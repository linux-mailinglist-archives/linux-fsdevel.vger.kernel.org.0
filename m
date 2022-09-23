Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5795E862D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 01:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiIWXGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 19:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIWXGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 19:06:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA21138FA;
        Fri, 23 Sep 2022 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663974369; x=1695510369;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M9I9OKRbZYn9ufyBdYONSB/ZCRdhRZig5+xzSytBtaE=;
  b=Bf7Ub7Zm1S4z7rlt/qf4AB0V3qNc6j5FF6LyZa4p9eqJizz5Ye4dLw2Q
   wCof11lAktOlw+ewr938qOUNKUy5gIcpr9K6/LtfOi+tcKcBnxGw/Nb0U
   K0/GF8E8AKPpKSJQvWgXlrTUJMb8Jn5lHdtiAP4SaVSDS+pRcUUwqS4Rm
   owiW4DrV4hRoChZex7LXrUYrvTWepi392ty+UJEGwwv0QtoHFbRvWPj/K
   Gs+PcseAMVuK0grKCa/XlsZntOQMyzI/BWGNhC0Vh0wZajWgTt8WV9NxD
   Y4jQLihAhbKphtBwEAIKOHONvACFWPv8j1zbhL0YPya1et0907Z4grVlF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="281079725"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="281079725"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 16:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="571550418"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2022 16:06:08 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 16:06:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 16:06:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 16:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsoMP2h/qwEVu8wiuTa7bMXUxJfQNpO6+HULpx5s8jUgvhiKFKpiX+VjbdXrZAMFHpaMJVUcsXUrLz+gJO/MhEX3BU4T5/vSuZwcv97QFioV65g8woClcMtJ4url0yKpg6kMVJBVS/8Mv/h82vnmGlMDiuhc/EBTa90uuvgnMFzE2PF9y+8lmEB8noFeFdAVCw13+Fd/hhaVTH+r0EG2jOzeNVTUcuglQbDxDixO1J52FWGpLBpZTzJ4uusztio2YC4l00PTqwCM+g6cmqrtcKkGnO9DUV7LpXna2xY0heDI26Jf0LGfciGVRYMbYQf+5hDRda0+gSXAfeVpyJr2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTpUZxfDjiFG57bR4UjSm2QAU6Jdo9raP6smB4Dta/Q=;
 b=PS3/U+gVEXTjuxqWU0Xdi/kYLZ3WQoR/OCffefpkEnrx1eAFucjr7dwt4ARK4/TtkYW+tpUBHFpAz0fj8RXomowLcsuVIY4+dHKXy1yhDNEVHQ6Sh/UnotOfcifg58Uto95F42stScork2alYlCyVoG+LTD0ChpvKwSqhMCgUo4poO5YKdpBV439pmXLZKmcqJNUCzJ3Qgp21/6KXdoKp2WL3VlAuZg9oYnaMzWdVsOO8wW1cFG9knMyUyycLWJ0sOVn6Iu2whtq/lnDoGLwdl4/fPBfZy0xLxDo3VxVQd0jJX8ZSRNSeY6fo3NXjO0Nj+NzEyI2JmdJYdwPWRLwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5113.namprd11.prod.outlook.com
 (2603:10b6:806:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 23:06:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 23:06:05 +0000
Date:   Fri, 23 Sep 2022 16:06:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <632e3bd8adb33_795a6294e0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220923093803.nroajmvn7twuptez@quack3>
X-ClientProxiedBy: BYAPR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:a03:60::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: a7381bbb-caec-4651-44a6-08da9db83174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isOqFmISw2n+vA00iGdVxKiovrVPnwofBZ5F9LWVv+7KMZYFPCTfzRLUuhSUDL2xq3yDPuZ95IPDvjqDOe5/u1uBeGOs1cPqeo3oVDPVOLSpUC8lrylQKPDwrrw6JgzwtnPWu+h5FcBH5Ek2yhlC5WwBpieUZ3KUnVe7K7s8wTJ1WKqsOVwg+Xv1vQXSW8jxOnvsv63/CNHb43Pynb9VVPRh05W56BxmNKmPAIAYi3rumE69GSfq/jpGI5tUTo3zKqpDGVDTCwSIbG3Y7g5IhIT5pCRfk9+ccfsvubqY3qfwDWJT4QEjUxf4eXhMxGhv6wSHOsNHrD02D+M9INUjw3roYIGvP5Hh0mBHsSw1Hcv/a6q1IM08nK3Gpqv958ffLAhKBfBxyFtFQJugHHaGkbQv+GF80MbFe2YbcTPhxTW4TEsUcujeOC1eORT2reS4ONqWBe1zzYRJ4exb9fTtibuvFNET0ix+SMiBuvdE6yVhLzEpg+fY8MmuzPlbPCCInXqBHiVr2crCFwy2pHV0m2r/bKfxsMMor35AHuRJ8Lebhen2aw2AmWYpsWFtwAR5CilmKBjhuBVoYbQy1MABmIZ9i4CAbYc053q+sto/DZdQo36CSDnHm9KJAeLFKGG3DzqxHL7dFjsRfj/3B7tkfNg2OOLtqMufGUVF3xgWNP164tLAr8P8L7X8ZL7lwtQ8jwJMUpOQUVTZy2uF7jR+h8/Vl/9UQlwydQIYHpuBBEWSdBxK/41WYYCdowzGowpx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(186003)(83380400001)(6666004)(41300700001)(38100700002)(5660300002)(26005)(6512007)(9686003)(7416002)(66476007)(4326008)(8936002)(66556008)(66946007)(82960400001)(86362001)(2906002)(110136005)(54906003)(478600001)(6486002)(6506007)(8676002)(316002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfYUj9Si5o7XuYSXsyQkOWIf4Dvel+DspyI9RRGt9eaLefsIdVJX7TL0T1mM?=
 =?us-ascii?Q?a8+xHiKmv4bfN3eo8wA4fw1Dg8PKEd42L8vAWqttFZSzvFzvzFeoVAeRsJt1?=
 =?us-ascii?Q?PBwXAo92lt2y9WIBXjy9zqFiym04TP9xInOIIg2/1XXQ5Cq/sw/dG0Z681G8?=
 =?us-ascii?Q?l2lD723RNE3bq2jQt1GhuwCKXBrxmqCkXog+0DLe+m1nhTqt/tpFAR2HSs+Y?=
 =?us-ascii?Q?iHj2JL8m34qpHTvT4PZmHYfzqBNmZLopBU+fWqyM1CNtn4GrAO/mS+0TBP+I?=
 =?us-ascii?Q?rcZfpZFCUIZLOgNP0L1wA2imsq5hGkyOhu1iFg+uD26G9pxlsCywLc8XV6cu?=
 =?us-ascii?Q?Kt7uUWo21nltxWefR61L2veTxWkR08FPEinkymoUkGI360Rj16R2C6xb7OQr?=
 =?us-ascii?Q?dG5yhEB7fqk30Im+q+aHOs8EOJY/otOOI4eZTQfAEgcPtzgJB+6mzDsiUkFE?=
 =?us-ascii?Q?neMRRwfUYJNAfFC3PWJS8BQ6zx16nSIGIbeavgxVcw56sHoNVjnYzzX8B9eK?=
 =?us-ascii?Q?suEv5/dUwGfF6++qGdyCZqDHuFySOhj1AbmZJAr7qsr9rQKgmWq7UdwzbcH8?=
 =?us-ascii?Q?SN6Zxt4cVzAlownzjR66cLoMhGbgHO5+p02Rn9uxrFYDR3qk4DA+SZvSRTOj?=
 =?us-ascii?Q?2wKBw6CZq8UD7MoVFArPDkLqXMLF3oIWyoRyJEJASYTeEnAO6AuL6hJy9vaQ?=
 =?us-ascii?Q?tFPRxxRqvSbgMzqro775JAmaS7TVz1rxXfwKInz598wrrGoeidXnTLspCP37?=
 =?us-ascii?Q?sys2hLBOq/MG16tKRR48vtrMqqeZoTwh5PyVTkz/6EiAl7JzMnb2xSok9K92?=
 =?us-ascii?Q?bLw82pOqHquhlr0qLMMatBk3E1Xh0XQlAwGHYFhk9XaV4znvnW5G72uhtjvX?=
 =?us-ascii?Q?cH5y/4SKHKcRe2DaH+1dQfth2bZqAYWTwKAE7VNdIgOQZWjlcT603LRoYydh?=
 =?us-ascii?Q?QLgS3cb/HEeojlcbmPGrL02YgLy1fM4mpXizTSlBnzWgt+HiCTQ1Wg2xk6Zn?=
 =?us-ascii?Q?3pPW8Jth2b70wacraFR4b+aQiIERuD+GWxg7kW3tmOZOKwUX2jbGXPnGWBwh?=
 =?us-ascii?Q?a0cLkcLJrB1G8TssVYeNOyMxQ6wy4sgT3to3aqaApH49EEmToGfTD96vnIP/?=
 =?us-ascii?Q?imBCSqoTPi5mkJFel8BLaYC7uXTv2hekYeqP9PMdyKyS3wqlkvU5DfhOEeBm?=
 =?us-ascii?Q?ceGcVcp8h7G1+v2N3/3mTsiQnpRq4hjrNvwBOKpg0czuD40xNbJxnl1HQ1dt?=
 =?us-ascii?Q?SoXPrVMs/yE28uYkKG4/IrYEueiWCZo5liPkCGx7QyV+zN3yHQaaunobfphk?=
 =?us-ascii?Q?kYgdl9go9mApMfFUFvsYpQRQ24IvdZZiVr7BogYXOl0l1Hin5BBJyXoyCMU4?=
 =?us-ascii?Q?K0mGkJnOEUb+jtI9m+fWEjRSooLuCpQ7whvwxOsCl9cSqZoC/LZKCMdk75iO?=
 =?us-ascii?Q?ztREytXS0W37VkLK16tMnS40mwFXwQ0GuUpt2VRfCnfXi/pXto6uWIvkdf8M?=
 =?us-ascii?Q?UFG3VHCTEV874CxVyXpgNlzgU1dTE33cu26lNXLsk115ADw5LqYUvWtEZ9jN?=
 =?us-ascii?Q?6dKCLC3NC9smrM3lP077vYkReJxq2EEyW2M0WN0l1G4hnz1lG2iiaY/pfiU8?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7381bbb-caec-4651-44a6-08da9db83174
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 23:06:05.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93R2HNG39YWtNQG5aoKpjOSxx7Fq5KNKwJQc808QGnYkco1o33VXIZjtPDY12RIDXb2ppqOlbPWEx1l6oX5Ovp2+T2tA2Yg2Z27RO/c+hU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara wrote:
> On Fri 23-09-22 12:10:12, Dave Chinner wrote:
> > On Thu, Sep 22, 2022 at 05:41:08PM -0700, Dan Williams wrote:
> > > Dave Chinner wrote:
> > > > On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > > > > 
> > > > > > Where are these DAX page pins that don't require the pin holder to
> > > > > > also hold active references to the filesystem objects coming from?
> > > > > 
> > > > > O_DIRECT and things like it.
> > > > 
> > > > O_DIRECT IO to a file holds a reference to a struct file which holds
> > > > an active reference to the struct inode. Hence you can't reclaim an
> > > > inode while an O_DIRECT IO is in progress to it. 
> > > > 
> > > > Similarly, file-backed pages pinned from user vmas have the inode
> > > > pinned by the VMA having a reference to the struct file passed to
> > > > them when they are instantiated. Hence anything using mmap() to pin
> > > > file-backed pages (i.e. applications using FSDAX access from
> > > > userspace) should also have a reference to the inode that prevents
> > > > the inode from being reclaimed.
> > > > 
> > > > So I'm at a loss to understand what "things like it" might actually
> > > > mean. Can you actually describe a situation where we actually permit
> > > > (even temporarily) these use-after-free scenarios?
> > > 
> > > Jason mentioned a scenario here:
> > > 
> > > https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> > > 
> > > Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> > > thread2 does memunmap()+close() while the read() is inflight.
> > 
> > And, ah, what production application does this and expects to be
> > able to process the result of the read() operation without getting a
> > SEGV?
> > 
> > There's a huge difference between an unlikely scenario which we need
> > to work (such as O_DIRECT IO to/from a mmap() buffer at a different
> > offset on the same file) and this sort of scenario where even if we
> > handle it correctly, the application can't do anything with the
> > result and will crash immediately....
> 
> I'm not sure I fully follow what we are concerned about here. As you've
> written above direct IO holds reference to the inode until it is completed
> (through kiocb->file->inode chain). So direct IO should be safe?
> 
> I'd be more worried about stuff like vmsplice() that can add file pages
> into pipe without holding inode alive in any way and keeping them there for
> arbitrarily long time. Didn't we want to add FOLL_LONGTERM to gup executed
> from vmsplice() to avoid issues like this?
> 
> > > Sounds plausible to me, but I have not tried to trigger it with a focus
> > > test.
> > 
> > If there really are applications this .... broken, then it's not the
> > responsibility of the filesystem to paper over the low level page
> > reference tracking issues that cause it.
> > 
> > i.e. The underlying problem here is that memunmap() frees the VMA
> > while there are still active task-based references to the pages in
> > that VMA. IOWs, the VMA should not be torn down until the O_DIRECT
> > read has released all the references to the pages mapped into the
> > task address space.
> > 
> > This just doesn't seem like an issue that we should be trying to fix
> > by adding band-aids to the inode life-cycle management.
> 
> I agree that freeing VMA while there are pinned pages is ... inconvenient.
> But that is just how gup works since the beginning - the moment you have
> struct page reference, you completely forget about the mapping you've used
> to get to the page. So anything can happen with the mapping after that
> moment. And in case of pages mapped by multiple processes I can easily see
> that one of the processes decides to unmap the page (and it may well be
> that was the initial process that acquired page references) while others
> still keep accessing the page using page references stored in some internal
> structure (RDMA anyone?). I think it will be rather difficult to come up
> with some scheme keeping VMA alive while there are pages pinned without
> regressing userspace which over the years became very much tailored to the
> peculiar gup behavior.
> 
> I can imagine we would keep *inode* referenced while there are its pages
> pinned. That should not be that difficult but at least in naive
> implementation that would put rather heavy stress on inode refcount under
> some loads so I don't think that's useful either.

What about instead of keeping the inode *referenced* while there might
be pinned pages, keep the inode *dirty*? Then
dax_writeback_mapping_range() can watch for inodes in the I_WILL_FREE
state and know this is the last chance to break layouts and truncate
mappings before the inode goes out of scope.

That feels clean and unburdensome to me, but this would not be the first
time I have overlooked a filesystem constraint.
