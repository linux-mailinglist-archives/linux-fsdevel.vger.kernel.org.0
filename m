Return-Path: <linux-fsdevel+bounces-43665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21BA5A34A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E652A3A5A19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D8E23BFA9;
	Mon, 10 Mar 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hbc2KWnr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FNQn1/qy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8423BCE1;
	Mon, 10 Mar 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632028; cv=fail; b=PbUCTxF/D/J+Pzu4XIyg1qPsqqpxW71cozKrXDuQKtB03dVe0MVwOXsHV+IohlfLpz2Z3GbqRBBV0vhZIzqVmsUSxQcmE71zUhmpDXUpeKzWnsP+foTQLYYz+dt7Kw0hvSTey+FFYAI35oLCLTvNr1wYQx6S6hkcfhvcweSQfvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632028; c=relaxed/simple;
	bh=pX13wPc39QFyAj232kklLT0btC1ORumQSgvujaWoKAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u58uPRqnPXh6iRg/4VKP1u501yAFA33ouN4EpQMRhwAr83fOmPtSO7rLYYLU8WM0ne6swzI3aFqMtNUr016RULH/fGXviJwOf1h3LuLPznDt6sGEHhIUxwXe7k2eRh+zTTKM13cortIQqT3d+xTdqZlz4oZoTj3zUEI7Diy8CDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hbc2KWnr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FNQn1/qy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfhTO032592;
	Mon, 10 Mar 2025 18:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fT0XXEVIi/mcitAoKVtC8I8u0NcfaCeIXemd/ZIDxkE=; b=
	Hbc2KWnrzke1RX1O0J1Mby29sHCRJ8YHcC+G9GK6V8u9y2Thj6xNYkypSoNu9X+q
	2ZXmOYpav0ThOmCfFkE6H2k7FZFxqwk5zOFQf1f4zfetslY3OmtugJjUZjlvoIt+
	vI9BFG+e3Dg4ZLR+I3O8oLj1PQ/yKRO92hZ3Q/LvrOGSwdz+BDciPFDxZryE9SRS
	P167NEUuMIKLYwKnapzExq542YW/QHNCOOGe4qck0R17U8DNgVMgb158CnhEmNFQ
	EVMod2d5yM0oiufWUjcgssveVuIPRpUww8ij6//e7iJoce1/JcNwZUElucjj0ivl
	jUA88bK+edvjdrODf5XwCA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxck9ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIa44v017442;
	Mon, 10 Mar 2025 18:40:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb80d0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPXbOltgUmJE3fgZ+bxXzeBgooZeWMnrFj4tueh0myGT5K6qLwJOROx208l+rboYUB4DFqCjhACdnxlhjkQVRxeMDH2uPGdJEmLVZMnnFHS0+lYDbm7RraGTR9rdoA65SKQ/pBCp33H5/5NqGRQeN0ZHEfvCSjs18LO+4q7oHHUOLnKzpWoILdd6h+HchrrDQp3IhZfvB5vY/qSyvXjh/MBUUNOCvmZgOZS2QdWJSJb9xKML+dbTd/cxmFJBOaja1dqka/lOAIovegRqnndQbTGWepEi1BoDiwZ37AxVz54yipB/Piy0YI77KSd9HKF0NeyA2KKKXQK3C0mh2oZQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT0XXEVIi/mcitAoKVtC8I8u0NcfaCeIXemd/ZIDxkE=;
 b=uaGp7GzLBeJq2pBj9Ri4pXRtsrXFRhfDJVn6buGzgzKkTvSdCwOcTadpCk6ebFk07YW55FaplZ5plI66wvZzcOVQnQhgNsYKk3WOA/8WFdC5sBHh9dO+dzs/S7b4lBXrnAma9qc1E2ONq1SF3UzCyMmx0py46U7uaO09D/L/Qpj+3TAG5n8EeJJ+Uhg2t9hZqMgoCy/9h12bH6hU98pkr1n7qZaWJEo+kOJxyM3vZJD0sRVY7bfBXA8nOvSWx6uFpEtHT07O/w1R/4IqTOo6JqN81Z0sIJ0I3IOFWPe8Gh9n6eYt84Zk9plHPHnN1mxBfnofmkktp5sZP8in/ziPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT0XXEVIi/mcitAoKVtC8I8u0NcfaCeIXemd/ZIDxkE=;
 b=FNQn1/qyP5xy2upZNX+reUacplpEbTNghDRYf8sNb/tzV4dHbxdm/M0K5p+isCCwdWwsGVxjloSn5vFugTJhnXGXkugaPWauturWTtVMhpMx9k/z7lmnBo1/A+NHqjvdw5O+mEhKMyObEEUpV8qib4ZVuqRxZKDRN5M75RyCovM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 08/10] xfs: Update atomic write max size
