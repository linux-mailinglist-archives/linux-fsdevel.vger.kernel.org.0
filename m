Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF3770631
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjHDQoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjHDQn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:43:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85D46BD;
        Fri,  4 Aug 2023 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691167435; x=1722703435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rMovC5o/ZiKHHGWNnbq2eGrssKA7dxxBz2nNrvqCMq4=;
  b=KyOCh0KrFP6lcPInrzLPRSGYDwd3t9mhXb+VzCYEsm84u1fC+Mx8HJy3
   T6P48AVUSZqk6kioJx6GiVMpuPdDw9I7UCIR21KB3mQX6+YJNFyoueI8Y
   w40VCCR72s8MnYU4VLwGkr3UnM7VBHGqNNRHCvf4abgCGGvnPTunxKeVU
   MKaEjGut2rRjznY3BfhVmicwA+/Zkfn+DDvJeGguxoPqCuPFe8OWlCk49
   3MPytAM839A6R7CKBu3Hwq5GOcDz6wk6cnlrgARq2dAU9vtY4vZaHJu+Q
   B7iAwPXR4Wt40WFf70euqhjQBTA61IU6rboqstNfEZKDiuVBOJPjbvjOD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436517029"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436517029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="707083148"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="707083148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2023 09:43:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:43:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 09:43:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 09:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gclw9BGOxLfprUiRhohkQtV5QeBsJ4WSl7TiLRR2auZ2Npyexm4ahhJXTQ1ZFrU7O1shj8R8sgMVpYu+zA3qbGXZ7xJpH4b/IV2hXJl7rLuMNRW1gewH0Qrhyxwi/Nr759RG4qbbX3YWi2c9A+UH4hIGQEHoRvai/h/1dbeAHxc/sA/RG2bj5AoPIgFlaLN7A1HfysgCp3c/zOWzYtDUnx0jb0lJanbAbbI4Gjvex2zwX9vDwq35q4bWomi/ggthUZu2wZDbk6J8Yf9koOkzS8V1qrPAWrFk+vFJZ9BCOGdjEs1xjAE50W+75N9BpU3hEWn4qduuCWmH5GbKK6+jKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMovC5o/ZiKHHGWNnbq2eGrssKA7dxxBz2nNrvqCMq4=;
 b=XbrAd6b88M/JzhbjnSbFVhklCygtSBAmkF4aMpkLW/OfFZaiXspDukDD234Ya2C5uaqJUpjBN31T/fu9mJKRKh+aI+BSz3KkvcJe/6uaCtCTUzlhgAgOTGsthktZ8a09cbtAkJmF/bB51i3EcaAosMXq1FetfgZj2JRcKRGR9erZ+WUYl9yQUzX8BuXrFdlO15Y0qCZ2jDOYUm0ITX1ri9xB4TuT6fYSA7TCUW9YzBnJQ5UtWog4vQ1nrZnf+kYaCQUZWiYCfl5yjwOnXQCEhyU8MDtuF05OQDW3aAVaJ1Tc7Vuc0BxES5ov7aJ7FUw6MZLBue8baULKwYkEJmDtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 16:43:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 16:43:45 +0000
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZw7ZZVWMs6JZuI06/zv64SypFG6/UB86AgAATdQCAAGg9gIAA9o2AgAAzsICAAA4DAIAAMoYAgAFG1ACAAvVKAIAAM9kA
Date:   Fri, 4 Aug 2023 16:43:45 +0000
Message-ID: <a21ab778704d02b8539e5c459750f8a2f771bede.camel@intel.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
         <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
         <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
         <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
         <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
         <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
         <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
         <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
         <7d03be1277a5f4be23df35ca96f4d6cd77735e2b.camel@intel.com>
         <475f31e1-0f6f-44a9-b93a-540c1d43e1bb@sirena.org.uk>
         <9902dd7e-1427-4c7e-b602-c1fbf6512f10@sirena.org.uk>
