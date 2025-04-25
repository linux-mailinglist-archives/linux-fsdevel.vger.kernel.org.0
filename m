Return-Path: <linux-fsdevel+bounces-47381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA95A9CE88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A483B41AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6591C5D6A;
	Fri, 25 Apr 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwlOdyUr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tl/T1VUN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA611AF0BC;
	Fri, 25 Apr 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599552; cv=fail; b=E7hLdTZiGLMiCUIwQbUbfC4yuI27OlIbs3xYwgMwEBO5BXpOfum24GIxyDa0nV52DBUH4XcSVF2bCm/MROSvvuvbEz0Bp4nMIPQ71cE8FlsJ5ATzOz5RfjYsH7jhOokroN/uyWPSUJpuQfkSKzCl2ob9YZzyX5MGtVaFrxEYQdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599552; c=relaxed/simple;
	bh=aBbCgTE+0p+dUqM5/IOXqx+WKdyzVIPaWCYBrY++5Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cck++TDU12ZO46OcRjovUG+w9h8BrL2i6LgVw0RqKBJym/8OCqcFfvlh5fpZIr+2YwMLh/9tF/DgNQfb3cn/WHY1hDs3+oRJ1V6qfv/4N6tWUH6REgqqdQIt7AhS/wUy4FiBqTLOZlMFddzi5SD084QWE6pGy1rGlhvC8UbE1s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mwlOdyUr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tl/T1VUN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PF6iQ3030340;
	Fri, 25 Apr 2025 16:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=; b=
	mwlOdyUrj4d7eCB4ILOFnViFFcJ4DPsxVv5fNKQU8Mn49orKj7SlGSkDrA7loLj7
	kFzH47UNgr8byAdYZjZCsTTAIvyLLUVUK7R5RhOIWo9UTHMoY01lxu8HvlYp20+n
	UfPbzylSpnG1FcAfthHdmuUpafcl5NYGn2mEdiyxlMSZddcYIIoZ1BAOlVcV3Ywe
	7ZXxtaGEndBWngznQcpYSthZr9MrRBVXZx7aYbReOv2wzmOnhtjTST6fbpdRhS5A
	K20lWiCDyJSMIaaZmVk2AUmwnuyKmtTzIFqeSV3uJ9G1YuIiPbD+zQ56tBBTFtc/
	zsqSPaBrHaL6hnCBZ0d9Hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468cr60ean-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFS2A1024858;
	Fri, 25 Apr 2025 16:45:37 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pud19s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4H55aKwGEzqKynBxx6b2rrLXV16cVEmoByRY25au+MGcmdfKG7r/o6Mx/88qYm47XGGQ7SY1AOsfjp2fQUeprEWS9PXnSmBd8x4UWmWVtquPTJPcE38J5NdzQ53qJFzpvrDYu4FjbpEg1wTNxjVpYWTIHtzwts/PdSD78bdyHh2V7E4haPUiGdjiZvpHqKX0NM9Ww7vKyxXbD4ZPtZoOwAD0K1iRdmTkzQx0ObqBkvf/SMdbb+PufECTSGlo9PFGEev+FSyKda2BhVqfRm2HJ4LqkM3l6rgsBmqHVtxi5rMvMIb33+p00geBcxn0PPJzipiVNMxmLeAE3DI+BA29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=;
 b=IylDApLepVcBOZcMGXVFmf3qMAMjFuzMk2u87OXZ2EEeiq03bxC4cS2SI+cdSF17LTB1KaIQyPGKusDuj9dVjEsKInDa3XAWf5fapihu5YEwogQ/jvWg3GzSA12oS0f9kjnd2HlO4aar8LiE0Nu1MaXGWair0Apj4dojTv5zQa5wKz7MHK2JQK1V+geg0Gy8msghYYk+RqkKQ6wF2knLHudG7NF40rGfxhn1M72D5g4wL24ZfWE8YAzIR/Mdy74v+HjBLiIEYZJ/giRaEsXIKEvHw8vaR9/Z3Gy1vGUTVLRpd3eZqKHAPqxPFHGuUHSshAt40jI/3SWPf35Kz+5ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=;
 b=tl/T1VUNNa/Mh8BG3QDF4Hs88B0sGuiTYjhZH+7IAu24+7cgREEQdjhy965MpzCnC+0BjP+KNkS3c0TP9RKyhd/OhHZ+E4dcWl0gPI8CvB8nTsdvakf6j62+TKG+RRnvmvjKU9b09aZCXt+kcGuKqQsEBzqBgEwYxIPG6p5B4mw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 03/15] xfs: add helpers to compute transaction reservation for finishing intent items
