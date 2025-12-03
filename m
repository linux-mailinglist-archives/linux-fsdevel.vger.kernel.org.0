Return-Path: <linux-fsdevel+bounces-70556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E5C9F26B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91893A6909
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156302FB973;
	Wed,  3 Dec 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xKINicsR";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ARhgGre0";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ARhgGre0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta41.messagelabs.com (mail1.bemta41.messagelabs.com [195.245.230.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC0126BF1;
	Wed,  3 Dec 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.245.230.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768929; cv=none; b=LJgeBzs/5elLLsPUeiDagB8iwVZDb9mzgFlUFXAprtHbR6VoGPfEqRHmNHEWKs9tH40K456gd6w/hA89YxZHS/IqWphr/8FAwLZtNSZQizI8NL8RIsisV6CbQ56ViZsYeHwwIZ24F4g7G/omsDneGO9SKTPX7gcHFyJ8Cq6UzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768929; c=relaxed/simple;
	bh=itNqXyXZyRD/uRko831szl/Y8eTbLSH/xkxJb2+FKZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgoeffdmTeBANUB3DJFvBjoymMjhY/3m9ODvUXWTwoKEbcW8koRiodWYn3/1tb2Vn0hPPYOqX5S/H4UQMZZpIjWLPTP+TbXdlGWk/ag2a3HtXcTm5Y+0B33aN4zpudRBlOms9DO2wRSs+2OTh7qfg2H7mX3WXayjqBHXtHzr/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xKINicsR; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ARhgGre0; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ARhgGre0; arc=none smtp.client-ip=195.245.230.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1764768924; i=@fujitsu.com;
	bh=ZAY1Gic2CWJjMxsl6KNRnnhhP7nUp7yTIvX8ENPeKww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	b=xKINicsRj3NLcQWoQmuiTC0IIR/D08n3ynPu0ZFxg/BYJBW5AnLsoulUD2LCnNM2Q
	 CL81B+8jwGab9KaJsWRvtUe65zxnIBVDJLBnkmk4K/fwRst40KZ8iV2U52IaLIYZX1
	 ZFkXfCZbtNLIcQL9q7tdOJG/TFoa+SxBEK7fPOC3obvf+vK9WIvF4M1d/NXLLYJDd8
	 UUgRgDjNEfiTO2RwAh331YRJMWT9qZfzTRKP1XSqXqlPeNt3Wcpf1TrtAqR4dkYDVS
	 i8ilIopJaa1bnVCSieuTsM4J4WvGaxVAtd3FvZp+Ktgmcs4vbXn+/97JQyGNnwAEvD
	 xXqbfdvcmQDUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA22Se0xTdxzF+7v39nIFLru2PO7YxNlkC2FQqK/
  8zJS5zIybbEajCVO3yApc+wDaprdMkDhA6BQ2DDLLo1UeM9nkpYUiUiaDQcMomlEhKEyc2xQG
  dYxV6sTw2FoIziX77+R3Puf7O38cAhVcx0MJNkPHalXSVBHui8VuJ6RR5dtjFDHmkk3w7n0HD
  p+6ZwA8U/kXAmfNSzgsMzgA7BvNxWH9aAOAeRcu43DAsoDDzvHfMGgqy0NgSdswCutqbuHQeL
  YDgQPGfgxe67BjcKj9HA5ni2wA6iunATw1bkBg7dwCH56ayUHh90VdCDzvNqBwrPQrABvcLhT
  e6Rvgwx+LexE4P+fJfmu7h+0MY57oT2OMfnARZ6zGuz5Mvm2az1guRjAXrk0hTHNdAc50nm/w
  YSYtFYDpci4CxmDKZm5U23yY2eYwZt7UC/YGHOIrVInqjI/48oWxUqAZzAUZLXMpOWBKWQh8C
  QHVAmir1YoXgjUERu2hR5vagdfAqFaM7sm7hK1QJxF66KEJWaWqxj9H/4cqB7S9ppbvpXAqmh
  754hzw6kAqjL59+TO+F0KpfJzub21cPiWkDtONphH+ytlX6YWW1uV3koql621FPl5NU+tp51n
  LMrOG2khbrn6zrAWUhK43X0VX+LW0veIB5tWoh8+7YkJXsq/Rwz80o8VAaHwOMz6HVQOkDkCO
  1X7MaqM2ixO1CplclyZVpIqlx6KSxGy6Vq1ho46ynE4iliVpxCzHibnMtKTUZLGK1TUDz5Z8/
  3wlvg247+dHd4MXCUQURC76xCgEAYnq5Ey5lJMnaNNTWa4bvEwQIppMfsPjrdWyMjbjiCLVs8
  hVmyb8RYHk7+Eem+Q00jROIVux+sE2oumnrg6UKOgs7EIJ15ThO1SAqdQqNjSEzNzmCVDegDx
  d9ezc6sYHwbpQIQl4PJ7AX8Nq0xS6//pOEEIAkZD81NvKX6HSPfvV6SmEeAqpS8TeQjrpv1Zo
  DiIih/YHF/l/sjmwYLzKWi7Zu18ZfCB7/N4TSXRt9jvHRy7Nn0kXTUh38CZKrQXHJvf49YSbb
  kw/AuqEaGVZWVzWCDiEJD7u3rfR/nX77YNv/XzCMbrkmmksitwqU77nejcgy97kSqE73OGNNs
  eXWS8kN3RuOul+u68FiobXRVRmaA9jRyt6N3wINFd2HWE6fSeP8/5YX+Y4yDMeeLMn6HXQ3Vs
  dudvPtjtB2aZ5+Gt/Zf5LF+0zJ4rfnwi6XhxbkxswFqLcsDP+F/1N5xZhcIng70f5eXq9OXKf
  02AY2RHIZTo/IP3ukOExVa1Pt8S5zacfFMct3erelfK4J36rRnJTMybCOLlUEoFqOek/XqRwL
  F4EAAA=
X-Env-Sender: tomasz.wolski@fujitsu.com
X-Msg-Ref: server-11.tower-858.messagelabs.com!1764768920!570346!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.120.0; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32111 invoked from network); 3 Dec 2025 13:35:20 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-11.tower-858.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Dec 2025 13:35:20 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 25159101FAB;
	Wed,  3 Dec 2025 13:35:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr01.n03.fujitsu.local 25159101FAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1764768920;
	bh=ZAY1Gic2CWJjMxsl6KNRnnhhP7nUp7yTIvX8ENPeKww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARhgGre0d5VN7pdKvqJWm/TGHKWQQCyWXbvKrwcrhe0VrzwDj3VXOTY/Qzq8zlPGm
	 GApwKXtoPbq6pcDowhnb9LC6a17soYpcylOSNeLhSVYJEmyfUdixxNNpr4sUUwjGBC
	 16yb7fwdIXC1p3y9liaMIseUYgLDWLsbT9ypl3g8WsRaxXhQ/rZEEJT+2HLbgDIzx2
	 djs4wRKHYjURAGL64H8QzM/iPSJAJ7pDciivlW1SYC7t9nd2AidWUIr4kxqFH3KnFN
	 7gHIyTzVpx9aTcHPQWuTDG2/Lq4eMp+k0DWdAwXAnbGDiAEhfbLHRPYEHEwYAf80YN
	 ei/XG6wzKZdQA==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id EBE2E100ED8;
	Wed,  3 Dec 2025 13:35:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr01.n03.fujitsu.local EBE2E100ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1764768920;
	bh=ZAY1Gic2CWJjMxsl6KNRnnhhP7nUp7yTIvX8ENPeKww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARhgGre0d5VN7pdKvqJWm/TGHKWQQCyWXbvKrwcrhe0VrzwDj3VXOTY/Qzq8zlPGm
	 GApwKXtoPbq6pcDowhnb9LC6a17soYpcylOSNeLhSVYJEmyfUdixxNNpr4sUUwjGBC
	 16yb7fwdIXC1p3y9liaMIseUYgLDWLsbT9ypl3g8WsRaxXhQ/rZEEJT+2HLbgDIzx2
	 djs4wRKHYjURAGL64H8QzM/iPSJAJ7pDciivlW1SYC7t9nd2AidWUIr4kxqFH3KnFN
	 7gHIyTzVpx9aTcHPQWuTDG2/Lq4eMp+k0DWdAwXAnbGDiAEhfbLHRPYEHEwYAf80YN
	 ei/XG6wzKZdQA==
Received: from localhost.BIOS.GDCv6 (unknown [10.172.196.36])
	by ubuntudhcp (Postfix) with ESMTP id 8B90D2203AF;
	Wed,  3 Dec 2025 13:35:19 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: alison.schofield@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
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
	terry.bowman@amd.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Wed,  3 Dec 2025 14:35:38 +0100
Message-ID: <20251203133552.15468-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aS3y0j96t1ygwJsR@aschofie-mobl2.lan>
References: <aS3y0j96t1ygwJsR@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

>> This series aims to address long-standing conflicts between HMEM and
>> CXL when handling Soft Reserved memory ranges.
>> 
>> Reworked from Dan's patch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>> 
>> Previous work:
>> https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
>> 
>> Link to v3:
>> https://lore.kernel.org/all/20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com
>> 
>> This series should be applied on top of:
>> "214291cbaace: acpi/hmat: Fix lockdep warning for hmem_register_resource()"
>> and is based on:
>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
>> 
>> I initially tried picking up the three probe ordering patches from v20/v21
>> of Type 2 support, but I hit a NULL pointer dereference in
>> devm_cxl_add_memdev() and cycle dependency with all patches so I left
>> them out for now. With my current series rebased on 6.18-rc2 plus
>> 214291cbaace, probe ordering behaves correctly on AMD systems and I have
>> verified the scenarios mentioned below. I can pull those three patches
>> back in for a future revision once the failures are sorted out.
>
>Hi Smita,
>
>This is a regression from the v3 version for my hotplug test case.
>I believe at least partially due to the ommitted probe order patches.
>I'm not clear why that 'dax18.0' still exists after region teardown.
>
>Upon booting:
>- Do not expect to see that Soft Reserved resource
>
>68e80000000-8d37fffffff : CXL Window 9
>  68e80000000-70e7fffffff : region9
>    68e80000000-70e7fffffff : Soft Reserved
>      68e80000000-70e7fffffff : dax18.0
>        68e80000000-70e7fffffff : System RAM (kmem)
>
>After region teardown:
>- Do not expect to see that Soft Reserved resource
>- Do not expect to see that DAX or kmem
>
>68e80000000-8d37fffffff : CXL Window 9
>  68e80000000-70e7fffffff : Soft Reserved
>    68e80000000-70e7fffffff : dax18.0
>      68e80000000-70e7fffffff : System RAM (kmem)
>
>Create the region anew:
>- Here we see a new region and dax devices created in the
>available space after the Soft Reserved. We don't want
>that. We want to be able to recreate in that original
>space of 68e80000000-70e7fffffff.
>
>68e80000000-8d37fffffff : CXL Window 9
>  68e80000000-70e7fffffff : Soft Reserved
>    68e80000000-70e7fffffff : dax18.0
>      68e80000000-70e7fffffff : System RAM (kmem)
>  70e80000000-78e7fffffff : region9
>    70e80000000-78e7fffffff : dax9.0
>      70e80000000-78e7fffffff : System RAM (kmem)
>
>
>-- Alison

Hello Smita, Alison

I did some testing and came across issues with probe order so I applied the 
three patches mentioned by Smita + fix for the NULL dereference.
I noticed issues in scenario 3.1 and 4 below but maybe they are related to
the test setup:

[1] QEMU: 1 CFMWS + Host-bridge + 1 CXL device
Soft reserve in not seen in the iomem:

a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
	  
kernel: [    0.000000][    T0] BIOS-e820: [mem 0x0000000a90000000-0x0000000b8fffffff] soft reserved

== region teardown
a90000000-b8fffffff : CXL Window 0
 // no dax devices
 
== region recreate
a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
	  
== booted with no PCI attached
a90000000-b8fffffff : Soft Reserved
  a90000000-b8fffffff : CXL Window 0
    a90000000-b8fffffff : dax1.0
      a90000000-b8fffffff : System RAM (kmem)
	  
== ..and hot plug via QEMU terminal => is the following iomem tree expected?
a90000000-b8fffffff : Soft Reserved
  a90000000-b8fffffff : CXL Window 0
    a90000000-b8fffffff : region0
      a90000000-b8fffffff : dax1.0
        a90000000-b8fffffff : System RAM (kmem)

kernel: [  129.820136][   T65] cxl_acpi ACPI0017:00: decoder0.0: created region0
..
kernel: [  129.827126][   T65] cxl_region region0: [mem 0xa90000000-0xb8fffffff flags 0x200] has System RAM: [mem 0xa90000000-0xb8fffffff flags 0x83000200]

[1.1] QEMU: 1 CFMWS + Host-bridge + 1 CXL device
      Region is smaller than SR - hmem claims the space

a90000000-bcfffffff : Soft Reserved
  a90000000-bcfffffff : CXL Window 0
    a90000000-bcfffffff : dax1.0
      a90000000-bcfffffff : System RAM (kmem)

[2] QEMU: 1 CFMWS + Host-bridge + 2 CXL devices

kernel: [    0.000000][    T0] BIOS-e820: [mem 0x0000000a90000000-0x0000000c8fffffff] soft reserved

a90000000-c8fffffff : CXL Window 0
  a90000000-b8fffffff : region1
    a90000000-b8fffffff : dax1.0
      a90000000-b8fffffff : System RAM (kmem)
  b90000000-c8fffffff : region0
    b90000000-c8fffffff : dax0.0
      b90000000-c8fffffff : System RAM (kmem)

== region1 teardown
a90000000-c8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)

