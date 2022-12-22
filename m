Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A34653BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 06:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiLVFlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 00:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLVFlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:41:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0A2BC0;
        Wed, 21 Dec 2022 21:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671687676; x=1703223676;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Zo/fbzhz2/KeSWjzHSyX/uhSqAWWLw9x+eTLpxwC4cQ=;
  b=Ewe0pbzo/JlspJ9Voi2O7xjeM3Ix9/Z7XPTupF02GSL22nHn87dElkHd
   y1u532TT416bEkO4Tov/TRdIJchx3bmseqBPS1rcci51zOrh93m+NLHDW
   YHHLeAfP3sNs0zqkDpFQuu1cXp2J84zx+vQfNxN6IHFVIqP53eHEjMjwl
   Z5zSpXcvBdJ8LgiQtetmX5OrCyqf39vvzKprw+2z+ChDZylgbc8iYsSoq
   5HOt7UnadG/QD44pzHmVuzdWXssXnL2biaomGHV2OQ1emUrXdtxZVEDUS
   QHBk6p6X6YhruTN2h5hiwC20NArcqNtb98O5K3odo1ivSFBxQccFbKVOf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321965933"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321965933"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 21:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="980457893"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="980457893"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2022 21:41:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 21:41:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 21:41:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 21:41:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTU8TDA6YDU2wwWT3bOHmrWH2nqIXhaMIVITMvupSjawAUXt9wnmzSnaZd8qzVw6WQpQ+a/NTl0y8JrAGn0bVIeR73JC2ELWg+i7skfZ7MmobQeg1b8GwV3JuTjzgbNj1485ctXCTAECvl2DJqotXavWVmqqAufWBIoFyT9y2uYxFk1PbNARNFHjPFrwdw3rMvIoNV88hDeTy+H+/aHBxI+k2goHHMeEhdd7SM8VngKg5fi3svBlxUV361ny5S5KwxW7QXRK1pzDa1WttbTAxbjb6ZkFIc4KeTzItvgH9w8SUwmEF2obEaQen6PxuafMbHXBsMBxBEm3IqULR7SLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXjmNwxDO3Xec2XZAZarYMfYNHW0ySRLe1UZNq3/iwc=;
 b=BI+Fq0yBc55e0YS9bpry/p/4oyssudd5ddmtDv1a3VszqEqC9f2VeGUxs2Etz+IsMGQ1UxLxuLT/nzAoyJ+MlH3QbvuSrUxulBCHjcG/+Mf94NWFoNJ7Zm+lh1gOJUzHS62MTDENAWxYkp+Pk85lXiYxuwpfwXr/4W0YfAhJktvTrGSXXkXISzzRl9rwZ2EK7UyIoHSzsFZJDQ1sOekmTlrMCwDSdAFy90mim9WXQ5Ma/L2zYRrlzlWZLRDC4cecPekT2blp7I9o8tHNS7CqdXTO2QNHTN+k1/JvEw1D64aOoMEpquMby490pOVePF/yfJ0gcDJDJxDCB5R0GrFVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 05:41:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 05:41:07 +0000
