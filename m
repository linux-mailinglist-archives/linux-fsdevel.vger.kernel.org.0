Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0260193F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJQUTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiJQUSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:18:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9080015A03
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666037914; x=1697573914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zaeEb8O6Kdx1IWpmmhiQOd0fhg+gr+Tk1tbcbEeDJ3U=;
  b=L9l35hEls8MV1S/RRqQaxcmtTtGnsSbpDarsIMLuTAFuQPGij3bkB2Ke
   dmDzfjJ7mAMlz53jnLQH9N2ON2+tFX/1SDPe0M9mUaNJYKgS8hwpeWn00
   XB2iSn5VgYwxPoB+Wl9zdolLC41i8qaL6kEfaM5PVTEenCzsQntkGPve0
   TYoD3SYabVfHtYM3MFTIWk+Fw9JLh17TM6bbxLSkIaF8mHLuw3uYZA93T
   dw+hk5HvH5JG8cfz/AXZJnqAYqOASmMNcFpl/CSR6bxtVfR1YBa0T54BA
   V1KotcjbcMm+T8IsYMoM7fAmXX1IwdSvsP4neKSH4NounaOImqdv6WFEV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="293279798"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="293279798"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 13:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="697191133"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="697191133"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2022 13:17:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 13:17:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 13:17:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 13:17:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 13:17:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPyGm+IJdWoZuYqeHQW4pzboX2sQgbn3n2vKC3Nfhi+3cUh93WtBMU47LhIXJ/B4U2LdnGgMcIHN6/HfysC8y8A6A9SviHbNYikKO76w+KIAX0QQX2fSDn/PSrOT3fSsIYSVnjbkiQEmQ9CD1Ek8Ovx5mksJesCbGWY5k5srha7+Um7OMtt2khoy1S9kCUyUiAMpjZEYpxsCEIdSfqV/xz+hFFl7n0G5jyNCRaM3fVd/vCtaDOLiGRMnqIRpO84VteABbADqxRh814UIBppDZd7bEILa80/su5W3WwTgSchqVokFmBTwzo5M5Hi2uiR0pRlQ19h4PFhpfSBnAYW3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GKxqBgqBuw1ngM7IpKJY9GYSV7YOvmLONCj8fFZ2EY=;
 b=JyVvejYeWnB8koSal+yU67EkdGKCjcQkgD7ITfljNmSB9iFF5g2vk3VAK+dt7DEUDzznS5t5/fmL4FPYOSeRgTIr2pLjmjaeukXWjhy9iFZ62scnEWr/ziDmyiGnKOIx/CiGmzK5GN0CQFBnCZeaTR454zTLRdo7xju62CuiteG2cglSRXDa+8MWRTHb74SfTUOWL4FhmHwmj8sp9Mlz2hJ8wCmfv40hOsGX9t4bHikmtH5pm6jxTkrcHNAVFnDNBP3LTW5mxnnXliiIASigo6UufSvKKvZFvd/fdBiCq8YsfdztnOdfOOh5RUJWaCa5ZqblW7AdfFetKfPxUH/pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB7550.namprd11.prod.outlook.com
 (2603:10b6:510:27d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 17 Oct
 2022 20:17:26 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.033; Mon, 17 Oct
 2022 20:17:25 +0000
Date:   Mon, 17 Oct 2022 13:17:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, <david@fromorbit.com>,
        <nvdimm@lists.linux.dev>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 07/25] fsdax: Hold dax lock over mapping insertion
