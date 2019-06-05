Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7366435C81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfFEMVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 08:21:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41970 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfFEMVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:21:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so19253421wrm.8;
        Wed, 05 Jun 2019 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eMX4q3DpHMhUsdsN4u88JHTPcA/fYwja5qc5UwXeOj0=;
        b=HkwwqWkbYHshnfYvDhmb8NlPq1PKXNE+NTRxvZwenZ5mdxm93abHvET1ts/6AqvNWM
         IfefGtgsPVhkwiYXcZgGowa3l3QfD+OKsqASzLS2+wUdHnALs6fu+BOB89zspYmQSBXA
         ktCUuQYXqnevp2qsxupbzl5wplKboxVDx5VwChJ09eueMX7GNlRFIeQNcX2DpnGBL4nN
         F/QmyXv+U0ci9q4txpJpnLdJ9gISMBrpAAvVxJVjbX8RWQClrvDeZEPs5VnvQZrc6rsJ
         FkuQDPfKNkTvAK0TXZRNc0xDGKJkhACetTPcFkPrPUuwDix+0WyWXACGaerBMJEk2+J1
         XLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eMX4q3DpHMhUsdsN4u88JHTPcA/fYwja5qc5UwXeOj0=;
        b=mgeLlCdWikl5GFWXnkbvo59T8tx6JhPSSLzJhWfmmpx2ttlJSl4O3Koey3nSCRp1JE
         AfPL0Mzeh4r7vu2px9BDcK+cV+hCf8BhDHFehN/0HIunLKUbOmip7BZ4SXDjGlapUsKQ
         KqWeD3t3noYFgY8MoS9cV4dKueQo/QqpWfcU0lrWP+4TaTQkgsZ/sv8ZlYuZNHvnLLVV
         IDqkCGs7f4gR1Py/SA4bqSa05CzwjNxL0iD8kK2tyhCdjw40GeL6BLHBjqElxibQEaEJ
         POm4741AA2Km6BvR0SyrCmY9iZvZIOK3PxuF+4Is5cq3AVtKV3+fEw0EoIxE8yCEdx6E
         XhVg==
X-Gm-Message-State: APjAAAVYOkOeHyLIP3CCJF+a2ol+05/OtiHrEyuNo+WISHUNj/Fm5zmN
        cCHSNOphyXD2NDt08Ru3lqA=
X-Google-Smtp-Source: APXvYqyPHvWdNV9UYQ5tB9zJObQjRgwr7QJNszooXaFDn9ZgdymeSnKyWkZI932VnvkKp8F3fqHtFg==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr9456223wru.87.1559737303220;
        Wed, 05 Jun 2019 05:21:43 -0700 (PDT)
Received: from [172.16.8.139] (host-78-151-217-120.as13285.net. [78.151.217.120])
        by smtp.gmail.com with ESMTPSA id v67sm4961931wme.24.2019.06.05.05.21.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:21:42 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 09/25] vfs: Allow mount information to be queried by
 fsinfo() [ver #13]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905633578.1662.8087594848892366318.stgit@warthog.procyon.org.uk>
Message-ID: <60136f9f-8eb6-a7f4-11c6-daf988274420@gmail.com>
Date:   Wed, 5 Jun 2019 13:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155905633578.1662.8087594848892366318.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/05/2019 16:12, David Howells wrote:
> Allow mount information, including information about the topology tree to
> be queried with the fsinfo() system call.  Usage of AT_FSINFO_MOUNTID_PATH
> allows overlapping mounts to be queried.
>
> To this end, four fsinfo() attributes are provided:
>
>   (1) FSINFO_ATTR_MOUNT_INFO.
>
>       This is a structure providing information about a mount, including:
>
> 	- Mounted superblock ID.
> 	- Mount ID (as AT_FSINFO_MOUNTID_PATH).
> 	- Parent mount ID.
> 	- Mount attributes (eg. R/O, NOEXEC).
> 	- Number of change notifications generated.
>
>       Note that the parent mount ID is overridden to the ID of the queried
>       mount if the parent lies outside of the chroot or dfd tree.
>
>   (2) FSINFO_ATTR_MOUNT_DEVNAME.
>
>       This a string providing the device name associated with the mount.
>
>       Note that the device name may be a path that lies outside of the root.
>
>   (3) FSINFO_ATTR_MOUNT_CHILDREN.
>
>       This produces an array of structures, one for each child and capped
>       with one for the argument mount (checked after listing all the
>       children).  Each element contains the mount ID and the notification
>       counter of the respective mount object.
>
>   (4) FSINFO_ATTR_MOUNT_SUBMOUNT.
>
>       This is a 1D array of strings, indexed with struct fsinfo_params::Nth.
>       Each string is the relative pathname of the corresponding child
>       returned by FSINFO_ATTR_MOUNT_CHILD.

FSINFO_ATTR_MOUNT_CHILD -> FSINFO_ATTR_MOUNT_CHILDREN


>       Note that paths in the mount at the base of the tree (whether that be
>       dfd or chroot) are relative to the base of the tree, not the root
>       directory of that mount.
>
> Signed-off-by: David Howells<dhowells@redhat.com>
> ---
>
>   fs/d_path.c                 |    2
>   fs/fsinfo.c                 |    9 ++
>   fs/internal.h               |    9 ++
>   fs/namespace.c              |  175 +++++++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/fsinfo.h |   28 +++++++
>   samples/vfs/test-fsinfo.c   |   47 +++++++++++-
>   6 files changed, 266 insertions(+), 4 deletions(-)

> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_MOUNT_INFO).
> + */
> +struct fsinfo_mount_info {
> +	__u64		f_sb_id;	/* Superblock ID */
> +	__u32		mnt_id;		/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
> +	__u32		parent_id;	/* Parent mount identifier */
> +	__u32		group_id;	/* Mount group ID */
> +	__u32		master_id;	/* Slave master group ID */
> +	__u32		from_id;	/* Slave propogated from ID */

propogated -> propagated

> +	__u32		attr;		/* MOUNT_ATTR_* flags */
> +	__u32		notify_counter;	/* Number of notifications generated. */
> +	__u32		__reserved[1];
> +};
> +
> +/*
> + * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
> + * - An extra element is placed on the end representing the parent mount.
> + */
> +struct fsinfo_mount_child {
> +	__u32		mnt_id;		/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
> +	__u32		notify_counter;	/* Number of notifications generated on mount. */
> +};
> +
>   #endif /* _UAPI_LINUX_FSINFO_H */
