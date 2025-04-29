Return-Path: <linux-fsdevel+bounces-47590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45969AA0A39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144247A77AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859112D1F42;
	Tue, 29 Apr 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H4ueW39v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ui/8cS8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F342C259F;
	Tue, 29 Apr 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926756; cv=fail; b=i6IHNpSwKCgUwJjkAXniLMZ6mfFI62suwzrtbyrPzmhNUy14eTyjKVrN0VDPENVpaskh/PLadEch9EuVJcAnJjInlsVW470Xzt70qSQauc+scBlL533PWiC54VKsZ/MUn0a3aTC3b9aXWglrw6PdfWS4A4PvmQ353htvbxUu7iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926756; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S65AqDLztO/DLZvycPuoWolCN/afgEWkwAfphqp4KJak4c0twmZdaZ7pld0Pk0twYCysC97nErDg7TBJCZovSl16n4CLzYF8fwzmY2bEuiaR791D5W0lffW/7ItA/4vAo2XTFlorByaPBclFj6OCZkz0/jLwe6iL1F5ONpGMQkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H4ueW39v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ui/8cS8S; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926752; x=1777462752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=H4ueW39vQcceUFG6Xhp0EQfrHoEH8D0CqNY8ABN0FzKKAUeT5Ravub/h
   acV2H33F2fr8MQlsXg3W3yqX+kBYih8Jdbt7/Ho8YlwPfNwls6h8wEmOK
   WSu++9UOhpjIqQpyCMFwFBdBr0bVKaW/V1uYubLeyKTKJNj7Alug9fruf
   YOAiVkP1i1Q1LXdp1XPxY9DnXsjkJlMA9jRyJ0BlXv2DZ+bw31guS1Odh
   lIy1gO7bHJDXVLNp/b7HrnI371QwN9dRu86UxWR4kZ61f0DUTolfHDqbf
   m/QteOxAR3zB0Pm0Ar7L1DzZmWFNAkYpVLpDesbqlRD5efBChJa0fnWJo
   A==;
X-CSE-ConnectionGUID: zVNUFkc0TqCDqGH0hAq6vA==
X-CSE-MsgGUID: RhwmsS89SIy45cigUXG9pQ==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="76813483"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:39:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpg/Z+XAwTtK8zecIeCnhrUGs342oxaiSYKMiUYPZCEqpoaDwUq9KjuVIvV7jMThKJ8k30whsm0Kstafi2FOD55byqFc/wygqaZfsiznAJ92HoCRl+UzLl7ZoCNyPQ0bQK58Zd2UNGIN441OIm8ve4p+xDnn5DoOlOxr2C5/LjM38m7fk2emw9qRguk3oha/pVzmhUQw0FoCux4D97BMHGSIriDyggBbq4OuDq5dw318mN1Qx0Qnsw7bOBDDvmQDj3EM2Clv04O+B85fxFsAvkcZMZ7ioE5uVPS83r+xiSWIx5DX4Q0wCa3T6ylEYYgNxrTsBkS/PGodE9EN4FKjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=i42WKfZ14GRT4qKc7Jc1klnMyaHVkVPYhUY5ixoPdLrLKrM0IHm3SAUQNFWaH8CoXj3SknNzTR5CiA15ZCsBZRm8lOAocwb4Y4+mSdUuEYJWGMUfMb91tEXshoRvWCjSNY67h7Pg3MhY1EmeW2JfCPswAk9SXGR9z/u2Nv+PjpnJ4zDiJyt0DGtnorNf6PmDJHmwWCI+x0rZtKdwEpU/X9Qv20HR1PJ/r5IoUQsTVPLa3ALdu05OjYiLE+L/iCJfHOAAETI8AkK89oa/bnyfDHt+K/Cj7YliFQ7c9MDKaSXECnAi5nAuobroA9QqaijMR++k8+Ot2JWeQb14bYRPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ui/8cS8S4Mr8LsFF4knzveP77/1BEZo8AorOXh29KER8lV4mii+XnAUssQD4OunWRo9t3Z++doxzBPHHup+LBJ5+T7bWldhNychiI4tiuyObcylgxjuzLWYw39WBYLI6Qg0ww8Fuj7PtZEMwt0rlmiwcXjpW/asBX13n4PqsLG4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7749.namprd04.prod.outlook.com (2603:10b6:8:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 11:39:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:39:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Md. Haris
 Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li
	<colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 14/17] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
