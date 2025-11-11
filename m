Return-Path: <linux-fsdevel+bounces-67862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87904C4C6C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 123324F29BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB202EC55A;
	Tue, 11 Nov 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yc3FvQS1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BPL2q4Q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD5248878;
	Tue, 11 Nov 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849902; cv=fail; b=Itk+fxmTll8xS2B50YsioeHhhPFX5kTMG0UTK56F3gQzb4ErqPcsWtYIMT7dkUMpforg61iLory48yCwJgQ7eKtSDoXKwjS7jkOeoFZLAbMiQ9GQ4XK0zvt4YVMzRCD5oOX+zetiHEBSHKOZahQKcIDLTrNcc1OHYp6U7vO7QvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849902; c=relaxed/simple;
	bh=JEJtC5EOYkiONlJa3xTy1cFPuN6WaII52ar7I8bEmQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TBy+wlFmFbERgt+7FVgqm3jZEN8o3MAZgTm3AawaPupEtkRwHt3oEtHsgrnkfUKMi5Zpm235F9Lrzyotlx6I6oXLsaG4s55EL/mqsNVDweVhhZYW8QPXgwtCEiYzNzlKH9rM4OhQ9Na4xld3cBcaQNSo5MHqxgCyeMMkOHwbHZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Yc3FvQS1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BPL2q4Q5; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762849900; x=1794385900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JEJtC5EOYkiONlJa3xTy1cFPuN6WaII52ar7I8bEmQU=;
  b=Yc3FvQS138gGDGFuKfA6miRHJiF3PuVECNKZUWtkpiqW8zW1XUgx//4K
   nSrLm5mHrRIU2tn4VWYXCoNbaxcCi9vW0nmOt7wXFAgOd9iPPIEI+Rn3z
   mWnhibw/lG7DpyqlJ74+/oTH3FYm3yLBhPrfZBTlBt2dWEuJ5ff7qhQBE
   Zd668ivEMzSEjbvO+PvPHE+E6BhWE5vDzWzYTxPrmiBDEf/5FKDL+IIsC
   gW91yZUewIefpzQvrP/NCi7cdE4nAmPx8AAc9mlhM5tggFKm6C6ez1jfE
   5fifnuzECV7aCpPlXpln/fiN8BXT4AS78N4GLTtS5xKLMqK0Tz1oO+npm
   Q==;
X-CSE-ConnectionGUID: MUJdHoF0Sv2FanHD/yL8bg==
X-CSE-MsgGUID: 3/0lY8XEQz6+wAXGarVHfw==
X-IronPort-AV: E=Sophos;i="6.19,296,1754928000"; 
   d="scan'208";a="134529749"
