Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D04DD521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 08:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiCRHRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCRHRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:17:12 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD01C0242;
        Fri, 18 Mar 2022 00:15:53 -0700 (PDT)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I54K9g011253;
        Fri, 18 Mar 2022 07:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=QbwulrNTUmrVcOTrYTaz8ovNE0l9wDpZHSzXCvxOKwI=;
 b=iaAYuQxRqG5Kolw1hl0oVRR6Ato72X1HfDKYtVPm4Mt3vLUJq8v+GfDgCWVvpw0wUz2n
 oqOF6EQ5oiT7MfFJNp7qSPCeTJ7MZW7nTUpL96+JUn5KfBrfTbBcVxnqmBqv1WFd/UlR
 Nkj4Wm8Ht+OdekMvYQm18zrnSGk2Ixoz6TGHm/zIgNnClsGZLu3RDnFtXit/qd4ZSW7G
 hX44nUE8Z8tShW+456JbQSFJUI07FtKBOswPrbnbNg42h2s+KXkiHZd2L8GeOeYAAxA5
 f1G73fxcwpvDZsJK+t2m5w9ozlAUWvsb206gM8aeSIyPcqhOVB5dTeiQ14sUVBYB99Jy jQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2108.outbound.protection.outlook.com [104.47.26.108])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3evgjyg7x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 07:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/W/iAWeGTWmzDQ68YqMjt4IgWq3Y87gGbtI8IU2rGBEJexicRX3xC5Nm2guAx9fw7vCIUKNvqOVSZo+PXFvprMgOZ348w8uWPSyejCkGEmc4ptA8aFjkayMQTWOFxG+x4z7aszT8Ax0vxODZfTFViCEiz2eaK/Rm8ifiUWimHEazIDagQdeZCPLgy4CHDqJBWMscOpDIr14UqE+z+b2AgFa2/K8uYVMYsdKodGp7ixTcSB9Pf6Zvv+LNHBeKYkOanPqI+FbEZNLySNInwZVQszodahZl5WsyV+oKjU1WqrxQtS3pFWjLqa+7Xk5cRItZjHofACIRbd9UAE7eHYtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbwulrNTUmrVcOTrYTaz8ovNE0l9wDpZHSzXCvxOKwI=;
 b=OMbze9yusX3a4WTtO8JARfYKvei7m6HTr4pMuMM7lm5Itfh1Txqdk3shaDCufaumhldf16M/gMTVpYe1FhAoKlgbVfXimQc3q5TovNZpJQUtFFaiaAjKfuWbz9pz3brU7C2TZkZtLw6d2YhMNS4UhLpu7bL+3NjacJSj3Bc42kn6XALzx4df4C1dUKwK3dIXaBOHTK7LaDb/pTOUgf3FylYaOLTK39wvvbmuP0jxu1G7vgy3Xxhn8G/U2Y/+KX03Kg6dhpc86yMgCBX7EQ7/3HzULkHPyli4jojed2FUSYAjwZaKfXS9HKcSoDVtz3od675qdh+zjpEH+mPIduqHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by PSAPR04MB4407.apcprd04.prod.outlook.com (2603:1096:301:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Fri, 18 Mar
 2022 07:15:26 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 07:15:26 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: [PATCH v3] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v3] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg6lzDjhk7fjGoDQ3egmYNh+h6C3Q==
