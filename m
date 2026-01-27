Return-Path: <linux-fsdevel+bounces-75561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHCdHCAReGnyngEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:13:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19708EA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3468E301D6A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78044225402;
	Tue, 27 Jan 2026 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q9fMesqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0D221FB6;
	Tue, 27 Jan 2026 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476370; cv=none; b=qqC4r1L0hlsrqkYTrowfXweDRMv3Co3SYKt2KygEckmfFw5iJXOr6mFrPU1PnIOTfTDXGvDNAL1zc+GzArG31um0wfhhuIIouuwHxdVKgQOVgHaFabRoJ/QtD09oMqPKcdbS9UWcOrXr1GFB52w5AvShqebE2AloKKpGZMgtg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476370; c=relaxed/simple;
	bh=9z4BMQamy2eIcsA1RCpI0lsFpa8w7wurJv4MoKUiqgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZHHRiVj79l8p6GsC1SEcj/yfyJ6oPriilUKXwosyv5zYJbr9OLouyZnLgQv6htCBPntWzJ2hfRqv2hgRqeuE0z+Gb+JqZ8pTqeoWNIjNOyrgPieNHcEVWz0K7net6a5C8buYUt61vzot7DmaDi8hCDW28MAl1djCPZpoxKG4U2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q9fMesqp; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9z4BMQamy2eIcsA1RCpI0lsFpa8w7wurJv4MoKUiqgg=;
	b=q9fMesqp5S+jlrRGLjwZpMrhDBRagd/VuG1qurXqHkIsdyD1EsZSczXeo+8orQu516MTy7DQ+
	lYcruWuZWu0KPnOPmarujf3Nwapxe1fAgpb1Q43S7d7L00WPgEeEjx3VD3YWuqzFW783yLAGkfp
	60+HTkdT97OYwi7Qot7k4G8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f0S3Z5JFPz1prL2;
	Tue, 27 Jan 2026 09:09:14 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id C7C3640539;
	Tue, 27 Jan 2026 09:12:43 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Jan 2026 09:12:42 +0800
Message-ID: <496fe218-dca3-477b-89f4-0f71adb155f6@huawei.com>
Date: Tue, 27 Jan 2026 09:12:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
To: Andrew Morton <akpm@linux-foundation.org>, Shardul B
	<shardul.b@mpiricsoftware.com>
CC: <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dev.jain@arm.com>, <david@kernel.org>, <janak@mpiricsoftware.com>,
	<shardulsb08@gmail.com>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
 <b2b99877afef36d9c79777846d19beeb14c81159.camel@mpiricsoftware.com>
 <19bf8d68cdb.ae2c0d37126486.8380742359510867201@mpiricsoftware.com>
 <20260126120451.0c28a6deb3ab532dfae40a24@linux-foundation.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <20260126120451.0c28a6deb3ab532dfae40a24@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kvack.org,vger.kernel.org,arm.com,kernel.org,mpiricsoftware.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75561-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tujinjiang@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: E19708EA2A
X-Rspamd-Action: no action


在 2026/1/27 4:04, Andrew Morton 写道:
> On Mon, 26 Jan 2026 11:16:08 +0530 Shardul B <shardul.b@mpiricsoftware.com> wrote:
>
>> Hi Matthew, Andrew,
>>
>>
>> Gently pinging this patch. I’ve checked the latest linux-next (next-20260123) and the akpm-unstable branches, and it doesn't appear to have been picked up yet.
>>
>>
>> The patch has a Reviewed-by from David Hildenbrand and fixes a memory leak in the XArray library identified by syzbot.
>>
>>
>> If there are no further concerns, could you please let me know if this is queued for the next cycle?
> There are comments from Jinjiang Tu and Dev Jain which remain
> unaddressed, please.

Hi, Andrew

The issue is another problem, independent ofShardul's patch.

I have posted a patch to solve it.
https://lore.kernel.org/linux-mm/20260121062243.1893129-1-tujinjiang@huawei.com

> The leak is a rare and this is a minor problem, I believe?
>
> I'll queue the patch for some exposure and testing but it appears that
> some additional consideration is needed before it should be progressed
> further.
>

