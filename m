Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F096560C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 08:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiLZHYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 02:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiLZHYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:24:01 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09292DDA;
        Sun, 25 Dec 2022 23:24:00 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQ5jskY031801;
        Mon, 26 Dec 2022 07:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=RvyFy5C6LSmgcCIopRwjCxr4aiN8E5adLg/ezt0fEBA=;
 b=DEzT3suxZCUbDnVqLfL/tpFysn0jmChr3kEyOaZZW/TNlMPper7iNxdMh3bUQERXtQAH
 VTKZbN6m49vjOXaLliJJXks3nFkNPALVgOoqCd4/u86O0hLoNghFvzG3KujJVcImOPsG
 yQwvQD3HFFI7EVqgkJi5VwifngCQx92gDY/IbGi7q1ew6jliMByQXAWLGYNEzLnxfM4e
 6Ex4T9Fd+Z1XBQ2tBFK7Bzu0QyUL/3YeZpdo0I4VBqJA30/lODggPG3vdrnM8eS6Y0xV
 O1H5Rz/HJ0raS1XThe5t4B/0vW7w6PvAhDJZA4T/cX/nzPg/KVNrAELNmqpQk5PMiDYM wQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mnqamshtg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Dec 2022 07:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqcuhPbisUuxu6gOARXnZNeeen38WbR2bDXdU3NCy9uJaAXlK/Olxqf4IgNARaTWUa9h/1MDjVpy0sE6XVzBAZDCmQfMa/hU78XClUG3qTd0gfawSRZBQowgnYae1G65MPdW+MbQ+SwYPdgroVk4nm1fiCRae13BckHYiSrLsuS+2bcJ2Io4My6I80k+Qh40jLypEpfmk7It9B0Kd2p6YH2vDSX9+qQtWF9WBHlU2Upi02Uh4qcc8WIAs1HvPRZvVqKYDtsyLiEChQqn3GOSwNkdiEStWNQK4VhqBPR9cIObF/mAIbCKXJRPT+YH8rLByKmFAG7EW8EP7dLzgm7oqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvyFy5C6LSmgcCIopRwjCxr4aiN8E5adLg/ezt0fEBA=;
 b=oOgmiwESMdevL3J3EI8h5rmVeZXYtq+aK2BCZy0P3IXoXVkT5IpnjbviiOxgLoH3dS5ij/MIIr8xyEKYe6f/hFC3Qq8PZ5emXQEfwMb5R8S04shF2YqbQYYcesAiQu0EtacnB7zV6COyBvWEYd9Bc9Mrr/kdovUqHYoDeodGh1T5gAPk7hwhqLXvfytykXSoG9VUKWxDtC5h84M0AgTXO9fN1+l5++TTLrinG5Dxr75+ftin5wRfcFMVkj51elkA4mJHCZsRNWRDZOtnHs+DX8MFUIxFSHzqWt4tVIP6PVfXzHjRhNiF4MHu/20X4IbYNbYyy++pEJu2Zr7zgnREVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4377.apcprd04.prod.outlook.com (2603:1096:4:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.15; Mon, 26 Dec
 2022 07:23:32 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%7]) with mapi id 15.20.5944.006; Mon, 26 Dec 2022
 07:23:32 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v1] exfat: fix unexpected EOF while reading dir
