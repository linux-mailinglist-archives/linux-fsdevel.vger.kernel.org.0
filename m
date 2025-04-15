Return-Path: <linux-fsdevel+bounces-46446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61DA897BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C3B188D59C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3B27F741;
	Tue, 15 Apr 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hkmF9EjE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q6FBxT6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB31275105;
	Tue, 15 Apr 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708627; cv=fail; b=fZDDmnM73WDg3SeLTV+MvnCnauWhQ/ee7LzbGFssK17RAIpB3MfTAhwVXSGh600anJL23EWx3M2P1wFP2bj9BPZtPU1gw0d9p12IQjapTlaYohojdlPAjEQ9rfBq6zf1sYFgncyvWMYRYptdKtaQTEaVbBlhQStJFQoAWRVheno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708627; c=relaxed/simple;
	bh=xBoXmTFRgtNum24f9AiJNcRqRhJBD0131gaIDVspxl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgZtciylwOi3nN4zazNGYUHeOD7bAI/0VIfUOowm1QWzDqC5wvULNr+QD5FHeKOXMa6fFx0eVeV9V0EvV84ClerhLH+DTm0lGc4/j+aitWUFWMN+eAo9tbk4VcrL/4jLrNwG0cBVyqmEgn4wVICyXr42s2fhRjPVst/9h/iTNdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hkmF9EjE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q6FBxT6A; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744708625; x=1776244625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xBoXmTFRgtNum24f9AiJNcRqRhJBD0131gaIDVspxl0=;
  b=hkmF9EjE9UEW+MWSuQ89jQQI7PFju9K0X6rIf99bnOgj7QoM9EGIUEzS
   cS/mIOUN2E/dXYr5QQl7M+c8w4HMufk20n2Xt60SUcfiFXhhLbQrkKJjQ
   f1jrIYp5Q3tK8Gai/G2X1+IPq8avHYik6gFCn8asgW3GyqcEdjfFgMMXN
   wWyyHtMt3Gf27E45HZ5ykP+Dfuk41Cp5Nn1PdLHTWcBfEp3VCp5ET7sJu
   DHwbczQACoESpEABOjVM+DsIWzl2VWorKlKDLne7gD+atYUVgOBtN+3dP
   f1z7x1p0+7MVgK9wbqt0XKsDvCUaC4tt93ZFxw7dhraorz88WKsinalQp
   A==;
