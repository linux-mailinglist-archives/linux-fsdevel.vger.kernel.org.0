Return-Path: <linux-fsdevel+bounces-41184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3CA2C1DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1F163D8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A61DEFCC;
	Fri,  7 Feb 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ipoBk3zX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="veVPJyhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67C1624C3;
	Fri,  7 Feb 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928918; cv=fail; b=tR6VzWfyLlxsk3uSEn2hSxUXY+uHZ160NQqxlf44K9MQbV3sgR9FNGf1llL2hWr/W0wH6yHZSS//X6t3q8D1AZuZ0xwpFyGQR4vqbcQePaosAyPNutpWJNHYMxlTBlx1YQFTSmG3P1I7OekxFKQ3OPUIsTCoWKC+2xGVB/k+pyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928918; c=relaxed/simple;
	bh=InTEhUHGM7sFeBBuWI6NKoSRnVmheX8EVt8qS2l0XLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TrUYauKehMKXXxtRHIvdgNYGvVRkEdMZasuJFiH4aZdzSGVcOZH4ZPPVsgLwK6hX/tYjQsJcnMv/FxBiTiJyv7oLbHKn1DztPMqGQhPq8I3o878e9IuO7O69zITlTQaEluCbWXaBjJEDkgJcwl3IipM2OhqnkR7YiChElJiucLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ipoBk3zX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=veVPJyhb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5171toJn031517;
	Fri, 7 Feb 2025 11:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vw7b+QP5p4ffWZghRDDijtIGwETjtAJiKja6j3hmt2I=; b=
	ipoBk3zXQXiVOD4Vff2TsJrilsNIP7C9AzFwn/rG4Gngy++vAhhqI1auGDIG0J8n
	AhV3oSkME2b66KsxUoSVzAt7pCc7wdbvRh96oUe+teOp7ISbkPM0WJ0REfGgGJJn
	k8R/5pVpuLtaAuqGl8v/+16p+0d99juhfIEBDfa61roiJ9+K8HPpJgYjYOu6C3FF
	IlhlY0Rja02iXM6kYT31IvRVMZbhnmBciEXrU0HVtWPu2NyjjAhAGW4dmxwnnumJ
	dToLrLd6ch4oNionuhSqeAtof0Piu1EJx0udI7Fk8SKsFlhfwMxuKLVdEjRgl6kW
	Wn2aolk9Ya5p9Ur39OLL3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44n0nb1hya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 11:48:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517Bfowv020686;
	Fri, 7 Feb 2025 11:48:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ft5f9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 11:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFuHZlycyhhBaazdUA1yXTonxexDuGySUylZxK939RBbjN045RUB6h6QoXRyN78OtJEH/1eZxeGWkphivOtUXt4cZzqr1UX/fgq9QB1rftJHlF0AeamYgfbqmLM/k+enmblKzsEBmdZQuz4pSPBfdNh0hba4o1xs/pThLkqaYTSgPz/fe6y+Rv4a5oqxKBkmAO00XpQ4mIdEsySr+CgYF4JUToeeGsi8tU3EkDdKtzu7Grj3CzmN6Gj20WPKVqz20iMRNAdDS1QzMapHFbbzjTpKQfSiIbS8O6bKVk6n28tTVvlRyQMkuYdPT9fRufI7fE7qCeuymEY6DGX2gz8QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw7b+QP5p4ffWZghRDDijtIGwETjtAJiKja6j3hmt2I=;
 b=AehBCJ8CoNfZsfyPNt+02YDPn3f7I4wLzd5YjZ5NonMkkI3jjqU0MlL+IRQum8xtJWecWqjq6B/oBpLRRfMIf/0f53MiW9bsBxfuGPY4grkp+VUVoJdu97gw8ZcqriH29WE/n03pbYZayiEKq34dnttAcW5mAYB0J7X9JDA4SUeHclpTfsiK8nXVXULgx8vG6j4AzHLrGFnHE4+giDYeixi0Ku7bqFgqGaDwnF2kR/z1BYu2w/BGKXpEVCXXOhd/WOxn4IQexXmN39wVU1VTcibMcVrJOehY+B1GNKamapVKA2zEhVnac6mTOiZNoX4Xn7cWR7q5kINXwhm+l+OCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw7b+QP5p4ffWZghRDDijtIGwETjtAJiKja6j3hmt2I=;
 b=veVPJyhbNAXg6XrEJu8bOsF1rrNcqk5kjutf7z2DmGxgbxB+Wzwunam2YNxntwdFDYpgF7zIQXOnWMYfEI9AV8KycROI4ZDznpld3MZfJmwxyZBz7r5Zlky8zCEz25ucBOyPAuIRWsKVvzh3u6zdC1uHQfZjy10YH7Kf+urEc7c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 11:48:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 11:48:04 +0000
