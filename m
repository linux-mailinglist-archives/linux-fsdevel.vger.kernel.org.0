Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB62024B60D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgHTKbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 06:31:39 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:33322 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731471AbgHTKUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:32 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A05DE434;
        Thu, 20 Aug 2020 13:20:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1597918826;
        bh=zUeZ9txBd8CUV16UFvP7cKQBctMZ9i7FqExpSVprv0U=;
        h=From:To:Subject:Date:References:In-Reply-To;
        b=SlxKJFc7RTxAJr3+1nq6HBKiPgCtt/0/RImqgQN6Le5bCBF0FPkXlxp1TG8n8z650
         HFpalwrq/efe9FT2/UBLsX8yHGLwhbtT9VVpw4imSF++7QLwaI9H92D4WJK1GnnWoD
         KgGvh1DFigsWF0QGM5kPgxhD8O8/3UPeUKstvC+w=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 20 Aug 2020 13:20:26 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 20 Aug 2020 13:20:26 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?utf-8?B?QXVyw6lsaWVuIEFwdGVs?= <aaptel@suse.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Index: AdZyNcmjSkpkGje7R9K6YobJrVDyZ///6wOA//ag0SA=
Date:   Thu, 20 Aug 2020 10:20:26 +0000
Message-ID: <7538540ab82e4b398a0203564a1f1b23@paragon-software.com>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
 <87mu2x48wa.fsf@suse.com>
In-Reply-To: <87mu2x48wa.fsf@suse.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQXVyw6lsaWVuIEFwdGVsIDxhYXB0ZWxAc3VzZS5jb20+DQpTZW50OiBGcmlkYXksIEF1
Z3VzdCAxNCwgMjAyMCA1OjA5IFBNDQo+IA0KPiBIaSBLb25zdGFudGluLA0KPiANCj4gVGhhdCdz
IGNvb2wgOikgQXMgTmlrb2xheSBzYWlkIGl0IG5lZWRzIGEgbGl0dGxlIGNoYW5nZSB0byB0aGUg
bWFrZWZpbGVzDQo+IHRvIGV2ZW4gYnVpbGQuDQo+IA0KPiBBcmUgeW91IGFsc28gZ29pbmcgdG8g
cHVibGlzaCB5b3VyIG93biBta2ZzLm50ZnMzIHRvb2w/IEkgZG9udCB0aGluayB0aGUNCj4gZXhp
c3Rpbmcgb25lIHdvdWxkIHN1cHBvcnQgNjRrIGNsdXN0ZXJzLg0KDQpIaSBBdXLDqWxpZW4uIFRo
YW5rcyBmb3IgeW91ciBmZWVkYmFjay4gV2UgcGxhbiB0byBwdWJsaXNoIG91ciBta2ZzLm50ZnMg
dXRpbGl0eSBhcyB0aGUgb3BlbiBzb3VyY2UgYXMgd2VsbCAoYW5kIHBvc3NpYmx5IGZzY2hrLm50
ZnMgLSBhZnRlciBta2ZzKS4gDQoNCj4gDQo+IEkgd291bGQgcmVjb21tZW5kIHRvIHJ1biBjaGVj
a3BhdGNoIChJIHNlZSBhbHJlYWR5IDg3IHdhcm5pbmdzLi4uIHNvbWUNCj4gb2YgaXQgaXMgbm9p
c2UpOg0KPiANCj4gICAkIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIDxwYXRjaD4NCj4gDQo+IEFu
ZCBzcGFyc2UgKEkgZG9udCBzZWUgbXVjaCk6DQo+IA0KPiAgICQgdG91Y2ggZnMvbnRmczMvKi5b
Y2hdICYmIG1ha2UgQz0xDQo+IA0KPiBZb3UgbmVlZCBhIHJlY2VudCBidWlsZCBvZiBzcGFyc2Ug
dG8gZG8gdGhhdCBsYXN0IG9uZS4gWW91IGNhbiBwYXNzIHlvdXINCj4gb3duIHNwYXJzZSBiaW4g
KG1ha2UgQ0hFQ0s9fi9wcm9nL3NwYXJzZS9zcGFyc2UgQz0xKQ0KPiANCj4gVGhpcyB3aWxsIGJl
IGEgZ29vZCBmaXJzdCBzdGVwLg0KDQpUaGUgc3BhcnNlIHV0aWxpdHkgaXMgcnVubmluZyBhZ2Fp
bnN0IHRoZSBjb2RlLCBhcyB3ZWxsIGFzIGNoZWNrcGF0Y2gucGwuIFNwcmFzZSBvdXRwdXQgaXMg
Y2xlYW4gbm93LiBDaGVja3BhdGNoJ3Mgc29tZWhvdyBpbXBvcnRhbnQgd2FybmluZ3Mgd2lsbCBi
ZSBmaXhlZCBpbiB2MiAoZXhjZXB0IG1heWJlIHR5cGVkZWZzKS4gDQoNCj4gDQo+IEhhdmUgeW91
IHRyaWVkIHRvIHJ1biB0aGUgeGZzdGVzdHMgc3VpdGUgYWdhaW5zdCBpdD8NCj4NCnhmc3Rlc3Rz
IGFyZSBiZWluZyBvbmUgb2Ygb3VyIHN0YW5kYXJkIHRlc3Qgc3VpdGVzIGFtb25nIG90aGVycy4g
Q3VycmVudGx5IHdlIGhhdmUgdGhlICdnZW5lcmljLzMzOScgYW5kICdnZW5lcmljLzAxMycgdGVz
dCBjYXNlcyBmYWlsaW5nLCB3b3JraW5nIG9uIGl0IG5vdy4gT3RoZXIgdGVzdHMgZWl0aGVyIHBh
c3Mgb3IgYmVpbmcgc2tpcHBlZCAoZHVlIHRvIG1pc3NpbmcgZmVhdHVyZXMgZS5nLiByZWZsaW5r
KS4gDQogDQo+IENoZWVycywNCj4gLS0NCj4gQXVyw6lsaWVuIEFwdGVsIC8gU1VTRSBMYWJzIFNh
bWJhIFRlYW0NCj4gR1BHOiAxODM5IENCNUYgOUY1QiBGQjlCIEFBOTcgIDhDOTkgMDNDOCBBNDlC
IDUyMUIgRDVEMw0KPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgREUNCj4gR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwg
TWFyeSBIaWdnaW5zLCBTcmkgUmFzaWFoIEhSQiAyNDcxNjUgKEFHIE3DvG5jaGVuKQ0K
