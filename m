Return-Path: <linux-fsdevel+bounces-70586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D52CA15C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 20:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0F34305BFE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5B31A7F8;
	Wed,  3 Dec 2025 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du+Z1tTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D5311C0C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788489; cv=none; b=ZigOPTuWOAH2FjE8QsGdUGt7UVNoJw1v/F73WDClQHxTAZ641D4nQXyiEUIJo/A6asnMEOea6Tn0V54i4YPJ9xFc/vSxsuzgYIQiMwr0oHISUeUmp+uqOLVg9/rBJOUZgOsYljx9lsipAbyvfY6Vw7mM0CgYQS45zaPHD60rA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788489; c=relaxed/simple;
	bh=olVUG41lo+4O+yZnlVp+4H7isftZzQWXa10aLiUe4ks=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u4wQClL8Off+IQ5iVMAaxVqWyQX94otQ2clKHFYvI1H8ot1BNEs3yqhJCN8obw8NqMoJgaUF2GoVQv7AF18SbtRz/YdBqfA345Eue6nAohViW6bFXiNffFOUzOwabAygSNDoCxhhh/tDTj8c1t8oA9bVDJUBtdPt4iwHJkL+rC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du+Z1tTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3070C4CEF5;
	Wed,  3 Dec 2025 19:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764788489;
	bh=olVUG41lo+4O+yZnlVp+4H7isftZzQWXa10aLiUe4ks=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=du+Z1tTd7ypHFt3K5tWXdOYfPIae6rmFJLIRMHjpSBNjtjDevXOX30B3zJXSnaMbR
	 33pqW2+YGYXeAcutydpU5nNXMnrsgFl/oGROlXgMJGHKlWwx4j5IL6EMovgzqnp4Lb
	 Mcc6weds72rA2xmJTlWx/uynLLHgg0NtWAVZuGAQHbCqYjKdveL07TS7TxS5ull6+T
	 0UZCluS+/yum/FNxuRJlsNt0Rdhtwkd42GqDD5aYfi79x7OFe3d7rK5v/jPvfGLUjj
	 aNrp8PsxhNxgBELR94aNafqxY5cbLr/AQyqeIr6vBJkO9JZ6I9mdOos03CJVXEiog3
	 NRBZzWgz6g9rw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 00E0EF4006A;
	Wed,  3 Dec 2025 14:01:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 14:01:28 -0500
X-ME-Sender: <xms:B4kwaVTcH2-c1PQ4y92m-CzFOEruYzRLU93D-Z1fy9lnyxmCcuxpwg>
    <xme:B4kwaZkbg8EJ5BRMm0LK7tlO8fARl60fBuzZO8oqZ9vccIyFA3Q0OJ7LBtIf5Z_Kt
    SlZrHi2KOouYjFxoA8M3qAfKqxzR77rqFzz9ytCk5DepulCsw2SthCX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrhhinh
    hgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvthes
    lhifnhdrnhgvthdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehokhhorhhnihgvvhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:B4kwaaTXN6WuXYe-_whoubhSys2XNxdnyyPxGVNJzaEtmBO1K3FAQw>
    <xmx:B4kwacHyNTWqw_9-qSrfv_cDXRz8xtuU5E81TJQYjs8jQC4vgkKyQg>
    <xmx:B4kwaZdk8wENi4psYiOD8nwnm-cIZKD8vK0OmpbOsVG2b590MXrL8w>
    <xmx:B4kwaTI9eneorO4s09rf_vGReJBdhd0JXBMq-mvZizP372sA0_-w7Q>
    <xmx:B4kwaYqWADtqQzfDlvYm88fC-WnLQXyb-xYIHA9_KQMSN-zPP1ZS_O93>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D454D780054; Wed,  3 Dec 2025 14:01:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Anbf2XGo_bhc
Date: Wed, 03 Dec 2025 14:00:44 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Jonathan Corbet" <corbet@lwn.net>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <ae795e6b-bf65-46ec-9629-edcec3dcd0b9@app.fastmail.com>
In-Reply-To: <20251201-dir-deleg-ro-v1-2-2e32cf2df9b7@kernel.org>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
 <20251201-dir-deleg-ro-v1-2-2e32cf2df9b7@kernel.org>
