Return-Path: <linux-fsdevel+bounces-77770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDPsHQolmGkJBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:10:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A616609C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9907302BDD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5631AA94;
	Fri, 20 Feb 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YlsvU2x4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lcYQJxBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FC7478
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578577; cv=fail; b=oPT5SYeL7DsW7AlOKODpG08I1m68bCTHgb9g2FrJZDmpPe+7MnKXa9RHtsrEsjIvaMa+/djl2tnILEG01nND/D+JTzNSlzxdtyoGt/3nWhbOCldJQsgX2bP2eqUaHsSu8cbZP9wVeGrt7WVWuRhCks5HbwH70ccs/Hq+bTavlcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578577; c=relaxed/simple;
	bh=km8xJDfL+YsKCEXnMQpmOoODB3PcftXLrLDEHmgV+Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6bCExpQBQTk5QWN61PND0VHiWdKW/Xp/YVGNkqzW33H9V/c90ks/0jUvvOQDuPIaPkoc+mQcLyYJwCs7VO4Yy+Dw2NzluQkJtUb92eDaWSkv0Y5quvKlLKDYkJehgVpILJdcjQQ6JcPkEF/Chk8P/AE/KQ+2mjz7QnS2CFNZy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YlsvU2x4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lcYQJxBt; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771578576; x=1803114576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=km8xJDfL+YsKCEXnMQpmOoODB3PcftXLrLDEHmgV+Ac=;
  b=YlsvU2x4fvFwJAyAzbIKDmRu6wJOLBtziiccxNerRfv1iJe/n7EL+CA7
   WnTkb5ADlY6ALBIo0H/TJOu31R4NCo9xBjB3PjOd+ny10C8gR4wGbSSsm
   7GgfahewaU4KrXZk+Ms1Kh8SqjKJ38zHqFDGxkvo1zvDcZ3GTKL03q8Ie
   7ocY4RLZG6C5etYZj6A6Ab49/z/K5vOek7gpXtQ2ZGzTldeB2rsUdm5tN
   3MoKpp1BHAb9v2TzX5Wr8BcnbYY/t+TgI/tmsvtjlfm+Km2PM6PF+wIkf
   Dkzg7wfj2niLZwdA46lRaFUYJqKrFJjLjBtpfekNr7f1E1TSU6JM6aYzh
   g==;
X-CSE-ConnectionGUID: CqHrsW2vRjqDKSMAD15Skw==
X-CSE-MsgGUID: xb27DrwlSyaYrMkMqCthfg==
X-IronPort-AV: E=Sophos;i="6.21,301,1763395200"; 
   d="scan'208";a="141660116"
Received: from mail-westus3azon11012047.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 17:09:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuNe+obflS0z9Lv0atoyoIX7oJE2BLWyy+Lio9iBBEApZEdOOUBbX6G1Um1hzXH2BsJlY9uhTDx2Lgp43buoqpkkg/qXUXyACNHdOrwKKL4IcnAyHfxtS7nYihQM6p2B7jM3EnXQwt183xxTAnQd7G8jzl5E0Ff9aGeQr8eAHh9siXMa+zt/mrPr6fIxvw8JhYEJM/wzBHi+dyF4U/4FsxSXF54GQME2C2WbvcSxGO0+8ITIIzLrmBxioM4YHBBUDPRPTjdqrfHOudJC1Q+QPuB+Tuw4iUmWGY2n2i3AyEOyAbknvirtDbrUDI8qLouxEK62+yf1D7j73RaNIZR2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km8xJDfL+YsKCEXnMQpmOoODB3PcftXLrLDEHmgV+Ac=;
 b=clf/FkntaxngNX24IVfVTYrnjeycoSk97Aat6AIMi47GO0gl5ymVcdKKT3gQN2+5A/xd/EZEmfQ9zsiIdYiGTEeTkjBESJoJt97OFmt6cj/Gzc8orUpQKKGR9/4xHpUXYRDfc2t/TmZlp+HTWQP5AqY9ny6Q4/6b4NtxuMJ2U/L/cHF6zyFE51Yss6BDmmVdPkA8Mvw+HXsWLnHC+94Xgh+EmaoN6h2NRewDZyXvl1ByfDCkjJCh5FTGx/MO18uofrbtNr0yjxNxJrTkd311jysgZoT+Lpi+OvyPlyM+XTC2W2qq7FHi2yCtvt9i3rc4KnHs9CNgnyBr35G8eQdzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km8xJDfL+YsKCEXnMQpmOoODB3PcftXLrLDEHmgV+Ac=;
 b=lcYQJxBtnAVRSJxC5zUG9CSHmm46CbXRzLOsBouNCY8cqeuNfMdAx8AFzhhbyVezzj/GGDx8MOHnwJWPfcRP+2dCgqI4nTVJQf2zB3Jduru84MwY59aQHlsqnO3/qZV63ucweVyT2tMAzCKldUm7FRH8+LdwIdKDoZHJhyFk+xU=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:09:33 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 09:09:33 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Theodore Tso <tytso@mit.edu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system testing
