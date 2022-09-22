Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E95E56E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIVACu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIVACs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:02:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B317D1DE;
        Wed, 21 Sep 2022 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663804967; x=1695340967;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t/yB1xwHU7aUuz6j4yKbOUNz6+N7TSY4jiiSVbQOGko=;
  b=Xuax5p1Mh4ibV5Dq88YFwLIJlYXriwhgc9frsuUQkmoqEiYcj1kS4icJ
   gf2/SY0k9k2Mn0Li6eAgHNfV8uXyuTN9Io7qVIJwvPrbIdu8f2Bo7sqT/
   +5bUmJUbyg34T+1RqXJdMcGXtechsNx/ka0SVGgxc+JUKTIk9gfeHZ/fB
   oj1gLKCzPw4zm7n2D3rzSmMVKVzkjAQRM2Yzo7Kzz2ihiq2prXFbyhOvw
   4/tdzhYm8KLFAA4swbIeOIdLNvkf3PKagA08W2wu77j6djmxlZTbCtXgA
   KBmLjZV7i6GBBMkR4UM0p/mJnr8eoTYGlbTxVpGm8Edt2+D+C/C+eXeKG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287232966"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="287232966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 17:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681989784"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2022 17:02:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 17:02:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 17:02:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 17:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb7CL74zHg3qP3bLZGat2qXi9kSwzg7pyTAPOdxp+3OQ4PQL1FeZdvH/XzF+IQ04A8/U/HpB+q9M4wseZCJqS0DuQE+8qM5DpTYC8F72ea/Jhl7pCOP2pYOTmBifAK/qHO8lYkf2EI5NB3bi6JzwZf7xNzj6idjkdyyFtLy/nHRmOicEXCFv0Qmw7rpzbOWsVxDoTJcSjDu3U3HEZrWZMD4Tzn7n+yMd5boaiX6oOBy9dQOq+98ajb1qHb4OTZwWgGP2xyIMp+M+QJzAJROr0/LBrgYMxZ5T53XitrclleEeaOXSmz33hQNlUDgxir0vd3oz/yqNYOag/IKO/cY7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az2kfvW8tj57ZFtV+plyaVfk/wOx4xeGuPbNRqzRAcs=;
 b=FS5oKV81H9KI76rzrYH3m6/mG1B5pAzRlP2RNm73s+lxRp1n0ICw3uS5oei4DPrM0bhF9kBE1Kgb0//ZPfQYviomP02RQBZXIkJJ8ybwVO4SXCuu6ucnoH63WeOmsJYv2l1wzuIJGHkoQSRWhFiolFHoT8j62K70xFUjRPrJ0PnRDl/7B+SGzzZNrwKcPyD7MsgtryH1UZia/91VInKfn/PZQ1hI5T8d8QEyhL28kKZQWspq6oApn15M6PEajLTl/yTqoDvDP9BdXL8IdbhWiTrrhGBLyfNhMi2QFCMVD0hdFGXqz3xFlHsxEFmvN9rL3I7XWQKWc86SNFJj2dnHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB5991.namprd11.prod.outlook.com
 (2603:10b6:8:72::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 00:02:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 00:02:40 +0000
Date:   Wed, 21 Sep 2022 17:02:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <632ba61d7666a_34962942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220921221416.GT3600936@dread.disaster.area>
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a2380f-8932-4ef5-f80f-08da9c2dc3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shZ97WHgIJgEvLz2kwoM705a+UyxkzTxOxa/9TSgn3b2JVa5gmabBVh4AwCJkUqIUm4nrZ/OxH3TpWY28xX0t2A8hWh//RPsLJTAq1FRbJWlI1XEA+6QtJGwrzwW9913VvyTLxrhtgaHK4oFj8fq2phVWPjLBISutCZ+WxKChyZEJLNst7BwnH0Jv8LCyWDHwhLRbnBgmfpVxe9TrfE+zG0r94OCTlVmavxH1ohajUafkyXz4a1JY7EuhUTS4eO4tf+dRaWARJpYznPyy6uX9SXBZGvTx4kNmwZHxbF0NvIMKwgf2I0MSE1nkkAeIYwSXk+Q5cSYx/oQPVqwnCJmDTzIimchYdnkXWui3FcJQFE4yW3cJ2UpeeOKy8Ygp8KdkuJ7kXSlbUZwSZGfH0R6ZFcC7ns60GHaa6Z+8g2aHSR50IQGLWyg9QiiZTWddNpjiZltjiARHANyoytUtcpbHPWn9N0c/DjcmhGXLx6pC+4Itzk8X1vqtSbTxPyA2x+CFj/xwQF/lqRK/87Sx9mytpLfICG1AX6nRn+Bgf9JB9QUXeqE58/jBZL/ap+gFpi9hfOrVg9MUq0UYIj/DwdhlL8HIy0sYVFJWDixWLxmiG07v+4N73ax53dIPe6UWCVpYwz/lwfiW8UpBcIX0fV7A10ctiBlYr6+7YnZaCHqo5uURFQBXT504HiawIhW0PsUd5pFrOKO8IItk0/FJGgEbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(2906002)(38100700002)(66476007)(26005)(66556008)(66946007)(82960400001)(8936002)(86362001)(110136005)(316002)(186003)(41300700001)(6666004)(54906003)(4326008)(6512007)(8676002)(6486002)(9686003)(6506007)(83380400001)(478600001)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/p0V0+qJQXPQMeLMOwNTdUqJlfElmXoflFG4ay1c8kIZcvdnKb3IaDuolUN?=
 =?us-ascii?Q?y3hZpE4gdIYEHAfotubgUkPnB+dYfN5DxVgU6nGiC/g9I1xEoL8ZzXgz1lbZ?=
 =?us-ascii?Q?vhMrAuoa8Ul7ToOmRD+n3aIul3yanEn05Lc5pJ9TLWoIfiV3muYrDSGSS5Sp?=
 =?us-ascii?Q?n0fFJZp7luR6k59NeANDdcua8AS8PbFwS2y+vYdwVZKe+wwVT5ze5eafstRC?=
 =?us-ascii?Q?5KScZLw1O9Y4FGH+M1L7jzVkty8IeTgNeEG1cqeBJbVxMckJhpLnqDXMms97?=
 =?us-ascii?Q?GOWR0xYR9hNo9jnmIHad7zEYqs54B0nBRfcRf2Nmqkw2VJLHveIBpzJ2fTyX?=
 =?us-ascii?Q?JyQRmCWoULmVTDZDgWo+oZLbtxyhBYiC9Q23uRJ7vqdKruRaOJi1MUeXMXL7?=
 =?us-ascii?Q?alE+qkVnXA87FXthIotVhzKZEuk1i7ZChBvAqfrF70xxTJtqDccsE7oTW8YE?=
 =?us-ascii?Q?ZOewxGJeubYmruH/Tunng17RGGshwbL3kseYoPKasvrESePBdGKFnldfNR2t?=
 =?us-ascii?Q?RBfyptDhqLiPW6qFcgvxkYryOAGqDK7JD/EVC3QktkRvt5rV1E5U5CzOipIw?=
 =?us-ascii?Q?+38a5Qgjxz80awXdU/9RTdVacOkyJzpDJYTTDH0SOtOv9atpduNmQAy7l9aj?=
 =?us-ascii?Q?Z7C3oPOLl8IlqzzPf7GbDfKhgoXg7fzF9ZBlVpwaOkFyp5Avkz8LEerEZ1Ig?=
 =?us-ascii?Q?oboEONES8bT70b0gqDAiRu1TeI/dgSvt0ChkKIqaEGZWwRNQJu7XPrhu2C35?=
 =?us-ascii?Q?6RTS0MMQONhDfG5xYmWy9tXVahqHEPQMRwWWAPltA++d/pmcQpQGZNZLqmCO?=
 =?us-ascii?Q?jruG7Rkf6D9p+ReExizgWJbmqFBd3nU2u52dd06SDVQHm9Q+4TROMr8GD2GP?=
 =?us-ascii?Q?V2tRTg1Z7vSu84an6igStbam/o4LbzRRKGPDKvee9kFXrpicC5YIvPH5HcFo?=
 =?us-ascii?Q?yitlkoo90XK8s2gmILbmP/TQaYXKjl5+oQwTCnR/2rkUosnu8nY8tCuGlQfP?=
 =?us-ascii?Q?BlDkvSQV5G7eVVcnbMyR3RHCWBgUdSdkigCGG3triifbbHkkh8EfDCmps58T?=
 =?us-ascii?Q?x+HD9huyUwnp+4mq8i6RFHFQGzfjsP9xYxU4HyZ+8itCaAWnyWajHrzLvZPA?=
 =?us-ascii?Q?KA2Hyf9WSVhbqQXYwAuqXcb3fTPSENByO1Y8x8Pn3QoSi/0ivxiak7JWGm0q?=
 =?us-ascii?Q?m0eRJgP6i0WTLbg+SK3hxzkf7MWpKKHkudPdDI/yxrlxrO0Rvy4sZiPfcb7+?=
 =?us-ascii?Q?apQymx8L6S0tfms8KanLUJFzAJ+J0/KBpcSw6jbtsIk/2y1qUX+QBAkSFIrE?=
 =?us-ascii?Q?itQLwraxSB4DBubpWw7H/IwZ2nD6QVJ46Gie+nWxoRcggv8SlvS1NVM/YsW3?=
 =?us-ascii?Q?mjIprpQCU9KRYs/3fHQIjClNfQQzWQ6fx7yIloLmgxKlWxgVZ1qSV2iCiBkC?=
 =?us-ascii?Q?n+ZR5Sjvlyb3+LUux8pCh8sieKF3O9GBc0RI3aOERxQ3d3A0egfnLdDLCWac?=
 =?us-ascii?Q?AqyZnRx+dFDHvmSZ9fnC5QvsKNVjauEiOMV7jata9Y7XdigbWI2RTWbqjUiY?=
 =?us-ascii?Q?ZmIWEYvpLV3Pab3ZaYHnIkl1XldHTsVkuc4p4GeRbB1wXMHqNZjwk7eqGZje?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a2380f-8932-4ef5-f80f-08da9c2dc3c6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:02:39.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCGWtJ96CDd0X/92eFPJorGPQnBuTBjJoZmQDvtaUYHigmC/yBb6QOu0ORdUhZPRnkswy3Bt0jIsvtz5cm0CaiPCfCIc+TpGx+iibM1lPDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner wrote:
> On Tue, Sep 20, 2022 at 09:44:52AM -0700, Dan Williams wrote:
> > Dave Chinner wrote:
> > > On Mon, Sep 19, 2022 at 09:11:48AM -0700, Dan Williams wrote:
> > > > Dave Chinner wrote:
> > > > > That all said, this really looks like a bit of a band-aid.
> > > > 
> > > > It definitely is since DAX is in this transitory state between doing
> > > > some activities page-less and others with page metadata. If DAX was
> > > > fully committed to behaving like a typical page then
> > > > unmap_mapping_range() would have already satisfied this reference
> > > > counting situation.
> > > > 
> > > > > I can't work out why would we we ever have an actual layout lease
> > > > > here that needs breaking given they are file based and active files
> > > > > hold a reference to the inode. If we ever break that, then I suspect
> > > > > this change will cause major problems for anyone using pNFS with XFS
> > > > > as xfs_break_layouts() can end up waiting for NFS delegation
> > > > > revocation. This is something we should never be doing in inode
> > > > > eviction/memory reclaim.
> > > > > 
> > > > > Hence I have to ask why this lease break is being done
> > > > > unconditionally for all inodes, instead of only calling
> > > > > xfs_break_dax_layouts() directly on DAX enabled regular files?  I
> > > > > also wonder what exciting new system deadlocks this will create
> > > > > because BREAK_UNMAP_FINAL can essentially block forever waiting on
> > > > > dax mappings going away. If that DAX mapping reclaim requires memory
> > > > > allocations.....
> > > > 
> > > > There should be no memory allocations in the DAX mapping reclaim path.
> > > > Also, the page pins it waits for are precluded from being GUP_LONGTERM.
> > > 
> > > So if the task that holds the pin needs memory allocation before it
> > > can unpin the page to allow direct inode reclaim to make progress?
> > 
> > No, it couldn't, and I realize now that GUP_LONGTERM has nothing to do
> > with this hang since any GFP_KERNEL in a path that took a DAX page pin
> > path could run afoul of this need to wait.
> > 
> > So, this has me looking at invalidate_inodes() and iput_final(), where I
> > did not see the reclaim entanglement, and thinking DAX has the unique
> > requirement to make sure that no access to a page outlives the hosting
> > inode.
> > 
> > Not that I need to tell you, but to get my own thinking straight,
> > compare that to typical page cache as the pinner can keep a pinned
> > page-cache page as long as it wants even after it has been truncated.
> 
> Right, because the page pin prevents the page from being freed
> after the page references the page cache keeps have been released.
> 
> But page cache page != DAX page. The DAX page is a direct reference
> to the storage media, not a generic reference counted kernel page
> that the kernel will keep alive as long as there is a reference to
> it.
> 
> Hence for a DAX page, we have to revoke all access to the page
> before the controlling owner context is torn down, otherwise we have
> a use-after-free scenario at the storage media level. For a FSDAX
> file data page, that owner context is the inode...
> 
> > DAX needs to make sure that truncate_inode_pages() ceases all access to
> > the page synchronous with the truncate.
> 
> Yes, exactly.
> 
> >
> > The typical page-cache will
> > ensure that the next mapping of the file will get a new page if the page
> > previously pinned for that offset is still in use, DAX can not offer
> > that as the same page that was previously pinned is always used.
> 
> Yes, because the new DAX ipage lookup will return the original page
> in the storage media, not a newly instantiated page cache page.
> 
> > So I think this means something like this:
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 6462276dfdf0..ab16772b9a8d 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -784,6 +784,11 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
> >                         continue;
> >                 }
> >  
> > +               if (dax_inode_busy(inode)) {
> > +                       busy = 1;
> > +                       continue;
> > +               }
> 
> That this does more than a check (i.e. it runs whatever
> dax_zap_pages() does) means it cannot be run under the inode
> spinlock.

Here lockdep did immediately scream at me for what can be done under the
inode lock.

> As this is called from the block device code when a bdev is being
> removed (i.e. will only find a superblock and inodes to invalidate
> on hot-unplug), shouldn't this DAX mapping invalidation actually be
> handled by the pmem failure notification infrastructure we've just
> added for reflink?

Perhaps. I think the patch I have in the works now is simpler without
having to require ext4 to add notify_failure infrastructure, but that
may be where this ends up.

> 
> > +
> >                 inode->i_state |= I_FREEING;
> >                 inode_lru_list_del(inode);
> >                 spin_unlock(&inode->i_lock);
> > @@ -1733,6 +1738,8 @@ static void iput_final(struct inode *inode)
> >                 spin_unlock(&inode->i_lock);
> >  
> >                 write_inode_now(inode, 1);
> > +               if (IS_DAX(inode))
> > +                       dax_break_layouts(inode);
> >  
> >                 spin_lock(&inode->i_lock);
> >                 state = inode->i_state;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 9eced4cc286e..e4a74ab310b5 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3028,8 +3028,20 @@ extern struct inode * igrab(struct inode *);
> >  extern ino_t iunique(struct super_block *, ino_t);
> >  extern int inode_needs_sync(struct inode *inode);
> >  extern int generic_delete_inode(struct inode *inode);
> > +
> > +static inline bool dax_inode_busy(struct inode *inode)
> > +{
> > +       if (!IS_DAX(inode))
> > +               return false;
> > +
> > +       return dax_zap_pages(inode) != NULL;
> > +}
> > +
> >  static inline int generic_drop_inode(struct inode *inode)
> >  {
> > +       if (dax_inode_busy(inode))
> > +               return 0;
> > +
> >         return !inode->i_nlink || inode_unhashed(inode);
> >  }
> 
> I don't think that's valid. This can result in unreferenced unlinked
> inodes that should be torn down immediately being placed in the LRU
> and cached in memory and potentially not processed until there is
> future memory pressure or an unmount....
> 
> i.e. dropping the final reference on an unlinked inode needs to
> reclaim the inode immediately and allow the filesystem to free the
> inode, regardless of any other factor. Nothing should have an active
> reference to the inode or inode related data/metadata at this point
> in time.
> 
> Honestly, this still seems like a band-aid because it doesn't appear
> to address that something has pinned the storage media without
> having an active reference to the object that arbitrates access to
> that storage media (i.e. the inode and, by proxy, then filesystem).
> Where are these DAX page pins that don't require the pin holder to
> also hold active references to the filesystem objects coming from?

I do not have a practical exploit for this only the observation that
iput_final() triggers truncate_inode_pages(). Then the follow-on
assumption that *if* pages are still recorded in inode->i_pages then
those pages could have an elevated reference count.

Certainly GUP_LONGTERM can set up these "memory registration" scenarios,
but those are forbidden.

The scenario I cannot convince myself is impossible is a driver that
goes into interruptible sleep while operating on a page it got from
get_user_pages(). Where the eventual driver completion path will clean
up the pinned page, but the process that launched the I/O has already
exited and dropped all the inode references it was holding. That's not
buggy on its face since the driver still cleans up everything it was
handed, but if this type of disconnect happens (closing mappings and
files while I/O is in-flight) then iput_final() needs to check.

The block-I/O submission path seems to be uninterruptible to prevent
this type of disconnect, but who knows what other drivers do with their
pages.
