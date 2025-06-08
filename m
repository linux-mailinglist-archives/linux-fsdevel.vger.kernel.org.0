Return-Path: <linux-fsdevel+bounces-50933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D71AD1394
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 19:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BA03A9515
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C531A9B46;
	Sun,  8 Jun 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="LUOGY1nR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnGqEbds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EF2629C;
	Sun,  8 Jun 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749404082; cv=none; b=taLVP/9525pmZuL1q1hE5VGAG0LoQQe7txsnsli1mNgeAQfOa7PnTSUEC6CW0XzRuAAz/06EvufCLgTgM3ClyfFibQFf8RFtTsY37BCipBU1L9TbBnPM57edZuswvqxB/ooMB4WdsUJBe49PYRbY6znvzHI0+iGH9hGLyBPaI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749404082; c=relaxed/simple;
	bh=DIUct9YGb4Y5skAXED6b43APurmY3ChtQ8L7qHDXc9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmQ9lCrAENgOfPKuggoOmSkc8FbYqZO96OhhxBiw3YgadPGj7ywc8Ltxero1WSsgsqqzfCR1l7eRz83XH8ttuVk/gEcNG6wxIALLmmFQlXPjQNzYImAadZ6orOHARccK7eLGlRzTPbh5A6l17a/ncIsasy9IJY1A+JgemWD/ArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=LUOGY1nR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnGqEbds; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 8F64B200318;
	Sun,  8 Jun 2025 13:34:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 08 Jun 2025 13:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749404077;
	 x=1749411277; bh=n7/TrUOvDRY0ZOIfKQQgJ0Q1gzIYz2O38/YYq+zef4w=; b=
	LUOGY1nRbA140UHOhanVwvmXgNY8NuSnSEdcPg9xhQOXVwDZtAifrf9OZU/NCgtT
	YFLYNuOXxpu010YLR2eh8BvcoDaUlIgixlifQ3cyBCEEgl9Zw3oE7e0edwgYozCa
	uacQ5EjBaL38ngfNxcbkzNBkr+ut/z3/AVxJS2prmSVb28QuVtsYU63SZHSMKuZj
	wdnRGT4i2Qd/BxoQ1q+bNO9q7h3Al2+ABfRKFJqkgGYFmU4FnND3l2CjtfW3AImt
	yL7qszpe8nacwigiq5b4eWIvbCEpO7rxBOek+ZFks7aBaySQm230WJ2nsp8T31D6
	cGE+DdhmE53BfX1bdo07Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749404077; x=
	1749411277; bh=n7/TrUOvDRY0ZOIfKQQgJ0Q1gzIYz2O38/YYq+zef4w=; b=J
	nGqEbdstOq2AUtOx69uD9FWuChmdeCHowGpor92gYIDmae4fCz+DdfjA/yezlznc
	PLecbSWSgN97kmCm2+iUL/kAqfXoXHa9TfBCPJpTDCiTYhPmCQKgcpx1bID8eB5A
	/mzi6y4yiyYeq7KbAykNMp8lIOL4B9HLhUOhvcedcmlZER2p7Y0lmoZV/MyNlAUn
	KVGY9XH84gkjGLcva1Q1IrtryrcESpJePp1G+ndsr0vRI2sx23ityjGkFKTdeRTH
	MEoF6pRz+BJXvRsAcBpKdLLdh7Aft1x49TI5xG31RLO+glQ7GFFa/i4uLpLeqVzo
	SFRz/CUlo+Wkfbq9dheFQ==
X-ME-Sender: <xms:rMlFaFdVUG4PcqpsyfShuPJC-FzC5CiVLouYzkm6XNzeyIUN9J5SHw>
    <xme:rMlFaDOcCovPTtQdqDXHgj9HRhRSNxxtbgEE-Jgb5vbqvdd66A2e9Gjif33Bm35B5
    RkGYwXV3RM_m0WegU4>
