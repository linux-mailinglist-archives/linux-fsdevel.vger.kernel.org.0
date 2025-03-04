Return-Path: <linux-fsdevel+bounces-43022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD1A4D0A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF973A84A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695377102;
	Tue,  4 Mar 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="n6ePWcnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6aB70U8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4133D8;
	Tue,  4 Mar 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051238; cv=none; b=k1igPSvnZzK9xbc9thmubsNjufi6GSrfXXtsAq0O82ujl6uZx0kmZ+OgfJbei06JGCtLKfJa8R76myh6a5xyVuVgSCrZqciQIr/qDd/Lp9Q9+aL3zLihiLAq1T9stTlzCJZTHd8ZscrxRidy/9ZaxB/akiQ+NOInCKA8zjtIYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051238; c=relaxed/simple;
	bh=rnprk/5LETxlTLSnMEr5WWWk1p2XJoOj2OLwf8W5610=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE5YejLpH4lVrC0fsy3heBpfE/FdcT44K81YfXJNP4hh4JJP8pbjkmA6hbQuYCnrKTzmcZ49EFKUjnaegyz1OvImrFCWG44JV1mRkuRKnIkwM7hwGQAbDgMlsxskKpiQln3miK14QeA1gcExR4JM6vThRiSy5FigZc6Lnjzao5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=n6ePWcnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6aB70U8Q; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailflow.stl.internal (Postfix) with ESMTP id 855681D415DB;
	Mon,  3 Mar 2025 20:20:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 03 Mar 2025 20:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051235; x=
	1741054835; bh=+MQgzypQgiXM4OjRQeqP0MkmEnM9cTUHzJisME6efzM=; b=n
	6ePWcndu8BHT63RinoGWf20O+TfoYO9eKukHH871juG8po0WWVguo/TSvdzW/FV0
	atyeoJ6DnuzZ7sHYAM2D6SyekdBF30VXd/PamXh419nAJPkvsdJ17+6uWucaOC5R
	IjXgE2rgDlzLgwR2jtIt1K5zEfkLbU5Kjx+gsTnjwRYeLabLO1Qv9e6osFexfYTE
	I1xSAWOEgF0gOZFuwH5czXM2WcMOVa6prk8wPScVLDEycLx+KXJ/brcsbTPKdsjs
	RzZ3ZCrdU5i1TGR2hCs7e6GtokQZHvd8+MOVDo172Nl2vrne3hEKrqbJZ1wAJArk
	0kq3VgM84Hu2iwS0/uJ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051235; x=1741054835; bh=+
	MQgzypQgiXM4OjRQeqP0MkmEnM9cTUHzJisME6efzM=; b=6aB70U8Q0+wXTH9wu
	4AInN1MbTjI6oER/o9Ns+u2pbh7gQ0o0cfU7PHxY/0MCodOt7dimForwsiXJaq2Y
	hoV+qPOfD+qwz1GPGsqGjjzZZ5V6cMnyWmuQB4nySaCYx/iMUEPYBIpeZuSUXol4
	gLPDrM/Li6KVg0D2w1kySn2+xNkSZFDon9p6t9ViTSfywIX6FdAzDDdyMu5gTb1S
	+dJXYwEgPnLECsIK9z5ZkUw1J2g+sSs0Ny47h6WQJSKtp4YSnhIJXpsUi5PAKAT6
	yNpEppOVCSwu3fd0ShG1mqxR0m846e0b1ruH5/UyyWlC1MWB/u/wPwM8lFBXFdMn
	/uYMA==
X-ME-Sender: <xms:YlXGZz2WW8GrdyGujd9k2Dx2mjnaT5-296pIKFdUhW8zvLqF3CrNeQ>
    <xme:YlXGZyHiK0urOZulopis2yWLL7zhWJvnidq3EHtE_pG_SshzxH95w6r8S4JzEQXjQ
    jqatFhVVcFQuR51qIc>
