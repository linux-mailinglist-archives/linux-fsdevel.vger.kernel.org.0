Return-Path: <linux-fsdevel+bounces-54051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3CAFAAF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65950189D4E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CD274643;
	Mon,  7 Jul 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDjsyyWR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MSWfXxAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0827144A;
	Mon,  7 Jul 2025 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866213; cv=fail; b=SuTzqEXMR1pfmBlJ5VtMEiVeqAg+OTU5JoW8/Q03YIFgDhpWH4jDyUYp6rlcOUbe0cMD++TaSs/hlu7nsBEGuNPcI1jkzl7qMJDq41l+yvoMIF/0GrM2Te+qpOgb8ztV3lwozda16HUkxFEpIfinzkp0WUHq6OgCmKTukXQQxFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866213; c=relaxed/simple;
	bh=sXJt6aqbDZwIZZ1rRzR1Im5hhGc27EsCypmwfIGanKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QG2bod3KliFpwH1YR2hWnSTOEK9rXXsmQa1QdnYVoycXEPQfn6/oPNWtmSO+v08/eTaTrRzEm++UInnIKopuITWRfSFYxkY9q7UuS2S7N5SGLbYDKHjll++JZ9WKmM7pTy2X1lA8tMa/ua2AWgK34lewB8Hp7pQtUuTqEVYkyw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gDjsyyWR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MSWfXxAj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ2qj021454;
	Mon, 7 Jul 2025 05:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HA99y+5DlXUSFWOgT50dXjeB07y57Vj9ZoRayk4sRa8=; b=
	gDjsyyWRgdwI0f9pjYdV/YZvfvuWsZWLzFXo0JlcZ0jzdmC60VzyoNw17dtjvvIf
	VR4QjF+PPkt/+HByR+9d96RIDKp4T1IgvcWt3d8P3GxVhLTsrrRrVrvlrZoJjdlq
	BktHxfkm2TWdhSJrkcYrH4ZJMHuusazTCL/rfxbWTskq0o+RXWv4kIujSLn33Tkc
	HVSJVkgJWefgQGJaRVV+QxTxCAHFSqhlA+WP8xm2VNto4fUDO3cYuba9yHjzIhrE
	jnDR3V7JXTniRJWEpETwGdPsp9OB4W130ut66eSvFEyZPyNg/RY9Hq3uKjhHGIhL
	Rl5bUgBbPhwVPJNEsS+sOQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptyfj0v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBj024285;
	Mon, 7 Jul 2025 05:28:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sdqx671VDEIkb8THU1/c0TIopnzr8iZbtY+B+YAVresmNAXe0lEzlalSSNnR0BfOlLdv2cDQ6N2BfWDZydLpF07TWWxZgmwlhVLjcvsN1Juy8vKRVyoXAjPCdBmCinPQt0ueZhd1K8LnUun1t/quWDLeMvDZYrVnIrESM3uzuzs7S1dF78qZ/Fo3xiYDDqwU91CgPEYIX5vnftNri2uAJWHElg94TaOHN+6ivJvO5VDBnZazxtsAys4QDaYrWCBRCx+E5txOb5ZPGJyxIHtx8pK4BKrvQLuuP6QSfTfO1G24yX0M0CyInZoYyKVAdgjdD1GZhbnBGUxqcQeXes2SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA99y+5DlXUSFWOgT50dXjeB07y57Vj9ZoRayk4sRa8=;
 b=jny/l8AbmEcB1Ihx0IvLwGojFsKXRkeW3Juoq8bqfVTA8MxqJGqe4wCIAuH5Jb/foJnmKGvscZl0t4LofMAXh2f8sAyg9b9hWeo66wISEWZu1Fsj0NhpBQSV40xD5DN+nVO9yPmtSLcKYxw+voooux5wUBPrl3TTE605AKcIOdQu8tAhbfJ7aG9GePCn7Yn1RysBII8a3+lvyQH0D9PJL1pBTfAOIRnz30XnLui2LLezBX8xrwxk8xUT77gK9+IG7gCRq9hf6au3FnkPQ1KezRf86sjg8tOjQ7XdfQNT/p/ssu098O0McTpuVIqtg3QYakjURowpyrsKtgxGuFjdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA99y+5DlXUSFWOgT50dXjeB07y57Vj9ZoRayk4sRa8=;
 b=MSWfXxAjjfbrYSoi/R5ll93eZ5Qb2wGZRVuY1mqKSvTQuUku5fdwFMbEDa/AaZ5srye9FbGX5flrc2zn5l7raMDUS827CwZqdVHd7B+Krkbq7sTrt65Z0Dg1zf43Oipb8+6CKn0g+OnDx61TthJCZVvOb+snuKhr8UJUYzTfA7c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 01/10] mm/mremap: perform some simple cleanups
