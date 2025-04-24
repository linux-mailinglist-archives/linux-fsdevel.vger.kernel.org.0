Return-Path: <linux-fsdevel+bounces-47160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A868BA9A14F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DFC194676C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DCB1DED42;
	Thu, 24 Apr 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7iYDbSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DB199948;
	Thu, 24 Apr 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475297; cv=none; b=kcZlzNIkNw4HRsNcnY0b+AYfwpnbqf1NeFU04btdGlgZMaOmbDqGGhqQnIxI+JYw0o1hQdVd9PCBWSNIhrjNDYii0M7FA1yd9s8ada4xvLfb9Z9zdmLs9HKLVG90mtYHjc9Pp5dvibSDxt6SbdKXiS3AaKwq5f9jBGE7Csjt3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475297; c=relaxed/simple;
	bh=8RoLzbdmrPHybDtten93nhXbJHJr4s/PjDxGqiEiSQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUBN64bRozxo3wAqALY0Va2El8nDb0Yu3Qy9wPseHbvdOO4F0NIA9d5AOMOfDDIFj/VwNMTHf49kZCPY+wLKohDK8yPCBc+PqEOqCSfJxEXLNHsyLUl6V19uBZ2zMc7YJDQHjeAjH8GH5bvdWCsJD352NXRjvp+dcjmDInKEz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7iYDbSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2D8C4CEE3;
	Thu, 24 Apr 2025 06:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475297;
	bh=8RoLzbdmrPHybDtten93nhXbJHJr4s/PjDxGqiEiSQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r7iYDbSt5R424NhNkx8Xyrb1occ7x871FHKT7pwaF9UG/fXMObIvzIzGungVPea2b
	 Y7VOPCgYXb76gikPNuy9uNRVIoS1cVZrPhke/JObDxO5XvvmcqQ8mpOpWgGVsdHYRC
	 CJt292XnAma5ZBfOtgFvlTTgXtINkPO/DWPARjrKivnckCYGS5m8cNlK2lesFCxjF/
	 pIg5uO5U9xtPNoA/7h0Q13pGcE8+GRddsFoC7Y3T5FJYQVYktKnOs5P47Ia1PdUp2F
	 5wcj3/14LLOqHFupblii+zxMzwjchMnoof58xcJoIc6z5k9tZT47of+RFHD5h+N9MT
	 T9TaLQqPV/agQ==
Message-ID: <71b655fb-9b01-4e29-9b8a-46debd059d7f@kernel.org>
Date: Thu, 24 Apr 2025 15:14:52 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] dm-bufio: use bio_add_virt_nofail
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-9-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

