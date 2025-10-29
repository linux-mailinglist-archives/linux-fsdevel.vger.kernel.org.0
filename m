Return-Path: <linux-fsdevel+bounces-66308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677CAC1B32B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701381C24DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F92D59FA;
	Wed, 29 Oct 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mw9SoRcP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cGpX4JTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA6278E63;
	Wed, 29 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746670; cv=fail; b=YodWRHuzlk/qedQLlE9FnLJSf0sYAeX3pgbgKFenrUpBke4+FKPiF3CjI5WD7QoRBEvJyZ/B5BvU00z8rHZWLyN3JS/KaiCqtzO3QKrJcAJ4tpkfURH82m8IJWSG61/HiOfU4Iq6k7vSXXY43wSXK/H1o6EbGg6ejxH/qNpqXu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746670; c=relaxed/simple;
	bh=46xBfO/Rb92wGZqzU02m7n0ah1slHukDe+ONEyizBXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPwK/XUEhE2q2Ea3GU+bvXV17UNCsZj/TC5fqyaypvuTIAVy6VP+N0iIENQOVActq+ux50srwdgaXFexJKNrrDWzSOlLyR70k0OLMEj2JT/Efcch8325tqJ8stTSoJbRGbkQmZfrqcR6c1h11B/UaF+EYkY1tGFdliV8XOn/cKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mw9SoRcP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cGpX4JTD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TE3Xxw011075;
	Wed, 29 Oct 2025 14:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gpmrDiumOSV1VaZydRpZWt6B8vCFBdIUik1m8+r5mOA=; b=
	Mw9SoRcPyvfKYwCWN/Z9W0RDmtbzLZNW4qoK/MR80vyBHXwZa0E6lX7W1cir/83u
	49VCJ2bdgSJtYe0tFBvj1C3aJNKaKhxyMnQBt22nFYF1QoBJzb439K34HyLvb7vn
	ZaJpcNPIVjpeJN6pAtvqwIqabYocbtLrpdqRPA7Gx9nz2SDV7gM6tagPavUZAmjV
	kz5kZdXmLFPyS568dc9zR0Fes2fvlb2Kj9xrXYVKY95Gb/iLgxZFvRfuST59xuhY
	3UuYV0aEgmhQ5sANDLR4aPgs21GWrrBOnOIZUjd/XRsVKw1VvQikHdi65QNDE3dT
	PLDGSXFwVcQ32JqGXZ06ww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vvhv3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 14:03:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TD7Kko007601;
	Wed, 29 Oct 2025 14:03:36 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wk8sm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 14:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8XHMWCv+qGghEisMJtMC/2C+CFRKIA/QV/yrOn8FOja29eiD84k4Xu5ObsDMP2XY0txCbW/AtXGCT1PIsbl6VI4UqoVEeOgNXB3jwByHYXKRb4gnNtEApv+dOZfspiYOPfS/n12XhD6fXxE1DzFCGUvQ0XOflOwCRUXP7OZPdR8YXLcbAYabCY4yyWBaSyJ/yDD1wrTnjJSbVJFVxYKEnYcQBglHwxTluz/r3hhH3aNlXYM1FEsjZrORHQ4LgfAzhqEVFgtLeLpE5xI0DB9Mpa3IjB8fVOQTMXc+VNG9a8zY8s3aUjJlsEYVKXnQfILPDF7RM0K8e4AciCLasf59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpmrDiumOSV1VaZydRpZWt6B8vCFBdIUik1m8+r5mOA=;
 b=tw95CjFqo5t1ZnRzJdl+ZQpuEnIpOffcmsc6Ip285gL9ElSY1yrpMZe2HPPNO410gD+m+y460E2GpCtBhN/pyl7xw+INX+eoOFaBspfi5BboKisVsOoPlt1jDYkt21ALlwEMyBSjOY12rywkmtzyoVP4NfLMayb3IL5bNdOXDTCxoacT0gngay/XYjZhMZfxqoUTaWUf35tMYT7lnsx3TsLX0f/CWBwkzFQreVtHmsu7kb9sSqAJUeHD4Kw0Ivz8wO0ALzOrSikkeaD6GfofEgaStc2BbPe6chEbwbRDB745Mwb/XHZ+pCt/Xwpz+Y3M0EHAmwSqwouTwHaD/Wwurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpmrDiumOSV1VaZydRpZWt6B8vCFBdIUik1m8+r5mOA=;
 b=cGpX4JTDSoJ3FMrSqq1065J0UcIdj2LSVqj85x+35zUNmo6FyTBZ+V+cy/VE3aQprK09fdeVEi1u6RMPJYeVWsg72qi8z1oKhmEBYv6591uc815kCsg8XIdprSsFcaSX4iUePtGMnQhT3Q0hv4Xtda5Zhr/0L8LwuRa13HWcD/M=
