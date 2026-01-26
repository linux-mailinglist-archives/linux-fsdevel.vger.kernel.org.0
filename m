Return-Path: <linux-fsdevel+bounces-75445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AZbEJRBd2mMdQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:27:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9AA86E31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0663013A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB8329E5B;
	Mon, 26 Jan 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eSzyAx5s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IIa184MS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F327FB34;
	Mon, 26 Jan 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423102; cv=fail; b=cdUL55sEixSmTQ77SF4y1+MLosjHdTiRPeeQq4Vt0Igp7JjiTMpiSczV3Nof911CGgQWbQaZ2cB1T4g1k0mXifFbtfVG9pHNoVQHbZg2D6JTEn8uOdOYC/Qp4+SqA+chwC6LQ5roY19PyfJUhc37Ecb8NtMkMUJ8YTHcpVnC8aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423102; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qVy5HlmCj13VI2OzUHnPoDNTE/IZSs0K3UdCzed4mm60bsQGTwmdQn/rzvFch/wOyfgrzPHkDLea8Z34Ypr+x807pfjTvd4iZnzCeUblYcJh/iwAA8Bg0Jf6RmqnGFYCXxXBPA2VT3WuK6+q8k2Ly/NYF0ZxAKsnqYv56dcgqq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eSzyAx5s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IIa184MS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769423101; x=1800959101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=eSzyAx5s1/ie1Jr4oeQGmOdayOGgkScRleFTzyVPLn8PuyHa7H6Z7H1Y
   8sLq3qFf8DEhRGmo64D4bN1/Xc2A7I9tLk88n3Z+5zVvXWsQTh991J8In
   lAVwTpdZblAwpP6tZma+KNYta8ap1ekBHZ9MsPYR4MUJ2GpiZxhvKezCf
   1XseBAnamuhcN3ecRaZzwOne7oiZrQaZBPHCW5uT0YW3CE+dhaweWyMeZ
   igREQy6vGwlXl3iP28P62L1FhMofpY0fN7He4A2b3eqoC0K+rKxmPRlnM
   B9fYhNSMSJ2SjoKxz06vwZ5AlUmHCFCbvLmogq32zk9HvHwRmVnoW2Kxk
   g==;
X-CSE-ConnectionGUID: Q96mHHJOSnGkZD9ropKMAw==
X-CSE-MsgGUID: GsCJ6D5IRvaYqeJU9WpdGg==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="138710029"
Received: from mail-westusazon11012045.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2026 18:24:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcuhOtpWIRLaA/LPbuguSYuXa5gbXMPqLviJmSOartbHEnIi0h8qOcRBk2IEcJNGwRCixhGpsjApm2yx0iteNzcPMm8f2XIO3f3v8X1giQaHHiQK+awxZBCO79j7DHroeR0DVaKPBT6Ku9nQtqtgd1tC1pAfeUN3KEbb+4JVxAuNuw8q84GfLLVIwgXvVBUeTaQnglKFwIVocVCuWn5K9CLdOhUvDNEAFtFvVXd/5Jv/q16I1Jf2ZFptcRwn3pNpp4oaXR7T9zcKW9sZ6r3g2mOE5LoR281Y3+OoFHciGNzw2iVNHrd41hbbSb9iII7Shgun6HIoMS5IzV1Tzt23pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=wSwhYpfuHJ0zskfu2ds/vDPJjfWCqsjhRUvgiPJLcP9DRgrQdn8Qct4/XvBrAqFLxUgAoIXR1B2t1nujmILH2vuwI4HB2Dg5APiPnxBQkE2XFRRP+ENZOaPXgbLigenLvLAcC4QE1F+J0O9aybQu0zglCWPBgiCderR/ThLCM1qS8NYOIgBksQK8mszJHp3Z85+/hKSXqpDr4epq95tZwB2AEa68ip4R9x5jYd4zUOzXNRG549Rpnl+fA7VhLCcMCq4V9CRLcrtYunmDASTH4HCe6J7wrn3S2qQG9EFDXtUC5tA8TXYp6Q7RLkKaXz4AaewWgCzuoItemKbdzZdGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=IIa184MS9XomAXWb3aqcX/ztMOdaUuA8Yk4gUB7iyj9k+yv73ZLu8bZMitOjs2BnSm//BPJvJXmacV5gHk47C14ud9pni9n5j8+7zPnSmqhq/KbNQg7ZIcYGnv3FqUDfangfRfrJHj7UeKDJeez1ytyTuMQd1jHe2zRiyeSPFWs=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7849.namprd04.prod.outlook.com (2603:10b6:510:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Mon, 26 Jan
 2026 10:24:46 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Mon, 26 Jan 2026
 10:24:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
