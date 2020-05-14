Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E951D33B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgENO4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgENO4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:56:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EAC061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 07:55:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x20so2995335ejb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mt4USsrPeAyCCKAdxZFCQYz+CwMakof0aOvagpM9z+o=;
        b=XHwGX1XaSQ5wh/Z0em+1CXAOr527IjSrMavRLreC9IKJriA2B6xXD8gqz25mPJUHFC
         QAekMp61OGmcVMUyzmOrwbEsdtlEwSwj7hNYZ657UnPEqh59cEwfoI2r/3X5fEBIgQgP
         QMqdcZQlL8Eo9hQbiiGcghcb36HxfG8505ZeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mt4USsrPeAyCCKAdxZFCQYz+CwMakof0aOvagpM9z+o=;
        b=fPVYg2PkGZIKIOMSdDuPDYTCYMZ2t0eM5IiBF43nFyszRFMFEKRKIz7cXY6Od/7FpR
         z8QM5azyKWU/3Xay9o97p+kAO2GFk56GTD2k4gQN3MJ7szCE3QCvaMeBgndahb1XjufW
         2DhL48I5DCnrT50D7BaejtacixY/H+snt3kEIYdGrivsp3ZBLgItMnXBMXiIcV3xuvMr
         M2Y4gZMptTMKvTUBLsWrUaJcwh+UyMquCT5h0FiiBzZ0WIutl7v8kih+2ybwZ7ATdnAL
         T9htaH3RpV0q9it9n5+WQ8H08rZlSHZVsVycwHU/YDv/k0H1b5u+TNwVM6dT+YtvT8rq
         iW3A==
X-Gm-Message-State: AOAM531dfgXF71ZWSa1dr/xk4U9VoeaBCh3WOpbaywaTYsjNBVkV37tQ
        IU0rO/LhzCgBBcrnfMGoZb2I2WsXYUxY1GsLpSrfMg==
X-Google-Smtp-Source: ABdhPJznld4Pwu9shBGKG9gqs0n2GjIcLnB9EImyMfp76wPV4nSsASgZ3dFfmQOKS2J7iVj4tmOCK6I+6vAkN47+2YQ=
X-Received: by 2002:a17:906:29d9:: with SMTP id y25mr4121892eje.198.1589468158535;
 Thu, 14 May 2020 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095915.11275-1-mszeredi@redhat.com> <CAJfpegtNQ8mYRBdRVLgmY8eVwFFdtvOEzWERegtXbLi9T2Ytqw@mail.gmail.com>
 <20200513194850.GY23230@ZenIV.linux.org.uk>
In-Reply-To: <20200513194850.GY23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 May 2020 16:55:46 +0200
Message-ID: <CAJfpegvouhYeok=VsUM77biQe_X4yD8873_K7j3Vjqf2ri02QA@mail.gmail.com>
Subject: Re: [PATCH 00/12] vfs patch queue
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 9:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, May 13, 2020 at 09:47:07AM +0200, Miklos Szeredi wrote:
> > On Tue, May 5, 2020 at 11:59 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > Hi Al,
> > >
> > > Can you please apply the following patches?
> >
> > Ping?  Could you please have a look at these patches?
> >
> > - /proc/mounts cursor is almost half the total lines changed, and that
> > one was already pretty damn well reviewed by you
> >
> > - unprivileged whiteout one was approved by the security guys
> >
> > - aio fsync one is a real bug, please comment on whether the patch is
> > acceptable or should I work around it in fuse
> >
> > - STATX_MNT_ID extension is a no brainer, the other one may or may not
> > be useful, that's arguable...
> >
> > - the others are not important, but I think useful
> >
> > - and I missed one (faccess2); amending to patch series
>
> I can live with that, modulo couple of trivial nits.

Nits from you and Christoph fixed, Reviewed-by: tags added, and force pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#for-viro

As I've said, I'm not sure what are the constraints for spinlock
holding.  We could easily switch to a mutex and that would solve the
inability to schedule, but would it make a real difference to the
damage a malicious user can do?

Thanks,
Miklos
