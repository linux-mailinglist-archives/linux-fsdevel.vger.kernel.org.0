Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88553728E6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbjFIDRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIDRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:17:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D930F2;
        Thu,  8 Jun 2023 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686280618; x=1717816618;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=KZvBFFzIvFGtAC3VrUoIotvpVMxZiT65tuudn4rLGaA=;
  b=jtUEHktS9y4eBRtK9gpsOf2SqmRx1Z81gOAnQdCHZ3BuOThjngG+fzY/
   fy4DaHNRrGqYJSBwVbZoC2K/YTttAHDIF7U2+YNjqIDl4huhM8vmnoR6U
   lU73MvuwHFGmDVPOXm5wsb19Cf9c4sqdD/9mRUVhYP/bJL7COYApV3C4Q
   vUAhNaAoP/4wQsqVbZY8XnMzVl2Il8TcioZdN9nUk3fHlCzja1036xue7
   kQjjEYYCWs7GL15UjQj+TQRu8nOah5dq9Og+u+9jAH3sgZ1c+3aczELcj
   e/oXuJ6W1nSASWZ00ggv1uvz+CVc6WwWSZ2sYuhplWhzGb4cZ2UBXkY8+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347147789"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="347147789"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 20:16:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="775333052"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="775333052"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2023 20:16:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 20:16:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 20:16:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 20:16:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftLY/cngAllavzS7JYLHz5NyrCZiU8QI0R2zUzDwLTMcJhdeGA0/TtAvSW8Noiz3uG324gAQ7Vy3KxQLzW/OnGuin1V12PJPXhLRzem5PHR/3JND6Ozaf78FP1dddMOzDwLdPP1O6Hgx5lIolM7dHJFlY1P86TKMJ+3Ms8CgRbdH9+5jFD/6AxPx7eAog0vtzy2HTryg4P1Pdxy+cn0JtDYlYxHBPe3XAPDIIJPd1K+n8UR6B0DcINMz1XSYxOFqN8In8ic7tfNPw2fUFM2W3rkXZhYNeByP5IgJECPDkA7z4TUZBiRVQTQ+AIyEVb1OyAA4pgCdcM6IYaOGl1cWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfjFVJVNOEMqcd532H3zVtsP6PQvlvTGTMNEbF0fcIA=;
 b=V6jUrj2IpdeHGreOOeSA8NIekimmGHziV5bTU4UWbSlmlQDTdhc9PLJdDFB0TdEASJDgmy1z1hcutCr6lxgb+z4nhbOUpnn1GeRMYaAA5P8/j9oGpkRmSGIP4FdqOh/LaXOy18XuIwmkT09NOBcA63d0HbjSdJWHE/zPM3MemVBrp3YJImlQiHSusMt6CZaTL8FvQKo3PEDzhnODqGgTdf0NpHuPO3jXCBS/YXkX+++lrCxCHZ+w8JhNViEvj3i6J9RFopWKa+1RMY7R6yyelAN3bwNmG1JJua9SVceGaxJXVCHHuyMEZ0oaO4LdRnEdZxKYO72VODa7btt01b/TpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5422.namprd11.prod.outlook.com (2603:10b6:5:399::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:16:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:16:47 +0000
Date:   Thu, 8 Jun 2023 20:16:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <willy@infradead.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v4 1/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <6482999b3afd8_142af82946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230509054714.1746956-1-jane.chu@oracle.com>
 <20230509054714.1746956-2-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230509054714.1746956-2-jane.chu@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 21dd84ef-8a80-4cf2-cc94-08db6897f56b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: af3UYQFcPKB5UsK0I6HsmfaXuZmvzZNmbdXOs2ocYmuVjWZSK3oV+FXCNc2bpnOHu61Xe8uxSYBePbDkfBkt3tg7HBelAFLd24YxogpK9LQgha9dngKfFqjz7NTHvSd9WNXDrHLkozWQEmQ8vES6eG8bDXe8eSZeYP/RnmFvpS5+MpZbreU3c6CEoioi//o9jV40SUMZsSVi3Jh04eVeX5ZGwoPSZTGKPjG14HpyBJOn3u1NkX5Jy5VA1kYdqQxyv/EmajSVq8TDiic5tYWkqBrv1ddEsY6ugSeokalfsD8txq1Z3A9ecRKUEd1uJ5Ncum5bAB6KwIInRxms88DVRnykVsgQvlVAvTBVfElffwN62bz8P2KcXHWMgxvpIWph6/mJQs2oTlVRtSOH8436KfEROEQjPMsayWzciebZICejrXF6HEeFWWGN4L5RwTBXNRPHRdfXxvbkIMYOUds4GpW1QMWUMk4Ep+QByDKlxj5jy8HHxEl5Rj8oKt0t58A0v0At+iGWbURrtwMbZDS9A2SQda9NOGy4IVKNg6BAk5SwSWS42gg71/vaO0xB31/EVPzOqw0RoYE427yA9Ao9oYxlw/WOk4GCaz8snUKAFcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(66556008)(6486002)(921005)(2906002)(66476007)(82960400001)(66946007)(38100700002)(86362001)(8676002)(8936002)(478600001)(316002)(5660300002)(41300700001)(6666004)(6506007)(26005)(9686003)(6512007)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vgZKbrF962qGJBJtGLASNBSiEeSohxuBFYCqVikycMdDPOJmGcVp75NXmsJo?=
 =?us-ascii?Q?Hydp/Shqh6zj195wRQjpn8AVtuaBNgSxwcTr335Z/LuZczYxlJZF9BbJIWnF?=
 =?us-ascii?Q?dg48mhSkpHzuqTgmWFvLZRTD2t7wnH74QNCfu4sOJmmRo/W2/1NPc2P/2qJ7?=
 =?us-ascii?Q?63h1l93af5eZ3QZu5qwLPcPESnLK9tNAWrmQ3Hi8xAzF7rArLesR59HeZy3P?=
 =?us-ascii?Q?DfKUq0AhLKiXHDUwWgKcCQ+OjwameeFzJV4LKIyCl6TsEhmVGkjSuHAGNb7Y?=
 =?us-ascii?Q?mGPKUVzeVG8Mk/EI5k5Swi8h5IszrZsomAnc7GS+kNiHcaaHw2mSXA2yTLF9?=
 =?us-ascii?Q?Hwwlim9GixPs9nGGwPqI98atwJ1TTn/zUfL76VVqB3jZOkRt4Ac6/zr7HT00?=
 =?us-ascii?Q?bs/6aMsGbYLfAAxS9xFsDb32nX1HmtfUJCM+iOZYSRWKjWNfrHUbe3GhCdzF?=
 =?us-ascii?Q?wl736PFYpQxp+Iq7kBATPDB3CCb+M0O1Fy1c0FK/o9QKS8IGdKm13s8EEXG4?=
 =?us-ascii?Q?GWox99EJ2jYuuOsC+M5u812EgzUqrBU07I15lG+pbhQVsxyagtT8znT39mSR?=
 =?us-ascii?Q?W3Y9U7f4EgnGeFJXOYDSr0dwHwVuDEN39LQ++YrZJUOpmBU5o0zu8is1zfyy?=
 =?us-ascii?Q?X0hSecHc5Xuvyf+hSFiob5xmve2gIukO1U20EXoyxzKE92b93cnJ9xIrYV+o?=
 =?us-ascii?Q?m7BG2ncO2CZRvFT3WxXIV42M9EuKnR05V6kg4mqky+svrVNxOBKzxh24wC0f?=
 =?us-ascii?Q?4nexCaPy+lF6au3EOwV+oXeU036wzMT2Y/VTaBowe1Lqb8DmqTaU0JPsLiKG?=
 =?us-ascii?Q?7e/c3IKZA8fg02GoJ/uz3zy/8T5soaatt/mLD3gt+ae27mABHoD8Q1oEyinQ?=
 =?us-ascii?Q?x/t3to6ZZDb8n4b3Sn6QXAXUKUJR+jiUawEisSo6CqgIZCbJNGM9EYxfS/Ju?=
 =?us-ascii?Q?qMT1lGHgXB4jTVRG7ANSjw+DWgYPoxBjzvfKwfCWvGb9GNP+uAYbh2ZzrU3E?=
 =?us-ascii?Q?QaQyNqb8tAjiy5ScCF1Ph8CHypHmkIM4Xnn827aRLF4BYTEtfUoGMjalUQYM?=
 =?us-ascii?Q?b9CC/1hDOIo0CP6nOErURJ/ZDA06xLEwScsR5lrQTvsTzetNvRzm3IaqXxTy?=
 =?us-ascii?Q?039kvTVsZqGLYGP7bATgxCUxogTDcnW/dpOExKedeg19qRAB2c+Vonvs5b5d?=
 =?us-ascii?Q?p6NfOuT/Ab0JT5ivOLf06gGrcV4U0dl4HB59duCwrZ353H2r2gVXRwVHChiE?=
 =?us-ascii?Q?ZlBB/d5qUFM8R/G8A37YnZL9Jy7YMhT49f5iHdrDtzZt/+xCf8VcX1Uzecfg?=
 =?us-ascii?Q?yB2ym2M2U5OK/f3Q8jDleJ6MRSBycpaGT19jlOIg1SJQQiz6Hg88plPJ7OQa?=
 =?us-ascii?Q?W4LpxL4sfJJQkDMrXE0Py+iePDLQxlilUHSMWyJIw8pr4JfrSD9m606qFX3w?=
 =?us-ascii?Q?f2N8jHc0/lVnCYCAVRcdZfZ6l4HO5bnAZLiOQ3rJ5iaBAzOR3eLaIELAXIeG?=
 =?us-ascii?Q?z5D+uwdamhuFwSGwmbUM72sa8bCJUXZhZhfYKzfsaTN4HEI3RJwVvuPCpoLs?=
 =?us-ascii?Q?0LPqT0VtoSAeME210VrkT7FRXS8Pz7i+NohwGP5Fw/rqGodWpJIksaHEBOUs?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dd84ef-8a80-4cf2-cc94-08db6897f56b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 03:16:47.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxFp7SZEp2+2LzywpjCqfXUL8rdzcO42FMxwPng37qqi9sFVsgJNk7aWkVtOAUPq1kWZLO1wzOSo0bjGXnVJzxGoewGx3knBEKWdhxKkO2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5422
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jane Chu wrote:
> When multiple processes mmap() a dax file, then at some point,
> a process issues a 'load' and consumes a hwpoison, the process
> receives a SIGBUS with si_code = BUS_MCEERR_AR and with si_lsb
> set for the poison scope. Soon after, any other process issues
> a 'load' to the poisoned page (that is unmapped from the kernel
> side by memory_failure), it receives a SIGBUS with
> si_code = BUS_ADRERR and without valid si_lsb.
> 
> This is confusing to user, and is different from page fault due
> to poison in RAM memory, also some helpful information is lost.
> 
> Channel dax backend driver's poison detection to the filesystem
> such that instead of reporting VM_FAULT_SIGBUS, it could report
> VM_FAULT_HWPOISON.
> 
> If user level block IO syscalls fail due to poison, the errno will
> be converted to EIO to maintain block API consistency.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/dax/super.c          |  5 ++++-
>  drivers/nvdimm/pmem.c        |  2 +-
>  drivers/s390/block/dcssblk.c |  3 ++-
>  fs/dax.c                     | 11 ++++++-----
>  fs/fuse/virtio_fs.c          |  3 ++-
>  include/linux/dax.h          |  5 +++++
>  include/linux/mm.h           |  2 ++
>  7 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c4c4728a36e4..0da9232ea175 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -203,6 +203,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  			size_t nr_pages)
>  {
> +	int ret;
> +
>  	if (!dax_alive(dax_dev))
>  		return -ENXIO;
>  	/*
> @@ -213,7 +215,8 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  	if (nr_pages != 1)
>  		return -EIO;
>  
> -	return dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
> +	ret = dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
> +	return dax_mem2blk_err(ret);
>  }
>  EXPORT_SYMBOL_GPL(dax_zero_page_range);
>  
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index ceea55f621cc..46e094e56159 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>  		long actual_nr;
>  
>  		if (mode != DAX_RECOVERY_WRITE)
> -			return -EIO;
> +			return -EHWPOISON;
>  
>  		/*
>  		 * Set the recovery stride is set to kernel page size because
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index c09f2e053bf8..ee47ac520cd4 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -54,7 +54,8 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
>  	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS,
>  			&kaddr, NULL);
>  	if (rc < 0)
> -		return rc;
> +		return dax_mem2blk_err(rc);
> +
>  	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
>  	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
>  	return 0;
> diff --git a/fs/dax.c b/fs/dax.c
> index 2ababb89918d..a26eb5abfdc0 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1148,7 +1148,7 @@ static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
>  	if (!zero_edge) {
>  		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
>  		if (ret)
> -			return ret;
> +			return dax_mem2blk_err(ret);
>  	}
>  
>  	if (copy_all) {
> @@ -1310,7 +1310,7 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
>  
>  out_unlock:
>  	dax_read_unlock(id);
> -	return ret;
> +	return dax_mem2blk_err(ret);
>  }
>  
>  int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> @@ -1342,7 +1342,8 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
>  	ret = dax_direct_access(iomap->dax_dev, pgoff, 1, DAX_ACCESS, &kaddr,
>  				NULL);
>  	if (ret < 0)
> -		return ret;
> +		return dax_mem2blk_err(ret);
> +
>  	memset(kaddr + offset, 0, size);
>  	if (iomap->flags & IOMAP_F_SHARED)
>  		ret = dax_iomap_copy_around(pos, size, PAGE_SIZE, srcmap,
> @@ -1498,7 +1499,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  
>  		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>  				DAX_ACCESS, &kaddr, NULL);
> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>  			map_len = dax_direct_access(dax_dev, pgoff,
>  					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>  					&kaddr, NULL);
> @@ -1506,7 +1507,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  				recovery = true;
>  		}
>  		if (map_len < 0) {
> -			ret = map_len;
> +			ret = dax_mem2blk_err(map_len);
>  			break;
>  		}
>  
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c727..5f1be1da92ce 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -775,7 +775,8 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
>  	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS, &kaddr,
>  			       NULL);
>  	if (rc < 0)
> -		return rc;
> +		return dax_mem2blk_err(rc);
> +
>  	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
>  	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
>  	return 0;
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index bf6258472e49..a4e97acf60f5 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -261,6 +261,11 @@ static inline bool dax_mapping(struct address_space *mapping)
>  	return mapping->host && IS_DAX(mapping->host);
>  }
>  
> +static inline int dax_mem2blk_err(int err)
> +{
> +	return (err == -EHWPOISON) ? -EIO : err;
> +}

I think it is worth a comment on this function to indicate where this
helper is *not* used. I.e. it's easy to grep for where the error code is
converted for file I/O errors, but the subtlety of when the
dax_direct_acces() return value is not translated for fault handling
deserves a comment when we wonder why this function exists in a few
years time.
