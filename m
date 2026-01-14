Return-Path: <linux-fsdevel+bounces-73700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A1D1EE97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0879330519EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D25399A64;
	Wed, 14 Jan 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dees5A4G";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XgLBHYyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED361399013;
	Wed, 14 Jan 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768395122; cv=fail; b=h+DgTrl8LKN/lAcUuG/DaBsvhzdDbUcq+L4cdc5XvDXJNFiPjhfVCZkQugiZHCI2MEghIWTHyCBTj+j6sxFy7rkaJIsDt4rGFEWzZ+7aliWP5NwpsArG59kB7JyGDBkKlZO95tdoM0fge1kGD+e6Gx91Sx2iqSexqqb+GnnV2ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768395122; c=relaxed/simple;
	bh=JlBbTvYD3VcHwMaklp0Yyo6VRVe/HTtp9JNhePzuRRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHY3zwdUR5nUaEJvf6NvPxuHpWOdlk8MVPnalH8zhUh8RC1CYwWu20x/HOcnEdt3J6pQ3l8v+JWyyfEDtvsMohZGp/CJh9+5ud+N83hrefabA2ACFQPUoXVXOVGqCV7u8WIdga1Zlre1b3RAwSE2okQDfhitvDV5/w9drtgTw14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dees5A4G; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XgLBHYyH; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768395119; x=1799931119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JlBbTvYD3VcHwMaklp0Yyo6VRVe/HTtp9JNhePzuRRY=;
  b=dees5A4G5rNcovZlxtKiXS91VGocTUkIYtv7Aso1SkIN1B6A90eqrt16
   gGEiX1Sq7KSKTBTVm3l7+RBONB6FAPeNRoR9xU8Uyyz8PmH158GQ+3MAr
   lRwCpDgGYXkud6AA0B46J1pn5xOo0XxtGzoRkt2D0JS+BTbH3El8Fez+3
   PbV8qlJ/G4GRvaEhcDymycOQgGqrj0as7VfTlPd6pB8EyYSmXD9i9D4vi
   3dIoetwPeQyRi/dD1xpajGco5WBGvkLdpg4ktXlMkatoYmibKAQk5knxo
   mKEM2OezetesnvIjGMQd3i4vNAzBHgxjgXr1vGxouPiYEkX93CIAL3koh
   A==;
