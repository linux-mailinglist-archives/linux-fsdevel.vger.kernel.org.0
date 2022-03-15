Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95C14D9ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbiCOPib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiCOPia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:38:30 -0400
Received: from mx0b-003b2802.pphosted.com (mx0b-003b2802.pphosted.com [205.220.180.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBAC53E02;
        Tue, 15 Mar 2022 08:37:17 -0700 (PDT)
Received: from pps.filterd (m0278969.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FCnTTc018195;
        Tue, 15 Mar 2022 15:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qmK+W3zqRHuO8QEAuL1C3+8+Cj+cZeJu42wVxYYl/KU=;
 b=Milq+CckAOLcW6FwogviOgDk23iO0hg04ZmXEyhtI7ONQceYoiHnP5iQJf8o76ryHWII
 bepmwsvL+HZQ/idTxA1+LX80Pvza50oeScAzoI8i48LUDt0QUQzRziUIWpy9yD2pD+MY
 dvudej7Zrdk7um1f0rVWA16FCy5A7LqqrQ2eBtXEjZLq5A6faXYXmi+sFZnx6DpJtJro
 7EvBVZysfA9jmC1pwiZ6mB8V5k1a5Ao1vjA8j7mxuWd8EFNFHmRe35wJ3lbcpoggktJl
 1eFTERNg62jHkvRzQGMLFPXPsYrkscxVfUO23GI5Ni5+rwr4PsVQIjYeTvDExMGLgjrO SQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3et646axjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 15:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge+M7+OIZGfuvm4Ws45kkrbK2eD0w7y7pVqMHoM6td37O9xOS46c2V0LIqftaOPll64IvewHzTka2IRiGoEvEwmQFrb53LMGaiU/9HTCAEaYlRc3YLflaLiWP8uzHKy0Rix7+3q43CmmDpnV0v7gWZW2MJ2B71skQXkurJzXoVayAHR9wMa8G+7izJLyZitggdjYwbMhIH/SnYsUGRETbDcrbeum2FgTyRAPnMeVLH06HyClcNIR3216YeXYKvP1V3kQdOEq6Hu2dqOO28u+cIQJj+nKaQ4VhTyZlz0mSpEWIrrEkGzLYIuk8wnyh05IwfXo0x3YdG7FwMi91aRk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmK+W3zqRHuO8QEAuL1C3+8+Cj+cZeJu42wVxYYl/KU=;
 b=NGZgefrPE8/gHjhvAc0qpBkodrqT7Cq+DcuVKLukBqLAM0bPtnLpp56x7gkryQp92O4bwYffDxgCZoNDIxALhFNVC3/hmHZzSDkWEdurzJNB+ao/TkXT+qOir5p7WSMa4VuEpidpnafagbzk+/tUpJtx3UdcgIK1g9VUICWE3eZQW0RuqUm8tz9UyIbkL/39QvCRku20+zcfp9kEYTorQIfhn/ZxGq9h9kugkXLckc8wJtfo8Unp8TTkPyPmpVcpmftAPfy3YT1ipFfvlyBYT5UAnMeA3GbzBNU9H7EnXsRnp2s0eTyQPwENouCmLGkleTC043Miu0gQ7qh1MhwUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by SN6PR08MB5166.namprd08.prod.outlook.com (2603:10b6:805:6b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 15:36:30 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 15:36:30 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
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
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM213hUiroX0Mx0m03tMAg0KZ2Ky4fWtAgAAMswCAAG2fIIAABmiAgAAGyQCAACZ5AIAABRKAgAE3XgCAAAMkgIAEG8cAgADOHYCAAUdY8A==
Date:   Tue, 15 Mar 2022 15:36:30 +0000
Message-ID: <CO3PR08MB7975EF4B014E211ACFAB7AF4DC109@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
 <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
 <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
 <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
 <0c40073d-3920-8835-fc50-b17d4da099f0@kernel.dk>
In-Reply-To: <0c40073d-3920-8835-fc50-b17d4da099f0@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2022-03-15T15:30:10Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=31544d90-0c50-48fa-be4d-c534e33470d4;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a401c0d-c9e6-4a39-8aa7-08da069993a1
x-ms-traffictypediagnostic: SN6PR08MB5166:EE_
x-microsoft-antispam-prvs: <SN6PR08MB5166F764EF0468937EE08866DC109@SN6PR08MB5166.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4BBVf9cOul6Fp4WJaF0TBUENOqJQ3ys6cwdVPyc0mIh52MirdqM/R+ruC055tZQmlZywx9RqXm5cLfvHg6e9Rf3zu3prmYcKAmXpa/sQIAsdOyfHaazFlbwZytvcnWGX7Ip+4MlAI3lVrhEtiOkbZJ0afB68nI7xnD4eCqxMdDfUR3tAh4V7PpNy7SETLhGM5Bw7bfpjdZpXW1xdEl4CaLHrIK5bjmtXZcPcqqyMCBltlkV2BjYsKCE0tiEsV+eyA0z4ES+f4BsIIpx1rEbo/yQtzMUnOPyxKehANUj0JrUSK/3Mneg4Ie2vgJ8rH7j1vRDgpwoD24D5QBXoGdgGT85dcA1z3Wr0ozr3WHslC2OX6QuRf26ko1fnDnUcNdTRvkTrKDXvYtvwIp4mpRnmhBb8Tl6SDBMXGD4I5rj5kMa1kol/9ObulscuU1POwCSpjunWp7Z9QmXGmgLrGkxosQM947itjcR4tI/RxHUmZF94WHmxHtNyS0JaoWShnyqj9l+6m3KXjHpPNiSMIsq4W08onxuN6XuELPUh/6pIe9af0DhCt4fJ2Or4L8LHfLipKwCs5fegSbvGCFsbgf6onH2fSeJeu7aLxoxp3rFRboRl+0h+Cq1toC8IPh4XUGHJb63umF1JN8bUvS8x0hReU4hK5e1oOaNPBIedEtgfkBcQH3NfKAoGQs+a4bPfSA9c2Gpx6/a/lSQuDvA2qL0OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66446008)(64756008)(66476007)(86362001)(8936002)(66946007)(4326008)(54906003)(76116006)(316002)(122000001)(8676002)(38100700002)(38070700005)(110136005)(26005)(9686003)(6506007)(83380400001)(71200400001)(55016003)(508600001)(7696005)(5660300002)(7416002)(2906002)(52536014)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3k0SVk0VWhES3JKMW84K0xTSFFaaGxmK1o4N0lqVVFBV2kwMzRraXExMFlv?=
 =?utf-8?B?YklsZTdLZDY3WVBoVDhaTzY1SUVEUUgzTHZFc3dDWGFaYndvdHA2RmtvenpR?=
 =?utf-8?B?bXdYZ1lQYm1uUDdiM0NuOUFCai9Fd2lCNldGNFM2KzhkNWhBa1lFWlBUeEVi?=
 =?utf-8?B?a0JBMkVDMkQ5S01sYzJNTkhqOE9hV29vdFdpMWlWKzhiZDhFVHVSRmcyVk5n?=
 =?utf-8?B?L2hXUnZuek9zMURQMm1yWUlMRnVkZUsrc3d6bE5ZRzdCZFNGZmIyZHdKSDZ3?=
 =?utf-8?B?SGRscCtkdnlpemJ2bHFOZ0VObGphNmJYTkpwVlBPNzVDWUFoZ0tSYlBZOEg1?=
 =?utf-8?B?WWNaOFRlNHlUUUNIMlJCM2JzUXRtcU4wVHFLRS80eUlwdHkxMEdvZzRneHdQ?=
 =?utf-8?B?Q25wbVNCRzU0ZEs3Y3BoejZ4ZTBKWTBmQ0phbFA1elQwUG5LL0ZJcUt4amxU?=
 =?utf-8?B?MDRQN3g5SVM0aDNsSGVVSDgzYjdPemorWC84cXhIcnlHVklHNE5PTlZ1UzJa?=
 =?utf-8?B?MmtHTTlRcW1qVUFWZVYyc1RuanA2MFVEYnFoQyszL09JalJMT1FJWGl1YlFM?=
 =?utf-8?B?V1V1aFd1WFQyTW9sUW81QlpSU0RKL1NsZUdFYlZjdGlmeitkNkFwMVZ5Q2dN?=
 =?utf-8?B?RkgxNFN3cS9NeFgvVCtwVi9jMmkwUjJsNzV4aEVJQWpOUFNaVWNEMDRzVjJQ?=
 =?utf-8?B?UXd1Q3JCbkhhR3VDU254L2d0L3hBaW5IWTZPbGI5WW44SWJCbUVFTVQwMkVo?=
 =?utf-8?B?TVU4RXZQV3UrbzhQSkZ6am1uTEFQZnJSSlBEVEtMSGJuMG0rWlp6emdwQnFq?=
 =?utf-8?B?MDJhQWRnYlY3dlNuaGFNNVd0bmdnWFFwTGN3dnhIL0g3NDN1VjFXOUErY2FZ?=
 =?utf-8?B?U1IvRlphRFVZcmtFbFV3d2ZJRkRrSVVybjBJbXhab1YvbSs5UnIrNGgyeWhn?=
 =?utf-8?B?Y1RFcU1Cd2UwMXQ1ZFFJSFdGaTdjcHl3bkZVNndCaURRSjNwMi9qYU9RaTdU?=
 =?utf-8?B?T2h0MitwN29wR21paVJWL1lkMVI2eWFrbDR4ZDVpdlBXS2dyUmZtVUlxSnkr?=
 =?utf-8?B?MkFWb3haOTY4S21PenFvaFVPMFlKMEdQZ1MxRjVJRFdrZmJLTHNXcVNlSlJ4?=
 =?utf-8?B?V21ORDVES0VKTU85YkJRVVB3cDFsenJNV0l4UzI0UDhNdk0vN2xTMnFwTHBT?=
 =?utf-8?B?QUpmcFVNWUhvWFRpaVI4Z3RzS3IyRG1PNHdsMlZ4dnFMVzJSVEdDOWNWQ1l4?=
 =?utf-8?B?WEJxMkpZbHg1ZVpVY0x0WEFUQWdmalVqdUlMV21QQ1VZM1hmOXVNdXUwUW9t?=
 =?utf-8?B?endsdmo1SGRZbGJaNlZHdEZmY1RXbVIrNG8rWjZGSjBzRkpNcWNEeFFPaXpX?=
 =?utf-8?B?QVYrZVdraUZyMWdVUGttUEhGNXJMdGtva083WFZ4MUovdlZkd0xYSmNrSTg5?=
 =?utf-8?B?N0FMZVVKTUNRckpSZElwemtzaXdTSDZFaldLb25UWVRwdHU3eDhyc2w5U1lD?=
 =?utf-8?B?SzUyYlBsNDJtelYvWGNqZi9zVWxxclZhZWFpVHBvbDlTRWVqdXZEblBCKy9a?=
 =?utf-8?B?M2FRbGVXRTRZeVZNV3I4eVdsemxBcmo2N1didnhEdC90K0szak03aXpiMUlG?=
 =?utf-8?B?MDB5c0NsWmtBV0REcVFWWkV1Q2VGVDhTVHRxS1NDMkZ2STRXL0M2Z0NBSzNG?=
 =?utf-8?B?NEhDdEh5ayt5SmxXM1IvdUNNUDZoeUVKUG4rOHkxbEFGR1I1bGROL2szdmdo?=
 =?utf-8?B?SGs0b0ZDNUJ3R1dDeEpLd09QWDFRL1FHVFRxcW81Ukx3N0xTWXk5UFNlb29m?=
 =?utf-8?B?V2pLcDlVUU1lNDgvQ1B1Ui9LUklIdElsYVdLZ3JaREJ1dlV3MHdLbHFvOFN4?=
 =?utf-8?B?ekN1Tzg3RmlpVkdUbmFudGNQbEVyM2xuWUgvYnphcm5JZWlSNVhGU1dLZlJN?=
 =?utf-8?Q?3oqEHKjoIscu1Sm1q+eZw4ips3EcX+us?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a401c0d-c9e6-4a39-8aa7-08da069993a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 15:36:30.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAGdPQRLB7mE566pq7iyT3u3733xBYTJYYKsmXbEHf2N81/0neq/BClBFFW7UzElYnsxXMiBV6p+lJ2JEdn6tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5166
X-Proofpoint-ORIG-GUID: 7FBtcyETceRelTtwDeUD9TuRcckX1CiG
X-Proofpoint-GUID: 7FBtcyETceRelTtwDeUD9TuRcckX1CiG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiANCj4gVGhpcyBpc24ndCBzb21lIHNldHVwIHRvIHNvbGljaXQgdm90ZXMgb24gd2hvIHN1cHBv
cnRzIHdoYXQuIElmIHRoZSBjb2RlIGlzbid0DQo+IHVwc3RyZWFtLCBpdCBieSBkZWZpbml0aW9u
IGRvZXNuJ3QgZXhpc3QgdG8gdGhlIGtlcm5lbC4gTm8gYW1vdW50IG9mICJ3ZSdyZQ0KPiBhbHNv
IGludGVyZXN0ZWQgaW4gdGhpcyIgY2hhbmdlcyB0aGF0Lg0KPiANCj4gV2hhdCBJIHdyb3RlIGVh
cmxpZXIgc3RpbGwgYXBwbGllcyAtIHdob2V2ZXIgaXMgaW50ZXJlc3RlZCBpbiBzdXBwb3J0aW5n
IGxpZmV0aW1lDQo+IGhpbnRzIHNob3VsZCBzdWJtaXQgdGhhdCBjb2RlIHVwc3RyZWFtLiBUaGUg
ZXhpc3RpbmcgcGF0Y2hzZXQgdG8gY2xlYW4gdGhpcw0KPiB1cCBkb2Vzbid0IGNoYW5nZSB0aGF0
IHByb2Nlc3MgQVQgQUxMLiBBcyBtZW50aW9uZWQsIHRoZSBvbmx5IGRpZmZlcmVuY2UgaXMNCj4g
d2hhdCB0aGUgYmFzZWxpbmUgbG9va3MgbGlrZSBpbiB0ZXJtcyBvZiB3aGF0IHRoZSBwYXRjaHNl
dCBpcyBiYXNlZCBvbi4NCj4gDQoNCkplbnMsIA0KDQpBY3R1YWxseSB3ZSBtaWdodCB3b3JrIHRv
IGlzc3VlIGEgcGF0Y2ggYW5kIHJldmVydCB0aGUgcGF0Y2ggcGx1cyBhZGQgdGhlIGNvZGUgDQp0
aGF0IEJlYW4gYW5kIEJhcnQgbWVudGlvbmVkIHdoaWNoIGlzIGN1cnJlbnRseSBBbmRyb2lkIG9u
bHkuDQpUaGUgcmVhc29uIGl0IGhhcyBub3QgYmVlbiBkb25lIGJlZm9yZSBpcyBiZWNhdXNlIGZv
ciBub3cgaXQncyBub3QgcHJvZHVjdGlvbiB5ZXQNCmJ1dCBpdCBtYXkgc29vbiBiZSB0aGF0IGNh
c2UuDQoNCldvdWxkIHRoaXMgcGF0Y2ggcmV2ZXJ0IGJlIGFuIG9wdGlvbiBhbmQgYWNjZXB0ZWQg
YXMgYSBjbG9zdXJlIGZvciB0aGlzIGRpc2N1c3Npb24/DQoNCkFub3RoZXIgb3B0aW9uICh3aGlj
aCBJIGFjdHVhbGx5IHByZWZlciksIGlmIEkgYXNrIGZvciBhIE1NICYgU3RvcmFnZSBCb0YgZGlz
Y3Vzc2lvbiANCm9uIHN0b3JhZ2UgaGludHMgd2hlcmUgSSBjYW4gc2hvdyB5b3UgdGhlIHN0YXR1
cyBvZiB0ZW1wZXJhdHVyZSBtYW5hZ2VtZW50DQphbmQgbXkgc3R1ZGllcyBvbiBob3cgdGhpcyBp
cyBiZW5lZmljaWFsIGZvciBzdG9yYWdlIGRldmljZXMuIA0KDQpXb3VsZCB0aGlzIGJlIG1vcmUg
YmVuZWZpY2lhbCBhbmQgbWF5YmUgZ2V0IHNvbWUgd2lkZXIgY29uc2Vuc3VzIA0Kb24gdGhlIHdy
aXRlIGhpbnRzPw0KDQpBZnRlciB0aGF0IGNvbnNlbnN1cyByZXZlcnRpbmcgKG9yIGFncmVlaW5n
IG9uIGEgbmV3IGFwcHJvYWNoKSB3aWxsIGJlIGVhc2llci4NCg0KPiAtLQ0KPiBKZW5zIEF4Ym9l
DQoNCkNoZWVycywNCiAgIEx1Y2ENCg0K
