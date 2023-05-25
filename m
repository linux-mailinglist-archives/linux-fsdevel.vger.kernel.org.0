Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B007710568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjEYFmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYFmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 01:42:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2290A9;
        Wed, 24 May 2023 22:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684993364; x=1716529364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mRKe+TfKA253mxIRYiJfNIkjlGD4Cl52nPFLrVPoZ5U=;
  b=ly4m6I0VpAI1BJMtZy5FUmFAdpp4wvbfesrc5mRyKhquYlBJRz1gGa7C
   FBoLeZ4K6zD0hV07VBqnA9QSEMmIAzMvf/nujmq1iy9i1hZzz2FMme0hL
   Xtf6SgV0vdtMewlt4Y63KHoDfGhErfFDHlU4RmV4YxHIrExFUsy4PtxMh
   z8RnPWs7URd3YlWZAHdBTOJlV9Q/pfFYsw/QjSJD3Ob4G+64EuSOKNS96
   rIYoCEF/Ezao3SzCqoeLqJfwhF+7YVzEyNVJBZGlRszoNTL2Qi+7pIdzh
   mGsn6iqAOVDHe55/JQ2c102u+HBhoYZsvGS2tMSrbNAwmjlKTgqKgdFDS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="352631530"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="352631530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="774529833"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="774529833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2023 22:42:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 22:42:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 22:42:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 22:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djZ8uXLFAzdMfPSznKrAca/mqU9kWHBM6gvV4JO4kQFvzHELvm4VqgoonsecYobELXlAs03hSWdzQmqZlX7joEZfyXHUcO046TWYZJq7Nmg3zRu3CncyJRoMduCjv+QtdXXGwdakxwcXhgNXKs4c0DZkEY+hCRtjpDVu3WzpfSi3BdjvEA+9fF22VnLBl3tUUONW/mw0sJXK7lnSRDzrn3MdIES6ojYEqpKuaNR5+XgqYngXBYfy0yS1DPYirPR4I3i14q9EeVVk0ItMV7+hRJ3uqS9uSxP0MZRIiyHH+/rowRkRXyU9H+OIu79EETrdaZe17x1Z8TAIN31PnZvA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd7H8WGsfr8EsHwyttKdBgxcSPXvW4/qmjG7NWRncE0=;
 b=RFDInp3AQTQWHB4asXrA+cf77vSxndP5V64gXWOT91SD6YYpSYYVn4wzLraRrH9t1xMu883aZJejgmCWgp8WoJdX5icvdtpukzAGnGQew7DSpZRTdtcVzvxnZCMCu/fdqC5s0a5Q1Bh/4gXy14Bp5aXFZ/0aAeJ+tjtRtp1LGthNTd6bDQSAM89dti3qe3fgTiQLo3wd4wi6uo59CH4vFW8vhFgyISp+Nm4YS5UciZATsmLaXRyOajEGbsa67BiWjYHrwJNbKARW2ifDWf42MfzW7dgWoCpLIalBusgdX0ebN8o+eKzWocuF6YrIHENsnk7vYJKYgyoZah9yOi7pZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 05:42:41 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 05:42:40 +0000
