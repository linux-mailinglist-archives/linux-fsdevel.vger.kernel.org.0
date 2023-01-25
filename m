Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619967B8ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjAYSAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjAYSAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:00:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02E3EC5A;
        Wed, 25 Jan 2023 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674669610; x=1706205610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A/Uy6c1fozvh0VldTC46OveosCR6AgFcTjRDot1ld3U=;
  b=VB4OrG3PbRDWbhfodsBdQsA/0mktQaQzsmMyE8dg2nY5SF+oZVZu0SNK
   dhVOptYGLR0p0VG+Nvz9IalgSCBdcoFSnQILJjqbh3wbosxEq+AsAuDD7
   cYNDD2pDJep2Ai95gNAiF1uYLpEDZSoUT85HArLe/MnUAJdKDCVCiTe86
   bsbkQx+vb5ZV4/coXzyOUcShBIkIxfKOkVvvUHdj7R8B3LxZqoa1sd4wy
   HmeKmVRCxGKNgIFjyI6IYIrnQnGeWvt9tzSAwodMRRzeFIDE+vlZHVeZn
   e1auSEh5jTREG8521GfSw/iHZmKJ+1bxdO12j6P57kvxXsEewquKRHlSZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326655727"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326655727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="664540911"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="664540911"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2023 10:00:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:00:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:00:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:00:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRlPFMuOIzxn65YQESyPDGtyyJVo2EISDH4ZAkvfLoUBSjAYkbyBkupFNrxUcLS3y0HXQIgwKw+ikKiqS5yGKkMog/9WWlQmqN7+OCVSIn7NNKDBuFsGSS4qMZQMWItyqLRBxC65CR0N74AWbbgul57vO4RpM29mryZwwuklwR6Hq3Tpz5F5ssP5DXAgbI9Dzjyon9VKa+HZSnBLT+sGJmge7SEBDp8OE9UfBLkofs4ZemqCsm1iechsHBwN1fz6I2McqcohOMLMscGlQVUuJhJzcal1QxkSRa/wkI1MKZ95KDiL+d1TRPbC5he6MBxmdP2srpyCgBse7fLkeXRUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIaOskBDcqaqLFEOvgcSuchOiTKyRuzlcssVhyAUgA4=;
 b=Dah3XeP8RqQoH2vD2MxQu6BJ0UXsXoIg1Nky3XMbenfFkmpX3CSe6mka54h5Ovr0+WMXyJcOMIIektooFVssC9YAjBsoIwcUxwBqq4eaz7phlxvHbOvp5jC4egHozSkyD5Z1wXtNEb8ZZ0ElqdLDeArqEG4dxjqiDmJqs++ZNAwPXfF8BfL5V8Q5dg5FLsjr+LW0EqOrxhnvx8Npw83ggbRBdYW2qWcgtG1W7eoW9aN4ib01ggW/JiJBGQsDjUj04L8vFnpmBDrDDLsRe8M2q5/cS9JU7QJsQx5KgeYvNQmsq16hBDS3u7Uz9kU2ALq4dly89Uwvbvp/8vPBYz84NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:00:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:00:06 +0000
Date:   Wed, 25 Jan 2023 10:00:03 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-block@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH 2/7] mm: remove the swap_readpage return value
Message-ID: <63d16e23ae4a_3a36e529425@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230125133436.447864-1-hch@lst.de>
 <20230125133436.447864-3-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125133436.447864-3-hch@lst.de>
