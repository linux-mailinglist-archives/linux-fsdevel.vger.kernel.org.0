Return-Path: <linux-fsdevel+bounces-45962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B31A7FCBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BC316F902
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE24269838;
	Tue,  8 Apr 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oUUjTFpc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j2YyDT1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174926980C;
	Tue,  8 Apr 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109107; cv=fail; b=OP7cc1Gg+gbpL0sXhnQDWDh81VVTpjTrWIzhvxreJwimxYSxO4jIk6sh1Wp4cBjgjhleKmyYV+GZ83Qro+xPqQYkpSyrn4IRKQXcfduJQPP2CoCa5SvibaXcLwRLjDnwknk/Azf3ZCYo0GG652uZ61ZEF40mxe/IgxycpT80Llw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109107; c=relaxed/simple;
	bh=OxQNq6QEGCEq+/HwIJELBoLmLVhKQyZgrkasPLbfpgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNyXLYZ9SgBFBWWc3aFOKkM97B+tngERfZVlBTCw/Fyc6HfV+r4cm7daHxAldW2wJZJl9IbRBdm7xGw77xBULXLQNGufJ+LClY4JWcVlb6UJKTs7B5aGU3lSvLvbBunwTroyMIBIGlwRQsrsUl4KU55360XNa7n/3XYFcChw2fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oUUjTFpc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j2YyDT1N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u4gq029500;
	Tue, 8 Apr 2025 10:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7fYyOlvylyOU0DXb15UFUCNloOEWOG2/wSGF8TCYNmM=; b=
	oUUjTFpcFv22NUVdBKAMCbkvxqzDen27bd4Sdsss3240yfg2BLgvTlfKGOX69DdZ
	b+oFX4rbxZg3O32i9FqP5tG2pTHHPI0er34ODgFBID5Q7ExGWJJUR9UclpGeV9g6
	1N+2bT97By7Faay/zocbLLqYxSTbi5yB3zsnt3L0IyP4hV4DCy/Ne3D2Dge5SZZG
	WulkatQB4nsuiTkbboPxyLxsmLQ75hJvwAT8FfOm+IfIzXOfD41xzVbUYJ9hOVAE
	oH/bTsP1db3yq3PSC4T1Eb6HVld/rQGFii2Wv4izDISiyNcCTuqWdV7WabyKSfCv
	jUN548FSBvJp+XjSQjlcqg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41cgqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5389F4px022201;
	Tue, 8 Apr 2025 10:42:52 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9twg1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0W5p3yDPazn5Pf5zx6x9y4461+6kn6SbkrkQdwmweh6t319eRzqESyIOLcjAEn1QtSKBG5XDrUZH9hFp7yfHZoSER3GwkCbgcIBsB6s4cV7YlytHBhRptF9XvuCGtxG37OLruPs2dddxGyj78H3m3ljUce8bSwNfGqd29lJzq28/Qf+k53Q4JPAnm+ZlR3mJV78UdZFN57bHiVQ2SC3pRzdiNAtJA6mmdnFO+tYgyWqiyO48B318KrUBThfLImDFUfUqvVbB0YDp6El1WAXJOgRCmhIQ5/EDT68aDeDztPmwPkIsEjZiJ68oMDMipFk22RUddQ0GnH0v4xUoZpzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fYyOlvylyOU0DXb15UFUCNloOEWOG2/wSGF8TCYNmM=;
 b=uaXMENwWoNHmLGl1e4O2V5Z2dlYU8QjACIiaHWK6b7LdQ3Etdjvz1Scn4cmCREfyi6V+U39UjbhKbOazO31hez/g4M8wrk2gUlhhEimdswRhsGNMBhlpi75Sv+KFS0+kc8IQCvBAWemviDtLYWS2yqmgGueE02s1ZyhGVZJSvXMNGca7G4YMb562nTNC6dk2gHxDMTdX8zNqAYoXpcT1iPmlYoZ/C4MC7EFftlLlZOJ5NSK/Ca4Rnvwa70rbLRvG4g0ExjZq5IxVIdVGs457DIZEE/IeQD6DAw/pcgO3xrxL++CcA8WdyJT3OmGF+imOkHz4CLAwuGYUDQ5LY7jpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fYyOlvylyOU0DXb15UFUCNloOEWOG2/wSGF8TCYNmM=;
 b=j2YyDT1NO26SyJh8Y9Y0cPRG5OewmOLemiWoKTT/kCg+v+TCVMXQJGA+0823XJzGHBntmxiBZQVBmFJ42A2WVk49G4yCLFTCm1HtDO8tijETT3EbZvuIEObRP0q51xWjRxmdvZAvyuVJvi1F0KzUs+rFsvc0viMLMxI/En5Utq8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:50 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 09/12] xfs: commit CoW-based atomic writes atomically
