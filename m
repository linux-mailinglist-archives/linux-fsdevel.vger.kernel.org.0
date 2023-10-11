Return-Path: <linux-fsdevel+bounces-69-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F5E7C56FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866121C20F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75C208A2;
	Wed, 11 Oct 2023 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqauGNXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AD208A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 14:36:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF02B90
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697035000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njQ4dnpfZGC4ByRw67xQr+GGX1qBvlFE3o000KfQ+QQ=;
	b=bqauGNXhiX8uiXJ4OZZ8Qk+ELnQDOGv3/A5ca2cxQBWTadaiWbykUvhowqBRH73tHLE554
	ShaXb67orNvi2f2WuKYId4YZzleu7FijbUKVnV6y696E+49E7IcPlHfcAmvHfsC3IagOjf
	kcfIbQ1Vhx/K0u72KN8Fzog556W0s7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-67l-pFXnMRmAiBbld7-tMw-1; Wed, 11 Oct 2023 10:36:38 -0400
X-MC-Unique: 67l-pFXnMRmAiBbld7-tMw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b98bbf130cso534553566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034997; x=1697639797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njQ4dnpfZGC4ByRw67xQr+GGX1qBvlFE3o000KfQ+QQ=;
        b=XagAWHxKcOsnFN3QocrnYBHxWGpieCxRjY652S9HyX/G3Y2gCVLwR5W36AcYVAIYhr
         koGKb26qCZx2dUw7e3QATjspMXIE3hajUsWV0GBaCAX9P1+hjH5vtlp1fb0obf/hq0Z5
         ZAaUgSXUEzEJcazqNcAHODziUcvXq5shOXHmlXAd3pp5s1XiRLgDEA3DnIOxJNs4UqPF
         FjaSB70G1odv0mYRZlBpNu8t34IIht2IoGKO2XY6h8Q+wF95e0SUSUn1imb2RQguvHFu
         bnFf9n4pacuSibLKT4ZIARmc0blQ8rkeQPPlvAimLFtBmw75rELhscfT0E4jRzDDHxyL
         KH9Q==
X-Gm-Message-State: AOJu0Yyqz6DUeem0CV6jVtyYpDdC+LuNl3PhVQFx4ARmhxw6B/0UThlu
	TQF+lM+x+POww+wrEjsFgCFGTcTxnWq229E1dmR5w8Tg+0vfY4eDqC0w3NuTVJFcFFRtyLGXxx/
	ndO0OlXSczvg9kwYZ9J5GKCV2AgTmTF70
X-Received: by 2002:a17:906:13:b0:9ae:519f:8276 with SMTP id 19-20020a170906001300b009ae519f8276mr18068020eja.73.1697034996746;
        Wed, 11 Oct 2023 07:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfkFfLegGCe3oDm6Tq+wmynkGrnlAFVucOt8YwkkD73ppT9Vc4NmBHI5FLVRzPHAWtxK4aPg==
X-Received: by 2002:a17:906:13:b0:9ae:519f:8276 with SMTP id 19-20020a170906001300b009ae519f8276mr18068007eja.73.1697034996342;
        Wed, 11 Oct 2023 07:36:36 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090629cb00b009ad829ed144sm9871905eje.130.2023.10.11.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:36:35 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:36:34 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 25/28] xfs: add fs-verity support
Message-ID: <4yogjyv77ljdz4kkj3roeez57k4vfceuvpsyhoppbd5twvz3i4@5ipzrf5voqod>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-26-aalbersh@redhat.com>
 <20231011013940.GJ21298@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011013940.GJ21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 18:39:40, Darrick J. Wong wrote:
> On Fri, Oct 06, 2023 at 08:49:19PM +0200, Andrey Albershteyn wrote:
> > -	if (!args->value) {
> > +	/*
> > +	 * We don't want to allocate memory for fs-verity Merkle tree blocks
> > +	 * (fs-verity descriptor is fine though). They will be stored in
> > +	 * underlying xfs_buf
> > +	 */
> > +	if (!args->value && !xfs_verity_merkle_block(args)) {
> 
> Hmm, why isn't this simply !(args->op_flags & XFS_DA_OP_BUFFER) ?

I check if args contains fs-verity block in multiple places so I
wrapped it into a function. Also, XFS_DA_OP_BUFFER only sets
args->bp. It doesn't affect where xfs_attr_copy_value copies the
value (this is changed with XBF_DOUBLE_ALLOC).

> > -	if (args->attr_filter & XFS_ATTR_VERITY &&
> > -			args->op_flags & XFS_DA_OP_BUFFER)
> > +	if (xfs_verity_merkle_block(args))
> >  		flags = XBF_DOUBLE_ALLOC;
> 
> Hmm, not sure what DOUBLE_ALLOC does, but I'll get there as I go
> backwards through the XFS patches...
> 

> > +/*
> > + * fs-verity attribute name format
> > + *
> > + * Merkle tree blocks are stored under extended attributes of the inode. The
> > + * name of the attributes are offsets into merkle tree.
> 
> Are these offsets byte offsets?
> 

Byte offsets.

> > +++ b/fs/xfs/xfs_inode.h
> > @@ -342,7 +342,8 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
> >   * inactivation completes, both flags will be cleared and the inode is a
> >   * plain old IRECLAIMABLE inode.
> >   */
> > -#define XFS_INACTIVATING	(1 << 13)
> > +#define XFS_INACTIVATING		(1 << 13)
> > +#define XFS_IVERITY_CONSTRUCTION	(1 << 14) /* merkle tree construction */
> 
> Under construction?  Or already built?

Under construction.

> >  
> >  /* Quotacheck is running but inode has not been added to quota counts. */
> >  #define XFS_IQUOTAUNCHECKED	(1 << 14)
> 
> These two iflags have the same definition.

Oops! Don't know how did I missed that, thanks!

> > diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> > new file mode 100644
> > index 000000000000..a2db56974122
> > --- /dev/null
> > +++ b/fs/xfs/xfs_verity.c
> > @@ -0,0 +1,257 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Red Hat, Inc.
> > + */
> > +#include "xfs.h"
> > +#include "xfs_shared.h"
> > +#include "xfs_format.h"
> > +#include "xfs_da_format.h"
> > +#include "xfs_da_btree.h"
> > +#include "xfs_trans_resv.h"
> > +#include "xfs_mount.h"
> > +#include "xfs_inode.h"
> > +#include "xfs_attr.h"
> > +#include "xfs_verity.h"
> > +#include "xfs_bmap_util.h"
> > +#include "xfs_log_format.h"
> > +#include "xfs_trans.h"
> > +
> > +static int
> 
> Hum, why isn't this ssize_t?  That's what other IO functions return when
> returning the number of bytes acted upon.

The fs/verity prototype is with int, so I left it as int.

> > +static int
> > +xfs_drop_merkle_tree(
> > +	struct xfs_inode	*ip,
> > +	u64			merkle_tree_size,
> > +	u8			log_blocksize)
> > +{
> > +	struct xfs_fsverity_merkle_key	name;
> > +	int			error = 0, index;
> > +	u64			offset = 0;
> > +	struct xfs_da_args	args = {
> > +		.dp		= ip,
> > +		.whichfork	= XFS_ATTR_FORK,
> > +		.attr_filter	= XFS_ATTR_VERITY,
> > +		.namelen	= sizeof(struct xfs_fsverity_merkle_key),
> > +		/* NULL value make xfs_attr_set remove the attr */
> > +		.value		= NULL,
> > +	};
> > +
> > +	for (index = 1; offset < merkle_tree_size; index++) {
> > +		xfs_fsverity_merkle_key_to_disk(&name, offset);
> > +		args.name = (const uint8_t *)&name.merkleoff;
> > +		args.attr_filter = XFS_ATTR_VERITY;
> 
> Why do these two args. fields need to be reset every time through the
> loop?

Oh, yeah this should be ok. I will check it.

> > +		error = xfs_attr_set(&args);
> 
> Why is it ok to drop the error here?
> 

My bad, will handle it.

> > +		offset = index << log_blocksize;
> 
> Hm, ok, the merkle key offsets /are/ byte offsets.
> 
> Isn't this whole loop just:
> 
> 	args.name = ...;
> 	args.attr_filter = ...;
> 	for (offset = 0; offset < merkle_tree_size; offset++) {
> 		xfs_fsverity_merkle_key_to_disk(&name, pos << log_blocksize);
> 		error = xfs_attr_set(&args);
> 		if (error)
> 			return error;
> 	}
> 
> > +static int
> > +xfs_end_enable_verity(
> > +	struct file		*filp,
> > +	const void		*desc,
> > +	size_t			desc_size,
> > +	u64			merkle_tree_size,
> > +	u8			log_blocksize)
> > +{
> > +	struct inode		*inode = file_inode(filp);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	struct xfs_trans	*tp;
> > +	struct xfs_da_args	args = {
> > +		.dp		= ip,
> > +		.whichfork	= XFS_ATTR_FORK,
> > +		.attr_filter	= XFS_ATTR_VERITY,
> > +		.attr_flags	= XATTR_CREATE,
> > +		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
> > +		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
> > +		.value		= (void *)desc,
> > +		.valuelen	= desc_size,
> > +	};
> > +	int			error = 0;
> > +
> > +	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> > +
> > +	/* fs-verity failed, just cleanup */
> > +	if (desc == NULL)
> > +		goto out;
> > +
> > +	error = xfs_attr_set(&args);
> > +	if (error)
> > +		goto out;
> > +
> > +	/* Set fsverity inode flag */
> > +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
> > +			0, 0, false, &tp);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Ensure that we've persisted the verity information before we enable
> > +	 * it on the inode and tell the caller we have sealed the inode.
> > +	 */
> > +	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
> > +
> > +	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > +	xfs_trans_set_sync(tp);
> > +
> > +	error = xfs_trans_commit(tp);
> > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > +
> > +	if (!error)
> > +		inode->i_flags |= S_VERITY;
> > +
> > +out:
> > +	if (error)
> > +		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
> > +						  log_blocksize));
> 
> (Don't WARNings panic some kernels?)

Not sure, but in case we fail to drop a tree (error already
happened) we probably want to know that something going on and tree
can not be removed. But I'm fine with removing this, not sure what
are the guidelines on WARNinigs.

> > +int
> > +xfs_read_merkle_tree_block(
> > +	struct inode		*inode,
> > +	unsigned int		pos,
> > +	struct fsverity_block	*block,
> > +	unsigned long		num_ra_pages)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	struct xfs_fsverity_merkle_key name;
> > +	int			error = 0;
> > +	struct xfs_da_args	args = {
> > +		.dp		= ip,
> > +		.attr_filter	= XFS_ATTR_VERITY,
> > +		.namelen	= sizeof(struct xfs_fsverity_merkle_key),
> > +	};
> > +	xfs_fsverity_merkle_key_to_disk(&name, pos);
> > +	args.name = (const uint8_t *)&name.merkleoff;
> > +
> > +	error = xfs_attr_get(&args);
> > +	if (error)
> > +		goto out;
> > +
> > +	WARN_ON_ONCE(!args.valuelen);
> > +
> > +	/* now we also want to get underlying xfs_buf */
> > +	args.op_flags = XFS_DA_OP_BUFFER;
> 
> If XFS_DA_OP_BUFFER returns the (bhold'd) xfs_buf containing the value,
> then ... can't we call xfs_attr_get once?

hmm, yeah, one call would be probably enough. The initial two calls
were here because fs/verity expected an error if attribute doesn't
exist. But with change to fs/verity/verify.c in patch 10 it's
probably fine to do everything just in one call. Thanks!

> Can the xfs_buf contents change after we drop the I{,O}LOCK?

By fs-verity? No

> Can users (or the kernel) change or add xattrs on a verity file?
>
> Are they allowed to move the file, and hence update the parent pointers?

Moving is probably fine but I haven't tested if it works fine with
parent pointers. But as they are xattrs I think it shouldn't be a
problem. I will check it.

> Or is the point of XBF_DOUBLE_ALLOC that we'll snapshot the attr data
> into the second half of the buffer, and that's what gets passed to
> fsverity core code?

Yes, this

> > +static int
> > +xfs_write_merkle_tree_block(
> > +	struct inode		*inode,
> > +	const void		*buf,
> > +	u64			pos,
> > +	unsigned int		size)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	struct xfs_fsverity_merkle_key	name;
> > +	struct xfs_da_args	args = {
> > +		.dp		= ip,
> > +		.whichfork	= XFS_ATTR_FORK,
> > +		.attr_filter	= XFS_ATTR_VERITY,
> > +		.attr_flags	= XATTR_CREATE,
> 
> What happens if merkle tree fails midway through writing the blobs to
> the xattr tree?  If they're not removed, then won't XATTR_CREATE here
> cause a second attempt to fail because there's a half-built tree?

If write fails during tree building fs-verity calls
xfs_end_enable_verity() which then goes into xfs_drop_merkle_tree()
(if(desc == NULL) case).

> > diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> > new file mode 100644
> > index 000000000000..0f32fd212091
> > --- /dev/null
> > +++ b/fs/xfs/xfs_verity.h
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Red Hat, Inc.
> > + */
> > +#ifndef __XFS_VERITY_H__
> > +#define __XFS_VERITY_H__
> > +
> > +#include "xfs.h"
> > +#include "xfs_da_format.h"
> > +#include "xfs_da_btree.h"
> > +#include <linux/fsverity.h>
> > +
> > +#define XFS_VERITY_DESCRIPTOR_NAME "verity_descriptor"
> > +#define XFS_VERITY_DESCRIPTOR_NAME_LEN 17
> 
> Want to shorten this by one for u64 alignment? ;)

sure :)

> > +static inline bool
> > +xfs_verity_merkle_block(
> > +		struct xfs_da_args *args)
> > +{
> > +	if (!(args->attr_filter & XFS_ATTR_VERITY))
> > +		return false;
> > +
> > +	if (!(args->op_flags & XFS_DA_OP_BUFFER))
> > +		return false;
> > +
> > +	if (args->valuelen < 1024 || args->valuelen > PAGE_SIZE ||
> > +			!is_power_of_2(args->valuelen))
> > +		return false;
> 
> Why do we check the valuelen here?

I use this function in multiple places to distinguish between
xfs_da_args which contains:
- fs-verity block
- fs-verity descriptor/any other attribute

Check for size is not necessary.

But this is one of the requirements on fs-verity blocks so I thought
it could be good candidate for one additional check. I'm fine with
removing this

> Also, if you're passing the xfs_buf out, I thought the buffer cache
> could handle weird sizes?

Not sure what you mean here

-- 
- Andrey


