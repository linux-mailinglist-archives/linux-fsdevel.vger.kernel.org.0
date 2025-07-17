Return-Path: <linux-fsdevel+bounces-55271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9273B0925A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390497A2812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284172FD894;
	Thu, 17 Jul 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJSIEnrK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WkmIzhR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43C2FCFDC;
	Thu, 17 Jul 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771446; cv=fail; b=F7aHrelaegeCoWZaTFr01BLXjODBhOThe+aSA8afOhH5VLs/fho2b5QY2NogpKYSLNFALNJd+KnLFlx2cWQu56AQt3lwChXmpxb8j+FB0kh+bXyv+jihDsGRivdFWTKFUauXIMDOiq94wfsCwrMGlbfuTE95lk6chpFajPSq6ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771446; c=relaxed/simple;
	bh=myxjXRNtsF2ObIzZxRmLFiNVJVKHjmEOhT22GdYZ7xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKculoEccpmsxH2Puq0Da84B51XqUefo7xIfHx8IeYwH+8MBMkyj3ym5f53isg5rZb/EPkv8q7oT/b818p7C79jkf6Sj5UanvQOdapB25aR5KwqkwVNFoBZCWAClZpCsiU3NezLNkXfL3T91B5q3PPL1IKahEZYnY92TirF+0gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJSIEnrK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WkmIzhR8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGCSTE005754;
	Thu, 17 Jul 2025 16:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pdb1wpw54s8wwl2mv0ErlIiBdZ2FUydxJS142NDlmAY=; b=
	AJSIEnrKwa/eFtwGKAg4e9NjkOZXJmV1Ua51B65CyA6Oyjo7F8/xQ6RdJPMAFy5e
	CFQio/TqZtce3CYBdabHBKZXkgvCtvDzYWLusR4ruydnwCL9BSgU9CSN7wsc93pR
	lTy1lGx7qd6T9NR9sKb8hWD6HWh6Y9cBO6ZaaFWBBiQWWM6CaHyVZWcm9CMAcCdW
	d00G6d9PTw5gASHtqEF6KZBIveNwViaUwp6BhhvDTlPZT7Y/sbWdl3TuJUFR1YTu
	dVbVAI459eCG/+CNGiWRnPzEuBh1+wQtJA40q2Bh8yMm9WZiBnuafLOlXxZSKf1G
	nv+fKQFOND+XP4cUCUqdvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g3mwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGjnju024098;
	Thu, 17 Jul 2025 16:56:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cxyg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn3+D1dDzAglXxcVoo02KNtnLWrFgda1tVWubG62iT4AqBEwVNLt9cEljm0/kVp18akqVp4UWJwdSmsuZsCQulcCgG+Gn5CZULVxM68P0NZRXhd3Dy70TzbYsY9Zy/B1rdVFaBPoSJAaIfwIX++K5FDMllCwcatZD8W372WNugB6IFp0cdvp8dDtFNHvCxRXpxMrx5R28DGaqB3YydMw8lcNkaqBLoXDxchQ36o0V7gMKgYfrgl/xZpYNztE9sI2IKxhaeLdWDcXw6D6gh8uhnDmYb9GNjuT1y2YP0hlL5yhD056QemGUyhc6dou808D9aJINUJSbuA1FMSjYb4TuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdb1wpw54s8wwl2mv0ErlIiBdZ2FUydxJS142NDlmAY=;
 b=eXhmKN4eDKBT+cXJLdNVOYj7XhN5OQWRz/owSDdsIdy1mQD5tnKZzBNSiN/ZjfR8frAGiltVberWWTiUjqVz1On3B/9ESq/AhpLh1azHzD7HJYH+c6Y4RmHhURCqcaLeA9f7A6uvNfWRaZY+qjk/e0xp7zE1rfQBQvuznxlBPZdFgqeWBA2/wyCmntjJGrjyQwUHnzoqigkCvqMTVot5TpzVceALShg5AW1PjJ8+zcI96Gxn6QtMGXEDqxX68nmRb2GlSkFbWknws9VkupcL06IhKIvFOvi6ZY8jbFEy624+zsfKqmE6H+rLMOTM//cvAPWaXNay38Bvq9zynyyjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdb1wpw54s8wwl2mv0ErlIiBdZ2FUydxJS142NDlmAY=;
 b=WkmIzhR8nN++k+YG5MDzaSLBNux6IeOC/LFBtxbs+FLhVOH8RRAzi548/cUODpip08+Q4B3kGoFpwojXcJsdCA8mRajYJGIFQZbPRXk0uh/dHC07LsLaAaZa6PtGrGjTXIWpqu8Hiprl7PgGmbCZLDTc+WRe9OOn7AqJPPu4RBM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 02/10] mm/mremap: refactor initial parameter sanity checks
