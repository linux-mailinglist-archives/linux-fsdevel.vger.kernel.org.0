Return-Path: <linux-fsdevel+bounces-47577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73297AA0932
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7F7176369
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7A2C1792;
	Tue, 29 Apr 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rAWq/67N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qisdtVFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA325291F;
	Tue, 29 Apr 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924714; cv=fail; b=hIrrPLLZkhwAOZmW+ZOOhLsbUU0M9kVf/N7hw4gQ6HlaCBGN7FgtXDZyer/Mus14+Md0gIGU9tSM6Y5iKgaPsdumPBF0HESP8KBc0jktpzZjsMP25+Jh8TXYpcG+38+xEuxgE4ISGkaZJkVrmgOFwJij+CZuBznW7G/mGRhZRRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924714; c=relaxed/simple;
	bh=2ye9fXwRAhSOvmzYBGzo3eMxA02VbV+2r+qdyT0I8kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPbt9MSr8OTa/KRJ82Rc8xZ5ho3VC/vb8qeqB6cEHpCgU4lujnFV3XyUvq+q7HdVwRKcGE3o6crck6dnLqLLKGV04OdW80QtTV96R+ckl58zublABgv8KEiIQjFTITVEG2cWXpO36xlQLSyS4D7nO5Ew+pT7p7ntTqNVy3BkHaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rAWq/67N; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qisdtVFT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745924713; x=1777460713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2ye9fXwRAhSOvmzYBGzo3eMxA02VbV+2r+qdyT0I8kc=;
  b=rAWq/67NiooC0mLEhs/NvaxrIXHEPgpAnGz8o5+349mf1IL3eVy+VV4Q
   vEYOPQ6qf+r+ezRKG5c4gDxg88xH/TQnWRI87K3BaO9Sjuj8Acm3oIS4M
   f1Was8cFKQHU5FcxwFxeitsJDJHgncdNJC1gssgB2XTx/lC1nFX5nY5GW
   SI3ahOd2v+oMH57sqxUrcevVJtC8b95lG9zqyj2fp2cRqxjcA1YB6fh8T
   bU7JiFuxfU04y0Vu6CoPj595Ci+qWajbODuhjZhSewZv7dxA54D/YUohy
   5ndIm50B8YyDGQWA0qTmeRHYCE6X93CU2aWXmUzEK8ZRBLwpak5eZR3ZR
   w==;
X-CSE-ConnectionGUID: TnctEpd3S4+Iz61/+JLQOQ==
X-CSE-MsgGUID: 4EHz8KtuQkCDInd0DO4utQ==
X-IronPort-AV: E=Sophos;i="6.15,248,1739808000"; 
   d="scan'208";a="78103717"
