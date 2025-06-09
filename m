Return-Path: <linux-fsdevel+bounces-51062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C55AD25BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E853E1891450
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629121CC71;
	Mon,  9 Jun 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O7TDUu4j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMxJFFU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D319258E;
	Mon,  9 Jun 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494273; cv=fail; b=ahV2UwCpq98H+CbIwBDRbmmhmgWP7Y+/kiDuxThwMZ7+Ct6IZgfujrFNoVS7E1TPM1A73ayiZ3UQUwp1ayhVYZ1xJNSnjC3kOsDpoNotjm5WV29VHOBrOMLxULngDAYvljxUdnQFPeaPgXXUVzGd527yW3IQqxhYg6/m8HrdhQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494273; c=relaxed/simple;
	bh=/xnCrcTPNeBqOhsQAeULgQOvrknubnfbtQqAmRe5fMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xg4JN2BgiyEm7eIJLvApUE2WSyd+pGjjQwMVj7qGF7/A6Xb4N1qY0MldCys61Fuqa6vvrW24csHY/5qC6DPPjm6orsjECDkfUGMbr/DsYTRi+MhWLeKmUpbHFr138j0TSALG3odTvvWkLTlbgjVBFU6lU7QGxfBXY2FC0gVg5rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O7TDUu4j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMxJFFU8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FhdCv010902;
	Mon, 9 Jun 2025 18:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kB/0odTmAVFHzUs6VH
	SY50wQUOjX1ao+XeM3xrW3jOg=; b=O7TDUu4j0V8ShF556F+TQqrXUHZiEKaDlu
	OpJ/WSf1qCl78sW+pDF0qbrsSfOJTH4s5f+ED4Yg18gGbP3Nyzy3Sw9YflYS1IaG
	NqO+H32wMPWzcIP8QE/cBvd2Cl4qw6uV6j2oTB8S14mCGSecg6xNmtPncavJCEDu
	Q36BekMtFw7yqFcBBT/RlQycdgxSRL2lx0jIPv/0KcD72JRjPDDhMko9HjPlI0VR
	UE6vPsQVcCUp8QvjD1peDA6pMtydkONEOkgOyq8ZIBHhF0jCRCA4wrWAsBqRBUs0
	GBFFnkv1Cween7ZZn/k4FBMLBPKOcRXlZCUnBHPQ+se5sfsgHWtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf2ryd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 18:37:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559HhV10004011;
	Mon, 9 Jun 2025 18:37:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7s8uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 18:37:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwGTL6T0T4rVbqLU2PLOluun1mkuDYpaIvIhNqiPFxsAd9Nsb4FpGF5/8yuIsgAR8kOcZfcdkkT3JMX4eSc66hODyL5W+aHcW4QgK+BB/uo2AhtEtEdkP5dyJRNe2sIr59AGzw6Ko3t2bTNy1xSqQYWLxaIFLHPKWSivRXBn7qR74E11aeUCu0ziEemB62WxL8Dwwh7ZhQxTxz6iBQjy30RqV9y+TLF/UgoJtIVLS90xWChmXPh2LSrWjAbjV1asr3AAFogATbGY4VtVYTkAG3ct+DcPK3c92CcQTmRkLMcP8wwA3R4r1v4QACqwC3gjcNdeXPMEMm8wFupiVTb0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB/0odTmAVFHzUs6VHSY50wQUOjX1ao+XeM3xrW3jOg=;
 b=b0mtxCEA2D/WBKiPTnpajTnpXaYaPePDlNvZNph7CT524e4PAvS2USLhqU4v7PzBu9H/4OC1dXwPEbzSC/jTTiWoM2X4KUVJdSzvr7LXrZjrCX9hr0xjyTF1NBe5AFGoZDoZyvfLcJKoUtTVMCxpwt+FfKOT5P3HL45aJiCkMMSx6yIUAiR6KDj2SZDmRmmSGtQL7Dx7L3prfg6ZIbcfkICSFCz2Pc3dRaLtCEJPiL/sabmS/OoA2ZxKOrEzL6NnJtwW7r3EA28lrG6kihhFR7Gmv8tkLvlKsb3YN/II1cdKOMJl0XagLzAsW60iZYnhvoKW+14DE/qLLQeiCj6HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB/0odTmAVFHzUs6VHSY50wQUOjX1ao+XeM3xrW3jOg=;
 b=OMxJFFU8lx7FIgdzNIR2eoWAt2GZgMdVJ+mD1poiwn0FuESxXNrIu0/j3//b4VB9e/5BkS93P/QCyePMuCZZwO2cJo8bhhMl/CKZmV38ygexNh9O7KaCAUpL6GjkiIgrrXy9QDuq1S2C7XRYIwj8YmaANsxOdktwRp1xWIk6idY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA0PR10MB7134.namprd10.prod.outlook.com (2603:10b6:208:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 18:37:35 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 18:37:34 +0000
