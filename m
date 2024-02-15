Return-Path: <linux-fsdevel+bounces-11731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB7856951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FA228F263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012D13473B;
	Thu, 15 Feb 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4+hqexs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7812FB27
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013497; cv=none; b=TKrTNOyXWh586t75F2DsWSs5zV4yJiGQta5TC7SO9RMxvBZ400PzSnmFfQ+rOGJGCBNV0NbWYh4YtBII3Uvv0t+KsH5R13O4WOsTCiZmDg0nifTK5Eh3AdT/QtPkcFh0jiQpeaN/qZZ7j2lbHCPYLZgZ9PatgpYTYTyt7rfqQrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013497; c=relaxed/simple;
	bh=EmZYE7sL8cn+RgYTRsaB3tpMBc7r9EH1RSFjXTfJsvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFzGH5nl37JWMsW1enygelSTfHP5giYnomULRakVfige6BPdiIcf0IDSFIvCzA/JrJ6VqPOgXr/UAd3AQu2ZJ1/PIWcJe9JGZQ9qamREnFRcz5l5OmkwSrVsRxDa4Ps8wmQJ70D1IkqkvKbAuOB0q/RrdeOn4y239BAUywxAfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4+hqexs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F242C433C7;
	Thu, 15 Feb 2024 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013497;
	bh=EmZYE7sL8cn+RgYTRsaB3tpMBc7r9EH1RSFjXTfJsvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4+hqexsx0Odp0sNQlQmgJM3FDJdS5fvGKikGZg54QCPVBj56q+pp9gTU/AD7MCPn
	 +G3/eKDuJaeG52y5c/GjeXLk8HDO9UTsAjpohcPjd/c+LDavhKFg+gGauOC7dzLqYj
	 gDeobZam3bAHttses9AEHgfcjgrk0K6wb3FUTxyaeMjiZmu3BEwMLi1B+6bW2Y1ADW
	 YPusc4I77491LzRRg0pzLxG3tUOkbneSYDJRXMSRm33s9y/lsnjlVsEZ+7wOoH21S5
	 saQ5KP05sCxHkRR7KsdZ5rMvu/b+4V/wFV9mHIUSvxVyP8+5IVR+uTIwG6T4yEM/wH
	 gplkghAqmlpeA==
Date: Thu, 15 Feb 2024 17:11:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>

On Wed, Feb 14, 2024 at 10:37:33AM -0800, Linus Torvalds wrote:
> On Wed, 14 Feb 2024 at 10:27, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Ok, that turned out to be simpler than I had evisioned - unless I made
> > horrible mistakes:
> 
> Hmm. Could we do the same for nsfs?

Jein (Ja/Yes + Nein/No).
We could but it would alter nsfs quite a bit.

Before stashing nsfs did (roughly):

/* get an unhashed dentry */
dentry = d_alloc_pseudo(sb, &qname);

/* get new or find existing inode */
inode = iget_locked(sb, ns->inum);

/* Add new or reuse existing dentry atomically */
d_instantiate_unique(dentry, inode);

Afaict, that was intended to work because d_instantiate_unique()
existed. But I don't think it ever worked before the stashing. I'll get
to that below.

d_instantiate_unique() used to to find an existing dentry or added a new
dentry all with inode->i_lock held.

A little after that stashing mechanism for nsfs was added
d_instantiate_unique() was split into two: d_exact_alias() and
d_splice_alias(). The semantics are different. d_exact_alias() discounts
hashed dentries - returns NULL - and only considers unhashed dentries
eligible for reuse. If it finds an unhashed alias it will rehash it and
return it.

And whereas d_instantiate_unique() found and added a new dentry with
inode->i_lock held and thus guaranteed that there would only be one
dentry the d_exact_alias() followed by d_splice_alias() doesn't because
i_lock is dropped in between of course.

But even the logic back then didn't work. Because back then nsfs called
d_alloc_pseudo() which sets dentry->d_parent = dentry. IOW, creates
IS_ROOT() dentries. But __d_instantiate_unique() did:

if (alias->d_parent != entry->d_parent)
        continue;

and so would reliably discount d_alloc_pseudo() dentries... So even back
then nsfs created aliases for each open of the same namespace.

Right now the same problem plus another problem would exist. Consider:

/* get an unhashed dentry */
dentry = d_alloc_anon(sb, &qname);

/* get new or find existing inode */
inode = iget_locked(sb, ns->inum);

/* Add new or reuse existing dentry atomically */
alias = d_exact_alias(dentry, inode);
if (!alias)
	d_splice_alias(inode, dentry);

That doesn't work. First, because of the inode->i_lock drop in between
d_exact_alias() and d_splice_alias(). Second, because d_exact_alias()
discounts IS_ROOT() for reuse. Third, because d_exact_alias() discounts
hashed dentries for reuse.

