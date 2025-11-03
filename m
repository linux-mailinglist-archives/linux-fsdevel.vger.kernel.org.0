Return-Path: <linux-fsdevel+bounces-66731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20536C2B474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48DE34EFFB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA860302769;
	Mon,  3 Nov 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vNgT36HX";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gKncODgr";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="M9Q6EN/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta41.messagelabs.com (mail1.bemta41.messagelabs.com [195.245.230.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFF3019A7;
	Mon,  3 Nov 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.245.230.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168743; cv=none; b=IuNAVFyCLavpVSEHzlT0ILKa9EqKlV6M867yu8CYZBZf+frCMggmQsrMAo05fc1TjShogmlzlr91JB3Cz8ZFXlFVKJrII/4tsCIPySXyDO6ij9nvLxfhczS4EHAvW048HlmE9uuD/blOC7EcE7o9Lsd/N3f8+9wEUgOSTmVNjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168743; c=relaxed/simple;
	bh=O/a7IoG10D6HLlLciKIAfeG+yrgUWRtc1OljxapqmNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJyI9sWf9mKXQ38kpTUb1OK4gVcxuFMwUTWqIiHAKcF4lSBDnarinAv0PDu40Nqop6wCW7ZG5/dyep0EOaUTkgwe6uESRVEy12XdnFD/HNvcE1yw5xDVIWquz6lHF33ElG/hJ60c0mEXyHsBUQJnl/5aKhb/72H/25AzAa4kxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vNgT36HX; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gKncODgr; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=M9Q6EN/h; arc=none smtp.client-ip=195.245.230.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1762168738; i=@fujitsu.com;
	bh=lWTfQaYpm6VfJ/9xy4tbemZZIjRJl7XPms8i1uMtQrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=vNgT36HXcahiUoOr+WTvCOk4n19fpHCC4ZY9+acbRHCd2P/ufjH2AUX/RSZovoYdQ
	 WEJ1CmvmDL9cnU4qMGVJZK2wManAuWhXeJuxZaAqkUsJxvmq6JhMitDrxfBGKdQPh2
	 PXqbOhXwonIC5OA1QAfLrH/dN7AD9ri3Mhf3MU+wF2BNFKvrfD99pFKOaY3eeVZb5Y
	 BNYAaJD74/ZhNCY8cMXYRSEmiGMNnc/cR9ckbNEX5i7ErhAUaxsyrtN4uJKfYCGLyC
	 soIJjcL/ckGK/wRyvTpx7+sg1xtsJN1Wv9x9TVamDn3Ewhy4EpzW30yeR1gBRySijG
	 gNobxAN49CtnQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfUwTdxjH+d1djxMoOcqLP5mgdogLpmW4aH4
  6cEyz7SRBlk2zxCWyUg56SWnrXWGwZBvlZVEZvqBdR0FAZKiIYQNGUCAwJPI6QAYKZWyOQdZB
  BDbY7AJsu9Kh7r8nz+f7/T7fPx4Klw2RgRSbbmR5nUorJz2I/ZFUnaL0LMW9OMyjiZ8HSfTX0
  jxA50v+xNDil3+TyGIeBKhrzESiG2PVAGVfqSHRQN0KiVqnfyFQkSUbQwWNIziqunyfRNaLLR
  gasPYQqLmlm0Df3S4m0WJ+B0C5JY8AOjltxtB1x4oEnZzPxFFnfhuGLi2ZcfT9Z5UAWeyrElS
  99BuOxrsGJMh27i6Glh3FZHQw8zj3DMHkDq2SzC3rhDuT0/FIwtRdC2OuNP+KMbVVp0im9VK1
  O2OvKwRM28wqYMxFHzN9ZR3uzGJtMLNcdBe86X1MwukS9OnvSTTtn8xihnsB6V3dZpAJsn1PA
  w9KRtcCWHBn0v002EARdCxsmmyWOAFBNxDQ1D8LnEBG52Kw7HrMumh44BTumkXRHy0hrqTPAZ
  zNthNOQNLhcPRC8ZrZjw6GD2ry1lJx+h8J7LTPrQFf+ii8YL/63+ntsHiqYS1VSu+Htp8eYs4
  Z0lvgzMU6iXPeQO+Cl5tKMFejCHhr1gZceh/YXTglHqbEAztgTYnMucZFa/bXRbgrJhSO9Nfi
  54Cf9RmH9anD+oyjDOBVAAksn8byit3KBJ5L1hhTVJxWqfpAoVayqbzewCreZwVjhDJZbVCyg
  qAUMlLU2kSljjXWAvG9PBa2nm8EpVM54e1gE4XJ/aUv6ShO5p2gT8zQqARNPJ+qZYV2sJmi5F
  BqzxeZD88ms+lJnFZ80nUMKS+5nzQmRcRSwaBKEbhkF+oBCuqrH9pacBmh0+vYwI3SVz4VRbR
  TpEnVPYlYf/UhEBToKwVubm4yLwPLp3DG//MZsJECcl9pjrOJF6czPrk0I5bAxBJ2zN1Zwqh6
  igIzsdibWcPxaV5YVFEG2JzWy+1enezY9sarbnHR3HTnnoCVQ+9GR8UGhc035O8YHnu9TH+zt
  Kdv4aNSU1zltdCkEX1BuQMG//hFaH+B5zd7TeNbiLiob/Ne8/WPPMFEtY8GJI1++HaIW2TFpm
  TcQxHRKqseenDQm9h39r7nPvMZajB/QO2J/56XVL63bcwBD/bXx20v1PJdWYPHj0Bbz1zijWO
  Wynq4c/r5O8v84ccxCYcPFNvmOip6bVd9vKbKFS1b+Ymm50bGyyez/ExvzZlePh5/IHd1+UTQ
  gqFS/Y5DH9hYUd8bvss/1LAtLnJP7CF1xgvmvp0hXP/Rew5+Nh08vG05IicEjSoiDOcF1b8tN
  b+NZQQAAA==
