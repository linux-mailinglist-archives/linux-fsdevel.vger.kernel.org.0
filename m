Return-Path: <linux-fsdevel+bounces-43807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1DA5DF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609983AF10B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287215689A;
	Wed, 12 Mar 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MfMikelM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S2w1pZYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113014C9D;
	Wed, 12 Mar 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790864; cv=fail; b=flGIBbbQZJW7hLV6I7KqjK8DsS/uwjg49Vi833IQn3g7Tf8+iIGkKWRSzPN+PYpqatZIK54U3unOLJ6v01nDehdru6EZDdZgu0N11ZAmcjnJgbtlMWnKmW0bWJuQqm/fgU29RXQCZqMCm/gZmkohS82kUpb/RTUni1VLs7PC4qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790864; c=relaxed/simple;
	bh=SuSfi2Hm4v6ClL3+S3o+j3HuZOiPZuyciRtdbxCWhtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ujtFiMn1ZOUgi6PdrPGz8AqL044ubeLvZTcr5JhhnyEMHiFZvyd00MSzQ8l3agciuO+rOhYUxg22L8Mvk/sp+MiJlAPDDtbnICt8GaEW22098FMaIIiYoHk3E2sRZUDWY1FVNl4ksg3j/n3PJwBZ4toZsiZoHzSyqNGz/zDTqp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MfMikelM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S2w1pZYd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CC4mnL001822;
	Wed, 12 Mar 2025 14:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DjNgzp6t/gnFXQXOoAK61NtAWc/5T0dOrA2vXFMuFFY=; b=
	MfMikelMfX182OuO6U32qjsw1Hh/Noa+ja2TCFQQxJznroGjqFEuJ8K5WKDTehrA
	OCAR90jmraZnYemZnq6XCyxS0BmfzcEmKu+hAU13ZEaEnIniDc7WhZwCUEGF70vr
	qq9F6E2ZP0iqrENNRecsjRatLar+zCsJClBYruYR+nNZYOo35L4hFUVqdJ+eSoif
	EkiJmLFZVt1ilfDW0BGrnNgzrvok4Oe/yjsLB1frsM4OgL8sVNseaeZEUSApynfa
	NcnKifPu9WtngLBUa7JlVTWkJd8WHgGyACLONESv5pUPPTIuoVDqeu8z5gIGn5Yv
	ozB1SvWAeEat+/dkz7Ep9Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vhy0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:47:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CEJIbU002139;
	Wed, 12 Mar 2025 14:47:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn7cpxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqn6U1wpW46rJDAbdCpqI4xGhgna0hRm0qh4yoqhRgSattK+/+Pu+BPg1CXvVNd3j7lrUf5Kk/5u0uwIeyD/KISb9Zi4T1LIO4UqUxhg6J+62UB5aJKUwtnZxPmWReaP7h9amz54tX2fDfC04sIC6Ta0aFVM1zXhJGzOH7REaSOjazC5z02J6rJxAW1fUhVFBhWo/lBnKIQV5jB68u55yMdBxG+O7FP5BLx7Cp4p5IhyuXtW8+PtQSTwmaNi6bhqWMyjh5dIMsdXzEOli/4U53YlbYvdYumwvZBwwXqz1zj9q5F2wxb359Am7yC0yZ/mQbcu3udMht0bb5MJYV5eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjNgzp6t/gnFXQXOoAK61NtAWc/5T0dOrA2vXFMuFFY=;
 b=JXA20W85SL+vzFwVCwJGwo5j907JQLfX94wdgASpQSxU+BxfPBNDu6OwQPScR0Cl+Jx3/+o6c2KOxo9R6Bxwz5F+N2jmH13kHfY1TK9Ibr+AD/kv47mtLWpxE4ceP1gLEJR8jBr0dZNmxrrUkNFCRyZAKMehycyqWAvx3VBJhD7YGVfzO1yQqB7wi2ZmagS9pXxWB25y50Hmq4xIE4V/rWA6ngcx7GS3zCdey09MXdxDDd0vuZ6I4f1l8ln2H93C5zT1qjtgTnOVfrJz9Ij286vvcpQLCZSLZgoE2ZBoUKSSQkmMogpwc6TLeRt9TJZjYmfq8yxXocEHmBP391m3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjNgzp6t/gnFXQXOoAK61NtAWc/5T0dOrA2vXFMuFFY=;
 b=S2w1pZYdRJDP2A7quyvinoToVY/g7HyZdj0NboRT1g4XLXpo2mYpO1ogs5gMMbjZQyxNjQAvdxzLi/FOV8mi0yw6iUCT0AE+aV94oeVPlRDrWOLHfTPbz3WIZh1GvGEbxd1KF2GfU9ggMmGinbKoEbMJTZCDhJvP+QAn1tb41Gk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 12 Mar
 2025 14:47:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:47:32 +0000
