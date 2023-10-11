Return-Path: <linux-fsdevel+bounces-94-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DECC7C59A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BC11C20BD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E728DA6;
	Wed, 11 Oct 2023 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arzcOlDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3C1A59F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:55:07 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5978F;
	Wed, 11 Oct 2023 09:55:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b275afb6abso254026966b.1;
        Wed, 11 Oct 2023 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043303; x=1697648103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DTJRcwAQv8n05UmhUrsPHrvrxtaB2I162mMKSQTGWY=;
        b=arzcOlDVE57mCKHFkXtGMNFclut0qp7dz3mv5TkTunwMKpoDCf6EoQ1QSyHYpWPhCH
         lq0DnUhpaUd+kBSRh1qcZCHWZaST1jyf6cMYy1xsYTVzLozczWc4WrupfFKNAWkYeM2D
         ZFQfL37/KyEzZqKpibflalYaDK1a74OvEVhikkCY1EdFRd3g+EAW/G5d4WLRlRkAMm0f
         018l6HdFlnRypeeu61Or3QSvmc1lSRXFG88PnzdPGLcTWqPbqhzfyQy71OxDk3l5cAQ7
         ZA5VsLVrWNM3Y/Ud6nEBCKqqIxdUtNdzSAddhXRNbz+2fg9DEwUdtRWLjaqRoD4Np850
         NjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043303; x=1697648103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DTJRcwAQv8n05UmhUrsPHrvrxtaB2I162mMKSQTGWY=;
        b=PSsEbM/7VWZmJ9dfqAHdgRePGrY2ymVEXKx9+4beQ5FrV4jtS+CiRcmocUQ3waDUJY
         58hcsVli3+094o3EO0gagIfL2HSpFAcS2B8AdGJO2Dknr6Q1JTaJNGMVuxFEw7btM/Pn
         IRV5cNrgbG3DQCgPRNqF6YmQZHoZwq9LGfZRWp2gUIGR17HsbPmrCysBUo17lh2FhtLy
         wHB3JAX7SDjnM8Xo8oEdaLwgRobBqTuf6buOTAjcLj5INWzJ20Hpklw59n790HCxJFD0
         ehshUw9guGx8C7htEtBgHPiZaehtF0emJGlzhpUNKDjtjAbd8ijbmEDwOQM8E4L7H+QX
         tVkg==
X-Gm-Message-State: AOJu0YxurcO0xPE7nM05RBpkQq+ziQowW/CzBTockFOVrGy2/fWzDK/0
	ikneaejTbBK5fPSSbttGqioGZicshw==
X-Google-Smtp-Source: AGHT+IHk37Y7nK/2NE88A5zYqaLykUfR7mcf6spGT+07MJYbo0mqabxIvaPTF/LFZq7F6y07BzMeiw==
X-Received: by 2002:a17:907:96ab:b0:9aa:1dc9:1474 with SMTP id hd43-20020a17090796ab00b009aa1dc91474mr16957331ejc.33.1697043302926;
        Wed, 11 Oct 2023 09:55:02 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id by8-20020a170906a2c800b009b913aa7cdasm10006292ejb.92.2023.10.11.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:55:02 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:55:00 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] *: mark stuff as __ro_after_init
Message-ID: <4f6bb9c0-abba-4ee4-a7aa-89265e886817@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

__read_mostly predates __ro_after_init. Many variables which are marked
__read_mostly should have been __ro_after_init from day 1.