Date:   Wed, 21 Dec 2022 21:41:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y6Pt7QXbXjaFpNjx@iweiny-desk3>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
 <20221221172802.18743-4-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221221172802.18743-4-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c426229-0a56-4854-61f8-08dae3df1fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKIAfpXI5UVmqcqMu25e2PA/dTjFdBP0QHDKpLV92vqw96zNDP1IVxcp2zXhvjO0mFu4hXHbfe0AVpQ/S+6z2ur1KrVqMx7qFL7Vi/3KTWHaLkrySMKSgiyarFBDkPicNcoqSGX+w1bACeTUHKhLnNqvEiwZfWAabHaombkxc4/q5cF+5nZ6ysubSeYhsBGkx4B6I7p/bsDShbnbnUKgT23ooQTkQ3DKtGMsMaK0mFZg+p9aJeHZjnDZJhONoLO96x306jgQgO0/90ycC12Q46xml1+Ao/6jFvQq/o6v470niNEnbuIepO+yvrTVSuFDtoC0HvgsSjjK9IQy7t8AQfP75EFUuuEzId46qoRGFc2ToSQFzXtpf0+S6YQJYiys73MkFNaLRTD6AcEHJEIVNwJ2tlI67TNf5shrtuqsYVStj/I1t2ezDXXBQKYt10j7dOTIS4dn5rfpVcfREjRiUPCbqqx29YRi4D6t1bF1ldAQ/bKh6d1EqqAr/sHUDc5Gdi9F+iifpTGUQfyCOAYFX+aiLDIhCDfqgTxWaSecEGylyhhzbBx35RjpFuzrubdmeFV/iKRcdrtQUSveEYlz/oscqgYf2M6JYAT3jzHi46XujgVZiO9a9P4UD7iTHm9jst5mTVwxH/ynNpvivjAe0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(54906003)(6506007)(6916009)(478600001)(316002)(82960400001)(6486002)(33716001)(38100700002)(8676002)(66476007)(66946007)(86362001)(66556008)(4326008)(83380400001)(5660300002)(8936002)(6666004)(9686003)(2906002)(41300700001)(186003)(6512007)(26005)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FMcWdwaXRwSC9iem5XRlpobzFhQm1sZU13MFo0alVNTjdEZ2xleGRxQi8w?=
 =?utf-8?B?Z2VuYmwrZXhKVy9ienhUYnVnNVRjMTJDNk9uRHYxWnpqelBSbGtPTDNnaG1t?=
 =?utf-8?B?RGtqY2ZCUExGSFVUUW1uWld2bit5YlJvRDFQeWgrVzJxTlVHWCtxYStZQ0Mz?=
 =?utf-8?B?NkZEcVBETmdsQUtLc2VIWFlGczIxazJ4dUVmV2NOTUFhMTNEY3o4TTF1bWNT?=
 =?utf-8?B?LzJ3VWRBZTBDK25hRThSa0lZdkN5N0ZmbnFqTStwcUozTlZnSXgzN2ZmakdK?=
 =?utf-8?B?T3plam1RZU1DbXBpdWh3dkcxTHBrS2Z6T25mRytJZkgrWG1LQkZ2WXhBT3d0?=
 =?utf-8?B?ckRPMHJFakdvWkt5KzZQZzBIZWhHNmdyWUt6aDY4WjluOEdESjBOc1pMcm11?=
 =?utf-8?B?K0hFd1NpYWdsUTVqOW1OWWJXczk1VTN6eERhaHA1MXZXejl3bHhoZ2VNVGRl?=
 =?utf-8?B?Nm9FK050S1VHRnF0OGhBWitDN3VXNmV1ZjVialNqbHgrT0w5S1hsaFhYNTB4?=
 =?utf-8?B?emY3ZXFmMkQ0RjNlUGMrYmo0TEl0Mi9VT3haVWh6Z25RVW55TmNZeEpSRU9S?=
 =?utf-8?B?QWg3WlRzdVNUNlMwdks0d3NianFrVmV0KzByREQwcUtvTjJNZWpHZzgzTXNH?=
 =?utf-8?B?a2N1WHhGc3lRNHBJWGFiN0EweW84V1d3QWpKOVJUZFBDdWl4OEkxa1VEV2kv?=
 =?utf-8?B?OVpqblp5aTZoNG1UYWpuR3BSSEtVVkRnd20vNUR3MU1DZi9aeDd6L2lGMkty?=
 =?utf-8?B?VXFCNWR6NEt0U1dDYmptdi8wNHgzdWxaaTNuQTJaSVZpVzVKeWphSDkzYU9x?=
 =?utf-8?B?bFdNUWhmaHpCQVBscnlSSDYrVDFEa1MvOHRWa2tJQUFMU3VHRlpFYm96QXNX?=
 =?utf-8?B?N2syUlUxSXdsdXNZempSM1BZRjR0VU5PSS9RWC9sL3RPQ3BPeUlubGU2SXMy?=
 =?utf-8?B?TnY3bGVPWmFSdlpEdGV4TStFU1NGVStjL3hkd0VtTWo0SEh1UjdzVEhFUzli?=
 =?utf-8?B?eHpTaWhpaFF0emxrTWVONWtMQ2tscmx3YVVwNkUzZTZUazgzTE9qcjY5cFBo?=
 =?utf-8?B?ODVtYUZTODVhWWFPaGVDTjJYOE5ZdkE4UUF3cHlKN0tHbEJ5ZTVjZWVtT3Bl?=
 =?utf-8?B?K2Uramo2Q0RzTTNXTGJhaVJYRXl3SDk0cE1Cb1NpaWRtMS9zQ3p0ZFFyL2Fm?=
 =?utf-8?B?enM4Q2psQUU4QTU4dlhoQVpjRU5kVWhYbzlEUVU5S2lHNG5Ld0hLT3BtRHcx?=
 =?utf-8?B?cGR0VnlFMXgzT0NTMnl0WC90N2hjZkE1ZWtFWFB4aHpCUnhrV05jV2RGbExL?=
 =?utf-8?B?TzhsS3JrTEhVTGhPYmM2UkVmQklzTWQvQkgzV2YydlllalhweDVzdEJJOGJI?=
 =?utf-8?B?N3JrRmdIWWgxYzVtVU5lUFh2WEpLVHZRMnpMVXVJQURxL1VWaHhFdHJiZWxZ?=
 =?utf-8?B?bmNpN1dFSis4TDNIQ250OGg4Q3A0eWlIdmordC9KM2xHVFdKcUpWdzZ3d3l6?=
 =?utf-8?B?bEdZbVd5VnordlFKZW5EeU5tR3Nnb2pKUHI0bW56YXpXOVdZQWFMWTRLNHNL?=
 =?utf-8?B?VjhBYWtpMW93QXU1aytlR0tTdlRRZ1ppcE1CVy9Cdml1bkVvUWt1ZVIvQm9z?=
 =?utf-8?B?RWk2eS9rS3hxVU5ZdkJ0V1M2dUxDZ01Ed0x4aWtFVnArdkNEM2ExWEc2SUE1?=
 =?utf-8?B?MHZBYzAyN3NSSW1mem5IQVJVcjhiZG1BREZ6VU9EdVNMcjBmTGdhbTJ1RGxS?=
 =?utf-8?B?eWUvWjR2Y2dvWmZremlKaU16VThWcDRPVUE4MTI3OENhV0FBdHJoTFBQY0JW?=
 =?utf-8?B?SDNpRCtQSDlDTjNmSVF2UnNKUS9oWDE1cDFseXNVRWJRaDRKMEJwMUNHZGRP?=
 =?utf-8?B?QmZCOHpXdjlxTnkrdDl4a0dVYWdIMjV1bjlONEU2cExiNUJxYUsxamRPUEtk?=
 =?utf-8?B?WWhmanlwZ2ZiU3lMbmdvVDFjdXF5V1JDTVZvUU5LYThzYllkU29maTVxVjNP?=
 =?utf-8?B?WVRaTEJpRW04T0lMNis0K1NyWW9XRXZRdE14TS9VYWNWS3VtMGhHd2RaUHkr?=
 =?utf-8?B?U2xXR2JsOXllNU80Z0xFYnllSXNnR1lRRk1KQUtLOWJsQUhsQmRydWV1UFlN?=
 =?utf-8?Q?w0gZfnkRrq3w7iNb8Zx/nHFZc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c426229-0a56-4854-61f8-08dae3df1fc2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 05:41:07.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IewGuNQzgIeqbfkjzLbmd3lj1BePXDim15soIpmyL6BaOgBilor9U7NYANCB4KMPyeCztrtuikndV+uhZc200Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 06:28:02PM +0100, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/ufs is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> requires the mapping address, so return that address from ufs_get_page()
