Return-Path: <linux-fsdevel+bounces-59341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30DB37A64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F5D1B23983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738A2E7F2F;
	Wed, 27 Aug 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kPF7i0lM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9621CC61;
	Wed, 27 Aug 2025 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276290; cv=fail; b=Wsi8F29unjmIYnCCKYMDGJ8AFnpQTFT6+fMl3zXDUQqnGmQyCAvlQX+qlmjkAhx+5zcocve02Ckq/PPe88CJS1PcSEIx4PNik+g3y5mzLfCUATnejZUCnK8bMiHcoV2r2e0lzk05pyxBBcO2So1NBJYWwnh7pAqnQ2ouqRqGgvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276290; c=relaxed/simple;
	bh=yJ6WhbI2IVadSwzkdm81vyc9cX3rGw53rvnaWzPiVUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u84f6GixRns8OS1C9JX6uyz3yTc/GQVvPnfNID8kiirgTsgyGcMz6bwPszaG1CS4oFztQ8qqkBpw0bw5SP7x1zIaaPwioEK1xW7bOmVnc62PJq6qhKlc3l+FvBnZ7j1M1pphb+bNrbxmeyquJ51P/dtqLB0FaO4+uHOr5L9nEkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kPF7i0lM; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756276289; x=1787812289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yJ6WhbI2IVadSwzkdm81vyc9cX3rGw53rvnaWzPiVUQ=;
  b=kPF7i0lMYCMH8dAQ/ngeia7yiVt9mcxOweo+huRhR+fpcGFEd0iw76MC
   Pv9ctyMeoG7S8Y5DMs+1i7oogX5r7mSS4gM8480CoRoJkC/Mf+Mt46EfV
   dN7XmAFzroM76PgsnRZP7Gx9+SI+WAEJD/USchuybGjA6DpDIDDtJiZgG
   TWPlSPZcVlri5tFum5fQMFPXGMoUHDj78ctd+xT5BJuszTMvrADIpsn1n
   VmP5UeSfpGVjd8uToBmBg80Hj8aP1CeYtkHp8h5U1XrD1PnRJ84fIRjYu
   nqsevpZbWOhxKzDdePLe0Uq4xgdG78cVLUN1aHQjoeRIPaCHG5uGD6B74
   Q==;
X-CSE-ConnectionGUID: BVjKZacDT+OyKgF1mXtxIA==
X-CSE-MsgGUID: Q2NPKodaTBixTzxUZC+ELg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="165838549"
X-IronPort-AV: E=Sophos;i="6.18,214,1751209200"; 
   d="scan'208";a="165838549"
