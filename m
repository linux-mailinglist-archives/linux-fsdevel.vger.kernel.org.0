Return-Path: <linux-fsdevel+bounces-50418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E2AACC01B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F41E3A5356
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D391F7910;
	Tue,  3 Jun 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IYbfacD2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lXeGFh1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6451C5A;
	Tue,  3 Jun 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931615; cv=fail; b=CSzDiTQ2S4oRp1JT7TfViiBDbXrRpxwwDyrJMou0knsgvsAGjB6Qu1fZuBilwzTfRTRxOmDBVfX21d29WUfZgJhoiyUzSQ1bQy5t2NqT/nswtYT4l7kn3OurxCe8RRw2d5xns6+PIz3o1Kee1HE9xnpWj14EQdryuQD6UFos28Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931615; c=relaxed/simple;
	bh=HAGiOCJQo+yjkCSaH+FNcp1VvwN9xdAAI6T66zSTtkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZK8I2hHtiljPaMKTUf5Gng31l56Rb/dLxk15bs5B3eYnEEoO/NxtZYPxAI1PEOThkuaZ+0GNcnWG+bkTULjqTGbT3JWHzYABF7BqVLJ1HPVk6Zk8dnpgPbG/trU68+JJKgWv3FhzkfbBYOt9IfLdQlAei6M68yTmtCzECEZn2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IYbfacD2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lXeGFh1f; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748931613; x=1780467613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HAGiOCJQo+yjkCSaH+FNcp1VvwN9xdAAI6T66zSTtkI=;
  b=IYbfacD2Qjm3fOkP4WLsnGlUnV+EM+TZcuH4wNth3cYB9C0s8W0LAwZR
   /hK9oC1c6orJ40esPwx9tov6y+KuPBKWOWjDI181LrvZRs4wWa8zQJ5Ip
   jO79L2q/rYCxYt3upu6Gxb/kGEJ4Z1eSB3wjDOlsqz+S7rGTg0MmtIJIc
   Qp2fr0QXdxq2RZSl9B5I2M0puzTtM7XEm18abkQ+XmPbptT0Z45ps8RrI
   3q2+nutCw5VI5+R6aM+RyimzubU9JC9YUUCDSXX1NVAsupKdd5GsEEuU8
   z0oAd6sWwF8bgyuHbV0N/lADvTJt2itXZPGfFl1+zKrNfHwMiUW61une/
   Q==;
X-CSE-ConnectionGUID: snZQL0OrTeScj4hy5bfPEw==
X-CSE-MsgGUID: 546pxbhoT4ulYuKHH+FCPA==
X-IronPort-AV: E=Sophos;i="6.16,205,1744041600"; 
   d="scan'208";a="88819283"
