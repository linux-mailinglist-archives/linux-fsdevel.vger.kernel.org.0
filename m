Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33356F1361
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjD1Ikk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbjD1Ikj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:40:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686E3AAC
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 01:40:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-fJcAo6zoM7-VoaW85-dBPw-1; Fri, 28 Apr 2023 09:40:32 +0100
X-MC-Unique: fJcAo6zoM7-VoaW85-dBPw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Apr
 2023 09:40:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Apr 2023 09:40:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] pidfd updates
Thread-Topic: [GIT PULL] pidfd updates
Thread-Index: AQHZd5MX9MAWlQde30y10AgREU+GGK9AaFPw
Date:   Fri, 28 Apr 2023 08:40:31 +0000
Message-ID: <eb05bc4e50464579a60b80ddfd596a6a@AcuMS.aculab.com>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com>
In-Reply-To: <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjUgQXByaWwgMjAyMyAxNzoyOQ0KPiANCj4g
T24gVHVlLCBBcHIgMjUsIDIwMjMgYXQgNTozNOKAr0FNIENocmlzdGlhbiBCcmF1bmVyIDxicmF1
bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSGVsbCwgeW91IGNvdWxkIGV2ZW4gZXh0
ZW5kIHRoYXQgcHJvcG9zYWwgYmVsb3cgdG8gd3JhcCB0aGUNCj4gPiBwdXRfdXNlcigpLi4uDQo+
ID4NCj4gPiBzdHJ1Y3QgZmRfZmlsZSB7DQo+ID4gICAgICAgICBzdHJ1Y3QgZmlsZSAqZmlsZTsN
Cj4gPiAgICAgICAgIGludCBmZDsNCj4gPiAgICAgICAgIGludCBfX3VzZXIgKmZkX3VzZXI7DQo+
ID4gfTsNCj4gDQo+IFNvIEkgZG9uJ3QgbGlrZSB0aGlzIGV4dGVuZGVkIHZlcnNpb24sIGJ1dCB5
b3VyIHByb3Bvc2FsIHBhdGNoIGJlbG93DQo+IGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBXaHk/
IFNpbXBseSBiZWNhdXNlIHRoZSAidHdvLXdvcmQgc3RydWN0IiBpcyBhY3R1YWxseSBhIGdvb2Qg
d2F5IHRvDQo+IHJldHVybiB0d28gdmFsdWVzLiBCdXQgYSB0aHJlZS13b3JkIG9uZSB3b3VsZCBi
ZSBwYXNzZWQgb24gdGhlIHN0YWNrLg0KPiANCj4gQm90aCBnY2MgYW5kIGNsYW5nIHJldHVybiBz
bWFsbCBzdHJ1Y3RzICh3aGVyZSAic21hbGwiIGlzIGxpdGVyYWxseQ0KPiBqdXN0IHR3byB3b3Jk
cykgaW4gcmVnaXN0ZXJzLCBhbmQgaXQncyBwYXJ0IG9mIG1vc3QgKGFsbD8pIEFCSXMgYW5kDQo+
IHdlJ3ZlIHJlbGllZCBvbiB0aGF0IGJlZm9yZS4NCg0KSXQgaXMgZGVmaW5pdGVseSBhcmNoaXRl
Y3R1cmUgZGVwZW5kYW50Lg0KeDg2LTY0IGFuZCBhcm0tNjQgd2lsbCByZXR1cm4gdHdvIDY0Yml0
IHZhbHVlcyBpbiByZWdpc3RlcnMuDQp4ODYtMzIgYW5kIGFybS0zMiByZXR1cm4gdHdvIDMyYml0
IHZhbHVlcyBvbiBzdGFjay4NCg0KUHJldHR5IG11Y2ggZXZlcnl0aGluZyBwYXNzZXMgc2hvcnQg
c3RydWN0dXJlcyBkaXJlY3RseSBieSB2YWx1ZS4NCihJJ20gbm90IHN1cmUgYWJvdXQgc3BhcmMt
MzIgdGhvdWdoLCBJJ20gc3VyZSBpdCBwYXNzZWQgYWxsDQpzdHJ1Y3R1cmVzIGJ5IHJlZmVyZW5j
ZSBiYWNrIGluIHRoZSAxOTgwcykNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

