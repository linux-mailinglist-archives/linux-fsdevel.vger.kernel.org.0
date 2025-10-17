Return-Path: <linux-fsdevel+bounces-64417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C678DBE7083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4223A2806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CEB26C39E;
	Fri, 17 Oct 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ECQrggFU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IDGSZugx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96159233155;
	Fri, 17 Oct 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688012; cv=fail; b=or8sAUS+v5vX+Iolju/qFq7NiCJwX9QVtqzAeyo5X5F5F52btFAwI8lpR8QrHt1SbLtDyXrr3l6GLGVRmIyaq1UBbOApFp0PWrcyOKHzpM+41rDVsBsbXRhPvBL5aYbDVgPblE2ZCkp0Q15J0NhsFFsWpCgJ4SilE+wu9x/17tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688012; c=relaxed/simple;
	bh=n0bIYUiI+Cy9dV8iIFm1n9f7JAeNJ6P33Q8owc9MJfQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C2gjVDn3mGIY4GQigsSqNatzPRR1rTxb9aU37DTdd7kWLLvmOayngWwz7jUBiA17eiNVfuFkHeh5jIkibWNddMXCOUcf+2krrSk51vJG1hSOotCEslzvEGL61NNvOv6rDh8v9CSPZy2efCcwppBFYJaGkXT7QLLIhF4zq6KYvTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ECQrggFU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IDGSZugx; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760688010; x=1792224010;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=n0bIYUiI+Cy9dV8iIFm1n9f7JAeNJ6P33Q8owc9MJfQ=;
  b=ECQrggFU3juMgSmOnjKAyM9oUIvJiGdwdTbWQCFyY7sptqCdyCBJnFUO
   3Z5yosYcY/Nw7r1l8YYGFJFPXQuJcfTr9b8nGoIKottDfiK22KQYEMKoF
   eqiuWqU3M8Y4TKmnIJS/ky+IpiaBsFe+0cNjvNxuHabb9fts5qGmmpjmY
   /D148RxLuWuaxafS+bFFRcPAn1WKiUxl24aU074izMnU31V54rgay6c9l
   S9Qs/7s2UHDDv46mAsd73ccw1+iVBoshpEvImcCYFOEM46wjVxSZxZl8w
   tIT+wH/fMjc7tO7ICq+BAYze78YEnLcDCgILGtn63YGNMMS/GevO5HO2l
   A==;
X-CSE-ConnectionGUID: SzgsyI21S6KoQtbriS4vMg==
X-CSE-MsgGUID: ga9dvkuYQSWtWj7cPWPQfQ==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="133407614"
Received: from mail-eastusazon11011039.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.39])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 16:00:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1Wh1kK25vzTIlxTkKdNiJ0GRWbXQMNDM0q4psDl243pX9FTjkVHVX92SfSrg8VtSyyM8BC3GFdQsl/Sb+0M01U3ODxEaDx5Y0vUh5X3XIJXrg1vXdzuVTosSWFfvioGr7CtD+zk0aYxHhMFmEyOPxf0eIwNJcVdt29bYjGt97YgYLhVtWVELPw97lwjLI0QHHp34hU/x/2RHiuvwXeSf/qkaTJBCyl7whdqd6ejqtq8NAkdTlcWN//6eB6J2Xw4rezLrRrvNi40pYBfMfne7Dc2yCM+L/ENMhB4Kys6as0yUC3Yl7I92j1qkAq9vD4cld1vHnV1hs9UsAJ0QssvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0bIYUiI+Cy9dV8iIFm1n9f7JAeNJ6P33Q8owc9MJfQ=;
 b=W4SPTJnCEflvdOzbc7WAPoIoTzdKF0P24fw6vU1k/skme5FybGbfVpathVNApWqXshY2kRVb6qm/OBi4tmGbJLgxgop4d6wnWZ0bduUGQ7wVJo/tckHGmoQceX79UsHOFwgbtHbCG6r7oC1L9OsXOdRDeqp2/0DPSEXVFs/zC2TXSD6TsDvIq7ll6zSKmmi17S+BXG3BcCsX5VeuXSvwIUFzAG16ZB7QF7OLsiLolV/oQetuJEJ0+lTthjAIhjWKeYjm9t5OnAa+POldyHxlAmDVC4iBpiU3AunKjB6WD7w91kJgWkOAQg52WOEPzvv9h8shZ6uyDA8zfHLV3XGy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0bIYUiI+Cy9dV8iIFm1n9f7JAeNJ6P33Q8owc9MJfQ=;
 b=IDGSZugxnUTpTovGcvThIr3ibTTi80tDsvWoKlJ0V1fum6pJKJvCwI2iBKh6SBTm+76DUuXPRtoqhPm1LqzCtOM8DzjEmV2YTFkSLHf4GvnnWK1nQ7ivDZNgLUDpdFOdRFQCG+dF1D/00sc+FsJzgqvE4+5Pv0LmWExbquR2Dnw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:00:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:00:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] zloopctl - a small zloop administration utility
