Return-Path: <linux-fsdevel+bounces-42979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F49A4C998
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E8A3B9E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF16254AF3;
	Mon,  3 Mar 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7B8OucF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="glKVoG9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34475253F22;
	Mon,  3 Mar 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021926; cv=fail; b=HebY3k4RNvAD/s7MAOdr8wYXluK1nJQZgg90tjfoKz0lEXjEYwxt9zhxGoRqLsDKLM+m9z6DT/YJSbkVrG4g3xiL4swQLMmPDc6cQh6dayScQD2KXHdGxCnK3XHBEAfnKafjDAez5iuv00q2JmoP2BaIwM+ubJM3Ahj2zoZqcU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021926; c=relaxed/simple;
	bh=u9qSvhBTFJNC8NAi2xtS6ZybO1LBv2KXmZqevjQ8JIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPG7eykasVfCpfnCtyKNqW20Jg4OUpGuOts1QISvDC+A5ragxmK5KVMzdcLzvr8lwQOoAPTBCzmBGox9A8EJ/b9ARwgRejRBezQq+eR9pCr7yU+rT7cvjfWT8vrHR7IErqjFXVhCx6o7j3XQ2HHAaRsEOIJJBUevzLUZSr176h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7B8OucF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=glKVoG9o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GGJnH009360;
	Mon, 3 Mar 2025 17:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OWYwa/5i+Jj8/qJpWDTKU1Azcekr3UtxyL2aK4F39t8=; b=
	Q7B8OucFpAlhdYMeYNheKLjbJQbxZJ5SSjpMVm38nLT4JCVwouww95NNyzqWVHfo
	AV49V5Ynlt4V18TVV361YjpvvyI/REO1yjtG9hwvzHJl3VDCvm+3Y65mUbQKdgLb
	a2Rnuio8Pf2sKEx22WCWBHggwjMtN/j1KDUYTBWJDf82OrBToDcSFrIWimADqgc6
	5Cp1EKdDS7bv2QpfOe90ZA+0RMcxaTiQ93gpyhRuu/+k2HYBxsBKu1XaBeV+16qF
	WZmPunZUX9GglH6azwmZWc9MCSiRDp6CO9vcowg+WwEmajy67CAHpA8P7VneI1uF
	RwTCx4eL1YEaWIKu32QU8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wk511-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523Gfvs2003202;
	Mon, 3 Mar 2025 17:11:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7sj1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEYvVRSwJyAO4sbMxdyk80nS3zZD85lga7CnBlMHke4n/SPxlv3kBn/8yEycXw7QurUBZi9WTv8VYBJHAx0ZtJzs/HsmIGn6mEbGZmBpzR8xYe6SkLSg0rWMazMtHMdxw8mGIUR0NOQdh48RCzeqzxCpIhYN3ZiMx+8SBHJ+CRTbggd36vzqwJrLrQo0FhNRdtVLPSgr9XjMIZBwh35+lL3FaQNzWgZKTAxbUqS1Eo+M/UI0F7w1g3rK4qk3lYWncrAIGz8iMWXO4fGXbY9ucr+DVk0C2uwXYnfM5WJPIA1uZhdfXamsW+eP1yqCyVK7+EVZrtH76dwk9WoB4+KCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWYwa/5i+Jj8/qJpWDTKU1Azcekr3UtxyL2aK4F39t8=;
 b=puMps8tzycIj3EH3b8JkqWgZS2+I3WCPOtX8Un7jb1ofhCS1BlurUvYTOa3iG3jR8s/x3NcbW0LQuXjH65rY8DD3JKbjf5XhTH7pq/No7R7oYTzIzSjtW5uonmse68za5SjlzABwiPR6KzriWLwY8rPRVfmgZYTpPeAVfcr9YE78C/rJr/V0PXkAm2DQEiuppxEqw+5uO7+wbiBjJF/CbiPXj1ommQdptUEg1DRy2Yo3zrHCPSHYYfh+W6VfPIAXgsGFog/IPKkZ4BpQ3H0ts+BOq2clei+2ZDoGFSPzNPMTLHNZo3nZcLOmrUKJ75v1APHUZAWaLlqzP3p++zpx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWYwa/5i+Jj8/qJpWDTKU1Azcekr3UtxyL2aK4F39t8=;
 b=glKVoG9oWreVlKRn7xKNjc9xflUatUsHxJEj9Cok0ieNKtpm75HJm7bMalHSXyQZulrqRgNKNonsOylGZXaVsvdAU8d6z8yWDhitB7zuJ8GHIoDz2N4wQVN6aw/Q+PhwJU5ljv0P9vpmDUfr5QHeAZsAo2GK2dDXaw6FdcGPsXI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:11:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 07/12] xfs: Reflink CoW-based atomic write support
