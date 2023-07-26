Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76B7628E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 04:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGZCza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 22:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGZCz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:55:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF879E64
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690340127; x=1721876127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sVdrwQ9DtUdaNPPIkkvbRhej9YuTqurvOttLb7LMh1w=;
  b=IqK7yr4FxdzN6d5UpHjSatMuEiNQpCFpfBEVrYpEf59QSF+sfZPpWcri
   8BuMZzaEDVC/vPTHj4sZf3PzYaHzGstXcbAPZ8Jb/q78MYGFKVje0S9Cx
   +amw4t+QjQ/pCO8FtGvLWFZos90uQLCtFmPRyBfTgeTRNdQbHwJ7cb1+l
   wg8WbHNdaQnCF9KDqCFPoPM2hmU/mkdy/LwOdJ327xXafEM8zuZZdKArE
   H3X/1ER4zSTV92IyZo0Dk6HlGhZcFbtqfOnk6g04BeI7vFQPDD66DaQgb
   yTDmOFw0i+ne5DXtTCrEaJrhcYkUMocSq2bXw6HPnvUL/9Wq1g6/cZKsH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352800679"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352800679"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 19:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="900222094"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="900222094"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2023 19:55:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 19:55:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 19:55:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 19:55:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 19:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kup+5zBNha5nhhoLp4L/GaDWhxb1wFxUwt+7BAL9OXxQEH227+RFI6nEc7psuUwYlhb3LpQBJhp7qE6Xq//qtjlY/tJDb3rEb1mngpQ8TrpgeODgM4HW4ZsD5ys0ZVJ1fb+ojHBzeQYY/Ze2+2vet8vyfpSz52aksv79Dm6XU2a1iAEymf+NPy7/7ejdT0wY3vqus7S3g2Mlw2+sNmWokbYnHveAxH68ojl0ITf7yiqPekhTcSYfGV9zsaPs59lcbxdtaoo/qvKQLyn//7/yisRMl16ZoxdF9HI5jD9HY53UQzA54jM50r3eSrplUUrbaUbgpytsS1RpxtEqVJ8+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNG6jyyunELJa/t0aTxp0U0r5gALq5Gp9gJ1CWw2XFU=;
 b=UxKdL9fhxbxyyT+FViWim+S68O2dw5e2OC6PBkG0JZHmas+lS04OEH+zr89m29lQHTXmdgm0AjfIRXFisxlbxHwbjoxR+onpljG72L6lGogO8AE5kz5u5ou6/r/ahuLqLi0f4Ufu6jtLUXKaTELca0q/wv4O2oLHRB7PqtQ3zTMaC/xNUxSyJcUgWqJs4f97uCGJdFdRhgp9AWPbO+LD/8BIyWClIGK56Owh8Eu/8lb4goxE2ycizWDE8c1KWoZsp5sMZ7Kj8rPQd8kKEiDjo4O4X13TPzA+EGSsAyIjyIk+WOdo/y28S4uu0Tebml1fQQkuOnflrxR1MJAC0wDQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:55:21 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::aa71:69cd:a453:98ef]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::aa71:69cd:a453:98ef%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:55:20 +0000
