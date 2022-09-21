Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5B5E5547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIUVjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiIUVjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:39:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B48BC31;
        Wed, 21 Sep 2022 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663796386; x=1695332386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cM8zUWJCpBi78ghXNdioeXPTIEiYgb3ew4yaOo1iB4Y=;
  b=DGffuVN9ZjefHk0KXKPY2qYOIXKee8pskj2IyStxqQpqk/hNI51JMG52
   U9E5vK1oQR28vMTaM1+isnbsFVrjMlO4+dsG7OcAVrGYt/ZjaLItXwFU5
   2UcvsKRyLwDrhsUoUdd3QQOGXl0+cuFs2YYatYsrGtHJHg4HIWUEzaNse
   SAOhh4jFlyI1OJb/PVwnq1XaG38oH2qJMhwAFCLM4+yscM2qU6IsQK/th
   heo8O+rwT44JAVdINCsf/FXXeZeboHJ+aKOAzFu4xEM0MvfB/2OdhIe60
   7dXcHnzg4KCf6tS1fKrHe2o6KWqPaESk3KANmf1Mz+VR7H0wUobQC6gzg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279854615"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="279854615"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="614967592"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2022 14:39:45 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 14:39:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 14:39:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 14:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaIHzUsTBALGSNcPKjwjDCiVJsimSVi1LCRNPLaeKMS0sFdvVSOPVRvK0YOQS/fTiUUAgwex77tvuvICLoivlIXfdxyOZVi2smeRPfBjcz7x3Slh4H76OdovdYqneyUPKFECFu+YlbARZJDRcRcs2O0+BwNhGGJI7IF+9HYXv4p8srnn6lTKSHqJefdiRtJ2ANFTmeIKL/KnuSiEnNhl5daePaaAuLazmbwccSY6fo1qPBlO2eZA59I7MOb7MMcuGP+2giFfA7FScwsW3boqxzWg/WMCcJ9tMlOBIN1rdGI5tZy0FkrC12Z+AktvPDiON4h5cyFLhrC7zBSMWx4fsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzTF3CKogVNe83DB0pzo5K7Z+pTRzCMEUMBFMLvBjhs=;
 b=OBm4RodrhY3Btkr2lmt+4zNriSVy+7c4OZ/2i5oa14COEEqv1oOEy90HFlwyUtaWuvu+VVgDAlROZ9FkcI0HR9GcvecSEBYIOJurXSG0GdSVtCHU26c8CBrHR3nhMCmR80BMf0MD5HluEHrwEJEvte4SQNztOGu+/WyV/oCvXoQYLzdeVIwFhak7f92ecdClUY7l+/xQLtrCSwUZjddtnhAcKJic5J5QjuZ2MRe5nscktZi7X7ylOXXY2vbtnxeP1OQYXKhZGdzN1Q9JmaZD7WbHuOK0hldodHfSs3hcWYeRRWpcn3qWQ+/vXgu9JO+9qoF/gx8n1VIKUQ0U1uGHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW3PR11MB4620.namprd11.prod.outlook.com
 (2603:10b6:303:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 21:38:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 21:38:59 +0000
Date:   Wed, 21 Sep 2022 14:38:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebfdb64-0743-4230-a81e-08da9c19b198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUk8dJuaPeZXxIZF2PyX9tG3WmdneczFTG7AUJr53n2PFUGenp31yTkfRr+M1caTJ5TC6yQGAb/H6cN7hKwqq+y2abmPoV/oFvKYGXEeR8Wr2YntywuhGdXBU1HzspMMjRJHf9OkBOqzYpuNpgZNrugtRq/QqCm+9eDJ1RCx2wBt7jHRqbk1/yEobWDMLY+9T12Fu2ePIRiQyqllQVj9ay1JUSrdtE9B+GiiM0crMBi0ZvNWoHsqrBVCUSu3GNqXwdX2W+ckznXu907sWoQN/lLC9yCPsLDA6IXuqHqsaSl3K2zuVnaSWuldGVpMXxkNYW+Oij2OpbreB6OysOIm2ze5mWWfz5K19uwDX5lkEzd56cFwuYoy4McMNRFrFkVyF2ztR0ezs4CDFDMymXOngWn3pAL5aQI+1DUBklQLvNfyOZ4Drl8LZznXpIV6IOfjhTiZTIeFZocy4Lt7XVASMG7L0LLQGhyNCJsubkj39Bsh5XZfCEJgGWZms8n99lL8BWks0EEFlQkYllCOdnn30iYWguEoSmWxPMHsgR7/99iYs53YIh3/zRLi8ljNry7vO89KQkIXX9cQ+awcrdHAlFnxK7WO7s+kzZxoAIE2ohuw76A9FYQykb/VRWHXBJo+LIYMWQ6vxTtb4AG4PDSCs0br+INneqSKAc3AaP+oqsUmb/8IcNO95f1quwbexIgtgaC2WGJcqIWqgEviMwPbXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(83380400001)(6666004)(41300700001)(6506007)(186003)(26005)(6512007)(9686003)(82960400001)(86362001)(38100700002)(66476007)(4326008)(66946007)(8936002)(8676002)(5660300002)(66556008)(7416002)(316002)(54906003)(110136005)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bitLZW/9fII9MZrM46gzpU+odIMqR9zkie7EWHIqiK79919pvf5Iraht635d?=
 =?us-ascii?Q?UZ+U+Fy0dV8JtzD1U1cp9WXh24+UleBZ9ABWy/rrtf4HqXrLZLeFCAgNAbGB?=
 =?us-ascii?Q?Z5SJ/gTBn5KZgN+OuLgLUVbrJyJ0IqpWKigIr1y4wx3SD0I0ljrCc9oJCmeq?=
 =?us-ascii?Q?RW15D3SGjkY0q8nxLofHgpcrUlVRPw2YW7jgw9Ht0mMMIdNIKcI4Kni/b1jK?=
 =?us-ascii?Q?EkH6vqaf74JDvWr9qZWoTZJLejq07IoNXEi1iyWot/MeigYfx0ryYT8UWLBs?=
 =?us-ascii?Q?2u5nY33VIDMO2tHt10WGK5z3BfOupjbRt38RT93NJhHQ/xu4ZC0Aw6TriAc6?=
 =?us-ascii?Q?YXzzSZDXD2Cx5zfqcQWnzDaN578FhavzwOxhAp1N6g8SNbyopJ1+0UqAfVhF?=
 =?us-ascii?Q?Gf//ODN8ovuRhqzuY4nOTH5K4S19OwEbnUUfxe+YxTo8oX9hH+c/Ndo30YbL?=
 =?us-ascii?Q?G8pHayfC1Z/jmUbG2AgJ37Dnaucb+s6taFy859ndpqYAtCHcKp+PhwZOX8a1?=
 =?us-ascii?Q?9uWdJZM/ddbk6WaDpjMY43ESuBHeQEP5bXiA6ghjYMZyh1ZBxk+N+KYpu0wF?=
 =?us-ascii?Q?cggWzu7BxyWXRAqr88wqpKvZOfqPcR2o2K6ufDRa5+3BB2TF7YeOxz0tdFxx?=
 =?us-ascii?Q?rMA06O+Aw5fAG7fRv/vVEK0D6E2gLE7lAK4VsnYiRdNo4g/EjyftCXzFCLtN?=
 =?us-ascii?Q?qfO9zuprfiGVLj2G7iXzqO7aCmZQacvgyjN8KR7X5wPX8vMeJAy0TGn2wIyk?=
 =?us-ascii?Q?h1ko0qHa2S3gCdRl1p7jvdibrvrcsNr3MBDUdmIfQNPfpOIpM/mnPSty3W27?=
 =?us-ascii?Q?k2K1GBshTNhqx4XlDT5oeIBvYvF2se1IonSMZ3q1Kfxa/kfCqKhGD5GEtUDb?=
 =?us-ascii?Q?QZqcu/bTkPYppjKgJXIKWMDSboAHrhU5REWtJ9XROS63GeQyjtJ317/a9ihy?=
 =?us-ascii?Q?uFt7NSWMqQ8k51Z1ejMttJ5wtRxlWS6GS4x53jOqQJFpwPAWK2t6O676EEfi?=
 =?us-ascii?Q?38W52APzXoObCSJN6+I0iLgsIHYdZkK896RSCrCudHuNpklH7C9CsjlFQj3r?=
 =?us-ascii?Q?I8Ubox1V3R0G32DxAwoojyoTnFA1RqTqjF/XF2MTZCayOBoL6aMZbaWbjqVj?=
 =?us-ascii?Q?3fwkS/mbp5QYeoC2RB9NwdBwJhVELMvmcnpOtPAXZSSBY0l/preg5Q/7qcyH?=
 =?us-ascii?Q?+kxhbmCgBzssR/T8o21HAPcgc5+g/qfauK7JygYpZBGAf3OgFbbikY9Q5VMb?=
 =?us-ascii?Q?pEMXQAHz+/dLMxek0Y/q2dU/sC/ek2h8ERGCJTxiaT1sQAn/BG7cucdiSnJn?=
 =?us-ascii?Q?LCJIAXqOalgklKp3/RyuHgri+SgUa2oe+HtvKXMdWvqTHx3T8YEPgJ7mSJ43?=
 =?us-ascii?Q?aBfvpH9h7lvx786wPhNTdaddIFzw7rtNWYucuFwImxgUfrXi0pbxQfKiIIli?=
 =?us-ascii?Q?uQOzlX6Ad7Av1ipNy/Pjv3aiNxak1jEOuF6lAHRKbtO7QaNBU4++SkTkPXUW?=
 =?us-ascii?Q?NTjRLZFBrnowbAVpSvkQFfhskaqxA9X+b9aAUegJHVtKidaakkYgmDXfkSys?=
 =?us-ascii?Q?oz8UtyArLmiFRfNzlFji4OchbK7tB/kFEhMHTMP+P0o3m9bEg7vgCs45E7GI?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebfdb64-0743-4230-a81e-08da9c19b198
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 21:38:59.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5mjBbbLw0wIP+bHr2Jm5Z64K+Mg6i37kKh/rbW3fSWLO/0+cPtpidxluu0tyhacqWgWknKNVHB8dJmyOMrM+VBAEqvP5LlovlKazupGSrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Thu, Sep 15, 2022 at 08:36:07PM -0700, Dan Williams wrote:
> > > The percpu_ref in 'struct dev_pagemap' is used to coordinate active
> > > mappings of device-memory with the device-removal / unbind path. It
> > > enables the semantic that initiating device-removal (or
> > > device-driver-unbind) blocks new mapping and DMA attempts, and waits for
> > > mapping revocation or inflight DMA to complete.
> > 
> > This seems strange to me
> > 
> > The pagemap should be ref'd as long as the filesystem is mounted over
> > the dax. The ref should be incrd when the filesystem is mounted and
> > decrd when it is unmounted.
> > 
> > When the filesystem unmounts it should zap all the mappings (actually
> > I don't think you can even unmount a filesystem while mappings are
> > open) and wait for all page references to go to zero, then put the
> > final pagemap back.
> > 
> > The rule is nothing can touch page->pgmap while page->refcount == 0,
> > and if page->refcount != 0 then page->pgmap must be valid, without any
> > refcounting on the page map itself.
> > 
> > So, why do we need pgmap refcounting all over the place? It seems like
> > it only existed before because of the abuse of the page->refcount?
> 
> Recall that this percpu_ref is mirroring the same function as
> blk_queue_enter() whereby every new request is checking to make sure the
> device is still alive, or whether it has started exiting.
> 
> So pgmap 'live' reference taking in fs/dax.c allows the core to start
> failing fault requests once device teardown has started. It is a 'block
> new, and drain old' semantic.

However this line of questioning has me realizing that I have the
put_dev_pagemap() in the wrong place. It needs to go in
free_zone_device_page(), so that gup extends the lifetime of the device.