Date: Thu, 17 Jul 2025 17:55:52 +0100
Message-ID: <c862d625c98b1abd861c406f2bfad8baf3287f83.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b707bb0-816e-4fed-a47f-08ddc552d4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1VaFlwDijBBCDLXc1WD3tacgHrlKDWFb8DvfQS+CcR8DdGkq0eKIatd1LXQ?=
 =?us-ascii?Q?RyMr9LXlDNNYOAxjE/3AeAoH8hSQHRF/pl5Y+Z3cSJzg1ZjsO7+pK1OhOAyu?=
 =?us-ascii?Q?qqSUu35/J7LsAu+A5z8BvM5OBkc6NjUNU/12pbwezmSmVNnYPEzYNPDhdlmJ?=
 =?us-ascii?Q?g1r+RwQU6L4j0I5Bj+9lCzInAfhZpBNaqVaeOJlHbLsW+7sPjescAiK4goo+?=
 =?us-ascii?Q?tjRMPb4GjxERujbdLu1regzIYROeHwC9CouirSED5lBWpQvTVp3BRintwExy?=
 =?us-ascii?Q?WCr1y/tvqjXAL33x/pmpQyYxDosefCK4N98sn82tjDhg8dBc6RzSB/Sy4kS7?=
 =?us-ascii?Q?bhqPgZeVejIjvv2YbiQM8Jsh+7WVoQuTM1wMXizRAQ3zUoAY7cgRrnY0GTvL?=
 =?us-ascii?Q?UUB1nKPbJy+mGteVGVNG0HnApVzsUzjnfMnKyJKAt41TD4gA3qMFfX6gJ/se?=
 =?us-ascii?Q?sqKmCOlinWg6UnrxNRsEAb6ToFNzbJwcJY4A92vOS9gHyYay4pD/NyYPkbgP?=
 =?us-ascii?Q?auXAByu/SQKpjXvzvqoyPLTeQFuldRp6Gs2YlGumm/vDUyRjohc2HcRcK4Jw?=
 =?us-ascii?Q?abu/tMuycFo7nQIcRm4cL5xqF8BkRuVktRSAEZfDPW6niMsx3rY+Jc+SWkuI?=
 =?us-ascii?Q?BN5x0ZAuTgYTPtLGS6luv72+uhp1YAx1LVonb6VrhQiqHxLk9ug24P4PkVLc?=
 =?us-ascii?Q?WYeijwubwdS8d/s/U38/nBEmaUnuZ73BAkXtTFJI23hHLK6ZaQEBZAckNsBm?=
 =?us-ascii?Q?cG457XRBpGk9YW6Wn4oB4NUteSMLipQW+JuxBvdzhMZtk/Zv4xQWhTcgUFPQ?=
 =?us-ascii?Q?nHhYfKWjKfj0tEQGiBciUIscrGBF91V6+dPv1BAAVXd6sT9lzbqBPZK49i0w?=
 =?us-ascii?Q?RWNpE9WQAA73sC843+NbR6GDr49t/eMHsyraC+rIu33o/0HYRCvbqm5d5y3u?=
 =?us-ascii?Q?MninfC4ZppUsww2XGT9/Ih8e4MzSyf3q/i8Z4iy58D8uTPXrMjt2B3ECvZTY?=
 =?us-ascii?Q?aJkeZtXCXomeYjST8fNDF8jo8Jj8jcdvyjM6nUh/18yCmVi4s6pA0YnQkKRq?=
 =?us-ascii?Q?2QJFMHSNx+XN9mdTAS0TTv+esk6UskRg8ZdUPFpzVK2PBfJXJWn551/mpJOr?=
 =?us-ascii?Q?mDaV9Srh6a5+X3T27JMJunvUBjJoVLDHbgHM8pDqbNvCUQtG6P7YcRC45WxD?=
 =?us-ascii?Q?jcqtKQ3I0a/aCWkN5r0BCXTP7nrrpS3KdAjs5qYRrlLjPofvUujFW4uZ8X36?=
 =?us-ascii?Q?26GbAMMMH3o79fRJkH4RLglqlrbAa8L89iMDo3BfHXlb+rVoCh7EZPwWkAmh?=
 =?us-ascii?Q?leqZ57107KWODgVy5HMdu2BCoqNsCa3w4ZMl2Dr8BP07dWppKmftnVJf1lUw?=
 =?us-ascii?Q?2Sfbp2zr5lIFkFOzlNsoiZDPrpEom8h7unK/rc930jmVGu/ulAbOzwe7ROMZ?=
 =?us-ascii?Q?xuojxK1UBW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPF/yPU6lDuj7RBAK0z3BDRsrcRLTUXFJXgBrRMCLvqiUsrEJkSRejMveZRM?=
 =?us-ascii?Q?51NE5Beb/3irYmp4ZWU5C7fVVQ9SrXFNBGIo4UV75X52udnkuwOu0dR85WyI?=
 =?us-ascii?Q?Dm6b5/PFYcMTwjUqMees6jGOWuk87O6r1dC4UqpkWwbSqZVlW9JNEaXcNNtX?=
 =?us-ascii?Q?FvqdtMRP1a1kB4qZPizfy04JPp/jf3roYCMIRyBtNoYhZfNu2Pv6LG3sHE/M?=
 =?us-ascii?Q?RqNMC576n63ueBk6R3YZpUHHeIb8z3IZCmIEH/5vfW/4q64kC74p/SZlG2BK?=
 =?us-ascii?Q?0UNuWNw4LlIuFsh8pHpD71KiLTa+Whf44EeegZt2Vgpt6MqNuCVow93N+CeK?=
 =?us-ascii?Q?lSIdlMzB+lMnBlbLzOZvtVz/qNHlzd/Ds6+3s99VjGVtQ/HClruFEDHbRyeD?=
 =?us-ascii?Q?zmcyy7c9GJ58WKCo22o/IquHfzEg7vsFZyQlZ+Ixa9Kf2fvQid+p3gIknWg6?=
 =?us-ascii?Q?C3zX0ww+3IDDvEocWkzA1MIf6uyZWXrg9u4u6tiYrzxbB8GojunphWBMd8ht?=
 =?us-ascii?Q?/o/cyVFiBaL+Bw6k9j+yW043k+x4KNKgv7rKNJ/175eFkLKEqbOx8MxD6YR1?=
 =?us-ascii?Q?a7TTb/oXzkys16hJo8uIWdf6rYeuSBgRbT6EjYtNl0vojWX9xLGkvgGiSUXH?=
 =?us-ascii?Q?ddmFRIUwm2OO7C3oAyFc5b2dOHxkfueadZFn1Y1V1jGaKj5stbtKN+wKHmyd?=
 =?us-ascii?Q?bA83hjoft8DVprPifdAju1Qiv9DnxhxjqxFXY/AsJ3kjPUBl7RPqVBLWCAOB?=
 =?us-ascii?Q?MJni3EUOjFT511qmfGIPhkjEAJ4uBFtcVq6u1hu+Ccy2k3b6yCPUOkgdGiou?=
 =?us-ascii?Q?C8uEQWqwTjqR05Wm21IQFNymAZKk7KIdnLRp50zk16cHpEuyNbqfp3rMdlLz?=
 =?us-ascii?Q?MmRtT56PNUwy1ti3eEniuKnaviurhzRclFZb2P8PdtD+t8nm7Wjzj/eMGgS6?=
 =?us-ascii?Q?p4/U507MN/QMCqIUlmwHtbVymbqXFaDsamBPWKxts5UTwwD99QmspnHDSo2a?=
 =?us-ascii?Q?oS5GMvMBQPRXZwUx/PSQPcOIjmjfISk60YUYYxo9mZr54b7okvTOEUrjEd6U?=
 =?us-ascii?Q?vVFsNFi2NFNzdHg3r5P2SNWogWhVWDRyhPLXxcF7TQeiVQOoFGJqyabTcowq?=
 =?us-ascii?Q?pjYiiUdT/yn3L4soKLxchf1xuZhvT9TiASrrFkDBWFXSrNDkxEr3UwFG21Jf?=
 =?us-ascii?Q?CKp7YgdtGm+OoVqQ3BoFE2TPmkI+O4NE+e1DFk7YSufH588Law/Q85wacMBE?=
 =?us-ascii?Q?B0tatwywge1j10cEGHWafcChXs9pmZW1iYFsPwJtEqyVMH96UXJVyyvu/D7x?=
 =?us-ascii?Q?usAIo57Uf5kXwJZ+9VLmmrhkN5BriPwcG0JbTka+cTYhM77E8NBysHn/54Bi?=
 =?us-ascii?Q?8jjBoHclpVdegvMbOmhKo5v2Vy/nh2wK4m5m5PsmZ3lPVSD38yPgHI324yeX?=
 =?us-ascii?Q?o3d9lZnqyBLBtSISbGSTeZI187t4FG+fN1vl8lwLTwdftxoEpJiUM5e9JUOl?=
 =?us-ascii?Q?Fxh8IjbMxGLxbLOyOj2CixkvMETcDh2Nu3VuZI5vEsp+an31UMnqdvJ91uYl?=
 =?us-ascii?Q?fBj3t0++Eb8SSWkVs3pqEjbrQGItFJvG7iCru3irokwxcDtFMw43HhgI3LM1?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iR6yvnzePEXl4LY7jr0TQU17MIGv2XGcjpW40QRHHvSUuSSFPB7UfEH0bRZ2k1H1aHmtZLBkolgd0KmZCMV3TrK6RUlROX7t58cXpZeT3e7LWMWkrSplaS9zSsduF5+bL2wwANOJ+fIoP3WRO6zwkFSGQXwiqiJqlY0FcS9RLZtRRbybFEHitlwijy8Tw6KOgDvH2+ZWknGu1prl1NVl1+R+2RdpYHmXYLi6zyf3p5pqAr7+IKfmHwG9r6X/NLWWhfF0GnHuvaXLeG8fW3P8jwfpzl9b4Jrc/NvjfqqgNKZmt+pcqKejQcbxaMXFYy9hx9cFm17BVUx4xXV/ZQDCl6CXmC1BHj7Iq5bSbR8vEFWG+Q1gS+7VW2qZ/8hdx71yyUrpxj0DJz1F5I0F9oJ8qh7b5PTXtfx6X71jy0ksGj8r768al7HryPJorUGSpDgnxqUu+TEh6+8F4H97M02ag0tR9hQdUD0P9qbogdvqq6nY/l+7eElXxCpH5PGKkfMbI+XnfUIl7XnpWbQJbh7AW8FYrKgJ8xo37T2RfkZxiAEo3+oNu062DBIjtTLx9nl+NYkRDx8t1MTIFOoD/nkYe4+R7+yGMyIpVbR3C/V++QE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b707bb0-816e-4fed-a47f-08ddc552d4b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:10.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ptAv2gg3Wkdof/6LOEHo35f2DROGFPT5713fIOJrIzZkCaIDgsdfrjQt4xL9cS8S3KT+PkycwAn7VR5AZyTXoiqvBKldeg3v8DjdfbFWsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-ORIG-GUID: jxsLn6SxItdqvZlf47_MnEqDNIuAKPfy
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68792b30 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=44BLHjD3IfhdABlFFWYA:9
X-Proofpoint-GUID: jxsLn6SxItdqvZlf47_MnEqDNIuAKPfy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfXzZGtk3F5ZVGF yO0ZxKoEolrcQq/sJ/K9j8Zr6ykk3qe/52oJrHkQ+bmxsk1qVh15bGwT08p6XmUQ5iRJ23gGzks 0kSExnk5altWpOVQE+94fbX7ATODbJZlcQ+rVvLBkGB/CgursPm4MA0DFNpydrRIdSvILtvz25G
 2Zd80GSMoq8y6zPcXb/9cBKbY93VAqSMmcpFbSQLY04Ry+JhsqsQYEassGLDvya3QDNl2MZC1M9 yn4T92FLjyIFDvoOYEwB+Yx5ZuorSyavQdtdjega0ELFakfaotb6QcXEqgvsrHpCF/gIj89Hl2H 61LhqbX3GZE/a6wf+fBPCOu3HtlmfCLMztx/kCL8U5eM9Q4b4lYrR7+DB2B8yMo84SsnObeVKXm
 +pTzlYA9wg+NxwOizQX0SqYt7lOIqKI5KwdX+AFLPypNNQoXMBzTfSVQPEjOLfwUAyrlmJPI

