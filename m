Return-Path: <linux-fsdevel+bounces-42989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D367A4CA25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BC517A5C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BAB22FDF3;
	Mon,  3 Mar 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U4FccVx6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EySHJTR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37484A3E;
	Mon,  3 Mar 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022948; cv=fail; b=oPVHSHlO/AbjykOHsbQnri5hViV64Xo6G1s1g3NB1u7YJnx+BGB57Z3VdZI8PA58nYqDkc7COWF/YunZCXvtj4VQuoafF5+iWX8Q6h9ZlNQc0rEKK22Qb1cxFWp5vs9J1clurQrbjbwPBOAaOsecr3C6Qy8Dj20C5++Xcft0mrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022948; c=relaxed/simple;
	bh=XUCvi7W/wKRGllTerUhiWkgUoNDOdDFuOqAEQnvVbXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ch+c4lAkUjMqtBdlkM/LNPMa5uuYjweuFWraDc439P41Y0lQxTsjS7XdehM4xwoNMvO+A+rKpL/CtypbGA3TrYvSg16FQG3fl82MCzAr/YfTrHqbUVHIG1B+Pk9+iBjzpXHP9QknKP4wPRkIcKlgMQ9ldxO1bTW3iSE4dWYPdZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U4FccVx6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EySHJTR6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GA0FL030059;
	Mon, 3 Mar 2025 17:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MkvMvt99JAoTjPuUnJ0B2tU7ZIeBkXdjnWNGvQTsAf0=; b=
	U4FccVx6FUNmPgnPTGouiK6N1heOgh1sJtc5Ad0C6s/UfDLoEbhNE6Q7xRYK0q3n
	R0IMVHNoWt2V7dkzrsB6kSoHuaZS3CFhbKc6n5bDn+E74oYfDV7X3o92cqrzFYNl
	O304XPIWHd0fLFrgU4dcddE350dqMx0+++QSfuJ0LGZ0P/a78zWhjA4oQjgtz7rH
	G4MMDxnlrkHEK+PeTk9csMiU6VspW06uqlJAYXcBYxiNp4nhfsCtzzVW9AYbIojW
	0HoUP7pZKGVV1ELYtka+KpZb5A9XEAXeeVFZkRvGlMIYVB2Z6aME4XOBFyJme2IV
	wuSDkIQXnGi47M0rIB7Cvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86k60h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GVSAQ039103;
	Mon, 3 Mar 2025 17:11:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8g8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZu1iwpVqwPeJoCWSlWCila30Z3oKx/16Kx5XpgAMRZ5CKF1RRdyQugBUlt4GMuuvVIvlY2xVfv+AfPPP5AD8lgOaWEKrpEXIeyAnmQImpdbrBRcf1ZbS4UbNSkDptK7UjjUsTFvssir+oj9fir+p/RBvFmcFf0UC750jvcOgcSIdPrWv1xBZxM+3n0cxbTZfRRoY3/NKCwlGXZc2w+sHilFt5MsGt+FSIhnxFSqfzI3a3bljiMASRZZIT/zFZetv7zKeIS1bNJPwlUHCeJ5MjPKIYjoc4wzqoOwEb37c9z3cLfcQPlSaBuPPfic7yHSpqwO1sva2VBpqn+wzKlMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkvMvt99JAoTjPuUnJ0B2tU7ZIeBkXdjnWNGvQTsAf0=;
 b=nlS4K2LrWoWnjTrBSxxMj/P3Y9YRpXlThotghKnwIZPgb/lS9Rf76qubTSJyngLwBTcEeusMIjKi4iiPFzXvT70ZKdcz31aqfQAlPc6f6vWWRnZH+/CpfirzQEjubvS3puK7hSH40PI+q9s+QTVOEa24lqHCE8hUGxn/0auCgjlPPkdHci/1dZm8zZjnAD1AAQXDOGu6UgLW4yWaW+0sRodnTgXzyST0VNwMKKOA1tKKBLbXwV9D2Ze9eugJITSD0BPlQwvqrq7KeVCEo1jV3nc3t9bVeg/ncbmig3atLnhdTnsTjlg8BRS6DpGCawkjkcvr6Fqc0SjdL68QRAM5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkvMvt99JAoTjPuUnJ0B2tU7ZIeBkXdjnWNGvQTsAf0=;
 b=EySHJTR64lxJGcjOxZjzxNo/tpYAL3g4hxPmXiWEeKj9sZdnapcFJaonM4OXhp0xKfZXOFfzb3lgnvI7AOWze41soyCOFK2IxAZ0kvrF/TFUaPA8osZqhdZR48JEe2FcKs72gGeO5c1i4rQQgQcifvjFGIMYSfqNFUlObyouKp8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:11:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:34 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 02/12] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