Also, mark some stuff as "const" and "__init" while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/bdev.c                       |    6 +++---
 fs/anon_inodes.c                   |    4 ++--
 fs/buffer.c                        |    4 ++--
 fs/char_dev.c                      |    2 +-
 fs/dcache.c                        |    8 ++++----
 fs/direct-io.c                     |    2 +-
 fs/eventpoll.c                     |    6 +++---
 fs/fcntl.c                         |    2 +-
 fs/file.c                          |    4 ++--
 fs/file_table.c                    |    2 +-
 fs/inode.c                         |    8 ++++----
 fs/kernfs/mount.c                  |    5 +++--
 fs/locks.c                         |    4 ++--
 fs/namespace.c                     |   16 ++++++++--------
 fs/notify/dnotify/dnotify.c        |    6 +++---
 fs/notify/fanotify/fanotify_user.c |    8 ++++----
 fs/notify/inotify/inotify_user.c   |    2 +-
 fs/pipe.c                          |    2 +-
 fs/userfaultfd.c                   |    2 +-
 include/linux/file.h               |    3 ++-
 kernel/audit_tree.c                |    4 ++--
 kernel/sched/core.c                |    2 +-
 kernel/user_namespace.c            |    2 +-
 kernel/workqueue.c                 |   16 ++++++++--------
 lib/debugobjects.c                 |    2 +-
 mm/khugepaged.c                    |    2 +-
 mm/shmem.c                         |    8 ++++----
 security/integrity/iint.c          |    2 +-
 28 files changed, 68 insertions(+), 66 deletions(-)

--- a/block/bdev.c
+++ b/block/bdev.c
@@ -292,7 +292,7 @@ EXPORT_SYMBOL(thaw_bdev);
  */
 
 static  __cacheline_aligned_in_smp DEFINE_MUTEX(bdev_lock);
-static struct kmem_cache * bdev_cachep __read_mostly;
+static struct kmem_cache * bdev_cachep __ro_after_init;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
@@ -361,13 +361,13 @@ static struct file_system_type bd_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-struct super_block *blockdev_superblock __read_mostly;
+struct super_block *blockdev_superblock __ro_after_init;
 EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
 {
 	int err;
-	static struct vfsmount *bd_mnt;
+	static struct vfsmount *bd_mnt __ro_after_init;
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -24,8 +24,8 @@
 
 #include <linux/uaccess.h>
 
-static struct vfsmount *anon_inode_mnt __read_mostly;
-static struct inode *anon_inode_inode;
+static struct vfsmount *anon_inode_mnt __ro_after_init;
+static struct inode *anon_inode_inode __ro_after_init;
 
 /*
  * anon_inodefs_dname() is called from d_path().
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2988,13 +2988,13 @@ EXPORT_SYMBOL(try_to_free_buffers);
 /*
  * Buffer-head allocation
  */
-static struct kmem_cache *bh_cachep __read_mostly;
+static struct kmem_cache *bh_cachep __ro_after_init;
 
 /*
  * Once the number of bh's in the machine exceeds this level, we start
  * stripping them in writeback.
  */
-static unsigned long max_buffer_heads;
+static unsigned long max_buffer_heads __ro_after_init;
 
 int buffer_heads_over_limit;
 
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -25,7 +25,7 @@
 
 #include "internal.h"
 
-static struct kobj_map *cdev_map;
+static struct kobj_map *cdev_map __ro_after_init;
 
 static DEFINE_MUTEX(chrdevs_lock);
 
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -78,7 +78,7 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
-static struct kmem_cache *dentry_cache __read_mostly;
+static struct kmem_cache *dentry_cache __ro_after_init;
 
 const struct qstr empty_name = QSTR_INIT("", 0);
 EXPORT_SYMBOL(empty_name);
@@ -96,9 +96,9 @@ EXPORT_SYMBOL(dotdot_name);
  * information, yet avoid using a prime hash-size or similar.
  */
 
-static unsigned int d_hash_shift __read_mostly;
+static unsigned int d_hash_shift __ro_after_init;
 
-static struct hlist_bl_head *dentry_hashtable __read_mostly;
+static struct hlist_bl_head *dentry_hashtable __ro_after_init;
 
 static inline struct hlist_bl_head *d_hash(unsigned int hash)
 {
@@ -3324,7 +3324,7 @@ static void __init dcache_init(void)
 }
 
 /* SLAB cache for __getname() consumers */
-struct kmem_cache *names_cachep __read_mostly;
+struct kmem_cache *names_cachep __ro_after_init;
 EXPORT_SYMBOL(names_cachep);
 
 void __init vfs_caches_init_early(void)
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -151,7 +151,7 @@ struct dio {
 	};
 } ____cacheline_aligned_in_smp;
 
