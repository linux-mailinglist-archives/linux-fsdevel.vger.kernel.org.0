Return-Path: <linux-fsdevel+bounces-36937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D2A9EB180
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D216BC91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20D1AAA28;
	Tue, 10 Dec 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jbc3bnFg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hK8AzuzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566241A0B0E;
	Tue, 10 Dec 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835637; cv=fail; b=qY6Fu8gcahARLzbuXigvjKYvCKpkiZjAyoSN++LCRwDtbfPlo764GVFVFkdxfx9O9Yp6A5lowCgrLDwmnJ/cQTyYBCJWsaZb852Jk9F7kTua8fRBGNoJdsvB8lGMkfGyWawoRtcvXriibVfoLuR+IbWJM1AlHd1TiMkM/xrASDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835637; c=relaxed/simple;
	bh=45vWlUnI4kOtYaQ1MmTnwY6BIs25J68EBldk2NkAmOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JzNn4Jgb0+faG6EIIyHO1i9JYaX3OrV9xtCVPkGN44aj6EpVkTeVoDPP7nBklBCUZjvKak0CQ9yqe1TwDt+utKyPvb/Nldr+2HsHbb7/4SEO8YkON/6SPiRF1LR4x0e2pmzvpYaGSPGjaJHFqONo88d7dRsxozZ8gAyJFSOhI+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jbc3bnFg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hK8AzuzM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABKHDN015769;
	Tue, 10 Dec 2024 12:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aapmy3MStREKbjTIJgXd4R743uNg2RINCcHjKmKi9sA=; b=
	Jbc3bnFgIECZjiG7CEANSYUB80Lz8TQKV7MaDPWJJNegSEWYxv2pcqJKOPaiatw1
	cV5gbOetAm25Wksb8FX1qfLEkXvaHB56jqHNt8Bsoc5rBhh+NrxHK81xuxzjC9Ib
	Pu9BnHBC1Cw43zXrdMFfb0CyBQTygtZ6hTGhtcRnGfpPgg+z/vYi6bqkiSrKkFMS
	wcuQcwnn9s5pRqqVWbAG/LJeMlsqQBRYCGB8sOQ5HedwKswy0qLW1vVeQJBn1ycu
	s4Bzo/k1EQKdjRAycJkwOkiUO7R8HKqizxm7rP0Cg1TCTZrPjiZGInmy/G37ksMH
	eiVoUf76kK8m153l5fjxlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc5r65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABnpXB036434;
	Tue, 10 Dec 2024 12:58:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8kuj2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jr6wfi8hY17TeNbwt0/B1ENfg8Ptj36LgX1LSVITSHNyk3NNLH4QUA3JLALQYb0qXtG74pwSPuaiCfnoy7+NPyH+3lpYdHivlVHUaaDUc8F9sLGpzvhwQFk/tJb9WCXe6eg+Qb4glUOU7rTX/rr3kqzWYvtcbc9V9TyEOlLzwsfRMkpvuS8po4xwUWoSOuEsjAFsR6O9Byti+nvvwMQtWFHjB9kk+QRxs3N1gbg4XR03vk/yfV0F4eNNU8nNIWXUdqCVWhWHiuNIa7MJaBeGBpMebNP3tsywInGhMotINsjm4bTSh5j1FRTJx3ZcSe+wBFH0dm+63pbVGRz9jLx7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aapmy3MStREKbjTIJgXd4R743uNg2RINCcHjKmKi9sA=;
 b=U/2imVuc2XgreJk5PXlhyJPFxNep2Skheke49Ncerv+TIoHkSzzTQYtYSgblf/OO4ft/X76P3n9GKKyivhF7d1fIhm7yab7RK+CSng3XGnIEK7RY0MlxyyibeA8mwZIOGYqFXYskvaCSExehS+352WGeaY9Bb8OTV3FSGw+45baINXUfWsulpb5VTpXdLD2QTW1zkXJmQ348oJX2tF1aIrqQUWfUlYixQppsraf9YdD+hytRH1uWw/s6IYWM+Bq2k8EWcb5T9D9nzxw9H/CgkOWOlLBq+MqqD4iMavkYo6tzhQ6mLPRlk3+xmir6hfBlPUPqw4fk2XyVwqcEEG4hcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aapmy3MStREKbjTIJgXd4R743uNg2RINCcHjKmKi9sA=;
 b=hK8AzuzM9Uf5+/r4PeGCTLxND+xo5cHoy/2l2p/7Oh8jDkfEXlmJcIJB/vl19pFCNXK8bMMTyH9Ryl1B9H4VupEBkXySg+atDbUAd8AIwt2409h3nUJ+H5AwIMbFkffk7AVcBRY40u5d+rQTp656e8Uevy4UyrNvqqunsKFiyzM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:58:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:58:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 6/7] xfs: Add RT atomic write unit max to xfs_mount
