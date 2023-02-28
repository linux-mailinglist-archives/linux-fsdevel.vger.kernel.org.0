Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46696A53CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 08:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjB1Hn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 02:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1HnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:43:24 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A311205C
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 23:43:23 -0800 (PST)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RNQfOt019754;
        Tue, 28 Feb 2023 06:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=7SASak8AQibfHLq3frEe3qrgYuIPfwZQv17OFq3iDYc=;
 b=iseVjyhbmyWrQTx7OQfDpeAEtEGHPYjAzcTq1U/pZSb7yFUhwp/pX6RjE3eGYxRN1bmE
 NOVkUuY1C4pMrlhB4Xd0IgIC3EJwM00L4FqycgJ7cO6zE/huw7+OSghdKkBxULt3dYQK
 lCapwPtwQ9a7LoKLWuYdz1g1QRM0CuJL2E29SE/wjGBgENV+xNOI+vhGXgE6giSkpcJ5
 Mm7b1tYgpKLBXQD36OXF88dz1U4VZL9zPGzm0M5oYa+AWajany4wCG+4WsO8z0GUay9T
 F522tLMjCK666P+lTuQNJpTTJGl0xy58r44YMGant58bvEVGWKvA8aWuJJUuGQ+IOdmh cA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2106.outbound.protection.outlook.com [104.47.26.106])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nyb2p2bh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 06:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy9SgvKjTpd5ZQhGsmQ6d4MNXeUoF3C41PWckRqLtOwGwyAcLsAgXaqhw4H2Db/ihMsk9h4pyWNDHFrKUg2ELiD6VZ44yCYRMoqnxn6S9HUT9iI5aeq8V9kt0M1WlsS/K4wxzPSzhdddjtAyoDphQi+h3l70iCxFxxFjqEYj+P0rUADRNiAMbPYlfuEi+T6JAIcKhbzH788VS4q4BJZBE+irrZm66V27k04Upe34us5FN11qkedckA0Nv1HF18H+B9ck69oP2Uqvi7nhulAn+lLYYuFArnIlDW2yFWzgvYYliva6W/Rg2OURn2Sd37rUs1YCHUHre4nLVGYJl8VvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SASak8AQibfHLq3frEe3qrgYuIPfwZQv17OFq3iDYc=;
 b=btpIgl9xC3nUwN1c96eBWcR/r3tKJ18pdLdbYVe+CuPwZ6Z+6qxRykU9M792x/O1dXm+Azvz9i2d8M0wqVD06jJmvq0zcyQrhYbzGBdZ1rwqF4dmdi5/mF/1vSc3AsJCooON17JXOOjLJqxdzjmC4Y0wiPc7G1qfTKsylKDMOBohDNHfpfFFqXSMOBx4wKuoCq/ph1lk21c70Uet2Dx7/75e7m4IkgnDiRh+455oXrYVxTH2Cx6JQoXfVVdfoOogyRD6DYXBsbbELBNMli9phnLmIROnGqKjWBjmqdYe0OwIWJmHzxSqhkWe6oAKhnlRl7TXmMCBlcz9ACCEStgA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4227.apcprd04.prod.outlook.com (2603:1096:820:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 06:07:26 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 06:07:26 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 2/3] exfat: don't print error log in normal case
