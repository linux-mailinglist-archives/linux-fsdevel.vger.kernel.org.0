Return-Path: <linux-fsdevel+bounces-77029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIMPNAcDjmlf+gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:42:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47012F8B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F03303322E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D835D5E9;
	Thu, 12 Feb 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CaRcOTEx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZFeJVR+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473182E8DE5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914564; cv=fail; b=ErATuGnvtJqgpQu5qE86ZVwKb51tzlfnL1N2XuWDcbKI+pIVY1uqpOvuYKowLKWTQMdokwc3+i1oasa3d91HF15SQkY2lsUGJBoDOXL+HT17pGc1rxvnV5GCRFNEcPSsPs8E83DY3WH4YU5yOK4rekzNinZFiaCEqRwYYEiGn/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914564; c=relaxed/simple;
	bh=CRIXvpPR2VVYB8rds4dTZRITfysaNAMiYWSs3QfDYag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeIeNLQ9VX0leme6d78WAqpfF3+Duojv7vSgYERjmel1a/0AG1j2NO4YczWmf8ldtwyyAbLtQO5oUVcmn9av9+ycZaTYi/YwaKgj7ogYCosbPYphViNx3LWBdNEMZFmGGuIYNFx2pqIisv97u+4P8UoKMyxssCSCpjiJjpLZKs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CaRcOTEx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZFeJVR+H; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770914563; x=1802450563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CRIXvpPR2VVYB8rds4dTZRITfysaNAMiYWSs3QfDYag=;
  b=CaRcOTExKjIUdorq7pQW72BCNuf9UzhA7dYz2XUlxJpCPk9ynhPq7f11
   mSMjLI19RWOtG91pb8BXUftp77coA08rndttXpqZlAcWFjr7O9nl6euey
   i92X9gH/FUIykNG2UWZ9irHSLv8H9QxME3J8oiS3hhhVF+wvho+HDjSKi
   PbXVBsirAsx3+zLniBNZHoQJLlS+eVEff8U4jPiJCMsQpiVZeRS7AiXNd
   c5mEth93RF8xbzB+Zm1fOWciqOLoRHTihgoKZQ4d+6lTjC1cw6GH8VTSU
   x2tygdpTIyzLO1NRIVXLsypWfRv9MlOs0BOza2I0W0XxYJgWtZVRX026c
   Q==;
X-CSE-ConnectionGUID: 36Mqj5VOQPOphHKi0wzzkw==
X-CSE-MsgGUID: p3ZD0LGbQieHOLQpeBYTPg==
X-IronPort-AV: E=Sophos;i="6.21,287,1763395200"; 
   d="scan'208";a="139755617"