-static struct kmem_cache *dio_cache __read_mostly;
+static struct kmem_cache *dio_cache __ro_after_init;
 
 /*
  * How many pages are in the queue?
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -256,10 +256,10 @@ static u64 loop_check_gen = 0;
 static struct eventpoll *inserting_into;
 
 /* Slab cache used to allocate "struct epitem" */
-static struct kmem_cache *epi_cache __read_mostly;
+static struct kmem_cache *epi_cache __ro_after_init;
 
 /* Slab cache used to allocate "struct eppoll_entry" */
-static struct kmem_cache *pwq_cache __read_mostly;
+static struct kmem_cache *pwq_cache __ro_after_init;
 
 /*
  * List of files with newly added links, where we may need to limit the number
@@ -271,7 +271,7 @@ struct epitems_head {
 };
 static struct epitems_head *tfile_check_list = EP_UNACTIVE_PTR;
 
-static struct kmem_cache *ephead_cache __read_mostly;
+static struct kmem_cache *ephead_cache __ro_after_init;
 
 static inline void free_ephead(struct epitems_head *head)
 {
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -844,7 +844,7 @@ int send_sigurg(struct fown_struct *fown)
 }
 
 static DEFINE_SPINLOCK(fasync_lock);
-static struct kmem_cache *fasync_cache __read_mostly;
+static struct kmem_cache *fasync_cache __ro_after_init;
 
 static void fasync_free_rcu(struct rcu_head *head)
 {
--- a/fs/file.c
+++ b/fs/file.c
@@ -25,10 +25,10 @@
 #include "internal.h"
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
-unsigned int sysctl_nr_open_min = BITS_PER_LONG;
+const unsigned int sysctl_nr_open_min = BITS_PER_LONG;
 /* our min() is unusable in constant expressions ;-/ */
 #define __const_min(x, y) ((x) < (y) ? (x) : (y))
-unsigned int sysctl_nr_open_max =
+const unsigned int sysctl_nr_open_max =
 	__const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
 
 static void __free_fdtable(struct fdtable *fdt)
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -40,7 +40,7 @@ static struct files_stat_struct files_stat = {
 };
 
 /* SLAB cache for file structures */
-static struct kmem_cache *filp_cachep __read_mostly;
+static struct kmem_cache *filp_cachep __ro_after_init;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -54,9 +54,9 @@
  *   inode_hash_lock
  */
 
-static unsigned int i_hash_mask __read_mostly;
-static unsigned int i_hash_shift __read_mostly;
-static struct hlist_head *inode_hashtable __read_mostly;
+static unsigned int i_hash_mask __ro_after_init;
+static unsigned int i_hash_shift __ro_after_init;
+static struct hlist_head *inode_hashtable __ro_after_init;
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
 
 /*
@@ -70,7 +70,7 @@ EXPORT_SYMBOL(empty_aops);
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
 
-static struct kmem_cache *inode_cachep __read_mostly;
+static struct kmem_cache *inode_cachep __ro_after_init;
 
 static long get_nr_inodes(void)
 {
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -21,8 +21,9 @@
 
 #include "kernfs-internal.h"
 
-struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
-struct kernfs_global_locks *kernfs_locks;
+struct kmem_cache *kernfs_node_cache __ro_after_init;
+struct kmem_cache *kernfs_iattrs_cache __ro_after_init;
+struct kernfs_global_locks *kernfs_locks __ro_after_init;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -167,8 +167,8 @@ static DEFINE_HASHTABLE(blocked_hash, BLOCKED_HASH_BITS);
  */
 static DEFINE_SPINLOCK(blocked_lock_lock);
 
