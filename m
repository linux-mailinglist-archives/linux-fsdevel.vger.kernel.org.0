Return-Path: <linux-fsdevel+bounces-46473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68F2A89D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ADC3BEFC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C2129B212;
	Tue, 15 Apr 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LDXhW3dL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K2ucWayF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F929B77A;
	Tue, 15 Apr 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719308; cv=fail; b=I+3tHJwAzz2LyUSalDqGsjFx/KATjop2sMwRi5JP9/VnTOqvXHqzS9vA2365HgvkwrxRTBAy0l0zq2Z8gOFWXJkJS4VXkEmF+egfsTR4urlnsRLdOi1F69FWtfVkCQqdnXAKGSUCiChmCB9+V89hCiSVjU1EgK/K9dRu8ZmTnxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719308; c=relaxed/simple;
	bh=UyMwuJ+lIB08dRfG/SSOantSxU/2xoypUKU+azLlxhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAUYmZlf20Q9X44l3XvwqUPaVThxwoh/wOBrBW3VC5FUhF2smJuDV1JYg5K0RincduZpct50NzQ6C1ezSbCpKJtrF4kIo2bSFu9QyUS56K/1yA75pF3Ojni7zEhUDhD7krNymaRXhGZBaOoFNjpI1x6utXLs9nyhsVn+33RSyvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LDXhW3dL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K2ucWayF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6frDv021703;
	Tue, 15 Apr 2025 12:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=16dIHWGqysP6D2Br2j5PueHAxkCdgXuedFYgBTCRSN0=; b=
	LDXhW3dLv1TNxFskZ+KRHvExRdVyVu3mkrc+RWmuq38kRFiBdFoPf3yrbhVcyaCe
	NYLebQxwU2mheOBOmSJxeRvfaLUK1nMlP2hax0FlBRXG3IAR6irxqRRdtPPkna7E
	gjwrcsXxraHyiIwSK54SuoBRsa2LBOBxJCK5s0w3rrKnumu302IUrtmSz47wQH2/
	PdCVaKxwooCsB5wCLsA587u46gbFaKURzYi6NgrxGErec246XRy8trrlqlHTKg8x
	iz2/xr5Bv5l4gQv8layqTpdphysHV4HXIeCYhX3uuG+VF3F1byqUhfx1e8GXWfxI
	YgVB7VkpYjnLqCiYWxBhzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf1q70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAu9hi038859;
	Tue, 15 Apr 2025 12:14:53 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4r76wk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aklXPnhw5ZMYxYLCNos0oiYvJJJU7EunD5Ghy//yC3cxt0lqHaGdq31segU3AL505zIUOTIGNpl42j4JkumC7Jx+FatSiZocaagCOyz4Ma7T7thTYwAdLpwLVVamG8/eYv+IuqV22qCExrnSJ61k2kcf2NYK5/dqtu5BHt34noadOdSN/vNT6HbuCl5Hzj8ORV32nL0ZNeDUolG9saWLDZwicmgOa2qBDf4Emq01UbhoWirqUs3NYeHXUuOc/N+ntr+HBttcv3giwhYCo7M8L5Y60h1/2y15GtX/uD1fP/vxCM8/g1m8EMCsiqJpGXiEGm7+wJpCOSA+OfrlXwhFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16dIHWGqysP6D2Br2j5PueHAxkCdgXuedFYgBTCRSN0=;
 b=C431Hvg3oYk1qvNw+Mp9yHSFSPjfwnIQnXmWNlx8PygZQ/RNowFt/KLoq3CXnXNBnXQ6Tr41S6S4LvY6C3jjER3ju4T+J7guBII/UoDKzOoS1bxLBlcgrbQPusZsAhZIiiONCisVj9X5xqjDjWl/4qFwmkcXzBNERPDlb1icmVBRy0k5NvzZ4l2LjHhWi8PaYmOILkgmwiDQSTby+aEByf0+CEJTYllddRGiShEqCAbFbvDRt1/2HV6z6nRQuc1rG4EWBtR00L5JbhLGTEjzDMdxWEOulSCzSln0DITnLQWe/ZNlKa9gO1gZbUorrZAkqszOWEKi9gwITaiwBiqS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16dIHWGqysP6D2Br2j5PueHAxkCdgXuedFYgBTCRSN0=;
 b=K2ucWayF+xnHMwG3Y7VKOdLdvV66wYj0pNtlFIONcXHkfu+/b/ppIY0pro5rzWPGELmAf/Awfe/q6uroSF0mn8b6e39nWf3SMQu9ELCjS7X/a7CIkrXM4D3JiQwrGKPP9R113wk5Fj2LjtQkY1GqP5OXMUBywt+yd+wDL+HGa2M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 09/14] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Tue, 15 Apr 2025 12:14:20 +0000
