Return-Path: <linux-fsdevel+bounces-47502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9EEA9EBAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0297F3AD21E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B81E1DF0;
	Mon, 28 Apr 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n/iTIxSW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Agtj1A+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8923233145;
	Mon, 28 Apr 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745831907; cv=fail; b=t0THRw2CdVqwg6s50zpqvqPdcmf0Dbb2UR587fyAZ7PENTrF2MJlnbHWBtgexg10XhReVsopomQ8/EDpZv8NhyB3nf8ecz+QUSqJ4hT1ytkPcO7L3TPeM83+aLAjtwia5xJbxkBJYVla/urcsgyx1DL/6WhrXNNiv9+O1HKTLcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745831907; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=seARsYnqRjtERkd2Cdr2XtKX8fW3xYECVBftI9ZjKEiqQwppe1+cHzKYbsan2oP3F+QB1Iud49gNubiOApEPtvjUp/kuqYYCwfnSPmyuBhhOebbQ2Yxg3SAtXGbFT5Ls+VCY+3Ccn97rXMo0wipgtTgRE6csCuiN3ET1rE0Rl+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=n/iTIxSW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Agtj1A+n; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745831906; x=1777367906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=n/iTIxSWPkTIvi8qLCH/HdqR8KcMLJGtSjJgqZHaUrIUkhuxfB1Wf1bb
   C2i/Xmse3JrLrRVOMGxNkSNvWVco3LUVdix9eFVO7KFeHC8Fbkiq9itwJ
   U3cTyH0Bg1G8g9PPWiFkN5jdXff803hIYT5FwAbDwmCh+L6q8WKRkwtiN
   QLa2/gmdnaqBKM5m3Vhr9xESul2IIrHxE07igwtK8TfPhazC+hrBPgfvg
   XyHdCu96HhtI0+DBv/4z28SgDFSrYL+aC9usBRnUbKfFr52Fr1CpwNld2
   FELWYDqxzMWI6ba59EMpHmxJWyFZWfgdLNVsirvjtUpgfWWxUezxsfUqI
   Q==;
X-CSE-ConnectionGUID: ggR+iemKSJC1fT3FoGKXOA==
X-CSE-MsgGUID: TRW93quJR1iSrFE52+RgLg==
X-IronPort-AV: E=Sophos;i="6.15,245,1739808000"; 
   d="scan'208";a="76687869"
