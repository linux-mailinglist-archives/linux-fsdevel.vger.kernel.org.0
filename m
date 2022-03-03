Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E84CC06D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiCCO44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiCCO44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:56:56 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9A18FAD1;
        Thu,  3 Mar 2022 06:56:08 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220303145604usoutp02d960234b3f99df9fd351b81d16da1aed~Y5r0yVhKl0709607096usoutp02m;
        Thu,  3 Mar 2022 14:56:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220303145604usoutp02d960234b3f99df9fd351b81d16da1aed~Y5r0yVhKl0709607096usoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646319364;
        bh=Xv6rh5bBMKpt0En8XPzuE5x3oDsTahSvkN6VOetLXtY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=otvf1frVbx+69jUqMkHSfpZa6uKDFUmbWv81hGPnPYlPTzv+x9nwby9VUZkmmHPos
         mx4LBaDwVxb1rXrXK47ebhVzKFBdZWTeDyXALoO1GM60OS4rzFAcqYW/FKfTbT8EqJ
         +RcC2eGUHuFWgPaFtuoRvHdzYq7qzVp9UF9lf3mg=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220303145603uscas1p1136cac99d2d64e911be025e04f4a7930~Y5r0ZRc0q3196031960uscas1p1c;
        Thu,  3 Mar 2022 14:56:03 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 5A.BB.10104.307D0226; Thu, 
        3 Mar 2022 09:56:03 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220303145603uscas1p263bf437711ca7c187835346c5fc01fb8~Y5rz9FUWu1180011800uscas1p20;
        Thu,  3 Mar 2022 14:56:03 +0000 (GMT)
X-AuditID: cbfec36f-315ff70000002778-6a-6220d7039b01
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 5D.F1.09657.207D0226; Thu, 
        3 Mar 2022 09:56:03 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 3 Mar 2022 06:55:56 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 3 Mar 2022 06:55:56 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmb9dDgbycJL0eB2NODtYgLP6ytqQyAgAAQCACAADetAIAAVbuA