Thread-Topic: [LSF/MM/BPF TOPIC] File system testing
Thread-Index: AQHcoOhjyt19HVQRkE6+n+S5U94kLbWLT3CA
Date: Fri, 20 Feb 2026 09:09:33 +0000
Message-ID: <777ce698-8b71-495e-aa6d-d4a6bc28d7e3@wdc.com>
References: <20260218150736.GD45984@macsyma-wired.lan>
In-Reply-To: <20260218150736.GD45984@macsyma-wired.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|LV8PR04MB8984:EE_
x-ms-office365-filtering-correlation-id: f6ff3a96-4898-4416-bfea-08de705fc38f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWJXYkpINjlHWHZGT2xaQUZ6emEvaXBRRzVkQWV6MkZqVitNRWRxemp4QU1C?=
 =?utf-8?B?NTAwbG5IbldCTERKbnM1QlR3VE5jMGxGMWt2UFRMRllNcXd4UDNBRkxmR3Vt?=
 =?utf-8?B?NDZrSDlGd3NVVWJUM2VLMVFwMUVqWUhXM2NlTUphQUFZOENDeU5TbGFuZGd3?=
 =?utf-8?B?KzF5RVVRSVFIbjl3SUY5UncxTExYcXFINk9mV0twTi9BMVVpS0N1bXJ4R3Nt?=
 =?utf-8?B?alpFRE5RbzB4M0NkMzdzOWhHQzRCNEs5VlJPd1I0TW50NFRFMVhidU4vYWc5?=
 =?utf-8?B?WlBYUzVjbnBwWW5iREZHc2U2SDlmY3BlT0s1THdqYlkyQVdrN3dmdUxxOFF1?=
 =?utf-8?B?ck15d0NFTnNqZTNJUWEyMHRMRGVSWm1VN3N5Zk5BMDlNY29FSjR6em9rWlVF?=
 =?utf-8?B?Lzk4dlBIOEc3SkZpeWV5OVNvWGl4UDMvSWd1R1lFcW9FUVQycVFiYjRDc243?=
 =?utf-8?B?bXZlbkpicVdKNXFKcjlZSkhSYkpVYU0wOER4ZmZNRzUvam53NmxmaU9tZXk1?=
 =?utf-8?B?cjVVeTBYaEk3bGFaZXk3YWFJTGFieUxZcDVRUXdTRkhZZEpId2F5RUYvMk96?=
 =?utf-8?B?dUMvS0hLbXROVHFONWhYWjN0dDhwQ01pMDVxWndZbzJ4S2JheTQxQkliaEJo?=
 =?utf-8?B?Ny9MUnVtSEhSdlRXRnNreTBEYXAzQ0s3bUNtTm94Rzl4SlpZemtseTJHUUww?=
 =?utf-8?B?NzVQenU3cU5iUHlGY1NHRUJNZVNlNVRVNDdVeGpOd3MyYXcvOFpxdklmSU9p?=
 =?utf-8?B?RklGbXhuZW0vZG44NGFTSDkxYTlSSDZkZHNWdlp0aEduYlVlZElDR21jd2U0?=
 =?utf-8?B?eU14WnRFekdlUHhkY3lPOThNYzRpWlp5TXpRdE41Zk1vdjZyeE5UZVpSWVBx?=
 =?utf-8?B?ZEFGWHZ4WWFjUXNRd1pscGtyWFltT1pPV3FMSFN6eTV1NmEzVmx1d0xOMllx?=
 =?utf-8?B?TkovZFQ4Y21iTEpKaFNTY29WUWJTd2VXTkxlSFkza2ZSNEVqNUJ3ZFcvd2pQ?=
 =?utf-8?B?WjlJT3NyaUlad3BSYjZlYjZ4UkgrK09xdGVZeEd1SjUzV3JYcFo3Z1RFbCti?=
 =?utf-8?B?N1E4ZEdESUFTdzE2UDdPMjdvdHo3Sm13aFpqK0VvNVRtZkI2aVhLSnNJbnpE?=
 =?utf-8?B?OEdKWkl2RHVnYk1RYWxXQW91OVBWbVhBM0o5R2VaZTZxbTNsT0lNejJCR1FR?=
 =?utf-8?B?TE9TUnlCVFJCOUNML3dTOXlrWlB1Q1RQNXNBazRSVEN3WUNwRHpMR1hCRjVn?=
 =?utf-8?B?QWRhdHhnZFU0bmU2YzhpR2IrbjlVdHF1MlNveFFZYkZ4UzcrMUxYZWczeEJk?=
 =?utf-8?B?R2U4ZlM2R2RSUmVIczRMSXRtYXZvL2ZuRWorU2xWSGU4Q2FSVVBuNWZOaE1C?=
 =?utf-8?B?ZWcvcGtXQmxrbm1zNitrdHB1d0k3T0g5RVIzZXVnUHlEZGNocEtDVE0rcVc0?=
 =?utf-8?B?TlRBNW9Rc2g2WjJlRHZwSE9XNW5iSStLMEpmbTlUeHlRRTk5bUQ2RlJFbnZv?=
 =?utf-8?B?TUFTbWVZT2kzV1JLeVNpeTdlS2ZGdjBzNVRNYjBFWFFPc2xJNFcwWXo3aS9y?=
 =?utf-8?B?QlQxNHI3OFVUbXI2L2N0RlYxK3BpbDdqREZ3bjN5MUliVEE5ZFg2VUZQTmRh?=
 =?utf-8?B?V1htQzZUNCtKRmp3cmxuaFpLWE5nVHAzMzhqN2N2SzNrMEVOcEswenhPbWVF?=
 =?utf-8?B?ZVVWUFo4OEkzVFZkQ1Zvc0lzTHViR2J4c0tDUVBnMkNlakV2Vm1yd3ltdnpK?=
 =?utf-8?B?dDBMK3MzRmVML1FZVlo2L3M0bm5ZK1lXdGxiZ0pPSUJENURob0t3cHlhb05X?=
 =?utf-8?B?LzJ2T3pjdmtWcGU1a25Lb0J3TWVVRFVsNW5lVXJUQWNPaGxIZkFQRXdtRTFj?=
 =?utf-8?B?LzJEcXlGMnd1U0JvbFd0bk4wTVV6TlloUGV0a3VwZ2JOeEZrUWIxbXFOSHVz?=
 =?utf-8?B?NHUrdHhzNlNSTGNZSFRwcGNyejRyYkRlSXVwTmJyT1NETHh5RkdhYXZVL1l1?=
 =?utf-8?B?NFd4Yy9vWUFTdlc0S25oTHVmeDVVMnVGakZyU2VLTWJ5RHBhTXFFaXJYQW93?=
 =?utf-8?B?K29IY2w3Szh1ZjBHT3RqZURxN3dpZ0VUWXc5djE3U0p1b05tbWN2TkdUcnlB?=
 =?utf-8?B?d1ZVVTBIYmZVUmtoNkdwNTlTc0FlRE1DU2w2L3ViVEVGc0VaQ3NxM3E5R1dP?=
 =?utf-8?Q?jMBp9L1zrUl3RPb4iA6xm50=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTdTZ1MwTFJxc3pheERyUVlaZUhMY1FaenBvSHcrbld0Zi9teXE0RHhDQUJC?=
 =?utf-8?B?eVl0Y3BMdkFYbWhialBKL0V1U3UvRDBtaFZndC91b3FPaWlTdEZab0FsWnNR?=
 =?utf-8?B?L0prV3djYmV6eitqTWV6RmZMRk9hbDJrdWtiOXUxZklvZzRlU0NpUThSZnhH?=
 =?utf-8?B?NWtncTZPYmFiVGYvQlRNc2VyYnoyVFhpZVUwQzhRWTBpWFgwb1BIb0FZQ2NS?=
 =?utf-8?B?dFVobVA5QS9mOGswL04vazhoZkU1UHR1dEFIOTl1R0xVN3FqdlNlRGRjZ1No?=
 =?utf-8?B?bFNFUjA0ZDh5ZXd4VzJkZys3aVF5V1hXd0dvMXNxY0ptdG5odDdsa0Fjamtp?=
 =?utf-8?B?enVRTzd2aGV2MkNkcnhYNEJmOEJLVFVyTkN5OVFMdXMvQmJjUzRaWHFsN1BG?=
 =?utf-8?B?YkwvKzBDamNHS0NoZTVSbFV4YkJoMnFabUlDVlZhYkhQeUF2OXp5YS9uRXlO?=
 =?utf-8?B?K0s5YmJla2VsbDZUWEtydXJ4d0V0Z2FaWUxXTmcvVFNUTUF0WnZTd3BvUjZS?=
 =?utf-8?B?YUMyelIrY0VTZkM0d3VSRm43bXRLemxUNWVmZFc5UHAweUxXbGNQSFB2RmI4?=
 =?utf-8?B?bElmSVdycndENmROYVN4am03TDh4blExM2lZTjRzSGtaSHdQbDVzYnE3N1NB?=
 =?utf-8?B?TVAvemVjaENleGlvdVgzdkoxbUVwV0xSMEFySmpRL0RLeksrV3RXVTJQelhG?=
 =?utf-8?B?MWRsSk9PVWtiQU9OS3kwbVlld0NSWFJocjNUVklLcElDSVRLa0hGei9sK3R2?=
 =?utf-8?B?ZkdrdjV6L09md1FCV1JYV3gzMTF2aTFkQnRONzF3eXF1Rk9qaSs4RytBWEti?=
 =?utf-8?B?amJOTTZSTFdyclpHL0JkVWdQclYvQ2pRNnd3Y1dUblYyTlRpN2hsNldmeWcy?=
 =?utf-8?B?QThtczg0enpJcUxuWStWbml4RkcvNG1OQnNWQ1MrczgwaDVoVzVZQklUZTE0?=
 =?utf-8?B?TTRleDdtdTBJbWJtWVBqdEhlT0I3Y1JVUXM0VUp2dGNUK3pwdjN6UWo4U0Vm?=
 =?utf-8?B?WDFlOHRXV3pIbVJXVm1OY2VKWDBYbzlQOG8zZGI1cVM0c1BiTzU1T0o5TjVs?=
 =?utf-8?B?Wk10bVlJQ3dlZmNaZ3NIOTNURE1IaG9DeXczRVlWVFYzdTJpeXZFMkI3QVFh?=
 =?utf-8?B?R0RjS0d2SnZhYVdJMVZpdzI2L3MzWW51cUFIUGdxdnFuaXF3K1Z6M1Z4V0xo?=
 =?utf-8?B?TUlXZmMraitmdVkvZGppMWJRQjd1N2ViN2VhN2x6dW1uTWZ6c1ovL1lzcERz?=
 =?utf-8?B?VHV2ZWJLcHRDRmdYMDBVTlJITlpkblZYK1NrM3J2UGh1d1g1UDhIMHlBZXBK?=
 =?utf-8?B?Nmk5QlIwL3dRUWFFcXM3QTlITjhaOFpFbnZLd1laK3l5b3ZXYjdWZ0pDeFpi?=
 =?utf-8?B?WVM4c2ZtRU81Zy90cmxMbWFLUWFVZU1aRFBPcVp2R2FLZDh4UE5DTlhaU0Y5?=
 =?utf-8?B?Y2NTQ2JmOWRvVW0raThuUkhsbkNMWXlKby9Dd3p3VnJkMDF6dW1iZnBBM1Q1?=
 =?utf-8?B?V29FUG9FQ0gwSWdFVFlDNnpDWFNLUUFtaU03alFMWkpLNFcrVjk0STMrRmgz?=
 =?utf-8?B?bTV6WHN4WWdFN2VhMmt0THFnM0pGZmVDWFc3TnBlYWdRVE5VVWJXSjRWZVZk?=
 =?utf-8?B?SCs1UkQ2Q3VNZjlMc3pxM2pJdTF2c3FzeU8rRkVnNCtJQzgvamtVdE5VUWtJ?=
 =?utf-8?B?b1FHWjdFbURNRWRkOVVEOTZ0d0xlbDhqWkVEQ2JNRGJUWlRoZXVSeDJVR1Vp?=
 =?utf-8?B?L2NaTTFaeE45V1BSbnE1WHVnZlgydTJBcXdsZkd1enZlNWdTYnRsdC9INm8z?=
 =?utf-8?B?anJrVnRBcjJ3N3cyRHZyZUw3Mkd1dUk2bWptOCtWdjlHQnFnS09TR05XVWQ1?=
 =?utf-8?B?SzM2WmEyK3lGN0tjV0dVZmJta3EyZ2hjb2hnRWlDRU41bmJ5bmhLazRlbGZP?=
 =?utf-8?B?UXMzUzVrNko5SzlNZy80SjAvK2Jic3M5VHRVWUJlRTFwTlZoSGdDUXc1ajND?=
 =?utf-8?B?MnorVVJvczhFNm5vSnhJNzhSaHh5MDA2ckVxelBIUks2eWNhOWV5dXVJdS9H?=
 =?utf-8?B?TUxQc0JWVFZJdnNNUFFyN2dlcHFJeVpOTVRScDJXbG1SRmJ0UytNb1BMYUw5?=
 =?utf-8?B?L2RvQm10WjRxZlNoeGcxV3hEYlVEVll3V2NCMC9qZUgxM0piL1hHS0QxM25M?=
 =?utf-8?B?blM5enhrSndGRlJjMlRZSFk2YnN1UHBNNCtEOUYxTnN6VFlyeHBIRW1kLzFQ?=
 =?utf-8?B?VEdLQmQ4c0dkUnE1TzlyRjFQcnB3dlIvaTZSOU1xQmE1RTlvcG41MnhITlIx?=
 =?utf-8?B?bXpMcEFCV0ZodTcyRFdxdDM0cWlZbTZHRmoyS2Q0YVNvZDI2dTVhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12B408062164EB47904F5B433008CC3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EmvVieDCKXi8/Tt49KE5X2VeQp90mspbwTNb6GL/iS4W/AWYNNnk2x1FoWYTmoHPzRUiJEwbWQIYTsN0KluPclkDyfY4Faw0+PR2HY4wj8MmwhxkWc6dBmDAYYHofWHynnB/JzhsBmMoXHh4sgDJBgIeAINZl+ex9jo2LPK5U8R5188ROXAcYFWUzrRWn/i0ZbXrgCUIdhJtUmXb09lkbiEgoaK8utbEvG6qrqWzpQlrkZsE0ZK30LCxRT6EzZHB3V6v/ZzUAcv1hgBWtRedlu4yMRxZJPH/z3zNXq/sdtq5/P3bQWNpgmNyElFmWehF9ULWo3K9lvoSOZ54+nxHvp/eS2rBiGS5MSJlMnRnKnHpKVOpkVgLcTZe6eJdsgU3Gexzyx/JhNy/kqE12y0L05j/LeDetA6pfaLFtIfiwAe8e7AUZiY1/ZrwWwVFb7qRtuVCE3sgUNib0OyWdalDMCn/XZLLBYYPSb5WXKpeQKXFzs4PqhsowMlzzWjshfRNZyK9w1WLiBigu2xghYe522N4xW6L652dl+UPRisPii1Xv2Aolm5zcUhqabCCd9b2lXeIYbn1DC+5X3t6Ay2SIh89Wmat1ToeKArivTV6GnNXLRxJ934GJWZXhwDx2TJQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ff3a96-4898-4416-bfea-08de705fc38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 09:09:33.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxFS04zAcu6sW8JmsHvMbIwc1Kkp3BTQQMrEMJ6Drk2MeF29qyg1bjvU2UeYHX0brsEVgLInoXjvzYpnjhAl+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77770-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Hans.Holmberg@wdc.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: CB4A616609C
