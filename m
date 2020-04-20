Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93C81B03EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTIKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 04:10:54 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:13467 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTIKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:10:54 -0400
IronPort-SDR: z3jJ3n8cIFVJJdKM1zKH5Hja7L9vAgIXLp2g/sEepXg2baC4xd5Jj2kfSqoLYjwjdtrbQ8Wiwk
 Wmja9Hnk7zlCimqLnQP6keralbo6+kl9R+IFNmFFE/0pybcFLAZCBZoPy/sE+LM2fWJSXZMe+8
 +YW9oAzsBO8uewM7Twx5t9NlR911XCxeCPJExGe5yn5GruWohY2A14MwfKPUDzJCNUOFiKsGee
 K24bdRgLaAm7aQTwBAJwjoC1g4mzrbGBjm43A1L3We2D/2X6BGd98fvhaDisScS3YK69PbWZgQ
 tnM=
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="48003471"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 20 Apr 2020 00:10:53 -0800
IronPort-SDR: j0c0SYjtH5xm1+rLbl7MBxJsFS7HD+VmqYjZa+nhY/t6UkUz6BYcU0RyQRtHlfmRWv0h//KbCV
 VrWFlJry+ZeEniLjyts830dxN6taqJ0tW3Ll22tAyFg+8wixnWYRTgjC+ZRTvi2OUd07gAE4Wa
 OnIK97LBe+EGO4LwABtrIRpkYSxqvKN/SgKRJT2+bP84xeex6fmhX9QenIhGhm35DqYcjFKQYw
 0r4p86j7WFjwf0flwW7eAi2iNapPW3Ru16tjIyXTTU+sdjIn6wBKBg+igiS/ttpah11AkZ5ny5
 TNw=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Tetsuhiro Kohada' <kohada.t2@gmail.com>,
        'Tetsuhiro Kohada' <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "motai.hirotaka@aj.mitsubishielectric.co.jp" 
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
Thread-Topic: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
Thread-Index: AQHWE8zo2F2bkeyZKkiqZc7BRS6Da6h8ioSAgASj0YCAABaLAIAAaZDA
Date:   Mon, 20 Apr 2020 08:10:47 +0000
Message-ID: <da017fb91fcd46e2842a1871b30a816a@SVR-IES-MBX-03.mgc.mentorg.com>
References: <CGME20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69@epcas1p1.samsung.com>
        <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
        <003601d61461$7140be60$53c23b20$@samsung.com>
        <b250254c-3b88-9457-652d-f96c4c15e454@gmail.com>
 <000001d616be$9f4513b0$ddcf3b10$@samsung.com>
In-Reply-To: <000001d616be$9f4513b0$ddcf3b10$@samsung.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pg0KPiBGcm9tOiBUZXRzdWhpcm8gS29oYWRhIDxLb2hhZGEuVGV0c3VoaXJvQGRjLm1pdHN1Ymlz
aGllbGVjdHJpYy5jby5qcD4NCj4gIT0NCj4gU2lnbmVkLW9mZi1ieTogVGV0c3VoaXJvIEtvaGFk
YQ0KPiA8S29oYWRhLlRldHN1aGlyb0BkYy5NaXRzdWJpc2hpRWxlY3RyaWMuY28uanA+DQo+DQpN
aXRzdWJpc2hpRWxlY3RyaWMgIT0gbWl0c3ViaXNoaWVsZWN0cmljDQoNCkNhcGl0YWwgbGV0dGVy
cyBtYXR0ZXI/Pz8/DQoNCi0tLS0tLS0tLS0tLS0tLS0tDQpNZW50b3IgR3JhcGhpY3MgKERldXRz
Y2hsYW5kKSBHbWJILCBBcm51bGZzdHJhw59lIDIwMSwgODA2MzQgTcO8bmNoZW4gLyBHZXJtYW55
DQpSZWdpc3RlcmdlcmljaHQgTcO8bmNoZW4gSFJCIDEwNjk1NSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IFRob21hcyBIZXVydW5nLCBBbGV4YW5kZXIgV2FsdGVyDQo=
