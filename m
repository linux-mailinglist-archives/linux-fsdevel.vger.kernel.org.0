Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8036E2B59CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKQGkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 01:40:33 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45262 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgKQGkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:40:33 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 233244006E;
        Tue, 17 Nov 2020 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605595232; bh=DjC3VM+e0vFZdkuSyPYlT8niQ45mjgGo6uM1KBWIRPs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Sv0DeyuFjNZgIFf7Dwr62Fxlw/5cC/f5gtxjbGx12nTsX6DLNKgTYWbkLKII6Gbj0
         0d11JJVfxRvTXebJKIhHCygJWkp1gsKeuPG7pflcXQTQwlGVbG660BMptd0Zyz4eEd
         5dhdc3VI/c4vMAaNa6cCU5BmSonrn4mfCtLRvPnfRQe3lJlKCTZsw4ih0oqIJtgCec
         1XFUunXvW+QveQWlCEMfhLi+WDKGxUcUHWBOkDJ0UNmn3syIyvgwlN/2JcBiHjaJwG
         XIVc3yF8F1PBMsSOKwubEytdimUPbTA5Eaue3xDdjnX70SAQGZjFKRqp9PT2uGDXtP
         mmwpijJTOaVFA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 50E6DA009C;
        Tue, 17 Nov 2020 06:40:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EBD8580216;
        Tue, 17 Nov 2020 06:40:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="YDQvpG0j";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGvJhM35HmrpQ1NaQNy6qZM8yKyn6qXYGYj64csyYryTFn7OwLSKnebRkrh2KN9pHVikKM79+zNefB8++D7auLd1YspIUZFghe98ippKNw7qal/ij16YqwankdKjRAg/L6S0Meg7RTMuAVvpmaVD+A7YJoR1mgoIqexg8uqt8sxtEFM5ZGnOSNmtUPi5uz1CQz9Tzz9IS7nhPn5dTmmOnk7GHO1kVMfZ4Btvk4SL82BBkPGZN1ULpXc/Ny7LSO6P76yLi3xJxxpopN/DzMa0+xbv0cQqf2EeN7mXcds5opm4hv2Y0VbYRmEBZDI5DVbcSmkBy4QsaaolPbdfKOSd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjC3VM+e0vFZdkuSyPYlT8niQ45mjgGo6uM1KBWIRPs=;
 b=iuqwF0PBzxZkDPyFiOPttrk8uIloL058PXfCD7zB0VI+FbvgHVqEexVD9vS+8gqkTf7SclbybgOfH2ZiqcMYeF5E15iAvc7r/ZEbJB0qepv8ia2kg6BSVzeSdefvLa6Bnro+c/qGRVy87MjxNi1sSTn4NbDO+Eig/Al3hJNFWDADh0I3AxTSZVTTGmURRR7rCgADSPPIwcumtcG09I0feZ8wMQV6AqEm3KiIboHlvfE0DJJbzWn9VVqaEzs/O1toC5L/ezsbVlso7IJtLhi8NjxEw9Z9VtNmKqKpzqCqIZAoTLs1Dt8xaNI7AfggbagmBgzJGMiPtpEiTZbs/9sI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjC3VM+e0vFZdkuSyPYlT8niQ45mjgGo6uM1KBWIRPs=;
 b=YDQvpG0j9s4117nPXgwImVAWUGaZyyzCeTMP0gTE0rHCCTU/A2ybfj4VEJrHjNPfpG02GZ0+6c52hpeBSIf/nGvGAlroKheUPoalvoMr6SgRkM/71n83EfVvNGkIGfyBBwoJcm0cz63AqKtYiO8DtjAZv65JaqeVBX3nxKddxCw=
