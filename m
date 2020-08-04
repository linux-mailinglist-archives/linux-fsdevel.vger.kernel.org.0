Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5F23BB3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHDNjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHDNjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:39:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DADC0617A0
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 06:38:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i26so26555849edv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BL+HRUdphF7y1mDIe4TAPt3GhgVXBM0iHVLi0mxnXW0=;
        b=NSVO26GNREg7AVBCgVqCzAcGqTkqheGeKdaAuy0KakoJXXrNUlZ84EzEyY4yvHmZI5
         O6tmd5s5RlTzliIqTPB4rHJBbPbSY4qoCXvcsJepnvgS3zREnqIMCM2NpSCqYLRE0pv4
         edd/ODepvfGug/XPWac8UAHvAeCp+Wtb4dpBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BL+HRUdphF7y1mDIe4TAPt3GhgVXBM0iHVLi0mxnXW0=;
        b=WhUoQcn+sxbf4zEbtfkGYngAPijGRhZWc3HVvLfuMxSEHiQrG3oHm+kQAmMikSZyOl
         ZOw9r1m2CXaW3JXcpNPyAqutCkySyz2UMEOOZHrgFBBin9ADjT4c8O77oVy+ZwtyN16B
         kX4BC51aF04iXjmEZWEuP3p8pV3X/FgbN7wdcGV3to8P7ZYPCSc2Sa13ieeoI7zHwXUP
         oYgB3+MYFmnmLn01KUfEqSditDWRjeDw+P8qC4cSSaE0T+zkVSUdxmOg0dOkasZ4YhgP
         lRcMH2EoNVGkaCloP81Z61DRaiMvWXrd0nTDQlIDCaEZczev6WzyaYxnu8asyfk68z3Y
         5ukg==
X-Gm-Message-State: AOAM531CKN+H6JxH8k+WRUaCAgP5YZuEnHtpFGukHrnqkINEDXq8ikHA
        pcDThqBwewhPBPG5V371OIOQZ9sUNQ4=
X-Google-Smtp-Source: ABdhPJwQ6u6Rdo8AHzpErMesCPuQNq6ArD3bzdOtJwNufzvYWW/taKK/GFn8W4BLEmJJ2eVzhamzjA==
X-Received: by 2002:aa7:d585:: with SMTP id r5mr8623729edq.30.1596548300295;
        Tue, 04 Aug 2020 06:38:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id dc23sm18860515edb.50.2020.08.04.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 06:38:19 -0700 (PDT)
