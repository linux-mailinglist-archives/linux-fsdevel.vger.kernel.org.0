Return-Path: <linux-fsdevel+bounces-38678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93EBA066EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBC188A659
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD10204F65;
	Wed,  8 Jan 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CE1J8fbz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rL9YBake"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD219AD8C;
	Wed,  8 Jan 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370511; cv=fail; b=Skc9LRGi22yrGTMl+r7GZeOwtYMg+5tVGJBmyinZz9tWX0xFbKDMKmYRR1vZWEw8hiMqGIX0ZNYXzoVbVbEza7VKni0cv5BK16eheTS51vqInSQMlZl0x0rhKgKQeBI+EFS2C7Wx3fpX0LxXq87BPOZ0HCYM7hWB/tets24FWqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370511; c=relaxed/simple;
	bh=NVgvwwYJi+9+DDsio5lKFrl7pUzd8cQE63M5UWw/X+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRKPWFXErgDUJMhDsSALVObxTyXzg0K+fn40cMUrST33+qOHoCUt21i5ZgiGgZhxBIeGujgvgi02WfrtVpK3pEaVo3SFKSuClZ5mPgIQl+DC4UqOPHYh17DQOXqHPBc/XZAs8n7aeg6MrdDtuDsBTlQ6BUgj7IWrQeLVXfHtg6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CE1J8fbz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rL9YBake; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMuvA000632;
	Wed, 8 Jan 2025 21:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7GFb4eRfhDviiQcq/mbGAKOEY6q+DjYZOp7ba30aAJ4=; b=
	CE1J8fbzTEl66tryIu9e+uJNRGsw6egt5qHr8ZqZ89HufVwkF/PzsXdRAKsbstXY
	IASlShf6kJ8l2X2smfQ8j5ohxPFZLm1to42pXNnw2CRKFxbgEAS6CFhGtkmZGzK+
	q/vdqcomD7RzZdF9fYAzOwtnhfzoUb7NUzq0urQbEILQdjI9AhAFrPu8VA0SkHg5
	Nz7r8QQlFnZV8yqgSFhEFtXLlnzJDefaFSMC6LiysK2nsGEYLuk03Yk2ZcE/pLlm
	/XvnzFgzB0U3AK6ifT37ha4rXP9seBxrCAFnjgClBRWTATk3et5qijvOYH5beJFj
	esvFDaXU5GDlNSFE7NQYPg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1bykdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:08:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508L2Wnr020119;
	Wed, 8 Jan 2025 21:08:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuegks12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKcdg1AkZYrsiTMOFMjAUNEwVVGcD4EKGrfpD6GS+5AD6lOshzzz8QkxEw1/gaq+dhYHHaCKLpq5NUern6sGeNIsXIavfx6EHiLC3KbxMlzZPwJfncqmeMwOM86QRiD+BRdSLUr8mrqU4T0J5s4/gtPr0vPRzE0sWxOVNMr6c0j4o9Uip5SG+S4v4ejdzfXzVYL68aZEZp1iZnXY3IoiJr+ypB/6Z6HtvGUvE1bltCGDJOhLNxdCDSIhc/XcAwGwKgC6RONq6J6o4txURqSZ+5569UOx+Pn0XhtYPEqQ8PRArXNevkk8XuACKZFBsG4IrBPvLm4aRBWTXmGb13MCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GFb4eRfhDviiQcq/mbGAKOEY6q+DjYZOp7ba30aAJ4=;
 b=iIQG71TLvQbUyhqngpsubx6E4AWobG6BAELpf2aR5SERMj8WYaSHH2O81LX5u6am6l11Exdk+YLKqCdkr3qhcBPlP/l+pK8vrHoUrTWZB47gqFvfoF+f8XFQBkYMYCvrvxTYg52RXl2boAKCUaRfMTZohLv47dVqD2dFU9lJYO1FOAUNvmsKlp7xt98DVUcafaUIagzOWsqOPYYkD2P+V+mKVY+4GrD9EH3eoE7Irx0kfnAPe2jdmH/Onnso4nDIFDhMd8SY3nKUW2J8Qe47HNu+kIgSSLDaoOkWjeOQCN7ktGUIi0AzOqQl8ydo/uWLEPn8cfzsRcGzMRDTjUgbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GFb4eRfhDviiQcq/mbGAKOEY6q+DjYZOp7ba30aAJ4=;
 b=rL9YBakepfnOmKJBSItVDMjajjvPcaaC3USsXRChY0hKU9e/SS3HlSCDNfzSlkccQTBwDR+JsZ4P/LCc/1MBfQmLOVK7CZW9HRTeSDCH7WDMGWP3+TrOTzsYexrPfX66JLbaqBttIzic4raPaUn5lRw8SXpNCyToY6YDaNJLMmw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB5142.namprd10.prod.outlook.com (2603:10b6:408:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 21:08:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 21:08:15 +0000
Date: Wed, 8 Jan 2025 21:08:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Jann Horn <jannh@google.com>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, surenb@google.com,
        kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com,
        jeffxu@google.com, kees@kernel.org, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
Message-ID: <ace885ed-9a57-427e-8d04-493b7504ef46@lucifer.local>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com>
 <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <Z3x_8uFn2e0EpDqM@google.com>
 <7e508a01-7d77-4065-8656-e5e5a551fa5f@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e508a01-7d77-4065-8656-e5e5a551fa5f@lucifer.local>
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: bf016eba-ef35-451a-2f61-08dd30289175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEFaKzJaNnBXOHNtdHB3bFBPWWY2bW9XTW1UeUNBd0d1dDFCcUp6bzZzcGh1?=
 =?utf-8?B?azM5ZXBhQmZBN2JHbHBjYUd6UVdvbWJhRzV3UUduaHFyajVXVFZqRTU1T2Nl?=
 =?utf-8?B?cHlVMmtyRzRMRGJQWVgyODBtM3F2TktuWXNGTG9Ha3U4VTREcG5GMFRLVXFr?=
 =?utf-8?B?M3RpbExSdnhzQXpCc1lkdS93aFFoNjIzbThvYVllRUliY3htKy9PWFNrMFVE?=
 =?utf-8?B?QUo4NXJMSTRrRlg2RUc1MjdXdmp3bGFtWDhiSUtWa2M3QitOUXZsVnlyS3c3?=
 =?utf-8?B?c0FnRThvVWlibld0ZDRtMlhEYjM0UUlrVVhHK2VuSUNBOHh3eTZFaGMwNmhI?=
 =?utf-8?B?cTc3c3FSWk1aTHZRTnM2M0RZbGNRd3FwalN0ZlphNEEvd3Y2UUlja0NPb0xt?=
 =?utf-8?B?dkdJRk56Wi9sbnhlaE1JZlJXYmcrTUxPRVdaVG1MZHNZc1lDWE1GTGFHRUo3?=
 =?utf-8?B?Y3ZKNkdpQXlIaWwzeSsvTFFOUFpLZlN5MXUzTDU5MU9aaGQyUXNwSUVuV1pS?=
 =?utf-8?B?VnNFeGZhU0p3cVByelZEM3JrS3lkb3FjNFNLNnY2R3VTMGxiajVlRDlGUVdC?=
 =?utf-8?B?b0ZKVVJCeUVIT0t4SlU2aThaaGNxdTcwUkZ1V0FreE54LzcrVjJBL3VWRitV?=
 =?utf-8?B?c0xDNXo0ak0reU4zVk1kUW1JeUkzN3VOUGw1Skl4UjFRYkR5c3M0T2dCMU5S?=
 =?utf-8?B?VlN4bmJCclQ4T3V4V096OHRXZGxDSkphNk1aQ09FSmphQkVaYURld04yRjc4?=
 =?utf-8?B?UEtRUklWQ00rNHdVSTNBcHltTFhZMGJXZUNwMkMxcTZJNVFEc2xLSW9jTkE0?=
 =?utf-8?B?OWxxTHlFLzdrNVYvN1kxUFhrb0xyNytBSllHR1VMejd5N3UwMUhSUE1WUG9S?=
 =?utf-8?B?ckQya2g1WWN2WjRNamRpQnBoYmw2QUJqWU90R2dPamxLK0dPT1lxNmkrQmln?=
 =?utf-8?B?VVZjc1ZqaHNiZFZibFcyOVV4RjNXd1lQSWpKRGZpRi9JM3UrNklxREdlV0J4?=
 =?utf-8?B?UmNpWFVvdkJEbUtWMDVPSzUvVGNEeHVNbytHTFc1T3hqRENVQm1wRlh3SGwv?=
 =?utf-8?B?Y1RSUkpJcTQvc0kxb3BIaHNHb0tQR2hLUzJtMGVuRHlyZ0FwQ1h3UUdWaE85?=
 =?utf-8?B?Qm53cWsxakZXaENzNHRKeE9oYUpvaEpKNjVQdG5BUjFYOUlnRjAvd08rNHI2?=
 =?utf-8?B?Y2dUeTU1RXFZclp6YWU0Q25YLzhYdGpuL2gySkNRY3V3Ymdrb0pldUE1VnJs?=
 =?utf-8?B?cTRkdjZlYjc2by9YTlpNZllaZDNOVVh5dGRwelBhTkRpbVNobDhqcytjaGVH?=
 =?utf-8?B?K09ibHhoUjExNENKRE5HSXAxRmkvQjVLMEk3bll0K1ZSR3REcUFFMm9hSXZt?=
 =?utf-8?B?Qm5QRExvYVFsOGhYS3IxR0FOM05Dd3NFV1JkTnFWU1BTSVBJaUZWMHdBSGhz?=
 =?utf-8?B?ZHhReTlEc1djTXdjYy93YktJR1lwQUUxYUI1UHBkMUFYSjREeDZQTHBqWGNQ?=
 =?utf-8?B?VWcyY3pGRSs2Rk0xckplbENSTllYeXMxY1ZBTnBCclc3TG5nV3loOVUwbnVl?=
 =?utf-8?B?NU1MMFpwQXgxWmgxVHU2UXdNVkpScUNrZnZMUTlucXNDK25TRnVTVENFcFE2?=
 =?utf-8?B?ZE9JcEVIb3E0Zm5xYi9jaWtaR1JjMGhuaXkrU240dG9SZGNmYnNaK0NjYmsz?=
 =?utf-8?B?Tm81TXliU2FJM1psUldhU2FidnpHajA2NDFBd3E4YXVnZ3ZJckwwaTAxbzNr?=
 =?utf-8?B?WjFpQnZqTUZNNHpsRm1penhOYzNBR1N6WVV6NzVvN0gvbWZNcGk3b0hlYXpm?=
 =?utf-8?B?VXlsWjAzR3lFeHhBMVdwSVNTRWFxZ0ZaWUJ4L2EwdlhGUEhGZzJIeEhRUmhN?=
 =?utf-8?Q?6+/E/awyVQZ0h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NhRFExVlZnRjVWS2RKNmlqdTltTzZqLzBMTE9haE9EMW1HZElzbWc5M01O?=
 =?utf-8?B?ZFNNQWV2SmxyZzZ1ajFpbnNlaFQ3TVlVSXFkQVhNZEVKTytIQ2tLWExsOGUw?=
 =?utf-8?B?VFZ6bFpvb1ZlbS9nUW4yMmFSMTczVEdOQ1JzZjJyUlR2YW91T2F6VWxCUFRD?=
 =?utf-8?B?TkpsTnQ5cVM1TStDWXJmK1JxWXI5OVNqNEtPMVlsQTI0cDlQWnVzaCs3VlpZ?=
 =?utf-8?B?U3pKWTlndjkzSCtiYlhjQTc4M2dESThOZ0h4Z3lSdUN5MHRQblp2eVF0eG9X?=
 =?utf-8?B?emlPUksxb1FwSlJDZ0hvVXVzaVRKaTJ5WGNxZjR1K3cwc0xCZTlBRFhCNDRW?=
 =?utf-8?B?YXJxMU1qd0kveTQ0YWxDeVJ5Q1k4WFpEcHBGSUVoNWtpdWpQZld2K2VHRzQw?=
 =?utf-8?B?VjRpZWhTenVSYVRtL1YvTkorVWtTalpYWmpYYytnOWtSNTY4ekpzYnVmaVo4?=
 =?utf-8?B?cU0xV3FUTjZPdGVpTllWMGVuSzVYQmw2VDd1Tlh2TXhEbW5lQUtUdERiTmMr?=
 =?utf-8?B?SmxHeEc0akc1WlZmanpRNzllZXdHek03c1d5bWlpYjZsRkUvTHhkWFkzRzBD?=
 =?utf-8?B?Q2lyODgwV244eHFCUEEwSUxrRXltMVV2YmtUUnFCUndlVk5id2ZBS1VsdE1T?=
 =?utf-8?B?ZTR3WEdPTVo1UHN2bDFjT3JuTGpSVGZjdmlXZ09yN3JwUVRNTlBCdHFjdXI2?=
 =?utf-8?B?akJ0YklmdTE0Umo0VXZMdWkycmVzZGtYeVhuckZmUXlUSmhKYWRnSmVSc2dy?=
 =?utf-8?B?TmJEWEpDSTJwd0l6OEplSm1tcjU4UzcvQXdHdm95RTE0c2NtaUEyRXNlb2h5?=
 =?utf-8?B?S0ZDbHVOYnFaZkVUY1pIM1FlQVg1TUMyQ29hUGRCSGRydG1HNmUrZnVMRDlD?=
 =?utf-8?B?QVl1UFMrMEJEd1JSRGhhR25xZTVLQUMxcUl3U282LzhTSTFLN0E3UFhYWFZv?=
 =?utf-8?B?T21CZzl4MUh0bmErTDFlT1VkVC9qUENMc0l0bVBmUGNnMUZiVnN6bkhrVG9i?=
 =?utf-8?B?cmVPaXUzMU5RMWxTVkZlYmF2bHZiZWN3T2Z2N0hjY0dhbTJNVTM4eFl2Y3RO?=
 =?utf-8?B?WksvV2oxeWtPdExnZy93cE1WM2hVNTVBYzhNbG9OWHhjbGRhR2NUOHN4cWpP?=
 =?utf-8?B?akhjQnVqTkNtTHB5ZElHcGlLNFFRMzZSYzVyc1d0TTJJSW9DbUxHRmx3dHFU?=
 =?utf-8?B?VmJBUjNFd2Npc0ZEV0hVeW4vb09XWTQ4VUF0SlgxZ2ZFQWlYaDlnbHpoSXMy?=
 =?utf-8?B?bnJUbXNLMFRwVzhXZnFDSUxvY1ZpM2h6MWpGMWFFTkd6anhQNVB4WFFFWXB1?=
 =?utf-8?B?eTRaQkFsTlJYejBaeWxYYTBkbkh6Sk1SSUM1aEthSVBpK3NQTmtBSUVTbnRv?=
 =?utf-8?B?R1FneVZZTTNzeEVCZGluTkM0V3RWQ2dPT2NpS3lmaVdCQS95VjdCUkpudmNp?=
 =?utf-8?B?N25NNlZBYkdRMFRZWWhIcUJRc0pPbmh6ZnJmNlpVTkxBUGpmcHhMcGExaHBo?=
 =?utf-8?B?dzYrMnlqMG5scG5DQnhuOEJ5Q3BXYldRNE40cWVHbHBmMDZ1emhrdGF1RmZ1?=
 =?utf-8?B?and3Wisyb0Q4ek85dDR4OFBFSWFuTjRkUmVFN1h1V1pQcFJrdG1FRVFreFV3?=
 =?utf-8?B?YytPZUtyc01WVmlJYTZyd3FkZExBWjVUOHBNc1JDU1FMSWt6MHNSd1V1V3pT?=
 =?utf-8?B?L3I3Z01DWnExMnpqaGo5R1VBUG1FRUFLNWNmMHR2OTdkNHhBZkYwWnc3OUFF?=
 =?utf-8?B?RUltcGVvZFRtK2J5c3JuVlN5UG84anV2V3NGQ0hVZUc4UVBTQWIxNnFoT2o0?=
 =?utf-8?B?NXMxR21KRk1QeWhSUEZWbWdlcHV1Q1VvZjB3WmpOU0hKeTduR0orM3Y3MFFZ?=
 =?utf-8?B?TFREVEVHSGZVR1VSVVJPWkh6S0dZL01WaFg4cVNmSDgrc2pKUVlJWk1iNjE4?=
 =?utf-8?B?cHhsUk5pSGNreHB2V2tsc2FvejRpV1o1TlNGREdUKzRETWtMWnAwTEcrV2d0?=
 =?utf-8?B?SDNEWWh0ZmRiRFdxNmw2a2pkUm05cnZteE55eWtleEtuZmQrS0tuMnNBaGFJ?=
 =?utf-8?B?aWpuVkxwNldteUZlaVhQZ2tlVUJqVlM0RTI3U3pMc2VXamhRd0pyalFIRis4?=
 =?utf-8?B?R2dLaXJLdC90VE13dzB5U0xZeXo1c0dNa0FCb21uQnNsL1d5VGV1MkRoUEVx?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rrUmxSpfHEUmJ3WRc/edf8E81ZSNA/slunkmqe2fb6pRh0P283G7XgeW6oo1LkpX3aRRNO4pyWDtwzcpSmDo/v/74ZoIFlyjCknVRdTpgigaHKIBou/sZuJHZ1pV/sVc5GmtFX25uIO1rD4IHmBWB9+87a0KzgnCpSWjWnIxue4fgSQwa03X8TbE0e7vW/VN6Qsv4KlCjKnwoiEJpiYxUsDqvLmLSKdK8hpfCtq/6Q3p7z8+cE2X6ssDZQTq1PrAchL9q9Mnvb7oJsp+49YWttABlGpMaSRNJDA/RmQxTypxh1fC3Dp5hz6R4lrYyU9pkNLVILbbgEsbIwE55t5iaaT31qFHhQ5qeD4e447/aL9w2QrFRtk7SwEhbWvIo4AvoDlKNnpqpkftmZQzJtteuwI3TkRmAVggL1fbKHrTaR2Pbjc5PcbcrUBpvtoudPzOtIaGEF7zGvD5lfCtolalmkdSFx5jYiji/isyA9E3hQNimNhKHcfPfVzYl09Ng4hNDoAV5XfyvwUmRe/G/Nj6jC0Vt8lTiSH5Jw+N9M0bk1Zj+DWLCNMgtbFhTO0xyzL2g49rY0vRIZPSxOrZsT3A5sJqgLI1/4BnFjOLFtdOCFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf016eba-ef35-451a-2f61-08dd30289175
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:08:15.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn6NAm8BwIalgKWyR9ytqDVP4CogNbJwM+JBq/XwCVtRlMALv+6g0NIakQOMKzEQ/zFaWvT7HtKfprf4KksR2DaeieVWJePT8zJGZWPjYeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080172
X-Proofpoint-ORIG-GUID: FD09RIzBiRPIq3F8hssHVcJJnuLMNHTV
X-Proofpoint-GUID: FD09RIzBiRPIq3F8hssHVcJJnuLMNHTV

On Wed, Jan 08, 2025 at 08:43:38PM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 06, 2025 at 05:14:26PM -0800, Isaac Manjarres wrote:
> > On Fri, Jan 03, 2025 at 04:03:44PM +0100, Jann Horn wrote:
> > > On Fri, Jan 3, 2025 at 12:32 AM Isaac J. Manjarres
> > > <isaacmanjarres@google.com> wrote:
> > > > Android currently uses the ashmem driver [1] for creating shared memory
> > > > regions between processes. Ashmem buffers can initially be mapped with
> > > > PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> > > > ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> > > > permissions that the buffer can be mapped with.
> > > >
> > > > Processes can remove the ability to map ashmem buffers as executable to
> > > > ensure that those buffers cannot be exploited to run unintended code.
> > >
> > > Is there really code out there that first maps an ashmem buffer with
> > > PROT_EXEC, then uses the ioctl to remove execute permission for future
> > > mappings? I don't see why anyone would do that.
> >
> > Hi Jann,
> >
> > Thanks for your feedback and for taking the time to review these
> > patches!
> >
> > Not that I'm aware of. The reason why I made this seal have semantics
> > where it prevents future executable mappings is because there are
> > existing applications that allocate an ashmem buffer (default
> > permissions are RWX), map the buffer as RW, and then restrict
> > the permissions to just R.
> >
> > When the buffer is mapped as RW, do_mmap() unconditionally sets
> > VM_MAYEXEC on the VMA for the mapping, which means that the mapping
> > could later be mapped as executable via mprotect(). Therefore, having
> > the semantics of the seal be that it prevents any executable mappings
> > would break existing code that has already been released. It would
> > make transitioning clients to memfd difficult, because to amend that,
> > the ashmem users would have to first restrict the permissions of the
> > buffer to be RW, then map it as RW, and then restrict the permissions
> > again to be just R, which also means an additional system call.
>
> You could do something similar to my adjustments to the F_SEAL_WRITE
> changes that clears VM_MAYEXEC in cases where do_mmap() maps an
> F_SEAL_EXEC'd without PROT_EXEC.
>
> Please note that F_SEAL_EXEC implies:
>
> F_SEAL_SHRINK
> F_SEAL_GROW
> F_SEAL_WRITE <- important, obviously
> F_SEAL_FUTURE_WRITE <- also important
>
> 	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> 		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
>
> Though interestingly only _after_ the mapping_deny_writable() call is
> performed which is... odd.
>
> Probably worth exploring F_SEAL_EXEC semantics in detail if you haven't
> already to see how viable this is.
>

OK please disregard this (+ other waffling on F_SEAL_EXEC), I dug in and this
flag is weirdly named and simply prevents chmod() changes to the mapping (...!).

For the semantics you need, you do very much appear to need something completely
new and what you suggest with F_SEAL_FUTURE_EXEC does appear to fit the bill
nicely.

