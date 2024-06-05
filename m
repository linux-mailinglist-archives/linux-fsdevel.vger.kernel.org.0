Return-Path: <linux-fsdevel+bounces-21043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7148FD0CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC04290421
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BBD1BC3C;
	Wed,  5 Jun 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IIWRm71v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="auGg8uzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CF23D7;
	Wed,  5 Jun 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597606; cv=fail; b=ml7kqo/IihIKbw3pEbX9FEIp1QVMUDsgXTJiDW5BUsuDWRvtVWbc2lIBDKBeiOBd32A1wd2k3ngPAsf3UZnDW90mFzxOO/S4Wf3tufJikkCK7oRoS9CE2CUNqJDuH0YmMYLhBw4SBW3oyTcx2msKsh5HXZcjVfr1jne+x3Bqoho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597606; c=relaxed/simple;
	bh=uybhBlj31ncSNdDg0xinoNj09o+sbycKirE2xxVW8Vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KFxqEYB+lshZCQeZ8zekMNP/g7a6fR7wlde7enoo/VS6+GYNC0mWiCm/1b3uQb3G/I3K++vwWskQCHQpr0LM9QxbMvZI4hclr/mlQ9y1UuMaLLZEdu7sTneLgFW4ZBr7JVA8gXD9ud78O+6JMSGQHpCA7G0P/YhsdZ4CSR4YOKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IIWRm71v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=auGg8uzr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455C2xJ2002352;
	Wed, 5 Jun 2024 14:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=z8qDnrYhBtx9j8ToAVPoEFmtkKRuVgsHnxtDWyVRCcA=;
 b=IIWRm71vKPEruLJQAIaqwBvcZ+tiOH8YhzSWVZbbJU6D5Tt0KxLURLzyvjN49sDXY5mW
 dth2draAfHgq3kY08n56lZGn2O2TElnBYUR3XCylBXy00VdGUzI7xP679bfjZL9WsFjr
 r+28FJgDgEbITb6KJVPC6ogXoceQe8BoLvhMhB88bWK1stFcW2qKo1WkrD5+7DMqAmaF
 DJLkXQnufOKtKabKTkKO+vv1SB8phSlIxZvOimXI4q3j9gfE5ZOQXrN34pO8Z9X826MM
 x8Lt0Bgyo+uh1m1VA5BFdyIRsrywRe1axlEOCqnYDWgMAQFVbDxkCFI9K+5Y1By/VKnc zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsq1e4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 14:26:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455DWkD5023955;
	Wed, 5 Jun 2024 14:26:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqybh9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 14:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxTzOQiy/dfNP8CpSqs9zwU5HhKjIAsXmelZ96mVqB9N+n6YcuslQQWRUeBZbNdgIEKOYonpINxLhDWBqCvVtK1XFT6AEv+v1piyfPrCg8D/ObBIj+JZNFTnBA8HWSH1aCsUafaPmJKZ+Qz+DotIhehBAEW1YivqWVjWgzHYZx2I29PUz9MKXAEXX43k4J+N8qw3ce/bbAOI5jQI+HKSHf6Q1oe4YxSLAloIz05xgVO2M43nDfJYSdqY+DuzoDqyaoWcd0ypile4UcV2iwkJcpJtKvCfEXpiGk5ox2oW6uZTiT20QQBo1er0KvmSDeS9tFCO+ymaCKbpe+r1y+NV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8qDnrYhBtx9j8ToAVPoEFmtkKRuVgsHnxtDWyVRCcA=;
 b=CnX7DFjGinU8HHgnZt/5ar7JOUI643LtZiVDZvMWKr9cb5fDaFo/A9xNvFEHcBDZ0Osoos2DTcg5/2bJf2tvzqov+ELC+3bDoRHbDmcoVkr2mGsevX+0Iz991CXFq3N/fCm9oMhk2lafrdJG+XAQHdwIu/cY0/jNttP+GyWLHQRotAXzrkRXs0viYkpuFWJPh0ufvUWJ0cnDbbP9iMcB15rMDg7wFrUhzABVxwyCgBB8XoK1RcAGdwyPSpR80IWanoboIPJByHx3o+meYjsZ81/5wZ07Esg9iClecmL4JsI7mvbtrB1svjP/zpMX6+DAfJaJWhrIl73sLB2yz57fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8qDnrYhBtx9j8ToAVPoEFmtkKRuVgsHnxtDWyVRCcA=;
 b=auGg8uzrZFoURzDrulzQrCDUgyxilZ46jTx0LhyxctjXKMaDVrMzmiAjeS3mMTN3CPzbbGbS4+bAfVdmiFTnuWuPre5w4ZpmZMHh/qaOiOmcUQacO3UKWcQg+BL/4l9s14xxGpkhBzZ/DTU/lVBCGOxR5EwupX/usbEbFwEXZTI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6408.namprd10.prod.outlook.com (2603:10b6:806:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 14:26:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.032; Wed, 5 Jun 2024
 14:26:17 +0000
Message-ID: <c9ac2f74-73f9-4eb5-819e-98a34dfb6b23@oracle.com>
Date: Wed, 5 Jun 2024 15:26:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/21] fs: xfs: align args->minlen for forced
 allocation alignment
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, Dave Chinner <dchinner@redhat.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-8-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240429174746.2132161-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bff11d-b522-4ca5-f2a7-08dc856b764e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2ZROTJZdTgyTWdrYTgvbFhmUmNEbXZtVDNrNVpzT0NVdmNVVHFidjBsS0lL?=
 =?utf-8?B?dVVOTTZJYTNWMjJjSWJCVjQzbU0vNlZLZ3dlbGwyS09aQ2k1WlRLcmpJclYy?=
 =?utf-8?B?M3VoTFBHWTRDNmFBYUJseHhsS1FEVk1KalNjZms2VXgydGpCUDhkSFB1RkNs?=
 =?utf-8?B?NXR1T1FQOE1wQU9vQ2ZLbDFQVnd5MUdtQUMxUldqR1pWdTFTVkczajE5MElP?=
 =?utf-8?B?eUhFdHRnSExsbXpTcmFuYzlwWkZ0QlpodEF2YkRxaC9CbHhEMmtKUHJYTXNz?=
 =?utf-8?B?TWlYWldNeW9jdHplZEp0RnJvbHdkNEdYOGg1c2FBZmlOblNRRzhFR0FjdVpo?=
 =?utf-8?B?NmllY0oxRXZnWUlXZmM5dThaMjNJRlFQbUZpS1hGQTZLNmJvVENiVEVMYVVX?=
 =?utf-8?B?eUFkZjdVLzBNdEdIUVpMNkc4R2VlRHI4ZHRLZmxlenNTcVFiSTAxTE1JNjY2?=
 =?utf-8?B?cnQvOTFqQ0kzQXBVRkRzanRaU2pja21JTVpleGZYYTJDd04vV1VVZUFRNnBH?=
 =?utf-8?B?ZW5sRzdUeEorU1l3b0dRWjExdlJia0xWdy9ldUYxRksxaHk3bzN3cTBMYzhQ?=
 =?utf-8?B?bnFPNVkzdGVJd05ON0dlaE1yQXJTUTRoazRmVWNjblg3Yk5EWEhBMmNlaE9P?=
 =?utf-8?B?TzBjYURyTFp3amVaLzdLRVpNUVpjUHhEbXUzcGZBM0Y0V1pFTzBITGFiTlpm?=
 =?utf-8?B?RzNRMjFib2pneWswSGJPcEV5Q205YjhYeXIvNE9kV1paMjc1S3l5ekJqczU5?=
 =?utf-8?B?b29QYmtFQTFhNlEyT0RPQ2k3bDhablYvY2tjclR4cHVtMUpjbkpOeUM2WEln?=
 =?utf-8?B?YXhRdU5raEsyRDRlSEtpMUZRQUxtWVB4b0lWMktFNG9MMFd6UEgva1ZwRTRj?=
 =?utf-8?B?SWZLOU0xYnVnR0FRNVNGR0N4VDNBdHpOUDNsVDdUS3FBUENFdENzN214MFho?=
 =?utf-8?B?eW0ydHlNSFk3ZW5hbUZYVVlQMThNakFHT3dxVHg4My83SDhyeHdxZTlWTVpD?=
 =?utf-8?B?U2lqbGZRMHo4KzlDV1dSb2pIYWxhVHNLZ0Q2U1BuWHBjOElvVzBjUWNuYmpL?=
 =?utf-8?B?M1ppTmtwWVVubjFoc0gyckNib0VvdUZUYzJqSm0wNzJmMXByaVlvM1BDSDJQ?=
 =?utf-8?B?RE9NN2VvYmRJVGVOUW5ZRE92S0ZITThVSktrckxick5BcHR5K3B1RVY5NkYz?=
 =?utf-8?B?cEJ0ZkY3K2NmNnBqN3BlYktRcXZVTHo2QTJSaEQvem1wYVgwRC9jL0NCRXhD?=
 =?utf-8?B?WWVIaUt4YzhHWHR5OXNHZERISUtGbEQrSHRUMjljWURPOWY2bll0MEl1TzZa?=
 =?utf-8?B?dE9XVm9QS0pWVENJYjY2aHl4cWROVERSQTJIMldIZ0lRdUpKMExSMy9MVFBH?=
 =?utf-8?B?SGhxRXVrcml4QkVrWThQUjhJcGdiQ0ZHRmlrbnI1Q2lFTmlDd0lIUnRvdnJD?=
 =?utf-8?B?VjlkUUEwK1ptTG94Q09nc0UzemFCT3FNbmxhU2gvdWV0ZzQvdnY5eCt4ZkVE?=
 =?utf-8?B?MEpNNnRRbnVHelhFMkszTGVkeitoRlAyeStWbjVPclBKcCtXeTJZeEc5b2hw?=
 =?utf-8?B?anZWZmtaQWZVZEVLOU50QTErSXNqVHdVWERodzZWTzNCVWZQOENTMUd3YXlH?=
 =?utf-8?B?bkpqWmEyTHV1VXZ5U3hDREs4VnBQbDdaZjZXQituZXVMWlUyRGF2N2t4cFE0?=
 =?utf-8?B?Sm5wUlBjSlZsa08xMXhGOGxzZC9rZXBqbUtMck1jUUtFa3g2OUpyMTg0RDFr?=
 =?utf-8?Q?ck+vGFl2qazAM+BfuP6IXxfIYdaid2KCoMjqv1m?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkJ2Z0MzYzZjU1hidmpyay95Z0V1bU9NTDVnZ2pvbHNsazlGQld4SE5ZcHZ4?=
 =?utf-8?B?MEg5NHF5NERBdjVmejlyV3dVU281UHVOaVJvV3FGa1FZeWtlNnNsN2FBUG02?=
 =?utf-8?B?TWNVaHUzQ05yQ3BVbHN0czcxejRtYTR6MXN6aElwQTJDUWgwVEIyRE05aGhS?=
 =?utf-8?B?SE9IWG5yWGpEWDlLb1VOSUdTUTF5aUNDWlUvRGUwbGZkNWlibnVZNTZ6a082?=
 =?utf-8?B?cFNMWmN6Rk5HZk9yZ3hzeTVUMzlzWncrZVpIZG90U1ZzUTZNTXBLWi9Xdml5?=
 =?utf-8?B?UC80dnBBOTU1WC84WjRCK0RzSWJwaDZYWXVUa0p2end0TGtvTCtObDJGbjJj?=
 =?utf-8?B?cVMyS1RCS251USsrODBhL2lJVjYrR1l6YnRFNWIzVHoxRzMybWMrYmcwWkZZ?=
 =?utf-8?B?WlZVK2xveGttRExWaDZOWTB0bmJHenNWZTdUbFF1Zmd0WkJTTDZHR0xEcGpW?=
 =?utf-8?B?bDBKOGhBS1Vpc1hDSjYvMmdWdVJkYWF5elVPeklkeXcwUUVOK1p6Z2d0SUxa?=
 =?utf-8?B?UURFb0ZyQ1hZcnN1VVh2Qk8yeVIvSTBxWW9MSTEyV2pkN2lIZGwyRXFSS3Js?=
 =?utf-8?B?U1hQcEFGSmNaNGJCdVUyOWkxamtOMExsSytsRkVic1RORDVBWUpxTmRtQ3VH?=
 =?utf-8?B?Y0lSSDlVSE5McFYvQ1J5M2JVanNXTkJqbFE3dDA0VEF6Zng5cytCV1lPV0N0?=
 =?utf-8?B?K3hpNkttUXJyYVp4cm81U1BxMXlMNmlDdWwxNDlOY0llM240Ym5zcFFpQnpS?=
 =?utf-8?B?dTY0cGZHTUlEQWhzVHNGdzhUTWFmMTJrWHNxZkt5NmJMQjVVUmdtMldseWR0?=
 =?utf-8?B?ZVdlQ2gvT0Y0VXRpZGpMTzhzWHcrb0orQk5QVG12KzkzeEw5dFNUaHBCcjJS?=
 =?utf-8?B?MEtTRHhGb01oVXVHWlBXV0RNT0lkOUFnU1FqTk9EK0JlVllIVDI0WFR3ZkZO?=
 =?utf-8?B?QjNpOCszL1FCc0N4WUhicVl2N0tLTmswVEtjRlhXWEpNV244UlQrandpdDVh?=
 =?utf-8?B?Y2IxYVdTU05wdUZiZnU5SmVHN21xSi8yZGhqWG5TMSszdVhLK0ViNHNMejJB?=
 =?utf-8?B?RFJvSVBicWk3Z09zWFFKR1Y5cmQrcHBsL29xZ0t0dHN0Sk9kSG9Dc3RYcFRR?=
 =?utf-8?B?RGhjSkhZUElza3dPWC94ODNUdVdwUG12Y2dybWVicGI0Sk8zaFBWdmc0Y0Jj?=
 =?utf-8?B?RDBNWVQ5eERVY0pUc3dSdU83TUt6Q3VEa0hXUEQwZVkzUnJFMnB6R2l1Rktm?=
 =?utf-8?B?THpKczJkc1hvOTdXRG1wbjZsbjBNcGJnZ0U1dHEwU0tjTXU0bWIyODBUZ2FJ?=
 =?utf-8?B?MXlyTjZPTmJ1WU5XdllWT3MwVjRBK0N3SkQrZG1JK2IwOGh3ak53N2hxUmR6?=
 =?utf-8?B?Z0dGby9tR3pwYjB2UEg5WDE4SHBYVkQ4dzdWcEJzYW9QUnVNL3Nqam1hT3Ir?=
 =?utf-8?B?SVc0NTBoK1RvbGo2WHJlL3J4SjhFUzVtQ2hacngxWmhnVzRUcnlCT0NpZTQ5?=
 =?utf-8?B?Y2NrbzFWWGxSdGE0SFVCQU9wQ1hWbzRVWTdicnpZR2t5dVVzTlR2MzBjWit2?=
 =?utf-8?B?SUYwL3dJcklMM1VoSjhkcUUxMDlabEpvdXBpQjBjdkFyS09TVjRjTnJzYlBD?=
 =?utf-8?B?VWFDeUFQL0F0bjV6dTJHT0Z4YXI5UEJiNXNma0Iva1JMNzd3QUw5SzdGV3dr?=
 =?utf-8?B?MGxqdkU4M0VRS1FSazlOWi9hek5CNUMvZ1VENUJWa1NHclJEMnF2TWw5ZStm?=
 =?utf-8?B?VDdJUmlBMTE4WEhvenBXR3h5c0ZNNGlrZzJmcmEySTFsQUxpVkRzU0l0bGk5?=
 =?utf-8?B?S0t2eE1QWGgvMHpuQ2VvZnpWbGZpNDF2R1c4cVhFRUowWmpjSSs0YzBRQys1?=
 =?utf-8?B?b2JqQm8xOTBKUHB6ZmJqc1JveDhUcHZpOWNYU1c0c3NHT1VpN1hBZWJCRUVK?=
 =?utf-8?B?M1VWemhLdy9IRTZxbkVNQmtIVXQrRmVnQmVqbmxkcnVUVm00SjAwOVgxWDFm?=
 =?utf-8?B?SHhvRmI2ZURMV3BUKzhjUzNlUHZZdUE2cTJnL0tJbEJJcGRPcjlnb1R4TVdH?=
 =?utf-8?B?ZDlXRFFrQ2pWbDIxc3lKTUxZSVBDZldtekZDM1MwSmxzUXZUQmt6Y2kyQTNT?=
 =?utf-8?Q?NJ3ORBcRBqeNSFfkDba2176E7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wo3q3Jmu/BgzN/3V1l6PEN0fiTH9JQqzKs8mraZx9oTY+ZI+nbeauiFGDmZpy1CKi7hCPJD+y+QSRlzbr5OXqrfvW1x9+xTEJYnkJijPuIgGpnu1pdI8WFLll/0KaeabwRCcuZeTsqytJ24EAa4jIijAgtNo7cgNvioaTz2he+lKOSSSbw9Iw6AcN4iDtihDA06d2Nvo5CiW8RVA/OO+sexucpTMDYxh2P8G7NtJrjwKQbFndyp4yQcFX7U+RlKX9HWpRRa+F8oFyygaRTUATkldFcIXcE+x0Rdzm2974gxa7cLxy8yfh0d7nKbfHwjr7cVYPwJkv90UtGkyMEaaRTXhVwUBS11seVIHxk7lQu+YOkARkyOd38e4+GgG5dAh7fdMPMv73bM/flG7Yay92fWnor0DRe5v6nps4W040Vwm4BzgxRkTVvw6XjhDTVMp+Av8rTI2IT2MRuNbO+MbDrviEaRP4U7O9g+v+3VmYxICkWvOXTkkw5Z/F4ByR+1EaBHjLL0dxVo02FORbAYDFEG/wnrEL9h0GUWH7JMk6rDT5RKrNTY5vwQGTOrPj6HytlMSs+RmRIoCnASLU0xQh6WTK0POgYxTqO0DYycfVPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bff11d-b522-4ca5-f2a7-08dc856b764e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:26:17.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4OM8B7DUumwA08yxPd/34XkTth8Vwc6MCerKWQCKbm/Sxh6pBr77yYYzQ9aLf3t5C5Krcpk81d6IEZYO5o9Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050109