Received: from mail-eastus2azlp17011025.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.25])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 17:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyCq5TX9DO4y7rRujHsKRnPDst6jiLcr12jMkHlU0hb3haczF6UlYWBHnLsGZIhSr2RXb3smInIcJyZsWczEt2a7Hmm0HMIX6AKy8UA3N5pXQqVU1f/Zfp8zce0KXrDg0593F5WyGvBNJbNZl+ZI8B7gVY+lpiTh0HZqroab4INdYy9fn3RGh7uxnCsZt+80D//p44KtPDJiqMs6PoItyBYRipUrOUP+IAdZ67ptG1Vqrv1gXo9MXYAvWmmqDkCKebT+d0uSVa/zbr/qM/7GK0n2XJH60edcsV7lSt/yPZWXkVMfMD98JQs34pHPuVBB2NuAelI3fppAkOLpf1ccHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=hiJ9fzv0yDmNggTsF4s9Ts4JbY1SDLN6VV79aTES862PefP0I297Y9HxumUsZAo+Y6vXeeKiK+S1o/wXfGKkSR+vkZ5W0tLKcnBvtNYXs0GTqJk1KVg9khEAdZQezv8lherQWSXrE5U2NxOL6Cc0H4zih4bBm/0lFTAMQ8yBQVMaUlawAlIUxfPFRwgQ81tXLlUkG4wGvqcQyZ6CMaq7jTOsujllA55m/jpkjDZuh9PaPFIwyKa/vzRgzrZt95qOaiv4eTJMCo73qjY9fBPoKBB14TPe4Bh3t8Pz5S6cVG8nI/lRruu4BxMAzJTOtO/HIE6z7VtCJdOIgQn7vIr2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=Agtj1A+nD4SsVwV2h3qQjee4WWg//kYjrOX9buTXbPvK1HWe2wA9jxMfdkVxceSC1+BivwveWvk4ZY1VtESRZRZ3yvRgJ7YZmAQk6thAZ/T+mquXdER6Eb9chmgeCeLYVIonvRFw7eOUF/d9nr5eYR2E2fhUyVSDiD0f1IM4eYI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7232.namprd04.prod.outlook.com (2603:10b6:a03:294::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 09:18:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 09:18:13 +0000
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
Subject: Re: [PATCH 13/17] btrfs: use bdev_rw_virt in scrub_one_super
Thread-Topic: [PATCH 13/17] btrfs: use bdev_rw_virt in scrub_one_super
Thread-Index: AQHbs5NbnE7IIw60gkC8Par+3ci2JrO41cWA
Date: Mon, 28 Apr 2025 09:18:12 +0000
Message-ID: <0bd0fa0a-e98a-4ac0-9d91-9e5ee4669946@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-14-hch@lst.de>
In-Reply-To: <20250422142628.1553523-14-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7232:EE_
x-ms-office365-filtering-correlation-id: 70b43dde-1b84-4102-3a79-08dd863599dc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1VnVmtQZXlOV09EdHQ0ZUczWXNEa1ovVFBCaWhYOUY4eDVIaEprcVpjd050?=
 =?utf-8?B?cEp4NWxTcDk1QUh6bDd2ZjJPUUlpeEIxSGJIUkV4M3RrSEVuNHB0MWRhUnMy?=
 =?utf-8?B?eEpMeEh6TlQwbnZRV1lzU25zMksybUNuOXJiVmF2ZUYxS0ZKaVNtZ215R2Jq?=
 =?utf-8?B?RzRYaTV4WUJXY2cyRU5xUUF2c1lPK0Vjd0lMNS9NNnQwM2pudWJiak9meTlL?=
 =?utf-8?B?SDRaSHF4bFJQeW9zL1YvYVJWU2JoUWFRZW5lTmkxVUQ3elZ0dHRCT1dNcjBl?=
 =?utf-8?B?QTJvaFBBcnJFSmJqa2ZJdisxZEUxMHlQTWJObGVENVc0V2xENWFsdWRLa1ZC?=
 =?utf-8?B?OWhKdHFSdk5TTlhoekYvWmdtY0pHMG5BN2I3UlNLTlQyVWVkZU1DNi9PZEdY?=
 =?utf-8?B?Q05qUUJsUzRldzhvMDZpYmxXNllRSHFTVEo0S0gvbFBtUEF5SmNpU2w1dnF5?=
 =?utf-8?B?enJQdDI4dytsS1ZWOFQvZWxHN2wxVW9tOW1aMldCMXV1U05VSVJYYTZiUmRC?=
 =?utf-8?B?elJPTlhaY2JGcjZJS3RMRVFrWUFUL1VYK1ZPQ1pBWWhFZXBwT3Axc1dBOW1R?=
 =?utf-8?B?SkZlWVBLaUozZVQ0YXhVM2dHQlc1OFErUVl5WnNkbDB0MUpKb0syMFNUck15?=
 =?utf-8?B?TnBZRk8xaWh0dzk2bWQ5YkVLU3dheGIxaUNwb2lnNnR3RnhCblpDcFJQV1Bh?=
 =?utf-8?B?T1dmaDNuajRnb2YxVlpTc0JMTHlkVVlGeVdnMHRSbmc2elNxQnFEODQwWXpI?=
 =?utf-8?B?U2l3VGJYS0FNcDJyaDVraDc0ZGYyQkhFcVQ2UnZOQ1pyS3BVK3pMUWhzM1lr?=
 =?utf-8?B?ZXBwQThKUEdyMzVWNzBwNE5ESlJ1d0dOd1VPSVQwKzdIeUFybVRyMVFUZDNz?=
 =?utf-8?B?TVd5N1JHWkc3QlE5bGZySGtUdUJiMStQek9ySnZsLzZmcGw3bWRhN1drSW1k?=
 =?utf-8?B?cHYxYXEwdThiSGd2QkdDZURwWjh1bEpPc3E4empHSDgwUk5kMWcwejhKTnpt?=
 =?utf-8?B?Mm9tREpjelZJTDVuUm9zWnpRZzRzVExuU0F5YW9VUHZFcDIxczNkVTl6SHdB?=
 =?utf-8?B?VFNZdzUvZWIyY29uZjgvRHVnRkl5MlVCeUtpNlJka3NBNUcrbkZvYjZWdUZV?=
 =?utf-8?B?clBoUzhDZnR6MElnODFsbnpQVCtDcnVraExWUU1XTzlyODdQa1lmUGE3STYr?=
 =?utf-8?B?SSswNnAxVUdkTURpemJoQ0pHQWE5STlKUklDbXhKNmprc1FYM3lyNEVrdkp6?=
 =?utf-8?B?cm5GcDFBOHRUeHJLYitOeG5ROVRLVnJpM2c1WHcwSTRLc1kvdUtYNTNzZUtv?=
 =?utf-8?B?Q3pQY2NsaFdxc2VEYTV1cWR0TEpFRE1UY3VUbFNob2xDTXVIV1A2N0xsUGdu?=
 =?utf-8?B?STdXREdsdEVLRDdsOVpDSDZoNHNMdVZBOGIxUHBPczg1L1MrbER0NjBsQ2Uw?=
 =?utf-8?B?NmxjUFBrbHc0K3lNaS9hMXhSUXVHU1o4Y3NaY00vTUQzMDVJaGFla1ZUdWJn?=
 =?utf-8?B?Qzc1S2Y3dHE5K0I4Z3pRRmc5MlVnZjMzVlg1WG5IQ0s4TkNzMWpoZ0x0RXpL?=
 =?utf-8?B?Z0t0dmtvQkE5cDBkTk5SNU94WTZSS29TaWNFQzF1LzFVY0tYa214akY2c2xX?=
 =?utf-8?B?RmZSN1lvMzhNaVVLOW8rS0tZdEtraitZRzhxWk5xcllBWHRjYXJCRGlxT0Jm?=
 =?utf-8?B?TGt5MVdMNjcxVjQ0WGVUQjN5M3h1OUYwQlVZL0pQYUdwZ3dKSVdja2JrNzlR?=
 =?utf-8?B?K0FtU1NicVZtUXpFSC9GclIvRmdkSkIwNkdQakdUSEsxMG1CYTNsUGJWd3lk?=
 =?utf-8?B?WWFZblNKZ29XVW83blE4ZVlIb3M0a1paSnMyQUNxejBweE5kWDdDc0l3Z1V5?=
 =?utf-8?B?WURkUm1GTEpNVTdrMzFKUk5iQXpLWmE5UVdvVzV6THhJRmNIelBYQjd5M2F2?=
 =?utf-8?B?YVg4RytvTGhJZmhtWEdSaWlVRmtQTS9TUnUybFE5MTk4V1Vuc3d2MkoyU1RD?=
 =?utf-8?B?T0pvNHBjdk1nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3ZXTVFVNmZESGhDc085UmVsNDhtZ2ZENURFeFg5NnduSkpSUmZVcWVSbnpv?=
 =?utf-8?B?REhRTG5lZzJ2elY5MjNVb0tHbEQ0bzlvdFF3QXJjMnJSL2ZzV3dMazVVUEVp?=
 =?utf-8?B?QkhXV0lhaTdTc3JGcG1sSWpFYWZIcGdRZnhCUnByS0dIZitkYmxhVWVaVVBp?=
 =?utf-8?B?Vk42bzNtb0JENC9DVWQ4NnBkbGE5RDRQWTBpL0d3TkErNHVvVkl5SUxRcXVK?=
 =?utf-8?B?T3RSMHVwSkJDVWhDcVZmMFBKSlBQN1NKcWl1U2lZU1Y4VzhuNGQwVVkvMmNM?=
 =?utf-8?B?Rk8xSjVkZkJnZzFkdU16TzBxRis0bFlmQlAzb2lxWmpnOHlCdTkrcjVGbTQ0?=
 =?utf-8?B?aFNSVDA4ZEFhbmdjZ1B5N3ZiZ2UwSG15akRVNFFjdmE0NGZUcHU4VFpCYWsy?=
 =?utf-8?B?N3RFSHoxWC85UE1TMlpHZGV0OWFmQldEUEhpSU5lelZDa3RhdkR3eXNsdUcx?=
 =?utf-8?B?Vkd0bVBERUhTbUJ4a1RGU290NTNtS1EwUWhVbkgwRWY1SkpmL1VMRVFBOVZa?=
 =?utf-8?B?SjN6dy9hZCtIZzdVOHNia0h1YmZBdWJGNlRVZTVlT2s5NUREbW1xZWpiZkto?=
 =?utf-8?B?djJGSXdjT0tTaEE4cUF5QkdtTFV4K3FMV1JDODkzeFJYRlo3WjNjSFdyNzlj?=
 =?utf-8?B?OXlyc2U2bGp5Z2FrNWRmeXFEdmJwUlE2ZzBRekgzSXBrbEdMV041RER4cm4x?=
 =?utf-8?B?Q01zcG8yT3pjdG5Kc3dSMUFZWlRTbzNlN3RzZjZ0dTJmVTA5dG5RSkpQTnE5?=
 =?utf-8?B?Um1TUmtVTi9lMHIzb0V2OGk5dThZT0ZYeTNqTFQyOFpzaGxPRkZOcE5SejY3?=
 =?utf-8?B?SzFZWGNxTVowQ25yMm5Pd0prdkx3K0VVY2FkV0lsV202Smc5anZYVlV5UDNM?=
 =?utf-8?B?VGRIR3NweGFJbTZ3ZG1BZldGeEZyNE4yZFRITEFtR0ZucWpCOGxxZ0JGU0tL?=
 =?utf-8?B?djdSb092d1RoWjNOa3hIbEJ1OENXYkJkbVpCMExJeFFubDNweGsvWDViU2pt?=
 =?utf-8?B?bHdEK3BWOE1Qajk3K1BYdVBScSsvZXo4MUxNSTJmTnlBL1ZwQlpOTStLQ0kx?=
 =?utf-8?B?eHlVaDg0MFpLRVZhVGtuOTdLVzQvMEplRTJwRVVHRFhOLzgrc1BrcVNsKysy?=
 =?utf-8?B?SkhGM2xvVmlTMXRUWE1SZjRMT0xDcWVqNFFnN0NxU0xuMEVuNU9ZSURSU3By?=
 =?utf-8?B?bjlINDRRSUN3ckVHZlhqM09MUzZmWVFTcHRZYWw5TTlEWnJCTk1DbzNyKzV3?=
 =?utf-8?B?RVJlMDVFUGttTG5FWDlvcmlKLzVqSWdnT2g2c1dsTzZadzJjVjJsRlBjZ3ps?=
 =?utf-8?B?U1RPeWd6UGM3T1I1N2pZTXI4QWp6dEFJYXFLa2NhSW9Ddi9iOTlGWEpub2FD?=
 =?utf-8?B?ZitldlUrY2hMWnQrZDZTNUhVQ1ZaK2U5QWRqOWRDNG5HK2dsSzZVN3Y0N1JQ?=
 =?utf-8?B?ZUtPU25TK1BEcnoySHh5UUFGYmpUb2Z2NW5NQ04zL1c5bG1rNHI1QkZteHVs?=
 =?utf-8?B?SytTTFoyRkFtMmp0T2s3VFdJNnhzTURTcjBIVTlMUnMxU1lGaHIvb0ZLbXEw?=
 =?utf-8?B?NUVjekhIOUh3TEJhVU9OUjd5eVJoT1hOTXVXbGNNWUVVL2trVm5uaFNuY2kz?=
 =?utf-8?B?eWhuRm03UHlIYlQ4SnFyb2ZpUkJMOXFxdHRreEhwQjVuUEJrWUVtYmFxamZV?=
 =?utf-8?B?bmt5anRid1FxcytCRVhqR3lITTM2WVYrS3N3cy8vbEZCc1g3NHhLeGU5OExs?=
 =?utf-8?B?cTZRemxPMlF4bjdVYjJuTXVNdy9tOHAvR1ZvT0ZBZkwwMVFtY2pCdTQzQ2ho?=
 =?utf-8?B?Tzl3WFdkVFppV1ZwZERuRnhxVE50eWcxZExZWjhCa3l0cS9ZbEQzWEV3VTQ0?=
 =?utf-8?B?d0cwUGordFBiNFNRTXk3VHhwdUZkOVNobjdVekwvUGJQNVFLdncrRVBPMHFB?=
 =?utf-8?B?dVN2ZmwvUm5pVlpHWXZjb0tEWHFSMnNsWkFocWp5Tjk3OExoNmZwUTB6dHpJ?=
 =?utf-8?B?eFYvOXNWUDJaODRGei9oc2hESS9heS9hVmRPc2FvcmwxQ3pyKzhDcFVZOEk3?=
 =?utf-8?B?TUJTNTFWZC9NRjU5Vk5CMkJRSWlWTzF0S1ozMUQ4OFF1TlhRTHlTNzlpYnk1?=
 =?utf-8?B?aW42MWtNU1FtVnVuNzdKUllxU01EQy9tcjNhcWFHUzRmU0x2QjhNNkJvZ3RJ?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA4F12478AF5F74FA23B806A1A148EC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zXJtBKsO2CFSEtHpcX6e7PPT+8see5596YPaS/f2mTpwCr3kBwYmsldKSPTG8tnZt4ne06mC8smiFTu2BXzT0rWKCsVO14ENnxzGNQpkaobIVXtpN6C/AeaG9jlDnitQN6c/1mTptWbW8OPIKKZ7LBLLdmA4NRSaAzhqdwxe7soXsicpJ8cjFXuBjBmCmkyMLvM0uZGcxRttvEHjVp/yUoXTkklmIkVFQhBTRAXuI2hUg/EBk/1+FyBYa4QJQHSz8bGvbdEpVXz9ZgtzoVDDSC3DUOunn+bkC9BaqSz9IFuZi8+Ayg0RGcy89cBZoOlXfuFuUWNFitdPSj5BMJWsQleTicXW5e3lxOZqscxMDf8D5dV+APGhowpGcLg6HKMbVYNlES6o5jfOCnmtfFCRDnGJLhHMfSUIuh/yx2y8uVgcSWI5abER4UkZYTBKDvHrymWEcCVSkBKhTf5i6AxKHd8dMH43gWRO4Hk7kO0pKtd4LwYLfi4Xt/czO0rztILP1aVo2ueS/ZJxhb31tXb/PTLVuraoPSHp99uXgXGKntb9jPTqbzVYNCHeDGPdZzWYDkda1Zi6dxCGb/5dtSZXyQeLMSN9QUFWXglXrsnoq3sKO63Jrga+AmsBFargUp27
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b43dde-1b84-4102-3a79-08dd863599dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 09:18:12.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Vux3Pz62n0TAv4xn/num/QRN21dgo2tEuC/XESzBDo7bJvxNDkFY6CVyO8tY7y4YicG/1TcsaBnfK9P2fw56ffREpO3/Od92u+0Wi+YJ+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7232

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

