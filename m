Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA45E5713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIVAOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIVAOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:14:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23C303E9;
        Wed, 21 Sep 2022 17:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663805681; x=1695341681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZlimsI43qIQFyOX8rX8mkYmfby15VtdsmV+6eFko6/E=;
  b=miIsZ1a3gWOgw7k1Ru6SKftyo7adWatyhN6ZSTSRYbxwiSjTPrIbkOZA
   qPbaI7DCedyrVUV3o5NDgDFTo6+24MUiFOqW3RODVwILLbIRirioMGc2u
   lmxYXCQ1OD+YAugs94zRYMUXvLco8FSwiqFAh+RiPeZ6fb/Vp2EefsPEs
   LrLkHeF9vSDDcSnsMtKdRhqIOJlnNgn54NQjR8YIwmQjYq+Osx4nrFH05
   oAg+RaMJBsYTGS6VccfWn0xpvgBXslJBCl7BxER4FWvQ3X0TGbSWweERL
   7+SMv7VY0oWepZIt5yLCSgnQICjF9RDW440Cadai0WmB+Y8GtQzotk/8E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="386446651"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="386446651"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 17:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681993154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2022 17:14:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 17:14:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 17:14:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 17:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8peQayJY5B3q9H8EA7sdGoWNFw9m7plvQ4rKTrF3jkSjplTk0q6Wzthmlk4AWpI4I9iamaFeyKlFMcup+XXG22WBLyeZJiDiGsUjTtd9UK1Mz7XWOqFSxoAnRQ3RyoPCM95/RloBhARE2VKssJeTRB40XHZCJ9ugltkZoGOFIyYDYND3qvTYKsnepqY8PApdY1M0ts8/VReUUDw0BTrVKAJIutBOs7iMkhS2zXV4WPFSDIfgNt0Z6Bg0TCeayt0GXfMoq/Gjwjhb2pB4BSycx3Vtoj7su/+q32uyndzRFnT+i/DoJhDcMxVXg+Ls/Up3j59Bij+8hkRMXq+7Qm18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHNYMdHJ7lSIzzhAVpLkkRZgKyhEAslHlfv+YE+Z3bM=;
 b=SmUF6Zas8XxrM159Ya5arftw1sgzVAVM5j/7xtr87uwcu5FT+OXke7tRGcgLsV11vn+RER3vK08B1rZyXERcP7csSm+ppUEMNDnDlG+8rKSigh+OjNM9uGeo7CZ7FcVYZvu11idarvqw+Ey4d74Lg2h9Ju97oqb0l1xqapeLixF3+8+pjL6kCJDxFo/Ime8wpqHM9DEElSNyLIF1af6iW81NlHYzSnVwtHlGqj+/FlwL/0URMr8xy3QVx1z99u7+J4xbj/fvN0x3sH5UFdp47PdUW6HcP27QftbTkK8Qxw2FLFBabcFc35xa+YDCSUnEC+IxIfVUVTH6mPOFcLEyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6365.namprd11.prod.outlook.com
 (2603:10b6:930:3b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 00:14:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 00:14:38 +0000
Date:   Wed, 21 Sep 2022 17:14:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyuLLsindwo0prz4@nvidia.com>
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 668e8a77-7104-4f0f-388b-08da9c2f6fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+vPhIOCL5FhsvOPm1sPzFsPe1OYrIFx+M2Pk+xsxqdWX4r2sECdo1vstJ545CcihTHtwLrLSwiisMmUEXDYdEqFOb/NAVsA1jiHKvxDI4zkM8knAemW77UxnzSoaSnaeG01cxUvACDI3y7dyPlk6cEpKCd+9NJsoGi403iYz3Gj8/kiOR2GW5AbVOwZsWpgqfX4zBEM4IBOwSVC2ZZOD8f2z2OLil3NSgJ0EvfjtoL8tzXj6NcI9eZUaJBmMsJ1Gl5Nj+eDvnx2V4Xp8aeNuG/yURUmUfK7HDSRoKU0wLrO8owjO2tV7fiOn3VOpystBZfL3WaNBpCU4f/ZcRapm6YTzs2p3cDvr0Je1Y0pJqVt9YJCeI9bSHwo0XinQstOH576vT5Jv3RlDucdzHmI/5Q+Hv43dnumJTyTFhT/PNCWbNAnY0QJkBT7vwabWLwY0IvDd7YC+P/nkarkXrWq5e9Lx9hb/2305PVFFFPpy6wveAGmnML/LdJi8mBKm7Wd0skpg+UEgMXlsTO9BW6jdy8TXMeY3FrhjTt+WvAuuo9Wo97481cp9TstEqI6LsMkewNJGbrhFqZ9dV1I8CCYonYS7W6m539oDUi9rzao4TJoR0Mr7aBZ7xxOlqbllBp6nHsZsGJ6OScKHluYlBqdm1VkdRZkzzIgF9yvdz/5llLMF7out4FiUhwhCLnKLQ7ny6vDMiZGoMyckiFT6NVn7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(316002)(54906003)(86362001)(5660300002)(7416002)(83380400001)(6486002)(2906002)(8936002)(41300700001)(9686003)(66556008)(4326008)(66476007)(6506007)(8676002)(82960400001)(38100700002)(110136005)(66946007)(186003)(26005)(6666004)(6512007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9dj3OK97812DQpl9yXnlfpT+2oL/GSbHAmQAiWxh+FvMqnrkJHBLVssSzRae?=
 =?us-ascii?Q?l5WzQpCJ8Tb4DmBAceE9hym9OaI+agw0F/oHp7m/H8SnioTBEK5ZpqZf6Opq?=
 =?us-ascii?Q?+scTm+PEKVDlyV56UL5U02qSvu09psXNCkjwehFhBj5cdKSabG65zg4Lv8Gf?=
 =?us-ascii?Q?U4x0tyX1zM5Xi9iz7jCZ+NgOnFWfO6FNbw3Sam3JGlZm3pimPHR0lp7E6IM5?=
 =?us-ascii?Q?UGKEv9ii/sKo12/rGkYVthS1teu6h2/UpN2h3v7s2YNbFqjD9oE7DvAnP/0+?=
 =?us-ascii?Q?DjgHshOppl75NlAUMvRQ/BKNnBGK+7X+AsvaoremYdyO5GcWbjSIdO9BhBFs?=
 =?us-ascii?Q?PRAq3GAKp2SXNtdUELrBmN9UFElFG9MicQ3+U0Gd0jQLBUwlgbIKGGXKL0WU?=
 =?us-ascii?Q?p8bZvJTBwNBibt6z8H9UmlhNibEAct/sxhiznuCkolU7gnIhlZRukNNbfT6w?=
 =?us-ascii?Q?KDfotkPSYq/HrbY6Fg31jngLyDyKd5HhGeUgDcqJJSyBs/qzhhqwxG4r/tzk?=
 =?us-ascii?Q?BOfR2eMarGBVYhiYRb43+cTRAX19dvQUY7nJd0Cm5i6wFm+G14QSAhH1Op1H?=
 =?us-ascii?Q?OzTVjINuJT8adv4uAJkPpgYkiUF2AiQFDxjHjbfpcoUzS2IObn5xu3ln03wx?=
 =?us-ascii?Q?NNiiipjMtG9j2p2wBPDPIUK+VtOnUe6jam0EDKTW9NnXexaGAXodond5IITI?=
 =?us-ascii?Q?qnN3kAw1lNj1DdYNlr0eJJ2YRW/ZvSRDKNvKIc/eTzZfK0UXqUJr/FTIUU30?=
 =?us-ascii?Q?F7wAefQX36mLMrrwoyYIqvoPu8BsDDkJ8kWdqXy9IM+ZbKw622ga+wJGTu8+?=
 =?us-ascii?Q?LFqrDWmZa9SiEc7w6RdeiWgVB/Dilmf9e/2sQIKafM2BBRW4mAfNK5qDOma0?=
 =?us-ascii?Q?hDNv62gzagqB/iFSvkXWy2bAYqDji27lXfFjAs4SsdUx+mp+ymHTjOI24adB?=
 =?us-ascii?Q?Not5PBTJ+JQw/a0kHYBuB65bYks2K+R8+jooqiTTVHNYspmL3xQ9cfDBpLiz?=
 =?us-ascii?Q?wzZ4gaicj1aQp6PcHEAmdGTNbAJD8SMTw4nwV67q0MsTpjaMIjljDBFxMtTR?=
 =?us-ascii?Q?GF7VAVIka/Zl5/lqhS4qb8oWGxGiG+uOld/COYc8xm0T9mDMWxFJSWX0HJFz?=
 =?us-ascii?Q?7wjxY1Y0s/XE5Yv+vUWBwRihfRDQu7+2yXx9YT+H8WCYR7IXSx8qRu83jvRf?=
 =?us-ascii?Q?+xlynsLHvki/EEXu8ukr3tOwi4W/b+IHo+x/LMV7/+NnJ7ajB8U8nf7bnszs?=
 =?us-ascii?Q?FYwFs6oOSHBkcYfYbubH0K9F0nGI+SR+8D1RHQre3k+mneVbU5LMG3dK6fD8?=
 =?us-ascii?Q?jYxisV8YFxY/cp8QKBIwHxVs2OgJDcOCnDTtoXe5PCK9MD+jBiEQGuqOzeQy?=
 =?us-ascii?Q?Hiz955bImyq8TyVfAjQ2FKfctV/9qPYPvP5ho2Qw6FGL+hB6f1MSKXrd+uqY?=
 =?us-ascii?Q?prnJJrcc6FGeKOQToYYrWaDHAU3rpBwqANoRRrb4VhCHD4iKvdekwmpbILeM?=
 =?us-ascii?Q?mr1LSZWLP97VAMmE5Tji7w1dC86VqqblEdfNfA7B152GzBg6xmuUGssmkzZH?=
 =?us-ascii?Q?SwLS0Ggb1sgr+Os3dcH0m+WL9kuIUQ4WbnS1JFEBJuCTf/FFXXtjAjYqfUP0?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 668e8a77-7104-4f0f-388b-08da9c2f6fdb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:14:38.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9scufQYP3aOyhMw/NnJAkmxmNfpJYhEaqXqfChH6kJNaQhB7GHlMtjsIPiQe3sSVV1SMqAwWIkoGt5eu8BtHzITYsVRgwcamXX9QYyPIunY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
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
> On Wed, Sep 21, 2022 at 02:38:56PM -0700, Dan Williams wrote:
> > Dan Williams wrote:
> > > Jason Gunthorpe wrote:
> > > > On Thu, Sep 15, 2022 at 08:36:07PM -0700, Dan Williams wrote:
> > > > > The percpu_ref in 'struct dev_pagemap' is used to coordinate active
> > > > > mappings of device-memory with the device-removal / unbind path. It
> > > > > enables the semantic that initiating device-removal (or
> > > > > device-driver-unbind) blocks new mapping and DMA attempts, and waits for
> > > > > mapping revocation or inflight DMA to complete.
> > > > 
> > > > This seems strange to me
> > > > 
> > > > The pagemap should be ref'd as long as the filesystem is mounted over
> > > > the dax. The ref should be incrd when the filesystem is mounted and
> > > > decrd when it is unmounted.
> > > > 
> > > > When the filesystem unmounts it should zap all the mappings (actually
> > > > I don't think you can even unmount a filesystem while mappings are
> > > > open) and wait for all page references to go to zero, then put the
> > > > final pagemap back.
> > > > 
> > > > The rule is nothing can touch page->pgmap while page->refcount == 0,
> > > > and if page->refcount != 0 then page->pgmap must be valid, without any
> > > > refcounting on the page map itself.
> > > > 
> > > > So, why do we need pgmap refcounting all over the place? It seems like
> > > > it only existed before because of the abuse of the page->refcount?
> > > 
> > > Recall that this percpu_ref is mirroring the same function as
> > > blk_queue_enter() whereby every new request is checking to make sure the
> > > device is still alive, or whether it has started exiting.
> > > 
> > > So pgmap 'live' reference taking in fs/dax.c allows the core to start
> > > failing fault requests once device teardown has started. It is a 'block
> > > new, and drain old' semantic.
> 
> It is weird this email never arrived for me..
> 
> I think that is all fine, but it would be much more logically
> expressed as a simple 'is pgmap alive' call before doing a new mapping
> than mucking with the refcount logic. Such a test could simply
> READ_ONCE a bool value in the pgmap struct.
> 
> Indeed, you could reasonably put such a liveness test at the moment
> every driver takes a 0 refcount struct page and turns it into a 1
> refcount struct page.

I could do it with a flag, but the reason to have pgmap->ref managed at
the page->_refcount 0 -> 1 and 1 -> 0 transitions is so at the end of
time memunmap_pages() can look at the one counter rather than scanning
and rescanning all the pages to see when they go to final idle.
