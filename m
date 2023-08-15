Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C177D485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjHOUp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 16:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbjHOUoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:44:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F851985;
        Tue, 15 Aug 2023 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692132273; x=1723668273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oeWYHSOvclEVydp658W8/v0Al5TEePlYRA/7mUXeLyg=;
  b=k6gSRPen4u1OWveSAsrLsovvz48YBuHuHsAeEZ3OU2Uu8IWk2NUsyIAY
   cORXOvhQqn7QRBqnFFJjuUYljnmdeLdP66caeHI9vV1dXScH7MHjWdBd1
   y+h5Kl4G6EP4TlYSL7pgFqHgPvaxXhjFep7eKyrCsKINv6Da4IdhAVGEI
   plMtyGEBEzLpF64HJQPmytQqfdqyqCKCrGdRN4WsZ4x/OJxZbjJV8np0v
   f1+auu2vT6tfo2LzBjwLg8oG9dUpuKW3KHpFTagGuG0KZtxA5KV5y/2nE
   m/woerFv3kCMWx4n4MYhkmrchYrP477EGmmHgCWopxyqx3YI68cJ9tAr+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="351960313"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="351960313"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 13:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="823973631"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="823973631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 13:43:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 13:42:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 13:42:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 13:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAJpBj3NOvDzVk5bTrmeNcXWkecR6l4INw1bdC5a232t2EgtQZA5Peddwvv+ir3LFJ1vY0e1qGqCw4zszebiAkHoZaHs2E/r+7VhwcXff8HswMMHzE52KYv02wL2Wpx+cmNPlD4XSNfHDv/HJnr9KkGS1gu+3sYxDFXAXWp0dxSW47I+Dwt4Idkwb5L6kbHb+QVhsvmvP38lCUGLQWm/FP7OR3wvXd2xQVitmLDYYHifr4I+vCKOo9Wsz7UlE/sIiNCBFoHjWSpcelMXi9NNT4D5M/NIpg2bETzmNlu2EQugCW+MGjgzDY0MO5PUi0B/CIBsib1XzXewD1htg0omVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeWYHSOvclEVydp658W8/v0Al5TEePlYRA/7mUXeLyg=;
 b=Hx0rEd3+r0Hj+cnHsbm1dNzs3AuQnSCRYFHXSoBYs7lXR0yPw8ERVrSt0gEUzhnr6XS+8adlJj+YSNn83DZthvSUH2jhkG8AAd0KJenFsdLBUjM4Jw10jvivVaHpGvE+x4L7iSNZY7N6PnDpEFVZ2kwXEzRuRp8CUPXBgTTfnw074bjJgaeoe6KWd/gvsbDeqc39bJAju++1750JaNadhrdm7fSnHgDbI3jhgs7nos/t9ac0znWTIeV9oY/9r/MUF7NBRbgYiVdOxHk8eDLTP3zowo6Y9YPMHq2NVo2FYXWEUzWIBmATw3tuVsqaHx6uf/NL69Y82VtfXMI4g0XYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 20:42:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6652.029; Tue, 15 Aug 2023
 20:42:52 +0000
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
Subject: Re: [PATCH v4 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH v4 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZyXsMNVNM7/zTI0u1rug712WAyq/r3yeA
Date:   Tue, 15 Aug 2023 20:42:52 +0000
Message-ID: <8a7bb14f808ab9da413c11f281041375d9a54b01.camel@intel.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
         <20230807-arm64-gcs-v4-21-68cfa37f9069@kernel.org>
In-Reply-To: <20230807-arm64-gcs-v4-21-68cfa37f9069@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7251:EE_
x-ms-office365-filtering-correlation-id: 20b106f0-c809-4448-9a55-08db9dd03235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yG6YuG678LecjS07qkY4HBoGggCtN+fNjCAEFQDs/lKUCfn+7WAfNdyqxsMk1Drw4q6V93ppHT7mjQlLEgX968236L6ix71RjJOp7twd1O7NmM4dCe9S6CBILiAX/NsYENY7axSOpLmpKnk1zKE2NjofGVQL/Ip8daYgpWY5ZnCeUVvc+QUgQeq7bI3adH8zTGSTT55a25f1rEYu1MKVp6Ke5bhJlzYyM+5HmeGev+O8zjFIor7WC5zCYtp0MG0Qjojw5y+TkxBGoxR9IsJvDWQV7T6Yv41Bh63hgyVh/aClPhLlEKbk3X6Dzxj7CYIv+wQ4xz03y2YaWduLnsJkO2eEi+BtF/aZKXqs/kE1dsCuDsOoXIHkgPVsWtBQ1E47c8xsWJgXM5AkMT1fbTprxzEaPLSdvQ3scG0SiP3vpeK6e1Hd3hQ3hoobO7H8jAWHkLR2uw3qfOLVq1KpEaAf8DVoccPDs8Xh86xCctTjIXLVBN1+7rZgNxKPxmO8eF7Z5pOaDZDzba9z69x33WJpISdCYKZDkYcoLk5K1Km3IV/G0DrvdFgZS5iwRcoQgnYvpZjqfQs/B7PAb0QdeErlCjIbUGSuedmxJCE3Z9/VIv4qipAoWUt5iJm1UVEvb1v/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(1800799009)(186009)(451199024)(26005)(54906003)(316002)(5660300002)(8676002)(110136005)(66446008)(66476007)(38070700005)(82960400001)(122000001)(38100700002)(6512007)(921005)(6486002)(2906002)(2616005)(478600001)(71200400001)(7406005)(7416002)(6506007)(41300700001)(66946007)(64756008)(86362001)(76116006)(91956017)(66556008)(558084003)(8936002)(36756003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG10ZGhJellXRzhPUXdQZVpTUC9CNGN5WUZWbFpiT3B2VVZ2T1dRRE5UNE9k?=
 =?utf-8?B?TGxrcDNSWUtlYWdraUQvamNEcFYrdWIrdVVFT25tOFdFVzBaOGVXTGtjRkNV?=
 =?utf-8?B?ellsNk8yc0JjTUxVOWt0UEpBTGkva2xxSzl1b3JTZEdCWjBDdnRUMVc0L1dp?=
 =?utf-8?B?SkhvSHFxbU9tbDBscForak9ld0tudUFSTmRFM0kxT3hpZlJVMHREcFZGNlZ4?=
 =?utf-8?B?M1dOaDQ4eFRqUks2a3NUZjNnNmV1RURNM051enErbHVpR1dLMVovd3BGNmdU?=
 =?utf-8?B?eDF1YnhLYUtWRktxb1kyS25saUw2V1B1SkhXMnp2YjduZFBjWTFKWCtOSTZ4?=
 =?utf-8?B?SW9ZdXMxcFlXQTNKZnBRT1JOTkdpZzN2bGJqRmszNWZmY2xhTGxwaXdyVktj?=
 =?utf-8?B?OVlEQmFNWkZPZUNLZ3F6dmZTUFZRdFYvRVZ4TGZOOE9KejRMU0JBVVlSc1Zi?=
 =?utf-8?B?dE8rbG1lMzIrem8xTUpTcE1Rak1rbzVlTmNPVkV5ZkZ2ejc0TjRXU01xRVJI?=
 =?utf-8?B?Tk9NZ1g5b2s3M1BucFBkbGF4ZXR6Z1RqWnVqeC9kRE05YmJ5WHN5UHMxQXZU?=
 =?utf-8?B?VGN4elA5SytNOG1EQmc4MCtPc2dDVHc2QUZjTlJZV0hsV3orV0VIckcwZU9I?=
 =?utf-8?B?V1pLYkVsM0NyNG8vUG9iYzc0OWpLY0h0aDMyVjZNQTRRUksvSUd0UHZDM1ZT?=
 =?utf-8?B?MEpXaU5ibjZSTmM4S2I3T21raDZWa3IxcUVQWnpCMTBadHpPcGxhbnlOMHdS?=
 =?utf-8?B?L0dCL3BmZysrSWNHQ1VUcWh0RThVU3dTKzdIRzNERnBlQzRlMHpjV2NUazBt?=
 =?utf-8?B?RmVzZll5WVJuZmZ6N0h6dDUzc25PeFVxWGhMR0dtTWw4UkdxakNWeGVsNjdo?=
 =?utf-8?B?QXhZd3llOTJHQUs1N0hTYUlOanhla3A5ejZEWGhKZS9CS3hTajlzVnNDRW5C?=
 =?utf-8?B?NVJQbndmY3VVRml4ZndLRW5UZGZ2K1VFYTIxajBQa0daOXk2c1dYdlRjcmI3?=
 =?utf-8?B?TkhiWlFMR2VtMEhjZjRUNWZDM0ViMUlmZ09VWi9yOEJFcVNrQ0t4ZklpY2tq?=
 =?utf-8?B?UHY0TzA2MlJtNmNEdnZ0Z2JvUHRDL0Rlay9WOWdUR1pyN0twTCs3N01OWGJn?=
 =?utf-8?B?dmhUMmFZTnlrajd1ODM3b3E0WHh4STRvM25neWRJZm5CMUM5d3BsNk9kMGM2?=
 =?utf-8?B?YmZGT3Vjc1pZbjViY25IbUJBMXhkMzh5WWM4bEF5LzVwNnNWUWErbGFTRTFl?=
 =?utf-8?B?L2JxVk91T2F0YkJ5eEliSVNPRVcxdWxVM2xQZXkyUDNicDU4QjBZSFNnZlBZ?=
 =?utf-8?B?SndqMHA4VUYrUGtFZXBLNWhlNWQrWVM5eitTM2xTWG5ZUEtUVlRvZ1cyMWJG?=
 =?utf-8?B?QlZQM2tBbnR4U3A2ZlRuNUdXcFB3NGJjUm5pUUhxK0F4SE52UGk2MEFPdVll?=
 =?utf-8?B?MkVJY3B4eVZCanVNS3JIUkZyVGJUSkFuU2x2RHh1RUFHWm1qUWlnQ085MXZk?=
 =?utf-8?B?QmxkQWFWREpIQWFvQ3BTK01EbTl5cUVsdzNDZTJ3aEMyeFhvN0hwcFFXVUN4?=
 =?utf-8?B?WG82UmxMQitRZkJMdnRZZTNBUTBjUjVWNG52U01VdCtRaHZJUUU4bGxDSFVr?=
 =?utf-8?B?VzdjT25UK1VKOTlFVEQyeXEvbkVtMXZUTGF3ZHd2RmlXSXdSa1dlbFRQUVRD?=
 =?utf-8?B?SlpSVjl2UVhGR3FnRzZlK1dNUUluTnBTR2gxVWlpQnZ4OHNGdG9WdXNHOVpu?=
 =?utf-8?B?alY5d2lBNEZHcHV1NW16Z1FQSjVjeHJQTlhhRDFuN3NVV2VyOVRzY3l5dEdR?=
 =?utf-8?B?akVjcXJjMnFOWVl5OW80M1VNcVBRdHk1dFAxbkVIaFdLeDY5RG96NDNiNTVP?=
 =?utf-8?B?eThQS25jQW1meUM2NjhIRTNPSkNsNlZTaDJkZGxUa05IK0pTSFFKLzF1T0Ey?=
 =?utf-8?B?c2NTM3draThhZXpna1lVcmovZGppOVRxd2ltK094Mm0vY05RUGt5Rm9nVEh1?=
 =?utf-8?B?eWR2L2hkVzBlNUlaMkV2eVFUNjFJOGJwd0IyeUc4YnpGRG43d3pGUGhsNTVv?=
 =?utf-8?B?WUt6c3FadmcyTlZ1dTZnU09aVDB6ckRrQkNmaU5FaEM2MTN1bm9nT0tTNDhK?=
 =?utf-8?B?VDRzVDJ1SHJQbGRXVUt1cEFyVm9tVTBpYjc4Nmg0SXh4YzNJTUQyQkxKeEdj?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B7EC3EB6B4C94F9F1E08A522826245@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b106f0-c809-4448-9a55-08db9dd03235
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 20:42:52.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qls2o4Z7ISXtkdUeqjoQfo7r71OwvIE8290Ct9q2RQVDCgGVaae1+oei+ckgLPp8IXsJ1DcXMdcA7nxgMHHcRMYy9QLJK50RLykOdD8FpUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
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

T24gTW9uLCAyMDIzLTA4LTA3IGF0IDIzOjAwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
wqDCoMKgwqDCoMKgwqBpZiAoZmxhZ3MgJiB+KFNIQURPV19TVEFDS19TRVRfVE9LRU4gfA0KPiBT
SEFET1dfU1RBQ0tfU0VUX01BUktFUikpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVJTlZBTDsNCj4gKw0KDQpUaGFua3MgZm9yIGFkZGluZyBTSEFET1dfU1RBQ0tf
U0VUX01BUktFUi4gSSBkb24ndCBzZWUgd2hlcmUgaXQgaXMNCmRlZmluZWQgaW4gdGhlc2UgcGF0
Y2hlcyB0aG91Z2guIE1pZ2h0IGhhdmUgYmVlbiBsZWZ0IG91dCBvbiBhY2NpZGVudD8NCg==
