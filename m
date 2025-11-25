Return-Path: <linux-fsdevel+bounces-69844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF1C87495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 23:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90F1F353C9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5C3328E3;
	Tue, 25 Nov 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSc7gots";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OPgey6pk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1542F6572;
	Tue, 25 Nov 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764108440; cv=fail; b=osBJPNgUW0lU6tKEfm+LciMuTFQ8wDXE9XHwuK+R0NqsoTyQTj30S9yz134eAM31ZhgorGKugyAOVdlIHzD4srAMaxdh44jX+Bl5zIlqHNi5MZNOjc7S7KhX82BLcomOtj3mqAQPQ2RT8ANFiZRr9g4masaSD7AYctV2Sk4HDBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764108440; c=relaxed/simple;
	bh=9r+uW1mJx9lGRz5qKREjvvchZLlo+xqnzZBL2YzaWPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bp2vYzuZZX/2ssqdzRDFDi5he6Khqmxd9eQti9DIfB5IBVLYfLII2aAXMkFZG0NYoMyGG4FXgCPDe7kd1yEpQzE+EqZSIf7RqdMvG9jixvjRtd4icXH4z5G5mMfvapD4JuSF4KPYHc20q/4UCigqZDSdRueGS91B+YNlHBhG4Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NSc7gots; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OPgey6pk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APM22K9619363;
	Tue, 25 Nov 2025 22:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BrTfboV35XM7n6Lwl4fPLyODCxhRIzNRR59RDtGMpFU=; b=
	NSc7gotsirFu3r9xQz5Gvjrrn++yQ3V2HXRl0NdGxu/cc/Am4F4vBQLGUsavVmfX
	NMToL9KHjNTOc7zNiBFlTbixoHVPFV1O0CPWMKnx/rCxb/lMGMPSkua52IKPqx/u
	EHKwcJWPaKkaHKTufD3HndfqcfKHDo8lAYIrwBBs1DsUDyji1fP/OaLc2Nn8QHs8
	cGbJe0IfxCT48hAcn9VYZVRzplKWQKb4r8DAQv0OLuQVbJDN5pxox3TbPjwFa2Fu
	Ha2qfX2nG4lP9ipBywhk415cSJfL8KfM4n6lQimmk64xo3s2xjoCJTUFbr5LJM4b
	Akah0ZOmcqsCskSdmM43rw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7xd8mx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 22:04:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5APLoc3w022172;
	Tue, 25 Nov 2025 22:04:38 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mdwccr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 22:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICxetZlYTew820uZXX/LMhqRVaNU6v9iwyjrcciBxOy38upnIALVkOftH4bhVR7Lhn06hcdj58/ds9UDp6PjWtSIbbr7Oe/I8xRHF6RqDIAEmoEyzlWjaw78vgg3xt6ymRYICmbNzDsLtsMQ3madgWVjm7fuYqaFR87k6CU8B50uVxWtUdk/gj0aJTpej1HpLNeD6c2l/SSr8/fvnL5IKje6kl7KXEMUe/EDSLvBZUvA8XCaSiOhNsjuaF1SXj9qUw2lYDEI0ik8B+GeiyLEUQajZhMqpf0cZC5MZ6ofRCii+nFvM7z/Ysx18snsLEK0noaZrY8j3tiAKxAVHPPANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrTfboV35XM7n6Lwl4fPLyODCxhRIzNRR59RDtGMpFU=;
 b=DVd1vAQ4QQYG0dMoDhKenthtlc9y5zW65VGT7/yxFYpOtMpzEbQh7bHnN4Nasg8eLpeeeMSM5UPWxwym3N5/6c+I/FLchiZvbs6RXc+nOm81AmaG7paiXSqkWW6fylSyyfg3ep3x9PKQm3cJ74tLXTh8VfuhUHhVWGHZTcSaXWAnBenm+/vD+HVsMtSWscwsJEVwuX16ljBP49jXdio9lmiPB3BrI4WBcYUJJOy2cswIhrwLHwVBhfoFfLi/rqem+lypqgHq9CT0sh39UtMrrKP9SuS004Wd3PSDGguMN8xngocIF7e/JLwI8sgrJ54x5DKDNtOVCyuHFHSP31Wj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrTfboV35XM7n6Lwl4fPLyODCxhRIzNRR59RDtGMpFU=;
 b=OPgey6pkfmu6e45LX+TEBbztOlTBIwWIjvACi+pSmNkvqKNEJBtwr2mp5CyBOTP+TTCeFCUFnkLlCY/pu1rcxwEpsUHgSPgd+f8Bi47qFswj5KHccrTn6o2B5PguJbICgC85qoga1YcujcHf1H/0SW+IKM8AGUBrDhaV9n9Zlwk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6558.namprd10.prod.outlook.com (2603:10b6:303:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 22:04:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 22:04:34 +0000
Message-ID: <8e1b84f9-e14f-4946-8097-12325516cdfa@oracle.com>
Date: Tue, 25 Nov 2025 23:04:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
        linmiaohe@huawei.com, harry.yoo@oracle.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org,
        jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de,
        rientjes@google.com, duenwen@google.com, jthoughton@google.com,
        jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com,
        sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com,
        dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251116013223.1557158-1-jiaqiyan@google.com>
 <20251116013223.1557158-2-jiaqiyan@google.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20251116013223.1557158-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0210.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 71da81cc-6fcb-4ba9-063b-08de2c6e9de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmtodXB2ZElvY2JYOHROWUlsWU9rQmxuWVloUkQ3b2p3MUxEV1ZkWEJwN3Y2?=
 =?utf-8?B?ZFY5eEtvR0dIQmwvQkptK2pBU3BVN3Q0Zm9RU1JnMEN1VXVFKzdhQ3Q5WjUy?=
 =?utf-8?B?TUdqYVJjVlJXSkNDUDFlVncvdjJieE9aRVFuaTVUdFFJUlhoQ0lHT2ljckc1?=
 =?utf-8?B?cTVQTWZPSG1YOE1lczNoNWkzSGkwS0dCUXoyZHkvOG9zbUVOWVZ0MHkrMEJO?=
 =?utf-8?B?aktDTm9zRDduNGgweEJ0TmRvVHJuUzVBankzc3hQd3ZzU0syUE4vcTNNeCtN?=
 =?utf-8?B?OXAvOEY3TTN0anU0SG1paTQ4TXpibm0zcTB6NnZ1VTlNdHJDNW0rQU9Uck5C?=
 =?utf-8?B?OUV2ZGpTRDZLRldOTTdQRXp1cXhQU2VUWFpaZCtBWW5Ed3hRU3VWcVlwWUJD?=
 =?utf-8?B?a0FxWGVsYlRkSjlUUEJGR3J5ZHUzbVZBdWJoU2E5MkpHSXIxaThyZ3orYTNk?=
 =?utf-8?B?Vkc1d1IxeXF6LzhKdFM3bVdwZktwVUxjeFVSSHJmdVZRWGI0ZnVyd0c3bERT?=
 =?utf-8?B?bnZhVlhUY3RpRVNqeGZwR3F0by9pWStoemhURVhrY1ExL0lFcXhZenh6TzQx?=
 =?utf-8?B?QlV2ZGZPVFRYb0Z1YXIrVTE0NXBsSmJhMFhRZHlBVGVraUkzaXJlNHlpbTNx?=
 =?utf-8?B?cUtrZWxRMkJpR052cmg0R1QvNkNTNHlzTkRsSExWamxIQTVXSzNtRGw3b0s0?=
 =?utf-8?B?dVE4OFBRUC9WRURvQ2srS1A0ZEtvOS9weTYyU3Jaejc2Y1ZINkFWdGFYZWVi?=
 =?utf-8?B?OVlhMGZNVE01MTRyZzhCR0lqWlBJKzVNRDVmN1dIcmlpZDRIY1BRdUhHaDVx?=
 =?utf-8?B?YzVLblU2Q3A1TnE1LytUN3ErNTQ1ZVh0NGViL2VjeGxhRzIwT082MmxacXJ3?=
 =?utf-8?B?OHg2d1drd3dKQkgyZk44dCtua3Zid21ncG9CNGIyaVAvTk5zRzZxVS9OYVIy?=
 =?utf-8?B?STRodmxzanhRYlF1ZUQyaGU1RU5xUWFIUmxZVlFrb1V2bDZFd0JMcU5keXI5?=
 =?utf-8?B?T0ZRbzZLVHNnbFNHNWRRbmxaREtiTEdxcGIzQndMTEYvTytuOGV6NHhqN1l2?=
 =?utf-8?B?dlBVa2ZERHRFWG81bW1SQ3pkK0dObnRqK0wzaEQwWlRvRTZQZUg4R1NHZURx?=
 =?utf-8?B?cjJnLzZOSlorS2dpRHBzSXd1WldnRit5WTZmVFRrOFFnSnV2SVU2ajlFeUZC?=
 =?utf-8?B?amRLOTBXRUQva0RldzNPMGpERGhPcmh6N2w1djJEN3kxeUFWRU9uUS9HZ2ZG?=
 =?utf-8?B?TFVoZHVQVG81WHJNLzBvY2F3LzY5SExJeWhxTDlKM0lxOVBlOFJtYVNwa3hQ?=
 =?utf-8?B?YWd6UUtNUEFWZVAyNHJRZWY1N2hMRm96VjV2TkNZR2lmYXFWRy9lRkRTdit1?=
 =?utf-8?B?eGw4ay9KWUFTUVFWcjhibmEwRTJZdXlabkFjTW13NGx2N3dpSWlndDlDSjd3?=
 =?utf-8?B?cXQySzJHVXlrb01hTFJKQ1N5UG9HNy9DUVd6MUdOTEZNeCthSlAvZFBtTVdx?=
 =?utf-8?B?alVES1JKM2xQemlQVDVzMWhoU1I0ZWRzeGZtcGZ1V0FVaVF4NDA5NFZpVHNy?=
 =?utf-8?B?NjhXeVFmNUJNRWMxQVdvV1RnRlp0U05SZ2VreGhKVWh1VjB2SG1CS0sxanlU?=
 =?utf-8?B?Z1Bsei9ocTRCcGtOZElNT3BpYlJma3B3cjFWNmwxSWhuTHFtUllFdFN2Z3Rw?=
 =?utf-8?B?aEgyUTVYTzZGdFNrTDQ4YWlDTTkrTk9XZVU0bTFTN25KUVR4UjZyd21xMmdD?=
 =?utf-8?B?Unl5YTRlbDcvV1UvQW1TSURpRlk2RWJ5Y0dVclpybmtnSDJkNGoxRThVc1Yr?=
 =?utf-8?B?MlVvQUxwQy9lUTNFcnpkOHJPVXVydVp1RHR5NXRyTkQ0MnpnSnJZZE1kVWdD?=
 =?utf-8?B?UzYrOUdncDFxeVoxSk5BSFErSUFETDNSbnhzZWZ1cWNGejZsQUtpdXAxdkZT?=
 =?utf-8?Q?m0u1z9Q3P5+LYDesJRX8mm1mn/J1E5Q/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1yY0FIR2NjUDhnVUZ0ZXF3Y2twMHZGT3lnZzlOY2NWZ0dTeVJicGU3bVlq?=
 =?utf-8?B?eEJSZ2hNQ0FZcXUwaUJzY2hpRHliNW1zQjYveTFxOGxKVnRSY1phUFNTMmNP?=
 =?utf-8?B?elY4d1AzcnRpNHlTb0ZSZlNMbmpsRVZobkh0Yno5Um55YVFxc2VmaHlVam1p?=
 =?utf-8?B?NVVadXl1TVVyTzRwY3ozMHl3c2NMR28xek85ZkV4U0VBMXhPUHBYZ01rWFBD?=
 =?utf-8?B?ZDZra2RISS9ORCtVWk1qT3cwbXBNT0JRWTJ5Yngzbjh3dGVxeUViMTJ4NnlE?=
 =?utf-8?B?aVdHNHJDVEVtQ1haZjdRODRDVkNWSFV0c2FqZmJGUlZPR2k2WW5FelVhNXJJ?=
 =?utf-8?B?VkZ0dFowbUlDcThUR3BoU2RkU0lIQ0VEalBTTllSV0JudTFiQ3RHazBhcTF4?=
 =?utf-8?B?cnBEaFFFOHpjY01WM1pYdFdNWmxoSTRSaU5PSm9rY05waC9HckNESi9ORUJt?=
 =?utf-8?B?ci8rdExpcXRzVTZzL3JVUUhiSjVuUXJ0dTRncTFNOXl6cGFaazVsOEZLS2l5?=
 =?utf-8?B?QlVlWkJyRWhINFhxdTFLOWRpK29XYUdaRERpWGNnT0FadUgyOFZpTG9TQTgz?=
 =?utf-8?B?N2NPdy9VT3lRNzgxL0ljREh0S2ZxWTVMOFVuR2VyM0dKb1VJZTdCTFRjcmhp?=
 =?utf-8?B?M3VEQTVCZGdhRjQrbXp3T1U1R0R4UE5YU2FGYUtxQkliTm9NdVRYNzVPR2NM?=
 =?utf-8?B?ekZaQzZOeHVjN3RnMjR0eVFrelV2Nkx1ZFpvNGJGSHZJZkY5SGJLK09qdjlR?=
 =?utf-8?B?ekNqdHlqRTJ1OWF5ZXFPaGVUbi96Qmg2S0RMZXEzWnFncTE5RU1QcnJoK1U4?=
 =?utf-8?B?a1BOZmJGQXprd25HbnN5czAxT29oQlE0NUJXbE03cnZzT21xZm5GL3dDN0RR?=
 =?utf-8?B?N1dIVGs5U0xOTGtKeUY0QVNaaThscG16RTlWK2plRjRMZVBWcFc1MUtQMmUy?=
 =?utf-8?B?RlBCT1NyVG9OUXhwN3c0WCtVcVRHQW80ejJsYVc2NzdFMjJhTkZnRVp0Ulpk?=
 =?utf-8?B?VW5ySWIrNjREVlRzeW85cnlrRERiOGpUUGVVMENEK3pBRWt6VnZxUERIb1BK?=
 =?utf-8?B?VURwYmxOTVVMdFNtN3VzUk1LZ0hrN2tNbU9IdWZoYXRqOVhJWVJjamRKdWsr?=
 =?utf-8?B?YkdIR29EMldPN0JCS0M1NXRBVkNGOE1xTVVwVUZVbUlYQWYvMkgyWjB5czVh?=
 =?utf-8?B?NmVjNmdLY0lLbU1NT2djbjBBYTgxanZyWUE3K3grLzFpS3lHWC82bStvcWVM?=
 =?utf-8?B?VVBWNWk4L3dydzNMdW9aRzBVZ1VPVEpSV0JkL2ZoYUdnTkdsWmg4TWdiYmt2?=
 =?utf-8?B?U1VZOHNKcElRWU1idEZzYlNYS0V2MkRzeldGWldWSzN1a0MwSE1QYmVpU0NW?=
 =?utf-8?B?Ym04Q09wMmVaQ2M2M2EzcTFpczdFRDF1M3RmaWFLYW5lbWxjaEErMHBqWTEv?=
 =?utf-8?B?K2RZQ0VGY1lBenYxWTNOWXJ2RmRTTEQ0SHZqZ3dVZ2JqaW9DVGs2NFBkU3hU?=
 =?utf-8?B?allONGdTKzRqNXBUemdPVnlselp4RjdlbDV5MFRlKzFBYXpnTHdJblNreVBI?=
 =?utf-8?B?UW1yVVZ0WHVaZWRaN0xEbUQ5TGdndW5GN1lFVG1OQmQrbFNiNTR3WDNCdzNr?=
 =?utf-8?B?WmRFT2RyTjY3cW9rckpHWHVVVThVZWVSdVlvY3E2bnQ4UjVlOGh0RzEwSm4w?=
 =?utf-8?B?VDdzVi9GcmM3T3FEaStFQUJkQ1Z2NkJOLzhpM3c0am9OYzhYbk1qLzJ4R2Z1?=
 =?utf-8?B?ZFFIeXhlT0NiZmlUbXl0bU5UWmlYSTBZZ0pUOW1MN1lObWp4aGFvWjh3OU8r?=
 =?utf-8?B?dk9LYmVRUnpMSW5EelZaYkI1OHFhQjU3QlBaTDBTNS9ocVpBRlNPaFdVRHlG?=
 =?utf-8?B?elZZeDJOYytzYjNibVhxbU1xSFU5M0VwdmlIQU9ubnovdTNoaVp5bGtISjJu?=
 =?utf-8?B?MFVCWkFrQ1Y0Sk1oUWdna3VHLzI4VFU1QTJheUFFdVIrRmk0WTU0azJabW9J?=
 =?utf-8?B?UGhoMDRyOXVhMGpmUGdFcG1Xa040emlUc0Vhc3lPRlZYL2pFVEcrd0grZllX?=
 =?utf-8?B?MWVnTllpYzZkN1RhaTBVaEllOWZoTEZMN3N5VEh5RElFYjUxaVp5T0RnelJr?=
 =?utf-8?B?aTVvMmZyeWRyRTgxTlNzTHJMWU1yV3FMUWMwYVBRWTRnemZQQ0lkWnJNTjRy?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J8t+kORiwLj2eSua732SlAe6ZnBcKYCS7QafX+T2JTs8D6xrQT0/flgu4wQy5nId3hC+LPxiH7u7FdYqYFclSsvQrEvIX2nsZ1znyTaGtS3bAVz0ZzADj+trEJpPsAOF1noDT7DYomDoV1LlbxfpEO0SUM/P5x7/rP8ME5m1InpCycYV+evGDV3JGI8G4LR3BSLvE9udVKItTI1mwpKCCFFmlTg8dTGgmPhLdDkrp1q27//3MrkY+DfESHgUhx2bbZJbwUuBd2TpYtMPBjP/OC+vYww0aj3SEhoQLxF/bqbgqQlrFgj4rUjm+qQDVuMg2HVV4ts3UDrW5I/MLWjVBJOVDqBRbxwto+/aTQntcWcX7UeSXEkfU8DKPNivMc1m0kNDAspQn/ybjwGLWK27nyJyPHYIFrKtKqdAR8aQ5w24PfmdEzPFtFLHZKXpt0BmhGyrLiKW+qTyxxJf6QtbtSkJ3XNUVK6Tbnl0xKvCGh9eCtSBr8DK6KuCwmU87mZD0Pz+45F/+6vEAex+HcqzcbIFJStTJ2Kn3e6Szxa4HFO2stZ+8DkNsDF0Sq9vKJ6RrCA84zPUKgzQwEg7etmiYQceEw64fhaJNURdGzmItoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71da81cc-6fcb-4ba9-063b-08de2c6e9de6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 22:04:34.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86McptYeVU8mCG1ZpaNPXj0nntst4TC1S1brqYMJxboOPAaVGca77DWVgNk8Tli9muUV3ub8PUJAKW556dTBEOFBt+n+WagJVwdrpS3M5CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE4MyBTYWx0ZWRfXwN5IyP7eNxG5
 6On6yvik8ARPr5UPW7VcDVsjcftWDsNejDuWCLSrA8AJeHYSkRJParD5p5qZoNqK8CJnuTHlUto
 wWiFZPaLRM5tmBhDln4P9YOQVabhKNdLyPhcKw4QP5LxP20w8GRwkg5GkPtyQI33vedBChpUVSb
 EycPI9oi7UM3qEF+sNe5zTKUAQA+SoBvba0y14PNbEuB9mkigPQlJgX6r+tZoo/K/GDlaCMqXAr
 Ad3KTZbDPxX361LHGRGNTnBJOqbHH3/FmQk+Rzdn8XyUpopplt0djhxWGWOUMwuU9uycJ1d8Rgm
 ZSUuZOnFTETkY+U3Rd4Yt/RuZDj56J7YngoV90vO81bKTRZt6brjjdFsjAADYFgqircyYXJnqdR
 eS3qGj2rqpAID0lOWZiN6ofhWfcBvxzPgOSACaSxs43Clt+ITe0=
X-Proofpoint-ORIG-GUID: XsuWVtYII7muk-9VwwDGNNo8QiZpITnR
X-Proofpoint-GUID: XsuWVtYII7muk-9VwwDGNNo8QiZpITnR
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=692627f7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Qvi3HOdRTzR8wQmjmQsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098

Sorry, resending for the non-HTML version.
  --

Hello Jiaqi,

Here is a summary of a few nits in this code:

  - Some functions declarations are problematic according to me
  - The parameter testing to activate the feature looks incorrect
  - The function signature change is probably not necessary
  - Maybe we should wait for an agreement on your other proposal:
[PATCH v1 0/2] Only free healthy pages in high-order HWPoison folio

The last item is not a nit, but as your above proposal may require to 
keep all data of a
hugetlb folio to recycle it correctly (especially the list of poisoned 
sub-pages), and
to avoid the race condition with returning poisoned pages to the 
freelist right before
removing them; you may need to change some aspects of this current code.




On 11/16/25 02:32, Jiaqi Yan wrote:
> [...]
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 8e63e46b8e1f0..b7733ef5ee917 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -871,10 +871,17 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn,
>   
>   #ifdef CONFIG_MEMORY_FAILURE
>   extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
> +extern bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> +						struct address_space *mapping);
>   #else
>   static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
>   {
>   }
> +static inline bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio
> +						       struct address_space *mapping)
> +{
> +	return false;
> +}
>   #endif