Message-ID: <634db85363e2c_4da329489@dwillia2-xfh.jf.intel.com.notmuch>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579185727.2236710.8711235794537270051.stgit@dwillia2-xfh.jf.intel.com>
 <Y02tnrZXxm+NzWVK@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y02tnrZXxm+NzWVK@nvidia.com>
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: b225c777-feb3-458a-deb4-08dab07c9b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLdr8khgKlS9ZFA5glDm2VO/WEsZROV2AHrXUxZRi3LZJrwAw2HHh4eOX7sBCgN2B0rdPxN9bxhg2m4u6X1wY8LLxdcn6kC8gV5bDAWzr8taNAqlT9GagcsxqcchOkUolF9vInvc1c+Cqth5MiamgGZrBn22X09of9Qo/YEHXnBPXnV4v0UNEccwiv/BPEvCyzwINhOBMmfkiDx1MtJVyHPeInrl0esVMPD+pRHXcZ9+/Wu9dFYBr68wfc2HvyELtK6+9xsGw4Thju9QQUrPofSLYLKygOSXqwbin1HQudLxW7Fjkrrn8Cm0VcOqM3Gptcomr+REevHWRRQWd9p4abWvks8CPwxDw+xiX1GJ2AV+AnU8sOcmayb0bC/K0HgqfUPv42RdpBeMBxH60lxz9smQ+KrYE2Svw7PaqMOM1jt5dIBDKjZaw30jFylJMGcV8vYb8Uunql1djrwXtCep4W6tTvKwLBlaTHSSIt3T+t+G7olK/qpkti8jxmFuXpwhpb6oN7X7Nq0cnuFvSmoLXMv4XS2e544eQiRQShq4nXoODRgq60ThBNPC3m24UQ4ITB6aJDlFUHWEQESErlCt85r2NzztMOxOXfvlObp86CHFKn4qvefaPN7zEvXNdJYdPxzLZtI4KAY+Mv/bB57whoilcaq7b+P+vFWXYHq/kkQMtK52jSQ+5JRfGzZRAyVCDR2ME9n5O2Dl7ZHRJ+sn5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(186003)(2906002)(6506007)(9686003)(5660300002)(54906003)(316002)(86362001)(38100700002)(6512007)(41300700001)(26005)(82960400001)(8676002)(66476007)(66556008)(66946007)(83380400001)(7416002)(4326008)(8936002)(110136005)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7A9bzZUNYBQSUCAKQ6XKLs5pqsG09LSRXKnG5agu8cPLYh9ajwS8LhQ6v43?=
 =?us-ascii?Q?INUA8xBNLqJ/vZIrpXHy6dOyhbssx9q/GQIofgfcYkpRq3OdpYXr/M+LDlXb?=
 =?us-ascii?Q?enPjVZnTGX8GcqlQHz6UkToAwfpncDtywG/CBhPZsAmphqL4n2wqUjbIJn79?=
 =?us-ascii?Q?7BGp2NnSuNeT4ONiLei9pzaLHjLtW30WOz0i/CbT8sb6hZVKzXQlKxrGSrwS?=
 =?us-ascii?Q?ZadZLhzKgcaadgtpzu/B7+K9K4ZAoiUFVB/nkzpOSbKCpx7ohcJLuNIFFDRp?=
 =?us-ascii?Q?FTxhed18DfLADLA648NkoxQTVBMuDzJZ78Vyj3OnXwr7z0DA1ftAbE3rg4Jx?=
 =?us-ascii?Q?K+si6B6ugmQj3TanORiDjfr7FD9wj0Y93FAm0L0EiYvAA6YPy2D8QYlvyh9H?=
 =?us-ascii?Q?P0Ai8VirQWu8DEYil8c9bGh2tNZtXlfoKhzmkJKwEPp5dCCfv0HDnCnRXdjU?=
 =?us-ascii?Q?a6g8SLPlgQ3KyDdytMUDac/jpBbgCap9BXJZcMVIPslbeqplmSlaXf4DqA+X?=
 =?us-ascii?Q?mFiPjIoYdN7jOn5oRbcMWV7jxYUn2dYhKmsxHSGti8SUMjg5pEiu+9tJ85/g?=
 =?us-ascii?Q?S+nJd2asjl2xVM7F4LOPUx7RdZT1Yv+to3l59+7J8q0kn32BKh7k5eVcNqjo?=
 =?us-ascii?Q?7Fj77Pl0WHxbiNecdfpM8NuqE2xRSg5KApqsCBU6bZaMhmGcthtk4U+hjuHU?=
 =?us-ascii?Q?zM4/UuhfHaAY9WyI5KB2sARLf2iimVR/T80CqDjEj7Hm7C2ojirqGIayFPeL?=
 =?us-ascii?Q?4IOfw6zdmTy5wjGNivp4j35fHiuGjXfDhMbieumTArE2dKeS0S1YWJruzrEH?=
 =?us-ascii?Q?dLN51mH2skqvn7lXPjTCy6/hu3gPPGbx4H5RwmGrsp4hAgLZQ+DOvVGLBb16?=
 =?us-ascii?Q?UfV8aAhgIkxL8XByBiPkqn3iDmB5b0pYmj9ZVaYdwqCwy8YqCoSlzU3F4fdb?=
 =?us-ascii?Q?xNPT21t4LlJ0zY6X9Ef0jEzIJKgEWzGnosMMZaD326w7aFoqOP5W9OMGvpcH?=
 =?us-ascii?Q?+w4jca/4ryd8cY4QcxYzl4YiLIo45GcsQdoAVcCcfdekyPANkLMDAcKJ1qgv?=
 =?us-ascii?Q?FSsxW2ETVpvwmUxTVme+L7dd27XGNOKZzBsMfhsZHc4DL5rwY5E5zkB+UDvK?=
 =?us-ascii?Q?kW/HPhxEQUQJ+DAw57LMI4gqvUI2lJuU5PNrWPdc2PO7ZAB2K3Oo0QwJr5Zh?=
 =?us-ascii?Q?Y4PPUoRTWBB9w/IQb02B8IIzK/A+1rf61fNJd3ThXYxkOiLmN8bNpub6UPRs?=
 =?us-ascii?Q?uG8EgBskXdElZ6YQeVg8b/f/9hOd1KBF+U2IkG5m2r77YVxaJET6Xw/a8HLd?=
 =?us-ascii?Q?hh86MJWapB7KpBl2g8AqeAOWMIzuPFhUnFhO/0IGWasrG3ZWP1Y4yz9stMQ7?=
 =?us-ascii?Q?czVI4CPwEzl8HyOU2zTQSHyZXGrNlf/aiSoNUD8coTVdbiBF3hg3GUwHdz+Q?=
 =?us-ascii?Q?nMtn9g35mUKCVQi1EUx7/Lb8WA05+soIxHuUtBrZ+BdHabLhUfW5rb5k3ojJ?=
 =?us-ascii?Q?PaFRI6yooiSRBIz3T0P/LXxvTrSkJoPE9OB7GdRdCBf+XDDsT+V6AetwV9+z?=
 =?us-ascii?Q?gJBx6M425rcApggRGsLx/oDXHu6X7gdx7kNnpT/djKVp0yRakNBQa6pGGMiT?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b225c777-feb3-458a-deb4-08dab07c9b7b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:17:25.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrks+vCTYr8YCU3XUgrG5LBvX4kwQIApgSJtzAybfpPbQesOmJC/7SWWtlaLWg6n7X52pwbGyJobfBV8CwtBwdbrbtb6r24pSwofbep0uYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Fri, Oct 14, 2022 at 04:57:37PM -0700, Dan Williams wrote:
> > In preparation for dax_insert_entry() to start taking page and pgmap
> > references ensure that page->pgmap is valid by holding the
> > dax_read_lock() over both dax_direct_access() and dax_insert_entry().
> > 
> > I.e. the code that wants to elevate the reference count of a pgmap page
> > from 0 -> 1 must ensure that the pgmap is not exiting and will not start
> > exiting until the proper references have been taken.
> 
> I'm surprised we can have a vmfault while the pgmap is exiting?
> 
> Shouldn't the FS have torn down all the inodes before it starts
> killing the pgmap?

Historically, no. The block-device is allowed to disappear while inodes
are still live. For example, the filesystem's calls to blk_queue_enter()
will start failing, but otherwise the filesystem tries to hobble along
after the device-driver has finished ->remove(). In the typical
page-cache case this makes sense since there is still some residual
usability of cached data even after the backing device is gone.

Recently Ruan plumbed support for failure-notification callbacks into
the filesystem, or at least XFS. With that in place the driver can
theoretically notify failures like "device gone" and the FS can take
actions like tearing down inodes. However, that is FS specific enabling
/ behaviour, not something the pgmap code can rely upon. At least, not
without some layering violations.
