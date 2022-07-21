Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75A57D688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 00:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiGUWHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiGUWHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:07:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFBA88744
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658441266; x=1689977266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FPxQlNN2rmxz1M/r1OhqQz08Bo6Rwfkhyq75YDQGrWU=;
  b=dsuuYXOUi7o8lzB6emz47m6NXo+FlET+xssAwMYzq0JTDfq3YyKHIQ5s
   WADTvmCQZZy/f3+ZCu+HYH7waXuEPC6e8OP8wrtB/U0AYSKgfnM5VtEpa
   C+LmS4lKvoWX/0fK7TK9mf1BVa0nEHAbjnDAtqoenBuekmZxOOLnTZCL0
   3jCLrgNCPTRYjK4NKNTo+NGfRnecX/z/ApQ+A2nGTaH1WFEJMazYA4iLU
   lgk0rXc6LobG0AsBhJJppwcbxyKPgccHkWemXdXBbb5Srg+VUNl3chnB4
   zhZXQDB2FcDD2uzjW/UGnBSiCEOIfEPeP7LyKnrL54idjtcRrAn8Czf8R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267579373"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267579373"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548949912"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 15:07:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 15:07:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 15:07:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 15:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN03ouLvmgx2aVzTLQSATWTS6v0Figl44MVqfn1x0Szkq112icu/idyumFtnEm5y3ILO2V9XjXk0BTTpjOgcAMHWZvwEgtrvma41D+7YEkPnqFOPg/q7hsvfp62r5H0HRFyz8m46A6Gt1jSM1fiNJs+ZOFu4R45cj4Y7RJXXkynWuT8Z8L4KG8qc4xA1UT2XzCp9nRAfu2ICr+48rBPRjR4EFXHihfEuwHwlasuwhcobv8pCtnq2o79sN4t6Og7aFuPSQ6OQKW/cjfJm6/u44KL6/DL3BZ6wguFJyqBuP28Lsh4MaH5NXUNiE7YgNMtJjgu/KRP/xwx7z1HC/AkKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IifXe80LPL5F7pkUUCp/AsKt3qVVQ6GgJ3PXnvJ/y1w=;
 b=EKOvrKY2RJoK6hefdkC9xKhki7Ehab+oXRF8MoIAkAHy1IAO8eV5KFKOGBCJ/5gURZp/wHsNHpNv1rJnZCeZoB+X5afeJyXtxpGRhrOI9QPcURZJGszxvrQ32oxiuk35etcG0RoRLvMeMKUjTd9P0a4p/blyNmzJRHqFQd01YDQFYWlCh+6dbr4euAVI/WbNYZUAZhHV7cikQKxcL7ZoUkKQZXVV4156UWbsuDT+ftad/uw9e/KBMpXwMwCZlxB5T+lTMijh3NJZd/ByUJ6Pm93FEPSrYv6CpAWnEDZg9KYynhvQCOzy8iLv8JG1kbPYBLc8oYh/hq1/nWgmlGH8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BL0PR11MB2963.namprd11.prod.outlook.com (2603:10b6:208:7b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.19; Thu, 21 Jul 2022 22:07:43 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%6]) with mapi id 15.20.5438.017; Thu, 21 Jul 2022
 22:07:43 +0000
Date:   Thu, 21 Jul 2022 15:07:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Sterba <dsterba@suse.com>
CC:     <linux-fsdevel@vger.kernel.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] affs: use memcpy_to_zero and remove replace
 kmap_atomic()
Message-ID: <YtnOKvyjvYwFcFQ1@iweiny-desk3>
References: <20220712222744.24783-1-dsterba@suse.com>
 <20220721185024.5789-1-dsterba@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220721185024.5789-1-dsterba@suse.com>
