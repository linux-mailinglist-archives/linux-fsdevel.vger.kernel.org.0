Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0108F327E41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhCAM1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 07:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhCAM1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:27:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E28C06178B
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 04:26:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m1so14295716wml.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KD4LJEezSXanY/+fxbjEzv3Osh9WD8nOyZFOgjBB36g=;
        b=CZxnxPb0K7GR6Qvt6NmYIQPiHxDX8dy8RkmKGIsYbrfrN4XPehp1iWIkNTYS7mVowK
         QDrM4D4Szb5W8I+1q8i6iI9DxbdpG1qXMzE5HJYTH/NssW/3qdADiDKsrBP1SKkUTmB1
         g16xudG8XLlbJQ0EfEiDot43bw2aNPTV0sE57jZyG/lSyEIu65LMtUCPhA8TjjKxFGD+
         5rrZn7lz/0BsyoNl8tS0TSFDbSh4l1ZvpRmFw0XwxTdHDWbLgleGzLbPZAjBoUMCQ1jI
         RN6PEQvC6fc470XRrvAHDJDPueFYFRwgdMi99o6+B2mClkvg/d2SBJrJbVeBsO6GI/fx
         n/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KD4LJEezSXanY/+fxbjEzv3Osh9WD8nOyZFOgjBB36g=;
        b=jdBTfTpEUd6IPa2kOZoS7qgYOObP6D/pYL3l4qEjHfLvkNj7kqS+ZwL+sRm/B/7je/
         nX376yQdUuDTdMPI1355SOPT8Bx/xX/PTUwBMxJDk2+U83cUP7G76jek+j0mesKiMmMo
         7QuiBR7TYkMavW0R4UBqUc4e7HWCOgQtydqK39r/XI85ZZjzgsoVyWOKRX6HXaO1Cvv8
         i+K5U1Y6ZTFfE8nhu24MnoZoXPs+eEHo25A4t8SFPtEeADCTgWRGkQla9JaOEqt+9JEA
         nUWLWD9JrAw7BRbMZdkXkjJAogcg7iw0KEcL1HUVEYsmkGKg55LDWBqkaEINFQGGYrFP
         UGrg==
X-Gm-Message-State: AOAM530xWoXyNpTiwKAXa+Owv6dF45rB4tIjyBXQ9VOZmwnT+te9O5cf
        OuJzjNyezdzaui9IRcuz58Vh9w==
X-Google-Smtp-Source: ABdhPJz8OhS4Q1P+hcYUzb4xUlgBO73g43l7Pd9vB1016kMqXRu1eWhWzuo+f525VTvWifU9/715fQ==
X-Received: by 2002:a05:600c:21c9:: with SMTP id x9mr10711107wmj.135.1614601588566;
        Mon, 01 Mar 2021 04:26:28 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:3854:8f6d:e288:2080])
        by smtp.gmail.com with ESMTPSA id r18sm25578444wro.7.2021.03.01.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:26:28 -0800 (PST)
Date:   Mon, 1 Mar 2021 12:26:26 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
Message-ID: <YDzdcnS1JJWboFYN@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-3-balsini@android.com>
 <CAJfpegviqcgtE4qRHZFy6xdL6Re7gs30TV1epkn7cvUu3A4hqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegviqcgtE4qRHZFy6xdL6Re7gs30TV1epkn7cvUu3A4hqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:21:04AM +0100, Miklos Szeredi wrote:
> On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > With a 64-bit kernel build the FUSE device cannot handle ioctl requests
> > coming from 32-bit user space.
> > This is due to the ioctl command translation that generates different
> > command identifiers that thus cannot be used for direct comparisons
> > without proper manipulation.
> >
> > Explicitly extract type and number from the ioctl command to enable
> > 32-bit user space compatibility on 64-bit kernel builds.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> >  fs/fuse/dev.c             | 29 ++++++++++++++++++-----------
> >  include/uapi/linux/fuse.h |  3 ++-
> >  2 files changed, 20 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 588f8d1240aa..ff9f3b83f879 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2233,37 +2233,44 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
> >  static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
> >                            unsigned long arg)
> >  {
> > -       int err = -ENOTTY;
> > +       int res;
> > +       int oldfd;
> > +       struct fuse_dev *fud = NULL;
> >
> > -       if (cmd == FUSE_DEV_IOC_CLONE) {
> > -               int oldfd;
> > +       if (_IOC_TYPE(cmd) != FUSE_DEV_IOC_MAGIC)
> > +               return -EINVAL;
> 
> Why change ENOTTY to EINVAL?
> 
> Thanks,
> MIklos

For the magic number mismatch I was thinking that EINVAL would have been
more appropriate, meaning: "this ioctl is definitely something this file
doesn't support".  ENOTTY, could be more specific to the subset of
ioctls supported by the file, so I kept this in the default case of the
switch.
After counting the use of ENOTTY vs EINVAL for these _IOC_TYPE checks,
EINVALs were less than half ENOTTYs, so I'm totally fine with switching
back to ENOTTY in V13.

Thanks!
Alessio
