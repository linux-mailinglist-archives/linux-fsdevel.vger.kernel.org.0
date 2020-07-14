Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20821F7E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGNRLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 13:11:17 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28661 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgGNRLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594746676; x=1626282676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8kpU2k9oXkau5pHogI80zpg0DXo9H025EuVJ9NGHdhw=;
  b=OtFAF7PuNDRz5vtpAegSyxwIsc/U6DuRFwwb6Z8mN8p2cLakq3WBQZRL
   35RMNEvNbUInAazalw2bpqEbVhYO8dYBXKfUu2hI94B2EMXZvTU2cn+6R
   EtWTQKAbNv8ZR9RR94S74WllPpPBaI2ipy6I9aquDI7KX7+Vm8/BZbQLz
   I=;
IronPort-SDR: e9VJoeTcMip0kbHBRzrbnBtw24IdK7Xgtyfm2kKa4+GQLRYtoQYyfC1JECFfA+7c4JwyqEjenO
 NW+oxjsuF+Hg==
X-IronPort-AV: E=Sophos;i="5.75,352,1589241600"; 
   d="scan'208";a="41856602"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 14 Jul 2020 17:11:15 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id A44A6A2597;
        Tue, 14 Jul 2020 17:11:12 +0000 (UTC)
Received: from EX13D12UEE001.ant.amazon.com (10.43.62.147) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 14 Jul 2020 17:11:11 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12UEE001.ant.amazon.com (10.43.62.147) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 14 Jul 2020 17:11:11 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 17:11:11 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2DD43C13B5; Tue, 14 Jul 2020 17:11:11 +0000 (UTC)
Date:   Tue, 14 Jul 2020 17:11:11 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 01/10] xattr: break delegations in {set,remove}xattr
Message-ID: <20200714171110.GA24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200623223927.31795-2-fllinden@amazon.com>
 <20200625203954.GA10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625203954.GA10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:39:54PM +0000, Frank van der Linden wrote:
> Hi Al,
> 
> Do you have any comments / concerns about this patch? It's part of nfs
> server side user xattr support, full series here:
> 
> https://lore.kernel.org/linux-nfs/20200623223927.31795-1-fllinden@amazon.com/
> 
> I copied this one to linux-fsdevel and you, just giving you an extra
> ping. Bruce/Chuck are OK with the rest of the series, so I just need
> your ACK on this one, and the next one (will send the ping separately).
> 
> Thanks,
> 
> - Frank

Hi Al,

Any comments on this one?

It's a simple change to break (NFSv4) delegations on set/removexattr, so it's pretty nfsd specific.

Linus - since this is nfsd specific, could this go in through the nfsd maintainer tree directly? Chuck has included it in a tree that is being readied for 5.9.

Thanks,

