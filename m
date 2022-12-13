Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354764ADD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiLMCjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiLMCiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:38:07 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866A1DF3C;
        Mon, 12 Dec 2022 18:37:30 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCMfxV6023229;
        Tue, 13 Dec 2022 02:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=ltF9uTLyurlLxk/wr/RfDjvUK/5Qter81QMsfjKp15I=;
 b=ohkH+aWBI2GvkcAz6gUo24qmpRuz1Pwz0ntS/N99zsCktlutodEgqSGWi+XtWq9CgFAF
 xleFx3Gghuvq2imB42mofocgRODJKFx/cYnKSuJXx0TQ9WKPKhCxMDsq6zz0z6o7nZQv
 dcA1+KyKMT820xhEE/LJneiA9Qi75nnQwoIWXQy3c4ZtWSIHwzVaXXe4QS68FPiUw5Y6
 RDysU9g1CPM6kP/4RaWsm2ejanrzBSeQmZgqpH4k3G+L4W8iKD7Gj+YxRMDkynX8GoPs
 FqdusU2onmVRYmqko6NYgAsCj/MFU2fZmEO7l9ugp8S1l2bMREVqj53TrQtfuuNK8BJ3 pQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcg0majja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7CK2nQ2tJgHigANthGgiEk7pHjiGlR0NvdFhbPYh+DioI8FhNVdJwatGuwU4fQG7y5Lhh0R1y5TNo8Ur+/dEOQGOm0yvUIll8txznTn49UJ/i6eqGVLZv9OsxndtyJqo9yw2DMwUyy5daryAjdpkpEuGU0oAmnQOtFPi1r1qAGj1Xl2xj9f//X6FsFudrMiHt14Pe3H5ba6HsBo/5GhcaMXgcpHvA823sLM6WLLqayvwNb73BxUjD/JJ+fvMegsq9bfPXMa6oxaKd7tm3ewWmbxREqoi/nYtpaicDaWbxuDXbdN5iUSOSJPx6uNJlQnDzn3Ze+ur6FbpHT/xZSWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltF9uTLyurlLxk/wr/RfDjvUK/5Qter81QMsfjKp15I=;
 b=VFeWVKj5746KGTOuxg39ByYOG0toPQZXOzt0DDzYPh4oECePTy6fwBFkzQ+skxNzXkJKHDxGLVdTfcVOOL6sRCkmxq5l4B3ZYIhim4tUYFJ6QaiDeOu37cuNpV6CqSlLy+cHFt8GkfouGGWetTFsL3gDiPIPY0ax0FrnKw+JJWvomH6/jXNDTWQNSP0X7u4JXr+ZtF5Kkl84BnEUg03VwNNnteRZVsT1R+0yQsImVVTzKp3W4zccnGk3wlqs7h9b9DoasxeNaQw+IVXuJZmAC5xSIEzGf60kYYXBHOggGG1WFG9R86TFPV7z9dZ+f7j6wMAWrg2Bg/FeHhCq/FR8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:37:12 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:37:12 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 7/7] exfat: reuse exfat_find_location() to simplify
 exfat_get_dentry_set()
Thread-Topic: [PATCH v2 7/7] exfat: reuse exfat_find_location() to simplify
 exfat_get_dentry_set()
