Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48B70EB40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbjEXCSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 22:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjEXCSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 22:18:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AEC1;
        Tue, 23 May 2023 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684894722; x=1716430722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AiR0nG0vNDBGH2V90CPQZNbL2j+VVw6KoTIa441ZZ24=;
  b=iYtXAc7BLdzr6caRQzRGvRxMGjBDvx00sCsGVxAZQzZSW6FesAOoaePA
   movpkph/9ViSTwtJHPoa4JVOw+bm3h9GH1+1pG+v3LBl9nGs1fqA+D+IN
   YRB1l9pt4eExxwTGEgbd1sA2IjoXBdqou8e7StSZJRQ/5eRGNMmDortqu
   c1VPPtI116itPkay5qkgK0zj0fPEi8cZpVRy9OAHyyBtRHjrE/v3zcEkL
   ABy2S7IElY4TOBAPZB7BlK81fYkeOSq60hbwv4GwZY0dFvzIjZoBwGN1u
   F/4loDdyo5XCtwutBtnHRl/GhtGTUnARnO9a52eEDC+bEb04egTmj2AEJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="356651485"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="356651485"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="654634395"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="654634395"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 23 May 2023 19:18:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 19:18:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 19:18:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 19:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPuM5kDSfGq/CWT1WHYYl6voLNsJKGnamMKtZiooTrm+ETKvhDFT3lBSruQDww0564VypDeqO9NPSVMpRzGFQw2GeVYevbJ3cSEhdBQGUUA7CvcumlqMMZesffuY6P/1tpZwr6X15FRsMuc3PryEbSl57A1nRbVRvk8l0Ocsi5lor0+3iIcChQt6QIFQSx+QlZlRakwv35mYNmKAqjO5V0UC55IUsmm/rTLqz+64+d6p/CwBYQ04QmcTGQcAEa6Abje4hSssSrN3qmrTMQtbz43tYx/StAv8EkIIvnknJ/8VBLNkrr+L5NGqCud2zQmWSTNaKEDMptyhIT8QF5zzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi/thOpf5WTXVIXXD/dWw7/tJRMQVbyH6JNP7dHUCJs=;
 b=IITAaTK/Aa2D41kMu3K8gadWDgqredPuDfJeBdaJM05RxRsWt08D8TdVdhlWlu60uXEtc4GqAdaOuP+R4r8Xoh90RBwyBTlBE9PAL5nJggLjwu7RS3gh+pt4eryAlZQs7ormNldzlCVnTqxSXOzGWS0FB2K81R+J29uYf5xtYkHwtB98aUUcE+QX1DVCjs9YzSX4dfi1+adnh0AJMSDPQQW0SZylWjD98I72jqfA/qbQq6KdFOYMarNA60AgTtxAaWuPfFErHBVcrfiD97FTChFLQiJsEiVP6q2YLTd3FJ1Es3wi6EwVXdhW8ghMh1MqfqEq6lMrSrP+baE9YCRcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 02:18:38 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 02:18:38 +0000