Date: Mon, 10 Mar 2025 18:39:44 +0000
Message-Id: <20250310183946.932054-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a3f8db-dbb7-4fe5-afda-08dd600300b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/QnZXu/Hs4UOqAXN4Ff5M3p2VFZYN0Hp9UVBcKSQGqbK7y4KVRGXm+4UUBdn?=
 =?us-ascii?Q?kxr+4UWjIjkBRcsug73IZ4XiGe5yvMN887islc6hV7l/rh9uaddgB1ZC5Jlr?=
 =?us-ascii?Q?+hr7huiUclavyV5YxOSXGyZEOuVCS5W03OOiUI6OUV7mVLN+A93w6YE82E4W?=
 =?us-ascii?Q?T8ys47nyu2II4UEtKLxIcT6vOYCK7jD9KzsGCOWDT6oRUuKPhnqKRCspu9au?=
 =?us-ascii?Q?zlLXwsSMSEJSoQIO44qn1cmmEeZBy5GgYey+yYBQj7da2SU8z7zIYt/J29wT?=
 =?us-ascii?Q?Zt5H0HwNPdC/zJvNf/IhKhA+NrFoKyyn8RUZEteKuxp5O054v+Mr9DjdzV16?=
 =?us-ascii?Q?knHQfmeKYtrwWxZFyBfjzkCGSiF8gjrhUL4eKZkIT1gSyCFN9WugUM4WB/aZ?=
 =?us-ascii?Q?yvkSaB8eQLwkTg3xkIGhBDCznT/7Zsu70ywjX5gRjDDB5GB9bfETsRUFupT2?=
 =?us-ascii?Q?2uLd3er45WI81ptRx06yavcsV1wYK1rAlmgL13zn39D5jjc1kLcTRUKNVX5O?=
 =?us-ascii?Q?eUKWZJxXFDZMmYmoDLNXNjHSCJV/BaQpAveefR+hD2gfC1LsFQG8OXjbn61d?=
 =?us-ascii?Q?I/+r4vb5LOwskTAJTrWiLkRYj+01j4nr8aGAl8gPJYzG7bKR1Q1e9JD9leju?=
 =?us-ascii?Q?+fEjDJS31mjNTy3v3ln5yR1DWsnGMgDJSRHdloVKbX5Ij7G911MksSxoCvuM?=
 =?us-ascii?Q?vnFdzdoBeycg6nWjBVPIcn/UWaodKtwbH8cdxDMk3lW+Aq57RPzJsGOC/9n5?=
 =?us-ascii?Q?xAPIcjE7QRdWvIlyghntDwFDdUkE65v2sWmv0bLjqrzk0apOhmvfhrJOgh9v?=
 =?us-ascii?Q?9suXbtqZfDs/gLMO/mfobeokvy0V7H+6rbdRfjvz2xh/aPxTN5S05T04I/+z?=
 =?us-ascii?Q?FcEhZlXfb4J9SPrg6NNG1FsMhny7IjLGnjJr/G7H9MqSKUrBe3nKlD7hvqZG?=
 =?us-ascii?Q?0S0E72cMz9da2cw0j3YCVaEHHtjb7MFWlXDrpovw7sONvtb03V8XcrBInpFC?=
 =?us-ascii?Q?nq4Vdz260cSRfdROFMIcOLXWOPlhANxwhbFH2in5jNgcGMMdoDOCXJmsV7lW?=
 =?us-ascii?Q?NGYSmRLD/3FRRyAZOVZ6R40WnG+zuhAWepZw/9FTOVXIPgwEqRdpEtJ2I9zH?=
 =?us-ascii?Q?bA/60884ij486kF6K0FnxQknFtB2hD/vtNCL6qxyMHO3YO2+zkYEV8/oFd2i?=
 =?us-ascii?Q?MvIXYy6kLl/LLzpmRgCvGNNKi4TqrYPLrzpdhiVjKUn26UL54RRwA8jlzKGd?=
 =?us-ascii?Q?5zWRKLsEK2MgPYucDScHx80p07Er0ifckUnb1a3p57LrQUcESaNSD5b1RNxI?=
 =?us-ascii?Q?63hvSln+ZxxEiwowV7pFglyV47XJqFp6+N7quUacQNWwI3K2m97Ps3MMFdhK?=
 =?us-ascii?Q?TEQPbF8oVR8MM/q7sPZ60mjHXrQk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkAuh3CNm8Fts6Yg0y7GLISNgjAXaEHmaUXGnK25LlffkBy+JgqpLS8E2Xbl?=
 =?us-ascii?Q?uWz/xIWdmElgr7VM+T8JqlyOFwaubtrMQzNM8ZSvWd9k8s9YRr1Hd3DyPvuy?=
 =?us-ascii?Q?3nDugOB2n2GfuIPcxuBce4qqinwwBP/4xpHq1BM6TuHfgieAqLbcu28yND6c?=
 =?us-ascii?Q?qC/aKW816S6hknE6juLJfjnJJzULSMaB6KyRGutQUINkH8iUQfgvhzlYC3eT?=
 =?us-ascii?Q?WujXtrSSySSrFpNEgUVZnbJE7v8kKiY8Cd5n1XW9XzukI9sET4Gny3ZTZmnh?=
 =?us-ascii?Q?O+iy0XH0xKsvigZ/O7bAbsi2b+sQOvzwGxL28Ivla6kUXDHA+EMiwJSCDILs?=
 =?us-ascii?Q?8JAj33+bWp0mOjQAYLyEaghEIdZ/+90/MZNZzKTRIfgO3tUnUrAHSzyaxKIQ?=
 =?us-ascii?Q?ALOjkIA5fdxetil6G97zP3fTS1H+opIhPtqsnGyP461yHcvcpWzvXis/B4KT?=
 =?us-ascii?Q?Z1vwGWVka+QRLGoPNsB1eSTjzJQm1/7Q7QFdhshd/8CBSoqYG7lHDVygN8Gt?=
 =?us-ascii?Q?yq8h27ZUfgSIP8Jlh66OSwLN07WsqGZqgDFwEKqDXQpByuVsXwZd5UMyyAFj?=
 =?us-ascii?Q?PrRo+dkbH6MT5CUVTFLCjzDFKz607rK2meAl9CJF8S+xwn3/wlXILRLdvXwu?=
 =?us-ascii?Q?cWfo4EO7Peo2cMlaF9AVAhtuqBn+IG97H4P8zGUsAoL8FI4M7qaUDMRE9QbC?=
 =?us-ascii?Q?MKcMXy5bGyklk3qPdPrRIaN5Wh7WrcNxxeV7JYoTmHUMd/i2DWuC95ZKfiNx?=
 =?us-ascii?Q?bF04L5wcnrdm44f/M26HT9mzggT/n8vLLgkBOtg7Qz6wXGnZGLEjKzj39+lZ?=
 =?us-ascii?Q?0IrkRgNSl5jChsULhYHwgL/jbVB1QiMvAYRWMR+qogHfAz52GsNjEkOdh2wy?=
 =?us-ascii?Q?8K1MIk3cjEKgBoLEiYg+mSRMwBdxWT8BJ9FXGYGDr/HNzKMZcoVYDA4LsuoT?=
 =?us-ascii?Q?O1QcL3wh4FpS4cXacbGf0mbHlLMEmXvy1k/E//+XAZN9O9UaS7eca8FBSfkW?=
 =?us-ascii?Q?kkhp2+FK1SR9Py6EMwUIRQKS+osgdyl3SFHuf/y2AHV4xO36bfS9EuHu1dsC?=
 =?us-ascii?Q?/XUZhG3/yrm8dcRJDDKgYcpkbIbk+aPOmuetibYHkyrbc/EiCF7ELH/AcXYK?=
 =?us-ascii?Q?yyiAPnfQePvVvkm03zNeOvG2gd8pFdY2UkJ3V8L8MrlJ6hMf08I4WIXH3l5B?=
 =?us-ascii?Q?pXhK83WuKdWcIwa/jdY5JJl05XKb4HsGOhQkM6mWWiT4qtQjJceqt3/vfJ38?=
 =?us-ascii?Q?Wd9q5L/2T80jbnLHpQOzT0rBBl+FAdGZMYNUkNnRNlZ3bDr1/oHbJEXMra7s?=
 =?us-ascii?Q?KK3fDeR7QUfQwJ7YE2f2UaAvtMuXmws4VhjwtTz6VwAGybeMO8uVNUlaZOmw?=
 =?us-ascii?Q?JraGxFyyf7QhLylXH7pYW3QGjK2fl/eeREwjxPYMiI0blaMfQsLAZpikrU1u?=
 =?us-ascii?Q?4NeSGoWjHPnhkLLeNyxx0ksFrfLlzxTNcp2UqrCKGtyD3zbsr3gUq6sfBN/X?=
 =?us-ascii?Q?/9jAfPNZec8FECv9GEPuCjTox7j1mfCJah/r/YbCJxpb79WiLaBx4RMugQBN?=
 =?us-ascii?Q?o+QziZ9cb9ywt8Y0ebDCfL31qoq5OjanPwmLBDZ8+2HBUKTvHtGZ0YLVCtZ0?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RTHHBGXCc7uZOGbxzFZ2xxlYIc0OFuLOz5VNVQOPKryKEE5Xyj+7g4Umymyo556tsZjzhTFwo5cAQG4zbKYWEspJ18AWNRCltRNyOAqFvieh6TmOtOt1g3IxzLf/gxWny2TdUCo3OGGTqjfIrAme8I4glaDAJ45pYvUCkqgNjSqFQQg/TlqliNI8coZbF0Tyrw+SqGbxYxp40b9UvDU4WcUt2RX5u8nRheYxIo0MitWLsEkessUdmT6ll4DMcm6gytE7PUxMc5a2QZc6nnqfdxJVfB5GE+c3HjZTLDAeMKC6w0Zz/d2/nhYlZOr1pi6yfSF02ZsI8wXH2abfqp9z7lqDipcRGUWBWZnEz/gjs2ga5SwDzTdgzaDZtAP8+ZZBdpygckWf3dGVvb2goUzoCK23zMRDGySkIc307TDeqoZkN3KME1iWWi/u3jgXTDNyvvHzp4KUWeroLpKBMX1XvmYS2Q1Tc9BvLE8KyEX7GUys8tBRglSJu6DJJGonx3UIc6uTDhMnlU0Xv0egynrXVUIBk4yYlCbWn2EzAx/Vd64Vi7ZxqpitMQR0HZSbs7kkrS5hJI+yt1nVXwn7a1GZ7KdgWezDlNy4ip+3959ytdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a3f8db-dbb7-4fe5-afda-08dd600300b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:17.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whp5MYPuQvaiszqiDmbFK9HiZyOiQDQlQ/IO1cTi4KIYyWLwRkIqJtMAiQzZJawi6zKA6M2YhObD5/MeHp9kaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503100145
