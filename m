Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FD565F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZJxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 05:53:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46967 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZJxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:53:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so1916834wrw.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8pQpjdmJVhQvnmEuktN5/Xz1yU/XdyfuqdJKbPiBj1U=;
        b=cUbPSTd2QPE9FZLfMSLJLxMmumGg04s7XO/R8f+H5EeDpFBizlLoCUMVTp8IsqX58y
         PjIJSIZMBWNHiezN+AjDBmBjfAmUV1H1kM5gybcPayPWmxcPMAj/yHQVX/argLTD/Ntr
         RzOr0GP+v1K6/P4amPBPBJTawkg65GekP1qKF2wTmi2eEX8oUhZMUhMh1898QRf/8kJC
         ehfRtZOpxXK2thYiIWlrh36zePTorr8qJIatVloOPJAmQyFCwd96F+G4n8uNlFdoAmtl
         cj3vurXgaP6OxdcJK7+Nbu2mwk7GB/JZBA58kLZCemr7eL8pWcU09ePtNiIOmTccnatw
         idgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8pQpjdmJVhQvnmEuktN5/Xz1yU/XdyfuqdJKbPiBj1U=;
        b=KYUkWXFEYVUwh8Uw5Or68RoAJZMQMfMmrkRcJZT3sbF8LCDhAcq9EI9zjatSZiXvLT
         1XYfaZRKbs8poF3p+fXdpB/2D+eSwi6u/rcm2tpQH29kPjxSJWB1bzMHC7Md+7LoOHdb
         vHL4MIW8H4PkwoYj2LAr2rsrloti2zN33NmepO1kaoJ+sxwCv4BWPiRhDWgoI8r9n5c0
         jvb+nyrBhyv/y0TA3vfn6+pJreF8Ia6MlohC851xt1Z66lP+9EXGs4tg0rIqmnLcnFBO
         T6zzYpTP+JHJcPQcvAFCJVQ6ePVCsecKISx6SL9pcPRH9M1Hkb+qzydxktYXr8bBOYr7
         rf2g==
X-Gm-Message-State: APjAAAW83LVwEjNhDTNlcS9LztEI8QspotC71Yt3M4KpKioyo7hWjPbi
        4qLtQdrZ3+hPjUU9TKuHnpkmeg==
X-Google-Smtp-Source: APXvYqzENWhsUAdR+lHaBRja7sDCrNPJyr/EbZI0XX6h6F2zd94X4ldLgurF85/sE2NYe80opHkCuA==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr3130331wrw.26.1561542779770;
        Wed, 26 Jun 2019 02:52:59 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id w23sm1766190wmi.45.2019.06.26.02.52.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 02:52:59 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:52:58 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/25] vfs: Add mount notification count [ver #14]
Message-ID: <20190626095257.yi5k667gxulztyzz@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <156138540611.25627.13279299200070977180.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156138540611.25627.13279299200070977180.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:10:06PM +0100, David Howells wrote:
> Add a notification count on mount objects so that the user can easily check
> to see if a mount has changed its attributes or its children.
> 
> Future patches will:
> 
>  (1) Provide this value through fsinfo() attributes.
> 
>  (2) Hook into the notify_mount() function to provide a notification
>      interface for userspace to monitor.

Sorry, I might have missed this. Is this based on your notification
patchset and thus presupposing that your notification patchset has been
merged?

(One further question below.)

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/mount.h     |   22 ++++++++++++++++++++++
>  fs/namespace.c |   13 +++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 6250de544760..47795802f78e 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -70,6 +70,7 @@ struct mount {
>  	struct hlist_head mnt_pins;
>  	struct fs_pin mnt_umount;
>  	struct dentry *mnt_ex_mountpoint;
> +	atomic_t mnt_notify_counter;	/* Number of notifications generated */
>  } __randomize_layout;
>  
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
> @@ -151,3 +152,24 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
>  {
>  	return ns->seq == 0;
>  }
> +
> +/*
> + * Type of mount topology change notification.
> + */
> +enum mount_notification_subtype {
> +	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
> +	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
> +	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
> +	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
> +	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
> +	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
> +	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
> +};
> +
> +static inline void notify_mount(struct mount *changed,
> +				struct mount *aux,
> +				enum mount_notification_subtype subtype,
> +				u32 info_flags)
> +{
> +	atomic_inc(&changed->mnt_notify_counter);
> +}
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a49a7d9ed482..1450faab96b9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -513,6 +513,8 @@ static int mnt_make_readonly(struct mount *mnt)
>  	smp_wmb();
>  	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
>  	unlock_mount_hash();
> +	if (ret == 0)
> +		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0x10000);
>  	return ret;
>  }
>  
> @@ -521,6 +523,7 @@ static int __mnt_unmake_readonly(struct mount *mnt)
>  	lock_mount_hash();
>  	mnt->mnt.mnt_flags &= ~MNT_READONLY;
>  	unlock_mount_hash();
> +	notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0);
>  	return 0;
>  }
>  
> @@ -833,6 +836,7 @@ static void umount_mnt(struct mount *mnt)
>  {
>  	/* old mountpoint will be dropped when we can do that */
>  	mnt->mnt_ex_mountpoint = mnt->mnt_mountpoint;
> +	notify_mount(mnt->mnt_parent, mnt, NOTIFY_MOUNT_UNMOUNT, 0);
>  	unhash_mnt(mnt);
>  }
>  
> @@ -1472,6 +1476,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  		p = list_first_entry(&tmp_list, struct mount, mnt_list);
>  		list_del_init(&p->mnt_expire);
>  		list_del_init(&p->mnt_list);
> +
>  		ns = p->mnt_ns;
>  		if (ns) {
>  			ns->mounts--;
> @@ -2095,7 +2100,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  		lock_mount_hash();
>  	}
>  	if (parent_path) {
> +		notify_mount(source_mnt->mnt_parent, source_mnt,
> +			     NOTIFY_MOUNT_MOVE_FROM, 0);
>  		detach_mnt(source_mnt, parent_path);
> +		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_MOVE_TO, 0);
>  		attach_mnt(source_mnt, dest_mnt, dest_mp);
>  		touch_mnt_namespace(source_mnt->mnt_ns);
>  	} else {
> @@ -2104,6 +2112,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  			list_del_init(&source_mnt->mnt_ns->list);
>  		}
>  		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
> +		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT,
> +			     source_mnt->mnt.mnt_sb->s_flags & SB_SUBMOUNT ?
> +			     0x10000 : 0);

What's that magic 0x10000 mean?

>  		commit_tree(source_mnt);
>  	}
>  
> @@ -2480,6 +2491,7 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
>  	mnt->mnt.mnt_flags = mnt_flags;
>  	touch_mnt_namespace(mnt->mnt_ns);
>  	unlock_mount_hash();
> +	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR, 0);
>  }
>  
>  /*
> @@ -2880,6 +2892,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
>  		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
>  			propagate_mount_busy(mnt, 1))
>  			continue;
> +		notify_mount(mnt, NULL, NOTIFY_MOUNT_EXPIRY, 0);
>  		list_move(&mnt->mnt_expire, &graveyard);
>  	}
>  	while (!list_empty(&graveyard)) {
> 
