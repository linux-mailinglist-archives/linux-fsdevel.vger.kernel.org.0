Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F74DAD53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 10:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiCPJTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354820AbiCPJTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:19:22 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD61B794;
        Wed, 16 Mar 2022 02:18:05 -0700 (PDT)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22G8N11Z001265;
        Wed, 16 Mar 2022 09:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=6FcMQXHFzxOq2drwmB5hhf/R+sed5fXrXVLBhXT+Gw8=;
 b=k6QucXCit48Tp1WUqM4qNjmdJGzAPedFVxZLNZR+ThePdXusj1sv4UMO1r2Ydp67R2d0
 NUBKoD9/gG6l+onMFdKKipXgA1kWUSB2HCjuPOMDz+o9vmuwznATfjtdj1l9eZHaCp4Y
 Oxv6AonH6gMycmi++q8Iyu+RLqZ1l4scDgh/3BdfmRBn9RUb2yOv+0e4gydUGpRbjoIi
 c+V6GXiYwu9Jdu0486gHqj9ULj8XOf5sWCKW/KBTu1LWxZPE0LaxN3Q+jtDuqOKEoS7d
 L7c2FamCZXUFxCiaWAha3uRhnX+7+zg/wak+qRiJV7ZoKAppEzlR1WA7X5xTfK2W1XGe yQ== 
Received: from apc01-hk2-obe.outbound.protection.outlook.com (mail-hk2apc01lp2053.outbound.protection.outlook.com [104.47.124.53])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3et65st69s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOp3/rXDROuR6JE6S38m9W3fUMQJ0ns2HCZ5D0Ql4IoaFig+LzdEMi7YXyjLhekuyPrQ1wIy0S6O56/0BkQMWmuGcQE8IyDnpJC4ZAnFhJb66L9oJPlnS0i4sPoRc/EAcPV72wpLUanOCRhDsNn8EVjkiqw/7DSHz+ROqoYUW6y/yo2EjlJW0ko9yd9M7yBWbg03QcEnsLosdEAPV4D/UpzMbKDp/i5Aq/dop11o2gFVfrE2aXyYrGDGaMW90erKa00dBWXhtPMy02rVoRZir4FI7VSk325EDHdwzcgUJJcrg96tp0phlZqFHq4MfO2mBZVGWhZW9WJAdKGffLW1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FcMQXHFzxOq2drwmB5hhf/R+sed5fXrXVLBhXT+Gw8=;
 b=fg9hZSKT0+C1iCXbwKGCK4gI6qqeI4zzQQNrs64kR3uxMYM+34jDyWteV4v64ozSVTkHmZxodUE7yd/hSmsb7Q0VFXDIgH0Rgyno/DVxhhDzZDow1HVEMLf1nxgOjmA6+7FxbOtU69jY3OIgK8NfsDT8j0SR6yB9u7gcOq3auUkMQgWqElY+fFfDjKQOk+AY49a/FFpCLBMrz4XGLjYHBGX4ywSQNEAOU+7BKreFYfk2gnh79+rKLCS4J6feijeGwRZcS1ex3XptWuXW8OTfXkO02ewOwGqHiVdbdf4bDAqoYu44Kl7CWpnYwTolZoQyP7wF888S90eYVx4dOR0DJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SEYPR04MB5908.apcprd04.prod.outlook.com (2603:1096:101:68::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 09:17:42 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::8cd9:c0ec:b2ba:d155]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::8cd9:c0ec:b2ba:d155%6]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 09:17:42 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg0Vskc+T+8E+65Sm+jIEZBsmb4mgAqgpIBAL5OAAAARKJNoA==
