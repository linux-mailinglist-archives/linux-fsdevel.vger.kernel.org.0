Return-Path: <linux-fsdevel+bounces-77435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA8uJ9n2lGlzJQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:16:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09600151C30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5863023DF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47F2798E8;
	Tue, 17 Feb 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gaFcl8fg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68E254841;
	Tue, 17 Feb 2026 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370189; cv=fail; b=ea1F7jmnRGUSHrE5ik1C6c6bjW+kEL9wD0IqyBlXsjs29V8x0Ot6nYreV6cxKpADwnpEleIeQCsX6Z9WHWqlScLFs0/Xdg+3DoUtyfLHSY5S6UBTlGj8mNyYhNH3DYlunuVzh2boZ6YD3B6nh9jp4UTUy31xknImziz1SAuO9YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370189; c=relaxed/simple;
	bh=p/FNDCuaE6MVM/5pbtJV1b7hnrpAwQXWlFxxcZ2T5Vw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cbE6GrrV+Vv6ZpFsDx7HGdTt1Xzdc5k6kkplWAJ2/f4boJqHcn2Q1ExAYXxWzj8LejzMlzoTYPnWZfUQgO8dFwEL9a0i5H7pJcC5KxaIwKbJJo6ojcpZBh6XLNXl833X6ea3xiwXv9EdLmaq2kMqu+BgTB7QglvQX0sphcdP7cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gaFcl8fg; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HJiLWV3447192;
	Tue, 17 Feb 2026 23:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=p/FNDCuaE6MVM/5pbtJV1b7hnrpAwQXWlFxxcZ2T5Vw=; b=gaFcl8fg
	ljikgJwk1PSRLR5r56Ge6X0icwJYXvIVUwPocr4iXlomjIAJlfjncRtYiH4qStBy
	JWhIQFJ807i0dEThmK7BG8w2shzgX28y5/5KNFBnJUfh+Hmf+dpk7vSNB+m3z/rW
	Wxd0V3/jra/r9U8kjkzoCuFD+JvmFFuyhCayNfKuTZG9xDs8XVAArdMpp0mb/FZU
	CX16C77KVGfpsfjaS4dj78bPqF+/Yq8rTF5Ir6PoYERKAlIT0kehtg9x8iGHP43n
	C7U3NDNcmfZUtW/Sln5H7oshKAggyTF5EEMgi1jYam37yi7HpSHVcrboawZSixKA
	OhGuQvXfuuDuQg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rxxkr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 23:16:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWF5AhR8VUvIodEd0zy6ElIhDEpwBn9jWImi93Cwg6N+iH0gp2ZOTsIquPXH+bL/N+cufxcXI6s58DOPDrWmsEGhztGdKgm738OoJvDEbbhkzZkzE6TMXuP6fCubddb/TB2udyqSWlg9XLMqpFXfV0hPquiHtjqnutnQzWWwpPEf2GG9dBf0DcY+leSXxEqYwZC3riSE9+FKO4/xKwQySC9mA9HnYpDtgYtSMFuC4o0VglQiRuGkeOubGaVZUEkkxFg3F6K/lniVvhmbtAIwA9BJ1Vha31g6WKxz6f2CymF2iZLQVKWE/HAsmlGvrm0Tu/8zb3+LEfjLlnCleRzpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/FNDCuaE6MVM/5pbtJV1b7hnrpAwQXWlFxxcZ2T5Vw=;
 b=GZaOsdiSCg064iOvJGhlv+E3BJNgBSzuB6KLiMMjtb6K3GPjZezBcwW/vddPlmo5BVm30bSevZVk/GPnB473FMZAKasWvedAhopW6IhD0wOCtE3eu8u8haeKpVWCEvMa630OOfQTWv8aqkwD/mxTunUwG24lJ0EVTB2noQVBYrzmLiGP77DMIeNy9vYKAbbQaFnxdN6DrwNMPixyCjXYEYtPghPrWwyxs2EOD7D56oTmlBmRrT3RxV+4YRjcLvIovoCV6lhDoPcZBJD1Nik+o7F6uW1FPkLUOO4cDNO7qoDQ9FqhJyUh70UWSGeo6n9MCIUktAreFPEx5vpXVTrn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6498.namprd15.prod.outlook.com (2603:10b6:610:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 23:16:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 23:16:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v4] hfsplus: fix uninit-value by
 validating catalog record size
Thread-Index: AQHcoGNpjS9z6dt2rkO5qu/gc1M4Qw==
Date: Tue, 17 Feb 2026 23:16:14 +0000
Message-ID: <f842540484864b0af27c22461e93abbc0e5041d8.camel@ibm.com>
References: <20260214002100.436125-1-kartikey406@gmail.com>
	 <d28f5840ba4ae273fcb0220f2e68d1101bd79d4b.camel@ibm.com>
