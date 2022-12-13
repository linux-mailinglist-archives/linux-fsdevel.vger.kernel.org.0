Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492664ADCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiLMCi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiLMCiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:38:02 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5B1E71A;
        Mon, 12 Dec 2022 18:37:15 -0800 (PST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD1YF56012328;
        Tue, 13 Dec 2022 02:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=RsWUC/zRObHxOPv1FlIyfmC6cM7JQtBg9nKz/ys/nhI=;
 b=niFKY06E1GJGkcqp289P1A32iG3N6xiTzUsHx1Kd5JfOiW1MNfTFaAs9ZK2ZmyNpu+TN
 i1xJrP4dX0o0fNO2hVr4Ov2l6U8NKP2PsKl87uBa6Xii1S9WzAAOgDJaBTYaTcGjz2VY
 J3H+rXN5zh5P6e4pZ+GeQofeXpYafy46LMalyNkddcrEABkmQ9o9+jpVDxkItWTyw8EU
 OJFLdJOq9LQHbj3b8Q87tlZD9lrXZj77ac/O230Obh34GAEulGNMhfsTnP3m4rWbnFTI
 b13O1PZ4BAw1Cjq3BNjByt09CgLoWHqCVxpDG6PCAmGwJwm5FBn7NMaYRZZ+Kjhhp1FY pg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcgw7th26-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C647pOu+Zt9x27LqMS3/PkkHOaxVTUWWlhM0bOIsfOj3YCM8ly6KEjHXV+6Pl7ziiDknEcbmnXBjBtlTMAnhddTZEdLC/Wg8gYcBhZ3VA5W3nH4TDA7rCD7v7Rdqnoz3tmZaPxF97uxPFQUtC1lB6WFicwg8IcqoVbX/ZgVSvCS5dX9oVMjNvtpXFviLgZF3CHylg4k0TyVppkQdkZSRlgcUhGIqcOtEFOPg1BQv/r+rkxqvgbRBGDOKWvQcryF+BSNhbiD1SPpzTKmiIdLzbz96srk1BmKGrqbJMFcoXwfuHClxc0eWpBf1418SHVSnaKUobHj5FWI9/Nm8dO7LCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsWUC/zRObHxOPv1FlIyfmC6cM7JQtBg9nKz/ys/nhI=;
 b=CD9bYMM87tQuvmXDId/SOAz67odRjVmJGTE9k3lR6XJG/DuvcR5zy1AS+wjRofNTtlZx4O4x1+e6noy4peYn25kAXe9hZNbFqfocjuP4yPRa0MWtYTZv5SvLtUz8EZEuxO6vyD2+cKdac+A+8GTWrrLm7fC3a2K172DVgrUYvUICJY5X8ZYKScqzZ3IgzHSavXmIN9OpULfdPxmRpP2HO56YyZCLRdIEK6t5PHGvPEGc8aAxh1Fx56bYtRue9VDY1Hq0BPL6/ZEtRdcVz1ONu+suWNtsqFHZWVD94meM4iGGqZ95lhzeLRgwqBUhs9HDf6/zsC5+MvP3OMaoU5kC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:36:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:36:59 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 3/7] exfat: remove unnecessary arguments from
 exfat_find_dir_entry()
Thread-Topic: [PATCH v2 3/7] exfat: remove unnecessary arguments from
 exfat_find_dir_entry()
