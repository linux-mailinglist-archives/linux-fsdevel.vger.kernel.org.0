Return-Path: <linux-fsdevel+bounces-45950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369EAA7FC7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F726167E50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFB267F67;
	Tue,  8 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUSaZ+bd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zzfw6Z/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7D267393;
	Tue,  8 Apr 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108974; cv=fail; b=A79oUs1XohakNzriH7b5BQySREI+Fwa778B9jeJ+7BOScNOYCXbxORQd9+3bjCqXhhYUEazlY2u97l5ZFYlzjeQ5dqxFIjuJt0OGi6Vuq+pvhSxegJWSirtUvhrC9R9+xa0JW4qDHVBSVcnEgHsjcuIglyVjQ7J3bOtTdL6l9Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108974; c=relaxed/simple;
	bh=ZK7M0aHDhxLo7oixjgpiEQvOIhzBXLVTqEowA7lZsxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVpDqJAC63I/lu236MeveOt2HrFqZRdm7oNh4cgI/1/xmsx1D8Q/CyWKPp00NaheF1JHf3M4TTuXLOGktJE7ppLXJgr+VeAXxnMzBI6eggI5VkkU0WxqcpdEvwgPJPWMMnNwVTRepa/P9NA1O3bMgQ3HhzuyZg5xiSAu0FW/q5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUSaZ+bd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zzfw6Z/e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u9VF023268;
	Tue, 8 Apr 2025 10:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N9FBFjiGx+aOtpukFxjK7ItkyhCuufz4ouH0jhONJW4=; b=
	LUSaZ+bd9uJDPYh7jl/lqt4sXF4an2Pw58a8pw9NyNIwXQPb48nZwPgKnTvuTKHP
	FNLcWQmqVxN9jppSm7ql++IUGBcKqtRholU7mYuWavN8Ov2J9O2tCBDayzK14kth
	Aq5ADuNFwMapgzGJABwcnEFaxvooKi16dwPFSmnEMZemFqyydqSBCqunMpwp7DSv
	BfL9s0OccYCSkwUYMDx4Xe0OsXUBThyQvMbrDUIr4kAsfqGEgvdRVN4/FkLhTaLf
	0LUvY8fdR/Rxj1LwgFUMEV/xuKeQC2lCFJthMOnzU3gReXvCjxrlYaPFzHAcWEfV
	8xJa37syjMXkQmmVBUyjFA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9vdms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5388gM2R023836;
	Tue, 8 Apr 2025 10:42:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfc2pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ4k1YjkHrYfTFwVdUiX/ZJvtWUtqGeAY1ymJUL7XFpVmDapRtNc2wXLT8BEC+Fv65pxJINrgZzBNRKNqWXBrPevyGvOdo4Ji3zUWqSzO6bW52l1LN96qjNCtJn9tp0KV7FAqi0REWPmy/j+KUbKIDYXF5WMFa6njNs9I9qOG78OXATZQOU40CQKzTx/gQkPcFi+AlBwYMeJSDqsEiVEkhi1DAfiwlEHmEzNt11xlbK4dNSS/aGeM8mJ+h0jPlg4do1+6+w5fq2BlXSOVbKTuSLF80oaD9zEUeIQfKuMnKKm21wyQDUEefGhyhNeG71mLsCPuZvc8LtFbs1dzUHXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9FBFjiGx+aOtpukFxjK7ItkyhCuufz4ouH0jhONJW4=;
 b=m8ypbEMKP+8PTPYm+1H+wkWyumRLHtg25QRQain28F/w4kTB5Czy5r4Sh02bn8BYDXyohFQTjWM7eE3YGqvnm7uOdVnPEEWxL1ceSPZKXlZmWvTmeWC9Ky3KnvAvYTDGJunLRTdK5cQHGusUA9X+cHFUb+pVlM4BtILwqBtPlLHrS9GHEwLXDiOvG1FZucarnmr9NxrC/MNXNb29z7pPj2XeNPCB2sp9tA5B0KYguHYI8Z0frOCcDIvjcSY7k3opaxpv9lwN+YIECWgMOekGESWtE5j236huQlIzo+mD4yHW0FMOW97uGTwQL3WZfGvcCjqqRa9F1Bu5gUkk/iQ59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9FBFjiGx+aOtpukFxjK7ItkyhCuufz4ouH0jhONJW4=;
 b=zzfw6Z/e0CaTC8sXLt+uOLJKG+bMXi+Ss8Ni68OMjJkgdovD1pzYHtRCxLbxgDiht/fOfnWHQQcd6MVX7VvKjt11wvPqkF/rUpSBEzdHovqnLv/48sYbV1mO569GonTw/EF9mlC33hDyNDMbv/9EzwvnBi4qDLjxbGl8xyJfqww=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 10:42:35 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 01/12] fs: add atomic write unit max opt to statx
