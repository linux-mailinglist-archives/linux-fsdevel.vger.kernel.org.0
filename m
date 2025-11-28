Return-Path: <linux-fsdevel+bounces-70109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BEC90D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 05:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5FA434FDE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D42FD1A1;
	Fri, 28 Nov 2025 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m+OiuFDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449F126C03;
	Fri, 28 Nov 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764303974; cv=none; b=ED9IKGbIwJangaOii4UdWLjUwuhvHENfLrnCycTFwuQn7cbLrV3QXsAZrj+IiQxDCgU+8D8qUsbcUpX6+QhwcacZZ3S9/xuOEVRZBd8Q6RQL8o6RqiaZRlHrACNvvk+jDvLBGYcNbC3B+EVzG6szsU9VmibpS6BGyDgWeYFiq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764303974; c=relaxed/simple;
	bh=G3rcabL4LjRyW9r8LEwOdNoRc3fsHxrEndASpiI/tUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFYeiXbP82athHxXw/tiL0lZ8fTQ3Jm4A4++qqz90cz8w/sBRGR+QRGEdXZXmwl1whxThz5Cbob5dY/F7qREN6V2LRj9DKWuSuTORU4HPeq2vi41xfSfqEu76yJSactaVpST/mGlf5DpZdo7cTuNC+0hCL2iYQZO/VtBniBWCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m+OiuFDS; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764303969; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cpTLTqsR0Se78YHX4AWic1njjAyRkF7e2rK5uq6I4pI=;
	b=m+OiuFDSA5+8MfDN8Tr11M7UxfnktDlTwToZurObOqpdbhQxgpwpRPQri5PxGSFxqzIPlgixS37S6r6VVDHKSD40mnzPi0xyBE+3f1w6HyMkvxc1C+CkuAFp9mkPBs65xRov67zlGNiQLioTkMQ5y9NRZElNN8KP4OtoOybrrB0=
Received: from 30.221.130.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtaTf7-_1764303965 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Nov 2025 12:26:06 +0800
Message-ID: <7890283d-9a75-4622-ba37-0f70dffd9db9@linux.alibaba.com>
Date: Fri, 28 Nov 2025 12:26:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
 hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
 djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
 rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
 ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
 gunho.lee@lge.com, Winston Wen <wentao@uniontech.com>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <85070A96ED55AF8F+20251128094644.060dd48e@winn-pc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <85070A96ED55AF8F+20251128094644.060dd48e@winn-pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/28 09:46, Winston Wen wrote:
> On Thu, 27 Nov 2025 13:59:33 +0900
> Namjae Jeon <linkinjeon@kernel.org> wrote:

...

> 
> Given your proven track record with the exfat driver upstreaming and
> maintenance, we are confident in the quality and future of this
> ntfsplus initiative. We are hopeful that it will address the
> long-standing gaps we've observed.
Just for the record here, I heard about this from Namjae almost
a year ago about this. Personally, I support this NTFS work simply
because Namjae has a good visible reputation in the community
as well as he is a real kernel filesystem developer active for
more than a decade. I can imagine it will be more likely to be
a success (and healthy driven by the community development)
compared to previous attempts.

Currently I am lacking time for this, but I could help if needed.

Thanks,
Gao Xiang

