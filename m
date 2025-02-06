Return-Path: <linux-fsdevel+bounces-41041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF2A2A376
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6586C167709
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081F224883;
	Thu,  6 Feb 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="aDumC1pQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC01FCCE1
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831608; cv=fail; b=ukYZkX7mK3Csr1qVgvZZYgehle2dWDd+IEKXOxBQq9ABdE8lAy25hOdzwD7yvgpbva3VYiGO7XoztRmVdi6hHX6yjWoifznUO5r4niXrg5WCnm1LCX7muTj3o4SP/nMUWQqG2W49MgWBu6ofXRMpLrYEavwagkrWpDc4AwUERkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831608; c=relaxed/simple;
	bh=e+kK5JBTd3R5jUr2IpI88fSdpiSG1mzGaoCrYmzm1Z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t0aFZaxAIDQHOg8lB9NLELkZVy4MEgXiJlgGruJmYi6oC2MNheqDVsyZCm7+/8Bgcjriy7jYzeerwWk5bC6FTZF0LcKM9RqqD9J4YKn2NLRf9OZ0p7Zfz0mpjGwOb13YCd13PZqVlKsq+MmM0y7Rl/0hJ7HJNM1m6isJ7p7bbN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=aDumC1pQ; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5165X0n3005278;
	Thu, 6 Feb 2025 07:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=e+kK5JB
	Td3R5jUr2IpI88fSdpiSG1mzGaoCrYmzm1Z0=; b=aDumC1pQdES9N+lp94++2pq
	UMFa9EJU+9FnPnUWSCXUHtizQCESXIvx0qstSNU/4Os8GAWLUat5cx8FO4j0IhB4
	P8ben9oZLnwNeu/nD4a79yjerZF2CyZMa0mAEei/qLDTTGb8QaaxMigABf4wbHUe
	HgtYZkxn0vtaM39pH7LeQQn0lJ2JsezRbeW3/IRCX0wLnNdZuPHJW6H0honlMgSD
	gV/5+lz7WW4VJkcTHg3Lq0VmIM8JqOCeUZZMdZMIeHNLNTuNwEfjIgUBT/kvDVlR
	Z0mW8g+KwajTFPGslTc4phAcDoti18wqdZ8eeUWq4/IR4IyF9W+MAY0TZ/xRMZw=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazlp17013074.outbound.protection.outlook.com [40.93.138.74])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44hd46bx28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 07:49:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCERckwYPxXJBu70w5gxCVAYaZQ6hQJ3F1fdOjq67Y2ufdJPl569VkpGkab3IZwFCGyfCkF2UstAUT9r5SRVHFX7LeAkxgoyPBsL7Aa1OD5E6mILiup8Y9sODpKyqZGil5/xhTtR/ye0gBENNMhAAWQkI2NIWNYCRkiF0hT0sFNB7flV+Oqt195I6791iTf+Xl5ShvnK9DA5ixecH25T/TtoW7ePSMcBugye9Q5RXNv0tYXRk59yXYik2RvkP5zpRpSFKzEQUOUOrV+65pYJkPdIzHicWB4s9a6XkQmOobUt+krP3zGsCoLMmzsCYh1rRzvdNhK5pqVya0D7Zw3P6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+kK5JBTd3R5jUr2IpI88fSdpiSG1mzGaoCrYmzm1Z0=;
 b=RS6JtZ+5gPL6oyIHiJXdVfPsq1kT+4eEJ7P0uYeqm8jztD7wNFEN56ZBqLtBiSSe3y+NU1Gv/tHTJ8Opv2Cof5DmskkCoglxYXAAj97EE4cDVwaJ5UjMB0qUq2lMwBCjrKr59Xc11ZUxOpa/5xlTlxBLlQeZyZjQGG6dffhHS6aqBuDyzE6k3pbci5RTDF2rI3iS+RYvr6R9IGKuq/KtLCkTst5f60rUSJwYWglO1+NtKczeeeBU0xPBko/KeHZ/krOxA7BiSaRQPr3WDykRZzPmeP8otwgzSlr4jdsqzsaJWBnPX6mLcPG7C/CEdjo08vaiZZAhQAgZ8ODXVO9yNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6834.apcprd04.prod.outlook.com (2603:1096:400:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 07:49:38 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 07:49:38 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Noah <kernel-org-10@maxgrass.eu>,
        linux-fsdevel
	<linux-fsdevel@vger.kernel.org>
CC: sj1557seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
Subject: Re: [exFAT] Missing O_DIRECT Support Causes Errors in Python and
 Affects Applications
Thread-Topic: [exFAT] Missing O_DIRECT Support Causes Errors in Python and
 Affects Applications
Thread-Index: AQHbdm6ApRtfvNYxw0qevnLlP9kNR7M55aqt
Date: Thu, 6 Feb 2025 07:49:38 +0000
Message-ID:
 <PUZPR04MB631698672680CB6AC1529C0F81F62@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <bug-219746-228826@https.bugzilla.kernel.org/>
 <bug-219746-228826-lg3LNttcRh@https.bugzilla.kernel.org/>
 <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
In-Reply-To: <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6834:EE_
x-ms-office365-filtering-correlation-id: a320ac68-9eed-4051-d5c2-08dd4682ce85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1V1Ny9odGUrR2RRZDNXc0xla3IzTVp5RFZlK2NCZzdQcG9xbWcwdE4vTmND?=
 =?utf-8?B?QUNRaFZxWlNvV0sxWmZMRXRsTVVZdnl0Q2lGb1diaXA2VGsyeHprZ3JzSTEw?=
 =?utf-8?B?MHB2Z2NjSDN6aFMyN2k5dS91K1ZPcWowYnl4Z2JSeGEzU0F3VS9wcG13bGtF?=
 =?utf-8?B?N2Z3eGtpTEVlWGc2aVpFYkpyazVuK1ZDTHljZThxK1JHNkRoeXZtdnJySWo3?=
 =?utf-8?B?RjAyQ3FIU1FjblZvdWhseUZvNDh4K2k0UTV5MnZjczJ0SGx2dXBMZWEva0Q3?=
 =?utf-8?B?cnJ3TmQ0YkRXWjFmanRaU1B3UXAzWjZQZG44L05XZmVJRjhCZkJyOS9OL1Yx?=
 =?utf-8?B?ZmtJZHdGQi9HRHRVc1AwVG1kNzVET2R5NlFWMUdwOHM5eXo1eDEvQ2ZnUlkr?=
 =?utf-8?B?a0NTTmRQQnlOOHdYdHhlMCtvWGF5ektLa1V3TTBCeFhoZHNKNmtLdkRQNExT?=
 =?utf-8?B?QytkYkxDOHdLR2FkM3FBRlRKQ0h2aU0rekd6V2E3bmtXZG9CYysvOEd6OVRz?=
 =?utf-8?B?T045cnd4TTRqTDVLbjlocm9vSTkrOUV6TTIvWDB5b1pGOUs2T0luMGpoUVY1?=
 =?utf-8?B?bmVUUG0rdFhEeFVYMWZWNmFKa29EMHM5em40dXJhSC9jb3J3eW44dDZkZ2l2?=
 =?utf-8?B?WWNvbzhVaEpDbzBEbFpvWjVWSmNKR2dTSnNhaDhZVlZDMVlSSEV1OXJUZmlM?=
 =?utf-8?B?LzYycEVXdldha2MvaG5YYWl2azNOVDRhV1ovOTRCQ1hKRG1OUVUxd09wTDd1?=
 =?utf-8?B?aGlXVlpFa1dXc0xBUEpJdUNwaWZNTHA4ZXVtMGxSK3dMTzhpYkJmZkxvWlRO?=
 =?utf-8?B?UUNUdnBoOXZOZVBSejNuMTZOVy9xNGZuUmFkMDY4Ry9RZ2wvVlNJaGRlQ0RF?=
 =?utf-8?B?T0NOdk5BU3NON2NSRjE0by9UOUNyOVByMVpnU1JRaE1MU0JIdzZCenpNdW1s?=
 =?utf-8?B?Vk5mUW94R2VVanY1QUdYam1QM2hOMG11cG1nRXpMK3BwV3NRbzNEcUd1dTRv?=
 =?utf-8?B?a20vR2JtZEZhV3AvOHRDOWJPUUVBQWplUWl5aDJUVHhXSEEzUEtwdWsrSjJz?=
 =?utf-8?B?WkVLMEF3RzIxMlRtMlhnNHNkWVNqa3NuV1doOUZQNVRpR3lXVnlKSmJUM3Ri?=
 =?utf-8?B?b2M1RTZOS1dsUzVENFBNVytwRHJKTm1ITmwwcWljMC9JaVVhOFp6Mk9BYWxy?=
 =?utf-8?B?OWQ1T21sOWNBbllDa2Jlc1A5blhJZ1FsTGJuVzAyOUVxdklIKzNESTRwajFy?=
 =?utf-8?B?UUowbVdNcmdBRmpXem50RTFzY1c5WS8zRnVzeUtmNHVlL21MUUU3TWcwZFV5?=
 =?utf-8?B?dzlGSlJuTW1tZkRHRmlNb0V3L1pnRTBpTXlrS2RaWkRnaVZSc291VTBnYWdC?=
 =?utf-8?B?ZFdVb3VPTUJtdlJlUkJVbmxaeHFJbEdjWE00d2grZlFya1NzNDB3cUppckpl?=
 =?utf-8?B?SDZYYWc2QXJ3Wm5LK1ROWTkvZjhqQURpUnh4VzlBK2Y4T1RHT0NocXZXZlZ0?=
 =?utf-8?B?Vm45RmpKdkdUZStmZWFob25CL0hGREtJUjVQYVFUTjNndWhlM3dHaDFqTXpL?=
 =?utf-8?B?MU1OZ25NT1lzMkhLZFg1alprdUxzeGFIYXA5RmVLdjdKK0ovZW9ZTnJRdjBQ?=
 =?utf-8?B?MDVBU0tkd21OU3ovY3BvRFVUTkFlc3paNjA1eTcvUXhLWmZUWW1DK1dtV0M4?=
 =?utf-8?B?STlqOGdadmNKV0srRDNsRkNSQXdRRmtSZGxlcE9BZFBvYlNuSG5GdE85QVVK?=
 =?utf-8?B?VVcwY05YMktJQTRXYUJ1RlFIejNXWlIzQ0tuWmI1OHFTWitvZHY2WUdoVXBj?=
 =?utf-8?B?cUdZS3dYcTdVZ1N1RXRmYTRlT0hyV0pTRjF4VFNGNllvck41a0diSE1oUHRp?=
 =?utf-8?B?NTlFR0RucFFjYkVSalhrU3F2ZE51RFNVV2ZZQzY1UTA0L3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHdGRjBnVDA3KytIejJ2Wklnd1FrcVZtQzFBb3d4ODFMTnlZZVFHajJXbWwz?=
 =?utf-8?B?UW1JRUwxVCsrRkNCK3lTSUk5OTJzcnlrdGxYT21jd1JMZ0c4L251UVJpMEpy?=
 =?utf-8?B?RkFCa2cydzdtVkZsTnZuWXJkaGNYYWJ4Yi9NMC9pd0ZKc1hlRzdFNjRvTGYr?=
 =?utf-8?B?R3FMVEZnOWJCbVJIOXpKT3EwU2N6TmdYcDhWK0RBbjNvbzNZNDg3aEdmTWEv?=
 =?utf-8?B?c091eHZaWHRjczR3alRyU2hFL25LOTJhd25tQnJwMlp6YnhkMVFmRjFFNEQ0?=
 =?utf-8?B?cVJHeldzUkhEQXE1cUg0dkxOdkJsdHB6YjNmZlNqYll1UFh0VjhmZzlJNHdQ?=
 =?utf-8?B?a3lLbWdoNEQwbzFIcFowZ080RzhuZ2VVekdiOE92NVExTFdWVHVMZ0dCRmEv?=
 =?utf-8?B?dTFLNXlSdVZXNi8zN2FTNkJlRktOTmp4UnlKcUNISnFYcGJ1V29rNU9USzF0?=
 =?utf-8?B?d0hEc0Zjbm15SndySzRyYkYvMFdueER6MzQ2eUxhYlJZYzdNZ01nc2dFRkRY?=
 =?utf-8?B?TDFRdjVrbUk1eTVWZlNWTm1OdWFSR285MjdIQjYxMEgwUTRmZTFCa0VpaFFJ?=
 =?utf-8?B?eDZselYram9sWnU2SXUxVDUzaThYWU5IZGU3TmFSemhZSjBsV2ErVEFVa1lT?=
 =?utf-8?B?KzFPZjVkRHEzMkxvZXFkMDJJeGVPS2xKT2hMSjRVWHFobEs2T2RRaWRnd2ls?=
 =?utf-8?B?emNiNUNQZmpNaU4xaFlkVmE0V01DcUo3QWpZSTRhb05LMi9RRnJhaURsWFo3?=
 =?utf-8?B?WGhVU1hmV0dyS3YzWGk4R0RlOW9xZGVOQWE5WU83VzU2bWltL1Q0d21ya3R0?=
 =?utf-8?B?bm50cGx3c0Z5WmthZUg1YmtNOWhiTEJETnFnRHFOaVBJT3JKNlBzejdjdEpB?=
 =?utf-8?B?YmdXQ3paekpOZFJnd1VWSVBEVXFSa3B3TDRSQVppSCtHdVZEVXhKMFRSOXkr?=
 =?utf-8?B?RTQzUkx6MnZuaDRFM0JlLzlrbk8xSUQvZU9xemp3ay9yUEFBa0VHV1lMckox?=
 =?utf-8?B?bk13dThGenYrd0FPU0JFN0RpSmNhRUs3UGpwbzVKa2owdFpTZHN3aUdremdy?=
 =?utf-8?B?c25NZDN2MUYwY25RMkVHVlBmS1FzYnNTdVRnc3dlVkdFSTVsbVRBNURWSDlD?=
 =?utf-8?B?aDA0Vyt0dG1CbHQrWkpSOFkzOUpxcXR4ZUx1N1Y3d0RtbTVYeVhlazJrY2hK?=
 =?utf-8?B?ak5reEhNbWYvTjFFcmxTU01FN3oyclJUdWFuSUhNZ1FKWDN1RjltRHh6MVlq?=
 =?utf-8?B?aFJsZEdLTEtrRHhZMXZ0STMzQU5JdmVXbVFqMUNSOXY0TGxWRXFlTFJLK0dx?=
 =?utf-8?B?M3l0SGhkUHQwL0VkUHpjcS9vRzJSMGNVenNZTzRyeWU5K1dDWHVFRlM1dGNZ?=
 =?utf-8?B?dkJ4Q1lDZWtMeUdoVVQrQWZrYmpVbVBnc2ZmNHIxOXpSZS8vem9YUExGTmNi?=
 =?utf-8?B?QlhUcG1kU295aUN5UVJsQkhQbnZ1ajhvc3o3TDFYK2JJVmsraXFrVFZFaFZa?=
 =?utf-8?B?U1V6UVlhdWI1dFI1QVZWMlV0RXVNQXE0aVFvZVg2LzdOM0U3YngxREwydXNt?=
 =?utf-8?B?bmVxTTJKRnFaVGk0Wm0xc05IbW1IL3NJL1VORTRTSElTN3gvSFNMWWI5VlB2?=
 =?utf-8?B?SUVjUVh1UDlkQXl0OEJPbldXREhrRVNJK2NCZk5mTUUyL2pwTkdBbUp5WjFE?=
 =?utf-8?B?Q0dJdkVCSHNMTnIrZnNSamNBVjBxY0krOVpvSDExdWtjdnJmcFZhWUxjOHBt?=
 =?utf-8?B?U0gwd0VpMUFSUFZIZ3VPQ3FUZTNLS005ajVXZkRqY1JLakdYcnR6MVhjUDZE?=
 =?utf-8?B?SjVLN1pzdlFpRjBSYlBqd1ZIdGtzdm1HajE0OU9xdllmeDR5RGw3aGNHMkxK?=
 =?utf-8?B?RStrNFhINC90QzhnejVZVUFLbjJHMzBZdjZzcDFjMjJDTUQ1Ui9aYmhyQWgz?=
 =?utf-8?B?alUySWI1Sll6SGxNVnQxOThmazVMNDE0b2hTdjhhazczUEVSWTI3YTVGSW0z?=
 =?utf-8?B?d0I3eUZrNDhUYjZpbGlUTWIvNnVacjRLOFdaUERlUlk3VUZ5WXdodVdjM3hx?=
 =?utf-8?B?NUw2ZytGMUpLdlR5UHRIMjdjV21ydzRvZExOOWdIczJaZCt5d0QxbWVacnVo?=
 =?utf-8?Q?t5sn9azSg6PH12iHis+5f/oor?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4uyN7NXgylzV/m0Z1qlrVSkbtKTb+nLaa173HUQLoCOGrK9OHIF+hdnzv/NRLNs7OyhVDEiJnazqV7wXWDB6xdc+mL8OfCZquv5TA71+JVMxxPVlyqbc8UG/A1DWkXxGtwgvL8Q4hz6zzxp7MomrAGRPybSyAw1mV+Cs3OVpgAL/UcHC/j8RWVX65xeEpW9UXxSrccFrnCJbicrG47jRuTjqk97xawmCVI20BW4AXe0Skn7eEOGPXf5Bif8RNbntHb2rWlvFzfrOND/UGDCqPV7ex+4r4AYN69gqyB46a3mCgwoPP1xYglqlVn05GxXpdwOXub/4LUnkt7C+8x0aq2gVBcGjjtkqsHESLAHXk56JBA7YWnPgGOfV790OfrOeOhHJCH6Rpi8JCknm4Bn+m4glGzt5kTCwSAf9AY+PcIQPFVNdvVIGWGnK3vy+6I/DHKFPAnOnKDaLixJjlNQo31RiEo3A1ig2zGbOQRAVE/XfokN1sqRyHUkfN5zJlM06aBCKz1QQTBw2IrYIxk52alpfhQKxlKfEO7zb2XTqzrjPQmZOiZsOD93EK1X42sWrTga8BwyXBgZy0Iqys/KkmktDOodOUCtyHFRTWecTRJKGjBQb3miBc90hdphVBFY2
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a320ac68-9eed-4051-d5c2-08dd4682ce85
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 07:49:38.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aWqiZdmRqpP3UzHe83JhZsdSSwdUSTSVC7YvnPBWnWGnA4x+kB+5/fdvkzJzXZlYQ8g18xtjCRDXc44pHYrjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6834
X-Proofpoint-GUID: JXEwkIC3817QHtEbwj0f5L2vkeATC6ez
X-Proofpoint-ORIG-GUID: JXEwkIC3817QHtEbwj0f5L2vkeATC6ez
X-Sony-Outbound-GUID: JXEwkIC3817QHtEbwj0f5L2vkeATC6ez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01

SGksDQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMgaXNzdWUsIEkgd2lsbCBjaGVjayBpdC4N
Cg0KQmVzdCBSZWdhcmRzLA0KWXVlemhhbmcgTW8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KDQpTdWJqZWN0OiBbZXhGQVRdIE1pc3NpbmcgT19ESVJFQ1QgU3VwcG9ydCBDYXVzZXMg
RXJyb3JzIGluIFB5dGhvbiBhbmQgQWZmZWN0cyBBcHBsaWNhdGlvbnMNCj4gRnJvbTogTm9haCA8
a2VybmVsLW9yZy0xMEBtYXhncmFzcy5ldT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgNCwg
MjAyNSAzOjA0IEFNDQo+IFRvOiBsaW51eC1mc2RldmVsIDxsaW51eC1mc2RldmVsQHZnZXIua2Vy
bmVsLm9yZz4NCj4gQ2M6IHNqMTU1N3NlbyA8c2oxNTU3LnNlb0BzYW1zdW5nLmNvbT47IE1vLCBZ
dWV6aGFuZyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbZXhGQVRdIE1p
c3NpbmcgT19ESVJFQ1QgU3VwcG9ydCBDYXVzZXMgRXJyb3JzIGluIFB5dGhvbiBhbmQNCj4gQWZm
ZWN0cyBBcHBsaWNhdGlvbnMNCj4gDQo+IEhlbGxvLA0KPiBJ4oCZdmUgZW5jb3VudGVyZWQgYW4g
aXNzdWUgd2l0aCB0aGUgZXhGQVQgZHJpdmVyIHdoZW4gYXR0ZW1wdGluZyB0byBjcmVhdGUgYW4N
Cj4gZW1wdHkgZmlsZSwgcmVzdWx0aW5nIGluIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+IE9TRXJy
b3I6IFtFcnJubyAxNF0gQmFkIGFkZHJlc3MNCj4gDQo+IFJlcHJvZHVjdGlvbiBTdGVwczoNCj4g
bWtkaXIgL3RtcC9leGZhdA0KPiBjZCAvdG1wL2V4ZmF0DQo+IGZhbGxvY2F0ZSAtbCA1MTJNIGV4
ZmF0LmltZw0KPiBta2ZzLmV4ZmF0IGV4ZmF0LmltZw0KPiBzdWRvIG1rZGlyIC1wIC9mYXRpbWFn
ZWRpci8NCj4gc3VkbyBtb3VudCAtbyB1bWFzaz0wMDIyLGdpZD0kKGlkIC1nKSx1aWQ9JChpZCAt
dSkgL3RtcC9leGZhdC9leGZhdC5pbWcNCj4gL2ZhdGltYWdlZGlyLw0KPiBjZCAvZmF0aW1hZ2Vk
aXINCj4gcHl0aG9uMyAtYyAnb3BlbigiZm9vIiwgIndiIiwgYnVmZmVyaW5nPTApLndyaXRlKGIi
IiknDQo+IA0KPiBPYnNlcnZhdGlvbnM6DQo+IDEuIFdpdGggdGhlIGtlcm5lbCBleEZBVCBkcml2
ZXI6DQo+IG8gUHJvZHVjZXMgT1NFcnJvcjogW0Vycm5vIDE0XSBCYWQgYWRkcmVzcyBvbiBMaW51
eCA2LjEyLjEwLg0KPiBvIERlc3BpdGUgdGhlIGVycm9yLCB0aGUgZmlsZSBpcyBjcmVhdGVkLg0K
PiBvIEFzIG5vdGVkIGJ5IEFydGVtIFMuIFRhc2hraW5vdjoNCj4gIldoaWxlIHRoaXMgY29kZSBw
cm9kdWNlcyBhbiBlcnJvciB1bmRlciBMaW51eCA2LjEyLjEwLCBpdCBzdGlsbCB3b3JrcyBhcw0K
PiBpbnRlbmRlZCAtIHRoZSBmaWxlIGlzIGNyZWF0ZWQuIg0KPiAyLiBXaXRoIGV4RkFULUZVU0U6
DQo+IG8gV29ya3MgYXMgZXhwZWN0ZWQgd2l0aG91dCBlcnJvcnM6DQo+IDMuIHN1ZG8gbG9zZXR1
cCAtZiBleGZhdC5pbWcNCj4gNC4gc3VkbyBmdXNlL21vdW50LmV4ZmF0LWZ1c2UgLW8gbG9vcCx1
bWFzaz0wMDIyLGdpZD0kKGlkIC1nKSx1aWQ9JChpZCAtdSkNCj4gL2Rldi9sb29wMCAvZmF0aW1h
Z2VkaXIvDQo+IDUuIGNkIC9mYXRpbWFnZWRpcg0KPiA2LiBweXRob24zIC1jICdvcGVuKCJmb28i
LCAid2IiLCBidWZmZXJpbmc9MCkud3JpdGUoYiIiKScNCj4gNy4gbHMNCj4gOC4gZm9vDQo+IA0K
PiBJbXBhY3Q6DQo+IOKAoiBBZmZlY3RzIFB5dGhvbidzIGZpbGUgaGFuZGxpbmcgYW5kIHBvcHVs
YXIgYXBwbGljYXRpb25zIGxpa2UgVlNDb2RpdW0gYW5kDQo+IFplZCwgd2hpY2ggcmVseSBvbiB1
bmJ1ZmZlcmVkIEkvTy4NCj4g4oCiIExpa2VseSByZWxhdGVkIHRvIHRoZSBsYWNrIG9mIE9fRElS
RUNUIHN1cHBvcnQgaW4gdGhlIGtlcm5lbCBleEZBVCBkcml2ZXIuDQo+IFJlZmVyZW5jZXM6DQo+
IOKAog0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTkNCj4gNzQ2X187ISFPN19ZU0hjbWQ5anAzaGpfNGRF
QWN5USEyNkRTZGhrU095Q2luLS03bnFfcHQyQng0Y2xPY1pMR2hODQo+IHFIenBmWXZnMlg1M1lk
eEtYQVJsYkppdzlKV3BraUJFOWQ4TVViWjBsWVJyWU1WMWEyUTk5RGFpdDYkDQo+IOKAog0KPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9iYnMuYXJjaGxpbnV4Lm9yZy92aWV3
dG9waWMucGhwP2lkPTI5NDgNCj4gMzdfXzshIU83X1lTSGNtZDlqcDNoal80ZEVBY3lRITI2RFNk
aGtTT3lDaW4tLTducV9wdDJCeDRjbE9jWkxHaE5xDQo+IEh6cGZZdmcyWDUzWWR4S1hBUmxiSml3
OUpXcGtpQkU5ZDhNVWJaMGxZUnJZTVYxYTJRM1JoWHAzRCQNCj4g4oCiDQo+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vemVkLWluZHVzdHJpZXMvemVkL2lz
c3Vlcy8yMQ0KPiA1OTVfXzshIU83X1lTSGNtZDlqcDNoal80ZEVBY3lRITI2RFNkaGtTT3lDaW4t
LTducV9wdDJCeDRjbE9jWkxHaE4NCj4gcUh6cGZZdmcyWDUzWWR4S1hBUmxiSml3OUpXcGtpQkU5
ZDhNVWJaMGxZUnJZTVYxYTJRNi02ODVuOSQNCj4gSXMgdGhlIGxhY2sgb2YgT19ESVJFQ1Qgc3Vw
cG9ydCBpbnRlbnRpb25hbCwgb3Igd291bGQgdGhpcyBiZSBjb25zaWRlcmVkIGZvcg0KPiBmdXR1
cmUgaW1wbGVtZW50YXRpb24/DQo+IEJlc3QgcmVnYXJkcywNCj4gTWF4IEdyYXNzDQo+IA0KDQo=

