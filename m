Return-Path: <linux-fsdevel+bounces-40026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F2A1B186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB673AAE6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CBC218AD6;
	Fri, 24 Jan 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e6A3JM3Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sWxSGTi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DB218AA2;
	Fri, 24 Jan 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706805; cv=fail; b=qiwAZtWeGct6tGgJf3cAmaxUG2qYB+hBrumy4KAjeh80HGp6izVLDEo/mM1GrEpUJPVoLQ2tRK/jZJc2As/9Ph0sgYZb8HV8MncR9GS+A69i24YRUgJ4d/8SQhAoHCZiX+TY6OMp2nklCc9UpZBr6lR7aIKB8ox7l4tZKtgxnb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706805; c=relaxed/simple;
	bh=mp7P5WaNqb/xuLtv0UreBdvXLBcjmJkbhkg67r1jKZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=taFkcdvubotZTHqUfk0Bky3zdYxAMADawnmEJYPRfDdc9OdRutcYzS5CtETyFe9H+lKWR8rKSGiFJZFhMZUcLCV82KPLQiRNKYbjDwDEbqT92dpQ1aO4iOqvAVdUVo8mKSRtqWbeef7k9c5u/nu3ogbnFbdKymzXb9M5kf3sf8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e6A3JM3Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sWxSGTi3; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737706803; x=1769242803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mp7P5WaNqb/xuLtv0UreBdvXLBcjmJkbhkg67r1jKZQ=;
  b=e6A3JM3Qi7KCpfprcF7pgFkpp+vNNGfh1/h2slTeNHGcW93kgCAImraF
   EwUcE4ia5lVz5LWO4XbnAWIfCM1kKQC+7sEpiaC7sK6WRrD2TclXpo625
   DG98mmKZ/K3PKjOEpIVrjX2PaLEOPuJZWTXi+zF5IMnOXwat4QW/4xhWA
   hjHE6ERvaZ3ClI9YerN0Wp8i4wydWYn4JQlEJKEjZ7ZExKtTdBN5nBhrd
   yDQzgApL7eW1mQSLTAFEEE/8UI6ncKJ2oOSJqxdQojRZQGra3rU6cpS4P
   hSlJpvvFsSRExzBodk7HrGmh/D5Y6uN8pNhuuE11dLTa2I2p0xoY6KrLK
   Q==;
