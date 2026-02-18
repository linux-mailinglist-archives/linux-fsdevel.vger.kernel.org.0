Return-Path: <linux-fsdevel+bounces-77601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPCrEqn+lWkDYAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:02:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0015878D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0AF302F384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890DB344DAE;
	Wed, 18 Feb 2026 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjpdT6tG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qCL7wy1T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGMQnK0b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxWWEmeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABA32C323
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437686; cv=none; b=XVwU2UFUR1NrbY3y+mXylRdYRqnCB6oORYX/sG98o9rO/kUccXBCaCyoJO2oi7JLt0V34AmHxVm9JE+wUOdBNEUVdgV11b8i+GUDZWn0Tf0nKvtMccwQmU0xqwALaHd4LOFgvEHZP5E+2AkQUMcZWn+pv4GgCefKVsR1g4Ka2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437686; c=relaxed/simple;
	bh=r5p50fgxeqnRiI3HqOy198KdIobanwWL7ySX9YuA5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ3LhU++gukVEFEG9pQkLXuQhSa5vdDKIwVVulbGiFOi11wKZJaV45YCsZp2IDwRRZHhcqud4lkUqdu/CmwNot0IexxdZZgDLmUEHL11Cnv/w6hBLbJm6Qgdu6qoVUNehrt/dPFPqrQ+Ul2cVh+6gWE2ZDzrB0RPwd/pzKY9rU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mjpdT6tG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qCL7wy1T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGMQnK0b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxWWEmeq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D41D43E6D8;
	Wed, 18 Feb 2026 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771437681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVTFDTNTc6+RIvbxQ7QRFu31DqKI++gAI+qJn+h3EHc=;
	b=mjpdT6tGzyYI3XPb6YQjMdE15d9eljLOPVH9P5sqUSV6mp3/hyrpLGWjnTHFSv1+zJzGDD
	654S8OzTfcI2ybmiqprIpJu8vGy2v/+dz3fvKiD7G7supLr+pIaxe8Oq/gwYwRa3BgBfP/
	EEx0W66BKBcvZmMX312Z8fHo3GfxSE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771437681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVTFDTNTc6+RIvbxQ7QRFu31DqKI++gAI+qJn+h3EHc=;
	b=qCL7wy1ToylRDoC1qsyG0YWxXdWK8M+ywobiCJ9w7Kzr6pt0TMpcPA3WLurCiF0ZGO4RRL
	aVR5pXWSrb7aYZBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fGMQnK0b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XxWWEmeq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771437676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVTFDTNTc6+RIvbxQ7QRFu31DqKI++gAI+qJn+h3EHc=;
	b=fGMQnK0bvfah91LKcsyLElbOhhK7wU41dNnQ2L/SrUeeqnfS6ss6M8z3a1E8PNNprHX1m9
	Ed/0ElGLqw/d5YZldE9PA0bD4GV7HtncvtbBbi+UqxIn2Zv4WjM7CB7YS09LxckB9db+CC
	yaybrZsUuFLyS4MD8+Njic1JquywssY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771437676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVTFDTNTc6+RIvbxQ7QRFu31DqKI++gAI+qJn+h3EHc=;
	b=XxWWEmeqNddVM4vHWNiY2yayzEvcFE5TKOIpAyzEwmTJbRPXz4tfolTCrvL0sVLNd30DgU
	NW4QwzJXY7qiK9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B59643EA65;
	Wed, 18 Feb 2026 18:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tyNSLGz+lWnFAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Feb 2026 18:01:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55F73A08CF; Wed, 18 Feb 2026 19:01:12 +0100 (CET)
Date: Wed, 18 Feb 2026 19:01:12 +0100
From: Jan Kara <jack@suse.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on
 file deletion
Message-ID: <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218032232.4049467-3-tjmercier@google.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77601-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,memory.events:url,suse.cz:dkim]
X-Rspamd-Queue-Id: 86F0015878D
X-Rspamd-Action: no action

On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> Currently some kernfs files (e.g. cgroup.events, memory.events) support
> inotify watches for IN_MODIFY, but unlike with regular filesystems, they
> do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> removed.

Please see my email:
https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxylx732voet@ol3kl4ackrpb

I think this is actually a bug in kernfs...

								Honza

