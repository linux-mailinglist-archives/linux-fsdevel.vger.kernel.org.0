Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7433F613FF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 22:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJaVdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 17:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJaVdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:33:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93212756
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667252025; x=1698788025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sq5pGr2xVSphQ2ON13lkWJUwJidXnoAbUq6Tw7zq6cc=;
  b=UDLMT1qO7H8WRl/6CICexB7LtYxvliWEPGj3S3CG30doaFJ4oqxGE3j8
   3Vrce3MOXaACpIY3zSLFyEr0NuCF+rRsOxmln4/+tOOlU9cXNBoedPpq7
   YHfxaxlGufsMl/i6NmYihyH3jV7dy3n9CdXUBd0A3qQgRsXF+Y8UlN5xS
   YWws7FWMFdlMAL1w5KEyhCSdtzTE0ZkoRwGni4rVEq3nDfelFYsGbMgeh
   /Kd6zv8Yyend3p40Fi5zyY0bQPmGvvpzh9cC7vi67D6vLAQTp1ZaEWNw9
   mIJ+Y4fghAx+WMfKJw2hvhtpCDO/zzW0d3Ssen/nlVL8AeV/rt9SerSul
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="289395085"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="289395085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878882321"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="878882321"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2022 14:33:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 14:33:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 14:33:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 14:33:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr2cS1xIgWaG6mZSOOnS8zYZHwG8ZKVz4cDwPhCFEq1t0ItnBb+IDbpmVGvBKsScQpA4bUydHNxC65lMr3fnFjHZsL4T9hb1QHVu7wRG9I/gqFzGqi3m2qx5XNWtVuh1OresOqS3hMpBu2QAwYmY0plRnlknA1fjZxABm86WZXw8b0NMIMr0ygkmF2Z5482WIt/Z1aWRrtMvlD14+tXBli+1RkLd4tE8wh9ASLcal8GfSOpuVGJvRDWArid9dObqYCR85mzWhhlEzrq5gKXABKJJMdBILuGak7qLSpbhu8VEjlBMq524AC+GnUe8VV3NLMsrpj7/fnE8BrW+I2vnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sq5pGr2xVSphQ2ON13lkWJUwJidXnoAbUq6Tw7zq6cc=;
 b=acfTzUA3KONqeRWilg1BfN0B0PvYpJWCpIv0RWQHfw+dGCFz851QUBBQU7YDHdde7cFtu832BsRp2m0DQ/oZ3o4JkFXQjd821jxDIkMJ4xEiU6fYNYQsyCx7vQNL9hSRBESFhGKhjfVMCcwKh1+zkB87QTXiaenltugaYv8pu6mfLZZihjbDMUUy31vYb2izA+ujyt1QIOcdG1Mk0OgUT1N0CscZnA4qzsrkP1pgln9rL5/h5xJaIYDb4DslIGZa2oFAlRcvoskvlFJXbpZ8TKMakRBgLK23klmr+ZvHvfmRMW/u93uSIbYDsBrZKkYdWkzn7MaS2T0d8b5O9GA/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 21:33:39 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 21:33:39 +0000
From:   "Pulavarty, Badari" <badari.pulavarty@intel.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "huangzhaoyang@gmail.com" <huangzhaoyang@gmail.com>,
        "ke.wang@unisoc.com" <ke.wang@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Topic: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Index: AQHY5Zz4BT/DMcb+H0K5D/9RcgEw0q4o776ggAAF94CAAB9/oA==
Date:   Mon, 31 Oct 2022 21:33:39 +0000
Message-ID: <DM6PR11MB3978118D60C73DE4D7A7E8AA9C379@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
 <Y1Md0hzhkqzik/WA@casper.infradead.org>
 <DM6PR11MB3978F27D63F743CDA577645D9C379@DM6PR11MB3978.namprd11.prod.outlook.com>
 <751d242-20a2-3792-d39c-29531b40c37f@google.com>