Date:   Thu, 3 Mar 2022 14:55:56 +0000
Message-ID: <20220303145551.GA7057@bgt-140510-bm01>
In-Reply-To: <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D550A378FB4F64C83B692D606EE82EC@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djX87rM1xWSDG7Nl7eY9uEns0Vr+zcm
        i87TF5gs/nbdY7LYtv8gm8XeW9oWe/aeZLHY93ovs8WEtq/MFjcmPGW0mHh8M6vFmptPWRx4
        PC5f8fbYOesuu0fzgjssHptWdbJ5TL6xnNHj8yY5j/YD3UwB7FFcNimpOZllqUX6dglcGZuu
        TWUumOZUMeXnDcYGxj0OXYycHBICJhJnGy4zdTFycQgJrGSUeL/qCjOE08okcX1JKxNM1d69
        81kgEmsZJa7cOMgI4XxglOg9/A6qfz+jxMtjn1hBWtgEDCR+H9/IDGKLCGhJLNv3jhWkiFmg
        h1Vi37cHQB0cHMICxhIvttZD1AAd8vooG4TtJnFsylNGEJtFQEXi1p6lYDYvUPmGeTPB5nMK
        WEtM3zaVBcRmFBCT+H5qDdipzALiEreezIc6W1Bi0ew9zBC2mMS/XQ/ZIGxFifvfX7KDnMAs
        oCmxfpc+RKudxOsDe9ggbEWJKd0P2SHWCkqcnPmEBaJVUuLgihvgkJAQ6OeU2HfvGdR8F4mG
        +8eg9kpLTF9zGapoFaPElG9t7BDOZkaJGb8uQFVZS/zrvMY+gVFlFpLDZyEcNQvJUbOQHDUL
        yVELGFlXMYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525iBCa50/8O5+9gvH7ro94hRiYOxkOM
        EhzMSiK8lpoKSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5l2VuSBQSSE8sSc1OTS1ILYLJMnFw
        SjUwLfPdGCu+77trep6aZdpPt48PTEsk9QxXyltY2j3zuGE042iRodWb8tndEeEpJppS1gr2
        j3xM3oSYKzu5SLdZMBc8TRe93ftBcnMyY7Vcy5roSRzhU4zlr8X7LmowY3r6o+SXfVqGnWyg
        9JqLIncNj2a8Vt/34rv5xZ7DU+1vtOt8M7uSt6X5Z4eu4tEov5mTYisfZG+5NfXxEaGfMgWT
        XGfGLvYNDHZdtfqiXkip/1J3ZX4OnsdZPbP+9d/7Oelt1O6zm/4fjcutu5q1ubvLUPZPDsuf
        2il7M+dkl7xv6RVuCLqR4ziNyS7Z1X/R5gMMnzz6eZZ8kHjW0xqS/LcqfdF+rj6hjhTH2oXV
        wUosxRmJhlrMRcWJADUWPhnhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0SZf5ukKSwc9pzBbTPvxktmht/8Zk
        0Xn6ApPF3657TBbb9h9ks9h7S9tiz96TLBb7Xu9ltpjQ9pXZ4saEp4wWE49vZrVYc/MpiwOP
        x+Ur3h47Z91l92hecIfFY9OqTjaPyTeWM3p83iTn0X6gmymAPYrLJiU1J7MstUjfLoErY9O1
        qcwF05wqpvy8wdjAuMehi5GTQ0LARGLv3vksXYxcHEICqxkltu54ywKSEBL4wCjxvUULIrGf
        UeL9z21gCTYBA4nfxzcyg9giAloSy/a9YwUpYhboYZXY9+0BUxcjB4ewgLHEi631EDUmEmdf
        H2WDsN0kjk15yghiswioSNzasxTM5gUq3zBvJivEspVMErOudIIlOAWsJaZvmwq2mFFATOL7
        qTVMIDazgLjErSfzmSBeEJBYsuc8M4QtKvHy8T9WCFtR4v73l+wg9zALaEqs36UP0Won8frA
        HjYIW1FiSvdDdogbBCVOznzCAtEqKXFwxQ2WCYwSs5Bsm4UwaRaSSbOQTJqFZNICRtZVjOKl
        xcW56RXFxnmp5XrFibnFpXnpesn5uZsYganh9L/DMTsY7936qHeIkYmD8RCjBAezkgivpaZC
        khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFej9iJ8UIC6YklqdmpqQWpRTBZJg5OqQampQ2Tnph8
        XzsjM+tz3tzVKVWLT2bbS6WbOK016vw6d4Ww7fngVavyd9heVm5uX5Q28c/huXH2Vq2/o3iE
        f1t/+32kKfV2yPz6ox2mi7WW/pv0KPyJef33DSzmW8wdlm+RMp7Gt0r8nphi/Ce9Fevyitcv
        26c216M5UWeGzzMRrr5FKVUVE9imV/XPmXP54dVji/k0g+0W2Bftk1jw2qFiwtvZak/uaX9t
        m+p5NXlbzxobFTv19Jk6GmfWHm0vuXhxfkNezr4kZmumk97yE6apHG24s3DRVobVj2pSwh+l
        yFZHZD9czzLPOTA3/vzfQ+1if57Z+Imv9J+leatQV2FKvG/Uqettv47PzOM4VzWlVImlOCPR
        UIu5qDgRAEHRxHF8AwAA
X-CMS-MailID: 20220303145603uscas1p263bf437711ca7c187835346c5fc01fb8
CMS-TYPE: 301P
X-CMS-RootMailID: 20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
        <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
        <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
        <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
        <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCBNYXIgMDMsIDIwMjIgYXQgMDk6NDk6MDZBTSArMDAwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6DQo+IE9uIDIwMjIvMDMvMDMgODoyOSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToNCj4g
