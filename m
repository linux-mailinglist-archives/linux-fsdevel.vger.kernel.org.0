Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16C4DD071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiCQV4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCQV4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:56:31 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D011FCD38;
        Thu, 17 Mar 2022 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647554114; x=1679090114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PHPwudfcWPkT6vIOj8QqVhipQixQN7MTdKKGH3s7D6k=;
  b=TTG+mfykPn7LKtH8mGaaeTKPwa0Nv75bajbHZ6hYHZjBPc3BFgXEyOKU
   Md0WceTABbQ3/Uz42pmMYEPT9YlbEzucf8j9a8NpQzM5ytgpmJn806PFR
   ryFkxz13IkmQoSAxX88Xi1U3W+evnoE0ek+rYp6L5EkNbh+gKLZu2ljfz
   WFdVlDzdQ7KXj/rVXherDGQfpdYw4Gz66tZytTMCs4QnzPk8KJO123viR
   0ALLRU7x92GrzRVybirlDOwiR8OYtrDehbwbujz8wXv7gmr3YWCP9MrXc
   RPV++PAWXq82Y//sJArokkZeaSaetmdpTmESAgHqS78jro9EVOB2r6mOI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317708554"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="317708554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 14:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="558124810"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 14:54:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 14:54:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 14:54:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 14:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG2fsmR1a7Kz2/6e++sDLyrLVQeUBPJUK2ORiuYaqt/UMqd2YMEGP5EFdg9T97XUDjX2+d1YIqu3BB+D+qmueWkl/bh2hdiD8enRPzh5sByEQ8DDoMfN+Lhh8grwXYzDoK7VP280SRgN2oQY2mwHs/8O1nJM7K5cuvxrl+HgtV8knEy6n3xFA4VecdcyRvgs/k2qOJUQA1AXYZVDyWDS+IiBqx1hhHPjij3L/6H4uRUaNTTP9SbiSjl2qTGc1IeGgf/iy+ISYmTmaIOu2aUOA2Dx/O4LfgMHPrX2rRwhg7qJWtYYUH6Fo+ASf1ryAqxbKVPhRoLwAVsSBg6Jaqk+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHPwudfcWPkT6vIOj8QqVhipQixQN7MTdKKGH3s7D6k=;
 b=b2ZGBUZZ4y3e/teympN5OW00RA9zGXoWthHa+MCgD/ti88ZXRWqdWoGZikZV9trvifflv0CHeYep5gasPLbBC0kWbHwHdSXfbiTE4OeUZi0GV1B394PiDi+ZGyqOluHA1fH94JpHG5a300NkzqLoYi+/l62s+ZUYNKQBEdZejK14t6Q6fak57s8N/GEg1rH5oIVbpj/LiOaR4H4FKI+Hs5L0qIn14bemIenV2DAZTceazRERcr62ue2Ff5CyINX893kkTfGznojpj9M32gazKwsWCUGM0EOw8uOpSW9gzOdYPLlDicLHIc5FyFINGqsLEwov5Q1AwLyAEbcLuwSiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4400.namprd11.prod.outlook.com (2603:10b6:208:18c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 21:54:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 21:54:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH v2 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Topic: [PATCH v2 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Index: AQHYOjQkQt0dpAs92U+89YeD49ZajKzEGMGAgAAGGQA=
Date:   Thu, 17 Mar 2022 21:54:52 +0000
Message-ID: <3ad2e3736c0062edd11960d1f476544e6543eaeb.camel@intel.com>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
         <20220317192013.13655-2-rick.p.edgecombe@intel.com>
         <202203171427.692F92D7@keescook>
In-Reply-To: <202203171427.692F92D7@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f6701a6-18be-4e9c-904f-08da0860c435
x-ms-traffictypediagnostic: MN2PR11MB4400:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MN2PR11MB4400B652407AF08EE62C62A1C9129@MN2PR11MB4400.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkikGMf3rCj16GNHDJ0xt5wAn/UU1N1kz0N6Z/RWEyXgtL7fuuYce1oUHJ7Sd2OGO+TIbge38sAnFff2m6QDlnuatKr03fb4rRX94G7CDTfvcvgszklQ+N0VDqR6+Gth4+3Lz6YyElXqCiNvO7J5Bg7mN3y5g8TNqzYWWzmJaCAMG3wEjmf6BWooh+/57D9rItten3mDtGFtrcKcTOiEjjL7od3cPZZYBHAMOsHtUa3hbUoAEMnqko+laie/W78JZNvoIBfMacUUzyQzet9dBr5sB8abjfckyxPtIlsAqopdzrjhjwv3gr2C1riaWx3mYL9v+MSXExqdaBNb0AoxqeYWheyUprvNtnL8xWZBP1cni79nCuJhZ9fWxmIOWQpmkmV54GdWXLiiupvW7VhVaXGVuik+Sp4jusmwcKaGrdsF1cni0d55bVoT573jNl+U9djtiH2wl6M7zFakBFVwKU9It+21WxiWOaeQFAJghiQJVlioNcLtC6+0F3wcRYkEHPBeSqnRluri20GvfIP6/To8rEcYpoVqXiJObr3rbTaUnZi2tuy+MvktUDoFO56LccHKdAxQqqqevn7CpgB9UX6YXasHkZ8NORcYb94EfDZV4Vl9J4AcdC5cum7zRuzhwIyA7arVY+xNp1TGKExmCaouUotqmyk2024Dj2lY+zrIutCelPGlZJpHHAI27FRHHVrILNU+8ADQxGELhP+mzj7KYTHPX9jm2vr/GzAsnJ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(8676002)(4326008)(6512007)(71200400001)(64756008)(76116006)(8936002)(66446008)(66556008)(122000001)(38100700002)(2906002)(4744005)(38070700005)(5660300002)(86362001)(6486002)(508600001)(82960400001)(6506007)(2616005)(316002)(36756003)(186003)(26005)(6916009)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnpVQmVkOUQ2Y3FTOTRKRGNQb3UvdkZSSk13M2FLTmNCbkUwUUc3U0V0Uzcw?=
 =?utf-8?B?THlLTWdtTWJYcDN3akkxOXZLeUp2STNlU2lQZnJtTy90b2JFaUFoVWgxcU5y?=
 =?utf-8?B?MXNLVEdYb0E5QzU3V2NTMWl2OURkT2NLOXh2MGRlRlZsRW1wKzVtRVBGTmVx?=
 =?utf-8?B?Uzl1V3RsdTlqQzlpOWVJbnhDQ29OR05qaGN1VkFKdWNzdFV3bEhDQ081Z0F4?=
 =?utf-8?B?dlUraTRnRGVuZURIRVNCeXNMek56bjFvc0tlUVl1SWNMbzhNdnZkVnNPeVRG?=
 =?utf-8?B?SlVjTkJOcWc1VHN3ZTB1WU0ySDhrQS9GS0hTUlFnLzg2N08xZWNJQmN4WFR0?=
 =?utf-8?B?VW1CNVhvakZDUm41ZTBacm9uRnJNWTRiTGo0T0h3Vm5tbk5DQjBmTzZ2Y2tU?=
 =?utf-8?B?VWw5Rm9SODMwcExwcUdZZVZrVGQzKzR2VVY0ZFRMR1hsN1dVSnZRS1ZDcnVz?=
 =?utf-8?B?N0pkdk9TSkF5ZnQ4dkxDa0IvNSsvRjBnSytiZStuekNUQ1NjMXcxSXZqT0hx?=
 =?utf-8?B?WHJXWVJuQ0NDVmJuZ2xIYVRzdlJ2akNvZjU5T1dtck5XclE0QzkzNmxWOVVR?=
 =?utf-8?B?Y3dHQS9NZDhIdjhpMzlCYmJ6ZWV2cCsvT015d0kwNlE0Y0xHT2svY3V2WE95?=
 =?utf-8?B?T2xHZ21OZzk3d3dxZVNIK0Z5ZkVuQU1SMjMzSGlWOTMrNHd5anRpZjQ5MDh5?=
 =?utf-8?B?bk1mTDdxWTFnbTlOb2l3TVRmbUs1UGdUelZaaHZoeVcwemRSdk10T3NTTko5?=
 =?utf-8?B?VmhSc0xGWFRjbURnenh1MFZOMWl1UW1vcGlQeUFTU29qY0tYWEdkSU4yS0Fo?=
 =?utf-8?B?ZzFGU05ZVGNrbXB4OFhhbGkwUXd2ZlBCd0VBTkVoOXFYMUdybnBNaE56bmVl?=
 =?utf-8?B?TUF2RThyV2VJSEFnUCtnMXg1NFIyM0V0S3NiZjVRc1RlL2hmNWVaYnJvTFhU?=
 =?utf-8?B?YlZCQll6SUpmVXlmWHRGNkJmaWFydFYzelRaeUppWnVTa2VwWG1mZjMyeFNT?=
 =?utf-8?B?U3hCV0hyRVhwSm9VWGh5d0ZJUlJpekNBZDZTOHh5VUg1Z3pYb1RaK3JUclZy?=
 =?utf-8?B?NFlhRnhIUWZ6bzhscUNtOXcwM3B2aVpQWVkwbW9GdmFoZXhGUmFwZEovOHRz?=
 =?utf-8?B?SEs1VGloYWpuRjM1K3JVQzNlWWNGNm8xQUhSVXBMNWhOZG8wMHRoMjNTVmR1?=
 =?utf-8?B?bmRma1RGK0FLRHB6bGJtYW5JUXY3Qk1jc3B3UVR2Tm95ZmFzN1BEL0pxYmZS?=
 =?utf-8?B?c3hpWWJLU0pzelE2cE91RVUvdFl5bjhSWTcySW9EVWVxMXVFVzBZTC9BSGtt?=
 =?utf-8?B?NmtvWkMwQnpDdTFkVjBDZVBYbjU0dURiSkQ0THl5NUs2elF2RitLTWorY01x?=
 =?utf-8?B?TWZzT3ZNTkJROUpsbkFnbEVzTVdsQ3lsV2JtSGZMd1FGSC9rOU05aFFhMENJ?=
 =?utf-8?B?N1N2bmRkdEwvQkpmYlFBTXJkbmQ4VkZEb3pUUGxITmNaWVQ1Q2NDUFdzcHVX?=
 =?utf-8?B?dVIwTDV5eU5LWkZIWFhMVlVmS2xrb3VWWGRGL2VucitESWl5dmJlR29vRDRo?=
 =?utf-8?B?ZnBnd3BmaG90VGFENmtHVEJYS3RsTHB3aGZWTWhyNmlhT2p3L0J0ZWUvdC9l?=
 =?utf-8?B?WjZ5SWxvOFlyV1F3Tmgzclc1RHNiL2hZejd6U2IvRnpPVE5yYlBRTjczUkd2?=
 =?utf-8?B?MGpoR3NwZXZiaE12MXRuckc0ZTBpamk0ZjF6K2pidEQ5QTBreWRNVWxBRjVn?=
 =?utf-8?B?eGNwZHJINHRlUnNjZUF3dnZ1MFAyK1pjNUV3N2h6RUtTYnNaaSthRVJMSW55?=
 =?utf-8?B?dmlxQkpsREhZZE1wWG0zRTlpWTBpN2Y4Q3dxYmI0VldnWC9oK3hsTGJ5VlRw?=
 =?utf-8?B?REZkZi9lQitQWllkdk9YaWUrK0RoY1hUcFRKQ3Q1SXNVdEZ1cDR0YXl5cWZo?=
 =?utf-8?B?M2owNE1aL3NOTWYydmNJTXpUNjcxRHdFSGhYZytRWW03S3lDQWs0Tm1Pb21t?=
 =?utf-8?Q?9qmd96ycLSUKqCgcSQ8GIy6RWf71wo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99DA881584B326499DFA1CA0CD9696D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6701a6-18be-4e9c-904f-08da0860c435
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 21:54:52.7292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pi4RYLduXoOrEgnGWVBSrL2HcnvfIuOO37T3jEoP7KeOyptRMKfUM4lHrvPXTw2lTRkopAX3gijY8CBm35GL+WzmOJHD7WcCvKZ7kNptcGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTE3IGF0IDE0OjMzIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IEkg
dGhpbmsgb2YgIkFjayIgdG8gbWVhbiAiSSBhbSBhIG1haW50YWluZXIgb2YgdGhpcyBhcmVhIGFu
ZCBzb21lb25lDQo+IGNhbg0KPiBjYXJyeSB0aGlzIGluc3RlYWQgb2YgaXQgZ29pbmcgdmlhIG15
IHRyZWUiLiBXaGlsZSBJIGNlcnRhaW5seSBwb2tlDQo+IGFuZA0KPiBwdHJhY2UgYW5kIHg4NiBh
IGxvdCwgSSBwcm9iYWJseSB3b3VsZG4ndCBBY2sgaW4gdGhpcyBwYXJ0IG9mIHRoZQ0KPiBrZXJu
ZWwuIEJ1dCBpdCBkb2VzIHNlZW0gIlJldmlld2VkLWJ5IiBpcyBhIHN0cm9uZ2VyIHNpZ25hbFsx
XS4NCg0KSSB0aG91Z2h0IEkgcmVtZW1iZXJlZCByZWFkaW5nIGluIHNvbWUga2VybmVsIGRvY3Mg
c29tZXdoZXJlIHRvIGRlbW90ZQ0KcmV2aWV3ZWQtYnkncyB0byBhY2tzIGlmIGFueXRoaW5nIGNo
YW5nZWQsIHNvIHNvbWUgY3JlZGl0IGdvZXMgaW4gZm9yDQp0aGUgcGFzdCB3b3JrIG9uIGl0LiBD
YW5ub3QgZmluZCBhbnl0aGluZyBub3csIHRoYW5rcyBmb3IgdGhlDQpjbGFyaWZpY2F0aW9uLg0K
