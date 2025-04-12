Return-Path: <linux-fsdevel+bounces-46327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A68A8702A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 00:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CBF16F627
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 22:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061720C03A;
	Sat, 12 Apr 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mHKOeOEH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iA4+fjTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB579194AD5;
	Sat, 12 Apr 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744498468; cv=fail; b=muMRCL6qbDJnzoAyQHaLJ1uDt2kng3PXEGAlNrtn5wUDe8xc3EmMlYOduuIGIVE66BzlGJr2PjPWgOTHt5qsnsdt6R7DM6Z/OWNlJBI/DGGmDoC1PhqCFxzZhQN5J1HFc0srVHUhvA/duA4Z6ll4WjofJBw3hdovLHAFpQ0DWsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744498468; c=relaxed/simple;
	bh=4jNlHZE/U2D4F3Hw2IGWEgiypxqI/lfFZEkqGIVpioQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9p+V/EpvaUnVBVIyXipAASecwcprw2iXP0U47m1mlsSzsFZmbPOQiKkIyiLXANToAqyqBVp1wIXIXJ5SkhRcULtVO0P8uw3oTZLxEjlC8uRHIywOzChRhDpno7fJycSRedivW3viF4ddRMmwu1vfa2g3ueFcxAefKea8v4LKL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mHKOeOEH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iA4+fjTc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CMk0CB022922;
	Sat, 12 Apr 2025 22:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vqrtW4dgtMOkiLCsRlROhBVRZQnDYsUaPi8NX0Q9XdY=; b=
	mHKOeOEHbTVkKScCNghP0Zo9mt+59JnWOo6pRPn+aPxfiTNBEvQeX3AynMUxDb9z
	Vtrwob1ZOVSSjE2AxXsCc31dVO+efZCHzGd/QswbtNvTb9ZOOaehsL+FKBoHFoZp
	vjRegnf153j1pdMdTKymSbvJ0LcWWQ3hTeIAlqZuGWk3MW0YpQvb3tUBFkH+uT2p
	EMyjyF0i3NlQJH02u6pL86Hw+CiilFT7xzk9/H78RYeQZdzFaqxecgBiKtm8RHBg
	NWnK2A+dpizN6Y/1ujSteabfRK7+LEnhV8OXTgeoGF91BSnc2MZdtls+dJ70Kdp4
	iK1wLvJYxLGGz3ZbtIRw4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4600pag0fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 22:54:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53CHrSbg007614;
	Sat, 12 Apr 2025 22:54:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45yem6cbtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 22:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+qbbvYx4wOIdeCPFLapfwYwkNnVLSFvD3SLmKvySfxHatC6mn4mh38oWDUuhzuc9RwPfbbGWhZapyp60HbkH1QgZYMvn92R1/BqlpDBzWMSlSrpR/U7neLD/78NbnWMN4dpsP7knq1ephmfCTUAAxwsX/HZEVOXZOPwmPUCi55F2ocbW72A5Ytz5XXn5vhhkwjJZGpXQ9nW/zOgPzzawVRK/KfrFuShWal6WNOQCBPHo03mtt0Lr2UvXvnnZn/l1B1m76yq5I16oO2go9C5gOG17nCxtrxA1IMVwZ+Q3pI6Pkvea4XzCOVAx5wDeobFMwFEXfQYsruE+C81HtA2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqrtW4dgtMOkiLCsRlROhBVRZQnDYsUaPi8NX0Q9XdY=;
 b=BmXTcw9s5ZFBycNaG7D5fCxz/HZ8HajrtWAKNgN6jW5tV2Tdm4Lo8XgaPiPx6NVbAS0Mcdyprn6Jm+IjD0LOEvbJ6o9AlamVvAp6NxaTihmubH+iRKKzOPySqOxr6CIPtKx0ecTRrZaMtUxMfoPPo1YHmiW8CrSBpuJ7oTV0LOFfKnxZ8T5tdKaCfTmk8IjXPusSvxaJfTJoWCgNhqcLW7xxOeFEU9bzNNZET/b9HaYUzi8MR0EYmrJRURgAMy5cyBFneKLHqE9wED0sgiqdJ+4IG9UUUKTv/BA2CtSLczMNLz5FKwnCdCr/cRhbl/7AAVQzJMTeEtndJ5B1etQNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqrtW4dgtMOkiLCsRlROhBVRZQnDYsUaPi8NX0Q9XdY=;
 b=iA4+fjTc7VXiZsI2voMgyr9gJuPLDTOvMJBXp8jKohW5p7fwgg05FSzvGfACSLsnTQdh2+Y3lweeX9PYmT4FCdrvJg4D9eyMKoiXHY2g9TNMO4q5OE3Smow4AMD/HCkhWKZWE9lDayIasE9twtncYea247e55pNawMVO2gsx4lY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5921.namprd10.prod.outlook.com (2603:10b6:208:3d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Sat, 12 Apr
 2025 22:54:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 22:54:17 +0000
Message-ID: <acb3e86e-f0f9-4bfc-8eaf-26fe2275800b@oracle.com>
Date: Sun, 13 Apr 2025 06:54:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] README: add supported fs list
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
References: <20250328164609.188062-1-zlang@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250328164609.188062-1-zlang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: b1244b09-ae10-4e75-7087-08dd7a14f3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2dvcGpGRyt2R2kwWGNMK0lqb3RvMXdTUlVaazhvRkEzNVVEeXpNeVdYNW13?=
 =?utf-8?B?bERuZ0VrUHZGMjZYa1FhREpkc21jYm4xRlJCQ2sxZEFBSFBHZUJRVkhnVTB1?=
 =?utf-8?B?WjV1dmp2UStIelFlNDQyQWZWbjU1Yml5T1BLMEtyekl3eHVRN2xlYmFJSk9v?=
 =?utf-8?B?UnVIcHFkWk1oa0pud2ROa2QzQnFWNTlDa0xxTGlBbmZ6akYzc3pkR0FZWjFq?=
 =?utf-8?B?YXFUeTIyU2ZURmRGcUplZzJxUDd2Y2V6Q0hjZ1F1YmZ3ZUNIaExQTThBVVB3?=
 =?utf-8?B?MndZTGhyV09yQTJFWmJLY0RRVmwrYzNHWExIOFV0aEMxS210cjY3dEJjem15?=
 =?utf-8?B?RG43Znl2bnFCN1dONEVuV2k4Sk9SMFJRMlZpUE9WOFZ2MXlpZ2VQbFR4bEZz?=
 =?utf-8?B?SGk3OXBtQUN6S2xiZ1pHdzg5bU1QV1JHeTlhVERsbm5LTUhRN05NYVVpZkly?=
 =?utf-8?B?SlRmSHZGL2hmY2M0eHhTYklxMWQ4Y3RDZEVranZhNE9aYThhMzV3eWI0T0hS?=
 =?utf-8?B?LzRmT0pjcFRBODZBcFhFcGI5N3dtdjhZdGE3M1c2dFdLRlRiQ00wVjc5Rmh0?=
 =?utf-8?B?Z3VHaEJlYnZhY1RKKzlzeFA4eVBFYmFGbnJXcmFFRGxMVmdkb3l4N3FYbU4y?=
 =?utf-8?B?NXNQcHZEZkxBUXVxYW0rK0VuTk1WWnNteGNYakhCelFrMm9CeGNpRTdKT3lv?=
 =?utf-8?B?aDFhRmh1VytKNFJGZ2VKemNIcjdqVDRDM3FLWHpGSTVlUW93RmFmSldJdnc5?=
 =?utf-8?B?NEtqNVgyNU05WElhc0w3Ujg2a2xlcVNJUlp1UXJXTVJMb0ZQaXVHM0JtVDU1?=
 =?utf-8?B?UzVhU0xGS1d0SHdiS29mV1pjVXVsdzE3cHdqYWo4NVAyd05RUisycWo3cUNE?=
 =?utf-8?B?djBacThmbE96T0phd05UbGFtYVRqOE1ydTkxWGNxbWN4VUVzVDRaNUNEVlZ1?=
 =?utf-8?B?T2ZTbDJHQ0lMWlZYZDJ6YktpVzVJa2hZODN6K3FKL2tkay9lbUNjR1ExbVM3?=
 =?utf-8?B?ckxvRlo4K2dwdm1zWWRlZHlSb2pwNFNyQjFhSnlhb0ZTZDVuQjRUV3VwT1Y2?=
 =?utf-8?B?cDJzMm5valkvTC8vOXlWdk5kNStVaFllcWRZR1VQaTRIek1KNXFOV2Z3RC9o?=
 =?utf-8?B?ck1lYkRMTVZCNGw5amIyV01VOEZ2bHp3OU1DVXMyaFAyZlZGV2VYZ2luNnBz?=
 =?utf-8?B?cTJjc2xTWW1TU0pBdTE3Yzg1cEduaEkrOU5kc2tKeVBNM1BhU1dXS0FVWHZT?=
 =?utf-8?B?Z3R1N0x3VzJqU2d1ZTJVcnQ2d0s0OTZpWTJyaTdWd3lQZWNDdHVObmkzUjMr?=
 =?utf-8?B?QVEzV2tEaUlkZHQ2TWpDUUF3ODJFb0Z3MWIxY3ZkcmFGQUZDWmo5M2cxYnJz?=
 =?utf-8?B?KysrVVR2S09NZ0VTaFVlNnk0Q1NHZXNCODg1OWpyQ1JnWmtmRFV0dm9SdmxB?=
 =?utf-8?B?ZTcwZzdQWi82STZIbFQyUVFjUC9wdlY2bk14WGZCYTlXNk1wUGpwSkc2enM0?=
 =?utf-8?B?TERVdGprT0U4dkZJeTF0YjZGTGc3b01nMS94UXBROVNHbmdodVZPU0xEU1Vh?=
 =?utf-8?B?T0JKMDVMU3l3M2VKeFREcWg3VkpHSXpocFdsREkvWnNQaHdLck5RZmZSbkxn?=
 =?utf-8?B?eDQyWmg3Yk5PM2hxdGdHeXU1cndBdkNENm5tN0RsYjc0QTh6TnhHZldmb2ZJ?=
 =?utf-8?B?K1kvNE5XRUV6ZzBYRXRQUjZTSGFydEQ1aXpZdGtnTmRtT21JMWcxVkY2VUFN?=
 =?utf-8?B?ZUJRNkJUSFdpYzdlR044UE5YUWpZY2owU2hZK1RMTW5vTGZYdi9aUmhIS0tF?=
 =?utf-8?Q?JY3WzOnzFN4Hr8f6CMsjHgYBO89Z+aU0c66yY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTNkRWFQUXNGbzJYRWNCbk0wZVdiZzBkZ0kvNlF5RC90d3N6SjhrU2RrNTBy?=
 =?utf-8?B?a0ZiUWF3MWViSCtGQklLSFp2T1hPbFh4Yk83ZS9yeXZtZndvWndZVVB4aGhO?=
 =?utf-8?B?azZ0R0lVQ2REU2hzZHl6aFF1Y0dHaXVqZ09wV0x4NExJSVI2R01pQlRUL1Ew?=
 =?utf-8?B?RTVjOVVnMGZvT0NXdHYyb3BwODh5Y3N4ZkxpSGUxVEQyOE16TGJ5TXJONC92?=
 =?utf-8?B?WkhVdjROSGFScklIblZhUEE5eE4rM2Y5VXp4cC9TZys2T3IzT3NJcGxOdmtw?=
 =?utf-8?B?V0drUkF4WUc2VWRlMGQ1S2JsVlp2Rkk0MGhxcTlaOUliVm90SnowR1VGSi9y?=
 =?utf-8?B?azhKb0ZYdnNhcW5KVkhiMGJvUUZETUpWTDluVHU2WFdTS2FXMU5TaUFndlFq?=
 =?utf-8?B?bFBkU2lMejVuQ2hMM1ovQ2d5RTJFRjdHTnM2NnpOcWNINFg4N1dKK01nanZp?=
 =?utf-8?B?Wkt4UnhZTm5kdEtXTVNpTE5SdVdzS25WZHNWUTh0Tjhvcy9JQlRpQldKVHB2?=
 =?utf-8?B?akswaW5CSlFteVozdjVGdFlQVldNVHRzY29EdHVZV1EvUDdncWJzV0E5UGlC?=
 =?utf-8?B?ekVnMDhBRmVyVjFsWWEvMjFqTWtGMzNNMTJETU1mVXpkaldkNnFuU2ZuekF4?=
 =?utf-8?B?VGZqVkFNSHc4ZllLM01UcTEvK3JYbzE4MGlBWjduWFhuSGJ5aGQ2amI5ZzFP?=
 =?utf-8?B?N0xteTMyNGwza3RNMCtic2hvUUhPT09uaW1ONmY5cHBhemVEYityMzUrMDJ3?=
 =?utf-8?B?TndOMSt0cjk4akszSjNsT0dkalB5UG02bjR2YStZTnllYVAvb3BWeVoxMnV6?=
 =?utf-8?B?RnNnK0VZWDlta3dnZVBQZDdqVGxZWUQ1WlowOWhBZExiS1ZVYmdMRUl0QXh1?=
 =?utf-8?B?UUlkeU1UdDJ3NHYrRGlzYjVxbVBPUlhoa2xrRERtM2pIWkdjUDlQZEhoamcx?=
 =?utf-8?B?SmViTzdsWVZqcXBLeWQ5SzZRWkZDUjYyOUhsU3crR29ZejFGOVFvQUpXSWxK?=
 =?utf-8?B?d0tQY0IxVWIwSmFralpidHp5WG03MEd3S2pOSEZwSUN2SGRVb2swWnhTTDlW?=
 =?utf-8?B?eUQreU1mNjlvYzNIdjVmUTFqSUppM1k0Z055ODdMQWRPTXExTXJBemMyWHU5?=
 =?utf-8?B?QWhpU0N5eThzV0lZU2R6aktPTG9MN1VDZVVuRHA1QlgzcFIveU5zM0lSS3pD?=
 =?utf-8?B?aEtYRzBVK0hoSGJqMnFEdUFMWnNEcEdJWnZPT2tyVEdUR2hhTWFLYlFycjl6?=
 =?utf-8?B?eGtxU2tyYWhzYzJOK3lpaHJqV3J6SzZGRGp0NFQrQVQvZXhDWHRmN1kyOXBJ?=
 =?utf-8?B?V0o4OXh2by8yMHR4ZHlQK2FrMkxjVFBqVGwxY05GQzI3TXNZS1RlTU9jMEdn?=
 =?utf-8?B?VWJHeHg1UWtFRm94Yjd1VUV6cGNLOUE1S09hUDdqYUE4WVJCMFlvR2h4YjZr?=
 =?utf-8?B?RjBIVy9LUXJYTk1HNVAxMFVYaTc5dWdqQUJVOE5LbUZkTTZZVGs5WlVjMWVR?=
 =?utf-8?B?VW5PcWJUQXpVTnRZcWhUWDZuOVRBTEc0dm93RUcrd29ubDcvb2N2YlpVajZ2?=
 =?utf-8?B?cTFFNEg1eWE3TmtpcU1qUlJOR0V4cFY1N1hRVmR4S1ZqWFNKOW8vOWRSbnJH?=
 =?utf-8?B?ampZYnRXYS9FSTU3MmdVbjB0cUZIc1Bod01BdjlLdlBNbXhSY29mU3c5NTBq?=
 =?utf-8?B?dUFWWFMwaFFNdklucUJjNDQ5U3dMcmxQeE5XUlhvMzBFOElTbktOZVRqcEc3?=
 =?utf-8?B?eW1zYUVNRlU2RDdHN1pscUZvWjVIRHNBL3BLWGQzdDNDWVpVN1Z4YVN5d1Vz?=
 =?utf-8?B?d2ZuM01BZlhqNjkvSnBnU1hxbFZrYlFhYmd5dnpaU2ZpZ2d5Ull6SVBoUUs4?=
 =?utf-8?B?d1VzNWZ5TDN1UUh0MVJOUTl3cXhNNGZVTnZrUnJIYkJGQTd5S3lYeGFzZjdh?=
 =?utf-8?B?Q09hZ0FqVytBVlN0UUk1VzQ3V1RnaEtnNys3TUlhV1hqcWhpeTFZb0U1eWNj?=
 =?utf-8?B?Y1BkQUxjV0duQzMxczBBU1ZjWDdpRE9NTy81K0Z3cnVsNnlha0Q3cGVkWTJL?=
 =?utf-8?B?WWFGc1FEdnRNYVczSXhLRmJjYzl1WkNpWkYwNU9NbldJd1FSZlowcngrRDcz?=
 =?utf-8?Q?tlEUB0BAa3pgNoHyN5Fm6HBaA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DkqdhlSCgZKZlLmcZkU7IYDBshSidPtPXp80E19w21ulBcEVZWXnXLroaY9Xmya4NP0yjVjHYL8mRTVvybBsPJMfLYKdpGNgl9cf8lHNtWMMaRjRrKh1iFtfBaD4xAAyKt1pGg46C6Xpq27KJgClpLv1Q1AqYIWmByJqxu+6w3L6awTCVF4eqe0GgnIjIvQD35dFdxPEPVbfc+3FPGgGuvC11eA3iMWt8lXNlquspz64UA8Mjcnd8V7det3QN7WDq81bcamSZWTzvIK0BI1AdWUEnvTuz+BmsTNC+1UMYUV4zUWFQ+tOCiRQ4zuhjtd+pXP4h6R2MJ1Vhe4ZSUhbR/L4vqLKsWX9OFnEshskBM1Mch69odnxAvuO2zEfrq/cDHb0JuUB/xIILUh8zURiRLjk0kJVpjninQtnewQs9mwH5HEqiyswErPGcKx0kGQh9rD+RgnEsG6sqvoN3VWuHDIYtZS58tGllkLIGrf7dzA60UfDN0S6BqDQz2Q+TCy4ZNPBq7zMBhI/X9Woq/Wg1zyvdrtvxWgStLjadSh6Z436Ke+aVgJjQPhUDVw3JeiF1Suypqn2zGjpdqE9e3wPFSYUU7WmG+12sawzBoYeEnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1244b09-ae10-4e75-7087-08dd7a14f3d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 22:54:16.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC/X5/3V+ahQFF1svybBjbvZulP4nJABLrdio+eTfPdwxf4wl05BZmlkMc+XyVe8ZCzXpyW4tTVhmrjuYnvGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_10,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504120177
