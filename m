Return-Path: <linux-fsdevel+bounces-59732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BAB3D73E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8E63A931C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2021C9F1;
	Mon,  1 Sep 2025 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="w8r5MlLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C021256C;
	Mon,  1 Sep 2025 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697394; cv=fail; b=MUpCTK2+EYB0Wgp34hSvTrcvvsqwrS4vqXpIjGZNXODCKpWU/CrSD8qz7E9NjWGx93vg/UdSU71ZcAmOvc5pussjhai370bawOqyCAWxDMQg35LCqt9mIfNLpBPDelHPEwa4uyNkMVwsTO2pHfGb22VVqal46k3z0JLV02hjzlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697394; c=relaxed/simple;
	bh=zIyUzii2Jma+R0mf9tZnZTzePwYVn0c6Q0xr3/MBz/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXwtIvqbKoPD3J9ZM83XKRUmj3ou07mymkCT+deBupQ8gyw1HgNh6w5OIz3PbhrToW3rv1jybCFCe6lLEmmf9u/yKEwxpKdU93mZeTliceXchc1TorZuTreBa/e5aZkgMKYPCGYpOvsLMB4cDOPo6mpB7Ixw6SdK4yJVdzbCquM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=w8r5MlLQ; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756697393; x=1788233393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zIyUzii2Jma+R0mf9tZnZTzePwYVn0c6Q0xr3/MBz/Q=;
  b=w8r5MlLQzHwNbF14ACoTujiz86ZxJ1iCIGdmgnvL+Bs1LxSF7xVweV4U
   zlK0jCRBdOoxMFRep42b7B27wVfqszhcm/uratbTw2sP64VSSXIyWp32B
   sDhRKOJBS+TUSi+Hh4LL0RmPZFkR0VY8110nbgrZYZDyyOdlYQhcZ4ml3
   9FPvzjC/BJWDg0GKO+s3P9EplN5Dtk3ocuD4Kp91dbcdA36zHfFwnl81k
   f4PoQPuMcWMGta15Ok/QBTngD+Tcn04u1NYaTHmyga9ggHWCb/gv+ZuOC
   fb/42D/fvwww3GZWw6Q8uuBrS+7rR9CfEDrmHivaHarC5Hx3/hEWVqzWf
   A==;
X-CSE-ConnectionGUID: TlpribqRTE+E7iWbybutkA==
X-CSE-MsgGUID: ng92U/Y/R/OBTrrDLibhUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="167269329"
X-IronPort-AV: E=Sophos;i="6.18,225,1751209200"; 
   d="scan'208";a="167269329"
Received: from mail-japanwestazon11011046.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.46])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 12:28:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXC8xQ8AfR7GmLC8Bp57yy2sU+Apjb9iNy6wFxyUMVc6OPz8WSAMbrBVNp5PjtKTtHp8W2DUsmnb2VY9JEvvMbfQDAUuj1tuUW+uM2g+2KcXFtYAsmC7qJxJF5BU5mNflekQOvDnxkCx9pnakcdlr0ePuBTYptaghxK4JYxw5wO0oZSOMCEL1bY3YOHViKBBX2igdhQ/LtFJLhP1sfYqcyATLOy/z+4/G/eYLGpkZAZzuHcHT+Q3WwPpZ9ZxpFetBqQBaGxYfh1bRUjEHZYI01/zlUSvOyxvUjK6lcwciLUmWEy8qxUlycYdEMyNEYxauGU5fvisQ7FciXaFmaRzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIyUzii2Jma+R0mf9tZnZTzePwYVn0c6Q0xr3/MBz/Q=;
 b=EaHTPjluEv7Wb4BFi4HpIg3Ed+8Bm+KPwU0/y7duItSLTpx7jSzKL59/G3pjXiuZWN5b5Sc0N4wgGa3kZTHlhE3eIcJ+8GaRu/nhfUm6VJ+53dE6iRl4+HUU1Ewvk6QKLXBtxxRulO0EMOA+C0rUqLUpE55wNesXpld5gWi/lywlA7QTDpeNW1C0wKDcOjCSWMw8KxuM+M9crxI3FQ00bXvYwOglcA3uSEugA8G545LTdhDBxVSL3YagDUXHdLb63gTytES5YFjB358HAiTV3OkbN/hBrxFZ7t9XaIpDL9lw5gM5hMXOlhMg/8Jly678T9dCnzM943rwi7kdJayK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by OS7PR01MB13935.jpnprd01.prod.outlook.com (2603:1096:604:369::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 03:28:30 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 03:28:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH 3/6] dax/hmem, cxl: Tighten dependencies on DEV_DAX_CXL
 and dax_hmem
