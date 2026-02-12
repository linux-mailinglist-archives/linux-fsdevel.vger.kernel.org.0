Return-Path: <linux-fsdevel+bounces-77059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHLDIcdNjmkaBgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:01:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 390371316F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C753045A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE135D5FC;
	Thu, 12 Feb 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="PCktO3j5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i677.smtp2go.com (e3i677.smtp2go.com [158.120.86.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18935771F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933684; cv=none; b=EQyRsqxdDVwdy018c1Qt+KyT2mKhpRtGMQgRWxeHUsejK2yKhi2OPZ5BmrooAY+pHX5vWYaDf8md8QFBdVqbx/iRwZMHRHATEExLTSB5XHWwfrf6PJEVPpV7tx1I5RwjPzILJiEYRwQz8NAegAONTJallGubVniuvN8sby7xjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933684; c=relaxed/simple;
	bh=/uzxl7mcz4rCA42Y3ztV83uJIM8obdgWVSPCbfAai/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV7ocdPqluzMe9WVMeOoEEjhQQDzU4ZAkxGTVDOBDdafzFNoTGknd4pKhDndcKAURc54l54iFIt94/M3bVIvu+far50jp+a7KAcWL/s2JF8H2sBU6nMgzMqiIPRZThzAVTeDN+viWZOBAInSdRd1ouzGxHGFVqH1+2G/GKphRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=PCktO3j5; arc=none smtp.client-ip=158.120.86.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1770933680; h=from : subject
 : to : message-id : date;
 bh=SPyKIPsZsBCAFDSVVgy7JovAeyFqTdGemFov23Js+nQ=;
 b=PCktO3j5EZ2u71z8nvQQQAbtL97n9xq1nAfRf2wuuz2K/YQmXeM8D4ffee1OBkMeO7Ibx
 m1xAsCjG+bDFVCsS8+Yx2VdFedjCVt4K3msAZxXI3AHcf3NLX6TibvYl7ByJM2ggqWCKmAQ
 8zuwRt4zspO0PKn+a6G994xdPDCSYNJnls8z9trYHKnQNHT89SBJEIqx1aeb3N/WLPpRjkW
 102rfHOL7vgUQBh+ADVVTJq01Sq00JhMPaiCLekRNTNjazQBfrEItK+twf0CVfpBYj6F9hM
 djWyCxuXP3OaUp0mLNnVAKHc9EnDT7QK8NhNWwHlvpy2C4y9suqKpw1LhpHw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vqekK-FnQW0hPvYx2-ndcv;
	Thu, 12 Feb 2026 22:01:12 +0000
Date: Thu, 12 Feb 2026 22:42:50 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 3/3] 9p: Enable symlink caching in page cache
Message-ID: <aY5JWgyHq5P17_jx@pilgrim>
References: <cover.1769013622.git.repk@triplefau.lt>
 <dfc736a3b22d1a799ec0eb30c038d75120745610.1769013622.git.repk@triplefau.lt>
 <2050624.usQuhbGJ8B@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2050624.usQuhbGJ8B@weasel>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sDdW3pvTwq
