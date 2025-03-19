Return-Path: <linux-fsdevel+bounces-44436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDFEA68C10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410A4188895B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C001B4F0A;
	Wed, 19 Mar 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZV6VX8B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XTHnnQvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E3255230;
	Wed, 19 Mar 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384706; cv=fail; b=Zbemlc+rjJznoZzt9QqJ/6Deffk1qsy5prAeO5uUG973IYo4cK3P+TAHz3gfa/90Tyf6dthFJ0iSvJCXSdU5S6DYZMm8tmuhgQRu6xIh9TBSCXGVMVb3oE6DbAEufzeV+3KFX3/2jWXXTSgfCGFaXd1ai/ceyvIjYBk2hEBo3/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384706; c=relaxed/simple;
	bh=fO+cpqYzsk7vkzbx0PIZdOzi2QUvzjCTae+yXmBIoWA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CLQU/BNzRSY9bGm28vhWaJ8iscqe58+Nd+awjYt7msxzwPsG/QZ+hPWZ3nj5EBKse9E/uHQ8dTfE8qx6bbXS/2dVchaO0gzr2jAYq290XVjO3zgMLYUtqCG6V5N/SLdjvAyI2DMFytji9GIB9JDBtQt6p4YEvSM7crdWHCC3z1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KZV6VX8B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XTHnnQvQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8fs9p027459;
	Wed, 19 Mar 2025 11:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=L4SmgJNWdWm35k4x
	mdgfgxVkmYtvAc0sog59ecGEktE=; b=KZV6VX8BrH3tSacGj8Q2VLzJX2t7ilxz
	p1UoNi5BrkZM56dNYP5uBr8N93rFNitGp1cg+uEwaz0cPWbQfGPKklz5FJpSNULk
	FrJ7mUaM+Zn6sRpDpGj0FpZzn5jKaDSC3mHmx5E3tOTf9suDBQiVlxVR5txNDOqW
	PTwzFihVUH2hRCHYeYqE8EVztKKSGTbL5qHVjxtO/1nw0Sj7uJW4S4zx8MPbPy3y
	3Ki7QgfvmP8HCWpDYAizJwTs/0EIduwgMHxaCSavbvrnvOFFvQ2dFbbWeA43wsZz
	rDQzP/MlArveFHhZ85RDuTGDN1HzLAUJeWV7R6gtPTaZR+KdihVc+w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3tuft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 11:44:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JAKk0t023645;
	Wed, 19 Mar 2025 11:44:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc70c8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 11:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygCjQjoPzyy15IVcbpLbG1DUyZcFHCKBSg+n+R6gEE4BlGGRdgd2z8lqv9z/c6ld3RvO94dSKY2KLeJb8DcZ0KFUAvuKAMY6zn+7tt5njuK5CPfywljSnxP/Eru4yV8B+pXTBcrHhI04t4KwGFMmI9BYtTViRa3gehgsZm5wimR0Jr9PZahCv/7h1uyTlATLi6xyGhnwbPg/l1ahTUaBWySFsWc6XWTnei9TPBHvYYYPJ9jW/j85i7d2Mhiydu6BqA39W51kHdZAu7nfBissUuF0q+7Q7surCxeT5KeWXhPoe02kaicPATUmcEMLapWM2yqnfdLYOztspCX45hpYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4SmgJNWdWm35k4xmdgfgxVkmYtvAc0sog59ecGEktE=;
 b=d7wP8/kj4PmXl6PvsgBP58ylwPammqLKn4eLomBGNByrdBXcWru2mxGjuDX0DG4DTqgdDOfOausLky8UhzsDgChGiqYdU/txTA+mOuEwIQhYQgQR9O96nQvKZm2+7dLYGXSiT3/rxBwGMhTZmuurIl9x9hHwHL2dLlrzqk4AggC6c8F8AL9IEL6qJILEtFwDf8OkDLkjkaRuc2ziDUMGQ7HbCp3p/cjYvkKnTjEc8qWgFzLqbhrQH81IKMtvSCtVlKCNmwZiFF8Cfewya+aJX/uxcZeBzAx7cepZAQS01RAaA2t4VE6EzNQDCyrAixKLz911NRebS6p7V6sOpmHFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4SmgJNWdWm35k4xmdgfgxVkmYtvAc0sog59ecGEktE=;
 b=XTHnnQvQwKJQ3hFKDb8+28Vf4wrOc+06DLgCH5FunpZORD5OEPd9l3mlhpLC2qGTnPdNWL6NTIXN4sFFPBlubP/f6dMCYmgMmwD0uhghmbGkpEzIi15s9CyDOPzOddfirBS6jbFYBYw6DREw4WTTcCblf0/o1gGIxTiN4dsgYnQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 11:44:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 11:44:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org, brauner@kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
