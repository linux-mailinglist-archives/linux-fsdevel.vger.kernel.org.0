Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8C221687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgGOUrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGOUrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:47:07 -0400
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jul 2020 13:47:06 PDT
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F2AC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 13:47:06 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D83E28066C;
        Thu, 16 Jul 2020 08:47:04 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1594846024;
        bh=xYjQmOzUOIm5kT8Zig5PiQTexa7vxIbVqh1eqFRlffc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=thUctRaxUB1YKZHrK+eoZzth6hBOlFS5sVaDMFcJMwUgHrXoRFp+CAL4AGs2P/Cj5
         pa8kVUs06T0g8xWRZyTOyF4tNI2R/PKWmQz/B9YiYvx0K2o7XkLiTRJdNXHc8SCx79
         ct3wHuKITeWkOEZic6cJoUlqraNiLJ212Gbqkbxim25P5djCuxKZwrDoPebTFhqztn
         o18cJmZkpiOgrReMB5aMwKkf91T3oO0zu4Qlm7Y5DBmNClRwHeD3yy8TIP4lCSHi16
         ZGS6gT3y/I/WZ2MMZJXKgZaj3pXcCHJRfAjsbON5jsXq7wXyj8uqVO5nCOdaULkXof
         BynWKh+pL1fng==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f0f6b480001>; Thu, 16 Jul 2020 08:47:04 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul 2020 08:47:04 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Thu, 16 Jul 2020 08:47:04 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc: filesystems: proc: Fix literal blocks
Thread-Topic: [PATCH 2/2] doc: filesystems: proc: Fix literal blocks
Thread-Index: AQHWWb4eYHrpPXxu80uMSkHErpHI+akIVYmA
Date:   Wed, 15 Jul 2020 20:47:03 +0000
Message-ID: <3d80a1ae-ba46-1840-a4a4-4046413d1c1c@alliedtelesis.co.nz>
References: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
 <20200714090644.13011-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200714090644.13011-2-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E76B2716FF9D464DACD6EDC91AA457F6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgSm9uLA0KDQpPbiAxNC8wNy8yMCA5OjA2IHBtLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBT
