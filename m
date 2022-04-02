Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D94EFE2E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 05:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiDBDby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiDBDbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:31:52 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D297CBE6A;
        Fri,  1 Apr 2022 20:29:58 -0700 (PDT)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2323Hr7X026715;
        Sat, 2 Apr 2022 03:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=dabxZW577wjPEGEoff5pZu2w+a1quSirUwiMnGVHFWI=;
 b=SXZf0UnbeNtaW/FdtVk0hrDbdUFL1uOn1Db6u0zP+uQdy6On8UB6IU52yly9+2VbK1mc
 9FtH50x4f4GESqM07RxSy/rSQCVAuklZ95Tb8nIM8xOsMXIFsgm7Q2b/MQaPXtqR0e7G
 pAh5l8mDfwy03sC1HPCDPTRDNVIzxVegqCtxjIRgq7XLpKZrVLkhpn6YeV4F0HI+vfr9
 Ntm+BzG1Dn4XFNmoXi/3uKGRyzDAths7KydY9KBxPey4/+PC23NgQX74Geva7CrqgPHZ
 qpSwIfAmXh88Wgmcs4tIxNG1QgI/0yyIAUcHbAEkYzYerWVAyvLBmpIY5XeMp622Awpz LQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2046.outbound.protection.outlook.com [104.47.26.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f6dbyr13h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Apr 2022 03:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex8ZBSvHLwV+Ik1f+Ce4vmuZ9OAz2vKe8kvKnnDoLRLd0OpO3t4eeIlTjquOvRmhipt11lgrd1lA4BnszqWV5fUHR4Cy8PK2SN+7pPjbOcnrZyJCcZJC/uxTj/t6v3tzETb1sx6TWAsuyEVQLGxJacB6fr2gDwa2EshQzsB3njQpeau1DLUNiN1cjl/kir8OetLCAy+/6aVbad2rFwPVYPJ4Ou/kNBjN+8U5BAn7JaL3NWrxH3omC3esJ/PMCmx7ZtiEQnst3N21llKySdi1yC2wRXi0SA70oNdBx2Vc1V4/viASp6kH8LEqt+hdthsxr7CL24NfzDIP9IoI9n8ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dabxZW577wjPEGEoff5pZu2w+a1quSirUwiMnGVHFWI=;
 b=PbcNfhmKTtMYFvCQkbZ3dAg7/P8wpTtVPaHM+WroZ4ryf2hNNH7KX21rGH+2h/Xzsic8FOn6XN5Y26LRXg8MAcandUpDRD/uJ/SZ+9mv+ehVgOkZ04nccG5pIs/TxmgI+xfwTcRMe4ciclQcZoIXUG5MGLjhoYVmG5nk/w/D8H8Y1Cf4AR+91JFrQnGVpzkl+LnMElzgzd1Broz++Dc5T7siwD4MDRFuCJwgIR8la6caSKOAL8Q7WIIUv5/XYqbF3VQgo6I0Yd5eI8sPLd/+eDYyIQffOoHM3Fu8ABHUpQax/yfhFAUlqbX5ZxHWQK4EhKpcOY+i+xQXievnaLkXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB4173.apcprd04.prod.outlook.com (2603:1096:400:2e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 03:28:00 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 03:28:00 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/2] block: add sync_blockdev_range()
Thread-Topic: [PATCH v2 1/2] block: add sync_blockdev_range()
Thread-Index: AdhGQJxpg7LpERZLRKCnO5+IYADlBA==
Date:   Sat, 2 Apr 2022 03:28:00 +0000
Message-ID: <HK2PR04MB38914CCBCA891B82060B659281E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89f95836-633d-4d11-51eb-08da1458ca17
x-ms-traffictypediagnostic: TYZPR04MB4173:EE_
x-microsoft-antispam-prvs: <TYZPR04MB4173ED47A43B0D2F9536052981E39@TYZPR04MB4173.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCoOEj9P3IUFftIExB9zzpDBnyVyQ7xsxIY4Ozqv4WorXZbdFqcggrEpvZqhXzcZ/precdx2Sp49aqowcnU9DmLg5s48cejqP7q8aeFT0p84eh0InIC90zzOZgqpyeGz0dpXT6DC/4z/l/6nnXivoUBUnOKF60dsyBn8wzQwTfxDVfe7+IoRASZ6Cs6djHvSsdVJB+XfswyY7/B7xQkuzo5ZKjwAc6QZ3Cuxh8WNa66yxle+S/oiH1AzP8+ddtgDWoWij9mqGHjGDnjEKPgwtbR5npGtRRiPGSSaJpmgv7f8+pVdG1YdZA45BMaR2PlN46JUyNC+vM/9fDg1Ntf+2SDjjDZijaxvyaoWzN1o0zOveyULAARxrTMVYl1A+XdjvJ+3iz+JldNnWfr4Amq8bhqqFg8Yq0DsIk3rOjVujTHc6fxp8fu0VhgKRJt3PaDDk0YJvTK/NihortHEZcbWzO7FI5yh6Mwy9R8EYfCfYgkY6pAmxXDHvgV4+m8Amzqmmw0z0qa6s9+g75DZkkhm2q6YsV6wDDVz/ksZN0Ij9wXTZVXr+7tGJ03StXpXtYI3GE4EyTugKPGUD20G+fVdgXfmocSv9kNoBQfzxbE+GaeE2uBgYYzDshaiFB7EIW/CnsRJs6Wfd4VuecU0lZnkH6Iay9EE/LUSkqNVisWdikJEUY+EmuzMs7WkUP00h+qTGEsvfCwsbF7P92fa2u7IDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(8676002)(66446008)(66946007)(66556008)(76116006)(66476007)(4326008)(316002)(2906002)(508600001)(54906003)(110136005)(38100700002)(122000001)(99936003)(33656002)(86362001)(38070700005)(82960400001)(26005)(6506007)(7696005)(9686003)(186003)(71200400001)(8936002)(52536014)(55016003)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlFVSTVXUjBTYzk1SE1TRDBvVnVZcjdtZEErNnNRbm41MGRlY3JaQ2k2WS9D?=
 =?utf-8?B?N2dNNmlaenhUODdNcFlaRWtlblJ2cHdJZzNVOE9TUWc0MHp0cUp2dm5BMEdo?=
 =?utf-8?B?ZTgxbk9PTUJibXFBbWFHVGIybkpvd2JPRDRyYWdYQU5lSkRjQ1Jwb09HM0dI?=
 =?utf-8?B?Wml1VytUY2poVXdtamJMZU14KzFGZzk1MUpEbkQvU0hYdmhiZ080SllNbHda?=
 =?utf-8?B?T3dGQlJwc0pGUTI4amRnV1BLUXRjbVVSRTlYRlJqNE9wdlIwS2tGSGw1SGZ0?=
 =?utf-8?B?dk5jZFI2eDhiOGI0TE5udWJMVHZ5WG9STFp6MTkwUHR6eUs4WCtvRldBWjRJ?=
 =?utf-8?B?bmVuVk01M3JOdFZwL3VwRmlQSzRSVHlDMW9ucExCeE5aaTNab0wzVWIrSU03?=
 =?utf-8?B?b3I4Z0wxUkNLcnNWTk5hZ21UaEg2Y3VyR3BGajlDUW15NGZFSkJTa1BSVTNP?=
 =?utf-8?B?VzBEUkZZcWY3UWFzVTVJWW5Na2NtVGVCaGpPeG5ubzVib0VxOFREWFNCbXNu?=
 =?utf-8?B?VWNzdVhteWsrQTlubkZMUlRRb0YzYXNYc1p6N2xkRll0UDRNSEJBTVdZMitj?=
 =?utf-8?B?OHRhNHVMaWc3bGRyYVZOVTdvSWFmcWoxMVh1VzlhSjJXRGNnaG5zWjZqZG5l?=
 =?utf-8?B?di9JTnQ1T1VVc3FyeGtIZXd3U3ZhNmR6VTNqZTJHMytmMGZVd29PK1krWTdr?=
 =?utf-8?B?U2pjamk5UjNqQXBQQ3NwNzAzcGFCM2RHSkNpZ1VyMzQ4M2VXeEFJc29mVTNN?=
 =?utf-8?B?LytjaDBqaFJGaHFxc2tsNG4vSUFKQklXRFgyanc0RmdWMTgvWlVtQU5pOHVJ?=
 =?utf-8?B?b1QyZVlsYXBlcHZNU2lBWDRNVk4wOW9CSmt0bGs4UVFxRGdNT1YzSVBsUUt5?=
 =?utf-8?B?YWhXOUdXNDZuRnNiRjU5cHRIbTVrRFFpQkFKYVFWanJDcW95aG5iY3Z5OW05?=
 =?utf-8?B?eERscEpuSEVLWW5JWloxYlB1ZzgwL0E4RW5yMXhkQnBLamlMRzVjWUJkbm1Z?=
 =?utf-8?B?MWpubWFSNHlwYzVVckkxY1E4dlNzMytsdXhRNFh0b3FGTEgvTEsrUXliZWI0?=
 =?utf-8?B?VnU3MWVGVVliQkhkSGJsZk9ZMGdvRmhWOStMRUFQSDAxZjZUUE03NjRVWTl4?=
 =?utf-8?B?ZE5DNUU2ZWIzWXdIbFUyM2Y2OWs5clNmTkhpRWJXek9xUytqWmYxZG9YVnRR?=
 =?utf-8?B?dzhER0ZaV3E1QXJIcXQ4aHlES1BFdEpRUU56UDJGYmNqVERPM0kyS3RjNVZC?=
 =?utf-8?B?ZWdHVC9wV3pxWSt1ejAyUDdtNUd5dzBhdHBkb1FTZWtnZklvU25BdkNNSk9x?=
 =?utf-8?B?cW9PTktlWllCd0xHZzhIK2dXdzM5cWUzaWVhbExkKy9LUW9SLy9BbTF5ZDFW?=
 =?utf-8?B?SnN6dE42aXU0cFRGK0VVMk9Xc2VIOGl0NzF5aUdRZnNDaWxMMVRYTU1ITnh3?=
 =?utf-8?B?cDZvV2t3L3hTWkZjZGl6eHN4M2pHMHpGd01JOHJjME5Gck1KM1NRRmlqcVVL?=
 =?utf-8?B?amlvZGw1WFJ4bmxrK1c3aWR4d0R6MlVVZXc2Ymw0ekJiSHJXKzY1SWpIOENQ?=
 =?utf-8?B?bmlDQ05WUnZKVTJUTFVuYldqbUhINmF5T05kTE9oMU5rTnRoTTdaUzk0UXVt?=
 =?utf-8?B?bWtRQWtXSXdqQWNCcVQweUtUckJ3UkxEbWs5QytwcW85N0RSVnQwRW9UcTdC?=
 =?utf-8?B?TGRvczN6c1c5c0t2cHdFYWhRK2xMaUl4ZFVqR0xMREh5V2xKcHV0bnJYMTlp?=
 =?utf-8?B?UXhTVnV3MlBXWGdHbG1lUmNzNEtFWmpFbERhTlNIcUVST3V3K2hNZVlrcERE?=
 =?utf-8?B?aDVQazBUcVNzbjJ2ckVUZzU4dWsvb1d1L3BOS3ppZytVTmppd05LV1d5d3NZ?=
 =?utf-8?B?cVF4Mjg2ZnlNVGk2ajJxcUhiTzlKRUIxRENDNFdlNjd2YmJ6VjBCdkI3djUx?=
 =?utf-8?B?UGNwNHZoTFUyajgzMWFUWEpmWWRpM1ZPbGxSQklubnU5eWl2VVVSc2kxNkk3?=
 =?utf-8?B?MlZrNHQxcVVGN2l0T3VJaHlFR1d4R2FiaUE5NlllOXZNd3pabS9uZERRS0pp?=
 =?utf-8?B?enJSZ3dsKzFkY1plTUZoSFRYdm5tVDhDanc5N0h0Z1BqcnF6YmYwQUQrV3ZV?=
 =?utf-8?B?ZmQ3UjdNbC9mNDU1Vy9MUVdWY3lJZlFHeGNKZ25aby8vRkwrYlBtYmkySzFH?=
 =?utf-8?B?SnhhbmM0V05WZExLVWhreHRlMHdHL1VQRk5sMFZBQVNReFFoSVNFa1pOalpG?=
 =?utf-8?B?eGNYNzRSdUNFeTFVSlBrTkljTlFLQ0lDSjJNWGliZ2x1MFA1VEJTN2VlbTlx?=
 =?utf-8?B?UFQ0UVNiVWtJVWpUZ3pDMCtiMEJlK3IwSEtvNFh3WkJtcC81QWQxdz09?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB38914CCBCA891B82060B659281E39HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f95836-633d-4d11-51eb-08da1458ca17
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 03:28:00.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKA4VO7ztwdj5a2d43emB9ajkW/xp3RsF3sTAARFkwprzHhqO6lrjJkSQF2cY4/8mHWj5Ie1eJqL1NLZLHQWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4173
X-Proofpoint-GUID: iOj3eWM3NREe_IZx6ofuYMokxPob8TAy
X-Proofpoint-ORIG-GUID: iOj3eWM3NREe_IZx6ofuYMokxPob8TAy
X-Sony-Outbound-GUID: iOj3eWM3NREe_IZx6ofuYMokxPob8TAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-02_01,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204020018
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB38914CCBCA891B82060B659281E39HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

c3luY19ibG9ja2Rldl9yYW5nZSgpIGlzIHRvIHN1cHBvcnQgc3luY2luZyBtdWx0aXBsZSBzZWN0
b3JzDQp3aXRoIGFzIGZldyBibG9jayBkZXZpY2UgcmVxdWVzdHMgYXMgcG9zc2libGUsIGl0IGlz
IGhlbHBmdWwNCnRvIG1ha2UgdGhlIGJsb2NrIGRldmljZSB0byBnaXZlIGZ1bGwgcGxheSB0byBp
dHMgcGVyZm9ybWFuY2UuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5N
b0Bzb255LmNvbT4NClN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRl
YWQub3JnPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCmNjOiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQotLS0NCiBibG9jay9iZGV2LmMgICAgICAgICAgIHwgMTAg
KysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvYmxrZGV2LmggfCAgNiArKysrKysNCiAyIGZpbGVz
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Jsb2NrL2JkZXYuYyBi
L2Jsb2NrL2JkZXYuYw0KaW5kZXggMTAyODM3YTM3MDUxLi41NzA0M2U0ZjMzMjIgMTAwNjQ0DQot
LS0gYS9ibG9jay9iZGV2LmMNCisrKyBiL2Jsb2NrL2JkZXYuYw0KQEAgLTIwMCw2ICsyMDAsMTYg
QEAgaW50IHN5bmNfYmxvY2tkZXYoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikNCiB9DQogRVhQ
T1JUX1NZTUJPTChzeW5jX2Jsb2NrZGV2KTsNCiANCitpbnQgc3luY19ibG9ja2Rldl9yYW5nZShz
dHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBsb2ZmX3QgbHN0YXJ0LCBsb2ZmX3QgbGVuZCkNCit7
DQorCWlmICghYmRldikNCisJCXJldHVybiAwOw0KKw0KKwlyZXR1cm4gZmlsZW1hcF93cml0ZV9h
bmRfd2FpdF9yYW5nZShiZGV2LT5iZF9pbm9kZS0+aV9tYXBwaW5nLA0KKwkJCWxzdGFydCwgbGVu
ZCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woc3luY19ibG9ja2Rldl9yYW5nZSk7DQorDQogLyoNCiAg
KiBXcml0ZSBvdXQgYW5kIHdhaXQgdXBvbiBhbGwgZGlydHkgZGF0YSBhc3NvY2lhdGVkIHdpdGgg
dGhpcw0KICAqIGRldmljZS4gICBGaWxlc3lzdGVtIGRhdGEgYXMgd2VsbCBhcyB0aGUgdW5kZXJs
eWluZyBibG9jaw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmggYi9pbmNsdWRl
L2xpbnV4L2Jsa2Rldi5oDQppbmRleCAxNmI0NzAzNWU0YjAuLjFlODVkMDY4OGQ5YyAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCisrKyBiL2luY2x1ZGUvbGludXgvYmxrZGV2
LmgNCkBAIC0xMzEwLDYgKzEzMTAsNyBAQCBpbnQgdHJ1bmNhdGVfYmRldl9yYW5nZShzdHJ1Y3Qg
YmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsIGxvZmZfdCBsc3RhcnQsDQogI2lmZGVm
IENPTkZJR19CTE9DSw0KIHZvaWQgaW52YWxpZGF0ZV9iZGV2KHN0cnVjdCBibG9ja19kZXZpY2Ug
KmJkZXYpOw0KIGludCBzeW5jX2Jsb2NrZGV2KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpOw0K
K2ludCBzeW5jX2Jsb2NrZGV2X3JhbmdlKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGxvZmZf
dCBsc3RhcnQsIGxvZmZfdCBsZW5kKTsNCiBpbnQgc3luY19ibG9ja2Rldl9ub3dhaXQoc3RydWN0
IGJsb2NrX2RldmljZSAqYmRldik7DQogdm9pZCBzeW5jX2JkZXZzKGJvb2wgd2FpdCk7DQogI2Vs
c2UNCkBAIC0xMzIwLDYgKzEzMjEsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgc3luY19ibG9ja2Rl
dihzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2KQ0KIHsNCiAJcmV0dXJuIDA7DQogfQ0KK3N0YXRp
YyBpbmxpbmUgaW50IHN5bmNfYmxvY2tkZXZfcmFuZ2Uoc3RydWN0IGJsb2NrX2RldmljZSAqYmRl
diwgbG9mZl90IGxzdGFydCwNCisJCWxvZmZfdCBsZW5kKQ0KK3sNCisJcmV0dXJuIDA7DQorfQ0K
IHN0YXRpYyBpbmxpbmUgaW50IHN5bmNfYmxvY2tkZXZfbm93YWl0KHN0cnVjdCBibG9ja19kZXZp
Y2UgKmJkZXYpDQogew0KIAlyZXR1cm4gMDsNCi0tIA0KMi4yNS4xDQoNCg==

--_002_HK2PR04MB38914CCBCA891B82060B659281E39HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="v2-0001-block-add-sync_blockdev_range.patch"
Content-Description: v2-0001-block-add-sync_blockdev_range.patch
Content-Disposition: attachment;
	filename="v2-0001-block-add-sync_blockdev_range.patch"; size=1976;
	creation-date="Sat, 02 Apr 2022 03:05:05 GMT";
	modification-date="Sat, 02 Apr 2022 03:28:00 GMT"
Content-Transfer-Encoding: base64

c3luY19ibG9ja2Rldl9yYW5nZSgpIGlzIHRvIHN1cHBvcnQgc3luY2luZyBtdWx0aXBsZSBzZWN0
b3JzCndpdGggYXMgZmV3IGJsb2NrIGRldmljZSByZXF1ZXN0cyBhcyBwb3NzaWJsZSwgaXQgaXMg
aGVscGZ1bAp0byBtYWtlIHRoZSBibG9jayBkZXZpY2UgdG8gZ2l2ZSBmdWxsIHBsYXkgdG8gaXRz
IHBlcmZvcm1hbmNlLgoKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNv
bnkuY29tPgpTdWdnZXN0ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+ClJldmlld2VkLWJ5OiBB
b3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPgpjYzogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPgotLS0KIGJsb2NrL2JkZXYuYyAgICAgICAgICAgfCAxMCArKysrKysrKysr
CiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIHwgIDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ibG9jay9iZGV2LmMgYi9ibG9jay9iZGV2LmMK
aW5kZXggMTAyODM3YTM3MDUxLi41NzA0M2U0ZjMzMjIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2JkZXYu
YworKysgYi9ibG9jay9iZGV2LmMKQEAgLTIwMCw2ICsyMDAsMTYgQEAgaW50IHN5bmNfYmxvY2tk
ZXYoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikKIH0KIEVYUE9SVF9TWU1CT0woc3luY19ibG9j
a2Rldik7CiAKK2ludCBzeW5jX2Jsb2NrZGV2X3JhbmdlKHN0cnVjdCBibG9ja19kZXZpY2UgKmJk
ZXYsIGxvZmZfdCBsc3RhcnQsIGxvZmZfdCBsZW5kKQoreworCWlmICghYmRldikKKwkJcmV0dXJu
IDA7CisKKwlyZXR1cm4gZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZShiZGV2LT5iZF9pbm9k
ZS0+aV9tYXBwaW5nLAorCQkJbHN0YXJ0LCBsZW5kKTsKK30KK0VYUE9SVF9TWU1CT0woc3luY19i
bG9ja2Rldl9yYW5nZSk7CisKIC8qCiAgKiBXcml0ZSBvdXQgYW5kIHdhaXQgdXBvbiBhbGwgZGly
dHkgZGF0YSBhc3NvY2lhdGVkIHdpdGggdGhpcwogICogZGV2aWNlLiAgIEZpbGVzeXN0ZW0gZGF0
YSBhcyB3ZWxsIGFzIHRoZSB1bmRlcmx5aW5nIGJsb2NrCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAppbmRleCAxNmI0NzAzNWU0YjAu
LjFlODVkMDY4OGQ5YyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaAorKysgYi9p
bmNsdWRlL2xpbnV4L2Jsa2Rldi5oCkBAIC0xMzEwLDYgKzEzMTAsNyBAQCBpbnQgdHJ1bmNhdGVf
YmRldl9yYW5nZShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsIGxvZmZf
dCBsc3RhcnQsCiAjaWZkZWYgQ09ORklHX0JMT0NLCiB2b2lkIGludmFsaWRhdGVfYmRldihzdHJ1
Y3QgYmxvY2tfZGV2aWNlICpiZGV2KTsKIGludCBzeW5jX2Jsb2NrZGV2KHN0cnVjdCBibG9ja19k
ZXZpY2UgKmJkZXYpOworaW50IHN5bmNfYmxvY2tkZXZfcmFuZ2Uoc3RydWN0IGJsb2NrX2Rldmlj
ZSAqYmRldiwgbG9mZl90IGxzdGFydCwgbG9mZl90IGxlbmQpOwogaW50IHN5bmNfYmxvY2tkZXZf
bm93YWl0KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpOwogdm9pZCBzeW5jX2JkZXZzKGJvb2wg
d2FpdCk7CiAjZWxzZQpAQCAtMTMyMCw2ICsxMzIxLDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IHN5
bmNfYmxvY2tkZXYoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikKIHsKIAlyZXR1cm4gMDsKIH0K
K3N0YXRpYyBpbmxpbmUgaW50IHN5bmNfYmxvY2tkZXZfcmFuZ2Uoc3RydWN0IGJsb2NrX2Rldmlj
ZSAqYmRldiwgbG9mZl90IGxzdGFydCwKKwkJbG9mZl90IGxlbmQpCit7CisJcmV0dXJuIDA7Cit9
CiBzdGF0aWMgaW5saW5lIGludCBzeW5jX2Jsb2NrZGV2X25vd2FpdChzdHJ1Y3QgYmxvY2tfZGV2
aWNlICpiZGV2KQogewogCXJldHVybiAwOwotLSAKMi4yNS4xCgo=

--_002_HK2PR04MB38914CCBCA891B82060B659281E39HK2PR04MB3891apcp_--
