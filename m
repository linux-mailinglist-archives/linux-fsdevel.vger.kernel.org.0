Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927086BEA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGQO4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 10:56:23 -0400
Received: from us-edge-1.acronis.com ([69.20.59.99]:45756 "EHLO
        us-edge-1.acronis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQO4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=acronis.com
        ; s=exim; h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:
        In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yW4SuzaBU8qUYaHFqprIkAtJHv9ihhc/wlf0+5ms/jw=; b=qtlSsX7MXWcRA9ipryfhMmDjXN
        St1z8oHCJc13lUShZ5Xh04n/kWzGEJ3E17X2YW3xEaY5ocKcUhQI7htAkyNO2ehC/EYRaOxjbIteX
        6J9pWtvxuML4OwFSNrK64HNpnNyJYriaNRZC/PI0QNtCj2eUZWxE5AhuRHLErc+wF5R0=;
Received: from [91.195.22.120] (helo=ru-ex-1.corp.acronis.com)
        by us-edge-1.acronis.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <Filipp.Mikoian@acronis.com>)
        id 1hnlLx-0008I3-7i; Wed, 17 Jul 2019 10:56:21 -0400
Received: from ru-ex-2.corp.acronis.com (10.250.32.21) by
 ru-ex-1.corp.acronis.com (10.250.32.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1591.10; Wed, 17 Jul 2019 17:56:18 +0300
Received: from ru-ex-2.corp.acronis.com ([fe80::3163:6934:fc33:4bd3]) by
 ru-ex-2.corp.acronis.com ([fe80::3163:6934:fc33:4bd3%4]) with mapi id
 15.01.1591.011; Wed, 17 Jul 2019 17:56:18 +0300
From:   Filipp Mikoian <Filipp.Mikoian@acronis.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
CC:     "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: io_uring question
Thread-Topic: io_uring question
Thread-Index: AQHVMlktc6wBW1EANEu5MaqUCERTlabNWhmAgAGgx4A=
Date:   Wed, 17 Jul 2019 14:56:17 +0000
Message-ID: <01104FE4-007E-471F-AD37-E32663CEB038@acronis.com>
References: <76524892f9c048ea88c7d87295ec85ae@acronis.com>
 <92e17024-55ca-069d-3aae-56bd0b2e96f6@kernel.dk>
In-Reply-To: <92e17024-55ca-069d-3aae-56bd0b2e96f6@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.246.144.16]
Content-Type: text/plain; charset="utf-8"
Content-ID: <36D7E8076B658B438CF7C3AA26CAA23F@acronis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MessageID-Signature: ae4595e5dac985501a879d8c46c1d44cadf4cac9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBDYW4geW91IHRyeSB0aGUgYXR0YWNoZWQgcGF0Y2ggYW5kIHNlZSBpZiBpdCBmaXhlcyBpdCBm
b3IgeW91Pw0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLCB0aGF0IHdvcmtlZCBsaWtlIGEgY2hhcm0g
Zm9yIGJvdGggT19ESVJFQ1QgYW5kIHBhZ2UNCmNhY2hlLiBCZWxvdyBpcyB0aGUgb3V0cHV0IGZv
ciBPX0RJUkVDVCByZWFkcyBzdWJtaXNzaW9uIG9uIHRoZSBzYW1lIG1hY2hpbmU6DQoNCnJvb3RA
bG9jYWxob3N0On4vaW9fdXJpbmcjIC4vaW9fdXJpbmdfcmVhZF9ibGtkZXYgL2Rldi9zZGE4DQpz
dWJtaXR0ZWRfYWxyZWFkeSA9ICAgMCwgc3VibWl0dGVkX25vdyA9ICAzMiwgc3VibWl0X3RpbWUg
PSAgICAgMjc3IHVzDQpzdWJtaXR0ZWRfYWxyZWFkeSA9ICAzMiwgc3VibWl0dGVkX25vdyA9ICAz
Miwgc3VibWl0X3RpbWUgPSAgICAgMTMxIHVzDQpzdWJtaXR0ZWRfYWxyZWFkeSA9ICA2NCwgc3Vi
bWl0dGVkX25vdyA9ICAzMiwgc3VibWl0X3RpbWUgPSAgICAgMjEzIHVzDQpzdWJtaXR0ZWRfYWxy
ZWFkeSA9ICA5Niwgc3VibWl0dGVkX25vdyA9ICAzMiwgc3VibWl0X3RpbWUgPSAgICAgMTcwIHVz
DQpzdWJtaXR0ZWRfYWxyZWFkeSA9IDEyOCwgc3VibWl0dGVkX25vdyA9ICAzMiwgc3VibWl0X3Rp
bWUgPSAgICAgMTYxIHVzDQpzdWJtaXR0ZWRfYWxyZWFkeSA9IDE2MCwgc3VibWl0dGVkX25vdyA9
ICAzMiwgc3VibWl0X3RpbWUgPSAgICAgMTY5IHVzDQpzdWJtaXR0ZWRfYWxyZWFkeSA9IDE5Miwg
c3VibWl0dGVkX25vdyA9ICAzMiwgc3VibWl0X3RpbWUgPSAgICAgMTg0IHVzDQoNCj4gTm90IHN1
cmUgaG93IGJlc3QgdG8gY29udmVyeSB0aGF0IGJpdCBvZiBpbmZvcm1hdGlvbi4gSWYgeW91J3Jl
IHVzaW5nDQo+IHRoZSBzcSB0aHJlYWQgZm9yIHN1Ym1pc3Npb24sIHRoZW4gd2UgY2Fubm90IHJl
bGlhYmx5IHRlbGwgdGhlDQo+IGFwcGxpY2F0aW9uIHdoZW4gYW4gc3FlIGhhcyBiZWVuIGNvbnN1
bWVkLiBUaGUgYXBwbGljYXRpb24gbXVzdCBsb29rIGZvcg0KPiBjb21wbGV0aW9ucyAoc3VjY2Vz
c2Z1bCBvciBlcnJvcnMpIGluIHRoZSBDUSByaW5nLg0KDQpJIGtub3cgdGhhdCBTUVBPTEwgZmVh
dHVyZSBzdXBwb3J0IGlzIG5vdCBmdWxseSBpbXBsZW1lbnRlZCBpbiBsaWJ1cmluZywNCnNvIGZv
ciBub3cgaXQgc2VlbXMgdGhhdCBpb191cmluZ19nZXRfc3FlKCkgY291bGQgcmV0dXJuIG5vdCBh
Y3R1YWxseQ0Kc3VibWl0dGVkIFNRRSwgZWRpdGluZyB3aGljaCBjb3VsZCBsZWFkIHRvIHJhY2Ug
YmV0d2VlbiBrZXJuZWwgcG9sbGluZw0KdGhyZWFkIGFuZCB1c2VyIHNwYWNlLiBJIGp1c3QgdGhp
bmsgaXQgaXMgd29ydGggbWVudGlvbmluZyB0aGlzIGZhY3QgaW4NCmRvY3VtZW50YXRpb24uDQoN
Cj4gWW91IGNvdWxkIHdhaXQgb24gY3EgcmluZyBjb21wbGV0aW9ucywgZWFjaCBzcWUgc2hvdWxk
IHRyaWdnZXIgb25lLg0KDQpVbmZvcnR1bmF0ZWx5IGZldyBpc3N1ZXMgc2VlbSB0byBhcmlzZSBp
ZiB0aGlzIGFwcHJvYWNoIGlzIHRha2VuIGluDQpJTy1pbnRlbnNpdmUgYXBwbGljYXRpb24uIEFz
IGEgZGlzY2xhaW1lciBJIHNob3VsZCBub3RlIHRoYXQgU1EgcmluZw0Kb3ZlcmZsb3cgaXMgYSBy
YXJlIGV2ZW50IGdpdmVuIGVub3VnaCBlbnRyaWVzLCBuZXZlcnRoZWxlc3MgYXBwbGljYXRpb25z
LA0KZXNwZWNpYWxseSB0aG9zZSB1c2luZyBTUVBPTEwsIHNob3VsZCBoYW5kbGUgdGhpcyBzaXR1
YXRpb24gZ3JhY2VmdWxseQ0KYW5kIGluIGEgcGVyZm9ybWFudCBtYW5uZXIuDQoNClNvIHdoYXQg
d2UgaGF2ZSBpcyBoaWdobHkgSU8taW50ZW5zaXZlIGFwcGxpY2F0aW9uIHRoYXQgc3VibWl0cyB2
ZXJ5DQpzbG93IElPcyoqKiAodGhhdCdzIHdoeSBpdCB1c2VzIGFzeW5jIElPIGluIHRoZSBmaXJz
dCBwbGFjZSkgYW5kDQpjYXJlcyBtdWNoIGFib3V0IHRoZSBwcm9ncmVzcyBvZiB0aGUgc3VibWl0
dGluZyB0aHJlYWRzKHRoZSBtb3N0IHByb2JhYmxlDQpyZWFzb24gdG8gdXNlIFNRUE9MTCBmZWF0
dXJlKS4gR2l2ZW4gc3VjaCBwcmVyZXF1aXNpdGVzLCB0aGUgZm9sbG93aW5nDQpzY2VuYXJpbyBp
cyBwcm9iYWJsZToNCg0KKioqIGJ5ICd2ZXJ5IHNsb3cnIEkgbWVhbiBJT3MsIGNvbXBsZXRpb24g
b2Ygd2hpY2ggdGFrZXMgc2lnbmlmaWNhbnRseQ0KICAgIG1vcmUgdGltZSB0aGFuIHN1Ym1pc3Np
b24NCg0KMS4gUHV0IEBzcV9lbnRyaWVzIHdpdGggdmVyeSBzbG93IElPcyBpbiBTUS4uLg0KICBQ
RU5ESU5HICAgICAgU1EgICAgIElORkxJR0hUICAgICAgIENRDQogICArLS0tKyAgICAgKy0tLSsg
ICAgICstLS0rICAgICArLS0tKy0tLSsNCj09PT09PT09PT09PT58IFggfCAgICAgfCAgIHwgICAg
IHwgICB8ICAgfA0KICAgKy0tLSsgICAgICstLS0rICAgICArLS0tKyAgICAgKy0tLSstLS0rDQog
ICAuLi53aGljaCB3aWxsIGJlIHN1Ym1pdHRlZCBieSBwb2xsaW5nIHRocmVhZA0KICBQRU5ESU5H
ICAgICAgU1EgICAgIElORkxJR0hUICAgICAgIENRDQogICArLS0tKyAgICAgKy0tLSsgICAgICst
LS0rICAgICArLS0tKy0tLSsNCiAgIHwgICB8ICAgICB8ICAgfD09PT0+fCBYIHwgICAgIHwgICB8
ICAgfA0KICAgKy0tLSsgICAgICstLS0rICAgICArLS0tKyAgICAgKy0tLSstLS0rDQoyLiBUaGVu
IHRyeSB0byBhZGQgKEBzcV9lbnRyaWVzICsgQHBlbmRpbmcpIGVudHJpZXMgdG8gU1EsIGJ1dCBv
bmx5DQogICBzdWNjZWVkIHdpdGggQHNxX2VudHJpZXMuDQogIFBFTkRJTkcgICAgICBTUSAgICAg
SU5GTElHSFQgICAgICAgQ1ENCiAgICstLS0rICAgICArLS0tKyAgICAgKy0tLSsgICAgICstLS0r
LS0tKw0KPT0+fCBYIHw9PT09PnwgWCB8ICAgICB8IFggfCAgICAgfCAgIHwgICB8DQogICArLS0t
KyAgICAgKy0tLSsgICAgICstLS0rICAgICArLS0tKy0tLSsNCjMuIFdhaXQgdmVyeSBsb25nIHRp
bWUgaW4gaW9fdXJpbmdfZW50ZXIoR0VURVZFTlRTKSB3YWl0aW5nIGZvciBDUSByaW5nDQogICBj
b21wbGV0aW9uLi4uDQogIFBFTkRJTkcgICAgICBTUSAgICAgSU5GTElHSFQgICAgICAgQ1ENCiAg
ICstLS0rICAgICArLS0tKyAgICAgKy0tLSsgICAgICstLS0rLS0tKw0KICAgfCBYIHwgICAgIHwg
WCB8ICAgICB8ICAgfD09PT0+fCBYIHwgICB8DQogICArLS0tKyAgICAgKy0tLSsgICAgICstLS0r
ICAgICArLS0tKy0tLSsNCiAgIC4uLmFuZCBzdGlsbCB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhh
dCBzbG90IGluIFNRIHJpbmcgYmVjYW1lDQogICBhdmFpbGFibGUuIFNob3VsZCB3ZSBjYWxsDQog
ICAgICAgaW9fdXJpbmdfZW50ZXIoR0VURVZFTlRTLCBtaW5fY29tcGxldGUgPSAxKTsNCiAgIGlu
IGEgbG9vcCwgY2hlY2tpbmcgKCpraGVhZCA9PSAqa3RhaWwpIGF0IGV2ZXJ5IGl0ZXJhdGlvbj8N
Cg0KQ29uY2x1ZGluZywgaXQgc2VlbXMgcmVhc29uYWJsZSB0byBpbnN0cnVjdCBhcHBsaWNhdGlv
bnMgdXNpbmcgU1FQT0xMIHRvDQpzdWJtaXQgU1FFcyB1bnRpbCB0aGUgcXVldWUgaXMgZnVsbCwg
YW5kIHRoZW4gY2FsbCBpb191cmluZ19lbnRlcigpLA0KcHJvYmFibHkgd2l0aCBzb21lIGZsYWcs
IHRvIHdhaXQgZm9yIGEgc2xvdCBpbiBzdWJtaXNzaW9uIHF1ZXVlLCBub3QgZm9yDQpjb21wbGV0
aW9ucywgc2luY2UNCjEpIFRpbWUgbmVlZGVkIHRvIGNvbXBsZXRlIElPIHRlbmRzIHRvIGJlIG11
Y2ggZ3JlYXRlciB0aGFuIHRpbWUgbmVlZGVkDQogICB0byBzdWJtaXQgaXQuDQoyKSBDUSByaW5n
IGNvbXBsZXRpb24gZG9lcyBub3QgaW1wbHkgdGhlIHNsb3QgYmVjYW1lIGF2YWlsYWJsZSBpbiBT
USAoc2VlDQogICBkaWFncmFtIGFib3ZlKS4NCjMpIEJ1c3kgd2FpdGluZyBvZiBzdWJtaXR0aW5n
IHRocmVhZCBpcyBwcm9iYWJseSBub3Qgd2hhdCBpcyBkZXNpcmVkIGJ5DQogICBTUVBPTEwgdXNl
cnMuDQoNClNpZGUgbm90ZTogZXZlbnRsb29wLWRyaXZlbiBhcHBsaWNhdGlvbnMgY291bGQgZmlu
ZCB0aGVtc2VsdmVzIGNvbWZvcnRlZA0KYnkgZXBvbGwoKS1pbmcgaW9yaW5nIGZkIHdpdGggRVBP
TExPVVQgdG8gd2FpdCBmb3IgdGhlIGF2YWlsYWJsZSBlbnRyeSBpbg0KU1EuIERvIEkgdW5kZXJz
dGFuZCBpdCBjb3JyZWN0bHkgdGhhdCBzcHVyaW91cyB3YWtldXBzIGFyZSBjdXJyZW50bHkNCnBv
c3NpYmxlIHNpbmNlIGlvX3VyaW5nX3BvbGwoKSBpcyBhd2FrZW5lZCBvbmx5IG9uIGlvX2NvbW1p
dF9jcXJpbmcoKSwNCndoaWNoLCBhcyBzaG93biBhYm92ZSwgZG9lc24ndCBndWFyYW50ZWUgdGhh
dCBFUE9MTE9VVCBtYXkgYmUgc2V0Pw0KDQpUaGFuayB5b3UgYWdhaW4hDQpfXw0KQmVzdCByZWdh
cmRzLA0KRmlsaXBwIE1pa29pYW4NCg0K