X-Proofpoint-GUID: bmemSLGZ7mz-OPAGV2vkOH0peahFUPg9
X-Proofpoint-ORIG-GUID: bmemSLGZ7mz-OPAGV2vkOH0peahFUPg9

On 29/3/25 00:46, Zorro Lang wrote:
> To clarify the supported filesystems by fstests, add a fs list to
> README file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> 
> The v1 patch and review points:
> https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/
> 
> V2 did below things:
> 1) Fix some wrong english sentences
> 2) Explain the meaning of "+" and "-".
> 3) Add a link to btrfs comment.
> 4) Split ext2/3/4 to 3 lines.
> 5) Reorder the fs list by "Level".
> 
> Thanks,
> Zorro
> 
>   README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/README b/README
> index 024d39531..5ceaa0c1e 100644
> --- a/README
> +++ b/README
> @@ -1,3 +1,93 @@
> +_______________________
> +SUPPORTED FS LIST
> +_______________________
> +
> +History
> +-------
> +
> +Firstly, xfstests is the old name of this project, due to it was originally
> +developed for testing the XFS file system on the SGI's Irix operating system.
> +When xfs was ported to Linux, so was xfstests, now it only supports Linux.
> +
> +As xfstests has many test cases that can be run on some other filesystems,
> +we call them "generic" (and "shared", but it has been removed) cases, you
> +can find them in tests/generic/ directory. Then more and more filesystems
> +started to use xfstests, and contribute patches. Today xfstests is used
> +as a file system regression test suite for lots of Linux's major file systems.
> +So it's not "xfs"tests only, we tend to call it "fstests" now.
> +
> +Supported fs
> +------------
> +
> +Firstly, there's not hard restriction about which filesystem can use fstests.
> +Any filesystem can give fstests a try.
> +
> +Although fstests supports many filesystems, they have different support level
> +by fstests. So mark it with 4 levels as below:
> +