You are conditionally declaring this 
hugetlb_should_keep_hwpoison_mapped() function and implementing
it into mm/hugetlb.c, but this file can be compiled in both cases 
(CONFIG_MEMORY_FAILURE enabled or not)
So you either need to have a single consistent declaration with the 
implementation and use something like that:

  bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
                                          struct address_space *mapping)
  {
+#ifdef CONFIG_MEMORY_FAILURE
         if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
                 return false;

@@ -6087,6 +6088,9 @@ bool hugetlb_should_keep_hwpoison_mapped(struct 
folio *folio,
                 return false;

         return mapping_mf_keep_ue_mapped(mapping);
+#else
+       return false;
+#endif
  }

Or keep your double declaration and hide the implementation when 
CONFIG_MEMORY_FAILURE is enabled:

+#ifdef CONFIG_MEMORY_FAILURE
  bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
                                          struct address_space *mapping)
  {
         if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
                 return false;

  @@ -6087,6 +6088,9 @@ bool hugetlb_should_keep_hwpoison_mapped(struct 
folio *folio,
                 return false;

         return mapping_mf_keep_ue_mapped(mapping);
  }
+#endif



>   
>   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 09b581c1d878d..9ad511aacde7c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -213,6 +213,8 @@ enum mapping_flags {
>   	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>   	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>   				   account usage to user cgroups */
> +	/* For MFD_MF_KEEP_UE_MAPPED. */
> +	AS_MF_KEEP_UE_MAPPED = 11,
>   	/* Bits 16-25 are used for FOLIO_ORDER */
>   	AS_FOLIO_ORDER_BITS = 5,
>   	AS_FOLIO_ORDER_MIN = 16,
> @@ -348,6 +350,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>   	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>   }
>   
> +static inline bool mapping_mf_keep_ue_mapped(const struct address_space *mapping)
> +{
> +	return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> +}
> +
> +static inline void mapping_set_mf_keep_ue_mapped(struct address_space *mapping)
> +{
> +	set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>   {
>   	return mapping->gfp_mask;
> @@ -1274,6 +1286,18 @@ void replace_page_cache_folio(struct folio *old, struct folio *new);
>   void delete_from_page_cache_batch(struct address_space *mapping,
>   				  struct folio_batch *fbatch);
>   bool filemap_release_folio(struct folio *folio, gfp_t gfp);
> +#ifdef CONFIG_MEMORY_FAILURE
> +/*
> + * Provided by memory failure to offline HWPoison-ed folio managed by memfd.
> + */
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio);
> +#else
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio)
> +{
> +}
> +#endif
>   loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
>   		int whence);
>   