X-ClientProxiedBy: CY5P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a394803-b5ea-48f9-801c-08dafefdfd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9smFqZ+wdBccEuD9xWjFJy95ZJAAwpCXk/E+41GD5fEfgV0Rikp8bdVuTCwFdpJwmFZJqIxJJ+y6ryrKwPmihaEGEsj5TMLQLDSGX2BaIGsPMTXPJDgJoN1PEd6x653VpKZHW79iNe0Rm931UhUPSnlaCt0ODrSY9q0uO8HNxJ47fpPt+TrmKOQcTlJqmeunS6oKw++7bLtIIIJJZdVogPrrATGRZI84e9XMqhzuqZ+/74yvYtw8YFkG3ap15fngq+7P7OqqHHoHeazhe3ljuJkuYBMvJUJgRCftXQje+6froInxNVK0Xwr0leRK8tEQ0TSnUqm5GUETkqnMoUfYrb4l2wP27/j97/k4bZHwqZMnZF16TEYb9KkvzofjjLaOyAxgPSsIuDPn7YmOi+xWIduTbwyljHRDTb+XnGqqpBPWStqoY4UNHBxBqp4wjeZCdeCijvqsAvjiVM5YAhalpWClUCCu/OekRXFtRjLjGtBBbY3REkphn4aOikl9OFUDAN8+uVqrwJFJzFn210EOmpqYsOMzmcrjGPK8EiDiBgS3VYWe3LzGrf734Kgh2+VH3gTvmEqjwlsOcQ68myQmeJNb2g83pzSYSYot9cqR6mKS4jas+37Sz1FE2gz7qG70Z518rHQZoASQhOi5h/quOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199018)(186003)(86362001)(6666004)(9686003)(26005)(6512007)(478600001)(6636002)(316002)(110136005)(66476007)(66946007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(8936002)(83380400001)(6486002)(6506007)(5660300002)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o5RZgdyeYfwkANrhQOsTqnK3sgnwq/dm+VmdvIeOQvs/oOBuRfgygeieoEcu?=
 =?us-ascii?Q?jc8MsxpdZ8rNsuF0C6Cp6aiaWmwMax4mJJdEvpOlCABwGmaicBCXutJKxRHP?=
 =?us-ascii?Q?ADAlAKDBH0S6UW0VefxytYQQj5OThk1ASZrZprVmyK8Z2a3gGYSx9k1xAyVS?=
 =?us-ascii?Q?vn0ir5grXjHtVPiCSusIOPaxrnR28uZzWLutp4SHoq+HzBshWw4mngyN6AaM?=
 =?us-ascii?Q?OqCvUXpBscHunhwa1N4eXzPdDOTXZ9hx4jgmrMKkZfSYPOAjjNRq6nM277sR?=
 =?us-ascii?Q?4F4QzuN8j01/o1r0xOwkQeLyMGZYi8cvhioLE2RufT3ayuWoBRQF/dYKz7ge?=
 =?us-ascii?Q?y6TM9mu7w6DrhxKxHSgXSifwDZlD7dG2J68SAe30usYbHxdF50a4Y+94duVr?=
 =?us-ascii?Q?O76xki60wmXIlxzzvyEJyDI0EziuwTAVNKFWcG3sB9vOABThu6aBcVhD97Pd?=
 =?us-ascii?Q?u8LdxRw7aORrpCY52MI5Mdl64lpaH8rQqy4gkhXGiAj1oTOSAzgdFhAyuH2+?=
 =?us-ascii?Q?qROA+Ri2EkZLJqBpE2ePidJvAm/UDh+At7R86SG0qOoGqDk3mU749H6CDaz6?=
 =?us-ascii?Q?C9D++CwNvxOv/cNoWW+S3VsVoPxsdwHiYf395Jt41gCOIM89k1eXrBC8Zo6q?=
 =?us-ascii?Q?MuRu1FVSYeaEXfgzn+D11A+bhGnmYx7GovQgG1EOeMvUDnASiYMDvG7BIWVo?=
 =?us-ascii?Q?EosoOn8SAXCpAUOCxUXqubmuDs9kgjPPQqyD9NdB0ZJ4n94t6fBQkee4fF60?=
 =?us-ascii?Q?ZHoz8hnna/BuP9F/bNHo70KpAWkbIbSwT0BmQdbg5qBlGBoDZKbSBzAU6xV6?=
 =?us-ascii?Q?npQ3C1D6KdfyMeEnhgVPMEuZayuzXvu04MYhABgH+oXyYLSKIPuI26dfFSj2?=
 =?us-ascii?Q?s2TPygWb2WIKg+PJb0r8uptPvD5ukbztIs//XFHv9ovY1U6sQ5GHRplWyic1?=
 =?us-ascii?Q?l+pmB+9U7w+VFlgt6Ry9aSeIsocJsRssFoSPoZ2mn8YbmPi4VRLxzUfQfkKH?=
 =?us-ascii?Q?R6CKh47p4e/rglByz8YSSqwWmQzb/RrV86lt+OktKtYAVwvqhFs1swPpQkEB?=
 =?us-ascii?Q?YGwKtH/TcM1VKiAsw1GBjXXmy60f5N/xz+ut18jDQ4elDGMpJCrmH1l4vwDf?=
 =?us-ascii?Q?Xh39MaODrTj3E1BsKIFuZhd6pi8i6BZTm0fwh44O36owDk2MPG4Gpk8Z2/1t?=
 =?us-ascii?Q?16DC/21gu1WLXgxJH1P+6FbhtFFvItEaQsJL1Livg7EpuqywURVB9oo/q65u?=
 =?us-ascii?Q?GGX4XYVQTmtQNRLqw/p/vQ3O7riNIIqCNar2tIyweRCFU1a6QFeeB8sgpAtP?=
 =?us-ascii?Q?5eX5KxM24vGdQzKD4SoRjyeMuB6LSA6L7cN7vXA23PsTIWh3LPXRAusUASy1?=
 =?us-ascii?Q?wnozgJu+I0Ae99erB4y78Gt+0rvBF9QU2yXo6QB/wlS7cOIvzrwFUgc38scg?=
 =?us-ascii?Q?x2ElBH/Y0XuUhEnc2Q1S5rZBr/uP/XEMHMhuRCFbsqF36CJlOp2cnFT+Ss1H?=
 =?us-ascii?Q?YMrpkvSaBccAgo/mTR+6TGH0XMY/TvclSmno5CTf7LT4M6zLzJLLN5nwHixt?=
 =?us-ascii?Q?ZI1AemfdfKX7ymwes4qiYmJAUlmIY5r/5PagpIvlgnH3zgFQdFK0dgXHl+hx?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a394803-b5ea-48f9-801c-08dafefdfd99
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:00:06.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXxsY9bwQKToRImBhzov6Wu4BmhymSucGI7AQXvIziDhozZbeiuHTzXqv8MlCPF70IRogyMS5vR4rGE/W6+PCLc/+jN2hYRJXhLv7M439vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig wrote:
> swap_readpage always returns 0, and no caller checks the return value.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page_io.c | 16 +++++-----------
>  mm/swap.h    |  7 +++----
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 3a5f921b932e82..6f7166fdc4b2bb 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -445,11 +445,9 @@ static void swap_readpage_fs(struct page *page,
>  		*plug = sio;
>  }
>  
> -int swap_readpage(struct page *page, bool synchronous,
> -		  struct swap_iocb **plug)
> +void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
>  {
>  	struct bio *bio;
> -	int ret = 0;
>  	struct swap_info_struct *sis = page_swap_info(page);
>  	bool workingset = PageWorkingset(page);
>  	unsigned long pflags;
> @@ -481,15 +479,12 @@ int swap_readpage(struct page *page, bool synchronous,
>  		goto out;
>  	}
>  
> -	if (sis->flags & SWP_SYNCHRONOUS_IO) {
> -		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> -		if (!ret) {
> -			count_vm_event(PSWPIN);
> -			goto out;
> -		}
> +	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
> +	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
> +		count_vm_event(PSWPIN);
> +		goto out;
>  	}
>  
> -	ret = 0;
>  	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
>  	bio->bi_iter.bi_sector = swap_page_sector(page);
>  	bio->bi_end_io = end_swap_bio_read;
> @@ -521,7 +516,6 @@ int swap_readpage(struct page *page, bool synchronous,
>  		psi_memstall_leave(&pflags);
>  	}
>  	delayacct_swapin_end();
> -	return ret;
>  }
>  
>  void __swap_read_unplug(struct swap_iocb *sio)
> diff --git a/mm/swap.h b/mm/swap.h
> index f78065c8ef524b..f5eb5069d28c2e 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -8,8 +8,7 @@
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);
>  struct swap_iocb;
> -int swap_readpage(struct page *page, bool do_poll,
> -		  struct swap_iocb **plug);
> +void swap_readpage(struct page *page, bool do_poll, struct swap_iocb **plug);
>  void __swap_read_unplug(struct swap_iocb *plug);
>  static inline void swap_read_unplug(struct swap_iocb *plug)
>  {
> @@ -64,8 +63,8 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  }
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
> -static inline int swap_readpage(struct page *page, bool do_poll,
> -				struct swap_iocb **plug)
> +static inline void swap_readpage(struct page *page, bool do_poll,
> +		struct swap_iocb **plug)
>  {
>  	return 0;
>  }
> -- 
> 2.39.0
> 

Looks correct,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
