Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1364FD17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 00:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLQXoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 18:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLQXoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 18:44:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A3A101FB;
        Sat, 17 Dec 2022 15:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671320684; x=1702856684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qFrml31+2ckFppLsI9PGkZ1l9flWL6M2umQjADMpsfc=;
  b=T9XS1NBClIP6bufj8D8qkXEbyY8vYHybebrjkpORYFjh6UgGTMyXSqUx
   8ksPZljhkS1fzzPheg0vhE8Li3doNtZNhlJLsqOaUSYKgQHnC78EfrhR1
   +YlJhxfb3pqB+aPtg7mM2c5097bU824TWU+Xss4OhALo+I7CoWoTjL0fK
   zeN8wuYbZl7CqpIgQLND9dlJzdZHnLQ9We8GAmzAwSJDVqsYr07bivQAx
   4lZuCnLP/X+erMnpFlIbGnc0RlEIJZ2EksmqUbiEuoX6bKf+9XOuP4qnb
   aYABYFoOFXa/GSi0iPOZWfb4UbENr24ymceA3n0levb8qPjh16280oXA1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="320339707"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="320339707"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 15:44:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="643625819"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="643625819"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2022 15:44:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 15:44:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 15:44:42 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 15:44:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgIFGhRTWC0SfplgdUn2cpKGRbw8DOlftZ9rRuKFl7d9vVvVEopmrGvuIUv34hiWP3fJp81+oJGX1Lc2STDI+Opgzt7QSOB07P5j+zypu/cGIB/8LheB5KEC291F+fRM0MWjeCqbLi1ia7HnrH7hSuDawSp5LnBHzxbrmEmPZ2WvOLiaUzhD1sNs1X6TNl7mGun/FJVR8K4xktKFub/F+K9eDgfYRgcy3nCrowZNigg+NBiz3AIhiPc7WjQxB5NdslUzVAhDlbnj+A/Y07Is7jOyfA4FeDbysQ3N0P6Vofqy+qZYVH3bBgUQzsAvQvEKv8QjeAGGtY3Rm9UVh8a+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1FJyTUWPedWfH4bPY52NZU04JWX4z2043zPadmavhc=;
 b=Kte3whTOT/2Yu2/YWkvtBpBJY6rJRfAkvlaXnvmRxn9K7nQfMZytLVRDtGrjhkl20IfB6Jl4K1x1fsG1Z+D+r6pCtXAcWa+uD7drBRYyGD5S1+8JWTkzv1gXjH3s38hehIcziFQ1HsrIJGnkYPRHGtkAdU6Agg6pqoUYZGbY77LNXR8vOiyUspvrYHHB7rLcrTWdU4DINmyjirb6wQTwNoAtyzkLyWLyNj7u20azZxXC7w37ISiwvLcAYBO1nT3nlDpqcdRDPo4pKZtHfwcpU0loO89NLh1505TGSTL2mWBQ5qs8y6zLTO7CLE51XaEq2V4mFHYsIVw75FCcMmhJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 23:44:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 23:44:40 +0000
Date:   Sat, 17 Dec 2022 15:44:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 4/8] reiserfs: Convert reiserfs_delete_item() to use
 kmap_local_folio()