Date: Mon,  7 Jul 2025 06:27:44 +0100
Message-ID: <067bd59f92c552fa4ed5bc22b051ec086bbc0235.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 690e4281-f40e-4a94-56f5-08ddbd171e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLJg1XecsHlZuGcayZ5vpuxcS3+tEouy21qo8GhoHjpKG3ycng9AIsfxVJ3J?=
 =?us-ascii?Q?cqfSwddbCEM9EvUSoRi6hneKK2FHCaSDZA40Hb01y85TJNHkWKqjWnC6uqv5?=
 =?us-ascii?Q?7Wgs9wDLCwotb2bg+LWRPX17lx3sOjCeYhiIXoSgVc3gWpEkQol0R8FdkSAT?=
 =?us-ascii?Q?tWfO5Emrf+l2mUURzDVoyAsIYJ4FqYOA3F0/a21Ko1NA0njmk0gpyexI53Ui?=
 =?us-ascii?Q?dlqGyAMdf6paXtK3yZeJu2WLtye8ypdMbDRgdTs3MCaFtH2YtQBNAEqyrLpx?=
 =?us-ascii?Q?pfAnc4v4QesZD3LuWZr3f+3m712lvJpk0rx5qYzcWdY10StP1aiBbllzwtpI?=
 =?us-ascii?Q?lLxyDeDYW8qhjHsa+TVQqftazSkvEiuiv7gDQbInkSkfmrcEW2R0G9xqHGAA?=
 =?us-ascii?Q?MvXSpjKataz35FXzhvZ3RYmu6AZzMT3ORR5Z3NGamytws8nhiHsBoK2lgAmJ?=
 =?us-ascii?Q?/bUmbBNusJHiGt3NJpwv24lYKUu6KJwa1mR5UxTppEbkwoOzhvm1QR7IsKfD?=
 =?us-ascii?Q?suF+aHlwJS/AKE8rP6OhQbMy5GwN3g2LRKMFjgS9rSYAXKZhzhLKJ5jIrwEq?=
 =?us-ascii?Q?qw0a34cUzUbw7i32BgkX88A5yU+jhZ+HXCZbLj5Tu86gvReD6AZh3SFchmzp?=
 =?us-ascii?Q?cLFiKV5Z/V8jFCrDjYxz+44XYvX00hCDt1n4qI3m3VVO90BTTALwVfBUVyAK?=
 =?us-ascii?Q?DPP1BMCSML8mIy/vFYnrKHGzbud23vtDobFphsOh8lXWriXE7sJybIgeq2P4?=
 =?us-ascii?Q?T/sNpXezFbeH5bqZMXkuuKzspsoOG6uYpR9muPD20RmiRx6Qkkwsu1CNE5Oe?=
 =?us-ascii?Q?H2PMdeYR6cjMMBch/xgYapE/U3dPovJsuBYijHZtb3+1D2p09Rhmg97cps3u?=
 =?us-ascii?Q?4j1Bt0kyL3cB2CwEMD1JJv5YREQ18OEW8LJljdcE8S+7FU6gdAoCTVFxs14U?=
 =?us-ascii?Q?cTb+3iNFvYUfigz47waiekBLamGS4/Y88MT+I8v3eQ8HXj+TDqZlNVWrMfgf?=
 =?us-ascii?Q?664kjndzVsviiOV1S3da6Q8zucc+50AYDOvu9WK3elT88Cw9T4I7FcY0M+e9?=
 =?us-ascii?Q?zu17SCrQSaB3K6QGYn+9S8J7JfNDSrW7ej+6apXDZalhUjkGOOTvtXawWfxy?=
 =?us-ascii?Q?9us5Q2wrc/PLkUQcwlmwCSy34PPyVqH2mJi93NMI3e5KnqGHRmbAizhZ15Bn?=
 =?us-ascii?Q?pmW0FCFBvgJco57hkU6kDYspnc2gMVTHjdk60w+UOv56Hbc3DOb+1x2ViWx2?=
 =?us-ascii?Q?FWtn5zaVnQnLU76rYQES0Nf8LJrbaOXVuqPL4kIAav+z6l91DS5BKvO1tVpS?=
 =?us-ascii?Q?/+u0oCoec0ba5nxKiX9qYFFYlAkcVkSt3ZlQvMfw7FG6wdJr3fIFpRcsrNJs?=
 =?us-ascii?Q?kdTfFS59UuCq9+PAD0dy+p34eNE7CTemZch6xLkQ/jBTAxgjI1bIJOYyNn9I?=
 =?us-ascii?Q?cwUu0PYMHpI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AxNJrtqMrjPgn9Uv3Tp00mA5wi0QmRcppPclWI/fx49PfuUzBgAEFf8rDLRR?=
 =?us-ascii?Q?j8brzJbk4PFDGhblpiB6LE8my9xNiq8obAq3fvVegHqBKFBKkLy4pqlypWsF?=
 =?us-ascii?Q?ecuqYIFzhlz7RZlcFpIABUGbK8MzsGyyDhhCRVxNNcUio+U+JSPxb99VgLww?=
 =?us-ascii?Q?rLyqp4VfOAtsMZjNHQBF1wg7+X8IYA10UdFnFkmwvfZQqIgJHVIMxRekbpxs?=
 =?us-ascii?Q?oAazQDXb5EFtJgO98VR1QZEGJaN8frcgerjXlLl+WTCTgv+O1xIKVLK/te3z?=
 =?us-ascii?Q?V70n1Zx2VrW/hJO7ZjC73oUdhQNlM7LsQGTmRw+P/kvmrGd3uTTYQUvgdD/Z?=
 =?us-ascii?Q?YGSUUzkNOJGfti/9jaGmun9dOVm/AO5N4S7DAE2Fh1/SQSxocRK32sLekNo3?=
 =?us-ascii?Q?XamZgKj1yQc3hKtRTtWyCM4BRU5TYPLdVbKsAagmKhl7N12L+YX38NJv96b9?=
 =?us-ascii?Q?UFrsr+MCBW8oU7u2fb2mGVkkVvY2iP8lz5JGcsYviSm83hn1OX1fXL/G5Xvs?=
 =?us-ascii?Q?fzT6p+uikr5COAt2oasNAYdwjZlq6uyqqxhjs8EEOMSqcv1qJazOSfK94yHe?=
 =?us-ascii?Q?pky+1XE2mfi54eM8FSG/QO1iJArcKInT9aEygebid0G27gavb/1HoCC5bj34?=
 =?us-ascii?Q?HUxRWLAE+3jIqnTTyGBa42oPiHZ6tLKb1zdCn1wvxwkJYLEgSaAi38FKvs0q?=
 =?us-ascii?Q?zjnq+IteLzGo6UiPaDVGRQ3bMBfhGnBYKPPPR/lmt5vkqSGUSDi2fseb9LY0?=
 =?us-ascii?Q?TH0h5mQwczP5sRHdeoruW9W+TH7NjNVvM9xYZkTv+Kd8kaSyUHOtikcSsBgZ?=
 =?us-ascii?Q?20J2Vc2AfmuXMXBblA6H5VyiB4OaqtJnGtDVkHY5XXgRcJXcijWtFmMnHriJ?=
 =?us-ascii?Q?ptifHWH70vT7dXKuQAiLPGg0eWLrczFD/mdbCwsFowKekLtuCwlYBhPN9VNo?=
 =?us-ascii?Q?a6zIBlhcLDxrSxoWTxuqEb4LQ89t30Ax6zvYpBBlFAd7TR34tpbQSUTry4vz?=
 =?us-ascii?Q?iK9ed7dlryGPOFv1Fn237O+v8HgDn2n6H6WpPzkZs4+w1sRv/2cHiiuhsfaF?=
 =?us-ascii?Q?bNpy3AWTiXZz7GmBUJjRmAuJ2/W7I7G/M6EvcWR2Nn1kvxI03iSrtW1H8E2p?=
 =?us-ascii?Q?OV/mxQe3+PtvmMHffJ8QmRNG8bLCxXwunzm2XHxX3yWQAfN9TmwPAxdTk+7L?=
 =?us-ascii?Q?SGfHzoTUczbSnAx3pLmbjydp7vWMDqmXVnWx19lqZdhgmLOtAgilf6SsMfO4?=
 =?us-ascii?Q?qeLMLzViCR3Z/YBU2NsOObslF/tQYdp0hLE8BwzTWQ8THhzIOhWvCXb1Zy8c?=
 =?us-ascii?Q?9jP2FKoMa1u9aeYhEg3QHBx7vYzbEFQppXeGM5M9b75KdCYQgX4CD03tQtuX?=
 =?us-ascii?Q?cukpUQhRAg4ZRlKRgcJVgXUjDmno2TTQ+9U6l0yU1wkDc4VA2UPM1tdCQxre?=
 =?us-ascii?Q?0AOGd5n0DXFEvSUeGYLltSWUMk+xqcm4qHElWKRjgWVANewKUOzuy0RN1cU7?=
 =?us-ascii?Q?yZGWgSD8aG00JZ0LKH5VfjbFhLivr41opjdKlrqUA4XlGW6hySZuo6huZhOb?=
 =?us-ascii?Q?WgdVoNR9f4WKjWvqNBWUwxUOE6ibb6AyVjvSKHG8TQkzfAVxUv4fWLlQGfIU?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K3TxDguwZaOct20uCROrVwXqbCisKfGw+3yuIXVsN7OzQuEpyt1zfGw7eGbawkdoZ5Au4Kqgr1klrQhgSToZ2gI9YO8B35rHkJRpn2cD5+cJMZVFNjOMVJLtozv7PiqbBGlbUi2uwfc9t/PxRdXcKIEBrqMxR8t316lYNk4+RPq3QFPJNHQQnYdqGeEL25CKYDG7expoKJHZmNhFICi7vvr3lnGCu6dTLAKnGPCHKx1VcPvUTZgKa3FWY5Z8Q5RnC2RMnfMwqbVJHCHR/G81h+K/QazXqlLwR5hw+OdtemHCf8h5b33QYr6mdq0d3GM+oF/t+BbDNfDqE7pihF5+q3OkpwdEXSjXgwSeB2D7lJG7ZpcVqwxIDE+wj+MmiPUL8syDCCLJwPkw9fIBep8jIhlDEMG8eQWOgAfwn/BVm0Ac3sL5TH8R3bx9SSTLhp2mx5xfs0BDgSbgNJXV2WNv+tnwYnOfKSvcF3pxLljPVABuC1pAs2XUrqaoJlRdwJAes+iq9wsIlKiMDafmxsqYW9Lkdx/iBVJRjx/mhgtB0F8jcEWKqJd0UYHMhOh1GofqsnpUhhEPDKKrD11/VnUAvtLWl0PgLFcbjHMFeCORnU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690e4281-f40e-4a94-56f5-08ddbd171e80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:35.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sOO1NvbhN42BfpouMzMDS9cVVGnADDgGG5zxrlX+G3pQxG8iNRF1PZDr4fIC0cP45EgaSa+e28B+NzQCMLm1pPgziTMM9v0bb1B0oqmpm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=686b5b18 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-y-8OK93jEFqfRmHsx8A:9
