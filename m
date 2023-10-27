Return-Path: <linux-fsdevel+bounces-1275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C62E7D8D56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BA1C20FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E31FD3;
	Fri, 27 Oct 2023 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="osBSU32+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ru9BCGv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E164A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 03:12:06 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974C192;
	Thu, 26 Oct 2023 20:12:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C7B555C014B;
	Thu, 26 Oct 2023 23:12:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 26 Oct 2023 23:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698376322; x=1698462722; bh=dPM6KbMta6x+pxGTpCLseQCb7QZuWnuvXHI
	/wP0PmDE=; b=osBSU32+MxXjs4gbe6p0n/tqB0E8dhbTwt/RY4koYQDTgNjFzpw
	bbYz1x1dBp/kSvJN+UsWxLdatS0PpqWr7doqXi9p7fYUgdgkQugAP0CGYsZCvvfc
	LkwS+wNp4VNj2QO1Lxn2CZyCZAQ74hkmS0hErGw7TaqWD80zpDGY+CjiTY6wvNvS
	Sd5LUQE98M4mb86Kv5lP89NPEX8idWP3PMDl4uOYtZDQF5D846iqOMbAB1UEtID0
	uck3UiKBH5hW/SeTxLx/ZZn1g+qPvQRN9uxNSrmQMfuf1X/h0O2Uv8w1asI8YvCb
	BocxzB4ATp4fOTRw9hFZYOKSRAwb1QADgKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698376322; x=1698462722; bh=dPM6KbMta6x+pxGTpCLseQCb7QZuWnuvXHI
	/wP0PmDE=; b=ru9BCGv4mLwe70qkC6IUwRQ663apoumCdfdQoxuTZ4K8tq6WK6H
	FrgLNhxogAD7GIHkMDc1hzrs31wrrCFHefGjgKq9k+uMlItV0lyc9KDqnleh2UMA
	N8Ia2CElSp0TpNwWLFHiBxqX2EBQNpRxWoNc5N/bRrEumlr2FZjT40PcX8HRRP9c
	8N7TzxQST+xm6AQze2/10hkGzBp2FavdWC8zVCRJJcnmZw2hVjU/cIYdvtuT48vz
	3DrSd44/DdzCcYsLrkWm9abd1e8YmfCaoATVFkKw56Kqd7HUfKsvGplA/mQPzsQV
	TS+HWbq67U+BOVJiUQeUQnmK48LZRlQtXaA==
X-ME-Sender: <xms:gio7ZS8bP1h-Fm2O7Lg0jxdj-fxFB-TXD930kP_z6Mqk7lxaDg4lKw>
    <xme:gio7ZSvplF4NcpNQuNCfgSpyCoiHk1zEUTGEVJIC4e23q9B5u79zfr9o1UGenaS2G
    1kTN94eocNP>
X-ME-Received: <xmr:gio7ZYBB6EMs4j33-1tEmc9zAdSbRxO379kk9e91yPpuApQxvL3u6seEoZM-5IkOQmmK0NR5GArYX4xZpLF_X5wgp7SW_0h0hzQ0mI4RMKk9-eSVQe2-As2t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:gio7ZadPoDumVnHXJsySszc0gyOdpuJs-7P0oS2CQ2VPg17u1KlZnw>
    <xmx:gio7ZXO4CefYtfr0auna8bIny8BTOrNKvrSZ24aZFHgPFlg4vEk6Lw>
    <xmx:gio7ZUl3xV_w1FlYLc2BNa8faunwf5Opi4UizPb-LNVrc76gsl5OGg>
    <xmx:gio7ZbmOMIXdFU9ifFhGpfI3rprpaOgYwV25V_y1pmZ-MR0dItLwsA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 23:11:56 -0400 (EDT)