Received: from mail-westcentralusazon11013033.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2025 16:31:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g29Rv98yF1HUvAwXcQtD9lFFzbAe7SDio/RQmlZH10vpAPbWkifu+BJ9gsj2fsOruAZXOxm7uZuRwnvvl3TVcjlx9B1j55Pp7CIeE2+bnRBHF7knI7xE21XKK3xMRrQBShZmVW5Ltm/F3ICUhcTaovmS1408r7Rot/Y51/8cBjvy0Skb48nKBQ8cYAiyNXwouw9JIRCH/bsBQ4Mmi/wU5vPiomdc1YHLGWYDyliW4vPJvrQOalMwpEPOuoLA493xtzRQgPknsnwJU8Sg5DGfSS4H2Tj9JRZathaGFM8KGz9UkYQ1hcXm9hlzHKtGyqO/OdjLdf/qNnMaa6vapHG/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEJtC5EOYkiONlJa3xTy1cFPuN6WaII52ar7I8bEmQU=;
 b=nVQT+AZpXAf3dp9bhBkJNiNx050Y7ajM7hnFM65++daSMv7i+hR6Xp3TA0RzEur8RL6sgl+KAQnJa3Af9VVD8e0st3cuqej19y8mHb8v89X1Iazb0nH8ZEq7px+kbPWPeVsTZ3vnrg8ewtbrfjFS19Xt0lPnrS1PZ2pXe6xS/VMsbDF2/L9fLxvDB1jdeBgFGwg0DBS0ii7nHC+0RIabE1SoMzg7XTFRbEtnc/oaC+jTX3+X2zjfEU0LqlyjujcbMxzjifX4BtdvEb1GHO4AlteHmRs19irw5oNd4up33VH4v87t6gLx0yB0tSJf2J71pd/uF4YHEC2uVHNRIYF4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEJtC5EOYkiONlJa3xTy1cFPuN6WaII52ar7I8bEmQU=;
 b=BPL2q4Q5T5P4zg/M69vVX6VRbWvrRgk5/BuWddHJs1UnqMwNHH1Vxe41abjAyANoAUoOQBRQ4d8dM61kYh0Sxt34JG9iiMZuECK5b8gblXi+RDcU4w2bO39WSMDNdlZpsJzGgprN2rASS5mIGeIesHKZK2NR25F4YE8wMCs/7tU=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by BY1PR04MB8725.namprd04.prod.outlook.com (2603:10b6:a03:52a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 08:31:30 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:31:30 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: hch <hch@lst.de>, Florian Weimer <fweimer@redhat.com>
CC: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, Dave Chinner <david@fromorbit.com>, "Darrick J . Wong"
	<djwong@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Thread-Topic: [RFC] xfs: fake fallocate success for always CoW inodes
Thread-Index: AQHcTyJJssvwQQo1oUKa94g0LXBTp7TlqddBgAAA/gCAAA4OAIAAAQYAgAdy+gA=
Date: Tue, 11 Nov 2025 08:31:30 +0000
Message-ID: <8b9e31f4-0ec6-4817-8214-4dfc4e988265@wdc.com>
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
 <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de>
 <aQyz1j7nqXPKTYPT@casper.infradead.org> <20251106144610.GA14909@lst.de>
In-Reply-To: <20251106144610.GA14909@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|BY1PR04MB8725:EE_
x-ms-office365-filtering-correlation-id: 102d64fe-d08f-4f44-260e-08de20fcb6fb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVJGM2lDS1hSeW94T2hVUmF1N0NrM2F0M0E5RHFYRUQ0bHdLdmdvWVd6cENR?=
 =?utf-8?B?TnFBdk41U3I3eGVvMmErUm10OWhBdDV1SDA0Kzl4NlQ4QVRkZ3hLb0pvcGd2?=
 =?utf-8?B?TGkzcGpYTDdGanpwcTdxMkhwWnJpQ1lZUjBTeForRFEwRDJNYk9DSjB1ckFI?=
 =?utf-8?B?NmhzUWRYam1NWVJ6ZVZHVE00aldJVWNSRW1kRFl4WVZPN1ZCditVdjZwV2pF?=
 =?utf-8?B?eVJtYlB6NFduS1RaTUg4YTczU2FCaFNoTUVKcHlUdVBWQWJXck9vbVMrWHBk?=
 =?utf-8?B?RklEMWJUcVY2c2hzNk9aaU5LZnhGdUZXa2hvaitCaE1xU1hxSVhRYWdyZHJL?=
 =?utf-8?B?UG9kK2tJMWhQSjYrRU5UM0FLZEhGR3RnOUMzVjAwOVpLYWd2STh6Y2hmVHQx?=
 =?utf-8?B?Y0crQ3h0cHRrQUFQdTJCQUxBYnkvVGhGNUhrQXdSZmJkbXZPU2pHWW9WUHJG?=
 =?utf-8?B?RFBQWkhQQVZ1eWZVUGhzbGtvakV2Tlo3UTJQckhOOC85bjd6WUp6b2xQTHZ4?=
 =?utf-8?B?NERhVEJYSGZNSm5mY3RSVFI3UGxSaGpiTkorRktRVFZYbDQ3L0JZbS9kMlVJ?=
 =?utf-8?B?UkVSRWM3OHdZYWdrd0FhZWthL1BoSWNWc1B2QmpjMzNRcVcrcGFWMVFkZFVM?=
 =?utf-8?B?aWZzNVJ2T1FQMjVmbEFXeG5oY3RiTUFHSnczLzhPdnphTHZmQlNQZ3gvcG0r?=
 =?utf-8?B?bWJnbzlkcENybTJkVlpaL3lQNEdmRE51SU5mMWg4WG1HcFJtS1NHdFdOTm4r?=
 =?utf-8?B?YWoyUzR6TDBtREJ0RUNUVkJxblBnUjZoYnp0d2pYcEN0a0FZVWVITklVeVN0?=
 =?utf-8?B?bFZlZ2JxazRmR1FhcmRDMFp1VU9Zb211OUNGWGVEVVNNRExlWHhvT3Q2RWJM?=
 =?utf-8?B?S2RzcEJlOVZDa08zTUltN05jYmxBUGRzZUZ4c0pveXBsMnUrN3lwNG1sMldW?=
 =?utf-8?B?Mjd2bGREMU93RlVBZXUxT1QrMGRJMjRDNW5peGovWEo3bk51bDF6UnFybGpq?=
 =?utf-8?B?QW8zUldsd0R6OG0yaGRUZEdqZDc0c0lCTDIyTjFvdGZVT0c0S0d5VlRzR2Nq?=
 =?utf-8?B?SHJZeitYWlp1bG40R25jR3NTRk1Cc0xVeFFXaHd5VGdkYXlTMTRmVk4wT2xJ?=
 =?utf-8?B?ZVJyaDZ3anUzbStFRkZuRDdvaGZGQVBkSnZmR0FEU1JkSTNzQWFzcmJLbTI5?=
 =?utf-8?B?KzBOYXdlREZ0L1BxWUVFUTF4RVRqbVI2ZTFNay9vcWNqUXV5OEZTNHlpQUpm?=
 =?utf-8?B?eWMrZnIvcHhKSmhlV3drTzU2ZlJxR1hmSEpHcGpxQ2VXVDE1VmdVSE1qQVFv?=
 =?utf-8?B?eEJUMUxGSUtqSHlWZ3ZrOVMrb2F6UHBFS2ZsSWFjTmM5YXdiWFYvM3g1UW9q?=
 =?utf-8?B?NFVGb21Vd1NhVmhMQ3NwWXF6ZzdMNFhZcTVSUHdHZXFwVVNGRkd1cW9HSkc0?=
 =?utf-8?B?eXRoUFFWbVR2VlFjN0tBdlVMeXd4SGtXMlgrbFVzWWJGR202aHpnakQ3VVYr?=
 =?utf-8?B?WVNwYXV0UGM0VmZRbWxCa0Y4UU05a0dralJIWWpoRnhDV0hsVlZYdDRXVGQw?=
 =?utf-8?B?ZmQ3ZU0zcFhuaDBiZUJ6UmJTN1Q3akVtVkFxMWxxMlZSY1RjTTlCaE51bHBx?=
 =?utf-8?B?SnZoU0U4dnJqQVNoSDEvWjFRMXE0aTJsaHRqSnZQalFJczhFZDZtTjBlTmZF?=
 =?utf-8?B?SWZxU0V0d0VvbE9RcjQ5L2l2L3NoYnMwc1hkNmtyWVVmRThDdkdacVNhek1F?=
 =?utf-8?B?bFk5VnQ3WkVpWFpHMGxzWlBsRXQzR3NyWHhoUktDS2hjQndWd0xxVGNPVG5n?=
 =?utf-8?B?R0J0MEw5a1lvNTRiR29hc1p4Mzc2VlhDbnNEUEZLeVpDWWltRnhicWZHdGVM?=
 =?utf-8?B?TXVGNi81UmYraUVnZHlxbWhBdzJ6eWJXanRndW5LWWN0TS9FelpIeTZsRE5S?=
 =?utf-8?B?OTducmFOVzdYcHp4VTVsRVZUWnpyUkVhdDR1Mm16SElsOVNYUHN6M1ZmNHNU?=
 =?utf-8?B?ZWpsNkt2VS9IWVJuem5iYkFHSHdDTXBvRFZ4Z1U4MERzTkZsSEZmV1Fnb21y?=
 =?utf-8?Q?qzTZ48?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXNPR1RrTFA2N1IzNFVjMXpvRFFaZ1NkZysvbnQ2UWdkRTdNUlN2VVlGZkZl?=
 =?utf-8?B?cDV5bm9uTW9aanhUeGxLWEpMWGdILzZZOGZ5QWVpTGhtOGRxUGRhRWl4a3FB?=
 =?utf-8?B?cUg5WHQ2ZW1qSW42M2NwVDd5UHFnejJDZ0l6TlJHbHFGVHNOZ2QyWkcxUnFr?=
 =?utf-8?B?cHY2Mk9OQkdaV2VpbkZVSHY5UVM3Yk5BWWtSZlRCdGxYc05jWjJuc2huTlk0?=
 =?utf-8?B?d2xHM2VCVk5DNDRyNnJFRTNUZWwvcDMrR2lKaGZhdVkySDBsMmkrbFArUzZC?=
 =?utf-8?B?R0JmV2JndFZZMER2bmpsUnV0V0l5akw1REZKNm1sWGdPUjZYYW1nYk15REg1?=
 =?utf-8?B?N1pGZUJmdEF6VUM5VTVZS1JVdE9yTUQvSTJWeDdlR0pnVnpVc3pDdkFOTmRk?=
 =?utf-8?B?QXZIQnlzWWdnRmluMFBObHNYZVNHbDJZcFZBdlpFdTZ1bTJ5d1QxVEREYXlH?=
 =?utf-8?B?ZytnVy9CT1hPMVJiTkRxd0p3ZkpvcVcrZ0gyNTM4MEdUNzVvMmZrcm5aTDBT?=
 =?utf-8?B?MlBhTDdlTW8yVFFSeEhza1ZaUytJanFrTzVuT2w3VlhPN2lpQ05DMGpJaHIz?=
 =?utf-8?B?eXJUcHRvcHl2djhaL05wMDZvbWtKV0RlNFBXekRQYmcwM2czazFxUWhXU2ZB?=
 =?utf-8?B?NmQwQ2dSTFFiNERidG1QbCtCaStPU2pRTVUxTGVtWjNyaUlDdmxPZFNUaVZm?=
 =?utf-8?B?ektTMU04R0lranRPYVJUTm1SaExzcTRjNU5XcU1IL1dEWGQvT1NEaTZEcE9v?=
 =?utf-8?B?M0sxMTZvcm1ETFEyT0FkQmczZjhTZlJzOTZ5S1ZkczlFVWxma3k5UGNtdU5C?=
 =?utf-8?B?cDRQY2puZEhUbnA5S3ZPbGFrbTY2bnZZMHRnQVJkd2hGcDRrSjdFK0VROFFP?=
 =?utf-8?B?U3BJcExZMGc4ZXJuVHlteE9kRXhtUm1MaWlEMVh6RVJ1SVU3eFc1YXEvcWZh?=
 =?utf-8?B?eW41WXptSHh3NVFUV21vSTlmQXlpc0kvOGtsQ0J2bE83Y1hmZlVyRmJISEQ1?=
 =?utf-8?B?cVRBSS9mcUFoc2pBUUhvNWxDazZ5K01ONkdkdFUwZm1rTGpmcXhQVWhRNXBo?=
 =?utf-8?B?dnlrL2s2TFBidk1kd211alo4VThJM2NINkFDbkplVTdkK2pwamR0dFR3ZlBE?=
 =?utf-8?B?cFNIKzF0WGVyWVdUVVFmUTFUL0lZbkp3aFYvbEl4M1Erc1hFVG02Zk9lU3dl?=
 =?utf-8?B?dmVxUVM4Wjd3WTFld2V6WGthbkJDWUZzN2htOVVuUEpvellhcTZKemVrS1dK?=
 =?utf-8?B?cklDRDhYcEk3eURjRlBQakRIMzFaUlRjMit6NVZMYnp2YW12Zno1QTBuR0Ev?=
 =?utf-8?B?K2JvdkZsNkE0YmQwNE94eWFsMURjalAraXF2TzBpNVF5SjVPL0N3UjB0Wkk2?=
 =?utf-8?B?VUhFOFhCcFpZZjdqM1dZWXlhMW5RZzhZR01hWHdDLzJyeUR0U1ROQlR2QUt4?=
 =?utf-8?B?QVdDK2U1ZjNWc3ZqZUlBbThJRWt1Vzd4SVRyWndvL1R0VWJ6R1N4cnBMK01F?=
 =?utf-8?B?UW5yNklTdkFQbkx6Qzd4Qmx4Sjg1MHlCY2RocUViZXNjSlZkMG8xNGtPa3ZY?=
 =?utf-8?B?ejdJZzNYZ0JxWnVCS1gxbjJKeUw2Y2VjMjJodjNsaGVGankxN2ZZeEpOZlFa?=
 =?utf-8?B?M3ZKUXA4bFdIUlMwN3dzbVFRdlNKa3dZdUd6bzRXdE5WSFYvSEwwTlM0SFcr?=
 =?utf-8?B?L2VxTVZoaEdlMTg5a2dtRnBsMFJaMk9tWnQwYitubzhiNi9PemlTQVhuR0xG?=
 =?utf-8?B?MVM4bGV5a0tIRFk3NXZkZys0UmtiVXdRSGM5YllNT2hHMXA4Y0l2L1M5eTZz?=
 =?utf-8?B?bG5lS2pTMHFmZm96dHhiY2VnQ2dPOWNzWVhaWjcxR2QzRWc3MlZEVW1wNkNM?=
 =?utf-8?B?c3cwRG1tZ1JPdVYvbzZhcUFTc2UzbmpCNkJFK3dqeHhHS0lacHg1Y05LdVRD?=
 =?utf-8?B?MkN6WElhb1RqU0tiTjVRc0RSZTFNNG9MNU84SmFyY0ZXM0ZTUUNTa3FsNkNr?=
 =?utf-8?B?bTJKaDV6OWphMHVTMkhGRUFGSUpnSDY2dVFUNWQ0cjM4dklGbG9oNVJNeDF5?=
 =?utf-8?B?WXMrWE51YU5jUkppbTFuR0x0QkdpQjZBbGRxSmNyNTFUdEVraExlTzdKckdi?=
 =?utf-8?B?MXIrZ0w5cll2Um8rbUtyT3cyVGhwV200YlRJUnRYekRWbnR0Y2owend0R054?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90E55D8030E7D94194485D25F39C7898@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	irXhNhwZIG3zPeGy8I4HXMNxe40QC2LFdiEB+/e9RLViMNXDq6oHSmLNwgZoZ9vwtqsUH9Euj/6TmBfo5EhywUmtT7d5uFzpoZyib6nt9k2SGBGvuDCIxQmnPKC2eSZfRexVj6NbyCRj6noY+SKPAWmdXqECk3vKxCUETMrIFPhBELBZibTAF2VclagXo/VBPRtEJyDRPbCM9MZiEJKTmFLJTXqiLSWolel1AtbBPN0DKYqGwy4loyKU6EfIxJpSFW27PhSd2bm6yfLoze4fadoJCBjPu5Opg9vlzV/plh1JEpx5Kd3BHpRQ/kpDaXUkpxxjVh3gudz0r2qnXdJlHJbhenAZIIrNbSRxKhDu/7UUgmDlCXccbgSW+2f7eZqwMQNfos7n4Cn7TqSD0Jh9BmC7NGmvXs7gQHUyZNGeCKHUqgDjRTMC5/2bwK5RNTSQAGM/k6zPZMQEHsjs2W7zOcx82vBa+a2+951XB7DMdJ+W2nT1r6+7xymr/WNmMya/cbHRkuTD7/k2HpI5BbcOb2bS1vK1PbypQMTI5BgXXPHj0jRUm3WNePLUCzxT9+7ETDxYM3EE4DiJBObdchIG8NOSxp3mwTF5e//pcwYNA4R4VWcRlbqSVN+hAY+z4vHS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102d64fe-d08f-4f44-260e-08de20fcb6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 08:31:30.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fa8afmYhGNRY8rDVX5Ym62zr85pYdKAEX7Nb8TcQf5RwG7+MM5HuTDZoCQ5FmfIvv+ic4SfVY/MGtrPmErWApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8725

T24gMDYvMTEvMjAyNSAxNTo0NiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFRodSwg
Tm92IDA2LCAyMDI1IGF0IDAyOjQyOjMwUE0gKzAwMDAsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0K
Pj4gT24gVGh1LCBOb3YgMDYsIDIwMjUgYXQgMDI6NTI6MTJQTSArMDEwMCwgQ2hyaXN0b3BoIEhl
bGx3aWcgd3JvdGU6DQo+Pj4gT24gVGh1LCBOb3YgMDYsIDIwMjUgYXQgMDI6NDg6MTJQTSArMDEw
MCwgRmxvcmlhbiBXZWltZXIgd3JvdGU6DQo+Pj4+ICogSGFucyBIb2xtYmVyZzoNCj4+Pj4NCj4+
Pj4+IFdlIGRvbid0IHN1cHBvcnQgcHJlYWxsb2NhdGlvbnMgZm9yIENvVyBpbm9kZXMgYW5kIHdl
IGN1cnJlbnRseSBmYWlsDQo+Pj4+PiB3aXRoIC1FT1BOT1RTVVBQLCBidXQgdGhpcyBjYXVzZXMg
YW4gaXNzdWUgZm9yIHVzZXJzIG9mIGdsaWJjJ3MNCj4+Pj4+IHBvc2l4X2ZhbGxvY2F0ZVsxXS4g
SWYgZmFsbG9jYXRlIGZhaWxzLCBwb3NpeF9mYWxsb2NhdGUgZmFsbHMgYmFjayBvbg0KPj4+Pj4g
d3JpdGluZyBhY3R1YWwgZGF0YSBpbnRvIHRoZSByYW5nZSB0byB0cnkgdG8gYWxsb2NhdGUgYmxv
Y2tzIHRoYXQgd2F5Lg0KPj4+Pj4gVGhhdCBkb2VzIG5vdCBhY3R1YWxseSBndXJhbnRlZSBhbnl0
aGluZyBmb3IgQ29XIGlub2RlcyBob3dldmVyIGFzIHdlDQo+Pj4+PiB3cml0ZSBvdXQgb2YgcGxh
Y2UuDQo+Pj4+IFdoeSBkb2Vzbid0IGZhbGxvY2F0ZSB0cmlnZ2VyIHRoZSBjb3B5IGluc3RlYWQ/
ICBJc24ndCB0aGlzIHdoYXQgdGhlDQo+Pj4+IHVzZXIgaXMgcmVxdWVzdGluZz8NCj4+PiBXaGF0
IGNvcHk/DQo+PiBJIGJlbGlldmUgRmxvcmlhbiBpcyB0aGlua2luZyBvZiBDb1cgaW4gdGhlIHNl
bnNlIG9mICJzaGFyZSB3aGlsZSByZWFkDQo+PiBvbmx5LCB0aGVuIHlvdSBoYXZlIGEgbXV0YWJs
ZSBibG9jayBhbGxvY2F0aW9uIiwgcmF0aGVyIHRoYW4gdGhlDQo+PiBXQUZMIChvciBTTVIpIHNl
bnNlIG9mICJ3ZSBhbHdheXMgcHV0IHdyaXRlcyBpbiBhIG5ldyBsb2NhdGlvbiIuDQo+IE5vdGUg
dGhhdCB0aGUgZ2xpYmMgcG9zaXhfZmFsbG9jYXRlKDMoIGZhbGxiYWNrIHdpbGwgbmV2ZXIgY29w
eSBhbnl3YXkuDQo+IEl0IGRvZXMgYSByYWN5IGNoZWNrIGFuZCBzb21ld2hhdCBicm9rZW4gY2hl
Y2sgaWYgdGhlcmUgaXMgYWxyZWFkeQ0KPiBkYXRhLCBhbmQgaWYgaXQgdGhpbmtzIHRoZXJlIGlz
bid0IGl0IHdyaXRlcyB6ZXJvZXMuICBXaGljaCBpcyB0aGUNCj4gd3JvbmcgdGhpbmcgZm9yIGp1
c3QgYWJvdXQgZXZlcnkgdXNlIGNhc2UgaW1hZ2luYWJsZS4gIEFuZCB0aGUgb25seQ0KPiB0aGlu
ZyB0byBzdG9wIGl0IGZyb20gZG9pbmcgdGhhdCBpcyB0byBpbXBsZW1lbnQgZmFsbG9jYXRlKDIp
IGFuZA0KPiByZXR1cm4gc3VjY2Vzcy4NCg0KSW4gc3RlYWQgb2YgcmV0dXJuaW5nIHN1Y2Nlc3Mg
aW4gZmFsbG9jYXRlKDIpLCBjb3VsZCB3ZSBpbiBzdGVhZCByZXR1cm4NCmFuIGRpc3RpbmN0IGVy
cm9yIGNvZGUgdGhhdCB3b3VsZCB0ZWxsIHRoZSBjYWxsZXIgdGhhdDoNCg0KVGhlIG9wdGltaXpl
ZCBhbGxvY2F0aW9uIG5vdCBzdXBwb3J0ZWQsIEFORCB0aGVyZSBpcyBubyB1c2UgdHJ5aW5nIHRv
DQpwcmVhbGxvY2F0ZSBkYXRhIHVzaW5nIHdyaXRlcz8NCg0KRVVTRUxFU1Mgd291bGQgYmUgbmlj
ZSB0byBoYXZlLCBidXQgdGhhdCBpcyBub3QgYXZhaWxhYmxlLg0KDQpUaGVuIHBvc2l4X2ZhbGxv
Y2F0ZSBjb3VsZCBmYWlsIHdpdGggLUVJTlZBTCAod2hpY2ggbG9va3MgbGVnaXQgYWNjb3JkaW5n
DQp0byB0aGUgbWFuIHBhZ2UgInRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0gZG9lcyBub3Qgc3Vw
cG9ydCB0aGUgb3BlcmF0aW9uIikNCm9yIHNraXAgdGhlIHdyaXRlcyBhbmQgcmV0dXJuIHN1Y2Nl
c3MgKHdoYXRldmVyIGlzIHByZWZlcmFibGUpDQoNCg==

