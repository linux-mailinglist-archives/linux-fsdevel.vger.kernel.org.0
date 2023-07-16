Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDC754F13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjGPOsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGPOsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:48:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A761B4;
        Sun, 16 Jul 2023 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689518885; x=1721054885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EJSysTs2Y0ZSs7jaXJXk4KRSi2Kve1Yiznrb18g37cY=;
  b=NE8kTNjko8DnhI7Pbq8k1X8jSwQPuxzZ5qBmWYsJK1sAE2KpEY0wFOwc
   rUv/HdU5jWLQQjcinEV8Jh9i4tMmvEkLxXzF5peZBVE8kLCEl2RLk6+Xw
   cJCG0mtJVO0pS90TDYzFtIByLysOFyib2kmeS2C3kGwst2XATXrXQF0J3
   arcFWQw0q+XUYcXiCaqpoP/kaCXLeYo0T27DbRCzBQnxhhgi/qK3b9Cuy
   MgdsYHTXrRQ2dS7J2pQA/yswYVdPl0xMEiOXNSug4sT1O0LOKW/4GrusK
   /IleE6hxAl8YPhw69LZBsokBb0TrWNrNem7rnTf86HC1QGS5h02A+s+8s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="345353532"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="345353532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 07:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="722936909"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="722936909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 16 Jul 2023 07:48:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 07:48:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 07:48:04 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 07:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK+mvuWX+R95YJ93w8yijYkpbCnB68RTYXTwEdO6P9BOUK3MJjU+2W+p5NVOf3S1RHki+u3YJI/wUQf1qI0grjYgIQ4VCgh6noRMsaSSeWZODqjDuxNomnNADaXDfmanvfLyToqh4BboU/PDu22j93I90nuwFD3exDI4iyoIv28CrjLXMS468pyX5jib4E3vBrmQbDFzo/BOwtmjVrB+ylEc+tM7J0BSnK9a+GD8pdXVX5SqKBl8XDlidDpvn28NWP9cxnagiGG0OuK9twXwDmUkev6AGwkat9Ccoy5pzvw/8cl7D/gaXu+RORpoBaAKFFYHdvWq4eIUBhpUV3ptqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYcsw74kGy9NDM2Wp5gkfGsd5HpqyIhG7J+5AjvgbJQ=;
 b=nN/Mp3jhyQ03af9IXsy6P53nCcNKYrIqrGgEtJoQcW3WU1bBfT+xdAyXRcsK0GKVyLcBqE48liJ1id3gGIgOAY52/ohcnlF/Y4Pfhav7XFADodeBjc9Z2xsy2w1CkIR9yWCFWnXd6ENGuICNRv2+COlOPwGK6NyLtmgPsYeeyr/rRVJmwktOrH/daxFEVWZpnEcNdIQuMlsx5fVxwvTLZqGOL2J/Da4wm8Hkxl1fak0Tcrhcri1AeLXl2d95EccUBJEA3cSCpKoe5OwBpOXfzw+FhSSm3k9LMqnpn/99fnx/5Hg7bMF4tguDv2EYUnUQoB23UzDBLBRQLFmhQ2COJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 14:48:01 +0000
