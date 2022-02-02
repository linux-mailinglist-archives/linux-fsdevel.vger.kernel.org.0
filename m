Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D244A79B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 21:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiBBUrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 15:47:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:49650 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239421AbiBBUrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643834834; x=1675370834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=likA05MZB+szVduXb/00IvX+f98KajuHPHkfjKl2Tv8=;
  b=WtQokH9eDBF39PXpUcxhobJgmwaY1Pjb66audRwTijQ82qf+qmV5YfGd
   aLLJGZLekLyoqpLyR/znIsUJ8FAl1EYg4iZ+Eh+T4C5NUzD/fCLJyfOmb
   sR/jxjg2ifhGYONz9VEgFSs6kHFyz3EPVzwRFQW5JrTHqdQu9FWxbzDRV
   q508q3tOyw46bivKTaU1SoZovbzZKlA0afMeYq7WsEP4qxwjS8i/SCUrh
   Q/b8s9zz2dtwthpGcvAqJo8muqFhCGW+IouLtpn66DSJB5zSjUedS5l9I
   hu0HXhV2RpSrww48fko+QnpCOOhj3rVIwkDyq74Pm/UEQQ3pAVJjZiF9Z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272506292"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="272506292"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="538466684"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 02 Feb 2022 12:47:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 2 Feb 2022 12:47:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 2 Feb 2022 12:47:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 2 Feb 2022 12:47:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNZ3fbmsSG+kKazt+VDr/ibuqjq8pUPe3zqjXW+Nv1tq/e6sm6aL8OkWqcUHYjSnpWRV189mqNFXf/7i70k8Bly2N5jEiVJSPI9CDOJHeKEVY/pRUsQw3GBPUDzJ0D65tCrhVnx/W/SE0vhODDJuu5YvFZfLb7gnB+nZC56pEDIEEdvMxHV7XqS/OEhYSKky+Lpnvc0RAOJtB94u5iwdA0WQBYlFEC93SDM3f5LUBbnTeH+PyYpeZ0zVxgHK1FkIICDFCG+HEiT3rkgREbRy2u0bzXEyPIOnrmwNqsTnOfRSxEGgWhTztAWSWv4u3A/cUJO7QMTg3Ogoym3cyvYgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=likA05MZB+szVduXb/00IvX+f98KajuHPHkfjKl2Tv8=;
 b=KjNq+EeQCy5sJodmoolSwO//ZoLVuct0N0F5we55BIOBHBx7Q16COLsVsxFz0hWHyjrkYF9HPc51MT4tI45YDt6SFg5E8Qwz5f3HctgF9EgrLALEf6qb+DSX+YpmJ+xkM1y//6I6X/gStIv7ZNxDVVyRuiQ0IDcsh98LUip4gVMEoUOicBIOPYECmgujrOHXAHDW3tYwC0dLWhl4flX3My3jw4RaxQJbFbfPgMAfECfwNm2tV63wqQkJGw03q8hDo0S0a1tL47ZNy0Uq5WLAP1RTq7Ynq0DzQGeyNOp9nGF6oFLvRkW3T0kxwKoaY4gKxU55z+pEU8E9K7fNMf4kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by DM6PR11MB3019.namprd11.prod.outlook.com (2603:10b6:5:67::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 20:47:11 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::3499:a5f6:82d:76ad]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::3499:a5f6:82d:76ad%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 20:47:10 +0000
From:   "Nakajima, Jun" <jun.nakajima@intel.com>
To:     Steven Price <steven.price@arm.com>
CC:     Chao Peng <chao.p.peng@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v4 00/12] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Thread-Topic: [PATCH v4 00/12] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Thread-Index: AQHYDG5kCMt6ReoFPkCCY5N8FQOK+Kx4tJYAgAbrnYCAAHP0AIAAvxQA
Date:   Wed, 2 Feb 2022 20:47:10 +0000
Message-ID: <1E8B7AC0-05B8-460F-96DB-FE1E04BA774A@intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <3326f57a-169d-8eb8-2b8b-0379c33ba7a5@arm.com>
 <08A0882C-2E35-4CFD-9176-FCB6665D1F3E@intel.com>
 <74a4a56f-539e-c51b-d90b-d2d6f55a34a3@arm.com>
