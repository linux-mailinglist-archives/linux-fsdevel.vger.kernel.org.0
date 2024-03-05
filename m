Return-Path: <linux-fsdevel+bounces-13568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6958711BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 01:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70E31F23ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030C4C96;
	Tue,  5 Mar 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuMkIlcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD097F;
	Tue,  5 Mar 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598836; cv=none; b=tyC9r6EriA1XCpn4wfTFIxtm7BY3BNUczDL4NkgLOMpfovBGSXpd9o8xPh30gJ8NIygsye+AxKLGKtgVF75bE58f46sagFYKs2y5g1wjESnHPYY7xiyl9uGKHk2kvLomxSrbOz5wDcHgMGdrnGUn9gmT9Z1YwzXWrP6NZ3gMA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598836; c=relaxed/simple;
	bh=Cg/zW0I8pepL6s5AwV6uMVENIFjhl/PnKbpucTLg7Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5cFiJ4eIMOZUw0pQYj6gunBG3SQ+8/EpiEpw49cie3PQw5j4QcI85h3a323gxGrtb8Qb7ebQdL1SlDisJP5ccjO7E67n5Lc1e0/00AQiBxKnX7LAeNFy7YtPQ8WDuPvoEcMqmJ3PIphC7cglIQ8/M/klVi1DRb/a0fSE3/l3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuMkIlcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13792C433F1;
	Tue,  5 Mar 2024 00:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709598836;
	bh=Cg/zW0I8pepL6s5AwV6uMVENIFjhl/PnKbpucTLg7Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuMkIlcnZpiMJsZap6GW67SAYvuKWmfOKIZaviJsCdxh93cqZkMmoClrSWeyRH6qq
	 anIdMyQ03/KLyxSA68Ey4uqDj5YH32hfkpd7NcZWQIWVHISB78Ek16VJ6l9HcWCRiQ
	 Xvw2K+V+zO9iEcC8CtsO9E2zgwIbg06nZzu+t8jOUIZxYie7bBw4Dpp6heZl6sSDBG
	 FJOVMJ2M4KlQW4oAM1zhTtitPYgOxgLGdcJD4tkROFv5k699TvoKDbu9YGjn58X1CK
	 q8D613OhpEnC7RM8rmj5d6b818IRzpFQXI/KY3Ao2+iqqPljpLDQFN0k8vy/tHCee/
	 WLbPb5OJC72Lg==
Date: Mon, 4 Mar 2024 16:33:54 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v5 09/24] fsverity: add tracepoints
Message-ID: <20240305003354.GD17145@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-11-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-11-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:32PM +0100, Andrey Albershteyn wrote:
> diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
> new file mode 100644
> index 000000000000..82966ecc5722
> --- /dev/null
> +++ b/include/trace/events/fsverity.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM fsverity
> +
> +#if !defined(_TRACE_FSVERITY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_FSVERITY_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct fsverity_descriptor;
> +struct merkle_tree_params;
> +struct fsverity_info;
> +
> +#define FSVERITY_TRACE_DIR_ASCEND	(1ul << 0)
> +#define FSVERITY_TRACE_DIR_DESCEND	(1ul << 1)
> +#define FSVERITY_HASH_SHOWN_LEN		20
> +
> +TRACE_EVENT(fsverity_enable,
> +	TP_PROTO(struct inode *inode, struct fsverity_descriptor *desc,
> +		struct merkle_tree_params *params),
> +	TP_ARGS(inode, desc, params),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(u64, data_size)
> +		__field(unsigned int, block_size)
> +		__field(unsigned int, num_levels)
> +		__field(u64, tree_size)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->data_size = desc->data_size;
> +		__entry->block_size = params->block_size;
> +		__entry->num_levels = params->num_levels;
> +		__entry->tree_size = params->tree_size;
> +	),
> +	TP_printk("ino %lu data size %llu tree size %llu block size %u levels %u",
> +		(unsigned long) __entry->ino,
> +		__entry->data_size,
> +		__entry->tree_size,
> +		__entry->block_size,
> +		__entry->num_levels)
> +);

All pointer parameters to the tracepoints should be const, so that it's clear
that the pointed-to-data isn't being modified.

The desc parameter is not needed for fsverity_enable, since it's only being used
for the file size which is also available in inode->i_size.

> +TRACE_EVENT(fsverity_tree_done,
> +	TP_PROTO(struct inode *inode, struct fsverity_descriptor *desc,
> +		struct merkle_tree_params *params),
> +	TP_ARGS(inode, desc, params),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(unsigned int, levels)
> +		__field(unsigned int, tree_blocks)
> +		__field(u64, tree_size)
> +		__array(u8, tree_hash, 64)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->levels = params->num_levels;
> +		__entry->tree_blocks =
> +			params->tree_size >> params->log_blocksize;
> +		__entry->tree_size = params->tree_size;
> +		memcpy(__entry->tree_hash, desc->root_hash, 64);
> +	),
> +	TP_printk("ino %lu levels %d tree_blocks %d tree_size %lld root_hash %s",
> +		(unsigned long) __entry->ino,
> +		__entry->levels,
> +		__entry->tree_blocks,
> +		__entry->tree_size,
> +		__print_hex(__entry->tree_hash, 64))
> +);

tree_blocks is using the wrong type (unsigned int instead of unsigned long), and
it doesn't seem very useful since there's already tree_size and the
fsverity_enable event which has block_size.