In-Reply-To: <9902dd7e-1427-4c7e-b602-c1fbf6512f10@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6404:EE_
x-ms-office365-filtering-correlation-id: 10f77aad-9f96-444e-c543-08db9509f82e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFc4CY/1iafeeUgm2Jg+rCFp9Z9V1mNkjwBkvYASvB+575lh6RxridLQM2CDuHvwGVClw/zzwacHSOZ2oOUG+nHDEPlyWoggaDJ1tbpiHcOz7ZTfFDwF6QPviJ3uqiBZSKmVeEIWaTXfHjRmHcNJfaV+Em9lARwLTVNt60xnHyHv1J4556g759ojHpoZ+g0Mxj9zQeHXNBbfikH/TONdRWPxqzgcV9TNlWRVrPgOWOTHWRfi56B76Vq0NbFrvtM43YEdKFh18XbMMTXNQq0fODGucUlyoRYWVBaX4ozZ6ZBlA0TG12iKqllqVrfW1mu9UalLbYqvXxjK2+psGdflz3vi2PVOak5+mVd5/9VHTLS7ut6axv4RpbjGFdz58wMeX3eXgYgGYfrbL0YXoezdm9yrz+asSczbIMPO3R4knDMaBGuBJd1Dm+YBcYclnhGu8letsTzYzs1NoY+rjo67RIPXpwLIEKIZXAtfy//bw+vyDoxryt2dJPLtZcpRizDPy9D/j0Zg1DVt0psVtPLdCLZJM416V5/l6lBZDHc0lNjPhDXW+WnYs2HqmRqmwnpKjWzSaGRPziaPLFRNBjZApyKfFOw9BS4k/gcQBkROiU/E4FYbULr4uzAoTn0QCLcB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(1800799003)(186006)(83380400001)(2616005)(26005)(6506007)(8676002)(76116006)(91956017)(316002)(2906002)(66556008)(5660300002)(66946007)(64756008)(66476007)(66446008)(4326008)(6916009)(7416002)(41300700001)(8936002)(6486002)(7406005)(6512007)(71200400001)(54906003)(478600001)(122000001)(38100700002)(82960400001)(36756003)(86362001)(38070700005)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDdDZm1nWWNUb2R2YUVHbnc1NEJIa1JlNkZCSE1iUjJhMno2TS9VaXZYWkxW?=
 =?utf-8?B?a251bm1ScUNoMnQ4a0xwbGxGTjFuUXg5aXBHczR2TUFLS2Q4d3NOVjUwcHNa?=
 =?utf-8?B?WDJIaFg3dy9ISk9DV1dxcFMwR2JaS21XUFBzMDRBQ0Z5RVBIYzNvTFg4OTFW?=
 =?utf-8?B?RmdIcW5GOFRQQWhIL3czK05OZDhjSlNZaHU4R3hzcnhneXJVWXFqelFHOEh4?=
 =?utf-8?B?bVRuZzQvYTRnSUxvUHpycFlaQVRLeHplUTNIamhMT080QThRS1ptV2U0bzNl?=
 =?utf-8?B?NmRuUjhxYTJBYkNkWU1JaXB4RGFRT21GdGNkdDAxMkd5bHk4d0JBWjVyV2I5?=
 =?utf-8?B?R0lQWUFoRStYMkg2dHA1b05QUU9KelVYVGxvRjVEUTlBSzhnajN2azQxaFFX?=
 =?utf-8?B?SWtzM0VGVWFibEJCZ3FpRUJNWUU2UCtHdWExOXZQSE1MSXdKQUdOWUwraTFI?=
 =?utf-8?B?Y0ZrdW1PSW9JRE5XeXdwcHhOUEZDV2g0bUp1T1V5YzBGY0FzbzM0cHZlUUN6?=
 =?utf-8?B?SWJVcUVQSFVqRTVHUm5EMEtNQk44cVFRbTZaaU02U3FscGd1cHNBbTJSeXZN?=
 =?utf-8?B?Z3BxeFBONGs2YjhLU3hHQjd6bjM1THhWdi9jRm1Ud1RIT2ZKUUtyQXMvNkV1?=
 =?utf-8?B?Y1NvRTR2emNBZytvWnlac3ZhRElHamVuUUExQXVRU0NDeHBpL21BSGpucWRk?=
 =?utf-8?B?U2NuMVZCVkxkbjhIbE1wTW83ODE5ME9Pd2RIWmNTYnF4RmhJcFlHWXV0U3ox?=
 =?utf-8?B?dFUvMUZvMHVRVVNXNlpTR2htV3pVYmk0ckdrR2hlQXZGelBKMFk2MGxWbUFY?=
 =?utf-8?B?RTBaRCtQdnRUaktpc1ZNakNGUm5lYURPYllJalVsNnQ5Wm51RFJuVEt5bVBV?=
 =?utf-8?B?aVJEOGVzb2VFYXhCMUNSQkE3SU5XL1BJNjJHRjBqVjlEWnFRQkt1TFNJUmNQ?=
 =?utf-8?B?dWZDazQveTVYMzRreEZ0T08vRiszYUZPeGhDZk1nZDFycWNYbEZ4bjV4azA0?=
 =?utf-8?B?R1hRUmdyODcvYm03MjJhN3QrN2RrdWp5ODIwN0NzdEMrVUpUb1lzV2d0R3dk?=
 =?utf-8?B?UUkyK2F4c0NsMEoyQmR2SXFxWk9Zbk42bUxleDBVeTE2OG5YbnJpZjFJdHhE?=
 =?utf-8?B?TDhnNHZVbDJkNmZ2Y0VLbFlrRW5odjBpZzlSZUgzeWFuQkFnY2dTU3kwQnlB?=
 =?utf-8?B?ZXdESTNHYldZR1o3cG0ySmxtRWNYTXp5WTNQajlZTWwyVHRMQ0VmUi9zWm15?=
 =?utf-8?B?dTBLN0R6WDUxYmg5TVFjZFdWOVBCWloyWVlXS3BFK003L3o3THE0cFlla3d1?=
 =?utf-8?B?TENlcjV4RDhCSUN0RmpkMitGOUtiMVJhOG5aUHVQOEpzUkt4c2N0ZU1uZHd4?=
 =?utf-8?B?Rkl4OUJScU1MUXBmVlNKcUdIZjNxMlBORXh5ZFhYdEkwSlpDdTVjSm9KbkM5?=
 =?utf-8?B?ZExCbUNpOENTaUQrcVJlNlRtcFVncy83MUp4b2VMTm1uazFkeDkxTHFMcmlR?=
 =?utf-8?B?NDRaQXdEcWtFVWg3N0ZxcHd3U1NEelpxQjcveDNYT2p3Y0tsZE0rd2tFcFRO?=
 =?utf-8?B?ZTNMSlFPeVBzeFc5VGg2bWJzNjBTZWhNd1R3Q0I4VnRMRlZ6SE5Nd0M0YXNm?=
 =?utf-8?B?RVBZS0NYMUZLSFpHTDl6N0xNRGpmMS9UZlNrNXFLN2dlTU1GdXlSM1g1R3JE?=
 =?utf-8?B?ZmZqOXliS1Z6T2NFQzFRbUwybmduUlR0Ui9jZE5zMnUreFFFSlU0VDk3cmR4?=
 =?utf-8?B?WHo4WTJBcm96WU8wemtDQ2VacUkrcnU3dm5vd09vMTVOY0o3cEVsekJkVU1Q?=
 =?utf-8?B?U0Y2WDF3ZEg2Z0Zya2ZmWndkT2FZUWlLTFg4U290cGMxVlpyOVZqdUhucDUw?=
 =?utf-8?B?OUV4S2h1WmQxUVhKdldOdG5Fc001SWFKd084b210NGZYdmM0K3FkOTJvT2tw?=
 =?utf-8?B?VXhibkZ6UFlCRzl5cFppWGVRYitFbzRmV09LOXA0RmhWRjVxa3VxREY5ZXgw?=
 =?utf-8?B?d3UxNHZ0dVVwSGlUblVYRm11L2w4MUdsUDRjemw4U3BGUnVLblJ5aUpwS3pC?=
 =?utf-8?B?VVFkY1JabXNtVURJSkEzL1JnZ1lyWXF0SFhBbUZrZHNCYTJ2WldvM2IwRVpS?=
 =?utf-8?B?dTRLTmJIeVBvYUw3cWVtYlRTaFRyVUlocUt4Q3FzbCtVNXhBRGpwQmlEbko1?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2165CA49514CF64FB547D94591ECAC4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f77aad-9f96-444e-c543-08db9509f82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 16:43:45.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUdxMV/1T/BbxB+IlYj7saw0Z925kGk4pECYcuRmu0D1Nvvw1AfZz+cMogSpEz97Rl1kBY35EK+GB2cNt76wbcZ5Tc49IOHj4IoSf9bDoT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDE0OjM4ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEF1ZyAwMiwgMjAyMyBhdCAwNToyNzo1NFBNICswMTAwLCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgQXVnIDAxLCAyMDIzIGF0IDA4OjU3OjU5UE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiANCj4gPiA+IFRvIG1ha2Ugc3VyZSB3ZSBhcmUgb24gdGhlIHNh