Thread-Topic: [PATCH 3/6] dax/hmem, cxl: Tighten dependencies on DEV_DAX_CXL
 and dax_hmem
Thread-Index: AQHcExbIH/bEXJAhM0a/yKLyjAZF7bR9usqA
Date: Mon, 1 Sep 2025 03:28:30 +0000
Message-ID: <e95590e9-5c39-430b-bccd-e531d46c2228@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-4-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250822034202.26896-4-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|OS7PR01MB13935:EE_
x-ms-office365-filtering-correlation-id: 59b9328a-6e66-4688-33b9-08dde9079f78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVZhN3FxTFJ4ZEZuSDRNeTMyem9vbmdXaEpBc1YyLzBFWmdQNFVZNHlSTjQx?=
 =?utf-8?B?RlVaVlROMllPRUhnMGlmd01MeDAzbVNzZVl0c3V3dGV0emxCTVBXQS9GWXZO?=
 =?utf-8?B?ZnEzd1E1Vzg2K1RLZUpHcERrVnFKRndZK0pzc04rREpObGJQcytNK2tmdkE2?=
 =?utf-8?B?VVFUOGFqZ1FWMUFtSkVicUhHemxGWk93Q2crd2o3S3FVdVI3cmZDTnF4b3VX?=
 =?utf-8?B?UDJQNCszeEJlQktKYTJWakUxWUlVdW1CbXdPd1NvR05zUDQ4bjdTZFpQQzln?=
 =?utf-8?B?b0xrQVNvZ0pRYXVRTjZ3WTA2N1pKdlZnMVd2TTJOZUNkRitXWEJwS3lwOWVK?=
 =?utf-8?B?dnZqV0VMWHgxL3NYMnFmQjMzQ0lxZjRjQUxwclNFc0QxQ1ZVVGhyUzBBNFUr?=
 =?utf-8?B?STZTRnN3RFhCekhkSGJnT1R2R29XZFB0dXFQRE1Pd09hR1BwaGptOXZhVnlC?=
 =?utf-8?B?QTUxb2tBdFBHUzFISU52V0FISk1QYTNPUXlPa2hXYm9lazUySmNxN0RyY25P?=
 =?utf-8?B?RmZMQ1FDUmxnZUE2TkpUNDZpRmVobW82ZlAyZnlpUXY4UHBsMWxuTXgzQzJR?=
 =?utf-8?B?Nmc2eE90S2llZ3hLT0o0UmlmUmFMeS9TWm0wYldMZ0x5ZUZVNU1RTXBqdGdC?=
 =?utf-8?B?aWVKMk50Vk44V0NmLzNNOFIvMmJ4bS85dXdYS1ZqSmdGZjdmU0hzRFpKTHMw?=
 =?utf-8?B?b1dEMmRWaEdmK0xEY1BHQ1ltdGJSc0F0aE9xZ1lDYUhTajZXRVRiRVpZdmhq?=
 =?utf-8?B?dHlpcnY2dFVodC9QbW5sS1BCMlJhZC8rNUZ0THZzSmsyR3JEZ2ZuTTNuczF4?=
 =?utf-8?B?Vm9CZGR2bmhobnZEL2dKSmRCN2YzTGY1UnFXNkpGOHRHVnlTOU12QXRCSnIx?=
 =?utf-8?B?ZGZTay9NbVBFdWVJZUJYbVJ5QTFZMmVDZ2E3bWMvczhzMmU2dVprQXJ4Y0dB?=
 =?utf-8?B?S21Ud1I0Q0lDTFhHWmpncElMWVdDemQzSDMrQXBrRllSRWpOdm9IMGZlbVNO?=
 =?utf-8?B?NTRaZG5NMkdUMitMcWN3Q0VsMWd5LzdGbDJUcXhqSWNNYUNCNEdoNzI1MjVV?=
 =?utf-8?B?ZWdKSFF4MmJLZ2VSR0JabWo2RFczUUE1OHlXalpoMW9NWElsTWo1NHZBZXdy?=
 =?utf-8?B?VWZ5RkFNSW1pUnZ0TWpMQUF5U2pYQXZvZkQ0dDUzL3VzaTZSVVlzOUQ2Y3BQ?=
 =?utf-8?B?YzZsMDdyNHJZajFmOTdmQUhOTU0wYU9lUnZkeU9WTEdzZFl0dlN0UmVsaUNm?=
 =?utf-8?B?SHdrcCthMENkdk1rbU0yNktjYzBkWVlhUmU2QlQ1cVRuUlh5YytscWlRVWpO?=
 =?utf-8?B?ampPd212L015eEE1ajBNVERIcWY1OENPd3lWRnM0U2tBaEUxYktSUVYvZ2Rq?=
 =?utf-8?B?Y1NvVmhDVDZCdW1QTmdMbmNEN3lYbmViVnVzZGdMcjdmWXcwNVFBWFhrOCtF?=
 =?utf-8?B?OSt0dUVDcVJibHlLU1lNZWFnblVlYjBWQlB5RjlidjBIVzVPQmhEckFGclZw?=
 =?utf-8?B?aHNjbExoMERha0NBNkJkaExwZk1sMTV6RjExN0RTQ0hmVjRtSmY5TzFjUVlZ?=
 =?utf-8?B?RDdWd0tERGEvZU45L2g2TWk1Uzg0THkyZFRUald0elQvSDJjellhMkI1SEFI?=
 =?utf-8?B?UENCcjlyYWQzQTZIL3dwKzhSQm5Odm9QN1ZIaVBqQ0NzZzFuWEpjTHZrZWhW?=
 =?utf-8?B?QlVEWGVDK29xdmlnUTRPd2NQa0F4dmlqdTNQMTgvZzFTTnQ5RTJhTi8venZy?=
 =?utf-8?B?ODNWb3dMMngxNlZ5SCtibDQ0SEd1REFVNXhaUnhiTFMrQ01KSEJSTGx6RVBl?=
 =?utf-8?B?bkEwcnE4U3ZsYWswQnBtYW5DM0VSb3c0RVlocDk3WTU2SXkvay9ZTWd3bUdm?=
 =?utf-8?B?bDErSzJobXBYM0NiQlRzL2R0RVdkSllidFhMZ2xiZjZBRjVRWC9nRjh4cStF?=
 =?utf-8?B?cHB2R3BMQXdBeUJFWFdray8yRzZNOW5yL2dyZEJOd2EzSlNOVTNTOFBESmpL?=
 =?utf-8?B?ZnMrYkJFT2hNaWVnaXpWMHdJK0dMbWkwQU11aUIvQUJTcFJ4U3M2NkplbEln?=
 =?utf-8?Q?zLo92l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlpFVGJxTUZPYmkwSkhnK2NUaFFndHoyc29FY2podXk2ZUxPNG8yOEY2TVNR?=
 =?utf-8?B?MkpEM3ExNFQ5ZG40T3A4NitSZUw2UDIyTDVXQTg1NWFuMmZxZTZON1lrMGk5?=
 =?utf-8?B?eGM3cnlXOU82MDY4ckh0Zy8yOGJITHZsU3hJSmFrZncveXNXM1dGSjQ5YTVh?=
 =?utf-8?B?ZVVET2xmUjA0SzNDd2N2UktEYnU1anJ0cGxaRU5kL0dLc1U4QkhOYzZVN0lW?=
 =?utf-8?B?enR2Y2ZFN0VOdlRoUzVFbm9qQjAzanhEYnZxWm52S0x5SmRqcVlJTldPdEY4?=
 =?utf-8?B?bFd6YVgzeVc4ekFSZ1NlN0Z3Ymo5WjhvTHBYbEExMmprZHpYZ2Vncld2Vm1J?=
 =?utf-8?B?RkJ5TklxVXpEZGZtUUlkRldhc1VqU3NLS1BQTnVXMXFtYWVERXBQK1UwTm9o?=
 =?utf-8?B?VnJqWHNHRGpoMlBJeTEwVExsbUlMaEtWcXF6bzJ6M1dWLzZFQVVXSnV2dlo5?=
 =?utf-8?B?ZlJjSjRJdjdHUzFJSEtyRzVKeU9hbkdJMVFUWmU3Nk5hV0hsSGpFa0RXdWVv?=
 =?utf-8?B?bkdPKzlRWmJ4Wnp1bmIwWEZaZ3FhL0t1Yzkxa1RoYWppRlFWOEw5Ykg4MGZU?=
 =?utf-8?B?aDdKWlpCRHB2eDhTbHZGcFI4aHZYRkhvWUUrRExPdCtENDBNQ0hTZmtwOE54?=
 =?utf-8?B?Z3JteHRHK2w0Ry9yWmxyemcvYzM3eTJEcHJheXVMSytCczd0a3FhSDFoTEFa?=
 =?utf-8?B?dzN6ejBlWXFCZG1FWlRhaVZZbDZWeExNUDN0SEtFaEd4V2QrbmZwRmpMajV5?=
 =?utf-8?B?WVlXbk50N2MrcHhTQUJlYXNrUkhKcFRDZ2JmaTQ5Q3poZ1dVMG5LeUpTeXZ4?=
 =?utf-8?B?c2E2Z29WUm42dWNhSzV1L1FRNHczcFFQeVZCNkhiVHU0WVVMSWhTekNPdTRF?=
 =?utf-8?B?cUFZNkIwR2xqNUJoUXgzSlhCcHFocHlja1NCUlBYMWxXbkw3ZUVpeDlvRGVS?=
 =?utf-8?B?SktaRXdXRFRyVUlSZ1ZZWFhzLzVoT0pCVG9hQ0QvZGZsWjQ2NVRqWHhOWnUr?=
 =?utf-8?B?SFc5L2RRak82UTFuYzNidTFsZEJTTnlzWUhMRVVSNUgzWm55M3d5ZkFTbXF1?=
 =?utf-8?B?Nk1zcWxpa0N4UUtqcW1OZkhvTkdRTEdHWHZmbzhva05VM2pIZnJ0UEFkck5F?=
 =?utf-8?B?dkIveklLREdkbTFJZlh6T0VUbGRFTThkaHBUMU40WWlmUFE3SldjT2Y0WFNm?=
 =?utf-8?B?ZG1HMEJNT3U5SW1CNEM2NXdIMlFHcm55RjkrdVJNUlprbXVoWU9XajFhSHdB?=
 =?utf-8?B?Z1NSTEFlOXlHajBJT0JSTDcwcnhNTnhPZFJEY0hYVDZBdEZCak9maTRxV1hF?=
 =?utf-8?B?VEc5d3Q2Qkk5aHN5SUh5ZXJta1BnRkp5T3RYb3QxOGZJc2hqZFFFSDdvQTNj?=
 =?utf-8?B?NEhkQVpPZFBHa1NlcEo1bFJqT3FiS09WQnAyQitLWEJNb2o0aEE5b094QmJ4?=
 =?utf-8?B?UFYvKzJFcDBUbC9rSzBOUmo0WFdCUkdKZDFVb211ckVJYldHNFh3ZmJrZEwv?=
 =?utf-8?B?QnRvWTFVUnY2WUF5Y1ZiSlVFOFJTYkhCWk85aWgzd29ob202V1N6ZElyeE56?=
 =?utf-8?B?UlRyNGlvUXgyaWsvOFdyL3M0bHFKZGFqZFJDd21PR3FQNmhuTDN6NXF0SjRj?=
 =?utf-8?B?RS9wOGhRREI4Z3NaOHovcklvMmlYdHB1UWJoaDJPdUJMV0xxUlNHMWxoK3FO?=
 =?utf-8?B?QUhJN0FNdHpxT3lUbDV2djFGdmdtWDFHVWp5a1l0UkIxa0sxZFB6VEdkQnJo?=
 =?utf-8?B?TkpYK0dMNStsSldkTXVIWmpHZUU2MFNhS1lLMDVYSkdFbE03T3JvbkhFeFVR?=
 =?utf-8?B?dmp3UmhEUHBaTWtRNnNtUldod1FJa0RCKzRESjFpdGJlTWxxcjE5SEFIOXQ5?=
 =?utf-8?B?dFVYUzdMa0JqYVB6OWpPN2FkeXRVRHhSRjhLRm44ZUEydUhyY0pkQThtSmtz?=
 =?utf-8?B?bVZveThxZlBqWnJsdHJUYm1WVndFWklzZ2h6Y0IxMzMycjRxc01SaWZvMmhP?=
 =?utf-8?B?eGJCV3VobjRHdkJudUliRUwwaFM5clpDNWptZ1lSbzU2QWlQbFljTWF4bWtS?=
 =?utf-8?B?UjIxcHFPMDlGMEJyS1Z1TERGMjF3bDJtYWlHU1NiM0FjKzFlb3lNWEo5VFNq?=
 =?utf-8?B?Wk5XOExEOFV1cEYvQnVsa2hDRUxnbDNoVjNZMmtSc3p6OGxwNUs1SURacFV1?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C823C0999EB4044A0535C0A4CEAAF38@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RjhEdwDR024hMKzAlQLBOE9OWJB3ZS0SzyxW22H+IvM6xhZfCE9DGJwGTNg36PdcW+d5ecLaO0Tvkd0R/hTKfAs/d9wrp23VgnBUNbIuiiwheyFz7UWhVPD1RU8v7lEz/OvXEUtxOsOQwi7srkmKtzGEJ+BNRamHgbb33xI5/efmdbEiNQtRCc5StJdfQnk7wjq411343F5owEBUdrHaKJaV/b+7MVaVoS6E6gwVq4jQBli+ddj/9wXw/4nJ2GuuK9HQRUM/la72hn/LOmc/AxpV7wFe6qdAOa7Y0DiGMr+iwd7DT0jnPK4Sql1HUUGuFF6SzE9Qx3FA64cobg3oslXLiFCCl5dlBXwqRdbBOwMS7/e3xeJmq/L7MmqOJDjK0uaDC5DfW4+URr2ciib3b0jALGuYqSrzETW2gEEd+dA1DXDRxapY8essFnRmNzXQFGxyAd4O+z/NwaFPqlHDQXOtjbptvgfNxmD8uLg6Hi6u9z+rGFYic4Oc5NL8tDlYiCn1D6LCUY0UxTAXMYOZiUg/B3mXO4rPYIXzYodPcojYwV2jR7YXIlWUclSEigGHIPCxhcbXk7VQf/yLKex4yNou2qyTq2dNsua7IIT9iwGEp66+AaIiBBu9WAIy2oBz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b9328a-6e66-4688-33b9-08dde9079f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 03:28:30.5360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jUEuCMQD3dfRSm1XuSI0rgkBylXdDsTkbhOI+VbW+CkDsb/lXPJPURB5dSQnrIyIPDweDlA3gU/XgB/F8Ow8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13935

