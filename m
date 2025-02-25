Return-Path: <linux-fsdevel+bounces-42602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB58A449A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 19:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6905918906BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59019CCEC;
	Tue, 25 Feb 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="budxzyoc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IzlzjoFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F06166F29;
	Tue, 25 Feb 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506849; cv=fail; b=m3AivPzbqgLXSwNE/BffdBBq0h1Pcmabojz9JwzJOYTBd6KDb+P94kyiutY2peM+e200K7XzXt6gCWIEQ0lTaPUFEF7WZIDqDGcwWk92/Ka1rzWRzmyBI5hIulwyGxcxz4CcfuHNSNbPf12flpuVexUk32kkms2UrYmQFRK41fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506849; c=relaxed/simple;
	bh=ScBJDYyVsPml+2fXNip2IM1Pu1JK6sc4t9d8X8Ni6LE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnumxlLgd7IF0NeCtyXh+T2ikzf786fpegF28m8zbGBwA+SLmF6coZkY/dm4PFgSrW1v15tZk+jK7gSotRMUT1bdIwaPJzRnrAYvCa/4plmRJNL6vGlRIYKt0wHkayV/Db9Vuk1kw2BApAiJ91WrDYTFok06NMSuOEsUu3Aehpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=budxzyoc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IzlzjoFv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHtZ92017671;
	Tue, 25 Feb 2025 18:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+aZWPACB3MQqn69eigVCAh8gbI6kJCHnJwfto0PtZPc=; b=
	budxzyoclyuchqlUdP+vAWgKjjYjnww40TsPJWnqGS+euap6WvjoMPw6xUpKg2f+
	m3B1+4+rOOqy+5GTnHp3Ion9ttz6w7qJdNW1cI8NMjjcAHwlnkCGACrABZgoKlU1
	yOy8CZQCwOiUwhvgokeRN7EQoTee5OcS/PwJGRC4BctLbR80toe2SjtlOJ1/3irt
	dzfsyrnT//DK99UmEFr1JmSNmKH9GknDN9WHjl5trfzGPAN9bdYi/+KBFdE5Wyqr
	/I6dwYqtfPS7saZPvGvvXAQZC+lrEAkc6DrtOg01zTY9ViOyLQ9s4kX2A48VxAug
	88TBtj4rQklrKdvyaLakkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sdwse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:07:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PGqp7O012609;
	Tue, 25 Feb 2025 18:07:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51av48g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo4l/sD/chQuiP5NBdbEeQ468L53bkL5hZ9xbFhUuJNDMZiccgKc/MYQiZbQdHpEKhZJHot8sEMK70ytQBz7pn/91m8JhE+ftJh9rm9NbU8F5xfvh/1Dfsn3bpLDe0l6mhfP+SWHzO+wpJnU/Q+4ZeSiT8nmK/a4qAcC2BSNKIGAWcM0yfATDwW1wIaL1FDKV5hK7yHseb+Ylzz2dVUOerj8EggAxaRnuLFcyJj17ewEDKkIRLUmkHIUacb4SSjSvh6Bd863vBYqE+7szt5IxebhhEdtSTW2b5ma9w9HLbuPVd1HpWYPf/NprfApeGVCuqx2k6dsLLJRmoRSvrmWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aZWPACB3MQqn69eigVCAh8gbI6kJCHnJwfto0PtZPc=;
 b=N2w/N8NeduakeGuxU+c93S8ejKeFCD9Q7Ml53sOZIvRzG+QIgFTqSHI+ebPdg5mFc8/5Sw/FYdI3YSUcmLEY499sQTDSGVRuND9avPbMcLpRr+INvjJ3FvtNEdmMpYeMhQU7aBw4egplANYGDiBkLsMjBHS9Vi5ozxp82Qr95/zrStDicg1K7UBO8synKxSO4FMOWdU0ze8PBhXshnWiEohEuBqEDiKaZHYApI4yi0VU3G0xOTYTqUsGCKZ4WHwI2DVD9GqEAmnXb3QDdxH7lc1o4K5fSS6v5KdkmGKq9oQ2v+0qEW4LyhfXmZQkKYx+elOJ7NZKSUGT9n0W4+weXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aZWPACB3MQqn69eigVCAh8gbI6kJCHnJwfto0PtZPc=;
 b=IzlzjoFv8NdwR0SGso2aNt823H+/+i8VP/I/ro7cF2+6ocpsjfcyoIIgMtpY2cumeNyUccgSTKYAUN+CPseSHXNbylxHhnfWUgCEdjF5Yblj9wA3pf8U1SNRWzkADeqAgkERLUdRLeKg1VNj/e6ojfu/XX06o8FWhnleMkgrhJg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 18:07:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 18:07:13 +0000
