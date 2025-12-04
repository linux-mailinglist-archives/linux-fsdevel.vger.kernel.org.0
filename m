Return-Path: <linux-fsdevel+bounces-70683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D63CA4204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C0730A2993
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBC27F72C;
	Thu,  4 Dec 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="Bd8xcsWu";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="n6fzT4dF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [153.96.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D526A0D5;
	Thu,  4 Dec 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860044; cv=fail; b=jhsKtVLpRLb3xOWSVWHpNFFyh+fw9tYDCRwS3QuY6kqVVTX8WswWVSpFXp9XQaviShIhI2Yv97weG9XnOxi12wehnAY+8HRyMJ1173IxtYwVIyv2J/YyPdMqHNvv5faMOX540tgyWxVznrksLpiHGjTgzeJGWdhd1zc1QagPYFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860044; c=relaxed/simple;
	bh=83FxPjY7TM5974i12o/zor3UwAGgZO3U/CfcuxnWW8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ex1hSlxNgqoSyMNYs7CsyqBTceZU5ZDbFMjMp4AygP5dZwdEcgvE7Nr6sUIaStp7iAfsQwG5LUpDr4TiuILIKguGI2kmKivNnNx5OIllNPNgxo0JdFLy7IqfM9Sz5Mbo+Q//5uTDKQsPCilq6l+j8rStsr/Qc0df8zMYXGimIGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=Bd8xcsWu; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=n6fzT4dF; arc=fail smtp.client-ip=153.96.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860041; x=1796396041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=83FxPjY7TM5974i12o/zor3UwAGgZO3U/CfcuxnWW8g=;
  b=Bd8xcsWumOjKK0eocrQYCFUsTorVy2QMFQSNeKJGuo5yN6aWtpwI/s7z
   L1OEskNi/CschqKw0gbaLU0Z4E/m9UB1la0s4rDpjUjImTWRXszf2vhnF
   Ce/ibYrV0myodyyIYCPHfk4/bBkOLgcIiEPixI5q/2zcZxIdT7PXSD9NR
   uusz2LuD9IY0gSp2Ihcb+OzMz6NndMuYcWJwppG37070zYYkOYpTGRz4l
   y7JRS4AdK5i5E4G9+psIVC4HE9kzfqcpDKoBDzG87UrLxCTDexWAt23xf
   dHGTa6JHfgpkJ4DCbcNHOaCAU+UOQ1MSTyoIvkz0Ca3k173fvjMSC9TZI
   A==;
X-CSE-ConnectionGUID: RWn/xcobQjKuO9kOBmwtCA==
X-CSE-MsgGUID: GJvpWWxpTk2oloA79k0yvg==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BAD8nzFp/3maZsBaHgEBCxIMggULgkBAAYIvszuCU?=
 =?us-ascii?q?ANXDwEBAQEBAQEBAQgBUQQBAQMEggyCdAKMaCc3Bg4BAQEBAwEBAQEBAgUBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAjVWBjIBDQEBNwEPC0YxJQYOBYMCgiUEEgM2tDeBAYIMAQEG2ywYY4FkC?=
 =?us-ascii?q?QkBgUGDfIFygmUBhH1XGoR4NoFVRIFKgkQxPoRYOIV3gzSZWUgKeBwDWSwBV?=
 =?us-ascii?q?RMNCgsHBYEgQwM1DAsqFSMPPAUtHYEjIR0XE2A9F0CDSRgGZw8GgREZSQICA?=
 =?us-ascii?q?gUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFLnsnAwsYDUgRL?=
 =?us-ascii?q?DcUG0RuB5QdT4IzmkcBr2s0B4I4gWeBXgYMn2caM4NxAZNukwuZBqkVAgQCB?=
 =?us-ascii?q?AUCEAiBfoIAMxokgzZSGQ+OIT6DQrxWdwI6AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3AWKd8F2qDafvuqOpQQskz7hLmUfoadDrNx3DaGk2?=
 =?us-ascii?q?bFEE4S5q/TECM04oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AuA+TIQ7o3sb0mersvOSwYdz+xoxHwbq2N38diak?=
 =?us-ascii?q?F4c6AMgUvajTFnSq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="35872149"
