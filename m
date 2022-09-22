Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD46D5E5764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIVAee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIVAec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:34:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D71D75;
        Wed, 21 Sep 2022 17:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663806869; x=1695342869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jqnTPnpiZYAK23LBghjOViRnifzNb+N6xJnk6sOc3pI=;
  b=ICVV3jgyWYJCxH5g8ROqiEbWDCVENGkKjPSXkr8IWbVzFnuDWsW3d9Zg
   5+85r5ZXt9AdUnWGPX5WMuOB2X58GYOHiil0pSib50RUwcUKeEyPHkB4o
   UgskJvvlNvnR+0aeL934LdxSVOcXy9Ndirn20O0TbYLzFdFp02mKnAiE6
   8b9pFUMtgaDfHl1NTmP5yTj9DkwsU0VaBlEuc57gX7/NCcp+nefDVK0Cd
   1lAmzCm7i0b0kJSIUgt6BIZdnKMfr0SvenDG0zPDj6afronfbjhobHzK4
   Rp6HuZOsebLIl08BR99OUMdZVNkFB0QrOJLKZiNlNsaGvN8lWtmzl0MKd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280532192"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="280532192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 17:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="864647026"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2022 17:34:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 17:34:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 17:34:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 17:34:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXnnHzeRvM0eapUnYjhDae6dmQlXaCjhEBWLVW4a1nBgXCS2x+ulK8sdRbg8ZkMJKciCozPj6IyfF/aVL6B0LpAq79Vl0wM6n/BlQQXSgrT7MxmcpC8Q4oUkAYmxEnWCeeq2W1SEaAOeGa0zgHAIwPr326BJZmH5Ir+Q2A3Jz5kkyi6bZNJgyKnBAMlLwnMgzrJyzey8hfy9ysZyoEk+hnxNtLn1DxJQFiuBuZQstoE0qlyU9XHiYMCEV5lPtoe4Pkj5+054xPEZc7zdxs7mwg5oAihV5hRDpzXgZdSa2XHEV28hnnXPWqEsKwcSvtKG7SwXTPIIGDZrDEc+ZcbRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysCvYwFHEas8xK2oat1R/yM1BCDSckx7FCOPm3yfG/s=;
 b=jpCDP4LmnwbgPrwkyMemDKvJrTd9EVwMOkmnS/KgGoJ3uM2qajBFjk2CW7wn1EYQWo96D26X9ZkGo1D9hk42S804haC9tgAZFLrAAngk/QFOlgt0kKrXE5g+4gzt59RAMRddGzWtFeFiKr4+h/nKzvDUHqUKKmOxs4UEt2TT/2YdeITgnkROTI5jnEZQV35IK0hXCKg6RDzHeNia/CJpx6A0pBNOXaf8gL7c6o79e5b8j8pRyJ4LdcHIpbPoA2pU2SzGKn2B1DJrN/qVEJRljils5tepoiea2dFiiNNicvXkXXiYZ+hciGMw626QIAefoqXJOWMkQqRYXe4rrQTyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5593.namprd11.prod.outlook.com
 (2603:10b6:510:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 00:34:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 00:34:25 +0000
Date:   Wed, 21 Sep 2022 17:34:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Message-ID: <632bad8e685d5_349629438@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
 <Yyuml1tSKPmvLS6P@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yyuml1tSKPmvLS6P@nvidia.com>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b73711-d72a-4161-61b7-08da9c323368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP0Ubq8FUQILZg0RXMQNtJJFRetE2xF+K3gIy4E48oc0NAXh+Ld6m/CQyszs/5NxHPC7X2uGSqd54I3kyO0YaaQyaQkUckcbWaX97pbw7RJhbyaQf08iv6ycd9Igj/9DmEy0Mq0guQJcq2dqoc/1EfIVzC+Cu9WL0ExGqbiqq67/JjSbTf0Nzg4Bv+88JUc5opg9Lvy8dBkxKaOnrqzDc2fPhEQWFPPDNmTJWFdTti3h1LdS5uwm8vkTh4L907Gl9+cyXFbCHlp/jW0UZYfP0JEsxV11eUUYIaHYVowQTzjdGvwVj3e9iccbxpIUSTWXy7uAAvC3jtM1N1VtlbOQYS3VO+p7xU9YsIkAfkkGOU5U3kHYBo9Ue3qiIGQ40odlRaHeagNsE4bjjczEopkNcEs7lBnceN1dIRhTAMuxuw6jTPYFtNxYiVlE28fZRJ3YOiNWAd8C506+j7f9pG2o6mQ/B3aF3tQ4ATKLUML3WRLUqGOOVPud+Q3dn9ipaRy5BJJX0KFs5AQIIgv7KTqQVnFvRhDTawGoZO+fCP8smYQReij7bqKNzGpsp77AiayvEbdHSTF4LMqQswGr9wEFhmEAuCduDIwYL8gYNLXIdPPUKSkmZYqS0EYazQa4/hG9KIYCIv1/QJSvzR3QEAf6kQ766QlCgNCc2QhreU71lqNJwEJLSUQSE7Ia1HKBfC4ONFozY2b+kwxvsecdZwR+lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(38100700002)(82960400001)(478600001)(316002)(8676002)(5660300002)(186003)(26005)(9686003)(7416002)(6512007)(6486002)(66946007)(66556008)(66476007)(4326008)(54906003)(110136005)(83380400001)(6666004)(6506007)(8936002)(86362001)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NLPsHmjAExeu0mv/ONFYGsxRjgsM9DMG0CjApK/L6enidYGZrxcukERidyv4?=
 =?us-ascii?Q?evlXMjkHOGXq+AsnPBfIjJR2rIqB8fulySNoxlKKUqZQgpUb7w+sk0rBm00U?=
 =?us-ascii?Q?iTKQuPSzFYuiNrSrzQV/Bgvhqg+kUuHWpxXQKBGGvDEAJ4MBGsHCpN96Vnyy?=
 =?us-ascii?Q?RtcC/NOfwbGeQFwJdQnLDaNkFoZtk0ksBdtHYs0uDw6MH145XPdE11A1lqrB?=
 =?us-ascii?Q?ScffRZ8lcO2wGFEM8NXXnv9sNZ6rbPpWFNYfMAUQV6cIYw2VK2q87MYZ0Y0C?=
 =?us-ascii?Q?eqgK41goUJ0RTfwWgK+5pTq2tcPAnCVmoX6oq+P/RFBcJocyifXyz23BIULn?=
 =?us-ascii?Q?Bvj+NDV8Qux6edbPF/TbyY27gfysblwUZn+rXOboK4YqB9JLfVLMSLVpbzVW?=
 =?us-ascii?Q?kjRHiilKUCT0+G3+o+GWUYK6gG2NgMFTXRTN1Y4ZB+6zPHQ/6wJTuoeSsKaz?=
 =?us-ascii?Q?3+dZDeSwI9gDyBERz9XSqfDcxc6ktwAk68uN8zVSVJIejKnzNOSDxFPw+RCg?=
 =?us-ascii?Q?/Ey+fZ4SRJtXHnbw/DhyoqiaCy37nFJec0AyLVv2p5jsavaggYsgCm9KZtOH?=
 =?us-ascii?Q?vF0wJE9DkXS5hGZRSDdT3bhs+qYySeEw89ufz7+BxzIoX1Ua5vozYXyUcz92?=
 =?us-ascii?Q?bTOSa3UwMAHJaH59xw4JBFHt2T8KZa50aOJj0Gv1PMxwFAZF4YBVFjsj/xRM?=
 =?us-ascii?Q?6HARa76hraC+fvpRe7o6gpyytMsmQg3LlG9nMeXvVoiDxhiRwY3F9pRrerHi?=
 =?us-ascii?Q?lQ/lqd0f/v29NEDrJPem9AZuz8k4gi/zQVQh4tQjEMhIaFcxiHEpYwumhodQ?=
 =?us-ascii?Q?Evjkq6fPSnY66SHL4qK1bNak18M3voDrtZPg4ioNgAAKA6+0iecuI66txyAl?=
 =?us-ascii?Q?hcewVESwriLAv+rf+E/UwSSxgjd58Yeprd+cnHVaPpc1EaYPtU/l0buiz6IB?=
 =?us-ascii?Q?g+PnTP54yWxJ1Z+lxztHb5Nkr/HwUp9RnSuZ7Pcaqn00Jz7zTBVrAPhDqBwB?=
 =?us-ascii?Q?c8k7iT3O4ex2plePhZjXiCqeCEeFCpNn3GyGSTtEmcpd3mhfNRtpuuB/ibAp?=
 =?us-ascii?Q?f0PbWXsMeQkjI1I1hGhBLvyNYafMlwkXtKJ2IM63vYjLf3M5i8+z/z+Au9zd?=
 =?us-ascii?Q?iKIZov3rrR32tObafBi9V45R6/FWwNFUJYk5e4s3gS1AgWhvDnZUDFRAxDid?=
 =?us-ascii?Q?MNk3KelY3aFTYpZhOYKWiLkCIRctG5OBsBGdyF8xHKqJSeQnI5lWtnQ9+2iX?=
 =?us-ascii?Q?K+svA8RL3k9K68BUlLTwC7W83qWJ/4LAnh6xrzqQAuHiycXew3Oyh8iLoNWr?=
 =?us-ascii?Q?TrXp1H3sZWvS2dmuasx5kSs1N7N9IuSGzi0c4Szem8dgvVM1kvA6kHXpnyMl?=
 =?us-ascii?Q?lW5c+dvOZZzLmBlh5DtwfgT8kAVU/p/4EABToSTv5O94Gxbb+DnvJ2k1NKS/?=
 =?us-ascii?Q?UBFRtMej0U67qmKEF/NcF5D4zKuo1j6smKXWRiD+aOg/qexli24qogVRQIcW?=
 =?us-ascii?Q?IkpVEvUe56krCb733cahPWsHsorHGKLQs8c4oQvJg+MtSD7CVIg2POuC/b3C?=
 =?us-ascii?Q?02ArQbBxrAjxfNhjwJrKQU2EfbHN+XouhuUPg3NjD4Fe65bh0Ba/67fNZnDj?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b73711-d72a-4161-61b7-08da9c323368
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:34:25.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weFQmGvlASfUMRaWZf5GSn/pH5N44GRni/FqPTJB+/eJrLZw0eW9JeVSVzXxEVm6k3up+6Hq/EDRa4eCfXdwyUUigILDPrX4olLjoKzo6s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Wed, Sep 21, 2022 at 04:45:22PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
> > > > The initial memremap_pages() implementation inherited the
> > > > __init_single_page() default of pages starting life with an elevated
> > > > reference count. This originally allowed for the page->pgmap pointer to
> > > > alias with the storage for page->lru since a page was only allowed to be
> > > > on an lru list when its reference count was zero.
> > > > 
> > > > Since then, 'struct page' definition cleanups have arranged for
> > > > dedicated space for the ZONE_DEVICE page metadata, and the
> > > > MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
> > > > page->_refcount transition to route the page to free_zone_device_page()
> > > > and not the core-mm page-free. With those cleanups in place and with
> > > > filesystem-dax and device-dax now converted to take and drop references
> > > > at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
> > > > and MEMORY_DEVICE_GENERIC reference counts at 0.
> > > > 
> > > > MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
> > > > pages start life at _refcount 1, so make that the default if
> > > > pgmap->init_mode is left at zero.
> > > 
> > > I'm shocked to read this - how does it make any sense?
> > 
> > I think what happened is that since memremap_pages() historically
> > produced pages with an elevated reference count that GPU drivers skipped
> > taking a reference on first allocation and just passed along an elevated
> > reference count page to the first user.
> > 
> > So either we keep that assumption or update all users to be prepared for
> > idle pages coming out of memremap_pages().
> > 
> > This is all in reaction to the "set_page_count(page, 1);" in
> > free_zone_device_page(). Which I am happy to get rid of but need from
> > help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
> > memremap_pages() starting all pages at reference count 0.
> 
> But, but this is all racy, it can't do this:
> 
> +	if (pgmap->ops && pgmap->ops->page_free)
> +		pgmap->ops->page_free(page);
>  
>  	/*
> +	 * Reset the page count to the @init_mode value to prepare for
> +	 * handing out the page again.
>  	 */
> +	if (pgmap->init_mode == INIT_PAGEMAP_BUSY)
> +		set_page_count(page, 1);
> 
> after the fact! Something like that hmm_test has already threaded the
> "freed" page into the free list via ops->page_free(), it can't have a
> 0 ref count and be on the free list, even temporarily :(
> 
> Maybe it nees to be re-ordered?
> 
> > > How on earth can a free'd page have both a 0 and 1 refcount??
> > 
> > This is residual wonkiness from memremap_pages() handing out pages with
> > elevated reference counts at the outset.
> 
> I think the answer to my question is the above troubled code where we
> still set the page refcount back to 1 even in the page_free path, so
> there is some consistency "a freed paged may have a refcount of 1" for
> the driver.
> 
> So, I guess this patch makes sense but I would put more noise around
> INIT_PAGEMAP_BUSY (eg annotate every driver that is using it with the
> explicit constant) and alert people that they need to fix their stuff
> to get rid of it.

Sounds reasonable.

> We should definately try to fix hmm_test as well so people have a good
> reference code to follow in fixing the other drivers :(

Oh, that's a good idea. I can probably fix that up and leave it to the
GPU driver folks to catch up with that example so we can kill off
INIT_PAGEMAP_BUSY.
