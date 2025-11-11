Return-Path: <linux-fsdevel+bounces-67965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69156C4ED79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2278F4F01CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8489369984;
	Tue, 11 Nov 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="poJqNjCp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YuLoBUdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D914286;
	Tue, 11 Nov 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875860; cv=fail; b=j/Qko3PJSLvzT14ZqXThzg0bmZq3XeW48xld8aSO57O7ouoODmvIR7M7oeKdXUkS5YpsscQbJViKnKOXcozSs6FoFozOMW1mwh2P1kMs5+QC1B9UzFwf7Zu1djgQq6nkOPUCGl6ZyTg00aPZkWivBCWY+tvvKSdZ/qLD3rbl+Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875860; c=relaxed/simple;
	bh=Lfgpx2drI9fYxtIkRne0cP/Eu/ZPEXM5JMUJnET6aXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QhROEdqnU6cD/emgCayZ3ywUzuI3LIvTAlVztEdJOwPEghqzvXFqGZPc5cBAWLwijSTtHqviA5Gwd+eajfZxW2l76x7heWXQvxcsuzWftR3XtoP+rJqC4VuDjDhPrwjjGc6iv3i34yOrhwpWL7VLxQjpxsmUWXVacFVWKoNz1/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=poJqNjCp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YuLoBUdY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABFNijf020166;
	Tue, 11 Nov 2025 15:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Lfgpx2drI9fYxtIkRne0cP/Eu/ZPEXM5JMUJnET6aXI=; b=
	poJqNjCp5rYyzaoKHmUddkGEbCH+jwnQY1zdMoATY/oxwnAa/1+JfGlfqniagZ5W
	0T4XO3O+1bG4Hy5TL16mGi9kAIPACKGCkm/RmRm7HCXEqrJBLxokda1QORngqmet
	upEerMi36oYF3hPfc1i3W5MRdR8ioTk/BBOTxK9kJ1QbK0H+iK1uqPviAcsuGOSj
	WNSgKM3IXNl79df5GVfS4BMuVrIGtRWkeldldVWEyXn4sseSnjnM/eKH81uUTLy1
	24hqpZ0SdmtEKGNigufeRaQXivwyhM7di0vXV5wsMbuxOl3bOuLpD2fvTCqUqiOY
	l19SOZrg9mLA6EM3AeGc6Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac6a707c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:44:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABFXNtA000712;
	Tue, 11 Nov 2025 15:44:01 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadpe11-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6tWCrylbkthHEzIzR0f8auheXyaNrZetXhTcozSrljrcidGl9V9+VX8WRJaQ8YlDkYbDFUcl8yzArgqjFq60ZtS/cx3G+EnqZTSbyx5SUtg9JxunfpKcprTupX+vbl+BS1CT5R+geCCgqlqrjclVFi2qHjh8QFGwbFHcqE8esLZjzqu17VAZC0cv9i0j4fjMOHAjdsQggxZjRVrs5bzt+lqCsewgjETe77DSUVk4ZRgl3YhiquRteQVQW8Q27B45Z85U+X7AWBe2Zdtn4rvjtORLXM0nVzGLfS8krAI7Rg9rDk99W3A7Af5jex16U1mSYDZ2Qb5vVlWhQuZCRx8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfgpx2drI9fYxtIkRne0cP/Eu/ZPEXM5JMUJnET6aXI=;
 b=Lg9RKjTidUucTZzxesPzOTwXIBau9Xeu8cVUz1LYvl8lTu+qjmQxJpxdqwWKKjviEvpZvCQL6mCdkCajnJbAkhuOfMLluLNFTBmvRIR12f/0P1xMko20TliL2d5Nq/7fhDURMEC5sB69b4LxouL3EhcAJx+nlUQ2qnKxccnK1wfoMBct2+TestJaYHfaILs+fkpeI5uG8jVC8MyVEWoOIDcoGRPKeAJ2RlcD/tdUiKqtqQv3dkFgbDFgpgh6oOcU3BNY00KfqSMZzm/RuMwrm3MVL84vSh6/PMKiFjVD5v5TRa5gZJ7+UTSyHuveVdA09kv4Trinm+9UEc6VQb3nQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfgpx2drI9fYxtIkRne0cP/Eu/ZPEXM5JMUJnET6aXI=;
 b=YuLoBUdY0irRsFJLyy7GQJa90MfksCnXVTplY2UJaL9pA0GgJtG6XapdocCWrEKgiYcwubDVQYsst4eDm59eBdNTtMF7CldYUeNEn1Y6GFJHhILF+S0W0GFY3/Lq5k8jCqx0MGoSgj8moAzNtR4MEE44oBmtxCajeeeqlfCBCoQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BY5PR10MB4258.namprd10.prod.outlook.com (2603:10b6:a03:208::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:43:57 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 15:43:57 +0000
Message-ID: <3dbe4a47-615d-4b5b-bf14-05bacf7de9e7@oracle.com>
Date: Tue, 11 Nov 2025 07:43:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@hammerspace.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        hch@lst.de, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251106170729.310683-1-dai.ngo@oracle.com>
 <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com>
 <e38104d7-1c2e-4791-aa78-d4458233dcb6@oracle.com>
 <5f014677-42c4-4638-a2ef-a1f285977ff4@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <5f014677-42c4-4638-a2ef-a1f285977ff4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BY5PR10MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b25fc7b-4415-4db2-f7f4-08de21392032
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K28rRHlxenBXVkFteHlRS3EySWxMMG45eGVLWHl0cWUyUjcvbGQveWFmN2dp?=
 =?utf-8?B?TTlBR3lINkZDYnhjM0R5WWM4b1phT2NCSmdDK2l5YzZndEQ0N0ZaRWg1UTFq?=
 =?utf-8?B?NXh4K05jNk5OeThpQ0x6K2xIQlE2S3dmb0RVNkpmK3UxaFg4ckNWOVpkZGJ0?=
 =?utf-8?B?RHFQT01DQ2kza05IVHAwckRpb3ZEbld5Y2dZcFlCZG5DQXhOZ3h3aFhHbnVh?=
 =?utf-8?B?MW1yaTIyNEtsM0MzL253U0dTSXVzUlBMdDd6MFowdXZxVzZUdnQwd0ZFdUkx?=
 =?utf-8?B?R2JZenNXdjVLNmZ3MER0QjhGdU96dDJUeXNzR0JQa1ByQ2RyYTduZVFmVGNq?=
 =?utf-8?B?emY0K2dvT2x6R2ZMRWZHM1R2aWtDVDNQY3MrV0drT25XbUR2SmFXWEwzTmpX?=
 =?utf-8?B?aW5Qc1FpQnhwM3lBOFJDZjRvTGZGRnVqL3RFOGJqQUVYdmoxOVpOYlRBRnNY?=
 =?utf-8?B?M0pxZVlxeGVudzRHNFM5NHRVYVlrRzJnMnIxZlB5WldEOTBPMGRTaWVKYzFy?=
 =?utf-8?B?Z0FweGFHeG5zYm5QeHhGKzJxK1lxK3BOMVRFMFFWK0lpZmVEZlIwSlJiWEpC?=
 =?utf-8?B?QXJZbCs3dWN1M3cyRzg5c2VBejUvcTMyMmtkQUNDejg4ZmM5Nk40MVdlSlJu?=
 =?utf-8?B?WnVVRnVsSWl2QlVIUXRoME5TOGVXUTBzQVRaK1RxL0xiQlRHbVViV1ZhN1ha?=
 =?utf-8?B?OXVxMnArSmF3cHlHRy9zK2YrNU9QN20yWXVvTmh5RGpQNjVKRUtuSmxNL2po?=
 =?utf-8?B?ek9OWVhyTHQ2bGNsT21YSnRWM2EyYWZ1M1NIdEdMeFhnbG1GTS8zV3luYXh2?=
 =?utf-8?B?d3o5RytHSGljTDF1bHJTeWVoNkdTQlY2VXJCYnhYQk5DMU93aUxMVXhLaE0w?=
 =?utf-8?B?Z1R1WE9tRENTM0h5ZmEzVEFQNnYwUDE1SGpSSmtOMlFuelFXUmpkc3k4R2Fx?=
 =?utf-8?B?ZUFsWWJ4WWxob3k0bEtyMUJsdkFNNnphb3JRSEZaOGUvb2lKWnRERmRtNUJT?=
 =?utf-8?B?a2pFZWxJOVVwdllNUGp6bHU0RmYwcTArMUhHUjBZU3NkZU1mOGpWanU4V2JJ?=
 =?utf-8?B?YTd1MVc0SkQwdWFVRGVKWHJucFJHekk5TnI2aDljVllQdFBBS1ZyaUNiL3I0?=
 =?utf-8?B?VGppMUtONjZCNTViTFpmdHRWUnZHdDA0SVhtMzY0VGdNbnd5SmlIdVgwUzAz?=
 =?utf-8?B?T0xxNEVJK0dnSnF6NWFMTytRSjhQOUY4eTEvQ09TTHRTNFhGaG02U1QxYmxG?=
 =?utf-8?B?bkpTa0pSWjR6SkpockNuWkRnVEI1bTFjenFVS0RMdEJUdVNyTUhEc2dwY3pX?=
 =?utf-8?B?Nko1eTNpNlJpRVZsc2llUXVQWTlZOU44ajNJM2xvRlJJdXA3ZUljaU5VWWJ6?=
 =?utf-8?B?WEpxempvdlk0TFpGb05LMU1FTXRxcnZEWVE2Y2h5S3JzT0dWS0lEVWpFN1B3?=
 =?utf-8?B?TE9EVk5WYlFRclRKTndhdEtRcWtoTGFJMmRncHpPMHVNaHBIQVFuZ1UyQmZW?=
 =?utf-8?B?TWNRMUhuZVBTRERSVzIyNlgwR1RwWEtJK3NaMUFHNHJXTGtVUlBxM09POUdY?=
 =?utf-8?B?L0FyaVJxVVVWYVZML2U0V0dtN0RuaHdWN2dLSVp6cmYwWWdydmpwSzM2L1RI?=
 =?utf-8?B?LzlsMHdaTDdYT1RBbVlsbTJIZUxndWw2SXc4YTdsMFNjbkxzbzdKUy9UMjBR?=
 =?utf-8?B?Y1FIek10ekYxR3lxZGExYlR6aG9nYXpDMTVLTC8vRnZxRTJUYXAxZnp5SzlO?=
 =?utf-8?B?UTVZMDY5Q3paTzNFeENQd3JHRWMrRTNJTVhuMUJXY0M4WkpiSFhoSDRuQk1a?=
 =?utf-8?B?bmtBMTZ0d3F0V3M4YmVDV2M1QVhoNTAvQXdDRG9lZ1VEaXR3YjZJbVNGblM3?=
 =?utf-8?B?REhuS0xmamJUOThYWHVKSTBTZW5FK05hQVZoejB0S1JRdWorSDRxQk51ak5Q?=
 =?utf-8?Q?fbBva9VShCOYzVYUZlmzIU3VSJF6pihL?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eFZvcTZ0TFRvcmc3Y3FwbFhXNEg3V3pGZ2xBR29WblZ5dXZYZ0tSS1hvZk9z?=
 =?utf-8?B?cFk5YjM3YzZzTHV2NVVCUldzVU43M0Eva3JtQmpEck5ESkZCdVFoZ1J4R3RB?=
 =?utf-8?B?YzYrYUFKa0Z4TDl0S214ZzlpQy9XMFFqc1pBd3R0NnE2bXVjc2VrMGE1blEw?=
 =?utf-8?B?TEdQRElBY3Z2d0NBUkRSZjRDK0ZabUpxb1BDMWhHUlFjQnVCK041N0hZdEJw?=
 =?utf-8?B?WkF2OWF3V3VyZFV4TmZ0akxqdVBQbGdOVThtQkRqczdaYTlqZytFZTNBYjZ2?=
 =?utf-8?B?dEl3UlJndWw4cWRrZlBqZDlkQ2hsRlhDRlIybTB4SHRteDFwMWRGWXlHS3JK?=
 =?utf-8?B?bmE3dmRDeXdNb1oyTEFrbmZBcUxjWURqdkRpQkFLclJka0NlQzZrTXNlS05s?=
 =?utf-8?B?dnhnV2Q0MWpDQXZIbjNqeXVaUE8zNzk5Ni91NnJDTC9xK3VYR3Ixek5zSmRy?=
 =?utf-8?B?dnlpM3dNOHAycVIwS0d6N1N3RlpOeWwvRGdmcDVWa040bU16UExycHRONCtV?=
 =?utf-8?B?WkRZNWpmd2FySGJSU3ZwZTV6S3lUZTdIcGhXN2h0cTliQUtoZk5DUE8ydit4?=
 =?utf-8?B?VExyMGI1ZW9MczI4Z1lSTUdmNnRGMW5pbk92d2oxY0xjMXFReGVieUE5UEhq?=
 =?utf-8?B?NVBTLzJJVjRVdURNVVp4Kys2Y3h1eko3SS91SFBVOUdVRVJaWkE3enE4d1VT?=
 =?utf-8?B?OFZEcnU1K21ndG9jZG9iWjg4YS9va1FEUHBUSmw4emY3dlB5N0Znd0RPRUN6?=
 =?utf-8?B?bUp3R3M4dGFxRm51TjVxY2VUTkJSVzRiNm9xWmtodlpaNFg0SVpPcytFQnFQ?=
 =?utf-8?B?Y0dUTG16VEtDMGtLWitmb0dDMTNGeHc0bU8zY1VCbmRNNEQ3SXRTN3FWamNy?=
 =?utf-8?B?MmFaSDJoSVlINmpzRW9WajF5d1pFMmllaHpiQmJPZEZ3ak5Ed28zMU4zZ1NH?=
 =?utf-8?B?RjJNWGZCbTJDOE5QME5kbitBZ2VCaytrU3ZQb0g3S2dOcEE0U0hidE13UFRk?=
 =?utf-8?B?NitRelZsZTVOUEpnSC9XY0ZUVGVnZmtqMVNodWlQcjZJR1ZaMFRVQkVTbitS?=
 =?utf-8?B?VEdSc3V4b1JNeVRFZXI1WFR5TDZ5Nk1GOG5rL1lQMFd4a3ljeEhpTHpqUGRs?=
 =?utf-8?B?ZnRKUjhUdlA3NXJ1aGNReTM0UjFBbFRQc0FGTUt0Zm1ZWnNDQWRFR0ZXa0dj?=
 =?utf-8?B?bDRCWDlFbHptQk8rWFk1ZUUxcTRIYnROZVdWRFBoeU83QitRd0wvNlVLWm5C?=
 =?utf-8?B?ZVFhbWdYZi9lYzZyOVVOZUZYYkNlUDJLa2tYakJZVmYwVXBYS08rdytWYXdE?=
 =?utf-8?B?OTRXOEdhdFlZSnF1V2R5U1FzSHp3T21MQ2FyNWhjY0RhVUcwYkJQdXdZZUdw?=
 =?utf-8?B?T3dzdHdJTnc1cmkwSE53MWk2bkpDUTdJRTM2NmZiV1NFaHZTWEN6YlZubnEv?=
 =?utf-8?B?cE1MY1Y4OUJYMlUvVGp2V2o2SzNXaWNYVmorL2d0VlBncVdCY09sUFFteC84?=
 =?utf-8?B?bFRWZktzbG4zTjRtRHJJNUdsQjI1cmcxMnlxeCtKQ0FOTVdhb05LaXpjT0th?=
 =?utf-8?B?SGkrYUFwK3ZvVDhXTUhvTzRjeUJoQklhVllZbG1yZXRPNytLT3RLeG96Sm80?=
 =?utf-8?B?aUF5M3d0eGxrV2NuK3F1MG9RMGYycW84SEUvZE5sWGMxc1gySnVmek5TcUhn?=
 =?utf-8?B?VkdyUm1YMXRHZWdEK2pKcEZUOGk1WTZSbVhjTTc4VkQ2U1RYTHBwV1lwc0lo?=
 =?utf-8?B?d0Z3SVJNMTNUeDY4a3R4QXZzU3cyRkw0OWQ3WUxrRDQ2eXpPaCt2WDAxd1A0?=
 =?utf-8?B?UUg2K1JZTFZ2bjhlaW5tQnJZSGxETFFCdDYwWXl0M0ZJaDc0b0REVU84U2c1?=
 =?utf-8?B?S3hRYkh1M1hnN3hacTJOQVMzTjhzaXZGK0tLekdVbEhGRk9MbC9PZHFXK0Jt?=
 =?utf-8?B?TVZaSDBIT0FoaDZXSGV3MEJ4R2RlRGJqWk5WOS9yN0NIS1N1bDlDUHQ2dUtt?=
 =?utf-8?B?Z3QrdEdDYW5mMHVQNFdqRmFVUTNwUzB5VG1xL3A4Z29rZHB5TXRRampmalVw?=
 =?utf-8?B?MnBuOHA2N2JyZXRWVFd3ZTRPYWRjdTg2Uzd6dktxdlRXNHJwSDZvTXd4WXVZ?=
 =?utf-8?Q?iNFbBcx2lTnGNai7Tp2ZBwFAp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VLB7U5HmpOH+xSDx1MVpiOiUcTMTrJs/XMjtuBTYs3qfLBYToMdNiTK+uev+E4xi34pdLBZzMUK8UM+eyESFIaGEYdrGpUMjxS9SRuqdeNpK8Y1mKILe4zYnE2JxKAi97GdOkF8Z2ePqHRS/JgIJtQo09aTFMlF2CioEjhPwBnDffqoL8wjm2qZHYn/zbGJ4Ptz83vybKQ9iC57WpewwwMt2Fsj8jge7IepGgvZy6DbbjtACtonojwxJEvW62+Fl5hO1JxMHNgl74Cro797F9AdDghSpa3OuXlq94YU+BE0tIOxb50dt+ap5Mi/A1dLdcCVtbnugr5lqvgNpzpdhJ4XJaFgzLJlJYOvDA2+W0qbprImWH+DYZbuJpyMcgSu8Un8VUGzWJufVNHCkOXwvTax+qveI0ikbGVc+4OXdKk27ZdlGpbm4rp+0fIurvQA+EaGGJcjmtzFMlUUJG30PgCliLOKB52Lqsw04E8QqLARpiwfI9bfD6Z7qqS+JmZ2nQDLFSauE0CUxXmwF46EGq2rY/M62TYiZq3Z+Co5fuGClh7SgQlTsjdOG4+3KbfXrEJXuNOa06C9eCndvfoJjVr/JlUZdHp+cniAubqGxO/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25fc7b-4415-4db2-f7f4-08de21392032
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:43:57.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc62uiHub3nUg0C4IS8RysgzurXGOfxS5PeHQviJw4APauX7h3gh+Pscl9g/lE5ZS+jae2YZDkHcGhhEXsHVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110127
X-Authority-Analysis: v=2.4 cv=UfJciaSN c=1 sm=1 tr=0 ts=691359c2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FuZQC0dglYl2rUVoK8MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13634
X-Proofpoint-GUID: liNF8Nrwf59MPdGiXoJszavn-OQkPVVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMCBTYWx0ZWRfXyEca8I0kToPd
 b5H8w/WbnOqLQw3k+sdScZep63I3Ph1H6aeWxMidz3qcsby2UzDS2xHzzLnZF17VZXuNKkjN0ul
 gFDU+kJIZ3tml9TQ/0qH7dYCCv6uK/LIEi9kC6ClB+BNcE9PR+oVmkMGAej4E1rgsqsjbEFN82D
 WgZMW6v42VE9dk/uae83fQH5thBSFZUtcGLNd+dLUskuG9Wqflp/n1pZFtHOB7OVbXxXBttY0dN
 /Ws0lVncZ5qQB/oVUn2W0LJmoo5T0BpjG0R6hD3kFWPC5CLL7PX0J4Dj5dvO1jBKu/Jd3K7Zhou
 fD2cgSgNMNDYe2/lH7W+ycr53+m9/ojrutPOC3LFomt6G9ug2SR1QCjFtD+C0GvRuzsezQ0A2BC
 crCbIM+VKn+NYy8IcbPfBP/Gpf8ZM+Pve6R5K/tDIPH9aBIOdhw=
X-Proofpoint-ORIG-GUID: liNF8Nrwf59MPdGiXoJszavn-OQkPVVN


On 11/11/25 7:34 AM, Chuck Lever wrote:
> On 11/11/25 10:24 AM, Dai Ngo wrote:
>>> Last thought (for now): I think Neil has some work for dynamic knfsd
>>> thread
>>> count.. or Jeff?  (I am having trouble finding it) Would that work around
>>> this problem?
>> This would help, and I prefer this route rather than rework __break_lease
>> to return EAGAIN/jukebox while the server recalling the layout.
> Jeff is looking at continuing Neil's work in this area.
>
> Adding more threads, IMHO, is not a good long term solution for this
> particular issue. There's no guarantee that the server won't get stuck
> no matter how many threads are created, and practically speaking, there
> are only so many threads that can be created before the server goes
> belly up. Or put another way, there's no way to formally prove that the
> server will always be able to make forward progress with this solution.
>
> We want NFSD to have a generic mechanism for deferring work so that an
> nfsd thread never waits more than a few dozen milliseconds for anything.
> This is the tactic NFSD uses for delegation recalls, for example.

I think we need both: (1) dynamic number of server threads and (2) the
ability to defer work as we currently do for the delegation recall. I'd
think we need (1) first as it applies for general server operations and
not just layout recalls.

Even if we had both of these enhancements, we still need to enforce timeout
for __break_lease since we don't want to wait for the recall forever.

-Dai


>
>

