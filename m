Return-Path: <linux-fsdevel+bounces-50806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326AEACFBE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBA27A9E2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4B1DE885;
	Fri,  6 Jun 2025 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kTO3AqQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103923A6;
	Fri,  6 Jun 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749183389; cv=fail; b=VVl5JB/3MxNRB0uGvGVW2pyNI/PYEtt1mYP4PD5oIffopsAMNMQdGXlBECWqd58XRp73w1UZ7MHjJi3sB6BA0jEU1Mmg4ZND01RzwTVqnIFavmXPQ+hoXKis1QmtHM5emehPbgcaO0sKRjaHYEPwRhKSI0q7ZrxK+h2jEYjNOaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749183389; c=relaxed/simple;
	bh=rPR1ndrrdL2hH5XuUb97h+RirXIEEMjG8OM5W4tgedA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGtAOUjqVQ5qk1mpmEUnek0lrfyPol3J8Es1VRAurYhE9eXUqRWv2RRcMrgiym5gAVtAUKT3BSz4Iu+FPHIZNYqT+J3KIIvthCiN4CLrG4oCcbmIk3KGyboNl89WosRB1EDHYrOJWjSuId4RyMOgwMcsbWgAAOywV71iSsHpGoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kTO3AqQK; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749183387; x=1780719387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rPR1ndrrdL2hH5XuUb97h+RirXIEEMjG8OM5W4tgedA=;
  b=kTO3AqQKrYRUkdhMs4jVXAwzFviJ17CaRFBDNbcqxPHCkQXL98tcTEBr
   x4paGnyuObZMj8zLa0G3uyVqfoH+wO6jVVvHgZ5guVII8J7j6R0BzuIx+
   h0OnKVy0k2j8JNUqY532zRStyoreU4aa5RQIK39trnqtmx5B31Yq61/zc
   fYk6yQ5cEnkdEJDheSZTUXvA8z78Q1DPVLE82Q1I1SsVsBX2o3Si9rhJJ
   g2Z0+f+wcPxLtRSseGGFIhQf/VICsdUGA+gcP816PdKOKEd6eyyebsUOL
   y7GSXMXXDj+u+RPij6Wrf57j6/NHXc2ia/z7W3+3ruutD9LsjMBnXT7ax
   A==;
X-CSE-ConnectionGUID: mG9TnImsQiOIRhECU+NPNg==
X-CSE-MsgGUID: d7iR+VDzR6qKmuFp3mhxTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="68783594"
X-IronPort-AV: E=Sophos;i="6.16,214,1744038000"; 
   d="scan'208";a="68783594"