Date:   Tue, 4 Aug 2020 15:38:17 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] fsinfo: Allow mount topology and propagation info
 to be retrieved [ver #21]
Message-ID: <20200804133817.GD32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:37:33PM +0100, David Howells wrote:
> Add a couple of attributes to allow information about the mount topology
> and propagation to be retrieved:
> 
>  (1) FSINFO_ATTR_MOUNT_TOPOLOGY.
> 
>      Information about a mount's parentage in the mount topology tree and
>      its propagation attributes.
> 
>      This has to be collected with the VFS namespace lock held, so it's
>      separate from FSINFO_ATTR_MOUNT_INFO.  The topology change counter
>      that a subsequent patch will export can be used to work out from the
>      cheaper _INFO attribute as to whether the more expensive _TOPOLOGY
>      attribute needs requerying.
> 
>      MOUNT_PROPAGATION_* flags are added to linux/mount.h for UAPI
>      consumption.  At some point a mount_setattr() system call needs to be
>      added.
> 
>  (2) FSINFO_ATTR_MOUNT_CHILDREN.
> 
>      Information about a mount's children in the mount topology tree.
> 
>      This is formatted as an array of structures, one for each child and
>      capped with one for the argument mount (checked after listing all the
>      children).  Each element contains the static IDs of the respective
>      mount object along with a sum of its change attributes.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c                 |    2 +
>  fs/internal.h               |    2 +
>  fs/namespace.c              |   94 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsinfo.h |   27 ++++++++++++
>  include/uapi/linux/mount.h  |   13 +++++-
>  samples/vfs/test-fsinfo.c   |   55 +++++++++++++++++++++++++
>  6 files changed, 192 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index f276857709ee..0540cce89555 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -291,9 +291,11 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
>  	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
>  
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_TOPOLOGY,	fsinfo_generic_mount_topology),
>  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	fsinfo_generic_seq_read),
>  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
>  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_generic_mount_point_full),
> +	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
>  	{}
>  };
>  
> diff --git a/fs/internal.h b/fs/internal.h
> index a56008b7f3ec..cb5edcc7125a 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -98,8 +98,10 @@ extern void dissolve_on_fput(struct vfsmount *);
>  extern int lookup_mount_object(struct path *, unsigned int, struct path *);
>  extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
>  extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_topology(struct path *, struct fsinfo_context *);
>  extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
>  extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
>  
>  /*
>   * fs_struct.c
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c196af35d39d..b5c2a3b4f96d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4303,6 +4303,54 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
>  	return sizeof(*p);
>  }
>  
> +/*
> + * Retrieve information about the topology at the nominated mount and
> + * its propogation attributes.
> + */
> +int fsinfo_generic_mount_topology(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_mount_topology *p = ctx->buffer;
> +	struct mount *m;
> +	struct path root;
> +
> +	get_fs_root(current->fs, &root);
> +
> +	namespace_lock();
> +
> +	m = real_mount(path->mnt);
> +
> +	p->parent_id = m->mnt_parent->mnt_id;
> +
> +	if (path->mnt == root.mnt) {
> +		p->parent_id = m->mnt_id;
> +	} else {
> +		rcu_read_lock();
> +		if (!are_paths_connected(&root, path))
> +			p->parent_id = m->mnt_id;
> +		rcu_read_unlock();
> +	}
> +
> +	if (IS_MNT_SHARED(m)) {
> +		p->shared_group_id = m->mnt_group_id;
> +		p->propagation_type |= MOUNT_PROPAGATION_SHARED;
> +	} else if (IS_MNT_SLAVE(m)) {
> +		int source = m->mnt_master->mnt_group_id;
> +		int from = get_dominating_id(m, &root);
> +		p->dependent_source_id = source;
> +		if (from && from != source)
> +			p->dependent_clone_of_id = from;
> +		p->propagation_type |= MOUNT_PROPAGATION_DEPENDENT;
> +	} else if (IS_MNT_UNBINDABLE(m)) {
> +		p->propagation_type |= MOUNT_PROPAGATION_UNBINDABLE;
> +	} else {
> +		p->propagation_type |= MOUNT_PROPAGATION_PRIVATE;
> +	}
> +
> +	namespace_unlock();
> +	path_put(&root);
> +	return sizeof(*p);
> +}
> +
>  /*
>   * Return the path of this mount relative to its parent and clipped to
>   * the current chroot.
> @@ -4379,4 +4427,50 @@ int fsinfo_generic_mount_point_full(struct path *path, struct fsinfo_context *ct
>  	return (ctx->buffer + ctx->buf_size) - p;
>  }
>  
> +/*
> + * Store a mount record into the fsinfo buffer.
> + */
> +static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mount *p,
> +			       bool is_root)
> +{
> +	struct fsinfo_mount_child record = {};
> +	unsigned int usage = ctx->usage;
> +
> +	if (ctx->usage >= INT_MAX)
> +		return;
> +	ctx->usage = usage + sizeof(record);
> +	if (!ctx->buffer || ctx->usage > ctx->buf_size)
> +		return;
> +
> +	record.mnt_unique_id	= p->mnt_unique_id;
> +	record.mnt_id		= p->mnt_id;
> +	record.parent_id	= is_root ? p->mnt_id : p->mnt_parent->mnt_id;
> +	memcpy(ctx->buffer + usage, &record, sizeof(record));
> +}
> +
> +/*
> + * Return information about the submounts relative to path.
> + */
> +int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct mount *m, *child;
> +
> +	m = real_mount(path->mnt);
> +
> +	read_seqlock_excl(&mount_lock);
> +
> +	list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
> +		if (child->mnt_parent != m)
> +			continue;
> +		fsinfo_store_mount(ctx, child, false);
> +	}
> +
> +	/* End the list with a copy of the parameter mount's details so that
> +	 * userspace can quickly check for changes.
> +	 */
> +	fsinfo_store_mount(ctx, m, true);
> +	read_sequnlock_excl(&mount_lock);
> +	return ctx->usage;
> +}
> +
>  #endif /* CONFIG_FSINFO */
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index 15ef161905cd..f0a352b7028e 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -35,6 +35,8 @@
>  #define FSINFO_ATTR_MOUNT_PATH		0x201	/* Bind mount/superblock path (string) */
>  #define FSINFO_ATTR_MOUNT_POINT		0x202	/* Relative path of mount in parent (string) */
>  #define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute path of mount (string) */
> +#define FSINFO_ATTR_MOUNT_TOPOLOGY	0x204	/* Mount object topology */
> +#define FSINFO_ATTR_MOUNT_CHILDREN	0x205	/* Children of this mount (list) */
>  
>  /*
>   * Optional fsinfo() parameter structure.
> @@ -102,6 +104,31 @@ struct fsinfo_mount_info {
>  
>  #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
>  
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_MOUNT_TOPOLOGY).
> + */
> +struct fsinfo_mount_topology {
> +	__u32	parent_id;		/* Parent mount identifier */

Again, which mount ID does this refer to?  I think we want this to be *the*
mount id that's both unique and can be looked up and that is 64 bits wide.


> +	__u32	shared_group_id;	/* Shared: mount group ID */
> +	__u32	dependent_source_id;	/* Dependent: source mount group ID */
> +	__u32	dependent_clone_of_id;	/* Dependent: ID of mount this was cloned from */

Another set of ID's that are currently 32bit *internally* but that doesn't mean
they will always be 32 bit.

And that last one (apart from "slave" being obfuscated) is simply incorrect.  It
has nothing to do with cloning.  It's the "ID of the closest peer group in the
propagation chain that has a representative mount in the current root".

> +	__u32	propagation_type;	/* MOUNT_PROPAGATION_* type */
> +};
> +
> +#define FSINFO_ATTR_MOUNT_TOPOLOGY__STRUCT struct fsinfo_mount_topology
> +
> +/*
> + * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
> + * - An extra element is placed on the end representing the parent mount.
> + */
> +struct fsinfo_mount_child {
> +	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
> +	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
> +	__u32	parent_id;		/* Parent mount identifier */


Again, which ID do we want for this and parent?  Preferably one which is 64bit.
As it is we are operating with 96bit mount ID's, which is excessive.

> +};
> +
> +#define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
> +
>  /*
>   * Information struct for fsinfo(FSINFO_ATTR_STATFS).
>   * - This gives extended filesystem information.
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 96a0240f23fe..9ac8bb708843 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -105,7 +105,7 @@ enum fsconfig_command {
>  #define FSMOUNT_CLOEXEC		0x00000001
>  
>  /*
> - * Mount attributes.
> + * Mount object attributes (these are separate to filesystem attributes).
>   */
>  #define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
>  #define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
> @@ -117,4 +117,15 @@ enum fsconfig_command {
>  #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
>  #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
>  
> +/*
> + * Mount object propagation type.
> + */
> +enum propagation_type {
> +	/* 0 is left unallocated to mean "no change" in mount_setattr()  */
> +	MOUNT_PROPAGATION_UNBINDABLE	= 1, /* Make unbindable. */
> +	MOUNT_PROPAGATION_PRIVATE	= 2, /* Do not receive or send mount events. */
> +	MOUNT_PROPAGATION_DEPENDENT	= 3, /* Only receive mount events. */
> +	MOUNT_PROPAGATION_SHARED	= 4, /* Send and receive mount events. */
> +};
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index f3bebb7318d9..b7290ea8eb55 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -21,6 +21,7 @@
>  #include <sys/syscall.h>
>  #include <linux/fsinfo.h>
>  #include <linux/socket.h>
> +#include <linux/mount.h>
>  #include <sys/stat.h>
>  #include <arpa/inet.h>
>  
> @@ -305,6 +306,58 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
>  	printf("\tattr    : %x\n", r->attr);
>  }
>  
> +static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
> +{
> +	struct fsinfo_mount_topology *r = reply;
> +
> +	printf("\n");
> +	printf("\tparent  : %x\n", r->parent_id);
> +
> +	switch (r->propagation_type) {
> +	case MOUNT_PROPAGATION_UNBINDABLE:
> +		printf("\tpropag  : unbindable\n");
> +		break;
> +	case MOUNT_PROPAGATION_PRIVATE:
> +		printf("\tpropag  : private\n");
> +		break;
> +	case MOUNT_PROPAGATION_DEPENDENT:
> +		printf("\tpropag  : dependent source=%x clone_of=%x\n",
> +		       r->dependent_source_id, r->dependent_clone_of_id);
> +		break;
> +	case MOUNT_PROPAGATION_SHARED:
> +		printf("\tpropag  : shared group=%x\n", r->shared_group_id);
> +		break;
> +	default:
> +		printf("\tpropag  : unknown type %x\n", r->propagation_type);
> +		break;
> +	}
> +
> +}
> +
> +static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
> +{
> +	struct fsinfo_mount_child *r = reply;
> +	ssize_t mplen;
> +	char path[32], *mp;
> +
> +	struct fsinfo_params params = {
> +		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
> +		.request	= FSINFO_ATTR_MOUNT_POINT,
> +	};
> +
> +	if (!list_last) {
> +		sprintf(path, "%u", r->mnt_id);
> +		mplen = get_fsinfo(path, "FSINFO_ATTR_MOUNT_POINT", &params, (void **)&mp);
> +		if (mplen < 0)
> +			mp = "-";
> +	} else {
> +		mp = "<this>";
> +	}
> +
> +	printf("%8x %16llx %s\n",
> +	       r->mnt_id, (unsigned long long)r->mnt_unique_id, mp);
> +}
> +
>  static void dump_string(void *reply, unsigned int size)
>  {
>  	char *s = reply, *p;
> @@ -383,9 +436,11 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
>  	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_meta_attributes),
>  
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_TOPOLOGY,	fsinfo_generic_mount_topology),
>  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	string),
>  	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
>  	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
> +	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
>  	{}
>  };
>  
> 
> 