Received: from mail-mtamuc121.fraunhofer.de ([192.102.154.121])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:53:55 +0100
X-CSE-ConnectionGUID: 4+jr3cnST5uQuYV6pqytDw==
X-CSE-MsgGUID: dIIp/ipNRbSOTRoAW3GfxQ==
IronPort-SDR: 6931a083_T/6QvM/t+pHLqDY8P682YVFPXV2t4vo2bWhcbgeuMolRpFY
 3Hcs9Vxu2uYPUE7JJduSl+VJPGJrFzos5F2Xz9A==
X-IPAS-Result: =?us-ascii?q?A0BBBQDL7aZo/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKVoglADVw8BAwEBAQEBCAFRBAEBghOCdAKMJSc3Bg4BAgEBAgEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBN?=
 =?us-ascii?q?wEPC0YxJQYOBSKCYIIlBBIDNQICAqclAYFAAoxXgQGCDAEBBgQE2yEYY4FkC?=
 =?us-ascii?q?QkBgT+DfIFwgmQBhHxXGYR3NoFVRIFKgkQxPoUQhXeDPJpQSAp4HANZLAFVE?=
 =?us-ascii?q?w0KCwcFgSBDAzUMCy4VIw88BS0dgSd9hBmEJitPgiJ1gXdBGT+DUx4Gaw8Gg?=
 =?us-ascii?q?RUZHS4CAgIFAkM+gVwXBh4GHxICAwECAoEcGkADCxgNSBEsNxQbRG4Hk1WDL?=
 =?us-ascii?q?JpHAa9rNAeCOIFngV4GDJ9nGjODcQGTbpMLmQapFgIEAgQFAhABAQaBfiaBW?=
 =?us-ascii?q?TMaJIM2TwMZD44hPoNCtzpEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:tmklbhHpUnq4DOOb5vGsup1Gf3FNhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuUGhcIfJsBqlis8giXbGPJSsSvcmXi750
 rhCZxDar3w6cBU3+3zHjPNP3K0O83fD7xYqxdDacr3JONREIqPvesMBZHtdc+Z+TAFfOqrhU
 KokAdgaGshzjo3to3AVoD2FWCSqXb3XyRpt2U7c2PAg1P0ONw3s11c7BegMq0X4sOXYKoINY
 O6P4+7m0xb7b6991RPRxI3ObzNws9qLZuh1SNH460oISzH6l3/ArKD1Ej7W8ctS7UqBwfVqe
 rnolnAAjTooqDOQ++4ti6jUhbkF0Aji9SNag7g4IN25eGxwNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WiTqPRuEulWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WdYgCKEXigBXvKappLqFEpHXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6faUskdtZJhEo7y90ca7MBDhHPJOkPIs1NSZLXPbURWTXeRfBOLZqlWOdU3DH4ZmpN
 9dmodFebrN5DNB/KTHCWeDYrId6ejC2rupiI7lvhFQpExRGtRdxjY8LjzePlx9RQFAC5Z8PJ
 2A5vBfrz7lXXgMdMy0ClQMQuCG/rTw5eXbSC9DIyRixBiFjDuu5rK/Ox+E3i0GWzcK5bs562
 DKnyHw+63mmfCmzR330XPV8v1t6a/c4+oGIPbJptkeKz3qhArtTIN9W4eatDRwm+2r4EZCqq
 i9n/91Vf4T11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFston+tiA1bkwntlmOs5/L
 NA3mqfuZYSJwjHhj7B69/BUAwvvlaooEAljfUYgxVkIMcjgYdq3MMiFX5uYdw99WPBmcga+d
 BVfYjhDSNtABmnh3OwhBgf/DXjZAV8Iv68eDl9hiWk6UkooJlH9Tpl+CU+pAZyyHtvceg32w
 2DCNUfqJh+CvIQba8VPpZ5ffeK
