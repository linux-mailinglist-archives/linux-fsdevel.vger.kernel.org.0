Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27352E0A3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfJVRNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 13:13:49 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:34624 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbfJVRNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:13:49 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 2C82781E18;
        Tue, 22 Oct 2019 20:13:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1571764425;
        bh=WBZrleQkgVo3x8bYOGbdnGwjOGIOJdJQHv+CY7ylyGA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=u77pJJYTNTHQFCSQj+wcQf6BxygccQVvF+oxgckVAUMAiEVSRdzAHHxQYOiDZEoV3
         kPburIpoqsaKIpWzCfzxTmQMlD3okZOSKwOVNVOe6t4b4yRNzzYK14v79hSRm2XfR+
         sa6PAiOzUrDpVKxvlVtpQlJGI88gjnBYYzpFEZRM=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 22 Oct 2019 20:13:44 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1591.008; Tue, 22 Oct 2019 20:13:44 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exFAT read-only driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] exFAT read-only driver GPL implementation by Paragon
 Software.
Thread-Index: AQHViPwP0nd+67F90kCW3ZTBWy3iuA==
Date:   Tue, 22 Oct 2019 17:13:44 +0000
Message-ID: <9763488C-9431-49FF-9465-1B965F159120@paragon-software.com>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <20191019233449.bgimi755vt32itnf@pali>
In-Reply-To: <20191019233449.bgimi755vt32itnf@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B23641893AC2445AD6FAC37F072C715@paragon-software.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGVsbG8hIA0KVGhhbmtzIGZvciB5b3VyIGZpbmRpbmdzLg0KDQo+IE9uIDIwIE9jdCAyMDE5LCBh
dCAwMjozNCwgUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+
IEhlbGxvISBJIGhhdmUgbm90IHJlYWQgZGVlcGx5IHdob2xlIGltcGxlbWVudGF0aW9uLCBqdXN0
IHNwb3R0ZWQNCj4gc3VzcGljaW91cyBvcHRpb25zLiBTZWUgYmVsb3cuDQo+IA0KPiBPbiBGcmlk
YXkgMTggT2N0b2JlciAyMDE5IDE1OjE4OjM5IEtvbnN0YW50aW4gS29tYXJvdiB3cm90ZToNCj4+
IGRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0K
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNWY4NzEzZmUx
YjBjDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQo+PiBA
QCAtMCwwICsxLDM4OCBAQA0KPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
ICovDQo+PiArLyoNCj4+ICsgKiAgbGludXgvZnMvZXhmYXQvc3VwZXIuYw0KPj4gKyAqDQo+PiAr
ICogQ29weXJpZ2h0IChjKSAyMDEwLTIwMTkgUGFyYWdvbiBTb2Z0d2FyZSBHbWJILCBBbGwgcmln
aHRzIHJlc2VydmVkLg0KPj4gKyAqDQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgPGxpbnV4
L2J1ZmZlcl9oZWFkLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2hhc2guaD4NCj4+ICsjaW5jbHVk
ZSA8bGludXgvbmxzLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3JhdGVsaW1pdC5oPg0KPj4gKw0K
Pj4gK3N0cnVjdCBleGZhdF9tb3VudF9vcHRpb25zIHsNCj4+ICsJa3VpZF90IGZzX3VpZDsNCj4+
ICsJa2dpZF90IGZzX2dpZDsNCj4+ICsJdTE2IGZzX2ZtYXNrOw0KPj4gKwl1MTYgZnNfZG1hc2s7
DQo+PiArCXUxNiBjb2RlcGFnZTsgLyogQ29kZXBhZ2UgZm9yIHNob3J0bmFtZSBjb252ZXJzaW9u
cyAqLw0KPiANCj4gQWNjb3JkaW5nIHRvIGV4RkFUIHNwZWNpZmljYXRpb24sIHNlY3Rpb24gNy43
LjMgRmlsZU5hbWUgRmllbGQgdGhlcmUgaXMNCj4gbm8gOC4zIHNob3J0bmFtZSBzdXBwb3J0IHdp
dGggRE9TL09FTSBjb2RlcGFnZS4NCj4gDQo+IGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2Vu
LXVzL3dpbmRvd3Mvd2luMzIvZmlsZWlvL2V4ZmF0LXNwZWNpZmljYXRpb24jNzczLWZpbGVuYW1l
LWZpZWxkDQo+IA0KPiBQbHVzIGl0IGxvb2tzIGxpa2UgdGhhdCB0aGlzIG1lbWJlciBjb2RlcGFn
ZSBpcyBvbmx5IHNldCBhbmQgbmV2ZXINCj4gYWNjZXNzZWQgaW4gd2hvbGUgZHJpdmVyLg0KPiAN
Cj4gU28gaXQgY2FuIGJlIGNsZWFuIGl0IHVwIGFuZCByZW1vdmVkPw0KWWVzLCB0aGlzIG9uZSBz
aG91bGQgYmUgcmVtb3ZlZCBhcyBub3QgdXNlZCBhY3R1YWxseSB0aHJvdWdoIHRoZSBjb2RlLiBP
bmUgdGhpbmcgdG8gZG8gYWJvdXQgdGhlIGltcGxlbWVudGF0aW9uLCBiZXNpZGVzIFJXIHN1cHBv
cnQgYW5kIGEgbGl0dGxlIGNsZWFuLXVwIG9mIHN1Y2ggcGxhY2VzIGxpa2UgdGhpcyBvbmUsIGlz
IG5scy9jb2RlcGFnZSBzdXBwb3J0LiBDdXJyZW50bHksIHV0Zi04IG9ubHkgaXMgc3VwcG9ydGVk
Lg0KDQo+IA0KPj4gKwkvKiBtaW51dGVzIGJpYXM9IFVUQyAtIGxvY2FsIHRpbWUuIEVhc3Rlcm4g
dGltZSB6b25lOiArMzAwLCAqLw0KPj4gKwkvKlBhcmlzLEJlcmxpbjogLTYwLCBNb3Njb3c6IC0x
ODAqLw0KPj4gKwlpbnQgYmlhczsNCj4+ICsJdTE2IGFsbG93X3V0aW1lOyAvKiBwZXJtaXNzaW9u
IGZvciBzZXR0aW5nIHRoZSBbYW1ddGltZSAqLw0KPj4gKwl1bnNpZ25lZCBxdWlldCA6IDEsIC8q
IHNldCA9IGZha2Ugc3VjY2Vzc2Z1bCBjaG1vZHMgYW5kIGNob3ducyAqLw0KPj4gKwkJc2hvd2V4
ZWMgOiAxLCAvKiBzZXQgPSBvbmx5IHNldCB4IGJpdCBmb3IgY29tL2V4ZS9iYXQgKi8NCj4+ICsJ
CXN5c19pbW11dGFibGUgOiAxLCAvKiBzZXQgPSBzeXN0ZW0gZmlsZXMgYXJlIGltbXV0YWJsZSAq
Lw0KPj4gKwkJdXRmOCA6IDEsIC8qIFVzZSBvZiBVVEYtOCBjaGFyYWN0ZXIgc2V0IChEZWZhdWx0
KSAqLw0KPj4gKwkJLyogY3JlYXRlIGVzY2FwZSBzZXF1ZW5jZXMgZm9yIHVuaGFuZGxlZCBVbmlj
b2RlICovDQo+PiArCQl1bmljb2RlX3hsYXRlIDogMSwgZmx1c2ggOiAxLCAvKiB3cml0ZSB0aGlu
Z3MgcXVpY2tseSAqLw0KPj4gKwkJdHpfc2V0IDogMSwgLyogRmlsZXN5c3RlbSB0aW1lc3RhbXBz
JyBvZmZzZXQgc2V0ICovDQo+PiArCQlkaXNjYXJkIDogMSAvKiBJc3N1ZSBkaXNjYXJkIHJlcXVl
c3RzIG9uIGRlbGV0aW9ucyAqLw0KPj4gKwkJOw0KPj4gK307DQo+IA0KPiAuLi4NCj4gDQo+PiBk
aWZmIC0tZ2l0IGEvZnMvZXhmYXQvc3VwZXIuYyBiL2ZzL2V4ZmF0L3N1cGVyLmMNCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA3MDVkYWIzYzNmYw0KPj4g
LS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZnMvZXhmYXQvc3VwZXIuYw0KPiAuLi4NCj4+ICtlbnVt
IHsNCj4+ICsJT3B0X3VpZCwgT3B0X2dpZCwgT3B0X3VtYXNrLCBPcHRfZG1hc2ssIE9wdF9mbWFz
aywgT3B0X2FsbG93X3V0aW1lLA0KPj4gKwlPcHRfY29kZXBhZ2UsIE9wdF9xdWlldCwgT3B0X3No
b3dleGVjLCBPcHRfZGVidWcsIE9wdF9pbW11dGFibGUsDQo+PiArCU9wdF91dGY4X25vLCBPcHRf
dXRmOF95ZXMsIE9wdF91bmlfeGxfbm8sIE9wdF91bmlfeGxfeWVzLCBPcHRfZmx1c2gsDQo+PiAr
CU9wdF90el91dGMsIE9wdF9kaXNjYXJkLCBPcHRfbmZzLCBPcHRfYmlhcywgT3B0X2VyciwNCj4+
ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBtYXRjaF90YWJsZV90IGZhdF90b2tlbnMgPSB7
DQo+PiArCXsgT3B0X3VpZCwgInVpZD0ldSIgfSwNCj4+ICsJeyBPcHRfZ2lkLCAiZ2lkPSV1IiB9
LA0KPj4gKwl7IE9wdF91bWFzaywgInVtYXNrPSVvIiB9LA0KPj4gKwl7IE9wdF9kbWFzaywgImRt
YXNrPSVvIiB9LA0KPj4gKwl7IE9wdF9mbWFzaywgImZtYXNrPSVvIiB9LA0KPj4gKwl7IE9wdF9h
bGxvd191dGltZSwgImFsbG93X3V0aW1lPSVvIiB9LA0KPj4gKwl7IE9wdF9jb2RlcGFnZSwgImNv
ZGVwYWdlPSV1IiB9LA0KPj4gKwl7IE9wdF9xdWlldCwgInF1aWV0IiB9LA0KPj4gKwl7IE9wdF9z
aG93ZXhlYywgInNob3dleGVjIiB9LA0KPj4gKwl7IE9wdF9kZWJ1ZywgImRlYnVnIiB9LA0KPj4g
Kwl7IE9wdF9pbW11dGFibGUsICJzeXNfaW1tdXRhYmxlIiB9LA0KPj4gKwl7IE9wdF9mbHVzaCwg
ImZsdXNoIiB9LA0KPj4gKwl7IE9wdF90el91dGMsICJ0ej1VVEMiIH0sDQo+PiArCXsgT3B0X2Jp
YXMsICJiaWFzPSVkIiB9LA0KPj4gKwl7IE9wdF9kaXNjYXJkLCAiZGlzY2FyZCIgfSwNCj4+ICsJ
eyBPcHRfdXRmOF9ubywgInV0Zjg9MCIgfSwgLyogMCBvciBubyBvciBmYWxzZSAqLw0KPj4gKwl7
IE9wdF91dGY4X25vLCAidXRmOD1ubyIgfSwNCj4+ICsJeyBPcHRfdXRmOF9ubywgInV0Zjg9ZmFs
c2UiIH0sDQo+PiArCXsgT3B0X3V0ZjhfeWVzLCAidXRmOD0xIiB9LCAvKiBlbXB0eSBvciAxIG9y
IHllcyBvciB0cnVlICovDQo+PiArCXsgT3B0X3V0ZjhfeWVzLCAidXRmOD15ZXMiIH0sDQo+PiAr
CXsgT3B0X3V0ZjhfeWVzLCAidXRmOD10cnVlIiB9LA0KPj4gKwl7IE9wdF91dGY4X3llcywgInV0
ZjgiIH0sDQo+IA0KPiBUaGVyZSBhcmUgbG90IG9mIHV0ZjggbW91bnQgb3B0aW9ucy4gQXJlIHRo
ZXkgcmVhbGx5IG5lZWRlZD8NCj4gDQo+IFdvdWxkIG5vdCBpdCBiZSBiZXR0ZXIgdG8gdXNlIGp1
c3Qgb25lICJpb2NoYXJzZXQiIG1vdW50IG9wdGlvbiBsaWtlDQo+IG90aGVyIFVuaWNvZGUgYmFz
ZWQgZmlsZXN5c3RlbSBoYXZlIGl0IChlLmcuIHZmYXQsIGpmcywgaXNvOTY2MCwgdWRmIG9yDQo+
IG50ZnMpPw0KDQpJdCBzZWVtcyByZWFzb25hYmxlIGFzIHdlbGwuICJpb2NoYXJzZXQiIG1heSBi
ZSBtb3JlIGhhbmR5IHdheSB0byBoYW5kbGUgc3VjaCBtb3VudCBvcHRpb25zLg0KDQo+IA0KPj4g
Kwl7IE9wdF91bmlfeGxfbm8sICJ1bmlfeGxhdGU9MCIgfSwgLyogMCBvciBubyBvciBmYWxzZSAq
Lw0KPj4gKwl7IE9wdF91bmlfeGxfbm8sICJ1bmlfeGxhdGU9bm8iIH0sDQo+PiArCXsgT3B0X3Vu
aV94bF9ubywgInVuaV94bGF0ZT1mYWxzZSIgfSwNCj4+ICsJeyBPcHRfdW5pX3hsX3llcywgInVu
aV94bGF0ZT0xIiB9LCAvKiBlbXB0eSBvciAxIG9yIHllcyBvciB0cnVlICovDQo+PiArCXsgT3B0
X3VuaV94bF95ZXMsICJ1bmlfeGxhdGU9eWVzIiB9LA0KPj4gKwl7IE9wdF91bmlfeGxfeWVzLCAi
dW5pX3hsYXRlPXRydWUiIH0sDQo+PiArCXsgT3B0X3VuaV94bF95ZXMsICJ1bmlfeGxhdGUiIH0s
DQo+PiArCXsgT3B0X2VyciwgTlVMTCB9DQo+PiArfTsNCj4gDQo+IC0tIA0KPiBQYWxpIFJvaMOh
cg0KPiBwYWxpLnJvaGFyQGdtYWlsLmNvbQ0KDQo=
