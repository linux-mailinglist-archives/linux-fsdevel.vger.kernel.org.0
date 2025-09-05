Return-Path: <linux-fsdevel+bounces-60398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A50B46687
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 00:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87782173B04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7AF279DB4;
	Fri,  5 Sep 2025 22:18:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B31D7995;
	Fri,  5 Sep 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110737; cv=none; b=WzoVh1qesMKgg9maxlxbNL3IrsbDTzRcZ+q0Cebn2BxKtElKq4KX2LqNOHNi3yyX5IULIePukqERotzEs+x/G802rTm07AjHTD7AKxAYhmkSuP1DIfxGXbj0hultezcLgDbXIPCvfV2XRBhLUOnhFgLr6DfFzeaeCU7ikQOYjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110737; c=relaxed/simple;
	bh=mRZfHDJpq1cAATIN4Rfd7d+AbqOqAHjI9ZorsEgGci8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDGjAUJYXRVf7ApRad/W0suBhGd5SHFbvazeKsovVa6CvNuj3sjbZHwVyOe7/ZFPa9dKUpWmXPCKMSpmEYI1ri3FEYNbhWSB5IJWEJLnp2SiPYfXUWTbaX1vB6cOzyYK4V2/y9aKfw91m1ECGuRPrP2fpfQmalbaDEQOVqgc4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id 6B60B40C96;
	Sat,  6 Sep 2025 00:18:53 +0200 (CEST)
Date: Sat, 6 Sep 2025 00:18:52 +0200
From: Max Kellermann <max@blarg.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com
Subject: Re: [RFC PATCH 13/20] ceph: add comments to metadata structures in
 msgr.h
Message-ID: <aLthzKYmppZzgfU0@swift.blarg.de>
References: <20250905200108.151563-1-slava@dubeyko.com>
 <20250905200108.151563-14-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905200108.151563-14-slava@dubeyko.com>

On 2025/09/05 22:01, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> Claude AI generated comments for CephFS metadata structure
> declarations in include/linux/ceph/*.h. These comments
> have been reviewed, checked, and corrected.

After looking at several of your patches, I doubt the value of this
effort.  This is mostly just redundant noise being added.

>  struct ceph_entity_addr {
> +	/* Address type identifier */
>  	__le32 type;  /* CEPH_ENTITY_ADDR_TYPE_* */

The old comment, which you (accidently?) left in there, is better than
your new comment.  It specifies what values are possible.

"Address type identifier" means nothing to me, no more than "type" of
"ceph_entity_addr".

> -	__le32 nonce;  /* unique id for process (e.g. pid) */
> +	/* Unique process identifier (typically PID) */
> +	__le32 nonce;

No improvement here.  Just rephrased to be a bit more verbose without
adding any information.

> +	/* Socket address (IPv4/IPv6) */
>  	struct sockaddr_storage in_addr;

Surprise - a "struct sockaddr_storage" is a socket address?  Does this
need to be explained?

What is the value of pointing out that it can be IPv4 or IPv6?  You
asked Claude to generate tokens, and so it did.  But do these tokens
add any value?  I don't think so.

>  struct ceph_entity_inst {
> +	/* Logical entity name (type + number) */
>  	struct ceph_entity_name name;

I don't understand this comment.  Okay, so the entity name is an
entity name, but what does it mean for a name to be "logical"?  What
is this "type" and "number" and how do you add them?

> +	/* Network address for this entity */
>  	struct ceph_entity_addr addr;

Oh well.  The address is an address.

> +	/* Wire protocol version */
>  	__le32 protocol_version;

The protocol version is one for the wire.  A-ha.

> +	/* Connection flags (lossy, etc.) */
>  	__u8  flags;         /* CEPH_MSG_CONNECT_* */

The old comment looked fine.  I can "git grep CEPH_MSG_CONNECT_" and
see possible values.

The new comment says these flags are for the connection.  Okay.  And
the flags can be lossy, can't they?  No, one of the possibly flags is
just "CEPH_MSG_CONNECT_LOSSY" and Claude confusingly rephrased this to
"lossy".  And "etc.", but what is "etc."?  Nothing, there are no other
flags.  The "etc." is just noise.

What would have been valuable pointing out is that this is a bit mask
(but this can be guessed easily).

Just leave the old comment, it's fine and enough.

>  struct ceph_msg_connect_reply {
> +	/* Reply tag (ready, retry, error, etc.) */
>  	__u8 tag;

How does "ready", "retry" etc. fit into a __u8?  Claude unhelpfully
omitted technical details by rephrasing the macro names.


(That's all I'm going to comment on now.  I could go on for hours, but
I feel this is a waste of time.)