Date:   Fri, 18 Mar 2022 07:15:25 +0000
Message-ID: <HK2PR04MB3891EE32B58A61D3ED9944CE81139@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6491c9dc-39ed-47d2-b477-08da08af132d
x-ms-traffictypediagnostic: PSAPR04MB4407:EE_
x-microsoft-antispam-prvs: <PSAPR04MB4407145FB66DE11688C779CC81139@PSAPR04MB4407.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7fzBPBK7Gje8SlLQokt6acly4mHxPpyawtUZrHOOngqfnvDDOZaUHayuNqcJQe9MmCkA0JkhO7xcFVWmning0l556fXT+uVBmw9B/YHz4E3V3Gp8hJB3xX+3L7GH2SwlHNY2RDtDguH40+5gF5JB2yQ+dizqzY2dVtGZ79EfdCFgV1+PmAFKCrqZOuIOLa4W+w9KE2eJ1c2ZKMG3GpNcdF2cxOJK1L5ihmX4kBHuCWWiF5PqTfwU9Hp7tnkzFBkiAv4e2nfdVhxYDkTI6FrOZWdjQkbOsMaRuu9WWICbYIFEA0XvyJBvyAeiAhh3qK/CoCFKn4pJMcS/j03U7u/VEGibJEDUBz40MbJXwUfT6sQfF0AIe4sGqnSyQJ5KcQkrZcQI5VLAwPiwUPeDOPsMIiFbhmKzz4tfUt7fqvXBQRR14m4BVTfIRdoEdm9DSG8H1s3RXMsCqZqizIQIsTLnQ+wHKL0bPnW96SgGEcgIXFrIhUXPaEbMnAH0etSpIPSYDyVy5307/uxUpa4fUD05f4PWB7Fx5WrOrEowa5UwKbYpYehXN9jiRTDySihsG/FjMPk3Tnht+TAjxqzbEtA0m31T/6hbtFqioHXRqIvAGnmn1VoSvoK7ImaF0r4CvOxMPbCAVbZAW7cpJgImesC6EVj1oVboMNIW8h4ay+imrIyVV7zmfwFsVuym9VtHIacrE5k+0y4j/5s/+fvUmRGPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(122000001)(82960400001)(99936003)(508600001)(6506007)(7696005)(38070700005)(38100700002)(83380400001)(186003)(26005)(2906002)(86362001)(8936002)(5660300002)(52536014)(55016003)(33656002)(316002)(54906003)(110136005)(66446008)(66476007)(66556008)(66946007)(8676002)(64756008)(76116006)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZDcGtScEJaakRvbjV2WDkwdkRUdDlKVGVBMTU3WjFmNGFtb0FGUUIxME1V?=
 =?utf-8?B?MEo0MUhOK2gzUGhmWCtua1JWZnJZWVI5QTR4cWdtSnRyczNCVzZUdjFUMDNi?=
 =?utf-8?B?dHJPVXNBczZTWExURjl1VElWeXk3RUk5MmdObjJobk94dSs4TU1DR3JOYys4?=
 =?utf-8?B?TjY5Z2FnZzdOQ2l0cFUvNTIrY1FrcXhpV2RnQm5ZNk83Mkd6WEFVbUoxa0tG?=
 =?utf-8?B?UXcrYmVhNnNab2pZYzRJdlNqUTZ2b09QMjcwMDRkM3ozR1owYllvQnluS21N?=
 =?utf-8?B?Q0FIR3dtYjlDSExmdHRmUDNGeWlNN1FDT0p3NWJWR2twVDU1cGlkSEY5T1VH?=
 =?utf-8?B?WjJXWjlMNlVYL0VSYlAwVkU1bEkwc0hrNVVJUUdtOGpUazRJbkUwMVdRR1hR?=
 =?utf-8?B?RmV4NGEyUG1ER0xaQmJTckxTblgxQmlPdUh0QTZtK0RyY2Faczdub042MmFl?=
 =?utf-8?B?QnpXOTRDNXpLbEFhbDd6dW41M3BaQ3o3K2hHUTNuSFF0a3hXZ25aVlJFdFJV?=
 =?utf-8?B?aCtrK3lSYWpqZDFkdFl2M2tGNUhBVVZtQ3UyOWkySFZDSUtIcFhmSkpNMXJH?=
 =?utf-8?B?UkFHZVptZkFOMmxOMzU4VHZTYnQ5b2NadUxMSkcxV3F6NkVUTkZEZi9HNzNr?=
 =?utf-8?B?enpoVTNWZG45Q0RVTCtySmtEUmdEanFqQTB1Wi9GbHR0QlJVT3JyblB0ZmJQ?=
 =?utf-8?B?QjcvdUNoLzJndDF6TnFOcHJ1ZFpVS1FYTlFmeWFpUEVaOGZqUGhJNlMzTy9w?=
 =?utf-8?B?bG5iMWYrbFZHSVNJaEkrTWRic0d4NnFDTy9aQ1JpMUtJdkozajlhNDRmMWpi?=
 =?utf-8?B?eTFHMlo2RnlGTlFJdXptL3FtNVIzYWROK0FIRDJSMDBldUV2Z1FUWkkxYzRI?=
 =?utf-8?B?Rmk3TEtTR0tRZENUcW1oUFVxVzl4bTB2Slk2OTI4VDN6NXI5U0hncUZFZE8y?=
 =?utf-8?B?UkpHbDhKeFdGZmhxMXpzOVJYMDlsUWtDUVhPRm1Va2w1bTEzN0JEZ2g1Tldv?=
 =?utf-8?B?Z1EwZzZPVVY2Yk1lTzBZSml3UnNScVNCQVdpdTBsUkU1dUNrQXh2ajQrTTll?=
 =?utf-8?B?ZWlXbDY1NFh3VCtDam5HZUNuSnFMRm1LS3VhOUhOSGQ0a1RIYVhuaDNyTzlO?=
 =?utf-8?B?WllHYmZMSnE3RlQxSWoxaERJbllFVnp6VmgvVmx4UDFNQTBtTzJrdWpWSHRL?=
 =?utf-8?B?YmNnQnYyTHQwdG9LUFFyZFhBSW8ycWJTOTZCaEc3YU5MUytkNTZYZ2RlOCt4?=
 =?utf-8?B?ZS9IU3JSRnFnbGRNdFZHZ3JDUGg2d1JmSGNEcWdrVjBJT1dKRmdSVGUyNzJH?=
 =?utf-8?B?MnRtdFhjYmRJNERaU2pxYnVmQUJMYmxQU1BEb2ZaZUkzNHl3aWJuSGdXWmRx?=
 =?utf-8?B?V2JSdmlURmkxb25Gd0Q4THROQU0zL1F2UjYxenVkTng5b3FjNTZ1bEg4ZDBp?=
 =?utf-8?B?YzdiMXRQVXkyckU1RTJ0eXR5Tm5LekxJSnFFSEhtdDl0Q1ltTitzTTF3dVhr?=
 =?utf-8?B?QndYUW8vUXBXM2x1K3ZwdEdSMlpoeEhwTDdHL2h1VnFIYjErYldyMzhMamVw?=
 =?utf-8?B?dmJEZlUzbjhCRUlBeGw5aFlPR3U3SWJ0aFN3NnFpd0lqd1NjNEdKeHVpbDJS?=
 =?utf-8?B?VGFMRjNsZXRCZEdPQ2JISERBMDBDTUo5OFhVdEc4dWViSlgwY3NzQkduR2Rm?=
 =?utf-8?B?cmRka1ZaZjkrQlpHZklvcjR1V2JXMDljamgwRWpWK3lLc2NHc1lVbE9Cc2RW?=
 =?utf-8?B?QVZHZlNjNFpWVndzMUZLRFlYczZHNDlLelBIVHd5WTgvMzhGaGpFT0Y5dlZG?=
 =?utf-8?B?NFlYcGtSVEFOOUR5L1NTMUxNVEMvdkFrMVMweU9KaHd2RnJ6bE95Z2V1UkZ0?=
 =?utf-8?B?NFcvYjBXS0hac2xkOFBzWitJTEEyU0xmVUlidjJaTEk0QTBMQkFFa21FUTgw?=
 =?utf-8?Q?dZq4FA4HP9pHUCmhHeLaN5TPS2qlvGmX?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891EE32B58A61D3ED9944CE81139HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491c9dc-39ed-47d2-b477-08da08af132d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 07:15:25.6814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLih8PkP+95dil4yC/2FNBY6zBEbRsPckhE8qHhUMyp2m8VrJCLrdS6Yp4TwVMh0yX53EVOkka4U9fcL4kz/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4407