X-Env-Sender: tomasz.wolski@fujitsu.com
X-Msg-Ref: server-8.tower-858.messagelabs.com!1762168731!338533!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.119.0; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23889 invoked from network); 3 Nov 2025 11:18:53 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-8.tower-858.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Nov 2025 11:18:53 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 0AC01151D;
	Mon,  3 Nov 2025 11:18:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr04.n03.fujitsu.local 0AC01151D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1762168731;
	bh=lWTfQaYpm6VfJ/9xy4tbemZZIjRJl7XPms8i1uMtQrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKncODgrZzwHl4PEYLXht0aC7IzMZ1z9L+eCdas5sX0gWQw2ci7M/QHv8lm17ksmv
	 WKCtSHsbkGtqisHTIHRElitvmWdWsJvfEIHMqs9Vx9W57rBwPLBEp07kAT7Q0I2OVu
	 6oXl1c07LH5rYH0K7TpYng+lUqBaTiZvqQgCPRZaiJTm240GVrcQE/ntTB0olUAWMe
	 HqpZefvqeKGX1jBhoGcXB6ojjMz84YcKEV92lwuo2N/yqW5KImwvgnmR9yTUTxVpkM
	 89KtLCtV7mAF/ggysSRhmDYOdI/NqJoySRuTta1UlECnDyIqjAwZcnNdwR9v+RcIi0
	 OOL9UkqCFw8vA==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id D97581536;
	Mon,  3 Nov 2025 11:18:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr04.n03.fujitsu.local D97581536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1762168730;
	bh=lWTfQaYpm6VfJ/9xy4tbemZZIjRJl7XPms8i1uMtQrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9Q6EN/h+42pxoTlI4UOVvRWaRiLvHO9CiLKwlEffXZJn6m1tyYwyMpy52NChaBNU
	 kFTVz2K6ltS1k68OVkcyI1tjYdVSl8hMNWkTkyYtQNfIrq9+w1hAb836ckoxRG+UJP
	 czLDEsBjFA/quhMV+RSuyTBq/8/5O5XFUqJop041tH0CH/TrSbNxbZGunxjcAaUdlc
	 9y0xoh8MuFNaWYVoHPiuZAP7Lc83op5gVszxkpnuUQ49EPFJM2Xoo5/PuXfFkuvuR4
	 gyeGGoDEurAKlN0TAX/pWpxy9tIp4N8F33hE1biKMToMkXfkibAsFMxZ8gkSmU16kx
	 IPjyyosHmoEEQ==
Received: from localhost.BIOS.GDCv6 (unknown [10.172.196.36])
	by ubuntudhcp (Postfix) with ESMTP id 78A702202BC;
	Mon,  3 Nov 2025 11:18:50 +0000 (UTC)
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
	skoralah@amd.com,
	terry.bowman@amd.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL
Date: Mon,  3 Nov 2025 12:18:37 +0100
Message-ID: <20251103111840.22057-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aQAmhrS3Im21m_jw@aschofie-mobl2.lan>
References: <aQAmhrS3Im21m_jw@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi Alison and Smita,

I’ve been following your patch proposal and testing it on a few QEMU setups

> Will it work to search directly for the region above by using params
> IORESOURCE_MEM, IORES_DESC_NONE. This way we only get region conflicts,
> no empty windows to examine. I think that might replace cxl_region_exists()
> work below.

I see expected 'dropping CXL range' message (case when region covers full CXL window)

[   31.783945] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
[   31.784609] deferring range to CXL: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
[   31.790588] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
[   31.791102] dropping CXL range: [mem 0xa90000000-0xb8fffffff flags 0x80000200]

a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)

[   31.384899] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
[   31.385586] deferring range to CXL: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
[   31.391107] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
[   31.391676] dropping CXL range: [mem 0xa90000000-0xc8fffffff flags 0x80000200]

a90000000-c8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
  b90000000-c8fffffff : region1
    b90000000-c8fffffff : dax1.0
      b90000000-c8fffffff : System RAM (kmem)
	  
a90000000-b8fffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)
b90000000-c8fffffff : CXL Window 1
  b90000000-c8fffffff : region1
    b90000000-c8fffffff : dax1.0
      b90000000-c8fffffff : System RAM (kmem)

However, when testing version with cxl_region_exists() I didn't see expected 'registering CXL range' message
when the CXL region does not fully occupy CXL window - please see below.
I should mention that I’m still getting familiar with CXL internals, so maybe I might be missing some context :)

a90000000-bcfffffff : CXL Window 0
  a90000000-b8fffffff : region0
    a90000000-b8fffffff : dax0.0
      a90000000-b8fffffff : System RAM (kmem)

[   30.434385] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
[   30.435116] deferring range to CXL: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
[   30.436530] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
[   30.437070] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
[   30.437599] dropping CXL range: [mem 0xa90000000-0xbcfffffff flags 0x80000200]

Thanks,
Tomasz