Received: from mail-southcentralusazon11011009.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.194.9])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2025 14:20:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uks3LnSvym1sZShD6Z9crCBjekbnDi/msK8zGUfI1c9n3yLBEONjGjo9YS+YDhNKbxmqrn1Xl4gwF8z66VVE+FCFcoYq7hBqGsk6XO+dcsJTrqekDWAQq6apO7QzkC7b2hVBJ9DnsPs7fQsY09jKbZarpRxi5qDnkQAk2Nw+i64wZOEOKeMm7uki8to1P2oUZM9B8emjt7AWukwqjcJyqQE8twHIu8hjjY1rkBOj36bqkTvmibQmh7KjbvVQM7pjnn1pzNRxGrjEb9ZLgsMe5IgEqxAN0rtUD7kn63kGVulKAJddxz1PsbW0iA62ucfNyx7z2vr5gtNKGW8HkJVqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAGiOCJQo+yjkCSaH+FNcp1VvwN9xdAAI6T66zSTtkI=;
 b=XTgsFgxfUAgJq+qxuOGCxJ4oAEmeDFo6MxRasee6PLlz8LsAhGTq6AvQEvjYYxyEK0Aan4qhVWKbd/2ekozsWRyN/hHM5Ii5krbhl2fUwGj45H5MMRkXfWqgS1icR70GDbg95HaN3GHZjKRyKa5fxpwMG1g/H078qUWQVu9Co2n8t57R4IdJv8g2RKNMrNj7F7y3drErEZ18losgnuGGBzZd6HQDCh8qIqHuOSNqsoLTHDkATWoVMnHLeKrIxTNz+mXG/M4aNn6FfAi3uttV/nZpXElmC0EQK04JYcevUArIacSJsLzHPPAWuqoSka3+BBSmvQwepTg9Oe3p0XSCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAGiOCJQo+yjkCSaH+FNcp1VvwN9xdAAI6T66zSTtkI=;
 b=lXeGFh1fQReQjs+t0rLxgXcQUtBm9YRXJgmZONEJzErcbLDatZ0yh5ijJ9GYACgT9etSFLa3R4G03kuV1hPrsRe2PP2HIz0+B7pQ+n2VGf0Sd/loU9/rj0V7VtXiALgrCBoRuimvCQeXQ1GFlnOTbG7XRqZ0ZT63PXt7QbDiWME=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7705.namprd04.prod.outlook.com (2603:10b6:806:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 06:20:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 06:20:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: Re: RWF_DONTCACHE documentation
Thread-Topic: RWF_DONTCACHE documentation
Thread-Index: AQHb09FaZau+RveTXkWNxr5C2v6R5rPwBFiAgADzIgA=
Date: Tue, 3 Jun 2025 06:20:10 +0000
Message-ID: <12bb8614-a3e1-474e-914c-c06171f0a35e@wdc.com>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
In-Reply-To: <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7705:EE_
x-ms-office365-filtering-correlation-id: dcbfca5f-fd0e-4c7c-5a49-08dda266b19b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWZ5Y1dnRTRLNDNUTkljelQveGNFeElQTmZqeU1SVkhIN1V3U2luWXV6TWo2?=
 =?utf-8?B?TXQwWjlLaCt5VzVlY3Blb1Rrd2ZQVmZvRTRJSHdlaldXSHhkdTN3a3dFalpx?=
 =?utf-8?B?dnltOVRQdldEYmxTc1hyWEVOTVVYVEdwa210U1RmU1h6NjVzem1sS3pxcFAy?=
 =?utf-8?B?Uzhrci9EKzhtS0N6Nm9HU0srWHRKcDkxSlNWc00rb1Z1ZG1TWWwwVDhXc2c5?=
 =?utf-8?B?bWRIZ2pnV09mcmd1U3Zsd05qTEhyQjA4MTdDbzh4ZjYxR0RWK0RJUFNyRnhG?=
 =?utf-8?B?Z3oveEVIVjg1VlIxdmVpdDUzM2piaTFuZ2JYcjBFY0Z5ZGdlQ0ZRTXcwTzhB?=
 =?utf-8?B?UmJkUDlUUXV6T3JwT0Q2ZS9TdVhwU1V6Nmd1K0ZkMDE0UGcwdHdaWEd2bHlG?=
 =?utf-8?B?WXFZaEZpWFdGTHIvMHRHZjloVUxjTFJJZkRXd21ZQ3hnaE9IeFJSVUVuSmxs?=
 =?utf-8?B?RkxZbXNnNUxlVEt6MEczV2l6NnJxZ1pHRUdrMVhkVjZqemRVSHpOZG9EZ1NW?=
 =?utf-8?B?V3dpdHFMQUFFeWd0YzllZlowMkR1dGhEQTRyM0FzbGF2a2xYSkZicDdVR05G?=
 =?utf-8?B?S3FzbEVqSW9rU3BIMlFRNUNZR3FXblFCRVk3Z0JEMjlnR3JNWE90YlBhTnZm?=
 =?utf-8?B?NVYveE1VWEVzalFOOXFueTJSWFh3MjdocXNLWHNTY1R6QWtvaHFPWnkzL0ZH?=
 =?utf-8?B?bzdiOGVjSjVLRWpXNmhMcmE5NDJXRk9lZEpJeGFJM0hndnMzRDBtMjlTWmQw?=
 =?utf-8?B?Sm8vaHh6RU9NTFlrc2hlR3MzbDkwUjl3VEM1Y1Jlbm1wZnB2QXBITG96Wmp4?=
 =?utf-8?B?QjRYWkRLTCtxM1l4cjMyUzJDMFI0UkZaWDdoYTlKRXI1QzVvWkxEc0lXc01V?=
 =?utf-8?B?OTA5TDM5STU4WlhZNVVoZ2FHRFBVS21jN1NZZ2RNS1pUVU5BUkVJRmZoYlhT?=
 =?utf-8?B?d1RmcE5NVEcwZGxpT05keXBmUmNRUWUzSVUyYTlPTFI2U0RjVGJVcldCYUM3?=
 =?utf-8?B?T1hWNkRGSml1RTM5S3lHVnlKSTJ4L3RYZFJERzBaSTJFQjRLVklPOUhucUJG?=
 =?utf-8?B?azNBY0NGcFZnbEt5QXIxZ0V2M2JBb2U2M2pCYzlmNFNpemRybjRnTGxlYS8v?=
 =?utf-8?B?YjdUTlU0aFBja1pibWE1TFViWkpPSHU1Z0NId2w1b0h3Y3lYL3lUMUxQYXl1?=
 =?utf-8?B?K2lQTmVmTlR5dEltN0JwRjlEOXlvUEN1WDY4UHhpRmZTV1dLdEJkOGozY2pz?=
 =?utf-8?B?dHBCRVZOYTlxdnN3NHRHOHQ2RGNEcEVQMElMODlkQ1ZaQlordzNFd2pKTUta?=
 =?utf-8?B?T0g5K3ROSTcvd1BabXJJbjN6U3kzcVFELzFFcmxOVHp2MWlmMXExM3QzczQz?=
 =?utf-8?B?SWdsbHRHdHNNWFdrZ2s1dnk3anpuL3NVM01HVjQ4RXhPMS9Ncnhra2NNdEVo?=
 =?utf-8?B?U0NhdTRjQkFhSTl6TjZsWlJ2MldJdHdkazlMWUNXd1ZlWlhXRXB3M3A5YWZI?=
 =?utf-8?B?K0JHQUczNDg3aDB6RDFBcTJqc0trU1daZTVScWZmOU14VVlWVFI0THZoVzlm?=
 =?utf-8?B?VzFNOC9ibDZDZE05djg5L041Vk02ZDR3dVYxS0orOWhrb2JUUWtmVWxBeGlj?=
 =?utf-8?B?dEdlTkxlbGpxK0VSTUlJNVp3QVJFazRQaXZ2b1FBWjE1MS9OekUreTg4bnBu?=
 =?utf-8?B?U3FIZTgvMkc1aC82ZW8raHF4dmI1MmE2SlViR25KaG1kVUdEaml0cGNJYzEv?=
 =?utf-8?B?M2NKTGt4dk82Qy96MWZRS2p0cm1MSExkYUdwSFh2dWpoZkpuNDMvRnN4RVAw?=
 =?utf-8?B?YjVLWlZBdG1aY3FNNEQwVTJYdDgyVTlWbDBSU2tLU1dOdHU1cXhqV3V6NmRQ?=
 =?utf-8?B?UzRhTy9Ub29vN3hlN2NNUlRoZXFkME9Cbk9LL2wrc00zdGpQcjZmWWUvbGdr?=
 =?utf-8?B?M0xWMzI1aVFJdjk4a2JEVkx1ekFhb3ppYzQ2UitmRGRYMmRNMFVLR1JXaEtY?=
 =?utf-8?Q?x2spznc4cXDXzyOLqu+XIpis7OGCUk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzZhRkNvQk1mc2FNaVN1UTFXb2pjSzF2d3FRLzhGMndvZzhiSVJDWHFOdzNw?=
 =?utf-8?B?b1c0Rzh2blNiM3JvVGd5QUhpYS92SHp4SS9GUWd2TVluaXZwNmVaZDRzcU13?=
 =?utf-8?B?UlN6VWNqbjBkZjJZMFlTdWpOaFFIWkkrSTNUQlAycEZMSVFid0N3Um05c0FW?=
 =?utf-8?B?anpoVmpSL2dZbEYxT05kWXZ3aWZIWFNnOHd5MWQ2cFhOUXFWSFlWbXkvcDlD?=
 =?utf-8?B?ZkxlR2xPR3FXZ3RQU29ldXdVRGdnOU9KZTNZWjBCSlMvNjZ4K21qRkd5N0Zu?=
 =?utf-8?B?Q0tneWg2aloraW1ER1ptb3dJMkNuMTVZSFBXcEp6V0o1NzFwdjgramJuRjFC?=
 =?utf-8?B?NnFYMkFTRmtLWGxLbDdYc3FhS2MreVdETlVDVlVOVFh2dmx0dVJLN05jSzYz?=
 =?utf-8?B?RnhXWksvalp6RldUNTRyR2p0dklQa213VjZ2dDdZRklqVk5OTmt6bE1kRmha?=
 =?utf-8?B?QkR6ck9OUmpVL1dpZXpicEZMWWdDUmoyellhcTQ3ampyNGRDeWFoczRueUlY?=
 =?utf-8?B?Ty9pMVNCUWJ5SmNBamNwenF3ZUJjMVV2VHBJM3hVS202RWdKd1NCSndMa1N4?=
 =?utf-8?B?TXVBWENEWkFwekxCc1NEeUdxQTdxMDlqZUNHazVON2hTajE5S2xKbzUvazVD?=
 =?utf-8?B?RE9kRWRBYTRFRGRPWXVCK0VVWHEzVlBuTUh1eGF0V2x1dkRSTkhER2JhMjU1?=
 =?utf-8?B?ZzVkSWQ2RXBicHRVS1l3dk5JT0hjemo1YndCWDJTV3pXcGpTVHMvWTloUlZj?=
 =?utf-8?B?QkpkRTBmSjVJOTRsREhvL2owcmRFd1hnaVlaWENpK0xnNnlrNGR3ck16UlMr?=
 =?utf-8?B?R2pCLzR1WTNZcVUrWm5KMkRlKy9aNjJPOEZPaDF3ZmtHa2ljdVlmSkdFT0lZ?=
 =?utf-8?B?RWxoVVY5LzliWGtIUWc3dTBlRHlGa29reElZTUtQRG03SlFoSXZkaEFrakNU?=
 =?utf-8?B?WEV5em44am5qOURsMlFBY0R2RFRXNi84YzhianhGRDR4QUUxclBISUExRWUv?=
 =?utf-8?B?VUJacXNIOU92c1hTSkwyV0xuMUZmc1J6TXBOQmFkMEZSZlBKUkxveGxvY21h?=
 =?utf-8?B?dUF6c0JINTFQeGZCTTlmOW1zaFhCN1RYUG9WR3ExM3NxTGhPbURrWGJtdTBa?=
 =?utf-8?B?QXk4cUlKM3d4WC9VS2tsNFVvczRnYXNRaGh4Z3FHeVZOenpTdENLMVRka3Fn?=
 =?utf-8?B?WFJGZW42ZktSUmszcDRoWmRWdXFEaHlHbGU4UklKWHNJWkJEb29md1hucEZL?=
 =?utf-8?B?M2EzZytSVWZCS3ZubDlBYjVYcEIxdVhHMFROY1JRQXk0WHpGKzV0VE1KeUgx?=
 =?utf-8?B?Y1FrR25IZEJBV2NUT3NWb2hUUDZ4ZWJiRlJkZzlDR3lwL1p1ellSMk1KVUU0?=
 =?utf-8?B?Nk5id3Z4RlFJNXRTZndRUXRuNzdPeXFjb2xFUkVOOCs3eVJ5VU5LWEs4eWR2?=
 =?utf-8?B?Y08ybGlLT2xpV3c4SEhJOVdmOGV3SENRWjBlM3dJajF3dlpxM0NrZGgyOHNO?=
 =?utf-8?B?MzdkNjZjZFozSVo4RWdjeWVFS01KVmNScDJoT1RyYkdXWGl5aDcvVGpJMjBv?=
 =?utf-8?B?aVlzVnozN1lpcDVyTFpSdFAvU0VXaUtHZzdRU0tpa2FEZkREZXZlQzhBdEpv?=
 =?utf-8?B?eGRpa2FmK29OYktVNzd6R0lQcmVMRG9hUDdJcHFwaUFuRHVhUXhrazkzaG9u?=
 =?utf-8?B?cFdIc2ZIWE9WeitwZEV0RitxTlR5WE4waXdKMXFIdFpNSElnNlRISnFVNzJG?=
 =?utf-8?B?dGRNR3Vnem5VZFlkWXZsNWJvbzlOcXB6MUV1VmJiZUtsMjFESzRLd2pnVGJ2?=
 =?utf-8?B?cGUxWTgrc1B6eHh5T2wybVNPQzBZa0w2KzdPbTllbFRCYXllOVZ3NG1KaFpD?=
 =?utf-8?B?aFdEZklXZCtLSEliL0lYL0JSNFN1YlJNRmZnNytycU1PeWxIclZueHFlbEwv?=
 =?utf-8?B?YlRJNmtNL0pmYWdRZ1gyc01IU092cXlxdExiR3N2M0xqL0pZRlRiaXNQYzZq?=
 =?utf-8?B?ZENYcUpqWmlucHdGVWdOZ2tmbmd1MTV3UVpsOEEzdm0zZGh6c2pvRVpudURF?=
 =?utf-8?B?NVFWWWFneUUyc2lwUUl0WnBaMEF5Tzk4RE9tdjk5TzdsUVFVbkMwWTRudVEz?=
 =?utf-8?B?UHVYNXBKK2FBcFVVUzhJK1lVNFpXS09VandpUFZuS1BIdXZiemdpYzJTNlQx?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CCF23FDC69BCF4AB8F71ED0C3932502@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ur3BHB3bAHXDq1/hQrrGQbyHvzFb8fpvvG1UqgERI2z76819meKNMWRGtiQ7dBPVlnMv80EVy13Rf8vS7tavGgIqagdIbJofzBmktFMnikBuZ2kdFKSYPp8wsImvmf9lWbvp03Gibhe6+C4Nk4mfQ/IA5fw+wCDRZJqxq3eUSXqnAVl6d5GiYRvQBQpGel9qeflcp6C3Aa6Yv7bEhAcJbn0bBLr0SBWLm5iR6uf598b6kEfZ1iujz1+8tUnLOAtxNosaw5H7Ny9fVFiCD6O3MZ6LH8YQPT3AIq9fO3tv9XdypNxDiFXA6HRWQtzYuIyhh3BADh9X0vw3edbUpYkdhvZUR3/C+65B83IZvYp9dnFUqlDsxcj5VZ2bljJRs+Az64ezvgVF3AEBry+HqdtvcDlITOsuLy7eW1A1Z52clq+F9ikBTnstYV2EZ+z0ajYy4saDt8tb6w9PrcjSNSKq60Zf08wwjxfGbZWETh2BYkRrU0rsbvwsymbBMXo6AGkeZ7mTe4k23VoI384lNUoeqJe8qwAJHPGzxyVr4XJ+t5NWPhNCbpY9oCrwKnjavZ7DF5w12RN1RjfTm534mikSgl1Swi4FWrfVjFjCmZ9gx16ry+6COcr8zl80fa85lGs3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbfca5f-fd0e-4c7c-5a49-08dda266b19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 06:20:10.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bZPF5LoEo/YmaCFRFxiUvR7EVuqhnEO4i7V5MPR9wbRkYhaemk1VILsUdJ+vOXFpfAHBnGUR27KptNSUGXYrhYhzPFFHQxTKbNHI8IWf38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7705

T24gMDIuMDYuMjUgMTc6NTMsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDYvMi8yNSA5OjAwIEFN
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IEhpIEplbnMsDQo+Pg0KPj4gSSBqdXN0IHRy
aWVkIHRvIHJlZmVyZW5jZSBSV0ZfRE9OVENBQ0hFIHNlbWFudGljcyBpbiBhIHN0YW5kYXJkcw0K
Pj4gZGlzY3Vzc2lvbiwgYnV0IGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBkb2N1bWVudGVkIGluIHRo
ZSBtYW4gcGFnZXMNCj4+IG9yIGluIGZhY3QgYW55d2hlcmUgZWxzZSBJIGNvdWxkIGVhc2lseSBm
aW5kLiAgQ291bGQgeW91IHBsZWFzZSB3cml0ZQ0KPj4gdXAgdGhlIHNlbWFudGljcyBmb3IgdGhl
IHByZWFkdjIvcHdyaXRldjIgbWFuIHBhZ2U/DQo+IA0KPiBTdXJlLCBJIGNhbiB3cml0ZSB1cCBz
b21ldGhpbmcgZm9yIHRoZSBtYW4gcGFnZS4NCj4gDQoNCkhpIEplbnMsDQoNClNtYWxsIHNpZGV0
cmFjayBoZXJlLiBXaGF0IGhhcHBlbmVkIHRvIHRoZSBleHQ0IGFuZCBidHJmcyBzdXBwb3J0IG9m
IA0KUldGX0RPTlRDQUNIRT8gSSByZW1lbWJlciBzZWVpbmcgeW91ciBzZXJpZXMgaGF2aW5nIGV4
dDQgYW5kIGJ0cmZzIA0Kc3VwcG9ydCBhcyB3ZWxsIGJ1dCBpbiBjdXJyZW50IG1hc3RlciBvbmx5
IHhmcyBpcyBzZXR0aW5nIEZPUF9ET05UQ0FDSEUuDQoNCldoYXQgZGlkIEkgbWlzcz8NCg0KVGhh
bmtzLA0KCUpvaGFubmVzDQo=