Message-ID: <Y55UZQsd9xprpdou@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-5-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216205348.3781217-5-willy@infradead.org>
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c4074c-9b42-4dd7-88b6-08dae088aa57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFf06M/zp5O/Q5C6AGZ5nzv9WPUtjOxQaAaTTRl6YtUAJ5zHyLpy+UP9J/18xY1lWM69cVoCOvV+quoOos5Pm+wN0bnqsAHc+/vOR6pZWHwE2qoXROZBkHfvhcQS3x/VXH8gDovfsmdga824291hbVuLpxBTCV0R8GiL4aLa2hse/jh2BGWYXvB7sxRD8eAP+iVxAFbtfAsjUbW+Q03VNuEsynhOB1COqDer4CUcaEX732zmkgxlr698jQrndo5sjSOOQHmIlvcav1jyl3P2tlbet8sai/AIUEyZ6yhFT+fNbEP+YJhz1BDRu2vv3hC4ZZa6nuZFY3cv0BVpP8amC2eWEd80OOFMVUu09tK9zcXEzfLEGAlL0j107sfd7sSg9vo6LKMvhiGXMm3Nxln8RxBA0yALkglgbuX+//70czQCU879qKJQJmpkJGkdVWjOoOyBmEdpeGR56R3BO8TIWQOfD/ZfElfD1xnX1nNEzmZCiTbNuu1X6buTDugdiQPTygVhKn25ZyE4sFd04NZNjCjNxBwaZI6WUyjmau05wCfuBhR0+uw/kwhkf23KFEWeP7QAmKBgHn9mz/JUrYEvr4eEdf59cy3j8zpIsWxsZ8f7mqMwLmHZILxckX4J8pKgxyNtZyH3tf46tZQEpk56sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(86362001)(66556008)(66946007)(66476007)(4326008)(8676002)(316002)(5660300002)(8936002)(41300700001)(33716001)(6666004)(6506007)(186003)(9686003)(26005)(6512007)(83380400001)(6916009)(82960400001)(54906003)(38100700002)(6486002)(478600001)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAXjil/NDGsheUhiJy3K/Sj7ADFcQpAwOt9jnfiMP78OgylMRma8JfZ9pUAn?=
 =?us-ascii?Q?tSRQMAh1IpY2yLngQWUFKojSCWY9ig01VwYTqiV6MnS47cGCM5QvzYOz/BaS?=
 =?us-ascii?Q?ibAMcwoXRSuucn4ZsNna/aFjLk6MtJCrKICWKRk/hbtGEFwkr0Q0gD+4xmKG?=
 =?us-ascii?Q?jIY25EqIYSEvz/BxmaQuidqA6ac9OGijZNsJGcE50VWPWW6+QwcH36OcYre7?=
 =?us-ascii?Q?MbGihLsLGLJMyoaFpAl9W6R/Zf93Ru82D4nzUvCIiM1PPMgqySIEW1VGmr7y?=
 =?us-ascii?Q?Mk1+EASp83Wx/gAp9bh/W+lxwf5dnn+pHRF8K61857mMSdIewGGTI1BC8uVm?=
 =?us-ascii?Q?X6FbPKvoE5q578ACCN7DPRS+ojRgv9JZagwQqqGZFfwG6vnx3/+fTWtb9Sxk?=
 =?us-ascii?Q?XClN33L1ai8qFesB0Afg9VsrG0iyisqm3/XrgaDxT8aL6INLt89JVdoWF4Bn?=
 =?us-ascii?Q?MB4s9KxhS3Zoog+P28bE1HQ1iXw+S8LOhzIdQyMALUuRPIzKW49PcjUhDeR0?=
 =?us-ascii?Q?uqptOeFhblBTlBwTyl7ulB6ExrElkHaANT4EOqEIrSBQU4MexKeDzTQQfzHb?=
 =?us-ascii?Q?6yJ+4WWWVhzAMQnFx648qzCL2PGi186J/INuXB+kQLJDLahld54/7rNq9iwA?=
 =?us-ascii?Q?0Q+Sc5TwpMZeNqKY/rgnR6R4NNd1DP0OwA6mCmS4JeWwsUtKV7fM0HkeC+Lx?=
 =?us-ascii?Q?fq4dNvfToHvyxU+2KQfeXIyRZzaIJry23uNh2Spl3uJhbv6K/CYDH9qnXfNA?=
 =?us-ascii?Q?szFHkt5YEqbrrAchGQ0PZkuAWJR5vf4varYdW71rSBGp3WI7sdikeXBZULo0?=
 =?us-ascii?Q?t7rQIOwZKd1E54vmBRtzhQTKQFTAxLoYQ3ktfI/BjdnzY9HMvPE1tRO+IP63?=
 =?us-ascii?Q?YTIlZNaduXlhkkRFm3+tc5j1w3/RLDypNXSvd4DSwkWu/fLNnopoOtaPgtDo?=
 =?us-ascii?Q?CYBIWhkzLvMe+4KyUSTmz8rqc2zn5YdmV1k4OIKIENLTZ3NeA4GcpLJAaOca?=
 =?us-ascii?Q?XywsE5dBPE4WI/OMjN6+H2o7rNZLAVcxkJECYemhvIFZ/yE44/9ALbrI/kU1?=
 =?us-ascii?Q?B1Q6U1OJAXtFJ0n8bWa1agJLruz535wL2SvUTjygbb/W7dC7F8rAxHvIURw3?=
 =?us-ascii?Q?+hEtWh/+SKberzR5OwxOsrBaFVn3oDK93c9yV/ITa3jgcGsAKit9V4lSgzwS?=
 =?us-ascii?Q?3T3TDLRaZMgUbwu0blbXosp4v2gYAB5hSzmb6ABdrNrqU8TpvH3lgdKYhVIX?=
 =?us-ascii?Q?U3VARFyYd1G9R0i885hqUBt0vtk8mzOYfPWLzPFTZJ0mmJzBTvEE565xzJtV?=
 =?us-ascii?Q?VYq5Nlb3pX/ZL4D136oyK3F57vcCiTlHiRB39/CFCo27ooUTR5Az3XLkBnRm?=
 =?us-ascii?Q?tKyFSdAkBaZgOeT8Dvfn6mVU18gVLT8flG4P7kEdC1dks1UnPSYD8hn4SsHO?=
 =?us-ascii?Q?0U4taUeZMFqrv/gu7io6DbFqD/01uSiUpzjt83urmXY8Nm9bofG55owlx+ok?=
 =?us-ascii?Q?GAh/FGbqdLS8fJBdXsZsR2PYSvaPOovHolSyNRhPq9VybSDsf/cONaSWEDvW?=
 =?us-ascii?Q?jlD5jhI55YE+48NHstkF2wgUZp6LZQVMQEE9ql6U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c4074c-9b42-4dd7-88b6-08dae088aa57
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 23:44:40.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgJgkaWBUCzP3H6aGqwqHHgfQfGFWH4woDY0LLGjgcrPeLyS9BESozq2s00nvwLWIbci8Xo1gSxQ+j8KbXazRw==
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

On Fri, Dec 16, 2022 at 08:53:43PM +0000, Matthew Wilcox (Oracle) wrote:
> kmap_atomic() is deprecated, and so is bh->b_page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  fs/reiserfs/stree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
> index 84c12a1947b2..309c61bd90e0 100644
> --- a/fs/reiserfs/stree.c
> +++ b/fs/reiserfs/stree.c
> @@ -1359,12 +1359,13 @@ int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
>  		 * -clm
>  		 */
>  
> -		data = kmap_atomic(un_bh->b_page);
> -		off = ((le_ih_k_offset(&s_ih) - 1) & (PAGE_SIZE - 1));
> -		memcpy(data + off,
> +		off = offset_in_folio(un_bh->b_folio,
> +					le_ih_k_offset(&s_ih) - 1);
> +		data = kmap_local_folio(un_bh->b_folio, off);
> +		memcpy(data,
>  		       ih_item_body(PATH_PLAST_BUFFER(path), &s_ih),
>  		       ret_value);
> -		kunmap_atomic(data);
> +		kunmap_local(data);
>  	}
>  
>  	/* Perform balancing after all resources have been collected at once. */
> -- 
> 2.35.1
> 
