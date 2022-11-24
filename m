Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4112637272
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKXGk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 01:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKXGkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:40:52 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DFFDAD3F;
        Wed, 23 Nov 2022 22:40:50 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO6OH5s001748;
        Thu, 24 Nov 2022 06:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=qwkyQki8XUKo4GmkKpTwouFfBIBxxOz+7oReYTJNuJg=;
 b=mbU0HVAFA3ALZTmPyjxowi9O5adSmcR6ehEkofBoEfNWRGH3oiCNvnh+yTOXbrdBf39a
 /xAcuV5sE/6HlzjnmCbn9sWhdpPNwuaAStXI4TwYTqTZ+m1+k/+S+I9udShsV9wGdeHn
 Lv+T2xRUTDSmMvvUZNwO744YE2X74pP2NkvMuFOW5EiJm8XBmTJsQKQxG1imu/3eRCM+
 UC+4POEVGnDzfKfA0AwWZfZvOnec236Mi1ePZ4DgwhcVd0nfLU8xsMpOIMSPRWpecjBM
 Z/1ZQ2XWgVv49XCoxN8KsAJfnxhrKFHuF9VHWoh6hOyxr10nWrL4mVLFJMNT3KTKHX+G NA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kxrb94t31-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 06:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0U2acbBoizVOlPIqiuTn5BGjtJEU8uywgqUUcf6Km8W+1Y2ohWv0WwS95rDHnCTkNfPApUUh8L1OHpC97snIvr3wInBFd1bWMSCGleXxoh+FsoM4FFnWPEWEz/aiQ/NyYotMTzgC/JKKgrsJC2aaNHsUT3BfLN0Swq5I5HJKQxKmj/yVZ3ZZblU2CiyR5X9HhTLAWJaVYwyltmf5Hg92QlKj85Mieak/34XyFE1BWWQUO0eKUIq5iaNdXp/B3Z0myCa+MTH/Dw3T2XRRiVp8K1gxZBT+SvQlF4yILM2OK3Mbm6aiThNhog4IHQ4TuHzutSsqpIRf6WdDr57uTSRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwkyQki8XUKo4GmkKpTwouFfBIBxxOz+7oReYTJNuJg=;
 b=aJHQ+R5VHUaDyVDbz5/uIkauN3eapyGCvPccXOJr351RAfjqHul5CQKpsTj9D3RlhFWxfQ+9aFH49x7p0ZtDDWrQE3SWIzep3+SLOQJYgBAwyX2ee8Hyn7+2KH9ht7P2MaQfI7k4sToLqWJDOVaZVoyX4lNe3Xkdoyk8vJ1jPrH3C1jhNW/FspksDZKWpkjfknde7bHvjGxnFEt7VFBS2H9iqlfcu6ywQX2HZgJ1mNuCv9TJ+xNcrozENpDc/53p0CcZoTX/9mt8EeUvjK4h8u6xC6+YCDuZHqIxSURN2AWDwdKSKNiPpGSTk7EZNd5dXKswQUQs4s5ujS+faHD/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4425.apcprd04.prod.outlook.com (2603:1096:4:e8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 06:40:26 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%8]) with mapi id 15.20.5857.008; Thu, 24 Nov 2022
 06:40:26 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 5/5] exfat: replace magic numbers with Macros