== recreate region1 - created in correct address range

a90000000-c8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
  b90000000-c8fffffff : region1
    b90000000-c8fffffff : dax1.0
      b90000000-c8fffffff : System RAM (kmem)

[2.1] QEMU: 1 CFMWS + Host-bridge + 2 CXL devices
      Region is smaller than SR - hmem claims the whole space

kernel: [    0.000000][    T0] BIOS-e820: [mem 0x0000000a90000000-0x0000000ccfffffff] soft reserved

a90000000-ccfffffff : Soft Reserved
  a90000000-ccfffffff : CXL Window 0
    a90000000-ccfffffff : dax1.0
      a90000000-ccfffffff : System RAM (kmem)

[3] QEMU: 2 CFMWS + Host-bridge + 2 CXL devices

a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
b90000000-c8fffffff : CXL Window 1
  b90000000-c8fffffff : region1
    b90000000-c8fffffff : dax1.0
      b90000000-c8fffffff : System RAM (kmem)

== Tearing down region 1

a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
b90000000-c8fffffff : CXL Window 1

== Recreate region 1 
a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
b90000000-c8fffffff : CXL Window 1
  b90000000-c8fffffff : region1
    b90000000-c8fffffff : dax1.0
      b90000000-c8fffffff : System RAM (kmem)