X-Proofpoint-GUID: nFtJGepF50UhaVhAMbM0pq6s_wHewnRU
X-Proofpoint-ORIG-GUID: nFtJGepF50UhaVhAMbM0pq6s_wHewnRU

On 29/04/2024 18:47, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> If args->minlen is not aligned to the constraints of forced
> alignment, we may do minlen allocations that are not aligned when we
> approach ENOSPC. Avoid this by always aligning args->minlen
> appropriately. If alignment of minlen results in a value smaller
> than the alignment constraint, fail the allocation immediately.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   fs/xfs/libxfs/xfs_bmap.c | 45 +++++++++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 7a0ef0900097..4f39a43d78a7 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3288,33 +3288,48 @@ xfs_bmap_longest_free_extent(
>   	return 0;
>   }
>   
> -static xfs_extlen_t
> +static int
>   xfs_bmap_select_minlen(
>   	struct xfs_bmalloca	*ap,
>   	struct xfs_alloc_arg	*args,
>   	xfs_extlen_t		blen)
>   {
> -
>   	/* Adjust best length for extent start alignment. */
>   	if (blen > args->alignment)
>   		blen -= args->alignment;
>   
>   	/*
>   	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
> -	 * possible that there is enough contiguous free space for this request.
> +	 * possible that there is enough contiguous free space for this request
> +	 * even if best length is less that the minimum length we need.
> +	 *
> +	 * If the best length won't satisfy the maximum length we requested,
> +	 * then use it as the minimum length so we get as large an allocation
> +	 * as possible.
>   	 */
>   	if (blen < ap->minlen)
> -		return ap->minlen;
> +		blen = ap->minlen;
> +	else if (blen > args->maxlen)
> +		blen = args->maxlen;
>   
>   	/*
> -	 * If the best seen length is less than the request length,
> -	 * use the best as the minimum, otherwise we've got the maxlen we
> -	 * were asked for.
> +	 * If we have alignment constraints, round the minlen down to match the
> +	 * constraint so that alignment will be attempted. This may reduce the
> +	 * allocation to smaller than was requested, so clamp the minimum to
> +	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
> +	 * to align the allocation, return ENOSPC at this point because we don't
> +	 * have enough contiguous free space to guarantee aligned allocation.
>   	 */
> -	if (blen < args->maxlen)
> -		return blen;
> -	return args->maxlen;
> -
> +	if (args->alignment > 1) {
> +		blen = rounddown(blen, args->alignment);
> +		if (blen < ap->minlen) {
> +			if (args->datatype & XFS_ALLOC_FORCEALIGN)
> +				return -ENOSPC;
> +			blen = ap->minlen;
> +		}
> +	}

Hi Dave,

I still think that there is a problem with this code or some other 
allocator code which gives rise to unexpected -ENOSPC. I just highlight 
this code, above, as I get an unexpected -ENOSPC failure here when the 
fs does have many free (big enough) extents. I think that the problem 
may be elsewhere, though.

Initially we have a file like this:

  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
    0: [0..127]:        62592..62719      0 (62592..62719)     128
    1: [128..895]:      hole                                   768
    2: [896..1023]:     63616..63743      0 (63616..63743)     128
    3: [1024..1151]:    64896..65023      0 (64896..65023)     128
    4: [1152..1279]:    65664..65791      0 (65664..65791)     128
    5: [1280..1407]:    68224..68351      0 (68224..68351)     128
    6: [1408..1535]:    76416..76543      0 (76416..76543)     128
    7: [1536..1791]:    62720..62975      0 (62720..62975)     256
    8: [1792..1919]:    60032..60159      0 (60032..60159)     128
    9: [1920..2047]:    63488..63615      0 (63488..63615)     128
   10: [2048..2303]:    63744..63999      0 (63744..63999)     256

forcealign extsize is 16 4k fsb, so the layout looks ok.

Then we truncate the file to 454 sectors (or 56.75 fsb). This gives:

EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
    0: [0..127]:        62592..62719      0 (62592..62719)     128
    1: [128..455]:      hole                                   328

We have 57 fsb.

Then I attempt to write from byte offset 232448 (454 sector) and a get a 
write failure in xfs_bmap_select_minlen() returning -ENOSPC; at that 
point the file looks like this:

  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
    0: [0..127]:        62592..62719      0 (62592..62719)     128
    1: [128..447]:      hole                                   320
    2: [448..575]:      62720..62847      0 (62720..62847)     128

That hole in ext #1 is 40 fsb, and not aligned with forcealign 
granularity. This means that ext #2 is misaligned wrt forcealign 
granularity.

This is strange.

I notice that we when allocate ext #2, xfs_bmap_btalloc() returns 
ap->blkno=7840, length=16, offset=56. I would expect offset % 16 == 0, 
which it is not.

In the following sub-io block zeroing, I note that we zero the front 
padding from pos=196608 (or fsb 48 or sector 384) for len=35840, and 
back padding from pos=263680 for len=64000 (upto sector 640 or fsb 80). 
That seems wrong, as we are zeroing data in the ext #1 hole, right?

Now the actual -ENOSPC comes from xfs_bmap_btalloc() -> ... -> 
xfs_bmap_select_minlen() with initially blen=32 args->alignment=16 
ap->minlen=1 args->maxlen=8. There xfs_bmap_btalloc() has ap->length=8 
initially. This may be just a symptom.

With args->maxlen < args->alignment, we fail with -ENOSPC in 
xfs_bmap_select_minlen()

I guess that there is something wrong in the block allocator for ext #2. 
Any idea where to check?

I'll send a new v4 series soon which has this problem, as to share the 
exact full code changes.

Thanks,
John


> +	args->minlen = blen;
> +	return 0;
>   }
>   
>   static int
> @@ -3350,8 +3365,7 @@ xfs_bmap_btalloc_select_lengths(
>   	if (pag)
>   		xfs_perag_rele(pag);
>   
> -	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> -	return error;
> +	return xfs_bmap_select_minlen(ap, args, blen);
>   }
>   
>   /* Update all inode and quota accounting for the allocation we just did. */
> @@ -3671,7 +3685,10 @@ xfs_bmap_btalloc_filestreams(
>   		goto out_low_space;
>   	}
>   
> -	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> +	error = xfs_bmap_select_minlen(ap, args, blen);
> +	if (error)
> +		goto out_low_space;
> +
>   	if (ap->aeof && ap->offset)
>   		error = xfs_bmap_btalloc_at_eof(ap, args);
>   


