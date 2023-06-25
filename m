Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3964C73CEB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 08:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFYG35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFYG34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:29:56 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DDE47
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 23:29:55 -0700 (PDT)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35P6TZF4013013;
        Sun, 25 Jun 2023 06:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=QfmRO1HDMVyDgyCJ+B+tRrae2TdohhYKIcuKWbP9wLY=;
 b=f+oIoNfDHCQOsiC80XdwhAj6stVer8hZLOIQH3WloTpu3jzRQ73QdhdjdIE75HuZYzSM
 MOzevZ7Eu1NhK7gB65vH7iGSOeRcq79j6v3ajEMalst/U9rpCc5bVReJYrdEWsRMq0Fi
 hKomEzs8DwNIM+rGQo0vzeW4mNAmele6EQ3iq/MDP4p8p54uZ0olj6DPv43ZskcRwVvi
 2l2wnrrxbcIyGFkjKd7Aaw8+W9oRzRRTY1ukS0a0LpUEbjRDImd9gkPILL99ssvUVvoi
 WIpO/1XCdQQInPb/O3wPEh7z5OTmRDKIY2rDi2fgjBn/xmJNCZTwSZ6uVY84TroistB7 sA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2111.outbound.protection.outlook.com [104.47.26.111])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3rdqu08qu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 06:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHIFQ4yn8iz6C4bHsvnKOpHolxpvLkTYDkO7qdahZW16V+5ngGUD5x/0TztH8oCl3BRN4VXPVR2YLWWRXRJi4dF5PMOQGS4VbyAeZFE36AiAqey1nSGRVMIP8vgvvjNwOcHd6PAO8YiVX/u0iAGNeE3FMf65mdhDDxoCof2zfDMb4/3x4K/tUjDg4F3juzP1Dz7vNWle3sZp/LD3UqsNXmUJ/yC0H7RzJfyTIFC0FfIKQQnGI/CKcLdFBPJz9ugpedvbXFIp//EYLdh+9yOljzu3KhyL5FuKN0wwlG62YBZ5Sc1WLmKwYkTUq1UgiWMOJ/WnXZwoES/HBBfdP9cchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfmRO1HDMVyDgyCJ+B+tRrae2TdohhYKIcuKWbP9wLY=;
 b=a256WKjb/8JmWRvKDvxK2bpJbxq9tfytQwapBxu7f2tRif/rEAIRmDH1/8C8ld2WHxyb5T3ylb/Sm/Dmw1Ck9ChZjzUvGp9sXZSq/58dA/PXmRZsoRsPYLRnNN0XmONUgKKHKQQKeMg/U8AT0+3sgPEnPnkB0vUYq0rRPE0SCdcH5W9MZZV2jofMD/Bf4xUC8GbEY3rC+50gjhliDHdVGxoi9PBWdZbgLjOKDbIJtRg4D2nLpqloozEbxWSLhHB1VY0ejql76mLoQgpqgMGgdr+7Zp/gEXoDWXahqYaogxP9ngZ/ir9mxEwnRK09N3flC7iNbxTdNwpmEekjSbQKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6298.apcprd04.prod.outlook.com (2603:1096:101:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 06:29:28 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275%5]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 06:29:24 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v1 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v1 0/2] exfat: get file size from DataLength