Message-ID: <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net>
Date: Fri, 27 Oct 2023 11:11:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-3-mszeredi@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
In-Reply-To: <20231025140205.3586473-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/10/23 22:02, Miklos Szeredi wrote:
> When adding a mount to a namespace insert it into an rbtree rooted in the
> mnt_namespace instead of a linear list.
>
> The mnt.mnt_list is still used to set up the mount tree and for
> propagation, but not after the mount has been added to a namespace.  Hence
> mnt_list can live in union with rb_node.  Use MNT_ONRB mount flag to
> validate that the mount is on the correct list.

Is that accurate, propagation occurs at mount and also at umount.


IDG how the change to umount_one() works, it looks like umount_list()

uses mnt_list. It looks like propagate_umount() is also using mnt_list.


Am I missing something obvious?

Ian

>
> This allows removing the cursor used for reading /proc/$PID/mountinfo.  The
> mnt_id_unique of the next mount can be used as an index into the seq file.
>
> Tested by inserting 100k bind mounts, unsharing the mount namespace, and
> unmounting.  No performance regressions have been observed.
>
> For the last mount in the 100k list the statmount() call was more than 100x
> faster due to the mount ID lookup not having to do a linear search.  This
> patch makes the overhead of mount ID lookup non-observable in this range.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/mount.h            |  24 +++---
>   fs/namespace.c        | 190 ++++++++++++++++++++----------------------
>   fs/pnode.c            |   2 +-
>   fs/proc_namespace.c   |   3 -
>   include/linux/mount.h |   5 +-
>   5 files changed, 106 insertions(+), 118 deletions(-)
>
> diff --git a/fs/mount.h b/fs/mount.h
> index a14f762b3f29..4a42fc68f4cc 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -8,19 +8,13 @@
>   struct mnt_namespace {
>   	struct ns_common	ns;
>   	struct mount *	root;
> -	/*
> -	 * Traversal and modification of .list is protected by either
> -	 * - taking namespace_sem for write, OR
> -	 * - taking namespace_sem for read AND taking .ns_lock.
> -	 */
> -	struct list_head	list;
> -	spinlock_t		ns_lock;
> +	struct rb_root		mounts; /* Protected by namespace_sem */
>   	struct user_namespace	*user_ns;
>   	struct ucounts		*ucounts;
>   	u64			seq;	/* Sequence number to prevent loops */
>   	wait_queue_head_t poll;
>   	u64 event;
> -	unsigned int		mounts; /* # of mounts in the namespace */
> +	unsigned int		nr_mounts; /* # of mounts in the namespace */
>   	unsigned int		pending_mounts;
>   } __randomize_layout;
>   
> @@ -55,7 +49,10 @@ struct mount {
>   	struct list_head mnt_child;	/* and going through their mnt_child */
>   	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
>   	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
> -	struct list_head mnt_list;
> +	union {
> +		struct rb_node mnt_node;	/* Under ns->mounts */
> +		struct list_head mnt_list;
> +	};
>   	struct list_head mnt_expire;	/* link in fs-specific expiry list */
>   	struct list_head mnt_share;	/* circular list of shared mounts */
>   	struct list_head mnt_slave_list;/* list of slave mounts */
> @@ -128,7 +125,6 @@ struct proc_mounts {
>   	struct mnt_namespace *ns;
>   	struct path root;
>   	int (*show)(struct seq_file *, struct vfsmount *);
> -	struct mount cursor;
>   };
>   
>   extern const struct seq_operations mounts_op;
> @@ -147,4 +143,12 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
>   	return ns->seq == 0;
>   }
>   
> +static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
> +{
> +	WARN_ON(!(mnt->mnt.mnt_flags & MNT_ONRB));
> +	mnt->mnt.mnt_flags &= ~MNT_ONRB;
> +	rb_erase(&mnt->mnt_node, &mnt->mnt_ns->mounts);
> +	list_add_tail(&mnt->mnt_list, dt_list);
> +}
> +
>   extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e02bc5f41c7b..0eab47ffc76c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -732,21 +732,6 @@ struct vfsmount *lookup_mnt(const struct path *path)
>   	return m;
>   }
>   
> -static inline void lock_ns_list(struct mnt_namespace *ns)
> -{
> -	spin_lock(&ns->ns_lock);
> -}
> -
> -static inline void unlock_ns_list(struct mnt_namespace *ns)
> -{
> -	spin_unlock(&ns->ns_lock);
> -}
> -
> -static inline bool mnt_is_cursor(struct mount *mnt)
> -{
> -	return mnt->mnt.mnt_flags & MNT_CURSOR;
> -}
> -
>   /*
>    * __is_local_mountpoint - Test to see if dentry is a mountpoint in the
>    *                         current mount namespace.
> @@ -765,19 +750,15 @@ static inline bool mnt_is_cursor(struct mount *mnt)
>   bool __is_local_mountpoint(struct dentry *dentry)
>   {
>   	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
> -	struct mount *mnt;
> +	struct mount *mnt, *n;
>   	bool is_covered = false;
>   
>   	down_read(&namespace_sem);
> -	lock_ns_list(ns);
> -	list_for_each_entry(mnt, &ns->list, mnt_list) {
> -		if (mnt_is_cursor(mnt))
> -			continue;
> +	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
>   		is_covered = (mnt->mnt_mountpoint == dentry);
>   		if (is_covered)
>   			break;
>   	}
> -	unlock_ns_list(ns);
>   	up_read(&namespace_sem);
>   
>   	return is_covered;
> @@ -1024,6 +1005,30 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
>   	mnt_add_count(old_parent, -1);
>   }
>   
> +static inline struct mount *node_to_mount(struct rb_node *node)
> +{
> +	return rb_entry(node, struct mount, mnt_node);
> +}
> +
> +static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
> +{
> +	struct rb_node **link = &ns->mounts.rb_node;
> +	struct rb_node *parent = NULL;
> +
> +	WARN_ON(mnt->mnt.mnt_flags & MNT_ONRB);
> +	mnt->mnt_ns = ns;
> +	while (*link) {
> +		parent = *link;
> +		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique)
> +			link = &parent->rb_left;
> +		else
> +			link = &parent->rb_right;
> +	}
> +	rb_link_node(&mnt->mnt_node, parent, link);
> +	rb_insert_color(&mnt->mnt_node, &ns->mounts);
> +	mnt->mnt.mnt_flags |= MNT_ONRB;
> +}
> +
>   /*
>    * vfsmount lock must be held for write
>    */
> @@ -1037,12 +1042,13 @@ static void commit_tree(struct mount *mnt)
>   	BUG_ON(parent == mnt);
>   
>   	list_add_tail(&head, &mnt->mnt_list);
> -	list_for_each_entry(m, &head, mnt_list)
> -		m->mnt_ns = n;
> +	while (!list_empty(&head)) {
> +		m = list_first_entry(&head, typeof(*m), mnt_list);
> +		list_del(&m->mnt_list);
>   
> -	list_splice(&head, n->list.prev);
> -
> -	n->mounts += n->pending_mounts;
> +		mnt_add_to_ns(n, m);
> +	}
> +	n->nr_mounts += n->pending_mounts;
>   	n->pending_mounts = 0;
>   
>   	__attach_mnt(mnt, parent);
> @@ -1190,7 +1196,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>   	}
>   
>   	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
> -	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
> +	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_ONRB);
>   
>   	atomic_inc(&sb->s_active);
>   	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
> @@ -1415,65 +1421,57 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
>   	return &p->mnt;
>   }
>   
> -#ifdef CONFIG_PROC_FS
> -static struct mount *mnt_list_next(struct mnt_namespace *ns,
> -				   struct list_head *p)
> +/*
> + * Returns the mount which either has the specified mnt_id, or has the next
> + * smallest id afer the specified one.
> + */
> +static struct mount *mnt_find_id_at(struct mnt_namespace *ns, u64 mnt_id)
>   {
> -	struct mount *mnt, *ret = NULL;
> +	struct rb_node *node = ns->mounts.rb_node;
> +	struct mount *ret = NULL;
>   
> -	lock_ns_list(ns);
> -	list_for_each_continue(p, &ns->list) {
> -		mnt = list_entry(p, typeof(*mnt), mnt_list);
> -		if (!mnt_is_cursor(mnt)) {
> -			ret = mnt;
> -			break;
> +	while (node) {
> +		struct mount *m = node_to_mount(node);
> +
> +		if (mnt_id <= m->mnt_id_unique) {
> +			ret = node_to_mount(node);
> +			if (mnt_id == m->mnt_id_unique)
> +				break;
> +			node = node->rb_left;
> +		} else {
> +			node = node->rb_right;
>   		}
>   	}
> -	unlock_ns_list(ns);
> -
>   	return ret;
>   }
>   
> +#ifdef CONFIG_PROC_FS
> +
>   /* iterator; we want it to have access to namespace_sem, thus here... */
>   static void *m_start(struct seq_file *m, loff_t *pos)
>   {
>   	struct proc_mounts *p = m->private;
> -	struct list_head *prev;
>   
>   	down_read(&namespace_sem);
> -	if (!*pos) {
> -		prev = &p->ns->list;
> -	} else {
> -		prev = &p->cursor.mnt_list;
>   
> -		/* Read after we'd reached the end? */
> -		if (list_empty(prev))
> -			return NULL;
> -	}
> -
> -	return mnt_list_next(p->ns, prev);
> +	return mnt_find_id_at(p->ns, *pos);
>   }
>   
>   static void *m_next(struct seq_file *m, void *v, loff_t *pos)
>   {
> -	struct proc_mounts *p = m->private;
> -	struct mount *mnt = v;
> +	struct mount *next = NULL, *mnt = v;
> +	struct rb_node *node = rb_next(&mnt->mnt_node);
>   
>   	++*pos;
> -	return mnt_list_next(p->ns, &mnt->mnt_list);
> +	if (node) {
> +		next = node_to_mount(node);
> +		*pos = next->mnt_id_unique;
> +	}
> +	return next;
>   }
>   
>   static void m_stop(struct seq_file *m, void *v)
>   {
> -	struct proc_mounts *p = m->private;
> -	struct mount *mnt = v;
> -
> -	lock_ns_list(p->ns);
> -	if (mnt)
> -		list_move_tail(&p->cursor.mnt_list, &mnt->mnt_list);
> -	else
> -		list_del_init(&p->cursor.mnt_list);
> -	unlock_ns_list(p->ns);
>   	up_read(&namespace_sem);
>   }
>   
> @@ -1491,14 +1489,6 @@ const struct seq_operations mounts_op = {
>   	.show	= m_show,
>   };
>   
> -void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
> -{
> -	down_read(&namespace_sem);
> -	lock_ns_list(ns);
> -	list_del(&cursor->mnt_list);
> -	unlock_ns_list(ns);
> -	up_read(&namespace_sem);
> -}
>   #endif  /* CONFIG_PROC_FS */
>   
>   /**
> @@ -1640,7 +1630,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>   	/* Gather the mounts to umount */
>   	for (p = mnt; p; p = next_mnt(p, mnt)) {
>   		p->mnt.mnt_flags |= MNT_UMOUNT;
> -		list_move(&p->mnt_list, &tmp_list);
> +		if (p->mnt.mnt_flags & MNT_ONRB)
> +			move_from_ns(p, &tmp_list);
> +		else
> +			list_move(&p->mnt_list, &tmp_list);
>   	}
>   
>   	/* Hide the mounts from mnt_mounts */
> @@ -1660,7 +1653,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>   		list_del_init(&p->mnt_list);
>   		ns = p->mnt_ns;
>   		if (ns) {
> -			ns->mounts--;
> +			ns->nr_mounts--;
>   			__touch_mnt_namespace(ns);
>   		}
>   		p->mnt_ns = NULL;
> @@ -1786,14 +1779,16 @@ static int do_umount(struct mount *mnt, int flags)
>   
>   	event++;
>   	if (flags & MNT_DETACH) {
> -		if (!list_empty(&mnt->mnt_list))
> +		if (mnt->mnt.mnt_flags & MNT_ONRB ||
> +		    !list_empty(&mnt->mnt_list))
>   			umount_tree(mnt, UMOUNT_PROPAGATE);
>   		retval = 0;
>   	} else {
>   		shrink_submounts(mnt);
>   		retval = -EBUSY;
>   		if (!propagate_mount_busy(mnt, 2)) {
> -			if (!list_empty(&mnt->mnt_list))
> +			if (mnt->mnt.mnt_flags & MNT_ONRB ||
> +			    !list_empty(&mnt->mnt_list))
>   				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
>   			retval = 0;
>   		}
> @@ -2211,9 +2206,9 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
>   	unsigned int mounts = 0;
>   	struct mount *p;
>   
> -	if (ns->mounts >= max)
> +	if (ns->nr_mounts >= max)
>   		return -ENOSPC;
> -	max -= ns->mounts;
> +	max -= ns->nr_mounts;
>   	if (ns->pending_mounts >= max)
>   		return -ENOSPC;
>   	max -= ns->pending_mounts;
> @@ -2357,8 +2352,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   		touch_mnt_namespace(source_mnt->mnt_ns);
>   	} else {
>   		if (source_mnt->mnt_ns) {
> +			LIST_HEAD(head);
> +
>   			/* move from anon - the caller will destroy */
> -			list_del_init(&source_mnt->mnt_ns->list);
> +			for (p = source_mnt; p; p = next_mnt(p, source_mnt))
> +				move_from_ns(p, &head);
> +			list_del_init(&head);
>   		}
>   		if (beneath)
>   			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
> @@ -2669,11 +2668,10 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
>   
>   	lock_mount_hash();
>   	for (p = mnt; p; p = next_mnt(p, mnt)) {
> -		p->mnt_ns = ns;
> -		ns->mounts++;
> +		mnt_add_to_ns(ns, p);
> +		ns->nr_mounts++;
>   	}
>   	ns->root = mnt;
> -	list_add_tail(&ns->list, &mnt->mnt_list);
>   	mntget(&mnt->mnt);
>   	unlock_mount_hash();
>   	namespace_unlock();
> @@ -3736,9 +3734,8 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>   	if (!anon)
>   		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
>   	refcount_set(&new_ns->ns.count, 1);
> -	INIT_LIST_HEAD(&new_ns->list);
> +	new_ns->mounts = RB_ROOT;
>   	init_waitqueue_head(&new_ns->poll);
> -	spin_lock_init(&new_ns->ns_lock);
>   	new_ns->user_ns = get_user_ns(user_ns);
>   	new_ns->ucounts = ucounts;
>   	return new_ns;
> @@ -3785,7 +3782,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>   		unlock_mount_hash();
>   	}
>   	new_ns->root = new;
> -	list_add_tail(&new_ns->list, &new->mnt_list);
>   
>   	/*
>   	 * Second pass: switch the tsk->fs->* elements and mark new vfsmounts
> @@ -3795,8 +3791,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>   	p = old;
>   	q = new;
>   	while (p) {
> -		q->mnt_ns = new_ns;
> -		new_ns->mounts++;
> +		mnt_add_to_ns(new_ns, q);
> +		new_ns->nr_mounts++;
>   		if (new_fs) {
>   			if (&p->mnt == new_fs->root.mnt) {
>   				new_fs->root.mnt = mntget(&q->mnt);
> @@ -3838,10 +3834,9 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
>   		mntput(m);
>   		return ERR_CAST(ns);
>   	}
> -	mnt->mnt_ns = ns;
>   	ns->root = mnt;
> -	ns->mounts++;
> -	list_add(&mnt->mnt_list, &ns->list);
> +	ns->nr_mounts++;
> +	mnt_add_to_ns(ns, mnt);
>   
>   	err = vfs_path_lookup(m->mnt_root, m,
>   			name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
> @@ -4019,10 +4014,9 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>   		goto err_path;
>   	}
>   	mnt = real_mount(newmount.mnt);
> -	mnt->mnt_ns = ns;
>   	ns->root = mnt;
> -	ns->mounts = 1;
> -	list_add(&mnt->mnt_list, &ns->list);
> +	ns->nr_mounts = 1;
> +	mnt_add_to_ns(ns, mnt);
>   	mntget(newmount.mnt);
>   
>   	/* Attach to an apparent O_PATH fd with a note that we need to unmount
> @@ -4693,10 +4687,9 @@ static void __init init_mount_tree(void)
>   	if (IS_ERR(ns))
>   		panic("Can't allocate initial namespace");
>   	m = real_mount(mnt);
> -	m->mnt_ns = ns;
>   	ns->root = m;
> -	ns->mounts = 1;
> -	list_add(&m->mnt_list, &ns->list);
> +	ns->nr_mounts = 1;
> +	mnt_add_to_ns(ns, m);
>   	init_task.nsproxy->mnt_ns = ns;
>   	get_mnt_ns(ns);
>   
> @@ -4823,18 +4816,14 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
>   				int *new_mnt_flags)
>   {
>   	int new_flags = *new_mnt_flags;
> -	struct mount *mnt;
> +	struct mount *mnt, *n;
>   	bool visible = false;
>   
>   	down_read(&namespace_sem);
> -	lock_ns_list(ns);
> -	list_for_each_entry(mnt, &ns->list, mnt_list) {
> +	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
>   		struct mount *child;
>   		int mnt_flags;
>   
> -		if (mnt_is_cursor(mnt))
> -			continue;
> -
>   		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
>   			continue;
>   
> @@ -4882,7 +4871,6 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
>   	next:	;
>   	}
>   found:
> -	unlock_ns_list(ns);
>   	up_read(&namespace_sem);
>   	return visible;
>   }
> diff --git a/fs/pnode.c b/fs/pnode.c
> index e4d0340393d5..a799e0315cc9 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -468,7 +468,7 @@ static void umount_one(struct mount *mnt, struct list_head *to_umount)
>   	mnt->mnt.mnt_flags |= MNT_UMOUNT;
>   	list_del_init(&mnt->mnt_child);
>   	list_del_init(&mnt->mnt_umounting);
> -	list_move_tail(&mnt->mnt_list, to_umount);
> +	move_from_ns(mnt, to_umount);
>   }
>   
>   /*
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 250eb5bf7b52..73d2274d5f59 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -283,8 +283,6 @@ static int mounts_open_common(struct inode *inode, struct file *file,
>   	p->ns = ns;
>   	p->root = root;
>   	p->show = show;
> -	INIT_LIST_HEAD(&p->cursor.mnt_list);
> -	p->cursor.mnt.mnt_flags = MNT_CURSOR;
>   
>   	return 0;
>   
> @@ -301,7 +299,6 @@ static int mounts_release(struct inode *inode, struct file *file)
>   	struct seq_file *m = file->private_data;
>   	struct proc_mounts *p = m->private;
>   	path_put(&p->root);
> -	mnt_cursor_del(p->ns, &p->cursor);
>   	put_mnt_ns(p->ns);
>   	return seq_release_private(inode, file);
>   }
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 4f40b40306d0..7952eddc835c 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -50,8 +50,7 @@ struct path;
>   #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
>   
>   #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
> -			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
> -			    MNT_CURSOR)
> +			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | MNT_ONRB)
>   
>   #define MNT_INTERNAL	0x4000
>   
> @@ -65,7 +64,7 @@ struct path;
>   #define MNT_SYNC_UMOUNT		0x2000000
>   #define MNT_MARKED		0x4000000
>   #define MNT_UMOUNT		0x8000000
> -#define MNT_CURSOR		0x10000000
> +#define MNT_ONRB		0x10000000
>   
>   struct vfsmount {
>   	struct dentry *mnt_root;	/* root of the mounted tree */

