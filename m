Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB02540349
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbiFGQCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiFGQCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:02:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702262C10C
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 09:02:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v25so23628518eda.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkNsdE3B6C69qG7xj8QZJZKYTbkZOuyj1Q7mTmi6Dgc=;
        b=Z/Kh8Wh2nk+fd9Wk7zMUsNy3u2A1+k+peW4JYUIvcwhU56kfjQa4aZM/G+o+jAXFpO
         4z8lDsEwFBXRJBOhkTVcTzl6qWlzuO0yEKeKnd8z1aWwSd0cQ1SKGRJmxN6H5nc1i75K
         PwGb7QkspkiCB4E43I7emWiHXjLal25L7diUV8BPhBWHM2AWa/UQ+dCj+5TF5JrqAtQM
         LIbUjLa0q+m8BO7BFawZokeLzqgZbOHJ+8qhfqHSWbDt1ibejZlygPmxYsagvyfnxx/i
         SLboHlhJTnEWT9RJnfql4AY1RyqF1HibWdcPVi96zWrqlFzPwP/60EU9eQtkm9+DrGvH
         EHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkNsdE3B6C69qG7xj8QZJZKYTbkZOuyj1Q7mTmi6Dgc=;
        b=sxCxiJ44nWDLiesVFwRo1bvGBezpr09rkznSHUkBIrjQ9NEtZlxNGX8znlU3BhDjIa
         y7QfRfdbdKVTWtoTuo1jfboicjoO2PY3bQrcFtMF0850g8/9Fd2GxddUH+qhrwg899rd
         2olVGvGxqihhphNMpiVj0nWJJpPEQCwi6BpFGAPHStiiDTNx92NF++YLlE2szzGnhlih
         jA8dILBxsQvePhw/aHfj/H4ghW0ogDTGssDUvbRN9nml37y6pmvYeBRIpOp8Lty83brP
         tdPEqf41bTPx+XeaexjVCKjN2j9Oikh9CUYIcFR5xRf83fa/qcGwQGh2FibFskri+7OG
         hyRg==
X-Gm-Message-State: AOAM533ydOU4bG9TUIExS1cWwyLiSxHHgS/ttuYeJGqvxx9BFvLi3QQp
        axC14VGBOsQZgqXumFEnxiBI+gsZM4YOpAivhnPytA==
X-Google-Smtp-Source: ABdhPJxOul8yZmpxwHNojhicL57daDh/YnV4uK/ODTuY4C1op7IlnAgaeC7wcXe2TABjcPdtiW9zxPSwo4Ra0OocE5c=
X-Received: by 2002:a05:6402:34c2:b0:42f:79c0:334b with SMTP id
 w2-20020a05640234c200b0042f79c0334bmr25329803edc.88.1654617762674; Tue, 07
 Jun 2022 09:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-3-pasha.tatashin@soleen.com> <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
In-Reply-To: <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 7 Jun 2022 12:02:04 -0400
Message-ID: <CA+CK2bC5U5j1xkZKuOETANo1=PPpbJn2mKYOa2fK1GLFib0ibw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
To:     Baoquan He <bhe@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com,
        Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 5, 2022 at 10:56 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > In some case initrd can be large. For example, it could be a netboot
> > image loaded by u-root, that is kexec'ing into it.
> >
> > The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> > not very obvious because it is hidden behind a generic INT_MAX macro.
> >
> > Theoretically, we could make it LONG_MAX, but it is safer to keep it
> > sane, and just increase it to 4G.
>
> Do we need to care about 32bit system where initramfs could be larger
> than 2G? On 32bit system, SSIZE_MAX is still 2G, right?

Yes, on 32-bit SSIZE_MAX is still 2G, so we are safe to keep 32-bit
systems run exactly as today.

#define KEXEC_FILE_SIZE_MAX    min_t(s64, 4LL << 30, SSIZE_MAX)
Is meant to protect against running over the 2G limit on 32-bit systems.

>
> Another concern is if 2G is enough. If we can foresee it might need be
> enlarged again in a near future, LONG_MAX certainly is not a good
> value, but a little bigger multiple of 2G can be better?

This little series enables increasing the max value above 2G, but
still keeps it within a sane size i.e. 4G, If 4G seems too small, I
can change it to 8G or 16G instead of 4G.

Thanks,
Pasha

>
> >
> > Increase the size to 4G, and make it obvious by having a new macro
> > that specifies the maximum file size supported by kexec_file_load()
> > syscall: KEXEC_FILE_SIZE_MAX.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/kexec_file.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 8347fc158d2b..f00cf70d82b9 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -31,6 +31,9 @@
> >
> >  static int kexec_calculate_store_digests(struct kimage *image);
> >
> > +/* Maximum size in bytes for kernel/initrd files. */
> > +#define KEXEC_FILE_SIZE_MAX  min_t(s64, 4LL << 30, SSIZE_MAX)
> > +
> >  /*
> >   * Currently this is the only default function that is exported as some
> >   * architectures need it to do additional handlings.
> > @@ -223,11 +226,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >                            const char __user *cmdline_ptr,
> >                            unsigned long cmdline_len, unsigned flags)
> >  {
> > -     int ret;
> > +     ssize_t ret;
> >       void *ldata;
> >
> >       ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
> > -                                    INT_MAX, NULL, READING_KEXEC_IMAGE);
> > +                                    KEXEC_FILE_SIZE_MAX, NULL,
> > +                                    READING_KEXEC_IMAGE);
> >       if (ret < 0)
> >               return ret;
> >       image->kernel_buf_len = ret;
> > @@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >       /* It is possible that there no initramfs is being loaded */
> >       if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
> >               ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
> > -                                            INT_MAX, NULL,
> > +                                            KEXEC_FILE_SIZE_MAX, NULL,
> >                                              READING_KEXEC_INITRAMFS);
> >               if (ret < 0)
> >                       goto out;
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
>
