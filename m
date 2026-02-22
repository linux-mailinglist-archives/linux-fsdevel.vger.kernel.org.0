Return-Path: <linux-fsdevel+bounces-77875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOb0Bs+Om2lP2AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:18:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CB170B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29B5301AF48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA035CB96;
	Sun, 22 Feb 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E5EBItJ2";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Hr3sEs+G";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Hr3sEs+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta41.messagelabs.com (mail1.bemta41.messagelabs.com [195.245.230.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392881D514E;
	Sun, 22 Feb 2026 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.245.230.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771802299; cv=none; b=LEEAYBW5ab9etvqmGwseGkcyw2wXzjycofNpSUzTT109qU2/peZcHLcoIyYjVAIEki/UJgHSLdiFRSwHIeoKWwKOpZHt3EsxN/9QH/SBR8pDGbTKzQElquQZ/JGqvNVBPN0XZHiZVXKA8t9hc7puH+dpZu/kvAMw9Dk12oyeFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771802299; c=relaxed/simple;
	bh=Bp1kcCAzTgPy3IlFrjGUNEol6PjJwCi9eAmQmhXFT7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWEVDYPzA/DuP6rRYaMuU9LDUF93NYj9bweCOJWCxj1oIpQCmKx+4mS8XgEBGazsBRH5OnWTXuEgaTSxjRtx1GuKfn0M1AmwwXI8U3sCKAOacPPecKZD2N8m7OqsHF+dw3gFpy5BW0+XFDAVout7OYEuMZP8y9H6BvojjfYCd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E5EBItJ2; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Hr3sEs+G; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Hr3sEs+G; arc=none smtp.client-ip=195.245.230.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1771802295; i=@fujitsu.com;
	bh=FdhqfBmWI1Vf3l9kwQ3rKzdU4/e6QfF0KHGTJW93ihI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	b=E5EBItJ2ZzovLF2zFZUe5VkoWiBx0M09mCqe95aL2KtbR28YG148xPPGpQLUxkaQv
	 oZHWENsotDPRHcxLddOhBEQSE8uZ7rBq22HUaPcuwG2FlB8I+Ar08n3d3bb1ZTTnjl
	 HNt62ccS/kZFeQgUAtm9jg4OqlZR0HWj5f+r1NZzrf+OrvniFcY4ARmKbG+o7JVwFs
	 zABSLYjdxNsl2FyXGGqdVJOopdgXY717EHNnpEnrotPq+MVdeY9VjIu5G8h0BBgP/j
	 3czCHi/UdVPuy9rKS7ThzxayGxH4zThDWENk2CgfwGlgqx6GsMH9weLZ3PNounhXEg
	 0qejh6HWRzHSQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA12Se0xTZxjG+51bD5eSQ4FxBjq3ZrqMSPGSsS8
  4QJwxZzFB54bJXIYWOLadpTQ9ZYLLRhFQRkWRrRJawJIamAXlJggb5ZbKqOmGcatTNsYmFxFm
  GMIGyCXrGcG5/fd83/N7n/f54yVRcS8RQrIZOlarlqkkhDcW8wZZHG47a1ZucU5ugoPDtwi4M
  DsF4PmKvxA4U79CwBLjLQD77mUTsOZeLYA51joC9jctEbBz9AEGzSU5CCxudaPQVnmHgKYv7A
  jsN93EYLvdicHvvyoj4EyhA8C8ikcA5o8aEXh5fgmH+VN6FH5T2IXA8lkjCn++UAVgyfgyDmt
  np1H4U18/DgeKehG4OO8J6HAMYTs3MHN5ZzEm7/YywbSZBoVMruMRzjR9GcZY2x8iTKPtM4Lp
  LK8VMuNNpYDpmlgGjNGcxbgsDiEz0/gCs2juBfv9DuFKdVJaxhFc0ddSJ9TU+GVcclqFeuD2K
  QBepJi6BuiGEn9eY9Q++mrTiLAAeHt0C0Z/a7hG8A8xdRqhl1fawBplsZxD/0fxUeWAHu2O5j
  VBRdB3Py/7ZyCQCqRbF/swfgCl7AR95et8lDcCqETaUZ3t2Ud6kjbSVfrN/LeIiqFn7+QhvKa
  pDfRFoxPntRe1g84xzOM8Lqai6O6mvau4P+0sHcF4jXrwnGYzujq6iXZ/14gWgQDTM5jpGcwC
  EBuAHKv9iNWGvyZN0irlCl2qTKmSyk6EJ0vZdG2ahg0/znK6rVJ5skbKcpyUy0xNVqVI1ayuE
  XiOyfuPl4JagWslL6IHPE8ikiBRfLxJKfZLSkvJVMg4xWFtuorlesA6kpTQokuFZqXYX8vK2Y
  yjSpXnJNdsmvSVBIreyfXYIk4jS+WU8lXrJthONvzSZUfJ6YfGblSMqdPUbEiwaIxPonhUka5
  +GrR23rfB+pAAERAIBGJfDatNVer+60+AYBJIAkQ2gyfFV6nWPd034amCeKp4JZXyVXSyf60Q
  PbJ+dPuupLdiccsrzVOjgWcuxv6KO1Q19mMyQ9tAw+GUOJ/2qLq06u7BYoltrvSHgwXNPp+ec
  F0X7IgMfTPh/JP3MXvvLr+Rjy/L548PPX59qWLu5c7MCx3GxLfHgne78P6F36NiC19dAcW7rV
  GnDcxwke5k6Lt/Vp6kHvx4td5chfS4J4e8DrRUv1j2OEGwZfruqYEjbXs/mf6g/sMD+mr/rG0
  7D1nHBef2rHRLvV1npIly6/2y4Rp79gL3ZKOkIy6+LKg3JbYGfS7CGcRFXulDwqI1Ryfdlhs5
  bOR7lY6s2NAbXvv3/Xbq+ma/mJ5j7WETwbnlYwa9PjohTr4udVvXfdeegxKMU8i2hqFaTvY3+
  NSwnVkEAAA=
X-Env-Sender: tomasz.wolski@fujitsu.com
X-Msg-Ref: server-10.tower-859.messagelabs.com!1771802282!263770!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.121.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20350 invoked from network); 22 Feb 2026 23:18:02 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-859.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Feb 2026 23:18:02 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E1ED7101B94;
	Sun, 22 Feb 2026 23:18:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local E1ED7101B94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1771802281;
	bh=FdhqfBmWI1Vf3l9kwQ3rKzdU4/e6QfF0KHGTJW93ihI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr3sEs+GEio8hQDyw1dFhDgofUT9QivKc/WVOEThGr9l8BD5LlauRupLNEQAFA9cT
	 QwdQPUDdjow3G3ekqJur+xks7NE9iV2V9begC4IXxpm/UQoisNfzOxKB17BaWsFUbW
	 cllAryfmypQE2S0j14Axp938N9zqz/7UKFgGhnBJpsuPxORxuH+dotN1snuhHblEnx
	 S0RSf43hcjpUOikbsNhhWgS3gQuJ/dMo99qcgm6pLrwfMfJavR7Nepffa+TypLTJxS
	 f/y8R1YEbTa06i9lNRbGGBRRhn9W4kwxQ7B2yzCP5wxUdNnWNjX7u9WgSML4c2rWle
	 T6k9Yp50/rEHA==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id BF990100B55;
	Sun, 22 Feb 2026 23:18:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local BF990100B55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1771802281;
	bh=FdhqfBmWI1Vf3l9kwQ3rKzdU4/e6QfF0KHGTJW93ihI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr3sEs+GEio8hQDyw1dFhDgofUT9QivKc/WVOEThGr9l8BD5LlauRupLNEQAFA9cT
	 QwdQPUDdjow3G3ekqJur+xks7NE9iV2V9begC4IXxpm/UQoisNfzOxKB17BaWsFUbW
	 cllAryfmypQE2S0j14Axp938N9zqz/7UKFgGhnBJpsuPxORxuH+dotN1snuhHblEnx
	 S0RSf43hcjpUOikbsNhhWgS3gQuJ/dMo99qcgm6pLrwfMfJavR7Nepffa+TypLTJxS
	 f/y8R1YEbTa06i9lNRbGGBRRhn9W4kwxQ7B2yzCP5wxUdNnWNjX7u9WgSML4c2rWle
	 T6k9Yp50/rEHA==
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by ubuntudhcp (Postfix) with ESMTP id 394F12205E4;
	Sun, 22 Feb 2026 23:18:01 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: skoralah@amd.com
Cc: alison.schofield@intel.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	gregkh@linuxfoundation.org,
	huang.ying.caritas@gmail.com,
	ira.weiny@intel.com,
	jack@suse.cz,
	jeff.johnson@oss.qualcomm.com,
	jonathan.cameron@huawei.com,
	len.brown@intel.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lizhijian@fujitsu.com,
	ming.li@zohomail.com,
	nathan.fontenot@amd.com,
	nvdimm@lists.linux.dev,
	pavel@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	rrichter@amd.com,
	smita.koralahallichannabasappa@amd.com,
	terry.bowman@amd.com,
	tomasz.wolski@fujitsu.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Mon, 23 Feb 2026 00:17:59 +0100
Message-Id: <20260222231759.12403-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <0b0eb8bb-44a5-422d-8d5b-070fb039ed68@amd.com>
References: <0b0eb8bb-44a5-422d-8d5b-070fb039ed68@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=170520fj,fujitsu.com:s=dspueurope];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77875-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,amd.com,alien8.de,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.wolski@fujitsu.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fujitsu.com:mid,fujitsu.com:dkim,fujitsu.com:email];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 873CB170B8A
X-Rspamd-Action: no action

