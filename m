Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0C550A3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiFSLa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFSLay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:30:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB265F6
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 04:30:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e5so4408045wma.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=O2I45PoOglfUqWYYLgh36wUEI38mqN5c3WyJELiYVrQ=;
        b=CMDX7ziQVP/ELJCQ2uYixvE/VDY4gI0qJRyGZ6YhB69FGdgWsPUtuQ4ujKYUJOLfr3
         JecC5hxwQzEatbQfmcHzd4sjCyNFkj1eXcQa2IbP+NPsmH3iuu5a83ukp1hWLtrn+SDp
         8gvphAot6Kf3zSzGxxzeUfJ6pluXb1axlJWDmuKfXjXHgxmIa3Ne9GsgU811Ua2tYlrE
         OA1WN8N/jwauET/7+Xk91P+RwrybwSq+T3UMITLjpWa85tfQOfL/LK5uULCiFGPNytHq
         /qfUyy4cM4U38c3lRisTyxMFzdqTuYbve/Ij7FcakHP7u3lqBMOhVDG5RpW9uGnPMM9A
         3j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=O2I45PoOglfUqWYYLgh36wUEI38mqN5c3WyJELiYVrQ=;
        b=5QMSnI9KEANRsD3zzBj8yzlogOxsRsln6IjjYWSvPWFXBEpL+ueRqHdSbwQESJr2Tt
         J5ot8RLGwC9V/09ukw1ndpivpdV3dKcp1BXTARLJ0RQ1kBtyUksJmRroNvRFmGR8gv0G
         gfDt4NIewdf3pBECKHMZaV+Vp3yRjQlSRhmYYZb+HL5WPn1DOwuquFXKgjOi9j9p+KYR
         XB+IPPvMIS5fZmZxoH3hk5tyCRHam2mdow1p5+3amSZclRh2sXI6RkRAozDeBWVcTGy9
         qPCzqhO/VswJtHAOyvaUDrNNmOBM6x+3wGwa1gqRVyubRtbJquV4TC4wFVqXagsbUx6z
         dFIw==
X-Gm-Message-State: AJIora9CQOpZ4HYGKNhfDC+y7DPa9jI1r+jMa/QJtvCVLdHcLL3rPqyf
        ZPqpZXttGAaT5D23sIdrUL3/hA==
X-Google-Smtp-Source: AGRyM1sQr/+BlLCjFYp7YIL2rW66A6O7S/z7a9tjlAuS/44BkYWT2Uw8taLHxSnMG2oypjiTMj2wcg==
X-Received: by 2002:a05:600c:17cf:b0:39c:4b79:78c9 with SMTP id y15-20020a05600c17cf00b0039c4b7978c9mr19415525wmo.96.1655638251293;
        Sun, 19 Jun 2022 04:30:51 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id x1-20020adff0c1000000b002103cfd2fbasm10156755wro.65.2022.06.19.04.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 04:30:50 -0700 (PDT)
Message-ID: <6c06b2d4-2d96-c4a6-7aca-5147a91e7cf2@scylladb.com>
Date:   Sun, 19 Jun 2022 14:30:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
In-Reply-To: <20220616201506.124209-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 16/06/2022 23.14, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Traditionally, the conditions for when DIO (direct I/O) is supported
> were fairly simple.  For both block devices and regular files, DIO had
> to be aligned to the logical block size of the block device.
>
> However, due to filesystem features that have been added over time (e.g.
> multi-device support, data journalling, inline data, encryption, verity,
> compression, checkpoint disabling, log-structured mode), the conditions
> for when DIO is allowed on a regular file have gotten increasingly
> complex.  Whether a particular regular file supports DIO, and with what
> alignment, can depend on various file attributes and filesystem mount
> options, as well as which block device(s) the file's data is located on.
>
> Moreover, the general rule of DIO needing to be aligned to the block
> device's logical block size is being relaxed to allow user buffers (but
> not file offsets) aligned to the DMA alignment instead
> (https://lore.kernel.org/linux-block/20220610195830.3574005-1-kbusch@fb.com/T/#u).
>
> XFS has an ioctl XFS_IOC_DIOINFO that exposes DIO alignment information.
> Uplifting this to the VFS is one possibility.  However, as discussed
> (https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u),
> this ioctl is rarely used and not known to be used outside of
> XFS-specific code.  It was also never intended to indicate when a file
> doesn't support DIO at all, nor was it intended for block devices.
>
> Therefore, let's expose this information via statx().  Add the
> STATX_DIOALIGN flag and two new statx fields associated with it:
>
> * stx_dio_mem_align: the alignment (in bytes) required for user memory
>    buffers for DIO, or 0 if DIO is not supported on the file.
>
> * stx_dio_offset_align: the alignment (in bytes) required for file
>    offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
>    on the file.  This will only be nonzero if stx_dio_mem_align is
>    nonzero, and vice versa.


If you consider AIO, this is actually three alignments:

1. offset alignment for reads (sector size in XFS)

2. offset alignment for overwrites (sector size in XFS since 
ed1128c2d0c87e, block size earlier)

3. offset alignment for appending writes (block size)


This is critical for linux-aio since violation of these alignments will 
stall the io_submit system call. Perhaps io_uring handles it better by 
bouncing to a workqueue, but there is a significant performance and 
latency penalty for that.


Small appending writes are important for database commit logs (and so 
it's better to overwrite a pre-formatted file to avoid aligning to block 
size).


It would be good to expose these differences.


>
> Note that as with other statx() extensions, if STATX_DIOALIGN isn't set
> in the returned statx struct, then these new fields won't be filled in.
> This will happen if the file is neither a regular file nor a block
> device, or if the file is a regular file and the filesystem doesn't
> support STATX_DIOALIGN.  It might also happen if the caller didn't
> include STATX_DIOALIGN in the request mask, since statx() isn't required
> to return unrequested information.
>
> This commit only adds the VFS-level plumbing for STATX_DIOALIGN.  For
> regular files, individual filesystems will still need to add code to
> support it.  For block devices, a separate commit will wire it up too.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   fs/stat.c                 | 2 ++
>   include/linux/stat.h      | 2 ++
>   include/uapi/linux/stat.h | 4 +++-
>   3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/stat.c b/fs/stat.c
> index 9ced8860e0f35..a7930d7444830 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -611,6 +611,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>   	tmp.stx_dev_major = MAJOR(stat->dev);
>   	tmp.stx_dev_minor = MINOR(stat->dev);
>   	tmp.stx_mnt_id = stat->mnt_id;
> +	tmp.stx_dio_mem_align = stat->dio_mem_align;
> +	tmp.stx_dio_offset_align = stat->dio_offset_align;
>   
>   	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>   }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 7df06931f25d8..ff277ced50e9f 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -50,6 +50,8 @@ struct kstat {
>   	struct timespec64 btime;			/* File creation time */
>   	u64		blocks;
>   	u64		mnt_id;
> +	u32		dio_mem_align;
> +	u32		dio_offset_align;
>   };
>   
>   #endif
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 1500a0f58041a..7cab2c65d3d7f 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -124,7 +124,8 @@ struct statx {
>   	__u32	stx_dev_minor;
>   	/* 0x90 */
>   	__u64	stx_mnt_id;
> -	__u64	__spare2;
> +	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>   	/* 0xa0 */
>   	__u64	__spare3[12];	/* Spare space for future expansion */
>   	/* 0x100 */
> @@ -152,6 +153,7 @@ struct statx {
>   #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
>   #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
>   #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
> +#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
>   
>   #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>   