Consequently switching to a similar iget_locked() mechanism for nsfs as
for pidfdfs right now would mean that there's now not just a single
dentry that's reused by all concurrent __ns_get_path() calls. Instead
one does get multiple dentries like in the old (likely broken) scheme.

For nsfs this might matter because in contrast to anonymous inodes and
pidfds these namespace fds can be bind-mounted and thus persisted. And
in that case it's nice if you only have a single dentry. Whether that
matters in practice in terms of memory I'm not sure. It likely doesn't.

Now, for pidfds we don't care. pidfds can never be bind-mounted and
there's no reason for that. That doesn't work with anonymous inodes and
it doesn't work with pidfdfs. The pidfds_mnt is marked as vfs internal
preventing it from being used for mounting.

For pidfds we also don't care about multiple dentries for the same
inode. Because right now - with pidfds being anonymous inodes - that's
exacty what already happens. And that really hasn't been an issue so far
so I don't see why it would be an issue now.

But, if we wanted this we could solve it without that stashing mechanism
as a patch on top of both pidfdfs and nsfs later but it would require
some dcache help.

I think what we'd need - specifically tailored to both nsfs and pidfdfs
- is something like the below. So, this is only expected to work on
stuff that does d_alloc_anon(). So has no real name and dentry->d_parent
== dentry; basically a bunch of IS_ROOT() dentries. I can add that on
top and then pidfds can use that and nsfs as well. But again, I don't
need it for pidfdfs to be functional. Up to you.

diff --git a/fs/dcache.c b/fs/dcache.c
index b813528fb147..7c78b8b1a8b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2642,6 +2642,39 @@ void d_add(struct dentry *entry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_add);

+/*
+ * Helper for special filesystems that want to recycle the exact same dentry
+ * over and over. Requires d_alloc_anon() and will reject anything that isn't
+ * IS_ROOT(). Caller must provide valid inode.
+ */
+struct dentry *d_instantiate_unique_anon(struct dentry *entry, struct inode *inode)
+{
+       struct dentry *alias;
+       unsigned int hash = entry->d_name.hash;
+
+       if (!inode)
+               return NULL;
+
+       if (!IS_ROOT(entry))
+               return NULL;
+
+       spin_lock(&inode->i_lock);
+       hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+               if (alias->d_name.hash != hash)
+                       continue;
+               if (!d_same_name(alias, entry->d_parent, &entry->d_name))
+                       continue;
+               dget_dlock(alias);
+               spin_unlock(&inode->i_lock);
+               return alias;
+       }
+
+       __d_instantiate(entry, inode);
+       spin_unlock(&inode->i_lock);
+       security_d_instantiate(entry, inode);
+       return NULL;
+}
+
 /**
  * d_exact_alias - find and hash an exact unhashed alias
  * @entry: dentry to add
diff --git a/fs/internal.h b/fs/internal.h
index b67406435fc0..41b441c7b2a0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -310,3 +310,4 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
+struct dentry *d_instantiate_unique_anon(struct dentry *entry, struct inode *inode);

And then this can become roughly:

struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
{
        struct path path;
        struct dentry *dentry, *alias;
        struct inode *inode;
        struct file *pidfd_file;

        dentry = d_alloc_anon(pidfdfs_sb);
        if (!dentry)
                return ERR_PTR(-ENOMEM);

        inode = iget_locked(pidfdfs_sb, pid->ino);
        if (!inode) {
                dput(dentry);
                return ERR_PTR(-ENOMEM);
        }

        if (inode->i_state & I_NEW) {
                inode->i_ino = pid->ino;
                inode->i_mode = S_IFREG | S_IRUGO;
                inode->i_fop = &pidfd_fops;
                inode->i_flags |= S_IMMUTABLE;
                inode->i_private = get_pid(pid);
                simple_inode_init_ts(inode);
                unlock_new_inode(inode);
        }

        alias = d_instantiate_unique_anon(dentry, inode);
        if (alias) {
                dput(dentry);
                dentry = alias;
        }

        path.dentry = dentry;
        path.mnt = mntget(pidfdfs_mnt);

        pidfd_file = dentry_open(&path, flags, current_cred());
        path_put(&path);
        return pidfd_file;
}

> 
> Also, quick question:
> 
> > +void pid_init_pidfdfs(struct pid *pid)
> > +{
> > +       pid->ino = ++pidfdfs_ino;
> > +}
> 
> As far as I can tell, the above is only safe because it is serialized by
> 
>         spin_lock_irq(&pidmap_lock);

Yes, I'm explicitly relying on that because that thing serializes all
alloc_pid() calls anyway which came in very handy nice.

> 
> in the only caller.
> 
> Can we please just not have a function at all, and just move it there,
> so that it's a whole lot more obvious that that inode generation
> really gets us a unique number?

Yes, of course. I just did it to avoid an ifdef basically.

> 
> Am I missing something?

Nope.

