Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7267017E998
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 21:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCIUCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 16:02:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39289 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgCIUCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:02:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id r15so7779662wrx.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeVljPhdhm9ParDwUu6Afw+/yj3piLrvxp5QA9qZTWo=;
        b=UimHgY9sfsdwIog/RfGtanXf+VpKrQzYurewI3Q3RTgrSV70n8rwFqSzKXiNCkJJlT
         QDL1SfYxtHh9Xqsky2bsFb+k+VNaGFac7Dfp2DQBlt34tThRF+JOa5vDWdNE8mCqZP8S
         DemojXkp1IopF6AFCJRL/UHJO4cbrGOuky9Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeVljPhdhm9ParDwUu6Afw+/yj3piLrvxp5QA9qZTWo=;
        b=iZizV9rsJBafTQUdnmtzRzpRJGIT8ZJ2VTn05bVvPsTS+y2eV0NnzcsPwMZlNo++4x
         j0ltfWutq8NdhiY1o+4bQJYtEKjy0rhidDHYnQ6bZmhPR7RLqT61iZ5LXhFKlNkrOyaT
         KFxXM1m7vzzt59yTj7jCL0uwlNSByGUXVT3NPrT4qJj/t8Ly+63/KGicumC2pd5JlcNz
         14HsQ4wpwtatAzNtKZMFwfvp2bxJ977wLS2KZzBEPePDOWribtP1wSuTOZxsblVmTAtW
         MCsqoeGR48Q90qgCMZwigW1KfvC1bX7m4B2Fwzvv63fmA536Rxv1VtsxeQmSB6x7Fsux
         /m3Q==
X-Gm-Message-State: ANhLgQ3A/U76D6uRmz14DjH2/SkAKUymzWxpRQr3HdkSG9AiI+BfUqsl
        ejyF5NwmgBqojkIiouvqSk8Myg==
X-Google-Smtp-Source: ADFU+vsjztKUGx6uit4tsErKeLsBF+UuOreNow/86Lo18dDQLK56ztwzQc4Vjf4ZRD5hkh66oWipKQ==
X-Received: by 2002:adf:f544:: with SMTP id j4mr15651347wrp.183.1583784161804;
        Mon, 09 Mar 2020 13:02:41 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id i1sm44388317wrs.18.2020.03.09.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:02:41 -0700 (PDT)
Date:   Mon, 9 Mar 2020 21:02:38 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Theodore Ts'o <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
Message-ID: <20200309200238.GB28467@miu.piliscsaba.redhat.com>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:00:46PM +0000, David Howells wrote:
> ============================
> WHY NOT USE PROCFS OR SYSFS?
> ============================

And here's the updated patch (hopefully addressed all of Al's concerns)
that uses procfs and a new mountfs.