Date:   Thu, 25 May 2023 13:44:31 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Eric Sandeen <sandeen@sandeen.net>
CC:     <dchinner@redhat.com>, <djwong@kernel.org>, <heng.su@intel.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: b9366c9c-bbe2-4f40-d314-08db5ce2dab1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFFpWS+wm5+vJqOJQ29yZR9Fiy4VMK7YHJSfMX7lQhlc/IVZr8EPSdZxeGvVhFNvokORb/fFVqzD43b1RPDcG408+VEIrUN+qW6k3YOpXmbgjC+4S+TFQHeS3e3OyLIMcgVV1NM3qEQbvG/jIQjJYfgPTMhtUbHAqRJzaHeRKnzeG1K13/edKIsXm601LjOvlNOxuSB4o31KCV2l4l4g6nahf191ibGtmB+DStjiHTPXVL9xP6cLXnWRhuwsU6E3S3Xo85GfCmmBnHeQ/+gB85qiqF64mQalGvj5GMQu0IELB0dWuWDD3LAbPYUXWNH0vOgFbU8mLZeCchZAKUuGNmRGUvb07Ev5+Fn6qVZ4Wd7UHX7lsYnLfjhfABw2u1MrZ+9Q/AU3WWb8Q6M+4NH0EHyY3gsURl78EoZS9Kfk7IwpNgtusn+IoWHcrqC6OrV8TZ7kzxE9i/qjE7JLxydMhdab3HexBt7ePqbeuylaVwRDNG9yfWSVWewuzKNpPFm0sdnxbCbz+23Wm/qLKmV7y8jYOqByH4QEB1ssU58/FA7FpPRNNMdXvSvEgdPq0ziYzeyFMEOs7STdyE28Jhod8+njacBaOtxTelVdZFt9fW+rsQgPFu6htK3MDeInROkzJ8VJrP2ZsRIvnKiCfpJqwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(66946007)(66556008)(6916009)(478600001)(6486002)(966005)(6666004)(316002)(4326008)(86362001)(8676002)(5660300002)(8936002)(38100700002)(44832011)(107886003)(26005)(82960400001)(186003)(53546011)(6512007)(6506007)(83380400001)(2906002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJx2DRSCfAwUJNV2GoUPhrjlLSmiTO/gxLS2LqM8ysmVPjbODTmQW/MjCKsG?=
 =?us-ascii?Q?lNE6/LXmZQiOUCeoFKZx176wKW12hJadTkr5DdPkH8QzRk0EGmff0SyyiGLl?=
 =?us-ascii?Q?EbYmSEK6iYM5suv7+VdcpT/w4/pcCjnHv/W3RNkQdHXB7lV6SeK+1qpRIW6P?=
 =?us-ascii?Q?XRYvadrHWb8R/bNtdLCkWQ1GzLvgzDfXXtTlF5USl4dquvX6GOt9V6jy20hl?=
 =?us-ascii?Q?ua62gtJk328QdzoUCm8pKxCNuQUOsEdYQcpbR1lPDU088XMgmjd+V3KRoyE2?=
 =?us-ascii?Q?LgN6VqlvfvvfFv9ZfPz+YILuwJDzua11tOm1iIyGA0KMfTA5Lm2uCxhBeVcT?=
 =?us-ascii?Q?zPVaInHfjNWn7U4r9stmLZhTdGvpY4/tdiCWqumdlYkPMLTpAviJHDOPH22A?=
 =?us-ascii?Q?ULaoXLLluwuRzQyPuBKj8XHfjBD08U820neZIWi66CVtC8uOSNWB6Kwql4jg?=
 =?us-ascii?Q?uzjY8qvUypgBlQ0eaYqCjs+c35linHwC7Iw4EHN2rCQ9axfeY4UzDjfhGbjg?=
 =?us-ascii?Q?FCS5NodoboLkTbTuuaweme4pBka7don6oEaf15cxic9tlesZu3jOJQG6UHYn?=
 =?us-ascii?Q?jSp0kxWwbQIs56AtLRWrhiH/GmbvzOjtiJSdMSvkzOE5gW2GTjgvmA1+MSXE?=
 =?us-ascii?Q?j6rOgnJdL+aGsyJ/35dHW+LVkbPRamcPsKdm5SdnIhRXV/MOrNV3evOxqchY?=
 =?us-ascii?Q?ibuPMaM9H44sv5CiCM34g6Q2UJZiTJywy31NUlmWooCTSMFp2e1hflOHZDZ/?=
 =?us-ascii?Q?SA82JsUNtzfW8VjN7RLX/qRMcxOc8f9j4mhiIERBdf/PiSIJatEeeWlZJPOb?=
 =?us-ascii?Q?c4EKi2zsuBJPCBlp098QBklLKeLlPf87j7qxC23N/P6TSxknu2BBxZQNHBkS?=
 =?us-ascii?Q?Sv7MZh42bDbeP8QXgJbPsB5XHoTHBoyj9pW08hTMqnfVoPvoTuLPRuK+bDgO?=
 =?us-ascii?Q?bYSRu2UCxJRQoHoUpnQQ4LfY53E+Kpg3WHJmTKAQKqhCm5OkeaMcgH/7ehSj?=
 =?us-ascii?Q?Cgnt02eMVUWgEfnKC58YpWzPEI3W7132sbrYZwtcNkn28VyFkiZ4qu7BBh/p?=
 =?us-ascii?Q?d87xHl9D9sR44qAczOB6ReZ0ksVape+ivQC/58wHC2a0Pp4zWvJofezcbRba?=
 =?us-ascii?Q?9ZySy+nuxiGhJ7Lc1QK/w5sOM8H4CrX1WGgErJ+tL3IBry//f/96BfGdcZjY?=
 =?us-ascii?Q?LiuK0nFrbv4zPqsndCReI3b+tW3XvWuwZ20bnlFBXZnWlq1YpRW0Wcr6OAWv?=
 =?us-ascii?Q?okGJaC9XLuf+F+H1gOHF+nXm54LbZKUCwb+eCDAlLHslWcJ4RkO/R9oES7le?=
 =?us-ascii?Q?KKZYMpXSwRZj9K+enQ82UPhOBbTBOZqc5kNUncr5aDJ4ouN/oSRAoB4BWyIL?=
 =?us-ascii?Q?DID6AcreT98JBkdhsUOYWkkhpaQ9rivWgV9+nGcq1yB2SVpY57Z7O6TyZQ8h?=
 =?us-ascii?Q?d4WCjPDYjubQx6UzFpeJBbRyby2oz/8v97q+oD+/Ks1D1v0QWSXbkiDeRaXf?=
 =?us-ascii?Q?y5YKHahT7etVdrZo0aCk4S1gOMLn0uasG8uslFE1SmmGd6try2i12dYvJNrK?=
 =?us-ascii?Q?D1yK041TLTG6iirIWpdJupVDFe0VifGGODaorlI0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9366c9c-bbe2-4f40-d314-08db5ce2dab1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 05:42:40.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oW5jPuy7ZSPewkaT8Q1Yl/0pW2+Y9FpGywYrfoINRQwpYFK0eKPGpMPEchY15ISZHgMZl3I51mcPXBSnUUi48Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-24 at 22:51:27 -0500, Eric Sandeen wrote:
> On 5/24/23 9:59 PM, Pengfei Xu wrote:
> > Hi Dave,
> > 
> > Greeting!
> > 
> > Platform: Alder lake
> > There is "soft lockup in __cleanup_mnt" in v6.4-rc3 kernel.
> > 
> > Syzkaller analysis repro.report and bisect detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230524_140757___cleanup_mnt
> > Guest machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/machineInfo0
> > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.c
> > Reproduced syscall: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.prog
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bisect_info.log
> > Kconfig origin: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/kconfig_origin
> 
> There was a lot of discussion yesterday about how turning the crank on
> syzkaller and throwing un-triaged bug reports over the wall at stressed-out
> xfs developers isn't particularly helpful.
> 
> There was also a very specific concern raised in that discussion:
> 
> > IOWs, the bug report is deficient and not complete, and so I'm
> > forced to spend unnecessary time trying to work out how to extract
> > the filesystem image from a weird syzkaller report that is basically
> > just a bunch of undocumented blobs in a github tree.
> 
> but here we are again, with another undocumented blob in a github tree, and
> no meaningful attempt at triage.
> 
> Syzbot at least is now providing filesystem images[1], which relieves some
> of the burden on the filesystem developers you're expecting to fix these
> bugs.
> 
> Perhaps before you send the /next/ filesystem-related syzkaller report, you
> can at least work out how to provide a standard filesystem image as part of
> the reproducer, one that can be examined with normal filesystem development
> and debugging tools?
> 
  There is a standard filesystem image after

git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
image is named as centos8_3.img, and will boot by start3.sh.

There is bzImage v6.4-rc3 in link: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bzImage_v64rc3
You could use it to boot v6.4-rc3 kernel.

./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Then you could reproduce this issue easily in above environment.

Thanks!
BR.

> [1]
> https://lore.kernel.org/lkml/0000000000001f239205fb969174@google.com/T/
> 
> 
