Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA522613424
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 12:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJaLFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJaLFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:05:03 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E90CD5;
        Mon, 31 Oct 2022 04:05:01 -0700 (PDT)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29V9gkVn027486;
        Mon, 31 Oct 2022 11:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=N5zjrMout8Rmi6xubd8w6/AAjsYxJZvbNQFtHtmOtZw=;
 b=LK4darbQXPn7LNrZ1ppEg8lQgOUK+Ku+EgEt08OGJqgXInCA5CmqVbWoZRN3B9i/E1TU
 Gy+jwiHDulIv2iiwf3RFYwsRDmN3sGtUvep0qdQsPGuQ+yG9OoTSAVn5Ly7VaCnq08va
 nw27rYoUtAUTTa8E0LOozQ7qgkWLMuQEPMK2bgCIZpepj0q5lfllxo0bCONsfNfR4YgN
 2mC0LrF7lcX274EkVc5grzy7rDVtDFQ0DV68p/9ll/t0YIDdBUItYFku4emmj1cqNKCb
 UPgmui1Qh8IuxKDXSYyL4WkIvkbYOrSVk4O0xAG9p8O4QlucJGVXk0lW3s/vf3buSwvB yQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2042.outbound.protection.outlook.com [104.47.110.42])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kgu21hrrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 11:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX29OsFEVlsB59bxPcexQOFCIQt7UHNZEIjYxSNEHZM09mIEcOBmn5UK9d5g4tV+juxzmoWj7WdK+XUa0NfPqIuMiDGKNL2oqEt3kUPDzwI4CdCtWkwIpzS2+PDTc2UGDAN3/1A+cFi9u5Jee7+Odddla2sf7dQ+z/iOuE6JcToEUodHWG5tdxzLxNEksUemG9Hc4i+oGBb8equZNjytxTMQ/iXAIz+mqpy4wYJw3gJ1VezDqZVtFmgouGKBNTT2YDDsG7iMos6inj9kjeBDoAsD6f2H8zKkPcbu/Ghe5O/lP6va7ftLqpHr0R2kjIq/+Osis8QoIB74MOFyZ6f8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5zjrMout8Rmi6xubd8w6/AAjsYxJZvbNQFtHtmOtZw=;
 b=frf6Xbru2/QpRlFAMGOndIQlQtk2N+QQQrOcZ7dyzmIBSQzua/O1BqU/ibw5CRsJb4o7OMWVYJ3Uonws68zZKx1nRgC84QyWhJ/HOcdjrHHe6fe/vSZXK/MdcjFkn9Gu7VOQdi96vw9SOgv6SY5M1hOsUb4+W+aMDxKtULT4oMbvvLDUWOVdsBzUhr/ZuSX6FXAqCV77mRK8CR2Xz+g8ydtA27M38pa+a5Yna8DagcNPDiMuypUTFDN/cGbgjEEhgU6nTZc7kJD1c7Ly95iB+nGO9vrjAfcTjEoHqHVlh1Qr58stgIVWIuR9FxC+WqSj3yGEYPOc2t6juVyfWPiZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB6114.apcprd04.prod.outlook.com (2603:1096:4:1fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Mon, 31 Oct
 2022 11:04:34 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%9]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 11:04:34 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v1 1/2] exfat: simplify empty entry hint
Thread-Topic: [PATCH v1 1/2] exfat: simplify empty entry hint
Thread-Index: Adjjis93Aa849t2vQ7mggbPVF9+9JgJZ42xJAAakZ9A=
Date:   Mon, 31 Oct 2022 11:04:34 +0000
Message-ID: <PUZPR04MB631665D55F4F0B290D0D543581379@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <CGME20221019072850epcas1p459b27e0d44eb0cc36ec09e9a734dcf60@epcas1p4.samsung.com>
 <PUZPR04MB6316EBE97C82DFBEFE3CCDAF812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <000001d8ece8$0241bca0$06c535e0$@samsung.com>
 <CAKYAXd__ypbjLpnNVDxf3UE4M+au2QwYYe2PeY8QsKZCBaO54w@mail.gmail.com>
