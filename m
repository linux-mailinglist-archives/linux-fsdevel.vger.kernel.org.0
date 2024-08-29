Return-Path: <linux-fsdevel+bounces-27939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B040D964D59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E21B1F2663E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090C1B81A1;
	Thu, 29 Aug 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXVRklDT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ec0szzo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A31B5824;
	Thu, 29 Aug 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954302; cv=fail; b=AHUMSPx2pAV+MTsKbn472KlbT0PxsZhGAv7hf4c2cB3eVPgpc5JYcb7qBzgmEepRhYghq19DFm6qg6Gluhqw8UzXLVw7Ku64kR+yH+H7RRFV0ALzWapEhSHYj+VCcpSqJxxeFXjwHE07snFlnbXMD4b8pUdcVBPRV3CTXOtTqLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954302; c=relaxed/simple;
	bh=Kg42KKA6f48iWrCUkyF+kmSAQcx22LzENn5pJvHU/MM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSnduhXCJm8kraJssph5iUhtshBfduP050YZI3S1WyvZYjhsonnMqiEVz93b7YXL3utrqWQCKfjIOBY1laAoabAhbmZpAY+i9t+Tfyot/E0AWRBlSvW+mpo3iymg0TtHY4jTz8SrdzENI2o2iqKHCO5LPLlPr3ad++s5zrZNgEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IXVRklDT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ec0szzo7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47THtVW1019960;
	Thu, 29 Aug 2024 17:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=nTdVpcfYKX9A3NR4kZ5e4B8t+NIJ1P6RAYO0Xp3bI10=; b=
	IXVRklDTTDR9egH+Tc/5qjXydF4fGyBrDiO7sCtwM6vd3yci6T0ecl36mdzH/3T7
	jutEooEG/e8trMe3qbEVp3QmqrVE8t8GPVBI5LpDJlfnhwosyvnLX3bZSqq/wZjK
	Ilg9blGW97Dlsuf+U+XhQ8pF3dfo7jH6dJ5Wy36zAlCY4iuwnVAYDlehUtZg97T5
	7VonDBbPh6dWDlCtwQGHw+5nQEjIsXb4YxXXRRod+wNcDyq8RZ6IUEYljLP0fKC3
	vmUiqfgGKGbeJmTxhsW7/tG7M/y30YLkWPqNzU4K3tnNcycH8h2AL4zUDY1lKhBb
	P3O0qnidCWp4WEhvR5G9HQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugvx0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 17:58:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47THkwsS033131;
	Thu, 29 Aug 2024 17:58:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0x2bte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 17:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP1HtrRAKP4j5tpHGl7Kd0TQBffvQldIgCm8FrKHzL3ryLApO/nf++B2v47SLz1tci/3KyI5bGlQthCeoZhK/ZkS81DrY1ZfD/30rQ6YluMQJQxvkechydJZ/7j2vcf8VUG/2e3I7Edl/x+i6NEPqTAyJnlmBN5LWHZjzmON++NiyrohdowTP6WWV0h+t9LnkOD4/B8nIcuRg0H/6TzeMZR6aWHGEmkJmGNPGH4+FxdnSHgLeBSn8Wf0fhL7urOESKQMdjbrSdrVaCDitlNIwPIT58NPo87iOEgQQgw+FX9xMbgOUWvBhbCNmuSFnE/47DbJhKt7sH6nDoUVRQEokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTdVpcfYKX9A3NR4kZ5e4B8t+NIJ1P6RAYO0Xp3bI10=;
 b=j7VfORzyyJqf4Q4sI++gVNSobE+akFL1eZXc8MyFDh6r7KP4GBDKMb3YlDIbAhy4wTcPxojRE9RgR1bq04ZBLI3oI6aeiyemy74n1/YXQiU4P/r4iSsCVbMjLyBWgHi8/sGxwLDYNtAvaUva52ptWTIQZ95bFzbNDZWujBh7zJqnMQ72jIfAHMfBhw/DUUypSFfPM3ZWW3os3BrNsyKEn1WxDZFVSFdtrFNQtucg0/QSM8boa1Gy5mzCmUq3NtTEPTamVvN3mVI2vDt4z86477tpepAewVglk5VA1EaCYSSq27mhf2k1Mxz1EVs2A4Ho9VLBLjccT27wisp+EW+uGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTdVpcfYKX9A3NR4kZ5e4B8t+NIJ1P6RAYO0Xp3bI10=;
 b=ec0szzo7RW7Msypi/dnb+Av1UfbBSkXJld2TByl/iyGdZA+xXkYgARXLfMPcxiXr0rxxm1hBxTzHjuoQJwk+UQY+27OvnzZSLb4k8ihX1LwsjTVGL3gNfK919vGxaHc38/JiDp8N5524+B4WcOXfZHaMMpiqtI1tOhxSnJpUaYc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 17:58:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Thu, 29 Aug 2024
 17:58:06 +0000
