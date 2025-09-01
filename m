Return-Path: <linux-fsdevel+bounces-59740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C9B3D9C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 08:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672A43B66A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8D253F13;
	Mon,  1 Sep 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rhO3P3T0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E923E25B;
	Mon,  1 Sep 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707687; cv=fail; b=cRfj1pTdEm95b2GYAXMpd4MD9XadQ+sBvaf6uCDlg7xE3R/rY+9v02KOQZjElaoxFl8HFBlDfEGi7gDH1v7cRMUO7wMA8YGRDf1nccNKOaZu2uJEcBfp4HUu56VkiFe1xz5XzclORbGoDnT0uhqlrt/8dGtXQT2y+jwIDOzjqeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707687; c=relaxed/simple;
	bh=pS6qGoSqJxMUfbvHjAznb/+JksN7miDa4cDZ3adYUrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNMbx9q0J5oTVsXTpMK5DJGiJcZJwyOePZxmx8iPvwmDXQHRFvylfFmCMzg5yhycFMYrrUaq9xkTE6FQf5P0d0AAi1lfNbsOOKtfL/zgxS9VHV5rmELAlfcrQSIKZn5jk15Pf/HoRqVyyVBoe/3W8NgCz05+/FsnT1ulZTL7pPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rhO3P3T0; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756707685; x=1788243685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pS6qGoSqJxMUfbvHjAznb/+JksN7miDa4cDZ3adYUrg=;
  b=rhO3P3T0EMZBa26eHuPu181/BLBgxwM60l2Mc87OJ6TzA/kSAaYGJziD
   dVwKfflzE+rzx0uHUMmTUo0ZTLQvaV2eimWBDrVm732U0M9Kd22/kWBtJ
   CZ8WNlOWKLEIRRNNIKdOIEyYH+c53HvG150bAamw8FsWY5s3QZkrcc+DD
   cu4YUovjrjdeEAX8snkCnQa7WHvldRIqEp9+zM3isfd8qSyO8grViQq0o
   bsjkqDFNZr2VpP92Y7fspTPR5yH9ZkS02V2yMEa3voYfz/XAlx5a+WI06
   lLrp7YvpybLuUbdcAop/LSMZ9X9PHcjWpkdqsFe5ScR0Orbvib/EhrqH3
   w==;
X-CSE-ConnectionGUID: L74pNZrpShao4B1Jakz0lQ==
X-CSE-MsgGUID: htZFMJlpQvWdbE6wl3T4Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="166303755"
X-IronPort-AV: E=Sophos;i="6.18,225,1751209200"; 
   d="scan'208";a="166303755"
