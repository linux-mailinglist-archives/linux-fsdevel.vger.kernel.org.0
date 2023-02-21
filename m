Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739D69DB46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBUHex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 02:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjBUHev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:34:51 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09FF233E1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 23:34:50 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L4uH2v019482;
        Tue, 21 Feb 2023 07:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=5P/jDAqF3xaPT7piuideXCRyzLQddmdgCWbXY5mpjsg=;
 b=LGi6scSpI+I1QbtChDU9hbZ1MzIRwJLeNgeqvXjD4PyRYVxOujXa6mddGp28z5B9E8Rk
 vhTcDzHDNPgpt51NkprF/cUIYCheLMDeqaTP1XmU9q71TAcUAtSSA2Van/0uFQXpNy/F
 ShgSXWDRpYbviFIPNP+abzeBIgoESZVj46cWE9J/Q4k4JwWJAf69kalwT0a+stVQc7E1
 leSiqztAIGyNNDSpJAlvk9Z4QDleKJAAuJAE20n7tB96zatNfw5HG94m10zvXfFeNPIp
 SfUzWJ5E7uxq4UPIslywkcmkzHi2PbQzSLCAMmFxzxH1y09ANDcGs3pEqFZQ2OI5+SE8 5w== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2048.outbound.protection.outlook.com [104.47.110.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ntmjn2vem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 07:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSIGYdYMYbArPUNhCaUkU8bBaYxBlfaVRc7+xds5rNGqh4tzb2OVBBqloFaknRqSJOFEulZTAgQc5Fyqr+9b1IEnu7K6K6sf1vMze+cSVFHsZZJJNxBXBzSfUf36sTmwYoXycU25RK25B6Q8ng49GSpWitFNOrS9mzzgysvMBqACfLGuL+hbqKt9GL9OpJOW9bDdLiiM1Ivpm2kXnF9ScRA2ducvY9DMQM8W4ARE2coy0cypW2w8JOnoPfxk/wS7zd1bUFFDrpgrkbVSUgdCMkbFKT/AJ60SYGnirMajHypJS5wd9fTNS31Lot2n57MhgL3kQN67mLX0sux6JK95WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P/jDAqF3xaPT7piuideXCRyzLQddmdgCWbXY5mpjsg=;
 b=WQrVCID0al65xPKosYllvy5fBJz31FbJRWyhCgZxFKH+jDciQ7pAWBha2hvN6TfF3wWo5TCtw+TePt/8BAiQQ3Sy5pRAvqlvCarS6wm6gny18P29DZKk9eQuPCivPeMkar6DWAyKAQYEAnactpvEfkDEA9OlXU7IooV36DfTiwe/DH7dysOllSonr02k2FCVr+yixvZdB8sgCQj2NT8uUDKqX6lYtm7wwnl9+amLGRvkKJ3c95pJFmwdIOaVIj4E/gj8yhN7ZdLzNSre2AbIfZppoLCdLltv8CM+Bc5GVqXJzS8RSEXdDePYYaOgJiN7fSZKis7B5nzctFZtr+gCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4165.apcprd04.prod.outlook.com (2603:1096:301:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 07:34:35 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 07:34:35 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH 1/3] exfat: remove unneeded code from exfat_alloc_cluster()
Thread-Topic: [PATCH 1/3] exfat: remove unneeded code from
 exfat_alloc_cluster()
Thread-Index: AdlFxb0R0myNhmzvSuqdhLs/CmEyKw==
Date:   Tue, 21 Feb 2023 07:34:35 +0000
Message-ID: <PUZPR04MB631611F7B3DB50E3247D935181A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4165:EE_
x-ms-office365-filtering-correlation-id: 0023a39a-d1e4-426b-5bcf-08db13de14a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZhrU+sKQC0R49I6SrzvMugICUcCfiApBZhDQzfBtb/7SahQcwhbpPTPKf/IxaGwGpIdywpGoYiNQlUR3CA6AA58wv1/JI4NC++otGj/e5E+q3Dd43DBH5vfYa06kodIKdVmOfw+RXu+Ne8wy2vA/n2y8tmUv+9S1LoZJo9get80cN3bSAZ4ZfwMEdXu7fSswy/a69hcmRD0lUFMMeCVPDSD0AtYH/w85JFu6LfkxP6j6dtURsJCnvIZLZYzmptkZngV1RxiEGvtAtwHzGkg7sWSDKWsSpu/RtSC7jLgQ4SetdgIlMK4rB4fMbeS3mR9Tfd07fZtUuw8kXoQ/PvzGh3WQTNnd96INM1ewEkmKmgKskzo8YX3U9GKCeHrqmDPz9HB0QxeT7nOwBoYfPa41UlM2DmoIayh2oAcnDLwDT2s6I0pbouNV2bjPjIBJU6yY6jfUnWEgdFdeJKMvnCZXebxhnlqouhpe6VLjY2ptbMtnFYmNl8qUaRdmOMbD7+Kl0q7LU4yGfbLfDZRlrGc5NMaTgs6v57MOL51WzNu3HEze6xNm5KV0pHrCTQsevFiJUr+LgbVzaNdp3qkmH4gVz575jErCt9UMKRnDjEi/8BZaqAIJaZQmCIfAyUqr1Ontz9P0IQlkHG8Khj667vYYEYm3xoKa0PfMNX3E19IyAlw6M7XtK+EGm3XWDhrtWZu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(82960400001)(122000001)(38100700002)(4744005)(83380400001)(86362001)(316002)(54906003)(8936002)(5660300002)(64756008)(66476007)(8676002)(4326008)(110136005)(55016003)(41300700001)(478600001)(38070700005)(107886003)(33656002)(7696005)(76116006)(66946007)(2906002)(71200400001)(66556008)(66446008)(52536014)(9686003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXFadnRsRVZCNm95a3Z1OEQzd2RZdEVHV2lacVl0ZkRFanNGTTdoT1JoME93?=
 =?utf-8?B?M1BJZHJLQmgzWUxtV0g5UzRjUTRQUytNYTdOdVNZQnZFNHRxV016RlViUTk4?=
 =?utf-8?B?eDJLbHBUTkVsa1VRd29pMkJUeHB3dFV1cERsZmlJY2FPTXBrcUZYUGxpZGIx?=
 =?utf-8?B?TVZYdkZiajdNUVU2ejVWSnlsUDhRSEVmQ2JvVU1ERHAzT2ZUbnpUMGRJZ2Jz?=
 =?utf-8?B?VWFFTFNSTis1M3ErNE00cHB1Ty9BanZKSEFMT3RjWUZpVWFOWWxUdUVqbTBL?=
 =?utf-8?B?RXo3Z3hNOHVKcUF0bmVmSmNsWDI2ZjZKbnVNdEVnWkZTd2VGbkVtbjNwUFMv?=
 =?utf-8?B?NkUzZEpBZXdadzFId3k3VzhUS1ZjWUIvVk1kTEJKMzduR1RPbnRZbDlnQlJP?=
 =?utf-8?B?Z2ltSDZ4V3FCaHVwRjdWWjBYZW5yc0l5REtwc25uc2pUN1N1dXYveG9xRGJo?=
 =?utf-8?B?VE1DNXN3UWQ1WlM4aksxK0NRQVZMWTJLWXhJNnJWQ1NSZDdOcU5ReXRGaXBB?=
 =?utf-8?B?U2NMdVpNTWlmLzB0dGxpTzE5clpMT1JOYWZUS0ZDUGVjZllwbk1tSHZqM3U1?=
 =?utf-8?B?Q3IrZzhGeEZsZXErd1o1bnRtdEcwK2JvK3R3dElGYUM1U2J5NitoWVQvSUhy?=
 =?utf-8?B?eEJ5Ung4WFVTQmVEbUJDRWgvYzgzT2hlM3dmU0lteC91cmV4b3psQmhrcTJp?=
 =?utf-8?B?QVk5UGp5WTZFei9FMXJzY2NHS2grQjc0SGtIYm9GQmFtNHJOZmVKWjZ1QnB4?=
 =?utf-8?B?ZHptVk16eGRTY1Q4WmQzQi9PN0lHSE9GTWhjVDR4QVhIdFFUSWFNQVUxVXNV?=
 =?utf-8?B?UDFVbHdoNVN3YUR5aFpDMUE5YlhUZy9Xb2ZuQjZwY25rNUFiUGZGNkJLZjJP?=
 =?utf-8?B?YlUwQmxhck52Um1WRGRmcXZqMkd6Nmpidm1LM1FmdlhKS3FQdnVBdS9PK1hS?=
 =?utf-8?B?aVlHTkp5eEo3OER6SklmT2NsaDN1WkRDSm9Hc2dmS3RndDZJUEdibFpTNVdw?=
 =?utf-8?B?N2xGY0xvQmxweHNILzg4U0RkYktyVWs2Ymt3UUlPMDlBdVhvNWwvNTliUWxU?=
 =?utf-8?B?NzJxK1RGMTYrSGhmbFJRWTNhaWZUZW9GczdHWFlHd1VWbTc5dmcxQlJCSzMy?=
 =?utf-8?B?L0p3ZWRLNW5taW1lbkN3U2phVjNPcTBWU3RuOWtVU2hScWs3MDhsTG54eW1V?=
 =?utf-8?B?OWFVSUs4QlNvQ0pEd0lIZ0xYamlEdXBWZy8rQU1DWGY3Q1Z5VDJIWW1RSCtU?=
 =?utf-8?B?dy9Zemhwa0NoK3hTT3FlakdrUmFZMmVuRFR5aEo1QmdYR3NMdXBHaW1PYkVZ?=
 =?utf-8?B?RWlGcWNLMFlQY21LZWM3UnpncVBHZWhKR1h3cG9GMTE1bHdZODNPeEpPRUZk?=
 =?utf-8?B?eUI2NlVCWVhqNjkvb3BkMnc1WU16Q0R0NFB1Zlg5cTFCTkVpRStKd2tMUzFO?=
 =?utf-8?B?cEg4QmM3UXFHV080SlZjTjFkNzh5UFdDbEQ1YncxY0REMGtWU2Vzdkk2em5M?=
 =?utf-8?B?Qk5NYjYvNTZyQURBMFJHeHcyVUR6R1pHWEdSMXozZVFHd2VIV1E5WllTT3Ez?=
 =?utf-8?B?MlBBakZnMy9sWUM0WUpURUYvbDJhbVZIZ1ovMTBpT0s4TEdXVkZyWlYyK1E1?=
 =?utf-8?B?VngwVmZxSysvT3g5bnN3YXNPa1Z1ZFFoNlBtTmczUmFQL0g4aW1aNTQzdmZo?=
 =?utf-8?B?N2pTSnJPTkZUTkVtejFrR2xpWTFHMERWWWZxU0Fha1FtZUxBY0N1OVQ4bWNX?=
 =?utf-8?B?REdKL2EzZmxoTjdGM2U2MTdNajZjN3MveFE4SWttSnZHS2I3VjlJSE9Bd0NT?=
 =?utf-8?B?U0pmZEdDaEVSbTlsSkJYR215eTBJYTd5S0hiaXlvbGRtVGpiZTdSSzYzQTFy?=
 =?utf-8?B?bDd6MDd3YUVOakEraURPQnRiTXcrNjFVUmxBd0ZDVlBWZFhycCtQNmFnL21t?=
 =?utf-8?B?VU1BUjcvRnpxZ3BuSWU5R1ZKK2FJRUFmc3hKQ3IrSEhwSEdwS3RLSXF4SmlR?=
 =?utf-8?B?TnFpMVVUaUhra3pua2hqUElSNkRLTnJCZW1sUFJtaEFsc3JSb1ZiQnNIYW1k?=
 =?utf-8?B?cjV6NzNROG43MEFhSUtOTzVlSjJTTkoxTUJieDJ0Umg2R1pRWDhOd1lPeWEz?=
 =?utf-8?Q?O/JHLOVNx92w+1ybsmqymZit2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K54O1Ry84Yz3y1OdoHI7Uaw3j8dD/TlZTg9RmChmmhRgZYmssPNxxaMcFdWIJgFlIZ9eaYhGtgHiHwBIrlidWYiLYwnJB14zxAwAWYQ3sROaM6LSVeN17QtDpn67NGathnZxyJ0UwQf7uJEa9tJqLOypyyBbe3Kp4ALAErr1bxshb64o7pwUy9iThHJ8Y1sGQSITKAoB4W/nUmg5epD1ALXPa2XCqm4oJ3HbsA9QcvKG70JDYVyr5l1JJ6wPzOVXKO6t4p2IQNyZRg887+ghEZTNv1C5nRFHqQVoND9AQeZzaqh5pU5vVpUG4nZO0yIWP1fSNmGw9Ei4u4YbdG7fqPG95y72FgxmWbK2N48+aezpdNckCr161kQp8AGI6sh1pX3DTm66XG1ZyMnFSMwRcmkSxD2U06GcSY8ryrdIAeMB3tLNmTbZ1v5pNnFTW8Pohn7q7GhZ4US6mv+YXtBaCsW/v3tJAeWor2zuwJ2ANuHXsk5BzJa7MiUpkF4l5a67wNh9b4pZ5WJQMe/bvO8Ps3dTx3RMf3/nyZXAI8l1Vxt6SgzZORLkRPoi7soEHmCxSAcZfDmlxGVzjBYTJEcdkJHyS9fYa74HkwJBOgdToEtE9XzxPaNTU+b32i/Fr52/zDHgY8hilHN97Ve9REuDK6GvUGZ+1L+j7UUXhrLARwbbq4et6lI8ao9cUBqILRqXYmbI/r2jU2spyDicx0U6g8+Xn6NuwP59BbB9x8kmDFthlzM4nCXxrtW4t3q27xgI9qJRGRhdpVkVxsQArNWOEMfj+SOYoBNSPkUwOOhTmh9AY5EpzuSTsiv2If8pkmzQIlobIjMqsiFTo/FZo6bdfQ==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0023a39a-d1e4-426b-5bcf-08db13de14a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 07:34:35.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R2FEY/D94yYROxk4vsyfNXSgLH0jGS5THhuoJpYoUuXbNLY4u6OVw9WkFkYHl3Ufo32gN4Ru3H7d74gbnhvvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4165
X-Proofpoint-GUID: xguHjfrFbEDHgT5h3eD0LAofx2tonPva
X-Proofpoint-ORIG-GUID: xguHjfrFbEDHgT5h3eD0LAofx2tonPva
X-Sony-Outbound-GUID: xguHjfrFbEDHgT5h3eD0LAofx2tonPva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_04,2023-02-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gdGhlIHJlbW92ZWQgY29kZSwgbnVtX2NsdXN0ZXJzIGlzIDAsIG5vdGhpbmcgaXMgZG9uZSBp
bg0KZXhmYXRfY2hhaW5fY29udF9jbHVzdGVyKCksIHNvIGl0IGlzIHVubmVlZGVkLCByZW1vdmUg
aXQuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQv
ZmF0ZW50LmMgfCA5ICstLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
OCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhm
YXQvZmF0ZW50LmMNCmluZGV4IDQxYWU0Y2NlMWY0Mi4uNjVhOGM5ZmIwNzJjIDEwMDY0NA0KLS0t
IGEvZnMvZXhmYXQvZmF0ZW50LmMNCisrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5jDQpAQCAtMzQ3LDE0
ICszNDcsNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1
bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIAkJZXhmYXRfZXJyKHNiLCAiaGludF9jbHVzdGVyIGlz
IGludmFsaWQgKCV1KSIsDQogCQkJaGludF9jbHUpOw0KIAkJaGludF9jbHUgPSBFWEZBVF9GSVJT
VF9DTFVTVEVSOw0KLQkJaWYgKHBfY2hhaW4tPmZsYWdzID09IEFMTE9DX05PX0ZBVF9DSEFJTikg
ew0KLQkJCWlmIChleGZhdF9jaGFpbl9jb250X2NsdXN0ZXIoc2IsIHBfY2hhaW4tPmRpciwNCi0J
CQkJCW51bV9jbHVzdGVycykpIHsNCi0JCQkJcmV0ID0gLUVJTzsNCi0JCQkJZ290byB1bmxvY2s7
DQotCQkJfQ0KLQkJCXBfY2hhaW4tPmZsYWdzID0gQUxMT0NfRkFUX0NIQUlOOw0KLQkJfQ0KKwkJ
cF9jaGFpbi0+ZmxhZ3MgPSBBTExPQ19GQVRfQ0hBSU47DQogCX0NCiANCiAJcF9jaGFpbi0+ZGly
ID0gRVhGQVRfRU9GX0NMVVNURVI7DQotLSANCjIuMjUuMQ0K
