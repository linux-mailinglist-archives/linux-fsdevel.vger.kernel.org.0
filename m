Return-Path: <linux-fsdevel+bounces-31944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D973799E1FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002BF1C21AEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55221DC182;
	Tue, 15 Oct 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gxtni85q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UV8rpvWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF81D5AB4;
	Tue, 15 Oct 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982936; cv=fail; b=JcnVjpeiFahlOfDZs5ORcRI9ymaIrKUQ8xJdpiu5ndLjOIy6YGSD2xS+bbTlM+++SGSWAYGlarpwOpnV+vBoOqkGzKuPOVw6rsD1VER3WQNNjReRPOsOxUXYIv2sDezkWwtDfuopaqHL/CSEbcQhrKChUHRtzY8JYEYr97I40ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982936; c=relaxed/simple;
	bh=m4fx0+cCtC52nY4lgOxPzkNwkAToDONzLOcOPTArYK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITF2pGbUvCKE8OfFOfGlX2lSv7/fkY7Ar56ndPzsq7gn9hhbmNwect93xb764I+IsBGQSXIc22S6w6eGtI2c6BjiLlEPBfNdvtAi6VzPyiozNvc0bGgL0nBGoZ7x2+vcbdzmP0gH8IrvW+hvXoD2XN8mmb/Mjjg0IzZ9HH78atY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gxtni85q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UV8rpvWn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F2Vu012540;
	Tue, 15 Oct 2024 09:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oPSQkBKXTw/U8/Qjn5+7yaMQ+m34nUuJMuR5LnQyssk=; b=
	Gxtni85qrt2kJW3Ke3R/prEhvytecINJ9JG72y2y6iCSD0AwlhHpIPRAO7sSl7PH
	lDlEZDSDmjbe40rb17iSbc2inbkp7V0lHXqv1bPacoFc7QrS7i7LbTj7QEWhiD3o
	rosQ37VJri0ZNbL3tLdRoCOt+UZ0ZMCI7QQIJuAy5QWWaCNU62i0nCDBsa0DMxq0
	aD8dbwatyye05n7A9k6VZlFmY5kMVdd+O3gcYv3HaDt8HwUK5A0dMDhX2h2nzVeC
	6gemvRKnoXbTepVYpwN3zx33l/rbZBrPhXEv3FtVJmhPvzh4WV/fM/CA1eyKAO5J
	7AzH7ueNIJ31yC7GCUFOXw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cgfc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8wukM027117;
	Tue, 15 Oct 2024 09:02:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdp9t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTMSBPnHKMRpqluubqxsQeWpWId2nBkcaQ0S/PqdeD763RbHI8g4TWGxvuNA+4IM84XZOK8RwhiRsxgMk4EoC5bNCfuCHqyY5oidwyyVlAYufm+2gjG6ubB1joyRgOtS2gR5AkYmVRR/C4g3SADBKBH7A24ujokgUicGknQQM5o8JD2slxxba6R1CcRh5EPPDyGrq/Tvza1iGH2AKsnlJC/0WARgr4VmvYlGdpUM+L1xDfdcyenqj37uNQ4dmm1DJ+G+LpKw1Ub5pUorEYIsnDkmM5RGkloiRrbEwVs7USlyLXuxdhp+No3Hs7NfKmXlUewm0v+AmoKHS6wt67iQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPSQkBKXTw/U8/Qjn5+7yaMQ+m34nUuJMuR5LnQyssk=;
 b=cw0L7fX9IlCAT6loQ8eFU6X4H/AReTtGLBXITX4nJfBlaqR7AFEAbO99SiSmkPAs5x9hhmVYm3jPh4+2+izHqSQlVbi2nCFKgiLY0gaRmgimsvywnFICXVCm1DliXcp55xUGmjFkv2+ZzB2+oznBXqJHKdorkSuRlbA5Lj/VIO5NTlX7zl17TwarLU74PAVTzrZV7dRoN8SD6mna6sN5JbkuMQhQnLFiB5PhgMvxbqpmtwUrdJ6YUUAPVg06/LdjHS1Phit7wBlRs6jSG834zALqjDs0s8p4e/ThUJwaSynghRTn2S8+gLDD11oZBxtxhYXYAnECImcBLYHjHyQ6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPSQkBKXTw/U8/Qjn5+7yaMQ+m34nUuJMuR5LnQyssk=;
 b=UV8rpvWn5cIu4GvMvPFy4+R/Osse+5TDsS9uTg2C0XWRCtO8PZYw3UpeaDy7qt6RwJQyFwYPgM55umxn7MCxEarsLU88Zf9oIxzRm7srB5kaZHKTEuLY48EOesxc/0hGh/275outkiEYEfybS/ZG2OpXZgEXpVZFwfcdboBJxiE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:01:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:01:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 4/7] fs: iomap: Atomic write support