Date: Mon,  3 Mar 2025 17:11:15 +0000
Message-Id: <20250303171120.2837067-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0399.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: c2146ec1-e275-468b-e0bc-08dd5a767f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?angABOBwD3Ztm2DFVCAK9E2EShxcMGKZMhvqaAld4ebXeA9eTVnchwBvw2Xq?=
 =?us-ascii?Q?F/BuluxWrn5/3CoUr0AqDs6xnsEAQBC286K6eVMLnq4TrklzlyKAN5/TmUbC?=
 =?us-ascii?Q?GVDUQ6GHuauZ4ugUcVG/45hRfng2NKw7Bd8uikONXKlbCf27mmN7ILafsopU?=
 =?us-ascii?Q?1idwH9m14wXKoJnM4JYBSFfRul00pNWLB0CBokTX+L+lPwCfXSVoxJ0NXalZ?=
 =?us-ascii?Q?nf/fYa6/lbPwDlrNu4QG64j3OI24XljduIg2rDhUSYy+DWrDKj9oLAKb0iqX?=
 =?us-ascii?Q?vPaXsmNw0Vyx8wvkRNGT4lVKgtbn7kr0tVD4xGqQ3ft4WHxkf8JeJlhXoInN?=
 =?us-ascii?Q?6lqzELKmcy4MKCscaX3O0nH/uUQ6T1RyAn4pMBbdIoulYl02c/VD3ot1lxQ8?=
 =?us-ascii?Q?HOvigCVdbV0XwLCoXypuh81GvOXHtggXJNmVA3qEsnfO2bMzMLTt0fTGiQnq?=
 =?us-ascii?Q?jxEMTNGVylBwxPV4B2WxKNaUJ6oNq8XF3y+FqMu5tiLQelloUhI0TZIrDiA6?=
 =?us-ascii?Q?1SlZGKEW3IumdkSmJ+bGN7c7XGifCA+tQpRf1PZTqd5oSx+mHI8VJ6mBZjzU?=
 =?us-ascii?Q?wtnBaPac7gW9FQ47AJbZOTLWeFexsnH+NwS+0+5LScGK/XORxST1MKaxdri+?=
 =?us-ascii?Q?79PdhvOW0iN5ld0ocYLBkePofE3GVdHIIngxeZLTPuqI2sopbkix3pmSHQHP?=
 =?us-ascii?Q?u78+58/iPHSeYczVM20RUrhyaz8W0mpqnMkEtqV2nLsOVv1HfUssYuok3Ns9?=
 =?us-ascii?Q?SCHfoWGCXnevNTZbMm7AY6zWzP9osAgNE8J9O+jmlowKYJR2gyi4bVksMxsb?=
 =?us-ascii?Q?uWJ2KYHDSsG7jG6/Rfx2BT7hPNcAFTxpSkJvO8Qiel+PEipeKB6pW6lR7AI4?=
 =?us-ascii?Q?PrTrTLC29/rOiBIcAlFykOzyZ9TLDD09CayP3aBlLhORnKgLsvzITu+m6IH6?=
 =?us-ascii?Q?HR4ddbvLAArw+IJglKuPdVeADJ3Jfl/VRJ+WDk0hjXgku5W163nsEAA1nBI0?=
 =?us-ascii?Q?7cdrV2Xx6Pgj/xMMGX2xvle8u4Eq//sOKgSWAyOzF6dND3kRVfhu53laLEkK?=
 =?us-ascii?Q?3e2iAxF6vkKIh/Drbidw0N5M7lL06Xq3Yt/ZdFSw3+VF3HYHTlm/HaAG/aJT?=
 =?us-ascii?Q?fJqHBa0xXHiQ1B8Uhf6+HsSpau9tb/tOEL9+t3PPonmJbxUZzBFoGYy/q2jQ?=
 =?us-ascii?Q?LeetXDgxUZE7RN4XJCE6h+tj10N6JRExZkC+fCyK8MD/mryePdsYPWzcemHs?=
 =?us-ascii?Q?D1YStamb7XpMdhL0GvLomnvuUIzrVNF7rArf0AAqoWXehZ50BO+mSce4yI3d?=
 =?us-ascii?Q?JI6TEj+Gep+gbpkjTT5Gyc5elO6CAcnTN0h6zcLIRyq9vidPLGbr48LYcgaJ?=
 =?us-ascii?Q?ZZlheLrDle/MZ8aR89XZkBejSxAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XA77AIeRXmjklNVFZ7EGRaL4NIMA+tkGn3mmm2HAOKYONpoP9qCkG90Fy6XH?=
 =?us-ascii?Q?Ts+pOh/WgnoOY3isy87GGlkHGN/BTpYk3DBBJMCGBiEN0wxhffDKvRNuOOeS?=
 =?us-ascii?Q?jfPbNBZNUokCQF2L2JMKCgp1DpOmEUTmPrAOgpw9x0jchYhF3ams+0Si6BTf?=
 =?us-ascii?Q?c0aSFTrS4VUWOQXUcrrfGDSYfBYzJzAvSiWXEaj1vMbnq8jgA6VD3tAQ+vex?=
 =?us-ascii?Q?7BF3LiIiQRW7SwD4vkFf0xvGw2SyxclzTDRIef1tuwBJe/m+5lZALyV/601C?=
 =?us-ascii?Q?oeM490h7rt9DNXSa4nQpBk8nQ4NtccbTYNfNRa9+VpVoFg5OTNzOQbvh/fFm?=
 =?us-ascii?Q?XCc/KqFCi2/rGvU+c5VwrQUV4O7vsC6I6ldacLoeSZaq6J2mCmWm3J8PBefE?=
 =?us-ascii?Q?xjQ2L8sW95s5QCmtCsorwVn/e5MRYFsxg4381iZeETVyKYYjOe6QtpOXOUK5?=
 =?us-ascii?Q?71+IlFFkBezyxrMFDeqM40bymot/JrM9uP9Q054DzR9cgrJzg+fWDd9mHoY2?=
 =?us-ascii?Q?M4cD08CooIaZ/dA5aelx1QBWJ17MVwIWthQGeVm761yj67GAdm6ag2lEciLh?=
 =?us-ascii?Q?dZf7m5/jX0bxEjzU/CQ+rvSc94igX2CNouqWcZ+DXMGojm/ZEONq4blrwlTr?=
 =?us-ascii?Q?is6TZnS3kfjci5IuPgBGE5pS8YDLmsMl+nnGG8EgXy1Ge3MApu64xi7YtAFD?=
 =?us-ascii?Q?Tr+YTrluLj2+NMZd1SH3HzDbbmnZLdHF5IWKCbfmqx0VLjgOa2/x1DPc9wCl?=
 =?us-ascii?Q?w12QylSFhSaeA/8kElxbOu3FtypQ5oHBCAkSPClV9la0g2BK04/8wp0BXNI7?=
 =?us-ascii?Q?d//BrOiorMJlxU2VWu0j4pXsqEzE5WnDs5rNNbFGoY5nQcUBIeNx5AaSzHSo?=
 =?us-ascii?Q?nsduS8MejuZ0FgfX6xmG4lmLFVaXUuQxM7u/03GFhDJJrdyZf+VsiTLsviru?=
 =?us-ascii?Q?A9J4Cz323q0NLYt5/nWll1M52c4PAgGRTPMVn9K1JpYgRwv4Z0jdMPWy6o/Y?=
 =?us-ascii?Q?3EsRqG3/+K80FjdhdNk/JyXUaoLydANpa2ohfL8tA9FMgLaWk7LDN19iUp3K?=
 =?us-ascii?Q?vYcQdXaNnz0CwqQY9E4FNXEO+G4299k6qzZYdj/5BtLY83b+WFrlHVHiHDnE?=
 =?us-ascii?Q?1+UE8QJAZsfoHt3CE6as4d8fwLRrasBPsVjGNJjMjbSF4M5JxVjm1EenuqMz?=
 =?us-ascii?Q?kIgDFjYhdN6H/LZZZw4MNm1r/CtysxRy8ZiHGPm05bhV3Uy0/UXdWQvBlNTJ?=
 =?us-ascii?Q?qHyny/CSrCIlJqbAy4J11IoVVDt9zti7aLXOzDjHgfcA9g6jGqsZluZKR1Mt?=
 =?us-ascii?Q?YHCGc1BSaQyCSyOW6fnqXPM+PsCHpjOHNibBxQnNAVNVJ8ms35aC57XhJ0F0?=
 =?us-ascii?Q?jYIr+9vnDMpaVcbNIJublihqtRx8ANryhanaQnwVNGT7XwpRHQ9+wrL6vFPX?=
 =?us-ascii?Q?aOtQ/wvHoX9lAG0zqklwCWBi8D0So5LDjsDLvaNeW1wixcRZWbNJKI7EAN1B?=
 =?us-ascii?Q?7E9P0vGTwbqKDfyKRxEojk+3shA0u5u1kB+4/SyiFrfCFSUnhattPwU+eP6U?=
 =?us-ascii?Q?k5es4/dclKsaQfj+5IIxWQVGwEpkVcDNgt0WHwCc2JDAO/tXGhvq4sWZhX4I?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7fJkoeTh4kG6BdWUNji8QzoJLiLyEq8PJwVEe++blvX7Ujx9fgyGsHzwUMNjeQlXt/l+xkF27lzgYHKXDPjLGC2N/1jieEAXazoZ29Dwo8bMvL/tNKfS5ByQmA/1Fa0e6UxsvipfTzoie6z4sM2K19+SuWsxctQNlg7H1rCd1QEJm/VBM1OM1zUfeQGjn0dd97B20yCZKcy3DZZUEglWbj+tXGn2VoiF1K+pFX1GK0C3imaYh/vFoplB5vUWEuAuyssXvcnX3oBeLwG4UfaN4bNmTOIumAwaN91oCODpEXFXor3S9+Bmrsv4cR4fxGwsClQ+gxaCH8HcQ9mBGgbkxzQN2MMiZtq4JZ1w0sJDoSDHC233zITOY+O0eikPjMvBCNPzzxDCUnIoN+mfSzNoQkKcOyIuUIFZ46K6RTKFeOfRZ5k3oZyjsblfQsFSi+Xs3sRXOy0w/MHqwQFr8Z7Rdy5DbWDcSYAau+m8htFWNwkFMCyr9aCLwNMa/FyQma+KUQ2MeTs36tzK+ySLbQTPpgDA06UdF3efAJBz0YPDdihBYO0DypCk5y1zfc3M5C1riuPiiVzj3WMP6AnLuzXbTPhhE22GKkyK7DmEsDUyzNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2146ec1-e275-468b-e0bc-08dd5a767f93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:55.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTGY+95szYgxGV3PUyh1viDIhXd315wxV5a8JNBvtZieDsKGv/9N8/Z7btnT9DWLrh9fNpGXhnszqvoRDjMulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-ORIG-GUID: -u5nMf178P2NBXft0LJcdhfSngOzkMEZ
