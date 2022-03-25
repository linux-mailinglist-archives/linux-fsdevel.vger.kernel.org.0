Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D264E7030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358081AbiCYJoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358144AbiCYJoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:44:08 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFECFBA5;
        Fri, 25 Mar 2022 02:42:34 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P4sY4d014911;
        Fri, 25 Mar 2022 09:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=YRTlMvAm4AIST9JKiXF3F3auYVKUmjcLH6oij9Htt9Q=;
 b=IEc4aXDRFpKFBWi8oIWbVCGNVZTYzHrbd/XbNv4ck9N/B3f52f+8wx6k0oNfx2HS8sjJ
 Gur+s3eTZW8b28F+7LjHObE4kgH/5xDDbX8rpb+W+qwJuCEAgkPSjQ46gMC2TJA3aZnj
 xT3PlnhDRj782CU6FrGNrK6p0t5byycRST+WDYLeka1ZcClO16iOOes2CHyYum6pPV0R
 r84YgAuBcFmjn0Y8QZ9YdBnanF60RTXF9VatKGI/pO8lMXedSZQzeyae8PsbQQ+IrD1C
 qhNKZhGoop+Ax4DGbiA0fJUSiMn7iwz3o3TiF4KzF9eICQ8MxUXZHvo0hWlnjqc/sBxv 9Q== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2110.outbound.protection.outlook.com [104.47.26.110])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ew5txdkmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 09:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiFnsyKZs+oO5y8mhsGdPLgozu/Ri1ekVB2ZAD3kyMUU7COv67N8z4lSeLsDOFWLXv5f2DKjIAErcqKttfti/SNxF/1N7+T5ize5MZWD+azl5C12RdLL3RyR0JQrXsZy9r62Z9VoImcBEV4MQKGsIZ5qdcGJiTf2J8wUc9jp4ee6XhOmOjOhyiYf2PTkNlf2FVxkXoNgjjlrbQYe37/txTxQ/PFPMClYBo8IF7fk86qDHsK0RmMQnrQsaG4KMXUwV8xm57QC0mR6RtqS9VMPPtTVWo1sOhxkc+rLaJE0WALQQVdqWLELYo6HKT1TJ0SGDrj3jvMy4nfhpg5oCH1L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRTlMvAm4AIST9JKiXF3F3auYVKUmjcLH6oij9Htt9Q=;
 b=T9/t4u5gmZNqIJX+D2aFGY5rFkjJZn665MkrzrkRcaQAnGCesLzB3AyKnXmoul2i87iXC6mf14Z4ZzSgvtZNKfLi2dLCITCuTPC6H0/U7D7WKo/yH1enM4TN7flhq6cDwrYoT4hFY1uDELT6++7N64ZhPOJ1abVkMpRW28XwTxLXdWcX4ldzi/X0sQr6h6wXf6CyKrxJ++Q2MtdAUcfDOoCgPrtUjMOsWa6tYKKH3mIySLf3iW0Y97O30qrZnWvRGdIC/Q9iZ0Sm5cpxC5RYhwgX2c4gowEN6xN/GxXiLV9r4ltD82Iu9/zCo4OuXXH+3NcYAt64ebxeRD+HcW2Heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by HK0PR04MB2386.apcprd04.prod.outlook.com (2603:1096:203:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 09:42:18 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 09:42:18 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: [PATCH 2/2] exfat: remove exfat_update_parent_info()
Thread-Topic: [PATCH 2/2] exfat: remove exfat_update_parent_info()
Thread-Index: AdhAK+2AhxgEsqrvQY2S5lzzjVrKNQ==
Date:   Fri, 25 Mar 2022 09:42:18 +0000
Message-ID: <HK2PR04MB38911DEEC1C24C06E4C272D5811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6abb3e2-aeb5-4b8a-2bb7-08da0e43c0d3
x-ms-traffictypediagnostic: HK0PR04MB2386:EE_
x-microsoft-antispam-prvs: <HK0PR04MB2386BCC846734EE5BAE23344811A9@HK0PR04MB2386.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9omKkoAi56lf0ukjLJQV19DsyAXOZ98+gBafBr+XBoGKkURkswEM1aXBHqE4j3ajnJ/NeV7LSv0jFucVq1sBbi14xhSr8mPq+lUtb8aAMOw+YFT6kTV2JPO73exWlQeSENg+U69XNSWH1OCffV5EdqyFc8xkoWx5GXClRF3o4dm26erlLtNWF9150k0eMCxMw0xFz7rb5T7efg/UoRVWv4nQpnenGX3UigQDPFlG1Do259pdhzFXXxcogqhxN9m0TpGiu2vhQ7kj2hTDvOJA36I0pWLBM5C/9+4oaVIGOvX/EQ1q+r50oHgjqQX4M72diFLYyhBFc1tqjvgQfaFipGIsIjhsByUOX1/A+PAizpb2tignFLjwf+dFLvjWRIipTGlnI+uYr7BFHh7stxdLitjiJKeNPrYmidQzwur+UteEMXHN3CY+FQiYQbz4otBNpewkeDElPFHPP1XapB3drM5egz1qP+riY9wUXWneMfFpzgCYGf+xe0HvoZMegEj/Yj7GFgNu+ZfdPRWMxM5QBB8BMpm3KvxyATHrYrAVQEfUzq3qbdDQOCAroEprJi//Uy66I63PHngjqqipdnxObS2RvOKd/CzjamAWUbnZPzrGC/EDXdksmRPIyBXg23ygjOK/8WFE+2Gsh0iW+tTdpkzuyAq+ziQW89+UYLZhFmwrJKFhYN7A1wHtAqOtx+IQvP7G8pPKNwOzpRe0wxkglQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(508600001)(7696005)(9686003)(64756008)(66946007)(2906002)(38070700005)(8676002)(6506007)(55016003)(71200400001)(8936002)(26005)(52536014)(76116006)(186003)(83380400001)(66476007)(110136005)(66556008)(33656002)(66446008)(5660300002)(54906003)(38100700002)(122000001)(86362001)(99936003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3U2VnVtRndnbzZRZk83OUVxc3IyTmhBTDByK3dZVTc4Qjh1bzF2cUdXbWFQ?=
 =?utf-8?B?SFVYK1V3T0RBaTJ5Q3hEc0dOSkpKMkhuMkpCdHQrZGtYckRtcG1zSG1ETk0w?=
 =?utf-8?B?ZlJINDJQRktuUytQdTFkMDJmQ1d1U0t1eUFSTVNjNnZOWStXSmlDeUdmRUxa?=
 =?utf-8?B?NVBqSmtVQUVoUGZ2cCtKamFHU2s0SlBLVWZYNlVyMWxXU0IrQ1NYWFFlbExQ?=
 =?utf-8?B?bk5TNUtwYm1EZnJFYmZ4Y2N3dE5sWEl4RjhoMHM5RXkzSU9MZEdvR0hqQzd5?=
 =?utf-8?B?alJ0aDBqRzJVd01NNjJLdVRsZ1pDZHBaWmNMeks1TzhPWlM5ajdseUYvVUdY?=
 =?utf-8?B?UlV6T2I4cnMyWWkramNsTENxUXB5V1hydzcyRWs2Q0xjemtCM0laUlNUUkpC?=
 =?utf-8?B?cW9PRTZENEtPQ04zaGozbWJuWVdRM1BRMkhpTmxrbkVzNFhqdXZ0ekdPY2pj?=
 =?utf-8?B?N2JmMnd1YU1uODRiN0dINGozM0MvT2tibmhkQVBFdWc0Tnp5T3lYWkhPZGFU?=
 =?utf-8?B?bXFRNEhDZHl0SStDU1ZUM0FFZmZoZi9ubDhuRWFoaXlGUjJBWVR3WDNFbTly?=
 =?utf-8?B?SFpqNzhmcUNWR0crVGVBNXNpcnZvYTZaMWcvOVdZcnZTTEwyYUxRNXJrdWlo?=
 =?utf-8?B?WGpvVllSM2hTTlc1ZHNqamFWQ2FPL1R5MzBvbkFZOCtXWER4M1IxRFBqWlZN?=
 =?utf-8?B?STVQSVp2TGR2WmpXRkszZUZEUlR3Qnh1TEk5enQ3VGxTVEtMMjJwK2psVTFB?=
 =?utf-8?B?R0lnaDk1NFhQTVJkL0hEUXRtcmx1eHJpWDZIcWpqamZtZDhkN09DM0hiZFRw?=
 =?utf-8?B?UFU1aG9uMlFMbWk5aWd0WG13QTRWQVdacHRvaVBNRXF5RUw5VldNU2dpcUpP?=
 =?utf-8?B?SVl1Uys3d1IrMUpCNUVYVytZditVSm43Rnhqa1g3RCtVeExjSHkyOTBDTlBq?=
 =?utf-8?B?WHRld0VXT2RhVVBNUDBWampjNXNORUR0ckVld1RtUE9ya2RtUng4U0JUV1I0?=
 =?utf-8?B?cmZpVytPNWZka0pRV2p2OHNTYXJqMWhuMUs2SXBiM0NVSFllcU12OXh5L1dt?=
 =?utf-8?B?YTN2amtxTmxSMy9GNDgrZ3hZVTJZR1BhUEJWaDVNZFQ1RWdQc0RwMWVqZlUx?=
 =?utf-8?B?SGpYV3M2b2ZjMGQvTHhKR0Y0OXRMbUJmSXlIZVdCdGhmTy9BYURNaGJKUXFF?=
 =?utf-8?B?aEJ6aHREcWRsTUpVNGJxZG5QWElkMW1uc1R0ZEoxOTRZR3RaQlRhWU5jWVUz?=
 =?utf-8?B?MXFhSjBYS0tjeVZwSFY5RDdqWTUwU2NIMXUyVGd4Y1F3ODM0ZmFtRnRjSElX?=
 =?utf-8?B?VFlMZVp5bjFOMXlTbkVJbVZjSkhMYzJSdk9PL2cwOERaOWNuRG5UR0svUWdS?=
 =?utf-8?B?a2M3eVR6c3g4YXJBajh4emFiMzVwYzFWcDVBRzVmQlJoYlFha0dGWTZtWnVa?=
 =?utf-8?B?UWV5OExxNCthRWV4L2NINnYvYzkxN1RqbGwwb1hxNVZTUUtSMUV6ZmxrTVEw?=
 =?utf-8?B?cmU4UXBLQlhUQ3M3WWt3THVUQzhiNjVYMU13ODdRazJJK1c3d29iY2NPZnkz?=
 =?utf-8?B?REIwOTFTeS9CRmNrdWtRRXFpVmw2eWVHcWNDQnpqeWI1ekFidFREM1ZyWE1r?=
 =?utf-8?B?anVROWI5ZDZreCtQMFBvNFkyWlJ5RlgzS2JycG9VaG5SVWx3R2FtQUc0QnFL?=
 =?utf-8?B?bjBTVkVVekkzK1pSUFBTNHM1R3ZMRFAxNnBvVHlpZ0F4bVF3UEJENFE0bFBw?=
 =?utf-8?B?RGxkOFpJdTFmM212b1JEUGVLR05XcU1CaVJoQW9NZ3YwZVNlbXd2STV0RVpU?=
 =?utf-8?B?VWpMZXg1U25QNms5SW03RnkrTlpvWnZVUThBZWErMEhuTzBISFVUdW41ejJT?=
 =?utf-8?B?WXB2akpiZ20zY2ozQXBoOW1qb0U1VUx5K1ZYMGRZMnR1eHJPWVZYakY4dkVV?=
 =?utf-8?Q?z6DcYQ66CpfZFCWeU4sEnvB887E6uWrM?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB38911DEEC1C24C06E4C272D5811A9HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6abb3e2-aeb5-4b8a-2bb7-08da0e43c0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 09:42:18.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6rcVb3qjdPkV6gsvktuuSlJEKs+dsX0+jFLYgpsIEiTTKRRHVKQGsJUgKOOxdrEOR3KIUALJlUC9ZIfJhlu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2386
X-Proofpoint-GUID: 4IcTWrDZ6lfTSMUiqhfRHnO6caQvwiZs
X-Proofpoint-ORIG-GUID: 4IcTWrDZ6lfTSMUiqhfRHnO6caQvwiZs
X-Sony-Outbound-GUID: 4IcTWrDZ6lfTSMUiqhfRHnO6caQvwiZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250054
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB38911DEEC1C24C06E4C272D5811A9HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

ZXhmYXRfdXBkYXRlX3BhcmVudF9pbmZvKCkgaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgd3Jvbmcg
cGFyZW50DQpkaXJlY3RvcnkgaW5mb3JtYXRpb24gYmVpbmcgdXNlZCBhZnRlciByZW5hbWluZy4g
Tm93IHRoYXQgYnVnIGlzDQpmaXhlZCwgdGhpcyBpcyBubyBsb25nZXIgbmVlZGVkLCBzbyByZW1v
dmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNv
bT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogRGFu
aWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L25hbWVp
LmMgfCAyNiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9u
YW1laS5jDQppbmRleCBlN2FkYjZiZmQ5ZDUuLjc2YWNjMzcyMTk1MSAxMDA2NDQNCi0tLSBhL2Zz
L2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC0xMTY4LDI4ICsxMTY4
LDYgQEAgc3RhdGljIGludCBleGZhdF9tb3ZlX2ZpbGUoc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGV4ZmF0X2NoYWluICpwX29sZGRpciwNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyB2
b2lkIGV4ZmF0X3VwZGF0ZV9wYXJlbnRfaW5mbyhzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqZWks
DQotCQlzdHJ1Y3QgaW5vZGUgKnBhcmVudF9pbm9kZSkNCi17DQotCXN0cnVjdCBleGZhdF9zYl9p
bmZvICpzYmkgPSBFWEZBVF9TQihwYXJlbnRfaW5vZGUtPmlfc2IpOw0KLQlzdHJ1Y3QgZXhmYXRf
aW5vZGVfaW5mbyAqcGFyZW50X2VpID0gRVhGQVRfSShwYXJlbnRfaW5vZGUpOw0KLQlsb2ZmX3Qg
cGFyZW50X2lzaXplID0gaV9zaXplX3JlYWQocGFyZW50X2lub2RlKTsNCi0NCi0JLyoNCi0JICog
dGhlIHByb2JsZW0gdGhhdCBzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyBjYWNoZXMgd3JvbmcgcGFy
ZW50IGluZm8uDQotCSAqDQotCSAqIGJlY2F1c2Ugb2YgZmxhZy1taXNtYXRjaCBvZiBlaS0+ZGly
LA0KLQkgKiB0aGVyZSBpcyBhYm5vcm1hbCB0cmF2ZXJzaW5nIGNsdXN0ZXIgY2hhaW4uDQotCSAq
Lw0KLQlpZiAodW5saWtlbHkocGFyZW50X2VpLT5mbGFncyAhPSBlaS0+ZGlyLmZsYWdzIHx8DQot
CQkgICAgIHBhcmVudF9pc2l6ZSAhPSBFWEZBVF9DTFVfVE9fQihlaS0+ZGlyLnNpemUsIHNiaSkg
fHwNCi0JCSAgICAgcGFyZW50X2VpLT5zdGFydF9jbHUgIT0gZWktPmRpci5kaXIpKSB7DQotCQll
eGZhdF9jaGFpbl9zZXQoJmVpLT5kaXIsIHBhcmVudF9laS0+c3RhcnRfY2x1LA0KLQkJCUVYRkFU
X0JfVE9fQ0xVX1JPVU5EX1VQKHBhcmVudF9pc2l6ZSwgc2JpKSwNCi0JCQlwYXJlbnRfZWktPmZs
YWdzKTsNCi0JfQ0KLX0NCi0NCiAvKiByZW5hbWUgb3IgbW92ZSBhIG9sZCBmaWxlIGludG8gYSBu
ZXcgZmlsZSAqLw0KIHN0YXRpYyBpbnQgX19leGZhdF9yZW5hbWUoc3RydWN0IGlub2RlICpvbGRf
cGFyZW50X2lub2RlLA0KIAkJc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpLCBzdHJ1Y3QgaW5v
ZGUgKm5ld19wYXJlbnRfaW5vZGUsDQpAQCAtMTIyMCw4ICsxMTk4LDYgQEAgc3RhdGljIGludCBf
X2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCQlyZXR1cm4g
LUVOT0VOVDsNCiAJfQ0KIA0KLQlleGZhdF91cGRhdGVfcGFyZW50X2luZm8oZWksIG9sZF9wYXJl
bnRfaW5vZGUpOw0KLQ0KIAlleGZhdF9jaGFpbl9kdXAoJm9sZGRpciwgJmVpLT5kaXIpOw0KIAlk
ZW50cnkgPSBlaS0+ZW50cnk7DQogDQpAQCAtMTI0Miw4ICsxMjE4LDYgQEAgc3RhdGljIGludCBf
X2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCQkJZ290byBv
dXQ7DQogCQl9DQogDQotCQlleGZhdF91cGRhdGVfcGFyZW50X2luZm8obmV3X2VpLCBuZXdfcGFy
ZW50X2lub2RlKTsNCi0NCiAJCXBfZGlyID0gJihuZXdfZWktPmRpcik7DQogCQluZXdfZW50cnkg
PSBuZXdfZWktPmVudHJ5Ow0KIAkJZXAgPSBleGZhdF9nZXRfZGVudHJ5KHNiLCBwX2RpciwgbmV3
X2VudHJ5LCAmbmV3X2JoKTsNCi0tIA0KMi4yNS4xDQo=

--_002_HK2PR04MB38911DEEC1C24C06E4C272D5811A9HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="0002-exfat-remove-exfat_update_parent_info.patch"
Content-Description: 0002-exfat-remove-exfat_update_parent_info.patch
Content-Disposition: attachment;
	filename="0002-exfat-remove-exfat_update_parent_info.patch"; size=2134;
	creation-date="Fri, 25 Mar 2022 09:01:36 GMT";
	modification-date="Fri, 25 Mar 2022 09:42:18 GMT"
Content-Transfer-Encoding: base64

ZXhmYXRfdXBkYXRlX3BhcmVudF9pbmZvKCkgaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgd3Jvbmcg
cGFyZW50CmRpcmVjdG9yeSBpbmZvcm1hdGlvbiBiZWluZyB1c2VkIGFmdGVyIHJlbmFtaW5nLiBO
b3cgdGhhdCBidWcgaXMKZml4ZWQsIHRoaXMgaXMgbm8gbG9uZ2VyIG5lZWRlZCwgc28gcmVtb3Zl
IGl0LgoKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPgpS
ZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEFveWFt
YSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+ClJldmlld2VkLWJ5OiBEYW5pZWwgUGFs
bWVyIDxkYW5pZWwucGFsbWVyQHNvbnkuY29tPgotLS0KIGZzL2V4ZmF0L25hbWVpLmMgfCAyNiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jCmluZGV4
IGU3YWRiNmJmZDlkNS4uNzZhY2MzNzIxOTUxIDEwMDY0NAotLS0gYS9mcy9leGZhdC9uYW1laS5j
CisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMKQEAgLTExNjgsMjggKzExNjgsNiBAQCBzdGF0aWMgaW50
IGV4ZmF0X21vdmVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfb2xkZGlyLAogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBleGZhdF91cGRhdGVfcGFy
ZW50X2luZm8oc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpLAotCQlzdHJ1Y3QgaW5vZGUgKnBh
cmVudF9pbm9kZSkKLXsKLQlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0IocGFy
ZW50X2lub2RlLT5pX3NiKTsKLQlzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqcGFyZW50X2VpID0g
RVhGQVRfSShwYXJlbnRfaW5vZGUpOwotCWxvZmZfdCBwYXJlbnRfaXNpemUgPSBpX3NpemVfcmVh
ZChwYXJlbnRfaW5vZGUpOwotCi0JLyoKLQkgKiB0aGUgcHJvYmxlbSB0aGF0IHN0cnVjdCBleGZh
dF9pbm9kZV9pbmZvIGNhY2hlcyB3cm9uZyBwYXJlbnQgaW5mby4KLQkgKgotCSAqIGJlY2F1c2Ug
b2YgZmxhZy1taXNtYXRjaCBvZiBlaS0+ZGlyLAotCSAqIHRoZXJlIGlzIGFibm9ybWFsIHRyYXZl
cnNpbmcgY2x1c3RlciBjaGFpbi4KLQkgKi8KLQlpZiAodW5saWtlbHkocGFyZW50X2VpLT5mbGFn
cyAhPSBlaS0+ZGlyLmZsYWdzIHx8Ci0JCSAgICAgcGFyZW50X2lzaXplICE9IEVYRkFUX0NMVV9U
T19CKGVpLT5kaXIuc2l6ZSwgc2JpKSB8fAotCQkgICAgIHBhcmVudF9laS0+c3RhcnRfY2x1ICE9
IGVpLT5kaXIuZGlyKSkgewotCQlleGZhdF9jaGFpbl9zZXQoJmVpLT5kaXIsIHBhcmVudF9laS0+
c3RhcnRfY2x1LAotCQkJRVhGQVRfQl9UT19DTFVfUk9VTkRfVVAocGFyZW50X2lzaXplLCBzYmkp
LAotCQkJcGFyZW50X2VpLT5mbGFncyk7Ci0JfQotfQotCiAvKiByZW5hbWUgb3IgbW92ZSBhIG9s
ZCBmaWxlIGludG8gYSBuZXcgZmlsZSAqLwogc3RhdGljIGludCBfX2V4ZmF0X3JlbmFtZShzdHJ1
Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsCiAJCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICpl
aSwgc3RydWN0IGlub2RlICpuZXdfcGFyZW50X2lub2RlLApAQCAtMTIyMCw4ICsxMTk4LDYgQEAg
c3RhdGljIGludCBfX2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUs
CiAJCXJldHVybiAtRU5PRU5UOwogCX0KIAotCWV4ZmF0X3VwZGF0ZV9wYXJlbnRfaW5mbyhlaSwg
b2xkX3BhcmVudF9pbm9kZSk7Ci0KIAlleGZhdF9jaGFpbl9kdXAoJm9sZGRpciwgJmVpLT5kaXIp
OwogCWRlbnRyeSA9IGVpLT5lbnRyeTsKIApAQCAtMTI0Miw4ICsxMjE4LDYgQEAgc3RhdGljIGlu
dCBfX2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsCiAJCQlnb3Rv
IG91dDsKIAkJfQogCi0JCWV4ZmF0X3VwZGF0ZV9wYXJlbnRfaW5mbyhuZXdfZWksIG5ld19wYXJl
bnRfaW5vZGUpOwotCiAJCXBfZGlyID0gJihuZXdfZWktPmRpcik7CiAJCW5ld19lbnRyeSA9IG5l
d19laS0+ZW50cnk7CiAJCWVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgcF9kaXIsIG5ld19lbnRy
eSwgJm5ld19iaCk7Ci0tIAoyLjI1LjEKCg==

--_002_HK2PR04MB38911DEEC1C24C06E4C272D5811A9HK2PR04MB3891apcp_--