Thread-Index: AdkOmtAgzNiu6amqRB+LFDMxgmm87w==
Date:   Tue, 13 Dec 2022 02:37:12 +0000
Message-ID: <PUZPR04MB63161B7273CCFE699435619681E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: 427fdb53-7c89-479f-da5f-08dadcb2f096
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeG+1cplfLPI9/tNIYu9q/jV897rfBboPfcEDlkImtlfjC+yQ0LsdBgKiadY038yshp2WTzSnVMbqfMr2eGb65DpswipzTL1lYUcpuAJFZO/JIiXZofQ3FRzoGuD57H7FSXUehjg8f1pWukQDvy34DVZJvUyepP7dGcNEPype7EMsncJ8bm61W5Er6VdR/+JNDxfSYhh2BP9ZQaHQdqQlZWWQO8a+JT8U3d7O7I7n8I5hy2JWlpYNNc/i1LLM5QKp6wD05y0xW3tMZI/skMf0MRtWjIOc7+jC4hAvCb4fw3cv6Mb/XwI+PAoA3LWvy09d92GKnEWahKg/JcQjxQtHWa9PxQGzc8tw5KqrhF4oBIL3u3aBw3Hkw+xqLbkxYNmsgQ1UePRHGhmXQSxtv9ldUDYU+YjZgqSM3JGK6FxpwiqjJFqa24HJ+rWIgHb5BayJdC+q4csmvFnIIO5jRjYkFivoqw2IYKMdo2j7HHloSia005i1KFpBvtHUGlAry6wbE2upolBcq22aSUd65PeepFuDs1OjDQK6O744BwJo0GBBybAZzgKSJPMab1l2B+nHUeMyT+2exT5HGwOTubeub8O6awAWb+SK2Bs4P3W39Iz/yMKXJH85BxtG6F5RCjX0DB0HH/t9oSPGAU/MvAdYsuj2UxmFeFdbUG9S1sBDlHbCZILtTNNkzoPXZCRfnleD14VnrN3pdLB8yntoQ3u8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnpJMEFrY05TWkRKS0RMUnk1RHF6ZVFPTFQzUlVPRHJ3dS8vNjNjcWgrV2VW?=
 =?utf-8?B?NWRlSmFIbVU0RGVNdFFHMEdYbmY0SlpUWnVGK05ESHNWT2VHbmJrSHJxT1JI?=
 =?utf-8?B?SENNQnl5cGNLbnBZRTdCSHFJVGxTcFZDdmZHN2RSdy8wWHE2QngrL2JUYzlD?=
 =?utf-8?B?QisvekszNXlyNGpjN1pGVERGNUhVeXRRTTRWRk1KakJFRmZ1d3YyeE9lZk1Z?=
 =?utf-8?B?NEFkV1VGRmtWaWVhV0UvYytYMUlaZGg1WEpIbzl3WWk2VFBIU1ZTRXVtSGIv?=
 =?utf-8?B?SmxCYVorTU1PV3hkZVl6U0l6ODFzTEwwaHAwc0I3Sm1hN3FKbUhWckpVNld6?=
 =?utf-8?B?Y0cvT1R2MGIxaUhhSFdOR2xCbVZ3RkVKQkU5cjg1NTg2b0RGb2pyRkVmams4?=
 =?utf-8?B?UCtvR3BLNk9FY2VFNWZseFBET0ZrRXA0L1ZmemlRbmJJUVllTUpUTEZwWnZY?=
 =?utf-8?B?RlhpY3A5QmN6d25KUGVtbkd1cjY4L1h2MFNRdmlNZTJVcDQ5MHNhcUd4SkM5?=
 =?utf-8?B?aUd2WnQrd2ZjdFY0Q3VKbHIvVlVEQ3craVYwNlMxR0pqWktZamdITE13enB3?=
 =?utf-8?B?ZzduL1JjZ0YvM3ZpSUZ2SjkzMktBNDgzbVUyN0QzNC85b0lNVDBwNGhrS2Z4?=
 =?utf-8?B?dVhBZ2NCRk9EaityOGw5MnkwTmNlK2hjZHFCajR2Q1BiS3VSWDlwUG5jYlFG?=
 =?utf-8?B?U1E1ZkJ0amt1NDJqam9jOUsyQ3RGSlhuYTQ1cm91Q3l2V0x3dm1NUHhvbVgz?=
 =?utf-8?B?WGMyaUxkZ3FTUnUvRXdsbEl1di9pSG5xWFRCT3FQbDQ3aWgxOXlzSjRrY0U3?=
 =?utf-8?B?Z2U2OFJpbC9UVGFWSWlEUmRSRFl5M0R4NGFLRDdvaFQ3alFXMkxLSUoyQkdQ?=
 =?utf-8?B?NStxVnBkYzFSczIzKzBVd29aaU00ajgybkR3YUIzQXo2RlZEQldqTFI0Q1N2?=
 =?utf-8?B?OHhYWVVwWE9aZnUrK0xRRmpxb2pIaFJrM2pjRGZoeENvUzFzbStEQVlERVRp?=
 =?utf-8?B?bDJOa1piN2VSNmlreGI4NUtuZCtlSlJoOEs2SDJZYm9Gc2ZQSjluZmlRVzJK?=
 =?utf-8?B?bFVoT2JWOGlNOTcxQXV2WmRELzZmYVFnR2MxcXFiMjJCUDRiaTFqNHJ3dVQ3?=
 =?utf-8?B?dnA5R25vSVpxejNmOW5iQnJkL1BvVlhSQTR4UU9zN3Y2RkdqKzlQRzVzVkRa?=
 =?utf-8?B?OXBtRlJPeTFrekdpWE56SHczUGVacEdsVUx1eDF0MjBpNGloSm5hNS83bGV1?=
 =?utf-8?B?NXVPenhrS1ZPVkZZWnBKR3JBeFFYSFliMVNqd29FT3BIN21VYitsVmRkZUdQ?=
 =?utf-8?B?ZEJ5ZU5sVjlsc0tTSEUzMWg2MUx1NVZPWnJ6TDl0UTlFc01uc24zRnZqeE82?=
 =?utf-8?B?ek5vRlMzamprWWE3blRVQjZHYUpjblpuNEU5cUNsYjNSK3ZZSy9Fck9aU3F6?=
 =?utf-8?B?RzdhZVJLOExkNGZjVGFaMzFhS21HbzdJTGdTWjltS2RPUFpmWUxtbTlmMURC?=
 =?utf-8?B?d1E1b3R4YWZpVkdkQ3ZncFA1SUMvVGt0VmJLWTAwbDNST2lZUjVlWHZ6RnZm?=
 =?utf-8?B?ZUl2RkJ4a2s2MTBmV0JTYXJWeW9ISWgzNmtzMVlkbWd1c2hWNHp5YXlXZWFv?=
 =?utf-8?B?bDVQaHI3SkJXV1I4T1NpbHJsOXVieXhhMkRnZGZ4YllNc2QvK3l5ZzlndjJz?=
 =?utf-8?B?bWs1QVJtRy9tWjlxZndPRlhsQVlkVDhYQnZQay9wb2hQN1Vuc2FReVFEVkRB?=
 =?utf-8?B?YXI2aTFRSEVXZWhFVG9jdElsRXQ0cmlpZDNyVU1DRGY4QUxOZC84VkRYZ2dI?=
 =?utf-8?B?T1oxUW1SNnd4NFEwME5jbXFFZVg5bytLY2Jjd1IzWjYyZjJGMkRHRWNNZUNI?=
 =?utf-8?B?Wkt4VDF4WHRUOUFzM3JwVVFmWUJGd3NkTmJBQVRCaW9tZDJRV0JtU1lZQm9E?=
 =?utf-8?B?OFlRRksxSVF2cGtFTnNXZi9oZ21oZExPcjNUNytWdCtnRnNUNjFlWGU2SU5X?=
 =?utf-8?B?eHlEK21FTG1rQ1d3cUhhYUptc3J5Z3cvNExlaWc1bW1pZXArUzhYQUZKMm1L?=
 =?utf-8?B?KzhWczRDdXo4b1REZmJURG9kb2ZLQnlBNW9iMm16cEV6YlFXYUJJREdmSllQ?=
 =?utf-8?Q?xPFh5CQA1xhQJXqsEp4NY7e8L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427fdb53-7c89-479f-da5f-08dadcb2f096
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:37:12.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQVunxTc0T/emDD56OvA1A6H2TGpey9TBd1j1lucr31AmiD7Yf513JMvm1g/PMtkiMV7cPG6uik1Kd2GErJrVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-GUID: -hwfYQiqcOJKK0uDBA7JtewPG_HJGGiG
X-Proofpoint-ORIG-GUID: -hwfYQiqcOJKK0uDBA7JtewPG_HJGGiG
X-Sony-Outbound-GUID: -hwfYQiqcOJKK0uDBA7JtewPG_HJGGiG
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

