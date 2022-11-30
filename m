Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699863CF88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 08:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiK3HFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 02:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3HFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:05:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E43454767;
        Tue, 29 Nov 2022 23:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669791948; x=1701327948;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+fgmJM2UvY5iDfOrskxfgnEnb1Y1ijvVz7oTg6btRSQ=;
  b=GwHiByiHBUk8/U+7JYdTmqtVe/ZWoiWzOpqRRlD0JZiTSt/Y/AdeOfl/
   qVdoBG3/PQoh+iSbfKFl11zrTIpGeoc9t5dnWUazGtKbwakVMkJSgUl0g
   dh0vSu0eKsSL17CZEfrfQuZo1RDnaBgEFlg8yp/GgK5V8SxxdSvE8mCYM
   BtNK7m+wqo70pLWoUdDsfJlADNR8dzm0pl0KjztRLt7Dvdbc7oddMqHYG
   PoKMVr2iWoU3RxVDpJPEI6zk+YcQYHB8UBZa/D2nz6pU39dkoudyPDM7H
   +6KF4j/AVDE6bZ97yJFGVY+oYjiy0sD0hSdXKfAvUwxZCRXeQe16Mji7p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295019533"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="295019533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 23:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="750213995"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="750213995"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 23:05:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 23:05:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 23:05:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 23:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm5m3KiXrdF3oCbajPlkoksFg2hgSVWtDlAhGFpsoqeNXa6IeLjXKLfbOtZV2jTxdPjhZM30RCzJrrmN83CEp2D3+R9SYaZ8gqIcC2KcSU+f1Vcir4m4HIhXowNOS2BbMYkVFF9JmqQFVUnW0YBxhTGQTcdzGH95d+t0qEluBKZ7gYGExBYTZrsbOVc4MT9aufRHFpF9WcIbj82HzzpnMe4EqhNiFmSt0SEQGEgqOHlODg0McpXWVDISEDoROCbt7AaTg1gTb2qvjo9cE2wl6oKeh8xWW/X6hEjqQA6YVCV1AfK5yLZtlOhG8tF7qHL7Hf2oM8yHsbdXsOP7yEkn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xWIR3xurpuz6iifss8dYXa+BQCOJLsugQ5+2IIuxwk=;
 b=Irj10EjenKB08Mwsh34+zYCrr7zQg+EurDeRB5dchewax87ILXEuWzStgKpuID9qDRtpPA5NgMRGBY7Zexe29krsshtPcFT1yJYE1HKgc/8C/Fzi3N8Na9N0wVYMD6tz6PomFatBDzS8b0RA2ZnY3+yd2OBL/AZPrJmSU93XTBPbyNnFMucEiE2pbanAR8siMbt5DI2yIiwwGiyPhScFBjcoLMvrQG5INKAxjpXHrKdiMi9WTxROT8VyRWxhngmZrlMF0Y8n7r0bl7nzR4mMwrHcDBNigsMAvRg5n14DdmErAwQvqdSVpGqO9z6clTyVT8BNEpXiwc2hhgBbXLp0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 07:05:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 07:05:39 +0000
Date:   Tue, 29 Nov 2022 23:05:30 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages
Message-ID: <638700ba5db1_c95729435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <6386d512ce3fc_c9572944e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y4bZGvP8Ozp+4De/@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4bZGvP8Ozp+4De/@magnolia>
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 661513f7-f1e0-446a-c23b-08dad2a148a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whxcUbZ8H+Rx8Go4H5r3MV4mgDo6QP/HbbNOzqr1V91lmrB/+uxAWtR202PCkcbaBxFlhgXlxMCi1Z90U+NdPLrBDJq8NMMNckTtSrFAO18lAtCjR+/GTJD22TuyrMdEaZD2njACkCL/t1B7rmEQJHdwQYmUoHt/IKVN/ZRoYoe3l73j4EIinBFbQSYeunqq/4Q8mcg9L4toNJgz9CkiiwsU0B2jfrq5T+K2TfQLlZOaAsun8/ygyEm3oLUMuYNCpMMlatL6SRR+Z7LTSB2SQ4wuKhxBLN3NgeEq/I5GjA0tBUvNHx1pDGo3lp4K11EcCjLIAWOeM8XNy59NZS5kdfYrP7hKbad84r1jcotGUG8W0l1otkaFkThQwT+ARRjPzeDhRNVxnrZ77tNeDx2upi+ItCjaB/PdatPlgr68AtSBnOS2zNHH0SoYPO+KG0OgvAICzdlb+apHfthqDN5mevu/fY0n/9ArrewNtXzN6wAOro67sCrlntepj+xkQe1LE+k7pqka9wHjqyPkK294l5ZbYry04ZrS52/7Sm6Y5tbRzl3ahwrrguurofF1qA3ECYpR+AkStRCt2Db9pDGK9hcUy7cg7++XFJnx+tCZoTZnF+UxQcOr7EYue7A5HXuWyOAI1DE02FNWeNsZgK8AEGC4Fl0PSRb/wVOgYclbUyehGDuJTYN8k6OCsS+4OG1kMLi62/zsqu+OTgDarKR5QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(83380400001)(186003)(86362001)(38100700002)(316002)(82960400001)(66899015)(15650500001)(2906002)(110136005)(66476007)(66556008)(41300700001)(8676002)(4326008)(8936002)(66946007)(5660300002)(6506007)(6512007)(478600001)(6666004)(9686003)(26005)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xjGjkwEXRfcrYW/iU4y+X/BZR7ykGHGoEjafRHTjMMdUPS2ZUCcXts554Gt?=
 =?us-ascii?Q?bRTXA8B+60vW0gm2ZMm3p4nrerTKyVzSwWrTyTAdzUfd5dG3lhTofBjrw0hZ?=
 =?us-ascii?Q?AAbTOqg1+uK6uvf/QO9JlfGtikwPOw8U+GxMK5EEX6ffaMc5AJIMwLAa3vXY?=
 =?us-ascii?Q?fzIWu7eRMJNZ6w/WcPdpnYUBkus3CXmhNdkpSCwWx/xkxtP8L7V0AaYU9+6W?=
 =?us-ascii?Q?dxYK8Z3ADQtheALunXMiazQE5MsUUAe4290CPHpQTajz0KycXzJXAmLVLC3Q?=
 =?us-ascii?Q?Nq9VoE+093qi8dFgIBAjDi6/6D2LfqNBhP1DqH3ODuLu2cS/+00FrRDGy/t5?=
 =?us-ascii?Q?3QPw+ZN2okUDWEPtg/3J3W6MOCJQIJwuq260KxMPYRYOOQfYGDlQF6XMvED7?=
 =?us-ascii?Q?xnwxYyHUKvjh0W0yUqZ0ynYRtDWRS+l2j1+ntI7mpu14djrIrxEsK+nv1Yku?=
 =?us-ascii?Q?5I68yaH+95HfwCDzyG92ChlyIzsMJwgsvDBWhEUvSyJHNt3srL561w8GB+X9?=
 =?us-ascii?Q?MMUBIMB5KmsDyjzLPtLzVyQJVIRXI+F33u+E2C3v/C/nZ1QPIl8CmK2fNbIo?=
 =?us-ascii?Q?1oZJBeWOkadYEjRRESikUlj/dSmuDxT1a4AXMnYJC0QvPnkOgvRiT5dAmyGT?=
 =?us-ascii?Q?T7PEIlmr1t8FbEPCKJ+S3lBHmGHgTrQS+oJlYWL6JV3ZB0uLZh2NjbvzK4R6?=
 =?us-ascii?Q?K+mYcYgoY0mV/gL8EMQVkLhBjESRLXb0Zg+R6IRnOAwzKE9GJXNnHTwrnnsM?=
 =?us-ascii?Q?A5tCN1MW6q5NcIFIlXsaYgmmVJsQj8stlHwT3Fk7VY+WUvfdYgNAtavOLmm9?=
 =?us-ascii?Q?lXUnfBbHK5gOnkWT3nbw+ZDCnFSh4X3nFDswRQ3BF4iMaIHZ6qK/Vqmp0Fwl?=
 =?us-ascii?Q?DHWy4Z8UGdFbReWXQ6jZzOQoDlNimJ+qoNGYD7ArIengqS07pnp8WeAjSczq?=
 =?us-ascii?Q?3Z9aPxFX6qpVEEjWfvX1BMnq926q418RwG39d79ZtIXlEwL+xRnOAeugIM/N?=
 =?us-ascii?Q?dcdUeg5lKdsZdT1ivyyrqn2Uk3VQAgvUJaDQzLp/id3K5P+kJKnhz/Smowra?=
 =?us-ascii?Q?qCTcL72vRM5SjDAc9VpSamXNUwKRWnh00sy5jq94dNByY4T29q1Ho0cO+vM3?=
 =?us-ascii?Q?6YMKG2ec/FJPMBK6YbpkEJ8p/qq4IcDFLf4+vydCjTaGNwQ1EnUi6RqZJ7SF?=
 =?us-ascii?Q?L2h7uhnXvMSksafHviYCEOEntFmBVGY6Alk8fbWLudHtKyOcxr6TWoQkHBT3?=
 =?us-ascii?Q?+5tG4HsaB8acObbBCH9Aeq6mR2z8Ov4JDoIAgwA6QWlNmPZI9fC3lLwRPXTW?=
 =?us-ascii?Q?t7hCiVPuMqzEj5kz3cg/NLAUyz8lFYSswB5Ler2ohsRQpIEtxDPXOjyNkbl2?=
 =?us-ascii?Q?pDbnvHMxpbv52s+cmsmxuxizyu0x8WPTv2gXQC2knkusQ8TZW/AaqsDviZqV?=
 =?us-ascii?Q?Zj08Tq9Kek60m/QILK+m6sCLgKbBQHWcm97mqiKUfLOa1r7hYqHeg66miStI?=
 =?us-ascii?Q?8V8uM4tivzO7v6sPmx1LF59HCVwMoai3tPLpWcWJVnAHZXa7ssklbDKuDLKl?=
 =?us-ascii?Q?NNl8xEsfHMwUFCK9mURDi47F2sd6kUQ1DjyJ9IAo690ZonNa7j0jrrig7WRx?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 661513f7-f1e0-446a-c23b-08dad2a148a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 07:05:39.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po6z5VmIkiUnN0W5rhcY3OpFrDZbW6LBAPjZEeJBAhiE18nkcdzhtyECAVMFiKmP4jCqXUeIuTLAzclkiWfIr/ifsjQPQngk2lm6rtJsRjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong wrote:
