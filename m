Return-Path: <linux-fsdevel+bounces-56717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA2B1ACFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 06:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7DA17EF7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079B1FBEB9;
	Tue,  5 Aug 2025 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YFXTI9OM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC451FAC37;
	Tue,  5 Aug 2025 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754366405; cv=fail; b=nrGlN3JCmyBWzKJqBKH3QNX3Otd4WjTqZsLLiz9jzbh7gLdVxF7qaATbwQdyTqVKBhwZ5ZW7lnfO6IwXTlCAlCaBme3FaUkY/W/sU3ffwKqhW5F8SuqUeWck7FpJcIa1jRuqeBGSezKIjBL18wxand3IjzaxKIdEE0jltXeteWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754366405; c=relaxed/simple;
	bh=DwuNn1DqhzSZZiYG53PxJCOrAWKAQ1pTAXwEOgCXgXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crBvhrwPkBr4OTWdIYemQ5xxCE3/Tb4ptfMhcnMFTpNSNS0sbwIqwdyKJZmE+WdO/ud3oYEZQnfPCPcJFksbi+IvHzw5HoKkIOjmwvVc31eQ2DjbudIxoJ/RawEyWzUo3760ytSDSv6LYZVGxJoy2QBGZp4QHjbr/QzG/Un87sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YFXTI9OM; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1754366403; x=1785902403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DwuNn1DqhzSZZiYG53PxJCOrAWKAQ1pTAXwEOgCXgXY=;
  b=YFXTI9OMSIaWtNufuze3lOcrnNrWGEt/pJZA0khciLMFvZAjcXqoWJZV
   xqtZNzjhNp+U0KWTEzDrnvg4sIHwMuK6CyI6iQ/1vXlOJC0Ep85zDoS3C
   7JAgELEXP4lnw4+Yfo8TZu0vaqVS2b52Bb8InM+u4wTvM44cFGqPK3dUL
   zCWdYMlOTR7L8snsoNODKgvXDJIlsTPHfbjvrcdQoxdN95rzs/Fuf/nCX
   SrAf9vQDaris1lAauiMLm654kD0YzlNIMtGGlP8leKZcgo6Ccb/Zo6qfn
   19ijg8xkhe78nc+vbQziDNXfV87URKUbmhKOFNcM/cguUDRxFRfYD3uKV
   A==;
X-CSE-ConnectionGUID: Jfj+OXeWRe6ra0lLeTBxzw==
X-CSE-MsgGUID: Nh8A64xaS0SDVkNkkZMBHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="163839253"
X-IronPort-AV: E=Sophos;i="6.17,265,1747666800"; 
   d="scan'208";a="163839253"