Received: from mail-japaneastazon11011033.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.33])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 15:21:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQw68/h1Ac+e8AfU8U+CyQBqvfvUjytetQvdT+H4YjAp0C+++RomMk2rWgu9/6v2ibm0UcPaU2WkzRM1fxq4ny1uUEF+2mHX97XzbTZ2mCKlENY/KYKSIinGgeCjr8a9/mthydmF6KHRTGBglbmSu6T1eWFpiiikctBWAtIgJI5xp9iNQTPRly6WfwCeE2J9aQWD1QlC7104NHShaZSzydN95t/CoOws6Bk13ileLpkKRXkUwcC7mf1iMCmnZ3UUlqIOWoZq8Vf3rTTWuTsGUwzQ1/xfjAcDtwSzNpaPhcMh6Vyqpy4d2KAPEP5I7uu4T2bH/nJpn02I1tV8MJVGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS6qGoSqJxMUfbvHjAznb/+JksN7miDa4cDZ3adYUrg=;
 b=ytt87QoVPP3RyWgNdz978BR60+lthljYviCta+bOklj6ELPHEYvgLp+xpv0cRlBnNLuvo96IiSutntJspiTGRWHrxrIktJB3ZqE+CTmhJzlY94pxxwp8lOScAYkZOIz/TlS12ZexelLahYhFjS54A1tobVrFoT/Nb46ae68uFd5UeKiAID+jlUMBCgo/7kg35PhNwyWw2Ba7g05jsJOsnJfzFdwMPtm3pqhux8X8AVv8t5ikZPNruPicWI6sB+qY7Bh6wrZZTgI/mt7vmDzFa4OmsQ3XYiL8lR8tKpTSIY7YQx5cwAjjscmFkN2lyhwFWV14t5Xdlqk7UbQENOA6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by TYCPR01MB10182.jpnprd01.prod.outlook.com (2603:1096:400:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 06:21:10 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 06:21:09 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [RFC PATCH 6/6] cxl/region, dax/hmem: Guard CXL DAX region
 creation and tighten HMEM deps
Thread-Topic: [RFC PATCH 6/6] cxl/region, dax/hmem: Guard CXL DAX region
 creation and tighten HMEM deps
Thread-Index: AQHcExbLdNWIb6U5w0692hMXPq5I3bR96wcA
Date: Mon, 1 Sep 2025 06:21:09 +0000
Message-ID: <2397ebb5-ae63-402e-bc23-339c74be9210@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-7-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250822034202.26896-7-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|TYCPR01MB10182:EE_
x-ms-office365-filtering-correlation-id: a38d7a45-cf34-4a8b-0ec4-08dde91fbdfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkJYUTdoZWhYUys0UFBTeHF5b3p4aUQvUWQ3S3VMRmtjMHRDN0ppSTBKcVRG?=
 =?utf-8?B?bWNJV3NCdkw3bWk3aGczQ3VWZHVvSG1uZkRvY3hPNzFjR1gvZThlWFZnQlZS?=
 =?utf-8?B?b3EyclVUZXc1bC9XK0JOK1I0T3BTVEtyMmQ3R09IY1l3Z295N2JtWlR0R2Ry?=
 =?utf-8?B?aUQwQlZaMGpCaFd2QVBicU9ueUtON2tzNHphWENqWFpidlM1S2Y0VXZyRmVE?=
 =?utf-8?B?TVhIS1ZVTWtuZkZQeVFYS0xxYmEyK2Qzd3U5MkNScUlyMmZaa1hsb1dmSzJt?=
 =?utf-8?B?OGM1b0Z0aDY0d0hSRDhaUlZXdFlVT1ZnTjN1a0xzTWYydUZoN2lGWnNkZmJ5?=
 =?utf-8?B?R3ZiMit0alVObjJrbXlwVWxCTkdyUTNOTmhvY2Y0NTgybTZBVWFUV2JNTFho?=
 =?utf-8?B?ZWZ3VVR1M3VheUJJWkx4bWdoMCt6bnNtc201YnRUY1NwbHhFeXZ0UmJiaGd0?=
 =?utf-8?B?VFhnaDdxOTVmK1c0NUJzZnVXQ2t2S1dobkEvbWhZRHlEVVRQZUJvM2FvaTlt?=
 =?utf-8?B?ZVI3VWhKQVVWUkMrWTNCV2R6Qm5ITGVTSTZvRitpbGNkM1hoUFZvSE8xL2pa?=
 =?utf-8?B?K1VxMGJSb1VCUlVQaXpMMWk2em5nR2NCT2ZnMTlhWlUveUJCS3c4eEllWXFR?=
 =?utf-8?B?WGd1Z2JJZUljMGM3RUlUU0dlY0QwMCthWVhZeHZkZkxSTFhOOTU2c0JtZEZ4?=
 =?utf-8?B?QUcwYjBwTGs4RUd5SnMwT1g1NFc1eEZIcjhJM05ZWFFVS2h5dVdPSDVLeTRn?=
 =?utf-8?B?bHpXUENaV1ZnMWNuUGNHZXh4TUFhYU1HTW5INnlVZnpCRzRoRUp4NWJRWUVa?=
 =?utf-8?B?b09sTzlST1ZkYWdaeFpyL1VVN0prWm1LM1hmQTQxMnJ4RVNyWEZPOGNYRnJi?=
 =?utf-8?B?YnFTVU85SVBCVDM3dTUrcjY3WmtqcDUyZDQxd2JUSlR6V3hZb2FtVTlPdEZO?=
 =?utf-8?B?ZlFZOThJRHZwKzZZMHdBUmRWUnhlNFowTXdReFJyNFdGekhvMHJuSE4ya09P?=
 =?utf-8?B?S3plTmpFdWFHMUxXNTc5dG9tbk1WbEthanhGcmdUQzNnWnN0QWc2SVRGVktF?=
 =?utf-8?B?MjdmbldpdGN4SmRYOHIySjVhNEVNR2dxRnowbGZDcnNHSHY5cjMvQWYzdkdw?=
 =?utf-8?B?SmVqRlpvUHZRWWtXdzljMEN2M0ZDRzFTRmo0MmViMkg4bm9KUjRzT0dsaU9o?=
 =?utf-8?B?bzg2RE1PTHVxbndwZXB1UDdzaEVPNWdHZVJBOWsrRnU2N3lEOHdQSTdiVGUv?=
 =?utf-8?B?Nmt4MzJUckRseXRYQXhqbHMvOFd3Ny9uY3EycUU3RkkrODdKMlRZS2VyaFJL?=
 =?utf-8?B?V1kzK0U4OFBPUVVkNTZYaHUyQjBOQWdyM0prZXB1VWV2RUduVjQ4d2xFYTl0?=
 =?utf-8?B?TXZuTThQYmROMDVBUmJ2cXBOWEU1NGRpT29pSXRSYnVDZDBPZDljaFI4eUE3?=
 =?utf-8?B?bWtKc0VkdW0wK3FpeFRWeEZIdThzYnN6c1U2YWVYampKYnA3bEt3dmkxc0VY?=
 =?utf-8?B?SWl6OFlLdnh6SDVTTlhBbjlwYTV4dklObWZXbXJ3RFVSaWpjVVlMRFJRVjM5?=
 =?utf-8?B?TlR2WklUWmVKY29IWUpPaU03V1JjZEJISHhOUmRpVU9yQUhkRFlQUnZScUNU?=
 =?utf-8?B?anVXUXMrT2Y4b2lXSTZHN1ZMZ2dzWUFtbWxOaE5rYjI1c0NKbXRRZjg0SWpj?=
 =?utf-8?B?WDJIclY0M0pvc2RKYitxMnI4S3hBQ2hYNVA1dXlkVlBqaUh3VUx5UXFtNHN3?=
 =?utf-8?B?ZmpSaVhmaXg4Tm1Xb3ZIR0xpTmRuck1RV0dJUWgyam12TU5wSzgyWGE3RDBh?=
 =?utf-8?B?OUMxRklyZDNNMUp2MWpnTCtNRnJNYWlKd1JaQ3BlT1lzNFF4MjdSRlBsV2dr?=
 =?utf-8?B?NFVLV1ljdzNHZlFKTkR2V2tLQmVFNnpWcTlMTnVqclpaTU5VMzcrdnlSOVNW?=
 =?utf-8?B?MlBLeUVsd0dVZEx0dVpmYk90V2JKUHlGcGovekphWkNXaWx1Qm5Dd1puRUVs?=
 =?utf-8?B?N2pLdVQrZFpkMllxNXJKbm5SaDJON2txa1p0c3hZRTV4NEFDUzR4T1RXdmN3?=
 =?utf-8?Q?XSdrst?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ymk4TDdrdk1JRFJQUmFEUDRRS2Jqb2ZqWWtkenFuWk50WGdTRnZJOW9iSlBN?=
 =?utf-8?B?czVoSVpvazRLbHFpQUkxN0RHQ2tZSEI2dDNEMUZaYkRXU2k2WGhVdkdRMXht?=
 =?utf-8?B?bmVERkxRakk2ZUFCL3AzQ0NGNXN4U050dWxHOVNzdmJxYll1aEdwSWVFaFNw?=
 =?utf-8?B?aWU2YkZMQkw0c2hVSnM3Y2crSi9KZC9UbzNzbUduTE9Qd2VpRDhvaXBnUkF4?=
 =?utf-8?B?UXZCUlRnZHpOTzJSZXpQQ0JqdnJZa05vRXJEeW5IZmlLMnl1alFNRklFUlhV?=
 =?utf-8?B?UzFBdmcxZUw3WnVac0hvVTl2NG1aRlpqRFdBL3ZOd2NqSXhjSmMzUUZvL0Mw?=
 =?utf-8?B?UXg3MnhTYVREV2dBREF4Z0dIVVk1SmlGVVM0Tzd6cHhCNjBBMCt1bnJTeHU1?=
 =?utf-8?B?R2oycGJhUjhScUpiODRVdnQwRm9FQStIWFhhS3lzNjJSNVFGVVVjdW5Yb1ZS?=
 =?utf-8?B?YlZsVk9TNW42VE81eEV5Ujk2RThDb3ZLdTVxUmJkeXVCVlp0RHZoMWpkK2Iy?=
 =?utf-8?B?Y3pmODVVUXVEZXZsd0p2aDJaMmpQbzJKSFZqWjF4czZ4Q0k5c3BrdDd0Q2hk?=
 =?utf-8?B?UE5EcEtNcGJPS1U1WFByYTZwUnV3TFNMbkdNeEZEN1lweElqTWJRcHM2WHpX?=
 =?utf-8?B?bEYzbUUwS3U0WnhlOTN3VDNKRUJGV2Y0R2dqbEE3dXVQU25Vd1VQWUhyT2tP?=
 =?utf-8?B?SnRBVW5YekpkOWZZRjJWa3hQd2xFOWxselJ2aXQxRjF6Nk5HOXVsZFBvWmpJ?=
 =?utf-8?B?a01sMFlMQjY0bW9wMTZxL1grMDRJcVg2OGNPc09CZTZzOWh5eU93SHQxRlBl?=
 =?utf-8?B?bTk5eXdOUlEwaFBaSDZPbk10dWFjd3BOMU0ydTBFNzVZL1FJT29LZkt3QW9J?=
 =?utf-8?B?bkN3R3hqSVpUcXdlK1d6Vmt3Z0owRHFQbXVhQUdmRU1UYS9xbktyV1lKK3Ry?=
 =?utf-8?B?VnJGL0dyeWNPNk5sYW5EajV0UHJsWnJqSmpiYURMc1k1YjR1Y2ErWXVxR3l4?=
 =?utf-8?B?R0pRcEJKblVWaFlEcGVxbklWTk9WR0ZWOEx0TG0yRVZiSkZmNFZkQlFGOVlo?=
 =?utf-8?B?ZzRIYjhBVUd5SEtsZzZzbGpRTzhuWmhYY2RERXE0b01OdG9uTG5HRVFVc1Nz?=
 =?utf-8?B?QXY3TWQ5aW1XbDNpQ01uZTRYWVYvSi9Za0lUanJpVmhsR2pDQWJub2FpejdX?=
 =?utf-8?B?VWhlVHd0aEhxZ3B4eHUrYlBzVDFsdnlnbHFkREkzQU5lNG9CbUt4d1dKRGhx?=
 =?utf-8?B?L0NodmtQSXJkdHYxSEF4cFZSWldoRmF6WjZNL0lzSEI3eW1KWmdXTVBEMmpN?=
 =?utf-8?B?RGNFZmFja21VMVloTytjaThjZkwxNWVTc29hSEpHQnYxSlJJdVMzU1N6T0ZZ?=
 =?utf-8?B?TE02SjAyTGdHNWxPUFRkVjZOc3lET2VwZUhOVHdiZGtTcnFaVGJqa1hERzQ3?=
 =?utf-8?B?TVZHWVE1Uk1CY3grWkNXMFhHN2FUMFN2M2E2VVkzU1QzVDZMNm1sT3hBU2wz?=
 =?utf-8?B?cXJKdGJ3SGJTc3ppMEtDVGZTQTdiYVJmUnl6T3FEUUVMaHMyODRuQkdaV2Fw?=
 =?utf-8?B?V3pnWDZWL3N3QTRLNXR6N0hzVk1XbkFtblFJUkxIcW95SWYvYmxqbm5YbWxk?=
 =?utf-8?B?QVorU1d3MEc5WEVYR2h3U25CZ3pFQWJMWUkwQzM1MExWZ0x2bE9BTlRSemFG?=
 =?utf-8?B?TlhGMFlCZkU2NFEza20va0pKYnJjUks4dXpYU2F5V2wzekRwb2FENHZmY2xz?=
 =?utf-8?B?bVl4cnY4MDMwS2FWNW9iSmpvV0p6UmRzWWxWanlRVm9KeXRFVkZzMExMUFAv?=
 =?utf-8?B?TmhYYTFBUnRPa2FUaTRQbUtzS1dNc1lFeFdYY3p2Q3ZBQkNIVU90TDVZTjEw?=
 =?utf-8?B?c1RoVjhjOHpnSlMxdlhYZExlWFAzbnphZGpKQ0VVQkp6eGtYdnV0aXlPcW8r?=
 =?utf-8?B?RXdlYkhXckdxY1c0bXppaGdNL1ZnVGhlWDI1OXM0YnFLdTVIeGNyemxKZVlP?=
 =?utf-8?B?SHRYOHJCQkVWdnFQOUswUjc3amtsN1A0MFl3SERTVTc3eHgzeWxwR3ZxMmZW?=
 =?utf-8?B?aGdZWDZiRnJmMkNuWGpVN084d3d6MTNLd3dwZE9BSFkrbkcxbk5zbGFCeU0v?=
 =?utf-8?B?QVpsbDFoYXgxY0NQdk9DS0pLVi9Oem05ZlJYUDRYZXczaXhaZDc1RVpCWlp2?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FFC9854201D1E42999B2BEA4BB0840B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NvqqrWzzU2rz5wWz/bheGcUJgdgTgDDcDg5wjDPD1CtdTsCiFowngK7QvkqCY6zECrQ1cwhF0OCogf8Z3BIF3jnISwVIjVqrKsnCaua3D0MhcLLJpH1V4hpkDaDwVtd/2J5qqWNs45E2C8BWrVP3N2Uw9KSa0Rw/EiB4xD0SRe3xeu1p6FSrkAmkyH9BtbnXb4IPrywfQqtrC4BM6uOsGixRiBBelhLh6od1btjEym/mVH2hsaIVcKyY11/fjHKtAUR92BzS6+1gc3e6FCOB5eO8pRFlWN3YtV5JmLW+n8wf0yR2Dbgoi/doLMVpUvg0a+LLD5Ghw8U0vFooqjQXPWJKTHnJ3/rHE5OUhXxPY/NYRN/711zuaqRKfXcc0Jgr0YmANAkgaavgiX1Axf3thH4brdLLbOpx882sA2E9TKFCxty3ywPvZYyJeTIMNxqZg3xl6zP9nKm8gHoIn/D1KTrlqned8tIaz0AkJox8G+ULj8Z89HVETHyNFUYBqHIUpTIr42Zr1Q3DYHsyEvBmXDlgkUb08X1Af+V4rQ7kw1qGgJMMv2GomeXpcvFvYXFLMwto9clZs0rmfSxmC7T5sytnjqgj476QBPbGJj6g6hMg3g6e+tcstKGbdaMrf7Sg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38d7a45-cf34-4a8b-0ec4-08dde91fbdfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 06:21:09.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93S7lHYXkJdE2RrVNsCOtZkBiG0Ne2ZKSnPTuP/O/fL58M4Dto5wpv3AtSTWaLV0F/52JKvR3O5oI6Y0hCk0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10182

DQoNCk9uIDIyLzA4LzIwMjUgMTE6NDIsIFNtaXRhIEtvcmFsYWhhbGxpIHdyb3RlOg0KPiBQcmV2
ZW50IGN4bF9yZWdpb25fcHJvYmUoKSBmcm9tIHVuY29uZGl0aW9uYWxseSBjYWxsaW5nIGludG8N
Cj4gZGV2bV9jeGxfYWRkX2RheF9yZWdpb24oKSB3aGVuIHRoZSBERVZfREFYX0NYTCBkcml2ZXIg
aXMgbm90IGVuYWJsZWQuDQo+IFdyYXAgdGhlIGNhbGwgd2l0aCBJU19FTkFCTEVEKENPTkZJR19E
RVZfREFYX0NYTCkgc28gcmVnaW9uIHByb2JlIHNraXBzDQo+IERBWCBzZXR1cCBjbGVhbmx5IGlm
IG5vIGNvbnN1bWVyIGlzIHByZXNlbnQuDQoNCkEgcXVlc3Rpb24gY2FtZSB0byBtaW5kOg0KICAN
CldoeSBpcyB0aGUgY2FzZSBvZiBgQ1hMX1JFR0lPTiAmJiAhREVWX0RBWF9DWExgIG5lY2Vzc2Fy
eT8gSXQgYXBwZWFycyB0byBmYWxsIGJhY2sgdG8gdGhlIGhtZW0gZHJpdmVyIGluIHRoYXQgc2Nl
bmFyaW8uDQpJZiBzbywgY291bGQgd2UgaW5zdGVhZCBzaW1wbGlmeSBpdCBhcyBmb2xsb3dzPw0K
ICANCi0tLSBhL2RyaXZlcnMvY3hsL0tjb25maWcNCisrKyBiL2RyaXZlcnMvY3hsL0tjb25maWcN
CkBAIC0yMDAsNiArMjAwLDcgQEAgY29uZmlnIENYTF9SRUdJT04NCiAgICAgICAgIGRlcGVuZHMg
b24gU1BBUlNFTUVNDQogICAgICAgICBzZWxlY3QgTUVNUkVHSU9ODQogICAgICAgICBzZWxlY3Qg
R0VUX0ZSRUVfUkVHSU9ODQorICAgICAgIHNlbGVjdCBERVZfREFYX0NYTA0KDQo+IA0KPiBJbiBw
YXJhbGxlbCwgdXBkYXRlIERFVl9EQVhfSE1FTeKAmXMgS2NvbmZpZyB0byBkZXBlbmQgb24NCj4g
IUNYTF9CVVMgfHwgKENYTF9BQ1BJICYmIENYTF9QQ0kpIHx8IG0uIFRoaXMgZW5zdXJlczoNCj4g
DQo+IEJ1aWx0LWluICh5KSBITUVNIGlzIGFsbG93ZWQgd2hlbiBDWEwgaXMgZGlzYWJsZWQsIG9y
IHdoZW4gdGhlIGZ1bGwNCj4gQ1hMIGRpc2NvdmVyeSBzdGFjayBpcyBidWlsdC1pbi4gTW9kdWxl
IChtKSBITUVNIHJlbWFpbnMgYWx3YXlzIHBvc3NpYmxlLg0KDQpIbW0sSUlVQywgYGRheF9obWVt
YCBpc24ndCBleGNsdXNpdmVseSBkZXNpZ25lZCBmb3IgQ1hMLiBJdCBjb3VsZCBzdXBwb3J0IG90
aGVyIHNwZWNpYWwgbWVtb3J5IHR5cGVzIChlLmcuLCBIQk0pLg0KDQpUaGFua3MNClpoaWppYW4N
Cg0KDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNtaXRhIEtvcmFsYWhhbGxpIDxTbWl0YS5Lb3Jh
bGFoYWxsaUNoYW5uYWJhc2FwcGFAYW1kLmNvbT4NCj4gLS0tDQo+IEkgZGlkIG5vdCB3YW50IHRv
IG92ZXJyaWRlIERhbuKAmXMgb3JpZ2luYWwgYXBwcm9hY2gsIHNvIEkgYW0gcG9zdGluZyB0aGlz
DQo+IGFzIGFuIFJGQy4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcmVzc2VzIGEgY29ybmVyIGNhc2Ug
d2hlbiBhcHBsaWVkIG9uIHRvcCBvZiBQYXRjaGVzIDHigJM1Lg0KPiANCj4gV2hlbiBERVZfREFY
X0hNRU09eSBhbmQgQ1hMPW0sIHRoZSBERVZfREFYX0NYTCBvcHRpb24gZW5kcyB1cCBkaXNhYmxl
ZC4NCj4gSW4gdGhhdCBjb25maWd1cmF0aW9uLCB3aXRoIFBhdGNoZXMgMeKAkzUgYXBwbGllZCwg
b3duZXJzaGlwIG9mIHRoZSBTb2Z0DQo+IFJlc2VydmVkIHJhbmdlcyBmYWxscyBiYWNrIHRvIGRh
eF9obWVtLiBBcyBhIHJlc3VsdCwgL3Byb2MvaW9tZW0gbG9va3MNCj4gbGlrZSB0aGlzOg0KPiAN
Cj4gODUwMDAwMDAwLTI4NGZmZmZmZmYgOiBDWEwgV2luZG93IDANCj4gICAgODUwMDAwMDAwLTI4
NGZmZmZmZmYgOiByZWdpb24zDQo+ICAgICAgODUwMDAwMDAwLTI4NGZmZmZmZmYgOiBTb2Z0IFJl
c2VydmVkDQo+ICAgICAgICA4NTAwMDAwMDAtMjg0ZmZmZmZmZiA6IGRheDAuMA0KPiAgICAgICAg
ICA4NTAwMDAwMDAtMjg0ZmZmZmZmZiA6IFN5c3RlbSBSQU0gKGttZW0pDQo+IDI4NTAwMDAwMDAt
NDg0ZmZmZmZmZiA6IENYTCBXaW5kb3cgMQ0KPiAgICAyODUwMDAwMDAwLTQ4NGZmZmZmZmYgOiBy
ZWdpb240DQo+ICAgICAgMjg1MDAwMDAwMC00ODRmZmZmZmZmIDogU29mdCBSZXNlcnZlZA0KPiAg
ICAgICAgMjg1MDAwMDAwMC00ODRmZmZmZmZmIDogZGF4MS4wDQo+ICAgICAgICAgIDI4NTAwMDAw
MDAtNDg0ZmZmZmZmZiA6IFN5c3RlbSBSQU0gKGttZW0pDQo+IDQ4NTAwMDAwMDAtNjg0ZmZmZmZm
ZiA6IENYTCBXaW5kb3cgMg0KPiAgICA0ODUwMDAwMDAwLTY4NGZmZmZmZmYgOiByZWdpb241DQo+
ICAgICAgNDg1MDAwMDAwMC02ODRmZmZmZmZmIDogU29mdCBSZXNlcnZlZA0KPiAgICAgICAgNDg1
MDAwMDAwMC02ODRmZmZmZmZmIDogZGF4Mi4wDQo+ICAgICAgICAgIDQ4NTAwMDAwMDAtNjg0ZmZm
ZmZmZiA6IFN5c3RlbSBSQU0gKGttZW0pDQo+IA0KPiBJbiB0aGlzIGNhc2UgdGhlIGRheCBkZXZp
Y2VzIGFyZSBjcmVhdGVkIGJ5IGRheF9obWVtLCBub3QgYnkgZGF4X2N4bC4NCj4gQ29uc2VxdWVu
dGx5LCBhICJjeGwgZGlzYWJsZS1yZWdpb24gPHJlZ2lvbng+IiBvcGVyYXRpb24gZG9lcyBub3QN
Cj4gdW5yZWdpc3RlciB0aGVzZSBkZXZpY2VzLiBJbiBhZGRpdGlvbiwgdGhlIGRtZXNnIG91dHB1
dCBjYW4gYmUgbWlzbGVhZGluZw0KPiB0byB1c2Vycywgc2luY2UgaXQgbG9va3MgbGlrZSB0aGUg
Q1hMIHJlZ2lvbiBkcml2ZXIgY3JlYXRlZCB0aGUgZGV2ZGF4DQo+IGRldmljZXM6DQo+IA0KPiAg
ICBkZXZtX2N4bF9hZGRfcmVnaW9uOiBjeGxfYWNwaSBBQ1BJMDAxNzowMDogZGVjb2RlcjAuMjog
Y3JlYXRlZCByZWdpb241DQo+ICAgIC4uDQo+ICAgIC4uDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHJl
c3NlcyB0aG9zZSBzaXR1YXRpb25zLiBJIGFtIG5vdCBlbnRpcmVseSBzdXJlIGhvdyBjbGVhbg0K
PiB0aGUgYXBwcm9hY2ggb2YgdXNpbmcg4oCcfHwgbeKAnSBpcywgc28gSSBhbSBzZW5kaW5nIGl0
IGFzIFJGQyBmb3IgZmVlZGJhY2suDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9u
LmMgfCA0ICsrKy0NCj4gICBkcml2ZXJzL2RheC9LY29uZmlnICAgICAgIHwgMSArDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYw0KPiBpbmRleCA3MWNjNDJkMDUyNDguLjZhMmMyMWU1NWRiYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jDQo+IEBAIC0zNjE3LDcgKzM2MTcsOSBAQCBzdGF0aWMgaW50IGN4bF9yZWdpb25fcHJvYmUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIAkJCQkJcC0+cmVzLT5zdGFydCwgcC0+cmVzLT5lbmQs
IGN4bHIsDQo+ICAgCQkJCQlpc19zeXN0ZW1fcmFtKSA+IDApDQo+ICAgCQkJcmV0dXJuIDA7DQo+
IC0JCXJldHVybiBkZXZtX2N4bF9hZGRfZGF4X3JlZ2lvbihjeGxyKTsNCj4gKwkJaWYgKElTX0VO
QUJMRUQoQ09ORklHX0RFVl9EQVhfQ1hMKSkNCj4gKwkJCXJldHVybiBkZXZtX2N4bF9hZGRfZGF4
X3JlZ2lvbihjeGxyKTsNCj4gKwkJcmV0dXJuIDA7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlkZXZf
ZGJnKCZjeGxyLT5kZXYsICJ1bnN1cHBvcnRlZCByZWdpb24gbW9kZTogJWRcbiIsDQo+ICAgCQkJ
Y3hsci0+bW9kZSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9LY29uZmlnIGIvZHJpdmVy
cy9kYXgvS2NvbmZpZw0KPiBpbmRleCAzNjgzYmIzZjIzMTEuLmZkMTJjY2E5MWM3OCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9kYXgvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2RheC9LY29uZmln
DQo+IEBAIC0zMCw2ICszMCw3IEBAIGNvbmZpZyBERVZfREFYX1BNRU0NCj4gICBjb25maWcgREVW
X0RBWF9ITUVNDQo+ICAgCXRyaXN0YXRlICJITUVNIERBWDogZGlyZWN0IGFjY2VzcyB0byAnc3Bl
Y2lmaWMgcHVycG9zZScgbWVtb3J5Ig0KPiAgIAlkZXBlbmRzIG9uIEVGSV9TT0ZUX1JFU0VSVkUN
Cj4gKwlkZXBlbmRzIG9uICFDWExfQlVTIHx8IChDWExfQUNQSSAmJiBDWExfUENJKSB8fCBtDQo+
ICAgCXNlbGVjdCBOVU1BX0tFRVBfTUVNSU5GTyBpZiBOVU1BX01FTUJMS1MNCj4gICAJZGVmYXVs
dCBERVZfREFYDQo+ICAgCWhlbHANCg==

