Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462654DA4D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352080AbiCOVuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 17:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352070AbiCOVuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:50:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3D4C790;
        Tue, 15 Mar 2022 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647380926; x=1678916926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uqVfH1gYvmzxoQsTpW3H5iU2/f+bEkBv9r3ehRX0sis=;
  b=Eh8iSnsgJLTnTdTfTA9pAaIFsj7KP9JqbbO41sbWq1ZeOGZ2zS5l0Sv0
   mhOIXEc3qkAl2szfzrmeP9YBKg4OEWTcUQcZ+ZZQRZKdUIrFKjO5ixJTG
   ia6dspWICK70lcVUsNfj8FqgAF0uHGOBZhdknOFlJQOigqCn8aVfMA2p0
   j9V91tJT2SulTHnQD2qduux9F3KWN+sqJKSIDPjgl8NSNGTEYdFXtII+g
   7hrhA4AdI4tUlGBSloCt+VzQ8PmqJkfEoXKVXfKagdkbjDhSJGE/hsNvb
   st/eJ1DWr767RKlBiJ56J9fx67rpQsXk/9cix15FOfV9Fkqn9h4/jZnxW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243881221"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="243881221"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="557125905"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 14:48:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 14:48:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 14:48:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 14:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMbUokC9nT31/V7F3mViugAsH5OtV40Fms/OGR9mWS6hfQRmbaHZls3rSMpCu8vNNt/wCRH75Q3gMTwcIWKEHJG88MywYKgwmSqYGd7LKDOI+FglPUGxyRbJPy/DNbzJmUPq5Lsmt8JVr2ZMWZeO4nj0MEAYWrFNllYGnLczFOhvxlfCR+lQy6YcdaadkD9LCHU4h27kwXj9S71vYYD69UNwimSpZyYV8dLTGIzJ0BH9/s0Q1x1Ut/PnrcJcf3YnzzcCEO8AeU5vmgIWPlaZaDqtZrXkwWEJpwNir5v/WH/0YZPYp5xRbBBEJxGoUM7A/fbB2asS96ygRBxUL7zxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqVfH1gYvmzxoQsTpW3H5iU2/f+bEkBv9r3ehRX0sis=;
 b=Tt3MsnlkTqtGxbF3c7JDYX4VcSrzUBeXpw983akqma+d9EGBu6JAayDAF6IAqxA1qWn0KoxIy0fj1wJ7P9J7egNMC3jITTWWgiVGR3JpJWuQUGiSv96dqVY9jnYmy8PGtEp5SXn/WHrDrLFZyJPnRS0n4/QvOfESeQ52QV6jgtuter0r4OLr1VDZSQg/hHVPvaxf3/WrBcJx2DyCBvTegKQFtJEn2GaUZtvZbvvLcad2eIOL/MaC0ccAhxZP8P5wi86oTsUBeWjfOsvkuQdCRAOJ3zCrg4jm4lGtkRqfdl8IeTgHaDDI1HxWsrRtDCHvFw8JKa6q7ylmMwYO/W6R2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 21:48:42 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 21:48:42 +0000
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
Subject: Re: [PATCH 2/3] x86: Improve formatting of user_regset arrays
Thread-Topic: [PATCH 2/3] x86: Improve formatting of user_regset arrays
Thread-Index: AQHYOKnKUS6L49FFdU+eB8OnPTiM0KzA5+8AgAATnIA=
Date:   Tue, 15 Mar 2022 21:48:42 +0000
Message-ID: <61b053631212c19a05c8fc49f15862b2ffa1e604.camel@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
         <20220315201706.7576-3-rick.p.edgecombe@intel.com>
         <202203151338.13B0505C9@keescook>
