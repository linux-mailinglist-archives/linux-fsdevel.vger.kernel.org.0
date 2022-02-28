Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDADC4C68FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiB1K4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiB1Ky6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:54:58 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601D919C02;
        Mon, 28 Feb 2022 02:53:22 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21S6rZ4H001223;
        Mon, 28 Feb 2022 10:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=zB+lZCeGR9GxazSq5uhX56nbMsCg+RM8thPPcY4Me+8=;
 b=WL5NV2jX+5Kqb2Q5wbHGqTgRlEDYLb+QaA9BUv36NXFeH0MFQOctPFPabxnPiT6Ocn7f
 X7ySatZ1GfQALJvVpuJ0xcf6VPm3MVBoNv08D2NV6RiugQA8CRyvfHnBL5DV/oDJ/wj5
 m1qZ9hbpHIPXxeC/lN1wyPTe21DgzbB9nRgBf08Vxupxmsq0LyNzz0TM4HSzV1DiBAF6
 k4Y5c/5bN7YFSq1fjgoVhf1GvbtdlWNjMmilyWeTXRWNVoFbasjPOzU9DolJYKJGm6pP
 JSEXSSPUe+H2XSVSpWGyPVVyZNGnP0r6zHIRbXBZpxLGbkp3dUKsIJL9Y52Nhe0zhfAH Bg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2043.outbound.protection.outlook.com [104.47.26.43])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3efefrshn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 10:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB7RZ5ZdQHERvEleyZcfWgiWGDXnlj3OcT3DTN0Em/lcLqu5VLu6AKIoLIwq/4ZmMeqe1qlypuIxRQbhdohIE3wmxLfrcXsEw3eIkRJA8ksLvLKtYY4YmqESG6akTzKy7/UWyzcB0cJ9W7SOd4V+FUiuGyYzIz0922F9Bp4j2isSXNLqeUZwf7m1fwn51NLXhJ/pBnugo3hnqiin7XHPM8hH2YVadB9rqhJnzLL417U9ZgcKtC3VZe6fa9rHvYf19jaeAi497hyv/RSE8c3GvDeSEdekcPmboqRDK2kRh+5DtAqgIy0dMAQlyl2x4fYAsdomsxokLBBm5T67iAJ1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB+lZCeGR9GxazSq5uhX56nbMsCg+RM8thPPcY4Me+8=;
 b=n4X517jOXP7YYNkdlSa4pFBcoxN7+6d5SLoaqos93+Q9D3ZfJyzdcXtJw2NgwCjjiPQ5Dupkz9rz3c3ACGmxjgGqPrj4lqPdZoIpZsVpIrR+clEavoql9ve/7ULvitmo8swQ/2tW+aN/shxry9QQYTYswHQe/9fP3+ws8JeTguiOmF3ar7HHnkJkVDjq80BEjnkHyqhLU1dKSUBvREEEO0oZ1qW7e8b5yS47ozZNUxNtMNcHnxeqtLNkKM5SIvLikPA2JQAsVK/e2nyq6pH+2i4jciczg7wEgSWg1W9BOciRJVWs01Wje+uNhdQB+mCwqFKh8MtBZNsDjWV4Px55IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB4511.apcprd04.prod.outlook.com (2603:1096:400:5a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 10:51:54 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::98b0:9ef4:57f2:c045]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::98b0:9ef4:57f2:c045%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 10:51:54 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayoqY+AgAA/KGA=
