Return-Path: <linux-fsdevel+bounces-6351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA7816750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BDE1F22C33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967D79FD;
	Mon, 18 Dec 2023 07:23:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7F79C7;
	Mon, 18 Dec 2023 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ef-657fefc8c14b
From: Hyeongtak Ji <hyeongtak.ji@sk.com>
To: gourry.memverge@gmail.com
Cc: Hasan.Maruf@amd.com,
	Jonathan.Cameron@Huawei.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	emirakhur@micron.com,
	fvdl@google.com,
	gregory.price@memverge.com,
	hannes@cmpxchg.org,
	haowang3@fb.com,
	hasanalmaruf@fb.com,
	hezhongkun.hzk@bytedance.com,
	honggyu.kim@sk.com,
	hpa@zytor.com,
	hyeongtak.ji@sk.com,
	jgroves@micron.com,
	john@jagalactic.com,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luto@kernel.org,
	mhocko@kernel.org,
	mhocko@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rakie.kim@sk.com,
	ravis.opensrc@micron.com,
	seungjun.ha@samsung.com,
	sthanneeru@micron.com,
	tglx@linutronix.de,
	tj@kernel.org,
	vtavarespetr@micron.com,
	x86@kernel.org,
	ying.huang@intel.com,
	kernel_team@skhynix.com
Subject: RE: [PATCH v3 00/11] mempolicy2, mbind2, and weighted interleave
Date: Mon, 18 Dec 2023 16:07:48 +0900
Message-Id: <20231218070750.2123-1-hyeongtak.ji@sk.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH973ne8/zdByPq803Zc1NozaRtfnYLP3RH4+JWdYfwnLqoZu6
	cilloyOXOhOi6CruqtGS7jxl0oq78+PKUFKtzWSUyVIpivVDepam/157f97v9+efN0upSuUr
	WK3umKDXaRLUtAIrBhdb1zUPZwobjJW+UGKrpmE6/zkDP+x/aOhznENwraANQb99lq5/b2fg
	qcVCQ//UFxkYznzCcEfcAeXPPyIwFtlpeJV9hoZ3Xe8QFN5bDu7xCRqctj1QZe2iofZXDg3W
	7AoMjU0tGN42lNDQUz0jh9aGu3IYGL9FwYe8MGh3WGTgvuCQwefOBgb6c90yGK75jqBWLKBg
	4vYzBO6efAZ+23vl0GK+gsP8+V/GPMwb26dpfnIiH/F/mqtp/sm3YYq/nDXE8A/N7xneIqby
	Z58OyvnaykC+vPGrjK8zjWFerMqleXE0n+GHXr9m+Obrk3iXd7RiS5yQoE0T9OtDDyjis16c
	xsmdS9NraispAypbZEIeLOFCiKvjKp7nlxeHGIlpbi0pNJRTJsSyXtxK4nq0yoQULMXVM6TA
	+YaSPJ7cNlI/2MhIHsz5kzFnqiQruU3ElNPEzFUGkEt1JTKJPbitROw6hyRWcaHENvmEnvMv
	Iy1FfViqobg1xHZDJckU50ey7hdT0lvCtbGky1r8r9ObOCu78SXEmRfEzf/j5gVxC6KqkEqr
	S0vUaBNCguIzdNr0oNikRBHNjubWyam99Wi0bbcLcSxSL1ZyAZmCSq5JS8lIdCHCUmovZXjZ
	rKSM02ScEPRJMfrUBCHFhXxYrF6u3Dh+PE7FHdYcE44IQrKgn7/KWI8VBuRzvCJoe++MotU7
	esThLd8cORmY1BY5nff5ZlxM588Oa0zqwY0WvLqqf4nxgKqwdefjU37KgZng0i0DUbFHp1Rf
	PGP3Tal7MnI8zWsfiDpSdNthH0wOsbkNi5aER0WMdMc2HdKNJp+//NK/Z31vnehcd74A9uPw
	dt/sCNkjO12txinxmuBASp+i+QvQzCBrMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGe/cdNx19TbEPTaJFmUmZUfgUYQZFb0eCiDCKnPmVQzdlS2tR
	aB5KB5kHTF1TpobJUmdbkYmJTkuNTmquIDqpleaR1Ix5yhFR/y7u5+K+/zwsIcukvFml+qyg
	USti5LSElJj9gte1jSYKG75XEGC0VNIwm/OEgfGaORr6Gq8iyM97haC/ZoEKxjoZaDGZaOif
	+SaCpOQeEu5YD0DZk88I0gpraHh+JZmGd453CMa/DhJw4+5SyOibQtD600lDkyUMzCUOGpqL
	2imwTaXTUHLlFgn1j9pJ6Koz0vChcp6Cl3VVFAz+LCfgY2YodDaaRNB6rVEEdsc3Cr501zHQ
	n9EqgtHqMQQ2ax4BztuPFxY+5DDwq6aXgnZDLhnqj6fSMkmc1jlL42lnDsJzbZU0bh4aJXB2
	ygiDHxreM9hkjcepLcMUtlWsxWX1AyJ8Tz9JYqs5g8bWHzkMHnnxgsFtBdPkIZ9jkm2RQowy
	QdAEhoRLolKeXibjuhefr7ZVEEmo1E2PxCzPbeKfXR9hXExza/gbSWWEHrGsJ+fL2xtW6JGE
	Jbhahs9r6iBcjge3h68drmdcDsmt4ieb4l2xlAvm9emPmD+V/nzWPaPIxWJuO291XEUulnEh
	vGW6mf7jL+HbC/tIVw3B+fGWYpkrJrjlfMr9m0QWkhr+swz/LMN/lgkRZuSpVCeoFMqYzeu1
	0VE6tfL8+lOxKita+JLySzPZtWiia7cdcSySu0s5/0RBRikStDqVHfEsIfeU7ixdiKSRCt0F
	QRN7UhMfI2jtyIcl5Uule48K4TLujOKsEC0IcYLm71XEir2TUNW5/D065wnJSY+I46UNy/yK
	vCZkEe76kfQ4SVbq/lOVZHPP3YzDR0aHNr7VzXtJLSqH24nnA7at4tUXNwRt//jJY3pzsep0
	QENhdODAIh9jb5Vvx7ZU5wqTL3WurPygeMtkeOiDHcJ4dV9uV/DK4/vcM7vDdr0OwOaSN4Gl
	86fV/nJSG6UIWktotIrfF9TRyCEDAAA=
