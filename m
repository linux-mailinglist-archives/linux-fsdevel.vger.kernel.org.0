Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF51C3EAD82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhHLXNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHLXNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:13:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B8C061756;
        Thu, 12 Aug 2021 16:13:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa17so12499108pjb.1;
        Thu, 12 Aug 2021 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fujScTYjzTyStSgs8KoR09YxJvaDCJX/WMkpB/+pqs=;
        b=AnhJpFLfPpIN4dsHVdKbE3kC6btKJ91oIzU0Y/jh1EPlE8nKEB0QosPsvVXr5MFy+C
         Yy2K5BrP+C494X+hzxzEPyXKlEe2zHgUNUVjtQDG+Cou700GWE9c6z5J5Ahuv3M14jJj
         rWIPujJtyTysPpKRpuwBoR0KOSPc4Qp5RDS+O5/8PPL3afd7C6i3tUmMiJtyXrOXiXhe
         T+JEfSm82N4HuAnud6dbcHbgS56aYFuMZN+ru6Q6OsbLr92E/JZVZIn11zlaPeucw7w8
         dZIlZeY5TRmLFpkCz5I+LRrF9sSvSyal4E9q9cJbq2zXR//9uetqkMidYk6K9xaJk87Z
         WMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fujScTYjzTyStSgs8KoR09YxJvaDCJX/WMkpB/+pqs=;
        b=j0kfMtExdqpt1vX2nXftUY8c4znIeIzYY75OK8l81LVqFQUis+Es+0TMm/7WXP1Abc
         Sv33WG1FFRxLSCrbiMYz2T14bWJUYKzu9zDoSMRK7j3hvYNFIGB5DFZWDt8Y6YI5YDcp
         Drfr6vxYeDvfcCBo6Hdei8wswglOQNwMdBITYtGlDrm87qJNEa73fVUN1IFam3S/E45W
         4wWCBCL1r8sQ/J7JSRzfzLGvPIp2JA3Y2Uq34dIZBvnkonwktrEg6hNwxaTh/QCE565K
         WM98WRwHSFk8l8qnYGgVtoCYqSujc7AXAfzun1UzvddBKwVnKwU0aVR4Xf7RsPxYiZyD
         ExKw==
X-Gm-Message-State: AOAM532ATnMnRt/W6c+eyJ+iGK3dczyZWhxADBAfwgSBQQeQ+knUtboc
        URkYFW7x3I0RMjrt2/Ij1YI=
X-Google-Smtp-Source: ABdhPJxgKjVYaqMcqfVhvr+jTHEpCXTZV6IvZqIFOtrbKtGkFFeS/7EJh0ZnxRaQSGMBdhNmTzpjUA==
X-Received: by 2002:a62:820f:0:b029:3e0:30aa:5174 with SMTP id w15-20020a62820f0000b02903e030aa5174mr6475119pfd.4.1628810005173;
        Thu, 12 Aug 2021 16:13:25 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id y8sm4729260pfe.162.2021.08.12.16.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 16:13:24 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH man-pages] statx.2: Add STATX_MNT_ID
To:     NeilBrown <neilb@suse.de>
References: <162880868648.15074.7283929646453264436@noble.neil.brown.name>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cdb757b8-b3e5-b951-8c3d-44ac20f18558@gmail.com>
Date:   Fri, 13 Aug 2021 01:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162880868648.15074.7283929646453264436@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Neil,

On 8/13/21 12:46 AM, NeilBrown wrote:
> 
> Linux 5.8 adds STATX_MNT_ID and stx_mnt_id.
> Add description to statx.2
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks. Patch applied.

Cheers,

Michael

> ---
>  man2/statx.2 | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index 9e3aeaa36fa3..c41ee45f9bc4 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -77,6 +77,7 @@ struct statx {
>         containing the filesystem where the file resides */
>      __u32 stx_dev_major;   /* Major ID */
>      __u32 stx_dev_minor;   /* Minor ID */
> +    __u64 stx_mnt_id;      /* Mount ID */
>  };
>  .EE
>  .in
> @@ -258,6 +259,7 @@ STATX_SIZE	Want stx_size
>  STATX_BLOCKS	Want stx_blocks
>  STATX_BASIC_STATS	[All of the above]
>  STATX_BTIME	Want stx_btime
> +STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
>  STATX_ALL	[All currently available fields]
>  .TE
>  .in
> @@ -411,6 +413,13 @@ The device on which this file (inode) resides.
>  .IR stx_rdev_major " and "  stx_rdev_minor
>  The device that this file (inode) represents if the file is of block or
>  character device type.
> +.TP
> +.I stx_mnt_id
> +.\" commit fa2fcf4f1df1559a0a4ee0f46915b496cc2ebf60
> +The mount ID of the mount containing the file.  This is the same number reported by
> +.BR name_to_handle_at (2)
> +and corresponds to the number in the first field in one of the records in
> +.IR /proc/self/mountinfo .
>  .PP
>  For further information on the above fields, see
>  .BR inode (7).
> @@ -573,9 +582,11 @@ is Linux-specific.
>  .BR access (2),
>  .BR chmod (2),
>  .BR chown (2),
> +.BR name_to_handle_at (2),
>  .BR readlink (2),
>  .BR stat (2),
>  .BR utime (2),
> +.BR proc (5),
>  .BR capabilities (7),
>  .BR inode (7),
>  .BR symlink (7)
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