Message-ID: <6d735dff-04a4-4386-b9e5-c01643dab92a@oracle.com>
Date: Thu, 29 Aug 2024 18:58:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] xfs: always tail align maxlen allocations
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <20240813163638.3751939-3-john.g.garry@oracle.com>
 <20240823163149.GC865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240823163149.GC865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0034.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::22)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dea28c-fd54-464d-a972-08dcc8542285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZWNVJBS1l4UzV1bS90V2thN1hRWTNpM1poenlGTmtZY3VYcXNiSm9jczBY?=
 =?utf-8?B?cjJodFNucjIvMmFHZTBYKzZpYkF1MVdzN0toM1pBOGptdGNJR0VNS28wUjQ4?=
 =?utf-8?B?bEx6NVpnOEVuWnJacU9Ub1RtN1JYdWtnRXpLVUxMRG9KRkNkdFMycEhBT1Nq?=
 =?utf-8?B?Q1BqL0g5bUNXL2RVdXNaNDJaaGJRc0ZTaHJLMHlrQXFzVEQ4SUlZTFpxa2c2?=
 =?utf-8?B?K2FGRjF0NlVQSUY2S0VVclhpWkpSVjZMTUpibEdiRWxjM005SUx0RXlzQmY5?=
 =?utf-8?B?MkRSUVUwT3ZoNlR1N25QV0Z3c3p3a2tYYTl0N3V2YmEvbEZoejZBOEZDdUJu?=
 =?utf-8?B?RFB6VEJXNjFmMWRpS0VNdDVyYWJKZFh4aS9BYnViZDV1VWY1M29tek9Va2Mv?=
 =?utf-8?B?bmpVNE1kd0VWTzRvMWFhNkh1VEl4dDduWk5rZCt1cEZINVU2d2JveXJPTkh0?=
 =?utf-8?B?TmlnQnR1c2dTa2RwZ1BGZkxXSTVxd3VxSEhNNXpkVnNZY0VmbHA1OW5NcVB6?=
 =?utf-8?B?YVFZdkNPK2ZMM0lUNEV2a0hBVUNiakxvbEpJTlZJQkNEUzZvZ0JCOGhHZC8r?=
 =?utf-8?B?Sk5sRGY5ZTZJdTVXNUlKK3lraVI1bGovK0YzTE56SUVSMis1NnNjY2NITXdS?=
 =?utf-8?B?aGFGQjJlTjhPYnBUUkVFV3ZBYnhINUJFQ3JBaXpsQ3JkZEhzVWhsK0hoS3Zt?=
 =?utf-8?B?cmsvVVN5ZUM3bTBPaEl4KzQ1K1Z4NXZIMGxNYS9LUDJoUTUzenl6ZmZJdFVX?=
 =?utf-8?B?bXR5dmVHOHFEOGM5OFF1NnZHa0JPdjVBZnJBMlNBNXpMTVhybnRKaGdyZlkw?=
 =?utf-8?B?bG5oMWpBZU1qK2lhbnc2WUdvclBpNll5SFB2YkZvMURNeGFlem1lMXFQZjhX?=
 =?utf-8?B?QTZHQ3lUTTR3aGVWMjVPZENkZDRYa1JmUnl0SDdDaUt6MlJRN0h3ZVZ5Z292?=
 =?utf-8?B?UGd3cDFqM0xlSkgvV1BhakgvVVF0TkRpL1MvZk9jZ2praHNydlM5RUVOL3Rh?=
 =?utf-8?B?UUs2YTAwclJkcWczKy9IVDUyZkJLQkt0ZTI0dVpPR2JxNmszNWVueHFvbEF0?=
 =?utf-8?B?L2Y1Y2JKM3JrMmhZRVlkSEp0bFpROEtUZ2l1L2VOcEFtNnB3NjM3ODRZWUlm?=
 =?utf-8?B?dS9aZ1REU3J5cGlvM08rYjF6NjhDc3ZvU2pHczdaSWIxNlM2VVpONUJBak85?=
 =?utf-8?B?cWM4OVhnVG4zOW1ucjVsaHVoWkowcnBRaUJ2SDBUb21TbjJaTW1JUSt0YS9H?=
 =?utf-8?B?cjR5TU4rbFMyZE81WHY4SnR4KzNNQUJSK2F2Yzc2TDNOd01seXZhNWw1aEVz?=
 =?utf-8?B?WVRDRnozSEhCYTVaVXhua0cyako0ZWxPUVdqVUF5UENpV0NqK2tGNUh4RnBD?=
 =?utf-8?B?RG9lWnhySVNKNzJtYjlFeXVBbW9reEM1aDYrTStFaE1mZ2hueE1kOElybFRV?=
 =?utf-8?B?K056NXNJdkVXbmNiYTlybEhkRUlhTDI1MVB4N2tpcnBodlk1YjQvRGZPRWhp?=
 =?utf-8?B?RlZJTDRpS0hMbm1oZDhGV0kyOGw5NEFLanVoNnpsZlN2NUYwWk5PTVZtY3I5?=
 =?utf-8?B?TWZ6dE00Sys2eUxZdUp0WjhkdkdQRnhXRnFDVFYzL3pSOVJuQXdaTTREZjZy?=
 =?utf-8?B?VlQyS3J1dm1PMHRGK2NoL1JRdS9mMGs3MDZSbzMrMzVUMzRiL2hnQmFQL0l1?=
 =?utf-8?B?QlEzUWs1eG1YQjRLUzZoY1k1em8zMHdmZ2l3UWFPWWZiK2NndUJmV3ZTYll4?=
 =?utf-8?B?WWNicEgreTRoU3N3UHArUzFJM1d5Q0RlN3NzVmtJTE9lNmVOVDQxSWY3bjA0?=
 =?utf-8?B?K2VUYnhJQW1kTTRHMHdiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JiU0NPdFJRT2k5ZnAyVFh3ZFovNHA1eVVPMlFVUHlsNzdrQzNtNVk2Q0tS?=
 =?utf-8?B?QWxzS3E2ZUdSbHJDOGxKSis3WVVpb3pZQ1cyNXBKMkpsUm4ydlBrUEhFSDZZ?=
 =?utf-8?B?MjN0QThTOS9UMkFuYzNkSzRLSk5FZUxJTnVlKzlMVEg4NWJtaVVNb3Riencr?=
 =?utf-8?B?WlhzZjlzTytuVkpFQUlCOTJxMFk1eFBGNlNPVGF4NXo4NjVnUTI3NDMyUHA1?=
 =?utf-8?B?MS9XZS9XcWVtbytEb2plZWtJOS9Oc3JVTm9VTWt1MkQ0ZFlIcDBkaG1SN3Az?=
 =?utf-8?B?N01sdFFOMmlnYzZjSzUyand1c21ucUNoU0VCYWwwMnptNUVYZTYzQ1hJMmhy?=
 =?utf-8?B?MmxJZ2tadURyckN4OGVKWi9iNkwxMFRjeFBEeWFNWDF3S0pzU05odFVIVUxD?=
 =?utf-8?B?alhiS0x0em83NVRwNlhFeG9nZVE3VTJiS1doR24rV3NaQzU5K0FJV3BWOGZv?=
 =?utf-8?B?dHdkVXg4SnBlNHNmUFREamhRVlRCVzk3VVVkbm40RjZBRDhtTUM5QTFQblZx?=
 =?utf-8?B?ai9VL0liQUllVXluYnd6N0VmRTc4K2lxdWdnTjcrZCtoZGJuQlV0c1drR1lG?=
 =?utf-8?B?R3JKSkNMRHl3cEU5WVQvbjZTdTZRNWduZWpYaWNVUUFwWnMwMHkrckl1NEY3?=
 =?utf-8?B?NXU4eENJK2p4SmoxN2s2dDJoSHQ5aTlYTGlEMUk3Lyt4RSt2WnVXNnhxWnV3?=
 =?utf-8?B?VWQyVnlaN05GRlhDdklyWUVHalZEdU84VS9uM2hOUElTcmkrejhJaWFycjZZ?=
 =?utf-8?B?dDFWSDJiekI1ZmdVbEQ0L3VtbFRMbkVmY25ENnJJWjVsemtqMDYrTnBGZkFS?=
 =?utf-8?B?QlRpOVVNNE14QjlNbmQxamxUa0JZQ2lpRUdST0NSbVplVm1kNTAycld4RHpi?=
 =?utf-8?B?WVgvZFhvekxTcXpFZ3VmYjViS0RJeFN1TmR6dE1IOWdMOHVMYkU2bEYya3hy?=
 =?utf-8?B?a2drZDVjeUJ6YmhLV2VZWWx5RlIxejJqZzB3cXY3bXp5a0JwdHdhaGpycVRL?=
 =?utf-8?B?SGZ3T201eEhYOWp1QWFJTFBvLzA1M3dUeUhSdnBHckZkMy9SU1Rma2pBaG9X?=
 =?utf-8?B?ZWwrT2xEMWFSZXdYUFdnYXNySTFpMTVWWExkdmVvNXFjRklPZVlEMGJMRnZh?=
 =?utf-8?B?T21HMTBBNTZrdXNvMDBnb1dEaE53enl3MkVTQlhMbHVVVjFGb0kxVytMdExR?=
 =?utf-8?B?MStva3c5Nm0zQ1pzYlB5dUpuMlZBU2hKRFZGZTF4UlB6OUZKVVlvOHlGWDRh?=
 =?utf-8?B?YS9jTkQybGFkWkZORHNkUlQraHZleUg3TEFTanZTNDducjhOMVFORU1XN0VG?=
 =?utf-8?B?dytybHZYOXFjN0w0QmdSblN4N29Oa0kyd3h6Qyt0MHVhaktWT0hwcWZ4ZXNW?=
 =?utf-8?B?bzQvdHlNZUxUMC9ocDhCN0JvRXZ6KzFIUmpJTTE5SitRemwwSmxmQ2dpZW5h?=
 =?utf-8?B?RkYwWmF2QmRmNHBCN3FUZ0tmKzVDVzRsZXlSVytQV1paZE0wRUk4NFh6cENt?=
 =?utf-8?B?VkJZTzFabi9RL3IySDBQdzJPSndnYnNKNVZDdHFjeWwrajZnKzU1WGY3N3k0?=
 =?utf-8?B?cmxJWWFsMDg5dnYrMVhhNXBCb3FKbndDaTdUcXhRVTc4aTZXSlIzKzg3TWVq?=
 =?utf-8?B?UUVDZzVJNEZKQkRXNWhuL3ZIb3VkOFgwSE9PMFYvTWdRMlFKc0RDRGluZUE1?=
 =?utf-8?B?d2dmUm45cUtKQTlzc3hqTlRRbWdwb25KNnE0UTFFUitJQmEvVjZQYndjdE1x?=
 =?utf-8?B?bU5rVndCQTU5SkhuY1c4eUIyQXJDMEluOUtWeFl4d09lemZucS9UcTg1eG5t?=
 =?utf-8?B?b3FQQm4xZ0xhbnVVby9ocGtUbGhsUnRpSXJidHNRZUhyOWpJNnZZaUdPSFZP?=
 =?utf-8?B?R1BIOWV5OGRKODJxaytmVGhoL2E5cFR5T2J4V2dEdHkvenRzRDhxZVVON1BP?=
 =?utf-8?B?cDJxUkZ3czJnYlk4dy9zUzdMcjlINGFQZlpka0R2MW9TcnJpMCtMMGszYUZ1?=
 =?utf-8?B?TkxZRHB5NE5rRUdSNGQ3NHZ5S0lEVzk3N0hvbEVwNjdON3JFcVplbTJFWVpY?=
 =?utf-8?B?Wlk0L2o5UFJ2bSs5eE40K2RXVmZqTWQxZVRVOWZrSkZPci9mbWtYbFBVSisv?=
 =?utf-8?B?clltYUF3VDZ0eVpaVGZZKy9pbU9vM2gvTXZXcTM1QnJyam9uR1loKzZFRmIx?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MYEh9bIIGmIwc1IS3JNxU3QBzxU+E5CKKrASm1WMC94qDP041DlcDCfOqX99R4fPg6DKbPD3SKQwzN8SffFKpBBpH/7AglGYZCkSfMGVY461GE1rsSVYoMtPtzqWqLlpgkn63D1iq83XDQvMdqfeq1Al13blp8h7Pp/fc2qf+6Qbb5tUOb8Uu+w7lUsZVNa+YJWjK1Zy6Z8UIoGHTrLlshNsKVa+pZZYUSrBxxfOVNZAGHRB07NrYhmLLjRUHSp7iXjp41hiMi+IzHXGoOvOJFvabd8sVdNeFEKPHBDJ0Rbq+ieSrSm9sU1fyD+sj2gc/0mClFQ0hX0FL8BalESVdiaZaGQxqqAtMPu4V6d+7icA9NqqXNdi3zFfNi34P9GO5LehzVNb+K0sd7sRsIXjyLa7spychZXsADUflAKrMxOiVKIjg2BUMcM7NioS3bG3ra0EiNuH+aDpTeATwLOIp0+yVSFSFgsx8YAVEe5/M1UtVs/MTqoZCG2VMyruRIvu5i143jJcrJ4RiAJRBynUWCLJ6nlRxtYsGqaYJl0v1Ws7p9n3eqsaip7jlLPhItGAzR0TV6K/0QzPn6efx5dcYzqgrzoOB6/HOnQSnnwwRJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dea28c-fd54-464d-a972-08dcc8542285
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 17:58:06.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0Vd3hgRj/NaBOme5hMQCTGDl9xnGxRkhCO1k9w2YAowvvit3NiR9guCD0DTZgLHesfwjVEEpbpuxmhz6fKgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290128
X-Proofpoint-GUID: H475fcAMi2sBuoynKpthv5MMTjfwRZ92
X-Proofpoint-ORIG-GUID: H475fcAMi2sBuoynKpthv5MMTjfwRZ92