X-Proofpoint-GUID: fT0vY_vIuNa6CHEf-lK6xz1ocQRdzEWn
X-Proofpoint-ORIG-GUID: fT0vY_vIuNa6CHEf-lK6xz1ocQRdzEWn
X-Sony-Outbound-GUID: fT0vY_vIuNa6CHEf-lK6xz1ocQRdzEWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203180038
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891EE32B58A61D3ED9944CE81139HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QmVmb3JlIHRoaXMgY29tbWl0LCBWb2x1bWVEaXJ0eSB3aWxsIGJlIGNsZWFyZWQgZmlyc3QgaW4N
CndyaXRlYmFjayBpZiAnZGlyc3luYycgb3IgJ3N5bmMnIGlzIG5vdCBlbmFibGVkLiBJZiB0aGUg
cG93ZXINCmlzIHN1ZGRlbmx5IGN1dCBvZmYgYWZ0ZXIgY2xlYW5pbmcgVm9sdW1lRGlydHkgYnV0
IG90aGVyDQp1cGRhdGVzIGFyZSBub3Qgd3JpdHRlbiwgdGhlIGV4RkFUIGZpbGVzeXN0ZW0gd2ls
bCBub3QgYmUgYWJsZQ0KdG8gZGV0ZWN0IHRoZSBwb3dlciBmYWlsdXJlIGluIHRoZSBuZXh0IG1v
dW50Lg0KDQpBbmQgVm9sdW1lRGlydHkgd2lsbCBiZSBzZXQgYWdhaW4gYnV0IG5vdCBjbGVhcmVk
IHdoZW4gdXBkYXRpbmcNCnRoZSBwYXJlbnQgZGlyZWN0b3J5LiBJdCBtZWFucyB0aGF0IEJvb3RT
ZWN0b3Igd2lsbCBiZSB3cml0dGVuIGF0DQpsZWFzdCBvbmNlIGluIGVhY2ggd3JpdGUtYmFjaywg
d2hpY2ggd2lsbCBzaG9ydGVuIHRoZSBsaWZlIG9mIHRoZQ0KZGV2aWNlLg0KDQpSZXZpZXdlZC1i
eTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1
IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1
ZXpoYW5nLk1vQHNvbnkuY29tPg0KLS0tDQoNCkNoYW5nZXMgZm9yIHYyOg0KICAtIENsZWFyIFZv
bHVtZURpcnR5IHVudGlsIHN5bmMgb3IgdW1vdW50IGlzIHJ1bg0KDQpDaGFuZ2VzIGZvciB2MzoN
CiAgLSBBZGQgUkVRX0ZVQSBhbmQgUkVRX1BSRUZMVVNIIHRvIGd1YXJhbnRlZSBzdHJpY3Qgd3Jp
dGUgb3JkZXJpbmcNCg0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCAgMiAtLQ0KIGZzL2V4ZmF0L25hbWVp
LmMgfCAgNSAtLS0tLQ0KIGZzL2V4ZmF0L3N1cGVyLmMgfCAxMCArKy0tLS0tLS0tDQogMyBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQppbmRleCBkODkwZmQzNGJiMmQu
LjJmNTEzMDA1OTIzNiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0KKysrIGIvZnMvZXhm
YXQvZmlsZS5jDQpAQCAtMjE4LDggKzIxOCw2IEBAIGludCBfX2V4ZmF0X3RydW5jYXRlKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSkNCiAJaWYgKGV4ZmF0X2ZyZWVfY2x1c3Rl
cihpbm9kZSwgJmNsdSkpDQogCQlyZXR1cm4gLUVJTzsNCiANCi0JZXhmYXRfY2xlYXJfdm9sdW1l
X2RpcnR5KHNiKTsNCi0NCiAJcmV0dXJuIDA7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0
L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCBhZjRlYjM5Y2MwYzMuLjM5YzliZGQ2
YjZhYSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVp
LmMNCkBAIC01NTQsNyArNTU0LDYgQEAgc3RhdGljIGludCBleGZhdF9jcmVhdGUoc3RydWN0IHVz
ZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmRpciwNCiAJZXhmYXRfc2V0
X3ZvbHVtZV9kaXJ0eShzYik7DQogCWVyciA9IGV4ZmF0X2FkZF9lbnRyeShkaXIsIGRlbnRyeS0+
ZF9uYW1lLm5hbWUsICZjZGlyLCBUWVBFX0ZJTEUsDQogCQkmaW5mbyk7DQotCWV4ZmF0X2NsZWFy
X3ZvbHVtZV9kaXJ0eShzYik7DQogCWlmIChlcnIpDQogCQlnb3RvIHVubG9jazsNCiANCkBAIC04
MTIsNyArODExLDYgQEAgc3RhdGljIGludCBleGZhdF91bmxpbmsoc3RydWN0IGlub2RlICpkaXIs
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCiANCiAJLyogVGhpcyBkb2Vzbid0IG1vZGlmeSBlaSAq
Lw0KIAllaS0+ZGlyLmRpciA9IERJUl9ERUxFVEVEOw0KLQlleGZhdF9jbGVhcl92b2x1bWVfZGly
dHkoc2IpOw0KIA0KIAlpbm9kZV9pbmNfaXZlcnNpb24oZGlyKTsNCiAJZGlyLT5pX210aW1lID0g
ZGlyLT5pX2F0aW1lID0gY3VycmVudF90aW1lKGRpcik7DQpAQCAtODQ2LDcgKzg0NCw2IEBAIHN0
YXRpYyBpbnQgZXhmYXRfbWtkaXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBz
dHJ1Y3QgaW5vZGUgKmRpciwNCiAJZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7DQogCWVyciA9
IGV4ZmF0X2FkZF9lbnRyeShkaXIsIGRlbnRyeS0+ZF9uYW1lLm5hbWUsICZjZGlyLCBUWVBFX0RJ
UiwNCiAJCSZpbmZvKTsNCi0JZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNiKTsNCiAJaWYgKGVy
cikNCiAJCWdvdG8gdW5sb2NrOw0KIA0KQEAgLTk3Niw3ICs5NzMsNiBAQCBzdGF0aWMgaW50IGV4
ZmF0X3JtZGlyKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQogCQln
b3RvIHVubG9jazsNCiAJfQ0KIAllaS0+ZGlyLmRpciA9IERJUl9ERUxFVEVEOw0KLQlleGZhdF9j
bGVhcl92b2x1bWVfZGlydHkoc2IpOw0KIA0KIAlpbm9kZV9pbmNfaXZlcnNpb24oZGlyKTsNCiAJ
ZGlyLT5pX210aW1lID0gZGlyLT5pX2F0aW1lID0gY3VycmVudF90aW1lKGRpcik7DQpAQCAtMTMx
MSw3ICsxMzA3LDYgQEAgc3RhdGljIGludCBfX2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9s
ZF9wYXJlbnRfaW5vZGUsDQogCQkgKi8NCiAJCW5ld19laS0+ZGlyLmRpciA9IERJUl9ERUxFVEVE
Ow0KIAl9DQotCWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7DQogb3V0Og0KIAlyZXR1cm4g
cmV0Ow0KIH0NCmRpZmYgLS1naXQgYS9mcy9leGZhdC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIu
Yw0KaW5kZXggOGM5ZmI3ZGNlYzE2Li5jMWY3ZjdiN2M0YWIgMTAwNjQ0DQotLS0gYS9mcy9leGZh
dC9zdXBlci5jDQorKysgYi9mcy9leGZhdC9zdXBlci5jDQpAQCAtMTAwLDcgKzEwMCw2IEBAIHN0
YXRpYyBpbnQgZXhmYXRfc2V0X3ZvbF9mbGFncyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNp
Z25lZCBzaG9ydCBuZXdfZmxhZ3MpDQogew0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0g
RVhGQVRfU0Ioc2IpOw0KIAlzdHJ1Y3QgYm9vdF9zZWN0b3IgKnBfYm9vdCA9IChzdHJ1Y3QgYm9v
dF9zZWN0b3IgKilzYmktPmJvb3RfYmgtPmJfZGF0YTsNCi0JYm9vbCBzeW5jOw0KIA0KIAkvKiBy
ZXRhaW4gcGVyc2lzdGVudC1mbGFncyAqLw0KIAluZXdfZmxhZ3MgfD0gc2JpLT52b2xfZmxhZ3Nf
cGVyc2lzdGVudDsNCkBAIC0xMTksMTYgKzExOCwxMSBAQCBzdGF0aWMgaW50IGV4ZmF0X3NldF92
b2xfZmxhZ3Moc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgc2hvcnQgbmV3X2ZsYWdz
KQ0KIA0KIAlwX2Jvb3QtPnZvbF9mbGFncyA9IGNwdV90b19sZTE2KG5ld19mbGFncyk7DQogDQot
CWlmICgobmV3X2ZsYWdzICYgVk9MVU1FX0RJUlRZKSAmJiAhYnVmZmVyX2RpcnR5KHNiaS0+Ym9v
dF9iaCkpDQotCQlzeW5jID0gdHJ1ZTsNCi0JZWxzZQ0KLQkJc3luYyA9IGZhbHNlOw0KLQ0KIAlz
ZXRfYnVmZmVyX3VwdG9kYXRlKHNiaS0+Ym9vdF9iaCk7DQogCW1hcmtfYnVmZmVyX2RpcnR5KHNi
aS0+Ym9vdF9iaCk7DQogDQotCWlmIChzeW5jKQ0KLQkJc3luY19kaXJ0eV9idWZmZXIoc2JpLT5i
b290X2JoKTsNCisJX19zeW5jX2RpcnR5X2J1ZmZlcihzYmktPmJvb3RfYmgsIFJFUV9TWU5DIHwg
UkVRX0ZVQSB8IFJFUV9QUkVGTFVTSCk7DQorDQogCXJldHVybiAwOw0KIH0NCiANCi0tIA0KMi4y
NS4xDQo=