X-Proofpoint-GUID: lDo9gyclB1EPGxXYBRh_lUsN2D5Yh80g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfXyxW+H0E43ant XEk3Wo4XvbMpW9eydrU1yO5xG8YVcig/WS/E+c2fKEnX0+xnE5UbPvALQ2XQaxrUZqgh23XmEWS NDd/qX7pVTS5s2kweRr+7rcc/ovudJJJkKoh8qOVFGCFDhtY39f7QY7ZaNL8lqLHBziqIA8Qww+
 pU4jRTz6QRZz4LDBGEJCVrX5w0yHfMw8d4tyCmC+czpBcrSyf0IbGEvMCdJU4WS/lL0n/iziBS5 wyRTsvj4KuN3bHbncOXp1qk6me+2CiHZwIppTHtRwqwhUd98ATV4X8lOekcS43xeajkgBa/NaSO jTx/5de1uFE1MgrtT01Z0mm6c0N/4xuyRjMDtTRDFec9HBa+Z/o1ptze0wdy0OwTbW82ecAQzal
 bZGV2Kk3yp/UaFKt9A+4HToya9ByiSioLo3AS1/H0t3fKsgyI58OAY36NIBim6X2xtn9O57k
X-Proofpoint-ORIG-GUID: lDo9gyclB1EPGxXYBRh_lUsN2D5Yh80g

