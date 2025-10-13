Return-Path: <linux-fsdevel+bounces-63932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48207BD1F73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917603B042D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C82ECEAB;
	Mon, 13 Oct 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3AtLQ1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82971DE3B5;
	Mon, 13 Oct 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343269; cv=none; b=T7fYFVlw97D6Sq45wKHyd5GfY7jOeKrBQCtNt06UXXKEPfOLkgTm3qRKu1/x/fy1FV8O3G3pJtfamSVcJFZkS2lq2qDC6JRxKbUdvoIglmAL/56r7V1v2Wc7MEywPZR9rRDD6Gyo3pPktsUe7CmYFdWOVk8j2f/lR0nxQUJ46YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343269; c=relaxed/simple;
	bh=TlFiaImgbVabS38jmlSM6UkcfOwbkJdDdnK/tEF+2vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIn+AGhM1v/Bon0Z5P3tALZ0atmZFw2lkMRamm+MfI2gIA6x49mEWoeAiIOeV1MLd27AphASIWeOAGv0vgYb02sQhlhqtt3qhTJQ84PzAurq+a79PvGN3DFHYEBQpF1zpo8k8040lTcerdr7mZ8ZZKFni0iwZHS1P/aa6fqa0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3AtLQ1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A99C4CEE7;
	Mon, 13 Oct 2025 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760343269;
	bh=TlFiaImgbVabS38jmlSM6UkcfOwbkJdDdnK/tEF+2vY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V3AtLQ1fS8zZ/2ezshsTwCsBvJcjgi0ekhuX1RhLLC8H5aAMLaGDUkWo/LvUlIIm9
	 OvzGYgpbpld7XTthVPMOdKM5yOUnL/uGR4mhcQ1zjDDEOP3a4FYRFN8MDfAJZ0hN/0
	 B1r73UiFOk74eDqSWg51UPKQ6EsGQ6x8a0MyvK5PQNUWG4pyM44sqa5bLKYCC8etQt
	 EfcNW1rBaNDRxSpFuNXseyY3tXMjkeLDN1sMysKNKPQZECVPp/0y1gnONQUpiVl/40
	 mAg7LJim2aPbunYRmHMLtQevGQBRb1g/DQUfQHKcxpy9z2fbpePDVuqKd5KoQ0NQJS
	 noU/c3DYR/HIA==
Message-ID: <2fd2cca0-6669-47c0-a322-4c702d5319d3@kernel.org>
Date: Mon, 13 Oct 2025 17:14:24 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: rename filemap_flush to filemap_fdatawrite_kick
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
 <20251013025808.4111128-11-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> Make the naming consistent with the other helpers and get away from
> the flush terminology that is way to overloaded.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