Thread-Topic: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
Thread-Index: AQHcjog57A9CnZwqlUaPsHc6XMSc1rVkPvGA
Date: Mon, 26 Jan 2026 10:24:46 +0000
Message-ID: <ef8a6be9-05b9-4959-9421-caedbf5d33a4@wdc.com>
References: <20260126055406.1421026-1-hch@lst.de>
 <20260126055406.1421026-2-hch@lst.de>
In-Reply-To: <20260126055406.1421026-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7849:EE_
x-ms-office365-filtering-correlation-id: 679fc2e1-8b5c-42d2-7e0f-08de5cc52112
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGJLN3hnZVk3ZWZYU0s2UU4zdWxMQUVwVDlNWlZSZHEwWk9TQ1plcEpPQmZX?=
 =?utf-8?B?c1p3M0ZHanJrRTRBSWdHVURUb0JDdndsdkJwL1RueHFGVWtoTTE0ZVlheE9L?=
 =?utf-8?B?aTRWMFl0RElEY21KNEYwT0JuRXRvcWZUdUJ4aTM2SWJIRnhZem9WQVEvOHdP?=
 =?utf-8?B?L2p3cnh6UDBVS0ZRSDJaTk1MQjJYYldrcm9KdGNLQlNITGNnUnNHZU1YLzFT?=
 =?utf-8?B?c2FpNFpsU0sxWUZZVm5NMjQ1SExRZ0p0VHE5bEg0OU03UzZJc25DZW41VFZO?=
 =?utf-8?B?bmlER1VRZVZqT0taK25GOUFIaWx0ZkpRYzIzWEg4MEFRS1RNNVhMTnorVE5T?=
 =?utf-8?B?eEIxS00rZmtHcmhUZnVFTk93K0JXbDhGcTN6a0F4aEFZMmVpd1N4S2l1Rlps?=
 =?utf-8?B?Z2p1RWdacFBYdjRNMmtSQW9scHY3ajF1SENndkpuRW8vaU0yQ2hDb01nTU5t?=
 =?utf-8?B?OE9jYTdLSDZ1eDgyNEozRi93RzN5S2toY1BSMXh5cHlxVjRic3lPS3pqd2hI?=
 =?utf-8?B?eDRWd0NFdTdRc1UwRHJSZGZpOEJTWEFHWFFpY0hiWTFUYjIxeHFsR2l4b2Jw?=
 =?utf-8?B?YmYrVHAxc0ZMRHhLNmI4M2RSUHAyTS9IMEVFdE8wcUIvN0FzVXJoSDJGZU1J?=
 =?utf-8?B?K0pPRTMwYnhLbHdjamZjMUY3M1pkaWYvRjhaVkE4bDRlYVp4TThrcmNTcFAr?=
 =?utf-8?B?ZjJtT3Ntd1J4Z09xdk03RlZOQWtaM3cxK1NOK2ZsNDlaazdMeDNLNUdOMHhV?=
 =?utf-8?B?M21WS2NnQytjcWNnd3k0amdaVFZkNGM1N3FmcmpRSTZIR3pzOGpIZkNpTE5r?=
 =?utf-8?B?eWx4NzJRcHV1c0wwQnVsZ1FyYkE2bXU0ZTRQT2VjdE5TQU9FQzZiWUZ1anYv?=
 =?utf-8?B?TlpKaG5hYU9jMW4zMzVKTzV1UUM5S09kcGtSRDNDNmxDRjRGMUF6VGppakxO?=
 =?utf-8?B?U2RseVRDMVc0QmljMnNoK3Azb2NGN3NIdytsMmNmdU1MRFZtc3ZqTWxSRksv?=
 =?utf-8?B?dVo5OHAxY1d2UG1hcHlVbVNTSTZ3VUljZWpIVksrV3JFdWpzNWl0YzZ3QlZn?=
 =?utf-8?B?YUpoRE9lWGh3dUZyOG00VDZURHAxbVBwWDAyMTJIVjZieXRLeURQbjRvSXJU?=
 =?utf-8?B?NmM1YXN1bzEvWjg0Vng1bThCeXlOczJkcUdBOHd4b0daenZJYUN1SE85QTQv?=
 =?utf-8?B?UFhMZlhOenJWNkwvN2VHOEsyMENDZ1VGSzROSFk5Q29MUU5LVXdOcGVVeG9H?=
 =?utf-8?B?RldCY2FCYWw2ZTJpYXVXY0puTXdtTkREQlM2SkxxUGcyTlQvbzNwMTJFUmNq?=
 =?utf-8?B?THN5NDRpN2RYOVVwVi8rdGM0dVg1SVk5d2UzWmxqZlVtTUl3NE5VTFNDYnRE?=
 =?utf-8?B?eklyaUk3MHFCRlRUektuaEc2QlZxVTRlei9hRXlwTDZVNUNtSlV6WTZINjBB?=
 =?utf-8?B?QWI3UVVZaHVXSzhsRnBpNUJVTkJESGZRR0VLOVNRYUp5ck1QK3crYUtibGN5?=
 =?utf-8?B?cGp2aEIwMjc3SUlHakYvSTM4WHVwUzA5bm5ZemxnUjVtUk9yNGZRQ20vRnpS?=
 =?utf-8?B?bEo1SmdSckNvTzJndjBsUFZCTUNlQ012dDdEUHJoWkNXYjhlb0NWYnNObGlz?=
 =?utf-8?B?WEtVa09VL0FJM3VFSTNIRUJnNDVHOXNveC9vaDJBTlBjaFNsQ3ZqR3RFbjIz?=
 =?utf-8?B?dDVPSmVHck5HODRyMGVqdFREUDBwcDVqZFV4NWZDR0xGaHlobmhBK1FWMmFy?=
 =?utf-8?B?c25mL0NjaXd1VmFDRjdOZmRPODNKZkI4QkQyNk1jQnhsMVdEWnFxcTNBTm5L?=
 =?utf-8?B?RHV3N1hHYXlqdDVSRUNDOHhVa292encxMHpvOXh4b0o1aklvUXNCTHlKVW5H?=
 =?utf-8?B?YXF6ZzFuSzVKVXI0UUU4aDdXZGEvTjR5TEtkMUZoWFpBTC9hOGtPdDVCWUtN?=
 =?utf-8?B?Nndxd2IvQldRYWZQcEpOQmF0MnJSc3IxamdtT09ZaXdYcW9UcEZyczAzejBP?=
 =?utf-8?B?eFVuMythU09sTnE3NXJTREl0R3poSEtHLzJiUFMveUhCQ1JLYnora1JaQ2k1?=
 =?utf-8?B?SFBjL0N3ZWZ2QWZhWWJrbTF6MGsydXBNazhJdUVCTnAvckdhOHpMZmdsbWhY?=
 =?utf-8?B?SFBoVkhHeEhqQnhmNzJKRTUrdHdMWTdtM3RPSjA4U2VXQy8xZlhoQk9uRnBY?=
 =?utf-8?Q?d7l7X66B4zMMMscK3QH2k9o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3A3UndTajBTZFhWZDNWSmxpSUtXb0RjakpFbDFwQnc3YS9GSWUzQlloL0Nl?=
 =?utf-8?B?SDlqVTdWMTV4VGhGWFFZbFZTSUZYci81b2lsTmVLYm81cFdiLzlzcGx1V3VD?=
 =?utf-8?B?dXVqcHRpNFpvZTBwRllPZ2dKNXVwT2pFcUljZzUzZlJYNmlRRWpYQ1BtUk9E?=
 =?utf-8?B?ZERTZVcyUzExa1FPVnc3MUhoQ09vZm42SGoxcDB3Mmk0cFJIZUtmbkRGWmdr?=
 =?utf-8?B?MUhEVVF5ejJ3K3UzVVRJaW9jazVEMVgvbGFJQmM0dDBaQlNFQ1k0eW1JL0x4?=
 =?utf-8?B?L2hTL2NmbTJoRGZIeGRmamdVQmpJQi8yR24vVDF2Q0tiaXVHcDNoUnRyRTUx?=
 =?utf-8?B?ZmNmZmNRalRZRzRPVW9ia1o1aHlSK1RPYmNpcUJkM0pTQkJTc1pzYlEzUEVG?=
 =?utf-8?B?cmY2bXFqYS9PVDZwODV3ZkFRUlNtVGIzem5rRUFIMlhPMUtFdGswaXUwcG5H?=
 =?utf-8?B?SGlrc0kyS3FvbFJYWWVkQWdmUW5vVXg2L1phT3EvUnBTSG93bnkzenpJeE1l?=
 =?utf-8?B?S29VUTNKT0Q5UVh3Y0ltSGNoVk5kTmZTTW11bnowb2JBZVZILzh2cDJjNzBu?=
 =?utf-8?B?anNMM3Qzd2Y5RVJlSHZhZVI5eVQ0VTRWTDVndlJQd1ZUa20vemM4RkJsVm1Y?=
 =?utf-8?B?TjhpY2RtTVNKbjM1ckVrYlBKcnNPOVN3dm1LMzRXenhsL3RJLzFrUzRqNDZi?=
 =?utf-8?B?QjdFdWZwb25Ra0wwYzlwNThPSzl0dUtoL3dnNkFxaHk5c3hFQXNkZnRPcjRB?=
 =?utf-8?B?SDBrTTZhbDkzcG0xOUlRNnZ0TkpYMmZUejFwQ3Zlc0RSY2FjWm1pREJEWlhS?=
 =?utf-8?B?SzZBNWJvMllkamRmZTBMYjRpTXJEV0pWQ0xrR01LTE5uQnR5WGNHcktNNk5k?=
 =?utf-8?B?cWRuZ0licUp5NlNsUW5WTEVaSjd6VUFYUGhVQjhuTU8xMUhQVnlpWEppZTZV?=
 =?utf-8?B?K3owODhhOUpsUklBU0JHZnpMV1Yrengzb01MdElqMENZRllzbk9VZHVtY1Qw?=
 =?utf-8?B?WmtaUThXVmlaRnZLR0EyVk96dEJyeWt2am9FWTVsdVIxbjhpRndUcHJJMk8z?=
 =?utf-8?B?Vy90aXNweVY3WkV1RmxJbGhFemdQMUM4S2d1b256QmxTWlJEdm1tQk9BOTIr?=
 =?utf-8?B?N25kcVQ5MnZJZnp1K080KzQ2T01JTU1Ec3l2T3dwbHRSWWVVUGUvbWFTVzNI?=
 =?utf-8?B?ZGE4S0gxeWgwZWRqYW1xcHcydlRSSjQ0MkMxVDJraWhNWGZZMFFLbyswUmlP?=
 =?utf-8?B?SEp5dlljaEhrY2QxWWVUcDZ2U0NnZGt4amRQK1I0bk9GcGpMZi93QUUvSEg1?=
 =?utf-8?B?cDVZZTlOYzVTZWp6WWJJaFZtdFFicnNlRmwyanZhallxM2g1UUljSWhEZWV4?=
 =?utf-8?B?MDM5RHJxdjhyUmMrRG5Nd01vVGdnWmZmaUF4MWh4WTUyODZNMVhLRUY0NTc4?=
 =?utf-8?B?MXY3RHVwSW5TQ080Z3JndDBFbDlxRW1yTkQxMzlQWThNM3FoZUt6Zm1La0d6?=
 =?utf-8?B?bXROVXVlK2h3My8xTGN3S2ZBV0xvOEZ3Y2VnYVJJTVJiRDIzeHplaXNnbGpx?=
 =?utf-8?B?YzRtdk90bUNlZUorY2RDdkFtRmRuVExoRHhiY3dIZ202Yy83citJTXFZQzJY?=
 =?utf-8?B?N0l0TzBlZStlczVWUVpzYUhLbUxPeG00VE5JTVYrNnMveE03emdwWHB3SUtx?=
 =?utf-8?B?b0dKWXVJL0Q2dTNGY2ErRFNjT3czQ2NqVWJYblhneWN4S1hFaWJvV1lHNzgz?=
 =?utf-8?B?TU1udXNqTUV4QTN3ODBRQUhDamJFUXgwRnNEMWQxY0ZCaTR0UWtHZzVSeWxT?=
 =?utf-8?B?aDNoK05MRWRWR2JRZDQxU1Vnd3lyU3o2MDg2R3RxZ2dja2JqTkxicFBId1Jw?=
 =?utf-8?B?WUZUWGk1V2FDTno4ZXRqSTZyK1IrR2QxWHRTeTJZZlpkY2U0ZHJHWm53VmtR?=
 =?utf-8?B?TURFT3R4elo3OUxSUUZqbHVqbWlRYy9hOCs3M1d1ZlMvd3Y5ZTg5cERCSzJj?=
 =?utf-8?B?Z3QyYS8zSmFpc0J6N0o4SkFXRHJTd3ZvcU9LLzBlQVJRc0x1UFlIbWx3cm9h?=
 =?utf-8?B?UUEwV2pkN1hLUytmdlVoa2tFdzRyK1k0cWVEZHlkZmwyM3E2a3Uxa0s0TUpI?=
 =?utf-8?B?UHY5TUhyVXZuM0tCL0VRb3VOVFJoZEwzSVlhb09rTG1kOGNDR3ZNWnZhVWs5?=
 =?utf-8?B?UGNEaGJXVWsyNTJVUXBDWDVTc3pxMDNzbnA1OGdXamdpOXpkaFVlK0luQXow?=
 =?utf-8?B?c0NyOEVvVmNXM0V0eUt2Z2F3eGV4YS9Gd01XYmRESzBKSlJTNFhkSW9WZzVE?=
 =?utf-8?B?MGxVUkgrbllEa0tCOWZsRnZYTmJRQkJLSFJlejIrenM3K3FTQXZNbjdKYU5Z?=
 =?utf-8?Q?9Y9THc9tXu5DYSeQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4A54D6ABB88F42A902FC0E4B1A22A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SlAsxL/E1zvJm5mOrhXISiOM+fzDD1i915xA0P5ALfBE9fXig+MEbiVf7aLcFgqtkQ5xSmIlaKM0Z8seT+BhQO/7kLJ+pchTc+pE8g5ICKiN0JbqH3adOxDzAZuG9SaRjspbinBhuvpQX66jm8zW6OSPrIx8Lm5usYiIKNiw/L09FpHdnl/2MdcxBtZnxO/mda0ZD1ZNPoyrCmwTMvbNjOUwLYjt6xpnNY8paqpYRqm6aENjjo4GlY3Wt7kcjvkhh6W/0myzzPyjUtxAsLG+fUe0twG9yBlV88Myw1q3+y2FrIfD54WpbXI79h52xvzwdFQbCIyb9AEx26RAlHr9Zw2NzQuXfJKhstGEPg9tYYCl0uao3xASlQ7vPT4X8InCU225zUVxrIfx5dp2NqtUMIpUhCWY5556DpAviPMUAyFv8K4zuHDhrMXpH1sOF4GjtAIvBqifcHCUzW3hnSzOzoUXY6wYSH5bOUkd65XEmVUuH0NMEwX3Fbk7f8bRyehW+6hPKOSlVvWRkXIFh377IVw3AOb61wNTXped/K471aGOU5rwn4wA+uz6jfId1Dw0RZ8gWezqmM2fe07qq3b07d83sWcG1cgqyDtCwVmYQfAqoO507fqfFs22RQTk9tMl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679fc2e1-8b5c-42d2-7e0f-08de5cc52112
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 10:24:46.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxyM8pI4Znna4IAhuWefGkD84v22jFFSoRpTJGdFBAgED+2NrHbR/Vo5ZgSmKI8gqXYVQGZigyzVAg77ORqp6KrMYN5lqcSxqfKQ+2cb6MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75445-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: AF9AA86E31
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