Thread-Topic: [PATCH v1] exfat: fix unexpected EOF while reading dir
Thread-Index: AdkY9qoUZeiX3wO0RPWa4GhJfGVdag==
Date:   Mon, 26 Dec 2022 07:23:32 +0000
Message-ID: <PUZPR04MB6316182889B5CE8003A5324981EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4377:EE_
x-ms-office365-filtering-correlation-id: 693854c4-1bc0-4546-eff8-08dae71217e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qd52EjVcp1Tq+aM3AdZneWwcrz+/b3EC9DBfkUFTG0tIFh7OI1dnDHfJ9Llx2AuNA1X8S/PIhsnoYwUwpXiP5+BB8wFNt8b6LCKyjoHGzYoEYXkeJACdQ8f78R1zZ6Pw8L5TJfVHU793rvJ7B+Kct+9UR5Kvdwrnuezun1kiAL2Y1dqVGUAINlj+COJwSsuNDqHOyU1wdbp9rna2bgQK9s3cC0qPV0v9UqgtzcCnwzjzFYwk9Cu2o14WNN7IjY++UzQxW9Qvy3NShT2fDsTD7YlmoUrV2ttmjnM1H75SDp4yP4HlI3sHSMaBgkIwsPEzHE1NWx90q+1cLcRL0oLVyr0JxlKwqQ80C6y1RlDG4cU81nRQT344xYHI5j0Hx0f1PPTocRSDTnguWy/G6LkL6wjGu8lclntWgGhz6GGgHQT2Bl686v0FGsUyW+NWzfsJFyI3vWoaXJ0z88SSu/qoXmso793QfNnsDwkB1bgxEZTpVpJv9ZfXiffyKF7JmozRfvTYibnYzXYFHdaiIV0BimAFl/7/4chlCDHwlPAARoxFP9kuc9ACFCQ3jaIfkF2+HHV4iSLAAk7sKX4x6R5DIW88BL+WzM9rxS26Wef9A5bSRUnYTsbYu6vPv1MYi6Em7ZKPVV0V/VRvlSH28Q8ywY03XRVoGlKkD/YrtUPr+JiaFI4tAvMbd3azsmuD9YTDp4+BtwyNXlw0D9ebwztl8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(54906003)(110136005)(83380400001)(2906002)(33656002)(7696005)(316002)(38070700005)(478600001)(82960400001)(186003)(122000001)(38100700002)(9686003)(6506007)(26005)(71200400001)(55016003)(86362001)(66946007)(66556008)(66476007)(52536014)(76116006)(41300700001)(4326008)(8676002)(8936002)(66446008)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNzUlUzdzhyR2hOaGZxcGFRaDYzenJpTlZ4SzVFT2FxTmV5cDZoSmlFLzdS?=
 =?utf-8?B?YkdqMTZ5KzZ5OTFWUUNobUZ6SDZJb2Evdm1EUTVWazh2OW1YSjE0S1p6QlJN?=
 =?utf-8?B?VmZUTkNnNVlYS0NQWlc0NFhKdm40UXl6Vm1Fam9KU2dxSUNOK3pEU1ZhTGNu?=
 =?utf-8?B?VjZValVJVzdVRkdXVFlENFludGNpTXEyN01Dd1pHbEhDUXJ6eUsrU2VYUUZr?=
 =?utf-8?B?ZDhMYXRqZmpvK3RuajJ5NktjMTFlS2YzRm9sdDJCSXFZSDFYdDBsemNkOE00?=
 =?utf-8?B?TWl3aTN1VFNoWTZ3QU5RQldsbnAwMDFoQ3pqMXBzcUVmekhockZielUrT0lk?=
 =?utf-8?B?c2lQVUxxQXVpWXNqRitUSEtHbGRBa0dPcXBwcWFxclo3RmRuMzBsYjNJTFEy?=
 =?utf-8?B?dWxUdUV6T3FwazNia1NKWE1VQVlKZS90WVgwdEc2emlCTnhSR0NPZEl0OHFO?=
 =?utf-8?B?bXVXNEl5bEdZVTNseEZ5RXA0T3lULzUvME1BUmtpd21kUjZnL2VHVi83WG8x?=
 =?utf-8?B?U3N4M2hwSThwWC9RbmdVUGo5cXJzcWEzbkpQazNmd3QzY2QwNm8zQlpjRFZU?=
 =?utf-8?B?TUtCU0RiZlRMRmRKcVJoTEZZWEUzT1B5a1NQTDUwK21IcTFVYjBuN0U3OWlo?=
 =?utf-8?B?S0VnR3RWNEl2ekVCSGJyYlpFVUNSRE9RZkJsVW1JaE9FQ004NHZvU2xadDNa?=
 =?utf-8?B?RXJMTUdHZkRNY2hZOTdQT1hGclBtSXY4NHkva1lyTWE2ZXBZS09VbDBPODhS?=
 =?utf-8?B?KzJDdDNieG42OVQrZExHNlB5c3JzOXZoWUhQbzNCMXZnNXVYVll2R1MzZGpz?=
 =?utf-8?B?QktDNFcrZ05LRHJVd3E4WWpjTVZCL3lMVVpFUkdtZFp6dVFncDhVckJMVHE5?=
 =?utf-8?B?QWI1QWVpc0FCK2NqNnJUQ0pKcHQ2Qit0MzdFb3poSW5CWWcvZEdGUk16UFdv?=
 =?utf-8?B?ZkRpb3dmVFoxZjczMUxQNDZIM1l2NEJRZ1ppMzRUOThGemJjbHhkWWR1UHEz?=
 =?utf-8?B?WlFlZGJiZFc0bFVQOUxNajVlQ1RPYUpLd2dNMkM4cTZXWWx6dXltU3hFRGFD?=
 =?utf-8?B?ZnRacU5UZjcyY2JablN2b3ptUDEvUDlQbzc5eEY1ZVBFTzNyLzYycWlOWjZi?=
 =?utf-8?B?ZlV3N29ZMXlLelN6aDFOaW5LTm03TGRaanBqWURRK0NhdCtQbnFyTnRiMXA5?=
 =?utf-8?B?ZnFSVlJiUWZOYXBZb0RLZTVFQ1NDdnFWVHlXd2hWdXBkd3VsRFdZVnJscHFT?=
 =?utf-8?B?bzhQVGtuaTg5TS91dEh4RkJqeTNZdS9OM2tUWXRKVWlqbFB5bzB2WldDQjlm?=
 =?utf-8?B?b1QvUFNENHpjeUFORnBFbEl6cEFzZkJEd0JzZm9WdUhyeG5UaGpqUi96UXEy?=
 =?utf-8?B?d2hhbEJtdjlkTnhKZVlKdzRtbEZZVGp6T2FDYVR4QXBsQmFvSHBDWS9meVYv?=
 =?utf-8?B?YXV0RU5tdHZWNjVpeVdxUTh2ZW9sbzM2MHdPbXVUMEFqWEhsQjAwNy9oQkc4?=
 =?utf-8?B?eDlwODRWc1UrMmlwV0xqOFBJbGZWNElJc2YxYzFsMjNYVTZ2aXhuaXNFZVdm?=
 =?utf-8?B?RkE3aEc5QVBwVkJndzhzRUt5SWZxQ1NNcjllUEJzWGF3ZG5KanMzejBwYklC?=
 =?utf-8?B?VUQ0MEJLWHNRTTRMYU00ZkNtcXlFaUkySXczeEhCRzJiY1FKTzBXL0RvL0RR?=
 =?utf-8?B?N1A3Zi9CbkRjUlIxL05pUlIvTGduTHFJTWtlQkQza3orQStEUCtHcTdCaEJQ?=
 =?utf-8?B?NmtzcUF6WE90S1N0eFlGbUN5K0E1LzBUVEZwZElxdW1UZERRRi9BeUpOcW5V?=
 =?utf-8?B?bG1wbnRsbXNqZUl4a3RLaGlMektqN1NCVGhKZ2lvMXFrWFNOSnZkNkcwYUtJ?=
 =?utf-8?B?NnZIQXlKL0xocjRPMkVyZmJkL0xrOGtCQTZyS00rMy80eiszdU5FMXBnWmhD?=
 =?utf-8?B?TVhwUnBJWEtZT1NKdm9xWGxsQ3h2VUJORmoxNTEvNkc5eEFHaG1FTXVSdVJw?=
 =?utf-8?B?endqRWRFTnl6eWR6NjI3MDFpdFE0UUNhWVY4RzgybzZLNTRFWis3ZlJteHV2?=
 =?utf-8?B?TTUrV09yVGE1RmZhWmxYTGlVRGNsT0NGVVFqeWFwSVl3a3pPTVltVi9wSDQy?=
 =?utf-8?Q?zajLJ5tBNCdtZKqPLhvQ/+W+K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693854c4-1bc0-4546-eff8-08dae71217e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2022 07:23:32.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r75UAqsawrzWJgL0R/OD7tlrY5sHwUjxtK2BrXosNEqmvKYLJZa6DtsMeSFVsv0f7mJjfphWNFDbXtTizBkLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4377
