Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9E606E55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 05:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJUDau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 23:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJUDar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:30:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E914705A;
        Thu, 20 Oct 2022 20:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666323045; x=1697859045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O05Ya+x21Utu2RNEA7h7pAUOTezrjGkI3cAeFsX2ftA=;
  b=OTl8Ng0rZo8dJiV9zfZ+j+sMvsWWrDQAPyBIg005RlWf3psBgNNdGTC2
   AqT8sNmTWgSuMOZ4mGkLLR2R6kFP7GQm/wtZAUxmUlSVqB22/fA4m2k7F
   qSoXeSEq9/+5+WiD+GpQGyfAeuSuLItt4ZKxH6d4arT+7m1uoNwS7QA+7
   /VVotcUSSVX7ix8edVttn3NBE6LdvH7DlV8QoBs1AyZrghEw9hLfkEbCi
   e9HYTgKeWO5flYVZQQJU/LfZ5ZyxRdaEJUvdHgTwAhSm8PKYsNnRagzVK
   A7Bb+yLYQ6f2nGMFQzDNdyNldQJZ6iPwW2TVYx7PDJJ6jjJxUkpbPzZIp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304514062"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304514062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="772783040"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="772783040"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2022 20:30:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:30:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 20:30:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 20:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6daS4woDSz9Uo+2VFLKhN4CRrLwdOmta+WhZe4CZK0Z+AR7V63Hc+guLZI44GlIhNJEi11HZCUUHgQilk/zFVX9n6MsA7f9TdBSPo7G93cyq6K6Dcz5J+v6K2h7qRBuCcmMtSwWtJ9SB4MTAmA89P9EQNSScbyF6cJZjVj6OcX2Mp2iUbkbmjg1d1CLxJV/PXUCQXz16DaA7tfZ63aVXoixi5Xn8E0wcq1xgH8ogk14duq03FZE4OmNAWF41hBPobTniF41Y5093s15dpoii6+rzSiuUvPllOmHDM2RJVDMAzqXEkDHDs4OXe2QnWpq64/0AzQ12p95eV/8ksGitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMmFZ/TqkokKWrmoFbWor2RGWPglqHe+BJZbttnUT3w=;
 b=htvoujIiDr1EwsP2J2AY+zFQSuVn8bSxy0FANlwFx1KtvWV2FC+YEwEp/GY+d83t+oUxI55H1uRKnDgz+VlemEff278gnQ5+UAv3sJrZWomlsNMJBBVbtuelEAmEdBjFPVjlLx4lnkrd6FtoRNeaHN+TVCv6sxAci4t+2yGcsOrciIeFM8+nzGemGZ4GwEmNowp2kMQm60ZtRRxxcjQkJdRJyZCNMoX7e9KbfLAmX/g7xU92DEyK2P4HBWn/E5j/HNXf0a4G7eVOH+Y9Uzm4v9l/cTI1Wd0RodxwoZRYbBxutN0sHMpH4VO+NHQ2Iu5WufXooQ2aP/u44q35+l/nIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6295.namprd11.prod.outlook.com (2603:10b6:8:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 03:30:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 03:30:38 +0000
Date:   Thu, 20 Oct 2022 20:30:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Howells <dhowells@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        <dchinner@redhat.com>, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        "Rohith Surabattula" <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        <torvalds@linux-foundation.org>, <linux-cifs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
Message-ID: <Y1ISWla50g5gHax6@iweiny-desk3>
References: <Y01VjOE2RrLVA2T6@infradead.org>
 <1762414.1665761217@warthog.procyon.org.uk>
 <1415915.1666274636@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1415915.1666274636@warthog.procyon.org.uk>
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: afc5e1fb-18b3-44ad-a85e-08dab3149fb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdeMIUkyrTX9VieTI2Z6T04rsq7feeuTpEzObUbDK+FghQmW1yNjk+yTu5RvmV9me1yxUHv4BrfnhvxJKcS+ljUGAjFpFFcQmouo4vrbDlHe1xYx9Qt1BR9xE7Mc9oytJuqLiNXAq7gsbs8bvic/lEtAKINGVcdKll57zFOlJnvsaKzEjazFC8BVvv8yDgHVsaAJT7dQwphxdZrgvh5zDLHfQVPd0c4a0qSiRYL7ns0uj0pe6PBGgQgLPoPLzz8Xti8zN6OVYxk3v3wTwDI9en8fcOdAolA0/TnNjF1Yv/rsnJHuVKoHp6TYNCJUxDtUt69OM//rgJgawYaZVweCWd8IZYFNZ4xy0i6p0V8eL9PSdn/LPmGgTV15Cf+/uCVDvwo/HVAT2D+fmUjZTD/NKLBBXWEVX1uRQ0FSmoAgskGkUEWeEZ7/XQQ11KVAbbvMF1IDh7zlaqf3uSGd8WGcO+Pk5f4akZglncQSd/qCmP5ZAsb8bUXScUvc0Mkwo1RarIvCIKE3k6Da98kBnZrNV+ROKraNIAvYfJ8U1c+FrWMlv8T12IHq51B1aJNVFLjKXBQ+yPqZtCXN4CWdK4V64OBGY5tPDYMCAI14tognA3ozKhKmswCNUWo2JWfYgAhVcjASSaiOYmZvzX9Tv8XLaRX9aX8xDk9Okz8hsNTJm0oVWgQ8AgLxRGB6TGVyloq2e9l65pg2nA4udog9J6KR8LSR8CcHSDak7hViGXSpQMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(2906002)(38100700002)(44832011)(6666004)(5660300002)(7416002)(26005)(86362001)(6512007)(9686003)(186003)(83380400001)(478600001)(82960400001)(33716001)(6506007)(966005)(6486002)(66946007)(8676002)(66476007)(66899015)(66556008)(4326008)(41300700001)(316002)(8936002)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BcMvvY0cPQE+ZNHUHWy0YQOqQOGp8Iy7bBH+fQZnMtodUadba4908maPP5lM?=
 =?us-ascii?Q?Y7OGkeh/h4OnFLOaxb1vHGtZghJTiyKq0xfYCyaQtxV2PgmmAra3EyevwKeB?=
 =?us-ascii?Q?NO06O3Wr5n32PGjRQdffGAQw0GitXVbpqcURo/GNSyDvyScjdpDc221DKQ4H?=
 =?us-ascii?Q?o0jnAay2fnAVCWJHgSaX+3Pxd4OzyAs/QxvchPpg73fvFddqnX0YqcJf87Dw?=
 =?us-ascii?Q?/fUihhnslkJnrySIen3fAHs35rTrwIXOAI9cAz21Q9tSGa/7hNHD7YjvK1pv?=
 =?us-ascii?Q?pslGTIyauIKXTUuRllM4OzGyUVtMRssiQhR4WkRaBSSdDFRp0qR6ZrXJSVlj?=
 =?us-ascii?Q?4GTGJAFp/GbU4itABVeWayQHq//lfVr6BqbEzYFl5i7rAbckrXI3Gb3EzOSl?=
 =?us-ascii?Q?GtllQ6dJq5PmuS39smIsrccWKVfDu06ae58yZQK1fo3CaiM5++DsHDqWgioQ?=
 =?us-ascii?Q?GnZaMJvCCbPBG3rLei7hf6I5jfRngrQ2HR+9AitquOtit/tkfOg9saz20XOK?=
 =?us-ascii?Q?lpo7vG4HvOvPtUjiO30GoCbW2TmHgyO4A7FLsayRiG1ldByhm2SNK5C+Ek1m?=
 =?us-ascii?Q?/klZZe7B/EoFOOBa+CajOK4NTmAeg58Yr1HP0CesasSI83eoVy4yzxWv6peT?=
 =?us-ascii?Q?01lWfr1oBykrUmPFVl0zhUcXLgj875Yo9GD5oqGzShqmlRQZl2rmtSL3iV+Y?=
 =?us-ascii?Q?Him4QwBbGi81NqbwMSN+gRxuv13aQckBQ1yIL/ARKZqM8UNB6xqNd87lD8UP?=
 =?us-ascii?Q?b4Gt1belGhcN0rgKjBQKOoZbdQbkiaf+xyLBdDKV0W77dIy8o+fIRrF9BeAK?=
 =?us-ascii?Q?sCWYUGpw55BZsbe2BLq1Dvgv+DMlKqblOE/VMKC5O6jzCFenV0pglv7CIGdO?=
 =?us-ascii?Q?WqYSI81mlo6TsUzBsBEpllbiE7zukZBuX/T2CcRvotOodVk/vtMldpc/0iGe?=
 =?us-ascii?Q?fUBkn8qYDthxhSZzJDWF+5r+VBCvGbR0u/8W3Y/99ggoCMxtMGGNDfi7FEOe?=
 =?us-ascii?Q?eeRSZE32oCvNGH2f6UdAItd8a6R7vWtRNamUsB2XfGSb9UJFRHrHutZ8pTMs?=
 =?us-ascii?Q?/5BvFSjFaNGI7mn6+P+li9vE9W9KKg0R6IL+ENvAi2ww2WgXqnPOMMcjH5sg?=
 =?us-ascii?Q?XIOM+P1It7yieOLJG3fCr6uk+xyMI2Vk+x53XMj5g7VZ/AgG7Wl2ZeY7lCIw?=
 =?us-ascii?Q?C8z0ryI33wbwcTila6G93jQdNdLEO9JpjsV7fCOBP2qZJpjlgda8Lt2YCgpk?=
 =?us-ascii?Q?LkwKdxZLdSnuID5c1TkIYf6A2NxveCSXgW+z2kFz99uUdDSe7Aeoh0IFR394?=
 =?us-ascii?Q?e6jLbQ3vlIJHv8Eu7spJdIsGSYqq0VPjo/9Skl4mKo26Mzymwa9gf63co14L?=
 =?us-ascii?Q?aV+ENMmfMyUNvY0KZ8FEqquSK2YMQqJ63spbyFxfSuCEQ5WwII46bWAaNUiI?=
 =?us-ascii?Q?GPOxBQmhPsNLohsVOBJc5nW3JQ/LQWU3aw26Alfx/C8/3iVj9TclUkt2DJSz?=
 =?us-ascii?Q?i/1gbC0St4UBVjq+S0WRd83p5HPYmDlxZyxUjE4kfCvXDjEDvjVrPzfK17Kp?=
 =?us-ascii?Q?0885lpQYQcNjRSMDcNnqi4syl32LOuC2z2UpVb8g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afc5e1fb-18b3-44ad-a85e-08dab3149fb7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 03:30:38.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gA9mWG3E6zL2MKMGADKOAPWRBrF8cqemdyfHnuXkb/5U1DFaXiA6GNiMxpFn0bRCwVS5pFIj7VCxwYviI3a/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:03:56PM +0100, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > >  (1) Async direct I/O.
> > > 
> > >      In the async case direct I/O, we cannot hold on to the iterator when we
> > >      return, even if the operation is still in progress (ie. we return
> > >      EIOCBQUEUED), as it is likely to be on the caller's stack.
> > > 
> > >      Also, simply copying the iterator isn't sufficient as virtual userspace
> > >      addresses cannot be trusted and we may have to pin the pages that
> > >      comprise the buffer.
> > 
> > This is very related to the discussion we are having related to pinning
> > for O_DIRECT with Ira and Al.
> 
> Do you have a link to that discussion?  I don't see anything obvious on
> fsdevel including Ira.

I think Christoph meant to say John Hubbard.

> 
> I do see a discussion involving iov_iter_pin_pages, but I don't see Ira
> involved in that.

This one?

https://lore.kernel.org/all/20220831041843.973026-5-jhubbard@nvidia.com/

I've been casually reading it but not directly involved.

Ira

> 
> > What block file systems do is to take the pages from the iter and some flags
> > on what is pinned.  We can generalize this to store all extra state in a
> > flags word, or byte the bullet and allow cloning of the iter in one form or
> > another.
> 
> Yeah, I know.  A list of pages is not an ideal solution.  It can only handle
> contiguous runs of pages, possibly with a partial page at either end.  A bvec
> iterator would be of more use as it can handle a series of partial pages.
> 
> Note also that I would need to turn the pages *back* into an iterator in order
> to commune with sendmsg() in the nether reaches of some network filesystems.
> 
> > >  (2) Crypto.
> > > 
> > >      The crypto interface takes scatterlists, not iterators, so we need to
> > >      be able to convert an iterator into a scatterlist in order to do
> > >      content encryption within netfslib.  Doing this in netfslib makes it
> > >      easier to store content-encrypted files encrypted in fscache.
> > 
> > Note that the scatterlist is generally a pretty bad interface.  We've
> > been talking for a while to have an interface that takes a page array
> > as an input and return an array of { dma_addr, len } tuples.  Thinking
> > about it taking in an iter might actually be an even better idea.
> 
> It would be nice to be able to pass an iterator to the crypto layer.  I'm not
> sure what the crypto people think of that.
> 
> > >  (3) RDMA.
> > > 
> > >      To perform RDMA, a buffer list needs to be presented as a QPE array.
> > >      Currently, cifs converts the iterator it is given to lists of pages,
> > >      then each list to a scatterlist and thence to a QPE array.  I have
> > >      code to pass the iterator down to the bottom, using an intermediate
> > >      BVEC iterator instead of a page list if I can't pass down the
> > >      original directly (eg. an XARRAY iterator on the pagecache), but I
> > >      still end up converting it to a scatterlist, which is then converted
> > >      to a QPE.  I'm trying to go directly from an iterator to a QPE array,
> > >      thus avoiding the need to allocate an sglist.
> > 
> > I'm not sure what you mean with QPE.  The fundamental low-level
> > interface in RDMA is the ib_sge.
> 
> Sorry, yes. ib_sge array.  I think it appears as QPs on the wire.
> 
> > If you feed it to RDMA READ/WRITE requests the interface for that is the
> > RDMA R/W API in drivers/infiniband/core/rw.c, which currently takes a
> > scatterlist but to which all of the above remarks on DMA interface apply.
> > For RDMA SEND that ULP has to do a dma_map_single/page to fill it, which is
> > a quite horrible layering violation and should move into the driver, but
> > that is going to a massive change to the whole RDMA subsystem, so unlikely
> > to happen anytime soon.
> 
> In cifs, as it is upstream, in RDMA transmission, the iterator is converted
> into a clutch of pages in the top, which is converted back into iterators
> (smbd_send()) and those into scatterlists (smbd_post_send_data()), thence into
> sge lists (see smbd_post_send_sgl()).
> 
> I have patches that pass an iterator (which it decants to a bvec if async) all
> the way down to the bottom layer.  Snippets are then converted to scatterlists
> and those to sge lists.  I would like to skip the scatterlist intermediate and
> convert directly to sge lists.
> 
> On the other hand, if you think the RDMA API should be taking scatterlists
> rather than sge lists, that would be fine.  Even better if I can just pass an
> iterator in directly - though neither scatterlist nor iterator has a place to
> put the RDMA local_dma_key - though I wonder if that's actually necessary for
> each sge element, or whether it could be handed through as part of the request
> as a hole.
> 
> > Neither case has anything to do with what should be in common iov_iter
> > code, all this needs to live in the RDMA subsystem as a consumer.
> 
> That's fine in principle.  However, I have some extraction code that can
> convert an iterator to another iterator, an sglist or an rdma sge list, using
> a common core of code to do all three.
> 
> I can split it up if that is preferable.
> 
> Do you have code that's ready to be used?  I can make immediate use of it.
> 
> David
> 
