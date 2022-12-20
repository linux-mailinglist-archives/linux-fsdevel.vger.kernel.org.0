Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3824A652A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 00:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiLTX7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 18:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLTX7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:59:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7801EAE9;
        Tue, 20 Dec 2022 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671580792; x=1703116792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ec4f5IFKTUREx8aRfG8i8QDuiFk7WX5XgaBTdN8GbD4=;
  b=iKlD1kunp7STr0mVCIgSJGkdplwaliQn27HbPQESh6sModtie22Dgaah
   B2+zUEePuAFdbI1e5IGAiG+R1sNS3kOsdjJn2F5A3p9+yZl5f5WgKxsad
   mbxGawKMKzGbVwh9kPXT47090AyujUT+tj3mkGgKu9QtlDqglrDefhZwd
   Xn2TvZ4xP3Qp8C0cYVjkGewlxt+apoQAP1hBSm3jNmVDFX817ORg0VU4+
   jIUskNy2cyqzn0zk1TYbMdYD+xFHVENdAEzxxx32rFilbvTt6LJ8/s+5R
   YC0+GE3fuaOARcZX1BZ0SyyryTE9LJhgGDyxSsj3gd3bfgmJ4PlJ24f82
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="319802055"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="319802055"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 15:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="739952341"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="739952341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2022 15:59:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 15:59:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 15:59:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 15:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGCg4bwyxfii1prv3BsBrJdVsokDxz5oAp6Ko6LhLWzA8LB3jqh5upEvoQy5DdqG7pOIbW7unhnkrXGZ/9NrU5i1Im0vp4q5RJsTyMU+sm0Ym+NIeS8aQRrwrkyjZI1R2uPRQ77UkYWNdsyahlNDD/ngHxggpmiLXD+5CR63SLyonf1Ywel0hcyljceRadGTuPJ+K+gXhZe62H0eSDrPcFPIDhJeUiQMqXezyjscI2rjLI3H99BqnX29EYVU9tsoET4lvgPHy4obLPBEdkbcWoGJLyoVZR13Kt7S3PzUpNSgfME9AsV22ztLHZefEIso0wLhvv23oWIicTqaqbUUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmTCyNUqjPS+r/10+iQrzVWL0GF2XtmzlpTMGZvU9d8=;
 b=dV5xpOE2170gl8XG7PaZQyk55K6R5igBpdCzH/nCVu/WL04j1SzIUJHXfKH7TaGeFs/4ZfdK6iLt2x6g9QA9yIg8DeThs7TiCBW9bqERk6lsIkGP3/utLVQtZApme0zAY6kXSRcKLDr4rNVc7qAoFCgAhaRFVyJ/get/RgCg1j6yDZldJHmkStR/6DQr3dy8zn1DB5r/arWKuhsKD1sIYd7He0jbYEV5exBW9536kIJlmWycmG0xdnP2Ch7//PG7OqXR57Aq0OX7dAyG0PM5T0cWD9eK4Mfm74K+d839SGijnCMJqJSH+XmMRjD7mz0rATrDhCdJA1RbBXO0s6LHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:59:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 23:59:44 +0000