Message-ID: <6959eb95-acd2-45b5-be40-39892219c0d5@oracle.com>
Date: Fri, 7 Feb 2025 11:48:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/10] xfs: iomap CoW-based atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-7-john.g.garry@oracle.com>
 <20250205200517.GZ21808@frogsfrogsfrogs>
 <58f630a4-3e02-451c-bd6e-22427cec5c11@oracle.com>
 <20250206214417.GW21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250206214417.GW21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0168.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7165d2-2fda-41dc-b9f6-08dd476d481b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXhvcmlnZmhpOUxXWE85alZhM2dBS2tMenJCM1g0ejYwTno3Qm5OQ3VTNUww?=
 =?utf-8?B?SUR0eXdDUkxHenhyUWMrQjI4T09vNXprYm1oUi9lV3VDZGtzN3AwSVdwbU9F?=
 =?utf-8?B?UUdLRldtZElhQkNGWERWZnl4cU4xb2xHOU51RTdybldUUXFQSVBvYWxkM0hi?=
 =?utf-8?B?cm9iQXRHcENPaEtaQW9jbWExZVErOVg4cGtpa0NaMjZnWnErRkV4U2NBcm9v?=
 =?utf-8?B?V1NCSThjNXIzT2wreHRCZHpId09kMFdaVGU3OWZVTWp2dStRRmR5a1I2Mkcv?=
 =?utf-8?B?R0dRdFRnRVU3TldGZmI2WFo4cWZ4L3NDSUthbk0zS09OQVo3L0RnS2RKazls?=
 =?utf-8?B?NXRnaFYwZjQ2b01icDRIK0hMb3p4ZWRUTHMxYUIwZnR4RmVJWkd2ZzArY1FP?=
 =?utf-8?B?WVlrTXRMU0FPUkl0enAwS01pbWRHWk1Zc0txK05vWTdZd3ZMdFhieENXUkQ1?=
 =?utf-8?B?VlVzZkc1Y2NBOU5Tc2poR0JBdlhmWEJVQXgvUHdIYTM0R1NBZ0lBSTNMTmJu?=
 =?utf-8?B?Q2dHUU1QUFVjeEtKS0hWRFd6V3d5R2trRlFRdWlTcytObFBnajNhMEdWR1ZI?=
 =?utf-8?B?QzE2YThDWVpmeFRNbnlxZjErb3YvM1RLTlVUY09TVTBqRCtKcGR1MDdOcVNx?=
 =?utf-8?B?ejR1OE1lU1hMaklidnNTYUpIRk9seGdWNVU4SVFDa2VhU1BEQ1FlYzN3Q1A4?=
 =?utf-8?B?QmZLRHRSRDNBbGNyMTJCTnhOSGhFajRGWlNPNmJHb3VPL3pUL21NWGQxR1Jo?=
 =?utf-8?B?em1xbXVUeGNvWS96eGhmbFdYZUFyYmpyWW51SmtVVkdZYk9ZY2xPcHVaVExh?=
 =?utf-8?B?MENJaU12VHRPNmZRZmJ5WE1QVFBvTGl2VGY0TU8vQU9KeUFvaS9nVDh5OXl4?=
 =?utf-8?B?eVl2c0ROcmRObndEbm9yTmY0Mld5U2hrSmEwZ0FGWVg1OU5mTWUybGczUzdK?=
 =?utf-8?B?eVlqZDFpaDVUTVFsbHd5ak12cHNCQjJXMVFlRk13WU9qOFNPMWFpY2NsU2VF?=
 =?utf-8?B?MHAzUXF1YjhqTExmTURJajEwd2QyZFFUK0VKSklDU2RCNnVCREpQTnhDN1Vy?=
 =?utf-8?B?MjFpbzlHTi9WanYzV3AvRU1xSVF4c2VmS00wVzFTYnVEeTBqcTh1MC9WWmpj?=
 =?utf-8?B?S1hVU1dWRGMvSlg5NjI5aE1LMmY5ejN5S3lldHN1RHU1VkU4U3BXV2hwb2VZ?=
 =?utf-8?B?cU83Z3BkbmZ2YXNQMTFwN0ozTitvMkFxZzUwMzA1dEFTeWN2YUZpOGhleVE3?=
 =?utf-8?B?aE8yT2FLaTdjRWcvQlUzK1Y2bzFYRkduanByM0N3OE13dXNBalh1S2tKR0tn?=
 =?utf-8?B?V1RTakc2SFdwR0ZPcnM2QnlOTTFCWngvU3VRdExGeEZhRFdEYXk1SUFuTVJu?=
 =?utf-8?B?NENBcHJkckxEMHM3UlRFZUZnNWNYa3BkNWlnNE4xNzRKQVlGTGF0MmFVN3F2?=
 =?utf-8?B?cHBPRWZCWG1lSDB1N3VFZVE2LzBYcnR3bDFZRHdFM0daOThHUVVVQ0E2SExi?=
 =?utf-8?B?UjNIRUZCaWk3WEVmOGlza3I5Zkxtd1BCS1puZ3hpWGZtTDAzUFNoOHNXeWpx?=
 =?utf-8?B?T2dEMGJrUzNVMERwd3Avc1JtM2tzR1l4blRSTVhCa3ZwR0JuMkdLdTBhUmFK?=
 =?utf-8?B?U2g0MjVXdW5wTHM2Rm9jK3VzVTdrVHFIVG9TRkN4d2owSHZMUEhuaTBZd2Ew?=
 =?utf-8?B?MnBzNE9vc2RkUkdWTDBRMFhMemhOVnN0Y1JNdFBYR1V6cXRxYkErSnBiVkdI?=
 =?utf-8?B?Mlp0NHJkSUF5WEJGdVNPRHBmSXdVVHAwWExaZ040NmlxVVdibHhiM21Ldyt5?=
 =?utf-8?B?aXNwQ1hJQmMrODB2cTlJWnVtUTJvYllTL1pHakRScFBhNVc3RGl6ZmFOcm11?=
 =?utf-8?Q?WPkX6FO5AEwBJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJzR0xFTGlwTHhlbWJLQWVCWXBqL1N4UXdReEFTZy9PNTRaV0pjZXVvb0hG?=
 =?utf-8?B?aUd0QnovOFpXVkhKdndEZmY2YjN6SjRuMmdYNUE5UzJSeHcyUmtJRS9NdkNr?=
 =?utf-8?B?N0lXTnl2VnhLeTk4dmdMSUttUGp2OUwxc2t1elZheEVMNlIzekU5citqakR3?=
 =?utf-8?B?Yml5OW13RzRrM255QXM1VStQM0tKYlBFV3FxaStQaTdmYStVb2s1cWNkdXE4?=
 =?utf-8?B?S29vRnowbFlJelRjUWFGbmdOZGM5aWNnNm4raFowOUQ1LzFNd0pEdElsMkcw?=
 =?utf-8?B?WmtyUC85aGR2dTBidGZwS2k2elhJbnpoSDR6eG9tc0lDbGxmcnRSd0o4OEJL?=
 =?utf-8?B?aDBpcWUrMHpMS3FGQUFPYmFXWEZHRXlJTnVJOG1TRGN2SnhGR3pjRDcyUU4r?=
 =?utf-8?B?MVYxWGFJdjIwQXZJQ2VKWEZRc3NMdzNtUlNwWHNzWVIyZ1liQkc0dWVnRjBF?=
 =?utf-8?B?dTljMnBRRXZlTnJpY3lQYndFbUlobGhUZkVFV1dIR2pYT011T25RbS9md3Vl?=
 =?utf-8?B?a3lvOXpaNHVJa210a25ZMFVwY1FxK3ozbkF5OWdGZ3R0c1lxaElWS21uSFMy?=
 =?utf-8?B?TXJaMHJXYng4RkJiSUFWVm5VN2JQRWNsWndiYWluN3RIVEpTODVEb2FKZEoy?=
 =?utf-8?B?QUxhWE55VWRoUWwwOGxhNUNXQlpHQ29MbUgyRTJESHR4ZmNCY2lNeXRYTGlU?=
 =?utf-8?B?NUNrRDhBc3VsanQvOVRiZjI1Y2dXcnhRQUNrYXBHV0FDRFdmcE1HZ1JBY1Va?=
 =?utf-8?B?amNsK2lqTnFpNXBJc2Z4azkvRjdIN0RDd0QxcEF0SUlENHhGOUo5VjVrTEhU?=
 =?utf-8?B?aUtEb1BSR05EOXVOeGp5dDFGVk1EbFZWTmVKL2svM2Z6dEh5UldzZHVWSjZr?=
 =?utf-8?B?bWdYWTllaVNueEtmUEg3aXNWWUprVVE3bEl2MzFmcTdpNkV4TE9ISXFPTzhC?=
 =?utf-8?B?dE5UR0VxRDlZWlU3UmZOT0Fyd0U0cGtLaFpBRnU2RENXUXI5Q0t2RVNwaGh1?=
 =?utf-8?B?Nlh4N3N2UFhKNSt1SlVuRkxpK1JYSVEzYmVFMUtEQXVSY0NxNGpIMEVRYjVN?=
 =?utf-8?B?ZG93NkVmK25EOTVPNnZ3WWV0S0laSnowR0ZFTmVUcG9JOXZWc2FUVkxvTzY2?=
 =?utf-8?B?dkYvL3cxV3owQmRVNlhNWjQ3VysyOTgrZVNrV2FYNlA5ajNYRzZ4cjB1VkFo?=
 =?utf-8?B?SUFJbGdzVVVmUjgwVWdRcUpuYjdsZkt3U0VZVmkrbmFEWnVaRFR5QndxVENa?=
 =?utf-8?B?cXRCMnBtNHNRbmlOUENqblRzODQwMWFxYnJhUnVJdG5jUmxrblB6YlU4M2J1?=
 =?utf-8?B?V2YvcXhOaGdaQWNXbUQ0bk9DWXgxaDFxbzBIaW1qZU5tMTdjOUUwc29BTWVh?=
 =?utf-8?B?eDdPZi9tWGJMbnBQdTFzUGhaVllrbkVvb3BqcWNUeWtCM2t4WFBoSEhRUmhY?=
 =?utf-8?B?WDYwdG9RbGJtNWVPZ2xmSnYxL2FZc1FVOWQ4YWtlMVlJell1TSszejhUS2tx?=
 =?utf-8?B?WlNWbGdQUjJZTkFUS3lod2pTdVY0OVlUbmQvNEJ3Z3F6V2x2RDlQeVNXc0R4?=
 =?utf-8?B?WkJEK0d4OHJ1QSttbTRQTG1ubUZ5Zm5rK016UjN0VWM2d0VnaFkvWXZkQStu?=
 =?utf-8?B?dm5ybnAwL3ZNSWl2MFRGWElSdmNYY2gwN3QwcTA1enhHZzhlYXFtRlVOQmFm?=
 =?utf-8?B?Y0U0d2ZVa2RrVlgzaUtNaXEyNkRScE5LRDVZUDFveXlSV1pXNjBwVVFTbE55?=
 =?utf-8?B?eHZlRVRSZXlmQno5aW0yTzdabTJNY0pTQnRLd3owekpIV3hLVkRSckt6WnI1?=
 =?utf-8?B?cXZMdzBPTDIzWUZHcGZCYlNyM0VoSTBTT3ZUY1dIcWFPQ0g4RWZQcnVhaGRK?=
 =?utf-8?B?YkpvakJkSVpVejF1c3VTRTBiNVBURmZlQUhaWU1lZldkRWViUUFiUXlxU2R4?=
 =?utf-8?B?QzNHY3hHWVl1aGtWZmJ5ZlVONnJPU0Z4M09CSlNGei9ZR0o3ZDFSa3h1NmxU?=
 =?utf-8?B?b05sbzNXV1NMTEVQdEtCdkdkYVVCMjZhU2pGMDcyREpYUlk5UUJaRUxMMm9X?=
 =?utf-8?B?Y1B5MzNNL0xyUUVNMThseUgyT2h0dUxWZ1ZUcEpNZFI5M1IzeGVzdXNWK3dQ?=
 =?utf-8?Q?fpyhFSv1HkVT/mFqaZYjh+s9v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zen5hkpPhCMJd0/O54xsGnDncASp3ZRKCk4yQzP04dmWXL/b71RUO3j6MN102gV1ie9pEfcFDaotaRa6eoMZfJ7JWKsh0QMZrbHfVzFFR1gzac80/EExef/+nvtFFwi0acnAPBXyElZ33B4wjgr2A4K56SOLK2EpNg6FyJq3/LttDMEaIQ17aKuPX6TfO8uehkiDSiaasq12gEw0BWWkH2vLnu59jsy7e3JQqVUjG+cetHE3CYyYbnlW9m99b6xdxXq/dQoanjYGW+FgTFQm2YyN6I+7tkjpWClIHm6PIdXemDpO6f/nveNFb7v9GPTA8+1N/OFM06o1eqSWSsyuGCa8e6wTZTsVdbfRY+5FCbW1n8gHLaXHUTSz0wKC+Abe1OV51jgWlOIwEKx0cNfDRl2tKTyKA5g0ohbnK7yEOWoMiYMWF7A7u35094JgKbR7NjOt9LpCrUXDCf4LAWoXH/7HuqQ63iRdMOzQMWPf88Fx6ghTRVfIQyKUpi9+hd4YsrH35xaAJ8Szc6TUDvH5A42YKNBtaxQwTiKsOPMrsxGPbtmwlyAhBuWYswVmjH8gvqCYRf8RlygHv7yiRkHzGfujG0OnDUk9dBgAn+h6Q3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7165d2-2fda-41dc-b9f6-08dd476d481b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:48:04.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVOHjL448bZ+mYTASoQo1nvQmq75vYzjaL5yCx9vDLsBQSsCP++81cAzTwh/Scqo/AWwXjfb+lsDFd+BXIlcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=692 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070091
X-Proofpoint-ORIG-GUID: Cq2J4qUlUmUDmfIdc6VHlFWaE-78pK6x
X-Proofpoint-GUID: Cq2J4qUlUmUDmfIdc6VHlFWaE-78pK6x

On 06/02/2025 21:44, Darrick J. Wong wrote:
>>> What is this checking?  That something else already created a mapping in
>>> the COW fork, so we want to bail out to get rid of it?
>> I want to check if some data is shared. In that case, we should unshare.
> Why is it necessary to unshare?  Userspace gave us a buffer of new
> contents, and we're already prepared to write that out of place and
> remap it.

fine, as long as the remap does what we need, then I won't bother with 
this explicit unshare.

> 
>> And I am not sure if that check is sufficient.
>>
>> On the buffered write path, we may have something in a CoW fork - in that
>> case it should be flushed, right?
> Flushed against what?  Concurrent writeback or something?  The directio
> setup should have flushed dirty pagecache, so the only things left in
> the COW fork are speculative preallocations.  (IOWs, I don't understand
> what needs to be flushed or why.)

ah, ok, as long as DIO would have flushed dirty relevant pagecache, then 
we should be good.

Cheers,
John


