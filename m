Return-Path: <linux-fsdevel+bounces-45125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C0A73099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097277A39B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372422135D0;
	Thu, 27 Mar 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="il2Jx2u+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F6144304;
	Thu, 27 Mar 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076031; cv=none; b=K79PJ31OiJ4q1WK5sic2MuWul5u1VCCrpfi3q/DZJPhPZ5x5OaBwHoU509w44tgyDdaV/3efkpXEvlOcf7jdQQ0pewoW86kMi5jxxID32pamGoNBckcurt4yFY1z44JqU0VaMpUdhMb9gXqSP02LzbQBK6GKQUMQSx9krhfCQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076031; c=relaxed/simple;
	bh=kSdwXpxCX7RhwYUTyzoT1ZWlicm1uvWqw4brkcU7tbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSeWS5u/FhIzMmvHGoQkqyGGD/UxKG74LLs13UPxAQ1T4dQ0rVQC7v2piBZOclmySdOA6J14KNbQA5HgWFGrelfj8JcUdtTQP3UXdE7/NU+m2pgJkQPn4pb1F8Vw0gg8dZFJLJkKcTYCuSTaA/9HdTXkueQFffzSye0MmVrNye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=il2Jx2u+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=qrpe8txb61wqy1P8MLVoBIkRkcteytpXmgLZG0cVFOY=;
	b=il2Jx2u+2CE6Z8Tko273bXDzFAk4Hq4iSWcoXYNyB38+xB94M8TFunF2+MzlQu
	04FGzP0fCoGjnMIxiNtY/hYqWDCnwtbZOv6xERMWse51N7znjJxMe9taFeql/vyF
	I+ua3I3uWwz8fy+9SBEYqTAezEfNHFIPCO615tvC4wIvU=
Received: from [192.168.5.16] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3l3yQOuVnhaJ1AA--.12270S2;
	Thu, 27 Mar 2025 19:46:25 +0800 (CST)
Message-ID: <af42c4fb-925a-4c3f-b54e-a07dff8bb168@163.com>
Date: Thu, 27 Mar 2025 19:46:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: Rename iomap_last_written_block to
 iomap_first_unchanged_block
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, djwong@kernel.org, brauner@kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250327055706.3668207-1-chizhiling@163.com>
 <Z-Up3xt1q9swlhv_@infradead.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <Z-Up3xt1q9swlhv_@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3l3yQOuVnhaJ1AA--.12270S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1UKr4xZF4fKr1UKFW3ZFb_yoW3Xwb_ur
	W0qr1kCF1vqFs0vF4DuF4fJFZaqa1UW348XrW5Jrs7X34fCFZrJF15ur9avr4DGa1Sy3Z8
	Gr409F129r129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRizBT7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgAsdnWfk5UUKaQADsI

On 2025/3/27 18:35, Christoph Hellwig wrote:
> On Thu, Mar 27, 2025 at 01:57:06PM +0800, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> This renames iomap_last_written_block() to iomap_first_unchanged_block()
>> to better reflect its actual behavior of finding the first unmodified
>> block after partial writes, improving code readability.
> 
> Does it?  I it used in the context of a write operation where uncached
> is not exactly well define.  I'm not a native speaker, but I don't see
> an improvement here (then again I picked the current name, so I might be
> biassed).

Okay, actually 'last_written_block' also makes sense, it's just that it 
returns the end of the last written block, not the beginning


thanks,
Chi Zhiling


