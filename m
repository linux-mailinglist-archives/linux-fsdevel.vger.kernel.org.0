Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B37583B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGRRpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGRRpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:45:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153110CB;
        Tue, 18 Jul 2023 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689702306; x=1721238306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sBawMFTGIK3dGjHnp/GnKmFmHTAupYWsrArXd1gWd7A=;
  b=Pd7c9h7PSMiMQjB1WhacZwNi22oTWeLPpz4F+C2TAydbEmC7zrdnJ4y1
   ylLAnF/vEfqCwJwvA3i3IhjnawHW8BPQJiKhCR11UK1usu4sEqIPKGyiy
   DNquTfqqJm8JHs/+OPLOB6SmWbJT/nz/K4Hr9HLxlfKLq+FpO3Jp4lk93
   X+7Bmcn1IaxsRdITEera5MhSexVMPu1jxEMVti/+LILBTc6WJNUmrUv+D
   dGWR0Nrx7cC9M8NMfma7dWZvOdv5wjjBOkuSlVGl2wxPCcZJQt8vA01yG
   GV9717bek0AU35K1x0iXcCrS6c/SLaAkZXnoT+RuIth82xGciCav2mhw9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="363731388"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="363731388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="758875997"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="758875997"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 10:45:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:45:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 10:45:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 10:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg6NTNMBipMxGRxh2JbIJHj4KTxlBSlEn9nxWJFdzjG2I8UpC1QDe9Ok0pbbFjJGxVONrmTL2G2ox694G4whI9LGnO5OSr4q68gSfwOdMZeCqbrpB7u8ndkIfNkwNrPxgNkdJVk+Ii6UyNkTRuTSOAdOVPqUPI+yM9vSatMqsDPahq9jkl+h0v514iD21HRDkvqgtC+1cvxCi38nwlujkiwPqAverz+nTZi2WMTFmBFeyEujKcchJi6b9PZDXYI0EneqvLOBWw1p6o95kq/3Lpd8qWpHARFI3Upu3IkkxU1KREXsugtl0Z+aabf1TXLL5IP0wGNhio6E84j44t6rNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBawMFTGIK3dGjHnp/GnKmFmHTAupYWsrArXd1gWd7A=;
 b=F71LMT+NMiAa8PSStjZkpChErefFPYLoU3JURYtDAfZjr/PgAa8yFnWDnnyfhVSMwMOopt8ZSUYODj5N+VsuH7MyKl20Ts3M4Sh42c/4ZWCEoq9WzGT0HBjeQApFeIIuT/AuSkxtNSlXi068hHVhy8A13IFxAZPF1mXB5Fv2KIundZNk5xLlpl7llogqrXw4cdnb+s/wsKlJl2YH/WuDGTTXcqFv43LcycuAdGZoy+u0PgyFV7tSWHCWOojAlHUR38t6TkjOeRSIJujWFP04+VTeBX9Sk4lEImq5HN6x668A9dQ0hK+Vant526BvfMObIlm+f0MssjsgRKBx00V9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 17:45:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:45:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 01/35] prctl: arch-agnostic prctl for shadow stack
Thread-Topic: [PATCH 01/35] prctl: arch-agnostic prctl for shadow stack
Thread-Index: AQHZuC/m8ItEgkm5BUidWdt+ZrJJgq+/zsYA
Date:   Tue, 18 Jul 2023 17:45:01 +0000
Message-ID: <3185fa6c37e54d26d66cd0e87e74fb5492399d78.camel@intel.com>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
         <20230716-arm64-gcs-v1-1-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-1-bf567f93bba6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB5550:EE_
