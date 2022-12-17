Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA064FD1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 00:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLQXxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 18:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLQXw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 18:52:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1DFDEAD;
        Sat, 17 Dec 2022 15:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671321176; x=1702857176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8e4OHvTcjKoq7caHteBf5fXQwMifysA3N5itboT7r/c=;
  b=B0Zg/7/4JOpaeWYgZHnIiwXXhnb5uKnWgQDwoq2ZY7Di+RYwuRBaqITL
   v7Y5S00cgSMJW6GdtRiXNncgQtKhFBPJw0xrSoCmeQhVQcTwxxAS+sovr
   d4a/wa/fjk86b2P7zTAMoh5h+AiCS/BDvgnhpLrBkkMy6v5CiXu9nsY9L
   /fAI/jH4Y+rWKdx21iVujOvAA4/oHu15m7UV0wng6sdSPzJxzdaBchypY
   1glN7IKOem4eCNPnOkZKzJgaKmhnG0WMKqVzqcTKJpBs9qO9YZQtrv6uj
   Dh6lp5Cv5sMJFnYKbCtKtc2GA2EWnrggrY2F8Wzc4Z1tZzOwjX2AmSWwL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="306841580"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="306841580"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 15:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="682641522"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="682641522"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2022 15:52:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 15:52:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 15:52:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 15:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxZrvjDXwVUH6DaRoNC/Zg9fcyygqVnQcqJoGU9LR02dBzWd/pLCKJrb7YcjFU20kb5ffwwqiDjthpV+ivmjMH8irJxiCSxqb2z8TbK4l1+GxqOGnpfhwblQKpbapv0E3IYDNniBFQ4oXcGWeBI1naoLnxtGHPrtJHsKXXz5lGRFo5cK+lrQp9L3JfNOmfAAX6uc3/DbPbg06Lkq9ezpKtDchBgw6NFSIO+ZNCbawoh/PdXfM21PEpuWBFbVKsdOK7r7vmobLTRZs5lZvqX0Lcj/I4OiTwiEFHwuMCWhR7KJcG9u0aUeJlcy+xxiwtGK9DtUT7xNCzYfcd2YbvQPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anDG/kguQmynFHy+gL9xzFHXUpCKsHiQF0VWEYKsMpI=;
 b=bORnotEMljOL4h8uHsJzBfSbjV6UC9LuQeJatSieYepEfP/VyBLIprgpsOEJqvakDDiphS/CktKAfbNtvMXTxg1B3Wuqwi96CMahp3LafsAtmFKPDBiJpcdMYlRr6TTqznCbfcLQ0a+lh9+YWKncuASAJs1lw4xe17KnJhYNj072OKoGMcNg06MDQfEKQIlYwGylj9uEm6y3bvNPlEAnDZd65YfDe/7jd5SQHsNk0AN7EnCUYwnMYsziVJyEW/xhZCoSTHsJy/EUNA0rDGUVSHr/SURYs1WS3TjhCjWMaOtlY3U+wsgh2miCvF1A1XDbMXk5NF1yhqcqgUEuXqkRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 23:52:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 23:52:53 +0000
