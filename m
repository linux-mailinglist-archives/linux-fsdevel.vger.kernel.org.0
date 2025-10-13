Return-Path: <linux-fsdevel+bounces-63929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5BBD1EF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86701898CAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D642ECD10;
	Mon, 13 Oct 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ+uHNeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05D2EB5A1;
	Mon, 13 Oct 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342949; cv=none; b=YdyBn4UUO5E3O8qi7XkI9LwJPhEFmqkNQSB9opdol4ZMYJZtI3Tl/APPVqLTYcmkmiiixeoLDLoMPtqgITCuFPv2o+yO7INnP0/Om6emz/WQUZ4VMnbdav7nzQR31ojYmv6VX7hg2gQot+taIn29BVpc6IMPvP1VnDMYNXHypuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342949; c=relaxed/simple;
	bh=gDCK0s48HW2hUV0Q7ClAR5lIhUaH2d/9Yb/F3zIIufk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4AzZM57JwwXOge5wJ2GzPtVYbnZcgHNFii3e1W38x4oI4g5w2bGiW4U0hBExv1zUfgE07y+bpNKsh1K/3Z/Gk0hE6fE3oc/ct4ufDRYuU2ATFxVaAPwG4Nl3GgGm5V/VtX5A9S8MrJA701IFt7qOikYB87QoyNJpMgwSoDLPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ+uHNeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F32C4CEE7;
	Mon, 13 Oct 2025 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760342946;
	bh=gDCK0s48HW2hUV0Q7ClAR5lIhUaH2d/9Yb/F3zIIufk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iJ+uHNePZM88j5ktJ5Bn1podhcv/yo+c/xoKWvmJCMV2YxHE+DNLDoI56qVkiCpTn
	 TxoscpmAdTgCxdgycT4KHSRE3r70iCpIgB7T7rI+1qUaM6ZZ+nt7mZjUbSA4b7Lrux
	 lUjw2K+OcCGzjj/6Ls0XCbV18L5FC4//4YoTGf/NMPzI6P1qWPH60TtfBA4kJShdjC
	 iqqE20h+7G6vYXYQLxzOsnRt8mRSEdjloLa4cbPqMDozwhAdJFn5cCaxx1RclH6zYT
	 Ysxe5J51HpSdoRXr4GrxLj69WDrKliXSJ4D7ff5TWJkpFEP96aTqY2YXjNkXI3Iwox
	 H2lbji/ExBBBg==
Message-ID: <e0fa533d-c3c4-4a94-9e22-c379d69cb640@kernel.org>
Date: Mon, 13 Oct 2025 17:09:02 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm: remove __filemap_fdatawrite_range
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-10-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range and filemap_fdatawrite_range_kick instead
> of the low-level __filemap_fdatawrite_range that requires the caller
> to know the internals of the writeback_control structure and remove
> __filemap_fdatawrite_range now that it is trivial and only two callers
> would be left.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