Date: Tue, 10 Dec 2024 12:57:36 +0000
Message-Id: <20241210125737.786928-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d7206c-75f8-410b-aaff-08dd191a4b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+MmhTyulF8CSC6z3ynz1qrEQ7x90vzsXH99SJQ75Y+Nc06k1aI/kX0EdjT7D?=
 =?us-ascii?Q?vcm1bm6a6Rlr77mCVEzmjUCpL7/+JG3+eA6dNWxdbH53+jRl60jLQVXVDwq1?=
 =?us-ascii?Q?6+0pcX8nDGFIBwgl0jxVSoy20GzKsHytVJBp1UvForiMXZsVNPl8CTydhC2S?=
 =?us-ascii?Q?olI7V0e5+IJzzDLNevjxD9jWM7r+8k0kFXpDeuO7tNMT1Q7KojKOI9R26Bmb?=
 =?us-ascii?Q?RVbQ2tVMi8G6/datjN26PHHT2XFVle6/HWSUHJKQKDpywHjHNB4DazEX0tLu?=
 =?us-ascii?Q?F8UxY0jVJG6RY/gPax10wPyYi7Hhxi+WTBVi0LJxVyDWX//YCB2dqObrkHrv?=
 =?us-ascii?Q?BQLthyuoyP1DfRUbXHzjfWnG6qiLQeBi5v+SDb8BfxtBV1OsmX40eRd32ocr?=
 =?us-ascii?Q?q914wobnAjoPPoBNLruH77afy5QPELe6XD/9XJXS6T4dgQ9K9IBQg324g6ui?=
 =?us-ascii?Q?BEg2wbJtS9D1AV1McgE/cQVBa8EPvBWHAvZOBbn6hjXxiHUGIa6Qm5Irpw6d?=
 =?us-ascii?Q?dn2sdqQvXGdOWaVnNg24kGzqmQghgJfeQYoZYYwoo92qkgRTcjMX1kr+/PFy?=
 =?us-ascii?Q?4ZxY5St3+zAHZ0cHHJk17YFvpKaDJUJIuZljrbYnsFoeidHPzNOkbLAM1MZz?=
 =?us-ascii?Q?RZZ8cKQ5XgZ++EKfSF7ArChjg4+C5UQY6RGW1V4gcn/7Bh6Q5xBAdB+L9O2g?=
 =?us-ascii?Q?Xfpt3oBQNGdwp00PNuD/BsMvm8UR0tbKx54i6MyGPZofCkVBMlquOHUhpPIh?=
 =?us-ascii?Q?C8WD1VdMitzpT/ZhvtqkYxwdEBMxaubkbvmkenbvLgwNtWHGqsO9Bmmm8EL+?=
 =?us-ascii?Q?KXfqru0e8wHffoZGFWarwW1byIC+Jw012RRLAVpigmg9lHPTgb9Qp9NDOW1w?=
 =?us-ascii?Q?9zm1+BUsjpsL5ZypZBbtXpvEynwBEsv839B2fEkweMhSC7vfkBop08pdq+cg?=
 =?us-ascii?Q?Y8nAg9Cbx+en/JMlsnaC4RtBdTYT6QwJtA7Y7GhtTAwvI7DUIDhlJq0HnvTw?=
 =?us-ascii?Q?BOdzTCsbjxxIVG8Wo8IZHcP6eDS960hFCW8gNoLVduYFzfmEmAJ0tQDyjtf0?=
 =?us-ascii?Q?99NTzlY8A145YwaRR+rhiuMN0xQmgFE4eMa7qwLbK97bG7fEuamdZwSdUtki?=
 =?us-ascii?Q?qfb1ydS9IRtWPxp7FZv/0+8e2a+lhPfjVqZYhvIDLJtiG+/3498312hAKoBG?=
 =?us-ascii?Q?B08inzIZnYWg8e4fHD/4Ps9ICUugAb7N5nIirZ8PptvoplmOfY4XIaB8X/jU?=
 =?us-ascii?Q?akbfnmDG/3JF4u8wRFpLe5DY9DmVG9Jw3fmeppNTw3Z41MuXA1t4Jep9PZJv?=
 =?us-ascii?Q?bjbjKc6SBPJkr0BbT2kSk68UHLAzxgnCqdOBlwUDp+lu8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxXCiwpcdDWXQRWjibFT/gIhrFDJ46uov9Ls9ptQUFJyXaYA9Yv61N/Dk6xG?=
 =?us-ascii?Q?vFZUFp1eMSiG6J7dq6txuTqHNY3388kUMF+xITds4P3uStzaBI4Y3RonH5Kd?=
 =?us-ascii?Q?D4SjN8ZHj8gf8gWzW+1+qufPs4SkjfBstPqUrlWITIMj7BiNQnaK0idsVL62?=
 =?us-ascii?Q?SBpOCNCBa5LTrvpq5mv8l4c8aB8w1dto/mttjn+03K1ctofhH4uDPKTzgm8I?=
 =?us-ascii?Q?f7+dmjlVr11hoI6+nwRicC1RmyIHhM8elIPxyFYHTKTpiWNl29BSaI3L+8cF?=
 =?us-ascii?Q?UypmgSf5La8L0IuW09g1hMqMXdSqcSljKf9K5iHelbMfulanpNuvL9/zZLf8?=
 =?us-ascii?Q?m3mid8NAdJ5dSeeuK3tkcOJHUO2T0Jb1TSHCeUrk/LoV48tsA6W1i7oNAIN6?=
 =?us-ascii?Q?+F4VQcu+8sJHE+g9LX8qiMnpySmwL1LeLzIQAeoBraJKzjPah1cTNRTJ3Tpi?=
 =?us-ascii?Q?Jgy4W4nTTD1YOTdc7D45cLRoH+ip6KWGjzcJdQknoDnnZ9vsYov4KnITOhch?=
 =?us-ascii?Q?qbSRS6AFyQBGGOXfBW4FA2Wav317jM4PO1FZUMb+9af6Fb5I974PzXDGYx6G?=
 =?us-ascii?Q?3sRowgSCxlL1qy9c5b9Q5wyy6+kVp/i8jK2yK+KifFp1wnAGcwg6jR13w1u7?=
 =?us-ascii?Q?nnlaNZoNRu7GXHmJLdAfFiIgiAtsp0sT0pWsQrmbyc0BBnxl1FP13EP06cwe?=
 =?us-ascii?Q?dC5eg/d5bYfvsz+VZ8mgXCzMEFi/OlS9CVeToIBGGcoeow/PAg0abeKZpb9q?=
 =?us-ascii?Q?7jWw41ml1bNrtQYPtT4Z2rDySdl2MGLgftocVoJzGUObGKTjThVyQ14HrbZ/?=
 =?us-ascii?Q?UglMCIPhbd8L+dMuJXuiGBYqZs1wab2ozD7kEv3+BGkGai1nrtmbpf9dbXRk?=
 =?us-ascii?Q?CaxlEyWNyf0AvoLkT4dHA2uPlY9mhgYgxj0pcvQPSJObQFx384Vp1/SLJL/B?=
 =?us-ascii?Q?ypiX2iqhilp5q32c8yevx8rP5j2D5ePcDs3zWhvCkR1/jt53HVwejVY5o608?=
 =?us-ascii?Q?fYDQNtk3ziXhKWqqWzxX21eByOFSI7qqMh7rtouQNky3HrSmVBNOsbannSuf?=
 =?us-ascii?Q?UAL2xBjXlYCu/f9dN29dONSfKrzgz/RXqX6wQZ8qeuYN0XulTNXU+cxcJZh2?=
 =?us-ascii?Q?XVKfFNMhqs4+0kzAGucUdtWSakHcE/SQPF/m+FIr/BMwk/U6Ujz4QfffmaaF?=
 =?us-ascii?Q?gbycZXSkqLQ/qMc6EJM974gz5Anh1tkSB1gC08AqsMtQf1gfZk4rMXxJZZjx?=
 =?us-ascii?Q?9iqOo9Rc2pcaXlcun6TZHULqxTPdj05QCnAUC05dD+T/Fvpd1xGNbhI6WvGR?=
 =?us-ascii?Q?Jfa7K7O/0HKvc2rTAvO2BesOZKTzrqLeA0oGZ1BP0I4Aba+ayqt4GIeA61ny?=
 =?us-ascii?Q?JocFR5qM85OGqM7+zkgFn4nmuPKslhsbvVc2V5fiRH5C6Bi7Ml2WmdqqzQJT?=
 =?us-ascii?Q?em89jF9HhEoCe0EmZd89vqMBb65iMCB7C3aXzkLbhhYrAcwhrEwVzghm/MUK?=
 =?us-ascii?Q?oPjImK61mLUscl1WMEvA2HmSTqY9v3QTQIHO1G+lMy57/Js2u6/K0A/AXqHc?=
 =?us-ascii?Q?ItLDReCTRyyb11KFwXeOQGzRRNKd4JV69lVSmUsvnv9Y8un4U0IUDmzx7BQX?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uhLcsrhzYDrfOaERYRqz8S6CMWy364sUZHAuMZF+DtCrrs3VXf4fjOP2vbvgUhmRnFwhE6o9D2hRBTseyfYopvQtM1xOGRdvtG2OvRgtJTxf9tCY1NzhCK59CeKi1YfL2sv5Hg0BFfgzACAmPviz3IErpFS7yzsyQ8r2RRNcNEB5rCd19tZbJyVSzNVJIDhmkHQ6LSodaFxbjmSt0PmKhOaQFG2XeQXtTyKnG8k67NWh/EgdwHqHjmJIuIMdX5bQC2eOxQtGEBMctHLi4jbmNEju6dmiHOa5RKns9rRqD5NAtys1mGyf8LZ9FvNVi3hiF7at6qaVuz1EQBUjbdtlgKy/lDbdp9mLgZtaNulqZMqzYU0+qkZWL5uHaLlkI97b+1nOuaZ5Dc4KuRpKrTW+KpDAAsfFP2PC7Uk1X4Gd/PLOvQYkBN5R+o2C5gc16rVO0rat/bXzzOpDrn5bFY/Jd+lLRWim1Y9lGnMcTcwrMaGYlCC7VWe+z7MNDjTZXlHpiFKHScMeSPvOsW9Sj8wEdwEtX7pvm1x1Blv1Mo22xo0CKQ+hirAaSbVBpMy0vq8mYYbBH3GGHbkZhynjm3EGhzvkhGFhkWHTgkEz/2kUWl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d7206c-75f8-410b-aaff-08dd191a4b72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:58:08.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzR5N9Lex+f0h4Uubov4jTk2sgBy1h7UtG095gfVQATkf5W9IbCgfBTFzolg2mzs0FeA39Lc69j/h/Ee5onPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-ORIG-GUID: OyX6LgvSVg0TlFR2o-Zm1cH_jlAsVKbX
