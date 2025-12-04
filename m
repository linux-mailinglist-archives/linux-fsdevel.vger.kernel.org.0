Return-Path: <linux-fsdevel+bounces-70676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F206CA4156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F6230B6AE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A6345734;
	Thu,  4 Dec 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="sJZ+t6EA";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="fkp5NKN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeBI204.fraunhofer.de (mail-edgebi204.fraunhofer.de [192.102.163.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22B339B2F;
	Thu,  4 Dec 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.163.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859397; cv=fail; b=gynB+8w7C62vYMuwex5V5NmGb3HGikWvBUwJnM8LTTJAw0kJjG3rjJ10KsvSdCmLRvHl8X3n4DqwyrRaQV4miBCPUg5NHzjhb5Ib8C2YAWVGmpreBVvnBTjeCs7LlMbK3dH32BXtDgbpHrdbIwOi/WyDpgTdpnwNR8oGRRl/Ec4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859397; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUEJ+bc/tKBApaI5OanMiLdWYqR07WFqb6Sdxj7wVKFQ6T2HARS2771Aymh/oipG+cVwwN9d9HSs+fVCwLidnoGIxcvHlnmjUXREqvI+xuwioFn7AmBNd7zoXlvRXMN2khd0q7xIFiAPoX7/lAIIJPZ2aSu7thQgsldIL5dO/us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=sJZ+t6EA; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=fkp5NKN3; arc=fail smtp.client-ip=192.102.163.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859395; x=1796395395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=sJZ+t6EA+JFpHb8P/vwacq9AStz/poPS5/6fnJvrq48m8vD3ioYpeWId
   /zBU9DG5njFd+qmy0C0Gh9NkPjhf/WJFJGziWxtqJ3mMGvy62F+pMPfGf
   dtL4WkoVCH2HdATZI2iGbETSjOrutNXmJt+51oOalFL2PQ35uyFtDFDLu
   MAAHO9EOKMgBBhpaN5eteHUyNyrSDXJx5W4aKHeVxL22qE1s/rlnZjsnR
   fDxFPG4rscZp0Ett9ZM1JADilh4ghIkHih3wZH+GkVcUHAlZHPW98jCyC
   qgIZWD8gIYfnewa205RvKZBZjYIMnuKWdYSffCjgInHf+nKka+h4ko1c8
   g==;
X-CSE-ConnectionGUID: 7sQfjXMDTBSTsAmU9hQyLw==
X-CSE-MsgGUID: Tpv+5bHjRAuQdNxH5ROtZA==
Authentication-Results: mail-edgeBI204.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EqBAAjnTFp/yUE4gpaHgEBCxIMggULgkBAAYIvszuBK?=
 =?us-ascii?q?4ElA1cPAQEBAQEBAQEBCAFRBAEBAwSFAAKMaCc2Bw4BAQEBAwEBAQEBAgUBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAjVWBjIBDQEBNwEPC0YxJQYOBYMCgiUEEgM2tEqBAYIMAQEG2ywYY4FkC?=
 =?us-ascii?q?QkBgUGDfIFygmUBhH1xhHg2gVVEgUqCdT6EWDiFd4M0mVlICngcA1ksAVUTD?=
 =?us-ascii?q?QoLBwWBIEMDNQwLKhUjSwUtHYEjIR0XE2A9F0CDSRgGZw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZgYcBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFLnsnAwsYDUgRLDcUG?=
 =?us-ascii?q?0RuB5QdT5x6Aa9rNAeCOIFngV4GDJ9nGjODcQGTbpMLmQapFQIEAgQFAhAIg?=
 =?us-ascii?q?W8LggQzGiSDNlIZD44hhAC8XncCOgIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 wGAHSd6rXGeGLHFGhSY5lsgpHXKe60=
X-Talos-CUID: =?us-ascii?q?9a23=3AQIV1S2pZI8yo15ZIvinBG97mUZ8+S3Pf/FL8H2W?=
 =?us-ascii?q?DNX1ATYDESWaB3Lwxxg=3D=3D?=
X-Talos-MUID: 9a23:7+6t1Qn4VH5rHMJVEt9RdnpeLNkrvq6OCnokjKwKndmkaBZXJwW02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="14770307"
Received: from mail-mtabi109-intra.mx.fraunhofer.de (HELO mail-mtaBI109.fraunhofer.de) ([10.226.4.37])
  by mail-edgeBI204.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:42:00 +0100
