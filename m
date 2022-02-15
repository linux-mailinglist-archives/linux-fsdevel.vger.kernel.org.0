Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E74B76AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiBOS2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 13:28:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiBOS2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:28:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EFE01A;
        Tue, 15 Feb 2022 10:28:25 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21FHtHVv016484;
        Tue, 15 Feb 2022 10:28:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1AHqiZLWgOGZxEbzKkc3vYi7/9CfOCRlmoRs5sFvdEk=;
 b=TJN5sBt72uAsQ2a+VZVTctUD18ZoyNgXlsTOUvUkxOGXsfN223r/bg/OtNBBuGkktWnr
 K5dWA8AykuJdeI2Etl/1GeH7xNXis1RZSKbk27/ZMbCCdB6ercenAxsOjNyLJNd248aN
 q9NpmO3wK+AM0uY71b9MEt/CA78jyn0GRdc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e843mn5n9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 10:28:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 10:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys1jxizQFCZgBFlaIhZJvsONEuF8W3ZWC4Rx0OD+rsVIqr/ptEoECjzXmyC/ux35d0mjNW0apNjts1uK1XWrniBPT/P/eAoPgu4JrA4FWrM8yhl24SK6Vfl25QyR6pBaab5km3+au9Y4plc/8/otUN0Sr2Q00L6HrjexxrOYsPEQ/8mqrzDnojdR7yJ7hNHCT50ON5qSfHWXXOCUDaW6qFZx7LCztK9NslY/3l+5omknCUF321IYipZv2e3xt+Ea4lPJuO6ZtxN28Qa8qXGjchMA82TFfKIDueUfal9MzfilZrufcR0dDjgbjv0Jl+rrd91JIVc0lMpSJpxJb5kidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AHqiZLWgOGZxEbzKkc3vYi7/9CfOCRlmoRs5sFvdEk=;
 b=cIBPT7rSuo+3aT/2ZZbjFCp6CgijytNym9sHuj31ptJx/jE7ZrnNMQOw+TR9rGlGZMfnjgbxnokG1lWord/8FhobPXYj2rr13443T27+pCBwz4u1W9N3wQpqqnJSJ8pU48/Ssv5UYu/9gqn/jMG+myknxi1rGCU2Z3ZHyAG4aGDzago+GaIZxCHwaD3HJnOmNxE2m70bu7bb7XRfyZbPFmb3iXAjBFtI4Ors6GLKDV8thKeSBKa5vmQCedDxw1qW3VYAO330uLbwwyv57IOVCWanbJGzcxV9HWdPRBkAkxQPfW+CVZ7RlKv3m8bSy9/MclyIqUN5UTvoINecBvV90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by MWHPR15MB1792.namprd15.prod.outlook.com (2603:10b6:301:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 18:28:22 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::649b:5061:eff4:4808]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::649b:5061:eff4:4808%4]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 18:28:21 +0000
From:   Chris Mason <clm@fb.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
CC:     "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Thread-Topic: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Thread-Index: AQHYIdXuUKIGLuECw02OdpDhd3P0HqyTbfIAgAGB/wA=
Date:   Tue, 15 Feb 2022 18:28:21 +0000
Message-ID: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com>
References: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
 <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
