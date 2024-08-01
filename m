Return-Path: <linux-fsdevel+bounces-24817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCA9450BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B73B28874
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60191BDA97;
	Thu,  1 Aug 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l9mb+mA2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PTFTltvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1C1BD01C;
	Thu,  1 Aug 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529932; cv=fail; b=S4EO3LZsL4NboNEPNJzWVIv5HFH9c5ICz6RuiYFpZjjTPu2PXivei8bjC5RTpB88IR17uUEAKr4ST4kLTIjuGB3jsKavSbnRFAkSdE0CiwcrUOp5hxiBuYEVexE81TH7IOlikAAw9qjK5zVKl7vOhs2K9qTH8d//bOVGpChg2f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529932; c=relaxed/simple;
	bh=2xJob8bM8FuDhmNTv5sPBNhkIAuRf+6gpXfoewv+evg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TA6pMd7QtJXFh4uc6aquJcAUrZIozaPFoqd25ASyINwNg7DzQyGEzcQXNQQDtm63UpxtP43Qm+QgJTzFwewEXzvhcj9E4ld5x3Zvc3xilZsCygBSU0IkYAyyS3M90iPeMsLh98fXrw5KN3OTM1ZWjlMCvS5ErpoB1j4gCEObO1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l9mb+mA2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PTFTltvI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtTJR002486;
	Thu, 1 Aug 2024 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=PQCgj/fTtiN7ZwNNirfsdVvWimv2TbWwYg7gvzOqD1s=; b=
	l9mb+mA2r5AX1wMXHacf0Df09V7cetVFF74qrhl4WVR7pjl5gUc+u3LOb8aNTRww
	ii/6kWGhHDPj8MPDe+2FHCorpJVTIdKvO34ri0R3OqwDhOKEt09iEd57s5yzURMc
	MrovlD7lUfnH/R8eEtLFZQXD6vn2RV4dvfCewHuGy/0Y9SgYlDr0G6Kr5ac2sylF
	pVYJghwLfAad2yRdCH5P6BMxlj7WatyU4iHi0qd+Dc9HMtgbUCMuMn7ILREellac
	wG/QLpjPbclWL1J0lNLbK73PAqjiWJ+fUorO8HiIIE//1Pm0pcGsxInqIHC7U3Ev
	KXsomOlfyC4KDJkig6ZYvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msest6t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:32:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471FNu3B030932;
	Thu, 1 Aug 2024 16:31:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehw38jm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glC7teV5587rCTAF3SEC9Fd9T+CnMgfkP2ZWsCVQPzRR0ew4VNqqUyWYxOkztD+vNzCJjPnpkIJJhmfI9HhxSpdY9w3sqvyLfKpKpQQZK/HF6inmUlyRwMeZqkypoNU/V8OW9y6M5aJyvY+caX2vi1NzTbqfAs2HYET/PmKhzrsg2vMWuu3KpMEElsjLV9JWwDyD5pS6tryoAK7M+14cv9alc2NDYw1unvg8Bz7/iwxRXnkw9rtAG6FI/s2y8haEZL7byO8qeYicZZx1eyl2WLQXmD9vN1T+eiSq6xsLUeeYr9gXFkm4MtJ34RjbiB8Qx0rxNt8Rztb+CzFhqLgDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQCgj/fTtiN7ZwNNirfsdVvWimv2TbWwYg7gvzOqD1s=;
 b=mwNsd8qfcal3kp/LBWfruGd/Tr+QbKJm11fxA6d1tdO1Gplpy3MZW5BD1h05Kn1i83pHzwamga6assm6EcpXD6SmL96wKOrrGGJKBX2W6BnCiGnM5BhjksONIFQJxiyPbPMQuDirqhAup1qmnTrFWjpuHY7Bqk/tD4LlIeZUjKdcpej62BWKOJR0IMpP1SFPhfGJNToe33/cJCBgdfFebwUKYgzWkk8Sb0oHZH+2tmNOCLtHuZml3SHa6tx6WXFmnGdXPPFdeCbIz68BBsz4U/YG7rpCsIhbdmEw0arMgQ441XBRgdvMHloxzg9SWlr5OD6/ist7rMG9C6W9DcjPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQCgj/fTtiN7ZwNNirfsdVvWimv2TbWwYg7gvzOqD1s=;
 b=PTFTltvIMNuGDzQIvgCiWsRBCd/EFVIva8XQwYlDctQyymGV8TFFZBcRF5TPil9ZjntwEgqE4j4h4onNeLBwOSh1Y7A3GARhznEyXkF0r8mkI14EGr2cj/SZU1fbvKDHpsejxEUytJzcDYoggT8HczsAraLh0ga/L1hwjbaVUVc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 13/14] xfs: Don't revert allocated offset for forcealign
