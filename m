Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF83F15DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhHSJLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 05:11:18 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:62976 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234128AbhHSJLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629364241; x=1660900241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TeVNNX52+ahSnjg7J6VtV1YGhrJuf1cy+5B6VfXs6oM=;
  b=yZ2HDIoyuNJMVDVQ90yG2KBcpwmeNO79uIp5zzmexS8KDxWKfKBJDbrW
   V5PFJpxxOximFD2Jcf4NjkV8npjd+fHd2+BNbvlKbpCUizFCLUF1LDFqj
   q8jscgEmSqKpy8goUfytbNGVvUNQ3UMvXIOq60sMxsxw3BvSsGkWYG6sD
   VB0xWNZiu/qnTuXss5t2EBQQBwHAGv+sCzq/73SkFhHHVVwHQUxPAXCTw
   PjrayEBzFp++Xh9ccmSM6qmn8tYDITGJmEOziJPZ1LLjfF7i6c9zyv2iA
   7vSD0ssYhdxJ3kdUdB0YwEg+fN6SDo1t0mg36wv7yWP6w6fC8zue9QkcX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="37669789"
X-IronPort-AV: E=Sophos;i="5.84,334,1620658800"; 
   d="scan'208";a="37669789"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 18:10:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgXeKAKPujlJsjNLCZE6qL3hb9g5W0/PABOL7btRRPC5ej0EEHWXYK1XiEXAmjk2PdXQnicG8FPcqXma0V2mMOYwQP5SJOUTmyyLbHnIRdaiu2HNWUY3fbWB+0iabvTV1gOnal0UlD6IY4hpkCGsOYB74ekcTvuX+vKRUp0PaP5VWtcY7Y/tL8gbpzHlXaOU4zCBPu5xn5F/t6v8W43q0wwhlwUhAGgJjKMYKOYGBuHdC+8Pi/sYCDt1uOCuaPVzBSkAiylEdpN52BcDrGIVUCCV2EC1CQNxiJLPFmPSp0pUs7r3jOmzaRZamWUVuZN6IL8xLBDTN+fU62eABcvc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeVNNX52+ahSnjg7J6VtV1YGhrJuf1cy+5B6VfXs6oM=;
 b=FMZRpLa2+pHNJYFW1HIGRun6M8P2EIc/hULamZOBcJz9Y899EwtONZbnWeNzV+HLU4lkbAvUcTKCYIo4Ysh0o1p8tZ3jsPCKt1e8B1PvR9YDvs7D/kvZ5y/Ubd8VX85Ak4brzpDurb2xTkV+ORRQ9ANTHhZhGrgVlmggHk3jaPLjw9TvGzUXfvI9pBjMxJV6IekQGyjJjfuomIOQ2GOHz4hCmDKbf7Lpsk2u9mcD+Xq8PM65OyqnGZxUtERvPgKZKqjd9n8R1+QxurDTeCoU3QBK5WJeW72lplc2TB2KEGM9X33edDvVLmhYwJmUpB4Ua9157z68FqVVFjHQCLaCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeVNNX52+ahSnjg7J6VtV1YGhrJuf1cy+5B6VfXs6oM=;
 b=BidYb79Qi5uy5t3fA6rtjcL0e4dSW+H8N4vr3tue8e9LIL7uuh6IXxvrVeUaTm6vbgU3eGtuAJ0k4HX97WItXIGFnJQEfH89EnpI9s2kLB97bJAfbwZbgKQOE+sc1v0V8+dPcQma9vQ+YIJQ4dqBIWM3lH6vJWPi5ScElHsEfp4=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6724.jpnprd01.prod.outlook.com (2603:1096:604:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Thu, 19 Aug
 2021 09:10:32 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 09:10:32 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: RE: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Thread-Index: AQHXhSoSnS/qStIblEyff+FzJU/rBqtlt1aAgBDEPoCAAmInAIAABusAgAGlyQCAAA74AIAAC+cA
Date:   Thu, 19 Aug 2021 09:10:32 +0000
Message-ID: <OSBPR01MB29203E90FCF9711D8736C8D4F4C09@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
 <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
 <d908b630-dbaf-fac5-527b-682ced045643@oracle.com>
 <ab9b42d8-2b81-9977-c60a-3f419e53f7bc@oracle.com>
In-Reply-To: <ab9b42d8-2b81-9977-c60a-3f419e53f7bc@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d365d7e3-2fb8-4726-90da-08d962f13287
x-ms-traffictypediagnostic: OS3PR01MB6724:
x-microsoft-antispam-prvs: <OS3PR01MB6724C04DCBDD3438DA314BBEF4C09@OS3PR01MB6724.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9olvzgm7caErg4snYe/imrHXAIemqpcEbIHxZNVOifYjOuAtDkPve3fQMc6TEvt7eg8XXlzah3nKy4MIrMyN/H2hGIV0O/ShS60FkqJLPkWXo4S4if76XISP1XQsBS/8p7Zw8BhI6q9S8TCadP0oREvPH+H8YxjYbn4pk8EtgS6NiDZE+zWIAGUsRq6L6VajkgieOmS/UjLvmJeH0S58C9UkMbKs2LEwh7wOu8DFWxAnHWHUcNAQPinFpKgSnj5/F561b07PDvoq7ZGuIh+v9ors0NAIgfEE7NBJO45lWpU+WC9k3feIvaXvJj5MiNFab1UJmemn72hC42cDqGMUlMOwaObZk9CEaKKqfcjLw/utJ2L7BNZLZ0wN/knorzk2+v9ddAXzw0VviSuFhEeCwG03Y2mdf5J7jwAmkdxr0I1+ciO6SCd6qo9BiIpQQK6VgzdYSMcfXi2Dx6Cty8nVqiThfNA4ySJeJUZTfBJ1to6tsNiLeVa8JaAXGXyLWaC6/3jOTjSxbr+YPzZF2MpWrDQEt5hI7rVooljLwdBlBe+1Nzx4NQ9/9f6gYKg7eZOYK7MlJE2aR5wP3EslK6cTA0tgaVf1QA061BOtNICiL3w0YYwh1lEWLRU3qETeg9odPUXQnJrJvBNIMa+FyCnuNzQZQBoNG+RhR27WPf7ymCq5rq9nqGa4BcCMP/ICn/yTiQYlCHQusGY38+5BT0sh7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(9686003)(83380400001)(86362001)(316002)(54906003)(66446008)(66476007)(85182001)(110136005)(71200400001)(26005)(2906002)(8676002)(478600001)(4326008)(186003)(7416002)(66946007)(52536014)(64756008)(66556008)(8936002)(33656002)(5660300002)(53546011)(7696005)(38070700005)(38100700002)(55016002)(122000001)(76116006)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L09ERWRwZTQyd0k3cHNWaEdtT0NWUWlUdGk3NEtTc1Y0bU53d25qdHpGOCtK?=
 =?utf-8?B?Ni9jSko0M0YxbFByZlRuSGZoTWo3bzFkZFUydWlqQkNGb2NiVWdib3Bzcmxu?=
 =?utf-8?B?RDdUY29hS1RQYlhHZmdLeFNXVnVEU0tZOWQ2M2lEVnBLS0xOU3BhVW9ySjdq?=
 =?utf-8?B?cXhZdlptVzM5WFd0VHdaNHpYU0JpdkNKa1VERkJseTBhUEtkU1ppK3NhMGJH?=
 =?utf-8?B?WU1VTWZvOVBtM1ZQRGk2dUF3VE56dEpnM0JBbEFTZndFaHNaVHJQQlY3aTZB?=
 =?utf-8?B?b2VSTnZ1MURqdHJiaDAzNkxsUENyTDlyL2RGZHQyWHBULzI3VG9Ud0JUMm00?=
 =?utf-8?B?ZXRocUtPbWdQU3UxYVJQOFRyYlFzZGo2ZkFFYjlrYVEybm9MMXJLc1NwRng0?=
 =?utf-8?B?dEJNMU90c3Q1d09wTEIwRXhjdGdxR295cHl5Y3ZySXFtVFh4Q28rZ2Rhc1hw?=
 =?utf-8?B?OXRjaXB5alNUcWoxa3dMMXdzdTJCOEp2UjVvaThzNHNxMkVsL0Z2MHNxc2Nx?=
 =?utf-8?B?MDVQU3dtY3BFOU5oZkNsb0wxZzN2UEowQ1k1czJUajIwUUw1UGdaNXpsbXdU?=
 =?utf-8?B?bmpud1NDemlidlZ2VCt6NHZSMGlFNWE0a0tsNzFEK0JVd042MzZnVHRYelVC?=
 =?utf-8?B?YnBUeGdUd2U5ZGpTbEhyUjQ3WDJPNnRjeklGUVpCWGFqMkc5MmVpcHQ3R2U4?=
 =?utf-8?B?c0p5cVRaZ29nMVBNZXdHandrT21zaytzb2Jtai9LNzVBZ3llZXAyNG95bWpo?=
 =?utf-8?B?QzBpbC9jSnhjQ3J0czZNNSttZHVMREVXcUltT1p4TGJJd2JmZWtOTFFobHRR?=
 =?utf-8?B?TkhrOGdaOEp3T1VNbjZuaGR4di9GSXJYdENtVUd1OGlpRlI2WjREYitIUDhY?=
 =?utf-8?B?bU1ZdVFEMUNLU0crVll6V0FobWdPV2pSTFRHWWFROHk5anJFU1A1RWhYOVMy?=
 =?utf-8?B?dS9RZzdHTHRvNkduRytlaUJHVTl0VklYRjlVbi9oaUJiMitjek4xYVlHcUpQ?=
 =?utf-8?B?dlpwcFFxWFZmZEorSzNGcnhRamwxaGdGeFlLWmNKSnJ4VEdTTmgyRkpudzZz?=
 =?utf-8?B?b29NeHMxWEd1ZTU2ZFBLY2VqbGVGWkxrMWcxVjFVc3BFMGZCVElzOStTL1Vx?=
 =?utf-8?B?QTVjbEQ0UFE0SHZEVHBGUkNjaTQ0elVTbFNYbkFYNERQbjY5blFJM1ZmZExP?=
 =?utf-8?B?UllXQ0h4L1hvbkNvK1NlQVRmWUNTREVzYTdhL1JTUkU0blpHejNFR2VJaDQw?=
 =?utf-8?B?ZkFSV0xBbG54MEkxanlnWW83YVFvUnB1Y1Q4eDlWN2l0ZEt5eklsc1VMV21a?=
 =?utf-8?B?elJ3dGRaWldpY2owWGp5UVVVUW5iN0dvbEhoaDQyVDlkb1BneHhnSk9SQmI5?=
 =?utf-8?B?NjFXU1RrdGlEMjJHc1Erdi9pQnJ5dkVPQyttUlY4ZlNLbS90OUNPcXBnbmI0?=
 =?utf-8?B?ZkNQblc3dDYxOEt4QXZsa3dOME9ML3hNZFVGZEhFdWdhVkFvR2RMcTB1NUNR?=
 =?utf-8?B?aFA4bmpZM3dPU3UzMEJibHJGamwrVHhpOEJ4MFBwT3hybmpiTW9mQ2lTVFd5?=
 =?utf-8?B?S01LdGZoK0daMWlRT1c1ZGRZaFZsZXYwZThwZGhYNWpVRUJTS242SGUreGh4?=
 =?utf-8?B?TmZYenlGb2NiOEpWdmUrUmJKYTF3YzZCRXN3WXdObTJXNHpubEtMblV5elJx?=
 =?utf-8?B?aXJzazErSTVsWlVHMWxGZVlqNm1HaHVRaDVSUndTdmtpcVhaQUE5VUhPMWFo?=
 =?utf-8?Q?snt5O0sa2gKUdCq2IdgDcvg4IPQ9N/n8mHvL/xq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d365d7e3-2fb8-4726-90da-08d962f13287
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 09:10:32.2742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVsF+UBl2mfXEkw79vHEJffrLv/3Y5SFOIbonAQAYHBrNjsjvB/5fG8k1R8+k80N+A1dd4X4+n6VTMuE1JtB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6724
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBSRVNFTkQgdjYgMS85XSBwYWdlbWFwOiBJbnRyb2R1Y2UgLT5tZW1vcnlfZmFpbHVyZSgp
DQo+IA0KPiBTb3JyeSwgY29ycmVjdGlvbiBpbiBsaW5lLg0KPiANCj4gT24gOC8xOS8yMDIxIDEy
OjE4IEFNLCBKYW5lIENodSB3cm90ZToNCj4gPiBIaSwgU2hpeWFuZywNCj4gPg0KPiA+ICA+wqAg
PiA+IDEpIFdoYXQgZG9lcyBpdCB0YWtlIGFuZCBjb3N0IHRvIG1ha2UgID7CoCA+ID4NCj4gPiB4
ZnNfc2JfdmVyc2lvbl9oYXNybWFwYnQoJm1wLT5tX3NiKSB0byByZXR1cm4gdHJ1ZT8NCj4gPiAg
Pg0KPiA+ICA+IEVuYWJsZSBybXBhYnQgZmVhdHVyZSB3aGVuIG1ha2luZyB4ZnMgZmlsZXN5c3Rl
bSAgPsKgwqDCoMKgIGBta2ZzLnhmcw0KPiA+IC1tIHJtYXBidD0xIC9wYXRoL3RvL2RldmljZWAg
ID4gQlRXLCByZWZsaW5rIGlzIGVuYWJsZWQgYnkgZGVmYXVsdC4NCj4gPg0KPiA+IFRoYW5rcyHC
oCBJIHRyaWVkDQo+ID4gbWtmcy54ZnMgLWQgYWdjb3VudD0yLGV4dHN6aW5oZXJpdD01MTIsc3U9
Mm0sc3c9MSAtbSByZWZsaW5rPTAgLW0NCj4gPiBybWFwYnQ9MSAtZiAvZGV2L3BtZW0wDQo+ID4N
Cj4gPiBBZ2FpbiwgaW5qZWN0ZWQgYSBIVyBwb2lzb24gdG8gdGhlIGZpcnN0IHBhZ2UgaW4gYSBk
YXgtZmlsZSwgaGFkIHRoZQ0KPiA+IHBvaXNvbiBjb25zdW1lZCBhbmQgcmVjZWl2ZWQgYSBTSUdC
VVMuIFRoZSByZXN1bHQgaXMgYmV0dGVyIC0NCj4gPg0KPiA+ICoqIFNJR0JVUyg3KTogY2Fuam1w
PTEsIHdoaWNoc3RlcD0wLCAqKg0KPiA+ICoqIHNpX2FkZHIoMHgweDdmZjJkODgwMDAwMCksIHNp
X2xzYigweDE1KSwgc2lfY29kZSgweDQsDQo+ID4gQlVTX01DRUVSUl9BUikgKioNCj4gPg0KPiA+
IFRoZSBTSUdCVVMgcGF5bG9hZCBsb29rcyBjb3JyZWN0Lg0KPiA+DQo+ID4gSG93ZXZlciwgImRt
ZXNnIiBoYXMgMjA0OCBsaW5lcyBvbiBzZW5kaW5nIFNJR0JVUywgb25lIHBlciA1MTJieXRlcyAt
DQo+IA0KPiBBY3R1YWxseSB0aGF0J3Mgb25lIHBlciAyTUIsIGV2ZW4gdGhvdWdoIHRoZSBwb2lz
b24gaXMgbG9jYXRlZCBpbiBwZm4gMHgxODUwNjAwDQo+IG9ubHkuDQo+IA0KPiA+DQo+ID4gWyA3
MDAzLjQ4MjMyNl0gTWVtb3J5IGZhaWx1cmU6IDB4MTg1MDYwMDogU2VuZGluZyBTSUdCVVMgdG8N
Cj4gPiBmc2RheF9wb2lzb25fdjE6NDEwOSBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRp
b24gWyA3MDAzLjUwNzk1Nl0NCj4gPiBNZW1vcnkgZmFpbHVyZTogMHgxODUwODAwOiBTZW5kaW5n
IFNJR0JVUyB0bw0KPiA+IGZzZGF4X3BvaXNvbl92MTo0MTA5IGR1ZSB0byBoYXJkd2FyZSBtZW1v
cnkgY29ycnVwdGlvbiBbIDcwMDMuNTMxNjgxXQ0KPiA+IE1lbW9yeSBmYWlsdXJlOiAweDE4NTBh
MDA6IFNlbmRpbmcgU0lHQlVTIHRvDQo+ID4gZnNkYXhfcG9pc29uX3YxOjQxMDkgZHVlIHRvIGhh
cmR3YXJlIG1lbW9yeSBjb3JydXB0aW9uIFsgNzAwMy41NTQxOTBdDQo+ID4gTWVtb3J5IGZhaWx1
cmU6IDB4MTg1MGMwMDogU2VuZGluZyBTSUdCVVMgdG8NCj4gPiBmc2RheF9wb2lzb25fdjE6NDEw
OSBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb24gWyA3MDAzLjU3NTgzMV0NCj4gPiBN
ZW1vcnkgZmFpbHVyZTogMHgxODUwZTAwOiBTZW5kaW5nIFNJR0JVUyB0bw0KPiA+IGZzZGF4X3Bv
aXNvbl92MTo0MTA5IGR1ZSB0byBoYXJkd2FyZSBtZW1vcnkgY29ycnVwdGlvbiBbIDcwMDMuNTk2
Nzk2XQ0KPiA+IE1lbW9yeSBmYWlsdXJlOiAweDE4NTEwMDA6IFNlbmRpbmcgU0lHQlVTIHRvDQo+
ID4gZnNkYXhfcG9pc29uX3YxOjQxMDkgZHVlIHRvIGhhcmR3YXJlIG1lbW9yeSBjb3JydXB0aW9u
IC4uLi4NCj4gPiBbIDcwNDUuNzM4MjcwXSBNZW1vcnkgZmFpbHVyZTogMHgxOTRmZTAwOiBTZW5k
aW5nIFNJR0JVUyB0bw0KPiA+IGZzZGF4X3BvaXNvbl92MTo0MTA5IGR1ZSB0byBoYXJkd2FyZSBt
ZW1vcnkgY29ycnVwdGlvbiBbIDcwNDUuNzU4ODg1XQ0KPiA+IE1lbW9yeSBmYWlsdXJlOiAweDE5
NTAwMDA6IFNlbmRpbmcgU0lHQlVTIHRvDQo+ID4gZnNkYXhfcG9pc29uX3YxOjQxMDkgZHVlIHRv
IGhhcmR3YXJlIG1lbW9yeSBjb3JydXB0aW9uIFsgNzA0NS43Nzk0OTVdDQo+ID4gTWVtb3J5IGZh
aWx1cmU6IDB4MTk1MDIwMDogU2VuZGluZyBTSUdCVVMgdG8NCj4gPiBmc2RheF9wb2lzb25fdjE6
NDEwOSBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb24gWyA3MDQ1LjgwMDEwNl0NCj4g
PiBNZW1vcnkgZmFpbHVyZTogMHgxOTUwNDAwOiBTZW5kaW5nIFNJR0JVUyB0bw0KPiA+IGZzZGF4
X3BvaXNvbl92MTo0MTA5IGR1ZSB0byBoYXJkd2FyZSBtZW1vcnkgY29ycnVwdGlvbg0KPiA+DQo+
ID4gVGhhdCdzIHRvbyBtdWNoIGZvciBhIHNpbmdsZSBwcm9jZXNzIGRlYWxpbmcgd2l0aCBhIHNp
bmdsZSBwb2lzb24gaW4gYQ0KPiA+IFBNRCBwYWdlLiBJZiBub3RoaW5nIGVsc2UsIGdpdmVuIGFu
IC5zaV9hZGRyX2xzYiBiZWluZyAweDE1LCBpdA0KPiA+IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBz
ZW5kIGEgU0lHQlVTIHBlciA1MTJCIGJsb2NrLg0KPiA+DQo+ID4gQ291bGQgeW91IGRldGVybWlu
ZSB0aGUgdXNlciBwcm9jZXNzJyBtYXBwaW5nIHNpemUgZnJvbSB0aGUNCj4gPiBmaWxlc3lzdGVt
LCBhbmQgdGFrZSB0aGF0IGFzIGEgaGludCB0byBkZXRlcm1pbmUgaG93IG1hbnkgaXRlcmF0aW9u
cw0KPiA+IHRvIGNhbGwNCj4gPiBtZl9kYXhfa2lsbF9wcm9jcygpID8NCj4gDQo+IFNvcnJ5LCBz
Y3JhdGNoIHRoZSA1MTJieXRlIHN0dWZmLi4uIHRoZSBmaWxlc3lzdGVtIGhhcyBiZWVuIG5vdGlm
aWVkIHRoZSBsZW5ndGggb2YNCj4gdGhlIHBvaXNvbiBibGFzdCByYWRpdXMsIGNvdWxkIGl0IHRh
a2UgY2x1ZSBmcm9tIHRoYXQ/DQoNCkkgdGhpbmsgdGhpcyBpcyBjYXVzZWQgYnkgYSBtaXN0YWtl
IEkgbWFkZSBpbiB0aGUgNnRoIHBhdGNoOiB4ZnMgaGFuZGxlciBpdGVyYXRlcyB0aGUgZmlsZSBy
YW5nZSBpbiBibG9jayBzaXplKDRrIGhlcmUpIGV2ZW4gdGhvdWdoIGl0IGlzIGEgUE1EIHBhZ2Uu
IFRoYXQncyB3aHkgc28gbWFueSBtZXNzYWdlIHNob3dzIHdoZW4gcG9pc29uIG9uIGEgUE1EIHBh
Z2UuICBJJ2xsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCg0KLS0NClRoYW5rcywNClJ1YW4u
DQoNCj4gDQo+IHRoYW5rcywNCj4gLWphbmUNCj4gDQo+ID4NCj4gPiB0aGFua3MhDQo+ID4gLWph
bmUNCj4gPg0KPiA+DQo+ID4NCg==