X-CSE-ConnectionGUID: K7oskp11SJyhvzLF1q1nTQ==
X-CSE-MsgGUID: b5N//JSTSIalZiuJp4l+tA==
IronPort-SDR: 69319db6_kVqGcDY2EXxZP0dRxxU77fSfDf3V3NEBXMJPPesS1idhvBX
 0gtwn9czEbzGJ87jAHHoqeQVtKKUNq+eUVdm6dw==
X-IPAS-Result: =?us-ascii?q?A0BABQBMVK1o/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCYnNwYOAQIBAQIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBD?=
 =?us-ascii?q?wtGMSUGDgUigmCCJQQSAzUCAgKtNgGBQAKMV4EBggwBAQYEBNshGGOBZAkJA?=
 =?us-ascii?q?YE/g3yBcIJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8ml1ICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLLhUjSwUtHYEneYQVhB8rT4IbcoF1QRk/g1MeBmsPBoEVGUkCA?=
 =?us-ascii?q?gIFAkM+gXEGHgYfEgIDAQICgRAQAm5AAwsYDUgRLDcUG0RuB5N3nXYBr2s0B?=
 =?us-ascii?q?4I4gWeBXgYMn2caM4NxAZNukwuZBqkWAgQCBAUCEAEBBoF+JoFZMxokgzZPA?=
 =?us-ascii?q?xkPjiGEALoxRDMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:/iEqKByjRdgDMWXXCzKPy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9yJy3f7QzRV5vqtAnmmdNM9XK6L/CnU6oEYiq8y
 YwzYwTotT4GORw/+23I358V7upR9Ryiv0FZ4KiPQLCQCr1gJZmNeYkCe217fMZsSyZPWpubP
 6AVAcBaIspqlIrjh3hSpwPvAiWtJL7x2htj2Ha1+IQz09xmTTmawDY+R/sEnSnOh8vabIMXX
 eyvk6TL0GvbP9VsmhzH7orNQEEqi66CQ+1eT9iK8W00JzzZi3mTiM/pIxGU0acNuDGR5vpmC
 /qIj1MgmT1I8mbw3cYJrbCZtN0wlWuYrSNhxpQVAIjrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPzYgu7T+GM63BfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
IronPort-Data: A9a23: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
 Osht4f+IX6Vsex4TCjB
IronPort-HdrOrdr: A9a23:HGE9sa55X3aONgUzvgPXwMDXdLJyesId70hD6qkRc3Fom6mj/K
 qTdZsgpHzJYUkqKRQdcLy7V5VoIkmsl6Kdg7NwAV7KZmCPhILCFuBfBOXZrQEJgUXFmtK13J
 0QF5RDNA==
