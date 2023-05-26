Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04A71205F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbjEZGmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbjEZGmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 02:42:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD812F;
        Thu, 25 May 2023 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685083352; x=1716619352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xU6hjEkjnnsuwJ7VSw8pAbiBtaqxJaGFVk60PVQoHp0=;
  b=BXDUZWP7mcNaSZg7qB6Q8UTRIp+ssXjQgB4rDKqI0VPVaQTS6WA9/sdp
   v1pozcNiSC5RJuioMHL9w9CzpUm7HtU6V9CjGE97VrYNeiMHzBLpIYFDs
   UvapzDjeH4XfooPiGROSTjnIti8DdfGY0UEL1EM/iWI8mh+H2YqWnpKaS
   4ZUZpnGK5YooOxmvYMmyYHp5Qnw8ekt/xm87JV83HQ+a9p6IcH3qfUMFS
   vFlVuUum0PlztRasli/JWP7+0iBiq/MiaKrFpBX3FOQzCEwo5su5zbpuJ
   w0yIEbQ/YDMAnbxuguaer4PtwtqwIhKIJ19DT7y+o7MqfEFlRldfACaXX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="357384932"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="357384932"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 23:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="879442529"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="879442529"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2023 23:42:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 23:42:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 23:42:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 23:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKcxG5FsZ46+ZYw1TAZjTjzWtrEaCvUQtEJKfX+ETAhIfmVqlxdbPDEhbA/ljrb1OGstjSftz1sSJmKIfbE9fpu4IwkjvuWkwsyfUkME7mjT/rvF3Fu9thS1DvrzAi8I4gd6RMyUah1JBRz5OKGV/Lvg6BkPMmd64zgTEzdfHtpa32xdR3bk/NfD0+Edl0WvBorBT+Tc0+g8sj1q6JRHUsIMiNbUFhxqyv7EzyEudrtzKstaqE1yVmyEYUhGNw01PtQcfwgGNtSfV7wOuKoQfWTf+vFFu2zKMUJSkuLslZT4mHfJ6w0beeD/zGWf5wkn80cKCdaw2M61zS2cWrpKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Snkn5cvKsyUvKIWArh7f+tMyw35tdutMv3SK6gIDOE=;
 b=kLxlvLB/O7l9Qk0JYVuwMUluaQRA6K1qM0q3D8AhyT+8HgZnpAFNKqVOvSUuvOiRe6HMr1IAQJ+uEADoUgdTIjl2jNFEi2iQnAAdfKmUGj+tVk/cLCl/q+2eOcNVZimFj9qAf9yYSOetG1xw15J8RKni/LT4dCw+CXD3tchd3r7yrwakRWLTKmcZidGWBv1A2krJ/YogotN7F+ONKpBl+vOt8DO6irQCK0fjy+VCfjGqUwWlt1D3VWEqH4Yis9AHZXIq/xu7Z7TQejrbA5YSyaNbYhkoVaDfgqwDTnNeUVKralRZpDtztzoLj9xsB1kRhml6kLU1oU41uswklw5brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW3PR11MB4636.namprd11.prod.outlook.com (2603:10b6:303:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 06:42:28 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 06:42:28 +0000
Date:   Fri, 26 May 2023 14:43:58 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>, <dchinner@redhat.com>,
        <djwong@kernel.org>, <heng.su@intel.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <lkp@intel.com>, Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <ZHBVLki6gYRLA/On@xpf.sh.intel.com>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
 <ZG785SwJtvR4pO/6@dread.disaster.area>
 <20230525175542.GB821358@mit.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230525175542.GB821358@mit.edu>
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW3PR11MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e44ebcd-e803-4b37-21d4-08db5db45f7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTXgada16fdphibOiHytJzYiwm1cup7vfnbCW5DmtPVj9nqTa3wzGfDSmaHzVKh+aT5TAPh7jIog1oBuzkPugXT3k8hq9URXt2/QfRn4FFFAggXbDlSCTeXTrZq9v6Z9OmNzPvq6VidnhypmxsDv9OQGhOn/bcgPWvYLJMh9UjMX6HD6c9OwKu06Q3y9WoSsd9xDYbS1zyBJjpWdCrFa9he55G0Jabym/E9r6LQQx//liC6+YdotH6cqe8VohJqlbWf9CDSzA0uY8oTJZTs9bzjFEZeX36EiDuC2YbPSGuWeYLdevxJJ2kLzMuPwHAbnemEgCdtUm/Po7CE/itVsX3pp3WNcKfeF9yf/98nrZERPAhjs1Qb6rIucZvhQV+Wb0yt2+Go6VPfEAGFHtQY/ritoLMAy7NBPLFxyEy3+fikLmHZvUAr6q3AKXFq+U9pzyBgZcc+rrJXAkkPAno4DUbK7vlScD5QTXCsHVx5IQy3XVp8lGMWb5TTfGm4SAGJLLG0Mdw2i34uqfSj/rXDI2ysjA6g7C50HWwmkmMQh8GG9lAtUG+XkTjYRJ0XHPZQjlsdTNm/O5nmVrjo5AlGr60DE45hz+W8KiM0O/PoCRFlOK7IbrGzmedPIrkjao52r/wRKIkn5X1IYpTct9zmfHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(44832011)(316002)(53546011)(6512007)(26005)(6506007)(82960400001)(38100700002)(66476007)(4326008)(6916009)(66946007)(66556008)(6486002)(8676002)(8936002)(966005)(5660300002)(6666004)(41300700001)(83380400001)(86362001)(478600001)(54906003)(186003)(2906002)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hxq1EG3KlbUGO6ppsL33hpxssaEILkYCowU45V0Ib0sLkiBU0rkfbprzcN7M?=
 =?us-ascii?Q?NBQR4SGIQp8kWLr8cUooItn9V3CVkXf8HKAQ9lwd4ipc5qcfeDuZHmFuty71?=
 =?us-ascii?Q?cvN12hqm0hhstiiEgpCVORoFZj7Dz20bsX00KEhR9OcmNEXYRoHwLKq+7qjD?=
 =?us-ascii?Q?tmB2YEcFgeX63zijRZQWvxwtvohrj2siFuSuFb8kzj1i0FWNVGpYGc0yHEZp?=
 =?us-ascii?Q?mRoO54TgzulNEzwCP0QOAb9UWTRrvxuEFD2OTLFoS7HEVHdRLN+54KOvmnJf?=
 =?us-ascii?Q?77OSvlyfn2mmLHb7oQRCs86tQGlQb1sZFsWtknCoNhFeIDjdQSOA90GVVLFk?=
 =?us-ascii?Q?Iy6j73mso2S/g47TE++4j2f5/++fUUJfRrirezN/Upe2ObT793WXvx7dOslx?=
 =?us-ascii?Q?sBIeCw4Scs3mXBtLF8h4OeZU5Zs8TUvdHIR9DHAzgModkJNWhLDCtp1JTTJR?=
 =?us-ascii?Q?6kRotAc3fq0QCq0e9lOk+stkntWxFfY9n8kSsBTO+4pQvO9Ak9r6wA7kvaiD?=
 =?us-ascii?Q?vFYLqimgVoI8rU8qDWmH4UjVAWtjz5uB22kKLG73GZeNak7gNoMuuv+ZQCxF?=
 =?us-ascii?Q?XyZDrBPY9XB8WnobybFC0YGFe3ATl+SKDiL6BiUl6wPbEiZJXx7ybK2DnvkL?=
 =?us-ascii?Q?vQtLBefNlKm/mBoYShultIczwblbWFTEHVBQnIUF67XcmKr747MjbOc++2yX?=
 =?us-ascii?Q?zoKXh51B625bQHyTdOR8pgO030/pj43e6vGtwnjktyL6NSWtYPwNtUbxDOrA?=
 =?us-ascii?Q?1P9Dw9ZLbzsG/T7GSFw2Kbccfv874IC9XQsVRsAG1rFKUpaAJ+9pO3hRc7nB?=
 =?us-ascii?Q?jz8pypZSCr5oymSZj4Xr1GrtqIKKJyeMW7iYoU9GYdjjE/SSKfr7B/6QxjaR?=
 =?us-ascii?Q?SV5EnLqD20DZUcdKyhH+B2fLP69ugIwiaZsMj07vjgNAnFc1Cx+Pyl8gY6d6?=
 =?us-ascii?Q?ON+/dY1xYY/B61FHizJlDjSC/bUMPhtkCfoHTbMeFxxpFOnMcniJ6p6vHa76?=
 =?us-ascii?Q?By2diwsXwyd42oizB4UF6/YRFGy4sAFG7S01LyinUiKd+788D6kw0lAkXwaN?=
 =?us-ascii?Q?zO2gJyGVTQQMBmjR0oEVhSpd/Aoviu6eVUfezm+YKoVhOGmlyhQ5aVKzKhdX?=
 =?us-ascii?Q?kZ8yf2BC7F+o/VaJYRUaoWHpoY792JHrvJ/jOkwpZ0PRD7xBhb1AVVUzhH1T?=
 =?us-ascii?Q?Nfs92sfOA/flCHeoFjfC4S2UozDBZU044O+zpSgQ988NZobWytJJVwfWNbLi?=
 =?us-ascii?Q?NIR7FS7phEohYyJm50yrFC36b7wXiMI/HGsguY8iV72Sut+YRbBbSURx1Dyx?=
 =?us-ascii?Q?9eBhgufwDCPyJPkiSoUAFw2jlkA/cMuFPyotLOAMByvnEFMuHc19Ur9N/gVj?=
 =?us-ascii?Q?wEsWtBJu4F0WBfN2ncARDPGdURbn705v6ES3NGUN1YnShtT8m3ktbXsEcbDx?=
 =?us-ascii?Q?4aVFa7D+ScWQIyziuqANNZLxanaWbrhYQhlbkVcuJswpJPOrVjEkdoZwF0Kk?=
 =?us-ascii?Q?pWMN3kTomlEPeFOzUAfJjrQiKFCFmIr+8Z1AcYg7EKZAHTaWRnfQbOqItptN?=
 =?us-ascii?Q?dpNxcG7BK6v4uDQpeYlO7r5DlJeNhvsCIohpQSdz9yJ3AF4D3JWtoZeGz6yA?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44ebcd-e803-4b37-21d4-08db5db45f7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 06:42:28.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfpfbFc1I/6xknHyyz2arwqyWbq73T4Chg2cDYyIPvsiVDYRXa6Oax2ICTEvKc5xHAT6kbpLG0SDNQYLBcOG5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On 2023-05-25 at 13:55:42 -0400, Theodore Ts'o wrote:
> On Thu, May 25, 2023 at 04:15:01PM +1000, Dave Chinner wrote:
> > Google's syzbot does this now, so your syzkaller bot should also be
> > able to do it....
> >
> > Please go and talk to the syzkaller authors to find out how they
> > extract filesystem images from the reproducer, and any other
> > information they've also been asked to provide for triage
> > purposes.
> 
> Pengfei,
> 
> What is it that your syzkaller instance doing that Google's upstream
> syzkaller instance is not doing?  Google's syzkaller's team is been
> very responsive at improving syzkaller's Web UI, including making it
> easy to get artifacts from the syzkaller instance, requesting that
> their bot to test a particular git tree or patch (since sometimes
> reproducer doesn't easily reproduce on KVM, but easily reproduces in
> their Google Cloud VM environment).
> 
> So if there is some unique feature which you've added to your syzbot
> instances, maybe you can contribute that change upstream, so that
> everyone can benefit?  From an upstream developer's perspective, it
> also means that I can very easily take a look at the currently active
> syzbot reports for a particular subsystem --- for example:
> 
>        https://syzkaller.appspot.com/upstream/s/ext4
> 
> ... and I can see how often a particular syzbot issue reproduces, and
> it makes it easier for me to prioritize which syzbot report I should
> work on next.  If there is a discussion on a particular report, I can
> get a link to that discussion on lore.kernel.org; and once a patch has
> been submitted, there is an indication on the dashboard that there is
> a PATCH associated with that particular report.
> 
> For example, take a look at this report:
> 
> 	https://syzkaller.appspot.com/bug?extid=e44749b6ba4d0434cd47
> 
> ... and look at the contents under the Discussion section; and then
> open up the "Last patch testing requests" collapsible section.
> 
> These are some of the reasons why using Google's instance of syzkaller
> is a huge value add --- and quite frankly, it means that I will
> prioritize looking at syzkaller reports on the syzkaller.appspot.com
> dashboard, where I can easily prioritize which reports are most useful
> for me to look at next, over those that you and others might forward
> from some company's private syzkaller instance.  It's just far more
> productive for me as an upstream maintainer.
> 
> Bottom line, having various companies run their own private instances
> of syzkaller is much less useful for the upstream community.  If Intel
> feels that it's useful to run their own instance, maybe there's some
> way you can work with Google syzkaller team so you don't have to do
> that?
> 
> Are there some improvements to the syzkaller code base Intel would be
> willing to contribute to the upstream syzkaller code base at
> https://github.com/google/syzkaller?  Or is there some other reason
> why Intel is running its own syzkaller instance?
> 
  Yes, I agree that we should work together to improve Syzkaller in case any
  coverage/feature is not supported by Syzkaller to ensure others can benefit
  from it. For example, I added IOMMUFD syscall description and user space
  SHSTK(shadow stack) tests for x86 platforms in syzkaller.

  Syzkaller is an unsupervised coverage-guided kernel fuzzer.
  According to my observation, some issues are platform dependent.
  Intel specific platforms could find some other different mainline kernel
  bugs by syzkaller tool which syzbot(https://syzkaller.appspot.com/upstream)
  doesn't find.
  And there are some special configurations like IOMMUFD, user space SHSTK
  (shadow stack) Intel cares about, for SHSTK, it needs HW support and qemu
  support also, we could cover some special situation to find more bugs.
  For example IOMMU related issues:
  Report: https://lore.kernel.org/all/ZBE1k040xAhIuTmq@xpf.sh.intel.com/
  Patch and veirfied: https://lore.kernel.org/linux-iommu/ZCfN0MSBxfYTm7kI@xpf.sh.intel.com/

  In order to solve these bugs, it makes sense for us to report the issues to
  Linux kernel community if no one has already reported them.

  Thanks!
  BR.

> Cheers,
> 
> 						- Ted