In-Reply-To: <d28f5840ba4ae273fcb0220f2e68d1101bd79d4b.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6498:EE_
x-ms-office365-filtering-correlation-id: 34b18647-136a-4139-fb36-08de6e7a8bfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHphQjRDK0pEQTZzaGdiVUNWUlhHd2l5TUlIWVJ0SDF6QlZUWCtBaXl0WE8w?=
 =?utf-8?B?ckdQbUVia05BYmNXbFNlcFBuaVI2T0t2aXhOZU54d2sybHd4MmdGT0VPWktj?=
 =?utf-8?B?cWpyKy9UK3ppZklOZWV1c29EVUFHdDhBdHl2cWFTRlNzYzRjMFpIaU95azVy?=
 =?utf-8?B?SjJXa0RUQkpKZW1YeElSQlp0SnpsSVo3SE1nK01OcE9tTUM3Wk9QbG16WjZi?=
 =?utf-8?B?NVpGMW5OWGV2Mzh5TEZidStRNGVucDJwZjZkTFM3YTF1dzBGRGl6bC9XaVNX?=
 =?utf-8?B?TWtJaUxEVjNSaWlVOWxBMmI3Mm1BRGlpSUcyQVBkMFE4SGgrUUlNbXQ3dzdX?=
 =?utf-8?B?M0lLV3pNRkVpeml2QzZJWjUySUJGUzI3T3ZlcmF2N1FKTGMwY0RJeUd0b2tz?=
 =?utf-8?B?eHdPTzRSQmdta0FWTWtOZW43cVJ3NmNhRDQ2SEhUWUhhb05RN0RWbWJJUWU4?=
 =?utf-8?B?USthNGw4NFcvSk1ZcVg4UXowNzdXbGNqOHo4bWtYeElVSEc1MmFsRFVWUndP?=
 =?utf-8?B?MzhuY1Q2SUtXS1UzNWV6enR4TmVjaE45b2hZTEQ0dmhhQXlpbkxDR1U4Zkdx?=
 =?utf-8?B?akkwaURmMEw3bDJBQWVGcDBzL0JoU0NSWjdZU0IzdnpaTyszSnBNZ2hRMTVD?=
 =?utf-8?B?Njc2a29mNXUwZThBVmRPZ1llUXRvNTJoMHVNOVppcWNzdDJpQWFHYkhTOVBw?=
 =?utf-8?B?U2ZOUDRYakFaSm1OYWtNNHBvb3JNR1d5YVVsbVM5NGQ5SFdQS1NIWS9UbXpV?=
 =?utf-8?B?d25rVit4Z0E1TDFPYUpCT0E2ME5naEFhYVF1YmJub0cvMlVFYnlhaUl0NHc0?=
 =?utf-8?B?Vm50ejg1ZlJlQTN6MnZCbGZydXRLYXVvUE9Nd2tFYWJlalVzMEdCS1VrWEw2?=
 =?utf-8?B?cDZoMGhHWWVQeDFTM1h2UkFqamxoVGovSWpRcFg5YTJaOVBhZXFRWkFrM1Ey?=
 =?utf-8?B?VGc3SnZXZVhETEZ0TVVNTzVXMVpRa3JUaitKNDE1ODRCUUk2SzRqRm10SDU2?=
 =?utf-8?B?R0wyNXRLcTdkYWVqc3M4Q1B3ZVM2dWQvRjhZRlUzYUUyaDFuYUFuNGlWUlVz?=
 =?utf-8?B?V0NPSTZaRlI1ODJIc1BYcFZ1SHlOYmJYSGZoS3Uwd3JmYjJtbXZsQmYzRzBF?=
 =?utf-8?B?T21MZjExb0hCdVpZNUFYZTJiaDVNRW9Uak1wWVR6dzRiV2hFcWMvMDNhak85?=
 =?utf-8?B?a2tXWWV6b3dDdTZaVURaSHNuUG0zQmNCaWo5eDJJdytybGROa2ZjZWNIbUhr?=
 =?utf-8?B?dnlUUWF3N2VtS0t2TUlhc0tCK2J3Szd3NmdFc3JGVmJReHRzNGdydmlPd3RY?=
 =?utf-8?B?RVZnM0hLMmhnbFVkVVQ5c00vWDNvLzJkQzlNdEtIVXNYcDFXcGVRYzNrVVVL?=
 =?utf-8?B?VEpzUjhWSDVmTCtrNFNBMisxTzNBdzBiZDdhcGVUaGJFRWxLZDdTK2QvWnpP?=
 =?utf-8?B?dGd2WHM4K014QVo0ZG9hOHM2dGwzeTNQMWJCZDJQeHhRT0RpZ3UvQ2tGZXNq?=
 =?utf-8?B?Z0o0MllNVHo2RENRQVhyUlZjd3NmOXk1MG9hbVNpN3pSRnorWElxSHBYS29C?=
 =?utf-8?B?VmxwKzNIeGZBa2VxL2hPdmZjVTdLQlVyYWx3SjNTakJOZ3VSSk5CUndBUkRI?=
 =?utf-8?B?LytoSE9WQktuaWhudjdiUVBEWFZ1bVpsdFlXZzdYM08vNHEwUjY0Z0hrdjJ4?=
 =?utf-8?B?bEFzRm5mRWVONllCU283ZjJ3bjBvdkp0NkN5cXhWQmwxc0trYlBYRE5wczJ3?=
 =?utf-8?B?ZnZycnBQQmFtY1RUazlLVmgxWjhJWnpCZU51djlaS0p5MTZPa2liN01VTHE1?=
 =?utf-8?B?aXU0WlpDdncrbmZPd2c3WmNXWDNJZ1g5Zm9kdTl6akZLQ0FrQ1lLQ3ZBY1Nl?=
 =?utf-8?B?dlRSZzkvOUU3Rm1nYktwQmRIOTlJRzFPMEdaREZ5UjZDRXVMbEJRY1JzOFor?=
 =?utf-8?B?YlB2ZS9kSG1XL20wMVYvYitQMW02ai85akdKQVpzS3IvNzZob2l0MVRhdHdD?=
 =?utf-8?B?TERQUjZxMUVFZHFFaXhrdlBMUlZHV2pSdCthdkpEVFN5ZUxUSHo4UmRsU0tx?=
 =?utf-8?B?YWxXVURDN0RuekpaR2RCQ1FocWVBa1Q1MGpHMWVyNk84UHhjMVc2TVZ4RWwv?=
 =?utf-8?Q?ps1gd5XHTZksj/jVqAh8Yh+b+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVZYTDRZUENiR000NDJScEF0cTViRjdTQmVFclZIODBhSjNNRmVsVnhPOGpB?=
 =?utf-8?B?TG52TjBkRTJSSFRGcC9FMTlUckgvSkNKeHZXNVJLQXhVeDAwUG1PWnhraHBK?=
 =?utf-8?B?RFdmOEpLTnZJdWlna05BS1gyVEpnVzRWSWt6dGdIcUFCTnIvdzFvY1M4bG12?=
 =?utf-8?B?NjdPUHhYUk1iTFozNmlkREN5emVROFdjZWNmTGVIZlNGQldZUUJiRUFpUWht?=
 =?utf-8?B?VnJpNWpqUEdBRXBGczhZN25URC9FbFp0QmFzY0NmQ0NySGN3STlKaTBmR1ZN?=
 =?utf-8?B?MXU4SFU4UEl4Zzg1OW9NbU9tV1ZLcVFXbC9QMkhub0lyS0lrZlFRQWYxdGZX?=
 =?utf-8?B?N2JaYkI1MDFIL3VmWjRyZ1FqYXFObFlXcXBGMFptM2FPeDlmVHRkNG1KZVR5?=
 =?utf-8?B?UGJSZ0R5SGdrRU1sOVFCNUliK09sSGZ5Wkk0NDJBZW9haGtzTVN5RXJwbHlS?=
 =?utf-8?B?MVU4bTVEK1RmVWJwUXRpeWFPVDM3RmhVMWQ1TndRQXQyZzQrSy9NZVVVV1BJ?=
 =?utf-8?B?UnJWWWE4MVdjK3VKSlgvcVZFeDcrbERBeGc4SElvMU84Q1grY0hYemFHMkhn?=
 =?utf-8?B?dTA0M01DdlZZT2gyamtsaEo2cy9FdnlydUFsWk84bGNac0FWdEZHZmhhNlJw?=
 =?utf-8?B?TDlUVHJwR1lMOHhCc3N1bmpxdk5FQkt3RzFnbDRFaTZZOFE0WW9Rc0prOWRm?=
 =?utf-8?B?WENOYUdMK2ZLSks1NWpWTDhsdzZNVGNabDZwZkFqaGFrbi9Qd3dpVm9MSEFU?=
 =?utf-8?B?RjdvVjFVUDJ5VTZWQmRySU5peG5ydklkbk1tZm1tRmNFdTZHNmZQNGhLQ2Nl?=
 =?utf-8?B?bU1oRURuNGEwbDB2dThpc0xmejJ0WUMrSWNMUEl2b1BDMVdzLzkrZ2pJWksx?=
 =?utf-8?B?U1JjTFRwNHJpNFpVRXNJQjZiSUZzN1lzcDQxdENKVnVnNkFSSWsrenJsUWFO?=
 =?utf-8?B?TXMzZUwrYlNTamZQYkt5RUZibzRTdDB5akxWcjJVQkIzMzNDa0pic2RuV2RN?=
 =?utf-8?B?VTAyalNtdGwxOUx0VUU1VVBvYUlldFB3TWp5M3JRQWE4RCt6UmZDOUhmMURR?=
 =?utf-8?B?ZEFwdDM1WXJMWjZaNzBOb0ZNb24rbHp4Q1lIUnV5RXNRVlR5QVkvcUZTS28v?=
 =?utf-8?B?YXF5Y0NzWWxaTUI4YUk3cE5EcGh1MDhKZjdwbUREcE5vWUtnYnU2R2x3YXlv?=
 =?utf-8?B?N0wweVlrb0h4WEt0U1VpQ0J1NUJ1YjROTmZlM2oxQ0RwNHJsUG5WTWFzS0Nx?=
 =?utf-8?B?RS9mblJPZmxXd1BKMFBjWlA2cFdiL2VzaXhGK1NJYVozSzVjYmV3Z0hKNDl4?=
 =?utf-8?B?M2M1OXAzak50V0lRYXQvUTl0bGxiTzRlRVB5UzlPN2NDbUZOTUFNck5pUGtJ?=
 =?utf-8?B?bGhXOHVCN3M2UTI5ZHpuSFdJNHJPV3F2N2ZabE1sMFUyUmJDaDVUeVZCeGVB?=
 =?utf-8?B?MmFWUldCeU5DeHJtdlVEOWNNdGdrbnNZNzAxSTl1SVBCeUZHQzlFbUx0T1FC?=
 =?utf-8?B?SGs5RkZ0OUlmYW9LZzBEelVRY3Iyc3lZQmpLR1VQZ1orUjUzaFpoK1hsYS8w?=
 =?utf-8?B?d3VIS3dQcVlNYzBCS0hZSVhUMWpUYmRjVnYxTFRZdnNNcWZ2N2EzdUY3NDVD?=
 =?utf-8?B?UjgzZzQ5bjBMbytoRmhDQi9MVHVwcDhzSkJxd0N3dit6ZERXTStrNTlRZExS?=
 =?utf-8?B?bm1lMUVodlFRSnVPamFYcVZkcHlXdnFNMzJpZk9CdVFSSzg1OWkzcyt3d3p2?=
 =?utf-8?B?cjRtT3dXUyt4Z2N1TGxzeHJjMktOdVFob2I2dUNXYzRPOWpHQnI4dER2VGs2?=
 =?utf-8?B?bVhwUUFqZDRkYmRMVVAydlFDdWMwZVNSSElxUjRuTk85anJxWEZKV1ZyTGY1?=
 =?utf-8?B?UWZwelgvcUpQcWRxQmpzTkVkbm1wenBVYXFNMHBYUWZZRFNXNHcybnd6eVFY?=
 =?utf-8?B?WHUrZ2dUeWNtZmF2UkRqaHBsaGprRFZYQU5PamowTHJEV3loa2h0bmdEbFBh?=
 =?utf-8?B?UVovMmlGTGp3d1h4WGRXaTNRNktqYW5waTA0SnFJbitwRXA5ZzVvaGFIbkI1?=
 =?utf-8?B?YlZiM3RiUlgvaW1RM1hPeXFFbEVDazBINkpVY2kzcEQ2cjdWWjRIMEY2RG5W?=
 =?utf-8?B?cW1NTG9FQU92RlJ6RS9uRHFoL0JkcHEwYjhvYVdLdHMySGltY1RKWWJBNnRl?=
 =?utf-8?B?b0drdnJuejZYUmNvUzVWM2VwNHRuVzlHMzBaT28vMEFNdVFiWFRvRWk3Vzdj?=
 =?utf-8?B?emt1SmtBYVpVdmdnRXdnZ0xBME40SnIyM1ZVUU43WE83OFJMNjVJbmlwOFVM?=
 =?utf-8?B?VnlmMEtjRTc1SWdFU2tGYlM2Y2VoOUJZVjlOcEwyY1RNM01oSEVjaVlqdlZ3?=
 =?utf-8?Q?EbtGkuyNAPBYOqI976PHDJ0NZzxuea61UXvPX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A33693ED4A43094ABCD75C058B0E1792@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b18647-136a-4139-fb36-08de6e7a8bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 23:16:14.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StKVs5PhyPT8b/Yk3X/KrLZ3mSUqQ30nPhbtKDN/tmETtUplFqqCgt9diyyZGz1gA2Coa1hIKNMreIunITA5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6498
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6994f6c5 cx=c_pps
 a=n9MmWVbgKLYxIbvHr99TLw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=wCmvBT1CAAAA:8 a=WX18pPVOkEZSni71HSEA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: flTWLBVojI82v46un6t0qAshKRAj05i2
