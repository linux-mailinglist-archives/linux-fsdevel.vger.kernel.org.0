Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2005B4EA337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiC1Wt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiC1Wt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:49:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537E17F3F1;
        Mon, 28 Mar 2022 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648507692; x=1680043692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZC9USRoGPnirzpRVYJ1tp3SP0XczhjHQfane2vzN1mY=;
  b=Sc3dH9cFiKdbnNZarHvFZw03WdtkMKDU5I8SHmmhIuU+YhfYm18ki0QI
   SmoHl49FQdxWNw3KF3DjBZKGxJkH+bP+iSu6RlZVFwoKTF9QpVLyisu8d
   HBfElGEGVrJvbfjtAZUqUvcy0+A2jw1i3O43aTUHK45SYfx6Etv5rANij
   I9ux54mSgWMz+tMaYzxnbEAW9vRFJ9VEmyPAWEQ5jgiGhyDVLWUsNNtGp
   CPVORMspIC800d24qGtS74fB8kFPMiOpstap3FcEzQYgl6OP1A4Ksw/na
   eXsvNqm5397jwhJ29Q8SwI/ROQZ7QVDEAvwhB7mCwSeN3CVrzHxoiw4r7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259303681"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="259303681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="502682295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 15:48:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 15:48:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 15:48:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 15:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf4sHM4EChQ3kc6HcOVjGubBJ86TI0n9R1mKg/iNc6Seufej9GsAVjWJzaiHnrJuwssBngXJCzamyrLy4wzub4U8OXm8tvU1U/OOYM9qBMcRE0X4CMXiybDDwvbGPxxPt4mnUn8MujNsRITd1P02NHMyYWxol3DgwV0Y6qaSzNlnLsAljaFArrC27Tj/6KNscr89qoXuYouXryVL9nB/UhGRtDjCQm+sCCPt1/1JMe7EPJA0FUFC5ra5c57b+j+iCVe05t5XPF5B5PmfHrqrdxAA8CwRtsvsCbm/OmRiB9o4unKwX2JubZxSHbcuXSCa+tQ2HayCGiLqtvRvGdMWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9USRoGPnirzpRVYJ1tp3SP0XczhjHQfane2vzN1mY=;
 b=agn8Z4YmidZz84MFI3w61hAcYfEQNRJnUtG4enhAjhVtRULtlWFNbIcQqEXqzVi2QHn9fpfp1EYzJQaa5E97uaV4IoJvA2cLUAzDGxyZ6gNlBAgDoaRNptamOIIhbCNbxXksHKAAeAtGnPaFuSTSQAKdhLxsEBnIu42m8rGgFv5yLf2SZN/gd5Gnf5D7ii/yBnBzsONF6+S9IdQuMzoG2QCGBxMhn6sM6nyMhkY+9RNalN2qQpc8lGJwtvAaFEKnSmsfx5Qi4bF2oxTOYJSm/vM+QgfuEWztyY1GSDcW8tjKaW9zAC6D7yqHEq4tw3IHFibYeLj0228Nmr723IX7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by MWHPR11MB1391.namprd11.prod.outlook.com (2603:10b6:300:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 22:48:09 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::7c02:2f27:bd12:4b90]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::7c02:2f27:bd12:4b90%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 22:48:08 +0000