> to be used in ufs_put_page().

I don't see the calls to kunmap() in ufs_rename converted here?

Did I miss them?

I think those calls need to be changed to ufs_put_page() calls in a precursor
patch to this one unless I'm missing something.

> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ufs/dir.c | 75 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 9fa86614d2d1..ed3568da29a8 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	return err;
>  }
>  
> -static inline void ufs_put_page(struct page *page)
> +static inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));

Any address in the page can be passed to kunmap_local() as this mask is done
internally.

>  	put_page(page);
>  }
>  
> @@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
>  	de = ufs_find_entry(dir, qstr, &page);
>  	if (de) {
>  		res = fs32_to_cpu(dir->i_sb, de->d_ino);
> -		ufs_put_page(page);
> +		ufs_put_page(page, de);
>  	}
>  	return res;
>  }
> @@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
>  	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
>  
>  	err = ufs_commit_chunk(page, pos, len);
> -	ufs_put_page(page);
> +	ufs_put_page(page, de);
>  	if (update_times)
>  		dir->i_mtime = dir->i_ctime = current_time(dir);
>  	mark_inode_dirty(dir);
>  }
>  
>  
> -static bool ufs_check_page(struct page *page)
> +static bool ufs_check_page(struct page *page, char *kaddr)
>  {
>  	struct inode *dir = page->mapping->host;
>  	struct super_block *sb = dir->i_sb;
> -	char *kaddr = page_address(page);
>  	unsigned offs, rec_len;
>  	unsigned limit = PAGE_SIZE;
>  	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> @@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
>  	return false;
>  }
>  
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> + * and must be treated accordingly for nesting purposes.
> + */
>  static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
>  {
> +	char *kaddr;
> +
>  	struct address_space *mapping = dir->i_mapping;
>  	struct page *page = read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(page)) {
> -		kmap(page);
> +		kaddr = kmap_local_page(page);
>  		if (unlikely(!PageChecked(page))) {
> -			if (!ufs_check_page(page))
> +			if (!ufs_check_page(page, kaddr))
>  				goto fail;
>  		}
>  		*p = page;
> -		return page_address(page);
> +		return kaddr;
>  	}
>  	return ERR_CAST(page);
>  
>  fail:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return ERR_PTR(-EIO);
>  }
>  
> @@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
>  					fs16_to_cpu(sb, p->d_reclen));
>  }
>  
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
> + * accordingly for nesting purposes.
> + */
>  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>  {
>  	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
> @@ -238,12 +253,15 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>  }
>  
>  /*
> - *	ufs_find_entry()
> + * Finds an entry in the specified directory with the wanted name. It returns a
> + * pointer to the directory's entry. The page in which the entry was found is
> + * in the res_page out parameter. The page is returned mapped and unlocked.
> + * The entry is guaranteed to be valid.
>   *
> - * finds an entry in the specified directory with the wanted name. It
> - * returns the page in which the entry was found, and the entry itself
> - * (as a parameter - res_dir). Page is returned mapped and unlocked.
> - * Entry is guaranteed to be valid.

I don't follow why this comment needed changing for this patch.  It probably
warrants it's own patch.

> + * On Success ufs_put_page() should be called on *res_page.
> + *
> + * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
> + * accordingly for nesting purposes.
>   */
>  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  				     struct page **res_page)
> @@ -282,7 +300,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  					goto found;
>  				de = ufs_next_entry(sb, de);
>  			}
> -			ufs_put_page(page);
> +			ufs_put_page(page, kaddr);
>  		}
>  		if (++n >= npages)
>  			n = 0;
> @@ -360,7 +378,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
>  		}
>  		unlock_page(page);
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	BUG();
>  	return -EINVAL;
> @@ -390,7 +408,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	mark_inode_dirty(dir);
>  	/* OFFSET_CACHE */
>  out_put:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -468,13 +486,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  					       ufs_get_de_namlen(sb, de),
>  					       fs32_to_cpu(sb, de->d_ino),
>  					       d_type)) {
> -					ufs_put_page(page);
> +					ufs_put_page(page, kaddr);
>  					return 0;
>  				}
>  			}
>  			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -485,10 +503,10 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>   * previous entry.
>   */
>  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> -		     struct page * page)
> +		     struct page *page)
>  {
>  	struct super_block *sb = inode->i_sb;
> -	char *kaddr = page_address(page);
> +	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);