Date:   Wed, 24 May 2023 10:20:36 +0800
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
Message-ID: <ZG10dA8uBpLs+tkF@xpf.sh.intel.com>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
 <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
 <20230523000029.GB3187780@google.com>
 <ZGxry4yMn+DKCWcJ@dread.disaster.area>
 <ZGyD8CNObpTbEeGQ@xpf.sh.intel.com>
 <ZG01u5KGsCBnWVGu@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZG01u5KGsCBnWVGu@dread.disaster.area>
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f52fc98-f5eb-46f2-4931-08db5bfd2f72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epyJL61+fSsKnfejDyg/y8J51AlEX7dbG/a0sTs5eTBdaor1JRkRa/9itThWZ3Oj6Km6DrboZvkRkzrvKbYhQNf+1Z9CnP3QhHbswRzxNU7u+YmNoe+dgg1sE3pew+MkI4MGwo8M33cDkeWDKzB/CjEaNzwKuJhpsdhCXBDTLoYGfdQp4LUJdVBT+/3i8/tEGMWME9WNjB7eTkFdsUlkyC68HQnztpL79rLppBr67u3B2zMLn+QqCcbz2uO17/DtrpzsZjS559pGF9/5GpX09dE9GIhWQmBxg2VuFxP8TMKm6LlyN14kdDi1TT5XDNsdxG/tnjMD5wZT2xC7vYKbmqVq3tGVh5V7Yh8f+DZAfQeN65pWonqVInnM5GoCCgPPKdWJfMNhgJn2KewWsizDIFogl5cBSTad/ggt+IJG0dqMRweUzYBgNIirgE0ijrRdQ32lWIxyMiXiyEBlwxhqAJ2nyOOuxZpO+2xTB1aExYckWVaH/J2xK9gPR8RTCA2lO6A4es7T3vux7A22sJq4bma3UU0Cha75LalUDEeLfYgalW2NCVXS39hvxDhaxiW/uvny+sE633K7UuIqGiLbMn4CFldV6kdCWT7/uSy/RFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(66556008)(5660300002)(8936002)(8676002)(44832011)(83380400001)(86362001)(6512007)(53546011)(6506007)(26005)(186003)(82960400001)(38100700002)(4326008)(478600001)(6486002)(6916009)(316002)(41300700001)(54906003)(2906002)(66476007)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJxh+TIdCG8zi44sHTksfsi3LUgIWztlyOhOL14+posLs/YJHkGDeDOD6FdL?=
 =?us-ascii?Q?1BcbNRpe6JS6fbRl9ChJJ3PfNFjWMaHYA9niMJmCYIgT6/0PAImztaOiYihF?=
 =?us-ascii?Q?A2NMbG64fssOeMJbOGDldzSvQs7XRV8pAPeHG7BmgWGixbd74kFQ+t1e0kcj?=
 =?us-ascii?Q?US6GevM0thJ59gcgQST4QcitRx/yWs/eby0dZ5ZMzvYZdd09xZiykSIaj3lK?=
 =?us-ascii?Q?ilgOPVqmqv8DnanhxqZ+StCMSSwoMW6wErL+nyr+tK+hfFvvbJpe0QBMClAp?=
 =?us-ascii?Q?jFR6NnRtxzoXmEsiKQKiEgvACxmAi0mNSEqpADDZOt6w04bkZVJDl2MDfxGe?=
 =?us-ascii?Q?Cr920pSoYygXK4EKqc3UFSMJW1JBjsxd1ySyd+u8J40v10eZviiSWtXH928P?=
 =?us-ascii?Q?sVEoitHGZQCyROGEr51iVPWQt0IxPjDopLQShXJscVuEDSIqTvRG178L/G6w?=
 =?us-ascii?Q?9e63SpLmahymUSS1Wolod46vbvXpFp3SEoOqGEoseDgWxi1BvA8BfN3Npgm1?=
 =?us-ascii?Q?Iyphx1cHn7Xz2UaOyR5w2pYqx9Peqlfbd/f6zJqCKN9WwozZLF/n/k8JRoLY?=
 =?us-ascii?Q?y82rrcF3FmRVZi98FevVJCWdceXcflgbl8sC3D2AMZXGYWxh+CIWxGUaeGG8?=
 =?us-ascii?Q?5QeNc/lLNR/Y5aLJth87xiPDV/Qe2EPzti1+rgWVq9rDAzvxB7LSf83gB55P?=
 =?us-ascii?Q?dIXPAJ8JliCmsY1kXAnyuKwKQTqJh5hK6MgRxKt0BqpK3mEY8XCLLP1Ybp5d?=
 =?us-ascii?Q?3xmxJ3b0C04tASGt924IgN9ZfN8lLOKknXUkUCbhVB8CCtfA4B782KSzFZaa?=
 =?us-ascii?Q?oNVGeecfmfVDCQFIlFf9TKjK25ug+9RWHdISWHKIzBpQoO6yXW/u4vY+pk20?=
 =?us-ascii?Q?MU79VLceYHuEd/y0rvshigZ3A0apbLg6Ym/VVznJdj+TmcpCLg/yyQE/0bZg?=
 =?us-ascii?Q?np8XURT17SiH53Yeadlt1gAToq4z1aqlYhI4+UwAG2kUum9NFt2r964WrLa0?=
 =?us-ascii?Q?+zPiEXw9cRA76E1Lv3y/NhqzNB2taqwLrWFTDpSKsXla6f4XH0Sg9pIMpw60?=
 =?us-ascii?Q?JuehexWMbuYmnoPLuXN+Boou6ZpcZd6lA8QIHvRTzNDX3jnP92X0Y6rh6/NQ?=
 =?us-ascii?Q?EE5GBNCHU5gkNtmage183uSBlX/7r3GOrF97VsEQRVnfMbyTiAD8irEnEgLE?=
 =?us-ascii?Q?caw2K/Vuh36Fj1ZHT556X/4ZdKmF0VLsCx8k3ErSMF6g0DF30woXg7oeTAL1?=
 =?us-ascii?Q?+HbvcH/cUMsxWbGDSGcWECgIZJIO7B4Q0PCV9xo6s1SPP6IooEnht49wjcIm?=
 =?us-ascii?Q?QHnqxBSAwz9iGKrXDN5JMsxN+2/vecW2INBqNtue8m9uufFhAAnZUwY+cwVq?=
 =?us-ascii?Q?vkXJrNFgWfmpHaU7PXNUu6l+UmZkrweqooUJC+uRMOxtiHZteNdGQcdvw0IW?=
 =?us-ascii?Q?oLiFkR1cTgZ9Ajg9iz6pyR9j93gU6Hz079iSceR1Qy8jWgAhw8DW2zlDkjoE?=
 =?us-ascii?Q?k/TaknS0cHFdP/y4HXmnQLDhPBl3LU21VPewtjkQyl1P7wxGdRIBZcLhJIcC?=
 =?us-ascii?Q?bf5yv1VGStWAEBGZwhCM1p9Jfgxh9r5Kn2aOkGYP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f52fc98-f5eb-46f2-4931-08db5bfd2f72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 02:18:38.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qwi0zOfsyVY9VTqHKgPHU0RmMDgHl/zjpB5tl2mlDr7wsPAVCsHa9fLtupS82h0i7ULB2J2ZgE8JrohFASMKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948
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