X-ME-Received: <xmr:YlXGZz5GpXqXFdLQvBdetRyypzEGk3CXI9S-_vvDh9V-NFb_KrydoUQ5Kg9kPxPKj0y4yr1gkongbMFNQreVH5PmLOaciFH2k36QhU1-yaQxqhLgGMKM7qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtph
    htthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehs
    uhhsvgdrtgiipdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthigthhhosehthi
    gthhhordhpihiiiigr
X-ME-Proxy: <xmx:YlXGZ40Ihn8qGU7m3HjWtO7_4BafgJ1ur1ZZU766V26Vrk1GDnycQw>
    <xmx:Y1XGZ2EWABzNV4q-IuPdKJNwxWO34QWD2rQzGNV74cZez-lzvF6dcw>
    <xmx:Y1XGZ59Jd0CfYwsv4HndPpbHXAtBqRYVreZ7ZBrWQ2N81FpsM2oA6A>
    <xmx:Y1XGZznEINLNe0fBEsXbFg8mgI9q_DvppEj1Op3fOM4hvBl0ElQOVQ>
    <xmx:Y1XGZ74Ef26yzK0aUYF1Mujtno-qzBU56KELVj0pFjHG4goShh9Urkmg>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:20:33 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC PATCH 6/9] Creating supervisor events for filesystem operations
Date: Tue,  4 Mar 2025 01:13:02 +0000
Message-ID: <ed5904af2bdab297f4137a43e44363721894f42f.1741047969.git.m@maowtm.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOTE from future me: This implementation which waits for user response
while blocking inside the current security_path_* hooks is problematic due
to taking exclusive inode lock on the parent directory, and while I have a
proposal for a solution, outlined below, I haven't managed to include the
code for that in this version of the patch. Thus for this commit in
particular I'm probably more looking for suggestions on the approach
rather than code review.  Please see the TODO section at the end of this
message before reviewing this patch.

----

This patch implements a proof-of-concept for modifying the current
landlock LSM hooks to send supervisor events and wait for responses, when
a supervised layer is involved.

In this design, access requests which would end up being denied by other
non-supervised landlock layers (or which would fail the normal inode
permission check anyways - but this is currently TODO, I only thought of
this afterwards) are denied straight away to avoid pointless supervisor
notifications.

Currently current_check_access_path only gets the path of the parent
directory for create/remove operations, which is not enough for what we
want to pass to the supervisor.  Therefore we extend it by passing in any
relevant child dentry (but see TODO below - this may not be possible with
the proper implementation).

This initial implementation doesn't handle links and renames, and for now
these operations behave as if no supervisor is present (and thus will be
denied, unless it is allowed by the layer rules).  Also note that we can
get spurious create requests if the program tries to O_CREAT open an
existing file that exists but not in the dcache (from my understanding).

Event IDs (referred to as an opaque cookie in the uapi) are currently
generated with a simple `next_event_id++`.  I considered using e.g. xarray
but decided to not for this PoC. Suggestions welcome. (Note that we have
to design our own event id even if we use an extension of fanotify, as
fanotify uses a file descriptor to identify events, which is not generic
enough for us)

----

TODO:

When testing this I realized that doing it this way means that for the
create/delete case, we end up holding an exclusive inode lock on the
parent directory while waiting for supervisor to respond (see namei.c -
security_path_mknod is called in may_o_create <- lookup_open which has an
exclusive lock if O_CREAT is passed), which will prevent all other tasks
from accessing that directory (regardless of whether or not they are under
landlock).

This is clearly unacceptable, but since landlock (and also this extension)
doesn't actually need a dentry for the child (which is allocated after the
inode lock), I think this is not unsolvable.  I'm experimenting with
creating a new LSM hook, something like security_pathname_mknod
(suggestions welcome), which will be called after we looked up the dentry
for the parent (to prevent racing symlinks TOCTOU), but before we take the
lock for it.  Such a hook can still take as argument the parent dentry,
plus name of the child (instead of a struct path for it).