We const-ify the vrm flags parameter to indicate this will never change.

We rename resize_is_valid() to remap_is_valid(), as this function does not
only apply to cases where we resize, so it's simply confusing to refer to
that here.

We remove the BUG() from mremap_at(), as we should not BUG() unless we are
certain it'll result in system instability.

We rename vrm_charge() to vrm_calc_charge() to make it clear this simply
calculates the charged number of pages rather than actually adjusting any
state.

We update the comment for vrm_implies_new_addr() to explain that
MREMAP_DONTUNMAP does not require a set address, but will always be moved.

Additionally consistently use 'res' rather than 'ret' for result values.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 55 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 1f5bebbb9c0c..65c7f29b6116 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -52,7 +52,7 @@ struct vma_remap_struct {
 	unsigned long addr;	/* User-specified address from which we remap. */
 	unsigned long old_len;	/* Length of range being remapped. */
 	unsigned long new_len;	/* Desired new length of mapping. */
-	unsigned long flags;	/* user-specified MREMAP_* flags. */
+	const unsigned long flags; /* user-specified MREMAP_* flags. */
 	unsigned long new_addr;	/* Optionally, desired new address. */
 
 	/* uffd state. */
@@ -909,7 +909,11 @@ static bool vrm_overlaps(struct vma_remap_struct *vrm)
 	return false;
 }
 