Date:   Sat, 17 Dec 2022 15:52:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <Y55WUrzblTsw6FfQ@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216205348.3781217-6-willy@infradead.org>
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d01787-d117-470a-105d-08dae089d03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZdp7qQIgGMv7aPBYUZT+5o/g4fs6h7crO7DeADTUTrezPgF+dcg+47ONipUcvbg2nHlm9j4LfFFE2jlk57fojE/l7ZgR+AAnogJ1V5ralHxGDzHkPph8a9DNUove039+4D+k7yv0ViDP8YESj3akYpBsVeRuthNjAD8wm0GJaHnok+tZxezOXviMzkWEbAdDGMevNK90YC3EvS+sEV5SPFvKL+MdZCNq7jdiSonhPrRRwYW3hmX2tabWdhkXwD7bzT4n8qo6csSf7nmXDOtArMgszeVASPgh4vYHXzgq8Mkk9OeIurkOX7sB88KPYlSZ00wfsU4n2LWqKY9HT4d80XXNGceauhJWb+KJW0gj/agwNYAZ3yvyR4QAUoI7+GGmwzJdaVXRZKCSiJnZafDF/d8XYEABxMY5OGwyhf+BRVjFJCzCh+o12p7001W3NnnFgKvk1sgwquMicYo7rWVKJW7Y2OSx32OizOQ3DQ0bfD6WMZhbiYSNJBo+Qo9lhwnHluD8mT76ydnE8jZ+CjqoWOp2z5yxGlqBb3+JZsig6Ep7SbDidCsrtyqcsRKwnsQZ7oHYT+zYm2jQK2u3+Z1xxL9f4rXxU0f/fVinNDopNdgGQBrZ6QqSTlP9VRHyTLb5nIj6YV0dlEL40zIRMv95w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(86362001)(66556008)(66946007)(66476007)(4326008)(8676002)(316002)(5660300002)(8936002)(41300700001)(33716001)(6506007)(186003)(9686003)(26005)(6512007)(83380400001)(6916009)(82960400001)(54906003)(38100700002)(6486002)(478600001)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0QBkjE6tCT9xKZfvLaz+EZxWhM0FUw7Ir98b6ZZLCGm0GblwjAZFaI8G5Ca?=
 =?us-ascii?Q?JMizuR88T1VMYMwi+s84ekdhX4Gr5VzYxQvXk0SYQiV3Tbp9ZxXZ97FUlWHR?=
 =?us-ascii?Q?X0JD6SPwBURDnPJX0VykzmrSA7gHKeuzpPjRk8TxD1bKedgSF/tMgTkEUc2Q?=
 =?us-ascii?Q?7orPvz+6/KoAbAyA2V87Klk75idfbpIMUvInMnl4vxD3LZcd3twZJR0rvrpr?=
 =?us-ascii?Q?GTuL3vkokYJwi5/oeHJYXxGngEy2rzMpEs35eQ5e7ZlzWfkjRwy1HjMUMj78?=
 =?us-ascii?Q?6Q/GInh0cxI7466YnQczjf5ZU6FWdtJ9iOX4N51dV2C3QcQ/e5OntD/zS1mi?=
 =?us-ascii?Q?5r818nxdORFY+80qqmAzfWXZ9UzYTqeJL/BpCj6PhhPkJWxt3FMpFLs+n9oB?=
 =?us-ascii?Q?2ve4tUBdoAjk5joEJTJ7XTQbVmRCl4xVfR2UnKlhTT9fzJCr1LiVwY05KP8q?=
 =?us-ascii?Q?7kQvKMkauKZRdYpsgCpBwK6dC1Y/d85F4TNGT7LNLmwgrwJcJmzW5lJh9kg1?=
 =?us-ascii?Q?Ud5CIlEzk9ymSz4vm9Xj0Run/jbnaxncf237AsU8ZP3NyYEAvRXXMT+LZEpp?=
 =?us-ascii?Q?2uoZRFhUv/eNgVvOwhX6VUq3vnCo3COFoOFH8NXcIX8hSVv/nWJogjhGN7zY?=
 =?us-ascii?Q?wE8m151c+wE21bjpaLaBOXWckuCpUw/LNmb4Sty4FdHLt9zGDoP0NoiEOzZa?=
 =?us-ascii?Q?uHKyopR2n5j2x7nBccfyr0zVsjxsZitaHv1WoQS8Z0EgefxZzgoh0rGtzUer?=
 =?us-ascii?Q?CY81S48DDFliwDsd0/15aVTclbcxJt+GqDnRGD4WO5EI8bu6ONox5uNoRmZx?=
 =?us-ascii?Q?ieQ5aL4JFfWO0L/MTd4JSqj2tvzNuZwiIeB9uhiiVIjjMWSrIrqDzmCkq96b?=
 =?us-ascii?Q?SgCCxfDSPwJRV79DdlGCzdg1UEGoZy1HpvrL3NHe/bXtKKaijYmWAPXrGCcT?=
 =?us-ascii?Q?EHe7zIeWCcNsDpRCPbKZqmwyNScqxzBlhhuRBJNEzhMZIb5QCfdtCs0Rq4vn?=
 =?us-ascii?Q?1QgXxoiJj6m5846eZPVi/dZkAulyBY2dkV6DugeT6sJ5L+378jOZ0tU/aozX?=
 =?us-ascii?Q?fYr3WZJg43/ZEtSIJaxuHhUg0484q1nhRFqOLALgRsczNKcVo9kT9ZiwcVTy?=
 =?us-ascii?Q?1SaWVNckC2FUy9d6qZAegCvwOWP8s9LGyMDcelSv1QBLIQV66VSzTBOS677h?=
 =?us-ascii?Q?kNcDkmQLlQTA/giD9uaxe2vdS+/laGyWFUvz61JszxmRciy1c+hzTLpHtbIr?=
 =?us-ascii?Q?xHKd3VlwHmy6hl90dKXGKMov3BmdNm4vL1sZgMiKwuHp4UbUmk9+zOZ+CTJO?=
 =?us-ascii?Q?McgnkK6BQRS0stKcM86hkRYfVAfqR3+3vzwzGiJtIc+cINszk7WNc3GRbg3i?=
 =?us-ascii?Q?EpFzZ+4HWUyQydqrIr9m92HP2EkBB/1j/ocLB8f/snVYkuDEkgOvojR9fAC6?=
 =?us-ascii?Q?bDve1grZyOorONC/LZ3ESDZC452ci1Sf1FeVi8ydgOdyJuUHWIqLvZpk4NJX?=
 =?us-ascii?Q?OkSFweBORiOdAQHdM40zu8Wajx20b10xfpsqEsFeVUjBG8fwt9YUjLK8FMiw?=
 =?us-ascii?Q?1AZ9Bi1oe2xbEhRlTeJen7LGbasWe65HtWkkhde5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d01787-d117-470a-105d-08dae089d03c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 23:52:53.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sme4o5pkyVTP9gIZdp4sumF0/I6tSXbExxSMPyyxtXv14+uQACjPtrHdgXcMVWyyTKPKDWSCuYarvpnb1IFXxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
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

