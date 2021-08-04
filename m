Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33F3DF8BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 02:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhHDAKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 20:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhHDAKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:10:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5DC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 17:10:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l17so600401ljn.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZroPpcFs5zl1u34pH41pVd3sjk7aZJY+DvQA0DPFYI=;
        b=CAeLh4KV0yVGHTEzyzBNcmMyjMClbLqxkGgftdacvLmb1YBxEp8QtWRe9x/ntinyRS
         XzTQ+xZ8BdFgo0T7APnudiiz0VpL87rUWhaK6bdaYd9tDO/+mPi8MmIHZW4N+4C2p35j
         dGtY6FBJt6YdqH+elWqxz1mgcr/jmScQCovTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZroPpcFs5zl1u34pH41pVd3sjk7aZJY+DvQA0DPFYI=;
        b=kg6Teeaz5nr9As4At5TznYiNLQEtXMk3eHXVtaj4LDK5iHAcD2aWuKgl8QSOv2c1ef
         fB++pvGzaAUW+geEIbHFIFaZjc5KMaft723b+MHMhaCyXbV0vWIYNFkCAtTzd3w9Lc4t
         4Oz1LiX25DoyWIKtJboiLwoa1y+XCFx0jnoyt9pFTFHyiTXl6ff+X+SPc+yHfMuSLUX3
         f57PvytP/EoqhNrSjlGFSIx5+oBES7W7KjvibKRp47xLAhUyK0sZHZfF+vP5OOa0a8QW
         v+y+1fQdavd6PP9mso9Fn14mYAW/sHGED703T0O3Ob/fDhhyaySfXi8q+EpbCITPKLXf
         Cazg==
X-Gm-Message-State: AOAM533GNhmlXteqA8WS6EzpctMdUj0yiHe+7eimDFcgT7nlWT+g3fyU
        lCSfneibWDRoB2WKoPyfQITGWS1dBGmNSrO/
X-Google-Smtp-Source: ABdhPJwj2hhZCK8q/55TASdiTn30XH2XJv4+hig1VPGz9CDebS6Li5TdNGEMychuMOuOhHHOEV52cQ==
X-Received: by 2002:a05:651c:2113:: with SMTP id a19mr16001347ljq.317.1628035839656;
        Tue, 03 Aug 2021 17:10:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id bi17sm31005lfb.138.2021.08.03.17.10.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 17:10:38 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y34so1406490lfa.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 17:10:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr17850839lfa.421.1628035838330;
 Tue, 03 Aug 2021 17:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com> <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu> <YQnU5m/ur+0D5MfJ@casper.infradead.org> <YQnZgq3gMKGI1Nig@mit.edu>
In-Reply-To: <YQnZgq3gMKGI1Nig@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Aug 2021 17:10:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
Message-ID: <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 5:04 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> TBH, I had forgotten that we had an in-kernel ntfs implementation.

Well, that's the one we are comparing to, so forgetting it is a bit of
an oversight.

> Whenver I've ever needed to access ntfs files, I've always used the
> ntfs-3g FUSE package.

The user-space FUSE thing does indeed work reasonably well.

It performs horribly badly if you care about things like that, though.

In fact, your own numbers kind of show that:

  ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
  ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds

and that's kind of the point of ntfs3.

           Linus
