Return-Path: <linux-fsdevel+bounces-9471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA78416DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9271F1C23C37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DD85466D;
	Mon, 29 Jan 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpBD0pkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F153E09;
	Mon, 29 Jan 2024 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570948; cv=none; b=UNIYTUobrs/YwKh8gvX1BIuLKElGyYEX9vdRyF1/rzayvFT4yGBrdavNhaE0uquPUnvUZVFq6o1ucryTRCEIaOcNMx7FQFM1W9LhPEYWx4AKyaEtaB91N51xIaedIag6mJ8UxsqTcaNfgrZEmqQr8N9MxZvafGSTh8l3Ans87U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570948; c=relaxed/simple;
	bh=ndf2vLbvZIQYQNE9pREjH50tsvV7CWwMiqHG6sTVNIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bR6dpmPdpS6CoI5K3w8U6gJmtP7cJtroLRgJfJ8rvPPO6lsKpVzrTf1tHSZ1BzXObmWsSj94WSu8Ndby3+k7++EQTnYcsQc5lIp9B5dSFOkBiXSbjPuT+6KsVyHr2GP4V1z3NHo2spoY1QDr9RLZ0A1Josy7sZWqGUOT0VMuZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpBD0pkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E688AC433C7;
	Mon, 29 Jan 2024 23:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570947;
	bh=ndf2vLbvZIQYQNE9pREjH50tsvV7CWwMiqHG6sTVNIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JpBD0pkApJsK1Lg9ekUAGkwlA0Sbgqlz2H8WvXFr8iKhHM0b0IKbSZ6wD1tcoj01C
	 DAovaEmy1aQXXzXMi2eQqUicPt4RfmG+am5adv7Qi73Q/sVjaPYxdHLM/Rpp9YOQON
	 YTdmRNVd6ARkl6PESrOQRGLy3l7DrYzuvUwDAYFGOee7U+d69xlAmHUwcC6ekt+ocA
	 V3sVhjRDUyF3KKAXV5sARfdzPALFpWl/tHwOykZZOkrIIIvezVsidD0NjebjuOmDUV
	 +my52WioNda7fDaQyJSmIRUSaQKuHEje67Ngc6C13QyBYk96LdB9iPoJR7+jxg8N7w
	 bB/k4NsdipxfQ==
Message-ID: <100af933-2253-45df-9045-5bd8e273df12@kernel.org>
Date: Tue, 30 Jan 2024 08:29:04 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] block: remove gfp_flags from blkdev_zone_mgmt
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Now that all callers pass in GFP_KERNEL to blkdev_zone_mgmt() and use
> memalloc_no{io,fs}_{save,restore}() to define the allocation scope, we can
> drop the gfp_mask parameter from blkdev_zone_mgmt() as well as
> blkdev_zone_reset_all() and blkdev_zone_reset_all_emulated().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

But let me check zonefs (patch 1).

-- 
Damien Le Moal
Western Digital Research