X-CSE-ConnectionGUID: 1alnotyYRsWL6lsBnszkcQ==
X-CSE-MsgGUID: KMe+f15KR6KR8uE/B68FNg==
X-IronPort-AV: E=Sophos;i="6.15,213,1739808000"; 
   d="scan'208";a="75498741"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2025 17:17:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMjbFbnZ39uxDUxtZTQB/a3nF6Vdxb6jrM806RJ8cYkotiIcDJFZo9JEjU9E9wt3J4PrcEYBPHwSRCi5I9vL12TujDAN6xCpy+iOhQwK79/x11d9o7XpZo7egh7c2l5VYiecoUdYfRY319cPKo29lZdIP2WMjiBw9NWrR9H4X0l6nWZNDsHDkx6iaFthGU8Vm7AJWdnxWVLpzA9Skg0ewLeEk0ygqPF2BLMVrNo7WZ0cNQrBXHXbpsYJUp8c3LBjPqHziAsGyS5OLzpShLWa8dnqgMrbrHKH1ijSnco1YEtQY/kOrHcQrDYACQ5KV3nOkqYYj1aNhlEMj7m0CwV1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBoXmTFRgtNum24f9AiJNcRqRhJBD0131gaIDVspxl0=;
 b=fQe7dQBkVCTtiJuJy4nM7VckVP3rF5+gkmIUUQI1spc2btNKlR28b0UlJatuZ1FGxRiqTquAPPAnP06a0MD/d2pxZf0q9GILhLiMu/vQ9ugzt8jGnuVOzQkqmohe7YkDakbsKpl9gHDF/XLiCeNbWzgUsOcoU718D0DNRraFbIZc6SY4AYsgoNJGirFrLCKa8iEcMx9nfceecDwaTbXeG9BVix1PTincDMWEZgFg8atKxeA6RFr5I7MQm9xsNqMzsaBrnhAhSg3YdK4S4P4WF+QkmMJssOtvXusApPzRCbb6MhF80xerVrNcTyBf4rOYgjtPLnkyn1qpgZT7pFsM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBoXmTFRgtNum24f9AiJNcRqRhJBD0131gaIDVspxl0=;
 b=Q6FBxT6A2hHeKg1vGQAFxTShgQnoGWEYPr4HnSOvVV38sWsYDVFUlVgs3/fqUsFdMrVy4RmTxtbLKH46AOnWh8k0HgXuBEZ/IGxSQWfTmI7WfUJfzU9YHCMauzhFeKlBg4YglkxngDBy9mvhNQM7EUhQxj6O8MLNi03/UGCJSBg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9363.namprd04.prod.outlook.com (2603:10b6:610:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 09:16:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 09:16:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
CC: Matthew Wilcox <willy@infradead.org>, now4yreal <now4yreal@foxmail.com>,
	Jan Kara <jack@suse.com>, Viro <viro@zeniv.linux.org.uk>, Bacik
	<josef@toxicpanda.com>, Stone <leocstone@gmail.com>, Sandeen
	<sandeen@redhat.com>, Johnson <jeff.johnson@oss.qualcomm.com>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Thread-Topic: [Bug Report] OOB-read BUG in HFS+ filesystem
Thread-Index: AQHbrUhNty3+fdMAPUuyNCJ0QAeZCLOjPRqvgAAbcACAAQOfgIAAF40A
Date: Tue, 15 Apr 2025 09:16:58 +0000
Message-ID: <786f0a0e-8cea-4007-bbae-2225fcca95b4@wdc.com>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
 <Z_0aBN-20w20-UiD@casper.infradead.org>
 <20250414162328.GD16750@twin.jikos.cz>
 <20250415-wohin-anfragen-90b2df73295b@brauner>
In-Reply-To: <20250415-wohin-anfragen-90b2df73295b@brauner>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9363:EE_
x-ms-office365-filtering-correlation-id: f5ffe597-45b2-4aaa-7cc1-08dd7bfe464e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWdsSHFXNmFueXNkcGpub3gvTWt5K3ZkeGhDZEdkQXpUVFZUTDBDbGN3YTNM?=
 =?utf-8?B?N1FjaVRMcWMzemxrbjBpcmpBSzNHN21iaHhiRjlvN0VvWExHSkwzQzZGS243?=
 =?utf-8?B?N0wydUZRREVsZ3BaNTlVTVlhenMvbU82TXR6TVd0VWdyS2FtM1R1Z2lJSHJp?=
 =?utf-8?B?Vk81NVNEQmwrWC9vRnVPOXZpeFlteWNEK0dDaHMycnpXTUNYbk5WQXE1Ynoz?=
 =?utf-8?B?Q05BQXhqNGp5Rm5LYS9jN1c5UVJKaUFsZ2J0Q0pPVWFOUzZ4QzZOZ1ZlMlVC?=
 =?utf-8?B?dzBHclpqcDFhZXIrUnRsSjBodW9nRnBqSENpYUREcGZwVlhxM0NRZzFQejRp?=
 =?utf-8?B?elluMjJVQTNIL2pEYXBaY0ZvSy9oZjVIRURJR2kwdkVCOU9XZGlvYjBLWXJZ?=
 =?utf-8?B?dVExRllzM1FaYWZnTzRORlRpZ0VIWnJhVXQzczRhMDgwQi9wUnpHc1Zkb2RZ?=
 =?utf-8?B?N0VFbEphNFVYNEZxcytxVGtFNTR0K3l2WGtDelp6YUdUdlI4NzcrcENtN09I?=
 =?utf-8?B?ZE5nWHphaUJSaC9TTlpOZ3lHd2hUVHJUTFgvc0xzK3ZSb2tiVmRUVW5xeWc2?=
 =?utf-8?B?eDdpMFZwREZTbW5jTE4xOWh5WUpuclF6WU95N0RjalNJZHY4UlZXNVdGLytj?=
 =?utf-8?B?VlJwdEtFT0VLNWtWNU5WdG5DWkx2T1M1ekNuRzVqRFQ0RDhVWFJxaWNURTBz?=
 =?utf-8?B?OWlLdVpEREpKeVovMEhXUnFKa3NuR25SOTM4aWR1Ymo5dENUQ29FbWxuaXRY?=
 =?utf-8?B?U1ovTUdka1ZTb3hsdGxEUHdTWTZGelltSngySTliZEpQcFJ4M2xOL1FiVlkz?=
 =?utf-8?B?cnJJUzNTM2t2elNVQUwxNXlSNVlpT2dMUGxNTHdkYkJWUmpka0ZVeFpsL3kx?=
 =?utf-8?B?c0IzUkxZRjA0cnRZTk5nSmNOTWpUWWRYSUpEcm0rWk5VdW9URnBpcXBGTm9I?=
 =?utf-8?B?MjVTb1hhejZidFZyYm85VThzTkw4eWFLenlFOVd6bnlnamVVMFkrcUx6K0Iw?=
 =?utf-8?B?OWZldkU4VDN4UXBlYktFaDlDcjJDOHN3WjZFdGdVRmJYWTlLbktqbXV3TzBv?=
 =?utf-8?B?V2VUUG1Hdk80NEVkUTJtalRlbmlSNis5TnAyNWU2TmpMMzVWdFlqckhmNXNm?=
 =?utf-8?B?dWRvQmVZUmE0YlV1eGNHZTNCTEZsUG1IU2hiWmJOeHNuZTdPdmNyNHRHWDRn?=
 =?utf-8?B?VzJOSmFVcTUzU2hBTkplKzdCRXlMckUzUHRxUFRWZ0NpWEl1c1d0TUFsdEZS?=
 =?utf-8?B?KzYxaTk0bkg3U2ZtTU1leFp4YjFsRjZBVXBSbi92WUc0ejViSExTUGNmZXBQ?=
 =?utf-8?B?UmppYnhLdHhSbHNSamhadFp3UlNLcGU3c25YMjdpeXN2R2VUcDJITFZLc2NH?=
 =?utf-8?B?RDUrRlZUQ2ZLQ1FGc0VicmRGU2RLeXZPcTR2MUoydXQxcGhQYlh0SFVJNmdn?=
 =?utf-8?B?WS91dmt1bkYrNy9zRE90SXNIT3VjMG9yaHZhLytGVUE0dkRZTmRkczdSSU5P?=
 =?utf-8?B?bHRMWjRPNStpRXRmaFVKbHFZR0xoUVNJbk15STZxR1ZFNCtTY3lFUi9SS1Rh?=
 =?utf-8?B?c054N0FJdDJwSTFYSEF0WWhMWGlvR0V3eXpicUlRY0cwY0RpSHFSWUM3azZq?=
 =?utf-8?B?M3R6c2hHT1lkZktRSHNOdlp1Mi9IbzFjd0d2dHAzQVR4ZDd3aUpQR3R0RkNl?=
 =?utf-8?B?d1d0L2Y5SUM0Q2h1bUNCajd1SjNYUldxdCt4TW0xa1NPSk00Qkl4UURrRkhv?=
 =?utf-8?B?aFA1cm0xWGY4RklHOWJrbUZIR3NqQ3puMFZwSUo5Y1ZVamdmK0UzK2tmc3hr?=
 =?utf-8?B?ei9tbUVhVzF1Zm9IM21KNldwQVRyVHR2M3JpQlZDajUvMkNjU3cvU0JTQW5n?=
 =?utf-8?B?Y042enV5d3g0SUoyb2F0RHBWbHNkcFVQQ3ZmdmVTcGlzTG9oQmlnTm1xWTNi?=
 =?utf-8?B?eUVsSjdadXkzK1FyTUo0ZWVaVnVMN0MxZHExYWtmMFFIMDQyZ1A3STR0Vnhx?=
 =?utf-8?Q?heuZM+93G9ix2IlaWS8iKmRVezc0f0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YS9kTzI1bmpFbFJaTXRkUlUrcHByekJQNjYrR1BQeVNrK05BTUtSaVk2eHR6?=
 =?utf-8?B?eWNCd1o5bVByaVNRRjJYSWYwTkdubjEvL29GTWxZMklobnZzcDMvaEJCT2dp?=
 =?utf-8?B?K0RNVjh2M0hBMU00ZmF4U1RIQ1NoTUtRMmYvNzNNTXVObEdDRlF6dFdCTDBa?=
 =?utf-8?B?bEYyUVdqbVhCYXBaVlZIdkk0OEtVeTlIN21hZlYvd0lqZ2ZwQzYvdTgybUtV?=
 =?utf-8?B?dVNPaFdrSXovampQay9oNmRDdTRKWmpUS2JJVC80TUp5QU5TMEZmMGZaVDRW?=
 =?utf-8?B?aGRoZEtqUWpiWFduOGdrYThsZUtwTk5pNmlENW9ZbTIvcEtSNGF2LzM1UTR1?=
 =?utf-8?B?bUFzMjBqV2VEWTkwY0NKOWN5SmpjWnI5TGdOMy80V29LTGltTTdudUUweDBw?=
 =?utf-8?B?Vy9JWFBNaTB4WjN5QWNPZHRQU1J1ampPWFByMlEwa1BLeHJGOHJWT1FVZ3Fw?=
 =?utf-8?B?bytNZnUxSEtnN2p5MG0yNE1Wc1JkMHd4SW80Q3g2MXpTOTJKcnpZcXRETitZ?=
 =?utf-8?B?eXhHRjA4Z1RoU2ZnVjNyYjFkZGNUNElqYndtc003ZGxadHlzbnROZEkrRHFo?=
 =?utf-8?B?ZkxtWXBUcm1tdXE4aXdhT1lZN0hxb2xISmoycDlMQWVwaWRINVlDUFoyYkFY?=
 =?utf-8?B?OHRZbFkzTk5qQTJiSFBsNFA2cXhPQzRUWmVVMnpLR2pjYXVMRm1TWUQ5NHBX?=
 =?utf-8?B?c2NQa2hwNzJKUDhiZVhKTjI5MFFER09xM21FYkMxeXdZeTJIdjdhRWlXaFB1?=
 =?utf-8?B?aDJlZlE5SzBjcHh4RUR6VUtOU2c0dmtXV243NWlhZUV3bkFJb2hCamxTMDhs?=
 =?utf-8?B?YXBVSWRQSFhLeDU2R0ZQdWxCNkllME01azl5bXFTSFJqbmk0WEEwcHFUa3RF?=
 =?utf-8?B?cTZxSHlwcVR3dzFOWjJ2d0JlbEVnZWZMbEdMZFhrdERsS2hJN0dnVVk3d0Rn?=
 =?utf-8?B?MG1jNS9jdkk4UmFQeDN6enptcURXQVRoM0w4L0F5NnVLMHduWCttSDAzeEJi?=
 =?utf-8?B?RHZHdFhubU44QUpwVFpwNVgrbVoycEsxeElycUYwblFhK0U0YWRxbklIK3NY?=
 =?utf-8?B?VE10R05RbGlNSEh3MXR4UnNOY1E0eHZMdGw1N21Yc1BYTWdhY3Jkc1k0TXkw?=
 =?utf-8?B?TXJHTlFmaC9CVWZmTTdlbkxTRThkNkZGV3BRYWtIYlUzdWhLZTRERVkyMEF3?=
 =?utf-8?B?cDhpK2V0Vmp1MW9veGdtZ1hxOFhyQ29lY3pEN0VPRW80bGRQc0d2N29ramRB?=
 =?utf-8?B?amdEVE0vMW1zUk1kYVd5dnNKWjVTOXJKRmdIYkVCeVU3YmF0LytjL0pwNVNs?=
 =?utf-8?B?T2wzbmNGM2VlYW1RcmVXWVBlUEpvY0dqUmV3NE9qYWt5R3ZCVnhRbzdxc3VN?=
 =?utf-8?B?R3dDMnVISzFTT25UQlVLRTJHUW9XZ0I2eVB2bkJ2Y2ZwV3FTaDIwMWd0ZElT?=
 =?utf-8?B?cllCcGc3RnVTd3U0VUtNTDJ6K3dRTC9KSHdTU3JMM3pmSmdxWmlSUDlJVnlS?=
 =?utf-8?B?MkdQTnRsbk9XZzdBSUpnT2VScVh2Zks1aTcrMGgzYS9xM0xReGF6aWJ5MU5B?=
 =?utf-8?B?UHBqMldlZHhoS25jZ0JkcXJXeTZQRGFMUGhTRGhBcm1qLzlZWE9BeWpnS1Y0?=
 =?utf-8?B?eko4dndrczIrNlpMOVBZcllzczl5VUZjTk1pTjBVUERLMjQ2V1VLWW5yN2p2?=
 =?utf-8?B?V096Z1dBRi9OeXRSRmhHcGQyTTh0bGR3RERERmFTRG5RV1VuSEVvMy9LRnRz?=
 =?utf-8?B?WUdaaWRaMlY0N3k3QmFnS1d0QnJMaFhhMzBGWFBJd0RJSzVQNUdRak4rU0Q2?=
 =?utf-8?B?Z1pldzFoZngzN0FkS2RXaEY2M2FZTkg3bXRLeVFLOURlTEc0b250VzZ6U0ta?=
 =?utf-8?B?VkFzeTYvZFZkQVpPWWdDVmVrK1EzU2xIaWgrS1VEaldzd1NUR2l6TXhnVVJu?=
 =?utf-8?B?d3RSNmlxSWtWUEFneDFVb2d1c2RJdUxGdUN2MWo4VHZUcVc4ZVB4emZVUE1m?=
 =?utf-8?B?ZTdyUEpia1NoeEhIWUx3K1BFZzZPREtSaTB2RzVCcDVyRmNpNytZNlpnV3pj?=
 =?utf-8?B?WTk2Y05UMERjK3d5NC96QjVvcWNPNE5SVHVUMkJ2Znk2eGtsMXdhWitiWUl0?=
 =?utf-8?B?UGphTTBqUmMxcFpxYk1NSW5Ba3VVdTZtUTFPTEdFSFI2T1JqbE1VcGw3NjUv?=
 =?utf-8?B?MDVMdG53WTR0UWNaaVBrKzRTMXRTV3U5c0hFZVVMUEE4TW5lcUphKzdYTGZM?=
 =?utf-8?B?TGVYeXBMd2tYVldPRDlMMWNFK0hnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <793BCBAEB0BF3041828B7A05506C2E37@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nyooLNkwRr8j3tDldYOEMZTkOXoDZ8hS1+v0/MnSjrE+4fPxhy+w1Mk+u3t9/PPKgyAaBfBCWn1UB6xq09smZkTMTVJMuas5w7zPwC0XYlYwJRbxy4ZRQVVvTofex6JcDzfJ3qmiRINJVgZ8hCEgYzd27nzGzGKUu59raaD5o0c8ls6TXpLMmZvBSHm4msZsgUGDG9w9lkygUJ4MG6hA7GcJ9eK/DQc53F200c1x1E64dcgKlIi0NbqSJhjan9/9K9dM3LLXtxrSG1XFUOyPyIPn1XuWbduj2riPysL5auRQbemdvw5Ec448SmQlKNQg3aZh3hvK93HORQQyK871ax90aqKy0mC21eOOzHhgw5YGpOl/CxDq3HO5IDdMH2QwBDM9y6FRHWPzgIQgvqBHqBbaiu+UIL44PATmjv3zE8TX1XsdDJskneU0zWeqwHW3nhjR8kKHA8SbMS0/OO1Ey69vUyViE+ohqBYS3qMB5MxTGpFoUtlqPBp56zfLlSs6koq5fCbMoSvk4Jy9b027lAjrpJmi82nCw8D8gbvuF96sbXmtaMwTiTbVgIkPR7ucZ3vf5Yu2GcGfOcUEIPROV4M6j/n+RRXh2ImaEjSCIfxN3ZlcF+H15zG3Aitf4XD9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ffe597-45b2-4aaa-7cc1-08dd7bfe464e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 09:16:58.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZUqQ8Eoqg03xqKGfDO8tLJaA3eCKKHOMZ7GM+0KOAOBguBfsOyLqUEg0KzVxw+k+iThZoT/PnNbYcC5MkOWYToIRrWBy9iGveFj1bq0G68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9363

T24gMTUuMDQuMjUgMDk6NTIsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAxNCwgMjAyNSBhdCAwNjoyMzoyOFBNICswMjAwLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+PiBP
biBNb24sIEFwciAxNCwgMjAyNSBhdCAwMzoyMTo1NlBNICswMTAwLCBNYXR0aGV3IFdpbGNveCB3
cm90ZToNCj4+PiBPbiBNb24sIEFwciAxNCwgMjAyNSBhdCAwNDoxODoyN1BNICswMjAwLCBDaHJp
c3RpYW4gQnJhdW5lciB3cm90ZToNCj4+Pj4gT24gTW9uLCBBcHIgMTQsIDIwMjUgYXQgMDk6NDU6
MjVQTSArMDgwMCwgbm93NHlyZWFsIHdyb3RlOg0KPj4+Pj4gRGVhciBMaW51eCBTZWN1cml0eSBN
YWludGFpbmVycywNCj4+Pj4+IEkgd291bGQgbGlrZSB0byByZXBvcnQgYSBPT0ItcmVhZCB2dWxu
ZXJhYmlsaXR5IGluIHRoZSBIRlMrIGZpbGUNCj4+Pj4+IHN5c3RlbSwgd2hpY2ggSSBkaXNjb3Zl
cmVkIHVzaW5nIG91ciBpbi1ob3VzZSBkZXZlbG9wZWQga2VybmVsIGZ1enplciwNCj4+Pj4+IFN5
bXN5ei4NCj4+Pj4NCj4+Pj4gQnVnIHJlcG9ydHMgZnJvbSBub24tb2ZmaWNpYWwgc3l6Ym90IGlu
c3RhbmNlcyBhcmUgZ2VuZXJhbGx5IG5vdA0KPj4+PiBhY2NlcHRlZC4NCj4+Pj4NCj4+Pj4gaGZz
IGFuZCBoZnNwbHVzIGFyZSBvcnBoYW5lZCBmaWxlc3lzdGVtcyBzaW5jZSBhdCBsZWFzdCAyMDE0
LiBCdWcNCj4+Pj4gcmVwb3J0cyBmb3Igc3VjaCBmaWxlc3lzdGVtcyB3b24ndCByZWNlaXZlIG11
Y2ggYXR0ZW50aW9uIGZyb20gdGhlIGNvcmUNCj4+Pj4gbWFpbnRhaW5lcnMuDQo+Pj4+DQo+Pj4+
IEknbSB2ZXJ5IHZlcnkgY2xvc2UgdG8gcHV0dGluZyB0aGVtIG9uIHRoZSBjaG9wcGluZyBibG9j
ayBhcyB0aGV5J3JlDQo+Pj4+IHNsb3dseSB0dXJuaW5nIGludG8gcG9pbnRsZXNzIGJ1cmRlbnMu
DQo+Pj4NCj4+PiBJJ3ZlIHRyaWVkIGFza2luZyBzb21lIHBlb3BsZSB3aG8gYXJlIGxvbmcgdGVy
bSBBcHBsZSAmIExpbnV4IHBlb3BsZSwNCj4+PiBidXQgaGF2ZW4ndCBiZWVuIGFibGUgdG8gZmlu
ZCBhbnlvbmUgaW50ZXJlc3RlZCBpbiBiZWNvbWluZyBtYWludGFpbmVyLg0KPj4+IExldCdzIGRy
b3AgYm90aCBoZnMgJiBoZnNwbHVzLiAgVGVuIHllYXJzIG9mIGJlaW5nIHVubWFpbnRhaW5lZCBp
cw0KPj4+IGxvbmcgZW5vdWdoLg0KPj4NCj4+IEFncmVlZC4gSWYgbmVlZGVkIHRoZXJlIGFyZSBG
VVNFIGltcGxlbWVudGF0aW9ucyB0byBhY2Nlc3MgLmRtZyBmaWxlcw0KPj4gd2l0aCBIRlMvSEZT
KyBvciBvdGhlciBzdGFuZGFsb25lIHRvb2xzLg0KPj4NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS8w
eDA5L2hmc2Z1c2UNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9kYXJsaW5naHEvZGFybGluZy1kbWcN
Cj4gDQo+IE9rLCBJJ20gb3BlbiB0byB0cnlpbmcuIEknbSBhZGRpbmcgYSBkZXByZWNhdGlvbiBt
ZXNzYWdlIHdoZW4gaW5pdGF0aW5nDQo+IGEgbmV3IGhmc3twbHVzfSBjb250ZXh0IGxvZ2dlZCB0
byBkbWVzZyBhbmQgdGhlbiB3ZSBjYW4gdHJ5IGFuZCByZW1vdmUNCj4gaXQgYnkgdGhlIGVuZCBv
ZiB0aGUgeWVhci4NCj4gDQo+IA0KDQpKdXN0IGEgd29yZCBvZiBjYXV0aW9uIHRob3VnaCwgKGF0
IGxlYXN0IEludGVsKSBNYWNzIGhhdmUgdGhlaXIgRUZJIEVTUCANCnBhcnRpdGlvbiBvbiBIRlMr
IGluc3RlYWQgb2YgRkFULiBJIGRvbid0IG93biBhbiBBcHBsZSBTaWxpY29uIE1hYyBzbyBJIA0K
Y2FuJ3QgY2hlY2sgaWYgaXQncyB0aGVyZSBhcyB3ZWxsLg0K