Received: from mail-japanwestazon11011020.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.20])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:30:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/zIHd/fhwEyzUdJyUsIRtCiPLQrYz+w0IvWNhAi2bthWjT7SfxgsUBRSscaLEZ8xu5DZe07SXhyVd3+BFWlTM0FgYTksPEF+yi8JJMc1S6sD6YrZuVRoh1FZiaFX5USNpO5Bv6MJKdLVjfdEkVSNgIM1U7IQVa0+iTu+kEGVxxUc4nptYTz1ZimW7RAlFf9ZnjbBEId1hFibPl9zzurbpHMpv7hEMm8Rn5V7ERXACjzX29mQf//si7FR8f7jAKYP0aeaxNwOftDzmv2zdHoI2CmuSDz5SckW/fjxu8C1hzvWgijzkytGHhkeTzs9ozQztlt24S0GQ9g5LIv9QvQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ6WhbI2IVadSwzkdm81vyc9cX3rGw53rvnaWzPiVUQ=;
 b=ZQ7wa17lg7/fvpw5xrCh4pBjKUxLqa/CVTEbB7fph/Olx08sOvt7ZlJfXGFBgn/PkIQbEbGTBFOqIM4W+xRfSBUz5h1z7aZU8yfZQAJExNvou6H4pchNdzkJ7+ECYzo6MT8uxzUcmQGNvocSstP8ZIDe6yt5O1b+ecB3JQ2uDeUcP7352/zWP7e0lj1kFU/r4FcEOIhWAanfaBp22ZrA5nwnUzCr8ul9qq4/3LNoyPrQotHLVawCIkd6rJ0HqEoa+TFHnFuN2eZ/UUw0Uy5dKtGnu/kMTb8bdHuj4iIzMF2H6KzHDwv7Md1b8CeoZdrNsT0xHnanZfc7iJpaEaPn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13059.jpnprd01.prod.outlook.com (2603:1096:405:1de::7)
 by TY3PR01MB9728.jpnprd01.prod.outlook.com (2603:1096:400:22a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 27 Aug
 2025 06:30:06 +0000
Received: from TY4PR01MB13059.jpnprd01.prod.outlook.com
 ([fe80::8d03:a668:cb8a:f151]) by TY4PR01MB13059.jpnprd01.prod.outlook.com
 ([fe80::8d03:a668:cb8a:f151%4]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:30:05 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
Thread-Topic: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate
 with cxl_mem probe completion
Thread-Index:
 AQHb9bLv4zMtn0217k6cvjwtOUPnhrQ/XBMAgACSGQCAE6DhgIAY1fuAgAA2vQCAAapGgIAE+FOAgAMOQYA=
Date: Wed, 27 Aug 2025 06:30:05 +0000
Message-ID: <46b8e026-78c5-46de-97b7-074c1e75fd08@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
 <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
 <aKZW5exydL4G37gk@aschofie-mobl2.lan>
 <8293a3bb-9a82-48d3-a011-bbab4e15a5b8@fujitsu.com>
 <42fc9fa9-3fbb-48f1-9579-7b95e1096a3b@amd.com>
 <67e6d058-7487-42ec-b5e4-932cb4c3893c@fujitsu.com>
In-Reply-To: <67e6d058-7487-42ec-b5e4-932cb4c3893c@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13059:EE_|TY3PR01MB9728:EE_
x-ms-office365-filtering-correlation-id: d4ae8c62-61fb-4deb-5a65-08dde533297f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWU0d28rams0NVZUNThwNExEWXIzNFFiKzBCTmVoL2NrTG5SN3BueFY4dStj?=
 =?utf-8?B?Qk5qaVM2OTd6MjU4WlBGYlZNRlg2aTMzOTVocjRMYmlTdGdpenY2MWhvTG50?=
 =?utf-8?B?a3M4Wm1LOVZ2alAxZ0lWOGthVnFCVWdFdjY2cjRZQ05uV0JpdlJWb1hxYmxz?=
 =?utf-8?B?b0oySmNseThkbUdFUytxYzdqeTdXM3d5cy96azdReFFxLzdScWFaT0UwWlhP?=
 =?utf-8?B?K3h0emVXT2ZpZ2p5QTViQ0kvZElaSGhYQkxkT0lMNXlyM0YwS1VDQkVyUURq?=
 =?utf-8?B?MUhaMys5eGN3VGRiS3A1M0c0U2dSOTlENmV6U2lpY0lDRHRhTlRmbzdMK2hm?=
 =?utf-8?B?WFZGUEw2OS9qb0pmRGVMNmpSUVc3dHVNSzEzODdnQ2VsNUJVdVVYdHNSNUZH?=
 =?utf-8?B?VVN3SmcxTTM5ZFdQZHUvRXF0NDlha1g5UE54cm1OUGYvcm9obGlZMkxKM1Ns?=
 =?utf-8?B?T3RpeTZiSVp1Y1E4Njdoa2RoR2owRDR2K1VQbVBORkIrMHRpWjNScmdDL0RI?=
 =?utf-8?B?MkpJa09IVHI2cW9wejNsNnpWY1pHaGR4ZU9qeWRzNUZSS20xLzVNMGwwRmx5?=
 =?utf-8?B?ZnF2YlRCaVpYdEs5K2hUZnozTTBJUTZ5ZjdKc3dEZVRLSkxkOW5NSnFmdjFU?=
 =?utf-8?B?Z1dTdGl5U2FpU0xUaHZzWEE3WFlpd082ZjczNGxjOHBxS2pqMm11VDcxMnBk?=
 =?utf-8?B?dWNJSWNvQWkraDZVSnVDRWdoVWRuTm9GOThFRWpsUGhMdWlCTEFXWDh0bko5?=
 =?utf-8?B?dGhSUU5ocmd2aE1SSStKOGkrRUFmRGc4VS9MV3BFcEgrMzVIN3ZseURYMFJJ?=
 =?utf-8?B?dkxyelpiZVliYmpWbWM5ZjdWMjBFTGlZV2lCdUxmeXFxVHg1R3RGQnlVTERY?=
 =?utf-8?B?R1JEQkloZFQ3NlVnM0NHbXdOSHVDMWVCVnF4WFp2M0tjbUpCK1VSTUJWY2Zj?=
 =?utf-8?B?cmJ2QndOTmZjaTNpOHBGL25jZ2w4dXVOeDl1N0lrSzBtczZVeGhMZm5uUHV3?=
 =?utf-8?B?LzZya2M5T2xGQ1ZhakhpNURNTUlHenlyR0V1U3BjODBKOXVsVHpIWVpmclJN?=
 =?utf-8?B?akhXNTRJL2syNjgrMllzRkIxS1hEUWJTYTYrdW4xcXprV2p3eTF0RzFvZVh4?=
 =?utf-8?B?eHRmb2x3Y0xLOXNWR0JJTzNyZytBR1dZUG42aEFIanIzVlVsakpmdWVKN1px?=
 =?utf-8?B?Z1pFY1N0c3ZNdzBub3VDUFcrcmZURy9MSkkwZVl2WmhZSm5scTAzV3FKVUFT?=
 =?utf-8?B?R0R2Yy9nREx2R3hHelhscC9UVTVRZ1VLTklzSm4waVY0WkRqYmxMMHBLTU5l?=
 =?utf-8?B?RmF3N2xkNmt4L293SVZ1c3BQTWlkbXArUHl1L0pEd2M2dFFnaVl3aXRjK1I0?=
 =?utf-8?B?dnFDUkZTYzNpWXJzUkRyUFc0MG02RVZYaFNVWG9ja3lucjRkcVJ6M2pub3dq?=
 =?utf-8?B?dSsvaytCTTFlZ1lXcjVtUTIvMFJ1UnFVUVh2eHd6VzhYZU0zU0NKRjA4MGxw?=
 =?utf-8?B?TjNzTDVNRDVBTlk3MTE3d0FOQ2xiQ1htQ3JRSHl6QWFMSE9FdFN5THRUREE0?=
 =?utf-8?B?ei9LT2plT2NJSFdMTUlmbG9EbTJzMm0vZ3Q2NXhOZmxGTWY4K0lnNnlXTmda?=
 =?utf-8?B?WlJwOVUwbEZBdEp6SDdDWjQ3S295Z0RXSWpkTnZHVU1WN1dxeWlDclRkK2JN?=
 =?utf-8?B?YmdhSEQwMW4rb054eTRQaGs0QlNPaUw4ek43a1RjMnpranVNbzNTMjBMVkJT?=
 =?utf-8?B?aW9hdDA3c0JEZDg3UTZ5MWxpUExFL0hzU25jV0F1MGN5eDJaMTVBUGJmbHNG?=
 =?utf-8?B?YU00eGRUS09renZydW9XOFZmRGxYSGhOOFBiSE13bFYwTGRIdS9wSXI3RkMz?=
 =?utf-8?B?T3ZhU1Y5K1JpaHpvbHZDWUplVmlyUHE2SURSV3BQeE9kMjYvS2g1L2FZQ3I3?=
 =?utf-8?B?dGZ5RWUvNHYrSUpraHA4ZCtWeEQ5VEVabXlTcG9BZkZiUWNTbDB1OWxnVkMv?=
 =?utf-8?B?T1MvRXlEYzFxejFLRU81c0loRnI4ZDBOMlZsRDVMMEJKOE1XcmJjNE1Zckp5?=
 =?utf-8?Q?d7Kucg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13059.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UndNQVlaV2hEQ2x0azVNdjVVWW9JSklSYjhKbVN5d00zTUxFVVViUlQvamt4?=
 =?utf-8?B?UXdYVGlVbGNQUlVzZytqdG14b0Q0ZXM4alFxa0ZRRGtoUVMrcHI5SnEyYmp6?=
 =?utf-8?B?M2x5WFJXUHpaSXh2ejlIWDRVVk5Mek96Vzdqbml0UWpId21hcC9pWUI4bGt6?=
 =?utf-8?B?K2Nsc2dHRUE3RjlPRU1EeVhmVFQrVSttUnhmYWlHUGg3emFIRGwxcG0rOVBP?=
 =?utf-8?B?QUhpcWh5dE80TWJVTkhBeW9xa2NsTGZKZThKTU9LdGc1TGVWR0htOENtQ0lz?=
 =?utf-8?B?OGY5cWFtR1J4NWJIamNjSFN2S2V4WGtEd2RWUEhQQ0pNV2ZadWNOUU5aOEtl?=
 =?utf-8?B?czFKYXpNcDhnNVB3dW5PaVNIVXpwbDNUSWV4dzg0MGNYREF5OFYrUDcrSlVS?=
 =?utf-8?B?aW5kMzF2OFVQR3FTb05wNFo5ZFR4UTM2TUpmazZZaWgwd3pNMXc0d0ZMVkts?=
 =?utf-8?B?VXd3OE1GaGJYb25IUkJPa2FKNXdJYk01NGpVeDBoeGlZUmdUNkVva1RGVTFk?=
 =?utf-8?B?WHU1aldJUGFFVVdYT3FBQWZwelY0UHp0UTVtWWVUa3p0d3hLRHF6eEdXQmdm?=
 =?utf-8?B?Ylp1VHNRRnJxYW44TDJaeVRWL3NoV09IQlU0VitlaGxnRmdwV3dRbGxzYlVZ?=
 =?utf-8?B?TTV0cnY2MFRjQzd5ZFNCWGkvMWVMOFM5d0lCaXpsbTQwVTc3WjRzWWY5WmlB?=
 =?utf-8?B?ZkxxVk9rWGo4ZDVXbEZqNEpvNmMyZkZuc2p5bzhoakZtMVdkOUl6cnZJUWhS?=
 =?utf-8?B?Z3VSWTJGTGNZcmV0bjd1dTNjSFljeWF4M0J3dmxOUjMxOWNrRTRLaitVaTRX?=
 =?utf-8?B?UmxlRmlMSHQvOVE5S0VwOTZMMmlFWnR5VjBxNExDOW9mUFNKOS9aaXZVdElu?=
 =?utf-8?B?dldsZkdlNE44M0pDT0hETGhicDRtSDNkYjlVaWp3cnBIS2oyVEFHdGptS29P?=
 =?utf-8?B?RDFHODFoeFBKM2haMWN6Y0t2SVk2THlDQndqNkg3Y0lHa2oyTkduT0g0WkZu?=
 =?utf-8?B?T1dwcDF4OWV2SE54Q2gwdDBSVlE5RWNOY3JlNVFFZkU3TWdkaCtLdVN6dlJu?=
 =?utf-8?B?ank3SXlzUVNoZWtjRElmSURJQmwwb3puN2RHMEhWMTFYejNLazZwSjc3a1Y0?=
 =?utf-8?B?Y0N3SzJ5YnUwVTJYNTNqQitWTCtOSFp2NnN0VndXVjltaE12d0tQeFZrVzlU?=
 =?utf-8?B?d3VMdkV0d2MyVmRNb0pudENORkZEdkZ2Wi9jNlI3V2t4MHRLcnVpZlVDRGxI?=
 =?utf-8?B?RWMzMzB1UUNBb2lVNjgvMG1SSll0TEUzYVpvTXlZUjB1QjdLV0JhOGN6US9F?=
 =?utf-8?B?elRrdHY2YnV1cFluRDB0K2ZwckVRazEwbXh2VkxsbmlzMWdmRDNSdmdPNEpI?=
 =?utf-8?B?d2hReHdJREViMEs3K0QvNWl1Y011TnFsZkVpU3hWdk1McDVORWhsMW50SE5G?=
 =?utf-8?B?TnBsWjRoVFhiK1M3RWd4eS9PL0k3Q0RoTmFCaXdNbGhWYU5mYlVDUFR6SW4w?=
 =?utf-8?B?TnB5bDRuOW95QWNSVkc1eEVSeVF0T1hCRkxQeVZ1MTFUZ1FhblRJN2J6Z0NP?=
 =?utf-8?B?a0p2OVNhOFlmMEFoK05kbTcxZE1sRlgxZ0Zab2pTSEJISHY5VVVPZ3BuK1BR?=
 =?utf-8?B?MURVeFM3cklZeFRwUTJzc2tvU21MSmtjdlM5cTlJaE10RzZ1SkREcDUyVE5p?=
 =?utf-8?B?NjlwdEsvKzlJZEZaSjRVbUlOKzBjV2t4UVZmc1k0L0JoOVdSelQrM21lUW00?=
 =?utf-8?B?MHpJR2s4T1AzSnFaR1BKak8wR3FYWTV4RG96QXdCaklhb041bmlrTVhHYjdh?=
 =?utf-8?B?NkdYU0xPTmhWR2MyVW5iNk1zeUNzQjlJWS9WU3A2bjVzYVdQelo5UnJmV2tr?=
 =?utf-8?B?azdCY0VRaDFIMXFKUDM0V1lNMGIxYmlGQU5TQi91SFJleUt6YmxQcWNyZDZ2?=
 =?utf-8?B?dWlNS1VuMEtpVWhJU3pKaWJaR3BSMGJJNlNROVZVNUlXSTEvTWVYaHJPTDE1?=
 =?utf-8?B?ZlE5QlBPcFI2SnhLZFNGbU1CSDcxYkZObnhzckZ1Qlk0TXhsRUMxM2lMTERB?=
 =?utf-8?B?Y0FxcWdZOTlvY1pUN0RsM3J4cldaaDBMSFdVMW1XZTBuUW9IVHRCandRaWdC?=
 =?utf-8?B?RVZjMmZFMm9tOFBmMzlJdUQySWpVUnNzNGhUMEJrMitnYk81Yk9qV3k1dVZr?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FBF24DB5C4D39439868F0EF30C2094A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NChaZFnGF0bOShpBQzzpZwsuzxkESTKoIk2OTRYacbszH+FCMmaRvIvawuEEyM0M7u1wt0w1ZuvOwQ336hYJRULy23dcNN2qdJmFOmGV3F8FlZZ/zas2632FBUTK36rWv5iCGB72Q5qegT8EamjcUIahIFTiZLS7NzUQj1G0o1KGcR3sVLi4Lkih1ulWpSmog2IbmQ3XR2kHYWiZzygVvjRJqA+4zrMEkzcpS+sPShQ6UZIcMyD0M5LOEL6JHWHVd4uKpZisDRl9VfhEWLW9dz/zRLzsb739ISuU8OZWVps82Pm88bdsmwLKIMWCZynTXH6NxO9ZcfNSsgoOkv65Qz5TV9MGzLspI7z+1tUjQoNaQUKBeK9OEEuToqoCL82z129/JuaORv5PUwH8kq+oKMUli4IruWfB8lBpXMzPFqwLoCrf+h58cYMzxp+uHE262bFDBZbBuPDK6b62R8HlNu2/uvGZ0/3RB5v3VTVkAa6O+fnBtHwtWcYhjj40dIujZOhR5VfVTe/Hsi+Pa44XfxmkydoMDWKZMMJmE931zwuqSSVeTxTj/1k4rQB1EyqGfQGQEFLZTGoZABUljy6UAbCfoGmnOpfoMi7O5rBQky57sDqJiqj/+W0Nh2issklZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13059.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae8c62-61fb-4deb-5a65-08dde533297f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 06:30:05.8494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi6jDOENCIhW+2kfjvoO7aR7+6+JKnZEmwT4G3oFBspL49OAMAhZkpCi6aYNfzBpxQjWMSYUw28ZumfXczxp1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9728

QWxsLA0KDQoNCkkgaGF2ZSBjb25maXJtZWQgdGhhdCBpbiB0aGUgIUNYTF9SRUdJT04gY29uZmln
dXJhdGlvbiwgdGhlIHNhbWUgZW52aXJvbm1lbnQgbWF5IGZhaWwgdG8gZmFsbCBiYWNrIHRvIGht
ZW0uKFlvdXIgbmV3IHBhdGNoIGNhbm5vdCByZXNvbHZlIHRoaXMgaXNzdWUpDQoNCkluIG15IGVu
dmlyb25tZW50Og0KLSBUaGVyZSBhcmUgdHdvIENYTCBtZW1vcnkgZGV2aWNlcyBjb3JyZXNwb25k
aW5nIHRvOg0KICAgYGBgDQogICA1ZDAwMDAwMDAtNmNmZmZmZmYgOiBDWEwgV2luZG93IDANCiAg
IDZkMDAwMDAwMC03Y2ZmZmZmZiA6IENYTCBXaW5kb3cgMQ0KICAgYGBgDQotIEU4MjAgdGFibGUg
Y29udGFpbnMgYSAnc29mdCByZXNlcnZlZCcgZW50cnk6DQogICBgYGANCiAgIFsgICAgMC4wMDAw
MDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDA1ZDAwMDAwMDAtMHgwMDAwMDAwN2NmZmZmZmZm
XSBzb2Z0IHJlc2VydmVkDQogICBgYGANCg0KSG93ZXZlciwgc2luY2UgbXkgQUNQSSBTUkFUIGRv
ZXNuJ3QgZGVzY3JpYmUgdGhlIENYTCBtZW1vcnkgZGV2aWNlcyAodGhlIHBvaW50KSwgYGFjcGkv
aG1hdC5jYCB3b24ndCBhbGxvY2F0ZSBtZW1vcnkgdGFyZ2V0cyBmb3IgdGhlbS4gVGhpcyBwcmV2
ZW50cyB0aGUgY2FsbCBjaGFpbjoNCmBgYGMNCmhtYXRfcmVnaXN0ZXJfdGFyZ2V0X2RldmljZXMo
KSAvLyBmb3IgZWFjaCBTUkFULWRlc2NyaWJlZCB0YXJnZXQNCiAgIC0+IGhtZW1fcmVnaXN0ZXJf
cmVzb3VyY2UoKQ0KICAgICAtPiBpbnNlcnQgZW50cnkgaW50byAiSE1FTSBkZXZpY2VzIiByZXNv
dXJjZQ0KYGBgDQoNClRoZXJlZm9yZSwgZm9yIHN1Y2Nlc3NmdWwgZmFsbGJhY2sgdG8gaG1lbSBp
biB0aGlzIGVudmlyb25tZW50OiBgZGF4X2htZW0ua29gIGFuZCBga21lbS5rb2AgbXVzdCByZXF1
ZXN0IHJlc291cmNlcyBCRUZPUkUgYGN4bF9hY3BpLmtvYCBpbnNlcnRzICdDWEwgV2luZG93IFgn
DQoNCkhvd2V2ZXIgdGhlIGtlcm5lbCBjYW5ub3QgZ3VhcmFudGVlIHRoaXMgaW5pdGlhbGl6YXRp
b24gb3JkZXIuDQoNCldoZW4gY3hsX2FjcGkgcnVucyBiZWZvcmUgZGF4X2ttZW0va21lbToNCmBg
YA0KKGJ1aWx0LWluKSAgICAgICAgICAgICAgICAgQ1hMX1JFR0lPTj1uDQpkcml2ZXIvZGF4L2ht
ZW0vZGV2aWNlLmMgIGN4bF9hY3BpLmtvICAgICAgZGF4X2htZW0ua28gICAgICAgICAgICAgICBr
bWVtLmtvDQoNCigxKSBBZGQgZW50cnkgJzE1ZDAwMDAwMDAtN2NmZmZmZmZmJw0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDIpIFRyYXZlcnNlICJITUVNIGRldmlj
ZXMiDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSW5zZXJ0
IHRvIGlvbWVtOg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDVkMDAwMDAwMC03Y2ZmZmZmZiA6IFNvZnQgUmVzZXJ2ZWQNCg0KICAgICAgICAgICAgICAgICAg
ICAgICgzKSBJbnNlcnQgQ1hMIFdpbmRvdyAwLzENCiAgICAgICAgICAgICAgICAgICAgICAgICAg
L3Byb2MvaW9tZW0gc2hvd3M6DQogICAgICAgICAgICAgICAgICAgICAgICAgIDVkMDAwMDAwMC03
Y2ZmZmZmZiA6IFNvZnQgUmVzZXJ2ZWQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICA1ZDAw
MDAwMDAtNmNmZmZmZmYgOiBDWEwgV2luZG93IDANCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA2ZDAwMDAwMDAtN2NmZmZmZmYgOiBDWEwgV2luZG93IDENCg0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoNCkgQ3JlYXRlIGRheCBkZXZpY2UNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDUp
IHJlcXVlc3RfbWVtX3JlZ2lvbigpIGZhaWxzDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yIDVkMDAwMDAwMC03Y2Zm
ZmZmZg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFJlYXNvbjogQ2hpbGRyZW4gb2YgJ1NvZnQgUmVzZXJ2ZWQnDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKENYTCBXaW5kb3dzIDAvMSkgZG9uJ3QgY292ZXIgZnVsbCByYW5nZQ0KYGBgDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KSW4gbXkgYW5vdGhlciBlbnZpcm9ubWVudCB3aGVyZSBBQ1BJ
IFNSQVQgaGFzIHNlcGFyYXRlIGVudHJpZXMgcGVyIENYTCBkZXZpY2U6DQoxLiBgYWNwaS9obWF0
LmNgIGluc2VydHMgdHdvIGVudHJpZXMgaW50byAiSE1FTSBkZXZpY2VzIjoNCiAgICAtIDVkMDAw
MDAwMC02Y2ZmZmZmZg0KICAgIC0gNmQwMDAwMDAwLTdjZmZmZmZmDQoNCjIuIFJlZ2FyZGxlc3Mg
b2YgbW9kdWxlIG9yZGVyLCBkYXgva21lbSByZXF1ZXN0cyBwZXItZGV2aWNlIHJlc291cmNlcywg
cmVzdWx0aW5nIGluOg0KICAgIGBgYA0KICAgIDVkMDAwMDAwMC03Y2ZmZmZmZiA6IFNvZnQgUmVz
ZXJ2ZWQNCiAgICAgICAgNWQwMDAwMDAwLTZjZmZmZmZmIDogQ1hMIFdpbmRvdyAwDQogICAgICAg
ICAgICA1ZDAwMDAwMDAtNmNmZmZmZmYgOiBkYXgwLjANCiAgICAgICAgICAgICAgICA1ZDAwMDAw
MDAtNmNmZmZmZmYgOiBTeXN0ZW0gUkFNIChrbWVtKQ0KICAgICAgICA2ZDAwMDAwMDAtN2NmZmZm
ZmYgOiBDWEwgV2luZG93IDENCiAgICAgICAgICAgIDZkMDAwMDAwMC03Y2ZmZmZmZiA6IGRheDEu
MA0KICAgICAgICAgICAgICAgIDZkMDAwMDAwMC03Y2ZmZmZmZiA6IFN5c3RlbSBSQU0gKGttZW0p
DQogICAgYGBgDQoNClRoYW5rcywNClpoaWppYW4NCg0KDQpPbiAyNS8wOC8yMDI1IDE1OjUwLCBM
aSBaaGlqaWFuIHdyb3RlOg0KPiANCj4gDQo+IE9uwqAyMi8wOC8yMDI1wqAxMTo1NizCoEtvcmFs
YWhhbGxpwqBDaGFubmFiYXNhcHBhLMKgU21pdGHCoHdyb3RlOg0KPj4+DQo+Pj4+DQo+Pj4+PiDC
oMKgwqDCoMKgwqBgYGANCj4+Pj4+DQo+Pj4+PiAzLsKgV2hlbsKgQ1hMX1JFR0lPTsKgaXPCoGRp
c2FibGVkLMKgdGhlcmXCoGlzwqBhwqBmYWlsdXJlwqB0b8KgZmFsbGJhY2vCoHRvwqBkYXhfaG1l
bSzCoGluwqB3aGljaMKgY2FzZcKgb25secKgQ1hMwqBXaW5kb3fCoFjCoGlzwqB2aXNpYmxlLg0K
Pj4+Pg0KPj4+PiBIYXZlbid0wqB0ZXN0ZWTCoCFDWExfUkVHSU9OwqB5ZXQuDQo+Pg0KPj4gV2hl
biBDWExfUkVHSU9OIGlzIGRpc2FibGVkLCBERVZfREFYX0NYTCB3aWxsIGFsc28gYmUgZGlzYWJs
ZWQuIFNvIGRheF9obWVtIHNob3VsZCBoYW5kbGUgaXQuIA0KPiANCj4gWWVzLMKgZmFsbGluZ8Kg
YmFja8KgdG/CoGRheF9obWVtL2ttZW3CoGlzwqB0aGXCoHJlc3VsdMKgd2XCoGV4cGVjdC4NCj4g
ScKgaGF2ZW4ndMKgZmlndXJlZMKgb3V0wqB0aGXCoHJvb3TCoGNhdXNlwqBvZsKgdGhlwqBpc3N1
ZcKgeWV0LMKgYnV0wqBJwqBjYW7CoHRlbGzCoHlvdcKgdGhhdMKgaW7CoG15wqBRRU1VwqBlbnZp
cm9ubWVudCwNCj4gdGhlcmXCoGlzwqBjdXJyZW50bHnCoGHCoGNlcnRhaW7CoHByb2JhYmlsaXR5
wqB0aGF0wqBpdMKgY2Fubm90wqBmYWxswqBiYWNrwqB0b8KgZGF4X2htZW0va21lbS4NCj4gDQo+
IFVwb27CoGl0c8KgZmFpbHVyZSzCoEnCoG9ic2VydmVkwqB0aGXCoGZvbGxvd2luZ8Kgd2Fybmlu
Z3PCoGFuZMKgZXJyb3JzwqAod2l0aMKgbXnCoGxvY2FswqBmaXh1cMKga2VybmVsKS4NCj4gW8Kg
wqDCoDEyLjIwMzI1NF3CoGttZW3CoGRheDAuMDrCoG1hcHBpbmcwOsKgMHg1ZDAwMDAwMDAtMHg3
Y2ZmZmZmZmbCoGNvdWxkwqBub3TCoHJlc2VydmXCoHJlZ2lvbg0KPiBbwqDCoMKgMTIuMjAzNDM3
XcKga21lbcKgZGF4MC4wOsKgcHJvYmXCoHdpdGjCoGRyaXZlcsKga21lbcKgZmFpbGVkwqB3aXRo
wqBlcnJvcsKgLTE2DQo+IA0KPiANCj4gDQo+PiBJwqB3YXPCoGFibGXCoHRvwqBmYWxsYmFja8Kg
dG/CoGRheF9obWVtLsKgQnV0wqBsZXTCoG1lwqBrbm93wqBpZsKgSSdtwqBtaXNzaW5nwqBzb21l
dGhpbmcuDQo+Pg0KPj4gY29uZmlnwqBERVZfREFYX0NYTA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
dHJpc3RhdGXCoCJDWEzCoERBWDrCoGRpcmVjdMKgYWNjZXNzwqB0b8KgQ1hMwqBSQU3CoHJlZ2lv
bnMiDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqBkZXBlbmRzwqBvbsKgQ1hMX0JVU8KgJibCoENYTF9S
RUdJT07CoCYmwqBERVZfREFYDQo+PiAuLg0KPj4NCj4+Pj4NCj4+Pj4+IMKgwqDCoMKgwqDCoE9u
wqBmYWlsdXJlOg0KPj4+Pj4gwqDCoMKgwqDCoMKgYGBgDQo+Pj4+PiDCoMKgwqDCoMKgwqAxMDAw
MDAwMDAtMjdmZmZmZmbCoDrCoFN5c3RlbcKgUkFNDQo+Pj4+PiDCoMKgwqDCoMKgwqA1YzAwMDEx
MjgtNWMwMDAxMWI3wqA6wqBwb3J0MQ0KPj4+Pj4gwqDCoMKgwqDCoMKgNWMwMDExMTI4LTVjMDAx
MTFiN8KgOsKgcG9ydDINCj4+Pj4+IMKgwqDCoMKgwqDCoDVkMDAwMDAwMC02Y2ZmZmZmZsKgOsKg
Q1hMwqBXaW5kb3fCoDANCj4+Pj4+IMKgwqDCoMKgwqDCoDZkMDAwMDAwMC03Y2ZmZmZmZsKgOsKg
Q1hMwqBXaW5kb3fCoDENCj4+Pj4+IMKgwqDCoMKgwqDCoDcwMDAwMDAwMDAtNzAwMDAwZmZmZsKg
OsKgUENJwqBCdXPCoDAwMDA6MGMNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqA3MDAwMDAwMDAwLTcw
MDAwMGZmZmbCoDrCoDAwMDA6MGM6MDAuMA0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqA3MDAw
MDAxMDgwLTcwMDAwMDEwZDfCoDrCoG1lbTENCj4+Pj4+IMKgwqDCoMKgwqDCoGBgYA0KPj4+Pj4N
Cj4+Pj4+IMKgwqDCoMKgwqDCoE9uwqBzdWNjZXNzOg0KPj4+Pj4gwqDCoMKgwqDCoMKgYGBgDQo+
Pj4+PiDCoMKgwqDCoMKgwqA1ZDAwMDAwMDAtN2NmZmZmZmbCoDrCoGRheDAuMA0KPj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoDVkMDAwMDAwMC03Y2ZmZmZmZsKgOsKgU3lzdGVtwqBSQU3CoChrbWVtKQ0K
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqA1ZDAwMDAwMDAtNmNmZmZmZmbCoDrCoENYTMKgV2lu
ZG93wqAwDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoDZkMDAwMDAwMC03Y2ZmZmZmZsKgOsKg
Q1hMwqBXaW5kb3fCoDENCj4+Pj4+IMKgwqDCoMKgwqDCoGBgYA0K

