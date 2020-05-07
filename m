Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344671C83DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgEGHxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 03:53:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgEGHxh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 03:53:37 -0400
Received: from lhreml737-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7AAF388BEEFFBA9EA804;
        Thu,  7 May 2020 08:53:35 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml737-chm.china.huawei.com (10.201.108.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 7 May 2020 08:53:35 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 7 May 2020 09:53:34 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Thu, 7 May 2020 09:53:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "John Johansen" <john.johansen@canonical.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Topic: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibYCWAgAAX0QCAAMB1IA==
Date:   Thu, 7 May 2020 07:53:34 +0000
Message-ID: <ab879f9e66874736a40e9c566cadc272@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
 <1588799408.4624.28.camel@linux.ibm.com>
In-Reply-To: <1588799408.4624.28.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.65.97]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgNiwgMjAyMCAxMTox
MCBQTQ0KPiBUbzogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsgZGF2
aWQuc2FmZm9yZEBnbWFpbC5jb207DQo+IHZpcm9AemVuaXYubGludXgub3JnLnVrOyBqbW9ycmlz
QG5hbWVpLm9yZzsgSm9obiBKb2hhbnNlbg0KPiA8am9obi5qb2hhbnNlbkBjYW5vbmljYWwuY29t
Pg0KPiBDYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWludGVncml0eUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBzZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaWx2aXUNCj4gVmxhc2NlYW51IDxTaWx2
aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDXVtQQVRDSCAxLzNd
IGV2bTogTW92ZSBob29rcyBvdXRzaWRlIExTTSBpbmZyYXN0cnVjdHVyZQ0KPiANCj4gT24gV2Vk
LCAyMDIwLTA1LTA2IGF0IDE1OjQ0IC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiA+IFNpbmNl
IGNvcHlpbmcgdGhlIEVWTSBITUFDIG9yIG9yaWdpbmFsIHNpZ25hdHVyZSBpc24ndCBhcHBsaWNh
YmxlLCBJDQo+ID4gd291bGQgcHJlZmVyIGV4cGxvcmluZyBhbiBFVk0gcG9ydGFibGUgYW5kIGlt
bXV0YWJsZSBzaWduYXR1cmUgb25seQ0KPiA+IHNvbHV0aW9uLg0KPiANCj4gVG8gcHJldmVudCBj
b3B5aW5nIHRoZSBFVk0geGF0dHIsIHdlIGFkZGVkICJzZWN1cml0eS5ldm0iIHRvDQo+IC9ldGMv
eGF0dHIuY29uZi4gwqBUbyBzdXBwb3J0IGNvcHlpbmcganVzdCB0aGUgRVZNIHBvcnRhYmxlIGFu
ZA0KPiBpbW11dGFibGUgc2lnbmF0dXJlcyB3aWxsIHJlcXVpcmUgYSBkaWZmZXJlbnQgc29sdXRp
b24uDQoNClRoaXMgcGF0Y2ggc2V0IHJlbW92ZXMgdGhlIG5lZWQgZm9yIGlnbm9yaW5nIHNlY3Vy
aXR5LmV2bS4gSXQgY2FuIGJlIGFsd2F5cw0KY29waWVkLCBldmVuIGlmIGl0IGlzIGFuIEhNQUMu
IEVWTSB3aWxsIHVwZGF0ZSBpdCBvbmx5IHdoZW4gdmVyaWZpY2F0aW9uIGluDQp0aGUgcHJlIGhv
b2sgaXMgc3VjY2Vzc2Z1bC4gQ29tYmluZWQgd2l0aCB0aGUgYWJpbGl0eSBvZiBwcm90ZWN0aW5n
IGEgc3Vic2V0DQpvZiBmaWxlcyB3aXRob3V0IGludHJvZHVjaW5nIGFuIEVWTSBwb2xpY3ksIHRo
ZXNlIGFkdmFudGFnZXMgc2VlbSB0bw0Kb3V0d2VpZ2ggdGhlIGVmZm9ydCBuZWNlc3NhcnkgdG8g
bWFrZSB0aGUgc3dpdGNoLg0KDQpSb2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3Nl
bGRvcmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlh
biwgU2hpIFlhbmxpDQo=