Date: Mon, 9 Jun 2025 19:37:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <2d4750fd-10d8-42f6-a396-ceaf386e65f5@lucifer.local>
References: <20250609165749.344976-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609165749.344976-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA0PR10MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf61695-b9e1-4415-22b1-08dda784b3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFW0Kc+BTz9RGinsCetwR/OX3u7Hy6nYwcCejrRDQnTANohcHkln3M2x53JF?=
 =?us-ascii?Q?lZb5aQ/QpoGbQnRoMqb0XE8quZ9jCF8cIVHBDd4Zvczn2Nmz27DMFJsrT2Gj?=
 =?us-ascii?Q?SsZApQUxLI8xw3m0HrBOt/L24xqc90pmzl7DsBwy6A9qtC7u7Q32G4viT4yC?=
 =?us-ascii?Q?12G0jR9Qb5jr0Z11yq8BHF2lcpS9+zKPkKLoQ0TwQMlEnCQQCWdEIHX5v/Y8?=
 =?us-ascii?Q?Q9T+Ry9UeqA8G8O4+jT6jnlVEyPzFhoGh9uym9rtDGKMc5IOvOhB+vnW6s6S?=
 =?us-ascii?Q?sycOjoGzthdSAVLJZCi257JF4ZsIzI0CoRX9TgZVZUGd115ICk1UsGxSrFIA?=
 =?us-ascii?Q?5tDLEy8wmcEl28xNxahng2LAO/1HvPSmILk3WhdCNjaByqi2q0uqoBEdFB4A?=
 =?us-ascii?Q?P7DBIb/9ZqENoLH9M+8cSz8G8YhD0oYYxSAE+u/OiGQXGnfu5XDzTqDrz+0k?=
 =?us-ascii?Q?hO9hYsOVetxB/FKXuLKN56ncCoqpbhbR4hpwD4iqBQlWEtsGvG8Pq0qU1s92?=
 =?us-ascii?Q?7YOrsUSGX8VTiDylFWajfhMfiktYavvW3OQiodpz0QYMBy0IRLKaJyIwXnJ3?=
 =?us-ascii?Q?1sqzI6xCc1rXPnCR9Pk7Xd9Pcp/c7vTE/1Kj89GfqMPe1lzPiBwQXZaWJzwK?=
 =?us-ascii?Q?LEFhI5LmBlTGVvxy5MMRBdry6gN/NYMhzSG6xnf9eUFbZMRZqxgx9c9P3m+L?=
 =?us-ascii?Q?2KUKqzcwVE2E1EKHOP9wxd31rfed8Aixzxv3+JkHlRQq7irO65fMK7Dx1EkL?=
 =?us-ascii?Q?pXqBSuGZZIfx8QyErz8YZC/zEsWwxMnxypt3Sh1lnkwBIh9LhopqN3kP/972?=
 =?us-ascii?Q?8IWAtmL8u/HwydOxSEAtrGVLZ+N8sBq2PUkhj17KxGc3VYhLy0co1ESlf/jH?=
 =?us-ascii?Q?NoXXlR4zfe9Dsc8c4JjtYq/weTRFpzvgyQAdD1CAxXtiQLS5m8/YxcuVsRGE?=
 =?us-ascii?Q?T+YhCw6e6k+Q5AcpsdUnYM1n9OV2HPx9hHCyeg6abZyE2ToYEnhtNj6GZWNE?=
 =?us-ascii?Q?l8Jx33E8E9LRlL0JxUVJxPsdmwJLXft+RRh1owuoESyVFBN1A8W0reDgF6cU?=
 =?us-ascii?Q?PTKdzWEHdwz1T26DtdNny10xrt6cLNR9UdmE7ZOAw7gi0gdSFDxNsZtEK8y3?=
 =?us-ascii?Q?CStyh/AaMn2tFZJqsqpHQf152a9Aj9TIeSU019bdOxJ1CLueOupgewf+dJgn?=
 =?us-ascii?Q?oK40ElHiiVtuWdvXjPR0NoCSRpyBrCTUTQpt3S/lcnzXphLjCiu323vCsaAq?=
 =?us-ascii?Q?qvr1g0KRZjGibDT4XXKy8HGKJuYh8ZEb128saAbVRTK4XSPL1znD5ERucP5Z?=
 =?us-ascii?Q?DQkSKQQGLq6ofNcbR5Xqb/Ed+UH3auM4OuqaYIFNDmux8xbKStFsazg45U6Z?=
 =?us-ascii?Q?bBm9L219z2yyc/RlNhDiDeRCakpFpVgFLObsd+kQ5CHq05sLJfYA/8Ze/0Bp?=
 =?us-ascii?Q?vg5MEpO3wqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuLaHQ1SzKJnqMIKyt1bcgFsxNnjkpCnfZA0lwzsySxR18j2CIv/bycfvjbN?=
 =?us-ascii?Q?DcEpuCSO/TwPyGYLYqpvKA4LCcBY6yaL0At7VXhWpoFBmXI59unRGhPj/MQl?=
 =?us-ascii?Q?f6K/zZSIBoeFbT+1et/Vm3YoD0gyDMpCZg/vwM35wBbqU2mEW2jQ4nnuGlxg?=
 =?us-ascii?Q?RnWK1hqZTuhvU1WYNvc70k84YvHvXVLcOAFQJpfuC7SdDmkXL+6FAVpa4mlq?=
 =?us-ascii?Q?UFwt3YU04Tvk71MmnVZJqvJwwtVCld++sx0yEYOZ5Szc/ysaunREAHu2+PRf?=
 =?us-ascii?Q?jbeG+xoypPF5/OK3KECgXrtcVntfCzZhgPVL6nNeAgo510iG3h7W2nS4SPe8?=
 =?us-ascii?Q?xa/9BNO29lc9W89ESfAGaE8it75rBiBusiF6XiVAcy9MQCSljiqDoM7LDNyF?=
 =?us-ascii?Q?SKDyRPdcP0Hk70zPp7CDSPL4Nbd01jIv3Hv4AjkQ8eq6I4C4TjwsdYHzaAE2?=
 =?us-ascii?Q?pYIz7HUV+EOkiuJRBlsI8Dnl2lyVSmUq8f4RcPj62/Aa91sioikd+JzGMHE9?=
 =?us-ascii?Q?6giJjjb1EyyoklN6LmicGehEdSwSqz71k2+it49CsyAI5+bSgxiKVMAB8JgT?=
 =?us-ascii?Q?HZGgRyb49TvhzvKGQycoVMFtI7mm90KTdnCHBpVbvgtQtYyczqoJ4ARk7TzL?=
 =?us-ascii?Q?+B27RgIx1ShP6tVhk2wdZleopgvsc5bdMmJ/8U73coEXa/SGKgJVjbvQjOHM?=
 =?us-ascii?Q?bWL1MAAs6XAdXOx1Y8j1p1QmygP01gDUZCosyt6uJa02ZRxDosBCOsRdXQZQ?=
 =?us-ascii?Q?VX7/69LTv5e0dmNLUMRT/EVOV1oV/cWfTLgrL2df0WTpCj/56+B/QlqsB1tb?=
 =?us-ascii?Q?zp28YjCrbtvzdmE0FWMrOPJVJXlzHdYsYdWPuwEuurwuFV4LB3n1sje9ZhNf?=
 =?us-ascii?Q?MTqQiiBFr1tpjkUzLc+PzNzTyM9XSt7ZF4Es1C7GEioVmip1SVffCnW0Z5b7?=
 =?us-ascii?Q?e8mFNK1X6BasI0tE1Y4jaSglX5nrUmaiw0z3NQ5qPhF4wUDpk3giS2E6slsy?=
 =?us-ascii?Q?COOxXl9hYmEfYzvtsjyNvYPd8nLOKZic20UBjXYOMkPR9Z49ku3bE+uqPFhj?=
 =?us-ascii?Q?JsqvqI2Bb+bz0iOZhc26vfrinCnxKEcTcSC3TIHg9zNMYzfcLza+0ovY1Go3?=
 =?us-ascii?Q?B1pS7umnaMduAPZHbVeoNPbBTZT8ETMKaKeYGvj/uESGLqB1L7KlDedo5j3P?=
 =?us-ascii?Q?GBds0Tf8/MDYpe5LBMvHEe3ZdgDC9JmRaaD+DkOUbKSWKn6gpr2sUTUvl5tv?=
 =?us-ascii?Q?rrqiUYW3ArtVVIkhjg6xLj2YTzyto+OK+mqDo27B1kNRq+FF/nBFedpAaMK6?=
 =?us-ascii?Q?PvfWcyJ+2Ow/IATj2nY9dxsQ/hv9Uf48FXcYE8FpLIJgKNgc0c1AtxnhXRQ+?=
 =?us-ascii?Q?Yxbnep0GAvPAgAySdVDH22LRaKkG4AY8J0tShp5b+Bkq32XaNI7Ul5+LTZ5Q?=
 =?us-ascii?Q?YMm3d2F7epGcpAbxnjD1ivggJHJSav2HAtcnUK1q2SuICqBmyjbmJeuNSukF?=
 =?us-ascii?Q?PGb05W9gltaowAKSJly3SPrrFqv3b/hM/i+i1r/3Y7sS7yKetLJMdHraa7YS?=
 =?us-ascii?Q?zqWiNLptfs6btOM+LfZoshMIjEe1J7yGxfuNvq2ifzJgOCv/rxss5zdu/aWp?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iVzeVfWw4L05LDmTRcR6UZx2weCit1u1O54lC0urRKCcZaKnvWY7UqzHrH3QUnvsAhL0JNIE6oI5kE3XwRW7m1uv8YB7/YUDGsh7YuFKHkgmTgcbvesxmLKIGKvYz55RljTuVI7mPiVd7Zn7h0NlXx+HAXOM8JDYg+Cbn/PWF8JdlpNlfs9FSZACuf3z3NijzoYOJTc/F1sHowNGO4AJQARTs8+RD0prGB58Q6LpJHWjtfeTwy81f5FBVcZgRXUGA/kQyKCnNaLBDOcl6lm3E0zW3Yjo2QLqebUlsk5BQsNwPq4p6Gg+hCOWG8GxIccmnZsb9rLyWsTVjmRGM0C4PG6UdDaeakd6JxoqZ8pzbhxqcsxihxESKnvBZoRsE50U9KeJTkLPH8W9ynJpLgYy3IE6L727r9CipFXoPOZRT7vG1v+69ujCVdoXZ9yvt6Anx0wmC2XRvjlG3Bzzt3Dwhz6y47+xQqYXvP+jBWvAVBVqP7JYYu5BDL2EOEazNrtmH2LBUS5fDtC39smWMFEYCYG7qlqYncxl5DOAEwYKxzI6GBZRfg/p31vMjQFJW7sRZugnyEUsqiBZxSJ0lHjCJG5uacen4CUAfrh1LFhXJvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf61695-b9e1-4415-22b1-08dda784b3af
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:37:34.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI6xD3lZO2fgtsIlXzKA+fi2STzydAUE2rXBFllhRzFINS9u0gNzrt8wfifXu+Yquypz3l43zeQRcYKFN5yWNErof7ymjQJl2jkvt0ccc+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090141
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684729f2 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=eF9pwXU_7nNgi4TVLEAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: hnp0cvvtGcbV92BnpHMfGeASS_vEPkMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0MSBTYWx0ZWRfXxcXYQ//Yl7y0 uhqmh0d+SPdeOFlyMVso/EfS550htCwkb0dHG6kCjURNo8uWrE01FKpSTMaQjp6AaXmGJ/MsPSR sPdlcOHN/1tbJORKcCJM0yOlfmImRiNougl1JlmptbasmZN0jTNRSfTZRI4WwQY3cA+Q8PDom07
 kBgxj5jKcFBYdMj1u5xtJmGjImaUQ1DJ3RSWA3YSp7Mo2omLZe8Bnz2Dw03VqblTtt7f6b9jR/g QIWsgVJBpBXaSXdA3m9zbwFrNNeSUSHRo5ataHLXdaMXN0TpEFDmKAWqQ8c/WmifaziQGYJy8J6 1QSsB2hjJoYNCFGzG9BHk2LV6qiquIwYF8EP3IaGqUBb+u+4WFnMGUZ9f9iXyGdQsdWhSjn7vRL
 rmsrtQDAbFw6noGoNwiDGH5h16wYgBBVKeC4Co/ARZolMnxDd31rloMAbQAXi6Orm4OUV4i9