Hi Smita,
>Hi Tomasz,
>
>On 2/20/2026 1:45 AM, Tomasz Wolski wrote:
>> Tested on QEMU and physical setups.
>> 
>> I have one question about "Soft Reserve" parent entries in iomem.
>> On QEMU I see parent "Soft Reserved":
>> 
>> a90000000-b4fffffff : Soft Reserved
>>    a90000000-b4fffffff : CXL Window 0
>>      a90000000-b4fffffff : dax1.0
>>        a90000000-b4fffffff : System RAM (kmem)
>> 
>> While on my physical setup this is missing - not sure if this is okay?
>> 
>> BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft reserved
>> 
>> 2070000000-606fffffff : CXL Window 0
>>    2070000000-606fffffff : region0
>>      2070000000-606fffffff : dax0.0
>>        2070000000-606fffffff : System RAM (kmem)
>> 6070000000-a06fffffff : CXL Window 1
>>    6070000000-a06fffffff : region1
>>      6070000000-a06fffffff : dax1.0
>>        6070000000-a06fffffff : System RAM (kmem)
>
>Thanks for testing on both setups!
>
>On QEMU: there is no region, so HMEM took ownership of the Soft Reserved 
>range (REGISTER path). Patch 9 then reintroduced the Soft Reserved entry 
>back into the iomem tree to reflect HMEM ownership.
>
>On physical setup: CXL fully claimed both ranges, region0 and region1 
>assembled successfully (DROP path). Since CXL owns the memory, there's 
>no Soft Reserved parent to reintroduce.
>
>Soft Reserved appears in /proc/iomem only when CXL does not fully claim 
>the range and HMEM takes over. Your physical setup is showing it 
>correctly. Maybe CXL_REGION config is false or region assembly failed on 
>and has cleaned up on QEMU so there aren't any regions?

Thanks a lot for clarifying the behavior.
I checked QEMU again and it works as you described (sorry, I must've
mixed something up in my notes during previous test)

>Thanks,
>Smita

> 
> Tested-by: Tomasz Wolski <tomasz.wolski@fujitsu.com>

