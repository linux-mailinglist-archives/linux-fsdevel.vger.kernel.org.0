Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9941465BA0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjACEaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 23:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACEaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:30:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C14EB6;
        Mon,  2 Jan 2023 20:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672720218; x=1704256218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TA3TdMQkuzP4/I+kTcZ2oFo86Ex/LZdz4bxMlIZFDPQ=;
  b=Xog8MG5YpA8yDgchoeHHBlVj6cLVKlSGMhJyXNslA2X/MgYtiijJsSLG
   aDggTUXc68W7d25SxaLgbRbG2CgGvVtZC7RQq5xspeaFpko++seweyiw0
   zqChVZ3yOy+HO+fzjt+Yz8hrZxRX0lv1vut6SkddgPZWxj+EyzIdjSxc+
   Q6bl3647q1OVTfgVc1tj8RhHOWMg8XE9j7xJgRGLDIDOGq9xczGCUMRxd
   lfEXQFyFKNKWhusFNkNVswLB342yUaXlSVNxxwuSarBLg3d4kzwxX3gmY
   doqwuDlwYN4XrsjGA0yn/gwuD3qM8CaFTHr2ynSr4vv7lRPf1FZoRNl6j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319285357"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="319285357"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 20:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="900034329"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="900034329"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jan 2023 20:30:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 20:30:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 20:30:17 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 20:30:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkkdD/qx7JtVo8aCXxraZwm9Ls4p9C7TMGLYcygyfm79ewpKUdDUgQykxRpQfiHbdlXM3kcYvFsXBu/8CguHknn+eqAT51B3bS+IvXAaqIAmuv9gVXCP9XZcdhaUjQaioNBOAZ7ntWPlLIT9lDCO8JuyH3pZwEBuBqtvm63D83ObhLXRtO18QfCM0cy9JrQroSEknXHd2YgqUXbqD9bmsq5dtst0oYKgMVn9GmPcqoYDv8j1+Xv1jv8P5t4E4D0Du7uQ1DB45bwwxO3V3LqJ2DkBaSU+Jd8lmBCPZvxZIQKhEIrQYfXlD6OQeXWO3qzPB6X1vEzYSCSSoVdBx7Th7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahkck+Lodx9GFIqo1h+NmK22nXP6IGE9p6lnbJRAEIM=;
 b=VNr+Wl6eL1TrOG+UvIvWoiNrQ9xT8fsZUUVtwygYwQFwWcJEXTsQBzIY+yR1+8EFCOnUxQ5Y/h/5Ah35pTpeO0GQNP6cei5p4JcAzw2jMhvYi1/lMjDLCnoptVpq+lhrwIpzx5KKzIJJ7Ii7vNfCIrGDtQfhmwCd4iko+SYZEcMYmjAsTJDseNdQf9jYyr1l98AmpTG/+kns5wmMWTne0l+GAQ+vNhOrbtiqfM9TTYYemRiTveyx5SVgBJl//1q9j6omisDiGd0DkDba6yf0w/AXO2SilDLZq61vpbyDOl8pYNZmJ2eJNd/xSZVvDsCXiLQGe6ALTiF2P7CjPlAthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6199.namprd11.prod.outlook.com (2603:10b6:8:99::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 04:30:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 04:30:15 +0000
