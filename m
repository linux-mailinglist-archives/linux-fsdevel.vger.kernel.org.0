Return-Path: <linux-fsdevel+bounces-69269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D64C76240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0859634E186
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2C30594F;
	Thu, 20 Nov 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gs0wJbpT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXWdiRul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1838285073;
	Thu, 20 Nov 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669401; cv=fail; b=QFuwaQjAEW+01SFk0xQ66jpf7eDSvjeVI+3erBAkaX51x8ZnWmaLtiu6oK5LEclYAsuVVa+ObbvXUqWo/husMRs5EGazWbHHnkBZLuny22nTq4A7CWtd6XlheXJk9RBaddRwSdjOvAWiuZpLDkJ0KN6StMJwzYODDoecjr5djcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669401; c=relaxed/simple;
	bh=EJWXAv7WqdfXbVnUKZyjTLUGp0hBQLTZc+zc7BYApHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jlf8x5FmyJXMsYXX5iI8lYzUJ6wgOkU5y6UGamdUzuN+RXQw080zy8tEcPAgZPYqByfgyatgbm9hPaUIee+tKypwytDc+6haf/utyvlAui3yrHB6TBnJCmFoNHDT3xueRgvnRBoYGe/lgFSoPeu5C7o2IDihTwdYwh2w+eIH49M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gs0wJbpT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXWdiRul; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJgPOR024330;
	Thu, 20 Nov 2025 20:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Tj+Aayjj6Z58y2DOFa/nANCD5tzrhDu7cTqMSvNrhxQ=; b=
	gs0wJbpTHsGj5N6CUk5m+CIlpHpfunrTXgbjLdta7bO6R7qgGGHzgfIN68O2j4pf
	RsNuCWjQNXtjbAs0eZ0TZV3qGi5iolTna7up6kXtHFHRBQctdQH58iio34Bylzmb
	Fscytnly0yyvrKU4RJhJai0yW1cWDYMhKCYVcNodmDjr6Cf8UEszRvOm+ODLMqzH
	Z12Frv9axB3hsELq+M6yxzIk1j1imCBsx1MRgG8V2u70IJ5LxJ1enq4MnJ9iJkFa
	cW+XxTeDG6S/69ayCFo5S86PdS4SkTKdYxrTD7J/NwPSXauWnj0l/r0e6Qmu3x6z
	ZWwK9+J9Nx006mx2UYR6og==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbusq3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 20:09:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJSY5H004341;
	Thu, 20 Nov 2025 20:09:36 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefycdd0b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 20:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhcIuyQ+mDqNZEcPocgrPh/LShSD/t9lusLvSibTE+0bBkCuQcdVKTGDuRETi2dKPcG6w6tY93EubGTJyqLxVHcuUgozUWJAjuWGGDTRUZXKjFwdVCFRrtVQhk5mAsLIBG7TQlPImkMnklX9LTWLQWSpHh81i0/ohynzUEoJ8mj/HyigCjgifhuvm84WKGTW8CxIhhARPUNhCKnyeHyKcBDx+Mb7ZRPQX2GdywlmQRxsVbtgMh9lDWVMkaFzZRVzsXwtzz0HzeeTKdtUNHouh9VtkQSpQPPZHoMD25Ql4y3rPuwwT2f307EifgJauxuaFBCwb4arv1F3UDfd9vfrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj+Aayjj6Z58y2DOFa/nANCD5tzrhDu7cTqMSvNrhxQ=;
 b=nLALwrDvPfqYi7ZPPusLtBEHmqKBTdGvMSTn4ytbQfT/yOi1WWsQaelzv9xl0NQ3VeafP0W6aPD+3heqDJIB6IhfwDlpY6gOJMVhhJmIBUoYEcWbtJapvNFbHFwz/d659bdfagk8JlsAD43+0LXpZACqsRPVH2t1adEm+atX88k/JGNZRc6vi+nSURxe1ceXoNiWG+XQt2zvbMSwzFmRYvOuCVzuc1qzL4AWyIzfXIZhmg27LyAH7nNq8elUT37oW0R4IhM+3IRuuKKgCIBoEoc8CFGkPMfcf6mBbBp34o82k6xh+hOKs5R1Mkr+LLveP7/HAfmRfW5K+Aar2a3yIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj+Aayjj6Z58y2DOFa/nANCD5tzrhDu7cTqMSvNrhxQ=;
 b=aXWdiRulSjAK9sN0ZIyl6bj9rYAvslFa/7nP70UlnBF3Kp9ri9t6WmIgahIB8xJjTfRQlklNrK0uz3enaRnD9HWQCcDN+nng1h0CcXZu69SDgsKHVNfEhhzL/H1wEtNsmAqX8OidoJfIkLhvLquNpBGcQpxK1uutiawtLDCXJaE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 20:09:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 20:09:28 +0000
