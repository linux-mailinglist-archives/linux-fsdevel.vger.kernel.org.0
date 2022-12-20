Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE94565250D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiLTQ7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLTQ7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:59:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A390EB1F4;
        Tue, 20 Dec 2022 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671555542; x=1703091542;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rW9X1oxUj2wffGBugp9bhcRfrdMa3tFdhW91yoE5G+A=;
  b=nhgAGPcxUvHp3rO6ai+X4Fp8yXUo5vplvkx8qaP+31pblf4CJwEvN4uy
   FWPmMO/OzSCfyEVyA/zJVYsl/wsWpX6NNUVr5TuY1DVHFUavVb7j2obFv
   fzFoJdYIfTGJd2xv6aI4DS1N5gmSSqXQBFSH6jY2X8Bt0QAXq740b+rVg
   yoHYbQsgBWUI1NJ9+6jArwtthLaZ3+BLL+S/Bo8caGrJASmMaZmuGt3O7
   09h15brh70Pz/qMK391J9Oe+f/4a+nuhHLAmViff+5QE4lpU5xlfKnIia
   Bl1a4ygagtVJ8c/tZMh+LY1DEgRPUTdkw3v4attDLFoN94oEFOymiCrny
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="319713837"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="319713837"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="653181153"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="653181153"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 20 Dec 2022 08:58:59 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 08:58:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 08:58:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 08:58:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwVAlpbqfTu1BdWiOVfjqjC/OExRucL+/RMMfUWMQvc4fUKqyyY0aVhkauDn7sR6Vf1vp269vy3BNOeGobA/oHYmAQhm25aL0QEV8yj8bqQEONytFgEAwxQEm0a7JVmhORVoqO+OAQqnZhj3NPmFNzg2f8csJcpdNvAh1Uy+6IrugncGYAzG8naSpLVQ7gb2Onjg2b1KSrOkqC5cTrTZYmTSff93JgULo/0NRqbjKM+FXEHdfECjGL4PJKUei4vYvKWQlJ9/RAqj/jrqnxNRDMvp292Pm0afTsyGCuGO0yyK4ORBlQ5r7NRf7SPmgr1tU1JLfUaIrkJde4/yVCk4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0ipdrlD2U9XDNTIAn8zgr6uUkvePemD3sk2E1sl/zo=;
 b=AY6bNV3Iby7xqo30rZ5McfNX1/+sn+Mrj9H1nggVV6YysmcLkI4HzfofxEcq+kgq4Hbo4ZgTYDP6T0RYihGrDQpl6v7ZGtD+ykLtbKuXIGvHjJDjreT5aCdPrzxcdHU6VKDifwHZS2USF2+8B1D0K8MXqOfgfsdHoBjrLBGKgmOuXk6vsfmbdszZfH5UC7R03rBfafQoEWif3w+VZ6EXCkPpgt9NtuemVWMiHO15r46725W7kn2cOpu3iuEeJIXcSc3Qa1blRx9jkTgqLLP/yA2siOphfJFA1jego8x03Y2JYxo5OYygtRN9Y8ZL+8UgWfBIqhfkppkasCs0Tp5UpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:58:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 16:58:56 +0000