Subject: Re: [PATCH 2/2] filelock: allow lease_managers to dictate what qualifies as a
 conflict
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 1, 2025, at 10:08 AM, Jeff Layton wrote:
> Requesting a delegation on a file from the userland fcntl() interface
> currently succeeds when there are conflicting opens present.
>
> This is because the lease handling code ignores conflicting opens for
> FL_LAYOUT and FL_DELEG leases. This was a hack put in place long ago,
> because nfsd already checks for conflicts in its own way. The kernel
> needs to perform this check for userland delegations the same way it is
> done for leases, however.
>
> Make this dependent on the lease_manager by adding a new
> ->lm_open_conflict() lease_manager operation and have
> generic_add_lease() call that instead of check_conflicting_open().
> Morph check_conflicting_open() into a ->lm_open_conflict() op that is
> only called for userland leases/delegations. Set the
> ->lm_open_conflict() operations for nfsd to trivial functions that
> always return 0.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/locking.rst |  1 +
>  fs/locks.c                            | 90 ++++++++++++++++-------------------
>  fs/nfsd/nfs4layouts.c                 | 11 ++++-
>  fs/nfsd/nfs4state.c                   |  7 +++
>  include/linux/filelock.h              |  1 +
>  5 files changed, 60 insertions(+), 50 deletions(-)
>
> diff --git a/Documentation/filesystems/locking.rst 
> b/Documentation/filesystems/locking.rst
> index 
> 77704fde98457423beae7ff00525a7383e37132b..29d453a2201bcafa03b26b706e4c68eaf5683829 
> 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -416,6 +416,7 @@ lm_change		yes		no			no
>  lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
> +lm_open_conflict        yes             no                      no
>  ======================	=============	=================	=========
> 
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 
> e974f8e180fe48682a271af4f143e6bc8e9c4d3b..a58c51c2cdd0cc4496538ed54d063cd523264128 
> 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -585,10 +585,50 @@ lease_setup(struct file_lease *fl, void **priv)
>  	__f_setown(filp, task_pid(current), PIDTYPE_TGID, 0);
>  }
> 
> +/**
> + * lease_open_conflict - see if the given file points to an inode that has
> + *			 an existing open that would conflict with the
> + *			 desired lease.
> + * @filp:	file to check
> + * @arg:	type of lease that we're trying to acquire
> + *
> + * Check to see if there's an existing open fd on this file that would
> + * conflict with the lease we're trying to set.
> + */
> +static int
> +lease_open_conflict(struct file *filp, const int arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	int self_wcount = 0, self_rcount = 0;
> +
> +	if (arg == F_RDLCK)
> +		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> +	else if (arg != F_WRLCK)
> +		return 0;
> +
> +	/*
> +	 * Make sure that only read/write count is from lease requestor.
> +	 * Note that this will result in denying write leases when i_writecount
> +	 * is negative, which is what we want.  (We shouldn't grant write leases
> +	 * on files open for execution.)
> +	 */
> +	if (filp->f_mode & FMODE_WRITE)
> +		self_wcount = 1;
> +	else if (filp->f_mode & FMODE_READ)
> +		self_rcount = 1;
> +
> +	if (atomic_read(&inode->i_writecount) != self_wcount ||
> +	    atomic_read(&inode->i_readcount) != self_rcount)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
>  static const struct lease_manager_operations lease_manager_ops = {
>  	.lm_break = lease_break_callback,
>  	.lm_change = lease_modify,
>  	.lm_setup = lease_setup,
> +	.lm_open_conflict = lease_open_conflict,
>  };
> 
>  /*
> @@ -1753,52 +1793,6 @@ int fcntl_getdeleg(struct file *filp, struct 
> delegation *deleg)
>  	return 0;
>  }
> 
> -/**
> - * check_conflicting_open - see if the given file points to an inode 
> that has
> - *			    an existing open that would conflict with the
> - *			    desired lease.
> - * @filp:	file to check
> - * @arg:	type of lease that we're trying to acquire
> - * @flags:	current lock flags
> - *
> - * Check to see if there's an existing open fd on this file that would
> - * conflict with the lease we're trying to set.
> - */
> -static int
> -check_conflicting_open(struct file *filp, const int arg, int flags)
> -{
> -	struct inode *inode = file_inode(filp);
> -	int self_wcount = 0, self_rcount = 0;
> -
> -	if (flags & FL_LAYOUT)
> -		return 0;
> -	if (flags & FL_DELEG)
> -		/* We leave these checks to the caller */
> -		return 0;
> -
> -	if (arg == F_RDLCK)
> -		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> -	else if (arg != F_WRLCK)
> -		return 0;
> -
> -	/*
> -	 * Make sure that only read/write count is from lease requestor.
> -	 * Note that this will result in denying write leases when 
> i_writecount
> -	 * is negative, which is what we want.  (We shouldn't grant write 
> leases
> -	 * on files open for execution.)
> -	 */
> -	if (filp->f_mode & FMODE_WRITE)
> -		self_wcount = 1;
> -	else if (filp->f_mode & FMODE_READ)
> -		self_rcount = 1;
> -
> -	if (atomic_read(&inode->i_writecount) != self_wcount ||
> -	    atomic_read(&inode->i_readcount) != self_rcount)
> -		return -EAGAIN;
> -
> -	return 0;
> -}
> -
>  static int
>  generic_add_lease(struct file *filp, int arg, struct file_lease **flp, 
> void **priv)
>  {
> @@ -1835,7 +1829,7 @@ generic_add_lease(struct file *filp, int arg, 
> struct file_lease **flp, void **pr
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
>  	time_out_leases(inode, &dispose);
> -	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
> +	error = lease->fl_lmops->lm_open_conflict(filp, arg);
>  	if (error)
>  		goto out;
> 
> @@ -1892,7 +1886,7 @@ generic_add_lease(struct file *filp, int arg, 
> struct file_lease **flp, void **pr
>  	 * precedes these checks.
>  	 */
>  	smp_mb();
> -	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
> +	error = lease->fl_lmops->lm_open_conflict(filp, arg);
>  	if (error) {
>  		locks_unlink_lock_ctx(&lease->c);
>  		goto out;
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 
> 683bd1130afe298f9df774684192c89f68102b72..ca7ec7a022bd5c12fad60ff9e51145d9cca55527 
> 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -764,9 +764,16 @@ nfsd4_layout_lm_change(struct file_lease *onlist, 
> int arg,
>  	return lease_modify(onlist, arg, dispose);
>  }
> 
> +static int
> +nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
> +{
> +	return 0;
> +}
> +

The usual idiom for no-op callbacks is to make them optional.
Then generic_add_lease would check if the ->lm_open_conflict
callback is defined first and skip the call if it's not.

If that doesn't make sense to do, and these NFSD-specific
functions need to remain, then our usual practice is to add
a kdoc comment for both of the new functions that looks like
the one you added above for lease_open_conflict().


Otherwise, I'm comfortable that this change fits in with the
deadlock prevention patches we are considering for NFSD.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

For both 1/2 and 2/2.


>  static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
> -	.lm_break	= nfsd4_layout_lm_break,
> -	.lm_change	= nfsd4_layout_lm_change,
> +	.lm_break		= nfsd4_layout_lm_break,
> +	.lm_change		= nfsd4_layout_lm_change,
> +	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>  };
> 
>  int
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 
> 8f8c9385101e15b64883eabec71775f26b14f890..669fabb095407e61525e5b71268cf1f06fc09877 
> 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5543,10 +5543,17 @@ nfsd_change_deleg_cb(struct file_lease *onlist, 
> int arg,
>  		return -EAGAIN;
>  }
> 
> +static int
> +nfsd4_deleg_lm_open_conflict(struct file *filp, int arg)
> +{
> +	return 0;
> +}
> +
>  static const struct lease_manager_operations nfsd_lease_mng_ops = {
>  	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
>  	.lm_break = nfsd_break_deleg_cb,
>  	.lm_change = nfsd_change_deleg_cb,
> +	.lm_open_conflict = nfsd4_deleg_lm_open_conflict,
>  };
> 
>  static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, 
> struct nfs4_stateowner *so, u32 seqid)
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 
> 54b824c05299261e6bd6acc4175cb277ea35b35d..2f5e5588ee0733c200103801d0d2ba19bebbf9af 
> 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -49,6 +49,7 @@ struct lease_manager_operations {
>  	int (*lm_change)(struct file_lease *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +	int (*lm_open_conflict)(struct file *, int);
>  };
> 
>  struct lock_manager {
>
> -- 
> 2.52.0

-- 
Chuck Lever

