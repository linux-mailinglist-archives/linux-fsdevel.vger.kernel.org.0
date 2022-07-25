Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFF58083D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 01:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiGYXcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 19:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGYXcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:32:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD16550;
        Mon, 25 Jul 2022 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658791951; x=1690327951;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lYnzv3M2/EBFdOJUNHFCot3TmeDYRjiE+1yl318nYww=;
  b=Upp8iamWSqlAtg1F0OlEatvFUUZBWsGD2JE4UmDdC3xPpjpjF6zaTfnf
   vl8V6+ZOkNAKcLSO8JuKZV55sWemQ+q1PvnyAQsXPeY1zW5ms+iZGscZd
   v7YSNqwlZMr+Cip4mpn4vAX5Wppd13TeYtpg82h/VQxtv4uofQPRLOSOu
   A1IeZThr+J8NT+hBaQp/CxqhjisCmLEssvLzsB8M0AyMtFX9OOlDg3asP
   hrpmbkhKtYbKEwbXzQ1yfu5eEqq0S0Yp08lUYGa2/tTyhPyHaY/vkf2pW
   Azv9NOew6fChtWY08WJdVmvskn4CjUGbeBCzdQMlSuPs5y4o9ybkcddFu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="349518360"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349518360"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 16:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="702679050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2022 16:32:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 16:32:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 16:32:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Jul 2022 16:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcEPdndGZcgUvkg62B1crAnGXLsxDe5Wfr8ljsnZJZ4CKYspC2Bz4cUayAQ4e1A3HFie10uZM89JHJqR3frUEvz/6tQYb8UT+lauxAIVxooOcCLn+uXxP0pPTgcSSMruHtx9404qTs0SkO11wbixF9Sc0MEPYmx6M4gTvtHSjyymuwhIgED84/37IIpqD604I+1pgQYGWZFtP/+Ru3neli1ijvwmhgH1aEkY8io0tS2wN8rb3reX6MpgbjRRlcfo+GggXecrdzCaxZwgWhW3RNpJ65x5H/l+GGb47XCtegQPZ00zzkOeyjbyH+x9SMv+7mqjeK+lUZ6743Hga38Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3QD/RPO8TmhqmTJLbcTPOEIzKaJZniIEUMUF+XQsn4=;
 b=aYCZKM2iNuauO+x/o614HbfkGdWqQXWb6WnSbzxzdaSpg28VRZzc+7ZRrpEq+oyjlmRAIjVRNBJYsdfVtm7RaMsFgqFnBSZuU10AC6c/LvsmWlUcFxCrInJfdn3QAuh8rtob/35Y0hzvHhWFeQmT9jXi4d96GhLvYmCJdjTvWUWEEv8u33FPDamoUSmn2sHJ/1uZurRQ9GPLlOXmkrdc5bi4o13ur9GMJdnK6q74Dc/C8zsoWkpODhbWlYpRW6loBXFWpd2jMwtQ32sfppg/p7Yvw8IfMN530UhMkEtfaC0boQGjBaTI4T+nflufUoKDheFzs/L1mezkZAfI3k4Kew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4317.namprd11.prod.outlook.com
 (2603:10b6:208:179::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 23:32:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 23:32:28 +0000
Date:   Mon, 25 Jul 2022 16:32:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Li Jinlin <lijinlin3@huawei.com>
CC:     <viro@zeniv.linux.org.uk>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] fsdax: Fix infinite loop in dax_iomap_rw()
Message-ID: <62df2808e5c50_1f5536294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220725032050.3873372-1-lijinlin3@huawei.com>
 <Yt8Hw2cXPz1ScQ1y@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yt8Hw2cXPz1ScQ1y@magnolia>
