Return-Path: <linux-fsdevel+bounces-46925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E90A96958
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D47717AD94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302427E1B9;
	Tue, 22 Apr 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oS9BHbyJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QvnoDn01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D027CCF3;
	Tue, 22 Apr 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324921; cv=fail; b=AtA03SMhhqJvetMsMB5NFyK3bEGdMEJjj7582tFD7R7226FwQjnIxiAmJcjaa8SxMdpQlNgc0gnLo0M32jjVQXEF2FiiTqhOIKILfF9pAT2pkbXbLP6fcMt2fN5gk+B8uzF+LNLAghZnpsgtNZUKYGU6V3NTsUoBXImT/aCUYU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324921; c=relaxed/simple;
	bh=HXoCifz0GuY1M5rkJrFyR/P7ou7T3D5tc2ERXQsB8mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3eQeOh1MfsA1yjlF8H3+4hUP8unk3YFrruNNRQsDXSkuJr0kGRgtEUpVOTTqIitQv2UN8PZ8VeRdnsd9mrU0O3PW6ZC00udTwCaF0WRDurnP1lk2/kwEHBOvydby0Oi0x5FuXuAu2CJqTS+2o/Ita5DmYx8Gx51L8gZ7t2nuDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oS9BHbyJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QvnoDn01; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3B48008309;
	Tue, 22 Apr 2025 12:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PfjAwbhZVoZaFEImTYzZAQtIzj7lCu5hv9mKI611ZXo=; b=
	oS9BHbyJEiLcreADBxXFLbE3zZ5BAEx/R71SSQxec7n1n7+g0wyZxX23UXk1jS34
	FR+frjgfrts2fc0dHuRSy9kZQ3wb1qREfrXNqKJb9YKiyDfJ8OdXDsj78gV8xW6P
	948gVyDY2t8G01ZRF6JoKrkOab7bjIda0P2Wi8JifF6EC76oQDRVZs60pNd2rl0R
	D7w2eAlUJ5Mmew+xzpsEWDnPl9T78+dj/ejuYBArn1VaL484vguwfPOwwd5vLZJz
	XPnKGtzrZxUK1fhBV/gc4V3IJxhZM122IDDprBxJXlxaIv+QHnaivwQWKqmt8wiS
	tlChzclXc0MDb2K0BhBW6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBkiqF033431;
	Tue, 22 Apr 2025 12:28:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010004.outbound.protection.outlook.com [40.93.10.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rm3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hb8rMnRrGW5cS22OR/hLVQVNlylrNe4TfEFiAqnHgrhvYC65gqiLAliiXmYYFeSGnh6SBFBhF/qVzO2bYGc8gtUMpTXsp5D708AinX/C5/sp+xm4vdldWnc3FGgIQhokY4gCIvdlYgT+1p2osNKYJ8la4W6NsGF35ATxY+meGVEXZVkYh1pILh2zUcFeo5+R1N1WwZptWzJeo/2C8EEvkZ2anVVhEc9tHV6UKHtY+7paBNk5llJXErHc5eauRFoHBygfkFDjEX0YumJ5K9mWX+ioFemnBfNkGa3Vf4bUtVR0m+UIgxabONuZGyjWsUNbmEIcnZO/raQ1ZFithrLQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfjAwbhZVoZaFEImTYzZAQtIzj7lCu5hv9mKI611ZXo=;
 b=Fw8ecvLx0clQjnfqf4elyhaS0Z16kEKY1qvrVHUBMckqGZ2yrQIDkwcRJSJoCXYrJjytk7wTW5ovHojcE1+xaVrnXpgeR7ecFZ5p0VnO1wyDE0rr4DQCX/SHiQ5sarReBb/7PBqogmSI15aV6HHLTdXAmfkqWGL1ce6eyK+JTlUwS4BvpFHta7+YDcPA+12Gi/et6rVWTLD1KjI9/4GRMu3+bdcZDsZdqfGLmdp2rSqoOgsxP+LKueVtZzKfMmmxfPWwqjTg9KvM0nJWpGfxHT5/D6AjodBCbpup8G5y5/o4ImF1XD3BkBMr8t26BW5rZA77PwF4ipqb3Zp1KA8BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfjAwbhZVoZaFEImTYzZAQtIzj7lCu5hv9mKI611ZXo=;
 b=QvnoDn01YhOSWPxLiZraWmvibugQ7kLfSdb5/p0wcQYRsbnI/C+G2f1LeWuiuWcgL9pEHttTOlKxFTLSkWlJ3drRaWsSkWVnlQmIPKiGPRe7ngFnRzQDVTTUnTE3GDnf7/4XVvOEZUaCEw5H1+Zgnl0D+s/CqkM8rZ9WoNAxCJY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7394.namprd10.prod.outlook.com (2603:10b6:610:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 12:28:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 01/15] fs: add atomic write unit max opt to statx
Date: Tue, 22 Apr 2025 12:27:25 +0000
Message-Id: <20250422122739.2230121-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: b0df1649-b4d8-463c-2580-08dd81992c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZxswPA/54ipwL1SjyIDdB/4kJSkP/JNPiToY144YshHHY2dRh96ck8v/YMg?=
 =?us-ascii?Q?X6/o3wY05Nj+8m1vpi7AUgOQ3eUuzmAnF9GbC2k6ZqQMmitCAH7maoyExHz7?=
 =?us-ascii?Q?tS2weizPpGPT/BfwfWf3n//yl5iIFH+7qsTu2KNmquPcd8wwO0fN6ZZnZTCa?=
 =?us-ascii?Q?EcSjWTE8e5qBWouA0HgU6XVCeQx/s22AUn3z6z6EekI/DCTE+0JbfiKBqFXi?=
 =?us-ascii?Q?RRfWXGemHwl8RueNizCV3hkvuUMgFF752Vg3H/X6e5TAYX+M5OUbhW8YoSCO?=
 =?us-ascii?Q?UcsBMVFFu7COH4qhqwAlvogdRU3RrmXmT8/U7Rz02jNuBgibM0zNANPFwGgl?=
 =?us-ascii?Q?RjtCjgpW3IoAT4fNChBjtf94NLTTHqWg7RzUdtTypQ77GlY5bPRLRK5ryYEn?=
 =?us-ascii?Q?OVZ3Rmlk1SDIsRSUWoAmtjejlhbG3auTxTVqsB87J3Dx/9f9wyIhSwMvIXAu?=
 =?us-ascii?Q?pJ0h9UEB0UBfyeJRKdpVX1W9DFg9hGJwhAiAEvwNt/27cqwZyNbYgKQGNVJE?=
 =?us-ascii?Q?2mQgiOK2o++AmZYFLX6a3feoa8KY64yFOnKoDeiaFvj9ipknBXPmBPyNZReX?=
 =?us-ascii?Q?8i9CRzd0MvKK8Koo10uXVrMrHGC7+5qSsPahyMYJ9e/UFQjVEm84dJQfCixS?=
 =?us-ascii?Q?+Uy/BN+dtsWM4+XbENCUp/blNWfTv6G1TxvOPYo+683WcExHWyHD00cnuZ81?=
 =?us-ascii?Q?uh2um/aTEOBRObitnMu5E29rjPd1Up/Cpxbe4thGWLbFIjorNdKuoORx3gAn?=
 =?us-ascii?Q?9E9ZaOfK8jXUgYGY33stxIzjWchNYyvN/IGazxYw4rpkxp3ZcIHEhjsAHHvv?=
 =?us-ascii?Q?HqsCOi0DyIteLmtedZNtSlNIXAZc8TLr+KoyzwdKIeZMJ/HrgMaHZn52DU97?=
 =?us-ascii?Q?C9v+FvgNpYubkPVizUD0ZhCwi39y+4Xf/Awjo3owyuyirilxo3Ge0TSWMfHu?=
 =?us-ascii?Q?PxKzn9y27F20M0ocJOeXowENxoZioV9idmcdoku60Lz+sgQX8tRbyZx83uXm?=
 =?us-ascii?Q?xUpr4Zcjh5KrbZrkVgxiuwEkHU/TQ+R2VKRLBil2rWMzx1ni41+Z8ERIrkxI?=
 =?us-ascii?Q?QN1g23fq/shDGfGED064VLdh75Idg4OnJyJJtEibgJKplSA4qnmAAsk0gEpB?=
 =?us-ascii?Q?LZEgFMsycQSX5xeeJY2HXt2RzoEcJO5UFCtztvTZKmwZJn4ia5ZzVe9bAZaG?=
 =?us-ascii?Q?9S/HxxeAH0QI2VJiNbC7UYgLB3ASWSBnu/n3leazLVYD5GIYxTjpUlT7JQNR?=
 =?us-ascii?Q?xz/Qfg5T7Z4byHooCp7lgFGOr+XsL8zqNA04bCa80zfrtLK9vtVKmYP9WZV2?=
 =?us-ascii?Q?HFdfM2q6eH4+AOKDq//SBujvY7kvgXbwPIZDw+0D/wbDGmk2ZN4h67sjXypz?=
 =?us-ascii?Q?rXY+FKpjPyU5Gf7JASH+UEcyfULC9vzRxqoryqCUN0zv5kWqKMNWJUoPMYP3?=
 =?us-ascii?Q?CRJCG/TN77I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkoJlzGU7PGp46+w5yfoWdpI9GLzdEkeiLaap+3qHqc9NDReVDxGVRAzbAzU?=
 =?us-ascii?Q?2yLZyw9GvyNC2qo5d5fP4qzJ4F0MRn7+Wi7nX3Jzu+uVANpvlINlhrQFil5z?=
 =?us-ascii?Q?fxST3l4ZaNczGDEiLS+2Uhiv74tXX1JRdyqNGIRU4tSm1fKAW2pScyiPKgIY?=
 =?us-ascii?Q?bufyjpqoWQteU9jbMXVM3IvKZOhLRfttF1Cz0b9Sjt+Cnr2zEtgtXVX35TaM?=
 =?us-ascii?Q?Fav4Z4icwIC+uO52tgbr25U90ujsSsWGbxTg6TU4dg9sxVOy0WwCjhwk2vHp?=
 =?us-ascii?Q?F0TNAVzebWJL7qiSQv6w1YWSYxTjZzKWTwJ4ofkb+YzYyXiNMFtGrdRzXPxo?=
 =?us-ascii?Q?IOj6Ecy/McMe5k/UR0uXNz2pNqCHFOrXwyqsrPhIsIRKK7LHr5Pe38wA8rXv?=
 =?us-ascii?Q?8+QrjGj5tHUJROJlrSIZojKAsrPkqqIdotH+5rHFWK3ZuJDiHAEMDLrIwLzG?=
 =?us-ascii?Q?YGEeMt65Xjh0lICogmCWksZL45/cLpwEiXIAxlnrFidp/OfJ7oU7SQXq8c+Q?=
 =?us-ascii?Q?W/E+j31AoE/0sJIcO+8qtMDJ/LaUJd7dhYw/fCaWClm0W+HfODgenRIHLMhT?=
 =?us-ascii?Q?KNJLLbpXAcx4YFL38P+ghoJ4cJOiIAlb/U8gagD/KObSWdL7Je6b7csEIkg/?=
 =?us-ascii?Q?kUiSrRDiXt1iScTmBTARe00Mk7Aj2gwIiGYjJbutkE6bqdl5W4xTp0+SQzsi?=
 =?us-ascii?Q?gmuOkan2kuGUlwNLra02XZkvA4hwVOdPkn02DFRhbA/pNlTohs9Bmrz/FGik?=
 =?us-ascii?Q?NxjQwmOX9GgY6p7qlRt6Kvbaz5hy/WPiq7b4SwjDmIJhtywxcX3vCksuuLJB?=
 =?us-ascii?Q?BKhVYcdAHJ/NX1cWTN57XdmSs2CqyN8OKDWe3WH06CYnc/qbvdUO3qa3/hjQ?=
 =?us-ascii?Q?anpAxf6niOCtqNc9BnniNXa5cYxQr+sYPQEMXfVrAEjEzZDVlkMt+b6+8zWW?=
 =?us-ascii?Q?tHWAPaqWeH5k0TjtciPfayz9p07xWWV2kVOrs9DEkXZEkCkbLtJykwUVdIcz?=
 =?us-ascii?Q?Vx9/JyPe/YL+e/eJg4iEA4PU3zjthjBgBYTSiwN6wAeKrhfZNQStL3H/ECfI?=
 =?us-ascii?Q?dhFEKa4Q0ax+nxHN/ngbu/KWDEgXhuBBTFPv1sqMskyBr0rep46jEKOQhcZr?=
 =?us-ascii?Q?gHlpAXS/4pG7SQ54W4ozWhpYuokzcQ5XaIgflmUhtQSIM26ZGajoyKbuAzv/?=
 =?us-ascii?Q?8MnESvDZzinU5bJd0pU3ZJfL+Umo+uqCA0FtBLK+SW4FCbHSDK602ETXuoOi?=
 =?us-ascii?Q?qYHk1HmeelSntKJA/fqJA4l9qt5hQsKOxyaApDsqJXt2T8OeEMLGKir1Axmm?=
 =?us-ascii?Q?yP1yRD7hLRLyzTNN7Ktkp3hhfQc2eJbpgwRbIVaxbnTJ7uXQ5ikcP5UBEcah?=
 =?us-ascii?Q?ilJF3PlyVIxML8GTvd2SQOj9tgY5ZRUzhfUerFTqpzIVCAc6davSmnGGQnTj?=
 =?us-ascii?Q?ifLDLjoDeS1HHhAbrKEq0cJvCq2gr2QvcEYKHcI94VonpgRhgf0u9M/tctmC?=
 =?us-ascii?Q?QvtVcwHixnnyEBE5OPB7Fue5WIwTxmtH5Y4CiNg7DHJmAtFINgzVd9OCpf2E?=
 =?us-ascii?Q?bJbhxqTco8ueA+1pGE0MQuUzIIQUfO3+8tqA48IUcZ4dTBplaCzkPf1qf+2b?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/9KLuKyPGK/bDAxHQylFXI5bL8PcJ7fQdAiqJ1iDnKg6lGdiOIfKKUi82QLt4o9Skpzznv6CnNCwTm4G7QMCG/6Xl0/29Yr24UHIEiT91iDuK7zZuVPLjHXsOCUXgvoQHP49he3SCs0vBVo9tM8/n755v1EY47+bWCW1IXjjk5J3/BvCtip6jCDy29dKGCNwF1x5vuQ/Vxd0DyESTyJsf6rEyIomoTpsXf5buD8QROL1J/0nHFOG+rgRo2PaZxg0USjc1t21AohfErxrqK+z4RC5HBkmxMlxFLa7PFQOq2Z/3xY4BlR7UuVqhN30Eqbl6KpunrKoeySQUErglRTzLxxHWWqqRlJIhQQfE/TpODctz0UopQWS3hXIG8JHWTnuE1hY/aLLJffpjhbBIYpztN1lEIB26zjGFLuNxO3bsDpYaMPsmwmyypl4ymhzpdWkY81slFx61rE+ifX4wr7YrvhpiE+04Byh0CUOBP+DI0EKHPjXJyQpbYmBhWeG83e1MctWWIQ9vw3dM6qNJsUWOYGO3vf0FQ8NHk9shKYf5e8IM38c9CIpn+G9VYLxFbozfN8a4bOjJRhoJD84fHLOUemTxcnuT8ClEk3xEaF98dg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0df1649-b4d8-463c-2580-08dd81992c4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:23.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbvPl6XbyDFsaI9kE8n0hps9Y5Q+x2jLZXZYfC9ySChwxoWoMrmBceEsPCbgat1DS1iX1V9HiFjNXd8jUkaJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: 3jh5vX6HzrKs6JeiGjNyYl_TutA_KGSD
X-Proofpoint-ORIG-GUID: 3jh5vX6HzrKs6JeiGjNyYl_TutA_KGSD

XFS will be able to support large atomic writes (atomic write > 1x block)
in future. This will be achieved by using different operating methods,
depending on the size of the write.

Specifically a new method of operation based in FS atomic extent remapping
will be supported in addition to the current HW offload-based method.

The FS method will generally be appreciably slower performing than the
HW-offload method. However the FS method will be typically able to
contribute to achieving a larger atomic write unit max limit.

XFS will support a hybrid mode, where HW offload method will be used when
possible, i.e. HW offload is used when the length of the write is
supported, and for other times FS-based atomic writes will be used.

As such, there is an atomic write length at which the user may experience
appreciably slower performance.

Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.

When zero, it means that there is no such performance boundary.

Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
ok for older kernels which don't support this new field, as they would
report 0 in this field (from zeroing in cp_statx()) already. Furthermore
those older kernels don't support large atomic writes - apart from block
fops, but there would be consistent performance there for atomic writes
in range [unit min, unit max].

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 block/bdev.c              | 3 ++-
 fs/ext4/inode.c           | 2 +-
 fs/stat.c                 | 6 +++++-
 fs/xfs/xfs_iops.c         | 2 +-
 include/linux/fs.h        | 3 ++-
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 8 ++++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..b4afc1763e8e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1301,7 +1301,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			0);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..cdf01e60fa6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
 	}
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..c41855f62d22 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
  * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
 	stat->result_mask |= STATX_WRITE_ATOMIC;
@@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
 		stat->atomic_write_unit_max = unit_max;
+		stat->atomic_write_unit_max_opt = unit_max_opt;
 		/* Initially only allow 1x segment */
 		stat->atomic_write_segments_max = 1;
 
@@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 756bd3ca8e00..f0e5d83195df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -610,7 +610,7 @@ xfs_report_atomic_write(
 
 	if (xfs_inode_can_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7b19d8f99aff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index be7496a6a0dd..e3d00e7bb26d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		dio_read_offset_align;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
 };
 
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..1686861aae20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -182,8 +182,12 @@ struct statx {
 	/* File offset alignment for direct I/O reads */
 	__u32	stx_dio_read_offset_align;
 
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
-- 
2.31.1


