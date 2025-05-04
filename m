Return-Path: <linux-fsdevel+bounces-48005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D61AA854B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D77916D32E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661651EE00D;
	Sun,  4 May 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SkdHu+k2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="juiCBOmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CC1CB518;
	Sun,  4 May 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349352; cv=fail; b=uO/I3sRT6aAEfdSPDx5579gabqLIHK545VdkTX+LOZLNjr2wNgOuWjUipJvLX90dyU9nzEbtLZ7PADOW6+RwLPTp153j5XBw1KHEXw7LJDROJQi14aibzQlqrUldII/sVxzRta9PSCNjuRhOBk5fJQk5nEv0S7IRuSMTpGb1nR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349352; c=relaxed/simple;
	bh=e8Rx4wKUghn5UbLRBAKEFYhg4Sjn+njknH+/5eTBz8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vF9rQpyVWVzyOeatdK8SffqrgGM66tOb9jR/W1sMRX9eDn76ye0GNYZx0gXrFNX+r7hPbnHvJJ/5VlPvQTizzhFRI2YLJzOoChTjlNWZ/+1IE76BS+ISc3RnSYLmSBXMyzA485n6MwS/TZwKpHoDzYFG2GAhlD9tIIId0JWFEUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SkdHu+k2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=juiCBOmv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448O3at031744;
	Sun, 4 May 2025 09:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=; b=
	SkdHu+k2zf7uISxI579s8fUp+5A+/PZ2Z/9Dhk+GtZkQaKn7FVeI2mVLfD5CVn2N
	SONNf19i42GoICm+GHzQ/GzTCYAT4W+hn9OX7BhZxd5PLqEMHbvbSR1crFz7ohWe
	Tu5Om+/FmwFom4x1ZGWVI5jK2wKlYGyROcgy0ONzKNgXON3tPGWWuaRDKPR7W0cD
	C2gMQg4dPxGKHgK9/oXOS+Iu7yr3SWs2GPvJf7ThNWWTxylPoGe1ceKWoTx4WA4S
	GkTXVaSdvsu5yhqW6ria+uN7X6vIJ7Cp0CvqE4no5tlBNgmNIYKHuZRfalxhEa0n
	lWPi3BofVwUWbSDHbSeE8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e4nqr10x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5445T5uc025015;
	Sun, 4 May 2025 09:00:18 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kd0ejk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnD+I4yXlEy6jYXxrJF5pKzLjwjOpNajTyWBokA3Lanl2pz0yGToC4k8mnBwzteeoExD6Jdjv2CGkNdx694g88JYizgtxgZBonXVZVQ8S3GST/Mg1B64bPZHbzj39vNF3Y8a4YOuHQ9CFQxslzMtFwrT80oPieeTtdqdNtg/eb5Gj7QmZSe7rxOQlgzEGzkkiFDpeCi751p6QQmYZ8fwc6sP0cf9NTqNIZUcWrUiV1wwHv/vHIfUOCIQZB/RKoLiRA64jL/ivYAzG7pdrx41V07HDdyhaIZ/VBSOvbkBFJiUzGKqHNnYPqrasj9HI6oeOsRGECNtJs7cMEYheGYgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=;
 b=a0PHS9o6seykKTBoDAIxNobM8RIsBwOdlktJ5g+dO0RXVGzSOHTN1mJibugdBog5CfN3n+lM7Sq9S+78ZjNX6wd9AE13XC8t2tOyXnK8msZ2ALt6MDIcRZGw3uwjtFJYPo2Xwcq7W0QWVmefMrk/yZVcVO0ouyaE3N7kb3Yc/i2XSiN1gsou34p+S+BjpnRHV3UgfppuL4IedufEXLXTH3fBm96JD65kk0wJOUv9cawoCnPfDiWfSM7QDMw0P/Q4P/TTPABotpkc3vkZ5/0RCLfUcDYTESDYuoHAVy/7LCZrgfuzN4CbzCV7Wk/Jn2W1Lx1J3t/F7LOlcwu35bsDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=;
 b=juiCBOmv4S9aM64Izj6wtBpHeTKUEd3AQH3B3SHDdUhAqx7RMNjcxEAp/PxUwG2oaaP/WWIQ0UGoYdISw5W+O36CFn01Sog1vkmjDVCU2PYo02XefhCx9xdTpltdyDxVNBnZUCYzaaVj4fKz+qDnvArafJicQo0pKTtvrekS9Sg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 15/16] xfs: update atomic write limits
