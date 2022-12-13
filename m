Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7976864ADC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiLMCiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiLMChp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:37:45 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5411DA74;
        Mon, 12 Dec 2022 18:37:10 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCMhFAS024500;
        Tue, 13 Dec 2022 02:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=gsSgag+OzMW2awXOZeMJ+owPNW7EBzItiG79Zvj+2Z0=;
 b=HAj8uQDNy2TsbfPEj1+XdfU2WG2XWBSlvBvx8KyajzhQfm7MOzKannYBKsmSwjy6N/4M
 yf7wPQYKgiltfFRshnaCzXF6NhiJyafRJg1WdUwpIMJaeYpfwLh0KHDWRalxsxo/JETa
 GhzjChWGRdWVsBbSvWGMb6LUi0MRnBsipZVY9eHDsaEm92Aux8w9sfNvwciQOJ/SMeSo
 UZOLw96AVuAaSwUx9ojjueF5P18wcLsPif8IqA1OO3TQWF/EfqWAvcRaqKsR43oe+WMC
 UAYlGSGQrWurWFzSD3nP5PykjkkXyHmT2zdZ3JwNedCPj5x9OJ7WI+5dn+PFc4PFznhe uw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2048.outbound.protection.outlook.com [104.47.110.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcg0majhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/c4EepiVyzxzC2G0Ae3s+yJdz0ITgMI53pctbMtebOJpt8eOKfz787MC9ghlZFu/0/JPPUsv/oEfZVyjIZhg+REPUPKRcrmNLmkd1jHvNRtRnnTyM3znGvswXD3+GCoF0G3hH3PzK4PVE7josArMM0G1yHsItJd4MK13Ik4LVBE5aZXnDbAuS7Xv76LnpNm/SjJ2kiRfyomSXCEV0Oz0AWIxrgnMCen2F7Jyf9ZofY3iFCp5op1G4d4jNmhxYkSVK4mNTZHyn69SLeSPQOglZcWphMPXJhV4s4RKA4rwDFz0W/PDn2nimPf8HJSM6hcNnN9Kxy0Zqs/ZcFydzu59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsSgag+OzMW2awXOZeMJ+owPNW7EBzItiG79Zvj+2Z0=;
 b=IgBonLpMY3PrN7BxRLrxc9Cmod1jf03L/5S4PhGAvjnqRabMlvlv9mvsq+mP7SE3Ye1v5Ejy6lhJ9PhETI4d4f20l7Hdz8+7e+UuKTOkVO8VFM85iHvauIvHSUDIMxKumKt5CesuoGbnPJp55kAQ0zkJVTn+O4UcJOqozFciKXMhp897xAWoRDbRd5PmM30gHHvOWA00zEugfvXvGsKndbUfoQBjTkt7bF6caFq1SSyGmBap8svcsdAiOvtIbHu6GYuhitpBu+cLsy4bcN0cl0+wFiTKWrhJitqUL/qyTnbqrXOTSEEpIkO8r35bA1y3TYntKDcRXe6MVVvtBRdSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:36:46 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:36:46 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 0/7] exfat: code optimizations