Date: Tue, 15 Oct 2024 09:01:39 +0000
Message-Id: <20241015090142.3189518-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:208:134::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: cffb2cda-5f73-4878-6cdf-08dcecf805fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iSctveB6IKAEH494Gtj/UxmFCzH+lW4MDbgh5L7yvfjpqKQE00eqjPbCGXoN?=
 =?us-ascii?Q?xVHBrb4tzXT4RZKtLaPCqDVUfR0NrqQnAMQI8CxAKTG8dhhlYj/3fPq6t2ak?=
 =?us-ascii?Q?D7QL2qoNUE+b1OnALjvTKVfM6H0Qhu7qJA86VWImhf8g/N8JAmhMSwaDgM/8?=
 =?us-ascii?Q?h2E/y3m8xvndlVRN6d+J9CI4ll8/OOObYSYckS3g0JUNtbUxumTivl2SDLzR?=
 =?us-ascii?Q?I1BtgRT1lIIJz2JRCV83VS6164iAP10W0chGIocL5J/Es3ncMukQH3jDjmD1?=
 =?us-ascii?Q?Be4iLmn+KSNygLg3rkWP8SfOhi1sBo4m/pBqtpG2KjAYuKahXe/eaCjbp51C?=
 =?us-ascii?Q?6zbKbraW+oIO/uYpegpBBn4PLfgvWrlaKnfysOQQi/eaita90U49ZsG1+yn+?=
 =?us-ascii?Q?To/SqtqtqN9ynjaaGll9qiLDnjHiKLM5F3q643IiGvX8VKb70WxaCaenJss3?=
 =?us-ascii?Q?/jsrOp+3sv0RY+6+fjFtfMb/CiUgF6a1i0ReEXMEa+l4bsV2ZSRiUO+MHzjT?=
 =?us-ascii?Q?xMtxtQnzSLMYeaUlutV+s+hbkryPlzzHV2U+VCysdlhMMWMNER1opu5gMFI7?=
 =?us-ascii?Q?QRXdsMgqMwnj95A2c/T0Zf9n+8v0Gi1PaQXaN73nwGk/TyRetrlKUfpr0Gzo?=
 =?us-ascii?Q?f9nAJM5KvJ9pUaGLaRgUdrXabrLTKkcwMC/ysyAUQYz8CFIFbsc5KNNcdWHO?=
 =?us-ascii?Q?f8WyOMU2jOyf4UT2bpsjvQQvXrNj90S8WpGSOwJZDzk7gFGtrfn8OWJYt3k1?=
 =?us-ascii?Q?H5wyM3rt82NdTIBCi3+qBtdRCdug5rwtr5pwsz2HjIAH5uwFyk17Nvv2xw12?=
 =?us-ascii?Q?HN2E3y/8Bzekf12/q34dfyv9ccksXG/WcoV94YJM0a4jPQwmjrGAu7Fq/JTm?=
 =?us-ascii?Q?y9Yqbz9iQRmdTOWKckkljp0LWdZSwc0lfTbS/lUsW43n7hi+7lJOxUfilYAO?=
 =?us-ascii?Q?Ptj1o7do80F11P6JvscxE6FEhpWu3Qnp4EPAlomYR1DaU2w4/VVJWiAU7NAy?=
 =?us-ascii?Q?tIVc/UOW5z0CG8stco6N+In6J9xAQBlynr15jUyCM+iXccZiqno6gswHCgZG?=
 =?us-ascii?Q?pbUWHwAJV9ooxelPMrKRv8mmfgbMEbcwAhRmBpPQ/W46g6yBx+bbt/8EhdeQ?=
 =?us-ascii?Q?5IZtCuZy4AxMDvm9IZRc0YJhvzSn5rLilhWJC9azESUBFUp0IBG/8RXxYV40?=
 =?us-ascii?Q?h7RMWV1qnQYi84fSkvpAEQ64VTlJh4n958b2YeNzyWD+pI4hYJq7X5BzjN4m?=
 =?us-ascii?Q?t8MpT3/9UmWyxwIBpGLQcVPZvhgJe8orSienPto70w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtmSS+Oz19+qhggu+3tGIE9WlFvJL1f4grxROx0b072R33JYj/r7IZ2aT5vH?=
 =?us-ascii?Q?phrv1+g4Vay/hY3MxQekZad5h4hpiaz2jxfw4wpRXhWRe+mQBF7Z6Tyf2WO0?=
 =?us-ascii?Q?bjSpadgVOQLTX58bW1NsacNCMIwN0SzCzj4nSLchjg48rinFsE3uzfRSKf99?=
 =?us-ascii?Q?zgP9cFsZnVJqikiY0ZijqaVTggfze5qyUQX+xPIw4BXCYQP/lCe/2wf1Wk17?=
 =?us-ascii?Q?+17E0fWy/gn3zfCueQP9whWUq/sS1HWmSB1NcY3cB+jRL9I0Q4bLlLICEFrM?=
 =?us-ascii?Q?ZhTjfcL0JFZp3N0A5fZJEOZjpw4ChDn6X1jaw08IZs1uWsh7AbFyuVuQLX5X?=
 =?us-ascii?Q?wBTVFRxAfQ14d+0DCg0cDB5zX+EXhevulg5uK9qL69RTKqlLt/1EHScrfL0z?=
 =?us-ascii?Q?lV4Ux93ipEowz4/OjiJCGvUMYa6S+AOzopVRNBNp4dY7G/vqc/Vecm7mqWEl?=
 =?us-ascii?Q?1CdG+WVggwiUm0fvNIoFP7HV6q3Z+2VyN6P4E/+KbqCHKigHpx44EpXAaAjC?=
 =?us-ascii?Q?+FLPbAOkLRmh5YXmgaiU7v9bdEMLfvmoGHN34ZQOf48Aia4C3TA+h7NKz2nR?=
 =?us-ascii?Q?foBgdX2BjSbiRJSu7TTP0IRvDOj+2Q7k6s3lcqKr7EfU9neSItwSZZSIh2TL?=
 =?us-ascii?Q?NQifeN+lzEyxjWOTGhQ8W7GOFxfWWL3lRH5IkGfQjBm+pN9ubMJZEiVAHe0q?=
 =?us-ascii?Q?Bbs7r0ZHjpDbrhwKoonPvIAlydBWd0X+ghaAWFayAOgUAw15cDHzUwfnjo3G?=
 =?us-ascii?Q?uNa1LL0lZZbeElxE0j/uOwYPGU2R67PNmWnkJpzEjw+8RvwoiVrt+VkDeYaa?=
 =?us-ascii?Q?tglzzZUfnx5qA9H+wxL2iY9i1jJZU9NTaItgQW0zMiDLGrt0aiRBhyiDy7hj?=
 =?us-ascii?Q?XisY/VmvqA5udNPThmOWZ8PBHuuJqp0zVn+nahpAcQuLQqcCYgIZyGrUbU2x?=
 =?us-ascii?Q?A1TSnk6WOZtAsA9evQMAiX+kopdoW2+bTczYqB71VV5rwFG38Es/Q9+u6uVm?=
 =?us-ascii?Q?ijmoGoeI5DjQfhDqclt07G9V9KOWGWToYn4IvI/tpgbjypEiz7CvM1GHHiec?=
 =?us-ascii?Q?PCjJ0AUnDUsSR6YJrQ6th4B3z1EHkB13ksUD2lO40ei4Vl/liaPxzt6Fv7rZ?=
 =?us-ascii?Q?yefEzncUDLL7PG8j4faiIpSCMPX97UOJCDwGA2oWy+kg3jTFVWsXMU8hJhgx?=
 =?us-ascii?Q?QNwMPCiNESOkwBVby5vIKuGB4ALNYy0kZNzkg1RW2zIvc98tCAfo4GxXcab2?=
 =?us-ascii?Q?ZwJmFQCZoBn00c78hv49lgnVyE3bmjBov6ytsfDyeoiqIePjA6spwoS2brUD?=
 =?us-ascii?Q?7QArVv7FwhGl0ReiQ4xZffL1iSOhP35taq59gN1cnBnt2QctZG56mOwB3o5d?=
 =?us-ascii?Q?Hos8gWqdU/9IM/kNttw1zhwCO9G6iiyMCa9NiC5HPFoctYJj+hMT3urbHFuU?=
 =?us-ascii?Q?Vo7nBbfz+KqGYsMKZdsO6Oj8rcG8/fp3i1a/WTjrZyh3uMlvFI8lTJoENBsK?=
 =?us-ascii?Q?xiRYiWRAawWIFxNTss1hKHtediiAJuXYKxqP7NuhYJ3GksvQJSEu/v535wNz?=
 =?us-ascii?Q?iMScKHvUDwhL3sobcvC0uflpUwkrKlisrkwnhXxahFEa8SRu7ggMBWaGwuIn?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6WOHf/8RRrcW7viCXJAYq3uUeVj90gAZWwfgCLuWhtmXHFK4AiY8WRPnZ8TVf22/+625lsUF9f8i3x641j2h8hZ33pAm1yAb8GgofWKPYHX9yb3hAiQ4mHzJR5vxENlKtY1kdv1TIUjFYnwcZASlrwC63WuopvAmHAKK8N3uM9EahzHm+hNbwysVFM4Eaq12DWQ80/M9I2d0SEFhHJFFZvpDRrymZGYsyAbzepVR38XNetbTXsPyv4EEzWreR8YsoYwVHpCK0u+WQFQCV/hbqMy+PjhZo8gjxzMqyhnWI/yMk3mq1JMcQJjspfD27qtj29BxC6e+mlOsApZcroUN0uwlpIGGjQ98ZdaTpu7zO1mYvt8K/zwKfOwFVVDcIZHF6QrXsp4uBbahuxHdiA3lDuSQ5+3jxpRKQQVqhwxC2CxQlBlMMnQ+lOCEvOrB8iHcTLv1UOsa56kg4V/DVTkLQrqo4Yz8G49fDN7CuU8ruaW//U/0rmAWCMFDOuzVs7nOOShYfgKwz+BQ0EsyKKfrF5hwO3dpU3XTvOK325TCAQGxc5BbPhOobCabRfvgsfomvWy6Irf6GH+MMrYH+bagSNGhGOkeuPbbfejRozjC5OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffb2cda-5f73-4878-6cdf-08dcecf805fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:01:57.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBX8eism9TqedjNN+9miSE87IqPBO2m09jg3viG4ALxaLVy15elDvEmDx5E1gd1XBjCJLmN43GI6Qx58XuqlGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150060
