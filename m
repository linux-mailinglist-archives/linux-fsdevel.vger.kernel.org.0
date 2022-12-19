Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA06508CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiLSItL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 03:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiLSIs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:48:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F2C753;
        Mon, 19 Dec 2022 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671439703; x=1702975703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KIpCFhQ0U/3ODsKmybGnumRtoiorSkib4N9ykDJCKXY=;
  b=ZUd/NjQDnjhq7Vo5qM87H3OARXfiSt0ohzL+GEXFfhQcHMGpFc2d49h3
   RQfX13V9M8e2ida6SG+Q5a/QUmcv167kmWJeNloIRIt+hmW8zGAyakpBk
   aoEi6x4x7yvfmISHoB+178jy4nGeeHkYgFCM3uic1ILm48218H6pKUC0I
   y+OJvrYXaChYvKh65vC5QLpOoj7xtc34IwYJLnrKNO7XwOeVHfSChStwp
   34hE0vZX6sCbu0/gaQay78OqAvWuSf4TZ6m5siLskf/t4paa9lhtx//TY
   tFjW58aNZSSu6L0898l6YcRMCJkXHjXlY8jHq02IH2Fa0pI+ExEzFA3NX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="299633408"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299633408"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 00:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="979310872"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979310872"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 00:48:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 19 Dec 2022 00:48:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 19 Dec 2022 00:48:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 19 Dec 2022 00:48:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJZb/uYCC/xzRs/KsL2k9BToKwZDo8dEKoim2Le9SFI2pFrEJFR16gun/7VTVRfolHi6H0GC96S/SK9Nq1G1IrtOnEd2VfKIU+FRY0VJgGhOc8+xzJWAmSn7aPfljL7QKC4o9zk588dgS8jaD6eNvw9eCoXzTIsKtNSTBI2F4aB7lkzVE/iEYmD1p6W7/gRAXEfNVlYO2hpeA6OMp/H4YTCuziBqEFc3iroFMVgniKvW2+5eC6OMM3ra0qT0bI2Vu23bTbEYuzOonBcbrc6IZm9kD5teNDAULDjq6o0iOJ74h/wgnVKicHNFAHtosZax4/xAGt41DYFxif25I/MQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIpCFhQ0U/3ODsKmybGnumRtoiorSkib4N9ykDJCKXY=;
 b=a2uT3DwAcEPV6zGnHeFo2sLFyWb/MRBh0U/jaFW9auXc+lX0i1lewMgs6dSgeTvyeamxjYmJ1K99cgjDoT4ebmFHgsZgbiIKHEEbBGTANGbUlM1gVnkOLv1AKqxnd7nI5aW60LVifWj0yr2HkkZSuaPSfW14pb0SxRuaE/POV4h8xFj7C/FSWHEECJhAT2IZRm0FFET0WrgWhH++kS4RvB4/jl4nRgvebniJgjoAWD+Zk0yqA/ni6pa/R+ndd8ynMz8sC5bATjjGSzjx4s8fQupYKU4u9tOu12vmXSJuqb3mGNTGYM4xztOibcU6dpEIVddQoidPGVM9qrM5189ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM8PR11MB5590.namprd11.prod.outlook.com (2603:10b6:8:32::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Mon, 19 Dec 2022 08:48:10 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 08:48:10 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "tabba@google.com" <tabba@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Topic: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Index: AQHZBhXuq53UEB1w4kqtU0OzCkPOIq5sjtQAgAhi5ICAAA9XAA==
Date:   Mon, 19 Dec 2022 08:48:10 +0000
Message-ID: <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
         <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
         <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
         <20221219075313.GB1691829@chaop.bj.intel.com>
In-Reply-To: <20221219075313.GB1691829@chaop.bj.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM8PR11MB5590:EE_
x-ms-office365-filtering-correlation-id: b88aee26-950f-4ac1-8c1a-08dae19dc1cb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRNansXIR21dnZ2lK91763rjv27mUNOucl5axHk4NwEEDt7ZmpCJ+E0eA/fSqolIadNaGkvXU5BL1jgLNmEb7n/VYveCHe+1oX5zAv1pqQtLHnDL5yVV93LVnn2Ij1NtZWLYBYv1PukqlLmmxw7APOMJyLzSBbnS0tDCtPxF34a44rJS6sypWRG+QWPkotRWEQORW2neiNsu5OI3QMa51TkjXyA2Du1AKQZftyAiKOczveGwhyYDB4wA6BlqD2yVPQWJR+T7196dzs0TfVpUrf6nQhUjf+08JUWrqyRtm8QccTy4pWrEExtrbgQV8NhsKPpLHQEHP1Yl5ORQL3v+qil0ROlTHAHIdcznAiMsRdEehNOYHudytniKIYDItuWRS4mYcVS4v1liyVjGIS+TyCAmA+JF2ON8eWVmG390eSyaKo61/LUQHqteLqTMbwtxSFZSIN8xBhPnxCNgqbZPaCTbi305b76Q/PmGWMYc/V5bD/U4r2Sy/+tqdUJtLRu2VW+WY1WpkkpuMjZwD5ZD+nhHiAFO0TAA1iEERZqgrWtLSJxV1FSDknXtW+s49tw5+e1OjdSynloh3OZ28xikokOHJ9A9Q9DCD67imrrirnMRxiF7FwPs7ZB7VUZT+0s08Hf0pv5S0l9ELTI3VUW8fHTgPmTupU//wsyl9TtzeWXVQzHfKITVZHKVY/SJ6066xZx6gj3IvfepQQTKjhvU3r2w7+iJ5BIp00oniazMwx4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(8676002)(5660300002)(6916009)(7406005)(7416002)(4326008)(91956017)(4001150100001)(54906003)(76116006)(66946007)(66556008)(66476007)(2906002)(64756008)(66446008)(6506007)(6486002)(71200400001)(966005)(478600001)(6512007)(26005)(186003)(41300700001)(86362001)(83380400001)(2616005)(38100700002)(82960400001)(36756003)(38070700005)(8936002)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ui9RWDhOVXpPT2JVQ3QzWkkwU3A2Sk1KQWhGTlhRMFh2dTVUNnpHZlcxdDYv?=
 =?utf-8?B?QkpKd2tBbVN1UkdmQ0xJajJyL05tWE51bTF4ZStmc21oODVmRFRHSDgvMmI5?=
 =?utf-8?B?R04rTWFwTFNFNlZYRlJKVFpodjE4YUFiaWxiZHlSeE9RZkNJZUxYQVZsWGVY?=
 =?utf-8?B?SUtZVFdUbUszZHlXL29xSU4xN1hNZXoxdGtMeUNpc2xhWnVQNjl3enNtbEpH?=
 =?utf-8?B?SHQ3NWl0clBzSUo5cG94VzJCL3FzdTRpR1JOYmw1TkhOWnJGS3NLN1czNW84?=
 =?utf-8?B?NFBIMHk4QXRhZGJwNVVmTit5MzZTbU9KT01vb2kwdStJcTV2cmJRUVpmd2ll?=
 =?utf-8?B?dVJtMGZ5Nk9SZ3R2Z1dSdm9rd3ZhUUpobTBQY0pqS0s5UlVDY0orY0k2NE1K?=
 =?utf-8?B?OE0wTm5UUThBZFFTTVMzRXRJakoxelVtZTg2U0hOeXVMajFZM3JxZThzc3lK?=
 =?utf-8?B?ZE1NVDV1Sy9VT1JBTlhpdnV4c1BPV3JxYkFuSjdiZUlpdUpKOFZJaTgybXZN?=
 =?utf-8?B?UkhWUGFNR3ZrQ0JkSm5jc3hEd2I4YkhWUTFrelRGR1FGSG41TzVUMmRld2V3?=
 =?utf-8?B?OVlMZlRKZFBua09qMHpmR0FQWERvNWoyTktBb0tVK2xlVHl5U2VrekptWENm?=
 =?utf-8?B?ZWpkTnlQOVJTZ2dQY09PTzRhSjdmQVB2TmplbmEyWGFqZFVVanExM0Zzd09G?=
 =?utf-8?B?cTFTVFdYMHZjN0ZQcDl1OFRxOEJqS3VFUjJybUtTNTRRdmR0VDNWQVM5T1VC?=
 =?utf-8?B?QU9oQlJIZXA5MGd4SnNBRXZZMW5LbGdVL2ozMGJZbDRnV3VXVnlzTUhHUU5P?=
 =?utf-8?B?czkzVGlFVXBMK3FjNC92WU1sakxUeEwxUVorcW1uTnJoRERYWnlGaldvU21W?=
 =?utf-8?B?MUJ4TFB0a3E5OVVKN2RnWVY1QkZXeDFWYWN4Um44QXhQbzBQeUFDYktOdUdK?=
 =?utf-8?B?UG1YTFZoQ01SS2RKWDNmZVRpQ29kckovaWdSa1NNVE5CeENRNFdRZ0c3UHAy?=
 =?utf-8?B?V0l3NUFKd0ZNSDc2dFlpaDFheDZrS3lYc0JlQjA2T1FETVlsODJoUHpKT01n?=
 =?utf-8?B?R21SYzYvd0t0MkdoQTB1UnpEQ2pkN2VUVHZrZmJKRlJ5ZDczcFZTdUtkeDBH?=
 =?utf-8?B?Wm9NWGFkNVM2cjExWDVaVU1XdlF4Wmg5TzlNMjN3bHdCdThqUWMxaGtqZEVR?=
 =?utf-8?B?RkpZeFRFdStsVndLREFGaUNkSU5JWlJPTW1XMitqY3FIWXdJbjdUSjl1Q3Fq?=
 =?utf-8?B?N1hKWlZWYkxUMHVIZlNzdStQVnFNK1NMNVd6NnkxZk5nSXBOY1pJTGhjdzBF?=
 =?utf-8?B?cXdMbjFWNVFSaFZienorU0doSzdIUHB6MEhWRlRIT0pQaFh6L2Q4UVZmekVk?=
 =?utf-8?B?czNKUnd4Y0hXcTMxRHcyVlB0ZUhjREszR21SaFdLSTNROXdScFRsVHV6NmZ4?=
 =?utf-8?B?S1pXVWJ2U1BvVWphbWU1c2l2SmQ5NDZrUXVIU1hFRjhxS2dLUEYwaUlscHQ4?=
 =?utf-8?B?VHJOazJ0NkwxMkZuK2ViUHVVVDk1VHBqeHRjbmdrSVNTYndrVG9BMGhTak55?=
 =?utf-8?B?LzdXaHBOWmk2TG1DYnJjc2kwbmxSMDRxeUM2WHNuVEkweWt5MkVIOUp6bmpX?=
 =?utf-8?B?MjN3RHcxVGZEYVdMTlBhVWUyRHhQTkxyOXBQNk50anpaNG1BcmxPSXZ6M3BK?=
 =?utf-8?B?WEtQeEMvM2R2ci9nbGdIdXg1QzZCS0NwN05IZXdvMWt1MFpQRU05L0VnU1Qr?=
 =?utf-8?B?UVJWbzAyL2twVlRoT3NhRVQxUUJTeDZCY2JQeTBPWXQxL3BWV3ZGaW9Fd2hK?=
 =?utf-8?B?VE9TUDJsTXNGQy91UCtXUDJpMDVZK2YyRkdGdnprWWM2S1dia1pWZzJodEFi?=
 =?utf-8?B?VUc4d3VDOE5DdVVzN0tKMjR6U0haTTFHc0F5MGhPTFR3L0IrNTNGU0JoRDA2?=
 =?utf-8?B?RDdmSXFPN2w3Q1p0YlQrMHR5THkwSXNCZWYzR0w1dzh3b2hnTGZ0ZXFxUnJh?=
 =?utf-8?B?N0lhR1dLdHlqd0JBejVFbmtIM0RtOXRIQWRSdnRhK1Z0b1hyNTlRNHhudU1a?=
 =?utf-8?B?R015TDVmdXlvcW1qRTgzZzJiaDlSbGVZRFY2R2lxWnFDRHY2ai9lYVFGSFZ5?=
 =?utf-8?B?UHc4TEFsQ1BMVWNlM1JVRVZ5TTV4SGR0QjU0WFlsbWFJM20zc29iZzRDMmxX?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7CB7BB1761BDA44B44EA3585A10144C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88aee26-950f-4ac1-8c1a-08dae19dc1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 08:48:10.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPDg1RwbaOSFnsHyby6CeQ2xLRkK/Ao2NUPXJQRQ9b8pZQz5I+abLSkv77az+kc9gDkIg+iTS6zBxtAwPV+TEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5590
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTE5IGF0IDE1OjUzICswODAwLCBDaGFvIFBlbmcgd3JvdGU6DQo+ID4g
DQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogVGhlc2Ug
cGFnZXMgYXJlIGN1cnJlbnRseSB1bm1vdmFibGUgc28gZG9uJ3QgcGxhY2UgdGhlbSBpbnRvDQo+
ID4gPiBtb3ZhYmxlDQo+ID4gPiArCSAqIHBhZ2VibG9ja3MgKGUuZy4gQ01BIGFuZCBaT05FX01P
VkFCTEUpLg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJbWFwcGluZyA9IG1lbWZkLT5mX21hcHBpbmc7
DQo+ID4gPiArCW1hcHBpbmdfc2V0X3VuZXZpY3RhYmxlKG1hcHBpbmcpOw0KPiA+ID4gKwltYXBw
aW5nX3NldF9nZnBfbWFzayhtYXBwaW5nLA0KPiA+ID4gKwkJCcKgwqDCoMKgIG1hcHBpbmdfZ2Zw
X21hc2sobWFwcGluZykgJiB+X19HRlBfTU9WQUJMRSk7DQo+ID4gDQo+ID4gQnV0LCBJSVVDIHJl
bW92aW5nIF9fR0ZQX01PVkFCTEUgZmxhZyBoZXJlIG9ubHkgbWFrZXMgcGFnZSBhbGxvY2F0aW9u
IGZyb20NCj4gPiBub24tDQo+ID4gbW92YWJsZSB6b25lcywgYnV0IGRvZXNuJ3QgbmVjZXNzYXJp
bHkgcHJldmVudCBwYWdlIGZyb20gYmVpbmcgbWlncmF0ZWQuwqAgTXkNCj4gPiBmaXJzdCBnbGFu
Y2UgaXMgeW91IG5lZWQgdG8gaW1wbGVtZW50IGVpdGhlciBhX29wcy0+bWlncmF0ZV9mb2xpbygp
IG9yIGp1c3QNCj4gPiBnZXRfcGFnZSgpIGFmdGVyIGZhdWx0aW5nIGluIHRoZSBwYWdlIHRvIHBy
ZXZlbnQuDQo+IA0KPiBUaGUgY3VycmVudCBhcGkgcmVzdHJpY3RlZG1lbV9nZXRfcGFnZSgpIGFs
cmVhZHkgZG9lcyB0aGlzLCBhZnRlciB0aGUNCj4gY2FsbGVyIGNhbGxpbmcgaXQsIGl0IGhvbGRz
IGEgcmVmZXJlbmNlIHRvIHRoZSBwYWdlLiBUaGUgY2FsbGVyIHRoZW4NCj4gZGVjaWRlcyB3aGVu
IHRvIGNhbGwgcHV0X3BhZ2UoKSBhcHByb3ByaWF0ZWx5Lg0KDQpJIHRyaWVkIHRvIGRpZyBzb21l
IGhpc3RvcnkuIFBlcmhhcHMgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IGl0IHNlZW1zIEtp
cmlsbA0Kc2FpZCBpbiB2OSB0aGF0IHRoaXMgY29kZSBkb2Vzbid0IHByZXZlbnQgcGFnZSBtaWdy
YXRpb24sIGFuZCB3ZSBuZWVkIHRvDQppbmNyZWFzZSBwYWdlIHJlZmNvdW50IGluIHJlc3RyaWN0
ZWRtZW1fZ2V0X3BhZ2UoKToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAy
MjExMjkxMTIxMzkudXNwNmRxaGJpaDQ3cXBqbEBib3guc2h1dGVtb3YubmFtZS8NCg0KQnV0IGxv
b2tpbmcgYXQgdGhpcyBzZXJpZXMgaXQgc2VlbXMgcmVzdHJpY3RlZG1lbV9nZXRfcGFnZSgpIGlu
IHRoaXMgdjEwIGlzDQppZGVudGljYWwgdG8gdGhlIG9uZSBpbiB2OSAoZXhjZXB0IHYxMCB1c2Vz
ICdmb2xpbycgaW5zdGVhZCBvZiAncGFnZScpPw0KDQpBbnl3YXkgaWYgdGhpcyBpcyBub3QgZml4
ZWQsIHRoZW4gaXQgc2hvdWxkIGJlIGZpeGVkLiAgT3RoZXJ3aXNlLCBhIGNvbW1lbnQgYXQNCnRo
ZSBwbGFjZSB3aGVyZSBwYWdlIHJlZmNvdW50IGlzIGluY3JlYXNlZCB3aWxsIGJlIGhlbHBmdWwg
dG8gaGVscCBwZW9wbGUNCnVuZGVyc3RhbmQgcGFnZSBtaWdyYXRpb24gaXMgYWN0dWFsbHkgcHJl
dmVudGVkLg0KDQo=
