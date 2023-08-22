Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD27847F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbjHVQrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHVQrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:47:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A2184;
        Tue, 22 Aug 2023 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692722850; x=1724258850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rFGwysgA2F5DK4bswjRwlL/RsTV9S/fb23WgZ6UD6Co=;
  b=KBgL0beWtVg0VPQs/dr5dCN0dTmE+TtAdj7T2Ej+xXPPOQ2XdT1av1Rf
   9E1SfeZJ5gWn4YI4ZY+QsHf7jPDLlq/fbosWjMg057EFWbmTx8m8QZUax
   mUlMAZGwLAU9cM8MLWjT99Pfh2fVHjNXqzi9jj3HRW9Qq9IfTZRDx7pcM
   9fXBvI9LoVjl5DQgGQe7DnK2rnRnoPpuEsXXP7730QjE+qegrsiXxONsP
   67ET4erkyRiBOpHP1tMxGs/VwQX5Dcfj0/mGhXe7EI1dPUu4uxM99ydbn
   3kgvXXcgjNzEg2gobY+sAIYrF7/NimKpzo+liy6u4dt5/O+E9DDe2x57U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="460296479"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="460296479"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="736289305"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="736289305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2023 09:47:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 09:47:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 09:47:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 09:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsLilqYQgWsmbllCsgrM/m+lwSvxWJM6UvT556dUmmWrsNU8ryoJwZy71ZkMor8A4gv4h4tsP4o/GANXxDqU6xNKz95rG80tKRETIXVmFp0vffOZq91TXB/rq3SIYjQVer1s266iMAJspnMEDanqMyeBA7f5VcLPNFihjw889+xXmUTzYsxP3fNNpPt9fxsNJKVOY3NpXT0fhwvCL6KgrONQsM9QeDrn6L7Bn2FT6atSQeLuoDyJ+oxFrGcQijimPf3Cl/QRNusym3ARdmLV8uCTwlBq2w32Z6Co075iB552g4i4Mp15TjmSZZmvfGZ+4iT4qZbsxqnxv8VzHEkh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFGwysgA2F5DK4bswjRwlL/RsTV9S/fb23WgZ6UD6Co=;
 b=IYi21Wn7/5Ca+g1UyIhKESlrwdCcq5CPoCWmTdycBU1irt21d2v76hKYjFFRDddPlmq0DN6VH+0YN9h+MSd9d8Ygjq8HUUr/2wyopZCWWshuUOR5ubRCInMwq0LjpKHqoyvh6YfD9KgGGC7h1NgDnRQhsNV7YbFErkh+q0GJMjBKxAaH5HsGlGFq8uJ5yo4vkQbQ8dbvKKlKXr1ynC33HgXRTpFv0vqvjtnS3g61M0al0ME7WgFnsAnKyZepqwtocpUtUseDqsp/bntQnqSsvUqxs2m8h4XdgEqEpFpMG12lL47S8KOE5Pf/jiGB9svaci8XLfhs3m8c4+Xor7zkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8667.namprd11.prod.outlook.com (2603:10b6:8:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 16:47:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:47:27 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "david@redhat.com" <david@redhat.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 11/37] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Topic: [PATCH v5 11/37] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Index: AQHZ1QGVAoAqFlFQRESDzW0R4fh4oK/2boqAgAAFsgCAABJqAA==
Date:   Tue, 22 Aug 2023 16:47:26 +0000
Message-ID: <e10e729392c5fa421baf08b4ea7aaac6ffada0f5.camel@intel.com>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
         <20230822-arm64-gcs-v5-11-9ef181dd6324@kernel.org>
         <8f2cf5af-cad7-a69c-e8ec-39f48deae1cb@redhat.com>
         <54b2c1e5-a99d-42c0-b686-1b5cbb849581@sirena.org.uk>
