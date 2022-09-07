Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F85B0E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 22:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIGUps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 16:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIGUpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:45:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5073BC118
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662583544; x=1694119544;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NBIc9NIkQCZc2VsQD3yjeyGv2LRieC6aeCAu6LnU7AU=;
  b=D8IDc3u6yjhnNruhG2BiPFCrVpQHBxGSPxyNjdS6q8EX0rqJNRJmWUjj
   9y0YqZE2B8PMI99iZiPI++z7B2uwc6IUcGIoeHdtGIvIdx/ikhNJ5HOdo
   jA95bObj2LXqVTt+R8qYhkG5cWziwvdBGEvomDccEcZMz4cRDwYnv1J7W
   UKV3pbKKpVJxhyPrresdliswHXM9qBReMScJis270zrdLcaK77Z8RAzk+
   0il1cuMAK2iHP+zKQfltICQZWupj5PRZJxAe6RMzM34YwhxuqvLx3DONv
   FSEUSfCq9JYcCajzvGyQrCOtr/uUgjbYhJbKlV+7cyjq6mT9NiRuae3Zc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360956244"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="360956244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 13:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="703751056"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 13:45:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 13:45:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 13:45:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 13:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG7aIsc/larBlYJQs/skfy7JzenKHhSpomK6eor295CCrAr6+Uxk5U54SPNeDuJ6jhh00XkfjK4rTKuRbiYDP9b0x/TzHQEZxvMFOSsT5Ez7Yp6FZyEkTllrI9lnd+QudYDVQ1v9Wz49T5pESqvO/+o4BvkCpFBuEU8DfzXX69Yx/YkFgGFanr9iEXoJ2SC7VimrTu32YfDrPcXqOigAhfB2k5PPCoZrjHpKSsvgl+UThVuE4gmDprXwiM+5twTymPGxWMhqeWiLD4d/ZjYCrQKne4LWvtprQNtsh4NugjUWEwYa7X7qbNgNxjz+gP12ktFgDqqBHaEEQz1HOvVsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb0pjSSibLq7XZlJDtkIIqyVotc/3dKRtzgX3nbOZXA=;
 b=Hz8PgxU3Z2bYiQof1WiCabPAmsaDXcN4itTiDIZ2D4+DZkKJIUhhu23ynMpSnOXPhAwTHNVse0acNuzPYN6CUzIvIr93+QRepu+UfyzWmKYWhPth3U7bfkb25yd58+1swGYACG3yCjXGZ36qH3OJIFmcg7U49PfSne0gPIPSAiQRCUNzoh+hYRsyQFH2Juhw/FQKjKRutP7lf39sg6RrXxUDF7onkJTzgzktPChP2fD13uGUGh4QOjyHjt4opn1f7lrCw/TI0fHcPOooPD7yxfpZQ4SkoPIlGDIZ+Au8eDveHfho2raaJglTL1X4UYqWLUxcalKs44rMUIQ+eXO9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL0PR11MB2948.namprd11.prod.outlook.com
 (2603:10b6:208:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Wed, 7 Sep
 2022 20:45:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 20:45:38 +0000
Date:   Wed, 7 Sep 2022 13:45:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <631902ef5591a_166f2941c@dwillia2-xfh.jf.intel.com.notmuch>
References: <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
 <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <YxjxUPS6pwHwQhRh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxjxUPS6pwHwQhRh@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc87b05-f794-4046-2f35-08da9111ebc9
X-MS-TrafficTypeDiagnostic: BL0PR11MB2948:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1wdvfFZanquQvM/7r2l+Y9MAidLRuNxOrSuL8fbVId6UEzCATpi+MIiXJL7ccgTjObq+zb10dF85yibn8YQPr4W0yd2oMPZGrNiz+M41qRYf4lw1AEQgJ548V/cbHGoo+2C7YzGnYl9Ebqs/AYlzEw1tW/hEGQ7s8GkWbZ279ULrWQNSNuthOtnBXtCCnbzzk2a+ct8sL9mTo6RQUL8y5E0TXEkC/da8cF/bs+8pud4nMeX9SctjkZxwkR6tGFBYjiiiLxHJFafYPyqjGm7cfI4PIF+gxi0GY1hRJYUkaXmdY6Nvlxd4nRAcFIy/Xx4Fbj65Wpr44TnT+QnBOq552C/Laga50NB7asG9oPTxU2xTUaFPcg+UYDIQgSP9H7cKhEnGtnOUjhHHS/5P5jQmeNwmla2qYkDr9iHEieICJ+jfqxlhQdBdpVbq95QxfVM+WFndvd3gT/Eg4mv/zSjTr1uL3G1i46BBPOV2KOqd1Nx0F6vE4OewHbN/XnJN0gQ/2/PkudPk5rE2QOAigGWV2iqmg6znxXXo+0kl1xyHo1cS36kt+oVUaCywviGMDza69MU48ynPy0fLKJtD1psv2yGJTbLush9xvcn7bGA514m3nYzqSZbYRevrnOn7ybpiGJL+yZ2a1BPLv1HoHLePfh8TNAoeE087aonYQ1KCVCh2gJC9Kwlnl6FToWZVREm2gWIw1v13sukX9pHQwjFmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(4326008)(8676002)(66946007)(110136005)(54906003)(66476007)(316002)(86362001)(8936002)(7416002)(2906002)(38100700002)(5660300002)(6506007)(82960400001)(6666004)(26005)(6512007)(9686003)(83380400001)(6486002)(478600001)(41300700001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCI8wNv6m90uQTauaPdBQzDd6CqaandbA5sRDYNs9k4ioSXvIaPMXzNGs5H5?=
 =?us-ascii?Q?8V45zgBfCEIMU001F/aLaX+9vbbfX3Op8qPNpoH+3yBpCI+6fhLYVcLn7FX3?=
 =?us-ascii?Q?zX2e4g8F6kNudElmgnfSKNoaFasMZF8gOrPdxIl47iLccRItXPMzb5UpTSDQ?=
 =?us-ascii?Q?Tzxlh+6tOm8kkYzrcImGV5l7ea0BAWiGlq3j5bsIaFo2Wa/UVWXwGPh5fH63?=
 =?us-ascii?Q?1AsRHe32R2NmqJXZEVcAFgjXW3X0kHi1FLGQ3S/L66Ocf6CTwMbqhDoF5/zF?=
 =?us-ascii?Q?0Ebvg9pNKrcl0CPVIMF/+2MI1V4JPAX1gneSGtPZBXmoCbn/lmg8qHma+sfV?=
 =?us-ascii?Q?S8F0/khlRqPgXfXqXxD0ekjQjmrdL5flT9pl7/wBnT04ADFTugsas97F5Ru0?=
 =?us-ascii?Q?JAXfhMZg+PFLhMDZhXMcEPAdC9YKmIrJR+POyzHQup/jY+Px424siz50sTDA?=
 =?us-ascii?Q?bpT010WHo23ExO+I8IqQmSgD1nc6L6ih3rhDLTdru/jIWaojeNO5Ec7yC4Tj?=
 =?us-ascii?Q?sB/1w6LYawCNd1CzvocFp6rkwOGwn9hD1koaqJUfkOmY/quJnYl9+70qIVI/?=
 =?us-ascii?Q?fCYUCFv7+fx8ou4CayRtvayFfE0CAZItamM8K50rMNpq0fa5mXOyHhT1Lzxm?=
 =?us-ascii?Q?9mtPfAFpcbba0/xRPIui8P2SyC6pm0JB4imOS6apvhda0JW88kVuSx34AjYR?=
 =?us-ascii?Q?yUASP1z/ODiEkInnsTzXTMLJdqSYbdd1+BXPH4SmbPL55p3ZK/RqBiI3sYNI?=
 =?us-ascii?Q?iF/CXdaR50O7PTTGzogFlPQSC6nouUosqMyru6NcAvUhEPzAkLOpwkLSWY2D?=
 =?us-ascii?Q?qeQxc2FtOnVIUyqniDmq3EiqkxAV3Sm5o4QqKEl/qpf3ByurN23lkbhmHYls?=
 =?us-ascii?Q?8lFJGWexW70xqCmpuLXO5ec2XQpFpr7x8HM83coTtwVthe2q+7KsUqW14MO1?=
 =?us-ascii?Q?HVIGqPkaQ1MUsX+Gv3w9g+f5OOuOriGF/OjGhhn42CMXfw6hnVMNFe1GF8rC?=
 =?us-ascii?Q?436rbzuj8T8ZN18/QWx3Xh9jZxdCf+EmUAQkHUpwZryCXfySwB6+rCxcYNoB?=
 =?us-ascii?Q?t1LOQjZ2NPds3wsI7K+G9MvuL/HE3LMtvrsdvgIAoBzak7vpYegSBd0pnZhs?=
 =?us-ascii?Q?bmUBuS6Voks3bCkpPLbGGMsEX9oMGPje+w09rnh4HSW4CDJDhRhEcHCjuVgg?=
 =?us-ascii?Q?jDmVRXqRAH2FsdEq75dIcgDF+FppDBTJOOr5tN8UvYFw4cD67o/pzZBvyJxB?=
 =?us-ascii?Q?hKSNmrgAAdTn0iNPqACI7FnautB2ZFlfFTcCo8CWrK1rJnOqpVJPxqrp4Hmm?=
 =?us-ascii?Q?FiTANFgoanlqBKYXNaV8F88gs1y9Rh1OnPuE5IK5iZS5mjiTGApl+fqSuZnH?=
 =?us-ascii?Q?jFM4JK/eSUMnczew0jCl7oEFBNEu0Ye/QvfmeQiVWZnAwvGTmKdju771o696?=
 =?us-ascii?Q?5F3URkZ+c2lGK+VmaO6DqfgrAwxoXST2fLTAGpDDWnhw6P1eUYixiK/wi3Qc?=
 =?us-ascii?Q?NY+XUAEV43rqslJ8owA9776YaD3QAcNpPK0nRkE2CEz6cMvH80zhe+FWaW6f?=
 =?us-ascii?Q?cyEU+I36DI+0kPZDZvJojlZ4TaijTineSXHuko0kehOKZh5rlIcufKa+/0Xk?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc87b05-f794-4046-2f35-08da9111ebc9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 20:45:38.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2vSvKcoUnihEroZliPu9nY/qzO+NhThHcV45jTbyi7fII4ERz0ST4WOrVfu/jwIqSyQEoT7JfoiM1hv1VFxrD/tbzzC+U4wbje7vWlxP30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2948
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 11:43:52AM -0700, Dan Williams wrote:
> 
> > It is still the case that while waiting for the page to go idle it is
> > associated with its given file / inode. It is possible that
> > memory-failure, or some other event that requires looking up the page's
> > association, fires in that time span.
> 
> Can't the page->mapping can remain set to the address space even if it is
> not installed into any PTEs? Zap should only remove the PTEs, not
> clear the page->mapping.
> 
> Or, said another way, page->mapping should only change while the page
> refcount is 0 and thus the filesystem is completely in control of when
> it changes, and can do so under its own locks
> 
> If the refcount is 0 then memory failure should not happen - it would
> require someone accessed the page without referencing it. The only
> thing that could do that is the kernel, and if the kernel is
> referencing a 0 refcount page (eg it got converted to meta-data or
> something), it is probably not linked to an address space anymore
> anyhow?

First, thank you for helping me think through this, I am going to need
this thread in 6 months when I revisit this code.

I agree with the observation that page->mapping should only change while
the reference count is zero, but my problem is catching the 1 -> 0 in
its natural location in free_zone_device_page(). That and the fact that
the entry needs to be maintained until the page is actually disconnected
from the file to me means that break layouts holds off truncate until it
can observe the 0 refcount condition while holding filesystem locks, and
then the final truncate deletes the mapping entry which is already at 0.

I.e. break layouts waits until _refcount reaches 0, but entry removal
still needs one more dax_delete_mapping_entry() event to transitition to
the _refcount == 0 plus no address_space entry condition. Effectively
simulating _mapcount with address_space tracking until DAX pages can
become vm_normal_page().
