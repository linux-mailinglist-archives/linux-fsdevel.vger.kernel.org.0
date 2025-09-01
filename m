Return-Path: <linux-fsdevel+bounces-59729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C9B3D6CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 04:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32A1173B97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 02:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8A202C5D;
	Mon,  1 Sep 2025 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sT230dqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856C1A0BE0;
	Mon,  1 Sep 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694878; cv=fail; b=RqKXvIas2aBschLCP+FRcypARezdutB1ELifE95bfitUFL0EaZkSasXvRF1wZ42Yhy0XpvYjTiIj9jgl5vM03nzIvrFFqlVhrY44CCm1mR0PmSZ1UpABTWQ9fMGhml4Y5ITJyyCOfwScixgQpiyRQgNXUNU9zW8KKmtvTJHYgvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694878; c=relaxed/simple;
	bh=fzecBoMxTWM89OZYLmoZHeScm4X96DoR/z05f3tiIEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCT3X+p99+3dyhV/V7oIDga4hnq5oTZf+oaVWCoRTBjhur9z4fX/xx+qnwgYGZsrZcWKenzaDQghepu8AjMGqKoPJ+nddk9IhseRlIsfY2EWFq6U+zkP34+YJaWKjdphVgdz6WtulIDEHnPK2d0UKp60YTOTI2+gllv/NUQx37U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sT230dqJ; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756694876; x=1788230876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fzecBoMxTWM89OZYLmoZHeScm4X96DoR/z05f3tiIEg=;
  b=sT230dqJEMWB3trYQr3PWl5LH7/5I69Z4BBj0wFEJfEKjg1j1LkaMdzG
   PcB3gtt/HGSP2wOgIxS8ZhyMIVLBKjF+pySoQG1oVuGBaqqR2Lrz+DscH
   bVEpBrd4ekMDQAgAeBgcaiv7ZX0jiZU4rPiDY9X+pC9fQFJx1sP4Z+qXf
   zVJh4abZCIeT0VKuZnZQP67PZO+0zBtnsbl0M8Mnx2V+me3+cRtvZ9CMh
   WhF2WJK+BF2G4aPG+ZADfDumHAPjwfUvvYzgK2jERzxhY5sNoea7Qvdii
   YkTYAoBqKolYril/2Do3YQkfS0RmGU3Ul2Ca8oehsDe+XyMbKNcZxx6Qg
   w==;
X-CSE-ConnectionGUID: DDGodrpGSNWqoxoEvuQTpw==
X-CSE-MsgGUID: YpnquuZwQVeC3eK0m1vjFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="77647323"
X-IronPort-AV: E=Sophos;i="6.18,225,1751209200"; 
   d="scan'208";a="77647323"
