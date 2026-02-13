Return-Path: <linux-fsdevel+bounces-77188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FxqGZOpj2mZSQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:45:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337F139D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C6873009806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED692FD1B3;
	Fri, 13 Feb 2026 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S5btkJNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285C214204
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022733; cv=fail; b=KMFtAzoHgqOI1VHVGjIBUw+LBNoWIIEun1Jf/OSVNBtJUWALgs3wLyJCtR93ZYs05HOAh1OvDS4fqdH9p5c27IdMY5KKJv2rDIYnFqZVIAWIQZuLqszOlu4rPKnyejjoZR5xSWm1+xhapGTtrfF6W+snku1/PHGi6x1qvmzNJgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022733; c=relaxed/simple;
	bh=ufaTcuQ6RhZoHl5r3w0OE+Hejjnu7oaWabWNZfi7eec=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=uxjoQWRa2/HCIOK21CzSXxQyJsVF/2ikhQ17AXyek0cX3I8mQR6q/jJ3wtKSyz0MWYDpaO/UF+3wxwUBiF0YTlFSsD81T6YkF+e/MsMZogkLKgh6UFD9wNARdZts7wkq+fAGLwWadkwZ2uV0hsQT1lcDvV//aM6IJ2BIl3WDLLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S5btkJNC; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DLYE7A145954;
	Fri, 13 Feb 2026 22:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ufaTcuQ6RhZoHl5r3w0OE+Hejjnu7oaWabWNZfi7eec=; b=S5btkJNC
	KKdcZjm5Rg8mH3083cIdkLcUce6SFe78iHHds+cuztoknOFLhEg8uPDI3YmiHEZh
	uln3G93YL6H/blD5QpTYCjLjbhbkeWFlJHTE0JsIIXsmBTvV7cRVUJeA2MW4JA3x
	CuT5V+dyzT5X09zKq6EdsGq9BzSGlBdhYuURhIEUrUPdbefFI01KYywCI44lR09o
	KZFwTl2xBzHqsKsHGOi3fvC70lEBzc4F5GxRiC82V838+RST60Hat/WZjLUClObW
	f/e9wA8ee4obzIegl4hsD6X+rUaz2KGEkJPCk7sqvtFDUQHPHzkh1ix16RuqSYgn
	Q11jyNgq52qZ5Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696xa3nk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 22:45:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRwqBt0YmgbpFmV4ueeI0tkJgeJaV/9dT+BT7im8lw8Z5WM8vgeN82Z7n5Z7nsAWatjfUeNdJESXwUOTUq2FclgggTZuU/ltpu9CjjDGwJtzEiHobXo3ofNXbLkAPG/97DaDabPFbFhJxEbnvPJTbwiIuePyHA+1k23sITOqG+95sBt18Wg+LClQcJ4CMFn9XuQeiMykdvwUUdgINTqdqGmojrc6vcgsQo+kCwrh2bpl1QuOuy/YhTIsOr1ZkxSZU4QZEe42e0kGno/yaDGrz3UCaLqj6w7L7egxO0akyi00wDm38JWDy1MBHDmzu72+qKm6r7uM+mLitXwjv3aqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufaTcuQ6RhZoHl5r3w0OE+Hejjnu7oaWabWNZfi7eec=;
 b=WFGcGTlqkh3VKectHeHYTw2LdaZEAifFdPZTPvcXfj0ewTsRswmHzHpLykubBWA0Blah9SFDHTW7b7ieNjwe/GfJp2Ggba/k6A19sP671WNOjekpl8VgBVW6lrMWIAp6+3SpyvVnutORtmjoKCLkFXcIF8KrseBHMCC+4KIXgIouCRchU0rvv08zIFCqPyaq11M5qAb30VtvkGH6svopxn6W+mCdI8hcQu/XJzOKBRTzI7YgTkAIyhhzJv0JgEInVv/5q9cGYqmsfCKfzb0R1OnjyiYBhMwT7CEFwOoDzqmQXYYLqZ+fS1nBe0tCmxUVjvKY225hYeW2MfFqbxtmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6008.namprd15.prod.outlook.com (2603:10b6:208:456::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 13 Feb
 2026 22:45:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 22:45:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: evaluate the upper 32bits for
 detecting overflow
Thread-Index: AQHcnCNRSqmOvktJcEm/ltcoFQArFLV/mx8AgADVPgCAAMw5AA==
Date: Fri, 13 Feb 2026 22:45:21 +0000
Message-ID: <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
	 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
	 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
	 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
	 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
In-Reply-To: <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6008:EE_
x-ms-office365-filtering-correlation-id: 7be2b862-d087-4824-0a43-08de6b5191b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWlReVFGYlNRMkVVdmJMRDJuWnhDNDFHeGxLeWgvL2RnUERPYnpOQ2VPTi9F?=
 =?utf-8?B?QmZkZk4wSUgwcktMalZ0em1hYW14RFZtK2dYWml2SGtTQVBLSmsxbHRjcmNo?=
 =?utf-8?B?MDdHUDFqTmtha1Q5YkVHVUNFVUZHSUFNRnVBRGJSR3VUQ3IyRzlTWFBZaXhq?=
 =?utf-8?B?WE10STNJL0F1Ukw2MitUUDNKbEpmN0N3TWo5R1RQVGRCT2JpSlB4amV1WlU4?=
 =?utf-8?B?cWNDL3Q3M3I0Z3NsTnd0T1o3aDJHa2tGekVNR3l0QVdQeExzQndQWjFNU1Fq?=
 =?utf-8?B?MGxNTytnWlhEaCtYeHIyckh3dHRyd0c2M1JvVURqb2ltVVZlNURZMDZEMk51?=
 =?utf-8?B?UkEvZnovakY1dlU0b2ZSTFVxTnNzUlhzZGVxNXVCWDlpN1hmZzRPdytHTEha?=
 =?utf-8?B?aTlycnhpZEdudHNrOEwxVHpicld5MG02UVRDSE14SnJoUmIxdU9nZkZHZ3Iv?=
 =?utf-8?B?RlJPSHZJaDA0NTc4WG9qVEtkaE5pRnFQcFlLdll2UnlZNXo2OUFoWm1GZ05a?=
 =?utf-8?B?UEZBYlhOc1c2M0lpdVZBSmtrWmdhOXp4Nm95ek9rV09MOUhjME1UZkFhT09C?=
 =?utf-8?B?TkZqZUx3ZUlTNHRmUXQ3S1RNaVpmWFJ2c20yVEcrMGZjUnJONnBpK29TcDZn?=
 =?utf-8?B?VkJhZ0JGWitFdVVjc0JIeElkeDhrblFXUnlhdjlOZm1ZdHJuOHlQZGRyeUFD?=
 =?utf-8?B?ZmMyR1owcnBJSGFKaUlXOHRuVHcvTDYyNWZ6WUpvU3JHTlE0eStsTGNVVElP?=
 =?utf-8?B?VWI0eHFSNzdadUU0bkZkdEpmUHV4YUdIdnExZjRJVlJsbm9BeFk5KzBvRlEx?=
 =?utf-8?B?anFucTF5NlJSWEZ6eUhuSU0xM0x3SXdQQUEydWU4NDI4YzNyUnFpRVlhS2Vj?=
 =?utf-8?B?K2hONGNsbVF6Yk5RQUlGU3dVOHJMaERWbzlTeFNxaGppMUoyUWZUWXFBTzJz?=
 =?utf-8?B?a1BLcjNvaXVrcHFpVHZ4ZVFQQVEvb3ZQV0tDQjhkZ1lsN0x4UzI1VEM3YkxE?=
 =?utf-8?B?eEp5TFgwRzRHQlQyc09QVDFiOE43bkV4bXozdEw1M2VZVU5ZUnFoSjdCb2Za?=
 =?utf-8?B?NHZ3cVVBcFBocUZaQVRjdlZ2NG1qdFVubU1xc3QyaUloMlBCc0ZpamhxYjBV?=
 =?utf-8?B?L3FWMzgzRC9YTXBUcmRvVEVMSG00WjJ6V1BBQytZMm11cTluWHgwWjV0My81?=
 =?utf-8?B?WmtXcXN0NHdzRi9YbGVRdWJTd2UzSms1eDd3U01temhzSWtURit2dEs0RDIy?=
 =?utf-8?B?ZDVzZGhZU3RRUmpqQU9zQ3FLOXJRcjdsbitIWkNhOXR1RWZTMGVXenAvMWJX?=
 =?utf-8?B?YWVMMTF0NVhuRDVpYlJpVGlIdEtSbmhTYkQwd2hYdHFXV05IN3g0bmtHc2lk?=
 =?utf-8?B?TVRnL3JmZC9EY09mZVpVd2plRmt6N1NKcFN5ZERoeUREakE1Ti95RjVwWkQ1?=
 =?utf-8?B?MVVZYVp3aFNHNlh0Z1RUM3Q0dDB5c01mZjRXTW5YY0FkK04zN0NIRXFOdHVl?=
 =?utf-8?B?emVEUHhiSDA1T0dFUGdSWFJudzEvT2R1OVplWm0welFScVNaZ3o5RlNQcEtP?=
 =?utf-8?B?NmNGa0laWTNlS2Robm5nMVhSSGFaVTBaM1cyRDljNllDRnYyVm0rb21sNzQ2?=
 =?utf-8?B?UGdXOW83TmcyTnFhRnFHeVh3dXh1WUJxNzYvTHJIcG1XNUNhR1Y0d08xRHpC?=
 =?utf-8?B?aXhlNnRHVkt0Zk95eVVBeHdWK3hYYzdkUitITTNucWJyL3JJNW5jNEdUVkR0?=
 =?utf-8?B?WEREZzh4Lzh5d1MzMlBNUlV4NXpNRjJQQzhRcCtrM1Rsci9UYkxkV3ZLNnVF?=
 =?utf-8?B?QWh3c0ZMUjkvOWlSM2I0RXNhNklEVmd6cHJxWE1Rc0wrQmlsbHFkTDE5WTR3?=
 =?utf-8?B?YzA1ZGMyNlRRYUdqMi8yWCs0WUdmbXNKRlpnMXZaU0VVM3FiUW0rdWdHc2p6?=
 =?utf-8?B?RnErMEMrUWVkZ0dLMHFMU2RNWVpSb0RSRnFEZmxWaUs3dEh4MWxwQ2pQMXdq?=
 =?utf-8?B?dE9WZmVoaC9LZEplZjF3TktDdG9lM01zT1FWaHd4QW9lOTBJbENQRU1IejA4?=
 =?utf-8?B?Z2xUVU91VzZpR0pvRUc2QytUME1HR1JaZWppQkE5RS9SUFgwR1I2VWt3N0hl?=
 =?utf-8?B?L0p1dXJmd0F3Uk9OMGNLUzlXKzNEWFZ1OTlnQnhHRXVvZmhFMkdQZUkwemFO?=
 =?utf-8?Q?pKJL0qsTb9nER22vJjjPuC4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mlh4cVhnR0M5bFUwcFNhNlRERkZpUEFrVGlFRUcyRXljS2tZR05CSFE0ZmMv?=
 =?utf-8?B?eklMQ2tuK0c5azg2WXU1QVJrUktuRndyUm1WajlySmtvRmdtUEhoTXI2V3d6?=
 =?utf-8?B?UU1UT016R2FZRzhzY0lGR2lsSFBRcm9qV3NzQzJ3YzZFam0vY2N3eUJDcWVC?=
 =?utf-8?B?WkJRR2IvTnRIM1J0NnJSZEQxc0E2QlE3WkxGcWlXaDQvYS94NkFlalVZRVgz?=
 =?utf-8?B?UW5lQit5cnNLMkRCZGQwTklIb3Iwb0pnQ1VGZjZ3UWRzWTFqMkNOVVZPVUV2?=
 =?utf-8?B?SnpYMm5LakZCdWdtdTd2MjZrMUxJVkdSL0tpVU12K2plYUVmVC81MG9rM1hr?=
 =?utf-8?B?R3Zad2ltYU9QUXVFVlRjSzJCSkRFNUVwR2RrVWU4MFFTV1RNd0lhblVpSWt3?=
 =?utf-8?B?c3FpV2ZCN3h0em1TZEhXaVZPSGZETXZKWFViQ25wSkx2elpzd3JOTnMxeXkz?=
 =?utf-8?B?RW9pYVdwTDF3aUNacFR4L0tFSDlIenVQU25sYk5QcFNTTU5RZVNjN1QrQ2dm?=
 =?utf-8?B?Z1cyV1ZOQnZzYzZWeithT09jQWRKNzJ1VytFamR0andjUFFNYXZUUmE4bEc0?=
 =?utf-8?B?Umo1dWVnMEYvOGdqbFg0cmZJeGNCMWxCZFpER0Q0U1ZoQ2NTbzNwMG5hWUtW?=
 =?utf-8?B?NG03NHpkZTg0SjhkcGNPdWRqd3J4SU0zRGZ4NHVZaDRxQjQ1RkRjODQrZUFw?=
 =?utf-8?B?WE00ZVY4OWY1aFROQWE5WHhrcmVEN1pBaUUyVW5zQTdwK25TektpampDMGM4?=
 =?utf-8?B?cGhKMUUreXBmYU04VkNrdW1wbjVZUnJjS2FhZ2p2d0s3cmJteTFjVHBQdVJM?=
 =?utf-8?B?eWcycmJvTW5LV3MyVEJ4K1M3SGJHa0UyNkJVbER6NlZEempmTkUzMHlub1ph?=
 =?utf-8?B?SnFUbkplUkZYMjJxcXFlaXhKcTZmemNMdWxsSDZHOXRuWVZuUmlYNmhzK2N0?=
 =?utf-8?B?OG1JdHBuU0NDQ0lxd21za2N0NitpdzNnY3JDblNqampybnVnUTlzMFN2VHRZ?=
 =?utf-8?B?L2NaRUNJcXRQM0tyQi9TREhaOFd1T2luUVM4dFJTSUZSYlZUYmR1NmhPcXdL?=
 =?utf-8?B?bDZUK0RqMmM2akxsSDVCSjIrbXVMdW9ILzIzUkswbDVneGY4OUVMY1VOei81?=
 =?utf-8?B?NVR6UkRiaEc0Z2hBZUNrblpXNzhYSm5DdzJRbkp3dzh4OTRsRE1BSzlSdmsv?=
 =?utf-8?B?Q1pHT01FNnNLWjJMMzBvcEEyaExnVm9ISFR1c2tVY2FCVFdYVk9OVjZjRDdt?=
 =?utf-8?B?cE9ydGtCdlhIVnJYUXZyU2hsU1o3OEFZSjcvRndqaWpqYWs0aFc4d2VNWEUz?=
 =?utf-8?B?a3F0ZU1aVDF0NEQrRUQ0UlJJRnJtT1BqMWFCZ3pHcDd5SHQzVzlDaTFTUTYr?=
 =?utf-8?B?Um1oRG5aYkFsdFhMNXRvUHR1eTBRbmxBT1R2R0dXUkd0VlFUTUJXQzV4bmJp?=
 =?utf-8?B?ZU8xZmxQQ0lDRXI2dGVQR0RmSnViaEhveXlod3N0NUtWaEpaM1A4bnJRQUw3?=
 =?utf-8?B?bGV6clo5dDV0SlZiZ3lsdGlFVHZzL3BQRElnN3FkVWNsQ3B1S0M4Y3NhSXBS?=
 =?utf-8?B?Z2VJT1c2ZEE4M2FMeDhPNFhGNFp4KzNaN2FsUFBETlVnQUQwNUhaeWVGVGhS?=
 =?utf-8?B?S0E0bUNIL2l4QUNJaVJRN1Q1SjBBWnBneGd3dnNUa000QWVJWVNSL2NuYitu?=
 =?utf-8?B?alRYQ0w5eVBsbXhyYndScFpjTEFyYU5IS0Y4YVJOSG9GbTd5Wks3NDIxRW91?=
 =?utf-8?B?U05zaVdCekxSWVVza2FWU2RydmNVaVB4TEhXYnVQQ0IyL0dmdStTenYyZkpJ?=
 =?utf-8?B?UHlrMTZ2OStxS1g3elMxbmdGY1NDUUFmWmRnYlFQWDBiVHRZYllqR0pJUzY3?=
 =?utf-8?B?Vk11VHNVQ2F3b1hHcFgrN1BLNGhyY3g5cnpjZmRjc0ZjWXNqeU5BWDNvT0JU?=
 =?utf-8?B?ejhDWS9IRVdMMFdsUDRVdDBNZ2FZSTNGNGFEQXZTRy9jNkdidTB3OFFGV2ZU?=
 =?utf-8?B?YVY1SUdpeklxOWtab243QzVXN042U3FtdEl3T3Ixc2NHK1dvb25YcUprNWRq?=
 =?utf-8?B?MDB1U0pkQXdTS1kvT2VmWEJkZmQ1cDFpdGRhVHRZbXNkM0NHL2FyaCtqemRj?=
 =?utf-8?B?T0NuRGlnUkFjdmUyVHBlRkg4N0lvUU5xMGFHZ3N0a0tUQlQ4T3dGV3FrR0JC?=
 =?utf-8?B?RzJxV3Y0Q294VVlHcHRRRXNFU0ZPY09VS25UczZjcG9yRWlJYnF0V0xsUG9j?=
 =?utf-8?B?RlFUWDRnT3pPZGdJS2djbWJXdStSMEc2bmp0ekE3emZDV040KzZvQ3M3WHVS?=
 =?utf-8?B?M1R5R2R5K2VPWUlKV2lPVURERmdsZUYzUUVqeWNwWElrVmJNWUlmdkpDbnND?=
 =?utf-8?Q?CPbxgKugdnorixpcJYbNYwxffbywjujscro8/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD812B9A08CF0A42BD868D52FBDF9D77@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be2b862-d087-4824-0a43-08de6b5191b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 22:45:21.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FM7t9ZHbNlWZU2GvSGZhxodXZj2qY8jqYT8lIRt2StCIzWe5NKySraQ6+GdzUdKHY2o9Mch2QXHXbLs115Xhlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6008
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698fa984 cx=c_pps
 a=oAmyFwY4cP9Ja8EDt9RnJg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Kk4oP9S42mGQ84ZI:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ltfgOT30QYKoxzsfqmwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _VZ8ndAJsIYdPttbPI3LzcuuZ0aLnFrx
X-Proofpoint-ORIG-GUID: _VZ8ndAJsIYdPttbPI3LzcuuZ0aLnFrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE3MSBTYWx0ZWRfX6DcQJZVq9hN0
 Dj3czCpYq/rw2zrRvtWvN4q2e0+ZSovVaOYLLZiJDCTebF+ZW5s5Etv4dAwX+efZt7YsUnlC65W
 gJjZNEZAedlFXPZmrY+ZDXxXXZNmO74CRyoJGOSTUOlbLVx64/bJzBP8NaZKaP5oQjBv7GJ4mjQ
 x0FNHbvbXwDL93h3zctzx0HUHPer+Xe2L0XT1ppidBZpxU433cUkCnu3N8bhssUNxlm/YJrAZik
 ICvzezxyj4YgvNR5WZMEl/MpqRKnyZc1ZLp1SEukc6TIXoXh/7pUbHDRr3SWtpym+ZMLW0YggGj
 Xwn24unYP8O0OjU96+u2EAYMcmCQIknjsya9u1X+mHyZ3Q7yldpvDnKMTNfV6VLg2pCKp2w155z
 PdF38CSlnhO0S4IuSptyKhoJUA7FOBgUvyPvUMeA+RT6hTDACGPAOe9o+NuduomFWG77XlKvg/V
 oWTeF7Zv5j6qL7tiMgw==
Subject: RE: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77188-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,I-love.SAKURA.ne.jp,dubeyko.com,xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8337F139D6B
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTEzIGF0IDE5OjM0ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDIvMTMgNjo1MSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyNi0wMi0xMiBhdCAyMjoyNyArMDkwMCwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+ID4g
T24gMjAyNi8wMi8xMiA3OjM2LCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gPiA+ID4g
T25seSBjb21waWxlIHRlc3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IE1heWJlLCBpdCBtYWtlcyBz
ZW5zZSB0byBydW4gc29tZSB0ZXN0cz8gOikNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEkgdHJp
ZWQgYmVsb3cgZGlmZi4gV2hpbGUgdGhpcyBkaWZmIHdvcmtlZCwgSSBjYW1lIHRvIGZlZWwgdGhh
dCB3ZSBkb24ndCBuZWVkIHRvDQo+ID4gPiBmYWlsIG9wZXJhdGlvbnMgdXBvbiBvdmVyZmxvdyBv
ZiAtPmZpbGVfY291bnQgb3IgLT5mb2xkZXJfY291bnQuDQo+ID4gPiANCj4gPiA+IFNpbmNlIC0+
bmV4dF9pZCBpcyB1c2VkIGZvciBpbm9kZSBudW1iZXIsIHdlIHNob3VsZCBjaGVjayBmb3IgbmV4
dF9pZCA+PSAxNi4NCj4gPiA+IA0KPiA+ID4gQnV0IC0+ZmlsZV9jb3VudCBhbmQgLT5mb2xkZXJf
Y291bnQgYXJlIChpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5KSBvbmx5IGZvcg0KPiA+ID4gc3Rh
dGlzdGljYWwgcHVycG9zZSBhbmQgKmN1cnJlbnRseSBjaGVja2luZyBmb3Igb3ZlcmZsb3cgb24g
Y3JlYXRpb24gYW5kIG5vdA0KPiA+ID4gY2hlY2tpbmcgZm9yIG92ZXJmbG93IG9uIGRlbGV0aW9u
Ki4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoZXNlIGZpZWxkcyBleGlzdCBub3QgZm9yIHN0YXRpc3Rp
Y2FsIHB1cnBvc2UuIFdlIHN0b3JlIHRoZXNlIHZhbHVlcyBpbiBzdHJ1Y3QNCj4gPiBoZnNfbWRi
IFsxLCAyXSBhbmQsIGZpbmFsbHksIG9uIHRoZSB2b2x1bWUuIEFzIGZpbGUgc3lzdGVtIGRyaXZl
ciBhcyBGU0NLIHRvb2wNCj4gPiBjYW4gdXNlIHRoZXNlIHZhbHVlcyBmb3IgY29tcGFyaW5nIHdp
dGggYi10cmVlcycgY29udGVudC4NCj4gPiANCj4gPiBBcyBJIHJlbWVtYmVyLCB3ZSBhcmUgY2hl
Y2tpbmcgdGhlIGRlbGV0aW9uIGNhc2UgdG9vIFszXS4NCj4gPiANCj4gPiA+IFRoZXJlIGFyZSAt
PnJvb3RfZmlsZXMgYW5kIC0+cm9vdF9kaXJzDQo+ID4gPiB3aGljaCBhcmUgYWxzbyBmb3Igc3Rh
dGlzdGljYWwgcHVycG9zZSBhbmQgKmN1cnJlbnRseSBub3QgY2hlY2tpbmcgZm9yIG92ZXJmbG93
Ki4NCj4gPiANCj4gPiBJdCdzIGFsc28gbm90IGZvciBzdGF0aXN0aWNhbCBwdXJwb3NlLiA6KSAg
SSB0aGluayB0byBoYXZlIHRoZSBjaGVja2luZyBsb2dpYw0KPiA+IGZvciByb290X2ZpbGVzIGFu
ZCByb290X2RpcnMgd2lsbCBiZSBnb29kIHRvby4NCj4gDQo+IFdlbGwsIEkgY2FsbGVkICJzdGF0
aXN0aWNhbCBwdXJwb3NlIiBiZWNhdXNlIGluYWNjdXJhdGUgdmFsdWVzIGRvIG5vdCBjYXVzZSBz
ZXJpb3VzDQo+IHByb2JsZW1zIChzdWNoIGFzIG1lbW9yeSBjb3JydXB0aW9uLCBzeXN0ZW0gY3Jh
c2gsIGxvc3Mgb2YgZmlsZSBkYXRhKS4NCj4gDQo+ID4gDQo+ID4gPiBPdmVyZmxvd2luZyBvbiB0
aGVzZSBjb3VudGVycyBhcmUgbm90IGZhdGFsIGVub3VnaCB0byBtYWtlIG9wZXJhdGlvbnMgZmFp
bC4NCj4gPiA+IA0KPiA+ID4gSSB0aGluayB0aGF0IHdlIGNhbiB1c2UgMzJiaXRzIGF0b21pY190
IGZvciAtPmZpbGVfY291bnQgLyAtPmZvbGRlcl9jb3VudCwgYW5kIGNhcA0KPiA+ID4gbWF4L21p
biByYW5nZSB1c2luZyBhdG9taWNfYWRkX3VubGVzcyh2LCAxLCAtMSkvYXRvbWljX2FkZF91bmxl
c3ModiwgLTEsIDApLg0KPiA+IA0KPiA+IFRoZXNlIHZhbHVlcyBhcmUgX19iZTMyIGFuZCBpdCBt
ZWFucyB0aGF0IFUzMl9NQVggaXMgY29tcGxldGVseSBub3JtYWwgdmFsdWUuDQo+ID4gVGhpcyBp
cyB3aHkgYXRvbWljNjRfdCB3YXMgc2VsZWN0ZWQuDQo+IA0KPiBhdG9taWNfYWRkX3VubGVzcyh2
LCAxLCAtMSkgaXMgYXRvbWljIHZlcnNpb24gb2YNCj4gDQo+ICAgaWYgKHYgIT0gLTEpIHYrKzsN
Cj4gDQo+IGFuZCBhdG9taWNfYWRkX3VubGVzcyh2LCAtMSwgMCkgaXMgYXRvbWljIHZlcnNpb24g
b2YNCj4gDQo+ICAgaWYgKHYgIT0gMCkgdi0tOw0KPiANCj4gLiBUaGUgdiBjYW4gYWNjZXB0IFUz
Ml9NQVggYXMgbm9ybWFsIHZhbHVlLg0KPiANCj4gQmVsb3cgaXMgd2hhdCBJIHN1Z2dlc3Q7IGRv
bid0IGZhaWwgb3BlcmF0aW9ucyBpZiBjb3VudGVyIHZhbHVlcyBmb3IgZmlsZXMvZGlyZWN0b3Jp
ZXMNCj4gb3ZlcmZsb3dlZCwgaW5zdGVhZCBsYXRlciBzdWdnZXN0IGZzY2suaGZzIHdoZW4gd3Jp
dGluZyB0byBtZGIuIFRoaXMgaXMgYSBoZXVyaXN0aWMNCj4gYmFzZWQgb24gYW4gYXNzdW1wdGlv
biB0aGF0ICJsZWdpdGltYXRlIHVzZXJzIHVubGlrZWx5IGNyZXRlIDY1NTM2KyBmaWxlcy9kaXJl
Y3Rvcmllcw0KPiB1bmRlciB0aGUgcm9vdCBkaXJlY3RvcnkgYW5kIDQyOTQ5NjcyOTYrIGZpbGVz
L2RpcmVjdG9yaWVzIHdpdGhpbiBvbmUgZmlsZXN5c3RlbSI7DQo+IGluIG90aGVyIHdvcmRzLCAi
b3ZlcmZsb3cgb2YgdGhlIGNvdW50ZXIgdmFsdWVzIGlzIGxpa2VseSBhIHNpZ25hbCBmb3IgYSBm
aWxlc3lzdGVtDQo+IGNvcnJ1cHRpb24gKG9yIGZ1enogdGVzdGluZykiLg0KPiANCj4gDQoNCnR5
cGVkZWYgc3RydWN0IHsNCglpbnQgY291bnRlcjsNCn0gYXRvbWljX3Q7DQoNClVJTlRfTUFYIGlz
IDQsMjk0LDk2NywyOTUgKG9yIDB4ZmZmZmZmZmYgaW4gaGV4YWRlY2ltYWwpLg0KSU5UX01BWDrC
oDMyLWJpdCBTaWduZWQgSW50ZWdlcjogUmFuZ2VzIGZyb20gLTIsMTQ3LDQ4Myw2NDggdG8gKzIs
MTQ3LDQ4Myw2NDcuDQoNClNvLCB5b3UgY2Fubm90IHJlcHJlc2VudCBfX2JlMzIgaW4gc2lnbmVk
IGludGVnZXIuDQoNClRoYW5rcywNClNsYXZhLg0K