On 2023-05-24 at 07:52:59 +1000, Dave Chinner wrote:
> On Tue, May 23, 2023 at 05:14:24PM +0800, Pengfei Xu wrote:
> >   I did not do well in two points, which led to the problem of this useless
> >   bisect info:
> >   1. Should double check "V4 Filesystem" related issue carefully, and should
> >      give reason of problem.
> >   2. Double check the bisect bad and good dmesg info, this time actually
> >      "good(actually not good)" dmesg also contains "BUG" related
> >      dmesg, but it doesn't contain the keyword "xfs_extent_free_diff_items"
> >      dmesg info, and give the wrong bisect info.
> >      Sorry for inconvenience...
> 
> I think you misunderstand.
> 
> The bisect you did was correct - the commit it
> identified was certainly does expose the underlying issue.
> 
> The reason the bisect, while correct, is actually useless is that it
> the underlying issue that the commit tripped over is not caused by
> the change in the commit. The underlying issue has been there for a
> long while - probably a decade - and it's that old, underlying issue
> that has caused the new code to fail.
> 
> IOWs, the problem is not the new code (i.e. it is not a regression
> in the new code identified by the bisect), the problem is in other
> code that has been silently propagating undetected corruption for
> years. Hence the bisect is not actually useful in diagnosing the
> root cause of the problem.
> 
  Thanks a lot Dave's description! It's clear.
  Anyway I will remove "CONFIG_XFS_SUPPORT_V4" in syzkaller fuzzing test
  next time to avoid the noise.

  Thanks also to Eric Biggers, Bagas Sanjaya and all community's help!

  Thanks!
  BR.

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
