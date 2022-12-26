Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDDB6560BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 08:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiLZHX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 02:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZHX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:23:58 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7972DDA;
        Sun, 25 Dec 2022 23:23:55 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQ5jskX031801;
        Mon, 26 Dec 2022 07:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=5V90Y5iO0rPnnAT0Gqah7F4YF/76PfwXWTuYIIGcKJo=;
 b=ibxsQ9mMXdHPRXYzetCR4OLfsp5yV8E4L8yFLjq64nRVx3xnVWhMpfoZ9meM+7L4A2Zs
 r6DECjK3jb02mz12DkfsLtFmLHoXPpzfVpwYLJN7OdutPQeyjpUfiYpuqorkzhBg+ytG
 o/uZFKjawzIrtLz0kSBdwd3Hsw4ZQ8RuW7ZKP95S/BTSuu8+H9Y+ZxfOa6nGdGPLMLRA
 n/eP0kmksDovoaYQaTLe45vDYSy+jRFQoFfgzE0sozP9UanYlWIiaQk78TEv/D2FGD6A
 Vfn9sLky8vQ8vE+jNaGfmMxhlvmn4TqttydQO1gl/KUG0HgQDLFx27OunCMNWZkMWCaR ow== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mnqamshtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Dec 2022 07:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsoY09w5+429+md9wks6LMmBw8kxfonG/tcWfCkTkbmUH7gKCgNGEGZDKDPtXkemfDpwDKfnmZibHDOfKpUBVyaMXazLU4IsuN4LJcWt9rkt5GgpEa1urBmWJMgmRhfYf4b38QGX1LHBFKDKjUVNK03yZM3LV5NICbJ647+GZRqshzstC9KbTbTg8K0SRbK5f4AJqQgqJ/GMQSDkscKDG/mo2/u89vydKE4jLkn5L9mTxJgllGv/V3fYK3DtrZXJirV8nclQR2S2tAdC5LOqjHEPja0NOX+XeoypGIq7sQfJP/zQV6JgGfti5Smg9DYenhKhcdIo+Vp0v1MIC/r5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V90Y5iO0rPnnAT0Gqah7F4YF/76PfwXWTuYIIGcKJo=;
 b=RjGphPow5rnaCnuFt5a1HY1zWlYhxmSmUIBbPDn4VKJkLsY67/6jPn9yJXRgosqrfgluldtn8tH9duNovzfQun8n7Xxr8qtpFtSEKt+pe32NAYQJCmeLcOHBG2PV96YFcg7QY7ophs8AEET5OgdmikfSnPvGM3R06JyBIavw5qNbW1tzDRVGj+ViLe6/xNVGCgW+RGlBNSiBFJ9CIJYgi4oB14ZBod0QPjLMNOOgNPuzwx57PmhY2rXcK4jKFiaHM7YJBUWXj/pUdkB8GRP1XCbI9Yyr/fPg3IUkXnGhuD0SW7PQGQ7ad/EIELBDPeRUH535Lq7jDKi/ikNBjUW3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4377.apcprd04.prod.outlook.com (2603:1096:4:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.15; Mon, 26 Dec
 2022 07:23:30 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%7]) with mapi id 15.20.5944.006; Mon, 26 Dec 2022
 07:23:30 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: fix reporting fs error when reading dir beyond EOF
Thread-Topic: [PATCH v1] exfat: fix reporting fs error when reading dir beyond
 EOF
