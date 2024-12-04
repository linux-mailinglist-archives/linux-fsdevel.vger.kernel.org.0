Return-Path: <linux-fsdevel+bounces-36478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB49E3F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BF7B28E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF420CCD9;
	Wed,  4 Dec 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BMhdwcu/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HjaBSRup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70120B816;
	Wed,  4 Dec 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327050; cv=fail; b=Hrn0MPeoizIfYwij8RAhpQZu9AT3i8GuWBEMKdM7GlRUSA9qoe9Wp1mZ4IVn79X5VXk9b+2clcBQY0A1uyZXuAFfU4dz9VG6TFlrtfHJA5VOPOr5bNni5X7MLArImkqlHW019aRj9tFRv/ATpawbPzC50dkZLFFgZh2cUDmBWJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327050; c=relaxed/simple;
	bh=PlwQketk9FLBmCpj2bx3skDOwh6/Ne3MFnw0h+vtj7c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tkOWRdBimaEBW4XzeQ/QCuIa90UXEaubv/JFZPS3Bus/Wbk2zXkTaK0NruC/XqfS8L/nqPryMCkmcIi0WRk0AF1lQvxIl6AbSkgZLr5kF+JjIoep/euHVK3HgHBw4TdyXTicmtwZsPbGuqO53O3tUgGJmOGBw0DYXjvgJSAlJIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BMhdwcu/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HjaBSRup; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4D0l8L026789;
	Wed, 4 Dec 2024 15:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=LzzXE84ifPL+YGZz
	e6ScOYdO8tzylkV1WIURQ9JJi30=; b=BMhdwcu/urwiDySPSP+t9lljuShmOIEo
	AkUKzsCK6Djtm3R5Ot1/ICC+606UyE9PSe4EJhMJr0GVVHYFuoKLFZtYyVtSaP/H
	nMT5Be1aBCdaS2UtVD3tefxyOxGk206WjHANL7brNP/Xb0CBPWVdf75gzDDh7qF4
	FYiRR/6Nh+06iffwH4oO/iS2avRTKumCYhnKe7xq4cN50XmVwozPMS4xcFEd/J3F
	8Efeqx+psQalOQyG6hnEeQ4xl1RV1BKRp481tvQt9pLmOOtQgqNexy4lH7asA3S0
	PvCWHzTDytCVH1MjjLt9yM2u0+aejBU4LVkzv0v7DMXxL9UjonXJdA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas8qsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EgW70001736;
	Wed, 4 Dec 2024 15:43:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s59md87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuO+sBPhWc0zgOC/p3gDrUa0+i3haV+um/tQBAkAnCJ3RYzcycXBwHpX8vFKCxPoVH6IaGwKlUhBfpdEt3QelOI9CAW4BRiyadX6efI5jg1VQWo9lLw42h3bAEhCrUYInGjc1rGFdXaYyc1w+3lwnCAcExOeOybEwuC/p8yHTMlNTzvP4EZ6yW1JIeySrtoiRlndQDcierAoOxJeP7aBbSGcocsP9OmKtNL+vMDXv3EwXWe4litH3+XEnBemYpJNvgOAiyDfQu8rsHWzcxQFC85hK2F7gW5TWntfEn4OCTuNjhr4LiB+6SKr2e18ktvDLM9SxVIKlLAhZV5xakZs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzzXE84ifPL+YGZze6ScOYdO8tzylkV1WIURQ9JJi30=;
 b=C/ibB7FJS3PCyzw5aLRDoqSS0reniiwrGyMGAtSYxqRv6WiPCVolCLCibTpMiO9mpof2E8LchZZ247LRAuBhoT5wYF9QWm8x3sAbJLFUjRXeuolWUeg7kJN3nV31IBW+jE8zateU8DRYdAPngdd52MN9wqkiB+N44NYToc9UcB1OTVlSUqcy+ilFEj0ECgwQ4VCl2n1nc8/SDK55jUK4ho4tocPxVydRMrnR66oppvrkzK9nj/uGaiCfvbjAepcUtDEz1v1xL/kENaejBa7yrzdjFdzt8QWtf/0ISVkkPyeRojpcIUx5sxqadW52VyDbi4G7zJqOuH9r8/1Iqm0gIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzzXE84ifPL+YGZze6ScOYdO8tzylkV1WIURQ9JJi30=;
 b=HjaBSRupfmjXnJrLT1FmGr0Aow1ri4alOo1QDupu4S4z9jKfNAs0UvQpNYNoOiRCiyJNq9x+o9uO7dIi4QQF/49jGdzGlQ3Jc7SzaagZNNsvhCgqKAvzcAdHJ6qsNRcH0YyTSRpVFyhLeZRIEdAA91cfjF6gulEYho193qTpwOo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:43:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 15:43:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/4] large atomic writes for xfs