Suggestions for alternative approaches are definitely welcome!

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c        | 134 ++++++++++++++++++++++++++++++++--
 security/landlock/supervise.c | 122 +++++++++++++++++++++++++++++++
 security/landlock/supervise.h | 106 ++++++++++++++++++++++++++-
 3 files changed, 354 insertions(+), 8 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 71b9dc331aae..5c147edb6fff 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -44,6 +44,7 @@
 #include "object.h"
 #include "ruleset.h"
 #include "setup.h"
+#include "supervise.h"
 
 /* Underlying object management */
 
@@ -924,10 +925,13 @@ static bool is_access_to_paths_allowed(
 }
 
 static int current_check_access_path(const struct path *const path,
+				     struct dentry *const child,
 				     access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	bool is_remove = !!(access_request & (LANDLOCK_ACCESS_FS_REMOVE_FILE |
+					      LANDLOCK_ACCESS_FS_REMOVE_DIR));
 
 	if (!dom)
 		return 0;
@@ -938,6 +942,29 @@ static int current_check_access_path(const struct path *const path,
 				       NULL, 0, NULL, NULL))
 		return 0;
 
+	if (landlock_has_supervisors(dom)) {
+		layer_mask_t pending_ask_supervise_layers =
+			landlock_layer_masks_to_denied_layers(
+				access_request, layer_masks,
+				sizeof(layer_masks), dom->num_layers);
+
+		WARN_ON_ONCE(!pending_ask_supervise_layers);
+
+		struct path child_path = *path;
+		if (child) {
+			child_path.dentry = child;
+		}
+
+		bool supervisor_allowed = landlock_ask_supervised_layers(
+			dom, pending_ask_supervise_layers,
+			LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS, access_request,
+			&child_path, NULL, child && !is_remove, false, 0);
+
+		if (supervisor_allowed) {
+			return 0;
+		}
+	}
+
 	return -EACCES;
 }
 
@@ -1092,6 +1119,8 @@ static bool collect_domain_accesses(
  * - 0 if access is allowed;
  * - -EXDEV if @old_dentry would inherit new access rights from @new_dir;
  * - -EACCES if file removal or creation is denied.
+ *
+ * TODO: implement interation wiht supervisors.
  */
 static int current_check_refer_path(struct dentry *const old_dentry,
 				    const struct path *const new_dir,
@@ -1415,38 +1444,43 @@ static int hook_path_rename(const struct path *const old_dir,
 static int hook_path_mkdir(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR);
+	return current_check_access_path(dir, dentry,
+					 LANDLOCK_ACCESS_FS_MAKE_DIR);
 }
 
 static int hook_path_mknod(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	return current_check_access_path(dir, get_mode_access(mode));
+	return current_check_access_path(dir, dentry, get_mode_access(mode));
 }
 
 static int hook_path_symlink(const struct path *const dir,
 			     struct dentry *const dentry,
 			     const char *const old_name)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM);
+	return current_check_access_path(dir, dentry,
+					 LANDLOCK_ACCESS_FS_MAKE_SYM);
 }
 
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
+	return current_check_access_path(dir, dentry,
+					 LANDLOCK_ACCESS_FS_REMOVE_FILE);
 }
 
 static int hook_path_rmdir(const struct path *const dir,
 			   struct dentry *const dentry)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