Received: from mail-centralusazlp17011031.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.31])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:05:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrUlkGkTI3gCU2y1kcEIb3dlhlWwLfMzc9cjlIu7uIlg6VIiOTeDhdg+Q4b53CnbMdSjXh/CCR9MYMee6zOB01Gwff+Z16x8Hpd7qNBOimLIVWS3wvfhdtQ/NWsWY0msjaxmBiUdGEYX/yUYDzs4zZPLnxHzwwabKdH/qcCvlnDzxbJqyeGondjzCpbtdHu0VTv6Q3w9FO5JclHYAMnzrkE9xthodO+bHFsncJVF9vITl5JurdYMtXIIzJuNd9vTDJEzSjlCo1Q+YCiO0TaRKcr0zhLZ6Sl5U6B+EV8dk0Uyi91kK31g2e6/Unt3+/dJdSsMku2dPaIwDz1zRlEPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ye9fXwRAhSOvmzYBGzo3eMxA02VbV+2r+qdyT0I8kc=;
 b=R26u/LhFlzwHJbjPZ8Ue4yMRVpls7QutKrGQak3KUCmGrPQo+RCv37vZ6lKuXb1pCaRMUXop9hSIQjR2KPAm7BKEmBw4K5qg5BW41y/iwZqgjK+3adEqfFdCNtyX7XGD7gBcHZnu+C5RhU8IlcfoIwXUV5gD/rfARxp1x+DWZirdZnFWx2ONbSh0LUfHt07+hBLjIicXe09oxBfl2G3O/VSXAHZxyVh2roT/dK4A1Lc3msCWEbATxkMYYykeBY/POnOlqlAqFNGnWwaOPlYHJ+ryPZEC9bpKFPMxIJe2KtB1+ttWgGSHgXO7P41sw/UYVWdjSQ2YyVaLjwRvdu2qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ye9fXwRAhSOvmzYBGzo3eMxA02VbV+2r+qdyT0I8kc=;
 b=qisdtVFTsmNEKWDH1UNK+/lloEq7uOkr/lwSYUC3u/8a1tJW339E3ZH2GcOXNvz6lpUozB6Lxd3Qto8C9TvNNBmHQhgw2gj+KaA8KvQuJf8HQYRASDmVilzYXz2TCWKye21EOpYP4dphEP8ZXtY/i4ywaNbMabK35s8Ry/a7pFo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6447.namprd04.prod.outlook.com (2603:10b6:208:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:05:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:05:08 +0000
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
Subject: Re: [PATCH 03/17] block: add a bio_add_vmalloc helper
Thread-Topic: [PATCH 03/17] block: add a bio_add_vmalloc helper
Thread-Index: AQHbs5LTbrGsazLW+keM61pwd9N/UbO6hfyA
Date: Tue, 29 Apr 2025 11:05:07 +0000
Message-ID: <7bac2b4a-18f0-4035-9e0f-3dbd0424b35f@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-4-hch@lst.de>
In-Reply-To: <20250422142628.1553523-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6447:EE_
x-ms-office365-filtering-correlation-id: 6df5f4e3-1b64-4ef1-1953-08dd870db3f2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlJ1Smc5eUhCRkY5YmdRS3dxOWNsY1VIV3F1MjF5OWRIdko1ZmJtL0xqWWFU?=
 =?utf-8?B?c2tsVForR1VGMjF5R21Gd25ONXJPSDVFQkpHdWM4RUVFZUdFVkt2MFN5N1Jz?=
 =?utf-8?B?eTZkTHhoWXNVVThkWUx6Um83Y1QvUytDUTZpbzZjOEZ1b0YzdFFoemtwODFQ?=
 =?utf-8?B?b0dFOSt4cU1wcHNUQjhMQWZjOWVNZk1tVTliWDdqL1hlQkJncmtuSDZtR1hj?=
 =?utf-8?B?KzluZWdwOFp5eGU3ZFpoZ3RSTEk2NkNhWm1RQ3o0MmJ4bjRsMzdNcXc3NXVU?=
 =?utf-8?B?dEhTMWRMS0p0L1FUV2hPaXIvN041amRiUVYrN2w3TkFqQW5BOW9ZanUzOUVE?=
 =?utf-8?B?Vk81dGN5b3FhMzFaNHhwRmFrZW91Z2hUVk9rQkVRNTVHNnE1NjRpeVpvY1li?=
 =?utf-8?B?NFpLTkd3RkN2bEg1QTJuallmb0gxVUk2VTZoeGExNDJIN0Fld1RmdjNmazdW?=
 =?utf-8?B?MmVJZG9iTTliZUExbmNIaWU5L1ErNGt1N0JYWnFYNlptcTFGNmpIbFQ1bUdx?=
 =?utf-8?B?M0pISUpXQ2J0eFJYN0xleFYvT1RFZHVzc3NDWUFVWUVqRHhBZ2Y5bUxqWDZv?=
 =?utf-8?B?dWo1Z3hpR2lmUTBXbHV6NVJqaHd5L0I5NmN1NHB0VnM2Zm9HRm9Ea2dqQjBE?=
 =?utf-8?B?T3RtT2M1QVQ0cGthQmZBQkx0djJUTXVBM1VZbzVnL3EzWkxXVmVPRDRxWEpY?=
 =?utf-8?B?bDFpY3V6N0U5bWdOaC9mdlI0bVhGT3BZSUxWSTR6a2lYWEFUVENiaVplVG5q?=
 =?utf-8?B?WjNOSHNpRVdpV2NkVHNXTkMzcmhYREdLdURDYldBRndVK1I0R3lKb2dEVFR0?=
 =?utf-8?B?cHRYdS9XOXB2dWtmUis1UGF4R2NxZk50Zk9MQU1YSmVRWi9Ic2FqaXZtbWt2?=
 =?utf-8?B?djBucWxxRkQ2Ni9RWjlIRGVrTDdpempTUGdpTDZYTWhvOHo3SGtvVzFiaFB4?=
 =?utf-8?B?QVc5R0Nnc1N3alVqcDdlRmNxWVBMdWJQMTVySjRJelBacDFRWDlIZXpkSFky?=
 =?utf-8?B?THRwOVhJRWJaVWJTZkdBZGM4cVhxZlVkd3c1R2JLb2tEejE4QUJaYVJuWWIw?=
 =?utf-8?B?Y3NLZXBmaTh0TDRzbEVQRTlJa3dmNmM5TzlKSW5qb3ZyU3VzRTNyOHZla1po?=
 =?utf-8?B?VjJDZ25FMEZiWWYrL1NqZFZMVHorVTcvNHR2Q05GS0FkVXlJaytMdmhKM0lP?=
 =?utf-8?B?a3FjdE5vTHRXbWgzRk9WaG9iOVdvSzJxejYyME5DSGszZExITzhNQm5OQlNa?=
 =?utf-8?B?TGdlYnBoanN2TzFzSVBhSnNkRUMrWlM4R1NIZXB6ZmsrQ1EyYVgwS2pxWlhz?=
 =?utf-8?B?TStNUEtHTjlVV09uQWNEcUJGWGg2NU1PcW03RDB1VXhvZTF4b2N2anhGNWl5?=
 =?utf-8?B?bjVHV1VrblkxRnpxaEx4TVVLSXBCQ2hIbEFENHlkZm1SZTRuWWY1bGZXNnRm?=
 =?utf-8?B?elBFQ214aWFnMk1MVDRtK05sUEpuQklWb0ZGY3RGbFZmd0VRQitpTTl1U0ZP?=
 =?utf-8?B?OXhGWXpnUXJrNHdsSFRQWFdIaVplbmE2Y2Y3eGEwN2o2OStaSSszR29Ta0s0?=
 =?utf-8?B?N29MdmR5UzhucStEK2ZtOS9GcXRLd1A3bk1wb0FJdjFFMWpNeUpuNURWcXkv?=
 =?utf-8?B?QUlrQkFxK1JJNlJaQ1V2SHA5azMzeVVxbGlHblhIVjk0VjAxUkcrSngvSUgy?=
 =?utf-8?B?QTlhT0YzbjV6Vi9CMHhIaXNqTmRzczQ2bEczN0hJV1RYZlZiclV2cXlnZVJU?=
 =?utf-8?B?dzl0N0dKS3VKZUFKVWJtZXpVZUxJS2hTRHBHelBhczVoRGxHaDJndkpqWmRm?=
 =?utf-8?B?czdOL2VPODE5TURmai9udStpdHYxVkU4ekVqdlh0YmxzYlpzaUM5TW9IUlEv?=
 =?utf-8?B?dFYxNzR5QXlIcTg3ejdGeXRCQU1lajlwZVFkYzJGRUQ3TFdvSXNOTXFoUVNM?=
 =?utf-8?B?d2RqcHFtZ3Y0c3ZDaDlLYVdwS29Id0VzV1dBeDNERE9aVzFUaWgxNm9BVTV5?=
 =?utf-8?B?R25md09PTk5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWkwSDBUZU9jYU5sbjFod0xqdGNuN1lXVW13RjdvY1p5Y29qbE8xYitEUzM4?=
 =?utf-8?B?WXZoQ0h6M0RaNTlvSTBScVNxeVpycTNGVUk3QzRVckZpTHJjcTdkQThyYStr?=
 =?utf-8?B?clRkanUycXphTDZGZmlnNmswWUpYZU9SbDN6MGt2dk5JbjArMktTZFQybzN6?=
 =?utf-8?B?SkY5dVk1MmtuUUlXQUk4azdDaUdiM1dTTnJGZEs1Y01FeGVGWmRWaTUzS1Y5?=
 =?utf-8?B?bFF2T0IwVWhaSUl6MkpDM0lXTDBoT3drd3dwNWNRNmxGRDdBenVuWk5pTDVV?=
 =?utf-8?B?UlhOQXlBajJLNTJITlF2WXZnVVAzSVozMys4UlpiWCtIWHdtc1drbnlwcnZ5?=
 =?utf-8?B?YnNQb3JGM1VudjRHNDZCMHdCaitxbFBndHJ4TXRZbUU4alVCclNCdlVZbmdx?=
 =?utf-8?B?WjRNVnYwemI5REx2dldlTXZJQjJMZmtLTXFFMnQ3d1lKVEk2bGNxekp3bVJ6?=
 =?utf-8?B?TE9qb0g4dG9OSFdHclRXSDhWNWMxaTBFaVVPZ2VTSXp3Q1Y5RlI5V1VZWCtW?=
 =?utf-8?B?Zm5HajZwOVcxOUFtQXJyZFRyOFhaQ3g4SE9XK09Vd2lCT3kzdGZmTXRiVTZ3?=
 =?utf-8?B?MjY2Y09IZGhxSVJmV252eEMyYUxNdHFtZHQ3eWUyUnRtNHdMN2pRaDB5bXhI?=
 =?utf-8?B?MEcwcnhCMDNna0xEOHdUS3JGODhkUUVvSmo3WWJsYU1PMXNpWnNsWTVYUjlR?=
 =?utf-8?B?UG1Yd1E5a05iOFU1bng1S0NMcmlVVGtzSG44aUpQQ3pDbmROY3B0Z2h6dmVv?=
 =?utf-8?B?LzZFd1RJdkZsK1R0L2JkcHBXOXNZdHpBcUsrbDJwRys5RlNBSFdzaWZRMy9Y?=
 =?utf-8?B?NlhvSGVacGtLdDY4TmxSenkrVE5rWEU1VkxKWkJtSmRMcGZDUXU2TG0yM3kr?=
 =?utf-8?B?Nmw3d0dRTGVEYzBLazBmK2tsWTY4OUdxNndxL1FBQUNkTmovZU1tVEdHUlhU?=
 =?utf-8?B?by9VVmk1MFdvcnkwa1d0a3JmY2IwdnVYeUNjYy9nRGRTRHpIVXY3aHVtSENO?=
 =?utf-8?B?eElJV3Myd0RMa1RESmJhaTE2c0g1SkJlRkFXNXR1ZHpmVmV1UVF4OGp5ckhW?=
 =?utf-8?B?VVpMWmxPZit4VVhqSXZiakkzQW4wTzkwSmtRVmFoZ2VqZUwvUzlIeHpncGd0?=
 =?utf-8?B?TXhTR2s3R2U5UEM0QVBRb1JUa0ZNUzFVbnFHOXJxbEw4Q2xKdnlIZnVaVGo0?=
 =?utf-8?B?bmQxTExQVXNNY0JUbmRaRzVSVGVlM0l5blRSdHdvVVVock9XVUppbzdqeE5D?=
 =?utf-8?B?NU1aWkVFeVIzTitwTndzS2gwdFdZelUzTDVtQWZkM1hiZEM0ckhOU05Odlg2?=
 =?utf-8?B?Z3ViMVJrdTlsUUd6U29hcDZLQU9qVXZiY1FPZlV3elRGSm1VSWxJZTJ3UzV4?=
 =?utf-8?B?YVh5WkhGSDRjcjBWRFhkM08rNU5Xak0zWEhLVGdKK0N6czMrTTNjMmFPanpa?=
 =?utf-8?B?c2xSVmVTaDRMWmdOWGp1cFE1cGpqQlBYY24vOWxGanVrdytGQUJtZmJoaDRZ?=
 =?utf-8?B?WDdxY3ZRVStCelM4UGJqU0JBNnpEYUZOYzFaWW1HWGJmbTBneS9IUnZYUVJx?=
 =?utf-8?B?OFZsalYvdWIvRlRjT2ZYU2xVVXpRZGlhL2E0aUlxb01qaGVjcHFvTllHZXQ4?=
 =?utf-8?B?VEVUdVcwRFJQNnVsKzRKaTBXTCtzeCsxVUsxb3JmTUxLeXFZc2lSZkVGNXJX?=
 =?utf-8?B?bkptbVZhc05WR2s2ZnVRVUJPNFVyVCtwbHY4aC9zWXhzY3lNQVdpM1FMblVZ?=
 =?utf-8?B?b3lDN2psZ21GY2FpcnRVUERvYm0yWGFkYTl6eWNRd1hod1JqNzA4b0ZqaHFC?=
 =?utf-8?B?OVhBY29tQ25QV1VJZG9Mc09mNCtCYWNlbk1iOW5FUmg1T3JOM1JQWUhscXBZ?=
 =?utf-8?B?Rm5yQ2s4NGI4U3M1bVhlUDZWYzFJSDNsUlozTGdWWVp5aVl4YUNDWkNCTTNU?=
 =?utf-8?B?T3pBMFZjQjFzZy90WlRTT05sOVZLeUpId09FQXpTRGxJS0VaYkcvU1ZWellS?=
 =?utf-8?B?b2x4bHpoNHd0SkxKT1dZdVM4dGJrVFRYdmROZEVYTWhXamNROSs4TWFKeG1h?=
 =?utf-8?B?VUl3OHhYTEl1UnV5dzBJRm1mTm1NU3ZPcE9hRlpYMEZrZ0toUTY4OEswcnRl?=
 =?utf-8?B?RVN2L29nYjdIdDVTMWdVZzJwck0zYkk2R3pRMkVoaUFnWnBhRy9rb1dFWnA2?=
 =?utf-8?B?REdwc2Rhb1k3eERXRnJVR2dDZkxMSkxhL2JBbDcrb2dkRHRacE4xTWo3QkRh?=
 =?utf-8?B?ZzNlWEsvSXpkUVNYQ0c3Q3VvSkdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12CB2B6F6AE58F4B8BF2A8A62949ACAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zshcl7GdM2W8BJPQdFKEohYDURopNeSUIcj43ArtTWa+XkNXN45/cMMCiCe4pgGUcwYao/CMEal16rYN1BoDFJE049+GarjnneMSFDVfiHrtKyyW2SOZFu0gKhYaOqPHQDJjL8JlOVzTAnRiOiIMkCnSQCYmVdDHJxxZgR+nXwfOrgFOnBJnHfjALEM6QzCq0qxn0fYQnZT2ru0An7sazrronqI8Yap59jWGn0Oul4qBkvscW63Z0PMNavE4ZI5H+jfferpkBoLIm+7y4u1uZ9Z8MwxhMYwp0IjghkiFCckJixrApU1bSVYrf36o1ryWnLx5LlZyMdrJ/ORHUjJ9jtODGh+N9dx0JQQgzznCpdXTjaWblpuH1St13HWKkKa8NvN3rvvSThpdQBQKc+Xp0DwC9yUvwp2o/4TxreFUeLrgpFLOTlWEI2LY2ylH8odRsMfm5uZ7DVo0EfbzZOI2hCss9mGczYiuzbRWURmqh8OTPVkAXlJPICVuIUwhst4E5RhvCXw4I49BInXCtGRcpxqYhuOvTGGnilNv3V0LWjN+Tqt/YrI6JoQvO2/2BuHwF01GltpLbwLUKyxC+EU2SpFSgDcZ9RFZ5IqEeqkAfnyRCNyui/CvgkEDT5ilSGc7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5f4e3-1b64-4ef1-1953-08dd870db3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:05:07.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLmtpuJwQJgqGdbk6caH0jQQzApvLFAVLOkdgFV3dHI3IdM1u87/WpADj6+pzlRUwFsUyuMmLa5YFfAWRU7gbV4bY0w4HSjsYfeJyIR2TVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6447

V2l0aCB0aGUgRGFtaWVuJ3MgY29tbWVudHMgYWRkcmVzc2VkOg0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

