Return-Path: <linux-fsdevel+bounces-46725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52CA9452C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 20:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CF5174FFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D51E1A05;
	Sat, 19 Apr 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hxgsu6z6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uIJKADEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D04142900;
	Sat, 19 Apr 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745089146; cv=fail; b=WbjcuNOvJTzpYIp319nKlcntUGqIH7662vEkNF7PgRp+perreeNP7F1YWWIkpcQf1WU6rfyTsy42nXAEpHNE/Zzycp317FHSzkCq2CTtoVXvOrPl6PET0u6bkTFV/ofLXPBE30o9GYVFBxY3hz5+LNothnucsZ87mnqwX+Etgag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745089146; c=relaxed/simple;
	bh=7+q9qQ/NWD8f7Yw7T3DGAQpDHiMsUbA+0oQdC5UwLMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FJo1S6yBX2WKg0TVrv0+UDjXKnZfjdumv80itAp+1RCrrZbyR5u75CP+x47TYvyJ7P6as3hp24JEV7p3AhRMj5P2QwIZ7T3KLRa/cwfFIsxAKDL+ZPsYSI1Kr/dUqQ2QyJjJ+MGk0s/yWsPT/AwA/p3oDx1HG3LfOMzF8G3UrdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hxgsu6z6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uIJKADEk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JFIMJ2010121;
	Sat, 19 Apr 2025 18:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jJDwmh0qb3TIDH8+mVsXKLnDg69jesVGC0LcKU+wEts=; b=
	Hxgsu6z6zMGxKmIloINj7GqHK4wPe6phbauzyybgSRRLhl85UsMxE99uuPJAkFY8
	xuJP3UZCEMA6kS3loi66SOqwytGaTukC6tJvJJkYombmxbJuiE+QFdVOrW3eIXTm
	N93Bwp07nK22aYZ0mcmXxfMquYA0KttdbTf+wVyRIzxuM5T/gA+ltxLcdsYZoCUZ
	kvjwGvjQf2i8KVOXUXFNR08lg/FWQ9dvthEmIIM6bw61EYj6Vdf+3R2o6aICP0ZQ
	UcFub2NuGfv7d6GuSlzhlLNp/Kyv0d91gDWC8dPjCTwtIsxSAhYh2R2LqQfrN1Dr
	0Z7Pu8IJMkLa5HMd4q2Kbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642ra8hgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 18:57:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53JHHPX1021121;
	Sat, 19 Apr 2025 18:57:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429d6sk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 18:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLrlfoH3baWt5YFS17fWMVxCdnRD2FX0mbMczrxAc/W8FsmkObyyHDuk1GU1y0Q4tvXcSYMosTJW7noHVMcGTvxflpJ31sqsf6U3XQdTiUEP1bnK81BXE78ONb4FCYqT+xpdtivcD71P9F/RLQkebwJkpKXIZ1yCyHmUblAOailkHiskPLmldBx7jf4W25hfA24sBC6XYijRHwZgmbnYfeR/l0fOztex0x50gnlHtYaoUvAta5CFVk0w+nYQU+a2jhtpAntesgnxBBMkikTB+H+9dx6yknqir6+V88JrpzfmJqTNKrrktTDdC7DcuQyoJN8+EKmsbr4hpajm4f+afA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJDwmh0qb3TIDH8+mVsXKLnDg69jesVGC0LcKU+wEts=;
 b=FeWaEbY4IXA9PSJGzlGMrKOWA35IsLQvl/8bDstE5gIVQpI94X8CT9VO7BQYF++CrYnT+0We//T8cDOoPhvyFZ9hKPZQVZ4iAiT0zdj/S4oC7knrjZXM0vJGNfweVg/R4VfaYJ+NvOxZ7OcCG2gsjsiDUnWTCXt1KnJjbxYvdtae3seIFFIYopYdYVJMxeWSXcTiCkBvzJkHYvfqUFVmS0/jTygVvO1qe362hy4s4QAwzMjBevXIiHzjY+fYaHCxAJmVryMQfMyYcyT13FZ9uWouNUfnm6pW4teHrhALBmc/ylrXnDXtiRAcj31NnaTl4okMNbezAeWRL4wWScmDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJDwmh0qb3TIDH8+mVsXKLnDg69jesVGC0LcKU+wEts=;
 b=uIJKADEkqUv9OnrvkH0wrdH0/kquvrV8Ytr6KvPxsVIEN+J90ncmavabXIU8qu/DTyaM/I8KLwai6PoGaWbZpB6nXgy9ed1KiYob+hmDAU8/84Q6HqGf8/WK73m/w/K/0t4GNc+m7w0L2PVD6pex6JRJ5AApskeVB0PM/FPJ+jM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7835.namprd10.prod.outlook.com (2603:10b6:610:1af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sat, 19 Apr
 2025 18:57:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.031; Sat, 19 Apr 2025
 18:57:44 +0000
Date: Sat, 19 Apr 2025 19:57:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
        peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com, Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-3-surenb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206103702.3873743-3-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0574.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 385cba6f-c6f7-450f-e3dd-08dd7f741198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVJyc2JKMVZBMjQraENxamxJS3htRE1qcmdaZVhjMmRIQ2xSTVo1Uk9nNGtw?=
 =?utf-8?B?cGJCM29EeldueE5zdFFJSTdMcEI1SnhIMGY5elhxaHBPUUhTYTJrSWxuOUdJ?=
 =?utf-8?B?RU5PK0k3NjhsZjhnc2E4ZGJpOHN4dS9OYS9VWG9TSHpjRGpzeTlSUGhMWCtS?=
 =?utf-8?B?T3BYMVVNNUdMZUJGS3JGdzJaSnQ3UU80bUFQZWlvRlZDdzJocUh2V2ZVOU9X?=
 =?utf-8?B?aXpFY2hDRkFlMlBscnhDVkdpNDR3cDdhR21TWnNzNE9KMmtHRDJrK3hRRks0?=
 =?utf-8?B?MG00SER1UE5Xa2EvbUxXUDZXNUR4MzMrOUF2R0wrUVk4MDEyM3ZTZEpVQ2ww?=
 =?utf-8?B?cnJQMVJ4M2FIOEpiSnFRK3JRc2tPa1BWQ0tSRytJMnVSVkkzeFczOXBYVllU?=
 =?utf-8?B?NTh3NEhRS2pJak1QZlVOWXRNd2pkMGs5YVVBQU41VEp1RVBCbUplcVVacXRX?=
 =?utf-8?B?QjRicUpxRVRoeldqSlMvempCZXl1UTZUQ09QRWJXTnBPc3NiemNSQjczK1dS?=
 =?utf-8?B?M2w2ZGtNSWVPSlMvbTRjQTZicmtBamRGT1d3WkdKYWpXWjRHUGxWOFp1SWpS?=
 =?utf-8?B?cktQRnE1T0hyVE9BSU43UG4zYy9tOWNuRWsvUUo5N1JxWDBoMG0wRTdaRHVS?=
 =?utf-8?B?bVJXcURjYklYNWROc1FNZzJ3d3JSWlJQb2JUZTVOVFlOMkdaTHI1ZWprYnBN?=
 =?utf-8?B?aUUzRlZ4UkF5dkw0cDFJNVhUSVJKVHNxeEx4ejJOTHBSYWUwUnpOMGIwV292?=
 =?utf-8?B?R0ZPOFBwRDd4ZS9EUWRHOFR2Sk9ZYWRFV3VLeW40WFNuQUNITFJHcXpUd0ZN?=
 =?utf-8?B?ZzcxRWtNYm1uR1FBQXRya0pNQmYwV3hNRGR0M2lVd0paL0JsNkZCMDFzenc1?=
 =?utf-8?B?VjAyZk4rY1NObGh2Y2YwdTREZ0hNYkh4RDZ1Q21oQ2E5ekNZT1JDQmJBMUxr?=
 =?utf-8?B?ckVORUxQcUZ2bjFVMjFNSWpaaEl6SWZzTFdPck84aVBwS1JKYkkxKzZtTnBx?=
 =?utf-8?B?MkEveG9JQ0NpRXA4NVFLbUVwQzN1ZkFDTHY0dnF1d2NWWnRsU0ZSOTBqNzdM?=
 =?utf-8?B?U1F6cEhnWVdqSUFMMnNVVXByNk8yODZUc2VUU3ova3RBYzJ6QWQzQjlpU0d0?=
 =?utf-8?B?cll2U1l4MlpWYnFCK1h2ZVV4SUpkYmxIME9EQ29TQ1ZpMkF5UW45dGpxb1lK?=
 =?utf-8?B?cXU2UG1kSWpuYitML3FadVB0YUU2YVkrVkNhdndxNUxKZStDSmVLcXFHaDg4?=
 =?utf-8?B?TWR2VlpBTWEvcTVoR1BqV1NsVzFFWTJZTFJNNUl0NzhnYWRNNzhiaU10S1Y2?=
 =?utf-8?B?ZEZwSzNHb0hsajd3TktSUmNTOW5mQmpnRG56aEFDMitBYldxaWxNUmVaWm9V?=
 =?utf-8?B?TWt4OEJXUGZKaFNyWFozRXNoSFJvUTFiTHRoc0hTMXJNZVpRNnM0eXdrem9E?=
 =?utf-8?B?cWUzVjBFUVA4T1RCVzVqNVR3MEZJUGFCNjJhK2paY2JVanFVRkZNc0daNXB1?=
 =?utf-8?B?QkNLekRicXdFelpRTXo0dlZKdEpOUzA3OUx3SjB4VmhlQW4wOTFkUkZvYzNl?=
 =?utf-8?B?UjNWYU9pN20yU3o3N1dpRzZHMXR0MWdvbnBzaFhSaFN0ZjlRYlBMTURtUkQr?=
 =?utf-8?B?eitTNFRVVjFBMkgxd2NRd2pSZFNVSFFOVHh5MnRXVkFmL2txVExUNHZKdkFm?=
 =?utf-8?B?azV0cjhrcUcyWW04OVdNT1lwNE5sYkRtWEpaRXFhSk5yM2NoZUFvSWdNVHA5?=
 =?utf-8?B?QkxWVVAvOUlWbEVsaWFqelo2bXB0ZTRvZmlIaWxQcEMxbDZsY21DcWJ3V0tC?=
 =?utf-8?B?WXhFT2JjT3BzZmJoZTZzc2JPYjRUd3VTSk1rbmJVS2hleVBEL3J1NHl6MXoz?=
 =?utf-8?Q?Zu4i8HkLmgUJO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmVBZFJhYkFjbmtkMm9LWDFEWWxzNGplUWtMdEZSS3BsSElBakIyQzlEcy9h?=
 =?utf-8?B?WTRsWmkvK0J0U3Zxc21EcmloeU9sK09Wbm1lV3pXS1JpUGFuOTlUaHk2Y1Ez?=
 =?utf-8?B?bU96YU11ZjVrc3luU214QmYvVGpGVmNVdlVIWmYrWlJYRlIvWVk5MDVTTWtZ?=
 =?utf-8?B?cEF4QVlqajZYLzFWVkc0OElHN1pWbmJ5cVdibEZHYnRMZDFLYVhCUG9HYzRU?=
 =?utf-8?B?YlZjSFlFYWV3L21VYzRQSTZTZ0dUbVJDKzM1K2I1NlAvcUdIL0FuRjV3YTUz?=
 =?utf-8?B?QUV1OVZFalpOKzM1cDg4aVBWTFBGWmk4aC84WWg4VnVKeTJxaXlkUEpON3ps?=
 =?utf-8?B?QWpFeXlaZjZ3SThwU3NxTTVNRkhFZnpyS282KzdVckh3N0F1KzZqdU9iQVZm?=
 =?utf-8?B?MUJrMlhWTGo3ZmZEY2pjc0tQY0hzZ2JNY04wOHVhWElCdEtSV1JEUEFBa2ll?=
 =?utf-8?B?ZnRXMkhULzV6UjhtbkNLTXhOSVpkT1hGZnlmWEZDMmlzQ1BvVjBFMXBRT0Vj?=
 =?utf-8?B?aTJJWUpqYi9jZlJqS0pxclBFeGM5ZWhYTGF3bkFyY0kzM3RSUmRYZFRzQnRI?=
 =?utf-8?B?cDhEYWQ3enlzV0hZUXZQdnp4Tk00UXZhcUdYMkY2Z2wrK1E1VjdoQ0dIZXBL?=
 =?utf-8?B?L3V2RnIwbnp3TWJSMEdjTDFvN1I4TXV5UUZ5SzZnZVhHY3ZMQzZibUFxYitk?=
 =?utf-8?B?SW5GMS91Mm9XdWRxZmZObVVoZmZJOHdzSHRtSnJIem45dnNHMlM4aTVJaGxJ?=
 =?utf-8?B?eGo5b3E1VTk0eTBaTVJFdEVSUFlSNXZ2QzlCb3Qrbk5TdGZZemFYSlZ3RzFj?=
 =?utf-8?B?dWRmM1pKelZYRHpBalVWMzgwOXJtQllHUElVZlVFWnlZUUlCRDl6ZDF0Ry9S?=
 =?utf-8?B?OGtHV3JSbU50S1dwSHAvSldWQXk3Ukl3SUhJZHltNjNYeFlLY2xhM2ZjdVlq?=
 =?utf-8?B?SkdrcUs5SFRCaXBJVGpuTGlYdVUzOUFBTHRhV1B3bUtNVFNhTnQ0eTVVSnlE?=
 =?utf-8?B?dFJMTDlBTmR6M3czVlRFNDFRaTd1VVdYdjhCWUNKMFZQc2p1VnZaMEFBbVZH?=
 =?utf-8?B?V0g2aVU1eGQwSHA1aWJwUkw1UEtmbTc0OWNWZkdkbTNpMGYra2p3bkQwcUpt?=
 =?utf-8?B?eU9zc1p5WW5xcHF4VTczdlljTmJ5bys0Ym5XTVlLV1ZINmlTQ0c1eXphSUM5?=
 =?utf-8?B?bHhrRXl4NkFOR3RCRGYrMVdiQ3BWME54SDQ5bERCSkkzd1ZYbk9xOG1SSG5l?=
 =?utf-8?B?ejlENFRoM3B2d0d6N1AvaUhtVTF6WDFDOFRQN1RlQks5OEw4RUNXTDdoQXBD?=
 =?utf-8?B?Z2dWTVpCWHNPNDlDRStDT3VZdkRNWDcwdFJETmsraWxxdzJQcGJiVjJYaU8r?=
 =?utf-8?B?RnZTaFlDVlF4RTlWTEhQMFQrMzZ4ZzN6c2NSUWZ3bStVSGdtck92R3NOcXJq?=
 =?utf-8?B?TVU4WkhoMkNoQnByTm9tNEFUaEZadVJSVlAxQlVqRVJqVkVXOXJVN1dJcTlj?=
 =?utf-8?B?UUo2eUlOc2xuM3J0V3FFRjFoU0VHMm5lVSsrME5sZkhPWkE0NFpVSHJhZVl1?=
 =?utf-8?B?aDM0VGVSQ3I4M0t6VXZ5YWZlMkt5b2lQaGlTTTF1eGpVdzgrcy9lT1FLaEdM?=
 =?utf-8?B?OXZwVkdsc3IwY0ZvTGR6VVd5WWovcXhMdFFuS3l0emlTWFZ5U0hqWGJvR1Nr?=
 =?utf-8?B?Q3J0a25rZG5PYWphblpnNHNhZm51T25aN0ZhTVl6akoyWnd6Mkwxc2VrdnFP?=
 =?utf-8?B?TDJwbmt4VHI2OTdnMXZ4YkhLeHpkRU5tMDAzVDllQzNMQjNnNGF3d0duaU5r?=
 =?utf-8?B?RnZBeXRKSVQ5cEZJOG14ZUFlUTRHQ2ord2lNZDVueGplT0RZTHdxMWNLWGl5?=
 =?utf-8?B?QTVpdXlTZmFLR1BmN1N2QTYrSEFtSFBDOXlYM0E5V2lpN0wwbERqSmdLV3dj?=
 =?utf-8?B?cHJoSVowWXdkQ3RnelA4aEpxUkZ3Zm9HUXRTRG52MG1nUWpxTDJxL1JMdFVH?=
 =?utf-8?B?YzE1dUpTdFYwcXlJbVRFa2JmdkxaMzVJbitwQ0hSYk1Mdk5TYTVQUGJuSmVO?=
 =?utf-8?B?RHJ1M0tCcFJtTGM5VGF4NFkxM2lJditqcjJNNVZyWVk2N2w2Zy90NE41Smd4?=
 =?utf-8?B?SWY0cW5qSXJBN28wTUFZSzVLeTMvK21Tc2plaGNjRTNpOSt6NzJBNHNSQjkz?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zHAcs9tU2Gtk1UudrYAPMTWsAkOfnH9X4UodxM3qYtFDczE8crmhlvcJo46kVYA6Vh0qWAsPPf/ZxxPGZIaZkalRFv6jfWAgozqd/FKomEYhdH2GRIFUlR1pLcMD0dXCmqPouV5KJPCZDTVuPjsjLtEs+5fADB1U/uyt9nUL5OraUoSlAPTChh7QyAqufKKgoXaBVqHX+TbcAYJQI3QhkBtwjgPYQ1YlKbZhwPD6mnBcoWPejL6WDeMvwaW7/k5Wj41PVq4hpC7JJGGBRa6fv0vzRh5jYIOaRO8OW2lPiXH62iPO8r70mmBZrCJ4dsrjMuJ/MD6alib1rqN4kgl2gkBFQKZg/NULI5/nqMw3py0LiYlAtODSYSkskTNLC63y9cklxNGh/I4QGJvbbVsDjbYqZkNuwXu+5zGoW8EFKbYlkeYK5D171emMT4c/zMsVkUHK0l4tLXC08NC4TfmRN3Izm2YlFX7zfaawHJ7fkc8C/AEOikbWuOyaQNFQFJ8ENDZn8KuFXSo/xn8mk2c2m4iuK22nMNo8SAcR5TdEuM8P2/BocQpcILyjHOamf1eMk8de0DUETJWxK6gzQ19HfUjtnOyw9263DcbzPmK+P7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385cba6f-c6f7-450f-e3dd-08dd7f741198
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 18:57:44.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuuDj+cpzDdeaVNtEi9CtHGQAHuekr43yKJzDB2QmaXCGqTZ+xFqEZZUPFjzavmzDCbsb0sf5ckRZfxef0u+D58qYWgG039jb57qNfO4nzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_08,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504190157
X-Proofpoint-ORIG-GUID: axN7zHN3DtKDzR1yaKqWeVVUKq5uxCwW
X-Proofpoint-GUID: axN7zHN3DtKDzR1yaKqWeVVUKq5uxCwW

+cc Alejandro

On Wed, Dec 06, 2023 at 02:36:56AM -0800, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
>
> Implement the uABI of UFFDIO_MOVE ioctl.
> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages are
> available (in userspace) for recycling, as is usually the case in heap
> compaction algorithms, then we can avoid the page allocation and memcpy
> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> userspace, we avoid the need to release (via madvise) the pages back to
> the kernel [2].
> We see over 40% reduction (on a Google pixel 6 device) in the compacting
> thread’s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This was
> measured using a benchmark that emulates a heap compaction implementation
> using userfaultfd (to allow concurrent accesses by application threads).
> More details of the usecase are explained in [2].
> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> touching them within the same vma. Today, it can only be done by mremap,
> however it forces splitting the vma.
>
> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@redhat.com/
> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
>
> Update for the ioctl_userfaultfd(2)  manpage:

Sorry to resurrect an old thread but... I don't think this update was ever
propagated anywhere?

If you did send separately to man-pages list or whatnot maybe worth nudging
again?

I don't see anything at [0].

[0]: https://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html

Thanks!

>
>    UFFDIO_MOVE
>        (Since Linux xxx)  Move a continuous memory chunk into the
>        userfault registered range and optionally wake up the blocked
>        thread. The source and destination addresses and the number of
>        bytes to move are specified by the src, dst, and len fields of
>        the uffdio_move structure pointed to by argp:
>
>            struct uffdio_move {
>                __u64 dst;    /* Destination of move */
>                __u64 src;    /* Source of move */
>                __u64 len;    /* Number of bytes to move */
>                __u64 mode;   /* Flags controlling behavior of move */
>                __s64 move;   /* Number of bytes moved, or negated error */
>            };
>
>        The following value may be bitwise ORed in mode to change the
>        behavior of the UFFDIO_MOVE operation:
>
>        UFFDIO_MOVE_MODE_DONTWAKE
>               Do not wake up the thread that waits for page-fault
>               resolution
>
>        UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
>               Allow holes in the source virtual range that is being moved.
>               When not specified, the holes will result in ENOENT error.
>               When specified, the holes will be accounted as successfully
>               moved memory. This is mostly useful to move hugepage aligned
>               virtual regions without knowing if there are transparent
>               hugepages in the regions or not, but preventing the risk of
>               having to split the hugepage during the operation.
>
>        The move field is used by the kernel to return the number of
>        bytes that was actually moved, or an error (a negated errno-
>        style value).  If the value returned in move doesn't match the
>        value that was specified in len, the operation fails with the
>        error EAGAIN.  The move field is output-only; it is not read by
>        the UFFDIO_MOVE operation.
>
>        The operation may fail for various reasons. Usually, remapping of
>        pages that are not exclusive to the given process fail; once KSM
>        might deduplicate pages or fork() COW-shares pages during fork()
>        with child processes, they are no longer exclusive. Further, the
>        kernel might only perform lightweight checks for detecting whether
>        the pages are exclusive, and return -EBUSY in case that check fails.
>        To make the operation more likely to succeed, KSM should be
>        disabled, fork() should be avoided or MADV_DONTFORK should be
>        configured for the source VMA before fork().
>
>        This ioctl(2) operation returns 0 on success.  In this case, the
>        entire area was moved.  On error, -1 is returned and errno is
>        set to indicate the error.  Possible errors include:
>
>        EAGAIN The number of bytes moved (i.e., the value returned in
>               the move field) does not equal the value that was
>               specified in the len field.
>
>        EINVAL Either dst or len was not a multiple of the system page
>               size, or the range specified by src and len or dst and len
>               was invalid.
>
>        EINVAL An invalid bit was specified in the mode field.
>
>        ENOENT
>               The source virtual memory range has unmapped holes and
>               UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
>
>        EEXIST
>               The destination virtual memory range is fully or partially
>               mapped.
>
>        EBUSY
>               The pages in the source virtual memory range are either
>               pinned or not exclusive to the process. The kernel might
>               only perform lightweight checks for detecting whether the
>               pages are exclusive. To make the operation more likely to
>               succeed, KSM should be disabled, fork() should be avoided
>               or MADV_DONTFORK should be configured for the source virtual
>               memory area before fork().
>
>        ENOMEM Allocating memory needed for the operation failed.
>
>        ESRCH
>               The target process has exited at the time of a UFFDIO_MOVE
>               operation.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst |   3 +
>  fs/userfaultfd.c                             |  72 +++
>  include/linux/rmap.h                         |   5 +
>  include/linux/userfaultfd_k.h                |  11 +
>  include/uapi/linux/userfaultfd.h             |  29 +-
>  mm/huge_memory.c                             | 122 ++++
>  mm/khugepaged.c                              |   3 +
>  mm/rmap.c                                    |   6 +
>  mm/userfaultfd.c                             | 614 +++++++++++++++++++
>  9 files changed, 864 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 203e26da5f92..e5cc8848dcb3 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -113,6 +113,9 @@ events, except page fault notifications, may be generated:
>    areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
>    support for shmem virtual memory areas.
>
> +- ``UFFD_FEATURE_MOVE`` indicates that the kernel supports moving an
> +  existing page contents from userspace.
> +
>  The userland application should set the feature flags it intends to use
>  when invoking the ``UFFDIO_API`` ioctl, to request that those features be
>  enabled if supported.
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e8af40b05549..6e2a4d6a0d8f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2005,6 +2005,75 @@ static inline unsigned int uffd_ctx_features(__u64 user_features)
>  	return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED;
>  }
>
> +static int userfaultfd_move(struct userfaultfd_ctx *ctx,
> +			    unsigned long arg)
> +{
> +	__s64 ret;
> +	struct uffdio_move uffdio_move;
> +	struct uffdio_move __user *user_uffdio_move;
> +	struct userfaultfd_wake_range range;
> +	struct mm_struct *mm = ctx->mm;
> +
> +	user_uffdio_move = (struct uffdio_move __user *) arg;
> +
> +	if (atomic_read(&ctx->mmap_changing))
> +		return -EAGAIN;
> +
> +	if (copy_from_user(&uffdio_move, user_uffdio_move,
> +			   /* don't copy "move" last field */
> +			   sizeof(uffdio_move)-sizeof(__s64)))
> +		return -EFAULT;
> +
> +	/* Do not allow cross-mm moves. */
> +	if (mm != current->mm)
> +		return -EINVAL;
> +
> +	ret = validate_range(mm, uffdio_move.dst, uffdio_move.len);
> +	if (ret)
> +		return ret;
> +
> +	ret = validate_range(mm, uffdio_move.src, uffdio_move.len);
> +	if (ret)
> +		return ret;
> +
> +	if (uffdio_move.mode & ~(UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES|
> +				  UFFDIO_MOVE_MODE_DONTWAKE))
> +		return -EINVAL;
> +
> +	if (mmget_not_zero(mm)) {
> +		mmap_read_lock(mm);
> +
> +		/* Re-check after taking mmap_lock */
> +		if (likely(!atomic_read(&ctx->mmap_changing)))
> +			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
> +					 uffdio_move.len, uffdio_move.mode);
> +		else
> +			ret = -EINVAL;
> +
> +		mmap_read_unlock(mm);
> +		mmput(mm);
> +	} else {
> +		return -ESRCH;
> +	}
> +
> +	if (unlikely(put_user(ret, &user_uffdio_move->move)))
> +		return -EFAULT;
> +	if (ret < 0)
> +		goto out;
> +
> +	/* len == 0 would wake all */
> +	VM_WARN_ON(!ret);
> +	range.len = ret;
> +	if (!(uffdio_move.mode & UFFDIO_MOVE_MODE_DONTWAKE)) {
> +		range.start = uffdio_move.dst;
> +		wake_userfault(ctx, &range);
> +	}
> +	ret = range.len == uffdio_move.len ? 0 : -EAGAIN;
> +
> +out:
> +	return ret;
> +}
> +
>  /*
>   * userland asks for a certain API version and we return which bits
>   * and ioctl commands are implemented in this kernel for such API
> @@ -2097,6 +2166,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
>  	case UFFDIO_ZEROPAGE:
>  		ret = userfaultfd_zeropage(ctx, arg);
>  		break;
> +	case UFFDIO_MOVE:
> +		ret = userfaultfd_move(ctx, arg);
> +		break;
>  	case UFFDIO_WRITEPROTECT:
>  		ret = userfaultfd_writeprotect(ctx, arg);
>  		break;
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b26fe858fd44..8034eda972e5 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -121,6 +121,11 @@ static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
>  	down_write(&anon_vma->root->rwsem);
>  }
>
> +static inline int anon_vma_trylock_write(struct anon_vma *anon_vma)
> +{
> +	return down_write_trylock(&anon_vma->root->rwsem);
> +}
> +
>  static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
>  {
>  	up_write(&anon_vma->root->rwsem);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index f2dc19f40d05..e4056547fbe6 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -93,6 +93,17 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>  extern long uffd_wp_range(struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long len, bool enable_wp);
>
> +/* move_pages */
> +void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> +void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> +		   unsigned long dst_start, unsigned long src_start,
> +		   unsigned long len, __u64 flags);
> +int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
> +			struct vm_area_struct *dst_vma,
> +			struct vm_area_struct *src_vma,
> +			unsigned long dst_addr, unsigned long src_addr);
> +
>  /* mm helpers */
>  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  					struct vm_userfaultfd_ctx vm_ctx)
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 0dbc81015018..2841e4ea8f2c 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -41,7 +41,8 @@
>  			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
>  			   UFFD_FEATURE_WP_UNPOPULATED |	\
>  			   UFFD_FEATURE_POISON |		\
> -			   UFFD_FEATURE_WP_ASYNC)
> +			   UFFD_FEATURE_WP_ASYNC |		\
> +			   UFFD_FEATURE_MOVE)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -50,6 +51,7 @@
>  	((__u64)1 << _UFFDIO_WAKE |		\
>  	 (__u64)1 << _UFFDIO_COPY |		\
>  	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
> +	 (__u64)1 << _UFFDIO_MOVE |		\
>  	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
>  	 (__u64)1 << _UFFDIO_CONTINUE |		\
>  	 (__u64)1 << _UFFDIO_POISON)
> @@ -73,6 +75,7 @@
>  #define _UFFDIO_WAKE			(0x02)
>  #define _UFFDIO_COPY			(0x03)
>  #define _UFFDIO_ZEROPAGE		(0x04)
> +#define _UFFDIO_MOVE			(0x05)
>  #define _UFFDIO_WRITEPROTECT		(0x06)
>  #define _UFFDIO_CONTINUE		(0x07)
>  #define _UFFDIO_POISON			(0x08)
> @@ -92,6 +95,8 @@
>  				      struct uffdio_copy)
>  #define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
>  				      struct uffdio_zeropage)
> +#define UFFDIO_MOVE		_IOWR(UFFDIO, _UFFDIO_MOVE,	\
> +				      struct uffdio_move)
>  #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
>  				      struct uffdio_writeprotect)
>  #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
> @@ -222,6 +227,9 @@ struct uffdio_api {
>  	 * asynchronous mode is supported in which the write fault is
>  	 * automatically resolved and write-protection is un-set.
>  	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
> +	 *
> +	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
> +	 * existing page contents from userspace.
>  	 */
>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -239,6 +247,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
>  #define UFFD_FEATURE_POISON			(1<<14)
>  #define UFFD_FEATURE_WP_ASYNC			(1<<15)
> +#define UFFD_FEATURE_MOVE			(1<<16)
>  	__u64 features;
>
>  	__u64 ioctls;
> @@ -347,6 +356,24 @@ struct uffdio_poison {
>  	__s64 updated;
>  };
>
> +struct uffdio_move {
> +	__u64 dst;
> +	__u64 src;
> +	__u64 len;
> +	/*
> +	 * Especially if used to atomically remove memory from the
> +	 * address space the wake on the dst range is not needed.
> +	 */
> +#define UFFDIO_MOVE_MODE_DONTWAKE		((__u64)1<<0)
> +#define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES	((__u64)1<<1)
> +	__u64 mode;
> +	/*
> +	 * "move" is written by the ioctl and must be at the end: the
> +	 * copy_from_user will not read the last 8 bytes.
> +	 */
> +	__s64 move;
> +};
> +
>  /*
>   * Flags for the userfaultfd(2) system call itself.
>   */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4f542444a91f..315968db1ca4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1964,6 +1964,128 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	return ret;
>  }
>
> +#ifdef CONFIG_USERFAULTFD
> +/*
> + * The PT lock for src_pmd and the mmap_lock for reading are held by
> + * the caller, but it must return after releasing the page_table_lock.
> + * Just move the page from src_pmd to dst_pmd if possible.
> + * Return zero if succeeded in moving the page, -EAGAIN if it needs to be
> + * repeated by the caller, or other errors in case of failure.
> + */
> +int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
> +			struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> +			unsigned long dst_addr, unsigned long src_addr)
> +{
> +	pmd_t _dst_pmd, src_pmdval;
> +	struct page *src_page;
> +	struct folio *src_folio;
> +	struct anon_vma *src_anon_vma;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pgtable_t src_pgtable;
> +	struct mmu_notifier_range range;
> +	int err = 0;
> +
> +	src_pmdval = *src_pmd;
> +	src_ptl = pmd_lockptr(mm, src_pmd);
> +
> +	lockdep_assert_held(src_ptl);
> +	mmap_assert_locked(mm);
> +
> +	/* Sanity checks before the operation */
> +	if (WARN_ON_ONCE(!pmd_none(dst_pmdval)) || WARN_ON_ONCE(src_addr & ~HPAGE_PMD_MASK) ||
> +	    WARN_ON_ONCE(dst_addr & ~HPAGE_PMD_MASK)) {
> +		spin_unlock(src_ptl);
> +		return -EINVAL;
> +	}
> +
> +	if (!pmd_trans_huge(src_pmdval)) {
> +		spin_unlock(src_ptl);
> +		if (is_pmd_migration_entry(src_pmdval)) {
> +			pmd_migration_entry_wait(mm, &src_pmdval);
> +			return -EAGAIN;
> +		}
> +		return -ENOENT;
> +	}
> +
> +	src_page = pmd_page(src_pmdval);
> +	if (unlikely(!PageAnonExclusive(src_page))) {
> +		spin_unlock(src_ptl);
> +		return -EBUSY;
> +	}
> +
> +	src_folio = page_folio(src_page);
> +	folio_get(src_folio);
> +	spin_unlock(src_ptl);
> +
> +	flush_cache_range(src_vma, src_addr, src_addr + HPAGE_PMD_SIZE);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, src_addr,
> +				src_addr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	folio_lock(src_folio);
> +
> +	/*
> +	 * split_huge_page walks the anon_vma chain without the page
> +	 * lock. Serialize against it with the anon_vma lock, the page
> +	 * lock is not enough.
> +	 */
> +	src_anon_vma = folio_get_anon_vma(src_folio);
> +	if (!src_anon_vma) {
> +		err = -EAGAIN;
> +		goto unlock_folio;
> +	}
> +	anon_vma_lock_write(src_anon_vma);
> +
> +	dst_ptl = pmd_lockptr(mm, dst_pmd);
> +	double_pt_lock(src_ptl, dst_ptl);
> +	if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> +		     !pmd_same(*dst_pmd, dst_pmdval))) {
> +		err = -EAGAIN;
> +		goto unlock_ptls;
> +	}
> +	if (folio_maybe_dma_pinned(src_folio) ||
> +	    !PageAnonExclusive(&src_folio->page)) {
> +		err = -EBUSY;
> +		goto unlock_ptls;
> +	}
> +
> +	if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
> +	    WARN_ON_ONCE(!folio_test_anon(src_folio))) {
> +		err = -EBUSY;
> +		goto unlock_ptls;
> +	}
> +
> +	folio_move_anon_rmap(src_folio, dst_vma);
> +	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +
> +	src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> +	/* Folio got pinned from under us. Put it back and fail the move. */
> +	if (folio_maybe_dma_pinned(src_folio)) {
> +		set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
> +		err = -EBUSY;
> +		goto unlock_ptls;
> +	}
> +
> +	_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
> +	/* Follow mremap() behavior and treat the entry dirty after the move */
> +	_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> +	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
> +
> +	src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
> +	pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
> +unlock_ptls:
> +	double_pt_unlock(src_ptl, dst_ptl);
> +	anon_vma_unlock_write(src_anon_vma);
> +	put_anon_vma(src_anon_vma);
> +unlock_folio:
> +	/* unblock rmap walks */
> +	folio_unlock(src_folio);
> +	mmu_notifier_invalidate_range_end(&range);
> +	folio_put(src_folio);
> +	return err;
> +}
> +#endif /* CONFIG_USERFAULTFD */
> +
>  /*
>   * Returns page table lock pointer if a given pmd maps a thp, NULL otherwise.
>   *
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 064654717843..0da6937572cf 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1139,6 +1139,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * Prevent all access to pagetables with the exception of
>  	 * gup_fast later handled by the ptep_clear_flush and the VM
>  	 * handled by the anon_vma lock + PG_lock.
> +	 *
> +	 * UFFDIO_MOVE is prevented to race as well thanks to the
> +	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
>  	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 525c5bc0b0b3..de9426ad0f1b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -490,6 +490,12 @@ void __init anon_vma_init(void)
>   * page_remove_rmap() that the anon_vma pointer from page->mapping is valid
>   * if there is a mapcount, we can dereference the anon_vma after observing
>   * those.
> + *
> + * NOTE: the caller should normally hold folio lock when calling this.  If
> + * not, the caller needs to double check the anon_vma didn't change after
> + * taking the anon_vma lock for either read or write (UFFDIO_MOVE can modify it
> + * concurrently without folio lock protection). See folio_lock_anon_vma_read()
> + * which has already covered that, and comment above remap_pages().
>   */
>  struct anon_vma *folio_get_anon_vma(struct folio *folio)
>  {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 0b6ca553bebe..9ec814e47e99 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -842,3 +842,617 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	mmap_read_unlock(dst_mm);
>  	return err;
>  }
> +
> +
> +void double_pt_lock(spinlock_t *ptl1,
> +		    spinlock_t *ptl2)
> +	__acquires(ptl1)
> +	__acquires(ptl2)
> +{
> +	spinlock_t *ptl_tmp;
> +
> +	if (ptl1 > ptl2) {
> +		/* exchange ptl1 and ptl2 */
> +		ptl_tmp = ptl1;
> +		ptl1 = ptl2;
> +		ptl2 = ptl_tmp;
> +	}
> +	/* lock in virtual address order to avoid lock inversion */
> +	spin_lock(ptl1);
> +	if (ptl1 != ptl2)
> +		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
> +	else
> +		__acquire(ptl2);
> +}
> +
> +void double_pt_unlock(spinlock_t *ptl1,
> +		      spinlock_t *ptl2)
> +	__releases(ptl1)
> +	__releases(ptl2)
> +{
> +	spin_unlock(ptl1);
> +	if (ptl1 != ptl2)
> +		spin_unlock(ptl2);
> +	else
> +		__release(ptl2);
> +}
> +
> +
> +static int move_present_pte(struct mm_struct *mm,
> +			    struct vm_area_struct *dst_vma,
> +			    struct vm_area_struct *src_vma,
> +			    unsigned long dst_addr, unsigned long src_addr,
> +			    pte_t *dst_pte, pte_t *src_pte,
> +			    pte_t orig_dst_pte, pte_t orig_src_pte,
> +			    spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +			    struct folio *src_folio)
> +{
> +	int err = 0;
> +
> +	double_pt_lock(dst_ptl, src_ptl);
> +
> +	if (!pte_same(*src_pte, orig_src_pte) ||
> +	    !pte_same(*dst_pte, orig_dst_pte)) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +	if (folio_test_large(src_folio) ||
> +	    folio_maybe_dma_pinned(src_folio) ||
> +	    !PageAnonExclusive(&src_folio->page)) {
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	folio_move_anon_rmap(src_folio, dst_vma);
> +	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +
> +	orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
> +	/* Folio got pinned from under us. Put it back and fail the move. */
> +	if (folio_maybe_dma_pinned(src_folio)) {
> +		set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
> +	/* Follow mremap() behavior and treat the entry dirty after the move */
> +	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
> +
> +	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> +out:
> +	double_pt_unlock(dst_ptl, src_ptl);
> +	return err;
> +}
> +
> +static int move_swap_pte(struct mm_struct *mm,
> +			 unsigned long dst_addr, unsigned long src_addr,
> +			 pte_t *dst_pte, pte_t *src_pte,
> +			 pte_t orig_dst_pte, pte_t orig_src_pte,
> +			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
> +{
> +	if (!pte_swp_exclusive(orig_src_pte))
> +		return -EBUSY;
> +
> +	double_pt_lock(dst_ptl, src_ptl);
> +
> +	if (!pte_same(*src_pte, orig_src_pte) ||
> +	    !pte_same(*dst_pte, orig_dst_pte)) {
> +		double_pt_unlock(dst_ptl, src_ptl);
> +		return -EAGAIN;
> +	}
> +
> +	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
> +	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> +	double_pt_unlock(dst_ptl, src_ptl);
> +
> +	return 0;
> +}
> +
> +/*
> + * The mmap_lock for reading is held by the caller. Just move the page
> + * from src_pmd to dst_pmd if possible, and return true if succeeded
> + * in moving the page.
> + */
> +static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> +			  struct vm_area_struct *dst_vma,
> +			  struct vm_area_struct *src_vma,
> +			  unsigned long dst_addr, unsigned long src_addr,
> +			  __u64 mode)
> +{
> +	swp_entry_t entry;
> +	pte_t orig_src_pte, orig_dst_pte;
> +	pte_t src_folio_pte;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pte_t *src_pte = NULL;
> +	pte_t *dst_pte = NULL;
> +
> +	struct folio *src_folio = NULL;
> +	struct anon_vma *src_anon_vma = NULL;
> +	struct mmu_notifier_range range;
> +	int err = 0;
> +
> +	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> +				src_addr, src_addr + PAGE_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +retry:
> +	dst_pte = pte_offset_map_nolock(mm, dst_pmd, dst_addr, &dst_ptl);
> +
> +	/* Retry if a huge pmd materialized from under us */
> +	if (unlikely(!dst_pte)) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	src_pte = pte_offset_map_nolock(mm, src_pmd, src_addr, &src_ptl);
> +
> +	/*
> +	 * We held the mmap_lock for reading so MADV_DONTNEED
> +	 * can zap transparent huge pages under us, or the
> +	 * transparent huge page fault can establish new
> +	 * transparent huge pages under us.
> +	 */
> +	if (unlikely(!src_pte)) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	/* Sanity checks before the operation */
> +	if (WARN_ON_ONCE(pmd_none(*dst_pmd)) ||	WARN_ON_ONCE(pmd_none(*src_pmd)) ||
> +	    WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) || WARN_ON_ONCE(pmd_trans_huge(*src_pmd))) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	spin_lock(dst_ptl);
> +	orig_dst_pte = *dst_pte;
> +	spin_unlock(dst_ptl);
> +	if (!pte_none(orig_dst_pte)) {
> +		err = -EEXIST;
> +		goto out;
> +	}
> +
> +	spin_lock(src_ptl);
> +	orig_src_pte = *src_pte;
> +	spin_unlock(src_ptl);
> +	if (pte_none(orig_src_pte)) {
> +		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> +			err = -ENOENT;
> +		else /* nothing to do to move a hole */
> +			err = 0;
> +		goto out;
> +	}
> +
> +	/* If PTE changed after we locked the folio them start over */
> +	if (src_folio && unlikely(!pte_same(src_folio_pte, orig_src_pte))) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	if (pte_present(orig_src_pte)) {
> +		/*
> +		 * Pin and lock both source folio and anon_vma. Since we are in
> +		 * RCU read section, we can't block, so on contention have to
> +		 * unmap the ptes, obtain the lock and retry.
> +		 */
> +		if (!src_folio) {
> +			struct folio *folio;
> +
> +			/*
> +			 * Pin the page while holding the lock to be sure the
> +			 * page isn't freed under us
> +			 */
> +			spin_lock(src_ptl);
> +			if (!pte_same(orig_src_pte, *src_pte)) {
> +				spin_unlock(src_ptl);
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +
> +			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
> +			if (!folio || !PageAnonExclusive(&folio->page)) {
> +				spin_unlock(src_ptl);
> +				err = -EBUSY;
> +				goto out;
> +			}
> +
> +			folio_get(folio);
> +			src_folio = folio;
> +			src_folio_pte = orig_src_pte;
> +			spin_unlock(src_ptl);
> +
> +			if (!folio_trylock(src_folio)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				/* now we can block and wait */
> +				folio_lock(src_folio);
> +				goto retry;
> +			}
> +
> +			if (WARN_ON_ONCE(!folio_test_anon(src_folio))) {
> +				err = -EBUSY;
> +				goto out;
> +			}
> +		}
> +
> +		/* at this point we have src_folio locked */
> +		if (folio_test_large(src_folio)) {
> +			err = split_folio(src_folio);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (!src_anon_vma) {
> +			/*
> +			 * folio_referenced walks the anon_vma chain
> +			 * without the folio lock. Serialize against it with
> +			 * the anon_vma lock, the folio lock is not enough.
> +			 */
> +			src_anon_vma = folio_get_anon_vma(src_folio);
> +			if (!src_anon_vma) {
> +				/* page was unmapped from under us */
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +			if (!anon_vma_trylock_write(src_anon_vma)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				/* now we can block and wait */
> +				anon_vma_lock_write(src_anon_vma);
> +				goto retry;
> +			}
> +		}
> +
> +		err = move_present_pte(mm,  dst_vma, src_vma,
> +				       dst_addr, src_addr, dst_pte, src_pte,
> +				       orig_dst_pte, orig_src_pte,
> +				       dst_ptl, src_ptl, src_folio);
> +	} else {
> +		entry = pte_to_swp_entry(orig_src_pte);
> +		if (non_swap_entry(entry)) {
> +			if (is_migration_entry(entry)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				migration_entry_wait(mm, src_pmd, src_addr);
> +				err = -EAGAIN;
> +			} else
> +				err = -EFAULT;
> +			goto out;
> +		}
> +
> +		err = move_swap_pte(mm, dst_addr, src_addr,
> +				    dst_pte, src_pte,
> +				    orig_dst_pte, orig_src_pte,
> +				    dst_ptl, src_ptl);
> +	}
> +
> +out:
> +	if (src_anon_vma) {
> +		anon_vma_unlock_write(src_anon_vma);
> +		put_anon_vma(src_anon_vma);
> +	}
> +	if (src_folio) {
> +		folio_unlock(src_folio);
> +		folio_put(src_folio);
> +	}
> +	if (dst_pte)
> +		pte_unmap(dst_pte);
> +	if (src_pte)
> +		pte_unmap(src_pte);
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return err;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline bool move_splits_huge_pmd(unsigned long dst_addr,
> +					unsigned long src_addr,
> +					unsigned long src_end)
> +{
> +	return (src_addr & ~HPAGE_PMD_MASK) || (dst_addr & ~HPAGE_PMD_MASK) ||
> +		src_end - src_addr < HPAGE_PMD_SIZE;
> +}
> +#else
> +static inline bool move_splits_huge_pmd(unsigned long dst_addr,
> +					unsigned long src_addr,
> +					unsigned long src_end)
> +{
> +	/* This is unreachable anyway, just to avoid warnings when HPAGE_PMD_SIZE==0 */
> +	return false;
> +}
> +#endif
> +
> +static inline bool vma_move_compatible(struct vm_area_struct *vma)
> +{
> +	return !(vma->vm_flags & (VM_PFNMAP | VM_IO |  VM_HUGETLB |
> +				  VM_MIXEDMAP | VM_SHADOW_STACK));
> +}
> +
> +static int validate_move_areas(struct userfaultfd_ctx *ctx,
> +			       struct vm_area_struct *src_vma,
> +			       struct vm_area_struct *dst_vma)
> +{
> +	/* Only allow moving if both have the same access and protection */
> +	if ((src_vma->vm_flags & VM_ACCESS_FLAGS) != (dst_vma->vm_flags & VM_ACCESS_FLAGS) ||
> +	    pgprot_val(src_vma->vm_page_prot) != pgprot_val(dst_vma->vm_page_prot))
> +		return -EINVAL;
> +
> +	/* Only allow moving if both are mlocked or both aren't */
> +	if ((src_vma->vm_flags & VM_LOCKED) != (dst_vma->vm_flags & VM_LOCKED))
> +		return -EINVAL;
> +
> +	/*
> +	 * For now, we keep it simple and only move between writable VMAs.
> +	 * Access flags are equal, therefore cheching only the source is enough.
> +	 */
> +	if (!(src_vma->vm_flags & VM_WRITE))
> +		return -EINVAL;
> +
> +	/* Check if vma flags indicate content which can be moved */
> +	if (!vma_move_compatible(src_vma) || !vma_move_compatible(dst_vma))
> +		return -EINVAL;
> +
> +	/* Ensure dst_vma is registered in uffd we are operating on */
> +	if (!dst_vma->vm_userfaultfd_ctx.ctx ||
> +	    dst_vma->vm_userfaultfd_ctx.ctx != ctx)
> +		return -EINVAL;
> +
> +	/* Only allow moving across anonymous vmas */
> +	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> +		return -EINVAL;
> +
> +	/*
> +	 * Ensure the dst_vma has a anon_vma or this page
> +	 * would get a NULL anon_vma when moved in the
> +	 * dst_vma.
> +	 */
> +	if (unlikely(anon_vma_prepare(dst_vma)))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * move_pages - move arbitrary anonymous pages of an existing vma
> + * @ctx: pointer to the userfaultfd context
> + * @mm: the address space to move pages
> + * @dst_start: start of the destination virtual memory range
> + * @src_start: start of the source virtual memory range
> + * @len: length of the virtual memory range
> + * @mode: flags from uffdio_move.mode
> + *
> + * Must be called with mmap_lock held for read.
> + *
> + * move_pages() remaps arbitrary anonymous pages atomically in zero
> + * copy. It only works on non shared anonymous pages because those can
> + * be relocated without generating non linear anon_vmas in the rmap
> + * code.
> + *
> + * It provides a zero copy mechanism to handle userspace page faults.
> + * The source vma pages should have mapcount == 1, which can be
> + * enforced by using madvise(MADV_DONTFORK) on src vma.
> + *
> + * The thread receiving the page during the userland page fault
> + * will receive the faulting page in the source vma through the network,
> + * storage or any other I/O device (MADV_DONTFORK in the source vma
> + * avoids move_pages() to fail with -EBUSY if the process forks before
> + * move_pages() is called), then it will call move_pages() to map the
> + * page in the faulting address in the destination vma.
> + *
> + * This userfaultfd command works purely via pagetables, so it's the
> + * most efficient way to move physical non shared anonymous pages
> + * across different virtual addresses. Unlike mremap()/mmap()/munmap()
> + * it does not create any new vmas. The mapping in the destination
> + * address is atomic.
> + *
> + * It only works if the vma protection bits are identical from the
> + * source and destination vma.
> + *
> + * It can remap non shared anonymous pages within the same vma too.
> + *
> + * If the source virtual memory range has any unmapped holes, or if
> + * the destination virtual memory range is not a whole unmapped hole,
> + * move_pages() will fail respectively with -ENOENT or -EEXIST. This
> + * provides a very strict behavior to avoid any chance of memory
> + * corruption going unnoticed if there are userland race conditions.
> + * Only one thread should resolve the userland page fault at any given
> + * time for any given faulting address. This means that if two threads
> + * try to both call move_pages() on the same destination address at the
> + * same time, the second thread will get an explicit error from this
> + * command.
> + *
> + * The command retval will return "len" is successful. The command
> + * however can be interrupted by fatal signals or errors. If
> + * interrupted it will return the number of bytes successfully
> + * remapped before the interruption if any, or the negative error if
> + * none. It will never return zero. Either it will return an error or
> + * an amount of bytes successfully moved. If the retval reports a
> + * "short" remap, the move_pages() command should be repeated by
> + * userland with src+retval, dst+reval, len-retval if it wants to know
> + * about the error that interrupted it.
> + *
> + * The UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES flag can be specified to
> + * prevent -ENOENT errors to materialize if there are holes in the
> + * source virtual range that is being remapped. The holes will be
> + * accounted as successfully remapped in the retval of the
> + * command. This is mostly useful to remap hugepage naturally aligned
> + * virtual regions without knowing if there are transparent hugepage
> + * in the regions or not, but preventing the risk of having to split
> + * the hugepmd during the remap.
> + *
> + * If there's any rmap walk that is taking the anon_vma locks without
> + * first obtaining the folio lock (the only current instance is
> + * folio_referenced), they will have to verify if the folio->mapping
> + * has changed after taking the anon_vma lock. If it changed they
> + * should release the lock and retry obtaining a new anon_vma, because
> + * it means the anon_vma was changed by move_pages() before the lock
> + * could be obtained. This is the only additional complexity added to
> + * the rmap code to provide this anonymous page remapping functionality.
> + */
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> +		   unsigned long dst_start, unsigned long src_start,
> +		   unsigned long len, __u64 mode)
> +{
> +	struct vm_area_struct *src_vma, *dst_vma;
> +	unsigned long src_addr, dst_addr;
> +	pmd_t *src_pmd, *dst_pmd;
> +	long err = -EINVAL;
> +	ssize_t moved = 0;
> +
> +	/* Sanitize the command parameters. */
> +	if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
> +	    WARN_ON_ONCE(dst_start & ~PAGE_MASK) ||
> +	    WARN_ON_ONCE(len & ~PAGE_MASK))
> +		goto out;
> +
> +	/* Does the address range wrap, or is the span zero-sized? */
> +	if (WARN_ON_ONCE(src_start + len <= src_start) ||
> +	    WARN_ON_ONCE(dst_start + len <= dst_start))
> +		goto out;
> +
> +	/*
> +	 * Make sure the vma is not shared, that the src and dst remap
> +	 * ranges are both valid and fully within a single existing
> +	 * vma.
> +	 */
> +	src_vma = find_vma(mm, src_start);
> +	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> +		goto out;
> +	if (src_start < src_vma->vm_start ||
> +	    src_start + len > src_vma->vm_end)
> +		goto out;
> +
> +	dst_vma = find_vma(mm, dst_start);
> +	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> +		goto out;
> +	if (dst_start < dst_vma->vm_start ||
> +	    dst_start + len > dst_vma->vm_end)
> +		goto out;
> +
> +	err = validate_move_areas(ctx, src_vma, dst_vma);
> +	if (err)
> +		goto out;
> +
> +	for (src_addr = src_start, dst_addr = dst_start;
> +	     src_addr < src_start + len;) {
> +		spinlock_t *ptl;
> +		pmd_t dst_pmdval;
> +		unsigned long step_size;
> +
> +		/*
> +		 * Below works because anonymous area would not have a
> +		 * transparent huge PUD. If file-backed support is added,
> +		 * that case would need to be handled here.
> +		 */
> +		src_pmd = mm_find_pmd(mm, src_addr);
> +		if (unlikely(!src_pmd)) {
> +			if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
> +				err = -ENOENT;
> +				break;
> +			}
> +			src_pmd = mm_alloc_pmd(mm, src_addr);
> +			if (unlikely(!src_pmd)) {
> +				err = -ENOMEM;
> +				break;
> +			}
> +		}
> +		dst_pmd = mm_alloc_pmd(mm, dst_addr);
> +		if (unlikely(!dst_pmd)) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		dst_pmdval = pmdp_get_lockless(dst_pmd);
> +		/*
> +		 * If the dst_pmd is mapped as THP don't override it and just
> +		 * be strict. If dst_pmd changes into TPH after this check, the
> +		 * move_pages_huge_pmd() will detect the change and retry
> +		 * while move_pages_pte() will detect the change and fail.
> +		 */
> +		if (unlikely(pmd_trans_huge(dst_pmdval))) {
> +			err = -EEXIST;
> +			break;
> +		}
> +
> +		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> +		if (ptl) {
> +			if (pmd_devmap(*src_pmd)) {
> +				spin_unlock(ptl);
> +				err = -ENOENT;
> +				break;
> +			}
> +
> +			/* Check if we can move the pmd without splitting it. */
> +			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> +			    !pmd_none(dst_pmdval)) {
> +				struct folio *folio = pfn_folio(pmd_pfn(*src_pmd));
> +
> +				if (!folio || !PageAnonExclusive(&folio->page)) {
> +					spin_unlock(ptl);
> +					err = -EBUSY;
> +					break;
> +				}
> +
> +				spin_unlock(ptl);
> +				split_huge_pmd(src_vma, src_pmd, src_addr);
> +				/* The folio will be split by move_pages_pte() */
> +				continue;
> +			}
> +
> +			err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
> +						  dst_pmdval, dst_vma, src_vma,
> +						  dst_addr, src_addr);
> +			step_size = HPAGE_PMD_SIZE;
> +		} else {
> +			if (pmd_none(*src_pmd)) {
> +				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
> +					err = -ENOENT;
> +					break;
> +				}
> +				if (unlikely(__pte_alloc(mm, src_pmd))) {
> +					err = -ENOMEM;
> +					break;
> +				}
> +			}
> +
> +			if (unlikely(pte_alloc(mm, dst_pmd))) {
> +				err = -ENOMEM;
> +				break;
> +			}
> +
> +			err = move_pages_pte(mm, dst_pmd, src_pmd,
> +					     dst_vma, src_vma,
> +					     dst_addr, src_addr, mode);
> +			step_size = PAGE_SIZE;
> +		}
> +
> +		cond_resched();
> +
> +		if (fatal_signal_pending(current)) {
> +			/* Do not override an error */
> +			if (!err || err == -EAGAIN)
> +				err = -EINTR;
> +			break;
> +		}
> +
> +		if (err) {
> +			if (err == -EAGAIN)
> +				continue;
> +			break;
> +		}
> +
> +		/* Proceed to the next page */
> +		dst_addr += step_size;
> +		src_addr += step_size;
> +		moved += step_size;
> +	}
> +
> +out:
> +	VM_WARN_ON(moved < 0);
> +	VM_WARN_ON(err > 0);
> +	VM_WARN_ON(!moved && !err);
> +	return moved ? moved : err;
> +}
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
>