+	return current_check_access_path(dir, dentry,
+					 LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
 static int hook_path_truncate(const struct path *const path)
 {
-	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
+	return current_check_access_path(path, NULL,
+					 LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
 /* File hooks */
@@ -1562,9 +1596,81 @@ static int hook_file_open(struct file *const file)
 	if ((open_access_request & allowed_access) == open_access_request)
 		return 0;
 
+	if (landlock_has_supervisors(dom)) {
+		layer_mask_t pending_ask_supervise_layers =
+			landlock_layer_masks_to_denied_layers(
+				open_access_request, layer_masks,
+				sizeof(layer_masks), dom->num_layers);
+
+		WARN_ON_ONCE(!pending_ask_supervise_layers);
+
+		/*
+		 * We don't need to ask the supervisor for optional
+		 * access right now - we can ask later.
+		 */
+
+		bool supervisor_allowed = landlock_ask_supervised_layers(
+			dom, pending_ask_supervise_layers,
+			LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS,
+			open_access_request, &file->f_path, NULL, false, false,
+			0);
+
+		if (supervisor_allowed) {
+			landlock_file(file)->allowed_access =
+				open_access_request;
+			return 0;
+		}
+	}
+
 	return -EACCES;
 }
 
+/*
+ * For any "optional" permissions (truncate and ioctl) which was
+ * not allowed at time a file was opened, we want to check with
+ * any supervised layers if they actually allow it at the time
+ * the user tries to do such an operation on the opened fd.  We
+ * can check for access on the path (using the opener's domain)
+ * as the opener can never re-gain permissions under landlock.
+ */
+static bool check_opened_file_access_supervisor(struct file *const file,
+						access_mask_t access_request)
+{
+	const struct landlock_ruleset *dom = landlock_get_applicable_domain(
+		landlock_cred(file->f_cred)->domain, any_fs);
+
+	if (landlock_has_supervisors(dom)) {
+		layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+		bool allowed = is_access_to_paths_allowed(
+			dom, &file->f_path,
+			landlock_init_layer_masks(dom, access_request,
+						  &layer_masks,
+						  LANDLOCK_KEY_INODE),
+			&layer_masks, NULL, 0, NULL, NULL);
+		if (allowed) {
+			WARN_ONCE(
+				1,
+				"Access was previously not allowed, now it's allowed in the same domain. Landlock bug?");
+			return false;
+		}
+
+		layer_mask_t pending_ask_supervise_layers =
+			landlock_layer_masks_to_denied_layers(
+				access_request, layer_masks,
+				sizeof(layer_masks), dom->num_layers);
+		WARN_ON_ONCE(!pending_ask_supervise_layers);
+
+		bool supervisor_allowed = landlock_ask_supervised_layers(
+			dom, pending_ask_supervise_layers,
+			LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS, access_request,
+			&file->f_path, NULL, false, false, 0);
+
+		return supervisor_allowed;
+	}
+
+	return false;
+}
+
 static int hook_file_truncate(struct file *const file)
 {
 	/*
@@ -1579,6 +1685,12 @@ static int hook_file_truncate(struct file *const file)
 	 */
 	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_TRUNCATE)
 		return 0;
+
+	if (check_opened_file_access_supervisor(file,
+						LANDLOCK_ACCESS_FS_TRUNCATE)) {
+		return 0;
+	}
+
 	return -EACCES;
 }
 
@@ -1602,6 +1714,11 @@ static int hook_file_ioctl(struct file *file, unsigned int cmd,
 	if (is_masked_device_ioctl(cmd))
 		return 0;
 
+	if (check_opened_file_access_supervisor(file,
+						LANDLOCK_ACCESS_FS_IOCTL_DEV)) {
+		return 0;
+	}
+
 	return -EACCES;
 }
 
@@ -1625,6 +1742,11 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 	if (is_masked_device_ioctl_compat(cmd))
 		return 0;
 
+	if (check_opened_file_access_supervisor(file,
+						LANDLOCK_ACCESS_FS_IOCTL_DEV)) {
+		return 0;
+	}
+
 	return -EACCES;
 }
 
diff --git a/security/landlock/supervise.c b/security/landlock/supervise.c
index a3bb6928f453..3f31a89c4c96 100644
--- a/security/landlock/supervise.c
+++ b/security/landlock/supervise.c
@@ -12,6 +12,12 @@
 
 #include "supervise.h"
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "landlock-supervise: " fmt
+
 struct landlock_supervisor *landlock_create_supervisor(void)
 {
 	struct landlock_supervisor *supervisor;
@@ -70,3 +76,119 @@ void landlock_put_supervisor(struct landlock_supervisor *const supervisor)
 		kfree(supervisor);
 	}
 }
