Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FED7ACFDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjIYGJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 02:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjIYGJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:09:45 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A9C6
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 23:09:39 -0700 (PDT)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P4Aqww031121;
        Mon, 25 Sep 2023 05:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=BU3AhuHw8m2VM06hpVFYbLasQYj1qqyB4L0hNgyJyXI=;
 b=Pf9Vv+EwmjxKdcU6GtMFn4cjh6LOCfcLL6+VU2RujH9E/+7ePy0HEdHisYSDBYrf3P9u
 H8/RojHaCSQmgQpsK2b8oh3sXwGZgCulwvmzG0ZzVqZlsvILzMaFdQzoBiudM0h/vTjt
 5Ed5Ybw0pxVcKvMDo6Hd/62c2q9P9qBfuzjvndMaFSbNhQ3vhCYrCKkNf0bq9T/ZSDAP
 3Tn7T56f5psiM7dbKgzt1G1JLjBDkb/5t4puMCg8zVQ7o698BWcMtMPl4AhD6GyYgAq3
 zh/fUvoGJMZDx0aE+yg1+zFVTqw6IJ2+2AJOjnU86SMN5OCdR908wzFFILoHYR1JVmbV qw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2045.outbound.protection.outlook.com [104.47.26.45])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3t9n669hcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 05:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2t9BuKReXdN8d+fV4AyD7EcvHpdDbBerODJLGE/2ng+5kdZFXt5YiNfwWF2Ay/9Vx/QKiaVf7fH/H8U/k2ujfvyOof61s0FPw+6gwg29AGIlmG9IMjWw1yhOBiio8vuuoxWCNgz1WN8SZN8VNuUhQkKLvmyzovI/bIbHWaeX1C9Ltxg8nxuRlVEjBnZEUApXVzxpMeDtYjtmDBwXQk0wmnsJ81mwqMIe2WzpKjWzj6azKvM/LbsUL/RsZrCVNpYhril6RH+91lpE14WXeBc+8MYLVqKRoxwVCauJKV6UchfU3+FhZd+mPTORG2HcQ1j3dhhxOE/dhjWxvUi0Z+/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU3AhuHw8m2VM06hpVFYbLasQYj1qqyB4L0hNgyJyXI=;
 b=JM7l1DmaPuTaQyF58VexzrLQYvNCdRhdW2fwIKa7+g6MFxBQq2iHatbzRxRDpculfzXI1rXC8ipFsrNKGV9ooVXM269AC5daowrOzm7xEcL7OOyUHYl60CYqeFyHVZY2T6bL5de2SAS6jhQkwRJdE87hefVg4LXcyjX9sdc7Ua42jJoPy3gRfItNmbPE6PY/ZoIMPzK1QVs3jOm5DZoALHYr7MDwcGKsU5TV0WodToTg1HgGHn2267/1c5uZ8ffmUpa5qMA3VofsHkU7jKkaZeWvuvCk4S7JU9RcJcuq/VSgT4uagdBcqHJ7Pc4tp/8AWqKo6Z09Ff/SeF3TVVuaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7081.apcprd04.prod.outlook.com (2603:1096:400:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:29:51 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f9d4:e3c8:e9c0:1ad]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f9d4:e3c8:e9c0:1ad%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:29:51 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 2/2] exfat: do not zeroed the extended part