Date: Wed,  4 Dec 2024 15:43:40 +0000
Message-Id: <20241204154344.3034362-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:335::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d978b29-18af-434d-3b85-08dd147a749c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFjns1AEtks0EAItYnIoHcsaKHx32hCrtcNPGTWMoaFYWCtPcHw1vNAbOMto?=
 =?us-ascii?Q?K+U2TUcR9VbeXGcozJJ8Pu0vZkDJVhWbvE5owDOhDN77KUq4b0bUfW5kNpq3?=
 =?us-ascii?Q?nYbS+FJUxwnlMZbLWlyvkz/59M51AEnFeouBpnRsQk2y/DwFpRdn6ZRYQKtV?=
 =?us-ascii?Q?luFka8MY6Y+CEiS3zXvVOi75s75f5GZsGSH4J1MonIPDdi16ioploOEr8qkt?=
 =?us-ascii?Q?kjvXTDpUejs6QAy4lWhyY1DdZCaXuFjPzFwTTZ1zHaiSjn2PfIYCL4aMx/lq?=
 =?us-ascii?Q?e2MdttY+4JtvF8nE+JjAxZLP0Kp1zo2m6NA5JgA+NToIy/mnfxdCgm8Vmulg?=
 =?us-ascii?Q?YhbZNZ5SQrn52AewdhkiY+g1rUL/Qaa+w5RDhx80yqV8oql7XTdgZAkl5a5T?=
 =?us-ascii?Q?pso/eaMILzrm3g11mnW/wVRAxxDOm1RijHb0Boz3jNup1Lkq93Ix2t2/gFPH?=
 =?us-ascii?Q?k8B17sKtIY6oqlWi69bErHsY5O4hPstNb4y+xcQUaludOZHxgsp79+tQBe+q?=
 =?us-ascii?Q?VLHwwRCZTzhPnWIlVSR4TFHauMlC/5/w55DfoONkQB1THXXOqvXWRebVymZE?=
 =?us-ascii?Q?5O1FMun0LHjwXELtrKz/4SpruJH58Vhpk9WHr60LTeA0COHFkLDDSXnqPy3B?=
 =?us-ascii?Q?j9ezxLjwxtKQOXrKgAXpVgDpj6l1BnsQA4KM/6y303Xkqf/jZrgiGxPz4fWV?=
 =?us-ascii?Q?mWN/uuZbBpHbXGDrF/v8C99prtNextJ80/lTtirAwwwpd6ePQiJBRfpgJ2mR?=
 =?us-ascii?Q?HhwoJP4jvC6Fxtn1cl/IvjhLHR4X7yWdJ+BZTmdhGNDm6jRG7w6P/Yh/CNi/?=
 =?us-ascii?Q?+tZFHFVu15/A+GMviE+A5eV4g+aWMDLbhQUqon4w76uVAqqaa/el0qgMAJCo?=
 =?us-ascii?Q?KbZdV+qsD0WcCAOKZpjCflFlr79sa3YmRQ5P2huv6L8vb/CzVSCiYa1mn7MZ?=
 =?us-ascii?Q?gtg5GZGC9FBaEVus+Drtr0rsojLIBqMpnSXLUn2DqLoS/0H8bmCRRQO8AM7V?=
 =?us-ascii?Q?NVwcZZGWCrLjtebbe0/Lthg+8RP27TQmkef4QuRf9/WCcUYDZe/BM8OhlSVN?=
 =?us-ascii?Q?i31YofNz+44N+pVnJOIyEhJmux4tyd4qA1n24P/9oCoGmqCEVgIiJa87ybv5?=
 =?us-ascii?Q?I9xxNRjx8VRaYa47J5Wa2KyKsHkvaCwpulRR+SyspnhBGtDxfQSN3gWA5aFm?=
 =?us-ascii?Q?ArPmXoFa+oUUqm9eX/+tfbZ0p3W/2xsNjypNfB3tsz9fp6sj/w4t7IR8Laas?=
 =?us-ascii?Q?urVOUApFRpq1S7dcP1nRgsD+g32yZmPgfMUxP0pYH7guR+rmDKl2BuZYIh3i?=
 =?us-ascii?Q?CpZxZ2WvAS45zjIvtMiZa7wbkGdA2YBPr1HtD6zvQXtl3zr8a4ShP7ebcHkl?=
 =?us-ascii?Q?PRJDvpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqH7JhI9e9o1KPHDpuFHNcGI5UrXVxewF6/OV5L1HbVJ5KZGcn5gZdSCKwXa?=
 =?us-ascii?Q?dbdPwg8XkCRJqOBONqIOzstSHnblLO81vlaC+lSZY4t39Uad9AmwwsUiV0rb?=
 =?us-ascii?Q?kv5B+UICvApZU+9EKsg9gFw+uC2ITTePxJrW6PHi9OwDRlL+0zTgPjnJwNpw?=
 =?us-ascii?Q?b3aNbV7ZLdB62B2upvon4JaLxIh1f38j6VddEcnAqHUIsOUNE2o59ecCkdTl?=
 =?us-ascii?Q?hKKEcFyk2muMWlRyX39NRlWrdbMWqu8iysZPSH09rc5PCMBuUknPRSDDLKS7?=
 =?us-ascii?Q?PQIH72RRtQ+I5BFF/SzAoi+NnYccF4P0G4eGkk+c3LpmwlICE020kVu1caOx?=
 =?us-ascii?Q?neSC8A940YvayAWSpCaIGWLqx7gTLSrbxnF7sBKx2pFJ8+mUN4EXKjzjuwdf?=
 =?us-ascii?Q?3cB8/iqY6k3NtyQ58QhE1ssKaysH/7n+DX4HaRqm3dltjICHa01d04eUCxIr?=
 =?us-ascii?Q?39aG/vrsy/BsB+bhgyYGRTAT+PKv5A7e3/NLErPCj57fXzDV0/LPYm+PB10f?=
 =?us-ascii?Q?4cWlEz7cvD1QUw3Kg2rvtWoakNYOnkH0Yg6gxqXp9pGG3vOq4YwV1fH5vejB?=
 =?us-ascii?Q?t8FTxNckLSrbl6y8TzJ05oZdTVO02/8KHZmuUx3cOwnUs3ja2NaxeIzvEQf5?=
 =?us-ascii?Q?hDspXYS1phSWWRg+xRMGAvMWGPeHGOS82h26O5CxwYQY65a5yEV9wlI6eoFe?=
 =?us-ascii?Q?4ILVVz2bfKbm0lpRHQOAV2QWCAZke8KQCyOOa25zmIgP0gkmgKcDdOPTPVyd?=
 =?us-ascii?Q?I6TcoZDrOKqmW14J3Mf7aEiJkRwOvXcIiNxrMmLcO8ssW6mCmJCv38gbJgiX?=
 =?us-ascii?Q?0IMyng6Wuvs448b5OSJVxhPXuw8uREO/ksX8k85g1bhNzQpvZWft+/+PvzH8?=
 =?us-ascii?Q?CUVZAZXrVaixQM1HTyw1RbsFkTtLw2XqQe/SlF48VB3QRn1oCja6oY4ZGmDy?=
 =?us-ascii?Q?mSykvg8kj/IB58hdLLl+/Qe9X9xHdyVDTZQx6+r20FjAvYRQcUr5Phk2nvtW?=
 =?us-ascii?Q?80m1uEA+ungl1cfXCr6s6qgj5RqeRI8oD01fdvkdXNxM+dLng16l/zflFt+L?=
 =?us-ascii?Q?t2RmixEIigtQGabel1sHJwMlcSzzYi2Uu0xj+/Oycsj9CxZKmhcEDQrKWekX?=
 =?us-ascii?Q?t/sZjmc+/V1iu9wXkE8Eq4sKm68FWtCcLXmovPtvqQS7J+gsIGC5/76flnlh?=
 =?us-ascii?Q?pDbAq8s2DDA+wDtPjjcd8GP5PQ/bvVeIP5kAqMkV9g2eRj7yyxf171r0BlCw?=
 =?us-ascii?Q?ItrXe5qDT+TdTwL7i6UR5KKiEyxuw/OBX40WyFOgg0eSuokTKgLzOfx/paXC?=
 =?us-ascii?Q?BOycSUW7C/xY0mBFCISd5/thVaFvG73v1ZdSksRwaSX4v8kUmrWrRneun2+L?=
 =?us-ascii?Q?3Q+xSB1Hxj2brx6HiTNiYeXMsvpsY6U58tq7cuE57BM+d7WS2L/IHvUjDR9u?=
 =?us-ascii?Q?C6RlX0N2GsU36u96jhjwDvlAnL5tgYo6pDUk5osXrnSOS6sulntZioCO4ZRM?=
 =?us-ascii?Q?mahZKspfOqDd89bjWFW15G/3d1WlSzIy6qi2rv6P9TUaVX/v/ok9BxqTgbiF?=
 =?us-ascii?Q?tKYvS9EX06Ky++pKTadGfTe6+0lU6HybE4mvDv0r6Trl/qXvQNpEVDDB1q5S?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tp+PtysEWPEP6XRybfavIqtI0YEk39Kx9Ilv2HSF0hBVO8XH/6gNPTvBEZxvuqCKvfrqacv43IHf2BrJQZjRTMkp5VMkvbAP+LjPOrDJVmez/sjeweFnk+xtvd0BdStaLu1/cENLYQVEoF/hUWTex1na3hFBSZCTAg9lz1cVgv+SDj0WYzJ8M4t6wwwkeM5QAwsh0kebPdu6c68166wZuFwkoQRgWjD52UaGZInMslns0VMF9TEpO5bgrLmKxx7FjpEygeqagWzBI+YPazzeWVsR1JbaznmL2W+vV7Sb8V35hXfJH+UneFB46UDm2dFn0K18LBqu9ZkpvCBzrCIxyXCbCvRoiXn4wdYkgrh/FAmHPl5m2wCofuXU7jKd7phc2I0BSuXPyCirqMImLnt1GnwnbXAX0BQqyKTIdMH6pYdOlIDmkBU8hpEOAcJvP4IqPztrTlJwxxsVtbbu9HlNt4nSA5fmTIZ41srqxWvGBq1UgvMwlhLBYCk7k4MAnptQyHJI/cT99E+Ena2VZPpPYw3fjnhBh2pTEz0xRjvqF8uwsmltyyFzt8sHbCbfC4ChySVtdXhVya5tFPWn6DceI9bHvKHMsM0i2IMYktnnKcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d978b29-18af-434d-3b85-08dd147a749c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:43:53.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db8G2C18jWkItY9dfQmnJ1PpbN2kHR+IPNjmH4pT4D+norPIIRrZr/pqR1FB+3I05VwDF+IUanr2V/Sry2Ky+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_12,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412040120