In-Reply-To: <54b2c1e5-a99d-42c0-b686-1b5cbb849581@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8667:EE_
x-ms-office365-filtering-correlation-id: 47500c2c-1d33-4167-3471-08dba32f77a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fh2gJTn3ZgAsRtVoqLdWhBw4ECmw9TVfDn6Z8PcztbMkUra88w5s7mULgEqrX6nuJobCDzUW4p9fU/lRKthQuK0ii244IYtETLAYM/CNLcASkOhrGeQHrldtwB+Jz7s0eKovsOSrtNyn8cgwyJbJEvBZRs9pq9kx1RsT2j7D2Z4qAgdAUZrFm8ALCa5SHCwLMG+4M1zBvY742rQtjIvIgW1YhkrHg7pARA816yTzVt7OsJChoEOm5ehmYrerUEzQx77BvfTiaRHNb/93Pd3Pb3iKhuk/QUZgBSy1pOEvKaFXgrvzFvzfLuf/HEY0qyARYMP+UiMHN43ySZE6bs8UCc6hqq7qZHWhb7WpMjlqcstnwuZrZOHVD2h0aFTiJpeKWdOpNFR5jIR/1ZQ6o/XcCdchMMHWEZXSLicQqGsxqi+es961RNRfrfkwdy3UrHJMeQCPattTJe2U6ikAqcUBgNlNnshgZBa8HWOFAYSzSa/JoyeFN50oqPW7kSNGygYpz3JML4hMW/hnF34rP6Ge8UhM0vCG1cRkid0gZk8mS6uLi+0wOSLixSBcU2OpkjsMosaKFd57hKlrLK+qi7QKkV2R8iSRFjkp7Q9fgaYDeZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66446008)(66556008)(38070700005)(54906003)(64756008)(76116006)(66946007)(66476007)(316002)(6512007)(82960400001)(91956017)(110136005)(8676002)(2616005)(8936002)(4326008)(36756003)(41300700001)(122000001)(478600001)(966005)(71200400001)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(7406005)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnZ6WTlCOFRXUzRPU3pZT3NsNmpOWUdIcTVhQ3dkVDFWWlJERXQ1c2pyQThr?=
 =?utf-8?B?RnhmaFFzSUxrUUl5VmZmcG5sQUNBd3ZYRWxhanJhMm5TcHZlSVpSbjRuNkhG?=
 =?utf-8?B?UFVjaEpPUExjUE11dEhoU2Z0RTd4K1JWQ1RWa29pbWFXZUZaN1VZRHdxcCtt?=
 =?utf-8?B?SHpIWnRuMHpxejlFTGJBeldnQnd1VjdmTnBuVmZONWlrekdVNG8zcWRkUHdV?=
 =?utf-8?B?K1JQZnhlS1ROZmJWQThzUi91UENNVzBkVHQ0aStHZm52TW9LK1p0NmxIL3RB?=
 =?utf-8?B?ZTlZSElrNHVLV3RXcVlqRzErUTlPQnhuRWxmMHdXSUM2WGhUMWZwNmF4QlRK?=
 =?utf-8?B?RU05OGJKS0NlWEt5L1RRL3ZFK25UQzhpaGlaUTdubE9YQXZYdGNWWGxuaFo4?=
 =?utf-8?B?cmxaMUlBemhldHdpZWk0UncxYUExYSs2YzFYcGdCV2MzM1YvZ0NhVHpxSDZ6?=
 =?utf-8?B?anVOUnpTSGd1U2RKSkFILzhNT0dkeXRod0NzOFhoZWVxRTBhWXJma2pmYVVM?=
 =?utf-8?B?c3V3OXlJSWFncnMzTGVHQllJamEyNkk3T0xnNU5wVnA2RGJRVElQRUN5cHJS?=
 =?utf-8?B?VkNUbDRWQTNFRHRWNlQzL2VPU1QwOXhvTHdBb21TTzZXSEg3b202R1dTRDBL?=
 =?utf-8?B?YlFQNTFVK2o0R1BFaWd1VzdaV1k5QSs0WHF2OHFHanViY3o5bW5mUTFvV045?=
 =?utf-8?B?c2RZUkhmck1SaFV2cHB3bVFibXJoaWFTOTg3QjY5VlhRTVpTcTQ1a3FUL3dJ?=
 =?utf-8?B?UkFSTXhXZjVjeDZSZ1h3YzY4ejJWVDhQb1FvT2xDdWJNYlI5bGNFQm5FZlZY?=
 =?utf-8?B?SllsVkdNQTU3N3hKYlRmK3lUZnpEMUdrMHlDUmRsWlRCelVYZXhBdWwycTdu?=
 =?utf-8?B?Zk9NOTBMcEdqRi85SUNpdDdva3pCK0p3SVd1cURCS1RQb2Nodk5ITFJqUmhi?=
 =?utf-8?B?SHNueTlpdGJnMGpOV29LZ0FiUmUyL3VYa2V1bmU1cGxVaWJ0V3o3Z3FaUCtY?=
 =?utf-8?B?T01uMDY5VW9BbVJEcCs2dzJJMGRUa1JjQk04akxHVW9QRmxpdGs3WjJaNGZ2?=
 =?utf-8?B?WmFOM01vdnhHS3I2RUthaS9GRkk3Z1VabWJVOW1QSm0wcWd3VFl2aUx1czV6?=
 =?utf-8?B?aDEwQVQ2OEN6UkxtRVE1NWYxMFpINDFYRkFKVVhZcHF3MWF1Z2hMbHlPQ3hr?=
 =?utf-8?B?dGpRK2NLeXVHQ25naFA2VFhUWmhzZHRKaTZkSnZlSmt2RldKR28rV20xa0tB?=
 =?utf-8?B?T1lhWk0wcmtkTi83SDM2WnQ5T2NiYVY0VG5hbjNsYktrYUt4bGMvSkpab1dB?=
 =?utf-8?B?NFJuelk1RGpQaXBaRE1KdUZvOTRvYzFqL0dqQklSWm05T1czZFpLVFo4cWc0?=
 =?utf-8?B?TU1sVnlSVk16dVNrV01ibi9SNnlvdEt4ZEFoVFlGaEpXQ0FqdDREU2NWcjRQ?=
 =?utf-8?B?U1cyNWdPYVdaQVRPTzRIM3ZDMDF0TTFjTzhwZitxRERhNis0ZytpMWVTTlpH?=
 =?utf-8?B?NTcxMWNUZVJ3azV4cGpzc2dteUtuV09HaDJGTzh4ODRVanU5Rlp4dzMvUHho?=
 =?utf-8?B?Y2VuVUsvcVVDbXhxT1Zld0ZHT25lRzBHZDVBNXhQOUFxdUdxcE02akZhbWYz?=
 =?utf-8?B?WVExMG5ZS1FmWkczbm5EcUMwZDBwL0U2ZG5QdDR5VDk5cmZ3c21JRVdpVlJT?=
 =?utf-8?B?MzNGN0tybnk3V1ViTGd2NEMxMWhQSHN4bGI0SzA1S1cwSHdwdjE3ZGIxaHA1?=
 =?utf-8?B?N2xVVTBzajlqUkdtRXRIbXJxLzNuQ1JmMitwL3NGTHBFMnNlV0ttSnpvN21W?=
 =?utf-8?B?THl4NWxyV0xGUjlSbFlEMzdXU29IeUlMTStxTkNDLzhGbzdiV0pzNnNFeDVr?=
 =?utf-8?B?MG5DU3orVkR5Vml0T0Q3Mmwxd3d1YjRManMvZUVkNG9GZ1lNNjJTU1pZYWRr?=
 =?utf-8?B?dkNjenEvWjV3QlppcGhLdlhZMncxMmcva0E1SW1HVi9SYkZMSVJPVWhJM1R5?=
 =?utf-8?B?Z3dNN3ZreHJJUzlTdFpWZzVwS0k2SmtjcmRhaHpzTEhrR251YUpRZEs0czFm?=
 =?utf-8?B?OWxqbWZybWdvVklWRzNXdlZnR3FJdnhHL1gySFJwMXluSTFqdnUyNy9kWlhu?=
 =?utf-8?B?R1hNSjFKMFlPUG56czduYzZOTGtHaWhmdUNMK2VRbFdOZFEvc1Z4UlJJWEdG?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0C7CF2011A57047BD3E69254981130F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47500c2c-1d33-4167-3471-08dba32f77a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 16:47:26.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+t8+qQNiMDe8Cn463BgpfED6esjlkGT4u1+Iq3/UOHZ7yXbaQwjRW3lBCic9wTAkzEk9xToPKjRLNMeSTYK0m2ZP7Co8xf5UOnKyi/u3qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTIyIGF0IDE2OjQxICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyAyMiwgMjAyMyBhdCAwNToyMTowOVBNICswMjAwLCBEYXZpZCBIaWxkZW5icmFu