> +L1: Fstests can be run on the specified fs basically.
> +L2: Rare support from the specified fs list to fix some generic test failures.
> +L3: Normal support from the specified fs list, has some own cases.
> +L4: Active support from the fs list, has lots of own cases.
> +
> +("+" means a slightly higher than the current level, but not reach to the next.
> +"-" is opposite, means a little bit lower than the current level.)

So far, we’ve defined only four levels: L1, L2, L3, and L4.
The "+" suggests a transition to the next level.

But when it comes to L4+, what’s next — L5? If so, then we’re
missing a clear definition for L5.

Thx. Anand


> +
> ++------------+-------+---------------------------------------------------------+
> +| Filesystem | Level |                       Comment                           |
> ++------------+-------+---------------------------------------------------------+
> +| XFS        |  L4+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
> +|            |       | notes.html#fstests-setup                                |
> ++------------+-------+---------------------------------------------------------+
> +| Ext4       |  L4   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext2       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext3       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| overlay    |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| f2fs       |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| tmpfs      |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> ++------------+-------+---------------------------------------------------------+
> +| Ceph       |  L2   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> ++------------+-------+---------------------------------------------------------+
> +| ocfs2      |  L2-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Bcachefs   |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Exfat      |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| AFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| FUSE       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| GFS2       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Glusterfs  |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| JFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| pvfs2      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> ++------------+-------+---------------------------------------------------------+
> +| ubifs      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| udf        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Virtiofs   |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| 9p         |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +
>   _______________________
>   BUILDING THE FSQA SUITE
>   _______________________


