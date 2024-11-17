Return-Path: <linux-fsdevel+bounces-35032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271E9D0239
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0421C2834F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 06:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840D405FB;
	Sun, 17 Nov 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="QvmqafI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BDF33E1;
	Sun, 17 Nov 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731824794; cv=pass; b=BUQkoZfvN8QplMH6GkLl5CbKNCVrDeI2j+iBdnUButS5Hjgr7WHhxVUhNqJyap89GihuFWQfsseDmQkXosqGRxFGvoChEZh/TnHpByocybe89XXb62nbK+01iV+GEiiuORLQ7L6MGPRNPFg+1z59Ph1gOYyAfnPlv8X6Y9zdRi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731824794; c=relaxed/simple;
	bh=YMPx2AXDqKjUxOi+5jt+Q+U8XxjW1e4C/lY32y+3znw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AfIYccXoE5WPE7ewvJH8THSHFCkuRUe5Fg6GDhhU899H56uwh86pM7aE357FjFPztpiKcyOJtmYmDbZhhLN7qkquKxsZoTD6NZEA6jHr3u6eXcQ5bXjfh0fxxaSMikIMmEGYGJinIdzZpxBHzwMjXVeHsZenxcMpclQE3kVR4EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=QvmqafI0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731824731; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D4Aq/DVwh/E3mUk0AG0S5Rkccm2R3LfyRqCNmZHkrj0S2rjwM2OjXq44H+KuqulSX/LziacyOF5ZL64p2FStQbwkvTL5r4cZSsDNojeOW5WAG7qU0KV9StgNmRjHI7wwy3m2QZM5CbVvsF3uwdbKFSAkPGNTwdrVGwI4aIp3/4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731824731; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eNkA+jOGDoBF1DzR74xP3oYFLSKLz/pv/89Q3x7ZaZI=; 
	b=GW6kKq2tzjR8S0/4u4ILXKTcaxwWNzh6CLdEPIbc0vrXOjYmZfV7OFDr/Kl0xCLRYhAIQKLDyQX61f9iXTtOha2ABKyPKG59YYQgHQmlf/QgHMWOzLpEpcRgR3X9KhqZefdV39iZNnOwYug7fojg1OlGAOx9s0ZSOX5Oq60BzUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731824731;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eNkA+jOGDoBF1DzR74xP3oYFLSKLz/pv/89Q3x7ZaZI=;
	b=QvmqafI0vODLG/AZyo9Iogi0eBuzYZ8EM7yRdBOgl/S0MMA50m9aTBr2XfjOmhAW
	WeJhKDIQAiptxJiyQc28GcLpkpxBIOGMgiL7lPelj9yzTw2EV1LNM+dTXJy9E9dursR
	b2bEtyISmG6frMJ8xpzhCn1NlPPWmEzhGzvB7TSg=
Received: by mx.zohomail.com with SMTPS id 1731824729720682.8589924584546;
	Sat, 16 Nov 2024 22:25:29 -0800 (PST)
Message-ID: <9868242c-ce91-421c-8f55-1185a66657ce@collabora.com>
Date: Sun, 17 Nov 2024 11:25:13 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com
Subject: Re: [RFCv1 6/6] selftests/page_detective: Introduce self tests for
 Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net,
 derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
 vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
 willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
 ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com,
 tandersen@netflix.com, rientjes@google.com, gthelen@google.com
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-7-pasha.tatashin@soleen.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241116175922.3265872-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/16/24 10:59 PM, Pasha Tatashin wrote:
> Add self tests for Page Detective, it contains testing of several memory
> types, and also some negative/bad input tests.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/page_detective/.gitignore       |   1 +
No need to add a new directory. Please just add the tests in 
selftests/mm/ directory.

>  .../testing/selftests/page_detective/Makefile |   7 +
>  tools/testing/selftests/page_detective/config |   4 +
>  .../page_detective/page_detective_test.c      | 727 ++++++++++++++++++
>  6 files changed, 741 insertions(+)
>  create mode 100644 tools/testing/selftests/page_detective/.gitignore
>  create mode 100644 tools/testing/selftests/page_detective/Makefile
>  create mode 100644 tools/testing/selftests/page_detective/config
>  create mode 100644 tools/testing/selftests/page_detective/page_detective_test.c

-- 
BR,
Muhammad Usama Anjum