cGhpbnggY29tcGxhaW5zDQo+DQo+ICAgIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvcHJvYy5y
c3Q6MjE5NDogV0FSTklORzogSW5jb25zaXN0ZW50IGxpdGVyYWwgYmxvY2sgcXVvdGluZy4NCj4N
Cj4gVXBkYXRlIHRoZSBjb21tYW5kIGxpbmUgc25pcHBldHMgdG8gYmUgcHJvcGVybHkgZm9ybWVk
IGxpdGVyYWwgYmxvY2tzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJp
cy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPiAgIERvY3VtZW50YXRpb24v
ZmlsZXN5c3RlbXMvcHJvYy5yc3QgfCAzOCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0IGIvRG9j
dW1lbnRhdGlvbi9maWxlc3lzdGVtcy9wcm9jLnJzdA0KPiBpbmRleCA1M2EwMjMwYTA4ZTIuLjYw
MjdkYzk0NzU1ZiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9wcm9j
LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0DQo+IEBAIC0y
MTkwLDI1ICsyMTkwLDI3IEBAIG1vdW50cG9pbnRzIHdpdGhpbiB0aGUgc2FtZSBuYW1lc3BhY2Uu
DQo+ICAgDQo+ICAgOjoNCj4gICANCj4gLSMgZ3JlcCBecHJvYyAvcHJvYy9tb3VudHMNCj4gLXBy
b2MgL3Byb2MgcHJvYyBydyxyZWxhdGltZSxoaWRlcGlkPTIgMCAwDQo+ICsgIyBncmVwIF5wcm9j
IC9wcm9jL21vdW50cw0KPiArIHByb2MgL3Byb2MgcHJvYyBydyxyZWxhdGltZSxoaWRlcGlkPTIg
MCAwDQo+ICAgDQo+IC0jIHN0cmFjZSAtZSBtb3VudCBtb3VudCAtbyBoaWRlcGlkPTEgLXQgcHJv
YyBwcm9jIC90bXAvcHJvYw0KPiAtbW91bnQoInByb2MiLCAiL3RtcC9wcm9jIiwgInByb2MiLCAw
LCAiaGlkZXBpZD0xIikgPSAwDQo+IC0rKysgZXhpdGVkIHdpdGggMCArKysNCj4gKyAjIHN0cmFj
ZSAtZSBtb3VudCBtb3VudCAtbyBoaWRlcGlkPTEgLXQgcHJvYyBwcm9jIC90bXAvcHJvYw0KPiAr
IG1vdW50KCJwcm9jIiwgIi90bXAvcHJvYyIsICJwcm9jIiwgMCwgImhpZGVwaWQ9MSIpID0gMA0K
PiArICsrKyBleGl0ZWQgd2l0aCAwICsrKw0KPiAgIA0KPiAtIyBncmVwIF5wcm9jIC9wcm9jL21v
dW50cw0KPiAtcHJvYyAvcHJvYyBwcm9jIHJ3LHJlbGF0aW1lLGhpZGVwaWQ9MiAwIDANCj4gLXBy
b2MgL3RtcC9wcm9jIHByb2MgcncscmVsYXRpbWUsaGlkZXBpZD0yIDAgMA0KPiArICMgZ3JlcCBe
cHJvYyAvcHJvYy9tb3VudHMNCj4gKyBwcm9jIC9wcm9jIHByb2MgcncscmVsYXRpbWUsaGlkZXBp
ZD0yIDAgMA0KPiArIHByb2MgL3RtcC9wcm9jIHByb2MgcncscmVsYXRpbWUsaGlkZXBpZD0yIDAg
MA0KPiAgIA0KPiAgIGFuZCBvbmx5IGFmdGVyIHJlbW91bnRpbmcgcHJvY2ZzIG1vdW50IG9wdGlv
bnMgd2lsbCBjaGFuZ2UgYXQgYWxsDQo+ICAgbW91bnRwb2ludHMuDQo+ICAgDQo+IC0jIG1vdW50
IC1vIHJlbW91bnQsaGlkZXBpZD0xIC10IHByb2MgcHJvYyAvdG1wL3Byb2MNCj4gKzo6DQo+ICsN
Cj4gKyAjIG1vdW50IC1vIHJlbW91bnQsaGlkZXBpZD0xIC10IHByb2MgcHJvYyAvdG1wL3Byb2MN
Cj4gICANCj4gLSMgZ3JlcCBecHJvYyAvcHJvYy9tb3VudHMNCj4gLXByb2MgL3Byb2MgcHJvYyBy
dyxyZWxhdGltZSxoaWRlcGlkPTEgMCAwDQo+IC1wcm9jIC90bXAvcHJvYyBwcm9jIHJ3LHJlbGF0
aW1lLGhpZGVwaWQ9MSAwIDANCj4gKyAjIGdyZXAgXnByb2MgL3Byb2MvbW91bnRzDQo+ICsgcHJv
YyAvcHJvYyBwcm9jIHJ3LHJlbGF0aW1lLGhpZGVwaWQ9MSAwIDANCj4gKyBwcm9jIC90bXAvcHJv
YyBwcm9jIHJ3LHJlbGF0aW1lLGhpZGVwaWQ9MSAwIDANCj4gICANCj4gICBUaGlzIGJlaGF2aW9y
IGlzIGRpZmZlcmVudCBmcm9tIHRoZSBiZWhhdmlvciBvZiBvdGhlciBmaWxlc3lzdGVtcy4NCj4g
ICANCj4gQEAgLTIyMTcsOCArMjIxOSwxMCBAQCBjcmVhdGVzIGEgbmV3IHByb2NmcyBpbnN0YW5j
ZS4gTW91bnQgb3B0aW9ucyBhZmZlY3Qgb3duIHByb2NmcyBpbnN0YW5jZS4NCj4gICBJdCBtZWFu
cyB0aGF0IGl0IGJlY2FtZSBwb3NzaWJsZSB0byBoYXZlIHNldmVyYWwgcHJvY2ZzIGluc3RhbmNl
cw0KPiAgIGRpc3BsYXlpbmcgdGFza3Mgd2l0aCBkaWZmZXJlbnQgZmlsdGVyaW5nIG9wdGlvbnMg
aW4gb25lIHBpZCBuYW1lc3BhY2UuDQo+ICAgDQo+IC0jIG1vdW50IC1vIGhpZGVwaWQ9aW52aXNp
YmxlIC10IHByb2MgcHJvYyAvcHJvYw0KPiAtIyBtb3VudCAtbyBoaWRlcGlkPW5vYWNjZXNzIC10
IHByb2MgcHJvYyAvdG1wL3Byb2MNCj4gLSMgZ3JlcCBecHJvYyAvcHJvYy9tb3VudHMNCj4gLXBy
b2MgL3Byb2MgcHJvYyBydyxyZWxhdGltZSxoaWRlcGlkPWludmlzaWJsZSAwIDANCj4gLXByb2Mg
L3RtcC9wcm9jIHByb2MgcncscmVsYXRpbWUsaGlkZXBpZD1ub2FjY2VzcyAwIDANCj4gKzo6DQo+
ICsNCj4gKyAjIG1vdW50IC1vIGhpZGVwaWQ9aW52aXNpYmxlIC10IHByb2MgcHJvYyAvcHJvYw0K
PiArICMgbW91bnQgLW8gaGlkZXBpZD1ub2FjY2VzcyAtdCBwcm9jIHByb2MgL3RtcC9wcm9jDQo+
ICsgIyBncmVwIF5wcm9jIC9wcm9jL21vdW50cw0KPiArIHByb2MgL3Byb2MgcHJvYyBydyxyZWxh
dGltZSxoaWRlcGlkPWludmlzaWJsZSAwIDANCj4gKyBwcm9jIC90bXAvcHJvYyBwcm9jIHJ3LHJl
bGF0aW1lLGhpZGVwaWQ9bm9hY2Nlc3MgMCAwDQoNCkxvb2tzIGxpa2UgTWF1cm8gYWxzbyBmaXhl
ZCB0aGlzIHNvIHRoaXMgY2FuIGJlIGRyb3BwZWQgdG9vLg0K
