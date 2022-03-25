Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559A64E702D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357917AbiCYJoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354229AbiCYJoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:44:02 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7029BCFBA8;
        Fri, 25 Mar 2022 02:42:28 -0700 (PDT)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P4kuch032355;
        Fri, 25 Mar 2022 09:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=8sfFDmHUsyZlhTXPAC6ZwO7s91/YqBeAd72VltcCBZ4=;
 b=MYbJ2BKZT94a1UOkfRLxw2Ik7J9vcjh5S8NlewNC9b+yq/XqU95l2AFQy8DZTT71cgJN
 gD7ZDLagprQsApJMyzaP50S3W6cRZ592zlg0+9YWBkhfTvgxMMtl1JGnmC1NABI8tHn3
 gHLDkDXqPrl7wqo4QQNCEeI/2uPcg/Sr16CRMGkAEA38vB/mAylAQz92+o03SEOGFZq7
 exGA15hIsyrCZwa4aEnLK9AD9El+oJ685XfxuhqaIAeUNRK5LLYQP/lZdpAkMlyuFzgC
 3uCLtXkVuQDj/tU20rsaHXxkCboq1wQOC9eAQy328KjA1y1rmc0sBojsPl+uelLAaMZJ eg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2048.outbound.protection.outlook.com [104.47.26.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f0yw3rk6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 09:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7p2wliQAvr24gxR436vqpUHssjFA/vyKxuQO4+Q8z64RReU9fvJsVMMyK3rp59yCICs6zptsmF9G2fdOIifVF6Ddv6vZcaVU02CKBzNGsTQXC5V7alr4EBGzLpAtJue1BWqfK/SJoCZIgSZSzMNbbp4T0P6vthGco4lMNqZc5vpLUJA8KYQg0xa+rILVnwHnKmPLjCbRQ+aov57lP6QDasRJCE+y6rmKnOPpSf2Kh+f7Ftnhxmxq9dl3aSKC3MQLv2rULm+WQL911EDUmFR21YuVA4WwZFWgpHEDypXx51hXfoOcnYcQZjyBdsSuoiaNkYngZL9/1LPpV7kavj82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sfFDmHUsyZlhTXPAC6ZwO7s91/YqBeAd72VltcCBZ4=;
 b=mXoVqYcHjRBC2KqIt2+LvLPX/RzRiZfZ96i5tEHSebLO1J9gIiwhYL4WLxzO4X4sRmgPLq8loZhptnawK9E3vHcxV8Ou0/8OUuqmvenNBNEKeIalYbhlapkBSIwXRTjkWpPl3LqFBXFTdu9Wp/Rj8q1oAIKkHReSnrHi+bDjYOp0/71Hrbja4vJt/EkaoXhct0qs9oRNwzjTJOt5NE7EhkKB1yoZnCcj3OISpvsnIvbBC0gbTT24kw8NqXUgq38HQ6pdns6kNG7iozudCP5opzaeQ5pptKDE5wOkBNJMAtLF2k+laOEW94USv6II9LMtkaJ9zMApno3chugmXYjGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by HK0PR04MB2386.apcprd04.prod.outlook.com (2603:1096:203:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 09:42:05 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 09:42:05 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: [PATCH 0/2] fix referencing wrong parent dir info after renaming
Thread-Topic: [PATCH 0/2] fix referencing wrong parent dir info after renaming
Thread-Index: AdhAKfN5p6xp4Ut3ToSE7wNp6pjfVQ==
Date:   Fri, 25 Mar 2022 09:42:05 +0000
Message-ID: <HK2PR04MB3891851AB34913F3CC2561F2811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7778250d-d3b0-49bf-3a7e-08da0e43b8df
x-ms-traffictypediagnostic: HK0PR04MB2386:EE_
x-microsoft-antispam-prvs: <HK0PR04MB23864E5636DE1ECA18BF42DB811A9@HK0PR04MB2386.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AnUgfqEl50RG1SrW4M1tKZmshZrWCmIdycXJAnUg23VAXLF6fV6jP2sxWW5dMtdLvijATcEqrQqGP8MpqaOlp09mzNdJsaxGi5lgBLi8BEGdzAM5vHMxtmnULpcjDB19JMn5MeS/Yy6kb3AHLjpKl3IAaa6xZ2xFyazRV2j5beh1LJHOp7NdgntA+JKkqsDSdhcgkDj6nhPuGaN4+JGvuhRi7BTinYs1wCOnmeMThyDq7MZW4YQW7jTfd9eNEcvShZ+qQ1g7YPs/PtytynTB1VLhQ2PqvytZcx7DPx0hzEBFMhLBvlRfxEeWvA5/RNI8FucqHsvVsJVVcJt1uMVY5IJpZ+PrmkimdMTneIWxtaZrd5jU/VmvQKOyYeTUA9h0din+I88WKBli0yRpSeIvw1/zA+LMofK6Hn9EFiC78aYT4RjVghdsdrBagXa35QXeNPyyGnft35WJwmXkcUYVppwaNhq2XWJBRpZ98qQ+Ul2bQNrrWdCk5oSrJO7ydb/3eL3oTMyde+bgCHHZ0vxpHJTR6Nd8LT30GWJ4vZBJmLhqbfdL9vLQXAbXHLoPg0gpFBVI6ice6mC4z/ft3W1GJ1JpndeKolemwUmyR8iyN61bL8pEq57qqGxJxP8xrpA3RWJXEqWyGN0iax1cyRNFIRl8MeKfaElEk4RXV0vNkD7q/Q+s3+nfc+1zq83mDlANgDxurvEAnyEAN1BB4C27g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(508600001)(7696005)(9686003)(64756008)(66946007)(2906002)(38070700005)(8676002)(6506007)(55016003)(71200400001)(8936002)(26005)(52536014)(76116006)(186003)(83380400001)(66476007)(110136005)(66556008)(33656002)(66446008)(5660300002)(54906003)(38100700002)(4744005)(122000001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXBKWFZIamlxMzlpNUFqbGRjMGRza04zam1zSmI3RnNKZGxxcm9UcVY2V2Rh?=
 =?utf-8?B?ZWNCU1NLbHU5Rkt6MnhPMXJYaUdQOHcyYmQyUFRYME9xdExRZG9zeU5zUUl1?=
 =?utf-8?B?M1hDVTZNZmt6clIyalRrbWd4Mk8vY0RJVndHUlVldHY1Um1oMHp2ZERhcm5u?=
 =?utf-8?B?SWU0ZURSMW1Vb2MrVnZKd2g1djhhTG14ZjgxMmhwZkNNTlV3ZlJRTWZGM0d1?=
 =?utf-8?B?OHFjT01tdjJxZFVNMHlSTGhrb1FNTjdNa2g2RG12ZTR3MVhjektseC9ZL2Rw?=
 =?utf-8?B?c0YrM29uOTNSa2owTlo3MGdkTE1seE1JTURxeVZzOGRuZGhHc2ZsOEQ1SWVx?=
 =?utf-8?B?aTJYZ24xZ0JwdDlka3VaUmZTaEdkamxHSVV4Mnd2c0ZROG16S0l6NTcwR3F5?=
 =?utf-8?B?MXErei9PYnViem11ZGEyTGo5OS9qUGN6QnJKTzRlL3A0WVFCN21aY0FrSWIy?=
 =?utf-8?B?VGlYSHM4b09XTXQ5bm1mb1BoMm5SVFFsazdscWRpWVhYUEVGL1JvaTF5WGhn?=
 =?utf-8?B?cjB5RWtVMitzNnpEaTNjdXJGQnh4dVdBZUFRcFdjMk5lVkl5SSswcVp3MGpz?=
 =?utf-8?B?RnBGaE5YRFl6K0poT2RncTdaSU1tTWFISll2alZSWVFaeStwZ1NteEJNakVS?=
 =?utf-8?B?cER1UEFxQVpUOFZYR3NuYUV6Rnl3UTJhYkxISnRZWmNPWTM3dzlMa01BNHM3?=
 =?utf-8?B?MExjTXRYcko2ZkszMzlqbVVQb1pkdFlMdFRYR2xGZFZ2OURDK05ldENOd0ky?=
 =?utf-8?B?NUZwNjhQWDN3RHBqOTNZMDV0M3VYOHliaGt5Q0JveC9oYXdlbXJVZlI3VURH?=
 =?utf-8?B?QUlrV00rdVpmQ3ZhV3dqZ0VVZnV5S1J2VDVOME5JdVlGSko1ejZSMjNIOGdY?=
 =?utf-8?B?cFpURHRYOUQ3cmx6bUJ6MGpGNmVTcWU1MnZNaUFWN0lacmpjUDBoWVlOclYz?=
 =?utf-8?B?dWpxV2RmdURPM2k4WXZqUFhXUTRDcE9jczJyS2lsYTF5TmN6L2x3dm5EYXM3?=
 =?utf-8?B?dGgvY2l0TzNaY0RmcDhPQWM5bXBodDJScHg4a3V0ZjltTXI3RFlYVHB4anl6?=
 =?utf-8?B?YTBWRGVVdnE0VW14OWoybkFxbnZJVmVpTUZabTRENWh2UCsxZ1lpM2tmNjZO?=
 =?utf-8?B?THhLV1p2WUlkUUJoS2tJUWZkTFNWWG1QOG9ra0FQUkk5Sy8xaFF3SXZMTG5a?=
 =?utf-8?B?YTF0aktaZWo1bkxEc3B0WC9pUHZ6eHUzRmVVMUREeWNmTGxJeHc0S0VBSVdV?=
 =?utf-8?B?Z1FtSmkrL2ZzZ0xDNURDcVBtaXVWUWIxdWZTaVFxWTJRMUJyMDhoem8xZUF0?=
 =?utf-8?B?akNvUFd5SjBXNjA1OXNoVzB5eWZnOVF1SForZStibERZTVpzUVEwZ2JMQlJB?=
 =?utf-8?B?WmZaZGFtbFcyN2wrUHB4Y3JGUzdGNzZvWmdjWHh5YVBRdWpyQ1lTVGZKOC9v?=
 =?utf-8?B?TGs1dzZua0ZmcGhyNEFtMnU0ME5laldhWjlFb3k1Y1FpcWduMFRPZ0JuRFU0?=
 =?utf-8?B?Vmt4VHBGdXRidGQ0UkpIUXB6anRTcXBOc1pKdWRtN1VCMWNKaHNoVGlwUnF2?=
 =?utf-8?B?Mnl0WllpL1FhWHNSbG4zK2ZpNWxrZWVESmFFSG5wT2xUUnVkY1RkcmNOdUhI?=
 =?utf-8?B?WDFMRnFFNjJXT0NjSTJGWEdDYXF6Y3pZMVI5OVAwWHIrN3p6djNLQi9la2d0?=
 =?utf-8?B?UGZMZEtkOC9QOTZoUTVCRFJoWlNmZFVvRUxFV2tyc2dNMmFJNHFaRGJGUTJ1?=
 =?utf-8?B?L2VPUHUxSHhBbVo4ODFLbHFEQzRkM1U5Q2lQUzRZNTBtd3d1WURYWmRDdThK?=
 =?utf-8?B?d2xwa3pVd3pFamtET1RGUE9xS3I2ZUFmSlQ0cEVPK0pvT2F2NEY4ZDRQWSs1?=
 =?utf-8?B?cjB6TlJ2bGpxSS9DZWNwelB1Yzh5bkdSNmdkTnd1RW1ydU00VUtDbEtuOUM0?=
 =?utf-8?Q?deeiiPfyi58kEcCELnxYGsE0DIjqv5M6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7778250d-d3b0-49bf-3a7e-08da0e43b8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 09:42:05.2487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlVDDJ2rPHA2Q0h82I97R5tw9hC27vxQWaXwGKnA4/HDU1LzIEyYGfl7dCY+aPkvQVxWuQgeiTGtARiUGhDoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2386
X-Proofpoint-GUID: h--Vrhli_mvzsTAZ-EyUHw6Q91EApxh9
X-Proofpoint-ORIG-GUID: h--Vrhli_mvzsTAZ-EyUHw6Q91EApxh9
X-Sony-Outbound-GUID: h--Vrhli_mvzsTAZ-EyUHw6Q91EApxh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=787 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250054
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZXhmYXRfdXBkYXRlX3BhcmVudF9pbmZvKCkgaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgYnVnLCBi
dXQgaXQgb25seQ0KZml4ZXMgdGhlIHJlbmFtZSBzeXN0ZW0gY2FsbCwgbm90IGJ5IGZpeGluZyB0
aGUgcm9vdCBjYXVzZSwgdGhlIGJ1Zw0Kc3RpbGwgY2F1c2VzIG90aGVyIHN5c3RlbSBjYWxscyB0
byBmYWlsLg0KDQpJbiB0aGlzIHBhdGNoIHNlcmllcywgdGhlIGZpcnN0IHBhdGNoIGZpeGVzIHRo
ZSBidWcgYnkgZml4aW5nIHRoZSByb290DQpjYXVzZS4gQWZ0ZXIgaXQsIGV4ZmF0X3VwZGF0ZV9w
YXJlbnRfaW5mbygpIGlzIG5vIGxvbmdlciBuZWVkZWQuIFNvIHRoZQ0Kc2Vjb25kIHBhdGNoIHJl
bW92ZXMgZXhmYXRfdXBkYXRlX3BhcmVudF9pbmZvKCkuDQoNCll1ZXpoYW5nIE1vICgyKToNCiAg
ZXhmYXQ6IGZpeCByZWZlcmVuY2luZyB3cm9uZyBwYXJlbnQgZGlyZWN0b3J5IGluZm9ybWF0aW9u
IGFmdGVyDQogICAgcmVuYW1pbmcNCiAgZXhmYXQ6IHJlbW92ZSBleGZhdF91cGRhdGVfcGFyZW50
X2luZm8oKQ0KDQogZnMvZXhmYXQvbmFtZWkuYyB8IDI3ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMjYgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi4yNS4xDQoNCg==