Message-ID: <cbccb472-7c01-4aef-bcb6-d303df7b271b@oracle.com>
Date: Tue, 25 Feb 2025 18:07:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] xfs: iomap CoW-based atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-8-john.g.garry@oracle.com>
 <20250224201333.GD21808@frogsfrogsfrogs>
 <4e78abd2-4f84-4002-b84c-6f90e2f869a8@oracle.com>
 <20250225174727.GF6242@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250225174727.GF6242@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0036.eurprd03.prod.outlook.com
 (2603:10a6:205:2::49) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe38c72-f9c0-483e-5f28-08dd55c73b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUw2YUdYSlBTdHJNRWRTeFFzY0pTd2U5TEJ6a2RQQzd0cE9IemRuOUFva3BF?=
 =?utf-8?B?a2F5NEFKNzlzb3YwZWRhb1BxR21JTi9WbFd2WFU0V1NGMEE4WTYzNDVmemt5?=
 =?utf-8?B?V25sSWFhYld5Z0Z3MXUwY29selh6VmNFd0RzN1lPazUyZjF2TnVXK0h6bnVU?=
 =?utf-8?B?Z2kwZElOQzhObzFzK1J1UTFNRTFYa2VvWCttS0tlTGJsbGlBZ2w1djhQeHlk?=
 =?utf-8?B?bDdQcmd6WXJtTWVpTGJjSy9NemcxcUx2bXNlVnZlWVNabDdJb3NJTmo4RGRZ?=
 =?utf-8?B?TFgxSjBvZHpLZG1uNG1CMVg3N1FpTnlCOHN4M0JhajdpYldJS2lGdlhhMzk5?=
 =?utf-8?B?c0tzQ1ErYUxKRmRIK2ZIdkN2UmF1eUlsNVZ6SWg1VjArdEZOOHNvZHZibURl?=
 =?utf-8?B?dURZK1NoYU44OEJvNVo5ZFJZWDZ6SUsvNmY2ekZYT1lSdjMrM2pZbXRKaE1z?=
 =?utf-8?B?dzBNTUxrN2lXWTZZOG9qS3AxcEFIeVA0WDAzckdLc0JUSC9jQXM0U1JPaG5a?=
 =?utf-8?B?c2lZWmlHV1d6eG44SkpIdjdJcTZwVjh2RFV6NHR4NDh2cStaNHlkVUxRMTJX?=
 =?utf-8?B?aStXaE13cmR3TzB6N0NybXBkaXVWQ1NkejlZWXlEZFJJOVJVSkdrRHFYTXlp?=
 =?utf-8?B?bVdYc0F5M1hFY3BvZTZleFhIUmhHV0taZW8xZCt6MGpYL2FjdUd3T1ZrSmR5?=
 =?utf-8?B?T0x6aExya2cwd084eGgvdjNDSTc1VXJJS0JyNmlnR0NZNUxoVmpkbThNbVFF?=
 =?utf-8?B?R1NFOE5CTEtIck51c2grU3Vqd2lmRFB1T2hyRmhGdmtvZG1SZzJhOWVQeDdK?=
 =?utf-8?B?VW00encwNjZTNUtLZXJJWERsZ1JpNzFZY3piNktTb2UvSjNMY2dTQmxxQWR3?=
 =?utf-8?B?aWRUeDJiZFpodEM5SEZ3UlVrSXZmV1JzUEVFUjRrOHVWd3FMQkJJbVRwSkR5?=
 =?utf-8?B?czczZFdZNXhGbmQ3VkQyaEFwZzZWREcvRnFaRDVJZi9qNzFLZGpPYm42QzVu?=
 =?utf-8?B?N01qSmtIU3c5dDd2ZDdLbXRkOTZrV0FnZDU2MGtER3U4cm1CdUdrTmZ3SWZl?=
 =?utf-8?B?K1NOT2RYMkQ5RGpBWVJyajY3WWt5MWRjUHYxT1RRQWpzbjZtVmZXc3ZSUCtP?=
 =?utf-8?B?YkllUlhKdUxESlNlR3NlR2NNck1rRmhWeVBmbVRXYkdkSjlVaDNpYjNUd3Vj?=
 =?utf-8?B?T0NOSnI2OHdrLzdaN1MrL2lPSFJ5RVEyeFA4OGxtOEs4WklXK3pTWXRIa3Jk?=
 =?utf-8?B?U0VtVXUzZDNORWY2eFlJTmd4RFdVdlQ3TENwK2h0L3NJS21kaWpDeDIwcjBH?=
 =?utf-8?B?VWY1MW5BNUlDa09RY2dKcXg3NHhGNmdpamdGTHZwZ1F4Tmd4U0I4TkxNdlND?=
 =?utf-8?B?RnJWamRoYjBmSDRtMnQ1L3ROcTFjY0FkNEdTL0d0dThvejNEOHNibUVtNHVl?=
 =?utf-8?B?eW1ldVJKMnNDUklLZHFBTFlFSHYwWnhSVVYzU3JDUXRrbmJiWjE1RFVITUI3?=
 =?utf-8?B?cHlrdDJTMnhya0NJK0tkS0ZBeU5uSVd4WkpHUVJWL0RrNktLd0wySS9NQ1Vm?=
 =?utf-8?B?WXZ2cnNKZ2NidTFDRUcrZm8rMS9neUMrM0FwU0QrYzRHZ2hIbk5xZXAybUpi?=
 =?utf-8?B?RzlVK3ZNVWtBTUlKUnI5ZXdDeCtSV1VsdDFWdzk4eUF1YmlQZDdtTUl2Y2lC?=
 =?utf-8?B?SExKaVdMWmpJODZEM0NKa1IrRmFMOEpkTVBmQ0xBUU9xYy9qcmpDa0JuaURm?=
 =?utf-8?B?WUF6bXFxNk5GUW1zNlRob0RwZjJJdG5KZE9IQW4yZ1MxZEUzUExCVDZ6a1hB?=
 =?utf-8?B?S213WmVnUkpEaGVjdlY2aWtOTFlaSnFTUmVWVGFackdvcklPbFMrMkI0Vy9G?=
 =?utf-8?Q?c4NxPGEphLOFy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0t1cHNPWFUzQVZnNFZTUmNRZzBKWHg0aWx6V1pzZUM4S3dLZzNiYWFIZUFG?=
 =?utf-8?B?dEtCdWkzUks3SmRrZlp6dm9vUnF1TUdpU1FBMzlPODN3dnRORnlIRUNCWjdw?=
 =?utf-8?B?YTA3L3pORjBXSDVieENTYnQ0ZFJiYzVsTGQweGlKaFpsRjhtTFNzVFJZVVVy?=
 =?utf-8?B?TmlvczBHc1lDellHQ1ZnRTRtOTRGeEJBQTBPRXRFcG8wOG9KTUprSUc0WVZk?=
 =?utf-8?B?RWhVSm8wNEZ0UEZsbHRIMXNLbmlmNUMzb3hvbHlvS3l6aFg4WldLWkFqaUhu?=
 =?utf-8?B?VWkwUkd0c25VSEphb3dCeVhZUlUwNER6Q3pqYXd6cmdhRHlkOVVuL0NZUGY0?=
 =?utf-8?B?d1FJUlU1ckhBdkJyWGV0M1RhZ1FHVDZJc3JtaGFkVnFuOFI0SDhtZXFNd25x?=
 =?utf-8?B?bTMvUGVtVnRJZXBtbDc3OFdGQXFBaExBRHdIM2dOSTRwWlBsNzVYNzVkdWFN?=
 =?utf-8?B?M0tXQXFsakVYOEN0OUxIeERWdjNTdm14cndmY3JjUHo0VnYrU0ZHaWRWLzFm?=
 =?utf-8?B?aGJMLzBTN2RnOGNEQy8xWm1abG5QUlZyR2lvOHVGMkJ4ZWp2bWROc2didHNu?=
 =?utf-8?B?eTNPT3hWYzV4aThRYncxVUQ5Yks2RGxJZ3pYTXRIWElQaTZtb1lsNmt1RUNi?=
 =?utf-8?B?U0orVXNqTDFoR25idG53azduWE5EOUFFaXFETnpyR1JIWDZmVkMvay9rRmpi?=
 =?utf-8?B?M3owd25xOGthRkl3bnRBc0ZmUkhPZ05JMUk1ckRmNHBLNzlja0YxRGFnL202?=
 =?utf-8?B?RDd1cWxnazRLMjNWNysvTGloem84eWtXdVJlQnJhdXczd0FwQjZIUStFTHBB?=
 =?utf-8?B?clFOcWprTjJxVWR5S2c5Lzk0ZXl3N1RKOFVpOGpkSWpXRlBHT2Z0WXdlK2RE?=
 =?utf-8?B?U25IN2QzR0w0c1I5d2ZaRU5TV1FsRUlqRW1jVXZHNk1ERGtIVHhlZkZxTC9S?=
 =?utf-8?B?d3pKUlMySEcwdkI3M3dHdWdTNGQrclQzY1loK0lDbjAxRUFtemtrTmRSM2Yx?=
 =?utf-8?B?dGZqTndZOHFTaWJZeHI3QkZmR2tOYmdlV1VSaHBrYjU3WkVEVTlpbXhzUHVX?=
 =?utf-8?B?RitKaFc1YktmcTZaZ2tlUG1xeG5sa3F3dW9TN1VvSll5WEpDa2pWcDduMUJL?=
 =?utf-8?B?QzB1eEgvd1g2ZUIzc2JKNUp2UkYvQ3NLVk15dTUrTHJFb2NER3JScWR4ajdM?=
 =?utf-8?B?dzF6aW40OGVXRkVVb1NORkExT1hOcVRQbHVON21BU0lROTJEVmlMUCszWWZ2?=
 =?utf-8?B?K0phWjNZdGNXVDFMZUI1SzA0OUFyRzF3QXhUYmV6Zk43Q0I3QTJWV1pkeEl6?=
 =?utf-8?B?V1l2Rk9JSTVHcFo0NDVMREQvQ2NRdklyNjY2WkxYMndDTnRQRCt2bkJqcE1N?=
 =?utf-8?B?WU5kMlNCM0xmK1pWZjB6cTFqUUF0QW9QbGF0QUNocGwyR1Irb2dtUlB0amJj?=
 =?utf-8?B?eW1YMEVMU1dFVlRSWTlNS0ZCVzg5VmRxYTRuUmtSK2NNREJVUkIwK28vTGpD?=
 =?utf-8?B?bjJyOGhKbTVvSEtUUW9YRjl3ZmdqSGtSUkF2VytkMjdxOXowMEx6SmROSGp2?=
 =?utf-8?B?Q0oza0hDTUdwblJWb0prVWx3ck16b05vSzJteFE2QlowMGZwVk9leldXSkZa?=
 =?utf-8?B?NlpNNXBkTGV4YlIrdnBFcTdHR3k2RzJQV1ZtN29ZdHRqZW02KzZPS1VFcFVD?=
 =?utf-8?B?OExTYmhscFk3bzB6UkJBdVJwYVhCVzFIR3J3RTc1Si9YZXRSM1huenlaNFhE?=
 =?utf-8?B?OHB3Z0NnVkFtaUlJSWxXQ1E2VDY1S0Vjcnp4UGdzQSs1aXQ4Q3Q2cEs5ZmRI?=
 =?utf-8?B?WVZWa1R3MVlPQ2llNjNaU3dGS1VtaFh2UVNIOXNrMWh6NWx3cmU2ZDhteDI3?=
 =?utf-8?B?ZE9PZzNGWUM4OHQyRmJNdEtZNi9KeTQ5M0NRb0YvRmUyWUJRc0dONUJPRDVR?=
 =?utf-8?B?Yzl6TU5Hdy9VOU1yQUl5NFlPQS9DdXE4RTRJTHgxbDNKeE9xNnloeUxLUG52?=
 =?utf-8?B?NWlJb1lZdVRKM01yZkdpSTBDNHpOZGMwV0pDSEhvU2NaenI2OFFTMy9zUmZE?=
 =?utf-8?B?dFNTSDNFcnZpKytVN3J1cGpHblZRbktoK3RwK3NZRGtRVk1oV0t3NDdTellr?=
 =?utf-8?B?Y2x0Um1QV1BkR1QyeEl6VEY3T1VnTzdxa3orM1pEc1lCdnlsU1h0Z0ZyOEMx?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vCrFUdVgS2N8AGorHg4MfV1QuPzCmQLC9JqDVH7EFG7uBIqzK6+pCXmZ4EQw9F8+OXQqA22nLHiPgi7cmMuktWcQZXI6ps2Qtb1Vk22JVnXbYdJKGyvhK6tJjrRaz+ZCg32m2B84mIQiKkfH79YAlNmpKI0R1eTIOeuB1ZvfHo9PBYx6iAqiWBoikzMXj0dCf/QTRghK1FA4eXjQcFELbUkAWpkqxRvjsoWNfu9aPGT6m3w7lSRlmcXQPflxi1/BqjBq4qJmu5vWHeRsO+VHNM58NVeYdCO/q6DC71l+ZKlHJ5Y8IM4ClTCI33zBQQ81n0jCmYum4hfv6sbBrICwO0Oz7E+IjeOrijTj/HmUThGceFo3NH88DcvLk84IvoMN8KhyYtIfCNpduFR1NDicfo1KQ+9berKUBjFPlktjBnLTidPw5j/pQzuVFmzUWmAgzE0YvBnic6f0HOoEr1aMI+j6diRxfBlCrvD6wmOQYp1QMyL49fHF5HjmLzI5X+5PRH30eyuMYLwgBemfMFXTZUUqrXgkpDits+yfiYDVsFLx3w83ca+nQEdsjSI23KdwgfXTwtIyWCa0iFNPuoCw7gL9bUlN+wJj7yHn4ddW7hE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe38c72-f9c0-483e-5f28-08dd55c73b1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:07:13.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1nUbYhfleH9bbx4p42al49uXLtFVH5ws95dPpN4BdEW79y5Icg/nDj4njEeZMzmS9zdxJQ8dgb1XyqjnEf23A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250114