X-ClientProxiedBy: SJ0PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b23289-82a4-4be1-ea57-08da6e95efdb
X-MS-TrafficTypeDiagnostic: MN2PR11MB4317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMrEYdyTcuKgqgIdsOyiVgsUe68reR41T4rbs35BdYb3oB2/NHPQ899ch8soaXY5KkbyNClKywuNT0zKxsNuUZ3yDzOWGxhaAwFzU8I7EJR1Pi1Cl9zzbLwI96x4sAsuL1exnHt1ULkRVYzHs/e0fai/EBbPacRGsYXpldU3Q15DSR3Ne9JKwX8WJQq/9Q/qOBIiECv3snQtfa9pcLl1f1UZeQi0FhGVtT4IjPDdJ57Lw73RLBPYH9KU9vNcKTxXqEPi2Wm0VNsSmRff+0zx+oGy5htS8gmgPif1/LpY02rPfMN0OvMkx+Z051XEU5XALRs2hk4UXgZJViFKXUAaXuInSlPDKyzC4k5uanNkOJde5Aoybkp2spNpgVdy9WqlyBEOOkW3XIb6K7jst6+aiH1Sm/Wvb/rLqFCnnkqF6jy7fvTzjrq02BrvTYN9DIJbrw51YBlsgy8izf/4/Gq9I9+SjV3RNzxNWhiQgPKFeSouu3GIV2T5njNr1s8udKPhmaMbNnQRpASmng5mUvlmlQu1jrsmXEZDcdl93e1zVmPM2bvMw0cwLHRr9MSnVOsK05F52eTslSniBc6UvgdzLM6XnzCn7qKdZvioZcSfqrXGdv+Ko+u3K8rKkjHKQOjFAM/6FmVpAl64LleeAOQGmGBV/it7AKWT0LxTeECiw3QVF7P9o+sp/WmBypf2+igxCH5f1Ajv/Uwy7HZMyOcFPlnTAYtGbvQkToK0U6qgRvIhVpktzhEYUYCXwTxAn49e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(346002)(376002)(38100700002)(82960400001)(86362001)(7416002)(83380400001)(186003)(5660300002)(66556008)(66476007)(8936002)(2906002)(478600001)(41300700001)(66946007)(6512007)(26005)(9686003)(6486002)(110136005)(8676002)(4326008)(45080400002)(316002)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2nQKtd0Hgp5DGOEkLw/e4YwCr46NfVmoXmNtCllCzFWJ42NpVWwmPKM0dgb?=
 =?us-ascii?Q?QVHbGyqjc2m19kDqOUluIBFN09R9eto5LNJCHeZgl3tN55pO5eX2SinpeVdx?=
 =?us-ascii?Q?OoTdPNPj8/RCJ2T3C/U3ecPKQ0y0+vIRhRA2iJCOvtjJvUFHPc/hlrtaGc5Y?=
 =?us-ascii?Q?ZYvQm2vvfVTwa3FwfpfR4WGlVDXFa8U6lmQkFyPgD9+03jHeFgtm/x6+F+BO?=
 =?us-ascii?Q?0f63BOVyOHyIGG2QVlNodhYoT6JscUpbfUEEgslUFwNHeuq4SaGf15YZea0W?=
 =?us-ascii?Q?wlADYXain1BM3Seutg73kCroR0BoYqeSDa1gngD6qTNpq+nnKLKMCAjdIBvW?=
 =?us-ascii?Q?KlG2R01Oc4Vttx1WlKxPh7mdwzYfLqUBGq72Y2ICL9nts9L6/IXGF5rbBBRz?=
 =?us-ascii?Q?LvfCqoqFOXUOrfZd2QTM49BI5xHMwu9/GfJWOoq5Pacn1ipj+I93bAQaVHlp?=
 =?us-ascii?Q?zTLdd/U+XPUR5JZ+0+DRxa+ZU66wP5AHOxcj15k6YZOaqI4Z7csbfXFiGpQt?=
 =?us-ascii?Q?rAYmiLsWUETVkHoJKD9izfUvIk5FCW7mWY0WR6H2s2y7ZBk9vlSeIMjeS+PP?=
 =?us-ascii?Q?urR4pXKF9wezznGsGuBf69NvDxc4Ynyx8jrmRQwPpDD0drc9WeN89IVYchQN?=
 =?us-ascii?Q?IquV/z0T346DDhNJhqqpeUAV67ENROEwUHzjeCNjjNIB50KoUqqaSs+7CeK6?=
 =?us-ascii?Q?awZk0ikdoFQCE3v8dmWDtvM/+sc8J8nrDq//oFjHo+1XzGA6iHlsbTm1BSI8?=
 =?us-ascii?Q?cQEYiBfQ4TQTAytMq06Yn+maECj5+RIgv/ZEF81V3I+PenVsEihV+3I6T5uM?=
 =?us-ascii?Q?gueTKw8zsyhD6M9hk3fZ7ruqQNooqJEaKAOGlyTNAdH033NgxvhjbHy3/L/0?=
 =?us-ascii?Q?buVLo4gW3vForEs88gFL4k7/XVj+LZ5Wyv8ow2QbMnb8FjLDibS94QV+bwcQ?=
 =?us-ascii?Q?Uc669hUwa7kJ7aa+liX62az1aYkKC5poeO5hTQVMcv82Mco0R4IGxCXCXnRD?=
 =?us-ascii?Q?7+mnaYLsIAnjSU1Gj+2AxooJHu2+tr3FoTa3GWqfBLdLJXM9gD1OIT2XCJU/?=
 =?us-ascii?Q?HZKt1lp8W8cmwlNii9maafHWKaWfStuiuccyPCvRMpsdN5j6kvkZZJQIGrxy?=
 =?us-ascii?Q?fThtLUlAv272TrGO43TfFFs+WKS60XVw0SBsNn0GUKqxJZASJE1r72NrzNXj?=
 =?us-ascii?Q?+LV3gOy/kEz8mXjoQ72LwDjsMUM0ArMyzkCJBtOoJESHszzQ47PY0USPEZyk?=
 =?us-ascii?Q?adtKh4jYiYebMSHS8d/3bJKQ4BAaPmJqLELIZaDhQa54JFavxrpixFNJUgac?=
 =?us-ascii?Q?4tFozVh+hAiLF5vviOsTh8qtZMGI1cifg3q0Rm4dWPAA2EGoxHwSEHV3KSFm?=
 =?us-ascii?Q?4ilw0v4qOWmD3zuChyxorGEVNAemjfFlwYIJuo1CVbIAQtNp5indGE6YugJD?=
 =?us-ascii?Q?Eequ8KiUY6mModD7SZG6oyFJ79AqTyG5rIR+fq9XDX2huShPVNhNaKfHX9me?=
 =?us-ascii?Q?LM43qoddh38A7GfY6cKnKyL1UyWhEd73AXJapByBN+2URAZIKsiQ0+Yn+Pxe?=
 =?us-ascii?Q?1iQjmc1Zd/4EGTksB+oVrvk2uQ5C8jjZQDqxK5/E8oIhVeOZneJdUdIJUbjj?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b23289-82a4-4be1-ea57-08da6e95efdb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 23:32:28.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77GC/SbHKUxsXVchG1MiI8uIknJSPgflXmKhysF4Dha1LYHAvOdf6O3xTDpuWMwH/wLpCS6/evgi8YbEmpR4etu484dbsNbolrg1rXAS6Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong wrote:
> On Mon, Jul 25, 2022 at 11:20:50AM +0800, Li Jinlin wrote:
> > I got an infinite loop and a WARNING report when executing a tail command
> > in virtiofs.
> > 
> >   WARNING: CPU: 10 PID: 964 at fs/iomap/iter.c:34 iomap_iter+0x3a2/0x3d0
> >   Modules linked in:
> >   CPU: 10 PID: 964 Comm: tail Not tainted 5.19.0-rc7
> >   Call Trace:
> >   <TASK>
> >   dax_iomap_rw+0xea/0x620
> >   ? __this_cpu_preempt_check+0x13/0x20
> >   fuse_dax_read_iter+0x47/0x80
> >   fuse_file_read_iter+0xae/0xd0
> >   new_sync_read+0xfe/0x180
> >   ? 0xffffffff81000000
> >   vfs_read+0x14d/0x1a0
> >   ksys_read+0x6d/0xf0
> >   __x64_sys_read+0x1a/0x20
> >   do_syscall_64+0x3b/0x90
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > The tail command will call read() with a count of 0. In this case,
> > iomap_iter() will report this WARNING, and always return 1 which casuing
> > the infinite loop in dax_iomap_rw().
> > 
> > Fixing by checking count whether is 0 in dax_iomap_rw().
> > 
> > Fixes: ca289e0b95af ("fsdax: switch dax_iomap_rw to use iomap_iter")
> > Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
> 
> Huh, I didn't know FUSE supports DAX and iomap now...

Yeah, it came in via DAX support for virtio-fs.

> > ---
> >  fs/dax.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 4155a6107fa1..7ab248ed21aa 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1241,6 +1241,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	loff_t done = 0;
> >  	int ret;
> >  
> > +	if (!iomi.len)
> > +		return 0;
> 
> Hmm, most of the callers of dax_iomap_rw skip the whole call if
> iov_iter_count(to)==0, so I wonder if fuse_dax_read_iter should do the
> same?
> 
> That said, iomap_dio_rw bails early if you pass it iomi.len, so I don't
> have any real objections to this.

That was the same conclusion I came to...

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks, will get this merged up for v5.19-final.
