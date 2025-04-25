Return-Path: <linux-fsdevel+bounces-47352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88909A9C6A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6B4C42BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D33723FC49;
	Fri, 25 Apr 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="STYEzj/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vcUcscQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8A1FA272;
	Fri, 25 Apr 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579089; cv=fail; b=Cinprd4DZ8KkwSWtRXxo8YPefOSCUBOAL+RgB23PjsG2yGPD4cPvK6QM4LsnPbJ4lR87MI3sjmvLmK2EulXWy3NITTkvyhF3yjj+/v73mwesr52ADaENwfh2W+XxF88tIHFlV8HdPmJDycguaYacRefb80isj+WDwTrt5clf5VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579089; c=relaxed/simple;
	bh=GmfJ4B2nZefOmcsAIT7jgl859ozKGQ/nUhF86B/xvPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u2KAmFrIAyOGGfHjnR/WLLhIY5Xxf+k4Yy21d8MnKEZVsnr8aFsQHy7sjRuIKWGI1JzAq9STDx5tNifKAOafjPfUWcgIZZsKuCl94ZBMa2/Zu5dlMDAnjrYRyWcdbgTG6d1zvTKMNPE6JRor3+I3+JklIz2hEml5gJTvHIwlit4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=STYEzj/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vcUcscQb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PB205W031080;
	Fri, 25 Apr 2025 11:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ce/lLPiVFnM/6hTo5qGeVySHwKDAlrpbsIcEjL7tLXg=; b=
	STYEzj/5xTsKaErr0Yi95NzBp50gMjWg1N0HPOqNIrigAm9a6Mzf3TLh9KZmiCKv
	NiijjcAYcOLMIIcapHnmF0Xaeb4gMc8yi3u5hoook1yI5vfhOAvkosp4klbR1+4T
	v0iGYp23aO2pLxrFDj3YVJCnn2Vyr5xUflyRfGyR/kJuJI8XbMhIBzwg9yVn1E0r
	h1I4ftXC1iugrS9mQfsgroq47d1YOStL6cnef2GlLMf0+ujAfFTLBrcPd2o+cbHz
	NnCPJADpq9CyiPGdcy6I/ojYCcC8IKWbd+5fbOzkJZIqG0mKQzYWeiW9EGxE6Dvx
	rUbqEv0jY3TpHJPcuevCag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46895kr15m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:04:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAUnx3030926;
	Fri, 25 Apr 2025 11:04:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08fvwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCqRuYnMBnXC6vfns92cOG6KVWUVVmOHKt1AxAAx1PfXbUP3CcpgTQRzPO9xB6LqHVCk6kIEV6Vd+KiHS7xncpjy26/T0XvoRxz7WoUv8S1Xv54ExJhfr1LS4jNI44sewYsela2ftJmxZztj8I8qxCRVwsI2Ni61qqheQ6xWvMSyhSJfjbeVo32Gxs9fAb0lNlq1F6BK1Fxv3IOqnoMKm39F1gWsBehgAzosFYsfWnVTpQ2APwjeAcXPUoP3U2TEo8N3CkCp0THvFtOjISOOVTiDSK2xkxHuZCHB5KkQ5bsGo7vn44Bu9TJ2FPG4Pa31uVlGHUT/4IpgI1M3+IvdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce/lLPiVFnM/6hTo5qGeVySHwKDAlrpbsIcEjL7tLXg=;
 b=gh85Xvpc/WMkQdaFggUGtJWJhj4Z3xmVg1dko6RiK6o1yr1OcvFDfx1s2a0vnaE1lgMxxMfln+YNZgCZXpj3pgpi0GrEfocCcHL/NLqV3NfBlITjx+wQR64tDjdIQZPKvW4YGTUcw+ZQHP5gEAacm3UQH3YfyGulK39ElIldDsOhXxZLhd0HIaGaGL/hDHlbf6SHA2eSkdXj2kut/LrQxy4Mlzl6+hgC/BucD6dK1w11YFp9UzFN5kcXmkhJHF/O7gHS374J56jftAl3qDqpmU/klOyUpqJG21e2j663nfuR3D5/IPvwO+e0I0Lvj7QjC3/kXZMdAwEWs1yoaKQ3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce/lLPiVFnM/6hTo5qGeVySHwKDAlrpbsIcEjL7tLXg=;
 b=vcUcscQbjJ2CNWeD8ZyogABhN8rhnDtUgk6sOWAvZ27FC5c47RsOXh1cBXd5rSfF5tU3LWUnMNtUKJ6eEGfiX8Eb2KhT/LqONNOZ5SIWIXjF26AfSCXTvhMgLgzDLOa7/UUWyKZFNq453pdUhJA2VCVcYtByyCjvGneW0FXanoQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5205.namprd10.prod.outlook.com (2603:10b6:408:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 11:04:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:04:20 +0000
Date: Fri, 25 Apr 2025 12:04:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <d745fc31-155c-4b1b-9f02-17e68f6c571e@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <CAJuCfpHxWwEiZdX-xrxe7J+Q20otPTPs4NR-oJBSnL7HNt-f2A@mail.gmail.com>
 <365487db-b829-47ee-8f5f-6cba873daae8@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <365487db-b829-47ee-8f5f-6cba873daae8@lucifer.local>
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 088a52a8-2844-48d9-1140-08dd83e8edda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUZqRG0remNkRENWczZWdTBDRXVqS0xlVmJtWFMwakIzRkNzRUFVYzBrUWRH?=
 =?utf-8?B?QzhNNHY4NHRmcWFldE56VFR1NHhjalRXU1lqSGIyV3dBTjR2QzI1MzJKZzBJ?=
 =?utf-8?B?VEMvRElrWHpzK2RDVGkzRWJRU2t6dGtjK1lyUlhYZVltSk9OSVVvK0l5dVph?=
 =?utf-8?B?YXJaa21rNnlvTjI4ZzlGK2tHMHk4dWlXQ1BXNWhYdFljVjZTbDNQbDAvZmVt?=
 =?utf-8?B?TytvMCtYMVd6MVFDaEJWaHdWWkdVdEZZcW80bGR1V2lobjRhUlBUKzFQS2xN?=
 =?utf-8?B?aExPVndpOW5kOHZFeU85QThsd3FmUUlzTUtha2lYRWkyWFluU0s0ZG5yNUNY?=
 =?utf-8?B?NzQzSGNjaWJiSVZPSHkvRDZXUkhsNUpEdU5xdmkwRzJkMzdkdUg5dVJ0UlVC?=
 =?utf-8?B?VXZLbnZSTUI5Y1pIWWFCQWk0TzFvTVpadjloVjlDamJOUjJ0M01rZ24rTFJI?=
 =?utf-8?B?ZDBuN0V5ZHIxN1BzUG1LSXp4aUZ5b0FMdUpmU0dqYXJpL2xRR2QyR0dpSEtL?=
 =?utf-8?B?S2RqVXlXbjFCNk4zZkphWGRsbEtycVFadkJ1ZCtyVjNVS0NiT1ZYd0h4b2xr?=
 =?utf-8?B?aFFuOG13clVaME5uN05yUjdQdFRvVytkWTZkbGVHenQ2L1hZVWVIWGdOODVy?=
 =?utf-8?B?KzFoWXFnR3g3L2huTTBwckNmZlpkV3hEa3FsUmJTcVlOcDB2UGVoN0ovTmhl?=
 =?utf-8?B?dEpheEJyaGR3aFNacEtOc21zVDgrdXJZcmVzTjlvQVNac1lNMnpZbTE2L1ly?=
 =?utf-8?B?OFE4bW16WHE0d2ZvcHlTNC9MSjd2TEwzT250WHZVNmRqK0dCR29reFIrTXdY?=
 =?utf-8?B?ZngycXV5VDRvWGExMUc3OU5EdmRJUnJjVnYrck1TQW1zNmZveGdzNkN1MTFq?=
 =?utf-8?B?VlRqYjQra3haeXdBbnVFY3phNTFFTlZIQ3Vlc1F5SWI4blN3T20wOFdQT0Qy?=
 =?utf-8?B?YmNHZlVVcng1N2NnMFlaSEY4Zko4Mk1zdUR0TE1vaEhsZFUraU52b2EzdXQy?=
 =?utf-8?B?Y25laEpGWVBobjFpRGM5aDlOUHhQQW1YWWRzSm5WaG9IMkFEZmNiUE1weTkw?=
 =?utf-8?B?RFVIM3lVdVFtOVYyMlBucWFaVWFsdys5U2NsdGVNY2JPd0c4WEJYNDRTRUlS?=
 =?utf-8?B?bWIxRWhlbU14TWtMTlFFRjRoWUMyZjFJQVAxcUw2R3RvVDBPUXV2Ny83QTds?=
 =?utf-8?B?aFpZaHhUeEZGTjRjUkUvd1pCQjYxWUJpNEJYUTROZ2lkWVVFMXRMc1hOUWdi?=
 =?utf-8?B?VUxmM0w1a3N1eWpISHA3NEFzdXMyQ2VRd3dIaUllSldoL1BldXdTMkNtZmRZ?=
 =?utf-8?B?eGc1bEpxSjRhTzZBVzZCMWpsZzhtS1JHakN4OEtGVkpqVnlubE5jdzFCdUxp?=
 =?utf-8?B?Y3cyQlRjbDR4d3RKZjFsaVJWSUFwRmc4VEJqdmVYMWYzT2VJYUhUc1hhQTQ4?=
 =?utf-8?B?dkVMZzIrWGhGbHpKR3BEdDR3YW9Rbms2eUNzVzZ6N3BLSHdMSWhERU1hcTRl?=
 =?utf-8?B?R3N5OElqVHdzZUxWTlcvZnFKbnhoNUswK0ZPcFQ5cGlsTVhVVUladk1zNmFz?=
 =?utf-8?B?aUpSSzNHMzhORi9vQklrcnUwNjdGQjIvZ1JEcDNuMzhQV2VEVjYwaTF5eEkx?=
 =?utf-8?B?dEZIaXZRVGpIbk9pQ0hPRmc3WjVwbEZma1liQzZ4a1h5YThLTnhmUUxFTjRC?=
 =?utf-8?B?WGREd3FaMlEzM0xxakY2V3pDaUFkU0M2VXUwb2JUV0tuUmI4ZzVIbWE3OTAr?=
 =?utf-8?B?Tyt6cE42cDVvR1JvZWFPSFpXanJrSHBZN3BrVjFPNDZNd2YxbHJsUW51UlV4?=
 =?utf-8?B?aVNOaUNHVzRZNlIxL090aHZKREJTNnh4WENGb0xLWlpBTUJQeFgzakhFem52?=
 =?utf-8?B?TjFLZm1iRFF1RHNwb3FaWEV0ajZ6ZFBBU3JFTDRZVU5pNlFicXAzbnhiTlhP?=
 =?utf-8?Q?kq/qcl2FwOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZhZUcydUY1ZHluVGloQXl6dGVxeWdWeG9ieDloYnNHUVJMaWliRmtTM2M4?=
 =?utf-8?B?azlvcEh6VzZzZlRFakJuaTd4c1JoUHg3aDY1RE9yK0cwQlJkdlI2R0ZqRkNJ?=
 =?utf-8?B?TlZDNlhqSW5zMTc4OGZkS09sbHJjNWhpVnR2Vk9KdllzMWxkNVM4TFQrL2c2?=
 =?utf-8?B?TlYwd0hKUVA5WjdNc0dRSW1NYjhubGlOUjhnb2sxRkttSFlub3FrVHVvQmNM?=
 =?utf-8?B?ZllWZGRWdmlOam8vblpjamNzL1NIcSt3V1lWQWZNb1pRci9xcTZLNjZaWGds?=
 =?utf-8?B?QmhwMnQxTUtNOG11RnZXdldWSkFvamxNdVh3aEdKc1FXVFF4YkFLRUFINWxS?=
 =?utf-8?B?TWFmbmI5SFFDbFJNTTUyck5NQy9rZngrYTI0MS9tYm9xT2RwUnBualljZ3dq?=
 =?utf-8?B?WnFjak9MMy9RS3FZVFgyeE1vWWV4aDNVVHV0QkJFa1VwTUNBRmc3SnZ3NDZs?=
 =?utf-8?B?MzR5aE9pODhWS2YzK2dJbWVwY3ZsVDFDcWxmTUFPZ1c4V2hZZXlGK2hZaTgw?=
 =?utf-8?B?czcwRHdZeTZHLzNHYnBjQ1Fod1lFV2Rha3llQ01wSDZaRXNpNkhrOHRzeWEr?=
 =?utf-8?B?Y0pNamFVeHI1SHo5OGF2dXVDeWJFWGI0NWViV2VOcGxXeWVucWZCaGN6ZVA1?=
 =?utf-8?B?dEFRYkd1bi9jVUxLVEo2aThKNC9PY2xqV2FWdlRmZlhxQkZ3TWRmYjNNY0xk?=
 =?utf-8?B?SzdlNVFRWkg1THdzVXl1TFZMWWhuSFhZUVZWWGpJZGxPNlFSaGpXY04yYS9v?=
 =?utf-8?B?VnFZQXQ2YlF1d1hWMytEZnhKQTNpQkpYT2lpbmQyaWN1YVVRRnRhaEJIcjdL?=
 =?utf-8?B?WVNzYWIwNTV0N3Q4Nk9yVEJ2MUpMNkpWbkxpanhya2pOdTV4WnMyaDRHUDVi?=
 =?utf-8?B?NWJ6bktPTUVndzg2N0JSbnMzWkE2TE1Vc09NdGFvdTVqTkZDVlVZRHdCbkJI?=
 =?utf-8?B?TU8xZ1RKa0VZMmZMdHBvOEJEN1ZaYit0bVFqdW5rbkV6c1ZWc2VEVlpsdXZs?=
 =?utf-8?B?YTE4SHJHRExSZlBCOEVoaGVIQTBzdnZicm1URTVKZUt3MG0wVTA4YkkxempF?=
 =?utf-8?B?aFJ5d0lMbXQ3UkZyWGNTZXJGWWRQdUhib3ZmaHBrYWhkRWFGYnhSdGJnZEkr?=
 =?utf-8?B?dnB0RjU4MzY3b3NBcWcwMVhmL1pQQUQvQlVLMnlCdWRPUWFIVkJidUJteG9Q?=
 =?utf-8?B?d2oyWUw0VlA4OU9DRGpvSGdPTWp2TXVGekFCK0NJRStWaVhLZWF2dE9jQ3Vk?=
 =?utf-8?B?RmZxekh2VXpQbmM2S0xRZ2RJWDNCZkVuMXBqTTlDL3d0dkt4M3A2em1kS1NY?=
 =?utf-8?B?TlRYQTBRZDczOFh1YlFWRmNNeTdtc0NZS0xrQXgyQ1U4Y0lqS3M1ZDNybXl2?=
 =?utf-8?B?MFhsNGRrWTlvT1RxdjBPSlBpWVJLSTRFQXgxYjgxOXd0RjZMZWl4N1Vhbk1k?=
 =?utf-8?B?am1CYUxnKzJNVGZwZThFa1dIM2dxTHFBR1Bud3pDNWlVclZKVDhkTUora0lh?=
 =?utf-8?B?c21sc29ha3ZXdHRJamFhSHpwbmt4ZTlraDRuQmxDUGdSVDVoRGI2MHQ0ZU93?=
 =?utf-8?B?SzVENnBzUm5JMjFXVXh5d2hEM0VBQm9oNXhTYWtVRzdEVU41TkNyQ25SdFFO?=
 =?utf-8?B?STFGZnRHK2lOd2t3cENHN0k4Q0ZDMWc2UU5USXVoRm9LY3hza0hhbGFaenRN?=
 =?utf-8?B?ZGRJbjZWajJDZ2hJNUpKNzFUaVBxdlFxREl4KzJPazVtSFl2S1QzT0EyOW4x?=
 =?utf-8?B?RW5xdThnTXpKajEyc1V3aFpkTnRrR1Q3eGhPUTJWamN6OWs2ZmQ3c2lQNHAw?=
 =?utf-8?B?NVdOVFN1dFk3TkJ0UFZMakxsalVnY3ZjemNtTXdiZ1QwVFlGUk5nQ1ZtSVgv?=
 =?utf-8?B?SUR2Z2NGYnBwbEFRTS9WZCt6MGdTRTVTN3lUTXhrMzZQSTNVZkxBdDUvbHVk?=
 =?utf-8?B?R1NQVXdDcHlJVDZKaSs3d2s2eG9JMW9tdUkyemh0b1E1Mncyc0tIUXlFcFNF?=
 =?utf-8?B?bnRaRHlaQ2dKZjVqQzc4MXE1US84ZG9hdk9RU0p4N3NneDRmdExEb2RQYVkx?=
 =?utf-8?B?QnlmaEU4akh0YjhpSWp5YUxCK1RkSWRWYmN2YTd1YW53MEZPRVF0c2ltMXFH?=
 =?utf-8?B?SHpiWS9tZ3BnNWN6dWVUcWtYMS9tcjRoYkFka3ltSlJ3Zk5kUVhzTGF3MjRm?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KpOiut4wiwnWpNQdpHp8u8lsAAWA14FUgSu8nuOo8cWGuZivA4HBjJcrYC/5t1GN6QyYZeGzYUigZv5IjhFid/832NjYnstoJttNS9cR6PvkxktOiDgd6oPLPYzSmoscU87CKa0bGGnWYBnGVj1t9skbfg6F3/lHpUGxU8cJqMe0QRTbJOoMPLidk0TJg1txOpV1HCycZfPUobx4a73zAs5k+VaIGk8NYnGi16yeJWLiPjxWgo4hLosOe4JYlIqRAbPpEaTmTlIanIi2T9+RjMXeclQE106HHIlUDc6buXDa+SeasJrO2GkeznYfJdjRqeOAs/KHknxBgC/FKcw4/irKpWpx65TR22LM71H7xiT4sG3NYiEd19yNzP9pqaE/i+VudsD4ImI7bDHaMEhJjyAMZkpClKsKnbaJfBHFKxEWiip6wk6MGc3JFddZdqC/qMoRMj7VZgg4juEGL2vmpc41QXKVImFwkE/ge0XI4x2BSO2MJ2P3TxV5CgRnGV96Iqch7KcCVS4YYZcN5b8tOeO+T7UntW5Rnix+O+YS69K9ljZCLbbvF0oURcrD3sl+0vVqmQvX4285vAFRBwGERZjYr4Z5CWo6j0Ibp/ZQcVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a52a8-2844-48d9-1140-08dd83e8edda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:04:20.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IB2EIVd1NRlq/+LfgFOK98rgF/Kc56ryePUSBOKz0hCimcj2RtOMx+qitpo8qZxs72SiFEYPcwzey/d+A7f8OgiTwjLr6c+ut7+usJX7es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MCBTYWx0ZWRfX9qMoX5mMlqj6 tLFBJZTD92NU/1Bkr9L9FFCUZhsXp5gTJAnjsq6380YOF27BbM3OEt57Cx7+iQsooTAIR9vY4ii H33IDSiR8zE7Zw0FPRRsXX+MC2kjxr2wgoIBroYegqcfDS38RzCGe3/38AeRpRcoanCbim+Zu5J
 vc5c01XQXwMFI0UkEMwfCNEjw5DLop9siKuQBaPXn0g19b5SCxaigLrLUoVsYUkhxcAsIdMFupg UnekO4003zyv+Dj7NlL6h8cX/Ra90e1nNHSsSjqb7aNF7F7kIKauBqHFVHejD9s0smwIG7iUI1b iGAOdj3bq9PmxLN4SKvH+lTMNViNBm7tlL8HcgfpDu/BltZA8Rp2nBwJyIoLpwRu8AvYiLN32fL q9Z5F5Gs
X-Proofpoint-ORIG-GUID: zSHD1jy7_jy3pZhNPJqmzE3H-KqbwhjP
X-Proofpoint-GUID: zSHD1jy7_jy3pZhNPJqmzE3H-KqbwhjP

On Fri, Apr 25, 2025 at 11:10:00AM +0100, Lorenzo Stoakes wrote:
> On Thu, Apr 24, 2025 at 06:37:39PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Apr 24, 2025 at 6:22 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Apr 24, 2025 at 2:22 PM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > > > of separation of concerns, as well as preventing us from integrating this
> > > > > and related logic into userland VMA testing going forward, and perhaps more
> > > > > importantly - enabling us to, in a subsequent commit, make VMA
> > > > > allocation/freeing a purely internal mm operation.
> > > > >
> > > > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > > > CONFIG_MMU is not set, and there is no sensible place to put these outside
> > > > > of that, so we are put in the position of having to duplication some logic
> > >
> > > s/to duplication/to duplicate
> > >
> > > > > here.
> > > > >
> > > > > This isn't ideal, but since nommu is a niche use-case, already duplicates a
> > > > > great deal of mmu logic by its nature and we can eliminate code that is not
> > > > > applicable to nommu, it seems a worthwhile trade-off.
> > > > >
> > > > > The intent is to move all this logic to vma.c in a subsequent commit,
> > > > > rendering VMA allocation, freeing and duplication mm-internal-only and
> > > > > userland testable.
> > > >
> > > > I'm pretty sure you tried it, but what's the big blocker to have patch
> > > > #3 first, so we can avoid the temporary move of the code to mmap.c ?
> > >
> > > Completely agree with David.
> > > I peeked into 4/4 and it seems you want to keep vma.c completely
> > > CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> > > IMHO it would be much cleaner to move these functions into vma.c from
> > > the beginning and have an #ifdef CONFIG_MMU there like this:
> > >
> > > mm/vma.c
> > >
> > > /* Functions identical for MMU/NOMMU */
> > > struct vm_area_struct *vm_area_alloc(struct mm_struct *mm) {...}
> > > void __init vma_state_init(void) {...}
> > >
> > > #ifdef CONFIG_MMU
> > > static void vm_area_init_from(const struct vm_area_struct *src,
> > >                              struct vm_area_struct *dest) {...}
> > > struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> > > void vm_area_free(struct vm_area_struct *vma) {...}
> > > #else /* CONFIG_MMU */
> > > static void vm_area_init_from(const struct vm_area_struct *src,
> > >                              struct vm_area_struct *dest) {...}
> > > struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> > > void vm_area_free(struct vm_area_struct *vma) {...}
> > > #endif /* CONFIG_MMU */
> >
> > 3/4 and 4/4 look reasonable but they can change substantially
> > depending on your answer to my suggestion above, so I'll wait for your
> > answer before moving forward.
> > Thanks for doing this!
> > Suren.
>
> You're welcome :)
>
> Well I will be fixing the issue David raised of course :) but as stated in
> previous email, I don't feel it makes sense to put nommu stuff in vma.c really.

UPDATE: As per discussions with Liam, will be going ahead with an alternative
but equivalent approach.

Thanks to both of you for your suggestions on this!

Cheers, Lorenzo

>
> >
> > >
> > >
> > >
> > >
> > >
> > > >
> > > > --
> > > > Cheers,
> > > >
> > > > David / dhildenb
> > > >