In-Reply-To: <CAKYAXd__ypbjLpnNVDxf3UE4M+au2QwYYe2PeY8QsKZCBaO54w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB6114:EE_
x-ms-office365-filtering-correlation-id: 609fbe2e-dbe9-4d4e-96d9-08dabb2fb1e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJWB7BAHTxU24SGRAHZXEISCT5zD207JDPydsn74hkTfIhz5TSYRFog+uGSAE57f1IOCDFs/PgjbmOoA5BGk5WtaSdtxJbXMJJ8Ql0TGQseTwIbvL0FwftKYpvDY7TfP0rEsRPqydCAlgHk57gWtg0bpbDMMy6b9M98AFWKYaGVa5kkb5ysaU6vxVrKFka2TnfvfE+lecK7bQQT/W3VdU1Teki9ZUZ3bLy45iDxLBaJNXhlt/CBtEg5xUC4F2QfD41l7oZMvUi0O8UKAqmTzSXSbkMKawxI1PgOVoIJ5mQMu3vPXqMQVIK5xRsZPYad+m1bJvapjs+ow39WO+gm8x4JimE5tns4N+MQHONrW6gl0v242ReNhauTlDri4e28PgKwzBNazeo+3jchuhjgY4/gX7duJPfwIc2AzYGWq/bqVHYaOPCdgK8PMf2f+1wrMgQP7Z0UwbYhFQJRaY+RPyyMQFkmaxU92zlN4/4GQxUa1dXn3TLeucZlEhbchO8yBMChLRo/HZEFIwKMEpNRYlqhfYNSnjxVe0bCgoPCWUuhcMAUJr9P3+/VY59RETMNZNsaATJb8K9xTvCUSEn02ZWYewRbfTSyqNKkl1aeCdJ2z7zKfjjuMYJqAcbgmOuZz5oMbLZreiXxfN3T1kKAnVJU+4dIxec9LrOzh+pVWRsCqT+MR7ufjHlztse3mjg2twahlAO6++DRL5LlF68n+WnuNFAyz/aCoxfa+ZVC1zAtA8w6UqQImIJJb+QIQQYPO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(122000001)(38070700005)(82960400001)(38100700002)(55016003)(86362001)(33656002)(4001150100001)(71200400001)(2906002)(107886003)(478600001)(4326008)(316002)(66446008)(76116006)(8676002)(66556008)(66946007)(64756008)(8936002)(5660300002)(110136005)(66476007)(7696005)(6506007)(41300700001)(52536014)(54906003)(9686003)(186003)(53546011)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZXcUpkTFdFLzR4N0tSYTNhbExkdTh4RU5tcUdTYUVSR1B4aFZuNnNlWjdZ?=
 =?utf-8?B?bGY4WTNtV2tYM05qZzM4NnIwN1NmOWhrNTQ4V0hOQUdlOWJsME8vd2puYVd3?=
 =?utf-8?B?aUJqRTlLemExdG5ra3lVM01jdXdJZWJ0ek9kMUVKbXJvV2xKN0htL2VUNnht?=
 =?utf-8?B?VW1XbTQ1Qm5iSm5ZWnFRZEVGZStSS01tWENjejNVelhBck1Kalk5SlNZa1FE?=
 =?utf-8?B?L2FFbjRDVmtDYi96OFFzb2doVlhZWFlNL2hPb2VtOENOa3RsbUlrZVhKdFE0?=
 =?utf-8?B?VW1QZW1lUXFZMit6MUwrbFpBU2Mrc3o5Q0xadGVNNmI4UG5YT014RmdXRmJI?=
 =?utf-8?B?c3ZtWTlxbDY5NVIveWQ4aytnRWhCNjUySXg0N2lpZ0Y1MkFLTGxYMmJkQWZB?=
 =?utf-8?B?MHVkbk84UE0vc2M2a3UxYTRnNmpPNEZNV0FqTjN6YUgxenkrN2dVMW9relJi?=
 =?utf-8?B?UzRWLyt5NmlKZEtYbk5vSkNzTDF0MGNLamxjbUQ0YUpYQ1N3V3NLYm5MZm5E?=
 =?utf-8?B?SEJteExNSThZMzhJTVQ2TUlNZFJHZ2lGUnhWNjRnNlgxNXVzU2pmVWpGNita?=
 =?utf-8?B?bFMxamNTQ21tditDSkRCdGJXSSt4TmI1UEx2K3R3MTUxYWF4RVYzR1BvdUFX?=
 =?utf-8?B?K01mNHZDZDd3YzdWRDNyZzFSUUR5U0dBWmlHdkZzcFhjVjFJdzMyYy9vb1l2?=
 =?utf-8?B?QXNqNUZRaWRwWEp5T2VNM2dPR1dsVFJCZU1SUThMcHE0bXBybHBpNGVPTzdE?=
 =?utf-8?B?ZVVnakdPc2VpQkNCS0dSU1RyMzNiV3RqR21Db3d2NTBMWGNHdjBkMVJFMVFk?=
 =?utf-8?B?ZDIzVTJKODVwT2M5OHZUZlhNTWNjNnNBRUVueGQ1OTF3eW9wcnl4ZXNsQTQy?=
 =?utf-8?B?VVJCQTQvQmpZeFVodmovS2V2Q0U5N3hjT05UOWxNdllmU09XSEJmTWdXc0NH?=
 =?utf-8?B?U3d5Tklya3dqdGZ0a1ZPby93ZzZuK3QxSm1kSkNGMWdIRk44dkhqVWg2M2l1?=
 =?utf-8?B?b1I0NnJTTmJXeHhhZjhIY1JoUjc0ejhQZGY1N3UxS3F4aDI5VjdYdFB3N2pP?=
 =?utf-8?B?Z3drTW1qa1FXVml5NnRYU2tXcVVCVkpPS3UxYVIzTlZNdkVraUxyQng4NTFR?=
 =?utf-8?B?UkJVWk9zTTJzbzM2UUF3ME9SWnVac05XMmM2TDNtZXJ4UXZzTnNQUW5zbXdk?=
 =?utf-8?B?cXQra2RTQmxSajN6LzJMdXh2QmdpdVBQMlJQUDN0S0MrWmhBOHg5UUsxQ0F5?=
 =?utf-8?B?M0N2ZXJRbzZjVUR6VGJ4SFZIQkI4VCt5dHZMSTlBZEdBOG1SU05nb2RRMmZu?=
 =?utf-8?B?TVpmZmN1L3lhVDR0eVZJMldaWTB0Uk9Rb2twcDlYa2ZvV0xDVTRqUUQ3ZEVT?=
 =?utf-8?B?TjgrT09GR3JiTWxoUmxTMi9GWmZxK3RnOXQyYVNRbjlyK3gzRkVSaG5ETGp6?=
 =?utf-8?B?QThYcEp1VkZiWEFHaVV0eTNOc3FVYmYwZnJMOUJOWWpWQzBNOE9ENVJudGw4?=
 =?utf-8?B?elJnUU9YQmdhYzU5TE9lVVB5bU9vSlhmeVJHUE82YzFsdDkzcVZQdmFlSEdj?=
 =?utf-8?B?NjB3aWxqdlIwR0w1eFFodUtOZVBic1FSMFhTSmh6eWxhM0s0Mzk4dllkUGJK?=
 =?utf-8?B?WGg1VzRaajJEOXovdE9NbE1pQ2diKysrOHc5aG1jN2pFTjFXYTZmOUxFbnBx?=
 =?utf-8?B?amRDQWhHbktvZ01CZmJsMkJpQjUrS0JGWUtMNHBnWTAwNW5GZDVETFoveVNS?=
 =?utf-8?B?UEh3MUwyY2dnbmVJOFB4Q01tRS9mNENnM2RRd2EweURkbkREZXdFekJaeFdi?=
 =?utf-8?B?RjV6bTZxbTZGclFlUjFSNEF4cmU4OElIc29NSk5La2IxaDl1eDhYVjUyWEgw?=
 =?utf-8?B?c0tsTWZKaHlyZml6RzVDRWRSRUVTbG53S2JKQ214TmowVGhMQVk2TDRtanRh?=
 =?utf-8?B?R3NUZkZMMFVNRUxSb3ZkSENIRmhXWjJEbzh1SXBBV1ZaWHVpaFU4NTh2RDBi?=
 =?utf-8?B?ckp6QW9oOTA2aFlycUtZRHpxTklpL3JzRzdSOEhZejdHSWwrTmdUTFNTQTUr?=
 =?utf-8?B?dW91MlJWZmR2TVVaa042ZGt2TncvYVRrR2JqdVR3ZGNCZTVvUitnZUlBQUk2?=
 =?utf-8?Q?+gmuH8XXSLvvBuwuG19GO4gKo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609fbe2e-dbe9-4d4e-96d9-08dabb2fb1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:04:34.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wjm8qkV3ZI60tVYuu8Z4LObd22ggKjJWgm93C1D+81V5tLKLslUdh+jx9pexWEU65vUhP+tcoIysfQg97lJGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6114
