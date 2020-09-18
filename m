Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884432703A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRSCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRSCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:02:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF4C0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 11:02:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so7077996lff.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4u0r95LmCJnTjwZ9OJy/4Is6hNAIz+ZuFhN256qhuA=;
        b=V/Ln5v6NmQsxO19cvJilY5Ckb9d1npYsdQxKCI/FvgJs0xLjUInHIHplkpEA0VKs9K
         LZXElWnzr40IrOwle70lIlgXsafAmg7LbLzk9AdmNawGikKXL9nv0eG3GYuxDDePN2hr
         mWO6y/93zwypa7uVPg/OBeukWdfujdTgnVtrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4u0r95LmCJnTjwZ9OJy/4Is6hNAIz+ZuFhN256qhuA=;
        b=gXexliRH22Om3CPSAAfZGW6QON2s45o7awhW+35U5y9qhPybm7n06fCJ8yDq6CVrAA
         PT4rUZQBiO65t40lXwaeTEQnlDTzVQb39vEZXhj8QiA+W0ZzxzSpdVlx1e03TPY0MIqQ
         S9T9zDo6mvgc8e9qA5YFy5kvpM/CENLF9wUZDQiINnq6Ful8P192ZZb1a3FtOhIGmPW/
         Lly0+b/J7UHN5/97sTwCtlwP+FkBJvPm66HCibNaj07ZeYp8/sgSj0BnxjH1q6nnjNZr
         8BPoNcWeMdzCsedA+QQdwFW76nXAqgCOfqXBaoreu3EUWAOj9pAHRfVT35UHUoZF29II
         AUhQ==
X-Gm-Message-State: AOAM531SMRIMc/d0nMpj0lsJGeVSMxLQDnOfUoCTpagaTvYkaSboBsY4
        NFzyVyv3cbCrNMow9NH/z2f+P46KKvEztQ==
X-Google-Smtp-Source: ABdhPJwlSkqnbP2xsamBq+VgzjG3l6hSwul1TzEVLHDLD5iGWKg4/AGp0zBbWoIsFpleDqu7OQIdYQ==
X-Received: by 2002:ac2:59da:: with SMTP id x26mr12103972lfn.346.1600452159709;
        Fri, 18 Sep 2020 11:02:39 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q17sm736586lfn.145.2020.09.18.11.02.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 11:02:38 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w11so7095175lfn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 11:02:38 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr10344146lfp.534.1600452157810;
 Fri, 18 Sep 2020 11:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
 <alpine.LRH.2.02.2009180509370.19302@file01.intranet.prod.int.rdu2.redhat.com>
 <20200918131317.GH18920@quack2.suse.cz>
In-Reply-To: <20200918131317.GH18920@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 11:02:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZNopeE_FWGhNe0uBSf9d0jJ_t3bwD8R9cUzZLHt0BZA@mail.gmail.com>
Message-ID: <CAHk-=wjZNopeE_FWGhNe0uBSf9d0jJ_t3bwD8R9cUzZLHt0BZA@mail.gmail.com>
Subject: Re: the "read" syscall sees partial effects of the "write" syscall
To:     Jan Kara <jack@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 6:13 AM Jan Kara <jack@suse.cz> wrote:
>
> Yes, but no Linux filesystem (except for XFS AFAIK) follows the POSIX spec
> in this regard.

Yeah, and we never have. As you say, performance sucks, and nobody has
ever cared.

So the standard in this case is just something that we'll never
follow, and should just be ignored. It's irrelevant.

There are other places we don't follow POSIX either.

Feel free to document it (I think it's currently just a "everybody
knows" kind of undocumented thing).

             Linus
