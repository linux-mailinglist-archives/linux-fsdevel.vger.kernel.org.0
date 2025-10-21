Return-Path: <linux-fsdevel+bounces-64849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E43ABF60E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662603B680F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03432E731;
	Tue, 21 Oct 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bvn8AEaF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Lq/UBX80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB332D0C2;
	Tue, 21 Oct 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046257; cv=fail; b=c4WvetPR5f4ZkLiJjO+qH8DH1JGGN2hsNlyi7/HTHeebtX4JmM1JUex0znaMm9PnwhLS2yeW5M26XFI+6VE2hEN5aqQR/cgi4Ccyl/FAf4wMVek61HUzL1ZklSxlnn8C2wCPHiJG9rrCfK39A/zJe4p9GTnbtzW5OYMRcr8kYx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046257; c=relaxed/simple;
	bh=YnegZYtqZ0uvDHbO+5L/yp5jL+q556Eb7mqV5dSowOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMkshFLUoYYxiKswnZPh8J+qnXpNFzVtqMAfVguW29dvYtQNTiz8wsLl94TeRUSIfhvq/gx85ZbxXVanLhDBwz22qHtw65ewL0RLuAkFW1h5Higt4vTh6inhXDdrWxJ1KC6sr8NfTQ2qOoz2O5g/GffAOcjF9QzzaEO7FIdXfqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Bvn8AEaF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Lq/UBX80; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761046254; x=1792582254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YnegZYtqZ0uvDHbO+5L/yp5jL+q556Eb7mqV5dSowOI=;
  b=Bvn8AEaFKZlI1/bdJR8m4aFxGADmb9Bs0Jbbt1bw4z8mtkrwtpILMFOf
   xwo7JB/wnCNRNKXKWEd9jd2LypP4YEH+6ry7HEIJHiHhqoYGA6AviyH4S
   ufn0fLe7hCaJrkpir+QV2lqPLsPuRrHHDroCSKbnNrO0f6OySrIctbZWf
   /k+Yj3t3tJIwRUQxS4j4xK5AUNF7/mzWH83RkHwSksIw3ad9GLuOehycb
   U5xTBLEUN3AfkJ1BgUhLl//VlI6vdaMk86asnefUjnTXIX5afCm3I45M2
   FY4EWJIwEsd69DjmKC1ME8EFVr5yvy2XtWsB4Av4Q/A5RbGii2BbHDvnn
   A==;
X-CSE-ConnectionGUID: dNS4K/ZeQjOVl1mTr2Dr7g==
X-CSE-MsgGUID: VOStqeN2RBqikvCOz+b6uA==
X-IronPort-AV: E=Sophos;i="6.19,244,1754928000"; 
   d="scan'208";a="134868425"