X-CSE-ConnectionGUID: 9t3JSsa0Qb+QdT10G/Zg5w==
X-CSE-MsgGUID: zq7EWtqhTueA6lODipdx6Q==
X-IronPort-AV: E=Sophos;i="6.13,230,1732550400"; 
   d="scan'208";a="36468614"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2025 16:20:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+gEBhD9yTmnykEL3kaHP6TB6l8dA2HNeO+5O7cZGkJOLMHW3IG8mXrT6dZYqYrkITfrJHPBmMU/AqgFA5rPnGei0fzxFYlCAx89Wy6VmbX9QX3Dk4Ol55vc7itoIFRR42hZPy5OKmrJzrhXmHnt8nyjOPjSNseA2GWyPsSL71nesWd/2uGeFzx1fUbtAoEq3pvIdmtbXlS/1I3pc9AJySmfi0P23DjZpGqsPEyOwOIxyYa2j9DBaDczgo0zU71N+5bndoRPbWICuhsUMHVkCMy7l+XD2fqcEoc0Mkp43Xqgl/syizoWnzOgTPa/TUPjWictFqqSpCnSJ1oFT6qGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp7P5WaNqb/xuLtv0UreBdvXLBcjmJkbhkg67r1jKZQ=;
 b=fr78T0gSZ4Ry/GBY3qO8K9QutPa7WXW8s42vQhvfG9oi0Gwf9WpPnHRIv7N+ivQVCfduWTJm95hJ7TWoPLzV6aOE2Ll1uWn1HtV+28SRBOVqW+4yOxXP/LcwaSl+sLfJIyb9UgnTEe073SDJcn6Z94zEd3hBVhAeMDHCHFMNhQ2xcXDJS7F7VTEnIckA2uL7g/OmtfWzaheJzC4w552oF/RKkjDIg3NfK3tC7GMb54c0WAbbx8UrdqVANPrBDdeyItZJWnFPIcaUXTWSNDYT3V1ZhgQZ1n+7M3SbaRqcvry3Z3z8dPnfy7SANzjOK2cQTHWZrveahsHviHNmKQH2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp7P5WaNqb/xuLtv0UreBdvXLBcjmJkbhkg67r1jKZQ=;
 b=sWxSGTi3xRuY5F1oz/yjmcK7rYk1G6luZRyZuMuvs7el4p8zNBVfeHdB3is0GNhzbRpa8Hss7D+siQ8hT4cqht07+tq4ucq7LmWoCd+Heiu+iNqh4tm5BNwliVywk9kgAbOtIGTEgdf3Tgbj09QK3ZLRU1NdTqsQgpE49sn0woI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8945.namprd04.prod.outlook.com (2603:10b6:510:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Fri, 24 Jan
 2025 08:19:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 08:19:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>, "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation
 framework
Thread-Topic: [RFC PATCH] Introduce generalized data temperature estimation
 framework
Thread-Index: AQHbbdWqn1HCzX8OPE6FHTiztjVarrMlldaA
Date: Fri, 24 Jan 2025 08:19:58 +0000
Message-ID: <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
In-Reply-To: <20250123202455.11338-1-slava@dubeyko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8945:EE_
x-ms-office365-filtering-correlation-id: 9bc69c62-f988-40c9-af19-08dd3c4fe414
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mnkxa2xWeDBzSUMwUmVtalR3ckRxaEN6dzZRdzRucU9YeXQrT1ZLcWxpUWVq?=
 =?utf-8?B?VktOZzRWNGhaenZWTU5pMG1qNFp1TXRVWlZrY0t4Nmc3YW5PUkdPb0poakJh?=
 =?utf-8?B?dXRPTDlQNHR4WCtRbkNmNnFJQk00OHJUQW8wam1GNG9ReE0wbndSaUxrNkg0?=
 =?utf-8?B?OTZEcUh5UDE5NzY4bXNmcXBuMSs5RU5Ud3pDY21US3dTSFY1M2dMRjNjT1RW?=
 =?utf-8?B?UitqOG9Ja1dHNktpcUwrRnZCVXJzM2t1dENhbzlqd2J5dGc0dFVyeTRmRzRv?=
 =?utf-8?B?SlFJZFFsbU9EQ3puK3VqS0didWVHUElHSlVtc1RGR2YzcVF3azF6ZGI3Snhh?=
 =?utf-8?B?OG9BTDJ2cU1nMDlBSmVxRXlpKzRiK0tyY0VGYmlyQjcrWWU3cW9GOExYMm05?=
 =?utf-8?B?STM2Y2JEOVdKNDYwVjJpajVEYzI1YXh5TzErSjQzci8xS1VsMUxwUGhiaXp2?=
 =?utf-8?B?ckpRYVVEYmlSeVFWZ3ljQlpCT25kSlVFdWpmdlVVcDluTnZNZ3hXc3Mza3Fx?=
 =?utf-8?B?YXRrT1g1ZEdqek1NcTlUd0ZXUThWZktEWHRVSCtzTzM0UWwybUJiMFVxQTlD?=
 =?utf-8?B?QnMxYkhSNDFCbDlGdTMxR2YwbFkvYjV4cDlRbWhtN1JmajVOWU9qMnZ1cGR5?=
 =?utf-8?B?ODhPSnNNOFNmZHR6dW1UMUdhQlAyRVQrZzRYSVZ2aWQ2akRISDN5eU5keXZH?=
 =?utf-8?B?bUxIdHpNUVJITVVrWTA3RDlkRHZwU004eDdmMWpsMlRSWE5zZVE5bWtTcWxV?=
 =?utf-8?B?dGQvNUMrN1FIYk1BVWlXeERBK1FwZVVoZ2U2bURzdHVZZy9sNDNDUmlpMEhK?=
 =?utf-8?B?RHFJVkNNYmVqS2tsOFNzcjNKMHJBVnIvRWRtR3REZmZhQ0JPcnFpdHNVenZ1?=
 =?utf-8?B?K0dyRGdaWldLdHYwSUtwK2piRW95Vk9CWVZDSVRIbGJHNjNyb090eUNQbWpw?=
 =?utf-8?B?a2xTdGpoZ2tVdGhxZWZndlV0RERjS1B6a1lUb3JLaW5VamdqeXFHY3VDdlJv?=
 =?utf-8?B?STE4L1NBL0ZlK2d2c0lYQ0k0VGJ5Z1FEK0tUS3Fxc3huNndSckEwZ3gyQ29n?=
 =?utf-8?B?QTc3cEk3c3ZNVHozL3lZMzh1bEhucVo2dUJGWnd3RWJ5SUVtYTNMREpNb0RX?=
 =?utf-8?B?SWZnc0ljVmZTeEZpYlVkWnlhSTJkNW5sbDJhVTNvVitHMmVTZDlEV1VwMXFn?=
 =?utf-8?B?NjRiblA5dlMxNmpZQUYzQUFXRlVCd3o0dHJDTDgwUkpHOTlSd0tCSnNFeGNJ?=
 =?utf-8?B?MWVpc0tkcnFIbnJpY0tjaFR2YnpWVFplR3RIWHduTG40Vm9UZWNiemdYdEtu?=
 =?utf-8?B?TzExdWNuWXBReVhDdGlDWlM1OC92S2VVU1FXRmxVbTZBQnY4RE93YXNTNlBk?=
 =?utf-8?B?WTlPZEFNREh1WWdQdFhvTGFERFg1dWthWGM5RmxVdDh4bnVuenlqcVNZR2Va?=
 =?utf-8?B?WDk1cTFUenduRDVEaExZL2pXaGEzck5mN3VlSlQxS2VaaktjNy9WYURncFBJ?=
 =?utf-8?B?amFlb0ZzUzlBK1VmS0p0NWZocjlKdlhEb3RPMUprK25BQTdCZ3pKYlZuajFQ?=
 =?utf-8?B?NlVpWktOVTdEOW02N1V6OHVxMGdXRzVYdDZjS0d3U0FyOHYxTTZaK3ZBMU5W?=
 =?utf-8?B?RU1iaC9VRkxiWEJTb0FsUVU1WG1NWHBwclRyWlNVWjhtT3RQZjhPckkyZnFp?=
 =?utf-8?B?OFBNU0hqbVpqZGVNcFhwdXI5SkRUdVRJWkpNakRSMjRhRnNCNUo5UDV3YklF?=
 =?utf-8?B?bTRLZjM2WnNlMWorVnRSK3B0K2JMTkNqYlVMTUFGcG5qeXZMYnZqNXlUTHhi?=
 =?utf-8?B?V3JzZWRteWJtelFVbDFJVmtDV21MNHRHb29oeFIvN0dmWFkrVHpDVVk1QTZs?=
 =?utf-8?B?SU45d1hneG1YRloyaFRRdHVzYzJrWmFhSks1WkJTbC9aa1RBMFpUODNjaVQz?=
 =?utf-8?Q?tKFn38dTpsj2MHCvYRSRORMy2gu5mINX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODhjcHdqU3cvdUl0Q1Rja1FUend6VzFwS1FXODMrNVNpSCtmY0c4L3VWQTMr?=
 =?utf-8?B?QXZTdTJMemMvTVplYjBDaUdBa2NzdTNZWXlPSHFwMGpWMDZJc2ZZanZVL29i?=
 =?utf-8?B?STUvT2RuTFhUd2QvbFlrQnUvNDNsTllaejN3bDg4VjBVci9MbHhUR2ZuSWU2?=
 =?utf-8?B?bnN3QTNiVUhjelZoK2ZxRmVVODZCakJYaGdrRkJzcjJETkllNm9UU2ZaWHpx?=
 =?utf-8?B?MXAxS08zN3c1U1B4b1Y4TW9IeEgza0JmWU8vem1pcVh4cWNGR1Y4MXE2cThj?=
 =?utf-8?B?WEpDWVJ4YVp4NFBQVERiZDNYZ3g4bnpvcE9TS2h5eHJPWnBNdkFESUV2UlN6?=
 =?utf-8?B?cmVzajBxR1h0UnpTZlBSVFpVQkpIcXFjZEoydDg4YjBiYVpteUlIUFhEY1V1?=
 =?utf-8?B?aHFscG9EWkk0UkJiRVdsdURkVnJPbkF1UWxDMUNGbWk1WTNoY1JiWVk0UVFm?=
 =?utf-8?B?WmpQeXZDUVRqZlQxaUhXdW52cVdnUjJEU2Y1Q0JjTHpPamxVWFd4cVR3SzA3?=
 =?utf-8?B?cW12WStQeGt2aU9NVXBEeHhrMWFwYlpHblVxYitlVW1JSjdOY3VWOGlUV3pK?=
 =?utf-8?B?Ti9rZ25JNVBGSysrWXVSL05FWHBHKzdDaEthZDNLNy9wNzVteWxTUkF4OGow?=
 =?utf-8?B?KzBacEdUbUMzYldlR3I3aUwwZndrRSt4UlJkdTA2VlVXS05PQ2xoNHFmbUk1?=
 =?utf-8?B?ZHlBR1QwbGE3NEJBYjhidlNod1hiWTRvNVNnL3MrMHh6ZjBic2dIZGhKTzJr?=
 =?utf-8?B?ZWxGYUdoSFdEYjBtTnBTR29aOGhtaU1XbHpVOEgwRUVyQ1pQWTNORUJ2R1Rm?=
 =?utf-8?B?djNLR1doUENicEp5SmZaQ0VDUzRFWU56MWQzRnRmaWMyMk9helR5TlZTYVBQ?=
 =?utf-8?B?K3RHMy9EVHBFNXZTdCtZcnZ2anFqdnhtUFNxVEgyVndmNElTVnkvNVVWQi9F?=
 =?utf-8?B?OUFFYkFIUTZqU05mR3N0M3VkZHdLUis2SUIrTjZ5WjhPcmxWVEl3ZVBHNE1I?=
 =?utf-8?B?V25JanNLT2pkWHFscUJ1Zzl0UUpGdEJlVFpQcWhNSFBzZ0JFYk5PNVE3UDgx?=
 =?utf-8?B?REhtUTNkQjNrdytZQ0VYM2xseXpZdWRzbGk0aFFiZ0VRVGF3aktTSGVwZ2Fh?=
 =?utf-8?B?K1RuVFFxNVdKK1c1REp5bFdMRkNoMTluM1Q1SzFQU2dQZEZzMk1mMVg3THpG?=
 =?utf-8?B?Nmc3enJqdmpGaXBMaDNtS1NaV0hyUVE0SHlyMnFEUWhhWkFlYyt2dGpCNFZO?=
 =?utf-8?B?dWdUM1NWSmVsOHhsTFlSOFdmOGl0ZkxFVTJ0VGZsbkF2c1cyaTg3Z1FWUnQx?=
 =?utf-8?B?elhnQ0dwUFB0NTNHWmo4N0NFNkVIQXVZSWJ6VU1FNlZrTm1ETDBhSGh6NFFa?=
 =?utf-8?B?bms4U09Fd2xZRzFuOG1ESXJCVENFdUNiMXEvRHB3c3NqQjB2VGc4WHVSTjJE?=
 =?utf-8?B?QUxoZkgySnFPSzh2YzAxZW5tb2liS1h5WGlvRlV4SjY5L0JWb2ZkbXgzKzdZ?=
 =?utf-8?B?dnR6QjBicGk3b0k2bHgvZkRqNW9yZFQ1Rk0yREEzVXNEdHdrekxyLzVrTHJq?=
 =?utf-8?B?aVNRQzJ5M3dBbWRZendMWHlRcFA4NEhweEg3Q1NocGM0dVhSK2ZwSGdXeDdw?=
 =?utf-8?B?QTR1bW5mbmsyN3ZoYVpRa0ZzQWQzeXFhZFNocC9xYjdLcnRxZkJQbWJ0OVYw?=
 =?utf-8?B?RVJOcmFORlpDaUhjWTJuc1ZPNzd3Rmo1TnRHVVVDQ1hHS2lXc0hEMmp2MTRH?=
 =?utf-8?B?enFFV2xLUDlrdkdkYzRDdG9mUFVwSHpvbFFJYzhRaHlkT2Z4bmdlSlprbmdj?=
 =?utf-8?B?cnY1ZVFOUm50ZHdvTUFWSTMxR1BJUUIvalJJaGYrMEZsY3hoZG1MSWp4ampo?=
 =?utf-8?B?Q0N2VnlJdiszSldoZ2kvYWFtN1dSZ2ZxNHhiNng0SFZpbWpJMGZxa0YzWGc4?=
 =?utf-8?B?WU5JUU1reWVtRGtOcWl4ZU5id2kvS0Z2cVlmK2hSc29SMTJZblNoQ0JVUW5w?=
 =?utf-8?B?S2VHL0FIdzM2NjZxd092Qkl6R2tZLzBsYzFTRlUxaHBQZHRGNlRKd3ZpL2NG?=
 =?utf-8?B?b3BkL00vL2pjeDk3bHR3Y0RadHgzNk84QlNSMklGY2tuWS9jeWhiT1RuYWR1?=
 =?utf-8?B?a3M4UEx2a2wrS09uQnhiQTRwVktjU3dMeVVCNk4wOXlRSjAzM1k4a0lyUXVp?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59D44A427034454D8CAE603CECA01B38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RVcsQNyPZ0zMHCOaVKrklkLKfnyDKghkr0Am45I9gGs8K/KgvmfYavt91GZhKRZkAp7xYogpD3LFvWiuJb6H53j8lnBVOtphQ0+DdNh8Mo46ELGZQqyENsi/hIhT3Ale8+ZHPz7OEU2wxHzQVPcaJJBru/Qhcr2TbrxqRS72hGH2ZgZJ1R3erA48Wy603zyjqvaHmDtPm7LwBqk5dlvqeCyAmjWAMyuZHLS4BI47dYauW3meVJ+SS0t/WCAFA381PiO5CYLbZBxWo12dnabznDMRMgyEERIRhl1/9mWccxZ6mtHygDWYgMgrXF9Yt0lCS9DFrwva15+Mcmuew/m6A7jeZvuUn6owtkYLtGzrxzv0aCXtoVoW4pANdgH+rPnh7NotZ3aDqAa4jPiVxyaJWf6kiBsLCkIM1WKBWZH1S74EFaS+7vbe/gWAm2GXOQEMR+x3IIOyu9PL+Lk6VrwljcoBr5RsFhXxFBBmPhmd40uFo9OyE6BhTGLst9+YLilmuDW0w7RdOutSVUAyJGtVwYimDSy7RR3I8zEJ0Ediz8f8JNQyobKLkyvztjw1RuqT+LQ0Y70ajrnVRIMYBhCbVMPIiY0Y0GnVcpZ7rMOa/ohmmMHg1zPASmCxsP6rS9kp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc69c62-f988-40c9-af19-08dd3c4fe414
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 08:19:58.2951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VEXEdc5MU9b7CgHyAWKgXuPA8uwobvyMnixBt1kroj8xB8DbI0KKB9yTcnmYAzDFRu7JgQu+DkX2vB33nWicgqCgHpG4pVseaaTF4WfjYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8945

T24gMjMuMDEuMjUgMjE6MzAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gW1BST0JMRU0g
REVDTEFSQVRJT05dDQo+IEVmZmljaWVudCBkYXRhIHBsYWNlbWVudCBwb2xpY3kgaXMgYSBIb2x5
IEdyYWlsIGZvciBkYXRhDQo+IHN0b3JhZ2UgYW5kIGZpbGUgc3lzdGVtIGVuZ2luZWVycy4gQWNo
aWV2aW5nIHRoaXMgZ29hbCBpcw0KPiBlcXVhbGx5IGltcG9ydGFudCBhbmQgcmVhbGx5IGhhcmQu
IE11bHRpcGxlIGRhdGEgc3RvcmFnZQ0KPiBhbmQgZmlsZSBzeXN0ZW0gdGVjaG5vbG9naWVzIGhh
dmUgYmVlbiBpbnZlbnRlZCB0byBtYW5hZ2UNCj4gdGhlIGRhdGEgcGxhY2VtZW50IHBvbGljeSAo
Zm9yIGV4YW1wbGUsIENPVywgWk5TLCBGRFAsIGV0YykuDQo+IEJ1dCB0aGVzZSB0ZWNobm9sb2dp
ZXMgc3RpbGwgcmVxdWlyZSB0aGUgaGludHMgcmVsYXRlZCB0bw0KPiBuYXR1cmUgb2YgZGF0YSBm
cm9tIGFwcGxpY2F0aW9uIHNpZGUuDQo+IA0KPiBbREFUQSAiVEVNUEVSQVRVUkUiIENPTkNFUFRd
DQo+IE9uZSBvZiB0aGUgd2lkZWx5IHVzZWQgYW5kIGludHVpdGl2ZWx5IGNsZWFyIGlkZWEgb2Yg
ZGF0YQ0KPiBuYXR1cmUgZGVmaW5pdGlvbiBpcyBkYXRhICJ0ZW1wZXJhdHVyZSIgKGNvbGQsIHdh
cm0sDQo+IGhvdCBkYXRhKS4gSG93ZXZlciwgZGF0YSAidGVtcGVyYXR1cmUiIGlzIGFzIGludHVp
dGl2ZWx5DQo+IHNvdW5kIGFzIGlsbHVzaXZlIGRlZmluaXRpb24gb2YgZGF0YSBuYXR1cmUuIEdl
bmVyYWxseQ0KPiBzcGVha2luZywgdGhlcm1vZHluYW1pY3MgZGVmaW5lcyB0ZW1wZXJhdHVyZSBh
cyBhIHdheQ0KPiB0byBlc3RpbWF0ZSB0aGUgYXZlcmFnZSBraW5ldGljIGVuZXJneSBvZiB2aWJy
YXRpbmcNCj4gYXRvbXMgaW4gYSBzdWJzdGFuY2UuIEJ1dCB3ZSBjYW5ub3Qgc2VlIGEgZGlyZWN0
IGFuYWxvZ3kNCj4gYmV0d2VlbiBkYXRhICJ0ZW1wZXJhdHVyZSIgYW5kIHRlbXBlcmF0dXJlIGlu
IHBoeXNpY3MNCj4gYmVjYXVzZSBkYXRhIGlzIG5vdCBzb21ldGhpbmcgdGhhdCBoYXMga2luZXRp
YyBlbmVyZ3kuDQo+IA0KPiBbV0hBVCBJUyBHRU5FUkFMSVpFRCBEQVRBICJURU1QRVJBVFVSRSIg
RVNUSU1BVElPTl0NCj4gV2UgdXN1YWxseSBpbXBseSB0aGF0IGlmIHNvbWUgZGF0YSBpcyB1cGRh
dGVkIG1vcmUNCj4gZnJlcXVlbnRseSwgdGhlbiBzdWNoIGRhdGEgaXMgbW9yZSBob3QgdGhhbiBv
dGhlciBvbmUuDQo+IEJ1dCwgaXQgaXMgcG9zc2libGUgdG8gc2VlIHNldmVyYWwgcHJvYmxlbXMg
aGVyZToNCj4gKDEpIEhvdyBjYW4gd2UgZXN0aW1hdGUgdGhlIGRhdGEgImhvdG5lc3MiIGluDQo+
IHF1YW50aXRhdGl2ZSB3YXk/ICgyKSBXZSBjYW4gc3RhdGUgdGhhdCBkYXRhIGlzICJob3QiDQo+
IGFmdGVyIHNvbWUgbnVtYmVyIG9mIHVwZGF0ZXMuIEl0IG1lYW5zIHRoYXQgdGhpcw0KPiBkZWZp
bml0aW9uIGltcGxpZXMgc3RhdGUgb2YgdGhlIGRhdGEgaW4gdGhlIHBhc3QuDQo+IFdpbGwgdGhp
cyBkYXRhIGNvbnRpbnVlIHRvIGJlICJob3QiIGluIHRoZSBmdXR1cmU/DQo+IEdlbmVyYWxseSBz
cGVha2luZywgdGhlIGNydWNpYWwgcHJvYmxlbSBpcyBob3cgdG8gZGVmaW5lDQo+IHRoZSBkYXRh
IG5hdHVyZSBvciBkYXRhICJ0ZW1wZXJhdHVyZSIgaW4gdGhlIGZ1dHVyZS4NCj4gQmVjYXVzZSwg
dGhpcyBrbm93bGVkZ2UgaXMgdGhlIGZ1bmRhbWVudGFsIGJhc2lzIGZvcg0KPiBlbGFib3JhdGlv
biBhbiBlZmZpY2llbnQgZGF0YSBwbGFjZW1lbnQgcG9saWN5Lg0KPiBHZW5lcmFsaXplZCBkYXRh
ICJ0ZW1wZXJhdHVyZSIgZXN0aW1hdGlvbiBmcmFtZXdvcmsNCj4gc3VnZ2VzdHMgdGhlIHdheSB0
byBkZWZpbmUgYSBmdXR1cmUgc3RhdGUgb2YgdGhlIGRhdGENCj4gYW5kIHRoZSBiYXNpcyBmb3Ig
cXVhbnRpdGF0aXZlIG1lYXN1cmVtZW50IG9mIGRhdGENCj4gInRlbXBlcmF0dXJlIi4NCj4gDQo+
IFtBUkNISVRFQ1RVUkUgT0YgRlJBTUVXT1JLXQ0KPiBVc3VhbGx5LCBmaWxlIHN5c3RlbSBoYXMg
YSBwYWdlIGNhY2hlIGZvciBldmVyeSBpbm9kZS4gQW5kDQo+IGluaXRpYWxseSBtZW1vcnkgcGFn
ZXMgYmVjb21lIGRpcnR5IGluIHBhZ2UgY2FjaGUuIEZpbmFsbHksDQo+IGRpcnR5IHBhZ2VzIHdp
bGwgYmUgc2VudCB0byBzdG9yYWdlIGRldmljZS4gVGVjaG5pY2FsbHkNCj4gc3BlYWtpbmcsIHRo
ZSBudW1iZXIgb2YgZGlydHkgcGFnZXMgaW4gYSBwYXJ0aWN1bGFyIHBhZ2UNCj4gY2FjaGUgaXMg
dGhlIHF1YW50aXRhdGl2ZSBtZWFzdXJlbWVudCBvZiBjdXJyZW50ICJob3RuZXNzIg0KPiBvZiBh
IGZpbGUuIEJ1dCBudW1iZXIgb2YgZGlydHkgcGFnZXMgaXMgc3RpbGwgbm90IHN0YWJsZQ0KPiBi
YXNpcyBmb3IgcXVhbnRpdGF0aXZlIG1lYXN1cmVtZW50IG9mIGRhdGEgInRlbXBlcmF0dXJlIi4N
Cj4gSXQgaXMgcG9zc2libGUgdG8gc3VnZ2VzdCBvZiB1c2luZyB0aGUgdG90YWwgbnVtYmVyIG9m
DQo+IGxvZ2ljYWwgYmxvY2tzIGluIGEgZmlsZSBhcyBhIHVuaXQgb2Ygb25lIGRlZ3JlZSBvZiBk
YXRhDQo+ICJ0ZW1wZXJhdHVyZSIuIEFzIGEgcmVzdWx0LCBpZiB0aGUgd2hvbGUgZmlsZSB3YXMg
dXBkYXRlZA0KPiBzZXZlcmFsIHRpbWVzLCB0aGVuICJ0ZW1wZXJhdHVyZSIgb2YgdGhlIGZpbGUg
aGFzIGJlZW4NCj4gaW5jcmVhc2VkIGZvciBzZXZlcmFsIGRlZ3JlZXMuIEFuZCBpZiB0aGUgZmls
ZSBpcyB1bmRlcg0KPiBjb250aW5vdXMgdXBkYXRlcywgdGhlbiB0aGUgZmlsZSAidGVtcGVyYXR1
cmUiIGlzIGdyb3dpbmcuDQo+IA0KPiBXZSBuZWVkIHRvIGtlZXAgbm90IG9ubHkgY3VycmVudCBu
dW1iZXIgb2YgZGlydHkgcGFnZXMsDQo+IGJ1dCBhbHNvIHRoZSBudW1iZXIgb2YgdXBkYXRlZCBw
YWdlcyBpbiB0aGUgbmVhciBwYXN0DQo+IGZvciBhY2N1bXVsYXRpbmcgdGhlIHRvdGFsICJ0ZW1w
ZXJhdHVyZSIgb2YgYSBmaWxlLg0KPiBHZW5lcmFsbHkgc3BlYWtpbmcsIHRvdGFsIG51bWJlciBv
ZiB1cGRhdGVkIHBhZ2VzIGluIHRoZQ0KPiBuZWFyZXN0IHBhc3QgZGVmaW5lcyB0aGUgYWdncmVn
YXRlZCAidGVtcGVyYXR1cmUiIG9mIGZpbGUuDQo+IEFuZCBudW1iZXIgb2YgZGlydHkgcGFnZXMg
ZGVmaW5lcyB0aGUgZGVsdGEgb2YNCj4gInRlbXBlcmF0dXJlIiBncm93dGggZm9yIGN1cnJlbnQg
dXBkYXRlIG9wZXJhdGlvbi4NCj4gVGhpcyBhcHByb2FjaCBkZWZpbmVzIHRoZSBtZWNoYW5pc20g
b2YgInRlbXBlcmF0dXJlIiBncm93dGguDQo+IA0KPiBCdXQgaWYgd2UgaGF2ZSBubyBtb3JlIHVw
ZGF0ZXMgZm9yIHRoZSBmaWxlLCB0aGVuDQo+ICJ0ZW1wZXJhdHVyZSIgbmVlZHMgdG8gZGVjcmVh
c2UuIFN0YXJ0aW5nIGFuZCBlbmRpbmcNCj4gdGltZXN0YW1wcyBvZiB1cGRhdGUgb3BlcmF0aW9u
IGNhbiB3b3JrIGFzIGEgYmFzaXMgZm9yDQo+IGRlY3JlYXNpbmcgInRlbXBlcmF0dXJlIiBvZiBh
IGZpbGUuIElmIHdlIGtub3cgdGhlIG51bWJlcg0KPiBvZiB1cGRhdGVkIGxvZ2ljYWwgYmxvY2tz
IG9mIHRoZSBmaWxlLCB0aGVuIHdlIGNhbiBkaXZpZGUNCj4gdGhlIGR1cmF0aW9uIG9mIHVwZGF0
ZSBvcGVyYXRpb24gb24gbnVtYmVyIG9mIHVwZGF0ZWQNCj4gbG9naWNhbCBibG9ja3MuIEFzIGEg
cmVzdWx0LCB0aGlzIGlzIHRoZSB3YXkgdG8gZGVmaW5lDQo+IGEgdGltZSBkdXJhdGlvbiBwZXIg
b25lIGxvZ2ljYWwgYmxvY2suIEJ5IG1lYW5zIG9mDQo+IG11bHRpcGx5aW5nIHRoaXMgdmFsdWUg
KHRpbWUgZHVyYXRpb24gcGVyIG9uZSBsb2dpY2FsDQo+IGJsb2NrKSBvbiB0b3RhbCBudW1iZXIg
b2YgbG9naWNhbCBibG9ja3MgaW4gZmlsZSwgd2UNCj4gY2FuIGNhbGN1bGF0ZSB0aGUgdGltZSBk
dXJhdGlvbiBvZiAidGVtcGVyYXR1cmUiDQo+IGRlY3JlYXNpbmcgZm9yIG9uZSBkZWdyZWUuIEZp
bmFsbHksIHRoZSBvcGVyYXRpb24gb2YNCj4gZGl2aXNpb24gdGhlIHRpbWUgcmFuZ2UgKGJldHdl
ZW4gZW5kIG9mIGxhc3QgdXBkYXRlDQo+IG9wZXJhdGlvbiBhbmQgYmVnaW4gb2YgbmV3IHVwZGF0
ZSBvcGVyYXRpb24pIG9uDQo+IHRoZSB0aW1lIGR1cmF0aW9uIG9mICJ0ZW1wZXJhdHVyZSIgZGVj
cmVhc2luZyBmb3INCj4gb25lIGRlZ3JlZSBwcm92aWRlcyB0aGUgd2F5IHRvIGRlZmluZSBob3cg
bWFueQ0KPiBkZWdyZWVzIHNob3VsZCBiZSBzdWJ0cmFjdGVkIGZyb20gY3VycmVudCAidGVtcGVy
YXR1cmUiDQo+IG9mIHRoZSBmaWxlLg0KPiANCj4gW0hPVyBUTyBVU0UgVEhFIEFQUFJPQUNIXQ0K
PiBUaGUgbGlmZXRpbWUgb2YgZGF0YSAidGVtcGVyYXR1cmUiIHZhbHVlIGZvciBhIGZpbGUNCj4g
Y2FuIGJlIGV4cGxhaW5lZCBieSBzdGVwczogKDEpIGlnZXQoKSBtZXRob2Qgc2V0cw0KPiB0aGUg
ZGF0YSAidGVtcGVyYXR1cmUiIG9iamVjdDsgKDIpIGZvbGlvX2FjY291bnRfZGlydGllZCgpDQo+
IG1ldGhvZCBhY2NvdW50cyB0aGUgbnVtYmVyIG9mIGRpcnR5IG1lbW9yeSBwYWdlcyBhbmQNCj4g
dHJpZXMgdG8gZXN0aW1hdGUgdGhlIGN1cnJlbnQgdGVtcGVyYXR1cmUgb2YgdGhlIGZpbGU7DQo+
ICgzKSBmb2xpb19jbGVhcl9kaXJ0eV9mb3JfaW8oKSBkZWNyZWFzZSBudW1iZXIgb2YgZGlydHkN
Cj4gbWVtb3J5IHBhZ2VzIGFuZCBpbmNyZWFzZXMgbnVtYmVyIG9mIHVwZGF0ZWQgcGFnZXM7DQo+
ICg0KSBmb2xpb19hY2NvdW50X2RpcnRpZWQoKSBhbHNvIGRlY3JlYXNlcyBmaWxlJ3MNCj4gInRl
bXBlcmF0dXJlIiBpZiB1cGRhdGVzIGhhc24ndCBoYXBwZW5lZCBzb21lIHRpbWU7DQo+ICg1KSBm
aWxlIHN5c3RlbSBjYW4gZ2V0IGZpbGUncyB0ZW1wZXJhdHVyZSBhbmQNCj4gdG8gc2hhcmUgdGhl
IGhpbnQgd2l0aCBibG9jayBsYXllcjsgKDYpIGlub2RlDQo+IGV2aWN0aW9uIG1ldGhvZCByZW1v
dmVzIGFuZCBmcmVlIHRoZSBkYXRhICJ0ZW1wZXJhdHVyZSINCj4gb2JqZWN0Lg0KDQpJIGRvbid0
IHdhbnQgdG8gcG91ciBnYXNvbGluZSBvbiBvbGQgZmxhbWUgd2FycywgYnV0IHdoYXQgaXMgdGhl
IA0KYWR2YW50YWdlIG9mIHRoaXMgYXV0by1tYWdpYyBkYXRhIHRlbXBlcmF0dXJlIGZyYW1ld29y
ayB2cyB0aGUgZXhpc3RpbmcgDQpmcmFtZXdvcms/ICdlbnVtIHJ3X2hpbnQnIGhhcyB0ZW1wZXJh
dHVyZSBpbiB0aGUgcmFuZ2Ugb2Ygbm9uZSwgc2hvcnQsIA0KbWVkaXVtLCBsb25nIGFuZCBleHRy
ZW1lICh3aGF0IGV2ZXIgdGhhdCBtZWFucyksIGNhbiBiZSBzZXQgYnkgYW4gDQphcHBsaWNhdGlv
biB2aWEgYW4gZmNudGwoKSBhbmQgaXMgcGx1bWJlZCBkb3duIGFsbCB0aGUgd2F5IHRvIHRoZSBi
aW8gDQpsZXZlbCBieSBtb3N0IEZTZXMgdGhhdCBjYXJlLg0K