Thread-Topic: [ANNOUNCE] zloopctl - a small zloop administration utility
Thread-Index: AQHcPzwKcfJfNkkeT0eJ8BPaFeC49g==
Date: Fri, 17 Oct 2025 08:00:01 +0000
Message-ID: <8c78d32e-ff56-4fc3-8624-3e2a6cff2439@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7122:EE_
x-ms-office365-filtering-correlation-id: edbd6e67-a5ab-4f46-0db9-08de0d532cac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHgvVDlWazMvNE8yVG4xTkpuVC9taHhWbThTZm9OU0VvQi9UREwyZnE1NjhQ?=
 =?utf-8?B?L3lTazh6MkdaT2RLTjNIZlhMWFBwZlhiUU03Tmw1cmQ3RVJyMHM2UjN1bHNw?=
 =?utf-8?B?VGhZMjMwUCswYkIvdVdTUGxiM01wTEQ4bWNpWGJHeXZFSU1kVHZPdzRkYVVY?=
 =?utf-8?B?MHNmakxMVUFhM2VtK0dSbG5vMTdQWS9RUGFFYUY5VTkrY0hZeXNyZ25hRHN5?=
 =?utf-8?B?K2hQeEdRcXZKNngvcU4yMkdBVmMvZjRYbittZTAzajhzcWhnQnYvbnlVdlA2?=
 =?utf-8?B?Y1dvSE9tRWFoaGxUVGJ5ZzBDUjAwZGUyMnZsSmJ0REs5OUdvcWh2d1Rwa21a?=
 =?utf-8?B?SW5tYU10bU5nOE15Mk5OWjRyUDJUV0kxWTI3N0pkbDI1OUJ6SWY5SDhVazBm?=
 =?utf-8?B?eldZb2VBTFpIMFJ5MVU4cWtnWG9JM1d1VVR0YXRuOUdtTU9PS2RYYWNZQmdt?=
 =?utf-8?B?eEllc3VEOFcwcjNpRG81OFZ2VXZnUWQ3ejlzNmNKR2ZUcENNVURHRXRNY3lW?=
 =?utf-8?B?WlREOE5XYTBTK054R3d4aHo1NzZBSUxiOU5LTHg5SGVLRnRZMjhNTU9XTDhB?=
 =?utf-8?B?YmFpcUVldEdiYjdvWmZVQ2lGZGpPbFJCUVovQnN6Z0R0cHN6M0E2YnhWVWpO?=
 =?utf-8?B?OXI0NWVHSHVzMnhZN0ovVFhlQTR2VlpNTld6c1NOb0xrVTMveXp5dkgxdVdL?=
 =?utf-8?B?L1BpbWwxTHNzdTdlT0huUm5UdWxyTG41dnlSZmg3M2VLam9idGc1OU8wVnJJ?=
 =?utf-8?B?cmdTZ2hlVktCVkFKOS9MZnZIN0pyWVhZYVZqVHpBZmp2M2UxL0dna0VXL0dv?=
 =?utf-8?B?cTNqZkYvenNXaW5FYTBnN21QU1VxTXo1Tkc3N1k1czBpY2NnL3dtTFVpdldz?=
 =?utf-8?B?R0k3QlNsVWUrZGhHc0tjWEJKSGtDNlAvTWdKMmI4SkxvUzhBWE5ET282L2ND?=
 =?utf-8?B?UGlWQmpNSkVJMzU1ekxpaUJMb2lkTUlLemljNHZON1RPWm1tczhhRVh6R3Vk?=
 =?utf-8?B?U1NMR2pSU0RKSWRwNmJzK0tjdGxNNUZORFl3aHpielhUSXlkajJucnNQQXFD?=
 =?utf-8?B?OW5yRXRCc0wxZTR0RFBRTHJ4cURuWUt4SXdUTnFyTXEyazlWemVUb2N0UDRJ?=
 =?utf-8?B?YmtmcWp5WnVwZityVFhNYVBrVDgyVU00S29IYUdYa1YwZkV6UGRZK2Q4azll?=
 =?utf-8?B?Mi9oSWlRbUJ2ZEZoMGQ4MlBiZlJZUUxyL0pQQWtPeTBwUktPalRWV2ZScmlN?=
 =?utf-8?B?WUZTcW1EbnJEdWNGc3U2NmpMRlpEZjc1eFVvdUhmaGY1QUFwL0ZpK01sMVd0?=
 =?utf-8?B?OUJVQkpvcWFMNkJDcDA1Y2VGMmNMRnVoQzdtbnp1V2pNTWg4WmVwOUl4eFhm?=
 =?utf-8?B?L3JYZGUvVC9wNjFIRzRNdk8zS3dJZVllcUR1Zk42Y3pvRzV1cTBRWXVXNitw?=
 =?utf-8?B?MHBpTTR6UGZIeDNpKzdUV3ZKa1YvYTlmajloNFcxK1hjWmQxamJ0ZlMvdk1P?=
 =?utf-8?B?aFVoYWVwWlBidTNnQktwbTQwUDdTbnYwWitpcThGUTJrQmZzZFl6czZOSjBR?=
 =?utf-8?B?MVJJMlpRQWhjdnk2WEtMcUZDMjgwQm5qckZPVFpvZUZxc0VQZ2s2SXFreE1Y?=
 =?utf-8?B?VG42a1hIQUtjOURTSzRMRW5YbXora1d0MVhrZGZVMUtmK3hqZGkrdXJ6ODF6?=
 =?utf-8?B?eVFVNWlndjhRUWZ5eVdyQzQyeVVqWmJBN3Q0VUxrWEZPWWZyNWNxcVpvTkIv?=
 =?utf-8?B?QzBiNHQ1RkUvN2xXaU5GUVNOTTZzaTYyOFBwdkUwZnR0YnhwaUsvK1ZWd1cx?=
 =?utf-8?B?bDdUeFdJUmxMQlBucmxTa1RtMC9tSXY4T3AwenR0aXRDd0U4RVA3TEF6NURT?=
 =?utf-8?B?bldyWkQ4UHlEVWNJVG9PUjlvd20wWGI5dG90NmlIN2s5N3JZcVdxblVMcE9X?=
 =?utf-8?B?d3VURkpncjFtNDFDMGYwMEdTRno3M3dlL05ReGg0OVlsdjR1RWFYUC8xL1VI?=
 =?utf-8?B?eVBmbjJOVEpSKzh0cEU2UFN3TG1Rb0NrRjZIKzV1RTl5dzB0VWN2ZkZEQm5Y?=
 =?utf-8?Q?1/EQs2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEl1QlI0ZWFRc1JhUmt4WUlwdWVycXlSRXZJa1NWb1d0cExKdmo1bXhZYnRt?=
 =?utf-8?B?NXVkK2k2VHlBRkY2TTBTQUU2d0pkaUo2T3E3WmtxQjc0djh6dlpjbVFBL1Ax?=
 =?utf-8?B?QjJaUndIa2crTHhRTW5nQmNOamtxOWxRbnpEUU1TTWFuZlN5S1dha0F5S0sz?=
 =?utf-8?B?MDdWRFJNcDRlYVF4QlFTam9ITGNHVXFhY0JLYmExZHZzKzhYdlFQVWc0dGp0?=
 =?utf-8?B?VWk1MmloTUQ1N3loWElGbFU0RW1tOUlqWEZicEtnZ0ZMODlCTnZXYTh0NzBj?=
 =?utf-8?B?QXNTZU9oWmloV1c4b1JtNHRHVEtkKzZlT1lIZE1ZRGJPWDViNmY1Q1haMEcz?=
 =?utf-8?B?T2p3MDllOXNhU1ZDcGlYLy81bTRYSUtEb3dQY0NFckZQMWYvRno3WDVYbXlM?=
 =?utf-8?B?YXRIbW1NOVUzaHE5WENPZUZSS3czTW9uZDZvRnkrU090VlNrc3NKL1ZPbFhK?=
 =?utf-8?B?ZmtJdGNiOFJwNGRheUtVOGQvR0tCaytLUWtNTWJuY2J1VUNlZnN4M0Z5NWNZ?=
 =?utf-8?B?WDF5RGp4L2E1WEUvMWJsQ1JvZ0hMT3J6L1ltVFQ0cS9OMDlrdXlNM2ZtMFk3?=
 =?utf-8?B?Um5vVzNmMWFMMzJ2dmJzai9vT2FqZUc1eFZVV3BVWVlnNWxZdFpLMnBjUXhx?=
 =?utf-8?B?ZkpORVprOWNhdzB4d1ZKam84MjhZUklOanBwcTdTcFg4MkdvdE9HNm4wZGdj?=
 =?utf-8?B?UFh6bDI4MDZxeThCZVZUS0RaUnFVaWttTGk3bnkyaUtkdzdoZFVXY3MyTFdT?=
 =?utf-8?B?RU5xMzVTcHg4dWU1YmNpL1NpRUFyWmtwU1RnT2k1QTRTaGt0ZTl6WVpOWTU1?=
 =?utf-8?B?c3ZyMVpzbDFTaDd6MFdvUVRZVXNRaXNTeFI3dzNqdklkeWZndllOUG40YXJD?=
 =?utf-8?B?c3E2RWdjTm5SclZFcjE1RGhWRFFoNlBBVWxYaXp0VU82c2ltTldFOVZaZTFP?=
 =?utf-8?B?TkJpSTI5SVdpWmNsUmovMVNFaXI4eWRqMTkvUi9RemROZ3ZuL3dKaFZWUVhw?=
 =?utf-8?B?ZXFoSHl6RldhYWF3ZmxGd0Z6T2U1ZnZ0OFZOUEM0V3hQVUFlQ2J0ZVMyc0RU?=
 =?utf-8?B?U3FkdVd5d3NBVDFocVB0QURPWXpaeWhwMmZYcXdMVCsvK0w3VldUUWt6Sk5N?=
 =?utf-8?B?ajBoQlFsYXk0YXNEZHFGR1ByNExleG5ZS1Q5ck5UcUtjTkxEUHJQN2lMUGlP?=
 =?utf-8?B?b1UvVjZnMkhLL043akM1YVBnTldzTkdZSGI0RG1sSEd1c0diZzUyRm9pb0d3?=
 =?utf-8?B?Nmwwa0ZCemE4MjZJTlVwU1dOemlhRTd1VllkMEdlM2pxTDhUZlhncWdhQ2Yv?=
 =?utf-8?B?b1A5d0thYzRocFBVWGR3MUVYbGtjdjNEYmxTTjVkcUwzK1pFUUk2V01HK0J4?=
 =?utf-8?B?djdPMTN6WTc4cXI1OThnWTB2Z3BZR0svUkhiY0xObHEzOVZ0b1ZwL1IwSTdZ?=
 =?utf-8?B?R2IzMEhNd3VpbXpRd2FIemhBM0k0SUt2K254K0dudzlaL1FFVFV3dDI1UHRq?=
 =?utf-8?B?em1DdGdWdVMvaXZ5VEh0VWdTWmhqamNmTkFaK0hqQmxUZkJ2RUZrRDZmWU5q?=
 =?utf-8?B?cHJqdUlIc0dXYVZTSitJbXQrT1FFTHN5SU9VdERtckhncmUvY0t5VUgwMWZZ?=
 =?utf-8?B?ZG0vVWJhMkVyQVkwek5qbnRlV2ZLTCtPYVVVcTJxbzVCaitCUlRZZFFPMkds?=
 =?utf-8?B?ajQzUUhwbDVwalU1TmZqVVE2S2RJOXBXSFRPbUo4MlZiTzcvZHV1bzA5NmJa?=
 =?utf-8?B?anBjeGtINXY0UzhjTVZBWm9TaHdGdXhpOGVYU3ZpaFJZTFdRU3lZNHhHSDJK?=
 =?utf-8?B?eTRtOHhkUDAvTzRLUWZ1bnkrRE16THlJV3E3YldJVUZzZEx1TitGZEg5T3JC?=
 =?utf-8?B?TWkxZnZ2dFFiU0d1ZTVWQm9USFVlellkOHJzUk5sRW9LT1BCTkJBdCs4aG43?=
 =?utf-8?B?Q2JxNE80S3dONGRrUUppNmc1TEV0WFlxRGFyUU5Mc0ZPdXNNVjZqRDcvdXA2?=
 =?utf-8?B?R0RmN3BsdC8rZiswem5sV013bDRQSmNhUUZwcjZLUXRzTHMxU1ljOUx5b0RT?=
 =?utf-8?B?cjJmb3J6V2pkb1FnTmt5WU5telIzeUthclN4VEpGY0tKU3RORmdCSE5GOGZU?=
 =?utf-8?B?RFpKWENLbEgvRWxGRklsV2xNMEdkTTlTRU5MWEtTaUJxdVBpYUZOcW9YRjdX?=
 =?utf-8?B?cU53VTBHNGl3RnJKam5nZ0g1clk1bDFlaEw1Tk1SNjRYSzdpOWJlR2JOUjNH?=
 =?utf-8?B?Y3B2eEdUaE9KaTl5MHRVSVdrT2ZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BC8B90CA3B81C4BB7FEC2ED20200851@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eJ3F7J+6rC28zZ9Ata1aBU5p1H4JxOjfQiQiaMsW1JfJHUQQ+arjDnsdwdON8wDMhcmZZNiLPmUMI+5yO/WTnv0CLJKGNfemGGW6UNOfEG8t9FsA+VdmbeBSEDPj60YWzAMmxaOKFAe6LxnSCU/ZFUFk8hD3c/iGknkle2a7c2hoKX5+m9mKVpaFsUJL6s/s/SF/aH6FTzyUgBpheYL0uNgPaGYgar9z58dcqaD6K/Ut8RcN2KuvX4QnJYIkPeaEPcQV8hXcjgZlor/2XLgwjwQAZAKz5xXnSg3u6P5fl3QIhjTQHVMFsRumxomXZlse+L4T4imP55LkenwzAB522eatKTvGWtutR3XmqliaT35osPlfifmiRy52g4iAmESUV8++RfXvjQyPeMZsbPLwnOCzapNqhRMFSsDU7kpPCxjc8yAXGOMlCxnXJ1wM52+UzY6X/z79/F0ispyrWfmYtsfa0yLH3Rycat/nfAVEdoti6L+F/ynBKRi5WxKapc3tqa2kYS3b9twRxW9/lkDmDd8ecGo/alh/JCRAOCTNo03LFkBaqNh4MQVP5CSCWD9pMs62+WyygQmGPm1gDYZJD8oEAEkTk+qDzQwIj13r2kwdfC47ojBdaxTZwU4Nof0R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbd6e67-a5ab-4f46-0db9-08de0d532cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 08:00:01.5602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg7jPI+6B7tCrvcAiUFrLwBlM9IV/c0CAJ3ir/XXz1O/bDF/AQqVGp0XIwww/Ea1DgI0GMCBj+4ah7UdcZPuu1laQiK2+1E+5GqGZtmQYds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122

