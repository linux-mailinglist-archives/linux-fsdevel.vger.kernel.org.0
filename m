Return-Path: <linux-fsdevel+bounces-51783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D3ADB4A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2860A188CEB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF58217F26;
	Mon, 16 Jun 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bjLV0q6U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LOqGAKSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42F17C219;
	Mon, 16 Jun 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085879; cv=fail; b=ewfKMhOQRfwFsJcFvQXHYrOiIff9Nn+lE4xMxfiqbgJudcPpciiX/XG/XXSEYT0lv/1n42BiymMX3ARRDXQ5I6BDjbQstJrb0fgWHny7hFbjC0hk1isjwJW8ZbdE4hmYM6E+mLZRExC0rqKiSwTUshVFZzFe9ke9Svc/yV0eLo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085879; c=relaxed/simple;
	bh=seqMN7UaEe16YZccIMzERPQmRpzkxuGHpuLxWgSJo8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QvUUbEnR9vGkYNo8EP3TAGtuDW6AquRIGlEGpFG3l8VqNnerKlNKApTEgLR4h9OrfRbFB8Ba8BXYIkCAHAU45KMbJ46SecIsQVkOCggIKaGXvi1cLGGtWSJ7ZJDA+Hs1R0MAio1engK1fI7LwkVIGdjPrSghnQcc+9fWDTTg/CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bjLV0q6U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LOqGAKSL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750085878; x=1781621878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=seqMN7UaEe16YZccIMzERPQmRpzkxuGHpuLxWgSJo8U=;
  b=bjLV0q6UcwyKp1tSZi5nV4+pX+8UdoSz3pfgWX6unbMq6hFoRFgiKOBu
   NDUBAcnYZBDUCXNf43SN1zfTElW1EZdT3dwXUtOQaGyoX6o9XpKdRfOND
   +DpY89WvRSIIGg/b2CFM3jBvo/0xVN5qJCKvzOxiFagViQqLNukTzaIJA
   eU8csjUcuKvMAOALTZBT4OskiH+IA0pQtxUjQ63ExruMpX6p6sAhcGJew
   2A7RNiNYKAQ8fRULwjX8YItjG5mLVukDgmI0CfKqX4IYi0cFfax+U0AQm
   kDMWdp5pEr5w4hD+7s7R6Zh11Ld4E6faY++AxzGdHHt8fjfVYkf9csUNy
   w==;
