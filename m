Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5011B5CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 16:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfLKP4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 10:56:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732493AbfLKP4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576079771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=d5cXQ9aPAE4GRDvsc3AuQvCEqBDgkysKLil3lO+CNl0=;
        b=gTAcZi+4Legml5HpYP5wwSEtYLGH1OgHrvhsM49oPnSDajEYJplNnVBQOM9R5AnHRYzucG
        wwbxAG8kVdNOcxQojkd1aNPqYTp8Qjw69HO5C48hcw3alvDEdJJctrgv3t5ZUAyJ9Egrue
        DJFc9nsNDxKc1b1fQdEa3utaAEdI8DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-ucKGQ_4qMU6Rqvx6bVZ01g-1; Wed, 11 Dec 2019 10:56:07 -0500
X-MC-Unique: ucKGQ_4qMU6Rqvx6bVZ01g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39DFF593A8;
        Wed, 11 Dec 2019 15:56:05 +0000 (UTC)
Received: from [10.36.117.148] (ovpn-117-148.ams2.redhat.com [10.36.117.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA8760BE1;
        Wed, 11 Dec 2019 15:55:57 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, oleg@redhat.com,
        mchehab+samsung@kernel.org, corbet@lwn.net, tytso@mit.edu,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
References: <20191130020225.20239-1-yukuai3@huawei.com>
 <20191130020225.20239-2-yukuai3@huawei.com>
 <20191130034339.GI20752@bombadil.infradead.org>
 <e2e7c9f1-7152-1d74-c434-c2c4d57d0422@huawei.com>
 <20191130193615.GJ20752@bombadil.infradead.org>
 <20191208191142.GU4203@ZenIV.linux.org.uk>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <c8a66d9d-63b6-58db-23b5-148122d606ca@redhat.com>
Date:   Wed, 11 Dec 2019 16:55:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191208191142.GU4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.12.19 20:11, Al Viro wrote:
> On Sat, Nov 30, 2019 at 11:36:15AM -0800, Matthew Wilcox wrote:
>> On Sat, Nov 30, 2019 at 03:53:10PM +0800, yukuai (C) wrote:
>>> On 2019/11/30 11:43, Matthew Wilcox wrote:
>>>> On Sat, Nov 30, 2019 at 10:02:23AM +0800, yu kuai wrote:
>>>>> However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
>>>>> two dentry are involed. So, add in 'DENTRY_D_LOCK_NESTED_TWICE'.
>>>>
>>>> No.  These need meaningful names.  Indeed, I think D_LOCK_NESTED is
>>>> a terrible name.
>>>>
>>>> The exception is __d_move() where I think we should actually name the
>>>> different lock classes instead of using a bare '2' and '3'.  Something
>>>> like this, perhaps:
>>>
>>> Thanks for looking into this, do you mind if I replace your patch with the
>>> first two patches in the patchset?
>>
>> That's fine by me, but I think we should wait for Al to give his approval
>> before submitting a new version.
> 
> IMO this is a wrong approach.  It's papering over a confused code in
> debugfs recursive removal and it would be better to get rid of _that_,
> rather than try and slap bandaids on it.
> 
> I suspect that the following would be a better way to deal with it; it adds
> a new primitive and converts debugfs and tracefs to that.  There are
> followups converting other such places, still not finished.
> 
> commit 7e9c8a08889bf42bbe64e80e456d2eca824e5db2
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Mon Nov 18 09:43:10 2019 -0500
> 
>     simple_recursive_removal(): kernel-side rm -rf for ramfs-style filesystems
>     
>     two requirements: no file creations in IS_DEADDIR and no cross-directory
>     renames whatsoever.
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 042b688ed124..da936c54d879 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -309,7 +309,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>  		parent = debugfs_mount->mnt_root;
>  
>  	inode_lock(d_inode(parent));
> -	dentry = lookup_one_len(name, parent, strlen(name));
> +	if (unlikely(IS_DEADDIR(d_inode(parent))))
> +		dentry = ERR_PTR(-ENOENT);
> +	else
> +		dentry = lookup_one_len(name, parent, strlen(name));
>  	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
>  		if (d_is_dir(dentry))
>  			pr_err("Directory '%s' with parent '%s' already present!\n",
> @@ -657,62 +660,15 @@ static void __debugfs_file_removed(struct dentry *dentry)
>  		wait_for_completion(&fsd->active_users_drained);
>  }
>  
> -static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> -{
> -	int ret = 0;
> -
> -	if (simple_positive(dentry)) {
> -		dget(dentry);
> -		if (d_is_dir(dentry)) {
> -			ret = simple_rmdir(d_inode(parent), dentry);
> -			if (!ret)
> -				fsnotify_rmdir(d_inode(parent), dentry);
> -		} else {
> -			simple_unlink(d_inode(parent), dentry);
> -			fsnotify_unlink(d_inode(parent), dentry);
> -		}
> -		if (!ret)
> -			d_delete(dentry);
> -		if (d_is_reg(dentry))
> -			__debugfs_file_removed(dentry);
> -		dput(dentry);
> -	}
> -	return ret;
> -}
> -
> -/**
> - * debugfs_remove - removes a file or directory from the debugfs filesystem
> - * @dentry: a pointer to a the dentry of the file or directory to be
> - *          removed.  If this parameter is NULL or an error value, nothing
> - *          will be done.
> - *
> - * This function removes a file or directory in debugfs that was previously
> - * created with a call to another debugfs function (like
> - * debugfs_create_file() or variants thereof.)
> - *
> - * This function is required to be called in order for the file to be
> - * removed, no automatic cleanup of files will happen when a module is
> - * removed, you are responsible here.
> - */
> -void debugfs_remove(struct dentry *dentry)
> +static void remove_one(struct dentry *victim)
>  {
> -	struct dentry *parent;
> -	int ret;
> -
> -	if (IS_ERR_OR_NULL(dentry))
> -		return;
> -
> -	parent = dentry->d_parent;
> -	inode_lock(d_inode(parent));
> -	ret = __debugfs_remove(dentry, parent);
> -	inode_unlock(d_inode(parent));
> -	if (!ret)
> -		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> +        if (d_is_reg(victim))
> +		__debugfs_file_removed(victim);
> +	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
>  }
> -EXPORT_SYMBOL_GPL(debugfs_remove);
>  
>  /**
> - * debugfs_remove_recursive - recursively removes a directory
> + * debugfs_remove - recursively removes a directory
>   * @dentry: a pointer to a the dentry of the directory to be removed.  If this
>   *          parameter is NULL or an error value, nothing will be done.
>   *
> @@ -724,65 +680,16 @@ EXPORT_SYMBOL_GPL(debugfs_remove);
>   * removed, no automatic cleanup of files will happen when a module is
>   * removed, you are responsible here.
>   */
> -void debugfs_remove_recursive(struct dentry *dentry)
> +void debugfs_remove(struct dentry *dentry)
>  {
> -	struct dentry *child, *parent;
> -
>  	if (IS_ERR_OR_NULL(dentry))
>  		return;
>  
> -	parent = dentry;
> - down:
> -	inode_lock(d_inode(parent));
> - loop:
> -	/*
> -	 * The parent->d_subdirs is protected by the d_lock. Outside that
> -	 * lock, the child can be unlinked and set to be freed which can
> -	 * use the d_u.d_child as the rcu head and corrupt this list.
> -	 */
> -	spin_lock(&parent->d_lock);
> -	list_for_each_entry(child, &parent->d_subdirs, d_child) {
> -		if (!simple_positive(child))
> -			continue;
> -
> -		/* perhaps simple_empty(child) makes more sense */
> -		if (!list_empty(&child->d_subdirs)) {
> -			spin_unlock(&parent->d_lock);
> -			inode_unlock(d_inode(parent));
> -			parent = child;
> -			goto down;
> -		}
> -
> -		spin_unlock(&parent->d_lock);
> -
> -		if (!__debugfs_remove(child, parent))
> -			simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> -
> -		/*
> -		 * The parent->d_lock protects agaist child from unlinking
> -		 * from d_subdirs. When releasing the parent->d_lock we can
> -		 * no longer trust that the next pointer is valid.
> -		 * Restart the loop. We'll skip this one with the
> -		 * simple_positive() check.
> -		 */
> -		goto loop;
> -	}
> -	spin_unlock(&parent->d_lock);
> -
> -	inode_unlock(d_inode(parent));
> -	child = parent;
> -	parent = parent->d_parent;
> -	inode_lock(d_inode(parent));
> -
> -	if (child != dentry)
> -		/* go up */
> -		goto loop;
> -
> -	if (!__debugfs_remove(child, parent))
> -		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> -	inode_unlock(d_inode(parent));
> +	simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
> +	simple_recursive_removal(dentry, remove_one);
> +	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
>  }
> -EXPORT_SYMBOL_GPL(debugfs_remove_recursive);
> +EXPORT_SYMBOL_GPL(debugfs_remove);
>  
>  /**
>   * debugfs_rename - rename a file/directory in the debugfs filesystem
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 540611b99b9a..b67003a948ed 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/buffer_head.h> /* sync_mapping_buffers */
>  #include <linux/fs_context.h>
>  #include <linux/pseudo_fs.h>
> +#include <linux/fsnotify.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -239,6 +240,75 @@ const struct inode_operations simple_dir_inode_operations = {
>  };
>  EXPORT_SYMBOL(simple_dir_inode_operations);
>  
> +static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
> +{
> +	struct dentry *child = NULL;
> +	struct list_head *p = prev ? &prev->d_child : &parent->d_subdirs;
> +
> +	spin_lock(&parent->d_lock);
> +	while ((p = p->next) != &parent->d_subdirs) {
> +		struct dentry *d = container_of(p, struct dentry, d_child);
> +		if (simple_positive(d)) {
> +			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
> +			if (simple_positive(d))
> +				child = dget_dlock(d);
> +			spin_unlock(&d->d_lock);
> +			if (likely(child))
> +				break;
> +		}
> +	}
> +	spin_unlock(&parent->d_lock);
> +	dput(prev);
> +	return child;
> +}
> +
> +void simple_recursive_removal(struct dentry *dentry,
> +                              void (*callback)(struct dentry *))
> +{
> +	struct dentry *this = dentry;
> +	while (true) {
> +		struct dentry *victim = NULL, *child;
> +		struct inode *inode = this->d_inode;
> +
> +		inode_lock(inode);
> +		if (d_is_dir(this))
> +			inode->i_flags |= S_DEAD;
> +		while ((child = find_next_child(this, victim)) == NULL) {
> +			// kill and ascend
> +			// update metadata while it's still locked
> +			inode->i_ctime = current_time(inode);
> +			clear_nlink(inode);
> +			inode_unlock(inode);
> +			victim = this;
> +			this = this->d_parent;
> +			inode = this->d_inode;
> +			inode_lock(inode);
> +			if (simple_positive(victim)) {
> +				d_invalidate(victim);	// avoid lost mounts
> +				if (d_is_dir(victim))
> +					fsnotify_rmdir(inode, victim);
> +				else
> +					fsnotify_unlink(inode, victim);
> +				if (callback)
> +					callback(victim);
> +				dput(victim);		// unpin it
> +			}
> +			if (victim == dentry) {
> +				inode->i_ctime = inode->i_mtime =
> +					current_time(inode);
> +				if (d_is_dir(dentry))
> +					drop_nlink(inode);
> +				inode_unlock(inode);
> +				dput(dentry);
> +				return;
> +			}
> +		}
> +		inode_unlock(inode);
> +		this = child;
> +	}
> +}
> +EXPORT_SYMBOL(simple_recursive_removal);
> +
>  static const struct super_operations simple_super_operations = {
>  	.statfs		= simple_statfs,
>  };
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index eeeae0475da9..2a16c0eb97e4 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -329,7 +329,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>  		parent = tracefs_mount->mnt_root;
>  
>  	inode_lock(parent->d_inode);
> -	dentry = lookup_one_len(name, parent, strlen(name));
> +	if (unlikely(IS_DEADDIR(parent->d_inode)))
> +		dentry = ERR_PTR(-ENOENT);
> +	else
> +		dentry = lookup_one_len(name, parent, strlen(name));
>  	if (!IS_ERR(dentry) && dentry->d_inode) {
>  		dput(dentry);
>  		dentry = ERR_PTR(-EEXIST);
> @@ -495,122 +498,27 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
>  	return dentry;
>  }
>  
> -static int __tracefs_remove(struct dentry *dentry, struct dentry *parent)
> +static void remove_one(struct dentry *victim)
>  {
> -	int ret = 0;
> -
> -	if (simple_positive(dentry)) {
> -		if (dentry->d_inode) {
> -			dget(dentry);
> -			switch (dentry->d_inode->i_mode & S_IFMT) {
> -			case S_IFDIR:
> -				ret = simple_rmdir(parent->d_inode, dentry);
> -				if (!ret)
> -					fsnotify_rmdir(parent->d_inode, dentry);
> -				break;
> -			default:
> -				simple_unlink(parent->d_inode, dentry);
> -				fsnotify_unlink(parent->d_inode, dentry);
> -				break;
> -			}
> -			if (!ret)
> -				d_delete(dentry);
> -			dput(dentry);
> -		}
> -	}
> -	return ret;
> -}
> -
> -/**
> - * tracefs_remove - removes a file or directory from the tracefs filesystem
> - * @dentry: a pointer to a the dentry of the file or directory to be
> - *          removed.
> - *
> - * This function removes a file or directory in tracefs that was previously
> - * created with a call to another tracefs function (like
> - * tracefs_create_file() or variants thereof.)
> - */
> -void tracefs_remove(struct dentry *dentry)
> -{
> -	struct dentry *parent;
> -	int ret;
> -
> -	if (IS_ERR_OR_NULL(dentry))
> -		return;
> -
> -	parent = dentry->d_parent;
> -	inode_lock(parent->d_inode);
> -	ret = __tracefs_remove(dentry, parent);
> -	inode_unlock(parent->d_inode);
> -	if (!ret)
> -		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
> +	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
>  }
>  
>  /**
> - * tracefs_remove_recursive - recursively removes a directory
> + * tracefs_remove - recursively removes a directory
>   * @dentry: a pointer to a the dentry of the directory to be removed.
>   *
>   * This function recursively removes a directory tree in tracefs that
>   * was previously created with a call to another tracefs function
>   * (like tracefs_create_file() or variants thereof.)
>   */
> -void tracefs_remove_recursive(struct dentry *dentry)
> +void tracefs_remove(struct dentry *dentry)
>  {
> -	struct dentry *child, *parent;
> -
>  	if (IS_ERR_OR_NULL(dentry))
>  		return;
>  
> -	parent = dentry;
> - down:
> -	inode_lock(parent->d_inode);
> - loop:
> -	/*
> -	 * The parent->d_subdirs is protected by the d_lock. Outside that
> -	 * lock, the child can be unlinked and set to be freed which can
> -	 * use the d_u.d_child as the rcu head and corrupt this list.
> -	 */
> -	spin_lock(&parent->d_lock);
> -	list_for_each_entry(child, &parent->d_subdirs, d_child) {
> -		if (!simple_positive(child))
> -			continue;
> -
> -		/* perhaps simple_empty(child) makes more sense */
> -		if (!list_empty(&child->d_subdirs)) {
> -			spin_unlock(&parent->d_lock);
> -			inode_unlock(parent->d_inode);
> -			parent = child;
> -			goto down;
> -		}
> -
> -		spin_unlock(&parent->d_lock);
> -
> -		if (!__tracefs_remove(child, parent))
> -			simple_release_fs(&tracefs_mount, &tracefs_mount_count);
> -
> -		/*
> -		 * The parent->d_lock protects agaist child from unlinking
> -		 * from d_subdirs. When releasing the parent->d_lock we can
> -		 * no longer trust that the next pointer is valid.
> -		 * Restart the loop. We'll skip this one with the
> -		 * simple_positive() check.
> -		 */
> -		goto loop;
> -	}
> -	spin_unlock(&parent->d_lock);
> -
> -	inode_unlock(parent->d_inode);
> -	child = parent;
> -	parent = parent->d_parent;
> -	inode_lock(parent->d_inode);
> -
> -	if (child != dentry)
> -		/* go up */
> -		goto loop;
> -
> -	if (!__tracefs_remove(child, parent))
> -		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
> -	inode_unlock(parent->d_inode);
> +	simple_pin_fs(&trace_fs_type, &tracefs_mount, &tracefs_mount_count);
> +	simple_recursive_removal(dentry, remove_one);
> +	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
>  }
>  
>  /**
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index 58424eb3b329..0a817d763f0f 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -82,7 +82,7 @@ struct dentry *debugfs_create_automount(const char *name,
>  					void *data);
>  
>  void debugfs_remove(struct dentry *dentry);
> -void debugfs_remove_recursive(struct dentry *dentry);
> +#define debugfs_remove_recursive debugfs_remove
>  
>  const struct file_operations *debugfs_real_fops(const struct file *filp);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 997a530ff4e9..73ffc8654987 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3242,6 +3242,8 @@ extern int simple_unlink(struct inode *, struct dentry *);
>  extern int simple_rmdir(struct inode *, struct dentry *);
>  extern int simple_rename(struct inode *, struct dentry *,
>  			 struct inode *, struct dentry *, unsigned int);
> +extern void simple_recursive_removal(struct dentry *,
> +                              void (*callback)(struct dentry *));
>  extern int noop_fsync(struct file *, loff_t, loff_t, int);
>  extern int noop_set_page_dirty(struct page *page);
>  extern void noop_invalidatepage(struct page *page, unsigned int offset,
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 88d279c1b863..99912445974c 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -28,7 +28,6 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  struct dentry *tracefs_create_dir(const char *name, struct dentry *parent);
>  
>  void tracefs_remove(struct dentry *dentry);
> -void tracefs_remove_recursive(struct dentry *dentry);
>  
>  struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
>  					   int (*mkdir)(const char *name),
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 563e80f9006a..88d94dc3ed37 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8366,7 +8366,7 @@ struct trace_array *trace_array_create(const char *name)
>  
>  	ret = event_trace_add_tracer(tr->dir, tr);
>  	if (ret) {
> -		tracefs_remove_recursive(tr->dir);
> +		tracefs_remove(tr->dir);
>  		goto out_free_tr;
>  	}
>  
> @@ -8422,7 +8422,7 @@ static int __remove_instance(struct trace_array *tr)
>  	event_trace_del_tracer(tr);
>  	ftrace_clear_pids(tr);
>  	ftrace_destroy_function_files(tr);
> -	tracefs_remove_recursive(tr->dir);
> +	tracefs_remove(tr->dir);
>  	free_trace_buffers(tr);
>  
>  	for (i = 0; i < tr->nr_topts; i++) {
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 648930823b57..25bb3e8fb170 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -696,7 +696,7 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
>  		return;
>  
>  	if (!--dir->nr_events) {
> -		tracefs_remove_recursive(dir->entry);
> +		tracefs_remove(dir->entry);
>  		list_del(&dir->list);
>  		__put_system_dir(dir);
>  	}
> @@ -715,7 +715,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
>  		}
>  		spin_unlock(&dir->d_lock);
>  
> -		tracefs_remove_recursive(dir);
> +		tracefs_remove(dir);
>  	}
>  
>  	list_del(&file->list);
> @@ -3032,7 +3032,7 @@ int event_trace_del_tracer(struct trace_array *tr)
>  
>  	down_write(&trace_event_sem);
>  	__trace_remove_event_dirs(tr);
> -	tracefs_remove_recursive(tr->event_dir);
> +	tracefs_remove(tr->event_dir);
>  	up_write(&trace_event_sem);
>  
>  	tr->event_dir = NULL;
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index fa95139445b2..fa45a031848c 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -551,7 +551,7 @@ static int init_tracefs(void)
>  	return 0;
>  
>   err:
> -	tracefs_remove_recursive(top_dir);
> +	tracefs_remove(top_dir);
>  	return -ENOMEM;
>  }
>  
> 

The patch in linux-next

commit 653f0d05be0948e7610bb786e6570bb6c48a4e75 (HEAD, refs/bisect/bad)
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Nov 18 09:43:10 2019 -0500

    simple_recursive_removal(): kernel-side rm -rf for ramfs-style
filesystems

    two requirements: no file creations in IS_DEADDIR and no cross-directory
    renames whatsoever.

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


Makes my simple QEMU setup crash when booting


[    4.571181] list_del corruption. prev->next should be
ffff8b75df3408d0, but was ffff8b75df340d50
[    4.572064] ------------[ cut here ]------------
[    4.572448] kernel BUG at lib/list_debug.c:51!
[    4.572838] invalid opcode: 0000 [#1] SMP NOPTI
[    4.573235] CPU: 0 PID: 479 Comm: systemd-udevd Not tainted
5.5.0-rc1+ #14
[    4.573827] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu4
[    4.574782] RIP: 0010:__list_del_entry_valid.cold+0x31/0x55
[    4.575252] Code: 0d 3d a8 e8 14 dd bd ff 0f 0b 48 c7 c7 00 0e 3d a8
e8 06 dd bd ff 0f 0b 48 89 f2 48 89 fe 48 c7b
[    4.576829] RSP: 0018:ffffaef9401ebd30 EFLAGS: 00010246
[    4.577283] RAX: 0000000000000054 RBX: ffff8b75df3416c0 RCX:
0000000000000000
[    4.577879] RDX: 0000000000000000 RSI: ffff8b757fa1a248 RDI:
ffff8b757fa1a248
[    4.578479] RBP: ffff8b75df3407e0 R08: 0000000000000000 R09:
0000000000000000
[    4.579055] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8b75df340860
[    4.579660] R13: 0000000000000000 R14: ffff8b75df3416c0 R15:
ffff8b75d6bda620
[    4.580257] FS:  00007f3016d08940(0000) GS:ffff8b757fa00000(0000)
knlGS:0000000000000000
[    4.580941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.581425] CR2: 00005555eedf9cf3 CR3: 0000000197fa2000 CR4:
00000000000006f0
[    4.582034] Call Trace:
[    4.582256]  __dentry_kill+0x86/0x190
[    4.582577]  ? dput+0x20/0x460
[    4.582839]  dput+0x2a6/0x460
[    4.583100]  debugfs_remove+0x40/0x60
[    4.583403]  blk_mq_debugfs_unregister_sched+0x15/0x30
[    4.583825]  blk_mq_exit_sched+0x6b/0xa0
[    4.584154]  __elevator_exit+0x32/0x50
[    4.584460]  elevator_switch_mq+0x63/0x170
[    4.584801]  elevator_switch+0x33/0x70
[    4.585114]  elv_iosched_store+0x135/0x1b0
[    4.585450]  queue_attr_store+0x47/0x70
[    4.585779]  kernfs_fop_write+0xdc/0x1c0
[    4.586128]  vfs_write+0xdb/0x1d0
[    4.586423]  ksys_write+0x65/0xe0
[    4.586716]  do_syscall_64+0x5c/0xa0
[    4.587029]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    4.587472] RIP: 0033:0x7f3017d4a467
[    4.587782] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00
00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 854
[    4.589353] RSP: 002b:00007ffc7fa4f518 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[    4.589994] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007f3017d4a467
[    4.590605] RDX: 0000000000000004 RSI: 00007ffc7fa4f600 RDI:
000000000000000f
[    4.591212] RBP: 00007ffc7fa4f600 R08: fefefefefefefeff R09:
ffffffff00000000
[    4.591820] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000004
[    4.592423] R13: 000055cdeaffe190 R14: 0000000000000004 R15:
00007f3017e1b700
[    4.593032] Modules linked in:
[    4.593307] ---[ end trace 42f66ce1e6e1c1fe ]---
[    4.593694] RIP: 0010:__list_del_entry_valid.cold+0x31/0x55
[    4.594173] Code: 0d 3d a8 e8 14 dd bd ff 0f 0b 48 c7 c7 00 0e 3d a8
e8 06 dd bd ff 0f 0b 48 89 f2 48 89 fe 48 c7b
[    4.595756] RSP: 0018:ffffaef9401ebd30 EFLAGS: 00010246
[    4.596205] RAX: 0000000000000054 RBX: ffff8b75df3416c0 RCX:
0000000000000000
[    4.596818] RDX: 0000000000000000 RSI: ffff8b757fa1a248 RDI:
ffff8b757fa1a248
[    4.597423] RBP: ffff8b75df3407e0 R08: 0000000000000000 R09:
0000000000000000
[    4.598038] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8b75df340860
[    4.598640] R13: 0000000000000000 R14: ffff8b75df3416c0 R15:
ffff8b75d6bda620
[    4.599241] FS:  00007f3016d08940(0000) GS:ffff8b757fa00000(0000)
knlGS:0000000000000000
[    4.599936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.600415] CR2: 00005555eedf9cf3 CR3: 0000000197fa2000 CR4:
00000000000006f0
[    4.601034] BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:38
[    4.601789] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
479, name: systemd-udevd
[    4.602505] INFO: lockdep is turned off.
[    4.602837] CPU: 0 PID: 479 Comm: systemd-udevd Tainted: G      D
       5.5.0-rc1+ #14
[    4.603549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu4
[    4.604520] Call Trace:
[    4.604736]  dump_stack+0x8f/0xd0
[    4.605020]  ___might_sleep.cold+0xb3/0xc3
[    4.605374]  exit_signals+0x30/0x2d0
[    4.605689]  do_exit+0xb4/0xc40
[    4.605961]  ? ksys_write+0x65/0xe0
[    4.606256]  rewind_stack_do_exit+0x17/0x20
[    4.606624] note: systemd-udevd[479] exited with preempt_count 2
[    4.611186] list_del corruption. prev->next should be
ffff8b75df3489f0, but was ffff8b75df3480f0
[    4.611972] ------------[ cut here ]------------
[    4.612371] kernel BUG at lib/list_debug.c:51!
[    4.612783] invalid opcode: 0000 [#2] SMP NOPTI
[    4.613161] CPU: 0 PID: 511 Comm: systemd-udevd Tainted: G      D W
       5.5.0-rc1+ #14
[    4.613875] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu4
[    4.614842] RIP: 0010:__list_del_entry_valid.cold+0x31/0x55
[    4.615309] Code: 0d 3d a8 e8 14 dd bd ff 0f 0b 48 c7 c7 00 0e 3d a8
e8 06 dd bd ff 0f 0b 48 89 f2 48 89 fe 48 c7b
[    4.616880] RSP: 0018:ffffaef9402a3d30 EFLAGS: 00010246
[    4.617327] RAX: 0000000000000054 RBX: ffff8b75df347240 RCX:
0000000000000000
[    4.617930] RDX: 0000000000000000 RSI: ffff8b757fa1a248 RDI:
ffff8b757fa1a248
[    4.618541] RBP: ffff8b75df348900 R08: 0000000000000000 R09:
0000000000000001
[    4.619140] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8b75df348980
[    4.619743] R13: 0000000000000000 R14: ffff8b75df347240 R15:
ffff8b75d6a25020
[    4.620349] FS:  00007f3016d08940(0000) GS:ffff8b757fa00000(0000)
knlGS:0000000000000000
[    4.621030] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.621508] CR2: 000055cdeb042e48 CR3: 000000019e202000 CR4:
00000000000006f0
[    4.622099] Call Trace:
[    4.622322]  __dentry_kill+0x86/0x190
[    4.622645]  ? dput+0x20/0x460
[    4.622911]  dput+0x2a6/0x460
[    4.623170]  debugfs_remove+0x40/0x60
[    4.623495]  blk_mq_debugfs_unregister_sched+0x15/0x30
[    4.623929]  blk_mq_exit_sched+0x6b/0xa0
[    4.624264]  __elevator_exit+0x32/0x50
[    4.624593]  elevator_switch_mq+0x63/0x170
[    4.624945]  elevator_switch+0x33/0x70
[    4.625268]  elv_iosched_store+0x135/0x1b0
[    4.625619]  queue_attr_store+0x47/0x70
[    4.625951]  kernfs_fop_write+0xdc/0x1c0
[    4.626289]  vfs_write+0xdb/0x1d0
[    4.626583]  ksys_write+0x65/0xe0
[    4.626870]  do_syscall_64+0x5c/0xa0
[    4.627180]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    4.627616] RIP: 0033:0x7f3017d4a467
[    4.627925] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00
00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 854
[    4.629499] RSP: 002b:00007ffc7fa4f578 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[    4.630136] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007f3017d4a467
[    4.630735] RDX: 0000000000000004 RSI: 00007ffc7fa4f660 RDI:
000000000000000f
[    4.631334] RBP: 00007ffc7fa4f660 R08: fefefefefefefeff R09:
ffffffff00000000
[    4.631940] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000004
[    4.632540] R13: 000055cdeaffe190 R14: 0000000000000004 R15:
00007f3017e1b700
[    4.633141] Modules linked in:
[    4.633414] ---[ end trace 42f66ce1e6e1c1ff ]---
[    4.633814] RIP: 0010:__list_del_entry_valid.cold+0x31/0x55
[    4.634289] Code: 0d 3d a8 e8 14 dd bd ff 0f 0b 48 c7 c7 00 0e 3d a8
e8 06 dd bd ff 0f 0b 48 89 f2 48 89 fe 48 c7b
[    4.635881] RSP: 0018:ffffaef9401ebd30 EFLAGS: 00010246
[    4.636329] RAX: 0000000000000054 RBX: ffff8b75df3416c0 RCX:
0000000000000000
[    4.636940] RDX: 0000000000000000 RSI: ffff8b757fa1a248 RDI:
ffff8b757fa1a248
[    4.637544] RBP: ffff8b75df3407e0 R08: 0000000000000000 R09:
0000000000000000
[    4.638149] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8b75df340860
[    4.638750] R13: 0000000000000000 R14: ffff8b75df3416c0 R15:
ffff8b75d6bda620
[    4.639360] FS:  00007f3016d08940(0000) GS:ffff8b757fa00000(0000)
knlGS:0000000000000000
[    4.640047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.640537] CR2: 000055cdeb042e48 CR3: 000000019e202000 CR4:
00000000000006f0
[    4.641128] note: systemd-udevd[511] exited with preempt_count 2


Reverting that commit makes it work again. How does that untested and
unreviewed patch end up in linux-next? Took me 30min to bisect.

-- 
Thanks,

David / dhildenb