X-Proofpoint-GUID: OvK5HbQz0Lx4Acrqa7hb9ujoEudPMUDE
X-Proofpoint-ORIG-GUID: OvK5HbQz0Lx4Acrqa7hb9ujoEudPMUDE
X-Sony-Outbound-GUID: OvK5HbQz0Lx4Acrqa7hb9ujoEudPMUDE
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

SWYgdGhlIHBvc2l0aW9uIGlzIG5vdCBhbGlnbmVkIHdpdGggdGhlIGRlbnRyeSBzaXplLCB0aGUg
cmV0dXJuDQp2YWx1ZSBvZiByZWFkZGlyKCkgd2lsbCBiZSBOVUxMIGFuZCBlcnJubyBpcyAwLCB3
aGljaCBtZWFucyB0aGUNCmVuZCBvZiB0aGUgZGlyZWN0b3J5IHN0cmVhbSBpcyByZWFjaGVkLg0K
DQpJZiB0aGUgcG9zaXRpb24gaXMgYWxpZ25lZCB3aXRoIGRlbnRyeSBzaXplLCBidXQgdGhlcmUg
aXMgbm8gZmlsZQ0Kb3IgZGlyZWN0b3J5IGF0IHRoZSBwb3NpdGlvbiwgZXhmYXRfcmVhZGRpcigp
IHdpbGwgY29udGludWUgdG8NCmdldCBkZW50cnkgZnJvbSB0aGUgbmV4dCBkZW50cnkuIFNvIHRo
ZSBkZW50cnkgZ290dGVuIGJ5IHJlYWRkaXIoKQ0KbWF5IG5vdCBiZSBhdCB0aGUgcG9zaXRpb24u
DQoNCkFmdGVyIHRoaXMgY29tbWl0LCBpZiB0aGUgcG9zaXRpb24gaXMgbm90IGFsaWduZWQgd2l0
aCB0aGUgZGVudHJ5DQpzaXplLCByb3VuZCB0aGUgcG9zaXRpb24gdXAgdG8gdGhlIGRlbnRyeSBz
aXplIGFuZCBjb250aW51ZSB0byBnZXQNCnRoZSBkZW50cnkuDQoNCkZpeGVzOiBjYTA2MTk3Mzgy
YmQgKCJleGZhdDogYWRkIGRpcmVjdG9yeSBvcGVyYXRpb25zIikNCg0KU2lnbmVkLW9mZi1ieTog
WXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3Ug
PEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFv
eWFtYUBzb255LmNvbT4NClJlcG9ydGVkLWJ5OiBXYW5nIFl1Z3VpIDx3YW5neXVndWlAZTE2LXRl
Y2guY29tPg0KLS0tDQogZnMvZXhmYXQvZGlyLmMgfCA1ICstLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQv
ZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggMWRmYTY3ZjMwN2YxLi4xMTIyYmVlM2I2MzQg
MTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBAIC0y
MzQsMTAgKzIzNCw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfaXRlcmF0ZShzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQogCQlmYWtlX29mZnNldCA9IDE7DQogCX0NCiAN
Ci0JaWYgKGNwb3MgJiAoREVOVFJZX1NJWkUgLSAxKSkgew0KLQkJZXJyID0gLUVOT0VOVDsNCi0J
CWdvdG8gdW5sb2NrOw0KLQl9DQorCWNwb3MgPSByb3VuZF91cChjcG9zLCBERU5UUllfU0laRSk7
DQogDQogCS8qIG5hbWUgYnVmZmVyIHNob3VsZCBiZSBhbGxvY2F0ZWQgYmVmb3JlIHVzZSAqLw0K
IAllcnIgPSBleGZhdF9hbGxvY19uYW1lYnVmKG5iKTsNCi0tIA0KMi4yNS4xDQo=