Date: Tue,  8 Apr 2025 10:41:58 +0000
Message-Id: <20250408104209.1852036-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::10) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 805b4d76-b470-4238-e5d4-08dd768a1293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X3YmlTeqyom+Tt35mdtfJYjGXhDjzwIE65F4cyoEO07/h7MqakbfmygbHt1v?=
 =?us-ascii?Q?7TZgbxvpXBPxBR5kFH51hlLv3qaIelgL2x9hmy6RZvurk1M96pCNSLFQXZdj?=
 =?us-ascii?Q?agN+C1GWrqtJcTsXi7F8mtMb3mYhkBASXiCerJDJXHXoEA+U6l4IwICXnPQW?=
 =?us-ascii?Q?tvnxasaTqDqcdgV5ObxTPchSPSm+3xY+NhEyjoDBmzf+zxAmYALGCjZG/nYT?=
 =?us-ascii?Q?eBMxDDCfieuAgKgzLgAkDhoAuAG37IZffuvUyYO3X+h48cyvXWhAqL/lfSPb?=
 =?us-ascii?Q?v25QMNvBm0FOB4ikRRgwkRp4oc/xOdVCwZUFARABKWH1jdlF0gWioewx6+e4?=
 =?us-ascii?Q?cewRjJa3n/nS29WXrFQ5jXH7jgXWmFVS1rRvrd8eQCSUovD92AemOTo4/UP7?=
 =?us-ascii?Q?Xfn0ZI6KL2ugRU4WAiw3e0W7VPFRgFnjI+FXynO/ve/IB+pNAYKD3FIdqSKP?=
 =?us-ascii?Q?lERJqmw7TUv6euPgr2Cdfg0atHWp6oz4nxtYpJOcdEBmrgC8mxqdH5pkTgk1?=
 =?us-ascii?Q?cCO1qaB4eKanmswM21qi9luq2Yn8fAr3b83q6FWKsmmKIcCiU+h6L2nr2Owh?=
 =?us-ascii?Q?BVXIueT6Ibwe2GmSgc1q9Q1vpLi/V+B7NXQ4CyI00vB93Z5Po67ZbcEKOrux?=
 =?us-ascii?Q?q7GajhPBA3eAp1SJ4hH69voR3B67TWvhBAhZ1TWj+UHcsSizYPtORIR+8vFF?=
 =?us-ascii?Q?zGOlZDlz2NA5iz0IB7Ej1DukpNaOUMp6Coz3KRLgRqRgH7pLvpY6Ayil7sSO?=
 =?us-ascii?Q?qOrlWN8il/uhMC3VIjC7ogK61laK9tGLnHpb1d4nE2sK4egqFkMuSYwfx6WK?=
 =?us-ascii?Q?uecI9cTwSwg7+9LFvu7qlhGbqCr+6yKJIATdgWYjFEafmVcT4ZHhbQ0IggD4?=
 =?us-ascii?Q?gypzktN4dsfvq4+q+mpa0x/trFOVUTFhj5/teKqY2QX+pIAu8r0PMSvCUFJJ?=
 =?us-ascii?Q?uJ0OA+2SVHgKw+mSZu8iHwwPDkHTH6898c889sIF92fsCPfmizbq343iLdZU?=
 =?us-ascii?Q?eRAKA/gG6BDR3yF16bnoCudZ1Mc9SESuCY+Zm5bPiwoLAoAwJvlw0qlg0JKv?=
 =?us-ascii?Q?Py9xuCBgUwYvf1AEfeGFX+/NzU248HNRyp63yF0zTBpyzazPhBqhg4tweL79?=
 =?us-ascii?Q?XRrawtShb7pLPeaUdsiZMTNsc6Z+fW6dtBlKcnBvsr9v3GOTecXsEKTTK0+t?=
 =?us-ascii?Q?ANaE0oI1Foratb6I9A5F6e5LSWvQMzObHLF5cueKgc9rAHxi7xw5dHopWVfS?=
 =?us-ascii?Q?oaLQe5nFVTaeXLKI53VQA8ldl/MnqWnOQRSSAKS7ybRth9oQo881JGk9h7xW?=
 =?us-ascii?Q?OIVjORfIau36YnAiDs8P0jr1BInBctfE+/NqHUiTw5qf8MJKtgDMCRFg8kbO?=
 =?us-ascii?Q?ewW5qzWW1R/jGmtFGT7MIKPcxFRm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qw2m3sn2esBgp56fqtprPzV/Hwe+OD8qYCrnqrkpzmGTgXZzo3MM05toDCt0?=
 =?us-ascii?Q?au3TTlxmiarvusv0bGl9Kv+fq9NR5zGs3nnbz/jjTd3lO8m+djCKdvTycNf1?=
 =?us-ascii?Q?aSzGqbqV2ou6GjEzCacrpt2oguGWcarKAjBGBS9sb6bzHcqCEcz2AjVd8eXx?=
 =?us-ascii?Q?mvzJGGp8psykPdkmL0thWLeXKf2VorDt8tC/dSdG+AthI2nIyQ/P+LDbtbZ6?=
 =?us-ascii?Q?sGGatmcC7ZzrEb89EHZZ3sJe0fzK7uu16GAgXOeAgc2F6Tx2jazvvY9XBmhT?=
 =?us-ascii?Q?p99yb1Wenh8brg1zzR8RWS5qluqPR9OiwWu63h906Ay/jKBWHTdchV6TFxz+?=
 =?us-ascii?Q?EUq9eB3dLN4B9rgJlNOSDjXe51Y1Gd2LYFTYJ33Bxf43P4LDY0mIErVTQK9s?=
 =?us-ascii?Q?Ds/RWRKz+kjvBLRzblSjMWQpdHTFHI/VlzhQPLsrHEdTrVxIKzOpa80SyeoO?=
 =?us-ascii?Q?O4AajQ69ZMxabwewqhMj8NCARXvrbGgvwU6BPTp3GNVG/3kkaJzprHntly2u?=
 =?us-ascii?Q?aCqfgAGnQ/boD11hU7YS4vivvLwQy96+gg/NXslMU525ZPGYmNC2EE0nzm0h?=
 =?us-ascii?Q?cuf45O04dZRUf/JKbrVEJ7in6Ny+rRsxxlvbV0QSqsNpheI1nPPetxpkNsPh?=
 =?us-ascii?Q?EJMELiIz1y6ZA/q7u/yBB1z2DnEyHZKUIGllh7MKycZ0SO2eA9udpjFrQsLH?=
 =?us-ascii?Q?YoE5lVZu6DNx5XHnmNsUGp1kaXzOVBZdJoYogow6rGyVFe1r7NR2vlikTRxE?=
 =?us-ascii?Q?KMS9ZILO6ZJfomawZ+6CMbLhPCXqjqZWZz+yOSuKzMGW6xrRbo7fN7cEWqED?=
 =?us-ascii?Q?NkHYa9AbW3iaNwottq6bDHhVtwmmRqgBEy7XIIBPuAJELTjnHk6ufj1PM9kH?=
 =?us-ascii?Q?SR7GTl+KgpLUvHXrl4RBcMn1DsMnlJoHqDCunCroPh1ReP9sCqGFNXGslnGp?=
 =?us-ascii?Q?uOb5fuNht0+2EqkRtdmNEOgzjgb0Dsn5ThvEnCkr4VtHszAy13Q2We5/tS2h?=
 =?us-ascii?Q?lJKdHLSYEE0ckpkblCww1JzyadlvHyz2c/9V/jCxlQ8YJ8KKeQpWKTn8VqIh?=
 =?us-ascii?Q?0c/F9Pzi5+11DUSpBJshc4c/c6dmRSOorxZ7aJ/qjz693ZpAneuW+YnttFY3?=
 =?us-ascii?Q?b6X6tHEzwDaECqaZHOs0MKkxkPpEHb76p41xWCmT03O1ZLL4NMfyKifvsS86?=
 =?us-ascii?Q?PSXOLTq2GHjmY3g9Um0tKxBUSgD9ybyXob1LUuw6vOHi+u529zFschw+Olpe?=
 =?us-ascii?Q?XA39dGV0ZpdH7v2r4KLGUQWBEm3OSM9EvjNFWoLV2jnkUdbNGJT31obx1aq/?=
 =?us-ascii?Q?E1XUo723h89r0Qawu37v0QzCNO0ey//gPvV23bmxvIbunw6iwzNO0ryAre+H?=
 =?us-ascii?Q?OAII2gPcMa3xSk2YU1uutRmQWajgCmXxdkWwZLN3GzuFsO8lyN8dwAcA3C1q?=
 =?us-ascii?Q?wPgQpeFChhAZ+Canq7v0wTHZACkAUZacUnqW+ulXVUrB/w5DaN62VgrZBv9x?=
 =?us-ascii?Q?BXRzJjysEz+xErLdUymHxnyN7mDssmaK7tvAhWsGzT78mg09D3kvUqARjr2B?=
 =?us-ascii?Q?WmwJ/lv3CkQbUY+IoRLRYnzMHG/R1wDRN6LqJV3d2HbMDvIIzP7yEkNd85bA?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	54XBu7au4NbycbdNyjSjh9Mj42q0TU3Kv1ruNc5vJBvEGpoFFk1vJ+uflI99uRPZvhXALbnCDf7yXvIznutVQyhRGs9LEp5LNLVApQuldj6RlhaLjq/NCQ4/vXRqVtxtm6+G4OquAE1NFsi7L6Y+r7oJRjnq2CH+czaZDuoktvFkvUcxAK5y4g7PiC82toCLdST5+XHWGdTupylwM7lCjCU5hMFHNlNFGASXbYCHqk2joQyWWsdq7CIU4tIL3aO+yNXAxCdYu9liO7Jy2HtbVbXFGLCPUQfIoaf5bDZoCmKd01wVe/qgvq/789QbztDr39qFRh0MhNQx5Bp1Q/wevzk8//BNLSM2OYiKWSbgJwODa8CvQKyBLqTHBjvCjlcFrCZAsHShmEx4rxoI94YSU+8HayT+HQb9XfhFCww5kDiZckrh4Mr3iewLaT+ACeiK7cuN+3c1sqwXzSw4bRoeBMla0oigW2BrT63FbzVenIl+fNcwoji+yR5xY/Lefaz396gUDZCDyEvFqtEKGx2+FCfRHMS01KFknlBQk8SxhUvpsCuNGPG+UNGl9S3xDbH6w/EbHJHTe1rj/Hu2g8motYgWSO1pfT3HU3jvdsfIh+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805b4d76-b470-4238-e5d4-08dd768a1293
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:35.1254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRpIlGJ070XJ4hhiVTp4aT/gWkxbPCpdfDOEd0iS2SxH681/0VIssMGtq4aqVXopOVBlBYionBpSeQTYRf0lnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: 6k0HpJqaAN--0ci4WvhOg70WM_QArQ9T
X-Proofpoint-GUID: 6k0HpJqaAN--0ci4WvhOg70WM_QArQ9T

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
index 1dc09ed5d403..51a45699112c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5663,7 +5663,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
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


