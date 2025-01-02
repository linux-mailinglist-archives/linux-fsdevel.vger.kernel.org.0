Return-Path: <linux-fsdevel+bounces-38321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CC9FFA10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08333A128D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5461B3934;
	Thu,  2 Jan 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PBIwEoxr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N9PTx3xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA97191F60;
	Thu,  2 Jan 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826694; cv=fail; b=Ox3DlCIhj6pNwoisA5QtfoOECnZeU4usvPpJsJQHfDw6JkY09EjdxWtbl4W961Dk/YAbb07jTMc+4HS6UEvESknwwEkTywXu2t111mSdT0LQM+6jKYcude8+Je+Y+mh220/mzOPS1GHDsl/cIRFlPXPxzkHlK588nfAWNuU1f5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826694; c=relaxed/simple;
	bh=6zfnmFazEqBaBWIRgVqn2WJ9JeRsqdBhAwUf1JTLJOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WU6h5CkzhepReJyD4SVQr7eOMZ8qmtCc/2f0RBsUZnNy/PXBD277x3Xt3trCuB39LlJFdfxWJo38Zl8ZyOVUhik/lWIJngaefjK4XC7YyyKL5PdlBXiM1Gzids0uNq3t/4jbZuR40e4VuDumyCSUJ9VzmdMxp60uGiXB0/Jb9po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PBIwEoxr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N9PTx3xg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtxLe024660;
	Thu, 2 Jan 2025 14:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=raWm6UgFAyHyqDYUwti3udy2SJevCJIf0CNPaRhdAsc=; b=
	PBIwEoxrqGmK5aArCn4NjtmBn/TkeneSzlj0UQ3YwaIQuP8w98oL8oBUhGuQe9aB
	dggL6A2+mxGUsp3KEuny91BR5oknkuFz2XwoW7UpZzqP1c/KQJoAUUJhlyTU3Ajb
	yTPwubGPknq13F5v4uQ022IBbmQyyVaBz8Dh3cJz//08Qlht8oCM7ASmhw8STmNC
	nfS2yzdhAC0SYPUGxwKH7PzTzzPupYoU7FVaX82gXueDs9MuPR/F/SX1mwHjE4WH
	JimBvc9zIGtDLUZDw0257vyWFH3nKPkOTn1ux+ux6B+aOBdMqWfM7+an7Ejo7h3Q
	lMrDvVX9ZvpNwQhL2gRBBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb889mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502DEWN5012914;
	Thu, 2 Jan 2025 14:04:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8jqvn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kifeLFQcpMx857oRdhlVxhahvVaGo1fqWIlP72qs75RmBUAyduPbsgNpBukQxLcjzRt8jdXUtyWoJbehEtTQWwgThS1x7oeCyCCd3EmFiAMCy25vxPeweBj/DtALl48btfNNtHVn0Dm+kbcH3WIxi3oA7CIHW78LQGVy2gWDOcsSWzCRjO5CCq3zQV8/2wpKa5/uwPO50q1ySXnti3jFQiYQQDYYerXvg6SF/gIWb8WWo/KAzmqapBvCS8OZ3Cp7aJYlHKGrlKoQwA9eIK5GGZsuuWmh7fg3xwTGyG01vHwtrALjXgn++7fW6y8FRBU1cCOSdqiGR0hwAVSHsxYQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raWm6UgFAyHyqDYUwti3udy2SJevCJIf0CNPaRhdAsc=;
 b=CLMF0GQ/qR1EkGWRh/k07XbfiOgOj/M54be8SH/uMGkxUD7VbFAvsMTnrP6z/k2Oz1o9NkW6g4Au2P20YASQ6nYdKVKhjH5bR6OJXM+sDCIG2f7/KMj3Zq1vqSgzU3s0xwU3fu1SBP4geVv4l7nWzmwfeEuyRTypRgAXGkKBcX4d94GAyHzuOWlEwMWxftixZmnt9XgXf1R147pNmj+ww2rCPP6XTnSxyEPYakSab8rMzyepYaLKZbCqY3LeAYkP8tzUEco049jlieawXS8bSAijUYrjXmTXQzRlehxsfDHfv18Ca7sErgnsTU+H+XGowrhnmR6zQq9XxM95EjFbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raWm6UgFAyHyqDYUwti3udy2SJevCJIf0CNPaRhdAsc=;
 b=N9PTx3xgpazMvqgEY9EKaVqlwcXAqDgDPm0mRhyn8EVO+kJ+Wlrr6YbOiq2U7OfVKCramOXY+4Ig69Psoi/eQXMlLljNqpIUBFUpP4nxmvHv8xRtVSRmk36JT/o51Dzxofz4TNZNxrK/VbFRoMtKTRO1C/yI94cQun/vy5DYEDs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:04:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/7] iomap: Add zero unwritten mappings dio support
