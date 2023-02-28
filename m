Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3C6A52D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 07:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB1GHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 01:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1GHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:07:30 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E2423662
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 22:07:29 -0800 (PST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S50XVd029420;
        Tue, 28 Feb 2023 06:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=clG+WoaYavyBFLjc+J0nw2ppl+r8rsSHNbCNioiMC0c=;
 b=XiZhJsI97Qmmy89VbSH0enhTcoGHts7dqKJ4xg5OmjR4HyAcQgO3yCrX5v50bvtjs9y7
 Yf0cZzfSZmGkobAGTldTD6Cv3MPWQkGfW7enqgNQUbeAzVEWQPCy1eM3VFzEIg+9Absp
 n8fgNriruMT9XS7XiruOjMIh5ooXFNbqrqM9GfQ4FBt+0QzgZy2rumKJraZDZ192j6d1
 01z0PyImg5u6isaJKzXD1Ia66UA1NHieW+UIEZep5cOLyHnGlq/P9rLFsUmu83WggB6x
 twZashStE/pOprm6ynyzeLfQXVaPMyTmb3691Uarh6/+DoaSQxtq5mqAQrbafprUkI+W bg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nyb2gab01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 06:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHgn0M+rL/B9dSIXnBkFO+O3MUOxPWRMcErA3gpkyFuy8ocXIhCdydTGtO21IR2thoG3qEH09OMHW5X73zCnK7wyR8nwtCMU8bpvSZXGWzcPua1brNBY7aUX/hYIj2PZAC5cTL2OKU7BOs7uwq2WKh2M6Pt6WAMHFkR/g9TtKz25NpQW0HxM+iz7+yeoKyw/B1W3P42IGm8E7OUr1YDDYI4aJI1urmaCOBaQtlQjKE1ULeezzDMc8CGWTbttTUU8BzWwgUWk8+j6ocROfEW27TjjEajHm7wAyjKte4W6U2wqlMImY5EgO8+RYxno6RMBzED9QmDMJ7j0R/iIj/Xmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clG+WoaYavyBFLjc+J0nw2ppl+r8rsSHNbCNioiMC0c=;
 b=DZ41vGtUIKWG0MVvK54Ua2FdjodP9/abZshJTcyBJICz8XCZjYT9c6BrKH0ORF8e7U/kxK9VmibyyQkXc/5exCjORtiVlQ5mWOWJcGorC1r1njixjn4qHX/flk+Iihd02EslwXhzwgA1wZP1IdRAVDBWXZcxgakZBw2JOMv9oAMXHjHu0qB1N5b5aR7ByxGwpOEP+e9WGMlsCQJUTnQgcYlPefieOzkdj5XF+EtDtOKN+XRNeSFggkRFmBbFZNWmVYcfWekciWqFHOKVfoM+g9udnRkXzaCk7lJXHB1xLw/+24RUhkGGwixh2R5IMOr4n/JlZZB4rz8C3Y+gIFv4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4227.apcprd04.prod.outlook.com (2603:1096:820:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 06:07:06 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 06:07:06 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Subject: [PATCH v2 0/3] exfat: fix and refine exfat_alloc_cluster()
Thread-Topic: [PATCH v2 0/3] exfat: fix and refine exfat_alloc_cluster()
Thread-Index: AdlLOk+vq0bI/eoiRruPludYvyVdng==
Date:   Tue, 28 Feb 2023 06:07:06 +0000
Message-ID: <PUZPR04MB6316DF13B8E9FC79FD477A6C81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4227:EE_
x-ms-office365-filtering-correlation-id: 5cc5236d-19ab-4689-3c75-08db1952051b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cs8eMSaQ9qr4Rng9U4JyrbJwWwCwfcczh+3vMgwaavfEw4Mv0doFHZAVnRCqWC759q/ciJH951BsnPNC/2JsQHcRigHfKhwANqpS/DPoZ0J9R0IoxFSahQtztg13GZvcY+E6A/K+phZ4Us5deNdGfbaeRuXzqj/VVQq5Ro7ZiESCE/ORxoVDsZtUSRXalh5oOwLJfkzVNrWB8RUKlxyweCbaEOUxuCW3sZMjIuyu18JXYQC0CArj5MSzPPzy1IILUGVduM71sea6QpRw3WjwXHXDBGmfPfaH3ref8hwqpuFbCgr1xlHcKiYMW1BFaWCPZTTXzXaAPrGMEezt9DN53mK3nnVwu5dNZhTvsaNX6YnZ1nXOAK8qBEDfedO0PV9RlUM7Zezachy7NPW7SQJU1axhXHhdtnncp1tj/z5Ix985JQn5YiSikPKs5mLLABWIgdzhiaZ1EJ6S8Dboy48gGN4uuRd1us9rD4zm3NxUI6PDx/zknvdlPboefANj23Yyzvyj41gGt8lgL1jsbI/MbPOTF1gWw8lvBTHpDzfjbaekDrGpN2iFHPcALqq1TnSVyrMLQxxkThNJT91sX2uqWRSu3B6kzGTztaUvPc3ixYlurPAzK/5yoSnmHjVx5ZcMsGsSJsDMJsd1/gBE4hG6JsNAxgLqptbMsadgaVDiII3FfvHVdb1fc1m8xd7+RRjnGYtQrqc5jE5gA8Q1+h9qMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(110136005)(83380400001)(33656002)(54906003)(316002)(478600001)(82960400001)(38070700005)(122000001)(7696005)(26005)(41300700001)(9686003)(186003)(71200400001)(6506007)(107886003)(5660300002)(4744005)(38100700002)(76116006)(52536014)(86362001)(8936002)(2906002)(66946007)(8676002)(66476007)(66446008)(66556008)(4326008)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFVXeGIreEM4ZUtNWDAwcDV4QmFCMTdXOGJJVHNlNUtiQmVhVFhKbXVlWWlk?=
 =?utf-8?B?N1ZWWm5ZT1JyWG1TY2hteDFNZW1VUUtHOVRIa3NWMTZBcDIzS1RWdXBCM3Fk?=
 =?utf-8?B?WVU5S0ZHdm4yNmVBdGVyOVdRbU5iZXN6aDZFWDFYK2xXeFpFSFZLbmZOWjB3?=
 =?utf-8?B?ajRtRWsyR1YyMGZrSGlBN2ExQm5RdE4zbjlhMWpFZm4xejBuOFB2WjM2K0ZT?=
 =?utf-8?B?MC9qS0MzWSs3THkvc0RXNnFQcnZ4TTc5N0Zhb2loQ050eWJYU1dkcUI1VXB1?=
 =?utf-8?B?SHVKemRBTXZNeVFyUCtYMy9xUWduZ2dLUHRxeXNHakZFQWRNZTFuY3lSeGhq?=
 =?utf-8?B?VG4xVjgzQWNyL010Wnl6NlYxR0xpSHkzcGpiTWZ5VVEvaGphdkRCS1RlWXFF?=
 =?utf-8?B?NXk4YzhhWTNpRVpvdUZ6dm4ycjVGd2dBVG5wRm5wK3BrcTlNWkhqUkVIRTN1?=
 =?utf-8?B?K0VnWENNTCtRS2l5dE5DYU01SGp6YThueGhTUFU0dnpkRlJqSWdVeVVsZUxI?=
 =?utf-8?B?ZUMzUk5xV09GYjF2R1NIcFFqS3BCUkJ6OFVoL2NHRzVuenFYc1lYV3FNWElP?=
 =?utf-8?B?MjI3WGRBR0RrWWF4ck1nUTZLeTVxaHJuUEdxUTc5b2wyTWM2SzJSbTRkSWw4?=
 =?utf-8?B?MVVCRGE5blBaK2tmTzRWYkM4aEhtVE5qc3JyZG9TcjFHdytZZ1FOeCtHMFNu?=
 =?utf-8?B?a1U4bDdaM01tVnYxZlpFM29LTzY1UzJncHdWZCtEalYrb05zckhYL0JpZHky?=
 =?utf-8?B?UHBMZ29ncitQYmZUMGZvL2h1SFl4c1NJYjY2RDN2SU03dlVhSEd2UXAvczc0?=
 =?utf-8?B?OWswTTNnaTB2VjJKY1ZOTnVMRlBvZ3VPc2dNN2ZKWFUwckZodUREci9qMVhB?=
 =?utf-8?B?Vk9FSWYzLzZYODNleGZHWnhHMDRkc2hXWWg0M1V6VEJ0R2hiUCtxbFdsNjFW?=
 =?utf-8?B?bzNYTkM4OW12RWxLc0ROYXJqMG5KVjJKTDR4cUNUQndlT2U2MU83UjF5dVZu?=
 =?utf-8?B?OGcvVmprQVpwR0R2ZWwzYlhvWFk3YVdlYUg4aDlsSm1Wc0VmalNuZ2ZZYThI?=
 =?utf-8?B?Rjh5YVppVjZTUnhPb1VNclhuNlRNNzllWktIV3hoY2M1QXhLczcwd2ZMeWNp?=
 =?utf-8?B?eVRVY1VXUnVrSmNQNlVIQmdPQUtKR3N4ZUZzM1ZhN2VEVldSSzJ3cENTZjlP?=
 =?utf-8?B?ZVVLVmZFcGFaa0NQWWU2Qk1qd1oyWmJjTXgvUDFIRmFsUExTN3pzdHNSRDZQ?=
 =?utf-8?B?VXRtUmRyd0dsbDcvZkNua3daMUM4cFQrRisvdDNNbEVnRjBmVEZUN1JxeXgw?=
 =?utf-8?B?bjZGdnpPVTdXNjQ2UkEwK1Fjd0tJaU9JcXhEUUNoanVrZGFtNkJ6V3pGSFp4?=
 =?utf-8?B?aXZsVGdtOXl1N2JTNitHNW9rb1VMd0IxcGQrdkFUMDhUNW1WWVQxYm43Y24v?=
 =?utf-8?B?VDBoaUQ0RzJaRHpVRHZsak9WUTlhcEc0UlNlR0NpaW05M0NoSGJEWGlvckhC?=
 =?utf-8?B?VnM1K2d3QlhRcWhBNEJkMFhOWFZDajNpRHBUSUZ0SEo5RGljVzFSTXdUUHVN?=
 =?utf-8?B?TUQ1SXE4Y216Ly81QUNyeWxMYVdJWTROSjhvcEd0c2Q5Z0tnTk9CREx0ZU4y?=
 =?utf-8?B?Y0RCV0pWRkptRGxueEZtcnlZVUp0RFJrblpRa0NBV3Z5K2tRcUpnRlFhZDF2?=
 =?utf-8?B?VXhEWmk1d2ZiQU9HWHM2c0pLMHBma1poeFZBTTIwalBISHN5NHE1alVVcjEx?=
 =?utf-8?B?Ry95VWZUM2VrS09oRC9vQ0R5eHJleVc0SVVTL0NWZXhWRlVzMWZVREhvNnlY?=
 =?utf-8?B?ZGU2MWtaZ0h5cFhuaFY3SmcvSEZYdVFOWUMxcVFkcGY3Z2tPUVNjdGljbzVF?=
 =?utf-8?B?RzY4ZHl6dUF0UVE4Um1HeWRsZkRMQ3ZEa3ZzWXNJUitWUlhTWlJwbkxDTU5a?=
 =?utf-8?B?OGZES1dBSlNNK20wZjRndjN0MGRuWUI1UzVRbkNseGt4d1dKZ0Y3UEpways0?=
 =?utf-8?B?TVd6WU56RThNWGhTUjRPd3MwQkFDTEJlSnJ5VHZwdHZOS2xKUFZvOXFPZWl6?=
 =?utf-8?B?MXNSc2pGa3l2VnFiRW9OV0d3VTJDOTQyZmVVZXRFa0ZUcnp0WUoxMWsvRWpw?=
 =?utf-8?Q?F/BBTfmG9tJ8th0AqIG0JQ+as?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QR58E8EfoV2iuhKQ45gf/XGK8XaqIYH/HnNltRQ0EWDo/cKsBBr9UTPI7TJxK0z9fj6WBj5/QTNXQihV/X2w9nTIpC/qtfJTi99oLUbNNOQ0gHh/yd6VElFfCaIHSztHoMEscSqjun+P+iJjZRjF9Zeh/pEJyuuAvA2barBXTsCEduxi/XfIYdEjcD5kzu9uU4NXb6y/q6nrkRIFjMycjgrgpw4mnK1BYKq403Z5/glXyCmpTsc/zPwZEFivcA9tOrzJlMjoina4/9L1DXMvuBoyPaLpSTzV0Alsji4mMybH1urQCKt77iMGpVrM1aGUoJoFnauzY6dcXvM+x6S91UKAZ04DxaA37OtAIm9Ia1CzJmpzbiMEIxBH2QHKeiCbAJ4OyJA8Ed2L6at/LZe/jtch26yQto79rk61nP67p6acj0xFsy/KB7hivjC93qNVktktm0EBPOHOLpShhwW7JIliNWaM3hoaKNE+74pthft1wBxsesTgJ7FR6+fnrTNsV4rAj1oPJQIW7sLzLsqkleOcKa7DUePCOwz+MKv4f0ptvarA2Z8IBt/tu6k0Y1CtqW1SHaFYqtrTqu0fzEmPVsMP8IHcCm5NYUQloodZZvvpb+d/WUn3OSXHP+5tPDO31tr+15Ry3hjFyHUear+vHLjeFspJzJUSpwJ5iEGGtXX7TNqBbRTmTMIuhVIPCX972oj8gAYJ/U4t8L5I954rTv6vI0s4S8Xs61bxsP0fubkcz1GJLYHTvk2DtMmlVgtlyVtJImXHV4XITiinqQjXksX0KUeem8FLiKHirFaV01MUiJDnpi3+P1kw9nDkdgtE+vEMq/Nef/Q54brzJ5akeg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc5236d-19ab-4689-3c75-08db1952051b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:07:06.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO34ylV781j6hX6qjoovQotLY8xiol2DBtzahA06dVa7MS3c01PlkUctdFD6gnZNOxHDJpzQqQLeTrqpjOkCSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4227
X-Proofpoint-ORIG-GUID: NPJA8Q6cEyAv7t7S3K1nBkzyr9zx78VE
X-Proofpoint-GUID: NPJA8Q6cEyAv7t7S3K1nBkzyr9zx78VE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: NPJA8Q6cEyAv7t7S3K1nBkzyr9zx78VE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_02,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Q2hhbmdlcyBmb3IgdjI6DQogIFsyLzNdIGRvIG5vdCByZXR1cm4gZXJyb3IgaWYgaGludF9jbHVz
dGVyIGludmFsaWQNCg0KWXVlemhhbmcgTW8gKDMpOg0KICBleGZhdDogcmVtb3ZlIHVubmVlZGVk
IGNvZGUgZnJvbSBleGZhdF9hbGxvY19jbHVzdGVyKCkNCiAgZXhmYXQ6IGRvbid0IHByaW50IGVy
cm9yIGxvZyBpbiBub3JtYWwgY2FzZQ0KICBleGZhdDogZml4IHRoZSBuZXdseSBhbGxvY2F0ZWQg
Y2x1c3RlcnMgYXJlIG5vdCBmcmVlZCBpbiBlcnJvcg0KICAgIGhhbmRsaW5nDQoNCiBmcy9leGZh
dC9mYXRlbnQuYyB8IDMxICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4x
DQo=