X-Talos-CUID: 9a23:0FfYUGFbjv9IqglEqmJD1VMxBJkoI0HTyXv7LFCcCX1sYr6sHAo=
X-Talos-MUID: 9a23:dyOKLgliDnOmK70tNgVVdnpaFMRR+oK1KXwivoc/vcDVGgJzERe02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="41523894"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI109.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:41:58 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:41:58 +0100
Received: from FR4P281CU032.outbound.protection.outlook.com (40.93.78.49) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:41:58 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHt/Ro6vneoNNbJQKy1AUysRc+lfkCs7LQjcKOfZDYkP10H6HjmLiWI+igwvSLBXIWndPaI+4AyqCAjyv2nQTuQ36THIGEfc7PYx+vLUczeK+FObN23ppMwF4pJzmkgKYG9x6QrMk+p1UXhITlA6ZaZAg/SQYza+4B8APme6hbTmgBFAEEgdqmenThAy5TMr7GXDbnJ6cCmA4eo9CSDNkWUBJlHMDiO+Kxv/e77foi86XW7WosWVaFKYcmhBZL8jNOvGl6ZyiEUUl3V7u4Qd4TMlBIRa0Ky5QaShhOrdSgE/OS7Iw888KrVyFIyyLrFwC06TvR43k7oHho8qVEwhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=iX8zdGlSccsG0dZt4N0RUTN0Hs51dYWhLnOhDvEvnu5u8LdUJ2Y2H86/iRkOnX7hN0jsja/g5a9nZwDo+3s1XHcwLa35q2tEcGKh2eKkR0ta1TU1TxeST1cx7x1fVrTGN/sAkNtlKsKBwIp946uisLflk74DPGXySLPAFAosH0I4JpQUau3Gje0p5JsoUGRN8wH26l32bO6is9PPAyNNvLegcCPBtxtxbXsYHJeVGQ4+kRRtzi5h/TPNgi44kNpz2VVW4e/lg4LnAvegVSogNE4O/20rkUBUZubni5jRz2Ocv0q9pxbqnsoY7lRCmtETx1l565lHqef3Vjqst8EGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=fkp5NKN3HYmV/v3R8l2pVoRJhUtbf0pO8CrfB3wDZSkvHK4bp9oDiH5vxLC6a+MAahP/4P4tRv0AbE5rCvG0Lmddr7eku6p8NR+CRnjmZ9cB7fv7FVz3PLsXWtmDkI+dtJio+hc1baxn6pOlUoZTQ867siMOQ8Z7M7S40npnzHM=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR6P281MB5042.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:176::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 14:41:56 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:41:56 +0000
From: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
To: <devnull+debug.rivosinc.com@kernel.org>
CC: <Liam.Howlett@oracle.com>, <a.hindborg@kernel.org>,
	<akpm@linux-foundation.org>, <alex.gaynor@gmail.com>,
	<alexghiti@rivosinc.com>, <aliceryhl@google.com>, <alistair.francis@wdc.com>,
	<andybnac@gmail.com>, <aou@eecs.berkeley.edu>, <arnd@arndb.de>,
	<atishp@rivosinc.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
	<bp@alien8.de>, <brauner@kernel.org>, <broonie@kernel.org>,
	<charlie@rivosinc.com>, <cleger@rivosinc.com>, <conor+dt@kernel.org>,
	<conor@kernel.org>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<debug@rivosinc.com>, <devicetree@vger.kernel.org>, <ebiederm@xmission.com>,
	<evan@rivosinc.com>, <gary@garyguo.net>, <hpa@zytor.com>, <jannh@google.com>,
	<jim.shu@sifive.com>, <kees@kernel.org>, <kito.cheng@sifive.com>,
	<krzk+dt@kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<lorenzo.stoakes@oracle.com>, <lossin@kernel.org>, <mingo@redhat.com>,
	<ojeda@kernel.org>, <oleg@redhat.com>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <peterz@infradead.org>,
	<richard.henderson@linaro.org>, <rick.p.edgecombe@intel.com>,
	<robh@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>,
	<zong.li@sifive.com>, Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 07/28] riscv/mm: manufacture shadow stack pte