Date: Thu,  2 Jan 2025 14:04:06 +0000
Message-Id: <20250102140411.14617-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:408:fb::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5829d814-0c29-4586-fb3c-08dd2b3664be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ni+U9WYFDX+FBRmoleq91AzFh/Tb0fr4UsdZVCE1WYUmdWje+Eh0aTeoH+lK?=
 =?us-ascii?Q?2z+0+aSdqxrmgpWqV1YfbKBCj82iw1UC4tyCe4q36wxyfxCRLtKLtBSRU/Mp?=
 =?us-ascii?Q?ZcSlBsDCbfsmOik5A8cox6ec5RVOgHy9vOdnAb7qHqg1TEji17tlfEk7Ra7z?=
 =?us-ascii?Q?tbLNglC4D1nJPEy5DpIKE+KglSAo4VVFVYteKHaUMKGhcelpv10PceAquaUd?=
 =?us-ascii?Q?hxKzdBcl2pouOuRPrSfadQM04DeHDZwrHhOCpOFZ/uQE6HIWoTe5LqsyHWph?=
 =?us-ascii?Q?CPjE0pjvGq59xl+0ybRQyLZR7pdPkg2iDcL6rNAXOCsk6gFMG5Jtp/qNIl53?=
 =?us-ascii?Q?cv1hpx5VmJGnv4tNIDBP2f4XWHmX9qYVNxxAf5n+o9mGuT5CwofPIU8AVlW0?=
 =?us-ascii?Q?Qyr61nSB7qDcyCxauPF98TWk0yQspGmITTpp+wzC/brNnHw9RKptHKddGeGZ?=
 =?us-ascii?Q?6hy4WbWoOuQybtGxXfjAmCD2I0Bfj0rlWbmMJo86wC/Shjw5Qag93FLzGDXl?=
 =?us-ascii?Q?tCnvv6LJTg2IHoHQakm5w3h/Tof6ASOHQYoHhm7KyYSecKtfIDQq7FUGZNUa?=
 =?us-ascii?Q?LQELnqyIbWjiP9aKFTTEKIs0Snun4SLQkP6ZkGhH3MI4mLV6mZbEzAwAy4b5?=
 =?us-ascii?Q?BKZScDavZ1aX4fNfixLSf1AlM8216CmIfyzJc6ke9oYGJ8V/gh/cK5ZH9RwV?=
 =?us-ascii?Q?8TJFTccf0tQtGXhcUg3XQWnIC+l50/T1DfR74fk5bk88X43bUPRSu3jKu6hg?=
 =?us-ascii?Q?tZxbYHdSlUVbRDJQFo4j8fzMYTpTRDEuADDARANJvUxPKSKRPtXBzJGDpfbL?=
 =?us-ascii?Q?Kxvt90jZcjz/j4JQ1hiE7lcG2PIisZPry4iNiTOR8nLsaWXyKRTl5U3gSzCH?=
 =?us-ascii?Q?zafQDtzdfVXLliYC/u2m9Ny3b8x0yWekErNOIfm/4i6P2z8lvLHVdNJELoyC?=
 =?us-ascii?Q?awsQn0hC4Ijpv9uzsJZkLxf3ylflAr5VBA7GA3w9Xw9Pb5HJsXovcio9QzgO?=
 =?us-ascii?Q?KcvweAvFxa2/Kmp9d6CAj6q9KpglBnIrG4It6+xyX+x9e/ACxa9rFdMi2DUd?=
 =?us-ascii?Q?RR5reeylTIFWvMYXt/0Pndr9XH13vdzy6nnTEqxu+MVJS72aj1Zi8/BcNrVr?=
 =?us-ascii?Q?+N6aY+if50hzcaxWbGnVDsb1R/sbkMwsVpLmnX76okgR/B/llvqjobXmVIhP?=
 =?us-ascii?Q?XFqLnq/UZgcZpMNOeUnVKXcOzf2Cn9Rw/SMNKgSDUzxRvgI6f+PmqTKuWF/L?=
 =?us-ascii?Q?yIgCz/u+SOYdt9ffop/kvuKGkNgxEVt2ixOUxdCGbwjoSN3/aSWsU52pKzbt?=
 =?us-ascii?Q?O6WgawJAAfq5cdAVApA51bVkLJIWu9QF+sQX4kdt83dgxoNag3l3bDT2VcqD?=
 =?us-ascii?Q?e1qddIvMWkRKuFPWnvehB/ID5trA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SR/ucCmfJZUAcyjWeNj9rhirI2GrH29UntJlzs38gBhGZo3T6pa/By0jxo6q?=
 =?us-ascii?Q?CYxlNu6nkzGJc2UmN8wWcJJYKwx6yC+q/6LX7s1EQRIArBPo/PP5mzBzK3CU?=
 =?us-ascii?Q?fjRMhySIvf0y76hj5536tZRpDQgEuZEJRGe9M87AMy6zWXFURS9FAAnsr7zm?=
 =?us-ascii?Q?xdPp9CGTwCgKKy8XIWa24rPwcNx044SNvujgU3qbtKuV6sDm3YCq5DL1Hjw1?=
 =?us-ascii?Q?VEsXta5OahYnYodBAAtfSz/iVEMUO3ZOh+82uC+yzkzlo//nrHBKfalKZ9vp?=
 =?us-ascii?Q?qyxa8x68TAXsH04VlYEo4nD0S2ZGmNi9TVoZ5vx6HwyqmK5ZnvR1r5HukQMg?=
 =?us-ascii?Q?EbCH8cLWS2uEQNmoDQNiwKzSEY+J4ZQ+wADcbH5Z1aQd/ESRt/isFm+imh85?=
 =?us-ascii?Q?MSWleMxHRB32qejRnqq/FvZGsDX7Lq4KrdySG8rpETzY15wAOsRWoS14QRcu?=
 =?us-ascii?Q?iaFHvaSYSkLaLtUD6rNvyj1JZvXrsF9jHwgnopSbCKw4e614i8aHOYNnqdVA?=
 =?us-ascii?Q?Tj2fTjhAj0PyDJ+68IOI0AZedhX09zyim2gBc1XNb1hnQwboARiN4OhWAqpF?=
 =?us-ascii?Q?g/SBeI36XLf1XXWryk6eMG2ivL/Xoaz6abo/TE7LzOwA1N/evcFFPG+KUj2/?=
 =?us-ascii?Q?sPvTv/zJxsZ7z/cEzu2H6c81RLPoGDhdgFE8lerEEHbXQDJQsVjYvC6EW3Fa?=
 =?us-ascii?Q?9D6hgzZ8i1GKUrJWqI/IU3D4qvjFMn4c1oLBMtCoFgJz0177phMHS9eb1tQ7?=
 =?us-ascii?Q?wBkbpExUA8dLC+tNyMCd0GgDCrKq6uHmreQoIkWOVqdcFJsFpvEFJouxuDLy?=
 =?us-ascii?Q?jOyPCPAPmtBZRD1SrZ+Xduy14VwFy2upqQHe7v2kXaynHo0veCEe1FjY3qyX?=
 =?us-ascii?Q?kpZg2Lils2dnPWkupx4a8Mro13HjgJW1yxpj86Qi/3UviKfpQAgom6aSoAM9?=
 =?us-ascii?Q?zTetWOcWIpqNKQasIs+o83k8JQJyNHwxlIbzz0JFvR3e5ncIkNC+bpDznrxx?=
 =?us-ascii?Q?W5FuWY0fEifQQ87TJSqMJr9PXRDNVdVsVpUQte4BMJMNa3htrA3OWohkFgTP?=
 =?us-ascii?Q?xG5jVPblcb7kPHww0vBMXUq0B1Q89sygywq1/yeirzeoUN6jXgWr4X7PbGsH?=
 =?us-ascii?Q?2ldwtl+NtGyu4YoAWKdN9UyzmCeqp6vyQ0rMQFocBsnyBj0JXBBLnVgQbWG2?=
 =?us-ascii?Q?SKsAPUn7tluQROeTpFGQgT7mDt0Kk6bRdvzslYftG/+C0rQZROKtbHgkWqwz?=
 =?us-ascii?Q?8hjtFurRFIZJmmALGYGInAAaJmDXBqGTJhD/bN63rxEi6R3k1nNzsHxza+wA?=
 =?us-ascii?Q?nReMm/orJq83CZ0BPWjxh5gqA4o796xeW0+K9/T3YgDuK5XjXvGLSSaxNwOl?=
 =?us-ascii?Q?i9wccfDGkBdB4u//Yjbu61xj5Q5geG727r3wly4GXIl+5XakCUSmbrkPDXbL?=
 =?us-ascii?Q?itMnpiRP/682mlOH8PAnrWD49x7ghbta1lrXpCHmIIOL/RDhC1EZAV4wIwyU?=
 =?us-ascii?Q?IWGyU3duDVTN4wAODe3u2WYhCNBIN+/wZ1ap8JXbzDpgLLk/a4/xhWfxFn8N?=
 =?us-ascii?Q?g1zGlYal7OvwiYyQ2H8ysUlhNntZ5ZNeeEz+GUxCA8ZQ2ykApC/tK9vEf2NT?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PyJZyfNhvf0Xm0IVL3Jxc+WXU9JrDP44vQ+EOEOIWdHovxaXoCGFQdjA3t/4QMWhVcOFS+LGIHAw0TILgx3x9xru5QZtQwnuSRza8RQ8RRRx7o9muP0mLs4P59VD+vwUCP/ImkdkYEimZQgsjYfobwvB0ZcfAcyeI8OGDyG34Zmd+lgi7lGwltDRXZ8xap0rMrJSd+9ZwgS4ce8Fh7OAnuJ6bxKd+NbP60zl9lygB7Nq99SSw4Hh700xjTEboFABdmzlcIjTSsx77On3Ph1rMDmOJkEMJVflKu0WCtkfhANG8olfW/MrgNsl5xXhbkVCJGjoIu0vGw1o1F5EHEym4WMCKIreM+HPHU5IKX171VZBAQaoScqKvtnUX20PTy614Ya3a9TIBYn04IZ4QBC8X9KbZnWrmMWyeMxYPHx18jT9jQW0QlT41AoVyA2uPlZh9x1KyzWLc3kopK/tLfSZjvEbKDGbAyYVOEEahpx6ZXDuFqGPrmOtLcLso7Jft2SgNwIrkhnKWWT+Rekp7PVFnLpNvc3/pjUAr1jX5EW7ptpw8xy4Ec/dREpooMsX1lCf/acfsir14+PHPSb8eQpTNdvPC3jg1z3s90PxR0kErsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5829d814-0c29-4586-fb3c-08dd2b3664be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:37.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5GzaetZqb3/KOURBXTk2bv3mRd/yuxawYuMZFgr0yQ6X7yUi3dMgxb0+fVzkTFWcSTFozXpIsCSUX95Bz4x9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: qYMn3A6Q_QpLIbtC6yOte6KoQo4ackOa