X-ME-Received: <xmr:rMlFaOirPuweXyoEJpozaGoBgjZL0G5Y-9CFlk3xdE_1S6DN6TUOPI7nM8SonCHyB5f6pwOsRHqrX0EFwqXILY6h3vuaIcJxo4y-kfteECC6EZ8m6AXH9mNaZZePdk5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepieeigeeghedtffeifffhkeeuffehhfevuefgvdekjeekhedv
    tedtgfdvgefhudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedvfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepvhhirhhoseiivghn
    ihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopegr
    mhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rMlFaO8N5dMAQSw9A0-RgJeWtimawCVfGrQAEXqz9tW3TAMPleMuCg>
    <xmx:rMlFaBtto1n0jByPBmGfG3tzS1C5GnsRVdd5XcKva4iBCOYX2T6Eng>
    <xmx:rMlFaNFSZn5DyvP1ZO2icFg-l4w4ajAcZA2blFelCJ6fuUYQAXt5vA>
    <xmx:rMlFaIOaQskG6vmsJdylzNJSSk1GxecrC0GQ4-i1CQyqcexmXxsjqw>
    <xmx:rclFaIeMwEpgQXGTU0Rlq93Gn6pg7ITeor60eJM1vHxI7RcsJcHGnoUu>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 13:34:31 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Song Liu <song@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>,
	amir73il@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	gnoack@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kernel-team@meta.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	repnop@google.com
Subject: Re: [PATCH v3 bpf-next 0/5] bpf path iterator
Date: Sun,  8 Jun 2025 18:32:55 +0100
Message-ID: <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606213015.255134-1-song@kernel.org>
References: <20250606213015.255134-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/6/25 22:30, Song Liu wrote:
> In security use cases, it is common to apply rules to VFS subtrees.
> However, filtering files in a subtree is not straightforward [1].
>
> One solution to this problem is to start from a path and walk up the VFS
> tree (towards the root). Among in-tree LSMs, Landlock uses this solution.
>
> BPF LSM solutions, such like Tetragon [2], also use similar approaches.
> However, due to lack of proper helper/kfunc support, BPF LSM solutions
> usually do the path walk with probe read, which is racy.
>
> This patchset introduces a new helper path_walk_parent, which walks
> path to its VFS parent. The helper is used in Landlock.
>
> A new BPF iterator, path iterator, is introduced to do the path walking.
> The BPF path iterator uses the new path_walk_parent help to walk the VFS
> tree.

Hi Song, Christian, Al and others,

Previously I proposed in [1] to add ability to do a reference-less parent
walk for Landlock.  However, as Christian pointed out and I do agree in
hindsight, it is not a good idea to do things like this in non-VFS code.

However, I still think this is valuable to consider given the performance
improvement, and after some discussion with Mickaël, I would like to
propose extending Song's helper to support such usage.  While I recognize
that this patch series is already in its v3, and I do not want to delay it
by too much, putting this proposal out now is still better than after this
has merged, so that we may consider signature changes.

I've created a proof-of-concept and did some brief testing.  The
performance improvement attained here is the same as in [1] (with a "git
status" workload, median landlock overhead 35% -> 28%, median time in
landlock decreases by 26.6%).

If this idea is accepted, I'm happy to work on it further, split out this
patch, update the comments and do more testing etc, potentially in
collaboration with Song.

An alternative to this is perhaps to add a new helper
path_walk_parent_rcu, also living in namei.c, that will be used directly
by Landlock.  I'm happy to do it either way, but with some experimentation
I personally think that the code in this patch is still clean enough, and
can avoid some duplication.

Patch title: path_walk_parent: support reference-less walk

A later commit will update the BPF path iterator to use this.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/namei.c             | 107 ++++++++++++++++++++++++++++++++++++-----
 include/linux/namei.h  |  19 +++++++-
 security/landlock/fs.c |  49 +++++++++++++++++--
 3 files changed, 157 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 732b8fd02451..351ebe957db8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1424,6 +1424,30 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
 	return found;
 }
 
+/**
+ * acquires rcu read lock if rcu == true.
+ */
+void path_walk_parent_start(struct parent_iterator *pit, const struct path *path,
+			   const struct path *root, bool ref_less)
+{
+	pit->path = *path;
+
+	pit->root.mnt = NULL;
+	pit->root.dentry = NULL;
+	if (root)
+		pit->root = *root;
+
+	pit->rcu = ref_less;
+	if (ref_less) {
+		pit->m_seq = read_seqbegin(&mount_lock);
+		pit->r_seq = read_seqbegin(&rename_lock);
+		pit->next_seq = read_seqcount_begin(&pit->path.dentry->d_seq);
+		rcu_read_lock();
+	} else {
+		path_get(&pit->path);
+	}
+}
+
 /**
  * path_walk_parent - Walk to the parent of path
  * @path: input and output path.
@@ -1446,35 +1470,92 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
  *           // stop walking
  *
  * Returns:
- *  true  - if @path is updated to its parent.
- *  false - if @path is already the root (real root or @root).
+ *  PATH_WALK_PARENT_UPDATED      - if @path is updated to its parent.
+ *  PATH_WALK_PARENT_ALREADY_ROOT - if @path is already the root (real root or @root).
+ *  PATH_WALK_PARENT_RETRY        - reference-less path walk failed. Caller should restart with rcu == false.
  */
