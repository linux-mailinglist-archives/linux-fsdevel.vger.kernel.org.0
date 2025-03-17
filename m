Return-Path: <linux-fsdevel+bounces-44171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095ABA64158
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB731891A3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C740219A9D;
	Mon, 17 Mar 2025 06:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990F218EA2;
	Mon, 17 Mar 2025 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192594; cv=none; b=E2Aat91sW396lYT2HV6MCUxBDZuw74tCcNM14JUmXWzS8K9TcQt6rE2g/DoMqAZp1ZPb34aUHlReLspzbAASAu3fXwA6WK5mxTiclMZ+x/kxrMW6gnddQjFRRmXZ2e5yvtVtOyhLv4TumWPA60rFi+8agooAKasq8GIMKiCiGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192594; c=relaxed/simple;
	bh=2KDn1pv2L9098J0m88wuXXYNFHtzdIKyYcdE0A6m9xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG3mFwCasQjUOdV0FHJilirUbQw/FxpyNIurCKpAuT7DO3cLanMeUN7mEMKBknb41oU8KX62BBTNmcU9P/6fNOYQLAIcVbfXVetAXjO7kVNzd5EqJEqjRQXF871moHBsSgvBR04NDAalWcPU56rvtDjRJReSrQ30X4x5nY1wsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0F7E68B05; Mon, 17 Mar 2025 07:23:06 +0100 (CET)
Date: Mon, 17 Mar 2025 07:23:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 09/13] xfs: add XFS_REFLINK_ALLOC_EXTSZALIGN
Message-ID: <20250317062306.GI27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-10-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 05:13:06PM +0000, John Garry wrote:
> +	 if (flags & XFS_REFLINK_ALLOC_EXTSZALIGN)

This line has an extra whitespace.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