This filemap_offline_hwpoison_folio() declaration also is problematic in 
the case without
CONFIG_MEMORY_FAILURE, as we implement a public function 
filemap_offline_hwpoison_folio()
in all the files including this "pagemap.h" header.

This coud be solved using "static inline" in this second case.



> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1d109c1acf211..bfdde4cf90500 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -313,7 +313,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
>   #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>   #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>   
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +		       MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED)
>   
>   static int check_sysctl_memfd_noexec(unsigned int *flags)
>   {
> @@ -387,6 +388,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
>   	if (!(flags & MFD_HUGETLB)) {
>   		if (flags & ~MFD_ALL_FLAGS)
>   			return -EINVAL;
> +		if (flags & MFD_MF_KEEP_UE_MAPPED)
> +			return -EINVAL;
>   	} else {
>   		/* Allow huge page size encoding in flags. */
>   		if (flags & ~(MFD_ALL_FLAGS |
> @@ -447,6 +450,16 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>   	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>   	file->f_flags |= O_LARGEFILE;
>   
> +	/*
> +	 * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create; no API
> +	 * to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED is not
> +	 * seal-able.
> +	 *
> +	 * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
> +	 */
> +	if (flags & (MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED))
> +		mapping_set_mf_keep_ue_mapped(file->f_mapping);
> +

The flags value that we need to have in order to set the "keep" value on 
the address space
is MFD_MF_KEEP_UE_MAPPED alone, as we already verified that the value is 
only given combined
to MFD_HUGETLB.
This is a nit identified by Harry Yoo during our internal conversations. 
Thanks Harry !


>   	if (flags & MFD_NOEXEC_SEAL) {
>   		struct inode *inode = file_inode(file);
>   
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3edebb0cda30b..c5e3e28872797 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -373,11 +373,13 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
>    * Schedule a process for later kill.
>    * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>    */
> -static void __add_to_kill(struct task_struct *tsk, const struct page *p,
> +static void __add_to_kill(struct task_struct *tsk, struct page *p,
>   			  struct vm_area_struct *vma, struct list_head *to_kill,
>   			  unsigned long addr)

Is there any reason to remove the "const" on the page structure in the 
signature ?
It looks like you only do that for the new call to page_folio(p), but we 
don't touch the page


>   {
>   	struct to_kill *tk;
> +	struct folio *folio;

You could use a "const" struct folio *folio too.



> +	struct address_space *mapping;
>   
>   	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
>   	if (!tk) {
> @@ -388,8 +390,19 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
>   	tk->addr = addr;
>   	if (is_zone_device_page(p))
>   		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
> -	else
> -		tk->size_shift = folio_shift(page_folio(p));
> +	else {
> +		folio = page_folio(p);

Now with both folio and p being "const", the code should work.



> +		mapping = folio_mapping(folio);
> +		if (mapping && mapping_mf_keep_ue_mapped(mapping))
> +			/*
> +			 * Let userspace know the radius of HWPoison is
> +			 * the size of raw page; accessing other pages
> +			 * inside the folio is still ok.
> +			 */
> +			tk->size_shift = PAGE_SHIFT;
> +		else
> +			tk->size_shift = folio_shift(folio);
> +	}
>   
>   	/*
>   	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
> @@ -414,7 +427,7 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
>   	list_add_tail(&tk->nd, to_kill);
>   }
>   
> -static void add_to_kill_anon_file(struct task_struct *tsk, const struct page *p,
> +static void add_to_kill_anon_file(struct task_struct *tsk, struct page *p,

No need to change the signature here too (otherwise you would have 
missed both functions
add_to_kill_fsdax() and add_to_kill_ksm().


>   		struct vm_area_struct *vma, struct list_head *to_kill,
>   		unsigned long addr)
>   {
> @@ -535,7 +548,7 @@ struct task_struct *task_early_kill(struct task_struct *tsk, int force_early)
>    * Collect processes when the error hit an anonymous page.
>    */
>   static void collect_procs_anon(const struct folio *folio,
> -		const struct page *page, struct list_head *to_kill,
> +		struct page *page, struct list_head *to_kill,

No need to change


>   		int force_early)
>   {
>   	struct task_struct *tsk;
> @@ -573,7 +586,7 @@ static void collect_procs_anon(const struct folio *folio,
>    * Collect processes when the error hit a file mapped page.
>    */
>   static void collect_procs_file(const struct folio *folio,
> -		const struct page *page, struct list_head *to_kill,
> +		struct page *page, struct list_head *to_kill,
>   		int force_early)

No need to change

>   {
>   	struct vm_area_struct *vma;
> @@ -655,7 +668,7 @@ static void collect_procs_fsdax(const struct page *page,
>   /*
>    * Collect the processes who have the corrupted page mapped to kill.
>    */
> -static void collect_procs(const struct folio *folio, const struct page *page,
> +static void collect_procs(const struct folio *folio, struct page *page,
>   		struct list_head *tokill, int force_early)
>   {
>   	if (!folio->mapping)
> @@ -1173,6 +1186,13 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>   		}
>   	}
>   
> +	/*
> +	 * MF still needs to holds a refcount for the deferred actions in
> +	 * filemap_offline_hwpoison_folio.
> +	 */
> +	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +		return res;
> +
>   	if (has_extra_refcount(ps, p, extra_pins))
>   		res = MF_FAILED;
>   
> @@ -1569,6 +1589,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   {
>   	LIST_HEAD(tokill);
>   	bool unmap_success;
> +	bool keep_mapped;
>   	int forcekill;
>   	bool mlocked = folio_test_mlocked(folio);
>   
> @@ -1596,8 +1617,12 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   	 */
>   	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>   
> -	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> -	if (!unmap_success)
> +	keep_mapped = hugetlb_should_keep_hwpoison_mapped(folio, folio->mapping);
> +	if (!keep_mapped)
> +		unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> +
> +	unmap_success = !folio_mapped(folio);
> +	if (!keep_mapped && !unmap_success)
>   		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
>   		       pfn, folio_mapcount(folio));
>   
> @@ -1622,7 +1647,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   		    !unmap_success;
>   	kill_procs(&tokill, forcekill, pfn, flags);
>   
> -	return unmap_success;
> +	return unmap_success || keep_mapped;
>   }
>   
>   static int identify_page_state(unsigned long pfn, struct page *p,
> @@ -1862,6 +1887,13 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>   	unsigned long count = 0;
>   
>   	head = llist_del_all(raw_hwp_list_head(folio));
> +	/*
> +	 * If filemap_offline_hwpoison_folio_hugetlb is handling this folio,
> +	 * it has already taken off the head of the llist.
> +	 */
> +	if (head == NULL)
> +		return 0;
> +

This may not be necessary depending on how we recycle hugetlb pages -- 
see below too.

>   	llist_for_each_entry_safe(p, next, head, node) {
>   		if (move_flag)
>   			SetPageHWPoison(p->page);
> @@ -1878,7 +1910,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	struct llist_head *head;
>   	struct raw_hwp_page *raw_hwp;
>   	struct raw_hwp_page *p;
> -	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> +	struct address_space *mapping = folio->mapping;
> +	bool has_hwpoison = folio_test_set_hwpoison(folio);
>   
>   	/*
>   	 * Once the hwpoison hugepage has lost reliable raw error info,
> @@ -1897,8 +1930,15 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	if (raw_hwp) {
>   		raw_hwp->page = page;
>   		llist_add(&raw_hwp->node, head);
> +		if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +			/*
> +			 * A new raw HWPoison page. Don't return HWPOISON.
> +			 * Error event will be counted in action_result().
> +			 */
> +			return 0;
> +
>   		/* the first error event will be counted in action_result(). */
> -		if (ret)
> +		if (has_hwpoison)
>   			num_poisoned_pages_inc(page_to_pfn(page));
>   	} else {
>   		/*
> @@ -1913,7 +1953,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   		 */
>   		__folio_free_raw_hwp(folio, false);
>   	}
> -	return ret;
> +
> +	return has_hwpoison ? -EHWPOISON : 0;
>   }
>   
>   static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
> @@ -2002,6 +2043,63 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   	return ret;
>   }
>   
> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
> +{
> +	int ret;
> +	struct llist_node *head;
> +	struct raw_hwp_page *curr, *next;
> +	struct page *page;
> +	unsigned long pfn;
> +
> +	/*
> +	 * Since folio is still in the folio_batch, drop the refcount
> +	 * elevated by filemap_get_folios.
> +	 */
> +	folio_put_refs(folio, 1);
> +	head = llist_del_all(raw_hwp_list_head(folio));

According to me we should wait until your other patch set is approved to 
decide if the folio raw_hwp_list
has to be removed from the folio or if is should be left there so that 
the recycling of this huge page
works correctly...

> +
> +	/*
> +	 * Release refcounts held by try_memory_failure_hugetlb, one per
> +	 * HWPoison-ed page in the raw hwp list.
> +	 */
> +	llist_for_each_entry(curr, head, node) {
> +		SetPageHWPoison(curr->page);
> +		folio_put(folio);
> +	}
> +
> +	/* Refcount now should be zero and ready to dissolve folio. */
> +	ret = dissolve_free_hugetlb_folio(folio);
> +	if (ret) {
> +		pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> +		return;
> +	}
> +
> +	llist_for_each_entry_safe(curr, next, head, node) {
> +		page = curr->page;
> +		pfn = page_to_pfn(page);
> +		drain_all_pages(page_zone(page));
> +		if (!take_page_off_buddy(page))
> +			pr_err("%#lx: unable to take off buddy allocator\n", pfn);
> +
> +		page_ref_inc(page);
> +		kfree(curr);
> +		pr_info("%#lx: pending hard offline completed\n", pfn);
> +	}
> +}

Let's revisit this above function when an agreement is reached on the 
recycling hugetlb pages proposal.





> +
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio)
> +{
> +	WARN_ON_ONCE(!mapping);
> +
> +	if (!folio_test_hwpoison(folio))
> +		return;
> +
> +	/* Pending MFR currently only exist for hugetlb. */
> +	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +		filemap_offline_hwpoison_folio_hugetlb(folio);
> +}
> +
>   /*
>    * Taking refcount of hugetlb pages needs extra care about race conditions
>    * with basic operations like hugepage allocation/free/demotion.


HTH

Best regards,
William.