X-CSE-ConnectionGUID: Y0xQh7+rQ020Lnpx5kp8mg==
X-CSE-MsgGUID: vPMdjuT1RICOGY4yUOrTDQ==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="139473436"
Received: from mail-westcentralusazon11013040.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.40])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 20:51:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnb0OleJL5Xvs0WRhJ8dEoSSnicnfCQnORgWo6+OKNN1QRuiBiGF2WRmkw8vEtxIQfHjSRCZ4hRXaq7BxBcypNtUy4406rlOWZcyp0x8xMNOZZAlKQeXJPj+ZAgYiSBJrigDPKvLtkLQbkcdHHWkXhqhaJTcymHRkP2dgbj78moAzU2BbEBm4eMcZenC9d05/QGKNn5ACGuZmlwYlk5UMw/uGqQaCac+OkLfXAbuS/R1MLLKIcxNIqS7VFQitUVRw6sZXU+MegOEnw8Tzm9FxPrcRguFt//f2xXY/VLUHTl3KsTmy7P78G53GQWT3OFxvNRsXgmzhFyqqwBeH4Lh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlBbTvYD3VcHwMaklp0Yyo6VRVe/HTtp9JNhePzuRRY=;
 b=AW3eQ6sw12HTrNQ+ze5uCUqqK3z3ZTToyun45akweKvy/N8UA95D3Wp1kykApwaSwwiFolchJnvVHfgZ/2D1Dc3H5oNKBEtdFiRDeJeMg6gjPaAxvJtwMFhLE9wN06ZqRIldcAxzhVXojoRcE2OCcaDy9d6d/P85RTUvXY7rPs80I2NFOxiV5jJNjiLY5/zDCu7Nw6DJthM5J7i9ItUkX9RjBc9M8eZ8MtpF8q9H/Ievs1BwciLfqWqm06tS19VvaVgBwWlXAOMXJWhHG28/8vWDi6Zqueohs0T0Ae6S4U4C3JJFVELjYDGQSMVLkT06SIse1JB8IjF7VtGGsyVt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlBbTvYD3VcHwMaklp0Yyo6VRVe/HTtp9JNhePzuRRY=;
 b=XgLBHYyHWwxHpo1HGPBW6ZeHc+Rz80MtmrJJXm3PYELKuUArTBH5NgaNbJMT/QX9CgYY6HQ7qvzycyVd3Hw2IqBRj47NDgIlnZQZ6hNU0vEB+96VzYr8orRGnxjZw1noO9I8cK9std2Q3t7WBOgqZgSQMgOBNE5Y9xjJ5dXFVw4=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB8371.namprd04.prod.outlook.com (2603:10b6:510:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 12:51:56 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 12:51:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Thread-Topic: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Thread-Index: AQHchSmBWp13y776yk6CYzqw+Ftv9rVRns0A
Date: Wed, 14 Jan 2026 12:51:56 +0000
Message-ID: <5cd780fc-f30f-4370-80b1-7228444424d5@wdc.com>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-6-hch@lst.de>
In-Reply-To: <20260114074145.3396036-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB8371:EE_
x-ms-office365-filtering-correlation-id: 869ad5ad-4766-48cd-c475-08de536bb343
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0ZIS1JqUzRjVFpsWFdNNWxJb3lkNlc2OUYzOFFaOFI1TThqS0lPM2hsYkRC?=
 =?utf-8?B?Tko0amN6TXg2QkJYazdXVTBBWUJ6cDJHTXZuSmpxam0vY3M1ZDUwV0IyQjNj?=
 =?utf-8?B?UzVHcUVpK1pvTkdOTEVmdFlDVEhXdEVKaytLSWovbnI0a29aZDhPWlNPNEM4?=
 =?utf-8?B?Z29qRFI5aDBrTS9VS2E2T3FZOGw1dmlDYmh2Rmpxb3dPRFVBODFPMTJ1dWxl?=
 =?utf-8?B?YjVZbjVpS1pZVVZnWTVoWlMxbkUyUEdvVm5Id09Kalp4emlBNlNWRm1Sc1Br?=
 =?utf-8?B?c2l6alJXcUVCRWY4anptQU5MYnFVOTQvWm85aUlyc1ZRNGNnWmxUNUtjaDFT?=
 =?utf-8?B?VTBjTkxSWm5zdXJaVkpWMk5neFlYUlNQWis2aFVyV24rQ1V2RzFpVDN4SGxJ?=
 =?utf-8?B?eUs0aytLMXVFSnVUN3BLZDUxakEyNTBnT3BVWERaZ0tuWUwzdTMvdm54aXdi?=
 =?utf-8?B?TVhGelhNY1NnM3J6Qk5DeU5PcUFVWU9KN1U2R0J0bkhqMTQyaHJLSEp3WkR6?=
 =?utf-8?B?Q3lSQ01oREEvTGZneC9nN1ZCZEtId05qb0x5TGMzNDRMM29TZFNNdEdjY25h?=
 =?utf-8?B?T3NsVHQ4MWRxTVI5MWF2aTN6RFk0N0ZLMXZPbWNaakxRczNNaGJKeVQxQ1lN?=
 =?utf-8?B?SUpxYURWVTk5Tm5qNy9JN1FBaVBoQlAzRHBIUndSRFl0eHBuVkFzMndEQnhs?=
 =?utf-8?B?cFkxeEpGaUhBUXhpd013VGNIN2U2ZFFpNk5peHE3ZDJJajlFT1lyMVl4VTYz?=
 =?utf-8?B?NUhhSGpqeU5PM3UvZjhteE1JNGlRUkZDcFNoaFJqc3JjTWZPMVdXdjQ2ZmVN?=
 =?utf-8?B?emRWM0lTM1RtMTFnUGZmMDlweXpJb0JIZ2U1ZjFkMHovc3NIbEtSV08ya0FE?=
 =?utf-8?B?WkwweDlvV25JZ0Eyb05hbkoyQ2Z1TDRscXV6V3lOTUtJa3JhVFp1eUtwSUpY?=
 =?utf-8?B?Y041UHF1S3RITTVwK3hwR3h2Vk10NFRRczFCVzFDWnZJaTFmNEhMb2tFa2xG?=
 =?utf-8?B?SEhmZ0JjUnRZZDJjVmdscTNKUG00UVUwUUM5eUlueVB3cDNwRlVrVGQzV0s0?=
 =?utf-8?B?Wkd1U21jOGxSRGMzdmN1WDU3TVh3MS8rNGIrYjhpZ3lJTVIzTXhNM2xtZ1dG?=
 =?utf-8?B?OUphUGM4WERaa0xBSWtYdTNUdk15dzFVTmtjUHhSdytiSDB1L2MrZ2RMVngx?=
 =?utf-8?B?WjNuWXBIN0Fvd0x1RHdyeEhaYU00ZFNUYnVMT3dTL1BSVnNnamRaZzNwY0Jw?=
 =?utf-8?B?YWRqOUxSenZ1WmF4VVVuQ3hxSVVpM0ZiOUQ1bm9JcW0yelh3WS9aVVFmc3Qw?=
 =?utf-8?B?MHBNMWY3OXlId2FzQnhZeWFqSWkvVU1ubE9XT2E5M290dDV2bEkyeHRPa3BE?=
 =?utf-8?B?eVgzMEhMYjRsTklGeFRxVFRKRDcyZ0RyeTNFM3pMSjgxMnBwR2J2OTZBVmdL?=
 =?utf-8?B?TzJlMTg5UDluVlBNYm5aenp3WnRIUjg1K2tiYkM3NUEwSWpoWFE5THRzcXVW?=
 =?utf-8?B?SGlaU2ZWR3pxOFFWTnlhT1FoT3NPZ2JROVJ2TTk1OSszTkgwdGtSNHp6ak9F?=
 =?utf-8?B?OHVrU3pBdUx5bmhDQ3hqMnNnZnZPRDRncUFMUzY2aHE0dUp4eDV3SUh1bkl1?=
 =?utf-8?B?TXgvalJwcEpOYWl0Z09TVFg3d3VjRVdvTDB0NUt1eG51SHY1RERuM29YNFlS?=
 =?utf-8?B?NDJrSldBKy9KUG1HdnByZ3FsU3grTGt1amxERjh4RGxGbXJTVWo0b1MrTW56?=
 =?utf-8?B?MjJqakNmM3huOTNzZm93WS9CVWlaUm1RNTNPYlBIVlVXdUc3K0c1Nk0wV2Ix?=
 =?utf-8?B?WC9heXY5MkY3S1l4TzF0MjBLMXduRW1VYitxNG4rNTl3bExpK0wvOE5ER01P?=
 =?utf-8?B?b0lhUDcyek1uWFUweE5mdkYrTS9GZVpCTERUVTkrVW9QK01malZ3RlNiM1c4?=
 =?utf-8?B?NzdDUnhBeXkvUGY0bDc3UE05NFJKSnBKL0g1b2dUTW1pa054TVpXS1FZbjJo?=
 =?utf-8?B?TEtYcklubkczcU8rSUVOK2VyRTgyUTg0R1Zmc0NVOFFzbmVYdDRnSlVUMTdr?=
 =?utf-8?B?WnphUGpyUFQxdnN6VHY1NDcweGM2WmhmRFQ2YTZzbWhrRGdTaXZQSE9LRWM1?=
 =?utf-8?B?Sm5wblpPdjVCSU9SNTdzTGdqNzQ4MGlWb2ZrSjI4TEd2dEpOWGU4ZkdzMjNq?=
 =?utf-8?Q?fO8f+6eEd7VFJ4Tf+i45jeo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXdXaWxieDBYSW5yQTBIbm1OSUF0a0F0U1VjUE1yZjdkT1F1YksyKzRFUS9O?=
 =?utf-8?B?eWVwcEt2TC9nTXpLMHI1bk5Wdk1oVFNGWjI0SFFvSFhVaytJSTI4VFV5czdw?=
 =?utf-8?B?ai82YWZJT2xLejRYOEpUZUd6emdCeTNMRGMwSzNVUTVxRDV4YWRGZUlGakhJ?=
 =?utf-8?B?b01xaFh1NXd2YzdHS2c5a2tVTCtJRkwwQmlxRjVxQVNwZHc0WUkvb3ArTlZq?=
 =?utf-8?B?MG8xMEt1anhpYlgxZG5UTUYvVmRtNXB4UHJ3c29LOEdJWWlRSjdHcWQ1SzZ5?=
 =?utf-8?B?TlJUZENISzJKbXNCNC9FdGlvKzB0OWJMUkI2TjljYXRVSlNSNm5uMU5ZMk1K?=
 =?utf-8?B?NzErU1JLd3V6UEZsS1RDMWhlL2Z0TTIzeGJJMHNFbmxEbmJIQkw4RDJZWXcx?=
 =?utf-8?B?dVpzMG9aSUs1eGtyNUVvMVA0RnhSc2lkRVdQV21EUUxUUjVkRVlZenUxTDF6?=
 =?utf-8?B?ZUZSY0VWM1pMOEhzSFJwYW5qeXRINzVINDJBTnZNUUd2WGg4eFA1MWtvZjJH?=
 =?utf-8?B?djVjRXkySy9LY3djK1cxcy95YXZ4S1JjeU1pMi9vdlBlSTJiM3VWQXM3bFBv?=
 =?utf-8?B?MkxTNm5SNDZzZHE3Y0lORjYrZ1pNTkg5T0I2TXN0bklsWC9hZUJaSktxU1ln?=
 =?utf-8?B?NjNXaS9qbFplaW56KzUzdHlTVVhLU2k2d0c1ZW5HNWh3b2RNay9PNnZ5MFRU?=
 =?utf-8?B?U1BUYjRHdzhtTkU1ekMzc3c4WnVFQzNCaXpEOXRLMnAyWTY3aGpISGZxVVFj?=
 =?utf-8?B?RGU2NmdoSU14bVBYdGVjeEQwVm5FSGRpSlZIYUEybytXNjZ2c2RmUGNsSlVw?=
 =?utf-8?B?NXFHbWsvcTYvSDk5LzJuUkdKd0ZHbjRRWVNQZ0JGWWRSaEJuMVFOb1h2Wjk3?=
 =?utf-8?B?WFhaWDNQUWd3VEdjQUNwWDRsK3N5UTJTQ3FjMU52UzMyUjNZSmxHN0hraksx?=
 =?utf-8?B?a2VNN3dubU8ydmRPdXV5TmxScVl5N3VjSWNXaDZpczMxU3FRM3VqOUNoLzBh?=
 =?utf-8?B?aGZpVk5ZaWMvTVhSUG9xN1YrU2FNVDdjT2k3MU92TU10MzladWZIOENycW1r?=
 =?utf-8?B?Lyt3aTNDdEl4VEFJbUIyS281QUpKZ0NlUFpDNStIcXpsbzRkdlk4NmVsOUx3?=
 =?utf-8?B?UDlvMmVKWkw5NU1xSlQ3Nnh5S3lsaExRVlowcHBGdGxIb3YwM29ZSGp0V1B6?=
 =?utf-8?B?SUZ5Sk9Xb0ZlUEdKcTFqSkhwZjNlWHZiT0c4VXZlVXBLV2VPRGdRNnVYNUNG?=
 =?utf-8?B?by9zVk81K0hrYWhNMVU4U0JXQklKLzZJSGFLeFVqL1M1cENmQWF4cHBVbmlu?=
 =?utf-8?B?MVd0THMwMTlGaDRSa29xQkk4dm9pbUQwdzN6cWFMcitUN2tGR2lyWTZKdlVW?=
 =?utf-8?B?emdVa3ozNkFITjVTcDkxZ0NPaGthV3V0K280VDQ5RkdwU3lJT3JDUEYyMXUx?=
 =?utf-8?B?eEZidDRlN2JaV3hDMXJsWDl1OXJBRXgvVEo5RmJheFREZStYemhKaEpYZXpw?=
 =?utf-8?B?R3N1UUUveHdqRlphL0poeHNtQ1MxYWFzalFieDYrMVN4anZBSVRGRTJ5YUM5?=
 =?utf-8?B?bHIxbkJmVnErd0dEaW9lUERxTVduSU1KS1NYelZteDA5WThMYW9EU3phVzFX?=
 =?utf-8?B?QTA4SGM0QTFLSCtPWFpjazQyREJHRzBsNno4ZXd0RTcveWE4Tm9ISk9JSTJJ?=
 =?utf-8?B?U3doRm5kd2E2TXRNMFpPR2xvRG9XN3A0OUtFRkE0QjBKU1duTzBreWxqVUNL?=
 =?utf-8?B?ZkZoTkZLVUNnZnlJckExR01BM1NDNXBwZ0ZZRndTVm81TjRrR1IrM2JxTlFJ?=
 =?utf-8?B?YUNMeDAzb1hSQ21scDhKWWpBc2xpeDQzWDgzTFNBN0U1c09KR3RkRXZ3dk1t?=
 =?utf-8?B?d01BNHhkM0orTXU4NEFSRFZSSFpLNGhZVW8veUhuR2RKUmtFaktvOTlIdnNH?=
 =?utf-8?B?Y1lHcTFGd2c0SnVFcnh0Y3g0R21xVVJRZ2V0UXl5bVVlbXFwZ29DdlowNHN6?=
 =?utf-8?B?bXBocEVCMFprM2tmTVU3NmNkeXpPZUhka001MmwrOWRNamphdzIxMFpmU1hw?=
 =?utf-8?B?M01kcmVKZWZWQXdXUnpoMW9MYmpNY1UzbzBVMFVlQzJmZWtJWTlmQVNyN2ti?=
 =?utf-8?B?QTdCTHBuMW1qSEZqSVpINHhQU1gvS0dxb1FZc2JONndMblpVMmVXMWZ5NTJY?=
 =?utf-8?B?U3JvRlFyWkQwZGlPKyt6WDZtSVJYam5rZzI2TzhCR1RBOUNYR0lmQm1iK0sr?=
 =?utf-8?B?d1g1OFdQYXNEdm1YbWxXN3VZQ0o1cWIvelFmYW1OWUZ0QVR0OU9reDh5aG55?=
 =?utf-8?B?a3NCNHBxd01LdkZ5T0t0MGk3OWFJbm5pR3kxRDBTOGJOdmpybEdiNlR5TWdi?=
 =?utf-8?Q?ZHAUaofdfEO/kdvZiad0k00YnBro3C46/JhAXAnddcH67?=
x-ms-exchange-antispam-messagedata-1: TNitQrGuvPK1VbkE5BcDQTUj8+9VVRUrJjc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E470F2DA759E64C8EC271C27C6E1DBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZQGjproWzNDy/Y5IPV6WldGGUIDY6yXPGtGon4my8WdgVS8PDmaIjzc+NPXrOvEFjVQan2iR47x1mzV1aZaJa86RFIKFRzSiu1cWV/4jTToimAtwBioYlOFzRBWhonLMRaKp7RYv+fy4hmc3CZCBF0EBY85TqRjVltyDMqPPtyuJ9dZdN1u5EtxjJ7c2jXQrVOmSUtcM7fcj8KstFoGkmpK0VIRWS3CTa/CdUshq1nwitzb0JK9Yf9MiuBoags680MvfWaJZLLb8wCOSUjgqGcNpDANcgQPvh27gRXmtNluB9f0nv7lw2YphOrufNwT80V15u5wdW0UoR/l4BQ9NDql7Z/cGbcfPSugYFkOVKpsdCeo7VuW5kTAwdEPekNBeLYK5vBuOmA5WjWzPUxZ4GhQv7mPlif7/Q7wlnddMw3CllZge8Iaeda9guwHWJ6vGuL+QQYvX8IXpvwDDc+ZKjceTaLGAx4l1rBKFPeA6EzWrFV4X0OiqOtRocdfF4FJp3S4GWSD2wiT9+kjnC7xCNyXV6H3Vsv0xg3tiFVSUmZNBNYdnXPsHHq2bit/IWrtaLxBsIExBiuXRKESjBQzI1G46+/c9zQ0ZyofMcV+RKwr93lRbtoRjBLhz3mh7Ny6u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ad5ad-4766-48cd-c475-08de536bb343
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 12:51:56.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eN08Qq2OgQMx5atplJBgdSwPIcdgPPocqsJ/SJmOfBelkqkB4ZlYqVWIjZnGekKlhA5jgv28Kz7oDN5Kmt8PKcL0m4sI/y9C/Q9sjP3Zxr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8371

T24gMS8xNC8yNiA4OjQzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gKyAqIGJpb19p
b3ZfYm91bmNlX25yX3ZlY3MgLSBjYWxjdWxhdGUgbnVtYmVyIG9mIGJ2ZWNzIGZvciBhIGJvdW5l
IGJpbw0KDQpzL2JvdW5lL2JvdW5jZS8NCg0K

