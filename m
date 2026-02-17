Return-Path: <linux-fsdevel+bounces-77357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAQ4JENYlGkXDAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:00:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F714BB26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1784301A525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32E13358DA;
	Tue, 17 Feb 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g24/07k2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46A3358B9;
	Tue, 17 Feb 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329599; cv=none; b=I/foxRSqxRoPvQCgnSrtxUfqA95hMI8sWJJd32KZhZMAvIZ3cUiOxxEArmcHrwxIvWt0qyonbdYRN6ABxQcOTy8f56DF2gCML2tiknwDttSaJ8NTVQ1Q57+R+bySyb+PLnzLBvTjrlJ4lnVxX/oLbGBOB3HIiV+TOYVAVVOuntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329599; c=relaxed/simple;
	bh=JL6N8Q2426GSWzgCqZaGIpbR/6bcvccFZNCTbTH+9Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0kT/Ce4qpO7DANVO+B5d2KxEJzKkyYH5o74xYeL+7kTmxfC8j9gbfo61bbcyPbVtJHXEtvlhw/scD2DVJeGqQm72Jv9kfwQ1LceQFccEbnQKgRV6LytsweCtlpL6aBcKFsk3Ne/NW8XlM4nfPaY/yIm4L5P6slQlkmMGEBOTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g24/07k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49914C4CEF7;
	Tue, 17 Feb 2026 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771329599;
	bh=JL6N8Q2426GSWzgCqZaGIpbR/6bcvccFZNCTbTH+9Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g24/07k2SDEgcha08fYfahB/SzP7X+2ZIwXx4PQTpNgaC6bQggu+v+zQf8nUG/hZh
	 6WpAO0JUsENj/KtNPDNdK+lBhrnkBUMvaIppZZ59MpdHoNureedepGMW9v5Whx1hbB
	 lbnWK2JltHiFkTdeS210EJIbkCgfw3fOBO1vcc0aE24kXhpe3Jb2cLIupOHaZr1nx4
	 8VKO7c9enXbLsKF5f1ulCOgQx9Nmc5IakZvvpP3XAxWt/aXxUJpvjUKi/fE6Mqw678
	 NviNLLZOzzlTwj1TtVKjKg1RtSBy4wddwhu9rIcLwmlOCn789YOPUpzGmsOYjmjnc9
	 t/Hbhr2iRs00w==
Date: Tue, 17 Feb 2026 12:59:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] proc: Relax check of mount visibility
Message-ID: <20260217-helikopter-parkplatz-859f8f7c0054@brauner>
References: <cover.1768295900.git.legion@kernel.org>
 <cover.1770979341.git.legion@kernel.org>
 <0943f113592a25bee341aae25d1cea088791054f.1770979341.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0943f113592a25bee341aae25d1cea088791054f.1770979341.git.legion@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77357-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,xmission.com,chromium.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D0F714BB26
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:44:29AM +0100, Alexey Gladkov wrote:
> When /proc is mounted with the subset=pid option, all system files from
> the root of the file system are not accessible in userspace. Only
> dynamic information about processes is available, which cannot be
> hidden with overmount.
> 
> For this reason, checking for full visibility is not relevant if
> mounting is performed with the subset=pid option.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  fs/namespace.c                 | 29 ++++++++++++++++-------------
>  fs/proc/root.c                 | 17 ++++++++++-------
>  include/linux/fs/super_types.h |  2 ++
>  3 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c58674a20cad..7daa86315c05 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6116,7 +6116,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
>  		/* This mount is not fully visible if it's root directory
>  		 * is not the root directory of the filesystem.
>  		 */
> -		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> +		if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
> +		    mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
>  			continue;
>  
>  		/* A local view of the mount flags */
> @@ -6136,18 +6137,20 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
>  		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
>  			continue;

There are a few things that I find problematic here.

Even before your change the mount flags of the first fully visible
procfs mount would be picked up. If the caller was unlucky they could
stumble upon the most restricted procfs mount in the mount namespace
rbtree. Leading to weird scenarios where a user cannot write to the
procfs instance they just mounted but could to another one that is also
in their namespace.

