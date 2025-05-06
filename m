Return-Path: <linux-fsdevel+bounces-48193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331BAABE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97619520AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B9F278749;
	Tue,  6 May 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+5Qt6g3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s59UFlXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E334272E72;
	Tue,  6 May 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522337; cv=fail; b=l+h6zfj3uzEgXE4sdD758gSADY+yOjEj2tnYGKhcELPbFhI1s+aiSy7ir0b/B1oISPnuIZdN6ky5FB9C/iOdNAyQFsLNLKr+vzYzpF6FJ0gMdEMt3riYgcjS8wVK5yOZL6Bd2M6VaZIMo/JhJmJ5DLUpiBiaEvcngyNAw+XzDh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522337; c=relaxed/simple;
	bh=wm7rSgXjAJHQhi8ehc1aU3KcZ144tJmRrGCHWg7nJCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwDaqU8R2hqXcFxv1J5fJC+tt9wobb9FoLD/01DXkdqtimPoBrLOMPhlxGjusoQvJJaQXBv3LinqNsmytpV5EuddZc5Xxx5Vmui0qUXLejF5Z6ByVmE0+Wlzq4HVqYOzHhCsH4jnKhQHAWVlQz5GK5+q7i3gWg1xEoVxELeaEP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+5Qt6g3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s59UFlXY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468bdwR027357;
	Tue, 6 May 2025 09:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=; b=
	Z+5Qt6g31HvyOTebJhxMQCgqx6AhPtDxr/XbyeXzsvYOq3NgWskia3EmF301YtnW
	nlZvbGKuK2a/Wvh8t7tCwDaffRWMwwak6pgf+JfzAe+2gDNPJMFkfdTo3losixlz
	8q1BH6ZCWguxbGp2/3t0s+XZ24x9EAXmwsu3QS7izDrZKnBs4dnZvsZyhT6qbxQS
	kK/FAO2WtebuCEQWa56EDh0wTEb9WN1unYgb4645NYHVGG6uCfnhAt1sliRcNV6e
	lPtrESs+FcT1eymqo9RkyudrobYRfx6YS1NwHS33OsXBHxVSP8FqeX7vewVIA41d
	3B7Zd74l0Ozj2FEb2R7adw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff2t02k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467hOB5024461;
	Tue, 6 May 2025 09:05:20 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf062x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuyqg5XlGa+I3TRVeslpXL/xzsQgCjTIfK2AIds+bWjl92iRf9n+JcIc/9tWmyzMiSPVUhB4mD83uQat5mYw6QXPrCX5sbHD4aLmnvj8wScIH91NEfD/Yb5J2pTYZN6rqqmX8JpdAelpCBOnJc1G8vI7X7a7weqsuDyukQEZrGeSQHQSNSnXBB9oTDFga9uQnlvNb1OMnnYOaoZHniavWHgJFm1t7xzMHmj66SkP2Q3EYFyI46CQj9kqsuF9g3b+VsvX47mB9ZYuS+BUTHaUb/V/cjhvgz7LvLH/gdSEigpR8vQE2Z16DDNDRcy8PNqBiXZvidT7kWvXeIGqWmrEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=;
 b=ahqmd2O3d6R8116Wt6q0HLqKNtOKT4pCVa72MQa4koW8MALvG28UEX2cUVZz+4N7s/Rpx2KJIpK2Du1IZi3ni0cqEI7EI975Lh0oM4t6ZfOV03ExUXlKgoi6zgbbq47P2RAY7zjm+QBIo9Q/2ldBzp27sGrciIYrguBOLgLYSv5NA+xbnbCtlNSacUWHNYZX6Euy9itAJ8/Fz64hrODmQFc+Q4qDBvg1VspaVW0SGsNDCUNBv2AYGctAiZ+mmO28Y5lOeusir9Od+N3yOftakmTtWk+fPBqsgR24Oxhcp0KOH6SgDFcSS5gQ8i0rvMq32xXuQTaaFoR6jj0KWEloSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=;
 b=s59UFlXYU5e/+RNWw7ddiYopVvVROvtGeLG1MFaMsin1U2Sb1CTXzhqlcqmca6FtvEOAoKj7zN4SYnMS9HZAxYC3DBzOvX46mIKzMW6ysyiZimfQrTCMYo4dyRB00dY12L7hwohj90DDVQBX5X7le87Ogh4ABiT59S2we6LlB6o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 05/17] xfs: add helpers to compute log item overhead
