Return-Path: <linux-fsdevel+bounces-47587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32685AA09B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F537A8E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7E2C2578;
	Tue, 29 Apr 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eieajeuW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K3dcktkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700F2C17B6;
	Tue, 29 Apr 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926401; cv=fail; b=pYvdzUQc5OtXPlP/JYntQ6y5si2wdebMzbOABCQf00bziWt++N2ZrMWkT3m/tRFRVAOCJdvlxTOTVr+xWLclNgK8+5D19LORkMORPV/uYWgcGg5Y+ilcY/QnePFw5EX1CydmO1W44DmY0lQUoQSnfkH8In8+fN37XYFhMP8LV3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926401; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOfxxYeCLrob7q65lb7quyUPsFRqV6SLP9k3v+A3QQHDUQuqrWzEiBDRekbShHgWnneT9eVMSrtkWf63YofI5jU9o5jB3bnhL2rvFl7oPoEZXUbjoFigesUqmxgW0lxRqhvnTgbn0fi8iHGGAQ1Rl99QfLspMlVm2RwcUjRrClM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eieajeuW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=K3dcktkA; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926399; x=1777462399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=eieajeuWWej60NOckgAiTySMTjzdmZUBXQt/qfWQlJhJPkHEmAVy8Jwn
   eNn8kyv2EqUscyQqQZpMmji6PgBcUwSGc910Iu4csHd6n6uP0rD2s63FR
   RgrdjH/NBhoMj+0UZR99Rz1vMu4GXyqQ4qECcTwxA9b1Q1XIQ8jtA9BHW
   +oM+IFGHZUA+7UyYZFPuVE1Qp8qOEXONGTr72XEEn0ipm7ns65xuio4LJ
   /eXGaOS5oqeO7zlk4ToBmMhoDc24L5VOFxQyuk3W8uy0aGD5YEEJilNd3
   J1nZqPM1pbm+lZ7QT301u6e0axp5nA7cDI/pbKf6lhmpyxVCpnoo4xCXx
   w==;