[3.1] QEMU: 2 CFMWS + Host-bridge + 2 CXL devices
      Region does not span whole CXL Window - hmem should claim the whole space, but kmem failed with EBUSY

a90000000-ccfffffff : Soft Reserved
  a90000000-bcfffffff : CXL Window 0
  bd0000000-ccfffffff : CXL Window 1
  
kernel: [   24.598310][  T543] cxl_acpi ACPI0017:00: decoder0.0 added to root0
kernel: [   24.598645][  T543] cxl_acpi ACPI0017:00: decode range: node: 1 range [0xa90000000 - 0xbcfffffff]
kernel: [   24.599673][  T543] cxl_acpi ACPI0017:00: decoder0.1 added to root0
kernel: [   24.599939][  T543] cxl_acpi ACPI0017:00: decode range: node: 2 range [0xbd0000000 - 0xccfffffff]
kernel: [   24.630549][  T543] cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
kernel: [   24.692068][   T70] cxl_pci 0000:0e:00.0: mem0:decoder2.0 no CXL window for range 0xb90000000:0xc8fffffff
kernel: [   24.722976][   T69] cxl_region region0: config state: 0
kernel: [   24.724446][   T69] cxl_acpi ACPI0017:00: decoder0.0: created region0
kernel: [   24.725023][   T69] cxl_pci 0000:0d:00.0: mem1:decoder3.0: __construct_region region0 res: [mem 0xa90000000-0xb8fffffff flags 0x200] iw: 1 ig: 256
kernel: [   24.727230][   T69] cxl_mem mem1: decoder:decoder3.0 parent:0000:0d:00.0 port:endpoint3 range:0xa90000000-0xb8fffffff pos:0
kernel: [   24.728660][   T69] cxl region0: region sort successful
kernel: [   24.729627][   T69] cxl region0: mem1:endpoint3 decoder3.0 add: mem1:decoder3.0 @ 0 next: none nr_eps:1 nr_targets: 1
kernel: [   24.730566][   T69] cxl region0: pci0000:0c:port1 decoder1.0 add: mem1:decoder3.0 @ 0 next: mem1 nr_eps: 1 nr_targets: 1
kernel: [   24.731445][   T69] cxl region0: pci0000:0c:port1 iw: 1 ig: 256
kernel: [   24.731791][   T69] cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem1:decoder3.0 @ 0
kernel: [   24.807234][  T519] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xccfffffff flags 0x80000200]
kernel: [   24.903542][   T99] hmem_platform hmem_platform.0: registering CXL range: [mem 0xa90000000-0xccfffffff flags 0x80000200]
kernel: [   25.043776][  T530] kmem dax2.0: mapping0: 0xa90000000-0xccfffffff could not reserve region
kernel: [   25.044553][  T530] kmem dax2.0: probe with driver kmem failed with error -16

