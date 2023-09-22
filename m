Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457AA7AB266
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjIVMqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIVMqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:46:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55C38F
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 05:45:54 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-45269fe9d6bso1040062137.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695386754; x=1695991554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iysbjF9DWSU3lQpDFHGASU4BCbt0LBgnC6a6oaBwv+c=;
        b=a0r76q4dvQGUueWuvtIk3JAlB5wlsUQwQ+oJ0AbsbdwsMvpVck4s5VQh2Y5zMoXqnk
         ZCW3kCR7jQpj7MDVfbF1Wt1LzSpip31h66PC4xlFMVXX0fTheWzcOSP4mROjTpFk06CE
         1SXWngSqaxaBTVJ02xXFIwxHu9C12CKsyLsUTnzkHoM1hzl7sBWLUCZ9SoMUTF3ppgAY
         58wxl3GawswBdmSm5xWju0xzJeoW5vx0LJCGPQJHg9lHrfoDJdkpQeZ6jFU3PmVzt9Gj
         htXtHfyIQjauXC9e3L/NNz+o1hc6wH12Er/bWBa86ZC28qL8Gz5AI7fQsIjhFm2CeAOt
         pF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386754; x=1695991554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iysbjF9DWSU3lQpDFHGASU4BCbt0LBgnC6a6oaBwv+c=;
        b=bEEKSs9iLoQSxoZLuIHaHraTlPE9x8bB8Fiy9vXHj1lyz0rexjUKMRDY8uEjU6xw+7
         h/cwK3Mi5u2WYYIH+f61PAqpA4KOdBhCfhGbKPMWLx8d3QfgwNuZRWGNN5aXLWIEEQnF
         NvkNnhhvgSEkyNCM6S9ChE4ZPDtiFS9Fnyg9LymCBqAIK56H+3F2LWJTlca6eMm0QVuk
         xHaGjWXyPTYxPE+5Jk47vwKVSlJl85WdTIaE+EGRf6AGyOtYc/YiyTOnLEOwGqLWkj8v
         SNx5UgZ54q/qs4aUYBF5xV+JLIx3O22y3ol6wlJBcX7XURBNuWbWU48fjUyqqgACHJLI
         od1A==
X-Gm-Message-State: AOJu0YzwtUsz3LZhjplB3O2rqTetEB/gksG1GT3G6h6KGksXKyXvVnlI
        YyIHWBapKvThQD1cx692CsU21OijS4wXjWCnuF8=
X-Google-Smtp-Source: AGHT+IF8XMHDMtCxh8E7yh0wbqloPO7VeNFpT/GGoewOSNgcDGhSswycACDO1JbKc+aw1Nu/DiI2cL4G+wxXiGzucKM=
X-Received: by 2002:a67:eb59:0:b0:447:6bdc:654c with SMTP id
 x25-20020a67eb59000000b004476bdc654cmr8838450vso.31.1695386753980; Fri, 22
 Sep 2023 05:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com> <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
In-Reply-To: <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Sep 2023 15:45:43 +0300
Message-ID: <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 2:50=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 21 Sept 2023 at 12:31, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Ok. Two follow up design questions.
> >
> > I used this in/out struct for both open/close ioctls,
> > because I needed the flags for different modes:
> >
> > struct fuse_backing_map {
> >        int32_t         fd;
> >        uint32_t        flags;
> >        uint32_t        backing_id;
> >        uint32_t        padding;
> > };
> >
> > I prefer to leave it like that (with flags=3D0) for future extensions
> > over the ioctl that inputs fd and outputs backing_id.
> > I hope you are ok with this.
>
> I'd prefer if backing_id was just a return value for open.  Taking a
> struct as input is okay, and possibly it should have some amount of
> reserved space for future extensions.
>
> As for close, I don't see why we'd need anything else than the backing ID=
...
>

OK. dropped the inode bound mode, updated the example
to do server managed backing id for the rdonly shared fds.

Pushed this to the fuse-backing-id branches:

[1] https://github.com/amir73il/linux/commits/fuse-backing-fd
[2] https://github.com/amir73il/libfuse/commits/fuse-backing-fd

> >
> > The second thing is mmap passthrough.
> >
> > I noticed that the current mmap passthough patch
> > uses the backing file as is, which is fine for io and does
> > pass the tests, but the path of that file is not a "fake path".
> >
> > So either FUSE mmap passthrough needs to allocate
> > a backing file with "fake path"
>
> Drat.
>
> > OR if it is not important, than maybe it is not important for
> > overlayfs either?
>
> We took great pains to make sure that /proc/self/maps, etc display the
> correct overlayfs path.  I don't see why FUSE should be different.
>

Now I will go have a think about how to ease the pain
in this area for vfs. I have some ideas...

Thanks,
Amir.