X-Proofpoint-GUID: Lafnwcx4jXHYhZK4mXDtgrG3-YqGpfti
X-Proofpoint-ORIG-GUID: Lafnwcx4jXHYhZK4mXDtgrG3-YqGpfti

Currently the atomic write unit min and max is fixed at the FS blocksize
for xfs and ext4.

This series expands support to allow multiple FS blocks to be written
atomically.

To allow multiple blocks be written atomically, the fs must ensure blocks
are allocated with some alignment and granularity. For xfs, today only
rtvol provides this through rt_extsize. So initial support for large
atomic writes will be for rtvol here. Support can easily be expanded to
regular files through the proposed forcealign feature.

An atomic write which spans mixed unwritten and mapped extents will be
rejected. It is the responsibility of userspace to ensure an atomic write
is within a single extent.

Based on v6.13-rc1.

Patches available at the following:
https://github.com/johnpgarry/linux/tree/atomic-write-large-atomics-v6.13

John Garry (3):
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Add RT atomic write unit max to xfs_mount
  xfs: Update xfs_get_atomic_write_attr() for large atomic writes

Ritesh Harjani (IBM) (1):
  iomap: Lift blocksize restriction on atomic writes

 fs/iomap/direct-io.c   |  2 +-
 fs/xfs/libxfs/xfs_sb.c |  3 +++
 fs/xfs/xfs_file.c      | 12 +++++-------
 fs/xfs/xfs_iops.c      | 21 +++++++++++++++++++--
 fs/xfs/xfs_iops.h      |  2 ++
 fs/xfs/xfs_mount.h     |  1 +
 fs/xfs/xfs_rtalloc.c   | 25 +++++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h   |  4 ++++
 8 files changed, 60 insertions(+), 10 deletions(-)

-- 
2.31.1