Thread-Index: AdkOmduhIQbmVfGOQoO6mEOmIBBoRg==
Date:   Tue, 13 Dec 2022 02:36:59 +0000
Message-ID: <PUZPR04MB63165C5B62A6672892ACC06881E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: 781109f2-7eb1-41cb-4ab1-08dadcb2e8d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzYQNyXSBcYGgIJKihKtBrLhktBEn7lM08KIjNQYqH4hXRMkIn/aqWlYUtTlUNPxvts5BSYlq+r2aC4mjBhRmLQQRlUG20rxsAPgjDIUvn+C7H5rn32mj3ftAVXnxFdGsp6U5YwfbxwfQu4WSOyPLdIUanHm3eYowQjeBx/gDfwEKz9cSRUJUAIc5yXSjbmA5SWGbsWcTYdneKQnsI4uwnQ3RdQ1o9k54ItyVMBFoFwPALeX1qQwxCDvSSj8jVk6YFsr2lXc/4hLw04YkA7Mml3Cxd6R5FZ9eQ4TDcwRjjx8ahFtUCAJ/ZbReuSc7XKWF+VkND+lnQf3x7sY3CUTpOTnPXXKFkUrCp/F0l6qU0PwQA6/DqddVA7TPMA2mAkcZafElWA9gL+HnBRK5DXS7CLPhKWGfFgP1GT/X8/3RD8go7mus00itNz7MAozBKjZYPASn82i7cTmJp99C5pFVmvwbie4Nxg7v3tF3BrLREO9QxO8HI6kvx/iARKB3vNpgZa72+Ywfs1W4anLrlXlF/yLRtAcPVs4YP5I9uskAuccHRs3gBc1n9sxJXFZRf97i8WzEXLXQ1ubWuxmKbD6KKI1D1skHZjyPhSVoguanvCuS7XDPAkCnb1d5j9nof4+1weS/p6A4GCluj8arpdZfWomJ7K7tCh4e4pc1CgsoFRne07x2MBJC3XdDJnHg9aghpTL+lboa78zHoy1UI4iHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTByejdyQVV2MWxVYmtDdGJRM0NhT2R3NndQdlJ5Uy82dXd1cGpQNHRHUE9r?=
 =?utf-8?B?bnZiOVpoMndtZHR6UG9CS29FeFRObkdsQUxaNUdyUURKelV6bUVwbGtmb255?=
 =?utf-8?B?a2crTFprVTVFUGdvMkNDdmJuellaQXhjN1ZXTHoxZVluQjJRVVdmT0g5MGts?=
 =?utf-8?B?MlZSVTRKU3crUk5EZHVhRzF3R1RXM0MyME5Qa3dnQ3F6dlYzU3duOEx6RTU3?=
 =?utf-8?B?YmhKb2JYZmpNdSttVjVYNXVVaTJGZlA2b0FHWTMvOHl4TmVEaFdDNHl6NWQ1?=
 =?utf-8?B?VlIya3hWQytmMXhZOTFFVWxjbDdxMW5KVGZVQ2ljbHZOZzliTzEwWUM2dUJP?=
 =?utf-8?B?UmlrZVdBQStEY1ZPSTRvMXVXVGd5Q3VRb2F5UGx1Sk5zRHRDMjRQWW5mUmF2?=
 =?utf-8?B?RFVJRGFFZGkrcXE4YXRtZlZHdERXVUdlem1XUnB6R2IxcTRmK0RFR1VBU3RY?=
 =?utf-8?B?aCs1eStVL3RkVlJEbm0ycEFPN0hCemVwMTdlN1JXQjFNWUQvNXQ0M3ZBT2JY?=
 =?utf-8?B?M1AwUnNRSEdOSEtCTEVid0t4THJERmxGbkVOQUllYUkwVlA3dVJsUkxuK1F3?=
 =?utf-8?B?U2tHcGFDOWVMd0xhMWpTN25iSHRod1dFeTZ4TUZiUUdodWl0V0wvakpWTVlP?=
 =?utf-8?B?dW5SVE8vb1lHand5VkhBRE80ZGlFUUVsL09lbytLNVdVWW8zOUIwWFFaWkJS?=
 =?utf-8?B?L2p1TkxRVll4T3lXYTZpbitqZWYrLzZhRHYvZzdNREtubHhoOGcrSXhGM3dH?=
 =?utf-8?B?b1VaZnRSNlBVekg3V1RnUERjTXQyajBhMWwrZWZ6Z1ZiaWF6QzNyeXkzK05y?=
 =?utf-8?B?R2ZlODFURkR0amR6RXRja2l1S1ZZVVhZc3REajhzclZpUjBYRUN2R0Zia1Zi?=
 =?utf-8?B?MlgrTXNBUlhoU3c2b2xaTkxCN2JXaGFJNEFrRTNzSlBkVjZrbUhoVHF2ODl1?=
 =?utf-8?B?TzlIT3o0RWdUcjFRK3lCV1pvcXBCb24rbnVoZEZRWWV4em9kVEhDREtUZ2pD?=
 =?utf-8?B?ZldvcUZ4TUlEZDZvTTRDRE96OTUvaHVYOWNLZ28zQTFVd1JsS2wrZ0VOTVZo?=
 =?utf-8?B?bDI0OEo0WmllYm5GWkc2aENuaWtCNGJ1VTdjd2ZmOG5RSGo3T0tZbWhYeEsy?=
 =?utf-8?B?a0w0cDZRVlhzSk9UZENyYVNPckRLdTVqemFLYS9EMkU5aTBBNmZyeFNqbkxk?=
 =?utf-8?B?RUhRNTFDWS8xa3YzcnpFaXJWM0hYbmdTaG45d2NTazdIcENaR1R3STRWckVp?=
 =?utf-8?B?MFgzK0plMTNFR1FQcUlZMWM0RzBBV2h1K1hEVWhWcTdoQWxmcGsvdXRqUEFp?=
 =?utf-8?B?eUQ0a0d1UGpDNXhnd1VtTVlxNjZoL0JrcG9VV2NLc1d4bWp2TXlaT1dhK1lE?=
 =?utf-8?B?NTVoVys1WklnaFRSQTFRT2R1SVJwR1d5Mm1Sek84K2ZMTk5rNFpka01OdmJ4?=
 =?utf-8?B?WVk0TWdiOGRseERwMENwK3JaY2orcnMxT1FpSnN6WjlFRnJodDdmTlBOaEFT?=
 =?utf-8?B?OXp2cDFhdklIVkJ3K1F2cEhLaW4xSTRTeDc0UC8xQ0FGaWF1TVg5NTk4emU1?=
 =?utf-8?B?eEdqbk90d3lINUQ2cmxTY0lxcnd5eVQ2KzdOdzI0K3ZYTGdoY0l4MDFxUUNi?=
 =?utf-8?B?QWJ1Z1NJRStRVDg4TlgyS0lkUnp2Nkl6MFZyRmVDTEVPU3VhajJEbnhYNCtI?=
 =?utf-8?B?TzdPSDJEZWpIWnl5ZjFwczZUb21JZlR6QUsrSWUzcDQ3b3lRdUlMUFNRUHdB?=
 =?utf-8?B?T0psZFdRSmNNUGtkSlY0NzBPaXVEbFkrMFI4YXluV3pGMTNyeHJCeWd3TUlt?=
 =?utf-8?B?U1JucEZta24rOWdOTzJ4aEJRZXE0WXFIc2V3ckxRb0dudmgybnduNkQzMXVw?=
 =?utf-8?B?M0lPMlFhQlczYVZ1L0hnM0JnTlZ3N3o2cWROWnBkVEs3RVlaeVhCekFxd0xz?=
 =?utf-8?B?aUNJSFM2bzZJdFdjc1U2bFduVzRyVkY0amw1eHNINi9TQmhnVnRSbHNGakxy?=
 =?utf-8?B?VU9wK0RVRXlPMlV4WmVpRW5qTmthdTh4akd0Nk4reDdzVUVCQ00zOFVwRTBG?=
 =?utf-8?B?YkEremtOdEZHNUtoUnNTOGZ6eVZkTHdIRnpBRFJIWGpSOW1QVWtKdmgxcFBB?=
 =?utf-8?Q?Qp0mo4dKnNix/+xBcIqZyJG5l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781109f2-7eb1-41cb-4ab1-08dadcb2e8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:36:59.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IPrWCD8JbcIW3J1B+ZWPiWQsxOf1MIeIswAqt1O3AAA6mCuyYLt0IJB1WHSxcVS787OPXpqCO9KUN6yAxOHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-ORIG-GUID: y-3SaFqLa4hnE3K0r3K6T1McdrWNpHih