Thread-Topic: [PATCH v2 2/3] exfat: don't print error log in normal case
Thread-Index: AdlLOpvFm4O2ert5RiWDsj4rGy5rJg==
Date:   Tue, 28 Feb 2023 06:07:26 +0000
Message-ID: <PUZPR04MB6316B9A83221D5AB769AB8CA81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4227:EE_
x-ms-office365-filtering-correlation-id: 9444fb74-333c-4feb-e828-08db195210d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4aD6OmdsWgTINjP5mcpxSZmC337hL3wnQkZvRPWx2COZxfozKUfQoR8K6MHt0nW9xsfKRqpoxwK/J/geHVaN+IYy5YJduRyxmqrvPXk8MYm1T/IXvPCY4zEynPEnW0NZ29G2GpciwH06jetHMk1mquiSlafBfa22mCULoxLQu0p+QFXT5eVHJX8YXXWcLxAcOYhm5A8Ja3ylmc0Y/MfLWG5LykA5NLR6cuZ+IrHgRE5TWeOS+QmCNXXkmWeFm0FzqOlZlxFmrm/F0ZUI2EeBUvp4Nvhr7Gjvl9JczdWBIfcq4U544oMDaOsHA2Pl8MHGT6y+L2Ba1DkhPafAeskTbXmnyPIzYAh529H8ttCtxLn8nWQELYA3YEX5rhABZy0gmbuDcx8TPiIyKmu5i58ytGg/Z8IPG5mhQGZaQt23xMZUztsEaP2mUIl7A+1BOYU+fbjw6lhPVSy7q+A1glWmEt53JajiF9SaM8US+3amW94VNllmIWj02qCOyna99bgdfb9zhwS3J5Gmd91FsE9+BvDe2E1TTI1WCfJls21vsypUTC5Z0xI4r3YWFImqIB+mkGtYjhQ/tA/UR/sDrb7Lpi6rEGSxYPZt6YTL2Z6y9bQ4gLsj3/P9l/6mfMQDokG1OmR9hg/TYP8p3R2zA3z0HHWrBRq111Mid7q+T2CFc1yjchn/ygTUtK3fZB00A+mdIed84NkqfvHa1skLGkHw7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(110136005)(83380400001)(33656002)(54906003)(316002)(478600001)(82960400001)(38070700005)(122000001)(7696005)(26005)(41300700001)(9686003)(186003)(71200400001)(6506007)(107886003)(5660300002)(38100700002)(76116006)(52536014)(86362001)(8936002)(2906002)(66946007)(8676002)(66476007)(66446008)(66556008)(4326008)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWZWS3U1QkdRazZxNjg4T0J1eWo5Szl5UWdxRVhrVjZNSW1ZcE1sOEJlTTZq?=
 =?utf-8?B?aFVveDQyalNmam5XZkNkbzgwWnkyNHE3ZmhPWjhvVERMZzE4eGx0b21ybUtx?=
 =?utf-8?B?TS90MnlkVDEyN1M5WkJ6aEEwdGpQR0tkQlRUWkhBWExiRTFtMEt0ZHBRbG54?=
 =?utf-8?B?ZUQxQUdBVW9FVHVlRG14Sk92ZGpoeVRBbWhPdVpKZW8xMytCSWs1Mll5WWI1?=
 =?utf-8?B?RlJMZE5HbEtILzJqUjVVY0gxNnBQT013dDBWNWRkcUFUVmFlelZUVTQ2azVR?=
 =?utf-8?B?akc0MHdJSDhyVnZnVS9FSUJBVG5BeTR1S0FFQWJ0RmtlVmFCSkU0ZmRaTnB6?=
 =?utf-8?B?SkwraHVFZFgrakRsQnVkVHFwUGc5U04rcnAvZUxUdTlrNk5sa1E5RFdKaU9T?=
 =?utf-8?B?TzRwbkRZYU13cDVueFBQbTVudWlQOXFOVnB1bGhEcEozcEdRaE5tM3BrMWdl?=
 =?utf-8?B?M05PQUNEZUtMS1FLRHhDUklLQzVtb3c1VkZVek5EeHl3UTFiUXBORFBKdGxi?=
 =?utf-8?B?L2pHcmF3UVZ0Z05hSm82UzJyYjQxUGliTEFETEVTVEk0T3VQbGZwc1ZjNU83?=
 =?utf-8?B?b01EQzR2VHpLeTdKN0VPTmFLQUNpKyt1Q2JQNTJ1RnRzQ01GVVRPNEIyTGtX?=
 =?utf-8?B?UlMrT3I3TzFaTjRsUlUrQ0VHaDVnODB5Y1RjSlRtQ1psZ2NVTFR2MFRmdzFB?=
 =?utf-8?B?VkJJRnlaSTZqeVJIRHVWc1NVbHREU2RmZ01CMFlzQ2NRNks0bk1OcFN5aytD?=
 =?utf-8?B?UDhNQkJubmJRZG9lcW9JTVJTaGxPTGhPYkx4MTJMOFBabHlETVZBcC9QUXg3?=
 =?utf-8?B?RXlwOS9DUEltOGl2ZE1KMzdUVjdoUGk5akNFbE1YZHF4cWIvTGRLcEVmQVh1?=
 =?utf-8?B?amh4M2l6UFU2ejVQeW5Ma0U0ak1WSFdUc1AwVGl1NHdHc1NFYXlTYURIcml3?=
 =?utf-8?B?R3luNjlVOGVPdUlwbTN0K3VjSEp0aGhKRU5xdUYxOTgrOEZ5ZjBhQlM2bWRJ?=
 =?utf-8?B?MHZobjV1UmRvYkJJYWhKd2lwckMvQ3VVRmJBSTQ4ZHdzeEF4NlRiTDhCbWl1?=
 =?utf-8?B?TEtOM0k4ZGhiWXVzWk1CelJjKzkxVU9IMDdPMDJHcHhQclBUZmg3TmtHME9M?=
 =?utf-8?B?TWNTN0dCYTBKbm1vcE1xYXhkOXNPNjcxK0FYeHdhM09jYmtoR3BqZVJqQWRt?=
 =?utf-8?B?cXphWTdmUHBkUnBHU21YYXUxb3kxdW9wUllQbTBPYURCV2R3VjM0ZTNJbVFM?=
 =?utf-8?B?Z2JoYjkrLzJuR09DK3JyeElCTkJWeWNveVNpZUgzS2laN3VOaURGdjhRZGxG?=
 =?utf-8?B?OGhTSEJBMzh5TENnblU1M0FDYTN4N1VjdVBQZmNjNGtRY1Mzc2g4K20yNWVx?=
 =?utf-8?B?VnJnU3VNOGRPWitIU2E3V0NUSEt5MHRKUWJrZlE0Y1BVbjh6WlE4ODRzOXZm?=
 =?utf-8?B?djc0ZWFFd20xZ3lMd2UxekpjTW1QL2NnUjhpcHEybCt0Q1ZXMDRTb2hVRnZU?=
 =?utf-8?B?YjRoMkZFM05TMCtYOXVHR0pCZ2NTUlgwc3ljd3BDNm5zTTN6N01ZSEFBNWRn?=
 =?utf-8?B?YW1iUldLZVFkbVJNMEdUYWk2dDJHWUJjV0JpblMxZmNRc0NGRmtzdVB0MDJQ?=
 =?utf-8?B?RmJndDJOMlNpZkpza25mMk91TnpVREJJdXVwV0wvd2hNQXdiMWExcXNqZUQ4?=
 =?utf-8?B?cFkyaTFCejZySXQ2VGYvZHlIK1FLOEJrakVyV3N5S1JxWWF6bmR2NGdxdGVj?=
 =?utf-8?B?Y0Vua0RRUDlEQlhWOGxVTWhrTTVPamJ2UkxJdmlpYWpJbW40Sm9LdFJOMWhj?=
 =?utf-8?B?MktRMnp1S0RmMEdZNTJYSk1zODJmZUR4Y1NpWC9aTEdKOW5xb3cyRWhRMXNY?=
 =?utf-8?B?YXJCQ3ppbnR1WDNReWh2bHZad0NzT28xRFV1ektybS9scDY2ZlJLelpTQ1Ar?=
 =?utf-8?B?ckQyRzMveVhlb0pCMFRaeTArV0VhM2lPMDVPR2lIM0gyQmFzYU01aGF1TFNo?=
 =?utf-8?B?QWdCOGhHdnFxVXdnQlNtaTlRREczalV2Q09ZeGNSb08xUTBIZmE5ZCtHY2Rs?=
 =?utf-8?B?eGlYQVV5WkxWNzNLNzB2Y2NkejRmeGR1dFpsdmwzdTY5SFFCT3hpSmFUZVdu?=
 =?utf-8?Q?zYqySBBX+WO6UdjYM+seO4bFI?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: izCwWFJP7TD1cYdStnsKn1+UECVXak3nBg4WXNP0lR+N3McHQMCl0YVjrHtL59ux5K69rkeL9pX5CkgWZj76TrIF9CnG8f4TJP7QIg/Fuazfd3F8B1tIyuJ6H7PmeA/ItamntJ0tnz4tdOVn0cY/Q/lMRZGioIqzwsEYWnOJrpSyW8ZNN5Vb8sUrwwQWmgmY6l5aGkiLds6CjJ+1qhHtq2U1W6LaEMnqbhDZyk9xl1X1//pdK5GiZCL76QKO655f34+uXwXse/VvHIdGAJ145a667qWrs9c8Bdai0+QEAIIalVNmQHfmnTNF6ErGiXzEtsFphvHi5ZsBMWO49ylksN8LQqj2X/poKvgd7P2pwrufl2mO6AhjVHPYWpUga23Ru6Yfr0qTC0xknR37q5tMZhUADR+XQ3qzN2QJfmUP2t45duEh8uWWlG6C/zweopMnJfV9TFGfjbHM57riRKt1t1BnZqlX2pRnkF/jCqBYW8nEcmd7nRCIM/5VGFPW/0zex3Bomq8d4Ypm4N0s/OeuBb407xF5746+mdgstA/+c4sHwoXkrViZBGJ82t74KdZ+seHVVi0yWtP2mwa3m2gGxtEmkFiyAnHdj1j73BiwEjFm2EW9U2E6VebDu5vb3jBFzrtaHuyRzZgknSyFAJRoCWXBO+BhM93SMpZ6VJxBhR3c+7wtxdCM2YPQ7RlZZCERXi/8una3OZklfuQr17vxEUYmHF4dj7QVO9nc0zFGYkTbpc/P1iy6sNFjAI2t2t3oOWbkqxRurG7kKA8skWYnLRo9NazVoVEb8Lp3WYjn6ZsslhIOd2qhjeyoC1H4yqeM6NLvsGtAGVfw42LeVH6Uqg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9444fb74-333c-4feb-e828-08db195210d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:07:26.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOWkw7R/sDxzDIb/BvrOumHeYyCzgwEj4ddRkzEp+Xl31RlrKeStt67EuQLOERN4rxG8yUx7yXRAT8jRt3a2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4227