> On Tue, Nov 29, 2022 at 07:59:14PM -0800, Dan Williams wrote:
> > [ add Andrew ]
> > 
> > Shiyang Ruan wrote:
> > > Many testcases failed in dax+reflink mode with warning message in dmesg.
> > > This also effects dax+noreflink mode if we run the test after a
> > > dax+reflink test.  So, the most urgent thing is solving the warning
> > > messages.
> > > 
> > > Patch 1 fixes some mistakes and adds handling of CoW cases not
> > > previously considered (srcmap is HOLE or UNWRITTEN).
> > > Patch 2 adds the implementation of unshare for fsdax.
> > > 
> > > With these fixes, most warning messages in dax_associate_entry() are
> > > gone.  But honestly, generic/388 will randomly failed with the warning.
> > > The case shutdown the xfs when fsstress is running, and do it for many
> > > times.  I think the reason is that dax pages in use are not able to be
> > > invalidated in time when fs is shutdown.  The next time dax page to be
> > > associated, it still remains the mapping value set last time.  I'll keep
> > > on solving it.
> > > 
> > > The warning message in dax_writeback_one() can also be fixed because of
> > > the dax unshare.
> > 
> > Thank you for digging in on this, I had been pinned down on CXL tasks
> > and worried that we would need to mark FS_DAX broken for a cycle, so
> > this is timely.
> > 
> > My only concern is that these patches look to have significant collisions with
> > the fsdax page reference counting reworks pending in linux-next. Although,
> > those are still sitting in mm-unstable:
> > 
> > http://lore.kernel.org/r/20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org
> > 
> > My preference would be to move ahead with both in which case I can help
> > rebase these fixes on top. In that scenario everything would go through
> > Andrew.
> > 
> > However, if we are getting too late in the cycle for that path I think
> > these dax-fixes take precedence, and one more cycle to let the page
> > reference count reworks sit is ok.
> 
> Well now that raises some interesting questions -- dax and reflink are
> totally broken on 6.1.  I was thinking about cramming them into 6.2 as a
> data corruption fix on the grounds that is not an acceptable state of
> affairs.

I agree it's not an acceptable state of affairs, but for 6.1 the answer
may be to just revert to dax+reflink being forbidden again. The fact
that no end user has noticed is probably a good sign that we can disable
that without any one screaming. That may be the easy answer for 6.2 as
well given how late this all is.

> OTOH we're past -rc7, which is **really late** to be changing core code.
> Then again, there aren't so many fsdax users and nobody's complained
> about 6.0/6.1 being busted, so perhaps the risk of regression isn't so
> bad?  Then again, that could be a sign that this could wait, if you and
> Andrew are really eager to merge the reworks.

The page reference counting has also been languishing for a long time. A
6.2 merge would be nice, it relieves maintenance burden, but they do not
start to have real end user implications until CXL memory hotplug
platforms arrive and the warts in the reference counting start to show
real problems in production.

> Just looking at the stuff that's still broken with dax+reflink -- I
> noticed that xfs/550-552 (aka the dax poison tests) are still regressing
> on reflink filesystems.

That's worrying because the whole point of reworking dax, xfs, and
mm/memory-failure all at once was to handle the collision of poison and
reflink'd dax files.

> So, uh, what would this patchset need to change if the "fsdax page
> reference counting reworks" were applied?  Would it be changing the page
> refcount instead of stashing that in page->index?

Nah, it's things like switching from pages to folios and shifting how
dax goes from pfns to pages.

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=cca48ba3196

Ideally fsdax would never deal in pfns at all and do everything in terms
of offsets relative to a 'struct dax_device'.

My gut is saying these patches, the refcount reworks, and the
dax+reflink fixes, are important but not end user critical. One more
status quo release does not hurt, and we can circle back to get this all
straightened early in v6.3.

I.e. just revert:

35fcd75af3ed xfs: fail dax mount if reflink is enabled on a partition

...for v6.1-rc8 and get back to this early in the New Year.

> 
> --D
> 
> > > Shiyang Ruan (2):
> > >   fsdax,xfs: fix warning messages at dax_[dis]associate_entry()
> > >   fsdax,xfs: port unshare to fsdax
> > > 
> > >  fs/dax.c             | 166 ++++++++++++++++++++++++++++++-------------
> > >  fs/xfs/xfs_iomap.c   |   6 +-
> > >  fs/xfs/xfs_reflink.c |   8 ++-
> > >  include/linux/dax.h  |   2 +
> > >  4 files changed, 129 insertions(+), 53 deletions(-)
> > > 
> > > -- 
> > > 2.38.1