-bool path_walk_parent(struct path *path, const struct path *root)
+int path_walk_parent(struct parent_iterator *pit, struct path *next_parent)
 {
 	struct dentry *parent;
+	struct path *path = &pit->path;
+	struct path *root = &pit->root;
+	unsigned mountpoint_d_seq;
 
 	if (path_equal(path, root))
 		return false;
 
 	if (unlikely(path->dentry == path->mnt->mnt_root)) {
-		struct path p;
+		struct path upper_mountpoint;
 
-		if (!choose_mountpoint(real_mount(path->mnt), root, &p))
-			return false;
-		path_put(path);
-		*path = p;
+		if (pit->rcu) {
+			if (!choose_mountpoint_rcu(real_mount(path->mnt), root,
+						   &upper_mountpoint,
+						   &mountpoint_d_seq)) {
+				return PATH_WALK_PARENT_ALREADY_ROOT;
+			}
+			if (read_seqcount_retry(&path->dentry->d_seq,
+						pit->next_seq)) {
+				return PATH_WALK_PARENT_RETRY;
+			}
+			*path = upper_mountpoint;
+			pit->next_seq = mountpoint_d_seq;
+		} else {
+			if (!choose_mountpoint(real_mount(path->mnt), root,
+					       &upper_mountpoint))
+				return PATH_WALK_PARENT_ALREADY_ROOT;
+			path_put(path);
+			*path = upper_mountpoint;
+		}
 	}
 
 	if (unlikely(IS_ROOT(path->dentry)))
-		return false;
+		return PATH_WALK_PARENT_ALREADY_ROOT;
 
-	parent = dget_parent(path->dentry);
-	dput(path->dentry);
-	path->dentry = parent;
-	return true;
+	if (pit->rcu) {
+		parent = READ_ONCE(path->dentry->d_parent);
+		if (read_seqcount_retry(&path->dentry->d_seq, pit->next_seq)) {
+			return PATH_WALK_PARENT_RETRY;
+		}
+		path->dentry = parent;
+		pit->next_seq = read_seqcount_begin(&parent->d_seq);
+	} else {
+		parent = dget_parent(path->dentry);
+		dput(path->dentry);
+		path->dentry = parent;
+	}
+
+	if (next_parent)
+		*next_parent = *path;
+
+	return PATH_WALK_PARENT_UPDATED;
 }
 EXPORT_SYMBOL_GPL(path_walk_parent);
 