In-Reply-To: <751d242-20a2-3792-d39c-29531b40c37f@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3978:EE_|CH0PR11MB5236:EE_
x-ms-office365-filtering-correlation-id: b8217bd8-46ec-4f22-1ab7-08dabb87933e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnJJcg9ZwuULhtqS3nNPV8o2nWBmZwjq1g+GV5qgy2j9CqzY0IuZ9aLSJPxOX3HXyqBeJ6hwWeaw2r+6aggvWIRy0rM/e+uwO8JI+kjdO+5klQumwfyQVUZm7G/Nej4J0VE7IQYlEHe17mL+55fhLnq4RAb3HV40hJeqH1mL9YbqgjcB6B9bhR1BVdi0y7LsVjc5o9UKMHyVlI2S608ckWBzu0ttkEFbcIQiJPmrfn0R2B2RqW6jC6zu+cQ8fVmcCTT7yADXzSOCZmineY8FAOnIxO977gGQuLoQ1mX+/X/AUCEyHaBItODcST3TRuPQC3j2ygh9sRC7Ee7bdmAsIW79OuwsSVosONm2HjRb0mIMJ1raJUdXk4Ztqg5T0DYLS9WuhPXN9uwirQEJEiYL504ncxkxb3ESqo5BbKKGiH2V4TJKrp9upGDiGPW2kdT8mFT6/Wi/NrxNPBYJ2X19WuF+g0Bkv54t8wtJ+KWIlicNFdjnIbeAvXxYRN1RiYoXbtDKknUjY5KyupUduuDMOzIiEBTPUcsZz4ck7GiLPHdNQQyyJ+UU7Rdr2K1bKFAKe+RHuI+W9VwEGSuxt1oYDERZjwttVdcRiHiBWvF63gYZR3BYjdXSwH5j1G0PV1b1KXa1E4CiXLEjU5WPVoh/0jwJ38XlkhkcnCsUIkDkNXpucRCau8vuUCgW7x23hYdtn6QYsp5BEAm0XfgzN6T0qbUbPBayjfbMpeqdhW8kBtYzlAHO7+mLTuwe4cKexQWY/Z1mf88edwbYIQGtBJRodw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(33656002)(86362001)(122000001)(38100700002)(82960400001)(38070700005)(83380400001)(55016003)(2906002)(6506007)(7696005)(9686003)(53546011)(478600001)(186003)(26005)(107886003)(41300700001)(316002)(52536014)(54906003)(6916009)(71200400001)(64756008)(66946007)(66476007)(66556008)(76116006)(5660300002)(8676002)(4326008)(66446008)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhhQ3pFQkJiRzc4b2JIdGM3SmxkZUxHdTYyNXJ5WTJpUVhRdGhMYmFzT2xZ?=
 =?utf-8?B?Vm04UFNZZE5tMFdyQWNRTnBqR200Nzk3Q3ZscWZXSjJ2RFVkcDhNYi9pS1hI?=
 =?utf-8?B?cHRyQ0ZZT3BKUG5xd3R0ZElvODZ3d09tMTgvU2pnRHA3RVhzTDhRMWpnU1R1?=
 =?utf-8?B?Z21iSWIwWXVqb3lneTN4Q09FN2N4WmF3YVAyK3ArV3B6WmxYajhDdWJnUXJ4?=
 =?utf-8?B?Mk9iblVLY1FNeUxhekdNNzZJVEp0UG9SQ1ZmSkRDczFUVStlQ3hsd3ZWNzhK?=
 =?utf-8?B?Qk1wcjFhN0QzamhWZENsOWg4Q0FpTUhQdnJzRThnNi9JcHd6d2VIQURoRko5?=
 =?utf-8?B?UjNsSzJuTUs4Z3luTklMTVdiYlB5aDVKeHJrM3lwOW5LNEpRZTFzak92dWJ1?=
 =?utf-8?B?Z0p0WXlHNWovSE1renJwb2ZOQjRrUjdUOWp1S3E3Z2ZGV2RKTVRBU3F1dnhV?=
 =?utf-8?B?aWdKb1grUlBqdnNzaDV4ZHh4bjVqZDVqc2dnTHNOc2tQTTM0RUo4VUlKOSs2?=
 =?utf-8?B?d0lTNytmeGo1YmlyTlRYTmRaeHE4Zm93QzFHOWp2TTF5ZkxGUnErVEcvUy90?=
 =?utf-8?B?WjNNWnIxMFJXenZGVmkyTVBQVWlKYU5CbzE3ZXd5cWFaOFBHSm9CRnJCQU5S?=
 =?utf-8?B?Q1lYYWE1WDNMU1FjSHdMV3ZDcS9UdWlRcVNXUDlyN3lYNk5BTUdObUtWZ0dU?=
 =?utf-8?B?K2QrUE1WUy9iTmYwcGU0akpXSElYZUZOWS80ZTM0UmZyV2lNeGJRNFhqQ1dy?=
 =?utf-8?B?VDZCc3VBcDRXTERDbGw0M0pLTmpvZVBpWHhON3E4UktpdnNVZUFvQURDNURI?=
 =?utf-8?B?QUlCemIyVGo2a010TWNSelREWjB2TzFCMXMyajllaTU2RWduYUt2clk3UlpL?=
 =?utf-8?B?bFhYTXlMSWNoYmJKZkdvTVVBcDlQTEEwUEJOUmthM1JLRmpXVjlXREhsaVdj?=
 =?utf-8?B?bFA5eEpQOUZkeGE1OHh2N0l4TitIN2FqZERWT0ZFTUlXYnBiZExLbm90SG82?=
 =?utf-8?B?K0dmbkZNV3BZbEV3d0poOENOajBzSmlrRFdzU01CRXVwRXhCdk56Y0FQbWx2?=
 =?utf-8?B?Sm9vZGQxNERoRHVuTFdVcjJIZUQ1UkVodHhKVThXU2FiMzQrSEc5MTNHRHUx?=
 =?utf-8?B?WjlFR3I1TmtJeGtpcEFuNi9pTXYrMEJDMnFGdENMT1JEbW5NWFFsMW9OdW1V?=
 =?utf-8?B?dGQzNXA3ZS9qbURzOHhGeWZPYStCcXJMU0RTRTM2NllONzJkczM5dkFwUVZx?=
 =?utf-8?B?eTFjM3VESzVxZDQ5SVlUN3BlU3FMNUM5WVcwT0FmZGEvdFVoakp6aWpQRWlI?=
 =?utf-8?B?MmN4TGF1TXhWaEFYUE93T0poQ3FCRDUvZWNqSDNHRjZ6U29NNzJ6MU1sa2wz?=
 =?utf-8?B?d2FLdXZDVkhvRE0xTTRkVkF1cUpCK2VWdGt1QUd5cFN6NHgwaXJpODczQ1BD?=
 =?utf-8?B?T1h3b3RVZjBUUGhoUGdXdENiNG9rWU11bHVBM2ZLU1l5cVNjV1Q3NUZpajM4?=
 =?utf-8?B?UzJZYkRrUkhNYzl3S3dWM1lyNG1LU0lJYmVneFdiemFWcFdGblQ5RzlWTnhk?=
 =?utf-8?B?QWh2VlEyd0t1SXh1VHcrOGpBeFFTaHdOazRyQUpZYzVYZkhjU1pXMDdzT2N1?=
 =?utf-8?B?ajhDRHdyS254WU92TGYySlZIaU1RSkVhTTkyTlBaS2F0OXZvZHFjYVdOMkJj?=
 =?utf-8?B?Q3B3TjQ4czRrMjNNVjd2V21lK3hzYmRFTVNzTjlRRXFUaHVpMDZOOGtDR2VN?=
 =?utf-8?B?ejdTNFRyOFh4VElTSWVYSGxRRGQ1Tm5hc0hydjN4NURpL21hNjU1WGdYZmZm?=
 =?utf-8?B?L01SOGs1RnRpQjdWZjhnRmdHNnF5Sis4THovUXNVY2cvemVUN0dWdFVHaW9o?=
 =?utf-8?B?USsvWVRyVlN0VTNDVkFmTWcxTUJYVGxkdk10ZVBXU1NucTNXa1dmRlg4WlZ6?=
 =?utf-8?B?RE8vYmsxOStURThzMHd4d2l3TzlxRy9YdG04L21RNWZpbWVVNUdkRnUzR0Yw?=
 =?utf-8?B?UjV3TXplcVkrSVMrTGEwanFpVzdydlFwaG9OWHlQN0d0R3FLN3NJSEMzakc5?=
 =?utf-8?B?N0Z5YmZ3T1NFREF2dWh3am1JTFF4bWNiM2NBa2wxK3IrR0pBWnA1KzhDVmN1?=
 =?utf-8?Q?CFQsPCgHULflX1farkrgDHksZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8217bd8-46ec-4f22-1ab7-08dabb87933e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 21:33:39.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hbz4zND1f6J++sBi3OaigdvQ1krd9RbzjPhW4O9HrOv4aN+8GjSO9DhmJLxLvALw3pGeCJXIlY8TE9u6lm94PiHvAw6qvMd1G/RulF7y85I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gDQoNCldpdGggNi4xLXJjMywgSSBhbSBhYmxlIHRv
