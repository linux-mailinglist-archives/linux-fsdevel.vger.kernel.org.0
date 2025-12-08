Return-Path: <linux-fsdevel+bounces-70980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F0DCAE13A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 20:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06F953003DEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5B2ECEA5;
	Mon,  8 Dec 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="M7EU31Kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3262ECD2A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221943; cv=fail; b=o5H55zXUucvLD3blpMwI1yaaTD9aq+Ta2o4XDChdcGYTcqCXNqvFnDGQDmoRb1nVQRx0pxnmG6eL/bDzHVwpnkcnc5duobL3F/D8y+C4YkwXRNxiB8HnwRESTvGM2jZPx//ikE6n3wvDJU4yIOZrCWQk5/xGY6Q84mehhTRzzfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221943; c=relaxed/simple;
	bh=lJCW5tadsr8cX1grQiyPiGUmtvqV4LeZhK9cxQl+q/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rp7Gv+eHqv8riHYj2ImFTjcr5IpH2ifN4bE8e5EDzFuuGeG7ruyCcQuf2sjxZuF7JRYIwkvfjIiWJOCpUL6XAosHo6JUVsppEEEIFNqelra1g0kBPFAL4olF7cRwWiiBYJGsWtne0bkb8mk2D5PYRgBW4WIgJpb+pi1B/9QDrGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=M7EU31Kq; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020083.outbound.protection.outlook.com [52.101.85.83]) by mx-outbound8-123.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 08 Dec 2025 19:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anuQkKOcDnvhkubrI+Bs7BwMvLm7GxUkuM0yg63JZoWxiqkweljY+OTnJuRe/ET9xswbWZ11irTNBOVq1Sr/aKRpIc5wUKDQCjZMeH0OTuPQgIw0RiXuTPqQZEbfp3QE5HiSKFNVKSq3lNg/mVckWZ8uLsRnPX/A4b5i3sqKX9ucTpeYbLfEkA+w9MwoeKq6H1MGAXWOxemp6DJxREyTKA9hSco0MvCUnBuElrG7SJ7WLiD/jA4Vsb6nM4Khp90cUcofPLi1gvK3WTmZQaUXHd8r1U38zSXokO5f5svbnaeFHAZ5CoasMIYWNMeHkYlGPWRnB39xhtmt7XXAnfE7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJCW5tadsr8cX1grQiyPiGUmtvqV4LeZhK9cxQl+q/U=;
 b=HhLXGZd+p/bkBrFg8PUc7LWu+6HRN5c5EYSNfSnx0qcA+6iyig9PwzbFEVMQhzREHkcEyJr9rekPG6onmHABS3z5yCoKIoC8ypWF4YZC2egqrJeAuOMgwqfhiw4jwFniKXLH+HQ6wtbXU8ho8sZZy2qfBsFPrCksCBw0ScGkO3O841zy5zIqbke9y7c3ZhLZJybqr/knTCYlB7hsYZ7b17EE1nW+tazyfJD26ixKgmSTwEITaR/f7WfcFoO28ZskyBZxNmXr0rOnmqRq0qVljPz4vJPs5MQu+MDOMUuAJu5G33wvtyVkpo0QliL8mK/QmkH5RsSPSvGPsU3r9Co0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJCW5tadsr8cX1grQiyPiGUmtvqV4LeZhK9cxQl+q/U=;
 b=M7EU31KqbRaPqHw60diIXtuCo8wB+sGV1XG0cxmin/vDDUBgnB975QrEeMykRYMXd7k4+DoOhnn2JI2fOK4dQgF9smAsOWIYLdqyKx8pnozUaOuU1DiKz18bvA3/WvUt0nEkrUb3cpeDOfvGd8xhWAVnNK08K8aYhgldN3Dl7LE=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MN0PR19MB5828.namprd19.prod.outlook.com (2603:10b6:208:37b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Mon, 8 Dec
 2025 17:52:17 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:52:16 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Abhishek Gupta <abhishekmgupta@google.com>, Bernd Schubert
	<bernd@bsbernd.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, Swetha Vadlakonda
	<swethv@google.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
Thread-Topic: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
Thread-Index:
 AQHcXuZx9b5pWktoG0+UcBaSWX3FrbUFUzGAgAE1FoCAAJ6SAIAHDCWAgAnjZ4CAAAKVAA==
Date: Mon, 8 Dec 2025 17:52:16 +0000
Message-ID: <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com>
References:
 <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
 <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
 <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
In-Reply-To:
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|MN0PR19MB5828:EE_
x-ms-office365-filtering-correlation-id: 9c925a51-6482-4a76-4e8a-08de368286ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEF5MW5OT0FVMmZkSzUwT3dmQ0RrSmxiS2svZmtrSjc0a2dQUm5Wc3V0Qjc4?=
 =?utf-8?B?NmNjTTB3T2swek1zd2VjL2s3eFI2dkllWm14Q3BwY2tpTlRzUm5LR01nN3Bs?=
 =?utf-8?B?c1J1bEtFYTFaWldPSHBKWUR6OVVTek10bU5OWC9oQWlCY1hQK2F3c21aQWQy?=
 =?utf-8?B?TUp2V01GckZiYVNML0prRHlpeExWTlNNZEVOMVZPTVVpZVFLNEpPZUhNSmU1?=
 =?utf-8?B?bGJYODlSMDZRVHFOSGwxZHdMVkpQWGQvR0EzVGttODIwbGJNUDhwdCtxSXYw?=
 =?utf-8?B?N3p4VTMzcFN0amJBTnZsbEIyUnZUVmw4VDRxTjhrRWR1SDhkQzZ1SUs2RVY2?=
 =?utf-8?B?UVNBTEFIWFVnZWpoNXlKdmZqeERZdHZydEFER3ZNUFhNM3RMSERsTXhvUUx6?=
 =?utf-8?B?OTVHZ0htcnp4OE11bDVaM3ZWNlliVlFWdUVDb0VHeTlqVk01TkE2TUVST2R5?=
 =?utf-8?B?c0pJa2dVTmp3QXhPalZrbFJybkxVSlAycEdTayt1bXM4UUd6c3RSMVRCMG56?=
 =?utf-8?B?cm1rUnFsdTA4OWZ4a1djVWxiN1VKWkhHMEd1cnh3dTB2NHVrQkxHOTcwSSt4?=
 =?utf-8?B?Nmh1bnBRdjJnU2hTL2xySzVmZlNvZHBtS0FBK2kvblNPcVp0UU94RlZmMzRL?=
 =?utf-8?B?ZThLSitYVG1CQzA4ODB3RUNZd1cvc2NGa2VhbVc3Y0NZUDVEa3A2cWYveFk1?=
 =?utf-8?B?Z1FyTGprUEszMmwybTdPRnFpNmxGYTVkdjRVbkVLeEpZeE9lRGpsaTdxcFpY?=
 =?utf-8?B?VFFVa0VFYldwTHAxR1kyaWFmaHlvLzkvQ3NQZXZwTDJHRjRTTkRHRW0vcGg5?=
 =?utf-8?B?ZWdBSmxLSnJRY25DelRiODF4alhnV3M1Yy9QUzNlcXBJWnNnNDVHZEFaY1M3?=
 =?utf-8?B?UjllbzlhNlErak1vemVLSnlwOHE5V0RLbDEwMVhDTzRwYUhyTm1qd2VCaWtk?=
 =?utf-8?B?VWxLRDg4dTRYdFF6R1hTeGwvOXFpT1YrZlE1VlpGWVUzTXJPOGVvSlJvdGlZ?=
 =?utf-8?B?dS9RSFpPb1l1MC9kdW44TUNqVmwvK1BIeVNCcG8zVVNrVTFJTUhaZkZiejNy?=
 =?utf-8?B?bWJteU9mLzRMbWJkcXlkVzdhNXhDd3NWS2lVU1lnUXozeGRDZDFRNFRyWktD?=
 =?utf-8?B?bmZFSHU1cjZ5YXN1SDgyWndzNmFuN2luK0pERXVVRVNuUk9FMVcvN1VocXgz?=
 =?utf-8?B?Z3RHWmZIYnFvdmdaODY4MEpBQU5MVEx1ZHZoVWtUMERCNktMd2liNFJUYnBR?=
 =?utf-8?B?a01ERnFYK29jSHRsbzZBa2YxYXNLZjl5RnB1bTRqWnQyNUl0eUs5eDBIYzZG?=
 =?utf-8?B?YmZvdC9relFLd2tWdTgwRXFWaHpIYTNLN2RGMGZjUGR4T1Y0NmFJN0gwQkhk?=
 =?utf-8?B?blE0VDBsaCt0VUVyOGhqWnpBT3ZrRGdhVzFNS3hJQ3EycWlrbmZNekpmOUtI?=
 =?utf-8?B?TExxNExFQ244Qmd2S3BLQTJJZXg1cXlnUklWTTB4QXFUeVd0SXpJTHpTaERk?=
 =?utf-8?B?Nyt0TXgrKzJyR2FTaklrN3VTU1NuWnVUUVg3VDVSNnVZdnRMM05STmMrWmlI?=
 =?utf-8?B?NzBkRExFWlZRSS9QbjZFUW1ZSVZmWDJ4dkJ3OUtVd29SYUZDOFVpRXRSams0?=
 =?utf-8?B?a0g0M3ZEWEJXc2tUYzdoalQ4UEp2K2VYcHhjZ21rakowaldFcGlLYW1JWWxE?=
 =?utf-8?B?ODlub09HRWlHR0ZwalJTZUliMVRiOHVkNlErbHFFK094WFhVc1djMGdXYlIx?=
 =?utf-8?B?U1Y3TnZad1dza3R4VGJxL3pneWNkVkFBdFI5TEhGcmVtbllpakJxZTNOdHZo?=
 =?utf-8?B?d3dEUElXZFRKbGJvaWVramtYb3BrWjdOc3l3NzAwV2tBVDh0eTNMVks4UXVw?=
 =?utf-8?B?U3J3QXV6QlkxMGtLVUJEbWozZmJOZHFFZ2ZvK1l6Q1JyTnhaOTZYendHaW1y?=
 =?utf-8?B?UGJQd3Bua011SFdzNnVVNmZ1enEwK0xiQ3lVZHpPeE8rTTZjMnRhM2tMaFcy?=
 =?utf-8?B?eFMzSnNBV0x3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWptdG85RGZCREJSVXFZOHkzVlkxbzBBbUViSXhGdWxXLzB5NkhnaTRTSVhI?=
 =?utf-8?B?SExhcjZ3dWJtTEJlcHZNdVVZcGtSSWl3bG8vYUVZUFVMN0RYVGdVYmdMeDBS?=
 =?utf-8?B?Q3NXa0hxVFFlVkh1U0o2dzRBTmJrb0tVRFdFMHh6eENVSFRPQzRBc0YzSlhQ?=
 =?utf-8?B?STBBTTNWbjY1QTFJVENOaHF0QmhJSzNURGgzQXFyQ3FJTnJFY0s5SjRhNzEr?=
 =?utf-8?B?M0VRWnVTeG9TdmR5T1BBMmptbVIzMUNwTjZOVEkxRmRMcW4raVpYdVgrcUp1?=
 =?utf-8?B?eEh0ZTAyU0hBcHdqUytkN0M3VjkxNkxuSVFEcklBNnlYWTdHRzQ0aXB0UWt1?=
 =?utf-8?B?RnNrdEdBcnByblE2MTNQbHhWTnJPeThkV0kvUmo1emg0emwrZFVZMkdYZWNM?=
 =?utf-8?B?TWhCTUNLZDJYSm83VWlaRmJSRk5ZZlFscExnTkhWZjBkL2JxdGtaVndhS2F6?=
 =?utf-8?B?L05TZGVtWnI5dnN3RHQySS9WQzZzc0p4bWU2c3cxbU9SYlJQaHBaWlB1Ny9B?=
 =?utf-8?B?b25aUFg1MEF3WXJ1WGpRMjFxZTArOThIMmtkcEpCQjdubmVJU3drME4xRkxJ?=
 =?utf-8?B?L3pGbHNYU1FkV3pQdkw5YU9aMnA2c1BzQXBTMDVIRlhGK1YxMGVCc2dNbllT?=
 =?utf-8?B?TVZrZVJRWkZGcjNTK0hWR1g4eFgwSTdnSmNHT3UzZ1BZczlNVVg4WDF5TjFT?=
 =?utf-8?B?alRSVERJR1FWODAxV1FOTGxkdi90cEJQYTlUeDRDbXhDcGtyVkQ4NW1hOXNw?=
 =?utf-8?B?bG9zLzE2YlNkejN1VnVmT1U5c0RoWEFSYWNubDBxVUo4aTV0WDhGMWZHc0xS?=
 =?utf-8?B?WTlJYXplY09ZbkQ4ZXp1TjFHSEFmR0RaazdoNXo2TFh6ekx3OXhpZjY5SWEy?=
 =?utf-8?B?cG5JRTVYNytaWVlQdUZiN1ZQdDlUa05JSm02alkxanRqR2E4SHhwUlpIYzdq?=
 =?utf-8?B?NUs0T0Z1QzFJbmVOTkRuVnJ3ZDNzbmRQWFk2NUNMMG5HZHJqc00vMU0rU2Vy?=
 =?utf-8?B?emZFeDhqOExmOTF5NWQzeTliUGZ3T01IQlVLazNsUzFqRTBpZFZZNkgyejRl?=
 =?utf-8?B?dWFFQklCZEg1QUdYa2IzSG5CeGtINFpzNTFNbENjRjRXMWl3NjlqM1A2NmRu?=
 =?utf-8?B?M2tXM0pENVo0OFhzU1Ivb1ZTVjIxcEQ0TUhUdG5KZm9PT01vTHR2YkhCbjFO?=
 =?utf-8?B?QmVKK2JpLzFFdk1hY1dtMjZHeHJmdmV3dkVsUWV1OXVQa1FNN1FtUWVWamlS?=
 =?utf-8?B?Q0pETHJiQ04wVWpEUGtOaXBaR1YrRlRTT3VpeEl2V1pSRWQzZUpQd2F1Zi9F?=
 =?utf-8?B?YmFGWnkzays4MEVLU2pNUWZVNlhJczFBVUd3NXNicENnT29xdjBneUFDSjJU?=
 =?utf-8?B?MFAxNFJzcWRNanlhS21KUUJVSUF0bFdyenFBb3lnRm1uODZHajBlOFkxcmxV?=
 =?utf-8?B?cGtzQTNXVS81ZkR1cTBsV05wTWVQSWJrSXFFZUkyRDRMTGQrQ3M2QXkxVStn?=
 =?utf-8?B?eVIzdjhueXl0bENhREFKNXpaZHVIQzk1VVgzUHhQQ0dEUFZGNWlENTZpS3U5?=
 =?utf-8?B?YUQ0eUdCckE4anFhQiszT2xpM2hBRVFoVEJzeTlKYVZOUEw4bVRLTnN4TGJM?=
 =?utf-8?B?N3lna2xoUndOYjJpTmc0YXNqVTZpU3JZVGxXdmF5M1NJOTk0TjhYYTBOYzIr?=
 =?utf-8?B?cllmWVVRSUFsRlplS2NHMEZtY1JZTnViVHFCNXU2Y1VwMVBMcHRJVk1LNHlr?=
 =?utf-8?B?b1JKRnN1RnJpQ1NBT1NLZE1kK3ovVXNvanNJZSt1UDJoclFjcllPajZaU294?=
 =?utf-8?B?MmNZSk1LL3JuL1drL090eFp2bm14Q0FMb29TakJGWFZxS21NNzhtSGRKSUtp?=
 =?utf-8?B?dkFvcTFRZjlhVWh5eDJTaU1LRjU5SklxaHlGTkpqcTFKME5DbjNCQnk3N2NJ?=
 =?utf-8?B?OTZZUXdwb0h5YXNtbGlSSTFGYjRlTkJnVnAyanFQMjRsbVZ3bGFTZi9Dd3JP?=
 =?utf-8?B?UE9YWXltMlFuMjNjb0R3YVh2MGtoTWhHS015MzcvMmxqVmt2U2Z1ZUdZbHoz?=
 =?utf-8?B?UEMzQ3lJdWdTQi8xbHcrdUFaaEFSbXU1aytnOTBBOCtJWHNiUTF1SEdNUTdz?=
 =?utf-8?B?TlJPZWRyTTJ2NFpVdWlOT0xEOFR1SjhUNjRNN09JcFlMRVNDR1M1Ykg5dmN4?=
 =?utf-8?Q?Ws6MMpC0zTJiP5faMJlO1YI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF23B3C3812CA346B6D3238C997E6887@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 7oR7sohiaA7GaWa+olL5Hf71SOR8Da0odYr+s/faNysUuPCpJf7loTztIPxUf+3JyWe2ZFUmuyCq0AvqdXa/yGLqjU7/P8iMRES/t3+Im/fhy0AI1cWWizI7SFsB6XBn8NEWSRWDqAvaD4cR3HclnhdxZSlAOGp50J3JC/hxieWaorGHm30otLptUysNMoclXKlz+SLw+snmwTgwavvhwabQ2EsfEI2uVCyxM9Os5Owk8EoLICiTXItbdLILzWnIQjUl2gX3NPn2Uyx1gupdueXBWgV7IBarm4HSTKRiRZuYhMIQNgRxkWnQAA9DyiL09QTwV2cUekmcw6T8OLrXBA3wqgnUWZsLvStHzldXPkKfqR3WWxKaajBhpsnLa8GKqhBp6rfPt0o23OhCpEZvRGRklrIfHdAG268qngaT2sVGvfOE7Pi7T3TfRufqa+7o+5QccOPVfot5QF5SYhY46/NTLj65xrTXw0iSVAtfOzlwK8vIpSHssF0Wex0syFohe44xOvejmV6NquphQqM/uMvBgiTePXaqSBLMoLbCL4/msT+wKeyYh5ePbBSZX+y3ttNQ4LiOzWlT1MBeGK/tL386sU/+4u2EYP2n5Rp60r1uqyc+yGqmu4zfjHOEEhBBE98s5qifAY+KnkPbvwGmnw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c925a51-6482-4a76-4e8a-08de368286ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 17:52:16.8260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/6aZQvhS7K0c037X5RACzBKyPm0hgja4P0xsbcVuANEL+/dL3zAyP7fxB+ZFL/na8M9tpoWV/Icsubwtrv50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5828
X-OriginatorOrg: ddn.com
X-BESS-ID: 1765221938-102171-7649-7724-1
X-BESS-VER: 2019.1_20251204.0155
X-BESS-Apparent-Source-IP: 52.101.85.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYWRsZAVgZQ0DLN0NDMzMAyxd
	TA0szcKM0s0TDF0MwoycLAJNXAPNFEqTYWAI3MIWxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269520 [from 
	cloudscan15-67.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

SGkgQWJoaXNoZWssDQoNCnllcyBJIHdhcyBhYmxlIHRvIHJ1biBpdCB0b2RheSwgd2lsbCBzZW5k
IG91dCBhIG1haWwgbGF0ZXIuIFNvcnJ5LA0KcmF0aGVyIGJ1c3kgd2l0aCBvdGhlciB3b3JrLg0K
DQoNCkJlc3QsDQpCZXJuZA0KDQpPbiAxMi84LzI1IDE4OjQzLCBBYmhpc2hlayBHdXB0YSB3cm90
ZToNCj4gSGkgQmVybmQsDQo+IA0KPiBXZXJlIHlvdSBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgaXNz
dWUgbG9jYWxseSB1c2luZyB0aGUgc3RlcHMgSSBwcm92aWRlZD8NCj4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIHlvdSByZXF1aXJlIGFueSBmdXJ0aGVyIGluZm9ybWF0aW9uIG9yIGFzc2lzdGFuY2Uu
DQo+IA0KPiBUaGFua3MsDQo+IEFiaGlzaGVrDQo+IA0KPiANCj4gT24gVHVlLCBEZWMgMiwgMjAy
NSBhdCA0OjEy4oCvUE0gQWJoaXNoZWsgR3VwdGEgPGFiaGlzaGVrbWd1cHRhQGdvb2dsZS5jb20N
Cj4gPG1haWx0bzphYmhpc2hla21ndXB0YUBnb29nbGUuY29tPj4gd3JvdGU6DQo+IA0KPiAgICAg
SGkgQmVybmQsDQo+IA0KPiAgICAgQXBvbG9naWVzIGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uZGlu
Zy4NCj4gDQo+ICAgICBIZXJlIGFyZSB0aGUgc3RlcHMgdG8gcmVwcm9kdWNlIHRoZSBGVVNFIHBl
cmZvcm1hbmNlIGlzc3VlIGxvY2FsbHkNCj4gICAgIHVzaW5nIGEgc2ltcGxlIHJlYWQtYmVuY2gg
RlVTRSBmaWxlc3lzdGVtOg0KPiANCj4gICAgIDEuIFNldCB1cCB0aGUgRlVTRSBGaWxlc3lzdGVt
Og0KPiAgICAgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9qYWNvYnNhL2Z1c2UuZ2l0IDxo
dHRwczovL2dpdGh1Yi5jb20vDQo+ICAgICBqYWNvYnNhL2Z1c2UuZ2l0PiBqYWNvYnNhLWZ1c2UN
Cj4gICAgIGNkIGphY29ic2EtZnVzZS9zYW1wbGVzL21vdW50X3JlYWRiZW5jaGZzDQo+ICAgICAj
IFJlcGxhY2UgPG1udF9kaXI+IHdpdGggeW91ciBkZXNpcmVkIG1vdW50IHBvaW50DQo+ICAgICBn
byBydW4gbW91bnQuZ28gLS1tb3VudF9wb2ludCA8bW50X2Rpcj4NCj4gDQo+ICAgICAyLiBSdW4g
RmlvIEJlbmNobWFyayAoaW9kZXB0aCAxKToNCj4gICAgIGZpb8KgIC0tbmFtZT1yYW5kcmVhZCAt
LXJ3PXJhbmRyZWFkIC0taW9lbmdpbmU9aW9fdXJpbmcgLS10aHJlYWQNCj4gICAgIC0tZmlsZW5h
bWU9PG1udF9kaXI+L3Rlc3QgLS1maWxlc2l6ZT0xRyAtLXRpbWVfYmFzZWQ9MSAtLXJ1bnRpbWU9
NXMNCj4gICAgIC0tYnM9NEsgLS1udW1qb2JzPTEgLS1pb2RlcHRoPTEgLS1kaXJlY3Q9MSAtLWdy
b3VwX3JlcG9ydGluZz0xDQo+IA0KPiAgICAgMy4gUnVuIEZpbyBCZW5jaG1hcmsgKGlvZGVwdGgg
NCk6DQo+ICAgICBmaW8gLS1uYW1lPXJhbmRyZWFkIC0tcnc9cmFuZHJlYWQgLS1pb2VuZ2luZT1p
b191cmluZyAtLXRocmVhZA0KPiAgICAgLS1maWxlbmFtZT08bW50X2Rpcj4vdGVzdCAtLWZpbGVz
aXplPTFHIC0tdGltZV9iYXNlZD0xIC0tcnVudGltZT01cw0KPiAgICAgLS1icz00SyAtLW51bWpv
YnM9MSAtLWlvZGVwdGg9NCAtLWRpcmVjdD0xIC0tZ3JvdXBfcmVwb3J0aW5nPTENCj4gDQo+IA0K
PiAgICAgRXhhbXBsZSBSZXN1bHRzIG9uIEtlcm5lbCA2LjE0IChSZWdyZXNzaW9uIE9ic2VydmVk
KQ0KPiANCj4gICAgIFRoZSBmb2xsb3dpbmcgb3V0cHV0IHNob3dzIHRoZSBsYWNrIG9mIHNjYWxp
bmcgb24gbXkgbWFjaGluZSB3aXRoDQo+ICAgICBLZXJuZWwgNi4xNDoNCj4gDQo+ICAgICBLZXJu
ZWw6DQo+ICAgICBMaW51eCBhYmhpc2hlay13ZXN0NGEtMjUwNCA2LjE0LjAtMTAxOS1nY3AgIzIw
LVVidW50dSBTTVAgV2VkIE9jdCAxNQ0KPiAgICAgMDA6NDE6MTIgVVRDIDIwMjUgeDg2XzY0IHg4
Nl82NCB4ODZfNjQgR05VL0xpbnV4DQo+IA0KPiAgICAgSW9kZXB0aCA9IDE6DQo+ICAgICBSRUFE
OiBidz03NC4zTWlCL3MgKDc3LjlNQi9zKSwgLi4uIGlvPTM3Mk1pQiAoMzkwTUIpLCBydW49NTAw
MS01MDAxbXNlYw0KPiANCj4gICAgIElvZGVwdGggPSA0Og0KPiAgICAgUkVBRDogYnc9ODcuNk1p
Qi9zICg5MS45TUIvcyksIC4uLiBpbz00MzhNaUIgKDQ1OU1CKSwgcnVuPTUwMDAtNTAwMG1zZWMN
Cj4gDQo+ICAgICBUaGFua3MsDQo+ICAgICBBYmhpc2hlaw0KPiANCj4gDQo+ICAgICBPbiBGcmks
IE5vdiAyOCwgMjAyNSBhdCA0OjM14oCvQU0gQmVybmQgU2NodWJlcnQgPGJlcm5kQGJzYmVybmQu
Y29tDQo+ICAgICA8bWFpbHRvOmJlcm5kQGJzYmVybmQuY29tPj4gd3JvdGU6DQo+ICAgICA+DQo+
ICAgICA+IEhpIEFiaGlzaGVrLA0KPiAgICAgPg0KPiAgICAgPiBPbiAxMS8yNy8yNSAxNDozNywg
QWJoaXNoZWsgR3VwdGEgd3JvdGU6DQo+ICAgICA+ID4gSGkgQmVybmQsDQo+ICAgICA+ID4NCj4g
ICAgID4gPiBUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLg0KPiAgICAgPiA+IFBsZWFzZSBm
aW5kIGJlbG93IHRoZSBmaW8gb3V0cHV0IG9uIDYuMTEgJiA2LjE0IGtlcm5lbCB2ZXJzaW9ucy4N
Cj4gICAgID4gPg0KPiAgICAgPiA+DQo+ICAgICA+ID4gT24ga2VybmVsIDYuMTENCj4gICAgID4g
Pg0KPiAgICAgPiA+IH4vZ2NzZnVzZSQgdW5hbWUgLWENCj4gICAgID4gPiBMaW51eCBhYmhpc2hl
ay1jNC0xOTItd2VzdDRhIDYuMTEuMC0xMDE2LWdjcCAjMTZ+MjQuMDQuMS1VYnVudHUgU01QDQo+
ICAgICA+ID4gV2VkIE1heSAyOCAwMjo0MDo1MiBVVEMgMjAyNSB4ODZfNjQgeDg2XzY0IHg4Nl82
NCBHTlUvTGludXgNCj4gICAgID4gPg0KPiAgICAgPiA+IGlvZGVwdGggPSAxDQo+ICAgICA+ID4g
On4vZmlvLWZpby0zLjM4JCAuL2ZpbyAtLW5hbWU9cmFuZHJlYWQgLS1ydz1yYW5kcmVhZA0KPiAg
ICAgPiA+IC0taW9lbmdpbmU9aW9fdXJpbmcgLS10aHJlYWQNCj4gICAgID4gPiAtLWZpbGVuYW1l
X2Zvcm1hdD0nL2hvbWUvYWJoaXNoZWttZ3VwdGFfZ29vZ2xlX2NvbS9idWNrZXQvJGpvYm51bScN
Cj4gICAgID4gPiAtLWZpbGVzaXplPTFHIC0tdGltZV9iYXNlZD0xIC0tcnVudGltZT0xNXMgLS1i
cz00SyAtLW51bWpvYnM9MQ0KPiAgICAgPiA+IC0taW9kZXB0aD0xIC0tZ3JvdXBfcmVwb3J0aW5n
PTEgLS1kaXJlY3Q9MQ0KPiAgICAgPiA+IHJhbmRyZWFkOiAoZz0wKTogcnc9cmFuZHJlYWQsIGJz
PShSKSA0MDk2Qi00MDk2QiwgKFcpDQo+ICAgICA0MDk2Qi00MDk2QiwgKFQpDQo+ICAgICA+ID4g
NDA5NkItNDA5NkIsIGlvZW5naW5lPWlvX3VyaW5nLCBpb2RlcHRoPTENCj4gICAgID4gPiBmaW8t
My4zOA0KPiAgICAgPiA+IFN0YXJ0aW5nIDEgdGhyZWFkDQo+ICAgICA+ID4gLi4uDQo+ICAgICA+
ID4gUnVuIHN0YXR1cyBncm91cCAwIChhbGwgam9icyk6DQo+ICAgICA+ID7CoCDCoCBSRUFEOiBi
dz0zMzExS2lCL3MgKDMzOTFrQi9zKSwgMzMxMUtpQi9zLTMzMTFLaUIvcw0KPiAgICAgPiA+ICgz
Mzkxa0Ivcy0zMzkxa0IvcyksIGlvPTQ4LjVNaUIgKDUwLjlNQiksIHJ1bj0xNTAwMS0xNTAwMW1z
ZWMNCj4gICAgID4gPg0KPiAgICAgPiA+IGlvZGVwdGg9NA0KPiAgICAgPiA+IDp+L2Zpby1maW8t
My4zOCQgLi9maW8gLS1uYW1lPXJhbmRyZWFkIC0tcnc9cmFuZHJlYWQNCj4gICAgID4gPiAtLWlv
ZW5naW5lPWlvX3VyaW5nIC0tdGhyZWFkDQo+ICAgICA+ID4gLS1maWxlbmFtZV9mb3JtYXQ9Jy9o
b21lL2FiaGlzaGVrbWd1cHRhX2dvb2dsZV9jb20vYnVja2V0LyRqb2JudW0nDQo+ICAgICA+ID4g
LS1maWxlc2l6ZT0xRyAtLXRpbWVfYmFzZWQ9MSAtLXJ1bnRpbWU9MTVzIC0tYnM9NEsgLS1udW1q
b2JzPTENCj4gICAgID4gPiAtLWlvZGVwdGg9NCAtLWdyb3VwX3JlcG9ydGluZz0xIC0tZGlyZWN0
PTENCj4gICAgID4gPiByYW5kcmVhZDogKGc9MCk6IHJ3PXJhbmRyZWFkLCBicz0oUikgNDA5NkIt
NDA5NkIsIChXKQ0KPiAgICAgNDA5NkItNDA5NkIsIChUKQ0KPiAgICAgPiA+IDQwOTZCLTQwOTZC
LCBpb2VuZ2luZT1pb191cmluZywgaW9kZXB0aD00DQo+ICAgICA+ID4gZmlvLTMuMzgNCj4gICAg
ID4gPiBTdGFydGluZyAxIHRocmVhZA0KPiAgICAgPiA+IC4uLg0KPiAgICAgPiA+IFJ1biBzdGF0
dXMgZ3JvdXAgMCAoYWxsIGpvYnMpOg0KPiAgICAgPiA+wqAgwqAgUkVBRDogYnc9MTEuME1pQi9z
ICgxMS42TUIvcyksIDExLjBNaUIvcy0xMS4wTWlCL3MNCj4gICAgID4gPiAoMTEuNk1CL3MtMTEu
Nk1CL3MpLCBpbz0xNjZNaUIgKDE3NE1CKSwgcnVuPTE1MDAyLTE1MDAybXNlYw0KPiAgICAgPiA+
DQo+ICAgICA+ID4NCj4gICAgID4gPiBPbiBrZXJuZWwgNi4xNA0KPiAgICAgPiA+DQo+ICAgICA+
ID4gOn4kIHVuYW1lIC1hDQo+ICAgICA+ID4gTGludXggYWJoaXNoZWstd2VzdDRhLTI1MDQgNi4x
NC4wLTEwMTktZ2NwICMyMC1VYnVudHUgU01QIFdlZCBPY3QgMTUNCj4gICAgID4gPiAwMDo0MTox
MiBVVEMgMjAyNSB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCj4gICAgID4gPg0KPiAg
ICAgPiA+IGlvZGVwdGg9MQ0KPiAgICAgPiA+IDp+JCBmaW8gLS1uYW1lPXJhbmRyZWFkIC0tcnc9
cmFuZHJlYWQgLS1pb2VuZ2luZT1pb191cmluZyAtLXRocmVhZA0KPiAgICAgPiA+IC0tZmlsZW5h
bWVfZm9ybWF0PScvaG9tZS9hYmhpc2hla21ndXB0YV9nb29nbGVfY29tL2J1Y2tldC8kam9ibnVt
Jw0KPiAgICAgPiA+IC0tZmlsZXNpemU9MUcgLS10aW1lX2Jhc2VkPTEgLS1ydW50aW1lPTE1cyAt
LWJzPTRLIC0tbnVtam9icz0xDQo+ICAgICA+ID4gLS1pb2RlcHRoPTEgLS1ncm91cF9yZXBvcnRp
bmc9MSAtLWRpcmVjdD0xDQo+ICAgICA+ID4gcmFuZHJlYWQ6IChnPTApOiBydz1yYW5kcmVhZCwg
YnM9KFIpIDQwOTZCLTQwOTZCLCAoVykNCj4gICAgIDQwOTZCLTQwOTZCLCAoVCkNCj4gICAgID4g
PiA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9aW9fdXJpbmcsIGlvZGVwdGg9MQ0KPiAgICAgPiA+IGZp
by0zLjM4DQo+ICAgICA+ID4gU3RhcnRpbmcgMSB0aHJlYWQNCj4gICAgID4gPiAuLi4NCj4gICAg
ID4gPiBSdW4gc3RhdHVzIGdyb3VwIDAgKGFsbCBqb2JzKToNCj4gICAgID4gPsKgIMKgIFJFQUQ6
IGJ3PTM1NzZLaUIvcyAoMzY2MmtCL3MpLCAzNTc2S2lCL3MtMzU3NktpQi9zDQo+ICAgICA+ID4g
KDM2NjJrQi9zLTM2NjJrQi9zKSwgaW89NTIuNE1pQiAoNTQuOU1CKSwgcnVuPTE1MDAxLTE1MDAx
bXNlYw0KPiAgICAgPiA+DQo+ICAgICA+ID4gaW9kZXB0aD00DQo+ICAgICA+ID4gOn4kIGZpbyAt
LW5hbWU9cmFuZHJlYWQgLS1ydz1yYW5kcmVhZCAtLWlvZW5naW5lPWlvX3VyaW5nIC0tdGhyZWFk
DQo+ICAgICA+ID4gLS1maWxlbmFtZV9mb3JtYXQ9Jy9ob21lL2FiaGlzaGVrbWd1cHRhX2dvb2ds
ZV9jb20vYnVja2V0LyRqb2JudW0nDQo+ICAgICA+ID4gLS1maWxlc2l6ZT0xRyAtLXRpbWVfYmFz
ZWQ9MSAtLXJ1bnRpbWU9MTVzIC0tYnM9NEsgLS1udW1qb2JzPTENCj4gICAgID4gPiAtLWlvZGVw
dGg9NCAtLWdyb3VwX3JlcG9ydGluZz0xIC0tZGlyZWN0PTENCj4gICAgID4gPiByYW5kcmVhZDog
KGc9MCk6IHJ3PXJhbmRyZWFkLCBicz0oUikgNDA5NkItNDA5NkIsIChXKQ0KPiAgICAgNDA5NkIt
NDA5NkIsIChUKQ0KPiAgICAgPiA+IDQwOTZCLTQwOTZCLCBpb2VuZ2luZT1pb191cmluZywgaW9k
ZXB0aD00DQo+ICAgICA+ID4gZmlvLTMuMzgNCj4gICAgID4gPiAuLi4NCj4gICAgID4gPiBSdW4g
c3RhdHVzIGdyb3VwIDAgKGFsbCBqb2JzKToNCj4gICAgID4gPsKgIMKgIFJFQUQ6IGJ3PTM4NjNL
aUIvcyAoMzk1NmtCL3MpLCAzODYzS2lCL3MtMzg2M0tpQi9zDQo+ICAgICA+ID4gKDM5NTZrQi9z
LTM5NTZrQi9zKSwgaW89NTYuNk1pQiAoNTkuM01CKSwgcnVuPTE1MDAxLTE1MDAxbXNlYw0KPiAg
ICAgPg0KPiAgICAgPiBhc3N1bWluZyBJIHdvdWxkIGZpbmQgc29tZSB0aW1lIG92ZXIgdGhlIHdl
ZWtlbmQgYW5kIHdpdGggdGhlIGZhY3QNCj4gICAgIHRoYXQNCj4gICAgID4gSSBkb24ndCBrbm93
IGFueXRoaW5nIGFib3V0IGdvb2dsZSBjbG91ZCwgaG93IGNhbiBJIHJlcHJvZHVjZSB0aGlzPw0K
PiAgICAgPg0KPiAgICAgPg0KPiAgICAgPiBUaGFua3MsDQo+ICAgICA+IEJlcm5kDQo+IA0KDQo=

