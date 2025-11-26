Return-Path: <linux-fsdevel+bounces-69866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3EC88E23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AF314E9082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A7311949;
	Wed, 26 Nov 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gG1GeleT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD436285071;
	Wed, 26 Nov 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148377; cv=none; b=BvK5Dq3V+crgL5ZAeYNkuTgbDTZjfD7a7K4kAs3S0mEkk/Z7ZfZ9BQsvP72vjnfVFUkjJ3nBWeUJmsV9pxBYb8keGQK8V5d8b5Qgt4M+CUcHAOKui7IVX1H+2ZstuHpt46no5Fc5fc7+/Yqv38QB/E3cZYe5xbMdBhiOd4yzq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148377; c=relaxed/simple;
	bh=nFyMVsSufAE1y6HRQ7xEm7tSUQ9PcLP7necJjbtfNxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SvhzqnRvkdETqhFIU1cFZzVAD3Ku7lRu6/EHU8TO5eVATPGdtcS01G1OtahO8mKeyMG/xklxoXTO1fVwAsDA1ast5yeN/UKHmDD9WYkP5hN457Ka3cCzS/JVORqEaqbsIJAyz3FhlTnXPLFzjJ3+2FZ37d/P0XgSoIT+T9tFySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gG1GeleT; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pK7iG/jT1pm79YRG1GvueV8H6gnyb9LCDKdVlOgfXnM=;
	b=gG1GeleTqTWcvH02918cIxdzys1PeGSDDw5ol4uEQ2omRl2JUl6NRG2vj06SdziEU4wkpPv+P
	N6ldwSmb+BQXu1k1v0kCKnBwhW0KZgrmFXmJvcOzZEVK/OlR+lHbQ1XNotS8IeeF7CLHRrutCwd
	FP+deOBQ58OWTUIjZzHJgi0=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dGYhb1qsPznTWk;
	Wed, 26 Nov 2025 17:11:27 +0800 (CST)
Received: from kwepemr100006.china.huawei.com (unknown [7.202.194.218])
	by mail.maildlp.com (Postfix) with ESMTPS id D455218001B;
	Wed, 26 Nov 2025 17:12:50 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemr100006.china.huawei.com (7.202.194.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 26 Nov 2025 17:12:50 +0800
Message-ID: <7ebbd365-702c-4491-86c6-23c6242ba80d@huawei.com>
Date: Wed, 26 Nov 2025 17:12:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: improve integrity checking in __mb_check_buddy
 by enhancing order-0 validation
To: Theodore Tso <tytso@mit.edu>
CC: Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, <libaokun1@huawei.com>, <chengzhihao1@huawei.com>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
 <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
 <6mjxlmvxs4p7k3rgs2cx3ny5u3o5tuikzpxxuqepq5yv6xcxk3@nvmzrpu2ooel>
 <2d7f50d1-36f0-452c-9bbe-4baaf7da34ce@huawei.com>
 <20251125214739.GA59583@mac.lan>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <20251125214739.GA59583@mac.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100006.china.huawei.com (7.202.194.218)



在 2025/11/26 5:47, Theodore Tso 写道:
> On Thu, Nov 06, 2025 at 10:59:22AM +0800, Sun Yongjian wrote:
>>
>> Thanks a lot for pointing out the logical flaw! Yes, you’re right—if order-0
>> bit pair is clear, then without a single 0 showing up at any higher order
>> we’ll never enter the `if` branch to run `MB_CHECK_ASSERT`. The code you
>> proposed is indeed a better, more elegant implementation!
> 
> Were you planning on sending a revised version of this patch set with
> the suggested change?
> 
> Thanks,
> 
> 						- Ted
> 

Hi Ted!

Thank you for the reminder. Yes, I've already sent the revised version 
with the suggested changes, you might have missed this email 🙂

https://lore.kernel.org/all/20251106060614.631382-1-sunyongjian@huaweicloud.com/

Cheers,
Yongjian