SGkgYWxsLA0KDQpJJ3ZlIGhhY2tlZCB0b2dldGhlciBhIHNtYWxsIHV0aWxpdHkgb24gdGhlIHNw
aXJpdCBvZiBsb3NldHVwKDgpIGZvciANCmFkbWluaXN0ZXJpbmcgemxvb3AgZGV2aWNlcy4gSSd2
ZSBkb25lIHRoaXMgYmVjYXVzZSBJIGZlbHQgdGhlcmUncyBhIA0KbmVlZCBmb3Igc29tZXRoaW5n
IGEgYml0IG1vcmUgdXNlciBmcmllbmRseSB0aGFuICdlY2hvICRBTExfTVlfQVJHUyA+PiANCi9k
ZXYvemxvb3AtY29udHJvbCcuIFRoYXQgb2YgY291cnNlIG1lYW5zIHlvdSBjYW4gc3RpbGwgdXNl
IGVjaG8gaW4gDQpwcm9qZWN0cyBsaWtlIGJsa3Rlc3RzIG9mIGZzdGVzdHMsIHRvIG5vdCBjcmVh
dGUgYW55IGRlcGVuZGVuY2llcyBvbiANCmZvcmVpZ24gcHJvamVjdHMuDQoNCg0KVGhlIHByb2pl
Y3Qgd2FzIHN0YXJ0ZWQgdG8gbG93ZXIgdGhlIGVudHJ5IGJhcnJpZXIgaW50byB1c2luZyB6bG9v
cCANCmRldmljZXMgZm9yIHRlc3RpbmcgZmlsZXN5c3RlbXMgYW5kL29yIHVzZXItc3BhY2UgdG9v
bHMgb3BlcmF0aW5nIG9uIA0Kem9uZWQgYmxvY2sgZGV2aWNlcy4NCg0KUGxlYXNlIGZpbmQgdGhl
IHNvdXJjZSBoZXJlOg0KDQpodHRwczovL2dpdGh1Yi5jb20vbW9yYmlkcnNhL3psb29wY3RsDQoN
ClB1bGwtcmVxdWVzdCAob3IgcGF0Y2hlcykgd2VsY29tZS4NCg0KQW5kIHllcyB0aGlzIGlzIHdy
aXR0ZW4gaW4gUnVzdCBhbmQgY291bGQndmUgYmVlbiBiYXNoLCBJIGtub3cuDQoNCkJ5dGUsDQoN
CiDCoCDCoCBKb2hhbm5lcw0KDQo=