X-CSE-ConnectionGUID: ixnkLgqsQWeiJ7coRa8MBA==
X-CSE-MsgGUID: WQ6fWbopSSylmn72L6E/AA==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="77463220"
Received: from mail-northcentralusazlp17012055.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.55])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:33:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofCq+JV34XSNZlcpUpfegQCaVWuSSpxZAR5NRfnv24o6hcGkE66xAJg3mW6wB6KWMHG6P/4XDmZhC1K6Frrg0mhhAEhIOk3i/s4rAgJztb8M8UWPYbKh47D5pjl4obeZCYd3macUw/KBOpgQ1WIWYrSamai1EQaIUFCelxjZLgH+JgR4VFANHlaWStXulgrEaaikrZ9Kk3Cynx9bvDlw/TVopU9NRrWqqOQXZFZSCQr2lWzuwsYE8zGhWasq6AqZ+f/FTQa+Pc64s8ZMt9ALqJCECyWdBla/DcmTbPzhK8nYplzLqum6KsN4tnHQWAqYfhYXoguGYg7svrp3pUlOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tChd7np5IOh7RDRIzG6unda9ZqE2iyYa1jYXsA5b+RgooYrHqDmKrXSXknUtzZ/Xuoob/i2ak7v1Nt8RcYw1yANypzrO8Rk+VBo1b2qMs31uwawSKrVv3b+/7gwDULei3JGos7GTlnNOvIWmfU1e8ju5Omao7aF79l4F2aHDyHD00rCQYYuaihqqh/cs0NT5tKmDoM7X3VScjwjW6+p+Yb8SnMbRQcRaA0TzbMZeaYG4BJUGkbmgz1hF3Eouqmesu0MjgdYvDjL8SfPUm3+icDt66nuYHIAchMq4Q7baDZc6BTIUZcQO2e0sIkCpEIrCD0wanEGQ5ezzAGRqbngzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=K3dcktkAqZDNGE/5qhYDD/+4zHsy/ZPFFHLgcODMoMUlAbE4LbXJGfUp+DWZqW8Dp1huWwdrtAQtQ8OEIMFP6PxHJcTXA2vxX+XM8ky9oQHGkzaVsKbAeCILFMpmlrV1KbbBF3npo5LK7aPmQfuMOv0hnA+b6zt6raYk80YCJ3Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9606.namprd04.prod.outlook.com (2603:10b6:8:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:33:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:33:15 +0000
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
Subject: Re: [PATCH 08/17] dm-bufio: use bio_add_virt_nofail
Thread-Topic: [PATCH 08/17] dm-bufio: use bio_add_virt_nofail
Thread-Index: AQHbs5L29FocJjFR8UmNEu0C7tAsgbO6jdiA
Date: Tue, 29 Apr 2025 11:33:15 +0000
Message-ID: <7ebfc9d6-8ae9-4a23-b648-5a9cf721a382@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-9-hch@lst.de>
In-Reply-To: <20250422142628.1553523-9-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9606:EE_
x-ms-office365-filtering-correlation-id: 9156308c-6af2-449a-a2c3-08dd8711a1f3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTR3Q1JWSTlOWU82bkpma1pybnc1bVd5WkprTU02LysyYkNYL2hjRWZBcmlD?=
 =?utf-8?B?UkhvLzhwZ2NWM1ovOHBqUzZjUFVqdGtQYVY4eDd3RVJTNnFUdmw4V1AwTmhJ?=
 =?utf-8?B?bURDR015VG9xWWEzUHkxK3dpZHhrYmx4NElQZUNuYWxDZENlRUxFNjRqRnpa?=
 =?utf-8?B?RytUREZEUHg2dDJEYmJxWmd6Wjg1NEthd1g5UzdKbU02S2pLSGd4ZTZTbVhz?=
 =?utf-8?B?bWJnYWJnTXA0alZPc0VRTE0yT1cyY1AvSUhzK3FNc3NuS3MwTlI2bWNFSlBP?=
 =?utf-8?B?M05wQzI5bmZEcm9pNGJYQk5aQTBBVXNDU3k2K2hweTRPOG5jaFVMZHg0bjNI?=
 =?utf-8?B?bmI4VFRpNk1xckRZcXk4TzVtdEllbW1GZlJFcVlnUFhwaXU5MUFta3dnbVdR?=
 =?utf-8?B?Skd0djNyQi80a2lOVnAwQTcvdTFPTnpmai9hbDRoMWhQV2pjVVFrM0hkSVpD?=
 =?utf-8?B?SFBFRFBJRHYwL2tQcFcyc09lTU8yeVBDVE9STWszWTU5Q0tLTitvOTY1ekh0?=
 =?utf-8?B?WGR5ck9DMmJXdWNNM2ZyMTNDdjR0d3BjR2QzbmFUcWlwM3NQaGVKZGNYSDkz?=
 =?utf-8?B?NDRuV2VJa0xLODl6eUJEQlRvOHZSK1RkQUs2ZTNEV3grcHpNRmtiQUxyNGdq?=
 =?utf-8?B?Y1VyckJHc2lua1lXL3JXZ2V1QjdLRXNlQUx3SGRIWC93eTRseHhTWHlnUnJk?=
 =?utf-8?B?dFppdjI3MjJMU1lGTitRcHpLV05wTlBiZWlHc0YyazYveG52MnRqL1VOTWxL?=
 =?utf-8?B?NGhpUUZ4NnZjY2pGYjlGUVNuS2dEZFJuOXB3Snp6YVdmZHF4d2MwY1g4YzNt?=
 =?utf-8?B?VjRqMk4wUkFuK0IvdzVxY1Q0Qld3QTRWTXVnRnM3RXBmQWNMY2dGTkdBZ1Bt?=
 =?utf-8?B?dUd5b0pqTTFBaU1rQzc5WW16d2k1RmhJRTBWVkhRUnZOdTltdWowa3Vtd080?=
 =?utf-8?B?dDZBQUFzLzdsbEgrcTAwOGZ3MkNSWENTcXFrRFI4V0pOd0RJaUVyTkQ0aUcx?=
 =?utf-8?B?L3p0TWZVcnA1TlZONmZZemMyd1ZSQWUxTjkweVVaWlROUDQrTjJ1VkNZNjg1?=
 =?utf-8?B?L0h2R2xuVUN2R0htd05WZm9vTlk1NDM2QjZOcys0RHJaV1JiamFZdmhqRncx?=
 =?utf-8?B?cWFUbEt0eVp6WDBwTFRMQ2VESTI4TGdReFFqcVhpK2lRYnVWKzd6bURNK0FC?=
 =?utf-8?B?cFBPYlN3OTJ6M0pLQjRtWHZEbGgrdGFEQjBSVFE4QzlQZFlhM0V1WkdDTmd2?=
 =?utf-8?B?QlB6N1NxZ2d5cTBscUxVQ2xuQXlqMTE5ZTA3c2JVb05KZVRFaFlJaXFXc0hX?=
 =?utf-8?B?OXNBNzJvNnNQR2UzejEvRWlSa281a0tKUGx6cXBBdjhEV0NEUzY0SE5TNDJj?=
 =?utf-8?B?VCtRUXU2NVhIWk9aaUVTYU93cnR3RG5zY1ZzcUpFa2tLd2I1NTlLRi95bDk1?=
 =?utf-8?B?a1RJT2JSM2ZMUU1aRFlYd1ZGSnFpTTFoR1BvV1dGQXdIVnl6TEVmUEVFajFp?=
 =?utf-8?B?RWYxMmlCRjVYRE9tdUpGVWdoMkFHNTNzUjFPUmFLMEd4YTgxQmFDL1dNK1dy?=
 =?utf-8?B?bGtHWGQzY2lZRFpFQzRSV3FnNUo2ZCtUbVppY1JKVGRicUk3YWQ2ZkpjSk5E?=
 =?utf-8?B?S1NQUG16M3Z1MTJvQVFCdkxoRUJDdHhUNndBUHdyb1dGbnVvRTB4Njd4N0p5?=
 =?utf-8?B?MTJnd200YWJNMk11MXJjc1BOSDZCTTJadG5rTVh3cmdWaVVDRFBBcHVnTnNG?=
 =?utf-8?B?NUQzTmgrUUJkYityc0ltVjhFalBXOTJPWUwyOFVDNi9uNkhoT2FUZXJIMHBn?=
 =?utf-8?B?ZHBPMXM0YlNnVHhNMG44N2dwM3pRcVpLS2pOZjVTKy9ka1d6a2ZwTVU5K2d6?=
 =?utf-8?B?OWJGN1pLUFVlZGxRemxhdlhIeHFVSkZPNjY4UDZZaEtIaktiRXRxWk5HNmY0?=
 =?utf-8?B?LzB0UDdnWXMvWXc5cG1QcHNsOXR0UDBUZG5xY2dSM1dQRUF6bVNJYUlnWlZM?=
 =?utf-8?B?MktQQlpabTJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blpoQlZOREhCb1pRcGhZUXgvMC8vbk5OUXlrbHdNZjVHZ3VjaG5MNDk3UnRW?=
 =?utf-8?B?M0tMa2FUZVZUeEI1NkYwaTZ0Y1dTbUYyNDdFdldjb1duelQzZWZvNHJaaHNs?=
 =?utf-8?B?UEFaN0ZXMUhNcUlNbE5qWnlCWFFTbGdQQy85ejhsRlhqTnlRYnZiaTJsUEpV?=
 =?utf-8?B?d2NZempERkpSNHhrT2pRM0dZNWJmcTZxMkJmWkEweUFFQXp5TlU1cmJhZkt6?=
 =?utf-8?B?TmVJUE90TGdXR1lhRVQzZ1l0ZVlDOGtENXhFdUh2aWVLWm93ZXlRa1JyNTN5?=
 =?utf-8?B?RFRnY1Q4Y3QvYi82MUhqNEdrcVV5ZGFJTTFhbXhwN29JMDUxU3k2SElTcmxQ?=
 =?utf-8?B?Ty9uTTc2MTRkZHpIZ0R3bW1LcDdPZ2dXZW4vRDhYZWNmNUxQM0hKWjJUNzVI?=
 =?utf-8?B?OVNEWGR4Z2ZFVWl6ampaSHN6TzBhc2tnK3BKOU1tbm5HbGNNbXNvU0xDMlZR?=
 =?utf-8?B?YVUyZjJib0ZtN1J1RktnZHR6T25Ua00xdDlkSWMzWnZPb3hWK1puYmx5bGFV?=
 =?utf-8?B?OG1HeDZCblhjazRzZXRKTGRiSWN1M2p4REh3K1grUzQzZitYMkRaVTVnSlNH?=
 =?utf-8?B?MEsydjVNNW9GZGlKMTF3cXM5K1BsK2tEc0h6Vm84WVFrRmlCaHcxSHUyNzZs?=
 =?utf-8?B?NGFNeXVuWUJHVDNBelV4RXUyemoyNndtTWxqZzY4UHRWTlhrTzA1T0F6WDZl?=
 =?utf-8?B?djZmc2VkSGFIVUMxcFh0TnBRN3plbUtheHJLRHl6TU1Rck5oZGlwTVNrdit2?=
 =?utf-8?B?bXZzSk0wVHl1VGlIT3RBUTBLS3NySk9CRmh5Ym90K21JcElJei8wNFdGdms5?=
 =?utf-8?B?TFJYM0RtN1oweEZ3MWMybHdqa1FjZExhZ0pQdGZRS0h0YnZUb2hnU0c2NWJS?=
 =?utf-8?B?YWIwTHg2NzNhMjE4K0RBTStJWjdvRU91Mys4Y1hvOEhKMk40QUtkSXMwNzgx?=
 =?utf-8?B?WFJlWEFkSmRMUFJ5Q0tvaEh6Wm1vdDJxeVU5VnR3NmlxSHhCV3dOZEkyR1Rs?=
 =?utf-8?B?K1hialFEQkljdDA0Y3N3K1VwTTBqYllSbWdsVThpYnROeXNtTFRSUEhmQ3R5?=
 =?utf-8?B?bHVWSkQyRlFNZUxpOFMvU2lRZjZpQ05vQjlnZUFJNTZjZmdIbmRiZk03Sjg0?=
 =?utf-8?B?T0w2UndaWTBtODdJNDBwaC9IWjFEcXJiWVlkVHBuYnBnZHl1Z0NMRnlQNjlF?=
 =?utf-8?B?MklKVWIxYUZMOXBnbkZSbzRmbWRlbHRIdWJ0cU9jWEpDU0ZiM1ByQkNycHFs?=
 =?utf-8?B?M08vR1QrbG5ObE83aStYL25RcmFnVVVwMWhQb0tqejlIcDdLeVpXb0FHWDE0?=
 =?utf-8?B?QUJBaE5KQm5ucmVuOUN1QUFsZ085Z0xNTXFmUHVnRGQ2dWpnbEI2Tm5DY3RI?=
 =?utf-8?B?YjhvWTJJTUJCSXhpQVZ2QjNPZllvQXpYR0lDRVZnTGtKMS9RVmpRWERyQk9W?=
 =?utf-8?B?ZG9yR3hab1dFQzN1S3V3VGI1M2RrMTBISjd4MGRmUnd4cEVZTTlaWVNMVmYv?=
 =?utf-8?B?ZnlEOTZmUDR0OHBsMWxjRllkZnlWSnFpN0tEOVlPRGZoS25Sc3ZJcDJPdzNt?=
 =?utf-8?B?S0Vpcmp2amM5dGE4RU5NLzhOSGthTzhkYVNhQ3k2RGF1b2dnaXpQUmY1bjlP?=
 =?utf-8?B?eUlKd244ci9NUWd6Q1ZKUXJEbmo5TDJaL0o3UmN2UlFWVm5ySGhMMzdQSTdj?=
 =?utf-8?B?Zlg1bGgxN1JCdWhXYjBzUHp4Y3BJUXo4d0QrUlZBMTRtNDJkcUU2TXV4SUVE?=
 =?utf-8?B?Q2svcUZNcG1DVXdsSEZqc1BicWs1REthTzJsMGJINU1pMVdrVm0ycGhmdENI?=
 =?utf-8?B?bVZtZ0ZxMjBWazlkS2t1VGFKUnhXdHlOYmJTTTRRMFVFTHhtVjJNelJtMHQ0?=
 =?utf-8?B?Y1JIWFVCK3JHQnRrVGJ6UzY1ZkdOQ2VDN0g3eTMvcFRXZkRXSEJCN055VkEy?=
 =?utf-8?B?TkpSVnphb3lwOFRsR3pybGpNNDJZV2xtVmRQQXVmd3JYNmtHSHhzQ0hDMXJR?=
 =?utf-8?B?cm00eUIwbzVKdWtHWEJiMmJRWVhSaVNMZCtNbW9WMHdjSDNoaFNxKzBUYzZT?=
 =?utf-8?B?bWk1OXdUckt5L1hJSVRtNTByV3hONUpzUTJzV0U1c1JHV3BBdUtlTFRCaFVp?=
 =?utf-8?B?YWZXUEZpQXlmSmV5Y3F3UWZNSnExWVhSdE1RNWRsa3Q1NjVuQVRpTW5ocHlE?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <106A40755F0D3346A1B743E436F3A33C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8jaGX50K7j+nobpSGDPXt8BDShxEhQgEsa26kvedgWesHc8NPyqwakZzAuO+IjYjzJm4o4kOR3l9JkfcUqP9XQPNsqEfQJKJRL9kRZnkOphXxHsBrdjsK6fXnD3expSBHXV2JMkvHGi+OVs+bSuz+wCLmKBBXhGaD3jZc4s1ioMfinCggvUdaTbMXib1h5DJJInSjVUK5oepqHiIZuC/rtzqL/Riqu5ickmqO+Nyw81rzXCJjW6ghuvBhMzwEALE4nMg9saatwo08YLZIGGmTfdOTAdsRQ5VibeV5eg1qIKwjJygPRB6ZXTwUSJPNdbbE1WKckhQolfcgYQhce4YJk7WAW7SAHZ0v7p4/cab90zDAidTV5lfiu6mLakPN7UtQENV4noaF87rgKZ8FnLhA2IJaFrGO3s7u6kH9ZEAwWg/WlHHCybBSuxiYAgPz7z4l7RZxueretaCR+jvhoxaOpeNbc0JHr69PFPMQC2d2txrn23tg3A6VU1GVCLvqu3c1ETq2PC/gk6vHAIDdYqqreCcYmJCLNoZls2o6uolHVYVW36IypYbSZS8GO06SiRu5cSZpDIbcV5SjmTJLm9adEy74UPq40C8eoegiYyIpcX9QSF/Zz1d/56sVykjms5/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9156308c-6af2-449a-a2c3-08dd8711a1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:33:15.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceIX6xSyK7s0n38kJqoNBGotcS3MIqiVM8uHMEcqVo4etJXgbpMoBn4foCEPVsOEHTkNepaCHOx+JuH0CCPT7uGCZikMZVrw+z2aj/e8kac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9606

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

