Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D375814D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjGRPtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGRPtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:49:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386679E;
        Tue, 18 Jul 2023 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689695384; x=1721231384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PgmgpHTW+p3JyAEdN5Ip5rsVIX4TbbHlm0Lu9WzSOt8=;
  b=OukEHvkUu9ktSQqYaoC7PSSfPj8XMcQuDYjox6nXFIBWbp1Bkv8Qsp8y
   6LXoP5hR0e4pJKOD09tc6BEGY8OxgB/o5GqAtJQ0BsrhguIP+UbMQ1Nvo
   5X0N0K1v5NvVfhpRvTWNgWhIjXqwI48j/I0edpAZ2fXyQfvIaC5lOBKaG
   oE/gbKDBj1QtaM6H5f1HK7vQyFT+EW0N/uX94jvgCQayLKp16cFv/LtRT
   HHw+znGZGArcnooqZbDnXPf8oF0z8+07aetkMR8Es4hYfcSZ1MJfcnxiu
   zN2rnKFHLJPxt43ipsHSXh6uroIcXrffxO2fyp9WF3HjXYNsSj0P0qua9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369798287"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="369798287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 08:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="726980370"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="726980370"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2023 08:49:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 08:49:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 08:49:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 08:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8h7w+or1FrmqSv3HsUpwKt52nd0Qs6LIj7gJSV1L9KmGfzpKXGahma4BmN7gPEOr1qHhKVrR3NnZW3S2kPLmzZtaKE/D+ECNWlkXbXOsX09fPqQQWMQm78P0efbxJ8psHCk1x/CCRWSoEKjA8v6YPA/r67H6E5SJ4rGqVXqgaQX+akZySAKX1c2Id1tBkDhK3GbjZiKDEtH7oN1q5dGL6pt2zr4btBuKJbu/kbs2URyxceWyfgZ+LkRRNeWDoRyDkkQlCdDwQXGnn+u2zOlrU5K4vYzIIbGWSpIr03fEJuqaADkpdvtyFez5nuImZYQT6Yhaws13DrXr45FAxwlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgmgpHTW+p3JyAEdN5Ip5rsVIX4TbbHlm0Lu9WzSOt8=;
 b=BuI72QxgxLieq+n3eSmbZyQSkS/Zs6idf3pSRM+jf31VgXuENCpyj6vL5+Ugv8Hrv2SxBrBmVMAQX5JcYbupk/uOK7RfSsVbYTtaBgEaUvvyLHxI1XkK04IWJWG5FL+dQvA9qQ5ufSciMbpP7eJVKrL+ZoWeFNtUB+k4k+wK10H37ALM2J4ywnOxfY74vRlElVV/duUk1d0V/7QDjjjtmzlMMXBklY3lFh10Gdr8ENYEopncviRmXuGUqqgPV50D4J379Sa4BvZdKc1xk6VIQWTYHdAW/4WS/cT1TCTnI0lLkre4BHh359mOAwAzUUdAxWYZKH09XRmSrjzXDu96SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 15:49:28 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:49:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 22/35] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH 22/35] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZuDA9Hy9NIq2k+UabXI3UglVqjq+/PuYAgABPpICAAB/ygA==
Date:   Tue, 18 Jul 2023 15:49:28 +0000
Message-ID: <7a4c97f68347d4188286c543cdccaa12577cdb9e.camel@intel.com>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
         <20230716-arm64-gcs-v1-22-bf567f93bba6@kernel.org>
         <ZLZW7Kvg2Rep8ySO@arm.com>
         <8ea03eda-e630-40c5-acc1-a63f5c5b3102@sirena.org.uk>
