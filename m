Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295C4F8C8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiDHDLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 23:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiDHDLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:11:06 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE4106124;
        Thu,  7 Apr 2022 20:09:02 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2382kRDi008391;
        Fri, 8 Apr 2022 03:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=JspmJYtyelfjVeO+f5YWb8WrG8nbY3WkFaGaB2cB3dU=;
 b=N8caXLslSYWZXj8VnKUTuVUG5Y3iDP4PVQKD2cqziy6/vn/4q0NWm2F0u5PvEvpSOxQs
 3+tNPHZWxM/X/F73I27D48ENh7zE5X1yypYzlDYliAxF9mBUcHQcFYy9nxmJXD0n8DDd
 B37qwCP7t4EViyennJKPCY/iQsFQnsBXmydfrEumptVw3Evw3b45E7onVNaN5A3qKLSw
 WEg9gS6xy4h6A2huwVkPH7lC2vJZT8mHqXsiGPcfZ7AxTFDxo8zILaPFFwuVhXBEOiSk
 61+Ac8x73TWMkGd1pIrPDahsHou9u7bOwnRkC7rt8k2uwAqcYm69NBYopjEXi1k6/FX1 yA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2046.outbound.protection.outlook.com [104.47.110.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f8yhgjfuf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 03:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6Ba0FH2Drse94ZLm+XUyaG5HTqJKkZghNhdoLKzGbJk5/AJnHzcFzZmX6nbOvfaC/zUA+yPkbaPzGSrfy3jJg5wJeica0VqhbfdqZZbLGiliq+Z5I/1W7t/ODSMKhryzxfxJARkUWMSFG5KX9gwH/S4gR2qbmXrtznRIC71ETH8Pv2MWe/6zhKFhueex9su9sHydfT1Z5tCTO9glIZ9joqqumTr7zSbIBaGUttuUpCWqcRUAoecYh8e8VCwugHrJFt/6+Py0J0EmW3ddIgxV51KlwRH9LempU1PVUNoiy/cm0cu4kDZ+ycM8MxLZ2qGpglQJyZPmyllrYExQJFysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JspmJYtyelfjVeO+f5YWb8WrG8nbY3WkFaGaB2cB3dU=;
 b=imuZIO1l1rApmhV08jTt0gnR/aDCDEh9avKh8mU+8JeIUqCwavbyrn/AKbWRbowG4fblYDIIQW2CItDh4yMXNbEhomarUsjqU0QfrF5KsF3D6dl5Hy/+fa7+BlRuVPa9hHAaAFEzgHNyNYCz3hmsNQ50bIMmt5jxnKEbR/9/etDoHaiLUK/r4e2d376ypUMVNmr9DFhIKxqwIO3gKS1Pg12dbcb9EsPcRHLV1RqPKatXGEVQvH79Y/hkmOvyV8UbpI6icOtmTAS7PiofZSkqEdqpPItdUlcnCiStZvDR5ZdTY3Bgp/oFkyCigKYXCLnyCiAwnWIhXt/CXUHwfw/1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SG2PR04MB3866.apcprd04.prod.outlook.com (2603:1096:4:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:07:44 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 03:07:44 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: [PATCH v3 1/2] block: add sync_blockdev_range()
Thread-Topic: [PATCH v3 1/2] block: add sync_blockdev_range()
Thread-Index: AdhK9MP60JwULp2VR8uDBNc4RhsS9w==
Date:   Fri, 8 Apr 2022 03:07:43 +0000
Message-ID: <HK2PR04MB3891FCECADD7AECEEF5DD63081E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f7d933d-0756-44a7-d52f-08da190cf363
x-ms-traffictypediagnostic: SG2PR04MB3866:EE_
x-microsoft-antispam-prvs: <SG2PR04MB3866FB0427841560136E45EF81E99@SG2PR04MB3866.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbHZ9mgY5JLQb6d0TyFJPfTT8JAuQ3w3mBUtN4HJC/A3IdL1hoAd8LXA1Z+0mWLVSlLwMCjiC0oy5OCG3JmY27hiAh3pEqKPde7b/9ikIXXKhi/9O9IqnIqwPK0XkFdO+ljYMQacz6t/4UzxFzNPrcMedRZ09yMrw6WCQW3fM8R9aMvmdtf1490l9TqK7S8hPespWzrib7dZq/iL6ZMqHQMsCU150H8+qOAPchOfKiZi0JDugNm/ZJfGMB1vOrfNMJE7hSz1IHR98G4N7aOlxjp91VFq6zBNUz6sNCjOJGyspkeaj6TiSB3EaVCbA1Ezaf6RY3HxlCxfUQPJjwFEn1IQ8GaAI5SOncreVtTOH3RiBS4XInwlsIiVj134VSN/mjszSZdwZud26t4J6zoDcXmH1h3Da+C4Gt98sW8/3tqCTXa+FEEVbbmAQ6UG1Vm9vn1xS6xPllwhFVIehZfiVviUUWB522AgqwtFElV8dhDPoxATfBPnAE5AfUGZCbWkNbTLL97HxVwmQEZj/Wa/xly1KDhsyQizfv7hRBoTRzNf/JTO2xLdTeodfpAvvJljAqcPfgyauUZG3yzMf66g0SUJakW/Ug/nzX+ynOXg2mBFH+DO0flXkZXsjfBe3WWQCy2Y3+ZAIe14AdqAp576+QABjlsOJPSyJaHTPKsSRSfdbF2djNIsLJ4hlWXMRiWjjS7D/nUWdVR+/OBreIjhjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(7696005)(6506007)(52536014)(71200400001)(82960400001)(5660300002)(33656002)(8936002)(38070700005)(2906002)(508600001)(86362001)(99936003)(55016003)(9686003)(54906003)(186003)(26005)(122000001)(38100700002)(110136005)(316002)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UCtkZUFSMUErU0xyMEM0UkF5YU92NWRWTS92bE80NE04eDFDNU5pR05Fb0VD?=
 =?utf-8?B?WkduWXZOVkloWE14QlhpemhXY0wzKzVmTHRONHlEV2dJRkIvb200NmdYN2Rq?=
 =?utf-8?B?RGFhNmVpUy9qWm1Jb25HVU02VWhydStsWkJtbSt2bGdyUjRYSGZEeGJ0bnl4?=
 =?utf-8?B?VDRZaWJxWWIwamNJU2hYWTI3T015RHp3cm4rT3ZVb2xkZ1o0QWxhNmRmN0Ur?=
 =?utf-8?B?aEt3dzljQ0xWdkx1U1plVlhoN05COUtuTThtWklyT3ltM1pkZlh0L3p5SWJN?=
 =?utf-8?B?c2tUejJCM2t4UmhFd2FDMi84TXZteTR4cVd6ckJlWUUvMDhMWVJvSnh2NDJN?=
 =?utf-8?B?TENZVllWWVFsdlBZTVZOb3FFSnJmZnFKSUQ2T2RzNHZMdFpvd3crVUhydU9L?=
 =?utf-8?B?S0dGaEdHQXVRNlp3eDY2akUreFZpc0ZoQXhPNWJvalJEb0dUbkdIU1ZpUDN4?=
 =?utf-8?B?MzFWU1NDVmkwbG1kdUwwSUtPc1RRb01wd01pU3F4L3l2SG5YRHlyRisxNjlQ?=
 =?utf-8?B?VFlXbTRNYzZLMWFoZUFvYVYwSW9hOUxPcFlRRi9LVnJJVzA0bFFvSE1JWTBX?=
 =?utf-8?B?ekVIVHZ1dThqUmxtSUowSE1aOVMvRmNFcnNrWUpubi9KVTA0dGdsK2FITC9I?=
 =?utf-8?B?bTR1UjJQZmp2UmxpSEFIQ25MTkhVc1dWQ0F4bHpkMkROVFZISTh5dzhScWZq?=
 =?utf-8?B?bDJZWlZIWjBiYVc5WUZpdlBDOFB6S09FeWwydlRLOUdzUWpQYWtJRXdCTmRm?=
 =?utf-8?B?Zkl0cDFDY0U1VGxHQi8wR2dESHRNOHZGT3ptTXJPNm5uYmVJUEFXOWFhaTNh?=
 =?utf-8?B?a3l5OHV0K040SGhZZklHeUpsK3B4YlU1Mlc4b1pYdU1RME5sRVlTZlRYTWEv?=
 =?utf-8?B?bVRONzZ4anZVTHlUY2toK2IwaWZCeE96S2xyM0RvdEtQWStZSEZQaXltTGVB?=
 =?utf-8?B?YlVheTk3cXBibjJIVUNmbXhoZVdOeUdYNkttcWRzdm9kWnpXM2dvRktVMmFY?=
 =?utf-8?B?cnZ4Q3NMWnBLMWdKaW9VVzFubnUvMlEzTFI3OTdHMHAvbjNpUWdiTG5VVURz?=
 =?utf-8?B?SzNrbzR2SGczUWNnSE1LN1gxbjdYakhmNUJaK0lnQjRtS1Jhd0NSVkNFNXRS?=
 =?utf-8?B?a290aWhaT29iaXBxeFJzTk1ENHY2WmxUWFZJVW5zMjJYRXFxaHprWWZJMG9r?=
 =?utf-8?B?TkpxSk44cTIzQVY3cmlDNkp4UC9wRmxucTRONHBGTWdnMlEyTG4xdjlOMVNt?=
 =?utf-8?B?T2pSNFRhTGdhbXNHaFBaOU04VlVCMnhlanYyeFNhc29RMkVSaGk1WWxpNFU3?=
 =?utf-8?B?U01NQ0pvRE8weWpNUmhCMkh3bEUzSGVRUTBXcmtlRjVNK1Q5ejR4YzJ6a3pO?=
 =?utf-8?B?elF0aEZ4ZkdEQWJCazM0anlVeVdTWHQ5K3VKeC9keXViZVNXbDJFckg2OUZK?=
 =?utf-8?B?Z0tnNlNhMHFOZHRCcngxZy9QWUlzZ1hVWFVJVmxaZG05TU1aU0sxODhKcFZo?=
 =?utf-8?B?RFZjQjhTNklLcjdhd3o4QTY1SlpMUmsvV3pkYVNnakpGSGl0TmhFTlR1U0pU?=
 =?utf-8?B?ZG9JMjdETWVUKzlqZWZwSEZkNUp6U05xM1k5enF3V0xYMmxoYWVjMTRhc3M4?=
 =?utf-8?B?QkdYbVR6bVo4QTlnVWV3ZndWRFU3Z1pLM1FKK29xNnV3Y1RleDBHQkpqbVpL?=
 =?utf-8?B?RWNsa0xlQXlvazBYakxjOXFMZGdwNmVKZjBpMVRJTXByc1hJOW5aNmhIWDFx?=
 =?utf-8?B?TzNsNTNnS2tBV09ZMUF6MmhyM1o0cnR6L3JRcitocVd2WEIzTTJ2TGI1ZGtk?=
 =?utf-8?B?K1E0Z3VOMHdTbDFDeEh3eFgwTzFwN1pxODJKc3lMVXQzdFdodGNrdFZVdlBj?=
 =?utf-8?B?eGRFUlF4Vk95RStjb2pmMXNqNm9yUERwTlRMUFJ1SHdwL05SMXJuTHlIRHNL?=
 =?utf-8?B?b1g1RDNsZk9CRThMeklOelBmckxlZ0ZtbVFZV1pSVXF2Wm1lcXdnM0hpZzE4?=
 =?utf-8?B?YWp2ZzhYaEM5LzZIRnFGVyttQVVqYUEwZWZwQ3FQSkpQQTdUQml0U1VoV0NI?=
 =?utf-8?B?bWc1WTFDQ0pNbTVEdnJ5VWg3RnV1ZW1odHZaWmhJMGNEaUhTZ3V0NTdYZnFL?=
 =?utf-8?B?VFNQWDJaa3grZk9HaDVHL3dKNmJTVHZpeHVPU2VzaW5sOHlUelYrMzVsWW50?=
 =?utf-8?B?MVRwSDhFR0NTK25LeUxDajdMWTZQQUIwcXhoMFZ1eG14dHg2dWNuWEFQd2pR?=
 =?utf-8?B?VXA4ZWpYSlJnNUNtK20vZnhqbFdZNVlYZ1AxNmpRdGRsUUtzMGNTU2RweFZO?=
 =?utf-8?B?VUI3azVXci9RT3lSWGpqZmRlbzJHUUpNUlRFNHpHTDB5WDREano2dz09?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891FCECADD7AECEEF5DD63081E99HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7d933d-0756-44a7-d52f-08da190cf363
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:07:43.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4+ceSZXVfCysEoCkDisFfzxOABTRQRSvSJyDwalSG7oy/zQkAhjlz3idJW7M/m6K4pO/MsqutPXFBgOx9vR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3866
X-Proofpoint-GUID: y0no5m2ISEEEJiwXFFTQT2d89UdtKtCz
X-Proofpoint-ORIG-GUID: y0no5m2ISEEEJiwXFFTQT2d89UdtKtCz
X-Sony-Outbound-GUID: y0no5m2ISEEEJiwXFFTQT2d89UdtKtCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_01,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891FCECADD7AECEEF5DD63081E99HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

c3luY19ibG9ja2Rldl9yYW5nZSgpIGlzIHRvIHN1cHBvcnQgc3luY2luZyBtdWx0aXBsZSBzZWN0
b3JzDQp3aXRoIGFzIGZldyBibG9jayBkZXZpY2UgcmVxdWVzdHMgYXMgcG9zc2libGUsIGl0IGlz
IGhlbHBmdWwNCnRvIG1ha2UgdGhlIGJsb2NrIGRldmljZSB0byBnaXZlIGZ1bGwgcGxheSB0byBp
dHMgcGVyZm9ybWFuY2UuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5N
b0Bzb255LmNvbT4NClN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRl
YWQub3JnPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCmNjOiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQotLS0NCiBibG9jay9iZGV2LmMgICAgICAgICAgIHwgNyAr
KysrKysrDQogaW5jbHVkZS9saW51eC9ibGtkZXYuaCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9ibG9jay9iZGV2LmMgYi9ibG9jay9iZGV2
LmMNCmluZGV4IDEzZGU4NzFmYTgxNi4uOGI1NDliMDcxYmQ2IDEwMDY0NA0KLS0tIGEvYmxvY2sv
YmRldi5jDQorKysgYi9ibG9jay9iZGV2LmMNCkBAIC0yMDAsNiArMjAwLDEzIEBAIGludCBzeW5j
X2Jsb2NrZGV2KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpDQogfQ0KIEVYUE9SVF9TWU1CT0wo
c3luY19ibG9ja2Rldik7DQogDQoraW50IHN5bmNfYmxvY2tkZXZfcmFuZ2Uoc3RydWN0IGJsb2Nr
X2RldmljZSAqYmRldiwgbG9mZl90IGxzdGFydCwgbG9mZl90IGxlbmQpDQorew0KKwlyZXR1cm4g
ZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZShiZGV2LT5iZF9pbm9kZS0+aV9tYXBwaW5nLA0K
KwkJCWxzdGFydCwgbGVuZCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woc3luY19ibG9ja2Rldl9yYW5n
ZSk7DQorDQogLyoNCiAgKiBXcml0ZSBvdXQgYW5kIHdhaXQgdXBvbiBhbGwgZGlydHkgZGF0YSBh
c3NvY2lhdGVkIHdpdGggdGhpcw0KICAqIGRldmljZS4gICBGaWxlc3lzdGVtIGRhdGEgYXMgd2Vs
bCBhcyB0aGUgdW5kZXJseWluZyBibG9jaw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxr
ZGV2LmggYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oDQppbmRleCA2MGQwMTYxMzg5OTcuLjMzMWNj
NjkxOGVlOSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCisrKyBiL2luY2x1
ZGUvbGludXgvYmxrZGV2LmgNCkBAIC0xNTQ3LDYgKzE1NDcsNyBAQCBpbnQgdHJ1bmNhdGVfYmRl
dl9yYW5nZShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsIGxvZmZfdCBs
c3RhcnQsDQogI2lmZGVmIENPTkZJR19CTE9DSw0KIHZvaWQgaW52YWxpZGF0ZV9iZGV2KHN0cnVj
dCBibG9ja19kZXZpY2UgKmJkZXYpOw0KIGludCBzeW5jX2Jsb2NrZGV2KHN0cnVjdCBibG9ja19k
ZXZpY2UgKmJkZXYpOw0KK2ludCBzeW5jX2Jsb2NrZGV2X3JhbmdlKHN0cnVjdCBibG9ja19kZXZp
Y2UgKmJkZXYsIGxvZmZfdCBsc3RhcnQsIGxvZmZfdCBsZW5kKTsNCiBpbnQgc3luY19ibG9ja2Rl
dl9ub3dhaXQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldik7DQogdm9pZCBzeW5jX2JkZXZzKGJv
b2wgd2FpdCk7DQogdm9pZCBwcmludGtfYWxsX3BhcnRpdGlvbnModm9pZCk7DQotLSANCjIuMjUu
MQ0K

--_002_HK2PR04MB3891FCECADD7AECEEF5DD63081E99HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="v3-0001-block-add-sync_blockdev_range.patch"
Content-Description: v3-0001-block-add-sync_blockdev_range.patch
Content-Disposition: attachment;
	filename="v3-0001-block-add-sync_blockdev_range.patch"; size=1668;
	creation-date="Fri, 08 Apr 2022 03:02:44 GMT";
	modification-date="Fri, 08 Apr 2022 03:07:43 GMT"
Content-Transfer-Encoding: base64

c3luY19ibG9ja2Rldl9yYW5nZSgpIGlzIHRvIHN1cHBvcnQgc3luY2luZyBtdWx0aXBsZSBzZWN0
b3JzCndpdGggYXMgZmV3IGJsb2NrIGRldmljZSByZXF1ZXN0cyBhcyBwb3NzaWJsZSwgaXQgaXMg
aGVscGZ1bAp0byBtYWtlIHRoZSBibG9jayBkZXZpY2UgdG8gZ2l2ZSBmdWxsIHBsYXkgdG8gaXRz
IHBlcmZvcm1hbmNlLgoKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNv
bnkuY29tPgpTdWdnZXN0ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+ClJldmlld2VkLWJ5OiBB
b3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPgpjYzogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPgotLS0KIGJsb2NrL2JkZXYuYyAgICAgICAgICAgfCA3ICsrKysrKysKIGlu
Y2x1ZGUvbGludXgvYmxrZGV2LmggfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmRldi5jIGIvYmxvY2svYmRldi5jCmluZGV4IDEzZGU4
NzFmYTgxNi4uOGI1NDliMDcxYmQ2IDEwMDY0NAotLS0gYS9ibG9jay9iZGV2LmMKKysrIGIvYmxv
Y2svYmRldi5jCkBAIC0yMDAsNiArMjAwLDEzIEBAIGludCBzeW5jX2Jsb2NrZGV2KHN0cnVjdCBi
bG9ja19kZXZpY2UgKmJkZXYpCiB9CiBFWFBPUlRfU1lNQk9MKHN5bmNfYmxvY2tkZXYpOwogCitp
bnQgc3luY19ibG9ja2Rldl9yYW5nZShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBsb2ZmX3Qg
bHN0YXJ0LCBsb2ZmX3QgbGVuZCkKK3sKKwlyZXR1cm4gZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9y
YW5nZShiZGV2LT5iZF9pbm9kZS0+aV9tYXBwaW5nLAorCQkJbHN0YXJ0LCBsZW5kKTsKK30KK0VY
UE9SVF9TWU1CT0woc3luY19ibG9ja2Rldl9yYW5nZSk7CisKIC8qCiAgKiBXcml0ZSBvdXQgYW5k
IHdhaXQgdXBvbiBhbGwgZGlydHkgZGF0YSBhc3NvY2lhdGVkIHdpdGggdGhpcwogICogZGV2aWNl
LiAgIEZpbGVzeXN0ZW0gZGF0YSBhcyB3ZWxsIGFzIHRoZSB1bmRlcmx5aW5nIGJsb2NrCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaApp
bmRleCA2MGQwMTYxMzg5OTcuLjMzMWNjNjkxOGVlOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9ibGtkZXYuaAorKysgYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCkBAIC0xNTQ3LDYgKzE1NDcs
NyBAQCBpbnQgdHJ1bmNhdGVfYmRldl9yYW5nZShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBm
bW9kZV90IG1vZGUsIGxvZmZfdCBsc3RhcnQsCiAjaWZkZWYgQ09ORklHX0JMT0NLCiB2b2lkIGlu
dmFsaWRhdGVfYmRldihzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2KTsKIGludCBzeW5jX2Jsb2Nr
ZGV2KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpOworaW50IHN5bmNfYmxvY2tkZXZfcmFuZ2Uo
c3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgbG9mZl90IGxzdGFydCwgbG9mZl90IGxlbmQpOwog
aW50IHN5bmNfYmxvY2tkZXZfbm93YWl0KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpOwogdm9p
ZCBzeW5jX2JkZXZzKGJvb2wgd2FpdCk7CiB2b2lkIHByaW50a19hbGxfcGFydGl0aW9ucyh2b2lk
KTsKLS0gCjIuMjUuMQoK

--_002_HK2PR04MB3891FCECADD7AECEEF5DD63081E99HK2PR04MB3891apcp_--
