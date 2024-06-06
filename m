Return-Path: <linux-fsdevel+bounces-21130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D708FF44E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1622D1F27276
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F2199390;
	Thu,  6 Jun 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bPASKQJu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pqza4Qjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3F16FF26;
	Thu,  6 Jun 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697261; cv=fail; b=A/O4fGx5YngS/OCn92mQTAY6VQdMO1Zjxfjbh1XezhyNmgqAthYQ+syc5VVlND9+0kml2ihMgOSSIPGlOZ8/Z+15ECS/2pHkh56N6N97/Uyk+69u81oMnsHRo06wSCnHzdSH0a6dHxwdegPU+PFBdshGrlECVWJZ9Y5OEqR9ErE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697261; c=relaxed/simple;
	bh=8h+dYpCC0ryakU/S2IR45s6lv+VKsPNuQPK0d6rdqKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5sfwXHOhJvfDb2BGccrCY25AzxQWH6wvlsiwTST+NbbpyAzvd3fqgKx3u+zEZt9GGhlqc5pvGFAiivuuRbSg8TVxo+vMd1n0yntjh/vjoqeqPSi0xVBXpqIuUhV5fqmbPFi9JWy5qEfiSCeE9d99ASWDjleD18zw6z0z6/EwHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bPASKQJu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pqza4Qjl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456Hwoto026885;
	Thu, 6 Jun 2024 18:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=K9cq+K48rT/yzy8DjI5bedmr3KH/a9KOYrxgzORzb3I=;
 b=bPASKQJuVHhoqeBaQKkl1ICJU1LAxOSESTA2urlgTXr0EMOsNQxhqIxqt3x555FnbcWd
 tY7cJU8e9Nkn0jfYLyEmONkdQP+z1kgmuMkIxkwzTeHMY1fVkSnuUk/OXPWDML6/AETs
 XV07fK47wiauIMWcUvJ9sNKLNljdgmUHh2dBKXK2mXljUXtfgGziPKXL62zZDrqLVIiD
 HpKP4Z7bFEzYnaPmprv+xlLHBLMzsuczX0gLCIzMH9pet+MH9tK2nAN49oA5aF2h/jlq
 +3ounv6MYhXuRBhYjnU0dIk69LGwaqrHk0TkmykGTvpG+1/4JYsD5ZtBn1KjEYCG3+XT 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ykct30r71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:07:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456GaHUc020553;
	Thu, 6 Jun 2024 18:07:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj5gqqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvxfSZNNys1Kv7jhhYvyevKcp+caR/bgR0MKsEClbPA/S7yvfWfN/e4lfUFw2r/6Sy3Cp3OTHS1RZ2u8WdotN38ICbC55JYzW9DevzLsp1v1WSjHK7gyKtYKgdOKb00i73Ipk2eIRkII9KtlovPW4MgfLFRnKZAnjo4BpHi9Ya6PWdKmZYAqe2Zx+Gs5+dhEZep+aohO7oVfCMA7xsEr1rAcl54x8H2cUAgqSqSaM5ugv65Eg41MA59VllCNd/dIfi/UuCwkCEUBkLxlbeZtwZzdRG3iaz/Pr5vBEbyOVBKLyeTHwbs9V4PNcGYNEqmKmv6va2EJwcr1QOXcjCcjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9cq+K48rT/yzy8DjI5bedmr3KH/a9KOYrxgzORzb3I=;
 b=gPOH8BkeXa0IIn3z4bQ8wszIDGUXrG8Jvd1Czo93UNUYrrnC3b6NG17OcxwRdQDHwixhoEUxIir0Vj5tfnbEPRZsVF+noiax/bp/uV8PGG/OOugoW1r80VVgNH3dbJ6BT8UnpxozVta7181Lw9zc2NpmyKbRl9EjtpcYaGvS3TKGh6eGeXmwlpx3BTkTPd5Rhc/P8LiPlMNgV/EKR486n4q+HnPX2wyYgEE8j01JWoYQXU/3NsLgxKifYcWEKAC+APtD4aW+pv7RiMpE6PBVpgFvQ11Li0mvVO/0Cl2MoDQb4oMlu2ZSKnvlIwfIVSxH9qaBfbl/7PFOxevFdZ3I/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9cq+K48rT/yzy8DjI5bedmr3KH/a9KOYrxgzORzb3I=;
 b=Pqza4QjlrZ2rHSaktZXqEWT/zE8HcojHh3Qj11CLro/zqXWJ4bmZyzjGVfdCcZ0u3x1MfvVMt7KoBv9EsGGei//dmYRHtYLHDhBFp+PsWocQO/XaHQcHxch0xEOlwuV4Rrf58g8tIeK1+N0WZ5zMv7Z87jRDYcaYwv2ieN1blNg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 18:07:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 18:07:22 +0000