--_002_HK2PR04MB3891EE32B58A61D3ED9944CE81139HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="v3-0001-exfat-do-not-clear-VolumeDirty-in-writeback.patch"
Content-Description: v3-0001-exfat-do-not-clear-VolumeDirty-in-writeback.patch
Content-Disposition: attachment;
	filename="v3-0001-exfat-do-not-clear-VolumeDirty-in-writeback.patch";
	size=3537; creation-date="Fri, 18 Mar 2022 07:14:40 GMT";
	modification-date="Fri, 18 Mar 2022 07:15:25 GMT"
Content-Transfer-Encoding: base64

QmVmb3JlIHRoaXMgY29tbWl0LCBWb2x1bWVEaXJ0eSB3aWxsIGJlIGNsZWFyZWQgZmlyc3QgaW4K
d3JpdGViYWNrIGlmICdkaXJzeW5jJyBvciAnc3luYycgaXMgbm90IGVuYWJsZWQuIElmIHRoZSBw
b3dlcgppcyBzdWRkZW5seSBjdXQgb2ZmIGFmdGVyIGNsZWFuaW5nIFZvbHVtZURpcnR5IGJ1dCBv
dGhlcgp1cGRhdGVzIGFyZSBub3Qgd3JpdHRlbiwgdGhlIGV4RkFUIGZpbGVzeXN0ZW0gd2lsbCBu
b3QgYmUgYWJsZQp0byBkZXRlY3QgdGhlIHBvd2VyIGZhaWx1cmUgaW4gdGhlIG5leHQgbW91bnQu
CgpBbmQgVm9sdW1lRGlydHkgd2lsbCBiZSBzZXQgYWdhaW4gYnV0IG5vdCBjbGVhcmVkIHdoZW4g
dXBkYXRpbmcKdGhlIHBhcmVudCBkaXJlY3RvcnkuIEl0IG1lYW5zIHRoYXQgQm9vdFNlY3RvciB3
aWxsIGJlIHdyaXR0ZW4gYXQKbGVhc3Qgb25jZSBpbiBlYWNoIHdyaXRlLWJhY2ssIHdoaWNoIHdp
bGwgc2hvcnRlbiB0aGUgbGlmZSBvZiB0aGUKZGV2aWNlLgoKUmV2aWV3ZWQtYnk6IEFuZHkgV3Ug
PEFuZHkuV3VAc29ueS5jb20+ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95
YW1hQHNvbnkuY29tPgpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29u
eS5jb20+Ci0tLQoKQ2hhbmdlcyBmb3IgdjI6CiAgLSBDbGVhciBWb2x1bWVEaXJ0eSB1bnRpbCBz
eW5jIG9yIHVtb3VudCBpcyBydW4KCkNoYW5nZXMgZm9yIHYzOgogIC0gQWRkIFJFUV9GVUEgYW5k
IFJFUV9QUkVGTFVTSCB0byBndWFyYW50ZWUgc3RyaWN0IHdyaXRlIG9yZGVyaW5nCgogZnMvZXhm
YXQvZmlsZS5jICB8ICAyIC0tCiBmcy9leGZhdC9uYW1laS5jIHwgIDUgLS0tLS0KIGZzL2V4ZmF0
L3N1cGVyLmMgfCAxMCArKy0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhm
YXQvZmlsZS5jCmluZGV4IGQ4OTBmZDM0YmIyZC4uMmY1MTMwMDU5MjM2IDEwMDY0NAotLS0gYS9m
cy9leGZhdC9maWxlLmMKKysrIGIvZnMvZXhmYXQvZmlsZS5jCkBAIC0yMTgsOCArMjE4LDYgQEAg
aW50IF9fZXhmYXRfdHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXpl
KQogCWlmIChleGZhdF9mcmVlX2NsdXN0ZXIoaW5vZGUsICZjbHUpKQogCQlyZXR1cm4gLUVJTzsK
IAotCWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7Ci0KIAlyZXR1cm4gMDsKIH0KIApkaWZm
IC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMKaW5kZXggYWY0ZWIz
OWNjMGMzLi4zOWM5YmRkNmI2YWEgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMKKysrIGIv
ZnMvZXhmYXQvbmFtZWkuYwpAQCAtNTU0LDcgKzU1NCw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfY3Jl
YXRlKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICpkaXIs
CiAJZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7CiAJZXJyID0gZXhmYXRfYWRkX2VudHJ5KGRp
ciwgZGVudHJ5LT5kX25hbWUubmFtZSwgJmNkaXIsIFRZUEVfRklMRSwKIAkJJmluZm8pOwotCWV4
ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7CiAJaWYgKGVycikKIAkJZ290byB1bmxvY2s7CiAK
QEAgLTgxMiw3ICs4MTEsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X3VubGluayhzdHJ1Y3QgaW5vZGUg
KmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCiAJLyogVGhpcyBkb2Vzbid0IG1vZGlmeSBl
aSAqLwogCWVpLT5kaXIuZGlyID0gRElSX0RFTEVURUQ7Ci0JZXhmYXRfY2xlYXJfdm9sdW1lX2Rp
cnR5KHNiKTsKIAogCWlub2RlX2luY19pdmVyc2lvbihkaXIpOwogCWRpci0+aV9tdGltZSA9IGRp
ci0+aV9hdGltZSA9IGN1cnJlbnRfdGltZShkaXIpOwpAQCAtODQ2LDcgKzg0NCw2IEBAIHN0YXRp
YyBpbnQgZXhmYXRfbWtkaXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1
Y3QgaW5vZGUgKmRpciwKIAlleGZhdF9zZXRfdm9sdW1lX2RpcnR5KHNiKTsKIAllcnIgPSBleGZh
dF9hZGRfZW50cnkoZGlyLCBkZW50cnktPmRfbmFtZS5uYW1lLCAmY2RpciwgVFlQRV9ESVIsCiAJ
CSZpbmZvKTsKLQlleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoc2IpOwogCWlmIChlcnIpCiAJCWdv
dG8gdW5sb2NrOwogCkBAIC05NzYsNyArOTczLDYgQEAgc3RhdGljIGludCBleGZhdF9ybWRpcihz
dHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCQlnb3RvIHVubG9jazsK
IAl9CiAJZWktPmRpci5kaXIgPSBESVJfREVMRVRFRDsKLQlleGZhdF9jbGVhcl92b2x1bWVfZGly
dHkoc2IpOwogCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRpcik7CiAJZGlyLT5pX210aW1lID0gZGly
LT5pX2F0aW1lID0gY3VycmVudF90aW1lKGRpcik7CkBAIC0xMzExLDcgKzEzMDcsNiBAQCBzdGF0
aWMgaW50IF9fZXhmYXRfcmVuYW1lKHN0cnVjdCBpbm9kZSAqb2xkX3BhcmVudF9pbm9kZSwKIAkJ
ICovCiAJCW5ld19laS0+ZGlyLmRpciA9IERJUl9ERUxFVEVEOwogCX0KLQlleGZhdF9jbGVhcl92
b2x1bWVfZGlydHkoc2IpOwogb3V0OgogCXJldHVybiByZXQ7CiB9CmRpZmYgLS1naXQgYS9mcy9l
eGZhdC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYwppbmRleCA4YzlmYjdkY2VjMTYuLmMxZjdm
N2I3YzRhYiAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvc3VwZXIuYworKysgYi9mcy9leGZhdC9zdXBl
ci5jCkBAIC0xMDAsNyArMTAwLDYgQEAgc3RhdGljIGludCBleGZhdF9zZXRfdm9sX2ZsYWdzKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIHNob3J0IG5ld19mbGFncykKIHsKIAlzdHJ1
Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOwogCXN0cnVjdCBib290X3NlY3Rv
ciAqcF9ib290ID0gKHN0cnVjdCBib290X3NlY3RvciAqKXNiaS0+Ym9vdF9iaC0+Yl9kYXRhOwot
CWJvb2wgc3luYzsKIAogCS8qIHJldGFpbiBwZXJzaXN0ZW50LWZsYWdzICovCiAJbmV3X2ZsYWdz
IHw9IHNiaS0+dm9sX2ZsYWdzX3BlcnNpc3RlbnQ7CkBAIC0xMTksMTYgKzExOCwxMSBAQCBzdGF0
aWMgaW50IGV4ZmF0X3NldF92b2xfZmxhZ3Moc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWdu
ZWQgc2hvcnQgbmV3X2ZsYWdzKQogCiAJcF9ib290LT52b2xfZmxhZ3MgPSBjcHVfdG9fbGUxNihu
ZXdfZmxhZ3MpOwogCi0JaWYgKChuZXdfZmxhZ3MgJiBWT0xVTUVfRElSVFkpICYmICFidWZmZXJf
ZGlydHkoc2JpLT5ib290X2JoKSkKLQkJc3luYyA9IHRydWU7Ci0JZWxzZQotCQlzeW5jID0gZmFs
c2U7Ci0KIAlzZXRfYnVmZmVyX3VwdG9kYXRlKHNiaS0+Ym9vdF9iaCk7CiAJbWFya19idWZmZXJf
ZGlydHkoc2JpLT5ib290X2JoKTsKIAotCWlmIChzeW5jKQotCQlzeW5jX2RpcnR5X2J1ZmZlcihz
YmktPmJvb3RfYmgpOworCV9fc3luY19kaXJ0eV9idWZmZXIoc2JpLT5ib290X2JoLCBSRVFfU1lO
QyB8IFJFUV9GVUEgfCBSRVFfUFJFRkxVU0gpOworCiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuMjUu
MQoK

--_002_HK2PR04MB3891EE32B58A61D3ED9944CE81139HK2PR04MB3891apcp_--