Get mountinfo from open file:

  cat /proc/$PID/fdmount/$FD/*

Get mountinfo by mount ID:

  mount -t mountfs mountfs /mountfs
  cat /mountfs/$MNT_ID/*

> Why is it better to go with a new system call rather than adding more magic
> stuff to /proc or /sysfs for each superblock object and each mount object?
> 
>  (1) It can be targetted.  It makes it easy to query directly by path or
>      fd, but can also query by mount ID or fscontext fd.  procfs and sysfs
>      cannot do three of these things easily.

See above: with the addition of open(path, O_PATH) it can do all of these.

> 
>  (2) Easier to provide LSM oversight.  Is the accessing process allowed to
>      query information pertinent to a particular file?

Not quite sure why this would be easier for a new ad-hoc interface than for
the well established filesystem API.

> 
>  (3) It's more efficient as we can return specific binary data rather than
>      making huge text dumps.  Granted, sysfs and procfs could present the
>      same data, though as lots of little files which have to be
>      individually opened, read, closed and parsed.
> 
>  (4) We wouldn't have the overhead of open and close (even adding a
>      self-contained readfile() syscall has to do that internally).
> 
>  (5) Opening a file in procfs or sysfs has a pathwalk overhead for each
>      file accessed.  We can use an integer attribute ID instead (yes, this
>      is similar to ioctl) - but could also use a string ID if that is
>      preferred.

Is that super-high performance really warranted?  What would be the
application of that?

> 
>  (6) Can query cross-namespace if, say, a container manager process is
>      given an fs_context that hasn't yet been mounted into a namespace - or
>      hasn't even been fully created yet.

This patch can do that too.

> 
>  (7) Don't have to create/delete a bunch of sysfs/procfs nodes each time a
>      mount happens or is removed - and since systemd makes much use of
>      mount namespaces and mount propagation, this will create a lot of
>      nodes.

This patch creates a single struct mountfs_entry per mount, which is 48bytes.

Now onto the advantages of a filesystem based API:

 - immediately usable from all programming languages, including scripts

 - same goes for future extensions: no need to update libc, utils, language
   bindings, strace, etc...

Thanks,
Miklos

---
 fs/Makefile              |    1 
 fs/mount.h               |    8 
 fs/mountfs/Makefile      |    1 
 fs/mountfs/super.c       |  502 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c           |   31 ++
 fs/proc/base.c           |    2 
 fs/proc/fd.c             |   82 +++++++
 fs/proc/fd.h             |    3 
 fs/proc_namespace.c      |   22 --
 fs/seq_file.c            |   23 ++
 include/linux/seq_file.h |    1 
 11 files changed, 654 insertions(+), 22 deletions(-)

--- a/fs/Makefile
+++ b/fs/Makefile
@@ -135,3 +135,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-y				+= mountfs/
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,6 +72,7 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+	struct mountfs_entry *mnt_mountfs_entry;
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
@@ -153,3 +154,10 @@ static inline bool is_anon_ns(struct mnt
 {
 	return ns->seq == 0;
 }
+
+void mnt_namespace_lock_read(void);
+void mnt_namespace_unlock_read(void);
+
+void mountfs_create(struct mount *mnt);
+extern void mountfs_remove(struct mount *mnt);
+int mountfs_lookup_internal(struct vfsmount *m, struct path *path);
--- /dev/null
+++ b/fs/mountfs/Makefile
@@ -0,0 +1 @@
+obj-y				+= super.o
--- /dev/null
+++ b/fs/mountfs/super.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../pnode.h"
+#include <linux/fs.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <linux/fs_struct.h>
+#include <linux/fs_context.h>
+
+#define MOUNTFS_SUPER_MAGIC 0x4e756f4d
+
+static DEFINE_SPINLOCK(mountfs_lock);
+static struct rb_root mountfs_entries = RB_ROOT;
+static struct vfsmount *mountfs_mnt __read_mostly;
+
+struct mountfs_entry {
+	struct kref kref;
+	struct mount *mnt;
+	struct rb_node node;
+	int id;
+};
+
+static const char *mountfs_attrs[] = {
+	"root", "mountpoint", "id", "parent", "options", "children",
+	"group", "master", "propagate_from"
+};
+
+#define MOUNTFS_INO(id) (((unsigned long) id + 1) * \
+			 (ARRAY_SIZE(mountfs_attrs) + 1))
+
+void mountfs_entry_release(struct kref *kref)
+{
+	kfree(container_of(kref, struct mountfs_entry, kref));
+}
+
+void mountfs_entry_put(struct mountfs_entry *entry)
+{
+	kref_put(&entry->kref, mountfs_entry_release);
+}
+
+static bool mountfs_entry_visible(struct mountfs_entry *entry)
+{
+	struct mount *mnt;
+	bool visible = false;
+
+	rcu_read_lock();
+	mnt = rcu_dereference(entry->mnt);
+	if (mnt && mnt->mnt_ns == current->nsproxy->mnt_ns)
+		visible = true;
+	rcu_read_unlock();
+
+	return visible;
+}
+static int mountfs_attr_show(struct seq_file *sf, void *v)
+{
+	const char *name = sf->file->f_path.dentry->d_name.name;
+	struct mountfs_entry *entry = sf->private;
+	struct mount *mnt;
+	struct vfsmount *m;
+	struct super_block *sb;
+	struct path root;
+	int tmp, err = -ENODEV;
+
+	mnt_namespace_lock_read();
+
+	mnt = entry->mnt;
+	if (!mnt || !mnt->mnt_ns)
+		goto out;
+
+	err = 0;
+	m = &mnt->mnt;
+	sb = m->mnt_sb;
+
+	if (strcmp(name, "root") == 0) {
+		if (sb->s_op->show_path) {
+			err = sb->s_op->show_path(sf, m->mnt_root);
+		} else {
+			seq_dentry(sf, m->mnt_root, " \t\n\\");
+		}
+		seq_putc(sf, '\n');
+	} else if (strcmp(name, "mountpoint") == 0) {
+		struct path mnt_path = { .dentry = m->mnt_root, .mnt = m };
+
+		get_fs_root(current->fs, &root);
+		err = seq_path_root(sf, &mnt_path, &root, " \t\n\\");
+		if (err == SEQ_SKIP) {
+			seq_puts(sf, "(unreachable)");
+			err = 0;
+		}
+		seq_putc(sf, '\n');
+		path_put(&root);
+	} else if (strcmp(name, "id") == 0) {
+		seq_printf(sf, "%i\n", mnt->mnt_id);
+	} else if (strcmp(name, "parent") == 0) {
+		tmp = rcu_dereference(mnt->mnt_parent)->mnt_id;
+		seq_printf(sf, "%i\n", tmp);
+	} else if (strcmp(name, "options") == 0) {
+		int mnt_flags = READ_ONCE(m->mnt_flags);
+
+		seq_puts(sf, mnt_flags & MNT_READONLY ? "ro" : "rw");
+		seq_mnt_opts(sf, mnt_flags);
+		seq_putc(sf, '\n');
+	} else if (strcmp(name, "children") == 0) {
+		struct mount *child;
+		bool first = true;
+
+		list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
+			if (!first)
+				seq_putc(sf, ',');
+			else
+				first = false;
+			seq_printf(sf, "%i", child->mnt_id);
+		}
+		if (!first)
+			seq_putc(sf, '\n');
+	} else if (strcmp(name, "group") == 0) {
+		if (IS_MNT_SHARED(mnt))
+			seq_printf(sf, "%i\n", mnt->mnt_group_id);
+	} else if (strcmp(name, "master") == 0) {
+		if (IS_MNT_SLAVE(mnt)) {
+			tmp = rcu_dereference(mnt->mnt_master)->mnt_group_id;
+			seq_printf(sf, "%i\n", tmp);
+		}
+	} else if (strcmp(name, "propagate_from") == 0) {
+		if (IS_MNT_SLAVE(mnt)) {
+			get_fs_root(current->fs, &root);
+			tmp = get_dominating_id(mnt, &root);
+			if (tmp)
+				seq_printf(sf, "%i\n", tmp);
+		}
+	} else {
+		WARN_ON(1);
+		err = -EIO;
+	}
+out:
+	mnt_namespace_unlock_read();
+
+	return err;
+}
+
+static int mountfs_attr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mountfs_attr_show, inode->i_private);
+}
+
+static const struct file_operations mountfs_attr_fops = {
+	.open		= mountfs_attr_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static struct mountfs_entry *mountfs_node_to_entry(struct rb_node *node)
+{
+	return rb_entry(node, struct mountfs_entry, node);
+}
+
+static struct rb_node **mountfs_find_node(int id, struct rb_node **parent)
+{
+	struct rb_node **link = &mountfs_entries.rb_node;
+
+	*parent = NULL;
+	while (*link) {
+		struct mountfs_entry *entry = mountfs_node_to_entry(*link);
+
+		*parent = *link;
+		if (id < entry->id)
+			link = &entry->node.rb_left;
+		else if (id > entry->id)
+			link = &entry->node.rb_right;
+		else
+			break;
+	}
+	return link;
+}
+
+void mountfs_create(struct mount *mnt)
+{
+	struct mountfs_entry *entry;
+	struct rb_node **link, *parent;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		WARN(1, "failed to allocate mountfs entry");
+		return;
+	}
+	kref_init(&entry->kref);
+	entry->mnt = mnt;
+	entry->id = mnt->mnt_id;
+
+	spin_lock(&mountfs_lock);
+	link = mountfs_find_node(entry->id, &parent);
+	if (!WARN_ON(*link)) {
+		rb_link_node(&entry->node, parent, link);
+		rb_insert_color(&entry->node, &mountfs_entries);
+		mnt->mnt_mountfs_entry = entry;
+	} else {
+		kfree(entry);
+	}
+	spin_unlock(&mountfs_lock);
+}
+
+void mountfs_remove(struct mount *mnt)
+{
+	struct mountfs_entry *entry = mnt->mnt_mountfs_entry;
+
+	if (!entry)
+		return;
+	spin_lock(&mountfs_lock);
+	entry->mnt = NULL;
+	rb_erase(&entry->node, &mountfs_entries);
+	spin_unlock(&mountfs_lock);
+
+	mountfs_entry_put(entry);
+
+	mnt->mnt_mountfs_entry = NULL;
+}
+
+static struct mountfs_entry *mountfs_get_entry(const char *name)
+{
+	struct mountfs_entry *entry = NULL;
+	struct rb_node **link, *dummy;
+	unsigned long mnt_id;
+	char buf[32];
+	int ret;
+
+	ret = kstrtoul(name, 10, &mnt_id);
+	if (ret || mnt_id > INT_MAX)
+		return NULL;
+
+	snprintf(buf, sizeof(buf), "%lu", mnt_id);
+	if (strcmp(buf, name) != 0)
+		return NULL;
+
+	spin_lock(&mountfs_lock);
+	link = mountfs_find_node(mnt_id, &dummy);
+	if (*link) {
+		entry = mountfs_node_to_entry(*link);
+		if (!mountfs_entry_visible(entry))
+			entry = NULL;
+		else
+			kref_get(&entry->kref);
+	}
+	spin_unlock(&mountfs_lock);
+
+	return entry;
+}
+
+static void mountfs_init_inode(struct inode *inode, umode_t mode);
+
+static struct dentry *mountfs_lookup_entry(struct dentry *dentry,
+					   struct mountfs_entry *entry,
+					   int idx)
+{
+	struct inode *inode;
+
+	inode = new_inode(dentry->d_sb);
+	if (!inode) {
+		mountfs_entry_put(entry);
+		return ERR_PTR(-ENOMEM);
+	}
+	inode->i_private = entry;
+	inode->i_ino = MOUNTFS_INO(entry->id) + idx;
+	mountfs_init_inode(inode, idx ? S_IFREG | 0444 : S_IFDIR | 0555);
+	return d_splice_alias(inode, dentry);
+
+}
+
+static struct dentry *mountfs_lookup(struct inode *dir, struct dentry *dentry,
+				     unsigned int flags)
+{
+	struct mountfs_entry *entry = dir->i_private;
+	int i = 0;
+
+	if (entry) {
+		for (i = 0; i < ARRAY_SIZE(mountfs_attrs); i++)
+			if (strcmp(mountfs_attrs[i], dentry->d_name.name) == 0)
+				break;
+		if (i == ARRAY_SIZE(mountfs_attrs))
+			return ERR_PTR(-ENOMEM);
+		i++;
+		kref_get(&entry->kref);
+	} else {
+		entry = mountfs_get_entry(dentry->d_name.name);
+		if (!entry)
+			return ERR_PTR(-ENOENT);
+	}
+
+	return mountfs_lookup_entry(dentry, entry, i);
+}
+
+static int mountfs_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct mountfs_entry *entry = dentry->d_inode->i_private;
+
+	/* root: valid */
+	if (!entry)
+		return 1;
+
+	/* removed: invalid */
+	if (!entry->mnt)
+		return 0;
+
+	/* attribute or visible in this namespace: valid */
+	if (!d_can_lookup(dentry) || mountfs_entry_visible(entry))
+		return 1;
+
+	/* invlisible in this namespace: valid but deny entry*/
+	return -ENOENT;
+}
+
+static int mountfs_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct rb_node *node;
+	struct mountfs_entry *entry = file_inode(file)->i_private;
+	char name[32];
+	const char *s;
+	unsigned int len, pos, id;
+
+	if (ctx->pos - 2 > INT_MAX || !dir_emit_dots(file, ctx))
+		return 0;
+
+	if (entry) {
+		while (ctx->pos - 2 < ARRAY_SIZE(mountfs_attrs)) {
+			s = mountfs_attrs[ctx->pos - 2];
+			if (!dir_emit(ctx, s, strlen(s),
+				      MOUNTFS_INO(entry->id) + ctx->pos,
+				      DT_REG))
+				break;
+			ctx->pos++;
+		}
+		return 0;
+	}
+
+	pos = ctx->pos - 2;
+	do {
+		spin_lock(&mountfs_lock);
+		mountfs_find_node(pos, &node);
+		pos = 1U + INT_MAX;
+		do {
+			if (!node) {
+				spin_unlock(&mountfs_lock);
+				goto out;
+			}
+			entry = mountfs_node_to_entry(node);
+			node = rb_next(node);
+		} while (!mountfs_entry_visible(entry));
+		if (node)
+			pos = mountfs_node_to_entry(node)->id;
+		id = entry->id;
+		spin_unlock(&mountfs_lock);
+
+		len = snprintf(name, sizeof(name), "%i", id);
+		ctx->pos = id + 2;
+		if (!dir_emit(ctx, name, len, MOUNTFS_INO(id), DT_DIR))
+			return 0;
+	} while (pos <= INT_MAX);
+out:
+	ctx->pos =  pos + 2;
+	return 0;
+}
+
+int mountfs_lookup_internal(struct vfsmount *m, struct path *path)
+{
+	char name[32];
+	struct qstr this = { .name = name };
+	struct mount *mnt = real_mount(m);
+	struct mountfs_entry *entry = mnt->mnt_mountfs_entry;
+	struct dentry *dentry, *old, *root = mountfs_mnt->mnt_root;
+
+	this.len = snprintf(name, sizeof(name), "%i", mnt->mnt_id);
+	dentry = d_hash_and_lookup(root, &this);
+	if (dentry && dentry->d_inode->i_private != entry) {
+		d_invalidate(dentry);
+		dput(dentry);
+		dentry = NULL;
+	}
+	if (!dentry) {
+		dentry = d_alloc(root, &this);
+		if (!dentry)
+			return -ENOMEM;
+
+		kref_get(&entry->kref);
+		old = mountfs_lookup_entry(dentry, entry, 0);
+		if (old) {
+			dput(dentry);
+			if (IS_ERR(old))
+				return PTR_ERR(old);
+			dentry = old;
+		}
+	}
+
+	*path = (struct path) { .mnt = mountfs_mnt, .dentry = dentry };
+	return 0;
+}
+
+static const struct dentry_operations mountfs_dops = {
+	.d_revalidate = mountfs_d_revalidate,
+};
+
+static const struct inode_operations mountfs_iops = {
+	.lookup = mountfs_lookup,
+};
+
+static const struct file_operations mountfs_fops = {
+	.iterate_shared = mountfs_readdir,
+	.read = generic_read_dir,
+	.llseek = generic_file_llseek,
+};
+
+static void mountfs_init_inode(struct inode *inode, umode_t mode)
+{
+	inode->i_mode = mode;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	if (S_ISREG(mode)) {
+		inode->i_size = PAGE_SIZE;
+		inode->i_fop = &mountfs_attr_fops;
+	} else {
+		inode->i_op = &mountfs_iops;
+		inode->i_fop = &mountfs_fops;
+	}
+}
+
+static void mountfs_evict_inode(struct inode *inode)
+{
+	struct mountfs_entry *entry = inode->i_private;
+
+	clear_inode(inode);
+	if (entry)
+		mountfs_entry_put(entry);
+}
+
+static const struct super_operations mountfs_sops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.evict_inode	= mountfs_evict_inode,
+};
+
+static int mountfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *root;
+
+	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_magic = MOUNTFS_SUPER_MAGIC;
+	sb->s_time_gran = 1;
+	sb->s_shrink.seeks = 0;
+	sb->s_op = &mountfs_sops;
+	sb->s_d_op = &mountfs_dops;
+
+	root = new_inode(sb);
+	if (!root)
+		return -ENOMEM;
+
+	root->i_ino = 1;
+	mountfs_init_inode(root, S_IFDIR | 0444);
+
+	sb->s_root = d_make_root(root);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int mountfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, mountfs_fill_super);
+}
+
+static const struct fs_context_operations mountfs_context_ops = {
+	.get_tree = mountfs_get_tree,
+};
+
+static int mountfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &mountfs_context_ops;
+	fc->global = true;
+	return 0;
+}
+
+static struct file_system_type mountfs_fs_type = {
+	.name = "mountfs",
+	.init_fs_context = mountfs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static int __init mountfs_init(void)
+{
+	int err;
+
+	err = register_filesystem(&mountfs_fs_type);
+	if (!err) {
+		mountfs_mnt = kern_mount(&mountfs_fs_type);
+		if (IS_ERR(mountfs_mnt)) {
+			err = PTR_ERR(mountfs_mnt);
+			unregister_filesystem(&mountfs_fs_type);
+		}
+	}
+	return err;
+}
+fs_initcall(mountfs_init);
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -943,6 +943,8 @@ struct vfsmount *vfs_create_mount(struct
 
 	if (fc->sb_flags & SB_KERNMOUNT)
 		mnt->mnt.mnt_flags = MNT_INTERNAL;
+	else
+		mountfs_create(mnt);
 
 	atomic_inc(&fc->root->d_sb->s_active);
 	mnt->mnt.mnt_sb		= fc->root->d_sb;
@@ -1013,7 +1015,7 @@ vfs_submount(const struct dentry *mountp
 }
 EXPORT_SYMBOL_GPL(vfs_submount);
 
-static struct mount *clone_mnt(struct mount *old, struct dentry *root,
+static struct mount *clone_mnt_common(struct mount *old, struct dentry *root,
 					int flag)
 {
 	struct super_block *sb = old->mnt.mnt_sb;
@@ -1079,6 +1081,17 @@ static struct mount *clone_mnt(struct mo
 	return ERR_PTR(err);
 }
 
+static struct mount *clone_mnt(struct mount *old, struct dentry *root,
+			       int flag)
+{
+	struct mount *mnt = clone_mnt_common(old, root, flag);
+
+	if (!IS_ERR(mnt))
+		mountfs_create(mnt);
+
+	return mnt;
+}
+
 static void cleanup_mnt(struct mount *mnt)
 {
 	struct hlist_node *p;
@@ -1091,6 +1104,7 @@ static void cleanup_mnt(struct mount *mn
 	 * so mnt_get_writers() below is safe.
 	 */
 	WARN_ON(mnt_get_writers(mnt));
+
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
 	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
@@ -1171,6 +1185,8 @@ static void mntput_no_expire(struct moun
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
 
+	mountfs_remove(mnt);
+
 	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
 		struct task_struct *task = current;
 		if (likely(!(task->flags & PF_KTHREAD))) {
@@ -1237,13 +1253,14 @@ EXPORT_SYMBOL(path_is_mountpoint);
 struct vfsmount *mnt_clone_internal(const struct path *path)
 {
 	struct mount *p;
-	p = clone_mnt(real_mount(path->mnt), path->dentry, CL_PRIVATE);
+	p = clone_mnt_common(real_mount(path->mnt), path->dentry, CL_PRIVATE);
 	if (IS_ERR(p))
 		return ERR_CAST(p);
 	p->mnt.mnt_flags |= MNT_INTERNAL;
 	return &p->mnt;
 }
 
+
 #ifdef CONFIG_PROC_FS
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
@@ -1385,6 +1402,16 @@ static inline void namespace_lock(void)
 	down_write(&namespace_sem);
 }
 
+void mnt_namespace_lock_read(void)
+{
+	down_read(&namespace_sem);
+}
+
+void mnt_namespace_unlock_read(void)
+{
+	up_read(&namespace_sem);
+}
+
 enum umount_tree_flags {
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3092,6 +3092,7 @@ static const struct pid_entry tgid_base_
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
 	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
+	DIR("fdmount",    S_IRUSR|S_IXUSR, proc_fdmount_inode_operations, proc_fdmount_operations),
 	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
@@ -3497,6 +3498,7 @@ static const struct inode_operations pro
 static const struct pid_entry tid_base_stuff[] = {
 	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
 	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
+	DIR("fdmount",   S_IRUSR|S_IXUSR, proc_fdmount_inode_operations, proc_fdmount_operations),
 	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -361,3 +361,85 @@ const struct file_operations proc_fdinfo
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,
 };
+
+static int proc_fdmount_link(struct dentry *dentry, struct path *path)
+{
+	struct files_struct *files = NULL;
+	struct task_struct *task;
+	struct path fd_path;
+	int ret = -ENOENT;
+
+	task = get_proc_task(d_inode(dentry));
+	if (task) {
+		files = get_files_struct(task);
+		put_task_struct(task);
+	}
+
+	if (files) {
+		unsigned int fd = proc_fd(d_inode(dentry));
+		struct file *fd_file;
+
+		spin_lock(&files->file_lock);
+		fd_file = fcheck_files(files, fd);
+		if (fd_file) {
+			fd_path = fd_file->f_path;
+			path_get(&fd_path);
+			ret = 0;
+		}
+		spin_unlock(&files->file_lock);
+		put_files_struct(files);
+	}
+	if (!ret) {
+		ret = mountfs_lookup_internal(fd_path.mnt, path);
+		path_put(&fd_path);
+	}
+
+	return ret;
+}
+
+static struct dentry *proc_fdmount_instantiate(struct dentry *dentry,
+	struct task_struct *task, const void *ptr)
+{
+	const struct fd_data *data = ptr;
+	struct proc_inode *ei;
+	struct inode *inode;
+
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | 0400);
+	if (!inode)
+		return ERR_PTR(-ENOENT);
+
+	ei = PROC_I(inode);
+	ei->fd = data->fd;
+
+	inode->i_op = &proc_pid_link_inode_operations;
+	inode->i_size = 64;
+
+	ei->op.proc_get_link = proc_fdmount_link;
+	tid_fd_update_inode(task, inode, 0);
+
+	d_set_d_op(dentry, &tid_fd_dentry_operations);
+	return d_splice_alias(inode, dentry);
+}
+
+static struct dentry *
+proc_lookupfdmount(struct inode *dir, struct dentry *dentry, unsigned int flags)
+{
+	return proc_lookupfd_common(dir, dentry, proc_fdmount_instantiate);
+}
+
+static int proc_readfdmount(struct file *file, struct dir_context *ctx)
+{
+	return proc_readfd_common(file, ctx,
+				  proc_fdmount_instantiate);
+}
+
+const struct inode_operations proc_fdmount_inode_operations = {
+	.lookup		= proc_lookupfdmount,
+	.setattr	= proc_setattr,
+};
+
+const struct file_operations proc_fdmount_operations = {
+	.read		= generic_read_dir,
+	.iterate_shared	= proc_readfdmount,
+	.llseek		= generic_file_llseek,
+};
--- a/fs/proc/fd.h
+++ b/fs/proc/fd.h
@@ -10,6 +10,9 @@ extern const struct inode_operations pro
 extern const struct file_operations proc_fdinfo_operations;
 extern const struct inode_operations proc_fdinfo_inode_operations;
 
+extern const struct file_operations proc_fdmount_operations;
+extern const struct inode_operations proc_fdmount_inode_operations;
+
 extern int proc_fd_permission(struct inode *inode, int mask);
 
 static inline unsigned int proc_fd(struct inode *inode)
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -61,24 +61,6 @@ static int show_sb_opts(struct seq_file
 	return security_sb_show_options(m, sb);
 }
 
-static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
-{
-	static const struct proc_fs_info mnt_info[] = {
-		{ MNT_NOSUID, ",nosuid" },
-		{ MNT_NODEV, ",nodev" },
-		{ MNT_NOEXEC, ",noexec" },
-		{ MNT_NOATIME, ",noatime" },
-		{ MNT_NODIRATIME, ",nodiratime" },
-		{ MNT_RELATIME, ",relatime" },
-		{ 0, NULL }
-	};
-	const struct proc_fs_info *fs_infop;
-
-	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
-	}
-}
 
 static inline void mangle(struct seq_file *m, const char *s)
 {
@@ -120,7 +102,7 @@ static int show_vfsmnt(struct seq_file *
 	err = show_sb_opts(m, sb);
 	if (err)
 		goto out;
-	show_mnt_opts(m, mnt);
+	seq_mnt_opts(m, mnt->mnt_flags);
 	if (sb->s_op->show_options)
 		err = sb->s_op->show_options(m, mnt_path.dentry);
 	seq_puts(m, " 0 0\n");
@@ -153,7 +135,7 @@ static int show_mountinfo(struct seq_fil
 		goto out;
 
 	seq_puts(m, mnt->mnt_flags & MNT_READONLY ? " ro" : " rw");
-	show_mnt_opts(m, mnt);
+	seq_mnt_opts(m, mnt->mnt_flags);
 
 	/* Tagged fields ("foo:X" or "bar") */
 	if (IS_MNT_SHARED(r))
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/mm.h>
 #include <linux/printk.h>
+#include <linux/mount.h>
 #include <linux/string_helpers.h>
 
 #include <linux/uaccess.h>
@@ -548,6 +549,28 @@ int seq_dentry(struct seq_file *m, struc
 }
 EXPORT_SYMBOL(seq_dentry);
 
+void seq_mnt_opts(struct seq_file *m, int mnt_flags)
+{
+	unsigned int i;
+	static const struct {
+		int flag;
+		const char *str;
+	} mnt_info[] = {
+		{ MNT_NOSUID, ",nosuid" },
+		{ MNT_NODEV, ",nodev" },
+		{ MNT_NOEXEC, ",noexec" },
+		{ MNT_NOATIME, ",noatime" },
+		{ MNT_NODIRATIME, ",nodiratime" },
+		{ MNT_RELATIME, ",relatime" },
+		{ 0, NULL }
+	};
+
+	for (i = 0; mnt_info[i].flag; i++) {
+		if (mnt_flags & mnt_info[i].flag)
+			seq_puts(m, mnt_info[i].str);
+	}
+}
+
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
 	return NULL + (*pos == 0);
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -138,6 +138,7 @@ int seq_file_path(struct seq_file *, str
 int seq_dentry(struct seq_file *, struct dentry *, const char *);
 int seq_path_root(struct seq_file *m, const struct path *path,
 		  const struct path *root, const char *esc);
+void seq_mnt_opts(struct seq_file *m, int mnt_flags);
 
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_open_size(struct file *, int (*)(struct seq_file *, void *), void *, size_t);