Date: Tue,  6 May 2025 09:04:15 +0000
Message-Id: <20250506090427.2549456-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd69058-6e6e-4697-116f-08dd8c7d1bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AW/GkSkKfeI2XVscEHbjO2p7YbTj9BHUc55uxmfIw0a8lxq07incCzK3cOGq?=
 =?us-ascii?Q?QWw9esR4QFo1A7ieam5wNbFIWh8FDQ7Xc3MxNFuUAkF9IAAFDdYVTmr3gn2Y?=
 =?us-ascii?Q?7i16hE0hTnuYfSIex3nGvhKFXHeF1voaFG1rWTKJ3Q9Lvy+J85VNoaSpbDvu?=
 =?us-ascii?Q?xwOics2EhUzFwsB7vsPu5PZVznVEZTVO88v7dkRVQ8O9FdU0lAzNZAXvMmxQ?=
 =?us-ascii?Q?VE9G0b9KLznfNUo5IgxNOSdG+a0ChLFgWciYQlCXTx2LP7oaLo4yvdYt1Y5Q?=
 =?us-ascii?Q?dtEYPaiEGfgm3fmO3xgyTLqpsO2EDCMApnMPu37mvEh7G2TpX+LFYJTM5a/s?=
 =?us-ascii?Q?W17KpBOAgDhm+MXk7C/3caxwvztDjTUhfkd4CvK6Uvt76j/e+AeW3+hR4O8P?=
 =?us-ascii?Q?zGK6YZufaY9Ejy7cmwd/emb8W+ZLsgog+HwcJVtiyZ8tkqGDspTLTorWU5Ln?=
 =?us-ascii?Q?CB8RcqWaMstIp9LqZMOiincyVnd7SKKFsqyiAt5hST4YErKPCimx8P58NrTB?=
 =?us-ascii?Q?p6goQm1kSGWnooAb/pQ1TAF3BrJ7W0lQ8kvwhk/dgR7atXCZX+zoB9VwVTud?=
 =?us-ascii?Q?rdF3o6lQoO2vqJzcLpAzj5HfxCZbY6x29I3oBv4PuzJVgjPZWNo/8LJDHYMq?=
 =?us-ascii?Q?0ItqCwZsC/jk/KPplnnTVX4snIpV9pXwlF3XFqySAdY8Dpy42P6eR/Uh8hfr?=
 =?us-ascii?Q?NQpe/D83kt/2UB+Y/ILAPB1jRIcEQn1zjdWFfCDyOkCAIvV/a/tBgXKMFeRc?=
 =?us-ascii?Q?VxI7oyMYnizTdRyEuXCNeFFxx4qKllT08ZnXJtvdOiojRuMNc0qf0Yl/DTgd?=
 =?us-ascii?Q?nY6Aqq9R604kF6sBK9NAE0Dy1PYx6+VQ2MwFIZA+Na6SeegGVWVEGVTCvHFu?=
 =?us-ascii?Q?ps9THNWLPZonrdlrbJDq/YFSpV+/EADIYEYc+D+b8TDNAuAK1bQHcQJiEwnb?=
 =?us-ascii?Q?1v6Hqd9XW7zaZORyXe7rVEkXxwDeSTe1OpssG1qtTKvxGPoFsV6oD06ZDwV4?=
 =?us-ascii?Q?19g03vnhyXmnwbxjP0P1c44vd99dkxV94QN4wUpG2y8dddl0Ys4z0jG6H8AA?=
 =?us-ascii?Q?gVS39xMS05gebXZmpRbThONE1T27J/ZnGGdojwvUDMYlE2c4xkEjoVp1kJFn?=
 =?us-ascii?Q?9hmR3yLdlLkKod8u7gy0+9DAC8rJSqiqidzmqMTNwjIjoEDBSIgLWdALiwg3?=
 =?us-ascii?Q?rsStLiP3+P5Mu2Ttg6mKpIBmlhOm4uiAdcZZvNFGUcNU2G+S9aOyx5xVy3Dp?=
 =?us-ascii?Q?LZhaxiGO53IXKYzpd6waVk5ui4zM6cmhh7Pu314gTd5ECAvg65/D8NFORAun?=
 =?us-ascii?Q?ts23bqUOeCFI/320XlIHkroodw+hfMn55XEtdcu2KYyMMLbTcdAQPrnswRJu?=
 =?us-ascii?Q?hpT2X2Htg335CVrE5mhdty8aNE6rVTqjm7lBnaAFgH/HVZAdxX0iXL1d39GV?=
 =?us-ascii?Q?hvpXFpXzAQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A3cCftc2ibY7jZxWBi6incpgAXVOKE/pqGvQVzOPpxSCKONzUX7VaAPTQxoM?=
 =?us-ascii?Q?ORghu30UauvEUgWxxhD++p297zQ7bkqMKaCUAQFSwxYX2acOzu4eZy2iaQtr?=
 =?us-ascii?Q?hGUp9wXzUWreTlFyA08vOcgtbOydg5lJJ8RAXfQHYqQfsQMs9Ar5EryRy6kR?=
 =?us-ascii?Q?LHIX9/+gXeDfpH3KptX/kjK3TFYxy1Y6cHhOAXXGrdNGEmkaQT1T7Ltl0WMu?=
 =?us-ascii?Q?5mZ66laThkwGHSJj/E8No5oPEg/3Q9rhiiAstWnZGOiCezW0Kk7CvHoUnuV9?=
 =?us-ascii?Q?OSM0+ZNNr6V7+huXh+nwf7wU3ylg5VTEDCnqHAovHFpYXXyDe84pyYRKf93L?=
 =?us-ascii?Q?uIfugfiHXAxb4LSa4aU9WPBfJ/G9QqC2q6e8ppBRS9sMogOE5Le77H1P+FPn?=
 =?us-ascii?Q?lfJx/W6ZpHbOWKL8L7xdYMd4kCd+sbRIqLBQEUtWZfJoBfwsqujlwMMqT7Lo?=
 =?us-ascii?Q?C0Hk5PM3LedoWANZwGxTWWCO/L2Ear+1Q/bN00Sx4Jcv/zVsjT+1VD1yB3b3?=
 =?us-ascii?Q?ivdl3jJdeOHsYVqOSWepNq+IEymWaoa+ioW+pprJlAN0g9R0VJxh4FR8gszJ?=
 =?us-ascii?Q?mHRawxF03WOoVJehzzxFt4+Bad21wY9iFsPt7+KbgfEi8Kmgqk43ozzz/saF?=
 =?us-ascii?Q?uf9oEZWJqDFCKgSRajFLd3w+QgKF8AHKolbgMf7328Agqs4vmh4ai2ZMn5y9?=
 =?us-ascii?Q?kaC5wjz+yfswSv0VmGTVurUND9yyCXIXd7We14vgCGtBmifmcGsuBgusNFiV?=
 =?us-ascii?Q?mHlWm9SER4aub6GMvuR9YTn6DRnlG8MshmEMoXDQKRnk2sv3ReZSln43q8yt?=
 =?us-ascii?Q?5slmk/QffiwCRJAGtuMfSYv8SvU7bKc4P7/9WBfsQNIJCA26333tEWBrjOhu?=
 =?us-ascii?Q?I2MD7EBgwL4T+zSdXev4poO2CzoD0Blcp4nfF1UZrYbzdho334eQfRMHBPzW?=
 =?us-ascii?Q?By6GP5/WKhRjcARusl1izgw5nxp5mq273+/aB5dolT+koYTpvjPEB6ScBQvg?=
 =?us-ascii?Q?wQq7dLUnTxlut8bkNzFSMclK/KyKlgRBaWmBGKgkavFHKS2eupK6NVF+0ZUY?=
 =?us-ascii?Q?6XPnxaBlpSmLTfNatf2awaa5l0jp2apr9IYsyDvYMrmSuPFcym26EFWqd9As?=
 =?us-ascii?Q?NCdD/WkuMySqiMC15Tf/6N6ooZC/KXm0YLfKOUHWFrR+uPCrvcNNGZchhuC9?=
 =?us-ascii?Q?93Xw9x8lhBiVHXcMiEQVl+pU1bGQkiVPSZ5tSm6qb6fh2igVr0LjDuFQTvU5?=
 =?us-ascii?Q?WgysWQRzWxS0zRm8cHC86+w6V/6uywgGOdNmO6YmQAWfPMjSt/7lC7j4HZT+?=
 =?us-ascii?Q?mG7puC2FNETI4qKdAwjIvgWqwfWa/duK9aDEuUsmLn+a8KtGp7AXXBkIp25v?=
 =?us-ascii?Q?3Gw0dpf8dB/76howOeac64AsKBZsI1/UFbo3BpXVKXTLZZt+3QajmT708H5C?=
 =?us-ascii?Q?x5cfwybCH7TuMIrqF4SEc5ckGoSWKiqWowLi3/sNILbHWebK8M4DnajG3ABc?=
 =?us-ascii?Q?FV0cY3kiIBZFbAKM+Gd2dJdsGK7AHFsu55N6dX70hJctxVimMEW3dnmT6E8r?=
 =?us-ascii?Q?VyMpjJcP9mwJrlt0ofP3d/0JFahCcywsaNzHYoeQEfw0n4HKYVW5bonRbxWT?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mgSdIT/0GuAt2fAi0bEXRB0Qr5q63TSWbE7ygpGOafvAPQiBPYBIpZjfRkvvQvSgUr4K5K+HBzVOFvNivty7vtKjSOTY2xo1bm1g7rPUhXWVmqw1DwJbO6l1f+dQPPoP2/snTberu/134wAAQ9tsCTvKYseQUEi/AabsHT1j9zhMVukek+dQDZMgAI8iH6YvUz09S0FaDXH3i3t9cSv0Ydzrde76HlLeP0q10Va147kiYsZqmCYNmI/1sfLEJwlnLYz8DNzCwzx4zM81fIA9zm33w9HuhPT8fegJ8gHi0dA8+ujjbBzDY5GUzHbuqcTkc2CaqWrBrl7JvQcGc5Y4/GfKuzf4DWxAMuhMQv5OUH1s5MK4mbvs5FtgQvVlvtcAEKUPaytgxQ3nnmZobq8FaH5HxM6aENr6wx2EUw6zBbJJi/ZFgJC3h4u8VYs3lZvHmYEv2UI8IWUttJ67Gvxxr92QkjTn00/7K4kjem54BF6EcvGOG0j1oz5BhlpQzzgvAo8iIA2LohkZAnwOH1ARJyChkOLu8nmX8vtupRa6c8tPIk76K+In3xXpfG4rjU867pwbYsIfOfNHcPLJx01/3Fn9z1c/1kamFi5F67okX90=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd69058-6e6e-4697-116f-08dd8c7d1bcb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:12.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNtydR11N0R2PXh+8y/J2vYMusETJyAKSg7ic78e0uVnsHRuK8/NyRUWVNeHYIBx9XkFFclrFcmkxmVcCciacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfXzothLmw1XoOE hasZrpr5EZ9RvoaY+fFYiRb6t2nQ3AuLlwo6m9qI6ys5eLGWscvaKY7ewJn/Umu6kEcftXvpGaQ 8U4bH51PK+ektZY9vttO1oAmH4jFg/J+3eMMyu8frePYGqfxXJzgnEZRQAY+v0iGTdSQd8jZJyS
 avSbADNZ0Yh53PVEuIb6AOaUlY9Fj9F3aW8fAJ2IusOMHaO7wY4G1FinWSgFGh6YN3q74kq9kkp zHIf05FDwgBeSWYEOnhlp8D6mcDBt4K7xlA9kbWegbDFjP0FHlQc8zBFLWnf3EIrdDwB7UhSJPR xQ0JYj+09VWqpJQdB21XWzIOUDhYArJXHuOfdCR080woK/OGoTUThWHjLTfBJk6cF/1FQbIECJk
 hZjSK76H7/2nCMhzN8rS+BSpgmYE9r1CiNTE63bCryn26sEmVu4k0St9pWKNaqPKmjlZOxEM
