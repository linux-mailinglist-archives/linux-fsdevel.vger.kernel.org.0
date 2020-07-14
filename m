Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB021F7EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGNRNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 13:13:33 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:31700 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNRNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594746812; x=1626282812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FARGP/IJSWHblT4ABOS8MJeoxrGe/2W7Ht2mq54yEIo=;
  b=q8kYRTWsuOjxuAvDwj8bS7NKwmhxExCm/FoSwArZ/Ktuz5dNKbkcxi+G
   +REG6z4cHg2X2WGnUCmNd/hwOusF+q++Vy0CbCvP7RHB27/ipYHBSTMdY
   ACdoOeESgYIqzzf3PDvQQlvM6w3dxo/TFUXax76mZFVJLGKHmgzkLJvyH
   w=;
IronPort-SDR: fB+/MkZV/Xn3ZMRMccY0xxvM9000CBQoByzqK+RfEjfAe6oMONrs38DmN0tu+Spl5ueDYw9xWG
 2y8LLcCMS61Q==
X-IronPort-AV: E=Sophos;i="5.75,352,1589241600"; 
   d="scan'208";a="43290765"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 14 Jul 2020 17:13:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id A6FEAA2120;
        Tue, 14 Jul 2020 17:13:29 +0000 (UTC)
Received: from EX13D08UWB003.ant.amazon.com (10.43.161.186) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 14 Jul 2020 17:13:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D08UWB003.ant.amazon.com (10.43.161.186) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 14 Jul 2020 17:13:28 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 17:13:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id D704BC13B5; Tue, 14 Jul 2020 17:13:28 +0000 (UTC)
Date:   Tue, 14 Jul 2020 17:13:28 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 02/10] xattr: add a function to check if a namespace
 is supported
Message-ID: <20200714171328.GB24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200623223927.31795-3-fllinden@amazon.com>
 <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:41:57PM +0000, Frank van der Linden wrote:
> Hi Al,
> 
> ..and here is the other xattr change that was part of the nfsd user xattr
> support series that I mentioned in my previous email.
> 
> Full series here:
> 
> https://lore.kernel.org/linux-nfs/20200623223927.31795-1-fllinden@amazon.com/
> 
> Any comments / concerned about this one?
> 
> Thanks,
> 
> - Frank

Hi Al,

Here's the other one I'm just sending a quick ping on. It's a simple change -
just add a little new function that enables nfsd to check if the "user."
namespace is at all supported by a filesystem.

Any comments?

Again, Linus - this is a pretty small change, doesn't affect any existing
codepaths, and it's already in the tree Chuck is setting up for 5.9. Could
this go in through that directly?

Thanks,

- Frank
> 
> On Tue, Jun 23, 2020 at 10:39:19PM +0000, Frank van der Linden wrote:
> > Add a function that checks is an extended attribute namespace is
> > supported for an inode, meaning that a handler must be present
> > for either the whole namespace, or at least one synthetic
> > xattr in the namespace.
> > 
> > To be used by the nfs server code when being queried for extended
> > attributes support.
> > 
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> >  fs/xattr.c            | 27 +++++++++++++++++++++++++++
> >  include/linux/xattr.h |  2 ++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 95f38f57347f..386b45676d7e 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -134,6 +134,33 @@ xattr_permission(struct inode *inode, const char *name, int mask)
> >  	return inode_permission(inode, mask);
> >  }
> >  
> > +/*
> > + * Look for any handler that deals with the specified namespace.
> > + */
> > +int
> > +xattr_supported_namespace(struct inode *inode, const char *prefix)
> > +{
> > +	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
> > +	const struct xattr_handler *handler;
> > +	size_t preflen;
> > +
> > +	if (!(inode->i_opflags & IOP_XATTR)) {
> > +		if (unlikely(is_bad_inode(inode)))
> > +			return -EIO;
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	preflen = strlen(prefix);
> > +
> > +	for_each_xattr_handler(handlers, handler) {
> > +		if (!strncmp(xattr_prefix(handler), prefix, preflen))
> > +			return 0;
> > +	}
> > +
> > +	return -EOPNOTSUPP;
> > +}
> > +EXPORT_SYMBOL(xattr_supported_namespace);
> > +
> >  int
> >  __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
> >  	       const void *value, size_t size, int flags)
> > diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> > index a2f3cd02653c..fac75810d9d3 100644
> > --- a/include/linux/xattr.h
> > +++ b/include/linux/xattr.h
> > @@ -61,6 +61,8 @@ ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_siz
> >  ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
> >  			   char **xattr_value, size_t size, gfp_t flags);
> >  
> > +int xattr_supported_namespace(struct inode *inode, const char *prefix);
> > +
> >  static inline const char *xattr_prefix(const struct xattr_handler *handler)
> >  {
> >  	return handler->prefix ?: handler->name;
> > -- 
> > 2.17.2
> > 
