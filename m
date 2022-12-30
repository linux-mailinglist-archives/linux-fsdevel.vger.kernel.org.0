Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787BB6593E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiL3Aln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 19:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3All (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:41:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3210414080;
        Thu, 29 Dec 2022 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672360900; x=1703896900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m6LdUjoBzM+2yHEGOg2vB3Hs3RUsRp3WFcayd7IMl6Y=;
  b=l6BCnKJ0LYCQV2KQs5+5sVwgcFguw6kHgsyZPW4ZIf3+UbFqwKfX2/UC
   SYTpdc0Hxr5uzxBhoSXCxNW22Xb+wTwwo2LKWS5DiGOj7srTBoWlJRbYy
   nI5VO5JGv2XbHKFUXj8BUBlUULFXnfm4NxvZgJR/n6bNKl5lrD8MRGtWc
   C6mCPvseE4wgDVRxkNSPzKYWUJMfQEuW9Yk/KCZoGFq21f3Gw9Bf0Tr40
   lpC3encBRnjQXIUX1SUewMYxBwLE7T2i9RBC25Y1O4HNnERb98W8Hm6QD
   rGgZ4HehEE+CFbW39vT/KL0+XK4S5EkzYaHoXR0qvecovc9pGIGy2KJho
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="319851613"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="319851613"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 16:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686123825"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="686123825"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 16:41:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 16:41:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 16:41:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 16:41:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEDcJIkZWSMV2d9nGNSpFz/kQbQtRiM9HkgVw317K44ZBrlZnoEZc9H/wS89xF+QGrcOxZzJplMTzkpqht6/19QchPXqtCkMLrdVZttt69p8rljlnMe/eeHM3VgAPpm7rp1UviJwR1jJL+jCRx+KMyYc6+U/zqCEQaU7drWszLx6FZZhzl/B2YVpq14fEPlJCL3R4XQsRYC2mwYmRlEGc4w+X3pfn47ttFDgfx0nxyf7yYsU+nYddMarUK9ys0W4aryJa8mzoa1DFQiIoyCICikIC7+I1UTuYpWqlkf8R5UnIkTqrgG0LbGTUzrkgmP2RwEgtTMC9DuY1pGVKgufXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6EtoiRCduYDvbELbMCKAP/el5AiTzEFvZ0O+xnPuDQ=;
 b=AjI9jChxv5mVyslKNl371bsiTuzLtmnQmmUVZ+vmdS1w7K2fXFeLA4l85yYlcqFJQS47DCvg/kMW6Opmnv6J9sGuQ8pSS+0GHXVYISwKrr/JdE7TSYwnOVjXX0Yef++FrgIy27QteHFHPKCPJyMIxhMlBeXNg3o2s2GaFB8W9I5+P0SV6jiA+a0Si+or8yWXp7RPE1EL1vQQj89QxzFDtqS3ZKLDQqwM8RX8HWXQ35U7wauWmxjw8QaeXgbxUv0+j+lPzgo8IZ17Fx9dodG/GO8P610nHNhi2uIpT/Au4NkdS4Esj2fJZxDvzxq7ffEX9Ird4bMOhRSE+zSAQgCHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 00:41:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 00:41:36 +0000
Date:   Thu, 29 Dec 2022 16:41:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] fs/ufs: Use the offset_in_page() helper
Message-ID: <Y64zu4ZIZ6E8iz9C@iweiny-desk3>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
 <20221229225100.22141-2-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221229225100.22141-2-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c78d95-dacc-4552-94f2-08dae9fe9b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYWqexzhef9McOQ/G4oURFhynxAuCWzD1qPESuNFFZhsPR149OJ67ZlAtHCvQHoOZ5IoaGOF1ICrOH+Hy15ZPzZxAEq8SbTOc14KVHhodUvZkHSeke7Tya6Nze0TJO+cDoYsIAslF52BiVwqxyme3OPUdF/hC/Z7/kzBLmky6/qYe4nJcKcqQWk85DH0lkp2KfRAAjntD4e5gxDORhLMRDa+Ye1GfFa8y4sontSN9e4RvktDIpsuNk3lfNlFHWBMFpM7rN15IDcpbjljABLjOVP34jEJD9/q/fkCI1IISJDlywI61yK2xXA3AdQrTcftJsyGFNZ77BkNrXc4JNTx9zr/fsMME7EfNOQbNIN4ZYhfDfvm6XrL4qF+6GGpy6gYAu4joPR3dB1KRB7QKiOrCFl0AhyM5s0IwGat/9gOW/iVqf3RE3MUdFNKtgqET3ZQklu+1WkI+RieZ+C745W6OEYspStZ3RI3ktOTAGUNF8Kp3ALmIODYylbHSa7Z4Qe5hoilGfgavB0RbnNmytMm7CKZy6y0UO+aUtvqbObIYzkAsXvNRQHhkHw10NnFfkCt+p7vwYoCcR2YBji0Tcv3vIxO8nBnHjE+u/q3MkWOx0hcgDM9VAJ0/CW6QpSk+CrkSMB+wsigC8xfHJCRryEmEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(38100700002)(2906002)(4326008)(8676002)(66556008)(66476007)(86362001)(66946007)(41300700001)(44832011)(8936002)(5660300002)(6666004)(83380400001)(6486002)(478600001)(26005)(9686003)(6512007)(186003)(316002)(6506007)(82960400001)(6916009)(54906003)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWd1S8rnz4cwCWsMhTCaRNBD41fCcSZKmNZ/pF4rO/TDDHsjz/16lppFUO0M?=
 =?us-ascii?Q?KP6u5FBp8ucNRuT4v5VZE4wLIh2LtD7aNS5uU6u9n1gCJ4C0j900Tpd0Qblo?=
 =?us-ascii?Q?Hg+EJk92qyGIluO3XMxKJo0o1v/iNNCUjWU09CKOao+8nES/74Z1LXaPEuz5?=
 =?us-ascii?Q?JOTsqE/kz7yzKvy40utqkQ0GxZvRPfS2vqM+ZlICNbsaYY615zX/AIq6Eg8G?=
 =?us-ascii?Q?v1NFM+94sy9HCUvg+RDYs86EeQJSAf1qgaUU04fMBBY+t6XgI5kO/lV2tivL?=
 =?us-ascii?Q?GSru4gs5G5Pft2iLZ+7jYwdhS1iR91NqT2IvoVstoT6FBaT3UMCuyfLdBlU9?=
 =?us-ascii?Q?AWJz7wZUk1oZSMS0/KWXAfQoMfKtJ0qlmAoppctvx4v9uKLi2+2Gcpsr2x/0?=
 =?us-ascii?Q?KTQ3okpp+gVhmarJVWYqtx65BLoNs54g8RcWV+ngTd6WyQE7YIGXhSasXvhL?=
 =?us-ascii?Q?E5omyDW/C64n0BgPjE9fHc1YU6+I4yXfuVephhJQh9lnbyFvKjV6Um12MKpA?=
 =?us-ascii?Q?RnldZX79++19LZa/yDqu1OVwK7fF02cNDsDdiHBUSYEplQpxkAHG+jxd3ePy?=
 =?us-ascii?Q?X/6rfcV7l04sdZdOXP5RjqurajsMNItYmnfduOfykM8vZgLMjPyjQS5RT7nB?=
 =?us-ascii?Q?aMTxp2uVmCgjVfXS7IIhte7bOe49mdVBxcaenTEjHT0M+kFkyqM3bKwSJWX+?=
 =?us-ascii?Q?0TfIDUX4fw7ShfTWHl1xUbPGN7q4n9pUuwThw57DLpm2BoH37d9Lz7qLd3nf?=
 =?us-ascii?Q?V07FFG/hP0Wl8nSWTV/VsBTBW/Oa7c1UiSEMWL47y970oY9j5Ij/+/B6Lxu0?=
 =?us-ascii?Q?BD1IGNaWQmsPfCgw3r3tfQYvzy44GY5OrqSI79U8bBNF4tl69qEYc/Egrb5g?=
 =?us-ascii?Q?lE8mzEfXBDeGyROf6m/AvAI8IxO9hYJCUMCnYS7fXztcuyFnCCoQUkMOPm10?=
 =?us-ascii?Q?NmtONE0LSR9VYbK9ALZ3oGub2fcEHhUwJB3dqpmwO6LG76chLYax69Z/aSCU?=
 =?us-ascii?Q?smf6L9ir42HxTenQ188knY6cYBKL5/wyH8HGu/MM2rUv4HFBVrNQ64OcltGQ?=
 =?us-ascii?Q?ngjTy+GCGfaZcg9dthl2wGh5hZbnvgm/LH7IK3x/CpbG5xUvOt8ds4qLrL4m?=
 =?us-ascii?Q?N0zHO5W5JTpvMp5qmAn1df/NaQFeZPlW1ztlaON/gvK1G2INYVZx2n5pLkS9?=
 =?us-ascii?Q?6Jt5zxMPE+J/8vgndxqdzmkidO4OjOlTMwrwXxO22ZAf5qoM8dSyIX4S0U22?=
 =?us-ascii?Q?vR/XjJ085aF/rQbdmEJcbNwTjXNSQw04Frx2Xwf2/rWiHrZ6b7wPqx2sZQac?=
 =?us-ascii?Q?/StCKgaZusADkgArS6VgQMORymAZuZJujdDiaQyPNTY1fMmmwYrSYjsuu5o4?=
 =?us-ascii?Q?NH41K3qvtEQ09BIECvDu4OSxsgjxFMOAkZl9yJGeX4pOjrp0AKfSSexckWED?=
 =?us-ascii?Q?mIMVDb2/nyKqFnogJxk8GbcuZXyZUiUfj2VDxQsqDTwThhaVDAAAI0Hd5H+Q?=
 =?us-ascii?Q?fQ9wVKNlBhfjDSqjsDoqT+gtwH7amC5hUVRpoiZgQaxfQJHTaJ4/EF3il6EW?=
 =?us-ascii?Q?pmriVVxCaAwQUwt4Kjk4RjsWnhi7diMQWtoVeXGK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c78d95-dacc-4552-94f2-08dae9fe9b0f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 00:41:36.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XohnIlOj4nvbpJxziS39awEzqnjgPsIY2/L/ITqsdcLUrAJBvMJzb+uTeHmnB81twKWtozm0d5LdaHp4JMTpQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:50:57PM +0100, Fabio M. De Francesco wrote:
> Use the offset_in_page() helper because it is more suitable than doing
> explicit subtractions between pointers to directory entries and kernel
> virtual addresses of mapped pages.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ufs/dir.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 391efaf1d528..69f78583c9c1 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -87,8 +87,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
>  		  struct page *page, struct inode *inode,
>  		  bool update_times)
>  {
> -	loff_t pos = page_offset(page) +
> -			(char *) de - (char *) page_address(page);
> +	loff_t pos = page_offset(page) + offset_in_page(de);
>  	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
>  	int err;
>  
> @@ -371,8 +370,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	return -EINVAL;
>  
>  got_it:
> -	pos = page_offset(page) +
> -			(char*)de - (char*)page_address(page);
> +	pos = page_offset(page) + offset_in_page(de);
>  	err = ufs_prepare_chunk(page, pos, rec_len);
>  	if (err)
>  		goto out_unlock;
> @@ -497,8 +495,8 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  {
>  	struct super_block *sb = inode->i_sb;
>  	char *kaddr = page_address(page);
> -	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
> -	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
> +	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
> +	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
>  	loff_t pos;
>  	struct ufs_dir_entry *pde = NULL;
>  	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
> @@ -522,7 +520,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  		de = ufs_next_entry(sb, de);
>  	}
>  	if (pde)
> -		from = (char*)pde - (char*)page_address(page);
> +		from = offset_in_page(pde);
>  
>  	pos = page_offset(page) + from;
>  	lock_page(page);
> -- 
> 2.39.0
> 
