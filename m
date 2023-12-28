Return-Path: <linux-fsdevel+bounces-6985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C681F541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFFE1C20EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF483C1D;
	Thu, 28 Dec 2023 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="A6fvfrHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDF63AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS5tcBc026015;
	Thu, 28 Dec 2023 07:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=OsiQNWbeqXP3B+9uexlb7CKFzPFIDzG5i4Lt1yY0oNw=;
 b=A6fvfrHYVhNHgSSMx7p3a+syW/YWw7WAnKsCj3Na+ggoPwk5KCJkbQBaFgltAt3uMfOJ
 cnLN3F0/oXSSlCXHSZ9afKCNQ06WAx+nwphbHECS5MyBmsvbKSXnI/mOu9vk7rRwoMjf
 mKi09FWQiZ1ts+c7V++aHvswXJni75axXGQSbqzCHs6Be8JJEE8WPTzc+/KZ6mWup0IV
 q3GUzerXsCaJHTFQpOABEqGtVx7Bb7vA3at3PfxvONZgifZItqKCaOECUh5WEjWHNBZT
 gJ7PWU7Ni7IHgmdcKwlTb1Yt/nwlNvHvyVpr+9XbRI4eeNhRxcHjopXxED2yX0eNqWcp bw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5pb73tuh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 07:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0cMwrr2LyLI4Uc3zkT31gOWq8UnxxS5pVf0aU64QI8JkYzpdZZ5npqDlErxcTihEZfNEjyPe5nVpZlCNtdax8eoH5tETbkB9vCPPjPrBZQj3G5Qt7tJE3GD7tTeKzByhlFRP7yCuZLvEN4DbOUoOj7Mfzm5j97H94KxFZIq9umY0wdiUDm6Wf+svCZq7UbLsAqJBmZg7iGzdz0G8ixoNAGiBUExyl3HJ0E31laCGSgGuOECgjXo3aZpkiB+PL/qit66otcii+Bc/HyG8GzPkVtjbGIUINucoND0sxdRYRyIS9ZoC9t/mB/yVyJjPbrOuz5iQSV/niv2CEfDG6Hu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsiQNWbeqXP3B+9uexlb7CKFzPFIDzG5i4Lt1yY0oNw=;
 b=FruOlw3XteMO8b+ArCMHyqfh3jfJJbRnRL98trJxZMbWU30mNJRa3bwQaRlj4/pGKEbVam03OymLULHL1FBFIP7Lk5SfDoAP9kRivJBv2vEwdzVwIp3gyttJ89HHsQE40gKDVomKHcal+SqeyV2TIpIcqETz+S3fJtnBZK0V9JUYEM87nMZ5VYNPTu+Kr0juuU2Ukfv82DNTpAvpeUafKczwu90bg+6oH53N91uIduZ+L9bWVhP0yfhuvXrn9uEs7vF1IGzTTXexnbr8nngmmq5w3HQKNJqIGRELDl3PrkLjD/q1+8o5eXFYYpcnNv/J/84XdFVH8lRzb7Ysn8RtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7223.apcprd04.prod.outlook.com (2603:1096:101:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 06:59:57 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 06:59:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 08/10] exfat: remove unused functions
Thread-Topic: [PATCH v2 08/10] exfat: remove unused functions
Thread-Index: Ado5WrnLuTRtybDYRCqx8qBlEMgWyg==
Date: Thu, 28 Dec 2023 06:59:57 +0000
Message-ID: 
 <PUZPR04MB6316B72D9F18B9D64D5D65BC819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7223:EE_