Received: from PH7PR11MB6056.namprd11.prod.outlook.com
 ([fe80::9293:fab2:6fa:2491]) by PH7PR11MB6056.namprd11.prod.outlook.com
 ([fe80::9293:fab2:6fa:2491%7]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 14:48:01 +0000
From:   "Zhu, Lipeng" <lipeng.zhu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Deng, Pan" <pan.deng@intel.com>, "Ma, Yu" <yu.ma@intel.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH] fs/address_space: add alignment padding for i_map and
 i_mmap_rwsem to mitigate a false sharing.
Thread-Topic: [PATCH] fs/address_space: add alignment padding for i_map and
 i_mmap_rwsem to mitigate a false sharing.
Thread-Index: AQHZqa7v2P+L/8oj4EeZct/uP09QLK+nAB2AgBWMBKA=
Date:   Sun, 16 Jul 2023 14:48:00 +0000
Message-ID: <PH7PR11MB6056EB3C6651A770BF0081699F3AA@PH7PR11MB6056.namprd11.prod.outlook.com>
References: <20230628105624.150352-1-lipeng.zhu@intel.com>
 <20230702141117.d9827596dea4ca9d6c5d1fd3@linux-foundation.org>
In-Reply-To: <20230702141117.d9827596dea4ca9d6c5d1fd3@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6056:EE_|DM6PR11MB4708:EE_
x-ms-office365-filtering-correlation-id: 4c4b7ab9-5246-42ae-8431-08db860ba71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fHE0v5KTHqgEPXOrZVcieqfMUnyWXl37kOhG8k8kMlsQ3UA3tKhFQsN5BWsHp633KeAg1ps4YOrP3fOe+C8gLFKW2l+XoCyE8h0Qsok8JKT/J40yT+LXIuEMoPI6Bchp7U6XnOTesFYGNEVEq56G76OxYLNZKiLwlgdLCfSbWsUJkwUN8o/fF84X+C6e3uCjXslPrJx67kQHQelxkbttJeG7NGuHT9F0w/inBqFwMhOwJpX6DqxRNAchUAzEhHA5tO9QOfmdwICkDNfT1qEzSfkUfgX8HMNsXvqTsQ+pN/oHNa2Utw0p2Yn++SG3jJSkMHD9iphR8FXSvlw8V/wKEz0F389ybBQBGJ/4V6eGyTUULUbB54ButpBgpIB1UCDBJC9xmxbDI1u17WI4AarPaO9O8QrGFFBHT1BkCa2MWH0j0PSoMKxSsS3dp4+FZcvsCqTnV4epH9PvNAZmlC7ompjZgP9fjLzSuVoXnXHGH8mal4TVLg5EuoSLUIOSqQbT6w1dnLe4Nb8TyC96OVBXIbIh3caZ3WP4Ym7FXWvMqEr3jTHCGO/0iFIfxDn8xdrkncmP+M7fSlsqObZ0OVabZaG8838B8PxAFLoLu6qf6oI9vLFrEz2+JSMshNlM4u8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(55016003)(54906003)(122000001)(82960400001)(38100700002)(7696005)(478600001)(41300700001)(8676002)(5660300002)(71200400001)(52536014)(66446008)(316002)(66946007)(64756008)(6916009)(66476007)(76116006)(4326008)(8936002)(66556008)(186003)(83380400001)(53546011)(9686003)(26005)(6506007)(86362001)(40140700001)(33656002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wtS9Ap98b/eobcVBiUMYI10NBzoS2K4PO0WhhdRzyF77/bm4yeswuJqtC5iK?=
 =?us-ascii?Q?B9TxPpJJ52/26INhV1jVK7DRBFGeSwu+tLMVA/zPycngd5d8d80VQ3g+5Q0x?=
 =?us-ascii?Q?NoW8+KrQ4mOogEwsXKkD//P8PvKjs74lMXrNwQt+LhyAh6fUxI7rGAhTpxsb?=
 =?us-ascii?Q?mYMYNWDGl0LGndLNfUMm6MlxndPZnLqdUk4aVggP2wWuF/+9OrgBiIpD1Rxx?=
 =?us-ascii?Q?eFoHPeeNOuWng3WALF1UHKzgncsroigSdlPvJr0afpAXaAFf2lGMJQ8MZbe0?=
 =?us-ascii?Q?GAfLpSbshZcz0anonZQPh1k2mfc9AaEdBMT13tYZGxIa2rfHOWORJB88quKH?=
 =?us-ascii?Q?Ie01Aj7BlqlHIO3ZnHd1cMr44CnI2XiIdMpRb2eoLMso23Jo3EzXvpt5r8A8?=
 =?us-ascii?Q?ALapjvJDtl7105Xb7iKAtrmwXLsfsi5RRuxvq+rLVCcABqTXD2jjKCQOR65D?=
 =?us-ascii?Q?33qUqiHRXIKGSG9EOOqkKcpPBqQphNKwXsz/oVzCZw6NgOq1u+F5UlO1jWLe?=
 =?us-ascii?Q?QrKG84iu93+b5SQ20MqxIJKlyx9QPbjeIjCOKKUMMk8SGpsEGy9bYTpPjUGC?=
 =?us-ascii?Q?hzJ/IduPAtT1s0ShQrbVbOd+mKTJSh3fFvz2nvlVmgoLiQohCjexbGap2O2T?=
 =?us-ascii?Q?HdLYN3vTgufou6tO4jQZ7jtSOUtSLq6HZYlFG89sq+v2uWDQsePRP6SoqsKO?=
 =?us-ascii?Q?Q0WWptg6pEj6UBSof6B5pG/riaueHAvLixm0pNpg3tuyStiF4tSEkV+6BPov?=
 =?us-ascii?Q?JzYf9ekrJp3mG6pIG1JpLirSpl2u0d2AgIa8sXAFFi7CMRQWsHuM3360sr+s?=
 =?us-ascii?Q?Lw1wB4YGK2UegUua4TvloPTPS/QsoGV1tF/a+aanPwCL9nKX9zrnKvFaV0Lj?=
 =?us-ascii?Q?FZxa0UwOXXv7FO0QtnC1DfQAUIyS7mW2h5nRFiR7VshFdATDjMBDvtg96ZQx?=
 =?us-ascii?Q?GIMugg1RpHKzkAyKDO+DTxvNunaqwyGPOFwF4vxjPSBe7JaeYEfaAxsV3YDF?=
 =?us-ascii?Q?OLrX4X/OiC2Rv4rfe/wq4GCoJRghOj5lx2XleyIqXzd+RMIyLmdt/Rftob+h?=
 =?us-ascii?Q?+3wV8apnKrwDkm3G/CIpe4JYJBqO4DpWiMsYh5DRRavg2QbKx5zpLZ6BKuDm?=
 =?us-ascii?Q?Mnd3jMU9N+TrHnA2z4HKJSptRggFUu1I3BYkX/8hYMkPAvMAcihjEQ01bFNd?=
 =?us-ascii?Q?dUFPaBv5Cu3Cxx0bRmc4WeQCVIpVAhbmswpTUwcVdzLegKMayv4Wz5JUM+bW?=
 =?us-ascii?Q?1EPFTHaZHs5X6gQNT4Rq9trRE4/mdLYxTwnOgKH4oP9Ei8RW0/w8yZ85UPvf?=
 =?us-ascii?Q?6bNLh3SF6a+oeJFlF/sh/82PVsMiqx3tcy65yq05xLWxD67HyV85Wl4ZnDtE?=
 =?us-ascii?Q?dEtLo4iw3GnEoWC5XtEKqKReZYTdKq+VxnRg8MP0VrRINnlY8vce9eRyLQ18?=
 =?us-ascii?Q?UcO9t7v6wsxVKCKixERsK9i51ugZLzh5AJkLQKOCypUXVLO4bqM9rSrdSUVF?=
 =?us-ascii?Q?JrfcJ3yZjLaESjBmjQqGOm3keZi5hOzU2AFO+48shoKjtQJVgXUh5FRhFVdm?=
 =?us-ascii?Q?GS55y93QF/nWI22jAaLpMEPah21TEDCtZMXaCGyL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4b7ab9-5246-42ae-8431-08db860ba71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 14:48:00.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTFJxv0fTjasNB+/QGraJbm1/LNKTukXkn9pO3DX57PnZr3DtADoPfA+8SZEY4XRVhF80KhbwIh9tU59reR1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Monday, July 3, 2023 5:11 AM
> To: Zhu, Lipeng <lipeng.zhu@intel.com>
> Cc: viro@zeniv.linux.org.uk; brauner@kernel.org; linux-
> fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org=
;
> Deng, Pan <pan.deng@intel.com>; Ma, Yu <yu.ma@intel.com>; Li, Tianyou
> <tianyou.li@intel.com>; tim.c.chen@linux.intel.com
> Subject: Re: [PATCH] fs/address_space: add alignment padding for i_map an=
d
> i_mmap_rwsem to mitigate a false sharing.
>=20
> On Wed, 28 Jun 2023 18:56:25 +0800 "Zhu, Lipeng" <lipeng.zhu@intel.com>
> wrote:
>=20
> > When running UnixBench/Shell Scripts, we observed high false sharing
> > for accessing i_mmap against i_mmap_rwsem.
> >
> > UnixBench/Shell Scripts are typical load/execute command test
> > scenarios, the i_mmap will be accessed frequently to insert/remove
> vma_interval_tree.
> > Meanwhile, the i_mmap_rwsem is frequently loaded. Unfortunately, they
> > are in the same cacheline.
>=20
> That sounds odd.  One would expect these two fields to be used in close
> conjunction, so any sharing might even be beneficial.  Can you identify i=
n more
> detail what's actually going on in there?
>=20

Yes, I'm running UnixBench/Shell Script which concurrently=20
launch->execute->exit a lot of shell commands.

During the workload running:
1: A lot of processes invoke vma_interval_tree_remove which touch=20
"i_mmap", the call stack:
----vma_interval_tree_remove
    |----unlink_file_vma
    |    free_pgtables
    |    |----exit_mmap
    |    |    mmput
    |    |    |----begin_new_exec
    |    |    |    load_elf_binary
    |    |    |    bprm_execve

2: Also, there are a lot of processes touch 'i_mmap_rwsem' to acquire=20
the semaphore in order to access 'i_mmap'.
In existing 'address_space' layout, 'i_mmap' and 'i_mmap_rwsem' are in=20
the same cacheline.
struct address_space {
    struct inode *             host;                 /*     0     8 */
    struct xarray              i_pages;              /*     8    16 */
    struct rw_semaphore        invalidate_lock;      /*    24    40 */
    /* --- cacheline 1 boundary (64 bytes) --- */
    gfp_t                      gfp_mask;             /*    64     4 */
    atomic_t                   i_mmap_writable;      /*    68     4 */
    struct rb_root_cached      i_mmap;               /*    72    16 */
    struct rw_semaphore        i_mmap_rwsem;         /*    88    40 */
    /* --- cacheline 2 boundary (128 bytes) --- */
    long unsigned int          nrpages;              /*   128     8 */
    long unsigned int          writeback_index;      /*   136     8 */
    const struct address_space_operations  * a_ops;  /*   144     8 */
    long unsigned int          flags;                /*   152     8 */
    errseq_t                   wb_err;               /*   160     4 */
    spinlock_t                 private_lock;         /*   164     4 */
    struct list_head           private_list;         /*   168    16 */
    void *                     private_data;         /*   184     8 */

    /* size: 192, cachelines: 3, members: 15 */ };

Following perf c2c result shows heavy c2c bounce due to false sharing.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      Shared Cache Line Distribution Pareto
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-------------------------------------------------------------
    0    3729     5791        0        0  0xff19b3818445c740
-------------------------------------------------------------
   3.27%    3.02%    0.00%    0.00%   0x18     0       1  0xffffffffa194403=
b       604       483       389      692       203  [k] vma_interval_tree_i=
nsert    [kernel.kallsyms]  vma_interval_tree_insert+75      0  1
   4.13%    3.63%    0.00%    0.00%   0x20     0       1  0xffffffffa19440a=
2       553       413       415      962       215  [k] vma_interval_tree_r=
emove    [kernel.kallsyms]  vma_interval_tree_remove+18      0  1
   2.04%    1.35%    0.00%    0.00%   0x28     0       1  0xffffffffa219a1d=
6      1210       855       460     1229       222  [k] rwsem_down_write_sl=
owpath   [kernel.kallsyms]  rwsem_down_write_slowpath+678    0  1
   0.62%    1.85%    0.00%    0.00%   0x28     0       1  0xffffffffa219a1b=
f       762       329       577      527       198  [k] rwsem_down_write_sl=
owpath   [kernel.kallsyms]  rwsem_down_write_slowpath+655    0  1
   0.48%    0.31%    0.00%    0.00%   0x28     0       1  0xffffffffa219a58=
c      1677      1476       733     1544       224  [k] down_write         =
         [kernel.kallsyms]  down_write+28                    0  1
   0.05%    0.07%    0.00%    0.00%   0x28     0       1  0xffffffffa219a21=
d      1040       819       689       33        27  [k] rwsem_down_write_sl=
owpath   [kernel.kallsyms]  rwsem_down_write_slowpath+749    0  1
   0.00%    0.05%    0.00%    0.00%   0x28     0       1  0xffffffffa17707d=
b         0      1005       786     1373       223  [k] up_write           =
         [kernel.kallsyms]  up_write+27                      0  1
   0.00%    0.02%    0.00%    0.00%   0x28     0       1  0xffffffffa219a06=
4         0       233       778       32        30  [k] rwsem_down_write_sl=
owpath   [kernel.kallsyms]  rwsem_down_write_slowpath+308    0  1
  33.82%   34.10%    0.00%    0.00%   0x30     0       1  0xffffffffa177094=
5       779       495       534     6011       224  [k] rwsem_spin_on_owner=
         [kernel.kallsyms]  rwsem_spin_on_owner+53           0  1
  17.06%   15.28%    0.00%    0.00%   0x30     0       1  0xffffffffa177091=
5       593       438       468     2715       224  [k] rwsem_spin_on_owner=
         [kernel.kallsyms]  rwsem_spin_on_owner+5            0  1
   3.54%    3.52%    0.00%    0.00%   0x30     0       1  0xffffffffa2199f8=
4       881       601       583     1421       223  [k] rwsem_down_write_sl=
owpath   [kernel.kallsyms]  rwsem_down_write_slowpath+84     0  1

> > The patch places the i_mmap and i_mmap_rwsem in separate cache lines
> > to avoid this false sharing problem.
> >
> > With this patch, on Intel Sapphire Rapids 2 sockets 112c/224t
> > platform, based on kernel v6.4-rc4, the 224 parallel score is improved
> > ~2.5% for UnixBench/Shell Scripts case. And perf c2c tool shows the
> > false sharing is resolved as expected, the symbol
> > vma_interval_tree_remove disappeared in cache line 0 after this change.
>=20
> There can be many address_spaces in memory, so a size increase is a conce=
rn.
> Is there anything we can do to minimize the cost of this?

Thanks for your reminder of the memory size increased. After the padding, t=
he
struct "address_space" need 4 cachelines to fill in, the memory size increa=
sed is
around ~33%.
Then I tried another approach by moving 'i_mmap_rwsem' under the field
'flags', no memory size increased for "address_space" and based on v6.4.0, =
on
Intel Sapphire Rapids 112C/224T platform, the score improves by ~5.3%. From
the perf c2c record data, the false sharing has been fixed for 'i_mmap' and
'i_mmap_rwsem'.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      Shared Cache Line Distribution Pareto
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-------------------------------------------------------------
   0      556      838        0        0  0xff2780d7965d2780
-------------------------------------------------------------
    0.18%    0.60%    0.00%    0.00%    0x8     0       1  0xffffffffafff27=
b8       503       453       569       14        13  [k] do_dentry_open    =
          [kernel.kallsyms]  do_dentry_open+456               0  1
    0.54%    0.12%    0.00%    0.00%    0x8     0       1  0xffffffffaffc51=
ac       510       199       428       15        12  [k] hugepage_vma_check=
          [kernel.kallsyms]  hugepage_vma_check+252           0  1
    1.80%    2.15%    0.00%    0.00%   0x18     0       1  0xffffffffb079a1=
d6      1778       799       343      215       136  [k] rwsem_down_write_s=
lowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+678    0  1
    0.54%    1.31%    0.00%    0.00%   0x18     0       1  0xffffffffb079a1=
bf       547       296       528       91        71  [k] rwsem_down_write_s=
lowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+655    0  1
    0.72%    0.72%    0.00%    0.00%   0x18     0       1  0xffffffffb079a5=
8c      1479      1534       676      288       163  [k] down_write        =
          [kernel.kallsyms]  down_write+28                    0  1
    0.00%    0.12%    0.00%    0.00%   0x18     0       1  0xffffffffafd707=
db         0      2381       744      282       158  [k] up_write          =
          [kernel.kallsyms]  up_write+27                      0  1
    0.00%    0.12%    0.00%    0.00%   0x18     0       1  0xffffffffb079a0=
64         0       239       518        6         6  [k] rwsem_down_write_s=
lowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+308    0  1
   46.58%   47.02%    0.00%    0.00%   0x20     0       1  0xffffffffafd709=
45       704       403       499     1137       219  [k] rwsem_spin_on_owne=
r         [kernel.kallsyms]  rwsem_spin_on_owner+53           0  1
   23.92%   25.78%    0.00%    0.00%   0x20     0       1  0xffffffffafd709=
15       558       413       500      542       185  [k] rwsem_spin_on_owne=
r         [kernel.kallsyms]  rwsem_spin_on_owner+5            0  1
=20
 I will send another patch out and update the commit log.

Lipeng Zhu,
Best Regards

