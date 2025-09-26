Return-Path: <linux-fsdevel+bounces-62889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E625BA41CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92677AF52E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7808220F21;
	Fri, 26 Sep 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsXMQq7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FAB21CA02;
	Fri, 26 Sep 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896360; cv=none; b=LLcU9vqcKNq+mLXQm7cFQrVZU1bUp0v8DpkA2MYJ8d73dCePu6G0qDzVOhkA6ihSrG1LIuLsQPWaN/L1hwKDJOtuFSRPiy8hIe+ES3VhbNd03PAtJtnwlBYHzbFvIaXvQplmLNDU5YI0zKIJrpYVRv5tyGSFtMh/MW0CykG0jGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896360; c=relaxed/simple;
	bh=+C/HkJwku94cR8IOy39V7bZ85Kdi5zTQzraqYci81fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSKldsbkaxXi/Pz0Y5GtjohcSHXq7GN8tFcUN1rKcFephrsjMAsVrFu5Ztw3lkVFgP7Qfu1jkWKvPE8okB0cKuOVMmgfHc+d5C91hBZeZTONj2Ko3ZxbjAgPg4SiVfH5AGaW7MO9noW+Y0eCtsz7474wmBqbhCPjljdqdPMBOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsXMQq7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD1C19421;
	Fri, 26 Sep 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896359;
	bh=+C/HkJwku94cR8IOy39V7bZ85Kdi5zTQzraqYci81fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsXMQq7L0Rj9++VRszDOPjsOqmvprqtnP5KTETwCpRrCHQhC0r/Y5vwiAl/n3axhD
	 Howb2yH8UXiG1Uh86064Z3p7ELVw05G2zm8v5Cnotm97TLEJnmpWLCMybZi7kbTdqY
	 494FWBR8iymtX3Wn9aukV0Oo3IRqesYqve2jY6FSRgEx/NSyINGjDFl6KNk9a/QuwX
	 hj5PPnVH6eRLzhTaWNSHpnUxeK9Ur5uuyfMCcaZ/h+c+EJaFz5eQKPT4krQlDvMJPS
	 NB1F3idSzfolNZ7ERHjBwwkXlCFXv3c9KO2vYAZXSASe3P9S1WYs6NMztIvJioTB8B
	 yijoQz/zcNpPQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/12 for v6.18] namespaces
Date: Fri, 26 Sep 2025 16:19:04 +0200
Message-ID: <20250926-vfs-namespaces-aaa270353fd5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18477; i=brauner@kernel.org; h=from:subject:message-id; bh=+C/HkJwku94cR8IOy39V7bZ85Kdi5zTQzraqYci81fk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3DxN2/zuWfayev3Me8uPMb7oyj94tPgduPFd+Psz xwuXr/RvaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAisX2MDHfqsqpZtlrKGijK Hfu48f6NZXJLZQt1eTWbrT5enVdWuYKR4WL73WuLNiv9818wp0Yh4nerY0vI/KWz1xWVFLlcDZk xjxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a larger set of changes around the generic namespace
infrastructure of the kernel.

Each specific namespace type (net, cgroup, mnt, ...) embedds a struct
ns_common which carries the reference count of the namespace and so on.

We open-coded and cargo-culted so many quirks for each namespace type
that it just wasn't scalable anymore. So given there's a bunch of new
changes coming in that area I've started cleaning all of this up.

The core change is to make it possible to correctly initialize every
namespace uniformly and derive the correct initialization settings from
the type of the namespace such as namespace operations, namespace type
and so on. This leaves the new ns_common_init() function with a single
parameter which is the specific namespace type which derives the correct
parameters statically. This also means the compiler will yell as soon as
someone does something remotely fishy.

The ns_common_init() addition also allows us to remove ns_alloc_inum()
and drops any special-casing of the initial network namespace in the
network namespace initialization code that Linus complained about.

Another part is reworking the reference counting. The reference counting
was open-coded and copy-pasted for each namespace type even though they
all followed the same rules. This also removes all open accesses to the
reference count and makes it private and only uses a very small set of
dedicated helpers to manipulate them just like we do for e.g., files.

