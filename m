Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B131615CBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKBHLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKBHLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:11:40 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FA413F46;
        Wed,  2 Nov 2022 00:11:38 -0700 (PDT)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A25v8TR020360;
        Wed, 2 Nov 2022 07:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=/c3cjSPRqwHVra4d9X7i01IuM7bGyyLc7e6NF4y2d5g=;
 b=mLDv10tDZJ8Y0z/POGOwADjsqH2uHjMG09PvhtnJovHev71CCO4fkswFV912Q22qbVY3
 8r4WoC6snX66NmrbJVsGJE0SaVcIgZNLyw2DKkLFfb00ZRsqt3+K/ZwW7aHMZOG4C+aE
 oNAxT50QclnZXzAo+51T5NiYce5U+68BXzoiwLLWndPU5+vggBw/myCiLhSJyGOlRPSW
 TzOazlWGmrH30FG94JIOjgqvA2FTLzhWq+oPTGscAj0lo3TkIhFBNAGXEtaXDsi2URuY
 B/ncdzzGJ9rUcT3SMWs3rBvYvxRVgLb6IiYfOY7Jp14mUFPat3oShWmDH0yoVVBzuBx3 0w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2045.outbound.protection.outlook.com [104.47.26.45])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kgt2p3yw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 07:11:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqajiaKUwueHlN92IDiVDUVWRJGveaL8OnCKqbXPnmlHEveLD088S1HX8DkJb3JzRL6VFgPRQX06vMouPeAbZb/anOHBX45yTLypUn6jyrt35dpEHu9bnOp13KbQTT2EjYhjmvNJDxNYhwuxgicvwEmEriD6D7Vxozc+9WrwSYdBwVkYOcQZu4jzURnNuP921CbxyaU2z67Rk29S+S1+i9kzatuQksi4ah/VtR8N75U0TJJbmibTLIK5yKSsrJo4SpHxomkTrYj9WKhjRXNeRnwFLrePJWkCchgqLZ2iQkKAMkGuVu3hFTFmW5gl34aiCY6bTR+ZWlk7rZoUxa40Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c3cjSPRqwHVra4d9X7i01IuM7bGyyLc7e6NF4y2d5g=;
 b=QinRVsC+/TvKZX9VAmVGkT1rtPE9oxwW1BUUWj9lXkIe1RizIJEtKSG/LrSMCAHFv/VfFDbp6FEvbyq07MeWxGDlT+A+n7Lz1E3BYMGGBI2kUJ50eifUIMLA1cBDfK/2km2dmmWZb2nvTXMBZNqYBChGcKq6Sva9kY68SgtZ/LlQKdRgtNYYV9IQtZp+NHhhrPLPOC22g5DRcmODQJR/HugDadP79yK4VreRQ23/bWfYFKYzn6ldmJUIIx10gkUP4TPddwo9acLiJHzBW0eEPJ81SE54ysIldZzOp0NXmKCIV6+t9ZB/VBQCXlKUcLpZ+6Lugg13ZD9KSWDRdOZUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6242.apcprd04.prod.outlook.com (2603:1096:820:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 07:11:23 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%9]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 07:11:23 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Thread-Topic: [PATCH v2 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Thread-Index: AdjuictTJa4khvd5R/iv8k3hEb/6ZQ==
Date:   Wed, 2 Nov 2022 07:11:23 +0000
Message-ID: <PUZPR04MB6316A41FC40A84059E60BAB481399@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6242:EE_
x-ms-office365-filtering-correlation-id: b23799c8-c983-459e-3c32-08dabca17337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZG8KMDyQCEcljq3RIigvSHVdZXG8L79QYDWAfvbhTBsQ+kLLIxXTzmQcc+fQyhPCt82g08U2EswyAOMc+eyV26RdNeWm7QgzAD7SdOkVtx5bvEIhOcChNSuUWL58sy3aSDOFe9Y6I9vmYWprQ5p0+baUFvQgk9/MOKglRxupurQS0Pps9+pOivuXw+Qgm0MmKTgAgDbRvHV6cqO1kDiY7MhMJv/2gmBdakdGPIlHBmEQwJjWlIump7vnKjrOlcCsnNkEbDL4HFklGsO+C2UzA4VdQIWU8DPIJ8XYmhC8D3BfUXeSJHG6z57Rr46X2jhduYQifMRFXAESzWNHxaYcRIk8Jiago739v0JwxoDe43qkbJ6Vmaklvk8cIRyINUGNCEPurrutgtlb0s498/cPOejE8kdh41kw7mGRBBoGrKyjadimI9dj8Z9v5d0oMdp6Dl6Ai0nL+8lXRtGbPKSK7r5QK7JEaLF1rdtGe8LV9wOuzKOJC2NwEbiijWqn7fCIRNiJ0mWVKM3oIy4VbxkqxKX6+OqeorTyV77Roh2XxNLVuiXE84dhSlxVK+JCv9nMQ1PYiuGS679aB+a8v9eFMrcn41xbk3Zd93vVoWJDeixfKIT/bmvmHi1qrYMI88OnQGWSayqQpZPqgTwpWo11o5CmnDl8Kw+1IdKN5nmlxa5fn/4NM5u/kIZ96+t3DDjiQ2o2cChIfZ6Ym6h3HfqyYy0K0eDB2KmpmEQVBp4DaDrZy0iWMUSXI8IQxFkiXYmO5XI1raSssPO1RzBDDe+cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(9686003)(6506007)(186003)(107886003)(316002)(26005)(2906002)(83380400001)(7696005)(55016003)(54906003)(66476007)(478600001)(66446008)(41300700001)(5660300002)(64756008)(76116006)(71200400001)(8936002)(66946007)(4326008)(8676002)(66556008)(52536014)(110136005)(86362001)(33656002)(122000001)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFRRb0c1WnJ1bDIwcENQS0xINTdmWkJweWJTNHR4aC84bkVRSVEzdWYyYzVO?=
 =?utf-8?B?UlJueC9INERSMU9SSzRQaWVXeU5mc2FnZi9jVUh5Qk9wdXdoM2NyRjFGa2lm?=
 =?utf-8?B?N0J2V0w5d05hVHdpdjlGdkNnUldaWUwzU0NBbmdCWDRtYWcvQnpoaCswVXVk?=
 =?utf-8?B?cVRFZXY1QXJ1NWU1ZDlsZFQrWVg5eFRJZGdDUk1xaTRkL2xNOW9yY1Jlb3FQ?=
 =?utf-8?B?blBQS2gxU3lVN3FVOUdPY292dnFSQ24vUnNZQXpLT2RyOGlwWFdONzdyV0hk?=
 =?utf-8?B?OU1mVGE5QWt3RllpQzZHZ2dVVk50L0FXTVJ1VnR6N0ZVbElzUXpodUdicEFv?=
 =?utf-8?B?bG1PaUN0U1hJUlBqUEVPZ0dmZ0k0K0d2a0RYbXVjZWYrdDgzZDdQVmw2VEtp?=
 =?utf-8?B?N1FwQ1lqN2Z2MGs5azc0cHFJdy85R0ltVEtNWHRoUzhuVm1RV3pRc2oxdXVk?=
 =?utf-8?B?Mm9aQlNRMEl5YXRkb1lvQjB5cXFIOWtWNnZDRS9uRkwxa05yalJXVmlZcGY3?=
 =?utf-8?B?dWJINTFBeHhzK05GMUErc1NmOUorV253d1FhSWpnclFJdnM4eVlWb0wwa1Rp?=
 =?utf-8?B?N2xzb0oxQWV4SHI5L1huYmduVzBvQ09USnVjWTVrZ2dCVWQ1Ym81eHkxbHJO?=
 =?utf-8?B?TEVtNzcxM1lCaHZJQmx2RUVqMkQ3VFZaUEZJYVpqU1gvSEZJcWNGQnNGd2pv?=
 =?utf-8?B?WmxWVDNrU3B4ZFNpSkxydGFnWC9ZTVd0QlhIS0hMcTNRWS9ra3gyME1iRy9S?=
 =?utf-8?B?bXFXbzkyRDE0cnprZGlBeS9mdmx3dnZraElsYUdlUkhVM2pHNU85NHU4bmZP?=
 =?utf-8?B?UWdxUjhYOSsxRVEwT0JKaFpuNVRZZ3BiY1JZZkZCMXZKUnRlQTBHeXpjSGJ5?=
 =?utf-8?B?QXJ5bUZSM3FvTkJWejhyUDV1RVZZWnVlekd1K2E0a0Q2d2wvMkJyQ0cyajVk?=
 =?utf-8?B?RkwvNVE4VmlpVkhtN1JBSkdqZTZ4bHBsQzVxb0ppUHBaTG5qbmhGcDREWVF5?=
 =?utf-8?B?b21KallQdFk0V0VoT3U4bUV0aGJxRkM1elVmSUhQb3ZobUlhdWlXTkRsSTk0?=
 =?utf-8?B?b01WRVR2VkJkL2I1TGJKSmthNTBNdW1pV0xVcVV3SE93d0pHS1VlUHZNMUdu?=
 =?utf-8?B?d2pmODQ2UG1zV1dmNC9tbW8rbmd5VzBSWDZFOFN4dG5tUUlqT3JuQVdtOXRI?=
 =?utf-8?B?bnJKbjlndXZGYTRYRzdRYWYxa1FZR0VsME1aVnlhZVRuekM2MkpyclRneThr?=
 =?utf-8?B?TS9CV09lY2VPUVdRcHFneHBVeU9JWWdsOXZ0SUhzZzhJRlJ1SmVCT0xwdDhx?=
 =?utf-8?B?Y2NtS0lkcm5yRTUvRnZrUE1EUTBTMExORTk1d2pIZWxGU1hXd0JXdlpSTklh?=
 =?utf-8?B?ZGpuQ0F2YUdjQzBTaW9zN294NkdkRGtMaU5Xd1F2YzBNMmtVdWdLb09xbitG?=
 =?utf-8?B?MGxXWVR6eHV1TXE3c01GL3FWbnVaM05YY2xyY2dGTjNldTNwZTRMUzNlZmV0?=
 =?utf-8?B?Vmo5SmxFYlFVZnc2cTI4WVNXeGZmODNac1d0TW5oMXFHZThNcU9CaytnR3c5?=
 =?utf-8?B?Qk90MGVnMlQrYkJwUG5qVXA1T1lyUU5JNjVYaTdYdXF4cFBaRnF1SkduWURs?=
 =?utf-8?B?ZHpwa0lhVEJBaVhteTJyYUt3NVhDY2czSExEN1VQYkhjR3BNYjZXNkNtVUZ2?=
 =?utf-8?B?dkdVQ1U0NlU4eTBiMHpSUUZOK1JnNUVhRnU3QkNPOTcvREcveUEvOHJVeHFa?=
 =?utf-8?B?WFFvODZBclV5Mjl0ODZTQnpBS2dpNU1wZnYvcWRVcWZPNUw1ZGpKVFdUVnYv?=
 =?utf-8?B?MXVaVXhoM1crVW54bFErWDRQdFJxODlJTGZuZ0tkTW13eGR4UEtralkzcnFx?=
 =?utf-8?B?bGJCeFk1MURjRnkrMU5hVzd6anloQXpjVURUVjFkSzJXaXhpMXBoTGdDc3VD?=
 =?utf-8?B?UHV4RUw4WWZ4c0JtYWl1VkVqOXBnSG5La1BTek0rZlkzT2tWejVJbzJRRTZK?=
 =?utf-8?B?dldzZkJOU0JzYUo2djFEK1RvNDFUazR0OG9RendrT01MK1g3SzRwaVIrUnhs?=
 =?utf-8?B?RC9IaVdhSVNSVllraklDeEZzK0ZZZUNSU25ZeHlpczhQWVNGN1gxMkFnelpI?=
 =?utf-8?Q?vxIRLfE9ygWDpRM4dT0G6huy0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23799c8-c983-459e-3c32-08dabca17337
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 07:11:23.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhaV6uFf1W8g1N4W6Xp0tDFe5av6ThF+qePbnhUQY2rDTUPf46bZC5x6aJnGZ4zXiOJTxAtdhTOMU51+pPgYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6242
X-Proofpoint-GUID: LFJ-1iAV7aAGdwjZsWX4j3vieb_0kOGG
X-Proofpoint-ORIG-GUID: LFJ-1iAV7aAGdwjZsWX4j3vieb_0kOGG
X-Sony-Outbound-GUID: LFJ-1iAV7aAGdwjZsWX4j3vieb_0kOGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QWZ0ZXIgdHJhdmVyc2luZyBhbGwgZGlyZWN0b3J5IGVudHJpZXMsIGhpbnQgdGhlIGVtcHR5IGRp
cmVjdG9yeQ0KZW50cnkgbm8gbWF0dGVyIHdoZXRoZXIgb3Igbm90IHRoZXJlIGFyZSBlbm91Z2gg
ZW1wdHkgZGlyZWN0b3J5DQplbnRyaWVzLg0KDQpBZnRlciB0aGlzIGNvbW1pdCwgaGludCB0aGUg
ZW1wdHkgZGlyZWN0b3J5IGVudHJpZXMgbGlrZSB0aGlzOg0KDQoxLiBIaW50IHRoZSBkZWxldGVk
IGRpcmVjdG9yeSBlbnRyaWVzIGlmIGVub3VnaDsNCjIuIEhpbnQgdGhlIGRlbGV0ZWQgYW5kIHVu
dXNlZCBkaXJlY3RvcnkgZW50cmllcyB3aGljaCBhdCB0aGUNCiAgIGVuZCBvZiB0aGUgY2x1c3Rl
ciBjaGFpbiBubyBtYXR0ZXIgd2hldGhlciBlbm91Z2ggb3Igbm90KEFkZA0KICAgYnkgdGhpcyBj
b21taXQpOw0KMy4gSWYgbm8gYW55IGVtcHR5IGRpcmVjdG9yeSBlbnRyaWVzLCBoaW50IHRoZSBl
bXB0eSBkaXJlY3RvcnkNCiAgIGVudHJpZXMgaW4gdGhlIG5ldyBjbHVzdGVyKEFkZCBieSB0aGlz
IGNvbW1pdCkuDQoNClRoaXMgYXZvaWRzIHJlcGVhdGVkIHRyYXZlcnNhbCBvZiBkaXJlY3Rvcnkg
ZW50cmllcywgcmVkdWNlcyBDUFUNCnVzYWdlLCBhbmQgaW1wcm92ZXMgdGhlIHBlcmZvcm1hbmNl
IG9mIGNyZWF0aW5nIGZpbGVzIGFuZA0KZGlyZWN0b3JpZXMoZXNwZWNpYWxseSBvbiBsb3ctcGVy
Zm9ybWFuY2UgQ1BVcykuDQoNClRlc3QgY3JlYXRlIDUwMDAgZmlsZXMgaW4gYSBjbGFzcyA0IFNE
IGNhcmQgb24gaW14NnEtc2FicmVsaXRlDQp3aXRoOg0KDQpmb3IgKChpPTA7aTw1O2krKykpOyBk
bw0KICAgc3luYw0KICAgdGltZSAoZm9yICgoaj0xO2o8PTEwMDA7aisrKSk7IGRvIHRvdWNoIGZp
bGUkKChpKjEwMDAraikpOyBkb25lKQ0KZG9uZQ0KDQpUaGUgbW9yZSBmaWxlcywgdGhlIG1vcmUg
cGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzLg0KDQogICAgICAgICAgICBCZWZvcmUgICBBZnRlciAg
ICBJbXByb3ZlbWVudA0KICAgMX4xMDAwICAgMjUuMzYwcyAgMjIuMTY4cyAgMTQuNDAlDQoxMDAx
fjIwMDAgICAzOC4yNDJzICAyOC43MnNzICAzMy4xNSUNCjIwMDF+MzAwMCAgIDQ5LjEzNHMgIDM1
LjAzN3MgIDQwLjIzJQ0KMzAwMX40MDAwICAgNjIuMDQycyAgNDEuNjI0cyAgNDkuMDUlDQo0MDAx
fjUwMDAgICA3My42MjlzICA0Ni43NzJzICA1Ny40MiUNCg0KU2lnbmVkLW9mZi1ieTogWXVlemhh
bmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHku
V3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBz
b255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2Rpci5jICAgfCAyNiArKysrKysrKysrKysrKysrKysr
KysrLS0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5k
ZXggOWY5Yjg0MzViYWNhLi41NDk3YTYxMDgwOGQgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIu
Yw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBAIC05MDUsMTcgKzkwNSwyNCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgZXhmYXRfcmVzZXRfZW1wdHlfaGludChzdHJ1Y3QgZXhmYXRfaGludF9mZW1wICpo
aW50X2ZlbXApDQogDQogc3RhdGljIGlubGluZSB2b2lkIGV4ZmF0X3NldF9lbXB0eV9oaW50KHN0
cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCXN0cnVjdCBleGZhdF9oaW50X2ZlbXAgKmNh
bmRpX2VtcHR5LCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKmNsdSwNCi0JCWludCBkZW50cnksIGludCBu
dW1fZW50cmllcykNCisJCWludCBkZW50cnksIGludCBudW1fZW50cmllcywgaW50IGVudHJ5X3R5
cGUpDQogew0KIAlpZiAoZWktPmhpbnRfZmVtcC5laWR4ID09IEVYRkFUX0hJTlRfTk9ORSB8fA0K
IAkgICAgZWktPmhpbnRfZmVtcC5laWR4ID4gZGVudHJ5KSB7DQorCQlpbnQgdG90YWxfZW50cmll
cyA9IEVYRkFUX0JfVE9fREVOKGlfc2l6ZV9yZWFkKCZlaS0+dmZzX2lub2RlKSk7DQorDQogCQlp
ZiAoY2FuZGlfZW1wdHktPmNvdW50ID09IDApIHsNCiAJCQljYW5kaV9lbXB0eS0+Y3VyID0gKmNs
dTsNCiAJCQljYW5kaV9lbXB0eS0+ZWlkeCA9IGRlbnRyeTsNCiAJCX0NCiANCi0JCWNhbmRpX2Vt
cHR5LT5jb3VudCsrOw0KLQkJaWYgKGNhbmRpX2VtcHR5LT5jb3VudCA9PSBudW1fZW50cmllcykN
CisJCWlmIChlbnRyeV90eXBlID09IFRZUEVfVU5VU0VEKQ0KKwkJCWNhbmRpX2VtcHR5LT5jb3Vu
dCArPSB0b3RhbF9lbnRyaWVzIC0gZGVudHJ5Ow0KKwkJZWxzZQ0KKwkJCWNhbmRpX2VtcHR5LT5j
b3VudCsrOw0KKw0KKwkJaWYgKGNhbmRpX2VtcHR5LT5jb3VudCA9PSBudW1fZW50cmllcyB8fA0K
KwkJICAgIGNhbmRpX2VtcHR5LT5jb3VudCArIGNhbmRpX2VtcHR5LT5laWR4ID09IHRvdGFsX2Vu
dHJpZXMpDQogCQkJZWktPmhpbnRfZmVtcCA9ICpjYW5kaV9lbXB0eTsNCiAJfQ0KIH0NCkBAIC05
ODksNyArOTk2LDggQEAgaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCQkJc3RlcCA9IERJUkVOVF9T
VEVQX0ZJTEU7DQogDQogCQkJCWV4ZmF0X3NldF9lbXB0eV9oaW50KGVpLCAmY2FuZGlfZW1wdHks
ICZjbHUsDQotCQkJCQkJZGVudHJ5LCBudW1fZW50cmllcyk7DQorCQkJCQkJZGVudHJ5LCBudW1f
ZW50cmllcywNCisJCQkJCQllbnRyeV90eXBlKTsNCiANCiAJCQkJYnJlbHNlKGJoKTsNCiAJCQkJ
aWYgKGVudHJ5X3R5cGUgPT0gVFlQRV9VTlVTRUQpDQpAQCAtMTEwMCw2ICsxMTA4LDE2IEBAIGlu
dCBleGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhm
YXRfaW5vZGVfaW5mbyAqZWksDQogCQlnb3RvIHJld2luZDsNCiAJfQ0KIA0KKwkvKg0KKwkgKiBz
ZXQgdGhlIEVYRkFUX0VPRl9DTFVTVEVSIGZsYWcgdG8gYXZvaWQgc2VhcmNoDQorCSAqIGZyb20g
dGhlIGJlZ2lubmluZyBhZ2FpbiB3aGVuIGFsbG9jYXRlZCBhIG5ldyBjbHVzdGVyDQorCSAqLw0K
KwlpZiAoZWktPmhpbnRfZmVtcC5laWR4ID09IEVYRkFUX0hJTlRfTk9ORSkgew0KKwkJZWktPmhp
bnRfZmVtcC5jdXIuZGlyID0gRVhGQVRfRU9GX0NMVVNURVI7DQorCQllaS0+aGludF9mZW1wLmVp
ZHggPSBwX2Rpci0+c2l6ZSAqIGRlbnRyaWVzX3Blcl9jbHU7DQorCQllaS0+aGludF9mZW1wLmNv
dW50ID0gMDsNCisJfQ0KKw0KIAkvKiBpbml0aWFsaXplZCBoaW50X3N0YXQgKi8NCiAJaGludF9z
dGF0LT5jbHUgPSBwX2Rpci0+ZGlyOw0KIAloaW50X3N0YXQtPmVpZHggPSAwOw0KZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCBiNjE3YmViYzNk
MGYuLmFkZDQ4OTM3MTFkMyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2Zz
L2V4ZmF0L25hbWVpLmMNCkBAIC0yMjQsMTEgKzIyNCwxOCBAQCBzdGF0aWMgaW50IGV4ZmF0X3Nl
YXJjaF9lbXB0eV9zbG90KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQogDQogCWlmIChoaW50X2Zl
bXAtPmVpZHggIT0gRVhGQVRfSElOVF9OT05FKSB7DQogCQlkZW50cnkgPSBoaW50X2ZlbXAtPmVp
ZHg7DQotCQlpZiAobnVtX2VudHJpZXMgPD0gaGludF9mZW1wLT5jb3VudCkgew0KLQkJCWhpbnRf
ZmVtcC0+ZWlkeCA9IEVYRkFUX0hJTlRfTk9ORTsNCi0JCQlyZXR1cm4gZGVudHJ5Ow0KLQkJfQ0K
IA0KKwkJLyoNCisJCSAqIElmIGhpbnRfZmVtcC0+Y291bnQgaXMgZW5vdWdoLCBpdCBpcyBuZWVk
ZWQgdG8gY2hlY2sgaWYNCisJCSAqIHRoZXJlIGFyZSBhY3R1YWwgZW1wdHkgZW50cmllcy4NCisJ
CSAqIE90aGVyd2lzZSwgYW5kIGlmICJkZW50cnkgKyBoaW50X2ZhbXAtPmNvdW50IiBpcyBhbHNv
IGVxdWFsDQorCQkgKiB0byAicF9kaXItPnNpemUgKiBkZW50cmllc19wZXJfY2x1IiwgaXQgbWVh
bnMgRU5PU1BDLg0KKwkJICovDQorCQlpZiAoZGVudHJ5ICsgaGludF9mZW1wLT5jb3VudCA9PSBw
X2Rpci0+c2l6ZSAqIGRlbnRyaWVzX3Blcl9jbHUNCisJCSAgICAmJiBudW1fZW50cmllcyA+IGhp
bnRfZmVtcC0+Y291bnQpDQorCQkJcmV0dXJuIC1FTk9TUEM7DQorDQorCQloaW50X2ZlbXAtPmVp
ZHggPSBFWEZBVF9ISU5UX05PTkU7DQogCQlleGZhdF9jaGFpbl9kdXAoJmNsdSwgJmhpbnRfZmVt
cC0+Y3VyKTsNCiAJfSBlbHNlIHsNCiAJCWV4ZmF0X2NoYWluX2R1cCgmY2x1LCBwX2Rpcik7DQpA
QCAtMjkzLDYgKzMwMCwxMiBAQCBzdGF0aWMgaW50IGV4ZmF0X3NlYXJjaF9lbXB0eV9zbG90KHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsDQogCQl9DQogCX0NCiANCisJaGludF9mZW1wLT5laWR4ID0g
cF9kaXItPnNpemUgKiBkZW50cmllc19wZXJfY2x1IC0gbnVtX2VtcHR5Ow0KKwloaW50X2ZlbXAt
PmNvdW50ID0gbnVtX2VtcHR5Ow0KKwlpZiAobnVtX2VtcHR5ID09IDApDQorCQlleGZhdF9jaGFp
bl9zZXQoJmhpbnRfZmVtcC0+Y3VyLCBFWEZBVF9FT0ZfQ0xVU1RFUiwgMCwNCisJCQkJY2x1LmZs
YWdzKTsNCisNCiAJcmV0dXJuIC1FTk9TUEM7DQogfQ0KIA0KQEAgLTM2OSwxNSArMzgyLDExIEBA
IHN0YXRpYyBpbnQgZXhmYXRfZmluZF9lbXB0eV9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLA0K
IAkJCWlmIChleGZhdF9lbnRfc2V0KHNiLCBsYXN0X2NsdSwgY2x1LmRpcikpDQogCQkJCXJldHVy
biAtRUlPOw0KIA0KLQkJaWYgKGhpbnRfZmVtcC5laWR4ID09IEVYRkFUX0hJTlRfTk9ORSkgew0K
LQkJCS8qIHRoZSBzcGVjaWFsIGNhc2UgdGhhdCBuZXcgZGVudHJ5DQotCQkJICogc2hvdWxkIGJl
IGFsbG9jYXRlZCBmcm9tIHRoZSBzdGFydCBvZiBuZXcgY2x1c3Rlcg0KLQkJCSAqLw0KLQkJCWhp
bnRfZmVtcC5laWR4ID0gRVhGQVRfQl9UT19ERU5fSURYKHBfZGlyLT5zaXplLCBzYmkpOw0KLQkJ
CWhpbnRfZmVtcC5jb3VudCA9IHNiaS0+ZGVudHJpZXNfcGVyX2NsdTsNCi0NCisJCWlmIChoaW50
X2ZlbXAuY3VyLmRpciA9PSBFWEZBVF9FT0ZfQ0xVU1RFUikNCiAJCQlleGZhdF9jaGFpbl9zZXQo
JmhpbnRfZmVtcC5jdXIsIGNsdS5kaXIsIDAsIGNsdS5mbGFncyk7DQotCQl9DQorDQorCQloaW50
X2ZlbXAuY291bnQgKz0gc2JpLT5kZW50cmllc19wZXJfY2x1Ow0KKw0KIAkJaGludF9mZW1wLmN1
ci5zaXplKys7DQogCQlwX2Rpci0+c2l6ZSsrOw0KIAkJc2l6ZSA9IEVYRkFUX0NMVV9UT19CKHBf
ZGlyLT5zaXplLCBzYmkpOw0KLS0gDQoyLjI1LjENCg==