In-Reply-To: <8ea03eda-e630-40c5-acc1-a63f5c5b3102@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4901:EE_
x-ms-office365-filtering-correlation-id: 90c4084b-e0e0-404a-092a-08db87a69200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T14orw1qCxy8wsGBuUl8o/XR3HtlKRJWziRic4iWmV/T/n5Eaqf58EBoaiw1GyZBRSXKKJcPIca2jUl85TpIf1lAs3HvdqbRou2Md90PMADb3hY1HAc7NRNxetBVD6DXjqieoc7vOqQu85LC5E2v/p4N1sR5czz7z+X4aeZbhfdpGXAiZzDrRX+Utv6TvI2Nq3xGmNx+uvHktakvVTEokyvd+9IdT+JqvzhCuHK86bhaDU8ekgec/yn2I4Zh13hVJYT9le3Dp7lIXNTnqIVyjUB1r0TmhwpSIOvTn1N9W8uYJjmwy9gsjHTnE7qDawylsfaOlhxb5gauZ5pk2NcaBFXLCOSFt5+Q582j2uqPfTpor98/cavSk5Pgnyzwdj4R9+eZ+0I7iS/zymmjO2/W6UiBrWTncCE7sqeksz9SndR8xse6sD7PtI08VBkT94+smyWmCgEsAGNZaS0ne2SiqjxNtV15FNo/YL5kKbyib7I9GE/FHiIKafhP7Md85lS4kKmZAiDLRICR66RMvz+siBpEkiNl0e9c9MmbnC81ehxuC4NZTCTxcpE6+CTFSFtsHkD7Q43WlPQcfZ9DIZNJx8YFFdnU522bj76uh4K6Sb0Ny0QiT3OOZW1F155NsNZX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(41300700001)(8676002)(7406005)(7416002)(66446008)(66476007)(66946007)(2906002)(8936002)(66556008)(6486002)(54906003)(91956017)(122000001)(76116006)(86362001)(4326008)(316002)(64756008)(36756003)(5660300002)(2616005)(6512007)(38100700002)(83380400001)(186003)(26005)(82960400001)(6506007)(71200400001)(38070700005)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0dPd1NKOW11SklRcFJOU01EV3FFbHZOVm5YUkdEaVBHb1JnR0plYzAvamN5?=
 =?utf-8?B?S3psbVVNbHliR0cyVW0wY2dBTUFBVnYzOUJwY1pTbW5PN1V5ZTcrY2FmaHN1?=
 =?utf-8?B?WG1EcUNlNXM0eHNoYXFsb3JCdWVmOVlLR21WakdsaUlQZGo2MXlVY24vYWl1?=
 =?utf-8?B?MXg4UE1YUkE0QlNUYUNOSTRodzZ3dVdNNHZKc1dtQ25OOWNENi9CbVhWdVpx?=
 =?utf-8?B?a1FWdlFaSnNVSTJJMzQ0cDhrTlY1Vk5sMjl3QjRYWVZIOVNxWG5uNDhaZzJp?=
 =?utf-8?B?UCtMQ3JLY0h5K2xWREJyb1U4S1ZJTHlRWG1wbW5YUU1BMmJTd3lJOEhBaHVP?=
 =?utf-8?B?cFRsZ2FFTm0xRGgwWFJwU1JYdDJ0WnRRSmtGU2FLSjlCWVVFTHhCN0Jhc2Fh?=
 =?utf-8?B?ajBhZ0UydHZ4dTRSc28rTmMySUpCYjZnUUZrbFhhdlhpcEhxMVQwY3o5TDlS?=
 =?utf-8?B?cGdqVFpmNE01TnpCM2prdUYyT2xXWTF2Wk5zLzQxMGRhY1pYamcrSW1ybGtM?=
 =?utf-8?B?L3NFV1I2cGhNMWxVSHFXTm90WGNBY2tnb1BDOUMydUQrWW13VE5uMm92V09E?=
 =?utf-8?B?M3N1citoeWRPbS9iL3pmVG5DNCs0aVloV3IySThBRW5BaDZzZ1VuRkJ0a2h6?=
 =?utf-8?B?a2J2UDJlSHBNTkUwT1dGOGc2NUpRbEFXWGlYYVl1OGptckY4MWZkZ21VUzY0?=
 =?utf-8?B?SzhObmJVMHV0QnVmUGV4SEhzK2VuUkkxTm1WcGpOT0VVQUhmMkRVRlJRaVRN?=
 =?utf-8?B?TklzaU5hU1RkN3dzTXlHRDdtR013ekJhYzVVcEZaU1BFM2s0WklmR3ZRRG5E?=
 =?utf-8?B?MWY4ZlpTcHZwV09QalF2blFwM1BWQjg3aG9XMzBXeXpWT2NtQXZuNVdSY2NL?=
 =?utf-8?B?bUVsenIyMksvMzQ2Z1dZb0dGR0ZDbGUxb2d3YXl1eE9DYlAvYzdZYmo4NmZ4?=
 =?utf-8?B?QUhwYXJsOUNmbUpwa2lkZXc4R3p0eFR4ZkFSR2NBQnVPWmpYZzdzMEh2aGpW?=
 =?utf-8?B?amY3cW82NG1haEVNK0NlNEIzY2xiaW8zYVFOK2JvY3dDL0JQZlVuV2xWTWlV?=
 =?utf-8?B?bHBlbXphS0dtcmgrUkVwdFJZRnpVSW8rL1hYT0hLVW1CV3k4RzZzalBOZU9U?=
 =?utf-8?B?Z2xPOGhYNHN2ZEZVZy92cUhBa1ZCcldHMXN3RVVyRml2ZHJ6OXJUMGE2clpk?=
 =?utf-8?B?ZG9aZHVsR1BRcHVNU2pZKy9zdVRCYmJWcW9UaFkxbGhuS3RqbmNkUlFLZUQy?=
 =?utf-8?B?MENBYUIzQjlvMTA3TFNsWkNzbEE1RDNtL1NGZXpuTXpMRmpBYjhkeTJwZ2c3?=
 =?utf-8?B?WTdCMVY1d0w2MFN0VTE1U0RLYlBnSzdEZEtZN2Q5SlVSendmUitkWXAwL05N?=
 =?utf-8?B?UGx2Z1hLaFFNWVVGaExrd2hyUDhkY0pxZDhqTjdYUlJoL05OYlhET2drL3A5?=
 =?utf-8?B?ZDUyakpQK1ozV1BIQUdaQXRDcWl3SXJkcStzY255ait1b3p0NUVDcXdIZWpt?=
 =?utf-8?B?NmdXczc4bnpERWtGOHZDb0xKWFBjUUFVSnlwUk4rRlN0c01mL3pIUndJbmNq?=
 =?utf-8?B?U0hZR291TjlWMUN6bWdyYzMwNzl3UlljRG16NUExZW1zOXV6WHRnY3pWMVFQ?=
 =?utf-8?B?RzkrZ0VqQWFNa24yeXEyZUU4SnNQaWhXc25zTU8xbzlidnF3amtTcEU1L3pR?=
 =?utf-8?B?MHgra2V4UXJJMTZVS3lqV0lYaTIyOXpVT0ZQVjFITTVQdjF3NTIxQW52WWF6?=
 =?utf-8?B?azNEQlF5U3NYQnh0c0ZtcmpMQkVTUGJKb05NL01UVkp3TDlFejBKTDA2L0Fr?=
 =?utf-8?B?UnVoNWYvcW42NVcwczBqUFFxMXhhbStSUjNjM1NWTG5yVjFMMU9FYngzOWpv?=
 =?utf-8?B?VkxBeXZGc0VMcjk2VFJaWTVqMUgrZndEdUM0NmZMRE1icGRQMllucUErOG5o?=
 =?utf-8?B?RktJclBqSGFDZ2hZV3JHM0p1VU1SZEExaWRGN3Z5em1POEQ2Skxpb0hGb3By?=
 =?utf-8?B?Y3dUTmVlaWxvNVZPQ2pHVUxGd1UxZ0M2NWhDVm1JeGcyREVqRzJYUk5EQ0dt?=
 =?utf-8?B?MjBySTc1YkpUcXpnMXBFMGU1ZVl5T2JNZ0FNTGEra2tHd213VkIyR0VDcU5q?=
 =?utf-8?B?UzdHU2trUm00Z2x5T3VqcDhMQ1oweVhMU2EvQ1E5WndlSkpWUWVrdGpEVnVs?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F21A12086E28FD428EAF494D03A270A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c4084b-e0e0-404a-092a-08db87a69200
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 15:49:28.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49gGbJ+kIBx5H5iMPgELadCVQH9VuTaxOuOBKA6mDTvNQPSjCtLs2eTpzNZwjGDEPboeuZjYzN+5HNAoc/l30FwQb6bspJ+loTl8xlv87Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
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