X-Proofpoint-GUID: OyX6LgvSVg0TlFR2o-Zm1cH_jlAsVKbX

rtvol guarantees alloc unit alignment through rt_extsize. As such, it is
possible to atomically write multiple FS blocks in a rtvol (up to
rt_extsize).

Add a member to xfs_mount to hold the pre-calculated atomic write unit max.

The value in rt_extsize does not need to be a power-of-2, so find the
largest power-of-2 evenly divisible into rt_extsize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_sb.c |  3 +++
 fs/xfs/xfs_mount.h     |  1 +
 fs/xfs/xfs_rtalloc.c   | 25 +++++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h   |  4 ++++
 4 files changed, 33 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index a809513a290c..f59d48f6557c 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_rtalloc.h"
 #include "xfs_rtbitmap.h"
 #include "xfs_exchrange.h"
 #include "xfs_rtgroup.h"
@@ -1148,6 +1149,8 @@ xfs_sb_mount_rextsize(
 		rgs->blklog = 0;
 		rgs->blkmask = (uint64_t)-1;
 	}
+
+	xfs_rt_awu_update(mp);
 }
 
 /* Update incore sb rt extent size, then recompute the cached rt geometry. */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index db9dade7d22a..8cd161238893 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -191,6 +191,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	unsigned int            m_rt_awu_max;   /* rt atomic write unit max */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 0cb534d71119..3551f09fd2cb 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -735,6 +735,30 @@ xfs_rtginode_ensure(
 	return xfs_rtginode_create(rtg, type, true);
 }
 
