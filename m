Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949986A397F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 04:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjB0D3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 22:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjB0D3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:29:24 -0500
X-Greylist: delayed 3654 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Feb 2023 19:29:20 PST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FCB15C9F
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 19:29:20 -0800 (PST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R1hOqq019548;
        Mon, 27 Feb 2023 02:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=JQ3w2h5ZK36FWF29L4fINGZyDgXsxG5wfvW84PqHPXk=;
 b=YpZYzDqQ5i+unA2Qjlz5lecb0G6LQ3c6P/ROoR7R46EtJditV6en/TQ9HTN0LVyVKBQT
 ItqE1C0wes2KSZo09sZUq30WlrORqIuHwMsoVwWIQU28S4RfUkHIKZVc7axtwhk0Amlu
 frmXZFaO+g0qunFRmsCYmSsjZoXIN2YgkywhsWeqApVtftMGo3LlvGYpnUQt/TKPxz7W
 sJxd0Bpy0wXndyDjgkA7Nhgi0XBHAFIIRoaFus/lHEDK8rAb4+9lYbOpxhn3MY/RzVkP
 oKdqWDc5kOLkerInYHGZ12xtcu2TQqDcRTOYrRvokXZoqbFHCMCnBg6fC1fH7eravtjm sQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nybgn92dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 02:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVvf02khRW//PhaDvtdiCU0Iqx3DMxl/TBOX+RBSi4WC6+3nPlivEBmVKXFk8pLH/WXnlS/Z6uI8s1tiHEXkQy6mOceXlZdZXJADIN84ymZIENULwMGjrnv489S0otFxvDFJNsJhdvxDtL6fb90TVjsDur/ghOWW71JV4wvLBvLoMEVu8+DOiCuRegWgZeTVEfPB1lNkVfV/AA991/L+NOvL3AUwwY1A9iGQfD65AQ+vHiWZqDIIc3p+h7FkHEz/VPsSKUJlJLlfN5SaSs9W1V326yAzBCscyUk9Z1JZzQJ0AuQeBI530kVyyS2ip/fUKy6+6rq+zOdvv+JCVEp/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ3w2h5ZK36FWF29L4fINGZyDgXsxG5wfvW84PqHPXk=;
 b=AozQ1VCfXDK81AJWHEuOpWfCb0NLOq5nerMPGgqXuQ+6bI+/OOI/KBGvp2O1TVijPM4lbzZ1ocQKht2HV7ag46YyWkAVFkidGNNielGQbeoOld7sX/0/j8gIEf36FCgUINGJ+XY7vItlEd0jjPGTFo9zJ6qirmblLynZIQT9B0dhSKi+BXQTdTq7r3KZ38S7iSLrXNgjZUbF9rsJ4a9c8Lk1N3P8jSzcY1jbwMEqyaukMaSwHLBENbxaRgUQApmtKUp70TguAd4QuC40PrdfJKj3DtbIxGtrlorBhqzFmXvSvYFQd8JOIdkn9WcwkZPK49QHEIRHwFFpHUfBhjXi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR04MB2272.apcprd04.prod.outlook.com (2603:1096:404:1c::18)
 by KL1PR04MB6735.apcprd04.prod.outlook.com (2603:1096:820:d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 02:20:13 +0000
Received: from TYAPR04MB2272.apcprd04.prod.outlook.com
 ([fe80::65ba:c802:ffac:d8c0]) by TYAPR04MB2272.apcprd04.prod.outlook.com
 ([fe80::65ba:c802:ffac:d8c0%4]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 02:20:13 +0000
From:   "Andy.Wu@sony.com" <Andy.Wu@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH 2/3] exfat: don't print error log in normal case
Thread-Topic: [PATCH 2/3] exfat: don't print error log in normal case
Thread-Index: AdlFxiFlnzIOBZgURkO2gsQA24A40QCktYOAAH3lA4A=
Date:   Mon, 27 Feb 2023 02:20:13 +0000
Message-ID: <TYAPR04MB2272FCA531495222A6BAFAF980AF9@TYAPR04MB2272.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com>
In-Reply-To: <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR04MB2272:EE_|KL1PR04MB6735:EE_
x-ms-office365-filtering-correlation-id: 4d4f4414-f562-4a14-f291-08db186928a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Bx/lan+USoxkiReo5P22yIHlb5xoAkmirlzg8rxS/oMobm/N53tH4dOOXh1GlvkRZsWZWJQ0jtgupHvvASPgkjgFEIu6DCMIM9ls7NIY+/MJ54K8q5tCSs5v6abM8Pv7BM0VZjABinhPJv5Xh+Zk+EeiBwCvEzlKNBJOxaL7eBiSbAfEh5zxbNxFCNKaStROmecsgl6RtYnSR/BCCIxtA1JT5YevsBAKfKoBTTOv+aq8rf0S9QaoWsMYxyLAvCC5JNEUmFSevd4M0U/NWwiqpripRiDmLWcPEy/v+uac97LDNhKfMeJJcybX6u14NGdCg1tr03q161amMvhBdBkP6/Aez79wOH0nm3sSDVGoczahzXpde6so2RSHFMCGaeuY/1oG9EKSlvKy3ksWacty5zSoUBs/sPDTSrf6dcpSqmx0OMC4p2u7fEmofoI692mX3ndxMKXdeapa6Ui1UHJus5DLD1ovojUuIhY0gUtM4nzKgTQ7ZWDrUuZKIW4zPzcoDNWJHgb67/jofmZfcl1sMAtDNYO6vXnlTx91HjtONrlOSE4G2ITDQO6ldIcQ0r6kH/5It8TsHCla4DqCLlelf5ji9vSrxBx0ap7xR/nj7IHOOJUdDbCOkcEVLKmbmn1rxO/OjGR/D9feigaSJD+tZDsyplj3qmVAaqJBD1prAtmsGGagMLoRlI0y9uDJJhHh0Rc70Pj1WvKeNqpMnZ5PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR04MB2272.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199018)(71200400001)(7696005)(8936002)(26005)(6506007)(64756008)(8676002)(41300700001)(66946007)(66446008)(4326008)(4744005)(52536014)(66476007)(66556008)(6636002)(54906003)(478600001)(107886003)(316002)(2906002)(110136005)(76116006)(5660300002)(82960400001)(122000001)(33656002)(86362001)(38070700005)(9686003)(38100700002)(186003)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3gwYURCS2Y3UjN6UHV4RFZvd2RoeUd4cCtkM1VidFB4cm5JQWdtMWtxVnlh?=
 =?utf-8?B?TXV1NjVhRVZWYXdBZ0NWSXFBZ0lKL3ZhNWdhUVE2OFcyZHZ6blNxN1BHcGxa?=
 =?utf-8?B?SGJnUkZycFpCSVBJWU9tWWM5Z1drNFZrcWtrTDZIMUlkVDlVdTg5NEd1YThJ?=
 =?utf-8?B?VjNqcUg5Z0RIOGprSTYwTW9GM3dHYkRZaDBwSnR6REZmdGlmeGdhNExWd3I1?=
 =?utf-8?B?NEx2T0hwYzcrMFBxYmdvMTN2bG5LOUZSMllzVkJ6SHliVGlYcGlDREVyK3F3?=
 =?utf-8?B?eWg0UENtN0FOZk01R1pub1V3RVYrWkxhWUVocXNHN3BaVGc1T3k3OFJrbkRi?=
 =?utf-8?B?b1JPRlBnS2V5M0lKUVJGL3RIOEZUZ01tb3RHbWZCYlM3R3VlUnBwNkh4L3VL?=
 =?utf-8?B?WEJlYVVtcitVQ0JQanJPb1g1Zng3aGpMUEZISStXSGQ5USswem4zOU5BMkpL?=
 =?utf-8?B?ZUZDL29lOVB5Q2p5bE0yV2Rud1RRSHZhV1A1K3ZLeTBLbUNpRGpZRzhHczFC?=
 =?utf-8?B?L3RodTZ3WjBKN1p0VVo0R1FPK0VtcGE3dmxJR2cyZVhrT2VZc0x1c3FFeklh?=
 =?utf-8?B?b3RoOXdybW9FajVCNnArQ3E2a0Y1V1NRMHJ5UDdDU3IzV2ZsbCsrOGlHZ2pq?=
 =?utf-8?B?SDNjZ3JnNFdHYStkcGhWZHFkZmdiekFFekZkWmxMalFhenp5ZGU5Wi9TTFI1?=
 =?utf-8?B?ZUxjVXhheC9lZG83RUpKc2JLVkQ2T0l6TUZwM3ZtYXB4ajk1a0FQVGppWndm?=
 =?utf-8?B?Nnd5Z0VEVUEwTWlQc2pEZ1pQbnVPUzI4dW9vem05ZVk3R2dWOWVRWXhOMVFF?=
 =?utf-8?B?c3l2K1BCV25ETW9PZEJqcEwwM1NMRy9uZHpOWU96VTZSMWFqV0ZudGNkV0tW?=
 =?utf-8?B?ajlBZVZCZ3Z0bVdwS09FbXlsNmtYeFlObTZjSUdSRU93Z0NuSGVaME1qVnJQ?=
 =?utf-8?B?NnpxV3FRQmQ4NmZnTXNkcEs5UHZLNEhQWnlOS0I0K090UFU3SXNia0ZKRThT?=
 =?utf-8?B?Mmd2eGFwRjhLbHpacm1rQmZlSjZwWTEzQ0NzVlh6RW1mbHp0eC9oZ3lSQVUz?=
 =?utf-8?B?WDN3WDlxeWRXczFoK2o0TU0xcWFRUlBZWFVIU1h3VUgycnV0YWZGRUs5OWUv?=
 =?utf-8?B?UHJhZGpCRXYrWjdtMWRqZi9DKzRDSnJQKytYYU54WUxMTHNuR3NrQUo0SElK?=
 =?utf-8?B?QTJpampVeDJMc0VmaGVJYXpzK25NMjNvY293ckF4dXg2b2NYVWhWZHZ2d3lx?=
 =?utf-8?B?NUxjbkxiSTN1bGxSTThYM1NpaEJMY09DaUgrZUMwOXQ4bXBNNWtjWVNlTVJk?=
 =?utf-8?B?a1JJUFZUblJZT3lpTEpPN0J2VkR4WlFObmU2akp0VkhLbHNuWlNvZm45d2lQ?=
 =?utf-8?B?dEU0OW92UEp5eWNObW42RkMyUUc1V0FOaWFiWHlhR01wUlRQbkorRmdSSkVw?=
 =?utf-8?B?ckVsUjNSZ1V5ZG9lT09McVJENGNDYUozZGVlWXlkNk43eEl5cmdqMzYyWkpO?=
 =?utf-8?B?QnlOOXdqOWlybmc4NGhWZUVieEQrbGhWcTh3UTVzU2JRZlFTbHBtME0xZDBy?=
 =?utf-8?B?dFJYNk5oZ2x0R0l6MzFMUGpHTXR6S3hDR3FkVThmY2JWS2t3Rm12TEQ5N0U4?=
 =?utf-8?B?VVZCRWM0dWRMeWV3TlVDRGJWdllPRzA3aTlGYkVpTDdTdXp5ZjQrNm5YSTdD?=
 =?utf-8?B?d0JtdDVUNE5pZzRCSzdEUXdzVU5NOFJwNldWZTg4Rm1RT2pQVUxCRjlIb3hj?=
 =?utf-8?B?OENMU0p4aFdhRWxHZDJaSGFJUUdWTDJBNXZ3WE1zbWJwYktIRWlwRzhQdE5M?=
 =?utf-8?B?VzVvUDZ1OFd6Nlg3WkFlUzEvK3pNUnBFRTA1dHM5bFFZVTgrLzg1UXZaNkx4?=
 =?utf-8?B?S2paT2ZPQzdTcFFzOE1BVWd2eGFJK2FWNXM4Y0s0eitPelF6NW1OK0FjM3d5?=
 =?utf-8?B?WGY2K2FMbDRIckl0aW5HQlZWT1BUMWFIdW92WUM2bW9sYzRENUVDeTRMRTE0?=
 =?utf-8?B?ZFJQRmhvQk5aV2NQNGp2TGRBQ2FPY1dZWkd6NUZHdXlsNTV0NEZSbDhIRWdP?=
 =?utf-8?B?K2hSeUdVZzZ3WUFOYnpQU2R5M25LTDNPV05TQkRrTjVBa241T2U0eWpOam9i?=
 =?utf-8?Q?dUTaaVPP3yEeYtDtRfYGKjggf?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uHVMvughJegCm2QcvqeHrGms9PTr2SxNY37S1Vf8DxFgVRQl9IVctn+K87T/wmreJjf/sM2VESdq+Lig9zSAw0dZT8kR/EtOOXxfHfsX5WEdR+smkiR/bA9sR59WR3aTL/78Jkr69rJiy+ngzHP9P1nFqfD1jpKfBXN2dVVBjZXCJaF5PKfNPLySttWiUZXEcfWcNOVpHssOo2pTQwxVM/HjgmTIM1WB9zc1QIeOJjtD4gyAwQdgXd7s/y/QocGsMa40JS9f9bAt86s3uBmby6bGeSNRWLgKw2Oy0Ia3SJAei9ppB25tieAO1ssNzGI9bfxnQeDbREu+vPo7xCPgtOt4pK3RGAO85ID58Z3UCI9Fd//0Rsbk7v3hm8sYvrTr6k8jLTUL1bWg3/lcgOXclVqSJPqKm2rbGhXQFhq7VQZVB7Ou2VVgrxx5dRVbRsjAnpccx1XAwFTpS+ve79TuorXxnRmgRwdrrjr7BHWgSMu1ZVLWMDtuBZJtkgfyvgfhkl9qZLwjQVtGB8HPGjaAirJxz38Ctrz027AmLSVHkXlahmpCL1F1kXe21+f1JV8hV2jM3KPXhlHrHMJrpSa7yYBwTNGRzm9Rt2ZEkPDV8FN6oKmnTLlD2xjQIs3tr2MG1or7nKauRDkbMML3Z+CuOjjIGboT4u6b11NhsDaFhOjHj3YCouiVyyHKJ8mfNRbxpSOIrTUBKCWV5WHhY8/wsOu/PpLPr62Or8uzVnc0gu4RjygTdj33nwBydkVPLxyn/sDaoQJDpYkCHryp/MStiO9NRfaCeRsfxQpSvRUCMNr3wkK1t20ezEHi6+cii4/ohgOIh33x10IIPMgPkqSjDA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR04MB2272.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4f4414-f562-4a14-f291-08db186928a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 02:20:13.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sz5+gUDf4pZopnPkJ2toeiqjCNSLFrQjdeqtgQOuOv1hj7OctZPawwgsCIZb3H41ATFMXw2eqd+u/mVmfsMq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6735
X-Proofpoint-ORIG-GUID: GlzHRiQGAXSKL-l3_NddY6OQexDjHX7t
X-Proofpoint-GUID: GlzHRiQGAXSKL-l3_NddY6OQexDjHX7t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: GlzHRiQGAXSKL-l3_NddY6OQexDjHX7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTmFtamFlOg0KDQo+ID4gKwlpZiAoaGludF9jbHUgPT0gc2JpLT5udW1fY2x1c3RlcnMpIHsN
Cj4gPiAgCQloaW50X2NsdSA9IEVYRkFUX0ZJUlNUX0NMVVNURVI7DQo+ID4gIAkJcF9jaGFpbi0+
ZmxhZ3MgPSBBTExPQ19GQVRfQ0hBSU47DQo+ID4gIAl9DQpUaGlzIGlzIG5vcm1hbCBjYXNlLCBz
byBsZXQgZXhmYXQgcmV3aW5kIHRvIHRoZSBmaXJzdCBjbHVzdGVyLg0KDQo+ID4gKwkvKiBjaGVj
ayBjbHVzdGVyIHZhbGlkYXRpb24gKi8NCj4gPiArCWlmICghaXNfdmFsaWRfY2x1c3RlcihzYmks
IGhpbnRfY2x1KSkgew0KPiA+ICsJCWV4ZmF0X2VycihzYiwgImhpbnRfY2x1c3RlciBpcyBpbnZh
bGlkICgldSkiLCBoaW50X2NsdSk7DQo+ID4gKwkJcmV0ID0gLUVJTzsNCj4gVGhlcmUgaXMgbm8g
cHJvYmxlbSB3aXRoIGFsbG9jYXRpb24gd2hlbiBpbnZhbGlkIGhpbnQgY2x1Lg0KPiBJdCBpcyBy
aWdodCB0byBoYW5kbGUgaXQgYXMgYmVmb3JlIGluc3RlYWQgcmV0dXJuaW5nIC1FSU8uDQpXZSB0
aGluayBhbGwgb3RoZXIgY2FzZSBhcmUgcmVhbCBlcnJvciBjYXNlLCBzbywgZXJyb3IgcHJpbnQg
YW5kIHJldHVybiBFSU8uDQpNYXkgSSBjb25maXJtIGlzIHRoZXJlIGFueSBub3JtYWwgY2FzZSBp
biBoZXJlPw0KDQpCZXN0IFJlZ2FyZHMNCkFuZHkgV3UNCg0K