bWUgcGFnZTogV2hhdCBJJ20gc2F5aW5nIGlzIHNheSB3ZQ0KPiA+ID4gZG8NCj4gPiA+IHNvbWV0
aGluZyBsaWtlIGFkZCBhbm90aGVyIGZsYWcgU0hBRE9XX1NUQUNLX1NFVF9NQVJLRVIgdGhhdA0K
PiA+ID4gbWVhbnMgYWRkDQo+ID4gPiBhIG1hcmtlciBhdCB0aGUgZW5kIChtYWtpbmcgdGhlIHRv
a2VuIG9mZiBieSBvbmUgZnJhbWUpLiBUaGVuIHlvdQ0KPiA+ID4gY2FuDQo+ID4gPiBqdXN0IHJl
amVjdCBhbnkgZmxhZ3MgIT0gKFNIQURPV19TVEFDS19TRVRfTUFSS0VSIHwNCj4gPiA+IFNIQURP
V19TVEFDS19TRVRfVE9LRU4pIHZhbHVlLCBhbmQgbGVhdmUgdGhlIHJlc3Qgb2YgdGhlIGNvZGUg
YXMNCj4gPiA+IGlzLiBTbw0KPiA+ID4gbm90IHJlYWxseSBpbXBsZW1lbnRpbmcgYW55dGhpbmcg
bmV3LsKgDQo+IA0KPiA+ID4gVGhlbiB4ODYgY291bGQgdXNlIHRoZSBzYW1lIGZsYWcgbWVhbmlu
Z3MgaWYvd2hlbiBpdCBpbXBsZW1lbnRzDQo+ID4gPiBlbmQNCj4gPiA+IG1hcmtlcnMuIElmIGl0
IGRvZXNuJ3Qgc2VlbSB3b3J0aCBpdCwgaXQncyBub3QgYSBiaWcgZGVhbCBvbiBteQ0KPiA+ID4g
ZW5kLg0KPiA+ID4gSnVzdCBzZWVtZWQgdGhhdCB0aGV5IHdlcmUgbmVlZGxlc3NseSBkaXZlcmdp
bmcuDQo+IA0KPiA+IFllcywgbXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgZmxhZ3MgaXMgdGhlIHNh
bWUuwqAgSSdsbCBkZWZpbml0ZWx5DQo+ID4gaW1wbGVtZW50IG9taXR0aW5nIHRoZSBjYXAgc2lu
Y2UgdGhlcmUncyBhbiBhY3R1YWwgdXNlIGNhc2UgZm9yDQo+ID4gdGhhdA0KPiA+IChleHRlbmRp
bmcgYW4gZXhpc3Rpbmcgc3RhY2ssIGl0J3MgbWFyZ2luYWxseSBzYWZlciB0byBub3QgaGF2ZSBh
bnkNCj4gPiBvcHBvcnR1bml0eSB0byBwaXZvdCBpbnRvIHRoZSBuZXdseSBhbGxvY2F0ZWQgcmVn
aW9uKS4NCj4gDQo+IEJUVyBhcmUgeW91IHBsYW5uaW5nIHRvIHJlcG9zdCB0aGUgc2VyaWVzIGZv
ciB0aGlzIHJlbGVhc2U/wqAgV2UncmUNCj4gYWxtb3N0IGF0IC1yYzUgd2hpY2ggaXMgcHJldHR5
IGxhdGUgYW5kIEkgZGlkbid0IHNlZSBhbnl0aGluZyB5ZXQuwqANCg0KVGhlcmUgd2VyZSBhIGZl
dyBwYXRjaGVzIEkgcG9zdGVkIG9uIHRvcCBvZiB0aGUgbGFzdCBzZXJpZXMgYWZ0ZXIgeW91cg0K
Y29tbWVudHMsIGJ1dCBJIHdhc24ndCBwbGFubmluZyBvbiByZXBvc3RpbmcgdGhlIHdob2xlIHRo
aW5nLiBXaHkgZG8NCnlvdSBhc2s/IEp1c3QgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgdGhlIGJlc3Qg
dmVyc2lvbiB0byBiYXNlIG9mZiBvZj8NCg0KPiBJdA0KPiBsb29rcyBsaWtlIHRoZXJlJ3MgYSBi
cmFuY2ggaW4gdGlwIHRoYXQncyBnZXR0aW5nIHNvbWUgdXBkYXRlcyBidXQNCj4gaXQncw0KPiBu
b3QgZ2V0dGluZyBtZXJnZWQgZm9yIC1uZXh0Lg0KDQpIbW0sIG5vdCBzdXJlIHdoeSBpdCdzIG5v
dCBpbiAtbmV4dCBhbnltb3JlLiBJJ2xsIGxvb2sgaW50byB0aGF0Lg0KVGhhbmtzIGZvciBwb2lu
dGluZyBpdCBvdXQuDQo=
