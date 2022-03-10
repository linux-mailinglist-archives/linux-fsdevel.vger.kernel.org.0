Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D24D5245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbiCJTOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 14:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245746AbiCJTOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:14:48 -0500
X-Greylist: delayed 1372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 11:13:46 PST
Received: from mx0a-003b2802.pphosted.com (mx0a-003b2802.pphosted.com [205.220.168.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F16D156948;
        Thu, 10 Mar 2022 11:13:45 -0800 (PST)
Received: from pps.filterd (m0278968.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AGtqD7000650;
        Thu, 10 Mar 2022 11:50:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OclXDHDom+4KKGHFdjH2Vu5qOj4PjSLtfjAwkRfOUaM=;
 b=Tyu6jMWNlzBYUARNGFfdjOLrQjskYby3GBDPrwR3lIUGIL5/FPGxF+T8laEDiXiaSaOm
 uFAlwIg3aqigavo/mjVAqRksDg/t0NaFCTsTtDEYB8552lDqPZI3hD9znxKGXMoEt8FA
 A67rAeOeB/OcWsJIZpvG+b4UBpXcimM1StRuDv5ScfD4q1CuM/l6kLvndNQKuESEIWjl
 Qeq9JB3lLhupIGx+gZpuS7XVTn3QpCpuvRiIypoUYyXT3ccg12QwG83uJ1hAK/vJuCk6
 7JvE8OYCmN8CIGDS+1Xy8BgDN9ToGTKa338gDZfK9Vh20fEGFWfWBGmaw0f9V+3ebdZJ Fw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3em4gtw9dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 11:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aee0XopuNts8lpM9uGz/mNHTTDQXQ2v+L49oSe5qN1q0g0G10Y+sVZWuBdy4KUcpkplT8EHqdIzW+1BYvrYXYAd5Q1KyM8eZ/S20qRvhuA9gBerln+/QxkOjBFr3fMZ0u+k4sGyk+7HfVHkrSPv1JsFjVaYQCEw5pSkqLlx3TaoxZYke976+aMto9tNR29kGcK0T1UCJ7yuRBRtGMRuPLWV3Xwf1g97o3bbupJJzWiLTW2hHYIgDQpdxG4GQ67OR4CLFfN64iyuOi93g9Vgcq1SUj3RB7NfykdA2VgW1fsYl+oMKXCLbGU/EdsjmbrHfxo89TVm64l4MtKdK8QjbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OclXDHDom+4KKGHFdjH2Vu5qOj4PjSLtfjAwkRfOUaM=;
 b=RCuEd1OJiEMabTnCEP5kKnjKHwsBt6qtbtyy7OvcjgdxqQOATlfj8ZZYPzowNS+aXoBo/hhfCjQ1OYdFBGDuhfSY5YhmRKVV9tsOegGg6X2sQ9Cge+tXATXSXJIfv5TR73rRa6QJMJNGPTytxYaqHzLv8FoocjSIKWcGgtuY1onTuVTOsRBrW7YHX2Px03+oMq63RPKd8LUbnrRu0/305Bea6GFbee5D8RYncc6BY1qrDQLtxF9MZ6cLht/nOvMWBBYeqs50gjza0c5ysW6HiiBc3wdck3PWGWPFFdKIV14fcm/lZ4dVzyjmcFBjZaMPIfyj0ilI9jKZ25xxj+wZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by BYAPR08MB4118.namprd08.prod.outlook.com (2603:10b6:a02:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 18:50:19 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 18:50:19 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Jens Axboe <axboe@kernel.dk>, Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
CC:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM213hUiroX0Mx0m03tMAg0KZ2Ky4fWtAgAAMswCAAG2fIA==
Date:   Thu, 10 Mar 2022 18:50:19 +0000
Message-ID: <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
In-Reply-To: <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2022-03-10T18:47:30Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=5d265308-374a-4d05-8a82-38ef0dda547f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
msip_label_37874100-6000-43b6-a204-2d77792600b9_enabled: true
msip_label_37874100-6000-43b6-a204-2d77792600b9_setdate: 2022-03-10T18:50:17Z
msip_label_37874100-6000-43b6-a204-2d77792600b9_method: Standard
msip_label_37874100-6000-43b6-a204-2d77792600b9_name: Confidential
msip_label_37874100-6000-43b6-a204-2d77792600b9_siteid: f38a5ecd-2813-4862-b11b-ac1d563c806f
msip_label_37874100-6000-43b6-a204-2d77792600b9_actionid: d74a97b2-1106-45ea-9185-c9d2cb64d54c
msip_label_37874100-6000-43b6-a204-2d77792600b9_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ce6601-a90a-486e-22e1-08da02c6d31e
x-ms-traffictypediagnostic: BYAPR08MB4118:EE_
x-microsoft-antispam-prvs: <BYAPR08MB41185C4503EF1BB89022925EDC0B9@BYAPR08MB4118.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50IzP16Of0klu4wmKsJENmqkH8vtk7TXrVCbP9KizTdT2c1xbmVaY+bCiLtnubAp4rw70FanM0DL7dTPXZGFpEGQYF50bBkRxn6JvUUAvTr+fw0oIVTCET4RDgV+spPl8f1BT3rVfOJfYAZRajjbrIKj8HLFRVBC7b1S8iUujgBiLPU9BckqpYtNlrqbU1IJ00lJnbMIL1fFT+7M8V6Rrh0AZVnkH+1QQgzgwIyacYJxK3YD8vlztsogwlzPZByqHoPQ2b01XoEfne4sW/KA9Hn0z4OF9Pvo/OWEKayiJT36jMmDZLCoIsWsut9rHOe8RqQayxgreHs3UpmUR347fLRvGWVtfrMfQcb6F4SjSh8Vbl93FP9mpvOSnMgUF3OG8BAosMkDIDzBBkfj6H0r3QpwQA7q8Tb4cOkpWoP21oW34W9KWBZ59+LwQZwhCTghZzVb8Q4oGeOPPdDddeWupVAPf3b/Uk4KR2WLm9oqHnEMfyrOtdll7eMDwPgxEJbfMCPRx6H6lOP1TI/7McdgSKdOgKtSc/1wpKygCUJEW6VIeKWbYGoEX71klyxukvr/1b2hh4rp3a03VNOqp+SYZDx2RJnc61BUCsye0TCj0pcq/7YrzPdFa85ywcZeB/HcPNGPBvDsT3FhOUwNG0kpW1G5sNdtntM62h9ZspT/onzhBYNvPJOjj1jkZsTXK++v8fRgp2DxbtPZiGVBxTRNNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(52536014)(38100700002)(38070700005)(8936002)(86362001)(122000001)(76116006)(71200400001)(66946007)(66446008)(66476007)(66556008)(64756008)(9686003)(55016003)(7696005)(6506007)(4326008)(8676002)(110136005)(54906003)(2906002)(508600001)(316002)(26005)(186003)(7416002)(4744005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NxV2M2dFhQR3JNMTczcTRSck44aFlrN01NZlR1MnJLZVBXb2Z2ekRFNjhZ?=
 =?utf-8?B?QktTempUZ2U4WHFqNVNIb3lvYlRQbG1YRmlEZjhKUUFIamkxV2xuRU1WcTVo?=
 =?utf-8?B?eFJVVXVQSXVyanUxcU1uR1ZhTmN6YjJ2Nk53Qm1kaHhwQ3RjNS9keWRCTWhl?=
 =?utf-8?B?c3puYUsrTjZWYjJSKzI5aDRLNjhVRWw0ZTF0UFV2WmFvODlRYzYzdXBxNmFL?=
 =?utf-8?B?RlA1VnFmbmpKYVc3SEk3MEg1aVVnTU05WWFFK2pyYmR3K0NzbXN6WWdta1ZS?=
 =?utf-8?B?SkNKYm5SSDFRNFNBOWszQlhJR29XdWt6VUluMEE1aWhQYXlrQW1CQUM3bU4y?=
 =?utf-8?B?TzhKZ1hqTlZVdnNyS1k3enpDQjlZQ3J3U0hFOS9CM1M2V0RudWhCOXN4dEdH?=
 =?utf-8?B?Y2cwQVBlNEJ5N0h1N3h3UEJhZlc0clRIRGZQTUMyR0QxYmFkbnZsWkpwVWdV?=
 =?utf-8?B?d2ZYSlJOTDBhVDVaQk1FYzFvTGgxTzRyOThaQjgyYXo2dHV5UmZJZlFNT2pV?=
 =?utf-8?B?Q1AydFVFT05RWVNGM2hMSlM0RlRNUzVSTXNNeS9kbW9mQTN0Y3FJMURHTHBL?=
 =?utf-8?B?ZU5oTkdPbFY5by9pSXRjRysxQmw1SHg4U1h1cDNsei96ZDJ0TTY4TEFLVkcw?=
 =?utf-8?B?bThYeUpWK21aZkZGUXp1bGZ4RCtFSGpmdlR4SStrYlFIQmxaNEE2QkExa3li?=
 =?utf-8?B?MjY2cGhvYUVNRGNaZHRYMEp4OVB2bis4V2JFaVVJb2NadVpXMTZYTTNWNVgy?=
 =?utf-8?B?cE9xNnNFdElWbjRqSVU3aFdhbVYwZzF1dk5WTjcxM0lXUlVuMGMrS2FHQ3Mr?=
 =?utf-8?B?eWZHMGhjV210NlM5T29yQ25pTVZ2TExsUlFFcUpZeXJhQU4zOHpRLzVrZDBH?=
 =?utf-8?B?VkxPb3FrWmt6NlUvamhmTXdnZlE5SWJMUnFOR08xYVdndE1lbE5ESTVQRXAz?=
 =?utf-8?B?anpTN1FXOWJkL1RwK1RHZjJEVzlmUlRLakpMWEFLdzNBdkNCRkxqb1Y3bUhU?=
 =?utf-8?B?M2o2OXZ3dVc2cm1aRG5nTGZZc3ZqMUxBUVl4VUZqanNXaXpRbVVBN1J1d2Rr?=
 =?utf-8?B?OTFxOU9Pa1JiNU5kN2pxdG53Wlp5alVhcUZjaGl6S0svYmE3RG9hdiswbW0y?=
 =?utf-8?B?UHRZS0p4ZDk3Y0llbnB6SDE3SVF0ZFdJWkpsZjdnbGhoUmpuL0ZhY3plSXQ5?=
 =?utf-8?B?QWRWTTdMUE1iYUU1dmZpRE16MERINmhZYVE2Uk5JdXJkNThRclhZbDhsUHUw?=
 =?utf-8?B?TnhTNUgzNEFzTHZvWjhQbFdGdDYrdDUrU0hjOWVYU0s4cEZnTzdyMVl2OWtr?=
 =?utf-8?B?aktDa0NqS2tXckp4dU9USHhzRkNsTFJPRXBsYUEyZE13UlVQc2VGZXcrL1Rh?=
 =?utf-8?B?R011Ry91cDh5S2xuZ2Nudnl5OWk4LzFhQkI4cUVQRjk3ekJQcHQ1UUQreGVE?=
 =?utf-8?B?SS9Bb2srVzBKRTVkckFZM0ExZE9NOGZSWDBZSDY0aHV5cm9OZE1peFUvKzFV?=
 =?utf-8?B?ZVNZSUxmUTNKcWk0OGNzaE1tbkt3QlA4ODFCN1V4RzFwVmRzWk8yT2FWbzhM?=
 =?utf-8?B?c0ZCdUprcnNBRE1lNm8vaVBIWVJPNmpsbm9Ta1AxM0xhai9uZkh3bnk1dGY0?=
 =?utf-8?B?M2h5cm8xRzFDZHVVVTBCcWlyMFpRb2hlOUFMTFZ6NmFYTFd0QjNwbGNwZDNL?=
 =?utf-8?B?RTFmeTlRUnRwU3IxV3RQUGF2STRLcnNiZlFvbEgwYUs4dm5raDY5bkxuR1J5?=
 =?utf-8?B?dS9sUUxmM2xEY0U5czdramVuQXNqV1poNm4rT1czRXArakRuSWc5T29TQjR0?=
 =?utf-8?B?YXNEaXppbWdtZ0gra2JqOFY0Rkg2cnNDVVh5Zk1IR3ZXcTYvRU50WG5tN1FP?=
 =?utf-8?B?VU9vZjZzcXRsM05OTXJKeFN3TnA2UFB1d1JDaFJNNjl4d3ZnN0gwenluWkZ2?=
 =?utf-8?B?ZUxDd2dJRndVeDhYQUVvZDlTb0F5enlSSUxEcG1iRzlucFBNajdHWnBMZjNJ?=
 =?utf-8?B?bXc4Y051bTlMRkVFV1Y4M1VpTlE5M25GSzVtZTAxYnpFVlpvTFJkUkJTaDd0?=
 =?utf-8?B?aWtISVRCQlF3T1BudEJqamUvUzFsQ1NmUTZqKzlRNElWS2hNTldQZjZLMnhH?=
 =?utf-8?B?SHFRZkNoSUxXVDNtTSthajRZejg3T2RGM282UGd6VEp2UWVvSlNwamRGMEh6?=
 =?utf-8?Q?OC21HmXw+aMiUvwvsAbZn00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce6601-a90a-486e-22e1-08da02c6d31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 18:50:19.4625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvXyJaCLZtUeKH5Ripo6LturgWZWKfVrOYbuSORXfKSG3B8llbixYFbn0XXvVYgHk9uuU4u6pGIvSGK1K8gpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4118
X-Proofpoint-GUID: 3xRAsGvLScDhF71bS2OAZALGs-YybvqL
X-Proofpoint-ORIG-GUID: 3xRAsGvLScDhF71bS2OAZALGs-YybvqL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWljcm9uIENvbmZpZGVudGlhbA0KDQo+IA0KPiBZb3UgZG8gYm90aCByZWFsaXplIHRoYXQgdGhp
cyBpcyBqdXN0IHRoZSBmaWxlIHNwZWNpZmljIGhpbnQ/IElub2RlIGJhc2VkIGhpbnRzDQo+IHdp
bGwgc3RpbGwgd29yayBmaW5lIGZvciBVRlMuDQo+IA0KPiAtLQ0KPiBKZW5zIEF4Ym9lDQoNCkpl
bnMsDQoNClRoYW5rcyBmb3IgdGhpcyByZXBseS4NCg0KVGhpcyB3aG9sZSBwYXRjaCBzZXJpZXMg
cmVtb3ZlcyBzdXBwb3J0IGZvciBwZXItYmlvIHdyaXRlX2hpbnQuIA0KV2l0aG91dCBiaW8gd3Jp
dGVfaGludCwgRjJGUyB3b24ndCBiZSBhYmxlIHRvIGNhc2NhZGUgSG90L1dhcm0vQ29sZCANCmlu
Zm9ybWF0aW9uIHRvIFNDU0kgLyBVRlMgZHJpdmVyLg0KDQpUaGlzIGlzIG15IGN1cnJlbnQgdW5k
ZXJzdGFuZGluZy4gSSBtaWdodCBiZSB3cm9uZyBidXQgSSBkb24ndCB0aGluayB3ZSANCkFyZSBj
b25jZXJuZWQgd2l0aCBpbm9kZSBoaW50IChhcyB3ZWxsIGFzIGZpbGUgaGludHMpLg0KDQpUaGFu
a3MsDQogIEx1Y2ENCg0KDQpNaWNyb24gQ29uZmlkZW50aWFsDQo=
