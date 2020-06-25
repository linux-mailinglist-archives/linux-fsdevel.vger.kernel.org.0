Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754A520A6EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbgFYUmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 16:42:04 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:1963 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390477AbgFYUmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593117723; x=1624653723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sp+Kfnig4+bLIVQ1Ra1S0tQSkZvMnG+IZFZS1dO49+U=;
  b=PHBxWOMuf+FEeXmXrV6NIvr4mB0yNxUNtfUvycQ0hdHzP+gYwL+LBDV9
   enS40GtyjqgMcII2QiQTdv/AMf++KZzQ2VY4m/5uALzZ2R8NoMJ6ZCcL0
   jKpjgA1Fr2JuxH5GMqX6LA7F5EsRleaG8qpucIzALlHLJXUzizCIBG6o+
   E=;
IronPort-SDR: zOgDFrHdB7JQVW3OX9pDlBqtcpjkpxnGXVdX7UexlfnIeh9SlAYEzLwJoh/DlCmDyOMEEWYDWr
 eKW0aBo0eQhA==
X-IronPort-AV: E=Sophos;i="5.75,280,1589241600"; 
   d="scan'208";a="47052694"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 25 Jun 2020 20:41:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 2C17CA2454;
        Thu, 25 Jun 2020 20:41:58 +0000 (UTC)
Received: from EX13D40UWA001.ant.amazon.com (10.43.160.53) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 20:41:57 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D40UWA001.ant.amazon.com (10.43.160.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 20:41:57 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 25 Jun 2020 20:41:57 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 82515C3318; Thu, 25 Jun 2020 20:41:57 +0000 (UTC)
Date:   Thu, 25 Jun 2020 20:41:57 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] xattr: add a function to check if a namespace
 is supported
Message-ID: <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200623223927.31795-3-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623223927.31795-3-fllinden@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

..and here is the other xattr change that was part of the nfsd user xattr
support series that I mentioned in my previous email.

Full series here:

https://lore.kernel.org/linux-nfs/20200623223927.31795-1-fllinden@amazon.com/

Any comments / concerned about this one?

Thanks,

- Frank

On Tue, Jun 23, 2020 at 10:39:19PM +0000, Frank van der Linden wrote:
> Add a function that checks is an extended attribute namespace is
> supported for an inode, meaning that a handler must be present
> for either the whole namespace, or at least one synthetic
> xattr in the namespace.
> 
> To be used by the nfs server code when being queried for extended
> attributes support.
> 
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
>  fs/xattr.c            | 27 +++++++++++++++++++++++++++
>  include/linux/xattr.h |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 95f38f57347f..386b45676d7e 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -134,6 +134,33 @@ xattr_permission(struct inode *inode, const char *name, int mask)
>  	return inode_permission(inode, mask);
>  }
>  
> +/*
> + * Look for any handler that deals with the specified namespace.
> + */
> +int
> +xattr_supported_namespace(struct inode *inode, const char *prefix)
> +{
> +	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
> +	const struct xattr_handler *handler;
> +	size_t preflen;
> +
> +	if (!(inode->i_opflags & IOP_XATTR)) {
> +		if (unlikely(is_bad_inode(inode)))
> +			return -EIO;
> +		return -EOPNOTSUPP;
> +	}
> +
> +	preflen = strlen(prefix);
> +
> +	for_each_xattr_handler(handlers, handler) {
> +		if (!strncmp(xattr_prefix(handler), prefix, preflen))
> +			return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(xattr_supported_namespace);
> +
>  int
>  __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
>  	       const void *value, size_t size, int flags)
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index a2f3cd02653c..fac75810d9d3 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -61,6 +61,8 @@ ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_siz
>  ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
>  			   char **xattr_value, size_t size, gfp_t flags);
>  
> +int xattr_supported_namespace(struct inode *inode, const char *prefix);
> +
>  static inline const char *xattr_prefix(const struct xattr_handler *handler)
>  {
>  	return handler->prefix ?: handler->name;
> -- 
> 2.17.2
> 