Received: from DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) by
 PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 14:03:33 +0000
Received: from DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036]) by DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 14:03:32 +0000
Message-ID: <3ec6f671-c490-42f2-b38b-f1fa20c60da2@oracle.com>
Date: Wed, 29 Oct 2025 09:02:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2 07/50] convert
 simple_{link,unlink,rmdir,rename,fill_super}() to new primitives
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
        raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
        a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-8-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Mark Tinguely <mark.tinguely@oracle.com>
In-Reply-To: <20251028004614.393374-8-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:208:a8::30) To DM4PR10MB7476.namprd10.prod.outlook.com
 (2603:10b6:8:17d::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7476:EE_|PH8PR10MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 592e265b-c9cc-4af6-894a-08de16f3f1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVFORXErWFVKUTZjelV4d2gxTE9GV2toeGxkQlBwaTlhSVU4MEFtanIzZTBN?=
 =?utf-8?B?N1BxRjlDcDk3UUR3TzVZSjdibUVmZlpSUHZVMW11ZGRnSS9qUEZOd2krdzZ0?=
 =?utf-8?B?TWxhYW9MN3RpMHZPa2ZVbDlkN2lXdWRTV2YwOVppZnZxbDdkem4xMjBWQ1Mv?=
 =?utf-8?B?NHV5L2lpNWhyTWp0TmJvNm5aTktUdFBmbjU2RU1ZYXpVdm5YZmYrNkJtM3JD?=
 =?utf-8?B?Yk4ydmp2Wk5ZdnZlUGJOVkJRcnJtVDNCRjdkZGpZNXQwV1ovbmRsbk9tZ0RP?=
 =?utf-8?B?YjhidjN3YStmRHpTS2YrVEk0R0F4eGw4QUxXdUZ0Vi9BSU9Qc0Q0aE1Va041?=
 =?utf-8?B?UWo5UmVrRExwdlJiemI0cEdzcXd5bVhvRUxZK1VlVDRKQjZKTU1zNnZjblJ2?=
 =?utf-8?B?citPVityRXhlKzJva05zRkZRK1Avb2VCSFlsYVpzK0t3K0NSNTFyaEFDMXVK?=
 =?utf-8?B?d1UyMHQ2M0tQblo0YkxOa1VmcjcwV3VkRmgrd3g1OWNMMFpOZ0ErYXp5QWdl?=
 =?utf-8?B?bzh1ajI0R2ZHR3pxemJ0NmY4bVp4aXhYVy9wRm12RGIwNXFBM3RvZDI5bmRE?=
 =?utf-8?B?MTAzQ2ppUE9Jcnc1ejhNWjFNWjkrK0s0M1M5a3NxZEJ2YzAxNnBuVzRIVXZT?=
 =?utf-8?B?bGhVSVFWS2M2cm1Gd0dBM2tRcDJDMDFJZUVzQU51UDk3Rzh1cnRPRVpIWC82?=
 =?utf-8?B?cUJEeTZvbnRwY3FVZ1pYMS94bHNSNE5TUHlkU0dNdmN5ejBpd01HOGk3aVJC?=
 =?utf-8?B?RHpMSktDRENJdVRlcFFwVWZqYVJsVlZ5UG1YMzViSlZnK0FxbU1Ndkw2WWdU?=
 =?utf-8?B?UXpxaGdRck9ObFBncHp5VmU2Vm9zRFJRVXFyaTI0N1ZXRndXUTI4czdmQnlW?=
 =?utf-8?B?MC8rK3B2R1dxV2dVSGc5dGIyZGlvSVMwSFMxSm94MW43RUJMaDRYT2dmVGxo?=
 =?utf-8?B?MG4zcUoraTEzc1UzSDVWUU9sT1pXTEtST2hNT2VXTG9oK2N2NXZ5RElVV0RI?=
 =?utf-8?B?dzNSWC9rTkJLWWNiTVR3NzNNcm1NOXVOWnFDTTlUK0twVHZWQmJpZy83VC9Q?=
 =?utf-8?B?RGVzL1VnQUJldmREKzBjalBDcmRHY1RIdHJkRHV5YWErRVdTcHJOSkhuQy9O?=
 =?utf-8?B?eWhqdzB6SEpZYjVHaDcxaGdsWm1vZjJXNHRnU0hyUTFQdmoxZE1MQ3hNU1RI?=
 =?utf-8?B?cTdxVTBBTlhuTGFGSHd6dWlCSXdyQ0taNUJNM2wzNjBpUEJCa3JheVN0UjhF?=
 =?utf-8?B?cXpsU3d4bzlFQVljdDNoOHVlVEF1UFJjM2cwV1JXNm1DUGJjSGtVWEQ1WGVo?=
 =?utf-8?B?ODYzM29vUHNxNWFOQm9jS3JRRGtNdUl2VDBDRGNkN0cxRWt3M1dlK0pFOHVp?=
 =?utf-8?B?TGlDMDNlSXJ2ek1PY3JXVTJxYWFnY21IVE0xOHFjSU53eEErYjM5ZlZ6clhJ?=
 =?utf-8?B?YWM0R2ZYMkU4YStjUWRHOFlwOGRGbndRd1o0b1Q3MjVCOEdDcWxrcjVCaWhI?=
 =?utf-8?B?dFA1VWxRdkRES1FmTzcvdTZxOC9yWjFmOFV4dmV0QzU2T3UzTEhYOU1HN0Jh?=
 =?utf-8?B?QXZPUDYvL2g0TEh3MTFqRzJ0VFRLT3hkODQ4TWUydHkrVDRqdEdBU0hwaHVV?=
 =?utf-8?B?clk3WnlJWEU1bThpVzdhcS8vbzBWV3RrODNRMGJWQWVXeG1DaGtZYTc4dXVG?=
 =?utf-8?B?eWlOOXNIL3NvZ0ZwYnFxbzVoQ3IwZ0VxSUhRSWMreEZjc0JsVlRYN0R5allS?=
 =?utf-8?B?RklHSmJVNEl6WHlIeUh0VWF5NEl6TE1icFBHalF2UitWY2hBeWZKVmRqWUY2?=
 =?utf-8?B?bXNId0JmRVdhL2Vnd1V1R0dORWFrQTVTVmF4QyswVGYxbFBhcVJ6bTdCOWlj?=
 =?utf-8?B?N2duQS9RUHhRa3RhOE42MUdzMlVwRWdwRlBxTndJdS90UG9jQkVTQ0g5SktE?=
 =?utf-8?Q?2V5lY9iA/FVtMWQTZPCZdeItRLQH1kOk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7476.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW1KR3JQTS9TUEhuejZXNi9udkdwcThSczBmVHA2WUpFOEFRWldLSFliZ280?=
 =?utf-8?B?bEswSS9JbjZ4bjlQc0tha3RodGNKUk1NRDhNQUxPallFVHU2WklSTjRJZDh0?=
 =?utf-8?B?ZlBNNGNRc0poK09QYytlK0FRdTJWVEwwVzJwVU5XWnpkc09wYlpqSFoxZW1L?=
 =?utf-8?B?ZDg5SVJjRHdIcnVWODNGS29OL2I2YTYxankxaCtKUHFmSklOakxFeGprQ0NM?=
 =?utf-8?B?Y2NTNS82a2xoRGRubDlDVGJTejNuaTdraHFrWVIwbGlyNFI5Wk9EcURoTWhZ?=
 =?utf-8?B?aWRCc3d3NXhQbEljelAyanNnOUJXZHJNWUYrN09iTTQvbUZsTlQxRWpMVmg1?=
 =?utf-8?B?R2FCaHh2SkZRSEhOWTU5b210S0twcFFXeEQ3V0ZTWmpudjZuRXBpSGs4UWhw?=
 =?utf-8?B?U0lsSHVraGU0bFoyeEJKT2U5ajAxdE9pU0dpckZuWFpaNjRCN2grRm5wUW9l?=
 =?utf-8?B?cmdITm5OcWhhbmtiUEhKaTNjWWU5clI1SWJhdFRCT0w2aHZvU2JPUEhvd2dP?=
 =?utf-8?B?bUgzK1RXdkJkUlJSWmk0aWZUbzZjQnpqL2F0VFR2aGtwK3B3cHJnWWRlQlJT?=
 =?utf-8?B?M2hDOW9pTHBPbis0ZEgrUER6T2FKY0VRZC9WN0l1c2ErYVRDOUdkaU01ZGd1?=
 =?utf-8?B?RzNIbDhOaXlVb25ROENoWVN2bUlWTnUvMUlnVGh6RGFZMjdEcDZNNlVUT3Ur?=
 =?utf-8?B?UFpBcTNGQW44SFFVMU82dndxVnliWnhseUVpR3FLNUgwUW1IYkdOd3F5Vzg0?=
 =?utf-8?B?MkFIUy9DZys4YjNQMzAybkh4aXlaZVA5SDIyK1hCMUNieGlsZlFMemZWTG1F?=
 =?utf-8?B?ekU1cXBsWmxQUWVtV2NrVU1RR0c5RVIvQ1VBcEcxZWhteFo3MjFvVmlKdE11?=
 =?utf-8?B?cFVhYWVCSk5JRmQxLzZxU0hyQ3Vkazd5M0hYVmZYRVVLMEhDSTBVbllFaU5w?=
 =?utf-8?B?aG42NEtKaDVTeDRnQ0U0ZUJTWG9CWUR4b25VWVk3YTFvL3NrTS96SjEyRGJv?=
 =?utf-8?B?VUpMeFBhTEtuWlFORW5zZ2JPbGZWUGsyMU0zL1grSytBcHhsMWVvWGQ4RTVj?=
 =?utf-8?B?TW9FSmlQMEZRRzV2NWlaKy9nSDlXQkROV2JiUUlCZXdRejBNeXgwL0VWeXZJ?=
 =?utf-8?B?YmFud2dWOTBjNVRSSkpLR09YaXdCS29kbG1YS09oR3pWbUNVbEZCT1NUYnhp?=
 =?utf-8?B?YmgrNS9DdmpncHV4NzVRT2NPR2QrV2RQeXZsdGlyNFoxWjA4aDR2eHU1Q29N?=
 =?utf-8?B?VHRNaG9JNEo5MkZ3TkNXbHI3amJpU0NnWVRDS2g2dVVEVjVkWEFMMmRnUWpv?=
 =?utf-8?B?VndqcGwxUHNDR0xMTGtxMXF3V3ZKOTV3elBYYW9aZGdIbkFFUGJXOG5wNy9a?=
 =?utf-8?B?SFZIUE94NUt3QVZyUzROV2dsc2wxcGtxdWVNaXBrU0pkWFpjaSswc0RubFY5?=
 =?utf-8?B?eDJSbENEMFRDeEJ4UytSOGNPWUQzbU5IOGYva2I3UUo4M3RVVmdkRTZLNmtJ?=
 =?utf-8?B?dS9SZDY1M09BaVRLUE0rYnB1Um1jR0srTHBiSWdyRlNMdlF3L2dlNXIrQzhX?=
 =?utf-8?B?eHJudk9NcGtxaEFmaDRxRGxvb2xjR3NiREFYcVJ3bEZJWkpFY2MxekhHOVMz?=
 =?utf-8?B?MERQU25CSXBGOVlrRUh3bnhrNkhGcFc5SzJkQmt4d3JIMk45YlhBR3BteEFD?=
 =?utf-8?B?RHdsTHNrK2V6ajlpSE5sZDh5c2YvdTlscjFGaGVqRkF2TDU4ZkJUNmliZ2RT?=
 =?utf-8?B?SDdxaVJOanFpK3pUNFNKcDMyRW1iSDVCOWY4Vi9pMTcvY2EwNVlFeitrZ0N2?=
 =?utf-8?B?TXhZNm54d2RnNXhsT0FNcDU4b1g0ZWE0endES3ZsWW4zYjhKV3lackhmMEZ0?=
 =?utf-8?B?OVNxa2M2YWoyNllVLzhmNjhtb0ZqTGdHOVVyQjN2TWhzZG9VZHhZbndzeWpG?=
 =?utf-8?B?MllJWWZJWS91bG5XeVZDTzBiSUJhaW13V3NzZVdKVm5iSU9ON2RMWWJjUm5H?=
 =?utf-8?B?aXpFZVBqbi9QKzk4cVY2V0hWb2plWE4wSXRmYjVzNTE1RHM3YVJ5aE1UM0Zo?=
 =?utf-8?B?Y3JMRjh1MW02eEo4L05JVGRUSzB5Q0VrMXVmNm5VclVRdkdlcXVCRTFRSE5X?=
 =?utf-8?B?NndwaUpaTXFTQ080RURSQVQwaHlpOHMxaURDU0UzNTVMK2tsSmErTmM5Z0g4?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+L6ofV932KM1S1CyMwvSKH6Fhw+8SZwHNjwZlPwFnIDYxtD+k4hSSpQnHXsvA9lQqvemWjrDiRyUOC4iymD17BU0USamoOZAkYEHS4PPRisgJHc3I/ubefCv15sHR32WYEVPQzrsLK38ihT0w92N1zC1/PN5UzPoMb+jPrsOarlLTZ4lrr7KnpJSAWpwcJGrlPDpq6ZxCSbCRg0lUhzEu5Jf7V7Vx53UXJmNpSdwXHwwBMwiaMYEXWc+zQdTU0qPfSa6BBA3oAufbp1qaJ4tmQFfOAEykfllHDBzXxS+UeXroikhNNOIf4fPBbKJMss1+brzvWnAAw1N/RDPjZFhVlL3g+BvsURhEVzejnNQB73js7ULNx0A+mb/wSiBOPbdaYM+okpP53BufwOuP4EGkPAv/w5PrnJhZ9bUbmqo6r4JUlc5ZCcaZTxsilZdgM67cUi9t36UMCXAyejv+0LEKx1YkVIuJXEmwMhqx5+IwEUr/1vjz3Y4UQSiAWW7AXroPY/rTTuhdH75OJuH2CNIi2mI6m4eEOIVroz1+DF6hBKWO2FSWLAiE51S7WNQblFu3IbLkmP8Xj5jR2oye5zAt47b1logZSy9VXRt3RPj2JM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e265b-c9cc-4af6-894a-08de16f3f1ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7476.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:03:32.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDqUYh82sUAxXc5T44ahouBxqKKKGNWxG2tvuxi/vr3Hw6piB1ZTWJ3JF2waYO5nwkWXzKsi7/vlEB/V3o2dsGZOrmTFDxXG9ITE22mNmTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX26JWJss0Y78F
 nWZ52HX4rJNfqfrk4S5h8pBrXu7aB6TaACKaHxGJTBPrxNTZIMMVGxZ8ii8d/vWUZVB1xpnz60q
 dnNzmbdqOEO0qnT07kQOj+WlUMcvoShQ0sfY1Nmj0RkYwHB7UKBGHu/XF/NKu75I36t3CN8mPFZ
 cL6HhPun737qLcWYM5F4Nq4HSKrlBi9q/2QgVopWGsnJXD9zycgiCDFt1/bHkHqB2EJC8Ic+D9c
 gt8RdNtuYoc2UXSbGZdENhdTqDohzFtg55DhT3i3v9eEAGbqF/HM9cLlDSeQiOMR5hLBIv0sr9f
 VEEiMrx4vsbAURHRI8y7g8KxdDs82h/EgazjwX8VjiQ6C4ZYPirUTOf3xbUsyXOKeJXP76Cz4zZ
 A8ynINC0wuSSbi+NO9YquHvcQbfUIg==
X-Proofpoint-ORIG-GUID: g4r_HgV5nT6KrauF923bdQ6vc64T_jvV
X-Proofpoint-GUID: g4r_HgV5nT6KrauF923bdQ6vc64T_jvV
X-Authority-Analysis: v=2.4 cv=SJ1PlevH c=1 sm=1 tr=0 ts=69021eb9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=drOt6m5kAAAA:8 a=o6dMto0KQjdpUhF9MvMA:9 a=QEXdDO2ut3YA:10
 a=RMMjzBEyIzXRtoq5n5K6:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22

On 10/27/25 7:45 PM, Al Viro wrote:
> Note that simple_unlink() et.al. are used by many filesystems; for now
> they can not assume that persistency mark will have been set back
> when the object got created.  Once all conversions are done we'll
> have them complain if called for something that had not been marked
> persistent.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/libfs.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index a033f35493d0..80f288a771e3 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c

...

>   EXPORT_SYMBOL(simple_unlink);
> @@ -1078,7 +1077,8 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
>   		simple_inode_init_ts(inode);
>   		inode->i_fop = files->ops;
>   		inode->i_ino = i;
> -		d_add(dentry, inode);
> +		d_make_persistent(dentry, inode);
> +		dput(dentry);
>   	}
>   	return 0;
>   }

Putting on the dunce hat for the rest of us:

I think I understand the dput() for d_add() changes, but it is non-obvious.
Thinking of future maintenance, you may want to make a comment.

--Mark Tinguely