X-CSE-ConnectionGUID: CMp5sB2WRFqxDDlAOOzkTw==
X-CSE-MsgGUID: sMY9QKbHQ9aZcZnk/t2DGw==
X-IronPort-AV: E=Sophos;i="6.16,241,1744041600"; 
   d="scan'208";a="85410858"
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.81])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 22:56:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnUh7tLM0deJuSG0Mjcw+3wLWKRsFFiAwBkxEwWd+Sn8JKh/3fr6P8oR2k+I1iCiU2x2P44QsWzuAlsmWkrWdgnxUBtGk9jrH79BjxpXwPrf/LYTQRXpIBHuO4rBHg+4ymrwJv4OJ1jsTAbbh+MfQ5J+J+cPCCti8UnHUeVtyd2MVLph6p2Q0jyPyzg9um7iCOX+LHrlRAv9HI4KRVARZv3xpXZimRVJ5M9unKlSIaC5GHYfIwwhI14SgUBNl2bwq7Br9x5xosp/aTYCFDWEyPdi0qZlNuAexwlp7/RwpCk9ZJAYPd0oA8P4MDaV2O+SyAeh/82VOuIsYKaa9DczFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seqMN7UaEe16YZccIMzERPQmRpzkxuGHpuLxWgSJo8U=;
 b=C8cPx9O4blCXRrHpZfL4iNjaCskDSfcSeCKM0uvCKMljDTyteZz+ItIr/xahX9yJ7tf0xR6H8HaC439KgRX91n6ZCTx//cj4nZYcfvh3pvqU7Uv7VtfILoa6o5p61X8u0AkfxZgd2HYCmVdxP7gO3QEn5VkfQb+pR/6sWdSNkH1XVlED3zpwXPElWventHWIfHYCDrGjDcyNg5ibqvJs3HIan6x68E7W4nHjyPPJwLVLecUhY3hW73KQAkw1A5OkJenkVXGHUGd/h7axpJ0AT7NR5OtJgVJnW7QQOYQYc3LGBv9Yi+BqjIer2f+ua/RBNxqXiF0WuHiM8Ji7OzUKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seqMN7UaEe16YZccIMzERPQmRpzkxuGHpuLxWgSJo8U=;
 b=LOqGAKSLqJkmyApP/JyrktY9kTVXXlKTsir0B4QA3QuYzbG2KpdhhLkr/LcxUC8MQ+rmsvmILYgkNk9aht7rwRPAs0dzpSxS6h4ncYbWGOiBq82NCuQ7Ms57y9FaCG6a0V+Gbym5hm26f8uM9nnRSa2Jt8GCO6rJSWrbnI27eLo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8573.namprd04.prod.outlook.com (2603:10b6:510:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:56:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:56:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Christian Brauner <brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Joanne Koong
	<joannelkoong@gmail.com>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>
Subject: Re: [PATCH 6/6] iomap: move all ioend handling to ioend.c
Thread-Topic: [PATCH 6/6] iomap: move all ioend handling to ioend.c
Thread-Index: AQHb3r7NhL10uTqoAEen+6MgJpWXLbQF4EQA
Date: Mon, 16 Jun 2025 14:56:46 +0000
Message-ID: <77ece589-9639-488d-b230-7dd257572227@wdc.com>
References: <20250616125957.3139793-1-hch@lst.de>
 <20250616125957.3139793-7-hch@lst.de>
In-Reply-To: <20250616125957.3139793-7-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8573:EE_
x-ms-office365-filtering-correlation-id: 231e8a59-c04b-434a-0194-08ddace603fc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEE0QUxCSnlocnc3UkJPd0ZzSHZxV0FSVHdiZ3JZbndjU0RObE0vUXRJby92?=
 =?utf-8?B?TTlMYjMzMFVTYkJjbkVwZlk2RXhhT1FqNkd5K3RQanRIbFh2WG5RN3ByWmwz?=
 =?utf-8?B?cVpEY0wvUEtzQmY2NjRKYlFpank3Tk1ONngxdnZ0ZjFSaDljY1pXY211anpx?=
 =?utf-8?B?L0d3MWp1TkJDeHdIbG9Ebm5vR3ZDWkFpbUppZGhxVUx1UFl5c1hMOWR1dGQ5?=
 =?utf-8?B?cFpnaDJBS3pzQ2dNWUl6RFFwdHNVS3JaaTNqYmc4RzdOdHJ6QU5uam9pbUlp?=
 =?utf-8?B?aWlpaW5NVVNiQ1RKQ0hLdFRTQ2xaWU9aaFVJUzhvWGNuQVJtY0JRdVRYU0kv?=
 =?utf-8?B?c1FueXFKcHpMSWdqbTR5TXdzQTNFY0VqMlVRUjExWXhvRy9NeklYWUhvT0li?=
 =?utf-8?B?Z1RtZE1qVUZjeEN4ZTB5NG9PcG5sOWZtV2NrUURkRzBIV2VMZXU5MW90bXJm?=
 =?utf-8?B?T3pib3FVYmNDY2ZibitlUjh2eUE3OEZPcU1qbmNkakxJMjA2bU5IenQ3Nzdj?=
 =?utf-8?B?M1F6SDAyQlRrdng4OCtMTHY2K3daMi9xUVVpM3VmZTNCcUJWc0FDeTJpbU5k?=
 =?utf-8?B?TWVuakNKQjdZYlBEam5jS3A1M282Tkg2UFZDb01Eb1NScnZuMEFyZi9NY2k5?=
 =?utf-8?B?eSt0U1NzOGgvakFSUjRYQWo4QkFaVEZDUyt5M2VaNDkxVWZxRFVobmxkSkhK?=
 =?utf-8?B?VndIb0hZdndyL3krZ3pMYWlKSERzYjZOWlBYa05Qb3ZHNjJKNlIxVzNzWUZk?=
 =?utf-8?B?dURHeit1dmpGQVB6TkUzRHcrUlJqa3BxMzZWU0hsR0dEdmN1VGQ2RWFaa2Iv?=
 =?utf-8?B?N3NocHBsS2FyRlgvWGhHYzFCTFdacVErVlYydXlteDN6ZXMvdDRlVGRzVkth?=
 =?utf-8?B?S2NqeW53bjFjRWtOSTVPbGp1NzZIMXpZOENkdGdxeDhVcUhkMkJNODNRc3k1?=
 =?utf-8?B?RTJoeTFIeDE3ZUpHcU0wa2xzb281SVlNNjIxV3NlZGw4bU5oS0FQWng2alpH?=
 =?utf-8?B?UENRWE13dUw4M0d6K0tDWElMSkdmeFJOVWxoVXM4K3NseW9HS0lLK1FzemVl?=
 =?utf-8?B?c284SVEzVjZqckhsb0swbWlaOFFsNkVIbXNTR2dVMWVMcmlibmtnOGZ0U3Bj?=
 =?utf-8?B?YmJQcVVxYzhuQ2tRNVBsRjUzM09CK2JLQkkwNFNLK3FEaHFBZ3ExZlBTcW5q?=
 =?utf-8?B?dXV3Y05GN1dJYkZkcnVCN053eU1RZHp4NlQ3ZE1ZUVUzQ0NMLzQ3RDA0QWQy?=
 =?utf-8?B?U3NFSlZxVlRjU1VRMEJ0MDlsTlc3MU1ySm5kalA0Q0JpQ0l3VTdvbkMzMkFw?=
 =?utf-8?B?YXB4U2ZGQ2tyNkFRL0ZickxYUEtqc2Urc3BnT3l3UEc4elBMOThhMU5ReU9i?=
 =?utf-8?B?YUZBMWhaa3ZJMlhVcEJtazYvRUZPK1gzYzVvbVBJdm1DbmMwVFJtaGlDVUIy?=
 =?utf-8?B?UDB3azZ3bjY0ZGZJdWdheENDeXVzUnJOcHNNRzF5b0pRYWVIdkp1UVV4RmVp?=
 =?utf-8?B?cnNwM1ozaHJEM2hNcGpwbnB1RzdrWEpQcmg3dmhWdTVzTTY1SE5DQUN0R1lR?=
 =?utf-8?B?N0tyNUVMazBLeEdKRGd6eHpCQW5XKzJFWTh2WHFpZm1Ua0ZDOTF3Q2Vscncv?=
 =?utf-8?B?NURtQVllNXdVT1oxMmpyYStLNktqREVhWDVoWGNkOWY4THZrVzI3Z2pFSHJH?=
 =?utf-8?B?Rll2VGNkWjV6WHZhdVlkcnR0Qm03cjVHZEtTK2FoQXRmOUQ1eUZZbXAxKzdZ?=
 =?utf-8?B?MEpBQ012MWdrdWZEc3JpMEJOUlNUdXkvcjZlMzk2MG5NUFMzWk1pUk9vVDdJ?=
 =?utf-8?B?MHJOSGtsUGJxTm9tQ1VHL2xvby9ra3dxSUdXMU5oaUxJU0RTNWFHSnJ0cE83?=
 =?utf-8?B?cXFXcWZrUzZvU1puSHVRa1lHYjc1UzNwOHZkUCt1b0JZL25oVFZMU1lnODVh?=
 =?utf-8?B?N04vckdQbndORTNMYndnY0V3L09NLytaeFdyMk9ZZkk2bVF0Q1M4anBrMDlW?=
 =?utf-8?B?YUJ6djRCaGdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3ZQdVRKc2x3dEFRb2xObVJjRHFJWTZSWEgzamIvTXFYY2g2SkRJU3h1RjVD?=
 =?utf-8?B?SHdhWXdqcFdiSTJsUDQ2UlFxOHErT3B4UG0wdTB2alFvQlVvc1EraElrTlZk?=
 =?utf-8?B?TlFWNW9ZeGIzbFV0YmlENFFSdEptMzFFMXZ1YjZjWGRjK29veXJldmhCMitE?=
 =?utf-8?B?WHJINXFUTGJHdkx1Vlh3cHRuS25PTTNHWkpjU2ZUc05LdTFsa2xlSWdpcUI5?=
 =?utf-8?B?TndZMkhoTnZUNjN5Y0pJWDR4SXJZOHYyWHZZRXp5ZEJoZW1FVEQyVmh0dTkr?=
 =?utf-8?B?ODdWTXpkN1d1QUNEU3pQRHAxUDJlcDB3WERyc1kyOE4yVjBPVGEyMU5kNjd0?=
 =?utf-8?B?Q3o1eEYyem5tKzIzSEp4S3o2M3lsVzBhMy9RNW1NK1hNYTZvM05ad1ZmcTNR?=
 =?utf-8?B?dy9RZysyYkpDK3lxU3lwaHMwNHpCQVhndUtrVWQ4OVFWWVUwY1pFMFN6WWor?=
 =?utf-8?B?RWhIdTgwQXEvZVZVKzNKMmhnc0sra2UvdExLdnF2dXEvdEhJVC9vRlBkREJP?=
 =?utf-8?B?bGZMZWxmZ1R0M1hXZ2VORStRRXc4b2FFUFN6KzJRT2hmYWRaUVFQMjI5VFpY?=
 =?utf-8?B?NjNSVGZpYmZlQVYwWTRVcTh4VVRtOEdidEdqZnA3bWtCRU8rakN4eEFnS0xF?=
 =?utf-8?B?R3M1cGF3UzhKeVVsYXVJK2NyRkIzd1lYTmtqQUpoN3AweWh1TEVBcG05Uk9Z?=
 =?utf-8?B?VFpZRjNndXRpWFFnOHJpVjRwemRhR3BSRlk4Rm1jYzRkdTh5Ui90NEFsSlBH?=
 =?utf-8?B?YVFxV25ZYjNsUHFiOFFhSkhPYmhydzlvVlAvMlNYd21ZcFBkcGY5eG1TWnI2?=
 =?utf-8?B?Rmdyek9MSytpRlJBQVNEUDBFeU54NHlMaGtZVFJGblBwTlBlVUpScmEyRmFk?=
 =?utf-8?B?aWxQeE1TV1hRZjYrZXVOb20ySkxEQ29RZER6bytOcUMyUkUrdm5aR0J0TkMv?=
 =?utf-8?B?cFdBTnl3bUU4TTBMd3p0dDRrbmwwdmIzaTVDckQ1bndnSHYvaWNYdHFZcEU5?=
 =?utf-8?B?b2FWSXhuY0xpbDNSazM1d1gzd25zQWZ5U3FTdDNoS2toZGZLWE40WEtKOXU5?=
 =?utf-8?B?Q1BtMjNaSFAyTkJqaU9Nb04rNnk2ZE1rY3JRa1RnWEI4YmZWZUFJdTNsQm9Q?=
 =?utf-8?B?b01hL2gxczRmK2xzVUZBWVlnbFpnWWgvWnN1YndJRGFKTlA1cTV3bWx6Zm5I?=
 =?utf-8?B?Um5WemxCTjgxVEdQcEszMEN1bmt1cE9XVVR0NWEwZERQN3Z2U1k3VjhyZ0VY?=
 =?utf-8?B?ZGtTS2lPbWk4U0FuRDAweG9RT1ZQSVcyTHVwSHdhQWoxbkVVYnJnMXdOS0tP?=
 =?utf-8?B?aHJDeUN1WHFzdlp5SENFdlc1bWhYN1oyTEhHYjRWaGRlQXZLWlVRRTBER2ps?=
 =?utf-8?B?SEhWZ0h4RGt1MHdNRmo4QnhsNU0ySkh0OC9rVlRNZ0dZRjd1WW5CR0diWTlx?=
 =?utf-8?B?dEU3UmRPcmlkQjc3ajFldTE1c2VyOGl6cExHWnowR1krYTJyajR6b3JGcW10?=
 =?utf-8?B?MHYxNVBOMkl5V2hrVWJTRmhKUzhHSHkvY2FvMHYzVFhIWHRjVjN5YnlXTDFU?=
 =?utf-8?B?enN3bzdtZDYzVmlNTnN2dWlTbEZLLzc2LzlmWG5vbmdzbGxkY3NzYUVBMjRP?=
 =?utf-8?B?LzFhVDVPejZXY1U1TVZjVjZEa2tOdDR1amJLVmhaWmtHaHZwbmFKWkNUbjk1?=
 =?utf-8?B?YUZ4dWVDVmxsc0NNaWh6M1dTY2dKZmd2aVBzVldkMXNDUlFBL0diNERrakc0?=
 =?utf-8?B?bTdyNng1cXdKWHVkdThoS1VCYXZBWkVka0h3YVRrUi9IM1ZWdWlISzQzemVY?=
 =?utf-8?B?OUlOUmdDZGhpSldIZHFsQy82VnkrOThmbDNrdUZNclJmWDV4MGtaeVBBbWsz?=
 =?utf-8?B?a29oSVV0NVJVcC9nd3Qrb2R4OG5LeUgySHdLanMrWkNHQ3d6Z0RpbE9ZYnhM?=
 =?utf-8?B?dWlkak1XRXpqNU1vSS9hYmJvc1lhSXYrbzF1MHBzZmlROHhZNC92ZVc3dmNI?=
 =?utf-8?B?empPQ2lmaGZMUUV6TDZUS3hYLy9LV1l6eEZ0V3RFYlc0Z285NzFyWnVuM0I0?=
 =?utf-8?B?Z1NwVEtqZEQzYmtGMGt2NlViTGdpYVhOK3YyNUhjYUN2M1NYcVR3am1UMDMw?=
 =?utf-8?B?a04yUVIvTE04dFJaa2N2aUllZW5MNTdDMm4zNWdyL0VZK3ZnSzFTUjB2ZHM1?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97B196DF25D1E04A8BF6E069F2142196@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YKIguwDTW3i6Jtfw12sa5pvhML4FNfeFmM07f58ujgbqY7YTYtrqCs8OHp+rhNrtkLQCw7OKTMETV3zqExxXC5vKNkeUOO4UjV2FfMM2sK3GV9GCQ2YDGMwaVNBL4ciqJzzniyztl4rbDCh4Ix/SYl7kr3DNOepmuPv8YDvYziy+XdBq7KYk04NugUOXjuW8lAJwuoOlk7AsT48B+EvpPorKyxtfAgxnSjkCzqgxYWoXEEljBUgtVRepsTvAQg1NsmGbH+ygHiikUc3gxzWe4JEcMpLYRbv7D8ohIozc+SPpB6iVWYl7tuYVvXgVMWI00l1LXo0XnZNyO9T+sah9FNTz6QloWcgWJhTbnXDN2M1TdfG22a9hlZ56xRT70Mg0dDL+AHm+pqMeaUsrqKmhFwsqK50oI4T6NeVJsu6UAFz+dJ3f0ubZXH2Rvz/nUP0jsptmWhK+7oPyw7XXm2/kQDHvFI9PWmjI+qrBScJqVu9aHPrcR+6XNqokzFFigWA9wExllYRVs5t8n09FHCGFqXPAB67mKGht8aYdZGda7xJ1oeAZGUSaNYqYluWghjbl9FJ5mMUhp7iQerl3VH2zvKRGgRUD9xxA2CJUkMoLFIB/k+nt7WTHVE7T5wwOtdQ2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231e8a59-c04b-434a-0194-08ddace603fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 14:56:46.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ4lpuxtETiF2PtQlE1b783sedwOLEbgpo3rWf2vSuBDYY4XCviGRemhLcLqPZOyTKq7AhPfJn7NXNI3yGSwYD1wmMS9h+VFNWRG0uuKPjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8573

T24gMTYuMDYuMjUgMTU6MDEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBjb2RlIGNhbiBi
ZSBzZWxmLWNvbnRhaW5lZCBpbiBpb21hcC5jLg0KDQpzL2lvbWFwLmMvaW9lbmQuYy8NCg==

