Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60895977DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiHQUX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiHQUXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:23:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA654647
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660767831; x=1692303831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OwiE9lCUQKxKcLF5VCJOym5RNh5MQTZ4TLa14BJDptI=;
  b=DsJsLMoyk17Tlf9BmVeP6aPxpeeOFF4B8j0mbr4zoYOvukyByuxzJnzE
   f4wj6vMjaJA2leIl21hNdJTi6+2AR+7afLAYA9mU7E4GwTbejzEYWyW84
   cHr1n1RRN8opk/6nyrIkp95eZspEmfmBtZaOQ2k4jA5/QnV4ntGQ5jUJg
   zpSTqtMhUqbWyDlzONU5o6koec5hnuGni1bBpO475opiF+oTh6mgE7EHe
   cYQIRtzFqBnfBnFjGlYxsEWADaAuBMTii4aWXHJXntskHtIFeldwjx3G9
   guUSgILc/y9M/cPJw3prZf0TLsFCx11ZLCzTqB9eAw4hJWXqTQbdGIinA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356591328"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="356591328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="935512942"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 13:23:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 13:23:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 13:23:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 13:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6qzYOSsc+9DyQARQNdo5gzAr93ChLCWfGqlDdy8jXF5aJY4FeZyr2nH2lMpupIepzktilRUOQBVbLuk9wAsLoiAooiqbYCqtGb1J+ZHj6X/GOkumml/HwU69/LlDDV9ugL8m3NJaOJ90Dyyn++qfMr5Vthdks1oDUvIdv3AJNnf+amwsa3Oux6Xhsald+zpHy8AEcK52UsMl6m5VJEKLoWQT/ARFnZv4Sba2wtdElNnCP3MD+74NL6+AthN90ELkOeMvzEYhOor+AtvKb2l8CuSdUkn6O6c+NfxMPHfq9zlMG1do5TtKlJlB0HTU2GOwOEhlgFIiStfuN9yKBvC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6uT/Ox3t0lFQ1Tfk+7ay1LTiYdRPk7XWo+yBocBEJc=;
 b=JdgYR+hMLXqlBNiUQZLwG9mozR3Y4zdSAeaJE5FGbLjCRC17RSafj3F2dQy2wUJ3kgbbm8Qkikx4/tUMvpSJs+CrA/MospJOfRcNy/ddNHcWVjQfQS9WlMbeyFkdgzSdERo0Htt2XWyvdLCZYx8owtZFMiCaGxDUxjM1Upsj8OYhss+nN4zXroA7JC/eKBsj/u5sIgLN7npk7/AZpe1p24396tWftdszPr8tbZyZkO8nq5T4ABwn+s92RhAvwv6V8KCks2mSSXu0T/2ExwA1KsP9PelYIU4PlNQZattAbgnb8OBo2IOZFle4L1ElaNbhIcYGvRebvCx7zeHyyL806A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MWHPR11MB1968.namprd11.prod.outlook.com (2603:10b6:300:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 20:23:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%5]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 20:23:45 +0000
Date:   Wed, 17 Aug 2022 13:23:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: folio_map
Message-ID: <Yv1OTWPVooKJivsL@iweiny-desk3>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
 <Yv1DzKKzkDjwVuKV@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv1DzKKzkDjwVuKV@casper.infradead.org>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d141520-8a30-45f9-b706-08da808e629b
