Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AE642277
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiLEFKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEFKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:10:32 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D6110077;
        Sun,  4 Dec 2022 21:10:30 -0800 (PST)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B50r8Zi001701;
        Mon, 5 Dec 2022 05:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=/4nCqGhymcqBsWRZN90JpJHo+c7h/d3+KXFuEzngCRM=;
 b=i/wxrna6RwxHKOZOTZm9KZrJAxeAZlKNwG632xtnKPcF+uFgaGrwAkpaJprEA2/WJfUZ
 j2VNnY47TTMwm868Uc3HF/afGAr0PoShn3P4ThZmxlRouiJrdONXyLOjSU2l2p4Apw3n
 Rf5B1oLAzE5TBTccFplu4qG/Z7PacaPIxAlvziay7tHcBJwF1rYN8hqBguL7eQA7Zgn9
 +DPe7EYjm6koBVJGlaAubMfZ4ejknQDPWh68ClaLX+ZQj72TYmrqpqpJ0kp6Vu8/WmJF
 UQfUra+ti/vhdosC+1ytWOLhYdLFJ8wiwRnEIPDdaPnqqH8gUF+M8Z5g6vt1UlV7YwMZ qQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2046.outbound.protection.outlook.com [104.47.110.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7ygd19pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L36XPPP78C7qdU6WXHwRTT9Z3k7kBg8BNq8j8gdC58vJbHNqeAC7WiWOrCzHsLfMphX13Rq3NW5lO+awmzMC7e0v1OYLKq8nEntzIgqylM8gKyJbAc90uIAyDSyeGPkAfkKF7oPrWNQ3NjGtbFQnqtVQPt8RHc7gyMIKifiUbUXNdkhFnyS6ViRpHwO4MXu7WUuT/1ZwvAc8e6fLNteJ0hBN/kxB5WZMsdzmkLGjUq7W+1oYqbFhmoHpWe/mW3Uc3ryGSGG/YYKjztk3KSaiESIQeKVmVupB1uCq4ukKBv1b3amk9bzrCESkS5K31XGQ+XCHZAUbTgJ7awpB2raVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4nCqGhymcqBsWRZN90JpJHo+c7h/d3+KXFuEzngCRM=;
 b=eghAcuBFIHJxnEoi6yOj1OYY+f38iSNqOeciL6QxCaZUYbfo/god+wBZEiKDIKxe6QmomZp78apT8SexRna6No/Ue/zQuUsMZq6THsppDVDKLHw+N3vaGo2/q3uMybYl3EijRUnqt8Ui9TG151XhHN7WKC44UbVYL0yKeodCtDZRqj4P7hymJXLwdvJqKB7YqKOuG/gbMMfn3fEzECMaI5tW4E6B42CSvN5ApJr8JKim78uqWupJF8FP3x5eOOuUVqCSIqwopgDidL77FT97BwMBTgd+ELWYzU4xekkXPAvNrUuyV2bjmntiF21GxSoXi0AOBose/j5cQ/+Fm3YSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSBPR04MB3909.apcprd04.prod.outlook.com (2603:1096:301:2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 05:10:14 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:10:14 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 4/6] exfat: remove argument 'size' from exfat_truncate()
Thread-Topic: [PATCH v1 4/6] exfat: remove argument 'size' from
 exfat_truncate()
Thread-Index: AdkIZnhxe+TqMJXuT+WIfdRVSGaD1Q==
Date:   Mon, 5 Dec 2022 05:10:14 +0000
Message-ID: <PUZPR04MB63164BCC8C07B9B4FA0755AE81189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSBPR04MB3909:EE_
x-ms-office365-filtering-correlation-id: 785c21d4-ddb0-420f-2996-08dad67efe1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Auq8BRJf28TbcTMvhw2SL+svj3hgSLNtnu3VvxNC6v7JQSCWe1qkZ3amKnPvWASTlH2nq4y/AudomOBanbi/xllye/Gkiu/Cxhku/tZ9BCmc1djTilGIcHOErMvozg5c3XQq8W3dnwkZUx1WgQOw+M9sIfiFxcKjrS3+HuE9n7gHO+CEydT/XIPdfnbXGfVY/zxuRF9Yl2BC2JkLofJl0O6BEZLhyjRSjSnCxzC0Mr8cOR4jsfpw+PnXDtNuyvJ12rTkIJi5wgE5swx0WoDsSV2JtZsY02MZeKwkS7VsnlcJIsB2lZzUJJJlNdnRhXTdEe3UrRI0NaLktb+65xfAOY8a8fl+qMSoHS3FwOQC7n8qVsv1BBEyyr6h7Fl/W5saQrch4+rtbSzSXuKcQbrvYQrOjAkzL1FZVoyP1EQE4ZJrPCGrIDO3dRsWsaxxGXhHy/08INLVlhPGkDcjDgzZ1zvAT/gg1+FNXKFkR59JVpa1hy8VAIkHtvXkJtI03TK1MBoJTaUKzFT9sb1yjr2T/9xR3HguvyQs0qQ5ccKNF55T7NPckYSYP7oY8J6uh5rjJreNf21sZlXiO0CeWJm3lCeF0FDhkVDIdtz3ySo/lymT/2c1z7xT2kRwaniFX2SJUbGDt26u99JjLOCr7TDgOBb7ElZcuWWm51ZaE00svPkjUumDH3I4eVuw6z5NY+APJDNTFobU5BwiIR5aeuhZvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(26005)(316002)(107886003)(478600001)(6506007)(7696005)(54906003)(110136005)(9686003)(71200400001)(76116006)(66556008)(66476007)(8676002)(66946007)(4326008)(64756008)(66446008)(8936002)(52536014)(5660300002)(186003)(83380400001)(41300700001)(2906002)(122000001)(38100700002)(82960400001)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0VlMzVVRG1OTVV6T2hLUDNIdExnQkZkUDc4dVNGaTBxK1d3Tk92SEsyZVN5?=
 =?utf-8?B?d0NiUFRMRUpxb3VEbnl1bVJlSFIzNHhLcEtaRnJobE1FRUpzOHNYeUVZaXV3?=
 =?utf-8?B?Vkd3MXZONWpiN0t6b3V6dThHSWhacitIVmdybHU1M1ZqVitSWHA2cnE0K3lR?=
 =?utf-8?B?RWV0MFZnd3h4QldVSGtzMXVLVjdFVUNtWEhRS3pJVkdsMDhONmtpQlVxb2V2?=
 =?utf-8?B?cDVsRTBsOHBVOXlCQ3RRYnN3YVplQ0FGTEdTTUN5dk1SVkZ0QXpwUzhSOHJS?=
 =?utf-8?B?aVBWdlV1Zk94cVRqSjZuNHR6dFhhMWpVL0ZuUTh2UWxvSFRwdUxoRGFuWkxN?=
 =?utf-8?B?b1BPRm81TkN2M09TejkzMzU1Yk5UbGxGOVBaU1EzNStsdUhhNWZKaDRHYnhv?=
 =?utf-8?B?STZWbFVrZEpSSkhmbkk1aVRMNE1VcnpMVDJVb0U4LzhPWm4vZWZobXRYZXNM?=
 =?utf-8?B?WDRmZDdLZjBUa2dCTzZOalczZWhaUU90R0JPb1lDMGdMYzBDOW5WUTZCNTAv?=
 =?utf-8?B?WFB5SGRVR1BmZmkyYmRTSnlGSGk2WlpFZHdlUndBRmdMclJXUDZsRzN0SUtE?=
 =?utf-8?B?VFJEamxyQUpXMFprVEhOZDYyZUJMUjhjMVdoUkpyL3M4c0pUK05sdHRVbWFz?=
 =?utf-8?B?VEM1dWZQRmdHS3ZFbjFqbmw4eHlxS24vZVZtMXNqZkIyU1dCK1dlRkF0a2tU?=
 =?utf-8?B?V3BqelVoNWVYYUIxTHFEeksrNk5Vcjlucjc0cGpFTmwwSDlZWDR2MWR3V2Vh?=
 =?utf-8?B?R1hhdURDNEc2SVlTQWVtWnVkcEVNdk51WS9SUVYxdjk0THFFU0NNS2FmYmlu?=
 =?utf-8?B?M0FQNGYxbFBqbGUxUmNNY0t6aXU5Tlo0emZFOTFQdXFlWVp4UXkrOEVwaTNz?=
 =?utf-8?B?NzM0WEwvT2tyTitzOXIvY0dvQXhmaHB5cER5L2VPSll2VVBKVzRLeU53by9U?=
 =?utf-8?B?dmpvamQxZ2oxR0JUMUh3Tnh6N2dvQWtrZ2h5UVgzQUljVUY3Z1dCdFhQeGxn?=
 =?utf-8?B?TUFUQ3NXZVZJS0Z2WVU5Q3lvSEhqdjRrQkY1VjUyclgvUmVkUjRnMGVIN3FK?=
 =?utf-8?B?QmRMWm1GK0xJejRHUnRYZU5FaXprdEttbjNYbnZpaGtvTGhjOStLQmNsNTdw?=
 =?utf-8?B?ZUlEYmtIeTlXSzFxck9sNFhucXJRbFhSNURoQkFYVXdoYjdhYjBkZzV2cFR3?=
 =?utf-8?B?cEllRTlWenpsREhJY3EwejM1MU9OWDI5ZzhjR1Exc0Q5bUxXVVF5TXJBcDdo?=
 =?utf-8?B?cE9sNWcxSEVKWjZrS2tFTjQ5YVlMNm5RNkI1SzBUVUZBcUY0aFBNYlNBV2dC?=
 =?utf-8?B?NWUwZUhZREpvTFlDb29RSFM5Vm1ZZFlCQWhObE1GM21VNDZyc1REWWhHNlhk?=
 =?utf-8?B?aThCNnM5akVXenZvQm81YmlUUGJlb01HNUNnVDVVcE11c1hzMHduL0JTeTNi?=
 =?utf-8?B?eDdqTDRQY0w4bEpBL2MzSDQwaTBYNDV2SGs5K1NadXAyUkl2aCtlREo5S2sx?=
 =?utf-8?B?bEFUWmZjQzE4RzNWQ0JrNnVrWlNaWDRZSFBweUt3UlVWRGs5R2IyZUs3Njcy?=
 =?utf-8?B?NE5ZeHNvcGNTeFgzQzFmN24yNEl1dW9CTFNLYzBYaTB2cGluSm1QaExwWEIw?=
 =?utf-8?B?NWc2Tk1VaVFIRXg0Q1NQcW9FL3R4TjFCUmg5c1ZjL29tNE9SRFh5WUduR29W?=
 =?utf-8?B?QlI0TEszcnRQOWFrdm5WSjl4TGdhR2MvUmJxVkFHVnpDeWZSZmZLRnY2WGkr?=
 =?utf-8?B?ZU5UbmlWdDlxb3RuWUVTQXlnbWREbzJWcXB3MFhFRGdXL1FlNEJEZ0dNSnVs?=
 =?utf-8?B?ZU1meXRxZ1psYU8zUGpTMU9TZWlpanBnTXNaZHl6SXh5Q3NhVmc2L2NUR0Ez?=
 =?utf-8?B?dHRVL1d5SE1meEhZU2wvWGd1R2EvUmZBVVJwTmNZQitPOHpaeXBwNkFhUG8z?=
 =?utf-8?B?bWQveW80YW4rTlRydTcyV3Yrb0dybHVXMzgxd09wMmdZc0tvYzhNejZhOFRZ?=
 =?utf-8?B?ODZjdlIxQXAyOUxONzhycFV6MW5MbUg5TFZ3bDJCZi9zeEY0eWFVZGhiZEE0?=
 =?utf-8?B?MjFtLzZHdjRCSCtxRnd1Nnh4QldaVzZodC9DY1llaVkyOWhySENld2ZKZ2U2?=
 =?utf-8?Q?Pt8w3Y8rU68mr3QdFnr45ZQtw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vJGpsztWbBscb4dr++D0fKjAs88J+m69Ls/Ua2vfRQgk3TP23LGx3f2Qop/Mu9Jt4kg+65TDNQgwagOrGjlA2H9txmv+jdXEhtdv2ALdZs4/RtkMamZiUBwop08NLCJv1K+5fHjLp0MFsZ2Od7E6SX1JpQ+3a0GuRxCc5WvF0qb+hip621R0gKDAQya9DYCf5PrnfHqsSIknh55gOK5PsFbTDlEj9R8aco16QjlMWDMQbK17RbCw1QmS/MSsLidOV8OpwbiOSxSW5uaATeUYjclH3kbfVBhsJ5sjvbOVE/qYvhgpUai//MU2ai1EArkifPfaGWVxmoyUSWNiFkk4ZfaeSDwbpfld0xKHO3h3ceU+qKsxx60yatyLcRQZNGIOnR98VNU3L5kWz0siKvYeoX6MKCwopphRRpeRnrtTQe0b7Bu4cBwD4fklqPGuT3EtdrhnUZPWrZe/L9RC5w3KTP5WA5pYz2BNU437IUP6rJmBxM31aLfgTV+eNvHerO2V/yJQqDvMdAP68DBPOVjIHUkHfZZsNoWxxSipNiNa17IM1RLE0S4KfACvCSji285wBV7LkP+zv0hrcu06xuPGF4jHgciidgDwkeKbScMMFRCotL8NPg9wKKGborTabm8J34fZSMgM0tS+Jovb4C9T6rR4Si+NwdvIFbK/cXbWw4pvg/oEqEIMLzvS938bW/ZCSaNOq5TuNnMSyP0Tj48NNIKsJtI2LhXXrpTFHR7tNSoviPlY6BBcKp1wjEL7vKyRR24A6YIDETHBdfztx4XJ4RyOUvJ3gPCxtjX+PF0e3aKVIHfgPro4nUckRVd1cn/Hvzr+U/7B3cWUGxlgIDq7ScXmFarzgI2fN+gWttNvKgv7pJl9qIenWZGpAWp6tXdr
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785c21d4-ddb0-420f-2996-08dad67efe1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:10:14.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVQhdKk9VX9xvxkKtF8UyYWOvkKav1cYq5bwoV0uBQVjjKxHdDgoEvWK40EU6902H83gO264GBm1DzUMevpBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB3909
X-Proofpoint-GUID: _BX3BBEK1vPaugjArhJwD-SpISUmOwD-
X-Proofpoint-ORIG-GUID: _BX3BBEK1vPaugjArhJwD-SpISUmOwD-
X-Sony-Outbound-GUID: _BX3BBEK1vPaugjArhJwD-SpISUmOwD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

YXJndW1lbnQgJ3NpemUnIGlzIG5vdCB1c2VkIGluIGV4ZmF0X3RydW5jYXRlKCksIHJlbW92ZSBp
dC4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoNClNpZ25lZC1v
ZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBB
bmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdh
dGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgMiArLQ0K
IGZzL2V4ZmF0L2ZpbGUuYyAgICAgfCA0ICsrLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgMiAr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCmlu
ZGV4IDIxZmVjMDFkNjhmZi4uYWUwNDg4MDJmOWRiIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZXhm
YXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KQEAgLTQ0OSw3ICs0NDksNyBAQCBp
bnQgZXhmYXRfdHJpbV9mcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZnN0cmltX3Jhbmdl
ICpyYW5nZSk7DQogLyogZmlsZS5jICovDQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgZXhmYXRfZmlsZV9vcGVyYXRpb25zOw0KIGludCBfX2V4ZmF0X3RydW5jYXRlKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSk7DQotdm9pZCBleGZhdF90cnVuY2F0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgc2l6ZSk7DQordm9pZCBleGZhdF90cnVuY2F0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlKTsNCiBpbnQgZXhmYXRfc2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1l
c3BhY2UgKm1udF91c2VybnMsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiAJCSAgc3RydWN0IGlh
dHRyICphdHRyKTsNCiBpbnQgZXhmYXRfZ2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1u
dF91c2VybnMsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0
L2ZpbGUuYyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KaW5kZXggNGUwNzkzZjM1ZThmLi43Yzk3YzFkZjEz
MDUgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9maWxlLmMNCisrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0K
QEAgLTE4OSw3ICsxODksNyBAQCBpbnQgX19leGZhdF90cnVuY2F0ZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBsb2ZmX3QgbmV3X3NpemUpDQogCXJldHVybiAwOw0KIH0NCiANCi12b2lkIGV4ZmF0X3Ry
dW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplKQ0KK3ZvaWQgZXhmYXRfdHJ1
bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSkNCiB7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2Ig
PSBpbm9kZS0+aV9zYjsNCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNi
KTsNCkBAIC0zMTAsNyArMzEwLDcgQEAgaW50IGV4ZmF0X3NldGF0dHIoc3RydWN0IHVzZXJfbmFt
ZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQogCQkgKiBfX2V4ZmF0
X3dyaXRlX2lub2RlKCkgaXMgY2FsbGVkIGZyb20gZXhmYXRfdHJ1bmNhdGUoKSwgaW5vZGUNCiAJ
CSAqIGlzIGFscmVhZHkgd3JpdHRlbiBieSBpdCwgc28gbWFya19pbm9kZV9kaXJ0eSgpIGlzIHVu
bmVlZGVkLg0KIAkJICovDQotCQlleGZhdF90cnVuY2F0ZShpbm9kZSwgYXR0ci0+aWFfc2l6ZSk7
DQorCQlleGZhdF90cnVuY2F0ZShpbm9kZSk7DQogCQl1cF93cml0ZSgmRVhGQVRfSShpbm9kZSkt
PnRydW5jYXRlX2xvY2spOw0KIAl9IGVsc2UNCiAJCW1hcmtfaW5vZGVfZGlydHkoaW5vZGUpOw0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCBk
YWM1MDAxYmFlOWUuLjBkMTQ3ZjhhMWY3YyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMN
CisrKyBiL2ZzL2V4ZmF0L2lub2RlLmMNCkBAIC0zNjIsNyArMzYyLDcgQEAgc3RhdGljIHZvaWQg
ZXhmYXRfd3JpdGVfZmFpbGVkKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBsb2ZmX3Qg
dG8pDQogCWlmICh0byA+IGlfc2l6ZV9yZWFkKGlub2RlKSkgew0KIAkJdHJ1bmNhdGVfcGFnZWNh
Y2hlKGlub2RlLCBpX3NpemVfcmVhZChpbm9kZSkpOw0KIAkJaW5vZGUtPmlfbXRpbWUgPSBpbm9k
ZS0+aV9jdGltZSA9IGN1cnJlbnRfdGltZShpbm9kZSk7DQotCQlleGZhdF90cnVuY2F0ZShpbm9k
ZSwgRVhGQVRfSShpbm9kZSktPmlfc2l6ZV9hbGlnbmVkKTsNCisJCWV4ZmF0X3RydW5jYXRlKGlu
b2RlKTsNCiAJfQ0KIH0NCiANCi0tIA0KMi4yNS4xDQo=