On Fri, Dec 16, 2022 at 08:53:44PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove uses of kmap() and b_page.  Also move the set_buffer_uptodate()
> call to after the memcpy() so that the memory barrier in
> set_buffer_uptodate() actually ensures that the old data can't be visible.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/reiserfs/journal.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 9ce4ec296b74..faf2f09d82e1 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -4200,21 +4200,19 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
>  		/* copy all the real blocks into log area.  dirty log blocks */
>  		if (buffer_journaled(cn->bh)) {
>  			struct buffer_head *tmp_bh;
> +			size_t offset = offset_in_folio(cn->bh->b_folio,
> +							cn->bh->b_data);
>  			char *addr;
> -			struct page *page;
>  			tmp_bh =
>  			    journal_getblk(sb,
>  					   SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
>  					   ((cur_write_start +
>  					     jindex) %
>  					    SB_ONDISK_JOURNAL_SIZE(sb)));
> +			addr = kmap_local_folio(cn->bh->b_folio, offset);
> +			memcpy(tmp_bh->b_data, addr, cn->bh->b_size);
> +			kunmap_local(addr);

I think we should have a memcpy_{to|from}_folio() like we do for the pages.

Did I miss this in the earlier patch?

Ira

>  			set_buffer_uptodate(tmp_bh);
> -			page = cn->bh->b_page;
> -			addr = kmap(page);
> -			memcpy(tmp_bh->b_data,
> -			       addr + offset_in_page(cn->bh->b_data),
> -			       cn->bh->b_size);
> -			kunmap(page);
>  			mark_buffer_dirty(tmp_bh);
>  			jindex++;
>  			set_buffer_journal_dirty(cn->bh);
> -- 
> 2.35.1
> 
