Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5082711F03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 06:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjEZExe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 00:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZExc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 00:53:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A412E;
        Thu, 25 May 2023 21:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685076810; x=1716612810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fy7amZXgJtrz2lodrsuDSp6en67cFhYG1krd8uYpOgs=;
  b=A4FqLQjzimWlM9Yq9+g29mKKI+NaWGrfym+YH/WrN0YK/J92mJE1xJiA
   xcZTVVH1G6VK2XY27PFus5feW4Z5hC5tUqK3wUS+3j/c0D59j0vZF7+K8
   pc/hF6wevhhFMnzZboJRyCGp4CGybZD5B/1vFwbAaZypVkcTcmKhuX9cu
   K3rY59RHmJZxIaPiHiUA3AYRgmiLQTctYezhXStq+i091ZMDAo6cummtd
   K4f+sX3AvN5VybWWSX7ubtZYPndUqTnvSEMubSudROELPzUqOCgWchquk
   vgru/MkfQNhiSxhPl2rOnA8Iq01B8H9cpGD5NL5fVgJ+OgBCNDYwSgkHK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="351627239"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="351627239"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 21:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="699294406"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="699294406"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2023 21:53:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 21:53:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 21:53:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 21:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G07XDcStB3BWM9740FwLjAPIHwHrWoKx8EAAv+CM7zdVjs/nT48inlrYDNpoUhOL9CnoPUDg7XX+kPEbAwXuuzpuYNtEs3vuJBFzhUGyG5fY6oRX7SRsLgH791yJ6y74QCHklSlO5pniT5Hks7iFxWrSEm0otfjzjK30EIhEf0PjP+vYqTE2GxkuobRBb4P7llfFdgAxorx+XfPq9Bt+GLT4ZimyUTWc069fskErwnpW+xDy4Oedj8Nd9Wafdpa3r7DBGbHKStSI+ymnP+0vNw+dgwdXShz9/t/tu5jRurcdPwDBkrpyfj+BHsHa1RilyTPIsdOi6Tda4qS4OUtDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skHoJA70t+8FETepaGuw7Efj5l0eq7gaSMKWXqUiT28=;
 b=kSbP8NzaNhk2jCQpkX3dGp/xDlg7NFk9vbN13ziFWLAUTLs1mTCqZlnMTrR2rXFPIVdlPMqbGTZF3Kru5QLgDAlDVsNQIEmjmnQLeaJuvaHgEb5sZAwiTxynI9/i7b1hPkur3L//Ae5q0Gpau4fwXkNwuRjiq/oHMkIhlM2MxqHmwmBDI1pZO+441gO3KXj0hb5m4mFG4+C6uuKDVAwX3nYm4Hk3QfPplhzsGTKI4ViFT1qHozvbUl0lDxq5nEcbr7hiDqD1Ya31JbvsCJ4NOrQaqHUdBs78X92gfNxgUQST20f1PEJLzkPQDtkRrlY6t6mbp9g1g7X5ldEkrLvU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Fri, 26 May
 2023 04:53:25 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 04:53:25 +0000