Thread-Index: AdmfODMxTKFC/pCyRPukKkKvxSTr0AFnT62AAJW6ZCA=
Date:   Sun, 25 Jun 2023 06:29:23 +0000
Message-ID: <PUZPR04MB631602DE8C97F0D3DAA036F08121A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316DB8A8CB6107D56716EBC815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd9ubktMNDdXPBDjRyUeGARMjMR5Hq+vwwCUbhwUmNURtQ@mail.gmail.com>
In-Reply-To: <CAKYAXd9ubktMNDdXPBDjRyUeGARMjMR5Hq+vwwCUbhwUmNURtQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6298:EE_
x-ms-office365-filtering-correlation-id: 131180e2-e3b7-462e-3422-08db75458464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXDpUv4w6TqWv/AuDLX1EcDFdc3fckrkjjHNizsnNiFdgprhOvBM/EZlQvU3yhwLHNPV6I4JlO0nxxH9YkQsxcUZLU1HUS3M/O2Dp4n2iHk5cZp7GISglPqCKZzTROZshWwE+QkmnXwp5CIGvJlSPuB6e4VIYm4WSlerLKPwFj+acVRBBSWi5suaFrVYHIQKpKeA17znx646rJPi4ywb9rd7F7lAxZXdpf/zUAS9IV+Hxyl5EABVSmVFva9BvoSjGESEleGT+tfj4PaApMoQeO0sVX/U2xBjhSH0Sz7S4DtYEAWoRKtnGYxSb2jtDoPJ8ztYyhAlWMo+D6q0WKKki/WGo3TcXWVXA/XHnOAIFwHSM3cr1S9w2WN1v80LhHKO/nshDLO1KVIMNwaQ5lvLf4r4zvnH//E+3foB+vHmLCjkoT3FeNTumt9GJBfJgZbnKDlfH0FjauGL/SRxqFiz7aY8jQJoKulLHpYUOQczI7gL4YVl3MZv5xbnEyw3eD7yn9iYzMkhWpOG0J+sx9b6KgATohURn7Vsiy1iGRhvctJj773AcvddQXiO9r5Oh+LtxGJ/Whc2gxUj3Bao/woPLe+nkmEtWqNDfaCdN15vShBhWF9IsLwmPPKRNGRKAbNL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(8936002)(8676002)(55016003)(64756008)(66446008)(66476007)(66556008)(4326008)(6916009)(66946007)(76116006)(41300700001)(316002)(6506007)(9686003)(26005)(186003)(107886003)(478600001)(54906003)(71200400001)(7696005)(2906002)(4744005)(52536014)(5660300002)(38070700005)(82960400001)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkhXMllEK0xNcW9ERGVYdEluTlBTT1Q1R3k1Yy9QbEg2MWR0SWYyOTdXNXY5?=
 =?utf-8?B?UnVTNU1uWFN3S1E4RDVvZ3dpcjIvRitUWTNtdU5sSnkvOTk4L2Q3c0szUThn?=
 =?utf-8?B?T1o3UWplWnJCemZ6bU9Nc01KVDA2aEluOFBJN1BGNFVuMlJXbWcva1pUcUFX?=
 =?utf-8?B?bTJCajU2WjNLVnlRUDFPbzVrUlhmMGpCek9yVVZxUUtpeFQvQ0Z4WEFHcjBm?=
 =?utf-8?B?cWpLR2FsWFRieVVxeXdMZms4Vlh0RWIwbG9Hd0VoWEhUZ3FDa3E5bENqZXV5?=
 =?utf-8?B?Y1RMN05VNEtvQzcxN3oxNHFZaUdjUUFCaHExZ295SCtORDRNWmVHbitWdzNQ?=
 =?utf-8?B?Z3ZBL2o5QlMxdTN2dVM0QnUzUWZOUnpBREFwOTRRZnNEeWpKY04xTm8rV2JH?=
 =?utf-8?B?QlMyU2xWT2dtTklJdkFqdUZCclVhenNNK0o2OUw3Mi9QanJ1aDMzRlo2NWVV?=
 =?utf-8?B?elNHV2JFTEt6aU5HeWpLbEZuQkRiWlFvYTV0TS9VRkJ2UVNHN21raUZBMXdh?=
 =?utf-8?B?Mjlab0ZjVTl6ZVFtbGJhbUtKRUhCQWJhNFdwNkxQZmtIUk8xZERydWN0Qitq?=
 =?utf-8?B?d1JSZ0VnNWo0NDV4Q0NUWTMxUWpraU5aRGpMOTF1ZitKTjBJcXZGNUdOaFhF?=
 =?utf-8?B?dmFwNnhSUVhoZjBSRGNDOXY4SitsSUpURWMveHAzM0JXZ3NyVjVlN3NxZ1Fo?=
 =?utf-8?B?bms2dzBvR1BOdFlmNHg4dW5YcUFLaUwvV3NiNUk1RkNYU1l6d3JsdFl0aVVT?=
 =?utf-8?B?QXpwbmRyTkVQT0dYUEN4ZzhYY1hiWEdvd3MyQVlKUVl1L2JqMmhTam1jQll5?=
 =?utf-8?B?ZXhjVTFhZ2ppMFhVWmsxL2FrL3FxNVFOTUNVSmJvTmZ0SXgwNXFoWGdVeHd1?=
 =?utf-8?B?ZFJMdEgvVVJYVkxBUUZoc1JZREdud0hqZCt0T3ByNjRkanREM0xRMWZ1TVIy?=
 =?utf-8?B?dk1qaXlydG9ZZUxqWDJnVUx3WUNybXUvNWJaN2x1eHZpMHY3VlJRNWVDb0JZ?=
 =?utf-8?B?RW11amQwajNFb1V4VzJ5NXNVRkJuQVNLK0wwVjVkMnVVNmw0ZXpJM1YxSEww?=
 =?utf-8?B?Q2lZdnczMjd5aDY5OHEyMWRqV2M4S2swNlV0YjkrMXFYSzdCREF5OVNUc0JB?=
 =?utf-8?B?TGxBb0c1ODIvWVZMVjN0bmo1dFNwNE9ub1E2bUFRcEIxVk9GbjQ3Vko1b0lX?=
 =?utf-8?B?eGNOaEZzNFIvZ0NNaUVOMlVEenl4RmYwR2NmdzhQLzRZTzZWaDRnZ1I0QnRE?=
 =?utf-8?B?MDlqR3JOaVpMd2s4VVUxRTJYY3JZTEVEUU96WUxFNjVUUm15UkdmQ1dYOVFC?=
 =?utf-8?B?bEx3UHFuTEQ5WTVQU3UreTdRajhBSU44UExtS1ZDQzFPZGZPMU8vbXloRHo3?=
 =?utf-8?B?VlB4cTV0dExpL2ZtbDJMbTUrZWlYSVViOStYcUxYZ3MxbmgxcUhYcm95L1Fv?=
 =?utf-8?B?U240b0VSRTZ1dFlDNVRJdWQ0eTJjQ01QMFVXaWRQbjZTekNrZ0ErV0xUc3hX?=
 =?utf-8?B?akhndG5qM29qLzNPUVhXRzFFTmxEYnR3UEdiT0V2cW8wM0Q1WXlzZXlpMGQ3?=
 =?utf-8?B?YnN5cEtIRmhQNXZ2dHFIemxVR3BucTNwdXdQTmZmR2UxMW13NWl6cFhHaWli?=
 =?utf-8?B?RjZxRTlSb3JMRGhlbkxXamNzSEdQR3J1czhRc3lTRnhWL2dzVkdRVENoSjJs?=
 =?utf-8?B?cm94S2YrMEVURE4zU1VYM3NyeGFOYjVkSTBrTENySDVaVi9XSlcxUEJZUFpv?=
 =?utf-8?B?OVFKZGh4elNHV1JzcTlIS1BVMFZTbXErbmVqTFNwZEtpU1pWbXJ1c1pYNEZ1?=
 =?utf-8?B?RWI1OFc0aW13M2UyMmUwSVlhRDFseDRsK3RkZTdwK290M2h6bDFWQWZpc01j?=
 =?utf-8?B?eE1JczVVcEtodEhWS2xpSlFTWUR3WFdEaVBjWjJaRTZaVi9oa2UvZTVuZFB0?=
 =?utf-8?B?bk9kTXZJUlVVM1o4U1M2TVpuR2J4VlZNRVlESkpRNkpXdkFBdE1NTWdjUVQr?=
 =?utf-8?B?YkkvNE0vNVkrZEhHTFBDWVNPWXFreVUzVlFpUGROZlhvV1BjNE1WRG83cWxt?=
 =?utf-8?B?Szc2bnJEQllDZXZDa2lvTUJKNGdERHh2TjhXNXcxeCt5OXlybjdibjladVFt?=
 =?utf-8?Q?mDFwNP3Kak4tcFp31Y9NdDJyP?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +r7whpnhBIzugjIHAfOlAmgha5D3t0IrjRikKND++hznwO+Wo323ccR9i7z0Yw30Uw7MIzoHgl4lGP6A6Roi7JcQbiLb/v+KPVTwKGeBMDTC/ySDbBJUG+LGNgwFYH5iFymP3YMvcBRN9ta0cmwojCmj6ArhIaDHbU4C2oJOmxJBTLuIVGAJcdRPSn9k8bo2j1UZkYFFyGkbFQV8g66Mug+s64mwmS6JDznRpVUUm5VT0qOFED3dVlcMGIEzlSKJeATX+7t/9mFiVVSU6pbb8XYuc07fRO7Fgx8Fu3KCdFEbd8MGu8/o5VOzFxMs157E4FNOPimoCCbWjWRhFXwVqpA7SgV6EkBhNMLh9GVgV9deaRlFyRJ5dlqmlsK4rHLAuCLy3SRS/sP95vK9hX23Y9aWjipJnlMgarfsh6x+Rh3FiVkEnF6djXPeUQUY6GIjo2QkIrKIaGlzLrUa3Ea3ztcGlGZnoz8twsOo0bi6CbGzPepzKcsR9ks/1+SNpOn6A9ad3H468SEGq24iIWodDFsa8fA5SiD6uiRM9WxbfShTHm3YTSpK8rIi9q9ONp8IAXRyjrN0hOjYRQIi9itW0EYSDGPt063GfkE07amGJY6DITLSgnhRjzKPQXmfwLyINUT9X0CVEB9m2lW/0kH6AhCpmWLzUm+J1SXevlsYq5j6wkXt51XoJMreb/MdGSbwj0i7RrFJlenMl80B7pwSY2JFN6JOmkniBgULyD+uj6aYjWN2D/PXLFsP6n242FAyeM2BY42whqeWLexwoAOK88EtvNVhHtIgXfT7Z+7moePqrLlO8UOyRg93qpvqyT/I8PjM0bBYcnom20InbkFBTw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131180e2-e3b7-462e-3422-08db75458464
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 06:29:23.7342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3/Mc/hS4xKivQyOSxEuv2zzognzXy5BE23Nj0KW6WFYr7JBmwtkPW1wgxrETZLU23CyLagHzlCA4NUmcseONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6298
X-Proofpoint-ORIG-GUID: 55uB9h_1qjruvLYiqzttReap4WiZeUlI
X-Proofpoint-GUID: 55uB9h_1qjruvLYiqzttReap4WiZeUlI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 55uB9h_1qjruvLYiqzttReap4WiZeUlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-25_03,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSAyMiwgMjAyMyAyOjQ4IFBNDQo+IDIwMjMtMDYtMTUgMTI6MjkgR01UKzA5OjAw
LCBZdWV6aGFuZy5Nb0Bzb255LmNvbQ0KPiA+IFl1ZXpoYW5nIE1vICgyKToNCj4gPiAgIGV4ZmF0
OiBjaGFuZ2UgdG8gZ2V0IGZpbGUgc2l6ZSBmcm9tIERhdGFMZW5ndGgNCj4gPiAgIGV4ZmF0OiBk
byBub3QgemVyb2VkIHRoZSBleHRlbmRlZCBwYXJ0DQo+IEhpIFl1ZXpoYW5nLA0KPiANCj4gRmly
c3QsIFRoYW5rIHlvdSBzbyBtdWNoIGZvciB5b3VyIHdvcmsuDQo+IEhhdmUgeW91IGV2ZXIgcnVu
IHhmc3Rlc3RzIGFnYWluc3QgZXhmYXQgaW5jbHVkZWQgdGhpcyBjaGFuZ2VzID8NCg0KWWVzLCBh
bGwgZ2VuZXJpYy8/Pz8gdGVzdHMgb2YgeGZzdGVzdHMgcGFzcywgZXhjZXB0IGdlbmVyaWMgLzI1
MS4NCkFyZSB0aGVyZSBhbnkgdGVzdHMgdGhhdCBmYWlsIGluIHlvdXIgZW52aXJvbm1lbnQ/DQo=