Date:   Wed, 26 Jul 2023 10:55:08 +0800
From:   Philip Li <philip.li@intel.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        Chuck Lever <cel@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Message-ID: <ZMCLDMRsItQ3ScjW@rli9-mobl>
References: <202307171436.29248fcf-oliver.sang@intel.com>
 <3B736492-9332-40C9-A916-DA6EE1A425B9@oracle.com>
 <53E23038-3904-400F-97E1-0BAFAD510D2D@oracle.com>
 <ZL/wMvYSjRU0L6Cp@rli9-mobl>
 <20230725-geraubt-international-910f0d37175b@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230725-geraubt-international-910f0d37175b@brauner>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: de679f89-f99e-4cd8-3638-08db8d83bfde
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1TgNLRxkQJp/T6WYw7EUwU632JX9AJ/UMOC3K8mvt6kvBeBLVEIZzEBSAK0OLcPYqUtUzCXXbSD+Tf6+ko6epnf74d2shfSgs4vPElnLonzBJXaK7msnByhJ0N1Qe2oDiTRP/TWRc1f0o623gb6gJlC1/PkzFnZzmFExzTkZnF2sG1J3FHlVRuuVNc2nliVuB38Ghwi0bM1KYAoy6Bdjcehh2IPTGM9u0V6SghRL/BNTsZIvvcny/WrrxqPbSVgue5+1eoRnwTVKbl5KiIDJfASaKnP855yjspvd1T338Kk+Et7FfTdGSNrwqUsCZjU36C3C65NL5yzklcmBhuF5Hxteo1oubkD+DOlRufOI6c4oxA+NINfU/nIN68ONHJdQiL8IwfIdpspuZaLamFu9s17DQC3i8gvqGWx8u6sSPV12FunVEMNntyjSXTYioxsyMjn2yjfQrpADwHXif0jQj/TF85E07lHGRNmk5xDgydg1y01gMJtPe/zdj2jSUtbTgi8PBMrgQxg4/ZCvXwJ+OdaiVzvT2btZYETjYTsoWjEOpgGEDyPmKIOD6iksxpQiZ1sjHs4cTB/MchCgLJk8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(66899021)(186003)(26005)(6506007)(2906002)(86362001)(82960400001)(8676002)(7416002)(8936002)(6916009)(33716001)(6512007)(966005)(54906003)(478600001)(6666004)(6486002)(9686003)(5660300002)(38100700002)(4326008)(66556008)(66476007)(66946007)(316002)(44832011)(41300700001)(53546011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Whl/6m5fUSzaFq/bzgqs5J3QdeWUSS98esvSHpks2Zm4WosZSmXwcjrssc7K?=
 =?us-ascii?Q?5LcY/LlNBW0eHOhVDNZoLw2IAOcpl1ka8NK7RHadf9mwEnQ2lbJ0jZ8cpglP?=
 =?us-ascii?Q?oTEv1dq35BS2b/beZIfckFkq33BEkZcsyYOKLLeIZTafsVLMObCMXYfn8KgF?=
 =?us-ascii?Q?ROBiocWvP2TjT894VuxNYgcI/D+kdcoToxETumaX30JpEOiLwz3szp79J88r?=
 =?us-ascii?Q?iXbc8Fz3DqGVF3CvxCbdfQfDZCeFbzSh4yxDleRsgJ5NSEmPPf+2MFZ/Anbr?=
 =?us-ascii?Q?s5nUXaOZSu2vmS9jcVHUBdH+UfuSSZ/QG8oE2E2cd19yYE9gC8lRL/x8/+lf?=
 =?us-ascii?Q?Is00IfblQq6FB8JWQ+LjvU7LJ1Kj0ClHyfM+/+OV7pzjkVtpeVoE0Hr1SAqo?=
 =?us-ascii?Q?buEtqzMZw7IvtGymNiXXi8n/VRBy/m8vcPfU/Y8ET3OJqHBJY0UapgVasT/s?=
 =?us-ascii?Q?gxbc4UfpA6NVKeRPAcY7YIbFeTssMH2cKG0P0H6uAOErKCtLdVJ1eKGnE53I?=
 =?us-ascii?Q?GIjrcm8rcFPdshrGYgDt4c3EDbIXDHAtHPCSE6wYKY6aRY4kQkM7DQVqKwOR?=
 =?us-ascii?Q?5k8ChWr4nd4tNKfZNgyk7XpxGYXOznpHBefnp5iFg0pfx/DrhXPR5uBeFE6q?=
 =?us-ascii?Q?eBd0nW8Qzjjgrqeevri76jMTY1IfGCd4Lolc4SYjfzllsCkvGk7v0qXyenVa?=
 =?us-ascii?Q?/nZ2hRRxXZoaRPTNR/MkLcZgkesuZH+zZSXpNQ9kwfdjJliIrpljVwdOBmA+?=
 =?us-ascii?Q?FeEED5PlPo2YtVK1xCGpK51Z61Q+5RByYbHHXNXri0CRTSJ2UIk7oSUKm8Cb?=
 =?us-ascii?Q?ztEzG0De0bLFqQ0k9AZja5br4F1X5X3XngQK1oliiHwGlDICxLm6TxqVqvl1?=
 =?us-ascii?Q?h8JGjZPmRIjk5cUVjlj1Dp98M0UyKiVH35eDDGoFrWf3O9wcOtcVnZKy+Q9i?=
 =?us-ascii?Q?6W5CnHzCLtKOTyXJy3danLJ3Xl/+y4BiJIVtGW7qrtb7NGusbVP68nKJFMGI?=
 =?us-ascii?Q?4cGahYVzKjZDXKCF6t+rNE23EeyRnpAZistreHb0pipubF0+Uzn1vv8j5pMq?=
 =?us-ascii?Q?ntLpe1drVIiPEGXrE2FtFtucbl7otKIS2l2wwl+rKoui2PxkTMmOkS3XOjYc?=
 =?us-ascii?Q?q+S0G25d9kEC6QyvREEvPjj72ANo3ZJmD7i4NDoVaRMQHnpaG3aeadV8ul5D?=
 =?us-ascii?Q?UBrm+H/CYQOvxqOiuw9lua13Ds7QOawM+XNyI9t4DRQrQbl2E0nh9fzN54E3?=
 =?us-ascii?Q?MF0lyFNUutMGkGK1/yDhurhA09X95EiUdfh3ivft9iphk3CCl6jwluOMO9aO?=
 =?us-ascii?Q?IqPlgtVxEd9EuKwyZ9IIhfG5k0pRsSu/x8eUl6cMDAeag4FnpeEJeZa0yXYm?=
 =?us-ascii?Q?ft3RFiA6r3KsY9opiq9oxIL2rLZ4Jw7ccxQ5N0HLAFvRyHUeYc3Du6m226vJ?=
 =?us-ascii?Q?aVCcBELgpMhNONTQn5zEzq6yB3OQjj5oZ+XYUD9Eh+tmHVx6xy4j2rAj/L+y?=
 =?us-ascii?Q?kLWmlg3ki2A0f9HBQ0V5dadXjAcuX3fp9BxULEi1S7s5a4ZIUXFaxM6WXlX4?=
 =?us-ascii?Q?5G1LEUgz4lu5xSEcOf5U92SzUNCT4aSVLbr2fuuS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de679f89-f99e-4cd8-3638-08db8d83bfde
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 02:55:20.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+8KizeIL8Bm0wrXoKQKPpvd3XTZDXWDx76vlPmKhRBonMKBzqLSGzb5ow4pKEBLuTUdGJvgG+nbMb8IZiU1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 05:59:22PM +0200, Christian Brauner wrote:
> On Tue, Jul 25, 2023 at 11:54:26PM +0800, Philip Li wrote:
> > On Tue, Jul 25, 2023 at 03:12:22PM +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Jul 22, 2023, at 4:33 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > > > 
> > > > 
> > > > 
> > > >> On Jul 17, 2023, at 2:46 AM, kernel test robot <oliver.sang@intel.com> wrote:
> > > >> 
> > > >> 
> > > >> hi, Chuck Lever,
> > > >> 
> > > >> we reported a 3.0% improvement of stress-ng.handle.ops_per_sec for this commit
> > > >> on
> > > >> https://lore.kernel.org/oe-lkp/202307132153.a52cdb2d-oliver.sang@intel.com/
> > > >> 
> > > >> but now we noticed a regression, detail as below, FYI
> > > >> 
> > > >> Hello,
> > > >> 
> > > >> kernel test robot noticed a -15.5% regression of will-it-scale.per_thread_ops on:
> > > >> 
> > > >> 
> > > >> commit: a1a690e009744e4526526b2f838beec5ef9233cc ("[PATCH v7 3/3] shmem: stable directory offsets")
> > > >> url: https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/libfs-Add-directory-operations-for-stable-offsets/20230701-014925
> > > >> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> > > >> patch link: https://lore.kernel.org/all/168814734331.530310.3911190551060453102.stgit@manet.1015granger.net/
> > > >> patch subject: [PATCH v7 3/3] shmem: stable directory offsets
> > > >> 
> > > >> testcase: will-it-scale
> > > >> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > > >> parameters:
> > > >> 
> > > >> nr_task: 16
> > > >> mode: thread
> > > >> test: unlink2
> > > >> cpufreq_governor: performance
> > > >> 
> > > >> 
> > > >> In addition to that, the commit also has significant impact on the following tests:
> > > >> 
> > > >> +------------------+-------------------------------------------------------------------------------------------------+
> > > >> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -40.0% regression                                   |
> > > >> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
> > > >> | test parameters  | cpufreq_governor=performance                                                                    |
> > > >> |                  | mode=thread                                                                                     |
> > > >> |                  | nr_task=16                                                                                      |
> > > >> |                  | test=unlink2                                                                                    |
> > > >> +------------------+-------------------------------------------------------------------------------------------------+
> > > >> | testcase: change | stress-ng: stress-ng.handle.ops_per_sec 3.0% improvement                                        |
> > > >> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory        |
> > > >> | test parameters  | class=filesystem                                                                                |
> > > >> |                  | cpufreq_governor=performance                                                                    |
> > > >> |                  | disk=1SSD                                                                                       |
> > > >> |                  | fs=ext4                                                                                         |
> > > >> |                  | nr_threads=10%                                                                                  |
> > > >> |                  | test=handle                                                                                     |
> > > >> |                  | testtime=60s                                                                                    |
> > > >> +------------------+-------------------------------------------------------------------------------------------------+
> > > >> 
> > > >> 
> > > >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > >> the same patch/commit), kindly add following tags
> > > >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > >> | Closes: https://lore.kernel.org/oe-lkp/202307171436.29248fcf-oliver.sang@intel.com
> > > >> 
> > > >> 
> > > >> Details are as below:
> > > >> -------------------------------------------------------------------------------------------------->
> > > >> 
> > > >> 
> > > >> To reproduce:
> > > >> 
> > > >>       git clone https://github.com/intel/lkp-tests.git
> > > >>       cd lkp-tests
> > > >>       sudo bin/lkp install job.yaml           # job file is attached in this email
> > > 
> > > Has anyone from the lkp or ltp teams had a chance to look at this?
> > > I'm stuck without this reproducer.
> > 
> > Sorry about this that fedora is not fully supported now [1]. A possible way
> > is to run the test inside docker [2]. But we haven't fully tested the
> > reproduce steps in docker yet, which is in our TODO list. Also a concern is
> > that docker environment probably can't reproduce the performance regression.
> > 
> > For now, not sure whether it is convenient for you to have a ubuntu or debian
> > environment to give a try? Another alternative is if you have new patch, we
> > can assist to verify it on our machines.
> 
> So while we have your attention here. I've asked this a while ago in
> another mail: It would be really really helpful if there was a way for
> us to ask/trigger a perf test run for specific branches/patches we
> suspect of being performance sensitive.
> 
> It's a bit of a shame that we have no simple way of submitting a custom
> job and get performance results reported. I know that resources for this
> are probably scarce but some way to at least request it would be really
> really nice.

Apologize for this limitation. We have some mid-term TODO list to allow
the verification of reported issue (start from build report) for fix patch.

We will consider runtime side as well per this input to provide a better
experience. And we can start with a controlled scope like to queue the
test in the report, so test suite/parameters/platform is in a manageable
manner.

Thanks for the input.

