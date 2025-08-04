Return-Path: <linux-fsdevel+bounces-56635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3706B1A0C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 13:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A4162205
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321D23D294;
	Mon,  4 Aug 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="aariVpo3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7C22D7B6
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308273; cv=fail; b=BJJMNXvh0AEbGeJ3YkYQHzfEXA62zbNPKKfMcPIQbjtNwOSKjXvbAG3tUN+drrJ9/WM8a+efV6Lzmn22k+IWPbNpUHPYfXs/CNGxAVCLT0ZpPKf0Xl+YPhbz5Z/C+6cK/OXWch3yfAv0mFr0HhosxAEHzlst291Q63mwc6P59TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308273; c=relaxed/simple;
	bh=IASrJPGQIJ4Az0FOmfgiTJ4Gh5zs/JEvky+hGUh2wqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayLfO0EWkfLQqiQqpHQbhhVoCOC402AhIbTtJXTSVDA6wrrx9Lxke180qJ8IjeYLlQc/3og8JINdiKlUlTK5IcqKsU6pxI0esQoNCk/HKQZFsErIWCADerYnU5RF6zsJeVlB1Kpv6TPpxyW96w9sYR8d3ZZ2vIAkkBZkq3rtQ5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=aariVpo3; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2108.outbound.protection.outlook.com [40.107.101.108]) by mx-outbound10-197.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 04 Aug 2025 11:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/Ho+H/GSxCUmS7FOiSvDebq0BnTSUcTdRtKxn0NW3PYdzJvE+lmQvONgl8IVo/LUbWNLcd2+zLtn6Untkl1f5Rf7u158kIueds+Rxh5e31XJcHE26gEhefp4GwGzfnc6GdXCtMTnRG6mb71eYVKrUZMT/gM2VH2prTifG+1q28+gVPc/Zm0i7horcIin9tzFRpt1GIyRVk98UH9VeCmpsHqSHukt+pSSIOXngFh03FDgEm8bBSTI20w7NiHkblO3B+GpnFBfzQNsEa+VcrWyT7w2mo2hcTUi2Tsgwmcjq9kwbPAwGH/QhurJ/py2CfibztXR9MiekudwIkYj1LeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IASrJPGQIJ4Az0FOmfgiTJ4Gh5zs/JEvky+hGUh2wqU=;
 b=GvOhaggJvHc3uE19RKupNL525FGlsjeCTp3oAqf/mnJYVlBZEkCIECBjGfkm3nFtwBsOjJYo0LI0GJplavIUoFuwWG4eSewZS95j9S7bD4nu5ag5jtkL1MJ5W2tdcs0jypyhHJqoOkxxoDcx0f8Td0aut5nt+/DGtQH9o5VLa/ve2gOMiAA1hw66UlWQacHLNkeTgYgv6tC8NvNeeMQGpu6EEm8mOfYXx50k3naMY9OZaxgJP4G9cWcjE0MIfITFoLodlPbKy34N5SJ+EQ6mRK7wTw9deSbfBXaeSzGpmF4opFsqNopuHBxQUQ0C2A0T1zdLn3qhAPmyAft83w0xFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IASrJPGQIJ4Az0FOmfgiTJ4Gh5zs/JEvky+hGUh2wqU=;
 b=aariVpo345Fr2cEOstx4jYrKIz5H6iDE0jDvFV62KrwhUzHhpV+7OgHhvRI8I1ozMJkt+ai0Ym8HtAGFeg+EjBerHA/X6S9Pe2ozM8xuymFsnjx6C7ff5Z/vL9f3CFpNDzMEGsd41Fuv8+vkvQWsM8PA22SAdGuqcnquqmKyTv0=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH7PR19MB7340.namprd19.prod.outlook.com (2603:10b6:510:27b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 4 Aug
 2025 10:17:47 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.9009.003; Mon, 4 Aug 2025
 10:17:46 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
Thread-Topic: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
Thread-Index: AQHb+1O1Ba/9brBA1kOcsMl9osqwDrRCA7yAgBBXpwA=
Date: Mon, 4 Aug 2025 10:17:46 +0000
Message-ID: <23982cdf-6447-4967-8d5a-56f9a7741046@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
 <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
 <CAJnrk1Zn=f9Y0xxgrrVPnuFT+zP3aLeLwbL8gxC5gLsyiJO=MQ@mail.gmail.com>
In-Reply-To:
 <CAJnrk1Zn=f9Y0xxgrrVPnuFT+zP3aLeLwbL8gxC5gLsyiJO=MQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|PH7PR19MB7340:EE_
x-ms-office365-filtering-correlation-id: 98c9ab92-a148-4a4e-2ebe-08ddd3402879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MytsZytLc3lKRXkwZ0JZWExreFBJbjNScjFpaWhZT01Vc1dvdG9DOHR4Y1JU?=
 =?utf-8?B?NDJmc2dXd2ZwVTk5c0EvQUVONXVDWEVNdTZUbmYvMndvT05TWkYyRWJYNWN2?=
 =?utf-8?B?OCs3Zmk3dDVjU0VsbGlweHdWc3FkdEd4Nmx3Ujd3dHRxVks3N0Uza2JGSUZv?=
 =?utf-8?B?anpxUG5rRWRiTktDR3FkcVJ3OXpBZk9uV2kvT1FWVnpvNGJXWVRSU2JvOURy?=
 =?utf-8?B?UzBDVGdhUTk0UzlVWmRRbGlDdm1GVHh4K2h2dGtZS05uUUk5YkJxYU03OEZq?=
 =?utf-8?B?U210VnBLSnpIS3E2a1F3Z0ZIQWl3UWdWZlFncWRsV3Qxakc2SmR6eUlKako3?=
 =?utf-8?B?bzBranVMcU1SVE9jQ2gveHUrQlBWRzhsNy8xV21xTG5hSUF1cHp0dU1xeksx?=
 =?utf-8?B?RkxWbGxoRmlvblFFS2Q1aUpBOHBCNi9WaG9rV3pXRmJGYUtISktKdFY1c2I1?=
 =?utf-8?B?TThFY3RGejVFK1c1UStmWWF3bnU1RStJZkFld0gxTVBEa1VhSk1qa0ExQlM3?=
 =?utf-8?B?c2Nac0dhRGRLZEhjZ1BJcTZEZ2VtbVRGcHptUzF0TDAxNmZsdTk3ZTlmKytX?=
 =?utf-8?B?UW9acXhMUmNRTlJhWjMyV0hDdU9aNnR6Sk0vZTIrbVFnVzR6amdlTFdEVzVN?=
 =?utf-8?B?aDI0bFgzc2krV0xocFZQb1ZWL3FLOTlGVzhUUmY0dEhKcTRycFhyYkRWZjJD?=
 =?utf-8?B?UE12Tm02SE9XSkV5YzNsbnBjbGhQeDNhZFhVYjBnL2c4T2NSZGptWDJIRFFy?=
 =?utf-8?B?K2t2Z2N1b251UHMrcmFvc0RPQ0RtQ1AvekpVVXNpNllYM3dWQ2FwSktRRk5i?=
 =?utf-8?B?UE0wM1VyTjVkQ3loSm40SEVyM29WR3JjWFN1cnNsZlFtRTJIRFJOekFMZW1D?=
 =?utf-8?B?Sjl2eW9ORGV1ejBramlYTUhRQUwrZ0dTWDkzQzZLZUM3S3N2NVFGbndmU1Vz?=
 =?utf-8?B?SzJFejhFVGlCc1ZadExOL1k4bE1QVUFPUVllV1c3MTVsTngzT294SWlTN0hr?=
 =?utf-8?B?V2F3RVVEeDRwMGtNMHRQL0lFVXhLaVhLTFdlZ1NmQkNHV1U2WkNHZDdsN1FY?=
 =?utf-8?B?cWxZZDlzV3k5WitlTGV1cHFhcEFZR2lydEVLbktTWVJnZm4xdXp5YmUzSEJl?=
 =?utf-8?B?dFFOMlZLcXFRQzZOckdxNXVZcnZvVHRaK3lUbkg1OWw4MmJoaCtvaGxTdzdQ?=
 =?utf-8?B?ZzdzRlRkZFNBMDZRNHdwZEFidUNFVFUwbDBnUG54MHJUREhNZkhEclRlb1hr?=
 =?utf-8?B?ekVPaWpHbEI2M2p0M1RhWEpIYXRQRFFzZTYrVTB0R09TaVZTSm5EbG5rSGlm?=
 =?utf-8?B?SlpYK0xqTXgwVTRKMTcrZXZoKzJzazlWc1Q4UkVhYnVUU0JLY28xZ3E1SG9o?=
 =?utf-8?B?SWJMcGxCODl3djZ6WWRoZGs5OVJDVHlZWEtzZFRmR2Nxdkp2RFhWb3Zha3l3?=
 =?utf-8?B?QWdXN0dhczBHSFJOdklCazBaWmtobHBWU2dTNHZubDBaeTJLalRJOG03eGZ6?=
 =?utf-8?B?OHBFMUpWTDdQUmUxUlp3M3F6YlJvQTZMMFlXd1cvMUM1ZERZTm5MY0hVL0gv?=
 =?utf-8?B?c29zTFVCQVNUMWFFL09KaUM0YWQ3TDVKcmxnam5pUDZaMzNtMkV0bzluVngw?=
 =?utf-8?B?TGpITTlrc2tYeHUxVW9GSnorUlRoMkpsNjdnVEdIZlJvczhXdDNwNlc2R0N0?=
 =?utf-8?B?YnV5MG12RmlseU9RTndvbUdOcTRvUHJhcjA1YW4rS3NHNUxldDlXMnlaQkpu?=
 =?utf-8?B?UmQ2eDdoNVM3MnByZ2JTRWhmeG5HVm1xM3VaUmE1Vi9ZOGZ4YnFkTk83aURw?=
 =?utf-8?B?cklvdEZtb1FXWG81c0Z1MklneVowbTk3YW1hSHNaeThWV3VoMkZJaHdyVUNX?=
 =?utf-8?B?UUx0a1dnUkZyNlNkVDZGTXd0MmxJYXZGM1VVMzZSQTV0Um9HaFBBbUx4QWMx?=
 =?utf-8?B?MU1jSFJQcHJIbjFoc2ZRbVpxYzkvTWJLZFMxM1FkNTZIbWdpb2tmN0ZlZkNq?=
 =?utf-8?B?SVIrWW9KbmVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnNrYnlDODU0WGk4VHRpSGh5WFhCanBhRkZvQVRvcDhNR3F4Y3IrTFdUeGZo?=
 =?utf-8?B?Y0VRcjJHRTEvK0VyRkZDblRCQ2RTVGptNVRzcTJTT0RSaFpXbXUvaFdRcnJz?=
 =?utf-8?B?clJQRUd2UjZjRTRYd3lIZW9FTTRsNHBvOG5UMmlodlJvdlJMbGNIaE4yQjJH?=
 =?utf-8?B?K0tKdzM0ZkZtTzJseUpuSHdCNXdtZ2xuWkVWU3p3V0pCeEpBL3ZYQ2JPTnpp?=
 =?utf-8?B?bExjbVc1V25NaFk5V3lpSmpLaGVnb0xqTmdPeUF5c05CVUVveHp4M2RjQ0Na?=
 =?utf-8?B?Zkx4enZKKzVGdFNHdHJ0Z3ZJSnl6cDlqZlNIUit6ZUo4R1hsT2ZjRDNwTEFo?=
 =?utf-8?B?M3I4QnF4c3lTVzUrVkJGNytpQkRnTTM5VVRybm01alJSWkN5dUdLc2xuU1Np?=
 =?utf-8?B?cnhCNzFmRTRYL0hOWkMyQnl3ajBKWE52Z1NJNGM5eFdPRk8zdHVqTVk1MTBk?=
 =?utf-8?B?NEV0SnFHZUNlTGFIQ2lPSnZZUGV4dWtLR29qL3h4K2xYYktCczNYQ2t5SWgz?=
 =?utf-8?B?RG5EYkZaSmdwdWdGZjhVbjVEV0hQSUY1SzZkOE81VDNvSUdML21Qd1dONGhr?=
 =?utf-8?B?bmZQNzh5UHNlOFg4c1YrUWNHUENTZUhqK3ovNEVBWFE5SzZTa2pPcktBS2c4?=
 =?utf-8?B?cndBV2lYTDBJTHlUQkRRdDFHeEVVVG9JTmR6cldOeFp6YitCZ0c4VjRJVUlQ?=
 =?utf-8?B?Y0hMYVZnSi9mMitwblMway9QNitjeFF2MHdYdDRsejNaM3B0UTh2L1NsS2th?=
 =?utf-8?B?b3VRZzBubGZMS1poVE53ZmNubXc4THhVTGVoaTR2V042QWtuNXl0a09jdi9J?=
 =?utf-8?B?T21Vd0pBVDAzQ0x2eFRhbnFnaGtDcGJqTTF2TjV3MHArSjQ0SUNsWVFKcEZa?=
 =?utf-8?B?TVBNckhPVjdWczlWQldBKzJLY2JGemdMQW5wdzJ2VWd2SnhlQU11dW9HazB6?=
 =?utf-8?B?eTlIV1pqNFJhWFFGRDlHM3c2QmRuTFpGODRLT3lwVkVTUFVXMUVDSExYRDZq?=
 =?utf-8?B?YUR4Zk8zcUJFQkZ4TW9EODNhTTRzR1Q5YUt4WXhXQUhWQ0Y3Q0h1dU5wUnM2?=
 =?utf-8?B?MkFhMWpGMDZycGFUYUN6Nm9nL0pMWXM2QmErWVY1bms3a2JkeG1NODBMcnJN?=
 =?utf-8?B?cmtDNk0vQkdHcUdybldyRU4vOTJZcVFLSmFGMWlvdEhUQ0lLRU5GaVg3aVlB?=
 =?utf-8?B?ZHRHdXdmYk9vcWNkM2JVZ3JKNmZCYWZxcndNaUFhNmlzQXdSazZHcVRNTDBy?=
 =?utf-8?B?VWlGenBQWVVoOWJ6RjFDM3ZJNzVnUWpnVnJQdXdhd1Z6Vk9WN0ZOYjd3SzRJ?=
 =?utf-8?B?Q3ROcnZsK29hWWFhc3hvbkNjYmFFcHVVS1ByM1dJTnl4aGd1TmN3bStmRlVV?=
 =?utf-8?B?a1EvTTdVQzc0UGVjdWdiRTVKdDZDdTBZV01zNXpZdldEWEYvUTNWc3NQcGNC?=
 =?utf-8?B?dWxscHhYU282MHI4UWpsUWMzcTFGRzNCOU5DcGFHbWN1WmRoemFoWkNZYWU2?=
 =?utf-8?B?UjBIL3phVHVzbUpDbmJueVBXTnBBNlFmc1ZpR3FHTE1zKzVjRTdzZVQ4OGxn?=
 =?utf-8?B?UDEvUHorS1QwNlg3Z2x3aTlRZ0x0VjNyaU1YSW5ybXU2Y2VsS2ZyMW91ajJ5?=
 =?utf-8?B?SWhPUE9zWitLUTlMWkxjMFhsWGJLMmNqc2ZaV1dacEFaaU4zQ0NaMzlFdTRN?=
 =?utf-8?B?ZUlUWjd2NFdpbzJKR3JJMjZyRi93dlltTVlzZUlBdVlHWWd1Q2trUGp1Mmds?=
 =?utf-8?B?Vzg4dHBneU4vZFJXTHY1b2Q2VzlidkRBMExlWG4vSm96N0lodmdUbmhKVTVp?=
 =?utf-8?B?VXBFUVVvNGhMdCtpWHNCb3l4NlJBV0lWUGVybEYvTmFjUlFnSGY4RG1YNXNS?=
 =?utf-8?B?YmNMbmJkejVEK0s5SS83UHd3Ly9XZUg5WWNFQnR4N1M2cTJCRkV4clR5V2Jj?=
 =?utf-8?B?NUYyN1hVUkhDb3UzaUtIQlZuTEx6c2cybEZ0NHREL0FzdlVqb2xPbEFkTS9a?=
 =?utf-8?B?dWVaN0FGUDhUdS9Gc0VGdEw2SDdPMEtWeVVqWEM1ZG1TNnhSSjVYZTNnbWYy?=
 =?utf-8?B?R2xHSW93VGFLODg4N1F1MWVWcU5BKzJaSzMvbFV0WE54eHg1OWFEZkRMSUdt?=
 =?utf-8?B?RmxGemJld0xibzV0M1NXZ0RPNDFpNDJnTlhRSUwrRG9JUXdLUzZybWNjNDU0?=
 =?utf-8?Q?5t/r0ox/xPv8uQpTphuMMyw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBC8934289EBF34B802C57B81407DDE2@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 5MZ82Xg1E9MaUPep7wAgRtoalsT9gA2DcYASGyP8yT9orFtqp64mZcr88bX0EMXW7/WcL5VvgD2hlbpmhmfx9bFD7ugvF7SFCED3IDUMgkqhwkAvOpPCjb0b3hVGJqW7JXctFg3QONawakdaGvARx2bitAgetqi+ARAIHzgPrIGAITMNtn1asiTi1DbdAgpnQTx+ZiQO/+bfT+4mE2lSoXuA9UY1VIW3SlgtEfrd36IeJNEi/SFqLa/wek12+HEGTodhC16rODAzYqfEAuUtImpNCDAYXTXYavhfvATaTzAICyCvrZPo0ZmPcqg89/JaJAnnlzOahZDL8PsTzKpSwp6EYDHA8v83w7NebwSzfmT7xyUWylR/S5KEPM8kwSGxBXBRGnQ3pP2fyWmnT41PzNDb51AG0uAIEVZQBGAmqhUJR7XulmAea7avMo9KQK708yVV4rgEE31Fl6gA7e9/5hthXXb98CwJ+msximwxfu/+a0N4jKoLFIwByury7OZFSTXs0xfNsxLCnLlP3MM/YMtXobTD9xAZ9BruIJ1MgRL3904UQk7F5Kl3E7dcbCtvFB4pZ3Io0AjiKcONuLeUgMaEFNCjovuPMc88qUZchyebH8ZFiFaMknL9fnOT6H79SfHKJQ3OrGoaGzv8LBSoTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c9ab92-a148-4a4e-2ebe-08ddd3402879
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 10:17:46.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3nHx4L+hyOwyqZtkkyJ+V3wfztIWkzWu6rDZ00w9FgNJgS0zixo4pO8IHc7MpNr488VrCOMqa1xOSQJfi2Arg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7340
X-OriginatorOrg: ddn.com
X-BESS-ID: 1754308269-102757-8508-1021-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.101.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWRmZAVgZQ0MjIMsk8KcnYLN
	HQKMXU2Cw5LcXMINU0ycLA0szE0CBJqTYWAL6KeaJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266535 [from 
	cloudscan21-248.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

SGkgSm9hbm5lLA0KDQp0aGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBzb3JyeSBmb3IgbWUgbGF0
ZSByZXBseS4gSGFkIHNlbnQgb3V0IHRoZQ0Kc2VyaWVzIG5pZ2h0IGJlZm9yZSBnb2luZyBvbiB2
YWNhdGlvbi4NCg0KT24gNy8yNS8yNSAwMjo0MywgSm9hbm5lIEtvb25nIHdyb3RlOg0KPiBPbiBU
dWUsIEp1bCAyMiwgMjAyNSBhdCAyOjU44oCvUE0gQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBk
ZG4uY29tPiB3cm90ZToNCj4+DQo+PiBDdXJyZW50bHksIEZVU0UgaW8tdXJpbmcgcmVxdWlyZXMg
YWxsIHF1ZXVlcyB0byBiZSByZWdpc3RlcmVkIGJlZm9yZQ0KPj4gYmVjb21pbmcgcmVhZHksIHdo
aWNoIGNhbiByZXN1bHQgaW4gdG9vIG11Y2ggbWVtb3J5IHVzYWdlLg0KPj4NCj4+IFRoaXMgcGF0
Y2ggaW50cm9kdWNlcyBhIHN0YXRpYyBxdWV1ZSBtYXBwaW5nIHN5c3RlbSB0aGF0IGFsbG93cyBG
VVNFDQo+PiBpby11cmluZyB0byBvcGVyYXRlIHdpdGggYSByZWR1Y2VkIG51bWJlciBvZiByZWdp
c3RlcmVkIHF1ZXVlcyBieToNCj4+DQo+PiAxLiBBZGRpbmcgYSBxdWV1ZV9tYXBwaW5nIGFycmF5
IHRvIHRyYWNrIHdoaWNoIHJlZ2lzdGVyZWQgcXVldWUgZWFjaA0KPj4gICAgQ1BVIHNob3VsZCB1
c2UNCj4+IDIuIFJlcGxhY2luZyB0aGUgaXNfcmluZ19yZWFkeSgpIGNoZWNrIHdpdGggaW1tZWRp
YXRlIHF1ZXVlIG1hcHBpbmcNCj4+ICAgIG9uY2UgYW55IHF1ZXVlcyBhcmUgcmVnaXN0ZXJlZA0K
Pj4gMy4gSW1wbGVtZW50aW5nIGZ1c2VfdXJpbmdfbWFwX3F1ZXVlcygpIHRvIGNyZWF0ZSBDUFUt
dG8tcXVldWUgbWFwcGluZ3MNCj4+ICAgIHRoYXQgcHJlZmVyIE5VTUEtbG9jYWwgcXVldWVzIHdo
ZW4gYXZhaWxhYmxlDQo+PiA0LiBVcGRhdGluZyBmdXNlX3VyaW5nX2dldF9xdWV1ZSgpIHRvIHVz
ZSB0aGUgc3RhdGljIG1hcHBpbmcgaW5zdGVhZA0KPj4gICAgb2YgZGlyZWN0IENQVS10by1xdWV1
ZSBjb3JyZXNwb25kZW5jZQ0KPj4NCj4+IFRoZSBtYXBwaW5nIHByaW9yaXRpemVzIE5VTUEgbG9j
YWxpdHkgYnkgZmlyc3QgYXR0ZW1wdGluZyB0byBtYXAgQ1BVcw0KPj4gdG8gcXVldWVzIG9uIHRo
ZSBzYW1lIE5VTUEgbm9kZSwgZmFsbGluZyBiYWNrIHRvIGFueSBhdmFpbGFibGUNCj4+IHJlZ2lz
dGVyZWQgcXVldWUgaWYgbm8gbG9jYWwgcXVldWUgZXhpc3RzLg0KPiANCj4gRG8gd2UgbmVlZCBh
IHN0YXRpYyBxdWV1ZSBtYXAgb3IgZG9lcyBpdCBzdWZmaWNlIHRvIGp1c3Qgb3ZlcmxvYWQgYQ0K
PiBxdWV1ZSBvbiB0aGUgbG9jYWwgbm9kZSBpZiB3ZSdyZSBub3QgYWJsZSB0byBmaW5kIGFuICJp
ZGVhbCIgcXVldWUgZm9yDQo+IHRoZSByZXF1ZXN0PyBpdCBzZWVtcyB0byBtZSBsaWtlIGlmIHdl
IGRlZmF1bHQgdG8gdGhhdCBiZWhhdmlvciwgdGhlbg0KPiB3ZSBnZXQgdGhlIGFkdmFudGFnZXMg
dGhlIHN0YXRpYyBxdWV1ZSBtYXAgaXMgdHJ5aW5nIHRvIHByb3ZpZGUgKGVnDQo+IG1hcmtpbmcg
dGhlIHJpbmcgYXMgcmVhZHkgYXMgc29vbiBhcyB0aGUgZmlyc3QgcXVldWUgaXMgcmVnaXN0ZXJl
ZCBhbmQNCj4gZmluZGluZyBhIGxhc3QtcmVzb3J0IHF1ZXVlIGZvciB0aGUgcmVxdWVzdCkgd2l0
aG91dCB0aGUgb3ZlcmhlYWQuDQo+IA0KDQpJIGhhdmUgYSBicmFuY2ggZm9yIHRoYXQsIHRoYXQg
dXNlcyB0aGUgZmlyc3QgYXZhaWxhYmxlIHF1ZXVlIGZyb20NCnRoZSByZWdpc3RlcmVkIHF1ZXVl
IGJpdG1hc2suIEluIHRlc3Rpbmcgd2l0aCBvdXIgZGRuIGZpbGUgc3lzdGVtDQppdCByZXN1bHRl
ZCBpbiB0b28gaW1iYWxhbmNlZCBxdWV1ZSB1c2FnZSBhbmQgSSBoYWQgZ2l2ZW4gdXAgdGhhdA0K
YXBwcm9hY2ggdGhlcmVmb3JlLiBBc3N1bWluZyB0aGUgc2NoZWR1bGVyIGJhbGFuY2VzIHByb2Nl
c3Nlcw0KYmV0d2VlbiBjb3JlcyB0aGUgc3RhdGljIG1hcHBwaW5nIGd1YXJhbnRlZXMgYmFsYW5j
ZWQgcXVldWVzLg0KDQoNClRoYW5rcywNCkJlcm5kDQo=