The other thing is that with this change specifically:

    if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
        mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)

we start caring about mount options of even partially exposed procfs
mounts. IOW, if someone had a bind-mount of e.g., /proc/pressure
somewhere that got inherited via CLONE_NEWNS then we suddenly take the
mount options of that into account for a new /proc/<pid>/* only instance.
I think we should continue caring only about procfs mounts that are
visible from their root.

The the other problem is that it is really annoying that we walk all
mounts in a mount namespace just to find procfs and sysfs mounts in
there. Currently a lot of workloads still do the CLONE_NEWNS dance
meaning they inherit all the crap from the host and then proceed to
setup their new rootfs. Busy container workloads that can be a lot.

So let's just be honest about it and treat procfs and sysfs as the
snowflakes that they have become and record their instances in a
separate per mount namespace hlist as in the (untested) patch below [1].

Also SB_I_USERNS_ALLOW_REVEALING seems unnecessary. The only time we
care about that flag is when we setup a new superblock. So this could
easily be a struct fs_context bitfield that just exists for the duration
of the creation of the new superblock and mount. So maybe pass that down
to mount_too_revealing() and further down into the actual helper.

[1]:
From 4bbd41e7a3ef91667dd334f31b1b6bf8caec0599 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Feb 2026 12:02:34 +0100
Subject: [PATCH] namespace: record fully visible mounts in list

Instead of wading through all the mounts in the mount namespace rbtree
to find fully visible procfs and sysfs mounts, be honest about them
being special cruft and record them in a separate per-mount namespace
list.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |  4 ++++
 fs/namespace.c | 19 +++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index e0816c11a198..5df134d56d47 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -25,6 +25,7 @@ struct mnt_namespace {
 	__u32			n_fsnotify_mask;
 	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
 #endif
+	struct hlist_head	mnt_visible_mounts; /* SB_I_USERNS_VISIBLE mounts */
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	refcount_t		passive; /* number references not pinning @mounts */
@@ -90,6 +91,7 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+	struct hlist_node mnt_ns_visible; /* link in ns->mnt_visible_mounts */
 	struct mount *overmount;	/* mounted on ->mnt_root */
 } __randomize_layout;
 
@@ -207,6 +209,8 @@ static inline void move_from_ns(struct mount *mnt)
 		ns->mnt_first_node = rb_next(&mnt->mnt_node);
 	rb_erase(&mnt->mnt_node, &ns->mounts);
 	RB_CLEAR_NODE(&mnt->mnt_node);
+	if (!hlist_unhashed(&mnt->mnt_ns_visible))
+		hlist_del_init(&mnt->mnt_ns_visible);
 }
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..764081c690d5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -321,6 +321,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_slave);
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
+		INIT_HLIST_NODE(&mnt->mnt_ns_visible);
 		RB_CLEAR_NODE(&mnt->mnt_node);
 		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
 	}
@@ -1098,6 +1099,10 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
 
+	if ((mnt->mnt.mnt_sb->s_iflags & SB_I_USERNS_VISIBLE) &&
+	    mnt->mnt.mnt_root == mnt->mnt.mnt_sb->s_root)
+		hlist_add_head(&mnt->mnt_ns_visible, &ns->mnt_visible_mounts);
+
 	mnt_notify_add(mnt);
 }
 
@@ -6295,22 +6300,20 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 				int *new_mnt_flags)
 {
 	int new_flags = *new_mnt_flags;
-	struct mount *mnt, *n;
+	struct mount *mnt;
+
+	/* Don't acquire namespace semaphore without a good reason. */
+	if (hlist_empty(&ns->mnt_visible_mounts))
+		return false;
 
 	guard(namespace_shared)();
-	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
+	hlist_for_each_entry(mnt, &ns->mnt_visible_mounts, mnt_ns_visible) {
 		struct mount *child;
 		int mnt_flags;
 
 		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
-		/* This mount is not fully visible if it's root directory
-		 * is not the root directory of the filesystem.
-		 */
-		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
-			continue;
-
 		/* A local view of the mount flags */
 		mnt_flags = mnt->mnt.mnt_flags;
 
-- 
2.47.3


