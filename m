Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A7231A238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhBLQAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 11:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBLQAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:00:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E08C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 07:59:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jj19so11538ejc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=golang-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQtB9DQQCYhoE2PX3zsTi2OoG8c7N9zifSGdBLGMpRU=;
        b=P7JvmqoKUlPwbYY/W3Md5u/d01RJCmNBOeYtTfXs92AEtiC9YivrE84PxDu0n+N02L
         gesWb+j292sMEUyr5ctTX5IGac4iVjlcVnN1ahRKq+VLmA8ErVq0ZCc2X3iuuM8+PUl+
         kI9fmuOff8qeVPLhxpbERC4MS93gj6B14V9PPWVDb2mURmuVn/88ZJwtBY9JSumVykwp
         DfkJVPgDssLVgvQ1HWTx2+QB29osXG+n0k1GvvSr2NAOUgDCWuTTObGzMsAuDWzKs5Bs
         xFEZIHl1U8MALR5uadD1YE5rAHF1RwOin0ANNZg5VWf/iL5ORbrUXH5akj1tuMWcDwbP
         rMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQtB9DQQCYhoE2PX3zsTi2OoG8c7N9zifSGdBLGMpRU=;
        b=nyS0t3FBju9YgqqHz7RH5i6e63D2r6MDcmBDdqQ/gkub2oiOJ90MQptn3PWL04MRV2
         gD3DUy83gohJNXfB88QQb549Q4GfK0qsUjqqsM9udikAmVYA9nxMW1asxXyFbir9yWyL
         EuZmPVINoCtmW+XDIMiLvZJ6DsL3pMz9HL3xzt73KzV2nb+ydahTIplxKnZBcQZt9zJG
         obwF+2pojZDmV6ley2ZtCyogwaIv43St4zsiQeCM4prwLLNmZpx41n0/iCFpZlvnHbTY
         KCr6yHMbv+WFjRkPmVD5oWtJuRPapmNCXJY5Y+CPJZLDJV8DCCWp317wnznw40der4KS
         rJwA==
X-Gm-Message-State: AOAM530Es9Q4d0xC7E0EJm/5j4sh4f5MftW/pwUpMCfpUA2WYiD9iEi5
        XSdhCRl9gfybnoq2yEtCMW/cfww4bfESXBayZA/lDw==
X-Google-Smtp-Source: ABdhPJxkERY/oPSU3XzhUsb2aRy7fBSqogheSCk2JXtUPt7fSrF/htK7vOhSmdS90JsKYB559clwRp7ujO8ykCKC/D8=
X-Received: by 2002:a17:906:8555:: with SMTP id h21mr3585156ejy.403.1613145555571;
 Fri, 12 Feb 2021 07:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com> <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com>
In-Reply-To: <YCaipZ+iY65iSrui@kroah.com>
From:   Ian Lance Taylor <iant@golang.org>
Date:   Fri, 12 Feb 2021 07:59:04 -0800
Message-ID: <CAOyqgcVTYhozM-mwc400qt+fabmUuBQTsjqbcA03xDooYXXcMA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 7:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > files in the first place?  They can not seek (well most can not), so
> > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > problem that userspace should not do.
> >
> > This may have been covered elsewhere, but it's not that people are
> > saying "let's use copy_file_range on files in /proc."  It's that the
> > Go language standard library provides an interface to operating system
> > files.  When Go code uses the standard library function io.Copy to
> > copy the contents of one open file to another open file, then on Linux
> > kernels 5.3 and greater the Go standard library will use the
> > copy_file_range system call.  That seems to be exactly what
> > copy_file_range is intended for.  Unfortunately it appears that when
> > people writing Go code open a file in /proc and use io.Copy the
> > contents to another open file, copy_file_range does nothing and
> > reports success.  There isn't anything on the copy_file_range man page
> > explaining this limitation, and there isn't any documented way to know
> > that the Go standard library should not use copy_file_range on certain
> > files.
>
> But, is this a bug in the kernel in that the syscall being made is not
> working properly, or a bug in that Go decided to do this for all types
> of files not knowing that some types of files can not handle this?
>
> If the kernel has always worked this way, I would say that Go is doing
> the wrong thing here.  If the kernel used to work properly, and then
> changed, then it's a regression on the kernel side.
>
> So which is it?

I don't work on the kernel, so I can't tell you which it is.  You will
have to decide.

From my perspective, as a kernel user rather than a kernel developer,
a system call that silently fails for certain files and that provides
no way to determine either 1) ahead of time that the system call will
fail, or 2) after the call that the system call did fail, is a useless
system call.  I can never use that system call, because I don't know
whether or not it will work.  So as a kernel user I would say that you
should fix the system call to report failure, or document some way to
know whether the system call will fail, or you should remove the
system call.  But I'm not a kernel developer, I don't have all the
information, and it's obviously your call.

I'll note that to the best of my knowledge this failure started
happening with the 5.3 kernel, as before 5.3 the problematic calls
would report a failure (EXDEV).  Since 5.3 isn't all that old I
personally wouldn't say that the kernel "has always worked this way."
But I may be mistaken about this.


> > So ideally the kernel will report EOPNOTSUPP or EINVAL when using
> > copy_file_range on a file in /proc or some other file system that
> > fails (and, minor side note, the copy_file_range man page should
> > document that it can return EOPNOTSUPP or EINVAL in some cases, which
> > does already happen on at least some kernel versions using at least
> > some file systems).
>
> Documentation is good, but what the kernel does is the true "definition"
> of what is going right or wrong here.

Sure.  The documentation comment was just a side note.  I hope that we
can all agree that accurate man pages are better than inaccurate ones.

Ian