[4] Physical machine: 2 CFMWS + Host-bridge + 2 CXL devices

kernel: BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft reserved

2070000000-606fffffff : CXL Window 0
  2070000000-606fffffff : region0
    2070000000-606fffffff : dax0.0
      2070000000-606fffffff : System RAM (kmem)
6070000000-a06fffffff : CXL Window 1
  6070000000-a06fffffff : region1
    6070000000-a06fffffff : dax1.0
      6070000000-a06fffffff : System RAM (kmem)

kernel: BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft reserved

== region 1 teardown and unplug (the unplug was done via ubind/remove in /sys/bus/pci/devices)

2070000000-606fffffff : CXL Window 0
  2070000000-606fffffff : region0
    2070000000-606fffffff : dax0.0
      2070000000-606fffffff : System RAM (kmem)
6070000000-a06fffffff : CXL Window 1

== plug - after PCI rescan cannot create hmem 
6070000000-a06fffffff : CXL Window 1
  6070000000-a06fffffff : region1

kernel: cxl_region region1: config state: 0
kernel: cxl_acpi ACPI0017:00: decoder0.1: created region1
kernel: cxl_pci 0000:04:00.0: mem1:decoder10.0: __construct_region region1 res: [mem 0x6070000000-0xa06fffffff flags 0x200] iw: 1 ig: 4096
kernel: cxl_mem mem1: decoder:decoder10.0 parent:0000:04:00.0 port:endpoint10 range:0x6070000000-0xa06fffffff pos:0
kernel: cxl region1: region sort successful
kernel: cxl region1: mem1:endpoint10 decoder10.0 add: mem1:decoder10.0 @ 0 next: none nr_eps: 1 nr_targets: 1
kernel: cxl region1: pci0000:00:port2 decoder2.1 add: mem1:decoder10.0 @ 0 next: mem1 nr_eps: 1 nr_targets: 1
kernel: cxl region1: pci0000:00:port2 cxl_port_setup_targets expected iw: 1 ig: 4096 [mem 0x6070000000-0xa06fffffff flags 0x200]
kernel: cxl region1: pci0000:00:port2 cxl_port_setup_targets got iw: 1 ig: 256 state: disabled 0x6070000000:0xa06fffffff
kernel: cxl_port endpoint10: failed to attach decoder10.0 to region1: -6