X-Proofpoint-ORIG-GUID: SDrFZ3n4KAjmE0gcWm9LwmRJrlQWTrRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE5MiBTYWx0ZWRfXz+9DHUAhTmR1
 zf5E5Nv2WWdsnyIATySw+1b7KF/iNMugfn8qy0X3Hy29FbBCehDh8XPuT1QCcdZDKJCLmUllNYB
 tRr6FcHjlm3JkcbkPwtyuXn4HVwYbYMjermMNlU0yr8/jDCsYK4TmxZylJ2jR5oECfvxJ2Uz3QE
 oAlGD75Y5sQb2wZeLwUO0IAPEhjwD8Dze5+38dVRmCnbCTGflBrEGoQZYsm9H1ut3kMCbQ9PJW2
 CAZ+UzuA0zOgewj/DXHAIYKey3ldOvJFm7nGmFp1qYn9UKmbnujf36A0T2KkDL/niE0FvQ4AznF
 UGYBGOGDSlUye0wX1g3I9mOhlODYSlgMi+/wMNsi8CHWYmhcaN4PhxuRzUyn/mSiiTyINDaPykS
 5qMdqUpibxHavpeVnNSn0zr82abaHPtCBaUMSEN03yzu/oL2v5+HoyVVh5M1Vu/kX116ppFT4Cc
 zJV3c+Hs6GhWnHGqZgw==