Received: from mail-japanwestazon11011034.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.34])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 12:58:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYelIgakoyY4nR+aPjw+vSKGV/bZU1+lF+duc8AABIaCnFeKnAU4NFozAbhVJIcWDUfHaqXJjdtB+nhCALJD3XUW4pw3bDCuqBl8bRTBZDWg+xoaCfawemsWDFJKYx8lvtqQu8kYdyaxBfe3YXrzu0ORt1z8aGot3hOu/1sOfpwVCuuc4RbRi87oB439dyjuYz794JvqxUcZ2RusjBT2vdPWiWSKHTKel3uyyj48SQLPZDEuPDCzfiDjrsEf4JwnKK72KrVaqwW/+jKo/C5eMQJYPdZlt+d4aHzxs+SqVj0V377hm0UIFlg/22fDYhlgSGjM6cZ+zkFRrh68o8jX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwuNn1DqhzSZZiYG53PxJCOrAWKAQ1pTAXwEOgCXgXY=;
 b=gcRTTGg/T/r3/uHFpwVc6bF2jfpDYwHXjJTDCSw8pngTO1Wz2Nf6i9CfKy2xrnMT4riSPhOleGoGmsMKgjAj75mJHfmxK3G/eRj9/NlpUKkdPoSH40SAs6brjj3uUrB19Gvmx6Fw+kMzeaFb4MiAyJbMum25nUpzbURmf1s1FWy3MLm7vOEuuakDOhXT2cfMRkNBZrbsNtnWna3pqCh/ZpCZRkmbI3Fp+2YlVxzD5klnSnHS2rSkudMgqBBIFbtVycf9pQ34VkfE6yxmwjYwDjnhsC32mcD61v/0ru97wNktr8UP3RBPLfmJqgKapY23LbEz7jGocdG0rnKagzU9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by OS3PR01MB6134.jpnprd01.prod.outlook.com (2603:1096:604:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 03:58:42 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 03:58:41 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Peter Zijlstra
	<peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
Thread-Topic: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate
 with cxl_mem probe completion
Thread-Index: AQHb9bLv4zMtn0217k6cvjwtOUPnhrQ/XBMAgACSGQCAE6DhgA==
Date: Tue, 5 Aug 2025 03:58:41 +0000
Message-ID: <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
In-Reply-To: <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|OS3PR01MB6134:EE_
x-ms-office365-filtering-correlation-id: cf7f03cc-12a6-4ee1-c8e0-08ddd3d45db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|1580799027|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qmo0S2R6L1JRT21UZy9qTW45NEN3ZnVOaFZWQTNjaml0eVRhQmxISU5wa0Rs?=
 =?utf-8?B?ZGZNSE5CUG81Ykk2YUExcUtGN2NQWjNPRkxibUJhajlWSUFubytrbVNqZjFT?=
 =?utf-8?B?M1pRMDNSdlh0SVBUSzJDNElnZXZ3TUp4TTBKVTZFYk14K2hnSkU1T01zNGNF?=
 =?utf-8?B?V094ZHVuS1FuZWFkMTI3VktSbHE5KzhtWnltMm96MTE1amNBNGxjWEViNnIw?=
 =?utf-8?B?OHZ1bVZadGhQeDlCOE1UeDNGRk1BNDVmZEYrQkZjZnpTNlNwMTN0Y3ZZUzQ0?=
 =?utf-8?B?ZTRYc3dLc1hmblhOSStVZEtWT2l4eTIrMW83aU5IUHcvZXdla05OYXJJTVRr?=
 =?utf-8?B?OVhaNVRPb1FLbXo5b3VKNU1ibmE3dncyMlN2SjVNeFFrT3FCdWtHSW5oMlZ3?=
 =?utf-8?B?RGxDc252dXc4T081ZXNJdU9TMGpNdkVLTHdyQWpQU00xeWg0UysyNEVOVCtk?=
 =?utf-8?B?VkRMUDZEWHNlMm9ZREpCcVpTN2JGUnFnVXdHRFFYYTRYKzN2cExZNmg3aUl4?=
 =?utf-8?B?VG5GVFpHdjdHMm5jMXh1S2J0L2Vhb2g2eG15SEg5REQxQzZHQVZpcWgySGJ0?=
 =?utf-8?B?cjB3UTNHR3JJL0ZuVG9XMlhSNzFBRE1NUDJkTWgxeEwvTWxQTHJSQjhiMi9M?=
 =?utf-8?B?VDlmaFZScXp3ekc4SXY4NEdqRmVLTUd6cElaV3B3ZWQwUmhZOE8rQ0dMUzh1?=
 =?utf-8?B?RmVUR1NXaHp1ZytCbGJLM0hVdWQ5WWhBcEl0Y3orSjhGaWs3SW05NDY1V0ZC?=
 =?utf-8?B?RCtzNUNlamtpOFV4a2dQME9aSkgrR2NqbDVSeTNlQzg5dXhTTlFCZVB6Z3kr?=
 =?utf-8?B?YmxZNkxhSStnc096aENJTitrTFBVc2M5NFRxRE40alF6c1h4WG0vV1VRbHJF?=
 =?utf-8?B?YTVHeUxNNW9CamVhZDNXTUV3UkduUlVzOUI2YzJXM1NOY3BsSVJGcGl2Y0tO?=
 =?utf-8?B?SFpUYm8rMk9Jb3ZkSzdWM3Rja0xZRWUxcFdCWmhRVTJBV1l1Nm44VXBRYVU4?=
 =?utf-8?B?Ukl3M3E0TnJEUmZVam5GUmlmNUlKek10OGtxVGl2bU03YXhUcFRvK3JkdVkv?=
 =?utf-8?B?RGVxZEpPWEUyZFNKSWIyRDliUm50MkJCN1J2MUQ3d3MrdXFaMUE3UllDN2pn?=
 =?utf-8?B?VVNFOWFJK0lVOVFwcTNFNU5UR1pRcndjM0lNazBZUmdQVGJFelZNOTcyeXAx?=
 =?utf-8?B?TFNaMVZmaEd2RjRNbHVxWFJrWCtDK29mRGUwQnZMSU51Y2RhWGFEdXNnWU9u?=
 =?utf-8?B?WTNtRGJZaldiK0JMaDFaRTRidGhRdHV2S3BiTnI3MTdzNm5xM05FRldCcWIx?=
 =?utf-8?B?ZkdpZ3d4Tzk3NWZ1VXZxTTFBK2REZDREQWI2RzFpR0tCb1lxdVdkZ0RibXVs?=
 =?utf-8?B?WnJuVWlOM1VSMkluRjdPSkl4b2pPUTM1NDBnRFUxRUFWNm9aenNMV0FWcmhw?=
 =?utf-8?B?UTdKZkMxSE9KVlV1OWpGNCtkd2FZbWpRSTFYK0dGUTBtcUNtakN4QkIwU2s5?=
 =?utf-8?B?SUM2ckRDUmZJdVBKYVlSeVphLzArbndCMTlqa3ZuMy95YmtlK0FLUHNuU0ZT?=
 =?utf-8?B?L0RiUitvRm5rRDJnWFNNTlBkc09IVE5ycmVlek54aEQ4QnNRZUgyUjBzMk83?=
 =?utf-8?B?RG1pOGZ5VHliM0ZROFJweEEzZkQ1dE5USTBxZHJ5VXBaZ2ZoWW9BUUh6YmRR?=
 =?utf-8?B?VWllM25yNjEwU2R1b2NyelE5cGZWMWNHanVqSXA5Z2tRWVN0eGtVem02MXlu?=
 =?utf-8?B?WHhndndDU0Rqbmhxcmg4QjlVQXo1d0c1LzFWUlR3d1ExekJZbGZHQ3RNeWR2?=
 =?utf-8?B?MThEK0ltVWxPWmhzUE1DcjY1M0NQbWlvT1djNlpvVzFmcGlNQndJK3lTMk5G?=
 =?utf-8?B?UUdnY1JjT3RGdklXWU42RG03SFluZ0ZUT2NSS1VtWW03Z1U3Sk9lZGU1cGtY?=
 =?utf-8?B?eE85dVZVZFJGeWlySDNLQ3RjYU1OZHYrSk5LZk9tVHB3eGhlNmwvNXF1elVs?=
 =?utf-8?B?RXB3RmRTaGhxS0t3Q0ZIdUJUcC90VG9VbGJJSzFnbjJIdDF5cmZGd1ppd1Bq?=
 =?utf-8?Q?w6t7Yn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmdNWFBCaTZYMVV4OUVDeVhONkxPZXZzTG9IMlBNZU5VLzhaYVUrTnRsc0lm?=
 =?utf-8?B?WFMyYlMvZ1hOSXp3b2tka0xBK1BqL1JLOUdudy8yZDFnYUxkZlpVdHh4QkRL?=
 =?utf-8?B?TWttQlVEclNaUFhTUWdIMWlsK21LbUsyclZOUFcvTnJHcnJyWlFoaXRIblh5?=
 =?utf-8?B?WnprTHNYem5TeFhEaHMwWXlBd0Yvc0ZBd0VZSDZreFJaWnh0VGZqcXJ4S3gr?=
 =?utf-8?B?aXRvb1U2SkRrNGpOZzRmRVIvTS9pWTJTUVRYemJTSmZKeTBrLzVhMm9vQUlm?=
 =?utf-8?B?dDJvVEY4czFvcTFWK3V1R3ozL3JWYUhyRE1xSG83SVVPZHRuZVlFZ2EwYzky?=
 =?utf-8?B?QWR6RFlMb0taRFBDRXNmUHhRWDYvQXNWNk9Ca01od2gvZnZGbWx4a1lSYjlj?=
 =?utf-8?B?U09oSWtDUXpldTI5RUl0Q3BLV0JpWjZ5Z3lNZmNuTmJ3N2NzZWRXeTc3azhP?=
 =?utf-8?B?bmphbEgrRVlMc3ZVeUorUGROQ0MzeTcvVGlkYmxVRlhyWnNYUDh4MGEvcFhy?=
 =?utf-8?B?dE93N2g0Um9sNm8yVTdtck8wTGpsVGZ0dGIrd3l6WUxXL2JJa0FsdzlyVmhl?=
 =?utf-8?B?QUZnY0hKMHg4YkJKM1hkUTlablYxU3AzOTNQK1NwNGxoUnRURndNRXI5anp5?=
 =?utf-8?B?aENpNEtCUDloN0lLVkJyTERyRnFhSm1PbUdiZjVhTmhuQjdLaUw4cHk3OTFD?=
 =?utf-8?B?V3cyMFozZW9lY2FIRHMwWVkzS2lhSGdyQkFBdXVmUmpMbmJGeUVTVk8wcWcz?=
 =?utf-8?B?RHhxV0RpbUFRTHVIVTAwb1B5b2N5alR0N0pqUGZYZXp4ZGJVRERaYWd6My9U?=
 =?utf-8?B?WE1nVVBINklZYS9CT1lodDcwcWRWc01KMVBjeXRzMm5FRjB3amhqVW5BTi8y?=
 =?utf-8?B?RUVEZEdDbzhSVWc1Q3pBUFJxamU1VHdia1dUQTU3NVNsZGdGNmx1Z1NPWHRQ?=
 =?utf-8?B?dEt0NHQ3SzNGZGFEeUEzRzNINy9GSzFnQlM5cHVIaHRkNWJDNnVGWEhKRHV0?=
 =?utf-8?B?SldHY0EyS3hNVTZhMkl5cTJIdUhwQlAwV2d5NTFVQXE3WVJjWkZDekkxc0p3?=
 =?utf-8?B?UFZwcnl0MEJGM2kzeS9ZT2RQY3MxYkxvcVRzdGFjL1hMSmdRbHZSNXJoZkRQ?=
 =?utf-8?B?VzZlRkRvVzRoZmlTd0dZUmEwRDNES2J4Mmx3V3NGRDdrYWRQMXg3TGRldFE3?=
 =?utf-8?B?clhSdmhLbm1TS2hVdVBvODhrbXlvUWxsWDZrV1JYcmx2bGJLMHEvVElBTWRz?=
 =?utf-8?B?ampzbnp0dEhUM1ZZREZsZXBkSzFxd0pPZXNBRzdtZjBZWk9RT2ltU1FHOFY1?=
 =?utf-8?B?T3N1MktvTjR2RGpwYkl4S21DejFpWllxdTlJaHM5Y29qQ1k0czJxbGw1V3hS?=
 =?utf-8?B?UWs4L1V3ZEhIN002YVZWQ0lWWUJ6Y1B5a1IyYllYN2FPNUM1cThoWkRZak5F?=
 =?utf-8?B?MkhlRy83MTVxb29SblFsN2xnTHVyOXpKUWIra2pDQjU3VllQUFhETmdidnpC?=
 =?utf-8?B?Kzl2c01LbzdVQXFWSE9QQVJWSGtkLzFXV0NreFR5MUhBeUVzT1NEK3R3SDFP?=
 =?utf-8?B?RGp6dVZMR3VSVjF0TjR3cUVZZGZLN2NWb0preUpuQXJhaU10RHhaa2UwSjM3?=
 =?utf-8?B?UmUrWU9BdDdxYWFzZlR5OG1IS1dvcnhHZFlhVW5LaytEVmlFaWZNa1JQZVRV?=
 =?utf-8?B?eHR5N2VvVnFKMlNKdCt1bTFXMTBiN2hrVElLaksyZTR5K2ltUDF5MlpFZmlY?=
 =?utf-8?B?dUJLV2hBcmwwcnlLdW9SQ0swWnpOK1poRUN4dGpxUW5GNTIvRG8reS9kR1Rz?=
 =?utf-8?B?TWhDT1NTRGNWRlFYRktkbVF4WEcya2VlcmZ4aEN1WHQ4QnRHSGVvbTJvZ1lk?=
 =?utf-8?B?RXE1VFpscHFLWU5zbkp6YWp5cFNIWDdleEVOVVkvT1lnK2FaK0VWejc2M3BH?=
 =?utf-8?B?cHE1OW4yN3Z1aHhMS2FNaUhmaUNzR0Y2cENXWUFyZmlZeUZXVERCY254U1o5?=
 =?utf-8?B?NE5YQ1NDTXB1TEl3RmQyeWFPN2VlSXppY3RpQ1ZPREdlMndBRHFGZlpyMXBm?=
 =?utf-8?B?RzJLV1RteUVFVjZmRVIvbkhiTXlnUno3UDJBSTdwaEJKM1V3Ry9QUzhJSk1X?=
 =?utf-8?B?QkhzYUxRTWxCSk1WaGFzRlhSbEtKb2gxbmhvMk5ZOFVLMjZNV2ZaT0I5andB?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7119D78DA3CE1B48B7D8EC1A8CC36972@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eCErjkVNvdqg2cfhF9sqyEi1H2Pz68jXb/BCaEvtTGX0xbMLV3puGOXZNKOKBfgVGf5anWLl2b2lmU8exVQTq7nDSjNELemBQXZxVfnqhkqs+ZTCv3VggFWp7tNDQ1WivHqM/RWCs16LxfzOhHziIoHHU9Duxi8XfBFli2RN47CWPKsRWQKIcIV49Ky8BJl0U3VIN2vTHWCYnpMtJmAQ3thqleyGsUcblqlRj9v2zmKWWM5sTuVboIRmoR1Z7WpnE2kP/icAbtuC71OLeTrk9rub607GktcW4iK+xJifvkgh9jbPGSh9YaV6wBxyoE7xe9U3dEaXljYycrr7Ud2v9jm5cS7GtNg//FDYINGWhZS4j43ZQtdFbeK32BSOjmqqGsz7NZFoh5dyLeR9ZQ6RyTFZsgyOFzP9xaPgH0cEdKt0MUel4CoYDyalvbQsKLk/+s43AeTKfvPQ34UhYrQu0L3/0xF1Pce4I02DyXa+EmjUt14NGwZGrOp1+Q8mZZfxAMJSI6ciY3tMHU+awul7+6hvCfayUY+eOILjWADazOuHbc+aGDq0EkYol7gA7/1Oc3GFgyxBh6Zn4yoGlSj9TH0nobzIuZNUPOL8tIb0FmoCsjsgcehq4+cYMnSBP4Jc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7f03cc-12a6-4ee1-c8e0-08ddd3d45db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 03:58:41.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHjU0C3EmPfYzeoxo6k5EGjPfqoORSw5duT4gBUGdElFlmqNAvqUCA6WXDJOsm0rEGfDKpGz/zTN7VI4+ai65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6134

SGkgRGFuIGFuZCBTbWl0YSwNCg0KDQpPbiAyNC8wNy8yMDI1IDAwOjEzLCBkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20gd3JvdGU6DQo+IGRhbi5qLndpbGxpYW1zQCB3cm90ZToNCj4gWy4uXQ0KPj4g
SWYgdGhlIGdvYWwgaXM6ICJJIHdhbnQgdG8gZ2l2ZSBkZXZpY2UtZGF4IGEgcG9pbnQgYXQgd2hp
Y2ggaXQgY2FuIG1ha2UNCj4+IGEgZ28gLyBuby1nbyBkZWNpc2lvbiBhYm91dCB3aGV0aGVyIHRo
ZSBDWEwgc3Vic3lzdGVtIGhhcyBwcm9wZXJseQ0KPj4gYXNzZW1ibGVkIGFsbCBDWEwgcmVnaW9u
cyBpbXBsaWVkIGJ5IFNvZnQgUmVzZXJ2ZWQgaW5zdGVyc2VjdGluZyB3aXRoDQo+PiBDWEwgV2lu
ZG93cy4iIFRoZW4gdGhhdCBpcyBzb21ldGhpbmcgbGlrZSB0aGUgYmVsb3csIG9ubHkgbGlnaHRs
eSB0ZXN0ZWQNCj4+IGFuZCBsaWtlbHkgcmVncmVzc2VzIHRoZSBub24tQ1hMIGNhc2UuDQo+Pg0K
Pj4gLS0gODwgLS0NCj4+ICBGcm9tIDQ4YjI1NDYxZWNhMDUwNTA0Y2Y1Njc4YWZkNzgzNzMwN2Iy
ZGQxNGYgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRh
bi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4+IERhdGU6IFR1ZSwgMjIgSnVsIDIwMjUgMTY6MTE6
MDggLTA3MDANCj4+IFN1YmplY3Q6IFtSRkMgUEFUQ0hdIGRheC9jeGw6IERlZmVyIFNvZnQgUmVz
ZXJ2ZWQgcmVnaXN0cmF0aW9uDQo+IA0KPiBMaWtlbHkgbmVlZHMgdGhpcyBpbmNyZW1lbnRhbCBj
aGFuZ2UgdG8gcHJldmVudCBERVZfREFYX0hNRU0gZnJvbSBiZWluZw0KPiBidWlsdC1pbiB3aGVu
IENYTCBpcyBub3QuIFRoaXMgc3RpbGwgbGVhdmVzIHRoZSBhd2t3YXJkIHNjZW5hcmlvIG9mIENY
TA0KPiBlbmFibGVkLCBERVZfREFYX0NYTCBkaXNhYmxlZCwgYW5kIERFVl9EQVhfSE1FTSBidWls
dC1pbi4gSSBiZWxpZXZlIHRoYXQNCj4gc2FmZWx5IGZhaWxzIGluIGRldmRheCBvbmx5IC8gZmFs
bGJhY2sgbW9kZSwgYnV0IHNvbWV0aGluZyB0bw0KPiBpbnZlc3RpZ2F0ZSB3aGVuIHJlc3Bpbm5p
bmcgb24gdG9wIG9mIHRoaXMuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgUkZDOyBJIGZpbmQg
eW91ciBwcm9wb3NhbCByZW1hcmthYmx5IGNvbXBlbGxpbmcsIGFzIGl0IGFkZXB0bHkgYWRkcmVz
c2VzIHRoZSBpc3N1ZXMgSSBhbSBjdXJyZW50bHkgZmFjaW5nLg0KDQoNClRvIGJlZ2luIHdpdGgs
IEkgc3RpbGwgZW5jb3VudGVyZWQgc2V2ZXJhbCBpc3N1ZXMgd2l0aCB5b3VyIHBhdGNoIChjb25z
aWRlcmluZyB0aGUgcGF0Y2ggYXQgdGhlIFJGQyBzdGFnZSwgSSB0aGluayBpdCBpcyBhbHJlYWR5
IHF1aXRlIGNvbW1lbmRhYmxlKToNCg0KMS4gU29tZSByZXNvdXJjZXMgZGVzY3JpYmVkIGJ5IFNS
QVQgYXJlIHdyb25nbHkgaWRlbnRpZmllZCBhcyBTeXN0ZW0gUkFNIChrbWVtKSwgc3VjaCBhcyB0
aGUgZm9sbG93aW5nOiAyMDAwMDAwMDAtNWJmZmZmZmYuDQogICAgDQogICAgYGBgDQogICAgMjAw
MDAwMDAwLTViZmZmZmZmIDogZGF4Ni4wDQogICAgICAyMDAwMDAwMDAtNWJmZmZmZmYgOiBTeXN0
ZW0gUkFNIChrbWVtKQ0KICAgIDVjMDAwMTEyOC01YzAwMDExYjcgOiBwb3J0MQ0KICAgIDVkMDAw
MDAwMC02NGZmZmZmZiA6IENYTCBXaW5kb3cgMA0KICAgICAgNWQwMDAwMDAwLTY0ZmZmZmZmIDog
cmVnaW9uMA0KICAgICAgICA1ZDAwMDAwMDAtNjRmZmZmZmYgOiBkYXgwLjANCiAgICAgICAgICA1
ZDAwMDAwMDAtNjRmZmZmZmYgOiBTeXN0ZW0gUkFNIChrbWVtKQ0KICAgIDY4MDAwMDAwMC1lN2Zm
ZmZmZiA6IFBDSSBCdXMgMDAwMDowMA0KDQogICAgW3Jvb3RAcmRtYS1zZXJ2ZXIgfl0jIGRtZXNn
IHwgZ3JlcCAtaSAtZSBzb2Z0IC1lIGhvdHBsdWcNCiAgICBbICAgIDAuMDAwMDAwXSBDb21tYW5k
IGxpbmU6IEJPT1RfSU1BR0U9KGhkMCxtc2RvczEpL2Jvb3Qvdm1saW51ei02LjE2LjAtcmM0LWxp
emhpamlhbi1EYW4rIHJvb3Q9VVVJRD0zODY3NjlhMy1jZmE1LTQ3YzgtODc5Ny1kNWVjNThjOWNi
NmMgcm8gZWFybHlwcmludGs9dHR5UzAgbm9fdGltZXJfY2hlY2sgbmV0LmlmbmFtZXM9MCBjb25z
b2xlPXR0eTEgY29uc29sZT10dHlTMCwxMTUyMDBuOCBzb2Z0bG9ja3VwX3BhbmljPTEgcHJpbnRr
LmRldmttc2c9b24gb29wcz1wYW5pYyBzeXNycV9hbHdheXNfZW5hYmxlZCBwYW5pY19vbl93YXJu
IGlnbm9yZV9sb2dsZXZlbCBrYXNhbi5mYXVsdD1wYW5pYw0KICAgIFsgICAgMC4wMDAwMDBdIEJJ
T1MtZTgyMDogW21lbSAweDAwMDAwMDAxODAwMDAwMDAtMHgwMDAwMDAwMWZmZmZmZmZmXSBzb2Z0
IHJlc2VydmVkDQogICAgWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDVk
MDAwMDAwMC0weDAwMDAwMDA2NGZmZmZmZl0gc29mdCByZXNlcnZlZA0KICAgIFsgICAgMC4wNzIx
MTRdIEFDUEk6IFNSQVQ6IE5vZGUgMyBQWE0gMyBbbWVtIDB4MjAwMDAwMDAwLTB4NWJmZmZmZmZd
IGhvdHBsdWcNCiAgICBgYGANCg0KMi4gVHJpZ2dlcnMgZGV2X3dhcm4gYW5kIGRldl9lcnI6DQog
ICAgDQogICAgYGBgDQogICAgW3Jvb3RAcmRtYS1zZXJ2ZXIgfl0jIGpvdXJuYWxjdGwgLXAgZXJy
IC1wIHdhcm5pbmcgLS1kbWVzZw0KICAgIC4uLnNuaXAuLi4NCiAgICBKdWwgMjkgMTM6MTc6MzYg
cmRtYS1zZXJ2ZXIga2VybmVsOiBjeGwgcm9vdDA6IEV4dGVuZGVkIGxpbmVhciBjYWNoZSBjYWxj
dWxhdGlvbiBmYWlsZWQgcmM6LTINCiAgICBKdWwgMjkgMTM6MTc6MzYgcmRtYS1zZXJ2ZXIga2Vy
bmVsOiBobWVtIGhtZW0uMTogcHJvYmUgd2l0aCBkcml2ZXIgaG1lbSBmYWlsZWQgd2l0aCBlcnJv
ciAtMTINCiAgICBKdWwgMjkgMTM6MTc6MzYgcmRtYS1zZXJ2ZXIga2VybmVsOiBobWVtIGhtZW0u
MjogcHJvYmUgd2l0aCBkcml2ZXIgaG1lbSBmYWlsZWQgd2l0aCBlcnJvciAtMTINCiAgICBKdWwg
MjkgMTM6MTc6MzYgcmRtYS1zZXJ2ZXIga2VybmVsOiBrbWVtIGRheDMuMDogbWFwcGluZzA6IDB4
MTAwMDAwMDAwLTB4MTdmZmZmZmYgY291bGQgbm90IHJlc2VydmUgcmVnaW9uDQogICAgSnVsIDI5
IDEzOjE3OjM2IHJkbWEtc2VydmVyIGtlcm5lbDoga21lbSBkYXgzLjA6IHByb2JlIHdpdGggZHJp
dmVyIGttZW0gZmFpbGVkIHdpdGggZXJyb3IgLTE2DQogICAgYGBgDQoNCjMuIFdoZW4gQ1hMX1JF
R0lPTiBpcyBkaXNhYmxlZCwgdGhlcmUgaXMgYSBmYWlsdXJlIHRvIGZhbGxiYWNrIHRvIGRheF9o
bWVtLCBpbiB3aGljaCBjYXNlIG9ubHkgQ1hMIFdpbmRvdyBYIGlzIHZpc2libGUuDQogICAgDQog
ICAgT24gZmFpbHVyZToNCiAgICANCiAgICBgYGANCiAgICAxMDAwMDAwMDAtMjdmZmZmZmYgOiBT
eXN0ZW0gUkFNDQogICAgNWMwMDAxMTI4LTVjMDAwMTFiNyA6IHBvcnQxDQogICAgNWMwMDExMTI4
LTVjMDAxMTFiNyA6IHBvcnQyDQogICAgNWQwMDAwMDAwLTZjZmZmZmZmIDogQ1hMIFdpbmRvdyAw
DQogICAgNmQwMDAwMDAwLTdjZmZmZmZmIDogQ1hMIFdpbmRvdyAxDQogICAgNzAwMDAwMDAwMC03
MDAwMDBmZmZmIDogUENJIEJ1cyAwMDAwOjBjDQogICAgICA3MDAwMDAwMDAwLTcwMDAwMGZmZmYg
OiAwMDAwOjBjOjAwLjANCiAgICAgICAgNzAwMDAwMTA4MC03MDAwMDAxMGQ3IDogbWVtMQ0KICAg
IGBgYA0KDQogICAgT24gc3VjY2VzczoNCiAgICANCiAgICBgYGANCiAgICA1ZDAwMDAwMDAtN2Nm
ZmZmZmYgOiBkYXgwLjANCiAgICAgIDVkMDAwMDAwMC03Y2ZmZmZmZiA6IFN5c3RlbSBSQU0gKGtt
ZW0pDQogICAgICAgIDVkMDAwMDAwMC02Y2ZmZmZmZiA6IENYTCBXaW5kb3cgMA0KICAgICAgICA2
ZDAwMDAwMDAtN2NmZmZmZmYgOiBDWEwgV2luZG93IDENCiAgICBgYGANCg0KSW4gdGVybSBvZiBp
c3N1ZXMgMSBhbmQgMiwgdGhpcyBhcmlzZXMgYmVjYXVzZSBobWVtX3JlZ2lzdGVyX2RldmljZSgp
IGF0dGVtcHRzIHRvIHJlZ2lzdGVyIHJlc291cmNlcyBvZiBhbGwgIkhNRU0gZGV2aWNlcywiIHdo
ZXJlYXMgd2Ugb25seSBuZWVkIHRvIHJlZ2lzdGVyIHRoZSBJT1JFU19ERVNDX1NPRlRfUkVTRVJW
RUQgcmVzb3VyY2VzLiBJIGJlbGlldmUgcmVzb2x2aW5nIHRoZSBjdXJyZW50IFRPRE8gd2lsbCBh
ZGRyZXNzIHRoaXMuDQoNCmBgYA0KLSAgIHJjID0gcmVnaW9uX2ludGVyc2VjdHMocmVzLT5zdGFy
dCwgcmVzb3VyY2Vfc2l6ZShyZXMpLCBJT1JFU09VUkNFX01FTSwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgIElPUkVTX0RFU0NfU09GVF9SRVNFUlZFRCk7DQotICAgaWYgKHJjICE9IFJFR0lP
Tl9JTlRFUlNFQ1RTKQ0KLSAgICAgICByZXR1cm4gMDsNCisgICAvKiBUT0RPOiBpbnNlcnQgIlNv
ZnQgUmVzZXJ2ZWQiIGludG8gaW9tZW0gaGVyZSAqLw0KYGBgDQoNClJlZ2FyZGluZyBpc3N1ZSAz
ICh3aGljaCBleGlzdHMgaW4gdGhlIGN1cnJlbnQgc2l0dWF0aW9uKSwgdGhpcyBjb3VsZCBiZSBi
ZWNhdXNlIGl0IGNhbm5vdCBlbnN1cmUgdGhhdCBkYXhfaG1lbV9wcm9iZSgpIGV4ZWN1dGVzIHBy
aW9yIHRvIGN4bF9hY3BpX3Byb2JlKCkgd2hlbiBDWExfUkVHSU9OIGlzIGRpc2FibGVkLg0KDQpJ
IGFtIHBsZWFzZWQgdGhhdCB5b3UgaGF2ZSBwdXNoZWQgdGhlIHBhdGNoIHRvIHRoZSBjeGwvZm9y
LTYuMTgvY3hsLXByb2JlLW9yZGVyIGJyYW5jaCwgYW5kIEknbSBsb29raW5nIGZvcndhcmQgdG8g
aXRzIGludGVncmF0aW9uIGludG8gdGhlIHVwc3RyZWFtIGR1cmluZyB0aGUgdjYuMTggbWVyZ2Ug
d2luZG93Lg0KQmVzaWRlcyB0aGUgY3VycmVudCBUT0RPLCB5b3UgYWxzbyBtZW50aW9uZWQgdGhh
dCB0aGlzIFJGQyBQQVRDSCBtdXN0IGJlIGZ1cnRoZXIgc3ViZGl2aWRlZCBpbnRvIHNldmVyYWwg
cGF0Y2hlcywgc28gdGhlcmUgcmVtYWlucyBzaWduaWZpY2FudCB3b3JrIHRvIGJlIGRvbmUuDQpJ
ZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHlvdSB3b3VsZCBiZSBwZXJzb25hbGx5IGNv
bnRpbnVpbmcgdG8gcHVzaCBmb3J3YXJkIHRoaXMgcGF0Y2gsIHJpZ2h0Pw0KDQoNClNtaXRhLA0K
DQpEbyB5b3UgaGF2ZSBhbnkgYWRkaXRpb25hbCB0aG91Z2h0cyBvbiB0aGlzIHByb3Bvc2FsIGZy
b20geW91ciBzaWRlPw0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KDQo+IC0tIDg8IC0tDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9LY29uZmlnIGIvZHJpdmVycy9kYXgvS2NvbmZpZw0K
PiBpbmRleCBkNjU2ZTRjMGViODQuLjM2ODNiYjNmMjMxMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9kYXgvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2RheC9LY29uZmlnDQo+IEBAIC00OCw2ICs0
OCw4IEBAIGNvbmZpZyBERVZfREFYX0NYTA0KPiAgIAl0cmlzdGF0ZSAiQ1hMIERBWDogZGlyZWN0
IGFjY2VzcyB0byBDWEwgUkFNIHJlZ2lvbnMiDQo+ICAgCWRlcGVuZHMgb24gQ1hMX0JVUyAmJiBD
WExfUkVHSU9OICYmIERFVl9EQVgNCj4gICAJZGVmYXVsdCBDWExfUkVHSU9OICYmIERFVl9EQVgN
Cj4gKwlkZXBlbmRzIG9uIENYTF9BQ1BJID49IERFVl9EQVhfSE1FTQ0KPiArCWRlcGVuZHMgb24g
Q1hMX1BDSSA+PSBERVZfREFYX0hNRU0NCj4gICAJaGVscA0KPiAgIAkgIENYTCBSQU0gcmVnaW9u
cyBhcmUgZWl0aGVyIG1hcHBlZCBieSBwbGF0Zm9ybS1maXJtd2FyZQ0KPiAgIAkgIGFuZCBwdWJs
aXNoZWQgaW4gdGhlIGluaXRpYWwgc3lzdGVtLW1lbW9yeSBtYXAgYXMgIlN5c3RlbSBSQU0iLCBt
YXBwZWQNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jIGIvZHJpdmVycy9k
YXgvaG1lbS9obWVtLmMNCj4gaW5kZXggMDkxNjQ3OGUzODE3Li44YmNkMTA0MTExYTggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jDQo+ICsrKyBiL2RyaXZlcnMvZGF4L2ht
ZW0vaG1lbS5jDQo+IEBAIC0xMDMsNyArMTAzLDcgQEAgc3RhdGljIGludCBobWVtX3JlZ2lzdGVy
X2RldmljZShzdHJ1Y3QgZGV2aWNlICpob3N0LCBpbnQgdGFyZ2V0X25pZCwNCj4gICAJbG9uZyBp
ZDsNCj4gICAJaW50IHJjOw0KPiAgIA0KPiAtCWlmIChJU19FTkFCTEVEKENPTkZJR19DWExfUkVH
SU9OKSAmJg0KPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19ERVZfREFYX0NYTCkgJiYNCj4gICAJ
ICAgIHJlZ2lvbl9pbnRlcnNlY3RzKHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSwgSU9S
RVNPVVJDRV9NRU0sDQo+ICAgCQkJICAgICAgSU9SRVNfREVTQ19DWEwpICE9IFJFR0lPTl9ESVNK
T0lOVCkgew0KPiAgIAkJc3dpdGNoIChkYXhfY3hsX21vZGUpIHsNCj4gQEAgLTIwOSw3ICsyMDks
NyBAQCBzdGF0aWMgX19pbml0IGludCBkYXhfaG1lbV9pbml0KHZvaWQpDQo+ICAgCSAqIENYTCB0
b3BvbG9neSBkaXNjb3ZlcnkgYXQgbGVhc3Qgb25jZSBiZWZvcmUgc2Nhbm5pbmcgdGhlDQo+ICAg
CSAqIGlvbWVtIHJlc291cmNlIHRyZWUgZm9yIElPUkVTX0RFU0NfQ1hMIHJlc291cmNlcy4NCj4g
ICAJICovDQo+IC0JaWYgKElTX0VOQUJMRUQoQ09ORklHX0NYTF9SRUdJT04pKSB7DQo+ICsJaWYg
KElTX0VOQUJMRUQoQ09ORklHX0RFVl9EQVhfQ1hMKSkgew0KPiAgIAkJcmVxdWVzdF9tb2R1bGUo
ImN4bF9hY3BpIik7DQo+ICAgCQlyZXF1ZXN0X21vZHVsZSgiY3hsX3BjaSIpOw0KPiAgIAl9DQo=

