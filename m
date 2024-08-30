Return-Path: <linux-fsdevel+bounces-28076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319A9666BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17F8280C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4A1B3B13;
	Fri, 30 Aug 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGfV+NN6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SYTZRRed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C41F942;
	Fri, 30 Aug 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034943; cv=fail; b=svD6Jbtu62z1ub1ScmHYVFckxhU4m9uFTr8iO0fXjR1EoVtvKX7EMTp5NNKpoeBS/c1u5Ogk7rKkgyfqP5hXtTt2XWOB32nJYirFrm3PNfF9DXWfDB6az/s0aGn1klQce0gID4E2W+OQUmiySbHIGkM854J1dtaIrw3O2rBJCaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034943; c=relaxed/simple;
	bh=Ckh/OvHV/WBY5vTKLB7Ci7lRV3ZNDVYvkV0Z+oFtrkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=pPS0CgnsNVJvgNM45D8XNFVyEHfCwpaguAv3f3ODnjK2eAz52PNTYILvIHZCHZEig1C3jFAoYqqyrxfhuUBns+r+ovJf4u+7I3SBB4OhOv7PN1/B9y2P6nFq8OfJ2lfKFmnzToHmWNRKVqI5LA+QJZ4DAQFmRi4tM02IhLXr6jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jGfV+NN6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SYTZRRed; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE3GwM009541;
	Fri, 30 Aug 2024 16:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=Ckh/OvHV/WBY5v
	TKLB7Ci7lRV3ZNDVYvkV0Z+oFtrkY=; b=jGfV+NN6cBAsjeILCqVWKCu+GP8VGT
	AHMY2yM5v4fOjBju7bofnXgMqRArBDfkTU99I+GWhPJnYckuwqipAs+TIDFaRvQB
	YypontzeDAAkCYIs/N8y+4bnPHhOo8AD4PjqobAJRtEvuzBJKObY0TM+z8eSDuKE
	tFpaNePWmaUIlsGdCS7vwN3wIqnyqRwlRq1ULcJC0Ek4KtwDnkSICV8GIbR7fcvP
	GXS2bG5w2Pa7I013D8UTzd4SO9hgmYz3PVByj6F3U6xGhK5cp9vMMA0ykeIm3G3i
	otFbpe1Gbytb3qtdvBggRxZGX+4E7A/8Qg8SUM+rtjm5Ou2fhPIxGZ5Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj0a7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 16:22:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFRc5D017427;
	Fri, 30 Aug 2024 16:22:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wndn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 16:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFUlNM65EGmaLwyd6nf4H0/ooIDgvxKuVdghhB+5q/IZAn+xHy6LajdTdCHDghjlEWitzk0NSzQtq/TEKlGK10x6hl/P9VU+TffI6aoOd3Zk+2iWE9K762vs017VZaE4QSiYlP6zK3iVQZAj3u7do8xnSYB5S/ZfHU+h2J+fpLVh76OrMfMvODtC3bMec2hwvFuuYvPn6jcMWtpOHKc4CZGkDCJjvQWwKyrE/fkMPWO0GB+enNiFif9lFlScXSAekrjazMFpppzD0wn4zk3UHCPjR+AFJpMm1EgePf6T06FAgwqHrKhjx/QabGMEIBEmZzYpOTjIrwQk7mAvtvHnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckh/OvHV/WBY5vTKLB7Ci7lRV3ZNDVYvkV0Z+oFtrkY=;
 b=ZYMaE90uKBzekBd+l0/tgLfygN3y1whfNGgnfgaF7dSp5Nfrjdu/KKvShWtPjxh/w+5BzB2NaOobCnPcr0UpmDS73fpvuDE9ZlQMb7fKV7QGySZU8hJ6T3YExrxN29N+Zc9hl7neZssCtSHmM4jwx9lyixuib214c+tNRIyPzF3MtnNU72IwPOweEJS5/2027c1vEHwgU4GNshtgFDm3Vr/SyqVTID+OhJSHpmY67vAa3EI9TdxF9t7MWkl6WyJzLThFLJunAZhigKIvHGOGHlt4AzrYEW/2HBur5XtYz0L9ykY4cNTBtrqVOQFk5hseLY9gPh0TXcjl/m6zUGv6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckh/OvHV/WBY5vTKLB7Ci7lRV3ZNDVYvkV0Z+oFtrkY=;
 b=SYTZRRedUN7LkEONAIjz0ZVRRFFjjQrvgAbr16mq47IoK1C269Mezt16sXxV2KqQpLv7uj0L1WogJW3oWynO0UY80pAVRKdc5Din390c+ACB7IX/DRQPYvjhieF+Qf8yoFvbshf+lUBDMv93tgir02pgkLb2HgiDaYE/fVed3ZI=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB5752.namprd10.prod.outlook.com (2603:10b6:303:18d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 16:22:11 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7918.018; Fri, 30 Aug 2024
 16:22:11 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-debuggers@vger.kernel.org, Jan Kara
 <jack@suse.cz>
Subject: Re: [PATCH] dcache: don't discard dentry_hashtable or d_hash_shift
In-Reply-To: <CAHk-=wjKbgRY+Jvu2GNaDXaAhyydOOW-R=0qCzM3mTLrZZg+iQ@mail.gmail.com>
References: <20240829182049.287086-1-stephen.s.brennan@oracle.com>
 <CAHk-=wjKbgRY+Jvu2GNaDXaAhyydOOW-R=0qCzM3mTLrZZg+iQ@mail.gmail.com>
Date: Fri, 30 Aug 2024 09:22:10 -0700
Message-ID: <87h6b2q8ul.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b30be0-a6d6-416b-9c87-08dcc90fe6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILSxG7aR9cHQE/DVTGhOV6Q1Xi/NkZKkt3Sy0SleRs4k2cwkD2CrenlJudEI?=
 =?us-ascii?Q?Kvk8lA9zHIvmS8tOjPteNCHikdaKpuHwVhS5iYsoS9hzgdjlBfVX9QBUyPpO?=
 =?us-ascii?Q?14j1BamJ64vLp9XM8wiGrjGEa4FmFggJoeYxDGy+hVmCsDJGjFO02OH/H7ez?=
 =?us-ascii?Q?uQhfpdRkUKdvod6zQ4lM0bI+8/vcCo3BqGeCgTc9A2+uMmreq8Bo/MF6+ykU?=
 =?us-ascii?Q?5EA2rACa3DP3maIkpXbK1bDPp4+zP+RFhHpEBRq38cj7XmPldjXEF+7NF6wy?=
 =?us-ascii?Q?tj7huBSXBngh0+2+4YXCrEnJnMty3VxGUcvN6pgzqDyQv/kZ13I/aW34EiDV?=
 =?us-ascii?Q?NVBMU+U4YZXCuw0uxDA7AMtUf+n+QCMEU15QUKdHeBJ1gw0kueV6kym367n8?=
 =?us-ascii?Q?3r6AcwvcgYYUeffSRIfZsAADkzmiSX5qdJjkFSNTUG0PyDqOAsY+sGP6DH/1?=
 =?us-ascii?Q?ezxx8oFQCQAdA+rR33NJdFKL5DyctX4VtBMFlY1xXq1GfprDrENq/o80gcP0?=
 =?us-ascii?Q?j3DXObEAdP5yUoQzZ4emAzNzsy9Qon4EOOW4ioZY1Mj7CQ+Sn/v0l9iC+zK/?=
 =?us-ascii?Q?FghiSl8rs2x6zEnYQ572OWDFK9xjRQpuLu+5UkajAVL4gB5sieuFRx+TZabc?=
 =?us-ascii?Q?8gBLjl0onerCjugGM8pOEZ4HNl7YXQqKPvzm3kP38UkTzUpYqNneI/Iq4iec?=
 =?us-ascii?Q?LJcCdES9X512uMVVGx/6jo/Onh0N2uTmhY6YlRLQhQ7oIkEsRdxhhbH4bN2E?=
 =?us-ascii?Q?FORiCIFMvGD5fOuttjuwfEqo+xlQU1UDXEVqHiC8/OuMSlmikBmiDMgU1zgB?=
 =?us-ascii?Q?B7+GH3x7Xi0L9uPl7BE2hLcRn+WYheJeWmk9IUrW56AnZsE8o/WkcUBhCwba?=
 =?us-ascii?Q?I3E0WQLcvlLqICU5bOgJv4Irp0uG2REkmjRkSChINjs1semCU1W37giTSRqX?=
 =?us-ascii?Q?KI7eCl6a6a8M3qxF3WNG7wmSled14RN5lC+ravTDCFij+x6KJVN8gPLtADv0?=
 =?us-ascii?Q?KS2Pgu+Ns1ELlojRBR9WApRhPOh3S7A1AI+pdljOVptE2HAhEjNdQ3WgLczr?=
 =?us-ascii?Q?5r4CgAqBk2dJvye3VF9eZqnmGEWf1bpfvaYv0Bhj41cdgww//0ct4qWgrni5?=
 =?us-ascii?Q?SvGQxTtOkBY+I3HE3zmw9W24eozgjDeHCRKSIBLciNNcMSp0t1CO/oYZnZhr?=
 =?us-ascii?Q?fIGWlAjaVCRmHF4ZXdS66R3I/fLHfeIFXGVjk5AVsUYG7NXwJWdX9e733e/8?=
 =?us-ascii?Q?WhHZmUIhXVT+Q+z7Pqq+Y23c2RrL6+5eU6UgaeXCDKOqq7nn78YYqLmpccJ1?=
 =?us-ascii?Q?xEZLAWcBaNwBOykYmIwp4gf+gxjZl8y7MyHFTq6Cc0KLag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5GweRQWNIWI4RDbiLDmBW1Z0GL5nC2Ity3rMdOTtQKfGA5ekOrMNkwgn1dJ?=
 =?us-ascii?Q?yYMdNyx5SrsrGEZg6co/O11D3jwkfVaLRdK3XoWka6ZVHJ1wFrXe3pU+SSXQ?=
 =?us-ascii?Q?nd6zZuwHB4nZaKiP1hMNFjn06YpUAeHd35p7icQFOJvdFwcL66MZmnmUYSZ7?=
 =?us-ascii?Q?hAudRYWX4141UF6Hzpds7H20E9QnaTd8kBbAZoriBh8FT4meeZZ148Q7tlzP?=
 =?us-ascii?Q?P7+Zbt2sa76SQJjDpWM3MaTVhljymifE3GtxbOPh4+idw7xp4RcsUpMs+4uM?=
 =?us-ascii?Q?Oh7eGMS8gG+zPx/QIJYJDOfalYiw81DHnBhDl97hOtMHoAOcF8w5qD32/O6M?=
 =?us-ascii?Q?Wo1CKUuVQ02dcr9waqyMsxj/ZCtkk5zgFMlLObxJJDEoyC0kdgTREAiv5vw/?=
 =?us-ascii?Q?Qla9V/erhWtF9A4DDke9oOplFg22Lr3VcuwwqbvITBklp48I5xF9YZcscoDc?=
 =?us-ascii?Q?VNzhBmGUZE4nIIj+fIUwQFSBDNGpIELjMwmxj56eNHhXIYJSEhldfOrPYFg4?=
 =?us-ascii?Q?8xLMXUwLcGvXMi86EakHl+yUacqlaMeNs5MSU/zGL3aodoyC82gFudT43MhL?=
 =?us-ascii?Q?nfYrA84UNgibHABEC3mz3JxoaOmWB5y1RU+p5MH/FBRIwv3CPrqKpN2j+b0i?=
 =?us-ascii?Q?+6zYPWwjQ7PCygCQ58ucdKd8oi5bZ+sBcI6227zScR9JVbM2Tz06Jvj2dVs2?=
 =?us-ascii?Q?63dpEyusWsJvnzCurm7IFkIYIS0xmJuw7nYfeJNaKBIkfS7m7A9l5hQCDZLe?=
 =?us-ascii?Q?g7PLAhj9vH1RqXOjOLppD+kEcgksFyt/UPpy7aY07quGUaqPZA96qWHxK6j3?=
 =?us-ascii?Q?2/JkNhsR7pM7UTQBF9QskHjJpMwRlLViFU0c2zO0x+JKCS8oe1HMYcOMx+om?=
 =?us-ascii?Q?2Mw0GP3IfU2VDdjmPG6pdJZ+j4o+Hkf5Gz9Sk3kJmpk+Q3YqJv0pzjeGNeIr?=
 =?us-ascii?Q?QmH3//FQZh2v6sf2y8hXd8j/cHdk+HwnaL1L2QQx0epqPS0kDsaiXPxELEoR?=
 =?us-ascii?Q?tSfGbqWg2fyzBpxAj5xndXKWJzInbbb+1qcaGJAPly/dHE4faJizbxhONrQS?=
 =?us-ascii?Q?PZnxMcWpoqyh755rs5kwFYvZ558U6MRV5pevsIuxvNkVTLCTUn6iqNDHEi7T?=
 =?us-ascii?Q?5DFcjUluyuvsls9X/FlJIJ0md7D+1g11Iu0DVbwPU4FDTG/0uCT17WLL2JOL?=
 =?us-ascii?Q?eJxWLR7twn0sOlNxkyBP8nDGDxOze7Ued7yBDAm6YeVY39Lsl6Flh4VxE5Gh?=
 =?us-ascii?Q?jfnuUw0ijwxYumuAsmpFlfgLd0urrJzsGY46R5gSqxE5W6Uz7RWt339eRrdL?=
 =?us-ascii?Q?B4m0PN+zwvUZp/N5D5jip37qnCoK+wdrLl9HNYs1zDmR/oKVAuVCUziaOx2T?=
 =?us-ascii?Q?HGUo/pqxih64ESE/a9hF6m9qp2UontRquR2OXP3a+JYVrdNddqD3/IuzVKpQ?=
 =?us-ascii?Q?3Hkg/+Ctk0+NMos/SnECMRz+/oNsJljnCzXIR/8njsbaVX8+XOHFhWjIVoAj?=
 =?us-ascii?Q?BXSHBdGYwdzCQ8/vzj/xWdE31oFSOnCMYGYptbq4Z2J+BNxGbSXDoAW/Ek+X?=
 =?us-ascii?Q?WWZLB/cDiglWcuFnPD/CeK+0HaVu6vCFCFcUe1ZBAaymFZY2RuNR/JAVk2IC?=
 =?us-ascii?Q?DH1IoJaPWRhr44Tbe/46jAvfMKvGb8Bzo+eaIxMDxev9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vbp/pM3r1NPLyUlaKSaReUu4N1D0hJBuZwLpK2hTGOSG6vGVaq9FUWKAWFHxNOW/0Z0AdWpkNMhxWPoTN7ISilh3DORUJKDTaZK/cF1xOKPYIM8fJdlswBsbLPDRdseVYaFg/4OSKuuX8LoYqTwACiHkiVKhI5nKwofTefxWXV/GlSOXyMimqu5YN8MXHpfkY2ZYaahrr/Pw+NnHUCGwU4GPoscEatvUVvwSNSdogYOqinXpk8dZVk/ZyCPYBjOUhvdQEdAfGZcDx2zoGGaMrzdarSHxyx3cBQkNzbyZ5lkWlTwcs0VlQB4aUkaiI1O+IOmljTL4q2zZMxbqIUansovSvJrTT0oGj6dXQnASH+ZF4W92sknS0pMZZZJSVZ/7K23z+f+YGPToDYXhJffBucSOmgnIqdee6ITaaUA8ug+m5pkRujJ856zwC+Xk8fSBaoZCyzDjGwrc0LDbPO6ZjuWghE5IYKddi1LSQ2yx325MZnJ1XjFx0Mx3shp0Zzadd1opJOpjrrGvGN2v/ejy1JYs1AuCmpEXYXoKAlR+Df1ZdV0L2/1EWNRazYgCzSNxr/gFVqRFC46lNHV9mhjQKNTb3UevdaWcVkX/YBmD2B8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b30be0-a6d6-416b-9c87-08dcc90fe6df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:22:11.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfD1hiNKLGtx/USmp4e+aWk7bF5thzwRaCH8ZCmdy8r4pifEzC8BzkKeNExn5n2ipLp0P7sX+zZ+93ad36I1mNzfN1MksF32l6ngykW4vJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=648
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300124
X-Proofpoint-GUID: ftRyfda61C-Oliw5hg0gHT-GyC0ORewR
X-Proofpoint-ORIG-GUID: ftRyfda61C-Oliw5hg0gHT-GyC0ORewR

Linus Torvalds <torvalds@linux-foundation.org> writes:
> Sure, applied with fixes to the comment (you seem to have dropped a word).

Thanks for applying, and for the catch & fixup!

Stephen