Thread-Topic: [PATCH 14/17] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
Thread-Index: AQHbs5NPa54zHskPPEe7I4gNgsuIvrO6j3kA
Date: Tue, 29 Apr 2025 11:39:06 +0000
Message-ID: <167bb670-b4dc-4b92-a078-459e96a20f36@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-15-hch@lst.de>
In-Reply-To: <20250422142628.1553523-15-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7749:EE_
x-ms-office365-filtering-correlation-id: 3524908e-b5c3-4252-5d7a-08dd87127327
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUJWUGd0K001NXljSFJpNCtMS2hVMVUxZENKYzZvYi8vcnpreGxYWTlLbTVX?=
 =?utf-8?B?OWxZbWJvWWNwbHFwN1NveXVMWXp4RFR1dXNjZm1GUlgwcFRWcjE4d0JVZVo3?=
 =?utf-8?B?RDJlZ2FGcUtEODR2MkFPNGJXWldRaWdVQXVRUDVwZGYvUm9pdHVNS3phOE5Q?=
 =?utf-8?B?TnBLZThyNlJlcjgrYW5vVXY4SUdKWitodFg2Q1NPdTJEcDVhVWM1TndLd2pD?=
 =?utf-8?B?ZDBOa1pqZlprMkRYUWhPNHJwLzBlVEtlZVdMWkJha1NYVG5wM1NFc3VLVytB?=
 =?utf-8?B?WXlDYTZGWjlXNkJnUHQrLzhrZHROUUxzYVZGbUdISDNTRU1qbU1WeUJjY2F2?=
 =?utf-8?B?Zms0YnFuQTV1WFdOeGpXamhkeTUzb294TU5qY3RXdzRhWlVBc2VFMGVjQ3BQ?=
 =?utf-8?B?OE1OZlFwYmZiVmo2RTRDTE9RUjdWYy93N1Fkd3BpQlNvY3Qva2duNy82Rkhs?=
 =?utf-8?B?WFQwYlkxbnlRbktDaDRhMGhXeXRuNVMvZFcvb3FieGs1YWJnc1JsYjJUakxG?=
 =?utf-8?B?b1ZxWEZOUmV4bWhPMWlpNjhCM3VESDhJQzdCUVlld3ZaUElRbHhLUk1jRHZq?=
 =?utf-8?B?bFJ2VS8xaWpWekxDODN6dUdmUHhyTklKQ0FKcW5lejhsVWlIU3R1UnVOZ25Q?=
 =?utf-8?B?dStGa2RNcy9OT1pWQzhTYUdybVlKWXJoRU1FY1l5K3ZRMWZ0YUJPbXRHWHRV?=
 =?utf-8?B?MjFxanlFem13ZFJ6YlpYVExFNTg3TkFXMEI2ZytER1loOXAxY09mbTU4TVRT?=
 =?utf-8?B?ZDhJeGtIRWZUcE5FU3J4Wm9LN29JZGM1R25wNFV2TjJBdWFGSkwxZ3JRdXVv?=
 =?utf-8?B?T1FmYWRFMndoUmlzVW4vM2tlUTVQR1ppdEk0UnZDQU5XbnJnVEY1cmRLd0lQ?=
 =?utf-8?B?bDV5Nk4yTDg3WU9lVHJZbDZIWWFpY0t0UjZjVURxeUdhRC8yS1cyRjh3M28x?=
 =?utf-8?B?Nkc1YUs5bmZjMGxpZDZIVEoyZlJYV2RidlFGSTJER1JQR3hzNmdnQ0U2NGVt?=
 =?utf-8?B?cGJHTmNDZTlWMFRZbS9XcTEza1VjREhVeHdnQ3JIaGpxNjNhUmRyZ2xKWVBF?=
 =?utf-8?B?RUttY0RuSTI1eXVCSVgwNGNicGpNd05MNCszeTgvNWt6aFFPWSsxZlloNUZC?=
 =?utf-8?B?UTRWK3NWNjFUQURhenpFbmRldEhIR2NCbVRUMm9oY0JiOXJwcDRod1lYZ0Fk?=
 =?utf-8?B?NnhhdnZrZFpka2dQU09YM2xTSTdWSG9iVCtnS1hHMTV5L3Rub3p4R2wwT3Vp?=
 =?utf-8?B?WHh0cnlwejRrOWcvRmJIVy9nOW02bXliVVdtcStOOWlGTjlCWEY4em1sejRB?=
 =?utf-8?B?cmxVd2kybXBwZGk1UEcvZVhLeWFWdVBWenl0OTJEanJKb2VVS2JBM2JMT3hH?=
 =?utf-8?B?cng5TjJoMkZ4d2VSZm8wNVE5Rm5pdUxPeldEcDdXN1huSjdMNDNJcWM4U1Jz?=
 =?utf-8?B?NmJPSTJNREtQRDJVc0w5NnVtUlJrSWY2S0RsaGpPMUVIT3Myay9NaFJlSkNO?=
 =?utf-8?B?Y3NPMjlNcGltQUFsVnlyWHpYRmNmMHd6d3JvNkVxeVRCSmtXZ1h5MVU5YWhY?=
 =?utf-8?B?M0xzMk1OcFJkbkc1ZlNRVUxMSUhIbG1mK0hubWltK2ZpcTQvNzFOWEV5S1Ft?=
 =?utf-8?B?WmZjME5ObFhCOUlVT0MyaEhNQk1Ndm5pMEwyTm10Mm9rT2xYVDNGbkJ6b0FE?=
 =?utf-8?B?bTRiUitDcmJ3bkx6aGJBQTBlcjlrSGM3ZEgvMTBaY05ETUd3TDNwNGt0T0ZM?=
 =?utf-8?B?ZHdyZVpFd0JNc1F1eWRrbGM0ZVE4K1FYdGM3R05GYm5INGZpQUlBaHdod1Rh?=
 =?utf-8?B?bVdiS2VNUnBadm5HWXJGeTQ5eDA2M1NqUURXUkFRNkVBbkg2WmNSVjJwR2Jk?=
 =?utf-8?B?L2hyNzQ0c3JQUGZlTVJ1SVJsYnk2RXNrcE5DdHBEK2NFekUxZ2ZpRW5ocFov?=
 =?utf-8?B?dkY1T1Z2QTVHNklOZnBNMkVXb1FIZ2I4R3dicEtkN0lrNmZrdjMrL1hxRzk3?=
 =?utf-8?B?R2VCTXVmbzlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2RlanphWUVRMWxmdzVpTFZZRGZmaXdWL2x2UTJ3MEcxQUYzNEs3VG5TUTU4?=
 =?utf-8?B?SXBBZmtFZGMrYzZnTkY1djdXbTgxcUcrWGhtMUZTb0dscnpjT0tJVXgwTi8z?=
 =?utf-8?B?eWZZQlRVdGZpa0lHS0l2c2U3UzUzQ2Y0NDhCZE9zMUF5VlRBUEM2eW1LbzBP?=
 =?utf-8?B?d2loSFdGQ01XcExnVnZwTmtTNllEdDMrNGJBSlViRWRTMW9mUFEwMjFmaG1u?=
 =?utf-8?B?OVY5OGQzWmlESk9qczlHZnhFNkhpYlNJVWo0dXlrTy94cmhiQXMwWnF2Mzk2?=
 =?utf-8?B?QisyaitpRDJlOXZNUTg1aXFkMmszUDhGN3B3QUM0QStBQUJFd0czNERxNzdO?=
 =?utf-8?B?UndSWXNqcmtySEdNTkl0VWd1Tk1NSjBqd21XamZ3VzFPMktaVGE1dndGQ0Rv?=
 =?utf-8?B?cFRNL1BPVjBFSVl3UG1wNDlrZTN2NGZxYTFwcTZzY1hkL2RpUng3QzBRTVFV?=
 =?utf-8?B?QnJGNXYraTJBdG1qUlVvQkFYS3dVaGlqVnRpZUJXUEVtNGh3S3RtT3VhUU4y?=
 =?utf-8?B?STF0bmhydDdjVlk0L1RueXlYRElhOFRqN2NWNVRqUDQ4cDNSOTY4OVBuQ2JT?=
 =?utf-8?B?QS9jVjF2ejRWU3RlU3FvVk9Ja2hNVVcyNktKRS8yYllITEliNWJ4d2dZL09X?=
 =?utf-8?B?NFlJRzlUd0RReVY2YVRFelpRMENSZzFEMld0OXRqV2tOUG1VMzMrMTViTmtl?=
 =?utf-8?B?ZzVXbitJUFp0M2VNMkcwUDlCSnoxcWZhSVZqVkkxS0prcnN1MlJXQ3dQSmpx?=
 =?utf-8?B?VW1FMExlYzgrcXJOSVBtQjdHWG42eHZSQ0hUUnowd0ZHZWswOVdYWlg5VWds?=
 =?utf-8?B?VWZpZFdJeVcvdERwenRRQ3dxWjR0dEsySytJb1lXc0tGVFlaUytLQkdMWFkx?=
 =?utf-8?B?NGZtWlh5NDRWRUo2YTk2ZDBXNUY1RHFXSXU5MlVFWklDbHRwSHZMT1d6MFhw?=
 =?utf-8?B?N3BwV2ZseGdhUDRMUzlsK0pVZFhVaThBRGZwYVk0bmxrak04eUpsbEdrUndy?=
 =?utf-8?B?K2ZrMmpjUWNxam4wemdaZkVZSXpGdFFPYnF2QkU4TWxlNWJsU0NsdXJBZnFm?=
 =?utf-8?B?TUFaZlRMV3ZBSVRyOFU1NUliVUdkeDYwQnp1VVhtN1d6cGZ0M0YwTzREMjlE?=
 =?utf-8?B?cU9ZSmlCUzRDT1FzWTgxSFJTNGtBUVNzd01IWnRMckErVzhvWkdtUG9UOUxL?=
 =?utf-8?B?OHVqeXgvT3l4dkVJQVRmSmJjKzQyOVNlV21FU3dNakN4d0Q3TUdNQTJwMWlz?=
 =?utf-8?B?eW4zc2d3SjZTTWJadjF0MVZkMWFxVVJNUXB3T3F2c1pOUExmWEVyNGlsM0Vz?=
 =?utf-8?B?YlpmSzR6UFhKemNBeXFrZzJsZEQySElUMkNZUTQ3ZStRQkhiRGdYdXdkNjRV?=
 =?utf-8?B?c2NMeXpIL0R6aWlYVkRBdzJVamxCeUYxWlNpVXB2K1p3TzFqWnF3UEZPakI4?=
 =?utf-8?B?VGRJcG1tOFlJKzVKTXArYmJuY1ZCdnZWTUtaREpncHozSENaTVRYVnZoUVdp?=
 =?utf-8?B?ZWZoVmdpUm9mNzJHa3BXMHVNdHQ3T0l0WHM2R2srK003ZjlseWdtdWhVaHVs?=
 =?utf-8?B?ZkkzSVl0ZFRQSUxRRW13ZUpnNk5Jck5ldjY3cXd4R2dydi90bU5rOGFteEJB?=
 =?utf-8?B?ZFRYTzZwbFVuNlA5YjArSVZoeTlTUHdzVkN5cDhheHJwdG5jcmhhbklTd2pF?=
 =?utf-8?B?VERMSjVmMVBpOVJuZ0RRbjlacjkxM2pSK0hKQTdQaHpsZjV3aWlORGdndDR4?=
 =?utf-8?B?eURPbXA4S2pjU21hVFBMMFlZRHhtQUdML25UbmlRQkQ4SWhTditTOEJZa0k4?=
 =?utf-8?B?MU9rTHhaVzljbHZJdEk4aGhiWkNTQUlLckRMTHVnOFFOV3RiRXJRb0Jmenpz?=
 =?utf-8?B?cThxRGFTL1NVRUZVYjJXYUR2a1NIdGRLZ2RLYm91TDVMcFZpRm5zSU9rdlFL?=
 =?utf-8?B?UTlZa3J4eWVhTXV4eTI0RVJJWkNyWk1sNyttb0hwVnpZYVNYTGUzamhFMStG?=
 =?utf-8?B?elVWdTJjZkRyQU5FNFVNaERNaStnWVVMaXh3OUMzSnRhQUxzR3ZJMHBydHJ2?=
 =?utf-8?B?RWkrQnA0NnQyUnNvZlFGcXpjZlRmVEpFYkNXZ2JNYXZzL3JHeXhjWmdDRkFo?=
 =?utf-8?B?WXZmRXp1ZVlVNy8rQzFrUHFoY0RHMFgyVjRWb0puSXNYcjJXUUUwWVJETTBD?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60D6CAB77479B0429826DAA05E812DBC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8zHdnfqeDkIz1OIZaY66i2/nqEEIfChq7wTmrezM4LxxKgyg+8i/6C3FH6MhHOpW3Z0qPjeE+tNDcER4lySnj9c0lMlPadT0l9P4SdIHotidpY31jSFkN8h1KR8PZvBiI0phr9yCgbXMPar2Fojzi2NU9T4/WHP+vbEwsTa22hYm93osTt4DPYpHEOTOfXr5db4xGfPSksxQLtQTq4bWDEYa0ZGzI41SiptMGtmizj+3nylCifpwy6lJAVNrmJvG0HoJRi6meDfSzbjFape2npnOk8WOSiOmtiIvWQ2uZo0IjyIYdBxGL34nSqLm8Ou7589yFAukbSWMShdwYfpxdmC5Iqu4nSKY3N75nxkoH4ytF2noZrdc3xyDd0vQoJgSrErZTHv7H9Ea1f5cwHCDi6KKuTfVRmjotCh7yuQ4diyE4U0WopT8miZr31vXvgAcCWKsRXVGyLWItHj0mNDkFAQTZj5QVK6/A56tLmbfFHkQf8LBS0xMKMYlVkr2J8F6opGq6+elNg7UNWagIN0g6vBJjyUJ8eOAAO1z28G+kChkl6uQ44LAA5frkSznca0u7J5edYpGhqvFuO5iwPCSfHNOojt+cGy+G0q+aDr30Ce8yY2gsnjxG4fHWQMSqaZ8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3524908e-b5c3-4252-5d7a-08dd87127327
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:39:06.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Tfx29GEzQfXDer8EzikR3d5kSuFcz26CdvpOGR35FpNWDA8imXJiqLlpuKnRDNxeRL/JjKzwG4R81gRES/VPUxwLc5LmXnvBmi59D0l58U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7749

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