Date:   Tue, 20 Dec 2022 08:58:52 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        <reiserfs-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <Y6HpzAFNA33jQ3bl@iweiny-desk3>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
 <Y6GB75HMEKfcGcsO@casper.infradead.org>
 <20221220111801.jhukawk3lbuonxs3@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221220111801.jhukawk3lbuonxs3@quack3>
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c93ed7f-58ce-46be-408b-08dae2ab7b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/0fog5+Kn8hcd5XqEGgU86816wdpY+uG0TsnFlN3t2NB5Kurrkk0+sOSHazgCxfNAS1vNIS26qHQHmSz0GXdYoUnLsPajXBOJKgibdXa3OQEVxHU0E4fbmMxKZ82H7pAKY1Uz2VAkKtj23DmR5Q63Kihzxi2DD2wE7OTv9ZlYKWc5V5Jzo/kYLp/+jeMpvUgthLfY8HAmmlVfLdDT4U161qxOAk8JzzFDBcczIH/wRxHHLMXq5Xxqe/PgBQQxyfPriup1opAL20GMIxD5uMMeOZaxLwolBRt4IEtL40jkNQeVa9bBKRdIGmntXAoOl5tF8VlyE6yhDzS34WNd0jFG0KfTSpIvElgaAUG2EWIytm6+6EZoBpO1wuz0b6xLzGUgF4mmyCTNaHV4rcMuyst9BQKtkaPpc23uw+QInY+sXq/vobNXSEbDHDPy0vbeeX8frabnSsqQ1laL2aGZvAd4LFyDMskjyC9EwOCJ2ldNM3sUMwVuZGLa+QfzBGQBYQ+BH35vjPB5mVlTkfNiijW81JpTIAo1UkhHGSSUfJa6gGMAdWeMTGWjS3aK+swsIK5ltdyUVE6duhrWTC6d+l2R1+uX4Nk13Vi6d1yH8VocBmv/0lBggp4jpT8CGSWAf9WOQNuPJZ/3GVTYBsr0AfJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(6666004)(8936002)(5660300002)(83380400001)(186003)(6512007)(44832011)(26005)(41300700001)(9686003)(2906002)(478600001)(316002)(966005)(6486002)(82960400001)(6506007)(6916009)(54906003)(33716001)(86362001)(4326008)(66476007)(66946007)(66556008)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VtyIpxqaScwchupfI5VaGyagOF1dDnW+j6/pb05TRzpv14auvh5ZCMi+aQTh?=
 =?us-ascii?Q?0q4Gu/hW68oihthDwAEtIAN1Ey2TFs1PUWjI+GJ1yAv6Tg8TNDulyPpYM7mv?=
 =?us-ascii?Q?9P4k6yIPYI43mldUcv9t5+RIzLG09FETDBR8J4/cWIBgEr0OftGgJ1cRTOh2?=
 =?us-ascii?Q?7sy2R/3zmVkVKYpdSafSyVrpT/iW40iQCenGNA8FRj8kdsFkYHUb0QaVLccM?=
 =?us-ascii?Q?yZ+WtC0zjo0BcRo2freO2MbovbUH1p1jNjO8olQH5qcexjTtCOUgKF0+Tv1n?=
 =?us-ascii?Q?8kb7G5f/bw3ryKpItxLbhr9BCLHxxg8sB8NIHo8lyIK27St5TgRIVoLX2UKT?=
 =?us-ascii?Q?KucCZANOlKJEeYdr3Y9z/xL5/rOn0TDHcyTTffhuyfgWTr5Q0HraiXS9mz1O?=
 =?us-ascii?Q?vqxxcY4sx7VWY5YtAzfCzSEg0PBGYn3sJH4au2NOxk3QAaablhUSM//osIZx?=
 =?us-ascii?Q?vEkEps8BYCvDOKrtkJfv0M+iT3waT5gdN14jgimOW6nHqUEl7iUN3+wa/IFb?=
 =?us-ascii?Q?CAyiFDu3Y5kANg4huq26Bb73D6PqMU7PrppA3/zZxr9ZbakTNdPiVuOpTHK3?=
 =?us-ascii?Q?uZjuSYvwo9T66jCOr2Vy+/H6lRTFyvxXFids1ErNbz7cMl5NCUg1iNoHxBwZ?=
 =?us-ascii?Q?aCZF8G2PYI0ATOHHLcm+aohi9LYmoHca+l3zgIXc+8iAhEBBs4GVUzXEaRi7?=
 =?us-ascii?Q?hfXH6V8PcoTBZOLbkIub/QYfY6/O1Yz9hhd+AVoNIpCmspNZ9YG9mpQ+OPhI?=
 =?us-ascii?Q?XD0DmpfHastlZIrUlBmnZ5ejTNLfDZLO4s7az4IY6yRzdESyWnleAGISwmTV?=
 =?us-ascii?Q?XHhPsmTY5Itz6YmNQh8Xa4iPSVunFqX5yu9OkmuCkzU2+qoOEmNb2+YVmc8i?=
 =?us-ascii?Q?z6ZmDpUP0Io28a6FsCGWQo9m61KzbyYkRK48eY5FOqj2kzDANMHPbozA9Go+?=
 =?us-ascii?Q?YXpc5nCIY6MXjSm7xfNFLT8nMpbVcvdznuh/BTh7IUBugI/wm/bTIsdpcjtN?=
 =?us-ascii?Q?AoQaUvT04HOlbaL5H/iKQ+6JGh93VgRJ/cEvQ63MlaFVlPZmtvJ2ctA6RTky?=
 =?us-ascii?Q?+cA808qX4God8ksuRobmOBH9PVZhFGsU6djqVLPvMX5xF7VoXwBjBEkwnmIv?=
 =?us-ascii?Q?JMpEXOaSFkMOwt3Tdi8h7/hHT5H6uQXkzbQ7AvUpVO8GkLhG47rlrG15TsIc?=
 =?us-ascii?Q?962q53YcsV0eZGBFDHFcqq2Ym657U4cnTq8HaFYTSiLA9MdBaNDJ8Zqg5aHk?=
 =?us-ascii?Q?u58F2q+pLua8XCHZMA/PYiDYcqMA1p7nmkIgysnuVz/4Bx9dHnMh4bC11qDN?=
 =?us-ascii?Q?tBP3RhIde4le6cnUEON+grbFZ/ORlekrZyG40cUcB4FzYr9KfseLKN+HQy5o?=
 =?us-ascii?Q?NcMpVditNHcTf3PJ5RDCnPx8paaA0FPqeu23NcKK3w6n3O24vDficJnz4c3f?=
 =?us-ascii?Q?nDwL4xLz7i3Y21tMs/k3H1P2IEVkC4XhgenPiJPipayLTGBhxQeRQM4DARve?=
 =?us-ascii?Q?Rrc7aKbnr3jHmNdN0IrPvqeJUqSsTiv1knyPj1L+VRtyjYENZnXKz4qaD5Fh?=
 =?us-ascii?Q?KAZYHRxduIO4WKW85DYatXgmFA1Z1siHAx9cW04t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c93ed7f-58ce-46be-408b-08dae2ab7b6b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:58:56.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGd1cHt8ojvd+6opft/1k6ebbHkI22Ago+L062atomjdFJ8ubQVxnKPw8hTliK4kI2bc7WwMtBdglKWCPv5YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:18:01PM +0100, Jan Kara wrote:
> On Tue 20-12-22 09:35:43, Matthew Wilcox wrote:
> > But that doesn't solve the "What about fs block size > PAGE_SIZE"
> > problem that we also want to solve.  Here's a concrete example:
> > 
> >  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
> >  {
> > -       struct page *page = bh->b_page;
> > +       struct folio *folio = bh->b_folio;
> >         char *addr;
> >         __u32 checksum;
> >  
> > -       addr = kmap_atomic(page);
> > -       checksum = crc32_be(crc32_sum,
> > -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> > -       kunmap_atomic(addr);
> > +       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
> > +
> > +       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
> > +       checksum = crc32_be(crc32_sum, addr, bh->b_size);
> > +       kunmap_local(addr);
> >  
> >         return checksum;
> >  }
> > 
> > I don't want to add a lot of complexity to handle the case of b_size >
> > PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
> > many people.  I'd rather have the assertion that we don't support it.
> > But if there's a good higher-level abstraction I'm missing here ...
> 
> Just out of curiosity: So far I was thinking folio is physically contiguous
> chunk of memory. And if it is, then it does not seem as a huge overkill if
> kmap_local_folio() just maps the whole folio?

Willy proposed that previously but we could not come to a consensus on how to
do it.

https://lore.kernel.org/all/Yv2VouJb2pNbP59m@iweiny-desk3/

FWIW I still think increasing the entries to cover any foreseeable need would
be sufficient because HIGHMEM does not need to be optimized.  Couldn't we hide
the entry count into some config option which is only set if a FS needs a
larger block size on a HIGHMEM system?

Ira

> Or are you concerned about
> the overhead of finding big enough hole in the vmap area?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
