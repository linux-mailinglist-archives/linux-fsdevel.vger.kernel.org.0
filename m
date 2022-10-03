Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66C95F27E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 05:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJCDwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 23:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJCDwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 23:52:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D01926AEA;
        Sun,  2 Oct 2022 20:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664769126; x=1696305126;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PDUddHyjMw1GbFE8aSkol1yuPKT5u/rJjqR6reOJtVM=;
  b=KNjFASoSgH2/Bci4vJj2Ju7nmlstcTIYbDR9UYElwcNh9IzevgJtCJ4K
   jJ4Nidi1R0FpDnJpgaHBKby6yErNxndqW03xLQGS4gCVdzWDP+N2HDUN6
   JBMz1vi6Ul4nNVZnYh/s3FWN00YsozQv62nLMqhXgdHM5CY3ursNQ/hvd
   cM+1kgDFHGtM9nkTMRUyD+Poce3wtVC8na8vcLhYETItXpsL0H3yYjG24
   qZ6Mo1d4xHYs/LQDIZZXCx4jm0vG3nmJxxm6pkv1TWkQtRBOnMNWXTIXC
   ok+5+Q8WMMj9DzfQgt+GHjbFl1m58Bz0b+MTlF00KH9qsyk/7ElKpjL/Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="282910664"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="282910664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 20:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="574488471"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="574488471"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2022 20:52:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 2 Oct 2022 20:52:04 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 2 Oct 2022 20:52:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 2 Oct 2022 20:52:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 2 Oct 2022 20:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b943gpaZrcS4pRs4BNCq2Haf9eFYAmRvuH3PmXFIFAXf4ZR4Nv7vjJVvK0DA/a6xIjCDgcwXrhqg9RGQSFrqoVRQCS7W0TFDdeOdG+HB8z+CnWZQ3aPwTcmA39jtdXoF9G4lw0+ABK05LD7If7MlyGC+EZ/v/h1At+9135vm2K110ISacD/Tc13iKtur0vrpVKLKfbXa2f2GFlcAAPbllHTQ9LrHDguhU++FKw3Ngcng3TphO9/pK+t46RYFeTRLu3SUoHL12BdEKDhHSh0pHoavZFP/VOuGGBsZIc81jJEuIJGh68N5LAmH84zdt+Zp2qzh6PLPu5R4kaFYEbNTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiyrN1/O/OZ3tKikwCY/0v8+GpF8VtQdoPIXWmZqkiM=;
 b=MWlMROi9oHauVWIO/fJ7M86nIMFeRsJkOkbevyaprReA6Wyr3vHk930RgfhC44VxSbptuHZYKGQLDIfrARND7BuBwRWgDQ5cy+gN1l2OUGf5e6iTLlYS494zxiec13RfHycIxZ4vTSWMBDQe/cTMubic0hA5DVMf3V+oyMLq6hseHVSMcqWVqlnh+HhEBkLbMEDVSJYv6O3e+Irl8Xs8AJJxlqhEOPCZ8hPDCg0mEHG/6M54o9uMySCz8dmwZmpW8o74BBbMf/hkhFy4ZQtKI/fPpHfQQA1AxZDWYQgCVVjJ85t3hUH4B0PgNszorc05l3Gzd7IsllA9F+SKeCoYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 03:52:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.035; Mon, 3 Oct 2022
 03:52:01 +0000