X-Rspamd-Action: no action

T24gMTgvMDIvMjAyNiAxNjowOCwgVGhlb2RvcmUgVHNvIHdyb3RlOg0KPiBJJ2QgbGlrZSB0byBw
cm9wb3NlIGEgcGVyZW5uaWFsIGZhdm9yaXRlIGZpbGUgc3lzdGVtIHRlc3RpbmcgYXMgYQ0KPiB0
b3BpYyBmb3IgdGhlIEZTIHRyYWNrLiAgVG9waWNzIHRvIGNvdmVyIHdvdWxkIGluY2x1ZGU6DQo+
IA0KPiAxKSBTdGFuZGFyZGl6aW5nIHRlc3Qgc2NlbmFyaW9zIGZvciB2YXJpb3VzIGZpbGUgc3lz
dGVtcy4NCj4gDQo+ICAgIEkgaGF2ZSB0ZXN0IHNjZW5hcmlvcyBmb3IgZXh0NCBhbmQgeGZzIGlu
IG15IHRlc3QgYXBwbGlhbmNlIChlLmcuLA0KPiAgICA0aywgNjRrLCBhbmQgMWsgYmxvY2tzaXpl
cywgd2l0aCBmc2NyeXB0IGVuYWJsZWQsIHdpdGggZGF4IGVuYWJsZWQsDQo+ICAgIGV0Yy4pICBC
dXQgSSBkb24ndCBoYXZlIHRob3NlIGZvciBvdGhlciBmaWxlIHN5c3RlbXMsIHN1Y2ggYXMNCj4g
ICAgYnRyZnMsIGV0Yy4gIEl0IHdvdWxkIGJlIG5pY2UgaWYgdGhpcyBjb3VsZCBiZSBjZW50cmFs
bHkgZG9jdW1lbnRlZA0KPiAgICBzb21lIHdoZXJlLCBwZXJoYXBzIGluIHRoZSBrZXJuZWwgc291
cmNlcz8NCj4gDQo+IDIpIFN0YW5kYXJkaXplZCB3YXkgb2YgZXhwcmVzc2luZyB0aGF0IGNlcnRh
aW4gdGVzdHMgYXJlIGV4cGVjdGVkIHRvDQo+ICAgIGZhaWwgZm9yIGEgZ2l2ZW4gdGVzdCBzY2Vu
YXJpby4gIElkZWFsbHksIHdlIGNhbiBlbmNvZGUgdGhpcyBpbg0KPiAgICB4ZnN0ZXN0cyB1cHN0
cmVhbSAoYW4gZXhhbXBsZSBvZiB0aGlzIGlzIHJlcXVpcmluZyBtZXRhZGF0YQ0KPiAgICBqb3Vy
bmFsbGluZyBmb3IgZ2VuZXJpYy8zODgpLiAgQnV0IGluIHNvbWUgY2FzZXMgdGhlIGZhaWx1cmUg
aXMNCj4gICAgdmVyeSBzcGVjaWZpYyB0byBhIHBhcnRpY3VsYXIgc2V0IG9mIGZpbGUgc3lzdGVt
IGNvbmZpZ3VyYXRpb25zLA0KPiAgICBhbmQgaXQgbWF5IHZhcnkgZGVwZW5kaW5nIG9uIGtlcm5l
bCB2ZXJzaW9uIChlLmcuLCBhIHByb2JsZW0gdGhhdA0KPiAgICB3YXMgZml4ZWQgaW4gNi42IGFu
ZCBsYXRlciBMVFMga2VybmVscywgYnV0IGl0IHdhcyB0b28gaGFyZCB0bw0KPiAgICBiYWNrcG9y
dCB0byBlYXJsaWVyIExUUyBrZXJuZWxzKS4NCj4gDQo+IDMpIEF1dG9tYXRpbmcgdGhlIHVzZSBv
ZiB0ZXN0cyB0byB2YWxpZGF0ZSBmaWxlIHN5c3RlbSBiYWNrcG9ydHMgdG8NCj4gICAgTFRTIGtl
cm5lbHMsIHNvIHRoYXQgY29tbWl0cyB3aGljaCBtaWdodCBjYXVzZSBmaWxlIHN5c3RlbQ0KPiAg
ICByZWdyZXNzaW9ucyBjYW4gYmUgYXV0b21hdGljYWxseSBkcm9wcGVkIGZyb20gYSBMVFMgcmMg
a2VybmVsLg0KPiANCj4gICAgCSAgICAgICAJICAgICAgCQkgICAgCSAgICAJIC0gVGVkDQo+IA0K
PiANCg0KVGhpcyBzb3VuZHMgaW50ZXJlc3RpbmcgdG8gbWUsIG1ha2luZyBtb3JlIG1hbmFnZWFi
bGUgdG8gcnVuIHNldHMgb2YNCmRpZmZlcmVudCBzY2VuYXJpb3MgKGFuZCBzaGFyaW5nIGltcG9y
dGFudCBvbmVzKSB3b3VsZCB3b3VsZCBiZSBncmVhdC4NCg0KTWFraW5nIGl0IGVhc2llciB0byBj
b21wYXJlIHRoZSByZXN1bHRzIG9mIGRpZmZlcmVudCBydW5zIG9mIGRpZmZlcmVudA0KY29uZmln
dXJhdGlvbnMgd291bGQgYWxzbyBiZSBhd2Vzb21lIChtYWtpbmcgaXQgZWFzeSB0byBmaWd1cmUg
b3V0DQppZiBhbiBpc3N1ZSBpcyByZWxhdGVkIHRvIGEgc3BlY2lmaWMgY29uZmlnIG9yIGEgbW9y
ZSBnZW5lcmljIHByb2JsZW0pDQoNCkNoZWVycywNCkhhbnMNCg0KDQo=