In-Reply-To: <74a4a56f-539e-c51b-d90b-d2d6f55a34a3@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c946e38f-cdca-4615-fcb4-08d9e68d2f61
x-ms-traffictypediagnostic: DM6PR11MB3019:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB30198F90B4ED4D39AB8E52C59A279@DM6PR11MB3019.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zA/IRSbiAdI8HVm9Rgebk4cMMjs2r+C/rjmJQ7Ec5UZa+8C3OkHo7yMx1kIZqFMO2EZs6O1/JS0rRsJdO47qf/UL+0aQ3Xwiw4G2faSlMXQ6VNjoqXQ4oIv/UooN40wlsbu7I6fAYprSuD59p/2z9lQT4BERJFlCsORF7kqCDhpn5H/wWVu5+SpzNxXHHHtpjPIql4jM5868Ije4d+mQOjtWz7HqixvbWyT+bThNGWLWqYGMUmVQs948rtepEsuDwkHQTlzdbOzKnpB774/ouYt2x6kO7ymlhoMD2cEjLKL1VHqdFcoXVCwFgbRJSRhWTey0cvk+XZPpBPMfzTaDuI6i9OeK1Zja/RpfViHpGLNrJAp34HykeSG1jXhc48/4FhMbEtGaH7/bSWHAbPogyfDSn/ck4RxID0ru7bnUWtNKEebtQPRrgYlCNRKBlGCIiJlBAtFVCUf0nvnrDkk07aMj8MAvzOxpQ2q8ZwGHlgjnabSj2DzvaVvXrudgXkEeEfB5tOgVFD65UhLap88l4C6Jmiz/XeVrk/OhKVLUaS+Z5xrTDDVeWpI2kguCS0o2J+gcSNcgfcpca8oiA4DkMoWCz6t4bjo4Wusi/E4PL9jxCc33MYcy+RRvJEkwe0mFBAmj4c/ENIG58SrWvnecNOEMDrk2/oC5Pvf2+VKrSV1vpuBQc2FlmZaUx5tfzU26PFoGj0L1S1FLXcDQp9ghX+7fFwAL+V3Lsa2mwuQk3lFz6UwrjIHlMguWo5tF8jqz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38070700005)(71200400001)(66556008)(82960400001)(66476007)(66446008)(53546011)(64756008)(86362001)(76116006)(8936002)(186003)(66946007)(6486002)(6506007)(26005)(122000001)(8676002)(508600001)(316002)(38100700002)(33656002)(2616005)(6512007)(5660300002)(83380400001)(36756003)(54906003)(2906002)(6916009)(7416002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDlSbUpPZjBWdWQzZHVLbXF5c2tLOFZnNEx4a3JKOUV2WktUNlFDS0hUZUh2?=
 =?utf-8?B?WUo0cVh5bjB1ZkFxT214bDJtUEtHYytWVllrb083UFhoT29CeUZrb2JiRFkr?=
 =?utf-8?B?UHlOTnpkMnJVdlZLZXBXMTdXbVFYd3l6WGFxRTVyb0N0cXAzM1JiS3JiUGE1?=
 =?utf-8?B?U2Q4WEx2eXRSZ2NpTUl1ck9TS1VsYUJPbUROTTl5bkNCZmZvUDN3eEZPaXFK?=
 =?utf-8?B?aHJ4TnhWbjVWdWtJM2IzTXROeEhDWEdKOE5ZeWZNTFVZVzdSeEU1Vno1UWFE?=
 =?utf-8?B?WDk5dlRZdTVZNERRbTVPQVhWNTlNTkxXdGdhbWhaK2hYeFlvd29XL0pidE5o?=
 =?utf-8?B?akY4OUUxS2VqazY4eDJ1VXYzeE9MbUtnY1ZRam45aEhFOGttbnA4YUVVcnU4?=
 =?utf-8?B?VDZsbzJGNHJJU1VGemMzM3licVlucFpFbzA5OXcyUmdWQ0RrMnk0bmtMM1l6?=
 =?utf-8?B?V2oyOS9LYjVibk5hWXdnUnFlWXNyRWt6VWNIRXJFdG5KYzh1ZWRCcjhlR1h4?=
 =?utf-8?B?eG1YV0dkK1hLeTFJdWg1aHk0dVFPU3dhN2NtZXB4RXBNRmNGWmtxRlpnVXRF?=
 =?utf-8?B?MzJkZFBKWmY2SkR4MythOGJIUW9hQWI3QlRpQWsyR2RNaDNPcGpjSzZWRVc1?=
 =?utf-8?B?djA2YXpnV1JnYWZSbnpVOUZMNHAwSjVDRlJsUjBhdkNoaXc2SzRCZVFGOUgw?=
 =?utf-8?B?UjZZZ2VoSVNwWmFoSTNFcGoreFZNeGs0MTUrMkg4WkJuam1scGtFbEdvUTVh?=
 =?utf-8?B?Ymdvc1k4NUllMFpsNjVwYmQ2Ti83WkFSYUw4aHZkcG1Jemw2djhzSHYxWjZp?=
 =?utf-8?B?cnppMmtnR0c3andIeVRqUE1GZCtYN2pTeTRLQk5CUlJCbHdxMVc3bG1Cd01T?=
 =?utf-8?B?a3kzaVFjV3V6WUd1RDhqV3NhdjlxSHk1cVRsdE5BTjNRbUtzSVRUUmMrNnBL?=
 =?utf-8?B?Sml0MnBIY1ZJUDhHeHorS29EakRjZVNxOGk0MmwvNXowU3N1bUpodk9CeThM?=
 =?utf-8?B?NTJCelJ2YXJ5WjZKK0s3bEM0YXMvZXZabzF0aUorUmpLVHBmbkE3dlk1c01x?=
 =?utf-8?B?ZkE4L2d0NDNlWlNaZjgzNGlZbmIyWU40RlpkazdDSVhNWFRQRHByRHM0M0tx?=
 =?utf-8?B?NGNIeXVWL25kSEN2Mk1Ed1diK0dHaTR0NWhqc21KMmhka2JXUFROcUdUamli?=
 =?utf-8?B?R0R0a3h5M1hNUUVVUEptbXA3c3d1RWE5VzdBQzNRNDNSSkxueDJvUXQwNUJv?=
 =?utf-8?B?K1N1dUhSWitheGlWS2dBYzBiWXZLTFk5ZzVVZW1qSWZDbGkrWHdVODBvYlFl?=
 =?utf-8?B?MDg3bWZzTTNiWE5zY0pteHBVZXBYQ1NaVE5QNFpNcnhBQ2VhR2l3YkdNK1JO?=
 =?utf-8?B?YjlVZzF0UnpKcUNXODNCTlV1dDRhTWdTZWZlR25MazV6RUdRdG1uYmpIZWNp?=
 =?utf-8?B?eG5vQ0pxTVQ2cDZjck9QSHI5a1NpMEVJb0tVZm9HTEdVVWY0RUZ5QXgyTzZP?=
 =?utf-8?B?OGl3Ymd0YlRpdml2TVFFN2ZFbmJsNkdXRFk1T0IrbHlkVGdHUUpQWGJmK1Y3?=
 =?utf-8?B?ZVNOYWx5Wjh0bDFUQkVDbVFwdFJGL2ZYajVwdEZpN1Jzd0lqK2w5aEdhVjJr?=
 =?utf-8?B?dEU3djNnTEVUUitXdDNhYzZYdnY1WDc1SXN5eTM3UWJFbUlTSFNFanhFdTJs?=
 =?utf-8?B?dGRCYjAyL1gvdFR5UTEwQ1lLRnNOOTNsSWV0YmJwakVLakV4VTJkNno2dDFC?=
 =?utf-8?B?QldSdnM5SENndTRMSFpsSlkwL3hrTG5jYnpEaWRVMFBVY0duWHFCU0NSSUNx?=
 =?utf-8?B?dDNUa2xneGtVNjVzVnNBdFh0VFdZckpBTjB3N3ZhbXZHeUxPbVluMTVTbGhF?=
 =?utf-8?B?K1E5c0hvRTJIamlCNDFnTU1yR2ZubGFPZDhjUkNEOW5IdkhGc0lSUGpVRFRq?=
 =?utf-8?B?R2xjV09hVGNQd014RUVRZ3JGbmVtaVd4bWJjZXczVllCYWxTM2hhejc2NGZG?=
 =?utf-8?B?YVd4c1Z1bkd0TmlxblVUVDFPbGdDWWloRU1kaThVSzlRaGxMenI3OTkzcFd6?=
 =?utf-8?B?SzF5clY4bnRPZVRVRGo3S2Z1cVdOLzkwRXVleEtVOXZBLzdpbWdheTVkVGZT?=
 =?utf-8?B?SmNiMGd5RXJoN3RvSEZQZ1dXaWQ2RjFlMEpGNkRYSkhzNTlreXdNOFhvZHA0?=
 =?utf-8?Q?TGVmk6jlqIh8oeQYM4pXcf4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A4707A5ED1AD248A1EF1E786923D312@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c946e38f-cdca-4615-fcb4-08d9e68d2f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 20:47:10.8270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drocGwNmgOg1xFjZzX04rY/cUlVWOi8GXsF3ilQ1nnG5/nTkAbZQlPpQSNqhiCBAEp2T11RSMZvvHo7U5wE2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3019
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEZlYiAyLCAyMDIyLCBhdCAxOjIzIEFNLCBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmlj
ZUBhcm0uY29tPiB3cm90ZToNCj4gDQo+IEhpIEp1biwNCj4gDQo+IE9uIDAyLzAyLzIwMjIgMDI6
MjgsIE5ha2FqaW1hLCBKdW4gd3JvdGU6DQo+PiANCj4+PiBPbiBKYW4gMjgsIDIwMjIsIGF0IDg6
NDcgQU0sIFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IE9uIDE4LzAxLzIwMjIgMTM6MjEsIENoYW8gUGVuZyB3cm90ZToNCj4+Pj4gVGhpcyBpcyB0
aGUgdjQgb2YgdGhpcyBzZXJpZXMgd2hpY2ggdHJ5IHRvIGltcGxlbWVudCB0aGUgZmQtYmFzZWQg
S1ZNDQo+Pj4+IGd1ZXN0IHByaXZhdGUgbWVtb3J5LiBUaGUgcGF0Y2hlcyBhcmUgYmFzZWQgb24g
bGF0ZXN0IGt2bS9xdWV1ZSBicmFuY2gNCj4+Pj4gY29tbWl0Og0KPj4+PiANCj4+Pj4gZmVhMzFk
MTY5MDk0IEtWTTogeDg2L3BtdTogRml4IGF2YWlsYWJsZV9ldmVudF90eXBlcyBjaGVjayBmb3IN
Cj4+Pj4gICAgICAgICAgICAgIFJFRl9DUFVfQ1lDTEVTIGV2ZW50DQo+Pj4+IA0KPj4+PiBJbnRy
b2R1Y3Rpb24NCj4+Pj4gLS0tLS0tLS0tLS0tDQo+Pj4+IEluIGdlbmVyYWwgdGhpcyBwYXRjaCBz
ZXJpZXMgaW50cm9kdWNlIGZkLWJhc2VkIG1lbXNsb3Qgd2hpY2ggcHJvdmlkZXMNCj4+Pj4gZ3Vl
c3QgbWVtb3J5IHRocm91Z2ggbWVtb3J5IGZpbGUgZGVzY3JpcHRvciBmZFtvZmZzZXQsc2l6ZV0g
aW5zdGVhZCBvZg0KPj4+PiBodmEvc2l6ZS4gVGhlIGZkIGNhbiBiZSBjcmVhdGVkIGZyb20gYSBz
dXBwb3J0ZWQgbWVtb3J5IGZpbGVzeXN0ZW0NCj4+Pj4gbGlrZSB0bXBmcy9odWdldGxiZnMgZXRj
LiB3aGljaCB3ZSByZWZlciBhcyBtZW1vcnkgYmFja2luZyBzdG9yZS4gS1ZNDQo+Pj4+IGFuZCB0
aGUgdGhlIG1lbW9yeSBiYWNraW5nIHN0b3JlIGV4Y2hhbmdlIGNhbGxiYWNrcyB3aGVuIHN1Y2gg
bWVtc2xvdA0KPj4+PiBnZXRzIGNyZWF0ZWQuIEF0IHJ1bnRpbWUgS1ZNIHdpbGwgY2FsbCBpbnRv
IGNhbGxiYWNrcyBwcm92aWRlZCBieSB0aGUNCj4+Pj4gYmFja2luZyBzdG9yZSB0byBnZXQgdGhl
IHBmbiB3aXRoIHRoZSBmZCtvZmZzZXQuIE1lbW9yeSBiYWNraW5nIHN0b3JlDQo+Pj4+IHdpbGwg
YWxzbyBjYWxsIGludG8gS1ZNIGNhbGxiYWNrcyB3aGVuIHVzZXJzcGFjZSBmYWxsb2NhdGUvcHVu
Y2ggaG9sZQ0KPj4+PiBvbiB0aGUgZmQgdG8gbm90aWZ5IEtWTSB0byBtYXAvdW5tYXAgc2Vjb25k
YXJ5IE1NVSBwYWdlIHRhYmxlcy4NCj4+Pj4gDQo+Pj4+IENvbXBhcmluZyB0byBleGlzdGluZyBo
dmEtYmFzZWQgbWVtc2xvdCwgdGhpcyBuZXcgdHlwZSBvZiBtZW1zbG90IGFsbG93cw0KPj4+PiBn
dWVzdCBtZW1vcnkgdW5tYXBwZWQgZnJvbSBob3N0IHVzZXJzcGFjZSBsaWtlIFFFTVUgYW5kIGV2
ZW4gdGhlIGtlcm5lbA0KPj4+PiBpdHNlbGYsIHRoZXJlZm9yZSByZWR1Y2UgYXR0YWNrIHN1cmZh
Y2UgYW5kIHByZXZlbnQgYnVncy4NCj4+Pj4gDQo+Pj4+IEJhc2VkIG9uIHRoaXMgZmQtYmFzZWQg
bWVtc2xvdCwgd2UgY2FuIGJ1aWxkIGd1ZXN0IHByaXZhdGUgbWVtb3J5IHRoYXQNCj4+Pj4gaXMg
Z29pbmcgdG8gYmUgdXNlZCBpbiBjb25maWRlbnRpYWwgY29tcHV0aW5nIGVudmlyb25tZW50cyBz
dWNoIGFzIEludGVsDQo+Pj4+IFREWCBhbmQgQU1EIFNFVi4gV2hlbiBzdXBwb3J0ZWQsIHRoZSBt
ZW1vcnkgYmFja2luZyBzdG9yZSBjYW4gcHJvdmlkZQ0KPj4+PiBtb3JlIGVuZm9yY2VtZW50IG9u
IHRoZSBmZCBhbmQgS1ZNIGNhbiB1c2UgYSBzaW5nbGUgbWVtc2xvdCB0byBob2xkIGJvdGgNCj4+
Pj4gdGhlIHByaXZhdGUgYW5kIHNoYXJlZCBwYXJ0IG9mIHRoZSBndWVzdCBtZW1vcnkuIA0KPj4+
IA0KPj4+IFRoaXMgbG9va3MgbGlrZSBpdCB3aWxsIGJlIHVzZWZ1bCBmb3IgQXJtJ3MgQ29uZmlk
ZW50aWFsIENvbXB1dGUNCj4+PiBBcmNoaXRlY3R1cmUgKENDQSkgdG9vIC0gaW4gcGFydGljdWxh
ciB3ZSBuZWVkIGEgd2F5IG9mIGVuc3VyaW5nIHRoYXQNCj4+PiB1c2VyIHNwYWNlIGNhbm5vdCAn
dHJpY2snIHRoZSBrZXJuZWwgaW50byBhY2Nlc3NpbmcgbWVtb3J5IHdoaWNoIGhhcw0KPj4+IGJl
ZW4gZGVsZWdhdGVkIHRvIGEgcmVhbG0gKGkuZS4gcHJvdGVjdGVkIGd1ZXN0KSwgYW5kIGEgbWVt
ZmQgc2VlbXMgbGlrZQ0KPj4+IGEgZ29vZCBtYXRjaC4NCj4+IA0KPj4gR29vZCB0byBoZWFyIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwgZm9yIEFSTeKAmXMgQ0NBIGFzIHdlbGwuDQo+PiANCj4+PiAN
Cj4+PiBTb21lIGNvbW1lbnRzIGJlbG93Lg0KPj4+IA0KPj4+PiBtbSBleHRlbnNpb24NCj4+Pj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+IEludHJvZHVjZXMgbmV3IEZfU0VBTF9JTkFDQ0VT
U0lCTEUgZm9yIHNobWVtIGFuZCBuZXcgTUZEX0lOQUNDRVNTSUJMRQ0KPj4+PiBmbGFnIGZvciBt
ZW1mZF9jcmVhdGUoKSwgdGhlIGZpbGUgY3JlYXRlZCB3aXRoIHRoZXNlIGZsYWdzIGNhbm5vdCBy
ZWFkKCksDQo+Pj4+IHdyaXRlKCkgb3IgbW1hcCgpIGV0YyB2aWEgbm9ybWFsIE1NVSBvcGVyYXRp
b25zLiBUaGUgZmlsZSBjb250ZW50IGNhbg0KPj4+PiBvbmx5IGJlIHVzZWQgd2l0aCB0aGUgbmV3
bHkgaW50cm9kdWNlZCBtZW1maWxlX25vdGlmaWVyIGV4dGVuc2lvbi4NCj4+PiANCj4+PiBGb3Ig
QXJtIENDQSB3ZSBhcmUgZXhwZWN0aW5nIHRvIHNlZWQgdGhlIHJlYWxtIHdpdGggYW4gaW5pdGlh
bCBtZW1vcnkNCj4+PiBjb250ZW50cyAoZS5nLiBrZXJuZWwgYW5kIGluaXRyZCkgd2hpY2ggd2ls
bCB0aGVuIGJlIG1lYXN1cmVkIGJlZm9yZQ0KPj4+IGV4ZWN1dGlvbiBzdGFydHMuIFRoZSAnb2J2
aW91cycgd2F5IG9mIGRvaW5nIHRoaXMgd2l0aCBhIG1lbWZkIHdvdWxkIGJlDQo+Pj4gdG8gcG9w
dWxhdGUgcGFydHMgb2YgdGhlIG1lbWZkIHRoZW4gc2VhbCBpdCB3aXRoIEZfU0VBTF9JTkFDQ0VT
U0lCTEUuDQo+PiANCj4+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIHdlIGhhdmUgdGhlIHNhbWUg
cHJvYmxlbSB3aXRoIFREWCwgd2hlcmUgYSBndWVzdCBURCAoVHJ1c3QgRG9tYWluKSBzdGFydHMg
aW4gcHJpdmF0ZSBtZW1vcnkuIFdlIHNlZWQgdGhlIHByaXZhdGUgbWVtb3J5IHR5cGljYWxseSB3
aXRoIGEgZ3Vlc3QgZmlybXdhcmUsIGFuZCB0aGUgaW5pdGlhbCBpbWFnZSAocGxhaW50ZXh0KSBp
cyBjb3BpZWQgdG8gc29tZXdoZXJlIGluIFFFTVUgbWVtb3J5IChmcm9tIGRpc2ssIGZvciBleGFt
cGxlKSBmb3IgdGhhdCBwdXJwb3NlOyB0aGlzIGxvY2F0aW9uIGlzIG5vdCBhc3NvY2lhdGVkIHdp
dGggdGhlIHRhcmdldCBHUEEuDQo+PiANCj4+IFVwb24gYSAobmV3KSBpb2N0bCBmcm9tIFFFTVUs
IEtWTSByZXF1ZXN0cyB0aGUgVERYIE1vZHVsZSB0byBjb3B5IHRoZSBwYWdlcyB0byBwcml2YXRl
IG1lbW9yeSAoYnkgZW5jcnlwdGluZykgc3BlY2lmeWluZyB0aGUgdGFyZ2V0IEdQQSwgdXNpbmcg
YSBURFggaW50ZXJmYWNlIGZ1bmN0aW9uIChUREguTUVNLlBBR0UuQUREKS4gVGhlIGFjdHVhbCBw
YWdlcyBmb3IgdGhlIHByaXZhdGUgbWVtb3J5IGlzIGFsbG9jYXRlZCBieSB0aGUgY2FsbGJhY2tz
IHByb3ZpZGVkIGJ5IHRoZSBiYWNraW5nIHN0b3JlIGR1cmluZyB0aGUg4oCcY29weeKAnSBvcGVy
YXRpb24uDQo+PiANCj4+IFdlIGV4dGVuZGVkIHRoZSBleGlzdGluZyBLVk1fTUVNT1JZX0VOQ1JZ
UFRfT1AgKGlvY3RsKSBmb3IgdGhlIGFib3ZlLiANCg0KSGkgU3RldmUsDQoNCj4gDQo+IE9rLCBz
byBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IFFFTVUgd291bGQgZG8gc29tZXRoaW5nIGFsb25n
IHRoZSBsaW5lcyBvZjoNCj4gDQo+IDEuIFVzZSBtZW1mZF9jcmVhdGUoLi4uTUZEX0lOQUNDRVNT
SUJMRSkgdG8gYWxsb2NhdGUgcHJpdmF0ZSBtZW1vcnkgZm9yDQo+IHRoZSBndWVzdC4NCj4gDQo+
IDIuIGZ0cnVuY2F0ZS9mYWxsb2NhdGUgdGhlIG1lbWZkIHRvIGJhY2sgdGhlIGFwcHJvcHJpYXRl
IGFyZWFzIG9mIHRoZSBtZW1mZC4NCj4gDQo+IDMuIENyZWF0ZSBhIG1lbXNsb3QgaW4gS1ZNIHBv
aW50aW5nIHRvIHRoZSBtZW1mZA0KPiANCj4gNC4gTG9hZCB0aGUgJ2d1ZXN0IGZpcm13YXJlJyAo
a2VybmVsL2luaXRyZCBvciBzaW1pbGFyKSBpbnRvIFZNTSBtZW1vcnkNCj4gDQo+IDUuIFVzZSB0
aGUgS1ZNX01FTU9SWV9FTkNSWVBUX09QIHRvIHJlcXVlc3QgdGhlICdndWVzdCBmaXJtd2FyZScg
YmUNCj4gY29waWVkIGludG8gdGhlIHByaXZhdGUgbWVtb3J5LiBUaGUgaW9jdGwgd291bGQgdGVt
cG9yYXJpbHkgcGluIHRoZQ0KPiBwYWdlcyBhbmQgYXNrIHRoZSBURFggbW9kdWxlIHRvIGNvcHkg
KCYgZW5jcnlwdCkgdGhlIGRhdGEgaW50byB0aGUNCj4gcHJpdmF0ZSBtZW1vcnksIHVucGlubmlu
ZyBhZnRlciB0aGUgY29weS4NCj4gDQo+IDYuIFFFTVUgY2FuIHRoZW4gZnJlZSB0aGUgdW5lbmNy
eXB0ZWQgY29weSBvZiB0aGUgZ3Vlc3QgZmlybXdhcmUuDQoNClllcywgdGhpcyBpcyBjb3JyZWN0
LiBXZSBwaW4gYW5kIHVucGluIHRoZSBwYWdlcyBvbmUtYnktb25lIHRvZGF5LCB0aG91Z2guDQoN
Cg0KPiANCj4+PiANCj4+PiBIb3dldmVyIGFzIHRoaW5ncyBzdGFuZCBpdCdzIG5vdCBwb3NzaWJs
ZSB0byBzZXQgdGhlIElOQUNDRVNTSUJMRSBzZWFsDQo+Pj4gYWZ0ZXIgY3JlYXRpbmcgYSBtZW1m
ZCAoRl9BTExfU0VBTFMgaGFzbid0IGJlZW4gdXBkYXRlZCB0byBpbmNsdWRlIGl0KS4NCj4+PiAN
Cj4+PiBPbmUgcG90ZW50aWFsIHdvcmthcm91bmQgd291bGQgYmUgZm9yIGFybTY0IHRvIHByb3Zp
ZGUgYSBjdXN0b20gS1ZNDQo+Pj4gaW9jdGwgdG8gZWZmZWN0aXZlbHkgbWVtY3B5KCkgaW50byB0
aGUgZ3Vlc3QncyBwcm90ZWN0ZWQgbWVtb3J5IHdoaWNoDQo+Pj4gd291bGQgb25seSBiZSBhY2Nl
c3NpYmxlIGJlZm9yZSB0aGUgZ3Vlc3QgaGFzIHN0YXJ0ZWQuIFRoZSBkcmF3YmFjayBpcw0KPj4+
IHRoYXQgaXQgcmVxdWlyZXMgdHdvIGNvcGllcyBvZiB0aGUgZGF0YSBkdXJpbmcgZ3Vlc3Qgc2V0
dXAuDQo+PiANCj4+IFNvLCB0aGUgZ3Vlc3QgcGFnZXMgYXJlIG5vdCBlbmNyeXB0ZWQgaW4gdGhl
IHJlYWxtPw0KPiANCj4gVGhlIHBhZ2VzIGFyZSBsaWtlbHkgdG8gYmUgZW5jcnlwdGVkLCBidXQg
YXJjaGl0ZWN0dXJhbGx5IGl0IGRvZXNuJ3QNCj4gbWF0dGVyIC0gdGhlIGhhcmR3YXJlIHByZXZl
bnRzIHRoZSAnTm9ybWFsIFdvcmxkJyBhY2Nlc3NpbmcgdGhlIHBhZ2VzDQo+IHdoZW4gdGhleSBh
cmUgYXNzaWduZWQgdG8gdGhlIHJlYWxtLiBFbmNyeXB0aW9uIGlzIG9ubHkgbmVjZXNzYXJ5IHRv
DQo+IHByb3RlY3QgYWdhaW5zdCBoYXJkd2FyZSBhdHRhY2tzIChlLmcuIGJ1cyBzbm9vcGluZyku
DQo+IA0KPj4gSSB0aGluayB5b3UgY291bGQgZG8gdGhlIHNhbWUgdGhpbmcsIGkuZS4gS1ZNIGNv
cGllcyB0aGUgcGFnZXMgdG8gdGhlIHJlYWxtLCB3aGVyZSBwYWdlcyBhcmUgYWxsb2NhdGVkIGJ5
IHRoZSBiYWNraW5nIHN0b3JlLiBCdXQsIHllcywgaXQgd2lsbCBoYXZlIHR3byBjb3BpZXMgb2Yg
dGhlIGRhdGEgYXQgdGhhdCB0aW1lIHVubGVzcyBlbmNyeXB0ZWQuIC4NCj4gDQo+IEknbSBub3Qg
c3VyZSBJIGZvbGxvdyB0aGUgInVubGVzcyBlbmNyeXB0ZWQiIHBhcnQgb2YgdGhhdC4NCg0KV2hh
dCBJIG1lYW50IGlzLCB0aGUgZW5jcnlwdGVkIG9uZSBpcyBub3QgYSBjb3B5IGJlY2F1c2UgdGhl
IGhvc3Qgc29mdHdhcmUgY2Fubm90IHJlY3JlYXRlIGl0IChmcm9tIHRoZSBURFggYXJjaGl0ZWN0
dXJlIHBvaW50IG9mIHZpZXcpLiBQcmFjdGljYWxseSB3ZSDigJxtb3Zl4oCdIHRoZSBwYWdlcyB0
byBwcml2YXRlIG1lbW9yeSBhcyB3ZSBwaW4gYW5kIHVucGluIHRoZSBwYWdlcyBvbmUtYnktb25l
IChhYm92ZSkuDQoNCg0KPiANCj4+PiANCj4+PiBEbyB5b3UgdGhpbmsgdGhpbmdzIGNvdWxkIGJl
IHJlbGF4ZWQgc28gdGhlIEZfU0VBTF9JTkFDQ0VTU0lCTEUgZmxhZw0KPj4+IGNvdWxkIGJlIHNl
dCBhZnRlciBhIG1lbWZkIGhhcyBiZWVuIGNyZWF0ZWQgKGFuZCBwYXJ0aWFsbHkgcG9wdWxhdGVk
KT8NCj4+PiANCj4+IA0KPj4gSSB0aGluayBGX1NFQUxfSU5BQ0NFU1NJQkxFIGNvdWxkIGJlIGRl
ZmVycmVkIHRvIHRoZSBwb2ludCB3aGVyZSBtZWFzdXJlbWVudCBvZiB0aGUgaW5pdGlhbCBpbWFn
ZSBpcyBkb25lICh3ZSBjYWxsIOKAnGJ1aWxkLXRpbWXigJ0gbWVhc3VyZW1lbnQgaW4gVERYKS4g
Rm9yIGV4YW1wbGUsIGlmIHdlIGFkZCBhIGNhbGxiYWNrIHRvIGFjdGl2YXRlIEZfU0VBTF9JTkFD
Q0VTU0lCTEUgYW5kIEtWTSBjYWxscyBpdCBiZWZvcmUgc3VjaCB0aGUgbWVhc3VyZW1lbnQgdGlt
ZSwgZG9lcyB0aGF0IHdvcmsgZm9yIHlvdT8NCj4gDQo+IFllcywgaWYgaXQncyBwb3NzaWJsZSB0
byBkZWZlciBzZXR0aW5nIHRoZSBGX1NFQUxfSU5BQ0NFU1NJQkxFIHRoZW4gaXQNCj4gc2hvdWxk
IGJlIHBvc3NpYmxlIGZvciBRRU1VIHRvIGxvYWQgdGhlIGluaXRpYWwgJ2d1ZXN0IGZpcm13YXJl
Jw0KPiBzdHJhaWdodCBpbnRvIHRoZSBtZW1mZC4gVGhlbiB0byBsYXVuY2ggdGhlIGd1ZXN0IHRo
ZSB0cnVzdGVkIGNvbXBvbmVudA0KPiBvbmx5IG5lZWRzIHRvIHByb3RlY3QgYW5kIG1lYXN1cmUg
dGhlIHBvcHVsYXRlZCBwYWdlcyAtIHRoZXJlJ3Mgbm8gbmVlZA0KPiB0byBjb3B5IHRoZSBkYXRh
IGZyb20gb25lIHNldCBvZiBwYWdlcyB0byBhbm90aGVyLiBUaGlzIHJlbW92ZXMgdGhlIG5lZWQN
Cj4gdG8gaGF2ZSB0d28gY29waWVzIG9mIHRoZSBpbml0aWFsIGltYWdlIGluIG1lbW9yeSBhdCB0
aGUgcG9pbnQgb2YgbWVhc3VyaW5nLg0KPiANCg0KT2suIFRoaXMgc2hvdWxkIGJlIHVzZWZ1bCBm
b3IgdGhlIGV4aXN0aW5nIFZNcy4gV2XigJlsbCB0YWtlIGEgbG9vayBhdCB0aGUgZGV0YWlscy4N
Cg0KDQotLS0gDQpKdW4NCg0KDQoNCg0KDQo=