ZCB3cm90ZToNCj4gPiBPbiAyMi4wOC4yMyAxNTo1NiwgTWFyayBCcm93biB3cm90ZToNCj4gDQo+
ID4gPiBAQCAtMzcyLDcgKzM3MiwxNyBAQCBleHRlcm4gdW5zaWduZWQgaW50IGtvYmpzaXplKGNv
bnN0IHZvaWQNCj4gPiA+ICpvYmpwKTsNCj4gPiA+IMKgwqDCoCAqIGhhdmluZyBhIFBBR0VfU0la
RSBndWFyZCBnYXAuDQo+ID4gPiDCoMKgwqAgKi8NCj4gPiA+IMKgwqAgIyBkZWZpbmUgVk1fU0hB
RE9XX1NUQUNLCVZNX0hJR0hfQVJDSF81DQo+ID4gPiAtI2Vsc2UNCj4gPiA+ICsjZW5kaWYNCj4g
PiA+ICsNCj4gPiA+ICsjaWYgZGVmaW5lZChDT05GSUdfQVJNNjRfR0NTKQ0KPiA+ID4gKy8qDQo+
ID4gPiArICogYXJtNjQncyBHdWFyZGVkIENvbnRyb2wgU3RhY2sgaW1wbGVtZW50cyBzaW1pbGFy
DQo+ID4gPiBmdW5jdGlvbmFsaXR5IGFuZA0KPiA+ID4gKyAqIGhhcyBzaW1pbGFyIGNvbnN0cmFp
bnRzIHRvIHNoYWRvdyBzdGFja3MuDQo+ID4gPiArICovDQo+ID4gPiArIyBkZWZpbmUgVk1fU0hB
RE9XX1NUQUNLCVZNX0hJR0hfQVJDSF81DQo+ID4gPiArI2VuZGlmDQo+IA0KPiA+IFNob3VsZG4n
dCB0aGF0IGFsbCBqdXN0IG1lcmdlZCB3aXRoIHRoZSBwcmV2aW91cyBkZWZpbmUocyk/DQo+IA0K
PiA+IEFsc28sIEkgd29uZGVyIGlmIHdlIG5vdyB3YW50IHRvIGhhdmUgQ09ORklHX0hBVkVfQVJD
SF9TSEFET1dfU1RBQ0sNCj4gPiBvcg0KPiA+IHNpbWlsYXIuDQo+IA0KPiBJIGNhbiBjZXJ0YWlu
bHkgdXBkYXRlIGl0IHRvIGRvIHRoYXQsIEkgd2FzIGp1c3QgdHJ5aW5nIHRvIGZpdCBpbg0KPiB3
aXRoDQo+IGhvdyB0aGUgY29kZSB3YXMgd3JpdHRlbiBvbiB0aGUgYmFzaXMgdGhhdCB0aGVyZSB3
YXMgcHJvYmFibHkgYSBnb29kDQo+IHJlYXNvbiBmb3IgaXQgdGhhdCBoYWQgYmVlbiBkaXNjdXNz
ZWQgc29tZXdoZXJlLsKgIEkgY2FuIHNlbmQgYW4NCj4gaW5jcmVtZW50YWwgcGF0Y2ggZm9yIHRo
aXMgb24gdG9wIG9mIHRoZSB4ODYgcGF0Y2hlcyBhc3N1bWluZyB0aGV5IGdvDQo+IGluDQo+IGR1
cmluZyB0aGUgbWVyZ2Ugd2luZG93Lg0KDQpUaGVyZSB3YXMgc29tZXRoaW5nIGxpa2UgdGhhdCBv
biB0aGUgeDg2IHNlcmllcyB3YXkgYmFjaywgYnV0IGl0IHdhcw0KZHJvcHBlZFswXS4gSUlSQyBy
aXNjLXYgd2FzIGdvaW5nIHRvIHRyeSB0byBkbyBzb21ldGhpbmcgb3RoZXIgdGhhbg0KVk1fU0hB
RE9XX1NUQUNLLCBzbyB0aGV5IG1heSBjb25mbGljdCBzb21lIGRheS4gQnV0IGluIHRoZSBtZWFu
dGltZSwNCmFkZGluZyBhIENPTkZJR19IQVZFX0FSQ0hfU0hBRE9XX1NUQUNLIGhlcmUgaW4gdGhl
IGFybSBzZXJpZXMgbWFrZXMNCnNlbnNlIHRvIG1lLg0KDQpbMF0NCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvZDA5ZTk1MmQ4YWU2OTZmNjg3ZjA3ODdkZmViN2JlNzY5OWMwMjkxMy5jYW1l
bEBpbnRlbC5jb20vDQo=
