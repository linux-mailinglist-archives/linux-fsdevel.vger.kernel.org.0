Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4D70D888
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjEWJMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 05:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjEWJMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 05:12:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B75102;
        Tue, 23 May 2023 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684833155; x=1716369155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+wO8AnPNXhhLQkFr4ndhU7ZA+iMdcGdKxqAvI+YYcjI=;
  b=TdfTgga86tPP/4mbrQTY1bK2NLftJAiHhy3qHuDd8TjIokhH9WIux0Vo
   CfYovsXJi2drlQSVi7SbQTdNAvLTX2NIjy/oYdJFpM8J6uzph26oJ7JYX
   32Ktnl/4l+cSmgEECGdVeIKfi23uWFkLZfprdaYjWNz7PacC2GYAxwPhQ
   egVl4hb93z6WPZHRTdI4vysosZKJPaDSMnOELpjaWC9p23pSPgxENHnVF
   XhRneZP/iw988YnEUCngihawabELh35j4DzkuVB+tRpf1GkaxDH+t5i+C
   BhWmO3tQK4AynxkKGl18EOemt33POWxlVq6XAtT9Edza0nRUe4ZDOYbde
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="352031304"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="352031304"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703864419"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="703864419"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2023 02:12:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 02:12:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 02:12:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 02:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGwIQjVPebZ7YOVSmMsqK41OEzCyVewy+eNbmoCL0y6ECuvD4Dltt65+sce8SEvnMXSEMYn/whrNHD9TP2R9ZseNKNg8RyIOH8Kux4+HMBFuXGpp5NJDknu4rvAkjdcIZhBCGtX9FBYhvP/fBqYVwqZhdPyF1oJjrIY09bOVQYLBs8+JwRo2C5QoqJOHwi18hvlzqFvyur0PDYgfsG1eGv3She6bqbRZTSJ8xocDPCBWQl8fIeYXj1QnW/eS4d+8Da69PRnki1CgO9fQN9Zcbna5fGg1BYYbMClDomvF24C8bfMy4bBDgcBb7yBYkXaa4UQPkRHVrDQbOdIyh1ZXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PssOwVXOdPBV6YUu6oFe+RCPg4EuN3ZQNsV/EEgVHz4=;
 b=T2i3coLPVFZrMRHnob+UM6YnjNSD+vozchjzzl8vGBac6xcbLzrruBQMehU18pb/vzbBuV73j6/agJbENRfyrBiM2tVD2ToRsiUafjrrO1/EU5AmK1vsoJbCdSVMbCP1cAqYighyKbi7up6gb8C5/lPRFAASFw+uyUepYuFAeAG4jfDtW2bAsbinIjyxAh1d7QF7QKZJU23EPK5AkepY/5w4DHEuFtvdAsD1wXS8TwY3D3mdpZl9Jk3+Ci1mB45m4crwAzOdRsiGjtUbHkk+ZZ4AE9jHAqSyW8SmuDwZrbl8RYubqs8jMmsjOfhoH4AfTC87829euokOmQMQX5Ubjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BN9PR11MB5482.namprd11.prod.outlook.com (2603:10b6:408:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 09:12:32 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 09:12:31 +0000
Date:   Tue, 23 May 2023 17:14:24 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heng.su@intel.com>, <dchinner@redhat.com>, <lkp@intel.com>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <ZGyD8CNObpTbEeGQ@xpf.sh.intel.com>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
 <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
 <20230523000029.GB3187780@google.com>
 <ZGxry4yMn+DKCWcJ@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZGxry4yMn+DKCWcJ@dread.disaster.area>
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BN9PR11MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e004a19-45bd-4a36-ca7d-08db5b6dd6db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9GaVQJ9R6ZYCcpoCnUGeCEHZgXSu7SzRRLlLOVWWkUnWqbWGzrGD12UkjXYGNAeLxh0RNyjKv/pPyGdsBFVUrtoDinwvuFCGv7hsVksB2S14cYqbGpStziUl+cUY8f65k72AtNSEoCkVVGktKQasU6NZtkqcYABhPKD3/0DskYInM5D8xdGw9VNoyWfkHV2JVphHWoqj94zPPUaqelSZK+oB0OT4DEWi5eYFRsr2s5dNhuizffw+t6tU1cK02Pu7pQEVN0iBjbnULq6taMrd11GsPplzD0z/ANEMkYnXGc92WVFTYDgAVa805kF5Pqc3NFer5VCaHq8n1GdD+p6+T04GB75CvpDv08DwdEcRZJCQHRq6ElAIOPOKr703UhchHhF5MQsuOo+RT1UYcCTsWx3QE3eQ4ZPbVmFzPkIBUH05tijIwEOuF8aoB3w1haAnPih0ixBOwT3/gIhBRC5IWRioUzCB30YmiPLlFXMkk1QRCkqu+OprlDUd2trsJ0LgpgjfrQtmz7CtoDYm0wmvBTdrLFnGxgrdWKgZkgLb45PP1dtJ3cO+1fWyYImwlPq0CK2ZoCyBCcN2jLY54St0IfMOhCbBj0zkExeA92M4rFLE/78MOCImyx9dr5n7GHiCfwGJpppPS4u7OIb78jzOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(53546011)(83380400001)(82960400001)(6512007)(26005)(38100700002)(6506007)(44832011)(186003)(2906002)(478600001)(966005)(316002)(66556008)(66946007)(6916009)(4326008)(66476007)(6666004)(6486002)(86362001)(41300700001)(66899021)(5660300002)(8676002)(8936002)(54906003)(31884004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a08otTI9284lKUNvdD2UemdFZzHdbxOr44BYxuy9Bi/GP8RpyY0s6Ich4j9I?=
 =?us-ascii?Q?pFKLZ9YBr+CXV2PNlVXTsx4Z6zghpanQyGOTYXGxShK5svr/W7HspEiXSazn?=
 =?us-ascii?Q?2JEET6ez3BsZ9ilxwojM815DonEwbUgyYKKNX2/6vYslGauEpOGNYuuEgT/h?=
 =?us-ascii?Q?dyMCc5KAwZLSLHX+9VRD60IhWlHdNIqwms2IL+TwDcl/fMshCLxTeb8BwZaQ?=
 =?us-ascii?Q?AF8id2GCobALc+74pwi7HDHcwTYuOJqjiDJnEIInCTMaLSZN5LgjpawG9SjW?=
 =?us-ascii?Q?GXUPvOhhEeXN2vMJKew+/eagjjznqkNiXuIFrsSMe7+lknVdzXFlHpw/ZF36?=
 =?us-ascii?Q?BJrwcVtR5UQM7CtpIccaX20eE6WCcpjYO8xlxAkIN1gDPY2lyRQPkz5oruu4?=
 =?us-ascii?Q?LRRrOvL1/jaNNgJF7WiOfBPV+4elCKdxZhQFvfx6evVaHNe9MLq/9kv1kdTG?=
 =?us-ascii?Q?RZ0i/+Fx4EVXxSjRFD1rQrFP+qMaYnb0bEUhMkWv7xTOp9cJq/DEqe7yTSC1?=
 =?us-ascii?Q?Eitb2aLtdOiwM+g0u6HIxJSjZBsH9sxKPShNpLW6pMNHz0lntz/REcl+N8Dp?=
 =?us-ascii?Q?P/t8BnrgyaGR39xYOVh8d4byc2Z1nGCfDPtYSKpFbfWSo4KWdO6lBIAuKtn+?=
 =?us-ascii?Q?7nni7WQAxx2M4YEryipJgWTqvz16vU0awjHneld98hTssa4icLCJr+qA/GDY?=
 =?us-ascii?Q?5V5qtFRm+Ek1vzb10+zaUH74nIHdj2xuPEAQVhNX4ZHyRldB2mH+yMOZigmv?=
 =?us-ascii?Q?jb329iXMd0the/ofIz9PnRseNphlVJzrIXBMT8K3O8wYL8o7p6CeWU0jJ2mS?=
 =?us-ascii?Q?hjAGHMa1dc3NQEVIbIecfCh46ummlQNTfI+Zn4cJ0PuNK8wFe5tX4WLaReYS?=
 =?us-ascii?Q?T/6czAy94DGZm29zq/D5D97LDyfMePHppNvKAwokIWvtZwTUddrM5yYvVT/c?=
 =?us-ascii?Q?cw3/MRhFfotPJWdE/ZIBiDXzUdsgl+61ZqRPJfqx/WNok3J5RgVzLC6gDdon?=
 =?us-ascii?Q?CihqpZwe7B2wEiQWFmi9Zz391MA0AMIeE92sH6pzbR+A5tSBL7BtwVetZF1b?=
 =?us-ascii?Q?8/h9qZ2d3acJ8Wc4mouKIAP0phl8aPwVwAmQ0vCK4AiaTC4mwL9perrZljAD?=
 =?us-ascii?Q?Lgjb+inXc7oMeH3489v2jmPeOxwOhGy6fvvzK1Mfw/gY0d3hbc+D5jnbevZz?=
 =?us-ascii?Q?l4PJJBTxn0Gu29n+mx4TgONQvDHEYPLQyawd2VbJBTSYuXsN+bUZvP67vJ9c?=
 =?us-ascii?Q?Fh4qq5WIK+5vKlSoH4XRGNJND/BMyB7eCh2Qm03XANIklJk4zBsZ32wkWSRF?=
 =?us-ascii?Q?BptyLE/rQ3tk2N6Q9pWfCJyaRvHZRP2XSobOkYvXfoDzlQWvJnmmDVm4eA7C?=
 =?us-ascii?Q?JMs5WAEEfRXd1rlzdyaeW3TJhFE7X8s6+JxtgGZCx7e87hrtSXNrMkA3g0lS?=
 =?us-ascii?Q?kVPWd5sk1gfKIlaZw0CEQVwaHK6kAba6bGc9Zu080Xss/nNyFOhBxSHMPBNi?=
 =?us-ascii?Q?vsSRuvbcV6/p2BhEqs1pXC4L13G2ikmPAMB1l6ewKj/hjhSMti1nIFSjEyd0?=
 =?us-ascii?Q?t1MQ5A1YBVTXmRrB9Q/q+tgObsS9Cuqe6RCaRuvW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e004a19-45bd-4a36-ca7d-08db5b6dd6db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 09:12:31.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhQG2DOiQaOY+Xf/8BF1/WpqCbLv84QZJS//cakeKj2orby517vF245eMtUhO1gtCqjtolZypt26pifkj6wXeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5482
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

Hi Dave,

On 2023-05-23 at 17:31:23 +1000, Dave Chinner wrote:
> On Tue, May 23, 2023 at 12:00:29AM +0000, Eric Biggers wrote:
> > On Mon, May 22, 2023 at 09:05:25AM -0700, Darrick J. Wong wrote:
> > > On Mon, May 22, 2023 at 01:39:27PM +0700, Bagas Sanjaya wrote:
> > > > On Mon, May 22, 2023 at 10:07:28AM +0800, Pengfei Xu wrote:
> > > > > Hi Darrick,
> > > > > 
> > > > > Greeting!
> > > > > There is BUG: unable to handle kernel NULL pointer dereference in
> > > > > xfs_extent_free_diff_items in v6.4-rc3:
> > > > > 
> > > > > Above issue could be reproduced in v6.4-rc3 and v6.4-rc2 kernel in guest.
> > > > > 
> > > > > Bisected this issue between v6.4-rc2 and v5.11, found the problem commit is:
> > > > > "
> > > > > f6b384631e1e xfs: give xfs_extfree_intent its own perag reference
> > > > > "
> > > > > 
> > > > > report0, repro.stat and so on detailed info is link: https://github.com/xupengfe/syzkaller_logs/tree/main/230521_043336_xfs_extent_free_diff_items
> > > > > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.c
> > > > > Syzkaller reproduced prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.prog
> > > > > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/kconfig_origin
> > > > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/bisect_info.log
> > > > > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/v6.4-rc3_reproduce_dmesg.log
> > > > > 
> > > > > v6.4-rc3 reproduced info:
> > > 
> > > Diagnosis and patches welcomed.
> > > 
> > > Or are we doing the usual syzbot bullshit where you all assume that I'm
> > > going to do all the fucking work for you?
> > > 
> > 
> > It looks like Pengfei already took the time to manually bisect this issue to a
> > very recent commit authored by you.  Is that not helpful?
> 
> No. The bisect is completely meaningless.
> 
> The cause of the problem is going to be some piece of corrupted
> metadata has got through a verifier check or log recovery and has
> resulted in a perag lookup failing. The bisect landed on the commit
> where the perag dependency was introduced; whatever is letting
> unchecked corrupted metadata throught he verifiers has existed long
> before this recent change was made.
> 
> I've already spent two hours analysing this report - I've got to the
> point where I've isolated the transaction in the trace, I see the
> allocation being run as expected, I see all the right things
> happening, and then it goes splat after the allocation has committed
> and it starts processing defered extent free operations. Neither the
> code nor the trace actually tell me anything about the nature of the
> failure that has occurred.
> 
> At this point, I still don't know where the corrupted metadata is
> coming from. That's the next thing I need to look at, and then I
> realised that this bug report *doesn't include a pointer to the
> corrupted filesystem image that is being mounted*.
> 
> IOWs, the bug report is deficient and not complete, and so I'm
> forced to spend unnecessary time trying to work out how to extract
> the filesystem image from a weird syzkaller report that is basically
> just a bunch of undocumented blobs in a github tree.
> 
> This is the same sort of shit we've been having to deal rigth from
> teh start with syzkaller. It doesn't matter that syzbot might have
> improved it's reporting a bit these days, we still have to deal with
> this sort of poor reporting from all the private syzkaller bot crank
> handles that are being turned by people who know little more than
> how to turn a crank handle.
> 
> To make matters worse, this is a v4 filesystem which has known
> unfixable issues when handling corrupted filesystems in both log
> replay and in runtime detection of corruption. We've repeatedly told
> people running syzkaller (including Pengfei) to stop running it on
> v4 filesystems and only report bugs on V5 format filesystems. This
> is to avoid wasting time triaging these problems back down to v4
> specific format bugs that ican only be fixed by moving to the v5
> format.
> 
> .....
> 
> And now after 4 hours, I have found several corruptions in the on
> disk format that v5 filesystems will have caught and v4 filesystems
> will not.
> 
> The AGFL indexes in the AGF have been corrupted. They are within
> valid bounds, but first + last != count. On a V5 filesystem we catch
> this and trigger an AGFL reset that is done of the first allocation.
> v4 filesystems do not do this last - first = count validation at
> all.
> 
> Further, the AGFL has also been corrupted - it is full of null
> blocks. This is another problem that V5 filesystems can catch and
> report, but v4 filesystems don't because they don't have headers in
> the AGFL that enable verification.
> 
> Yes, there's definitely scope for further improvements in validation
> here, but the unhandled corruptions that I've found still don't
> explain how we got a null perag in the xefi created from a
> referenced perag that is causing the crash.
> 
> So, yeah, the bisect is completely useless, and I've got half a day
> into triage and I still don't have any clue what the corruption is
> that is causing the kernel to crash....
> 
> ----
> 
> Do you see the problem now, Eric?
> 
> Performing root-cause analysis of syzkaller based malicious
> filesystem corruption bugs is anything but simple. It takes hours to
> days just to work through triage of a single bug report, and we're
> getting a couple of these sorts of bug reported every week.
> 
> People who do nothing but turn the bot crank handle throw stuff like
> this over the wall at usi are easy to find. Bots and bot crank
> turners scale really easily. Engineers who can find and fix the
> problems, OTOH, don't.
> 
> And just to rub salt into the wounds, we now have people who turn
> crank handles on other bots to tell everyone else how important
> they think the problem is without having performed any triage at
> all. And then we're expected to make an untriaged bug report our
> highest priority and immediately spend hours of time to make sense
> of the steaming pile that has just been dumped on us.
> 
> Worse, we've had people who track regressions imply that if we don't
> prioritise fixing regressions ahead of anything else we might be
> working on, then we might not get new work merged until the
> regressions have been fixed. In my book, that's akin to extortion,
> and it might give you some insight to why Darrick reacted so
> vigorously to having an untriaged syzkaller bug tracked as a high
> visibility, must fix regression.
> 
> What we really need is more people who are capable to triaging bug
> reports like this instead of having lots of people cranking on bot
> handles and dumping untriaged bug reports on the maintainer.
> Further, if you aren't capable of triaging the bug report, then you
> aren't qualified to classify it as a "must fix" regression.
> 
> It's like people don't have any common sense or decency anymore:
> it's not very nice to classify a bug as a "must fix" regression
> without first having consulted the engineers responsible for that
> code. If you don't know what the cause of the bug is, then don't
> crank handles that cause people to have to address it immediately!
> 
> If nothing changes, then the ever increasing amount of bot cranking
> is going to burn us out completely. Nobody wins when that
> happens....
> 
  I did not do well in two points, which led to the problem of this useless
  bisect info:
  1. Should double check "V4 Filesystem" related issue carefully, and should
     give reason of problem.
  2. Double check the bisect bad and good dmesg info, this time actually
     "good(actually not good)" dmesg also contains "BUG" related
     dmesg, but it doesn't contain the keyword "xfs_extent_free_diff_items"
     dmesg info, and give the wrong bisect info.
     Sorry for inconvenience...

     For above 2 points, I will solve the above two problems thoroughly a.s.a.p.
     I won't report useless bisection information caused by the above 2 points.

  Thanks!
  BR.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
