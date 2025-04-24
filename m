Return-Path: <linux-fsdevel+bounces-47156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8FA9A105
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DB55A25F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F01DE2CB;
	Thu, 24 Apr 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMHxCcfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A933198A11;
	Thu, 24 Apr 2025 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474951; cv=none; b=aARwI3VAtm3ADO6OAU00utPn9Tf2KLykvfajlRM2JassP2Sn94FEcQcgkuvxFInLueyljhtG66Eli3fbpmVsT3i6iuhurzot+CiopT66Q51FgFlNfKD3ee3ynvHmcqwcnl10RnpqVz7hgDdjH5w2NyhtPkoVXuUUqF2gBLKoAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474951; c=relaxed/simple;
	bh=BVSDkYQ8LVV8v1ugx4BRXNcVyN6sGUsK5pW+EQhOZWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DODZewcgCipCeCqcaQOTbfHoxM/aA0vGagPd4CNFLJl4I0oWwdKWZHQbmXEpea5FBHYljPL2AAO/Ejg41nuAJpPvVtpoX1cobB6mUF0qVmesKVcnTPKLXtlAkT8oppvFjnnAYuJ2aUZx3//QnfOlBf/lPWv9WbHhnzPNpBk+34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMHxCcfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B8AC4CEE3;
	Thu, 24 Apr 2025 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745474950;
	bh=BVSDkYQ8LVV8v1ugx4BRXNcVyN6sGUsK5pW+EQhOZWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMHxCcfwGUElwKdVK9BNrBksnQ686Yz9pwgkuWQPytujvQEVhW4kJnPFlsn46/sQD
	 DFIdOpftAC+w5d1JGqVsf5HwbbQujiKFokXecKwtH9NTtR80hUgXbMU4uvl9ZbA7by
	 dfGAcOp0hUx+HUjB3x1qa86YcEhDJGdE8e1wv5hghfJ7o0yL/WUVQ6cliv4FLugKz1
	 PjuynclPQLjRkeub+Jo/WN/B+/O9qgngBcIqgJeCpgV4+oYSME2cJlupCVreZeXHAc
	 4M9P/yB4ZxcdT+IeSnA7Pf6eVonx4GANnsdmAfLm2v3+i/Y4F6+LCBYlPNDj1X2tIn
	 qL4y8fEh5J33A==
Message-ID: <7a56f76c-7916-42ac-ae5c-6e30c3dbd643@kernel.org>
Date: Thu, 24 Apr 2025 15:09:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] block: remove the q argument from blk_rq_map_kern
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
 <20250422142628.1553523-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Remove the q argument from blk_rq_map_kern and the internal helpers
> called by it as the queue can trivially be derived from the request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