Message-Id: <20250415121425.4146847-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN7PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:20::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0f5880-6f86-4bd3-0f5d-08dd7c171fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oieoi2JxV2ui8Z1uRrcnBVGl5wfkQI8/Mu4XwfREJWljmIDawbZJqWmJ5nXW?=
 =?us-ascii?Q?ybGvIE1UFO8+1itXujUFy/izHQwuk095UoOdeBNb7/H3mfH2NWCB7xOpMf91?=
 =?us-ascii?Q?PFvLu7Y29YjAisav+mKTyl0cT3XLbaXA3OmY1ynxZo79QGtb57iZ/005MPMc?=
 =?us-ascii?Q?jlNDy7Wj3xL8WQ62i2OxvcrNUAWwNxu6KXzObnE31AmWcfCgU2Axqgr5viV5?=
 =?us-ascii?Q?zgtJViHRpcgrT+lFfrOP5P4BptNeD0PFZSpbrbAib1hx8xCf9Mjs+309jPHN?=
 =?us-ascii?Q?JUXFkKzH/Ge4X6M5+gbhzB8p7dYHvcTcb70TUWFopcKywJdvsx5iSWT9hTal?=
 =?us-ascii?Q?e+0d0xBJVsyA/tpfpeGc2HrXizs+3TFOhkJSTA2aI42M81GXZsCvO8YAyFZV?=
 =?us-ascii?Q?NAQoGEWIc2qSKOy2SGSXzY7goDmGjeAOs7t6tyXvooenD5jrcw64MFQHFO5N?=
 =?us-ascii?Q?yYNYsbgHTd/y1RsJq5pwAedxL1TksYEPQ+UqhsY4AGzN/jmRweZEyqZJTk4z?=
 =?us-ascii?Q?2T17DSpEvgHLC/sBlNvzjAT3ubVHKRWrdq/KHsKY/nBDwBjWZw5tMVSzH/UC?=
 =?us-ascii?Q?sz+/kbwIFBDaMXPAC4IrbjovN2z6/+37Xeivl3Am31fHdCVnKWGCN/nLkbKl?=
 =?us-ascii?Q?i48HLeIJEffCCKNJOGCk8r7nJQw4SCE5atIjH4R6H+8WzR/3uwH05uTdGpVV?=
 =?us-ascii?Q?EQa+4oFuvPUSPi7pqvMABplWe9bbLmjohk6ATMQQjHMKKIsTwxsdj9MkPy0z?=
 =?us-ascii?Q?VJC5mDuIRNKehDCFxzEZQnHEH88JuZ9hs8vaiJPsBIgMWnEVeJ1xoDAHPIk4?=
 =?us-ascii?Q?FCYNZ6JDsxeJGNqEESrYA+yCVGfnBszHA7ubqwyN3WKtwkYpBgVlHJragbSP?=
 =?us-ascii?Q?yPng8W7xCz8OBtXmLOFG1MMJH+zIgSnVLOgGO9HKQN2fVHXtZq3BIuaGs15j?=
 =?us-ascii?Q?xSKVr/cTs7H23n6YVRr9/X370qkVfQlECn/GX+UDuZVotxDy88ZoJQezNqoU?=
 =?us-ascii?Q?s33syr3UFKFhmJrzh98Xo7FxHM9+b2+7ryXZS13JE89cZlviUpz1eYiit+E3?=
 =?us-ascii?Q?XbMGcit5HYfiZ50Tqq5+WWVZ5mVcfY0JAKRAX0U0xAl1daKmPPgok7jRTwNN?=
 =?us-ascii?Q?DvXBv7VknaC4Xnbik9UW4ZYa6B78mJ44mGykbT2Z9pcFyKoX3l1EfhFaOyEC?=
 =?us-ascii?Q?TEwidHeR/86gwcX0X9CnuyUbp9uMqcCyPHJMKI6TCWSRght4hUISE7aQXyPs?=
 =?us-ascii?Q?m3a/iSsG61bQt6LYuAjFEzyCSq5V95/DKo9lTZWRe2epZ6odiolSrGxWgopD?=
 =?us-ascii?Q?PMRPbF1fGA5kKUazDNWeo+DbtSRN9T6ArqyrjusK+JunOhIoGG/WnlD6bzoI?=
 =?us-ascii?Q?X0PvyqtS8oMHfd5auqxnHv3Ln3MQ1qIeMqhSMTFasmCbHo8tZFirYyk5R2mL?=
 =?us-ascii?Q?C4pmzRM4LP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7CZR4s0ZAGrqdLhbgCmhj7tSpXFLmz6HV19a5zuoQDt3rPrvhizhwoMozmD0?=
 =?us-ascii?Q?br29YNekbdWjn10If/NnlyJ3dtXZSMMOHzma10OrH+r64feBu2CaCKt4e55M?=
 =?us-ascii?Q?XjWqIqRyGwELXB/2DLPlBj9cpEVzOwvcS1xAqS+AUM5SLXfy3YrA4V8jhozK?=
 =?us-ascii?Q?shn91cTZUJ50LJiSOFNviduw8eOoT4tMH1zStxO9dcrbzK8aOQ4l0+GFa0Yx?=
 =?us-ascii?Q?VMLAzsFzkI17xqBQRFhpyS2A7HZCP3V51GacVih9TAzD7JjmZbdcykG9epQy?=
 =?us-ascii?Q?ZM/9b2iYoiZLjfmPiuvdX2XO6zR335pX/SoHgvsA0U38RIILf5Ohooaejszr?=
 =?us-ascii?Q?/LTTCQmh2cR437YtJv9npXFNyMGdtNnvT7vmdMYXzwrUeRn2qCaePqTGSDhi?=
 =?us-ascii?Q?DUf1a7PgzR4nyAtw4h6dzuCmWjJHdi+T6qBs3LO4yrUvHTsCXHZxfJO/7Nbg?=
 =?us-ascii?Q?MKarBhQ/qcHRwqwfVYDDFY9OlYsuE5TclwD26RGMvaIYHjHI+0wG0Aii9XQE?=
 =?us-ascii?Q?Aj96/vZmSQYKgkbb2O4Kb6PQpwedncCT7WzpOHp6Uv4kuFhFLqhTYVNHlhcm?=
 =?us-ascii?Q?tP0jHStqpMHMvVFVGOG7IHGwY+yo4+x9o1YUEZMk2wk8Qv+p6oeVsrlq8hD2?=
 =?us-ascii?Q?5+bQsvFVx6n6lXtusK3BwrM5hzp12Z+5ZWUe+amQDPqigDNuMT3kZBynMeRi?=
 =?us-ascii?Q?Hwnvu9B6ZfE3WNFrIrhkNgaEVUYC+olesTXSTaPpnmICFwuHweaNIOVsyPxU?=
 =?us-ascii?Q?IeeZSQNmVyzeYYS4aMvONxGIgpxp5Gxx1uU3dSdcpXi0FRtGz8I5tQjuwuLM?=
 =?us-ascii?Q?uJSJMuKNst/xyTh1s9XH/gI7AF3bqVCx/I/Fom2zPXPRrgiOI1uZITsUBDXO?=
 =?us-ascii?Q?vCH0W4WGFfMJjFUtS/B0qzMwquslpBj9f1Y0P+mSo3an/KyqSWk+iDVKwLba?=
 =?us-ascii?Q?g0dx9qXh+fvujsm+pO3qfFHW3JwjijnecHGTy+y5H1oUGxFOMVkr+sunm9nx?=
 =?us-ascii?Q?Ra/yxyb/gvn149SeCzZ0VirjQn2crMY4yXVkFcaeqecLBK9dLLfH/z1ruTU7?=
 =?us-ascii?Q?KTxQEcfEQwbJbkCBy6+Tz4nIwX8tBESjgff7JK8bypzhqIFTqBQdEVGVVHZN?=
 =?us-ascii?Q?k3ziBTbWNwAKNxc+QnvAUpZQG4MiIL1BdoxNDpzTaKb0ER6sRD0UHoxghucM?=
 =?us-ascii?Q?336eUt+QM6rxaWTE9TzZC/ACjfbhF0VIpswrihGEEKABdPk8Xo17Mu/6FrpS?=
 =?us-ascii?Q?/Qzo52IWMVJxQejaUzWMQzvTMeuyJ4Ew1Rgh1WysXRsxEWebHYxhG3LWLqDf?=
 =?us-ascii?Q?ND/W0qNZtSczswHjCn8uaIELTe5fVmWWTnSuk3tJ65JtyCCjmcF6OoFvxCks?=
 =?us-ascii?Q?WwUrhDtfjS52bHihsU1Op1xJ7/7Gfjkb9iWlGWnKelFTjsn1X+NrvbpEj856?=
 =?us-ascii?Q?fpaiW3vPg5HrPGDuWofLDJnO/rM/yK53/ok7/ua7Pcoem3R2YJsb2RtbhRh1?=
 =?us-ascii?Q?VQYPyfp/iAqYKh6XRgpOTw9iC88d+suuyGtR1qc5OjiX2LxD67MiIEAYP/IQ?=
 =?us-ascii?Q?3aOoSYIy4fAWUpQRkkPo7LumAliYr0/z8fYIAujKBrDHpiKsCSu2OeXZjtKv?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0g0fzTeG2oIAF70V/V54uVxZEN1bWUeAza6PUDmefIOHwU/rMihVk4+rbHyOxKUviDFSFcPiJGIXr+VlEjKpgHCuB7BT6t/Z9oIW/umICFg4vwzuXBNJpHQPDl0ZxoeNL81BbXyabDRAwR35qTiWqA62naI8+IqnNc1Qcc3taNs6lpzC54VTNkSzbCkUCxWfel//3jrUFOE3sgBSuVU4REmgJvEzvvC9sgZHL9K9AA9ONr6w7ctAa90O094SvUzrnIUt7Itp8VMGbSswnRB9dwTI/D7I54KTfnrwld+/pKCBrj/xBJRmzXEKNdWG5Clx8b6smOjsmbXESVyyI+kFqkgAg9XOtqY8kWzXosyOka0/fC/fOmDYkpmvTyTEnVDSFdcC0h0Q4Es17CBS/gJZYlvweh2h/FOx1X1NwxEYZ5kvjVlpMVKmguzcWJVqHuu7XE3D7s0O+DPbdVHIMoNJYaHgBUmzQlW3SVkh8BvGXysu+kEiE/jLJLorXA69unlbShBICyYW/2Rt8j3Uma7II8hnhHqRMXLhV1GlxxYbFa7tgub8IvTz23HH+SEr35ir2Ch7Gt5PD3AtKsEG0XZCXp9fH0TBbARI3Ss4houj4vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0f5880-6f86-4bd3-0f5d-08dd7c171fe1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:51.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w03O2nBzW1tz6S0QtwNFDS7VyxLJ+/O/nM00t7vST2l2sKIs9xpw+W9doG9V+yi9e5FMJ+27QnG1ovVVVjYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-GUID: AGhLKuuAPuBk2babJhlvTTDW3BZAW3Lv
X-Proofpoint-ORIG-GUID: AGhLKuuAPuBk2babJhlvTTDW3BZAW3Lv

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 049655ebc3f7..02bb8257ea24 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,41 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	if (len > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +847,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +912,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


