Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1566A54E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 22:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjAMVsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 16:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjAMVsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:48:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488CACDA;
        Fri, 13 Jan 2023 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646480; x=1705182480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=anxkw38+6PUGJvmP0TB/aLL9oQD5STfiSMqj8WwM5pc=;
  b=OHwXrsyVMRWEZi6tkGotd/EvkadGyCP0JNpatGFErk8Mpi+B6InU0yEX
   SCwrjo2MdQEkBRY73MUVEucd6BLkRpc753YUn/+EaPZ03ChV3AYxKGzTz
   4AYSCtnU1fCQizp6X0F2+8/ibvK6QTQ3VzAcVe8O32Q4acH/AdWcvL8iD
   PiCSsGDdJ4OP6FCITHQFm2dPKU/Sq405oXVSD9j7TrWjOO95dYy4gLuzy
   3/apVo7xO1AhljLkD9otW/ywLkTlp8oe7gz22Ta9iwSJpoESnfcMMC2CI
   OjsfAmZ3aCkrUx4gaG/l6mYctKwWJIRpNw0Zmr8bOJICP2/XX6zsv5VHd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322806956"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322806956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:47:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="658346614"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="658346614"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2023 13:47:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 13:47:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 13:47:56 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 13:47:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPYpJCEf7Z5jCJcnf5vpLOw+nme7nV3f5O1ntdLnJqxhHWuI4lauS54hS+J4pD7Nv3D/6A/w/FfkQOl3hkFa+YD1oRQFE00pt70CCFyv57q8/zKn1seCrOkB6wNBn3vz0fH6Jg5GU+s1LHpCOoRoXQB5uXmZE6Xq5KOBhcuXlgItZEBquV26ZCqge8q8g7INhLd4IOKb6RFyU+sZX3GUM7CKRJ8BtQqG+zGkS9Vc28C9wRPy8HTyJ/T6QRl6jmDA54WsBTJdMuDH22/cLm3gjvyeejv8ePAdNxn8gxbJXlzFP3zqE5LYXOvfY/FVNVtPrgXya8bKJONNQTOSqE+Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBhxvvL5NMhbRaCM7PYfG2buzz6DcghmkcdoNR3D25k=;
 b=b+Y4s0oJnfmi6xRU1ld1sdGZYb971YxZKtYWO6M6MRRLy3nfX9zxND4IW7+1IVS85mhQd77IkyoQ+iEpB5inxToiFRsxiywiwzC6AOxWSd2XRZ6iTAOP0eTZTBlQ7T5SvJTf9fhKyYjBXPImwBBqZsc1dGKmG9qrv0CpYeAEQQ8EwJbBD4f7+Hrj5S9Rb/T8bOWGPQsFwHJnvh0HBC/0vT4Rl7mK/Nb1aIDJ5A9wSTOXMFaLN26yyXJjBEaWO/ojY318JQf2dXA7kjRgLBQRY+U7FeCilQuE5JJzZbqA1L8ui2uNu4uEQoqcyk3mTVrLgUkEb7uk2gVVBehCsbX8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 21:47:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 21:47:51 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jan.glauber@gmail.com" <jan.glauber@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] lockref: stop doing cpu_relax in the cmpxchg loop