X-CFilter-Loop: Reflected

Hi Gregory,

Thank you for the v3 patch.

Gregory Price <gourry.memverge@gmail.com> write:

[snip]

> =====================================================================
> Performance tests - MLC
> From Ravi Jonnalagadda <ravis.opensrc@micron.com>
> 
> Workload:                               W2
> Data Signature:                         2:1 read:write
> DRAM only bandwidth (GBps):             298.8
> DRAM + CXL (default interleave) (GBps): 113.04
> DRAM + CXL (weighted interleave)(GBps): 412.5
> Gain over DRAM only:                    1.38x
> 
> Workload:                               W5
> Data Signature:                         1:1 read:write
> DRAM only bandwidth (GBps):             273.2
> DRAM + CXL (default interleave) (GBps): 117.23
> DRAM + CXL (weighted interleave)(GBps): 382.7
> Gain over DRAM only:                    1.4x

I've run XSBench based on the v3 patch and got numbers below. I used
your sample numactl extension from here:
Link: https://github.com/gmprice/numactl/tree/weighted_interleave_master

Performance tests – XSBench
NUMA node 0: 56 logical cores, 128 GB memory
NUMA node 2: 96 GB CXL memory

  1. dram only
  $ numactl -membind 0 ./XSBench -s XL –p 5000000
  Threads:     56
  Runtime:     36.235 seconds
  Lookups:     170,000,000
  Lookups/s:   4,691,618
 
  2. default interleave
  $ numactl –-interleave 0,2 ./XSBench –s XL –p 5000000
  Threads:     56
  Runtime:     55.243 seconds
  Lookups:     170,000,000
  Lookups/s:   3,077,293

  3. weighted interleave
  $ numactl --weighted --interleave 0,2 ./XSBench –s XL –p 5000000
  Threads:     56
  Runtime:     29.262 seconds
  Lookups:     170,000,000
  Lookups/s:   5,809,513

In terms of runtime, weighted-interleaving shows 1.19x improvement
compared to dram only, and 1.47x compared to default interleave.  I’ve
repeatedly run XSBench and have not observed any significant variations
across the runs.

Kind regards,
Hyeongtak