Date: Thu, 6 Jun 2024 14:07:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-mm@kvack.org, rppt@kernel.org
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
Message-ID: <rcjhp7lo4h42biynqf7t66vlcqemg7gucn2sbgmbdfycdpq3lr@isljix7btf7k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, rppt@kernel.org
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
 <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
 <ue44yftirugr6u4ewl5cvgatpqnheuho7rgax3jyg6ox5vruyq@7k6harvobd2q>
 <CAJuCfpEFpd-+DDr=EyA1gMKZcDZYpZN9pBuFczhVXrFSe11U_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpEFpd-+DDr=EyA1gMKZcDZYpZN9pBuFczhVXrFSe11U_g@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0445.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d9ea30-7096-4b57-03cd-08dc86538317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aU1VRTUzTTFxZHJoN3k2cXJETVpmM0RSeVd0UHFpR0xDaUZiUzlEYkwvcnV6?=
 =?utf-8?B?TElTSHBIN29CcVlFRkVKaURqRkJTUHVUU3RFaGlIdG5mL0N3NWZIb2VOdzFR?=
 =?utf-8?B?bVMyb2M2OXFaRU5pVWhzeCtZZmwxVGJVM0lMdzRTUTlXaFo0OGRzRTNQM3oy?=
 =?utf-8?B?cTIyb1lEbVY0MzRqZ2JkN0tkVDZYeDMrTis1eVhzUUNoMGJGbmN1Y09menJs?=
 =?utf-8?B?RGZDNkt4VExxQ3NBYWhQQ2dpazMrOXJhRDFsbUV1WThQaU13dFladlBvRkR0?=
 =?utf-8?B?QzI5WXVabGp5SWRzYlV1Ky9talE4QnRNYkFud0xKNEIwOWZyOHVQb2FGWTJp?=
 =?utf-8?B?VnF4NU5XcU90dWh6SGVTVkx6dmozenhWUFlXS2c3TVJhUkhaZkllYm0rblJF?=
 =?utf-8?B?d3lWbnBLSzdycFQrc2VWSHM3UGFUNUppR1crcituL214d21ydStleFpJSHJW?=
 =?utf-8?B?WmtvamNRUWhEMGVvZkhtcTNOUUhlL2xQVk1yRDFaSmY0d2lreTI0dzhBN1RI?=
 =?utf-8?B?L0FLWEdDVlZpVGU4WnIreHgzdkNZSGpzQi9zd0NNdEJVNkFQSmxFd08rNncz?=
 =?utf-8?B?SnFKaGVhQ3Vnb2RqTUFIb0xqNnB0K1RUWkgvZktNS2RkalM3YzRadzF0SGx0?=
 =?utf-8?B?TjhNWEh4RVlVVWVXekFPaStkN20wM0V1RFM3d29CM1NFaVYvNEJWbmZlT3ZC?=
 =?utf-8?B?K1lGRlBHSjlUcC9JNVpDOWFiQ1p2VXhKOGVpYWFGRWFtdUltMUt0NDQyQncr?=
 =?utf-8?B?QnVxcFZ5SkxoNVZ2ZnRyQ0ZpT3hsbmdtclZaL2EvSUFSWi9GeFhKTEdwL09t?=
 =?utf-8?B?WDRLN0FHM2lQdzNYOUhMa25hbEE1di9lSjdMUVFCYTNwVzR3QnZXY1ppdmk0?=
 =?utf-8?B?TVoxYmhoUWdtampCSE1RN3pNVkhpRnYrTllSd1BYaTZxZGM5VEIwK0JPRTJa?=
 =?utf-8?B?MTA2SjAzcDRuNHp0ZTBKalJ3Uy8rRzhUQlk3TjhzamdXcjBaSSt4TzlFYmdu?=
 =?utf-8?B?R3kwYVZPQ3VSNGRxNnM3TnBuWE81eGh4ZERkRS9hZGtUQ3ZkbEZ0L3NEOVJy?=
 =?utf-8?B?NWVUU0NPMVdLdll2OE42RlRXRkEvMFMvMGsxRHYwaUNMSXhWaEtNZjRkeHlD?=
 =?utf-8?B?QXo4d2tuRnRhU09mdkdGNm11d21PMmJPTEVFRG00bHRmWk03Mmh0dy9pWjBo?=
 =?utf-8?B?ZjhvbkZpbDlQYWZaZTRaNytacWt6QlFLSUd0ckJqNHlaNWI2b1hpbnJPM0dh?=
 =?utf-8?B?bjBVTkROeURWR296QXRWYUhpVVh6a0F2Q0t3VnhrOGdwNGMwd2E0SjFWZHlH?=
 =?utf-8?B?cTVmMEs0NFc3SkliNWlPSERPdEJPZXFVVmw5QXRYc0YyOXNiVHB0VkFMWno5?=
 =?utf-8?B?WUxHOEtNTzRqVmtVRmpsVUtSa2tBNGhrVnRHRm0wSDJRc0J4b3BJbmhVaTFY?=
 =?utf-8?B?Tmk0MzJId09MUkUybGQ5cnUwUFc0K21WNU43NWdtT2hGWmF6YTl0MnJNUENm?=
 =?utf-8?B?M1E0MThCQjlLNnVDY3ZHRnVPMzZtNW9Ca1p1ejA3Mjdhek9lenRxdndqZFpt?=
 =?utf-8?B?b2kxbTd1S1pVdWRRQ2g1VzBHWSsyaXllQjErNTJ0czZkTU4yalp4dDQ0YnNK?=
 =?utf-8?B?OUNFV0ZOSEpIV0xHYWVLaGg1UHZMSjUrZEViVDdyNXVaZDIrUGVKbEtTMzN6?=
 =?utf-8?B?SW1GVXU2eU56eE9wYWc3SzRZclp2MzdTakF3dWl3TFpmOExnV3o1S0lBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkxZYVZpby9QS2NJaGFRQ09DL3hxRzY5MmVoNkFVQ3lWT2Q5bTN2MXV3a0g3?=
 =?utf-8?B?bW84bHEwc2k3SmJTcWpET0x1M00zT0J2bVlVVEE3TkhOWFQxT1NxQ0VlR0F5?=
 =?utf-8?B?aXhkUjdNZXY1QitCNUhUQmlpMVRkU3BSTW9VYzBpRnBEc3V0SGxmZjBqSE5S?=
 =?utf-8?B?cmErOThOOEVYdWFKc3VvV1h3bVhBamlIbmIvby8zN2N4clJRb01LM2JRbFhI?=
 =?utf-8?B?OHRqUlN5azJyZWVGK1Vpa2MyamFxbFhWaHlCdmp3MHpZbDZqT09hbzdjUUdF?=
 =?utf-8?B?djhGM1MwMTRmNDdHa0tEVW5CL2JmYTVxOHJCcmlETWI3RHAyNkk5RUJ0RlVu?=
 =?utf-8?B?K2ZSa3dueERRcVBQQUwwcDhUd2FzRURtUHMxRloxVGpNWDJZK2U1d1RIVDVI?=
 =?utf-8?B?RWk2UGxweStOa0tJSkVvd09FaGIxRDJDZUw5NUZBb0Ivc1IyMlZkNmpWNFZR?=
 =?utf-8?B?Z3N5QjMzRDUrcjBGNlZaSjVJVENGblNtZEJIVkl4NHZoMm5SUk9RaGFJMkpC?=
 =?utf-8?B?K0xJYWVOcHlXR1BKZmhrRk1lSWhVUXNUcjhzR2ZwdzRxRjRYN0N2UUdvMkds?=
 =?utf-8?B?NklTMXQ2U0lWYWlyZ05NYmVhSXM3c3dKK054dXhVRUl6T0Q2Y2ZUcmU5cnNY?=
 =?utf-8?B?N0tidmttUWxidUdRM2lwSWx6ejZ5M2Q1WDhQbG9PaktNS1ZWN2VKR2NuNlhY?=
 =?utf-8?B?cGUyYWtNa2lYOGVaVitIZnZOUnErVlViRlB2VVZMdTZxOGg5NEMzUm5YbFo5?=
 =?utf-8?B?SGpFRE0yaUZFY1BuY3JuTlVrMDBraUhucVlBQW8zNUNlWlZqdHhBbzJpeTFl?=
 =?utf-8?B?eEc3WmYwSDFueXNCSk1VS2NZVG1nVTY0dkZBU0xwb3ZXNGpLZ2ZMak9tSUZ0?=
 =?utf-8?B?bnFkbDF0alNUSWRyUGlFMGduaHArNE5ObUxiVFRPU25EdjR0eWtFM01XbVhE?=
 =?utf-8?B?NXNpMjhmcmNHanZ6b092T3grb2hONi9wS0F5OGlIcW5sNm1hRDdSZE15a1h4?=
 =?utf-8?B?eE93cmhicExxNXB0VXRJbllvYW9PbXVFM0c4cVExbUZOQ0t5bW1Ra3lMNTJZ?=
 =?utf-8?B?bmJqQzROdzY1R3M3Q1I5dHhhNzMvUzdObjVHMGZkS0xpMW1mZlhML2FUaTc5?=
 =?utf-8?B?SWp4blYxOElzbWdEUVF4cmNMckhrR05hWFhyU2xpZm82MTlLcVpMREl4cDRP?=
 =?utf-8?B?R213alpxeTNvOWdMai84L0k1NU1pWmFWUWZudXVYN2tNTWNzNHcvWENYZ0Jt?=
 =?utf-8?B?TVpBb3cvSjZiQWpVaFUyL0V6RGxwU3Eyc1pheU9pOVlVMjBWbEx4eERyUzFR?=
 =?utf-8?B?ZWM5MHdUZHJRZTF5a0xqazRGZnlHY2c1cTkyWjNielpocGVPSUw0Vys1YVBR?=
 =?utf-8?B?T1J2Sm9qZExxWTY1aWZqWUFvellNRmZmU3lPb0lGaWJ3U1d4M3MrWXA5NUZm?=
 =?utf-8?B?YnR1MFFsdkZUNHd6RWh0REliL1JKY1Z6SENXenF0NUovYVhiV3FmQVRGZzZI?=
 =?utf-8?B?b3c0c2Jpd25WaHF4WEQ5T0ZpRUVIaUFCSXNqbDcyRjZ6NzZBNnprRnljNWhm?=
 =?utf-8?B?a0xIYmtJVk5SRFdLQWlkdFB4aVE3eE9Fd3RYQ3RrajkvazBmdkpEZ1FsY280?=
 =?utf-8?B?c2tjblZxT2RBZlpHZS95dWZSSTBZMThMdzQydDNLMm03b2JjbytpZ0dKZVRQ?=
 =?utf-8?B?alBFUlJwR09SUW9jYWNHSWttcURBTnlRZkJsSWNSaXAwejJrcStJbzdBcU9p?=
 =?utf-8?B?OXErK3hhMXRqa0V1MGhkZGdocXZXRytKSEIxUXl0Rm1pcjNmdEdtVzRRaFc3?=
 =?utf-8?B?ajg5V05ERi9SVE9BZG5XbnhQcEt5L0wvWnMwd0xBU2JDQzllSjBiZVNKYnFu?=
 =?utf-8?B?OXQ1Q2ZKS0xuL056aU53RU9uV3huR2l6ckRrTXlPVklsOExFdjZHbWtCa3Vu?=
 =?utf-8?B?bWdqWklWNldRUXVhTkN5c1JHMFlRS2NjNk0weE4zWEIxemMzZmpMV3MyOXYr?=
 =?utf-8?B?ZlVnQlR6MU1ueGVGVXVKcWM1dEh3M0QzaERRQUJPdFRpRzc4WFozaEZublF2?=
 =?utf-8?B?ekVTTlZnVFZGbFEycHY5Ulc5a2tTK1ZxOGVsQ0RtWUE1cHVXUXlwNnNORXd5?=
 =?utf-8?Q?nQ2x5Vgwx25B+InCCVsH9JAGF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8fBK9BPAh4yOZg8TkARkV6/6Sl3f53JGlGn/I59xrmkbg4bKFiU/2TShmwdW1w7gBfXWRMpe6/24kKRgqOFsVv+FN9i+cyCd+UffgxrPtM1ttdgiIPNpxQ+NBdTNgc1aDIcIU8XOITabAUafKeP9knnPEN1ijrycqZe6an3Y47ZviROkwZiQL34bDDF4K/eg23SS7t91+JhSU/vabCYOMNZaZYWrRweIYmCze0tTWVX4lWfNKz3Tdg4/9KQUx107Jo0Af3xVUNGv6nmf7mFmEbe03oCkokfHBvGDiTbmv6SMLwF9jVYCu6GistQMy6VfhP27UEcLbJigr0KIVZlf3jV5Uuo5NI42taUieTI6XA4y2qSgJXWZvcOAsVAx3clbh0aDyJa1Op7bwi6xE6mnE1Md10QIM1S/DnFOG5SSxTIYjMuU2ytxVosj8UjDUEhg4voEBAsZyYpkyEQ7RUZJ3xF+kff6z0fdRl00wl5YCxDcHHsfMr47z+XiwtSzQu8cRjoB14Kb4f3QonMgtG7j4G7Bqvn5L4YHA0FI3E+dsME8UKMYw+0vWsJFISDUldZdCanboPXCz29dmvMqH3OPwpu1+g91NZcMAGuwFgGnur8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d9ea30-7096-4b57-03cd-08dc86538317
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:07:22.1000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le+21pOVzFgyuAgetGezAyIkRiNITgJuZubIlS3mnW7RPa4++pA07661mDUNjH5QA/DXWZnbvEb3ySfHMq91fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060125
X-Proofpoint-GUID: oOkWR0A1ns1aBmR6v84apFdtMu6fXAPL
X-Proofpoint-ORIG-GUID: oOkWR0A1ns1aBmR6v84apFdtMu6fXAPL