In-Reply-To: <202203151338.13B0505C9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc51d6ff-1162-4230-726d-08da06cd92cf
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM4PR11MB526268110878245B2988DABFC9109@DM4PR11MB5262.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITzBrWOEBwDIQP1+0i72unbRt7EFYopMlyUIkY3tmUP1pM6hS0LK4q1f3CMo3qwbM0IMv7Law/dCsJj6+qyXaxlmWVTyibzGDi62rxkXo9/zcVaz+F3ymLISeGQxncfycUrL4eIPsy6JtOAQPkFntc6qM9HHZlyLLUyeauLuBLCXXUerOHQsM+0UwMqDWERq8RO9f3GYV88hk4qLKdjREHHT3a1KYWEKb1A83melVl3yHVniwtWoCHGnUFESnGvXA9Uh2qqizxel3r52M8oOCYEZzB7NaNHI+e/LhW+u0BU3566q/kpWrVcGYxoDTdBhenIPv7ZnYBYYuV/OaIvQRWu8jx/75QjFzlu6+IVWVfTl1dMcntKi7b7L8S5d/Kabip+FoB2RcOieoGRILN0b7QPI75kMlmtgcgArrU2EOzKZ+BhcUTJRvVPl27caLOpt0qhKozvzLHCacvQHEHerS7QC/yFE9E6ViTx4j3paaXYjoDEuKHhXGRxuC8CMV0CHTkAORU0iVLYZRvEwlp26lNrRxS6Bq6UI2fZh9O4gMvPoBygO81pQcDGb0TjTsJCPb9FGWC63Wl/JmhdpHldTYv+zRytcp7YZ+4QfU479HEAUPAHEthWLasKL5K5JlVd7EXJZ5TMaJkfARx49c8KoBV3SKMhy7Geat1DZ/8XFirvOjsLsf+T6bWxAt4CKpzKRJkqLnlA1alPtuxfQF+KllXnZCP+XwAbzaaepLalXOXXNFC9Ew6dDyrzhqtcWp+DRnozd2TL94mn1CAfQRYLtCIisqM7fdprEsRVGvVa2nfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(558084003)(86362001)(38070700005)(4326008)(8676002)(66556008)(66446008)(66476007)(66946007)(76116006)(6512007)(508600001)(38100700002)(6506007)(8936002)(2616005)(71200400001)(6916009)(54906003)(36756003)(6486002)(122000001)(26005)(5660300002)(186003)(82960400001)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEF3SnpQWEEzTURpeU1VVzRWbjc5akZUUnZ3QnN1TlN3SExGYm1xMGozY3hp?=
 =?utf-8?B?VE5aYkZUUUZ2VTdvNXhLcE9wTk1lWmE5WkFLY3ZCOE1SQkpnbGYwaWFHWWt6?=
 =?utf-8?B?MURQRUcyUk1LcUp5d1lSQ0FtcE55VktnNG9UK0dFamptZUZCVHFFRzVyVVla?=
 =?utf-8?B?dFIxUlZUSnhXdzA3b1VoYTdMOE1URDVpOXBGdUN6YUk5MndGdDBrWDBnM05U?=
 =?utf-8?B?K1dSWEZRbkxObFlnY1lNQm9BU21JUkFpZEZKKzM3SWViajArWDZNTmVyNm9y?=
 =?utf-8?B?dGhUWTJFYS9vUWMzMkE4dWtVUTIrc1FVc0hyWmR5V1lua3dsREt3WitJMXFZ?=
 =?utf-8?B?U3JUclg3YVRVV25nOXJGNVU1STE2ZXRDdG5LanRaenZLMjNTRDdrRlZ6NHVC?=
 =?utf-8?B?aS9KMzY5L05TRjEvTFZZMEZPQ081eVB6ekdwMzdqaUtEd2xsTDRobGJMKzJ4?=
 =?utf-8?B?S1VDejNycjBjdjZ1d1hXd1YwN2liS0VRNHFEU29UMUNRSGM1OVl3WFdob011?=
 =?utf-8?B?R1JjUjlKOXdWelBjUUZIMTNWTEhVZGRvem40blJEcXBRaW02QTc1RDhOVG11?=
 =?utf-8?B?R3ZhL1VEWTFzK2ptNGVQTzhPbWpGTTlubW1zLzE1emNyUGszU2wzZ1dMd0hG?=
 =?utf-8?B?VzFpQWNwMWVvVXpaVjdjS1dJYko4dWFoeVp2eTRtM1NHNXM2ejZxTVpiRE8x?=
 =?utf-8?B?YzZwdVhScVo2c3ZadUFkbXBxRnBrb3dmbC9JaFVYSVdFMU92N1UzZDVGeUZB?=
 =?utf-8?B?UVYrNkNxZytaSVRPMFVUOXlPWWZwc05VeXJTbXl1TnczMmw1RWhBUWFuUkFG?=
 =?utf-8?B?bDk3dFc3TGhiQTBvYnhGdm4xRGNYRHFINjlqVGhDVld6KytJbHNzNW1uSmF5?=
 =?utf-8?B?OG1KWlhiaFk2ZW5VUFNsTThXK1BsOXNWek91UmdtZm1yNVByeUp4NGE3M3Qv?=
 =?utf-8?B?VGRLU1hsNjJVOHI0Z1VyaXBwUmRHY1Jsa2xYekhPdksyT0xhL0N6djJWdWJ6?=
 =?utf-8?B?MG1qK0JPVFNhL2xySnFJMWlzNmpoUUZPK0krQjQ3WGQ1RVp4OXZwbzhFY0l1?=
 =?utf-8?B?aklFNVM3M2N1R1RsOU9KaWJ3Z2hyTmd2YVlrbEIwZDZ2QVpTUDVKdXlwQTBy?=
 =?utf-8?B?NzByK256ZVhJZC9JdUgwdnFGYWJtRTRzdmJOdlAzL1lidXVpRzJodW9YVU12?=
 =?utf-8?B?L3lreGRZSGVURUxKRDRLUzZuVGdnaFdKY2U1TWFUQW8xTEl6UTFMRU5mbzJY?=
 =?utf-8?B?ZHJ0UkJ0RWx6UXdSQ1Z5amhldExTOWJRMWdtbWU1VGZORU1tSVlxS3QycmFK?=
 =?utf-8?B?K0ppL2ZpdGtyRlkzTksyVW12NTgwVUphMTB0ZklMRHFLc1lnMktQVE1Jckxv?=
 =?utf-8?B?YjNwQkRzQktDQnFXZWpncnMrNkdrcFZ1VzhKdHc5a3hnbnd6LzVxbHhXMHNJ?=
 =?utf-8?B?VkxuWkpHK01wb0ltVFNoUXBxSTVOTGVhN2tGSGNSRDg3OEFQV1ZmYnZVUTJY?=
 =?utf-8?B?VnpIUmlnZ0s4anJTRHpWaDNLTmEwTGdkUU5qVVdvMDJEZUZSNDVwQVhqWHhK?=
 =?utf-8?B?ZlRpRk85ZHZDem9Nem5BTGliL1M2bEthRjg3WC9zc2xDdWdvWFRKRGZCY0h3?=
 =?utf-8?B?UzlVT0NpTGVac2FkUTg4Y2dHTzlDRnJOa2tMdEJyYnErc1hpOWkrcFlNNTQ5?=
 =?utf-8?B?R0pMd25LQ1ZYN29GMCs3UVJ2aUJSc25tMzVKQ0NjV2FUWFRkTmZNM1ZFTk5R?=
 =?utf-8?B?b2dSYzJPbitnMXdMUFJaVStYOGVYSGN4YUt6OVNKZyswRUZXWU43YXU5OU9T?=
 =?utf-8?B?QnVBdU9HQ1NQU1pKSUxybHNqWGVjTTZPdjVsSERNeFF6cFFFRTJtUmovTnlm?=
 =?utf-8?B?REhPdU5WdG4wQmxxeU1uYjY3Y2tDYWF6Mkp6M2FwdFVqZTVPYnc1M1IwYzhs?=
 =?utf-8?B?L3FBRXlqSXdDREJBQllZTTFQU0p4SWkyL2NseEUzaEVPT3pSVWJabmVCbklW?=
 =?utf-8?Q?xsth4/bQl3GhrMb9xQjBN+O2iFthHw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A65A273157696543B2142D840656B015@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51d6ff-1162-4230-726d-08da06cd92cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 21:48:42.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTEZfzLbYO4Bhd62/SkCqIGDDbNUzivGw73HXNGEYhXvYm+X1oUSAhmmEXtD9nkgph1Ba6vSYrfs6pSkKDnFcVK6dqJ3OoJezq2x6f3J5zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDEzOjM4IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IFJl
dmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCg0KVGhhbmtzIQ0K
