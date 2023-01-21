Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44A67650E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 09:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAUIGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 03:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUIGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:06:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAD3589AC;
        Sat, 21 Jan 2023 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674288365; x=1705824365;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IeMSGOpxw2++XNqpRm1m5V6V9+3fiE4nA0vO0AvLI4s=;
  b=fYBWLyQAsZRTlNe/PN5UnfHgsonsVNuB2obbX61EoSgDjqk5Ww/Fofta
   HEUTqQu8p8zARodQg46gqIIbGf9Pyju/OaFiekhb5su8fHDO1rNXuva5U
   Ct8t89Bb2GAlaprsS5a8m6fSAv388FZx1m20X6LKtXVC0ZxYPBGWYMUZt
   DW+PYyC678frKw1TWqnhMXK7jNb6BamKNiQLu32ExRM75ccQqvTir6j1r
   lhagNG17enrkjlbtGxKvhBYzVZTzocMXua8eqIy2dEZ3Ta32LlbRbDdaF
   aDcpQxgJ6BTKbmWwnkEGX6nosTQz386VxV84zYG3odMHSnKZdOLSK02sW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="327040924"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="327040924"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 00:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="768971396"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="768971396"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2023 00:06:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 00:06:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 21 Jan 2023 00:06:04 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 21 Jan 2023 00:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1ksVupYoDtFffLSM1pqNeALoA7/R50suMYzKxUc7yCMQ30lg9pyIZ0EmB62MXAU2amjI6Jufu2m4yXa1gldOPKXNVmW82cHoqnJsNx/d5GHk7RSn/cmGPrA5Nbss6Bb1mOmS3ZulYtJQ28b455D4EeM58Q7s3+wZu6qmq4WQC4BODxl0OxTa8dkoT9ZIMGsSpZQ3hskSQukpqXbcuw155v5JaV0WxFHcFiGx1pdm5XdpO3OXYidao+hyzfup3vGSoA4M3bEybcWBWqg67IulM8xfrYWmxD3elv/hfZmNakYMaguMfjHoTw8umzwAtW0W6uMskkYvBGS9CuzjD7jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN1QJIl8g+9jt6oRxgWyznYY7ALMRiqVAQNrq8G/Adc=;
 b=OptwxcTmmndDP7ubbYYMY7sBCtkiFH9Qtfn+OVPsI1QxHPKCLrqUwpxZsTj1Y75m5qqLVME2Ai4d6rCFj5kNdLeWJgKl82SnAm3lv1taWwvsGGPULwOpUdny253w/tAsleVVhJtyyrztzD6XDfKtDozi7C9Xf8g8TDGbSPUPPKQgUwBo8o2bPCeWehl74H65f4O/ZZyUbUvK1UL3gLKYViUw5TCMM0RzNl3hlRJF0t/OWhFDLcbUpimRTXPCMvcMLyvClQff7osbYWeuSARW3to30Wk7PoJBHfDKkb80WhyKV4G728SM4evYPQ+BCDBOU7mP5S2dVVWLcUyygfFrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 08:06:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 08:06:01 +0000
Date:   Sat, 21 Jan 2023 00:05:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Helge Deller <deller@gmx.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox" <willy@infradead.org>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <63cb9ce63db7e_c68ad29473@iweiny-mobl.notmuch>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org>
 <Y8ocXbztTPbxu3bq@ZenIV>
 <Y8oem+z9SN487MIm@casper.infradead.org>
 <Y8ohpDtqI8bPAgRn@ZenIV>
 <Y8os8QR1pRXyu4N8@ZenIV>
 <99978295-6643-0cf2-8760-43e097f20dad@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99978295-6643-0cf2-8760-43e097f20dad@gmx.de>