SW4gZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSwgcGFydCBvZiB0aGUgY29kZSBpcyB0aGUgc2FtZSBh
cw0KZXhmYXRfZmluZF9sb2NhdGlvbigpLCByZXVzZSBleGZhdF9maW5kX2xvY2F0aW9uKCkgdG8g
c2ltcGxpZnkNCmV4ZmF0X2dldF9kZW50cnlfc2V0KCkuDQoNCkNvZGUgcmVmaW5lbWVudCwgbm8g
ZnVuY3Rpb25hbCBjaGFuZ2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0t
DQogZnMvZXhmYXQvZGlyLmMgfCAxNyArKysrLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggODEyMWE3ZTA3M2JjLi4xZGZhNjdmMzA3
ZjEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBA
IC04MTgsNyArODE4LDcgQEAgaW50IGV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9l
bnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJdW5zaWduZWQgaW50IHR5cGUpDQogew0KIAlpbnQgcmV0
LCBpLCBudW1fYmg7DQotCXVuc2lnbmVkIGludCBvZmYsIGJ5dGVfb2Zmc2V0LCBjbHUgPSAwOw0K
Kwl1bnNpZ25lZCBpbnQgb2ZmOw0KIAlzZWN0b3JfdCBzZWM7DQogCXN0cnVjdCBleGZhdF9zYl9p
bmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQogCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwOw0KQEAg
LTgzMSwyNyArODMxLDE2IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRf
ZW50cnlfc2V0X2NhY2hlICplcywNCiAJCXJldHVybiAtRUlPOw0KIAl9DQogDQotCWJ5dGVfb2Zm
c2V0ID0gRVhGQVRfREVOX1RPX0IoZW50cnkpOw0KLQlyZXQgPSBleGZhdF93YWxrX2ZhdF9jaGFp
bihzYiwgcF9kaXIsIGJ5dGVfb2Zmc2V0LCAmY2x1KTsNCisJcmV0ID0gZXhmYXRfZmluZF9sb2Nh
dGlvbihzYiwgcF9kaXIsIGVudHJ5LCAmc2VjLCAmb2ZmKTsNCiAJaWYgKHJldCkNCiAJCXJldHVy
biByZXQ7DQogDQogCW1lbXNldChlcywgMCwgc2l6ZW9mKCplcykpOw0KIAllcy0+c2IgPSBzYjsN
CiAJZXMtPm1vZGlmaWVkID0gZmFsc2U7DQotDQotCS8qIGJ5dGUgb2Zmc2V0IGluIGNsdXN0ZXIg
Ki8NCi0JYnl0ZV9vZmZzZXQgPSBFWEZBVF9DTFVfT0ZGU0VUKGJ5dGVfb2Zmc2V0LCBzYmkpOw0K
LQ0KLQkvKiBieXRlIG9mZnNldCBpbiBzZWN0b3IgKi8NCi0Jb2ZmID0gRVhGQVRfQkxLX09GRlNF
VChieXRlX29mZnNldCwgc2IpOw0KIAllcy0+c3RhcnRfb2ZmID0gb2ZmOw0KIAllcy0+YmggPSBl
cy0+X19iaDsNCiANCi0JLyogc2VjdG9yIG9mZnNldCBpbiBjbHVzdGVyICovDQotCXNlYyA9IEVY
RkFUX0JfVE9fQkxLKGJ5dGVfb2Zmc2V0LCBzYik7DQotCXNlYyArPSBleGZhdF9jbHVzdGVyX3Rv
X3NlY3RvcihzYmksIGNsdSk7DQotDQogCWJoID0gc2JfYnJlYWQoc2IsIHNlYyk7DQogCWlmICgh
YmgpDQogCQlyZXR1cm4gLUVJTzsNCkBAIC04NzgsNiArODY3LDggQEAgaW50IGV4ZmF0X2dldF9k
ZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAlmb3IgKGkgPSAx
OyBpIDwgbnVtX2JoOyBpKyspIHsNCiAJCS8qIGdldCB0aGUgbmV4dCBzZWN0b3IgKi8NCiAJCWlm
IChleGZhdF9pc19sYXN0X3NlY3Rvcl9pbl9jbHVzdGVyKHNiaSwgc2VjKSkgew0KKwkJCXVuc2ln
bmVkIGludCBjbHUgPSBleGZhdF9zZWN0b3JfdG9fY2x1c3RlcihzYmksIHNlYyk7DQorDQogCQkJ
aWYgKHBfZGlyLT5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pDQogCQkJCWNsdSsrOw0KIAkJ
CWVsc2UgaWYgKGV4ZmF0X2dldF9uZXh0X2NsdXN0ZXIoc2IsICZjbHUpKQ0KLS0gDQoyLjI1LjEN
Cg==
