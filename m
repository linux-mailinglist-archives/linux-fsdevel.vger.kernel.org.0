Return-Path: <linux-fsdevel+bounces-6872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D781DB00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 15:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5C51C210B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB405695;
	Sun, 24 Dec 2023 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="bb5Xapnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653D5663
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BOEwmJ7019774;
	Sun, 24 Dec 2023 14:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=j52n+zjJX+0vJV8UHSZtadeF/6JRbve7yqdN2uuxKFI=;
 b=bb5Xapnf2v2KoGiAs5gbcOOIfVobkX3cFCCdFN7AtvYAmDt/AL7An3vRzAfJNKU8dDJb
 ai43h+YZ0SsTlP5lBftTZmCDoQKPs5Yg4OrSF2m+xnm5gHV+h1cYcN+r+FW1GwzJBUI5
 MpvgKkkACr6g2uKPYDEQBFmlp/51VTPlKnPsZ0T4LvgqXsUh6IKWmm5wd5xVLtlxQ1eY
 Ss5Y7YdYJLLltpdj8+SpoDKa6OleJP3/GHjaMOJc+awUbQCy26zL1Hbvm3w2vEH0Fuer
 YJGHoX48xvooykhZa0Iu9ZrlFM/bNx5vw5cTaMGtCEN65jGvC1CZpVRm1kxo5Khgip6D dg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5pb70ucw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Dec 2023 14:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD12oAGYOoMViy4RuG74IP7Y0CiKaPcRn5pjGr1qo/rxOkJ/c0+7++E6+vLyjz5UaEGnmVL4rXe0dhS2OWe684Ir2IPz6kjR5KW7Ws/DJkLioFIVrgMS3x/uqxjk9YTJ1MX8blbzkDmlaUtNGLYLuG84yJcbKXXqZt4SoiM902Y4eDoCVYoc+d7tXgQ7a7BYtzPyFbaNfVhsGWvXNGJbQW3Ospe6/W0cL4/ZZm1ng0vSTJl+UhnCFCNNZnR7S60IajYIUReLSJMNM3YriujqFmfRph383mNcyi+bpTiL2mZ9xnRqHCmsFsxBm/bTc2me+1F/RuZZOdReekgrZY6a5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j52n+zjJX+0vJV8UHSZtadeF/6JRbve7yqdN2uuxKFI=;
 b=mjM8+kRXXC/6gZ53H4ZwAFQr/gL+kt52hs24ja3W6rL4vAWNxp7mx1RnNcybi6mLrv2Wkh7ZgO/8Att2xmV3C+aiDTIyi6hLPS41JSNozngmTZrqP7qeEtbvJU9y9RNDU8N6xf+dEEwP9DKrgCk7bEw+LTZS2XJePP51NBg5gj27WwtZ2K9K6d+Y9ku7bXlo7YpVAXTqzjZwPtClLxmZfUJ75mAUdoXSrBuBakOUE/Cf0FwviwaFjZRDx6Ft7vAJsRywBDQxm/wO/AC0gv6scbnvDckyw7hQnCiVGyk9FsL73U9p70GCNI4D06TwCinjkcwgxuHi7CoYS8nmoAkqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB4383.apcprd04.prod.outlook.com (2603:1096:400:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 14:58:38 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 14:58:37 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v1 10/11] exfat: do not sync parent dir if just update
 timestamp
Thread-Topic: [PATCH v1 10/11] exfat: do not sync parent dir if just update
 timestamp
Thread-Index: AQHaKcjO3vQLwbcuZ0eVTDlb27nKt7C01lkAgAO11CA=
Date: Sun, 24 Dec 2023 14:58:37 +0000
Message-ID: 
 <PUZPR04MB6316500DDCF17B663C311BE5819AA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com>
 <tencent_C819A7DB899F09F0693C9C36BA8CA422FA0A@qq.com>
 <CAKYAXd9QEbr9AnKb+2Mf8iUkZsWyFZcekfYCKqDq2CiJ93EbmQ@mail.gmail.com>
In-Reply-To: 
 <CAKYAXd9QEbr9AnKb+2Mf8iUkZsWyFZcekfYCKqDq2CiJ93EbmQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB4383:EE_