Received: from mail-northcentralusazon11010022.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.22])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2026 00:42:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvsrp/VWZruZN58sLEb1v5MiLj9ayJy+FBho8/NMt+DMcMBRaJGX9ExR41sWPPb2g4dXvWOZfGR1SnZcoiubHDoqeAiL+4hTrHg105vjdAemo5xzjsLIIKcuuYQ6WdJoxn4OcLoOVZ3y2WZyKF5+DrZaYuisrYTxEjaBROEC2TOFKVOAX3kUwCo40B5rlk1TJUN4HhypF80AIrMy/+gmT+D0nHKpqfxlA9HtBC6m9oNt7pApLWF8QjETXyCw7Qz3W03doUFALxlIr8QJPYaEUUYBr80hAAk/MK1z0/DxZ5y6ye87fCyE/HuO0Co858V73/9hgo/FMpMOf3N3xlWTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRIXvpPR2VVYB8rds4dTZRITfysaNAMiYWSs3QfDYag=;
 b=R21PbELFojCrrjpYDHE/tt/On6h3tiYEa8BMaAOcONbkBx6kW272OiDL9Tcs/NcwZwpbv6jIFdTIrY3v0UUbH0m+s/82URrnlOJb2r+u+nvs4x9nFTQvgr33tNDKDJh3+14XTeczy357ozi8nmZ0iB39RGGiABRjPeUtUVFwp23V8fkd/8b0w78SLxarNJ+vHfC684aM4UAdE3VL3rK2eZ7FBPTKEY3y4FmUiigV1P5xMVuY2w5vvySV3jaM6LLjgw2dfYTE9vzNNUijb/QQokkaGBmzFsqMCrvaknjCSSoDKey44j/wcXqDMoh7FXSKDwDwilw9xbAJaqEX3M5EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRIXvpPR2VVYB8rds4dTZRITfysaNAMiYWSs3QfDYag=;
 b=ZFeJVR+HCDZoKrQ9v5bbKSYE69CuW7WacK0wQ59p8HnbzHLNccDU6ckAsEeNualPTy8kit+ngpqTEIythMla9TYNgQhhFZ7M1j2wQYKPOBu3dMWnpzDoc6ItxjbfZ5hzOhAnAohrj2yFDpLjj5jHaEe4/vVmzbfIbJpp3ZR2Lwc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA0PR04MB7449.namprd04.prod.outlook.com (2603:10b6:806:e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 16:42:36 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Thu, 12 Feb 2026
 16:42:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Hans Holmberg <Hans.Holmberg@wdc.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jack@suse.com" <jack@suse.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Topic: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Index: AQHcnCVy0zbMvpaPJEe12Y5TD3XDD7V/ROOA
Date: Thu, 12 Feb 2026 16:42:35 +0000
Message-ID: <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
In-Reply-To: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA0PR04MB7449:EE_
x-ms-office365-filtering-correlation-id: a1a5853d-e1bc-4e8d-3979-08de6a55b9fb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnp0M1dlVlF4bW91WTErQVJRSzJpcEpVQWZraEV6ZmhKMEtGdG96bTMyOVpB?=
 =?utf-8?B?RDZDVWdjMUovUjBLMUozU2ZMd0RRWEtTWjZEdFYyRGd2L2JsaWJiZHBKZWZp?=
 =?utf-8?B?cGNzQVpybXZHMUc3ZzVlblBVUnVOK2FaMkFEem1ZVnZjbHppaVNJRnkxMVdJ?=
 =?utf-8?B?dVQzeElrMnIyY3ptZ2tiL1F4aXpKTnBiZ1ZXd3k4QnVYdDZGTVA4ckJLc29T?=
 =?utf-8?B?QWtQdUlRelI0ZFlCdW1yakJzZVk5UnlxQjZpSkRjR0NLNnc3bC9yWFlDUDRr?=
 =?utf-8?B?L09ETlpta21PY29LOEJTQ2lqcGM5aTE5S0RVNHNzZ01rbFVXSWN2bGhqQUxy?=
 =?utf-8?B?UHpDT1UxcElmS3VaZ2RjTGlBT1NUT1pGQ29SNW9Jend1NkhRRGlnNmVQcmVE?=
 =?utf-8?B?RTNNNGRYRkh2enFEcWxpelU4aWp0VU40eEtSVFdndWd4bytyT2Y3ZmRQZU5q?=
 =?utf-8?B?TWZxb2hYOXVWdWVzaC9rYUZrQ3pIaCtOdUFQM0JoMEZGbEVRbGp2QkQ1d0Uz?=
 =?utf-8?B?N0NOZThBZmduYUlMK3JkWVNQclVSOHVaQ203VmJlaCtVdXpRSVk5aURaaHJP?=
 =?utf-8?B?bnBjaWJOQTZ3T0c0bGFjVlVsOXBqVytYeDFRRjF2SDV1Ni9JbmJuTjEvSXlz?=
 =?utf-8?B?MGt1RG5VTUwvVmVnTjVSZE1FcjI5NGVNR0M4eWVVNG5KQTRyZ0xxcVN0Ukk0?=
 =?utf-8?B?eGNYL3pCVHZEWFZHTVh5OTVhZ2d4TzFqWXdVSjhnb1ZaUzJHWmFnZzhZUUhm?=
 =?utf-8?B?THBET3NEcUFrczZCK3kwUjVlL3FXWmdFQ21yenJiRlRJOWRnOHRWTElxQ0pV?=
 =?utf-8?B?OUErTWppS0FKakRXbVNKYXBFM1h3a0J4K2VyUnJ0cmdOY29MSG1qM3l2Q3BK?=
 =?utf-8?B?S0JlakU3Y05jZjNkUkZjNU1oTDlWYTI1VExqNjlvVWJzcERieDlURXJYdkF2?=
 =?utf-8?B?ZEQxMlVveC9nM1htYlhscDBxZXFIQysydTMxT3BUc1NnWURpdWN0TWZlNlQ2?=
 =?utf-8?B?NmpVMjJTZHlyM0s3S2dzeVl1VFdHKzc2RVFVS29TNVYyVG5DcVRUaTM1ZDd4?=
 =?utf-8?B?Ky9NMzNFMXJqT0R3T0UxNHFWc0xwUWgxdmt4VVltWXdoYjRqRHZNeVJzK1RJ?=
 =?utf-8?B?ZXkybGJFY1d6dFdIV1lkeTRKZ2V1UUFPSXRLazFKSjFRTm1xbmRxQjRHYm9h?=
 =?utf-8?B?KzZGcnViaUNIdzB6a2kzekV5TnROVUxLUFU3S3VoaVVTRTBKQ2R4VlpZYzlj?=
 =?utf-8?B?NEcwdjdoUGtycDd3cVlZdk9xemlER2lIOXFST2lQMEE4QzRicmpGSFZGUDVE?=
 =?utf-8?B?SlBWVGFNenhYZVE1V2RtZTE0eE9UaU1FTEtwK1FKVjBwNnZqTCtzZkdTcWQ0?=
 =?utf-8?B?Tlh3NXowaGROaXZKS2pkaytMcUJjdkRpUXV5S1pLR0llMmRsODRHNlFnRzRT?=
 =?utf-8?B?UVE5bXlvY2Y2S0lEOTlJNzA0N0ZDTHpRR2V6NHFPbm4vRENuRVBqeW9zQ1VK?=
 =?utf-8?B?bE42M0VLSjB0a1phWERFanRiWVVOYjVvSGgyQThMbS8ySkQ0bkdoRnJPdnM4?=
 =?utf-8?B?aDE1RjZmRjYzWTduOWdQVmo4MytUNXdDL0ZSNzIvejJGNC9DaDdlWW11ZGdY?=
 =?utf-8?B?VU5TMS9sSzM2TG5JQyt3VWpjQm5ZWmNDMUhuQzZSbHRCVThiMUtMekxvL0Z0?=
 =?utf-8?B?N3d4aXh0Nm9tQ24xbzZkRDZmem1EaThCTTdpK1BmeUE4Uy91OENmSjNWdGJR?=
 =?utf-8?B?WUgxR2pXajkxdGJVZ2FaRTl4eGUxbUphMEtSMlVUaHViMkljQnhwbS9jaFFJ?=
 =?utf-8?B?L3VIS3NaT0dBL3MxNmp0ZXF4OGM1N1JQL2pXTU9pSUM1NGV1S0l0cFVtVENt?=
 =?utf-8?B?OFV6K3Y0bXVZM083RENiRlpkT1N0SThYdG1SeG9yNGc5czFZanloMHd1OFFC?=
 =?utf-8?B?NmNsR3QrZUlCdWM0bzhVbUxQeUV1a0ZDMEdHN1oyTGJwY29ZTTlid01pd3FK?=
 =?utf-8?B?RHMzcTZRVC8wS3hrSnlPYTlGNlRHcDRFWGEwUTlSckJCa055dlIzQkNoWm9X?=
 =?utf-8?B?Vy9kSHh2aEdEM0tDQW9LOHN6QW01Mm1yck5UaHJMSjBQeG56REs0ODRWRzdv?=
 =?utf-8?B?V2prUE01SVdZMk1Ed2pSVDh0ZEhvVGtWVFlHeEhSdlpjNjBMcENtNXVFbktq?=
 =?utf-8?Q?bgqXJ2W8yGGAg6/tR2e/Mok=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0JHaVhJRkRoMGxLZ213OXl5RUNvV2VkOEdrRmQ4S3JCZDFwOXRyWCtqRCtr?=
 =?utf-8?B?SGlEdVpkMm8rQnpHTTl0RkxUZzlnRDB1TUxxZW9jdk51TUZSNEROZHhGWE5Q?=
 =?utf-8?B?YXBYUnBPZzQ5RUYzWkJQSW5ZVHIzNCt6Qm5aYUZaRXRXYjBaYmxrZFFVSXdE?=
 =?utf-8?B?dHF2U2g3TVZtMDRSQnpJVHVhQ053WWNJdkJ2NWR0ek9PbUUwZUFSSFZoQURG?=
 =?utf-8?B?WGVyc2VQNDhLZWphZ0RvMkU2RG9YN2pWTldwRjBzNmgvcjJ3WTIyMEtkU2J5?=
 =?utf-8?B?RzlId3I4WTBsdS9zTGhnTXA5ZHlkT1BYZHEyN2hkdER4NHBvM1R1Sm1YWkk0?=
 =?utf-8?B?cXdvblZOT1V6Mnpzb3NPQVFGVGoyOG12WnVkdXhJWnBUUitrWjhnR2RPOVcv?=
 =?utf-8?B?S1dOQ0RJaEgydlZ1QkNxTzdVNjBaME9lZ29TeUV0NGhhKzRmalpZMmlhUWNz?=
 =?utf-8?B?WEhRSm1LU0p6SG00aHNoK09teGhVTE5ZWGJFTm1lV1JRMU15QStOckZKUUpG?=
 =?utf-8?B?KytPb0UyTHVTekNMVUR6N0RUQ3R4c3VtT1hhUXVRUXBqWTZ1STJxUzFpUzY1?=
 =?utf-8?B?UGhKYUJBUkZzZVZtV0pybUJkVTFINk5SS01rN0lOUlU5bnN6em4xZHk1SkM1?=
 =?utf-8?B?dDZqckl6VFpGQnc3dWtycS9DWkdIazh0d2hhRkhBeEJ1RW12azBPbi9wRHhK?=
 =?utf-8?B?b0dCTmx0S24zbURXZjBqdXdOeERBYnFjekhXMmFlS3lmeExBTzRjcy9ZYVdZ?=
 =?utf-8?B?eWNtMjFIMElqWDBJWXFxVDVFUEdXNXZMOFdwdm5XOGZoNU9xS1d2VytjK0h2?=
 =?utf-8?B?cVJUTTBqTVQzdHMzYitTRmJmbS9GdzNsN0JESEZoOGJwU3I2OCtyb3FVa293?=
 =?utf-8?B?SDNnOWhZM3RwblNWaVp0UDZZcWhrakVDczZQRWp0Zi9YVE05TWhmc05xaTZo?=
 =?utf-8?B?ZEUyQUxvWTJFVkZRcGgwWDNRSlFyY1A1ZjhKQlF6K21kODRYMmtQOU9EWWxG?=
 =?utf-8?B?MUVZbklkOE4xdDVlZE9nVW0zdVkzWUdFSElicGxGUWNzU3NwdlFRWmVrNUxK?=
 =?utf-8?B?clR0MWtBbWt3QlFTdlRsaFNSbGhZZWhQamZoSDcxQW5aQnp5SUQ1clAvcXR3?=
 =?utf-8?B?NTdVb1JibzZRR09uTmdlV1IwcmN0VU85SFdYMnFtcWVvc1pUQzNGQlZyNzl0?=
 =?utf-8?B?dENDamxyWFhzVnpTQWFxeXJRN3FGdFJxTkUrWFI2Q0hqMGtCMDIrMnhuWXRh?=
 =?utf-8?B?aTBxcnFnbG1TWGVEMW53SFBSUEkyKzkwRWMrenEvV050SUU1cjlMU3VnVVkz?=
 =?utf-8?B?M0trNmJRS3lOT1c5V3Nza295dStlYi9EbnFvWU5LMWlpVnBmYTdpVWIvWFBX?=
 =?utf-8?B?UWNkVm9tY3BveUp5R1NzbExBZS9sZlZ2ZlpDQzU5MzlWaFhoVDRGRGVxWEZZ?=
 =?utf-8?B?WUQvUWtCVWFxSWEwdFlqQWFRMERMOGJUTUlBNUdkZnkvT1JLUW1OeDZvWVpn?=
 =?utf-8?B?UXFFaTE5eGNVdjVUYXBTanZ0Z3RSM3VPMjl4S1dBTHJyOHN1TldWQW0xN2Zy?=
 =?utf-8?B?aEppUFQzd0Ixd214cFl3dkk3d2twdGhsK0trN1pJWnk5RWowVDJPTHIwdzJG?=
 =?utf-8?B?Z3RYM3ZaY1F0SlBSc1NzWFdLQWxEM0NxcU16aEpXY1I2VlJRMmowdnFRSEd6?=
 =?utf-8?B?cSthMmRwRFEzV1RUalVqMnVXOHcrQ2g1NC9ibENjZDlkTmJYblJSWENwR0ta?=
 =?utf-8?B?TWgvQ2dpS2h2aEwzSXFyYnJVZmp6UXBGZyt5dDNWOTN3b2VIdVk1dTRscS9I?=
 =?utf-8?B?MHJQa1krY1kvUW9QNXF0N3plQmJDQzdKWHpZL2lla3BXeURUckQxWjRHVzBR?=
 =?utf-8?B?ZFhJR0JISU5tUEZEMFh0bFhpRFR0Z1Q0Ti85anJFcHF5THVxUlVxeGE2OXpn?=
 =?utf-8?B?OTZraGFaUXcwRVplSzA1TjY4MCtZOGx4aGRva2RZTndEQk1pQU8vWHJ4NUFY?=
 =?utf-8?B?NVMydGhJZm9HRVcwTXNIWnRhMG9XS3dCUTh4WVNhbHhuZzBtbVdna3RmUm5G?=
 =?utf-8?B?bisrU0w3TnRnWFdmRytqcXl0ZXFaK0dHZFZza2FKVjU4OHRVNTN4N2E4RlZr?=
 =?utf-8?B?R0NyZDZiT0FNdDIzOSsvUWQ4Mnp0eEU1QXFjSWRsSGl1YXdBaTRQL2Y5S3h1?=
 =?utf-8?B?SEkzdElOSkpod1dReFdwc3Q5eEljRFdhTzBwM29LTk1TN3dsN1hpd3V0M1Q2?=
 =?utf-8?B?K1ViY2VqSFNTZkJDN3VvQlFDTFZldXp4UE5vcGN4TFhEUDlDckM5bGtjMzdw?=
 =?utf-8?B?UEVqQTBuaEpDeksvQ2ZPdm1jaXJmQXZVSDhVZU55b2V5eHFlVHpkeU5USUJN?=
 =?utf-8?Q?TemXSDcXDhlyB+5t7T+KaTknbMPWIbXVKLuGh6j3qc093?=
x-ms-exchange-antispam-messagedata-1: hk7Icp57Gi2t4lmUUiqWoMxdkMV7xVoMagg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FA0556FBC191C49B221C9CAC0B90709@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x34Sdu2QBYBJ7VR1LYVCQ8mNUh203Azy66GGJ8TmSHkrp0StphmXg0gOltpLOG2QVcL5K3Jd++tjgA6NL0wXZr/RtfflCI11ySCW9LZ2ikBLANLDekCLg85GxgOiH6U36jmZQfUFGmNGrwY4nVor00/yNE8lnQIOgllSFW9UB2YmE+X0shDwm1iP/HpvAMsCDD6/hQiTdN2n1foDYBfgNQbDppcJjjKzgbgjTjlpJ9yvkDDtUG2/KE95rw0lmYG9FdlSY/b89ucHlZbk0qxFF0KaoLPbX813/JPDSfG/Y1LOADXTFG7G5AJj10LVJ4EVysPaxvxnDzLrbjxQXJsPNIRKm8agHMwj04sfUZSNOxW5dPT6U4z1mq+tI8Mqr82u8mfFEZ1FhdOOdSEcrkU+8/lcchK89RN/m3OuIQf/u95tZKB8lJB6tk/TcywMU1KxJy53CG2rsEaFbSVWoA82CO7t4pM6xP2js+b1hOKDPttn9VdABc3HdBQ0a4T652MFQZe2C846suXOVX61BgidQTtgdEQ0emYS3KPN4w72qNKrYntBX0NjyCKCKjkz3nOIgBokg2o2abbqubHxPwc0gec3hPoKh5m9QNlhJvRD1M7ZPX04+cQaeeNp02con/jV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a5853d-e1bc-4e8d-3979-08de6a55b9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 16:42:35.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvQDP5SrValoGboXaRKXZyMkqnWV3BqTXgg/eX/sXLNNhtMysLy9zBuM6jXlubDc0GQ97YJNswoxyZ8p0lYWE/Ycys/sPGersszeDoPfabo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7449
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77029-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
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
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 3E47012F8B1
X-Rspamd-Action: no action

T24gMi8xMi8yNiAyOjQyIFBNLCBIYW5zIEhvbG1iZXJnIHdyb3RlOg0KPiBIaSBhbGwsDQo+DQo+
IEknZCBsaWtlIHRvIHByb3Bvc2UgYSB0b3BpYyBvbiBmaWxlIHN5c3RlbSBiZW5jaG1hcmtpbmc6
DQo+DQo+IENhbiB3ZSBlc3RhYmxpc2ggYSBjb21tb24gcHJvamVjdChsaWtlIHhmc3Rlc3RzLCBi
bGt0ZXN0cykgZm9yDQo+IG1lYXN1cmluZyBmaWxlIHN5c3RlbSBwZXJmb3JtYW5jZT8gVGhlIGlk
ZWEgaXMgdG8gc2hhcmUgYSBjb21tb24gYmFzZQ0KPiBjb250YWluaW5nIHBlZXItcmV2aWV3ZWQg
d29ya2xvYWRzIGFuZCBzY3JpcHRzIHRvIHJ1biB0aGVzZSwgY29sbGVjdCBhbmQNCj4gc3RvcmUg
cmVzdWx0cy4NCj4NCj4gQmVuY2htYXJraW5nIGlzIGhhcmQgaGFyZCBoYXJkLCBsZXQncyBzaGFy
ZSB0aGUgYnVyZGVuIQ0KDQpEZWZpbml0ZWx5IEknbSBhbGwgaW4hDQoNCj4gQSBzaGFyZWQgcHJv
amVjdCB3b3VsZCByZW1vdmUgdGhlIG5lZWQgZm9yIGV2ZXJ5b25lIHRvIGNvb2sgdXAgdGhlaXIN
Cj4gb3duIGZyYW1ld29ya3MgYW5kIGhlbHAgZGVmaW5lIGEgc2V0IG9mIHdvcmtsb2FkcyB0aGF0
IHRoZSBjb21tdW5pdHkNCj4gY2FyZXMgYWJvdXQuDQo+DQo+IE15c2VsZiwgSSB3YW50IHRvIGVu
c3VyZSB0aGF0IGFueSBvcHRpbWl6YXRpb25zIEkgd29yayBvbjoNCj4NCj4gMSkgRG8gbm90IGlu
dHJvZHVjZSByZWdyZXNzaW9ucyBpbiBwZXJmb3JtYW5jZSBlbHNld2hlcmUgYmVmb3JlIEkNCj4g
ICAgIHN1Ym1pdCBwYXRjaGVzDQo+IDIpIENhbiBiZSByZWxpYWJseSByZXByb2R1Y2VkLCB2ZXJp
ZmllZCwgYW5kIHJlZ3Jlc3Npb27igJF0ZXN0ZWQgYnkgdGhlDQo+ICAgICBjb21tdW5pdHkNCj4N
Cj4gVGhlIGZvY3VzLCBJIHRoaW5rLCB3b3VsZCBmaXJzdCBiZSBvbiBzeW50aGV0aWMgd29ya2xv
YWRzIChlLmcuIGZpbykNCj4gYnV0IGl0IGNvdWxkIGV4cGFuZGVkIHRvIHJ1bm5pbmcgYXBwbGlj
YXRpb24gYW5kIGRhdGFiYXNlIHdvcmtsb2Fkcw0KPiAoZS5nLiBSb2Nrc0RCKS4NCj4NCj4gVGhl
IGZzcGVyZlsxXSBwcm9qZWN0IGlzIGEgcHl0aG9uLWJhc2VkIGltcGxlbWVudGF0aW9uIGZvciBm
aWxlIHN5c3RlbQ0KPiBiZW5jaG1hcmtpbmcgdGhhdCB3ZSBjYW4gdXNlIGFzIGEgYmFzZSBmb3Ig
dGhlIGRpc2N1c3Npb24uDQo+IFRoZXJlIGFyZSBwcm9iYWJseSBvdGhlcnMgb3V0IHRoZXJlIGFz
IHdlbGwuDQo+DQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vam9zZWZiYWNpay9mc3BlcmYNCg0K
SSB3YXMgYWJvdXQgdG8gbWVudGlvbiBKb3NlZidzIGZzcGVyZiBwcm9qZWN0LiBXZSBhbHNvIHVz
ZWQgdG8gaGF2ZSBzb21lIA0Kc29ydCBvZiBhIGRhc2hib2FyZCBmb3IgZnNwZXJmIHJlc3VsdHMg
Zm9yIEJUUkZTLCBidXQgdGhhdCB2YW5pc2hlZCANCnRvZ2V0aGVyIHdpdGggSm9zZWYuDQoNCkEg
Y29tbW9uIGRhc2hib2FyZCB3aXRoIHBlciB3b3JrbG9hZCBzdGF0aXN0aWNzIGZvciBkaWZmZXJl
bnQgDQpmaWxlc3lzdGVtcyB3b3VsZCBiZSBhIGdyZWF0IHRoaW5nIHRvIGhhdmUsIGJ1dCBmb3Ig
dGhhdCB0byB3b3JrLCB3ZSdkIA0KbmVlZCBkaWZmZXJlbnQgaGFyZHdhcmUgYW5kIHByb2JhYmx5
IHRoZSB2ZW5kb3JzIG9mIHNhaWQgaGFyZHdhcmUgdG8gYnV5IA0KaW4gaW50byBpdC4NCg0KRm9y
IGRldmVsb3BlcnMgaXQgd291bGQgYmUgYSBiZW5lZml0IHRvIHNlZSBldmVudHVhbCByZWdyZXNz
aW9ucyBhbmQgDQpvdmVyYWxsIHdlYWsgcG9pbnRzLCBmb3IgdXNlcnMgaXQgd291bGQgYmUgYSBu
aWNlIHRvb2wgdG8gc2VlIHdoYXQgRlMgdG8gDQpwaWNrIGZvciB3aGF0IHdvcmtsb2FkLg0KDQpC
VVQgc29tZW9uZSBoYXMgdG8gZG8gdGhlIGpvYiBzZXR0aW5nIGV2ZXJ5dGhpbmcgdXAgYW5kIG1h
aW50YWluaW5nIGl0Lg0KDQoNCkJ5dGUsDQoNCiDCoCDCoCBKb2hhbm5lcw0KDQo=