Date:   Fri, 26 May 2023 12:55:23 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Eric Sandeen <sandeen@sandeen.net>, <dchinner@redhat.com>,
        <djwong@kernel.org>, <heng.su@intel.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <lkp@intel.com>, <nogikh@google.com>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <ZHA7uzlUEy5QILxm@xpf.sh.intel.com>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
 <ZG785SwJtvR4pO/6@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZG785SwJtvR4pO/6@dread.disaster.area>
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: a9549ff5-fcb4-47dc-d60b-08db5da52353
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtiO0TDb0McyDQyyXDP5vkFRiz86E9Mf8/O45axsFr9VjKwBjM8YhiaxrjfjtAqgi1H3hTMSmCkIuedRe58dAjkWepkbnivaFRDAVe5OOFkAilaq/mRIXg+PBEOCfwayfwXv8JKeNxONq0vOqMiGyfZ8cAFzFi73A35xOFKpqUF5U4ZriJA5sy2z7PkuvWAw7JIMFApst0ZeTs+vAGv3ZQAnroiZW0Rwlc3eH9YwWawvvx4aDKB/RbaWyM82W144R3Ym5fGPv66SUWCQt1Gpx5GvRzyt3M5SGF9qcDZhQ8f7TQ0XDdBdHfljsePhxIl1jQqHBWhRwldBimPdaia8CUystsTw1cFIPig/m0tcAR9BNTZUbnmm+/Y17Yvc9jKWsbTWrZrpcEb6SpBFsXduaL1Z6lIc3UFoT1Hh9SU5cU90r3u9lmUl+IMWo1mi+PjbCU3pZSzwXahI/FFjl6PMxPDDPbuNIb5LHCBiSrF6P+sEsM08TsI8s7Y56uBDW7zMqkx88Dkl9bhvVTv+pJG647DjbHhPS0SO/XUYRfItC0jzro+NC7wco64Iz2BwQb4kkR387wHTspqo69DKWEqZEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(41300700001)(6486002)(2906002)(316002)(82960400001)(5660300002)(8936002)(8676002)(186003)(38100700002)(86362001)(6506007)(6512007)(26005)(53546011)(966005)(44832011)(6916009)(66476007)(66556008)(66946007)(83380400001)(478600001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bb2ovh6YKNLiBVHvNGiKkWGxY0veEyQ06lUya0gc5hiGV/LNoQUYTVcqXo9C?=
 =?us-ascii?Q?4WYEZA78lXE+5+fi0/l25ZhSEY5SAmI0SQehgz6hvToFNPke8PKEqKbPK14d?=
 =?us-ascii?Q?dX5cFGF3h9HaC95aba6RRpC1w0fhGcPvijVoyEdz9sm6Pu0NEu3DV5XrO6+1?=
 =?us-ascii?Q?phe7HXkNbjZMI7u37DGRmQXM1cHvrk+Q5toyZhhruX4biK6Gl9Y4tlIpsJ2O?=
 =?us-ascii?Q?pwFwE/LzImrW2SyDxaFiQvMHEcesaWApd2OeTnVhd03hA34EIU7Qpe5lkj1y?=
 =?us-ascii?Q?XpA6RvpLvGUA70KyUd7qWbuBT3yOMqVTsRZS/R5zcbBckb+6O+2ZusFKi8Oo?=
 =?us-ascii?Q?yi48VxenRMnE2Fob6u8GDW1feVWqxVW4nbdivY9eVCvC9VHPo/+FIG4KUxye?=
 =?us-ascii?Q?nfld5w3Bf/vVVL39kmmjHUCWzK4yH3j9BvnSlOpZwfxmv1ZtEyEG+PWLRo2Z?=
 =?us-ascii?Q?BPIbg8JmAP5oCdvQVJlwDmN7P0sIK5/8XjQKHHQBCDGAscF3sgeo0lzTbvw0?=
 =?us-ascii?Q?LUMj03YqDoD0sby6uNfo0wLKfcKY4QylivvfDdeO/uf9To7/uyn9igY/RxIK?=
 =?us-ascii?Q?KGIzGlo7mxkfQG18XodgbwRrqxkIPTyJ8VvpQ66zLSjkVKBsDh2XfSkMKG29?=
 =?us-ascii?Q?c+l5d0ZcgnGGdQETHaaN/d+ZKjezCDiBgddQZPgRdSk/nCXuxPfZx/BwJ4yG?=
 =?us-ascii?Q?hqN6jf7F4FfycnJa1nMqqiEBxHWofo1ZpFNeZkm6ODpd8TsvyC0QCg3B1RuH?=
 =?us-ascii?Q?MwAi/e6cBeBBuEpI1XMWDCMHUSobrRmlLyC2rVItXEJ7O94M/Odu6Ev9kubG?=
 =?us-ascii?Q?4QXezQn8OwZpdNXrs11XD+AEh7bCnbu0UvkZbUVZ9t5cI6J+84ghHJlyGHWu?=
 =?us-ascii?Q?BkHMpdIFuIEhvWdZ4Jg7DPQwC8YhEqdpHgyJs3NR5ncsFTD7EySa5zwokFlp?=
 =?us-ascii?Q?4aAoIlogCkjQJOLLqg/fZmGRM1ta1naparLBSNH1WddYwD4MJA+BolXNnvgu?=
 =?us-ascii?Q?tKbPtugE1PN8P5sgqDqU2XpveFiui8yzIxEODZ9BDatssaD5TVZYxln9lz+H?=
 =?us-ascii?Q?4vTSCiDbs/2SGk0ccIHR5eq9x+NbaDMzH+i5UPVChBJXVNlMamr2DdUh8qZt?=
 =?us-ascii?Q?1AqWj5TAUmTN/KaZWjf/L9+n7rsYGBzYZ5fyO43vwEaWu5ZYAViIQWmKsPPE?=
 =?us-ascii?Q?wmtmReUDXDo/wO+5EH8ZdLzrkB6jDDfZcYUsKUBPeMrFWToMOAFSXOTyOLCb?=
 =?us-ascii?Q?v1eRw7vmMF+xl4+wNMCLIRCnM5yCV0WXJU0IicdvC8bKFVy1+m8wZ4pRz3u5?=
 =?us-ascii?Q?c/O/xkx2kV4+8WDmXB8GVX9R5iyarIBmnbiTDhY81Kgfl4mLBgojhNrHydHo?=
 =?us-ascii?Q?IftA81JiRMp+zpR6vZGSK4QmPGjg5q+o+YXubqmwjzgKoukSHZo5oJVbDGW+?=
 =?us-ascii?Q?yrXhBchvIOLz0EA87hq7l6n4pCASIsYS1dJ2ZXhn34l7Mj7NqXZQYWbyUvBX?=
 =?us-ascii?Q?JyAnzknSW2U2Rf7t/DHXBIzVPEGl1v5sUfKu0vUdHZWesEz3tjcDhvgDt/U8?=
 =?us-ascii?Q?eA5Kmri50tlj64NMQ1MZc44JoHJu4rzZL8Q/KzXbDh34lu751JowUbggZzpw?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9549ff5-fcb4-47dc-d60b-08db5da52353
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 04:53:24.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjr4VlQagk+zsUODShg1PUY+7j6bPr1Nk4y4QjzB0XGYcWMLEft878pn3UakLgPInPaaLEYFczY/PQM5OyCjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5820
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 2023-05-25 at 16:15:01 +1000, Dave Chinner wrote:
> On Thu, May 25, 2023 at 01:44:31PM +0800, Pengfei Xu wrote:
> > On 2023-05-24 at 22:51:27 -0500, Eric Sandeen wrote:
> > > On 5/24/23 9:59 PM, Pengfei Xu wrote:
> > > > Hi Dave,
> > > > 
> > > > Greeting!
> > > > 
> > > > Platform: Alder lake
> > > > There is "soft lockup in __cleanup_mnt" in v6.4-rc3 kernel.
> > > > 
> > > > Syzkaller analysis repro.report and bisect detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230524_140757___cleanup_mnt
> > > > Guest machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/machineInfo0
> > > > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.c
> > > > Reproduced syscall: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.prog
> > > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bisect_info.log
> > > > Kconfig origin: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/kconfig_origin
> > > 
> > > There was a lot of discussion yesterday about how turning the crank on
> > > syzkaller and throwing un-triaged bug reports over the wall at stressed-out
> > > xfs developers isn't particularly helpful.
> > > 
> > > There was also a very specific concern raised in that discussion:
> > > 
> > > > IOWs, the bug report is deficient and not complete, and so I'm
> > > > forced to spend unnecessary time trying to work out how to extract
> > > > the filesystem image from a weird syzkaller report that is basically
> > > > just a bunch of undocumented blobs in a github tree.
> > > 
> > > but here we are again, with another undocumented blob in a github tree, and
> > > no meaningful attempt at triage.
> > > 
> > > Syzbot at least is now providing filesystem images[1], which relieves some
> > > of the burden on the filesystem developers you're expecting to fix these
> > > bugs.
> > > 
> > > Perhaps before you send the /next/ filesystem-related syzkaller report, you
> > > can at least work out how to provide a standard filesystem image as part of
> > > the reproducer, one that can be examined with normal filesystem development
> > > and debugging tools?
> > > 
> >   There is a standard filesystem image after
> > 
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > image is named as centos8_3.img, and will boot by start3.sh.
> 
> No. That is not the filesystem image that is being asked for. The
> syzkaller reproducer (i.e. what you call repro.c) contructs a
> filesystem image in it's own memory which it then mounts and runs
> the test operations on.  That's the filesystem image that we need
> extracted into a separate image file because that's the one that is
> corrupted and we need to look at when triaging these issues.
> Google's syzbot does this now, so your syzkaller bot should also be
> able to do it.
> 
> Please go and talk to the syzkaller authors to find out how they
> extract filesystem images from the reproducer, and any other
> information they've also been asked to provide for triage
> purposes.
> 
  Thanks Dave Chinner's patient suggestion!
  Thanks syzkaller maintainer Aleksandr Nogikh's guidance!
  I put the generated filesystem image file0.gz for mounting in link:
https://github.com/xupengfe/syzkaller_logs/raw/main/230524_140757___cleanup_mnt/file0.gz
  And could "gunzip file0.gz" to get file0.

  Thanks!
  BR.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
