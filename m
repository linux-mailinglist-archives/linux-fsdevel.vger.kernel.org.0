Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040235F113F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiI3R4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiI3R4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:56:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E9B4AF;
        Fri, 30 Sep 2022 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664560596; x=1696096596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W3rfCue41SmZ40DHqiHa0R8uPoTLFo2yQlcW/Z2JfmI=;
  b=a2hwEC7R0HCxuaXKrBBnXCq/uhJGio2Pcd/ibXtk0kjicDFbkUilq6nz
   /hh6a7IfFM3DvHCjC7jZwte6TEv3Dp/d79YvVVLXl1wQFKqb0uJlROdA4
   hrzqPU8E0UT4UZvAmVthomuyKVWOP01kF4ygZCi+rfzCdfnOqs9zAIF3H
   zSRM/Sv4aBcUcV5jjVzvPXuCWeLUb7wHM2/uBaJ/i+x/mYzMksyt4sSKV
   aF9AEC/f6vJj0yzs7oQTOxa8GVJ6LMu/j7zMY4rkK1m+Wbym0OoC7pTAf
   c3KR2RzRjkEzfMRDoEGNMu5WUq7RnwS4XEYYiC+KWqHtix6p2xCjmv8Xa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282619727"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="282619727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 10:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="691337639"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691337639"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 10:56:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:56:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:56:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 10:56:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 10:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEIli6fAwwb4KB8sy/kjYFf2frJxiXxmyJeEO9owgfo62lTpMYaB2P6S/9k7NGG+kl+b5owuH+51GXDY3zT8IUJNlorcn8L0xycd1yJv8dURqGVzzmkFTaqJcM2UuDbPIIuJ8qoS+L3Mj8PJE2DLVqVbd9iDi0ZQpbIRFBHEsVQlpF4X9ntmWFztiSJFbMR6s2KL+h8A5httdm2Xg4EiqNHzV4zBGqZIlQfGaj5r/Ihn5Xtcu5m3DS/wTQ0rT3Ec6DHKQLpzMxHzP88q9K2sVJR4IJMiNJUDQb2qxIxfW1jLGVy/GSev6Vunp3CAvl9DtxUZ7YVXZ1YTGmbu6+NEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3rfCue41SmZ40DHqiHa0R8uPoTLFo2yQlcW/Z2JfmI=;
 b=VuNk80TC32hGH7Ns8xx90awyB+wzeQSHss/sa0D+/uxNq4zfSRthEilTEpf5zMQW4bvpd6u87j9lDeqbPxuVr+7kNd7+AfClwTUkJrfI+SbyPJxmITMKGDUep0n+IiKzZtUllrIcZcSJLmvBCeFxyysKxBNbqe6gO2AMpxypQr6j8y3a4v5dCkVnAygBhnD3rX8k6mauOPKYGG52whSgeJIL3tZO6Tr6KfPfge4ZATtqc5LADRoLzmUV6qFhOOajLHsopa6te/Bj0DkpyL1kSZL3JMB/UaiHdXyD1BPmKbvDxuJ/r1Tt1l80mSmwtHF6PPR/lAZgnXru9M+anaXC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW5PR11MB5809.namprd11.prod.outlook.com
 (2603:10b6:303:197::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 17:56:31 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5676.023; Fri, 30 Sep
 2022 17:56:31 +0000
Date:   Fri, 30 Sep 2022 10:56:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>
CC:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <63372dcbc7f13_739029490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
 <20220926141055.sdlm3hkfepa7azf2@quack3>
 <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <20220930134144.pd67rbgahzcb62mf@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220930134144.pd67rbgahzcb62mf@quack3>
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW5PR11MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: ee152f5c-2feb-4068-11f5-08daa30d1b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIRpQt5yO3HNPMhaKOe0XYBWv1wx3iWMUiBAvf0rTENUaEZ/jyXHKaWP8K/b9UILSxsF/pQ1lJhGJqY2YINvJcipQYoa3V3Pk6gTPTgIT59Z+QTaeQRKSVRsEH3RLoFx3D2Bq4Q265WpoFYHzP7zlcLZKVm/5kqmA3gBzGMA/iYsdHtPjYwCiJ4cKvDv3lQ6iBOhZEKhzk70qjni60QBQgkHe8llw8n+LWr2VoGKF7Boni+xb+XalO+pHzo5dZqBttlktJkf5Xfvhbo05VuvSv5/+J/0IHEQ1Xi3NY5Zof/jU9kQzPqbX0vVPpq2J6Qk7RbVbu3AbJijobeikjmKtuu3sP9a/rXiwv4McWAFFeYg1heP6BIZu5khoBZ4vIF/DErS9KY07dUXEeMP+0EiAwErN6DP3xXq+CjaOrqDoY3JmVnTAQbiLdrojd0ujjKSIBBenqPwmFQ0fgkuEHEjE+7KuXph5/B5MpkJD3bEAs0Zebcwdcw0KIHdL7grKdGxVEIQq/idPzZL54tC1ykMX8hWcw0zpcF6HLLkkbpkq7l2K3rwBrgwWkuBTUno6DsVZZvxwo7S5skgt9kVCPdpWIaLDd8/vZwVJ9UOsr9AyPGXl+NnPZCBWvY0jJHYfCJ/huaqZgGDYCuNEzZBeakAXoMnqBhNClqpjBEvb1eB2Tiuq5iSDZfouKywmggoLuPN+UUG3Elt3lVCwntb/aYEUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(316002)(110136005)(54906003)(66899015)(478600001)(66476007)(66946007)(66556008)(4326008)(8676002)(6486002)(8936002)(7416002)(5660300002)(9686003)(6512007)(86362001)(6506007)(38100700002)(26005)(2906002)(6666004)(186003)(41300700001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xr11XnjvMxHGkDhJaVm5EeXNfTktrTZowZ1sediVkaK1BUEzOhuecHZaJ7T0?=
 =?us-ascii?Q?Ss34MZ79w3gZD0KDartx6+92l9BC12zzNEqcOIHLAlmyN1V9v6nBE1UXUKGb?=
 =?us-ascii?Q?5h0xyXcfvTeYwXWAIoupKkOcO70wML0Kj3cAb0OWtKTaRAwH4R+87AzVGMGc?=
 =?us-ascii?Q?U1kU4p8V1+yp+TLzN19BFyb5zmXc7+B70VeURpNzzYSRcbhvGNO/aCjQQnFn?=
 =?us-ascii?Q?YHoW3MGZApRWq1FDXVTQ0P92NkiQcHOjaFyrux0xg0pgv7pOxZykS3i6fEBN?=
 =?us-ascii?Q?jUpKXoQofgyOXLpTgSC5exp2tZ9GIGalkdtmaR1fJQ0W7rJEqYw+gomLb81q?=
 =?us-ascii?Q?Bzzt/MqchGGo7beV0Jrj420yF8GNB4gMCnSRWovavO/fbCZKzBTYJPxw0StT?=
 =?us-ascii?Q?vXrot/jM4liHydEArT24FCs46lGd3J66trS5TT7XRJPsmOoymayYwlZwn8Lh?=
 =?us-ascii?Q?NcXYc/jAnWAGk46H5J6pL6IrQAUYQTs0qu7j60WGPPrempuyKVf5T6jnW6t9?=
 =?us-ascii?Q?spW6J/w0n517MbD2+bvDPTbLYfTkTMR9c9RbxJRo3ITMSl8s5FQs6EvYRnzP?=
 =?us-ascii?Q?isBT1p5Lg96HyAW/Ekpdv3g57VijR1Aw5FAYkJ9AppnGeZWIpBOljNgX+W+O?=
 =?us-ascii?Q?bRUZ6Qpm8sbR58eY6MUwL2GnUrhbvmiaYnTHqiF2oOwjkoPwejCY/K4uk8TB?=
 =?us-ascii?Q?B5bMiZFMao+dNut2OF5GfAsab10YBj20avW6sw3Mqdx3cdZayLFTGJ9kYOvx?=
 =?us-ascii?Q?DSl9F/g/UYQBvAoSzZsIXnQIzQodemSW9zhzgP3lnJUDWH/0W+Z5EmKLlYWN?=
 =?us-ascii?Q?bzTEIHdxS8e98ZGM09vflPz1jJRiu3u0Vy4dYbmflrhM5hPnY710sM7a/gXq?=
 =?us-ascii?Q?jBn4iX0GX4CtVJdcQ5GD6wK9cWUOtJczOch1cnzoD8d8+BSD71K1s9jO8cWV?=
 =?us-ascii?Q?xGk6wy+ErhxTPrtoKD7YXXO/CFilwpAtxe7R1jnOVpUvsSmZX0tOeUHE632y?=
 =?us-ascii?Q?KgpvQUB++1nUkIfOGM0QZVWYhhQwQ3FG4Ar5HCMjzdi0tYtfyizW3ifCb+oa?=
 =?us-ascii?Q?D2Vxd/e61HreH4xZWQgkCDACFTjEnI0o619RFxFYRolPlt6hurSDSWvj8dD8?=
 =?us-ascii?Q?kAraDtiiaZC+RJTL4TICLbRyJ77g4GFoOtN4MpnpF83LZcCufs+zMyjoZI+5?=
 =?us-ascii?Q?Hskz7QnvQwR2YMQkI09qO235OWc43SbxqeWnEQVsQkxRWzbC7hiBMzJ03iIR?=
 =?us-ascii?Q?l/U5L8kBxxLieLK/tza1CbkLjfJSaVSvfJQlAFjSMUNQ0wur0Pv3wxuuhwg8?=
 =?us-ascii?Q?eXnYClD7ubhoK8k7GkbEu0zFZY+05/M+9Lgy1+B2d1MSWW4auHIic3xVFK02?=
 =?us-ascii?Q?ZqbMEBA6uYyxd+eTXuWIKuxl4+OoFL2Hs1YiZz5mI8G3/fEEXuf2MI5i4wCt?=
 =?us-ascii?Q?bxTkafJteYkfc+tfYWUx1iYCAnU77pXR8l4RuLhJBHhxLadMUEWCyIXrfASD?=
 =?us-ascii?Q?bfGfAf7gPwY2Yrw7HLhGX1A2tkrNRjVo+P5Nfoccw43XIylKd3t88l45CN4v?=
 =?us-ascii?Q?MEsqM5nJF0wzF56rKHTGLiWLiqoO/SHTNEHL6zP8Rqou3jqx3lhot25tKn9B?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee152f5c-2feb-4068-11f5-08daa30d1b06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 17:56:31.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6E7GUcrZ9kqA3xabFV3wKdUMMEQKU4myyZGYiQ+XYqOJqmZXFBlNuylHcrzyejIFV4c9fyzLw1jBt4cxJVxEjL0CypUgEh8xiyYGN6QvaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara wrote:
[..]
> I agree this is doable but there's the nasty sideeffect that inode reclaim
> may block for abitrary time waiting for page pinning. If the application
> that has pinned the page requires __GFP_FS memory allocation to get to a
> point where it releases the page, we even have a deadlock possibility.
> So it's better than the UAF issue but still not ideal.

I expect VMA pinning would have similar deadlock exposure if pinning a
VMA keeps the inode allocated. Anything that puts a page-pin release
dependency in the inode freeing path can potentially deadlock a reclaim
event that depends on that inode being freed.

As you say the UAF is worse. I am not too worried about the deadlock
case for a couple reasons:

1/ There are no reports I can find of iput_final() triggering the WARN
that validates that truncate_inode_pages_final() is called while all
associated pages are unpinned. That WARN has been in place since 2017:

d2c997c0f145 fs, dax: use page->mapping to warn if truncate collides with a busy page

2/ It is bad form for I/O drivers to perform __GFP_FS and __GFP_IO
allocations in their fast paths. So while the deadlock is not impossible
it is unlikely with the major producers of transient page pin events.

My hope, famous last words, is that this is only a theoretical deadlock,
or we can handle this with targeted driver fixes. Any driver that thinks
it wants to pin pages and then do more allocations that recurse into the
FS likely wants to get that out of its fast path anyway. I will also
take a look at a lockdep annotation for the wait event to see if that
can give an early warning versus fs_reclaim_acquire().