Date: Tue,  8 Apr 2025 10:42:06 +0000
Message-Id: <20250408104209.1852036-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b89fa20-7687-49ce-aaad-08dd768a1bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q3TkXI89a0NAGs1p/Hn7LcyA3YvmHMLE+ALPp2Atlh1mQes11WMhRBpWDIgU?=
 =?us-ascii?Q?ivVB0kYp+BJg/Ki4HA37QeJcDJ7blQLRWHlfS4Jj2JR/FsalL4Rc5Czbnn4t?=
 =?us-ascii?Q?wlAbajiMUxK3CrRD/wSiOcmW5ateInOpRMfobOyAzbn1BLcsgPoDStjpziV1?=
 =?us-ascii?Q?PVYPsMg1ReNAHRxjgu2AHyENYkwrplUvo9IusQSirKsv7KJpuHlf5557yvSa?=
 =?us-ascii?Q?ngVkfoWjlAbaJByxO9mq18oqaF7PREs7L7l/cTyME6ItowaRJEMPO7n4IAfQ?=
 =?us-ascii?Q?nRvJlM9Ij3IHNrTWOlQfFkmt3HDL56JCZwjqTIl9t66Wc6md0FTBxVLqxp6A?=
 =?us-ascii?Q?j1FhHng10j9u5XSXurkvM/+RzIJ+ZDviiSuwg0eKKv6Jw/VfAxf3dqf7iq0H?=
 =?us-ascii?Q?TqgrGucFKDgjRqaUHxk8C3xnyHoO8+FKRblQlhbO8KD9mvAfMFIjYm80tbCk?=
 =?us-ascii?Q?1ISVhnvWiP3M3H4tm7cillNH0ty/w9s4TlWcW6fh9rRF2OJZlPnYBP2p6mCf?=
 =?us-ascii?Q?qYIK6a3mHh2NM+e8eFU5S2jtuFEXeWkewRwF4aCaIGLGFae57OpLCKRzApPQ?=
 =?us-ascii?Q?NMslSi53eHSsmMq3Mu2wxOWqPrkNKhzuDMtAHBtmaL1LzGsx+AT3Lz/wOFQy?=
 =?us-ascii?Q?SIf5hUQv6n+AB5fQpehFXq7SvsGg8wReIOOCLjjYD0UhNEuDLQDLLCZ8AbOg?=
 =?us-ascii?Q?dfBSo0WcVlDTUMsEb9WejzSG56JG5ilVMVbZIVb73zUwD/4idBQsfJ2uaEvo?=
 =?us-ascii?Q?7yTcpL/tk8kd0jhMjnoRec3+8iUrJ6Su5KYFxDu9p0pdBoOOIWTxdeRLU4Dk?=
 =?us-ascii?Q?KHlTxRYCEXStXdMNSszrmCwkNJa1TNvUCwC6p/OAnAUJQ8epfsmbAnEEjPzw?=
 =?us-ascii?Q?KkK1PQErLhIAYvGSEL6wclH3SNoPgbEmxyHjjIyoZMYLaI7QIzodbhsj9KKW?=
 =?us-ascii?Q?r9b+GKLsGXf+1M+tjsFk4djFUeTjoApzuAdnX68h1J0NXfjx8cr2hls2bGp1?=
 =?us-ascii?Q?PYD7qv05XfWx++wFqH07DivN5hj6I6klA6KQ2MNIFQ7uDyRAt+zeJ4yCI0XP?=
 =?us-ascii?Q?fot6aw8xr1cDGUMXjWIB9O31S4PFBxN3YFqNsVRlzblgiul6TOrCZHzxVo7k?=
 =?us-ascii?Q?eHK5B8p+QqT1PhJNeOsJVvb5edoKEDWrF/WPWXrxu9+uOD1aqI6M5wVRwvcc?=
 =?us-ascii?Q?UH0oHn3y7woCLOER1m9f+vwQFpP292BJZkDMXN6XQm3GvjXvs7429wYOhHN6?=
 =?us-ascii?Q?rS2daSIlKkcuzilB0hy/ZGuk8MUJTC1MFkPsErgoBl593Dd7XUFaae7FczIE?=
 =?us-ascii?Q?vSELJdbzYphyYOr/f/oUQLGszESeTNFfaM2hvVglrNlzExO87u14XxB+Qtk0?=
 =?us-ascii?Q?ZUUqYMeTKB3aU8Cw55pTY5rhsXkR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2SoEALCfpW9RvCUWMeFWguizobc7pVZykykbKqNqJer5aSo0qZt3nnGsX2HU?=
 =?us-ascii?Q?Dj9917Ub4BVWbm172WdxYgvEoIqT9uhx5D0glXbuExoTxo5z7Ib3g0vsuyuH?=
 =?us-ascii?Q?7GVJIrMW95JmoE13ZS6Rylcx8R8ttMoLMihze9sQyGbIPfyTmmMuVTQgE6/U?=
 =?us-ascii?Q?BZc0MuiLwwjmImcHPRFeAYoR8VoKr/9YHB9yEb0hb9g52zIFvQhi2pN7m5dX?=
 =?us-ascii?Q?wybmgoIMqn8uoBc991Yv2902F4l0SKNst8WneUQvwAHeeAw1gMedXJ23lKEQ?=
 =?us-ascii?Q?DiR/panc8cRmf+EYalblYXOu871qes0d8ybmphQA6F3rslLht/8eMYo81TzS?=
 =?us-ascii?Q?uCb/h7R0yDDivVukJtXvuW0PHZdxyjZ16TklCfZu6v8J+3WAARuR84ipRw1J?=
 =?us-ascii?Q?aLcgtBmemLfSzCa4jNloQn8nLkKO2sXt9l2zfyUbNyRS1GoW9XzTyrZes13M?=
 =?us-ascii?Q?whQsE/CPL26Qos5Vu0zSI9EUSmFv4+JAXJYJ50hHLVw4h9i7v8gUQBle5FP8?=
 =?us-ascii?Q?ZjrZPgzdopkHTonvyUwrVJXrp9YvVXCgdBysJRVeQnHU5eEEcsUJ+Svz/kar?=
 =?us-ascii?Q?AnFwjKG2m3XUV9M3j6jTq/zRwTE5cpp6X8Rs2HpEcSZDHJK1974YPkbReysN?=
 =?us-ascii?Q?/rkHNnBUZ4mkaqrhT8AukrPiO1LBhZCvxRh5mb1wbN/tAbnFP9c4a6fw0asZ?=
 =?us-ascii?Q?LFEO62YYvmJkON/U4q+WDKBMmCN7d6/caG1uEcUo5z8OjU7v9lTMvh8ak345?=
 =?us-ascii?Q?8K3EDMyw1N1MpVoMipk8i3TM3r9vh2T4IRHWC4K1AZPKq5F3tY8rifmAkVLG?=
 =?us-ascii?Q?GYIKRsDpY3UevOYwY+n+N/DtExvoa8orkClWjorDH2A5ZqXrjY7GWrelAy5O?=
 =?us-ascii?Q?2BSNp+yH1UK359sN2G3rqWVhdqmk0e8J3zqwYdup9VUbodDtLk3jXz/u9IYm?=
 =?us-ascii?Q?nvtjRQo7uP0D/HbDpBNTzeO4vvgbBHkwamEqDt96qTRkt+XX7nLl1E9RXgqm?=
 =?us-ascii?Q?N2zpOnRdjANTn49l2D+wn5M3gL1peSmSgec3QypeZIrnY//U7zPFDeIrWxYv?=
 =?us-ascii?Q?JulnAE+7+2wjTMNsKob1PH4lKrShPGj4XT8BfTHYoF/9X4wWyKPuWLL0dRM1?=
 =?us-ascii?Q?JqCYH760IQ0Whci2hs4umhyDJVQfSrc1UGZAHfdE0PUlITCHYyN8EZPJ1+gD?=
 =?us-ascii?Q?pRuHRlw+/L3k7vVC2ic1u+87VMi4jXfsxLgx32Ohl4fDDSwdgbPwV/ca8LVd?=
 =?us-ascii?Q?GHtj3MIDBNwJ5RZvkYRdr2wEIPxRItGxYOkVw4ch/YKt6SmqRxsTWBGLEdPk?=
 =?us-ascii?Q?6vP2kmLzr3As0KVkt7LYZK0SEM8eN7QZfm7su3FY+XZ5bIdzL5vk42Vcndma?=
 =?us-ascii?Q?b6kmUs/gLvozEGDkiWittDTW0AMSvfkRsF1uk6WGndw+BfQb8xQhC0ny4G1O?=
 =?us-ascii?Q?cAZ4ivf/0lk7bqd4wVBkIYsuqohXOF3gCqYPyT6y+UTuIUGokMVOKdpgzygh?=
 =?us-ascii?Q?AUKP97C4xvGQHzQU60SUejslIQ1cNRsZna6HQ9qItOkxuKny/xh1TvM2MMYc?=
 =?us-ascii?Q?BpC3Q5Qq90eN8Wk1JglRscHCVsG1Ipczp97S75vTdXLxpFbNFuo/Kc3Pq/5G?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9CiprKysHWkznA14vUsbJNui6twhSPtHp211GjXGethxSEHOrZ5gLBYe73Qr47jCMxE5Ep4Y0M/6AatlKicSHyLvp0kQWhWFN3fRsWxGpXHz1p1uD1k/BxbtwwDjZlIQCxRkfA26KWc4bAl9+t4ukHcktxhHDaqQE9x4D73wPUR4wFAAIUVG6nArMvusFhB/C7oO2oPIRZuvQUXkA1oFPK7iJTvflX9l07e4gYxeQ38rM5vzL94grUXgkxyZmHeI9Mit+bAmQrLb+A+Ccf7Y8xVMsFuH2HngkB4iFz6ZZ6vdOHZmuqwlQRmvUC+mxxQdGGIxBPxvJm4YgVhswYYfw6ToSKtjGcd5Wv38tuCHveol5DAKpODIHX8O8IlR5g/14u0eF0okwiZc/7hPFfR8h7kDdmXviJGWcpb8+WoynAhMZ8G+23iJ304rR61YMwLd+Ld716eSW+uFiQJKqjiSsSXeVkyB7jTu4M+Cb9Au9Jl7YAKbnTpvmlYccfGJ3CfoRPqzHL2+pt5fCafMX+7fF91L1BwL7AABWgv3MgY6l2ZHjFAoXuOI9hcKm52/Kd5lY7B+2vDlPbOYKPPCsDIjKtEctORbpfCqC6Y8ydf5IHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b89fa20-7687-49ce-aaad-08dd768a1bb3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:50.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRD08i6mJOPATLP7t8FP2AtSi24JdlQaDSCMpNV+N3BoHfUIYPpNf2XNfLn0HAH3QJLtlRPtbfv1JegIRvDobw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: 1P91RsN6HgElpGn1ssEza6B6uCnykTC5
X-Proofpoint-GUID: 1P91RsN6HgElpGn1ssEza6B6uCnykTC5

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 +++-
 fs/xfs/xfs_reflink.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  2 ++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1302783a7157..ba4b02abc6e4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5d338916098..01f1930fdde6 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -984,6 +984,62 @@ xfs_reflink_end_cow(
 	return error;
 }
 
+/*
+ * Fully remap all of the file's data fork at once, which is the critical part
+ * in achieving atomic behaviour.
+ * The regular CoW end path does not use function as to keep the block
+ * reservation per transaction as low as possible.
+ */
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 379619f24247..412e9b6f2082 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