In-Reply-To: <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d0dc326-e7c8-42c3-7d32-08d9f0b0f1ea
x-ms-traffictypediagnostic: MWHPR15MB1792:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1792B832B79FBDD3A95E7F8CD3349@MWHPR15MB1792.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oi0oZjX0l9byetpcymHT/9Ni2c3jh0k3C21EH6BiQCHQ6WsEpYeejwGgMwDelHGSonhzXw2+eKyS6hgjc0conGRyugNLCvG0LFvoSndPuwSRURafkEenYWQORDAf2Suph+YF994AQ2A+Ux+L+EZ4cZNRo1HIKOj5PWXmWBXNuSinT1ou6oPzWQl8XvbFmMkAfjw+NuUnkWvg2cH7aWaxTjgyZOquEzQhZERpV7f13QFSZX31MwogVxxkZehLjwT8SD+39i5JfrincWGI0xObeOAciStsToCZvbhpsJBATonBMsEKAaKSGK1AmfRI8pB2tHJXiZUyMjIyzfSdUOW8aQcFmybDbAq+afAm94gWRGvoFRyZrSuOJjxI8T4PN9D9CFN8nAQv8uF1uvqnJnN2N0cYnGykSQdZjVIRZenAZpK0+hsPciRuRLxTdg+RHj3Gdh/VINHCC1HCjgO5D42BHiYqt9B7fSci6wOYIkDHtdZlIIt1xdj128FWOJTkRir+KdvvjMFM6AQRbe6cRWO/Vn3Fe6sbC0I6oF7Hbzt2w1gWnpTQEbVCRx8JbYXaXo6M5vyWjzu5Yzbnie2hjLaT9HU8ztG+EBFhYeGPcj8wKworz7IYrcNSOULp+arbwBXP01GcpepTHIhoaG/cUHjgRw/wMVTIlPY0L9V3C4yS0/kWfEvT8xlogSOBVd5M5wSHD2bgEodqbq2e7uN6c+fU2UGbeTpph7kUK997sNzUbQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(64756008)(8676002)(38070700005)(66476007)(66446008)(4326008)(508600001)(76116006)(71200400001)(33656002)(2616005)(6512007)(2906002)(186003)(86362001)(6506007)(53546011)(110136005)(83380400001)(54906003)(36756003)(5660300002)(8936002)(38100700002)(122000001)(6486002)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVloTHNXWmVoOVF6MUhGYlNIc1E0QWNHc3d1d3gvUWhlNm1YaDlmeVJBZ2xK?=
 =?utf-8?B?MHEvTWdHcW8wYlpUNFVHcnZlcUpPWVJLdGlqZUhqKzBqVVBGaVBkWEtsbkJC?=
 =?utf-8?B?Zk1ONWZjc3NxUTloSk1qUDR3OWthNGk4QUo4Q1kxaG1HOHdpdjdYa0lxc28z?=
 =?utf-8?B?UlpsR3NUWDNpbTNYcFlaUlljdnNpamkvcU5CUHBSSVZiNXBLc3FxZlJCSDFl?=
 =?utf-8?B?NFZyaTJvb0xQVUVQaXJrVjdsV0c5V1dld0hWUUd4ajFudGNWTjhlNTQ5bUcx?=
 =?utf-8?B?L2pPNlRzR0g5RGN1R3FhSTk3Y2dzZ0Yrb2o4a0VJVGl3YUNXbXJvZnBSNkVv?=
 =?utf-8?B?NC9iak84eVhvaUN5R0lrRFArTEJES0M1TVpiczhveVY5VElBZWl2RlFnZzRk?=
 =?utf-8?B?QjFxWm8yV21wbUlsbFU4cjVLWjJiazVTNExaV2J0dGVWMHl4VkdSSjF2ZFlo?=
 =?utf-8?B?WnRaOCtVM1d3Nlg3Zkxjb2o3dlRtY1dkYTRoSlBFWkJCZURORi9FaGV2TU4z?=
 =?utf-8?B?a084SzBSNHl4UU5hQXZNM3JmcERnVy9DRGszbG5vb2h4UElwYi8wZ05ERlEv?=
 =?utf-8?B?TFdRTzQvc1dGcUxLT0tCM1RkcmlKMk1PcGluaVFaNXJHR05iMEluQ3JzeCtt?=
 =?utf-8?B?bHZ6VkU2K09DeVpxSHZFR05uVWNMTUVHOHJ3WXJ6QkdWbkpSVGxTT1B2OCt0?=
 =?utf-8?B?VUNKMFo4UGFuTVBzWG9kMUJVN3dFYlI2ZlJCRGNYU2t4Unp1eVV5Q1czWis5?=
 =?utf-8?B?MW1lcjJicFo4Z3lBalBiUFpad2VNaldydDV2YzU2UmNnZE9WT2FnSTdhVC9J?=
 =?utf-8?B?VHBKdEsxd2cxYS9OTy9TOE9aUElLdnlRdDQyWHNtWldaZmpSNW9JWTZTR2dZ?=
 =?utf-8?B?VUYzMUNnMVg5aC9XaERlN0xmSXN6UmV5MTVXT0FYcEdPMmtxeDlVVlRFZTYw?=
 =?utf-8?B?UHM1eUN1UVJSRzVzWHc0dVNzaXBVQ2R3T1lzRGpCNmNhWnVjN0IwZWNrOXc5?=
 =?utf-8?B?NERzZityMDBaNWJQNGVBZ3lPdk84SStMQUh1ZVZrSmd3NTQ0U1hmbWltSzQ5?=
 =?utf-8?B?Y0xjMGRoWE4xckFLWkN3eU5KalQ3cEVNT0wzRHFNeTB0UEJxUEpjUVFvTnFC?=
 =?utf-8?B?RVdlWUhDcERIWmZiMzRLV1k2enkzbUlPSGt6Q0laekFvUXpKUnc1Wi9tbnhv?=
 =?utf-8?B?S2xrQjd3WG1nRUtsOVdianpsQkVDWGtKcFNhZHh1MVltdmRVdVZCZ2JVWlNS?=
 =?utf-8?B?RVkyaW1UbStmOWZaR1cvdEpSeHo4azF3cmdNbmpqZVlIVXlWWkp5RCtzbkJp?=
 =?utf-8?B?Q1JwZjc1WU5hOG9FZXp6Mi9GZEdvUEwyZklzaG1zemh0NGdXamNFeng1Z1R5?=
 =?utf-8?B?VDRxelFvbWZoNlQ4OWNZVWIzd0VFelhQd0x2RzkwUmxBVkN0NWRUck5URjYz?=
 =?utf-8?B?M1RLSFI3SnlhZFR5c0FPY2R5V3NnQzBZelFhVTRTSk5MUUt6bW9KbWpZbUxa?=
 =?utf-8?B?Yit0R1orY3ZXaVoySnFjQzZTNFlzTmRMYnE2QU15ZzE5Q3RjeTU1SHFYeHV4?=
 =?utf-8?B?MEQxOG00STllK1diTHc1Q0FBTFc3ZDJIVm1jN1VXZENBOEpkSHUyMGpvcGRT?=
 =?utf-8?B?b2c4dkJFWlR5UExHMzhkOXNHNUhyNFNNZ09GRG1QTG1LeC9pSDVUV3Flc1ZN?=
 =?utf-8?B?NE1tVzlHZkZ3czAvOXNnT3laUHNEeEVNTW1uOVRGY1A5MGNxUXdFSFlqNy9L?=
 =?utf-8?B?cDZnSkZTTUp0R0QxMXk4L2phU2JHOG41djlpV2ZmcTgwRE45cm9iMG5VWTlj?=
 =?utf-8?B?bHhsVWdVMDE0VnhRNDdHU1NGM1FhUzZSOVB2ZDV0MXVzdUE0d0ljeE5RbzFm?=
 =?utf-8?B?VkpmSjhhc3VXUzlsbU1OU0ZBSzROYWN1Ui8xeUlaT0Y4QzVPWEpQd2l1bFoy?=
 =?utf-8?B?NU9BZlFQczFrdjd2RzJ3ZGRKMzIzUGFnSkpQeG5CblZPT3VnVk55amJpbzA2?=
 =?utf-8?B?VFJzelpzMTZsYmpJUENkNUR1K2k3T0lnb1Z6Syt5anVITWxJbWVBWFBIWFZj?=
 =?utf-8?B?YXV6ME5IclE0cWQ2b1Zmd09Xa1JudWdKakhnT05SZkhDWmprU2xwelRnUlNV?=
 =?utf-8?B?SWZXWExPbXUvdGRMQmNhRmxSWkM3L2hlalBaUWVMRWdPUEFYR2tjbitLTUxG?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB6648745A487B409F8AB22D1D7F28CC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0dc326-e7c8-42c3-7d32-08d9f0b0f1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 18:28:21.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOHW39VJ9m/bRIZe/2pCNyVIojAUjsK7fif9xXj9+hLSM9pkwNU6cirsY7VZftLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1792
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: m7iOETsKRZDTPralx5de2n2iISPcqicU
X-Proofpoint-GUID: m7iOETsKRZDTPralx5de2n2iISPcqicU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_05,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 mlxlogscore=981 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202150106
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEZlYiAxNCwgMjAyMiwgYXQgMjoyNiBQTSwgQ2hyaXMgTWFzb24gPGNsbUBmYi5jb20+
IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gRmViIDE0LCAyMDIyLCBhdCAyOjA1IFBNLCBQYXVs
IEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBFeHBlcmlt
ZW50YWwuICBOb3QgZm9yIGluY2x1c2lvbi4gIFlldCwgYW55d2F5Lg0KPj4gDQo+PiBGcmVlaW5n
IGxhcmdlIG51bWJlcnMgb2YgbmFtZXNwYWNlcyBpbiBxdWljayBzdWNjZXNzaW9uIGNhbiByZXN1
bHQgaW4NCj4+IGEgYm90dGxlbmVjayBvbiB0aGUgc3luY2hyb25pemVfcmN1KCkgaW52b2tlZCBm
cm9tIGtlcm5fdW5tb3VudCgpLg0KPj4gVGhpcyBwYXRjaCBhcHBsaWVzIHRoZSBzeW5jaHJvbml6
ZV9yY3VfZXhwZWRpdGVkKCkgaGFtbWVyIHRvIGFsbG93DQo+PiBmdXJ0aGVyIHRlc3RpbmcgYW5k
IGZhdWx0IGlzb2xhdGlvbi4NCj4+IA0KPj4gSGV5LCBhdCBsZWFzdCB0aGVyZSB3YXMgbm8gbmVl
ZCB0byBjaGFuZ2UgdGhlIGNvbW1lbnQhICA7LSkNCj4+IA0KPiANCj4gSSBkb27igJl0IHRoaW5r
IHRoaXMgd2lsbCBiZSBmYXN0IGVub3VnaC4gIEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgdGhhdCBj
b21taXQgZTFlYjI2ZmE2MmQwNGVjMDk1NTQzMmJlMWFhODcyMmE5N2NiNTJlNyBpcyBwdXR0aW5n
IGFsbCBvZiB0aGUgaXBjIG5hbWVzcGFjZSBmcmVlcyBvbnRvIGEgbGlzdCwgYW5kIGV2ZXJ5IGZy
ZWUgaW5jbHVkZXMgb25lIGNhbGwgdG8gc3luY2hyb25pemVfcmN1KCkNCj4gDQo+IFRoZSBlbmQg
cmVzdWx0IGlzIHRoYXQgd2UgY2FuIGNyZWF0ZSBuZXcgbmFtZXNwYWNlcyBtdWNoIG11Y2ggZmFz
dGVyIHRoYW4gd2UgY2FuIGZyZWUgdGhlbSwgYW5kIGV2ZW50dWFsbHkgd2UgcnVuIG91dC4gIEkg
Zm91bmQgdGhpcyB3aGlsZSBkZWJ1Z2dpbmcgY2xvbmUoKSByZXR1cm5pbmcgRU5PU1BDIGJlY2F1
c2UgY3JlYXRlX2lwY19ucygpIHdhcyByZXR1cm5pbmcgRU5PU1BDLg0KDQpJ4oCZbSBnb2luZyB0
byB0cnkgUmlr4oCZcyBwYXRjaCwgYnV0IEkgY2hhbmdlZCBHaXVzZXBwZeKAmXMgYmVuY2htYXJr
IGZyb20gdGhpcyBjb21taXQsIGp1c3QgdG8gbWFrZSBpdCBydW4gZm9yIGEgbWlsbGlvbiBpdGVy
YXRpb25zIGluc3RlYWQgb2YgMTAwMC4NCg0KI2RlZmluZSBfR05VX1NPVVJDRQ0KI2luY2x1ZGUg
PHNjaGVkLmg+DQojaW5jbHVkZSA8ZXJyb3IuaD4NCiNpbmNsdWRlIDxlcnJuby5oPg0KI2luY2x1
ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQoNCmludCBtYWluKCkNCnsNCiAgICAg
ICAgaW50IGk7DQoNCiAgICAgICAgZm9yIChpID0gMDsgaSA8IDEwMDAwMDA7IGkrKykgew0KICAg
ICAgICAgICAgICAgIGlmICh1bnNoYXJlKENMT05FX05FV0lQQykgPCAwKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgZXJyb3IoRVhJVF9GQUlMVVJFLCBlcnJubywgInVuc2hhcmUiKTsNCiAgICAg
ICAgfQ0KfQ0KDQpUaGVuIEkgcHV0IG9uIGEgZHJnbiBzY3JpcHQgdG8gcHJpbnQgdGhlIHNpemUg
b2YgdGhlIGZyZWVfaXBjX2xpc3Q6DQoNCiMhL3Vzci9iaW4vZW52IGRyZ24NCiMgdXNhZ2U6IC4v
Y2hlY2tfbGlzdCA8cGlkIG9mIHdvcmtlciB0aHJlYWQgZG9pbmcgZnJlZV9pcGMgY2FsbHM+DQoN
CmZyb20gZHJnbiBpbXBvcnQgKg0KZnJvbSBkcmduLmhlbHBlcnMubGludXgucGlkIGltcG9ydCBm
aW5kX3Rhc2sNCmltcG9ydCBzeXMsb3MsdGltZQ0KDQpkZWYgbGxpc3RfY291bnQoY3VyKToNCiAg
ICBjb3VudCA9IDANCiAgICB3aGlsZSBjdXI6DQogICAgICAgIGNvdW50ICs9IDENCiAgICAgICAg
Y3VyID0gY3VyLm5leHQNCiAgICByZXR1cm4gY291bnQNCg0KcGlkID0gaW50KHN5cy5hcmd2WzFd
KQ0KDQojIHNvbWV0aW1lcyB0aGUgd29ya2VyIGlzIGluIGRpZmZlcmVudCBmdW5jdGlvbnMsIHNv
IHRoaXMNCiMgd2lsbCB0aHJvdyBleGNlcHRpb25zIGlmIHdlIGNhbid0IGZpbmQgdGhlIGZyZWVf
aXBjIGNhbGwNCmZvciB4IGluIHJhbmdlKDEsIDUpOg0KICAgIHRyeToNCiAgICAgICAgdGFzayA9
IGZpbmRfdGFzayhwcm9nLCBpbnQocGlkKSkNCiAgICAgICAgdHJhY2UgPSBwcm9nLnN0YWNrX3Ry
YWNlKHRhc2spDQogICAgICAgIGhlYWQgPSBwcm9nWydmcmVlX2lwY19saXN0J10NCiAgICAgICAg
Zm9yIGkgaW4gcmFuZ2UoMCwgbGVuKHRyYWNlKSk6DQogICAgICAgICAgICBpZiAiZnJlZV9pcGMg
YXQiIGluIHN0cih0cmFjZVtpXSk6DQogICAgICAgICAgICAgICAgZnJlZV9pcGNfaW5kZXggPSBp
DQogICAgICAgIG4gPSB0cmFjZVtmcmVlX2lwY19pbmRleF1bJ24nXQ0KICAgICAgICBwcmludCgi
aXBjIGZyZWUgbGlzdCBpcyAlZCB3b3JrZXIgJWQgcmVtYWluaW5nICVkIiAlIChsbGlzdF9jb3Vu
dChoZWFkLmZpcnN0KSwgcGlkLCBsbGlzdF9jb3VudChuLm1udF9sbGlzdC5uZXh0KSkpDQogICAg
ICAgIGJyZWFrDQogICAgZXhjZXB0Og0KICAgICAgICB0aW1lLnNsZWVwKDAuNSkNCiAgICAgICAg
cGFzcw0KDQpJIHdhcyBleHBlY3RpbmcgdGhlIHJ1biB0byBwcmV0dHkgcXVpY2tseSBoaXQgRU5P
U1BDLCB0aGVuIHRyeSBSaWvigJlzIHBhdGNoLCB0aGVuIGNlbGVicmF0ZSBhbmQgbW92ZSBvbi4g
IFdoYXQgc2VlbXMgdG8gYmUgaGFwcGVuaW5nIGluc3RlYWQgaXMgdGhhdCB1bnNoYXJlIGlzIHNw
ZW5kaW5nIGFsbCBvZiBpdHMgdGltZSBjcmVhdGluZyBzdXBlciBibG9ja3M6DQoNCiAgICA0OC4w
NyUgIGJvb20gICAgICAgICAgICAgW2tlcm5lbC52bWxpbnV4XSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBba10gdGVzdF9rZXllZF9zdXBlcg0KICAgICAg
ICAgICAgfA0KICAgICAgICAgICAgLS0tMHg1NTQxZjY4OTQ5NTY0MWQ3DQogICAgICAgICAgICAg
ICBfX2xpYmNfc3RhcnRfbWFpbg0KICAgICAgICAgICAgICAgdW5zaGFyZQ0KICAgICAgICAgICAg
ICAgZW50cnlfU1lTQ0FMTF82NA0KICAgICAgICAgICAgICAgZG9fc3lzY2FsbF82NA0KICAgICAg
ICAgICAgICAgX194NjRfc3lzX3Vuc2hhcmUNCiAgICAgICAgICAgICAgIGtzeXNfdW5zaGFyZQ0K
ICAgICAgICAgICAgICAgdW5zaGFyZV9uc3Byb3h5X25hbWVzcGFjZXMNCiAgICAgICAgICAgICAg
IGNyZWF0ZV9uZXdfbmFtZXNwYWNlcw0KICAgICAgICAgICAgICAgY29weV9pcGNzDQogICAgICAg
ICAgICAgICBtcV9pbml0X25zDQogICAgICAgICAgICAgICBtcV9jcmVhdGVfbW91bnQNCiAgICAg
ICAgICAgICAgIGZjX21vdW50DQogICAgICAgICAgICAgICB2ZnNfZ2V0X3RyZWUNCiAgICAgICAg
ICAgICAgIHZmc19nZXRfc3VwZXINCiAgICAgICAgICAgICAgIHNnZXRfZmMNCiAgICAgICAgICAg
ICAgIHRlc3Rfa2V5ZWRfc3VwZXINCg0KQnV0LCB0aGlzIGRvZXMgbmljZWx5IHNob3cgdGhlIGJh
Y2tsb2cgb24gdGhlIGZyZWVfaXBjX2xpc3QuICBJdCBnZXRzIHVwIHRvIGFyb3VuZCAxNTBLIGVu
dHJpZXMsIHdpdGggb3VyIHdvcmtlciB0aHJlYWQgc3R1Y2s6DQoNCjE5NiBrd29ya2VyLzA6Mitl
dmVudHMgRA0KWzwwPl0gX193YWl0X3JjdV9ncCsweDEwNS8weDEyMA0KWzwwPl0gc3luY2hyb25p
emVfcmN1KzB4NjQvMHg3MA0KWzwwPl0ga2Vybl91bm1vdW50KzB4MjcvMHg1MA0KWzwwPl0gZnJl
ZV9pcGMrMHg2Yi8weGUwDQpbPDA+XSBwcm9jZXNzX29uZV93b3JrKzB4MWVlLzB4M2MwDQpbPDA+
XSB3b3JrZXJfdGhyZWFkKzB4MjNhLzB4M2IwDQpbPDA+XSBrdGhyZWFkKzB4ZTYvMHgxMTANCls8
MD5dIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwDQoNCiMgLi9jaGVja19saXN0LmRyZ24gMTk2DQpp
cGMgZnJlZSBsaXN0IGlzIDU4MDk5IHdvcmtlciAxOTYgcmVtYWluaW5nIDk4MDEyDQoNCkV2ZW50
dWFsbHksIGhsaXN0X2Zvcl9lYWNoX2VudHJ5KG9sZCwgJmZjLT5mc190eXBlLT5mc19zdXBlcnMs
IHNfaW5zdGFuY2VzKSBpcyBzbG93ZXIgdGhhbiBzeW5jaHJvbml6ZV9yY3UoKSwgYW5kIHRoZSB3
b3JrZXIgdGhyZWFkIGlzIGFibGUgdG8gbWFrZSBwcm9ncmVzcz8gIFByb2R1Y3Rpb24gaW4gdGhp
cyBjYXNlIGlzIGEgZmV3IG5zamFpbCBwcm9jcywgc28gaXTigJlzIG5vdCBhIGNyYXp5IHdvcmts
b2FkLiAgTXkgZ3Vlc3MgaXMgdGhhdCBwcm9kIHRlbmRzIHRvIGhhdmUgbG9uZ2VyIGdyYWNlIHBl
cmlvZHMgdGhhbiB0aGlzIHRlc3QgYm94LCBzbyB0aGUgd29ya2VyIHRocmVhZCBsb3NlcywgYnV0
IEkgaGF2ZW7igJl0IGJlZW4gYWJsZSB0byBmaWd1cmUgb3V0IHdoeSB0aGUgd29ya2VyIHN1ZGRl
bmx5IGNhdGNoZXMgdXAgZnJvbSB0aW1lIHRvIHRpbWUgb24gdGhlIHRlc3QgYm94Lg0KDQotY2hy
aXMNCg0K
