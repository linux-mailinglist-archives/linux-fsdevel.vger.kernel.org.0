Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9F77355F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 02:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjHHAb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 20:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHHAb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:31:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C810F6;
        Mon,  7 Aug 2023 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691454686; x=1722990686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M+jkFTNbMjSdENFKHr3VG9UhmbYDtgsHNjm9NhIACIY=;
  b=lx1yuwqc7B9yZRHWx1M5UOYWI141W8NZe+2QxIYDJE+x3qNbuWKtOkNU
   iPvW265Q8h9ZiEJWf2LYv4v11TKKkKiut5ZfIaygxLPd6FMbLX3cpOZE/
   lt6dmbjhhyY1OSPMyqdlFRSoLaCEYRSBUMjbohfP6X/f3i5hv6PMEx/cD
   Pjh3R7AuSuW6P1PoMk6NWNNr6/sHuJZGagT1kYl0Zq0HjJXxFkiK8LFwJ
   UUtQkSpLplqQ7Fx9jYIFOlVedYJTfBEJ53jBpwOSvc6uxtf+YDUw66ueK
   tBNUT9Cjba1SPIgaUAjUCLu7XGd6CofhdlncTdJbBy641UlTMslRm+t2u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370677837"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="370677837"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 17:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731175815"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="731175815"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2023 17:31:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 17:31:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 17:31:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 17:31:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcshPPopH5R1Vq5xldjbPis3jfEXO953VRjxvtEcGybUuNTDZQdC+JqNER6I9nBmsWLA+kP47qcfL9g9bv9o0Z0KT60Se4OAFPOmUdgs706J3qYGSXMWrhdm/Qomvm9jq9LsOgXK/QCyUDrc7XKcDTWDEacF+H8pC/VNNmkuTNNiHeytmewMzdQ0ZXbqchObLJfaDKNILHhjutj198eGGFroCswZEE2666ZKdSbTdVDXFFu33SaerC3a6N8KAbLA9PZAftWG0LRyBhvA7gxasVUzNCngqZbtLGK8p7mGRwuDj/ym3MNL0PPY6icWL2Xh+9cdjNxqcJ0NF7AeN5W2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O8O4GzUf/4l4ySilCR91omGpuPMsptDayOhlYrTs2M=;
 b=a0GomSTC/pfkMm8ISGk4JuC1FrPQkdR7Nr3Of0d63n/T/TN6Ym18xnecTcVjhgHih22m1tGGeWnh4kIxNDV4Twe2IjDZVqcgvPhfxL4ayAXu3I/Zc3jM6xJ7NdOXUlf5OD3eismhz8Bt1bhpT1DDHhDECpO5A2RN2+g48fWhucwIlFRNZl1ON9z21kuobvsSa2mc8R7pPFIZ0uS+ghF5kjWo0M9H9Sr46WyL2PvjsFpGnomlg9zfrB5wsMY9b/pcyDLDvBmXvHaDGDCiwbWMXqRZ97GPs/TPcwZqHX99ukj2qF9h3nly4/zzr4QGNXTFvS5QkI9qfzNtmgAUFifc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 00:31:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 00:31:21 +0000
Date:   Mon, 7 Aug 2023 17:31:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>,
        <mcgrof@kernel.org>
