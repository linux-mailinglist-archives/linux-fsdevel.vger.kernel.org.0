Return-Path: <linux-fsdevel+bounces-67387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E3C3D9A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 23:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3B91890F87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06033CEAE;
	Thu,  6 Nov 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aff+9e2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7D30BB87;
	Thu,  6 Nov 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468215; cv=fail; b=iBZTkD3Z3oXRrp2EDN+g23ngqR6C1cQYVhNML0lyYP4uILRSU+4eTDcmEbeJnfQ2JPpNugZ4K77J/MyYSGW5ZCMUaNpXHs1Li1lIQuEGL8r4fBCEDssDAF2yTUnYxrrMR33X2bkqMhNkPf+h/B6PcC+ejr2l+z9DYbFRAHd2FXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468215; c=relaxed/simple;
	bh=9QD180Vthr1Rxp9ohqd1F4HxZ8j4VNhDAb8MYwEgUjo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=jIp5NvbMvX1wkfQHcrPGoDQxB7i0lB1UuvnyFSa9bCTGpjmFz91RnxRwKDo+3WcsrwJOFiQCdTbj/l8oQ4Zy0lcfQh/yqR2z4bu8pcRJT3SOZA+l+t2Wp0dP3SEIF3bJ6uoMMksCR4fK9AAcT+4u/9QuRwXMwCRBa7okXPt1vIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aff+9e2n; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6E42fK007670;
	Thu, 6 Nov 2025 22:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9QD180Vthr1Rxp9ohqd1F4HxZ8j4VNhDAb8MYwEgUjo=; b=aff+9e2n
	poGVZyKhBDC11uyG4EnNkJYgrKg4bfz5FEUYSVxZjNogI9uAhKziofjeicq+MYQS
	uCob/W9f9v6GiY9+q+1Z57rbQL1Q9RYrpmnAkZtBIp4gafyaPRed8jtou2ZD+TGO
	MOnYmUtXZvbT8tI2ikKTetykTXzxZHZqGy6FdcBAaeBxjGDRGHdoAEFL7Qlg/WlA
	wo2XerAanNeM1Pw1pX93kj5uiVlIsZnRQxxcThFztRK4un1KcWzkcqFGsi4RyXbM
	iu+mPd2A4h5OFndyg/iPzQXgv8wh4DpqP5PMIgvVNcVKdT+x5FJblh1BO9iMNn4f
	YpeA+ZCddy5YSw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrgssh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 22:30:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoCI7JUtCDUoJJRNTpKHEF9VAIFPilq+mjZL7JUg1VCc81cWqPNgGpx+T+k4hr4icmYppt9kxSW8abY0gCvcfM0pk92hPly56f8YfHAdB9Z6fv/9TPJD0Frn6m+nsnhTwZXJGYaeSytVuC0rrqhhzO8Rj+dstZZPhULp1a5wZfjG+Ytv1YQCgenvMnkcNZa7cz4cFbeD7Y+7VyRZJCjZ1gevNVc+UpAHLR4a1ZTeCP0bEvXrcgyjYuh2bzR+ArjQAbrhkp5rWKR4BLv4RERz5jr+S/qoREiEM9AgYd9Yanhsg0C92TSAQgNpdkz4u6X9dnHfPD0u/PxJCoyJ/eZHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QD180Vthr1Rxp9ohqd1F4HxZ8j4VNhDAb8MYwEgUjo=;
 b=Zlj6rzfSa8Xp1W+ZTB52SFQmr+86bd0OHusiyZDH3wprCUSc2r6BAasZNnPNHV2DgY0dTWvvl61lQerjBOvZ2L2WpOrbkXbYdVviBl0X5v/eo1q/64jALvA+QGrZg16Vr6Uv4MDmD9cDoydsnxbzS3mh5iNZXVHu2DCM5BZC47dl8Lffq08jWBrUgYpqc1Ld1Dvre38XLVNZJqig6U7rW52KQ0Kzxp8SeGMtaxxPeXzOdLyu1f7HRMk9yqgYv8Wj8fmW3YKGXlxI9WYLmk492Ub9v0/GTF6IvvjH3zBYpkGKQKaIDAdiw5ZiU3zA4tjluams43ji0xGsqB6jbDRwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5964.namprd15.prod.outlook.com (2603:10b6:8:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 22:29:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 22:29:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "wqu@suse.com"
	<wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Why generic/073 is generic but not btrfs
 specific?
Thread-Index: AQHcT12Yh6lLNevRjkO1oS1HPlyWxLTmIW2AgAADsICAAAXVgIAAEAgA
Date: Thu, 6 Nov 2025 22:29:46 +0000
Message-ID: <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
	 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
	 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
	 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
In-Reply-To: <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5964:EE_
x-ms-office365-filtering-correlation-id: 75a76db7-5f98-4e46-014e-08de1d83fde3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eW5CR3RabndwdUpsTERNTXZuQ2Y2eGtleGRsVFUrbjltZ0lCTU1heDVNTWJo?=
 =?utf-8?B?R1IvOGpMTkFIOVYzU29OODN1NzhqUlJWU2VPSkpVWmJicHN1d0F6bjJwYWtQ?=
 =?utf-8?B?dHVIRE5RZkZxcXJZdjdZc3VRckEvS0lrYnVwdHhlQnlmQThWblFRWTRHVEUw?=
 =?utf-8?B?c1pWcnhubDdQc21vbktMZVZndTNMRUtTVGtQK2hoVVdNR21uYkVyOXBPeldu?=
 =?utf-8?B?RjdrQzl3VUlwYmhHZnBZcXMwejg3dEdQUDdwNm84MTJxOXcrMXBSWitPZEVS?=
 =?utf-8?B?TUVJMzQ0ZThqbUpiSG5iUFRQa0h5aU1DSUF5Y1BOaENEbi9wb2F2YTkwR1hz?=
 =?utf-8?B?eEdLZGtPOHlxbERkUTRQdnFDS2dKaVVxTCtuYlBpTHJ0ZXQxMEUybjRlL0Rx?=
 =?utf-8?B?ZnNJK1FwYUR3TUNDRDdPUzRDZ05pekt2RHp1VnZuVktjZ1QwYkd1VXF5dUxn?=
 =?utf-8?B?SU02OVJ4b2lITUVIUjd0L1FHcUJJWnRRWldOU0FlTEd1bDA5MGIyK2tqcW4v?=
 =?utf-8?B?WnVZZjE1azZlWHVoeDVOcFVmRFdUREFzZ3BRTUsvQVBuVGRrUGZ6TlAza2dw?=
 =?utf-8?B?QlJzeVhCQUlYSDMraFZLRFhXQU81akE4ME01bjQycE1mQVdEcFhkaFB0MTFF?=
 =?utf-8?B?ZUVFUmhLdTAzTDdDbUZjbm9ha0pTcWlvMFlqc2ZFZlBaZUhsY25OWkVEc0d5?=
 =?utf-8?B?WHJSUDRtUVlRdzZDTkt3RW04QUVKc1BWYVh5NkdRRUQzT2xlb2JjS05oNVRn?=
 =?utf-8?B?dThqcjYwR0phcjVoaHlmdHREYlJuQWtBK3VVOVNJbUZybnYxUmEzODZqNW4z?=
 =?utf-8?B?RU9MUW9CVVpQNVRmTStha3NDRURPTE01NnZiUklsY0RyMXRjNEdleHU5VjAv?=
 =?utf-8?B?cWMyMlcxU01FdHRFRmEybTZDR3ZUL3hnZkdMQVpsTTVodmtueklPSHZLcXJp?=
 =?utf-8?B?QmRzQTlsYXJ3c2NkM3d5V2phN05uRkFoZ2k2NXVLVFFNS2xyL1liTk9oWHQ2?=
 =?utf-8?B?Y1RmZDdLdkE1aDUxR1pWVUFOSzJRempKUklJQXJPYzBkNFZtVGd1VzJxblNw?=
 =?utf-8?B?UFNsM2doNTQxZXU1cm15M0NJN0lXRHNiMldnek12VHVHRGlVWXFTSHVIOUhG?=
 =?utf-8?B?MDRkUHVVbXhwNGF2TmNNdThGTnI0RzlZMjBqN3MrQ2JGVnBiV1UzUlJoK2k3?=
 =?utf-8?B?cmY5KzhQL2Rxcm1MK3BGNGVnZkIrVXdmUGZZSlhReVRIZ0J3ZnZ4V0NKWUJx?=
 =?utf-8?B?M0x5NHhGekh2NFZrcEVCdFJvdTJYVWdUUVZJRGdtMEZlNW1kTHdZMWRBVURp?=
 =?utf-8?B?YzNUdjNTTVlnQXY5Z1N3Y0tLMWRqMUJLS0s5TkJFVk1UcWFQTzhtOE9EeEN1?=
 =?utf-8?B?emt3b0tYQjRxZHpxMlpWUGVWOW9oNmc3ZjJISi82NEVTaEh5RG0rdSszbzRl?=
 =?utf-8?B?ZkRROUxLME10UDQ5ODBjK2g1V3MxR2NPTWFUaE9nNnZzdU5NZStROEhQang5?=
 =?utf-8?B?V3duNDdpQ2t2RkszaFEwaFdZdUVYeDlRZXRGOWh5Mi9oUC9KR0tSVWVmNGdE?=
 =?utf-8?B?VFF5Y0dEVzhqL21CWkMyUTNpMVlmWm1lN3o5VktteEZpSFpIWFU1V1huUGdG?=
 =?utf-8?B?VVFWa1NpMGNHVC9OZWxBc1dmZnFsQ3o0Mzl1eVBXdTc4dWR5d0I4SlY2TVlw?=
 =?utf-8?B?aWtTeFZzbDNFbk15RDJxTWJlb2dwWnZjV1VnSmNwQWJvRHdyWDFPTG1QOTJH?=
 =?utf-8?B?U2k5cVRtdGxMOFovaWJNY0hjVThQcmM4Z0xyUUYxeTZ5eEY1eE1wT2N0QjdB?=
 =?utf-8?B?UXgwWVpDSlNsRk8vUWRwVUJsbjVkY05VMHpCWTRySXVEcFFTNjJIMFEwREUv?=
 =?utf-8?B?dkVNSE5lbnZMRzBFMlRXemtHbk1vVDN2Q0I4ZnA4eTZXQk5JMFZ2cnlIYVpu?=
 =?utf-8?B?VUw5eVNqQXhRV2dYRjJPbWlRbXkyY0lFWm5wdm5NOFp1dUtWTlQxRjFNK1BX?=
 =?utf-8?B?ajdXcDNlV1E5WUFOOUcrVlNQU1lLUkNyUUwzUlk5RE1UU3lub3F6RjJMSWdK?=
 =?utf-8?Q?Um44QQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1dySWM2aDgrN2hhNFVubEU2MjBNTnltdmh1MEhTaG9mVGRqcTlDcWdvWmRj?=
 =?utf-8?B?b3ZDRmtVMm9wMnJLSGVEOUQ1b0lyNXg4Yk1FZmRpQmswWUhLNlRMRUFreEpV?=
 =?utf-8?B?bTVrV29FT0NzUUxoNHZqNm12YzNEd0NtclY5ZnN3enJNMml0ZTRHOVlNakhQ?=
 =?utf-8?B?dDdFS2x2UzZWanNSeENTcitrSjJpTDJhUUJpVGxoZlBxU0MxVk1LRlRUS1pv?=
 =?utf-8?B?TmFrZk9YYmJETm1VT3pJWTU3YStHa0xoR1VNZ0tWNm5yMk9Dd21EaVArS2ox?=
 =?utf-8?B?cVFYcDZySUtiQlFjbVYzekl6c1BjaEJDQXhFZDBxS1doYnVuM1NQVjhVNjdQ?=
 =?utf-8?B?cjMxd1dub3MvSkZ1L09tRTdGL2lMTjhKOCt2QkJMNXhNcjNjRWoxeXlMcWZI?=
 =?utf-8?B?S3pZakMyclY5V1JudkFuTG5SeTYxNWZ1M1RWMHlXQld3SGVqU0JVbUxtcEVv?=
 =?utf-8?B?ODM4K2tFQkh5eXdTSGdKQS91WUxmYVNCSjhRdmZKSVhKYXkwaWVCOEZQTVgv?=
 =?utf-8?B?d0c3Vjk2bm44K3I2R0QveDBXWENMdDFlbDdrbWxFa3NGYWVuL1k3bWpicHdv?=
 =?utf-8?B?WHlld1ZyOXkzcGMrZXc0NDNralZrSjhxR3VLYzg4UDhTc05mZC9zNXpKNUpm?=
 =?utf-8?B?cCtBMkxNZVJGdU1JejVEcGpCQzBSeE1hNDhQS0dsRHZJOWExRnNWN2hWRm92?=
 =?utf-8?B?WmlWL2l2cXNEMlkwUUt4NDJNelZNNzY1Z0VxZmUxZE9sQlZWUURzTmlOVFNQ?=
 =?utf-8?B?YmdmVHNCVC91ZG4rMzdSYUNlYlhkcUlpMGlJV2dJcUwyZ2F3ODdkR1p5WEhF?=
 =?utf-8?B?a2tLVUo4eFd3REp4dWpmUXBlWEttSmNGS1ZBVEI4RnE1d2V4SGZadnhEblpq?=
 =?utf-8?B?bzhXQk9EWTZYdEdFU1A3V1B2VmtGRENzcUJXZ2p2ZTJ3ajJiVnFxVDVjWEVv?=
 =?utf-8?B?Z1BrUXhKZWh5aEhZUmpvY2VhK1IwNDBENWMrM0V5R1VmUm83emhoNjBwRUc5?=
 =?utf-8?B?aVMvVmlpNi96ZkJiZ2ZqK1ExVGwxN3Nva2RuVzB3ZVNiZGdONzgxd0VRVUtQ?=
 =?utf-8?B?THpjMWRRTk9tNnFMVHZ3cVhwa0toYWFNRkpaVzJNY0E0bU5OTGE2ZnJBdmt5?=
 =?utf-8?B?ejhvTTdqQVduT2VINUpJVDJNSEZLQkViTWJSK0RuTnJGMlRvRGhQdjZSMXdm?=
 =?utf-8?B?WmdBQTlMZVF1L1ZycVNSZGorNVphMy96M1hFaWV6Q0tuOHV4aVA1Y1N5RzVr?=
 =?utf-8?B?ZkpLR0hWeTluc21URjk5SnRKK1gvYUlWVFhXdFlzL0RmZkxlcmhSM0s3M0Mx?=
 =?utf-8?B?Z1RINjgvN2NZZ2toSXRmTERsemRqRVNGWTRzSXR3SEw3bm0yNlZpbkpLeE83?=
 =?utf-8?B?VmxIckxXN2JGNUZENU5xcWpGQkZsNjI1RzRFNi8rbGl6U085NFlrUTFSVlVt?=
 =?utf-8?B?NWpTZUNGbE9CMHp4encraU03SzAwN3kwV3lFQWxaMWlRclNULzQ2Rkx2ZDU1?=
 =?utf-8?B?TXovYi9WcmxTcEgydW8zcCt5MjBwMm5uaHFEZlBObllSSDRzRnk2a2s2Z3BY?=
 =?utf-8?B?d2FtUzkyNkkwNWhJRHNKUnBudjRUQkc3WmxRdGhDZ3U0NCtER2ZhczNaY1E4?=
 =?utf-8?B?RlRLMy9MRTVtVmRoV1d1T05ZMWlxQTZNdUx3U1dhSUhOaUVZUU1YZHhxczZO?=
 =?utf-8?B?b1o3THBLdEdSRUpVaGNXZDJKVkJIN1AzV1B5NU04cTZOek1PaTdBb0ZMTm83?=
 =?utf-8?B?UkljMmt1UDJkTmFDRGlsbk9DTTgxUStlejZSVUFTZzJGOFg1SEFJdS8rdU1M?=
 =?utf-8?B?RFJ1NG1rRnJsQmxRelNLdFFyTmR1SVJIcE4zRFBuaHBVVG1CclRmYkNKZlJz?=
 =?utf-8?B?M1VFeTZwTmJIZGY2Q3kxL3BPUlhCVFZ3M3ZTdmRpOTFFM1pGenR3ZEVnaGR5?=
 =?utf-8?B?alNEQ0MrVVpvYlhUUzRKVlRmTENLTi9CNm90WUc0SDB2eDRZMjBvWEFkNTZS?=
 =?utf-8?B?eUorYnR2dld4Rk5XQWRHcklIcVRwQyt0blFZc2xCT3g3K0l5RGsyMzcwTDFp?=
 =?utf-8?B?L3VDWlRGY01xcFFnaGl0dG9QOFI0SWJ5TFhwcUtrVTVaNFJPZjNyUXB5b3V1?=
 =?utf-8?B?OVYwSFdPSWptQTcwV1A3NFNDZ1BScmNpT2xXZXFkMjlIbE1qWnpKS1VvNWEv?=
 =?utf-8?Q?3qiu2sWBvKYHuxNOwjVS5OA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B54E0F5107B17C4E85A7F5C26D32E26F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a76db7-5f98-4e46-014e-08de1d83fde3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 22:29:46.9635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjTmS7OWSM4WrX+PPClQbvKYbi2T86xsZJQIvziCoifL8Z8RjbTqJE/TdIrJN5GSZJXJb9t+jUsMDqqMOCM0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5964
X-Proofpoint-GUID: ct7zQUjzGogNDWDw92Miec2ZQcz1nfe5
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690d2170 cx=c_pps
 a=Vharl4M+XVTaKge5CdhMZQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ALQA8Wv7axFMYHR8vdYA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: ct7zQUjzGogNDWDw92Miec2ZQcz1nfe5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX4yXE/V2G3m0M
 gbnM3/anghdj5VbQ0ghGWdsgHJMBzSefcnKEDTTyBJttFpFpn50Jkh6Ar5RFLX/Y3tGnhg/4dK/
 tPPqrimsJBu0QTeVzrBFGxKj7rJOrF8wiFMrTFkmWoDhX3hxIQIV3TrYdTwRsbp3ma5aKEeGfri
 7vEPsG+bivv8ewI00gp3kbmSRWL6uIH7PeKjATpdHx7UJoo4c1CZaOqVVi+DUQTiM0R0L/E9HsM
 VuAtdm/sEykESr9bgJJ7kin63V/+ckWlEKP0f48CrCjBRTSLFNIDmttYlnD65ms9FQK5jRtPNw+
 1pp1TPKbfPhJYtJw8XlrYX6vQ2/gPoX5gMK9OOZg/YtTyNXdccXGfUddaJl/AfjsdFtdL5tEap5
 S32l/lXj5QG86tov0YPHpyItY3X2Dw==
Subject: RE: [RFC] Why generic/073 is generic but not btrfs specific?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

T24gRnJpLCAyMDI1LTExLTA3IGF0IDA4OjAyICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6DQo+IA0K
PiDlnKggMjAyNS8xMS83IDA3OjQxLCBWaWFjaGVzbGF2IER1YmV5a28g5YaZ6YGTOg0KPiA+IE9u
IEZyaSwgMjAyNS0xMS0wNyBhdCAwNzoyOCArMTAzMCwgUXUgV2VucnVvIHdyb3RlOg0KPiA+ID4g
DQo+ID4gPiDlnKggMjAyNS8xMS83IDA3OjEwLCBWaWFjaGVzbGF2IER1YmV5a28g5YaZ6YGTOg0K
PiA+ID4gPiBIZWxsbywNCj4gPiA+ID4gDQo+ID4gPiA+IFJ1bm5pbmcgZ2VuZXJpYy8wNzMgZm9y
IHRoZSBjYXNlIG9mIEhGUysgZmluaXNoZXMgd2l0aCB2b2x1bWUgY29ycnVwdGlvbjoNCj4gPiA+
ID4gDQo+ID4gPiA+IHN1ZG8gLi9jaGVjayBnZW5lcmljLzA3Mw0KPiA+ID4gPiBGU1RZUCAtLSBo
ZnNwbHVzDQo+ID4gPiA+IFBMQVRGT1JNIC0tIExpbnV4L3g4Nl82NCBoZnNwbHVzLXRlc3Rpbmct
MDAwMSA2LjE3LjAtcmMxKyAjNCBTTVAgUFJFRU1QVF9EWU5BTUlDDQo+ID4gPiA+IFdlZCBPY3Qg
MSAxNTowMjo0NCBQRFQgMjAyNQ0KPiA+ID4gPiBNS0ZTX09QVElPTlMgLS0gL2Rldi9sb29wNTEN
Cj4gPiA+ID4gTU9VTlRfT1BUSU9OUyAtLSAvZGV2L2xvb3A1MSAvbW50L3NjcmF0Y2gNCj4gPiA+
ID4gDQo+ID4gPiA+IGdlbmVyaWMvMDczIF9jaGVja19nZW5lcmljX2ZpbGVzeXN0ZW06IGZpbGVz
eXN0ZW0gb24gL2Rldi9sb29wNTEgaXMgaW5jb25zaXN0ZW50DQo+ID4gPiA+IChzZWUgWEZTVEVT
VFMtMi94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8wNzMuZnVsbCBmb3IgZGV0YWlscykN
Cj4gPiA+ID4gDQo+ID4gPiA+IFJhbjogZ2VuZXJpYy8wNzMNCj4gPiA+ID4gRmFpbHVyZXM6IGdl
bmVyaWMvMDczDQo+ID4gPiA+IEZhaWxlZCAxIG9mIDEgdGVzdHMNCj4gPiA+ID4gDQo+ID4gPiA+
IHN1ZG8gZnNjay5oZnNwbHVzIC1kIC9kZXYvbG9vcDUxDQo+ID4gPiA+ICoqIC9kZXYvbG9vcDUx
DQo+ID4gPiA+IFVzaW5nIGNhY2hlQmxvY2tTaXplPTMySyBjYWNoZVRvdGFsQmxvY2s9MTAyNCBj
YWNoZVNpemU9MzI3NjhLLg0KPiA+ID4gPiBFeGVjdXRpbmcgZnNja19oZnMgKHZlcnNpb24gNTQw
LjEtTGludXgpLg0KPiA+ID4gPiAqKiBDaGVja2luZyBub24tam91cm5hbGVkIEhGUyBQbHVzIFZv
bHVtZS4NCj4gPiA+ID4gVGhlIHZvbHVtZSBuYW1lIGlzIHVudGl0bGVkDQo+ID4gPiA+ICoqIENo
ZWNraW5nIGV4dGVudHMgb3ZlcmZsb3cgZmlsZS4NCj4gPiA+ID4gKiogQ2hlY2tpbmcgY2F0YWxv
ZyBmaWxlLg0KPiA+ID4gPiAqKiBDaGVja2luZyBtdWx0aS1saW5rZWQgZmlsZXMuDQo+ID4gPiA+
ICoqIENoZWNraW5nIGNhdGFsb2cgaGllcmFyY2h5Lg0KPiA+ID4gPiBJbnZhbGlkIGRpcmVjdG9y
eSBpdGVtIGNvdW50DQo+ID4gPiA+IChJdCBzaG91bGQgYmUgMSBpbnN0ZWFkIG9mIDApDQo+ID4g
PiA+ICoqIENoZWNraW5nIGV4dGVuZGVkIGF0dHJpYnV0ZXMgZmlsZS4NCj4gPiA+ID4gKiogQ2hl
Y2tpbmcgdm9sdW1lIGJpdG1hcC4NCj4gPiA+ID4gKiogQ2hlY2tpbmcgdm9sdW1lIGluZm9ybWF0
aW9uLg0KPiA+ID4gPiBWZXJpZnkgU3RhdHVzOiBWSVN0YXQgPSAweDAwMDAsIEFCVFN0YXQgPSAw
eDAwMDAgRUJUU3RhdCA9IDB4MDAwMA0KPiA+ID4gPiBDQlRTdGF0ID0gMHgwMDAwIENhdFN0YXQg
PSAweDAwMDA0MDAwDQo+ID4gPiA+ICoqIFJlcGFpcmluZyB2b2x1bWUuDQo+ID4gPiA+ICoqIFJl
Y2hlY2tpbmcgdm9sdW1lLg0KPiA+ID4gPiAqKiBDaGVja2luZyBub24tam91cm5hbGVkIEhGUyBQ
bHVzIFZvbHVtZS4NCj4gPiA+ID4gVGhlIHZvbHVtZSBuYW1lIGlzIHVudGl0bGVkDQo+ID4gPiA+
ICoqIENoZWNraW5nIGV4dGVudHMgb3ZlcmZsb3cgZmlsZS4NCj4gPiA+ID4gKiogQ2hlY2tpbmcg
Y2F0YWxvZyBmaWxlLg0KPiA+ID4gPiAqKiBDaGVja2luZyBtdWx0aS1saW5rZWQgZmlsZXMuDQo+
ID4gPiA+ICoqIENoZWNraW5nIGNhdGFsb2cgaGllcmFyY2h5Lg0KPiA+ID4gPiAqKiBDaGVja2lu
ZyBleHRlbmRlZCBhdHRyaWJ1dGVzIGZpbGUuDQo+ID4gPiA+ICoqIENoZWNraW5nIHZvbHVtZSBi
aXRtYXAuDQo+ID4gPiA+ICoqIENoZWNraW5nIHZvbHVtZSBpbmZvcm1hdGlvbi4NCj4gPiA+ID4g
KiogVGhlIHZvbHVtZSB1bnRpdGxlZCB3YXMgcmVwYWlyZWQgc3VjY2Vzc2Z1bGx5Lg0KPiA+ID4g
PiANCj4gPiA+ID4gSW5pdGlhbGx5LCBJIGNvbnNpZGVyZWQgdGhhdCBzb21ldGhpbmcgaXMgd3Jv
bmcgd2l0aCBIRlMrIGRyaXZlciBsb2dpYy4gQnV0DQo+ID4gPiA+IGFmdGVyIHRlc3RpbmcgYW5k
IGRlYnVnZ2luZyB0aGUgaXNzdWUsIEkgYmVsaWV2ZSB0aGF0IEhGUysgbG9naWMgaXMgY29ycmVj
dC4NCj4gPiA+ID4gDQo+ID4gPiA+IEFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBnZW5lcmljLzA3
MyBpcyBjaGVja2luZyBzcGVjaWZpYyBidHJmcyByZWxhdGVkIGNhc2U6DQo+ID4gPiA+IA0KPiA+
ID4gPiAjIFRlc3QgZmlsZSBBIGZzeW5jIGFmdGVyIG1vdmluZyBvbmUgb3RoZXIgdW5yZWxhdGVk
IGZpbGUgQiBiZXR3ZWVuIGRpcmVjdG9yaWVzDQo+ID4gPiA+ICMgYW5kIGZzeW5jaW5nIEIncyBv
bGQgcGFyZW50IGRpcmVjdG9yeSBiZWZvcmUgZnN5bmNpbmcgdGhlIGZpbGUgQS4gQ2hlY2sgdGhh
dA0KPiA+ID4gPiAjIGFmdGVyIGEgY3Jhc2ggYWxsIHRoZSBmaWxlIEEgZGF0YSB3ZSBmc3luY2Vk
IGlzIGF2YWlsYWJsZS4NCj4gPiA+ID4gIw0KPiA+ID4gPiAjIFRoaXMgdGVzdCBpcyBtb3RpdmF0
ZWQgYnkgYW4gaXNzdWUgZGlzY292ZXJlZCBpbiBidHJmcyB3aGljaCBjYXVzZWQgdGhlIGZpbGUN
Cj4gPiA+ID4gIyBkYXRhIHRvIGJlIGxvc3QgKGRlc3BpdGUgZnN5bmMgcmV0dXJuaW5nIHN1Y2Nl
c3MgdG8gdXNlciBzcGFjZSkuIFRoYXQgYnRyZnMNCj4gPiA+ID4gIyBidWcgd2FzIGZpeGVkIGJ5
IHRoZSBmb2xsb3dpbmcgbGludXgga2VybmVsIHBhdGNoOg0KPiA+ID4gPiAjDQo+ID4gPiA+ICMg
ICBCdHJmczogZml4IGRhdGEgbG9zcyBpbiB0aGUgZmFzdCBmc3luYyBwYXRoDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGUgdGVzdCBpcyBkb2luZyB0aGVzZSBzdGVwcyBvbiBmaW5hbCBwaGFzZToNCj4g
PiA+ID4gDQo+ID4gPiA+IG12ICRTQ1JBVENIX01OVC90ZXN0ZGlyXzEvYmFyICRTQ1JBVENIX01O
VC90ZXN0ZGlyXzIvYmFyDQo+ID4gPiA+ICRYRlNfSU9fUFJPRyAtYyAiZnN5bmMiICRTQ1JBVENI
X01OVC90ZXN0ZGlyXzENCj4gPiA+ID4gJFhGU19JT19QUk9HIC1jICJmc3luYyIgJFNDUkFUQ0hf
TU5UL2Zvbw0KPiA+ID4gPiANCj4gPiA+ID4gU28sIHdlIG1vdmUgZmlsZSBiYXIgZnJvbSB0ZXN0
ZGlyXzEgaW50byB0ZXN0ZGlyXzIgZm9sZGVyLiBJdCBtZWFucyB0aGF0IEhGUysNCj4gPiA+ID4g
bG9naWMgZGVjcmVtZW50cyB0aGUgbnVtYmVyIG9mIGVudHJpZXMgaW4gdGVzdGRpcl8xIGFuZCBp
bmNyZW1lbnRzIG51bWJlciBvZg0KPiA+ID4gPiBlbnRyaWVzIGluIHRlc3RkaXJfMi4gRmluYWxs
eSwgd2UgZG8gZnN5bmMgb25seSBmb3IgdGVzdGRpcl8xIGFuZCBmb28gYnV0IG5vdA0KPiA+ID4g
PiBmb3IgdGVzdGRpcl8yLg0KPiA+ID4gDQo+ID4gPiBJZiB0aGUgZnMgaXMgdXNpbmcgam91cm5h
bCwgc2hvdWxkbid0IHRoZSBpbmNyZW1lbnRzIG9uIHRoZSB0ZXN0ZGlyXzINCj4gPiA+IGFscmVh
ZHkgYmUgam91cm5hbGVkPyBUaHVzIGFmdGVyIGEgcG93ZXIgbG9zcywgdGhlIGluY3JlbWVudHMg
b24NCj4gPiA+IHRlc3RkaXJfMi9iYXIgc2hvdWxkIGJlIHJlcGxheWVkIHRodXMgdGhlIGVuZCB1
c2VyIHNob3VsZCBzdGlsbCBzZWUgdGhhdA0KPiA+ID4gaW5vZGUuDQo+ID4gPiANCj4gPiANCj4g
PiBUZWNobmljYWxseSBzcGVha2luZywgSEZTKyBpcyBqb3VybmFsaW5nIGZpbGUgc3lzdGVtIGlu
IEFwcGxlIGltcGxlbWVudGF0aW9uLg0KPiA+IEJ1dCB3ZSBkb24ndCBoYXZlIHRoaXMgZnVuY3Rp
b25hbGl0eSBpbXBsZW1lbnRlZCBhbmQgZnVsbHkgc3VwcG9ydGVkIG9uIExpbnV4DQo+ID4ga2Vy
bmVsIHNpZGUuIFBvdGVudGlhbGx5LCBpdCBjYW4gYmUgZG9uZSBidXQgY3VycmVudGx5IHdlIGhh
dmVuJ3Qgc3VjaA0KPiA+IGZ1bmN0aW9uYWxpdHkgeWV0LiBTbywgSEZTL0hGUysgZG9lc24ndCB1
c2Ugam91cm5hbGluZyBvbiBMaW51eCBrZXJuZWwgc2lkZSAgYW5kDQo+ID4gbm8gam91cm5hbCBy
ZXBsYXkgY291bGQgaGFwcGVuLiA6KQ0KPiANCj4gVGhhdCdzIGZpbmUsIGJ0cmZzIGRvZXNuJ3Qg
c3VwcG9ydCAodHJhZGl0aW9uYWwpIGpvdXJuYWwgZWl0aGVyLCBzaW5jZSANCj4gaXRzIG1ldGFk
YXRhIGlzIGFscmVhZHkgZnVsbHkgQ09XIHByb3RlY3RlZC4NCj4gDQo+IFRoZSBqb3VybmFsLWxp
a2UgcGFydCBpcyBjYWxsZWQgbG9nLXRyZWUsIHdoaWNoIGlzIG9ubHkgdXRpbGl6ZWQgZm9yIA0K
PiBzcGVlZGluZyB1cCBmc3luYygpIHNvIG5vIGZ1bGwgZnMgc3luYyBpcyBuZWVkZWQgKHdoaWNo
IGlzIHN1cGVyIA0KPiBleHBlbnNpdmUgZm9yIGJ0cmZzKQ0KPiANCj4gVGhhdCdzIHRoZSByZWFz
b24gd2h5IGJ0cmZzJyBmc3luYygpIGlzIHN1cGVyIGNvbXBsZXggYW5kIEZpbGlwZSBzcGVudCAN
Cj4gdG9ucyBvZiBoaXMgdGltZSBvbiB0aGlzIGZpZWxkLCBhbmQgaXQgaXMgYnRyZnMgdGhhdCBl
eHBvc2VkIHRoaXMgcHJvYmxlbS4NCj4gDQo+IA0KPiBCdXQgaWYgSEZTKyBvbiBsaW51eCBkb2Vz
bid0IHN1cHBvcnQgbWV0YWRhdGEgam91cm5hbCwgSSdtIGFmcmFpZCB5b3UgDQo+IHdpbGwgbmVl
ZCB0byBnbyB0aGUgaGFyZCBwYXRoIGp1c3QgbGlrZSBidHJmcywgdG8gbWFudWFsbHkgY2hlY2sg
aWYgYW4gDQo+IGlub2RlIG5lZWRzIGl0cyBwYXJlbnQgaW5vZGVzIHVwZGF0ZWQgZHVyaW5nIGZz
eW5jLg0KDQpZZWFoLCB5b3UgYXJlIHJpZ2h0LCB0aGlzIGlzIG9uZSBvZiB0aGUgcG9zc2libGUg
d2F5LiBMZXQgbWUgY2hlY2sgdGhlDQpjb21wbGV4aXR5IG9mIHRoaXMgY2hhbmdlLg0KDQo+ID4g
DQo+ID4gPiBUbyBtZSB0aGlzIGxvb2tzIGxpa2UgYSBidWcgaW4gSEZTIGxvZ2ljIHdoZXJlIHNv
bWV0aGluZyBpcyBub3QgcHJvcGVybHkNCj4gPiA+IGpvdXJuYWxlZCAodGhlIGluY3JlbWVudCBv
biB0aGUgdGVzdGRpcl8yL2JhcikuDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgc3Rh
dGVtZW50IGNvdWxkIGJlIGNvcnJlY3QgaWYgd2Ugd2lsbCBzdXBwb3J0IGpvdXJuYWxpbmcgZm9y
IEhGUysuIEJ1dCBIRlMNCj4gPiBuZXZlciBzdXBwb3J0ZWQgdGhlIGpvdXJuYWxpbmcgdGVjaG5v
bG9neS4NCj4gPiANCj4gPiA+IEZpbmFsbHksIGlmIHlvdSdyZSBhc2tpbmcgYW4gZW5kIHVzZXIg
dGhhdCBpZiBpdCBpcyBhY2NlcHRhYmxlIHRoYXQNCj4gPiA+IGFmdGVyIG1vdmluZyBhbiBpbm9k
ZSBhbmQgZnN5bmMgdGhlIG9sZCBkaXJlY3RvcnksIHRoZSBpbm9kZSBpcyBubw0KPiA+ID4gbG9u
Z2VyIHJlYWNoYWJsZSwgSSdtIHByZXR0eSBzdXJlIG5vIGVuZCB1c2VyIHdpbGwgdGhpbmsgaXQn
cyBhY2NlcHRhYmxlLg0KPiA+ID4gDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhl
IGZzY2sgb25seSBjb3JyZWN0cyB0aGUgbnVtYmVyIG9mIGVudHJpZXMgZm9yIHRlc3RkaXJfMg0K
PiA+IGZvbGRlci4gVGhlIHJlc3QgaXMgcHJldHR5IE9LLg0KPiANCj4gU28gaXQgbWVhbnMgdGhl
IG5saW5rIG51bWJlciBvbiB0aGUgY2hpbGQgaW5vZGUgaXMgY29ycmVjdC4gSSBndWVzcyANCj4g
c2luY2UgdGVzdGRpcl8yIGlzIG5vdCB0aGUgZGlyZWN0b3J5IHdoZXJlIGZzeW5jIGlzIGNhbGxl
ZCwgdGh1cyBpdHMgDQo+IG51bWJlciBvZiByZWZlcmVuY2VzIGlzIG5vdCB1cGRhdGVkLg0KPiAN
Cj4gV2l0aCBqb3VybmFsIGl0IHdpbGwgYmUgbXVjaCBlYXNpZXIsIGJ1dCB3aXRob3V0IGl0LCB5
b3UgaGF2ZSB0byBpdGVyYXRlIA0KPiB0aHJvdWdoIHRoZSBjaGFuZ2VkIGlub2RlIGJhY2tyZWZz
LCBhbmQgdXBkYXRlIHRoZSBpbnZvbHZlZCBkaXJlY3RvcmllcyANCj4gb25lIGJ5IG9uZSBkdXJp
bmcgZnN5bmMoKSwganVzdCBsaWtlIGJ0cmZzLi4uDQo+IA0KPiA+IA0KPiA+ID4gPiBBcyBhIHJl
c3VsdCwgdGhpcyBpcyB0aGUgcmVhc29uIHdoeSBmc2NrLmhmc3BsdXMgZGV0ZWN0cyB0aGUNCj4g
PiA+ID4gdm9sdW1lIGNvcnJ1cHRpb24gYWZ0ZXJ3YXJkcy4gQXMgZmFyIGFzIEkgY2FuIHNlZSwg
dGhlIEhGUysgZHJpdmVyIGJlaGF2aW9yIGlzDQo+ID4gPiA+IGNvbXBsZXRlbHkgY29ycmVjdCBh
bmQgbm90aGluZyBuZWVkcyB0byBiZSBkb25lIGZvciBmaXhpbmcgaW4gSEZTKyBsb2dpYyBoZXJl
Lg0KPiA+ID4gDQo+ID4gPiBUaGVuIEkgZ3Vlc3MgeW91IG1heSBhbHNvIHdhbnQgdG8gYXNrIHdo
eSBFWFQ0L1hGUy9CdHJmcy9GMmZzIGFsbCBwYXNzDQo+ID4gPiB0aGUgdGVzdCBjYXNlLg0KPiA+
ID4gDQo+ID4gDQo+ID4gU28sIGV4dDQgYW5kIHhmcyBzdXBwb3J0IGpvdXJuYWxpbmcuIE1heWJl
LCBpdCdzIGludGVyZXN0aW5nIHRvIGNoZWNrIHdoYXQgaXMNCj4gPiBnb2luZyBvbiB3aXRoIEYy
RlMsIEZBVCwgYW5kIG90aGVyIGZpbGUgc3lzdGVtIHRoYXQgaGFzbid0IGpvdXJuYWxpbmcgc3Vw
cG9ydC4NCj4gDQo+IElJUkMgRjJGUyBhbHNvIHN1cHBvcnQgam91cm5hbHMuDQo+IA0KPiBGb3Ig
VkZBVCB0aGUgdGVzdCBjYXNlIGlzIHJlamVjdGVkIGR1ZSB0byB0aGUgbGFjayBvZiBqb3VybmFs
IHN1cHBvcnQuDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgSEZTKyBkb2Vzbid0IHN1cHBv
cnQgam91cm5hbCBhdCBhbGwsIHlvdSBtYXkgd2FudCANCj4gdG8gYWRkIGhmcy9oZnMrIHRvIF9o
YXNfbWV0YWRhdGFfam91cm5hbGluZygpLCBzbyB0aGF0IHRoZSB0ZXN0IGNhc2UgDQo+IHdpbGwg
YmUgc2tpcHBlZC4NCj4gDQo+IEJ1dCBzdGlsbCwgc2luY2UgdGhpcyB0ZXN0IGNhc2UgYWxyZWFk
eSBsZWFkcyB0byBmc2NrIGVycm9yIHJlcG9ydHMsIGl0IA0KPiBpcyB3b3J0aHkgc29tZSBpbXBy
b3ZlbWVudCB0byBhdm9pZCBzdWNoIHByb2JsZW0uDQo+IA0KDQpNYWtlIHNlbnNlLiBMZXQgbWUg
Y2hlY2sgdGhlIGNvbXBsZXhpdHkgb2YgSEZTKyBtb2RpZmljYXRpb24gdG8gc3VwcG9ydA0KY29y
cmVjdGx5IHN1Y2ggc2l0dWF0aW9uLiBCdXQgSEZTIHNob3VsZCBiZSBhZGRlZCB0byBfaGFzX21l
dGFkYXRhX2pvdXJuYWxpbmcoKQ0KaWYgaXQgaXMgbm90IGFscmVhZHkgdGhlcmUuDQoNClRoYW5r
cywNClNsYXZhLg0KDQo=