X-Proofpoint-ORIG-GUID: 12jKhBPpoKCudEdDioMSgBFVQG6c446k
X-Proofpoint-GUID: 12jKhBPpoKCudEdDioMSgBFVQG6c446k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 12jKhBPpoKCudEdDioMSgBFVQG6c446k
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

V2hlbiBhbGxvY2F0aW5nIGEgbmV3IGNsdXN0ZXIsIGV4RkFUIGZpcnN0IGFsbG9jYXRlcyBmcm9t
IHRoZQ0KbmV4dCBjbHVzdGVyIG9mIHRoZSBsYXN0IGNsdXN0ZXIgb2YgdGhlIGZpbGUuIElmIHRo
ZSBsYXN0IGNsdXN0ZXINCm9mIHRoZSBmaWxlIGlzIHRoZSBsYXN0IGNsdXN0ZXIgb2YgdGhlIHZv
bHVtZSwgYWxsb2NhdGUgZnJvbSB0aGUNCmZpcnN0IGNsdXN0ZXIuIFRoaXMgaXMgYSBub3JtYWwg
Y2FzZSwgYnV0IHRoZSBmb2xsb3dpbmcgZXJyb3IgbG9nDQp3aWxsIGJlIHByaW50ZWQuIEl0IG1h
a2VzIHVzZXJzIGNvbmZ1c2VkLCBzbyB0aGlzIGNvbW1pdCByZW1vdmVzDQp0aGUgZXJyb3IgbG9n
Lg0KDQpbMTk2MDkwNS4xODE1NDVdIGV4RkFULWZzIChzZGIxKTogaGludF9jbHVzdGVyIGlzIGlu
dmFsaWQgKDI2MjEzMCkNCg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1v
QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQotLS0N
CiBmcy9leGZhdC9mYXRlbnQuYyB8IDUgKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmF0ZW50LmMg
Yi9mcy9leGZhdC9mYXRlbnQuYw0KaW5kZXggNjVhOGM5ZmIwNzJjLi5jNzVjNWEyY2FkNDIgMTAw
NjQ0DQotLS0gYS9mcy9leGZhdC9mYXRlbnQuYw0KKysrIGIvZnMvZXhmYXQvZmF0ZW50LmMNCkBA
IC0zNDQsOCArMzQ0LDkgQEAgaW50IGV4ZmF0X2FsbG9jX2NsdXN0ZXIoc3RydWN0IGlub2RlICpp
bm9kZSwgdW5zaWduZWQgaW50IG51bV9hbGxvYywNCiANCiAJLyogY2hlY2sgY2x1c3RlciB2YWxp
ZGF0aW9uICovDQogCWlmICghaXNfdmFsaWRfY2x1c3RlcihzYmksIGhpbnRfY2x1KSkgew0KLQkJ
ZXhmYXRfZXJyKHNiLCAiaGludF9jbHVzdGVyIGlzIGludmFsaWQgKCV1KSIsDQotCQkJaGludF9j
bHUpOw0KKwkJaWYgKGhpbnRfY2x1ICE9IHNiaS0+bnVtX2NsdXN0ZXJzKQ0KKwkJCWV4ZmF0X2Vy
cihzYiwgImhpbnRfY2x1c3RlciBpcyBpbnZhbGlkICgldSksIHJld2luZCB0byB0aGUgZmlyc3Qg
Y2x1c3RlciIsDQorCQkJCQloaW50X2NsdSk7DQogCQloaW50X2NsdSA9IEVYRkFUX0ZJUlNUX0NM
VVNURVI7DQogCQlwX2NoYWluLT5mbGFncyA9IEFMTE9DX0ZBVF9DSEFJTjsNCiAJfQ0KLS0gDQoy
LjI1LjENCg0K