X-MS-TrafficTypeDiagnostic: MWHPR11MB1968:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7STcB5To5EXYLUuQNuIqU048BSJQWS/DGYerS6YCxRDC4Lb/1NrNXG8WBKzXMl9KQKoe01FFr1hFum3PmICc9398rBd8FEyEazIslW010yE3d5i3bwDBEp0vJhTOnv3Axq9ZIaF3XdZV8n0oQd/KyZHhEl68mNvSzMmb6lpFyHcCqBUTWeaKRwjnYLhOZKwlLQ8UiJwaAIfhp0+Uxgm/PXPtRLs5QOFehW/ZtjUbDMOqL325LmHKXqMpvxqRd0dKVBv6WBuxPfFMpPKTBW88B4vWUfeA7LKL7x27VRdgRjzYJKPqtC6WdxAnkLC8S+zbPKFANRU7fZbiXjyDytzyQ8rgObWWKs5rZQp76TT0jKQChfEg3zcKDcsOfHr/ph3jmfShhsKf1C/jd9xgg33LCub3GgG68LoUq/QtDuQAkG6faQOCWuhLIQ/wnjYCvvNQ4utqBpBg54erAuadGxQrxO54Ut0ScVLctTS/brtkl2RrW3velq59a7OIbauTT7WRPdY5ySAF2w3SAnvkr2We42Tl+X1PY5zkzDm8LJxyE1BDGvhXfB5CSIj5JjF937o8AaxrPXgB9wUtNae2wIPIoXVr1bcVvFF1gPStq/vMhRp0wTlosfcfIldAvIvhlc9NPnyQf+gwLsFsSzIosBvdTtmq6meTKvlQ6vTHz4ZhULxbHaa2L02zNrL2621B23Sgy2fU4HgRGSlKkC/wnQ8ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(136003)(346002)(376002)(366004)(7116003)(38100700002)(66556008)(5660300002)(66946007)(4326008)(316002)(54906003)(8676002)(66476007)(33716001)(8936002)(6916009)(44832011)(2906002)(82960400001)(86362001)(41300700001)(9686003)(478600001)(26005)(6506007)(6486002)(6512007)(6666004)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FeQC6HwCerI3xMO8tcCD3g/RX8UKpjEj+YgfBHvXXhDLEiYCCjhD37fV6QW?=
 =?us-ascii?Q?jwoGcxRIoUFdFWsG8/K3qJKPuqJ0JC71do7RjT/k7E1k9X9OS6xUa78DyI37?=
 =?us-ascii?Q?DJVgTQ3EhGYZY2YlWlYz4/szyATxp8oHT251CWsaUtXCrO1/BAdAv4q0eIaD?=
 =?us-ascii?Q?/5ST+Cppi6OTR8K96BVXGA02p8AuIVW8+9fIHRGAjm92Hm5ZB0/2Mh/wvfsd?=
 =?us-ascii?Q?57V3b88EqScouTv7/ilhRslA5uQJ8OOzV8/RFWTWxeGVKe7LIdT0wslatzgp?=
 =?us-ascii?Q?cDLx4qp7n4twi3n9OrkGbM/EsCYgoFuvrfcAIGwcByD02yT4F1M4TTjepeu+?=
 =?us-ascii?Q?3naAxl+drWxHb6XWfBc91wN8K5zkKoT4CRrTmV3ff9txAdOtw8LOz9SxVFyM?=
 =?us-ascii?Q?vylmNhNEV4waPbMmHiAVhPYPKQQdlfHYIhOgOvRtZ0WFA9Wk8nWmkA9D5MLY?=
 =?us-ascii?Q?6xDzxeO9DOm5G++PzvPefdVDOGrJWbL9Eg6wYeO/Aqz4QVuGqZph2jrAvOD8?=
 =?us-ascii?Q?4RT7GCRQecUjP9ketpjKy1kJpdrfbUI7gAawieXdsF7UM5ePDJB8wCkvSHzT?=
 =?us-ascii?Q?vl4Sto75TDstXJy4BFf8MJcjNE6Yh9zSx7RHcZkqP/fVU2OYqO5Q7LYf8rPD?=
 =?us-ascii?Q?4LOk9eyBPoPF4l8c8gWTu3DQHDURTkLpwraRPnncU3szPcjgTwwvcd52wJuD?=
 =?us-ascii?Q?DSiqkdmbb0GQEOlQlGrsL7MXSFfsVaaHomZb/bnbxhKDGIU4xO/vwYFjvZcS?=
 =?us-ascii?Q?baHGbDooh7jFFypeNBoWkSu3/GhnssNROXyCWOMWpc58d4onRjJ19mc5LWAl?=
 =?us-ascii?Q?MtZ7/Q7W1rp0s9vr/uMY5OdlAv8f5EpAD/dkIjJIDfdoFvDiaFmvpRbrt0M0?=
 =?us-ascii?Q?vB0pA9ai+02VmCnQX6wCDjvTMFKzeKV5Zs8hNfPJCIG0dB76cBxPThUK17rc?=
 =?us-ascii?Q?lq075OGaCQpXljcQ4ZhHSciW5Arm63wQvBXkgXXfpg/FiM4wFbU7pyZUOK4Z?=
 =?us-ascii?Q?zbvniJHTTbVkdiuFKhq6tNGcvMJcA17RbSBMRgf/cre4vYby0sdwWcYWdmPE?=
 =?us-ascii?Q?FtPTcdhTF0QqZi5yfjKB6s8K+cyhuJ3o2ENDeiCVwA+Gk5xpn9vQDUbu581G?=
 =?us-ascii?Q?qPfeCkwvBdUd/+QP+o76z88Kyx/ocWlGO4eyh6nv2t/HselA0Mv8ZQJPSoG8?=
 =?us-ascii?Q?9rdGFlINCZunN9kDZcZhxHdNLW3ii5F+nENRY2fipEqXqVS7bEE4qkfj1xf9?=
 =?us-ascii?Q?hfmLMqkPVJya1uNNCfkCCWnpi8N1m4zHLm2l3wi4XWbdi3Bgm7f3bTncqUHC?=
 =?us-ascii?Q?2ZfYGuxcfD6awJY7uLZbihg7MNQLrsc+VuakDR2qxcM/wA9sr53ba5IfDGwf?=
 =?us-ascii?Q?Ni4STlIyE22D/r3TeFup3m1niJCMQqPpZ/CnTAip3w1JUevfJ00NxgZ/hDCr?=
 =?us-ascii?Q?/XlYqad8S4FQogJR+blT0sfAI8jl12A+Cs1AK7km0gFJBckC7lks6kdHxCe4?=
 =?us-ascii?Q?+3i1Nt9hADc4uJBrRr1AxaZCbLRwNG45Ip9FgLvfBd6D9hpRQUsWnZLm1Bh8?=
 =?us-ascii?Q?5Z+lJGQPG5jFZlupcT3ZW1WGXrfm/Gtx0c4lfPN2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d141520-8a30-45f9-b706-08da808e629b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 20:23:45.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ/wsFpVpdcvsTVZY8986Mbyxz3G6XOCfxaTWsSTNR2QWX0yKjhkBMRca7RINaFzP45kQU37Ds/niASafkaHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:38:52PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 17, 2022 at 01:29:35PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> > > Some of you will already know all this, but I'll go into a certain amount