Thanks,
Tomasz

>> 
>> Probe order patches of interest:
>> cxl/mem: refactor memdev allocation
>> cxl/mem: Arrange for always-synchronous memdev attach
>> cxl/port: Arrange for always synchronous endpoint attach
>> 
>> [1] Hotplug looks okay. After offlining the memory I can tear down the
>> regions and recreate it back if CXL owns entire SR range as Soft Reserved
>> is gone. dax_cxl creates dax devices and onlines memory.
>> 850000000-284fffffff : CXL Window 0
>>   850000000-284fffffff : region0
>>     850000000-284fffffff : dax0.0
>>       850000000-284fffffff : System RAM (kmem)
>> 
>> [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
>> HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
>> and dax devices are created from HMEM.
>> 850000000-284fffffff : CXL Window 0
>>   850000000-284fffffff : Soft Reserved
>>     850000000-284fffffff : dax0.0
>>       850000000-284fffffff : System RAM (kmem)
>> 
>> [3] Region assembly failures also behave okay and work same as [2].
>> 
>> Before:
>> 2850000000-484fffffff : Soft Reserved
>>   2850000000-484fffffff : CXL Window 1
>>     2850000000-484fffffff : dax4.0
>>       2850000000-484fffffff : System RAM (kmem)
>> 
>> After tearing down dax4.0 and creating it back:
>> 
>> Logs:
>> [  547.847764] unregister_dax_mapping:  mapping0: unregister_dax_mapping
>> [  547.855000] trim_dev_dax_range: dax dax4.0: delete range[0]: 0x2850000000:0x484fffffff
>> [  622.474580] alloc_dev_dax_range: dax dax4.1: alloc range[0]: 0x0000002850000000:0x000000484fffffff
>> [  752.766194] Fallback order for Node 0: 0 1
>> [  752.766199] Fallback order for Node 1: 1 0
>> [  752.766200] Built 2 zonelists, mobility grouping on.  Total pages: 8096220
>> [  752.783234] Policy zone: Normal
>> [  752.808604] Demotion targets for Node 0: preferred: 1, fallback: 1
>> [  752.815509] Demotion targets for Node 1: null
>> 
>> After:
>> 2850000000-484fffffff : Soft Reserved
>>   2850000000-484fffffff : CXL Window 1
>>     2850000000-484fffffff : dax4.1
>>       2850000000-484fffffff : System RAM (kmem)
>> 
>> [4] A small hack to tear down the fully assembled and probed region
>> (i.e region in committed state) for range 850000000-284fffffff.
>> This is to test the region teardown path for regions which don't
>> fully cover the Soft Reserved range.
>> 
>> 850000000-284fffffff : Soft Reserved
>>   850000000-284fffffff : CXL Window 0
>>     850000000-284fffffff : dax5.0
>>       850000000-284fffffff : System RAM (kmem)
>> 2850000000-484fffffff : CXL Window 1
>>   2850000000-484fffffff : region1
>>     2850000000-484fffffff : dax1.0
>>       2850000000-484fffffff : System RAM (kmem)
>> .4850000000-684fffffff : CXL Window 2
>>   4850000000-684fffffff : region2
>>     4850000000-684fffffff : dax2.0
>>       4850000000-684fffffff : System RAM (kmem)
>> 
>> daxctl list -R -u
>> [
>>   {
>>     "path":"\/platform\/ACPI0017:00\/root0\/decoder0.1\/region1\/dax_region1",
>>     "id":1,
>>     "size":"128.00 GiB (137.44 GB)",
>>     "align":2097152
>>   },
>>   {
>>     "path":"\/platform\/hmem.5",
>>     "id":5,
>>     "size":"128.00 GiB (137.44 GB)",
>>     "align":2097152
>>   },
>>   {
>>     "path":"\/platform\/ACPI0017:00\/root0\/decoder0.2\/region2\/dax_region2",
>>     "id":2,
>>     "size":"128.00 GiB (137.44 GB)",
>>     "align":2097152
>>   }
>> ]
>> 
>> I couldn't test multiple regions under same Soft Reserved range
>> with/without contiguous mapping due to limiting BIOS support. Hopefully
>> that works.
>> 
>> v4 updates:
>> - No changes patches 1-3.
>> - New patches 4-7.
>> - handle_deferred_cxl() has been enhanced to handle case where CXL
>> regions do not contiguously and fully cover Soft Reserved ranges.
>> - Support added to defer cxl_dax registration.
>> - Support added to teardown cxl regions.
>> 
>> v3 updates:
>>  - Fixed two "From".
>> 
>> v2 updates:
>>  - Removed conditional check on CONFIG_EFI_SOFT_RESERVE as dax_hmem
>>    depends on CONFIG_EFI_SOFT_RESERVE. (Zhijian)
>>  - Added TODO note. (Zhijian)
>>  - Included region_intersects_soft_reserve() inside CONFIG_EFI_SOFT_RESERVE
>>    conditional check. (Zhijian)
>>  - insert_resource_late() -> insert_resource_expand_to_fit() and
>>    __insert_resource_expand_to_fit() replacement. (Boris)
>>  - Fixed Co-developed and Signed-off by. (Dan)
>>  - Combined 2/6 and 3/6 into a single patch. (Zhijian).
>>  - Skip local variable in remove_soft_reserved. (Jonathan)
>>  - Drop kfree with __free(). (Jonathan)
>>  - return 0 -> return dev_add_action_or_reset(host...) (Jonathan)
>>  - Dropped 6/6.
>>  - Reviewed-by tags (Dave, Jonathan)
>> 
>> Dan Williams (4):
>>   dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is
>>     ready
>>   dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
>>     ranges
>>   dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
>>   dax/hmem: Defer handling of Soft Reserved ranges that overlap CXL
>>     windows
>> 
>> Smita Koralahalli (5):
>>   cxl/region, dax/hmem: Arbitrate Soft Reserved ownership with
>>     cxl_regions_fully_map()
>>   cxl/region: Add register_dax flag to control probe-time devdax setup
>>   cxl/region, dax/hmem: Register devdax only when CXL owns Soft Reserved
>>     span
>>   cxl/region, dax/hmem: Tear down CXL regions when HMEM reclaims Soft
>>     Reserved
>>   dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
>> 
>>  arch/x86/kernel/e820.c    |   2 +-
>>  drivers/cxl/acpi.c        |   2 +-
>>  drivers/cxl/core/region.c | 181 ++++++++++++++++++++++++++++++++++++--
>>  drivers/cxl/cxl.h         |  17 ++++
>>  drivers/dax/Kconfig       |   2 +
>>  drivers/dax/hmem/device.c |   4 +-
>>  drivers/dax/hmem/hmem.c   | 137 ++++++++++++++++++++++++++---
>>  include/linux/ioport.h    |  13 ++-
>>  kernel/resource.c         |  92 ++++++++++++++++---
>>  9 files changed, 415 insertions(+), 35 deletions(-)
>> 
>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
>> -- 
>> 2.17.1
>> 

