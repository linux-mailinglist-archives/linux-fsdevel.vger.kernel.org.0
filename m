Return-Path: <linux-fsdevel+bounces-77138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGNjHhQQj2mCHgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:50:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70D135D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CFA23055DD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288B3590C7;
	Fri, 13 Feb 2026 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gTWpIndo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yu+69eEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285731986F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983439; cv=fail; b=AnHiGjT7fYv9VhSbX5/ShSkmvBQOp+U4kPoB/Um27FgeTpQADMkn64FX8tc8R1FPjJ3+edx3FTmwVisHN86mSDPcIR+s0t6oIFo2/cUyUVD/0AlrsMTsw9HOCO7dxyGiEM4uqednjMKRWTO7YpplZEXTCkjwMfyloB6JdP2J/dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983439; c=relaxed/simple;
	bh=3PJJt7CrcuiU9qz7FgLEZhPdIOdyeK/jhPq5CQw9nkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BAAiHJMOb+pTzM+q9tqs0UcuICqL1rwa5Oi+0BWZIaW6KiK6aykNDGGaWwpvNAIeSXGyq/rjlo1fYgRNfw0quPixRWihJoQnGZdHt1Jp13YG5ZMnxvNZGuD6WbMGAWbCDIHe718KloSu5R6D4EqssEAO2OLNojq5SKjs24TY248=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gTWpIndo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yu+69eEB; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770983438; x=1802519438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3PJJt7CrcuiU9qz7FgLEZhPdIOdyeK/jhPq5CQw9nkU=;
  b=gTWpIndoeYjxLcG20MiQJVg+Ott/Fyyxk39dVGCFMGSiboiBKExiSjKY
   CDezAFPvcHix/PydRoJVtCaZTVDiOyHIH9Yf4HrcQ2x0oPAluuEC217+9
   pBnmV2JIK18fvCJRKBdNcRM5PoE7iSy7R8oVJpV0muON+VXPXNmF9kGyw
   MYC3RLXU6QIU2G/CZR0p6WBWvD/NMcTukvhLFxDyUZf/jpJnzExSKbk2c
   lFt7KxZnRyZtDDb6h+TG0ObxY6W3KZu6sIaoZBJ74qpMEEGIKMK8GjKYP
   MCJhy3PnlO7jKhO88omMN9MT+CylsxUrlKk1xyo+yFiwIWX704fY01XNv
   A==;