Received: from BN8PR12MB3474.namprd12.prod.outlook.com (2603:10b6:408:46::14)
 by BN6PR12MB1570.namprd12.prod.outlook.com (2603:10b6:405:5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Tue, 17 Nov
 2020 06:40:17 +0000
Received: from BN8PR12MB3474.namprd12.prod.outlook.com
 ([fe80::cd57:13d:10e4:671a]) by BN8PR12MB3474.namprd12.prod.outlook.com
 ([fe80::cd57:13d:10e4:671a%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 06:40:16 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2 10/13] arc: use FLATMEM with freeing of unused memory
 map instead of DISCONTIGMEM
Thread-Topic: [PATCH v2 10/13] arc: use FLATMEM with freeing of unused memory
 map instead of DISCONTIGMEM
Thread-Index: AQHWsHFMd8nsSVmCb0aJAIj0V26/qqnL+B8A
Date:   Tue, 17 Nov 2020 06:40:16 +0000
Message-ID: <3a1ef201-611b-3eb0-1a8a-4fcb05634b85@synopsys.com>
References: <20201101170454.9567-1-rppt@kernel.org>
 <20201101170454.9567-11-rppt@kernel.org>
In-Reply-To: <20201101170454.9567-11-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87e12fa8-d7e0-4295-9a17-08d88ac3a53c
x-ms-traffictypediagnostic: BN6PR12MB1570:
x-microsoft-antispam-prvs: <BN6PR12MB1570434DDD777F21D5458847B6E20@BN6PR12MB1570.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1ewO5Xepeb5LpunZColuhPzzL33joH242We2YOPa1+ekbpmE8IM3w6+N/ksOkAXgwQ1w9n8YDty0GV/52XMqZm/lcTLa2LLI1K3Lcjjc4fld4uGkT3fxK2SEnaDFbRmjadGeYB9ZMrQi69Wt4JKrnvPROd0xzayNMmLLn7t1ijFIMMLqygWDwgs4aQt7lvjBbc1Ho3XraySS3O6raL364ZtE5mhaFTrsWUXSkARCvXZLyYyxVGO2LK5ceIhFCr+TGc9oEWvwldZ+MEXB9tqY5Nt0yM8K2hdeXZGpVxY9Dq8pwszekT5muUB2ncMKhikq7u3drVLLUH7+LWkf0xgI1RD8MPSAGBVFgx2enpgYz4VxHedjqMaoo+NQO9+M38R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(316002)(478600001)(36756003)(2616005)(5660300002)(76116006)(53546011)(66946007)(186003)(26005)(64756008)(66446008)(91956017)(66476007)(6506007)(4326008)(66556008)(86362001)(31686004)(2906002)(31696002)(7416002)(8676002)(71200400001)(54906003)(110136005)(83380400001)(6486002)(6512007)(8936002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JYagcnJnxSAGF8Xuh7EkD3zqE6Y4m7dX+11ZoqFimvtPwxUPlSC8oS419nFfMqCJLsGzov7D79Kq3s+Mn1/hzFHwQFsnC31bT4Ni4EtIr/2wjYCrWqm8/vxDnKupoiyB842Ob3zFUvLKitBAkXdxCMg6ej5G/dFImilROL2OEoKFnMEdhmQAN049+LXtL4IG7QgfBiHE+ENaSzGu2jgj19bbyGIc08u729WCIvgQ8ELkBCi/3oQVMz+/QyKGB2dhpsAXD5M1lYQ1tyX+eXSPBqfmQcLGllN7y9fmUTLBg2XmNgw91TFoLhtUHJQct9wYtMtGnPfLrol78jKBRJ5MV9LdkYd2IQDR84ahHsshmtMOrwv7+k5JathRC/WMVKa2AXdO+u01dX4inR0XNjofX8dB56PNAtzq6tPZ+XdjmIM3MFIlHBxlroTgmNjCB2mYyX+89fiB8F+9QbkOQylAF6blXu03IXCFeCZvQgua8VtBTWqHQw5Cw4txAMEp8HFWX0E3rXfC6600866GNg2pJRtSv/XPiTBnqNzKdGU1V4BAC6X7HgtoqsPirtrkIWFxmZHr+GqVjAtIpzL/BZNWQXY2Z4A7hA3LDYsv8uLlImgPChZOeeG+q9gbk054g8bXAoL/aiygzpsJjxpFvZNrWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA72F6642E098D4F9498E63F11094E1C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e12fa8-d7e0-4295-9a17-08d88ac3a53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 06:40:16.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDaDwzLIfGvCMFwPanGEbeV8vVP7S2uc97GZmiXpdoVWmkjpVXa5oo3tlqyGShnyjq5FyrxYisv8OJmGuNGTcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1570
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTWlrZSwNCg0KT24gMTEvMS8yMCA5OjA0IEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBG
cm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+DQo+IEN1cnJlbnRseSBB
UkMgdXNlcyBESVNDT05USUdNRU0gdG8gY29wZSB3aXRoIHNwYXJzZSBwaHlzaWNhbCBtZW1vcnkg
YWRkcmVzcw0KPiBzcGFjZSBvbiBzeXN0ZW1zIHdpdGggMiBtZW1vcnkgYmFua3MuIFdoaWxlIERJ
U0NPTlRJR01FTSBhdm9pZHMgd2FzdGluZw0KPiBtZW1vcnkgb24gdW5wb3B1bGF0ZWQgbWVtb3J5
IG1hcCwgaXQgYWRkcyBib3RoIG1lbW9yeSBhbmQgQ1BVIG92ZXJoZWFkDQo+IHJlbGF0aXZlbHkg
dG8gRkxBVE1FTS4gTW9yZW92ZXIsIERJU0NPTlRJTkdNRU0gaXMgZ2VuZXJhbGx5IGNvbnNpZGVy
ZWQNCj4gZGVwcmVjYXRlZC4NCj4NCj4gVGhlIG9idmlvdXMgcmVwbGFjZW1lbnQgZm9yIERJU0NP
TlRJR01FTSB3b3VsZCBiZSBTUEFSU0VNRU0sIGJ1dCBpdCBpcyBhbHNvDQo+IGxlc3MgZWZmaWNp
ZW50IHRoYW4gRkxBVE1FTSBpbiBwZm5fdG9fcGFnZSgpIGFuZCBwYWdlX3RvX3BmbigpIGNvbnZl
cnNpb25zLg0KPiBCZXNpZGVzIGl0IHJlcXVpcmVzIHR1bmluZyBvZiBTRUNUSU9OX1NJWkUgd2hp
Y2ggaXMgbm90IHRyaXZpYWwgZm9yDQo+IHBvc3NpYmxlIEFSQyBtZW1vcnkgY29uZmlndXJhdGlv
bi4NCj4NCj4gU2luY2UgdGhlIG1lbW9yeSBtYXAgZm9yIGJvdGggYmFua3MgaXMgYWx3YXlzIGFs
bG9jYXRlZCBmcm9tIHRoZSAibG93bWVtIg0KPiBiYW5rLCBpdCBpcyBwb3NzaWJsZSB0byB1c2Ug
RkxBVE1FTSBmb3IgdHdvLWJhbmsgY29uZmlndXJhdGlvbiBhbmQgc2ltcGx5DQo+IGZyZWUgdGhl
IHVudXNlZCBob2xlIGluIHRoZSBtZW1vcnkgbWFwLiBBbGwgaXMgcmVxdWlyZWQgZm9yIHRoYXQg
aXMgdG8NCj4gcHJvdmlkZSBBUkMtc3BlY2lmaWMgcGZuX3ZhbGlkKCkgdGhhdCB3aWxsIHRha2Ug
aW50byBhY2NvdW50IGFjdHVhbA0KPiBwaHlzaWNhbCBtZW1vcnkgY29uZmlndXJhdGlvbiBhbmQg
ZGVmaW5lIEhBVkVfQVJDSF9QRk5fVkFMSUQuDQo+DQo+IFRoZSByZXN1bHRpbmcga2VybmVsIGlt
YWdlIGNvbmZpZ3VyZWQgd2l0aCBkZWZjb25maWcgKyBISUdITUVNPXkgaXMNCj4gc21hbGxlcjoN
Cj4NCj4gJCBzaXplIGEvdm1saW51eCBiL3ZtbGludXgNCj4gICAgIHRleHQgICAgZGF0YSAgICAg
YnNzICAgICBkZWMgICAgIGhleCBmaWxlbmFtZQ0KPiA0NjczNTAzIDEyNDU0NTYgIDI3OTc1NiA2
MTk4NzE1ICA1ZTk1YmIgYS92bWxpbnV4DQo+IDQ2NTg3MDYgMTI0Njg2NCAgMjc5NzU2IDYxODUz
MjYgIDVlNjE2ZSBiL3ZtbGludXgNCj4NCj4gJCAuL3NjcmlwdHMvYmxvYXQtby1tZXRlciBhL3Zt
bGludXggYi92bWxpbnV4DQo+IGFkZC9yZW1vdmU6IDI4LzMwIGdyb3cvc2hyaW5rOiA0Mi8zOTkg
dXAvZG93bjogMTA5ODYvLTI5MDI1ICgtMTgwMzkpDQo+IC4uLg0KPiBUb3RhbDogQmVmb3JlPTQ3
MDkzMTUsIEFmdGVyPTQ2OTEyNzYsIGNoZyAtMC4zOCUNCj4NCj4gQm9vdGluZyBuU0lNIHdpdGgg
aGFwc19ucy5kdHMgcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIG1lbW9yeSB1c2FnZQ0KPiByZXBv
cnRzOg0KPg0KPiBhOg0KPiBNZW1vcnk6IDE1NTkxMDRLLzE1NzI4NjRLIGF2YWlsYWJsZSAoMzUz
MUsga2VybmVsIGNvZGUsIDU5NUsgcndkYXRhLCA3NTJLIHJvZGF0YSwgMTM2SyBpbml0LCAyNzVL
IGJzcywgMTM3NjBLIHJlc2VydmVkLCAwSyBjbWEtcmVzZXJ2ZWQsIDEwNDg1NzZLIGhpZ2htZW0p
DQo+DQo+IGI6DQo+IE1lbW9yeTogMTU1OTExMksvMTU3Mjg2NEsgYXZhaWxhYmxlICgzNTE5SyBr
ZXJuZWwgY29kZSwgNTk0SyByd2RhdGEsIDc1Mksgcm9kYXRhLCAxMzZLIGluaXQsIDI4MEsgYnNz
LCAxMzc1MksgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCwgMTA0ODU3NksgaGlnaG1lbSkNCj4N
Cj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KDQpT
b3JyeSB0aGlzIGZlbGwgdGhyb3VnaCB0aGUgY3JhY2tzLiBEbyB5b3UgaGF2ZSBhIGJyYW5jaCBJ
IGNhbiBjaGVja291dCANCmFuZCBkbyBhIHF1aWNrIHRlc3QuDQoNClRoeCwNCi1WaW5lZXQNCg0K
PiAtLS0NCj4gICBhcmNoL2FyYy9LY29uZmlnICAgICAgICAgICAgfCAgMyArKy0NCj4gICBhcmNo
L2FyYy9pbmNsdWRlL2FzbS9wYWdlLmggfCAyMCArKysrKysrKysrKysrKysrKy0tLQ0KPiAgIGFy
Y2gvYXJjL21tL2luaXQuYyAgICAgICAgICB8IDI5ICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL0tjb25maWcgYi9hcmNoL2FyYy9LY29uZmln
DQo+IGluZGV4IDBhODljYzlkZWY2NS4uYzg3NGY4YWIwMzQxIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FyYy9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJjL0tjb25maWcNCj4gQEAgLTY3LDYgKzY3LDcg
QEAgY29uZmlnIEdFTkVSSUNfQ1NVTQ0KPiAgIA0KPiAgIGNvbmZpZyBBUkNIX0RJU0NPTlRJR01F
TV9FTkFCTEUNCj4gICAJZGVmX2Jvb2wgbg0KPiArCWRlcGVuZHMgb24gQlJPS0VODQo+ICAgDQo+
ICAgY29uZmlnIEFSQ0hfRkxBVE1FTV9FTkFCTEUNCj4gICAJZGVmX2Jvb2wgeQ0KPiBAQCAtNTA2
LDcgKzUwNyw3IEBAIGNvbmZpZyBMSU5VWF9SQU1fQkFTRQ0KPiAgIA0KPiAgIGNvbmZpZyBISUdI
TUVNDQo+ICAgCWJvb2wgIkhpZ2ggTWVtb3J5IFN1cHBvcnQiDQo+IC0Jc2VsZWN0IEFSQ0hfRElT
Q09OVElHTUVNX0VOQUJMRQ0KPiArCXNlbGVjdCBIQVZFX0FSQ0hfUEZOX1ZBTElEDQo+ICAgCWhl
bHANCj4gICAJICBXaXRoIEFSQyAyRzoyRyBhZGRyZXNzIHNwbGl0LCBvbmx5IHVwcGVyIDJHIGlz
IGRpcmVjdGx5IGFkZHJlc3NhYmxlIGJ5DQo+ICAgCSAga2VybmVsLiBFbmFibGUgdGhpcyB0byBw
b3RlbnRpYWxseSBhbGxvdyBhY2Nlc3MgdG8gcmVzdCBvZiAyRyBhbmQgUEFFDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FyYy9pbmNsdWRlL2FzbS9wYWdlLmggYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9w
YWdlLmgNCj4gaW5kZXggYjBkZmVkMGYxMmJlLi4yM2U0MWU4OTBlZGEgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJjL2luY2x1ZGUvYXNtL3BhZ2UuaA0KPiArKysgYi9hcmNoL2FyYy9pbmNsdWRlL2Fz
bS9wYWdlLmgNCj4gQEAgLTgyLDExICs4MiwyNSBAQCB0eXBlZGVmIHB0ZV90ICogcGd0YWJsZV90
Ow0KPiAgICAqLw0KPiAgICNkZWZpbmUgdmlydF90b19wZm4oa2FkZHIpCShfX3BhKGthZGRyKSA+
PiBQQUdFX1NISUZUKQ0KPiAgIA0KPiAtI2RlZmluZSBBUkNIX1BGTl9PRkZTRVQJCXZpcnRfdG9f
cGZuKENPTkZJR19MSU5VWF9SQU1fQkFTRSkNCj4gKy8qDQo+ICsgKiBXaGVuIEhJR0hNRU0gaXMg
ZW5hYmxlZCB3ZSBoYXZlIGhvbGVzIGluIHRoZSBtZW1vcnkgbWFwIHNvIHdlIG5lZWQNCj4gKyAq
IHBmbl92YWxpZCgpIHRoYXQgdGFrZXMgaW50byBhY2NvdW50IHRoZSBhY3R1YWwgZXh0ZW50cyBv
ZiB0aGUgcGh5c2ljYWwNCj4gKyAqIG1lbW9yeQ0KPiArICovDQo+ICsjaWZkZWYgQ09ORklHX0hJ
R0hNRU0NCj4gKw0KPiArZXh0ZXJuIHVuc2lnbmVkIGxvbmcgYXJjaF9wZm5fb2Zmc2V0Ow0KPiAr
I2RlZmluZSBBUkNIX1BGTl9PRkZTRVQJCWFyY2hfcGZuX29mZnNldA0KPiArDQo+ICtleHRlcm4g
aW50IHBmbl92YWxpZCh1bnNpZ25lZCBsb25nIHBmbik7DQo+ICsjZGVmaW5lIHBmbl92YWxpZAkJ
cGZuX3ZhbGlkDQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX0ZMQVRNRU0NCj4gKyNlbHNlIC8qIENP
TkZJR19ISUdITUVNICovDQo+ICsNCj4gKyNkZWZpbmUgQVJDSF9QRk5fT0ZGU0VUCQl2aXJ0X3Rv
X3BmbihDT05GSUdfTElOVVhfUkFNX0JBU0UpDQo+ICAgI2RlZmluZSBwZm5fdmFsaWQocGZuKQkJ
KCgocGZuKSAtIEFSQ0hfUEZOX09GRlNFVCkgPCBtYXhfbWFwbnIpDQo+IC0jZW5kaWYNCj4gKw0K
PiArI2VuZGlmIC8qIENPTkZJR19ISUdITUVNICovDQo+ICAgDQo+ICAgLyoNCj4gICAgKiBfX3Bh
LCBfX3ZhLCB2aXJ0X3RvX3BhZ2UgKEFMRVJUOiBkZXByZWNhdGVkLCBkb24ndCB1c2UgdGhlbSkN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL21tL2luaXQuYyBiL2FyY2gvYXJjL21tL2luaXQuYw0K
PiBpbmRleCAzYTM1YjgyYTcxOGUuLmNlMDdlNjk3OTE2YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cmMvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvYXJjL21tL2luaXQuYw0KPiBAQCAtMjgsNiArMjgs
OCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBsb3dfbWVtX3N6Ow0KPiAgIHN0YXRpYyB1bnNpZ25l
ZCBsb25nIG1pbl9oaWdoX3BmbiwgbWF4X2hpZ2hfcGZuOw0KPiAgIHN0YXRpYyBwaHlzX2FkZHJf
dCBoaWdoX21lbV9zdGFydDsNCj4gICBzdGF0aWMgcGh5c19hZGRyX3QgaGlnaF9tZW1fc3o7DQo+
ICt1bnNpZ25lZCBsb25nIGFyY2hfcGZuX29mZnNldDsNCj4gK0VYUE9SVF9TWU1CT0woYXJjaF9w
Zm5fb2Zmc2V0KTsNCj4gICAjZW5kaWYNCj4gICANCj4gICAjaWZkZWYgQ09ORklHX0RJU0NPTlRJ
R01FTQ0KPiBAQCAtOTgsMTYgKzEwMCwxMSBAQCB2b2lkIF9faW5pdCBzZXR1cF9hcmNoX21lbW9y
eSh2b2lkKQ0KPiAgIAlpbml0X21tLmJyayA9ICh1bnNpZ25lZCBsb25nKV9lbmQ7DQo+ICAgDQo+
ICAgCS8qIGZpcnN0IHBhZ2Ugb2Ygc3lzdGVtIC0ga2VybmVsIC52ZWN0b3Igc3RhcnRzIGhlcmUg
Ki8NCj4gLQltaW5fbG93X3BmbiA9IEFSQ0hfUEZOX09GRlNFVDsNCj4gKwltaW5fbG93X3BmbiA9
IHZpcnRfdG9fcGZuKENPTkZJR19MSU5VWF9SQU1fQkFTRSk7DQo+ICAgDQo+ICAgCS8qIExhc3Qg
dXNhYmxlIHBhZ2Ugb2YgbG93IG1lbSAqLw0KPiAgIAltYXhfbG93X3BmbiA9IG1heF9wZm4gPSBQ
Rk5fRE9XTihsb3dfbWVtX3N0YXJ0ICsgbG93X21lbV9zeik7DQo+ICAgDQo+IC0jaWZkZWYgQ09O
RklHX0ZMQVRNRU0NCj4gLQkvKiBwZm5fdmFsaWQoKSB1c2VzIHRoaXMgKi8NCj4gLQltYXhfbWFw
bnIgPSBtYXhfbG93X3BmbiAtIG1pbl9sb3dfcGZuOw0KPiAtI2VuZGlmDQo+IC0NCj4gICAJLyot
LS0tLS0tLS0tLS0tIGJvb3RtZW0gYWxsb2NhdG9yIHNldHVwIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKi8NCj4gICANCj4gICAJLyoNCj4gQEAgLTE1Myw3ICsxNTAsOSBAQCB2b2lkIF9faW5pdCBz
ZXR1cF9hcmNoX21lbW9yeSh2b2lkKQ0KPiAgIAkgKiBESVNDT05USUdNRU0gaW4gdHVybnMgcmVx
dWlyZXMgbXVsdGlwbGUgbm9kZXMuIG5vZGUgMCBhYm92ZSBpcw0KPiAgIAkgKiBwb3B1bGF0ZWQg
d2l0aCBub3JtYWwgbWVtb3J5IHpvbmUgd2hpbGUgbm9kZSAxIG9ubHkgaGFzIGhpZ2htZW0NCj4g
ICAJICovDQo+ICsjaWZkZWYgQ09ORklHX0RJU0NPTlRJR01FTQ0KPiAgIAlub2RlX3NldF9vbmxp
bmUoMSk7DQo+ICsjZW5kaWYNCj4gICANCj4gICAJbWluX2hpZ2hfcGZuID0gUEZOX0RPV04oaGln
aF9tZW1fc3RhcnQpOw0KPiAgIAltYXhfaGlnaF9wZm4gPSBQRk5fRE9XTihoaWdoX21lbV9zdGFy
dCArIGhpZ2hfbWVtX3N6KTsNCj4gQEAgLTE2MSw4ICsxNjAsMTUgQEAgdm9pZCBfX2luaXQgc2V0
dXBfYXJjaF9tZW1vcnkodm9pZCkNCj4gICAJbWF4X3pvbmVfcGZuW1pPTkVfSElHSE1FTV0gPSBt
aW5fbG93X3BmbjsNCj4gICANCj4gICAJaGlnaF9tZW1vcnkgPSAodm9pZCAqKShtaW5faGlnaF9w
Zm4gPDwgUEFHRV9TSElGVCk7DQo+ICsNCj4gKwlhcmNoX3Bmbl9vZmZzZXQgPSBtaW4obWluX2xv
d19wZm4sIG1pbl9oaWdoX3Bmbik7DQo+ICAgCWttYXBfaW5pdCgpOw0KPiAtI2VuZGlmDQo+ICsN
Cj4gKyNlbHNlIC8qIENPTkZJR19ISUdITUVNICovDQo+ICsJLyogcGZuX3ZhbGlkKCkgdXNlcyB0
aGlzIHdoZW4gRkxBVE1FTT15IGFuZCBISUdITUVNPW4gKi8NCj4gKwltYXhfbWFwbnIgPSBtYXhf
bG93X3BmbiAtIG1pbl9sb3dfcGZuOw0KPiArDQo+ICsjZW5kaWYgLyogQ09ORklHX0hJR0hNRU0g
Ki8NCj4gICANCj4gICAJZnJlZV9hcmVhX2luaXQobWF4X3pvbmVfcGZuKTsNCj4gICB9DQo+IEBA
IC0xOTAsMyArMTk2LDEyIEBAIHZvaWQgX19pbml0IG1lbV9pbml0KHZvaWQpDQo+ICAgCWhpZ2ht
ZW1faW5pdCgpOw0KPiAgIAltZW1faW5pdF9wcmludF9pbmZvKE5VTEwpOw0KPiAgIH0NCj4gKw0K
PiArI2lmZGVmIENPTkZJR19ISUdITUVNDQo+ICtpbnQgcGZuX3ZhbGlkKHVuc2lnbmVkIGxvbmcg
cGZuKQ0KPiArew0KPiArCXJldHVybiAocGZuID49IG1pbl9oaWdoX3BmbiAmJiBwZm4gPD0gbWF4
X2hpZ2hfcGZuKSB8fA0KPiArCQkocGZuID49IG1pbl9sb3dfcGZuICYmIHBmbiA8PSBtYXhfbG93
X3Bmbik7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKHBmbl92YWxpZCk7DQo+ICsjZW5kaWYNCg0K
