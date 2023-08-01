Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317BD76BAE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjHAROi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjHAROg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:14:36 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE81FFC;
        Tue,  1 Aug 2023 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690910075; x=1722446075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FRvXXa7JaeiVapccOgdfgjbs2LEN8my9wSw1S6f1Eag=;
  b=Dj62+o6UaNNUbvu9B0y4v+DmnyHmr+9QJ31zvx9ArCoDx/ECb6WJ7GJL
   K6H9zvH/b5hjaAOeBoTe0FfdshQGh2D03zSGiiBlxj/vmWiDUfqOIchRK
   AVuoaku7N6OHIOUZbQVk7g/fYXMKRcYwBFXk5u0lxzrQ7cHlMpLOr1w3/
   tDMdAqK+05oEOIqgfmDQd2mjtGwlGpxBjEjzCSzDZknzBscKtB7om/Oix
   LxPxbAnj8mTiR8Alc6kqxaZgkrgBPWWK9DQMCXmUTziA71NBMInt2wLKo
   HE/d8X2ZY6OzLJ1hFcE0syR5lV35spefP+dVRvxDoj3A0F9JWgePMpb+S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433205002"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="433205002"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852552726"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="852552726"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 10:07:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:07:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 10:07:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 10:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M58zofTgf/2syFUgBs+gEdho26anktgbxHOFcfAeYQ60ykg4ROWN8GBYdUYNmGpUzKU+gYVHd4nz/LwF9RFGJq3/+nmOQjbAFpGuuoufR5pAJQdw4HkzUtcXZkvTwJKdM3Bvn2ZBOOwV85YVOujHTG/mQp6adlSb/M+tSPWwRoNNDqfyAP5nOwgBxXSkI9B79zQDwqekUVw6XCUblDSE+YHbaKdw6hgsQqHZLTfvFxxDjOJedel0uPoZ1Y7jYFm6WFqSqZ+3+I0woJD2Dy9RV+OaU3Jitr8ZtSO2pmvghQU7PFohjKA/vXHkU5SOE8h6Ww4prJYHOzedxG8sAv+aPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRvXXa7JaeiVapccOgdfgjbs2LEN8my9wSw1S6f1Eag=;
 b=U6d6PFKvnYDBYNn7Y1l48iIMEyYdLSfr2bRMU1ac+cZCAFFnqFC7Soi/RuWoIf8XFmUjCZu3KRQ4jrXPmDPmPKbd8GYkdedWBCd8SgbZOREMf54eG8sG3JUf63eIkx5lHW0nNCy35PBYoUhcgJ9S3lwHdIlvBx4bF+deP7gZMMQxgfY6019v2rKF1KBGYvcJTcTAeCJb2Olb5XY8zAUCWgVTLgCvWhxyt+WTNtGP8qo055H52VJeJU9uwYT4/ouQ0GAGb2zzfgPSqESbMv3iiSWV/GulgxdkFT3y3JuftpEBxnwVc4vfV5RF4t8ZjaANz7njQE+J53I3sA8xcomaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 17:07:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:07:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZw7ZZVWMs6JZuI06/zv64SypFG6/UB86AgAATdQCAAGg9gIAA9o2AgAAzsIA=
Date:   Tue, 1 Aug 2023 17:07:00 +0000
Message-ID: <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
         <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
         <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
         <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
         <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
         <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