On 23/08/2024 17:31, Darrick J. Wong wrote:

sorry for the slow reply...

> On Tue, Aug 13, 2024 at 04:36:26PM +0000, John Garry wrote:
>> From: Dave Chinner <dchinner@redhat.com>
>>>> When we do a large allocation, the core free space allocation code
>> assumes that args->maxlen is aligned to args->prod/args->mod. hence
>> if we get a maximum sized extent allocated, it does not do tail
>> alignment of the extent.
>>
>> However, this assumes that nothing modifies args->maxlen between the
>> original allocation context setup and trimming the selected free
>> space extent to size. This assumption has recently been found to be
>> invalid - xfs_alloc_space_available() modifies args->maxlen in low
>> space situations - and there may be more situations we haven't yet
>> found like this.
>>
>> Force aligned allocation introduces the requirement that extents are
>> correctly tail aligned, resulting in this occasional latent
>> alignment failure to be reclassified from an unimportant curiousity
>> to a must-fix bug.
>>
>> Removing the assumption about args->maxlen allocations always being
>> tail aligned is trivial, and should not impact anything because
>> args->maxlen for inodes with extent size hints configured are
>> already aligned. Hence all this change does it avoid weird corner
>> cases that would have resulted in unaligned extent sizes by always
>> trimming the extent down to an aligned size.
>>
>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]
> 
> Still provisional -- neither the original patch author nor the submitter
> have answered my question from June:
> 
> IOWs, we always trim rlen, unless there is no alignment (prod==1) or
> rlen is less than mod.  For a forcealign file, it should never be the
> case that minlen < mod because we'll have returned ENOSPC, right?