IHJ1biBteSB0ZXN0IHRvIGNvbXBsZXRpb24g8J+Yig0KDQpJIHdpbGwgbm93IGJhY2sgb3V0IGFs
bCBteSBkZWJ1ZyBhbmQgdHJ5IGl0IGFnYWluLg0KDQpUaGFua3MsDQpCYWRhcmkNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEh1Z2ggRGlja2lucyA8aHVnaGRAZ29vZ2xlLmNv
bT4gDQpTZW50OiBNb25kYXksIE9jdG9iZXIgMzEsIDIwMjIgMTI6MzkgUE0NClRvOiBQdWxhdmFy
dHksIEJhZGFyaSA8YmFkYXJpLnB1bGF2YXJ0eUBpbnRlbC5jb20+DQpDYzogTWF0dGhldyBXaWxj
b3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+OyBkYXZpZEBmcm9tb3JiaXQuY29tOyBha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnOyBiZm9zdGVyQHJlZGhhdC5jb207IGh1YW5nemhhb3lhbmdAZ21haWwu
Y29tOyBrZS53YW5nQHVuaXNvYy5jb207IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tbUBrdmFjay5vcmc7IHpoYW95YW5nLmh1YW5nQHVuaXNvYy5jb207IFNodXRlbW92LCBL
aXJpbGwgPGtpcmlsbC5zaHV0ZW1vdkBpbnRlbC5jb20+OyBUYW5nLCBGZW5nIDxmZW5nLnRhbmdA
aW50ZWwuY29tPjsgSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgWWluLCBGZW5n
d2VpIDxmZW5nd2VpLnlpbkBpbnRlbC5jb20+OyBIYW5zZW4sIERhdmUgPGRhdmUuaGFuc2VuQGlu
dGVsLmNvbT47IFphbnVzc2ksIFRvbSA8dG9tLnphbnVzc2lAaW50ZWwuY29tPg0KU3ViamVjdDog
UkU6IFtSRkMgUEFUQ0hdIG1tOiBtb3ZlIHhhIGZvcndhcmQgd2hlbiBydW4gYWNyb3NzIHpvbWJp
ZSBwYWdlDQoNCk9uIE1vbiwgMzEgT2N0IDIwMjIsIFB1bGF2YXJ0eSwgQmFkYXJpIHdyb3RlOg0K
DQo+IEhpLA0KPiANCj4gSnVzdCB3YW50IHRvIGdpdmUgYW4gdXBkYXRlIG9uIHRoZSBpc3N1ZSwg
aG9waW5nIHRvIGdldCBtb3JlIHRob3VnaHRzL3N1Z2dlc3Rpb25zLg0KPiANCj4gSSBoYXZlIGJl
ZW4gYWRkaW5nIGxvdCBvZiBkZWJ1ZyB0byB0cnkgdG8gcm9vdCBjYXVzZSB0aGUgaXNzdWUuDQo+
IFdoZW4gSSBlbmFibGVkIENPTkZJR19WTV9ERUJVRywgSSBydW4gaW50byBmb2xsb3dpbmcgYXNz
ZXJ0aW9uIGZhaWx1cmU6DQo+IA0KPiBbIDE4MTAuMjgyMDU1XSBlbnRyeTogMCBmb2xpbzogZmZl
NmRmYzMwZTQyODA0MCBbIDE4MTAuMjgyMDU5XSBwYWdlIA0KPiBkdW1wZWQgYmVjYXVzZTogVk1f
QlVHX09OX1BBR0UoZW50cnkgIT0gZm9saW8pIFsgMTgxMC4yODIwNjJdIEJVRzogDQouLi4NCj4g
WyAxODEwLjI4MjMxMF0gIF9fZGVsZXRlX2Zyb21fc3dhcF9jYWNoZS5jb2xkLjIwKzB4MzMvMHgz
NQ0KPiBbIDE4MTAuMjgyMzIxXSAgZGVsZXRlX2Zyb21fc3dhcF9jYWNoZSsweDUwLzB4YTAgWyAx
ODEwLjI4MjMzMF0gIA0KPiBmb2xpb19mcmVlX3N3YXArMHhhYi8weGUwIFsgMTgxMC4yODIzMzld
ICBmcmVlX3N3YXBfY2FjaGUrMHg4YS8weGEwIFsgDQo+IDE4MTAuMjgyMzQ2XSAgZnJlZV9wYWdl
X2FuZF9zd2FwX2NhY2hlKzB4MTIvMHhiMA0KPiBbIDE4MTAuMjgyMzU2XSAgc3BsaXRfaHVnZV9w
YWdlX3RvX2xpc3QrMHhmMTMvMHgxMGQwICAgICA8PDw8PDw8PDw8PDw8PDw8PDwNCj4gWyAxODEw
LjI4MjM2NV0gIG1hZHZpc2VfY29sZF9vcl9wYWdlb3V0X3B0ZV9yYW5nZSsweDUyOC8weDEzOTAN
Cj4gWyAxODEwLjI4MjM3NF0gIHdhbGtfcGdkX3JhbmdlKzB4NWZlLzB4YTEwIFsgMTgxMC4yODIz
ODNdICANCj4gX193YWxrX3BhZ2VfcmFuZ2UrMHgxODQvMHgxOTAgWyAxODEwLjI4MjM5MV0gIA0K
PiB3YWxrX3BhZ2VfcmFuZ2UrMHgxMjAvMHgxOTAgWyAxODEwLjI4MjM5OF0gIA0KPiBtYWR2aXNl
X3BhZ2VvdXQrMHgxMGIvMHgyYTAgWyAxODEwLjI4MjQwNl0gID8gDQo+IHNldF90cmFja19wcmVw
YXJlKzB4NDgvMHg3MCBbIDE4MTAuMjgyNDE1XSAgDQo+IG1hZHZpc2Vfdm1hX2JlaGF2aW9yKzB4
MmYyLzB4YjEwIFsgMTgxMC4yODI0MjJdICA/IA0KPiBmaW5kX3ZtYV9wcmV2KzB4NzIvMHhjMCBb
IDE4MTAuMjgyNDMxXSAgZG9fbWFkdmlzZSsweDIxYi8weDQ0MCBbIA0KPiAxODEwLjI4MjQzOV0g
IGRhbW9uX3ZhX2FwcGx5X3NjaGVtZSsweDc2LzB4YTAgWyAxODEwLjI4MjQ0OF0gIA0KPiBrZGFt
b25kX2ZuKzB4YmU5LzB4ZTEwIFsgMTgxMC4yODI0NTZdICA/IA0KPiBkYW1vbl9zcGxpdF9yZWdp
b25fYXQrMHg3MC8weDcwIFsgMTgxMC4yODI2NzVdICBrdGhyZWFkKzB4ZmMvMHgxMzAgWyANCj4g
MTgxMC4yODI4MzddICA/IGt0aHJlYWRfY29tcGxldGVfYW5kX2V4aXQrMHgyMC8weDIwDQo+IA0K
PiBTaW5jZSBJIGFtIG5vdCB1c2luZyBodWdlcGFnZXMgZXhwbGljaXRseS4uICBJIHJlY29tcGls
ZWQgdGhlIGtlcm5lbCANCj4gd2l0aA0KPiANCj4gQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdF
PW4NCj4gDQo+IEFuZCBteSBwcm9ibGVtIHdlbnQgYXdheSAoaW5jbHVkaW5nIHRoZSBvcmlnaW5h
bCBpc3N1ZSkuDQoNCkZvciB0aGF0IG9uZSwgcGxlYXNlIHRyeSB3aXRoIDYuMS1yYzMgKGFuZCBD
T05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UgYmFjayB0byB5KS4gIE1lbCBwdXQgYSBmaXggdG8g
dGhhdCBraW5kIG9mIHRoaW5nIGludG8gNi4xLXJjMiwgdGhlbiBJIGZpeGVkIGl0cyB3YXJuaW5n
IGluIDYuMS1yYzMgKGdpdCBsb2cgLW4yIG1tL2h1Z2VfbWVtb3J5LmMgdGVsbHMgbW9yZSkuDQoN
Ckh1Z2gNCg==
