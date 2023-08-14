Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE6277B6C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjHNKdm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHNKdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:33:15 -0400
X-Greylist: delayed 101 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 03:33:14 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE510C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 03:33:13 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E9fxDq006292;
        Mon, 14 Aug 2023 10:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=GUCyaAjXVopjKV1DPZBOSKaIiCkPEi5LuZHsMHoY31c=;
 b=hm2HhV3CXlkrHRdsczZ+JOZigtC40oXo1Y1BfFWvOxDueqecBlinXOcho58n9yDqmTAQ
 ootcvMYV5p4yJsOpS2VMesvf5Yp0fVNvf6EgD+mCxfhwkxW/nUMAC5uAKvRHLtS79xYy
 0776Nm45HA/hP74Whrwiyp2H5lj9P7tuIk2hNTIgwtg8JxysZXd0t9QZNLpgiEXkD4R/
 COBsa98wwstf8Pw9yDFWsMDWw143VfQCbRyvHXBRnVGJvIvPdKuS3Dud6ftKOgyLi1WP
 RLPbHw++vGvRFt9jEbRTfD8AKEI07rAW3HQzJ/1XWvfQHVdK9KqeHKKeNC97oxviQDia tw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2049.outbound.protection.outlook.com [104.47.110.49])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3se2vc9enc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 10:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbLNnoTASRWw5kSbvEZ9R9kZ1S1xGT9+ghnQE3GnQiC9WgFhIHM9xPuWtPQE8SrKCmpnRa8Vw2T/OiDOTUCuZBIY2brKsQv9hnu2j3mXIagtmDe53H2WPJSW8sIdZ38dT3laVNaxSqzC/cX82BvyGwS1NpEfX3A8FlQGx60wheoBAOOi/fnUSsYmsf5KWODJTbhPBAh12N64uguMwD6Ku4M2PHaudTNRHf1WPBlF3+OmA4xjYmumVcqDx5OpJ50xLM5je2/lq4uS2pH4nIKShaXq/bc9urlLu5MQBf6DuSf52SMcGDHZUR4+PB9g/kMfShjvvS+Ojsxw/JqfqTIdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUCyaAjXVopjKV1DPZBOSKaIiCkPEi5LuZHsMHoY31c=;
 b=V6uUM6/G/VyT48KQVXNIarjs3KpFcuTT1+tDVsrU0E0iteERlFgKPL9fGD7p9iystmum5GxhaopkvLXJUx130/UcCN2ya+Uz2Qtj/7mC0w7e46qGrWt6KR2V6y++PZuS3zynLQKMiTc+9/tTHC+EnnQO9il2rahJdYJGuzt1q+TC54Nc0kIcz3Aey5J2XHm4oUl3dFkSFcwy0ksjFJ2PRCbtWkiZTV+RG/oSF1uK+ya8i2jTfG1m4Ogev6dT9GENXBgir48V5R70HHCtMPds+KeMgR1piNFUgqFL5RgzazI90PUtnwAX7GCe04Z6RF5zCEXlazr4BWVMF3T7EoomjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4456.apcprd04.prod.outlook.com (2603:1096:301:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:31:11 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:31:11 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2 1/2] exfat: change to get file size from DataLength