X-smtpcorp-track: 12YSBEfoCx9z.P4RWKlrlWF5W.GNO8uQE2KZ6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[triplefau.lt:email,triplefau.lt:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77059-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	R_DKIM_ALLOW(0.00)[triplefau.lt:s=s510616];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,triplefau.lt:email,triplefau.lt:dkim,qemu.org:url]
X-Rspamd-Queue-Id: 390371316F8
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 04:35:24PM +0100, Christian Schoenebeck wrote:
> On Wednesday, 21 January 2026 20:56:10 CET Remi Pommarel wrote:
> > Currently, when cache=loose is enabled, file reads are cached in the
> > page cache, but symlink reads are not. This patch allows the results
> > of p9_client_readlink() to be stored in the page cache, eliminating
> > the need for repeated 9P transactions on subsequent symlink accesses.
> > 
> > This change improves performance for workloads that involve frequent
> > symlink resolution.
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  fs/9p/vfs_addr.c       | 24 ++++++++++++--
> >  fs/9p/vfs_inode.c      |  6 ++--
> >  fs/9p/vfs_inode_dotl.c | 73 +++++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 90 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> > index 862164181bac..ee672abbb02c 100644
> > --- a/fs/9p/vfs_addr.c
> > +++ b/fs/9p/vfs_addr.c
> > @@ -70,10 +70,19 @@ static void v9fs_issue_read(struct netfs_io_subrequest
> > *subreq) {
> >  	struct netfs_io_request *rreq = subreq->rreq;
> >  	struct p9_fid *fid = rreq->netfs_priv;
> > +	char *target;
> >  	unsigned long long pos = subreq->start + subreq->transferred;
> > -	int total, err;
> > -
> > -	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
> > +	int total, err, len, n;
> > +
> > +	if (S_ISLNK(rreq->inode->i_mode)) {
> > +		err = p9_client_readlink(fid, &target);
> 
> Treadlink request requires 9p2000.L. So this would break with legacy protocol
> versions 9p2000 and 9p2000.u I guess:
> 
> https://wiki.qemu.org/Documentation/9p#9p_Protocol

I'm having trouble seeing how v9fs_issue_read() could be called for
S_ISLNK inodes under 9p2000 or 9p2000.u.

As I understand it, v9fs_issue_read() is only invoked through the page
cache operations via the inode’s a_ops. This seems to me that only
regular files and (now that I added a page_get_link() in
v9fs_symlink_inode_operations_dotl) symlinks using 9p2000.L can call
v9fs_issue_read(). But not symlinks using 9p2000 or 9p2000.u as I
haven't modified v9fs_symlink_inode_operations. But I may have missed
something here ?

Maybe what is misleading is that this performance optimization is only
applicable for 9p2000.L which I should possibly mention in the commit
message.

> 
> > +		len = strnlen(target, PAGE_SIZE - 1);
> 
> Usually we are bound to PATH_MAX.
> 
> Target link path is coming from 9p server, which may run another OS and
> therefore target might be longer than PATH_MAX, in which case it would always
> yield in -ENAMETOOLONG when client requests that link target from cache.
> 
> But OTOH there is no real alternative for storing a link target in cache that
> can never be delivered to user. So I guess it is OK as-is.
> 
> Simply using PATH_MAX would make it worse, as it would potentially silently
> shorten the link from host.
> 
> > +		n = copy_to_iter(target, len, &subreq->io_iter);
> > +		if (n != len)
> > +			err = -EFAULT;
> > +		total = i_size_read(rreq->inode);
> > +	} else
> > +		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
> > 
> >  	/* if we just extended the file size, any portion not in
> >  	 * cache won't be on server and is zeroes */
> > @@ -99,6 +108,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest
> > *subreq) static int v9fs_init_request(struct netfs_io_request *rreq, struct
> > file *file) {
> >  	struct p9_fid *fid;
> > +	struct dentry *dentry;
> >  	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
> >  			rreq->origin == NETFS_WRITETHROUGH ||
> >  			rreq->origin == NETFS_UNBUFFERED_WRITE ||
> > @@ -115,6 +125,14 @@ static int v9fs_init_request(struct netfs_io_request
> > *rreq, struct file *file) if (!fid)
> >  			goto no_fid;
> >  		p9_fid_get(fid);
> > +	} else if (S_ISLNK(rreq->inode->i_mode)) {
> > +		dentry = d_find_alias(rreq->inode);
> > +		if (!dentry)
> > +			goto no_fid;
> > +		fid = v9fs_fid_lookup(dentry);
> > +		dput(dentry);
> > +		if (IS_ERR(fid))
> > +			goto no_fid;
> >  	} else {
> >  		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
> >  		if (!fid)
> > diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> > index a82a71be309b..e1b762f3e081 100644
> > --- a/fs/9p/vfs_inode.c
> > +++ b/fs/9p/vfs_inode.c
> > @@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
> >  			goto error;
> >  		}
> > 
> > -		if (v9fs_proto_dotl(v9ses))
> > +		if (v9fs_proto_dotl(v9ses)) {
> >  			inode->i_op = &v9fs_symlink_inode_operations_dotl;
> > -		else
> > +			inode_nohighmem(inode);
> 
> What is that for?

According to filesystems/porting.rst and commit 21fc61c73c39 ("don't put
symlink bodies in pagecache into highmem") all symlinks that need to use
page_follow_link_light() (which is now more or less page_get_link())
should not add highmem pages in pagecache or deadlocks could happen. The
inode_nohighmem() prevents that.

Also from __page_get_link()
  BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);

A BUG_ON() is supposed to punish us if inode_nohighmem() is not used
here.

Of course this does not have any effect on 64bits platforms.

> 
> > +		} else {
> >  			inode->i_op = &v9fs_symlink_inode_operations;
> > +		}
> > 
> >  		break;
> >  	case S_IFDIR:
> > diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> > index 6312b3590f74..486b11dbada3 100644
> > --- a/fs/9p/vfs_inode_dotl.c
> > +++ b/fs/9p/vfs_inode_dotl.c
> > @@ -686,9 +686,13 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> > inode *dir, int err;
> >  	kgid_t gid;
> >  	const unsigned char *name;
> > +	umode_t mode;
> > +	struct v9fs_session_info *v9ses;
> >  	struct p9_qid qid;
> >  	struct p9_fid *dfid;
> >  	struct p9_fid *fid = NULL;
> > +	struct inode *inode;
> > +	struct posix_acl *dacl = NULL, *pacl = NULL;
> > 
> >  	name = dentry->d_name.name;
> >  	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
> > @@ -702,6 +706,15 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> > inode *dir,
> > 
> >  	gid = v9fs_get_fsgid_for_create(dir);
> > 
> > +	/* Update mode based on ACL value */
> > +	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
> > +	if (err) {
> > +		p9_debug(P9_DEBUG_VFS,
> > +			 "Failed to get acl values in symlink %d\n",
> > +			 err);
> > +		goto error;
> > +	}
> > +
> >  	/* Server doesn't alter fid on TSYMLINK. Hence no need to clone it. */
> >  	err = p9_client_symlink(dfid, name, symname, gid, &qid);
> > 
> > @@ -712,8 +725,30 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> > inode *dir,
> > 
> >  	v9fs_invalidate_inode_attr(dir);
> > 
> > +	/* instantiate inode and assign the unopened fid to the dentry */
> > +	fid = p9_client_walk(dfid, 1, &name, 1);
> > +	if (IS_ERR(fid)) {
> > +		err = PTR_ERR(fid);
> > +		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
> > +			 err);
> > +		goto error;
> > +	}
> > +
> > +	v9ses = v9fs_inode2v9ses(dir);
> > +	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
> > +	if (IS_ERR(inode)) {
> > +		err = PTR_ERR(inode);
> > +		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
> > +			 err);
> > +		goto error;
> > +	}
> > +	v9fs_set_create_acl(inode, fid, dacl, pacl);
> > +	v9fs_fid_add(dentry, &fid);
> > +	d_instantiate(dentry, inode);
> > +	err = 0;
> >  error:
> >  	p9_fid_put(fid);
> > +	v9fs_put_acl(dacl, pacl);
> >  	p9_fid_put(dfid);
> >  	return err;
> >  }
> > @@ -853,24 +888,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct
> > inode *dir, }
> > 
> >  /**
> > - * v9fs_vfs_get_link_dotl - follow a symlink path
> > + * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
> > + *
> > + * To be used when symlink caching is not enabled.
> > + *
> >   * @dentry: dentry for symlink
> >   * @inode: inode for symlink
> >   * @done: destructor for return value
> >   */
> > -
> >  static const char *
> > -v9fs_vfs_get_link_dotl(struct dentry *dentry,
> > -		       struct inode *inode,
> > -		       struct delayed_call *done)
> > +v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
> > +			       struct inode *inode,
> > +			       struct delayed_call *done)
> >  {
> >  	struct p9_fid *fid;
> >  	char *target;
> >  	int retval;
> > 
> > -	if (!dentry)
> > -		return ERR_PTR(-ECHILD);
> > -
> >  	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
> > 
> >  	fid = v9fs_fid_lookup(dentry);
> > @@ -884,6 +918,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
> >  	return target;
> >  }
> > 
> > +/**
> > + * v9fs_vfs_get_link_dotl - follow a symlink path
> > + * @dentry: dentry for symlink
> > + * @inode: inode for symlink
> > + * @done: destructor for return value
> > + */
> > +static const char *
> > +v9fs_vfs_get_link_dotl(struct dentry *dentry,
> > +		       struct inode *inode,
> > +		       struct delayed_call *done)
> > +{
> > +	struct v9fs_session_info *v9ses;
> > +
> > +	if (!dentry)
> > +		return ERR_PTR(-ECHILD);
> > +
> > +	v9ses = v9fs_inode2v9ses(inode);
> > +	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
> > +		return page_get_link(dentry, inode, done);
> > +
> > +	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
> > +}
> > +
> >  int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
> >  {
> >  	struct p9_stat_dotl *st;
> 

Thanks for the review,

-- 
Remi