+
+/**
+ * landlock_ask_supervised_layers - check if all denied layers
+ * are supervised, and if yes, ask all of them for permission.
+ *
+ * Return whether access should be allowed.  If denied_layers
+ * contains any non-supervised layer, will return false without
+ * making any supervisor event.
+ *
+ * Caller owns any paths passed in, we might get refs.
+ */
+bool landlock_ask_supervised_layers(
+	const struct landlock_ruleset *const domain,
+	const layer_mask_t denied_layers,
+	const landlock_supervise_event_type_t request_type,
+	const access_mask_t access_request, const struct path *const path1,
+	const struct path *const path2, const bool path1_new,
+	const bool path2_new, const __u16 port)
+{
+	size_t layer_level;
+	unsigned long denied_layers_ = denied_layers;
+
+	if (WARN_ON_ONCE(!denied_layers)) {
+		return true;
+	}
+
+	for_each_set_bit(layer_level, &denied_layers_, domain->num_layers) {
+		if (!domain->layer_stack[layer_level].supervisor) {
+			return false;
+		}
+	}
+
+	/*
+	 * All denied layers are supervisor layers, so we just ask
+	 * them in turn. There's good argument for either order (top
+	 * -> bottom, or the other way), so we just do the easiest
+	 * thing here.
+	 */
+
+	for_each_set_bit(layer_level, &denied_layers_, domain->num_layers) {
+		struct landlock_supervisor *const supervisor =
+			domain->layer_stack[layer_level].supervisor;
+
+		/*
+		 * supervisor will stay valid here because we're blocking
+		 * this thread which references the layer, which in terms
+		 * references the supervisor.
+		 */
+
+		/* TODO: memchg supervisor owner then allocate with account */
+		struct landlock_supervise_event_kernel *event __free(
+			landlock_put_supervise_event) =
+			kzalloc(sizeof(*event), GFP_KERNEL_ACCOUNT);
+
+		int rc;
+
+		if (!event) {
+			pr_alert(
+				"failed to allocate memory for supervisor event\n");
+			return false;
+		}
+
+		refcount_set(&event->usage, 1);
+		event->state = LANDLOCK_SUPERVISE_EVENT_NEW;
+
+		event->type = request_type;
+		event->access_request = access_request;
+		event->accessor = get_pid(task_pid(current));
+		switch (request_type) {
+		case LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS:
+			if (path1) {
+				path_get(path1);
+				event->target_1 = *path1;
+				event->target_1_is_new = path1_new;
+			}
+			if (path2) {
+				path_get(path2);
+				event->target_2 = *path2;
+				event->target_2_is_new = path2_new;
+			}
+			break;
+		case LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS:
+			event->port = port;
+			break;
+		}
+
+		if (WARN_ON(!supervisor)) {
+			/*
+			 * We checked all denied layers are supervised
+			 * earlier...
+			 */
+			return false;
+		}
+
+		spin_lock(&supervisor->lock);
+		event->event_id = supervisor->next_event_id++;
+		landlock_get_supervise_event(event);
+		list_add_tail(&event->node, &supervisor->event_queue);
+		spin_unlock(&supervisor->lock);
+		wake_up(&supervisor->poll_event_wq);
+
+		rc = wait_var_event_killable(
+			event, LANDLOCK_SUPERVISE_EVENT_HANDLED(event));
+		if (rc) {
+			/* Task died, doesn't matter what we say */
+			return false;
+		}
+		if (event->state != LANDLOCK_SUPERVISE_EVENT_ALLOWED) {
+			return false;
+		}
+
+		/* event has __free */
+	}
+
+	return true;
+}
diff --git a/security/landlock/supervise.h b/security/landlock/supervise.h
index febe26a11578..10fc274fabb7 100644
--- a/security/landlock/supervise.h
+++ b/security/landlock/supervise.h
@@ -12,6 +12,7 @@
 #include <linux/wait.h>
 #include <linux/path.h>
 #include <linux/pid.h>
+#include <uapi/linux/landlock.h>
 
 #include "access.h"
 #include "ruleset.h"
