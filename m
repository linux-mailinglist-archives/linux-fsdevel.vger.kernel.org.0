Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70FA5E6EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 23:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIVV4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 17:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIVV42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:56:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0708B109779;
        Thu, 22 Sep 2022 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663883787; x=1695419787;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TF9ohMeOdxOMPU8wNWg0+uO+8siZDUoP9TRt2qswqGM=;
  b=YVCtePsdNdUSfWnpRqv4RHQQ5FW3aFMfYgmEK1tNnqW7HN1487fiOMt9
   P3wCOsgFLTGB5bLcMfsDpZ5xpshgLRmTM457zxRRP8zQvw6OXEn4L45uy
   BvUctomkPOLYS6NRPKYhuEnOOQTmAcwHerY8jh6N3PY4cg8h3L/Tfdw2F
   Jrv9mm0PAIwCUD4ZdKNkKMF/bpaVAH6UO90pjNVUivJGPlMu1grE4QOUl
   MD7bE46pcIp3YRFRWPHK6nVLCC6NsEmfCzDsLdb2d9byZDpRk/SRxop+p
   4MnYjE2fuzh8XUFmbf2Z3A9/Jrp7UYT9i8bxQVJPeKk+bQ352IjjkPQrh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301883635"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301883635"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650712718"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 14:54:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 14:54:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 14:54:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 14:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4sD3tzhetkJTXC+Y+SI9pb4PaN/zbzPlN7Qa0HNBk8RBcvSB/nk6HP/4v/LqHoZdzjr13M++WsdAkW8qLAO9CXVI8xpjGDta2UAVIVq012EKCQva9v6XA6BFSesVU7v81APX8Tgax13uaJ7XD9B7jYnp0OlOTn0VUJi76JcpkUNWA2pH5KxIrrfK9aPFRePIaYha1E3Mf98kbjq6zvh7A/zANVPbCombdXSbCqz0k3ju+HEP3A94Xmysblf78WA199GlNprQAFK7qyJDUDkLMK1/ARNSn3kYBcaP7rmZXJJRnf5aW4hlE5xRwKRcUIuiBt2CrxhB4k3lh50Gwsdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hickjYoSb4cp8i3n8hOMWQH35gIZl17oBPYyhW8xE8k=;
 b=nltHbLBknIajovejgjo74sdAkYF8eXcL5AWuMPJ26lI2kCLgmkUkx8vjGOb4UMo3NsuFWpKuMhQpmv/0r6GABt1rx3930LRtj5aQL+d7h1/ge9nRRPG/DUp3p3pwy1qlmfF5+zwtdeb/DsxPIURVrPyeAImF7rMf+8e/jGGKdM3xfwiAnM+FRuBJXkp+2rrjZmCHGzbeQb7uk5nvSPwoVhyRrCxZsJqWBscnj/ZTmPuNzh14sT2iT56Ti9z5xDmgRXUjG0aL5t6Yj2Xn3DErYNaoOBMY+caB04TMZupIYX2hca8DOlKxDq4tl/ZtjKvGP+UUviRxMnzoHGEvGETd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4676.namprd11.prod.outlook.com
 (2603:10b6:5:2a7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 21:54:44 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 21:54:44 +0000
Date:   Thu, 22 Sep 2022 14:54:42 -0700
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
Message-ID: <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyyhrTxFJZlMGYY6@nvidia.com>
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e638cc0-afd0-4200-56d3-08da9ce50f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8MAe3YfJib/tYsvR11rQsklxtGbJp5uYtSahxmP57deoYa8fFlJkEOkLikg2dqezHGtFaL8LDHASoSRBwy7uZXA0UOFXNPDt1ABI4NUjaUeD4cJEEVJe1zGkLddhZLxPyPZj1p5ve6O5oGO8M4+UwK4TXNQCZlQCKdnvwuW3PvR0jCSC+PkUVvnMFxGfWIeME5BQJOZuXhOZi869bdppUc2o2mD416Tbou5pcXLaNvJUpmFi9Idzs6/ouqFX6Sm67dh5iengJyf54nkhjPM0e0CFKT31GciG9Xa0/Puvjcd97DhrWkUqhwuiSdasySe8qtUjkl+MYB4N3HCZvXBD+YdgmI+Vq6yCW+v7B85EBZGXE9uJlPBFGtWGB1YphH+vPHCh8yVs0vwcc3AKtu3taomhOU70EDOL2FaDRwnIncJj5T+CB/jx31yp+cCUwTMx5V2X+QaaL5n8ZfI1+OCsX74HoTtfQ7w5zlvhw7vqxtRRmtfWjXQmZYsJaTywLCnRflaibrRo6gsLru5T45OqKP/QkBRzVlw5lWOKGEUMOD3aerLzjAuu+F7AeUcSbRAdtYLBmZYI9vtG0W6mu1ydxOLdTDaTw6Wuwbls7kdDdRUzLdJAhIlGKcoDIDVmeYJYlSItSo7ADW3xjjdB1BHK909jdUqkFud+sJB2hxbYozr7AcA9ts+Ri8wuTSasc72jjEgrRdKNEDjGjlBa18o8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(186003)(2906002)(83380400001)(26005)(9686003)(6512007)(5660300002)(8936002)(7416002)(86362001)(6506007)(41300700001)(66946007)(66476007)(4326008)(8676002)(66556008)(54906003)(478600001)(316002)(38100700002)(110136005)(6486002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SjVEZaLuoaxFGcixmOXu+D+H/8F1u9EX8E9yZUL3llbn9kpaap+arHS/+RiT?=
 =?us-ascii?Q?6GqHm7RcfTsyZFWmzcIsapd/vGzdNL7/i976ZoXTQJ0WFYhnvUpnKgJSf6US?=
 =?us-ascii?Q?OQqoWWr5QC8lcahNCCrwWYJ3PMM+dwDjCJr+zVL5Stu7WNr+GN1eCWwhSrng?=
 =?us-ascii?Q?K6hVitDGR3TZsijFJFsm4UuOOwnKBONsLTfc0dcqQAWmVls3+nxxhHwG008C?=
 =?us-ascii?Q?o+kqy8oczZq0U3CDQ95foLEqJxC39Ol40GlqY146nPP1dr5LZ/NW9v0Gmg+1?=
 =?us-ascii?Q?VJOMZaeF5K2zKD+2R/RSISVXuV9yX8prKPU2+4abxhi/uTekk/whll3Yrjv4?=
 =?us-ascii?Q?aF5xsDlPqvSB4Slc13puVf7pASfeMu+Hm032etNezT+8DcPfV9hItYlm4683?=
 =?us-ascii?Q?f7NMUyAPvW2gZeSJfApVO44xT+/Y3XYuRnwQZbT3Fy9J3oDFJo3GCtraW0Lk?=
 =?us-ascii?Q?3V0UzgTUPea4pQCsrJfZQuZUQP/tdTKrOfSBwkNsdBhbJwF2RcZFmTcYdU4w?=
 =?us-ascii?Q?rcj7y1qZ4aJOIk+D2tL6OR6vBtJmQ/IG4OhIGvA7CebQq4/5cTnGj4Sblktv?=
 =?us-ascii?Q?NIkP4B+pfTD/gojWehSV0tJLUaSdKst20+ant4hOwLQOsyhfNGRJUiLB6x8m?=
 =?us-ascii?Q?XOv8JX7egJcYKvatjIPX9hGOH/m+jxbAEExzNZV7TW8gogf83Z0HMoL0mzFo?=
 =?us-ascii?Q?kciIH3dXhUrj3S0KXEyZ2+xqh/osHSFEy1PsgM7xgp/Ud5yhXAwrAS/rZjXB?=
 =?us-ascii?Q?hDCk1RU/Ahi1GYVaV3ishiAXDD1wm4iSQOm8sUoDFfYR8DgL0Vns+SOJcLj2?=
 =?us-ascii?Q?PINW3rbyPh5wTQ3keCKBtiIKQgHNkZE9lmjjWFPzCYJY5LUWC1Bt19vuZE26?=
 =?us-ascii?Q?rBh4vAXNhxjKv+iBNh6lNkwPcqaY4viYpx9SX/SHqmZttkOxgVmz33tNn6Wp?=
 =?us-ascii?Q?Z6HgqxAiva0mGltnmjCHKiZfuqzY9dMQzWRt4/1LDS6QQJFeyn53wF1U6NtV?=
 =?us-ascii?Q?jGskkHgKrkTRE7tTJgEQpNMzxz06nnnKo0H0/2MHi8ui+dLH7KO30b2/cou6?=
 =?us-ascii?Q?kZcTm/9rZ0w+qqrY5OHV28Egwz1Dx3oMxvjXfK4nFZBWCVjOsrzozHAuex/j?=
 =?us-ascii?Q?yUZwD7nMBOC18XlkWKoBVLR1MAUnWNkQUQWiEn2IN2jWLGVMYUo3SPkEVPPF?=
 =?us-ascii?Q?eTo3ufQSwx7b/hzJcoRbjBNT0IwK+vwD/0Cccsi8ByA0j830lTHngbjbc9GZ?=
 =?us-ascii?Q?sC22kAMc29KwzpU9YRHtgxH7XBjGHHMP/u7JuJRdUS5eiGzlaPGTdUY+f6T3?=
 =?us-ascii?Q?H/CYH4+Dt4cNex9JF2gRD14BFCqmKf7p2cuKThqtIPNVJI4T4i7I3FDaiEXL?=
 =?us-ascii?Q?rzIemf00u11vYH6i0SluzetqocZVCtSsEEs3VSyeJbffkX3IMjQ2sGg4XEXF?=
 =?us-ascii?Q?JQ8MWxv+JNh5PIdyET1n47rCjbKtlO6kEiXtHK6FHrMbZwWR1lkfgWxJilac?=
 =?us-ascii?Q?UKuBo9iIsLvUPElCYptFY9MSemf0ymVUn3UcXv61H32YcJic4nXWWFzoe4sQ?=
 =?us-ascii?Q?xp4ic65eO+/fYpq77L+pfcGdKBf3wNClPa91UzV2edBHREfTGLiJg3CnppSE?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e638cc0-afd0-4200-56d3-08da9ce50f47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 21:54:44.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCo50yv28oDj6vc7UGfFBbbrgdiCpcu0G/dlLqrRjwNrigveLBnfZLcZBk/mW3fOikGt8j6rAwYldddp5Rm+4CLWXQwXrhWncwa+BKYY4eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
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
> On Wed, Sep 21, 2022 at 07:17:40PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Wed, Sep 21, 2022 at 05:14:34PM -0700, Dan Williams wrote:
> > > 
> > > > > Indeed, you could reasonably put such a liveness test at the moment
> > > > > every driver takes a 0 refcount struct page and turns it into a 1
> > > > > refcount struct page.
> > > > 
> > > > I could do it with a flag, but the reason to have pgmap->ref managed at
> > > > the page->_refcount 0 -> 1 and 1 -> 0 transitions is so at the end of
> > > > time memunmap_pages() can look at the one counter rather than scanning
> > > > and rescanning all the pages to see when they go to final idle.
> > > 
> > > That makes some sense too, but the logical way to do that is to put some
> > > counter along the page_free() path, and establish a 'make a page not
> > > free' path that does the other side.
> > > 
> > > ie it should not be in DAX code, it should be all in common pgmap
> > > code. The pgmap should never be freed while any page->refcount != 0
> > > and that should be an intrinsic property of pgmap, not relying on
> > > external parties.
> > 
> > I just do not know where to put such intrinsics since there is nothing
> > today that requires going through the pgmap object to discover the pfn
> > and 'allocate' the page.
> 
> I think that is just a new API that wrappers the set refcount = 1,
> percpu refcount and maybe building appropriate compound pages too.
> 
> Eg maybe something like:
> 
>   struct folio *pgmap_alloc_folios(pgmap, start, length)
> 
> And you get back maximally sized allocated folios with refcount = 1
> that span the requested range.
> 
> > In other words make dax_direct_access() the 'allocation' event that pins
> > the pgmap? I might be speaking a foreign language if you're not familiar
> > with the relationship of 'struct dax_device' to 'struct dev_pagemap'
> > instances. This is not the first time I have considered making them one
> > in the same.
> 
> I don't know enough about dax, so yes very foreign :)
> 
> I'm thinking broadly about how to make pgmap usable to all the other
> drivers in a safe and robust way that makes some kind of logical sense.

I think the API should be pgmap_folio_get() because, at least for DAX,
the memory is already allocated. The 'allocator' for fsdax is the
filesystem block allocator, and pgmap_folio_get() grants access to a
folio in the pgmap by a pfn that the block allocator knows about. If the
GPU use case wants to wrap an allocator around that they can, but the
fundamental requirement is check if the pgmap is dead and if not elevate
the page reference.

So something like:

/**
 * pgmap_get_folio() - reference a folio in a live @pgmap by @pfn
 * @pgmap: live pgmap instance, caller ensures this does not race @pgmap death
 * @pfn: page frame number covered by @pgmap
 */
struct folio *pgmap_get_folio(struct dev_pagemap *pgmap, unsigned long pfn)
{
        struct page *page;
        
        VM_WARN_ONCE(pgmap != xa_load(&pgmap_array, PHYS_PFN(phys)));
        
        if (WARN_ONCE(percpu_ref_is_dying(&pgmap->ref)))
                return NULL;
        page = pfn_to_page(pfn);
        return page_folio(page);
}

This does not create compound folios, that needs to be coordinated with
the caller and likely needs an explicit

    pgmap_construct_folio(pgmap, pfn, order)

...call that can be done while holding locks against operations that
will cause the folio to be broken down.