Date: Sun,  4 May 2025 08:59:22 +0000
Message-Id: <20250504085923.1895402-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:408:ff::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4845d63a-a3ef-4b02-915b-08dd8aea15ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+JkJv3vD7+EwAWaDtNe+tL06yLVK5qyBbx61XyZfubPUpHeW6bIsadP+JS+?=
 =?us-ascii?Q?RTGwr3V2U46Ex167P+M81QCVtlULHy9osf8MRqjI1KeMlRrM1qqZUOtRMtJm?=
 =?us-ascii?Q?WxhRrg3TNmXxAkUGt7to5M9zCZYJA0o6p1GCU4KDLmt1nIpzse24ftAonYDP?=
 =?us-ascii?Q?uIjh5a2tMn1+1OOgf5mOvkYciPmRoBFociUo3ExayRZkmczYuT78o6mIxr77?=
 =?us-ascii?Q?FDrPOoXGZjwA+//s7jc2baPB8+mLYbS5IWBgNHQQcuYnkXloij8GB+zmTtND?=
 =?us-ascii?Q?428dcVV3QnGAMP7TD4VZUwYJVU/Urta8vlrM4IJEfhqJOqzIoLc7dh0sIfOX?=
 =?us-ascii?Q?UBvejHuQZ+ey+Q03ozmu3h4Ae6rDGCGlKNRFLTxUTXZoG37imY/ltw1iW/KS?=
 =?us-ascii?Q?J552XLr2D/pg1wwv3GQko3VTSEW+q5d+MXxPAt6RhJdyKqBVkW/dAqx2RX4O?=
 =?us-ascii?Q?hxSrwxA2UP+vnL5LB0JLdlJaBcVkl1KdDv7JOFkpdK7WU3VNNdtKazQv/oG9?=
 =?us-ascii?Q?HEke/3levKm5oF059v/2lK0nBg3M9cWBr5DHcsjAbGxXcccyG/8uWOiZ+6y6?=
 =?us-ascii?Q?U87zx+USK4S857sdb1lwk+k8S0f8qWH4DUzeDILMXCT1OaYugR3MBaTaBeUv?=
 =?us-ascii?Q?GL106QiFIAGxFwOwY7OC3qxNIHomL68fwKzQtQSxxUBumi8QxmnpDCiIGBdM?=
 =?us-ascii?Q?Fy6FETLyoNtVlIN1wCWUZY04V1kbgKO2Bwx7Aec+fzIS30MnV0MTa7FNLae0?=
 =?us-ascii?Q?abNo+rhr4a/O24YvcnLaM0nKmd87JHiPR3EXUmD/67QoCoYialOxz2JVSorD?=
 =?us-ascii?Q?4p9C8uNNDARFSnKJzQh9LuE3W2+HlDF3509GdFUIps3zUm1eTfIFxayXD+Rr?=
 =?us-ascii?Q?S9regEt1Szk+gxobH8sw+TiukbXI+tG4eMFSNut1gheHUd6LVb5hkqQaFt+f?=
 =?us-ascii?Q?G/9MdFjNIlFExinpJswR/NjQZm2goT6jfzfQEqJD/1wyNZTI+UnxzliclbMQ?=
 =?us-ascii?Q?h19o2FM2PoVmVA2huxEDtG8iynEaQjRDSuKKwX7VAeMV9xZMnrgrXSsIwoLx?=
 =?us-ascii?Q?4NRrkHz6OR3RIUeyRsdP6wiwdPnwSjOFLxbAgXLc5Xbc24m9e3kjGQ2LeBuf?=
 =?us-ascii?Q?yMaSN8SAn7Knf1YbU1BunBkRTrHpbNLZugk5MLXh8xuD2VGpfqaK8UChsBu3?=
 =?us-ascii?Q?THwhQeEz/LgK9gKWIlOAduam9q1pxrEYpKR7g2QiSNPCvMERVuTnTHsNWcYI?=
 =?us-ascii?Q?5elUMe1DyADs9rMNCvc4U+/iX0b25wNWrb8J0GDfBAGJdxMNOfgLMj8nXu1f?=
 =?us-ascii?Q?R1m+yRthY01uloA19GGHfHWYUJb37ZesFSfrwtHXJ6Ge2TBoffQNlTyOQsyg?=
 =?us-ascii?Q?np0th68wjnIbwGbx0PeugaAEqRTS72Baf+EX1D35z921U0zSlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpoFcqwCKCCR0An1+kLp2Pfi6ZGvvGH2Y8H7NhRE+OgfC7LEMc0Y7NLS5hm3?=
 =?us-ascii?Q?ejdyvjeXQwR9JCx5gzXmHuHZVGEXKQB3TcMgqbt3E6VASaFcyc2Kras3yink?=
 =?us-ascii?Q?u0FEFTMxPODEKWenDNifk0CRF79NDJysZkIcD41V5LzXQtTtecEOLu6SfQiB?=
 =?us-ascii?Q?tir6EbGGASW9VUNtGLaHs21yRqCZ7P/CDoui90h8xT4aGkHcstt/QEjvlpPJ?=
 =?us-ascii?Q?921JT+Wcupm6mSvnETaMNXB8q1B+/GK70zwyA28DzAh3HFiYpICkxzXGXyRJ?=
 =?us-ascii?Q?NGczwiANtrMJmijdo4uwEBZAZwyPAftTL+htuYppi+zlI0SnZ8dkXIASIPn3?=
 =?us-ascii?Q?Q8t0UfXc2LwVT6j/tYxNzEWyhZZBBYT4X1tVjNE+GmNBFVQ5EQU6pnaUZAHn?=
 =?us-ascii?Q?RTGr5ybasswKE3FbZUz+wTGUlBGz3QbAXNY0lQcCK7y5OzAVIplxUteOKtuF?=
 =?us-ascii?Q?ZGgJiUcw/Ih9cuMjcvJp3HquAbwPnBQbdoLxksuLg7XR/D55fRRcOwKIFWXq?=
 =?us-ascii?Q?XGFrW6AEEWM/YzD3J9XX/lC5sxA35u2tQ5is9zotbh+anbVNzP9chbRNHVfD?=
 =?us-ascii?Q?Oi6R5hXEdeBuAmNCxwBmjBJhcnEK3GvaF+wPOWWL1Ljdw9XkDZfZ6IvcolHs?=
 =?us-ascii?Q?I6tdRpVgGqlprbDEdyx8wBivpF76AKMAbjeKjl5/TPfpxLxDm6YmPLsuGjh7?=
 =?us-ascii?Q?ni4Yb/KM+sN7Q5D1gQQmrkZFxJNajmkm9itLxYs3oylZSYUCYwqM/f8YKBMf?=
 =?us-ascii?Q?qSb/QP3M8p5NLe/vD+uu0G0unoEzIftyTulJBBJba0YQeyiUIKpFjCXlg4Cs?=
 =?us-ascii?Q?kyakRRkQq9//+RBWfBpvFNDW4rjd4a1U2SM0zqBLwUI21yNYyMpA1/toRyAV?=
 =?us-ascii?Q?kIBsnyEFwe33sTmUuxEvJ102+HNtr8zyKb2rKKTHZfDBLM1dMlbsJGYFaD4b?=
 =?us-ascii?Q?OH7dQsd7F0KMVo48+i6AELukTvJ1dVnnnol4ydtT2JsK/HlN89gOATHn8QiS?=
 =?us-ascii?Q?+fepBWbA2KLHRlE3hJ6hQD99NRkIwBH+59OpLOjJaisHiXto73fIQn8cwrhG?=
 =?us-ascii?Q?VYfeFLVgZoQEMkVOB0D30ksg3c0GmgshgcyzkYe9riyPN03e74+LsAFWSmC6?=
 =?us-ascii?Q?1ERBPq1VrcWhHtMz6ggyrPLRrjcGXyybeRt6w/yxqunjMyGMD9EAAz5kiVMN?=
 =?us-ascii?Q?jvDiEWyh6eSptGchGP2g16Ln32/pG1i59rxR9bZ74SmQV6rrrI0Lt2Y8Xj2Q?=
 =?us-ascii?Q?hYRmN4gasdiTgi6ONXcArAcxpa8VPFDFCoe/72V9djzhZdZ27UFJhpKoG59V?=
 =?us-ascii?Q?Anb96dcH3ZoYlE3P6FSTK2fygbBnYdGUi4YaqdB6becFpgFFqPgl/3vTQV8x?=
 =?us-ascii?Q?kObl9FnOJbymHZbN2bY2FgZ/OiI0L+S51rzfiD7w/3F2lyNAmAQovb7z3hW9?=
 =?us-ascii?Q?MgpqIpa/LdeTegy/Lc5bwGd8O1yNlEVKwWNS4gHBSPqCxUeK0dUDtYP1fLq4?=
 =?us-ascii?Q?klT9ou0CpdN7nJnW3bCGHHX2DrW94ymUvuqXP0zRBSt8uEjyi6Lwk/Liwc43?=
 =?us-ascii?Q?yxY2c3Y4Nxf+ADch2MaA1/uajxd0+ZFLRf9SqQyY8TtwosHGqzpnz5WUGjht?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5FXMFqVdznQQNJDh1gIW61xMcMokncuNXzAWZ0+Gjir/2YEVHIRYPMDwfhw1shZebM/gKP1Mgm7b2lP+3yrtxpHxG3COPl7fMdr8Fre6N8G6AuM+RmbjTZsvsTISBtl9fsD6jZPNdkUFJpaWFqee3/QNJvY4w5qJJD9Mx59sDhjEuJmJbwQG35EkX5z5vWbfN9Z4+RcMkrvCYU5nIJPCeP4Hg7rhcXsP/YR1A71O2lFR79xrsh+UOuZqSoZMKIEu0jm165yZu00K5Fdr4hxuvaxNNXr5BTmBPvknWRNsxCbCQYgBAZxQe9o67AG7vVwq+tW63H4A9f11ezVYFoyv/b6NQ0k5GSlGK7PW1Ozwlx5KRiuViwuUZMw4ACOuHxjmbbzkC3/R8mUCVnIjGMmKh6Kc8wbMB/iuOofyRZcIWlgm8mgjuBLD64SDgyoHXRX4UOSXjrNHBY2AdN8z9Pxd+B0bi7TbH+8+VU8q3+9bUKX0oNkyW5INHpQnmeTYQk9Tr/xwX9tVHwtL2G1l/OQ3ANEroPsPHSgAIgZYoKj7a/oc1e3pDLD7Do/A+JhhVn6vGZ3ri5CU0KQtQyw3CPgfwZTLurPxzohoHjyycqBL9XM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4845d63a-a3ef-4b02-915b-08dd8aea15ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:15.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmM/KiLvHg7eHby7Z2q1g0xFZR2C8wsx54NByCoOkvK51bjv1Mnd9CtyX+tAym5RCTmmeQ9/E8PhMMm2++RSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: -Y9-8y6URCPA52GZ7Aku1hD_REMT4ipe
