Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1BC22167F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGOUpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 16:45:06 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37268 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgGOUpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:45:02 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7FE948066C;
        Thu, 16 Jul 2020 08:44:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1594845894;
        bh=Yyrrii0aC13/URhPuBNQwge6HS2GmJlH4tIWcCtwuik=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=xnJm4t/14f2aR0lTcnqmPhj4qT6tA4A+BQZbK++5niPKjXZobZpur9z0GGQW7+yKW
         8PNhx1k2mq8ku/NnrS3NmZbloNkbAUoSzikBPXo4iHKVUNddes5oCIfWBecW/iyodG
         InVjzTzcgGzFddsdggHWDwcBZSuwm/QYXpW0Zn+66gUVQirdXFGLallItVZQ5cFDOa
         Zfak+VFIF6UH5UXTtPsw1EH/RpPXU8ApoESprVMX3FF4FJyuS5ho2Gzlb8G5JB+I94
         Ccb1Ny2CUtnbjIjR+KSYQOHYck2Lg4I4McQ5SVqDCWiE6uJb9clFCGm1ZwPqQPyOR1
         EteGRa08RaMqQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f0f6ac50001>; Thu, 16 Jul 2020 08:44:53 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul 2020 08:44:54 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Thu, 16 Jul 2020 08:44:54 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] doc: filesystems: proc: Remove stray '-' preventing
 table output
Thread-Topic: [PATCH 1/2] doc: filesystems: proc: Remove stray '-' preventing
 table output
Thread-Index: AQHWWb4d+mzGhLnBJ0Sy58P6Uv8OEqkGTvYAgAIF+QA=
Date:   Wed, 15 Jul 2020 20:44:54 +0000
Message-ID: <e8df76a1-349f-7499-77a9-bac42e2c6e32@alliedtelesis.co.nz>
References: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
 <20200714075100.41db8cea@lwn.net>
In-Reply-To: <20200714075100.41db8cea@lwn.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43E8D424AD5D9A4193247B9BF585BA9D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQpPbiAxNS8wNy8yMCAxOjUxIGFtLCBKb25hdGhhbiBDb3JiZXQgd3JvdGU6DQo+IE9uIFR1ZSwg
MTQgSnVsIDIwMjAgMjE6MDY6NDMgKzEyMDANCj4gQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4NCj4+IFdoZW4gcHJvY2Vzc2luZyBwcm9j
LnJzdCBzcGhpbnggY29tcGxhaW5lZA0KPj4NCj4+ICAgIERvY3VtZW50YXRpb24vZmlsZXN5c3Rl
bXMvcHJvYy5yc3Q6NTQ4OiBXQVJOSU5HOiBNYWxmb3JtZWQgdGFibGUuDQo+PiAgICBUZXh0IGlu
IGNvbHVtbiBtYXJnaW4gaW4gdGFibGUgbGluZSAyOS4NCj4+DQo+PiBUaGlzIGNhdXNlZCB0aGUg
ZW50aXJlIHRhYmxlIHRvIGJlIGRyb3BwZWQuIFJlbW92aW5nIHRoZSBzdHJheSAnLScNCj4+IHJl
c29sdmVzIHRoZSBlcnJvciBhbmQgcHJvZHVjZXMgdGhlIGRlc2lyZWQgdGFibGUuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lz
LmNvLm56Pg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvcHJvYy5yc3Qg
fCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0
IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9wcm9jLnJzdA0KPj4gaW5kZXggOTk2ZjNjZmU3
MDMwLi41M2EwMjMwYTA4ZTIgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0
ZW1zL3Byb2MucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0
DQo+PiBAQCAtNTQ1LDcgKzU0NSw3IEBAIGVuY29kZWQgbWFubmVyLiBUaGUgY29kZXMgYXJlIHRo
ZSBmb2xsb3dpbmc6DQo+PiAgICAgICBoZyAgICBodWdlIHBhZ2UgYWR2aXNlIGZsYWcNCj4+ICAg
ICAgIG5oICAgIG5vIGh1Z2UgcGFnZSBhZHZpc2UgZmxhZw0KPj4gICAgICAgbWcgICAgbWVyZ2Fi
bGUgYWR2aXNlIGZsYWcNCj4+IC0gICAgYnQgIC0gYXJtNjQgQlRJIGd1YXJkZWQgcGFnZQ0KPj4g
KyAgICBidCAgICBhcm02NCBCVEkgZ3VhcmRlZCBwYWdlDQo+PiAgICAgICA9PSAgICA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gV2hpY2ggdHJlZSBhcmUgeW91IGxv
b2tpbmcgYXQ/ICBNYXVybyBmaXhlZCB0aGlzIGJhY2sgaW4gSnVuZS4uLg0KPg0KPiBUaGFua3Ms
DQoNClRpcCBvZiBMaW51cydzIHRyZWUuIEN1cnJlbnRseSBwb2ludHMgdG8gY29tbWl0IGU5OTE5
ZTExZTIxOSAoIk1lcmdlIA0KYnJhbmNoICdmb3ItbGludXMnIG9mIA0KZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2R0b3IvaW5wdXQiKS4gSSBjYW4gc2VlIA0K
TWF1cm8ncyBmaXggd2FpdGluZyBpbiBkb2NzLW5leHQgKHByb2JhYmx5IHNob3VsZCBoYXZlIGNo
ZWNrZWQgdGhlcmUgDQpmaXJzdCkuIEZlZWwgZnJlZSB0byBkcm9wIHRoaXMgcGF0Y2guDQoNCj4N
Cj4gam9u
