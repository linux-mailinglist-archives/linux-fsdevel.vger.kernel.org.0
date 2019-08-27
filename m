Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C769EB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfH0Ott (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 10:49:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47698 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0Ott (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:49:49 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B56AB54B;
        Tue, 27 Aug 2019 16:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1566917385;
        bh=rFgk1pvrfx+jQ2e3NBtVhCM4d/9bcGbvNX4VHdT/37A=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b0CrUdkQCO3ydWxNsBAIld1kS9jj/8HHn3ZMvhsloLGvd7NF5IyZdM+7F4PkR7SAX
         +I8p4fn1s6F5g3TrdwVcYGalaeCDqannrp7RmKkMGTnP66I8v+Mxvel67Sg3zl/cmD
         J3qEFiRxU3DCUf1tpxl+uTs9PDTrQtKS1FgTaZMc=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 5/7] bcm-vk: add bcm_vk UAPI
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-6-scott.branden@broadcom.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
Organization: Ideas on Board
Message-ID: <61c3e8a2-b230-844e-466c-ba45b42542a1@ideasonboard.com>
Date:   Tue, 27 Aug 2019 15:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822192451.5983-6-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Scott,

On 22/08/2019 20:24, Scott Branden wrote:
> Add user space api for bcm-vk driver.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  include/uapi/linux/misc/bcm_vk.h | 88 ++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> 
> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> new file mode 100644
> index 000000000000..df7dfd7f0702
> --- /dev/null
> +++ b/include/uapi/linux/misc/bcm_vk.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> +/*
> + * Copyright(c) 2018 Broadcom
> + */
> +
> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> +#define __UAPI_LINUX_MISC_BCM_VK_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +struct vk_metadata {
> +	/* struct version, always backwards compatible */
> +	__u32 version;
> +
> +	/* Version 0 fields */
> +	__u32 card_status;
> +#define VK_CARD_STATUS_FASTBOOT_READY BIT(0)
> +#define VK_CARD_STATUS_FWLOADER_READY BIT(1)
> +
> +	__u32 firmware_version;
> +	__u32 fw_status;
> +	/* End version 0 fields */
> +
> +	__u64 reserved[14];
> +	/* Total of 16*u64 for all versions */
> +};
> +
> +struct vk_image {
> +	__u32 type;     /* Type of image */
> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> +	char filename[64]; /* Filename of image */
> +};
> +
> +/* default firmware images names */
> +#define VK_BOOT1_DEF_FILENAME	    "vk-boot1.bin"
> +#define VK_BOOT2_DEF_FILENAME	    "vk-boot2.bin"
> +
> +struct vk_access {
> +	__u8 barno;     /* BAR number to use */
> +	__u8 type;      /* Type of access */
> +#define VK_ACCESS_READ 0
> +#define VK_ACCESS_WRITE 1
> +	__u32 len;      /* length of data */
> +	__u64 offset;   /* offset in BAR */
> +	__u32 *data;    /* where to read/write data to */
> +};
> +
> +struct vk_reset {
> +	__u32 arg1;
> +	__u32 arg2;
> +};
> +
> +#define VK_MAGIC              0x5E
> +
> +/* Get metadata from Valkyrie (firmware version, card status, etc) */
> +#define VK_IOCTL_GET_METADATA _IOR(VK_MAGIC, 0x1, struct vk_metadata)
> +
> +/* Load image to Valkyrie */
> +#define VK_IOCTL_LOAD_IMAGE   _IOW(VK_MAGIC, 0x2, struct vk_image)
> +
> +/* Read data from Valkyrie */
> +#define VK_IOCTL_ACCESS_BAR   _IOWR(VK_MAGIC, 0x3, struct vk_access)
> +
> +/* Send Reset to Valkyrie */
> +#define VK_IOCTL_RESET        _IOW(VK_MAGIC, 0x4, struct vk_reset)

It sounds a bit like the valkyrie is a generic asynchronous coprocessor,
does it merit using the remoteproc interfaces to control it ?

Or is it really just a single purpose cell doing video operations ?

--
Kieran

> +
> +/*
> + * message block - basic unit in the message where a message's size is always
> + *		   N x sizeof(basic_block)
> + */
> +struct vk_msg_blk {
> +	__u8 function_id;
> +#define VK_FID_TRANS_BUF 5
> +#define VK_FID_SHUTDOWN  8
> +	__u8 size;
> +	__u16 queue_id:4;
> +	__u16 msg_id:12;
> +	__u32 context_id;
> +	__u32 args[2];
> +#define VK_CMD_PLANES_MASK 0x000F /* number of planes to up/download */
> +#define VK_CMD_UPLOAD      0x0400 /* memory transfer to vk */
> +#define VK_CMD_DOWNLOAD    0x0500 /* memory transfer from vk */
> +#define VK_CMD_MASK        0x0F00 /* command mask */
> +};
> +
> +#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
> 

-- 
Regards
--
Kieran