We are currently checking some things later, and some things immediately.
Aggregate the checks and avoid ones that need not be made.

Simplify things by aligning lengths immediately.  Defer setting the delta
parameter until later, which removes some duplicate code in the hugetlb
case.

We can safely perform the checks moved from mremap_to() to
check_mremap_params() because:

* If we set a new address via vrm_set_new_addr(), then this is guaranteed
  to not overlap nor to position the new VMA past TASK_SIZE, so there's no
  need to check these later.

* We can simply page align lengths immediately. We do not need to check for
  overlap nor TASK_SIZE sanity after hugetlb alignment as this asserts
  addresses are huge-aligned, then huge-aligns lengths, rounding down. This
  means any existing overlap would have already been caught.

Moving things around like this lays the groundwork for subsequent changes
to permit operations on batches of VMAs.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 65c7f29b6116..9ce20c238ffd 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1413,14 +1413,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	struct mm_struct *mm = current->mm;
 	unsigned long err;
 
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
 	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1525,7 +1517,12 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(vrm->new_len))
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
@@ -1544,6 +1541,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
 		return -EINVAL;
 
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
 	 * it will bail out at the very beginning.
@@ -1620,8 +1621,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 	if (vrm->new_len > vrm->old_len)
 		return false;
 
-	vrm_set_delta(vrm);
-
 	return true;
 }
 
@@ -1721,14 +1720,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma;
 	unsigned long res;
 
+	vrm->old_len = PAGE_ALIGN(vrm->old_len);
+	vrm->new_len = PAGE_ALIGN(vrm->new_len);
+
 	res = check_mremap_params(vrm);
 	if (res)
 		return res;
 
-	vrm->old_len = PAGE_ALIGN(vrm->old_len);
-	vrm->new_len = PAGE_ALIGN(vrm->new_len);
-	vrm_set_delta(vrm);
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 	vrm->mmap_locked = true;
@@ -1751,6 +1749,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		goto out;
 	}
 
+	vrm_set_delta(vrm);
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-- 
2.50.1


