Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD5605515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 03:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJTBgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiJTBgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:36:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405321CA5A8;
        Wed, 19 Oct 2022 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666229780; x=1697765780;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/nrOQFrhf1EX4NjuvK8kqQS4PDGIYwLLK4HPOOq8ftc=;
  b=IHJ2OqXGa++F2ALvMLpvQGzJRVIkz51IlZuBJ5Abp2g0sBvRYgu/Vjdd
   YxGiJEXZkoVqab6mTQWivwMCZ2Uh7KoMv2JFQJq7qSd0oWYqT8ayipb63
   CchQyqeV1MYRpvsB7m3AQDApS/vEFYqzHOZB/WNWkI7lz+6waDfw6/okU
   r+Fh7AlbiFcTjRmZSdsLiT1lIeMaQnW37kdjiu+akbjT479EX0Nt8j0qk
   l+UTtWD5ZQI23AAJSxr2IW7S4vKCwZ8CgPfB0IBPRGe/AlrZFCJPTjEg8
   aHTFWhs06xk2Ypg7sxSO1lpoY4hXyndEtPmsByISLLBL+u398VGB/WOSZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="392880981"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="392880981"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 18:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="734513151"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="734513151"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 19 Oct 2022 18:35:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 18:35:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 18:35:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 18:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2hix6NPYxet0UyxOViAxO5qBwMPN0OEpfytN+TqHPrqL2I+QAWQo6EjRk82MueUAEx/h1sPQ7S4InH9LR2cGJ0EMzE8ZnwK3H9+07YaFBei/vC/XCsBXGQldTSDhLFL6gv0NSwgvUSYMM7VJWlutZTWwVIZsxEqshKWE7SReVnjefH2HDD4H60l9iOpkuwbLigfLBeuUDt896091w7CSZV267jX0DZx6R/b4QXJsk4a7G3sPizvP5RrDrRY+hssEJdHMElkYv2eHlDcQ1vOac/rODMG95Ba11tZjgABPEEfJdiUD+DQp2OFwz2lnDCzg1qREOOKPcnC4fdKHPQaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuTTFMrW+a4fiyDNPJgVan8a7GZbf8NN+hG4oh+wr+s=;
 b=cOxlrNzHz6x7z0oq8QG3t6qLMVbhNwFfmsJVVL9Yf1owQv7rUoycTdsk4tb+9gbmY4U4YiI+iDuyVd+QW7lth1+W5Doi7svivGqlkZ9FqfsMMKex6AkotuyEpqRQThiK05+OrTpQSqZo/V8BwiepWE9lBG3yFUg1hPde/Eoay6RjSVWeYvBRvljxqHG0lHQIJlN/cOVir6xwDeWfG4eOfWWImwTVh6ft1pAeDJEcmjtGS3+JnrILd4homxWXyg7zPSkL14/pLJaz+gIvEzdSOnUYIv+nc7fFXYi69Hg+s7rvPqoIWgHdBbsx42hkFuUX8ExKIPtW7vEpw+x795Epyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5050.namprd11.prod.outlook.com
 (2603:10b6:806:fb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 01:35:47 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 01:35:47 +0000
Date:   Wed, 19 Oct 2022 18:35:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Brian Foster <bfoster@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
 <YjSTq4roN/LJ7Xsy@bfoster>
 <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b5ecc6-4ff8-498f-d3d0-08dab23b6979
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/mfpoYo2BXemAs/GURXjgrdmwYX0kBnlIy8pb14th4vMljCX8m2u7EhaCtvJa5eMOzn0jsp5uWliooPXDOjojBdqUngueKqQ6u5jf86CVdfCuzBmyGkVmZaO0IBM0866YqhlmU2fNHeK9OS6yPWJmFPTt69I3g3MThIoEOSCqmDrHLzvh70W2lwCDQAYXLZ21OfcJN6y4I/LFZjcFixrpb4xHDID/0bREa7c27TXKc2o/B9Ul/XGQNaxG/tuNs5QjMogBvbuI2IoKyF3wUKYME3t6tuHP7qztKLtYe6KWpNgoqBCnMgzi/G/fNXDpcv6Ad41CXvZJR7/dl9L7yVsDciJzZLTeJ17K+PBUC/Io2VhgEQ8Nf/CQvK8lrRL98UKfIxRAv8UoEvzy8/DNUH7pkds6vFLg1Xg1bR4ca+kgYGWuQwIVFHtgPOh6bTFrTtW6Amq5mI8GT3uPeQtfN6fXZ+vOBfGc3OG99TBMq8AhqcdnKUBs/PegDRgwKwqkGPQw8JT/eRdvyxjMKpBAPpdmCoyPADui08cuC+1kFbtoymM8J7Ax0j1bL/maV/POA4zmJbEnwr7X4Wj4sEx7OaPUjJFQ835T6NC3tw2dBGnKhczp4JfD0DBxhzsjZemzw0bnIpGIguhyiVKM+5sSAWNs2ObAFDTchod71axrzld8yiNLEgX/rciheuLMPNsuSDlbBqO3x5CT1pd3QRHhDpq7BzNwHhGO/kAxY573B5WqWQH9Vg6Z6JzQBU2hgp5hGJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(9686003)(38100700002)(82960400001)(316002)(66946007)(966005)(66476007)(66556008)(4326008)(6486002)(54906003)(110136005)(2906002)(8676002)(8936002)(41300700001)(186003)(83380400001)(6666004)(5660300002)(478600001)(6506007)(53546011)(26005)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AerXJR+Q9jOugIm9MiIianRQ7xjO8Butw1Hy2IpeeRFxyn1aRc/FOXX8P5BO?=
 =?us-ascii?Q?xXsaEIkX5E9ms1yRz4HkFJDVk12uURHfY19GKi40tl7vS66d0OunFwonO1Af?=
 =?us-ascii?Q?/wa+6Y3FESIY8U8mdWpIMhMUG2a50UCrGnwghGNCPoQbQcp14LHcWp+OVk3b?=
 =?us-ascii?Q?6X+bEvCGAbl78xlv1pvODNa6Gx9JjyJQojVvcxThTUL3eaqYSRoi1Hj0A/bW?=
 =?us-ascii?Q?yQY6ULB3MGbIYsr2BD/f0SgD8lI2kHXdH2pItZeFKiFNuFYLipkC5/HGLIRk?=
 =?us-ascii?Q?jmdTeRqLxKyKWc+ZScd8N50JBJKIxzqg7FPCQYhtaQzRugwtBGlsKzD+SgPV?=
 =?us-ascii?Q?LRYj3f8xPpBbkmf9bn4yKb16Qj9r4jxYmqmvqns72tt8d2f/4ZK7G6trlXvO?=
 =?us-ascii?Q?ms5UhylxEjlo7/X64uXnNeVk0DMZjLuu/XNZzo/dT3NvbvPkU4ifhxDhcB7K?=
 =?us-ascii?Q?5mDUIdz89aZkuCcaIiuLWpRyYYI4It/ihRcbpCzWplk8g4IWBn/3Hrxpy5yG?=
 =?us-ascii?Q?iD/K2HrzTgW3AhZstlFiQkody+5jx8R9V/NmGIDDR43QH+zGUQ9LSbtjbV5Y?=
 =?us-ascii?Q?No1Fe3v883vPDGFiR7I/rOOk8yVYkZJNKKAf2bR99/6oroJAWVUY0Kzg/2D5?=
 =?us-ascii?Q?Q3ND/d5Mx1ervwgMTXblLRGNLQcdIAiVhlh79EZVkGKJDvvSAdahwTsOYjce?=
 =?us-ascii?Q?Xcmu2ptSXVAXlJVXzyUwp59ljbcsSbdJwcGy1JLeuP6lKFLrqFgUjNvBnRs/?=
 =?us-ascii?Q?RxC5XGz39rJtLPVUnpYCSDrws/+XoclTiD3Of1mN8czfirpmRXgpNm11kiIf?=
 =?us-ascii?Q?AWBRJhLlj08ypFDylDDifE3S6NlyqtqsvgDpNfmn9psgTiDZ9oBsdmyVOU5j?=
 =?us-ascii?Q?Yu1m8Czwq25QZfNqUAbetS12CUw8hcrAm8K0BwQVF8/xWYDeBpe0J68VhvcY?=
 =?us-ascii?Q?KH6UARGDU8rXZWTo6PMTQJdMwQkrMT0T2la5xJOp8Z7TqPg72jq9U6fde/F7?=
 =?us-ascii?Q?eqXZhglvo/f73p0U9/QH1J/26ZRs74vSDscCSGCnJmlTvpYHjxPmOGC0dedV?=
 =?us-ascii?Q?t3oKxKY28A04Gtzx9wWXfL0ilW00tc+i8CvXUzk21z8D1bkf68v4LhOHXSji?=
 =?us-ascii?Q?f1DSlEDXxFAVgla3c+90k8PGmRj9nX2LEQnEPKYJTWRkRYYkEtSvhN1nWXEb?=
 =?us-ascii?Q?L/dhWDR7ORtypPxZSXQW11L+XfGEay909CI+dqmz9CoGgKqOqnDOdwU9a8sr?=
 =?us-ascii?Q?yROOe0c+sDRgay1tcDfokHfUBRUiFMv0l874a9Swyps5doPfh4nPWY2/t++M?=
 =?us-ascii?Q?m9w33VBPA+zeWq3HNs3VW5bII/aAZH6H5DlJa9T7xAR7m40Hx/J70idfb/KB?=
 =?us-ascii?Q?9gr7BuwumIIE5ku7Kwtfm6UCgHMDXLch7Y3BVOrKAIrKQwi0t4fEK/P4q83g?=
 =?us-ascii?Q?a+VMs/pdDrKX4g8DkObX0CH8Lii26LtpRpxx8vKXGtRnNtZpEDzP7DWWwPRY?=
 =?us-ascii?Q?twNuGd5IZpKMDDt5hR/8c1pBfuDmQ7GM2u1WI3jML7r6lm7Dg6+YDhG0M9QY?=
 =?us-ascii?Q?cyAqjx6b8lW1niILjVGwPkLBGL+CE8ns/MPOyvjUq8tj/fnS7zabqCiyLZz+?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b5ecc6-4ff8-498f-d3d0-08dab23b6979
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 01:35:47.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxBRyPSKnLqe5J1DsS2BSrHRNX/VQWe70flLh//cpuGzz+KFpfqE/BjJCXQLR7Bv90hVYFC5s/BrOV4jfvnrEjvzxUe9MmiL4eX9ZRdfo90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, Mar 18, 2022 at 7:45 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Excellent!  I'm going to propose these two patches for -rc1 (I don't
> > think we want to be playing with this after -rc8)
> 
> Ack. I think your commit message may be a bit too optimistic (who
> knows if other loads can trigger the over-long page locking wait-queue
> latencies), but since I don't see any other ways to really check this
> than just trying it, let's do it.
> 
>                  Linus

A report from a tester with this call trace:

 watchdog: BUG: soft lockup - CPU#127 stuck for 134s! [ksoftirqd/127:782]
 RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
 [..]
 Call Trace:
  <TASK>
  folio_wake_bit+0x8a/0x110
  folio_end_writeback+0x37/0x80
  ext4_finish_bio+0x19a/0x270
  ext4_end_bio+0x47/0x140
  blk_update_request+0x112/0x410

...lead me to this thread. This was after I had them force all softirqs
to run in ksoftirqd context, and run with rq_affinity == 2 to force
I/O completion work to throttle new submissions.

Willy, are these headed upstream:

https://lore.kernel.org/all/YjSbHp6B9a1G3tuQ@casper.infradead.org

...or I am missing an alternate solution posted elsewhere?