Message-ID: <b718b3c2-d19e-42c7-a29e-5e07319e2439@oracle.com>
Date: Thu, 20 Nov 2025 15:09:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] VFS/knfsd: Teach dentry_create() to use
 atomic_open()
To: Benjamin Coddington <bcodding@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <cover.1763653605.git.bcodding@hammerspace.com>
 <d7405b554e3b12a037dbce4b9db29394d87183d1.1763653605.git.bcodding@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d7405b554e3b12a037dbce4b9db29394d87183d1.1763653605.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:610:38::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 5711e89d-c5a0-4922-0b8a-08de2870b5b2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TnNibUdrL1gxWFV4aUp3RWUyenlsN2JZWWJ3MGl6NkRNTlpJY3FnMTVHYncz?=
 =?utf-8?B?eDNyVUdwMWppQ2JHUXNqVEk2WDJpRHdvUk01T1FISlhRU243SVJrN0x2Z0gy?=
 =?utf-8?B?WE4xdy85ZjZLRnB3NmJKRXZZU01sUmY1Uzl1Y0U3czJGb3lFZ3ozRlh5NmR1?=
 =?utf-8?B?YTgvWXhPOVR6K3BNR1N5ZjA2NjhrSklTSmt4VkNkcHg2TzNDUmcreUxOaUJ4?=
 =?utf-8?B?V255RTVmV2xJV2dlRnViTytucHFTOFRtM3FGcGNtTld1WUlHTlVrbnBwYUVk?=
 =?utf-8?B?djF0V3dZck5hTGFGeTQxMklhbXV2S1JkQ21yTHJaZVNjTUVmOTRVSXFiZ0hx?=
 =?utf-8?B?ZWVnMVFjZ1FGbkZ6eEFLR3VZQTV3L2I3aExsQ3dNUG1EWFlhbnAvdk5SOEdu?=
 =?utf-8?B?bFA2L0t2KzFYUmpIUlFORklLWTk5T0YvSVkvREx1RS9kYnI4T0pxS0wrdXBL?=
 =?utf-8?B?d0RpZzZNbUVEQVA5MlRUbzFuQ0pHa094Nlc2b2xZSExrMXFsRHBCOUVIcEhU?=
 =?utf-8?B?d3Z5R0lHY2cxSFFjaWNjUEhieXc1ZUtNRWczQjkreWIyVCtJUDVjMFZGV0k1?=
 =?utf-8?B?WlZkeExGblcyZ1g5Z1RPM0hJQmVRQmlEY1RqdlE4OVIyMGE5dVR3M0ZibERJ?=
 =?utf-8?B?TTdMemY0UVBsL0FFT3A0SDUxVkxJa2ZYbXBFZHAwcFBlcGd4Ni8wSitzN0th?=
 =?utf-8?B?VFJxOWtTQUtpaWJNQ2NaNDROaUlwdFV3Q1F2K2trb2hzODNsRnAyeGlLQi9h?=
 =?utf-8?B?VTZPa1ZTaDFTVTY2b1RueWxUOWNJaVpaMnAxY1JrSzJpaHRsNlRXY05ocG9G?=
 =?utf-8?B?Qms2UWh4RVpSRGZxWmlLUW1pb0VEVVlxdjR3U1JBZ2V4bHZ0eE92QlBkTkNC?=
 =?utf-8?B?OFRJOEJMRVZ4SjRxTmg5ckJNM1JQQ0dwS1BiWDZiYWxzOXdnREFwRzk5VWla?=
 =?utf-8?B?VHBPSmRic09IQVVTWm9JN1Y0UzIwVytiT25Zc0Q3blRtdkVoeFgzeTdId25s?=
 =?utf-8?B?cS9iYy9pNlNBU1hja3QxQVJxUE9FRURkM2c3U1A3enhsQ2tneS9wQmlqNndn?=
 =?utf-8?B?alhwTnJ2SFdqaXhMaHhTUzhVRzRhUldLUGI1aW5yQjBxNS84eW00QlVkRjhG?=
 =?utf-8?B?SmovSmpDci9tRTlSdURnMTY0aFJicVA4TndlUmgwUUpDQ0dJajR4ZE1VbFZk?=
 =?utf-8?B?ME40ZW9WY1lGNzVjQzVLV2l1elpZaHBFbzMvRmpTeUFzK241b1lGWDZISUxs?=
 =?utf-8?B?MUhGbnZoeVd0d3BIdGpsOVBYTC9WQTNvU3lEbzFXeTNFVjFDa3ZSN3l3SWhL?=
 =?utf-8?B?eTh4NVViYjdNbUxEZThMNnhUVmlla1pEVUNHVUtsdk5ZZ2dwUWNEaWJLb2VK?=
 =?utf-8?B?YTRZMWpGZXZIYkZmYXBpc0lKRUdwZTdTY2VjSmRBL0hxc09QRXZEUnRpTjlU?=
 =?utf-8?B?QjBLdWY1c0p1RmxXTnRqNjhGVnNUbi90SzVOZmU5SlZpcnFUbDQyTEJTelR4?=
 =?utf-8?B?R1UzOEJ6NkZkNDcyT3RWZmh0dzdUbThtNkZNc2JtVStpcXVSWUdoN3FGb0pi?=
 =?utf-8?B?Q29jbDlyak13NkFFYUFaU1hHdFhtRWZ2OWRvMG5aUmxON25sMURnZHFORm5M?=
 =?utf-8?B?LzA3Wi9EM3pZYmx2M0RJMVVsWC9nYjQrL2poUmU1cDNreFU5dnlTdGRraytJ?=
 =?utf-8?B?VU1aOE51b0JScVpoczNtb0dlbVk4b3E5bUFoc3EvT2VYUXVjcVBGaEdZSlNB?=
 =?utf-8?B?OTZJNXBya05EdmZGYk1ab0c1Mm5hTzFSUkhzcjN4UWlNOTE1aG44UFZzYlZX?=
 =?utf-8?B?NTVMN2pNS3c4UmhtTlNtdmt6aGNOOU1QWU1RQkpxc3hWdy9kWjl6b1pCWUQy?=
 =?utf-8?B?Q2N4RjZJRXprWUFFUlk1VVFBY1pSUHFrbHVxUVR3a200bFpjK0J1dzIyb2FE?=
 =?utf-8?B?MlFDZnZ6cllqV1lIMFoybS81STFBaXluY2MvNnpQWWhEYlh0NW5OejZWTDdS?=
 =?utf-8?Q?2HXDsIJspl1+eNE3y4/rsxl1BBqIp0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bENTTkhkcTlqR3VBTXR6UE56bllOdWE5a3ByalBJbU1wVysydjlaME5CVzh6?=
 =?utf-8?B?dzBQVjV2T2ZpUnMweWY1VlR5bmUrV1BiTm9HU2VPakFERkZSL01ObDlJM2Y4?=
 =?utf-8?B?UUxzdkRYSUl5UXF2OVFhTXBQTG1XUVo4bEVXYXNRTUNHeUo2eC9UUWlGQWVF?=
 =?utf-8?B?WmovbGtZQkt5dm04cU1hbEM5OFM4QmxqMUllQ0RZcWJyaXVCbkVsc29KUTFk?=
 =?utf-8?B?c21xTnVTZU1relF0d0hqOHlmZ0J1OC81Ty80T3MzeTlYanJsUGlWMWJSZ3hC?=
 =?utf-8?B?NEh1ZWZFWE9JNTZaNi9DT0tDdXRwMmFsNlQ0cFZuNmYvUVl3YklNR1ZTMm9U?=
 =?utf-8?B?ajZpcXFRVEVYbERVRW5wOVdhb3Jza0p3S21yY3B5ZGltYnp0cXMvYUFqeGo0?=
 =?utf-8?B?c0tQd2JsNE9xODRwZVhKMi9QbS90SzkycTVrRU0yQmhhcngxZTdXZGRaTkJl?=
 =?utf-8?B?NzhudCtGc2JtSDc5YVJ5N2cwcTlNVUlrSERYaTNMODhSaGlOZzdKRkJjSlBy?=
 =?utf-8?B?WlFubWx3bExNdGQ4TDNsQmVxc09HZGZhQ3YxUFdlMG91Ylh5Y2pId2FZMW9E?=
 =?utf-8?B?TDVxOHBEZ0Vob1BtUWQ3NFpQRitHeTBIM0tZY3VTQjB4cFNaMk9Ta1c5RkE0?=
 =?utf-8?B?eG51VTZxUGt5SEpPT3JPQ2s3eXZTVHRaN1dVVU41ZHZjMjQ4OW1ZamlmU1dY?=
 =?utf-8?B?MTNZZTE4V2NOUjBnSkpiNHFJTG5JS0M4a0NCWVVVOGVPbDRmd005VHpZVXQ0?=
 =?utf-8?B?SGxaTVAxK3FHc09yYWhqdm02SXNuY2ttZEtmVFloRWkrRTJ1TC9CZFBGOWk2?=
 =?utf-8?B?bWVNMTBDMDMySUtUV01uU1ZJTERqYkNSR2l6YUlFSlAzekRkaERRcUpSWUdU?=
 =?utf-8?B?S1FEMGtiK0F4dzdicnRYeVlPNCtGREdYWEo1cXlzcHN1aWhBN1hmMEpwcGx5?=
 =?utf-8?B?KzBrbndPbUE0SE1aUUo4R3Q1cXNYNHdmRnhEelF5L0dpTTl6MTdSdi9TM3hI?=
 =?utf-8?B?THhUTVp4SHJJRXByZzZIQ2ZGUUh5bUJrREFabis2QzB4U2ZOK29yNE1ibzRt?=
 =?utf-8?B?d1VtMCsrRUlmSFJOVllJdURWQktvdmlUckdPQ1lYYkUvVGlBWUdmOFlzeFNj?=
 =?utf-8?B?Mi8wZytCeXExMmI4K3VINC9VdEhFOHBpZ1BqZWYrQUVGYndsR1luNjUwMXN5?=
 =?utf-8?B?a052anlYNW5SbEFYWnJTK3BxT0VOaVpwYnJWSjZEcWt3Mldabzl4V3kxQmJN?=
 =?utf-8?B?a0R0cXFxRnJMUlMvZzJzckpQY01semFFYklFbkU5dHhaMmFRemhtSDhmNFMv?=
 =?utf-8?B?RjFQbmdQRHhGRXZrREw3bEd3bGM3bUdydGkxUTk3dWNIRnhaN0ZDYnEwMVNS?=
 =?utf-8?B?d0JpS0M3cGpKdURrVE5DbU05c3o3YmZUSVN2K2wyK2kvMkQyRmdPdWl5bHN4?=
 =?utf-8?B?M0F5Z3lLRTUxLzR5N3RQMkxNNm1yNml4SStMeW9KT0piNEZjdG1aWVFoWGdy?=
 =?utf-8?B?aEl1c010Q3BCb0hjWmZ5Y1RoY05jbis5NkRQTHB2bkZSRUtVMVdkK2ZQME9z?=
 =?utf-8?B?d2k2S2xuVnBkNzhSR1YwZ3pLOXhWcDNCSTBMalNFTCtaN3gvK2MyUlF0cFgx?=
 =?utf-8?B?V283dDhhb1VWMGtQYUIzUmQrNTFzK211ZW5rWndkUjVnbGl3d2NtZlZoRVN5?=
 =?utf-8?B?azAwTVZSbmYvcXE0cWVOdVllemRuOGllUVRlcUdCTXNDZk4zdVdTTnR4QUJI?=
 =?utf-8?B?a0szeW80ZlhqUjZkbEFUblVXcHRGTTFwK0U1L0prYXdPQUx5ZEllYXFqcFox?=
 =?utf-8?B?Nk8wV1hBYjhZb2RSZlROUkkwTDlENCs4RVdOd0JpZFpYb252djNrZnF6eDNh?=
 =?utf-8?B?UldtQ0RmbllSbmNJeWdTYVp5VkxvSFQrc3Y3VFJuTzBpRUhnQ1hnMi81ZDN5?=
 =?utf-8?B?OWgxSU51VlZJZjVvSVkyWGZIamhGbDI5Z2N2Z01MMk13Wmt3OHY0a0dJTmFK?=
 =?utf-8?B?YjRqVVZPcXFoWFI2cUtLQjRLYmsvWVFvN2JQaFkyZ2pRUjViTUFQU1YxamxM?=
 =?utf-8?B?NnkrODZsK3JRTXBIOTdKbk90ZndzNUdaRzhIZkE5bVU1dE43Ty9wQ0tVVXAw?=
 =?utf-8?Q?b1Nacc3DXnoWqXXeMF9U6jQ09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n2RMziuPcDr097eoKXJBXNJtKnfUG3cOksrCYdTG5C24knEweL4e5YOVy/ROTDtR2mrXveFc1n6U3Jo5pLxqHopZOWuNSI67nxPmKqukVq0a2R/ZL09SROEwIRk5NdgS9wE/szMuhxkgn3d3j+GLeHwScaQK/zzVtsqYdLux+nioZ6KTtv+18ui2QJsg+L9jGCJYZWhyQ6TvzFpC2sVPqBOlapohraoN+4pm1MuEs1tpTZcqktDgPJzdGOwlwpNAmISLo0jnFjDO8hMZP9lHkdbNcpeBaJMX9n57caZCcurEXrfKDSm0WouQXaYLXAlMWscGkgsEdvqaEtL+Cp8lU9DFy8CrufguVeIdFrMqoy5oplkZE3fDGTYFDHDWwEIXkMRG1+3pVICPbjcoLjd2orpcFyOeX3Kj2WJs94gbixX7TGERFG/mmezhELOVymWIoZ7nJBTVT7zDMHVbMrck2ejoey30RWqSXdDiBcFXL43fcGzIGoZMEtp4aqzg2SA7M3D6Gc3rWBDXpYfadpbJcVMN4N1oTpWaJvFwo3mcW1mZw+vc6zelNSfFPqFXGu4cQiMvKIe1LOL0OiSGLTcbTbWV8KBn4AIfoaPUEpXPRdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5711e89d-c5a0-4922-0b8a-08de2870b5b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:09:28.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivOcYvuOkwV+qRVfKWaxKzUMXhdIxh1Pg9R1Z1CAYVdRMTWe7YteOpqsQERCNBKtmwhmGCE2AV4jep5PLKXSTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_08,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXxEPtyik1kDhh
 GoQEJ935zGKvWxXVm5/HdvNFPNNfXaOXAKyIZvwjkT/gJAXlgoh0JrKrRwnuWY8K2ZkGP32fpct
 7p0uagRJdzbz+Kbijwrd+WpwxH1x8Tb3Ti93gByOLvOlwRPawAsrjaSrP62NCP2jiCewPmsTUd3
 wpMgu63HZ46AklKuDECgp1J0Y2QtgChJ8U1c0owXdcEasAL37cNM9mgWHJQRlucqDe5fBiDMHG0
 iuTqnTTYrRVDtuMHDjejkgxQCmSW4hWX+J6oO+T0yKlBy1qfcQebQa22drEKtni03auERu/Q0rE
 1USAqFv+v2Yhq2XopilVK8iWyCP0b9mYG36wAfwckl9MoytsGVoxaMsUcJ50vlGlK/8A53bMw3y
 OszboiFYZICx+UelYP9AyDRHf5Ubog==