T24gVHVlLCAyMDIzLTA3LTE4IGF0IDE0OjU1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEp1bCAxOCwgMjAyMyBhdCAxMDoxMDowNEFNICswMTAwLCBTemFib2xjcyBOYWd5IHdy
b3RlOg0KPiANCj4gPiDCoMKgIHVpbnQ2NF90ICpwID0gbWFwX3NoYWRvd19zdGFjaygwLCBOKjgs
IDApOw0KPiANCj4gPiBpJ2QgZXhwZWN0IHBbTi0xXSB0byBiZSB0aGUgZW5kIHRva2VuIGFuZCBw
W04tMl0gdG8gYmUgdGhlIGNhcA0KPiA+IHRva2VuLA0KPiA+IG5vdCBwW1BBR0VfQUxJR04oTio4
KS84LTJdLg0KPiANCj4gWWVzLCB0aGF0IHByb2JhYmx5IHdvdWxkIGJlIG1vcmUgaGVscGZ1bC4N
Cg0KSEogbWFkZSBhIHNpbWlsYXIgcmVxdWVzdCBvbiB0aGUgeDg2IHNpZGUuIEhlIHdhbnRlZCBh
biB1bmFsaWduZWQgc2l6ZQ0KcGFzc2VkIGluIHRvIHJlc3VsdCBpbiB1bmFsaWduZWQgdG9rZW4g
cGxhY2VtZW50Lg0KDQo+IA0KPiA+IGlmIHdlIGFsbG93IG1pc2FsbGlnbmVkIHNpemUgaGVyZSAo
YW5kIGluIG11bm1hcCkgdGhlbiBpIHRoaW5rIGl0J3MNCj4gPiBiZXR0ZXIgdG8gbm90IHBhZ2Ug
YWxpZ24uwqAgc2l6ZSU4IT0wIHx8IHNpemU8MTYgY2FuIGJlIGFuIGVycm9yLg0KPiANCj4gSG9u
ZXN0bHkgSSdkIGJlIGEgbG90IGhhcHBpZXIgdG8ganVzdCBub3QgYWxsb3cgbWlzYWxpZ25tZW50
IGJ1dCB0aGF0DQo+IHJhaXNlcyB0aGUgaXNzdWUgd2l0aCBiaW5hcmllcyByYW5kb21seSBub3Qg
d29ya2luZyB3aGVuIG1vdmVkIHRvIGENCj4ga2VybmVsIHdpdGggYSBkaWZmZXJlbnQgcGFnZSBz
aXplLsKgIEknbGwgaGF2ZSBhIHRoaW5rIGJ1dCBwb3NzaWJseQ0KPiB0aGUNCj4gc2FmZXN0IHRo
aW5nIHdvdWxkIGJlIHJlcXVpcmluZyBhIG11bHRpcGxlIG9mIDRLIHRoZW4gcm91bmRpbmcgdXAg
dG8NCj4gb3VyDQo+IGFjdHVhbCBwYWdlIHNpemUuDQoNCg0KU29tZWRheSB3aGVuIHRoZSB4ODYg
c2lkZSBpcyBmaW5hbGx5IHVwc3RyZWFtIEkgaGF2ZSBhIG1hbnBhZ2UgZm9yDQptYXBfc2hhZG93
X3N0YWNrLiBBbnkgZGlmZmVyZW5jZXMgb24gdGhlIGFybSBzaWRlIHdvdWxkIG5lZWQgdG8gYmUN
CmRvY3VtZW50ZWQsIGJ1dCBJJ20gbm90IHN1cmUgd2h5IHRoZXJlIHNob3VsZCBiZSBhbnkgZGlm
ZmVyZW5jZXMuIExpa2UsDQp3aHkgbm90IHVzZSB0aGUgc2FtZSBmbGFncz8gT3IgaGF2ZSBhIG5l
dyBmbGFnIGZvciB0b2tlbitlbmQgbWFya2VyDQp0aGF0IHg4NiBjYW4gdXNlIGFzIHdlbGw/DQo=