X-Talos-CUID: 9a23:ai8a72M8bTFT++5DBGpl7hUfHPsZL2Dk0UbufVehGHpFV+jA
X-Talos-MUID: 9a23:ClNpPQl49yeChJvAFE7JdnpuFeZwpKW2LnoHqrI6gc6tCndfNSek2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,306,1747692000"; 
   d="scan'208";a="32648698"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC121.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:53:54 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:53:53 +0100
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.50) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:53:53 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkNYzpV9hNoLa3MRYH2OoiuaAuJsXnQAK8zkdB1y77E76JDXmxKqjD+Zp1UDREeAGdQAwTYv0G3VqwZn9iwu9BkQRYY4rQVp0ESoOpJFU9+VrYN4b+11XmJNU4FNHv0Q4EiG3v0R7cy5FMg4gvs61FrMBWfQx2YWhRLEPMXzbxpIRetzqrlqigLLBLXWIsVNX/0tjz8zGQ3d2mWWkIDnG4tbBt1JBSQ5A/hyTGOPoh4WqZgUZAIr0SulpUrvooRJNgZD/pEoX0iBzvi1PCw4MgxGa4CPg9nYIY9ZJ+zsCSDZtA1NKP4xEscyp5zE8EC1AFHeJDp+z/nasj1qTB6J4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83FxPjY7TM5974i12o/zor3UwAGgZO3U/CfcuxnWW8g=;
 b=XGsc1q5+rqfY7ToY4MPBGBysfaAkvmoZfYXzeYIOZWVFKKl22tzlInkrrxonhjv7nHlJBErYCrO4t/sfT9Ku4DKymIRgRTfaPY7u7gvx3pczghUOjmNF4dJLBZpEBSS76/vgcls20PlxMvM0fT7wFjgL2VuXDi9apXKTH0sAhvIbVLnk3LMnk9uPXXoK+nwRCkze4S9GglxGR/uqXHunf9k+Y9ZJVhbJMSLlNrufoN4fcM+BiyQ33Vd5O4A6wcVxZfmuDGBmbzuaEsf3eW1N4HuiWVSKGCh/+nPGk0SGRFpMa09Zb9P3TzwS15fmYJgUUL7kiOA6gbTWFfvqDmK5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83FxPjY7TM5974i12o/zor3UwAGgZO3U/CfcuxnWW8g=;
 b=n6fzT4dFR4hZoxsIytEHGsEvPA5WICfZsOFCIlxlCseNS5En16PkMM7YBm5roqGNdBc3srRjsYDtXEvMwYfRG/FvKPh4CdLDDmnuK9zCoS2mQsAJkO4ZWqB8mDxEe+OG76JrFwbG3/uvONS1bcWUAiiIukSxr0NhnK+VemhiXJc=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR5P281MB5029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:181::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 14:53:52 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:53:52 +0000
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
Subject: Re: [PATCH v23 15/28] riscv/traps: Introduce software check exception and uprobe handling
Date: Thu,  4 Dec 2025 15:53:44 +0100
Message-ID: <20251204145344.12844-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-15-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-15-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR5P281MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: bc326ad1-61c3-4e1c-2b96-08de3344f065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mk0Xw0yyOe8wLhrCvn5S4uIcG3hCzcV5xc9G9w6ZvwZty8EY1HMLBWFSgDtC?=
 =?us-ascii?Q?ZSThfie09tPIrcPI5JmvgqJNkDkSRaIgeIdDBh74Hzw5Xn8X7bZJCx1v2JcU?=
 =?us-ascii?Q?mb0Rzr00cxlcZ0Jz6lVIp8Vvs1mLgWBgx6QBxv1f00lR7lsXoro+ZHZGQDhR?=
 =?us-ascii?Q?h7kttzO364Orf+HfcNRWkTSBkqtQYidf+Ym6VyNeewbTHQeaMmC4x/MJIwlb?=
 =?us-ascii?Q?2QbSYGFoYp2L9N1vqmOUaj+FcIO6cyhsKHfCbvjqFU1Rcrgsd7u0mlpqHV7K?=
 =?us-ascii?Q?wiFS1BunbnoPDoaNruOBL2Iz6n68e9BeIQvWTnEqwi85UkvWPIA7IcIOrMaj?=
 =?us-ascii?Q?6+kxuwKdYYO0AgZM/W3Ap2sCqPgIDpjTmLPfMv1nmgPZSI0o6v+tZznaUqhD?=
 =?us-ascii?Q?Q0DGepBNG9bsbziorRv+z35FXe8EvNCUNEcYJbyqlAlGCDCGuONdF6n7W8+A?=
 =?us-ascii?Q?one7uBjIfwr1TVXgcibb75DjBz/r49G/HkpRcZE1TQa5pbHCV0cEfEyT4nBk?=
 =?us-ascii?Q?R6hZpRNBhk0/8p4ypGJtCjz9WJZKJiO3eHUXrz4Wi9i3BAKqoSm5KiBzlhan?=
 =?us-ascii?Q?2/kwNUtldagR9Ga2vtGVlaA7ziCiFHW/aMdXXUseVDjNvLdfOOA6bgF4LC1h?=
 =?us-ascii?Q?+bQ3DX+egkqfKUG701OR36hBy5mU3NkZudKADGhudAuEdMm12c4efyoOIghY?=
 =?us-ascii?Q?o3qZZyRgiAR2IvBTfizYwT3AlmDrnAy3WsStULDnQxjaWu+dmZqL922FeFv8?=
 =?us-ascii?Q?txLoVExB2/H2dJoMNN5L1ZYGaAxKf7Huf9sTHSb1zklTKWYRQhIW5GoRoul5?=
 =?us-ascii?Q?8eqBNgqCwZ7GDecU/wa+Fl3vEtNg1dDlKWPiCCCpWXuemqw3uInibWmzzHbi?=
 =?us-ascii?Q?FNOXsbpV0GRdp0CsZaOShrA/el7OFFF6nywQR/BmCjW15OsG9wi/gVe2P+hi?=
 =?us-ascii?Q?ygmKslME++8N//IhQw9v97wjeYPC51/nJR0Z7Dcp03pfZLjgrCN2UJD62zc1?=
 =?us-ascii?Q?GNvEIh3OjsOpYHrXu230csw7RB5I1baTl6fU+FNednbdFb1omFBPsSO8xjLp?=
 =?us-ascii?Q?gsyjdJ8JI8SajnhQ134bahFcumSPBJi8nQu2d4a2MneQZf/qU1yvxjdUP1eM?=
 =?us-ascii?Q?oCOkFUzuiWGUVbAvdd+Z7Ze38ZVNGfsDYomy73kq7bbBoWRN6vWMGYutvWvN?=
 =?us-ascii?Q?41xfdrIJPQ9U3oVpzexn+tKh/eKImaZyjN7ZZ+o9leHf7MNf+3PxsaoTl4MD?=
 =?us-ascii?Q?LN6V0dLeEQGZjTTwltomRfArBwgTNI9AULIF+mKt3wMjA4DYKp04akg4w1tT?=
 =?us-ascii?Q?44SOPyg6nJKKeC8Rk1DE3U3Hj3Lk9EFYvqkifEaAh9EioepBA01LzR0IwlM4?=
 =?us-ascii?Q?lLgCZEpNTMYT7QGVrcFzqUqt6Mv0WcdsMTeyYDcUmACCFe/0wHuWiBox15yA?=
 =?us-ascii?Q?SR4yvPEHaIqb+E7UIAdwQCe2NUVNhb5y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9VP14KecUUtxpPeb3ipMH2/hE27cIPUwehRTxUJWJI8MA3okybyvYHykOsS?=
 =?us-ascii?Q?2kUMKyrFIsV1J6TEcvU8Mc4epSkFoicm8wQyC8oCMXtKrRSX4USBjiy1WWTd?=
 =?us-ascii?Q?Pzx7/TsBH3hC2Kw5tZqVic5YWV6uTnhDjdeIyZuW0cGYVk29LUoluBu8jmP2?=
 =?us-ascii?Q?KOQdiRQlXtUmWVhagrFDt9YKqKFJ3Ii+0qU+Vm9nRZC0RibdTCujHbNuhiuN?=
 =?us-ascii?Q?CoIUVFMEmwG9rXqQ6Y4DHggbv0FkJD3v+9VOdts+AJusqnoXm+JPC83BhaHf?=
 =?us-ascii?Q?BKbTdm3lh18zkzzgh1TwrFlVjPgbt3UDPOtO87B+rt3QBanXnMkmW39rvYRY?=
 =?us-ascii?Q?EKg5uv+NDGQKfU5gyLpMq2uExFEIYWMLN2tjmx+UrevHT3iQ1C+TbJ6cSCSa?=
 =?us-ascii?Q?nRZndfu8bGPoA/Lm0amAHc5epJ/VJ6oUDfUA+giSCNeZXKHA7DqhBzHfxiVC?=
 =?us-ascii?Q?R35ZQ4mp3hEFZhY+FgDSoBSQKwFJ+MdRkWKvBvOlYHDbxblCgdPOIoEcdvZR?=
 =?us-ascii?Q?RLP+tSb+SXJvH4vtAVn02NS68WjpIU56Am3BzhcqzA/VhsEberkE3DM+fmiN?=
 =?us-ascii?Q?Jj8m4wH+8kTyQeJyTCqt7M9gCyBw2hjRbdvFs6jiOXCO3y0nTpDd0ItVKi48?=
 =?us-ascii?Q?dksGlURBn+2G6bzHyjFcDpVhYQBuaW2yFbuGRvg3JsjubJZWU0PrWsCMs/fW?=
 =?us-ascii?Q?pK3/iIq3Pl66/U2nz8FT0bKg8w0q0eH3JVVcx/02y6k8FBy/YHV4+oDp4FIq?=
 =?us-ascii?Q?xh1Zl9klHHIbQkRH2FgP2BA7jbB09HNUnYlvBPD7F2UD5zNIqTJB7lJXOJgU?=
 =?us-ascii?Q?LxHqNgdEzVt1pHoIFEfneeEIsVFC0udBx3aMoLN9quO4L26svWpR50ZVOQcn?=
 =?us-ascii?Q?tiriDFcdLFpew88g3qfvPW5MYEjSoYc4glFHd8VPTA5pzXmkLQjvy4uDD9a/?=
 =?us-ascii?Q?o7CrobMwdWpN9ROqgMV60ZOXzjf/sHq+3uXFqI02equ0538NuOZR3it4LEN2?=
 =?us-ascii?Q?IG8dsA4Kuq5U+FrKgPNfsG22cKvhJK2m1UMPcu2J6DZjeQrAN20jQnw5zn8u?=
 =?us-ascii?Q?Z8NlLMgNDazFRsylOHznsgjtCmJZUpeCm0xx2aBUzz1NBPwCAR7jTZGjZsht?=
 =?us-ascii?Q?mdpG2+iTfpGO3G7MnU0oADA4Lqtu0Xvn9JWaBk3qDbx3ec/aKSTxfKqwNB8K?=
 =?us-ascii?Q?NCCWaV6qm6JdNJuN6+QlpPIVuv/XkTcECy05o+av4yrLifNJ/1U1pHUXbIx/?=
 =?us-ascii?Q?0oAY/CNG2iRqQ3QvjvD7O2F+6V6AJD65Iv2Gk5KzSyDXBRStLPLj3W6Kno5g?=
 =?us-ascii?Q?Zv9IH8yhbdsJnLALYfAKrPO9TimWiqOsNp+HL7h7nbOouKvvdePyoFnf4/pF?=
 =?us-ascii?Q?7zsKnPahkWZLmZ8cYokhyExcTIijF4jyVUxpTxK8fSzYVxrgAqJiAyqO1yiP?=
 =?us-ascii?Q?AhaO/c25BZigXH8efj3R1OpITPO2mcWQSvfPNdKxCB9XgCDJeSW9DiEBE7Dc?=
 =?us-ascii?Q?5fV6EDpx2rN4aE+USiY0r13jFDIAIaWAFXD7/vvgTE7Ws1roIwP45I936E2v?=
 =?us-ascii?Q?peYts+PTi6BoPeiXnOCB9X9Ps4+H7ih/uINUOaoLe4RBB16CWYulFwV6GqKl?=
 =?us-ascii?Q?rjkRFIK6cb9k39BCCg5Mun4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc326ad1-61c3-4e1c-2b96-08de3344f065
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:53:51.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W1S3btTuexPn0chv3uVyO0osYofYgyVbQymroDT4Msg/91nkJGrK1rDSFLfUmZgAijmPvgnO7jV1zKInkrLSKKVNsbzvoMLMyb5FFVs88wVlP93P6eq04aOxvSjpkwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5029
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core
Only software check exception tested, not uprobes.

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

