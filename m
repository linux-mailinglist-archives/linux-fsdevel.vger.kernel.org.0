Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5766A4B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjAMVDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 16:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjAMVDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:03:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9742E19;
        Fri, 13 Jan 2023 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673643790; x=1705179790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nXdiljVNiGX/bR+zYZIhtNBfAIf0HyRGtQJvisBStLo=;
  b=YnYH1+4AsQDYbJn4A4tcxyEpFonyGdePaPhRBigA0wY0Y3LD4E+84EOC
   0s8e5vPOarfU+fSG3VKKArE5qfCpdA4FVd8uakVmAVtVeVclKCvLEXMiC
   CJWcoJ/uzUZjJefKL9yNgeld+xxaJVlTop2+rm4BE85InkqBzINRt1wbZ
   Kjusaxx1jQKpQnTawIfTp5cwUbSJnLYTcHrpDGOWL8A7ApXO5631SPoHH
   fRdhcE9P7jaeMbnE1CSPwd3pBXBSzwCvlbCT7ePUQnz+U8llYWC1Jdwyx
   hqHFvA+g4f8FoIFP37hVoMr3A+z5/bZpDHa11jbtuUYFnpYL4QgLpl88Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="321796015"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="321796015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="832193746"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="832193746"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2023 13:03:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 13:03:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 13:03:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 13:03:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+BvOA5XSxEXM7+NFnazo5BJT1q2S96qHQ7a91n38E9ubayrkYuZFiMbOQJ493Thont63PRkU4/ck/HJl4wZUcttG1Za/GcOw/NPxlVYktoEGVIxjMbV5aWTua1bxi+3aI7sodtY9rfpxp0uYQgMIrL65K+vXHmK4A8F6QE1+o31CINa5FZ6ycLCwKBAGU/XmsBznm2KeGGL6DWWDL4nMkT9OCMCgRc7qyTvgU6yAhDdCdsir7O7nJsXZ/teboYc/RWOKffgyzDPdThLuWqMU7Ugi+TMroNiTYM+GOPv5OZBxrwsLiQ/uCpRlVroG+2Zzy/WyKyvybfl2kOLdFbTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXdiljVNiGX/bR+zYZIhtNBfAIf0HyRGtQJvisBStLo=;
 b=MrVIr8mBiJf33zFuTNirZX4wl0cmxCngWV/D9cCMJh85iAZuxzHw3/ZJl56ii0jTxkEMXtV12fj3+ErmbmWNpLhYSvcdlcLXtkDsMj3Ydfjcv6UzuUIXg0KLd7rvfT7j09KO1cBNP7xK4JEbLwBRnMjn8e2DowZaWZClvSTMj/AlvqmDas7MFysHKWzUm6gZxDJPW7wb46NMu+5lkXdnwLp2LgN3Ao/0jmQryBuFKn0yDkCqMqCl2JeiupredPedaMIFKmqvj0BykGfttBmsbPsbXY2lDbYdIvy+vvIZYXfYxaCsWHShGXFqTn7corR/QqTMsekRhJPP39eeZ5EC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 21:03:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 21:03:03 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: RE: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Thread-Topic: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Thread-Index: AQHZJyR/hg4pL/N6e0ad2k2xs4MPaK6c0rqAgAACirA=
