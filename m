Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D51288009
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJIBeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 21:34:09 -0400
Received: from smtp.h3c.com ([60.191.123.56]:59639 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJIBeJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:34:09 -0400
Received: from DAG2EX04-BASE.srv.huawei-3com.com ([10.8.0.67])
        by h3cspam01-ex.h3c.com with ESMTPS id 0991Xc8Y082505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 09:33:38 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX04-BASE.srv.huawei-3com.com (10.8.0.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Oct 2020 09:33:39 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Fri, 9 Oct 2020 09:33:39 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs: use correct parameter in notes of
 generic_file_llseek_size()
Thread-Topic: [PATCH] fs: use correct parameter in notes of
 generic_file_llseek_size()
Thread-Index: AQHWg1VbepwpzeymnU+ybaV+ROAJcqliuT9Q//+IhgCAKjJhBf//kt0AgAKqO+A=
Date:   Fri, 9 Oct 2020 01:33:38 +0000
Message-ID: <626670182a9249719f5c9301ed5c4958@h3c.com>
References: <20200905071525.12259-1-tian.xianting@h3c.com>
 <3808373d663146c882c22397a1d6587f@h3c.com>
 <07de1867-e61c-07fb-8809-91d5e573329b@infradead.org>
 <e028ff27412d4a80aa273320482a801d@h3c.com>
 <b2bd4f65-3054-3c08-807f-f1e800c122ed@infradead.org>
In-Reply-To: <b2bd4f65-3054-3c08-807f-f1e800c122ed@infradead.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0991Xc8Y082505
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U29ycnkgUmFuZHksDQpJIHVzZWQgbXkgY2VsbHBob25lIHRvIHNlbmQgdGhlIHByZXZpb3VzIG1h
aWwsIGl0IGlzIGh0bWwuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSYW5k
eSBEdW5sYXAgW21haWx0bzpyZHVubGFwQGluZnJhZGVhZC5vcmddIA0KU2VudDogVGh1cnNkYXks
IE9jdG9iZXIgMDgsIDIwMjAgMTI6NTAgQU0NClRvOiB0aWFueGlhbnRpbmcgKFJEKSA8dGlhbi54
aWFudGluZ0BoM2MuY29tPjsgdmlyb0B6ZW5pdi5saW51eC5vcmcudWsNCkNjOiBsaW51eC1mc2Rl
dmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSF0gZnM6IHVzZSBjb3JyZWN0IHBhcmFtZXRlciBpbiBub3RlcyBvZiBnZW5l
cmljX2ZpbGVfbGxzZWVrX3NpemUoKQ0KDQpPbiAxMC83LzIwIDg6MjAgQU0sIFRpYW54aWFudGlu
ZyB3cm90ZToNCj4gaGksDQo+IA0KPiB0aGFua3MgUmFuZHkNCj4gDQo+IEkgY2hlY2tlZCB0aGUg
bGF0ZXN0IGNvZGUsIHNlZW1zIHRoaXMgcGF0Y2ggbm90IGFwcGxpZWQgY3VycmVudGx5Lg0KDQpI
aS0tDQoNClBsZWFzZSBkb24ndCBzZW5kIGh0bWwgZW1haWwuDQpJJ20gcHJldHR5IHN1cmUgdGhh
dCB0aGUgbWFpbGluZyBsaXN0IGhhcyBkcm9wcGVkIChkaXNjYXJkZWQpIHlvdXIgZW1haWwgYmVj
YXVzZSBpdCB3YXMgaHRtbC4NCg0KUHJvYmFibHkgb25seSBBbCBhbmQgSSByZWNlaXZlZCB5b3Vy
IGVtYWlsLg0KDQpBbC0gV291bGQgeW91IHByZWZlciB0aGF0IGZzLyBkb2N1bWVudGF0aW9uIHBh
dGNoZXMgZ28gdG8gc29tZW9uZSBlbHNlIGZvciBtZXJnaW5nPyAgbWF5YmUgQW5kcmV3Pw0KDQpU
aGFua3MuDQoNClBTOiBJIGNhbid0IHRlbGwgaWYgSSBhbSB3cml0aW5nIGFuIGh0bWwgZW1haWwg
b3Igbm90Li4uIDooDQoNCg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiC3
orz+yMs6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiC3osvNyrG85Dog
RnJpZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjAgMTA6NTc6MjQgQU0NCj4gytW8/sjLOiB0aWFueGlh
bnRpbmcgKFJEKTsgdmlyb0B6ZW5pdi5saW51eC5vcmcudWsNCj4gs63LzTogbGludXgtZnNkZXZl
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g1vfM4jog
UmU6IFtQQVRDSF0gZnM6IHVzZSBjb3JyZWN0IHBhcmFtZXRlciBpbiBub3RlcyBvZiANCj4gZ2Vu
ZXJpY19maWxlX2xsc2Vla19zaXplKCkNCj4gDQo+IE9uIDkvMTAvMjAgNzowNiBQTSwgVGlhbnhp
YW50aW5nIHdyb3RlOg0KPj4gSGkgdmlybywNCj4+IENvdWxkIEkgZ2V0IHlvdXIgZmVlZGJhY2s/
DQo+PiBUaGlzIHBhdGNoIGZpeGVkIHRoZSBidWlsZCB3YXJuaW5nLCBJIHRoaW5rIGl0IGNhbiBi
ZSBhcHBsaWVkLCB0aGFua3MgDQo+PiA6KQ0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+PiBGcm9tOiB0aWFueGlhbnRpbmcgKFJEKQ0KPj4gU2VudDogU2F0dXJkYXksIFNlcHRl
bWJlciAwNSwgMjAyMCAzOjE1IFBNDQo+PiBUbzogdmlyb0B6ZW5pdi5saW51eC5vcmcudWsNCj4+
IENjOiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgDQo+PiB0aWFueGlhbnRpbmcgKFJEKSA8dGlhbi54aWFudGluZ0BoM2MuY29tPg0K
Pj4gU3ViamVjdDogW1BBVENIXSBmczogdXNlIGNvcnJlY3QgcGFyYW1ldGVyIGluIG5vdGVzIG9m
IA0KPj4gZ2VuZXJpY19maWxlX2xsc2Vla19zaXplKCkNCj4+DQo+PiBGaXggd2FybmluZyB3aGVu
IGNvbXBpbGluZyB3aXRoIFc9MToNCj4+IGZzL3JlYWRfd3JpdGUuYzo4ODogd2FybmluZzogRnVu
Y3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbWF4c2l6ZScgbm90IGRlc2NyaWJlZCBpbiAnZ2Vu
ZXJpY19maWxlX2xsc2Vla19zaXplJw0KPj4gZnMvcmVhZF93cml0ZS5jOjg4OiB3YXJuaW5nOiBF
eGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdzaXplJyBkZXNjcmlwdGlvbiBpbiAnZ2VuZXJpY19m
aWxlX2xsc2Vla19zaXplJw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHRp
YW4ueGlhbnRpbmdAaDNjLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+PiAtLS0NCj4+ICBmcy9yZWFk
X3dyaXRlLmMgfCAyICstDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL3JlYWRfd3JpdGUuYyBiL2ZzL3JlYWRf
d3JpdGUuYyBpbmRleCANCj4+IDVkYjU4YjhjNy4uMDU4NTYzZWUyIDEwMDY0NA0KPj4gLS0tIGEv
ZnMvcmVhZF93cml0ZS5jDQo+PiArKysgYi9mcy9yZWFkX3dyaXRlLmMNCj4+IEBAIC03MSw3ICs3
MSw3IEBAIEVYUE9SVF9TWU1CT0wodmZzX3NldHBvcyk7DQo+PiAgICogQGZpbGU6ICAgIGZpbGUg
c3RydWN0dXJlIHRvIHNlZWsgb24NCj4+ICAgKiBAb2Zmc2V0OiAgZmlsZSBvZmZzZXQgdG8gc2Vl
ayB0bw0KPj4gICAqIEB3aGVuY2U6ICB0eXBlIG9mIHNlZWsNCj4+IC0gKiBAc2l6ZTogICAgbWF4
IHNpemUgb2YgdGhpcyBmaWxlIGluIGZpbGUgc3lzdGVtDQo+PiArICogQG1heHNpemU6IG1heCBz
aXplIG9mIHRoaXMgZmlsZSBpbiBmaWxlIHN5c3RlbQ0KPj4gICAqIEBlb2Y6ICAgICBvZmZzZXQg
dXNlZCBmb3IgU0VFS19FTkQgcG9zaXRpb24NCj4+ICAgKg0KPj4gICAqIFRoaXMgaXMgYSB2YXJp
YW50IG9mIGdlbmVyaWNfZmlsZV9sbHNlZWsgdGhhdCBhbGxvd3MgcGFzc2luZyBpbiBhIA0KPj4g
Y3VzdG9tDQo+Pg0KPiANCj4gDQo+IC0tDQo+IH5SYW5keQ0KPiANCg0KLS0NCn5SYW5keQ0KDQo=
