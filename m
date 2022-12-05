Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951BA64227F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiLEFMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiLEFLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:11:53 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C70D13F09;
        Sun,  4 Dec 2022 21:11:28 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B544ADp000617;
        Mon, 5 Dec 2022 05:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=pXIxG9ozhfeRTtlPOdXCaAX8WiF/PfCfAMHLcwuNYFk=;
 b=mt97YA4aIWeyU8uT1lcOcuggPeABjjXqXLwT7zlm0DuPs2wLfyjEixaiqY2o+vxXjYoZ
 7YgZWBhJBY/9FD/XiwfoYBFTA9vyOdtBYkHBlOd2DkZgFpg3jdE7PcJYF3TDd7U81Gsp
 4rCevyZMw4tBxQVYsf6bZKkvxqpW+qraIfeNZtDwZO8+XluZqxPdrK8c9rhYL7GZOTEu
 AHZmK0m+1MjvDI1VXm13BGNz1Hoc2BYN0WUTpQTGaqrAkJzUI7fsxEDM22c+0WSY8Gsj
 nA73iAM9dMXb5ga5ZJpRfILp7yOTFgnlajC4zX+hNOrpVbOYRSZfHF3BWSrIaOSSRTr8 vg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2049.outbound.protection.outlook.com [104.47.110.49])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7ycb1aj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDgnYLvrc0t1J5jXDnU+LkxUuMiTwLZfJ9J58vFE7vxvNHTZGLrlwwCcXWxpzA7cGUZKL/qbLhvSqozUKR6xhdV5ogD/pe77bXFqx/BQ9cbRUnlJA2P0gvcgrvT9ZWARO2HErqXYypFZLdOjh4WDM+6uxdkajrsbBjal7ZbdXAKK2sIsSnMUFrol4exNbmBVCh7e2Vn+jFkMCvx467I3Z2qT0mBwa6ktbuq8JFYZQUg+ZNkxnCdgDwVa311Te2NGm63xGNiD1Tm+v5ul41hxi1ZmROjpSpOL+CE2yVzYdh/Q0JK4rMuXueHEXeJop1lAfDUa31yEn0GnIqOEmYs84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXIxG9ozhfeRTtlPOdXCaAX8WiF/PfCfAMHLcwuNYFk=;
 b=I33oBkP9CulASWpr3xZWNWnkcUfmE7b26f/DoA0nU0ngrI03FfoHQylPqEiqznOO2F6+PBFtUIl+6pWFEeB0ruoZv8TV++YXzdATeBgEnMXQRV9fDuDVOVWJAO0NAVGKSCsGvuS8YloY4kEIqvbqOfYIOtX24lKg0ZdFCP5IJ6c5CH5arCsDWBt3oNEDwQLrWLmsdFhNPg+oxB8DvqPZFNRgxXudx9SfEA0hOysCegSahAfMoOsM9ejAlul+v2F8Ub1KTvs6AZKRlyeSyTvEE6IzFelcPcFnzhBgnrssHG6FOm4ZfC0Up4+wlnDLX3oXIUc2UHaPUTfXLuArvlxWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by HKAPR04MB4035.apcprd04.prod.outlook.com (2603:1096:203:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 05:09:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:09:54 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 0/6] exfat: code optimizations