In-Reply-To: <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BN9PR11MB5226:EE_
x-ms-office365-filtering-correlation-id: 08235d36-8a4c-41c6-b208-08db92b1b8c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ga5pnL3VcR8RndglMsNf1Tyep4ObiDthtXo8ONF4W/5Rtl2GHP6p4FS2qbLy/15D7wi/tiOuAoQcMVa5YMh9j7QsN+dlG+4lftPqlXamnbuR7dAOSJexToNge9VN/BtIz6N43COEeOKk/MhkzgZeFLRSXek/A3AR2xQlCjPCEy+2cjPqpEVKURkmsB3heahAh2iudd3aTR663oatPz3EIeITc9V63oXOR+hxvpiLoxSD4GkvdfWZAqIg+5wRJj3tI0mXicvAJW51mcSpmcARrm/NLYYllSULiCcaJfv+Ic41Qz+8K+0cexEOv4FvHjk53fO2wYWwxVhQjX/ji36QlV5DQvnoAUrxfm+I3hzVqfRlt8+u4pp0yd6rsRLmxPEMUVsCOuxnDCKWeorgM/xWjqfDEkz45WmQjitDdSUJUF5dDXpK4LEuRktXtIINLCQLXg2Qm3cwhTZMFAC2VIotP/xyo5jknyQ/KX1W3eR7LaLjfvAob/N2u0JZGHPDike5tSolFmWjsIYOTMllxFlR2AIIBmycm8/K5nHyQTR2yjmoOSIA5/KPo7d4FNkNOeMAyV6w4PIWhjeLSJ8g3fuX6rOmqeBoadiQ+Hu/33s/1XIbKhh6J6M3A8s2L4stajzJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(7416002)(38100700002)(66899021)(7406005)(6506007)(5660300002)(76116006)(6916009)(4326008)(66946007)(66476007)(71200400001)(66556008)(64756008)(82960400001)(66446008)(54906003)(6512007)(91956017)(122000001)(478600001)(2906002)(2616005)(8936002)(8676002)(38070700005)(6486002)(41300700001)(36756003)(186003)(316002)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHRMZ3g5OXhuMW80RlhtY2YyWjI4akdwVHVXbUczY1RQWDZrY21UakJiMVB2?=
 =?utf-8?B?U3kzeGw3Y1pqNjdVMnJOdUppZzMwTVZpQlc2RlNhajZFSjI3TkpCSDFGRGpy?=
 =?utf-8?B?WGVvTGtGZzh4Z0hjQmNwblhjclJQOXZVNlZWUmw3cjFHdzZiNTJRZ1NESW9l?=
 =?utf-8?B?NWxsd3JmNG85MlhCV1hKRWd2Tnk5cWs5UG91TlpBVVNpNVAyNURzYWhheG9o?=
 =?utf-8?B?Z0NxYU52NXB2azIvWkJMaXVGL2lycmkyRyt5SG5vTHA4ZmhHbGwvZkI4enhq?=
 =?utf-8?B?ajlET1Y5QU9RWmFtYi84bUo4V1VjaW5yV2hiRk5uMjZrSDRKa1k4d2JEaGF6?=
 =?utf-8?B?QWo5NHNEd29KbTJQN3hyUTBzV0ZuM3dVa2s3dndZSkxYYVRZOHAreTVPdFJR?=
 =?utf-8?B?TGxFdnZGcEt0UWJJcnFncWtJV04rcmZYYUF2RjZ1a1hOTjhzUG5icngwWjFQ?=
 =?utf-8?B?N2FTdXBjVmpNcmp2aFhWS1lFYTJudUJPSC96akhja0pBUllPN01BNXZKbUI0?=
 =?utf-8?B?ZHhPWFlhWDV1bGtvQjE0d2gwc0xvVWU1bFo0Vy9uL2NKc2UyQld5T0hKVExY?=
 =?utf-8?B?Mkg0aTd6WUdhRU1zMmhCZTNGOXFwbGpMcEwrRnJzV0gxM1g4dkRnZGNHUWhV?=
 =?utf-8?B?U01LUXNQVlFyN0tQSHFQMGVYVGJheGI5YmRaclU1UDNwdENmYkJHNVVaL1pV?=
 =?utf-8?B?OXduMDJ6VFhKUlVOUmNWSE50OVJscWRTQk1vUG9tblQrbmFEN2VGT2FveXJu?=
 =?utf-8?B?YkFITndvdlRNd21aaFNDbzE0NFdWUjRJTGprL1p2UnFCZnVJK3dwQnFOVXBJ?=
 =?utf-8?B?YmswQS8yamE5VmQ0R3RSNk1XdDdUT09wMG9rMEd1ZVhUZy9idUd3M1lldTFs?=
 =?utf-8?B?Zmt2aFVHVXl5QW5ubEtqQUFXTUZsWmtReThFZWdjOFJLbkJrUzlLREhyckta?=
 =?utf-8?B?cnFjS2hPOE03cHM3RzhRcitFM0p3bG55M2VzUDdXTnpKdDl3M3Nwd09uRm56?=
 =?utf-8?B?T1FEcUNSL0VCNWh1N3B2MENlTlBoeDV3bSs2b3VMVXU2MGlFdVVseDgxc0Z4?=
 =?utf-8?B?WWtDcVRvTXZyemdUbjhuNWtzdnBmU2pHVzQrYzhNOTBEWXFtM2F6VVNzU3ZN?=
 =?utf-8?B?UkdVb2RabEFJcGt3dVhxbDBYRVdTNTdXeDg4SEt6ZndrbnNpdWlZeTh0WlFN?=
 =?utf-8?B?Wkk1NG9YM2sxekFXUm9VSHRTWWtzNW1zVXFzQ0JvZE53Y3RXeWd6V1dvbkdV?=
 =?utf-8?B?ZEQrdy80VkxRd2xMOFVLQTFTZ0hpUjk1eGV5S1hXRkdLUlNQNWNGK1V2NjUx?=
 =?utf-8?B?TFYrRDRpbk1BLzJ2dW0wNm1lRWVjLzk5UG1oVnRjNEVsaWo2K2ZqT1A4QlBw?=
 =?utf-8?B?dEZ4VlR0RGdtTUdtSmlyMkttMWFTUFpvR0NGRmRRVkFmU0dIeVgzWkJ1Rk8w?=
 =?utf-8?B?bVlXa1RXTlA1UE9hSUY2eVd1Q3dFZlBlSlpkdStQaU8zZTdtSUpldWM2WDBE?=
 =?utf-8?B?OU5yakhVaExuR2VQMVVwdFRrL1VjVVExZ2JyVXZyVnB5ejJucTYzNjk0NXg3?=
 =?utf-8?B?M01Tc0RYYXlNSXUydmo1aFM3Q3V4cUlmZk4vNlNOVDdoWVZIeGtSd3FZREdt?=
 =?utf-8?B?WHAzNUFEMk9SdFN1WGVyaUNGTkF2Rk8rak5XVGo2NDRCZjJUNWRqOWJVUWpF?=
 =?utf-8?B?Sm1lYXRlekpibUlqTHNZdGpsN2ZTZzdHdEY5b3NPRG82ek44OS95MG0xNjNn?=
 =?utf-8?B?NUhvc255YjRPTEpRbEpJUnBjVGdJZnkvcUNjK3VRRjBxcmdUb2NaOFdaTjNX?=
 =?utf-8?B?SXlLVkl5dVI0QWsxUnZtSHh4WWRoRGxNbC8wWDl3QXFWdC9zdGo5TmM1VnRx?=
 =?utf-8?B?cFZxVGdiMFYzM3pBaHNFYlI0Ymg1cFZzWWhzUlZ0NVl5WlpYNTZsYVNITFpr?=
 =?utf-8?B?a3dBYy9sOFNwQjA5WVRYV0xYdEpVendSU1FyUWs1UFVkYTlaem9lY3NuLzlL?=
 =?utf-8?B?Witrb09ySFNOcFNuSldXOTZ1bUVwWlFqeHZNajN3R1hvUXdjaElLc0NPaDZi?=
 =?utf-8?B?TldHbHE4ZU9QMGNJT2xQZUhhYmMybFdOTGwzTjAxNU4rOERiWlZOR3FRdi9k?=
 =?utf-8?B?MDEyQWFTc09nQlh2V0tEUkdGbnNHL09lbU5rcGZueGxZeGdQUkdSYnUyYWUv?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <195AA2F49F590F45A5F47FA3A6C4F118@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08235d36-8a4c-41c6-b208-08db92b1b8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 17:07:00.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rv6VCMEg8MFZsHrXmQvw4gmCwvxVRhQ8+i7oatXKIBM7boo0r/Y+iz0DHrXQa218ZXPNR74DRMdQeJBS4RLqKEOtoV6+5csrnRNtRxbJMBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDE1OjAxICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIEp1bCAzMSwgMjAyMyBhdCAxMToxOTozNFBNICswMDAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gDQo+ID4gVGhlIHRoaW5nIEkgd2FzIHRyeWluZyB0byBnZXQgYXQgd2FzLCB3