X-Proofpoint-GUID: E-ZCrBEXU-5wNetuVsV3t_DZxYntz9tx
X-Proofpoint-ORIG-GUID: E-ZCrBEXU-5wNetuVsV3t_DZxYntz9tx

On 25/02/2025 17:47, Darrick J. Wong wrote:
>> I can try, and would then need to try to factor out what would be much
>> duplicated code.
> <nod> I think it's pretty straightforward:

Yeah, I already had done sometime like this since.

> 
> xfs_direct_cow_write_iomap_begin()
> {
> 	ASSERT(flags & IOMAP_WRITE);
> 	ASSERT(flags & IOMAP_DIRECT);
> 	ASSERT(flags & IOMAP_ATOMIC_SW);
> 
> 	if (xfs_is_shutdown(mp))
> 		return -EIO;
> 
> 	/*
> 	 * Writes that span EOF might trigger an IO size update on
> 	 * completion, so consider them to be dirty for the purposes of
> 	 * O_DSYNC even if there is no other metadata changes pending or
> 	 * have been made here.
> 	 */
> 	if (offset + length > i_size_read(inode))
> 		iomap_flags |= IOMAP_F_DIRTY;
> 
> 	lockmode = XFS_ILOCK_EXCL;
> 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> 	if (error)
> 		return error;
> 
> 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
> 			&imap, &nimaps, 0);
> 	if (error)
> 		goto out_unlock;
> 
> 	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> 			&lockmode, true, true);
> 	if (error)
> 		goto out_unlock;
> 
> 	endoff = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
> 	trace_xfs_iomap_found(ip, offset, endoff - offset, XFS_COW_FORK,
> 			&cmap);
> 	if (imap.br_startblock != HOLESTARTBLOCK) {

note: As you know, all this is common to xfs_direct_write_iomap_begin(), 
but unfortunately can't neatly be factored out due to the xfs_iunlock() 
calls.

> 		seq = xfs_iomap_inode_sequence(ip, 0);
> 		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
> 				seq);
> 		if (error)
> 			goto out_unlock;
> 	}
> 	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> 	xfs_iunlock(ip, lockmode);
> 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> 			IOMAP_F_SHARED, seq);
> 
> out_unlock:
> 	if (lockmode)
> 		xfs_iunlock(ip, lockmode);
> 	return error;
> }


Cheers,
John