Date: Mon,  3 Mar 2025 17:11:10 +0000
Message-Id: <20250303171120.2837067-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7491a9ba-1146-4b2e-998f-08dd5a767344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iEPosnaqheRRzSPDb+so/x5UD64lwtux9g57McVODG1tu/oGUE81oOr5x852?=
 =?us-ascii?Q?XBeq5mLX4bZAwNjteNv712F8Arj0ewq9eLmsAthjwcyPEMOOhd2XQf3y1x0c?=
 =?us-ascii?Q?7M9r0Mo+K4kadLoYsbC5PDtyW2gCwHFezyT0iVvs6kUI1LAdJfWce7zZZXLl?=
 =?us-ascii?Q?vrF0rV93/MQ2q0wGgnIac9R0hrHU8H9sKxlBDqXWIUesikrQ+UYSnkRyDtvY?=
 =?us-ascii?Q?jCX5kEEwHTnG086AoizCUZYk/26MO7zjtqUNdYoznh4FfR4YWvG3K4W4NyW/?=
 =?us-ascii?Q?Ece2h8RjkcrFi4Eb6DZiMHF1LOp1CCZFiM5dcA/+66pWv9QsmToJD5qwANHc?=
 =?us-ascii?Q?sUvfPmc0broDEDL1Dq/C50mEbzHLeyHDRPRsiT0o8LFuSvbPb+cjxN8E9D1k?=
 =?us-ascii?Q?Xds6Nn8YkbiIZl/Z7QC2LSqAAEbbcBFNVpba9Yc5QyA/HnbKp7BQ5SS5fRDS?=
 =?us-ascii?Q?9ZpfxoTYWWkta/fu2BHB6SJ7nJCsqiPGL+/lQqFbpsYKvvazKjiMGMoP1/V5?=
 =?us-ascii?Q?i1ffNtwV5Hps5bBXjDjLtiVcjDtsVUHw8H8ghSbhEymEX2YYfRN8gHwCz/v+?=
 =?us-ascii?Q?CQejSyCM+pPOa1T7eNUn182e26Tgaen3aYMyoU2MIyvW014iVGgHLig7n2/P?=
 =?us-ascii?Q?2PO3HqE/y8oWMCUYB2Jkf4xuC+Jpus9dXo5Po8ohBiDwt1ZxMsZEVj4Mp5I6?=
 =?us-ascii?Q?/fRPOSM7UYYHGK1SXf9g35HjuRqn/M1N7issUqxA/E1nQUzV/44QdRwGHyGr?=
 =?us-ascii?Q?KFf/seEkaRNeEsRGcAEicMY2RGYBlhBja8Kz6nhPjROYdpYzz04wQ/0LCkLo?=
 =?us-ascii?Q?Twdld/twqGPS8VfVDJkZq4ckUDRzaIb5ImDwTl2xCSDHi85VrnBaGeKBAJiZ?=
 =?us-ascii?Q?iq3RC2n4EtzLODuMownjz5B4QlDry/LIhXuN2NmqCXO+lyWf5gA3MR39Es4L?=
 =?us-ascii?Q?2+fe9okwCD55QliZdaONQ8U1N+jX1lGsOcNkvNbt4771onurnKP51Yz0oh4w?=
 =?us-ascii?Q?osdaSgTCrlcxV/hBt4YwkBSeBZgG7ENydHIKgsDFrgRAjN3M04+4/6oXelft?=
 =?us-ascii?Q?tWQFRjqH2RMtiLInURrNPPRspb5xn9NScX7AXIvan1+YSBHu6P5uO/sMy1eX?=
 =?us-ascii?Q?ESh2ch5dHTumS4dr1SjeCzfGBmuUf7QO+0a2D1Bg8q5CDNCGSN4HjeLk9RcV?=
 =?us-ascii?Q?Bvnls+PP5r6FPgilDdZC+OC87Jg0ih6155Hw97zS2g1cudVdv/yc3cdI+8y8?=
 =?us-ascii?Q?mlODUWgp9J1HICfwGSE8C5SveUt+3dp1SHz6LyzCm+EWiD+1pTYxIDQBcRbx?=
 =?us-ascii?Q?YtVUnpm/KNEYRoteNfRqvk+xQpqoFCO9kaLREVZcULE0FfhUtwNs3p1jbUCa?=
 =?us-ascii?Q?m1xhr0dIg3nvccrj/jtB/xwkquCE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YKmLozqPL1cj0dAXZw51XrA22BSV7WrU2jOb+D9DDr8WxCUCu/8MtiXNxnXq?=
 =?us-ascii?Q?3YbTuVRXJ5Dij5oG31mm7KJFQ/KRWjIOiHGtUJYgul5zK8PJb79gFDSsw/zG?=
 =?us-ascii?Q?4vgFaXvZ2JOwmMK46gxcDlQifwdNXeiYjybHzQBXATa+6iFud5G0cEpTwBnP?=
 =?us-ascii?Q?HytFzTD7FTaH7bsqyJ8CVLMWIX1khDoo1cP8+Mm3qjueWCUO+USJZfvE5rjI?=
 =?us-ascii?Q?D3k1OeqVlAiObGm4MyJ77ykgDTLmKzrS6i/N5tsr26pQwyV9Ac9jgZTdirJR?=
 =?us-ascii?Q?AXVd3TMSWO5oFZs3+bLDBibUuR2/w0c4yR2QOn4C2PFqVprNtJ0HCejTgDIT?=
 =?us-ascii?Q?JWIjV7EGNEVa71sgUA3JMEWfT6M/Js7crmLybXxvkV6/Dvvkq01pSX1nWibN?=
 =?us-ascii?Q?789jPNlhgqvpgOVtFDnbaEXWhUb6TJOr00mqHs2j9S5l52gxoyFrzp/OQeSM?=
 =?us-ascii?Q?5J7IYd8Jj1Twwkcj6qeoriTVEcfmdZHHlB8054ReaIj4TlCd8q/H/pkmvfRH?=
 =?us-ascii?Q?OcvBcxcAPHl+5UYaZwE8WA6RGmZHCOtJG/oFQbOzt11mHByP8Ahbw7L0DA4D?=
 =?us-ascii?Q?nAi13mhXfUQ0YU7vM9KB/0zh1neOtu/T2pQFZSIldGozSNq/bWczA8VsSetr?=
 =?us-ascii?Q?9nqp4jb1tzuQeAXOSb8bRydckXVFw7hEPRcc9+BN6agSYE9/cxvL0hNbBOHE?=
 =?us-ascii?Q?Msuybe9/VO7vdLaCHICKNOU4AP+WPiYzklBAz2a7ukwvk1nYHtI3ZmCPzqhD?=
 =?us-ascii?Q?OHJd4OTGBTrqe4h6+/i/w1c8IrjXrTUyBfhWT7zSTlmeqJTNv+8K1Kdv9yeH?=
 =?us-ascii?Q?R0sSN9djsNJ8glgdQv9/1iUhN6vKyd5CbL5JEvJCAIhQoTvf8aynNeYmRz6E?=
 =?us-ascii?Q?jMTOd5bQzBHnc1RNWRpCcCcgrckJJPOB8fRe64Vo4EA5c+aJUB/EPZuTf/Zv?=
 =?us-ascii?Q?bPqMM28ykCgXHDTH6zH1nHk2zIJXcr7t0c/9cd5p9eB8AWAnY6U3qNsCFknq?=
 =?us-ascii?Q?O3geEcdl03Xva+yWs3KDwNU2Pk0NpBR4o7oRf2ockR5v+8/d3IKBFN5goiG4?=
 =?us-ascii?Q?bsLqKjcAZjQ1KNHpYFKnc/gVuSAoi0yyMHdQrB5e5PlZIQBWMJhaI67yM9XX?=
 =?us-ascii?Q?iVq3tSI1c++9nLIkvyl8e1NWSWYIUiTZ11qOymIN31ychORIqZaCEWBlrlvQ?=
 =?us-ascii?Q?O1SrT7NtorpilIsDwTa2VdzvEw65hhzP/7ozb1TJbi7H9wm43Pt0rqJdhOrw?=
 =?us-ascii?Q?WlJWCIBeV9OXC9xojHE98jlD3NpxyxieObK7Jzhu6vrN50j3ytHQVmXiynzv?=
 =?us-ascii?Q?D6LuUhep3eapg9+yKKsOwYsY9UqbdB0n8zSAaHHPbIMiay9mIBAqqqexGPw8?=
 =?us-ascii?Q?A+BsxIu+TOC9uWVrfuw5SUK8Nx6fkHBKd6MMoXspVytfNWT65B/6mKNb8XPv?=
 =?us-ascii?Q?hKUkCqtZO0nJjiE5vyYIc6PWXq67yKEBmh8lmUsmozj5gLg6VHCDMpEqbKWp?=
 =?us-ascii?Q?8wVFf1n2XRLSbP0UMDxh8iATN+YyaRmtKEUSp0Qc6OM70DnvO8RacGAoNafe?=
 =?us-ascii?Q?v+O66REZIH3YhB1io9lfKZp+kB3JaWtONQisrlp3pZziRCvqO6t0Z3Ao+Kju?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yWg7BwMrTEmwLqoQ6MoJgqwOWdEnF9PRzmJVF8LC97i9sQ7NaMkcRiSG5XsUYevfkHH7kSDljblNxvY7NmYF4IsVUDA+Kit8AhjmVCX0UJFbDLVmcgjSwdg5cxjB3Y/2FU8gQMxozcvJyVxPbQPuZaR1qinLJSBHY1o2q7VTNUUOOQCbnsEIjfiDTM7X9M29xJMSPCO40pDzxmoPJGqafXbSv5rklJelFgxhoMTXnZSD7jDtuZ9Ac4zVHensl25Iry/CzzTDAS/u7QmpWY1/R0dNBRl1ES4GuG0FYIMEv798TFYrhUog8LjFKq2FMqDanTQc+kx11MjYod6td86JFxvcgfkh6gLY/1YtJRitOQiVPU1WZRdXBXjy1EMdBtK6igTb2RwBX+5tVH7ljbFI/6cXY7DGtZ27SDeoVHYm7LY7ORPrq8hY4aap2mFmqxD0MoxBenM+sWvVwDlxmPIaww/yXQS4OchKYB8pMIXpIpCwFJGKd5ZYv2xq7O1q90pgpb65KfryrMCh+xFyxwST+hiretey9ygKhMgWrHcwz6gO+qDpMLtTLW+klEnUGjf77arY0ksfROup3moUuqV/VWYMk9vaNuWl/F+g0TovtSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7491a9ba-1146-4b2e-998f-08dd5a767344
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:34.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMrYYbRd4NIaJtF1P2QX7l3Dp7sRBWatFnk8EOwRXiZZv53nJmLRTRS+szoowZbRkex+FlvtEYtVsymxhCto7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-ORIG-GUID: bv7SfAyJ0v3V2dLOTI9o0nvNVnYi4MWY
X-Proofpoint-GUID: bv7SfAyJ0v3V2dLOTI9o0nvNVnYi4MWY