* Suren Baghdasaryan <surenb@google.com> [240606 13:33]:
> On Thu, Jun 6, 2024 at 10:15=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240606 12:52]:
> > > On Wed, Jun 5, 2024 at 4:16=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > On Tue, Jun 4, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko <andrii@kern=
el.org> wrote:
> > > > >
> > > > > Attempt to use RCU-protected per-VMA lock when looking up request=
ed VMA
> > > > > as much as possible, only falling back to mmap_lock if per-VMA lo=
ck
> > > > > failed. This is done so that querying of VMAs doesn't interfere w=
ith
> > > > > other critical tasks, like page fault handling.
> > > > >
> > > > > This has been suggested by mm folks, and we make use of a newly a=
dded
> > > > > internal API that works like find_vma(), but tries to use per-VMA=
 lock.
> > > > >
> > > > > We have two sets of setup/query/teardown helper functions with di=
fferent
> > > > > implementations depending on availability of per-VMA lock (condit=
ioned
> > > > > on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.
> > > > >
> > > > > When per-VMA lock is available, lookup is done under RCU, attempt=
ing to
> > > > > take a per-VMA lock. If that fails, we fallback to mmap_lock, but=
 then
> > > > > proceed to unconditionally grab per-VMA lock again, dropping mmap=
_lock
> > > > > immediately. In this configuration mmap_lock is never helf for lo=
ng,
> > > > > minimizing disruptions while querying.
> > > > >
> > > > > When per-VMA lock is compiled out, we take mmap_lock once, query =
VMAs
> > > > > using find_vma() API, and then unlock mmap_lock at the very end o=
nce as
> > > > > well. In this setup we avoid locking/unlocking mmap_lock on every=
 looked
> > > > > up VMA (depending on query parameters we might need to iterate a =
few of
> > > > > them).
> > > > >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 46 insertions(+)
> > > > >
> > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > index 614fbe5d0667..140032ffc551 100644
> > > > > --- a/fs/proc/task_mmu.c
> > > > > +++ b/fs/proc/task_mmu.c
> > > > > @@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode=
, struct file *file)
> > > > >                 PROCMAP_QUERY_VMA_FLAGS                         \
> > > > >  )
> > > > >
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +static int query_vma_setup(struct mm_struct *mm)
> > > > > +{
> > > > > +       /* in the presence of per-VMA lock we don't need any setu=
p/teardown */
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static void query_vma_teardown(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
> > > > > +{
> > > > > +       /* in the presence of per-VMA lock we need to unlock vma,=
 if present */
> > > > > +       if (vma)
> > > > > +               vma_end_read(vma);
> > > > > +}
> > > > > +
> > > > > +static struct vm_area_struct *query_vma_find_by_addr(struct mm_s=
truct *mm, unsigned long addr)
> > > > > +{
> > > > > +       struct vm_area_struct *vma;
> > > > > +
> > > > > +       /* try to use less disruptive per-VMA lock */
> > > > > +       vma =3D find_and_lock_vma_rcu(mm, addr);
> > > > > +       if (IS_ERR(vma)) {
> > > > > +               /* failed to take per-VMA lock, fallback to mmap_=
lock */
> > > > > +               if (mmap_read_lock_killable(mm))
> > > > > +                       return ERR_PTR(-EINTR);
> > > > > +
> > > > > +               vma =3D find_vma(mm, addr);
> > > > > +               if (vma) {
> > > > > +                       /*
> > > > > +                        * We cannot use vma_start_read() as it m=
ay fail due to
> > > > > +                        * false locked (see comment in vma_start=
_read()). We
> > > > > +                        * can avoid that by directly locking vm_=
lock under
> > > > > +                        * mmap_lock, which guarantees that nobod=
y can lock the
> > > > > +                        * vma for write (vma_start_write()) unde=
r us.
> > > > > +                        */
> > > > > +                       down_read(&vma->vm_lock->lock);
> > > >
> > > > Hi Andrii,
> > > > The above pattern of locking VMA under mmap_lock and then dropping
> > > > mmap_lock is becoming more common. Matthew had an RFC proposal for =
an
> > > > API to do this here:
> > > > https://lore.kernel.org/all/ZivhG0yrbpFqORDw@casper.infradead.org/.=
 It
> > > > might be worth reviving that discussion.
> > >
> > > Sure, it would be nice to have generic and blessed primitives to use
> > > here. But the good news is that once this is all figured out by you m=
m
> > > folks, it should be easy to make use of those primitives here, right?
> > >
> > > >
> > > > > +               }
> > > > > +
> > > > > +               mmap_read_unlock(mm);
> > > >
> > > > Later on in your code you are calling get_vma_name() which might ca=
ll
> > > > anon_vma_name() to retrieve user-defined VMA name. After this patch
> > > > this operation will be done without holding mmap_lock, however per
> > > > https://elixir.bootlin.com/linux/latest/source/include/linux/mm_typ=
es.h#L582
> > > > this function has to be called with mmap_lock held for read. Indeed
> > > > with debug flags enabled you should hit this assertion:
> > > > https://elixir.bootlin.com/linux/latest/source/mm/madvise.c#L96.
> >
> > The documentation on the first link says to hold the lock or take a
> > reference, but then we assert the lock.  If you take a reference to the
> > anon vma name, then we will trigger the assert.  Either the
> > documentation needs changing or the assert is incorrect - or I'm missin=
g
> > something?
>=20
> I think the documentation is correct. It says that at the time of
> calling anon_vma_name() the mmap_lock should be locked (hence the
> assertion). Then the user can raise anon_vma_name refcount, drop
> mmap_lock and safely continue using anon_vma_name object. IOW this is
> fine:
>=20
> mmap_read_lock(vma->mm);
> anon_name =3D anon_vma_name(vma);
> anon_vma_name_get(anon_name);
> mmap_read_unlock(vma->mm);
> // keep using anon_name
> anon_vma_name_put(anon_name);
>=20

I consider that an optimistic view of what will happen, but okay.