Also, the way this handles the hash is weird.  It shows 64 bytes, even if it's
shorter, and it doesn't show what algorithm it uses.  That makes the value hard
to use, as the same string could be shown for two hashes that are actually
different.  Maybe take a look at how fsverity-utils prints hashes.

Also, did you perhaps intend to use the file digest instead?  The "Merkle tree
root hash" isn't the actual file digest that userspace sees.  There's one more
level of hashing on top of that.

> +TRACE_EVENT(fsverity_verify_block,
> +	TP_PROTO(struct inode *inode, u64 offset),
> +	TP_ARGS(inode, offset),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(u64, offset)
> +		__field(unsigned int, block_size)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->offset = offset;
> +		__entry->block_size =
> +			inode->i_verity_info->tree_params.block_size;
> +	),
> +	TP_printk("ino %lu data offset %lld data block size %u",
> +		(unsigned long) __entry->ino,
> +		__entry->offset,
> +		__entry->block_size)
> +);

This should be named fsverity_verify_data_block, since it's invoked when a data
block is verified, not when a hash block is verified.  Or did you perhaps intend
for this to be invoked for all blocks?

Also, please don't use 'offset', as it's ambiguous.  We should follow the
convention used in the pagecache code where 'pos' is used for an offset in
bytes, and 'index' is used for an offset in something else such as blocks.
Likewise in the other tracepoints that are using 'offset'.

Also, the derefenece of ->i_verity_info seems a bit out of place.  This probably
should be passed the merkle_tree_params directly.

> +TRACE_EVENT(fsverity_merkle_tree_block_verified,
> +	TP_PROTO(struct inode *inode,
> +		 struct fsverity_blockbuf *block,
> +		 u8 direction),
> +	TP_ARGS(inode, block, direction),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(u64, offset)
> +		__field(u8, direction)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->offset = block->offset;
> +		__entry->direction = direction;
> +	),
> +	TP_printk("ino %lu block offset %llu %s",
> +		(unsigned long) __entry->ino,
> +		__entry->offset,
> +		__entry->direction == 0 ? "ascend" : "descend")
> +);

It looks like 'offset' is the index of the block in the whole Merkle tree, in
which case it should be called 'index'.  However perhaps it would be more useful
to provide a (level, index_in_level) pair?

Also, fsverity_merkle_tree_block_verified isn't just being invoked when a Merkle
tree block is being verified, but also when an already-verified block is seen.
That might make it confusing to use.  Perhaps it should be defined to be just
for when a block is being verified?

> +TRACE_EVENT(fsverity_invalidate_block,
> +	TP_PROTO(struct inode *inode, struct fsverity_blockbuf *block),
> +	TP_ARGS(inode, block),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(u64, offset)
> +		__field(unsigned int, block_size)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->offset = block->offset;
> +		__entry->block_size = block->size;
> +	),
> +	TP_printk("ino %lu block position %llu block size %u",
> +		(unsigned long) __entry->ino,
> +		__entry->offset,
> +		__entry->block_size)
> +);

fsverity_invalidate_merkle_tree_block?  And again, call 'offset' something else.

> +TRACE_EVENT(fsverity_read_merkle_tree_block,
> +	TP_PROTO(struct inode *inode, u64 offset, unsigned int log_blocksize),
> +	TP_ARGS(inode, offset, log_blocksize),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(u64, offset)
> +		__field(u64, index)
> +		__field(unsigned int, block_size)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->offset = offset;
> +		__entry->index = offset >> log_blocksize;
> +		__entry->block_size = 1 << log_blocksize;
> +	),
> +	TP_printk("ino %lu tree offset %llu block index %llu block hize %u",
> +		(unsigned long) __entry->ino,
> +		__entry->offset,
> +		__entry->index,
> +		__entry->block_size)
> +);

This tracepoint is never actually invoked.

Also it seems redundant to have both 'index' and 'offset'.

> +TRACE_EVENT(fsverity_verify_signature,
> +	TP_PROTO(const struct inode *inode, const u8 *signature, size_t sig_size),
> +	TP_ARGS(inode, signature, sig_size),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__dynamic_array(u8, signature, sig_size)
> +		__field(size_t, sig_size)
> +		__field(size_t, sig_size_show)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		memcpy(__get_dynamic_array(signature), signature, sig_size);
> +		__entry->sig_size = sig_size;
> +		__entry->sig_size_show = (sig_size > FSVERITY_HASH_SHOWN_LEN ?
> +			FSVERITY_HASH_SHOWN_LEN : sig_size);
> +	),
> +	TP_printk("ino %lu sig_size %lu %s%s%s",
> +		(unsigned long) __entry->ino,
> +		__entry->sig_size,
> +		(__entry->sig_size ? "sig " : ""),
> +		__print_hex(__get_dynamic_array(signature),
> +			__entry->sig_size_show),
> +		(__entry->sig_size ? "..." : ""))
> +);

Do you actually have plans to use the builtin signature support?  It's been
causing a lot of issues for people, so I've been discouraging people from using
it.  If there is no use case for this tracepoint then we shouldn't add it.

The way it's printing the signature is also weird.  It's incorrectly referring
to it a "hash", and it's only showing the first 20 bytes which might just
contain PKCS#7 boilerplate and not the actual signature.  So I'm not sure what
the purpose of this is.

Also, this tracepoint gets invoked even when there is no signature, which is
confusing.

- Eric

