Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDF4F8C44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiDHCdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 22:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiDHCda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:33:30 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7713A1B8;
        Thu,  7 Apr 2022 19:31:25 -0700 (PDT)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237MQXtQ006169;
        Fri, 8 Apr 2022 02:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=0+M4PbkcJi/Tc9nb3sG6Z8Bdqe5mAafuH5wB2HphXIw=;
 b=pQnn7g9KYP3hcdifFM/1HYDuJM06nps3xb1qlo0sWze2TCrn38svOZlZWz09GjHczqfO
 QYu6Nmw9IaU0oQ9jJKKoz5aP0rH12ZVfd2IUNHJRntiYA9EFinpINfmyFbAwbAbkotia
 8vL2soQs5n+carx92uu/Ea+QtokDLUM/bshrKIkQE+wRnr0Dh3lSTyuUHylLkSXVTp47
 5qR/w9zQKnYzsbaLMJVx8Zff8/1CBEAX35aCd90K/mYCwZ69WgUw/aOg8gUYMpd6zCtC
 21M+lDZowY46FOU2lxKwL497JLsWZuYRLNZWzN831ASJal4lIbKjrzdiGlcdHky+IdA3 fg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2044.outbound.protection.outlook.com [104.47.26.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f8wx8jjde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 02:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAeziylXZUyjw1hXHCLpAG4YjvT9Sc6JQNxgWmEnkuXnhNGNHLCs0KcxvcRqs+kfS0fUK37zBACTXkc6ZejJwmoTkWBYqQywMMZ1pBpbemN+eDp3rC/4A2vMWFDRRqPmFn5dSOZvjgcRz4+EnyFBEx8cGBPt5OPtivHasv+k/nxqhLZVFaTKvmZc94/d97dYduLTnLcd0ZHE1Sk7VSnWexjN6a1cpW+58a7w6fe6buNvJJe6gspVRn7CCqKapO4rrqbA2sjWdIFx/6B69CpyTkTtCmMZ1YFUSw8vOfyBTrtfR+ekiUMrJWsa23vvsQSloCScWmlPNo593dXXppW9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+M4PbkcJi/Tc9nb3sG6Z8Bdqe5mAafuH5wB2HphXIw=;
 b=TNfBXvp65/cr7lho6E0Jh5IEN0WuqhPd2K8+ZkSNOCUjUFn7q0ZrBukkCOz6E44FYWbM0tuUFz3XCSYrBdPsk4JFdLhaJHhADrFmdbpvW3+YT03C74xfGzaEi5Q2rjAblTpsdHQ1MT3Lb9rM6u8tCMrvHR127wSzjYkBWOfD4tQREya72rSyRt8KFJIDTGh648v2oD2pv/KU0IONe6n2qf5IIy3WJFWpWDXi9R69KKC2USzvjRVaeZv2+OwWoIbAaBJjhY060ai4069lmAWzvBRa/vg3R1fXO8M9Jnok+e3cl+V++CqFyHDDDuz7mMEJxJ+3D0XP9qwJcIFoxcpHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SI2PR04MB4154.apcprd04.prod.outlook.com (2603:1096:4:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:29:34 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 02:29:34 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH v2 1/2] block: add sync_blockdev_range()
Thread-Topic: [PATCH v2 1/2] block: add sync_blockdev_range()
Thread-Index: AdhGQJxpg7LpERZLRKCnO5+IYADlBABnxzoAAG99VxAALla2gAAmLhjQ
Date:   Fri, 8 Apr 2022 02:29:34 +0000
Message-ID: <HK2PR04MB38918D93372C03934B2D1A4A81E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914CCBCA891B82060B659281E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Ykp5cmdP3nV8XTFj@infradead.org>
 <HK2PR04MB38910663E1666A0C74A5618781E79@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Yk6cnX5eHrJYrVXQ@infradead.org>
In-Reply-To: <Yk6cnX5eHrJYrVXQ@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20d5c69d-6440-4fc1-658e-08da19079ea8
x-ms-traffictypediagnostic: SI2PR04MB4154:EE_
x-microsoft-antispam-prvs: <SI2PR04MB415435528C64FE4A5E8C7CD581E99@SI2PR04MB4154.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2LPCFvggQMhf/fxVC7ilkI+fFv4JNHMgUhKnRnD+i6XJzhsJrlGTgw8gGXbL/UM1dhLQ7FmdcZFZevt5b7+5o/xx+9Qt3PTi+JRqNtgjPU2sE7gQUzNGVFNvsfe8lbi6fZAgnYEvuRS+woBCWt92GlCy7srd5Qe2PwjMX+ZviGvZRLbiycGupfgj6dJsQ97CztBR1KtOJnsUEYnGfK65yGGu0K2Cxwcg3HRYgoHnZ2ivmAjuW5KIb+qRhOMs4OpcfS+FvAu3mFBpks52i0NobktkwOhD0/lHtf1n8zvds6e34InZet0/BhrACScGn6HLUCaMwjHDcElFAx1+2AUzmCo8cpMCQrhdutxXOge15mq3EcFGfXR94fNSIiXkl1LsW8wHIhr4AYizgXyGf9M3tssj6+8Lo5CkLPuDlx4aQhYsBVGJa81QujayAi0yzQQqX0zeWk72L+K1tCFNXmtdAtj0fd8Nfs88p7QhE95c2Rk84BMNQbZCv+uWJ5peUMU7ALQmS8LI420gpE7WeDSmLnONze8jHHn1Lm1ovWW6BGOccMfEm/80hopEaSUKAPYhUgEQUlReWgPXXi4Uk+L2/LHgP5zriXj/tt/JatNIYn0uJRHj4AMsVDDBeszJSvS/OcEv3qN218wI0zX3+lkda55h0CPwmm0+dGScOSlc+VbNC13s79jqDkeRKR4Yex7v9H0U4wKCmRleC2BXJziBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(8936002)(6916009)(55016003)(64756008)(122000001)(52536014)(54906003)(38100700002)(83380400001)(316002)(33656002)(4326008)(71200400001)(7696005)(6506007)(82960400001)(86362001)(2906002)(66556008)(9686003)(66476007)(66946007)(66446008)(186003)(76116006)(26005)(38070700005)(4744005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkFUNTh2UUpZaVBJZXFyTDhQYVluQ2tEQnJMcXR4d1NvSkVkYzd3VGhseHJl?=
 =?utf-8?B?MEY2SGJCREhGRW81SE1HV1dOUjZtYmV2YytleG5SeTFjV0c0R2FtZFp4RGND?=
 =?utf-8?B?T0NZZHMzUXZqa25BT3JUbm5UVnoyNS9HT05QVTFVM3Jtb1hXdEVNM1dvN2pX?=
 =?utf-8?B?MTUyRDhycG0xZ0luVzJ6bHQ5Z01MYk9BYVg1WmZxVjVtYnBSM3NyeGtvSWpO?=
 =?utf-8?B?KzkwRHVRMmo3aWtaajljajVONElHZ1QrZy9VZU4reUFEMG1vdUxHcVpOR00v?=
 =?utf-8?B?VVpqYnNNYTVjM1BGR3BNck5hTUwrYWkxNlN1b1F2MGlpaTFJUWpmMHVXbW5P?=
 =?utf-8?B?a3gxY0s4M29XOFQ1Z2ZnSUdxbjlFZTFWVjJsc2gvWmxzUjJxNDM4RDNod0RL?=
 =?utf-8?B?WUQ1VktnczA0NHF6SDRXRTJxMGZ2dmUvV0QrMzF4MW5uNHNxUW00UjJDUUs4?=
 =?utf-8?B?THQyTkE5NHhIVG9FUUdvUWxzYzZXcWo4dmk3K2pGM1k4NTgvRVVvZFI1Rk80?=
 =?utf-8?B?ckhFL21SK2lzeWh5bGtSNHhGanJGMThsWnBIRDVvczU0QnhweHVCVEt3Ri8v?=
 =?utf-8?B?MEJpZGhBeG1oQmJnMU5DWDlTdUNWdHdlUnVna1hCNEVpK0pLQzQ1RG9kM1Rs?=
 =?utf-8?B?eENWMHh1cmgwZnI3SEgwN1JiN0UvQUxJWFJ6NjUwZmZmelFKcmhqWmhyRlNn?=
 =?utf-8?B?cjl5QklkSmlZZnMvZDZKNXhsWTJrdUFuQzRwb28wd3pBNklFdEwzMFp4bnBO?=
 =?utf-8?B?MDNKSklzVTh0c3hjQ3RRSWxLZ3ZCdWdTYUJibjhSN2pjSE1pbDFMb3c0V3ZX?=
 =?utf-8?B?b1ZlTkRBOE5ZMTFNcUlpMVZvMG1Tby9YSE1aYS81UEdoSEMyeERpdmtUckpZ?=
 =?utf-8?B?Z3RORHhLc3ZReVdiUStEMzdxa000RlQxeEtyZWVCUFljTjV0QXlMVzEzSkJ2?=
 =?utf-8?B?QmF6TG00bjBHZUJvSXBSMVQ1M0c4UXZtblVpVXZraUlvUzFBM2U1dW1XWWFD?=
 =?utf-8?B?L3NZdjFlTUhxaG81TFFKVlhOYlZvYklzb3hwNjFjeEdrTFFYQ0hCR1hPZ3ZR?=
 =?utf-8?B?N01lOEttUVpqMk92ZURvazJuUHZSQjExVnhGUVcvTWRITHFmQXQvWGdNSTdy?=
 =?utf-8?B?R0gxdFJPLzdkQUt2alRreUpZZnQvK01TN2dyM1RRakFITUlFcG9WZ2ZjV082?=
 =?utf-8?B?TmpJeXZpcWJZNjJaU2o2TFJnM0xWRXhacWY1U0tMVVRmeHFpSUF4UWZ6Ui90?=
 =?utf-8?B?VUhWMDQ0cTd6eTlvVkVYWEsvY1JWOTZndGVxTnRVTG92aUtVSzhjMU41cGkz?=
 =?utf-8?B?bGhvNlM2Q2xxR3Z2UU9CMUF2R3RhZ2orUitmZ3phYTRuMWk4WXBuc2tIa2lr?=
 =?utf-8?B?RStGVGY5TTYxdm05dzFRb1V6MkdFU1EyczlSQ1dKZThsTGl0eDdFd3ZHM0hj?=
 =?utf-8?B?bm1MYXQ4c05xamdJWG1BTnM5UVJqS01sRXpQd0VNcHN0bVI3VUN3SU1jNzJM?=
 =?utf-8?B?S0FFbjc3Q0c1azlqVndTc1ZLN3Azb2xyWG1LNGRIaXFqS1dBZlVwZHhib055?=
 =?utf-8?B?clJaOVJQZ3BneWFFSWtyTDJEY2hDSHBtczdEamcyTXgydXhvWGFlYXhTOWtL?=
 =?utf-8?B?NkN0OWZlcTJNMU9RWFp0QkYxc2NqUkRqV1BuQi9rRGQxallEUTcxUDBXVXY4?=
 =?utf-8?B?bWJ1SUZ0NGc0S1FuR25GZmZCQmlUOHU1Q3NEN0xFeUhydnVsRGl2VC8vc2JY?=
 =?utf-8?B?WDlCekVxaEt4ZGIyd0pYRWVzYUV0czdVVmxCYVV6WElYaUFCbzZ4R2JSUG82?=
 =?utf-8?B?bVNUTUl4SVdrbnEybzVnRjdkWWxib2VKa1JaalkwU20wa0NXM0FWbUJ3MHh5?=
 =?utf-8?B?UElKbURLN0RUUHFwYWtpRmVvVHVwVEVTM2JKS0psOXZXeXNVeUdmMEVEMmo1?=
 =?utf-8?B?UE5hRjNabnVBejhCbE5MZ3pJUXY5QUhYSXRLdmlrMVYwYjlGakp4YVN5RCtx?=
 =?utf-8?B?alBBdGJzUGIzZmc3MDBBSjJXWkE4b0I0UkdjZklqNjZhV0dxb3hlSWJrU0xu?=
 =?utf-8?B?ZFlrQ3o0RExNSVMvVVZMTWhoZjRTYTAwV3BRZkxLQVVldlF2R0hkR0JqMUxD?=
 =?utf-8?B?cGdCQjdjUFkzdlVibE5XSkhaT3hLZzJZRFpUSFBRSkVtNHNXMGYwZURsL0FW?=
 =?utf-8?B?ZUlQelVrcVp0L21lQlA1SVhCdmE2RnBqNnVBd3Y3RERkSmNZSkhvV3NQRldH?=
 =?utf-8?B?bUcxNXJMdTE5RzBLY2RFTTZWcGpnVThldDR6Z2N3U2QxdmlEUG8zMyt2MjZv?=
 =?utf-8?B?WEdRdnFkRkU1UjladUtJcmY0NlhGM3pMajRtYXFIbDJaVE1PS0xUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d5c69d-6440-4fc1-658e-08da19079ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 02:29:34.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrcy+YdLMXe1+V8j8+0jGWJ3IbYdiL9JGiIzs/0M0Tkyx5mRHDCzEfw5rX+F4SRgqwOH5iX3mQJgaMlXiYIC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4154
X-Proofpoint-GUID: ICa_xo0cMjCKeFQsuA0LGHzpN84km3oP
X-Proofpoint-ORIG-GUID: ICa_xo0cMjCKeFQsuA0LGHzpN84km3oP
X-Sony-Outbound-GUID: ICa_xo0cMjCKeFQsuA0LGHzpN84km3oP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+DQo+ID4gPiBUaGlz
IGNoZWNrIGlzbid0IHJlYWxseSBuZWVkZWQsIGFuZCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgYQ0K
PiA+ID4gIUNPTkZJR19CTE9DSyBzdHViIGZvciB0aGlzIGVpdGhlci4NCj4gPg0KPiA+IHN5bmNf
YmxvY2tkZXYoKSBhbmQgcmVsYXRlZCBoZWxwZXJzIGhhdmUgdGhpcyBjaGVjayBhbmQgYSAhQ09O
RklHX0JMT0NLDQo+IHN0dWIuDQo+ID4gSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgdGhlIGJh
Y2tncm91bmQgb2YgeW91ciBjb21tZW50LCBjb3VsZCB5b3UNCj4gZXhwbGFpbiBhIGxpdHRsZSBt
b3JlPw0KPiANCj4gc3luY19ibG9ja2RldiBhbmQgc3luY19ibG9ja2RldiBkbyB0aGF0IGJlY2F1
c2UgdGhleSBhcmUgdW5jb25kaXRpb25hbGx5DQo+IGNhbGxlZCBmcm9tIHN5bmNfZmlsZXN5c3Rl
bSwgYW5kIG5vdCBqdXN0IGZyb20gYmxvY2stZGVwZW5kZW50IGNvZGUuDQo+IEV2ZW50dWFsbHkg
dGhhdCBzaG91bGQgYmUgY2xlYW5lZCB1cCBhcyB3ZWxsLCBidXQgcGxlYXNlIGRvbid0IGFkZCBp
dCB0byBuZXcNCj4gY29kZS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGV4cGxhbmF0aW9uLg0KSSB3
aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggdG8gcmVtb3ZlIHRoZSBjaGVjayBhbmQgdGhlICFDT05GSUdf
QkxPQ0sgc3R1Yi4NCg==