> > > of detail for the peanut gallery.
> > > 
> > > One of the problems that people want to solve with multi-page folios
> > > is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> > > already exist; you can happily create a 64kB block size filesystem on
> > > a PPC/ARM/... today, then fail to mount it on an x86 machine.
> > > 
> > > kmap_local_folio() only lets you map a single page from a folio.
> > > This works for the majority of cases (eg ->write_begin() works on a
> > > per-page basis *anyway*, so we can just map a single page from the folio).
> > > But this is somewhat hampering for ext2_get_page(), used for directory
> > > handling.  A directory record may cross a page boundary (because it
> > > wasn't a page boundary on the machine which created the filesystem),
> > > and juggling two pages being mapped at once is tricky with the stack
> > > model for kmap_local.
> > > 
> > > I don't particularly want to invest heavily in optimising for HIGHMEM.
> > > The number of machines which will use multi-page folios and HIGHMEM is
> > > not going to be large, one hopes, as 64-bit kernels are far more common.
> > > I'm happy for 32-bit to be slow, as long as it works.
> > > 
> > > For these reasons, I proposing the logical equivalent to this:
> > > 
> > > +void *folio_map_local(struct folio *folio)
> > > +{
> > > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > > +               return folio_address(folio);
> > > +       if (!folio_test_large(folio))
> > > +               return kmap_local_page(&folio->page);
> > > +       return vmap_folio(folio);
> > > +}
> > > +
> > > +void folio_unmap_local(const void *addr)
> > > +{
> > > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > > +               return;
> > > +       if (is_vmalloc_addr(addr))
> > > +               vunmap(addr);
> > > +	else
> > > +       	kunmap_local(addr);
> > > +}
> > > 
> > > (where vmap_folio() is a new function that works a lot like vmap(),
> > > chunks of this get moved out-of-line, etc, etc., but this concept)
> > 
> > So it aims at replacing kmap_local_page(), but for folios, right?
> > kmap_local_page() interface can be used from any context, but vmap helpers
> > might_sleep(). How do we rectify this?
> 
> I'm not proposing getting rid of kmap_local_folio().  That should still
> exist and work for users who need to use it in atomic context.  Indeed,
> I'm intending to put a note in the doc for folio_map_local() suggesting
> that users may prefer to use kmap_local_folio().  Good idea to put a
> might_sleep() in folio_map_local() though.

There is also a semantic miss-match WRT the unmapping order.  But I think
Kirill brings up a bigger issue.

How many folios do you think will need to be mapped at a time?  And is there
any practical limit on their size?  Are 64k blocks a reasonable upper bound
until highmem can be deprecated completely?

I say this because I'm not sure that mapping a 64k block would always fail.
These mappings are transitory.  How often will a filesystem be mapping more
than 2 folios at once?

In our conversions most of the time 2 pages are mapped at once,
source/destination.

That said, to help ensure that a full folio map never fails we could increase
the number of pages supported by kmap_local_page().  At first, I was not a fan
but that would only be a penalty for HIGHMEM systems.  And as we are not
optimizing for such systems I'm not sure I see a downside to increasing the
limit to 32 or even 64.  I'm also inclined to believe that HIGHMEM systems are
smaller core counts.  So I don't think this is likely to multiply the space
wasted much.

Would doubling the support within kmap_local_page() be enough?

A final idea would be to hide the increase behind a 'support large block size
filesystems' config option under HIGHMEM systems.  But I'm really not sure that
is even needed.

Ira
