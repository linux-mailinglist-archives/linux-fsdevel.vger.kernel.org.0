Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6F10A6BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 23:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKZWnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 17:43:50 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:35253 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKZWnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:43:50 -0500
Received: by mail-vk1-f171.google.com with SMTP id o187so872899vka.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NIKLkvM4xMfYGbffg8jQ0rMypbxQgK1rbaThbLEhpZw=;
        b=RGpoCWCkbrDlTMcqplO/MgmulD7nCGJ+EaMqI5rhYCHa2SnYnkLPyWj9xW18EE4r2a
         6V2NIImEar+30DoDZvFnPOVS+HOWqfXTrWFgVfSvOLyTRziwds4dOZk9DjPFGR/VIo/s
         V7umYNUI8oxymPv1NFBFoCIKmOdx8hg4zZm3SoFg0IFYXBAoLVqvoPa13rrfkRDmk+0S
         jwZlPrE+sQbEK8UzVsbqpWmVCpJq9f9gUcZQXBXuGEXRgknJro1y8leB5mksz4s0URhw
         MW/GJ2Hty11J07qFNmz2RuzrIkRyksvu237SpHOPywSS340rMO2CwuJoxwLoR15j5fAG
         ZR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NIKLkvM4xMfYGbffg8jQ0rMypbxQgK1rbaThbLEhpZw=;
        b=C8TmGHNl4g1w3UGdjMBWJuWEucO8sfDrRwMm1Njmq/UUwf8szqpJLuTEbikXVmMb/7
         5EXSwFN5bcobGzw10Y8zLF51oAdGHm/Fr6+HOZqJYPPA/6HVehmDwCS+tn1sFUAIp1gY
         64u0cuy8BwQIbCfneUPc9sOMZRpWAUwWv1wmGMjdamJ/hkPc2gZFWsCMUeESa8OdcWAE
         Qy/ERKwmBR91Gm5g2o1/FMsSyUABzEo30gm5FqqMO6xFR/VOoeNPo3zx3DVJR+S+dQAi
         jsZK0537gOEIGtUobEtHDIFnV1rHhw/92TxhFMaWqekhWtjjN51OeS7X8wMtizOoyO7R
         FuSg==
X-Gm-Message-State: APjAAAVv/a/vQ4VaHEY+8YzHxopGkL2GPkeVPxmnctkyLcoB6scCq5ym
        s19oM6Z2+jj1tgtNG5NM8f6aK++Vn6pitBhZwXx43Fr9
X-Google-Smtp-Source: APXvYqxFuF8WD8ZUtLYX+bHCboPaJWjra7Jy3M1ZriUHQzl4f0r1KrXCnJPu3Q268ekUr6Sm/gmu7FYZfjEkBwIfwA8=
X-Received: by 2002:a05:6122:305:: with SMTP id c5mr769977vko.42.1574808228332;
 Tue, 26 Nov 2019 14:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20191126185018.8283-1-hubcap@kernel.org> <CAHk-=wgbKoRHsbLGDBAA7c6frAtO7GVQt4nxx5kPsixCpTLCDg@mail.gmail.com>
 <CAOg9mSQ5hURb-e-hfg-q5_rgCfBC+wh7Z6mLUS_Tdu6iLquDhg@mail.gmail.com>
In-Reply-To: <CAOg9mSQ5hURb-e-hfg-q5_rgCfBC+wh7Z6mLUS_Tdu6iLquDhg@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 26 Nov 2019 17:43:37 -0500
Message-ID: <CAOg9mSRLCL5FbyPK6KqTWJtJfOuNUXoCHUV2SUoYzOh4N6rEVA@mail.gmail.com>
Subject: Fwd: [PATCH V3] orangefs: posix open permission checking...
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---------- Forwarded message ---------
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, Nov 26, 2019 at 4:02 PM
Subject: Re: [PATCH V3] orangefs: posix open permission checking...
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <hubcap@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>



>> I don't know what side effects that "new_op->upcall.uid = 0;" will
>> have on the server side

I believe that the 0 is only used for whatever filesystem operations
(usually one) are required to get this service_operation done.
I think it will only kick in during discrete IO operations
that we've already posixly promised to complete.

I still am looking for a kernel access()-like thing so
I can only use UID 0 when needed - I see your argument about
always doing it...

The orangefs people are interested in this, so they'll be looking
at this last iteration. Thanks for helping me to understand the
right way to look at it from the kernel's perspective.

-Mike

On Tue, Nov 26, 2019 at 2:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 26, 2019 at 10:50 AM <hubcap@kernel.org> wrote:
> >
> > Here's another version that is hopefully closer to
> > usable...
>
> This looks like it should work.
>
> I don't know what side effects that "new_op->upcall.uid = 0;" will
> have on the server side, and it still looks a bit hacky to me, but at
> least it doesn't have the obvious problems on the client side.
>
> Arguably, if you trust the client, you might as well just *always* do
> that upcall.uid clearing.
>
> And if you don't trust the client, then you'd have to do some NFS-like
> root squash anyway, at which point the uid clearing will actually
> remove permissions and break this situation again.
>
> So I do think this shows a deeper issue still, but at least it is an
> understandable workaround for a non-posix filesystem.
>
>                Linus
