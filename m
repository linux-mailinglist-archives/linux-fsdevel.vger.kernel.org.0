Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EACD2EA4A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 06:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbhAEFIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 00:08:14 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37850 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbhAEFIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:08:13 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 09C41C0091;
        Tue,  5 Jan 2021 05:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1609823233; bh=Ak7v+pljvwgmkCRkPQgXYQSoEcv0eiBbTuu6sJqVb1A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mZ9sR8+ijE7/ZKz8n+iVlOP2ve6tE10LGnfXTVOjvYESrv4arHhve87lyGnN61uaf
         NLWQxgK5ySJEpKd3CoYfPvgipcy0Li0cYNuYGzj/KsWCMu23J0oXB8re9lwkCBeTen
         o0Bc7nxy9GXRY8R1U9sskpwWhEzD8sVaRaeQyL8M9mMDSRlvc0NcpcKCL9jLnhxK6S
         LjfRYgut8Jx5kCugYADwriS6PLtTYer0eBVOqKeB2nNwVLsVHSzNxQmVbUIY8S9FuB
         2wPpA3WIREWMgjqnv4odqTxyYMt3USnezHlNr2Om7ZH1kHa6I0Dj8dKupm5mwMc6mv
         2ozF8wBbyqLdw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2BA90A0071;
        Tue,  5 Jan 2021 05:07:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7DBC7800C1;
        Tue,  5 Jan 2021 05:07:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="c/sjXhuV";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBm5SAHQbxrHRXR+BmUbGtkvJAE0pd88gcdtucdjeUfiwYEugAT+LzG9QevssbrYsgPzxZKyctXELJsFqQxH0QT5cyl/HmRo3vMPjic7tGGro9cBoOJsASOTIKSxfUUf8jqe8tbcHGjLPfIJ7oVEOQYPOL6O+G5hK+slpr2veNx2VXNrFP6NNfC1fZv34SCcRa87zSVh7g6GLpnsbBKnQPIheN6Q9jfXUjL8uwGYIfUppXHdDvMJ1se8RGdv3nAVB9NQt1uoYSGBBAUYo3Uii0zh+rQwsTb3GAiepM8WPGiOiDQ2MS56CkVTHTp4arVld2KRYAafqBklo3Sl/VmcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak7v+pljvwgmkCRkPQgXYQSoEcv0eiBbTuu6sJqVb1A=;
 b=JHtbK1GjP5Z2B8QZckXP+uTcnWnURBzScY8bk3zDIPX+215iH7/jXxyWLOIRXdvhtsywW1mNgGQ1LeVR1Bv0a1zVjQTmvRGQQ1iHuyyuxCMmAbmD2ymXjGUPeAaUvZmWDH1/CAUyWrcHr0zmQE7svvgP8DbnbNPwSBxIW5fvJ/y37JHHfkjDSlv4vc1avbOvRa/ZYkrXv1RHLOx+8JbPs7pBdd5K8DQyGyg9NR0BoaKufDSG4TSw3AcFIlPgQ7xQAopdQlpqS4Ebd+4LLmOE9dudOr/nDWHro8cUBrPO5e+ZCkr/JdbIbhiTB/uH0wVE70AUt61N7bhYtp8JkUnEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak7v+pljvwgmkCRkPQgXYQSoEcv0eiBbTuu6sJqVb1A=;
 b=c/sjXhuV1qWd/VE52o4WG3dwK+3AHQwhWLN+Eo1+S3TV2sAjgrbdVBsnCPF2Ql3MAKCuOnaKAvEM0ZAeW1J0O5WaiIJjdeGia603kENaf155ydOPugcX9XiebVfWlUdqkQ/4Biaxc9UEkE0yh1kUk/KBvTpHSxN0xzNvSXe9voU=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3254.namprd12.prod.outlook.com (2603:10b6:a03:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Tue, 5 Jan
 2021 05:07:05 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 05:07:05 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v3] arch/arc: add copy_user_page() to <asm/page.h> to fix
 build error on ARC
Thread-Topic: [PATCH v3] arch/arc: add copy_user_page() to <asm/page.h> to fix
 build error on ARC