X-Proofpoint-ORIG-GUID: qYMn3A6Q_QpLIbtC6yOte6KoQo4ackOa

For atomic writes support, it is required to only ever submit a single bio
(for an atomic write).

Furthermore, currently the atomic write unit min and max limit is fixed at
the FS block size.

For lifting the atomic write unit max limit, it may occur that an atomic
write spans mixed unwritten and mapped extents. For this case, due to the
iterative nature of iomap, multiple bios would be produced, which is
intolerable.

Add a function to zero unwritten extents in a certain range, which may be
used to ensure that unwritten extents are zeroed prior to issuing of an
atomic write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |  3 ++
 2 files changed, 79 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23fdad16e6a8..18c888f0c11f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -805,6 +805,82 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
 
+static loff_t
+iomap_dio_zero_unwritten_iter(struct iomap_iter *iter, struct iomap_dio *dio)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t length = iomap_length(iter);
+	loff_t pos = iter->pos;
+
+	if (iomap->type == IOMAP_UNWRITTEN) {
+		int ret;
+
+		dio->flags |= IOMAP_DIO_UNWRITTEN;
+		ret = iomap_dio_zero(iter, dio, pos, length);
+		if (ret)
+			return ret;
+	}
+
+	dio->size += length;
+
+	return length;
+}
+
+ssize_t
+iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct iomap_dio *dio;
+	ssize_t ret;
+	struct iomap_iter iomi = {
+		.inode		= inode,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(iter),
+		.flags		= IOMAP_WRITE,
+	};
+
+	dio = kzalloc(sizeof(*dio), GFP_KERNEL);
+	if (!dio)
+		return -ENOMEM;
+
+	dio->iocb = iocb;
+	atomic_set(&dio->ref, 1);
+	dio->i_size = i_size_read(inode);
+	dio->dops = dops;
+	dio->submit.waiter = current;
+	dio->wait_for_completion = true;
+
+	inode_dio_begin(inode);
+
+	while ((ret = iomap_iter(&iomi, ops)) > 0)
+		iomi.processed = iomap_dio_zero_unwritten_iter(&iomi, dio);
+
+	if (ret < 0)
+		iomap_dio_set_error(dio, ret);
+
+	if (!atomic_dec_and_test(&dio->ref)) {
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (!READ_ONCE(dio->submit.waiter))
+				break;
+
+			blk_io_schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+	}
+
+	if (dops && dops->end_io)
+		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
+
+	kfree(dio);
+
+	inode_dio_end(file_inode(iocb->ki_filp));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_dio_zero_unwritten);
+
 static int __init iomap_dio_init(void)
 {
 	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5675af6b740c..c2d44b9e446d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -440,6 +440,9 @@ ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
+ssize_t iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
+
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 void iomap_dio_bio_end_io(struct bio *bio);
 
-- 
2.31.1


