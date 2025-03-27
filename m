Return-Path: <linux-fsdevel+bounces-45175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF3A74099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 23:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6981E189BD7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA001DE3B3;
	Thu, 27 Mar 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrK9GE76";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R6puv4qv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC41CD1F;
	Thu, 27 Mar 2025 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743113073; cv=fail; b=NKMY9/i1Z4O1DQ2LePKIPZT1rh8V3QhgBMNLMzBika4pYywBMMvSUfhIMPqiXqmMQSDqx0DbX403TvLArqmTNxIT+F5550FRoIVMu87nYFNsnmZvxOVbYSlSRNIimKIFLzS2kfM+jqQc/xAyk1IDcz5jokvOxRdFanEWyRuNEEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743113073; c=relaxed/simple;
	bh=7B8HuPDUjBu+q+N61ktK3WMkbv/UjVjW+Jm7XSTlF8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=soxhn4C9ZWgscLtmH6qbb0WOumdxX5TZLyHokmPkXXBncjWCUJF/aPTDeTux/ysGHpdaMywYTP0Ke/42Hbg3hItdMDyBsEIqlRoUolYyUKZoqb2ha4d7LIR15P0JnchAfTkJukvR6GuOs5mdH29qGKS/W7UfbRl5rtMut4VH58I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrK9GE76; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R6puv4qv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RLMxRc009982;
	Thu, 27 Mar 2025 22:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6cIzIv+qDN2OyplMCayp/4QueqI86fCSWQdrNkt5tNE=; b=
	HrK9GE76efeXYjhjEh5Bqa0l0U1+PAnXUvb7DuienI06nSFAeOZ0s9cALrV84RBH
	dAdO4EkHdyQI4Ds9PwjSl5I8p42a0n2BwDPmAW36YSk7zaUc9v1MXQccDPh3I30w
	amk+XtkFcBq0rRPhEzwprQG38kaBqPgGWtnMFiHHzNIVVEsX+uyBAzWz4eEHQEXv
	yOQT4LZMfZapoB3eVvtiSnIcZq/pjcXnYvMgctH14kzYIvn/gjkdGOxGwBRTJDlJ
	l5vb3hqA6lMox0CcEI3Mnd/rjNodnS5uaRHEccCDkPnWoSTpyqbvAHZRTnfmOMYK
	JMgBTCr4zn9Bg3Hjv4gcOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn875k6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 22:04:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RKFC5r029634;
	Thu, 27 Mar 2025 22:04:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc4d9t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 22:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAy//d8x+kV1sXOgrNt0kx9e3Jzdu+PPCsf4y9WDDmmATpP19vGwvl+Azk5DJxNwdmQilBhMPvi0Fo7BVjqhgHGwzw8U9rivM736YL/aUhc4R7OQkaPEZ/UJnbhZUnBuZZiyyN9fwsoUQKPktabgy+EzDg7pmWSpB1AlEnOkdB8PTeZ4ubyyoNKbbg+sKHg0vBV1/Fagk4nPi9fn011f2AE6n6hQv7XMP5vqdeeo8Q33AVIMvj4ygMQnacaL7f0RJGygqRnh2iEM8bvwDxb4n0lCkbpm9JPyA6m4BfD0gi+zg2mh78esowxMvrDfRGM55VnYcPlUI5eceB9rqM2v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cIzIv+qDN2OyplMCayp/4QueqI86fCSWQdrNkt5tNE=;
 b=CcdZ/lZBqWXQdnlr479IKXXDCnrvtCNlxd+cUcR1y9JKpJ9vur9GpR63gmcgcDF1YlH29Xz9tXJlqBcoqpfOngz/sX0vY038ctt5u1HqLptNbomJIAeFoU3y8T9HWWmqrYqd6dP3n6oDytk286xPzs0goQ1sJBPu1TCmSq2EFMSoMAQzCO8WzQJdtq2nwKPoVM2RtKn1ODaxYfSizhNOFWgJY3W0UGuygmBUSJmRNTnxiWSO/TxGgyxLBBbXRxcuFXgfK5ZyCFH46TeaFfNX/kPY+O/I975mjtIso4xSM+cSLLmoDZpWpx7+e2LatAmbQLROZvW02pB6/8rHUjeYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cIzIv+qDN2OyplMCayp/4QueqI86fCSWQdrNkt5tNE=;
 b=R6puv4qvKp5E8kxn+dvMgftCK4qIvRmsn1OPhIlrweJdHFmPKxj3oNxqRD5UmAn+hzq3sasJU8a0L3CSr5lUpbCG8fXde/UD9j4Z06fVIQkLebgqgqVPCjWIlYag/cPqlp/U01YOQlEXvGgA4K6xGAWy7ZtB3a2n+kkgthMB5Q0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6897.namprd10.prod.outlook.com (2603:10b6:208:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 22:04:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 22:04:16 +0000
Message-ID: <8f1fc565-9bbb-4bbb-ab53-3c47808ef257@oracle.com>
Date: Thu, 27 Mar 2025 22:04:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: Fix conflicting values of iomap flags
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        brauner@kernel.org, djwong@kernel.org, dchinner@redhat.com,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org
References: <20250327170119.61045-1-ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250327170119.61045-1-ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a87517a-1c8b-44be-2932-08dd6d7b513a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEtiMi8xRmYxQy9URG9qQTlKK1JOWk94N2xMY0xPZ2tQSjhsQW8vbzlqS1FO?=
 =?utf-8?B?TUVzdGVKaFRhbW0rZWJTd3pRVmtPV3hPTTBLNWZoUVJqS2dLMFZOWmh4UmU2?=
 =?utf-8?B?OWlRQUM4Mllrd1lHUURRTWZwRVBDcWhIVi91cHJLd1lGQUJQV25GSnFhNFNp?=
 =?utf-8?B?dGYwbzUvR2htTWdsdUUrU0tVT1JlRGxuRVFON3drZmR4eVZkOXc0d1ZFV0xL?=
 =?utf-8?B?RUJFeTh6MUdiWWJHakRhVWZVNUtuYVRoalVtbFF6cGFuV0NKdHJjUmZCOEMz?=
 =?utf-8?B?WjRaT0dpK2ZXUU8xamRReHdBL3NJYW9DSTQwQUlDMnRBRFlkTUtnYVBaQ2Fu?=
 =?utf-8?B?SE0vclgyYU80V0NrT1hpREU1STRTQ0haUDVibHpFTVFObnh4NjRsYUF0eXBi?=
 =?utf-8?B?bWZGSnl1em1BcFE1TVFsMmNXRGRCNUw4cVY3NzNMeDFicXdLVjRMZlpUY0xY?=
 =?utf-8?B?aTRodTZpNnJpY0I2M24xdkwzb1pPU25rM1cvdzhja1BRUFd0WkhaTjIwc0pJ?=
 =?utf-8?B?ZiswYzNYZ3NzMGdZQk1obkUrQXdXZFQxUUwxRXRoZUdla3ovMGsyejAzN0Jo?=
 =?utf-8?B?ODQxSnRJZ3h2eURKY0RkRVNPWlNEK0EzYVZQYjZWWVZ4c2tVSVFPazA0SDNi?=
 =?utf-8?B?MlV3VzZWWWdEK0VZVGllTHZFdlpRa05RQzRpWHd0K25YcXZqaTRxNm80ODlw?=
 =?utf-8?B?OHlGc3NteTh6YmlRY3gwK3FqUmNvcXFkSTRvSGpSaGxqL2w3bERmMmRWeVE0?=
 =?utf-8?B?dTdWMFRZME5qd0FROTZ6SnBjdFJOSGJZU3RGcFEvaTYxK0p6bzAxSy9pZVZi?=
 =?utf-8?B?ZU9VcjdwWnJWZ2s4eWl3Qm5wZ3BVSGNkbFJDdDRFOURoTThtY2FkQXRTdGtN?=
 =?utf-8?B?UTlsZTVxU1hNSkxXWHdIVUIzUExjMEgvWXp6MVljOEVmYm5VWHY2Nk04TERB?=
 =?utf-8?B?NXJVNUY5eFM4QS85azFmZlp5Qm1DRExYZW04TE9Pb09wZytBeTZOMGFGcDRB?=
 =?utf-8?B?QmIzR3FVZ1dyUkxyeU1kVzRnRzNNRVROOHluK0Fod1E2SHZRZ3lQZlcwZnVh?=
 =?utf-8?B?d202bFJuQ2lDWGhjSVRLQ1orcVdWSThiS01GRXFqcTRWQ043WEV2YlBiM2cv?=
 =?utf-8?B?QXA0TUxCWlYxR3pFb21VcVdoUkEzRTdIVUUyVHNDa3JZc2xjZ2pObHJqLy85?=
 =?utf-8?B?STBOdi9qZzU2Y0hLeGFwOEV0elZZSnJaR0RlczF1SW1hQmhuazY4ZDgxdG1a?=
 =?utf-8?B?cXZWY2owMTU3azNLSHp3ZDlJUU1xVldqS3c1RlZ3V21RWWNBV2NrODRGVDlZ?=
 =?utf-8?B?dHNWbnpwN3JBKzVnWEdUWitrekY1YXNuejh3ZmVoc0dSMXJTNE1qMU82YXZh?=
 =?utf-8?B?NjRiblRsK1pveVVwZ21kbHVPTTlRTzdyQWxDVUhhVnV3dlV6SzZMaVRrUlZO?=
 =?utf-8?B?WnpzSWsrK1ViWFA0d3JLYTNNUDRqcU1SYUdETWpoekxQUEE0Sk1nY0lkazZO?=
 =?utf-8?B?VmZTdGp3OWJ5aUhHNElOL1cxYVhPK3hUT3daczJuS1FwR2crb1c2N2RuL0ZN?=
 =?utf-8?B?NkQyYktxSzMvTzFKMW5UaEhwRERhQzlEK3YrTG5NY2hYSGZ0Z0FFaWl0dlBS?=
 =?utf-8?B?Q1VZNmpSQjZTbkphNWNLL1ROd0lPbHFnTEtJeWk5ai9hVnRXTUpqdzRuN0FZ?=
 =?utf-8?B?TUJVdGsyek50SEJkYUV3TVBpaEVOYU9xd1ZYK2F6U0RUNjFlUXFsZFhzWE43?=
 =?utf-8?B?ODFPYllHNEpkS0htMnc5dXcycDBzR0d1bmhiMytDZVU4ZVlHTjNPTzVhRC90?=
 =?utf-8?B?NVlOZHZQa1dKQXBzR3VpTERVd01PbnFyTmtYN0N2dzVabThsblRBQ3JSOFlK?=
 =?utf-8?Q?4LWYDNHQMwaib?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZXc0dxc0hUUHdVTDd1QWxGL1E5ajhpREpISDFJZVpxck1UNVVaYjhqc0Rt?=
 =?utf-8?B?SklETG9GVFo5SjFlaERVdC8rNTFiR3hzMFlibnNQbVRVZW5VUWl2M0Jpb1E2?=
 =?utf-8?B?TC95L3NIQStNRkkxWUhBZHM0MUE5UzlOZDJRMHkrZVI2UnBpUUFINEpLMGp1?=
 =?utf-8?B?QTh2QmdXZHdyOWVINW1jZlRYTHQyTFkrQXBSZWNXSFkwTFZuUWJ6a0dWSzln?=
 =?utf-8?B?eGxvMkN0bytySVVJRGxuOC9xR01mUmNhWFcrVnhsY1AxM280K0VlT0Q5UFRV?=
 =?utf-8?B?SjAzeEhRQSs1bXN1TEl4YzdZR296dDFjZ05WZ3dZbUdNM3dNVkxLNmNKeklN?=
 =?utf-8?B?ZVhMcjZwWkl5bnl5d29BNmlSazdybXNmS1h5em14eTE5WTZaMFpkWCt0bDYv?=
 =?utf-8?B?QXl2NzJRbWlucU5nbCtJSG80RFRLV2ZtWFEycml6aEZSY2laZFdjdUNDWDUz?=
 =?utf-8?B?eDhSVDg2UCt4NEhCcmtEc2F0Y3Njck9NNHY2OWVFK0ZuV21kSXJpdTlPSVRo?=
 =?utf-8?B?bWVwWDMwUnhNUWQ3cS8wVzJOQUVnYlRSUkp6cDUyR2R3Zlh4clE1Tjdlb1Jz?=
 =?utf-8?B?Q1FKMEpBVnFTQ2lyR2JVT2ptWUlvZmJjcW9Na0p1K3N1bUFCcEkvd3JiL1Bu?=
 =?utf-8?B?Y3YxdzBVQ0NvY1p0YkVaWmxBVGRTWU9PclZHVEh5OGpBN2ZaQkQzK1RkZTFG?=
 =?utf-8?B?V0t6Rm5keUxuL3kyRGdYSWZTZCs3MHJlV1NsaFUyamEvK0s4aVZhYXZBQnVk?=
 =?utf-8?B?b1V2TFZ2MTNiaVY0N2l0U0kxbTVTUUVQZElBSDdKV3hEVDVDR0dsQjBiNVpQ?=
 =?utf-8?B?cEtJSGI1emtoY0RSZW1Va0NieDIwYVFyNWt4WVVXRitiaWVwQm1aZC80UlpH?=
 =?utf-8?B?c3FjMnFuKzlBSGluSWtQUFgxemptNlFNY3R3Qk85THFxaFFKaEFMS21HVEts?=
 =?utf-8?B?d0F5a25KTEo0YWhsbXRyd053Wlp3am04TG4rZWIwREdNdnluK1J1WHlva1M4?=
 =?utf-8?B?dERtRytKVXFmaklKeGNmemJFcUdrU3NzMVFQcTFKd3p3RE0wM1Q0dXhXb2pz?=
 =?utf-8?B?SENOSHpCajQwS0hvUHNlc29abVdOZE45UUZZNHJJWlcvV0hFNzVJT2NWRUdS?=
 =?utf-8?B?SCtIOVBpdEVKWDd3ZzNzbTJFQ0RNZzhVek9BdTU2eUNZR1VFRjNXQnJHQXgy?=
 =?utf-8?B?RUVnbWtQMUtUV01YL0taMlE0NDZpcTVYMExPdTZoR0hrYTAzcXhHRm1XRUtS?=
 =?utf-8?B?L2Rhc3pFRFRlRWd4N3llUGc1M0M0NE9xYkRhRkJrQlF5Z2g1SUIzaFVqR1Vr?=
 =?utf-8?B?eUJEV3IwNHNUdmIzKzBGYnk1ZURmU2crKzVSbmlQREQrVUdtVCtSckNCbFZz?=
 =?utf-8?B?ZXV3ZjJHZFcvdWJFMmU4Ylo0bUtyR2lhSzV3YjgrWlREb3p2L09KR3owNVIy?=
 =?utf-8?B?U0hiMzQzOHV3cHpZK2xTZXNSSVhjb3Z2K3VRWGFKSzA1ak5qbm1aazVHWTNa?=
 =?utf-8?B?Y0VPS2wveHA1U0tZbHl0Mk0yRW5NMTlua3R6NEkxUG82MnVqWGt0dGNwYkd1?=
 =?utf-8?B?NkRmcXNkcTBocWN2WVppZ1JmdXpVdCs5Ly9uK2dJb1VhakJKYWd1d1pkSFZs?=
 =?utf-8?B?WHVQOHZyR1BUbDAwTTBQYzZJUnFJN0JyVU0yQk9WTXhReWhpdFhYVUxCaWFK?=
 =?utf-8?B?YXRTUlZzNzM5M1J4UDFJa1J2aFhSbFZGd2xJRkdWdjcvZGh0NHhPdWhWR2hs?=
 =?utf-8?B?cE5RSFVNY3cydHdxazJPSkVEV0dZb3FWR0crUWMzVWdMT3VidkdxTkFJRHZX?=
 =?utf-8?B?YlZCSC9pUXZTUkhTWUorKzVLNGVDK3JyL3lFVWd0bjBSYkpZNnZ4Z0UxVDdM?=
 =?utf-8?B?bUZpUVdJelBtUTJDWmN4QWZyakl0Z3RDWlNzaHFrSUFJYk55RDhvd1JoWHdy?=
 =?utf-8?B?SnhqT29EcHRmUmg1Z3BIOHc4M3pmL0pGY0lqMGlSMENTb2FWVlo4T0FuY3Q3?=
 =?utf-8?B?NlJET21CUEZXR0J6UjArbVUrenpmaXllU3pUYjczMFpodFd2SXM2QVk0ZDVK?=
 =?utf-8?B?SjkwbjI3UGx5SVI5eUdEa2JOVW9oMDZLTTNyWUtOUkFwRTdwRnR5WTI0VFh1?=
 =?utf-8?B?TEdtMTBWYjRUeGRlL0tDS3FIMUtCMUU3Vk90N3VIUGNDOWlsWm03YlZrdXVM?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n9QQ0iOOqQPDJYTLNWkIAG7ukq7Gs1cXqj8mOwHd89gsqgr0DlK9N+GRskrA2bw+NAElV8CyfbSIpDAvHH2nv1VEAFQ8Ljon+bqQGYuquYBpQcSTaofmj1Pn3LCIyoJZ0zPRiMsuvCNaq3JE2soava10lwkIhw0Kcqqoi074ec6YNnugWphxyKbkZLw/zlrBAwgXg6sIRMLRNdEqRi0oVBG2hT2p40Lqup5DTGLJi4QejE4G4KYCEGNdO5mCh+v3Vy/XndiQzAMgTkORu/JFsZWFDaC+D8V+zR/CSJXw0QT9LJ2h2cTSJHV+YdqT4j+f6c6boMrWmtP7sKueYm5WmmMz4F13380GjP3/6eMfVqvUoWjW0ltt73JA3H2/R5BJ4JQsXDL5xTyzS4UX4Zw4ZLdV7tlENqJTUGsddJ8+f2A92L0SY/6Fler+yw3hkPKRMtp34ZOrZNIzJfBYohZjs7+JdVsuv90l8Y9QkQKcgkFn/Z72QntAxd0sfzD4tZxjO3AOJg39cTMU13qtNXiDuyg0Wrd4V/nq+okvzzX0hq3lfSqHe4Q2exlSCwd7CfYs0DW0oE1P5EF9wVgX77dSQnm8qilQA3GOJFeDyQ4lsv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a87517a-1c8b-44be-2932-08dd6d7b513a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 22:04:16.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NQ1cij1SubeCWmBEyX4mGVgdN2N1zq+eIQNs1fcuBa9Irdcjlw8AimdJr5jjKl7lU8JjDuuf4iSYlDL+/z4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270149
X-Proofpoint-GUID: hSbCko5qObuEO-XNdn-BhwxyG4nmx3JW
X-Proofpoint-ORIG-GUID: hSbCko5qObuEO-XNdn-BhwxyG4nmx3JW

On 27/03/2025 17:01, Ritesh Harjani (IBM) wrote:
> IOMAP_F_ATOMIC_BIO mistakenly took the same value as of IOMAP_F_SIZE_CHANGED
> in patch '370a6de7651b ("iomap: rework IOMAP atomic flags")'.
> Let's fix this and let's also create some more space for filesystem reported
> flags to avoid this in future. This patch makes the core iomap flags to start
> from bit 15, moving downwards. Note that "flags" member within struct iomap
> is of type u16.

Just my opinion - and others will prob disagree - but I think that the 
reason this was missed (my fault, though) was because we have separate 
grouping of flags within the same struct member. Maybe having separate 
flags altogether would help avoid this.

> 
> Fixes: 370a6de7651b ("iomap: rework IOMAP atomic flags")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   include/linux/iomap.h | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 02fe001feebbd4..68416b135151d7 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -78,6 +78,11 @@ struct vm_fault;
>   #define IOMAP_F_ANON_WRITE	(1U << 7)
>   #define IOMAP_F_ATOMIC_BIO	(1U << 8)
> 
> +/*
> + * Flag reserved for file system specific usage
> + */
> +#define IOMAP_F_PRIVATE		(1U << 12)
> +
>   /*
>    * Flags set by the core iomap code during operations:
>    *
> @@ -88,14 +93,8 @@ struct vm_fault;
>    * range it covers needs to be remapped by the high level before the operation
>    * can proceed.
>    */
> -#define IOMAP_F_SIZE_CHANGED	(1U << 8)
> -#define IOMAP_F_STALE		(1U << 9)
> -
> -/*
> - * Flags from 0x1000 up are for file system specific usage:
> - */
> -#define IOMAP_F_PRIVATE		(1U << 12)
> -
> +#define IOMAP_F_SIZE_CHANGED	(1U << 14)
> +#define IOMAP_F_STALE		(1U << 15)
> 
>   /*
>    * Magic value for addr:


