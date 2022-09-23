Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA85E71B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiIWCCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIWCCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:02:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D041118B31;
        Thu, 22 Sep 2022 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663898534; x=1695434534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l2WpTaxc0IZDM2w1mXAQdy6TEj3Rz/9ynYmXQvtE2ow=;
  b=Mmhnag8WWQKlfk+IhhDf9+liOQF0wtmIjuDHqRRQQsEwMdFmb1Qhki7f
   MXsYeV28hsohpDB/XtAmL4lweQGyeIRxeVc+pFG76LrUwACiev9yKMTOr
   eQQZTiHkD2ziLp9Bow6FUchdjQUoVKCGSX2URWiQpzwkbNtp6FT8vfzyo
   J0ELm428pWvy2tKZ2z6hVsT5TMTvPIuTZ4vXckzfoGjyVH7NeExoZf7se
   g2jxMP034eaWTzv+448n9S78Nwy7LCRypX1DYBHQycrpUgpfcuBjIkqLP
   xA0bHVIZM9l9jj5M2zovhZ1oHqE0i+E84vo4aiZFfrf2CnJTl7rxq1tF8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386775524"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="386775524"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688550786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 19:02:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:02:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 19:02:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 19:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J61oToOg/Zfv/AHRXKsg6U7NGm1SGjIzBH7kBSZLAHUu0+2tMbdDr+iJD2MoHYEg3J1Dyln3BRu5G8l/7OSd7fbv+OQQ/6G840SbnZgTOxLfZKxzWLc+GjBBKdlPPrYXDbrItQujPV8cWdr5Ym+4rzzYWAHS7GxMqT2J5kMAAQJ0Edb9P+a+4oSs4PDuxcV8asFtJUcLGGrlWclvll8PlNWNLjM44Afs6jFiGueTGXJ/V9xqQeRn/Ldl83HpYwT744oS3XAtaPAFsc6tDOKm3rxBx2dzFCeRJOABMKji/SWTYQRCXYQrukpKx1wqP5qV1UCuOO3aVQAjDvgzpQeGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5FmAcqJh3W05kne15p7/hGdb8iOzw5GJ2lmFFrur3A=;
 b=CQ7tvUifQKTcwOHWxIv+AMwuEgQmwCp3Knt2Pksodq3atzAPUVG2FOg+xobCPKa6XwME1B7P8t/bXt6kgAyhUQw5dvzl0DT2oE2GD27hugvtv0gc/fBlpqXo+ZEc7Fe6NW9I2n5ojMWt4Fm5uK9qM4iw2k3VjOa6zQV7s5gCghI6vU1FscE48PURN5z+g74LKped0KFrU0Mo/1OunJmM817RQYSTG+J7eXbu+yWyqlBJjbBJZIpk1bQknzswGixLVlRcTXrDwn76kjeBcSZjWr/Ag4AYgucDr8xv51RoPdwbg9WtwrLQHBdblMsQJv0AJt5X8Bns8w/hNvO3ivb5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5037.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 02:01:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Fri, 23 Sep 2022
 02:01:59 +0000
Date:   Thu, 22 Sep 2022 19:01:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <akpm@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <632d13949e113_4a6742947c@dwillia2-xfh.jf.intel.com.notmuch>
References: <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923013634.GY3600936@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220923013634.GY3600936@dread.disaster.area>
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ebc668-bb77-4956-24df-08da9d079982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS/Bcl+5npKrHHoU0/paJ3BJug86c4aSthfgKRq85R75kPuDPgyLt2dzE8W1qsd9APALN+E5l8MlEAIXnu5F5ZK0IAKe3Y9uOKorhESBv7mDcoG/3qcDcO5PaBeKQ3OzbngOYhnp2vUy6+XQAbuzMmdcbjTkDAduETcTlb0uVDhKems00SYkvvQ5LjDbH4ZVY1i3xiZC8IJ7PuEJGkdtP8gFDr1CoynQqR/58bPswn0WasxdTeNQVdZZK4ProCsR7zQ/dXxYwcF2DfPn9bNWdC0mPBp2NNRxiFMhosNA2LRK0hHQhvrUb4hmnSV+FANBF/VBltfWemG4qAjVOSPoE2Ly6CjhpPXpq7e7nleO58UvCJUnuIKbcccS55M7slZaNe/7a9WghEkNOT6IIBZy+4nLZNMxS94sDHgocOoSdzAXDdvEO2ArMXf4kWTBpFtQdAfG/+vJVJKL6iVMIcKMbx42/AiIChxWp10r82aYLqLvKdxB+742FTwrCYsSLmFzYd6NOWH/MxONmaOsBSRt6XmfpqUfUa2TvBZUIWyJ4l8TCRIYbFQtTnJ22r46yOUSfo/QW9EIgA3OEJxsEpnTVwU4r5kK61Fpg+8i16kwh1fsB+F3eDmkD+IykU0TmocvE373q4ptaRMjY2Wk4ewEpuV/hfVo8BLILySAWwWFu36+U4YV3J5LX6t9BlFq+E15xqvmFmHOkjGzyDWbBJ+1kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(8936002)(4326008)(82960400001)(66476007)(66556008)(66946007)(38100700002)(86362001)(7416002)(5660300002)(2906002)(6512007)(6666004)(9686003)(26005)(83380400001)(6506007)(186003)(6486002)(478600001)(8676002)(41300700001)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roG1sgajdMGWo26HCP2/eC1dxpk2lGJGzxsl2ZT4nbMrnfH1JrrnOaAUTHhH?=
 =?us-ascii?Q?bDoYXwziyAGpIsmHAZkREaLVFr/iJXs7szS3O8wEUqCVkfsbmTtFVn+xVHJr?=
 =?us-ascii?Q?9IMwM5oHwe51+zLuhn80nypulC9qAlarwdc0mUVwoBg6x2h0n1uh+BSFp4N2?=
 =?us-ascii?Q?Ag8zuGM61X5y/pSFCyORYRwiiF6SPfbuheAI5y1mEsgDgag4WrWKkTb+UJUF?=
 =?us-ascii?Q?60OdPbvkEFgEX76MBCG5N6mkKwRUzUGIVtu66WaEvHFgcWH531Hj6jn4PWp3?=
 =?us-ascii?Q?9W8bHIXxRA1ut/PMrNajPTw5QPdlEFP3Jmx2AuZ3ab7U1gDF//5w6mVijB5P?=
 =?us-ascii?Q?HDq++5K3M5FU0RwnZTB6dLpQ8NlqoOCFVWJQt/keXkJIWr6PLgBFwKR+jZAS?=
 =?us-ascii?Q?wDS3p98EHvTThd3JAQR6l3QevRbd9zxq0t2QRfaZcShVjhKcLl3ux1MngOdv?=
 =?us-ascii?Q?042RtWBSorhxg7RnfG1A1qQAGgxZZYLi//CSmGS3Rh0brYJsrFrB/IbR+0an?=
 =?us-ascii?Q?V8DsP9p+5YR0fRBkOjv6wdzDg+DWV/szhnmfLtQO1D+vrctfAN81lJYQ5AKH?=
 =?us-ascii?Q?YQ5WzLHhB6fBA7CRq03eKFTmFASzVr/eV9tLwQCiV6roVEUzBDuunaLzynn4?=
 =?us-ascii?Q?ocT3ktE5hLYQYY5jO6mN04fUuOH9RYnX4Iynlr7026yBxeYIFgzCsVa/h5B8?=
 =?us-ascii?Q?0E6GY+IlCGW3PdZ6jqyjg+9HrLtIUmW9/lDBL47KxpZ/P4J3xyq7h0UFUOa2?=
 =?us-ascii?Q?DndLF20o6N6dO5LN54nzSsV6GhWjcXdFjyAwXnFo+uHl1A4AznaKASnG6I6X?=
 =?us-ascii?Q?HnIiHVpeoNLZUGseoMCuzdR5Z8JJqlrvKjcz6hoib8gyrH0j0SMSMoAwXW91?=
 =?us-ascii?Q?FVlrEW8onqd91E3cp0ziKApevkIPiSqgOqprN3CiA3rKekE23CA0nHilqtZ7?=
 =?us-ascii?Q?4jzRr7ZGQyTRE80Prw6LlPUHMF+FNDfQ0gg9PKJkqJyaYeJLNeyGBvSbD9N+?=
 =?us-ascii?Q?WWxtBQEyNVbptJaJAIGQKyj5E81kCfu6KelhxeTgCwi4ufmG+TRbX29LFR3M?=
 =?us-ascii?Q?RDtfUATww4XLD6e5k47858vxjSjFTdHS4uwfvZi/nTIdxZ8mFu8jD6xWEbwG?=
 =?us-ascii?Q?hZ9iuizHbSTTigIS4PBdvVRBrMooqZf7lp+JNJ5a5KIAFsfGRghXkF1/g0jz?=
 =?us-ascii?Q?AtnUxuAi4H+5e03PlJIyjBGI28Gvojchybzfr3S0B45PnaBYyw8KfZW+Etux?=
 =?us-ascii?Q?oxgznuMU11GP7YsUefKyAiQlV3wML4nKR7SJhraBm5CcsF4M267mt+SqYd48?=
 =?us-ascii?Q?ifNDyjDT2395b561I7DwJpMSejFEGqQKYaEXx/xOifXyD24EiA7XWtesvaIv?=
 =?us-ascii?Q?GBAZHBl3iKiIqxgzG+VD+4ipP+/8tph5kxk8X1WJk16yJK55zDpDJxhS1O7k?=
 =?us-ascii?Q?PFHyBamJh9ZjYolcTD6hTHmHqfzwVHzhbwGpP9BeONd8W5s00LZ8axdDjGeT?=
 =?us-ascii?Q?rHLSomp/u4xBcP7l/fcXoswK1z07qr+SSBb7LPpbj7i0ERj2+C2aL0qFcoH4?=
 =?us-ascii?Q?Efo2OXyp0YMCU4VHpMBkpJYhl7MjXjp7ynKDNcqsIFjkwm89ZQ7M0E8hCa6k?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ebc668-bb77-4956-24df-08da9d079982
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 02:01:59.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvgfUVQZY8JNQzKBVESJqovBLYLehW0lowB3wewpRJDgp6dyWWGaAzSAnyExyllvOqjCmYGJjBawphN/weNAVERhQlo88f0yZHXV4EPh9RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner wrote:
> On Thu, Sep 22, 2022 at 02:54:42PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Wed, Sep 21, 2022 at 07:17:40PM -0700, Dan Williams wrote:
> > > > Jason Gunthorpe wrote:
> > > > > On Wed, Sep 21, 2022 at 05:14:34PM -0700, Dan Williams wrote:
> > > > > 
> > > > > > > Indeed, you could reasonably put such a liveness test at the moment
> > > > > > > every driver takes a 0 refcount struct page and turns it into a 1
> > > > > > > refcount struct page.
> > > > > > 
> > > > > > I could do it with a flag, but the reason to have pgmap->ref managed at
> > > > > > the page->_refcount 0 -> 1 and 1 -> 0 transitions is so at the end of
> > > > > > time memunmap_pages() can look at the one counter rather than scanning
> > > > > > and rescanning all the pages to see when they go to final idle.
> > > > > 
> > > > > That makes some sense too, but the logical way to do that is to put some
> > > > > counter along the page_free() path, and establish a 'make a page not
> > > > > free' path that does the other side.
> > > > > 
> > > > > ie it should not be in DAX code, it should be all in common pgmap
> > > > > code. The pgmap should never be freed while any page->refcount != 0
> > > > > and that should be an intrinsic property of pgmap, not relying on
> > > > > external parties.
> > > > 
> > > > I just do not know where to put such intrinsics since there is nothing
> > > > today that requires going through the pgmap object to discover the pfn
> > > > and 'allocate' the page.
> > > 
> > > I think that is just a new API that wrappers the set refcount = 1,
> > > percpu refcount and maybe building appropriate compound pages too.
> > > 
> > > Eg maybe something like:
> > > 
> > >   struct folio *pgmap_alloc_folios(pgmap, start, length)
> > > 
> > > And you get back maximally sized allocated folios with refcount = 1
> > > that span the requested range.
> > > 
> > > > In other words make dax_direct_access() the 'allocation' event that pins
> > > > the pgmap? I might be speaking a foreign language if you're not familiar
> > > > with the relationship of 'struct dax_device' to 'struct dev_pagemap'
> > > > instances. This is not the first time I have considered making them one
> > > > in the same.
> > > 
> > > I don't know enough about dax, so yes very foreign :)
> > > 
> > > I'm thinking broadly about how to make pgmap usable to all the other
> > > drivers in a safe and robust way that makes some kind of logical sense.
> > 
> > I think the API should be pgmap_folio_get() because, at least for DAX,
> > the memory is already allocated. The 'allocator' for fsdax is the
> > filesystem block allocator, and pgmap_folio_get() grants access to a
> 
> No, the "allocator" for fsdax is the inode iomap interface, not the
> filesystem block allocator. The filesystem block allocator is only
> involved in iomapping if we have to allocate a new mapping for a
> given file offset.
> 
> A better name for this is "arbiter", not allocator.  To get an
> active mapping of the DAX pages backing a file, we need to ask the
> inode iomap subsystem to *map a file offset* and it will return
> kaddr and/or pfns for the backing store the file offset maps to.
> 
> IOWs, for FSDAX, access to the backing store (i.e. the physical pages) is
> arbitrated by the *inode*, not the filesystem allocator or the dax
> device. Hence if a subsystem needs to pin the backing store for some
> use, it must first ensure that it holds an inode reference (direct
> or indirect) for that range of the backing store that will spans the
> life of the pin. When the pin is done, it can tear down the mappings
> it was using and then the inode reference can be released.
> 
> This ensures that any racing unlink of the inode will not result in
> the backing store being freed from under the application that has a
> pin. It will prevent the inode from being reclaimed and so
> potentially accessing stale or freed in-memory structures. And it
> will prevent the filesytem from being unmounted while the
> application using FSDAX access is still actively using that
> functionality even if it's already closed all it's fds....

Sounds so simple when you put it that way. I'll give it a shot and stop
the gymnastics of trying to get in front of truncate_inode_pages_final()
with a 'dax break layouts', just hold it off until final unpin.