Date:   Wed, 16 Mar 2022 09:17:42 +0000
Message-ID: <HK2PR04MB389107EDB293B91E9750CEEE81119@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
In-Reply-To: <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 554169ed-324e-41e3-3bc2-08da072dd334
x-ms-traffictypediagnostic: SEYPR04MB5908:EE_
x-microsoft-antispam-prvs: <SEYPR04MB5908EEE5978656C40BD6D62781119@SEYPR04MB5908.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjE26ZT97FHLfaakWvGzZqeioG7IE5yHevAK4ITdBaENgE7iJmE+UW4W+J49ZMXQ+uVvCieDOdZ2AM2ANeaC3mFVacrbRvcUts4DndRxm1AOrYEEasqV+B06ExPT8ToKJBaw8CVqIwPkPrRbIhBY4DRNkCVWyCaNtYxmHsLaftn8atBc/lBIlmcsTt1VZCgxR73l9kKDeXmMqgXYm7w8FT0cfHORaQnw6eVnT5QUbmlSTMzPrw/7653md9bTmBL/NRL9d2uhcS7GvWPi/xpTJPfER+oibD4t046YKtp3dQavvOx/T5NaU/BgpGPLSaU7OTsejcKXrRJYq0CdO25GOdZKrm4Ej83MFd4uEpTx7nJ0UelbL0xs1TCekiJ8OuoCV4Lv4HgQ8mXi9cxYNr1ozVqaZZ1s0xn/DGMW4CgsGpHpml1TBVHHppfAv59eat4E6+puuJtG+Gmcm2ul8+VuYNRUbEU3dVGveHCaO0t7sYoMErHT2AVZ4kxWiYX+sl2x4dRK8vGPCB/YotoWZD8VNE+IP9eyjYP5NjJ1SlDSzWmHGJTChm+jFn4HVXKVUyQkbho2VUv9jCE4KZIZv34QQ9m/8EIsH4pLc/sBm8B4OvsXmGzzsqej2kbRXD/lTWJUovb8u6UTUIvDKGa9+cK8na9ThCNafT0vSo/VmHPI+UPcx4rekEXGr2yZmVoH7G+Mp+3gS8zRuDvNn29wvr+z6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66446008)(66476007)(66556008)(64756008)(8936002)(66946007)(110136005)(8676002)(86362001)(316002)(5660300002)(52536014)(83380400001)(4744005)(2906002)(54906003)(76116006)(71200400001)(9686003)(7696005)(6506007)(107886003)(55016003)(186003)(26005)(508600001)(82960400001)(38070700005)(38100700002)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym9VUFhWOGNDd1Fadnh3dVNoN1VvTlVpK282dEtxUHNvMFNVQ05IQVhrY1Va?=
 =?utf-8?B?aU5qMjUvMjMrbS8vRDdGRkdKUzZSNklHeVBuakNzV3p2ODRCc1IxVTJrR3ZV?=
 =?utf-8?B?bWJ6UWp3MW5ycnBud2tqbXpoczcvWkhOQytra3dOWktNZFBtY3Z0bGtRbm5B?=
 =?utf-8?B?UTlWRlJldjRiSjJ3OU1Rc2VzOEQyb2JYUmhPSUxPSENzeThwZFk0M1krdERB?=
 =?utf-8?B?WVZCRGF5TmhwaGl2dmZaS0srUnovNjVKV0xBZFUwc1JNUzVONEhOdVoyTjJP?=
 =?utf-8?B?Z1g2K3pNQy9qUlUzWmEwdzJ6VzVKWERLY0lxZjlCVHRMTTJiQ3hzVml4SnN1?=
 =?utf-8?B?aWtDU0tYRWVwM3VmajNlQytaWXhsQ0hhRm9rdit2K0tsWlZkRFB1SFJxc3BU?=
 =?utf-8?B?NHFsZEdQbS9WUWtpRlMxZDhTQXRuaTl0aHM3Ukl2VURpbmU3NWhyTEVXbDJ0?=
 =?utf-8?B?U2tLNXZDYlBiYVc4QXEyVk52QUl5bldOdWZaWUx5Zit5bXAyeWtncGh3Rkdw?=
 =?utf-8?B?cWV3SmxSSnd1V1cyUlBld3hQWWlTWlFFY0o1OEtrdzE3NkNvcEVPQ3lYdWQ2?=
 =?utf-8?B?SWt6VUNEQzlxVnhXNlIrbmQrQnJPczMyMXVYTTg5RHJlOFdXd2IrUXFlV3Fx?=
 =?utf-8?B?YTJSOUdVMVpJcC8vR05NdGhMQ0p2a2xzZHpUMmZVQ2RXenFzaTFvTlhLWFph?=
 =?utf-8?B?MTZFZFVXU1lQZkduV2R3c2M4UldVakpLM3JoTkx6aGh1cWlJeURqaWlJaVJl?=
 =?utf-8?B?UzV2cThIVlZEaXdhNXNkRFZBVUZLclNXdlE1MmtQLzZiTHFtd0FBUUJMSWdh?=
 =?utf-8?B?a3FyK2UxMUdJaGdEQytlWC9LYzRjT3lwMUtCU1cybkZPek4zaU9XMk5XMHFC?=
 =?utf-8?B?dkMrZ1NQaW43N2JMQyt0UlJ1WDJoYW1RTEM2T3oxVEtVMGp3TVdxcWVqaVlW?=
 =?utf-8?B?Y0hSU1JpeVMrSmNyNWY1WjJMSnl4VHFGK1U0NWxkV2N2L3c5R0VQZzFMeitT?=
 =?utf-8?B?cVpubWVIc0F4ZTN5ZlJQTjRubFFzOTlqcUd6Q3lqVW5SUGdrQi83MnpNVVdQ?=
 =?utf-8?B?cktzbUtSL0F3STFiVG9ualNEVWJjNSt6WWVyRlF3ekVJZGxIMm5GSmlLbXBu?=
 =?utf-8?B?T2pDSEt4S3RmUU9Fak9CYTFNZHBBNEtPMFgyVnFLbTMxeE95Snd3RS83akdp?=
 =?utf-8?B?dTVaaFZoS1FjRjZqSGJ6TnlEaFlodDJHSktoZ041TFpjcVUvQnZyOFY0T3p4?=
 =?utf-8?B?MEZQeXZZZlczSnROZFZ0TTFxWk42NGY0dzRHSnZvK2lKS282am9QSVVIUTd0?=
 =?utf-8?B?eUI0ZUZwZHdsLzNvMzJneDFQNWpMUkpIamttRjhxK0hnSS9iTGppbUNHSzcr?=
 =?utf-8?B?VThvSy9yUk1SY3N0ZDhHUi84cUpwMGlubTdVR25yaTVSZ1NPK21lVVNhVzhT?=
 =?utf-8?B?VFRZVzZuaU5EZWFUbVlFOVdPWjUxTnZueVhuNW4ycUYvb2MvUERRTkw5a3hK?=
 =?utf-8?B?eTAzT0RBK1I0eE5NN3Q4TW9wb0dvdXVnNFBZbytxN0pGY0NlSThYWUlDNllM?=
 =?utf-8?B?QmNqK1BzOFFrU3JkWjYzUDBTbDNMak8wWERXYllRbUl3dFBneFdFbHZWdmMx?=
 =?utf-8?B?NDl2MTZvK1Fya1dTZnNXemJ5NFNmTHFaUVhMbzRLWk5jQjduZTJrcFJNYTM2?=
 =?utf-8?B?ZngvOTVwWVdsbE93TFNna3VhOWRwQlJzYXdRVTZvOWdUYXBIamtCZ1JEa3JP?=
 =?utf-8?B?WHlwWW0vMmR2OUxPYXNYVFAzT2YwMGhLd1JibzdRVkNvdHRCUUdPMWlmQ3Rl?=
 =?utf-8?B?Q05LSnNJRkZ6RkwvVUk4QTJHaGEyaFlWTXY3Z2llYlh1Y0V2K1ZTYXZrQjlD?=
 =?utf-8?B?M2MzejRta3FMQUdJR3VoVVVSSU5WeXVsWnY4a2xCZitSVjJXODBWeVBPSk1q?=
 =?utf-8?Q?FLq2ew44rdXB1xVg9YEMmyU2om59ATjT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554169ed-324e-41e3-3bc2-08da072dd334
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 09:17:42.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oulx+KImFKLwME/ID3mJeg2DrBUnYAWeI2R46YiVqKlVAlDVwPzkSe8us9AuG7DKQoYyTTBDsrWWI3pKnPR2Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5908
X-Proofpoint-GUID: kqNL-T6Kx1zvA7klcoSPb_kQzGbkZEW3
X-Proofpoint-ORIG-GUID: kqNL-T6Kx1zvA7klcoSPb_kQzGbkZEW3
X-Sony-Outbound-GUID: kqNL-T6Kx1zvA7klcoSPb_kQzGbkZEW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=511 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203160057
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTmFtamFlLCBLb2hhZGEuVGV0c3VoaXJvLA0KDQo+ID4+IC0gICAgICAgaWYgKHN5bmMpDQo+
ID4+IC0gICAgICAgICAgICAgICBzeW5jX2RpcnR5X2J1ZmZlcihzYmktPmJvb3RfYmgpOw0KPiA+
PiArICAgICAgIHN5bmNfZGlydHlfYnVmZmVyKHNiaS0+Ym9vdF9iaCk7DQo+ID4+ICsNCj4gPg0K
PiA+IFVzZSBfX3N5bmNfZGlydHlfYnVmZmVyKCkgd2l0aCBSRVFfRlVBL1JFUV9QUkVGTFVTSCBp
bnN0ZWFkIHRvDQo+ID4gZ3VhcmFudGVlIGEgc3RyaWN0IHdyaXRlIG9yZGVyIChpbmNsdWRpbmcg
ZGV2aWNlcykuDQo+IFl1ZXpoYW5nLCBJdCBzZWVtcyB0byBtYWtlIHNlbnNlLiBDYW4geW91IGNo
ZWNrIHRoaXMgPw0KPiANCg0KV2hlbiBjYWxsIGV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYiks
IGFsbCBkaXJ0eSBidWZmZXJzIGhhZCBzeW5jZWQgYnkgc3luY19ibG9ja2RldigpLCBzbyBJIHRo
aW5rIFJFUV9GVUEvUkVRX1BSRUZMVVNIIGlzIG5vdCBuZWVkZWQuDQoNCmBgYA0KICAgICAgICBz
eW5jX2Jsb2NrZGV2KHNiLT5zX2JkZXYpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgaWYgKGV4ZmF0X2Ns
ZWFyX3ZvbHVtZV9kaXJ0eShzYikpDQpgYGANCg0KZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KCkg
aXMgb25seSBjYWxsZWQgaW4gc3luYyBvciB1bW91bnQgY29udGV4dC4NCkluIHN5bmMgb3IgdW1v
dW50IGNvbnRleHQsIGFsbCByZXF1ZXN0cyB3aWxsIGJlIGlzc3VlZCB3aXRoIFJFUV9TWU5DIHJl
Z2FyZGxlc3Mgb2Ygd2hldGhlciBSRVFfU1lOQyBpcw0Kc2V0IHdoZW4gc3VibWl0dGluZyBidWZm
ZXIuDQoNCkFuZCBzaW5jZSB0aGUgcmVxdWVzdCBvZiBzZXQgVm9sdW1lRGlydHkgaXMgaXNzdWVk
IHdpdGggUkVRX1NZTkMuIFNvIGZvciBzaW1wbGljaXR5LCBjYWxsIHN5bmNfZGlydHlfYnVmZmVy
KCkNCnVuY29uZGl0aW9uYWxseS4NCg0KQmVzdCBSZWdhcmRzLA0KWXVlemhhbmcgTW8NCg0KDQo=