In future xfs will support a SW-based atomic write, so rename
IOMAP_ATOMIC -> IOMAP_ATOMIC_HW to be clear which mode is being used.

Also relocate setting of IOMAP_ATOMIC_HW to the write path in
__iomap_dio_rw(), to be clear that this flag is only relevant to writes.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst |  4 ++--
 fs/ext4/inode.c                                |  2 +-
 fs/iomap/direct-io.c                           | 18 +++++++++---------
 fs/iomap/trace.h                               |  2 +-
 include/linux/iomap.h                          |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index d1535109587a..0b9d7be23bce 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -514,8 +514,8 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
- * ``IOMAP_ATOMIC``: This write is being issued with torn-write
-   protection.
+ * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
+   protection based on HW-offload support.
    Only a single bio can be created for the write, and the write must
    not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
    set.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..ba2f1e3db7c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3467,7 +3467,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
 		return false;
 
 	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC)
+	if (flags & IOMAP_ATOMIC_HW)
 		return false;
 
 	/* can only try again if we wrote nothing */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e1e32e2bb0bf..c696ce980796 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -317,7 +317,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic)
+		const struct iomap *iomap, bool use_fua, bool atomic_hw)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -329,7 +329,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic)
+	if (atomic_hw)
 		opflags |= REQ_ATOMIC;
 
 	return opflags;
@@ -340,8 +340,8 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
+	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
 	const loff_t length = iomap_length(iter);
-	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -351,7 +351,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	u64 copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic_hw && length != fs_block_size)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
@@ -428,7 +428,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -461,7 +461,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic && n != length)) {
+		if (WARN_ON_ONCE(atomic_hw && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
@@ -652,9 +652,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (iocb->ki_flags & IOCB_ATOMIC)
-		iomi.flags |= IOMAP_ATOMIC;
-
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -689,6 +686,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			iomi.flags |= IOMAP_ATOMIC_HW;
+
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb_is_dsync(iocb)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 9eab2c8ac3c5..69af89044ebd 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC,		"ATOMIC" }
+	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index ea29388b2fba..87cd7079aaf3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -189,7 +189,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC		(1 << 9)
+#define IOMAP_ATOMIC_HW		(1 << 9)
 #define IOMAP_DONTCACHE		(1 << 10)
 
 struct iomap_ops {
-- 
2.31.1