X-Proofpoint-ORIG-GUID: I0U2nTBgY_4aaa6zjzCbkTsyfnDabB4y
X-Proofpoint-GUID: I0U2nTBgY_4aaa6zjzCbkTsyfnDabB4y
X-Sony-Outbound-GUID: I0U2nTBgY_4aaa6zjzCbkTsyfnDabB4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IEJUVywgZWktPmhpbnRfZmVtcC5jb3VudCB3YXMgYWxyZWFkeSByZXNldCBhdCB0aGUgYmVn
aW5uaW5nIG9mDQo+ID4gZXhmYXRfZmluZF9kaXJfZW50cnkoKS4gU28gY29uZGl0aW9uLWNoZWNr
IGFib3ZlIGNvdWxkIGJlIHJlbW92ZWQuDQo+ID4gSXMgdGhlcmUgYW55IHNjZW5hcmlvIEknbSBt
aXNzaW5nPw0KDQpJZiB0aGUgc2VhcmNoIGRvZXMgbm90IHN0YXJ0IGZyb20gdGhlIGZpcnN0IGVu
dHJ5IGFuZCB0aGVyZSBhcmUgbm90IGVub3VnaCBlbXB0eSBlbnRyaWVzLg0KVGhpcyBjb25kaXRp
b24gd2lsbCBiZSB0cnVlIHdoZW4gcmV3aW5kaW5nLg0KDQo+ID4+IC0JY2FuZGlfZW1wdHkuZWlk
eCA9IEVYRkFUX0hJTlRfTk9ORTsNCj4gPj4gKwlpZiAoZWktPmhpbnRfZmVtcC5laWR4ICE9IEVY
RkFUX0hJTlRfTk9ORSAmJg0KPiA+PiArCSAgICBlaS0+aGludF9mZW1wLmNvdW50IDwgbnVtX2Vu
dHJpZXMpDQo+ID4+ICsJCWVpLT5oaW50X2ZlbXAuZWlkeCA9IEVYRkFUX0hJTlRfTk9ORTsNCj4g
Pj4gKw0KPiA+PiArCWlmIChlaS0+aGludF9mZW1wLmVpZHggPT0gRVhGQVRfSElOVF9OT05FKQ0K
PiA+PiArCQllaS0+aGludF9mZW1wLmNvdW50ID0gMDsNCj4gPj4gKw0KPiA+PiArCWNhbmRpX2Vt
cHR5ID0gZWktPmhpbnRfZmVtcDsNCj4gPj4gKw0KPiA+DQo+ID4gSXQgd291bGQgYmUgbmljZSB0
byBtYWtlIHRoZSBjb2RlIGJsb2NrIGFib3ZlIGEgc3RhdGljIGlubGluZSBmdW5jdGlvbg0KPiA+
IGFzIHdlbGwuDQoNClNpbmNlIHRoZSBjb2RlIGlzIGNhbGxlZCBvbmNlIG9ubHkgaW4gZXhmYXRf
ZmluZF9kaXJfZW50cnkoKSwgSSBkaWRuJ3QgbWFrZSBhIGZ1bmN0aW9uIGZvciB0aGUgY29kZS4N
Cg0KSG93IGFib3V0IG1ha2UgZnVuY3Rpb24gZXhmYXRfcmVzZXRfZW1wdHlfaGludF9pZl9ub3Rf
ZW5vdWdoKCkgZm9yIHRoaXMgY29kZT8NClRoZSBmdW5jdGlvbiBuYW1lIGlzIGEgYml0IGxvbmfi
mLksIGRvIHlvdSBoYXZlIGEgYmV0dGVyIGlkZWE/DQoNCk9yIG1heWJlLCB3ZSBjYW4gYWRkIGV4
ZmF0X3Jlc2V0X2VtcHR5X2hpbnQoKSBhbmQgdW5jb25kaXRpb25hbGx5IHJlc2V0IGVpLT5oaW50
X2ZlbXAgaW4gaXQuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFt
amFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVy
IDMxLCAyMDIyIDI6MzEgUE0NCj4gVG86IFN1bmdqb25nIFNlbyA8c2oxNTU3LnNlb0BzYW1zdW5n
LmNvbT47IE1vLCBZdWV6aGFuZw0KPiA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQo+IENjOiBsaW51
eC1mc2RldmVsIDxsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbA0K
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MSAxLzJdIGV4ZmF0OiBzaW1wbGlmeSBlbXB0eSBlbnRyeSBoaW50DQo+IA0KPiBBZGQgbWlzc2lu
ZyBDYzogWXVlemhhbmcgTW8uDQo+IA0KPiAyMDIyLTEwLTMxIDE0OjE2IEdNVCswOTowMCwgU3Vu
Z2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcuY29tPjoNCj4gPiBIZWxsbywgWXVlemhhbmcg
TW8sDQo+ID4NCj4gPj4gVGhpcyBjb21taXQgYWRkcyBleGZhdF9oaW50X2VtcHR5X2VudHJ5KCkg
dG8gcmVkdWNlIGNvZGUgY29tcGxleGl0eQ0KPiA+PiBhbmQgbWFrZSBjb2RlIG1vcmUgcmVhZGFi
bGUuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bz
b255LmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQo+
ID4+IFJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0K
PiA+PiAtLS0NCj4gPj4gIGZzL2V4ZmF0L2Rpci5jIHwgNTYNCj4gPj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMgaW5kZXgNCj4gPj4gN2I2NDhiNjY2
MmYwLi5hNTY5ZjI4NWY0ZmQgMTAwNjQ0DQo+ID4+IC0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQo+ID4+
ICsrKyBiL2ZzL2V4ZmF0L2Rpci5jDQo+ID4+IEBAIC05MzQsNiArOTM0LDI0IEBAIHN0cnVjdCBl
eGZhdF9lbnRyeV9zZXRfY2FjaGUNCj4gPj4gKmV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBz
dXBlcl9ibG9jayAqc2IsDQo+ID4+ICAJcmV0dXJuIE5VTEw7DQo+ID4+ICB9DQo+ID4+DQo+ID4+
ICtzdGF0aWMgaW5saW5lIHZvaWQgZXhmYXRfaGludF9lbXB0eV9lbnRyeShzdHJ1Y3QgZXhmYXRf
aW5vZGVfaW5mbyAqZWksDQo+ID4+ICsJCXN0cnVjdCBleGZhdF9oaW50X2ZlbXAgKmNhbmRpX2Vt
cHR5LCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKmNsdSwNCj4gPj4gKwkJaW50IGRlbnRyeSwgaW50IG51
bV9lbnRyaWVzKQ0KPiA+PiArew0KPiA+PiArCWlmIChlaS0+aGludF9mZW1wLmVpZHggPT0gRVhG
QVRfSElOVF9OT05FIHx8DQo+ID4+ICsJICAgIGVpLT5oaW50X2ZlbXAuY291bnQgPCBudW1fZW50
cmllcyB8fA0KPiA+DQo+ID4gSXQgc2VlbXMgbGlrZSBhIGdvb2QgYXBwcm9hY2guDQo+ID4gQlRX
LCBlaS0+aGludF9mZW1wLmNvdW50IHdhcyBhbHJlYWR5IHJlc2V0IGF0IHRoZSBiZWdpbm5pbmcg
b2YNCj4gPiBleGZhdF9maW5kX2Rpcl9lbnRyeSgpLiBTbyBjb25kaXRpb24tY2hlY2sgYWJvdmUg
Y291bGQgYmUgcmVtb3ZlZC4NCj4gPiBJcyB0aGVyZSBhbnkgc2NlbmFyaW8gSSdtIG1pc3Npbmc/
DQo+ID4NCj4gPj4gKwkgICAgZWktPmhpbnRfZmVtcC5laWR4ID4gZGVudHJ5KSB7DQo+ID4+ICsJ
CWlmIChjYW5kaV9lbXB0eS0+Y291bnQgPT0gMCkgew0KPiA+PiArCQkJY2FuZGlfZW1wdHktPmN1
ciA9ICpjbHU7DQo+ID4+ICsJCQljYW5kaV9lbXB0eS0+ZWlkeCA9IGRlbnRyeTsNCj4gPj4gKwkJ
fQ0KPiA+PiArDQo+ID4+ICsJCWNhbmRpX2VtcHR5LT5jb3VudCsrOw0KPiA+PiArCQlpZiAoY2Fu
ZGlfZW1wdHktPmNvdW50ID09IG51bV9lbnRyaWVzKQ0KPiA+PiArCQkJZWktPmhpbnRfZmVtcCA9
ICpjYW5kaV9lbXB0eTsNCj4gPj4gKwl9DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gIGVudW0gew0K
PiA+PiAgCURJUkVOVF9TVEVQX0ZJTEUsDQo+ID4+ICAJRElSRU5UX1NURVBfU1RSTSwNCj4gPj4g
QEAgLTk1OCw3ICs5NzYsNyBAQCBpbnQgZXhmYXRfZmluZF9kaXJfZW50cnkoc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiwNCj4gPj4gc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpLCAgew0KPiA+PiAg
CWludCBpLCByZXdpbmQgPSAwLCBkZW50cnkgPSAwLCBlbmRfZWlkeCA9IDAsIG51bV9leHQgPSAw
LCBsZW47DQo+ID4+ICAJaW50IG9yZGVyLCBzdGVwLCBuYW1lX2xlbiA9IDA7DQo+ID4+IC0JaW50
IGRlbnRyaWVzX3Blcl9jbHUsIG51bV9lbXB0eSA9IDA7DQo+ID4+ICsJaW50IGRlbnRyaWVzX3Bl
cl9jbHU7DQo+ID4+ICAJdW5zaWduZWQgaW50IGVudHJ5X3R5cGU7DQo+ID4+ICAJdW5zaWduZWQg
c2hvcnQgKnVuaW5hbWUgPSBOVUxMOw0KPiA+PiAgCXN0cnVjdCBleGZhdF9jaGFpbiBjbHU7DQo+
ID4+IEBAIC05NzYsNyArOTk0LDE1IEBAIGludCBleGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiLA0KPiA+PiBzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqZWksDQo+ID4+
ICAJCWVuZF9laWR4ID0gZGVudHJ5Ow0KPiA+PiAgCX0NCj4gPj4NCj4gPj4gLQljYW5kaV9lbXB0
eS5laWR4ID0gRVhGQVRfSElOVF9OT05FOw0KPiA+PiArCWlmIChlaS0+aGludF9mZW1wLmVpZHgg
IT0gRVhGQVRfSElOVF9OT05FICYmDQo+ID4+ICsJICAgIGVpLT5oaW50X2ZlbXAuY291bnQgPCBu
dW1fZW50cmllcykNCj4gPj4gKwkJZWktPmhpbnRfZmVtcC5laWR4ID0gRVhGQVRfSElOVF9OT05F
Ow0KPiA+PiArDQo+ID4+ICsJaWYgKGVpLT5oaW50X2ZlbXAuZWlkeCA9PSBFWEZBVF9ISU5UX05P
TkUpDQo+ID4+ICsJCWVpLT5oaW50X2ZlbXAuY291bnQgPSAwOw0KPiA+PiArDQo+ID4+ICsJY2Fu
ZGlfZW1wdHkgPSBlaS0+aGludF9mZW1wOw0KPiA+PiArDQo+ID4NCj4gPiBJdCB3b3VsZCBiZSBu
aWNlIHRvIG1ha2UgdGhlIGNvZGUgYmxvY2sgYWJvdmUgYSBzdGF0aWMgaW5saW5lIGZ1bmN0aW9u
DQo+ID4gYXMgd2VsbC4NCj4gPg0KPiA+PiAgcmV3aW5kOg0KPiA+PiAgCW9yZGVyID0gMDsNCj4g
Pj4gIAlzdGVwID0gRElSRU5UX1NURVBfRklMRTsNCj4gPiBbc25pcF0NCj4gPj4gLS0NCj4gPj4g
Mi4yNS4xDQo+ID4NCj4gPg0K