X-Proofpoint-ORIG-GUID: 9zV_QkJdDubBPEtH8TwEIgzTD037EKbs
X-Proofpoint-GUID: 9zV_QkJdDubBPEtH8TwEIgzTD037EKbs

Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
flag set.

Initially FSes (XFS) should only support writing a single FS block
atomically.

As with any atomic write, we should produce a single bio which covers the
complete write length.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 .../filesystems/iomap/operations.rst          | 11 ++++++
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 include/linux/iomap.h                         |  1 +
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 8e6c721d2330..fb95e99ca1a0 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,17 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
+ * ``IOMAP_ATOMIC``: This write is being issued with torn-write
+   protection. Only a single bio can be created for the write, and the
+   write must not be split into multiple I/O requests, i.e. flag
+   REQ_ATOMIC must be set.
+   The file range to write must be aligned to satisfy the requirements
+   of both the filesystem and the underlying block device's atomic
+   commit capabilities.
+   If filesystem metadata updates are required (e.g. unwritten extent
+   conversion or copy on write), all updates for the entire file range
+   must be committed atomically as well.
+
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f637aa0706a3..c968a0e2a60b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	loff_t length = iomap_length(iter);
+	const loff_t length = iomap_length(iter);
+	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	if (atomic && (length != fs_block_size))
+		return -EINVAL;
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -382,7 +388,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -415,6 +421,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (atomic && n != length) {
+			/*
+			 * This bio should have covered the complete length,
+			 * which it doesn't, so error. We may need to zero out
+			 * the tail (complete FS block), similar to when
+			 * bio_iov_iter_get_pages() returns an error, above.
+			 */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto zero_tail;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -598,6 +615,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iomi.flags |= IOMAP_ATOMIC;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -659,7 +679,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret != -EAGAIN) {
 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
 								iomi.len);
-				ret = -ENOTBLK;
+				if (iocb->ki_flags & IOCB_ATOMIC) {
+					/*
+					 * folio invalidation failed, maybe
+					 * this is transient, unlock and see if
+					 * the caller tries again.
+					 */
+					ret = -EAGAIN;
+				} else {
+					/* fall back to buffered write */
+					ret = -ENOTBLK;
+				}
 			}
 			goto out_free_dio;
 		}
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae..c7644bdcfca3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


