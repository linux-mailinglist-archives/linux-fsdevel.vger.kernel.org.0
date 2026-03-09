Return-Path: <linux-fsdevel+bounces-79759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAZuLP6grmm2GwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:29:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA7B23710B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC54730500DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFF938F95B;
	Mon,  9 Mar 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIS2BILs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DA34F47E;
	Mon,  9 Mar 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052112; cv=none; b=PR66RLmDMhhAd5NOs4PP14qpryIgo93xIxd4n+4Z7gTWWtu3FedCwG4qOgCaimmEP19WEZUaLk5equqeDH04hdZqGa0kXfZ4byqsHaZT5rMCfPLLdsHIX6mJAVLYn8wTsZME8SSs/vZvmdl1seXZHFLceLxWoDydp5jKBWxKDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052112; c=relaxed/simple;
	bh=4hj3Fw9Xfg/E/XvvYPQceg7vHZ7uUcX9IecJdsLcm7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj3E9X42ob7nnp+MST1hec6IGyEPbVfKMEliBDmePf6lZ7Zh1d2FHL4nNfu5pqX3dnzkxV10IfSnUPk5AGSsUuFU0KsYLfHlwigEr/2AZmFvNTG7wYoxeiS5YmhhPyfhJvsHTXLypMn2gpzLLRXzjjNxEJUKxT/zQDywjwVLu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIS2BILs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A5C4CEF7;
	Mon,  9 Mar 2026 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773052112;
	bh=4hj3Fw9Xfg/E/XvvYPQceg7vHZ7uUcX9IecJdsLcm7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIS2BILsVA8UdkfiYFLH6bjdtAdLxZ460v1Ab/LYR//fmXHas/q3Yq+eR2oyxa+s+
	 HEEDmDMOWBGd20GllltQcvcc8HqBAPWftp5xGvXYYY3hLftfSgcSL8BTbGEMtpwxXD
	 PIz/LUERz3fmL7s2qPoBiN3sKBiiTln0swEp50LV/Fje4MH5w7MMmUWz6jkh3I8xgr
	 9iHyuLU39VFt3eehh2bxOzlzxLllMxbSF57KhLhTfeE5vCUuKnh3/q5zAa/+9c7Rek
	 cLugTF+C55cgPgdX2zKggUC1DMJ3DWRfi2Ka5+p/WMG8GcGlqo77vfCa0fr2ZZJvOz
	 BdOKQJUB4MZbA==
Date: Mon, 9 Mar 2026 11:28:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove externs from fs.h on functions modified
 by i_ino widening
Message-ID: <20260309-zinspolitik-irrten-f08531a0c68b@brauner>
References: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
X-Rspamd-Queue-Id: 0CA7B23710B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79759-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.310];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 02:54:31PM -0500, Jeff Layton wrote:
> Christoph says, in response to one of the patches in the i_ino widening
> series, which changes the prototype of several functions in fs.h:
> 
>     "Can you please drop all these pointless externs while you're at it?"
> 
> Remove extern keyword from functions touched by that patch (and a few
> that happened to be nearby). Also add missing argument names to
> declarations that lacked them.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

As I said I had already dropped those externs in your original patch but
thanks for sending this. I've taken it.

Fwiw, one or two cycles ago I started with the fs.h header split.
Most of the superblock stuff has been moved from fs.h into:

include/linux/fs/super.h
include/linux/fs/super_types.h

The same thing should ultimately be done for inodes I'm pretty sure.
So I'm happy to take patches for that as well.