+/**
+ * releases rcu read lock if rcu == true.
+ * Returns -EAGAIN if rcu path walk failed.
+ */
+int path_walk_parent_end(struct parent_iterator *pit)
+{
+	bool need_restart = false;
+
+	if (pit->rcu) {
+		rcu_read_unlock();
+		/* do we need these if we're checking d_seq throughout? */
+		if (read_seqretry(&mount_lock, pit->m_seq) ||
+		    read_seqretry(&rename_lock, pit->r_seq)) {
+			need_restart = true;
+		}
+	} else {
+		path_put(&pit->path);
+	}
+
+	if (need_restart)
+		return -EAGAIN;
+
+	return 0;
+}
+
 /*
  * Perform an automount
  * - return -EISDIR to tell follow_managed() to stop and return the path we
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 9d220b1e823c..e7fdfae12bd5 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -86,7 +86,24 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
-bool path_walk_parent(struct path *path, const struct path *root);
+struct parent_iterator {
+	struct path path;
+	struct path root;
+	bool rcu;
+	/* expected seq of path->dentry */
+	unsigned next_seq;
+	unsigned m_seq, r_seq;
+};
+
+#define PATH_WALK_PARENT_UPDATED		0
+#define PATH_WALK_PARENT_ALREADY_ROOT	-1
+#define PATH_WALK_PARENT_RETRY			-2
+
+void path_walk_parent_start(struct parent_iterator *pit,
+			    const struct path *path, const struct path *root,
+			    bool ref_less);
+int path_walk_parent(struct parent_iterator *pit, struct path *next_parent);
+int path_walk_parent_end(struct parent_iterator *pit);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3adac544dc9e..522ac617d192 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -375,6 +375,9 @@ find_rule(const struct landlock_ruleset *const domain,
 		return NULL;
 
 	inode = d_backing_inode(dentry);
+	if (unlikely(!inode))
+		/* this can happen in reference-less path walk. Let outside retry. */
+		return NULL;
 	rcu_read_lock();
 	id.key.object = rcu_dereference(landlock_inode(inode)->object);
 	rule = landlock_find_rule(domain, id);
@@ -767,10 +770,15 @@ static bool is_access_to_paths_allowed(
 	     child1_is_directory = true, child2_is_directory = true;
 	struct path walker_path;
 	access_mask_t access_masked_parent1, access_masked_parent2;
+	layer_mask_t _layer_mask_parent_1_init[LANDLOCK_NUM_ACCESS_FS],
+		_layer_mask_parent_2_init[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t _layer_masks_child1[LANDLOCK_NUM_ACCESS_FS],
 		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
+	struct parent_iterator iter;
+	bool restart_pathwalk = false;
+	int err;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -784,6 +792,15 @@ static bool is_access_to_paths_allowed(
 	if (WARN_ON_ONCE(!layer_masks_parent1))
 		return false;
 
+	memcpy(_layer_mask_parent_1_init, layer_masks_parent1,
+	       sizeof(*layer_masks_parent1));
+	if (unlikely(layer_masks_parent2)) {
+		memcpy(_layer_mask_parent_2_init, layer_masks_parent2,
+		       sizeof(*layer_masks_parent2));
+	}
+
+restart_pathwalk:
+
 	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
 
 	if (unlikely(layer_masks_parent2)) {
@@ -830,15 +847,15 @@ static bool is_access_to_paths_allowed(
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
 
+	path_walk_parent_start(&iter, path, NULL, !restart_pathwalk);
 	walker_path = *path;
-	path_get(&walker_path);
+
 	/*
 	 * We need to walk through all the hierarchy to not miss any relevant
 	 * restriction.
 	 */
 	while (true) {
 		const struct landlock_rule *rule;
-		struct path root = {};
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -896,8 +913,22 @@ static bool is_access_to_paths_allowed(
 		if (allowed_parent1 && allowed_parent2)
 			break;
 
-		if (path_walk_parent(&walker_path, &root))
+		switch (path_walk_parent(&iter, &walker_path)) {
+		case PATH_WALK_PARENT_UPDATED:
 			continue;
+		case PATH_WALK_PARENT_RETRY:
+			path_walk_parent_end(&iter);
+			memcpy(layer_masks_parent1, _layer_mask_parent_1_init,
+			       sizeof(*layer_masks_parent1));
+			if (layer_masks_parent2)
+				memcpy(layer_masks_parent2,
+				       _layer_mask_parent_2_init,
+				       sizeof(*layer_masks_parent2));
+			restart_pathwalk = true;
+			goto restart_pathwalk;
+		case PATH_WALK_PARENT_ALREADY_ROOT:
+			break;
+		}
 
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
 			/*
@@ -913,7 +944,17 @@ static bool is_access_to_paths_allowed(
 		}
 		break;
 	}
-	path_put(&walker_path);
+
+	err = path_walk_parent_end(&iter);
+	if (err == -EAGAIN) {
+		memcpy(layer_masks_parent1, _layer_mask_parent_1_init,
+		       sizeof(*layer_masks_parent1));
+		if (layer_masks_parent2)
+			memcpy(layer_masks_parent2, _layer_mask_parent_2_init,
+			       sizeof(*layer_masks_parent2));
+		restart_pathwalk = true;
+		goto restart_pathwalk;
+	}
 
 	if (!allowed_parent1) {
 		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
prerequisite-patch-id: 3a08c744682d5b01f98d196b3d3320b862d189c8
prerequisite-patch-id: 37586287398318c9896395b186f0809da1b0b81d
prerequisite-patch-id: 990fee8b55dae8d26bcf05a953e37988dd83d563
prerequisite-patch-id: 7f95cfaeaed0b5b30206b81691367fa520244526
prerequisite-patch-id: e10506d21bc71ff99db81bf5ab46ddfec98d1fca
prerequisite-patch-id: 8785acb37f7cf6fb62dcbdbf0a14338c04fe342f
-- 
2.49.0