x-ms-office365-filtering-correlation-id: 10d2d7f7-cc94-4ae6-10be-08db87b6b683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p4Lq9bAIh4d1Y0rwMtjFsbS0/XxLOPeNb7+rOVBpLSoJHEA1nUEOjW4mzE3uhmT5pgh/RIkvlcCkkExItaIboO5ofDJWyxMx4g/QYpBfa8310HkvkNi9Eip4IC3y/M60UQF+jrifuX/Lf2Bms03arTBG3r1Q8/lsHnqROJKfZ7RSQ9XUyVv6D+OeKYxwdMLcKjrsCn9FsjzyAAKL32tcnv6vIwWVb1W14YxQ6G6K26ocjTGumThnhIHhRuKzD0y1XQ/Kv1kk6Kpi0JRMxpV30sEojuU//vr7FkqassfA3AtCini1StMQ/dG2FwvtnXqI5jnVa3QEKgasxaQlHoe+TzYbGmAri4RNaJ4s78vzWyIrR/+QX659CmE3s/ly6V4kN2YYkI/1Z5deNf+Si1M4ZybzC+QG0MJgvGKUsiTvQDrys9TDWSKxhbacAZPNbCdVjGaczCY17svBwg/7xwibSeAMELBpyjOaSh3dF0ZahPnmLVmDA5OnMlg45ZM4/AaMkOtFtlRN7YuSZ5Ixt7PEpEsQlwjro0SVl3cP2AGmEdh4dUcTxMOuTiqI7DTDfQMHavoPHp8zKoh7tXjANF4eqzWlxMtv+OdfpwPwm9JpixGfR80CsSMBd7jXKXTumrIf76S+SiEJX0m4QJcV8U6Daw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(6486002)(478600001)(83380400001)(71200400001)(6506007)(26005)(6512007)(38100700002)(91956017)(64756008)(76116006)(66476007)(66446008)(66556008)(110136005)(54906003)(66946007)(921005)(4326008)(122000001)(186003)(82960400001)(2616005)(5660300002)(7406005)(7416002)(316002)(8936002)(8676002)(38070700005)(86362001)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGpOTWhMWW1CVG1YYS9lbHpiRFNhUVNKVkRWRDB1WmFTYkZKUzFpcWxLT0k0?=
 =?utf-8?B?TzNjUkpzZ3BQNTI3S2JsNGVOMlhpVVdybWRSMnZ0b21ibnpJVHRvSVlsNFph?=
 =?utf-8?B?OFFqWGZtRXpjSnFROURkNUd5ZkFwaUFtT2JEdUxjN0VFRFFYSWFnMEQ4dUNo?=
 =?utf-8?B?OFhHUTBVRlIvT2MwTEt2dWhHUE1kTHBOK09uNzVWOFE5QzY4N2dscFpHb3pJ?=
 =?utf-8?B?eXVtSlpicVA4OHRCWkdvL1ZOZFFQL3JvWkMyUHhVcTRjenRHR2NxblRRcjF2?=
 =?utf-8?B?eWM3Z1I0NFM1eVdKRlk5aklSTHQ1SHExT1V5ZHVpeTFMTEUvZ0FBMDM3WmlX?=
 =?utf-8?B?YTBSZUFLZi8wbEJZREdTVldMV3A1OGxyRno2MmhSb3RGbWJGK0pwTVVXQTdI?=
 =?utf-8?B?aFFsMkN4Z0ZQWXN6dTUxZkVzek9jY2xHejhLd1d1K0lSTVhjYm13UmdtTUVX?=
 =?utf-8?B?cktqUENKRzJrV2VDVDFFaU9heUlHQklNcHZmZ3o2MDEzdk0vQWlSRFRTY1pU?=
 =?utf-8?B?amlsV2g3ZjBFRGk0a292eTVjdmF2WDRDUGp6WkJzVlFjNDdwVFUwbEU0azA0?=
 =?utf-8?B?L1VsbHd4eWxQRXFrTHc5M0RrK3c1UStscVpnR2tEZ21lbVJBbW5VaTVoL1J3?=
 =?utf-8?B?cnNJeFVLREFDUEcvb1l1M0kzUFM0S3NUMHgvSlUxQ3NIbHV1Q2JxZWtqbWpy?=
 =?utf-8?B?L0FDZUszRWVqR0luc1NIREpWTm92SFRRWHdILytkQTMyc0tER2l6Y2Y4RGxv?=
 =?utf-8?B?eEpIYzFyMXVLQTZ3RHEyS2JJaDE3UzV3OUVGcEJyVnpLUXJha3VQYnk5Y2Fy?=
 =?utf-8?B?MzhuZnF4eEM5TUVtNGlaSm4xZmplaU13dEhOVHE0SGx4L3A3c00xNG4xYXBB?=
 =?utf-8?B?SGl1bldBZG9UTHNNN3NhaDFSZGNBK01IM0VNMzFCQ3pieDBHWW80MFp0VkFi?=
 =?utf-8?B?emxycTR2RHRXN3ZPdEJDSkZ2dlNyUHBkN1d6Ynh6OVptZTNob2NyR3QzL3p1?=
 =?utf-8?B?eTBTSGk1ZWpyTXJESWQzNTB2MStkRklUNSt4S1l0dVloZ1VHc1V6V08waWNS?=
 =?utf-8?B?dHRHbWRWUHNEVFpLV0lXNENTTE9uUkhYa1BUb1A5alU2UWF3TUhaUENFeVdQ?=
 =?utf-8?B?WlY4ZlY0elRCSkYwL3BiZzFJTzhLS1BhL3I4N3UxUG4rcEhLQm5pdTh6cXpw?=
 =?utf-8?B?dlh0S0s2M1pVNnFMSThPbTFZazNxb3NZcDF5NVplK1J0S3NJTnc5ZG5CVXdq?=
 =?utf-8?B?YXVCTnFsSStIbExSekd1aitBYi9YaUFFWmsyVHRHSTFidW1xd2gzTVZyRHpR?=
 =?utf-8?B?S251UG5GM2svZjdYT0czaEErTTNGczl6N3JPVmdEZlZ6UVpVT0EwLzdYYnFr?=
 =?utf-8?B?U2ZRaG5JcEMvU0w3OFZxOHc4RXRsOWtqK0gwbWVwNGl3NW5mbnZsU3VGaDNP?=
 =?utf-8?B?M0hWRmFyUWxSVk9QdFA1VlhZaGl0anhqMWF3NHJSVHBHK29oSVBOS1NNSkw0?=
 =?utf-8?B?YWx6dG1JUTlaTEZXTDVFNTZwdWgwUVpiVThNbkNRczFNWk9TLy9yQUVpL2tK?=
 =?utf-8?B?QUt0Z2FPcHpsNWpoTXhuM3gxZi9MckFIYjEwYzVHUmJOQnlxNkRvS1M2aU1l?=
 =?utf-8?B?RmpKYnIxUFZuUkNXdUdWRFRwUlQ0MzdkUmZFMmlTbGVjdms0WFBOUENjWUQ5?=
 =?utf-8?B?ai9ORy9EdWN4WnV4czRaNlNxN2phdVVXU1hyd1k2TGhoQ3lvRDFNUWFRTHlM?=
 =?utf-8?B?M2puNzgxWkdVRS9VbGNkL292VUg4eGFsaEJpVEIwbElFd2xrRkhxM2pYSytG?=
 =?utf-8?B?VTUyV3NXTXdzamxzaG5vUVVtTjEwU3p6RVBjOExaMm8vcjhlZHgrcEdnWFpS?=
 =?utf-8?B?NVUzTnhvQlFpdU5lQ3hWdEh2dWRmNnFTUkpwK3hEYlNraU5ORU4vbDJtR0E3?=
 =?utf-8?B?b2RZUlNPWnJFT2R6QzZPZkQ3eUJSOVBzM1A1WHU5eHVEbE9Kb083MnZpNGF6?=
 =?utf-8?B?ODkxTHY3Z3lLMWdtUFZ6WkZVN1lpOUhtcXFyWml1N2VSRFJTenVtUVZhNDRG?=
 =?utf-8?B?RmVxOHdkaW55YTRuTEhBMG1Ga0V5cXdHZ2NtSXVvNDRBeE5ON01iR1c0V0Ix?=
 =?utf-8?B?MEdkektqM3UwUHM3enplSHpEWTUvemVJeDY0N3FiQXl4RjYxS1lSamZNUWEw?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4229F05D081F6E4583E5F48037CC13B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d2d7f7-cc94-4ae6-10be-08db87b6b683
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 17:45:01.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5tan2sVScG0lttRjiRb8xA4a5TdtnnLDIQBLeBtEkvVvk0anjTRs5/RC5yTSIWGvXnwJtnxMHcZsLgmROY+Lu0eLKsJ3ow+TK/QVA+8h0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTE2IGF0IDIyOjUwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBG
cm9tOiBEZWVwYWsgR3VwdGEgPGRlYnVnQHJpdm9zaW5jLmNvbT4NCj4gDQo+IFRocmVlIGFyY2hp
dGVjdHVyZXMgKHg4NiwgYWFyY2g2NCwgcmlzY3YpIGhhdmUgYW5ub3VuY2VkIHN1cHBvcnQgZm9y
DQo+IHNoYWRvdyBzdGFjay7CoCBUaGlzIHBhdGNoIGFkZHMgYXJjaC1hZ25vc3RpYyBwcnRjbCBz
dXBwb3J0IHRvIGVuYWJsZQ0KPiAvZGlzYWJsZS9nZXQvc2V0IHN0YXR1cyBvZiBzaGFkb3cgc3Rh
Y2sgYW5kIGZvcndhcmQgY29udHJvbCAobGFuZGluZw0KPiBwYWQpDQo+IGZsb3cgY2ZpIHN0YXR1
c2VzLg0KDQpXaGF0IGlzIHRoaXMgYWJvdXQgZm9yd2FyZCBjb250cm9sIGZsb3c/IFNlZW1zIHRv
IGJlIGp1c3QgYWJvdXQgc2hhZG93DQpzdGFjay4NCg0KPiANCj4gTmV3IHByY3RscyBhcmUNCj4g
wqDCoMKgwqDCoCAtIFBSX0dFVF9TSEFET1dfU1RBQ0tfU1RBVFVTLCBQUl9TRVRfU0hBRE9XX1NU
QUNLX1NUQVRVUw0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVlcGFrIEd1cHRhIDxkZWJ1Z0ByaXZv
c2luYy5jb20+DQo+IFtSZWJhc2VkIG9udG8gY3VycmVudCBrZXJuZWxzLCByZW51bWJlcmluZyB0
byB0cmFjayBvdGhlciBhbGxvY2F0aW9ucw0KPiDCoGFscmVhZHkgdXBzdHJlYW0sIGRyb3BwaW5n
IGluZGlyZWN0IExQLCB1cGRhdGluZyB0byBwYXNzIGFyZyB0byBzZXQNCj4gwqAgYnkgdmFsdWUs
IGZpeCBtaXNzaW5nIHByb3RvdHlwZXMgZm9yIHdlYWsgZnVuY3Rpb25zIGFuZCB1cGRhdGUNCj4g
dGl0bGUuDQo+IMKgIC0tIGJyb29uaWVdDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJy
b29uaWVAa2VybmVsLm9yZz4NCg0KVGhpcyBpcyBzaW1pbGFyIHRvIHRoZSBhcmNoX3ByY3RsKCkg
dGhpbmcgeDg2IGRvZXMsIGJ1dCBJIGFjdHVhbGx5IHNlZQ0KYSBmYWlyIGFtb3VudCBvZiBkaWZm
ZXJlbmNlczoNCg0KMS4gUFJfU0VUX1NIQURPV19TVEFDS19TVEFUVVMgc2VlbXMgbGlrZSBhIHN0
cmFuZ2UgbmFtZSBmb3IgdGhlIHRoaW5nDQphY3R1YWxseSBkb2luZyB0aGUgd2hvbGUgZW5hYmxp
bmcgb2YgdGhlIGZlYXR1cmUgd2hpY2ggaW52b2x2ZXMNCmFsbG9jYXRpbmcgbWVtb3J5LCBldGMu
IEFuZCBpbiB0aGUgZnV0dXJlIGEgZ3Jvd2luZyBhcnJheSBvZiBkaWZmZXJlbnQNCnRoaW5ncyAo
ZW5hYmxpbmcgcHVzaCwgd3JpdGUsIGV0YykuDQoNCjIuIHg4NiBvbmx5IGFsbG93cyBvbmUgZW5h
YmxpbmcvZGlzYWJsaW5nIG9wZXJhdGlvbiBhdCBhIHRpbWUuIFNvIHlvdQ0KY2FuJ3QgZW5hYmxl
IHNoYWRvdyBzdGFjayBBTkQgV1JTUyB3aXRoIG9uZSBzeXNjYWxsLCBmb3IgZXhhbXBsZS4gVGhp
cw0KaXMgdG8gbWFrZSBpdCBzbyBpdCdzIGNsZWFyIHdoaWNoIG9wZXJhdGlvbiBmYWlsZWQuIEFs
c28sIHNpbmNlIHNvbWUNCmZlYXR1cmVzIGRlcGVuZCBvbiBvdGhlcnMgKFdSU1MpLCB0aGVyZSB3
b3VsZCBuZWVkIHRvIGJlIHNvbWUgb3JkZXJpbmcNCmFuZCByb2xsYmFjayBsb2dpYy7CoFRoZXJl
IHdhcyBzb21lIGRpc2N1c3Npb24gYWJvdXQgYSBiYXRjaCBlbmFibGluZw0KYXJjaF9wcmN0bCgp
IHRoYXQgY291bGQgcmVwb3J0IGZhaWx1cmVzIGluZGVwZW5kZW50bHksIGJ1dCBpdCB3YXMNCmRl
ZW1lZCBwcmVtYXR1cmUgb3B0aW1pemF0aW9uLg0KDQozLiBJdCBvbmx5IGFsbG93cyB5b3UgdG8g
bG9jayB0aGUgd2hvbGUgZmVhdHVyZSwgYW5kIG5vdCBpbmRpdmlkdWFsDQpzdWJmZWF0dXJlcy4g
Rm9yIHRoaW5ncyBsaWtlIFdSU1MsIGl0IGNhbWUgdXAgdGhhdCB0aGVyZSBtaWdodCBiZSBhbg0K
ZWxmIGJpdCwgbGlrZSB0aGUgc2hhZG93IHN0YWNrIG9uZSwgYnV0IHRoYXQgd29ya3MgYSBiaXQg
ZGlmZmVyZW50Lg0KSW5zdGVhZCBvZiBvbmx5IGVuYWJsaW5nIHNoYWRvdyBzdGFjayB3aGVuIEFM
TCBEU09zIHN1cHBvcnQgdGhlDQpmZWF0dXJlLCBpdCB3b3VsZCB3YW50IHRvIGJlIGVuYWJsZWQg
aWYgQU5ZIERTT3MgcmVxdWlyZSBpdC4gU28NCnVzZXJzcGFjZSBtaWdodCB3YW50IHRvIGRvIHNv
bWV0aGluZyBsaWtlIGxvY2sgc2hhZG93IHN0YWNrLCBidXQgbGVhdmUNCldSU1MgdW5sb2NrZWQg
aW4gY2FzZSBhIGRsb3BlbigpIGNhbGwgY2FtZSBhY3Jvc3MgYSBXUlNTLXJlcXVpcmluZyBEU08u
DQoNCjQuIFRvIHN1cHBvcnQgQ1JJVSwgdGhlcmUgbmVlZGVkIHRvIGJlIGEgcHRyYWNlLW9ubHkg
dW5sb2NrIGZlYXR1cmUuDQpUaGUgYXJjaF9wcmN0bCgpIGhhcyBhIHNwZWNpYWwgcHRyYWNlIHJv
dXRlIHRvIGVuZm9yY2UgdGhhdCB0aGlzIHVubG9jaw0KaXMgb25seSBjb21pbmcgZnJvbSBwdHJh
Y2UuIElzIHRoZXJlIHNvbWUgd2F5IHRvIGRvIHRoaXMgd2l0aCBhIHJlZ3VsYXINCnByY3RsKCk/
DQoNCjUuIEkgc2VlIGluIHRoZSBuZXh0IHBhdGNoIHRoZXJlIGlzIGhpbnRlZCBzdXBwb3J0IGZv
ciB3cml0ZSBhbmQgcHVzaA0KYXMgd2VsbCAoYWx0aG91Z2ggSSBjYW4ndCBmaW5kIHRoZSBpbXBs
ZW1lbnRhdGlvbiBpbiB0aGUgcGF0Y2hlcywgYW0gSQ0KbWlzc2luZyBpdD8pLiBYODYgaGFzIHNv
bWV0aGluZyBjbG9zZSBlbm91Z2ggdG8gd3JpdGUsIGJ1dCBub3QgcHVzaC4NCldoYXQgaXMgdGhl
IGlkZWEgZm9yIHdoZW4gdGhlIGZlYXR1cmVzIGRvbid0IGV4YWN0bHkgbWF0Y2g/DQoNCkkgdGhp
bmsgd2hlbiBEZWVwYWsgb3JpZ2luYWxseSBicm91Z2h0IHVwIHRoaXMgdW5pZmllZCBwcmN0bC1i
YXNlZA0KaW50ZXJmYWNlLCBpdCBzZWVtZWQgZmFyIGF3YXkgYmVmb3JlIHdlIGNvdWxkIHRlbGwg
aWYgaXQgKmNvdWxkKiBiZQ0KdW5pZmllZC4gRG8gZWl0aGVyIG9mIHlvdSBoYXZlIGFueSB0aG91
Z2h0cyBvbiB3aGV0aGVyIHRoZSBhYm92ZSBwb2ludHMNCmNvdWxkIGJlIGluY29ycG9yYXRlZD8N
Cg==