> 
> This creates a problem for processes monitoring cgroups. For example, a
> service monitoring memory.events for memory.high breaches needs to know
> when a cgroup is removed to clean up its state. Where it's known that a
> cgroup is removed when all processes die, without IN_DELETE_SELF the
> service must resort to inefficient workarounds such as:
> 1.  Periodically scanning procfs to detect process death (wastes CPU and
>     is susceptible to PID reuse).
> 2.  Placing an additional IN_DELETE watch on the parent directory
>     (wastes resources managing double the watches).
> 3.  Holding a pidfd for every monitored cgroup (can exhaust file
>     descriptors).
> 
> This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
> This allows applications to rely on a single existing watch on the file
> of interest (e.g. memory.events) to receive notifications for both
> modifications and the eventual removal of the file, as well as automatic
> watch descriptor cleanup, simplifying userspace logic and improving
> resource efficiency.
> 
> Implementation details:
> The kernfs notification worker is updated to handle file deletion.
> The optimized single call for MODIFY events to both the parent and the
> file is retained, however because CREATE (parent) events remain
> unsupported for kernfs files, support for DELETE (parent) events is not
> added here to retain symmetry. Only support for DELETE_SELF events is
> added.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  fs/kernfs/dir.c             | 21 +++++++++++++++++
>  fs/kernfs/file.c            | 45 ++++++++++++++++++++-----------------
>  fs/kernfs/kernfs-internal.h |  3 +++
>  3 files changed, 48 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 29baeeb97871..e5bda829fcb8 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/fs.h>
> +#include <linux/fsnotify_backend.h>
>  #include <linux/namei.h>
>  #include <linux/idr.h>
>  #include <linux/slab.h>
> @@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool show)
>  	up_write(&root->kernfs_rwsem);
>  }
>  
> +static void kernfs_notify_file_deleted(struct kernfs_node *kn)
> +{
> +	static DECLARE_WORK(kernfs_notify_deleted_work,
> +			    kernfs_notify_workfn);
> +
> +	guard(spinlock_irqsave)(&kernfs_notify_lock);
> +	/* may overwite already pending FS_MODIFY events */
> +	kn->attr.notify_event = FS_DELETE;
> +
> +	if (!kn->attr.notify_next) {
> +		kernfs_get(kn);
> +		kn->attr.notify_next = kernfs_notify_list;
> +		kernfs_notify_list = kn;
> +		schedule_work(&kernfs_notify_deleted_work);
> +	}
> +}
> +
>  static void __kernfs_remove(struct kernfs_node *kn)
>  {
>  	struct kernfs_node *pos, *parent;
> @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  			struct kernfs_iattrs *ps_iattr =
>  				parent ? parent->iattr : NULL;
>  
> +			if (kernfs_type(pos) == KERNFS_FILE)
> +				kernfs_notify_file_deleted(pos);
> +
>  			/* update timestamps on the parent */
>  			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>  
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index e978284ff983..4be9bbe29378 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -37,8 +37,8 @@ struct kernfs_open_node {
>   */
>  #define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
>  
> -static DEFINE_SPINLOCK(kernfs_notify_lock);
> -static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
> +DEFINE_SPINLOCK(kernfs_notify_lock);
> +struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
>  
>  static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
>  {
> @@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
>  	return ret;
>  }
>  
> -static void kernfs_notify_workfn(struct work_struct *work)
> +void kernfs_notify_workfn(struct work_struct *work)
>  {
>  	struct kernfs_node *kn;
>  	struct kernfs_super_info *info;
> @@ -935,11 +935,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	down_read(&root->kernfs_supers_rwsem);
>  	down_read(&root->kernfs_rwsem);
>  	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
> -		struct kernfs_node *parent;
> -		struct inode *p_inode = NULL;
> -		const char *kn_name;
>  		struct inode *inode;
> -		struct qstr name;
>  
>  		/*
>  		 * We want fsnotify_modify() on @kn but as the
> @@ -951,24 +947,31 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  		if (!inode)
>  			continue;
>  
> -		kn_name = kernfs_rcu_name(kn);
> -		name = QSTR(kn_name);
> -		parent = kernfs_get_parent(kn);
> -		if (parent) {
> -			p_inode = ilookup(info->sb, kernfs_ino(parent));
> -			if (p_inode) {
> -				fsnotify(notify_event | FS_EVENT_ON_CHILD,
> -					 inode, FSNOTIFY_EVENT_INODE,
> -					 p_inode, &name, inode, 0);
> -				iput(p_inode);
> +		if (notify_event == FS_DELETE) {
> +			fsnotify_inoderemove(inode);
> +		} else {
> +			struct kernfs_node *parent = kernfs_get_parent(kn);
> +			struct inode *p_inode = NULL;
> +
> +			if (parent) {
> +				p_inode = ilookup(info->sb, kernfs_ino(parent));
> +				if (p_inode) {
> +					const char *kn_name = kernfs_rcu_name(kn);
> +					struct qstr name = QSTR(kn_name);
> +
> +					fsnotify(notify_event | FS_EVENT_ON_CHILD,
> +						 inode, FSNOTIFY_EVENT_INODE,
> +						 p_inode, &name, inode, 0);
> +					iput(p_inode);
> +				}
> +
> +				kernfs_put(parent);
>  			}
>  
> -			kernfs_put(parent);
> +			if (!p_inode)
> +				fsnotify_inode(inode, notify_event);
>  		}
>  
> -		if (!p_inode)
> -			fsnotify_inode(inode, notify_event);
> -
>  		iput(inode);
>  	}
>  
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 6061b6f70d2a..cf4b21f4f3b6 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -199,6 +199,8 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
>   * file.c
>   */
>  extern const struct file_operations kernfs_file_fops;
> +extern struct kernfs_node *kernfs_notify_list;
> +extern void kernfs_notify_workfn(struct work_struct *work);
>  
>  bool kernfs_should_drain_open_files(struct kernfs_node *kn);
>  void kernfs_drain_open_files(struct kernfs_node *kn);
> @@ -212,4 +214,5 @@ extern const struct inode_operations kernfs_symlink_iops;
>   * kernfs locks
>   */
>  extern struct kernfs_global_locks *kernfs_locks;
> +extern spinlock_t kernfs_notify_lock;
>  #endif	/* __KERNFS_INTERNAL_H */
> -- 
> 2.53.0.310.g728cabbaf7-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