Date: Thu,  4 Dec 2025 15:41:48 +0100
Message-ID: <20251204144148.10012-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-7-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-7-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR6P281MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: af64d21e-c50f-499b-0038-08de33434625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|3613699012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2azDWEqsef48A3ProwLjaufZCVvPC8BBPivm9awc+KWGj+k7I1M6e8I74QM9?=
 =?us-ascii?Q?7R3mG+L7/Sq0bnUHiEoaaX5LgaYovnHzGsxgGruzcLnpLZ99ekVg/4w528ru?=
 =?us-ascii?Q?oJYiNvZ8MujHXfl0drMdc20q9ihjqvF0/zkkZK/zpb++IOx1ZSYNr7h4up60?=
 =?us-ascii?Q?kT71IGaRKStweBM9BIpGX46gZmgAWRBFXfueK/rDlLQWaDrglTpk9wtw688+?=
 =?us-ascii?Q?lsDeClj/XuiUWecTJTaqmYrYQYv503ruuGAtOlS47m9WmmLzeD6pR0MDhW06?=
 =?us-ascii?Q?CwlARdOjkLNmym8QLM5U+Ex94wnZmI9q+14pDMy9/HGzNl+4EIKms0vVYpi7?=
 =?us-ascii?Q?JIjK3CJkhlm7WA5e0oAu79PINg8ZUbM6xsLqyW+Kd7fl61i8ksBSrxrlpEk4?=
 =?us-ascii?Q?poQOwmJBfYqQ6hiGhX+2R6lG28NRkGMoPM7xhnMKnPQNtBTAdj/wcoKa74aN?=
 =?us-ascii?Q?vk3Vx1Cxq0bmQ/f9ea2SMLlIBonTsBymqCkwscu9eF/INT+1C9Xnu14zESFU?=
 =?us-ascii?Q?Ah+ayJ3+hWJMwTJX8cZEX/IJlIbtp0v/Tu7GhnA7E2O7wFPaPctIY6pIt76W?=
 =?us-ascii?Q?R5OWb9qZerA9Fpmgfqf+c9edLMxL7ItLxEdyS2vdD4acsaGnb00xU/Xcgmsu?=
 =?us-ascii?Q?E93pEp+Wwio9l3tEXE10HtwjvuI5dW8LK2LrSdRrc7sJQDyqCWPHQz1FyXuW?=
 =?us-ascii?Q?HOAZuN4YNj/wq5QGcckbYveOzaUOaACocpixoxF0tMJA0asn3yu0828OkLoz?=
 =?us-ascii?Q?b2/wr/0DmTkbapLJjor1FM8PZodalGf3FZJlAIkjbosC/7YJRqXMpOasB4jy?=
 =?us-ascii?Q?Y/nAvPiNXTrV2kmJCU7QDz7ciNTaH30UZ/us/uZiYS+DaPmC+nCQ0QWXy3sp?=
 =?us-ascii?Q?t4pwtRry1JFft7tBeBTO3NxWZY+RFPw0DnMmvOWSbYifCrrkAbEMGGJ3dqqR?=
 =?us-ascii?Q?9vDeuG6vBhOG2jDKarlFesLpqNBnQhiuIeOLSWTal5Y69fNgVJXBTCyBVcGa?=
 =?us-ascii?Q?26SC3p4nzNG1Lfx85R0iD5dyvxrO0NtCgSpt3jRFtLSyrluGbqe1ZLf5zS6u?=
 =?us-ascii?Q?LlO6ZjKVEqRvhGhIfPFmH30d9FY+iENYZG8J76ZJA9UyXS7aI436gTb6sN/Q?=
 =?us-ascii?Q?nxgA3yYWTTAfuuRLmXmQ2dzFz4NT3rPlbG987wjxUAPQLqj3JFBjD/fzr/zI?=
 =?us-ascii?Q?qVUtn8WQhGV9D9WvK05AiJABrTi7ejKYSUB+dByX36aOAn+XcZ1eE5a3v3sc?=
 =?us-ascii?Q?39KfJ4o28cDR+oPiDmriJCShGY5OaZV/Pr43ePlg1jRRQ8SDvn/V07wgyWw5?=
 =?us-ascii?Q?ySSy7Ahafst3jDNixWHYQRIH4JbVTi2B3VtcOJ40bMd8gnz69+FwfiPQwq5Y?=
 =?us-ascii?Q?mgX/0Qa7e7N7YpPi0WwxuYWt+QpnfMyCSeVzelVkmw34/yUVNUBqbu57lAkQ?=
 =?us-ascii?Q?614RWAmYAdhHuxhsJ3iZvrPmdiQ7QI+VDsW3OUvw7WXuQ1Z3LZn4DAuxViZ+?=
 =?us-ascii?Q?iRY0ujZjEuS/378wphp8NM1fstji5/cgpowK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ak0qdct2g5Uz/qEaOzi82kRTAuAbldns23TaG63v2zjKSIfzayI/ZgKc14md?=
 =?us-ascii?Q?arvYpZKFOIfzd5dJFnx1TB06X7pjV/KoYxjA4xjCZD7W2Q6wDOXDfz45XvzM?=
 =?us-ascii?Q?o1pIXsR762e4ft+KXeolL9IzkW/svhPrgjEhi5Uu81qwOtMPDSb9BLS2CVaY?=
 =?us-ascii?Q?iGFc4h3AAB3Doa1k3sehdj/s5hbLqrpzcrq+PwA6p5ZKxjFMiw+LVxpWKTs7?=
 =?us-ascii?Q?IPYh4Dn80Guzge3d8zTKpCHzaWs+GjuKAxctaO+4PIdD861LteS//32/3oRy?=
 =?us-ascii?Q?+zW5DriWGCG5urekoG1aupu08K6qF+zoYVzMK6EQjCJjsD4wu32f6+gcLP8z?=
 =?us-ascii?Q?TautXdBbrXlU1qTW9j/qm44gq/a4EeTiWjtbjFPkN13DZl84hJx/qLGKxZR6?=
 =?us-ascii?Q?Ke7P0MsOBfUUEJpaWf59OrYs6RR+KQGnJJ3/H/8+cCo+wA/yONmvcDiO2QqM?=
 =?us-ascii?Q?dfDQuOAO7eHmaGCQBHFuUcmfokoA5ye4kmdHOsxDve5AHJqgbq9GiezSqGJq?=
 =?us-ascii?Q?302mH7cJNtSKX7rkcPKmbMZPxXazJnqgSPd6eJwQueL/CxGFfA4dlM5dYpj3?=
 =?us-ascii?Q?wgzeeafXsxeflpPRDbZZWkmLsjKndaxdCYOmMOF6OAXR3TU75c/otGTsia/F?=
 =?us-ascii?Q?nbr3NFFo9O0N4TnyH1MvvtIWXD6U7Le/McaaP2Tt+N+8Q/XHYttbycsj1CmQ?=
 =?us-ascii?Q?pLPH7JojOBLmnu5vW4rGlppv1eEKXJFtdVCMFvOLvVYIVT2Ar1E2ZRif7H6L?=
 =?us-ascii?Q?PJhvMKF+4KMMvXkh1/i3pCQ5fqAPxLpOlPHDptdMG4CMHLXas+mAyFZ3ot1h?=
 =?us-ascii?Q?6sqncRmqCSEJj6/Ib/4Wiz3zeIfD6s2w4d2nGMQIvxT8d7RSlNAnresC/j+z?=
 =?us-ascii?Q?HSIJ1HkPyZSTZYsGC2C6xy5p5QDTIcbE8B8C9FpT6moV/bHGsrR5srih09N/?=
 =?us-ascii?Q?Xpa5LbnR/olssA9fil/1cC8OrOndNY+6vA0ITWRhC6V6lM6p7blEFzYzSkBE?=
 =?us-ascii?Q?KVAcL8trkZGA5Pb481A5rwBwqsx1lPDCYk9+UfP3rBDcFpKX06/Gmedc6HHZ?=
 =?us-ascii?Q?JQuRhrEWRJWh28aRhVV6ijGReNPg1kwNGM3zAUAmJHulCqHaFhz4ozw03PmP?=
 =?us-ascii?Q?BGMK7vQgoElloxUDRZ74zDJS9DbEuo4KZW91udpg9LZgQxBjFp06Q8LKXgSg?=
 =?us-ascii?Q?GapBUn96MLA9S99pPuxKCRaMTLaZI+ne7YvBr5+j4jhmoi7+A1nz1d2AvPen?=
 =?us-ascii?Q?ul0VSkJax9mfij/aKR+CNg3LoLBVMwzsgxNbhXB5THiHjdJztraZ6+iDhGsM?=
 =?us-ascii?Q?RFMVTl1T//43d+gdz2iff7SrEuOKvKD+V6UBZaL3CSTd04e1GuaRHJ1J8uYM?=
 =?us-ascii?Q?2wEQxN9v+F/7DyauSLRjWcwRqpFrBsnijxURYMFpiEY5RBtz/wIqSJgKVMBk?=
 =?us-ascii?Q?Y9gRIktgldIPXGlk6VbEvy1G9Qa/rlG+XE8SpecucLJbA0cdR/cRV6U0+p94?=
 =?us-ascii?Q?bjB9pmvhZtH31gZjita0JJFzRHO5MgQS4fCrlW2ODcIkyvm5YlRgjqDPAa/I?=
 =?us-ascii?Q?NzKO6DT3h1Sc+WfmYsgVpSgo9Zpevt1zs2Pbmrb/iaN5fCcIifk3XWYcxGO7?=
 =?us-ascii?Q?/2cRexnCRctw37G3ZqqSMOg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af64d21e-c50f-499b-0038-08de33434625
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:41:56.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofSDCKudjnZ31SW131+5vcfOVwYYUgHZtTjZgWRU9CnU3TY8noTlvfpP6xdt8fB28f9udhf44MjpmcQWOR0m+i9Hwyqu//hQn8HTtqQ/5XXS+zljC/NiJbI+jZwc+qjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB5042
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