Thread-Topic: [PATCH] lockref: stop doing cpu_relax in the cmpxchg loop
Thread-Index: AQHZJ38sKLMnUvTX/Ey0++hFbTHJia6c4Nww
Date:   Fri, 13 Jan 2023 21:47:50 +0000
Message-ID: <SJ1PR11MB6083B48A2B2114EF833D69E2FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <20230113184447.1707316-1-mjguzik@gmail.com>
In-Reply-To: <20230113184447.1707316-1-mjguzik@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7811:EE_
x-ms-office365-filtering-correlation-id: 302d4f46-237b-4c71-670f-08daf5afd17e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcI7WEGX2tTYFG7FSnfuOnTj8NaBT7PAuZHmkvU3wH0UDEkDYDirvtIx2pMM0z4/kdCMFWxQj9DOcw5raj2LUVDhwmre887NrQkltz2JHNuXE1ATc9ttga8URUL1/CFS9Jeknu8jNrFoN94QLVInRV8wFcdOuVoWFMrWCqMKy3hnTFyS/VzDt0oLUU/9yjNPngITH73VaEWn2Xm+C3rLYfzjv6ukx8T6XpC00nwEbCUnbWc8WtjbilVtn5DT/36bebiu0wESQ/NrzjH5CtlvHsljkc7lYQTBa4U31BGgMFvTPhCYA0S5aB+4ZMjxk4xAfrb/nMI4ELI1wY1IpAjttrJD2qNzKVIzWweA9+FK+xBI7ngTmUo6i1U+4wG/WfV9oQ6xJHPpnBixCNdYv+Nk6cpuxlhq2j3gDeUdIYh0oGzMsFvDRvLD1OA+vWqLrqJZODsy5HIoHQ5rWqo4Y/rNKlM4mI6822WhIX1DuWj+w+McijOOR7W1R54ti9yFy/zbssfraXV+HD2LAF+VCsu5XwGDe71F0RjhSxNgn2GxW5/mYsdBmyJ+gtNhrAvWp8Ji5fUSKiSny/ArwuFhwW8Rw0T0zq7hWzmbRfVm2hpnL8tLRuP5B7Gd0J07M6kgbyGBElJbWJ8Pckp8Cg7+xS7DPvPkdEZj/sD+vIKiA2nZ60NGKo9o65+IltFWJMSx1u9JeyPP5h/WFjJFJ5C1gFVW6rhqi9S4Io2nOs5Xi8PCsFv6nYWM9Psvx8sZGLC8zR6Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(110136005)(54906003)(41300700001)(38070700005)(6506007)(478600001)(2906002)(316002)(122000001)(38100700002)(82960400001)(33656002)(83380400001)(66476007)(4326008)(66556008)(52536014)(8676002)(64756008)(66446008)(86362001)(26005)(186003)(9686003)(55016003)(4744005)(7696005)(5660300002)(66946007)(76116006)(71200400001)(7416002)(8936002)(40753002)(133343001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i7fH0KoVMCEefZm1QtybSlqF1YZh5X15ZORNIRCUX9h7PKxy/mUnaqK/C7NC?=
 =?us-ascii?Q?w99W2HGp/KzoCmrYCoFb8QppXe7a05GduzgJVoT97I0FeZVGPw3ohq9IxcPq?=
 =?us-ascii?Q?CzX/sNc6QxZa5AC7l3xVLH2rVI0CmV6d5crS0jULgjTwco2xo6jsIKHLpxnW?=
 =?us-ascii?Q?XSNzggON6USB0k2QuGJTUkAl9jFFMrFvcXcmCfDLLON7OPKks0MYaqxyQFWg?=
 =?us-ascii?Q?UB1clKiJHk2bbG3/sDnd4L3yp+q4PHKM6NKC27ru5D+B3tD+IMMRVA9S0h4m?=
 =?us-ascii?Q?wJsJNExp2CLMgLcvJIyUfvdNWk0OouxZkRTDW5njfkJfeb2OREe9gtn09OxJ?=
 =?us-ascii?Q?J2zBFUQX8R1CIg9dvlHNhDm9I5CJF6ofZw3qLC64nhH2w8n6YcYX20LK5lVd?=
 =?us-ascii?Q?HFJxVe5218UZI6HvVAmbM4vYZbqJyUIZjfno7jiZ7OidiLypt/yBiCU59p2u?=
 =?us-ascii?Q?GCX8rX5AbA9xDut1rVGJqHu3W3J1EAeOw7Kk6yh5VEXO9/7uwlEfOmtD7jq1?=
 =?us-ascii?Q?9etuC8pkoFFUFXES52qW5qN6Mt7w8JexRjZIRi95uBiY7HcJ/+lbQ9vjQ9Nr?=
 =?us-ascii?Q?NQ235atxZ2NibY/hPPVHdRw+iWyS96Bp8NJuGkzjYrT2xZfI5Eni4HPu5Tc+?=
 =?us-ascii?Q?7R3TCwVDFb7erfdcGCMrQSsUMg9q/CJ8rzFwQdsYfPTfJDpBlI0AX5ch+kvN?=
 =?us-ascii?Q?ueKglUrQiizw46KFkugQyridWy+8nH47KoBtjjftcAVkG7Dng1bC39rTZ6mu?=
 =?us-ascii?Q?y8aMicVDGM62WZZ8DRCC0Ry24LnSdUFuuZh4+hyrY7k+uGImcU15dVJxffXN?=
 =?us-ascii?Q?hXhicmY+vJ8V9b+gc/d9NLEGbMFldKE2srrTsfvHABbTpcNBEwst8Yu13Ig8?=
 =?us-ascii?Q?7bQvJ3/gQO8dw94s1ydflQfkZsoWUGotuSL1Irq8UtZhTUmwXHuieMhNv5V9?=
 =?us-ascii?Q?RL4cnpM5CJB9ngqGtsYTIFQLeIkSgU4VwTgMwLhEcWMf8Qc3RI81hkfGgywg?=
 =?us-ascii?Q?RA+LRSRbqrUFoeX+VAON6z0wObZ/OZV4tPS12aY4mWQWvjUV1h4Tgb0TG29b?=
 =?us-ascii?Q?ijtuWEnsVx9pyjyQLiTfcA7EFF4ep0Yq+YeBALs+jii76E1cva38MSitWSPG?=
 =?us-ascii?Q?27l7wu9C0sHnteuthuIfhOq/W6uNWhJTxPkIVDxoMbKK0A0qyFABOmJ/YKFB?=
 =?us-ascii?Q?Oxbm5I7nWXilHGcY0kXusEkXU2AOK4xcBWWRqvymg0GGZ5sfoxR6+tLgP47P?=
 =?us-ascii?Q?DHrGiORr1JPqYbPwioHDDfda622wh+Wg2KujG/Yi6D1fXrSQpd3HHPKJ8qoV?=
 =?us-ascii?Q?BNl+vjZ7lqeUrHDX30WJfSGr18upi0CORZ1m5E0XlatARxy1B121hR/H75km?=
 =?us-ascii?Q?/RfC+uF53GiDgsr7kYHRGCwtbp/WOukUUpDJQTEm2bepLIEwvUEPjhbAZkPK?=
 =?us-ascii?Q?Jy+uFXx0upsqy/fNp6LjP5VRX9lmnSukHo8kZZzuphzLY1JLzfbMeH7vQUyj?=
 =?us-ascii?Q?7/8yxNec6BoaaxFjsg68oPrzB9OjIskLLjRpw54PHroIuRbv0bhcxcs2dLdj?=
 =?us-ascii?Q?tVE0FeXZLhzFkZWH7Cm20yVGsB+ACQEQNuypqa/t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d4f46-237b-4c71-670f-08daf5afd17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 21:47:50.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUJcJkprr49AIE/u1MUNLhqRczNhd1dVSI6xkMUhhEBUdRvlnkm86988jtZgwuVYKGNrehC6JDzDMG59qNwpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/lib/lockref.c b/lib/lockref.c
> index 45e93ece8ba0..2afe4c5d8919 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -23,7 +23,6 @@
>               }                                                          =
     \
>               if (!--retry)                                              =
     \
>                       break;                                             =
     \
> -             cpu_relax();                                               =
     \
>       }                                                                  =
     \
>  } while (0)

The computer necrophiliacs at Debian and Gentoo seem determined
to keep ia64 alive.

So perhaps this should s/cpu_relax/soemt_relax/ where soemt_relax
is a no-op everywhere except ia64, which can define it as cpu_relax.

The ia64 case is quite painful if one thread on a core is spinning in that
loop, while the other thread on the same core is the one that needs to
run to update that value so that the cmpxchg can succeed.

-Tony