Thread-Index: AdkY+qIINYyntsrGSEaOLoPl+jzKaQ==
Date:   Mon, 26 Dec 2022 07:23:29 +0000
Message-ID: <PUZPR04MB6316579893496BC54C4FE96F81EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4377:EE_
x-ms-office365-filtering-correlation-id: 4810ee06-88a2-483c-4b9f-08dae712168f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: it+6dP6K5xJgH9OgCY2JyU8JH9v834WB9+SsdN45W7YuwFHhbNUHKldp+SF74Wwz0UVrS/JaDIaNQR//jJWDXdjI1ciKk+44XxTP+nnUSz0aChbGWkzZBtPXTgofeL8VMd6lCC06ex9YAhRc6EsqxTYuoOuleruqZZcdQtj3yKQhc+BoLFKsCXMcQNrFFYJU9lsNsJyVnS4aChfissqUo5fHHlbp76kvtKXsP01oCno4Xpm/58r6XfvCsL7FWZbbrfJQHMviNOtquaj5IrPOu3PpGgaKJO5N2sWe3882nFOt34ryhZp/XBPWWkaGDxe/RIVi3N1jKjmm2nLxR7eK3jYTKOJ73NGyaLXLzrVD0jby0ozV4A4wVzg/JRWWZqOjqd3Kca1vbSaI5LU3757YUGge2/8GC6XG157JFuWyghK13S8IzAbIwFMIu+6WyD/Xbnh7zj46kgHIRwF1J6BCuPgfUaFtuQ0ePXbSZZ8a2e/vJbUmUWzFvEH/SoBpEHWHgUUxlwUvFp1SUejVcL+J5aI6DIiSXnhtTZyDdCaV7WPb2nqbR8YNG86EUbais+nOdWJDGAs0qhdpNNjxJToPoNUpw77sJ6gc0uJSJwJaelXTtV+mnRsdu5iZ8foDySGTj9jKEte4zdstKjnBnNWqYBZDbZRtGXB/T1Oc/wi5ND0GHe5PcrVpGSDWc9S4VlOruE/oy06v5erspGjQi4GbvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(54906003)(110136005)(83380400001)(2906002)(33656002)(7696005)(316002)(38070700005)(107886003)(478600001)(82960400001)(186003)(122000001)(38100700002)(9686003)(6506007)(26005)(71200400001)(55016003)(86362001)(66946007)(66556008)(66476007)(52536014)(76116006)(41300700001)(4326008)(8676002)(8936002)(66446008)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3NRbUI1a0dEVEhMSllLL2o2NmdUMnUvQVVUTEtuSEVoWXk2VkUybWxXSVZ3?=
 =?utf-8?B?RWlHS0E5enUzWlF2dTNXNjBFZTVoS0FoMXZSTFdDODVEaFdSdU5oNWRXMHBI?=
 =?utf-8?B?SEs0WWRLQS9xZmhhL1FsSUlEUkNxYzFsUCtxUWg3bXkraUtaZXY5M0o3UEc2?=
 =?utf-8?B?VTRZZkY0dTJ0MzQ3MTM2dWtmbHVkbzJXck5lYWsvLysxa1NPV1d2aVVFUFc2?=
 =?utf-8?B?RTFVY1A1OEViUVRrR3hKS3RsVHBPMVJwZ3lXYTkzM0NFQlVXTitaWlFnbTdP?=
 =?utf-8?B?MTZacDZ3U2paVWNtbU1vK0dsQkhoeHA2TTFBUnY2QlhYM0VvL0xFVHhYb1My?=
 =?utf-8?B?UTVQM1l6SXdtcFh6TXJOdTBOMERSUkdZRFlzb2c1aGp1WnFEcSt4N3RqWDZl?=
 =?utf-8?B?OG1zeUtyQjlmM3l3Z1dOT0lCSWJRcWg0OTIzVU5XWFRYbFVPbDFGTUJjWkhW?=
 =?utf-8?B?TEJidXNPZlE3cUdoTnRCY21uV0VrQjhaSU1sT3M4VnFrZFVSWEV6eEY2eEVW?=
 =?utf-8?B?VjZ0L2JYOCtwaE5BV0JsNC9vSHg1N3lJTWVhTkw3aFdudW1RbjQ5QnhPUFIy?=
 =?utf-8?B?aHVtdVA2QzluOGRGWlRFVExlWWZsbHNNMWZSYUpvZTRUb1d6ZUN6Z2VZbGI2?=
 =?utf-8?B?MkZoQlB3elp0RGJQbzFYS05VRWZhZm0xbStaK3UzSlI0SncyTEMzS3Azb0E3?=
 =?utf-8?B?cFIyQWdoa2FxN3RCMUkyK2F1aHBwY01kNnpHSjhDYTRxeGl3Y2cxMDBEai9q?=
 =?utf-8?B?RGdpZm1DUnFXS1Z1dHFDNjY3ZDRuN2V0Q2VZUkRyNXNsemMyOW11b2JWOC9v?=
 =?utf-8?B?NWNyNmtyU01oamJmVVZrakRwaGxvT28xTGNoMWlVamFhOE1VeVpLaXJiZElL?=
 =?utf-8?B?ZmFIQXJteFFsOGpFT0FrM0VCZXVBdDFvWmpXWjlNekVKYlJ6L29BeVBxZ3hN?=
 =?utf-8?B?OHBmTUFCclBxWWlhUlMxU2pnemtiSkppbFB5aUhyMmdxd0RpdlQ1ZGFTQ2t5?=
 =?utf-8?B?bktjRUlCa2NqNVdCdXpMVW1pNzBpK0F1VlZJV0pLdEdjZHJqMXBEdTk0YmFU?=
 =?utf-8?B?YVdrU084YjNCdUhWVXJVK3ZXVTJrSlNJNXJmWjBYQ1hZN0pmVmZyckRmanZs?=
 =?utf-8?B?bmhnTkQyMC90KzMrMXpQUHBwU3FSL1oyVEJHK1ZsY3pqM1Y1dWJySHo3bndx?=
 =?utf-8?B?YjIrMlVVcTZOaGE0VVJaVElDWFI2VHFHZnI1MnkvNUFFMThWbWlYRWZBejFY?=
 =?utf-8?B?cThSZzdhckppS2RaKzJVa3FIeWQ2MS93TFV2bXlkUzBvSWt6c0N4SkwwSGhC?=
 =?utf-8?B?OEdubTd4cFR0K0FSTStyRENzd3ZCSlBtSDhaYWV4SG0yZFpUOVpZNHpSWEh0?=
 =?utf-8?B?aU1OVHZXc3lUNmJkU0h1eTNiVTlhUzN3ZVNjTFRZVVltZEY4SXVXREVhY1hy?=
 =?utf-8?B?ek5RZml0RUszWjM0SGZuUXZUdDFWdk1jSDlyT1NzVEVGQUx0TDM4UFJZOG01?=
 =?utf-8?B?RlJDcWxONVFUeUM4TDgvZ3cybE12SkJFRmlLa1M3dVp5bVJYSDYyZUQvYkxY?=
 =?utf-8?B?cWhBT3pmTVA1R09zbGFGZzJIek1yZERLZzBGNzd0UHBRZXMrSzk0QkNDVUlM?=
 =?utf-8?B?ejN6aXVFUno5Z3h2SjgwSmRBNE1IeXN2dVI0bHhWdm00RFhZdTVWb21lWUs3?=
 =?utf-8?B?NE9LOEdmMlp0NlBONjQwbEFsandSMlRvdm15cEViT01vUkJ2UGJ1Q2RXT0hV?=
 =?utf-8?B?NDBBeGwvSUNUQk9PdFJyQVZWcGJoTExMQlBvZVRIUE1FdHZHNkM0ZGI0UC8w?=
 =?utf-8?B?ZVRUa2RqQVVleEJlVGE4d0RibEs3Tk9lcnNhL0s1cXMwS3F6MldWOFlSM0ho?=
 =?utf-8?B?M3RNR3NBakJURyt3SVVFMkIxNmRrOG1FVkNjQzMwRU1PWUxsNk9kYWJxQWFz?=
 =?utf-8?B?RkFVUzBrQk52QXNGY1hUWjkxT3NOVEpFL0pJNW5zRHdmNWFLWHJETzlWdFFo?=
 =?utf-8?B?NXdtcU5SR1I0Mm1UTjB3Q3dtdndJKzF2d2hnRzQxNUFTMGZheTJabGJKb3l1?=
 =?utf-8?B?NnFCK3BzeXZKRTNZdlpVbC9sS0l0UENGUzR5QW9idTFWcmdKRE1ORzBPQWJB?=
 =?utf-8?Q?e25jcXswXI6RHEd3Ew+YGG+eH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4810ee06-88a2-483c-4b9f-08dae712168f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2022 07:23:29.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYHAdsOLU+PXIlpFAy8Eu63j/fqlqinNLKQDqOHdp2kD0Uarzgg4bWVAW5EM/vzbxABQnYE/8U4QPQwY+N+evg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4377