Date: Fri, 25 Apr 2025 16:44:52 +0000
Message-Id: <20250425164504.3263637-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c29d40-b6f6-4156-2ed2-08dd841899e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAhnXLWaLKbiEqkKAOGxlh5AuDhY2lf+8To13O1gNY6vjnOFlxCIdP/WSaGs?=
 =?us-ascii?Q?UW68Widzdd2d5hCQfZfW0+dSWf+eFhMg89fNw+MMLzdC2M89F1yD9Iy/vbHa?=
 =?us-ascii?Q?Y2XRTLQ5xfVGeRy2MjrM9VoEFDdx9oS/0Jtgn4Pbm0YeUrMcDeqG9QKR9r2E?=
 =?us-ascii?Q?yNqTGUNwMHoE8ZsgPCqVSHA7ccy21pAgbYcWw7KjIF5uSSgTGorNgGD9BVeu?=
 =?us-ascii?Q?RghWQ/tJBsmTk/SNkotCj7xZZcCSTH702m7S9Qlyz9IXhZGGTai595K2yTgL?=
 =?us-ascii?Q?BQcc8p9gaFGZTFBzjDA0WSOyfpWGFhotjHSnssUYBxxmsGRkMJ6qt1Ki5mtq?=
 =?us-ascii?Q?b2SiWVQuMGcvc2WkorC8fL7pOoKowEwl0pEwWzj61YctWCO5pysFrJGJI80s?=
 =?us-ascii?Q?9vaXrp7qIbNSl7GZXTSHXhPM79ymYQ+8MlG6WBZLI8/KL8DC3uZIuoa/o4ol?=
 =?us-ascii?Q?p3lDWh1g4eT5AB6gB29i4lFpru4E1PtwCaRVMgLYDf055wdE3AguUpmLWAY5?=
 =?us-ascii?Q?f4e88Z+PSzO0dNC9OwI5751Awuq0azt2wedqR0cQRnfUNxfPfzw8sS1Tmory?=
 =?us-ascii?Q?60cRK3JtlRp3YchJFXuNwUgaS3W40GmbLvqh8g+0XMBM4BmKcOTsNz6vcC4m?=
 =?us-ascii?Q?XUMl7m+x1svHvEu0vPqUK4V5wdGaHoKuF5nRUCKQGGuedHZcuBJurZOz21LQ?=
 =?us-ascii?Q?YQAn+cngIVtGjPg1KQcICBtsvXG8NJXWuFbmIO1G+tmomOklnZwwyi0bs03T?=
 =?us-ascii?Q?oCxt0bMcTyqD/uqHFjrP2ICocHPfIYcg2B/Zz76av9p2hhr7FOJiNkxqN03R?=
 =?us-ascii?Q?NQCXDfR8wDoy6XemqOXWbFZFReNONxh6Zusfg4BOy7vccnUeoQpzbG82UqQb?=
 =?us-ascii?Q?tAOmVERIjvge4agIXBQv7I/ZHCnJ/FGM5poax1SeSMEAyaHl5AWFChsaJmO2?=
 =?us-ascii?Q?DXfPe0RO00+zPZ5qg+kSMyCPb692v2G/crRtxTvajtrLWvH3XfpwvMTf79WD?=
 =?us-ascii?Q?xxhGggLedBHOWsp0nVypzOLz+sr4L2UPH2jyraTfSSysdNG9qywxNIv7+mPx?=
 =?us-ascii?Q?j1IQ2oVp+0tumBArNiyKTWEXcfeGmVMJUZC6t+xXxi75WsdLLOWpiA3RVw5C?=
 =?us-ascii?Q?05d+deAX5Ix7I9rh9Y9wxqAQ6jUsWG1kGr0RHgC7OtYC+rctdPQD3IcV262p?=
 =?us-ascii?Q?TKX+9wAx9lNlM+o/P7THLslZK9rm36j6sJmfvx97eas0x2TI2W6nX87usgnz?=
 =?us-ascii?Q?swdmmcYWRRD7q9S6sRzNWnNW2zhsZj4+Dw0lqgBV21EToHOKAkiHGW2DnIfU?=
 =?us-ascii?Q?0qrkO48CB/r7jTRFsu5WU8LyYfkginOMTCEgHkORRz1Rh/v9L0tqfCU7kfnY?=
 =?us-ascii?Q?PnBXqEcHGUPFrIial9baSJJIn6d3Zq3Hg4sLVvnygy2jr5XgCH8KUQG/6j6l?=
 =?us-ascii?Q?wq9mR9m1pys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDy7mJG1i4umqiYAXpOf+1thSjY1mPBn05QtiBV3BHVOaiC3u9xt/qPCCec8?=
 =?us-ascii?Q?wACakpNItHFsJJDkVCgg1BhitM6WcJx6aoWp6UOsmE/j/l6T9bAzCzGEup0w?=
 =?us-ascii?Q?By1JkZo+Gtn8inWo2FUr9asgnoAUriCXZmLdfj+MqMj+vgyqmpZkx3sijxEP?=
 =?us-ascii?Q?cgrtqtb2QoA6Hj3uya3VWWHemu8RJNMqhoHZvvQYZ5qtlKMrsb95JWoGVTsx?=
 =?us-ascii?Q?S7joY+2er/Pama+5x4kND7HYgZNQdipFtxCqvXMPDlJ9TPoJzo7hxMGbp6GS?=
 =?us-ascii?Q?oFFoM+nQkRQgLCTY5M97vy60eqNv66lDWXAnD35Ad9GRrUIrzPVA/b5xOgKv?=
 =?us-ascii?Q?arfn57Z+WnCq7fjRXoD9/9JUZkzTkLS//PKosiImNhk3EggtcNV0+uP8R+qM?=
 =?us-ascii?Q?xoyrLOCwu2ELyjBRC1ngsyfeAjphFeNe0I64uL3fB8dwpMNY+PkS3sptIYv8?=
 =?us-ascii?Q?OS+Ukp2Ua093qew/d/sCpSKUctSw5AHBZCrkM+UpiUgB8QpCBAWqUaI2dNC1?=
 =?us-ascii?Q?dF1Kp8NMe+y2K3Z98L6hKVzTqQDrTjf9Gj+f5B9IjWXgYc6NGHwJQPmL/2o0?=
 =?us-ascii?Q?tyRLN7J2EEfWEmIwzkrFCRWhssVy7FJZTX9vqJtVmFr1dBXtp+ZSNvxyavzu?=
 =?us-ascii?Q?mIoYFq7iA4LdnKhT8YhQYcY5HYE6tBwevtdOJNJ+OqLP3esRl1ne82kfhYXD?=
 =?us-ascii?Q?ARhzVTL3Xhr+StcDp/++151ILBzFvmbLfq12w/hknJ89/D/RTHwmnKiOJC7m?=
 =?us-ascii?Q?a02yxlVUnLB4w/I7OX35EU88pcbXIZSRI8xfM0HZXbHXgLPccm9eVHFfI+MW?=
 =?us-ascii?Q?7qfRyPwEiPZBHofwfoq0MsY6WkkkwpntfbT6CzFaJeFk/M/6QPFWHfbwMYVH?=
 =?us-ascii?Q?Hhooq8iiDlwXKpUeCssupNmmll9gk8M8xiRew27U9qsyJxGxX9SNiDUKDczq?=
 =?us-ascii?Q?BSYA0M07c+qV47v3t0ys2HdRBgvdRC7pgBmn/Pfi18wHuM4d0UkBfRbG/gp8?=
 =?us-ascii?Q?oA+w7fXZdTXHYusUk7QqyshGlJsaen7MEI6Wm+c9bo2l/1klWtKedPWnfNj8?=
 =?us-ascii?Q?pZkpmRs+iCT8VPkwCfoWufoCW75JrU6sJLXb1/4vkkbU4iIvAaNuNe1kEaHR?=
 =?us-ascii?Q?J3yl5pLGbmCsCesPUAd1Dbp9tJ4Vo9zefXzRPIta4jOYzPEDfwRitLXB1RRY?=
 =?us-ascii?Q?4bnqHHEN10dadq3O4rZa/03jYRaV3gPFjE3/O94+qlTKMbnHLYMXnY9a/x8d?=
 =?us-ascii?Q?Q5NlJl63TqfByyCQvI1eHtPYgyCgwIbGfJEUI/CeitnqIhZYKDGNg+Jin/Tx?=
 =?us-ascii?Q?qN7wtURCOAqc6uRCwa4zXWgse3HeHgAhA7gWHn0GV57fLEKzb9m8a366lkh3?=
 =?us-ascii?Q?YXvJ2jOMyDn5rR9caS3FSt3YjgIR8k84J2qTcbwM6pw067ufGdT2EhAJmme6?=
 =?us-ascii?Q?odNZHp2eKAgiDIxEg+Ih/dvJoT5ko3xBsTD7J5Sg1louuxE2rjNDgZGai0NH?=
 =?us-ascii?Q?03NU7c6KjaKJXh8CDxoFdpmh5rW4gs4W9+GsVFJHfbjl7JV7HahVljEoqxRq?=
 =?us-ascii?Q?jNhkv61rn1H4aQnVMQSZMeMI1f9m+lBo3XGHiNvog0Ucs6hodrIrY9Mf8B6k?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pYwbtcMBd8VnRNVK9f/1S4l+LAwRG/BBF1P/wspUUaVnXY9fhtWr1YBELIj55/JVxu1/gqgZe6u2DsaeM+m84MQ1lXiGim2eI8+FpzJeCN0x4TD8vGrKdtYDhPFD4q8svU6xPxG68I62FOYo2gf4mKMumr+rWmwqnxNSNy/0XX1/tsl78FxAxgl86sZFMRULCMXBx2+swibryVHODS5Ibz8GMggHfNyhlf8gVzoMaTiO0xdwIt9MdJnJzxHoUo1T0Nk1iFBdeDJqjKzVEMwtkb4o8ZLnIZjN4dYp5SWaLg5qWUewLyN13vp+OarcAxZXCryajFauPuYHxeY6AiEZ6tnM8IRO0+yH1uduuBrBvkiZYUZ+7EaLL+5WcA0kSRXgSkxF8hYijDt+l9YMmpg3iheMBHlZivO4GFc9GEziLWlvbwnWUh6HkbySG1vhzHLkaER2SbD1s15yr4KgMuxP8WphGZstJ+a6eQT6jAjUQVOy/MEH75UkEiY+VdakE6negXeN2qIFgDVgFkVYNBIzGrRJInINlPDadnaMcGssnnpdlaiXIq3P3lXSb05BbPVlpkBNy/UZqHUbVAo4D9pbXSaKAl9OVMzflJxubl1AVFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c29d40-b6f6-4156-2ed2-08dd841899e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:35.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ghh5D7SXRuTnH+WOtWh4InjBH4IK8WGEFpaQF5O94tDvJBaOIoxQMItsciZ8DSwYHBXdL3hyEdwS87Oz0dCPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX1Zg0MRxi/3XE AOriDIKvbIWwyDkqVBgKHgNkJOox3DNPWKh0CYdPRzlqGkpBkOQNPY+K6jpBns2pOhCvKQuiGAD 9EFP/4Jbg+4fbhjPu49l0ceYG8Q3nT+xf+LNRVx5Opp8ykXFDJtH4EbgvNTmHeXwDibYprJic3/
 sW+8w9E3pVpxsbbacgpVL9FHrpzQQsWsSpwJqH/JLlDtM+wTz4ewv7DgkM81BRkVv7rXDRC2xDQ ZdbEtYEOuN7U+uvUkC+Xq/nluRGGdTswVr0pA83VDZravXEEb8BNQRLjkUSvgRstAqBwSK7ODU7 KP1X8vHDdFHlUZv+7GMGUq3qHPL89Ug/uXqXpsL71UAKnYbMAR9ws4QTDI8PDjkAaO2fZmvNoA2 o2YVQd7D
