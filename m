Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A30CFE46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJHP75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:59:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35073 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJHP75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:59:57 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so37690842iop.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2019 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBcYZS8wTLJ+jyCTUqfygduDl+keSPK2KmttGIFgonY=;
        b=M/ESIIsDxB9Ncm/b7SrUpQK2qVva33uQVjzi0rmMNZWq+KjIL4kQkdUI6PDLqU/YO0
         NizkAN6jpaDwaYsdMmnkZNXTiTw1jJ+zVkTDYA/lUqABHr4pIaFRqaMSCzBxtVbHR1VZ
         W5O61xR+bDEC4nuTDqOy/p8AXbBLd8hpsQv8gtlYA7SRZXmD5ks72VKXDo1PFN8cDKDc
         u1FSmMLttZ1FH2imVoFaRFZGhWVppi2xW4NChmzu3G/5rUR84dHQwCFid99lcEpRkHXZ
         32yB2Ijm9S2jk5yGsVvOUma6diTYFfZIsF4IzLIRtWRF67jK0JXedwEtHlt4eLm/N8rT
         mJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBcYZS8wTLJ+jyCTUqfygduDl+keSPK2KmttGIFgonY=;
        b=QajXez5Wk1ILyfPRXYDHosfkmH1I2cz0lVg816IFwFwQtfx4QaxwkcZfjQ1C3URIYV
         tfpi2Uto6jt10uXzJCayF5vPNfapV4CRHGk8mcT1wl7uKXje+CktlxRIedck7L275ixg
         PQPpiSbi5V9eWr8cA2g6QfTQtB4KpqfPJLSyzVNjF189JeKE+64KVxPA7fKDoFnJQc2y
         wiG1VFAD8VWW+EyU6aPezYyZ5tmLWScbxQSRkE4XyH7rmJb/78Ciy+7w4LuiHNxh46nv
         se6EKqFw8yRx35ynGjX5U98PpJfcu13JgvgJj+cHEfDUVAE4MAlN2Lc86o6ON9GDijvS
         RMiw==
X-Gm-Message-State: APjAAAXFZEufs6qp4+bcZMutlvMDEBv8Ir5swhs874ouY96aFV8dOtsM
        /et6g9fgO1uAA07L/caObs/FOyEoo5biQRgzzuLSSQ==
X-Google-Smtp-Source: APXvYqymrV9utqTVCvOUYGzIJ6y1+AXeNbE8gVyHhEeLwYRevHtWq7pSIXdwblnHIwynvlpahdExjkvZ4QC8O2T4/QY=
X-Received: by 2002:a6b:ca85:: with SMTP id a127mr29155336iog.278.1570550395547;
 Tue, 08 Oct 2019 08:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-6-scott.branden@broadcom.com> <61c3e8a2-b230-844e-466c-ba45b42542a1@ideasonboard.com>
In-Reply-To: <61c3e8a2-b230-844e-466c-ba45b42542a1@ideasonboard.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 8 Oct 2019 08:59:43 -0700
Message-ID: <CAOesGMg6f2pK4ZZ8bz=0nMgCJG-8JhLZe41prZoGsBhgGs6_jA@mail.gmail.com>
Subject: Re: [PATCH 5/7] bcm-vk: add bcm_vk UAPI
To:     kieran.bingham@ideasonboard.com
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 7:49 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Scott,
>
> On 22/08/2019 20:24, Scott Branden wrote:
> > Add user space api for bcm-vk driver.
> >
> > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > ---
> >  include/uapi/linux/misc/bcm_vk.h | 88 ++++++++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> >
> > diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> > new file mode 100644
> > index 000000000000..df7dfd7f0702
> > --- /dev/null
> > +++ b/include/uapi/linux/misc/bcm_vk.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> > +/*
> > + * Copyright(c) 2018 Broadcom
> > + */
> > +
> > +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> > +#define __UAPI_LINUX_MISC_BCM_VK_H
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +struct vk_metadata {
> > +     /* struct version, always backwards compatible */
> > +     __u32 version;
> > +
> > +     /* Version 0 fields */
> > +     __u32 card_status;
> > +#define VK_CARD_STATUS_FASTBOOT_READY BIT(0)
> > +#define VK_CARD_STATUS_FWLOADER_READY BIT(1)
> > +
> > +     __u32 firmware_version;
> > +     __u32 fw_status;
> > +     /* End version 0 fields */
> > +
> > +     __u64 reserved[14];
> > +     /* Total of 16*u64 for all versions */
> > +};
> > +
> > +struct vk_image {
> > +     __u32 type;     /* Type of image */
> > +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> > +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> > +     char filename[64]; /* Filename of image */
> > +};
> > +
> > +/* default firmware images names */
> > +#define VK_BOOT1_DEF_FILENAME            "vk-boot1.bin"
> > +#define VK_BOOT2_DEF_FILENAME            "vk-boot2.bin"
> > +
> > +struct vk_access {
> > +     __u8 barno;     /* BAR number to use */
> > +     __u8 type;      /* Type of access */
> > +#define VK_ACCESS_READ 0
> > +#define VK_ACCESS_WRITE 1
> > +     __u32 len;      /* length of data */
> > +     __u64 offset;   /* offset in BAR */
> > +     __u32 *data;    /* where to read/write data to */
> > +};
> > +
> > +struct vk_reset {
> > +     __u32 arg1;
> > +     __u32 arg2;
> > +};
> > +
> > +#define VK_MAGIC              0x5E
> > +
> > +/* Get metadata from Valkyrie (firmware version, card status, etc) */
> > +#define VK_IOCTL_GET_METADATA _IOR(VK_MAGIC, 0x1, struct vk_metadata)
> > +
> > +/* Load image to Valkyrie */
> > +#define VK_IOCTL_LOAD_IMAGE   _IOW(VK_MAGIC, 0x2, struct vk_image)
> > +
> > +/* Read data from Valkyrie */
> > +#define VK_IOCTL_ACCESS_BAR   _IOWR(VK_MAGIC, 0x3, struct vk_access)
> > +
> > +/* Send Reset to Valkyrie */
> > +#define VK_IOCTL_RESET        _IOW(VK_MAGIC, 0x4, struct vk_reset)
>
> It sounds a bit like the valkyrie is a generic asynchronous coprocessor,
> does it merit using the remoteproc interfaces to control it ?
>
> Or is it really just a single purpose cell doing video operations ?

Remoteproc brings some useful shared functionality, in particular
around loading and parsing firmware formats for platforms where the
remote processor uses system carved out memory to run, etc.

For something like a PCIe device, it *can* be used but it really
doesn't bring any immediate benefit, especially if there aren't
multiple in-kernel drivers that need to talk to the hardware in an
abstracted way.


-Olof



-Olof