X-CSE-ConnectionGUID: 0gWcBS4URMK/GKzr1r9+pA==
X-CSE-MsgGUID: ork5kf+7SCqUjS/l4VDTnQ==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="141282137"
Received: from mail-eastusazon11011032.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2026 19:50:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fb4KKO71MH7fZUFxV7XN54arjnguNmWB99DV/oYrl2lM8HjoygivkwPWdMZVU0rWB7v4S5Bd6O3ghZar6s5i7tA0SwF+HmedcsXHMa5QZXq9aX5z34C1UjGdpKdPZ1yepkOaDUaSlpj/zU8/tW8atnTra+GUm3z6GQ5m8BtRH3GomP5sJ1vyxbHqMZ8GsuwsmhQ01RMoTG0+hqExkTSWAou28y+UHGjUwIujO+DDztObF71puKF71VcA2b5cqo21IPKuRWKVrWa3/4MV+XCVxt6tQR6xlPtpvicy/+dmTy5zxtvqHxZvel0cG1KnetQeYROYlvpvUaEY7TJbhAiAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PJJt7CrcuiU9qz7FgLEZhPdIOdyeK/jhPq5CQw9nkU=;
 b=RYlIzL26SIdiCg4KFDWs/q9gMwAlkrJEcbiWLapfddw8GcUbLwHY7UXdcnbEnlSd/F8IjFvdeRRDvEAT2wq3LRxVrPM9ekATst5NvfOHgBgORMCeXtGAQ/Y9TQWgBqUK+kD4mrvL163nN1og8EKo/XEkQEXbZ+cOc7efotRv+yODz+jQnaCXTITgudxZIyvgL2Wwc3GCXsw0seDPSksVZGWbLt5Mjwy8yIfZLuxN76xgReladSwCsd/mq154+UuxUthzHUtSnSDV9hJC6s+ssigCBomGtODaHYiVn4NCXqQxg339eBjCz52K0fEoyKwPQXTI+zeV2Oi2BL3orDuO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PJJt7CrcuiU9qz7FgLEZhPdIOdyeK/jhPq5CQw9nkU=;
 b=yu+69eEBiAbYDi83rCHHIOFnPMkdHkNdBgHKcCsWeP0EFesRoe4+6dapocaudlQdawsGR7NMjuDatD9tm3P9mPdgNL7NKXe+HEIFNMdTdlhUEJpz3hG3DZCsrwQkPxuLWgXv/ZSGROJWe7g6koVS8w3lt7wQd+LhJbxoNqkZI4I=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH8PR04MB8710.namprd04.prod.outlook.com (2603:10b6:510:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 11:50:26 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 11:50:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Hans Holmberg <Hans.Holmberg@wdc.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch
	<hch@lst.de>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Topic: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Index: AQHcnCVy0zbMvpaPJEe12Y5TD3XDD7V/IEuAgAFlS4A=
Date: Fri, 13 Feb 2026 11:50:26 +0000
Message-ID: <aY8OKCkO7oVFodp0@shinmob>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <395d1665-f5f4-4484-8d68-bad00d545220@flourine.local>
In-Reply-To: <395d1665-f5f4-4484-8d68-bad00d545220@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH8PR04MB8710:EE_
x-ms-office365-filtering-correlation-id: 80353c4b-5660-4f94-5ced-08de6af6142a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVVWeUIrSzlIVUJHVGhjN3daV2prSDNXck9PZXBOK3JEYnVzdTVUT0QwYjAy?=
 =?utf-8?B?OU9Bd2I5dlJITmpvVU1vT09YTDNsb2t6bDA4Wks5VlJEdHR5RDkvVzlnZUlJ?=
 =?utf-8?B?QkY1UVlYNzlUQzlxYVFkc09sMkxScXdlb092Kythcy91czUycTVBU2RWdUNa?=
 =?utf-8?B?R0V4bzd3NkVHWDc5MXRTSjR5cE9yK2lqWUsrNkhTY2F4WTRPV1hLRTdjU0xO?=
 =?utf-8?B?bjU2bGF0MVdDYVpPb0RNQUYycGNVR1pieGw4eHlLZFdZUW43YlprOU5BNXJZ?=
 =?utf-8?B?aitsUzA5TWhiNXlUOVhlZnRXRngrS3BNQ2Uvb2RGMCsxMDJoTzdKSVR6RjRW?=
 =?utf-8?B?T1pmUUdaQmo2WlZsRTh2RU9PUXhGUHVHMkNUeGFmL043cEhrMjI0WEl0VjEz?=
 =?utf-8?B?K0JXa1hYT0VqRnU5ZXppcWZmTjFjT2F0NzBhTFVSTGs4NjM1eTZ1UVR0cjJJ?=
 =?utf-8?B?SFVBTERWVytrMUZielpJQVYxdzJ3YllQTC9sWHZ0aG00UzhCL2FuZis1L2Rm?=
 =?utf-8?B?Rk5MTzgyY0R2emNqMFVnVzVUdFo2WmMxbFJTSW4yWEk4eWx1YVozYThUZzBn?=
 =?utf-8?B?a2doMVd6WEhKY2dTQ3hxWWJjVnhWaktOR3RrcFZXeERRUTZxM1V6N2tjYVE4?=
 =?utf-8?B?ZkhFL0JGM3JEU1N0aTNDSnU2U0JBaVcxdm9ORTFxT29ncmlDUU5BWVVmQTlX?=
 =?utf-8?B?TUtTaTRzWlRBKzVwLzVPN2NvQ0prVXZtb0JCMFA4YXY5clJLMGp4QUVFMzRN?=
 =?utf-8?B?WDZkSk1uNUtjL0RPUGtzczM2enpWZk1QaGhKYXRzTytRK3BaL09pNXdRNnRP?=
 =?utf-8?B?NU5iWGNONzBuT01NWHAwQStubnVFMzFOaXFuZlZ2SjZLWUlTMWMzcWgrSFhL?=
 =?utf-8?B?V1FBbG5md0lyb1ZJTHZKcWNtbURwVys0NjRBUnFZSmdhVFdxS1QzbEgxVk9M?=
 =?utf-8?B?Q1VlQmJVNlFnK1YvZjU1T280VmtLYkdXOVFwck9VREZ1YTkzUEVDcUw3Z2tF?=
 =?utf-8?B?ZFYrVld0bEdLS0w5SDBnZEY4cHdpTFYvTmVxL2tJMUVLd3N4WWVFVm53N2F4?=
 =?utf-8?B?c3k5Y2ZWcGpBZFBxUlpTK3UreUdoSWkzRFJTSk5qTWk5U2JZRlkwc3pBQnRk?=
 =?utf-8?B?akFYWkpyQjdJUWVWVTVLM2ZwZ0N0c3JJbU8yMVVVbkZrZlF1aE5LUVJ6VVc5?=
 =?utf-8?B?ZVg1YkVtcWJiYW8xWS9oSUo2dFBUYzVFTC9Kb2pGYlovcm1SeXNPRllNNWtT?=
 =?utf-8?B?YzVaOHg4K3R2WUpQSzNjVG9FOE9Hd3hMU3lMSGpVOGwxeUxhNDYyRmJ3dlNV?=
 =?utf-8?B?NHhRUFJJWlhKc0ZqMFFXNUl1ak1RY1FySUFZaS9PSHk5a1dTa0FudU5zSU9N?=
 =?utf-8?B?VEVCL051Zk92N2NLMEt1dXU2d0FadjEvTVdNTGhSY3dsYkNnTzNqaGFUSC9u?=
 =?utf-8?B?cWxuOVpqejl3WkZHOUR6OVB6R05ycE15OXhhS3M2a0Ivc0pOdjBZUnN1bWx0?=
 =?utf-8?B?RzZoOHB2aEZVcEFmalRQeDZQVlgvUVc1K2M0OFhWQ3VHVnZEMW5QNlJhcCtK?=
 =?utf-8?B?c2xzYXVoa1BzOHdQd05wRnN4Vjc5amk5RCtRSWNleTgvbkZFZTFqTUFldkJj?=
 =?utf-8?B?K2FaOTVVL3d1YjhqSnJNcTZtRWpOczJMaTFubGdIRUZBbklrNVlEU1c1TGUy?=
 =?utf-8?B?cndrR3hyRTlFMEpyZHF2Ukt3QWErRFpUNTVuaFRzNEtlYnpZanlONDV3TVJo?=
 =?utf-8?B?SlJVaFFpUGl2bHlSbk1zVVgwOUhScEVPMDJ6SkUrZWwyVk01QW01UjdZeDB5?=
 =?utf-8?B?RDhtMmpyNENZY2dIVGVpYUZmVHphd2tjd08xczRoMG9iMHNKcWFnM1VPZkhE?=
 =?utf-8?B?S285Q2NBWUYrTmlzZTI4dEtqRDdUbzJ2WXFHZitpK053SjJScHFoUExOZnJ6?=
 =?utf-8?B?d1hiWkc2YXhiOXljOGV1bFZLWUpaN1l4bFFoL2diNktzREJJL3NNb2U2aFFH?=
 =?utf-8?B?MEs5NkgrRXpNMkRYY3kxM0s0L2xPR3d2K05WWG1Ebkg0cTRSb3lraFkxbG5T?=
 =?utf-8?B?WGQ1dDh4NzdqRzJCcWk2OVlpdmh0NDNwTDZzamV4ZTQycno5b29ZcGNJVDZY?=
 =?utf-8?Q?Ema3e7SdqH1ennjXLJlYyq4lU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEgyVENHM0kzVE9va1BCRWdiNFM3RTZCRHcrczhVaTg2aDkzY2t4eEozYnBa?=
 =?utf-8?B?aG82VWNvazkzL1pmWVQzTmU3NStMYmFtV3FiNW44K1RFRjZRQlBlSUZOZE8r?=
 =?utf-8?B?enlJc1IvZXRIMVRPMG40dVJvQ05nM2pZUXJEdHovNnhRdGRjanNOOEZpaFdF?=
 =?utf-8?B?bDM4UTRTYnpjVjJ0bXMrZmozbnlRT013YmNDVGhhUGs0eGpvVi92SDIrTU5Y?=
 =?utf-8?B?a0FEM3N4aXBvZ1BselpMcDgyS2VJdXdNaGo5RVNsZHh6NWJ3UEdkL0N4VnEx?=
 =?utf-8?B?SWZXQVNZTnBJcmMrNlY0c0s1UlpYVXhSMFlSbGFUbmVnTnZ4eitsWVc3cHd3?=
 =?utf-8?B?M3ZEN1RMNER4aHhKKzZ4bkw1OVdObVlJMGZFc0t2a2p4ZnZMOHdacVNwelhx?=
 =?utf-8?B?NDZlRUNqRkFLMHp0c21FUWVhcnBPTEd4bkhvQ2RMRTUyOUpQa2VzeXNvY0xx?=
 =?utf-8?B?QThOUi93VDZOYk1oT0g0MGFmcVRJY2F1bjk5MS9HTEZETTlXYmRKaFV2VG44?=
 =?utf-8?B?VUhBeE5oWXpLeUl2K0lHWHhFSDZRV2J3NlM0bnFwVkg5SFR3NnVmTkhGTGR5?=
 =?utf-8?B?Slg3UnE3VDhhMXRYT2Q4TWdrVnkrK3ZQdjZUYlllVEJvbWY3RFhxOU1mN0xP?=
 =?utf-8?B?VjdTanZnRzZoN2Q0Y0dMZmxSeSthQnZ1cXhzMXVKUTlaYmNNbTZlZTBHbFRl?=
 =?utf-8?B?dEVqZzVYdkd4UXR0UXhiSGt5TmhkOWNyTkdQS0w2aFJBbUwxSU9zWFFqRUFI?=
 =?utf-8?B?UmprUVQxZ01KL0FNK1dZYnBtWDJIK1VPeEg2eVVHU0NmTVlSN0RuS1Z4WXpj?=
 =?utf-8?B?KzVyZWloU3E1V1dERFoyOUNGZUtlc2pLTFhLaVVVbjR1OE1hNHpoUVhWZ2k2?=
 =?utf-8?B?S0IvNm9nUUV6dGVJalBMb3Zpc3R4cER6UE0reEhOYklyajlGdE9Ed2JHTm9M?=
 =?utf-8?B?UGdDUEdOSmJQelpXV1UzeGsrbm5Hc0dvQkFaVDF1a3BmL0lkbUlVQ2o5U0ZO?=
 =?utf-8?B?NkZKdVhHeDhQakNEQjUzVjhVUHZjM044dlBMcCtnS3JsZStqb2J6aTdRRTlC?=
 =?utf-8?B?akE5Y3crcHNYZjFVcHlldkc5dGtUQ2d2ZmpKb2NqUXhxb3M1ZzRXa2o3UVRT?=
 =?utf-8?B?b2pyZEVrU20yQlY4VUMyckUxWnJqbkZvUnN5cEE5K2FPMWVJY1dPRDlLU0FU?=
 =?utf-8?B?cnBQU3BCUm9ucG9jeHN1STBKUXdKT01BWkJxNUtoWU1nTnQzTExFbDhGN1do?=
 =?utf-8?B?ZjZ0VXJYL2U2NVdJNFFZL0NrUUp4Zks0Q3o2OE8ra3FGMEh1ekY4S3N4RXFZ?=
 =?utf-8?B?K1k1ZDdRdGoySldieUg3MG41WVNqSy9JTzgvaDJralRhRm5VZWt2bkNXU0Zj?=
 =?utf-8?B?TEtxOEJUb1EvcFZhM0szMVFGSEUxK29rTmR3bFhGNmNESVJDeWZxQlJtZnJS?=
 =?utf-8?B?ZEZxcWNVWGM4M3Fvc29vQTlyeUJXd2dzSFVFT0FMQjUzaE90UFQ0R0JIVGdw?=
 =?utf-8?B?WVdJcjBGVnVxS3I2aVJqNTRCdVlFb3VxOFNyam9iRWhIalpwQVdzbkVnY0Ir?=
 =?utf-8?B?aTdhQ2JYL3RkVzJVc1pRd0F5bis2ZHBNQ0ZYMFE1bjBMMXZEakdJc2oxclRD?=
 =?utf-8?B?VUhSdmJHQzIzdXZwbTBMam8xWndTUGZldXhsNWZKMUcxZ2lwS1ZqM2o2Sm9x?=
 =?utf-8?B?anBJRkw1bmVmaURzc2tsQUQ1c0xveC9OSWUwMU1sYmFoRWZOVEtOdlAzWkhL?=
 =?utf-8?B?SWVTMEhwQTNPZkZaMXRldEx4M3UrS0haZ3ZucnhORCs4bUJjTHF1VThtZ0NS?=
 =?utf-8?B?aVQzRVluSnA5cGhJWEpWK21kZUhIamE5Z3VCdFRobFE5KzZjTC9ZaFJ3NFZj?=
 =?utf-8?B?cXdHSVJVMEJYTXd0cTNRTkJUbGV2QXFpVnQvdVJLNGV4ekpzeWVmemJRV3JB?=
 =?utf-8?B?bWd0aU9SVUw5MHgxalFOc3hSUFMrYWx5cWhaWW9CekZMMGovM1oxdUNlN3lI?=
 =?utf-8?B?WmhBM25ZeTB5NjN1R3pSdHVDY0l4OEprRVBMR25PdXpENUZWTEV0YmZCVGZh?=
 =?utf-8?B?QVpOaTlKTXd3aU5NZWg4MWVwSUFBTDNJajdmaktoVEtuRzFQUVlnQm5WN2Nx?=
 =?utf-8?B?NUFsdjBLbndzMDF0S1cyNmhqcThyUW1Cems5RlUyTXYwRHJwT3pwQWtpUkky?=
 =?utf-8?B?SmNhMDZCbnBRMS9GYXVHUVhxcUttYXR2NFlRVnhsNVVnZkJKOENNQ2pWUnpn?=
 =?utf-8?B?ZUwraXQ2bU96OUR0OFFDMnFBTTFmcDBkV0dYTWFPZUJZb0dUVWhjQlZIaDBh?=
 =?utf-8?B?VzBxaGlvTkdmSnZCVTFtSFdaSStZU0gzQWUraXZQL3dOWGdlQ0tROEJqS2Y1?=
 =?utf-8?Q?5u5GPvdyR9dBaZmw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85CA037383624F40BA8FC64BE710E1E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ViAy/NQ71my5TPhxFebf0lsSlb3E1b84V1Er2/AykvoMLPRekZnyEYIKT1qIpwJXWyR+WfpPzX27rC8bDv0GBFkjhyUJwLfmiUt9qVfViFJFH6Tn3el/hvvcSqH/Ocbx9n3HCg2JVdsN7Kh2jZHoIgDojPXJph0V2wABaqqloXTg2CrqIt/zj+L19Dz5SBVABmpgDhVynJk4EjZgk2mb7Bq7J+maX7YvGpCkyds6eUDAiJq7ESOeOIudxWxfoScIFGEbA7JCW9XJWmbmv2zUS3WD2OUE0lbaS9lKLkNm6nbUosVn3fiNZBSR4sMt8aPFoQDw7xSTsQYTPomlc8/hdJIQFF4Ek8phFDL+dIayHy4mu38UmcMefqc4HUwWBy0z4osf/MfJ4DklvBWICESRxsPt3mvEraD7L4zpmL4bIDMTOMJKzef7DGPNzs8xtfg4ddLA4RNbJ2mDLWpoLaGi7yAgTs8bwsiXNX08avNdLiBI9L42lSCMitZehIOqPpKR05FQBMoVEUIDSyoiqPM9ZWSQztUeXGfM7odV6AocnOCjL2MW+N3xJ7FF4fEVqzGzIhWwfVYErgK8iUjeO9I+96YpO7p9d264x1r70R8NMVQlg3OT46yE5jjNPh1j17Db
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80353c4b-5660-4f94-5ced-08de6af6142a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 11:50:26.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfpKjIBOSwWDAzo4tZi++CSTeEYxloAqGuTv1wG8eiwtD9sJi+kXXpOLk8Me2KRd4kO2MHJsPrKNKhO189FhT7m30rblvSqyd8Iy9pIv3xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77138-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:url,sharedspace.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD70D135D7E
X-Rspamd-Action: no action

T24gRmViIDEyLCAyMDI2IC8gMTU6MzEsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IE9uIFRodSwg
RmViIDEyLCAyMDI2IGF0IDAxOjQyOjM1UE0gKzAwMDAsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+
ID4gQSBzaGFyZWQgcHJvamVjdCB3b3VsZCByZW1vdmUgdGhlIG5lZWQgZm9yIGV2ZXJ5b25lIHRv
IGNvb2sgdXAgdGhlaXINCj4gPiBvd24gZnJhbWV3b3JrcyBhbmQgaGVscCBkZWZpbmUgYSBzZXQg
b2Ygd29ya2xvYWRzIHRoYXQgdGhlIGNvbW11bml0eQ0KPiA+IGNhcmVzIGFib3V0Lg0KPiA+IA0K
PiA+IE15c2VsZiwgSSB3YW50IHRvIGVuc3VyZSB0aGF0IGFueSBvcHRpbWl6YXRpb25zIEkgd29y
ayBvbjoNCj4gPiANCj4gPiAxKSBEbyBub3QgaW50cm9kdWNlIHJlZ3Jlc3Npb25zIGluIHBlcmZv
cm1hbmNlIGVsc2V3aGVyZSBiZWZvcmUgSQ0KPiA+ICAgIHN1Ym1pdCBwYXRjaGVzDQo+ID4gMikg
Q2FuIGJlIHJlbGlhYmx5IHJlcHJvZHVjZWQsIHZlcmlmaWVkLCBhbmQgcmVncmVzc2lvbuKAkXRl
c3RlZCBieSB0aGUNCj4gPiAgICBjb21tdW5pdHkNCj4gDQo+IE5vdCB0aGF0IEkgdXNlIGl0IHZl
cnkgb2Z0ZW4gYnV0IG1tdGVzdHMgaXMgcHJldHR5IGdvb2QgZm9yIHRoaXM6DQo+IA0KPiBodHRw
czovL2dpdGh1Yi5jb20vZ29ybWFubS9tbXRlc3RzDQoNCkp1c3QgRllJLCBJIHJlbWVtYmVyIHRo
YXQgdGhlIGxhc3Qgc2Vzc2lvbiBvZiB0aGUgIktlcm5lbCBUZXN0aW5nICYNCkRlcGVuZGFiaWxp
dHkgTUMiIFsxXSBhdCB0aGUgTGludXggUGx1bWJlcnMgQ29uZiAyMDI2IGluIFRva3lvIHdhcyBy
ZWxhdGVkIHRvDQp0aGlzIHRvcGljLiBJdCB3YXMgdGl0bGVkICJBIGZhc3QgcGF0aCB0byBiZW5j
aG1hcmtpbmciLCBhbmQgaXQgZGlzY3Vzc2VkIHRoZQ0KbmV3IE9TUyB0b29sIG5hbWVkICJmYXN0
cGF0aCIgWzJdLCBxdW90ZSwNCg0KICAgIkZhc3RwYXRoIGlzIGEgY29tbWFuZC1saW5lIHRvb2wg
c3BlY2lmaWNhbGx5IGRlc2lnbmVkIGZvciBtb25pdG9yaW5nIHRoZQ0KICAgIHBlcmZvcm1hbmNl
IG9mIHRoZSBMaW51eCBrZXJuZWwgYnkgZXhlY3V0aW5nIHN0cnVjdHVyZWQgcGVyZm9ybWFuY2UN
CiAgICBiZW5jaG1hcmtzIG9uIGEgZGl2ZXJzZSByYW5nZSBvZiBoYXJkd2FyZSBwbGF0Zm9ybXMu
Ig0KDQpbMV0gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzE5L3Nlc3Npb25zLzIyOC8jMjAyNTEy
MTINClsyXSBodHRwczovL2Zhc3RwYXRoLmRvY3MuYXJtLmNvbS9lbi9sYXRlc3QvaW50cm9kdWN0
aW9uLmh0bWwjb3ZlcnZpZXctb2YtZmFzdHBhdGg=

