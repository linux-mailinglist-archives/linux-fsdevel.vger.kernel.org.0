Return-Path: <linux-fsdevel+bounces-44431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E62A68983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 11:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8408B179C73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5483253B79;
	Wed, 19 Mar 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWe8UCUE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ws9K6Dpn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95025178B;
	Wed, 19 Mar 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379927; cv=fail; b=Tdmedv43vnr9t/QCNVxIsvgKK690xBrnTDgBqS3NvadJ+q1UVMYyCnU3y21mAj4lkl4RjDBPGSbY+/ed2aS7Bn9B6f4vbGF83I+ewwVqgitlzp1iRkd7akLm2EJfWJc6allMLYb7aLAU5DJ7EBQHQqmzJ5RvOGDWVcUNIlswop0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379927; c=relaxed/simple;
	bh=Fzo8/ey1h8BVVwljpHmPkCCbBn6FqH+uwF62gf+n5xY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+55YedUYpLQuFLZHfzpN2X1apbOFqNsdhXI3K8AH5eV/qXiiUnl4WmP7EzfaZUtB2h8IBQB0EF31j9NyVN2EF+3EOa8UT5TCS4eWxjIpUiVLTGen/hFkx791K1BnNuWX1qemhhqTlLI9BIkRIxWOm5++RTlVmbJkgxhn/kwL8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LWe8UCUE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ws9K6Dpn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8fqNO029202;
	Wed, 19 Mar 2025 10:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zWDgXRP0PGHrTaBKFgOn6N8rqBGy8eG9Ez4oFHYATIA=; b=
	LWe8UCUEQd4bTMGIJv7hbk8TAft17AomQs0DDdxQda7ZFf28jH90oAVUarzoGqxN
	ALpmsKiUX8xTHaTdPZWb1xxzEUUnpAfwuMhGugKa4V2EmtVYgPFMZXYELkuzJTtU
	C2r7G9gbVeX0RZBg4nJHdXZMvSG3AKWIVb+eG2fx2PVVQ3slqcVOXFGcK1eIjUCE
	UaXzC9/5oWD0oAPa4FvQWxOGUC7mE+Jc2xVhxphFWP5yVh5X3w6IsWiBJklIMdGJ
	yRm0fB7JKRL/mIOfmQxZVP+B59qVrMND1ufpQHTsGnwpEnS2GHrjkvbeLKkt84AL
	wgREVS3W6Cuq/w1FLljcag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbb2mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 10:25:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8Wnvu018702;
	Wed, 19 Mar 2025 10:25:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdmec4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 10:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW3S0I4+nX47wdwvWJgRVoBa3m/+bX1B7/qrmirkRo8W7mF41YwShJ0syrsG8pP1FazPv3sp+VDBZ5UGQlAzFJUp3SLjAz5JGhCF/H3NPd7vkSxmOaAbhiDSiBqKTwL0eCuEMlpM+LKI74kXD2qIGGlYhKpoZOzkc21s5AEohBxFoZ5w/rh38JC03Ydv0tAYmBWSTSljqrZsHwoUwfDtTI4R5jxyU50XBZ9zXp72zpCbKuGa+bRNEk4JANt9Gg30vtpRTkXBUweWfTE/sUaz5DlJZTsr2+Lr3nphyhBP5RDUGTJzwn9wpCOITIeA22YUkaV7bYb3+PffxUDKFV3xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWDgXRP0PGHrTaBKFgOn6N8rqBGy8eG9Ez4oFHYATIA=;
 b=U3bDrKlxV2DiHHJ6AfpIH3lReMqoIB50RJXjNWwJbOHJZKvIZGQVu0Sb6pj86tmzUN+mOPV0GVL20QZtkiuuZ/cc+8PwJ6Y+7pyg4Cu9K7KOSurMList+68fQc91ndFBXIsCuc2CdSicnFiquMV23GsFUFvcPSwbvxTagj74EnTlK4RnzMgo+laxuLGCsqn8LlUxgm1t7tA8zrOR+yCtgpWXqM3/7i1LzarcUis7/ImrzoXevbwirky4r7zZ0Po7Hzju+DathN3cGF0VIUDJhlP2T4OLA+bytG0AqXp/NHX2GfkoLvat/OffxOA0L2GWwoW02jkBDYWilACMnr9RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWDgXRP0PGHrTaBKFgOn6N8rqBGy8eG9Ez4oFHYATIA=;
 b=Ws9K6DpnaW2ZfPQ/2HeYTQNClkiKHguycIClV1nebidDwptdHHanjUuPmD3rlcTYuqTty9zWBnQMuczK/t1yjVh1WpfsQZCxpBiMLqEAIW1FxJy++lgMRr6W0MWA759fb9Xdj4iLR2PWWf23Qw2aDukk62cAeG4AtH2lXHmkxX4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7934.namprd10.prod.outlook.com (2603:10b6:8:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:24:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 10:24:59 +0000
Message-ID: <ef315f4e-d7e9-48ee-b975-e0a014d10ba2@oracle.com>
Date: Wed, 19 Mar 2025 10:24:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <Z9fOoE3LxcLNcddh@infradead.org>
 <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
 <20250318053906.GD14470@lst.de>
 <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com>
 <20250318083203.GA18902@lst.de>
 <de3f6e25-851a-4ed7-9511-397270785794@oracle.com>
 <20250319073045.GA25373@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250319073045.GA25373@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 723e97c4-f1c1-4492-e977-08dd66d04cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djh1VXhscmFwWHdmRDAyZ0lmeFFzRDR1anRXQTNGVmovUjRVWG9uYU55SWta?=
 =?utf-8?B?Tkt2TkpjaURMWVNGYnJSTnJwVGtUbWZIQVZQWnlBZElzMzBFN1dHUXlHM255?=
 =?utf-8?B?d29yYUtrUkZvd1pRN2RHSXVTeGJUdWlNeDZ2NXgvMFNPL2dsdkEvaEFPekx4?=
 =?utf-8?B?TVlXTHFybjN1Tm13N1RBTnE1bllOakdDVFVIQ2VKSW4zZXVXRkpZZHArLzJT?=
 =?utf-8?B?aXdBUXZlVmx3dVpycG1mcVBvQ3N4UGZWZnh0VHhqeXYzY1I4WUZNRWlCMmFC?=
 =?utf-8?B?eDY5bTI3SUEvUm4vRUZUTjdhODdLZWxXSG9nSHBJVlZpM1grZ1hnbkRmbDlj?=
 =?utf-8?B?V1htbFlYekRzVXA3RlYxS2FBN29LakQxVlIrajd2M1pPYWxnSWNUSzNJc2FE?=
 =?utf-8?B?OGVNSlRCTnlvT1RRQytMTHFKdzZaTjQzYjRTd08renlvTkhwMzl2ZFBncjdC?=
 =?utf-8?B?VEpaU1hFYnFkK0o4VjloRktOTzZSSVFCNm42blp3d1Fic29BNUo0dll6eUdI?=
 =?utf-8?B?d3BvTDZvNHUrVHFRTFN3SzVJL2JWVXJ2NGtCSmliM1c2V080Mzc5YnAzYXRX?=
 =?utf-8?B?c2UvT0gyaUhyMk92OGc5VWVaZ0M0aUlnWERwWFN4MkJ5ZVl6NlRSUkNLaUxE?=
 =?utf-8?B?dEZrbXNEUzc5YTdPUjZMSHZaVy9xNTg1cG9XVDNpbUJRZkpraDhXVlF3bWZM?=
 =?utf-8?B?TmtweGw0MWo3M0lscUN2V3djVWs5Uk02bm9rVy9MVy9aTUVyNEJqcXRlTjcz?=
 =?utf-8?B?RnhPdERtdnRUeFJFNXpGalFTcm1kc2cyZ3AvYVVGS1VhZEpkZVJhc3JMWGVK?=
 =?utf-8?B?Y25NMXIwWWJzVlVYcy9MMUNHbnBPeUVxcGQzMXRZM200WXFVWW82QjJkZDNk?=
 =?utf-8?B?ci9iR1E1d09JNFgveTNKZEl0bG5ERHBRc05tU0RPRnpxbnNWM0prK3Nxd1Rv?=
 =?utf-8?B?RnNuclZ5T2pIYVRWd0s4eFJNTWRJejJVSzRYUlBpVHVtcWRMbTNiZU53a0sv?=
 =?utf-8?B?RzV1enlxWFZ0UWpFTVZnSVN1NWlvSHUrNm55QWRFMVhIWXdzNE5iL0VXQkNw?=
 =?utf-8?B?YWEzRFMxbUNOd011cUVoZDZ2V2hDVmxqL0NWc1FvMTA4RXprWWRxTHRzM2Ry?=
 =?utf-8?B?K1A0b3NXeGVKdldzSzArVlFGVmNwS256NGZINlozb0U4VXEvaWVYc3pKczJ2?=
 =?utf-8?B?OVlwVDU4MHVqL2ZHYll0SThKNG42eGt4Rm1oVWNVM2lVMCtuaTRudGo0U1Zj?=
 =?utf-8?B?SitxS2d2U3hrS2V1OHREcFNrMDVyOFd1QUpQbjJ2R084OUxDOUZYN3BCc1NQ?=
 =?utf-8?B?RnZGd1lCYkdyZmpmUFcwbFMyczZLakFFVjNhV2l3MzlsKzA4Yk1jNVhDdjBz?=
 =?utf-8?B?dkQySUJZNG9xa1dlZitTc0IwRm5JS25xbjdWamtrbWhXQ0djYkRWUjZYVFlW?=
 =?utf-8?B?U1htajFGSHNUa0dpY3Nhb1hMU21HT2hHMEM1Slh6dHh0Ym9QZkE2bEpxaTJ5?=
 =?utf-8?B?S1h4cGpEY0x2Q2JoWFFDaEIxVERqZmxNZGJaNnFPYTNaUEU0TkNEWVVTQWl4?=
 =?utf-8?B?SmQ0dlJ5MVAyTmJOcndtYTFweFZtK0dYYWNHdlZ5MUZpTmF2azVDZkNVS3c4?=
 =?utf-8?B?N2lYV01CWTlrc2RVQzdZcFB2Z0RDeW5NanhWcGlGSUM4akt6RHdxdXdiRFhh?=
 =?utf-8?B?NGJWdStYYWMvMy8vb0lhYndwRXNnYndBSkFrZ1V5S3kvYVFEUU1Bd0JoNzVE?=
 =?utf-8?B?Z3c4b0lJMWpoaG5oSEI3S3pNQlhHd2twa213bnR1SS9ldWVtYUFPUGoyREdp?=
 =?utf-8?B?NlczMnZENlAyR1JiVFhqNDZTc0h6ZE5xWUhwdkVKL2ZHbEhYS24wQnJqSFZV?=
 =?utf-8?Q?vZPaevHu+3CBb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHgrNXhiOHFmTStQWElCMWZiNjgrWDlwaXNHcVZuRlhRM2dPN0FWZzhKOUVa?=
 =?utf-8?B?b01wamxyaG1iNWNIRUpvL3dTZW1NeEpJV0IyN2R0d01rL3Qvb2dsTm9Oamw0?=
 =?utf-8?B?a2htdjZGckVpS0N3dnlSdm15RkpETDVzMVcxbGJPejExTHlnVW54dTVNVEpP?=
 =?utf-8?B?ZDJqZmpuc0ROS2s4MmlnQUNpWDJHUEJML0RmemVVZ0svVkhTbDdjakMvU1h5?=
 =?utf-8?B?U0hEcmIwMGN0YkhXMWdJcXVsTFhIMWxSaGxnTGR4dk05ZGQyTVgvV01RakF3?=
 =?utf-8?B?QWdOK052SUkyRXZIL0Q3ZWNFL2U3anVzb1Z4cEl5UjExLzRCMW1YbmJOTUFZ?=
 =?utf-8?B?UlBtbWRmTVhTckhiR2RKdS9OeE1sVEpMWmo5T2g5bmJhdENhczA4ZWtqa1pQ?=
 =?utf-8?B?SHUzR0FnK1ZYWFR6OUg5SDNTR2dQY051b0tsQ0FhK2JXbEdNMFdUOWdJamtU?=
 =?utf-8?B?ZGh6dVNhWFJSUkZ4OHNodExLRnNtWmR1TXBUVUR0UTBRamlMRWd6Z1BLSWNE?=
 =?utf-8?B?TVk2cmNkM1lkSU1EaFQyY2Y3QkpLcWlzd1loWGw3VndIdG5nQVVwbnp5SXpM?=
 =?utf-8?B?MkdGMndOTDJpanY4a1gyWXZ1aUtMU3h2RE9sUW00WmthT0FjRjhWam8xMGZi?=
 =?utf-8?B?RnlUdlpSLzNDTG1vRHE5cnFTaFh0U3BuRXNXeDc2QnpFYklpVmVTeTY3Ynkx?=
 =?utf-8?B?NU5VcWxtUHNWWHJKaVVHUXVqMEpPMVdWaGJnLzE2eFozNURyYWlLcm95c295?=
 =?utf-8?B?ZGd6Qk9wK2M0eDVnMDVjT2xKdmFoNVQyOXBUdEpUSWlzSFdXTVV3a3JlZ0M4?=
 =?utf-8?B?RUJwb3YydTBRVDE1V3JJQitKSW1haVlibWFHb05GUis1QytPb0RuNHpEbHRh?=
 =?utf-8?B?a2VJTnlqaWdvcDRPME1iK0tGSEFyeEttaWVMK1BMZkVXTE1QcE1CeFdkN0Zn?=
 =?utf-8?B?UXY4YkhrY3ZFVlplSm5SMW5GUXRlZGZMbGNiRy9QVnRYOG9nWGhEUDIrTlB2?=
 =?utf-8?B?VHpDL0UzdUtUOWhHdHBFUEkvendTbUlPb002bWVIb203OGNuMVI5UEJrUEtw?=
 =?utf-8?B?b2YxNGhiVVROU2xzWTlseE54R0tIRVN6Nmp5anJxMVVzSUNKbnpZT2FqZml5?=
 =?utf-8?B?WUR3eHdJL1JqbzVrUGw3VE8waVVHZ0R4d1pDdWZRNHRxdkZHR01IRmZCUDdr?=
 =?utf-8?B?RTdpb01hakV2MEplODdRY00yN1ZNeW5sWVJFVkdiMG9uRE84Tm16TnVEWjB1?=
 =?utf-8?B?U0JCajFWMkI3ODR5WVJ2MERSam56L2g2V2hwYllKeEFOSXpJNktKdTVzY1Ru?=
 =?utf-8?B?ZS9EdmhtUEZiNWxNaWFEcXlpRkZDK1Y1QTFBVS9jNThvRERQallwR0VvYm5X?=
 =?utf-8?B?MEJ4WjNJcWV4QVVuMjBKNmtrNTBydmg4RS9zQUFJdkVYSXhsZitSQjdSanV2?=
 =?utf-8?B?OHlRQlA0bE1lZWR3dVArUW5QSFdwTzBaNkdseVhPbFNwaCtTS2M0TzhYWTFI?=
 =?utf-8?B?NGxac3BCTzkwTHRGUldEMWZGa2tCUXpqUnZKVmNOZG9sdWdTVkZYNDYrUS9M?=
 =?utf-8?B?UHAwQkVNcXBDd1pQejdRSHI2SFo5TjB2VzlpV0pNYlhIaHlIR0ovQkh3YVhF?=
 =?utf-8?B?SkM4Uk9aVlYxTVFZT1Y0Qzd4K0VBYVJsVzZQQUlWWkloaEZ1S3ZrL3lKbGZR?=
 =?utf-8?B?R3A1Tm0wb1dqMjVtS0RMeENuUkpQalBJSlBVS3VjOUp6OHJRbGZZMlBkWVhi?=
 =?utf-8?B?R0tDRDBSTzZGZ1ZUQStIcEZ4a0pDM2xGU2NnMExSckd3R04xK3F1Sm9xZXJI?=
 =?utf-8?B?SGZoK0w3SUZwWUxEVnVFcjBiT3JvdU1UVlNrVG0yRk0wdFRhMkdkbEJBU2xY?=
 =?utf-8?B?ZVVHYXVGNlJoM2RlME5WK20zZTlYeWhiRVJOc0NZaHpPWWt2Uzh5N2lLVGZX?=
 =?utf-8?B?UVdHQTBqQndWUCttV1llejErcmUxcEozQ2ZqQ0NZYjF0MVNrTkVhZ2t6dUlC?=
 =?utf-8?B?VlU0Qk9TV0Q0ajlyOHNOL0FydW00RGFyQkFVcHZVUzBQd2tibTVJSi9GTlYr?=
 =?utf-8?B?WUlhWFdISlcwNzJJN1BpaGxjL3NneHJIejhhMTk1U1pKWDFQQVJzeUtjK1Ar?=
 =?utf-8?B?YnpBNkh0UEtKSDUva3dEQmRzWk1MWnY4ZDJwZUF5T0hXWE9PMk1HQUVsT0hH?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2X2LUi8sp3B/JO+ab1x/VKPtsHyh2XX59cFgi/hRfnyg0EpRUsGaXHVR3qsmAvT+h3g+LGos8HtXPuCrn6Xlme9REk67pUbofubkH2LuWDYol144/oUrDefkbSrcuZXcRyrOYvFi7YXDoWWx5R8vQC31VjrVZJj50UEdIjlJwA101xr3aButoSKeutAk5yUHc2fSweXw7XqgpV9AeIau2qYS4Vep1o+MWSunQBURRtzEi2MIaiSjA896xE0UBR+9dtJgziCNRNzIcMuuDJ2gTpyTncrz/mZYWhJPh2pP7TRX8RKawfR+WA6ao25olSPsgA2Do52eJnYB/n3gO9oYakOhmhIlVmJXlFFPdqOSVKMysWf83GR2olDf72g700hEMqzR3FmWGKTBQj6vZWZVlF2Gpx79pz01wiS1sdRh2G64jpByCDMlivYBs+yDOGD6zqg9R7+Nya2uumpB8NOWs44dhA1Z5ZNPL5qVBRvtzsEVZ9EykH5nseXXDXA9Pz0C16bjN0nHdtYkt3pTXb9leGYqt0cO4P1pBdrT5n1psRgIiSzhU3bDBs2NzuSPDkHb+Tjp83dfZWFMwBPrOhJuRMhXP5Vptmziz8GPq2z9yY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723e97c4-f1c1-4492-e977-08dd66d04cf7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:24:58.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRjT5H9ktoSJwOUntr0IUIUe1QjdtknfsK44ZgsSSnPmDcE/WIkBiCr4ZpOyVTKvzmQsaQnAsRzHvhHgWzVHuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190072
X-Proofpoint-GUID: ySUv7R0Ez_L5IvaDU_I_-RiExR_rTlk6
X-Proofpoint-ORIG-GUID: ySUv7R0Ez_L5IvaDU_I_-RiExR_rTlk6

On 19/03/2025 07:30, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 05:44:46PM +0000, John Garry wrote:
>> Please suggest any further modifications to the following attempt. I have
>> XFS_REFLINK_FORCE_COW still being passed to xfs_reflink_fill_cow_hole(),
>> but xfs_reflink_fill_cow_hole() is quite a large function and I am not sure
>> if I want to duplicate lots of it.
> 
> As said I'd do away with the helpers.  Below is my completely
> untested whiteboard coding attempt, based against the series you
> sent out.

it seems to work ok, cheers

Just a query, below

> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 88d86cabb8a1..06ece7070cfd 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1083,67 +1083,104 @@ xfs_atomic_write_cow_iomap_begin(
>   	struct iomap		*iomap,
>   	struct iomap		*srcmap)
>   {
> -	ASSERT(flags & IOMAP_WRITE);
> -	ASSERT(flags & IOMAP_DIRECT);
> -
>   	struct xfs_inode	*ip = XFS_I(inode);
>   	struct xfs_mount	*mp = ip->i_mount;
> -	struct xfs_bmbt_irec	imap, cmap;
>   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>   	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> -	int			nimaps = 1, error;
> -	bool			shared = false;
> -	unsigned int		lockmode = XFS_ILOCK_EXCL;
> +	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
> +	int			nmaps = 1;
> +	xfs_filblks_t		resaligned;
> +	struct xfs_bmbt_irec	cmap;
> +	struct xfs_iext_cursor	icur;
> +	struct xfs_trans	*tp;
> +	int			error;
>   	u64			seq;
>   
> +	ASSERT(!XFS_IS_REALTIME_INODE(ip));
> +	ASSERT(flags & IOMAP_WRITE);
> +	ASSERT(flags & IOMAP_DIRECT);
> +
>   	if (xfs_is_shutdown(mp))
>   		return -EIO;
>   
> -	if (!xfs_has_reflink(mp))
> +	if (WARN_ON_ONCE(!xfs_has_reflink(mp)))
>   		return -EINVAL;
>   
> -	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +
> +	if (!ip->i_cowfp) {
> +		ASSERT(!xfs_is_reflink_inode(ip));
> +		xfs_ifork_init_cow(ip);
> +	}
> +
> +	/*
> +	 * If we don't find an overlapping extent, trim the range we need to
> +	 * allocate to fit the hole we found.
> +	 */
> +	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
> +		cmap.br_startoff = end_fsb;
> +	if (cmap.br_startoff <= offset_fsb) {
> +		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
> +		goto found;
> +	}
> +
> +	end_fsb = cmap.br_startoff;
> +	count_fsb = end_fsb - offset_fsb;
> +	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
> +			xfs_get_cowextsz_hint(ip));
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +
> +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write,
> +			XFS_DIOSTRAT_SPACE_RES(mp, resaligned), 0, false, &tp);
>   	if (error)
>   		return error;
>   
> -	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
> -			&nimaps, 0);
> -	if (error)
> -		goto out_unlock;
> +	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
> +		cmap.br_startoff = end_fsb;

Do we really need this logic?

offset_fsb does not change, and logically cmap.br_startoff == end_fsb 
already, right?

> +	if (cmap.br_startoff <= offset_fsb) {
> +		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
> +		xfs_trans_cancel(tp);
> +		goto found;
> +	}
>   
> -	 /*
> -	  * Use XFS_REFLINK_ALLOC_EXTSZALIGN to hint at aligning new extents
> -	  * according to extszhint, such that there will be a greater chance
> -	  * that future atomic writes to that same range will be aligned (and
> -	  * don't require this COW-based method).
> -	  */
> -	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -			&lockmode, XFS_REFLINK_CONVERT_UNWRITTEN |
> -			XFS_REFLINK_FORCE_COW | XFS_REFLINK_ALLOC_EXTSZALIGN);
>   	/*
> -	 * Don't check @shared. For atomic writes, we should error when
> -	 * we don't get a COW fork extent mapping.
> +	 * Allocate the entire reservation as unwritten blocks.
> +	 *
> +	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
> +	 * extszhint, such that there will be a greater chance that future
> +	 * atomic writes to that same range will be aligned (and don't require
> +	 * this COW-based method).
>   	 */
> -	if (error)
> +	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
> +			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
> +			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);