PiBPbiAwMy4wMy4yMDIyIDA2OjMyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPiA+Pg0KPiA+
Pj4gT24gMyBNYXIgMjAyMiwgYXQgMDQuMjQsIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gPj4+DQo+ID4+PiDvu79UaGlua2luZyBwcm9hY3RpdmVseSBhYm91
dCBMU0ZNTSwgcmVnYXJkaW5nIGp1c3QgWm9uZSBzdG9yYWdlLi4NCj4gPj4+DQo+ID4+PiBJJ2Qg
bGlrZSB0byBwcm9wb3NlIGEgQm9GIGZvciBab25lZCBTdG9yYWdlLiBUaGUgcG9pbnQgb2YgaXQg
aXMNCj4gPj4+IHRvIGFkZHJlc3MgdGhlIGV4aXN0aW5nIHBvaW50IHBvaW50cyB3ZSBoYXZlIGFu
ZCB0YWtlIGFkdmFudGFnZSBvZg0KPiA+Pj4gaGF2aW5nIGZvbGtzIGluIHRoZSByb29tIHdlIGNh
biBsaWtlbHkgc2V0dGxlIG9uIHRoaW5ncyBmYXN0ZXIgd2hpY2gNCj4gPj4+IG90aGVyd2lzZSB3
b3VsZCB0YWtlIHllYXJzLg0KPiA+Pj4NCj4gPj4+IEknbGwgdGhyb3cgYXQgbGVhc3Qgb25lIHRv
cGljIG91dDoNCj4gPj4+DQo+ID4+PiAgKiBSYXcgYWNjZXNzIGZvciB6b25lIGFwcGVuZCBmb3Ig
bWljcm9iZW5jaG1hcmtzOg0KPiA+Pj4gICAgICAtIGFyZSB3ZSByZWFsbHkgaGFwcHkgd2l0aCB0
aGUgc3RhdHVzIHF1bz8NCj4gPj4+ICAgIC0gaWYgbm90IHdoYXQgb3V0bGV0cyBkbyB3ZSBoYXZl
Pw0KPiA+Pj4NCj4gPj4+IEkgdGhpbmsgdGhlIG52bWUgcGFzc3Rocm9naCBzdHVmZiBkZXNlcnZl
cyBpdCdzIG93biBzaGFyZWQNCj4gPj4+IGRpc2N1c3Npb24gdGhvdWdoIGFuZCBzaG91bGQgbm90
IG1ha2UgaXQgcGFydCBvZiB0aGUgQm9GLg0KPiA+Pj4NCj4gPj4+ICBMdWlzDQo+ID4+DQo+ID4+
IFRoYW5rcyBmb3IgcHJvcG9zaW5nIHRoaXMsIEx1aXMuDQo+ID4+DQo+ID4+IEnigJlkIGxpa2Ug
dG8gam9pbiB0aGlzIGRpc2N1c3Npb24gdG9vLg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IEph
dmllcg0KPiA+IA0KPiA+IExldCBtZSBleHBhbmQgYSBiaXQgb24gdGhpcy4gVGhlcmUgaXMgb25l
IHRvcGljIHRoYXQgSSB3b3VsZCBsaWtlIHRvDQo+ID4gY292ZXIgaW4gdGhpcyBzZXNzaW9uOg0K
PiA+IA0KPiA+ICAgIC0gUE8yIHpvbmUgc2l6ZXMNCj4gPiAgICAgICAgSW4gdGhlIHBhc3Qgd2Vl
a3Mgd2UgaGF2ZSBiZWVuIHRhbGtpbmcgdG8gRGFtaWVuIGFuZCBNYXRpYXMgYXJvdW5kDQo+ID4g
ICAgICAgIHRoZSBjb25zdHJhaW50IHRoYXQgd2UgY3VycmVudGx5IGhhdmUgZm9yIFBPMiB6b25l
IHNpemVzLiBXaGlsZQ0KPiA+ICAgICAgICB0aGlzIGhhcyBub3QgYmVlbiBhbiBpc3N1ZSBmb3Ig
U01SIEhERHMsIHRoZSBnYXAgdGhhdCBaTlMNCj4gPiAgICAgICAgaW50cm9kdWNlcyBiZXR3ZWVu
IHpvbmUgY2FwYWNpdHkgYW5kIHpvbmUgc2l6ZSBjYXVzZXMgaG9sZXMgaW4gdGhlDQo+ID4gICAg
ICAgIGFkZHJlc3Mgc3BhY2UuIFRoaXMgdW5tYXBwZWQgTEJBIHNwYWNlIGhhcyBiZWVuIHRoZSB0
b3BpYyBvZg0KPiA+ICAgICAgICBkaXNjdXNzaW9uIHdpdGggc2V2ZXJhbCBaTlMgYWRvcHRlcnMu
DQo+ID4gDQo+ID4gICAgICAgIE9uZSBvZiB0aGUgdGhpbmdzIHRvIG5vdGUgaGVyZSBpcyB0aGF0
IGV2ZW4gaWYgdGhlIHpvbmUgc2l6ZSBpcyBhDQo+ID4gICAgICAgIFBPMiwgdGhlIHpvbmUgY2Fw
YWNpdHkgaXMgdHlwaWNhbGx5IG5vdC4gVGhpcyBtZWFucyB0aGF0IGV2ZW4gd2hlbg0KPiA+ICAg
ICAgICB3ZSBjYW4gdXNlIHNoaWZ0cyB0byBtb3ZlIGFyb3VuZCB6b25lcywgdGhlIGFjdHVhbCBk
YXRhIHBsYWNlbWVudA0KPiA+ICAgICAgICBhbGdvcml0aG1zIG5lZWQgdG8gZGVhbCB3aXRoIGFy
Yml0cmFyeSBzaXplcy4gU28gYXQgdGhlIGVuZCBvZiB0aGUNCj4gPiAgICAgICAgZGF5IGFwcGxp
Y2F0aW9ucyB0aGF0IHVzZSBhIGNvbnRpZ3VvdXMgYWRkcmVzcyBzcGFjZSAtIGxpa2UgaW4gYQ0K
PiA+ICAgICAgICBjb252ZW50aW9uYWwgYmxvY2sgZGV2aWNlIC0sIHdpbGwgaGF2ZSB0byBkZWFs
IHdpdGggdGhpcy4NCj4gDQo+ICJ0aGUgYWN0dWFsIGRhdGEgcGxhY2VtZW50IGFsZ29yaXRobXMg
bmVlZCB0byBkZWFsIHdpdGggYXJiaXRyYXJ5IHNpemVzIg0KPiANCj4gPz8/DQo+IA0KPiBObyBp
dCBkb2VzIG5vdC4gV2l0aCB6b25lIGNhcCA8IHpvbmUgc2l6ZSwgdGhlIGFtb3VudCBvZiBzZWN0
b3JzIHRoYXQgY2FuIGJlDQo+IHVzZWQgd2l0aGluIGEgem9uZSBtYXkgYmUgc21hbGxlciB0aGFu
IHRoZSB6b25lIHNpemUsIGJ1dDoNCj4gMSkgV3JpdGVzIHN0aWxsIG11c3QgYmUgaXNzdWVkIGF0
IHRoZSBXUCBsb2NhdGlvbiBzbyBjaG9vc2luZyBhIHpvbmUgZm9yIHdyaXRpbmcNCj4gZGF0YSBo
YXMgdGhlIHNhbWUgY29uc3RyYWludCByZWdhcmRsZXNzIG9mIHRoZSB6b25lIGNhcGFjaXR5OiBE
byBJIGhhdmUgZW5vdWdoDQo+IHVzYWJsZSBzZWN0b3JzIGxlZnQgaW4gdGhlIHpvbmUgPw0KDQpB
cmUgeW91IHNheWluZyBob2xlcyBhcmUgaXJyZWxldmFudCBiZWNhdXNlIGFuIGFwcGxpY2F0aW9u
IGhhcyB0byBrbm93IHRoZSANCnN0YXR1cyBvZiBhIHpvbmUgYnkgcXVlcnlpbmcgdGhlIGRldmlj
ZSBmb3IgdGhlIHpvbmUgc3RhdHVzIGJlZm9yZSB1c2luZyBhIHpvbmUNCmFuZCBhdCB0aGF0IHBv
aW50IGl0IHNob3VsZCBrbm93IGEgc3RhcnQgTEJBPyBJIHNlZSB5b3VyIHBvaW50IGhlcmUgYnV0
IHdlIGhhdmUNCnRvIGFzc3VtZSB0aGluZ3MgdG8gYXJyaXZlIGF0IHRoaXMgY29uY2x1c2lvbi4N
Cg0KTGV0J3MgdGhpbmsgb2YgYW5vdGhlciBzY2VuYXJpbyB3aGVyZSB0aGUgZHJpdmUgaXMgbWFu
YWdlZCBieSBhIHVzZXIgc3BhY2UgDQphcHBsaWNhdGlvbiB0aGF0IGtub3dzIHRoZSBzdGF0dXMg
b2Ygem9uZXMgYW5kIHBpY2tzIGEgem9uZSBiZWNhdXNlIGl0IGtub3dzIA0KaXQgaXMgZnJlZS4g
VG8gY2FsY3VsYXRlIHRoZSBzdGFydCBvZmZzZXQgaW4gdGVybXMgb2YgTEJBcyB0aGUgYXBwbGlj
YXRpb24gaGFzIA0KdG8gdXNlIHRoZSBkaWZmZXJlbmNlIGluIHpvbmVfc2l6ZSBhbmQgem9uZV9j
YXAgdG8gY2FsY3VsYXRlIHRoZSB3cml0ZSBvZmZzZXQNCmluIHRlcm1zIG9mIExCQXMuIA0KDQpN
eSBhcmd1bWVudCBpcyB0aGF0IHRoZSB6b25lX3NpemUgaXMgYSBjb25zdHJ1Y3QgY29uY2VpdmVk
IHRvIG1ha2UgYSBaTlMgem9uZQ0KYSBwb3dlciBvZiAyIHRoYXQgY3JlYXRlcyBhIGhvbGUgaW4g
dGhlIExCQSBzcGFjZS4gQXBwbGljYXRpb25zIGRvbid0IHdhbnQNCnRvIGRlYWwgd2l0aCB0aGUg
cG93ZXIgb2YgMiBjb25zdHJhaW50IGFuZCBuZWl0aGVyIGRvIGRldmljZXMuIEl0IHNlZW1zIGxp
a2UNCnRoZSBleGlzdGluZyB6b25lZCBrZXJuZWwgaW5mcmFzdHJ1Y3R1cmUsIHdoaWNoIG1hZGUg
c2Vuc2UgZm9yIFNNUiwgcHVzaGVkIA0KdGhpcyBjb25zdHJhaW50IG9udG8gZGV2aWNlcyBhbmQg
b250byB1c2Vycy4gQXJndW1lbnRzIGNhbiBiZSBtYWRlIGZvciB3aGVyZSANCmNvbXBsZXhpdHkg
c2hvdWxkIGxpZSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhpcyBkZWNpc2lvbiBtYWRlIHRoaW5ncyBl
YXNpZXIgZm9yDQpzb21lb25lIHRvIHVzZSBhIFpOUyBTU0QgYXMgYSBibG9jayBkZXZpY2UuIA0K
DQo+IDIpIFJlYWRpbmcgYWZ0ZXIgdGhlIFdQIGlzIG5vdCB1c2VmdWwgKGlmIG5vdCBvdXRyaWdo
dCBzdHVwaWQpLCByZWdhcmRsZXNzIG9mDQo+IHdoZXJlIHRoZSBsYXN0IHVzYWJsZSBzZWN0b3Ig
aW4gdGhlIHpvbmUgaXMgKGF0IHpvbmUgc3RhcnQgKyB6b25lIHNpemUgb3IgYXQNCj4gem9uZSBz
dGFydCArIHpvbmUgY2FwKS4NCg0KT2YgY291cnNlIGJ1dCB0aGUgd2l0aCBwbzIgeW91IGZvcmNl
IHVzZWxlc3MgTEJBIHNwYWNlIGV2ZW4gaWYgeW91IGZpbGwgYSB6b25lLg0KDQoNCj4gDQo+IEFu
ZCB0YWxraW5nIGFib3V0ICJ1c2UgYSBjb250aWd1b3VzIGFkZHJlc3Mgc3BhY2UiIGlzIGluIG15
IG9waW5pb24gbm9uc2Vuc2UgaW4NCj4gdGhlIGNvbnRleHQgb2Ygem9uZWQgc3RvcmFnZSBzaW5j
ZSBieSBkZWZpbml0aW9uLCBldmVyeXRoaW5nIGhhcyB0byBiZSBtYW5hZ2VkDQo+IHVzaW5nIHpv
bmVzIGFzIHVuaXRzLiBUaGUgb25seSBzZW5zaWJsZSByYW5nZSBmb3IgYSAiY29udGlndW91cyBh
ZGRyZXNzIHNwYWNlIg0KPiBpcyAiem9uZSBzdGFydCArIG1pbih6b25lIGNhcCwgem9uZSBzaXpl
KSIuDQoNCkRlZmluaXRlbHkgZGlzYWdyZWUgd2l0aCB0aGlzIGdpdmVuIHByZXZpb3VzIGFyZ3Vt
ZW50cy4gVGhpcyBpcyBhIGNvbnN0cnVjdCANCmZvcmNlZCB1cG9uIHVzIGJlY2F1c2Ugb2Ygem9u
ZWQgc3RvcmFnZSBsZWdhY3kuDQoNCj4gDQo+ID4gICAgICAgIFNpbmNlIGNodW5rX3NlY3RvcnMg
aXMgbm8gbG9uZ2VyIHJlcXVpcmVkIHRvIGJlIGEgUE8yLCB3ZSBoYXZlDQo+ID4gICAgICAgIHN0
YXJ0ZWQgdGhlIHdvcmsgaW4gcmVtb3ZpbmcgdGhpcyBjb25zdHJhaW50LiBXZSBhcmUgd29ya2lu
ZyBpbiAyDQo+ID4gICAgICAgIHBoYXNlczoNCj4gPiANCj4gPiAgICAgICAgICAxLiBBZGQgYW4g
ZW11bGF0aW9uIGxheWVyIGluIE5WTWUgZHJpdmVyIHRvIHNpbXVsYXRlIFBPMiBkZXZpY2VzDQo+
ID4gCXdoZW4gdGhlIEhXIHByZXNlbnRzIGEgem9uZV9jYXBhY2l0eSA9IHpvbmVfc2l6ZS4gVGhp
cyBpcyBhDQo+ID4gCXByb2R1Y3Qgb2Ygb25lIG9mIERhbWllbidzIGVhcmx5IGNvbmNlcm5zIGFi
b3V0IHN1cHBvcnRpbmcNCj4gPiAJZXhpc3RpbmcgYXBwbGljYXRpb25zIGFuZCBGU3MgdGhhdCB3
b3JrIHVuZGVyIHRoZSBQTzINCj4gPiAJYXNzdW1wdGlvbi4gV2Ugd2lsbCBwb3N0IHRoZXNlIHBh
dGNoZXMgaW4gdGhlIG5leHQgZmV3IGRheXMuDQo+ID4gDQo+ID4gICAgICAgICAgMi4gUmVtb3Zl
IHRoZSBQTzIgY29uc3RyYWludCBmcm9tIHRoZSBibG9jayBsYXllciBhbmQgYWRkDQo+ID4gCXN1
cHBvcnQgZm9yIGFyYml0cmFyeSB6b25lIHN1cHBvcnQgaW4gYnRyZnMuIFRoaXMgd2lsbCBhbGxv
dyB0aGUNCj4gPiAJcmF3IGJsb2NrIGRldmljZSB0byBiZSBwcmVzZW50IGZvciBhcmJpdHJhcnkg
em9uZSBzaXplcyAoYW5kDQo+ID4gCWNhcGFjaXRpZXMpIGFuZCBidHJmcyB3aWxsIGJlIGFibGUg
dG8gdXNlIGl0IG5hdGl2ZWx5Lg0KPiANCj4gWm9uZSBzaXplcyBjYW5ub3QgYmUgYXJiaXRyYXJ5
IGluIGJ0cmZzIHNpbmNlIGJsb2NrIGdyb3VwcyBtdXN0IGJlIGEgbXVsdGlwbGUgb2YNCj4gNjRL
LiBTbyBjb25zdHJhaW50cyByZW1haW4gYW5kIHNob3VsZCBiZSBlbmZvcmNlZCwgYXQgbGVhc3Qg
YnkgYnRyZnMuDQoNCkkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGJhc2UgYSBsb3Qgb2YgZGVjaXNp
b25zIG9uIHRoZSB3b3JrIHRoYXQgaGFzIGdvbmUgaW50byANCmJ0cmZzLiBJIHRoaW5rIGl0IGlz
IHZlcnkgcHJvbWlzaW5nLCBidXQgSSBkb24ndCB0aGluayBpdCBpcyBzZXR0bGVkIHRoYXQgaXQg
DQppcyB0aGUgb25seSB3YXkgcGVvcGxlIHdpbGwgY29uc3VtZSBaTlMgU1NEcy4NCg0KPiANCj4g
PiANCj4gPiAJRm9yIGNvbXBsZXRlbmVzcywgRjJGUyB3b3JrcyBuYXRpdmVseSBpbiBQTzIgem9u
ZSBzaXplcywgc28gd2UNCj4gPiAJd2lsbCBub3QgZG8gd29yayBoZXJlIGZvciBub3csIGFzIHRo
ZSBjaGFuZ2VzIHdpbGwgbm90IGJyaW5nIGFueQ0KPiA+IAliZW5lZml0LiBGb3IgRjJGUywgdGhl
IGVtdWxhdGlvbiBsYXllciB3aWxsIGhlbHAgdXNlIGRldmljZXMNCj4gPiAJdGhhdCBkbyBub3Qg
aGF2ZSBQTzIgem9uZSBzaXplcy4NCj4gPiANCj4gPiAgICAgICBXZSBhcmUgd29ya2luZyB0b3dh
cmRzIGhhdmluZyBhdCBsZWFzdCBhIFJGQyBvZiAoMikgYmVmb3JlIExTRi9NTS4NCj4gPiAgICAg
ICBTaW5jZSB0aGlzIGlzIGEgdG9waWMgdGhhdCBpbnZvbHZlcyBzZXZlcmFsIHBhcnRpZXMgYWNy
b3NzIHRoZQ0KPiA+ICAgICAgIHN0YWNrLCBJIGJlbGlldmUgdGhhdCBhIEYyRiBjb252ZXJzYXRp
b24gd2lsbCBoZWxwIGxheWluZyB0aGUgcGF0aA0KPiA+ICAgICAgIGZvcndhcmQuDQo+ID4gDQo+
ID4gVGhhbmtzLA0KPiA+IEphdmllcg0KPiA+IA0KPiANCj4gDQo+IC0tIA0KPiBEYW1pZW4gTGUg
TW9hbA0KPiBXZXN0ZXJuIERpZ2l0YWwgUmVzZWFyY2g=