Date:   Tue, 20 Dec 2022 15:59:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jan Kara <jack@suse.cz>, <reiserfs-devel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <Y6JMazsjbPRJ7oMM@iweiny-desk3>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
 <Y6GB75HMEKfcGcsO@casper.infradead.org>
 <20221220111801.jhukawk3lbuonxs3@quack3>
 <Y6HpzAFNA33jQ3bl@iweiny-desk3>
 <Y6IAUetp7nihz9Qu@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y6IAUetp7nihz9Qu@casper.infradead.org>
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO6PR11MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fc09aa-6625-46fc-3ca7-08dae2e6447b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkBD1aAe7nsgpixdI7SonTMehHHcmSRthbHYqFxzWjH4q7FRhvmpgMvhvoyOgGg2xfRUQqyNfk8C3o+Z90hFyIyxnQrUeuhlRp1PGt8HmBD07/pO3ssh99Tm2jAWoZQbyFVggD7rBq+XnpRN4nlQSBxgpZihX0hAu+dJCpuBZxB5OiwikJoHY3TfXkOmpCt/9xgFrznDYV82Ly6n8eJksc7UHTJ0mKGAqwsDTVBlN58xBaZnGGMDpbfgU5vvZHpUYUu3sFlJOq4mlzqaj8YO6OppwLSqohEidKHpiI0zRYxiW7meOd3VB5QWkmNIYkHGdp+UEZq5mCHLv4SUVsDqoHabCnZxmFTWv/qRcAXGKlMkRBFksX9nNOH/hcbdRzwMwhRIXADfyuABmAcAv8FCivHVA9oD92F7u5IEhh3ETVvMT/AffPMLA/pS9Yi0AWybePAvEHIRXg3sbqfRq1UPOHBFmOVEVlrSjaV61I2Qzrd5034OaWl5VYy5yCLhdsSScU7NIRzKxS0THE36H8TIW1LlwCdbfqiN2ylPhlcoALtofnt1miB4HC02nm/Av/4VKd/xjA0TTkUho9H9g3pV++DUSscqhVaexjPd9wMJVAyGewcM7WWhVNfBZWVrZZgEqD0LkuZ1Dk4Nv0FUXwL591G8Wm1JIrAuoQf8bkNTbd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(54906003)(6916009)(316002)(2906002)(44832011)(6486002)(478600001)(83380400001)(6666004)(86362001)(6506007)(6512007)(9686003)(966005)(186003)(26005)(8936002)(82960400001)(38100700002)(41300700001)(33716001)(5660300002)(66946007)(66476007)(4326008)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qVW+jajq37ip0+Sfgm5Z9I769RqGNGaG660HW6uzCgUpWDjxvB5Um5qD5XWd?=
 =?us-ascii?Q?8rED9G5xpDCzqRMrxv1A1lM6cKI00CGDrDVz1t4TEmdMF23I00r3GNT+G9GZ?=
 =?us-ascii?Q?LBKLL2VMBh+uImthHQsOFwlVEhE7BeznaaIxXnkemmhoL/UG8DjjMHgrIp8H?=
 =?us-ascii?Q?gAaehc/7QUNcCo+rcii1AlVJxI4B4an/S6hl87YHN9D4ZDoUC+05uaqiliZC?=
 =?us-ascii?Q?hD6RALK1dHGFNwIRpAYLSjdScHIWYLjxvNRBuy9ZcAiTHQMAa/rpi92SE4lB?=
 =?us-ascii?Q?+YlUqBCbtAvYeT+QdAmK/vwcaIwNT1YS5oNXufendTSNDPcwWVwrMo/eSvxo?=
 =?us-ascii?Q?+fzIXrrtvhIi6u9dLajHRlcUL85HND+AZDwa/gxFYmN2h3/8/IgyE8YXtI4d?=
 =?us-ascii?Q?v3wQs4MXHja8rU3sEVMyk7sGU+Hr6UlNqgSiBmp6a9ua59Yobmj3cSF1AbAQ?=
 =?us-ascii?Q?7FtlrL/lU68HfREDxJmbaczkMQECDkia5H3BJpRbuC1WS2266EQCRrqQgpQ6?=
 =?us-ascii?Q?g+hMv1+WxG6NUOmUDhBLxjxvd93nTGuf7B/56jj72CBJ3e88S5uAbx3d4pap?=
 =?us-ascii?Q?6PpLqlES6E3ZTNSj/+v3Ljmr9KYvUVUUyTFoFOYXEXXU+twOn0+Z3p+zZd2F?=
 =?us-ascii?Q?tS1/tbmzxDLieoj+B7LPJSenTts0MTsnTvaWWHeDdTnzKz4G3R5ZuZAzfk53?=
 =?us-ascii?Q?JaRw41TgUatAs+8hldFF+RPzyqzfXia3QCURofXYSIjssNZiGa6kWj+sGFoU?=
 =?us-ascii?Q?QZzmdzEa8LfbPNP9vser3Mlwr7rYLCO7fEiYpBSGyeIhBgFQfU+eSiqAgMPY?=
 =?us-ascii?Q?XmU+0302O4FEGrqFYEQblcMsNyixnxyh3egfBxhEA8i26NPM3gBQmByfuQrH?=
 =?us-ascii?Q?kSxR6V6sx40BzZ+L9qXymo+brHXO8dHfcGsZAp9G7N5OAZZSlFuWWOBl8jcM?=
 =?us-ascii?Q?xoNH3iHZKnyaU/2KJ00hgFD/6p2pHGYrVitSOzWmL5YDg2pjWADeY2ht4WsG?=
 =?us-ascii?Q?bZdcza4I6ABC6FJ5JxsH0LfGpBoksI3Ww/TGqR6CNyCIIbusjNew8/8SC9VE?=
 =?us-ascii?Q?IpACnWDMDtgfoQE9UV5YDSMJfE1cGbypzSSikzqS5riPMb+e+iqUtGTKtRr8?=
 =?us-ascii?Q?3RFvQXoWsysVVHpU3oQt/K6PrfqY28jwLadS8LVp7VQQlmXA8LREQwNls8E3?=
 =?us-ascii?Q?8+pozk+V1rC6pVH3LmrC26iZuGRiKSP5DZ5Nm4PzejhzdGKmL6ye+mV7E3Od?=
 =?us-ascii?Q?pMkbvWfgBjEWkq2wOtYBExsrq+bk9XYRF4xJzskovE8xCsPtqP+iCgv5EADN?=
 =?us-ascii?Q?EZUvGNTKEksSqhpyJO1qL7weh8yG7fxpJu2/v0LhBlgGvvot4yn/97wVDGRY?=
 =?us-ascii?Q?LBOLNynhqrHDRy6crt0al1NHMbDhHTPnop0Hqe8GGe91LaWNg7zpg6rpDEvl?=
 =?us-ascii?Q?gOb5PMkOfe/V57dvYcWNIP5GOSS+1c9ly0tw+Ku4lgHmLxeXzpZD/epFZorA?=
 =?us-ascii?Q?RksR8g7JXGewKJpeLDTIOcXQa9qZ6Gf/7vXAKayKFK4kFH0+bVgw5vUqzOjV?=
 =?us-ascii?Q?XTHDfMpgeXYl7s9837PrqMzt9J53TqjJoAqItTMX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc09aa-6625-46fc-3ca7-08dae2e6447b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:59:44.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1GfwZihWeOcFxSCfGX79e9qPv6JEWQvRsscadx7lW7aonHP2OIYkbYHg1r2dCvC5kV7gLZLGPCAsGEX0d32fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 06:34:57PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 20, 2022 at 08:58:52AM -0800, Ira Weiny wrote:
> > On Tue, Dec 20, 2022 at 12:18:01PM +0100, Jan Kara wrote:
> > > On Tue 20-12-22 09:35:43, Matthew Wilcox wrote:
> > > > But that doesn't solve the "What about fs block size > PAGE_SIZE"
> > > > problem that we also want to solve.  Here's a concrete example:
> > > > 
> > > >  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
> > > >  {
> > > > -       struct page *page = bh->b_page;
> > > > +       struct folio *folio = bh->b_folio;
> > > >         char *addr;
> > > >         __u32 checksum;
> > > >  
> > > > -       addr = kmap_atomic(page);
> > > > -       checksum = crc32_be(crc32_sum,
> > > > -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> > > > -       kunmap_atomic(addr);
> > > > +       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
> > > > +
> > > > +       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
> > > > +       checksum = crc32_be(crc32_sum, addr, bh->b_size);
> > > > +       kunmap_local(addr);
> > > >  
> > > >         return checksum;
> > > >  }
> > > > 
> > > > I don't want to add a lot of complexity to handle the case of b_size >
> > > > PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
> > > > many people.  I'd rather have the assertion that we don't support it.
> > > > But if there's a good higher-level abstraction I'm missing here ...
> > > 
> > > Just out of curiosity: So far I was thinking folio is physically contiguous
> > > chunk of memory. And if it is, then it does not seem as a huge overkill if
> > > kmap_local_folio() just maps the whole folio?
> > 
> > Willy proposed that previously but we could not come to a consensus on how to
> > do it.
> > 
> > https://lore.kernel.org/all/Yv2VouJb2pNbP59m@iweiny-desk3/
> > 
> > FWIW I still think increasing the entries to cover any foreseeable need would
> > be sufficient because HIGHMEM does not need to be optimized.  Couldn't we hide
> > the entry count into some config option which is only set if a FS needs a
> > larger block size on a HIGHMEM system?
> 
> "any foreseeable need"?  I mean ... I'd like to support 2MB folios,
> even on HIGHMEM machines, and that's 512 entries.  If we're doing
> memcpy_to_folio(), we know that's only one mapping, but still, 512
> entries is _a lot_ of address space to be reserving on a 32-bit machine.

I'm confused.  A memcpy_to_folio() could loop to map the pages as needed
depending on the amount of data to copy.  Or just map/unmap in a loop.

This seems like an argument to have a memcpy_to_folio() to hide such nastiness
on HIGHMEM from the user.

> I don't know exactly what the address space layout is on x86-PAE or
> ARM-PAE these days, but as I recall, the low 3GB is user and the high
> 1GB is divided between LOWMEM and VMAP space; something like 800MB of
> LOWMEM and 200MB of vmap/kmap/PCI iomem/...
> 
> Where I think we can absolutely get away with this reasoning is having
> a kmap_local_buffer().  It's perfectly reasonable to restrict fs block
> size to 64kB (after all, we've been limiting it to 4kB on x86 for thirty
> years), and having a __kmap_local_pfns(pfn, n, prot) doesn't seem like
> a terribly bad idea to me.
> 
> So ... is this our path forward:
> 
>  - Introduce a complex memcpy_to/from_folio() in highmem.c that mirrors
>    zero_user_segments()
>  - Have a simple memcpy_to/from_folio() in highmem.h that mirrors
>    zero_user_segments()

I'm confused again.  What is the difference between the complex/simple other
than inline vs not?

>  - Convert __kmap_local_pfn_prot() to __kmap_local_pfns()

I'm not sure I follow this need but I think you are speaking of having the
mapping of multiple pages in a tight loop in the preemption disabled region?

Frankly, I think this is an over optimization for HIGHMEM.  Just loop calling
kmap_local_page() (either with or without an unmap depending on the details.)

>  - Add kmap_local_buffer() that can handle buffer_heads up to, say, 16x
>    PAGE_SIZE

I really just don't know the details of the various file systems.[*]  Is this
something which could be hidden in Kconfig magic and just call this
kmap_local_folio()?

My gut says that HIGHMEM systems don't need large block size FS's.  So could
large block size FS's be limited to !HIGHMEM configs?

Ira

[*] I only play a file system developer on TV.  ;-)