DQoNCk9uIDIyLzA4LzIwMjUgMTE6NDEsIFNtaXRhIEtvcmFsYWhhbGxpIHdyb3RlOg0KPiBVcGRh
dGUgS2NvbmZpZyBhbmQgcnVudGltZSBjaGVja3MgdG8gYmV0dGVyIGNvb3JkaW5hdGUgZGF4X2N4
bCBhbmQgZGF4X2htZW0NCj4gcmVnaXN0cmF0aW9uLg0KPiANCj4gQWRkIGV4cGxpY2l0IEtjb25m
aWcgb3JkZXJpbmcgc28gdGhhdCBDWExfQUNQSSBhbmQgQ1hMX1BDSSBtdXN0IGJlDQo+IGluaXRp
YWxpemVkIGJlZm9yZSBERVZfREFYX0hNRU0uIA0KDQpJcyB0aGlzIGRlcGVuZGVuY3kgc3RhdGVt
ZW50IGZ1bGx5IGFjY3VyYXRlPyBUbyBjbGFyaWZ5LCBhbm90aGVyIHByZXJlcXVpc2l0ZSBmb3IN
CnRoaXMgb3JkZXJpbmcgdG8gd29yayBjb3JyZWN0bHkgaXMgdGhhdCBkYXhfaG1lbSBtdXN0IGV4
cGxpY2l0bHkgY2FsbA0KYHJlcXVlc3RfbW9kdWxlKCJjeGxfYWNwaSIpYCBhbmQgYHJlcXVlc3Rf
bW9kdWxlKCJjeGxfcGNpIilgIGR1cmluZyBpdHMgaW5pdGlhbGl6YXRpb24uDQogIA0KVGhlcmVm
b3JlLCBJIHJlY29tbWVuZCBjb25zb2xpZGF0aW5nIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBpbnRv
IGEgc2luZ2xlIGNvbW1pdA0KdG8gZW5zdXJlIGF0b21pYyBoYW5kbGluZyBvZiB0aGUgaW5pdGlh
bGl6YXRpb24gb3JkZXI6DQotIFtQQVRDSCAyLzZdIGRheC9obWVtOiBSZXF1ZXN0IGN4bF9hY3Bp
IGFuZCBjeGxfcGNpIGJlZm9yZSB3YWxraW5nIFNvZnQgUmVzZXJ2ZWQgcmFuZ2VzDQotIFtQQVRD
SCAzLzZdIGRheC9obWVtLCBjeGw6IFRpZ2h0ZW4gZGVwZW5kZW5jaWVzIG9uIERFVl9EQVhfQ1hM
IGFuZCBkYXhfaG1lbQ0KDQpUaGFua3MNClpoaWppYW4NCg0KPiBUaGlzIHByZXZlbnRzIGRheF9o
bWVtIGZyb20gY29uc3VtaW5nDQo+IFNvZnQgUmVzZXJ2ZWQgcmFuZ2VzIGJlZm9yZSBDWEwgZHJp
dmVycyBoYXZlIGhhZCBhIGNoYW5jZSB0byBjbGFpbSB0aGVtLg0KPiANCj4gUmVwbGFjZSBJU19F
TkFCTEVEKENPTkZJR19DWExfUkVHSU9OKSB3aXRoIElTX0VOQUJMRUQoQ09ORklHX0RFVl9EQVhf
Q1hMKQ0KPiBzbyB0aGUgY29kZSBtb3JlIHByZWNpc2VseSByZWZsZWN0cyB3aGVuIENYTC1zcGVj
aWZpYyBEQVggY29vcmRpbmF0aW9uIGlzDQo+IGV4cGVjdGVkLg0KPiANCj4gVGhpcyBlbnN1cmVz
IHRoYXQgb3duZXJzaGlwIG9mIFNvZnQgUmVzZXJ2ZWQgcmFuZ2VzIGlzIGNvbnNpc3RlbnRseQ0K
PiBoYW5kZWQgb2ZmIHRvIHRoZSBDWEwgc3RhY2sgd2hlbiBERVZfREFYX0NYTCBpcyBjb25maWd1
cmVkLg0K