From:   "Nakajima, Jun" <jun.nakajima@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>
CC:     Chao Peng <chao.p.peng@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Thread-Topic: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Thread-Index: AQHYNIh+ptDATuLcJUiff48Z+IxILqzVWHAAgAAqTQA=
Date:   Mon, 28 Mar 2022 22:48:08 +0000
Message-ID: <7CCE5220-0ACF-48EE-9366-93CABDA91065@intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
In-Reply-To: <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bee5dda-6696-4d60-0c03-08da110d07d1
x-ms-traffictypediagnostic: MWHPR11MB1391:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB13915CD989F91199BDF81FFE9A1D9@MWHPR11MB1391.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xk1nx33NvzVeKCuVjNkl3mT21pZbOcdQgC6mxERFaKliLJQrkuWPP02LMuHb+BVEZOjIshEbIuxG9JZl/L/yDKKkvd/bK5quVF70JpafyRNuzMVh4pPueFRNy42oyDIw4gp74455K+iis3vhYnc0xs3Soe06rj3XnSjNsBHMidzVO5+yL9AMYX7vv79zK7c76QqjCK7hgO7v9UFcQIbN+tnzQuLopAHKU8tBHWj2ZI+uYoFNLIMZNGdwx3sJKQIquOEmWytGLUKSqjQWeBmOr5Y4njDaNAYS9HZ7n2HB+EIr0M2k2R8dCj+nF5YAGZw9DYkl6/9FfNfq6FlO5YWYpk+VPd5W0RFbmI5XUI9O8tV0DHTAUPJlzdMevN4LjJhX6K1l/ZCAfUjIu20u5me/1kGIbf+yJGv9c+kF7eWnsC29pX7wyHgTvClCX9/SEhThOF6xfSlvoqxyloU9f3QatadvRuZFj319cOgAYU2csjCqKNhn1Hewt4VqkiMfMf+X8r6NSIFmEdanoDSGWkxLsiM2YO37KPuUnhPuzJQKUj+LJEE7Q524rwxdcCugrTudTgYYXXsXGsTn93fYhK9+Xfk7bgZT9lyIjL7iC8MzppsRI1+OObEotGgZSS4J2Ret+ibsiEc88hI4ncI32Zq3x8LHb1G1nYcjLZjkpphG08eJWV3dxBWTXxjQJjXfm3WJ0RgMdxPKoF2Rp/dop1sG73hdX2IAabosE+LEa1zEJq+pZOdNTIhVBJBqXX0eF39V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(76116006)(86362001)(2906002)(82960400001)(38100700002)(66476007)(38070700005)(8936002)(8676002)(66446008)(66556008)(66946007)(7416002)(7406005)(64756008)(4744005)(5660300002)(6506007)(186003)(2616005)(122000001)(33656002)(316002)(508600001)(6512007)(53546011)(71200400001)(4326008)(36756003)(6916009)(83380400001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JZMnNiWXZWMGpZUVhaS2FXMXdNeUM4bjZRS29KeUJ2cHpWWXkyL0NaMy81?=
 =?utf-8?B?clcwcHllOXl1bVdLeXRZd3Jqa2FsVStBQ09YSTRDYmJvWDlEYmxCZTV5NEtl?=
 =?utf-8?B?dytxcm90ZytrNUpuTHRtbTRoRUZoRDhtTlJsQ3Jna3ZWOGJhbk1IUCs5dTZi?=
 =?utf-8?B?MUdzdms5MUZEUVZ2amdWeko3RFZ6OG1ZdXgxWlRlQklBNkZYMHBHTC9oOUFq?=
 =?utf-8?B?K0VMNkhseDlsOTVvNVpQWW5uWE5VS2xWR09YcktSQVJRYkJ1U1NQVE93MENG?=
 =?utf-8?B?NnJwRStkc0FpbDBaQVFGNVh4VGhjSVlQckRrYUNCSjNHOFV6RXBYTWdUUkxY?=
 =?utf-8?B?NnFQUklQMktNUTI5QmVCcXpQdzdlRm5hZ043WGFlUDNlWTZSbkVIYWZ2bWhP?=
 =?utf-8?B?RnowelVYSmxwbmgvOVYwbERMcHdtWFpqNG5wRnROVk1vV0pkRXBDc1NyaUEx?=
 =?utf-8?B?b09JM1ZhWCt1dnNuSlpUc0xUSldOUmR2alpsbm1PYlBSUU8xdkVBalR2Y3J2?=
 =?utf-8?B?a3VSdk5OeTNqVzhkOTdQM2JZZ3I4dDQyZjVzQkZsckoyM2lUL05rQTVzdG1a?=
 =?utf-8?B?ZUxiR3pkWEpzcmsxY0RJR0ZiZW9STElXdDlTTDcyTy9NYS9DRFhZbWs2alZh?=
 =?utf-8?B?SkFEOGEzaHRhVUt5a0VNMjlnZUVTWkQ1azlPOGh0TGNWdjZOeWd0cXBMN3o2?=
 =?utf-8?B?SFdiVDdtNkdxdHVZeVJZc3NoL1daOWdKbVRwWmd2cTdQZlhlZlBrS0ZrMHVD?=
 =?utf-8?B?aE1RY0loUHRueFY4SjF1dGVzcTk1KzBYbGJsdWFzMUJEL0Vjd2RBZjdyY2Zr?=
 =?utf-8?B?R045Uk0vTnNMbmlzZTJXSTkyK1g5S1VFaWpOSFVweWhnNFptSEVEQ3ppRVhx?=
 =?utf-8?B?WldzMlVQODJJdUZ2UkdPdjV1clBCVTVyV1c3OTlPczdHT2pHZFl5bG81ci9C?=
 =?utf-8?B?MUgzeGtGeG0vTDRaZVBhSkF1R1BnTExlUjRCTk4wcFlkdFJwRlU1dHQyclk3?=
 =?utf-8?B?c29SaVE0R2pNdng0YyttRU5jWmliY0Q1eUhLb282RU5sVU9YSnZ5OFpScmc1?=
 =?utf-8?B?ZWZ4SjcxS09LL0lpcXN4ZXN5Y1Q1Vi9ZUW1Gcy9HWGJ2dDVRYmJwM3pLZ1Rs?=
 =?utf-8?B?VkozbTV3eUhzdS9kNXAzdENrTEFaTENDOS9aNWxzTmV0azNUc01jdHJZbmhm?=
 =?utf-8?B?RC8yMUgrV3JLb2NPOVpORll0VVJqaGZVa0Zod1Z0Y1ZYMzI2M3VDa3pMV1pU?=
 =?utf-8?B?d01jUy9jY3c5d1VGRzhWQmtYTkowdGFKcmdsaFYxQXptV01RT3NpdjdnRGlv?=
 =?utf-8?B?T3JoOWQ5c045dU96SjdXMG1LNHJDZmRtMXlMaDNVVkZ0eU5xY053VTdBMTdn?=
 =?utf-8?B?dkViZHRseXRsV3dyOU94Mjd2cXFtSi9EL050eVlnaWNZMVpPNU1ZQkcrSndS?=
 =?utf-8?B?QkM2WTZuRCtOSFFPMjBIMVZuQ2lKbUkwVUZyd1pQMVZtYktmWDFvOWdIWkNL?=
 =?utf-8?B?Y01va3FpNWpMNVRLbENkbWIxSStIRjhmaTdSNFNsdUp5YWtLOFJKdGVETzR6?=
 =?utf-8?B?elVpOHcxaCsrL0NiM1lmMDhvOUlEaytscXNDZzJ6MEQxMlFmN1VGVkdtRTA2?=
 =?utf-8?B?aUl6alRlaWRhcE9TVXB5dnByb21kQm5panR1aWlFY284dy8ySncyaUJLYmps?=
 =?utf-8?B?Y3Jtd1dKQ0ZYZE9xMUsrb0U5TzBUR3V1Mks2R0pNSEhya2V5c0dOV1ZHazFE?=
 =?utf-8?B?K1BqUHNXSmJ0U0Y4NmZSM2hlRGV1Q2VtajdCZThJUHYreGdEMU1Valh2allC?=
 =?utf-8?B?bDlMUTVrMk5aN3V6UnVzYTE3TDZlam05TGpHS1FvN01ZRHNnOGI1bitleHo4?=
 =?utf-8?B?M1dJS2h5YUVTMEJPOXJqVkYyY2lUOUJ2dzlSRTlJT2NJSERuTDJaL01tWW9w?=
 =?utf-8?B?M3V2SERyOFl2V3JxQnBPVjMrRVVYVXA1MTNxaXlwTWtaTjdrQlAvMk9ieDQz?=
 =?utf-8?B?MGg2TVQ2N0NaeWx6VHg1MzNZRCtNWmtWMVVkZjhlaG1VOEI3YW5keEpHNzhw?=
 =?utf-8?B?SHVTMXRQbFVjaCtqRXhlanRsSHA1aENFTFdvNDA4SDZBUlBQUWFBcFIrbERS?=
 =?utf-8?B?VTd5aFJ4STFweWtLWlBCYnV2QnJOdEViTlZiMk1YNEZ1L2hMeStWdnRPTUFt?=
 =?utf-8?B?SmRWcU10SDV2cUNzMFJsVjFINjJDVXZ1MVFhRDZDU1dOenROcHBENWZXQ1A2?=
 =?utf-8?B?TGJvTEdVM0JQbVg5c2lqd2dQYWUzT1c0Wno5eXR1RVpnN2lUbDliM2NBVURw?=
 =?utf-8?B?MXh0YkVPc1ZndGFEb3BBTzQyR0l2UXc2YmQ0U1lJNytzWTdvQTF2dzVud2pM?=
 =?utf-8?Q?qcEsjMxs20XWAfdTR6F9GK4Mqx0cQmL1grF3EDatdLkvk?=
x-ms-exchange-antispam-messagedata-1: 9GAOVr2EhDJY/E6tH4lh4wtlrcXlI5rGCM8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FB2428F2C7DA04AB1C7EC70E5CBA7C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bee5dda-6696-4d60-0c03-08da110d07d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 22:48:08.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ajXcW/ZobgPr7c4/NTn8GG2bPDlrX943cpuhJzz1ZaXvVHCWYyh957Jgt0l82fT3ia8fgTq9pr7+cEZfZeDqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1391
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBNYXIgMjgsIDIwMjIsIGF0IDE6MTYgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWFyIDEwLCAyMDIyIGF0IDY6MDkgQU0gQ2hh
byBQZW5nIDxjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4gDQo+PiBUaGlz
IGlzIHRoZSB2NSBvZiB0aGlzIHNlcmllcyB3aGljaCB0cmllcyB0byBpbXBsZW1lbnQgdGhlIGZk
LWJhc2VkIEtWTQ0KPj4gZ3Vlc3QgcHJpdmF0ZSBtZW1vcnkuIFRoZSBwYXRjaGVzIGFyZSBiYXNl
ZCBvbiBsYXRlc3Qga3ZtL3F1ZXVlIGJyYW5jaA0KPj4gY29tbWl0Og0KPj4gDQo+PiAgZDUwODk0
MTZiN2ZiIEtWTTogeDg2OiBJbnRyb2R1Y2UgS1ZNX0NBUF9ESVNBQkxFX1FVSVJLUzINCj4gDQo+
IENhbiB0aGlzIHNlcmllcyBiZSBydW4gYW5kIGEgVk0gYm9vdGVkIHdpdGhvdXQgVERYPyAgQSBm
ZWF0dXJlIGxpa2UNCj4gdGhhdCBtaWdodCBoZWxwIHB1c2ggaXQgZm9yd2FyZC4NCj4gDQo+IOKA
lEFuZHkNCg0KU2luY2UgdGhlIHVzZXJzcGFjZSBWTU0gKGUuZy4gUUVNVSkgbG9zZXMgZGlyZWN0
IGFjY2VzcyB0byBwcml2YXRlIG1lbW9yeSBvZiB0aGUgVk0sIHRoZSBndWVzdCBuZWVkcyB0byBh
dm9pZCB1c2luZyB0aGUgcHJpdmF0ZSBtZW1vcnkgZm9yICh2aXJ0dWFsKSBETUEgYnVmZmVycywg
Zm9yIGV4YW1wbGUuIE90aGVyd2lzZSwgaXQgd291bGQgbmVlZCB0byB1c2UgYm91bmNlIGJ1ZmZl
cnMsIGkuZS4gd2Ugd291bGQgbmVlZCBjaGFuZ2VzIHRvIHRoZSBWTS4gSSB0aGluayB3ZSBjYW4g
dHJ5IHRoYXQgKGkuZS4gYWRkIG9ubHkgYm91bmNlIGJ1ZmZlciBjaGFuZ2VzKS4gV2hhdCBkbyB5
b3UgdGhpbms/DQoNClRoYW5rcywNCi0tLSANCkp1bg0KDQoNCg==