Received: from mail-japaneastazon11010052.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 13:16:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9QcwqPKc4J0nDEv+2y6k4vSuZNiB6uCwWv1BtL26ZUimu4W7w9pmEirE9i8ZVXYcRMl4Kwd/hWJt8Lh5Ag1R/p1HDWHhbc6S2EoBHhaR/i7YofbbZ9Sw7pGTZrD07A4QKHOm0h4SnN13YwT/9F8xQExQLUenQ+wSrMMVMpmRcGGrD5AaQr9q8VqKBsLEhikk6pLDsKOFqa/Ro+uynBcttgacQ331yY2SFzNhgm+bFrwrx56wbUezAK24Ev+kr+r25IN8M+G2izjYcX+bb+t323hU+SfmYPs1ulpP0xsY8v4u4x84033qgwOq76gXB2YgnvTYs5K56D08ddhF03c3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPR1ndrrdL2hH5XuUb97h+RirXIEEMjG8OM5W4tgedA=;
 b=WIzjvBJqrOb+c8SuxC4y0QabuXaoWbJnd03fB3DN+1aSnMgi9eKBJdiGaA8zsisQhgfAOWwxZUEUIBw1UmyOxmMqAk0jADqIJGP36aU3YBVIOWQToS58ZftrSBNUXThfgfqI1oQgXeI0CWfyZuGQFquw4RnTxGCccHQWQQhdZGPfTr70CEJkfNCJjktHXccpMqoviXZA1cYJT8lNTn/u4U1cqcr1xr2F/uWCx4Ow/PMOyY5Kv0VxRiTI1WwRLkjXms1TtyiVQy8bzW+2r+fjIiD3LpQHu9HIf+y0vAfDcyv6drvGAlMcJCJKs86oLghi+1GclxFAMZvX+Wi0pte39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB5840.jpnprd01.prod.outlook.com (2603:1096:400:a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 04:16:09 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 04:16:08 +0000
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
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
Thread-Topic: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
Thread-Index: AQHb1NWvtbNnXafuvki4qeiq5rRAV7P1iceA
Date: Fri, 6 Jun 2025 04:16:08 +0000
Message-ID: <3e045950-9ffb-4a9b-9793-958a16db0c33@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB5840:EE_
x-ms-office365-filtering-correlation-id: 4184c0d2-ac66-4023-7a69-08dda4b0dd08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkVsd1hObElmQmo0WEVMREp1Mjd6Y3ZhK2Y2R0I2dmJyeEFCbTcrNk1EVVFL?=
 =?utf-8?B?N0FLbEF4VWNFdCtnYWpqeEVNTjN6eklINnJuNm9VM0pWOHRCWVQwVHlPQ2Q3?=
 =?utf-8?B?OCtIazlBd2d3ckdnZzVCV01KTGVVcFRWS3M3T1ZnUDF6dkNVWmdrd3M4bVJo?=
 =?utf-8?B?dFFhK3dCMUpwK2VMOXFJVk1hQ3A3cExERlJ1anAvc1I0Z3BwVjZoRlRXZVgv?=
 =?utf-8?B?L1VWU2ZWSGw5b2NES2xGUEpOR3gwR1RmME5XNS9mcXhoWk1QSzlqb2hGVDFa?=
 =?utf-8?B?SUhmc2FBZEpBME40WmdvYmdqWm9OM0VHSjNBeExtM0FJemRPZ1FRcUs4dDlO?=
 =?utf-8?B?cndrbWlING4xMnYxeU9YZ2c1SnpvTlNVVHphSmt4a0lraCtpYjZvNitOYm5p?=
 =?utf-8?B?MjZFNWxaM1FvSzJrS2ZLa0N4S0RDdllYNXlvVk1hVGVPTmh0LzZqMHVBOE5J?=
 =?utf-8?B?enlVTmlHbXpWdTd6M1gxVW9ZT3dzRWFrZFAvTDZrczA5anhvelRDV3ArM0M3?=
 =?utf-8?B?YlZRdXVpZ3lVNE1FU1JOMlVUM0xuSm1tRFp3cFpMMXZ2N1pGODdhMVhweGh5?=
 =?utf-8?B?UzgzczcwYW9ZSWZTTDFNakh6UXdaWG04K2JlMlMyVWd0b2pENGhLUURMZ1o0?=
 =?utf-8?B?Nmt6YitObU10R0NYd0V1T3Y0WEpMNjFaVzIrakdKMHZvelhyZmR2b3FNdVRH?=
 =?utf-8?B?Z0JMcVd0YzliUWpPTXZmVVJWNGsxUzI0aVlMS0N0OGxFaWxodE9xdjdyT1B6?=
 =?utf-8?B?Rmcrd3NIdDNFQjFTblhJaEdNRWRwYVBBU2hVZk9yQjRhQ0IxNjFraS9KaXdm?=
 =?utf-8?B?dVg5VlVYbzNZR1Ewa1dmbVN5c0c5ZGordkdQaUwvZEhxSGxRQVdpc3luUFlj?=
 =?utf-8?B?RUZpMGxNdExBQzJGWTZ5am5Xd2U3OWlYSS8ycWxRNG54MXVVR0JkNGM3ellz?=
 =?utf-8?B?MlliWWdDa0VmdzZsWk1XaWlLa0tnSlRLTzVFU05NVy9ENU1XRFMvdlRmZHhw?=
 =?utf-8?B?Z3VHQU9KaytrZDBvZmFyMWd5czJpNEN0MGpBWDFSSWhEM2d5dnpzYk1OSFEy?=
 =?utf-8?B?RzAwUlB2cHJ2ZitsckxaUHI5SFB1SXIxVmcyQ3hGSnZyc20yN1dicXovczU0?=
 =?utf-8?B?aVRrWDdtVFN5Zmd6VFdja3lySU1idStPNGdFOFZaRlo2MFpLdlpOdUZ5QVdW?=
 =?utf-8?B?bk5mZzJqeVpWbGRLVm55eGhUcUc3R3B5UkxLNzlUTjZHaUt0czB1Zk9OTThR?=
 =?utf-8?B?VUgyMmlHVDkwVGNlOVgxRzNlTWlBcDJ2SGVYMkhmb2ZlVDZFY3JKekd5TEVZ?=
 =?utf-8?B?K3BpakpPK1IydEZKWUJ4OEFrK3Y0WkRZcE0xeGpIRUt1b1B3MHd2K1JxNThC?=
 =?utf-8?B?UXpCVGZaZCsvdW54YWV5ZXp3c2xrT202M1UrRmJMSHFDK0RIM2xRYktSak5w?=
 =?utf-8?B?WmRMS2hjMHd2R0JwNjlKNTJNeDNIUFdNSmwwcHhUNkFDZTNnbEUxN1plV1ZJ?=
 =?utf-8?B?VENldUFseGtya0taWjNTMktHVFJaOWppU1JGT2hveEdFS0huQUl1anZLaVN6?=
 =?utf-8?B?RUdKRWFua252eUNBNk9rcitzaWI2bWFlenhmNE01cGMrN1hmb2hCWjhtY3Z4?=
 =?utf-8?B?Y1o0bEVocVA4Rzg3b2RlZEpuVWNtSlpodGtlbC9HMEVSSzBQUXFCMU9qejg4?=
 =?utf-8?B?OTFQbllnZjBEWDdLWVdKQVpERGVnOW5oNlozcnhqNEQ2c3ovRDNpUnpKUjc3?=
 =?utf-8?B?UXl3bkU4aTdsbjdOYVROZEpqSlJBOTJidEV3YnhLSHE2MmpSZmh1bWlWTGtK?=
 =?utf-8?B?WnY5WTlhSkFVL0tvOGsrUVJ0MjFBN1BtQ0ZlVXl2Q0l4TGEwRkExL2tSSmdK?=
 =?utf-8?B?Z2JRcGswUXAyTldlRzNPMXJWQlZGYitFeVkzUUlVSERyMlg5RzB3VFRHamFn?=
 =?utf-8?B?VUxMT3VNTHlNQ2o2ck1NNXRLUHBXMDBWckxybjh4QTF2SEU3RHExZXk3dGFQ?=
 =?utf-8?B?NC9EYjE4aFdwWm4vMnlhMkNrN3lrS3pUbHpoUzhmWkdBa3AwYUFZOUtYNHRx?=
 =?utf-8?Q?BE9DRp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmtJWXBaakVEM2tzZCtjMUtneUd0VlNKUVpuWmV2M1lIMUpmekdkd1piWVVU?=
 =?utf-8?B?M0FiMFF4ZllBMnZKcUg0Y0pkWFhBaXpGZWVLMWlUNnlZblVZaDN1OFh2alpZ?=
 =?utf-8?B?OW9jVXhia3hhZ0UvVWxOT0RiL21lVnhLYWVRT0dPRHBSbEN1R3Fia0JrMU5X?=
 =?utf-8?B?UTc0STZMUllBSUN3aGtLZ1pEaXRtZ2JNWmJxMTlBTm1mSkFiQzByQUdBRXY0?=
 =?utf-8?B?QittVll0RFQzOWhIYzkrVmVjWldKSHZXMEhRR3V3M1Z1OE9WbGpTUUUvMlQ4?=
 =?utf-8?B?N3E4bDBxdHNXUFhjVUVTWWdBbi91bnhINlBNcTZJeHRZK2tJNUsyV1l5WS9C?=
 =?utf-8?B?N0IrNUJUdFpnTE1yMDk1N1BNbUtXYm9CSDJ4VFo3cCs3VUk3SVVzQ2hrb0RF?=
 =?utf-8?B?bGZoRmtKd1RvOHoxdHh5MDc4b1dHZUVURWJkNStuRDRaSHRaRzlVTzFEWWlR?=
 =?utf-8?B?RHNhbGpLM2s2WkpZRXpFbE5kSFROektZcGlQbEUwZml4N28rMVdUMHdGTVRl?=
 =?utf-8?B?d002WWdTdWdnd2ZXU3hDWks1QXMyVEJPNGY3VVpVNXdBUklGN2FObDRUYTQ2?=
 =?utf-8?B?SHVNVnZXYTUwdGJxSjZNcmt3d2haSzVvS2YwVXJ4RXVybGloZWtQRXF1MjV3?=
 =?utf-8?B?QVdBOWFlNWlyQk51elBkUWhRZHFGdEpmb2E3eGtsT3VPeWRBS1FoYk5ZdFB2?=
 =?utf-8?B?T1FRbHR1b1hKVk1MeXBERUdRaG5LT0owT24walFYV1FZYWZOdWJYYzdGcDk1?=
 =?utf-8?B?TG03cXJCaVlSWWh1V1FnSkFBTWhGejRKeUJVK1pIVFZwcGQ0aHRFL1pkcGwz?=
 =?utf-8?B?dEZwKzg4dFl2cm94OVY0bUNGUHVXWUlRam5MTVptWTJhcld3MVhzSTN3Q2V0?=
 =?utf-8?B?OUJRdTY5TFdlSlhoU2IvRXY3c1ZXNXdsTHliVVl5SUc2cDdEbHpGcHN5Qis1?=
 =?utf-8?B?VDkycjVWTGhqQmxBR3ZaSis5YS93T3FFcnNNSVVwV1R1QlNzV1FpTkp1SGRv?=
 =?utf-8?B?YzkrUE5VQWtUaDJjODVISDlKQzJhU0I0eDVjaDZaUzErQ2tpUnFmdDIvOEh6?=
 =?utf-8?B?bWZSNE9HMit1K1FqNE1DdHZjSlVNaWtGN1hzYWlSUHVlQTVHbnpLTkhRMmlh?=
 =?utf-8?B?UkFkZnVLTTAvSlB6WXdOQjJ5NXNjM3QrT0dpRDVCQTd4UXNEaVJhbTlmOFFo?=
 =?utf-8?B?QjEvQytSOWg0SDd3cURBQU9sZzhHaWlXSDR1alNGczlSWUtYUHoxa1pnN2pn?=
 =?utf-8?B?OVJkeWpvd3p0VENiYUlId0xBNG5rWTloV3B6aFhOUmtYNlRLcTJXNHkvRUpP?=
 =?utf-8?B?UmszcGtSN2dLby9nc2lHT0FVUU9IUDNrMEh5QldodXlNUmE1Um9NSHNXdmxX?=
 =?utf-8?B?UjQyM0tyTmJLNXlHRC8vRW9wY21QcnkwN1MxdlpoZDRDbStlY0hOWWhIWnBj?=
 =?utf-8?B?cEdIWnNaVDRLUm5GUmp6amx5dXlPZHN1eUsyTnpEOFJpT3lRa0k0SWhETXkv?=
 =?utf-8?B?MU1EWGdvVEt6bTJ0MVJKU1pqMEtNZmxNRkhBZVdqVzNTTmd3UVVKd0QyZUQv?=
 =?utf-8?B?eUwvQk9haVVsb0dCSHJPemVaUEZaUWNSUU0rSkdmN1NwV29vRm54ZW5QbVZq?=
 =?utf-8?B?S2tZMSt2dzZ6aml3SjdrWUIvZ0FYUk1xQ01ub0ZrL0ZWYUVsVzdLV2J2MXBv?=
 =?utf-8?B?aGpXZDdXU253cGt6TVBPeGxBMERsQWtPMXhGSWp0ODFmQzhxMjMxTytyUWpV?=
 =?utf-8?B?QytiRjdhZWVFTnRQSVMyRHAwdERoWHdocnl2clpRUm11WkZqTjNjNnhiQms2?=
 =?utf-8?B?NHlNVHZPNDZHWXBaK0tzd29pdmJ6Y3ViTmZ0K2Ixell4c0x6MkMvSzhxKzgy?=
 =?utf-8?B?ejh6UklxWVA5Rm9VbXRqQnFMaUN0MzQyNWNJeVcyMFBjaXJ2bUtaSHJEcUEx?=
 =?utf-8?B?N1ZMZGx0RGxLcmpFbEVjWkNUd1JJS09rZXlNRUpUbEFNZmpzWERsTnd3R3Fo?=
 =?utf-8?B?dW4xS2FGSFpLQXhBaVo1eHFNc3IzT3hCNW1PUEpTVGRyMHdld0wrbXRMdkFn?=
 =?utf-8?B?WFVUb3RZa29yeEVDUXdnL1RqRG5aUmRQYjVnazFhc3NhYldiQWMrY2tGcWJJ?=
 =?utf-8?B?UEJCUEY2V0lLeUsxRzNPOS9kaGtEYkNzSUZFUEhuR0ppaGdYcXJmd0pscmd3?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93D31F9486F747448CBA883A872686F1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WJAG+WgW880YPvMsTxjGLKKhbFG7l3OFozrP9+5YZ9oKw+pGBliRwpN25xzpKxo8dDGrX6V39qQkqcZMkJk7Snl9y8SPyx3NvEjBC98U+MH+fecknHsl6RucZ3V+criDPH0hqZFObTmuki9A6hykvNOEsxefufwj3AR/mfgLk6Ox9hKbDUdn/LvxHj2AMpwRRmk75Z7l8wPYJ4K71nFbJG3ErO3NudVY9CLLRCsM2592q6wY4iWiLtDf/+VRXtfSwM8trngOIupmEp6yLkLqn8fHdcgtGFtOTX7AuWt2594aCdyWdkeGEI5yxdOUY/LiRgmCS1OJzY9+ZBjB/cmoULCZ0cMVB2wNMIiVsjM6Cl/GgSKDgVGEHmyuGl/W12b5sCPSii7YrIlnAMl1b/mK5a04q4atF3WfFMsn67XDRYWXCq4Vo3sHjNLydJC8oOFbnGZxvMhwNNHd9n+fFdTlRcVFVgLsHNpU4Q1izcnr8JtjU89Cvv+qWINJIXfAMmvZX2YfbIrz30nZiwR2gGyWsEt32HcVRj+4ESganaTKop1OId3iuVredyP0Mh4LjWg0DWjBS1e2Ljvh/kbRfK8jmJtXISz7+ef8gA69cdZCYhSHvFIMZEcwyatmt8fyt7jy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4184c0d2-ac66-4023-7a69-08dda4b0dd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 04:16:08.5720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esC1L+pqZduqpr//KWxiX8PBc92GgANEoYefi9RAW5dK/idMk8A6A0xGGzfkehbRJmKJ2Ds99mEOP9pm6CDPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5840

DQpUaGUgdGVybSAicmVnaW9uIHRlYXJkb3duIiBpbiB0aGUgc3ViamVjdCBsaW5lIGFwcGVhcnMg
aW5hY2N1cmF0ZS4NCg0KDQpBcyBJIHVuZGVyc3RhbmQsIGN4bF9yZWdpb25fc29mdHJlc2Vydl91
cGRhdGUoKSBzaG91bGQgd29yayBvbmx5DQp3aGVuIHRoZSByZWdpb24gaXMgcmVhZHksIGJ1dCB0
aGUgY3VycmVudCBsb2dpYyBvbmx5IGd1YXJhbnRlZXMgdGhhdCB0aGUgKm1lbWRldiogaXMgcmVh
ZHkuDQoNCklzIHRoZXJlIHRydWx5IG5vIHRpbWluZyBnYXAgYmV0d2VlbiByZWdpb24gcmVhZGlu
ZXNzIGFuZCBtZW1kZXYgcmVhZGluZXNzPw0KSWYgdGhpcyBhc3N1bXB0aW9uIGlzIHRydWUsIGNv
dWxkIHdlIGRvY3VtZW50IHRoaXMgcmVsYXRpb25zaGlwIGluIGJvdGggdGhlIGNvbW1pdCBsb2cg
YW5kIGNvZGUgY29tbWVudHM/DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KT24gMDQvMDYvMjAy
NSAwNjoxOSwgU21pdGEgS29yYWxhaGFsbGkgd3JvdGU6DQo+IFJld29ya2VkIGZyb20gYSBwYXRj
aCBieSBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gDQo+
IFByZXZpb3VzbHksIHdoZW4gQ1hMIHJlZ2lvbnMgd2VyZSBjcmVhdGVkIHRocm91Z2ggYXV0b2Rp
c2NvdmVyeSBhbmQgdGhlaXINCj4gcmVzb3VyY2VzIG92ZXJsYXBwZWQgd2l0aCBTT0ZUIFJFU0VS
VkVEIHJhbmdlcywgdGhlIHNvZnQgcmVzZXJ2ZWQgcmVzb3VyY2UNCj4gcmVtYWluZWQgaW4gcGxh
Y2UgYWZ0ZXIgcmVnaW9uIHRlYXJkb3duLiBUaGlzIGxlZnQgdGhlIEhQQSByYW5nZQ0KPiB1bmF2
YWlsYWJsZSBmb3IgcmV1c2UgZXZlbiBhZnRlciB0aGUgcmVnaW9uIHdhcyBkZXN0cm95ZWQuDQo+
IA0KPiBFbmhhbmNlIHRoZSBsb2dpYyB0byByZWxpYWJseSByZW1vdmUgU09GVCBSRVNFUlZFRCBy
ZXNvdXJjZXMgYXNzb2NpYXRlZA0KPiB3aXRoIGEgcmVnaW9uLCByZWdhcmRsZXNzIG9mIGFsaWdu
bWVudCBvciBoaWVyYXJjaHkgaW4gdGhlIGlvbWVtIHRyZWUuDQo+IA0KPiBMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjkzMTJjMDc2NTIyNGFlNzY4NjJkNTlhMTc3NDhj
ODE4OGZiOTVmMS4xNjkyNjM4ODE3LmdpdC5hbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbS8NCj4g
Q28tZGV2ZWxvcGVkLWJ5OiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVs
ZEBpbnRlbC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogVGVycnkgQm93bWFuIDx0ZXJyeS5ib3dt
YW5AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGVycnkgQm93bWFuIDx0ZXJyeS5ib3dtYW5A
YW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU21pdGEgS29yYWxhaGFsbGkgPFNtaXRhLktvcmFs
YWhhbGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2N4bC9hY3Bp
LmMgICAgICAgIHwgICAyICsNCj4gICBkcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIHwgMTUxICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9jeGwvY3hs
LmggICAgICAgICB8ICAgNSArKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTU4IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9hY3BpLmMgYi9kcml2ZXJzL2N4bC9h
Y3BpLmMNCj4gaW5kZXggOTc4ZjYzYjMyYjQxLi4xYjEzODhmZWIzNmQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvY3hsL2FjcGkuYw0KPiArKysgYi9kcml2ZXJzL2N4bC9hY3BpLmMNCj4gQEAgLTgy
Myw2ICs4MjMsOCBAQCBzdGF0aWMgdm9pZCBjeGxfc29mdHJlc2Vydl9tZW1fd29ya19mbihzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgCSAqIGFuZCBjeGxfbWVtIGRyaXZlcnMgYXJlIGxv
YWRlZC4NCj4gICAJICovDQo+ICAgCXdhaXRfZm9yX2RldmljZV9wcm9iZSgpOw0KPiArDQo+ICsJ
Y3hsX3JlZ2lvbl9zb2Z0cmVzZXJ2X3VwZGF0ZSgpOw0KPiAgIH0NCj4gICBzdGF0aWMgREVDTEFS
RV9XT1JLKGN4bF9zcl93b3JrLCBjeGxfc29mdHJlc2Vydl9tZW1fd29ya19mbik7DQo+ICAgDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29y
ZS9yZWdpb24uYw0KPiBpbmRleCAxMDliOGE5OGM0YzcuLjNhNWNhNDRkNjVmMyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3Jl
L3JlZ2lvbi5jDQo+IEBAIC0zNDQzLDYgKzM0NDMsMTU3IEBAIGludCBjeGxfYWRkX3RvX3JlZ2lv
bihzdHJ1Y3QgY3hsX3BvcnQgKnJvb3QsIHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hs
ZWQpDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0xfTlNfR1BMKGN4bF9hZGRfdG9fcmVnaW9uLCAi
Q1hMIik7DQo+ICAgDQo+ICtzdGF0aWMgaW50IGFkZF9zb2Z0X3Jlc2VydmVkKHJlc291cmNlX3Np
emVfdCBzdGFydCwgcmVzb3VyY2Vfc2l6ZV90IGxlbiwNCj4gKwkJCSAgICAgdW5zaWduZWQgbG9u
ZyBmbGFncykNCj4gK3sNCj4gKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlcyA9IGttYWxsb2Moc2l6ZW9m
KCpyZXMpLCBHRlBfS0VSTkVMKTsNCj4gKwlpbnQgcmM7DQo+ICsNCj4gKwlpZiAoIXJlcykNCj4g
KwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwkqcmVzID0gREVGSU5FX1JFU19NRU1fTkFNRUQo
c3RhcnQsIGxlbiwgIlNvZnQgUmVzZXJ2ZWQiKTsNCj4gKw0KPiArCXJlcy0+ZGVzYyA9IElPUkVT
X0RFU0NfU09GVF9SRVNFUlZFRDsNCj4gKwlyZXMtPmZsYWdzID0gZmxhZ3M7DQo+ICsJcmMgPSBp
bnNlcnRfcmVzb3VyY2UoJmlvbWVtX3Jlc291cmNlLCByZXMpOw0KPiArCWlmIChyYykgew0KPiAr
CQlrZnJlZShyZXMpOw0KPiArCQlyZXR1cm4gcmM7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHJlbW92ZV9zb2Z0X3Jlc2VydmVkKHN0cnVjdCBj
eGxfcmVnaW9uICpjeGxyLCBzdHJ1Y3QgcmVzb3VyY2UgKnNvZnQsDQo+ICsJCQkJIHJlc291cmNl
X3NpemVfdCBzdGFydCwgcmVzb3VyY2Vfc2l6ZV90IGVuZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgY3hs
X3Jvb3RfZGVjb2RlciAqY3hscmQgPSB0b19jeGxfcm9vdF9kZWNvZGVyKGN4bHItPmRldi5wYXJl
bnQpOw0KPiArCXJlc291cmNlX3NpemVfdCBuZXdfc3RhcnQsIG5ld19lbmQ7DQo+ICsJaW50IHJj
Ow0KPiArDQo+ICsJLyogUHJldmVudCBuZXcgdXNhZ2Ugd2hpbGUgcmVtb3Zpbmcgb3IgYWRqdXN0
aW5nIHRoZSByZXNvdXJjZSAqLw0KPiArCWd1YXJkKG11dGV4KSgmY3hscmQtPnJhbmdlX2xvY2sp
Ow0KPiArDQo+ICsJLyogQWxpZ25zIGF0IGJvdGggcmVzb3VyY2Ugc3RhcnQgYW5kIGVuZCAqLw0K
PiArCWlmIChzb2Z0LT5zdGFydCA9PSBzdGFydCAmJiBzb2Z0LT5lbmQgPT0gZW5kKQ0KPiArCQln
b3RvIHJlbW92ZTsNCj4gKw0KPiArCS8qIEFsaWducyBhdCBlaXRoZXIgcmVzb3VyY2Ugc3RhcnQg
b3IgZW5kICovDQo+ICsJaWYgKHNvZnQtPnN0YXJ0ID09IHN0YXJ0IHx8IHNvZnQtPmVuZCA9PSBl
bmQpIHsNCj4gKwkJaWYgKHNvZnQtPnN0YXJ0ID09IHN0YXJ0KSB7DQo+ICsJCQluZXdfc3RhcnQg
PSBlbmQgKyAxOw0KPiArCQkJbmV3X2VuZCA9IHNvZnQtPmVuZDsNCj4gKwkJfSBlbHNlIHsNCj4g
KwkJCW5ld19zdGFydCA9IHNvZnQtPnN0YXJ0Ow0KPiArCQkJbmV3X2VuZCA9IHN0YXJ0IC0gMTsN
Cj4gKwkJfQ0KPiArDQo+ICsJCXJjID0gYWRkX3NvZnRfcmVzZXJ2ZWQobmV3X3N0YXJ0LCBuZXdf
ZW5kIC0gbmV3X3N0YXJ0ICsgMSwNCj4gKwkJCQkgICAgICAgc29mdC0+ZmxhZ3MpOw0KPiArCQlp
ZiAocmMpDQo+ICsJCQlkZXZfd2FybigmY3hsci0+ZGV2LCAiY2Fubm90IGFkZCBuZXcgc29mdCBy
ZXNlcnZlZCByZXNvdXJjZSBhdCAlcGFcbiIsDQo+ICsJCQkJICZuZXdfc3RhcnQpOw0KPiArDQo+
ICsJCS8qIFJlbW92ZSB0aGUgb3JpZ2luYWwgU29mdCBSZXNlcnZlZCByZXNvdXJjZSAqLw0KPiAr
CQlnb3RvIHJlbW92ZTsNCj4gKwl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIE5vIGFsaWdubWVudC4g
QXR0ZW1wdCBhIDMtd2F5IHNwbGl0IHRoYXQgcmVtb3ZlcyB0aGUgcGFydCBvZg0KPiArCSAqIHRo
ZSByZXNvdXJjZSB0aGUgcmVnaW9uIG9jY3VwaWVkLCBhbmQgdGhlbiBjcmVhdGVzIG5ldyBzb2Z0
DQo+ICsJICogcmVzZXJ2ZWQgcmVzb3VyY2VzIGZvciB0aGUgbGVhZGluZyBhbmQgdHJhaWxpbmcg
YWRkciBzcGFjZS4NCj4gKwkgKi8NCj4gKwluZXdfc3RhcnQgPSBzb2Z0LT5zdGFydDsNCj4gKwlu
ZXdfZW5kID0gc29mdC0+ZW5kOw0KPiArDQo+ICsJcmMgPSBhZGRfc29mdF9yZXNlcnZlZChuZXdf
c3RhcnQsIHN0YXJ0IC0gbmV3X3N0YXJ0LCBzb2Z0LT5mbGFncyk7DQo+ICsJaWYgKHJjKQ0KPiAr
CQlkZXZfd2FybigmY3hsci0+ZGV2LCAiY2Fubm90IGFkZCBuZXcgc29mdCByZXNlcnZlZCByZXNv
dXJjZSBhdCAlcGFcbiIsDQo+ICsJCQkgJm5ld19zdGFydCk7DQo+ICsNCj4gKwlyYyA9IGFkZF9z
b2Z0X3Jlc2VydmVkKGVuZCArIDEsIG5ld19lbmQgLSBlbmQsIHNvZnQtPmZsYWdzKTsNCj4gKwlp
ZiAocmMpDQo+ICsJCWRldl93YXJuKCZjeGxyLT5kZXYsICJjYW5ub3QgYWRkIG5ldyBzb2Z0IHJl
c2VydmVkIHJlc291cmNlIGF0ICVwYSArIDFcbiIsDQo+ICsJCQkgJmVuZCk7DQo+ICsNCj4gK3Jl
bW92ZToNCj4gKwlyYyA9IHJlbW92ZV9yZXNvdXJjZShzb2Z0KTsNCj4gKwlpZiAocmMpDQo+ICsJ
CWRldl93YXJuKCZjeGxyLT5kZXYsICJjYW5ub3QgcmVtb3ZlIHNvZnQgcmVzZXJ2ZWQgcmVzb3Vy
Y2UgJXByXG4iLA0KPiArCQkJIHNvZnQpOw0KPiArfQ0KPiArDQo+ICsvKg0KPiArICogbm9ybWFs
aXplX3Jlc291cmNlDQo+ICsgKg0KPiArICogVGhlIHdhbGtfaW9tZW1fcmVzX2Rlc2MoKSByZXR1
cm5zIGEgY29weSBvZiBhIHJlc291cmNlLCBub3QgYSByZWZlcmVuY2UNCj4gKyAqIHRvIHRoZSBh
Y3R1YWwgcmVzb3VyY2UgaW4gdGhlIGlvbWVtX3Jlc291cmNlIHRyZWUuIEFzIGEgcmVzdWx0LA0K
PiArICogX19yZWxlYXNlX3Jlc291cmNlKCkgd2hpY2ggcmVsaWVzIG9uIHBvaW50ZXIgZXF1YWxp
dHkgd2lsbCBmYWlsLg0KPiArICoNCj4gKyAqIFRoaXMgaGVscGVyIHdhbGtzIHRoZSBjaGlsZHJl
biBvZiB0aGUgcmVzb3VyY2UncyBwYXJlbnQgdG8gZmluZCBhbmQNCj4gKyAqIHJldHVybiB0aGUg
b3JpZ2luYWwgcmVzb3VyY2UgcG9pbnRlciB0aGF0IG1hdGNoZXMgdGhlIGdpdmVuIHJlc291cmNl
J3MNCj4gKyAqIHN0YXJ0IGFuZCBlbmQgYWRkcmVzc2VzLg0KPiArICoNCj4gKyAqIFJldHVybjog
UG9pbnRlciB0byB0aGUgbWF0Y2hpbmcgb3JpZ2luYWwgcmVzb3VyY2UgaW4gaW9tZW1fcmVzb3Vy
Y2UsIG9yDQo+ICsgKiAgICAgICAgIE5VTEwgaWYgbm90IGZvdW5kIG9yIGludmFsaWQgaW5wdXQu
DQo+ICsgKi8NCj4gK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgKm5vcm1hbGl6ZV9yZXNvdXJjZShz
dHJ1Y3QgcmVzb3VyY2UgKnJlcykNCj4gK3sNCj4gKwlpZiAoIXJlcyB8fCAhcmVzLT5wYXJlbnQp
DQo+ICsJCXJldHVybiBOVUxMOw0KPiArDQo+ICsJZm9yIChzdHJ1Y3QgcmVzb3VyY2UgKnJlc19p
dGVyID0gcmVzLT5wYXJlbnQtPmNoaWxkOw0KPiArCSAgICAgcmVzX2l0ZXIgIT0gTlVMTDsgcmVz
X2l0ZXIgPSByZXNfaXRlci0+c2libGluZykgew0KPiArCQlpZiAoKHJlc19pdGVyLT5zdGFydCA9
PSByZXMtPnN0YXJ0KSAmJg0KPiArCQkgICAgKHJlc19pdGVyLT5lbmQgPT0gcmVzLT5lbmQpKQ0K
PiArCQkJcmV0dXJuIHJlc19pdGVyOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBOVUxMOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgaW50IF9fY3hsX3JlZ2lvbl9zb2Z0cmVzZXJ2X3VwZGF0ZShzdHJ1
Y3QgcmVzb3VyY2UgKnNvZnQsDQo+ICsJCQkJCSAgdm9pZCAqX2N4bHIpDQo+ICt7DQo+ICsJc3Ry
dWN0IGN4bF9yZWdpb24gKmN4bHIgPSBfY3hscjsNCj4gKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlcyA9
IGN4bHItPnBhcmFtcy5yZXM7DQo+ICsNCj4gKwkvKiBTa2lwIG5vbi1pbnRlcnNlY3Rpbmcgc29m
dC1yZXNlcnZlZCByZWdpb25zICovDQo+ICsJaWYgKHNvZnQtPmVuZCA8IHJlcy0+c3RhcnQgfHwg
c29mdC0+c3RhcnQgPiByZXMtPmVuZCkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlzb2Z0ID0g
bm9ybWFsaXplX3Jlc291cmNlKHNvZnQpOw0KPiArCWlmICghc29mdCkNCj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ICsNCj4gKwlyZW1vdmVfc29mdF9yZXNlcnZlZChjeGxyLCBzb2Z0LCByZXMtPnN0
YXJ0LCByZXMtPmVuZCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAraW50IGN4
bF9yZWdpb25fc29mdHJlc2Vydl91cGRhdGUodm9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSBOVUxMOw0KPiArDQo+ICsJd2hpbGUgKChkZXYgPSBidXNfZmluZF9uZXh0X2Rldmlj
ZSgmY3hsX2J1c190eXBlLCBkZXYpKSkgew0KPiArCQlzdHJ1Y3QgZGV2aWNlICpwdXRfZGV2IF9f
ZnJlZShwdXRfZGV2aWNlKSA9IGRldjsNCj4gKwkJc3RydWN0IGN4bF9yZWdpb24gKmN4bHI7DQo+
ICsNCj4gKwkJaWYgKCFpc19jeGxfcmVnaW9uKGRldikpDQo+ICsJCQljb250aW51ZTsNCj4gKw0K
PiArCQljeGxyID0gdG9fY3hsX3JlZ2lvbihkZXYpOw0KPiArDQo+ICsJCXdhbGtfaW9tZW1fcmVz
X2Rlc2MoSU9SRVNfREVTQ19TT0ZUX1JFU0VSVkVELA0KPiArCQkJCSAgICBJT1JFU09VUkNFX01F
TSwgMCwgLTEsIGN4bHIsDQo+ICsJCQkJICAgIF9fY3hsX3JlZ2lvbl9zb2Z0cmVzZXJ2X3VwZGF0
ZSk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX05T
X0dQTChjeGxfcmVnaW9uX3NvZnRyZXNlcnZfdXBkYXRlLCAiQ1hMIik7DQo+ICsNCj4gICB1NjQg
Y3hsX3BvcnRfZ2V0X3NwYV9jYWNoZV9hbGlhcyhzdHJ1Y3QgY3hsX3BvcnQgKmVuZHBvaW50LCB1
NjQgc3BhKQ0KPiAgIHsNCj4gICAJc3RydWN0IGN4bF9yZWdpb25fcmVmICppdGVyOw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jeGwvY3hsLmggYi9kcml2ZXJzL2N4bC9jeGwuaA0KPiBpbmRleCAx
YmE3ZDM5YzI5OTEuLmZjMzljNGIyNDc0NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY3hs
LmgNCj4gKysrIGIvZHJpdmVycy9jeGwvY3hsLmgNCj4gQEAgLTg1OSw2ICs4NTksNyBAQCBzdHJ1
Y3QgY3hsX3BtZW1fcmVnaW9uICp0b19jeGxfcG1lbV9yZWdpb24oc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gICBpbnQgY3hsX2FkZF90b19yZWdpb24oc3RydWN0IGN4bF9wb3J0ICpyb290LA0KPiAg
IAkJICAgICAgc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCk7DQo+ICAgc3RydWN0
IGN4bF9kYXhfcmVnaW9uICp0b19jeGxfZGF4X3JlZ2lvbihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0K
PiAraW50IGN4bF9yZWdpb25fc29mdHJlc2Vydl91cGRhdGUodm9pZCk7DQo+ICAgdTY0IGN4bF9w
b3J0X2dldF9zcGFfY2FjaGVfYWxpYXMoc3RydWN0IGN4bF9wb3J0ICplbmRwb2ludCwgdTY0IHNw
YSk7DQo+ICAgI2Vsc2UNCj4gICBzdGF0aWMgaW5saW5lIGJvb2wgaXNfY3hsX3BtZW1fcmVnaW9u
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gQEAgLTg3OCw2ICs4NzksMTAgQEAgc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgY3hsX2RheF9yZWdpb24gKnRvX2N4bF9kYXhfcmVnaW9uKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gICB7DQo+ICAgCXJldHVybiBOVUxMOw0KPiAgIH0NCj4gK3N0YXRpYyBpbmxpbmUg
aW50IGN4bF9yZWdpb25fc29mdHJlc2Vydl91cGRhdGUodm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gICBzdGF0aWMgaW5saW5lIHU2NCBjeGxfcG9ydF9nZXRfc3BhX2NhY2hlX2Fs
aWFzKHN0cnVjdCBjeGxfcG9ydCAqZW5kcG9pbnQsDQo+ICAgCQkJCQkgICAgICAgdTY0IHNwYSkN
Cj4gICB7

