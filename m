Return-Path: <linux-fsdevel+bounces-68936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C0C68E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E8D4F058F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9593191C2;
	Tue, 18 Nov 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IBPHcqBU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mQSk2RDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B63308F2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462906; cv=fail; b=WZ7eseRR4JSkbeUHsKOr9l7UcuD7a01FkctraVSbQxVay1ZQCXzO5exVF/8S0OztlMnQGX43/Uur4pYOnDWoNx3+khwlBIbjJaeATkpDbdvfBrzGuX0FLI2WHp9gfJXzTB0QG1G/x6C4yR3OBQaneYKHboCtMB/NYQbnZpQ2lNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462906; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UteRbaqLi6VPt6f1yZaExaLV25UXDvrzPkdBRNp+CsbtnPNfrB8LyE3X6+xMyy71cbXlp6FYqJS8uDo8CexilwsiTqmE02lPz2q6s+RqUFNxcStH+uc2xXS0ysAzNtSBVBP+cwNWZFgBviHwwLILZUkmN6pTDrqJDKc+0XwNeE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IBPHcqBU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mQSk2RDu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763462904; x=1794998904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=IBPHcqBU11LMeToKMaer2p2G7QpupC0082axbPJ73D9i58t/5//JtIaB
   mVVhB1njqRIXnxWOe/axUaSOIu9VmRXs0CsgIaMUHNSFWS60oY5FQn+Qx
   TYdVXv/ZIf81vVf/fnObxpx6YQXhGH36r7KnjtyD6Uk5+7o2XocDxkmOC
   HuffUCHVuG2tSlJaQShFOarZpGL36T53dnmxxOiPUenX/T3tfdLxfbM3U
   N1WRjoe177ABrY38cmy6RQSVDz0NIU6jz57qj/hA3Sz+H3jK0K/Id6jwv
   ghC7wnkfJf0OLpU1pHDq+KQ6AckP7KSeB89UtRf2wMwjO8nEtSShBZB2C
   Q==;
X-CSE-ConnectionGUID: kTUclB0BQT28O5K9QHX4Lw==
X-CSE-MsgGUID: pMDHjt7ZQLmfnKyyXZZRQg==
X-IronPort-AV: E=Sophos;i="6.19,314,1754928000"; 
   d="scan'208";a="135328758"