Subject: RE: [PATCH v12 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <64d18cd6c6e09_5ea6e294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
 <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:303:8d::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3866b84b-f26f-4a77-9b63-08db97a6ca01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAxOiKh7+3IInWKRx+oehQxn/8AILlFv3ZpH+tAQPaaXH7wjpWuUi1qlPITRICOgWQSPbnv2YTVW7GbAoGQoZT2QCLj22gH3czj/A9GtiyHcCxrUeQWzdIc0/4XOGV6QtUTxNfP9cTGh2NvLm/QBHJorxz/GEMpFM1zYysjrGYTOuLw+H7lI3w1bgbC9OC0AVncyUQHRBajfYkJometBM98JLprECsJLUxWVpLxzEBOJwuXmJmWk4CTFztkyLWVfETMdjPFlNvS5xWi3px66ZVj1+msA32b8Zj/Evwf7Y06fQMLafYPvlEHA3VfgDATclKmTepCfUSuZDDOzGiPu7Jptd2Gs0BzntxHxkexEAsgJiVNXYIKuGiSiXbLUckcZX+rV+i2lFeM7eKqeCf1BJ9aaCDsBX2pwzf2IuGmnYe/FFo8Z9dDqpxoJfGLa/MnIN269W+Df12GwZniFo3bumr6AklzS6KqtAdMF318fOZvX10dHfy4PeeMCVDvF35DA5v6+hJB5/xvC1ZKTNEC1ZaGgwujmF94cI1WqcJUME0wbLsBj1v2/eOWhiknIjrNk3NzqllvyOPdnQkyXPIId/xlBxA8gzwCe4bfSf5dD++CSw9dP73uk8VUMINdEjFngeRa3ESPIdandpQWgHByDyTb/DLRzYaWYr0GrR6VDF6VAl69KOE7uxjSG5y85NYBsgybnfX1r+Fq7SeVxBbOX1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(1800799003)(186006)(90011799007)(90021799007)(451199021)(26005)(6506007)(9686003)(6512007)(6486002)(966005)(6666004)(82960400001)(478600001)(38100700002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(2906002)(83380400001)(86362001)(18704003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBKkqCQveuuBdKj45Qbr7WqHIRG4/bB4hLGwGI3g+aOLs7L1kUhm4oBmoYPv?=
 =?us-ascii?Q?OdLxGBu0j5bzMS+ZvHPJKH49ySPe7vEpnG47lks/ObLcmcORlsSNMPxa3Nnf?=
 =?us-ascii?Q?u0vDKTvi5vcJwjElJE8UkUa/ezPAo2XYQDR8MIXq7E3FTDx+BPrBcpGNYhQl?=
 =?us-ascii?Q?UO6AnQKTVIaUhEDpOu+iZUqW8CiejKzLfZ+6Aa/BtkYHM/GY4L8lwBij5m2N?=
 =?us-ascii?Q?lj9QBy6Hast/ywazpiWkUZW6+f4p7yHw9AYsr0VifDRmIHCTZf4LDyZZngBv?=
 =?us-ascii?Q?2LIJuei3Rr6u2LQ0Mxu/IKVI07ME/rg3alQUiTEE/J/klBNKOhWm19zHuYkK?=
 =?us-ascii?Q?IK7tNoN0WrWI9HegOAgLQcD03+ff0wA+p4+oALopBjLaijcAjCRJgn6RNVjj?=
 =?us-ascii?Q?YgSy8PmJM/IjRbN+LXCBP8zwfTCNMQK5Tgxe1NJZX87vzAn1GI7qcVHUMrSZ?=
 =?us-ascii?Q?izzYil0KbnPCflaKoRHuG0c9nvf6mmHgG1Y1/KNoR6ewjeX7U48tVasEICA2?=
 =?us-ascii?Q?UgA4l1eO9/NtC/H9FgpZQw/xh0jawcGUCFqHSmfmCK+AfgRRx/7TmruNXhor?=
 =?us-ascii?Q?d9T7fPgvtJw/BqIErIx1VpuAerKZ/AzRIV54GJobhB/xRs+04iZshlEXekqx?=
 =?us-ascii?Q?+GukuC2lwqEEP5XXnvfo4w/kTFz0IVv+Hr6WXxordegSNx7HEZ0y7/X4/9z5?=
 =?us-ascii?Q?V16v8Nyzqqoop1vB79+jze3bS9JU9G3aEk1suskbQIXGZrKghteaOKM0A9C7?=
 =?us-ascii?Q?4PPs9/XmcFvECwWEKc/L/Y/vNPbHwYeuXk/wpQIEleLm6cE1LZCiw6eE1o9X?=
 =?us-ascii?Q?jXqeTvIU/jYT6941jOTnmc9pCeSDiVvvWlcHzIjjCu8oe1BQssRIcHD+2f5V?=
 =?us-ascii?Q?kg/o/MaDhOUB6qUwNkt/N8bdqp68zOHJgPg88eKQDdcPurJ21GEd9s58rp0E?=
 =?us-ascii?Q?HUPL8NXdcjpp0taTIQkAh5Ksm+P5uz+VTh+gEsd+4LVVTxkyGiku94fMK5+1?=
 =?us-ascii?Q?YNk78ICtOtvyjDIlyq/epmzw74vDMN2LIck4mnKiZ4cFtifL2GeiuoCnoL9Z?=
 =?us-ascii?Q?zfieieqvlBGg6qqZoMeXwmmEmlkjapxc3xv2GEnemNM1n6MzLNuKzb7TWbqz?=
 =?us-ascii?Q?Jy1MK/GWNNC1XOlOM1bUgwaQrU2GZcoFSG9sU/vXKmcRYguaFBFKuU6mkMp6?=
 =?us-ascii?Q?a3oLJeLMbIgvZq5gXcOFeLzQLf7doUg29Fsv8z1b+hUDx3ANmu0+bqHg6o8e?=
 =?us-ascii?Q?mPQv/jk3ve9r+/WlDElsPJh5nZ3axOalA3kiQjpJaMrhevGtaN8LvMAEtrLX?=
 =?us-ascii?Q?V+R9EEI6C2spGBo0QKtANeNWroSavI8G6tQaKKdNbgexcQ9gLFF9Vj6MauoH?=
 =?us-ascii?Q?olK+DgCosDynD4lhlvCbWl1O5O2iOjRJ7hFX04R7IvqpyLi9se6rg8gliqYI?=
 =?us-ascii?Q?SjXzvaKMN41Ib+4WZa7OYB5C7yn5pux09CEVKGR4o4eiHs6z9vaV2WSaNowM?=
 =?us-ascii?Q?GYm7quQtBAUlLFnyIZvQR9NFwKt7scaSnrBRuCNzIRtT3AFH/aeTE4thrhlI?=
 =?us-ascii?Q?Ik3u0NY4gVIqnMN3FQYUBLNk7LL8lkO3d2P1CaAldmomWkNcsRhrdT9PoeLg?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3866b84b-f26f-4a77-9b63-08db97a6ca01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 00:31:21.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ+C10gSEVJqhWJoXPYuSnLGXw+xFOEotRc+ah0/+Z+5cTj6ecoRXgmA3PdimEkBVOYkIa/E4SLA69DbTnHlaeuelmNGtOjtOAAg2tV1P6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> on it to unmap all files in use, and notify processes who are using
> those files.
> 
> Call trace:
> trigger unbind
>  -> unbind_store()
>   -> ... (skip)
>    -> devres_release_all()
>     -> kill_dax()
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>       -> xfs_dax_notify_failure()
>       `-> freeze_super()             // freeze (kernel call)
>       `-> do xfs rmap
>       ` -> mf_dax_kill_procs()
>       `  -> collect_procs_fsdax()    // all associated processes
>       `  -> unmap_and_kill()
>       ` -> invalidate_inode_pages2_range() // drop file's cache
>       `-> thaw_super()               // thaw (both kernel & user call)
> 
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  Use the exclusive freeze/thaw[2] to lock the filesystem to prevent
> new dax mapping from being created.  Do not shutdown filesystem directly
> if configuration is not supported, or if failure range includes metadata
> area.  Make sure all files and processes(not only the current progress)
> are handled correctly.  Also drop the cache of associated files before
> pmem is removed.

I would say more about why this is important for DAX users. Yes, the
devm_memremap_pages() vs get_user_pages() infrastructure can be improved
if it has a mechanism to revoke all pages that it has handed out for a
given device, but that's not an end user visible effect.

The end user impact needs to be clear. Is this for existing deployed
pmem where a user accidentally removes a device and wants failures and
process killing instead of hangs?

The reason Linux has got along without this for so long is because pmem
is difficult to remove (and with the sunset of Optane, difficult to
acquire). One motivation to pursue this is CXL where hotplug is better
defined and use cases like dynamic capacity devices where making forward
progress to kill processes is better than hanging.

It would help to have an example of what happens without this patch.

> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2]: https://lore.kernel.org/linux-xfs/168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c         |  3 +-
>  fs/xfs/xfs_notify_failure.c | 86 ++++++++++++++++++++++++++++++++++---
>  include/linux/mm.h          |  1 +
>  mm/memory-failure.c         | 17 ++++++--
>  4 files changed, 96 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c4c4728a36e4..2e1a35e82fce 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>  		return;
>  
>  	if (dax_dev->holder_data != NULL)
> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> +				MF_MEM_PRE_REMOVE);

The motivation in the original proposal was to convey the death of
large extents to memory_failure(). However, that proposal predated your
mf_dax_kill_procs() approach. With mf_dax_kill_procs() the need for a
new bulk memory_failure() API is gone.

This is where the end user impact needs to be clear. It seems that
without this patch the filesystem may assume failure while the device is
already present, but that seems ok. The goal is forward progress after a
mistake not necessarily minimizing damage after a mistake. The fact that
the current code is not as gentle could be considered a feature because
graceful shutdown should always unmount before unplug, and if one
unplugs before unmount it is already understood that they get to keep
the pieces.

Because the driver ->remove() callback can not enforce that the device
is still present it seems unnecessary to optimize for the case where the
filesystem is the device is being removed from an actively mounted
filesystem, but the device is still present.

The dax_holder_notify_failure(dax_dev, 0, U64_MAX) is sufficient to say
"userspace failed to umount before hardware eject, stop trying to access
this range", rather than "try to finish up in this range, but it might
already be too late".