X-Proofpoint-GUID: KyIFyxyk9LHEFQhPNzpbgXN4Wn8DmLji
X-Proofpoint-ORIG-GUID: KyIFyxyk9LHEFQhPNzpbgXN4Wn8DmLji
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691f7581 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=9sHGE7YwQULgWlausWEA:9
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22

On 11/20/25 10:57 AM, Benjamin Coddington wrote:
> While knfsd offers combined exclusive create and open results to clients,
> on some filesystems those results may not be atomic.  This behavior can be
> observed.  For example, an open O_CREAT with mode 0 will succeed in creating
> the file but unexpectedly return -EACCES from vfs_open().
> 
> Additionally reducing the number of remote RPC calls required for O_CREAT
> on network filesystem provides a performance benefit in the open path.
> 
> Teach knfsd's helper dentry_create() to use atomic_open() for filesystems
> that support it.  The previously const @path is passed up to atomic_open()
> and may be modified depending on whether an existing entry was found or if
> the atomic_open() returned an error and consumed the passed-in dentry.
> 
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c         | 46 +++++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/nfs4proc.c |  8 +++++---
>  include/linux/fs.h |  2 +-
>  3 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 9c0aad5bbff7..941b9fcebd1b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4200,6 +4200,9 @@ EXPORT_SYMBOL(user_path_create);
>   *
>   * Caller must hold the parent directory's lock, and have prepared
>   * a negative dentry, placed in @path->dentry, for the new file.
> + * If the file was looked up only or didn't need to be created,
> + * FMODE_OPENED will not be set, and @path will be updated with the
> + * new dentry.  The dentry may be negative.
>   *
>   * Caller sets @path->mnt to the vfsmount of the filesystem where
>   * the new file is to be created. The parent directory and the
> @@ -4208,21 +4211,50 @@ EXPORT_SYMBOL(user_path_create);
>   * On success, returns a "struct file *". Otherwise a ERR_PTR
>   * is returned.
>   */
> -struct file *dentry_create(const struct path *path, int flags, umode_t mode,
> +struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  			   const struct cred *cred)
>  {
> +	struct dentry *dentry = path->dentry;
> +	struct dentry *dir = dentry->d_parent;
> +	struct inode *dir_inode = d_inode(dir);
> +	struct mnt_idmap *idmap;
>  	struct file *file;
> -	int error;
> +	int error, create_error;
>  
>  	file = alloc_empty_file(flags, cred);
>  	if (IS_ERR(file))
>  		return file;
>  
> -	error = vfs_create(mnt_idmap(path->mnt),
> -			   d_inode(path->dentry->d_parent),
> -			   path->dentry, mode, true);
> -	if (!error)
> -		error = vfs_open(path, file);
> +	idmap = mnt_idmap(path->mnt);
> +
> +	if (dir_inode->i_op->atomic_open) {
> +		path->dentry = dir;
> +		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> +
> +		create_error = may_o_create(idmap, path, dentry, mode);
> +		if (create_error)
> +			flags &= ~O_CREAT;
> +
> +		dentry = atomic_open(path, dentry, file, flags, mode);
> +		error = PTR_ERR_OR_ZERO(dentry);
> +
> +		if (unlikely(create_error) && error == -ENOENT)
> +			error = create_error;
> +
> +		if (!error) {
> +			if (file->f_mode & FMODE_CREATED)
> +				fsnotify_create(dir->d_inode, dentry);
> +			if (file->f_mode & FMODE_OPENED)
> +				fsnotify_open(file);
> +		}
> +
> +		path->dentry = dentry;

When atomic_open() fails, it returns ERR_PTR. Then path->dentry gets set
to ERR_PTR unconditionally here.

Should path->dentry restoration be conditional, only updating on
success? Or perhaps should the original dentry be preserved in the local
variable and restored on error?


> +
> +	} else {
> +		error = vfs_create(idmap, dir_inode, dentry, mode, true);
> +		if (!error)
> +			error = vfs_open(path, file);

Revisiting this, I wonder if the non-atomic error flow needs specific
code to clean up after creation/open failures.


> +	}
>  
>  	if (unlikely(error)) {
>  		fput(file);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..7ff7e5855e58 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -194,7 +194,7 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
>  }
>  
>  static __be32
> -nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
> +nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
>  		 struct nfsd4_open *open)
>  {
>  	struct file *filp;
> @@ -214,9 +214,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
>  	}
>  
>  	path.mnt = fhp->fh_export->ex_path.mnt;
> -	path.dentry = child;
> +	path.dentry = *child;
>  	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
>  			     current_cred());
> +	*child = path.dentry;
> +
>  	if (IS_ERR(filp))
>  		return nfserrno(PTR_ERR(filp));
>  
> @@ -353,7 +355,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	status = fh_fill_pre_attrs(fhp);
>  	if (status != nfs_ok)
>  		goto out;
> -	status = nfsd4_vfs_create(fhp, child, open);
> +	status = nfsd4_vfs_create(fhp, &child, open);
>  	if (status != nfs_ok)
>  		goto out;
>  	open->op_created = true;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 601d036a6c78..772b734477e5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2878,7 +2878,7 @@ struct file *dentry_open(const struct path *path, int flags,
>  			 const struct cred *creds);
>  struct file *dentry_open_nonotify(const struct path *path, int flags,
>  				  const struct cred *cred);
> -struct file *dentry_create(const struct path *path, int flags, umode_t mode,
> +struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  			   const struct cred *cred);
>  struct path *backing_file_user_path(const struct file *f);
>  

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