Thread-Topic: [PATCH v3 2/2] exfat: do not zeroed the extended part
Thread-Index: AdnvcNO4U5DLWxY2QtuDuNbPCCrffQ==
Date:   Mon, 25 Sep 2023 05:29:51 +0000
Message-ID: <PUZPR04MB6316E597E2D9F261605EBE1B81FCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7081:EE_
x-ms-office365-filtering-correlation-id: c0f3caa9-2c8c-4e6a-1ea8-08dbbd887134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWBErNzrHeraK48ol12iDJbanv5/9UHFSMKnXHPHvQsAv3qEe/1vQxY6d6wL1pHFpkZ+VapSXfl7DI4HsWK2uD9vNyXF7C4ev5Tgli9DyUSog4NDRo8TAJ4edlRmLlczh0VHSbqUnhHGTVRdDQENiAdxQ9zG/L4NxDhc0GtL+8tFQ7xG3mhuPdrQcKqHxxs7drC7Ra3IwY8J0jhYF0QSYhczcH0QzifExswpoC9zRPfipqLaZ/5MbY6N97tfaolH/Nvg+/uqQ94Rbm6N6Sy/nGVrpxwePS+l6ftXHQbYcKjfb6DzH7FlV0R6JkC0s3fe+IoU4nr3u0FUF0IETi0iwHOZKCsiqVscAqmktrlhAdiQQL+vsOy8ULYsWG/jQZJbGfryn0M4GBS5ArVVrU0DNqJYgeGuQCrYN8SuZyuQny8Gn4B1lqeO7vb8HUQUYvWmb3QgclDUR0ofxKIyLYVCJGimKuS1Qw2IDi1v0Jw7EpXAwNzHpR6xUJEGNU5biBPsjP67Brg5lR52Z25RKDmhVRuyWmcAZPNMPTa4jFvY0afoofMg/CGDS7hnWcHYNogkrq5gaINOuDFa2NOaYvcOa0OWVyTEyU2loEGKUMvwFciIM9gfRyegInnoJRlNKKWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(8936002)(4326008)(5660300002)(8676002)(2906002)(52536014)(316002)(41300700001)(66446008)(64756008)(66556008)(55016003)(66476007)(54906003)(110136005)(66946007)(76116006)(26005)(107886003)(33656002)(9686003)(71200400001)(38100700002)(82960400001)(122000001)(38070700005)(86362001)(478600001)(83380400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVZcXpaT3dmT01YSFllaWFMa3VaeS90Wk1YZFJoejMwNngrRkRYenBDdU9q?=
 =?utf-8?B?YkxJa25BTE52R0FKMm9GbXV0T0x0ckpNaE9oMEEycm1DSzNjU3NUYlhFWnli?=
 =?utf-8?B?Yk1yS0oxa2J6SndhQUMxSnBNbUZ0eDNkczlrb2tpcFpubUxlM2w2OEd3UG1a?=
 =?utf-8?B?Mno2aXdzeC9qRUdCYVNmMHgxVlVNYVF3M3ZpQnBEbGw1YURaUHRmL2VIS0lj?=
 =?utf-8?B?MERvaFExZCtMWWdzMFlIejQ1YVZJWnlIRklPZ3FUT1BMNzFXcEFFbnlacGJ5?=
 =?utf-8?B?S3pSekJCcUVhL09xQndrby94UDJFdmdxZWtJdno4NDJuRjljeW02enppR0N3?=
 =?utf-8?B?dEg1ZzhxZ2JtMEZ1SVFzMm5QTDVvUHlpRjBseEMwbVRDYUVNbTF5KzgvZXNF?=
 =?utf-8?B?aGVKOVQwcFlCSVliTmFDRGpkSng2bmE0bXFPVUpmb2pMM3RmN2h5ZFUrVHoy?=
 =?utf-8?B?YXNJcFFWTUhTcUkyK09PbzNwWFdCZzdNVEM0RXZocExEQkJFYzlrVm0zWnpH?=
 =?utf-8?B?NEE3WTJ0SjFQL3laYVJ4T3ZvNWhNM3RZcmNLT0NTZ2hrbHd4OElpY0oxb2FH?=
 =?utf-8?B?b3NiNnczQVBJZXhodG92dU1WdXZvTGJFVDk1ZnE5dGJRMmQ2cGpTVXFkK3Yx?=
 =?utf-8?B?Q3E5Mm1reVJWVis4VDhvM1A5V3BVaFI0Kzd3ay9VRVhad0dhdVhCclpOV09h?=
 =?utf-8?B?dy84TGpDMkhJK043WFdmUlhDZEdWa1QxM2NvVGlwQ1R1T1lCbTZlMmhiNVl2?=
 =?utf-8?B?Zkw3OVJ3SEJ5dWhmZG4xQmhURVM1NW9HRmtHQUd5OEFROEN5aFQ0RWJweitw?=
 =?utf-8?B?TkpveFlIS1hKQXlKTW5qV0hoVXdkNVRGSnZEVE80eE9zMDhKQWxlZ1hLRFpt?=
 =?utf-8?B?cXg2QTNGYlpweU0wTzYwVHpJK3ZhOUgrVTJZdmVnajFyNFZFUCtDNzlzazY0?=
 =?utf-8?B?ajVsOEhpYXdybEZyeDBwYTJ1VkZWQ3dmVm1NbnE2TTJ4bkFoNzB5SitRcC9i?=
 =?utf-8?B?VG4wQU0zd3VmWXA4dGZwYWpzUERzNldXZjQyL1YvcXZOSElKUWpCTWFzOTZF?=
 =?utf-8?B?b0pMaEFZS2JpUjQzQ0lRMXlCQ3JXSlJVNklVb0hZNkY2MDU3VGhyaWFHaDR5?=
 =?utf-8?B?emY2bG50M092U000eWtqWTRsb2toS2pYNklxL2FqZ3BQQ3ltZzZTMnRKcG9M?=
 =?utf-8?B?RFA2RkVtWG5VZUF1M1hpeUhscXE0SWpCRkhGL1QxdXl1Nmx4QWVzVjhpRkFH?=
 =?utf-8?B?VEZSWWhEVFZvYmZWb21HT2pKeTN3S1U0QUFtRnNoTzlsaEdoK2pkUHcvRG5a?=
 =?utf-8?B?N3ZYUTdyYXZ6Kzd2RzcrTXZmOGRIVWExUUl2K0I0MkhWTytsaS9ET282SmlH?=
 =?utf-8?B?SGoxckwrSEJyajhmZlAzZ0FGT2JROWxqVllQZHRXMEhzUDAzNzM2VGVzc0lG?=
 =?utf-8?B?RU1QZmYrRmNSUm9NNkRzbHFiMUpMeVVUTG5hMzdNRitBZlFYRUd5UHl3ckM3?=
 =?utf-8?B?UlJ2K1U0RVZCUmROeG90b2l1YnVKQlJFQm1XZ3U0eVFadllKa254d2tyN0dD?=
 =?utf-8?B?K0htVXZHTGJZSzJxU3RRdXIzK1IxREU3NUUwRmtSSmlFT2NKNkpXajd0aXVN?=
 =?utf-8?B?dGxzTkRPSmZja0JDc2dianhwZ2RQMFhDZFFEelBmNGNaK29Ha1YzcVpSWG9x?=
 =?utf-8?B?S24zcDlqalNhTUN4OU5hanY0RWMzd3VqenE1eXRkdkNadDRtUWtlRHRCK2pK?=
 =?utf-8?B?TG9BYlhOT3BvYWNWRzJqcFBrMkJyc3pKMGpkSmhaUzJMRWRGSWJRdFc1R1pM?=
 =?utf-8?B?Q2sxeGRIcHZBd3VPRzZQYU43SUllbTdibmpvYXRFMzNVSVdCU2tRa2ExVGFv?=
 =?utf-8?B?eU50em9ORnVVRUhGUjg2WTVhK3Y3SWppZXhtclZINlcxZDNQc0gvNFBWdnU2?=
 =?utf-8?B?bUNIMHJFTFljczAzT0ZaODBzY2dOQ2lUdXNoNmNJWnZVTmVnaHcvOGFGNUN6?=
 =?utf-8?B?QVVUbEVHRUE2UnlsQmZ4eHk2dkt3M2ljeHBkWmRYeFE0emNxbGtLbitzUEFZ?=
 =?utf-8?B?QkNhR0xsVnd2MjNrV2xxUnN2VDVMaEJHa2d4MFhWK2RvcWI1UERFajBWck1h?=
 =?utf-8?Q?9kGc2jTcbBSP6cJRtRaDDFm+f?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OYMOyfv+o5yaCDSPK2PLScAY6ah3YrELSYZ1ejXjwX+Cm1HF+bpvOmuIvt/haC87xhbYMerZo9oOIee7qWicoUdWt8aVXZJHGmyEseagntFLlFt1AbyXDqMkMzyLK71vZoVt/9yUYpd+yeHbUWnrfHrna4VhbcNUA3ExT4ap1u1qibIR6GM5XHf5E2b9ZnlWenGBICLVKT3El/f1E3M31BlmWJWKRqwoIhWwHzOi1DAsOTMFS4IV0QBn1RiRGCARaTEj0fOEE0V3MlVvQJRNISNK+J5Fml51EeLNWp1HjvR9ZwZIyFb3MqgtfFrBxwNYVpcqVaJAu8cR6jddLbuLlD86+GZ6avx1Xpy2Ne5XAUmlEdKct+uXOdIF4UFsSjew6xH37Vm0Zg6Bq6Zm31WeGE4QbhHCfesNuC4LZp+w7FheP93T7YM6a9qyTaxlZ18PgnffrBpAlgh3U3ftoQOY67+CLeE0sE8TsutijLLW29WNfEth7bcOuqsnFsx3J4BSVn+amyj1D2WvBDOF2mLiZi6zLoGFcld8vy27hSsNG61nGhG/AaGVApEzfaL0tVB6zeLNmKCSIUeG17xOr6HioPmnPtYbaoMTP23jERHaDHbtw+c5GlFkGNZaYvDGjaNprF+aIe8W1LotkUybAGOeq72OqDuVtMR9g6Ii+GNE6N31ZnRujJ5RgzeHu723HPgkINc83oLa6OvRVTGRMCuf1388PoPI14iW9YYn84hJCoTrbYvObMlPsFViSOg9w60KcSrrtkuha8Wxv4UztqJQeiijc7HawpVIA987GgJaZsTCcuNpfwAiTi1u1aOCPt9I9RhQ5rdwf9uJupqT9hf+ew==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f3caa9-2c8c-4e6a-1ea8-08dbbd887134
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:29:51.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7eSPV0zz9SQspJ1F4Ee36ldIhHNxw2zOLAGymmj0aoL2HGu196UMI6B/17ByUmWVEOwGtUdykvCHcWCSWysdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7081
X-Proofpoint-ORIG-GUID: rTImMq_AvDZ7WHA-p9FWQhGdGJ53V0js
X-Proofpoint-GUID: rTImMq_AvDZ7WHA-p9FWQhGdGJ53V0js
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: rTImMq_AvDZ7WHA-p9FWQhGdGJ53V0js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_03,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2UgdGhlIHJlYWQgb3BlcmF0aW9uIGJleW9uZCB0aGUgVmFsaWREYXRhTGVuZ3RoIHJldHVy
bnMgemVybywNCmlmIHdlIGp1c3QgZXh0ZW5kIHRoZSBzaXplIG9mIHRoZSBmaWxlLCB3ZSBkb24n
dCBuZWVkIHRvIHplcm8gdGhlDQpleHRlbmRlZCBwYXJ0LCBidXQgb25seSBjaGFuZ2UgdGhlIERh
dGFMZW5ndGggd2l0aG91dCBjaGFuZ2luZw0KdGhlIFZhbGlkRGF0YUxlbmd0aC4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9p
bm9kZS5jIHwgMTYgKysrKysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygr
KSwgMjEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9l
eGZhdC9maWxlLmMNCmluZGV4IDhlNDVlNzgyZmFmZi4uMzkwZmVmODg4ZGY1IDEwMDY0NA0KLS0t
IGEvZnMvZXhmYXQvZmlsZS5jDQorKysgYi9mcy9leGZhdC9maWxlLmMNCkBAIC0xNywzMiArMTcs
NjkgQEANCiANCiBzdGF0aWMgaW50IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIGxvZmZfdCBzaXplKQ0KIHsNCi0Jc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBp
bm9kZS0+aV9tYXBwaW5nOw0KLQlsb2ZmX3Qgc3RhcnQgPSBpX3NpemVfcmVhZChpbm9kZSksIGNv
dW50ID0gc2l6ZSAtIGlfc2l6ZV9yZWFkKGlub2RlKTsNCi0JaW50IGVyciwgZXJyMjsNCisJaW50
IHJldDsNCisJdW5zaWduZWQgaW50IG51bV9jbHVzdGVycywgbmV3X251bV9jbHVzdGVycywgbGFz
dF9jbHU7DQorCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOw0K
KwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQorCXN0cnVjdCBleGZhdF9z
Yl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQorCXN0cnVjdCBleGZhdF9jaGFpbiBjbHU7DQog
DQotCWVyciA9IGdlbmVyaWNfY29udF9leHBhbmRfc2ltcGxlKGlub2RlLCBzaXplKTsNCi0JaWYg
KGVycikNCi0JCXJldHVybiBlcnI7DQorCXJldCA9IGlub2RlX25ld3NpemVfb2soaW5vZGUsIHNp
emUpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJbnVtX2NsdXN0ZXJzID0gRVhG
QVRfQl9UT19DTFVfUk9VTkRfVVAoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmkpOw0KKwluZXdfbnVt
X2NsdXN0ZXJzID0gRVhGQVRfQl9UT19DTFVfUk9VTkRfVVAoc2l6ZSwgc2JpKTsNCisNCisJaWYg
KG5ld19udW1fY2x1c3RlcnMgPT0gbnVtX2NsdXN0ZXJzKQ0KKwkJZ290byBvdXQ7DQorDQorCWV4
ZmF0X2NoYWluX3NldCgmY2x1LCBlaS0+c3RhcnRfY2x1LCBudW1fY2x1c3RlcnMsIGVpLT5mbGFn
cyk7DQorCXJldCA9IGV4ZmF0X2ZpbmRfbGFzdF9jbHVzdGVyKHNiLCAmY2x1LCAmbGFzdF9jbHUp
Ow0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCiANCisJY2x1LmRpciA9IChsYXN0X2NsdSA9
PSBFWEZBVF9FT0ZfQ0xVU1RFUikgPw0KKwkJCUVYRkFUX0VPRl9DTFVTVEVSIDogbGFzdF9jbHUg
KyAxOw0KKwljbHUuc2l6ZSA9IDA7DQorCWNsdS5mbGFncyA9IGVpLT5mbGFnczsNCisNCisJcmV0
ID0gZXhmYXRfYWxsb2NfY2x1c3Rlcihpbm9kZSwgbmV3X251bV9jbHVzdGVycyAtIG51bV9jbHVz
dGVycywNCisJCQkmY2x1LCBJU19ESVJTWU5DKGlub2RlKSk7DQorCWlmIChyZXQpDQorCQlyZXR1
cm4gcmV0Ow0KKw0KKwkvKiBBcHBlbmQgbmV3IGNsdXN0ZXJzIHRvIGNoYWluICovDQorCWlmIChj
bHUuZmxhZ3MgIT0gZWktPmZsYWdzKSB7DQorCQlleGZhdF9jaGFpbl9jb250X2NsdXN0ZXIoc2Is
IGVpLT5zdGFydF9jbHUsIG51bV9jbHVzdGVycyk7DQorCQllaS0+ZmxhZ3MgPSBBTExPQ19GQVRf
Q0hBSU47DQorCX0NCisJaWYgKGNsdS5mbGFncyA9PSBBTExPQ19GQVRfQ0hBSU4pDQorCQlpZiAo
ZXhmYXRfZW50X3NldChzYiwgbGFzdF9jbHUsIGNsdS5kaXIpKQ0KKwkJCWdvdG8gZnJlZV9jbHU7
DQorDQorCWlmIChudW1fY2x1c3RlcnMgPT0gMCkNCisJCWVpLT5zdGFydF9jbHUgPSBjbHUuZGly
Ow0KKw0KK291dDoNCiAJaW5vZGUtPmlfbXRpbWUgPSBpbm9kZV9zZXRfY3RpbWVfY3VycmVudChp
bm9kZSk7DQotCUVYRkFUX0koaW5vZGUpLT52YWxpZF9zaXplID0gc2l6ZTsNCi0JbWFya19pbm9k
ZV9kaXJ0eShpbm9kZSk7DQorCS8qIEV4cGFuZGVkIHJhbmdlIG5vdCB6ZXJvZWQsIGRvIG5vdCB1
cGRhdGUgdmFsaWRfc2l6ZSAqLw0KKwlpX3NpemVfd3JpdGUoaW5vZGUsIHNpemUpOw0KIA0KLQlp
ZiAoIUlTX1NZTkMoaW5vZGUpKQ0KLQkJcmV0dXJuIDA7DQorCWVpLT5pX3NpemVfYWxpZ25lZCA9
IHJvdW5kX3VwKHNpemUsIHNiLT5zX2Jsb2Nrc2l6ZSk7DQorCWVpLT5pX3NpemVfb25kaXNrID0g
ZWktPmlfc2l6ZV9hbGlnbmVkOw0KKwlpbm9kZS0+aV9ibG9ja3MgPSByb3VuZF91cChzaXplLCBz
YmktPmNsdXN0ZXJfc2l6ZSkgPj4gOTsNCiANCi0JZXJyID0gZmlsZW1hcF9mZGF0YXdyaXRlX3Jh
bmdlKG1hcHBpbmcsIHN0YXJ0LCBzdGFydCArIGNvdW50IC0gMSk7DQotCWVycjIgPSBzeW5jX21h
cHBpbmdfYnVmZmVycyhtYXBwaW5nKTsNCi0JaWYgKCFlcnIpDQotCQllcnIgPSBlcnIyOw0KLQll
cnIyID0gd3JpdGVfaW5vZGVfbm93KGlub2RlLCAxKTsNCi0JaWYgKCFlcnIpDQotCQllcnIgPSBl
cnIyOw0KLQlpZiAoZXJyKQ0KLQkJcmV0dXJuIGVycjsNCisJaWYgKElTX0RJUlNZTkMoaW5vZGUp
KQ0KKwkJcmV0dXJuIHdyaXRlX2lub2RlX25vdyhpbm9kZSwgMSk7DQorDQorCW1hcmtfaW5vZGVf
ZGlydHkoaW5vZGUpOw0KKw0KKwlyZXR1cm4gMDsNCiANCi0JcmV0dXJuIGZpbGVtYXBfZmRhdGF3
YWl0X3JhbmdlKG1hcHBpbmcsIHN0YXJ0LCBzdGFydCArIGNvdW50IC0gMSk7DQorZnJlZV9jbHU6
DQorCWV4ZmF0X2ZyZWVfY2x1c3Rlcihpbm9kZSwgJmNsdSk7DQorCXJldHVybiAtRUlPOw0KIH0N
CiANCiBzdGF0aWMgYm9vbCBleGZhdF9hbGxvd19zZXRfdGltZShzdHJ1Y3QgZXhmYXRfc2JfaW5m
byAqc2JpLCBzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lub2Rl
LmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCBmYjhjMTc5OTZiMzUuLmFiYTRkOWVjOWQ1MiAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2ZzL2V4ZmF0L2lub2RlLmMNCkBA
IC04MSw3ICs4MSwxNSBAQCBpbnQgX19leGZhdF93cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBpbnQgc3luYykNCiAJCWVwMi0+ZGVudHJ5LnN0cmVhbS5zdGFydF9jbHUgPSBFWEZBVF9G
UkVFX0NMVVNURVI7DQogCX0NCiANCi0JZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBj
cHVfdG9fbGU2NChlaS0+dmFsaWRfc2l6ZSk7DQorCS8qDQorCSAqIG1tYXAgd3JpdGUgZG9lcyBu
b3QgdXNlIGV4ZmF0X3dyaXRlX2VuZCgpLCB2YWxpZF9zaXplIG1heSBiZQ0KKwkgKiBleHRlbmRl
ZCB0byB0aGUgc2VjdG9yLWFsaWduZWQgbGVuZ3RoIGluIGV4ZmF0X2dldF9ibG9jaygpLg0KKwkg
KiBTbyB3ZSBuZWVkIHRvIGZpeHVwIHZhbGlkX3NpemUgdG8gdGhlIHdyaXRyZW4gbGVuZ3RoLg0K
KwkgKi8NCisJaWYgKG9uX2Rpc2tfc2l6ZSA8IGVpLT52YWxpZF9zaXplKQ0KKwkJZXAyLT5kZW50
cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBlcDItPmRlbnRyeS5zdHJlYW0uc2l6ZTsNCisJZWxzZQ0K
KwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9fbGU2NChlaS0+dmFsaWRf
c2l6ZSk7DQogDQogCWV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtX3dpdGhfZW50cnlfc2V0KCZlcyk7
DQogCXJldHVybiBleGZhdF9wdXRfZGVudHJ5X3NldCgmZXMsIHN5bmMpOw0KQEAgLTMzMCw2ICsz
MzgsMTIgQEAgaW50IGV4ZmF0X2dldF9ibG9jayhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzZWN0b3Jf
dCBpYmxvY2ssDQogCQkJCQlwb3MsIGVpLT5pX3NpemVfYWxpZ25lZCk7DQogCQkJZ290byB1bmxv
Y2tfcmV0Ow0KIAkJfQ0KKw0KKwkJcG9zIC09IHNiLT5zX2Jsb2Nrc2l6ZTsNCisJCWlmIChwb3Mg
KyBiaF9yZXN1bHQtPmJfc2l6ZSA+IGVpLT52YWxpZF9zaXplKSB7DQorCQkJZWktPnZhbGlkX3Np
emUgPSBwb3MgKyBiaF9yZXN1bHQtPmJfc2l6ZTsNCisJCQltYXJrX2lub2RlX2RpcnR5KGlub2Rl
KTsNCisJCX0NCiAJfSBlbHNlIHsNCiAJCXNpemVfdCBiX3NpemUgPSBFWEZBVF9CTEtfVE9fQiht
YXhfYmxvY2tzLCBzYik7DQogDQotLSANCjIuMjUuMQ0KDQo=
