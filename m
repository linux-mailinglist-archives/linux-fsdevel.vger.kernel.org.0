Return-Path: <linux-fsdevel+bounces-47584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5784BAA0986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475135A86E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED002C1E19;
	Tue, 29 Apr 2025 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pnbrIjJK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jNeU2PKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BD2C1090;
	Tue, 29 Apr 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926156; cv=fail; b=od/+8AIsyabuwnjG/5Q7vKZ3d7McohHwVQsXxDHW5IjGBcQuQXX5HDnB75lP4XXvkZMmBUcQAgnotKy43L5FSJYzhniUZd++YIXB+hxy38Xfe3CHN8tev3cY+wIdM1tcrRC9CjE4Wv4qUu0JontaEda8oBy1jEWT1D/fHpvHm3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926156; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BaJWadGCTtH6tyCuKzldd2Pyg+fkFoA56CCQlGabIbl1h8g7ZUHvAE1tOF9lIywAAjKJD0zkzlMYzipNOboiZwsg6uim++W2j2mXlyI+iuyWM/8vInEii6Sbvhz/skHHBPkNYvjoKu8WOHmKEQdp2PkR7MZj9YM4YMGfBlES2zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pnbrIjJK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jNeU2PKx; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926154; x=1777462154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pnbrIjJKNuMlmc9EEIZt1X9mOe53OI91P8E7NSD9+0ZG5OOtsoMZjwOM
   JYYf8m/SCWkgwIZgJ53FBI6n8bUEMUvCWt50X8M/ZYprr+sGugRvD8FD6
   ibuLVZqxR85Fj7WepU4gGy51DCEUiriW+wi966NvNpS2ivrIt9lO2eWtN
   nRwJgYJULtPrhoEkUjg7r9XsjjPqg2rLotDLYZxmPFfqP6v2URW2N4pyy
   s8wGJMunWLDAymb2w+vciPIgxjzbj/EAUQ6KMSMXfXBuUJPPBc8OA6ohG
   aBuQOMdEOZZ3ZeOXcwAhJfvBAhrEqKU9kiSq6nv+NGtIXxMpMYLJBpleq
   A==;