- Frank
> 
> 
> On Tue, Jun 23, 2020 at 10:39:18PM +0000, Frank van der Linden wrote:
> > set/removexattr on an exported filesystem should break NFS delegations.
> > This is true in general, but also for the upcoming support for
> > RFC 8726 (NFSv4 extended attribute support). Make sure that they do.
> > 
> > Additonally, they need to grow a _locked variant, since callers might
> > call this with i_rwsem held (like the NFS server code).
> > 
> > Cc: stable@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> >  fs/xattr.c            | 84 +++++++++++++++++++++++++++++++++++++++----
> >  include/linux/xattr.h |  2 ++
> >  2 files changed, 79 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 91608d9bfc6a..95f38f57347f 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -204,10 +204,22 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
> >  	return error;
> >  }
> >  
> > -
> > +/**
> > + * __vfs_setxattr_locked: set an extended attribute while holding the inode
> > + * lock
> > + *
> > + *  @dentry - object to perform setxattr on
> > + *  @name - xattr name to set
> > + *  @value - value to set @name to
> > + *  @size - size of @value
> > + *  @flags - flags to pass into filesystem operations
> > + *  @delegated_inode - on return, will contain an inode pointer that
> > + *  a delegation was broken on, NULL if none.
> > + */
> >  int
> > -vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
> > -		size_t size, int flags)
> > +__vfs_setxattr_locked(struct dentry *dentry, const char *name,
> > +		const void *value, size_t size, int flags,
> > +		struct inode **delegated_inode)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  	int error;
> > @@ -216,15 +228,40 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
> >  	if (error)
> >  		return error;
> >  
> > -	inode_lock(inode);
> >  	error = security_inode_setxattr(dentry, name, value, size, flags);
> >  	if (error)
> >  		goto out;
> >  
> > +	error = try_break_deleg(inode, delegated_inode);
> > +	if (error)
> > +		goto out;
> > +
> >  	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
> >  
> >  out:
> > +	return error;
> > +}
> > +EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
> > +
> > +int
> > +vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
> > +		size_t size, int flags)
> > +{
> > +	struct inode *inode = dentry->d_inode;
> > +	struct inode *delegated_inode = NULL;
> > +	int error;
> > +
> > +retry_deleg:
> > +	inode_lock(inode);
> > +	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
> > +	    &delegated_inode);
> >  	inode_unlock(inode);
> > +
> > +	if (delegated_inode) {
> > +		error = break_deleg_wait(&delegated_inode);
> > +		if (!error)
> > +			goto retry_deleg;
> > +	}
> >  	return error;
> >  }
> >  EXPORT_SYMBOL_GPL(vfs_setxattr);
> > @@ -378,8 +415,18 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
> >  }
> >  EXPORT_SYMBOL(__vfs_removexattr);
> >  
> > +/**
> > + * __vfs_removexattr_locked: set an extended attribute while holding the inode
> > + * lock
> > + *
> > + *  @dentry - object to perform setxattr on
> > + *  @name - name of xattr to remove
> > + *  @delegated_inode - on return, will contain an inode pointer that
> > + *  a delegation was broken on, NULL if none.
> > + */
> >  int
> > -vfs_removexattr(struct dentry *dentry, const char *name)
> > +__vfs_removexattr_locked(struct dentry *dentry, const char *name,
> > +		struct inode **delegated_inode)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  	int error;
> > @@ -388,11 +435,14 @@ vfs_removexattr(struct dentry *dentry, const char *name)
> >  	if (error)
> >  		return error;
> >  
> > -	inode_lock(inode);
> >  	error = security_inode_removexattr(dentry, name);
> >  	if (error)
> >  		goto out;
> >  
> > +	error = try_break_deleg(inode, delegated_inode);
> > +	if (error)
> > +		goto out;
> > +
> >  	error = __vfs_removexattr(dentry, name);
> >  
> >  	if (!error) {
> > @@ -401,12 +451,32 @@ vfs_removexattr(struct dentry *dentry, const char *name)
> >  	}
> >  
> >  out:
> > +	return error;
> > +}
> > +EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
> > +
> > +int
> > +vfs_removexattr(struct dentry *dentry, const char *name)
> > +{
> > +	struct inode *inode = dentry->d_inode;
> > +	struct inode *delegated_inode = NULL;
> > +	int error;
> > +
> > +retry_deleg:
> > +	inode_lock(inode);
> > +	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
> >  	inode_unlock(inode);
> > +
> > +	if (delegated_inode) {
> > +		error = break_deleg_wait(&delegated_inode);
> > +		if (!error)
> > +			goto retry_deleg;
> > +	}
> > +
> >  	return error;
> >  }
> >  EXPORT_SYMBOL_GPL(vfs_removexattr);
> >  
> > -
> >  /*
> >   * Extended attribute SET operations
> >   */
> > diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> > index 47eaa34f8761..a2f3cd02653c 100644
> > --- a/include/linux/xattr.h
> > +++ b/include/linux/xattr.h
> > @@ -51,8 +51,10 @@ ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
> >  ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
> >  int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
> >  int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
> > +int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
> >  int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
> >  int __vfs_removexattr(struct dentry *, const char *);
> > +int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
> >  int vfs_removexattr(struct dentry *, const char *);
> >  
> >  ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
> > -- 
> > 2.17.2
> > 
