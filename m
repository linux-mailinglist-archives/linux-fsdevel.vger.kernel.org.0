Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FACE4D5E4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 10:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbiCKJX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 04:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347490AbiCKJW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:22:58 -0500
Received: from mx0a-003b2802.pphosted.com (mx0a-003b2802.pphosted.com [205.220.168.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A81BD059;
        Fri, 11 Mar 2022 01:21:52 -0800 (PST)
Received: from pps.filterd (m0278966.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22B9DKp7025827;
        Fri, 11 Mar 2022 02:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yEkgg8kFrNsu6TMViEijVYYrZ3Fg4FQX8RdygX9//JA=;
 b=a11GNTEsPtI2y/Qj1OG7hGnhSKtCqKBD0Ao5qf0SsQnYUZAZ8+sqKjJft7u4Df+DyXGW
 IRZqoCMqIl0XpDj/M2R3HzeqBlEB9Bu7DKs6uDnk40GeOLmhA8+sGW7EnHX09ZzBkNX1
 wzTRBJWGTGGcQOA3aFmbOhqK3e/Elm+dhWq5/l/mExVkrGs6mJ5vVAAWBAP25LpwBqUs
 57PBxb29kELgdZqKqAWhMqm8Li8Xr08IFsw4Zv31rNA46s/aDKdmQMMNGBDLX8XgRYow
 IY3qPz8QrYmJ64BL5ElvOHyZK/ytRbYtKTxy/bwSPEJWl3AOqZz+9uzo2Ptu2zDzcG9E cg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3em5bgpx4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 02:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPFcMVxE8j2p+Rgny5E2cD7SnLr7eEoI0Xz9rv69+Y43x4t9bAQLlWiISTCN+LT6L96MY56kTsXSePOxeYGqJG+e14hoARC06DQZ/MhIGmDFCMqhcHOtcKdUXnL/OKmm+6SPko9XxZUl9TeyK56JZkfCYck1uWYOcljRRg5mEg/fISrX9Qh+T7YZT+0nX1i98XuTKnmeWaM50h5M1dpCCvJUZSOegWRsGIJdIyG6BHThZeRmmQimEoLAzZUO9PFPW0fA0y4jPs09Y2G/cgDkT728Kw4tAbMISgGr4lAgbKZU7GND0jpHnMvB9Otkc7kaLp5wX2BG3xcsYwvm3dUY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEkgg8kFrNsu6TMViEijVYYrZ3Fg4FQX8RdygX9//JA=;
 b=E0VtC5XkseH1IFoVv7gkX2V5+yqxYvwetQP0IipQAs27b7bLox7jAaJw7Cwgi6rfDe5nqHX87ujWzEEwZC/eMimIJnFcHir98TQtGpVslJ7znougTCxcEYs7VTtJdbBFRjywkrI+PQhlYQkQK571yH9lgyAskwVCYL4JdqvzZxWDJFurf0Kd9GpHNto33Xp/NFNX6U5Hn2E9ds0czFndqOszxl0YBI+9Pqn+YsEMB6ikqme/pzPMb+EV0HyK6JaTAGh/oHkii5z7BBGwfBQ9GgMwPdbSCLTdt5dLlUuFtuOcIsaJpviVeIXffvwXEgDgKJl6TQJ94nMGEMUbV90FRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by SN6PR08MB3982.namprd08.prod.outlook.com (2603:10b6:805:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:21:33 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.024; Fri, 11 Mar 2022
 09:21:33 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Jens Axboe <axboe@kernel.dk>,
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
Thread-Index: AQHYM213hUiroX0Mx0m03tMAg0KZ2Ky4fWtAgAAMswCAAG2fIIAABmiAgAAGyQCAACZ5AIAABzyAgAC333A=
Date:   Fri, 11 Mar 2022 09:21:33 +0000
Message-ID: <CO3PR08MB7975A67FEDA70043DA3EDC8ADC0C9@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <9d645cf0-1685-437a-23e4-b2a01553bba5@acm.org>
In-Reply-To: <9d645cf0-1685-437a-23e4-b2a01553bba5@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2022-03-11T09:16:31Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=86e74ac9-bd41-4c65-8e6f-8e7baccc7548;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9167abd3-a5dd-4d19-664b-08da034088f2
x-ms-traffictypediagnostic: SN6PR08MB3982:EE_
x-microsoft-antispam-prvs: <SN6PR08MB398235A0682E0ABB15CD31F2DC0C9@SN6PR08MB3982.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBVMwOH3i5lygWmGTb1IeNEyXQ1+hwlF8PoM17+0Ions4VM8pdgfZ16qZyUbImQltgLgpY8Lh1VmO/vOS3y/Aq5DkRTNpRlP8lgi7i6+BJAZS5rZpnqyPSILWzFdUHA/uqiO7aQCrk9RcfoGJcFWqOqQPxRxL9JmiJVJcnYpuGD/xgRRD46IgZEhuQfdp04LvjlhfiPe5pCwcrUIHgp0Y+pFjFAmA662jbWx2rrWW7n6abxsyhSlFc3ckR+fc/gGj4x/TwZKC2CojqF0ogw3gLTb5Q5w+Gd91GUtn/2nw3/I0Od3PTt9zHdSifsTPjajcii2jyfOHJhRAFtrhkQbgQM6+ArUey759e8gLSP6N+e+IIVxgzVWWhTfMsfVhk8flp9ze+6v+QxCRz0ZuckEkhlq5ENwC2HoMb0ytMkfGtT4+sk5Jp3VRV+UlmUU6zmr8U5AvhDqlgRAwRN06nSMFuWDFBnBLlXmY2UfUuAx+KHtl//qDj3WgCi1KA/4KiH04XoqufsD0o1ez2NklWAUabdsN4R1mkmuUuzMLN0vs+KwCXzMOvRuObKYnVhUuMfQsWY29TvYOoHdjyBQL+6GpT2htrNzOueBDuIJBjXzJfag3FrxB032xQV+yAnRcNo2ZdlLKlR52x7oBgYEbNg8WhpsIKTUOG5Wjqoq2Skl6CCDyHuBvBMwbR6NjemPxT/ts+KaLAB7pzv9GB2ynUsOeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(76116006)(8936002)(7416002)(5660300002)(52536014)(26005)(66446008)(64756008)(316002)(8676002)(4744005)(122000001)(110136005)(54906003)(38070700005)(2906002)(4326008)(38100700002)(83380400001)(86362001)(55016003)(71200400001)(186003)(508600001)(6506007)(7696005)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2IyMURHMUw1Ny8yTkVxaU5GZ0V2UGxlQVRjZzNFNUFrWGtvT0NjTG5iUzBt?=
 =?utf-8?B?QUQxd3RMRXQvZzdYbC83cmdqelZheGN1dWtEUjZHMDJhZjAveW10ZUpXeFNz?=
 =?utf-8?B?cENoa0RSaExWQ0hGOFJxVHdoOHBrV1BwSWJVNStzN1N6UWF1QXQwQWVMYU9O?=
 =?utf-8?B?WjhycTRlWHVIZUtxWERCUUlYQmk3aG5BMVNTaW5SS3FPUFgxY3FVV09ocWRa?=
 =?utf-8?B?TlUrbGdzN1FLaWNxa1VCT1djNmViRU5WUWwyRWIxbFBzaEdtQkVsckllWG1E?=
 =?utf-8?B?amUycVpaSVRzNWpVM3ZaWkJqWHFiZnQzS0N4MU9XZytJYWVJam9oRHZaNVZj?=
 =?utf-8?B?ZG9GcHcxckZjL2JLTHh0OGxVRkIwUlZyM3BJVkJFRWJ4MllueFEraW5Ja3M3?=
 =?utf-8?B?bnE5ckNjYnNURGdRaU5mVGJrN0lQNElYSCtPZCtnMG15cDNMR3JCTjkzdXZF?=
 =?utf-8?B?NUF5SDJlbHNmUVgwcTJWakhIcWZ2UGJMRXhvYTR2T09Cd2docmVwbEt3RU1z?=
 =?utf-8?B?dEVmMm5OZGx1d3NkU1BrWDJ1TUVpTlpIeU1LLy9ZNm1GQUVkZnI2M3A0d213?=
 =?utf-8?B?RTRVck5Hc0djNFdnSXorT0ZVazFaQk9tUHZRbEs5SUtmQ2txTC85ZkV6MGVt?=
 =?utf-8?B?ak1tNHlPUGszYjJFMHZKMTlLSW8zZXA5V3FTeDJLbDRoZTNOQWZvWmNMME82?=
 =?utf-8?B?bFJSYmtKSy9nNG1YT0JzVEFWSGErSEtVTjc2V0ZHQVBia0J5UVhzTzNyVzgz?=
 =?utf-8?B?ZkJzemt1dVpBclJMeHBySHhBZWNYSE5sOHQwdXVjNGU5U1RpNmhFQXBBWGdG?=
 =?utf-8?B?bU5oanlucitMUFNWOFpwMXZzVmh6VHhyUHhtREVmWVJYVm1IaWI1cEczQkRu?=
 =?utf-8?B?K25UY1ZuOUQwSjE4cTM3N0ZDckxqN2REN0hldTFNM0tVN2VpdFRVckk2aTI4?=
 =?utf-8?B?K1V3NTFKdDJxSUFhRXY4bndGa0hGcit1NnRnVldTTVVUL08zajQ0cWNjdDZK?=
 =?utf-8?B?Ny92SXRDQWFMSC9aLzhvV2RVV2pNUHc0TjRtTDlJQzZQaTZ3eW54dlNnbk04?=
 =?utf-8?B?TUZFanhjakRFcXJjdCtmQitaRG1QTHRha05PMTFRelJZdWpYdEIrMkxHTUZK?=
 =?utf-8?B?ZkdweHE2NUlvN0RsZkVnOHprWnRsWjN5MGU2NVlYaTBoY1dWek9wdWwzbU5D?=
 =?utf-8?B?VUt0UkNKNUlnaGx0dEE0U3NkSmhycnZRTEZhK1ExUjBaYW9xWCtlMnU5MUdL?=
 =?utf-8?B?dFUrZm5SdTlwMUlEdCtrb1BleHdteEsrTzZYaThLN3owN1dSMzJ1cENLcXdM?=
 =?utf-8?B?cmVrZjdia2k4M0hZRFRzWGhwa3k0ZFlMTk5hVU5nRnBRN2lNbzlUU213Q083?=
 =?utf-8?B?anZUMGdaM1A5UzdjNHdQeUlsZWZwdHpCN1k0MmVyYmRQOWpKMEdtR3VSNU9z?=
 =?utf-8?B?VW5iQlpYYXplTTZNbHdTTExuY0dBeW1zTVBzMmdUN3dTNTg5NnptK1REeTE5?=
 =?utf-8?B?N09uS2Vmc25nM1JqbUJRM1NqWlc3NDdxcmsxbGJmcDRLSUlhQjdBQkVvNHdz?=
 =?utf-8?B?VWxEMDdVMldBL2wzaHVkZ0JKM3JqSkVsMDV0a0NPUnpUYzZHSTUvek0wOCtx?=
 =?utf-8?B?N01zck5nbGcwWFhOcldDeXdKbXhubHk4cmo3dkp5aGZXbE5tMkZ4bktYd01S?=
 =?utf-8?B?TGxyOWJ3QXRWL2x4MGErUkpEeHFqcVZqdldCNlk4ZDdJNUVna0xsMlFQS2Yz?=
 =?utf-8?B?ckVsdHN3bGVidUl1dU5DZ1V5OTkrbzRBdFdTWjhIb1BxK1lPT2F3VU14VHhp?=
 =?utf-8?B?NTV3bHg4TGN6Q0NBbFI2V0RLcWVpS2dRR0szSE91Y1BOdWhlcm5WUDc2Rkpr?=
 =?utf-8?B?WnYzb1RyemJqeDdsaFBvZ3N1ZjZzaitueEptTUZnU200MFozTDdiNTRnYTVp?=
 =?utf-8?Q?i719mwh04zA0RNkM9fhpQU+SnUlWtR2x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9167abd3-a5dd-4d19-664b-08da034088f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 09:21:33.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9mAIgpMOYzQXqOPLnEAKmbQkrCjlk3hbyFaBJ8fooWtpR3bgsSsY2YFm/h55OO1Gc4JfGJ1PQ6RxHMQqMp9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB3982
X-Proofpoint-GUID: cN1uvc9-NPQMmiEWbHQ2mjgQGJthowxL
X-Proofpoint-ORIG-GUID: cN1uvc9-NPQMmiEWbHQ2mjgQGJthowxL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gU2luY2UgdGhlcmUgaXMgYSBkZXNpcmUgdG8gcmVtb3ZlIHRoZSB3cml0ZSBoaW50IGlu
Zm9ybWF0aW9uIGZyb20gc3RydWN0IGJpbywgaXMNCj4gdGhlcmUgYW55IG90aGVyIGluZm9ybWF0
aW9uIHRoZSAic3lzdGVtIGRhdGEgY2hhcmFjdGVyaXN0aWNzIiBpbmZvcm1hdGlvbg0KPiBjYW4g
YmUgZGVyaXZlZCBmcm9tPw0KPiBIb3cgYWJvdXQgZS5nLiBkZXJpdmluZyB0aGF0IGluZm9ybWF0
aW9uIGZyb20gcmVxdWVzdCBmbGFncyBsaWtlIFJFUV9TWU5DLA0KPiBSRVFfTUVUQSBhbmQvb3Ig
UkVRX0lETEU/DQoNCkJhcnQsDQoNCkkgYWdyZWUgd2l0aCBhbGwgeW91ciBhbmFseXNpcy4gVGhl
IHBvaW50IGlzIHRoZXNlIGZsYWdzIChTeW5jLCBNZXRhIGFuZCBJZGxlKSBhcmUgDQpyZWFsbHkg
bWVhbnQgZm9yIGxhdGVuY3kgbWFuYWdlbWVudCB3aGVyZWFzIGhlcmUgdGhlIHByb2JsZW0gaXMg
aG90L2NvbGQgc2VwYXJhdGlvbi4NCg0KQXQgdGhpcyBtb21lbnQgSSBhbSBub3QgYXdhcmUgb2Yg
YW55IG1ldGhvZG9sb2d5IHdlIGNhbiB1c2UgdG8gbWFwIFMvTS9JZGxlIGZsYWdzDQpJbnRvIGhv
dC9jb2xkIG1lYW5pbmcgYnV0IEkgYW0gb3BlbiB0byB0YWxrIGFuZCBkaXNjdXNzIDotKQ0KDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0KDQpDaGVlcnMsDQogIEx1Y2ENCg==