X-Proofpoint-GUID: 8DNplI7PAIKCXh8XnzMr3oLSkCsV3VaU
X-Proofpoint-ORIG-GUID: 8DNplI7PAIKCXh8XnzMr3oLSkCsV3VaU
X-Authority-Analysis: v=2.4 cv=Xr36OUF9 c=1 sm=1 tr=0 ts=6819d0d1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6KFWBsMsv8NWCX33yDQA:9 cc=ntf awl=host:13129

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h     |  3 +++
 fs/xfs/xfs_buf_item.c      | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h      |  3 +++
 fs/xfs/xfs_extfree_item.c  | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h  |  3 +++
 fs/xfs/xfs_log_cil.c       |  4 +---
 fs/xfs/xfs_log_priv.h      | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h |  3 +++
 fs/xfs/xfs_rmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h     |  3 +++
 12 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..646c515ee355 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..b42fee06899d 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_log_space(unsigned int nr);
+unsigned int xfs_bud_log_space(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..90139e0f3271 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_log_space(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..e10e324cd245 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_log_space(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..d574f5f639fa 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..c8402040410b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_log_space(unsigned int nr);
+unsigned int xfs_efd_log_space(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..076501123d89 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..0fc3f493342b 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_log_space(unsigned int nr);
+unsigned int xfs_cud_log_space(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..c99700318ec2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..3a99f0117f2d 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_log_space(unsigned int nr);
+unsigned int xfs_rud_log_space(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