-static struct kmem_cache *flctx_cache __read_mostly;
-static struct kmem_cache *filelock_cache __read_mostly;
+static struct kmem_cache *flctx_cache __ro_after_init;
+static struct kmem_cache *filelock_cache __ro_after_init;
 
 static struct file_lock_context *
 locks_get_lock_context(struct inode *inode, int type)
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -39,10 +39,10 @@
 /* Maximum number of mounts in a mount namespace */
 static unsigned int sysctl_mount_max __read_mostly = 100000;
 
-static unsigned int m_hash_mask __read_mostly;
-static unsigned int m_hash_shift __read_mostly;
-static unsigned int mp_hash_mask __read_mostly;
-static unsigned int mp_hash_shift __read_mostly;
+static unsigned int m_hash_mask __ro_after_init;
+static unsigned int m_hash_shift __ro_after_init;
+static unsigned int mp_hash_mask __ro_after_init;
+static unsigned int mp_hash_shift __ro_after_init;
 
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
@@ -68,9 +68,9 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
-static struct hlist_head *mount_hashtable __read_mostly;
-static struct hlist_head *mountpoint_hashtable __read_mostly;
-static struct kmem_cache *mnt_cache __read_mostly;
+static struct hlist_head *mount_hashtable __ro_after_init;
+static struct hlist_head *mountpoint_hashtable __ro_after_init;
+static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -86,7 +86,7 @@ struct mount_kattr {
 };
 
 /* /sys/fs */
-struct kobject *fs_kobj;
+struct kobject *fs_kobj __ro_after_init;
 EXPORT_SYMBOL_GPL(fs_kobj);
 
 /*
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -39,9 +39,9 @@ static void __init dnotify_sysctl_init(void)
 #define dnotify_sysctl_init() do { } while (0)
 #endif
 
-static struct kmem_cache *dnotify_struct_cache __read_mostly;
-static struct kmem_cache *dnotify_mark_cache __read_mostly;
-static struct fsnotify_group *dnotify_group __read_mostly;
+static struct kmem_cache *dnotify_struct_cache __ro_after_init;
+static struct kmem_cache *dnotify_mark_cache __ro_after_init;
+static struct fsnotify_group *dnotify_group __ro_after_init;
 
 /*
  * dnotify will attach one of these to each inode (i_fsnotify_marks) which
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -112,10 +112,10 @@ static void __init fanotify_sysctls_init(void)
 
 extern const struct fsnotify_ops fanotify_fsnotify_ops;
 
-struct kmem_cache *fanotify_mark_cache __read_mostly;
-struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
-struct kmem_cache *fanotify_path_event_cachep __read_mostly;
-struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
+struct kmem_cache *fanotify_mark_cache __ro_after_init;
+struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -49,7 +49,7 @@
 /* configurable via /proc/sys/fs/inotify/ */
 static int inotify_max_queued_events __read_mostly;
 
-struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
+struct kmem_cache *inotify_inode_mark_cachep __ro_after_init;
 
 #ifdef CONFIG_SYSCTL
 
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -854,7 +854,7 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	kfree(pipe);
 }
 
-static struct vfsmount *pipe_mnt __read_mostly;
+static struct vfsmount *pipe_mnt __ro_after_init;
 
 /*
  * pipefs_dname() is called from d_path().
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -49,7 +49,7 @@ static struct ctl_table vm_userfaultfd_table[] = {
 };
 #endif
 
-static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
+static struct kmem_cache *userfaultfd_ctx_cachep __ro_after_init;
 
 /*
  * Start with fault_pending_wqh and fault_wqh so they're more likely
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -113,6 +113,7 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
-extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
+extern const unsigned int sysctl_nr_open_min;
+extern const unsigned int sysctl_nr_open_max;
 
 #endif /* __LINUX_FILE_H */
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -87,8 +87,8 @@ static struct task_struct *prune_thread;
  * that makes a difference.  Some.
  */
 
-static struct fsnotify_group *audit_tree_group;
-static struct kmem_cache *audit_tree_mark_cachep __read_mostly;
+static struct fsnotify_group *audit_tree_group __ro_after_init;
+static struct kmem_cache *audit_tree_mark_cachep __ro_after_init;
 
 static struct audit_tree *alloc_tree(const char *s)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9903,7 +9903,7 @@ struct task_group root_task_group;
 LIST_HEAD(task_groups);
 
 /* Cacheline aligned slab cache for task_group */