X-Proofpoint-ORIG-GUID: -Y9-8y6URCPA52GZ7Aku1hD_REMT4ipe
X-Authority-Analysis: v=2.4 cv=PouTbxM3 c=1 sm=1 tr=0 ts=68172ca4 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-okyUcW3L33xbzEWqc4A:9 cc=ntf awl=host:13129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MCBTYWx0ZWRfX2H58FG9TuxoE b+Zum7AN7v86PNnTv4h+T12lOkZWCIBWTocPifk4Hz/bkSlDXa/R6CMR1ChVf4rqb4rdNdqrADf RBNyNiWlR4MplxvbUPaAk5VZODl3jFCY+qXOAw8VK1AAxS8lcnNWx3GMv+ewx6oPvV+DMJ30cjf
 wIT4EYM+KCfZsu7hY1SAUwoCw1W1NI9LUtEJn9RnVqld3HhZSPr0R8I64eG9teiwunjLEirjwSg wb1EPynHuKoPqhz25lXpz7oP1PFffZEqe+qis45MaT5vQ6fubbNXk+YSIjdgbX1P+cAINQ1zEm2 7uMSgaj0oCkQU4Elg6jxDCpZePw/IM7HFTszTK5xZTfUl6n4YD57kWEAeTHqNKHzQHbKaC7+RTM
 K2zRu4uleAQvSfSw/vvXf7mBgMSZH8+bcp7YV8nfscqplH+YsPAINVy+cmZ6oQwdrFtY7VlF

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
blocksize but only if HW support. Otherwise we are limited to combined
limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
 > 1x blocksize, then just continue to report 0 as before.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: update comments in the helper functions]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 52 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f4a66ff85748..48254a72071b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 77a0606e9dc9..8cddbb7c149b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,67 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a minimum size of one fsblock.  Without this
+	 * mechanism, we can only guarantee atomic writes up to a single LBA.
+	 *
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
+		return mp->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (!xfs_can_sw_atomic_write(mp)) {
+		if (xfs_inode_can_hw_atomic_write(ip))
+			return mp->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a maximum size of whatever we can complete through
+	 * that means.  Hardware support is reported via max_opt, not here.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	/*
+	 * Advertise the maximum size of an atomic write that we can tell the
+	 * block device to perform for us.  In general the bdev limit will be
+	 * less than our out of place write limit, but we don't want to exceed
+	 * the awu_max.
+	 */
+	return min(awu_max, xfs_inode_buftarg(ip)->bt_bdev_awu_max);
 }
 
 static void
-- 
2.31.1