For forcealign, mod == 0, so naturally that (minlen < mod) would not 
happen. We want to alloc a multiple of align only, which is in prod.

If we consider minlen < prod, then that should not happen either as we 
would have returned ENOSPC. In xfs_bmap_select_minlen() we rounddown 
blen by args->alignment, and if that is less than the ap->minlen (1), 
i.e. if after rounddown we have 0, then we return ENOSPC for forcealign. 
So then minlen would not be less than prod after selecting minlen in 
xfs_bmap_select_minlen().

I hope that I am answering the question asked...

Thanks,
John

> 
> --D
> 
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
>> index d559d992c6ef..bf08b9e9d9ac 100644
>> --- a/fs/xfs/libxfs/xfs_alloc.c
>> +++ b/fs/xfs/libxfs/xfs_alloc.c
>> @@ -433,20 +433,18 @@ xfs_alloc_compute_diff(
>>    * Fix up the length, based on mod and prod.
>>    * len should be k * prod + mod for some k.
>>    * If len is too small it is returned unchanged.
>> - * If len hits maxlen it is left alone.
>>    */
>> -STATIC void
>> +static void
>>   xfs_alloc_fix_len(
>> -	xfs_alloc_arg_t	*args)		/* allocation argument structure */
>> +	struct xfs_alloc_arg	*args)
>>   {
>> -	xfs_extlen_t	k;
>> -	xfs_extlen_t	rlen;
>> +	xfs_extlen_t		k;
>> +	xfs_extlen_t		rlen = args->len;
>>   
>>   	ASSERT(args->mod < args->prod);
>> -	rlen = args->len;
>>   	ASSERT(rlen >= args->minlen);
>>   	ASSERT(rlen <= args->maxlen);
>> -	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
>> +	if (args->prod <= 1 || rlen < args->mod ||
>>   	    (args->mod == 0 && rlen < args->prod))
>>   		return;
>>   	k = rlen % args->prod;
>> -- 
>> 2.31.1
>>
>>