@@ -46,9 +47,56 @@ struct landlock_supervise_event_kernel {
 	refcount_t usage;
 	enum landlock_supervise_event_state state;
 
-	/* more fields to come */
+	/* Cookie as presented to user-space */
+	u32 event_id;
+
+	landlock_supervise_event_type_t type;
+	access_mask_t access_request;
+	struct pid *accessor;
+	union {
+		struct {
+			/**
+			 * @target_1: The first (and may be the only, for
+			 * most requests) target path. To expose as much
+			 * useful information to the supervisor as possible,
+			 * for file creation and deletion, this points to the
+			 * actual path being created (or deleted), rather
+			 * than the parent directory. Note that for the
+			 * create case, this means that the dentry will be
+			 * negative (unless we end up in some horrible race).
+			 * In the create case, target_1_is_new is set, so
+			 * that we know to pass the parent as the fd to the
+			 * user-space supervisor, and fill destname with the
+			 * name of the file.
+			 *
+			 * For refer (link and rename), this points to the
+			 * source (or simply the first argument in case of
+			 * exchange) being linked. It will necessarily have
+			 * to be an existing file (even though the dentry may
+			 * turn negative).
+			 */
+			struct path target_1;
+			/**
+			 * @target_2: The destination path for link and
+			 * rename (or simply the second argument in case of
+			 * exchange). target_2_is_new will be set unless this
+			 * is an exchange.
+			 */
+			struct path target_2;
+
+			u8 target_1_is_new : 1;
+			u8 target_2_is_new : 1;
+		};
+		struct {
+			__u16 port;
+		};
+	};
 };
 
+#define LANDLOCK_SUPERVISE_EVENT_HANDLED(event)                \
+	((event)->state == LANDLOCK_SUPERVISE_EVENT_ALLOWED || \
+	 (event)->state == LANDLOCK_SUPERVISE_EVENT_DENIED)
+
 struct landlock_supervisor *landlock_create_supervisor(void);
 void landlock_get_supervisor(struct landlock_supervisor *const supervisor);
 void landlock_put_supervisor(struct landlock_supervisor *const supervisor);
@@ -62,8 +110,62 @@ static inline void landlock_get_supervise_event(
 static inline void landlock_put_supervise_event(
 	struct landlock_supervise_event_kernel *const event)
 {
-	if (refcount_dec_and_test(&event->usage))
+	if (refcount_dec_and_test(&event->usage)) {
+		switch (event->type) {
+		case LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS:
+			if (event->target_1.dentry)
+				path_put(&event->target_1);
+			if (event->target_2.dentry)
+				path_put(&event->target_2);
+			break;
+		case LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS:
+			break;
+		}
+		put_pid(event->accessor);
 		kfree(event);
+	}
+}
+
+DEFINE_FREE(landlock_put_supervise_event,
+	    struct landlock_supervise_event_kernel *,
+	    if (_T) landlock_put_supervise_event(_T))
+
+static inline bool
+landlock_has_supervisors(const struct landlock_ruleset *const domain)
+{
+	size_t layer_level;
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
+		if (domain->layer_stack[layer_level].supervisor)
+			return true;
+	}
+	return false;
 }
 
+static inline layer_mask_t landlock_layer_masks_to_denied_layers(
+	const access_mask_t access_request, const layer_mask_t layer_masks[],
+	const size_t masks_array_size, const int num_layers)
+{
+	unsigned long access_req = access_request;
+	layer_mask_t denied_layers = 0;
+	size_t layer_level;
+	unsigned long access_bit;
+
+	for (layer_level = 0; layer_level < num_layers; layer_level++) {
+		for_each_set_bit(access_bit, &access_req, masks_array_size) {
+			if (layer_masks[access_bit] & BIT_ULL(layer_level))
+				denied_layers |= BIT_ULL(layer_level);
+		}
+	}
+
+	return denied_layers;
+}
+
+bool landlock_ask_supervised_layers(
+	const struct landlock_ruleset *const domain,
+	const layer_mask_t denied_layers,
+	const landlock_supervise_event_type_t request_type,
+	const access_mask_t access_request, const struct path *const path1,
+	const struct path *const path2, const bool path1_new,
+	const bool path2_new, const __u16 port);
+
 #endif /* _SECURITY_LANDLOCK_SUPERVISE_H */
-- 
2.39.5


