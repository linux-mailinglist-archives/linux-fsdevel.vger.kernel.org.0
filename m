Return-Path: <linux-fsdevel+bounces-20412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413198D2EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD0F28B094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50316A36D;
	Wed, 29 May 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfbgA6jN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89832168C3D;
	Wed, 29 May 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968903; cv=none; b=AgKiAlLGKjjHD1FlVwQGkCvuGbonD+yPwxCi9NFyAz9XwfkBdl11WxpkXXwjvTOM3wyFD9PSIr65Ff6tsg+xpy5sZ1aQ71qYJxyZskij1Gb/Mw/GN+rg378CHhr0yWxyO/IrW880ruIZcoCzpqg4/aALnp97RK75o452yN+N/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968903; c=relaxed/simple;
	bh=S3iTcM1ZSPmjm7GZozDt8RGkp17GchQ3Ca1mGNH4Urc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjRZQkdMKZgcQdVHlToFkLnSnnqrOn29v5LPQqdVK6arkKQQYQtKHCG1H/UhEqhAv99TtWd1y+0TWnbbBMFYvvYBRyVjWmswIUmKiX2WpmayH1fBLa6MgbJWMFCiZDH5IFpUpoDXvDjWNvxBXEdKIjWVzj9v9SPyQ4BwyeEmg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfbgA6jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F7C2BD10;
	Wed, 29 May 2024 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968903;
	bh=S3iTcM1ZSPmjm7GZozDt8RGkp17GchQ3Ca1mGNH4Urc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dfbgA6jNdLtv905YzgHRwUpIcUYBb2/FqhbHwVVPi8jDYBzJegkHqnKtVllDgSZxJ
	 hl119F1YITV2L0CzUXjFMz0P8CY1JoKC531SnvSR0HoJ9YdSPXasTOt6h/EqHBOz5D
	 L6tidnnLJT9F5jmKbw3Jjz/je6ejB31Y6FneddoZhnRuBt9uZ2weZz0M8qraIlnOGu
	 b564lvPJrYPe1xyTLSU6lOiEFiwyarsZVBy/9tTbFhKAXiUQ99rmKkFZCc0tkP24fr
	 AM3HjKJP/ev9C0RkvyustpQi11rCci5L99jxRXkdkeoJFk08ttBvU+/Hb1H+2ytDwu
	 nVyuobiiw1hmg==
Message-ID: <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
Date: Wed, 29 May 2024 16:48:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/24 15:17, Nitesh Shetty wrote:
> On 24/05/24 01:33PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>>> Since copy is a composite operation involving src and dst sectors/lba,
>>> each needs to be represented by a separate bio to make it compatible
>>> with device mapper.
>>> We expect caller to take a plug and send bio with destination information,
>>> followed by bio with source information.
>>> Once the dst bio arrives we form a request and wait for source
>>> bio. Upon arrival of source bio we merge these two bio's and send
>>> corresponding request down to device driver.
>>> Merging non copy offload bio is avoided by checking for copy specific
>>> opcodes in merge function.
>>
>> In this patch I don't see any changes for blk_attempt_bio_merge(). Does
>> this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
>> happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?
>>
> Yes, in this case copy won't work, as both src and dst bio reach driver
> as part of separate requests.
> We will add this as part of documentation.

So that means that 2 major SAS HBAs which set this flag (megaraid and mpt3sas)
will not get support for copy offload ? Not ideal, by far.

-- 
Damien Le Moal
Western Digital Research