Received: from mail-southcentralusazon11013054.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2025 19:30:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcVlFpq6/mZ/m3txzI1PoDe/BXaxqmFq8ovL5P1xTkzYxFoag3NUgJc0nae5Lmw9ugr/MsJGc5/lZKmldd/NkgoexTlPv5Rxkb9h0HNSkbq+eS+7LOU5la9B4LhNcE6fTNOItLkKSU9pudmgPi7scltrEKzEcfHpz7JtpJobfjCN99+NHIfANs96rIDD6pxhXXXN1MS9UXIlaeJyw7n1kpYfIIPCvm1CVW/OLIeJCPoy2up72lfRozVGTq5cOLXJQRW2x8DkG2wHq/AnCUj1dQtwTQl2ba+Illi5UgypYCipLZ4D+ldllMDlfzgK90DR5XrgIh8mUUIECq76blz76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnegZYtqZ0uvDHbO+5L/yp5jL+q556Eb7mqV5dSowOI=;
 b=FJEABoxqk0W+gJ3A2KyqYuxSFK86cBGpJiFRpsYPV/wQJHra8nEmez4MRsEv+W48u4fkoieZhFNVzljkzYbqd/CgZxnEoNC5ZdWBl29ROl5AD36qlCQb46rBDOfNsKL/+yAsBt2IrpUOPuV+nnK8KqndrU/TsZFFRopQjfccOgibz7TyErXtqZGfkuZe7A3VZeq2W4Omz1IBV4AKTEcKacYQ8ERuKmpA4qfe0RrCQxOiDdzUSMbAgN2SPDo4WQIWqJuZrMA0utzzjqCgX7/uliAa5x4n4EA10hIUoE8KrNWSAfJJPP5GSBRFvA2iQQGlBjtkNq7GhLpB+0piRK40VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnegZYtqZ0uvDHbO+5L/yp5jL+q556Eb7mqV5dSowOI=;
 b=Lq/UBX80Nc/H9aRLFQV08yyvcyXIBllBm1SJRjJN5xsrLSArlKHAoGMOCl82ylONGwXoWH3NIFsI8S0rhTnkF6OK1FMZrtV9pplNyoy9JcpDB1Q5AZchR05xMLMeJfjy1ow/z2jywsHl/TrnfBK5VR6tiJv41Ck5jOvIcxEhfZs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CYYPR04MB9029.namprd04.prod.outlook.com (2603:10b6:930:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 11:30:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 11:30:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "hch@infradead.org" <hch@infradead.org>, Qu
 Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"djwong@kernel.org" <djwong@kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "jack@suse.com"
	<jack@suse.com>
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Thread-Topic: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Thread-Index: AQHcQaLQW/VaEMy5706D8S0d134oFLTKzYWAgAEhjYCAAEu9AIAAB66AgAA2gwA=
Date: Tue, 21 Oct 2025 11:30:44 +0000
Message-ID: <25742d91-f82e-482e-8978-6ab2288569da@wdc.com>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
 <aPc6uLKJkavZ_SkM@infradead.org>
 <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
In-Reply-To: <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CYYPR04MB9029:EE_
x-ms-office365-filtering-correlation-id: 8d999fc1-80ae-4d34-5183-08de1095463b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SENoNVlwZUVXdXA2cll3KzhOMGd3TnViVDg3czVDQVRLaENPek1ZRnV6aWdF?=
 =?utf-8?B?OHA0bEYycG45WW13NGZsUDQ0bzFOKzhVaEdMelE3VUNtTVZFRHJnQVBSL2dy?=
 =?utf-8?B?eEYrM3RKRm55a3VJbEZrNCtVMFRMWXN1aEZ3TGNGejZDRW5tejlkMHJEK3gr?=
 =?utf-8?B?OGtwYk0wNWhLSVpsL0Z5WXVkMytMSEVuYkJ6VU1iWS9jSnp3bkNZNVBpN0gx?=
 =?utf-8?B?cHVCVFYzNWZwbWoyNFZDUkVBa0ptMGVpVzNQNjlTR0xlZ3M4SlZ4aVJWMENX?=
 =?utf-8?B?L1dzcFR2M2RuZXB6QlM1RXpPRUpQY0pYT3ZrTjlYSEpCbmlrb3JyTEQ5MmJl?=
 =?utf-8?B?TUlDM05LZ215NEJZVG1uVER0a0NubUtzcThIMTB1WExIc1AvendSZ3FoOGRv?=
 =?utf-8?B?Nm1vekRtQjJ3dGlHSTJHOWtITEJyVkhtNWkxR2RscERIWDlnSlZxU0FpRkoy?=
 =?utf-8?B?ZGFmcmtuZDJXQ24zcTVrZGU4SzhlUWhMTEVqOGExbXd2ZHQ3U0hzNEJQb092?=
 =?utf-8?B?U0N0SklEdFhudldNM2xISW5iK3V3b3lSck45OEVtV2h1ODRNSEc1RkRjSlYz?=
 =?utf-8?B?VEUvWmFLeDVVUUhTMTdyUnJOZVV1dnl2TU5PZUJBV0JBQTJBTkZITWN3N0cr?=
 =?utf-8?B?ZDEwTWZ0aHJtSFdlY0doSXRjRTBNK3IyUTJiM2c2dms3eHlxak1uVXlTNC9h?=
 =?utf-8?B?NDdTSHVHYy9jbG5CeVBobmZlUjc4MWZlT20xaVRwdzBPVTNjNXRLam4vY0xS?=
 =?utf-8?B?WjI3U3NWQ0Q3TzIwRStPa1JqaWNWRE5PdnhRQXpEUXE1WS8yQm1icVRJU3JK?=
 =?utf-8?B?UnFBZVBoQWpqOHpaK3lsbDRRSmFXR1g2NlVVeGZndmVDekh0QnFBUW1LSEU1?=
 =?utf-8?B?dmdNSHM1SG8yREE2VXROTXlpaUxlYUJ0blhqQmhQN3RlMnhJc2p0b0JQRXFN?=
 =?utf-8?B?NWhKZEF0YjFNYngrR3BaRTdyUlBLYlgvQ2NRWXpFV3YzQS9OSnEvSjlwQWM1?=
 =?utf-8?B?U3dsSWRTdUxleDlwb3F4RXo4Vk1oa0tBNEVpVllXV0E5c3hHL3ZZdWpOeTJO?=
 =?utf-8?B?aG9JQlZqdTVtNXh6Ynlscmt2LzNqQWdWODNHQVJiUXlRN2ZucUxoa1NOaGpE?=
 =?utf-8?B?ZVpkZWdJM1VBeGFXS3h5WUNGektTTDZ0WTFKL3lnTTFoYmd2QTBJZ3JvR3JB?=
 =?utf-8?B?M2FiTEhvalZTanlhSm1QMDJMZE1qZmduQUJlSkVQbCtxMzZPQmtKUnZXVzZo?=
 =?utf-8?B?RXVzeVZhcElaYzdNTnB1bVk5bFcxYjE3OHBtZnF3a1JlNFZPZGdqTHRMZTFT?=
 =?utf-8?B?U2orY1RDUDBVaFVocTJMRmdVSk5OMU1kNVpPT3l2SnBzZ3I0S2lXcThtWi9D?=
 =?utf-8?B?MWFNVjdvcUlHdGZBU0ZpVVltOUtDWnc4YWVxaHhMUmxMMFJHMkp0SjE0UnIr?=
 =?utf-8?B?eTlzY2sxSTJXa2VmOU5neHY5QUFrU0R4SUJHU29QcTFvWGlFTWlSVmRRTDBr?=
 =?utf-8?B?UjA0QnR2SjVnZk85VXNzZFlNNXhMcjU3T3BwdkUyRkdROUcva3BTWEZBdUg4?=
 =?utf-8?B?WmV1MVVYSHFHZTNsODgvK2xTV29kbE9DUXV2ZXNRQ3pBeTU0WW9tY3Z1V0Y2?=
 =?utf-8?B?QzFuWjRGKzA5Y2FOZVNkMVViNUg4S1U3WURCV2NjZ25uOFNVSlJGLzJIZ3Vp?=
 =?utf-8?B?cWNCTGFGdXcxSHhHZmlIQjVsSStOWTNGZVlEVWJnd2Y0bGpEczA0TE0xbHlV?=
 =?utf-8?B?UHQ2ZFQ3WG5RdnovZkZLMFFKdUlucUF5L01KaVEvSlpLODVvUVVDL1dDRDZu?=
 =?utf-8?B?bHJTRXd1dm5xQkdRQWZTMWhlckxFTU9mVXpucThhbzlibjhMZEtLWlFRTGNS?=
 =?utf-8?B?bmR1YjcyeTJ2bkZ6Tk9hZTRod0J6SzdYZ2Z6bnRpaXBHWU5UbDJ5YmxYM1N5?=
 =?utf-8?B?Q1hSUEJtUVdMdGdZUG80MElWbnNOblhsRWVtWTU5T0NNMkNVLzhQcmlzaHRx?=
 =?utf-8?B?UkkveHZVd2Fkc0F0b1pJSDZQYVIwKzRpVkd3bkxETG9idzBHc2pWZ3NOald6?=
 =?utf-8?Q?IbuU2Z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnNoclhOM1hjZW9yaUpsQ0taUnpJeGlEYXJCUFBCVE5hL0ZZYWx6UEg1RVVo?=
 =?utf-8?B?UStmYlFvV0NKbFlXRCs3WExpYkhKa213UGEwSFlaT2NMZ1o2S1BEWUFYS0Y3?=
 =?utf-8?B?REtOZGYrN0RFTW5ZbE1qTkZkUkp1eGxaK25HTHpBeXdzODIwU0Z0UXUrZGJC?=
 =?utf-8?B?K0NaTU9pU2c4TjlPWW5DWmxPcDdtT3lzM3pnY0YrMmFzUTJRRHM3R1JlVW1X?=
 =?utf-8?B?NE5jQ1B5ZVJmMjZ1L3R4RVA5YnRGQVRobitLWHpjTUtlOFJ1cDlTNHlKMmFG?=
 =?utf-8?B?Nk1aOGdYam9zanR4THJkbU9aVXVFeHVxc01qYWtNQmJoT2dVOWNEOGpqdFcx?=
 =?utf-8?B?cXN6YWxxRDBHd2pMenJpV29LVEdwTTJVdW13TVBpd2c0SVFSczJNNnZTTXV5?=
 =?utf-8?B?QWVBTmNLWFFsMEdOMTd6bG5qUDNGVGxKOVZIeVFGL1pmdmNrYXYrM3kvU29D?=
 =?utf-8?B?Vmd2aFdqamtCSUNwcVJCLy9GN1JVQUZ0SFFWVW5YcTlHbFlZM29Vc05vUHVH?=
 =?utf-8?B?MDZUamFSN2NpN0dEMGgwYjBrUmhWRWZWLzYvQXE1UnZPR0IrdW5wOTNpZEVQ?=
 =?utf-8?B?TjJhQWhOR1RXdldHVE9MaWhrYWc5c09hamw1VGhSS2lWVGZUS1Y4MzlxbXFk?=
 =?utf-8?B?dEk3WU53cjk2aEtENkplQ1dpaDdJSmxmQUIxS2ppY0w0WnhjVjhtU0JqdVV2?=
 =?utf-8?B?cHFHK21tN0QzRkJZY2JCRDU3YlVVeHpLdHZ1eU5XWUpVMGtEenc0UzRPakVY?=
 =?utf-8?B?L0h6b2hUQjZ5VWZKbWYrdnRtYjYzd1l3L3YvYnZnb1JmVVBNc044ckpLbE1M?=
 =?utf-8?B?NXdIL0xHR3dzRjRtd2R0K21zMERza2FUQkpyaXlDNjh4RjdsR053aDJ1UE5J?=
 =?utf-8?B?RVhzVStzTEtvZzNFajRqUlNOSGpYT1lHZkVXWlhCdFBiU1RTOUJJb2dnWFBC?=
 =?utf-8?B?T1FoZnRoM0JLeUlMRGx6dTNVb0pQZHBVMHRiSERYOERYVGJ5VlpCRkJhcWE4?=
 =?utf-8?B?MXVIeGRwODJoSDhHMW8xL2FkelpReTdhSWdqL2xpMCtzWTRqeUVSRVNEQWFP?=
 =?utf-8?B?YnRFN2k3em1OK3JkaEd5SkxMSkE3Y0VUV1EyZHlRdXRTelRYS3ZZdE5OQTJv?=
 =?utf-8?B?OVB5MDdkcVU0MkZjeVdIUzlqdlZNbUdNTVVRTTQxa1VMSWJkeUxBWVBnQmtt?=
 =?utf-8?B?dldhTjBzUGllZ2NucGJ4Y2xNSk9pVVFUdEo3YmxSbSt1T2VGLzJyU0tOQ1M3?=
 =?utf-8?B?VjFiYXl4WHl1T1dGMGg1b3gxZjVNekRnbStyVC9ONkFmVTE0ZVNOYTREdDJv?=
 =?utf-8?B?VnZPNXAwbXdrbWozM1c0RTNhMkhJZXpTWXJrck0yK3NJQjc0VHozNDZ1Y2U3?=
 =?utf-8?B?cGk4SDBLNzhXUUlhdFRoV2xEc0U2L1A1ZFdLU1N5bElKS2FrRCt5TU5NdHRY?=
 =?utf-8?B?a3NYbS9hT05OWjNmdnlvL2phWENKTzFHLzQ4QXVPSDhzUzduYlhtMW1QaDRa?=
 =?utf-8?B?YXBYYXRIRWlGSTdkdkNEdVN1VWs2eWFyODF6cTI1OWhRaVY1bmpFRDIrcVRh?=
 =?utf-8?B?QUpOZitidlhGZmVXbFFFT0l0L3F3ZHU2VVZNdjN0MzBSWTBtdUMrTURhOUUv?=
 =?utf-8?B?UlFaNERuY0NxQjZ2SDg2RU1Rc2VPbERpNTZ3eERlVFY1UmVjME5wQ3E2QUxM?=
 =?utf-8?B?TTBvUGF0RWl2ZEprWUNiQS9TVEZiSEwybmdib21FcXZmYUx4SDZvVXllNVh1?=
 =?utf-8?B?MlB2QVlSOGlzV1dKVkp3Ri9BMnFFVGpVeGRQNVNMV0FmVE5TbEtaWDBleTdD?=
 =?utf-8?B?dmtFQityR0VvRHdsVEVsWk0vdUpQWHNTdUpTVmNVVk13UTJJWW92dlYvNzVI?=
 =?utf-8?B?UmU1RHVvRVdoZUMvNUhHYVdiS2Y3cmNKUDM2UHpRU3hiVEUxUUJtZlg3SnBU?=
 =?utf-8?B?VGJBdGNUdThrb01ITXhYczB6VVdiTW9MYWlHMHVldGo3KzJCck1IeEtDczVR?=
 =?utf-8?B?N09ldkJpcmkrWjZxOGJEdS9iWTRteGFKRHQ4SVJsVmRWanNRb2RleUo3MDRw?=
 =?utf-8?B?YnUwWi8wVG9GeUNIcWNJZWxJUm5MRytrRy9NeVJyakdzSU44aFJrMlNzN3N2?=
 =?utf-8?B?Z3hObGsvQkJFNGpaTFpzNzg2YXVwRXVzMHpMZmJaa25xdWYrSmc5MW5WNjF6?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6F5D70BCEA18246A89BCAA4A52F850D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VCP9LnPkCpQ2RQeLKuUAVS8uaQxB52YZgCKgO2tqeD7ArX76uceyHIsnfR57UFwVu6h1B/veGg1oVIk3+7NKveVdNrMrl59uCMf/+MCFFhsJy0fjytIk7T+7OsQZqP05/Dc+BET+/Gl2+GxnEKfSXdtGoFP0Zt8hC2VAkNAfTIOcxOgEgXemKOEiEhLUW3M6rQEnTP9Chv7WVBlLTqPwuU8pLp5wEQTKzMMr0tk6Nm7hnJlpCAKJdL5YxGDGsN9Ys+pLL4cbD/VzxT5DOj9iwvkjV6/gqW1nN8QlEYV3xdAEYd4iPDdl5LDU8kkfI52Zr7UVFAyTrP530lQqsILg41phps2WdT4zzmbEZwsOik3lZVJ0J+zyF0RTT7LjVM2sirDDpjNHZ5jj2iJSv3MDGKvj2+bafoFViElHYSC3JJ9woNc8VOiDRthGj6HVQL+WVf/jDH3871uksT96vexFPJeJTYmQthcXsRI6lYLfcbABIePAb3+UOm6eYFtH6vAsser7mt9CVsHkvnfxlH3bj5sIdUOFETZknaTr7e71Kr1iKfiWh+QKSjeOkBzO4bDvdhP7lDXL2QnXT95XMq+SCfC41TcaGWNpReaduzIoMaHH8BIqwKFlBsbxOKPDM7/t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d999fc1-80ae-4d34-5183-08de1095463b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 11:30:44.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n84j5vRYUwIaw2cdBXR2ctZgygWb5J+rOIVIzFf2sNq5mI79BixmhWBveO6hmOsZtxZqUrWtcPkc26rano/wT3BLyFOFXj6EiGUVWzkfE7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9029

T24gMTAvMjEvMjUgMTA6MTUgQU0sIFF1IFdlbnJ1byB3cm90ZToNCj4NCj4g5ZyoIDIwMjUvMTAv
MjEgMTg6MTgsIENocmlzdG9waCBIZWxsd2lnIOWGmemBkzoNCj4+IE9uIFR1ZSwgT2N0IDIxLCAy
MDI1IGF0IDAxOjQ3OjAzUE0gKzEwMzAsIFF1IFdlbnJ1byB3cm90ZToNCj4+PiBPZmYtdG9waWMg
YSBsaXR0bGUsIG1pbmQgdG8gc2hhcmUgdGhlIHBlcmZvcm1hbmNlIGRyb3Agd2l0aCBQSSBlbmFi
bGVkIG9uDQo+Pj4gWEZTPw0KPj4gSWYgdGhlIGJhbmR3aXRoIG9mIHRoZSBTU0RzIGdldCBjbG9z
ZSBvciBleGNlZWRzIHRoZSBEUkFNIGJhbmR3aXRoDQo+PiBidWZmZXJlZCBJL08gY2FuIGJlIDUw
JSBvciBsZXNzIG9mIHRoZSBkaXJlY3QgSS9PIHBlcmZvcm1hbmNlLg0KPiBJbiBteSBjYXNlLCB0
aGUgRFJBTSBpcyB3YXkgZmFzdGVyIHRoYW4gdGhlIFNTRCAodGVucyBvZiBHaUIvcyB2cyBsZXNz
DQo+IHRoYW4gNUdpQi9zKS4NCj4NCj4+PiBXaXRoIHRoaXMgcGF0Y2ggSSdtIGFibGUgdG8gZW5h
YmxlIGRpcmVjdCBJTyBmb3IgaW5vZGVzIHdpdGggY2hlY2tzdW1zLg0KPj4+IEkgdGhvdWdodCBp
dCB3b3VsZCBlYXNpbHkgaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2UsIGJ1dCB0aGUgdHJ1dGggaXMs
IGl0J3MNCj4+PiBub3QgdGhhdCBkaWZmZXJlbnQgZnJvbSBidWZmZXJlZCBJTyBmYWxsIGJhY2su
DQo+PiBUaGF0J3MgYmVjYXVzZSB5b3Ugc3RpbGwgY29weSBkYXRhLg0KPiBFbmFibGluZyB0aGUg
ZXh0cmEgY29weSBmb3IgZGlyZWN0IElPIG9ubHkgZHJvcHMgYXJvdW5kIDE1fjIwJQ0KPiBwZXJm
b3JtYW5jZSwgYnV0IHRoYXQncyBvbiBubyBjc3VtIGNhc2UuDQo+DQo+IFNvIGZhciB0aGUgY2Fs
Y3VsYXRpb24gbWF0Y2hlcyB5b3VyIGVzdGltYXRpb24sIGJ1dC4uLg0KPg0KPj4+IFNvIEkgc3Rh
cnQgd29uZGVyaW5nIGlmIGl0J3MgdGhlIGNoZWNrc3VtIGl0c2VsZiBjYXVzaW5nIHRoZSBtaXNl
cmFibGUNCj4+PiBwZXJmb3JtYW5jZSBudW1iZXJzLg0KPj4gT25seSBpbmRpcmVjdGx5IGJ5IHRv
dWNoaW5nIGFsbCB0aGUgY2FjaGVsaW5lcy4gIEJ1dCBvbmNlIHlvdSBjb3B5IHlvdQ0KPj4gdG91
Y2ggdGhlbSBhZ2Fpbi4gIEVzcGVjaWFsbHkgaWYgbm90IGRvbmUgaW4gc21hbGwgY2h1bmtzLg0K
PiBBcyBsb25nIGFzIEkgZW5hYmxlIGNoZWNrc3VtIHZlcmlmaWNhdGlvbiwgZXZlbiB3aXRoIHRo
ZSBib3VuY2luZyBwYWdlDQo+IGRpcmVjdCBJTywgdGhlIHJlc3VsdCBpcyBub3QgYW55IGJldHRl
ciB0aGFuIGJ1ZmZlcmVkIElPIGZhbGxiYWNrLCBhbGwNCj4gYXJvdW5kIDEwJSAobm90IGJ5IDEw
JSwgYXQgMTAlKSBvZiB0aGUgZGlyZWN0IElPIHNwZWVkIChubyBtYXR0ZXINCj4gYm91bmNpbmcg
b3Igbm90KS4NCj4NCj4gTWF5YmUgSSBuZWVkIHRvIGNoZWNrIGlmIHRoZSBwcm9wZXIgaGFyZHdh
cmUgYWNjZWxlcmF0ZWQgQ1JDMzIgaXMNCj4gdXRpbGl6ZWQuLi4NCg0KDQpZb3UgY291bGQgYWxz
byBoYWNrIGluIGEgTlVMTC1jc3VtIGZvciB0ZXN0aW5nLiBTb21ldGhpbmcgdGhhdCB3cml0ZXMg
YSANCmZpeGVkIHZhbHVlIGV2ZXJ5IHRpbWUuIFRoaXMgd291bGQgdGhlbiBydWxlIG91dCBhbGwg
dGhlIGNvc3Qgb2YgdGhlIA0KY3N1bSBnZW5lcmF0aW9uIGFuZCBvbmx5IHRlc3QgdGhlIGFmZmVj
dGVkIElPIHBhdGhzLg0KDQo=