X-ClientProxiedBy: BYAPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:a03:100::48) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc56bd87-22d1-4a8e-f28f-08da6b656f8f
X-MS-TrafficTypeDiagnostic: BL0PR11MB2963:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUZ7DG+vLMJZBhYLxPYBxcRVco02DdECGd38SvSuXAVFXrpmPvQ9AcmDaalLwsCQAVIGYT4ywc5QbCJ0xMZisXu6AFbBwiTVGaUO5nIQQRFayFc0tx+wFTNJNNSOQT/tXgdbPMdULBBwmu1adR8l2vBwkQurv4QVgdAiFtIReR52Gn+Q03AnnUNesFfsGvsiOM0X25Mbg2qjx+6ySqC5QkOIr3t8YM3ewlHUY8NuOcLXWcTvi0/TzSOUR9aILtgq1azJMhqrDDyuwMeA5oqWXz/dqAQ1tx6snl13fS/zm57nfzg09rI52206xcdLlC8sLW8aIRXDHEINooOd4bLTo5o4Q8uqUV3cZyyTOakpz1/3Od94EIgTvVvONORPbPt1RTrjVdy6lvv05DaFIp6VpsjFO6IzaNYX5XUZse8x9AyKJSqHBr9wC3kcOzLGVm6ZvukjI4z7EGE/xscauBdGEA5t7G0byVWfaKP1mzKRKK9/IfKr5zauxMdghIvLj+29fcV5SHXWs08l6J9p44tUcYUFTWLnqtWKAlYt/2bPYRrlOCGQWEhTJHZD6shtKSnYz/wjZE5X6fr9pm4WuisEYL5KX+Vx7DQUWiFOBRYz+hZJPHbAwypTCpyjh9QVgeuueY8zRXsIrXZrGjie8IDlnRUXOjMLjd5lNwvSeGAAXNQWgQGWeVLzMPjg9eomcXTT8gQY6TywmDOgpLbj/zd2a0ZQOxg6y6gBj+mKJrcGY4kbnQ27xcYCuryQEa8P13ZF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(136003)(376002)(366004)(346002)(6916009)(6666004)(6506007)(6512007)(6486002)(26005)(41300700001)(478600001)(66946007)(316002)(44832011)(66556008)(33716001)(8936002)(8676002)(4326008)(2906002)(5660300002)(38100700002)(82960400001)(186003)(66476007)(86362001)(83380400001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBwcYR+l+VXMs1z2YZAUyJDBsWztIrLB2WUPANlT0VZ08HfReXeENxABY/wq?=
 =?us-ascii?Q?fbbhoGmzw7nuSWO07zf/2Vn89eGy5SQ9C3Lnima/gjHUx3h7lOKCak6KbdY1?=
 =?us-ascii?Q?4d30loAfH1f/uZY3ksul7uY0Osgde8b0tgD4W1nNsdXy05TOBQs3MIwBrGUO?=
 =?us-ascii?Q?wV1bOPPaBaoDqZWWaqoaMxteVSvCkLAcsCPmcaTSnGl3JLjC6T0+W4xBZL0g?=
 =?us-ascii?Q?0jJPatbadhTUbH2WXgfNHueQkEYHpEoqcb8ibaHdwINuLzAwiPFGgBwjJIcW?=
 =?us-ascii?Q?5o9L0SGTSHn5FHZEtMx/GqsTnW45RBOk1EamB8lhV+7zlkpSlPrL/KMJumhb?=
 =?us-ascii?Q?37Nep4Xbn6MnwlHBSYXZR++bJsqslcKx9jihf8k+oxC1T1oo5Bwju0PFZM6E?=
 =?us-ascii?Q?Q1nVt/0gispp29zJdXFCzoWSAAeOIxHXBkoo+TGE2fV9D4gChNi3dq/eJidw?=
 =?us-ascii?Q?KiclsdxCAbd3OrsR1UHbkQtANVxgQsWJor5eHZgYgYMg4tLUP9GNFK6Sq3kv?=
 =?us-ascii?Q?FPyzja+NsI4nFKgjOMjoPZGQmHyspfP/vn7CRTUMVuzzNV29Tz1J4EePuope?=
 =?us-ascii?Q?IsYENgNS46/MdhbbWB6sTeZT/+BdkaAkcDZSJChzZ01iLfaHBKLIh6Cmhkqd?=
 =?us-ascii?Q?XXFrYXNAi+pYCmkykpZDpKH8dbo2oe75BWgT5sXpZt221opVl67SNR0C62sx?=
 =?us-ascii?Q?XyKWB1RCkOf1VG05s8l8GO6ToIGzpEx6piZ04P+yc25fdGjoaKKmne8gUtX6?=
 =?us-ascii?Q?LusRJ7rvnNgw+n1WMmCGWE2hJ45rKGxCorBHs2Vz8raSniW4eFjbx+Tn8gFw?=
 =?us-ascii?Q?ipQOM2gL3FazNtdcnyFGsXHp5ztq4GmnrBx3D/oiPhP5jVDdF0vggyqR2kZx?=
 =?us-ascii?Q?kx44IJPzfA19z7qUPFS41Gmgt2qCk355R1qw48eA0ob17OLxYdJr2eRvypzZ?=
 =?us-ascii?Q?NMC4CY3CFk9ExEpZSmFbdC6lTThA6OxwwrhBteFbTVvTmHoy1OD5GaW1Eyxr?=
 =?us-ascii?Q?ewBCAhquHrislyY3bm+SdFxsOeGQVWSe5uE2x5XxjyQ1mco83tQA4WTDQLwn?=
 =?us-ascii?Q?CPxIZuzS3hGrO524aTYqOPjLzRo3mgy4ArjatnIVlGuPFSXbmJlHtXu3xALq?=
 =?us-ascii?Q?V5uh8IOiYH17HBEhWgJx3M/ubca3BBRZeLqB0qSvuPNvR3wMaUfP6531VfaV?=
 =?us-ascii?Q?+/6gMiGF4WYHsGYe7k+plu5xDoXr5Of5tSsso1x16FNCoNv9g0rTOOXa2Rjc?=
 =?us-ascii?Q?Nex/ZyEhOWdAatIjxKt0l1pbcvp//txMKlzUJNAwa8vplb3dEr2ZTL4pYRKP?=
 =?us-ascii?Q?9VeSIX8hujzziPWHbSeN2fieBD7wEjyW/Z77ENBfndJDNCNnCDttgK8GQz+L?=
 =?us-ascii?Q?2F/DdBJos2JviJ7X5qRNLorshoxfL0inuM/BQoRQ01A0EyasJsesiIYzf39W?=
 =?us-ascii?Q?zDDapj2iPlc8M2d2uEi3jXBQswDBbq52XSFKRCtl2TDFg/8s68eJiMXUBpsQ?=
 =?us-ascii?Q?EV2duf+pVIMsKhsxaDLSQaOYAEMYl9OVGwTiBkRW+hjsmQciX38AFONo0rzW?=
 =?us-ascii?Q?V/MzU+dJ8UTcID/SzYBn45zT7BU+vxB/flhWzC1Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc56bd87-22d1-4a8e-f28f-08da6b656f8f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:07:43.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysZTouBnnJBf/3eqstNIJxxFQFruWT3DIBV6K6vv0lk/sMtUBSk4r9iMINxm6X1x0ZjK/jGMB4XOKvF+SQ/XXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:50:24PM +0200, David Sterba wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. For kmap around a memcpy there's a convenience
> helper memcpy_to_page, use it.
> 
> CC: Ira Weiny <ira.weiny@intel.com>

Typo in the subject: s/memcpy_to_page/memcpy_to_zero

Other than that.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> CC: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/affs/file.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index cd00a4c68a12..45a21729f358 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -526,7 +526,6 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
>  	struct inode *inode = page->mapping->host;
>  	struct super_block *sb = inode->i_sb;
>  	struct buffer_head *bh;
> -	char *data;
>  	unsigned pos = 0;
>  	u32 bidx, boff, bsize;
>  	u32 tmp;
> @@ -545,9 +544,7 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
>  			return PTR_ERR(bh);
>  		tmp = min(bsize - boff, to - pos);
>  		BUG_ON(pos + tmp > to || tmp > bsize);
> -		data = kmap_atomic(page);
> -		memcpy(data + pos, AFFS_DATA(bh) + boff, tmp);
> -		kunmap_atomic(data);
> +		memcpy_to_page(page, pos, AFFS_DATA(bh) + boff, tmp);
>  		affs_brelse(bh);
>  		bidx++;
>  		pos += tmp;
> -- 
> 2.36.1
> 