+void
+xfs_rt_awu_update(
+	struct xfs_mount	*mp)
+{
+	unsigned int		rsize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
+	unsigned int		awu_max;
+
+	if (is_power_of_2(rsize)) {
+		mp->m_rt_awu_max = rsize;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into sb_rextsize
+	 */
+	awu_max = mp->m_sb.sb_blocksize;
+	while (1) {
+		if (rsize % (awu_max * 2))
+			break;
+		awu_max *= 2;
+	}
+	mp->m_rt_awu_max = awu_max;
+}
+
 static struct xfs_mount *
 xfs_growfs_rt_alloc_fake_mount(
 	const struct xfs_mount	*mp,
@@ -969,6 +993,7 @@ xfs_growfs_rt_bmblock(
 	 */
 	mp->m_rsumlevels = nmp->m_rsumlevels;
 	mp->m_rsumblocks = nmp->m_rsumblocks;
+	mp->m_rt_awu_max = nmp->m_rt_awu_max;
 
 	/*
 	 * Recompute the growfsrt reservation from the new rsumsize.
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 8e2a07b8174b..fcb7bb3df470 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -42,6 +42,10 @@ xfs_growfs_rt(
 	struct xfs_mount	*mp,	/* file system mount structure */
 	xfs_growfs_rt_t		*in);	/* user supplied growfs struct */
 
+void
+xfs_rt_awu_update(
+	struct xfs_mount	*mp);
+
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
 # define xfs_growfs_rt(mp,in)				(-ENOSYS)
-- 
2.31.1