X-ClientProxiedBy: BYAPR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:40::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efa22c9-7e51-4b38-f14b-08dafb8655f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86i59CnWB/1olS3ocn3tLEWuRYuHzmfz+F7CZLwpD8z5wN+5Cp4jTTRiVL+gDRNYs97xWusrzJLok9PGFXngEJBOUKCovEp4wn/hoTflHej/jGrup5Q0tGwKeG9avoPynPccOlRghsDfS+x5fwcMAvLrAXnWWcbcSzftxg3gUhLOM2LGzGvO2DkozxNMvT/Hhtv7KoocF5HlcgGIaBFeL4elWiAsiw1hwMxiHLRxFaRTFqLx5jAlVU925zNzE7u93J7RxFzzygQmiC8EsjcKZpBNO66k5luVF5Rv/lIf6OHc/Hq2zPfiW1vpotXhU2WSq24wNNtpBLU1iQFcJqkzLlKakNNZGqEPp3CabXV43g76A321SecPR1WsN5IeF58H57IeflnrsnrtsAcHlGDbeot0fs0Spbe5Uqhy5xiDLLAFOz25oaHozUj3nJuH9rhl4FnVT4rVAP+64ySMYWN+2CHvZw9SWTg3k+lQBPlIHVkibewbWUlXWR6IO49HtIWq4V1SPi1i0hmVTkEMDkFKQhsTlEqR3qD3tJPt6uKKdthtrYraAZ3f9XEhcAuu3ZWOTmiM5ONmLBmvkSieYoWkZDjxbBZFhyTWryWsZJw3nOKcpcz0yA8dYXEWZ7jqZKmsAwGLKDGruTLBtW0csaTvLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(44832011)(86362001)(2906002)(66946007)(9686003)(186003)(26005)(6512007)(66476007)(41300700001)(4326008)(8676002)(66556008)(478600001)(6486002)(966005)(316002)(6506007)(53546011)(54906003)(110136005)(6666004)(82960400001)(5660300002)(38100700002)(8936002)(562404015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zj88QdZ9A+PVaaMf562CUO3KQUeoDBIrOKqyQgEBQ4SGPbxEKfUmDVqWNCS?=
 =?us-ascii?Q?A74glklj1wYy3bsWZl+SirMoAwnM8vuoAgdDQaHBeyqAtNoz9ryXhjFtvuBL?=
 =?us-ascii?Q?szi0I+yeSfm0GF2oMGYQ8Xm/Xn7Fi858sTVyysWowaTg2jfmW/3epkPHLFVh?=
 =?us-ascii?Q?iFoVIGKiaHdM4CL569a7IOfDVM43Gg6TkRPfZyw/gh++qS5KBucfBjPOKYFW?=
 =?us-ascii?Q?gde4BC3lzY5UF+P0gXwdzF1XgkUfmERqZCj83i84e3mnrywIJ+rjzRWnvLa+?=
 =?us-ascii?Q?Z7grI+XJ/kF1aDRvmAPd3p5tuZrytWOATwECNgAfJBMJVIm7BRsFuE8vR9tJ?=
 =?us-ascii?Q?q1jYP/ULPxCZ1nkYGBD0Rfi0rI66Jm7vEVzc4hLfA8Eg3cGH/cC+V7NEO84/?=
 =?us-ascii?Q?rUgN8xiH4LIhPGoMZ2bP+x/KqF2DObKqx3uhOgsRN2Ajx4asWp/NGRVM9Kua?=
 =?us-ascii?Q?iQr+yC5FoJD/2aDkgrbFMJUdHqmwIIfXTMz3IhMfoafxBASCgot831leyajp?=
 =?us-ascii?Q?qY0WW5RI62HpvJ+HUeKynMRFr1cnSHt92P62Vo8SO3pKdqxuTQy/Y+Dt5rhx?=
 =?us-ascii?Q?F6LFGn2C0V+fukaFKhgNK24wWFlTJIf6cdRNjLZNBSUvwBVF+4TvISWPyNKn?=
 =?us-ascii?Q?jy+sy7yt9X766QqSVCPe0PAaEG/I7dYkU3bafAygxuN4zeASjvMskUuIh/1B?=
 =?us-ascii?Q?Ifjq+sYVlLlDk4ALs/0kRvhEuS9Gr3umLKlkTPS2+8dwx0VFc0q22m/i27KQ?=
 =?us-ascii?Q?0ylsS0T7nOLcLQ+h4ygpph9FGs0K4nqGtdLyI46BlOmaBd+SD0CsJNDgrVKB?=
 =?us-ascii?Q?XdbNqszC5p24LZiBOxj6AYu8+R7W7b0BkbV495gU7jcO14I0zqGeYg9KgJ/m?=
 =?us-ascii?Q?aSSNqRFLa+/geSPPqvlfuJ/zpKO7zy6LUq3dmSfNQl4BMxFIgMS+j+JYHxA6?=
 =?us-ascii?Q?jmdbH83VV6iLyrLpL5ebBZ6blfQ6Fpu6IcDBaTOo4FzTv6t+ekcmtZi2Vi6U?=
 =?us-ascii?Q?0s3ZTy4CvTnlwF0XBJsuxvuo7wnvnmm89M/eXw3AP5/f8sgGaNnSY2lJGrL2?=
 =?us-ascii?Q?Bokv70AJA2Ba1CuywQFxv1U1HG2tfJEugrhNGLHR8owJOpew7ZZT+6Pgk2AU?=
 =?us-ascii?Q?2yQROgxHNr32ljHXt8VjT3YDFjpK852CH2HE0YOqZ/EpCOkbGLUe/yPZ/C5G?=
 =?us-ascii?Q?WmbMYTExAy2lJJW56xgTx5weyHiS2QbS0QPmQgF31HZai3B2EUe39NuuJ+Iq?=
 =?us-ascii?Q?Iyum7+qaGYQa8ESljpmWe3eJ1uuc1ll5P/g7Itcr2rYa8FXpL6vEi+z/ICqE?=
 =?us-ascii?Q?d0r78MKSgCXUvq6BgzcGdnl4QSq1EYt/g4filutSP/OQT1FtnAtqgeDWzeHJ?=
 =?us-ascii?Q?f5mZndNwNqr6Aqwh1xr/hrOSjLO2NprC9xPIVXZm8cV2im4LZv33DGIJUttk?=
 =?us-ascii?Q?J6Alhioh8pc30JZ5TVmTW2ksCEb0kfNgrowCUXJTd3Gn5x9HtE6+WN6Pqu1R?=
 =?us-ascii?Q?P/xt+cXSWzbljjxEDz0/Xs5o75LA/SiA4ksxiJFJfK/hx/fxHFl45Z2W1y22?=
 =?us-ascii?Q?OcRKw0RY+IsuJAh3NiMX1Wn6IYlJveW31mMg9uZ1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efa22c9-7e51-4b38-f14b-08dafb8655f4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 08:06:01.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHAsXq/VN0f+aDTio6/sGqUOrfgTi5Ooclg6qCc6VBlITe/5RUjBQL/7iUfm2UiI0qcqlVpYIjILwWbxRPEhqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Helge Deller wrote:
> On 1/20/23 06:56, Al Viro wrote:
> > On Fri, Jan 20, 2023 at 05:07:48AM +0000, Al Viro wrote:
> >> On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:
> >>
> >>>> Sure, but... there's also this:
> >>>>
> >>>> static inline void __kunmap_local(const void *addr)
> >>>> {
> >>>> #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> >>>>          kunmap_flush_on_unmap(addr);
> >>>> #endif
> >>>> }
> >>>>
> >>>> Are you sure that the guts of that thing will be happy with address that is not
> >>>> page-aligned?  I've looked there at some point, got scared of parisc (IIRC)
> >>>> MMU details and decided not to rely upon that...
> >>>
> >>> Ugh, PA-RISC (the only implementor) definitely will flush the wrong
> >>> addresses.  I think we should do this, as having bugs that only manifest
> >>> on one not-well-tested architecture seems Bad.
> >>>
> >>>   static inline void __kunmap_local(const void *addr)
> >>>   {
> >>>   #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> >>> -       kunmap_flush_on_unmap(addr);
> >>> +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
> >>>   #endif
> >>>   }
> >>
> >> PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?
> >
> > 	Anyway, that's a question to parisc folks; I _think_ pdtlb
> > quietly ignores the lower bits of address, so that part seems
> > to be safe, but I wouldn't bet upon that.
> 
> No, on PA2.0 (64bit) CPUs the lower bits of the address of pdtlb
> encodes the amount of memory (page size) to be flushed, see:
> http://ftp.parisc-linux.org/docs/arch/parisc2.0.pdf (page 7-106)
> So, the proposed page alignment with e.g. PTR_ALIGN_DON() is needed.
> 
> Helge

I'm not sure I completely understand.

First, arn't PAGE_ALIGN_DOWN(addr) and PTR_ALIGN_DOWN(addr, PAGE_SIZE) the
same?

align.h
#define PTR_ALIGN_DOWN(p, a)    ((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))

mm.h:
#define PAGE_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PAGE_SIZE)

Did parisc redefine it somewhere I'm not seeing?

Second, if the lower bits encode the amount of memory to be flushed is it
required to return the original value returned from page_address()?

Ira
