Return-Path: <linux-fsdevel+bounces-77820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JEm8HCi+mGnuLgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:03:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3AA16A89D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FA8B301AAB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B42FDC3C;
	Fri, 20 Feb 2026 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RD3ATLAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4F1CD1E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617824; cv=fail; b=YzYpAQt9Qonsn1h8k2BDjs3WcBq8WY0WNP8hOI3dzcRKjrycFAgonexzM3eicDOOKg3+QE3omBTvcCiFFbnUYWQffmeGwLKEL5vFJ4MOtrdpoKAjXQG2dneUFy62FCXQYIIWSm29jmodCCLvcke9j7skCZIYp5zwsbXQvRqof2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617824; c=relaxed/simple;
	bh=BdvbtcpUQTUbiFor8tMOv2yc8aPlB/23f3guzJEAYe4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Sy6wE1wznEz8HLkUa4AJJykLQJbORXulSEUFj3EqdYCSmqq/Sa9+bRlmc/P/WiLqSh/sO4pBTm4nv1i2vGVDP3jDeZN3X7wu5aGde8Bak4Hvm7LnzmdRM0g17V/gCTlOVvyu4re3I17zpqLqBMYhnXLo4h/KADLSZ9HL9TUd/+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RD3ATLAH; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEUxfJ1602270;
	Fri, 20 Feb 2026 20:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=BdvbtcpUQTUbiFor8tMOv2yc8aPlB/23f3guzJEAYe4=; b=RD3ATLAH
	lHncfd4aEATYhAqpLJJBGZTJbEpxXDCHijlg5OpOdhiB0l/T/B0IopkdsT1x8R2H
	0OwW9lsHpuekGxvvm4p4xoLG/9GWSdPXhimEEO4ygeHAi7lMF8tdlN/gq3KncEQY
	bjOSvgxcXEnekQZLEU8b6b5kDZTZ1iPTzfgz9rfkWneaum0wLtZT702AUFaTqXKi
	MqCA61k2Pp1CwGxOdl/1JxrVONhyL8dD4wJxoUgetN/MnVaV4arK/9K+vFRmpDdn
	uwMAug5P96Cb/5YsVeR35s0PjeqnynOXWSzF0/K3G0Qp9obptmP9525nE3wYyTj5
	wB0XEwBC+9Z5Bg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcrcx4d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 20:03:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK6aHeV/sxz+NDJZ7nb/Y1w/USDH8E/PJyvEO0XupcnoM0B3ai96z0J0yosQ9XRCZz5GnZuPKOKpUP0dMBoP2rSRX3iMGmtpOxeVuDuxP5zUTh5yCR7D7w+ofg7ODBqS5tbmx/JbB/S8i7iNJVmzmX/8Ahf18ZlfPjEGuIiuQ7kbFQQUuP6oHENfd4pD8uluW/KalHWnDaQ9Nnc1ZG9l7p12ycRqIQQlDvIx6dfYlCgWPmtiRftTFCxgR5tRzgk9C8za6DQ9oVnSdJbr3FetMhQAsQAgY/+QiD1VjHGr0bPFNaJCViwkwB+RMWhkGmSsnj4bNGptmZuPPwEzhyeI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdvbtcpUQTUbiFor8tMOv2yc8aPlB/23f3guzJEAYe4=;
 b=IJoUUA1qLTze9WTkNCtVvqxTGT23QoXhiYMf7kp4fkO/ye7dLBhIQrwOhLsprPCk1KcCeCpo7dsXPyUZUvBqVpLF5srkZDmZVbLLtJX5swm19wtqEoK8YBuAeoXCtRtGa4PH88EUmLm1uPy5z+YjwPWLEO1tBBaT8ei7ArCbjDB081xafysT0n8KUE1e8JWxArVCPf2e02VjyYRdB32HNw1iQB+V9URSASrfUujGp1SS6thEnib2yuqwFlPUuUONEfES0VmdTjaHyafLtmj+ht7qvXJXKrSvb0PgescoTDTpzftexGRl+itcJ4lhB9eJDoRW6OZBooRSxHnG2v36rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4234.namprd15.prod.outlook.com (2603:10b6:a03:2c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 20:03:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 20:03:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfs: don't fail operations when
 files/directories counter overflows
Thread-Index: AQHcooG+DsqfupG0wEScBcO/cXm4orWMAvYA
Date: Fri, 20 Feb 2026 20:03:33 +0000
Message-ID: <be0afbc9cf2816b19952a8d38ffb4a82519454e2.camel@ibm.com>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
	 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
	 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
	 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
	 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
	 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
	 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
	 <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
	 <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
	 <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
	 <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
	 <fd5c05a5-2752-4dab-ba98-2750577fb9a4@I-love.SAKURA.ne.jp>
In-Reply-To: <fd5c05a5-2752-4dab-ba98-2750577fb9a4@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4234:EE_
x-ms-office365-filtering-correlation-id: 5d6b702c-4082-46c4-d7b1-08de70bb2038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVNlVGRpTlpCT3pSR3cxQXlTMndtUTRUWEZhZ2IxWTBtSGd4enBaUzNnZ2Vk?=
 =?utf-8?B?Ymw5TVFTSHhnUGFSWFVhZk5RK2lkVGg4TXhweWdJNVJjOStyN2xId0JIQktH?=
 =?utf-8?B?T2YzdGVNS1dMQU9GMVp4UmtrTGloQ0V4Z3dTMGxrSzh4VHhad1A3eS9vTERp?=
 =?utf-8?B?NEdhOEs2dmY0SnhWamtqWi9EZ0ZKa0pmZDF4VjlVOGlzT0ZDUkIwWXh6WVNL?=
 =?utf-8?B?dE1obEszSHk0RVhCMWtlK0ZrQ2t2VmZHRFFacTZZV1NrTE4xMHdXcENJc2I0?=
 =?utf-8?B?azFSSXJOMHFwRkh2aURSVVZUMTJOVGptU2ZQT3dWblZ0OVRyazBjaHdXMVB2?=
 =?utf-8?B?NVNHU0xLZi91UGFhK2ZRNit5OFdXNFdRNnpBelFWNy9PdndsMUpvTGtTa0V0?=
 =?utf-8?B?MGI3VHd2UDNONVhTQzNscE01ellyeWQ3ZHFwS000SGI5b011ZXRjS2xvOGtF?=
 =?utf-8?B?d1hINnZBbGx2SjlOdWFUL01YQkFvZjJKYVNLbFQyT0pMQ2lZcEF5aWVXdUJL?=
 =?utf-8?B?MWx3eDBDZEtsdGhaVUdJNEdIWlh1UVZqOGNDd2E2TXZXRDJURXFIbEwrcEV0?=
 =?utf-8?B?L0lBbEl3eDJrTVJ1cDhvdGNQaFIwTUZCL0ptSjZDYzBQKzlpV2xpVytGanpD?=
 =?utf-8?B?ZUlFcTBDNmI0T1h6emVCcVZDemhDNVpxVkQ0TzRieTNFbm5CeTdPOENGUG5l?=
 =?utf-8?B?UkJ0THpsOUNYbGxmTmNGcHExYUF6VEc1aEhmSGtXY29vR0t6Qk5YWjM1azhW?=
 =?utf-8?B?c09MdEFic0lYSnkxRW5FaWtWcWFDZTRncUZaRk9ncS85UW05Ylg0VnpWbUZn?=
 =?utf-8?B?b0NFc2JmOFFUUTVmNjBjSHlSbFhsaC9SMGZsVVRubThPZXYrQ2tzcDJZVk54?=
 =?utf-8?B?S1cxbnJhRTc2WU15WmlQZUZrNWoyWVBIQnRFUklISFQ0bDFSSU4vZjJQZ21o?=
 =?utf-8?B?bVFKQy84dWVhUTVWYnl2WEVicEhCeitTcUQ2eThrS3p4ZEswSWVsMWlFOTMr?=
 =?utf-8?B?ZWlpdUVPWkxxYnJ6MFdjaUZ3bUhTUmJlYm9uUUdlbXl2SDJOcVVhOW1Od1lJ?=
 =?utf-8?B?Yy9rUUNtRjZ2RGNSdHAveFMxSGNURkQwejg0S3IyVUVRWFJKN2UyR000L3RO?=
 =?utf-8?B?TUZQc0FOREo3NGJFcEROSm9MYmNiaXFTbGpmZURyL2YxYm9RM1c5YVdtdUJ3?=
 =?utf-8?B?VTFuVXE4WnhGU1NJWnFnVExLK0ltbTE3eG5tQzRLMVltNFQ2TW5Ib3lzeWNF?=
 =?utf-8?B?R0IwRnZxb2U5U3BST1NVbERDZ0FFYTk2TXVNbVFzbzEwY0hmc1VqY2d4ek81?=
 =?utf-8?B?MC9tOGI1S1pJOGMyMDZOMHI0VnVnc2FEUkl2d2k5ejJYZERUUVF5K0JzZzJr?=
 =?utf-8?B?SEtsWlhPUUZmN2RwM0huSERaa3N6MmRhUVdzL0VFejBYaXJrZHpQWkkyU1dx?=
 =?utf-8?B?a2pYaVI0S2djUEZKdE9pRzdaU2MwOHFEVG9HQVpvQjc2VVV3b0U3cHphOXU1?=
 =?utf-8?B?eEJneThTVTlwYnVLVW9WTE9MZHFyMy9ucmxhREZCMU5lVkNhQjN3d0ZISlFl?=
 =?utf-8?B?ZUhvVjM3WTBPdXRWVStDKzRQVmRVNlJiT1ptVWNVYjlCcFNIT0lqb3gvVENG?=
 =?utf-8?B?cThFd1FZM3lCSFh5UWFpVXhpV2NGY2xrNTl5Qi8xQU15NktmV0lNc21iSFVC?=
 =?utf-8?B?bkVZYk9mVGxEUXpQRjlZYUZEd2MxTVl1L2RYc3VGZmg3N2Q5NkxIZUphaVlw?=
 =?utf-8?B?bUxxQlozQ3Zsd2E3VVpubEhrSDBLY2dMSG5wS21EQkhoaVBTUHpJSXJlU1kz?=
 =?utf-8?B?RFdMTUlyRUloZ1VHZGxaN2RWamxPNkN6RHE4T055dGsvZ1VLTzNTc1NwZlYx?=
 =?utf-8?B?cEZkVG15NDB5eEdja0hDd2J4M0s2bkJraFMzVDZTTnNUV2hxSTFLV0phRHly?=
 =?utf-8?B?Ymo0WU1Lb3VTMk1OYmNOTjU2VXVkM3ZWTk5Ia3dIMkRIT1lnVjhXRFdCYito?=
 =?utf-8?B?TlNuY1BFTElPdjM0ajFUeS8vMzE4UUNXZzcyN3lCQXpDUCtmdzc5L3BMVmFr?=
 =?utf-8?B?T1JCWUJIRXRPMy81NHJpV2hWamczUDJTcHRESG5OSXJLc3VOVkhwNDBhZ0Fq?=
 =?utf-8?B?VStHMHZYT0hwOE02TzdDRnJLVlp2cFdIZjJmbWFHQTJYWHN6bFVjSUpDNUQz?=
 =?utf-8?Q?G56/bRsWuTSnjvYaVVFri+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXNRODZleDVNeTJoVU9sZDRXTmRUUmFWWVZGViszampidkx5V2FobmFZNHNR?=
 =?utf-8?B?N3Z3MmFtbDR3bitkQXJub1BIMWRENHFtdzJ1QUNPZ200T0huWDB2WkRkNS9u?=
 =?utf-8?B?WmZpVzBjMGZBYVhjbkkrSmt6OVhhVlE4L0FESzUrZXlMenhoWkJxUGk5cVRm?=
 =?utf-8?B?a2NpT2xtdjRlQklGak1lcHZYekNqOGlYa1lqMUQveUNvVG9jV25xMmIydGJ1?=
 =?utf-8?B?WmxXcHV2NG0zckJiekZRbGhzajlIWE5udmJpNVEzemQ5L2NYdjdPbEhGLzNX?=
 =?utf-8?B?UGFKZmF6VHJDSGM5TFZCZTZjSllMbUNRblRiVzJnOC9KblNJQnY3M09sT29E?=
 =?utf-8?B?d0h1ZXo2dnVpckRwV21IMXJoYm9jSUxxVDgvbGQybHBWeHlKRXEwSVNLZmpv?=
 =?utf-8?B?MEtONzRBdUhHdFNKaFRQcDVoMEE2c2J4NXIxMmZraFMxMXBQc09rRWF4WGs2?=
 =?utf-8?B?ck5qK1VjdUV2NnJ6ZVdYU3dLc3Q1MVpjcGxyeXpCc3FQZFlLYVBlQjd4YzN2?=
 =?utf-8?B?b1l4TEt6eWxGdC85VzJsRkE5N3pFMEVBTjhmT0MrUGg4QmZUdy9tOWtIdUdt?=
 =?utf-8?B?djRLWmlQWHJFYmFGb3oyU3RzNUE1NzVyTEFCRHdZWXBuL2sydmpabStpamxm?=
 =?utf-8?B?K1U5N09ja2NEZzRSZkY4ZktScTRabVJKSVR1U1NLV2MzTkhUT2NWS2lDMjJ4?=
 =?utf-8?B?UldRL0Y2aEZ6YXNjVXl0Q01VVm5xUmVPWHcwMHBLN1RWKzY4eDNrc09VZlA5?=
 =?utf-8?B?Ri9qQUZHdEVuZk45ckxBM3I0VjREMktnWDJKalhTL2I0bVJxNm5WSVZJWWVJ?=
 =?utf-8?B?UEpHQnZtVVVyS2ZDaWJiYS9ZL2taaFg2NEdEUEdQeE1hQlpYTTkyV2svVzF3?=
 =?utf-8?B?bWNkY0JtLzlzL3NORDlpQ1RWUnRFQTlJQ2VSRkNSU0JjdUFSWnR2OTVXZjE2?=
 =?utf-8?B?cWJiWXNVU09QV0lUQWxVYlg5Z1gvcFN2dlBUcTVWT3VZU0lmeXRMa1hzeExU?=
 =?utf-8?B?VUNnSVBqTnJpQytCSFVJUk4wSkIxcHBJNVJ1YzBBWW51aWt6QUdxN0Zxa2pQ?=
 =?utf-8?B?b3dZYitUVUQ2Tmljalkzd2tiQ2VWVVdkY05EOWtiUnhTcmc1RWpDZkV6NGRP?=
 =?utf-8?B?cko0QVBaM2NWRFprUm5iQ1NYQjF4RFdMM0JSalVOVVFpQVF1ZHdxaGx6WGlY?=
 =?utf-8?B?VE5uTGtjMC9lVGxmcmpSUjVVMFZNbEZoenBGVE5TT1l4RzVBek12RmNpcXc2?=
 =?utf-8?B?d2owRXB0eXFPTmNLSjQxNFUzamV0dWh2RmpaTHNqV0tXNnFWM0FyYmNHTzQy?=
 =?utf-8?B?MU13QVhoSFJNN005MGxJZU44VjFqbURHdklJYldoUEJ1UWhrVy9uYVhycVE1?=
 =?utf-8?B?dDNMbFQxaUxUa0tLQ2I4SG44NC9aR1JGSENGWEZ3eEhkNExHcUxwaEhSNk1G?=
 =?utf-8?B?eFhObXJTY0doRjkzWENMR2cveTNSV3N1S3B0NjJueW80WTRBdi9CNHlmMTJw?=
 =?utf-8?B?WG5HUnZpSCtIS2h6SUFubzIvSUoySzRka0hjYm5ndHBrOFdiV25kVDUzTVd4?=
 =?utf-8?B?ZVU0Vk5UaU9Fb3NZeWVRcm1hQ2NZOEVpWEU0TjlXNzNkbDRBUHI4ZDgzZk5T?=
 =?utf-8?B?TTE0UFpWUEU2a3BmZnVKMzJZdzA3dmtTV2ZHdFBFMk56bGRONllJNTRnNWFt?=
 =?utf-8?B?Qk9kQlFyY3FleGVkczBZTXpVdExadzhRRzR4OU4zSjdoK0cwamF1b05Zd1Vk?=
 =?utf-8?B?RVYwQTQ4Q29qTlhETU9Ca1NGcFRoellCK09RRWZGcU9ST1JFUW44RTJtYTU4?=
 =?utf-8?B?QVdCZ08zWjVrZlJnek4yU3RUaHNPQkh3WHFWb2FQSS84Z0NENVRkTmp1dWNv?=
 =?utf-8?B?OHJYMkhyWWNnRlVNN251R1JDUFpwZWRaSXdKZzZTaTZSTHZYaVVkM3d2dC9s?=
 =?utf-8?B?THFGUVUrblZsMURzZGNlL3J2MDRCKytTNzFOS2hpeWl6UC9Fc0tXaTU1RndZ?=
 =?utf-8?B?aTFCOUN2QkpzTFc3Q2h4TE5MK3c1blpXUHNUYjVZSGNYcUE5dVVGZzJNdXVD?=
 =?utf-8?B?Z2NXb3JlVzFtaHdMODFwMVpMZVRqWDVOcFIzclNKOE9UR3JnUWVydUZraUtV?=
 =?utf-8?B?OXE4VExvb1g5cFZEdHBoN1RTQzMzMXA1WmVKMG5EVnBlRkFObHNGaGN1WDhT?=
 =?utf-8?B?STFmNSszeWM0WHJzdmNkaHhaRGtNQ1d5bHNYZCtBNHVPOWNQODFCTG84N3RO?=
 =?utf-8?B?K2orZ0FsYjUwd1hHdFd3Nk8zOE9BdUVyVUJkWnpncVNuV1RKZHBsRVBHZFUw?=
 =?utf-8?B?NnlGOXhxdm5meko4MzZEQ0xwZlNQSGltbGlnWHRTRWdZWVlTSlFkYWV3OFBv?=
 =?utf-8?Q?PgYGYs8VOj3EjPUf3NtNHTwN54eeWxhWnJpRA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71ED0E30F89C3748A0B639115F624974@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6b702c-4082-46c4-d7b1-08de70bb2038
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 20:03:33.4936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQJhbAoG4GFud00MNu7odz6JjV2P0nNQRV8rELqoV3KXJbpL6FzDAKynq0YdK36X/PWDaRvvaCbptpq17g0ziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4234
X-Proofpoint-GUID: cYXPCywDr-sX29USwtF9Cm88WhPX6OkV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE2OCBTYWx0ZWRfXzfb6YUWbR1+O
 /g1yH/Jd919huY5zaUnAtJdXuqcTrtTApivZEpxuXnJOJVaUg2JPPvdKmcR+mafrpEJ9fN2kEvP
 EDO1LshDySXlTzEClSHoZTBpQHRo3nkMEfFPT2zcXVYe8WcH5fUav8tjTdkwvQkX2bFETd2yUwr
 lDB+0mZLXVqWXgrw3kXcTg1/Yv9S4hQ7HVhQWXoS4ClPHNuAWpURLyLqM90ACMQzqdFSC7ellUG
 FNuKsoeSoRYy3sfCGORBHaJ73uEr1Mn363Z8SAsFJBe3jY553V5oORXjra32garQUVGbs3mYDC7
 RSddQwZXm8m5vpwM2eQaXChvtLMjU0Z1718QnjdJOIIBxAPWCSTiF5fvVQD1PIMqJXoFnlWoFRC
 mu3ty8hOMHO6Iv+JhfS9RG+BqXCK+IcgSB90h1slo7kYdDvznmg67oOwsX/7wI+ddt6hfX1kPPG
 23/yCWF8qgZR08VyEaQ==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=6998be17 cx=c_pps
 a=j8kfsx1CyBm2fJFf+vs0Eg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=mrZIRt2ET9EWsbEDdxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cYXPCywDr-sX29USwtF9Cm88WhPX6OkV
Subject: Re:  [PATCH] hfs: don't fail operations when files/directories
 counter overflows
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_03,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77820-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,I-love.SAKURA.ne.jp,dubeyko.com,xs4all.nl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF3AA16A89D
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTIxIGF0IDAwOjU3ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IENvbW1pdCBiMjI2ODA0NTMyYTggKCJoZnM6IFJlcGxhY2UgQlVHX09OIHdpdGggZXJyb3IgaGFu
ZGxpbmcgZm9yIENOSUQNCj4gY291bnQgY2hlY2tzIikgd2FzIGFuIGltcHJvdmVtZW50IGluIHRo
YXQgaXQgYXZvaWRzIGtlcm5lbCBjcmFzaCwgYnV0DQo+IHdhcyBub3QgYW4gaW1wcm92ZW1lbnQg
aW4gc2V2ZXJhbCBhc3BlY3RzLg0KPiANCj4gRmlyc3QgYXNwZWN0IGlzIHRoYXQgaXQgaW5jcmVh
c2VkIHBvc3NpYmlsaXR5IG9mIGNvbW1pdHRpbmcgY29ycnVwdGVkDQo+IGNvdW50ZXIgdmFsdWVz
IHRvIG1kYiwgZm9yIHRoYXQgY29tbWl0IGRpZCBub3QgZWxpbWluYXRlIHBvc3NpYmlsaXR5IG9m
DQo+IHRlbXBvcmFyaWx5IG92ZXJmbG93aW5nIGNvdW50ZXIgdmFsdWVzIGRlc3BpdGUgdGhlc2Ug
Y291bnRlciB2YWx1ZXMgbWlnaHQNCj4gYmUgY29uY3VycmVudGx5IHJlYWQgYnkgaGZzX21kYl9j
b21taXQoKSBiZWNhdXNlIG5vdGhpbmcgc2VyaWFsaXplcw0KPiBoZnNfbmV3X2lub2RlKCkgYW5k
IGhmc19tZGJfY29tbWl0KCkuDQo+IA0KPiAgIGhmc19uZXdfaW5vZGUoKSB7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBoZnNfbWRiX2NvbW1pdCgpIHsNCj4gICAgICguLi5zbmlwcGVkLi4u
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoLi4uc25pcHBlZC4uLikNCj4gICAgIC8v
IDQyOTQ5NjcyOTUgLT4gNDI5NDk2NzI5Ng0KPiAgICAgZmlsZV9jb3VudCA9IGF0b21pYzY0X2lu
Y19yZXR1cm4oJkhGU19TQihzYiktPmZpbGVfY291bnQpOw0KPiAgICAgLy8gRGV0ZWN0cyBvdmVy
Zmxvdw0KPiAgICAgaWYgKGZpbGVfY291bnQgPiBVMzJfTUFYKSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gMCB3aWxsIGJlIGNvbW1pdHRl
ZCBpbnN0ZWFkIG9mIDQyOTQ5NjcyOTUNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtZGItPmRyRmlsQ250ID0gY3B1X3RvX2JlMzIoKHUzMilhdG9t
aWM2NF9yZWFkKCZIRlNfU0Ioc2IpLT5maWxlX2NvdW50KSk7DQo+ICAgICAgIC8vIDQyOTQ5Njcy
OTYgLT4gNDI5NDk2NzI5NQ0KPiAgICAgICBhdG9taWM2NF9kZWMoJkhGU19TQihzYiktPmZpbGVf
Y291bnQpOw0KPiAgICAgICBnb3RvIG91dF9kaXNjYXJkOw0KPiAgICAgfQ0KPiAgICAgKC4uLnNu
aXBwZWQuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICguLi5zbmlwcGVkLi4uKQ0K
PiAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+IA0K
PiBTZWNvbmQgYXNwZWN0IGlzIHRoYXQgaXNfaGZzX2NuaWRfY291bnRzX3ZhbGlkKCkgY2Fubm90
IGNoZWNrIGZvcg0KPiBuZWdhdGl2ZSBjb3VudGVyIHZhbHVlcyBkdWUgdG8gczY0IGFuZCB1MzIg
Y29tcGFyaXNvbi4NCj4gDQo+ICAgaWYgKHVubGlrZWx5KGF0b21pYzY0X3JlYWQoJnNiaS0+Zmls
ZV9jb3VudCkgPiBVMzJfTUFYKSkgew0KPiAgICAgcHJfd2FybigiZmlsZSBjb3VudCBleGNlZWRz
IGxpbWl0XG4iKTsNCj4gICAgIGNvcnJ1cHRlZCA9IHRydWU7DQo+ICAgfQ0KPiANCj4gVGhpcmQg
YXNwZWN0IGlzIHRoYXQgaXNfaGZzX2NuaWRfY291bnRzX3ZhbGlkKCkgbmVlZGxlc3NseSByZWpl
Y3RzDQo+IGNyZWF0aW9uL2RlbGV0aW9uIG9mIGZpbGVzL2RpcmVjdG9yaWVzLCBmb3Igb3ZlcmZs
b3cgb2YgdGhlc2UgY291bnRlcg0KPiB2YWx1ZXMgaXMgbm90IGZhdGFsIGVycm9yIGNvbmRpdGlv
bi4gVGhlc2UgY291bnRlciB2YWx1ZXMgYXJlIG9ubHkgZm9yDQo+IGluZm9ybWF0aW9uYWwgdXNl
ICh3aGljaCBpcyBub3QgZ3VhcmFudGVlZCB0byBiZSBpbiBzeW5jIHdpdGggYWN0dWFsDQo+IG51
bWJlciBvZiBmaWxlcy9kaXJlY3RvcmllcykuIFRoZSBvbmx5IGZhdGFsIGVycm9yIGNvbmRpdGlv
biB0aGF0IG11c3QNCj4gcmVqZWN0IGlzIHRoYXQgYWxsIGF2YWlsYWJsZSAzMmJpdHMgaW5vZGUg
bnVtYmVycyBhcmUgYWxyZWFkeSBpbiB1c2UNCj4gd2hlbiBjcmVhdGluZyBhIGZpbGUgb3IgZGly
ZWN0b3J5LiBPdGhlciBjb25kaXRpb25zIGNhbiBiZSBjaGVja2VkIGFuZA0KPiBjb3JyZWN0ZWQg
d2hlbiBmc2NrLmhmcyBpcyBydW4uDQo+IA0KPiBGb3VydGggYXNwZWN0IGlzIHRoYXQgaXNfaGZz
X2NuaWRfY291bnRzX3ZhbGlkKCkgY2FsbHMgcHJpbnRrKCkgd2l0aG91dA0KPiByYXRlbGltaXQu
IEEgZmlsZXN5c3RlbSBjb3VsZCBzdGF5IGluIG1vdW50ZWQgc3RhdGUgZm9yIGRheXMvd2Vla3Mv
bW9udGhzLA0KPiBhbmQgZS5nLiBzeW5jKCkgcmVxdWVzdCBjb3VsZCBiZSBjYWxsZWQgZm9yIGUu
Zy4gMTAwIHRpbWVzIHBlciBzZWNvbmQuDQo+IFRoZSBjb25zZXF1ZW5jZSB3aWxsIGJlIHN0YWxs
IHByb2JsZW0gZHVlIHRvIHByaW50aygpIGZsb29kaW5nIGFuZC9vcg0KPiBvdXQgb2YgZGlzayBz
cGFjZSBkdWUgdG8gdW5pbXBvcnRhbnQga2VybmVsIG1lc3NhZ2VzLg0KPiANCj4gRml4IHNvbWUg
b2YgdGhlc2UgYXNwZWN0cywgYnkgZG9uJ3QgYWxsb3cgdGVtcG9yYXJpbHkgb3ZlcmZsb3dpbmcg
Y291bnRlcg0KPiB2YWx1ZXMgZm9yIGZpbGVzL2RpcmVjdG9yaWVzIGFuZCByZW1vdmUgcHJpbnRr
KCkgZm9yIGZpbGUvZGlyZWN0b3J5DQo+IGNvdW50ZXJzLiBUaGlzIHBhdGNoIGRvZXMgbm90IHRv
dWNoIG5leHRfaWQgY291bnRlciwgZm9yIHRoZXJlIGFyZQ0KPiBkaWZmZXJlbnQgdG9waWNzIHRv
IGNvbnNpZGVyLg0KPiANCj4gVGVjaG5pY2FsbHkgc3BlYWtpbmcsIHdlIGNhbiBzaHJpbmsgdGhl
c2UgY291bnRlciB2YWx1ZXMgZnJvbSBhdG9taWM2NF90DQo+IHRvIGF0b21pY190LCBidXQgdGhp
cyBwYXRjaCBkb2VzIG5vdCBjaGFuZ2UgYmVjYXVzZSBWaWFjaGVzbGF2IER1YmV5a28NCj4gZG9l
cyBub3Qgd2FudCB0byB0cmVhdCAtMSAobmVnYXRpdmUgdmFsdWUpIGFzIFUzMl9NQVggKHBvc2l0
aXZlIHZhbHVlKS4NCg0KSSBjYW5ub3QgYWNjZXB0IHRoZSBwYXRjaCB3aXRoIHN1Y2ggY29tbWVu
dCBiZWNhdXNlIEkgZG9uJ3QgbmVlZCBpbiBmYXZvci4gV2UNCnNob3VsZCBoYXZlIHRlY2huaWNh
bGx5IHJlYXNvbmFibGUgc29sdXRpb24uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRldHN1byBI
YW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5qcD4NCj4gLS0tDQo+ICBmcy9o
ZnMvaW5vZGUuYyB8IDMwICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZnMvaGZz
L21kYi5jICAgfCAgOCAtLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAyOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9oZnMvaW5vZGUuYyBi
L2ZzL2hmcy9pbm9kZS5jDQo+IGluZGV4IDg3ODUzNWRiNjRkNi4uZTEwZjk2ZDE3MTFlIDEwMDY0
NA0KPiAtLS0gYS9mcy9oZnMvaW5vZGUuYw0KPiArKysgYi9mcy9oZnMvaW5vZGUuYw0KPiBAQCAt
MTg1LDggKzE4NSw2IEBAIHN0cnVjdCBpbm9kZSAqaGZzX25ld19pbm9kZShzdHJ1Y3QgaW5vZGUg
KmRpciwgY29uc3Qgc3RydWN0IHFzdHIgKm5hbWUsIHVtb2RlX3QNCj4gIAlzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnNiID0gZGlyLT5pX3NiOw0KPiAgCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBuZXdfaW5v
ZGUoc2IpOw0KPiAgCXM2NCBuZXh0X2lkOw0KPiAtCXM2NCBmaWxlX2NvdW50Ow0KPiAtCXM2NCBm
b2xkZXJfY291bnQ7DQo+ICAJaW50IGVyciA9IC1FTk9NRU07DQo+ICANCj4gIAlpZiAoIWlub2Rl
KQ0KPiBAQCAtMjE2LDEzICsyMTQsOCBAQCBzdHJ1Y3QgaW5vZGUgKmhmc19uZXdfaW5vZGUoc3Ry
dWN0IGlub2RlICpkaXIsIGNvbnN0IHN0cnVjdCBxc3RyICpuYW1lLCB1bW9kZV90DQo+ICAJSEZT
X0koaW5vZGUpLT50el9zZWNvbmRzd2VzdCA9IHN5c190ei50el9taW51dGVzd2VzdCAqIDYwOw0K
PiAgCWlmIChTX0lTRElSKG1vZGUpKSB7DQo+ICAJCWlub2RlLT5pX3NpemUgPSAyOw0KPiAtCQlm
b2xkZXJfY291bnQgPSBhdG9taWM2NF9pbmNfcmV0dXJuKCZIRlNfU0Ioc2IpLT5mb2xkZXJfY291
bnQpOw0KPiAtCQlpZiAoZm9sZGVyX2NvdW50PiBVMzJfTUFYKSB7DQo+IC0JCQlhdG9taWM2NF9k
ZWMoJkhGU19TQihzYiktPmZvbGRlcl9jb3VudCk7DQo+IC0JCQlwcl9lcnIoImNhbm5vdCBjcmVh
dGUgbmV3IGlub2RlOiBmb2xkZXIgY291bnQgZXhjZWVkcyBsaW1pdFxuIik7DQo+IC0JCQlnb3Rv
IG91dF9kaXNjYXJkOw0KPiAtCQl9DQo+IC0JCWlmIChkaXItPmlfaW5vID09IEhGU19ST09UX0NO
SUQpDQo+ICsJCWF0b21pYzY0X2FkZF91bmxlc3MoJkhGU19TQihzYiktPmZvbGRlcl9jb3VudCwg
MSwgVTMyX01BWCk7DQoNCldlIGNhbm5vdCBzaW1wbHkgc2lsZW50bHkgc3RvcCBhY2NvdW50aW5n
IGZvbGRlcnMgY291bnQuIFdlIHNob3VsZCBjb21wbGFpbiBhbmQNCm11c3QgcmV0dXJuIGVycm9y
Lg0KDQo+ICsJCWlmIChkaXItPmlfaW5vID09IEhGU19ST09UX0NOSUQgJiYgSEZTX1NCKHNiKS0+
cm9vdF9kaXJzICE9IFUxNl9NQVgpDQo+ICAJCQlIRlNfU0Ioc2IpLT5yb290X2RpcnMrKzsNCj4g
IAkJaW5vZGUtPmlfb3AgPSAmaGZzX2Rpcl9pbm9kZV9vcGVyYXRpb25zOw0KPiAgCQlpbm9kZS0+
aV9mb3AgPSAmaGZzX2Rpcl9vcGVyYXRpb25zOw0KPiBAQCAtMjMwLDEzICsyMjMsOCBAQCBzdHJ1
Y3QgaW5vZGUgKmhmc19uZXdfaW5vZGUoc3RydWN0IGlub2RlICpkaXIsIGNvbnN0IHN0cnVjdCBx
c3RyICpuYW1lLCB1bW9kZV90DQo+ICAJCWlub2RlLT5pX21vZGUgJj0gfkhGU19TQihpbm9kZS0+
aV9zYiktPnNfZGlyX3VtYXNrOw0KPiAgCX0gZWxzZSBpZiAoU19JU1JFRyhtb2RlKSkgew0KPiAg
CQlIRlNfSShpbm9kZSktPmNsdW1wX2Jsb2NrcyA9IEhGU19TQihzYiktPmNsdW1wYWJsa3M7DQo+
IC0JCWZpbGVfY291bnQgPSBhdG9taWM2NF9pbmNfcmV0dXJuKCZIRlNfU0Ioc2IpLT5maWxlX2Nv
dW50KTsNCj4gLQkJaWYgKGZpbGVfY291bnQgPiBVMzJfTUFYKSB7DQo+IC0JCQlhdG9taWM2NF9k
ZWMoJkhGU19TQihzYiktPmZpbGVfY291bnQpOw0KPiAtCQkJcHJfZXJyKCJjYW5ub3QgY3JlYXRl
IG5ldyBpbm9kZTogZmlsZSBjb3VudCBleGNlZWRzIGxpbWl0XG4iKTsNCj4gLQkJCWdvdG8gb3V0
X2Rpc2NhcmQ7DQo+IC0JCX0NCj4gLQkJaWYgKGRpci0+aV9pbm8gPT0gSEZTX1JPT1RfQ05JRCkN
Cj4gKwkJYXRvbWljNjRfYWRkX3VubGVzcygmSEZTX1NCKHNiKS0+ZmlsZV9jb3VudCwgMSwgVTMy
X01BWCk7DQoNClRoZSBzYW1lIGhlcmUuIFdlIGNhbm5vdCBzaW1wbHkgc2lsZW50bHkgc3RvcCBh
Y2NvdW50aW5nIGZpbGVzIGNvdW50LiBXZSBzaG91bGQNCmNvbXBsYWluIGFuZCBtdXN0IHJldHVy
biBlcnJvci4NCg0KPiArCQlpZiAoZGlyLT5pX2lubyA9PSBIRlNfUk9PVF9DTklEICYmIEhGU19T
QihzYiktPnJvb3RfZmlsZXMgIT0gVTE2X01BWCkNCj4gIAkJCUhGU19TQihzYiktPnJvb3RfZmls
ZXMrKzsNCj4gIAkJaW5vZGUtPmlfb3AgPSAmaGZzX2ZpbGVfaW5vZGVfb3BlcmF0aW9uczsNCj4g
IAkJaW5vZGUtPmlfZm9wID0gJmhmc19maWxlX29wZXJhdGlvbnM7DQo+IEBAIC0yNzIsMTYgKzI2
MCwxOCBAQCB2b2lkIGhmc19kZWxldGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4gIA0K
PiAgCWhmc19kYmcoImlubyAlbHVcbiIsIGlub2RlLT5pX2lubyk7DQo+ICAJaWYgKFNfSVNESVIo
aW5vZGUtPmlfbW9kZSkpIHsNCj4gLQkJYXRvbWljNjRfZGVjKCZIRlNfU0Ioc2IpLT5mb2xkZXJf
Y291bnQpOw0KPiAtCQlpZiAoSEZTX0koaW5vZGUpLT5jYXRfa2V5LlBhcklEID09IGNwdV90b19i
ZTMyKEhGU19ST09UX0NOSUQpKQ0KPiArCQlhdG9taWM2NF9hZGRfdW5sZXNzKCZIRlNfU0Ioc2Ip
LT5mb2xkZXJfY291bnQsIC0xLCAwKTsNCg0KSSBkb24ndCBzZWUgcG9pbnQgdG8gY2hhbmdlIGF0
b21pYzY0X2RlYygpIG9uIGF0b21pYzY0X2FkZF91bmxlc3MoKSBoZXJlLg0KDQo+ICsJCWlmIChI
RlNfSShpbm9kZSktPmNhdF9rZXkuUGFySUQgPT0gY3B1X3RvX2JlMzIoSEZTX1JPT1RfQ05JRCkg
JiYNCj4gKwkJICAgIEhGU19TQihzYiktPnJvb3RfZGlycykNCj4gIAkJCUhGU19TQihzYiktPnJv
b3RfZGlycy0tOw0KPiAgCQlzZXRfYml0KEhGU19GTEdfTURCX0RJUlRZLCAmSEZTX1NCKHNiKS0+
ZmxhZ3MpOw0KPiAgCQloZnNfbWFya19tZGJfZGlydHkoc2IpOw0KPiAgCQlyZXR1cm47DQo+ICAJ
fQ0KPiAgDQo+IC0JYXRvbWljNjRfZGVjKCZIRlNfU0Ioc2IpLT5maWxlX2NvdW50KTsNCj4gLQlp
ZiAoSEZTX0koaW5vZGUpLT5jYXRfa2V5LlBhcklEID09IGNwdV90b19iZTMyKEhGU19ST09UX0NO
SUQpKQ0KPiArCWF0b21pYzY0X2FkZF91bmxlc3MoJkhGU19TQihzYiktPmZpbGVfY291bnQsIC0x
LCAwKTsNCg0KVGhlIHNhbWUgY29tbWVudCBoZXJlLg0KDQo+ICsJaWYgKEhGU19JKGlub2RlKS0+
Y2F0X2tleS5QYXJJRCA9PSBjcHVfdG9fYmUzMihIRlNfUk9PVF9DTklEKSAmJg0KPiArCSAgICBI
RlNfU0Ioc2IpLT5yb290X2ZpbGVzKQ0KPiAgCQlIRlNfU0Ioc2IpLT5yb290X2ZpbGVzLS07DQo+
ICAJaWYgKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkpIHsNCj4gIAkJaWYgKCFpbm9kZS0+aV9ubGlu
aykgew0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL21kYi5jIGIvZnMvaGZzL21kYi5jDQo+IGluZGV4
IGE5N2NlYTM1Y2EyZS4uZTc5ZTM2YjdlZDg0IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnMvbWRiLmMN
Cj4gKysrIGIvZnMvaGZzL21kYi5jDQo+IEBAIC03MywxNCArNzMsNiBAQCBib29sIGlzX2hmc19j
bmlkX2NvdW50c192YWxpZChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KPiAgCQlwcl93YXJuKCJu
ZXh0IENOSUQgZXhjZWVkcyBsaW1pdFxuIik7DQo+ICAJCWNvcnJ1cHRlZCA9IHRydWU7DQo+ICAJ
fQ0KPiAtCWlmICh1bmxpa2VseShhdG9taWM2NF9yZWFkKCZzYmktPmZpbGVfY291bnQpID4gVTMy
X01BWCkpIHsNCj4gLQkJcHJfd2FybigiZmlsZSBjb3VudCBleGNlZWRzIGxpbWl0XG4iKTsNCj4g
LQkJY29ycnVwdGVkID0gdHJ1ZTsNCj4gLQl9DQo+IC0JaWYgKHVubGlrZWx5KGF0b21pYzY0X3Jl
YWQoJnNiaS0+Zm9sZGVyX2NvdW50KSA+IFUzMl9NQVgpKSB7DQo+IC0JCXByX3dhcm4oImZvbGRl
ciBjb3VudCBleGNlZWRzIGxpbWl0XG4iKTsNCj4gLQkJY29ycnVwdGVkID0gdHJ1ZTsNCj4gLQl9
DQoNCldlIG5lZWQgdG8gaGF2ZSB0aGlzIGNoZWNrIGhlcmUuIEkgZG9uJ3Qgc2VlIHRoZSBwb2lu
dCB0byByZW1vdmUgdGhlc2UgY2hlY2tzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAgDQo+ICAJ
cmV0dXJuICFjb3JydXB0ZWQ7DQo+ICB9DQo=

