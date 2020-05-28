Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECE1E69C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406019AbgE1Svo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405911AbgE1Svn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 14:51:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC7C08C5C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 11:51:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so34694915ljm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhLg0g9nIVFkh8Xej4e2gvlmNSMTD4F2E/T/7QsRMv8=;
        b=AYcUjneN2MB3Dg+M1pugzVZJdxa872FQyc0afbyKSWW1oWb/d1rwk9bn7+CzdK3mHa
         tArLlEWWcS0pmgUdgvh4UhxapiHNyCYitzgmuPpFaFrB1CcK1PCfLpwMLGY/rt9ZbGVr
         HuHNIUVtpMtoMJZ4AirU8Bfo1+H2VgFd0PSHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhLg0g9nIVFkh8Xej4e2gvlmNSMTD4F2E/T/7QsRMv8=;
        b=RlXsVW1sQ70spaobSepuFbZUaBq5rKJhp0ioJ2JfGj0Fz6cFyrGXMFnmmU84yIzHb2
         N6Q7yhmPgsnzakYuxG6gUBW37maLsr7C1K03TCetoP+rKYaMkRQrCvd5jBLH8K0RRZeE
         6rQhr/t4AHp3DW/9dwB4XK1pYW5igsm7iJQSkRueXV74BCFlfhMV9SKl+EwHhTyqU5FC
         QDQ9lP8G/WmJs4xtMvEnEg97Mm4C5cny828k/OjCbWT0GN1z4KPLjkTmrsZRiChGL3Ju
         rPwwLNM3kr6T3YybVyj4R33/YuVfKeJ9onhuZXwreEL7AdGl9ZSAvWTxLwXkoarqIeQS
         U6eQ==
X-Gm-Message-State: AOAM531c+bpCBxPuH6V89jnQEsu57ihPSakueQuwakav4WUEDIWt/yL/
        u90cu3AZqCfDwgagSN2zIDP4ix8FlLE=
X-Google-Smtp-Source: ABdhPJwBGvcTAWlKTc1X0iegz1+AkDn8/bKhific9TDik2rZNlX5RIcJ7l1TQEVfim18eu9SOV70Kg==
X-Received: by 2002:a2e:87da:: with SMTP id v26mr2102907ljj.14.1590691898925;
        Thu, 28 May 2020 11:51:38 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id o4sm1782352lff.78.2020.05.28.11.51.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:51:38 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id a25so23106086ljp.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 11:51:37 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr1927771ljg.421.1590691897249;
 Thu, 28 May 2020 11:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de>
In-Reply-To: <20200528054043.621510-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:51:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Message-ID: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 10:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> this series fixes a few issues and cleans up the helpers that read from
> or write to kernel space buffers, and ensures that we don't change the
> address limit if we are using the ->read_iter and ->write_iter methods
> that don't need the changed address limit.

Apart from the "please don't mix irrelevant whitespace changes with
other changes" comment, this looks fine to me.

And a rant related to that change: I'm really inclined to remove the
checkpatch check for 80 columns entirely, but it shouldn't have been
triggering for old lines even now.

Or maybe make it check for something more reasonable, like 100 characters.

I find it ironic and annoying how "checkpatch" warns about that silly
legacy limit, when checkpatch itself then on the very next few lines
has a line that is 124 columns wide

And yes, that 124 character line has a good reason for it. But that's
kind of the point. There are lots of perfectly fine reasons for longer
lines.

I'd much rather check for "no deep indentation" or "no unnecessarily
complex conditionals" or other issues that are more likely to be
_real_ problems.  But do we really have 80x25 terminals any more that
we'd care about?

               Linus