Thread-Index: AQHW4xWINHlmzpy9lE+McOvZMOuaoKoYewsA
Date:   Tue, 5 Jan 2021 05:07:05 +0000
Message-ID: <503084f4-b082-edc7-1d11-c3d712a5b4b5@synopsys.com>
References: <20210105034453.12629-1-rdunlap@infradead.org>
In-Reply-To: <20210105034453.12629-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed38f42f-74f9-421f-acda-08d8b137bec1
x-ms-traffictypediagnostic: BYAPR12MB3254:
x-microsoft-antispam-prvs: <BYAPR12MB32548CA255AF3794B5146155B6D10@BYAPR12MB3254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwK/kRD3rbp4yVV1AusCDLjdm/c9c3//QV2muooG8HY6gygrZRbZrmktENkOY2qsiv2et0i/gCRdl82gk2q/9sNzSsgl8GNVb7mNPxzJEk4TDEo8fLwOIRTAloDHrVDkfzVCcTCUcsPH1ncr7W80b8x5O3mUO3N56G50cKF1YrD8K+qsz9VPIiwFIWNYXS/yaL3CeoArjaEUCg0FZAdxSMO//v/NPMB7eR+oCjjnol40YaRgHcCgdsSjPiRXDgGweDQgBkUWWMqTNewQUrAUxnLWoTPMfau03cEoUPgKLcKgL8BXFCetk9WuR88/Obf1YpuZehN6zvcFuHveXbiBPsb/9BE7ouxvcWJDHJ5Y0SCpBqNKTMbftgPS0Zj9mMXUnlV5/49iiTa6s/jObGfw63obsKXhd4HUA6tyliPmn5LpHqwtSUozZmdC9jQYOr9uDwI3BPZgT6YpeOAbRavfveEuw6we4+nAb3NKQkCo6gg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(31696002)(36756003)(186003)(54906003)(316002)(110136005)(26005)(6506007)(53546011)(8936002)(71200400001)(64756008)(76116006)(66946007)(66446008)(4326008)(2906002)(86362001)(2616005)(66476007)(31686004)(7416002)(478600001)(5660300002)(8676002)(6486002)(6512007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SGhHWE44ZVhBTGZxTUZtUk83eFJIZzB3WExIeHc2alprTEZvc3ZTMVFCWTJW?=
 =?utf-8?B?Y1JuK1hreFM5L0V1a2FudER3TWlIdkFBZm5RZnBUWHY4V01ZOHBrbi9HdkRo?=
 =?utf-8?B?THNCMHRTNWtiZS9QRm5VWnNzaUhaVmhuN0tEWWltQVFTdEg4cm43c24rNjhD?=
 =?utf-8?B?S0taQXZnQmJDZW00N0ZwM1RCbjNsQWRvOXllOFlLL0E0dnl4R09Oc3lTVXdD?=
 =?utf-8?B?VmNFZWlrdi9rdTRWZEN3OGQxdVMyem9xK2pRQVJoRHhKWXl6YUd6bjBzdHpT?=
 =?utf-8?B?cW9SUkVLMFR6K1hTU2djUjBJRlMxclZGY3JUV1JYYmxjd0EwSHVZdWl5TkJO?=
 =?utf-8?B?bFEwNWJ3a2QySFlKMFJJN1pYdWdoMDBLcG12UHRyblg5M3AxU29Zd3FmajhZ?=
 =?utf-8?B?dW1WT2E5YTlUa2JEVDQwT21UbXM2S2wxM2pTbDZnbTNGcDB1MXNNUFZ6VnpI?=
 =?utf-8?B?Q1hPUjB0NlFWTTNRRGsvWVlnWXBTbDVSTHFKdUsrSE1PSStZNkRQWGNtcGxz?=
 =?utf-8?B?VkNQa2IrbzZEMUxxNlpsWHdSSk4rQzFnQ3NHRzRGeXJHd3pRY3AyVi9qYkJG?=
 =?utf-8?B?TWpOTnFWVkJoY0p1SGZSVERVNkdjbis0anZMT0V6aUkyWEdqTFNrakdSMys3?=
 =?utf-8?B?K0lSQTBGRFVsQmp6MkRRT09kSkhZNEQwT1pJWHZxMW15MUdteEhIYk10WTZv?=
 =?utf-8?B?ZnhnZUFieVpOdXVqMUNGalBYQk92VjQyYndXU2thU2xJSW5WQ1hISWgvWGt4?=
 =?utf-8?B?YmRPdGtseElVV0x0WGpNNHV3M2hVK0sxRjlqSzRvSllrUVBUeVZ6b2NrYUVj?=
 =?utf-8?B?dVRUMzZ0dmNuZWlPNjBKT3dacUN3VGxRV0ZldHdsTEFNUHhGb2ZtYVBnTjF5?=
 =?utf-8?B?NWZ0UEhhV0xxc0JlbldwYWVWU25aVzFqbFA4YVRXZkU1NFRWQ2ZLVE9jR0Na?=
 =?utf-8?B?SUtKMmpuMGVVMm1wOWFJT1h5TjJkbEloZGp0WG13VGpJZ0ZRT2NFK2NWSjVi?=
 =?utf-8?B?UW1VenpkT1NCODhiVE9mL0ZSbVBzRjFLVmVRNXJEdHhEdmhJVlkvOS9mQU1Z?=
 =?utf-8?B?UC9VMzd5WFo1S3NiM3M3ay9aV3REVGZ4d21JVGdPcCthTS9TMmFpZUxLVit6?=
 =?utf-8?B?Nng3L3M0akJrNFlVNVhwZjNzVVJuVXNlVTlxUlhEODZidVdMY0UvVGw3VVBR?=
 =?utf-8?B?bXdGcVVEQ201TjZNSFZIeHlvWHdIVnBTQndaMlhsNXBzUW1wMC9yZ3AxSXAx?=
 =?utf-8?B?QSs2WmY3NUU0QUxabzdRL2c3QzNFZ2NaNDUwcFRqdnZnRitzV2g5bGhud1pO?=
 =?utf-8?Q?dzfE25dWElQgs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <895D86CCCCA3BF40998EEAF54ED487E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed38f42f-74f9-421f-acda-08d8b137bec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 05:07:05.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsMkOMkQf9kKkEMsyoXUfcoFerp2tLOIu2zTVfXKM4twJLPGWhL7jC8VJQ6u7pWkUwp1AdtDgdkmblOIsb/KEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3254
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS80LzIxIDc6NDQgUE0sIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gZnMvZGF4LmMgdXNlcyBj
b3B5X3VzZXJfcGFnZSgpIGJ1dCBBUkMgZG9lcyBub3QgcHJvdmlkZSB0aGF0IGludGVyZmFjZSwN
Cj4gcmVzdWx0aW5nIGluIGEgYnVpbGQgZXJyb3IuDQo+IA0KPiBQcm92aWRlIGNvcHlfdXNlcl9w
YWdlKCkgaW4gPGFzbS9wYWdlLmg+Lg0KPiANCj4gLi4vZnMvZGF4LmM6IEluIGZ1bmN0aW9uICdj
b3B5X2Nvd19wYWdlX2RheCc6DQo+IC4uL2ZzL2RheC5jOjcwMjoyOiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2NvcHlfdXNlcl9wYWdlJzsgZGlkIHlvdSBtZWFuICdj
b3B5X3RvX3VzZXJfcGFnZSc/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQ0KPiANCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4g
Q2M6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IGxpbnV4LXNucHMt
YXJjQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlh
bXNAaW50ZWwuY29tPg0KPiAjQWNrZWQtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lz
LmNvbT4gIyB2MQ0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
Zz4NCj4gQ2M6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiBDYzogSmFu
IEthcmEgPGphY2tAc3VzZS5jej4NCj4gQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnDQo+ICNSZXZpZXdlZC1ieTogSXJhIFdl
aW55IDxpcmEud2VpbnlAaW50ZWwuY29tPiAjIHYyDQoNCkFkZGVkIHRvIGFyYyAjZm9yLWN1cnIu
DQoNClRoeCwNCi1WaW5lZXQNCg0KPiAtLS0NCj4gdjI6IHJlYmFzZSwgYWRkIG1vcmUgQ2M6DQo+
IHYzOiBhZGQgY29weV91c2VyX3BhZ2UoKSB0byBhcmNoL2FyYy9pbmNsdWRlL2FzbS9wYWdlLmgN
Cj4gDQo+ICAgYXJjaC9hcmMvaW5jbHVkZS9hc20vcGFnZS5oIHwgICAgMSArDQo+IA0KPiAtLS0g
bG54LTUxMS1yYzEub3JpZy9hcmNoL2FyYy9pbmNsdWRlL2FzbS9wYWdlLmgNCj4gKysrIGxueC01
MTEtcmMxL2FyY2gvYXJjL2luY2x1ZGUvYXNtL3BhZ2UuaA0KPiBAQCAtMTAsNiArMTAsNyBAQA0K
PiAgICNpZm5kZWYgX19BU1NFTUJMWV9fDQo+ICAgDQo+ICAgI2RlZmluZSBjbGVhcl9wYWdlKHBh
ZGRyKQkJbWVtc2V0KChwYWRkciksIDAsIFBBR0VfU0laRSkNCj4gKyNkZWZpbmUgY29weV91c2Vy
X3BhZ2UodG8sIGZyb20sIHZhZGRyLCBwZykJY29weV9wYWdlKHRvLCBmcm9tKQ0KPiAgICNkZWZp
bmUgY29weV9wYWdlKHRvLCBmcm9tKQkJbWVtY3B5KCh0byksIChmcm9tKSwgUEFHRV9TSVpFKQ0K
PiAgIA0KPiAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdDsNCj4gDQoNCg==