-/* Do the mremap() flags require that the new_addr parameter be specified? */
+/*
+ * Will a new address definitely be assigned? This either if the user specifies
+ * it via MREMAP_FIXED, or if MREMAP_DONTUNMAP is used, indicating we will
+ * always detemrine a target address.
+ */
 static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
 {
 	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
@@ -955,7 +959,7 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
  *
  * Returns true on success, false if insufficient memory to charge.
  */
-static bool vrm_charge(struct vma_remap_struct *vrm)
+static bool vrm_calc_charge(struct vma_remap_struct *vrm)
 {
 	unsigned long charged;
 
@@ -1260,8 +1264,11 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
+	/*
+	 * If accounted, determine the number of bytes the operation will
+	 * charge.
+	 */
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/* We don't want racing faults. */
@@ -1300,12 +1307,12 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 }
 
 /*
- * resize_is_valid() - Ensure the vma can be resized to the new length at the give
- * address.
+ * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
+ * at the given address.
  *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vma_remap_struct *vrm)
+static int remap_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = vrm->vma;
@@ -1444,7 +1451,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1569,7 +1576,7 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 
-	if (!vrm_charge(vrm))
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/*
@@ -1630,7 +1637,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	unsigned long err;
 	unsigned long addr = vrm->addr;
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1703,18 +1710,20 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 		return expand_vma(vrm);
 	}
 
-	BUG();
+	/* Should not be possible. */
+	WARN_ON_ONCE(1);
+	return -EINVAL;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret;
+	unsigned long res;
 
-	ret = check_mremap_params(vrm);
-	if (ret)
-		return ret;
+	res = check_mremap_params(vrm);
+	if (res)
+		return res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1726,41 +1735,41 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 
 	vma = vrm->vma = vma_lookup(mm, vrm->addr);
 	if (!vma) {
-		ret = -EFAULT;
+		res = -EFAULT;
 		goto out;
 	}
 
 	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
-		ret = -EPERM;
+		res = -EPERM;
 		goto out;
 	}
 
 	/* Align to hugetlb page size, if required. */
 	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		ret = -EINVAL;
+		res = -EINVAL;
 		goto out;
 	}
 
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
 	if (vrm->mmap_locked) {
 		mmap_write_unlock(mm);
 		vrm->mmap_locked = false;
 
-		if (!offset_in_page(ret) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
 			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
 
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 
-	return ret;
+	return res;
 }
 
 /*
-- 
2.50.0