Message-ID: <b5160f7c-4bb1-469a-8527-2011b0aa0b6b@oracle.com>
Date: Wed, 12 Mar 2025 14:47:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment
 hint
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-10-john.g.garry@oracle.com>
 <Z9E679YhzP6grfDV@infradead.org>
 <4d9499e3-4698-4d0c-b7bb-104023b29f3a@oracle.com>
 <Z9GP6F_n2BR3XCn5@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9GP6F_n2BR3XCn5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: b378e061-6f33-48b9-11f2-08dd6174d1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2JwMVZMN3BOOUJzNnJRT0VaMlRxL0ZaVzdISmxZazN4NFFCKzl0RkF2dk9s?=
 =?utf-8?B?Wi9lRmo0QUlmWS9va3NqS1FpcDRxaU9xd0puRXluUzhlaFFWQUN2KzRDNkVv?=
 =?utf-8?B?Smc4NmdiQTZwalJCWGU3aVdsZlNOem5NdGtjWWdPZjlXQ3RlNkJOdmoxbWtS?=
 =?utf-8?B?NEZIMmNZY0tHWGZvN0NqQ1ArV0R6TGtXUWFOZG93S2R1Tjd2NWJBTzBkQTh2?=
 =?utf-8?B?UGpsem1OUTRLOTNJS1ptc1VsZXEvWG1LVmEwZnVzQmNiY1VPYmFtZFlWdWQ0?=
 =?utf-8?B?N0l2aEpIYis0a2dJQTZFdWVWMjAwclZhemdJRldqcm1WdDN6RUxvcHNmcmti?=
 =?utf-8?B?YU84d3krc2VYRjNQYWdzeDJ4WjFCZDlhTEFrQnBUZHJyUExsZ1VkNHJLOGhH?=
 =?utf-8?B?SEpRTnZHSmhUL3Q3N2s5TktUMnJyd1hHd0dBSVIxUGRRejNzdWhZUGRoaXVO?=
 =?utf-8?B?VWdNOERwMlN1anhXN200akNUSXJ1a3RLcjA0cXlqRkVHWUlmU1czZERvc2Jq?=
 =?utf-8?B?bUxBVjhFN0hRZjR0K3BwRm1WMmxDclcxNWpyNW9qNW1LMDd1ZVBPVTliVjdy?=
 =?utf-8?B?bWQ2cEdDQVhZTzBleDlPKzhYUGFEOHFPS2l0Mm1yalRqdndmV1gzT1Q2U3JD?=
 =?utf-8?B?dkdCM29PdGJ2TGlMOGRrY2x6MkY3dDJINXRvYTFCNUFadm5NYWI0UkFlejAz?=
 =?utf-8?B?RWlkWTNoTlF5b2poR1hQSU80Q1dUcFZpK3VUNVU1a0lTVkdZd3Z2QjArMVRM?=
 =?utf-8?B?VjRXL0pxSHRzVFM5NGFHbnM4MmlXc243YW96Z1N1R1lXbVFVZ1VUT2JWWlFs?=
 =?utf-8?B?M1VSM25TNGZkT0F1UmFERnVZOS9RNFhpM3dNSTJDOGtvcHNCUGxzVG1ncUtq?=
 =?utf-8?B?RGk2MjRRN3ozdW54QTBYZUJOd2dLL202OHNxZkpXbmxsQTIzS0JoMzBZcjlw?=
 =?utf-8?B?eGdRT0lPY3JrRlNXcVNSckk5SCt5Rzl6a1BuYzBPY29peU5YQUNVa0c1VmQ3?=
 =?utf-8?B?NS91NmxPZjJFZktwVFAwcGNpcmx1Q3pqTXh1OTRBZ3NQOUIyakgxSDJZUlpC?=
 =?utf-8?B?U1lWd0tPQTNpVUJPRjZYZXkzZ0lLV1pPM05reG4yUGdPYmwySDdPT3NYaS80?=
 =?utf-8?B?akkweUdwZ1lwVHEwVDY1T1BIQXhXektOUGVNMUhHZm9jNWRudjE5M3o5a0Vj?=
 =?utf-8?B?a0VGYURKd1pscklQSThLVUtaZHVieDFkVUdRQkxoaFQvOUI5QlZ4TnlrK3hL?=
 =?utf-8?B?MXNFNDFWb1h1Mnd1NU92TzVNbnpEcjFMS25JYnlzL21wc2dYbDBpSlZwbVo0?=
 =?utf-8?B?WVNVZ2haN3F2YUEyVktFM2R1WUxKbjA3aEJRWXk2eXBuY2Q2Mnh4TmlINFRm?=
 =?utf-8?B?UWl1NVBGTUNZaFdiOXQ5STFzZVpXZGd6Vk1nVzN4bk9UK0dpcW1XVjBxSkx6?=
 =?utf-8?B?Ly9GQzNvbEJ5aUptM2xXZ0RuU2RxV0d0c3NjblNpSGhtZ1NOeGpZeXBtRStv?=
 =?utf-8?B?bXd1TjJzM3BmVzE3OG1rdHBzcDhFdmJlWVRpRkFWaUtneVVRMUlyd1ovejA5?=
 =?utf-8?B?SjBFQ0x4WGo5TVYrSHp4bDZReVQvTmhEZ2tMVTRMNG9NZnZpME9lanVJcEVF?=
 =?utf-8?B?UU11aUtGaDdESVR5TTE2V21lNC8vREV6Q0hCbXh0Q0pRTVhYMGprN2pwZHFa?=
 =?utf-8?B?M25ka1BWTVJtelh5Z25LcS81KzM1M3FQU1RGWVl3VWNta3lSWVowZ0RnQjZ2?=
 =?utf-8?B?ZHE1T3o1UEpJRVNadjdBUE1EdHpDQmlrbFBJU3VnUDVhSTRXdVdZT3hodTNj?=
 =?utf-8?B?eTJVdHhadmtjY0wxQUtrdmFPSXVyV2w1NUY4bkhDRnVrSmZKOTdKNjd3d0N6?=
 =?utf-8?Q?i5GbF3FActWFK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pDaVVxZ1AxZmhjR2kxOTA5REpDWmNvVjJkd1NjY0JvdnlweE1YRTdmakxK?=
 =?utf-8?B?ODJSWTJZYTE0dks5ZXZSZVBKNHkzL0VOYlExdU9jM1RlQ0hkWC82VEVUL0FZ?=
 =?utf-8?B?Rm1HWDZ3bzlDTWlGMlZjeWovZTRXSmM3UlRQOUZ3SHkzdGprVVB3RThUeVBP?=
 =?utf-8?B?RFN5aEhWZGxoRGttZ3RuTzl5aURUc0lSdkRRTXhSYVNLOGVZeU05OUtHeDVO?=
 =?utf-8?B?Rnl6TStWS3kzOGdXVTZTMmgycmgrUm9wTUg3a01ZQkwwWUNXL1dlVzBucUF0?=
 =?utf-8?B?RVJTUnpBSlJUTzRNUjFObTlTbUhhdGZuTm5SYUxCSzRxbkRLUS9KTGJ2NFUw?=
 =?utf-8?B?VEJ2TkxqaXhwdDFaQUo5dXpKWGNuWllNcG1UZG9GL3JZQkZPbmFPZGxwSG5a?=
 =?utf-8?B?NlZIZzlmMlhORDQxNERtWWRySDkzbC9wR0tsSGhBa0JLa2JqODh4RkNSQlJa?=
 =?utf-8?B?MUJoSWNOMHpnaUxmZ1RFUkNESFliTmk1QnNJY0tSVGZhOGZUQTk5bVNTYjJl?=
 =?utf-8?B?WCs2c0ViRjV1bzZJczdtVHJ4eGFsZVR5WEpiMmdpUWRGL3RUdkJ3Y2tZdUJ0?=
 =?utf-8?B?S1J3REt5WnpPam41SlpqTytwWVEzbHVMUTZhelJRd2FtcTYvUzJ3czFCVTFy?=
 =?utf-8?B?c25VcUh2cjBJRWVvZENqODNjUGZGQkU5UDE4dFRBbGlxdFhEdXZyOXNoMjJq?=
 =?utf-8?B?VkUyTktVSXYrcDQ4OExQUDVMd0tFaEZiazNDZm9ueThHSS9yOHBwQkdzNzJv?=
 =?utf-8?B?OCtnMXpZbyt5REVMblNZOUxwTmFNdmhrdTlVNHRoTW95dXZrMElHa3M5b2VH?=
 =?utf-8?B?UUxpdUNkRjhpVXk4WEsrV2RYeUc3UFl6T052TXhzejdaNnluNStFUXVPOFFI?=
 =?utf-8?B?b2NvMGU2UlJrdEJnb3lnNWNVTjEwZVBLb2lqV3pnNitza0ZOU0s0OFRhdkFU?=
 =?utf-8?B?TmgvMFdETkdodVZhb3RWZmxZd2I4TzNyY0RhcXBPNm85UlY3cWQrSi9aeXdM?=
 =?utf-8?B?My95UkZPZ0h1L25Ka3FQeUV3QWE1RkF4UEV6VmkwZitEaCtCZUJXY1ptYjB5?=
 =?utf-8?B?QWczL2Z6b2RlUGJycEp3NjFwREhOUUdzc0ttQUltQnFKMi9LNGJFZThUOEFZ?=
 =?utf-8?B?WTFLQi9ud1hsSVpKWjRXbmVVTGViWjZHT2VuTjhCdmJLK29QYnFla0J5RndL?=
 =?utf-8?B?SGtrb0hWTEs5WFFPQjhsVlk1WjNaOEwvMEk4bFJmajVyV2ZvMFRYU2FSbVFy?=
 =?utf-8?B?NUdQOFd2VU5idGFUN2dQUEhZaUEzRWdoNSs0ZTdLN3FnSUhSSXNnQ01ZbUx3?=
 =?utf-8?B?THZySFdHZ2xCN3BaSmhieXhxWVhCOGIxUEVheU1waUxVaTEweEhGdktDRW5N?=
 =?utf-8?B?Zm0wellyY0Q0RFJFcEFsRkdSVWJYZU8zaEJzbVhhMTFTUVZJN3pXeEp6VG45?=
 =?utf-8?B?Wnc0RUk0QmVKOHcwMWJYUC9jRGN5M29odmhaS0RER1ljcE1CbWFQcCtJVllF?=
 =?utf-8?B?c2I0NkxDd25TWGtGWW9ZYXdhSGJCUzN5NzIyRXQwYmZNUHpMd2QvSi92UEtU?=
 =?utf-8?B?bmgxd1JsWWMrazJCb1BocTh4ZGh2dUZwSHJLcG1rTFVxaUZ2VEdCV2NSSkZv?=
 =?utf-8?B?bHZSamtCZVBad0F1VmpEZVJXaEU0U0c0MnlPbHFlNzFjREFibEc1c3FGTUdI?=
 =?utf-8?B?THlvQktQQzZBWWN1cmkvNyt1blZtTXQ2MTQ0eitUVFhtOWU5bTJmbGFFbnFP?=
 =?utf-8?B?OUszZmowT2lIbXBDL3FFSjJ1N0pxR2c1WTlxRHg4K3pJYURBM2VqQTNMVkxj?=
 =?utf-8?B?OGFvQ0g1N3ZocnNVaXJnNjc1MGhsMWw2T3dMcEV4eTlXV1A1engzK0dadnFu?=
 =?utf-8?B?bGZkTUhyaXpCZ0tPWTVZNTkvT2w5WUZGTVFOeXU4ZDdVK1dPVCtaQVpTNmJy?=
 =?utf-8?B?aFFXNDZndXVHSDdrV3dsdFRrN3N1YWJBOXBQRUhzSEhsOFZUbVZPN0sxc0Jp?=
 =?utf-8?B?Smk3TVNSUll4UUtzUWtUR2REL21uazdtcWhNandaYXRZQUxIaVhhZ002bitO?=
 =?utf-8?B?UnZzODVTK0huL1lmcURaSWFMT29qMUNnWnJabGthV0xPb3MrQWxPY1h3ZkZF?=
 =?utf-8?B?OXFmYjRaNHNFUjFLV1M5bXFhQ2RaOEswalFpSDlBanF6OEIvaHY4aExlVkxZ?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6iA01XdShem0URSSSzugvWhcioDx/q1y1gRgSNTR44jsDYX8Y8E4hCVe3gJ80nzu+xZbD2A/Pfufe2RAwwuRmIK+2vKSqIQsaZypBqbIIq8XoL5F7zR3/eWwUgfzsXZlzPIQYgPFnrLR87W225kTeojoy1iDkNRZqZm34EbIOq1Ozdj06yNCe0qouAu6vAyHwwjQSerpop5+1+99Y5R5ZCy7zgfShVBzjSPe5U9U0/lBls91ci9mhs+Ie7jvqrxNJRnjvyv2s7r9SNd0Am2jcGEKpD70KufBfg/qa/HUT7vLSPWsJiFRu2ETqGufUqXz09OfeVAvuGGw86ABo6CNqRlQcwZ0h2kYIYRjxYFqwFT4az8GskmIxIveHpIDUt7zjHlZgodqYeb+EMxm2rGMPvt1SkXzFaEHYnh4wBohTjQJPHloi03F87fImPC1I5rDZgJ3iuw0XW3XevCb+HDDlxhTkJxBjM9sZank5YKRvnCa5JDGnO22rd2vTFjyk6GeGlxiAkM+LX6dRvwdK9bJc9WqCrE0sD+Tl/f7psaNuiPFBDHUQwMUqsnECcS10pFwX1FLgn/Xz/GqQUGcT5Yd8eLqRse43kF359GWNZqpf+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b378e061-6f33-48b9-11f2-08dd6174d1d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:47:32.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syHnRWnsuveK/jr2t1YOUNyjQf9BJCnwDsv5PCCfWsxHIpMvyDwRIGI62XFOOQGAWfsWnHYMXdbP9XXhld3hKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120101
X-Proofpoint-GUID: moXB60iFNq-ifOOnhXoaDSpMal57239G
X-Proofpoint-ORIG-GUID: moXB60iFNq-ifOOnhXoaDSpMal57239G

On 12/03/2025 13:45, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 08:05:14AM +0000, John Garry wrote:
>>> Shouldn't we be doing this by default for any extent size hint
>>> based allocations?
>>
>> I'm not sure.
>>
>> I think that currently users just expect extszhint to hint at the
>> granularity only.
>>
>> Maybe users don't require alignment and adding an alignment requirement just
>> leads to more fragmentation.
> 
> But does it?  Once an extsize hint is set I'd expect that we keep
> getting more allocation with it. 

Sure, but that value is configurable per inode (so not all inodes may 
have it set)...but then it is also inherited.

> And keeping the aligned is the concept
> of a buddy allocator which reduces fragmentation.  Because of that I
> wonder why we aren't doing that by default.
> 

As I see, we just pay attention to stripe alignment. Dave also 
questioned this - Dave, any further idea on why this?

To me it could sense to use extszhint as the alignment requirement, but 
only if no stripe alignment. We also need to ensure to ignore this in 
low space allocator.

Thanks,
John