Date: Wed, 19 Mar 2025 11:44:02 +0000
Message-Id: <20250319114402.3757248-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:208:15e::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: c49b422c-b02c-4134-67aa-08dd66db75de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1gaOTSOGjyrQPmbsqQEgNEWfihaDLrYrWnWErY9oKbkndj1WGDfNEnLOL8dv?=
 =?us-ascii?Q?P5YHgXixwSS4Qy449Oq/xWKmUkp9QfQ1ddBx5bxtdbBd4fdhTdvMBy44OyTZ?=
 =?us-ascii?Q?BzNRbnRw0d91tyedaMHb9ajZRotZI4LUaBSpKf1eVXprzwSiQKVDBpnexQyC?=
 =?us-ascii?Q?zGNlf7ztMs8kcs8cicwX3j8hSQgNTSY2RzxJ0TO/FLarvPAnFr5VkJ8Rc5mY?=
 =?us-ascii?Q?UdGJhE63akQkcfYKMatROdM1aJZwipS+qx8um7xahAWm58XaHTAa2sBTx5jb?=
 =?us-ascii?Q?1TiRdMejgnS1hL7pnPeNJKwrX5OZR15/X+Be7+zIkwuvNzYuzgbEXTRgowBK?=
 =?us-ascii?Q?V40UMv/VZaHTlo3IUfO0/Q8LIfPhh/WSmb6aNMpNdDyM3znRh2UTX6J5TBFa?=
 =?us-ascii?Q?LVG0gGAc+B2Da5kN/zCKcac5fvcLibcDF8vwETJUHmwPUP7fcR8VpjVdgmBY?=
 =?us-ascii?Q?buaOAKlQpglsFQCgG613z7eht1Zyf4Tg337Cda23WJB1FWRPo583Uln7r4vA?=
 =?us-ascii?Q?ZByVnEef2A2fDRjAwq/fbUiTEaTidTzm5pvfHfKfjTg2nOc3/vKZAmnx0Py6?=
 =?us-ascii?Q?ZSB7saklbDyd74SEi+B6xlkULEDbe1fI8o9lIwxDcOLs5qF+C4y0P0B6OU+Q?=
 =?us-ascii?Q?qwjAceUgYCRWisZBzR+cSrZU/wZUNVtBcNQfMhl1wrcjFiBeU4tFNjn6+0pU?=
 =?us-ascii?Q?2sPQLU0uwA+TKzshl3eGLdGISEPDael+kn5A1GltWNQN4Aa5KrJSPj5FMctm?=
 =?us-ascii?Q?UwbVfZINeKwRdkT/M80ATz4B91WYlS1DtVL74pv6vhkHJp9TjzenvnF3kzqJ?=
 =?us-ascii?Q?lORor58vT4Dc4h7cWebs29At3L0zhxe5FKoVnkBlYcBz9X9hMIRzxBiI1q4X?=
 =?us-ascii?Q?uSYZM1hNdb2HBrTbLmP4MOCbM9ZtA+m4zSKfVSVg8EeP1fzi2TGLFAnqSHJA?=
 =?us-ascii?Q?4yWrvmM1E3ULptu6NmxIVVmp7ttVq7zx2Ye6qgK6fXZ9xbaoK3QsaA0R5vcK?=
 =?us-ascii?Q?zuUnQLzkn4ItqTkXKTlQrL2PcvLfx3E/VmGN1jcPRjQr1ORlC3uWs1B8M9B9?=
 =?us-ascii?Q?+LOd7MR0Ci8EDKumWLUGnnbq0q590oyppf1N9gybkvb1Q4f+0qAP9u2fRY5P?=
 =?us-ascii?Q?nQcX6VOmnbpRIh9BhowaE4DHmBAB0mgmqPgjsnjA1rRfJyF7k6E2S18Eow8d?=
 =?us-ascii?Q?51kbPZOpyJOy6YHRshtz3rTDqeSaTMnrTECJXKAzYEtzrTbzvbk5wgdNlOOU?=
 =?us-ascii?Q?87R9g622WUMfnahBOrmeaGzcLvY/JnhqsuNinBzlNqAD+NqaxLgGshADEF/t?=
 =?us-ascii?Q?ceAVw9mzmIhgA8cTEaE1D+iwLCmrmeht0LlAP7YKIEO3idmv0mlGeB6JKLwH?=
 =?us-ascii?Q?M/Mr1trDPHznSeXkPu15gVD0a5+X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMWrXUJRkmwrfb22qUh6sVaC2p3XOgZK4c+Wacb9PCDILqBcqsuIHI8iDBPQ?=
 =?us-ascii?Q?QMZ1Ccm5XpN1Gd2364cq8HjQVa95JBs9POkKTykqRRYEBiTr6Fzmd2+SJmP5?=
 =?us-ascii?Q?LVYxPBlmdgUOA+HCYvdLMsrZyI+g0gMRCS/yjM9PdlBfYXLDcm2XHYITaUva?=
 =?us-ascii?Q?2E5HKYoeXQjSG9EGyhOqberga34CNAMGQIz40BjgVvATNZgbjNLCeVI7NBJ1?=
 =?us-ascii?Q?oY1FcbQU9mz483MDV/hHw5Ao4b6XShtwlDBB9x3TqkP6TQCP8D4gsB/BrxnB?=
 =?us-ascii?Q?Vlx2SnyfLN58F7MQk17hlCylit/i3UxSGG+LODu2tNKWQQJmOUzWVdihQBeX?=
 =?us-ascii?Q?Jmuxt4/niXVjWQsIDkkczLIt1gEkPaPykXFufVFblcIJWzcbYz2wajitYWZL?=
 =?us-ascii?Q?x1siR5H0scP6Mmk63d748qV0vHD5jSz5+s+NkNatk54EyAmuoqX94loVc8Ms?=
 =?us-ascii?Q?q/THWXDZND+c8zwWskm6bXYTXdm3Xw31Wswn4iwj+FbUFTc92jlhJDpJMBpp?=
 =?us-ascii?Q?qwnSVfJvtduXSRSpxOpv/KCbNRo+ft1fS579AVIErtzvMp33V8BuaMIDyokz?=
 =?us-ascii?Q?vyBTKE6vfJmp08r0jLuczVTaHJf81wZbbEZtomG9jdtjFfRh3BMkYtCtJTbl?=
 =?us-ascii?Q?PEVRG5PCuiFn1hc0EUdOQE5o+3TWfMypf+NzxrEmyddZrmLCY+RzvJu+hgVG?=
 =?us-ascii?Q?2YS93fEppF/Nqnq393zB0KMX3ExvlcnrFAjmtcWGCCunx1a463dIHBWMhyaY?=
 =?us-ascii?Q?FkGhIl4ijHsLa4AahZWYzfsdpzT7ETr9PzCU4wGtrCigYZrZCG1SaYpVTjGD?=
 =?us-ascii?Q?1xKTuzry85gA7IinsRBkq7OZXSn0woE3yYTvnvs4tG6WeDCSQUPI6CJJRNQL?=
 =?us-ascii?Q?4Cfd3OG5pvGY1zDBeRXqcO7oph7VYDS5lOA4KyinbHN5nffz/IzCBocmuXB/?=
 =?us-ascii?Q?WmINCFL4oyaR/qbX85KSkc+Odp7M0kUZzzqqvF5HOQyy/7xN5ZotbjOsW+e6?=
 =?us-ascii?Q?HYtShRlO3/MyvIDiS4YijZl9n3gT6sOdOG31QvNW/QBloZfyzaBiW3FPzJ+E?=
 =?us-ascii?Q?pemNNGn34Z+64EBYa2CyVDjqr2FD6QXMehFFZt2M5HNpuxAcUGhjrMm8LCJm?=
 =?us-ascii?Q?9bOaroGo22HEiYMFYr6M7GZPF/ZO218KYETH2VID8FTPBAyP82RmhSFntmQA?=
 =?us-ascii?Q?X5J7VKuuhcMYCNnCDHlKvjOBLxvlWjubHS6CoT3l3o/tm1wH950KabBi6xT/?=
 =?us-ascii?Q?T50vON+aUWkUiq2qNEcmipcfXhr2JWw+w3yWE0DbMxwgmwowJCS80zJfcALo?=
 =?us-ascii?Q?QKxgHt/QY2PkcbBdnMJFv61OZ+VFzXiSTtmDvpioCaJdjWuZOZgODtovsrGn?=
 =?us-ascii?Q?3N82Yyy9mEhgDS0iQMtce/R4jYJQKRlzqyrLUOp4IreTwK2XRQ4PVnrOuHip?=
 =?us-ascii?Q?A6WhrT+3axAp7y4BdDqICnlHkrZl7guqFQPQLwqFOv/vuF5cXCx7PBbNM9NX?=
 =?us-ascii?Q?jTgGjjYuGry4bfg6u30FDy+yFu0Hc19ofP6CGCjCfaXyfBugMdrvGKBATKKl?=
 =?us-ascii?Q?dZV9DLcdVRpzYtJF08CVGW2Fn54vMw4ad0s7AtqryNnO9SOiCGibmJcjb9mc?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZKmF4QUbVkNcO+c0uPkAJoG70rRy6CP79+qpxMjQNwLWjaxlMrFt5SUwHtcqKDAkuo8IG8+04y8NUrSVGCRBj7SkYKCl4UuJup6/XkqT2ZhKAhyZHqGWBzUv7eq8GBgoGmHhsnVBA4v0KRDfHxrn3T7s/mKSrnYVJ1uIT+P5ftQsHusY+dYbYZY9V2VCQS3q4cIvOsO06oKVRy/8Ys2pEDo1ViJhiXqworrEHKVJ4uN3m0oYBW0hIWngF6Ag3JjCumDoFC2FJBpODaYcZr0jneWGuaBrfBe4DG6POaHIY5Cppa4ZHmhn6LtGYIm3NexUt0Q/u8UcuflyMEX7wMT8jR+dMD8nK7P0h54qxpPvhHMSs7SvjpXk9igUaAggVQ/kW89cm8ftqjyvEEL0JCAg9PPgyXaQRZc67hoDMyAmC85N8uNTknzdT071d/BMZ20TY7FuICamjSjYeBjXp6UMFKxAFzKT7KZU9PZg6BT1OlS7Cw8nRixY9cJB/QZcpAqIwblUnywd9JZpMM8ipQNNbdwCpKcbKcQCFvRryrUc4+PdQVsRD0RxBsdkaUC2P5MSniW3U8h/VQi2Pq8bb89zUF+e5WULS0IGtaw3rKvtOAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49b422c-b02c-4134-67aa-08dd66db75de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 11:44:51.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtorBsqfq3uz6cCzZ6Dbc5Pidy+423PXaE3X4micbp2fdHFw5Q5Eo8epJ5hIXnbWJmVP6S+TsohTBfnP5p7PKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190081