X-Proofpoint-GUID: 2cg_ezbUyyPGJzji1hXjefePGWWgXQSE
X-Proofpoint-ORIG-GUID: 2cg_ezbUyyPGJzji1hXjefePGWWgXQSE
X-Sony-Outbound-GUID: 2cg_ezbUyyPGJzji1hXjefePGWWgXQSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_04,2022-12-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2Ugc2Vla2RpcigpIGRvZXMgbm90IGNoZWNrIHdoZXRoZXIgdGhlIHBvc2l0aW9uIGlzIHZh
bGlkLCB0aGUNCnBvc2l0aW9uIG1heSBleGNlZWQgdGhlIHNpemUgb2YgdGhlIGRpcmVjdG9yeS4g
V2UgZm91bmQgdGhhdCBmb3INCmEgZGlyZWN0b3J5IHdpdGggZGlzY29udGludW91cyBjbHVzdGVy
cywgaWYgdGhlIHBvc2l0aW9uIGV4Y2VlZHMNCnRoZSBzaXplIG9mIHRoZSBkaXJlY3RvcnkgYW5k
IHRoZSBleGNlc3Mgc2l6ZSBpcyBncmVhdGVyIHRoYW4gb3INCmVxdWFsIHRvIHRoZSBjbHVzdGVy
IHNpemUsIGV4ZmF0X3JlYWRkaXIoKSB3aWxsIHJldHVybiAtRUlPLA0KY2F1c2luZyBhIGZpbGUg
c3lzdGVtIGVycm9yIGFuZCBtYWtpbmcgdGhlIGZpbGUgc3lzdGVtIHVuYXZhaWxhYmxlLg0KDQpS
ZXByb2R1Y2UgdGhpcyBidWcgYnk6DQoNCnNlZWtkaXIoZGlyLCBkaXJfc2l6ZSArIGNsdXN0ZXJf
c2l6ZSk7DQpkaXJlbnQgPSByZWFkZGlyKGRpcik7DQoNClRoZSBmb2xsb3dpbmcgbG9nIHdpbGwg
YmUgcHJpbnRlZCBpZiBtb3VudCB3aXRoICdlcnJvcnM9cmVtb3VudC1ybycuDQoNClsxMTE2Ni43
MTI4OTZdIGV4RkFULWZzIChzZGIxKTogZXJyb3IsIGludmFsaWQgYWNjZXNzIHRvIEZBVCAoZW50
cnkgMHhmZmZmZmZmZikNClsxMTE2Ni43MTI5MDVdIGV4RkFULWZzIChzZGIxKTogRmlsZXN5c3Rl
bSBoYXMgYmVlbiBzZXQgcmVhZC1vbmx5DQoNCkZpeGVzOiAxZTU2NTRkZTBmNTEgKCJleGZhdDog
aGFuZGxlIHdyb25nIHN0cmVhbSBlbnRyeSBzaXplIGluIGV4ZmF0X3JlYWRkaXIoKSIpDQoNClNp
Z25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2Vk
LWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRh
cnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IDExMjJiZWUzYjYz
NC4uMTU4NDI3ZTgxMjRlIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4
ZmF0L2Rpci5jDQpAQCAtMTAwLDcgKzEwMCw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfcmVhZGRpcihz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgKmNwb3MsIHN0cnVjdCBleGZhdF9kaXJfZW50DQog
CQkJY2x1LmRpciA9IGVpLT5oaW50X2JtYXAuY2x1Ow0KIAkJfQ0KIA0KLQkJd2hpbGUgKGNsdV9v
ZmZzZXQgPiAwKSB7DQorCQl3aGlsZSAoY2x1X29mZnNldCA+IDAgJiYgY2x1LmRpciAhPSBFWEZB
VF9FT0ZfQ0xVU1RFUikgew0KIAkJCWlmIChleGZhdF9nZXRfbmV4dF9jbHVzdGVyKHNiLCAmKGNs
dS5kaXIpKSkNCiAJCQkJcmV0dXJuIC1FSU87DQogDQotLSANCjIuMjUuMQ0KDQo=