Date: Thu,  1 Aug 2024 16:30:56 +0000
Message-Id: <20240801163057.3981192-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:208:234::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: f3abb9d8-aa2b-4d16-1a7b-08dcb247748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q3FOzpBrkp+EXJ5GRjar3oPdqYofl/AyVBkCR0w2Ih8geioGsjJUJQxD4HwO?=
 =?us-ascii?Q?PV56LHgCZQrG0CoWTWcsGIvPA0wHs9XX2eYt+/KtnvfGsBZA64XEBqwV2g7+?=
 =?us-ascii?Q?p2ylmVvo792rq/vceHvrEyfJMc2LBi6dlJYh8Ysq7F3PYN8zJkYFSOY8/x4y?=
 =?us-ascii?Q?I6XG1+506Uvp6w7RC2nOleckD6D3ARy106z984vIbyzEgj0/1FQKja+NhV5o?=
 =?us-ascii?Q?DVYy5wwYHfvh/+s6pEdvIdLqdhAbHvMWGMR4orfnIqz0370UvB+Hrf1zlWeF?=
 =?us-ascii?Q?br9Jd3A3VkmnTqkjXxo6a/eCIIeL/R74PPQbVUpyvH5sKpQPoa3mGAKJA2Kd?=
 =?us-ascii?Q?zTxtGicT9KvO2YsUhkuYi9mzQ0cTTwrhO/MUxLSfXzXYP/ybyEm4ZVZ+RneS?=
 =?us-ascii?Q?UCO/V34Nh4BqtL7z0dZjfLKvzm7KYTpjy3eSNzHnEpP8icVmBkv8CBxZdAdg?=
 =?us-ascii?Q?0QIUVcoWiAjByBGe24arH0dhKaaSMCX8pFYgA82O52/ywcYg2Pxhh8tGJlMr?=
 =?us-ascii?Q?0jxcokuZ9+m6yNvwEZbDv1NT5F0QzgdfarT/x3gitMGGrOnPV3lXl0kd9tXS?=
 =?us-ascii?Q?VF02yfnANKPLwDB9hVqwhasixQO8BImlG7Yw2E6zTnga7zs4X8iXiO/Aw2hF?=
 =?us-ascii?Q?5zvnIbmwUjuRHPCxSBrvDCyDo3EcX22vIuObdOvJSOkqwNWBMjhTZSWYokGl?=
 =?us-ascii?Q?n+mk47lhCgn/WZ+HP6FXQ+jL4DeGADC6S7lxsqeHyDnJrm+np9m4iYtvMbv8?=
 =?us-ascii?Q?Ldbe2ZoqgPZ+ikMzKmXdwsAuZfhrYP4N4VJ3ARSXm38Oxuzb0i7NOI16PeCs?=
 =?us-ascii?Q?sWoKMC+aUmE+iF1DqtKGr7Rf44fgCg5ayM0lZ+3dours3d9vSzIBzVB4OYfZ?=
 =?us-ascii?Q?p6k/1T6H6omYJAOM0yGy/pTFw62hfP7Fvvd13LKrOiN6E25XFw7nz3uVp8DH?=
 =?us-ascii?Q?TvwLK0KXgMAMjVydcMnBVboyjUD9GCrbtbA42nRtvwGr8q6hk0vlpzuNFJGf?=
 =?us-ascii?Q?zbB4I0XawJgMWG5K7WJ1aIm67n67nqTzFjLEDoBbGDRUKZsHqgkC4TZdMPdc?=
 =?us-ascii?Q?0zi4LIfsuQVnNB6pOb3Zvp1DytHdb3jYJnqoMKV21TMNwPEAhdWv79avSj8I?=
 =?us-ascii?Q?+t/gGh2Z25na8zXMYHYAdFod4eyWQmC+csAG9tBQ3VAiotwcr92Ul0Hq5ADX?=
 =?us-ascii?Q?ckbWLonV7W5sKbS2vOLCsWyFS6i45x5Hcb/fK9aQNjqHb6EK+w//GUFtLDK2?=
 =?us-ascii?Q?DByS+6QRDl8YmIajfbqxL7cqerliPzG/mWnfHwz45rlDLhjPhBOArlM+zFQF?=
 =?us-ascii?Q?bWiNXoH9RmHR4AAsa/aWKFGfWESBMFA8RBLWQCVtGdqL8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ocMbiLP+ASMcpI+jCDHVqrh/UrLyDUl0tuEYkSpMkoHx2+EaArnE2TOOfEc?=
 =?us-ascii?Q?/3DmbFY2g4dbsv/SgWyzsWuHIbYIVovZ58Iosqy/VEMlTy1LZqgA30jie9c6?=
 =?us-ascii?Q?1bTskw9EYGs0XsikkA1wgIgLGsoOsPWyiEJQFPH+d13OOtACMByRxgXC5GZ3?=
 =?us-ascii?Q?f8T6nm2VkQZ/ZuIPpNG6898c7mqQZ+FRfrjMaH6fl2mLJZSFnhjCr6nVAq/m?=
 =?us-ascii?Q?gsRLr++T6K0rZQAmjNa02B3Ro69KZGgSk/GbL2e2XzOFEHWFrgtONWf8p7J+?=
 =?us-ascii?Q?sxspVfYywIHM347KbIF0Ld1XL85ThQk1tYjtjUZ7KuGjMvv5GjXC2pMkx+B/?=
 =?us-ascii?Q?OapzkMvS5jxja4z1mnkOpJAG+qJY3aMRaD2tPAsvUnRnIyK6EXt+L4zw2Af1?=
 =?us-ascii?Q?sNMTUSQ7pUfuM+FDrabWCakagv3GY7sU+TPuX+3NNSaQmfbyX577uY2ia4tn?=
 =?us-ascii?Q?UZ7vrNKq+elEyxxj8BCH0jO2LPd0g03+1crWbDMgVPVepUc0dXE2oMsZaX28?=
 =?us-ascii?Q?ZkOQFmQky2VzEW5dl6gctag/4Bz+mGCmSRxLx1eBCesuU8WY/7b5mW0wqoIi?=
 =?us-ascii?Q?B5u5sPG6ucT9vbyTq6+FAo8wX6xu403OQirBo2VbGBdbI7R0nmXLIbBPp+qW?=
 =?us-ascii?Q?8SgHzetmcp3OZsHoVhHfCRpLNccgqeq0mC06yKT0qLBOsPrHCUHpcU451cY5?=
 =?us-ascii?Q?QCn9vxnChJQaH8kVaSFNfb64TWAFRyXDUcheZJx5WOOKt6AA5oA63g3bIpXd?=
 =?us-ascii?Q?e2S8ujXvFUr5BvpJz4Ld5sOACaaroGKCVqYWWXopLUCRPwIfjRs4ZWn1vF/z?=
 =?us-ascii?Q?56qUWEnpgn/9XvQAR1iHVXf08RNeCQxMWfhKXImvZShzlKYkgJlSFss/QnYX?=
 =?us-ascii?Q?p3fdBWTichesGEG5mDsrEbfriTliNYI+2RflCCsOskXevEYiM4LvAB/O4SxB?=
 =?us-ascii?Q?La3jYq00NLBK1BIYgiBdf5qMmRKdqWrwVzLMvGob8nkqnZLW8kIF79CAaz9e?=
 =?us-ascii?Q?yqK23xshC0K07hf0bauKgGOA4gJByTr5LB2pVxybQrjxgoPP/ot3WI/MjXIa?=
 =?us-ascii?Q?2LNL5FREShyYtxLsbaERPBLCdhVIs3YdovDR3/TfHIjBqajBqjXyRlkAUvdD?=
 =?us-ascii?Q?Xza7N0li5f2Y9NNc8zwTB8SUyaiwZq8oJpMDueApdI/ZGNupC/xEb9PUYvjV?=
 =?us-ascii?Q?YCLweS/VNeH+dq5m08YDd5Q5FKp5FM6MI2S0pHN3wNM48LCBhOR94xqPAEZp?=
 =?us-ascii?Q?TR7+egeOeajMDcHeaBMLWO/zIbDsQBap1Nhp2IfAUuBXyM2cqZ0auZe0tE2H?=
 =?us-ascii?Q?UYGCQG3Aeakat+U8WXWq3z/eBcPPSI57DqXB24CV7quqVMHTcyNgXqSOIMd+?=
 =?us-ascii?Q?72jdLM/Ovyl5oR+/rNHOnhr2qIRsUhE7maNAhxesDxtHCqvmZI++ZlzP3+pz?=
 =?us-ascii?Q?WYqRlG2dtqjAP0mPjfLgpHGaxrZqxqnjeXnxQEn6+g6di2hQEuZBwuCjI9cO?=
 =?us-ascii?Q?acangsc9XnSGyToLPkIcnGHI/2wD4IM23bfHZpwWONe7+pO7ziz3fxLaUgzR?=
 =?us-ascii?Q?bNqX+d3/nRAFNgk/BLUXZstLeEf3zaX2TPh5z/gL0PrV/klXmIAiFbOenYy1?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7FUWX71pzFEk68SxTYqYjMzB0ZBuUjhO8ZDGvaj74UUhcEqsNVTLuDV+4C7NIN4sAFFn3pF/hLps0JfNGuH6zykUSkIiMXsUbiozxBbXGxfzOqGYMm2PFjZ38bDfsXcL8Ov/AVuvSfm9b5dyadQ58Lu61zkJi3V4IThr4a3LMIVOmnFaf1oF3pXw2JAjASc5VYeo2nt+Di0Cn3/VEuGvffXbAqdduwABREYB9HFwmgE/d9Chpdqza/hZYR5hgWw1DUNjf022FS6y2dSsb7A1vfMHuK6TnK0l/SnG9yYngh2hHrBs2SWE4iez3qYG84Gm9VwRS3uRtFuvPhvlyD1hs5AAw03efXaxJb7pqMx/Vtzs2bZxEDGrziqMR1svUOFQrW3dpnrC90FUXaYrIUDoOOpKKthsVcmcwCKKALJNhgCxkwHjAwY/BOY1EPBakZ7mwXSYuIKj7a+v/ZC3bIOKAp6urzMmctHmly0UD41Y0VWH7idiPU5+sxaP23103y4ANwJCBrl6x7nIV4npEbzo2VDn8gV2hZ6UGBmAEv2rP4AVG7iYTWvISMkCwqz8E7ciyGH5MhfaEkLchAvnU5bxQNYvpzmuJ12BunkntE+EUA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3abb9d8-aa2b-4d16-1a7b-08dcb247748d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:54.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C4OqGCiLdSQApem4PylC+qWr7pSTq3sgtdVs7Hm3Hb/8Fyy4/O3/ys71v5ZwzVqvDsdJWzWK/M0hlr1TCV9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-ORIG-GUID: qJ0WyqSyhTAGzsqbdLZzCwftgqDAqkdh