X-Proofpoint-ORIG-GUID: JlqlPzLZ9EGhckPW-C7yMD1p-p4h77N1
X-Proofpoint-GUID: JlqlPzLZ9EGhckPW-C7yMD1p-p4h77N1

XFS supports atomic writes - or untorn writes - based on different methods:
- HW offload in the disk
- Software emulation

The value reported in stx_atomic_write_unit_max will be the max of the
software emulation method.

The max atomic write unit size of the software emulated atomic writes will
generally be much larger than the HW offload. However, software emulated
atomic writes will also be typically much slower.

The filesystem will transparently support both methods, specifically
HW offload is the preferred method when possible, e.g. if write size is
small enough then HW offload will be used.

Advertise this HW offload limit to the user in a new statx member,
stx_atomic_write_unit_max_opt.

We want STATX_WRITE_ATOMIC to get this new member in addition to the
already-existing members, so mention that a value of 0 means that
stx_atomic_write_unit_max holds this limit.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I'm sending as an RFC as I am not sure if we need bother with this.

Maybe it's better to update the man page to mention that software
emulated atomic writes are available, and the user should check the
mounted bdev atomic write limits instead to know this opt limit.
diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 0abac75c1..c3872f05d 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -79,6 +79,9 @@ struct statx {
 \&
     /* File offset alignment for direct I/O reads */
     __u32   stx_dio_read_offset_align;
+\&
+    /* Direct I/O atomic write opt max limit */
+    __u32 stx_atomic_write_unit_max_opt;
 };
 .EE
 .in
@@ -271,7 +274,8 @@ STATX_SUBVOL	Want stx_subvol
 	(since Linux 6.10; support varies by filesystem)
 STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
 	stx_atomic_write_unit_max,
-	and stx_atomic_write_segments_max.
+	stx_atomic_write_segments_max,
+	and stx_atomic_write_unit_max_opt.
 	(since Linux 6.11; support varies by filesystem)
 STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
 	(since Linux 6.14; support varies by filesystem)
@@ -519,6 +523,15 @@ is supported on block devices since Linux 6.11.
 The support on regular files varies by filesystem;
 it is supported by xfs and ext4 since Linux 6.13.
 .TP
+.I stx_atomic_write_unit_max_opt
+The maximum size (in bytes) which is optimised for fast
+untorn writes.
+This value must not exceed the value in
+.I stx_atomic_write_unit_max.
+A value of 0 indicates that
+.I stx_atomic_write_unit_max
+is the optimised limit.
+.TP
 .I stx_atomic_write_segments_max
 The maximum number of elements in an array of vectors
 for a write with torn-write protection enabled.
-- 
2.31.1