X-CSE-ConnectionGUID: l8IHD+yhQaO8kHOnnFGcXg==
X-CSE-MsgGUID: XG3m9RwOT36uIro7F1D95g==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="82771094"
Received: from mail-centralusazlp17011031.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.31])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:29:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIFOZqzQ68k0xuHrbpanZHgtmTKNl/xTPk3SOz5M8uCHJL+tquYW8XjnDVkGCBADao9Z4q1KRUjnlWGhmCV/GFtgT6BOOxkpDMQioq/hYScnK6gl/rVwujQX5QT1pxXqjk7dpW1cnVoKjVxStjrRPdopb6DUsjoPVrQ9HQhka3bGk4nGUVy4aNkX6A0EFsjeD2P5NRfKdAR7DEqqMDZ0CqjlN3fQC2tlAoRjtsXIlEaJntPQgRENpb7n60b9WrVFrhD2GNzVYLjDMIzQd413r9xsJ8VxyTsNaiPG7h5sC5LYzO/c5B8c+TyMyNV14KkL03Xm9d/Dc3YlMw4SYebjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hkhFQl9dSSSOlvu12XL0V9gvMAJPbaFWZVm8xywGA1cF7wVdkgxA5xVYmxiAUOiKCotvOFB89W5EKfKXjxTKuRyvIJXHSZ0oa58N3SxqD0x/Mqdz8rbJDO/F29tpRMqiH86pzaCHHhYz16wv8Nr+novRFZR2+f9E27ObdcS5hTBhP6POox10GflzAbxbwwd302vICk3FqHNwemy9WT5ZNzsPHKfMk1jy4/7el6/z2QaBaiKIAEcKdP7FDktbhvrnhLyUOgnNrcPx56qNv1QmSzNuHtl+VncAKH26c9rCiLuPrvTaCdK8JGjMsRkNIy3MLP8aEquwhwcv1N23pbo/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jNeU2PKxFJAhbyxu3TzP1IwNdhIiyKyl7z5lpa7Lhg507m2KZD2N+siRqWOhmYcoyrIBunGNPp3ToYGnHEUbGNGnLFt4Y/PhP2AluNWlrVKOoKJ6/ueiYXTmUx/lakSL+OJ6utKEotAPcj3jEfq4gRrbFVCqOu+dNCQICnDPrq0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7743.namprd04.prod.outlook.com (2603:10b6:a03:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 11:29:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:29:03 +0000
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
Subject: Re: [PATCH 05/17] block: pass the operation to bio_{map,copy}_kern
Thread-Topic: [PATCH 05/17] block: pass the operation to bio_{map,copy}_kern
Thread-Index: AQHbs5LVusHl4vtgO0usWyc2jNXywbO6jKuA
Date: Tue, 29 Apr 2025 11:29:03 +0000
Message-ID: <ffe6f4a9-e0b4-461b-af9b-daffdd94a1e2@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-6-hch@lst.de>
In-Reply-To: <20250422142628.1553523-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7743:EE_
x-ms-office365-filtering-correlation-id: 39fb2d71-f8c7-43a4-3a99-08dd87110ba9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEVObmFidGhuSDlKRkYvdC9QU3V5MXJoR2VhcGhvUWJ4Y09zOHp5aDVObis0?=
 =?utf-8?B?RjN0UDRacVBNUDFrSk1haFlnODFMSkM0d2ZYai93aHV1WmNZWE5PYnFEWXJm?=
 =?utf-8?B?b1ZpcWQ4a3ROUGk0SmR6YzFuSGJ4NTZzM3VLS2VkczZzNW04VGplRFlkU1da?=
 =?utf-8?B?Q09zRUZ0bG92bmpEVC9pMnMxTjlWWUc1aHRLM2ZnYlVHQjlINXFtWERKd3My?=
 =?utf-8?B?M0U5WDY4a0JxVGwvT1ZmdHkwN3ZFbXVIYkYxR21NN3pkei8yZ0JqTGdDVk82?=
 =?utf-8?B?b282Tmtab1JSdTNTcHdUYllnTFM1ZDJjeEVFR2E2K05Zd1pOUTdHOTF6M2pm?=
 =?utf-8?B?VThMaGMrQ29UQjNtRTIvc2t5V0NqTGt6MWh0SUNhRjQ0TVVwMHpwTzFNQm5Q?=
 =?utf-8?B?bTJBQldOWEtQZWIvR3gwcnc3WnBzYmt2MTVMdEVQZFlTQTN2RllLdGZXSGZx?=
 =?utf-8?B?V1Z6Sy9YVnhZWVhMWE9ENVVsY1JVanl4WHZ1bVEvRmQyb1dEa2dXZFB1TC9u?=
 =?utf-8?B?VTlVeDRNZmxZUWNoV0VEVnlQNDY4Y3lMNzBpb1lva2pKdjdGSTNyTG9VbjNM?=
 =?utf-8?B?VWRIekZiYWNaWnZKYmZkVnBWRnhiU0ZYWkZoVEZqTFViYUZvT0VCL1dpUmxt?=
 =?utf-8?B?QTA0cEdMUjgrOEFPemtxcGgxQkJSb3VpY1p5eGR0ZUlYa01JWnhJd0Zqbkd0?=
 =?utf-8?B?Y3Nqb2ZtT1B4VzAzWVowNE9yTklHemZ4NFo4bGRNV3NzRzQra3JYNDJBUmxE?=
 =?utf-8?B?ZVY3aWhLR3Bhbmwwc0tqNWpHaTRYWHhvOFgzQndNajEyTUc2UGpPdDE1QVB2?=
 =?utf-8?B?VEEwZ3V6QmE4NitJbFlKSEhRb0JsdVZKaVJJa2w0azJCdDZEV1hvd3A1YklO?=
 =?utf-8?B?MXZwbmZHVmpNd2QyekhMSU5iTmdLOWxoUy9BbnQ2TUo0aUZUbG9WNUx5aVJp?=
 =?utf-8?B?Ymtnb0tWdU1TYnRpdnkwZ1hmMGo3ZjJ1cE1vN2QzY1Rjd0lRUW1UR0NtYlk3?=
 =?utf-8?B?cEo0dy9RYURWOTdHQWpJbWFFUWNsS2k1Vk1ZL3RuZVRPNGJlWjBDbzdud1Qx?=
 =?utf-8?B?ZGZwR3JOSjNZTWdpVmhjVklaL0F5S2E0SzgxQTFENE5FWDB3dzJyYzBiRTk2?=
 =?utf-8?B?aXBhRDJSZjhiakxkVWlCbEcyeERQU1JCMDl2alpHU1dpL1FQUUIzaW90RytQ?=
 =?utf-8?B?dXNGWGsrSHEvSUNQaGpZOFFZTjRCSUF1UlZSeWd5Y3ltRklYdWNJT2RINVlP?=
 =?utf-8?B?eWFEclFralR6ZENjVlp2My9HL1o4YVpDU1d0ZTlPYmJUWWcweS92a2xOQWxJ?=
 =?utf-8?B?SmlFaFlXRW5BNTFwaXVwaHpOWEw5ZEp6aTlWYmJYNExFSWU0MHF1VHFpVzZi?=
 =?utf-8?B?M2EyQjc4N3BOVXFtR0Y2YXRhNzAwTDQ5ZjlXNFZwSjhVall6Si9FQzNrZ3dV?=
 =?utf-8?B?TlNuR0xNdXZDQzAxaGw3NkE0TjBrOU9QZWI5SkREVFFheHJMSGZoanlKeFp2?=
 =?utf-8?B?SGlrSDR5UUEvU3hnSE5tcHlHRUh4cm1WSmRWY0tDOFhkOHF1bVZ5RFFJdXFs?=
 =?utf-8?B?VEJ5UDdZa2xlVFM5WVU2SEk1OEZOZEFVNisraEdRUFh5V3h5VEdTTmRZTko1?=
 =?utf-8?B?QnVmMmpvUEtad2s5dk04ejkySk9NVERYQS8wc1hTZWdBa1d6cU5UbVN3YWhI?=
 =?utf-8?B?WVpnUzdGKzRFZFgrMjlXTWF2UWM0dmJnbHJVUjgyRjhZYzVyaDE2ZHNnSmtV?=
 =?utf-8?B?MnJ6elZXd0hlaktmOERjdmpGWi9OdHF4VnN2cS9YakwxeC9pQW5hVGxnYzlI?=
 =?utf-8?B?VFpRM0YrMUxUVnNxbXFQOXZvMFAwcFhEK1pFWTdERFRYV3p2RXpDZDM5ZU1z?=
 =?utf-8?B?UlVGWlhRTlNxZVJ2UmFaMHV1ejQ0MU4wU3cyY0hPaFpRVWthSGxLWEdBL3Ir?=
 =?utf-8?B?MkJXc1pzcFNSTkUvanJKc0paeDVXaUtzZVFKNEJDeXhndFFjUWVtN0UvOVQ0?=
 =?utf-8?B?WHRkOGk5K3N3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmk0MENTVEQyb3ZmNktNZ0VyTWJSWEw0ZGlMMGovcFpLanA5eEdvM2pIWkND?=
 =?utf-8?B?cVFQNy9TdlJTMDVKbEw1VjBKeG5VSGZlRTJYRmdXYzdtcFpBSmgyK1ovM2I2?=
 =?utf-8?B?NEc0c0cwMXpxdFdac1JNVUlxZGowT1AvSzVPa21Nd3RRdHlsdTZmUXpHOXNV?=
 =?utf-8?B?ZXh5UzFBampOeXRKUnJQcHRtdEVXRVVxOE5PcGZUWEZSRFJ6d1ZCekE5OSs3?=
 =?utf-8?B?U2p5WElxSGxTanVLNjBWR1Q1aHI4emx2b1ZINXNwTjQxaFo4cVZqV3VRK3hY?=
 =?utf-8?B?RzhBV3lrRVpKWUFsTFNuNHQ3R3ZtaDZyZ2pONzI5dmZTYXRYM2RnSldudjdZ?=
 =?utf-8?B?aVgxZk5GV1l2VkswSVN4RmtqbWZNdXBUZ0tFRFYrNG40REM4cDhaVHQrS2ha?=
 =?utf-8?B?Q0VrOXlNV1FMZ3VaUGFpYVBwL3pLREZab0VJakVzZENZMFY1bHJVWnNLczRi?=
 =?utf-8?B?cmpvK1A2b0oybkMxK0gydE1wU3pBN25nQnZuSGc3NldDVEhZSWxLVjdBb09E?=
 =?utf-8?B?MDJtbXI2TUk2TS9ELzMyc3RtYzhhZFRacjl6QjJvRkE5NjVkM1o3eTN3d1Ju?=
 =?utf-8?B?THN1c1p4WURSZW9OL3A2LzVQRlJHOG44Y3lXb2ZPNGFuZjlMNkpuQ0h1RU1h?=
 =?utf-8?B?dGtkdzNRR2Z3bWJtZ2JHS2NIbFFCRlpkNWlXR0E3d0MrOXJZZ0w2OVJERm5o?=
 =?utf-8?B?QXg3UHJzQ3QvODFDdGJvWE0vZjBDMWlmUHNPckJzdzh1Sm5KK0Fabm9rTE0w?=
 =?utf-8?B?bUhpc1RyK0RtTDhtOVBTdVFLQVJpbS9PTDBaa2ExbEgwWXg1YWc4YnJBOWg2?=
 =?utf-8?B?cE9aTjlNOWU2ZUxiT3RGWFBqQVJnUERiOXluTWNJYTBpNmhTV3hCdE11cnJG?=
 =?utf-8?B?VHZkR1hySEdpOTFlR3lUZWhVVGtjY2hxcDYyT3duZU9XTS9Fb1F4Y0RKNWdI?=
 =?utf-8?B?bmxlcFdjVWFnV25mbzVTSXJ6NUlOSGxYRjhZRGM0bmU1N3RmaDBvaG13SHVs?=
 =?utf-8?B?UVZlWldNQjdaZlN3cUZXb2dXUVcyZTFKU3FFbHBxUGRvZWdHWlhDTSt3WWI3?=
 =?utf-8?B?YW45ODhhYmNLemgrNElMOVB4bWpPeHZqSW9qa1dzVzVrdVV1TmorSWRPQ3VK?=
 =?utf-8?B?aW5DNmpBenY4SXFqc2ZIT0NRVzdiSlZ1aGxub0FsMVlxU01GdFJhTks2RVRS?=
 =?utf-8?B?bVYvWUZOdE5nNWMvYVVNemxzTE91Q0EzQzJQTzJRL25ZYTVEZm90R0JkbHV3?=
 =?utf-8?B?N0N0RHNwVWhNWjJLVkJYWHdBTmcxbWpVS2ZuZlNPaTIzcWlpdzdxQUNrcldE?=
 =?utf-8?B?cDVuRHppWWo2dnIvcjh6WGpZaVVvS3RHQWtWbG0xcjdxdnlScUkwL3A5QkQ4?=
 =?utf-8?B?dWlOYngrdWRqdTVJd0VlSEFXUnpTR0tSMkZxdm1jb2l4UndiUVFhL2J0NjF3?=
 =?utf-8?B?ejB6eUdibnNETjBxbGFHWWVFdW81N2tpcktkMWVGajNNV3Nxb2dHcnBUd25h?=
 =?utf-8?B?YUNDenNJMytlWmZnbTNMdEFYZTNJektjSXpQNXZ5Y1lLMENib1N0Q2pkZWJT?=
 =?utf-8?B?LzJ5blR0Y1B1RkZxdWRQT0k0eFFyL3g0TkpiUDFPU1VHVlA2Tm1DQm5Dcjlw?=
 =?utf-8?B?OUpLc0g3WXMwQlBRUlZUTW96L2hXN0NyZ2FYMEtOZ2dNeWdCNmxoeDNBTndC?=
 =?utf-8?B?ZU5kN1BTUENIRlpoWWU1WmtXSVRYVlNmVTQyZ3Qyczg1a0h0TnNkajlPMWtX?=
 =?utf-8?B?VGYxU0hjNCtpZ3BkRHlWV0h1cGFDOG9yWWs5ZURsa29QSWR1OGtPRVJlWjd5?=
 =?utf-8?B?TnZuMkJPZkxOeno2L0Y4R0tUSDhOVUxXSTBwTndOMW5Pb1MyN2pUeGpHUEUr?=
 =?utf-8?B?TnFmMmduWENkdERJSXhKVENoNmY2STIyaFRMOWFaOXVNU296MFUwYUljdnhZ?=
 =?utf-8?B?MUMzbU1oWG1CU1VmVzNZUzRONy9ZOVZENS81OHNEekNBMll6Mzg3c2Y2b0ZW?=
 =?utf-8?B?TFJ4NXFMNm5rTGtwUE04dFpPVjhaVkVlaUVQWmlscStRWGtjcDdsVWVXd1h4?=
 =?utf-8?B?bmxuMW1HNTN2WklXVC9IUm1HNG4za05jTEJTQjFJMmVKODdxRTd2TUNJcFJB?=
 =?utf-8?B?bEljNStSdWk5T2lnMXhSTDI5Mk1FUk1mMC9EL0VyNVY0MUlEQkZYam1hWmJS?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F10186197F606143AEE766A9490614BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nIlU+pW++oZ08FZChGqxxdcwCFrLCr6q+Dp9oeHbN5brzU9M21BY2IIn+KaHammvwJVkDMdA7n9VoO2SgZOs7UdJBkhJ3JOrOptkZ7EoQeGYOheNoAWYguuK7kiCORRYkk9Gt3D88J9nWT8/yH+qRW9UrG16SSKgnE0M7XmrG34jPinlZrt1YchrBeq8Qe6KcNGmbnbUAY3X9LOVYE8tRP0v9IU9zu3FSTR79iuqtaZ11L59Uy4W8iCN4LWtGoRtVP+dZLGzsbIf+ge47ZDnGBY3AmSBih4L4tL/VWmxTPMW8dGR1g1/D1a4nTf1+wnyP7IKu4aP6Tb3F95/o55buSXhjjKt+Nu9qbS4dW6j2CM2xMzkALPZGRBW1ddQ8srsybgl555IC4DDf4OPF2yPL5I/cucvTfxTXi3jNVrTrZ0OPnSk+S8qesyMsY0FKfBH+TaH4k17rT7fQqQA/eEz8m3rhalt6bUoolkDg0pTm19NcYVFgJ3qGXt5s3H7b2wYkbuAoaXFpt1GqW2jzFpdGvcIKYtUE8loJVm4Sx1JQHDQxbST443xQIHUesKUE8GUqk+RRsMyAkxzKSQ/WZ9BtBSBA6ddkaU7DlDd2VWGEaWox5e/IrjXaxn9oY1NVJsv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fb2d71-f8c7-43a4-3a99-08dd87110ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:29:03.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IDDk0xm/h77FL1rfQMfV9nX8TyBRikLQzqCiUGeHkvq6/wTOu5att6j5YnaMctu8Y1d4ZFyXZyFOhMKXXHbuT1uwxoSS8HDvQrpNL50070=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7743

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