Thread-Topic: [PATCH v2 5/5] exfat: replace magic numbers with Macros
Thread-Index: Adj/zvsgGNVBvInHQtSPjlm/TwV6nA==
Date:   Thu, 24 Nov 2022 06:40:26 +0000
Message-ID: <PUZPR04MB63165748DE0CC74B3C3DF2A6810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4425:EE_
x-ms-office365-filtering-correlation-id: 85537ed8-ff4b-45df-0031-08dacde6c59f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9M+w3FY8mKXeKSCMUm/VIib2nGZRbqnUrA8WhKUKfcB+rx8xgz5fzFkvnxg3ZKsagdu1M9daOAtWaVSCbq13MugJpv4PfLXfcoMozxdCYawzXmJrOYktudMIKMFobw4/V61H2YilQa+xHt1WOiI5kC3evG2RmIeXU/j+4O3bpYt6shUt2jWa+Ax3Jz1qwMF7soLtwe21E4iz3QkT/1uVoViM+YGTQrgMBLN27OMsXMfkTMBaMphbglqqXW5AdmbyKfViSF5mZS6O173q1Auq71eFMg1EhL6fIbPg7BLLCBiplVWSKT2DUDk2+edKoBDGOC/pC3kdTSRZhV6cliTozUWT9jvQYmkLwCqZBVQmgn8RZY0FZpMUhP80iB7ygmX1Lpo1x0FxfHj93laLgJGfpspQRZz91T1ErHdXvxkSsyFBVC8HedK2ifexJcoahbppeXyOK7LhxAqKkiRgRnLwM2uwCya2Ov2rDiX8wxwX3l1TXZot8GeKJh48vbXWKvcT7dt5alyhf9AtUQOhLYhJlLjIiyFZcBi536H+JlZEIW7pBvpfV/VhpJxTCRbUmnjbOjlFRZLvg4LFX0NTYty2B05N5tpPIe0U2AOfo+2m/K+QVrrvBjMWcGao3NFXnwJHUFQcKmR9zQqTlbDZdphMBi/1prnmUrNTa855S6OVF9BiBnsFYSwabV4dY62Phd24uIOF+eGiBoXOL9LKNMWOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(41300700001)(8936002)(478600001)(54906003)(4326008)(5660300002)(316002)(66556008)(66476007)(66946007)(76116006)(52536014)(66446008)(64756008)(8676002)(71200400001)(107886003)(2906002)(7696005)(6506007)(9686003)(186003)(110136005)(122000001)(26005)(38070700005)(38100700002)(82960400001)(86362001)(83380400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWdXelJqMmY1Q29IT0puR0drM0JnV05GU3NzZzRmZTBmQWN3bElWcDRwVU9F?=
 =?utf-8?B?eDJjRDFIMXE2L1BibDdqRGVxVXVTZWNmNE1lYzdtUmh2OTZub1FIV2tybDVn?=
 =?utf-8?B?cXdhN1ZtY2R1M1puQ29qUFdRWjVJaHlwcUE3NzBTM21rVjNaem5wbGN4MXZs?=
 =?utf-8?B?MlJURmdUbUdBczk0Z0U0K0JlVXB0R3VBRjJPSWNaMHdUOTg3UUl2aDV4bkV4?=
 =?utf-8?B?YlQwZTZ6RnhBVStjbHNNNnZCZUlsMkhITGR5VnljemR5cDV0SHAwaFRDSHhI?=
 =?utf-8?B?YmVEZUtQQkNHcXh3TVZmMTVkQ09GdGRGc3FWN3F5K2JVeU4yN1luOVBFTlFC?=
 =?utf-8?B?b3V2RWpjRU5zdllhK2VjZVU2RXBDUjdyeHc5cm5mV0NNc202OGNlQmRFdG1u?=
 =?utf-8?B?N0lsV1dCNXRxdS9KR3IzTHVicWxFOGIxTmtwbHBtVmROcjdta2pPRzArU2Vt?=
 =?utf-8?B?TFZmdVZKOVlCRVI2K2pGRTNldWpEeUNydGdyL0JFZkVBMi9pdHlkZG12SEZl?=
 =?utf-8?B?MHVVQWswTkllT0xpOWkyQ1pTUE00NWdEWDJKb3JZUTBCMlFUdlpHYTFvQjF2?=
 =?utf-8?B?R2JvTnI4WWg3OUVrS3dmRldoQTBoTDhVTHdaT1hKSE5qbGM3VkRyRjlYbzRE?=
 =?utf-8?B?WkNKSzJ6VmdCZzluc3NTOFYyTFd2ZzBPUWpWS2hDMjhFRUZnVDI1R2p4T1dU?=
 =?utf-8?B?OGY3Rkt6UFl4RElRMTNoam5kNkFBVXJZMHluS1djZi9BUkZiQktiMUxydHdM?=
 =?utf-8?B?TXlwc2VNQ3RGOVdPaTArT3ZucjlxTm9PV3VCbGNJZXFrbVdQL1FndWVmZUFF?=
 =?utf-8?B?MzU1UDB4d0hNVEVZenlHaVQ0YlJyU0NqdlFPWVdwMCtaeTBIMEdpem1LRVBT?=
 =?utf-8?B?MVpSN2x0NUFucHB2NndSNFJ4Q1hLMm9pUkM5Z0x4V2FZVE5xVjVkenRIbkRx?=
 =?utf-8?B?VlB3NU03TnFRRmhjSUFBZDBrb2t2WDVFQ2ErL3Fpb1BWZTcxTEVjQ1JuaFBJ?=
 =?utf-8?B?OFBQVlB5ZFZhNUZ2NkxOSjJ1ZzBUMUl0N0c1eUJCanUzTVdUcWRVcHdaYmpB?=
 =?utf-8?B?RmlvTWlDSy9HOGRjWjhidVhLTlNMTmRrcG0rek1xVyt5dGxSSmJnWDFlVGFh?=
 =?utf-8?B?K3ljRElqWlFYbkRNTWNaejhnbDE1ZGtNQUVwZm9zVHppWFQxa3BsNkkrYVlF?=
 =?utf-8?B?ZVIwYVdvWjB1ZU5LcDRlZkhGZ1BJSzlOR3dmdkxNNkVVUk04WERpelB5c3ZE?=
 =?utf-8?B?T0xiejQ4elkyd0JuZU9ENTZYOE1qTzRiQ01aRi9XWDg3ZUxnb3NEOFRvYUJl?=
 =?utf-8?B?QTY5Mkl0MjlrUkw4djF4ZWRPU2I4N0dhb3Y1RkloalNyVEpDcVZRNXNicHNa?=
 =?utf-8?B?OVJGdHVPTVRXVml4YWhYYVczelBWQjBKSnErdjZmNmVMT0dYNnZnK1JrWXNl?=
 =?utf-8?B?VDVaVVd1aE9sYVQzOU5FdFBUdVpzMTNyVkQ1ZGQ3VDg5UGVJMkRtVVEvbzhr?=
 =?utf-8?B?aWxJNGlDUlhSUzlrT01hUkRSWEFjSGJ6VjFIWSt0VnU1TU5XaEJYeFZEQm94?=
 =?utf-8?B?d1kwRHdYak8vOXNtbi9EaHU4V3JFbUdpZ3U3cnRyQVVnNDByV0lTNEh0TmtF?=
 =?utf-8?B?MTF3cTQvcnJHQVkzMmFhZklyQ2hIT09DSmJwUkxISFNpV1p0Yyt0aGd0b211?=
 =?utf-8?B?Tkd4MjE2R00wQVFqUEpES3M4bXlvTmxHZjNCaU5DaHpaRjNlTWg1V0VBQWtE?=
 =?utf-8?B?TFlWUjdjVUpZSlVoTXNjQTRETmhaRXptSmg1K2E1TVpJMjBXc3BmclpBTVpu?=
 =?utf-8?B?dXJuWU40bVYwRGk0eGEvbzJRNFhlOW9VU3ZqMUUrREJuZmNLYzFieThQMlJP?=
 =?utf-8?B?MFQzcHQ2dlBDRlp3VXFQc05IanJCbUxUU0pMQlhLK0NHZVYxMy9SV2Rvc2lK?=
 =?utf-8?B?QStoOHlXREdEdCtES2RsRDVmazAyYUNOdEdqQ3FYSTY5SWtOUzFOOEROMGNS?=
 =?utf-8?B?dS85MW5KSXFZYlJUMmRnLzBPdk9oKy9vM1RQOEM3SEk2QWlqcStDMGZ6QjJ0?=
 =?utf-8?B?RVp6Yk1JTjlxK2l5ZVQ1QmFaay9wU0xySUVSbmxZRWw2c0tNbi9UaHpQbXdE?=
 =?utf-8?Q?h9xwYMK4RkeKH/rovIbuSlQt6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: raLTJpJXAy3Zc+8QQ8SEWYPnUcqTGImkSV0E3V8b//z+go3WVXllt400+4SFzKXAfTtPq8mdZBij4PdWeNZW9QQ7bgTWh+oplMUbRLeKfpwBhgxaW1woDH25iQ8c7uQQapYhxyNLnlN6o1SJ38cyXiANU962hcCeRoh1cX3W4bMzsEaLL38Utq/yXxR2UrNDFLn3/xs7ZV295OyS/Vs2bbWccv6IQhg0ITRJpOWb1bawGrB8lQNKrEWIY0/hcSRgjksNbyDhQqd+VI6ZQ3DEGrk0PGRBx+rPRmkCnPezdD0CDkV6BmWliUmddvbeOzbv6lXM97uhP1rRZwDJO/d5HVJxNwUcFvBgluwWiKHWZHA5m6FROerk2Lu04UsfVm44Qv/7K99rhJxpK7aVph9+tvzp8K0UCqmnYEz7cNPjHM5JFLMkeNBZJd73/Xedn04YXhxmp0uzDFHkOypNPQKSunbRK1eJuVn3b0y6nrdTSffL51cbqpA/iLgjoaR998Erqryb+FsMkQVqeS817eUDGgloIhndZ25ouPM2fWNdLXfIQ8tFEw8s4oMmaQiS4SZbTttbwk3C1zBKPIDURFHOXZbuSI659GdQ0fK9o9dJLSQrR9hJFhdtMKIiZVAFhYhDCLE3T+fcppct08p348TX7aoXZz96tokwxvIoTKgT6Wfz371N5fEmHVoPQmyOgEAsxw+oyE308ItS4j3hii7RmCasrnPzqnswuBzGvVe80l1hpUotLAauz2734fu3zGVq6gRyk2kUk8/Xg3+a1x4sgf7/Ti1ISaFvrWSzkls8ltn2OdA3tiSvYnM01Aifou2zu34cb9EgcmmzwBUg06HdOLYoE8dQ1X/08WC2YjOCrn4cfyP0Vm45/wNKAOomsrGP
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85537ed8-ff4b-45df-0031-08dacde6c59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:40:26.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD5q98V1hrYtWI1Hh7LTOadc/QhZFnIEEsqzOanZQAIkEs5Yls88ALrpiAL7MluGqYk0h4fC9FDCwoxSkN53nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4425
X-Proofpoint-GUID: DH00IPFq01qaAT2-gQM6k_ledK9q3ztH
X-Proofpoint-ORIG-GUID: DH00IPFq01qaAT2-gQM6k_ledK9q3ztH
X-Sony-Outbound-GUID: DH00IPFq01qaAT2-gQM6k_ledK9q3ztH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_04,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Q29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6
IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1
IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5h
b3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgIHwgMTIgKysrKysrLS0tLS0t
DQogZnMvZXhmYXQvaW5vZGUuYyB8ICA0ICsrLS0NCiBmcy9leGZhdC9uYW1laS5jIHwgIDQgKyst
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCBhOWEw
YjNlNDZhZjIuLmMwNTQ5M2ZjOTEyNCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysg
Yi9mcy9leGZhdC9kaXIuYw0KQEAgLTQ0LDcgKzQ0LDcgQEAgc3RhdGljIHZvaWQgZXhmYXRfZ2V0
X3VuaW5hbWVfZnJvbV9leHRfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCiAJICogVGhp
cmQgZW50cnkgIDogZmlyc3QgZmlsZS1uYW1lIGVudHJ5DQogCSAqIFNvLCB0aGUgaW5kZXggb2Yg
Zmlyc3QgZmlsZS1uYW1lIGRlbnRyeSBzaG91bGQgc3RhcnQgZnJvbSAyLg0KIAkgKi8NCi0JZm9y
IChpID0gMjsgaSA8IGVzLm51bV9lbnRyaWVzOyBpKyspIHsNCisJZm9yIChpID0gRVNfSURYX0ZJ
UlNUX0ZJTEVOQU1FOyBpIDwgZXMubnVtX2VudHJpZXM7IGkrKykgew0KIAkJc3RydWN0IGV4ZmF0
X2RlbnRyeSAqZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgmZXMsIGkpOw0KIA0KIAkJLyog
ZW5kIG9mIG5hbWUgZW50cnkgKi8NCkBAIC0zMzYsNyArMzM2LDcgQEAgaW50IGV4ZmF0X2NhbGNf
bnVtX2VudHJpZXMoc3RydWN0IGV4ZmF0X3VuaV9uYW1lICpwX3VuaW5hbWUpDQogCQlyZXR1cm4g
LUVJTlZBTDsNCiANCiAJLyogMSBmaWxlIGVudHJ5ICsgMSBzdHJlYW0gZW50cnkgKyBuYW1lIGVu
dHJpZXMgKi8NCi0JcmV0dXJuICgobGVuIC0gMSkgLyBFWEZBVF9GSUxFX05BTUVfTEVOICsgMyk7
DQorCXJldHVybiBFU19FTlRSWV9OVU0obGVuKTsNCiB9DQogDQogdW5zaWduZWQgaW50IGV4ZmF0
X2dldF9lbnRyeV90eXBlKHN0cnVjdCBleGZhdF9kZW50cnkgKmVwKQ0KQEAgLTU5MSwxMyArNTkx
LDEzIEBAIHZvaWQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW1fd2l0aF9lbnRyeV9zZXQoc3RydWN0
IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMpDQogCXVuc2lnbmVkIHNob3J0IGNoa3N1bSA9IDA7
DQogCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwOw0KIA0KLQlmb3IgKGkgPSAwOyBpIDwgZXMtPm51
bV9lbnRyaWVzOyBpKyspIHsNCisJZm9yIChpID0gRVNfSURYX0ZJTEU7IGkgPCBlcy0+bnVtX2Vu
dHJpZXM7IGkrKykgew0KIAkJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQog
CQljaGtzdW0gPSBleGZhdF9jYWxjX2Noa3N1bTE2KGVwLCBERU5UUllfU0laRSwgY2hrc3VtLA0K
IAkJCQkJICAgICBjaGtzdW1fdHlwZSk7DQogCQljaGtzdW1fdHlwZSA9IENTX0RFRkFVTFQ7DQog
CX0NCi0JZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgMCk7DQorCWVwID0gZXhmYXRf
Z2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9GSUxFKTsNCiAJZXAtPmRlbnRyeS5maWxlLmNo
ZWNrc3VtID0gY3B1X3RvX2xlMTYoY2hrc3VtKTsNCiAJZXMtPm1vZGlmaWVkID0gdHJ1ZTsNCiB9
DQpAQCAtODU4LDcgKzg1OCw3IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhm
YXRfZW50cnlfc2V0X2NhY2hlICplcywNCiAJCXJldHVybiAtRUlPOw0KIAllcy0+YmhbZXMtPm51
bV9iaCsrXSA9IGJoOw0KIA0KLQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVzLCAwKTsN
CisJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgRVNfSURYX0ZJTEUpOw0KIAlpZiAo
IWV4ZmF0X3ZhbGlkYXRlX2VudHJ5KGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKSwgJm1vZGUpKQ0K
IAkJZ290byBwdXRfZXM7DQogDQpAQCAtODk1LDcgKzg5NSw3IEBAIGludCBleGZhdF9nZXRfZGVu
dHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCiAJfQ0KIA0KIAkvKiB2
YWxpZGF0ZSBjYWNoZWQgZGVudHJpZXMgKi8NCi0JZm9yIChpID0gMTsgaSA8IG51bV9lbnRyaWVz
OyBpKyspIHsNCisJZm9yIChpID0gRVNfSURYX1NUUkVBTTsgaSA8IG51bV9lbnRyaWVzOyBpKysp
IHsNCiAJCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIGkpOw0KIAkJaWYgKCFleGZh
dF92YWxpZGF0ZV9lbnRyeShleGZhdF9nZXRfZW50cnlfdHlwZShlcCksICZtb2RlKSkNCiAJCQln
b3RvIHB1dF9lczsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9pbm9kZS5jIGIvZnMvZXhmYXQvaW5v
ZGUuYw0KaW5kZXggYTg0ZWFlNzI1NTZkLi5kYWM1MDAxYmFlOWUgMTAwNjQ0DQotLS0gYS9mcy9l
eGZhdC9pbm9kZS5jDQorKysgYi9mcy9leGZhdC9pbm9kZS5jDQpAQCAtNDQsOCArNDQsOCBAQCBp
bnQgX19leGZhdF93cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgc3luYykNCiAJ
LyogZ2V0IHRoZSBkaXJlY3RvcnkgZW50cnkgb2YgZ2l2ZW4gZmlsZSBvciBkaXJlY3RvcnkgKi8N
CiAJaWYgKGV4ZmF0X2dldF9kZW50cnlfc2V0KCZlcywgc2IsICYoZWktPmRpciksIGVpLT5lbnRy
eSwgRVNfQUxMX0VOVFJJRVMpKQ0KIAkJcmV0dXJuIC1FSU87DQotCWVwID0gZXhmYXRfZ2V0X2Rl
bnRyeV9jYWNoZWQoJmVzLCAwKTsNCi0JZXAyID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVz
LCAxKTsNCisJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgmZXMsIEVTX0lEWF9GSUxFKTsN
CisJZXAyID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVzLCBFU19JRFhfU1RSRUFNKTsNCiAN
CiAJZXAtPmRlbnRyeS5maWxlLmF0dHIgPSBjcHVfdG9fbGUxNihleGZhdF9tYWtlX2F0dHIoaW5v
ZGUpKTsNCiANCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWku
Yw0KaW5kZXggNTc1MTBkN2Y1OGNmLi4wMWU0ZThjNjBiYmUgMTAwNjQ0DQotLS0gYS9mcy9leGZh
dC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtNjQ2LDggKzY0Niw4IEBAIHN0
YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IHFzdHIgKnFuYW1l
LA0KIAlkZW50cnkgPSBoaW50X29wdC5laWR4Ow0KIAlpZiAoZXhmYXRfZ2V0X2RlbnRyeV9zZXQo
JmVzLCBzYiwgJmNkaXIsIGRlbnRyeSwgRVNfMl9FTlRSSUVTKSkNCiAJCXJldHVybiAtRUlPOw0K
LQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKCZlcywgMCk7DQotCWVwMiA9IGV4ZmF0X2dl
dF9kZW50cnlfY2FjaGVkKCZlcywgMSk7DQorCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQo
JmVzLCBFU19JRFhfRklMRSk7DQorCWVwMiA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKCZlcywg
RVNfSURYX1NUUkVBTSk7DQogDQogCWluZm8tPnR5cGUgPSBleGZhdF9nZXRfZW50cnlfdHlwZShl
cCk7DQogCWluZm8tPmF0dHIgPSBsZTE2X3RvX2NwdShlcC0+ZGVudHJ5LmZpbGUuYXR0cik7DQot
LSANCjIuMjUuMQ0KDQo=