Received: from mail-westcentralusazon11013002.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.2])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2025 18:48:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh295znS6PNQw7DwmRlQHEVEhcSQKoML6ElJYDM+gkz+ojPTlfxg6AlI6xb66zjBaTXiEF8liG0emwSY/XEuiXbRvymqKarnIYKyKreZ2DnwwMShuovPZTqmWK888RrKJwygS7l/SqMGe7eao1OOBD2lUOke5cZ7QVpi4tpxad5bQ5+HnlYtv9zEmIwzBXN6HEKGwKGIpV69KgW7IgoXku5GQru9MIWhp42Pp9lFGG+CJv/edo+UjzhiPb1DC4daJVBoIlaKxuzMwtMy/8U93m2R4kpnh+wPshq0rUf17PY0zF0slS9V205kIrV9KzKslgOyakeNLuOWYRxQZ3BNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=BORwZJtvS/dFawPew0FNMBEhE21zBQWFSw61COGWiB/JPJzHjx0fgMAYYBxw1ppGruljYzpFav0jwyhwwC/Mo3UsI1WaB7FTlT76kMd/zRVS/H5KRNPXKbvWpOjFugx73ck2sT/9X0G3d04Xhn5lCb4uqlMtOkOrAVMCFNljpJIbU2i9Mtyj2v7uCjb0oG7M9gXO6I8HqChVgfWVeCrqvZSI9qMvFaDYZzDDK13ejS6ofjaWXSoRp0C2VvWtAFEXcJfyQbR2hkYtMZR0cJqkYR0bKq9M1/HVLUzbRcO8Px2MrmECFdVAMorsUZgkcTVwTf2wI5uKDPn8SZjsIo1kCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=mQSk2RDuqqepuj2FKIPypc2uauaP7siJ/jgXwbfTMIqsOSizLBRg0u310kCzNeTryGnRThrCrYPd6OcpYphycTeUTgszVpGYvmlxSTEmPNQ+1M1ZqfZ6z3zxebn8dTEKbNnyJnEzFA0ZAmMWZFx+qCRF2adfy9V6OrOxTN0Ll5I=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BY5PR04MB6993.namprd04.prod.outlook.com (2603:10b6:a03:226::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:48:22 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 10:48:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "jack@suse.cz" <jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Thread-Topic: [PATCH] fs: unexport ioctl_getflags
Thread-Index: AQHcWFpYO3eeFzvHeU6rWuZA7DY4R7T4QQGA
Date: Tue, 18 Nov 2025 10:48:22 +0000
Message-ID: <13bf32d4-8f84-403a-9571-65e41bd4c96e@wdc.com>
References: <20251118070941.2368011-1-hch@lst.de>
In-Reply-To: <20251118070941.2368011-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BY5PR04MB6993:EE_
x-ms-office365-filtering-correlation-id: 6f65a543-d7d7-404b-4bfb-08de268ffe39
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjdBSkxNemR1N3JLa1VVZ0ZNcE9waUplamZVcG9ybFd3ZVdGL3pDZmdYaDhr?=
 =?utf-8?B?SkhTdUZWaUxndHF5VVRPcGlyRnpKL2RLN0RycXZ3NXJ2MUxmU1k1VFhtOVVw?=
 =?utf-8?B?NGdOSUJoOEk3Y2dFR1lreSsxVythaEd4ODNYSXFkY0FCY0RadS84SFIvVDJC?=
 =?utf-8?B?TUF4NnR4ZkVhOVh4b0xVc24wT0hNNHpOVkxsNk1pV2V6c3RScUY5Mi9tNG9G?=
 =?utf-8?B?WXVaL1NSaDBVR1FjbHRxYlRoSWd1aGJ0RXhLeGp2SWthNHB4ZGZNYzBkbmFl?=
 =?utf-8?B?SHp6aEY5MGpZcjA3dm1VR3A3a0c0SysxUzQyZ1BzeHdZSHNDY0FNVWFjdUFO?=
 =?utf-8?B?akVlNGRSUXMxajhEVFBib2hNRTlma2Z3OHE5bG9qOEg5YmsreEpYQm94V3hQ?=
 =?utf-8?B?VVoyVlNKRGRaaG5NOEFzNVJUUG5DbmlRcUFQQVBCMUtBVTBnRUEycVZINlpL?=
 =?utf-8?B?dnN0SmxaMElHQTd5Y1FXRXZqbnYwQTRLaldmZE1YS0ZjbmhSaFlWSHNaRVph?=
 =?utf-8?B?YUJTZG4vWnRlSkI4NEhQYWxkZ0xIYjZZaGs1cUNQcEpNZlFiYjAvL25pRFM5?=
 =?utf-8?B?Ykx1V2NlUHFObzNIUEFiUmpGQTNTYXRqd29VbEdUdk5iMzhaeW5JSEc2eklP?=
 =?utf-8?B?a3doT2ZuRmY1Rzlrc0d6cWU4REZKZ05XWTBSMVlhWXJrN1dPejFpWkhxOVA2?=
 =?utf-8?B?cG02MS9PSFpYbElsb0xkZXdXbzFrbC8zTVVuNlJqclR0c0s4YU83WjBuUGdl?=
 =?utf-8?B?SDg2RFFNTEg3REJMWFVYSElERDFaeXlpcnhBYWMxQk8yWlRQeWx1RWlkcjZP?=
 =?utf-8?B?bUcvUjZnSjhxbkRrRDlZN2ZyZTR4NW1WOTdRc04zUUFWVUNsRHJlZmNER2dB?=
 =?utf-8?B?a1B0TVdDcnRaVlVhcWRqQ1YvY0cvWWUzQkw0ancxTFgrQlBUSWRaVncxeVpU?=
 =?utf-8?B?Nkcwa2EwK2lBc3BpOTRRaU1tRklFTVQyQzJLR3ZFUmw1elhCL2k0ZTNhWDFW?=
 =?utf-8?B?SmV1MmdPMytWb25mUDVRNnpSYTZmdVhlVzhhTlg4QytTdjFwSkFyL3RZNVFi?=
 =?utf-8?B?M1YrTXpSZ3E1bmJ4MnFTSnNiWlY3Rit1SnhCYWI2d0RGclNxY2tWak1XZ1F5?=
 =?utf-8?B?eUJRRFRTTHR3VEJLNHdSTldPUFZtRUlIU3JOcE5hNDBSSUt0bDNWU05JM3gy?=
 =?utf-8?B?MkV6NFZRMzFybU5PT3ZvNkpUNTlPY1FEWStiZFlaWjZjUGlSSUpNSmZYRlQx?=
 =?utf-8?B?QTAwd2RPSG04LytjcTl0Nk1CWldkc3Q5Rll1Q0Q1eEpJWFdsQ1RCaGltbk9x?=
 =?utf-8?B?NGxDdk5WVWtqcE5lMk5VTjdwYUtwUEtnUGIvY1M1dWpHVjVZSU50UnJUek1P?=
 =?utf-8?B?ZXNIUkE4SUFpRGI1Ulo3eW1nR0p5b1prS0M0ajk4YndPRnBEUi9rMy83Rm5U?=
 =?utf-8?B?b2QxZ201UWdGd3JXK0ZibkFrZk9iUkxJb21iM1lXTGVHaWNZNjJ0TkxIQ1R0?=
 =?utf-8?B?N1d6SU5vRWtVM09iSldYNFc5Z1hxQ2txak9pNFJSQ25kbHFFVk5QWkd0akZr?=
 =?utf-8?B?aktTcHJVa1QzUkREbHJJbENya0lxWGxkZ01yWnBmWmpOY1ZISFNOb0c5TWVD?=
 =?utf-8?B?ZjU5b3k3TE1WcWgvNlYrSm9KcXgzaGY4L0E5d29XZ2N3WExZNnVaa0d3eHB6?=
 =?utf-8?B?Wjg2NGlKQUlBd2pqbnlWT3pNTUt5WEVETkJId0txM0dDalBYWUlUZUZlM29j?=
 =?utf-8?B?bituY0dDNjBhSWEwOXh0NjZ4Q2t1WmlyNGd5SWRXUFptMlIvalNrd1pFRGJ3?=
 =?utf-8?B?N3JES1NCNHZDMWFTVnFtclI3Yk41UHU0UmRrODllWVZ6WUh1TzRybUdGUGda?=
 =?utf-8?B?VFNRaVU3MksyeDJ3QTQwNnIybXkzQktyVERhQ2FhUlMySXNFTU9ORlVkQi83?=
 =?utf-8?B?UnpWWG9QclFmN25hblgvRW5KcXZYUUhydnM3Vjd3OUgxakJsT01ORmhVUDFD?=
 =?utf-8?B?bndzRTVBanViUkJ4aEgrV1lCVGdGa1YrZ3BvMzMwT0taN0FwbE9CaUFzWTdO?=
 =?utf-8?Q?DqUDsK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE1GWE9CRkxmY0Faa3V4S3hYSE14M1F4OHFJZ1RhK2FrWFhrMlZtdGFqcDhT?=
 =?utf-8?B?ajA0R1F6RzNpcnkxN2tNM0w5YTliTkpOaEp6OW5jMHp0UWFzTlFzTUZscFlm?=
 =?utf-8?B?aDhxVktzb3p4WlJEWHpNdUQwRzdMWDFmQjdCZ3BIcnp2c1ordG05bEVVWVpB?=
 =?utf-8?B?ZkpCZVF2cmY3bVBYbE10M0IzZmF3TFVyVXl6SUFvSGl1NXhRS1g4TWRlUEE0?=
 =?utf-8?B?TFFCcnNZNGpIcUJHckdwRmdIZGMwWElhYnc5V3c4RlpLYmR6bzdXdTNNalJS?=
 =?utf-8?B?bXMzdVNqU3hGdEJWMnpyb2RlK2RNUmlnRHkyMnpmRVk1ZldwLy94b3dkdGoy?=
 =?utf-8?B?TE5LK2IxK1JkT3BrOWgyL0hyZFBlMGp0cHVqSk1kbHpuZFRYNDVqemVYSU9j?=
 =?utf-8?B?RXlnbmdOOTNOb2x0cWVDUE50b01ZUldZM05wSHpqSTJWOHJjVDU3Rk1nVG5l?=
 =?utf-8?B?U2xYQ2JOamJ5OHd2RUo3Nk1rbnFiRFFXRzFHVk12ZlljZG9HUVVwZFhPV1Jh?=
 =?utf-8?B?VUZXWjRjbi9NSDRYVjVKSStZZkxXNDREdVFPOExDc3JCL0NSd3BOUndsb0ts?=
 =?utf-8?B?LzFoY2JEWURoYmZpdzJyeWVnZ3c1YUcyR1NPb0k2M1BCZmphVis4RDE4azdV?=
 =?utf-8?B?c3JpM2hROFZjWlJaR2VYdmZoc21zVytSMXozZ09xWlprT0ZWQWoyalFobSt2?=
 =?utf-8?B?Q2NHbUplMjBXMzZ1NDFoczBvdEM5UXBCY3NyZ09ZQlJCQVFlY3pYZndEcE1O?=
 =?utf-8?B?OTBNc2dBcG5leHVrUFZwWEcxT0J1YXFGNzhScEJlZEg5blp1SCtLRlhJWHl1?=
 =?utf-8?B?YUR2QXAzYWJOdnUzUUloTkt6bGdCTzExYVFTMEY1UWY2aUJsMG5JNndSU0w4?=
 =?utf-8?B?L1F5czRNU2ozVzRmcm1tb3FJZk5RL1BkOE11NzJMdnBQQ2VjRDZoMGJOQWU5?=
 =?utf-8?B?UDJhY1RFNUt3R2hpRm80WWJqL0p3MVFaUHNLUmhvQzBmQ25wb2pRVEp2YXdO?=
 =?utf-8?B?aXFxQlVMREFvUFhlaDRzZXh5eDY1b2F3Y1hLNndackRucFVuNnpqam9UNFhs?=
 =?utf-8?B?dmF5dWJQU1dLbThNZ0hMZGJsZVZqNmY2V3pEUmczalFGYUQ5NHVNN3dHY0N5?=
 =?utf-8?B?WklLSGlsYWN4bUo5UFVKMURZTFoyNUZrTWpGb2dxY2dBc3AwYzZ4M241VDB0?=
 =?utf-8?B?eU1SQlhsU1BEeEpHSWY3dFlDZmlqYmpCdFJvZWcrWHMreVYrdVU2cFpmemdV?=
 =?utf-8?B?bHZZaTE4Q3RFUTFlSFNKd3c0TGZpalhEdWRkZnFpRlAyeGY1dnMrQUZTbE1I?=
 =?utf-8?B?TUxoZEdhdVZneGFiQ1RyWWh3WlJHK2hBeThHU2FWZDZDMmRkdGp3ajFLZXpE?=
 =?utf-8?B?UktYTWNvZnhxME9LbmJYdzdEOUM4TXliM1YrMy92b0Z0Znh2YTVIR281K0JC?=
 =?utf-8?B?dE9VNVlmZDBvbXphbmlOTFIxbldzcW9XU1d5VVJ4WmVaNVVVSjVXRXU5UVFw?=
 =?utf-8?B?OGw2cFhwbmNaKzM2Z2w3aWg4RGtXbnlZd3VHY0wrQ3Iya3BlTkZLSk1WTUZK?=
 =?utf-8?B?TmJMa0lZdHA3WG8yaS9wNGx4ZER0UndGWjRWbXFBVHhBMWlRQkk4MXkvUU1H?=
 =?utf-8?B?TnpmQ21SZWtMeFhuZFJEV3hQdlY1blVSODZmYXNCd1VuSXhhZ0xIcnV1TEZl?=
 =?utf-8?B?Mmw1Tm1PY09TTjdJRUUvZDg2dzhnSjJYUWZTbjRKcm1hU1kxRG9PdnVCSjdL?=
 =?utf-8?B?VDFlL1VIWGpwNHJOelVZTE0wTmFDb3Q4VE1qZTRxbnV4dGRvV1pxYlg3SGxs?=
 =?utf-8?B?YVA2dkFlOWZEL0FKMGN6UFZwWk5mUHdKTUdncmUxenFMeDc4L1VLcjBwcUt0?=
 =?utf-8?B?NHV1SzNiQXRodHhSMlMrYTJkdVlPNmxscVRVK1MxNE9zTmpuMHA2ZlhtSngw?=
 =?utf-8?B?alBmWmNKMTUrYlF0WE83VC94Rm04Z1ByL3lkNWl4Q1VNU2U5RDd2UGpScmYy?=
 =?utf-8?B?eGdSb2puRXYxOW5lVTBJd0Z3c2JJdEhmRlhaa0YzZmNmNkpYUERBdndrWmRp?=
 =?utf-8?B?eU9SMzdiSXlhcmFYNWVNYjQvWEVIcExpaFpDQzdpWDJtQlpid1paem9zNTVv?=
 =?utf-8?B?N01PdFhDdjduVHBNekNhNWNjQnRCNldiK3YxbXVSdGRJeXgweWFuYkU1TkhM?=
 =?utf-8?B?OUZGUmN0blZsUWN0MVFkaHBvQXpWWFBlMUQyV0lwOWxXR2pxL2JPYnNLZU82?=
 =?utf-8?B?Y3htSGQ3aGJGb1BCd2RFelZ2Qm9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B758B07F5BDE7B46BE7B34F0A11A88DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNzEV4LoSQvM8aGfUHbHMEfO3858U96NK6CU4uqqK3IQ6HSFMod0NUHR0GRy4U/VVZ3Ut9VmWdJW5uDH+4+4Sm4kqp/JEH3LvJaOHf7tFcq+o7j8f6MrN6yCUgwUABI0/naCcd/oWgyYBpovxbxSwTo4LBYDmWRvAU+jzNuHU6zU6oJeHNHsZaD+yDtJ0NlS5GG+o9oVgnR5G1ceWxYhSiSKnheHyETl27G3lcjAjgLcSvCvWtcdb86RbLH/jSxPRdPwQU5qsXEDeSB9SwrlVLpQ7zwX/mn/Y9cT/mNnAGbKBedAG+EidIPf4hkcIZ5nPI+lYAPtIsT5hwd8ETjo6ANmCp618QPgSvY/9dEdV408/C4kZ7DYNX6qNfLzazZQeNxAUP13PWTtSmNVzUsaKo3YObXQOCdoxw1x2ipd5J8yFKK0z1YWuS9tRFNdc9w/ajkzBsxH1FrWgmwBnCO9S2yzyE//PjsmhwtDu8HuZ7aqaBJxO8lv823AblxPE8AkBSdWMvojrIsVLBFfUJzLljQpHdYun66VM7R6X3+sKEoiMLNo+97Zai9O2A2V8pxVGOSokShGODqMhAKePWiDqNRQlcUNik0VeFgqD6/mCQM78hoefTw+G8/wCZ+3YCF1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f65a543-d7d7-404b-4bfb-08de268ffe39
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 10:48:22.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhtaLQsK2e+XALYY3lvxC3Pbc45paXSVuK4n2JRaxyyNW0EZb9mLRBcOzbS3u1W9ucmnDsNL/56/9ZtEHDMQWyTIAIwAFSKPrk8NjOz6whw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6993

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