Subject: RE:  [PATCH v4] hfsplus: fix uninit-value by validating catalog
 record size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170192
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77435-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,dubeyko.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09600151C30
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTE3IGF0IDAwOjE5ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFNhdCwgMjAyNi0wMi0xNCBhdCAwNTo1MSArMDUzMCwgRGVlcGFuc2h1IEthcnRp
a2V5IHdyb3RlOg0KPiA+IFN5emJvdCByZXBvcnRlZCBhIEtNU0FOIHVuaW5pdC12YWx1ZSBpc3N1
ZSBpbiBoZnNwbHVzX3N0cmNhc2VjbXAoKS4gVGhlDQo+ID4gcm9vdCBjYXVzZSBpcyB0aGF0IGhm
c19icmVjX3JlYWQoKSBkb2Vzbid0IHZhbGlkYXRlIHRoYXQgdGhlIG9uLWRpc2sNCj4gPiByZWNv
cmQgc2l6ZSBtYXRjaGVzIHRoZSBleHBlY3RlZCBzaXplIGZvciB0aGUgcmVjb3JkIHR5cGUgYmVp
bmcgcmVhZC4NCj4gPiANCj4gPiBXaGVuIG1vdW50aW5nIGEgY29ycnVwdGVkIGZpbGVzeXN0ZW0s
IGhmc19icmVjX3JlYWQoKSBtYXkgcmVhZCBsZXNzIGRhdGENCj4gPiB0aGFuIGV4cGVjdGVkLiBG
b3IgZXhhbXBsZSwgd2hlbiByZWFkaW5nIGEgY2F0YWxvZyB0aHJlYWQgcmVjb3JkLCB0aGUNCj4g
PiBkZWJ1ZyBvdXRwdXQgc2hvd2VkOg0KPiA+IA0KPiA+ICAgSEZTUExVU19CUkVDX1JFQUQ6IHJl
Y19sZW49NTIwLCBmZC0+ZW50cnlsZW5ndGg9MjYNCj4gPiAgIEhGU1BMVVNfQlJFQ19SRUFEOiBX
QVJOSU5HIC0gZW50cnlsZW5ndGggKDI2KSA8IHJlY19sZW4gKDUyMCkgLSBQQVJUSUFMIFJFQUQh
DQo+ID4gDQo+ID4gaGZzX2JyZWNfcmVhZCgpIG9ubHkgdmFsaWRhdGVzIHRoYXQgZW50cnlsZW5n
dGggaXMgbm90IGdyZWF0ZXIgdGhhbiB0aGUNCj4gPiBidWZmZXIgc2l6ZSwgYnV0IGRvZXNuJ3Qg
Y2hlY2sgaWYgaXQncyBsZXNzIHRoYW4gZXhwZWN0ZWQuIEl0IHN1Y2Nlc3NmdWxseQ0KPiA+IHJl
YWRzIDI2IGJ5dGVzIGludG8gYSA1MjAtYnl0ZSBzdHJ1Y3R1cmUgYW5kIHJldHVybnMgc3VjY2Vz
cywgbGVhdmluZyA0OTQNCj4gPiBieXRlcyB1bmluaXRpYWxpemVkLg0KPiA+IA0KPiA+IFRoaXMg
dW5pbml0aWFsaXplZCBkYXRhIGluIHRtcC50aHJlYWQubm9kZU5hbWUgdGhlbiBnZXRzIGNvcGll
ZCBieQ0KPiA+IGhmc3BsdXNfY2F0X2J1aWxkX2tleV91bmkoKSBhbmQgdXNlZCBieSBoZnNwbHVz
X3N0cmNhc2VjbXAoKSwgdHJpZ2dlcmluZw0KPiA+IHRoZSBLTVNBTiB3YXJuaW5nIHdoZW4gdGhl
IHVuaW5pdGlhbGl6ZWQgYnl0ZXMgYXJlIHVzZWQgYXMgYXJyYXkgaW5kaWNlcw0KPiA+IGluIGNh
c2VfZm9sZCgpLg0KPiA+IA0KPiA+IEZpeCBieSBpbnRyb2R1Y2luZyBoZnNwbHVzX2JyZWNfcmVh
ZF9jYXQoKSB3cmFwcGVyIHRoYXQ6DQo+ID4gMS4gQ2FsbHMgaGZzX2JyZWNfcmVhZCgpIHRvIHJl
YWQgdGhlIGRhdGENCj4gPiAyLiBWYWxpZGF0ZXMgdGhlIHJlY29yZCBzaXplIGJhc2VkIG9uIHRo
ZSB0eXBlIGZpZWxkOg0KPiA+ICAgIC0gRml4ZWQgc2l6ZSBmb3IgZm9sZGVyIGFuZCBmaWxlIHJl
Y29yZHMNCj4gPiAgICAtIFZhcmlhYmxlIHNpemUgZm9yIHRocmVhZCByZWNvcmRzIChkZXBlbmRz
IG9uIHN0cmluZyBsZW5ndGgpDQo+ID4gMy4gUmV0dXJucyAtRUlPIGlmIHNpemUgZG9lc24ndCBt
YXRjaCBleHBlY3RlZA0KPiA+IA0KPiA+IEFsc28gaW5pdGlhbGl6ZSB0aGUgdG1wIHZhcmlhYmxl
IGluIGhmc3BsdXNfZmluZF9jYXQoKSBhcyBkZWZlbnNpdmUNCj4gPiBwcm9ncmFtbWluZyB0byBl
bnN1cmUgbm8gdW5pbml0aWFsaXplZCBkYXRhIGV2ZW4gaWYgdmFsaWRhdGlvbiBpcw0KPiA+IGJ5
cGFzc2VkLg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrZDgwYWJiNWI4OTBkMzkyNjFl
NzJAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiA+IENsb3NlczogaHR0cHM6Ly91cmxkZWZl
bnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19zeXprYWxsZXIuYXBwc3BvdC5j
b21fYnVnLTNGZXh0aWQtM0RkODBhYmI1Yjg5MGQzOTI2MWU3MiZkPUR3SURBZyZjPUJTRGljcUJR
QkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdT
czAwJm09SHNBM180dXdKS21TUzgtS2hfS1NTTlpEZElKSjM3ZlFnMVFrbjhITlZ0bHZPV1RSVW90
V2RYLVlVLTZCRzVFayZzPWFoU2lOcDA5WHRrNmZaNEoxSEtOVklLR1lNeUFBQjZwQjB6U01NTHVp
RFkmZT0gDQo+ID4gRml4ZXM6IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQ0KPiA+
IFRlc3RlZC1ieTogc3l6Ym90K2Q4MGFiYjViODkwZDM5MjYxZTcyQHN5emthbGxlci5hcHBzcG90
bWFpbC5jb20NCj4gPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIv
dXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19hbGxfMjAyNjAxMjAwNTExMTQuMTI4MTI4
NS0yRDEtMkRrYXJ0aWtleTQwNi00MGdtYWlsLmNvbV8mZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJ
OVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZt
PUhzQTNfNHV3SkttU1M4LUtoX0tTU05aRGRJSkozN2ZRZzFRa244SE5WdGx2T1dUUlVvdFdkWC1Z
VS02Qkc1RWsmcz1tNUtBVFNlY2pfTjU5alJ5Y2txV3dUREhMV3NBay1TQTRNY0ZpVVRweUhnJmU9
ICBbdjFdDQo+ID4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3Vy
bD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfYWxsXzIwMjYwMTIxMDYzMTA5LjE4MzAyNjMt
MkQxLTJEa2FydGlrZXk0MDYtNDBnbWFpbC5jb21fJmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlS
a1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1I
c0EzXzR1d0pLbVNTOC1LaF9LU1NOWkRkSUpKMzdmUWcxUWtuOEhOVnRsdk9XVFJVb3RXZFgtWVUt
NkJHNUVrJnM9S3R4ZC04RTg0OEtvM1NLSi1oWjJfVm9hNUNCSUNTYVltR1kxaTlGbkw2TSZlPSAg
W3YyXQ0KPiA+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDI2MDIxMjAxNDIzMy4yNDIyMDQ2LTJE
MS0yRGthcnRpa2V5NDA2LTQwZ21haWwuY29tXyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtW
eVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09SHNB
M180dXdKS21TUzgtS2hfS1NTTlpEZElKSjM3ZlFnMVFrbjhITlZ0bHZPV1RSVW90V2RYLVlVLTZC
RzVFayZzPUtjTVBfM0tZOFN1S1JGaGhDcmphS2ZVSjlDZTRuYmhfV3V1WWwtNGR5dlUmZT0gIFt2
M10NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZWVwYW5zaHUgS2FydGlrZXkgPGthcnRpa2V5NDA2QGdt
YWlsLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+IC0gTW92ZSBoZnNwbHVz
X2NhdF90aHJlYWRfc2l6ZSgpIGFzIHN0YXRpYyBpbmxpbmUgdG8gaGVhZGVyIGZpbGUgYXMNCj4g
PiAgIHN1Z2dlc3RlZCBieSBWaWFjaGVzbGF2IER1YmV5a28NCj4gPiANCj4gPiBDaGFuZ2VzIGlu
IHYzOg0KPiA+IC0gSW50cm9kdWNlZCBoZnNwbHVzX2JyZWNfcmVhZF9jYXQoKSB3cmFwcGVyIGZ1
bmN0aW9uIGZvciBjYXRhbG9nLXNwZWNpZmljDQo+ID4gICB2YWxpZGF0aW9uIGluc3RlYWQgb2Yg
bW9kaWZ5aW5nIGdlbmVyaWMgaGZzX2JyZWNfcmVhZCgpDQo+ID4gLSBBZGRlZCBoZnNwbHVzX2Nh
dF90aHJlYWRfc2l6ZSgpIGhlbHBlciB0byBjYWxjdWxhdGUgdmFyaWFibGUtc2l6ZSB0aHJlYWQN
Cj4gPiAgIHJlY29yZCBzaXplcw0KPiA+IC0gVXNlIGV4YWN0IHNpemUgbWF0Y2ggKCE9KSBpbnN0
ZWFkIG9mIG1pbmltdW0gc2l6ZSBjaGVjayAoPCkNCj4gPiAtIFVzZSBzaXplb2YoaGZzcGx1c191
bmljaHIpIGluc3RlYWQgb2YgaGFyZGNvZGVkIHZhbHVlIDINCj4gPiAtIFVwZGF0ZWQgYWxsIGNh
dGFsb2cgcmVjb3JkIHJlYWQgc2l0ZXMgdG8gdXNlIG5ldyB3cmFwcGVyIGZ1bmN0aW9uDQo+ID4g
LSBBZGRyZXNzZWQgcmV2aWV3IGZlZWRiYWNrIGZyb20gVmlhY2hlc2xhdiBEdWJleWtvDQo+ID4g
DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIFVzZSBzdHJ1Y3R1cmUgaW5pdGlhbGl6YXRpb24g
KD0gezB9KSBpbnN0ZWFkIG9mIG1lbXNldCgpDQo+ID4gLSBJbXByb3ZlZCBjb21taXQgbWVzc2Fn
ZSB0byBjbGFyaWZ5IGhvdyB1bmluaXRpYWxpemVkIGRhdGEgaXMgdXNlZA0KPiA+IC0tLQ0KPiA+
ICBmcy9oZnNwbHVzL2JmaW5kLmMgICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGZzL2hmc3BsdXMvY2F0YWxvZy5jICAgIHwgIDQgKystLQ0K
PiA+ICBmcy9oZnNwbHVzL2Rpci5jICAgICAgICB8ICAyICstDQo+ID4gIGZzL2hmc3BsdXMvaGZz
cGx1c19mcy5oIHwgIDkgKysrKysrKysNCj4gPiAgZnMvaGZzcGx1cy9zdXBlci5jICAgICAgfCAg
MiArLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvYmZpbmQuYyBiL2ZzL2hmc3Bs
dXMvYmZpbmQuYw0KPiA+IGluZGV4IDliODlkY2UwMGVlOS4uNGM1ZmQyMTU4NWVmIDEwMDY0NA0K
PiA+IC0tLSBhL2ZzL2hmc3BsdXMvYmZpbmQuYw0KPiA+ICsrKyBiL2ZzL2hmc3BsdXMvYmZpbmQu
Yw0KPiA+IEBAIC0yOTcsMyArMjk3LDQ5IEBAIGludCBoZnNfYnJlY19nb3RvKHN0cnVjdCBoZnNf
ZmluZF9kYXRhICpmZCwgaW50IGNudCkNCj4gPiAgCWZkLT5ibm9kZSA9IGJub2RlOw0KPiA+ICAJ
cmV0dXJuIHJlczsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGhmc3BsdXNfYnJl
Y19yZWFkX2NhdCAtIHJlYWQgYW5kIHZhbGlkYXRlIGEgY2F0YWxvZyByZWNvcmQNCj4gPiArICog
QGZkOiBmaW5kIGRhdGEgc3RydWN0dXJlDQo+ID4gKyAqIEBlbnRyeTogcG9pbnRlciB0byBjYXRh
bG9nIGVudHJ5IHRvIHJlYWQgaW50bw0KPiA+ICsgKg0KPiA+ICsgKiBSZWFkcyBhIGNhdGFsb2cg
cmVjb3JkIGFuZCB2YWxpZGF0ZXMgaXRzIHNpemUgbWF0Y2hlcyB0aGUgZXhwZWN0ZWQNCj4gPiAr
ICogc2l6ZSBiYXNlZCBvbiB0aGUgcmVjb3JkIHR5cGUuDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVy
bnMgMCBvbiBzdWNjZXNzLCBvciBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuDQo+ID4g
KyAqLw0KPiA+ICtpbnQgaGZzcGx1c19icmVjX3JlYWRfY2F0KHN0cnVjdCBoZnNfZmluZF9kYXRh
ICpmZCwgaGZzcGx1c19jYXRfZW50cnkgKmVudHJ5KQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmVzOw0K
PiA+ICsJdTMyIGV4cGVjdGVkX3NpemU7DQo+ID4gKw0KPiA+ICsJcmVzID0gaGZzX2JyZWNfcmVh
ZChmZCwgZW50cnksIHNpemVvZihoZnNwbHVzX2NhdF9lbnRyeSkpOw0KPiA+ICsJaWYgKHJlcykN
Cj4gPiArCQlyZXR1cm4gcmVzOw0KPiA+ICsNCj4gPiArCS8qIFZhbGlkYXRlIGNhdGFsb2cgcmVj
b3JkIHNpemUgYmFzZWQgb24gdHlwZSAqLw0KPiA+ICsJc3dpdGNoIChiZTE2X3RvX2NwdShlbnRy
eS0+dHlwZSkpIHsNCj4gPiArCWNhc2UgSEZTUExVU19GT0xERVI6DQo+ID4gKwkJZXhwZWN0ZWRf
c2l6ZSA9IHNpemVvZihzdHJ1Y3QgaGZzcGx1c19jYXRfZm9sZGVyKTsNCj4gPiArCQlicmVhazsN
Cj4gPiArCWNhc2UgSEZTUExVU19GSUxFOg0KPiA+ICsJCWV4cGVjdGVkX3NpemUgPSBzaXplb2Yo
c3RydWN0IGhmc3BsdXNfY2F0X2ZpbGUpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBIRlNQ
TFVTX0ZPTERFUl9USFJFQUQ6DQo+ID4gKwljYXNlIEhGU1BMVVNfRklMRV9USFJFQUQ6DQo+ID4g
KwkJZXhwZWN0ZWRfc2l6ZSA9IGhmc3BsdXNfY2F0X3RocmVhZF9zaXplKCZlbnRyeS0+dGhyZWFk
KTsNCj4gPiArCQlicmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJcHJfZXJyKCJ1bmtub3du
IGNhdGFsb2cgcmVjb3JkIHR5cGUgJWRcbiIsDQo+ID4gKwkJICAgICAgIGJlMTZfdG9fY3B1KGVu
dHJ5LT50eXBlKSk7DQo+ID4gKwkJcmV0dXJuIC1FSU87DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
aWYgKGZkLT5lbnRyeWxlbmd0aCAhPSBleHBlY3RlZF9zaXplKSB7DQo+ID4gKwkJcHJfZXJyKCJj
YXRhbG9nIHJlY29yZCBzaXplIG1pc21hdGNoICh0eXBlICVkLCBnb3QgJXUsIGV4cGVjdGVkICV1
KVxuIiwNCj4gPiArCQkgICAgICAgYmUxNl90b19jcHUoZW50cnktPnR5cGUpLCBmZC0+ZW50cnls
ZW5ndGgsIGV4cGVjdGVkX3NpemUpOw0KPiA+ICsJCXJldHVybiAtRUlPOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMv
Y2F0YWxvZy5jIGIvZnMvaGZzcGx1cy9jYXRhbG9nLmMNCj4gPiBpbmRleCAwMmMxZWVlNGE0Yjgu
LjZjODM4MGY3MjA4ZCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9oZnNwbHVzL2NhdGFsb2cuYw0KPiA+
ICsrKyBiL2ZzL2hmc3BsdXMvY2F0YWxvZy5jDQo+ID4gQEAgLTE5NCwxMiArMTk0LDEyIEBAIHN0
YXRpYyBpbnQgaGZzcGx1c19maWxsX2NhdF90aHJlYWQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwN
Cj4gPiAgaW50IGhmc3BsdXNfZmluZF9jYXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTMyIGNu
aWQsDQo+ID4gIAkJICAgICBzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQpDQo+ID4gIHsNCj4gPiAt
CWhmc3BsdXNfY2F0X2VudHJ5IHRtcDsNCj4gPiArCWhmc3BsdXNfY2F0X2VudHJ5IHRtcCA9IHsw
fTsNCj4gPiAgCWludCBlcnI7DQo+ID4gIAl1MTYgdHlwZTsNCj4gPiAgDQo+ID4gIAloZnNwbHVz
X2NhdF9idWlsZF9rZXlfd2l0aF9jbmlkKHNiLCBmZC0+c2VhcmNoX2tleSwgY25pZCk7DQo+ID4g
LQllcnIgPSBoZnNfYnJlY19yZWFkKGZkLCAmdG1wLCBzaXplb2YoaGZzcGx1c19jYXRfZW50cnkp
KTsNCj4gPiArCWVyciA9IGhmc3BsdXNfYnJlY19yZWFkX2NhdChmZCwgJnRtcCk7DQo+ID4gIAlp
ZiAoZXJyKQ0KPiA+ICAJCXJldHVybiBlcnI7DQo+ID4gIA0KPiA+IGRpZmYgLS1naXQgYS9mcy9o
ZnNwbHVzL2Rpci5jIGIvZnMvaGZzcGx1cy9kaXIuYw0KPiA+IGluZGV4IGNhZGYwYjVmOTM0Mi4u
ZDg2ZTJmN2IyODljIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2hmc3BsdXMvZGlyLmMNCj4gPiArKysg
Yi9mcy9oZnNwbHVzL2Rpci5jDQo+ID4gQEAgLTQ5LDcgKzQ5LDcgQEAgc3RhdGljIHN0cnVjdCBk
ZW50cnkgKmhmc3BsdXNfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnksDQo+ID4gIAlpZiAodW5saWtlbHkoZXJyIDwgMCkpDQo+ID4gIAkJZ290byBmYWlsOw0K
PiA+ICBhZ2FpbjoNCj4gPiAtCWVyciA9IGhmc19icmVjX3JlYWQoJmZkLCAmZW50cnksIHNpemVv
ZihlbnRyeSkpOw0KPiA+ICsJZXJyID0gaGZzcGx1c19icmVjX3JlYWRfY2F0KCZmZCwgJmVudHJ5
KTsNCj4gPiAgCWlmIChlcnIpIHsNCj4gPiAgCQlpZiAoZXJyID09IC1FTk9FTlQpIHsNCj4gPiAg
CQkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiA+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2hmc3Bs
dXNfZnMuaCBiL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oDQo+ID4gaW5kZXggNDVmZTNhMTJlY2Jh
Li5lODExZDMzODYxYWYgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmgN
Cj4gPiArKysgYi9mcy9oZnNwbHVzL2hmc3BsdXNfZnMuaA0KPiA+IEBAIC01MDYsNiArNTA2LDE1
IEBAIGludCBoZnNwbHVzX3N1Ym1pdF9iaW8oc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc2VjdG9y
X3Qgc2VjdG9yLCB2b2lkICpidWYsDQo+ID4gIAkJICAgICAgIHZvaWQgKipkYXRhLCBibGtfb3Bm
X3Qgb3BmKTsNCj4gPiAgaW50IGhmc3BsdXNfcmVhZF93cmFwcGVyKHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IpOw0KPiA+ICANCj4gPiArc3RhdGljIGlubGluZSB1MzIgaGZzcGx1c19jYXRfdGhyZWFk
X3NpemUoY29uc3Qgc3RydWN0IGhmc3BsdXNfY2F0X3RocmVhZCAqdGhyZWFkKQ0KPiA+ICt7DQo+
ID4gKwlyZXR1cm4gb2Zmc2V0b2Yoc3RydWN0IGhmc3BsdXNfY2F0X3RocmVhZCwgbm9kZU5hbWUp
ICsNCj4gPiArCSAgICAgICBvZmZzZXRvZihzdHJ1Y3QgaGZzcGx1c191bmlzdHIsIHVuaWNvZGUp
ICsNCj4gPiArCSAgICAgICBiZTE2X3RvX2NwdSh0aHJlYWQtPm5vZGVOYW1lLmxlbmd0aCkgKiBz
aXplb2YoaGZzcGx1c191bmljaHIpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgaGZzcGx1c19i
cmVjX3JlYWRfY2F0KHN0cnVjdCBoZnNfZmluZF9kYXRhICpmZCwgaGZzcGx1c19jYXRfZW50cnkg
KmVudHJ5KTsNCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIHRpbWUgaGVscGVyczogY29udmVydCBi
ZXR3ZWVuIDE5MDQtYmFzZSBhbmQgMTk3MC1iYXNlIHRpbWVzdGFtcHMNCj4gPiAgICoNCj4gPiBk
aWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9zdXBlci5jIGIvZnMvaGZzcGx1cy9zdXBlci5jDQo+ID4g
aW5kZXggYWFmZmE5ZTA2MGEwLi5lNTk2MTFhNjY0ZWYgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvaGZz
cGx1cy9zdXBlci5jDQo+ID4gKysrIGIvZnMvaGZzcGx1cy9zdXBlci5jDQo+ID4gQEAgLTU2Nyw3
ICs1NjcsNyBAQCBzdGF0aWMgaW50IGhmc3BsdXNfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ID4gIAllcnIgPSBoZnNwbHVzX2NhdF9i
dWlsZF9rZXkoc2IsIGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9DTklELCAmc3RyKTsNCj4g
PiAgCWlmICh1bmxpa2VseShlcnIgPCAwKSkNCj4gPiAgCQlnb3RvIG91dF9wdXRfcm9vdDsNCj4g
PiAtCWlmICghaGZzX2JyZWNfcmVhZCgmZmQsICZlbnRyeSwgc2l6ZW9mKGVudHJ5KSkpIHsNCj4g
PiArCWlmICghaGZzcGx1c19icmVjX3JlYWRfY2F0KCZmZCwgJmVudHJ5KSkgew0KPiA+ICAJCWhm
c19maW5kX2V4aXQoJmZkKTsNCj4gPiAgCQlpZiAoZW50cnkudHlwZSAhPSBjcHVfdG9fYmUxNihI
RlNQTFVTX0ZPTERFUikpIHsNCj4gPiAgCQkJZXJyID0gLUVJTzsNCj4gDQo+IFRoZSBwYXRjaCBs
b29rcyBnb29kLiBJIGRvbid0IGhhdmUgYW55IHJlbWFya3MuIEkgdGhpbmsgdGhhdCB3ZSd2ZSBy
ZWNlaXZlZA0KPiBwcmV0dHkgZ29vZCBzdWdnZXN0aW9uIGhvdyB0aGUgcGF0Y2ggY291bGQgYmUg
aW1wcm92ZWQuIENvdWxkIHlvdSBpbXByb3ZlIHRoZQ0KPiBwYXRjaD8gOikNCj4gDQo+IEkgYXNz
dW1lIHRoYXQgd2UgaGF2ZSB0aGUgc2FtZSBpc3N1ZSBmb3IgSEZTIGNhc2UuIEZyYW5rbHkgc3Bl
YWtpbmcsIEkgYW0NCj4gY29uc2lkZXJpbmcgdG8gbWFrZSB0aGUgYi10cmVlIGZ1bmN0aW9uYWxp
dHkgZ2VuZXJpYyBvbmUgZm9yIEhGUy9IRlMrIGJlY2F1c2UNCj4gdGhlcmUgYXJlIG11bHRpcGxl
IHNpbWlsYXJpdGllcyBpbiB0aGlzIGxvZ2ljLiBXb3VsZCB5b3UgbGlrZSB0byB0cnkgdG8NCj4g
Z2VuZXJhbGl6ZSB0aGlzIGItdHJlZSBmdW5jdGlvbmFsaXR5IGluIHRoZSBmb3JtIG9mIGxpYmhm
cyBvciBzb21ldGhpbmcgbGlrZQ0KPiB0aGlzPw0KPiANCg0KSSBkaWQgcnVuIHhmc3Rlc3RzIGZv
ciB0aGUgcGF0Y2guIFRoZSBwYXRjaCBoYXNuJ3QgaW50cm9kdWNlZCBhbnkgbmV3IGlzc3Vlcy4N
CkV2ZXJ5dGhpbmcgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlr
byA8c2xhdmFAZHViZXlrby5jb20+DQpUZXN0ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xh
dmFAZHViZXlrby5jb20+DQoNCkkgY2FuIHRha2UgdGhlIHBhdGNoIGFzIGl0IGlzLiBCdXQgSSB3
b3VsZCBsaWtlIHRvIHNlZSB0aGUgc3VnZ2VzdGVkIHNtYWxsDQppbXByb3ZlbWVudC4NCg0KVGhh
bmtzLA0KU2xhdmEuDQo=