X-Proofpoint-GUID: y-3SaFqLa4hnE3K0r3K6T1McdrWNpHih
X-Sony-Outbound-GUID: y-3SaFqLa4hnE3K0r3K6T1McdrWNpHih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBjb21taXQgcmVtb3ZlcyBhcmd1bWVudCAnbnVtX2VudHJpZXMnIGFuZCAndHlwZScgZnJv
bQ0KZXhmYXRfZmluZF9kaXJfZW50cnkoKS4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlv
bmFsIGNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bz
b255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3
ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9l
eGZhdC9kaXIuYyAgICAgIHwgMTIgKysrKysrKy0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8
ICAzICstLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAxMCArKy0tLS0tLS0tDQogMyBmaWxlcyBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IDM5N2VhMmQ5ODg0OC4uODEy
MWE3ZTA3M2JjIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rp
ci5jDQpAQCAtOTU2LDcgKzk1Niw3IEBAIGVudW0gew0KICAqLw0KIGludCBleGZhdF9maW5kX2Rp
cl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAq
ZWksDQogCQlzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBzdHJ1Y3QgZXhmYXRfdW5pX25hbWUg
KnBfdW5pbmFtZSwNCi0JCWludCBudW1fZW50cmllcywgdW5zaWduZWQgaW50IHR5cGUsIHN0cnVj
dCBleGZhdF9oaW50ICpoaW50X29wdCkNCisJCXN0cnVjdCBleGZhdF9oaW50ICpoaW50X29wdCkN
CiB7DQogCWludCBpLCByZXdpbmQgPSAwLCBkZW50cnkgPSAwLCBlbmRfZWlkeCA9IDAsIG51bV9l
eHQgPSAwLCBsZW47DQogCWludCBvcmRlciwgc3RlcCwgbmFtZV9sZW4gPSAwOw0KQEAgLTk2Nyw2
ICs5NjcsMTAgQEAgaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJc3RydWN0IGV4ZmF0X2hpbnQgKmhp
bnRfc3RhdCA9ICZlaS0+aGludF9zdGF0Ow0KIAlzdHJ1Y3QgZXhmYXRfaGludF9mZW1wIGNhbmRp
X2VtcHR5Ow0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOw0KKwlp
bnQgbnVtX2VudHJpZXMgPSBleGZhdF9jYWxjX251bV9lbnRyaWVzKHBfdW5pbmFtZSk7DQorDQor
CWlmIChudW1fZW50cmllcyA8IDApDQorCQlyZXR1cm4gbnVtX2VudHJpZXM7DQogDQogCWRlbnRy
aWVzX3Blcl9jbHUgPSBzYmktPmRlbnRyaWVzX3Blcl9jbHU7DQogDQpAQCAtMTAyMCwxMCArMTAy
NCw4IEBAIGludCBleGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBz
dHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqZWksDQogCQkJCXN0ZXAgPSBESVJFTlRfU1RFUF9GSUxF
Ow0KIAkJCQloaW50X29wdC0+Y2x1ID0gY2x1LmRpcjsNCiAJCQkJaGludF9vcHQtPmVpZHggPSBp
Ow0KLQkJCQlpZiAodHlwZSA9PSBUWVBFX0FMTCB8fCB0eXBlID09IGVudHJ5X3R5cGUpIHsNCi0J
CQkJCW51bV9leHQgPSBlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dDsNCi0JCQkJCXN0ZXAgPSBESVJF
TlRfU1RFUF9TVFJNOw0KLQkJCQl9DQorCQkJCW51bV9leHQgPSBlcC0+ZGVudHJ5LmZpbGUubnVt
X2V4dDsNCisJCQkJc3RlcCA9IERJUkVOVF9TVEVQX1NUUk07DQogCQkJCWJyZWxzZShiaCk7DQog
CQkJCWNvbnRpbnVlOw0KIAkJCX0NCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIv
ZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggMzdlOGFmODA0MmFhLi4yMWZlYzAxZDY4ZmYgMTAw
NjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9mcy9leGZhdC9leGZhdF9mcy5o
DQpAQCAtNzEsNyArNzEsNiBAQCBlbnVtIHsNCiAjZGVmaW5lIFRZUEVfUEFERElORwkJMHgwNDAy
DQogI2RlZmluZSBUWVBFX0FDTFRBQgkJMHgwNDAzDQogI2RlZmluZSBUWVBFX0JFTklHTl9TRUMJ
CTB4MDgwMA0KLSNkZWZpbmUgVFlQRV9BTEwJCTB4MEZGRg0KIA0KICNkZWZpbmUgTUFYX0NIQVJT
RVRfU0laRQk2IC8qIG1heCBzaXplIG9mIG11bHRpLWJ5dGUgY2hhcmFjdGVyICovDQogI2RlZmlu
ZSBNQVhfTkFNRV9MRU5HVEgJCTI1NSAvKiBtYXggbGVuIG9mIGZpbGUgbmFtZSBleGNsdWRpbmcg
TlVMTCAqLw0KQEAgLTQ5MCw3ICs0ODksNyBAQCB2b2lkIGV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3Vt
X3dpdGhfZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzKTsNCiBpbnQg
ZXhmYXRfY2FsY19udW1fZW50cmllcyhzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5pbmFtZSk7
DQogaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVj
dCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCXN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsIHN0
cnVjdCBleGZhdF91bmlfbmFtZSAqcF91bmluYW1lLA0KLQkJaW50IG51bV9lbnRyaWVzLCB1bnNp
Z25lZCBpbnQgdHlwZSwgc3RydWN0IGV4ZmF0X2hpbnQgKmhpbnRfb3B0KTsNCisJCXN0cnVjdCBl
eGZhdF9oaW50ICpoaW50X29wdCk7DQogaW50IGV4ZmF0X2FsbG9jX25ld19kaXIoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpjbHUpOw0KIHN0cnVjdCBleGZhdF9kZW50
cnkgKmV4ZmF0X2dldF9kZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCiAJCXN0cnVjdCBl
eGZhdF9jaGFpbiAqcF9kaXIsIGludCBlbnRyeSwgc3RydWN0IGJ1ZmZlcl9oZWFkICoqYmgpOw0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCAz
NDdjOGRmNDViZDAuLjVmOTk1ZWJhNWRiYiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMN
CisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC01OTcsNyArNTk3LDcgQEAgc3RhdGljIGludCBl
eGZhdF9jcmVhdGUoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5v
ZGUgKmRpciwNCiBzdGF0aWMgaW50IGV4ZmF0X2ZpbmQoc3RydWN0IGlub2RlICpkaXIsIHN0cnVj
dCBxc3RyICpxbmFtZSwNCiAJCXN0cnVjdCBleGZhdF9kaXJfZW50cnkgKmluZm8pDQogew0KLQlp
bnQgcmV0LCBkZW50cnksIG51bV9lbnRyaWVzLCBjb3VudDsNCisJaW50IHJldCwgZGVudHJ5LCBj
b3VudDsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGNkaXI7DQogCXN0cnVjdCBleGZhdF91bmlfbmFt
ZSB1bmlfbmFtZTsNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGRpci0+aV9zYjsNCkBAIC02
MTYsMTAgKzYxNiw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IHFzdHIgKnFuYW1lLA0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCi0JbnVt
X2VudHJpZXMgPSBleGZhdF9jYWxjX251bV9lbnRyaWVzKCZ1bmlfbmFtZSk7DQotCWlmIChudW1f
ZW50cmllcyA8IDApDQotCQlyZXR1cm4gbnVtX2VudHJpZXM7DQotDQogCS8qIGNoZWNrIHRoZSB2
YWxpZGF0aW9uIG9mIGhpbnRfc3RhdCBhbmQgaW5pdGlhbGl6ZSBpdCBpZiByZXF1aXJlZCAqLw0K
IAlpZiAoZWktPnZlcnNpb24gIT0gKGlub2RlX3BlZWtfaXZlcnNpb25fcmF3KGRpcikgJiAweGZm
ZmZmZmZmKSkgew0KIAkJZWktPmhpbnRfc3RhdC5jbHUgPSBjZGlyLmRpcjsNCkBAIC02MjksOSAr
NjI1LDcgQEAgc3RhdGljIGludCBleGZhdF9maW5kKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3Qg
cXN0ciAqcW5hbWUsDQogCX0NCiANCiAJLyogc2VhcmNoIHRoZSBmaWxlIG5hbWUgZm9yIGRpcmVj
dG9yaWVzICovDQotCWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHNiLCBlaSwgJmNkaXIs
ICZ1bmlfbmFtZSwNCi0JCQludW1fZW50cmllcywgVFlQRV9BTEwsICZoaW50X29wdCk7DQotDQor
CWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHNiLCBlaSwgJmNkaXIsICZ1bmlfbmFtZSwg
JmhpbnRfb3B0KTsNCiAJaWYgKGRlbnRyeSA8IDApDQogCQlyZXR1cm4gZGVudHJ5OyAvKiAtZXJy
b3IgdmFsdWUgKi8NCiANCi0tIA0KMi4yNS4xDQoNCg==