X-Proofpoint-ORIG-GUID: 4YSw_as04Y2YDtGxiKRulNegrZ2oB0PK
X-Proofpoint-GUID: 4YSw_as04Y2YDtGxiKRulNegrZ2oB0PK

Now that CoW-based atomic writes are supported, update the max size of an
atomic write.

For simplicity, limit at the max of what the mounted bdev can support in
terms of atomic write limits. Maybe in future we will have a better way
to advertise this optimised limit.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

For RT inode, just limit to 1x block, even though larger can be supported
in future.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c  | 14 +++++++++++++-
 fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  1 +
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index de065cc2e7cf..16a1f9541690 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -607,12 +607,24 @@ xfs_get_atomic_write_attr(
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		/* For now, set limit at 1x block */
+		*unit_max = ip->i_mount->m_sb.sb_blocksize;
+	} else {
+		*unit_max =  min_t(unsigned int,
+					XFS_FSB_TO_B(mp, mp->m_awu_max),
+					target->bt_bdev_awu_max);
+	}
 }
 
 static void
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index e65a659901d5..414adfb944b9 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -665,6 +665,32 @@ xfs_agbtree_compute_maxlevels(
 	levels = max(levels, mp->m_rmap_maxlevels);
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
+static inline void
+xfs_compute_awu_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	xfs_agblock_t		awu_max;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->m_awu_max = 1;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into agsize and which
+	 * also fits into an unsigned int field.
+	 */
+	awu_max = 1;
+	while (1) {
+		if (agsize % (awu_max * 2))
+			break;
+		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
+			break;
+		awu_max *= 2;
+	}
+	mp->m_awu_max = awu_max;
+}
 
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
@@ -751,6 +777,8 @@ xfs_mountfs(
 	xfs_agbtree_compute_maxlevels(mp);
 	xfs_rtbtree_compute_maxlevels(mp);
 
+	xfs_compute_awu_max(mp);
+
 	/*
 	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
 	 * is NOT aligned turn off m_dalign since allocator alignment is within
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 799b84220ebb..1b0136da2aec 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -229,6 +229,7 @@ typedef struct xfs_mount {
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
 	unsigned int		m_max_open_zones;
+	xfs_extlen_t		m_awu_max;	/* data device max atomic write */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
-- 
2.31.1