Date:   Mon, 28 Feb 2022 10:51:54 +0000
Message-ID: <HK2PR04MB3891B4F1C2BC707582E81C0C81019@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353E089F4843C6CE6A0BA1E90019@TYAPR01MB5353.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB5353E089F4843C6CE6A0BA1E90019@TYAPR01MB5353.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72fb6db1-379b-454b-76ab-08d9faa85585
x-ms-traffictypediagnostic: TYZPR04MB4511:EE_
x-microsoft-antispam-prvs: <TYZPR04MB4511B9DFCA7634A2083E973781019@TYZPR04MB4511.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXRArqCwMTkOZHimMEdhYRHRPh9oKkHiVlxhu3kzYd9+DnsIylZQjn6hnBwjNCWJyOB9Q/x419slb1755DE+9WXbJbW/h8tHliuWKG5SI3aK2hQ+HPIT2e0aTYFzqRJWYNYlGQlxTo+g/w1lm+qf7eHPO5aPiaqCZU6rGfQJwMKOLXPez2TRRxqWIUw2hlUBFC/vRY+5U/IbuR89PqwO+/nisix3i/Vj3e+BO0HAqoKxzP2J2EZUlUB5n4O2tvRRFHhrOnX/VIV40OrYggzOpV10EC8GZYAv4EKIq2+ZdXV3pEVr2ByGtpWta4sj2XJvst9GinonADPBFv+5pSSG+o5kAhG7rOCU4KHOkQgS89srvPvxbzxoo3yQ3ND3CGU2huE8zc+YL5PCxXiFZmcQjs+7AkaEO7pG87E/epQ8mADGnz334iAqm5bd40TR5GOTrlDnBSz9DyFC3wMTdhN8/XfuTQmEPzsTbTZX+Q30MfK2kdfBx5XOeeuSdakEIQiT3ko90gP6FyWGpVft+C34QIxoBLE9iS/aTwnB4GKrrUHhens3QU7f+TJ5TP5UjAah/sltvNrsvUt8wPlPL4HJyoa1jU3gNNCmE6a6aQDmWr69Y8jJtnuXkBQICE6Bg6zZX2QAYn2jr7OtTIPGJZTnrPmtdMEQQmpdNi1H0qoZlc5Iln4M9WsP0s+2Z+WsEdzqrvmE7v3RSAIF/CckkGkWRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(33656002)(122000001)(38070700005)(82960400001)(86362001)(38100700002)(2906002)(76116006)(66946007)(64756008)(8676002)(66446008)(8936002)(66476007)(52536014)(4326008)(66556008)(186003)(26005)(110136005)(83380400001)(54906003)(71200400001)(508600001)(9686003)(7696005)(6506007)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFNjcXZ1bUcxMmY1OWJJaWU3R0U1Z0tFTXkwY0E4MG1QNHluMkdrU0dSa0VX?=
 =?utf-8?B?c1piM1lKVzZSQkNrSTYrYlBCRjQvTEVUZGVtTWd5TDlPOGppWlhVSlo1aWVx?=
 =?utf-8?B?N1ZVWEI4S1FDTTlmdnpLLzRBdVZ5eHN2cXphY1krTG0xUzdZZEQxTmdmci9n?=
 =?utf-8?B?ZmRva3crcFFjb0ZXUnB2Nk1CK1JoUXVCMXFjbUlZZ1M4OEZnV0ZxeDBsZVEw?=
 =?utf-8?B?TWRyM1d2MEZQNFBJa1ZBWmFlTnFPUWxQQ1ZtNEc3S0M0Vy83R1dzRlBRRHlQ?=
 =?utf-8?B?U1RpLy9sRHVGQTZvbWJibnB0RVZXWkxobDk5TmJLREEzQVJsR3JqeHY1Y3ls?=
 =?utf-8?B?YjJCTXJ6VEhlUHIrZXNuQXdyc0lJRmdFN3d6S24zNHNTWlJFOTN4SnZIMnov?=
 =?utf-8?B?SnRMYUk2L2NEcHMzSGlOckwyeXJ1OFFUMFJKd3A1RnZVZ1JGdWZ2WnU3bUZU?=
 =?utf-8?B?QVpRaStLTHd1djdNVDNLWDJyTVBiVTFyNjNITWRWN0RteHdTMHFTVFZORmdI?=
 =?utf-8?B?cjhjS0xjdTRvLzRLYjVLRDA5cElMQzJIT1NTcy9tcGFBK3hHdEtERmdmZEVm?=
 =?utf-8?B?blVKUjVLTU5XbDB3TjkzMFpWeDJYKzFHcEd2bWZqQ3g4eXBDc09mSmZmRFVD?=
 =?utf-8?B?TW9rK3dKSC9SM2FXZ2ZQSGJjU25vZmlUNEJMazdIa2llbDNuUHVlT21pQUJX?=
 =?utf-8?B?N01hYWlJQXFWVjVMVEloODhHdCtUZXdNOEtnbHI3MGxnTlU4VU8rcU9WZndB?=
 =?utf-8?B?bXZEaXRYRzZHT3p4YmRQV2JxTVhSL0I1U1Znckt1b1NxNjNKVHFJazZyVmFV?=
 =?utf-8?B?eWo4QW52M255UW5Zb3pQZlhrUUpWS2hmYkhQMTIxSFIrY3V3QUFjQTF6aVNl?=
 =?utf-8?B?KzdaTzVrdzJyV0xlUW5OYVdqRlUzUDJXcEcwUVNXZTQ3QStienRvSUZacjY2?=
 =?utf-8?B?Qlk2a2FwOWFrZk5DbVRKVVhBV1JlaFVZNnVucitzamVMbFdEUkZuaXRBcEt1?=
 =?utf-8?B?Umc0WUo2MTVVd2hYeWwvRFhKVW1vaUlpc3A1bkIrVHFSRnZvK2t2cCt0dEU0?=
 =?utf-8?B?OUdXZTZ6dm5TNmhyVTQ3ZTRVWWVkN0VpRVlSZkpId3FXTStCalVtV2JDdHZG?=
 =?utf-8?B?MTdyRDBNbVAwNWk5S1dJUmpJcWQvdTlVTVVZQ0VmMHQyc2lnZXJKUGVTVzF1?=
 =?utf-8?B?dFp4OE9Pbk1VbHNjM002Q21CVXNIYXdUSVB3WE9pMVpUejVwditVOWd2RlAw?=
 =?utf-8?B?Q3lzaTd2SFlQNjV0MGN0V2c0Z0dSd0I1YURZZ1RFSTZ3SllkTnVvd1YraUpn?=
 =?utf-8?B?dmVOYW4vUE1JV3dZMXRmVlVVYTFkRFUzMkdYQmpic2JmYmJTQWZLbnZvR0o1?=
 =?utf-8?B?T3g4dkN0WVM1NFByTnozdnlYTmNKRi9IQW5QRkI5S2grVzJjV2pZdXlSNHBU?=
 =?utf-8?B?QUVGNFQ5dkkzTi9MN1gzMHJwZVpUUkx4blFWeXFEUU9oejIwNllDV0VMaGow?=
 =?utf-8?B?Ly9yWWc2aGUrYkJYVDVLamZ3aVN3WnJQNmNCQm8wQnQrbU0zN1BFQTFNa1ZP?=
 =?utf-8?B?YXFwbFR5ZkpFSVpYdk9rSWdPL2Qxbm1CdVlXMWFnc0p4VzFrY09iWjJqNVZx?=
 =?utf-8?B?L2dITnB1OWVIU2xZbi9sN3RwK0RIV0wrN3o1ZE9XbENZbytTQ3J3RFRrOUdF?=
 =?utf-8?B?aGcvSXI1aTJyYVVlSHRWOTZEM2EveDQ3UHBDdDkrSXpicHIra1c3MzVicGh6?=
 =?utf-8?B?UkNRNTk1dDVHU3BSTTU3TFBOdDljamJrZFVwbHNRWGNLVVhFMXpxWERhemdE?=
 =?utf-8?B?WVZQWG45Z29IaXVMTzNyczdpMW1ydjVXS25yYlZidEZMMDNCRmt4TmVXeXVT?=
 =?utf-8?B?UGlxSlNoVno3VWRFL21sRkZ5clVmSHBPZEVOdnhwMVBicEVnS3puSHEweGFF?=
 =?utf-8?B?OXFrZzZRS0V3S2FIWVNaaDAzMnVuVkd4MGYzZXpqNDYzemJHbFhtRVRSVEhv?=
 =?utf-8?B?STBScGNhL2srLzZ1OWRZdVd3d1lUN2E2KzNGVG95NTAwU01sVU13NjE4Vlk1?=
 =?utf-8?B?aW90a0lRcTAxelMzTSsyZEpTMHFlN05KNnJBQ1hBYW5mS0h3TWlRSk81OUNo?=
 =?utf-8?B?R1NJcUtTZE9oY1QrNHd1MEZFUzZyczdVWnJCSWR3d1gxbkhHbnJHYkQwQ2ZC?=
 =?utf-8?Q?BSRjO6gR12Dz9zvHk7dDZJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fb6db1-379b-454b-76ab-08d9faa85585
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 10:51:54.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vb0qUPmVfEFqjZFTMv38D0GFOXCT0mCBY18fVXVO1dgJZyalVaWuXkIChnmkElOS6mkNMWGO7yD8CMZuEqm+WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4511
X-Proofpoint-ORIG-GUID: 7_UOlu37D2ZVFKwGuJw89ekhHGBFeGng
X-Proofpoint-GUID: 7_UOlu37D2ZVFKwGuJw89ekhHGBFeGng
X-Sony-Outbound-GUID: 7_UOlu37D2ZVFKwGuJw89ekhHGBFeGng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_04,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 adultscore=0 mlxlogscore=989 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280062
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIEtvaGFkYS5UZXRzdWhpcm8uDQoNClRoYW5rIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+PiBB
bmQgVm9sdW1lRGlydHkgd2lsbCBiZSBzZXQgYWdhaW4gd2hlbiB1cGRhdGluZyB0aGUgcGFyZW50
IGRpcmVjdG9yeS4gDQo+PiBJdCBtZWFucyB0aGF0IEJvb3RTZWN0b3Igd2lsbCBiZSB3cml0dGVu
IHR3aWNlIGluIGVhY2ggd3JpdGViYWNrLCB0aGF0IHdpbGwgc2hvcnRlbiB0aGUgbGlmZSBvZiB0
aGUgZGV2aWNlLg0KPiANCj4gSSBoYXZlIHRoZSBzYW1lIGNvbmNlcm4uDQo+IEZyb20gYSBsaWZl
c3BhbiBwb2ludCBvZiB2aWV3LCB3ZSBzaG91bGQgcHJvYmFibHkgY2xlYXIgZGlydHkgd2l0aCBq
dXN0IHN5bmNfZnMoKS4NCg0KSWYgaXQgaXMgYWNjZXB0YWJsZSBmb3IgVm9sdW1lRGlydHkgdG8g
cmVtYWluIGRpcnR5IGFmdGVyIGFsbCB1cGRhdGVzIGFyZSBjb21wbGV0ZSwgSSB0aGluayBpdCBp
cyBhIGdvb2QgaWRlYS4NCihQUzogVGhlIG9yaWdpbmFsIGxvZ2ljIGlzIHRvIGNsZWFyIFZvbHVt
ZURpcnR5IGFmdGVyIEJpdE1hcCwgRkFUIGFuZCBkaXJlY3RvcnkgZW50cmllcyBhcmUgdXBkYXRl
ZC4pDQoNCj4+ICAJc3luY19ibG9ja2RldihzYi0+c19iZGV2KTsNCj4+IC0JaWYgKGV4ZmF0X2Ns
ZWFyX3ZvbHVtZV9kaXJ0eShzYikpDQo+PiArCWlmIChfX2V4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0
eShzYikpDQo+IA0KPiBJZiBTQl9TWU5DSFJPTk9VUyBvciBTQl9ESVJTWU5DIGlzIG5vdCBwcmVz
ZW50LCBpc24ndCBkaXJ0eSBjbGVhcmVkPw0KDQpXaXRoIHRoaXMgcGF0Y2gsIGV4ZmF0X2NsZWFy
X3ZvbHVtZV9kaXJ0eSgpIHdpbGwgbm90IGNsZWFyIFZvbHVtZURpcnR5IGlmIFNCX1NZTkNIUk9O
T1VTIG9yIFNCX0RJUlNZTkMgaXMgbm90IHByZXNlbnQsIGFuZCBfX2V4ZmF0X2NsZWFyX3ZvbHVt
ZV9kaXJ0eSgpIHdpbGwgY2xlYXIgVm9sdW1lRGlydHkgdW5jb25kaXRpb25hbGx5Lg0KDQo+PiAr
aW50IGV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKSB7DQo+
PiArCWlmIChzYi0+c19mbGFncyAmIChTQl9TWU5DSFJPTk9VUyB8IFNCX0RJUlNZTkMpKQ0KPj4g
KwkJcmV0dXJuIF9fZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNiKTsNCj4gDQo+IEV2ZW4gd2hl
biBvbmx5IG9uZSBvZiBTQiBvciBESVIgaXMgc3luY2VkLCBkaXJ0eSB3aWxsIGJlIGNsZWFyZWQu
DQo+IElzbid0IGl0IG5lY2Vzc2FyeSB0byBoYXZlIGJvdGggU0JfU1lOQ0hST05PVVMgYW5kIFNC
X0RJUlNZTkM/DQoNClZvbHVtZURpcnR5IHdpbGwgYmUgY2xlYXJlZCBpZiBvbmUgb2YgU0JfU1lO
Q0hST05PVVMgYW5kIFNCX0RJUlNZTkMgaXMgc2V0Lg0KVGhlIGNvbmRpdGlvbiBvZiAoc2ItPnNf
ZmxhZ3MgJiAoU0JfU1lOQ0hST05PVVMgfCBTQl9ESVJTWU5DKSkgaXMgZXhhY3RseSB0aGF0Lg0K
DQo+IEFuZCwgSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdXNlIElTX1NZTkMgb3IgSVNf
RElSU1lOQyBtYWNybyBoZXJlLg0KDQpJZiB1c2UgSVNfU1lOQyBvciBJU19ESVJTWU5DLCB3ZSBz
aG91bGQgcGFzcyBgaW5vZGVgIGFzIGFuIGFyZ3VtZW50LCBpdCB3aWxsIGJlIGEgYmlnIGNoYW5n
ZSBmb3IgY29kZS4NCkFuZCBpZiBvcGVuIGEgZmlsZSB3aXRoIE9fU1lOQywgSVNfRElSU1lOQyBh
bmQgSVNfU1lOQyB3aWxsIGJlIHRydWUsIFZvbHVtZURpcnR5IHdpbGwgYmUgY2xlYXJlZC4gDQpT
byBJIHRoaW5rIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gdXNlIElTX0RJUlNZTkMgYW5kIElTX1NZ
TkMuDQoNCkJlc3QgUmVnYXJkcywNCll1ZXpoYW5nLE1vDQo=