x-ms-office365-filtering-correlation-id: edb30d5d-7382-498d-1bdf-08dc0490cecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gFgA447hDnlZZicSGxftoSqPrnsgmECAJDlhtGgnJd0EpWHspKMjQjAql4xLQCe7EU1pxPivvq5AgiEc4uZppde1lz/wYQcxsWayoMCCZmkIaXXcWQCVPfUfPIoV/xpwdvHdSCALyXoA3OD32xYmEONneVB/gXKcHgj7hsWOCXxqn64Vtn4tJeEbDmljmlfWv86L7kD3100HJPnoDUKGFdLluU8H9m4gMu15AcINyC12Fugj+DrtRJ7eBSA8sFC5VxRKwsasBfJNjqMLIVwhiUBDCJMQMi8gWz2B1VtYmMvH8TKwZ5V/ns/KTBrEDTGxT/9xxjBkdcgqp2pGPt1XaH+3tkR1tdIrWyxQg40zmWONoTcymdLobHHILiqndXWU8s7FyYPTUMW1ysw8hq6/xjp9CTSbOwG7qPv/8c0wQLnKw6qCzMsQYHKZ9FvKx+AOKtz1yoBIbcMYCl1wubKV8rycGeNB7c33Y0RgqxwB85Zflt0rl1aSftvSjcoQpUyu+8WrbL2afIsh/hd8WOtDrJmYwAsE9lEVGbWTtru4TUQ53xH28TiZxWyb2ejF/5V51tRlDDrtcm8EUJRnn+5Q0EGVu85aTjXBcDKnLwqXXmHB1oys7edopLxC0Ut4rzn9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(86362001)(26005)(33656002)(107886003)(83380400001)(38100700002)(82960400001)(41300700001)(122000001)(5660300002)(15650500001)(478600001)(2906002)(71200400001)(8936002)(8676002)(38070700009)(64756008)(6916009)(55016003)(66946007)(66556008)(66476007)(66446008)(76116006)(316002)(52536014)(4326008)(54906003)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Qm03bWdWNXRFd09yam1oL1hYWDhGOVp3ZzBOYWtOSnZOVWZaQlhtcm5EOEVJ?=
 =?utf-8?B?NDV2TXRPeldCOTVWUGNjbWh1cU5wTTZVazdYc2E5SkpzQmNYc2s1RXM0ckRt?=
 =?utf-8?B?N0E4NHpvcnZvd09rSHB6Ymp1UU5aaE9yTktGVUIrcm40MFRaa05BNFRrZW8z?=
 =?utf-8?B?Q0swYko2TEU4N2pzR2VLbGZJSHUyRlJZRk0xUjBRUERiRXNxMHpZNU1DRldy?=
 =?utf-8?B?ZVNLbUw2TmNCMDV0TXJoREIvZ1BXaVl6RXNrMTBPZUVvOFJBV09wWithRVE0?=
 =?utf-8?B?TWY0cy9rL3Z5N3BJMjZFdU9PRzl1SUdtK0JXRFUyY05vZ0ovWEU3WGpjQVQ3?=
 =?utf-8?B?UkF1NWdncCt0V2pJeUxnemw2aEtaU1o4ZHlUcit3ZW15REpnamlnMjhDM3N4?=
 =?utf-8?B?d09CbVgyR3hZRDhqZXhvb29BMUJaSnBtZ3NSdWZRKyt2N3lRMWZxaHhBVGtG?=
 =?utf-8?B?VzJCVGVWU0dPbW5SbkhxK0ZLckZiQVRtNkZRdXdDTkpSRnhjZG1ES1REeTBh?=
 =?utf-8?B?ampTdXNTRmp3Qld2Y0xBZmFkSkhuMHV0UFVYZ09GNCt5a3hIcWcwM1IzZ2RG?=
 =?utf-8?B?b1hraXZONDRIb2RKb2Rra1FLdDk4c0N5bnNtb0VvcXJINHJHSkEyU2djMEp3?=
 =?utf-8?B?SVFtV0p1TUljM1ZScTl2TTltNzR1SjJ0K0pURlNCdDhZdk93VWFDU3FNYWhK?=
 =?utf-8?B?R0R3WE1XYUd2akppMS9QL1BLOEVQT2lRQnI2c2poUElTZVdFa2JzQ0RFZVhC?=
 =?utf-8?B?cVlvR3dlcWhTbXdKSFo4cHQ4TGlvV3hmMndraU1CZHBuelFTdGhhREM1eWpH?=
 =?utf-8?B?N3VJejFBZWVHckxqaEI1QXMxSzlMOGlRVW0zNHJoSm1oOXJ6Y0xoelFXaTlD?=
 =?utf-8?B?dWF3dzR2ZitOUkVnYkRjMFJMV1phQS9MTkRkUUVRanYxdkVyRHB4elpnVUpZ?=
 =?utf-8?B?aVZkU0ppL1djOU1xRlV3MTd6MG1tTVhtdVJ4elQ4VXVrNGp3TktzV0x6RzNR?=
 =?utf-8?B?UzFEV1dGSUFyTys3YmxSeW1hK2ZqYmkzekVZb0wyQ3U1VUhxQlYyZ0ppRW1M?=
 =?utf-8?B?SUdON1Jxa3hFajUyOHp6TjBuMUg4eGNJcnM2eVFidjdGYUQvVU1xU1dmMTgw?=
 =?utf-8?B?YkVhL2l1RzBjb3h5V2xyai9vTmdMMHBHMnRWTzhnY3oyQ1ZLZzNZMW5xall4?=
 =?utf-8?B?RFhrelRXK3NwNXBHRUxNK0VKK1hBUnk0TlluTlV6R01RdCtOWHg2OUdHZ3Ro?=
 =?utf-8?B?WHB0MU05ZlkrVFQ5TUpNM20xaXhLZjVoN1dXL2c3UVpRVGFiV3p2MVFWd2pP?=
 =?utf-8?B?RmtLaWlBUXJiKzdtZVNnSTlTOHVlL3JZbTVxU3BiSnA1dnFtTEhtL0hESlRh?=
 =?utf-8?B?bGFEbFl0ZWhlVFVMR0thclhDUDl2eGNPa0oxNllqZ08wWGR3OS9YK0p2dE1K?=
 =?utf-8?B?UlNvbUt6cHlCSzF0ZExDQmJ2QVBVeC82dk50YzczekZMN0RpU2dKeGxmQThm?=
 =?utf-8?B?ZGIvZEtzQTZnVFRvQTlMYXBxYTYvNmtSUThwNDlCbWRpKzhiWlo3eDVkWGFM?=
 =?utf-8?B?MVVUcStma2NBRWVteDdzT2dPNzBGcVJFZmx2Mmx0YkYzdXZUb0dmc2pweDFX?=
 =?utf-8?B?NTY4RDZiWldhS09HTHpRNXk4enE0SU5FeExtT1RSQWpTVjVjdG9SMXIrSjdF?=
 =?utf-8?B?MEVaNTNnR1NEb1RLNCtnck9MMlFMd1BaQnRzMUtZTUFyeDhHZHdNOFNzZHQv?=
 =?utf-8?B?TkF2eExGWXVYT0pSRFpLcDNWMEREVWcxc2VyeW02YThwMXBZS296ZDhMQWtC?=
 =?utf-8?B?Kzh3WUFhTVBHZDV5czlDY1dhR3VQODJXK0x3RWZYRERBcEt5OE9pYVg3dDBD?=
 =?utf-8?B?ODdyc295bEpBc2RMZzNLSFpVc0FmTURZL2dkOC9NUTBpMEYrSW5iNFhEU3ZI?=
 =?utf-8?B?ejQyMU1BOUZKVk1CT05XaFp5N056bE1rZmZIdUtNbHErNGNTMm5jUFkyRDBt?=
 =?utf-8?B?eXozOTI2TlZOdi95dkVlZGVBQ2JGcDZ6TjBNdUdxL01xVmZ1THdRU2JZSCtV?=
 =?utf-8?B?NkNYNGZ3TVRyTUp2dlpMQVlKM21Yd2xUcDJ0NnRacnA0MTY0V0NETTc1aFpC?=
 =?utf-8?Q?OipyXqjVuN//n0JD5SLlMnMDy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3Fcv8lDTlhNAKWTpnuy8tu4BxoYFrOnE6h2cQSftDBSZF1jD9H5bFNdhWUgd+cx1SgoOQf8zWFEYv/BiNdWfXLf/5xhO6PDGyzJZMiW5wEf/TISZh3k8HJnnr2rj12E34Apbr7avpePSrkKwEvxQEy+z4dhF/Bg0O2ogM2H4ziQBndY8eOtoZKdSBNVLTUutEHneDMWfi+wx9N2f4GWvAf0MoGQq9mTJZCAsIN/8lslJUQHqUtLMwe4riX9TYELysnHjmBLx4BVpRKbqRpDzzXCFZMZm+lheS0RXfsXRUVTyUpE4je9UYtxc3Bq3aRmsuD762wAPiac0a8waJvIwZxCyFkRqnV2UTzSVAZq9HdvN8WlshHm4kJ7NxzwkkzwkjTimwFbHeJuUbf0Thgy8VRgW9NlDCUc8zguOcMD5gMfrcPDoyC8jiyZ7Hip8tzQCuCn++gQU8gxl9TLmcOpxne5QCbJKjQ/SoJNybrS+/UDpu+ClOqO0q4TRrAmXp8dx9NizePSzXudv9mhLOegwYcz4U5CuLnpcT7fhzVo9C7oAYhFGt47S7Oy877natL8vYTR/ZBUvCQQ1eFHwltYupdhekQ7Rk9M4zl1GExsd11XP1Y4n/XTbLqkg83jNyiai
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb30d5d-7382-498d-1bdf-08dc0490cecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2023 14:58:37.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SKAH/zrCymxjkNFVQ+UnzjMX/ZijFm+4lAm43dtHvCtWEHx8bjdbO7jXt/1H6A7EXQByKz7/vJwXclJEPmDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4383
X-Proofpoint-GUID: ZRShILW0-Fkuv9zM03l8A99OAwjW5Hd9
X-Proofpoint-ORIG-GUID: ZRShILW0-Fkuv9zM03l8A99OAwjW5Hd9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: ZRShILW0-Fkuv9zM03l8A99OAwjW5Hd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-24_08,2023-12-22_01,2023-05-22_02

PiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlk
YXksIERlY2VtYmVyIDIyLCAyMDIzIDE6MDkgUE0NCj4gPiBGcm9tOiBZdWV6aGFuZyBNbyA8bWFp
bHRvOll1ZXpoYW5nLk1vQHNvbnkuY29tPg0KPiA+DQo+ID4gV2hlbiBzeW5jIG9yIGRpcl9zeW5j
IGlzIGVuYWJsZWQsIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3luYyB0aGUgcGFyZW50DQo+ID4gZGly
ZWN0b3J5J3MgaW5vZGUgaWYgb25seSBmb3IgdXBkYXRpbmcgaXRzIHRpbWVzdGFtcC4NCj4gPg0K
PiA+IDEuIElmIGFuIHVuZXhwZWN0ZWQgcG93ZXIgZmFpbHVyZSBvY2N1cnMsIHRoZSB0aW1lc3Rh
bXAgb2YgdGhlDQo+ID4gICAgcGFyZW50IGRpcmVjdG9yeSBpcyBub3QgdXBkYXRlZCB0byB0aGUg
c3RvcmFnZSwgd2hpY2ggaGFzIG5vDQo+ID4gICAgaW1wYWN0IG9uIHRoZSB1c2VyLg0KPiBXZWxs
LCBXaHkgZG8geW91IHRoaW5rIHRpbWVzdGFtcCBzeW5jIG9mIHBhcmVudCBkaXIgaXMgbm90IGlt
cG9ydGFudCA/DQoNCklmIHRoZSBzaXplIG9mIHRoZSBwYXJlbnQgZGlyZWN0b3J5IGRvZXMgbm90
IGNoYW5nZSAob25seSB0aGUgdGltZXN0YW1wIG9mDQp0aGUgcGFyZW50IGRpcmVjdG9yeSBuZWVk
cyB0byBiZSBzeW5jaHJvbml6ZWQpLCBzeW5jaHJvbml6aW5nIHRoZSBkZW50cnkNCnNldCBvZiB0
aGUgcGFyZW50IGRpcmVjdG9yeSBpcyBub3QgYXMgaW1wb3J0YW50IGFzIHN5bmNocm9uaXppbmcg
dGhlIGRlbnRyeQ0Kc2V0IG9mIHRoZSB0YXJnZXQgZmlsZS4NCg0KSW4gdGhlIGNhc2Ugb2YgYSBs
YXJnZSBudW1iZXIgb2YgZmlsZSBvcGVyYXRpb25zLCBza2lwcGluZyB0aGUgc3luY2hyb25pemF0
aW9uDQpvZiB0aGUgcGFyZW50IGRpcmVjdG9yeSB0aW1lc3RhbXAgY2FuIGFsbG93IHRoZSBmaWxl
IG9wZXJhdGlvbnMgdG8gYmUNCmNvbXBsZXRlZCBmYXN0ZXIgYW5kIHNob3J0ZW4gdGhlIGZpbGUg
b3BlcmF0aW9uIGNvbXBsZXRpb24gdGltZS4gVGhlIHJpc2sgb2YNCnVzZXIgZGF0YSBsb3NzIGlz
IGdyZWF0ZXIgaWYgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSBvZiB1bmV4cGVjdGVkIHBvd2VyIG91
dGFnZQ0KYW5kIHRoZSBwcm9jZXNzIGlzIG5vdCBjb21wbGV0ZWQgZm9yIGEgbG9uZyB0aW1lLg0K
DQpCeSBza2lwcGluZyB0aGUgc3luY2hyb25pemF0aW9uIG9mIHRoZSBwYXJlbnQgZGlyZWN0b3J5
IHRpbWVzdGFtcCwgZXZlbiBpZg0KdGhlIHBhcmVudCBkaXJlY3RvcnkgdGltZXN0YW1wIGlzIG5v
dCB1cGRhdGVkIGR1ZSB0byBhbiB1bmV4cGVjdGVkIHBvd2VyDQpvdXRhZ2UsIHRoZSBmaWxlIG9w
ZXJhdGlvbiB3aWxsIHN0aWxsIGJlIHN1Y2Nlc3NmdWwuDQoNCj4gPg0KPiA+IDIuIFRoZSBudW1i
ZXIgb2Ygd3JpdGVzIHdpbGwgYmUgZ3JlYXRseSByZWR1Y2VkLCB3aGljaCBjYW4gbm90DQo+ID4g
ICAgb25seSBpbXByb3ZlIHBlcmZvcm1hbmNlLCBidXQgYWxzbyBwcm9sb25nIGRldmljZSBsaWZl
Lg0KPiBIb3cgbXVjaCBkb2VzIHRoaXMgaGF2ZSBvbiB5b3VyIG1lYXN1cmVtZW50IHJlc3VsdHM/
DQoNCkkgZGlkIG5vdCBtZWFzdXJlIHRoZSBpbXByb3ZlbWVudHMgYnJvdWdodCBieSB0aGlzIHBh
dGNoIGFsb25lLA0KdGhlIGltcHJvdmVtZW50cyBicm91Z2h0IGJ5IHRoaXMgcGF0Y2ggc2V0IGFy
ZSBsaXN0ZWQgaW4gWzAvMTFdLg0KDQpJZiB3aXRob3V0IHRoaXMgcGF0Y2gsIDIgZGVudHJ5IHNl
dHModGhlIHRhcmdldCBmaWxlIGRlbnRyeSBzZXQgYW5kIHRoZSBwYXJlbnQNCmRpciBkZW50cnkg
c2V0KSB3aWxsIGJlIHN5bmMgaW4gYSBmaWxlIG9wZXJhdGlvbi4NCg0KSWYgd2l0aCB0aGlzIHBh
dGNoLCAxIGRlbnRyeSBzZXQodGhlIHRhcmdldCBmaWxlIGRlbnRyeSBzZXQpIHdpbGwgYmUgc3lu
YyBpbiBhDQpmaWxlIG9wZXJhdGlvbiwgdGhlIHBhcmVudCBkaXIgZGVudHJ5IHNldCB3aWxsIG5v
dCBiZSBzeW5jIGluIG1vc3QgY2FzZS4NCg0KU28gdGhpcyBwYXRjaCByZWR1Y2VzIG1ldGFkYXRh
IHN5bmNocm9uaXphdGlvbiBieSBuZWFybHkgaGFsZi4NCg==