X-Proofpoint-GUID: NuSDCbaH1zA2_rdXIN5fydu4vCuUAlhf
X-Proofpoint-ORIG-GUID: NuSDCbaH1zA2_rdXIN5fydu4vCuUAlhf

From: "Darrick J. Wong" <djwong@kernel.org>

In the transaction reservation code, hoist the logic that computes the
reservation needed to finish one log intent item into separate helper
functions.  These will be used in subsequent patches to estimate the
number of blocks that an online repair can commit to reaping in the same
transaction as the change committing the new data structure.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 165 ++++++++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_trans_resv.h |  18 ++++
 2 files changed, 152 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 13d00c7166e1..580d00ae2857 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -263,6 +263,42 @@ xfs_rtalloc_block_count(
  * register overflow from temporaries in the calculations.
  */
 
+/*
+ * Finishing a data device refcount updates (t1):
+ *    the agfs of the ags containing the blocks: nr_ops * sector size
+ *    the refcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	return xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Realtime refcount updates (t2);
+ *    the rt refcount inode
+ *    the rtrefcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_rtreflink(mp))
+		return 0;
+
+	return xfs_calc_inode_res(mp, 1) +
+	       xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
+				     mp->m_sb.sb_blocksize);
+}
+
 /*
  * Compute the log reservation required to handle the refcount update
  * transaction.  Refcount updates are always done via deferred log items.
@@ -280,19 +316,10 @@ xfs_calc_refcountbt_reservation(
 	struct xfs_mount	*mp,
 	unsigned int		nr_ops)
 {
-	unsigned int		blksz = XFS_FSB_TO_B(mp, 1);
-	unsigned int		t1, t2 = 0;
+	unsigned int		t1, t2;
 
-	if (!xfs_has_reflink(mp))
-		return 0;
-
-	t1 = xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops), blksz);
-
-	if (xfs_has_realtime(mp))
-		t2 = xfs_calc_inode_res(mp, 1) +
-		     xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
-				     blksz);
+	t1 = xfs_calc_finish_cui_reservation(mp, nr_ops);
+	t2 = xfs_calc_finish_rt_cui_reservation(mp, nr_ops);
 
 	return max(t1, t2);
 }
@@ -379,6 +406,96 @@ xfs_calc_write_reservation_minlogsize(
 	return xfs_calc_write_reservation(mp, true);
 }
 
+/*
+ * Finishing an EFI can free the blocks and bmap blocks (t2):
+ *    the agf for each of the ags: nr * sector size
+ *    the agfl for each of the ags: nr * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    worst case split in allocation btrees per extent assuming nr extents:
+ *		nr exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Or, if it's a realtime file (t3):
+ *    the agf for each of the ags: 2 * sector size
+ *    the agfl for each of the ags: 2 * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    the realtime bitmap:
+ *		2 exts * ((XFS_BMBT_MAX_EXTLEN / rtextsize) / NBBY) bytes
+ *    the realtime summary: 2 exts * 1 block
+ *    worst case split in allocation btrees per extent assuming 2 extents:
+ *		2 exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_realtime(mp))
+		return 0;
+
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_rtalloc_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rmapbt(mp))
+		return 0;
+	return xfs_calc_finish_efi_reservation(mp, nr);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rt_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rtrmapbt(mp))
+		return 0;
+	return xfs_calc_finish_rt_efi_reservation(mp, nr);
+}
+
+/*
+ * In finishing a BUI, we can modify:
+ *    the inode being truncated: inode size
+ *    dquots
+ *    the inode's bmap btree: (max depth + 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_bui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_inode_res(mp, 1) + XFS_DQUOT_LOGRES +
+	       xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1,
+			       mp->m_sb.sb_blocksize);
+}
+
 /*
  * In truncating a file we free up to two extents at once.  We can modify (t1):
  *    the inode being truncated: inode size
@@ -411,16 +528,8 @@ xfs_calc_itruncate_reservation(
 	t1 = xfs_calc_inode_res(mp, 1) +
 	     xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1, blksz);
 
-	t2 = xfs_calc_buf_res(9, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 4), blksz);
-
-	if (xfs_has_realtime(mp)) {
-		t3 = xfs_calc_buf_res(5, mp->m_sb.sb_sectsize) +
-		     xfs_calc_buf_res(xfs_rtalloc_block_count(mp, 2), blksz) +
-		     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2), blksz);
-	} else {
-		t3 = 0;
-	}
+	t2 = xfs_calc_finish_efi_reservation(mp, 4);
+	t3 = xfs_calc_finish_rt_efi_reservation(mp, 2);
 
 	/*
 	 * In the early days of reflink, we included enough reservation to log
@@ -501,9 +610,7 @@ xfs_calc_rename_reservation(
 	     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
 			XFS_FSB_TO_B(mp, 1));
 
-	t2 = xfs_calc_buf_res(7, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 3),
-			XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 3);
 
 	if (xfs_has_parent(mp)) {
 		unsigned int	rename_overhead, exchange_overhead;
@@ -611,9 +718,7 @@ xfs_calc_link_reservation(
 	overhead += xfs_calc_iunlink_remove_reservation(mp);
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 1),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 1);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrsetm.tr_logres;
@@ -676,9 +781,7 @@ xfs_calc_remove_reservation(
 
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 2);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrrm.tr_logres;
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 0554b9d775d2..d9d0032cbbc5 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -98,6 +98,24 @@ struct xfs_trans_resv {
 void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
 uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
 
+unsigned int xfs_calc_finish_bui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
 unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
-- 
2.31.1