Date:   Fri, 13 Jan 2023 21:03:03 +0000
Message-ID: <SJ1PR11MB60832EF4EA3D528533100F8DFCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <Y8HDzzDaP5uY0v8K@Jessicas-MacBook-Pro>
In-Reply-To: <Y8HDzzDaP5uY0v8K@Jessicas-MacBook-Pro>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4829:EE_
x-ms-office365-filtering-correlation-id: 1a240220-0744-46c9-d541-08daf5a98fa3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBZa7SK0GoFeimb42z0r0TVdfhAWMAfUqElZPsT8ciuZgFk8/zyU7xSmv18ZZIkPaQDbcCL19BobaKasgWQhefX08cCxkLVYA1W8fMpxXod/9jWg7VsHBSF/3iEs+y5hcpGSvx8IKlH3tUo8+yBm7mzZxumsbAs9nQGhbWElutzFmOHleQEsjy0zquOSEZmXrOIdGrXwoooEzhQVDYXfJgRj9LyekYBv6QeWtjcvee+qSWhQRVs078O8Tl/4kOGYt/dCDibB0yu9CCzKUFIqL2JQUARqkFb4MFygIklfTj2LVE8fGA1LU9l1OCz5uFDdQKS2kDQuvySiAsFWAuuhnSiZiRUwezw3e8gctc0AYsK5RThAUaLTyeNlr/YhnUDwq53Kynuhhc+xwqmrPvC/jBXZLm3ixldIdZP9xsZr/Gwsjtt+R5qn4ltZZwvek2Zt0XsDXrExcwQ7H9ZdTB1lqQJkZrruMqFZpUdHxwR/bzmHOglQTFQg4OhWCcI4BrpSlXcIKkONIYVraOb0V2qX59xBX/dmbjEe3gO1ndL0UtE0iIyPPVakLn6sP6UGivJxYWn4dpjeEPiP7cCfd2AJj4GRYPSp2LGX7eYIE5ilo2gV8SJ1R1yD9QDZlaI9xFoSvgMxLqzoU5oQUm5+5NJS/AgIP9GczSvOt4Y0fvp1TdosmmildtDUO+qgwve4zZvNA3nTU/9q+g9XNsDDRtl7Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(6506007)(26005)(9686003)(186003)(64756008)(71200400001)(7696005)(38100700002)(82960400001)(122000001)(478600001)(38070700005)(86362001)(55016003)(83380400001)(33656002)(4744005)(52536014)(7416002)(5660300002)(8936002)(66946007)(66556008)(4326008)(76116006)(66476007)(2906002)(8676002)(316002)(66446008)(110136005)(54906003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMv9lTS3DURNW8qZddBR6X0pgrI5yk08WzlPbCE1xWQkvKpFdAJEbb8KiHy6?=
 =?us-ascii?Q?oagddOltWQJaa3vQN13qowidXLvyqg9dj/fBtuf+nrRQAPU9EHvHTNaf5/Vr?=
 =?us-ascii?Q?KtNaWhN6z6nRcXXuSBWYSzbWZNxEt4I6NpMes4PT2LkDMMwI7H+CaTjjnhBC?=
 =?us-ascii?Q?Fm9y9FYjq+A0j1IHY9AUavAFy+lCFfYT7/D9Y8BfijtO3HcoxHrSyVPQ5kFK?=
 =?us-ascii?Q?ceBsaEWXkkXQ/hQPDawfR3GLjGvharlwTm/gDQy/lTtrXvD+NJZhKma+Dfs5?=
 =?us-ascii?Q?ruNHCY9jaX8VeG9KmP1q5FEYe8jQGOctYoHto1LDEjAEqD3GQCmGT1uKQo+j?=
 =?us-ascii?Q?WFfNcbcrznsVEl1Efxdni014p2aVqZPTUMwv6tj77rYmmfNbxfP4+95cmAm5?=
 =?us-ascii?Q?CWybJQWN9R7cPQweJHVPVOVhi/HdxutK8uoLFTWGRIIzBsjERqki6+13dlXU?=
 =?us-ascii?Q?Terewz7ZKat/0bZ+N9fzqGhOIu+OAl+AOCwHEDGWJWt3w9xhv71IWOnUNS8E?=
 =?us-ascii?Q?pVjGCDgiw8osq2aVJ2ZFv3g2Qva9YvPk+MTQfz+wMVabvlWFaI4mGYm8c632?=
 =?us-ascii?Q?M3b4o4MovuVA1a9nK0YEDss4GqZhW9Ql3XS8YQVcVnuIdEaAJtZEAA0MQ2a9?=
 =?us-ascii?Q?vlmV10HBLtAxmK9PcUigHm/+bsw3wHWOFEX9y22RASVoHSAoWSdKEDayRWv7?=
 =?us-ascii?Q?1rm5BhsPEKGmLs6CPMS26vIZNXawm1rQ/oQUUWR54A40iYS/dHHPlgd7sLIl?=
 =?us-ascii?Q?xImJK0AUIkw6E5l2lOP545ltG1k3UW4MxRJOKVy6bafodI8wmFs0BzRvIgyx?=
 =?us-ascii?Q?v6seda1lbC/3I9gSEYcHGb8f9qvYQjzQ7BJJQ1pbmPGeeca1XKu4nM7cstyh?=
 =?us-ascii?Q?kLLLuxnZwtlrD5Y0xCSzcCtc+0P2UYUVyrixhXhILYK4ElFV7CeGERCEY+G3?=
 =?us-ascii?Q?4x9fO4aos1cegk2+VnUt6J4XBTNu+KMcY67OWKKLgBVjTXIVJ9rWDEEzcL/j?=
 =?us-ascii?Q?H9W+614JmJWe/8dIIwPZEUAWrOJB11NPzf8XbciJQprUiHy2MrWph9OK69od?=
 =?us-ascii?Q?g8BrwifrOxJK0iqS2fz6FGkRONLopNRCMOaERRxOpYu7uNy/208KVcy+JPVP?=
 =?us-ascii?Q?HbLiVfordC8A2OWhKhmf3Q7ENRtxgXt8IBvWkGq7jPthl19ljG84DbuDftDZ?=
 =?us-ascii?Q?Df7GaQP2RA9efFwJ2OHHbP0cbB4AR5r3bgRcuhWscg3sWKHGl0jGUqOCZHN/?=
 =?us-ascii?Q?0DlU7ifBJ15dyIvFaAcWoi6Cl1k+eJhrFru8UCUydQf1IWLswLPW6JQbco/E?=
 =?us-ascii?Q?vaBB9K5KpbM4x9GUcy7qfI3E5av/dK9HyJ+RgtUCYM/57EgqInUj1MECge/9?=
 =?us-ascii?Q?qWe9UnYec0DCc+wuLoA8HYbE0ns6aVJF92URCmS9HbxAsoEi9S6sxq9yIMDO?=
 =?us-ascii?Q?cXnPh1jVRqHEBwK28cX2IrWMwHSxQ4pBrTWfE+V6IPVbB47zbjR6CNRwXASq?=
 =?us-ascii?Q?I2KMQEILy+2G0xhGIzCir9DJImBQl4fn8QyvFlkb+Iw6G8vIW5mEBoZv/vJA?=
 =?us-ascii?Q?ZC74rUMQKKtQfvLvJSCJH6jYUafF0tR3Qo4ohsKv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a240220-0744-46c9-d541-08daf5a98fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 21:03:03.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iP+WoKMuNmzfW4VBvxRLXk0s8OaSIK3TWsGgHsXBnA7Rb+9dQmnjX4+KAcJTwb20eJFmuUZ+udwrovPao+s4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> For what it's worth, Debian and Gentoo both have ia64 ports with active
> users (6.1 looks like it currently fails to build in Debian due to a
> minor packaging issue, but various versions of 6.0 were built and
> published, and one of those is running on the one ia64 Debian builder I
> personally have access to).

Jess,

So dropping ia64 from the upstream kernel won't just save time of kernel
developers. It will also save time for the folks keeping Debian and Gentoo
ports up and running.

Are there people actually running production systems on ia64 that also
update to v6.x kernels?

If so, why? Just scrap the machine and replace with almost anything else.
You'll cover the cost of the new machine in short order with the savings on
your power bill.

-Tony
