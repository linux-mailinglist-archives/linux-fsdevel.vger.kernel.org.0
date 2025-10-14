Return-Path: <linux-fsdevel+bounces-64160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98BBDB570
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A81541D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CB307AF4;
	Tue, 14 Oct 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4PVRnob";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xUF7offZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E7307491;
	Tue, 14 Oct 2025 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475507; cv=fail; b=rJ7DIJszioc9yuWsuVCqIbYKxOHTPxvwUPDZViaOhpm2OXoe38jiLiJqlf5xyvVudL9TJsjIxXhBFID5m5Uod4pqmWUgzuU8CHbXmrTIgsMqq4jfOtrjHGFwqrsK+CUE/yGYgnNclV1bCGXMSna2KT+smv0WulT89Z8O/AqCUEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475507; c=relaxed/simple;
	bh=4iyvOvfIvYHMT80YtU83WKdLGnTvX/ssDbUQnA1ew44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cai624hXKXNR4EgHg2xdz61y4GpX/WUvkgjFYuJE9TMXcx//P1yRHQR7aoQ8lTbQCvYcMfQZ7JVP7NkkkOdQ4Ag3mbdp7qO6i2n/8hf+0T9FCXzTOLl40Ca1JYtdPFVCN7ANpusABv+z7KlGydzsk4RLSEjB1dOubplfMOjJ+Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4PVRnob; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xUF7offZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfI3U003685;
	Tue, 14 Oct 2025 20:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D1xinRh/z2vw7X5yV/Rblh0PKQulENPwLFlPVDcl++s=; b=
	l4PVRnobjQtEfoQhIMCylDdubrwKNixFctyc+tz1d0A1Ll4WCBu/eQzEsu2tp0DZ
	Z10BtgkipLphP603cUrvLuNO+f6tN6c6fQ4QoEkrdBZB9zkWtUQBoaNqavG99/jL
	6JhL55Wji0JXMoSFGk8YzgjL3Fcal936YFm6jw/ns3F619OPi7bVYIWrnxB954c4
	mxM9ZduAsYk9G/RaeIItYNmTVTPQD/F2eUkXhYFALfBUF6LGDCaUTtMdsFHhqFNN
	b2PSOYCDw1O566sOn/W1zr3uqiA8KXKvblYmJOFrwFdGlRrL+xopjIffrjltujhf
	DrsU2BrmlBrpkPKwTuEZvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59da9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 20:57:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EJUECw009814;
	Tue, 14 Oct 2025 20:57:29 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpffu1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 20:57:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKfLGfiSA2h3/1deS7bhuoqYSPqO/erwZk2ja57mcHURuJkJarQfqRl4G3WicfV/yr8bSDYNqn4g6ESp9hDygZ6VtAlCB+pp3VfDqGP3mLbaJO0uznDVnnYpDgyTbKrRaBnUIQbyv2NLKeL2uBdw3uQrRMT4aTdwqjV1x6BMdK0KyskjNiPNh+xVcxbIG8AFDEBLttVjjwGmfL/VqOn3nCRDLc4WVlpWPDdmofHnBrldrM0QQjYFc5bDyh9ZlpUkXywoeiQ0GKL+DFPtKmm4UPM01WfwPozHiRAvpbpwYiz+TSz9pkWfmwsDO9nBXLSl3gZC0cFjrkpHb/KJ5AGp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1xinRh/z2vw7X5yV/Rblh0PKQulENPwLFlPVDcl++s=;
 b=wzjiHjqfYVrdfuTyWbJ4ed+1FmrRG4bPJQ44JRPs7h5M5XmWD2jDYf5h/jtHiR3zX5FtT2wm+toxcjJynjt/RvHgw6wJ2+A6XW44xoNW7MysR4/FDH7Q15J2TnVcGdoZ95s7vS8MZpJ2frhON4nKxNe32Jq8Qt2ywNyapZ+/XA3dZPXRK/LgHFRSFMmF+nCzw9sbeEsSAFMvOTVUkAEnEW/vdZI9l+s734tQEi43qfFJlbank8QIgMIxxUwHGCNee382oU+EebW81omYYs4sOmm5Jh8ccUDUuJ57qh9aC8C89OQoi4HWod/n98ZUv+OKwDFxY4PMk5a3iqhxcZ/+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1xinRh/z2vw7X5yV/Rblh0PKQulENPwLFlPVDcl++s=;
 b=xUF7offZXyGb3w2/xENfIm+in8CtFcQE4RWfryRJtEV6prELsKNZ4VBvMsd+8Fbvp3jLtG77vpWN3sIInMmj2xK5j5DOIXSl/D+zGWzCwSr7Xvue0Vv585krE6P4jn6gl71Kw4m/+fhDVV3e4P5H1FCyc2gi79qDL6qX1QBR3Wc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH4PR10MB8147.namprd10.prod.outlook.com (2603:10b6:610:236::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 20:57:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 20:57:22 +0000
Message-ID: <24367c05-ad1f-4546-b2ed-69e587113a54@oracle.com>
Date: Tue, 14 Oct 2025 22:57:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Jiaqi Yan <jiaqiyan@google.com>, Ackerley Tng <ackerleytng@google.com>
Cc: jgg@nvidia.com, akpm@linux-foundation.org, ankita@nvidia.com,
        dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com,
        jane.chu@oracle.com, jthoughton@google.com, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, harry.yoo@oracle.com
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH4PR10MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: f2246437-1e7e-4610-ea73-08de0b644513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVA1OEdJcjhFbXZZRDlLWVhxdjlmQzIwOVZ3VEh6a3c1NGlDWGdGZ1JWY3Av?=
 =?utf-8?B?UEVScnczcUk4dXRDOHRTd1V1ZTZxZHVPMXBhNzJpYXAzY2QxNlc4RUFUcy9m?=
 =?utf-8?B?YUUwSDB5MXJEQ1BxSmZBVGd4WFFYbG1oZDExbldRa0lNK2trNXREQVpxZCsw?=
 =?utf-8?B?czRwZFNxSlR4MUdxNWRFYWV5dWVxb3ViQ1dTUHBHNWJHVjN5NFVBZjRPZVJI?=
 =?utf-8?B?ZHRITk4rVklwajVwcmNwOUY5ZHRaNlMySkYwNGpsZXBPR3ltMkZtalQ3Vjli?=
 =?utf-8?B?dDRydndUMmtVK05YekdlblVVb1lYc0wwZXo1UjdFbXRia0pNWi9idG5lR01G?=
 =?utf-8?B?SUFBV3lWWk5WTmxYR2F2cG9GbHNIay9GcE15VDlNazc0REVqRXBKMDVVTTVQ?=
 =?utf-8?B?NVBKWHJjdU9kUk5HUU1SeDVFSXJiL3JycjlHd3hUN0MxWGJVVVdhdHJrN3A0?=
 =?utf-8?B?eDFvRTlMTzRGbnQxWVVtcjE4c05VUTZIS3cxdEZpcU5aRkJuWXdCeE44MXZQ?=
 =?utf-8?B?Rm1XWjFDNDNRZDV3VlN6V2l4NnhFU0ZTNUFZSFhkL3lRblpUTFIzWmREUlRI?=
 =?utf-8?B?bmVteFlKd1JtdGZHVnFEU0pBQ3NDWW5IMXZ4S3pFdFFXT3dnenplL0VYZ1Uy?=
 =?utf-8?B?YVB0czM2Y29pTk1QVHh1UzYycWFSMGRlK3k1SXhOc20wSGpwVVY1bTJtRVpP?=
 =?utf-8?B?a25EcnhMNkZlWU9HaGZHaXQxTDR3cExYZjR0NHZpUkkza3NPalE3MXJON1hP?=
 =?utf-8?B?aTBwUG1rVnZiOWtuTTdiZ1g0WkFCbERCTVg2TDQxdXcxZ3JuYWtzNlVPT3hT?=
 =?utf-8?B?UTNxeVFrVUxOMXVaWGRHNUVia0FiVHppWExDU2N2U0lUUzB3Njd0NkRYQ1VB?=
 =?utf-8?B?ekdMZjdnVEtvL0xUZ3ZtY0JZREZ0djV0T3AzcEJjcFBXR2JBOXlTRGpqYjhl?=
 =?utf-8?B?T0VoSE02RjB0TTJ2SUlkazFBeXUvNkdTeVZBMUxhb2ozcEpxZktyMnJmQzhn?=
 =?utf-8?B?K3VDYUZRQ2puVmVmQjFUcVdDVEtVNVEyZU8vYXJkWXdxNWFIdksyeGVBcEN3?=
 =?utf-8?B?NTVDRmdCdEUyQUFmOWlVcDRHQmZQWlI2R3VvSWRqL3JITmdiZGxqT1RTaWJN?=
 =?utf-8?B?Zkt3MkNBdGxZNE5LdHJ1SlRWQitMOGg5YlVoUnA1eGVrdkdGSWNpbXJUTHBU?=
 =?utf-8?B?Mm9FNXJ0L0dUMFQzR2JNRitzNnBEUHJ1bGw3czIvNlpMVTZubW1MNlUxOWlH?=
 =?utf-8?B?dS81d0NkMlprd0lKeHMxaHBEOE93SmVsbGVrc3dUSjAzVUZQNVVnU1R4K3U2?=
 =?utf-8?B?eG1BY0RucUR5TndhMWcxQXFSS1FqV3pWMWVpV0syZGw3V1R1RGtUNStiRzF0?=
 =?utf-8?B?QnRRMVd3OTM1MGtVejErSFJLSi90am9NUlR1TUVYLzQrRkg3R0p4aGxwYUhJ?=
 =?utf-8?B?Yy9pUTU0TGdlemxUM2lSMXdWeEJrT1JnT3VRMTRYbkxJV0FPeDNvSVhYc0Fx?=
 =?utf-8?B?emQwM1UrYnJ5REN5NXk1dHQrMmdmY01PZ09LM1FhT0FMcFg2elI5Z0lYcDVX?=
 =?utf-8?B?S1lXRjlCYW02WGlYTXJCRkdqeDRURFBGdnpmOVBnWWJIdk91RzU4b1ZBOXRw?=
 =?utf-8?B?TDZGMUI4V05SbVl0UERCRVlEV01WOXVNVUg4RERpRjFxMGVQMVJsc04yTTRP?=
 =?utf-8?B?VmpWRTkvSFI1ZHBaeWVFT3ZCMEU4QTMyOXVVT2lVa0hPa2tidHl5VEVYcDRn?=
 =?utf-8?B?VmFBMkwweW8vK3N0OEgvQ1JaZnF5U01ia0JFMXlBaitWYlR4ZlJaMjZCYlo4?=
 =?utf-8?B?UzlGKzdpMm5NekVQR3U1WmJ3UHJhUVlrUkJrNVZ3VzlTUDB0S3l3Q1RLdmZ5?=
 =?utf-8?B?TjVIRXhTNmpScGV0YndCNUZ2dWg5TWc0bXM4eGExc2EvUlhDUG5SZXBQS29N?=
 =?utf-8?B?bTlueVZTYkE1NUZmc0gzWUwxVFNmVXZCQWZhVUJWZ1J5eVdxbWVqVGtTQ0Fl?=
 =?utf-8?B?K0lTV01QeE1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JQbEd3RlR1ZEJCVXFVS0pnOFBnZDUvczRyMTYxYmNvbGhkTXNuUkpad0hE?=
 =?utf-8?B?OENrdWVrVGZEYnhTQktvS1FmV3BiNWVGQmlXTDhXcm1tVUtqOWFFS0FwUXd2?=
 =?utf-8?B?d0o2UERseFdKeDJJZTltbmxQd1Y5b2ZhRXRyQ01sOFpCNTdDQndNK2FrdmUy?=
 =?utf-8?B?Mm0vWEdUYlhadUMvUnl4R1BrT0h5RGs0N2huVzF4ckRWZUlYWUcrOVNaeDZi?=
 =?utf-8?B?RnNiVGJ5ZmF6ZzdEOFNDRVlZYmVEakxZUjhrWmcweFVYOWVhMHA4cGJEMGF6?=
 =?utf-8?B?cWxSdDlQSjlFMVVta3h6MnErcTVHdGdiZW9renNwZU00dUtLcnltVWhsT1Ez?=
 =?utf-8?B?b1ZEZVNGZEFUaEFhWGg1RXBVbHl4Q1VSbDJlY1plUG9abDArbmsvV0JmMVBU?=
 =?utf-8?B?S1p2bDQ5U1JTU1hqQ0NldElpaHJVTzEwaGZRa01HOVAzd2pobXBPTkR1RzNp?=
 =?utf-8?B?azFvU2xEcWlpVkVIRTJmUTg0TDZDZnFEQmFPTnR6cnM5b2ExTU51NzFPNVdo?=
 =?utf-8?B?b1JpdDlLWlNaWUMrNGw5UEZIV1ZzU2VKZnU4MWZGOGFlbHlaQlM5cHNoWkxj?=
 =?utf-8?B?TEoxbk9PMTdYQTF4WTVOWXJMV2VhQVp6eU1Kc1dYZDlZZHVHVkRsZDlBaS85?=
 =?utf-8?B?WVRxUG95c3AxSVIxT04yUUxqeTBaRnR3TXo0ejR5S2tnaTF0ZVlvM05MQzhq?=
 =?utf-8?B?c29nT3lQNkdkU3JUdFdFN0tYcy9RSEU1b29ySXZwa3BtdEVlNHNPb2FRYlZ6?=
 =?utf-8?B?b3k2QnBuVTZpNngrMlJ5aUJVTXVBenZPQmlrajVlQXlGRDA3TGFHaEg4RzFH?=
 =?utf-8?B?OHZiSEZVMlhnOUxPM1FNQzA0OE05aTRRZVNzMFdWOXJHeS9zUnd4bGhkVXR6?=
 =?utf-8?B?KzFMcjVsUDFDamtxZXl6SU1ic2thWFVCVnl6cmwybkh5TG53SGpLMlJTaHFJ?=
 =?utf-8?B?SGdNTnROd2ovQzJQajY5Z2FNSmM5OVZsVEl5K3FmUXhIMjRnQVoySlozREJP?=
 =?utf-8?B?dmI5Sm9FeEtuamlMYk4rSUpLZkpJM3VOMFVDcWpNWWoyVVFHK3VhN2hFclBp?=
 =?utf-8?B?ZWFHanFZZVVlUHZXcVl2T0Z4dXQzTnZqR0w2cUNwczduNnptcS9VMmZqVlZl?=
 =?utf-8?B?Y3o5ekxmSGcwblBrNDJ6bFRhcHZCekZqTmlMdkVKYlc2ZUZ1MVhBR0dEMXJj?=
 =?utf-8?B?dGZZaFU4SHo1R1hJR3JnaGhDTGphSUZRTzlNTHUzU2g1b1I4dEl0NGVFK3Vi?=
 =?utf-8?B?TXVZOGJveExMNThsZDhCL1BjZTMzQ2VZNnZnaGxzeUdvekcrd0NqOTU4WHRj?=
 =?utf-8?B?YVZvZEdKV0JyVUtXcWlOVmlCeDR5REI5OWxvSVlzYWdnU3Y1bVhZTDMxejZn?=
 =?utf-8?B?WVg0dFdheEk1UWtOMytXbnZFczE2TERiQXBOcU9nWVNwdzkwbWpheU1jVjJ3?=
 =?utf-8?B?UmlZV29sZ2N5eXNKUXRaL2p3NzRTUk1tUUFvbklzelVOZ1p5a282eXdmanZs?=
 =?utf-8?B?L0VaTWFTajdiUlNvWFpUK0hBWHN1Z2lVN3pWWkQ4OUhCVkM5alFvWVhybCtF?=
 =?utf-8?B?OW9Tbm9tRUlpQjk3cUttVkNUM0pvcHc4TUI5TDhuQldGdkxiZk01OEJUV2VN?=
 =?utf-8?B?OXcxbVMzVGZXRjJzdWRJS09EUVJUK0M3OFEwVnA5Nk5DSEJ4elBLRnhLNEhN?=
 =?utf-8?B?UlpYUXZ2NkhUQ0xjQTFjV3E3SHdJeUYzNGdXTVc4RWtQekVEYzFtam5PMnlY?=
 =?utf-8?B?bkFtR2Y1ZFdLY1U1RnFETmI3WVFIVklabm1mUXFDVXE5L3ZHOEZMbEVYVTk4?=
 =?utf-8?B?M1pTcnRucURzeTFyY1V1cEdZQ2lLZHZlUXRLN05FSHFzT1ZpVkNaNFo5cjFM?=
 =?utf-8?B?SnhCNHpXUUM5UUlhMUNQdVFiemtQS3dFdzEyeTJ2eGdOcFUvbmdFbTgwL3JI?=
 =?utf-8?B?OFNqbE1ldTNlaDJJY0M0NkJHVmVpMDZFZWs3dlZtRnZzTENYSWd4U3BwRDB3?=
 =?utf-8?B?bm9idlZ5Q1cxWjBZRkRsaEJPYlE4a0N1NGtCQkhMZ090cW9VYmdXbGZ6bHBv?=
 =?utf-8?B?TEd4V1pGSE5zQlg2NHdQdHQ5Szd1RnRMemZ4QnprenJ0bThydzFzeWYrLzRD?=
 =?utf-8?B?cTNtaUo4aUljb09MZ3RWSnNpSUZRWHJyV29sVitSTzhTVGdhQjNueGJwNUVV?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YD6SyDv/v4tb5oacD2CtW/AiRLpVmazGQONQTgB7SgqW0s3tZlubVWNDIViA4K6KHAtLZ1MT/Kl3V8UN18S9dQT4uF/ZyxTRIHeSBCx2LTgWhwmgnulvCAPuGAJp/u2C+OX1/37BEbdIZkH9dWC4SSiE1v6d1pvPJ0pC4GaqxLnKiBoSD1lp6gnvgLe4WwnQgNEz3AjE4YBNNU/tUcfqlC4MpY+cN+pHHpPOIDkZ2gNMJbQO0O+PDDYNfmhj0/vobchQcXJlFEaTPDeoWbIltTULHJL+hm3+v9Crt/B3nT0hKP+hKHXkQvyjjqYhr6EhYpuRaS56EN//3PCq32L1vlMYOLSFvNPAs/ixZpSOeaylgX035rtgRqYKqmqu78rrb/oEJByXsWWDg297PbWMxqUw+s1GTrssAzdo/p7zqyw+bepHjeyHDCtvcx/ubw6PPGNaKoxkRz4uwWaab9Eozr+ZZAW+qgfhPQ9YnBNJ1LcQlgEqixNKraLDlIoyN8GJFxhSiiaKOq3KXhFs1ZqFZSAdSkGwPU1GSWGXaaavglMacHlCVclG6m/szCfLR2MOt62S7BUyEx16iDl9iJfdtq/iij5MKHmmf4510Q2Opn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2246437-1e7e-4610-ea73-08de0b644513
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:57:22.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc62tu21UILpq7CQfOppA4vFifnhGQWx49+LmuDn9WW+jWI6g3Ks2prgNCGUIRbLChv3HkIOBjQdbDNvGCKeqMEAgi+NOxOZii8PIpS6Id4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfXxklrvuVTnzme
 EurUG2AWnLRum5FFugiUIfUCAWfxVd2r45MJzzBPIbGTIOHdbjPWmgxDWrHgo35N0Z+mP0ZJgI3
 j7m3P6KwoSbgdR7HZDopxhoec2MXgpqljwPcFWtrVB4+dJtpMR8dZgIB0LZi7juZRQtNUu4BdPX
 ZDxl0+8XQD2/eMIvdnX4eyfEa5ocwSP61LsHV2kQX02Aeo6noOkklQuP/iaX4Wnze8YdillYIxN
 CGJpfUDChPFzuxWdsOLvuFsbiqzntEEpAGRPdrKJaZPYh0fSWuAMBWTV3e59q6fInVkhY7pnnHU
 /u7nPcyZWW+Jo5NSHiMUObIM2lovaRBm1ZA4pTOr5FwW9gKSiELdHT606yrdaCxqQ5FdVkAAn8B
 S5R/VkbVt2q95PnLUVHHH4JzVbditsvZzhMv3l8F7T1eGM3+E8M=
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68eeb93a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=lZZPSlyylhX4fgwzZdAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: 6knLEfkK3vMkHHiEboy42ns1VQq-AeNW
X-Proofpoint-GUID: 6knLEfkK3vMkHHiEboy42ns1VQq-AeNW

On 10/14/25 00:14, Jiaqi Yan wrote:
 > On Fri, Sep 19, 2025 at 8:58 AM William Roche wrote:
 > [...]
 >>
 >> Using this framework, I realized that the code provided here has a
 >> problem:
 >> When the error impacts a large folio, the release of this folio
 >> doesn't isolate the sub-page(s) actually impacted by the poison.
 >> __rmqueue_pcplist() can return a known poisoned page to
 >> get_page_from_freelist().
 >
 > Just curious, how exactly you can repro this leaking of a known poison
 > page? It may help me debug my patch.
 >

When the memfd segment impacted by a memory error is released, the 
sub-page impacted by a memory error is not removed from the freelist and 
an allocation of memory (large enough to increase the chance to get this 
page) crashes the system with the following stack trace (for example):

[  479.572513] RIP: 0010:clear_page_erms+0xb/0x20
[...]
[  479.587565]  post_alloc_hook+0xbd/0xd0
[  479.588371]  get_page_from_freelist+0x3a6/0x6d0
[  479.589221]  ? srso_alias_return_thunk+0x5/0xfbef5
[  479.590122]  __alloc_frozen_pages_noprof+0x186/0x380
[  479.591012]  alloc_pages_mpol+0x7b/0x180
[  479.591787]  vma_alloc_folio_noprof+0x70/0xf0
[  479.592609]  alloc_anon_folio+0x1a0/0x3a0
[  479.593401]  do_anonymous_page+0x13f/0x4d0
[  479.594174]  ? pte_offset_map_rw_nolock+0x1f/0xa0
[  479.595035]  __handle_mm_fault+0x581/0x6c0
[  479.595799]  handle_mm_fault+0xcf/0x2a0
[  479.596539]  do_user_addr_fault+0x22b/0x6e0
[  479.597349]  exc_page_fault+0x67/0x170
[  479.598095]  asm_exc_page_fault+0x26/0x30

The idea is to run the test program in the VM and instead of using 
madvise to poison the location, I take the physical address of the 
location, and use Qemu 'gpa2hpa' address of the location,
so that I can inject the error on the hypervisor with the 
hwpoison-inject module (for example).
Let the test program finish and run a memory allocator (trying to take 
as much memory as possible)
You should end up on a panic of the VM.

 >>
 >> This revealed some mm limitations, as I would have expected that the
 >> check_new_pages() mechanism used by the __rmqueue functions would
 >> filter these pages out, but I noticed that this has been disabled by
 >> default in 2023 with:
 >> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
 >> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
 >
 > Thanks for the reference. I did turned on CONFIG_DEBUG_VM=y during dev
 > and testing but didn't notice any WARNING on "bad page"; It is very
 > likely I was just lucky.
 >
 >>
 >>
 >> This problem seems to be avoided if we call take_page_off_buddy(page)
 >> in the filemap_offline_hwpoison_folio_hugetlb() function without
 >> testing if PageBuddy(page) is true first.
 >
 > Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
 > shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
 > not. take_page_off_buddy will check PageBuddy or not, on the page_head
 > of different page orders. So maybe somehow a known poisoned page is
 > not taken off from buddy allocator due to this?
 >
 > Let me try to fix it in v2, by the end of the week. If you could test
 > with your way of repro as well, that will be very helpful!


Of course, I'll run the test on your v2 version and let you know how it 
goes.


 >> But according to me it leaves a (small) race condition where a new
 >> page allocation could get a poisoned sub-page between the dissolve
 >> phase and the attempt to remove it from the buddy allocator.

I still think that the way we recycle the impacted large page still has 
a (much smaller) race condition where a memory allocation can get the 
poisoned page, as we don't have the checks to filter the poisoned page 
from the freelist.
I'm not sure we have a way to recycle the page without having a moment 
when the poison page is in the freelist.
(I'd be happy to be proven wrong ;) )


 >> If performance requires using Hugetlb pages, than maybe we could
 >> accept to loose a huge page after a memory impacted
 >> MFD_MF_KEEP_UE_MAPPED memfd segment is released ? If it can easily
 >> avoid some other corruption.

What I meant is: if we don't have a reliable way to recycle an impacted 
large page, we could start with a version of the code where we don't 
recycle it, just to avoid the risk...


 >
 > There is also another possible path if VMM can change to back VM
 > memory with *1G guest_memfd*, which wraps 1G hugetlbfs. In Ackerley's
 > work [1], guest_memfd can split the 1G page for conversions. If we
 > re-use the splitting for memory failure recovery, we can probably
 > achieve something generally similar to THP's memory failure recovery:
 > split 1G to 2M and 4k chunks, then unmap only 4k of poisoned page. We
 > still lose the 1G TLB size so VM may be subject to some performance
 > sacrifice.
 >
 > [1] 
https://lore.kernel.org/linux-mm/2ae41e0d80339da2b57011622ac2288fed65cd01.1747264138.git.ackerleytng@google.com


Thanks for the pointer.
I personally think that splitting the large page into base pages, is 
just fine.
The main possibility I see in this project is to significantly increase 
the probability to survive a memory error on large pages backed VMs.

HTH.

Thanks a lot,
William.

