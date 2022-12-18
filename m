Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625D64FD1F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 01:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLRACb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 19:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLRACa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 19:02:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4BF5B3;
        Sat, 17 Dec 2022 16:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671321749; x=1702857749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LuUZHqDqWS5uS2B9KJLvxSicYJsy1AHHzqAzGQk+Oqg=;
  b=by/TuxgI9t5un3aK3ovcmgX2ZYLUnbwy6IELCUsfLSt0uTQPK3oU9SXz
   xiHXMmLe0Z3KZip39GCsN3yCAPqnKkZ7slj2UiCWHn4Qv/Orxu6jceUws
   PpuChzmt+UnJnfn9SAOIbjd4PjpjRm5QJYWxHFQ02MJmsSVrGUJ6X5cBL
   zxliLYTPOs884iXVRH1UbLXclF92Wst0tRadY89tjqsTSl66/IeKeDBe3
   gnFtU7rSHXZQBDkZ94sdFELbBoDaeoGVlPyQCvZ5VCsXEe3Zhe8BrGppD
   h5a+MO3xAkznzLe5zYAY5yQ4wm7/gV40r2ZSvW0fURrsmE6uvtEEQIckW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="383506339"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="383506339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 16:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="824468330"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="824468330"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2022 16:02:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 16:02:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 16:02:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 16:02:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM8gBOWWgSiyvxXsNdqzAA8EIr7XLRhfujctdPEMHDlal3p0wGk2vbxVRPSHO6afTQYptdL7VC1XnkpOvWySp62yNVzUj00oSEgC9smq9pJcrBZaGPe1FgLm+9AbihVAaSq/UE7khQyFmx/TrAmQczoWf9tJoKeNomRL0PQOeJGoDrtu6JXTFk7BEig8x7mcZw9BMTPgFZv6EB3LVMllz/swrZyphG2xAddh2+Pq1EDrW7RSNukMYpoCCfpUPzhapL/KFU94ExVdLarzXlCmZ8EuTlVK6zSgGVRs4f/I1u6to1r2kipGoAs2MBcSl34IvPrhstfTDyXbZxuJoUerpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9bn1LFbVcZDQrlQjE3HLiYICezESCkaMRH5cktAcH8=;
 b=F/RF6E/1FfUwLAcytPTHjFUvqdYd8VDjRfexxIRo+PmxWgysB0IWyCii8/36YXHeoVJxedRRL0+4bG/pWBv9040bAxxn6xMNl/jvQIscCs+9Mxjkt07ewmK18qLOE1NIVCe7tgnSHBff5DSiUdShSaglnvHruhRBjOvNbUNWKmtzgdKHZYCm95G//j4sdnfoX92hPLjfPvSiS1ocibOJz/l8EAAYqFwDR/JQZy41KGWviQJgdgynlfLyYLQ4OYxnjDtQIFEmqoK90dRrioiRStnv6D92pds8ASvPyT6ZBWcKg5BEeuuYiRVCw8xcOZYCEhwpsp4+AW4LCk9fJIon4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 18 Dec
 2022 00:02:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sun, 18 Dec 2022
 00:02:26 +0000
Date:   Sat, 17 Dec 2022 16:02:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 6/8] reiserfs: Convert map_block_for_writepage() to use
 kmap_local_folio()