x-ms-office365-filtering-correlation-id: 94043ca0-ea91-43f3-56fe-08dc07729a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WnOqVhq2+JOQzuc3qq/mjQhVker01WHsCRgORSpnIE8zfSAmifIwpcMmRGitrhRt+p8Zxx9un9mBZCd6gHWeFu250Lj+mmDE3mRWqcBUgjgHELjZKH6hXvqP9dxK6beGuxeFQ/TShnKXDm1hdQakSEzPf/MYnASFCJU7mpbLHxJFckw0hQBKXwgCSTsZAcvKADSrwEFT+V4nxrWmDmilQigc6Tv5PidPRQg1EDUxBm3f78XhTulzyzvQD0I361GFulOFP2hIq+fL76jw1hnNF0Yr0zsFeKq3SlsEwDDpYGTNCwNzN/JGMJZGjzy1IbwN+o8ujIISnRvUcAJQXAFiHs828tefOlhIkYmKMswMwlS/W6S+j4ICcnQT4bAZmA4k6q5D7sCmy/aeJgbSqmK4R6g+g8/Vva6hQd95bk7If7JxSp+MBx0PK0H4VldJ4tb48zJnlAD5+phq0os08EhIx8YzwACJY9fmJFbZ8TzyRB+20SYDXonXIn4lanOYY6TzwgO2yR8WF7O6OPILsqdfIxDCKHT3gks4ApQjDQuma6UjhcMe2l3BXL/GlXiBcaLWC1YI/nnI6GjPlNjcrdWkU0C+Rlwh7PQ7kxESHuq4b08LHL4fy0X5DHyaSarw8t5f
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(66556008)(66446008)(66476007)(76116006)(5660300002)(64756008)(66946007)(55016003)(4326008)(52536014)(8676002)(8936002)(316002)(54906003)(110136005)(38070700009)(9686003)(107886003)(7696005)(478600001)(71200400001)(26005)(86362001)(6506007)(33656002)(122000001)(41300700001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V2RwWmVWWXlTNmwzUUROYnlGcHNCQTZoaGxybE44TXM1aDB0VmNqQTJiZCtF?=
 =?utf-8?B?N2VLdHJLVzBQNy9tUHVHYmtEcnFhZmo1a0tZeVlNV05aRVFNOUxmaTBxZy91?=
 =?utf-8?B?dSt3NmI4VXJxcDJHdzg2WTd0TTVhcDI1bndVR3JYTTI1allFbklvL3VJbnRq?=
 =?utf-8?B?SzgrV3gwb3krdFcwbnBwd0tsbTlOZUNHZmJ1TDM5UFRJRGRKS1hnS2dORDdP?=
 =?utf-8?B?cDdOWGxOYS9XOHZ3TVJaZExySXpaK3RCdXRVNzNZZXpTdldDNm5RMHlxcnM3?=
 =?utf-8?B?V0h0MU1GcW9SZDIyOHV3NzRNdWVpb2dBSEtwcjN3NXBSYSsvS2xBQi9URE5k?=
 =?utf-8?B?cGI5NzRGNDZJOU9HNmJta1g2OGdXUXpXNENqOVRNb2pDeWJHMW11ck1peEts?=
 =?utf-8?B?Y2VrOHJKbnVjZE9qTmVCdTVUbm81VzI2WUdCMFZEbFVsWlowM0k1WGVJQTg0?=
 =?utf-8?B?ZHFqNHVuSmFQUDNZKzVOeWpYWnI4cDlPQ1JwdGdERjY5bHJMZ2E2TnRNNkNN?=
 =?utf-8?B?cHBCQjBWM0gyVnVaaWhZbjU2cjBvTGd3MFJHZnFud2VRa2hBSThoZ05PTU9X?=
 =?utf-8?B?TWpibDNHbnFjdUlINnJjWERPYURubFdqbStDRkZOT254M0pjRC9JYWxCN3Vy?=
 =?utf-8?B?bnA2Z2dFWjZLWjRLUndUMnIxcUhzVFZkTTRRVUt5OGVOTVlIb2xwcVdnSGV4?=
 =?utf-8?B?bSttTm1TakgwOTdwZkFhbVcveWNmYVA2dFBUbW5ORmk0V3J0TWt0bWdYelJi?=
 =?utf-8?B?NEp4MUxOYnpIQmE2L0d4UW5KeUxaNjlBdDVJS0JQUEFCUFVvSFZKbmgwOE9B?=
 =?utf-8?B?QXAxNDR2SHA0N25mUWNPRTNCNmxZeUxhYVA4MnJldHoyV09oR3h5MzlPNnE3?=
 =?utf-8?B?L201VzBXTU5WZ0xYbnlsNXFTTUxKNmR0WVBhYlo0allObVZRQ0FzcE9VaWNk?=
 =?utf-8?B?NjJ3aFdzZDZxV0pxajhKN0VKeU0yREdFeHlqaWF4QkNMbzhnaWl4OG5GYiti?=
 =?utf-8?B?eExOeEZIZ3NQQlhsWVFWTWdRdHJuRGtMRXd1cFJuT3JsZWV0M2NVNEFvd0ZS?=
 =?utf-8?B?bHRzc3laNjI4SFhENjJBRTBVVUloMGtpSGJ4dGJKQXM0VTVPdkROY2tFQ253?=
 =?utf-8?B?UWFWSjdJVU5mdjlSWUtURWV5MUZhQTVJNVdkRUJOcUcrY3IrNjd5NmtPRjZB?=
 =?utf-8?B?S0pFQ0xmOVZkamZPZm5CNFVaOGI2MnNJaFFTdUN0ck5QZHJRK3dEV0lDaVgx?=
 =?utf-8?B?L2xaL2xUcSs3YmZrSlZ1M3NSbjk3T1ZtNjFVU2dzT1BWYUZlSTF5VTYzRGdP?=
 =?utf-8?B?ZU5xZjArQWwzRmJ4cHdaVXJMOGJ4MTU2TG9SYXI3cXpiQ3FkeldIRGJ3RW8z?=
 =?utf-8?B?c3ZuZDFMSnI0aEVYQ0orQytvcERmMGR5dUlqbkdZYU11VHFmcGlQVmFnaTMw?=
 =?utf-8?B?M2hyZXZZUFdDSmJVUmFHamJRMnZzUUo2SkkrWENROFYwYU1BRnpkRTZxblV3?=
 =?utf-8?B?S2dEWWcxWUtzZTFBaUFjcnpBV1JwRFN1Y0lsWTJFSFMxWkVZTCswU21HVS9w?=
 =?utf-8?B?VmtvOFFYZTVjcUtVNkxaVkRRS215OG5LVEtHbzFxVEhKUzY0MkdzM2lXZlFS?=
 =?utf-8?B?d3U5eFIwRkhudjFPY0Jjc0RObnVWdDJERktYYXRReFA1OWRjUyswdnljOUJS?=
 =?utf-8?B?TkpCdXhUZC9sT2RvODdjTitsei80TWpQY1pUYjRSWEpkSThveVNLOHNVL3po?=
 =?utf-8?B?UGtwRGd1SjBMeGYxRlBIOStQTytZa1pTbWJ3MFpLcy9KbGF3bFlvNkthV0tK?=
 =?utf-8?B?U0trVlR3eW9jRENyMEUyK0h4bmdGV3BaZUVsK25tejhyWkY0ZkZIVnpGdmdZ?=
 =?utf-8?B?ZUdkWFhFMGFJdmlQZHhkbnRMMkt2eXQ3c0JlbjdBQmdCcldoUFFlMlhORFhi?=
 =?utf-8?B?QWhoYjZLN2FGTXo4SFFud2xBUU04VmYwMnlBTXNhdWcvMWlpZm04QU5TMXFO?=
 =?utf-8?B?TzVzVTZWUlFDQkZZdEN6aDJxNWVZRVlFTWMrV3BTaldLVU1HQVdVREt5U2wy?=
 =?utf-8?B?YzAyRlBwNmFidS8ySDM5ckZaUGlEMmtsZ1dBS2FvdVEybjZGQkJoYjltM1pT?=
 =?utf-8?Q?x0nGqB5YaeY6CJ64E6FzViMs/?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	21Y1zOcoNMIGfAR+SS/yr3FShelxXg4b/sxwfWaFYKGqKFWyAGyP3oZKuchFH970VnjcTAcHGDgs5BY07sw4V3yzf9I0ucuVOycYus1KAS8SKov/J8504N8b6qjzJPlgg/lBcOiuE3G/hUgefJ+Q8VqHPgKO3nN+vyR9No/T3IUS/ABnWIUNjS18n1BBqRCVrh5KAO5Ooeum6MOxgiNKPzp4F/UrBAB4gjnN8igbzeXBRsm9ywH+Rq7Ql+PL6HNL6pp2WeuU7PUwDE1zXdqnC4sZY8/OKhYoNTl6cxRZnUzimskWIiDi7hIuqIQJfma07wcyc3dzMvX5bnO9nhW950uUGKmauzBisIn+WiDJZhUL/C6HhZvnKaWMTmeTtp+ucMV4mwe9wkcXwGUiC3VztnZ7/i8cNLgetNb5bRFwFgr0zL7McULpOLibDDjFL/3uCvooABRwmCleqn+iQ842m1eHasDcQLMWHf1T6ssG2s70HRnH/h+d5eoDQf3rG76W1PE6pVFJcqPnSZ1s/R5Y7djzFwLkz1mf6RXLpf/8kFI2hRMDkD7dgmCc+m4qUGWMS5/HhjqcBOAeC2o7ZUEkGDWApvC7NSz92nBjK3gSBGEAbyHWhxR3bIaI7ii1H9Lv
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94043ca0-ea91-43f3-56fe-08dc07729a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:59:57.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M88SN/opLymPftqBbm7SVVQgU0xSPOovZTljNQ6bl2qVLWRjPvd/jossCSWbC2eQ0Em6IN6w0OTZ/LGR/SieqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7223
X-Proofpoint-GUID: eRXtKkVheJdveC2UArHaxQeKkQTT-uVJ
X-Proofpoint-ORIG-GUID: eRXtKkVheJdveC2UArHaxQeKkQTT-uVJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: eRXtKkVheJdveC2UArHaxQeKkQTT-uVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

ZXhmYXRfY291bnRfZXh0X2VudHJpZXMoKSBpcyBubyBsb25nZXIgY2FsbGVkLCByZW1vdmUgaXQu
DQpleGZhdF91cGRhdGVfZGlyX2Noa3N1bSgpIGlzIG5vIGxvbmdlciBjYWxsZWQsIHJlbW92ZSBp
dCBhbmQNCnJlbmFtZSBleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93aXRoX2VudHJ5X3NldCgpIHRv
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBB
b3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZGly
LmMgICAgICB8IDYwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgNiArLS0tLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAg
fCAgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2NCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4
IGYxMjNjMWMyYTRhMi4uODhhOGMyYTYwOTg4IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMN
CisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNDc4LDQxICs0NzgsNiBAQCB2b2lkIGV4ZmF0X2lu
aXRfZGlyX2VudHJ5KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAlleGZhdF9p
bml0X3N0cmVhbV9lbnRyeShlcCwgc3RhcnRfY2x1LCBzaXplKTsNCiB9DQogDQotaW50IGV4ZmF0
X3VwZGF0ZV9kaXJfY2hrc3VtKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFp
biAqcF9kaXIsDQotCQlpbnQgZW50cnkpDQotew0KLQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0g
aW5vZGUtPmlfc2I7DQotCWludCByZXQgPSAwOw0KLQlpbnQgaSwgbnVtX2VudHJpZXM7DQotCXUx
NiBjaGtzdW07DQotCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwLCAqZmVwOw0KLQlzdHJ1Y3QgYnVm
ZmVyX2hlYWQgKmZiaCwgKmJoOw0KLQ0KLQlmZXAgPSBleGZhdF9nZXRfZGVudHJ5KHNiLCBwX2Rp
ciwgZW50cnksICZmYmgpOw0KLQlpZiAoIWZlcCkNCi0JCXJldHVybiAtRUlPOw0KLQ0KLQludW1f
ZW50cmllcyA9IGZlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDE7DQotCWNoa3N1bSA9IGV4ZmF0
X2NhbGNfY2hrc3VtMTYoZmVwLCBERU5UUllfU0laRSwgMCwgQ1NfRElSX0VOVFJZKTsNCi0NCi0J
Zm9yIChpID0gMTsgaSA8IG51bV9lbnRyaWVzOyBpKyspIHsNCi0JCWVwID0gZXhmYXRfZ2V0X2Rl
bnRyeShzYiwgcF9kaXIsIGVudHJ5ICsgaSwgJmJoKTsNCi0JCWlmICghZXApIHsNCi0JCQlyZXQg
PSAtRUlPOw0KLQkJCWdvdG8gcmVsZWFzZV9mYmg7DQotCQl9DQotCQljaGtzdW0gPSBleGZhdF9j
YWxjX2Noa3N1bTE2KGVwLCBERU5UUllfU0laRSwgY2hrc3VtLA0KLQkJCQlDU19ERUZBVUxUKTsN
Ci0JCWJyZWxzZShiaCk7DQotCX0NCi0NCi0JZmVwLT5kZW50cnkuZmlsZS5jaGVja3N1bSA9IGNw
dV90b19sZTE2KGNoa3N1bSk7DQotCWV4ZmF0X3VwZGF0ZV9iaChmYmgsIElTX0RJUlNZTkMoaW5v
ZGUpKTsNCi1yZWxlYXNlX2ZiaDoNCi0JYnJlbHNlKGZiaCk7DQotCXJldHVybiByZXQ7DQotfQ0K
LQ0KIHN0YXRpYyB2b2lkIGV4ZmF0X2ZyZWVfYmVuaWduX3NlY29uZGFyeV9jbHVzdGVycyhzdHJ1
Y3QgaW5vZGUgKmlub2RlLA0KIAkJc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXApDQogew0KQEAgLTU1
Miw3ICs1MTcsNyBAQCB2b2lkIGV4ZmF0X2luaXRfZXh0X2VudHJ5KHN0cnVjdCBleGZhdF9lbnRy
eV9zZXRfY2FjaGUgKmVzLCBpbnQgbnVtX2VudHJpZXMsDQogCQl1bmluYW1lICs9IEVYRkFUX0ZJ
TEVfTkFNRV9MRU47DQogCX0NCiANCi0JZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW1fd2l0aF9lbnRy
eV9zZXQoZXMpOw0KKwlleGZhdF91cGRhdGVfZGlyX2Noa3N1bShlcyk7DQogfQ0KIA0KIHZvaWQg
ZXhmYXRfcmVtb3ZlX2VudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2Vu
dHJ5X3NldF9jYWNoZSAqZXMsDQpAQCAtNTc0LDcgKzUzOSw3IEBAIHZvaWQgZXhmYXRfcmVtb3Zl
X2VudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNo
ZSAqZXMsDQogCQllcy0+bW9kaWZpZWQgPSB0cnVlOw0KIH0NCiANCi12b2lkIGV4ZmF0X3VwZGF0
ZV9kaXJfY2hrc3VtX3dpdGhfZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUg
KmVzKQ0KK3ZvaWQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW0oc3RydWN0IGV4ZmF0X2VudHJ5X3Nl
dF9jYWNoZSAqZXMpDQogew0KIAlpbnQgY2hrc3VtX3R5cGUgPSBDU19ESVJfRU5UUlksIGk7DQog
CXVuc2lnbmVkIHNob3J0IGNoa3N1bSA9IDA7DQpAQCAtMTIzNywyNyArMTIwMiw2IEBAIGludCBl
eGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRf
aW5vZGVfaW5mbyAqZWksDQogCXJldHVybiBkZW50cnkgLSBudW1fZXh0Ow0KIH0NCiANCi1pbnQg
ZXhmYXRfY291bnRfZXh0X2VudHJpZXMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4
ZmF0X2NoYWluICpwX2RpciwNCi0JCWludCBlbnRyeSwgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXAp
DQotew0KLQlpbnQgaSwgY291bnQgPSAwOw0KLQl1bnNpZ25lZCBpbnQgdHlwZTsNCi0Jc3RydWN0
IGV4ZmF0X2RlbnRyeSAqZXh0X2VwOw0KLQlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOw0KLQ0KLQlm
b3IgKGkgPSAwLCBlbnRyeSsrOyBpIDwgZXAtPmRlbnRyeS5maWxlLm51bV9leHQ7IGkrKywgZW50
cnkrKykgew0KLQkJZXh0X2VwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgcF9kaXIsIGVudHJ5LCAm
YmgpOw0KLQkJaWYgKCFleHRfZXApDQotCQkJcmV0dXJuIC1FSU87DQotDQotCQl0eXBlID0gZXhm
YXRfZ2V0X2VudHJ5X3R5cGUoZXh0X2VwKTsNCi0JCWJyZWxzZShiaCk7DQotCQlpZiAodHlwZSAm
IFRZUEVfQ1JJVElDQUxfU0VDIHx8IHR5cGUgJiBUWVBFX0JFTklHTl9TRUMpDQotCQkJY291bnQr
KzsNCi0JfQ0KLQlyZXR1cm4gY291bnQ7DQotfQ0KLQ0KIGludCBleGZhdF9jb3VudF9kaXJfZW50
cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKQ0K
IHsNCiAJaW50IGksIGNvdW50ID0gMDsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5o
IGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggYjFjODVmNmVjOTBiLi43N2ZlNDEwYzExZmIg
MTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9mcy9leGZhdC9leGZhdF9m
cy5oDQpAQCAtNDMxLDggKzQzMSw2IEBAIGludCBleGZhdF9lbnRfZ2V0KHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IsIHVuc2lnbmVkIGludCBsb2MsDQogCQl1bnNpZ25lZCBpbnQgKmNvbnRlbnQpOw0K
IGludCBleGZhdF9lbnRfc2V0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCBs
b2MsDQogCQl1bnNpZ25lZCBpbnQgY29udGVudCk7DQotaW50IGV4ZmF0X2NvdW50X2V4dF9lbnRy
aWVzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQot
CQlpbnQgZW50cnksIHN0cnVjdCBleGZhdF9kZW50cnkgKnBfZW50cnkpOw0KIGludCBleGZhdF9j
aGFpbl9jb250X2NsdXN0ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGNo
YWluLA0KIAkJdW5zaWduZWQgaW50IGxlbik7DQogaW50IGV4ZmF0X3plcm9lZF9jbHVzdGVyKHN0
cnVjdCBpbm9kZSAqZGlyLCB1bnNpZ25lZCBpbnQgY2x1KTsNCkBAIC00ODcsOSArNDg1LDcgQEAg
dm9pZCBleGZhdF9pbml0X2V4dF9lbnRyeShzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICpl
cywgaW50IG51bV9lbnRyaWVzLA0KIAkJc3RydWN0IGV4ZmF0X3VuaV9uYW1lICpwX3VuaW5hbWUp
Ow0KIHZvaWQgZXhmYXRfcmVtb3ZlX2VudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlpbnQgb3JkZXIpOw0KLWludCBleGZhdF91
cGRhdGVfZGlyX2Noa3N1bShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfZGlyLA0KLQkJaW50IGVudHJ5KTsNCi12b2lkIGV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtX3dp
dGhfZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzKTsNCit2b2lkIGV4
ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtKHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzKTsN
CiBpbnQgZXhmYXRfY2FsY19udW1fZW50cmllcyhzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5p
bmFtZSk7DQogaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCXN0cnVjdCBleGZhdF9jaGFpbiAqcF9k
aXIsIHN0cnVjdCBleGZhdF91bmlfbmFtZSAqcF91bmluYW1lLA0KZGlmZiAtLWdpdCBhL2ZzL2V4
ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCA1MjJlZGNiYjJjZTQuLjA2MTRi
Y2NmYmU3NiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2ZzL2V4ZmF0L2lu
b2RlLmMNCkBAIC05NCw3ICs5NCw3IEBAIGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGludCBzeW5jKQ0KIAkJZXAyLT5kZW50cnkuc3RyZWFtLnN0YXJ0X2NsdSA9
IEVYRkFUX0ZSRUVfQ0xVU1RFUjsNCiAJfQ0KIA0KLQlleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93
aXRoX2VudHJ5X3NldCgmZXMpOw0KKwlleGZhdF91cGRhdGVfZGlyX2Noa3N1bSgmZXMpOw0KIAly
ZXR1cm4gZXhmYXRfcHV0X2RlbnRyeV9zZXQoJmVzLCBzeW5jKTsNCiB9DQogDQotLSANCjIuMjUu
MQ0KDQo=

