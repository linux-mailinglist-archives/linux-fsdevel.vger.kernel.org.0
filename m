Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F54DB861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 20:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbiCPTIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiCPTIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:08:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485466E4D6;
        Wed, 16 Mar 2022 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457615; x=1678993615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uIgMVEu3MyfngKFGEj3PYBmw4qvWn5Z5YDHjGaoOc0U=;
  b=kIEgyp7eQFuf7yY0KLBo8ihUl3a3PYPSzCwNEjRYjnNkNYI/XX0KNJsF
   /s+R577cxVfideFhczaMIUlA2nuilIFcUN9lxHKJ/d9IqaGQIhXuOg521
   HYdbJJaLeCsPsnKO9ZH86Y9gVK/geU7gRmUgVOqX0EC4wjmaOiL1r3xGT
   PgHHBtdpf1ulUHl/q/dHUGnARQpiB+ib6fxjKDXdhj1tvFiCCGYpM4FhS
   PWFFJVkuFfjUA/RD4Dz54ZtLfb2RZTorQ1pV4Xgqcte2d/M56jvFZjJ1G
   IBJHJngMQdYI5YAdud9Q7XNqkn9i/RLZ7WUcyGMKmYAWF243578EgOdsI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236637060"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236637060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="598833573"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2022 12:06:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 12:06:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 12:06:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 12:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PokeztLPbJxhqoKr/V2sKrHxi/YRLvvV73ln87AubgLZ4ac1TXDVQFo8VYRhi/4eJLLdVzTrlkORo+jbv9NY9IRa9p3eISDRCDq2U2yNNqZBotO+mpjFK6hsfjdCmCBeWUVqT/ie7hiL5IoWBcbtrLnHuEwHa3g6XEJ9sOh6F1/RK3UK38pec8qLe+NisHJwqWUxf0gjVMtAywvnXQstCw8grdgqrNTFwXFLhb6pgn03xFIkZkBrbCOjcfqOXMCI//kaJC2F7vlVzTlCaYZQaQiu/rHo2JlZdC+WmBOgdks1PS6Pu804KMo2Gy0QaWWm6LBx/Yr2fWIb4tJAeirj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIgMVEu3MyfngKFGEj3PYBmw4qvWn5Z5YDHjGaoOc0U=;
 b=gwwlHTRKHZ/hYDCs5ZThCAe6wTw02q9VO5LLOelOCB0Pa8+H2oyotZ/7Do08FKG7EPwQ+qZNgNgx8pZvYmy4chjK84xgFGorDtK88nmZRDyG2EWBxKp5310XHNt7pkk6Y7YzOCCXsb9KLB9pqUn62Q9+/nKxQgJfjy8JpdgiAqvkFwL2q3c0ogC9xk0PV1o4vagKHpIX3htatPWgH/uxdhjQefuzLMV4mtm+Lv1mxorWw1hR/1mSF9QcZwgnqzxomlfmk5XgJ7+NiTyKxfiUfV6jOdiy1Bk7X1JZmqxbDrujXdllJ+tEgk76VAZ0bLHROZ7O7hx91oycOBFgHzpexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN6PR11MB3470.namprd11.prod.outlook.com (2603:10b6:805:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 19:06:49 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 19:06:48 +0000
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
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Topic: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Index: AQHYOKnIB2wsd8uW6EiQs+9kCgApRqzA6N8AgAAT7wCAAFKbAIABETqA
Date:   Wed, 16 Mar 2022 19:06:48 +0000
Message-ID: <b5f9ce3c70d202834e0a76ed30966e2c81eb28dc.camel@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
         <20220315201706.7576-2-rick.p.edgecombe@intel.com>
         <202203151340.7447F75BDC@keescook>
         <fe7ce2ae1011b240e3a6ee8b0425ff3e2c675b6d.camel@intel.com>
         <202203151948.E5076F4BB@keescook>
In-Reply-To: <202203151948.E5076F4BB@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40fbf73f-d602-4ca9-70a6-08da07801f5b
x-ms-traffictypediagnostic: SN6PR11MB3470:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB34705EEA09EADEFFC3568EB5C9119@SN6PR11MB3470.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RmUoEeNBjUEizAVrs6lsQHbgIkuPj7FgUgLftFJvsi++aw6u8g2qmlXWDmbqWSIPQc56pT3tsEoOTrvZ2mcrIiL8QRAA07lHqdkQM8TaBDriv1KFFS9EidJ4Og1C0teBAtpKYIDDrRy5/cuNdba6PCpmzRJ3HUW4NzNZE96emvqDOtpCsVC8Z1jj6/KFFHyapivkGC9FrJLL4N7nCjucKqzwWQ6KCzu3r+x6TQPQXNlRN9LITG+oFAfyQKtMmlyTUY5pznd6FmCnzJhBhNH1uJU6G6XOzZqOiyKV3yeggQguIn//NSK2sI2UlToySHOx2LyFJEf2vlOCovVMw0z0hhFn/eY1nEG+YyIhkIBY/du6G/tG7lmNWyd/1hBwLtdlGmjh6jGugipmJrbZ9wO146/StdtkIGJNxKAYUqDubjgchqbB1rExZgW67urBTsjm+I2guxFnRbWN2YdmW981c6MopFVq3U8xUTzVLmSRTVCfirrTY0j/wGF667s+FwT7ZSIzr4v5of+e/WwDxcaHjni/Z3lKrAfPLo75mics8b9YQJJEJTyA7AQjdjwK+oqvlq8+6w23FOuPhKDiVpkkntHKK8qgEs/3HAKtUFmoZ1BB/ubAl3ZmFVcgv2iLVME2q+H0bfWdwZQeEgwBg31JI062q4g3x2gL2ttm0sc5b10cEe2AOwE4slIEXYkR801ab0kUR397I3rGbtSNvE7weaY3SHCA7PHU5tGnsglThKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(38070700005)(86362001)(54906003)(122000001)(82960400001)(316002)(83380400001)(36756003)(26005)(186003)(66476007)(66446008)(8936002)(64756008)(66556008)(76116006)(4326008)(66946007)(8676002)(6486002)(71200400001)(508600001)(6512007)(6506007)(2616005)(38100700002)(5660300002)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVtQU9Kd1U0TTFjYUk3WjF2MDcxeGVydXBKYWZleEUrTjVXbFF6RlVrT3l1?=
 =?utf-8?B?YmExaHh3VlVrajBBbmVrdjFhVkE4WDVzMGhtMlhZSEhLYzdwYksxTjFsaFFO?=
 =?utf-8?B?aktYL2xDOTBsNzNLSGo4eXFucVMvNnpEN0VXcjFSa0YrWDZjRndFZ1NaN0lE?=
 =?utf-8?B?YnJyMDI3aExBaWtKV0FWcHBQWnB0NTF4ai9pajBFM0FqMHBoVDZhMng0THQ0?=
 =?utf-8?B?RDdCajhlRzduUTV1OEtHSFdEbzVzZWU4TTJrMWUzaFJIT3VMbWMxN04rS3lZ?=
 =?utf-8?B?bWlNYmxJb0xFNVhlMVR1M0RvSzR3U2lwMDFoVmdOcElPajR0Vzc1L213dEx1?=
 =?utf-8?B?OE1JSnJMQWIzSGp5YTlUTTRocHFwa1F5UEpzaEFYcDYwNlJ2cHZaWDBMUmZY?=
 =?utf-8?B?bVlQMXlKSFZIRGd4UE15aDNxUnlwUGY5V2NZcm14aGYyMUJWaE14R2RsblFK?=
 =?utf-8?B?b1FDRFpaek5BSWRkMUpSZjNuOXN6SlRybzBXUDlQaXY4M0xwOTBUMUJ0Wkgr?=
 =?utf-8?B?UjlVNFlubDR0WUV4Zzl6RlJxT2dqYkVXRkJ1WEpScWRFOGhzMEluQ2ZEODdM?=
 =?utf-8?B?NDBuTVcxNXV4QmxvUHZIWVN6d29NaG9mdk55MC82SndvSDhiRnRwSjgzVlpr?=
 =?utf-8?B?eEdaQmp4RFAxV0NCUGo4aTBrVmNuWlU3SzVOZjc4TS8yK0t4MmhhZElPMWds?=
 =?utf-8?B?aS9iNGpUeXEzK3QyVENEdGNWZnVEUDNhY3lNb1N6dGRDU3FUWUlWNzFZZjg2?=
 =?utf-8?B?S3hJQ0llWldhV0xBSW5mdC8yZzJ6aXoxYmJsdGFPQkFPRjNqVDZkNEk0Rmox?=
 =?utf-8?B?SjZnWTMzcDJEZGNJQXF0RExGWTk2Vm5Id2ZuSmFEQWZHRi9qSktGMnArOWJC?=
 =?utf-8?B?cXBTaW5wN0pyaU9aeCs0ZHJjRDA0Wm9TVGVsNEQyQjl3d2lDMFFmM2ppU0dN?=
 =?utf-8?B?QlFKeG1Kb0ZETmN6THN4Z1JCemRjaTlPL2cyQWlCSllGc2tDNGhqUk14U1g1?=
 =?utf-8?B?eXV1ZncxSGFNdE5TM3pLZThMQU1sWnFJUERrWlNXUElPWHd3SjJYSE5LS3hP?=
 =?utf-8?B?L3VaOWRiREg2U1A2TXZFYUdRQnBwRC9MOW9WTXlTWkkrblN0MjA4V1l4Yy9E?=
 =?utf-8?B?TTVvNW9qMmhoMWFIUklsZ3RRUzFlOXlaL25yVDhmSkZYQkZYa3dudHhyWjFU?=
 =?utf-8?B?RnBlZ21zdStOSlJEWE9GNHF4WjlESnNRYTJhUWViS0lYOG5lR3JXb3RyYmVP?=
 =?utf-8?B?c2E3QzZwM253NUlYa2VkZ2ovZVFSOUdmWk1YSUJRamtyRHArOE1GQ3pDYUJF?=
 =?utf-8?B?MUV6aFN2U3hVRzNTaEZvUmVncXAzM0ExMG55NERxa2hsaE8xMUNvRDIzMjF3?=
 =?utf-8?B?R1BYU0JlcXpiSmoyZS81Nk1mV3IyVExxRVROM3ZLZGNXWjNxQm1Ec2hwTFVo?=
 =?utf-8?B?T2dNRWlzTnF1cC9lNk4yWlJoa3dmNzh5SkhJSllxRDRwTDNxblU2VFVFcURO?=
 =?utf-8?B?cmdwL0hYajY2N28waHFzbEQ3YjlMeUhBU2k0Sm9EQzEyMTdoR3I0czZmdVdL?=
 =?utf-8?B?dnNYZzRBUGhVUVU0ZFU4VURaMXZNR2hSa2M1NlhqUmp4UGx6MVJuVGNieEUx?=
 =?utf-8?B?SCs1SVU2cGx0dURSbDNMVE5OOGxzZDB0Z1gvQUt5ME5FSlZtQW0vdEdnS3RU?=
 =?utf-8?B?NFFHbG5SMjdLQThuUXRVTXZ2RE1wczUyUVFmdzY4SG9yRnJMT0VzOVlXbldI?=
 =?utf-8?B?QkNWL2NpeGRINnRIQldKdXhUdG85cTluSENSWDg4QitNUXZSc1ZMU0lDYmVt?=
 =?utf-8?B?U2x3Q3E5UUFHUGNrcEU3KzdTOVczTnpTWnVWNjdlUnR2cW1id1dmWnE2ZkEx?=
 =?utf-8?B?VzI5WnpPb3VWRlpDNEpDV0ZJZFFvVzJFSE1LZUl4TzE1b0ljVEluNXpTLzJj?=
 =?utf-8?B?d2NIZUdBTGptVGpNYnY1T1d0WCtUYXdNQ3dQUElGMGpEeC85bEpxRHdXblhC?=
 =?utf-8?Q?bcDyL06raoEtpJTZuRBMKZG5wxNXiQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <014E5A9359BF6F4CA9D8E68CE1B34412@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fbf73f-d602-4ca9-70a6-08da07801f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 19:06:48.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAK1n2HQ7vUW7ZE9+IA1gjWuOTXEWhffokI2iWjOhXoP9E5+pXBd5LKhvvbXqGB7lnx/h/N6yjhlvR4FqBIVAl0CMYyeyzAIp5cMNn1AzPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDE5OjQ4IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA5OjUzOjEzUE0gKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQ
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMi0wMy0xNSBhdCAxMzo0MSAtMDcwMCwgS2VlcyBDb29r
IHdyb3RlOg0KPiA+ID4gSGF2ZSB5b3UgdmVyaWZpZWQgdGhlcmUncyBubyBiaW5hcnkgZGlmZmVy
ZW5jZSBpbiBtYWNoaW5lIGNvZGUNCj4gPiA+IG91dHB1dD8NCj4gPiANCj4gPiBUaGVyZSBhY3R1
YWxseSB3YXMgYSBkaWZmZXJlbnQgaW4gdGhlIGJpbmFyaWVzLiBJIGludmVzdGlnYXRlZCBhDQo+
ID4gYml0LA0KPiA+IGFuZCBpdCBzZWVtZWQgYXQgbGVhc3QgcGFydCBvZiBpdCB3YXMgZHVlIHRv
IHRoZSBsaW5lIG51bWJlcnMNCj4gPiBjaGFuZ2luZw0KPiA+IHRoZSBXQVJOX09OKClzLiBCdXQg
b3RoZXJ3aXNlLCBJIGFzc3VtZWQgc29tZSBjb21waWxlciBvcHRpbWl6YXRpb24NCj4gPiBtdXN0
IGhhdmUgYmVlbiBidW1wZWQuDQo+IA0KPiBSaWdodCwgeW91IGNhbiBpZ25vcmUgYWxsIHRoZSBk
ZWJ1Z2dpbmcgbGluZSBudW1iZXIgY2hhbmdlcy4NCj4gImRpZmZvc2NvcGUiIHNob3VsZCBoZWxw
IHNlZSB0aGUgZGlmZmVyZW5jZSBieSBzZWN0aW9uLiBBcyBsb25nIGFzDQo+IHRoZQ0KPiBhY3R1
YWwgb2JqZWN0IGNvZGUgaXNuJ3QgY2hhbmdpbmcsIHlvdSBzaG91bGQgYmUgZ29vZC4NCg0KV2hh
dCBJIGRpZCBvcmlnaW5hbGx5IHdhcyBvYmpkdW1wIC1EIHB0cmFjZS5vIGFuZCBkaWZmIHRoYXQu
IFRoZW4gSQ0Kc2xvd2x5IHJlZHVjZWQgY2hhbmdlcyB0byBzZWUgd2hhdCB3YXMgZ2VuZXJhdGlu
ZyB0aGUgZGlmZmVyZW5jZS4gV2hlbg0KSSBtYWludGFpbmVkIHRoZSBsaW5lIG51bWJlcnMgZnJv
bSB0aGUgb3JpZ2luYWwgdmVyc2lvbiwgYW5kIHNpbXBseQ0KY29udmVydGVkIHRoZSBlbnVtIHRv
IGRlZmluZXMsIGl0IHN0aWxsIGdlbmVyYXRlZCBzbGlnaHRseSBkaWZmZXJlbnQNCmNvZGUgaW4g
cGxhY2VzIHRoYXQgZGlkbid0IHNlZW0gdG8gY29ubmVjdGVkIHRvIHRoZSBjaGFuZ2VzLiBTbyBJ
DQpmaWd1cmVkIHRoZSBjb21waWxlciB3YXMgZG9pbmcgc29tZXRoaW5nLCBhbmQgcmVsaWVkIG9u
IGNoZWNraW5nIHRoYXQNCnRoZSBhY3R1YWwgY29uc3RhbnRzIGRpZG4ndCBjaGFuZ2UgaW4gdmFs
dWUuDQoNClRoaXMgbW9ybmluZyBJIHRyaWVkIGFnYWluIHRvIGZpZ3VyZSBvdXQgd2hhdCB3YXMg
Y2F1c2luZyB0aGUNCmRpZmZlcmVuY2UuIElmIEkgc3RyaXAgZGVidWcgc3ltYm9scywgcmVtb3Zl
IHRoZSBCVUlMRF9CVUdfT04oKXMgYW5kDQpyZWZvcm1hdCB0aGUgZW51bXMgc3VjaCB0aGF0IHRo
ZSBsaW5lIG51bWJlcnMgYXJlIHRoZSBzYW1lIGJlbG93IHRoZQ0KZW51bXMgdGhlbiB0aGUgb2Jq
ZHVtcCBvdXRwdXQgaXMgaWRlbnRpY2FsLg0KDQpJIHRoaW5rIHdoYXQgaXMgaGFwcGVuaW5nIGlu
IHRoaXMgZGVidWcgc3RyaXBwZWQgdGVzdCwgaXMgdGhhdCBpbiB0aGUNCmNhbGwncyB0byBwdXRf
dXNlcigpLCBpdCBjYWxscyBtaWdodF9mYXVsdCgpLCB3aGljaCBoYXMgYSBfX0xJTkVfXy4NCg0K
QnV0IGV2ZW4gYWRkaW5nIGEgY29tbWVudCB0byB0aGUgYmFzZSBmaWxlIGhhcyBzdXJwcmlzaW5n
bHkgd2lkZQ0KZWZmZWN0cy4gSXQgY2F1c2VkIHRoZSBfX2J1Z190YWJsZSBzZWN0aW9uIHRhYmxl
IHRvIGdldCBjb2RlIGdlbmVyYXRlZA0Kd2l0aCBkaWZmZXJlbnQgaW5zdHJ1Y3Rpb25zLCBub3Qg
anVzdCBsaW5lIG51bWJlcnMgY29uc3RhbnRzIGNoYW5naW5nLg0KDQpTbyBJIHRoaW5rIHRoZXJl
IHNob3VsZCBiZSBubyBmdW5jdGlvbmFsIGNoYW5nZSwgYnV0IHRoZSBiaW5hcmllcyBhcmUNCm5v
dCBpZGVudGljYWwuDQo=
