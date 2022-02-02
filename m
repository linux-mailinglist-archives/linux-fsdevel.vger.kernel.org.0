Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122284A69E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 03:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiBBC2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 21:28:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:24744 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231835AbiBBC2U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643768900; x=1675304900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ISQXmQvB5FWGlq+sjuY1WVpudefCuhtIKvnBMJL4iok=;
  b=YfjfxIYtJFwF3iOULjaIxKQ8Tb4z2qw3gifgMdv0I1qShGY8zBAttTwt
   Ektj+/OEId+eZbZqNBWvnfeFcrad6k8DxVe/ZYE4otQmgH6StTf5ZPt4l
   IeXFKRsOnzj1KOC2QKO0US1iHwTSMOOU5VaX6Xty7TC00cpDQ64GLEADy
   FGIUV8hUb1WMWEk5o/QtPamK1nWHUXA8z41a+XLYplVhOTlDpauBQnc/G
   fYJiHfiyovlmAe3pof/VrlVwoLv+c6EUq3FnFVqtFJDRFkYtJcNxyZEoQ
   mn23yzqlpT3mn13ngtAIQkgaE7J/1lrGra08ld9bE7qfIVJf1flkMMklq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247786875"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247786875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 18:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="497594391"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2022 18:28:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 18:28:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 18:28:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 18:28:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e89XOIqH6D1z7JbDOBTVK/6wV+S1gXKXxdPtKfH7snSv/lnJo6jkmjwDkpj8dsiONvVf33oFQY5aiyCpkUWuMS+Tvn9qD1W2DRL2A9fUQYOC2hpIRvX9nGbp4+cnk60eQ/ENbnkQp4sku79QzUbcw9gTVM8MU2C7zQyoysH6LVorCtob6eV5GukN8mEAdUix6zUdK4tP2FZ2tbkt2Iow9vgW7T7DSqEgAK8kuqELzZDnrXBiDHmEEeqiMp0Cs9ysBK1PhkJEWbK+6MK99bgaKCA8ZxT2VB5/NDKVGsdJEq9GKDwUj4vfh8zkbvOsaJ6kfBgLKuL7JyMdEZ1uPe9zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISQXmQvB5FWGlq+sjuY1WVpudefCuhtIKvnBMJL4iok=;
 b=UFlx6ZQVOqFSDCUMCo+cQrcAj6v1CZdip6iJB1MxqZlXT2fS9WCcY37HWyDom2nh5AhWIk4FGu+qaEXxIsm7vYlk5KcY/QW0PYTJ/NHFXWYrnTrQieYq3NEOPG2F83VBAYUPiEBIWCUv+PHvRKIQ2GIGqPTlOvpiTy44KprlIynkZrc/jxnKLC7L1mF3FTAJMqst/RGFK4TthiZrHoW5IGI8kaCn9tWOzm/9GjyZEFN3nUJ/0bGXG5cJdRrsPodN0PXln8T3q6CIccsSuwB2j/01oGcGso8rxgHRlU4QFqL8vxk8e1/0/N5BsFhDx28T79jUuZxtDfDisyL0oZ77HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by BY5PR11MB4008.namprd11.prod.outlook.com (2603:10b6:a03:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:28:16 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::3499:a5f6:82d:76ad]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::3499:a5f6:82d:76ad%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:28:16 +0000
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
Thread-Index: AQHYDG5kCMt6ReoFPkCCY5N8FQOK+Kx4tJYAgAbrnYA=
Date:   Wed, 2 Feb 2022 02:28:16 +0000
Message-ID: <08A0882C-2E35-4CFD-9176-FCB6665D1F3E@intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <3326f57a-169d-8eb8-2b8b-0379c33ba7a5@arm.com>
In-Reply-To: <3326f57a-169d-8eb8-2b8b-0379c33ba7a5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c26e20a-ae3a-437c-8cd5-08d9e5f3ab8d
x-ms-traffictypediagnostic: BY5PR11MB4008:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB4008DB2E2F747221021BBBB89A279@BY5PR11MB4008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmmROuW38f0oxPRHsNtfwDAYujSU9Qk6K+Gny2nCR+4/ovmT4sYoagI8sdZE9VCZeL/K9Fqm91qgksfq5/1tCZe4BYA6Pc84YE63NCd5VEKt3g8oSxUT5CwZN+lNQHtuEHgjuFr+6LAQe3vs1UNiMgMZKOOYSSwYT0wgahA9MhXICPd/3IrnMMNUyNNKP5G5JnNNKsUTY+8JSFo/TMZ72NI0ZUdOjQxkhRCwG4ZZlOKrIRK7xtoR6XMn1kHvC9qJEd4wMejhoOURMIupxcCTg3i9wVHPWFwiakMfSOOwIKCIpGojhCXeHaC/GjoxYcIScjaao0ugwyJlkp1PI6WfHn6QTYwgS8+q8p/eSEZ+AALhM+okAZ4bkySOdHx2LwjvwCFf/hKydwm31mA7zjvRY2j/miP4CjUEhPQrIgFigGdpLa47qv3JlZ7sABY0MvIWJojTePx5v7awVumcJ+ItbHg78ONFm07ipA5ZNo8fyRfeAEknPgaTfsVsETBtkxOh8+7anKWqz7j7Hx/uOOcF3sCzK3ZslzMvSAyv1dnaVRx/+5xaoQDHpo3Zl9aNQzMGGuSvQ9JXQWSm9oj/8/1mAHKaoh3PQefAJ6s608E6BdXZOk/eFkd1zVfaiolgk0qYlgobQRYxdZ6kv/GlVA000af0VBz+2hUdbgJoNrH3zwpG8G9KG74tAOAMVwk3GOWG4vJ0kjWNWsvh6sdFxP/V0uZJarXgxmFG8bAqc+gyQtR5FiMsoF7KYK35jDXgB2Yh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(64756008)(71200400001)(8676002)(8936002)(76116006)(66446008)(66946007)(316002)(2616005)(6486002)(54906003)(508600001)(66556008)(2906002)(26005)(83380400001)(186003)(4326008)(6916009)(6512007)(86362001)(33656002)(53546011)(6506007)(7416002)(5660300002)(82960400001)(38070700005)(36756003)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE1vbDkwYTQyR3E0L0FiQTc4bGlwaW5QTGhnNVZTVnFQaFd6RUkwSVlNSlVR?=
 =?utf-8?B?MGxJSWhybVdQNmovOXdHdGxMWU05OENKQWtVYzB5bU0wZmZmTVJDWEtwYTR6?=
 =?utf-8?B?ejIwVVJ1WkhqN0poTWdOZVRYQkdpdDZMZm9TL1F1RVBVZEppdTgwM3E1NkZz?=
 =?utf-8?B?aytXbHNKanEvZWpWS2VUbmp4MENBa2hFdi9CaXcrYXIvaVJLM01iRC9hZzg4?=
 =?utf-8?B?eHNDcWVzRWtIbVZ2NWdCNC9wQU1NOFJDRmhGUXJ3N0FZeXMzejZUK0tiYnIz?=
 =?utf-8?B?SVBkRlI5amQ0Sml6ZFhLTVI3V2plem9wTWM1MElVK25UWExkajNibXFzQmlV?=
 =?utf-8?B?aVpzK1dQK014eml5NlBWY3dlekM3Vlk4S0pJVHBiMHRFSlZ3NlNFWHpQSGxF?=
 =?utf-8?B?bUVHQmQ4QWtid0Zzc1FYeFI3Skx3V1ZPUUUyeHpCUlQzaGtzQjJKbU85QWhN?=
 =?utf-8?B?U2hsTkNuaGxwV1pVUFhOVUtvS211a2Z6QzBZdWYrUkNNY1diOUVsbTlDenl6?=
 =?utf-8?B?QzNLSEt3bFhEWm1qS0tIYnBlTzlhOWJ3ODVYcHM1cGxvSFNZK2taNGRLalpW?=
 =?utf-8?B?NVpEOVd2Z0NWYXBJUUJxV2dJd0RoQ0pNT3NoSGpxYzlVWCszY3RVb3NIZFlv?=
 =?utf-8?B?aFJmN0dZbm1CRkZyWS9VaW1rcjUrZjI2N1JHSDYxb3AxdUlqUXQxSjZ1N1NS?=
 =?utf-8?B?THM2Mm1nRnNLU1AwWVhBVzNQNDRUZFZjSVRpVnNNWVhTVUROTzZyOXEwazEw?=
 =?utf-8?B?NSsvM1NDWWRYNklOdXVYQ3Y0clYzNk5hVTZyWU1rRllrczh1WEZwUE5ZbHhJ?=
 =?utf-8?B?OHdReGJOWWhrSDMzVXhBSlhVakVENmRBYUVWTEtpakIyNkJERWdOYitON2kz?=
 =?utf-8?B?dW5sVytybDl0VjYwMlNLN1VsbDFWbHZEWGJTR0hPT3gwRW5rREM3MkxZbnBQ?=
 =?utf-8?B?dk9RLzRFL0Rxc1F2UkhmUW9ndmcwZWpZTlEwc3ZlenplSk8wMmlMSjBxdWVB?=
 =?utf-8?B?Z1k5KzNQWStJQUYzcmpyVjVYeFdCZnd2VmptdWZJNndOY3BMYTloSmRQMHlV?=
 =?utf-8?B?TFh1UDJmWm55UW52VlBQQ2lybDdPOG1qTTRBemQ5K2pTYXczYnNRTGNkd0ow?=
 =?utf-8?B?VVVsT2tnWDl5U1hRa292MnBMdU00YWtxU0hjbVNzejloNGdzRGNndko1RzZr?=
 =?utf-8?B?S1Y4c1JHc2VKaTRDVnYzVHhmWFd6ZHBWV0NrRG1GeVFLYTJqOWpyOUVnWFIr?=
 =?utf-8?B?SERsOUJzbnpxSkVoVzBmNmNYcUhVSTN3SnNjeHVqR1MrVWYwUUkvcVQxdkh4?=
 =?utf-8?B?NEI1Nk42NnA0dDFaK1NsRXFUMVArR0tPWTZCZzh0bm1xd1RQOEtFY3dSemls?=
 =?utf-8?B?cHY0SDJFbFJvQ2wwdzc1YUtxbjBlY3FlY1J3aUZyYmFKRFU5NndQR0ZTU2Nm?=
 =?utf-8?B?b1QwOHBpZE5naDRjMm1Pc1dIN3RhcHRjRWRFM3NYSU5IclNSQ0FPT1dlSGdG?=
 =?utf-8?B?a2Vra2F2bWNFM3JWM25lTDVCQk14eXFSUDhsa1hzT3VsTjN3WGVxTFhxZ0dv?=
 =?utf-8?B?bU50anZDMHBOOVEyTnRMcGxyc2QrYmZMRkZlUlVFT2FWQi9JNnpsS1JyRVpq?=
 =?utf-8?B?OHVGcG5HSDV6VHVjK2lDUFlvMHRxaXFkRGdWcnV1UkFKdVIvMHlLMktVdCsx?=
 =?utf-8?B?TlpjR1FWUGR1eEJRSFlubFJJY3hBQWNicnp6RlM2dEQ2YmtBSXJvbGtqeUVD?=
 =?utf-8?B?VG9JVmZQZFJ0VFRpNVR1ZFhBdnlkVklJcDZLY3VtUldWSGMyQzdxU3M2eUpx?=
 =?utf-8?B?SGdZd3VnaGF6Ym53VllUeTF6L1pGYlNaa0NxK013MkY2WUdxZTZ6RjV6aWRo?=
 =?utf-8?B?cFB2WFY3OTRWZ25EMFNQalRlSDdKcDdncHE3cDVJTXVmL28wK1ZRVmFFWm1q?=
 =?utf-8?B?K0ZzMEFYYk5rVFNVc2srdDFOL1BnZHpUUE04a0xwZkYrNDBpR3RVT0VVaEgx?=
 =?utf-8?B?aXZBeGkzQzY1MTFpRVZmVVQySUYwN1l4Sll1NHIramdFam9UWHRoNG5SMjBE?=
 =?utf-8?B?a081RU91QzNwRmM0R3I4V09kVWIvVEoreEdqbmx1Rmg0Um9aUGtBZS9KTlFy?=
 =?utf-8?B?VUdBRit2M1ZlVFZXYnQ0TWZqV1VJM3VkeFlEOGh5ZXh2MFA0RlRyck95U0pq?=
 =?utf-8?Q?sQGvfFo2OcLd/SVK5uaD934=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5B5996FFE46E644AED72D29149E6E94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c26e20a-ae3a-437c-8cd5-08d9e5f3ab8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:28:16.6380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUqaMtaRsMvVVNNzUBDe+vaEpYBenGTiCRFr+MZeuDZ7hVXL7ZsALiSlu4jS1xdlmCbLm25t20ZmpGrQpif/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4008
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEphbiAyOCwgMjAyMiwgYXQgODo0NyBBTSwgU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJp
Y2VAYXJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxOC8wMS8yMDIyIDEzOjIxLCBDaGFvIFBlbmcg
d3JvdGU6DQo+PiBUaGlzIGlzIHRoZSB2NCBvZiB0aGlzIHNlcmllcyB3aGljaCB0cnkgdG8gaW1w
bGVtZW50IHRoZSBmZC1iYXNlZCBLVk0NCj4+IGd1ZXN0IHByaXZhdGUgbWVtb3J5LiBUaGUgcGF0
Y2hlcyBhcmUgYmFzZWQgb24gbGF0ZXN0IGt2bS9xdWV1ZSBicmFuY2gNCj4+IGNvbW1pdDoNCj4+
IA0KPj4gIGZlYTMxZDE2OTA5NCBLVk06IHg4Ni9wbXU6IEZpeCBhdmFpbGFibGVfZXZlbnRfdHlw
ZXMgY2hlY2sgZm9yDQo+PiAgICAgICAgICAgICAgIFJFRl9DUFVfQ1lDTEVTIGV2ZW50DQo+PiAN
Cj4+IEludHJvZHVjdGlvbg0KPj4gLS0tLS0tLS0tLS0tDQo+PiBJbiBnZW5lcmFsIHRoaXMgcGF0
Y2ggc2VyaWVzIGludHJvZHVjZSBmZC1iYXNlZCBtZW1zbG90IHdoaWNoIHByb3ZpZGVzDQo+PiBn
dWVzdCBtZW1vcnkgdGhyb3VnaCBtZW1vcnkgZmlsZSBkZXNjcmlwdG9yIGZkW29mZnNldCxzaXpl
XSBpbnN0ZWFkIG9mDQo+PiBodmEvc2l6ZS4gVGhlIGZkIGNhbiBiZSBjcmVhdGVkIGZyb20gYSBz
dXBwb3J0ZWQgbWVtb3J5IGZpbGVzeXN0ZW0NCj4+IGxpa2UgdG1wZnMvaHVnZXRsYmZzIGV0Yy4g
d2hpY2ggd2UgcmVmZXIgYXMgbWVtb3J5IGJhY2tpbmcgc3RvcmUuIEtWTQ0KPj4gYW5kIHRoZSB0
aGUgbWVtb3J5IGJhY2tpbmcgc3RvcmUgZXhjaGFuZ2UgY2FsbGJhY2tzIHdoZW4gc3VjaCBtZW1z
bG90DQo+PiBnZXRzIGNyZWF0ZWQuIEF0IHJ1bnRpbWUgS1ZNIHdpbGwgY2FsbCBpbnRvIGNhbGxi
YWNrcyBwcm92aWRlZCBieSB0aGUNCj4+IGJhY2tpbmcgc3RvcmUgdG8gZ2V0IHRoZSBwZm4gd2l0
aCB0aGUgZmQrb2Zmc2V0LiBNZW1vcnkgYmFja2luZyBzdG9yZQ0KPj4gd2lsbCBhbHNvIGNhbGwg
aW50byBLVk0gY2FsbGJhY2tzIHdoZW4gdXNlcnNwYWNlIGZhbGxvY2F0ZS9wdW5jaCBob2xlDQo+
PiBvbiB0aGUgZmQgdG8gbm90aWZ5IEtWTSB0byBtYXAvdW5tYXAgc2Vjb25kYXJ5IE1NVSBwYWdl
IHRhYmxlcy4NCj4+IA0KPj4gQ29tcGFyaW5nIHRvIGV4aXN0aW5nIGh2YS1iYXNlZCBtZW1zbG90
LCB0aGlzIG5ldyB0eXBlIG9mIG1lbXNsb3QgYWxsb3dzDQo+PiBndWVzdCBtZW1vcnkgdW5tYXBw
ZWQgZnJvbSBob3N0IHVzZXJzcGFjZSBsaWtlIFFFTVUgYW5kIGV2ZW4gdGhlIGtlcm5lbA0KPj4g
aXRzZWxmLCB0aGVyZWZvcmUgcmVkdWNlIGF0dGFjayBzdXJmYWNlIGFuZCBwcmV2ZW50IGJ1Z3Mu
DQo+PiANCj4+IEJhc2VkIG9uIHRoaXMgZmQtYmFzZWQgbWVtc2xvdCwgd2UgY2FuIGJ1aWxkIGd1
ZXN0IHByaXZhdGUgbWVtb3J5IHRoYXQNCj4+IGlzIGdvaW5nIHRvIGJlIHVzZWQgaW4gY29uZmlk
ZW50aWFsIGNvbXB1dGluZyBlbnZpcm9ubWVudHMgc3VjaCBhcyBJbnRlbA0KPj4gVERYIGFuZCBB
TUQgU0VWLiBXaGVuIHN1cHBvcnRlZCwgdGhlIG1lbW9yeSBiYWNraW5nIHN0b3JlIGNhbiBwcm92
aWRlDQo+PiBtb3JlIGVuZm9yY2VtZW50IG9uIHRoZSBmZCBhbmQgS1ZNIGNhbiB1c2UgYSBzaW5n
bGUgbWVtc2xvdCB0byBob2xkIGJvdGgNCj4+IHRoZSBwcml2YXRlIGFuZCBzaGFyZWQgcGFydCBv
ZiB0aGUgZ3Vlc3QgbWVtb3J5LiANCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBpdCB3aWxsIGJlIHVz
ZWZ1bCBmb3IgQXJtJ3MgQ29uZmlkZW50aWFsIENvbXB1dGUNCj4gQXJjaGl0ZWN0dXJlIChDQ0Ep
IHRvbyAtIGluIHBhcnRpY3VsYXIgd2UgbmVlZCBhIHdheSBvZiBlbnN1cmluZyB0aGF0DQo+IHVz
ZXIgc3BhY2UgY2Fubm90ICd0cmljaycgdGhlIGtlcm5lbCBpbnRvIGFjY2Vzc2luZyBtZW1vcnkg
d2hpY2ggaGFzDQo+IGJlZW4gZGVsZWdhdGVkIHRvIGEgcmVhbG0gKGkuZS4gcHJvdGVjdGVkIGd1
ZXN0KSwgYW5kIGEgbWVtZmQgc2VlbXMgbGlrZQ0KPiBhIGdvb2QgbWF0Y2guDQoNCkdvb2QgdG8g
aGVhciB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsIGZvciBBUk3igJlzIENDQSBhcyB3ZWxsLg0KDQo+
IA0KPiBTb21lIGNvbW1lbnRzIGJlbG93Lg0KPiANCj4+IG1tIGV4dGVuc2lvbg0KPj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+PiBJbnRyb2R1Y2VzIG5ldyBGX1NFQUxfSU5BQ0NFU1NJQkxFIGZv
ciBzaG1lbSBhbmQgbmV3IE1GRF9JTkFDQ0VTU0lCTEUNCj4+IGZsYWcgZm9yIG1lbWZkX2NyZWF0
ZSgpLCB0aGUgZmlsZSBjcmVhdGVkIHdpdGggdGhlc2UgZmxhZ3MgY2Fubm90IHJlYWQoKSwNCj4+
IHdyaXRlKCkgb3IgbW1hcCgpIGV0YyB2aWEgbm9ybWFsIE1NVSBvcGVyYXRpb25zLiBUaGUgZmls
ZSBjb250ZW50IGNhbg0KPj4gb25seSBiZSB1c2VkIHdpdGggdGhlIG5ld2x5IGludHJvZHVjZWQg
bWVtZmlsZV9ub3RpZmllciBleHRlbnNpb24uDQo+IA0KPiBGb3IgQXJtIENDQSB3ZSBhcmUgZXhw
ZWN0aW5nIHRvIHNlZWQgdGhlIHJlYWxtIHdpdGggYW4gaW5pdGlhbCBtZW1vcnkNCj4gY29udGVu
dHMgKGUuZy4ga2VybmVsIGFuZCBpbml0cmQpIHdoaWNoIHdpbGwgdGhlbiBiZSBtZWFzdXJlZCBi
ZWZvcmUNCj4gZXhlY3V0aW9uIHN0YXJ0cy4gVGhlICdvYnZpb3VzJyB3YXkgb2YgZG9pbmcgdGhp
cyB3aXRoIGEgbWVtZmQgd291bGQgYmUNCj4gdG8gcG9wdWxhdGUgcGFydHMgb2YgdGhlIG1lbWZk
IHRoZW4gc2VhbCBpdCB3aXRoIEZfU0VBTF9JTkFDQ0VTU0lCTEUuDQoNCkFzIGZhciBhcyBJIHVu
ZGVyc3RhbmQsIHdlIGhhdmUgdGhlIHNhbWUgcHJvYmxlbSB3aXRoIFREWCwgd2hlcmUgYSBndWVz
dCBURCAoVHJ1c3QgRG9tYWluKSBzdGFydHMgaW4gcHJpdmF0ZSBtZW1vcnkuIFdlIHNlZWQgdGhl
IHByaXZhdGUgbWVtb3J5IHR5cGljYWxseSB3aXRoIGEgZ3Vlc3QgZmlybXdhcmUsIGFuZCB0aGUg
aW5pdGlhbCBpbWFnZSAocGxhaW50ZXh0KSBpcyBjb3BpZWQgdG8gc29tZXdoZXJlIGluIFFFTVUg
bWVtb3J5IChmcm9tIGRpc2ssIGZvciBleGFtcGxlKSBmb3IgdGhhdCBwdXJwb3NlOyB0aGlzIGxv
Y2F0aW9uIGlzIG5vdCBhc3NvY2lhdGVkIHdpdGggdGhlIHRhcmdldCBHUEEuDQoNClVwb24gYSAo
bmV3KSBpb2N0bCBmcm9tIFFFTVUsIEtWTSByZXF1ZXN0cyB0aGUgVERYIE1vZHVsZSB0byBjb3B5
IHRoZSBwYWdlcyB0byBwcml2YXRlIG1lbW9yeSAoYnkgZW5jcnlwdGluZykgc3BlY2lmeWluZyB0
aGUgdGFyZ2V0IEdQQSwgdXNpbmcgYSBURFggaW50ZXJmYWNlIGZ1bmN0aW9uIChUREguTUVNLlBB
R0UuQUREKS4gVGhlIGFjdHVhbCBwYWdlcyBmb3IgdGhlIHByaXZhdGUgbWVtb3J5IGlzIGFsbG9j
YXRlZCBieSB0aGUgY2FsbGJhY2tzIHByb3ZpZGVkIGJ5IHRoZSBiYWNraW5nIHN0b3JlIGR1cmlu
ZyB0aGUg4oCcY29weeKAnSBvcGVyYXRpb24uDQoNCldlIGV4dGVuZGVkIHRoZSBleGlzdGluZyBL
Vk1fTUVNT1JZX0VOQ1JZUFRfT1AgKGlvY3RsKSBmb3IgdGhlIGFib3ZlLiANCg0KPiANCj4gSG93
ZXZlciBhcyB0aGluZ3Mgc3RhbmQgaXQncyBub3QgcG9zc2libGUgdG8gc2V0IHRoZSBJTkFDQ0VT
U0lCTEUgc2VhbA0KPiBhZnRlciBjcmVhdGluZyBhIG1lbWZkIChGX0FMTF9TRUFMUyBoYXNuJ3Qg
YmVlbiB1cGRhdGVkIHRvIGluY2x1ZGUgaXQpLg0KPiANCj4gT25lIHBvdGVudGlhbCB3b3JrYXJv
dW5kIHdvdWxkIGJlIGZvciBhcm02NCB0byBwcm92aWRlIGEgY3VzdG9tIEtWTQ0KPiBpb2N0bCB0
byBlZmZlY3RpdmVseSBtZW1jcHkoKSBpbnRvIHRoZSBndWVzdCdzIHByb3RlY3RlZCBtZW1vcnkg
d2hpY2gNCj4gd291bGQgb25seSBiZSBhY2Nlc3NpYmxlIGJlZm9yZSB0aGUgZ3Vlc3QgaGFzIHN0
YXJ0ZWQuIFRoZSBkcmF3YmFjayBpcw0KPiB0aGF0IGl0IHJlcXVpcmVzIHR3byBjb3BpZXMgb2Yg
dGhlIGRhdGEgZHVyaW5nIGd1ZXN0IHNldHVwLg0KDQpTbywgdGhlIGd1ZXN0IHBhZ2VzIGFyZSBu
b3QgZW5jcnlwdGVkIGluIHRoZSByZWFsbT8NCg0KSSB0aGluayB5b3UgY291bGQgZG8gdGhlIHNh
bWUgdGhpbmcsIGkuZS4gS1ZNIGNvcGllcyB0aGUgcGFnZXMgdG8gdGhlIHJlYWxtLCB3aGVyZSBw
YWdlcyBhcmUgYWxsb2NhdGVkIGJ5IHRoZSBiYWNraW5nIHN0b3JlLiBCdXQsIHllcywgaXQgd2ls
bCBoYXZlIHR3byBjb3BpZXMgb2YgdGhlIGRhdGEgYXQgdGhhdCB0aW1lIHVubGVzcyBlbmNyeXB0
ZWQuIC4NCg0KPiANCj4gRG8geW91IHRoaW5rIHRoaW5ncyBjb3VsZCBiZSByZWxheGVkIHNvIHRo
ZSBGX1NFQUxfSU5BQ0NFU1NJQkxFIGZsYWcNCj4gY291bGQgYmUgc2V0IGFmdGVyIGEgbWVtZmQg
aGFzIGJlZW4gY3JlYXRlZCAoYW5kIHBhcnRpYWxseSBwb3B1bGF0ZWQpPw0KPiANCg0KSSB0aGlu
ayBGX1NFQUxfSU5BQ0NFU1NJQkxFIGNvdWxkIGJlIGRlZmVycmVkIHRvIHRoZSBwb2ludCB3aGVy
ZSBtZWFzdXJlbWVudCBvZiB0aGUgaW5pdGlhbCBpbWFnZSBpcyBkb25lICh3ZSBjYWxsIOKAnGJ1
aWxkLXRpbWXigJ0gbWVhc3VyZW1lbnQgaW4gVERYKS4gRm9yIGV4YW1wbGUsIGlmIHdlIGFkZCBh
IGNhbGxiYWNrIHRvIGFjdGl2YXRlIEZfU0VBTF9JTkFDQ0VTU0lCTEUgYW5kIEtWTSBjYWxscyBp
dCBiZWZvcmUgc3VjaCB0aGUgbWVhc3VyZW1lbnQgdGltZSwgZG9lcyB0aGF0IHdvcmsgZm9yIHlv
dT8NCg0KLS0tIA0KSnVuDQoNCg0KDQo=