Thread-Topic: [PATCH v2 0/7] exfat: code optimizations
Thread-Index: AdkOmSf6KOfX0Y5hSJCy9jICcQZvCw==
Date:   Tue, 13 Dec 2022 02:36:46 +0000
Message-ID: <PUZPR04MB6316B3802565F2A09DD0D47A81E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: b3387f82-6e08-4d19-cfd9-08dadcb2e157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkpQXwHswhlGhHmhQcUrJcINBJ8/IXqTWonthW6xaP/I+nta9il5M7wJMhOW7Iqbw4Xv786v3ypT5T+AtkW4DQ69CBDsdxN6hdaogwkKKtWRFbHlUQi/Y2rHEzkTn+1TiJ9LNTO8wHWZ/XOUsQEaXzkwwYVN3BvUDGMS3/W+HLCeEo/5UtR2S0wFQy9FKHLJGI6uTbWaQnoqgN1rXGJ5z8+4Z23VMcK8Bj0LoM+PtYBKwTivtLGQtxL6BcEmnb1Psz2cMI4ogTgp57/WSKGgbWNxvEQ17qq/7UHgCF7wYJGv3bkEp6ofuPwFHtkazL46RCC6aodVwftaIfmkNAGtQKX+s+92gKIyUGl+zTO/X1rXY/6Yw0Z34NiU49r066eHVvYK3FbUB3P9OwC/KHl+StJ08f71KN2W/72zLTGC5ekg6/oXY6jMwzTAsk1rV+BeBtPkRWbvu9ZZZ6L7ttpQ7SkGj397LO8erTIgZ/7HUphrb0DU9mDxTMUBLinX+pDff1xpFgsmOmlMwU2qm7sZbDZRuRFM6PlYia5YpdNFYF//QPPxVvnoEicCU6i5xgHZRv/xHlXBXAq2x7iAsa0dNJv/DnwcKGvFGWhj9hbr6OT24W+/RY22rz1YJ8OU0/JiHUl5K2u4UaHgJuVomx4RDUmYigJ0U2Ge90F/j2we1pFvZA0xUa8/oUokX2Y9qtcTukthM+uuqCbUxgyS3OTALg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(4744005)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTFOTHN4V0piUG5SRWJETFhGSjJMWmNxaXJmSzZ5QnFjWUlmNWhsWUlvaTdM?=
 =?utf-8?B?NHZKaVcvN0NtMnpmYXFvcmdSWHlFT3dWYnpoRlR4cFJwMTdPaFdRalp5Vjlx?=
 =?utf-8?B?dFYxeGN3THBOckRBYWU5MjJYUU9qV0JwTGRzek9YWFFWc1J2RlozYlBnaVJQ?=
 =?utf-8?B?VlhObHMwaStlV1VPMmZROEt3S2ZmaXdQUWZkeUdKLzFlaUo0dWpPTVN5Tkto?=
 =?utf-8?B?ZlJVNGtWWEY4cW9QcTlNaHZiY3FkcTYxbG9vR2p0ODlhUTRKZm84U0dqTmc1?=
 =?utf-8?B?YldQMk5OYjI3Y3FxdjJHQXlQemw4WXhweEtGblJwZTgvRHJFYzAvM2J3TkxW?=
 =?utf-8?B?b3I3M3diMTluRFp6UW1UdElheEZQMVArQkZqS01EMUFRZ0s5UDhuRFhjYmZV?=
 =?utf-8?B?SEo1Uy9JU0lKRXBOamthZ3d0RmxkVUhRZkdPMnExQUdERmZrNWpWNk9zQzJr?=
 =?utf-8?B?Q0s3aG5QVnlmeElDWmVCdVM2bHFHQzNjRDJ1MWFGTXJYUk0wcG91NFE5TjlF?=
 =?utf-8?B?WXV0bHJyaEhxMHg5VENkdU9VWC9JbmhYcThQcXNMaDZLYlE1cWk5eW1zeXl6?=
 =?utf-8?B?Lzk0Zyt4Rk5QaDR5ODFSaWJHWWJUMFhjUm55TjhmeFRDNUxCODBmNVZaNzlm?=
 =?utf-8?B?Q0hGQnRjdm5mUTVyMUpMT0lDTUZVU1hYK1hUb3ZMOUphdDc3VUxMdFBEVzhv?=
 =?utf-8?B?bzJwSnlqdWdiaExNbHRXZDVtMkljY2U1YlBNWVNQOWRUVGoxWFZhVUVNS2Fr?=
 =?utf-8?B?SXRoOHZTZHBWR2pvd0VEdjBFOFY0TTcycnRkSTJTdk9Cd3RQaUJhRGNXaFJn?=
 =?utf-8?B?S2JtZzJhblJIRnRZd2Y1RE9TTFp1Y0tTemZDcDZlODFRVXU0ZXBVZGorcFoy?=
 =?utf-8?B?ZnpRZzdGYmd3NVdvWitWRmZWSXVpQkRLY1RUVlFCVC9uOEFpNTltUzU2ZzNk?=
 =?utf-8?B?Wml1RlU0WDJLKzVUd3doVEdYSHp3cjh4RUU4R0JidjlvRGQybDRseFNrU0F3?=
 =?utf-8?B?Y0xnaGY4LzJKcUQxKzRnK3I1cXN3TDB4UnZCS3l3Sk5PYnZoaWVJZVhxay9E?=
 =?utf-8?B?cm9KeGREOE8rRm93aHVIWTQvcnlGeVd0YWZRUG1RUW90YldLYjh0bGYyUFpQ?=
 =?utf-8?B?Q3RmdHc4UFpzUEZ2Sm1wak5NTjZWcE5acmtyRW96UytNR2VnNnJGR1F0aXBG?=
 =?utf-8?B?R0NEVTNZamE3UFN1WnA3Y1JhMUFPUU11MTNyOGJ3Z05laWdDWE5iUHA5Tm9S?=
 =?utf-8?B?K2xHV2xlR1kxZUdEN2JBM3lUZllub3ZKbU1tVHRYclNKc2wwb1d1dUhMck5P?=
 =?utf-8?B?ellLR3FEbHhGUDZXVjcwdzl1MGo1eGltQ3VxNThvTzNzem9FbzMyM1VBUlc3?=
 =?utf-8?B?bnlBRTAwLzVlNDRXUDI3ZURrS1lLMEpVODB5TG4yUTFpVVZMQlRtQ1FOTTZm?=
 =?utf-8?B?VVlsSUZHOEovN3BqVm9xMmhLZXZHdzVKMzZ1djBUdlBCV3QzRG44dkJ4Vjd5?=
 =?utf-8?B?UWNJTExXaUxIclNlbE9zcVBPK2IvYm5CQ2dUSHVOQmxkSU85c1hDTElVUUdD?=
 =?utf-8?B?T0RjZVdUU3kvTWQ0c29nL0JqcmQvYzN4ZEJrRXVHZUVzMmxkTHZhaWJ3cDZs?=
 =?utf-8?B?U1pCMWgwOWJ2aWJ0QmlhekRBc1plOUZ4TVJHZG5CcEhJSkViUDVjaUNlZlNy?=
 =?utf-8?B?b0ZNV3JpdC8rZEdwUnBuei9Hend3ZUt4OXpBdnBFVFphVnQ3QnVaUG1ZNi9s?=
 =?utf-8?B?QVRkSGsrL0FTbXJpNU41MjFRRFZoK2V2dldBcDFXOVJuT29FSkV1V0h6VERo?=
 =?utf-8?B?VU5IUWFlMlFNcDVUN0RlVldaczV0Z01rdmxWQ1U0eXdrSlRCVEd6N3JPbXYy?=
 =?utf-8?B?eU03TmFjSXo3bUFxejlMbVlOQUQ0dUp2RFQ4RVg2NXZURGRIMXBLLzg0eDIw?=
 =?utf-8?B?d1d1SzE3Z3lySHhCQWZPV3RRa0c4cjI2SXdFellDMFJ5aXRjTnRCcnNQSmdq?=
 =?utf-8?B?T3F5aDVkdHhENVB6ci9Ub3NISVlZTW9GOFZqWUVQbzFEeUh3TWdCcW5FQkR2?=
 =?utf-8?B?OUNIUFB0VGJ5R3RnYStqS3NEaStaR2dGOSt4MVorTE1mVzVuc0VGTm1ycWps?=
 =?utf-8?Q?06SjZL8aFCkHed0Uu68DVIO0n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3387f82-6e08-4d19-cfd9-08dadcb2e157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:36:46.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXTgMhRPVPWqaLn1PsRg0p+4T+jvEw+I8R1EVplmfM/R5RqI/NaxPnI/4ohDN5/PVWWqm3e/X/JPrRr4l7kAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-GUID: fjwaHg5RCRCJwXc4UFakKUXtjEFSXI3F