Date:   Sun, 2 Oct 2022 20:51:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <YzpcXU2WO8e22Cmi@iweiny-desk3>
References: <YzN+ZYLjK6HI1P1C@ZenIV>
 <YzSSl1ItVlARDvG3@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YzSSl1ItVlARDvG3@ZenIV>
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 47df2a36-f0d1-4c05-56e6-08daa4f2a07c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIMq02yWR6nS0vkVx2ndUpQ9r+pEVhWEv60tiRjPXMn7IPbjKSpEeitXk4M/xYhqTrLQ7LJNueRMZIBPSN4em1RmWc5EwzLU+WJQm4JTC4iJS/QegzT2ts5ZY66QC6Wle53fb0lR7L/ut2OO4UZg2Ur0Mw5VNR9GSwUBO7Xlm1bJXakopyuPphTOq8KPQR8t/vJGoLjfFSQNd/+sAYlkYq9dZ+ORy+gemf6AVBd9O9c6mKguwb5FTeFFLv55nDLzROWGfgk6rabWjiQrcwwdSQWQ0NYswsYC+9X9xWLD7qZU/U1KUOvN2IaNYWEX3iCHj/8g77hPyfb54UBXhUy1RDW587acHH+GnDas2qJ4HWJDSGcr6sPowa264aEaJD8W0Jyp+5xQcaCA4ezUdlDLtKvHhkG5R2Ha/NTG7SGqOyeIpWBeSWOv5gpQmqvhA8tmnPs/l62MB9iL4AibWVxAJA8q8urAZE7GnCni0meDK63TKMZmvaA9ofZ+R8iTFID8GN3AJMMdkuy4aaohHH5oLjc2opqswvo4igJf3WhoiMIfxG9DM3lrxzYVvmSVBjalxgzdWScvjTB76DRBjmDNRiAF4fUdzRoPBpH3ajOzMTODVSAxytxssFhmoRhlOBYVlH3PeEVOT989pzv8pge366ABDr/spQbyko46eqnke2Bjgdb2mRT14FdT1tV0YfsuTOIci6u8O3MTXt6AtYTKdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(6506007)(2906002)(33716001)(86362001)(44832011)(38100700002)(82960400001)(9686003)(26005)(6512007)(6666004)(6486002)(6916009)(316002)(478600001)(4326008)(41300700001)(66946007)(66556008)(66476007)(8936002)(5660300002)(8676002)(186003)(83380400001)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jqwyaQUuXMjZVF91cuBV8kKlUcxMPrdbgoI2CHVq4Prmae20l2L7Bj943bP?=
 =?us-ascii?Q?mpaehlZgxRL4SfToUPGloIKoSCRQgzreOFlh5JWZR6LHHPaOvJay/qEcIkjz?=
 =?us-ascii?Q?BdSy/j2fgfYVfLfo7M1pMBFJmKkyTwI2udPKBov3OQsptNrrYJK9MwaKyImN?=
 =?us-ascii?Q?diLyzq7gwPFtlNBFm5gvjcqo3ZSgpPWBRYSCUMIy3hRCtZ6BgUo236Li5Wem?=
 =?us-ascii?Q?R8Zics9h4FXj6g0PklIy8NBQXUAutPrP6tKE7Ho+E4y7XRYmPT/UgzWoBhcM?=
 =?us-ascii?Q?GogAFSPNvAsZuugvHg5YgXrehGof0PVwOvNjCjnPQnLDC8elA9p1GVvpCBos?=
 =?us-ascii?Q?IpzUvDDP3SI/QRRt+MHc72QiFNGggc9VQckKdx3C5XckyIhxGT/N5+jP69YZ?=
 =?us-ascii?Q?D6Ux55ASZvojf95eiU/RmU2GDBxcI1NoHfmCsHjQhS+rsJxUkPUHbgxeeq+z?=
 =?us-ascii?Q?/y9V7Gm5/FA3d7bSmt8QZUdsCrYPxlnzKV2eZ4wfIszEJzKFmNh8UfNseFbZ?=
 =?us-ascii?Q?U4U/dvCokEqkyQbxcV1wt7B3F5MrjWBX/PTj8oOGynn6Tgit30Gdrd1db/9a?=
 =?us-ascii?Q?Z2dxosTwv93Bwq/eztO5/N3GRsuLJr6rsVj9XnNeNicpFVIHbULmkcuVUZkk?=
 =?us-ascii?Q?a5hJw10iWlHNW13EReIY9KQJj7SRSnOJLEnLUEr6v3IUJrv4N8NDqXKL4fAE?=
 =?us-ascii?Q?YePDwmDUAoSx2hO/BKSyWrg7qqw93ce/mIZJMQFT5ZDZZEzY4ZIViSPpXOh+?=
 =?us-ascii?Q?HZHZcpQznF/mQGm8WrTXQ9X3LcCuvOhFovCu6n97nAvRYVJB0hUGhNu9J8EQ?=
 =?us-ascii?Q?Wl0PPDqaoJMPbElUMcdUGVyy4/f7dsXGYYQ19Sfed7qsBQoiZU2QMl0a0DPw?=
 =?us-ascii?Q?VaRKH4giPpP2E8OcV2qKDXLaeAnQTLEjoJtxoAfaz5YdJb59fQmom4WCwl89?=
 =?us-ascii?Q?LcrzxOcFWq3y17bG4+M37T1a/yTduiSHTscGdrq71x5+uq2TAKugRluzOdEC?=
 =?us-ascii?Q?cBkfY18bf0cOFdUkIRm077zxmoJqjuU9xfEQXWJN6x8RWoUsG1Ahom66zpUy?=
 =?us-ascii?Q?4XGiFF0YCUYfDZ327a/vdMWkwiOU1ISDZMkkguaNMsC2PI+iW2IFeR4bJbtl?=
 =?us-ascii?Q?5YxCaJAfd/MYSZL/iYeGmyKkFga0Dl1/qZCMUWwOPKMzzYsQ9Ikl4ytQvzPm?=
 =?us-ascii?Q?bA8q+CcKrS5YF6jlOue+YsIQbEp7V2L/D2MytGht6+U+knNQIO9E8pX5rY4C?=
 =?us-ascii?Q?W8XEJaK79np5iEXIiiOIaYPBjbsPDuLMl4WEMMoeYLE3in/rB6VX3ffWvvht?=
 =?us-ascii?Q?uopDleUXHFs+PYT4Ua+4nOP/24za3xgqF2O/nfzkch05uwjjLg60Gylh1swj?=
 =?us-ascii?Q?8z7OYHTqQQVkija6YHNEi4OTiAr1Uils7AgTDYOC8L5pzZg2DqBKB8Atzd82?=
 =?us-ascii?Q?IlNQk3N7uzPozsUh2OzoQmASlQk6+jGlDO+6E0uJyduo0q2CB93O+T07lJOB?=
 =?us-ascii?Q?qw5ue9SKkhN7SoUnGdt+ieHqg/WFYfDScCLMOsA1T247iwteu1YVYQbdnMiH?=
 =?us-ascii?Q?zD4FBQE3aeErxRzwEQclz29qi7lksUtcfSIlChyf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47df2a36-f0d1-4c05-56e6-08daa4f2a07c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 03:52:01.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqDi2ZA623didnS/uc0JOLtH74EboSBKN75UxoeS+XSPDsMrA/URRRA+qDtqymOYe4VbB+OyNq7Tlt6qbAtubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 07:29:43PM +0100, Al Viro wrote:
> On Tue, Sep 27, 2022 at 11:51:17PM +0100, Al Viro wrote:
> > [I'm going to send a pull request tomorrow if nobody yells;
> > please review and test - it seems to work fine here, but extra
> > eyes and extra testing would be very welcome]
> 
> ... and now with page leak fixed:
> 
> commit 06bbaa6dc53cb72040db952053432541acb9adc7
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Mon Sep 26 11:59:14 2022 -0400
> 
>     [coredump] don't use __kernel_write() on kmap_local_page()
>     
>     passing kmap_local_page() result to __kernel_write() is unsafe -
>     random ->write_iter() might (and 9p one does) get unhappy when
>     passed ITER_KVEC with pointer that came from kmap_local_page().
>     
>     Fix by providing a variant of __kernel_write() that takes an iov_iter
>     from caller (__kernel_write() becomes a trivial wrapper) and adding
>     dump_emit_page() that parallels dump_emit(), except that instead of
>     __kernel_write() it uses __kernel_write_iter() with ITER_BVEC source.
>     
>     Fixes: 3159ed57792b "fs/coredump: use kmap_local_page()"
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>

> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9f4aae202109..1ab4f5b76a1e 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -832,6 +832,38 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>  	}
>  }
>  
> +static int dump_emit_page(struct coredump_params *cprm, struct page *page)
> +{
> +	struct bio_vec bvec = {
> +		.bv_page	= page,
> +		.bv_offset	= 0,
> +		.bv_len		= PAGE_SIZE,
> +	};
> +	struct iov_iter iter;
> +	struct file *file = cprm->file;
> +	loff_t pos = file->f_pos;
> +	ssize_t n;
> +
> +	if (cprm->to_skip) {
> +		if (!__dump_skip(cprm, cprm->to_skip))
> +			return 0;
> +		cprm->to_skip = 0;
> +	}
> +	if (cprm->written + PAGE_SIZE > cprm->limit)
> +		return 0;
> +	if (dump_interrupted())
> +		return 0;
> +	iov_iter_bvec(&iter, WRITE, &bvec, 1, PAGE_SIZE);
> +	n = __kernel_write_iter(cprm->file, &iter, &pos);
> +	if (n != PAGE_SIZE)
> +		return 0;
> +	file->f_pos = pos;
> +	cprm->written += PAGE_SIZE;
> +	cprm->pos += PAGE_SIZE;
> +
> +	return 1;
> +}
> +
>  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>  {
>  	if (cprm->to_skip) {
> @@ -863,7 +895,6 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  
>  	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
>  		struct page *page;
> -		int stop;
>  
>  		/*
>  		 * To avoid having to allocate page tables for virtual address
> @@ -874,10 +905,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  		 */
>  		page = get_dump_page(addr);
>  		if (page) {
> -			void *kaddr = kmap_local_page(page);
> -
> -			stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
> -			kunmap_local(kaddr);
> +			int stop = !dump_emit_page(cprm, page);
>  			put_page(page);
>  			if (stop)
>  				return 0;
> diff --git a/fs/internal.h b/fs/internal.h
> index 87e96b9024ce..3e206d3e317c 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -16,6 +16,7 @@ struct shrink_control;
>  struct fs_context;
>  struct user_namespace;
>  struct pipe_inode_info;
> +struct iov_iter;
>  
>  /*
>   * block/bdev.c
> @@ -221,3 +222,5 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
>  int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
>  int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  		struct xattr_ctx *ctx);
> +
> +ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 1a261dcf1778..328ce8cf9a85 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -496,14 +496,9 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
>  }
>  
>  /* caller is responsible for file_start_write/file_end_write */
> -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos)
>  {
> -	struct kvec iov = {
> -		.iov_base	= (void *)buf,
> -		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
> -	};
>  	struct kiocb kiocb;
> -	struct iov_iter iter;
>  	ssize_t ret;
>  
>  	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
> @@ -519,8 +514,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
>  
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = pos ? *pos : 0;
> -	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
> -	ret = file->f_op->write_iter(&kiocb, &iter);
> +	ret = file->f_op->write_iter(&kiocb, from);
>  	if (ret > 0) {
>  		if (pos)
>  			*pos = kiocb.ki_pos;
> @@ -530,6 +524,18 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
>  	inc_syscw(current);
>  	return ret;
>  }
> +
> +/* caller is responsible for file_start_write/file_end_write */
> +ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +{
> +	struct kvec iov = {
> +		.iov_base	= (void *)buf,
> +		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
> +	};
> +	struct iov_iter iter;
> +	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
> +	return __kernel_write_iter(file, &iter, pos);
> +}
>  /*
>   * This "EXPORT_SYMBOL_GPL()" is more of a "EXPORT_SYMBOL_DONTUSE()",
>   * but autofs is one of the few internal kernel users that actually
> 