X-Proofpoint-ORIG-GUID: hnp0cvvtGcbV92BnpHMfGeASS_vEPkMC

Andrew - apologies, please attach the tags as below which I mistakenly didn't
propagate...

Thanks!

(note to self, figure out b4 :P)

On Mon, Jun 09, 2025 at 05:57:49PM +0100, Lorenzo Stoakes wrote:
> Nested file systems, that is those which invoke call_mmap() within their
> own f_op->mmap() handlers, may encounter underlying file systems which
> provide the f_op->mmap_prepare() hook introduced by commit
> c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> 
> We have a chicken-and-egg scenario here - until all file systems are
> converted to using .mmap_prepare(), we cannot convert these nested
> handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> 
> So we have to do it the other way round - invoke the .mmap_prepare() hook
> from an .mmap() one.
> 
> in order to do so, we need to convert VMA state into a struct vm_area_desc
> descriptor, invoking the underlying file system's f_op->mmap_prepare()
> callback passing a pointer to this, and then setting VMA state accordingly
> and safely.
> 
> This patch achieves this via the compat_vma_mmap_prepare() function, which
> we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> passed in file pointer.
> 
> We place the fundamental logic into mm/vma.h where VMA manipulation
> belongs. We also update the VMA userland tests to accommodate the changes.
> 
> The compat_vma_mmap_prepare() function and its associated machinery is
> temporary, and will be removed once the conversion of file systems is
> complete.
> 
> We carefully place this code so it can be used with CONFIG_MMU and also
> with cutting edge nommu silicon.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> Apologies for the quick turn-around here, but I'm keen to address the silly
> kernel-doc and nommu issues here.
> 
> v2:
> * Propagated tags (thanks everyone!)
> * Corrected nommu issue by carefully positioning code in mm/util.c and mm/vma.h.
> * Fixed ';' typo in kernel-doc comment.
> 
> v1:
> https://lore.kernel.org/all/20250609092413.45435-1-lorenzo.stoakes@oracle.com/
> 
>  include/linux/fs.h               |  6 ++--
>  mm/util.c                        | 39 ++++++++++++++++++++++++
>  mm/vma.c                         |  1 -
>  mm/vma.h                         | 51 ++++++++++++++++++++++++++++++++
>  tools/testing/vma/vma_internal.h | 16 ++++++++++
>  5 files changed, 110 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 05abdabe9db7..8fe41a2b7527 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
>  	return true;
>  }
>  
> +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> +
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> -		return -EINVAL;
> +	if (file->f_op->mmap_prepare)
> +		return compat_vma_mmap_prepare(file, vma);
>  
>  	return file->f_op->mmap(file, vma);
>  }
> diff --git a/mm/util.c b/mm/util.c
> index 448117da071f..23a9bc26ef68 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1131,3 +1131,42 @@ void flush_dcache_folio(struct folio *folio)
>  }
>  EXPORT_SYMBOL(flush_dcache_folio);
>  #endif
> +
> +/**
> + * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> + * existing VMA
> + * @file: The file which possesss an f_op->mmap_prepare() hook
> + * @vma: The VMA to apply the .mmap_prepare() hook to.
> + *
> + * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
> + * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
> + *
> + * Until all filesystems are converted to use .mmap_prepare(), we must be
> + * conservative and continue to invoke these 'wrapper' filesystems using the
> + * deprecated .mmap() hook.
> + *
> + * However we have a problem if the underlying file system possesses an
> + * .mmap_prepare() hook, as we are in a different context when we invoke the
> + * .mmap() hook, already having a VMA to deal with.
> + *
> + * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
> + * establishes a struct vm_area_desc descriptor, passes to the underlying
> + * .mmap_prepare() hook and applies any changes performed by it.
> + *
> + * Once the conversion of filesystems is complete this function will no longer
> + * be required and will be removed.
> + *
> + * Returns: 0 on success or error.
> + */
> +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vm_area_desc desc;
> +	int err;
> +
> +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> +	if (err)
> +		return err;
> +	set_vma_from_desc(vma, &desc);
> +
> +	return 0;
> +}
> diff --git a/mm/vma.c b/mm/vma.c
> index 01b1d26d87b4..3cdd0aaa10aa 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
>  	return ret;
>  }
>  
> -
>  /* Insert vm structure into process list sorted by address
>   * and into the inode's i_mmap tree.  If vm_file is non-NULL
>   * then i_mmap_rwsem is taken here.
> diff --git a/mm/vma.h b/mm/vma.h
> index 0db066e7a45d..d92e6c906c96 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -222,6 +222,53 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>  	return 0;
>  }
>  
> +
> +/*
> + * Temporary helper functions for file systems which wrap an invocation of
> + * f_op->mmap() but which might have an underlying file system which implements
> + * f_op->mmap_prepare().
> + */
> +
> +static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc)
> +{
> +	desc->mm = vma->vm_mm;
> +	desc->start = vma->vm_start;
> +	desc->end = vma->vm_end;
> +
> +	desc->pgoff = vma->vm_pgoff;
> +	desc->file = vma->vm_file;
> +	desc->vm_flags = vma->vm_flags;
> +	desc->page_prot = vma->vm_page_prot;
> +
> +	desc->vm_ops = NULL;
> +	desc->private_data = NULL;
> +
> +	return desc;
> +}
> +
> +static inline void set_vma_from_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc)
> +{
> +	/*
> +	 * Since we're invoking .mmap_prepare() despite having a partially
> +	 * established VMA, we must take care to handle setting fields
> +	 * correctly.
> +	 */
> +
> +	/* Mutable fields. Populated with initial state. */
> +	vma->vm_pgoff = desc->pgoff;
> +	if (vma->vm_file != desc->file)
> +		vma_set_file(vma, desc->file);
> +	if (vma->vm_flags != desc->vm_flags)
> +		vm_flags_set(vma, desc->vm_flags);
> +	vma->vm_page_prot = desc->page_prot;
> +
> +	/* User-defined fields. */
> +	vma->vm_ops = desc->vm_ops;
> +	vma->vm_private_data = desc->private_data;
> +}
> +
>  int
>  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
> @@ -570,4 +617,8 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
>  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
>  #endif
>  
> +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc);
> +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
> +
>  #endif	/* __MM_VMA_H */
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 77b2949d874a..675a55216607 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -159,6 +159,14 @@ typedef __bitwise unsigned int vm_fault_t;
>  
>  #define ASSERT_EXCLUSIVE_WRITER(x)
>  
> +/**
> + * swap - swap values of @a and @b
> + * @a: first value
> + * @b: second value
> + */
> +#define swap(a, b) \
> +	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> +
>  struct kref {
>  	refcount_t refcount;
>  };
> @@ -1479,4 +1487,12 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
>  	return vm_flags;
>  }
>  
> +static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
> +{
> +	/* Changing an anonymous vma with this is illegal */
> +	get_file(file);
> +	swap(vma->vm_file, file);
> +	fput(file);
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0
> 

