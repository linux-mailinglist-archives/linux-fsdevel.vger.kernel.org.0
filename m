Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA617C2D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCFQ0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:26:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35655 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCFQ0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:26:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so3090135wro.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1pAbu8s6OwXgixj0n+naPc2nPniakOVqFilRH1BVyuU=;
        b=Cjpv48dFPEWtDJbBckJRgJU8KJHI8stfezsRY9I3nWtuD0FH0IsbxBTLMWBUP1EjUy
         MzfSlQ2jrzOtcHriXa5TYcSqcE1QADG/0sHRRHI+79v7HmDBKEljPFh1Ie7DHDEtqJyV
         IIJPWBpfS7ivxXmqxZl5AwpKvy6U43CrnZZeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1pAbu8s6OwXgixj0n+naPc2nPniakOVqFilRH1BVyuU=;
        b=GKkB1tnCvJrGX083CBLds28wvkrhFSeHlaZWw2wSvuLeeA/jeFb49XRN64jyGTB6dH
         RHYoErXz1JEf+LOuusMM2CvWIdmY/fy7NZhGFt+NI3a8TgXJaSto7fc69V07cCAqYi65
         OVXpGxuKwk844TeqCuP0DoC8GerwhdIgCarSuBCSNpadwFsYPWMgYTMgR25uTHljmYJ1
         rXsUqguwoVLFThOerDjIobO9EnWD5ZCxPXq9Gpcxx3ylNgI0R/OK3ksGxa4IwOcF2tuL
         HtsGSBs2tK5PCzEW6ckLMXqVvtCd0Wuoy3KiYvNhRFdFyFEPW+DWBkFxVTmajgKdCuft
         VIhA==
X-Gm-Message-State: ANhLgQ2rXausN60lh0DXsfGyx3UlXVhxBuocPm05VZFxAOW3PXPj9GV9
        Jz2bND2IAee9HLZ0ASPklMaR9A==
X-Google-Smtp-Source: ADFU+vs/SDmVC6nj4LJsKOcreHLWoP9YcJmfNm3jss/Rnfs1WJJGOggTyhbbsF/Naz8HSeWi8kMHZQ==
X-Received: by 2002:a5d:5188:: with SMTP id k8mr4770274wrv.265.1583511957494;
        Fri, 06 Mar 2020 08:25:57 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t9sm13136351wmi.45.2020.03.06.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 08:25:56 -0800 (PST)
Date:   Fri, 6 Mar 2020 17:25:49 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200306162549.GA28467@miu.piliscsaba.redhat.com>
References: <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> 
> I'm doing a patch.   Let's see how it fares in the face of all these
> preconceptions.

Here's a first cut.  Doesn't yet have superblock info, just mount info.
Probably has rough edges, but appears to work.

I started with sysfs, then kernfs, then went with a custom filesystem, because
neither could do what I wanted.

Anyway, this is more for review of the concept, than for a code review, but
obviously if you see a fatal flaw in the design, please let me know.

