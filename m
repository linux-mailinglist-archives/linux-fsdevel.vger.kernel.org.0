Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE815B0B30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIGRLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 13:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIGRLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:11:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A4BC128
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662570629; x=1694106629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WFvm1tv1fzBz8XQhPXEux6TiuRxGptTMjrd3F+Y7Jig=;
  b=dklyF4KsyJICpNDzly5oBxTIHpU+cGXaq9+oHcS8TfOhAOhBT+vjJNEV
   f7n9D0zHqTToKMvjimwmUW743sqood71FpNiO3hcvFRdPoeklUz1TKa/k
   C8/vHOyc/pLPqOpQDTjAnWvyS+T6wVWng16xDBXkcB2vFEhU5b+P5p9Wz
   FIwYdk0EwXa+mU9s5EgqLQXnwHwoSeifrc7Sg9RI5Q92tUJthmMWFeo9O
   XiOR5+FaIfwbXmyDL0UuL0OBvXJ7xCISCtmMivGIB8TiYyzeuZEhFTWw9
   aWJB1cnIK1n+i59Il+LbJhpRCJsn4ZS1sBGjinQUrqH3prv/b+Lum5tpN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295676340"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295676340"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 10:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="591800451"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 10:10:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 10:10:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 10:10:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 10:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZYL7urHhRqFNWBrDkKMOH8UZ6VzqcOjfYSJdEyZw3CAiUlPf55Ny6IZ1D2NH17Uqu21GoFxwcIynKHTJnZApcLBHrHffIds8zo3XXYZzWxB+AxltlSkvVul2zEK/MtflS5ijOaj6AKR/cWwZZPA5m8347FjMmAey+dAoLxfvRlFUhPVIrxN14Kd7kOFfCe6FXDYWraIrhMQsM8JXlMloWwM2Jc4dozugNC88S5GfS+hFHxnqC84D0UQc2eq9UWbq84erQsiCF3Rs7oeO1QpRlOB4FnUxKwXUBJqY3wm0B80EaNtmjYt5Ajpdm3sZBmDan2ucmntO1aoNcBZAm0P+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sGQzEzRxSOo4sjN72Er3H5icXtaWif1lwLEVhp5W4M=;
 b=W+hE6GAFK8JjY7WZL08mUBgyUZ8ZVXfJY5V4qZV/vCt4szwq7g0cE1jF8pip4X3C8yp5z3zbZC3f7PFbmlthVWqCnEpocKnypjhZUxEIbp7Bp7jLakl2l8ezp5eYK78RENO7RhipBSjwOfACN4C8zmcJlXlpDCRZjO0yo8/pqWkJimng25Gn8jUF8Rvwg7pPRkoVpbv6sI7+2gPEq3+lKfUEibwVhu2ThlnjajFl6kjYkc91+z89Cg36sOKaX/mR0Ab9UyInZUmwMq/lt3AeBLGs5Gu1lz+3CkeSebq7eroVB9nXKaFnnvaBDvC+QFmy+b2zgZs+uGX32ddgskwe4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB6501.namprd11.prod.outlook.com
 (2603:10b6:8:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 17:10:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 17:10:25 +0000
Date:   Wed, 7 Sep 2022 10:10:23 -0700
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
Message-ID: <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxiVfn8+fR4I76ED@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4859d6c-23dd-48f9-809d-08da90f3db02
X-MS-TrafficTypeDiagnostic: DM4PR11MB6501:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMahDNyzW0d8zm+lf6vTPhYiMttL3BHFZlAAUx7T+gfPnwMTTsIH44JhzuUZVMf1NiYk3CUj7TrWPLUhMoO8TiO2uW3FpCQmi29MhdgJ5mE+EmHaoY1TTZrjOcFm6HWISjVOBOxpdvv/4Dv1Zht2iG9R1WKAqzNHaLHTnc18BYEItrO4a/k2VQUOQq3Fm915+qWkCOMJ8+iPG/ttOd843EvvDVjplDWXEzzn9XUaRJC4SB12g/GuHV9xdG20NMr/myD26f6jLRViGB1I+qzY69oCnbc2jvlHbvz2CRMxwXSmGPmtIQt0icTAW/NRzj14GWPHUrSI4XRDV7R2vvKgi5PPiyOe35Fd5WYeHk8lzayajZJ++YNqjvrFYkCSynjVv7hcaRKr/hCNLBQ/duubD7dJp3LfhRABt+9dEfJlz0k+goOTPyBIYDShRSKiLv/KNVHJ2j5Oj+HorB5W0xVZe8UxTn9NQQRdPS2noj0QY3SRNNBm6rdTSyHEFBpuOJaZw1ntTegLRyFu3u6qAWWCRSq3N/TgMHhtAWJxpbasgmygI5zOHutFF3OO6S0OGmQ8O4adFVcl1y74QatRIzOjYZKmYQD+oaNrNYvws27t09ei3/XzdFUTpDXhV+N/ulGSlC8ZBZ7Ko0V6w7UmiJmzCvwhIKmFuCYR6FYcVTS1qDiL7kXzmQqaxWfdx+Pp8wfcWMAgRDvwg6/Z624to4X1UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(366004)(136003)(83380400001)(66476007)(8676002)(66946007)(110136005)(54906003)(66556008)(2906002)(4326008)(82960400001)(38100700002)(316002)(8936002)(7416002)(186003)(41300700001)(6506007)(5660300002)(478600001)(6486002)(6512007)(26005)(9686003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIarxb5Gpc/CviUEp5rHPTigqXyHG3vHA7woe+WMNwh112CrTbfXYiqdiSSO?=
 =?us-ascii?Q?vKq8Cp6a81Hmf0yWJXeZEs1SMmIZZjZWAIEKAvP/yZe8Z9pxLjtkObsBqOMh?=
 =?us-ascii?Q?dR8Ogz9+RrWSdaRhpF0BOIqTaWMpWiV/5+MhFk0GDwbNTfArn6PnfnAus0Ob?=
 =?us-ascii?Q?sCsUTDXEDj8YkNNvsfgmxxIFurzTkb96wssMJd5lxFCjYomvH+nrK1lEp30+?=
 =?us-ascii?Q?K7cg/yM9CZ8VnsMJYq26LkMeoSePg3hsNy8jMqzRYz3Mm5afYb/QiPC8jvDZ?=
 =?us-ascii?Q?Lo628r9AnyPjFqoZyvOY39Q0TbqII6uhe0RVP0rl6/SwSUlOP0q4ABG8qfwJ?=
 =?us-ascii?Q?GCOUyHOraML5ByU6m+496H+zJrEJRwX5CcBeqYAl64aNXvMPok11hev0jyWh?=
 =?us-ascii?Q?4gHQLAdzBADreDUsDyhvIVTd9q5q7foyzHZ8LGawjLoFw32aMMZjfNkH0jND?=
 =?us-ascii?Q?GfcLmgbnIVvZFjxXfJan7dwbhVCyqU4cEWGF+XNqpU2TX2BEVXVlO6mqk43D?=
 =?us-ascii?Q?DFfV5QvWF9vNyM7mswT1mY76QDh3DnyFw5bSGfeyhRCZPC9AumtMk4/3CUlZ?=
 =?us-ascii?Q?in4KNuG5zJ9JR3U+Vx5jUEwKfuCaXg2AstLXCfrJmsDnnIDpctnNNAZZl3PC?=
 =?us-ascii?Q?cgMtUCv0lvLVKRmwDiK+r9zKDIHAZEfs990z7wdUFgjtMl+fJYabKZK+XkG5?=
 =?us-ascii?Q?OMozVCwDxtwrEOD/vNigqi/0HjSiJrN2kVaWt/G/DoWyONm+8RPc4VOnHopU?=
 =?us-ascii?Q?dPW3fgl1tEA/o9TUK1hUrf5EHTrJQggyLbELb5mbPyUlxMHWbqsSh23+bxIX?=
 =?us-ascii?Q?7WjRB081QWHFvxAJRIL3C5mJy8tWIuwfokwifD2kZyXNKpLOoLbPRROmw8EF?=
 =?us-ascii?Q?IxTKUBylv+bgjEeV94fWBfeENZPuj0fiewYLxl7eKNoN7q7kIoPdd9GEFfxl?=
 =?us-ascii?Q?tRzT6Ua9nBZHoaeUlsnxT1uqm7JHMQrTamvY+GAeUcf3B4V+Zpn6QlKTPxoY?=
 =?us-ascii?Q?6DhTz0eFw9xrOr/5sTpels96ZbjWgly8rHVSfQkFD9UldnA6NyMSwCx4xLQA?=
 =?us-ascii?Q?EcTg3I33zrdeS0qXH4WzDFCfLLw57qXf5/jenoxEKiFYvADelwERyYcpJW2v?=
 =?us-ascii?Q?U2tB/cO7e2CswMwHtV8hh84bp9niRe93ZC6tqBKbQy0LdnFCFS5ZKw2Hgsc4?=
 =?us-ascii?Q?p5K0lsm0KRifFzeL4VZI9T9gM6oC619uKM6BNm2JdjlRF6ByDEimvgZG4lKe?=
 =?us-ascii?Q?nMq7sNkczdDuRgqwk04Hr03iWNIY+3Lz57ALKHB+3H4QyT+3BT5hCSvQ+xTv?=
 =?us-ascii?Q?lZgUUBWfQgA68IgxuZb98EjwxTA/XIx5/XsxozrpCDPLHPlFlAjUKPD7Hl/O?=
 =?us-ascii?Q?zTdT8i70mMoKfHP3K0zOubmve8siWA75jv9Lwii+04Y91C3O8iufzY28fTsH?=
 =?us-ascii?Q?rrdtjhjQMonOne/cJr47lhtfl0voJWRWFueBOHQcBfGn7Lsu3H5hFYaT2/iW?=
 =?us-ascii?Q?vpRyOLkHToajJaDKjo1MflKP47eFgu45Jd3mtDCIIhKPaJeQgTyc1d2hs5VF?=
 =?us-ascii?Q?/Hi0gnVieB3Hy+miIPSrsWFKMrNKo95gAVmwGsd5AYaSiPVt4brNLcW02U72?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4859d6c-23dd-48f9-809d-08da90f3db02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:10:25.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whMO5GKhNhHhMtWa4bzQfSTVdW5DEuUKfo7imAs6Ble5hwaC2s3giTRsbz52f8T3OMsO4VqDQelMCfshsr2tQ9erT37IDEE43FCwalUsHS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
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
> On Tue, Sep 06, 2022 at 05:54:54PM -0700, Dan Williams wrote:
> > Dan Williams wrote:
> > > Jason Gunthorpe wrote:
> > > > On Tue, Sep 06, 2022 at 11:37:36AM -0700, Dan Williams wrote:
> > > > > Jason Gunthorpe wrote:
> > > > > > On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> > > > > > 
> > > > > > > > Can we continue to have the weird page->refcount behavior and still
> > > > > > > > change the other things?
> > > > > > > 
> > > > > > > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > > > > > > first.
> > > > > > 
> > > > > > So who will do the put page after the PTE/PMD's are cleared out? In
> > > > > > the normal case the tlb flusher does it integrated into zap..
> > > > > 
> > > > > AFAICS the zap manages the _mapcount not _refcount. Are you talking
> > > > > about page_remove_rmap() or some other reference count drop?
> > > > 
> > > > No, page refcount.
> > > > 
> > > > __tlb_remove_page() eventually causes a put_page() via
> > > > tlb_batch_pages_flush() calling free_pages_and_swap_cache()
> > > > 
> > > > Eg:
> > > > 
> > > >  *  MMU_GATHER_NO_GATHER
> > > >  *
> > > >  *  If the option is set the mmu_gather will not track individual pages for
> > > >  *  delayed page free anymore. A platform that enables the option needs to
> > > >  *  provide its own implementation of the __tlb_remove_page_size() function to
> > > >  *  free pages.
> > > 
> > > Ok, yes, that is a vm_normal_page() mechanism which I was going to defer
> > > since it is incremental to the _refcount handling fix and maintain that
> > > DAX pages are still !vm_normal_page() in this set.
> > > 
> > > > > > Can we safely have the put page in the fsdax side after the zap?
> > > > > 
> > > > > The _refcount is managed from the lifetime insert_page() to
> > > > > truncate_inode_pages(), where for DAX those are managed from
> > > > > dax_insert_dentry() to dax_delete_mapping_entry().
> > > > 
> > > > As long as we all understand the page doesn't become re-allocatable
> > > > until the refcount reaches 0 and the free op is called it may be OK!
> > > 
> > > Yes, but this does mean that page_maybe_dma_pinned() is not sufficient for
> > > when the filesystem can safely reuse the page, it really needs to wait
> > > for the reference count to drop to 0 similar to how it waits for the
> > > page-idle condition today.
> > 
> > This gets tricky with break_layouts(). For example xfs_break_layouts()
> > wants to ensure that the page is gup idle while holding the mmap lock.
> > If the page is not gup idle it needs to drop locks and retry. It is
> > possible the path to drop a page reference also needs to acquire
> > filesystem locs. Consider odd cases like DMA from one offset to another
> > in the same file. So waiting with filesystem locks held is off the
> > table, which also means that deferring the wait until
> > dax_delete_mapping_entry() time is also off the table.
> > 
> > That means that even after the conversion to make DAX page references
> > 0-based it will still be the case that filesystem code will be waiting
> > for the 2 -> 1 transition to indicate "mapped DAX page has no more
> > external references".
> 
> Why?
> 
> If you are doing the break layouts wouldn't you first zap the ptes,
> which will bring the reference to 0 if there are not other users.

The internals of break layouts does zap the ptes, but it does not remove
the mapping entries. So, I was limiting my thinking to that constraint,
but now that I push on it, the need to keep the entry around until the
final truncate_setsize() event seems soft. It should be ok to upgrade
break layouts to delete mapping entries, wait for _refcount to drop to
zero, and then re-evaluate that nothing installed a new entry after
acquiring the filesystem locks again.