X-Proofpoint-GUID: -u5nMf178P2NBXft0LJcdhfSngOzkMEZ

Base SW-based atomic writes on CoW.

For SW-based atomic write support, always allocate a cow hole in
xfs_reflink_allocate_cow() to write the new data.

The semantics is that if @atomic_sw is set, we will be passed a CoW fork
extent mapping for no error returned.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 5 +++--
 fs/xfs/xfs_reflink.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 3b1b7a56af34..97dc38841063 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -444,6 +444,7 @@ xfs_reflink_fill_cow_hole(
 	int			nimaps;
 	int			error;
 	bool			found;
+	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
 	*lockmode = XFS_ILOCK_EXCL;
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic_sw))
 		goto out_trans_cancel;
 
 	if (found) {
@@ -580,7 +581,7 @@ xfs_reflink_allocate_cow(
 	}
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !(flags & XFS_REFLINK_ATOMIC_SW)))
 		return error;
 
 	/* CoW fork has a real extent */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cdbd73d58822..dfd94e51e2b4 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -10,6 +10,7 @@
  * Flags for xfs_reflink_allocate_cow()
  */
 #define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
+#define XFS_REFLINK_ATOMIC_SW	(1u << 1) /* alloc for SW-based atomic write */
 
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
-- 
2.31.1