ZSBoYXZlIHRoaXMgc2hhcmVkIHN5c2NhbGwNCj4gPiB0aGF0DQo+ID4gbWVhbnMgY3JlYXRlIHNo
YWRvdyBzdGFjayBtZW1vcnkgYW5kIHByZXBvcHVsYXRlIGl0IGxpa2UgdGhpcyBmbGFnDQo+ID4g
c2F5cy4gT24geDg2IHdlIG9wdGlvbmFsbHkgc3VwcG9ydCBTSEFET1dfU1RBQ0tfU0VUX1RPS0VO
IHdoaWNoDQo+ID4gbWVhbnMNCj4gPiBwdXQgYSB0b2tlbiByaWdodCBhdCB0aGUgZW5kIG9mIHNp
emUuIFNvIG1heWJlIGFybSBzaG91bGQgaGF2ZSBhDQo+ID4gZGlmZmVyZW50IGZsYWcgdmFsdWUg
dGhhdCBpbmNsdWRlcyBwdXR0aW5nIHRoZSBtYXJrZXIgYW5kIHRoZW4gdGhlDQo+ID4gdG9rZW4s
IGFuZCB4ODYgY291bGQgbWF0Y2ggaXQgc29tZWRheSBpZiB3ZSBnZXQgbWFya2VycyB0b28uDQo+
IA0KPiBPaCwgSSBzZWUuwqAgTXkgbWVudGFsIG1vZGVsIHdhcyB0aGF0IHRoaXMgd2FzIGNvbnRy
b2xsaW5nIHRoZSB3aG9sZQ0KPiB0aGluZyB3ZSBwdXQgYXQgdGhlIHRvcCByYXRoZXIgdGhhbiB0
cmVhdGluZyB0aGUgdGVybWluYXRvciBhbmQgdGhlDQo+IGNhcA0KPiBzZXBhcmF0ZWx5Lg0KPiAN
Cj4gPiBJdCBjb3VsZCBiZSBhIGRpZmZlcmVudCBmbGFnLCBsaWtlIFNIQURPV19TVEFDS19TRVRf
VE9LRU5fTUFSS0VSLA0KPiA+IG9yIGl0DQo+ID4gY291bGQgYmUgU0hBRE9XX1NUQUNLX1NFVF9N
QVJLRVIsIGFuZCBjYWxsZXJzIGNvdWxkIHBhc3MNCj4gPiAoU0hBRE9XX1NUQUNLX1NFVF9UT0tF
TiB8IFNIQURPV19TVEFDS19TRVRfTUFSS0VSKSB0byBnZXQgd2hhdCB5b3UNCj4gPiBoYXZlDQo+
ID4gaW1wbGVtZW50ZWQgaGVyZS4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBGb3IgYXJtNjQg
Y29kZSB0aGlzIHdvdWxkIG1lYW4gdGhhdCBpdCB3b3VsZCBiZSBwb3NzaWJsZSAoYW5kIGZhaXJs
eQ0KPiBlYXN5KSB0byBjcmVhdGUgc3RhY2tzIHdoaWNoIGRvbid0IGhhdmUgYSB0ZXJtaW5hdGlv
biByZWNvcmQgd2hpY2gNCj4gd291bGQNCj4gbWFrZSBsaWZlIGhhcmRlciBmb3IgdW53aW5kZXJz
IHRvIHJlbHkgb24uwqAgSSBkb24ndCB0aGluayB0aGlzIGlzDQo+IGluc3VybW91bnRhYmxlLCBj
cmVhdGluZyBtYW51YWxseSBzaG91bGRuJ3QgYmUgdGhlIHN0YW5kYXJkIGFuZCBpdCdsbA0KPiBh
bHJlYWR5IGJlIGFuIGlzc3VlIG9uIHg4NiBhbnl3YXkuDQoNCklmIHlvdSBhcmUgZ29pbmcgdG8g
c3VwcG9ydCBvcHRpb25hbGx5IHdyaXRpbmcgdG8gc2hhZG93IHN0YWNrcyAod2hpY2gNCng4NiBu
ZWVkZWQgZm9yIENSSVUsIGFuZCBhbHNvIHNlZW1zIGxpa2UgYSBuaWNlIHRoaW5nIGZvciBzZXZl
cmFsIG90aGVyDQpyZWFzb25zKSwgeW91IGFyZSBhbHJlYWR5IGF0IHRoYXQgcG9pbnQuIENhbid0
IHlvdSBhbHNvIGRvIGEgYnVuY2ggb2YNCmdjc3BvcG0ncyB0byB0aGUgdG9wIG9mIHRoZSBHQ1Mg
c3RhY2ssIGFuZCBoYXZlIG5vIG1hcmtlciB0byBoaXQgYmVmb3JlDQp0aGUgZW5kIG9mIHRoZSBz
dGFjaz8gKG1heWJlIG5vdCBpbiBHQ1MsIEkgZG9uJ3Qga25vdy4uLikNCg0KPiANCj4gVGhlIG90
aGVyIG1pbm9yIGlzc3VlIGlzIHRoYXQgdGhlIGN1cnJlbnQgYXJtNjQgbWFya2VyIGlzIGFsbCBi
aXRzIDANCj4gc28gYnkgaXRzZWxmIGZvciBhcm02NCBfTUFSS0VSIHdvdWxkIGhhdmUgbm8gcGVy
Y2VwdGlibGUgaW1wYWN0LCBpdA0KPiB3b3VsZCBvbmx5IHNlcnZlIHRvIHB1c2ggdGhlIHRva2Vu
IGRvd24gYSBzbG90IGluIHRoZSBzdGFjayAoSSdtDQo+IGd1ZXNzaW5nIHRoYXQncyB0aGUgaW50
ZW5kZWQgbWVhbmluZz8pLg0KDQpQdXNoaW5nIHRoZSB0b2tlbiBkb3duIGEgZnJhbWUgaXMgd2hh
dCBmbGFncz09MCBkb2VzIGluIHRoaXMgcGF0Y2gsDQpyaWdodD8NCg0KWW91IGRvbid0IGhhdmUg
dG8gc3VwcG9ydCBhbGwgdGhlIGZsYWdzIGFjdHVhbGx5LCB5b3UgY291bGQganVzdA0Kc3VwcG9y
dCB0aGUgb25lIG1vZGUgeW91IGFscmVhZHkgaGF2ZSBhbmQgcmVqZWN0IGFsbCBvdGhlcg0KY29t
YmluYXRpb25zLi4uIFRoZW4gaXQgbWF0Y2hlcyBiZXR3ZWVuIGFyY2gncywgYW5kIHlvdSBzdGls
bCBoYXZlIHRoZQ0KZ3VhcmFudGVlZC1pc2ggZW5kIG1hcmtlci4NCg0KU28gdGhlIHF1ZXN0aW9u
IGlzIG5vdCB3aGF0IG1vZGUgc2hvdWxkIGFybSBzdXBwb3J0LCBidXQgc2hvdWxkIHdlIGhhdmUN
CnRoZSBmbGFncyBtYXRjaCBiZXR3ZWVuIHg4NiBhbmQgQVJNPw0KDQo+IMKgIEknbSBub3Qgc3Vy
ZSB0aGF0J3MgYQ0KPiBwYXJ0aWN1bGFybHkgYmlnIGRlYWwgdGhvdWdoLg0KDQpZZWEsIGl0J3Mg
bm90IGEgYmlnIHByb2JsZW0gZWl0aGVyIHdheS4NCg==