Received: from mail-japanwestazon11011055.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 11:46:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QesNNExgrGlKFjUgAbEoQmgNVZw0t61XTgghEwpR70oV6kyyDRsElD0He+XHSDDBMa6xxoFAZmnRX4Ek4I+xeGFiYGifCRqukxKJiVu1oGWIbs7VvyGKnqA3BOwKjjH9u6pngrr2VW9oxlWisS2pHk5QKZJOlSyugfl8ag3LwwP+TsM9AuLWuJMHgUvNDZXELLuJCRfkaRkcU6V02214BPOfWafqFifj0IP+LkdpXfwnb6uzwE1kapY4W7MNbvxx3M2PhS1epWAuv/00fONLCC40lIAUi8OORs+GUIauNgrWI+3O8GCd0RIJUGOQIKWZSVxjXDEKltvSH+RI/VUdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzecBoMxTWM89OZYLmoZHeScm4X96DoR/z05f3tiIEg=;
 b=pC0G5P/bDDk2a5dMVOzco3U+nHLmP0d79YaHP2XyafyiaabXbxzoEmE76IJLoQFIY+PGM6eJ919bDwGa/rkvXMPFd5bm+HkiEGxnDYEoCPeOfFOAYjzUC7aKpBvzORp1GsKi5HVNlo4cFP88mwO6zFi2slqtK58eWowGrmUikSQo/hvWExrc/2ziW/DDb49/jAwuEmiDhCnTEOH+ewLL8YLHscJtneXuIclN5/GR0g8dFKPFTCxAdcO/WnwilFVUvw60OgHbup4txs+1aD/kpc2Sw39NsqUhH2gxEQ2KBt2RQ/wpAwtsXVSAK6Jv5T+kwYnctIsEjBc36N4cVLI4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by TY4PR01MB14562.jpnprd01.prod.outlook.com (2603:1096:405:23b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 02:46:33 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 02:46:32 +0000
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
 AQHb9bLv4zMtn0217k6cvjwtOUPnhrQ/XBMAgACSGQCAE6DhgIAY1fuAgAA2vQCAAapGgIAE+FOAgAMOQYCAAq0PAIAE8CkA
Date: Mon, 1 Sep 2025 02:46:32 +0000
Message-ID: <2dd4d4fe-3680-456b-812b-8e3e99f2cb8b@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
 <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
 <aKZW5exydL4G37gk@aschofie-mobl2.lan>
 <8293a3bb-9a82-48d3-a011-bbab4e15a5b8@fujitsu.com>
 <42fc9fa9-3fbb-48f1-9579-7b95e1096a3b@amd.com>
 <67e6d058-7487-42ec-b5e4-932cb4c3893c@fujitsu.com>
 <46b8e026-78c5-46de-97b7-074c1e75fd08@fujitsu.com>
 <a2e900b0-1b89-4e88-a6d4-8c0e6de50f52@amd.com>
In-Reply-To: <a2e900b0-1b89-4e88-a6d4-8c0e6de50f52@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|TY4PR01MB14562:EE_
x-ms-office365-filtering-correlation-id: 8a31f61d-e38a-4572-ed0f-08dde901c2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3p6Y1RIUWpvOXBvNkdTSzV6Qks0Ui9VZTh1SEl4VlV6Smt6cjV3dWt4RjVa?=
 =?utf-8?B?dVRhOHpSZDEreThzSjhpZzB2Z0wyc3dTRlB3ak9haDROaDNxclBHZUNNbFcw?=
 =?utf-8?B?WS9hcENPelZ1ek1Jc3BQVnRPUnJNenlUUnFUa3lXNW4vOXZWU01tMDY1VHF2?=
 =?utf-8?B?YmdBVHlPa2NDMTBwU2NiRS9MY1ZQdHM4SGlCZVJDSjR6U0tZTnJGVmZpSkxa?=
 =?utf-8?B?M3dtbUdsK1p0ZGp6eDlHQmZ3R2pBOXdyY2ZoR1ladUd5eDJnMGo2SEdGYnVz?=
 =?utf-8?B?SGtURFRWT3VTcW92UjZDNDdVVDBoS0JObXE4Vmd0ajFXNXExY0xBYk5Rdy9m?=
 =?utf-8?B?c2NKSm03Tyt4Y2E5Qk1RRXJlT1hMYmRJbWFlL1dMYW1jMGlOVmxTR0F0WW84?=
 =?utf-8?B?V1BEVWpZTCtlZ0pkN2VWTnB2TC9JWGZ0SFowZS8xNXMveWpaK1ByN2gxeDFq?=
 =?utf-8?B?S2phYmExamZDM0psZ3ZoL3hCVDZTa3JCaGEwSkJab0Z6OGl4ZWI2bGNOdUlD?=
 =?utf-8?B?S2M1OWthWFF1ZG9jczMxRjNZTjdJc3dZNDVIRXIvQ29tNFlmcWlYSTludjBq?=
 =?utf-8?B?bjlJREVrUS90cTNxemF4OEVCZ05nanFpajZNbEZCZWdwRXMrUlJ3b0syZ05W?=
 =?utf-8?B?enN4dnk4YjVkNEd1Z1VIVUpqcDQ2SzlHS0NJLzFlRWg3QW5aSlh1dExaTWR0?=
 =?utf-8?B?QTZvZ3dpSVRmZWdFWVNEUE1wcXp1aWFIdDhPeFQwVlJzZFRTeDk3Qm9PQ0wr?=
 =?utf-8?B?RFNMU05vZUdEUXVTbXBXQ21aUFJXTVRNODBUQkJ0bmFSN0VWMVdma3Bsb3Z5?=
 =?utf-8?B?SkloWHdhRUE5NmlCdytxS3BhTzZ2VDlxNmZGZm42cDhjdEx0aFhJMlpVQjhp?=
 =?utf-8?B?Rmd0R2pPNW94N0U1SUhMcVRRNXRvR3o4bWkzK2toKzdTcVM5ZVVPemRhdXoy?=
 =?utf-8?B?WUNvK0RxU2hETHh2NFhlNkRnSDNzbllhQlVUTmVFS3VnNTVOaVBzVENibDFW?=
 =?utf-8?B?NzJiS3IrRTNaTjNRK1E5WU40N3YzeXhGV3c2OWtRY09NNHg4TS9QWS8zejMy?=
 =?utf-8?B?R01sQk1QKzA2QmwzZDB3RnF6UGpQd2tIWGxYaWtwOGlnd2x4ZENENG80bzhT?=
 =?utf-8?B?RjZCNmFtVmhGR0JZUVJNSnNPRDNPSloySk1kbHVKMk50OVVrZHJuc1g0SUlK?=
 =?utf-8?B?WjQ0aC8wY1pGR0pWbFRpdDR1bDBPVHdkZ3N0NFlTMmZwM0NhL0kvTUREYkRF?=
 =?utf-8?B?K2d6czlCS2lKdnJVMHJDMHBoMUlva3NBNGNPd1ZVQ2FCWEl2bTFhRUpJSE11?=
 =?utf-8?B?dUdmNnNqbUppeVVETnhEVUV1ZGhlSUwvZldPcE8xaXpHcGVUZlBVZFNlNjNT?=
 =?utf-8?B?YlVEc2JuMzIybEZscTQvaW1JRmdZNGhWakZ2Vitzc055T1NjSWkwd1dNeWxo?=
 =?utf-8?B?aEpLNFhJaUx6L1B1QTF1UGg3L09Uc3ZvNm9HNzNRZVdXZXRlc3V2VmxicTNP?=
 =?utf-8?B?OHVFMG1CRlJQQUdPQXI4Y2EyN2RibHRGVzRIZE9oQXZtY2FPbEdiK0FkN1du?=
 =?utf-8?B?ck5GN295bDQyTS8wYStIbUdsVFcrekV1d3k4SkI0UDdhZWtQSzBvRkNrWlBF?=
 =?utf-8?B?T1prMVJJUVBrcXlKRWhBUE1lMDVsVEJvblRrNklIVSt1cmFsZmhnT2lVa1Jy?=
 =?utf-8?B?RG5objdmanp0TG8vamY4QThsUit2NmZmSFN5WXhNSFJsb0c4bWkyMVNScHRr?=
 =?utf-8?B?cDhNZ3NEMkdzeUh6eC9hczZKSURWbkVNNmRUQURRUnYraVZGVm82OCtZb3NC?=
 =?utf-8?B?Z014OC9ZeWFySG0rNDBTMkxSK2JSM1orTk9yOWhyckVDRTZHN2xiQ1dUcFVW?=
 =?utf-8?B?UGVueFZHOUFhWkwzT3ZMSHBXNndycU5BK2F4Z2FWckFzdEcyV2hpQlo3YmZ6?=
 =?utf-8?B?eW5DdDVqb1Y4NS9pYlJKSTlwcmV2bncyT0t2QWh5K2tmaXMvcXRiNTNIMWhl?=
 =?utf-8?B?VjV0Wlp4b3V5QVlEQ0dGNENyMGZWK2dldWZBWjlXb1YyQUl0QnZkV2lOMnJt?=
 =?utf-8?Q?JcuANg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmRJY3Q2eVZkdWZvS1FhVHNxOE5WQ0dGUHJTalVhS29hYVFqaDJWYVpJNU0y?=
 =?utf-8?B?NGNIUlI3czFxMFBsUGdReDY2TVk2aVdoZjY2WW9QMW9XWXVXYTg0YndUNDdR?=
 =?utf-8?B?Z1R0ekFmYjNoVmM4RHc2SkNtZWpJVHZTcHh4aDh0TWVqNW4yd0I1OExEUjdS?=
 =?utf-8?B?K0JvdE5PQmlpZ2tCblg5cUUvb01WaUR1amxTL0ttV2FqTGZJVFAycEIzUHBK?=
 =?utf-8?B?dWNWZjhOT0M2OWRYQ2R2akRnT0gyVW5iWjd2a1haQmlxMXlEcWtxUVFsVVhq?=
 =?utf-8?B?ZDhZRmJFd3N4c3lPa0lhM0tXTzdBc0hhSmxvM0NsS01jQ0REYlFXVUFRSDBv?=
 =?utf-8?B?QS9XRjN1dzhTenNXWXZCZldHUGRzQ1NDa2lqbElWeGI5R245QmU4U1J6SmFB?=
 =?utf-8?B?U2lGdHpkMHRyK29RMEtVcGMxOUtwMU95NnlhcS9DZTAyKzByVTFnZTBBb01E?=
 =?utf-8?B?K29QMjBTUy9TQkZ2ZzUxZE1td241Q2dNcUt1Q1h2eXljbVdneFc5YXVhMUR2?=
 =?utf-8?B?dGRBVEtXYWpVRXExOHRPcEdzeXdvbUEvUGlCbjJXd0NJRm9rL25FanB2Z1pZ?=
 =?utf-8?B?dGJsbDZsbCtZVmw1d1JIQkMwbEVYL0E1K01FN2diL0NiSjRQWm55NWpMSHla?=
 =?utf-8?B?SFVPaVdVcFlobytUdUVrVWdwYzBhWkpuOUpMVlBTcXFTK3lZbmRYUGlwd2ZX?=
 =?utf-8?B?RzZpekxKZWZqcW15cXlvWVl6dnFZQk1HNXp0L1MwbXpUaXFmZVBMZ0xmVU5s?=
 =?utf-8?B?ajJUUjI5Y0NOeFVwNGk5QnFXV0VXOFpCWVFMeHVYOHp4N05LWVptVlRXMHhp?=
 =?utf-8?B?Kzk3dzJyTkdLZlBta3J0YlN1RDVhS2tkZVZuZmxzQjFSa0VySWtvN25ZL1BF?=
 =?utf-8?B?dUlOekVtMVlsdkhGRDRlOHZHcTFEcE1rOGwzU25DTDBsYW5rQlZzbFQyS0Z0?=
 =?utf-8?B?MDJxcU1MOXhFdVg5cm9pN05XVHptaDZHKzBFbkdiMzg2ODRvR0VHZ013UGo3?=
 =?utf-8?B?M3VNU0hiYVk3MWJSQ3VjK1BuQmM5Y1ZCWU9ZT2xQRFNVcUt4bkpuUVZFb1BD?=
 =?utf-8?B?bjNiNXNJYkRCaTl2Q0FLNjg5RjV5bGliSzM0RGJRZ3FWYVNFUHkyRXUzbGVi?=
 =?utf-8?B?enk1SUd6RXVNWmsxMG04dGdJYkNhWncyMkVrUSttb05TdWRNeW5JSURHN1Zk?=
 =?utf-8?B?RDFPRUZEZnY1bDAyMTRjWVZPZDNodjhtMzIrTXM0UmJ4QjdJWHk5RStXek1U?=
 =?utf-8?B?ampVYUJsZG84NDZvb0oyNmVGSTArbWFnbWl5eEk4Rk9VeHo1b2Vta0MrKy82?=
 =?utf-8?B?UWgvUXVQejZGenNYYm15SjZIUDhWcVBOTGUrSGNrdlltUDcvc283UktwMitN?=
 =?utf-8?B?TUJXVmsvQlBZWkFHWGtMbU1SZ1N3WDBhYnlPckJ3QkZ1TW9vK2lWV094c3Ar?=
 =?utf-8?B?RU9CZmpWTElpdUJCQ2gydndvbkpKKzM2T3dJTlRndTN4Q2NROWM0dWlmQkdV?=
 =?utf-8?B?Rm9hKy9vRkZwT2kxajA2QWNobWRxS0gwNU9CSkh2UnVwRGFaMVFhdFdpZEt3?=
 =?utf-8?B?cU9RSGFPektKTlROWjlxOUNBbStPOXVCTHVJcHNCcGY5WmJwY3dPUGpWWmUw?=
 =?utf-8?B?OVlaTEpMWlhzSVNraXR1Sk5vclFTbGlHUWlFWGh4MmpYQk1NZWhBUkZ0UkxB?=
 =?utf-8?B?T2JwdEFUby9rR2lMNUt4NkxzckJlNkdxWmhuZTRLREgySkxtUktzUi9pbjZw?=
 =?utf-8?B?d0doTkorQlNKUHFVVUNObGZsNzhlNU9rVFA0VEVTQ1F0WkpTd05BR01YcU9C?=
 =?utf-8?B?anR5U09jWjI3MkV4OTZLOVdzdFRmQmZSOU5sVm1zWVF6TDJSd2VodXlTK2sy?=
 =?utf-8?B?M0YzRnZKdERtcnhxUTBNM0krNnZ3ejhPL1FyNU1mQm9ycWR1QjhTbkRpS1ph?=
 =?utf-8?B?blB3Yktya3lZTTRLcjNXOFo0WWRIUldwOXRKbVIyOFQ3ZXFIaDhyZ3F4TTdF?=
 =?utf-8?B?SFRneHlNT1JkWGZrbStHVTRiNFZLeThBdit1Y3NjQlFmM0d1Y25FY1c5TTBq?=
 =?utf-8?B?S3ZIMmFVdGdRNWpERjBPUVdNM1FGYjVyRnlDSEpJUEZJK2d4UytFbzFxVExT?=
 =?utf-8?B?dDJMakdCVlJmT0hLNlhkZFVEVkhBOE16OUN3SVRCRHAzVXJnd0UyUFVBMWEw?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <623C5F7486C68B4AA8E7FE1F214AD872@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AspOakd2D4onTQ6jBf5F3f9rjsKNN6W43ygX96Mi2sJdgjLCVQvIdR6uD2YZjE+sEiR9+9/k6gLJY9Gq8tNkNS+9MjyG/FLhqQXS/XrwaZSApnmxR02fZ6hefyOV7F3pBSZ+f2L78VpUgcb1aqc/zA+qy+okaBfpTzurQPXYpqgC6mICTLtOBS9ndlYeG4SHLa2bvlma1pDnnnQ5uRkKekhVTmJXrY22h1fkRamt6eIlfwdR7OvJeQpEo7U9i9wwKZBnmuKkyFmsyQsb+/P1B5jVzUPWuoT0ZnOee31LCS9uaY/DhImUk6tSARcr94fV/05IO2NnNh1FU/t88u18UOnfVU5sJWUWc70PrB/0Efsc2RCL3nyEND52QK59tk4tbywks+0+IhsliIWbMK+eQWtEMuicUl8KUheqQ1szlsQEzOMtZqnB88dIy5LjHVLFEplS7wj+CAjmYl9UEOb8/ZDPwkBWNfrdxqKa4zXpXL5gZmwTWD0lImpR2PEFIhbwirDgCBVJmDMN+NgaIYPdow1Y/L1bZsPA9QiorvR4aDMVwN1urwWUaTXXPOPoVGZCJSB2Rj4t8c5NrhKPSXzyPMAuyXW80hBU82pjnNefjm8GdbPxduRyUJOc/+p65LYD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a31f61d-e38a-4572-ed0f-08dde901c2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 02:46:32.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kScV49evQd1/0phFEzzqUUnXxcz5n9BamP287b+iCJgJG/pU7GP0R/XYcDClt2vHw1dtLWm9aHcr/k1VND8avQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14562

DQoNCk9uIDI5LzA4LzIwMjUgMDc6MjEsIEtvcmFsYWhhbGxpIENoYW5uYWJhc2FwcGEsIFNtaXRh
IHdyb3RlOg0KPiBIacKgWmhpamlhbiwNCj4gDQo+IE9uwqA4LzI2LzIwMjXCoDExOjMwwqBQTSzC
oFpoaWppYW7CoExpwqAoRnVqaXRzdSnCoHdyb3RlOg0KPj4gQWxsLA0KPj4NCj4+DQo+PiBJwqBo
YXZlwqBjb25maXJtZWTCoHRoYXTCoGluwqB0aGXCoCFDWExfUkVHSU9OwqBjb25maWd1cmF0aW9u
LMKgdGhlwqBzYW1lwqBlbnZpcm9ubWVudMKgbWF5wqBmYWlswqB0b8KgZmFsbMKgYmFja8KgdG/C
oGhtZW0uKFlvdXLCoG5ld8KgcGF0Y2jCoGNhbm5vdMKgcmVzb2x2ZcKgdGhpc8KgaXNzdWUpDQo+
Pg0KPj4gSW7CoG15wqBlbnZpcm9ubWVudDoNCj4+IC3CoFRoZXJlwqBhcmXCoHR3b8KgQ1hMwqBt
ZW1vcnnCoGRldmljZXPCoGNvcnJlc3BvbmRpbmfCoHRvOg0KPj4gwqDCoMKgwqBgYGANCj4+IMKg
wqDCoMKgNWQwMDAwMDAwLTZjZmZmZmZmwqA6wqBDWEzCoFdpbmRvd8KgMA0KPj4gwqDCoMKgwqA2
ZDAwMDAwMDAtN2NmZmZmZmbCoDrCoENYTMKgV2luZG93wqAxDQo+PiDCoMKgwqDCoGBgYA0KPj4g
LcKgRTgyMMKgdGFibGXCoGNvbnRhaW5zwqBhwqAnc29mdMKgcmVzZXJ2ZWQnwqBlbnRyeToNCj4+
IMKgwqDCoMKgYGBgDQo+PiDCoMKgwqDCoFvCoMKgwqDCoDAuMDAwMDAwXcKgQklPUy1lODIwOsKg
W21lbcKgMHgwMDAwMDAwNWQwMDAwMDAwLTB4MDAwMDAwMDdjZmZmZmZmZl3CoHNvZnTCoHJlc2Vy
dmVkDQo+PiDCoMKgwqDCoGBgYA0KPj4NCj4+IEhvd2V2ZXIswqBzaW5jZcKgbXnCoEFDUEnCoFNS
QVTCoGRvZXNuJ3TCoGRlc2NyaWJlwqB0aGXCoENYTMKgbWVtb3J5wqBkZXZpY2VzwqAodGhlwqBw
b2ludCkswqBgYWNwaS9obWF0LmNgwqB3b24ndMKgYWxsb2NhdGXCoG1lbW9yecKgdGFyZ2V0c8Kg
Zm9ywqB0aGVtLsKgVGhpc8KgcHJldmVudHPCoHRoZcKgY2FsbMKgY2hhaW46DQo+PiBgYGBjDQo+
PiBobWF0X3JlZ2lzdGVyX3RhcmdldF9kZXZpY2VzKCnCoC8vwqBmb3LCoGVhY2jCoFNSQVQtZGVz
Y3JpYmVkwqB0YXJnZXQNCj4+IMKgwqDCoMKgLT7CoGhtZW1fcmVnaXN0ZXJfcmVzb3VyY2UoKQ0K
Pj4gwqDCoMKgwqDCoMKgLT7CoGluc2VydMKgZW50cnnCoGludG/CoCJITUVNwqBkZXZpY2VzIsKg
cmVzb3VyY2UNCj4+IGBgYA0KPj4NCj4+IFRoZXJlZm9yZSzCoGZvcsKgc3VjY2Vzc2Z1bMKgZmFs
bGJhY2vCoHRvwqBobWVtwqBpbsKgdGhpc8KgZW52aXJvbm1lbnQ6wqBgZGF4X2htZW0ua29gwqBh
bmTCoGBrbWVtLmtvYMKgbXVzdMKgcmVxdWVzdMKgcmVzb3VyY2VzwqBCRUZPUkXCoGBjeGxfYWNw
aS5rb2DCoGluc2VydHPCoCdDWEzCoFdpbmRvd8KgWCcNCj4+DQo+PiBIb3dldmVywqB0aGXCoGtl
cm5lbMKgY2Fubm90wqBndWFyYW50ZWXCoHRoaXPCoGluaXRpYWxpemF0aW9uwqBvcmRlci4NCj4+
DQo+PiBXaGVuwqBjeGxfYWNwacKgcnVuc8KgYmVmb3JlwqBkYXhfa21lbS9rbWVtOg0KPj4gYGBg
DQo+PiAoYnVpbHQtaW4pwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoENYTF9SRUdJ
T049bg0KPj4gZHJpdmVyL2RheC9obWVtL2RldmljZS5jwqDCoGN4bF9hY3BpLmtvwqDCoMKgwqDC
oMKgZGF4X2htZW0ua2/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrbWVtLmtvDQo+Pg0K
Pj4gKDEpwqBBZGTCoGVudHJ5wqAnMTVkMDAwMDAwMC03Y2ZmZmZmZmYnDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCgyKcKgVHJhdmVyc2XCoCJITUVNwqBkZXZpY2VzIg0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEluc2VydMKgdG/CoGlvbWVtOg0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDVkMDAwMDAwMC03Y2ZmZmZmZsKg
OsKgU29mdMKgUmVzZXJ2ZWQNCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgKDMpwqBJbnNlcnTCoENYTMKgV2luZG93wqAwLzENCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC9wcm9jL2lvbWVt
wqBzaG93czoNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDVkMDAwMDAwMC03Y2ZmZmZmZsKgOsKgU29mdMKgUmVzZXJ2ZWQNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA1ZDAw
MDAwMDAtNmNmZmZmZmbCoDrCoENYTMKgV2luZG93wqAwDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgNmQwMDAwMDAwLTdjZmZmZmZm
wqA6wqBDWEzCoFdpbmRvd8KgMQ0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCg0
KcKgQ3JlYXRlwqBkYXjCoGRldmljZQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKDUpwqByZXF1ZXN0
X21lbV9yZWdpb24oKcKgZmFpbHMNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmb3LCoDVkMDAw
MDAwMC03Y2ZmZmZmZg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFJlYXNvbjrCoENoaWxkcmVu
wqBvZsKgJ1NvZnTCoFJlc2VydmVkJw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoChDWEzCoFdp
bmRvd3PCoDAvMSnCoGRvbid0wqBjb3ZlcsKgZnVsbMKgcmFuZ2UNCj4+IGBgYA0KPj4NCj4gDQo+
IFRoYW5rcyBmb3IgY29uZmlybWluZyB0aGUgZmFpbHVyZSBwb2ludC4gSSB3YXMgdGhpbmtpbmcg
b2YgdHdvIHBvc3NpYmxlIHdheXPCoGZvcndhcmTCoGhlcmUswqBhbmTCoEnCoHdvdWxkwqBsaWtl
wqB0b8KgZ2V0wqBmZWVkYmFja8KgZnJvbcKgb3RoZXJzOg0KPiANCj4gWzFdwqBUZWFjaMKgZGF4
X2htZW3CoHRvwqBzcGxpdMKgd2hlbsKgdGhlwqBwYXJlbnTCoGNsYWltwqBmYWlsczoNCj4gSWYg
X19yZXF1ZXN0X3JlZ2lvbigpIGZhaWxzIGZvciB0aGUgdG9wLWxldmVsIFNvZnQgUmVzZXJ2ZWQg
cmFuZ2UgYmVjYXVzZSBJT1JFU19ERVNDX0NYTCBjaGlsZHJlbiBhbHJlYWR5IGV4aXN0LCBkYXhf
aG1lbSBjb3VsZCBpdGVyYXRlIHRob3NlIHdpbmRvd3MgYW5kIHJlZ2lzdGVyIGVhY2ggb25lIGlu
ZGl2aWR1YWxseS4gVGhlIGRvd25zaWRlIGlzIHRoYXQgaXQgYWRkcyBzb21lIGNvbXBsZXhpdHkg
YW5kIGZlZWxzIGEgYml0IGxpa2UgcGFwZXJpbmcgb3ZlciB0aGUgZmFjdCB0aGF0IENYTCBzaG91
bGQgZXZlbnR1YWxseSBvd24gYWxsIG9mIHRoaXMgbWVtb3J5LiANCg0KSSBleGFtaW5lZCBiZWxv
dyBjaGFuZ2UgdG8gZW5zdXJlIGttZW0gcnVucyBmaXJzdCwgaXQgc2VlbWVkIHRvIHdvcmsuDQoN
CiAgc3RhdGljIGludCBfX2luaXQgY3hsX2FjcGlfaW5pdCh2b2lkKQ0KICB7DQorICAgICAgIGlm
ICghSVNfRU5BQkxFRChDT05GSUdfREVWX0RBWF9DWEwpICYmIElTX0VOQUJMRUQoQ09ORklHX0RF
Vl9EQVhfS01FTSkpIHsNCisgICAgICAgICAgICAgICAvKiBmYWxsIGJhY2sgdG8gZGF4X2htZW0s
a21lbSAqLw0KKyAgICAgICAgICAgICAgIHJlcXVlc3RfbW9kdWxlKCJrbWVtIik7DQorICAgICAg
IH0NCiAgICAgICAgIHJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmN4bF9hY3BpX2Ry
aXZlcik7DQogIH0NCg0KDQo+IEFzIERhbiBtZW50aW9uZWQsIHRoZSBsb25nLXRlcm0gcGxhbiBp
cyBmb3IgTGludXggdG8gbm90IG5lZWQgdGhlIHNvZnQtcmVzZXJ2ZSBmYWxsYmFjayBhdCBhbGws
IGFuZCBzaW1wbHkgaWdub3JlIFNvZnQgUmVzZXJ2ZSBmb3IgQ1hMIFdpbmRvd3MgYmVjYXVzZSB0
aGUgQ1hMIHN1YnN5c3RlbcKgd2lsbMKgaGFuZGxlwqBpdC4NCg0KVGhlIGN1cnJlbnQgQ1hMX1JF
R0lPTiBrY29uZmlnIHN0YXRlczoNCiAgIE90aGVyd2lzZSwgcGxhdGZvcm0tZmlybXdhcmUgbWFu
YWdlZCBDWEwgaXMgZW5hYmxlZCBieSBiZWluZyBwbGFjZWQgaW4gdGhlIHN5c3RlbSBhZGRyZXNz
IG1hcCBhbmQgZG9lcyBub3QgbmVlZCBhIGRyaXZlci4NCg0KSSB0aGluayB0aGlzIGltcGxpZXMg
dGhhdCBhIGZhbGxiYWNrIHRvIGRheF9obWVtL2ttZW0gaXMgc3RpbGwgcmVxdWlyZWQgZm9yIHN1
Y2ggY2FzZXMuDQoNCk9mIGNvdXJzZSwgSSBwZXJzb25hbGx5IGFncmVlIHdpdGggdGhpcyAnbG9u
Zy10ZXJtIHBsYW4nLg0KDQoNCg0KPiANCj4gWzJdwqBBbHdheXPCoHVuY29uZGl0aW9uYWxsecKg
bG9hZMKgQ1hMwqBlYXJseS4uDQo+IENhbGwgcmVxdWVzdF9tb2R1bGUoImN4bF9hY3BpIik7IHJl
cXVlc3RfbW9kdWxlKCJjeGxfcGNpIik7IGZyb20gZGF4X2htZW1faW5pdCgpICh3aXRob3V0IHRo
ZSBJU19FTkFCTEVEKENPTkZJR19ERVZfREFYX0NYTCkgZ3VhcmQpLiBJZiB0aG9zZSBhcmUgeS9t
LCB0aGV54oCZbGwgYmUgcHJlc2VudDsgaWYgbiwgaXTigJlzIGEgbm8tb3AuIFRoZW4gaW4gaG1l
bV9yZWdpc3Rlcl9kZXZpY2UoKcKgZHJvcMKgdGhlwqBJU19FTkFCTEVEKENPTkZJR19ERVZfREFY
X0NYTCnCoGdhdGXCoGFuZMKgZG86DQo+IA0KPiBpZsKgKHJlZ2lvbl9pbnRlcnNlY3RzKHJlcy0+
c3RhcnQswqByZXNvdXJjZV9zaXplKHJlcyksDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoElPUkVTT1VSQ0VfTUVNLMKgSU9SRVNfREVTQ19DWEwpwqAhPVJF
R0lPTl9ESVNKT0lOVCkNCj4gIMKgwqDCoMKgLyrCoGRlZmVywqB0b8KgQ1hMwqAqLzsNCj4gDQo+
IGFuZCBkZWZlciB0byBDWEwgaWYgd2luZG93cyBhcmUgcHJlc2VudC4gVGhpcyBtYWtlcyBTb2Z0
IFJlc2VydmVkIHVuYXZhaWxhYmxlIG9uY2UgQ1hMIFdpbmRvd3MgaGF2ZSBiZWVuIGRpc2NvdmVy
ZWQsIGV2ZW4gaWYgQ1hMX1JFR0lPTiBpcyBkaXNhYmxlZC4gVGhhdCBhbGlnbnMgYmV0dGVyIHdp
dGggdGhlIGlkZWEgdGhhdCDigJxDWEwgc2hvdWxkIHdpbuKAnSB3aGVuZXZlciBhIHdpbmRvdyBp
cyB2aXNpYmxlIChUaGlzIGFsc28gbmVlZHMgdG8gYmUgY29uc2lkZXJlZCBhbG9uZ3NpZGUgcGF0
Y2jCoDYvNsKgaW7CoG15wqBzZXJpZXMuKQ0KPiANCj4gV2l0aCBDWExfUkVHSU9OPW4gdGhlcmUg
d291bGQgYmUgbm8gZGV2ZGF4IGFuZCBubyBrbWVtIGZvciB0aGF0IHJhbmdlOyBwcm9jL2lvbWVt
wqB3b3VsZMKgc2hvd8Kgb25secKgdGhlwqB3aW5kb3dzwqBzb21ldGhpbmfCoGxpa2XCoGJlbG93
DQo+IA0KPiA4NTAwMDAwMDAtMjg0ZmZmZmZmZsKgOsKgQ1hMwqBXaW5kb3fCoDANCj4gMjg1MDAw
MDAwMC00ODRmZmZmZmZmwqA6wqBDWEzCoFdpbmRvd8KgMQ0KPiA0ODUwMDAwMDAwLTY4NGZmZmZm
ZmbCoDrCoENYTMKgV2luZG93wqAyDQo+IA0KPiBUaGF0IG1lYW5zIHRoZSBtZW1vcnkgaXMgbGVm
dCB1bmNsYWltZWQvdW5hdmFpbGFibGUuLiAobm8gU3lzdGVtIFJBTSwgbm8gL2Rldi9kYXgpLsKg
SXPCoHRoYXTCoGFjY2VwdGFibGXCoHdoZW7CoENYTF9SRUdJT07CoGlzwqBkaXNhYmxlZD8NCg0K
UmVnYXJkaW5nIG9wdGlvbiBbMl0gKHVuY29uZGl0aW9uYWxseSBsb2FkaW5nIENYTCBlYXJseSk6
DQpUaGlzIGFwcHJvYWNoIGNvbmZsaWN0cyB3aXRoIHRoZSBDWExfUkVHSU9OIEtjb25maWcgZGVz
Y3JpcHRpb24gbWVudGlvbmVkIGFib3ZlLg0KDQoNCi0tLQ0KVG8gcmVmb2N1cyBvbiB0aGUgb3Jp
Z2luYWwgaXNzdWUg4oCTIHRoZSBpbmFiaWxpdHkgdG8gcmVjcmVhdGUgcmVnaW9ucyBhZnRlciBk
ZXN0cnVjdGlvbiB3aGVuIENYTCBXaW5kb3dzIG92ZXJsYXAgd2l0aCBTb2Z0IFJlc2VydmVkDQpJ
IGJlbGlldmUgeW91ciBwYXRjaCBzZXJpZXMgIltQQVRDSCAwLzZdIGRheC9obWVtLCBjeGw6IENv
b3JkaW5hdGUgU29mdCBSZXNlcnZlZCBoYW5kbGluZyB3aXRoIENYTCIgZWZmZWN0aXZlbHkgYWRk
cmVzc2VzIHRoaXMgcHJvYmxlbS4NCiAgDQpBcyBmb3IgdGhlIHByZS1leGlzdGluZyBpc3N1ZXMg
d2l0aCAhQ1hMX1JFR0lPTiBhbmQgdGhlIHVuaW1wbGVtZW50ZWQgREFYX0NYTF9NT0RFX1JFR0lT
VEVSLCBJIHN1Z2dlc3QgZGVmZXJyaW5nIHRoZW0gZm9yIG5vdy4NClRoZXkgbmVlZCBub3QgYmUg
cmVzb2x2ZWQgd2l0aGluIHRoaXMgcGF0Y2ggc2V0LCBhcyB3ZSBzaG91bGQgcHJpb3JpdGl6ZSB0
aGUgaW5pdGlhbCBwcm9ibGVtLg0KDQoNClRoYW5rcw0KWmhpamlhbg0K