X-Proofpoint-GUID: qJ0WyqSyhTAGzsqbdLZzCwftgqDAqkdh

In xfs_bmap_process_allocated_extent(), for when we found that we could not
provide the requested length completely, the mapping is moved so that we
can provide as much as possible for the original request.

For forcealign, this would mean ignoring alignment guaranteed, so don't do
this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index d6ae344a17fc..d246b15160ac 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3491,11 +3491,15 @@ xfs_bmap_process_allocated_extent(
 	 * original request as possible.  Free space is apparently
 	 * very fragmented so we're unlikely to be able to satisfy the
 	 * hints anyway.
+	 * However, for an inode with forcealign, continue with the
+	 * found offset as we need to honour the alignment hint.
 	 */
-	if (ap->length <= orig_length)
-		ap->offset = orig_offset;
-	else if (ap->offset + ap->length < orig_offset + orig_length)
-		ap->offset = orig_offset + orig_length - ap->length;
+	if (!xfs_inode_has_forcealign(ap->ip)) {
+		if (ap->length <= orig_length)
+			ap->offset = orig_offset;
+		else if (ap->offset + ap->length < orig_offset + orig_length)
+			ap->offset = orig_offset + orig_length - ap->length;
+	}
 	xfs_bmap_alloc_account(ap);
 }
 
-- 
2.31.1