get mountinfo from open file:

  cat /proc/$PID/fdmount/$FD/*

get mountinfo by mount ID:

  mount -t mountfs mountfs /mountfs
  cat /mountfs/$MNT_ID/*


Thanks,
Miklos

---
 fs/Makefile              |    1 
 fs/mount.h               |   11 +
 fs/mountfs/Makefile      |    1 
 fs/mountfs/super.c       |  497 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c           |   60 +++++
 fs/proc/base.c           |    2 
 fs/proc/fd.c             |   82 +++++++
 fs/proc/fd.h             |    3 
 fs/proc_namespace.c      |   22 --
 fs/seq_file.c            |   23 ++
 include/linux/seq_file.h |    1 
 11 files changed, 682 insertions(+), 21 deletions(-)

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
@@ -153,3 +154,13 @@ static inline bool is_anon_ns(struct mnt
 {
 	return ns->seq == 0;
 }
+
+extern struct mount *get_mount(struct mount *mnt);
+extern void mntput_no_expire(struct mount *mnt);
+
+void mountfs_create(struct mount *mnt, struct mnt_namespace *mnt_ns);
+extern void mountfs_remove(struct mount *mnt);
+void seq_mount_children(struct seq_file *sf, struct mount *mnt);
+void seq_mount_propagate_from(struct seq_file *sf, struct mount *mnt,
+			      const struct path *root);
+int mountfs_lookup_internal(struct vfsmount *m, struct path *path);
--- /dev/null
+++ b/fs/mountfs/Makefile
@@ -0,0 +1 @@
+obj-y				+= super.o
--- /dev/null
+++ b/fs/mountfs/super.c
@@ -0,0 +1,497 @@
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
+static DEFINE_MUTEX(mountfs_lock);
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
+static struct mount *mountfs_get_mount(struct mountfs_entry *entry)
+{
+	struct mount *mnt;
+
+	rcu_read_lock();
+	mnt = get_mount(rcu_dereference(entry->mnt));
+	rcu_read_unlock();
+
+	return mnt;
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
+
+static int mountfs_attr_show(struct seq_file *sf, void *v)
+{
+	const char *name = sf->file->f_path.dentry->d_name.name;
+	struct mountfs_entry *entry = sf->private;
+	struct mount *mnt = mountfs_get_mount(entry);
+	struct vfsmount *m;
+	struct super_block *sb;
+	struct path root;
+	int err = 0;
+
+	if (!mnt)
+		return -ENODEV;
+
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
+		path_put(&root);
+		if (err == SEQ_SKIP) {
+			seq_puts(sf, "(unreachable)");
+			err = 0;
+		}
+		seq_putc(sf, '\n');
+	} else if (strcmp(name, "id") == 0) {
+		seq_printf(sf, "%i\n", mnt->mnt_id);
+	} else if (strcmp(name, "parent") == 0) {
+		int parent;
+
+		rcu_read_lock();
+		parent = rcu_dereference(mnt->mnt_parent)->mnt_id;
+		rcu_read_unlock();
+
+		seq_printf(sf, "%i\n", parent);
+	} else if (strcmp(name, "options") == 0) {
+		int mnt_flags = READ_ONCE(m->mnt_flags);
+
+		seq_puts(sf, mnt_flags & MNT_READONLY ? "ro" : "rw");
+		seq_mnt_opts(sf, mnt_flags);
+		seq_putc(sf, '\n');
+	} else if (strcmp(name, "children") == 0) {
+		seq_mount_children(sf, mnt);
+	} else if (strcmp(name, "group") == 0) {
+		if (IS_MNT_SHARED(mnt))
+			seq_printf(sf, "%i\n", mnt->mnt_group_id);
+	} else if (strcmp(name, "master") == 0) {
+		if (IS_MNT_SLAVE(mnt)) {
+			int master;
+
+			rcu_read_lock();
+			master = rcu_dereference(mnt->mnt_master)->mnt_group_id;
+			rcu_read_unlock();
+			seq_printf(sf, "%i\n", master);
+		}
+	} else if (strcmp(name, "propagate_from") == 0) {
+		if (IS_MNT_SLAVE(mnt)) {
+			get_fs_root(current->fs, &root);
+			seq_mount_propagate_from(sf, mnt, &root);
+			path_put(&root);
+		}
+	}
+	mntput_no_expire(mnt);
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
+void mountfs_create(struct mount *mnt, struct mnt_namespace *mnt_ns)
+{
+	struct mountfs_entry *entry;
+	struct rb_node **link, *parent;
+
+	if (mnt->mnt.mnt_flags & MNT_INTERNAL)
+		return;
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
+	mutex_lock(&mountfs_lock);
+	link = mountfs_find_node(entry->id, &parent);
+	if (!WARN_ON(*link)) {
+		rb_link_node(&entry->node, parent, link);
+		rb_insert_color(&entry->node, &mountfs_entries);
+		mnt->mnt_mountfs_entry = entry;
+	} else {
+		kfree(entry);
+	}
+	mutex_unlock(&mountfs_lock);
+}
+
+void mountfs_remove(struct mount *mnt)
+{
+	struct mountfs_entry *entry = mnt->mnt_mountfs_entry;
+
+	if (!entry)
+		return;
+
+	mutex_lock(&mountfs_lock);
+	entry->mnt = NULL;
+	rb_erase(&entry->node, &mountfs_entries);
+	mutex_unlock(&mountfs_lock);
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
+	if (WARN_ON(snprintf(buf, sizeof(buf), "%lu", mnt_id) >= sizeof(buf)) ||
+	    strcmp(buf, name) != 0)
+		return NULL;
+
+	mutex_lock(&mountfs_lock);
+	link = mountfs_find_node(mnt_id, &dummy);
+	if (*link) {
+		entry = mountfs_node_to_entry(*link);
+		if (!mountfs_entry_visible(entry))
+			entry = NULL;
+		else
+			kref_get(&entry->kref);
+	}
+	mutex_unlock(&mountfs_lock);
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
+	unsigned int len;
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
+	mutex_lock(&mountfs_lock);
+	mountfs_find_node(ctx->pos - 2, &node);
+	for (; node; node = rb_next(node)) {
+		entry = mountfs_node_to_entry(node);
+		len = snprintf(name, sizeof(name), "%i", entry->id);
+		if (WARN_ON(len >= sizeof(name)))
+			goto out_unlock;
+		if (!mountfs_entry_visible(entry))
+			continue;
+		ctx->pos = (loff_t) entry->id + 2;
+		if (!dir_emit(ctx, name, len, MOUNTFS_INO(entry->id), DT_DIR))
+			goto out_unlock;
+	}
+	ctx->pos = (loff_t) INT_MAX + 3;
+out_unlock:
+	mutex_unlock(&mountfs_lock);
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
+	if (WARN_ON(this.len >= sizeof(name)))
+		return -EIO;
+
+	dentry = d_hash_and_lookup(root, &this);
+	if (!dentry) {
+		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+
+		dentry = d_alloc_parallel(root, &this, &wq);
+		if (!IS_ERR(dentry) && d_in_lookup(dentry)) {
+			kref_get(&entry->kref);
+			old = mountfs_lookup_entry(dentry, entry, 0);
+			d_lookup_done(dentry);
+			if (unlikely(old)) {
+				dput(dentry);
+				dentry = old;
+			}
+		}
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
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
@@ -172,6 +172,24 @@ unsigned int mnt_get_count(struct mount
 #endif
 }
 
+struct mount *get_mount(struct mount *mnt)
+{
+	if (mnt) {
+		/* see comment in mntput_no_expire() */
+		if (likely(READ_ONCE(mnt->mnt_ns))) {
+			mnt_add_count(mnt, 1);
+		} else {
+			lock_mount_hash();
+			if (mnt->mnt.mnt_flags & MNT_DOOMED)
+				mnt = NULL;
+			else
+				mnt_add_count(mnt, 1);
+			unlock_mount_hash();
+		}
+	}
+	return mnt;
+}
+
 static struct mount *alloc_vfsmnt(const char *name)
 {
 	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
@@ -1091,6 +1109,9 @@ static void cleanup_mnt(struct mount *mn
 	 * so mnt_get_writers() below is safe.
 	 */
 	WARN_ON(mnt_get_writers(mnt));
+
+	mountfs_remove(mnt);
+
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
 	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
@@ -1120,7 +1141,7 @@ static void delayed_mntput(struct work_s
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
-static void mntput_no_expire(struct mount *mnt)
+void mntput_no_expire(struct mount *mnt)
 {
 	LIST_HEAD(list);
 
@@ -1296,6 +1317,37 @@ const struct seq_operations mounts_op =
 };
 #endif  /* CONFIG_PROC_FS */
 
+void seq_mount_children(struct seq_file *sf, struct mount *mnt)
+{
+	struct mount *child;
+	bool first = true;
+
+	down_read(&namespace_sem);
+	list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
+		if (!first)
+			seq_putc(sf, ',');
+		else
+			first = false;
+		seq_printf(sf, "%i", child->mnt_id);
+	}
+	up_read(&namespace_sem);
+	if (!first)
+		seq_putc(sf, '\n');
+}
+
+void seq_mount_propagate_from(struct seq_file *sf, struct mount *mnt,
+			      const struct path *root)
+{
+	int dom;
+
+	down_read(&namespace_sem);
+	dom = get_dominating_id(mnt, root);
+	up_read(&namespace_sem);
+
+	if (dom)
+		seq_printf(sf, "%i\n", dom);
+}
+
 /**
  * may_umount_tree - check if a mount tree is busy
  * @mnt: root of mount tree
@@ -2062,6 +2114,9 @@ static int attach_recursive_mnt(struct m
 		err = count_mounts(ns, source_mnt);
 		if (err)
 			goto out;
+
+		for (p = source_mnt; p; p = next_mnt(p, source_mnt))
+			mountfs_create(p, ns);
 	}
 
 	if (IS_MNT_SHARED(dest_mnt)) {
@@ -3224,6 +3279,7 @@ struct mnt_namespace *copy_mnt_ns(unsign
 	p = old;
 	q = new;
 	while (p) {
+		mountfs_create(q, new_ns);
 		q->mnt_ns = new_ns;
 		new_ns->mounts++;
 		if (new_fs) {
@@ -3686,6 +3742,8 @@ static void __init init_mount_tree(void)
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
 	m = real_mount(mnt);
+
+	mountfs_create(m, ns);
 	m->mnt_ns = ns;
 	ns->root = m;
 	ns->mounts = 1;
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