Thread-Topic: [PATCH v2 1/2] exfat: change to get file size from DataLength
Thread-Index: AdmpYuJ0V9XHhCJETaqF4XX9XJpueglBfDIAAAk3PXA=
Date:   Mon, 14 Aug 2023 10:31:11 +0000
Message-ID: <PUZPR04MB631673AB1344155F9E8F2C5F8117A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB631612A7F55F8B5523E631BA8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd8F2_b3R0WG-kR1w5_T36s2wT6_QmN9M+HggygsmKmLzw@mail.gmail.com>
In-Reply-To: <CAKYAXd8F2_b3R0WG-kR1w5_T36s2wT6_QmN9M+HggygsmKmLzw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4456:EE_
x-ms-office365-filtering-correlation-id: 09d8f56b-9322-4577-6e00-08db9cb19448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EOFQd+fXkb1OvohgZSqZR0DSwJ+f6q5YBAfnzLiz0KmBIVhRiIVmiO4Auh1/90JuTIPUqTpK6PmBAY5OGQfsNtoz2UWk2uABHlD4Ek9UUAVk93GxMToih4l2LDnMPv+QpUPbHLDJKK6bB6CCyfADXMzB5sWaBZeozAbf8maKRyKPOseVqowzCHDM+CMV/JkwJYmKJkc18bMJGiLPv/SZpODgrV4ty2E0Xm48GBjTOie8Pu20BRTL4OBeqG9LiHRKR59Bf4Pz0O/Ao4MndoPSM2sOdpn8+0ATwCRxb9+nrdjKUFzZ9/VDLT7m6cv6Kr7h/rzpmibo6ty5DdYdhLbtzAVnP9809ccIJVqGGwWOX/XBfT1zso/GKRr3moLIerLtgi7eD9owMj4LBc0tUgXG0gmCcvZHk818CbFH9THEFGUIVFZUgjHmU5pJKuZi+Sb5ksBOqKlStQNhgybQRqq0qtKQd9tteLuRw9r0C1flP911U1hKHdowR0KMdRXUcj4gcMwnz6XLOMi8dVyPUrw2mU40HVd9upps0ug2J2b/ce6UAsQLHitWxN5U+ZiByPf+846DN6cNu3kLagDxOCc5SjilZDvc3U+nvxD7zgXNzR2suJg8BJnKTBPMFQurUcg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(186006)(1800799006)(7696005)(33656002)(71200400001)(9686003)(54906003)(478600001)(55016003)(53546011)(107886003)(2906002)(26005)(6506007)(4326008)(6916009)(316002)(76116006)(66556008)(66476007)(8936002)(5660300002)(52536014)(8676002)(64756008)(66946007)(66446008)(41300700001)(38070700005)(38100700002)(86362001)(83380400001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTM0UjJtN1ZuQVBSSVQrK1h1OWRNaTNnVGVzWk0zTzRHbEJLL1dhNmV5SVJK?=
 =?utf-8?B?RVJWWkFqQm1UVW9TNlpiV3hHcjFpQW9qME1lU3NkN2orTUh6UU1QTU5DNlVP?=
 =?utf-8?B?c0J2SXZMZm5uNk41Z0w1MllMNUl3SWZhbUdoVUY5Tkc1SnJnc3R6SFRTNDU5?=
 =?utf-8?B?QlFiVzNVdmdINUxFUDJYNG1hRndiWkVSUXBnTzVaR0J3RVowVDJJQ1NrbjY4?=
 =?utf-8?B?Qmp5Rm1LZmZSZzB2cENxcERIMi84dHVjZmF4QzJ5OGNYUlhTWHhHekduTG8r?=
 =?utf-8?B?c2EvSUVucHVCUkRDOXhzMy8xOWlxYUNacnh0SFdXT2I1NG1FWnNNSzlXcTh4?=
 =?utf-8?B?eE5UaVM2SjF5RS9taHNXV0ZXZlB5a1BDalVHVXZJVzRGbjlaT3Q3WjUydHo0?=
 =?utf-8?B?ZXJnMmFuZk85SVd3WWd0MmZKWHdLd29OMmNpVzdkOXg2WnN4YVhBSVV0bmJS?=
 =?utf-8?B?V29SbG9xSnVpZm5zbGF6OXFIL1JTU2IyU2ora3lNUVlGVENBSjJCRnZhbjY1?=
 =?utf-8?B?ak1JZ28rWiszdUIwb3g0eFprLzV0OVdhSFF0SWUzT3dZTnR1bnNwNndDUDJj?=
 =?utf-8?B?MXV1NEltSkluaUF6UTVNQWxaK08xNW9LY3BTMWNmT016R2RkbHQxN2RiaGlx?=
 =?utf-8?B?eXJkVmpkTGo2UWMrem1tNkthRTl3NEJvbWtBVDJPRUZVbDJxdmhDSWFYNDNu?=
 =?utf-8?B?SVhwWm1YU1U5OUwrTEJXY0VndytZdEhlc29TUmtpeUljZFlhZy9CWFhSSERQ?=
 =?utf-8?B?ZXRCU1RHQTh2VjNuVkZKeWJHSEdhSllKeVROMjl5aXhrZlZuR2xLKzdrSVZD?=
 =?utf-8?B?MkdZMDZ0VXpMdDJKZlJPWnBqaWptNEY5Q1J1aFRsaVMyOVJ0M3FIWFBuVHFK?=
 =?utf-8?B?Z0lzVCtJcFV1R3dlcTZneDE3em5nUGRDL3I2elRoRXJuQmlRYlJFM2YxNkFR?=
 =?utf-8?B?OUFkNFVwbDRKUThyWFVlUC9KbTUrbjl1UkdWeFdWTWc3NUtFYXJmMU1SbDdj?=
 =?utf-8?B?NGNUR3QwVFNRN3FBbzIyT09wbWw3STVTQ0Q1LzFSM1llNFk1cXpzaGFYaHJ0?=
 =?utf-8?B?SUhwR0lQcXByRENIR0FzdVBLRmlxWmVrbXJNTDBRbWRXRXJvRDZtVkZvenR1?=
 =?utf-8?B?aUZvOC9mOEQ1QjJTYUk4ZHpFOWZrdDVnYko4WXRyS0hGTC9hYnJwNUt4STJS?=
 =?utf-8?B?ZlJKVDFrK25pek1IMHFSYVlINTBrQk04a2xCNCtzdXV3ZEw1T2RDZTI3Z1JF?=
 =?utf-8?B?UDhHUXhZK3hOUkxLblVtSytTTmVoZlVnaFJXL0VsNVFpMG1kUG5sN1kzTGVS?=
 =?utf-8?B?dFFUWnI1NWwyU1J6V0l0ZmFvZ25XRjQ3aHVXVUQxTk4xcHRBaUJZcS9ZRk15?=
 =?utf-8?B?ZmFhM0paMHhiV1FMeVFydXBBSDVZbjE0eU9uNytVZEQ4YXBkWjJvRGJWSHRm?=
 =?utf-8?B?eE8rZ3FHT3FpTGdlUTRSU0xSZHM5U2lhU3JIM0RLQmM4UUtnZnY5aWg5emxN?=
 =?utf-8?B?Ui85WEYxbGplVDFmSTJZZGt4aFBwa3MzNVlyVGxPS2JhTk5mUDAvUHBEL3Bt?=
 =?utf-8?B?TzNNaERNKzArUFlKSGVTcmJLYkJGdDZvVEwvbXdubHZTWWgzZHdsMkNLSEx6?=
 =?utf-8?B?a0lXYWxGa1hPT1NqUEJEZzFHKzZqY1NDYkNldFhnb01RWXlTVUVYbnNSS2Nj?=
 =?utf-8?B?ZUJGc3VOVUpaVDlHYnJvYmVESEdqQ1J5dHo4ZS8xNzhROG1DUDNWNnJsRUR4?=
 =?utf-8?B?cWY0aFdyNndzbjVuN3E1YjFNemMzeW5NaWVwVHhNY3U4R0VMWFJ4SmlKL1dp?=
 =?utf-8?B?RHJiS0tTbnIzeHQ0NXFVcktPYkNsQXE0bm5rSEhNNFdYUjRqTGQ2bXJxbDZK?=
 =?utf-8?B?cm5EVUhDbFFlSE5Xck1Sd1J5S1NIcTl4dlhBc1dCMjNyemtNRkF6a09nekRU?=
 =?utf-8?B?bEIzajhMMU1rdmR4UDhYUnNuSjJCMy9aS3ZCTUdHSEp2b0RFQzZFdjJtOVhN?=
 =?utf-8?B?dGh6Ry9NY0pWa2x6U1RWemxWMmJYejdyYkEzTVJHL3NHRlBQcHZBeFRyWjEy?=
 =?utf-8?B?K0hDekJDYW5Tc2FkVks2QjlrNnNmN0ZxN0NGbVZxOVREb3RTd094eFBYRVRi?=
 =?utf-8?Q?PezDZc5qheJePOs6gg9S0Qpkl?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lkL7j1yCmIY1yaVyWsLt7uUvgJCCzeIbPR98PjM3jcueXQ0ch7mXdQTOZN/n+zKKUfwcFyCQe02ct8Ot6iZhDlvZKI2WDVJnDjikjp9bSn3+dffKtOWR8SRrdE74/qll/RwH15YpKkM6q52Ar/8HW8a2jqYwh8eZvf5kxT/JWwq38x2VOFwaIt97LBgS9ZwDTWrSsNuCD/21VvdYcGkWN7fiypQI9NOqqSruClV0xvt584h6CgWY8zhFlUTFMe1w01IhhA0SPJA+c922AH/9W1ncwwKiGIwwg1PTQucpziO5Grb14urHrW3q8M/O8SFJtfZgUkXG5VQ1qW/jz2vMGoyJ3d+F3RkqTA9y8IznJm4lnI90sNWQGdwg7gN/lal3gmDuB1PW23LuJtoJ0rs+2a42Gac+BJuZrQxZAt+eYTisWqr05xz9KJasJ7mz9u2v+tvbJ1K9O9E4ve6vH/3DUu/RgcDDpsqAUh3bkDFrbgqOWQZ+NULr5Tlmlx6o/6Z0FYdQcVc/4o6rIFQ0aW5bLcAoIrIA4JNB2JW4rPHaheYgdHMoFcMAdz2Ppqgr6Xzu0V4cnvrgo4RPXrXt1kYXimX8kLXdmff/NbEOfrCWBUq7CQnZUsB2sARRDttsMqPUtJ7vLBCAdZ/M6zXDCJg4GGzFOvk4FGqLOrnQ9ECpdWVDI56Ck7f4CYS0m9y1jPYO9sRhR0iyT62sAgefAeYlDQG1ePEsVw1urIfAz2XVwp4oXWxagTJMZ4RRNrmODpelj50NuyunLkdaTzvnpVtej4XbDx95AhytnzcI4DAzNFuLjA8Mh1YQbVyl10lY8l2WYcX7fhgs0xHVpklOFVZ6Qw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d8f56b-9322-4577-6e00-08db9cb19448
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 10:31:11.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tq0Q2qh4ipObdWabHdvyasfOGU0mHgxlv0usg0EHPH6iSCywEdCCsiAE9dB2TyulfAX8aom53LuR/+7xAkF7IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4456
X-Proofpoint-ORIG-GUID: BFdNSMzVBfy6ljuICbuNVo2vKxVxPLFm
X-Proofpoint-GUID: BFdNSMzVBfy6ljuICbuNVo2vKxVxPLFm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: BFdNSMzVBfy6ljuICbuNVo2vKxVxPLFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2lu
amVvbkBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNCwgMjAyMyAxMjozNiBQ
TQ0KPiBUbzogTW8sIFl1ZXpoYW5nIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCj4gQ2M6IHNqMTU1
Ny5zZW9Ac2Ftc3VuZy5jb207IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBXdSwgQW5k
eQ0KPiA8QW5keS5XdUBzb255LmNvbT47IEFveWFtYSwgV2F0YXJ1IChTR0MpIDxXYXRhcnUuQW95
YW1hQHNvbnkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZXhmYXQ6IGNoYW5n
ZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0aA0KPiANCj4gW3NuaXBdDQo+ID4gK3N0
YXRpYyBzc2l6ZV90IGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0
cnVjdCBpb3ZfaXRlcg0KPiA+ICppdGVyKQ0KPiA+ICt7DQo+ID4gKwlzc2l6ZV90IHJldDsNCj4g
PiArCXN0cnVjdCBmaWxlICpmaWxlID0gaW9jYi0+a2lfZmlscDsNCj4gPiArCXN0cnVjdCBpbm9k
ZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOw0KPiA+ICsJc3RydWN0IGV4ZmF0X2lub2RlX2lu
Zm8gKmVpID0gRVhGQVRfSShpbm9kZSk7DQo+ID4gKwlsb2ZmX3QgcG9zID0gaW9jYi0+a2lfcG9z
Ow0KPiA+ICsJbG9mZl90IHZhbGlkX3NpemU7DQo+ID4gKw0KPiA+ICsJaW5vZGVfbG9jayhpbm9k
ZSk7DQo+ID4gKw0KPiA+ICsJdmFsaWRfc2l6ZSA9IGVpLT52YWxpZF9zaXplOw0KPiA+ICsNCj4g
PiArCXJldCA9IGdlbmVyaWNfd3JpdGVfY2hlY2tzKGlvY2IsIGl0ZXIpOw0KPiA+ICsJaWYgKHJl
dCA8IDApDQo+ID4gKwkJZ290byB1bmxvY2s7DQo+ID4gKw0KPiA+ICsJaWYgKHBvcyA+IHZhbGlk
X3NpemUpIHsNCj4gPiArCQlyZXQgPSBleGZhdF9maWxlX3plcm9lZF9yYW5nZShmaWxlLCB2YWxp
ZF9zaXplLCBwb3MpOw0KPiBDYW4gd2UgdXNlIGJsb2NrX3dyaXRlX2JlZ2luIGluc3RlYWQgb2Yg
Y29udF93cml0ZV9iZWdpbiBpbg0KPiBleGZhdF93cml0ZV9iZWdpbj8NCg0KWWVzLg0KDQpleGZh
dF9nZXRfYmxvY2soKSBzaG91bGQgYmUgZXhwb3J0ZWQgaWYgYmxvY2tfd3JpdGVfYmVnaW4oKSBp
cyB1c2VkLg0KDQo+IA0KPiA+ICsJCWlmIChyZXQgPCAwICYmIHJldCAhPSAtRU5PU1BDKSB7DQo+
ID4gKwkJCWV4ZmF0X2Vycihpbm9kZS0+aV9zYiwNCj4gPiArCQkJCSJ3cml0ZTogZmFpbCB0byB6
ZXJvIGZyb20gJWxsdSB0byAlbGx1KCVsZCkiLA0KPiA+ICsJCQkJdmFsaWRfc2l6ZSwgcG9zLCBy
ZXQpOw0KPiA+ICsJCX0NCj4gPiArCQlpZiAocmV0IDwgMCkNCj4gPiArCQkJZ290byB1bmxvY2s7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0ID0gX19nZW5lcmljX2ZpbGVfd3JpdGVfaXRlcihp
b2NiLCBpdGVyKTsNCj4gPiArCWlmIChyZXQgPCAwKQ0KPiBQcm9iYWJseSBJdCBzaG91bGQgYmUg
aWYgKHJldCA8PSAwKS4uLg0KDQpJbiB0aGUgY2FzZSBvZiByZXQ9PTAsIGV4ZmF0X2ZpbGVfemVy
b2VkX3JhbmdlKCkgbWF5IGhhdmUgd3JpdHRlbiB6ZXJvcyB0byBwYWdlIGNhY2hlLCBhbmQgdGhl
DQpmb2xsb3dpbmcgdmZzX2ZzeW5jX3JhbmdlKCkgaXMgbmVlZGVkIHRvIHN5bmNocm9uaXplIHRo
ZXNlIGRhdGEuDQoNCj4gDQo+ID4gKwkJZ290byB1bmxvY2s7DQo+ID4gKw0KPiA+ICsJaWYgKHBv
cyArIHJldCA+IGlfc2l6ZV9yZWFkKGlub2RlKSkNCj4gPiArCQlpX3NpemVfd3JpdGUoaW5vZGUs
IHBvcyArIHJldCk7DQo+ID4gKw0KPiA+ICsJaWYgKHBvcyArIHJldCA+IGVpLT52YWxpZF9zaXpl
KQ0KPiA+ICsJCWVpLT52YWxpZF9zaXplID0gcG9zICsgcmV0Ow0KPiA+ICsNCj4gPiArCS8qDQo+
ID4gKwkgKiBJZiB2YWxpZF9zaXplIGlzIGV4dGVuZGVkIHdpdGggc2VjdG9yLWFsaWduZWQgbGVu
Z3RoIGluDQo+ID4gKwkgKiBleGZhdF9nZXRfYmxvY2soKSwgc2V0IHRvIHRoZSB3cml0cmVuIGxl
bmd0aC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGlfc2l6ZV9yZWFkKGlub2RlKSA8IGVpLT52YWxp
ZF9zaXplKQ0KPiA+ICsJCWVpLT52YWxpZF9zaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOw0KPiA+
ICsNCj4gPiArCW1hcmtfaW5vZGVfZGlydHkoaW5vZGUpOw0KPiA+ICsJaW5vZGVfdW5sb2NrKGlu
b2RlKTsNCj4gPiArDQo+ID4gKwlpZiAocG9zID4gdmFsaWRfc2l6ZSAmJiBpb2NiX2lzX2RzeW5j
KGlvY2IpKSB7DQo+ID4gKwkJc3NpemVfdCBlcnIgPSB2ZnNfZnN5bmNfcmFuZ2UoZmlsZSwgdmFs
aWRfc2l6ZSwgcG9zIC0gMSwNCj4gPiArCQkJCWlvY2ItPmtpX2ZsYWdzICYgSU9DQl9TWU5DKTsN
Cj4gSXQgc2hvdWxkIGJlIG1vdmVkIHRvIGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKCkgPw0KDQpU
aGUgaW5vZGUgbG9jayBpcyBsb2NrZWQgd2hlbiBleGZhdF9maWxlX3plcm9lZF9yYW5nZSgpIGlz
IGNhbGxlZCwgYW5kIHZmc19mc3luY19yYW5nZSgpIG1heQ0KbmVlZCB0byBzeW5jaHJvbml6ZSBh
IGxvdCBvZiBkYXRhLiBJZiB2ZnNfZnN5bmNfcmFuZ2UoKSBpcyBjYWxsZWQgaW4gZXhmYXRfZmls
ZV96ZXJvZWRfcmFuZ2UoKSwgDQp0aGUgaW5vZGUgbG9jayB3aWxsIGJlIGxvY2tlZCBmb3IgYSBs
b25nIHRpbWUuDQo=