Thread-Topic: [PATCH v1 0/6] exfat: code optimizations
Thread-Index: AdkIZ7zMZCitIQ8VQiu4HxnU2BjjZw==
Date:   Mon, 5 Dec 2022 05:09:53 +0000
Message-ID: <PUZPR04MB631603F0661D8DF28473307E81189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|HKAPR04MB4035:EE_
x-ms-office365-filtering-correlation-id: 809a5e86-b3fc-4f64-91b2-08dad67ef201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkFcH2rqEKYvZHri3VYdPk57+jT/I7MoDjwhlg/nNDbBis7xaAElCRpQ0TCJZZPDEpQeYTxyGJETAJggKrnaauECwuzNtNIOnwMVQPl2c+gbiKBDGyWwKM9ebtLSAJKfsETFMOBfumDZdgwzEnWfGKefx5jAYO6VscL2ds8IptLtLzxtIeFQMrtf8ycDtHs5mqrq2o59K05XFAmAYErgqNEdNpzNNHmDhwk4H1x2+HhWrSnFqGJc4luq+Z2aXIB82GU4uQc+GsMA/byoKE7GYDTfRWAtp72BDggaz1YZA6osU56yPsmI4nSWCyXJcmhGss+RkJ/HyZwyBchVOhsbWiWXhjoPKPG5lNwKYaEgxFYzPHsMUGzTsEE6vXULFDxnT8wdPSi8DaImRZ8WScZNd7AyZ/Vb6cULsICjNEZyEvhfaV1PztWvJk6GYZO/1wjuxjxb5Jd+BfsTd3h99zy900SYJnbv44aRj9LMVDHqP9ITUla2PWKT8zv2yVYP5bOiHLr2q5EHCwLW3w/rzmb3+A4ZdiyVq4uKyQyFwhQ5XK4sL9/r1nuKcn7ywsW+2HNnwxV/IqwO6UFwzrOb/iePA4sHFDWtbFdaxccqH/plTyDuBbyl7GF8NkpBsbWXJg8tu/W6dwUw70827t1Ziuiw31zwnXZsmks4m3zmPApsmcP6Lky9gnT14tJ7phzvFiM1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(33656002)(82960400001)(2906002)(122000001)(4744005)(41300700001)(8936002)(186003)(52536014)(5660300002)(38100700002)(86362001)(83380400001)(38070700005)(55016003)(54906003)(66446008)(110136005)(316002)(66476007)(66556008)(64756008)(71200400001)(76116006)(4326008)(8676002)(478600001)(107886003)(7696005)(66946007)(26005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlE4eG1zRU9sMjBXQjVIZjZyZTNjRzlHZnRFVUFReXc1cWNwTDFPSldHSDgx?=
 =?utf-8?B?UFFTRVZ4Njkwais3aHFPVS9QSEl3L0c4elRGS0packV6NzkybldtbE9SZmt0?=
 =?utf-8?B?bGptRlU4Tncxb285aEx4R3o0YlZRajJsYkNnVkZWa1VCUk1hbFhlQmJJdWJj?=
 =?utf-8?B?SFdwZjNSVG9RaVdMZ0VkdEU5Q0NHUGNSa0pWNjA4VnpmY096MUZscmVPOGk0?=
 =?utf-8?B?bXN0UVRoeVVseTZUKzlJWDNYeDBBeHUzTVVzT2FwSkVxNFpSR092ekFzUnJi?=
 =?utf-8?B?aDJzVkZKVVcyRHkzNHhYeWJWREpmR1VuTVo0dzZEV0p5aHZLSnlHZm1reEpN?=
 =?utf-8?B?SUxRMzNTdVJtQWl0VVJqUGdsUk9talVHK0NkeXpFK0dPY3A2Zjl0TDYwL0VF?=
 =?utf-8?B?R251eUNvOE1mWmR6TTVwTFM5SnpXNnNlVk5WMFkzTGtoVWFkRzJBdXBLMzl1?=
 =?utf-8?B?ZDRzWTRiYVVua0drWFBhdFRWUjQ5V0tyY202MWM0QVRaV3kydmplWDRLalYv?=
 =?utf-8?B?M1BaWXN3aFV2ZHR2VGx3SVVPOFc3b2RqWHN5VE0xQkg5cUpVNWdtVnErS1NN?=
 =?utf-8?B?cTdZSFVaRE8wdDJXczBoaFpFZWs3d2dpRnREcGRib2pMUmpNbjZKaEgvbWlY?=
 =?utf-8?B?bEFEYm5jVnYwVnZZWmJ4YVNhdW1EemZ6ZnU2TUFOaXBYZlI5Tm45cVJ3OEFN?=
 =?utf-8?B?QXpRVnRzSEhOcXE2MnhMakZ6SFJvcnBLdXY5em12R2RqM1l4TXJMMnZWN1pv?=
 =?utf-8?B?OWp5V0VzbXNhVCsvZjRQL3l0WStObzQ1TG1OSGRwUk5qblRYMG1SVlhpUmV5?=
 =?utf-8?B?NUJrQ3hMdGdYU0cwNDd0dFllV1V1akFkVC9FdGx1aFVvMmlacm5Ob1hMcjRo?=
 =?utf-8?B?aStrdWx4YjJ5MHhJeHFETS8xSHpBSjNPSklKbEczZ0t1TWFKZDh1cnVxUlA1?=
 =?utf-8?B?c3oxNDhEUUdrYlF5VWpsT3FXTE5aNFR1WnFHMmw2UDVBeUVDS1JQR2pMRy9z?=
 =?utf-8?B?bWZMZlNvSVZoMU1MSzUrLzdHMml0Q2VxYjJibU1zRWZoT0ZQbTlvS3JMbGFq?=
 =?utf-8?B?N2xkMkd1RXd3YlVPNEVlYUlOQ3l5WmpCUmcxRlNVVmd3aWFQa2F1YXVraW5I?=
 =?utf-8?B?UVliREFTTHZ1c1d1cjZCeEVqRmVTTmhTTUhobmExUU01bzN6b3ZHcDZXVTc1?=
 =?utf-8?B?YnN4cFRHNTJ3NlJaMFdraWI3U0xlUDRxb3NEbzcyKytsQkNsQ0x6aDB6Yy9D?=
 =?utf-8?B?NXhuTkVubHF0dDlld3YzTG9pNkFKVG10TWZrUTVTRWs3RXFySWcyci9JaFRE?=
 =?utf-8?B?Wm5vTVBZN0NwZ1JpS3ZtaGdQZ0tOVm5NQmV3SDJJQ24wem0zd0dQaDN3N0lz?=
 =?utf-8?B?U0JhWWFNODBDQk5RVmMzMFFTWjFoQmNHMHFzc3VHcGNzZGtTT0QxNlVxUTBM?=
 =?utf-8?B?TTNKSXhvT1ZrcXRLQzJzN00yaDhzaVRyZ3NoL2dQSVpCVkxTVnlrY1N6MUVG?=
 =?utf-8?B?a05zTjYrTmwrL3JDRWZ4MFY2cVZFZDJnNWRQS1J6b0tBbVFLeTZhRFdDWW9x?=
 =?utf-8?B?d2VHenVTZExQQ2lMKzJYeHpCVkRUN3VpRUJwOUFZS0pTVTEyRkRGTkhFUGg3?=
 =?utf-8?B?SlpvOG5aQnFHeDR0N2RXaDNMbC9vU1lFRUFJUE1yNEZWN05CbW5XVXoyZ1BM?=
 =?utf-8?B?UUlUQldsTForQkkrTlUvcFhLL1pGRnJnZUdoaE1YdFNUK2FxTlUxZGV0VHE2?=
 =?utf-8?B?OGxCRnNXTkR1SFlTd2kwdXkxdExPTE4vZ241Y1hZelBHaU9wNk14Zi9QRWd6?=
 =?utf-8?B?UlBGdXJHVUZ4MTlPY2hkWlhoSWswbVlIQmt6T1kvN3hTbjZrb0VHU2dXQnUx?=
 =?utf-8?B?OFIvWFl1eURkTmNPNytFUTNzbVlSMWRPUDMzMnV2dzdUYmhZYVVLR2xNRkZ3?=
 =?utf-8?B?UjF6bFp2VEtGTU9mSW1zSm5XbkpMVmgwZW9ZNDVSdXE5K09BTk9GV0JiaVk2?=
 =?utf-8?B?anFUeUxaMDRwbkxPd1RwKzcyQ0pINVM4MTE1Z0toMG5CTHhkQVNUWVRpMkFI?=
 =?utf-8?B?TUxQUHNZR0x3MXB1TWI5Mkdtejl1bVdIN0xNSU5zOHdzdE9BRnBkZ1lQdkhC?=
 =?utf-8?Q?TLlTVdbxvJEhCd2l7Mvn2TyIi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aUBycBX6olBmfoiFjyTBDwg2J0gg4ZMz1gS5QRVkaZPpOZll5pH6T3yL0E2eejlRlHYVZ7RfReNh/CIYUzSMzq2Gcc0i/nyH47Tbt3srSWkLeHN+//drev5+oEMDeBU/+4PXK4lukPqPgCnhbJ6qaPFvKvyWkNJoRIT0DYbMXOMtLoKzFCWwOS/ygxfVHkbtvWEYB/kRW6IzGZO6T5GY5Itn2LOGXKDdlN4lr+A5sH31PlQvhLlqBKv2RwgWEOzrgToFvCohGLEBHd7j/NC5YpX9sGKjrlmf7GpQwZX+X6VC+NUJegD2npQLVCDf7YZMr2yvJ36VHf2M8OzAF3DQCmC3xp63S68lz7MPiM/lwru/4gAYw6eHeEh1l7SPIxwLAZemeotRUTeN8CE8fmSAC0aZLtRLIOO7+Z8HCF+TGAj/6g2wmTIr75i4kV6fl75YAXGIkVAm1fUHu8THaoIbfgxhTaBxHdq6Gh3GLM8qQKAoqUenLE/3mfiC7063DWiiG6SBseTZWupl63fUlUM7L7vapY6wlD9kuCgCfutESVO+fElGYSrCBvVY5BeFh67kr+LELeh/LeD+gEHsULJGywCWc6W6IZx0uWp13HU95Fj54KXAslMUs7rPQNvSWrmQNsswUMxY4lfrZr0Cca4Jcf5Ya5zVskhPCH3tSqLK9m0+dZPaMAxkGDPRb3sU37zz5Ib3Hg8DgehWdti2jRqi+UfDUmMsbrVoJaeetrBJ+Norso1+bsRJhE/k3KRfpHWe7fb4JqQYPv2vONnqzmmOgrl3lD7ppd9DK/SSEoQV2y2RxjTR0fLWyXux6yWLbDfatRWLO++3maVpYjwpx/G9mO5hdhfMWa7T/7OLYCf3ApFbU3ZLIctZp6Ue6vYmPk3v
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809a5e86-b3fc-4f64-91b2-08dad67ef201
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:09:54.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnxsj+UKuoSRKRHIm4FyI7biXMB96muCAl7x7gGUmXC+o/gK4rKjLZsANFdP3QwVp7zOUP27AkJ3nNGPQNHe7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR04MB4035
X-Proofpoint-ORIG-GUID: XSng6IOv8iTPT9J73fhaWFIFrPsCPPEf
X-Proofpoint-GUID: XSng6IOv8iTPT9J73fhaWFIFrPsCPPEf
X-Sony-Outbound-GUID: XSng6IOv8iTPT9J73fhaWFIFrPsCPPEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBwYXRjaHNldCBpcyBzb21lIG1pbm9yIGNvZGUgb3B0aW1pemF0aW9ucywgbm8gZnVuY3Rp
b25hbCBjaGFuZ2VzLg0KDQpZdWV6aGFuZyBNbyAoNik6DQogIGV4ZmF0OiByZW1vdmUgY2FsbCBp
bG9nMigpIGZyb20gZXhmYXRfcmVhZGRpcigpDQogIGV4ZmF0OiByZW1vdmUgdW5uZWVkZWQgY29k
ZXMgZnJvbSBfX2V4ZmF0X3JlbmFtZSgpDQogIGV4ZmF0OiByZW1vdmUgdW5uZWNlc3NhcnkgYXJn
dW1lbnRzIGZyb20gZXhmYXRfZmluZF9kaXJfZW50cnkoKQ0KICBleGZhdDogcmVtb3ZlIGFyZ3Vt
ZW50ICdzaXplJyBmcm9tIGV4ZmF0X3RydW5jYXRlKCkNCiAgZXhmYXQ6IHJlbW92ZSBpX3NpemVf
d3JpdGUoKSBmcm9tIF9fZXhmYXRfdHJ1bmNhdGUoKQ0KICBleGZhdDogcmV1c2UgZXhmYXRfZmlu
ZF9sb2NhdGlvbigpIHRvIHNpbXBsaWZ5IGV4ZmF0X2dldF9kZW50cnlfc2V0KCkNCg0KIGZzL2V4
ZmF0L2Rpci5jICAgICAgfCAzOCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAxNyArKysrKysrKysrKy0tLS0tLQ0KIGZzL2V4ZmF0
L2ZpbGUuYyAgICAgfCAxMiArKysrKy0tLS0tLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgIDQg
KystLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAxOSArKystLS0tLS0tLS0tLS0tLS0tDQogNSBm
aWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA1NCBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjI1LjENCg==