Date:   Mon, 2 Jan 2023 20:30:10 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/ext4: Replace kmap_atomic() with kmap_local_page()
Message-ID: <Y7OvUjWtYPTJYjbU@iweiny-mobl>
References: <20221231174439.8557-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221231174439.8557-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d6bd5e-97bc-43d5-079c-08daed4335ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7RcuIbKbZbDrnwbmEuWrmqchzgXGB58ItXBIjXDUU+cLrDuPtzfjP+e/NQrkKmuDdAuH3l5/SgRwDLcFC3UnkXsvCCvgJLkPPDNQ9jgiI7aX0CeGEI5WnxDxMGXihe/IY507UBsXto5TRgb+5dVJ9JagpuLRiy0WgUlrvV0jgTimkuHHfsvqa0/DFNLQ6ZnTofPeIfGY1wckrU/aHLKn+EoLcIDrwUROMehkotIOtnnvNhWcK+taKgzX7OliF4crhK2AYYBsshL17t+xGUPsqznfXMn45mnyMfWl3CB295VzUOAjf+0bAZL6bBhPcN4qFnWqRCOi0USiY3q4dL3U56J4kQLWQSyNdSoaGCZbUnyLw6LQYySo7oEznFCuNglRipb8Fq1RbScjchCp6gYnqENvc2C2JmpmoVyeyeoObExP5MZyyJ3bdULtKJTdIErQLwExG94KZiYLtq23089P61MSwqpmG9odMNpoqE1VkJjtXO119ZV7oTkx8m5+ha0W4qCMWsna8QVcqtfwgAtTavj/coeFlcMAPJandX2UI2VaTVg0oCK91jh/Fr3qzHOXqTQuohc63kpfVmmA1MieCIhBgRda6dTJa3VNC/akXGZxJk71oRciQVjsx3caALblMOcSc4WUevGLyev/US0vSLiBxnUr/OuFeksIgXeydGu9JG+6ylvgyvCoZP1vVLZY6BWY/HLL/n9fx31MN4Niw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(41300700001)(8936002)(4326008)(66946007)(7416002)(8676002)(5660300002)(316002)(44832011)(54906003)(6916009)(2906002)(6486002)(6506007)(66556008)(6666004)(478600001)(66476007)(86362001)(26005)(186003)(83380400001)(9686003)(6512007)(38100700002)(82960400001)(33716001)(22166006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mFiYqqlRCm2+oJgAOeRIenz9bkNwtbU2LnEdte0xJAV5UZgS2TTNxVngwl9v?=
 =?us-ascii?Q?5s8is4SclT7i6bB9afBBn0CPYqVro0sa9vTsYq511SypIqO8yQ5qygYs6ynU?=
 =?us-ascii?Q?ZUYfZv+snNElr/P/huG+e9HBnt2BHnbHfzmPkGSIFID7M+JO/hbVmfKNfetA?=
 =?us-ascii?Q?7vrxg+xp5+yqlurGWmzoW5uxRiAjWkVIVc8TFFelEUBvXvz8Oz6w69M66fTG?=
 =?us-ascii?Q?eTr0+cHJYkCvWIx3iivze8wuZBOLumWlabzWvLiJIoeKkUj8XwfFcAs535Ws?=
 =?us-ascii?Q?4ovqkReubuAembdPuejBXl+/rhcL8Ka9hDXZIH1rTpVxNE2X1s75lCzfhGfI?=
 =?us-ascii?Q?BxvCBNU+44rXV2JJVGWF+KalBQNscIXs0tdmxXE9faNk2ilFo5dXVN2YZE7H?=
 =?us-ascii?Q?Q6124+Q2pATX0HCCdP/hwg/2Ch8TG0+idAQrqK4XyrBW7YtvISxrOpwNV0zx?=
 =?us-ascii?Q?E2sGSiGzO16YiBj3i5PlV3y4eSDs8WQXHu4k/J1ehn/kk4cokuyzNcz2U3jy?=
 =?us-ascii?Q?djlBiKFnB0MMAm7zp3I5VtybjsfVjnBHnfHoes6xUuoR0RJlAnI5CLmx6BBD?=
 =?us-ascii?Q?4Qr8bdJohXW0CRLOSSpcW3ArlA6ZtlEKHAW2+1VwdaAOsSmdsZ/mDw+ENGMW?=
 =?us-ascii?Q?LKBkGEeL0AKuohTcEc1d6yyVRGN/S9JaQCHUkhBQfKMDJJTQbbAs6t7tQ4SR?=
 =?us-ascii?Q?L+79nHlqnbCKoAy4r69hY804MHkVqcm4lRlm2eWe8H9iqQS9V8yPRaZ0ozoA?=
 =?us-ascii?Q?rDRyfXH4T3jv5uVGewrrsIY+QdTwB5e9yvf+tjcyocvSj8OGZJYoAbl0aTWe?=
 =?us-ascii?Q?c/yT+Za7crH5RYozx2OiXR61RS0XY2+UeZdtQhgpnb29oxYZtTTn/0IFc5WT?=
 =?us-ascii?Q?EVUyrqFAwo2hUPDt0dlGKzO5iY8PbofBZsK1Z9xS+oR8tyhC1ojtNCsO/MdK?=
 =?us-ascii?Q?ckfWqI/nqmwzOC9gkiyJhCZWvIUsFcgCqVQPgQxdTX9SnZGp1u89AzLYbzOD?=
 =?us-ascii?Q?Wq3HiUYFDh74tquEgM0S0pcpcuOpOKPB7vfHWafgRGhk5f5lJtByifEfWI5J?=
 =?us-ascii?Q?eQ24bKSDRKqQuCBl3/OSj/AmpM/T8UN3t9Kd9PUVF+XSz34GMe8+cpEV2Oig?=
 =?us-ascii?Q?RnPyfxXPbW+JsCmkadBu5tuvTg7RuEbJcty6eqzxca3y0FiHAWJRlGhqsYWZ?=
 =?us-ascii?Q?G9sV6ngfV4elP39u+0WF59/adm9UFMqdG+8wzz+vejZgIAItuS7NvlDOIjyC?=
 =?us-ascii?Q?P10qhhA9ez1emJnSL2c250RronhSAKZg/voghfus2B5DMtxOOKYL/OQBc1TC?=
 =?us-ascii?Q?kewi9G9uUs9d//z5cmxZtUQZcsANMU0Xs63sheWxnIU85r/q4AG5eaNX+YuO?=
 =?us-ascii?Q?yK6vs9exmU2KHkHl/KJ/biwvCDNBVZdzke6SH231bajO3x1Zjl0SrPTE7g5k?=
 =?us-ascii?Q?dyNa2n7FT83HmJ2ZEDdcg9MKgWzAH0r3kLO6tGCCwg9Twu3CqC/y0OzOE7J0?=
 =?us-ascii?Q?2LP3YJAdhUJcJGtmwWD4ubYg6d9/lDRPTs3EXDyBi4pcQnhgS0qR0FB00Avd?=
 =?us-ascii?Q?pyEcw/Uece+HLolyvGoo0efarjJhJEARjKChSmpa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d6bd5e-97bc-43d5-079c-08daed4335ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 04:30:14.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKhYRkcT7o8nhRGqCSN6QNreb6PkQamvvrw+iqHpdDg7wAKz+AG1gsmx6IpIHjTYN8ylH+h6K5a10ftEtahJng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6199
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 06:44:39PM +0100, Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page().
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> 
> However, the code within the mappings and un-mappings in ext4/inline.c
> does not depend on the above-mentioned side effects.
> 
> Therefore, a mere replacement of the old API with the new one is all it
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> I tried my best to understand the code within mapping and un-mapping.
> However, I'm not an expert. Therefore, although I'm pretty confident, I
> cannot be 100% sure that the code between the mapping and the un-mapping
> does not depend on pagefault_disable() and/or preempt_disable().
> 
> Unfortunately, I cannot currently test this changes to check the
> above-mentioned assumptions. However, if I'm required to do the tests
> with (x)fstests, I have no problems with doing them in the next days.
> 
> If so, I'll test in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
> 
> I'd like to hear whether or not the maintainers require these tests
> and/or other tests.
> 
>  fs/ext4/inline.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2b42ececa46d..bfb044425d8a 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -490,10 +490,10 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
>  		goto out;
>  
>  	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
>  	flush_dcache_page(page);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	zero_user_segment(page, len, PAGE_SIZE);
>  	SetPageUptodate(page);
>  	brelse(iloc.bh);
> @@ -763,9 +763,9 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  		 */
>  		(void) ext4_find_inline_data_nolock(inode);
>  
> -		kaddr = kmap_atomic(page);
> +		kaddr = kmap_local_page(page);
>  		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
> -		kunmap_atomic(kaddr);
> +		kunmap_local(kaddr);
>  		SetPageUptodate(page);
>  		/* clear page dirty so that writepages wouldn't work for us. */
>  		ClearPageDirty(page);
> @@ -831,9 +831,9 @@ ext4_journalled_write_inline_data(struct inode *inode,
>  	}
>  
>  	ext4_write_lock_xattr(inode, &no_expand);
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	ext4_write_inline_data(inode, &iloc, kaddr, 0, len);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	ext4_write_unlock_xattr(inode, &no_expand);
>  
>  	return iloc.bh;
> -- 
> 2.39.0
> 