In addition this generalizes the mount namespace iteration
infrastructure introduced a few cycles ago. As reminder, the vfs makes
it possible to iterate sequentially and bidirectionally through all
mount namespaces on the system or all mount namespaces that the caller
holds privilege over. This allow userspace to iterate over all mounts in
all mount namespaces using the listmount() and statmount() system call.

Each mount namespace has a unique identifier for the lifetime of the
systems that is exposed to userspace. The network namespace also has a
unique identifier working exactly the same way. This extends the concept
to all other namespace types.

The new nstree type makes it possible to lookup namespaces purely by
their identifier and to walk the namespace list sequentially and
bidirectionally for all namespace types, allowing userspace to iterate
through all namespaces. Looking up namespaces in the namespace tree
works completely lockless.

This also means we can move the mount namespace onto the generic
infrastructure and remove a bunch of code and members from struct
mnt_namespace itself.

There's a bunch of stuff coming on top of this in the future but for now
this uses the generic namespace tree to extend a concept introduced
first for pidfs a few cycles ago. For a while now we have supported
pidfs file handles for pidfds. This has proven to be very useful.

This extends the concept to cover namespaces as well. It is possible to
encode and decode namespace file handles using the common
name_to_handle_at() and open_by_handle_at() apis.

As with pidfs file handles, namespace file handles are exhaustive,
meaning it is not required to actually hold a reference to nsfs in able
to decode aka open_by_handle_at() a namespace file handle. Instead the
FD_NSFS_ROOT constant can be passed which will let the kernel grab a
reference to the root of nsfs internally and thus decode the file
handle.

Namespaces file descriptors can already be derived from pidfds which
means they aren't subject to overmount protection bugs. IOW, it's
irrelevant if the caller would not have access to an appropriate
/proc/<pid>/ns/ directory as they could always just derive the namespace
based on a pidfd already.

It has the same advantage as pidfds. It's possible to reliably and for
the lifetime of the system refer to a namespace without pinning any
resources and to compare them trivially.

Permission checking is kept simple. If the caller is located in the
namespace the file handle refers to they are able to open it otherwise
they must hold privilege over the owning namespace of the relevant
namespace.

The namespace file handle layout is exposed as uapi and has a stable and
extensible format. For now it simply contains the namespace identifier,
the namespace type, and the inode number. The stable format means that
userspace may construct its own namespace file handles without going
through name_to_handle_at() as they are already allowed for pidfs and
cgroup file handles.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1] This will have merge conflict and requires some minor changes after having
    merged the vfs-6.18-rc1.misc and kernel-6.18-rc1.clone3 pull requests. The
    patch required looks like this:

diff --cc include/linux/cgroup.h
index 56d9556a181a,5156fed8cbc3..000000000000
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@@ -783,52 -784,7 +784,6 @@@ static inline void cgroup_sk_free(struc
  
  #endif	/* CONFIG_CGROUP_DATA */
  
- struct cgroup_namespace {
- 	struct ns_common	ns;
- 	struct user_namespace	*user_ns;
- 	struct ucounts		*ucounts;
- 	struct css_set          *root_cset;
- };
- 
- extern struct cgroup_namespace init_cgroup_ns;
- 
- #ifdef CONFIG_CGROUPS
- 
- void free_cgroup_ns(struct cgroup_namespace *ns);
- 
- struct cgroup_namespace *copy_cgroup_ns(u64 flags,
- 					struct user_namespace *user_ns,
- 					struct cgroup_namespace *old_ns);
- 
- int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
- 		   struct cgroup_namespace *ns);
- 
- static inline void get_cgroup_ns(struct cgroup_namespace *ns)
- {
- 	refcount_inc(&ns->ns.count);
- }
- 
- static inline void put_cgroup_ns(struct cgroup_namespace *ns)
- {
- 	if (refcount_dec_and_test(&ns->ns.count))
- 		free_cgroup_ns(ns);
- }
- 
- #else /* !CONFIG_CGROUPS */
- 
- static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
- static inline struct cgroup_namespace *
- copy_cgroup_ns(u64 flags, struct user_namespace *user_ns,
- 	       struct cgroup_namespace *old_ns)
- {
- 	return old_ns;
- }
- 
- static inline void get_cgroup_ns(struct cgroup_namespace *ns) { }
- static inline void put_cgroup_ns(struct cgroup_namespace *ns) { }
- 
- #endif /* !CONFIG_CGROUPS */
--
  #ifdef CONFIG_CGROUPS
  
  void cgroup_enter_frozen(void);
