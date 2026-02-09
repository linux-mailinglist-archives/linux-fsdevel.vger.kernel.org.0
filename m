Return-Path: <linux-fsdevel+bounces-76759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO1gJJVKimndJAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:59:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFEF114A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD76E302BEBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3F3806AA;
	Mon,  9 Feb 2026 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hdiUcouh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073772FE579;
	Mon,  9 Feb 2026 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670618; cv=fail; b=hbFWq+5gVF1EyNZLb02WLpfPhGAS6Ed9YsWRsE3IxAL/zFYvlTLcWUVQrCh7L1HwJ9qZeylkhEIlst1/mA5exT9dLBdKO0+iRrk/u9rII4jj8+Ka2N1SwttAYXmrSntHIFZV31jC0ZvUCRmBGDY3GmAupJCIvjEki11ZpDSypD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670618; c=relaxed/simple;
	bh=k1B3FtHIfpNWG1kRAfe1wZ6Cr7tOSwCeWyG338LpTic=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kRfmQJKmibNy9hfFqJBKayWsI0vdRwl1o58EFlAK9TjqtG4QiCrDyZt3IOh6FCnhFy3oJxTaWchuAU97VPeNVYam0WZqXm+G/Ts6dRi14AR5OmsNk+/OtNXFt6ZETVqMGjY8q2gHqg/wQWdanaKk8vr2xUTTy7CzTbht8PwNgHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hdiUcouh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619FFLhN130324;
	Mon, 9 Feb 2026 20:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=k1B3FtHIfpNWG1kRAfe1wZ6Cr7tOSwCeWyG338LpTic=; b=hdiUcouh
	f7a+GNWMM+v3YBwsLw8jOnFcXYJSkv2HfAv2DFpwLLmQVbMBvaa8KjqQL6oLWZJ+
	1BJqvcOGemKsZxw68+Oac4pfPIWuDlfnRxV5SN8AC36x71znazGtjL16yP+B0CI+
	zdNBbunVHTiBVPUgOS2MmbTPANwBB1VqsGInLT9YQk30GZJZ8Sdqv75miCjX4Hvx
	fSS2arUoRXwhSQFghhkPIRUpG6cONKv5rsqrupaZx1LLGK5yITAX2QCCatkc8C+1
	O/YbyDjbYNsuvPmp6x+9NtN28B/ZB1iPQpUbPsw+zq7Qf2UGDH5b7pYKeAeLANs3
	3yJryFCFvLzJCQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uqkj4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 20:56:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrrBJ4rEsuEILMjclJNMTkN4XtpxiMU+U8o4SaqvlHOrVILTUj2YiE3bR3qdLuaEEYreKU/i9/bps5PN7lzZfqrjAD5hinj60ddQbNeXrRXZ9jzWadIt5ZYm2tLi0Q2s5G+MjexKwFHQZiKZThzFfRZZe2BuMyrQdaLRabb6+xVLUyRGkUHEm8zFl2DKsyf9sU+Stj2Te+TcDHsuC2lU4WjaLipAA5K53E379ky46b5kV2vbgspkKOpVG2615sq44pyX7YH1GEvJWCa3Jpss6trcpzBEiKXFZ3OPo5xuwiAGyF5FseSNO4u+lCj7YUpMhQw8PsQzwujm5ujp/y5Dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1B3FtHIfpNWG1kRAfe1wZ6Cr7tOSwCeWyG338LpTic=;
 b=cs++VAPtzWzNyKIg0BIREj5IXJSmEHaIC3sOwTSGYa+skOc+7WDW6t+IQ7xCvv2mjBbemANrOLtZTqPM7GGAMwhkN9H7GrJffMEjmZileumPXXNl644ht4YfT+oKr20TRcLSQVMd84zDoH4bCrmxGVOCCULdE4975xm12iwcAa1uV9b/5CtW+2Bj791ooVQiA6wmaCxG4+p9RfJBu9N+VYkShdbkrswM9Hv2eRraPFAICRFBmSLEBsABUA9avvPws8KuOgTmcawxkjRwz0VgtauizB0YwJsO1kRSxj9MFtGorfa47EDh0m4z3Xdhn4OX7snIUxJmBUcE7FgUZQfU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPFA04B1B353.namprd15.prod.outlook.com (2603:10b6:518:1::4b9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 20:56:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 20:56:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "greg@kroah.com" <greg@kroah.com>, "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH v1 3/4] ml-lib: Implement simple
 testing character device driver
Thread-Index: AQHcmEos0SSjVp/v2kOIbbb6FIhOeLV63J6A
Date: Mon, 9 Feb 2026 20:56:47 +0000
Message-ID: <d3f051c5920d4f68c00a92845e2491003b516a1f.camel@ibm.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
	 <20260206191136.2609767-4-slava@dubeyko.com>
	 <2026020719-thrive-domain-f0c2@gregkh>
In-Reply-To: <2026020719-thrive-domain-f0c2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPFA04B1B353:EE_
x-ms-office365-filtering-correlation-id: 012a8f58-fa39-4932-6319-08de681dbd7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk94K1ZJSWZZV2dlZzlEdGY5Z2oxblg1SVJvZTdXOTVqK1FQUlJHL3dwN0w4?=
 =?utf-8?B?S2lITGJGZFozaUZKbVFOb0Z4eGpGWk1MQzVRdFQ3SHMwbkRBWjA3Zzg0aXp4?=
 =?utf-8?B?ZGNGUzNPWjV0SWhZanl6dzlKcVFZQURuQ3RKdzRLcXByR1JZaXh4bWJvZnQr?=
 =?utf-8?B?dGxCRWpDdmc1Tkk4VEJWdmtIRzFJeDJycjRKTGV6S0Vtd3M1VXBxdTFzSGVS?=
 =?utf-8?B?ejNBUGJNZ0ptRmZ4c05xeW1odTNRaTZZTndGRS85Y0ZKcGpHai9lN3FFWEVX?=
 =?utf-8?B?aExHQUErb2lQcDNYQ3VsZEtURDZ4cWtSZjJ4NHcwcDVZcmZJL0ZvSVN4YnYx?=
 =?utf-8?B?YmNXSnV3OHRnR1FPaWo0ZS91SFRZeDFuQmxHbzVqRTB5emYybmlobWI1S3do?=
 =?utf-8?B?N3ExQWhEdHF1bi81MXF3Y3J6c2JBNjVQcUJES2lsdW9qWG05RVNHL2Z6NUUy?=
 =?utf-8?B?KzgrUVEveFVUMVlkMVZNTDd5Q2JtQ1VwQXVFdFcwQWYrM3NvSFhGN0tFVS9n?=
 =?utf-8?B?dm9vRVAySVFOcm5QT2dHVWRLTHJDSm5TcnRTT25ZejcwV1RvcjFDY2dnWWhB?=
 =?utf-8?B?dG5sL1F2a2hPZGZqbU1RUnRVTzFlZWVuSlB3RUFPemtqKzN2enAxZDlNQ3Yr?=
 =?utf-8?B?aXpSZmxra21oVnVPUFYveWNYaWpYWmdGN05DTkhUV0s0L3YyTkEvRzczNmxs?=
 =?utf-8?B?eVhSNjVCTXdUdEdlWENXYW5aME0zSjlwc0g1Q1Z1SFVPTENrMHZwVHVGbHZr?=
 =?utf-8?B?S056Nm1ac0JaWGRpb3ZrQ05yUVZZNjQ5ZVhSU1FXRXV1SDYzREdNd2ZhWWN5?=
 =?utf-8?B?c1dWV09MbWE5RXcrVnhHcEtHY0E0YlgrQmNianJjQmdYT08xSE94VTJmNXBw?=
 =?utf-8?B?cjdBZ09LQ2RkNHNJV3lQNVFHVHhOaytONVNhL0hlcEhHblFtMllrSnRrL0N1?=
 =?utf-8?B?VjhYWjJNQWlhVVh4RlJlVUZKY2RTbzEvQkxuS2cvNmpGWDFtYlJPOGxNdEFU?=
 =?utf-8?B?MnJjV1ZmOEM5cThtcG5XRE1VeTVoUUMzSHZRWXFKRTE4MndoRnY2Zk1tSncy?=
 =?utf-8?B?eitVZUx5YVppaW9lWmRpOTRPZDBrK3hrTGVxY1hGZXozSFZoZmpWVWd6ZXZ0?=
 =?utf-8?B?UGEzMlFnRStpV0tHZURxL1hnS29SQkxxa0hnVDkyaUwrZHk2aGJ3K2RRZE5D?=
 =?utf-8?B?QTRjVVZ2eDg3T0loZ1ZxcFhqVW43SkpybWZqRVYwVEdVNmRyNndoUjFyN2xm?=
 =?utf-8?B?ZVhMOW51ajMvYnJITkJKeUlzd0cydWtPUWFPNTUzcE0vcDhGSjk3OTFFZ2tt?=
 =?utf-8?B?SU5Lenl1L09ONEVCQXJKbTZVSGs3N0pBS1BjOHh0MW9EcU1XZHNQN2syMURp?=
 =?utf-8?B?M0YrK2o5L29EbXVtWFYrRTgrK3pHLzFaTG1pUFdmM2pIM1RuSnVaUEF3UkNP?=
 =?utf-8?B?amJqeXJRaXhuOERYbFpjQXJFNkdlZzJ4d1J6Y0JKVGovT1lETmQ0cTVsRzNI?=
 =?utf-8?B?T3FkNFBJblBHeGZUREhlVG9KTG8yMm5FRUJBVUxoTWVIaU1PVkpMQ0dMb0JH?=
 =?utf-8?B?VzJ2ZnduR2UvaEpXMWNyRWh6NCs5Zmlpb25zcTVHN215QjZzNkY4bzdidEVm?=
 =?utf-8?B?b3BTUzNDc1k5YXd2NGZyZG53QTUvQVpPbUtKSFlzazFzMzRLTEUwVTJiRXpn?=
 =?utf-8?B?OHRYbE5yUEF4b1g5Z2RnZkJOWTA0cHp0cHFrSjRiSkpnQ21qOHdGVFZCQjBD?=
 =?utf-8?B?Zm1hODRueGljOXNEc3JTVlRUaUdjTUF4L2Z5NGxUS3FuTGNyV2ZZVXkrSFhk?=
 =?utf-8?B?YVczKzVCdnI4cFZEL3d4SlFwOUt3eFpoc3NaYkhyRFBPcmJPa3AyR0N6Q0h1?=
 =?utf-8?B?MTg4NFpqcXJDcjVoOXk2bWYreURJM1plMVJZZGNYdE9ranlMV2tzVGprcWY1?=
 =?utf-8?B?SnJuNld4WWdBeDZXMWE4NkVEWUYzNUoxNDc0dnlPQ0E0ajIyMWJVUStnVU5i?=
 =?utf-8?B?YzBaaHM4NkJ0NERjSmVmRXRzNmJ4enJmQjVLS1dQeXQvczZtR2hldTBVZFpE?=
 =?utf-8?B?alpPUXVZM200ZXpXWXBFOWp6RHRVTWRvdmtrUFFIcmdNNytNOTZWMHlGRlAx?=
 =?utf-8?B?Zm1Fc1N5RkdFZVJjT3ZGb0F4S3p2aStuM2NKU1FMQmxsci8vbitESDVXT285?=
 =?utf-8?Q?mQvf+yd6IVOfy1M8gVCHolI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0JpM2NZM3VsRHN3a2wvSUV0ZW9ITXN1NXdHVFZUdHRTZHkvSmJoeWZLUjZl?=
 =?utf-8?B?d3JWRzFyR0NSYjRYME8zS1dBc3dUWnZzQWp0L0VySWFxVUFQR1VYM0VUbWhz?=
 =?utf-8?B?bnI2WklIUENyRVpKb0d4bGJBclBYRDA1ek5TRXRSVGg3OURYTU9iS2swSGlh?=
 =?utf-8?B?K0Y0QkVMTTgvREpORFRLUmVlbjNRQTArZlZZZ2dXM2c5Y0srN016ZkRJK0lF?=
 =?utf-8?B?K0djWi92dUlKb1gyNU84RDc4SXpuL29NcThncm1kek5aLzdLemhQVUV1VkZl?=
 =?utf-8?B?VUl4Rkc5amQ1T1hnMjhhOVpqbHlnQTZ0dFJobEh2S1Y0M1RXQkxpd3JGU2VT?=
 =?utf-8?B?UW1CNm9oZ3QvdjB3TDdXTnZYakRjdkxNSll3MHhhMGR4YThiVkRGclRzeUFr?=
 =?utf-8?B?dHRrWnNiY29LSU9jZGIxTUlocDE4dGI1OE9hNXE0WEt5UmRRK1BES20rbWFw?=
 =?utf-8?B?NFZ4bnZBSHJ3V0dTMmhjTjFTelZ5Nm5LWTJwN21BL25kWXV3U1VPakFpek15?=
 =?utf-8?B?TFVGaFI3am4reG1OdTM1UGU3Q1NGZkprQVhqejBCUS9NdWE2Q0ZqMlBRUzV2?=
 =?utf-8?B?MHF4NVJTZDlYREg4c2pJaktDWFhnRjRSRjdmdkRaUmFxMTNFWWk3UWRKLy9I?=
 =?utf-8?B?Rm4rZmYxZ2kwSHlZQTF3N0J3NkJBdCtyZFoyWHc0MmswbDVFRW1ZLzlSUC9E?=
 =?utf-8?B?cDdQbGVPQnpzTkRuelNjalMyQVROd1VJWUZORGE2a0M1RVVIV2ZFVDJlMWN0?=
 =?utf-8?B?aWhTdWNqakswcGVWWGpPOTVqQ2tBQ0laZWZtTXZYTjZoU2x3dm80TlZwc0Q3?=
 =?utf-8?B?UFc5cm83NDl4ZVVkSkVBNkpGUGVpVFd1NmJWTXNMQTZIQTJkWWlVZkM3K25o?=
 =?utf-8?B?SXhDMWJmemJDK0Z6Y0FvWWV4ekZDWTFDMWRNS1k0WkJqelBKVWUvSVlUTjM4?=
 =?utf-8?B?MGZXM0pWZExWTkhZQ1JMdy9JTWRpZ3RqWGw1d2hGNWJpNGc4enhqcFZaUzNV?=
 =?utf-8?B?N0xZUGZyanBrMGJiQk5nZ2dZNWYveUtQb1NGMUdkL1VVbjZ1ZDRtYk94QkVD?=
 =?utf-8?B?b3ZtUzY3dDVHaHBoYnV2eUF0VEZWOWIzYUk1MHgzNjJ2N0Fqem81RnB1clVU?=
 =?utf-8?B?SjhMU1JiTkgzOTBIQ0FGQTl4dUYvRGhoMkV3cXhUMG85NFRrWkFCeHRFZDFB?=
 =?utf-8?B?OHVPZzNZWkFSVHozY283OC9oaE5odzRSVnJGZFMybFgzS213S2gza2Y0bkIz?=
 =?utf-8?B?ejBzVnNRV1QxTDVwSkFUVGNYTFpyVDR3OEFsbFhpMDM5SXBJVGMzM1RFOFJy?=
 =?utf-8?B?clo1MjRPVTBhekFTL2ZNRzBWWVQ1cVJPaFlKbmRyajlmZWxzSGE1Y1lFeVFW?=
 =?utf-8?B?a3NIQUNRYmJCNUc2ejB0NUZoa1BRSjM1VlJ0T3JrWGd1dmo4TTlDejZoYXhZ?=
 =?utf-8?B?cktLc2l0WEZUWDR2NWU2cGxzcVpZQVB4L2RXakZWdkxRVFFhYWdPSnJhYlE1?=
 =?utf-8?B?MlFtQ1JtVG1QZ3ZrcE55M2lFN01UelpxUG8rdVZBSUxPSDFBdFI0TnowL21r?=
 =?utf-8?B?TEtJMjJrMGQrakZtU21wVlkyaTV5akE5S0ZZQ0I5RVlLYXB3d1V0MGFFaFZN?=
 =?utf-8?B?Zi91TU9GYlRmblZNcEdIOFBXOXBUdlY2eTdxWHNUNS9jTW9RZStkaEw3SUJG?=
 =?utf-8?B?cEFaalpkL3IwNGovc3pycE13SE1mQzVDeXI2UUpRaHY3S2lMSWRoVFZ5RG5R?=
 =?utf-8?B?UUp0V1dkNGdMeWlkby93K1A4NmJjOW5ORlFxREpoazhNbDZiR0RLdEJiUHl2?=
 =?utf-8?B?TjQvYXJPY2VzY1BNc2F6cjdiZEZhUlpEVWp2VDk0UWVFNU1VcUFJazlsbldR?=
 =?utf-8?B?b3A2akVqSVRmSUFyRlNrcm84eXdkekpLK283Snp6cDlXdEc0K2FkNnlENjBN?=
 =?utf-8?B?YVBhek5PTC95Y2NUVi9lZ21XK2htWlhURjQxMVBXS2NxeXhHMHdOTjNubHc4?=
 =?utf-8?B?QUpNaHpad0pBUjlId09iWDRJQ1pDTFA1ZmdqcUZwQUxlOUVldjZFcitSWW9B?=
 =?utf-8?B?SHJkZzFmQnFiQnlScFR6elRsRFZ1elowN1Q1WEIycWVmK1VJTmtzKzljTGtD?=
 =?utf-8?B?djV5SXhYL0hqSjYwQlhuNG5QUHdIMEZ5elpMbEFuOVNQSTQ1M3JDdFpWRmY3?=
 =?utf-8?B?QldYQjhTVFVndFUvR2Y4THdKdFVyLzl1TGtMQ3ZqbHFQNVFSQzZKaUo1aVJ2?=
 =?utf-8?B?MkZTT3lRVHkzYVB3VVl2VlhYc0gxcTV0OVdxKzhxZmFzSXhNZUViVFJ5dElh?=
 =?utf-8?B?bFVTdTBiV2hXSTVIZTlBMWNwMjJPQmEwMFlHaDFBK2hKcyttYXppendiSDVR?=
 =?utf-8?Q?skShO9BSp8vsZaGHh8Yzxra7FOgUyWOp7yijP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C799914920FF724E844FE42F648B10FB@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 012a8f58-fa39-4932-6319-08de681dbd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 20:56:47.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yrf744E/LBTGjTAYSgPSzDv5KeJYEGz/Yc9UqZAZHYIzMbq8hA5Q9xmRBZv8BPNdVSvSabgKDiu1wsydo70ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA04B1B353
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfXxptLBe5p9Xeh
 Td9vPzvyF+k20HOxXUT8q6alwUZG79k0uRmerP2CxrDTPqWhBCtw9KXtB2aeZ8OE/yRnGM6ID8O
 mi2ty62z1Xy0VtCLAf3EDRkDOXs7Uzdnz9eOwvPk5YqpkL88dqjEogTBGcOpW31qh4HVhLPKwE2
 fHPVc3F2RRj9pPh6hmjLFOX+6NQfG1O0FouS0YH6PMZFhp83Ie0oViGWfmUQl+YSOsatTNA/EBW
 Tv5daiKGkX9AubthWDv9FWT4EkYse4Diu4Va1PFRZbgrYH5t017NsYAeAjsJeRqUtcWjgawJrOq
 KwRj6Qd4x86sM+4lOrj4gAdRPHuJ/++dQCrLFDxbKaX11Zcxs1+Hiy7BMGahldictGar+I35zLu
 3pZHBgJjfyT+PxTIUafbWOZp9xrgXEkmI13NVSOQCYxPd6DIOqFKM6q6zb67/Teh0fDcr8vipTN
 vLp0zM0brl+S78uksVw==
X-Proofpoint-ORIG-GUID: VCfE44vWW3XKOi-wXD_RLUPslxrWNiwh
X-Proofpoint-GUID: VCfE44vWW3XKOi-wXD_RLUPslxrWNiwh
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698a4a12 cx=c_pps
 a=fq9WP/vNXoxpaIAZvvUcmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=wCmvBT1CAAAA:8 a=kbvEEr2ZjCnUHBvhssgA:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
Subject: RE: [RFC PATCH v1 3/4] ml-lib: Implement simple testing character
 device driver
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76759-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3DFEF114A96
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTA3IGF0IDE2OjU1ICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBG
cmksIEZlYiAwNiwgMjAyNiBhdCAxMToxMTozNUFNIC0wODAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gSW1wbGVtZW50IHNpbXBsZSB0ZXN0aW5nIGNoYXJhY3RlciBkZXZpY2UgZHJp
dmVyDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBk
dWJleWtvLmNvbT4NCj4gDQo+IEl0J3MgaGFyZCB0byB0ZWxsIGlmIHRoaXMgaXMganVzdCBhbiBl
YXJseSBhcHJpbC1mb29scyBqb2tlIG9yIG5vdCwgYnV0DQo+IGlmIGl0J3Mgbm90Og0KPiANCj4g
PiArIyMjIENoYXJhY3RlciBEZXZpY2UgT3BlcmF0aW9ucw0KPiA+ICstICoqT3Blbi9DbG9zZSoq
OiBEZXZpY2UgY2FuIGJlIG9wZW5lZCBhbmQgY2xvc2VkIG11bHRpcGxlIHRpbWVzDQo+ID4gKy0g
KipSZWFkKio6IFJlYWQgZGF0YSBmcm9tIGEga2VybmVsIGJ1ZmZlcg0KPiA+ICstICoqV3JpdGUq
KjogV3JpdGUgZGF0YSB0byBhIGtlcm5lbCBidWZmZXIgKDFLQiBjYXBhY2l0eSkNCj4gPiArLSAq
KlNlZWsqKjogU3VwcG9ydCBmb3IgbHNlZWsoKSBvcGVyYXRpb25zDQo+ID4gKw0KPiA+ICsjIyMg
SU9DVEwgQ29tbWFuZHMNCj4gPiArLSBgTUxfTElCX1RFU1RfREVWX0lPQ1JFU0VUYDogQ2xlYXIg
dGhlIGRldmljZSBidWZmZXINCj4gPiArLSBgTUxfTElCX1RFU1RfREVWX0lPQ0dFVFNJWkVgOiBH
ZXQgY3VycmVudCBkYXRhIHNpemUNCj4gPiArLSBgTUxfTElCX1RFU1RfREVWX0lPQ1NFVFNJWkVg
OiBTZXQgZGF0YSBzaXplDQo+ID4gKw0KPiA+ICsjIyMgU3lzZnMgQXR0cmlidXRlcw0KPiA+ICtM
b2NhdGVkIGF0IGAvc3lzL2NsYXNzL21sX2xpYl90ZXN0L21sbGliZGV2YDoNCj4gPiArLSBgYnVm
ZmVyX3NpemVgOiBNYXhpbXVtIGJ1ZmZlciBjYXBhY2l0eSAocmVhZC1vbmx5KQ0KPiA+ICstIGBk
YXRhX3NpemVgOiBDdXJyZW50IGFtb3VudCBvZiBkYXRhIGluIGJ1ZmZlciAocmVhZC1vbmx5KQ0K
PiA+ICstIGBhY2Nlc3NfY291bnRgOiBOdW1iZXIgb2YgdGltZXMgZGV2aWNlIGhhcyBiZWVuIG9w
ZW5lZCAocmVhZC1vbmx5KQ0KPiA+ICstIGBzdGF0c2A6IENvbXByZWhlbnNpdmUgc3RhdGlzdGlj
cyAob3BlbnMsIHJlYWRzLCB3cml0ZXMpDQo+IA0KPiBBZ2FpbiwgdGhpcyBpcyBub3QgYW4gYWNj
ZXB0YWJsZSB1c2Ugb2Ygc3lzZnMuDQoNCk1heWJlLCBJIGFtIG1pc3NpbmcgeW91ciBwb2ludC4g
QXJlIHlvdSBhc3N1bWluZyB0aGF0IEkgYW0gZ29pbmcgdG8gc2hhcmUgaHVnZQ0KcGllY2VzIG9m
IGRhdGEgYnkgbWVhbnMgb2Ygc3lzZnM/IElmIHNvLCB0aGVuIEkgYW0gbm90IGdvaW5nIHRvIHVz
ZSBzeXNmcyBmb3INCml0Lg0KDQo+IA0KPiA+ICsJLyogQWxsb2NhdGUgZGV2aWNlIG51bWJlciAq
Lw0KPiA+ICsJcmV0ID0gYWxsb2NfY2hyZGV2X3JlZ2lvbigmZGV2X251bWJlciwgMCwgMSwgREVW
SUNFX05BTUUpOw0KPiANCj4gRG9uJ3QgYnVybiBhIGNkZXYgZm9yIHRoaXMsIHBsZWFzZSB1c2Ug
dGhlIG1pc2MgZGV2aWNlIGFwaS4NCj4gDQoNCkl0IGlzIG5vdCByZWFsLWxpZmUgZHJpdmVyLiBJ
dCBpcyBvbmx5IHRlc3RpbmcgZHJpdmVyIHdpdGggdGhlIGdvYWwgdG8NCmNoZWNrL3Rlc3QgdGhl
IE1MIGxpYnJhcnkgaW5mcmFzdHJ1Y3R1cmUgYW5kIHRvIHNob3cgdGhlIHBvdGVudGlhbCB3YXkg
b2YgdXNpbmcNCnRoZSBNTCBsaWJyYXJ5Lg0KDQpBcyB0aGUgbmV4dCBzdGVwLCBJIGFtIHBsYW5u
aW5nIHRvIHVzZSB0aGUgTUwgbGlicmFyeSBmb3IgdHdvIHBvdGVudGlhbCByZWFsLQ0KbGlmZSB1
c2UtY2FzZTogKDEpIEdDIHN1YnN5c3RlbSBvZiBMRlMgZmlsZSBzeXN0ZW0sICgyKSBNTC1iYXNl
ZCBEQU1PTiBhcHByb2FjaC4NCg0KU28sIHRoaXMgZHJpdmVyIGlzIG9ubHkgdGVzdGluZyBlbmdp
bmUgb2YgaW1wbGVtZW50aW5nIGFuZCB0ZXN0aW5nIHRoZSB2aXNpb24gb2YNCk1MIGxpYnJhcnku
DQoNClRoYW5rcywNClNsYXZhLg0K