X-Proofpoint-ORIG-GUID: fjwaHg5RCRCJwXc4UFakKUXtjEFSXI3F
X-Sony-Outbound-GUID: fjwaHg5RCRCJwXc4UFakKUXtjEFSXI3F
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

VGhpcyBwYXRjaHNldCBpcyBzb21lIG1pbm9yIGNvZGUgb3B0aW1pemF0aW9ucywgbm8gZnVuY3Rp
b25hbCBjaGFuZ2VzLg0KDQpDaGFuZ2VzIGZvciB2MjoNCiAgLSBbNi83XSBbNy83XSBGaXggcmV0
dXJuIHZhbHVlIHR5cGUgb2YgZXhmYXRfc2VjdG9yX3RvX2NsdXN0ZXIoKQ0KDQpZdWV6aGFuZyBN
byAoNyk6DQogIGV4ZmF0OiByZW1vdmUgY2FsbCBpbG9nMigpIGZyb20gZXhmYXRfcmVhZGRpcigp
DQogIGV4ZmF0OiByZW1vdmUgdW5uZWVkZWQgY29kZXMgZnJvbSBfX2V4ZmF0X3JlbmFtZSgpDQog
IGV4ZmF0OiByZW1vdmUgdW5uZWNlc3NhcnkgYXJndW1lbnRzIGZyb20gZXhmYXRfZmluZF9kaXJf
ZW50cnkoKQ0KICBleGZhdDogcmVtb3ZlIGFyZ3VtZW50ICdzaXplJyBmcm9tIGV4ZmF0X3RydW5j
YXRlKCkNCiAgZXhmYXQ6IHJlbW92ZSBpX3NpemVfd3JpdGUoKSBmcm9tIF9fZXhmYXRfdHJ1bmNh
dGUoKQ0KICBleGZhdDogZml4IG92ZXJmbG93IGluIHNlY3RvciBhbmQgY2x1c3RlciBjb252ZXJz
aW9uDQogIGV4ZmF0OiByZXVzZSBleGZhdF9maW5kX2xvY2F0aW9uKCkgdG8gc2ltcGxpZnkgZXhm
YXRfZ2V0X2RlbnRyeV9zZXQoKQ0KDQogZnMvZXhmYXQvZGlyLmMgICAgICB8IDM4ICsrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8IDE5
ICsrKysrKysrKysrKy0tLS0tLS0NCiBmcy9leGZhdC9maWxlLmMgICAgIHwgMTIgKysrKystLS0t
LS0tDQogZnMvZXhmYXQvaW5vZGUuYyAgICB8ICA0ICsrLS0NCiBmcy9leGZhdC9uYW1laS5jICAg
IHwgMTkgKysrLS0tLS0tLS0tLS0tLS0tLQ0KIDUgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9u
cygrKSwgNTUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4xDQo=