diff --cc include/linux/ipc_namespace.h
index 4b399893e2b3,21eff63f47da..000000000000
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@@ -129,9 -129,14 +129,14 @@@ static inline int mq_init_ns(struct ipc
  #endif
  
  #if defined(CONFIG_IPC_NS)
 +extern struct ipc_namespace *copy_ipcs(u64 flags,
 +	struct user_namespace *user_ns, struct ipc_namespace *ns);
 +
+ static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
+ {
+ 	return container_of(ns, struct ipc_namespace, ns);
+ }
+ 
 -extern struct ipc_namespace *copy_ipcs(unsigned long flags,
 -	struct user_namespace *user_ns, struct ipc_namespace *ns);
 -
  static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
  {
  	if (ns)
diff --cc include/linux/mnt_namespace.h
index ff290c87b2e7,6d1c4c218c14..000000000000
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@@ -11,7 -11,9 +11,9 @@@ struct fs_struct
  struct user_namespace;
  struct ns_common;
  
+ extern struct mnt_namespace init_mnt_ns;
+ 
 -extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 +extern struct mnt_namespace *copy_mnt_ns(u64, struct mnt_namespace *,
  		struct user_namespace *, struct fs_struct *);
  extern void put_mnt_ns(struct mnt_namespace *ns);
  DEFINE_FREE(put_mnt_ns, struct mnt_namespace *, if (!IS_ERR_OR_NULL(_T)) put_mnt_ns(_T))
diff --cc include/linux/utsname.h
index ba34ec0e2f95,547bd4439706..000000000000
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
diff --git a/fs/proc/root.c b/fs/proc/root.c
index fd1f1c8a939a..1e24e085c7d5 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -143,7 +143,7 @@ static int proc_parse_pidns_param(struct fs_context *fc,
 	if (!proc_ns_file(ns_filp))
 		return invalfc(fc, "pidns argument is not an nsfs file");
 	ns = get_proc_ns(file_inode(ns_filp));
-	if (ns->ops->type != CLONE_NEWPID)
+	if (ns->ns_type != CLONE_NEWPID)
 		return invalfc(fc, "pidns argument is not a pidns file");
 	target = container_of(ns, struct pid_namespace, ns);
 
diff --git a/include/linux/cgroup_namespace.h b/include/linux/cgroup_namespace.h
index 81ccbdee425b..78a8418558a4 100644
--- a/include/linux/cgroup_namespace.h
+++ b/include/linux/cgroup_namespace.h
@@ -22,7 +22,7 @@ static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
 
 void free_cgroup_ns(struct cgroup_namespace *ns);
 
-struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
+struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 					struct user_namespace *user_ns,
 					struct cgroup_namespace *old_ns);
 
@@ -44,7 +44,7 @@ static inline void put_cgroup_ns(struct cgroup_namespace *ns)
 
 static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
 static inline struct cgroup_namespace *
-copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
+copy_cgroup_ns(u64 flags, struct user_namespace *user_ns,
 	       struct cgroup_namespace *old_ns)
 {
 	return old_ns;
diff --git a/include/linux/uts_namespace.h b/include/linux/uts_namespace.h
index 23b4f0e1b338..60f37fec0f4b 100644
--- a/include/linux/uts_namespace.h
+++ b/include/linux/uts_namespace.h
@@ -28,7 +28,7 @@ static inline void get_uts_ns(struct uts_namespace *ns)
 	ns_ref_inc(ns);
 }
 
-extern struct uts_namespace *copy_utsname(unsigned long flags,
+extern struct uts_namespace *copy_utsname(u64 flags,
 	struct user_namespace *user_ns, struct uts_namespace *old_ns);
 extern void free_uts_ns(struct uts_namespace *ns);
 
@@ -48,7 +48,7 @@ static inline void put_uts_ns(struct uts_namespace *ns)
 {
 }
 
-static inline struct uts_namespace *copy_utsname(unsigned long flags,
+static inline struct uts_namespace *copy_utsname(u64 flags,
 	struct user_namespace *user_ns, struct uts_namespace *old_ns)
 {
 	if (flags & CLONE_NEWUTS)

[2] https://lore.kernel.org/linux-next/aNEPxbts2exyK_2A@finisterre.sirena.org.uk

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-6.18-rc1

for you to fetch changes up to 6e65f4e8fc5b02f7a60ebb5b1b83772df0b86663:

  Merge patch series "ns: tweak ns common handling" (2025-09-25 09:23:55 +0200)

Please consider pulling these changes from the signed namespace-6.18-rc1 tag.

Thanks!
Christian

----------------------------------------------------------------
namespace-6.18-rc1

----------------------------------------------------------------
Al Viro (1):
      mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list

Christian Brauner (70):
      pidfs: validate extensible ioctls
      nsfs: drop tautological ioctl() check
      nsfs: validate extensible ioctls
      block: use extensible_ioctl_valid()
      ns: move to_ns_common() to ns_common.h
      nsfs: add nsfs.h header
      ns: uniformly initialize ns_common
      cgroup: use ns_common_init()
      ipc: use ns_common_init()
      mnt: use ns_common_init()
      net: use ns_common_init()
      pid: use ns_common_init()
      time: use ns_common_init()
      user: use ns_common_init()
      uts: use ns_common_init()
      ns: remove ns_alloc_inum()
      nstree: make iterator generic
      Merge branch 'no-rebase-mnt_ns_tree_remove'
      mnt: support ns lookup
      cgroup: support ns lookup
      ipc: support ns lookup
      net: support ns lookup
      pid: support ns lookup
      time: support ns lookup
      user: support ns lookup
      uts: support ns lookup
      ns: add to_<type>_ns() to respective headers
      nsfs: add current_in_namespace()
      nsfs: support file handles
      nsfs: support exhaustive file handles
      nsfs: add missing id retrieval support
      tools: update nsfs.h uapi header
      selftests/namespaces: add identifier selftests
      selftests/namespaces: add file handle selftests
      uts: split namespace into separate header
      Merge patch series "ns: support file handles"
      mnt: expose pointer to init_mnt_ns
      nscommon: move to separate file
      cgroup: split namespace into separate header
      nsfs: add inode number for anon namespace
      mnt: simplify ns_common_init() handling
      net: centralize ns_common initialization
      nscommon: simplify initialization
      ns: add reference count helpers
      mnt: port to ns_ref_*() helpers
      ns: add ns_common_free()
      cgroup: port to ns_ref_*() helpers
      Merge patch series "ns: rework common initialization"
      ipc: port to ns_ref_*() helpers
      pid: port to ns_ref_*() helpers
      time: port to ns_ref_*() helpers
      user: port to ns_ref_*() helpers
      net-sysfs: use check_net()
      net: use check_net()
      ipv4: use check_net()
      uts: port to ns_ref_*() helpers
      net: port to ns_ref_*() helpers
      nsfs: port to ns_ref_*() helpers
      ns: rename to __ns_ref
      Merge patch series "ns: rework reference counting"
      selftests/namespaces: verify initial namespace inode numbers
      ns: use inode initializer for initial namespaces
      cgroup: add missing ns_common include
      ns: simplify ns_common_init() further
      ns: add ns_debug()
      Merge patch series "ns: minor tweaks"
      nstree: make struct ns_tree private
      ns: move ns type into struct ns_common
      ns: drop assert
      Merge patch series "ns: tweak ns common handling"

 block/blk-integrity.c                              |    8 +-
 fs/fhandle.c                                       |    6 +
 fs/internal.h                                      |    1 +
 fs/mount.h                                         |   12 +-
 fs/namespace.c                                     |  196 +--
 fs/nsfs.c                                          |  211 ++-
 fs/pidfs.c                                         |    2 +-
 include/linux/cgroup.h                             |   46 +-
 include/linux/cgroup_namespace.h                   |   58 +
 include/linux/exportfs.h                           |    6 +
 include/linux/fs.h                                 |   14 +
 include/linux/ipc_namespace.h                      |    9 +-
 include/linux/mnt_namespace.h                      |    2 +
 include/linux/ns_common.h                          |  139 +-
 include/linux/nsfs.h                               |   40 +
 include/linux/nsproxy.h                            |   11 -
 include/linux/nstree.h                             |   78 ++
 include/linux/pid_namespace.h                      |    7 +-
 include/linux/proc_ns.h                            |   22 +-
 include/linux/time_namespace.h                     |   13 +-
 include/linux/user_namespace.h                     |    9 +-
 include/linux/uts_namespace.h                      |   65 +
 include/linux/utsname.h                            |   53 +-
 include/net/net_namespace.h                        |   13 +-
 include/uapi/linux/fcntl.h                         |    1 +
 include/uapi/linux/nsfs.h                          |   18 +-
 init/main.c                                        |    2 +
 init/version-timestamp.c                           |    5 +-
 ipc/msgutil.c                                      |    6 +-
 ipc/namespace.c                                    |   19 +-
 ipc/shm.c                                          |    2 +
 kernel/Makefile                                    |    2 +-
 kernel/cgroup/cgroup.c                             |    7 +-
 kernel/cgroup/namespace.c                          |   27 +-
 kernel/nscommon.c                                  |   77 ++
 kernel/nsproxy.c                                   |    4 +-
 kernel/nstree.c                                    |  247 ++++
 kernel/pid.c                                       |    5 +-
 kernel/pid_namespace.c                             |   23 +-
 kernel/time/namespace.c                            |   32 +-
 kernel/user.c                                      |    5 +-
 kernel/user_namespace.c                            |   24 +-
 kernel/utsname.c                                   |   31 +-
 net/core/net-sysfs.c                               |    6 +-
 net/core/net_namespace.c                           |   58 +-
 net/ipv4/inet_timewait_sock.c                      |    4 +-
 net/ipv4/tcp_metrics.c                             |    2 +-
 tools/include/uapi/linux/nsfs.h                    |   17 +-
 tools/testing/selftests/namespaces/.gitignore      |    3 +
 tools/testing/selftests/namespaces/Makefile        |    7 +
 tools/testing/selftests/namespaces/config          |    7 +
 .../selftests/namespaces/file_handle_test.c        | 1429 ++++++++++++++++++++
 tools/testing/selftests/namespaces/init_ino_test.c |   61 +
 tools/testing/selftests/namespaces/nsid_test.c     |  986 ++++++++++++++
 54 files changed, 3677 insertions(+), 461 deletions(-)
 create mode 100644 include/linux/cgroup_namespace.h
 create mode 100644 include/linux/nsfs.h
 create mode 100644 include/linux/nstree.h
 create mode 100644 include/linux/uts_namespace.h
 create mode 100644 kernel/nscommon.c
 create mode 100644 kernel/nstree.c
 create mode 100644 tools/testing/selftests/namespaces/.gitignore
 create mode 100644 tools/testing/selftests/namespaces/Makefile
 create mode 100644 tools/testing/selftests/namespaces/config
 create mode 100644 tools/testing/selftests/namespaces/file_handle_test.c
 create mode 100644 tools/testing/selftests/namespaces/init_ino_test.c
 create mode 100644 tools/testing/selftests/namespaces/nsid_test.c

