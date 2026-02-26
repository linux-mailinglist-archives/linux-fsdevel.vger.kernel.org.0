Return-Path: <linux-fsdevel+bounces-78615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLeLOiuUoGl+kwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:42:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7F1ADE1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D03E3290743
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B88D2C859;
	Thu, 26 Feb 2026 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hv3ylgU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D6368965
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127965; cv=fail; b=PZwqxLHQtXDrly3DyngrtCdJ1TUBilNTX/P0Zx+Mos74nm86OKvczKw8eqAudbFnOL5fCeUj+aKc2RWB9kgBygQiM/Iubu+pBC+ObuaXyaj01hqeDqWFAuGN0eP7tkKUTJuZpiVYEmjNRCEb7UJCUc5Lo0uYsSeY7lOqXcr0a5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127965; c=relaxed/simple;
	bh=72il/OlGwV2voXWHeFDdIAx6YkipUjvMw/bM/Mx6DRY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Uej9yAekKOCuqzkrPskQ9lPit0TNwBU+5YHRi05at6VDTG/Erp2uZWwo/JXsVn2Hxf7sxWiQSqcJBFMnuRS66S4DuWq3Ff56hikaB/gS7Su8zBB5JUMzbPg7J4uKsQNNjmXqV96Q2rwsR7nYnlHk2v46Jg0X+Sm/lSzzpj2+1Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hv3ylgU4; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QFUwOb2615756;
	Thu, 26 Feb 2026 17:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=72il/OlGwV2voXWHeFDdIAx6YkipUjvMw/bM/Mx6DRY=; b=hv3ylgU4
	spIs/CmgFH1SH2AznjT0zPmBGcv6xAliMrem7y2MGd0BZJJXgQ8sIG5u0oNczPvO
	AePqDUO8ItdSCf+SBewD4q5kc7eE3zP38G99eYP0XJ00irQONYWSB4olyQWX1tH4
	2A+Iv7polvY3KadiJJ8eXbB70KikK9HXFKgZgKW4gYeqpdRRO+55ZvEGD4dJQiAx
	uCqsDIroVb0z4MjfppCuY6dLv3hIrlJcpcEQuMHsNUR7Or0BjM4VunnzPkW7lJm+
	Bz97WcmjdMTG9orrZyuq5ljnJ25AJwCBHuSgTmFdt3DwuXaygOTElev9RDvdcZ+j
	iVVt1+ZBAUDgGQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf47285xn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:45:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBzHwDk4Ht+vwUuzT+KhCUceNxd4iPSchFeUmRKeXW6AEwiYDTIW81CP0fkiQKEKAEu4Curv/24YFLhI3tgRCE9MXlbrIvsY8XL+XgX9FetYZlYsSxOygfGXd1RX6AD23rMuqSYOMQN74/rLMTfDMz0AKyE2dvc7CQt8JVjIKiY4kQYR+sY8KXmwKJ972bD6vru864ggRtZG0vsgXetgJ0jjmaqS9rAxmBcIXL2iuiLOrpUFKDmdgGuz4WXjQA9p4fAxva6mf/fGvtnpkJKu8WPhsK80wAVAQbidkxxXkxWWiGIZOuhzLfjWQb31BPgo09zdVFxXkhwMAbvQPcr88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72il/OlGwV2voXWHeFDdIAx6YkipUjvMw/bM/Mx6DRY=;
 b=zAOXn1RuWfIAbSaCkpsbcot45rglRnBOBPhTCJ1j+fx1hGSwsyNz/KHcTz3kSML/NOj9bLNIOR9Rdrrph04AhODxuAb2/5ddr0B1N8jfbCVypfyZtfTpx1xXskDeJT0sbvnLSbqLao2p59cWD/DRHWNI+M1Szj24l/nVXeD2OuAulGx8mj2viTau8Z1HCl1NuONoxV7WOG6+laaql2z7wyami8mHtarnTIpW7foYtnUmof1iWdvQgflwye5ze8A7ecIDs5nL8gG1wjQ6LqLX4PjlZYrqdGuTJW9DGAiDlWpBuRBIGA4iNmz5o9E4QXNfVijy1bH7eO8O+i2fYB0rnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB6228.namprd15.prod.outlook.com (2603:10b6:8:17d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 17:45:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 17:45:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: don't fail operations when
 files/directories counter overflows
Thread-Index: AQHcotRssjIcoi+1fEadeuY4I7u5nrWVC0mAgAA+j4A=
Date: Thu, 26 Feb 2026 17:45:54 +0000
Message-ID: <e29dc9d188ac8925408a825b0073f6ed2990db89.camel@ibm.com>
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
	 <be0afbc9cf2816b19952a8d38ffb4a82519454e2.camel@ibm.com>
	 <15eebd5d-cf5b-42ca-a772-6918520ff140@I-love.SAKURA.ne.jp>
	 <0cef4eb7-987e-4fa6-a5b1-a64c5db1f42b@I-love.SAKURA.ne.jp>
In-Reply-To: <0cef4eb7-987e-4fa6-a5b1-a64c5db1f42b@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB6228:EE_
x-ms-office365-filtering-correlation-id: 590ed104-af6a-4bf2-de91-08de755ee428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 WYYcZ7UhH7fg9fP9kF3RbZD4kbAGoLbqkGraNxlBd/9RcSt0pGO4PApQMNYu8VgFi+0+k4vy8XXZOGL9xbwmz/TlV9mAs6CPR4qJHW7i6ew/wMV+nrdPZ0mXFSde06+RUhOy8Uv+mGLaVFuKWbKyoxdcBF4sWVah7N0o+x8M8lamHaG3Rtv58JioHsWeBif6LbG9zauc9ZN9jzphG8H+JHTrEB6xklOCbx5KU2OpOk1lMWPxBmc2bJZuRXP3uu+YbqN5TW6zrQfD9u4pX9GxNFz0qLYw294/gB1/kZHVlzgc0qv6YqZHvVUDPTWxHIjsOXD48T4LA9m07XVCULrXGIF3Re+8jYWMwaJTU0bdNlSDIQVVih0jz/Rm39QFmGDo7MqvlyzWqxPpeqRgDCOD/8tfps4LDNkZ4XAVhzzGwV871YFxQWnS9yCzXCvlxPH8lmwqXci8LNhuUM1PAahPnrmq+FnDpowHMp5mw5eBOFuMv08BOG6Cz01kzaINI/p+DWnDPJIo35L7f7gBLeC6y4wpfFVGatQTG1RzFyB+CFjrtIizEKYK6x0tFboe3DGiafh3jycUmGh7lQpl01XBN2VSgJ0FIwtHWUBJUfMUPApW9C2C5YdZSezBiD3sEZMhqCV83zX9cN48Q9JUhhQKfHMyZnANls9jONvPOQRmSXu0BegQSoXHsIvT3i5H+qAJkBumpGhO4uR6jG74ZzFEaqmvhnLc6lz8t7SluuW76t4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azhMQWNaUlJydTlLR09jYWxTS29FT1Z5WW5WazN2TzdKTDZPcnhlQmNUVTB3?=
 =?utf-8?B?V1B2ck0rM2MvVTI0MTBQMEZnVjVkZnVKaEZNRHZ3c01EYUVxMVZyU1pjdVUy?=
 =?utf-8?B?MXdWSWUzY25CSGlvNnhOWmFFTmV4ZkhmMnl4WVNzUlBtTy9pSlpoVjdoa2k2?=
 =?utf-8?B?S21uWWo2MXpPQWpwcUUxaDMyekpyMkZTanhQUzlWQlFoc1ozNFRnRFFON0JV?=
 =?utf-8?B?V0FTL3F3dnZTQWVkbXBONlhkcGUybFVVR2s4citWUVlBR0Z2OVVqcDFkdGxk?=
 =?utf-8?B?UGlOT3pKaStOdDZsU29sRzZMMGpPYi9vWUJFTXJZL1FzVGtsNUorL05nTCt0?=
 =?utf-8?B?bzFLSHZUdlRUYTg1ZjdEM0YwNXc4b2RKbndsTTJtcWZ3NHdkR1R6Z2QvRERj?=
 =?utf-8?B?akhOVE02Ym9wT2ErQnhWNE9JdDNXbW5LeVI0UVQ5VGFMdkZ4UHB3RlVhN1V3?=
 =?utf-8?B?dGpLbnRDU3lMczZER3FjZFp4YktCTVFuVHZ4Z0UzTTYvc01JMUJweERQNFFr?=
 =?utf-8?B?UUZHQktPc1JDTGRSdnpTZEtKSllhRnAyR3JwbGxxRjRyVmMvMVVKWUNkRXd0?=
 =?utf-8?B?czk4ako5R3hyTVd1TmFMZFU2MUU1WEhZRGVJOTdGaVdIaWdNODA2WkxVQWFF?=
 =?utf-8?B?TDd3Y04yaGJ4TlN2RWJiUGlaODlFcjAzcTVrcUY0WHFMNFBIMWRzMm14Si9r?=
 =?utf-8?B?bU8zejFRK0JreW85VGdyalh2OFJWUkV3TlozWDJGWjREOFh0bVZNbnVNN2dm?=
 =?utf-8?B?bzlKS0kyREl2TTBGc3llMVJpMzZ6L2F5WnF6RmVwbVBseG1ObWxYclBXb3RL?=
 =?utf-8?B?c3pveHZYbHVlR1FXWm00WUxRdDhDMU1LUC9QRzlpM2lpZ0VXSjhBVUdyK3Jr?=
 =?utf-8?B?TThaaU1Wdm1adFRwWmZuVjZXR3hrVi9xWkRsT3Z4ZXFUT3hnVmJGckpjRFo1?=
 =?utf-8?B?aS8rY09YV2ZsdjdUblJpd25tZHp6SmdZRUp4Z3hzcmQwQkMvSU5pN3hDMXNR?=
 =?utf-8?B?dUdIbjNqNWYwd1dGbThNMkROb2dyZVlQU0tZNlZLdHVacE56T2JVLzhLTVUx?=
 =?utf-8?B?dklNUzdHNW41bGFQTTNCaFczdGV5RENQVWV3YVptNytCVUdnd1lQYjNGWlB1?=
 =?utf-8?B?WC9pYi94SksvVmJMemJ0SnZaZHY4VGR2bWQrdytXcXQrbll3YzJGL2ZENUZv?=
 =?utf-8?B?U015Y2RtWlBRN3pwblJLRFJiZHExcmE4NE1VZ0g4NGFoVzR1Zlg5UjArZFBi?=
 =?utf-8?B?ZjBINng5bjRyaGhNQm5ENWU4enZ5V1FzNm1EVTA4VlhkQ1JjMEpUY3RKVXFH?=
 =?utf-8?B?azNPZWJMbzk5dytKbmlVZFFlajQ1Z3UzN0JzMjBkbmllbDVyV1JRaldqOEtY?=
 =?utf-8?B?bEJqM2hXazIyc082eTlRQTlkWDZsMjNYcHV2ck5kaUtSWDBoMDZkbXhianQv?=
 =?utf-8?B?TUxZaENEakFrZktRSXdLbFhqKzhlenI1elhTUHdqeFRjeWtqR29XUTFBdWZR?=
 =?utf-8?B?bERCRTJvcHNQY1l0d2lTTm13d0JHSFFLMU5LdHZnRlNxYk9tRFRuVkxtK2ph?=
 =?utf-8?B?TlBzakRJdjQ3UzFEcmJwMXY4YVREajB6aGxEbWxTVGxXK1lJT0c2SXhwVFpt?=
 =?utf-8?B?RXlVRmdGcDdyZUhUMkhEczRLSFVLTk42RXo2eWtVQ1hEUG14NHJHN1IxcU5s?=
 =?utf-8?B?SEkzQWJJNkRDbGMrQkJPamMzSWlmK2lQYlU1MTZqRDBIanAvZjlKalAvUFVM?=
 =?utf-8?B?UlhKbDEvZWZzOGJLQTlOTTcybyt3YXFFVnNPSXVoYjNJRWNOTVNLOUZmczRO?=
 =?utf-8?B?K0xBSDdkQXlISTdva3Zpck40aVBtcS91OGpHc1RFRFpocklrN2doZGJJRW03?=
 =?utf-8?B?SjNvMU1JSlhKSUpPQWJHMW41dTlZZW9JWEJZaU91R3AvcXNLY3BFYnRNaVpr?=
 =?utf-8?B?V2c5MTZTK0ZXTExkSmxVWXI4dzU3Z0NzRTY1LzMyUlVJNEF5aFZ5WHE3cmlz?=
 =?utf-8?B?NnZDSHJWbVBwd0cvSUdodXNvS0VCTGQwa0w0UXhDQ1g0UnpnTFRCaGRYMDVY?=
 =?utf-8?B?WFJlUHoxNWFWV3BQUTJ4ZWw2VFdJbVdtdkNJWWsyMVJaK1N3Q3JZT1o5OEVH?=
 =?utf-8?B?UENpcDdZaTB3Yk9JNm0vcjJRUjNsTVB2MmE4dU5ZQUY0L29NWFNKajkzdzlW?=
 =?utf-8?B?THUwVGtuOEpLMk9sdDFTQXYyTHYyeVBGRitHc1Q3V2NZTitQK203LzR0Kzhx?=
 =?utf-8?B?dElSbjRna2xZOGFZVW0zRzRocy9sWEswazBVSXF1L3RoalJCOU1UWmhqV2dk?=
 =?utf-8?B?SFZMSndIeW5ENEhLZmhsTDk0TGcvVWYxb0htUVdBRWJSNDdwMDZCK0dGQ0F5?=
 =?utf-8?Q?GDCXEYemHw9ivTHXxOmJb/uZbp0vnxj0J3DLP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4581F1503CD6AE4FBCC087343DE1BA86@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 590ed104-af6a-4bf2-de91-08de755ee428
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 17:45:54.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+JxHOP8+8pM1NvEyun268b7v1kCfM1zXTmJdt26HbYAKe4N8/QhndaBopbqKAWQFI9wKdBmCuSm9Ve5wbIlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6228
X-Proofpoint-ORIG-GUID: 3YPZZnGefNENtACilBLKGj7lXM5qgcCZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2MCBTYWx0ZWRfX5jumAJ1/ChJS
 bcpX58dMxKvTwDRuTTRlpn5OYcd241g8z+9Rhq9U5lUJBZmst7K20qq3ojiumO+O9FUndF0GTMk
 jiIjrmesk01UJIkYlhOL3/YvgBa7cvgRCoYFKYa+nAWUipQ5gYYBD6etz3MWidRHm1+YG4kiFGW
 XpWN34OWkmjfpEymq7xH2OLLF5R7z9P7MdlvsLU3rqaog4rYdFl7GD3qtPT8WKSZ53ciuW2Ffax
 AluD0ouUr+rth4M3zmwAAmkvmGi3+9rAyLIfrW4Nq4v/7mXGGCQVQIt1AHEV9vxcLZKEL4nmbDv
 YpFxR5qsNkSjhj54/gw0tauTu7YVeOUwo6hE7qDuCODKt1O+9OJqKrCTlolm3h1ClAmFLm2dPI9
 gVasHymIy4HLyHH7dFkdMxuTmfo//SYGMsLkqYFG8Sz+OPGShDq6/qBRIBvEeH2K3AH5/Bz4QKq
 osRUXpu1xeZAXZdc6zg==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a086d5 cx=c_pps
 a=IN6nX5sQGDwae/9PVKyrlQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=qxWGVCWjAAAA:8 a=-KD-8OfyFO8nvMCfA_UA:9
 a=QEXdDO2ut3YA:10 a=s57Xr27pIc281qfTS48n:22
X-Proofpoint-GUID: 3YPZZnGefNENtACilBLKGj7lXM5qgcCZ
Subject: RE: [PATCH] hfs: don't fail operations when files/directories counter
 overflows
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78615-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,I-love.SAKURA.ne.jp,dubeyko.com,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DE7F1ADE1E
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDIzOjAxICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDIvMjEgMTA6NTAsIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPiA+IFdlIGNhbm5v
dCBzaW1wbHkgc2lsZW50bHkgc3RvcCBhY2NvdW50aW5nIGZvbGRlcnMgY291bnQuIFdlIHNob3Vs
ZCBjb21wbGFpbiBhbmQNCj4gPiA+IG11c3QgcmV0dXJuIGVycm9yLg0KPiANCj4gSGVyZSBpcyBh
biBvcGluaW9uIGZyb20gR29vZ2xlIEFJIG1vZGUuDQo+IA0KPiBodHRwczovL3VybGRlZmVuc2Uu
cHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3NoYXJlLmdvb2dsZV9haW1vZGVfVlRI
NW1IUEZtYUg2MmZud3gmZD1Ed0lDYVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00
QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPTFGM1IwTUZzcDU3VVBTV0FX
blJkWmdLR0VEQW5qS180elRSNVNmbXBCVmM4QjY5MC11VUhodWlEaHpld2hkTXEmcz1QVkZLdkdm
d2xsbXk0djZGaU1GY0xfa3lFUTc4OTNzUWc4aVpjSDB6bkhnJmU9ICAoRXhwaXJlcyBpbiA3IGRh
eXMuIFBsZWFzZSBzYXZlIGlmIG5lZWRlZC4pDQoNCkkgYW0gbm90IGdvaW5nIHRvIGNoZWNrIHdo
YXQgYWJzdXJkIGNhbiBnZW5lcmF0ZSBHUFVzIGFuZCBNTCBtb2RlbHMuIDopIEkgaG9wZQ0KeW91
IGFyZSBub3Qgc2VyaW91cyBhYm91dCB0aGlzLiBTdHVwaWQgaGFyZHdhcmUgY2Fubm90IGhhdmUg
YW4gb3BpbmlvbiBiZWNhdXNlDQppdCBoYXNuJ3Qgc291bCwgaXQgY2Fubm90IHRoaW5rLCBpdCBo
YXNuJ3QgY29uc2NpZW50aW91c25lc3MgYW5kIGl0IGhhcyBubyBpZGVhDQphYm91dCBldGhpY3Mu
DQoNCkJlc3QgcmVnYXJkcywNClNsYXZhLg0K