I feel like this deserves a comment to clarify that dir points somewhere in the
page we need the base address of.

>  	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
>  	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
>  	loff_t pos;
> @@ -527,7 +545,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  	inode->i_ctime = inode->i_mtime = current_time(inode);
>  	mark_inode_dirty(inode);
>  out:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	UFSD("EXIT\n");
>  	return err;
>  }
> @@ -551,8 +569,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  		goto fail;
>  	}
>  
> -	kmap(page);
> -	base = (char*)page_address(page);
> +	base = kmap_local_page(page);

NIT: I'd make this conversion a separate patch.

Ira

>  	memset(base, 0, PAGE_SIZE);
>  
>  	de = (struct ufs_dir_entry *) base;
> @@ -569,7 +586,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
>  	ufs_set_de_namlen(sb, de, 2);
>  	strcpy (de->d_name, "..");
> -	kunmap(page);
> +	kunmap_local(base);
>  
>  	err = ufs_commit_chunk(page, 0, chunk_size);
>  fail:
> @@ -585,9 +602,9 @@ int ufs_empty_dir(struct inode * inode)
>  	struct super_block *sb = inode->i_sb;
>  	struct page *page = NULL;
>  	unsigned long i, npages = dir_pages(inode);
> +	char *kaddr;
>  
>  	for (i = 0; i < npages; i++) {
> -		char *kaddr;
>  		struct ufs_dir_entry *de;
>  
>  		kaddr = ufs_get_page(inode, i, &page);
> @@ -620,12 +637,12 @@ int ufs_empty_dir(struct inode * inode)
>  			}
>  			de = ufs_next_entry(sb, de);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 1;
>  
>  not_empty:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return 0;
>  }
>  
> -- 
> 2.39.0
> 