-static struct kmem_cache *task_group_cache __read_mostly;
+static struct kmem_cache *task_group_cache __ro_after_init;
 #endif
 
 void __init sched_init(void)
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -22,7 +22,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 
-static struct kmem_cache *user_ns_cachep __read_mostly;
+static struct kmem_cache *user_ns_cachep __ro_after_init;
 static DEFINE_MUTEX(userns_state_mutex);
 
 static bool new_idmap_permitted(const struct file *file,
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -418,21 +418,21 @@ static struct workqueue_attrs *ordered_wq_attrs[NR_STD_WORKER_POOLS];
  * process context while holding a pool lock. Bounce to a dedicated kthread
  * worker to avoid A-A deadlocks.
  */
-static struct kthread_worker *pwq_release_worker;
+static struct kthread_worker *pwq_release_worker __ro_after_init;
 
-struct workqueue_struct *system_wq __read_mostly;
+struct workqueue_struct *system_wq __ro_after_init;
 EXPORT_SYMBOL(system_wq);
-struct workqueue_struct *system_highpri_wq __read_mostly;
+struct workqueue_struct *system_highpri_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_highpri_wq);
-struct workqueue_struct *system_long_wq __read_mostly;
+struct workqueue_struct *system_long_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_long_wq);
-struct workqueue_struct *system_unbound_wq __read_mostly;
+struct workqueue_struct *system_unbound_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_unbound_wq);
-struct workqueue_struct *system_freezable_wq __read_mostly;
+struct workqueue_struct *system_freezable_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_freezable_wq);
-struct workqueue_struct *system_power_efficient_wq __read_mostly;
+struct workqueue_struct *system_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_power_efficient_wq);
-struct workqueue_struct *system_freezable_power_efficient_wq __read_mostly;
+struct workqueue_struct *system_freezable_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 
 static int worker_thread(void *__worker);
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -89,7 +89,7 @@ static int			debug_objects_pool_size __read_mostly
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static const struct debug_obj_descr *descr_test  __read_mostly;
-static struct kmem_cache	*obj_cache __read_mostly;
+static struct kmem_cache	*obj_cache __ro_after_init;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -91,7 +91,7 @@ static unsigned int khugepaged_max_ptes_shared __read_mostly;
 #define MM_SLOTS_HASH_BITS 10
 static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
-static struct kmem_cache *mm_slot_cache __read_mostly;
+static struct kmem_cache *mm_slot_cache __ro_after_init;
 
 struct collapse_control {
 	bool is_khugepaged;
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -42,7 +42,7 @@
 #include <linux/iversion.h>
 #include "swap.h"
 
-static struct vfsmount *shm_mnt;
+static struct vfsmount *shm_mnt __ro_after_init;
 
 #ifdef CONFIG_SHMEM
 /*
@@ -4394,7 +4394,7 @@ static const struct fs_context_operations shmem_fs_context_ops = {
 #endif
 };
 
-static struct kmem_cache *shmem_inode_cachep;
+static struct kmem_cache *shmem_inode_cachep __ro_after_init;
 
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
@@ -4426,14 +4426,14 @@ static void shmem_init_inode(void *foo)
 	inode_init_once(&info->vfs_inode);
 }
 
-static void shmem_init_inodecache(void)
+static void __init shmem_init_inodecache(void)
 {
 	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
 				sizeof(struct shmem_inode_info),
 				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
 }
 
-static void shmem_destroy_inodecache(void)
+static void __init shmem_destroy_inodecache(void)
 {
 	kmem_cache_destroy(shmem_inode_cachep);
 }
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -23,7 +23,7 @@
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
 static DEFINE_RWLOCK(integrity_iint_lock);
-static struct kmem_cache *iint_cache __read_mostly;
+static struct kmem_cache *iint_cache __ro_after_init;
 
 struct dentry *integrity_dir;
 