Message-ID: <Y55YjyfVYasvNP+y@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-7-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216205348.3781217-7-willy@infradead.org>
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: be4da3ab-4ce1-4a98-8b2b-08dae08b25a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LisF7ZsvEbVPGyz4Ac0pWO/3BfBOFSRgpArRUDLyCc/xhVnSG2aVTwG+W44vi6BPQjdBh+bnYGWL3g9a2Ol0DUsGlVUmPAKKxnQ71rJ0VlWhIz3hL3MFwKy2E2jmM3ReENRUNkkzWmi2eNAhXv8/qId4MJ3+6y/gJHn/EVY0VdFJziapCsgXnOztqyDB+bCxDCqIXv4GatDrXljWwrKM53K1lsS4uCBEedfYdYZu+LHPG2jppW+RouUmFR/1M+eSa2T5VOgF9uBE1KPbVJE4wqHwSK261vX1KJg00b95Ea6KQIARdYCcVuGuG97YE37pKC0143d3TCwtxSJeWN0tm/FYW+pjSgQ4mp01C/Pcpqp6M3449t2q0ltwjeR+n2gF+11opwyQ5lNdmI7RC54Tw38p/bfRTDg3PTOcNGeaFNPYfhiAEOcZpL0PteigjYY9/pW3WkQGyCBnjtjbi0KimZ3/ZjQV7kQw+QI/UEIemDHd6A30b25c7AMglYMDNR/izf1zx1Y/B5RlE86uIaMrnw5Qq8c3LaCJsGgJAhwY2a3iGNOIWpqoYbi8G+5SgQrI9WgMtoaeYq7RvKDQTZOHiEe3ikZ/FnmfSNMXg3KicOeahvkxAiGckrjIYKOTEIfCPmjeED4+JVdQ10nvXVNsEM8lHJhk46FpRWlMGvTa0Op2Dfvr08y+hRZzB/1ZJ4kr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(86362001)(83380400001)(6506007)(66476007)(8676002)(6916009)(54906003)(66946007)(38100700002)(33716001)(316002)(2906002)(66556008)(82960400001)(5660300002)(44832011)(6512007)(41300700001)(186003)(26005)(9686003)(8936002)(6486002)(478600001)(4326008)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hoSkjZ61G4efwESClbi1i5W7OoFjeEyfkLsMa+dzHYCbqCmgkGqtzw+RSBTf?=
 =?us-ascii?Q?tM8rmHrYpdwiWdAKHaRFxBYPasaxq/Iy0JHsCxRoHnMRs6nbbMw7eBMwuhLx?=
 =?us-ascii?Q?5RyqLWNtMkRCkeoYdI8Okllmlmdx2xDuBOlc/tiTu65/jwBWZ5VkeTb1cGHT?=
 =?us-ascii?Q?7hdztU1Q0RSsIxW3g4raFYqMo8H9jxMDXy4Pf8+F5CwEcan89/Q5K3Tuk+9t?=
 =?us-ascii?Q?sjwE/iWl0TQesuez01ErbGxAOSjzom7zHdBKfLKa2W+CGR8n+LWqbjg2xgPA?=
 =?us-ascii?Q?8Y116sEWg06t0FBmqqg9Cj/wAY9dTS5/8IN4SuyxgVMb1gnkQxLyuXwzVWpM?=
 =?us-ascii?Q?NKcoGFbShe00gITokmZ8x0ayiDhBWz8AKPvUEt3L0GgtIZdJObRud1Sita8V?=
 =?us-ascii?Q?RfCtZEy20dXY9peZvOBqNZSegXMGKg6wH2exd3b/eOLp4DJHv9vO39JBI2QP?=
 =?us-ascii?Q?VNHXAwIjPRYXjw/gq+5AeB8NfYQJpjUlW0skaGbHKgC+uwfZ+2L/FSF7YF/3?=
 =?us-ascii?Q?5qDe1SdUi2BNJXqyxDgi8sovR9ZAhUb5gKCHqxDQS/ZmpKP1D9u8bJXU5P3Q?=
 =?us-ascii?Q?q13LRyyFVkE3+EOhk2ckUqURxtusIKE39tcFFrCcKB3fE23M8JtZ0ixWPtD7?=
 =?us-ascii?Q?/P11EZM1hrcWYXNA2fr7pa/psNTn3/mrheCTnz8d/vr9YQRSzs+bE9qnW55l?=
 =?us-ascii?Q?q9fNpjKV2GXiesSoW+U1o/+4hKycCex+L4tbbvzMKxNnhVQQhkpIsATd9fhr?=
 =?us-ascii?Q?ihlYi8R/Yk5iw4T3Q7PuhiigzD9kd3u13z/PIGJEe2qOsvo5Vy+ow2eeQncM?=
 =?us-ascii?Q?PcWPh04yCRs89gsvM8PDEZC7vuRok/DLZjbwWTBCVOQWrotTwaEu4v7cvGaN?=
 =?us-ascii?Q?ndzC5j3xk9i0kYYtZg4k22zPzl5O/seN62G/TYYS2x16QeVabhCi3iBFgp+s?=
 =?us-ascii?Q?p0B3IpAq1lv7X20OQhmDfclTKQTE4L152cFhUhCi3wcnAq7xmf5mBRG1I5ZV?=
 =?us-ascii?Q?xAeQ4uJMGuKTgOEBKngDPsPsVEk0HjXwv1h5PhWDLHtHGJHSAVPSlFqw6BYU?=
 =?us-ascii?Q?qfNR2SwGCsBe+rdH5EVsnnkU6Fo3k5JNCmxVBwZx9/Osf7FL6t6kjw8ImPRw?=
 =?us-ascii?Q?R5hRQjI0lPBQUKymQHQflAI90FV6zCrmeYx+mUw5nJSiKqh9XPPr7xomG/+4?=
 =?us-ascii?Q?uv1rELGfh/aakPRYOcFp/sdevlIdZq9Idjoy619T8xEX/NIwdJemOFe2/irD?=
 =?us-ascii?Q?s5w6KMbxRu8CtGDDvj5UbbNJI56PTw4ffBbnSPtUd8cCsRv7IiY2Mamcs/sN?=
 =?us-ascii?Q?pqT/pemUN3eSAlQItxoEHUyxhUtZFph5b5aHxO3EJRJq2rbQCHxjQRyf575Y?=
 =?us-ascii?Q?fDvUBrsp+NngYB84/yVUpGMpFy4RE8bWpOJbkkqjUpkxgJYG/b89eJxgYLWm?=
 =?us-ascii?Q?2tQOOvOKP8ehRpu7s6rPGvbJbm75+CpqwSS/T+Dr4s3bhdOQmoTiXwMJRqDd?=
 =?us-ascii?Q?zZu8eys+dlocLBZp24o/pT1JvOjC4YMDCoE/BicGKIgvOjHXs4YUwW/bT9ia?=
 =?us-ascii?Q?3D9jOKSYGFGw8oG4nw9pg4WIIRmX+0kJ+Qu/QFq7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be4da3ab-4ce1-4a98-8b2b-08dae08b25a0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2022 00:02:26.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOjynyjsVqem2H0zFD3EXmanL7QtpUGqTEs6wB1P4lr/eYOnelAC9NnmdGnINpHRq3nRbpz7OjLTYGU8GjhW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 08:53:45PM +0000, Matthew Wilcox (Oracle) wrote:
> Removes uses of kmap() and b_page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  fs/reiserfs/inode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 0ca2d439510a..b79848111957 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2360,6 +2360,7 @@ static int map_block_for_writepage(struct inode *inode,
>  	struct item_head tmp_ih;
>  	struct item_head *ih;
>  	struct buffer_head *bh;
> +	char *p;
>  	__le32 *item;
>  	struct cpu_key key;
>  	INITIALIZE_PATH(path);
> @@ -2382,7 +2383,8 @@ static int map_block_for_writepage(struct inode *inode,
>  		return -EIO;
>  	}
>  
> -	kmap(bh_result->b_page);
> +	p = kmap_local_folio(bh_result->b_folio,
> +			offset_in_folio(bh_result->b_folio, byte_offset - 1));
>  start_over:
>  	reiserfs_write_lock(inode->i_sb);
>  	make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3);
> @@ -2413,9 +2415,6 @@ static int map_block_for_writepage(struct inode *inode,
>  		set_block_dev_mapped(bh_result,
>  				     get_block_num(item, pos_in_item), inode);
>  	} else if (is_direct_le_ih(ih)) {
> -		char *p;
> -		p = page_address(bh_result->b_page);
> -		p += (byte_offset - 1) & (PAGE_SIZE - 1);
>  		copy_size = ih_item_len(ih) - pos_in_item;
>  
>  		fs_gen = get_generation(inode->i_sb);
> @@ -2491,7 +2490,7 @@ static int map_block_for_writepage(struct inode *inode,
>  			}
>  		}
>  	}
> -	kunmap(bh_result->b_page);
> +	kunmap_local(p);
>  
>  	if (!retval && buffer_mapped(bh_result) && bh_result->b_blocknr == 0) {
>  		/*
> -- 
> 2.35.1
> 
