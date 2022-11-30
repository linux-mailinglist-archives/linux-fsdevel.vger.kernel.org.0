Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D263E2E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 22:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK3VtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 16:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiK3VtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:49:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B354475;
        Wed, 30 Nov 2022 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669844953; x=1701380953;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CBYlTxhNXUfMU2XfY62hD1Q8cOwJKWXOMPFvtvVoIEo=;
  b=VKhpLJDPt+b5JuP7IgeqmiQUVwC0RdCtkGQJqtOt9/z+5Jnv9mStz0s2
   GYgNzRlsto8EWlgUxcMLk5x1CblbpqpZY/P6KvS6sR8ucU39fyd1k/3N6
   HzLEU5q97KiZfH50QTZPY1Wp4XZJn305zYIysj0q5pP8/fRwoqERuauWK
   UUVVaHTveo5ORTzL1i+GEayl5C6KsMiCSiU3+bYL2KHMHcMw4nfn/cfXZ
   qV/DfHA0/b7NXQdQKKYlIJwjXt1aqn6FVf8OSbSEMHmn6oq4npXd9/7Ok
   Hi6EeOEVVjk9mXioDi9W51Q3E/zuXV3twr+UznVG9U3wynF/rIFNTgQ9n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377688424"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377688424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 13:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644381285"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="644381285"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 13:49:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 13:49:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 13:49:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 13:49:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/gyPzJR5YGgaJS5y9ZA+R86cCCDA6hY/J/RAiWnzNwnqNTRgc8QXP9fGE2W5+jR9fXDT13LhajlW3Rc+dIas5aTgLF7EgEcn7s3iAPokDxaLrOLQdVo8V4HVpwKai272sfyv1RSRtISBe+K5E+kWC1Kz8VD3jqfgo41ySmsgZy21uOf7g6kK6vlmD2zlmiPy7DCBwmKlNmFxXfonW1PMftg5Eip8bm2u8GjZQuRym5m+HBSd1DYGBpaRt+WzELN4dvUdRyF27Z4JJ9ta3ViOnNiawl6t80GVXalvpgRcSjRX3l9AOBtLTdTL5mU9cGP6djeabH0SfQLcXUuNFWdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLZ5wsUwEikoDN0+YcYATs6MQ/vNBtQzHi1xcLI8Lkw=;
 b=EqTIa/usOM6KEH2OyrdpOrb1T0UdnbpdQkvUbDzTwp6uEVGMA7wPNTK7LPeYPJ/WSzMR14Z8NWQbYoKoZ+CSnsEMKN2W9erwUKHIQIbs/MMdBgyDLDTwk+/dkwndv2p7/GRL/hD3OEvdju2rg5/49gu7SIRJczTg9uZIsKZXQ1uK49r+6ZcWt/CkjagC/BFJMuyrLnpjicHZYcvuntmk0hpAefUYuR5iA0Y8+ZoENnf+mnCcZV2vZehHHjTZrBffgOTK3NNDdUz2i1DjEegfKo4LUqMffzBHNH08VTq2pVS/dOZB9fp3QD/RCUec+kdkPN0FDhvTTAPU6d5AVvyBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH3PR11MB7842.namprd11.prod.outlook.com
 (2603:10b6:610:128::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Wed, 30 Nov
 2022 21:49:10 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 21:49:10 +0000
Date:   Wed, 30 Nov 2022 13:48:59 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <djwong@kernel.org>, <david@fromorbit.com>
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages
Message-ID: <6387cfcbea21f_3cbe0294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <6386d512ce3fc_c9572944e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20221130132725.cd332f03ad3fb5902a54c919@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221130132725.cd332f03ad3fb5902a54c919@linux-foundation.org>
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bdc6b8-442f-4d10-ddeb-08dad31cb5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlFRFLdidpsLURmAgnnkaQTahmhHQ1ZvBtQYon4UJXr59mbzo8ErCGQvXXOJKp6QG6NYrYvyAFDNSSFIWrbHakLUYIOlURZf5V+NEdjBrY36GFP5+RNRA7lAhoTYa49xgzzctyf6Y1sVIZrwvsQR3UI5rlaulNXDFOEwI0VR6pQgmnHABXUKB28iNyiaaR5yhBmlrIeuRgUYZw6e+eL7GCe3yYJj+UbFqKsKkHzztSWjbX639Z1WOeNRVFBbZaqTp/maFUNrMsGbXkVsHqGK8MKTgovoELMjR4ea8lxuXA14WzNyuCrBueFiIvgtTRK7n5CMkClYGwiMseRv5oD+bzunrz3SZz4aaOr2Onx+bltZVqFWf0ADI6O6KTzureVOYDYLNneOzM38zwhlsW7amlGKeM2T3xsujpcyXkLQd4YlIR26vzoVl56kbPUdRs0M/K7ZsAVKOTnHNyk6rEypxlgZK1kwzxZiKqXOU4B/gHRaIBz4d0h4MH7+zwxJKEyrnREz1TIYQI4oWNvl6gC32u1Ve2SQ2PeV28Dst3YbyOuM9XcbE9YI61qVJDFBJ/ht3j4W87Ja1e3sY8xE3QnY0M5mg/fbRUy/6xNd2rZEGE9kJ9xne1sNbD6zcg/QmXoRJLM9U+UbXFfKAd+IdPWM8wbGZfWSNEIKf67fEsou1lLvAwTVCCjUpAIPvWUd9r1UoNXlbLz9kOrQjqPQRHmhLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(66556008)(66946007)(2906002)(82960400001)(41300700001)(15650500001)(66476007)(83380400001)(86362001)(6486002)(966005)(110136005)(8676002)(478600001)(38100700002)(4326008)(6512007)(5660300002)(8936002)(316002)(6506007)(6666004)(9686003)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWp6zVjhf0f7FKuzIVn1v5ySlIkgKD869Rqv8NselazbCGcZ+WHzEOJ0K/l3?=
 =?us-ascii?Q?hjXnzQ2ztwY9B3dYQ9xd7kTgLpw2A/VZaK4ITry0nE69UrRfu7MzRaFfrYz1?=
 =?us-ascii?Q?2ZRr7ztXpqEZm/EWtjBveA2QPX82L66Qgfww64EHuYp9eSq+5gq7Xzh/8Ul8?=
 =?us-ascii?Q?t7X3UNGel8M6m4qqI+cTQkFx+N8ERribe8n+y0L6n77QUQk5BNFb6R7nJYes?=
 =?us-ascii?Q?EfIcPIglVKAbLU+Ifk7bT18tVWq180gU9Yvk3ahSHZckHymZ5YZsm9e9VKkf?=
 =?us-ascii?Q?/3j1U8rfjo7jbRm5Et04zszbKqtkJPASM2peyWC20MCnRwJvUXxAD5cHs/X6?=
 =?us-ascii?Q?Q9uJjX1HKqaTCBQyZmbzwIiYYnuwS1GGv0F7wl5zVN4AAL7thlyUyeNUQkLm?=
 =?us-ascii?Q?Zefabv0Ca9gi4+nRzMl/HkzCtMjroIDbQjJeRAKYgy6JUUWIIRT55yWQUZpo?=
 =?us-ascii?Q?TMYLAvl/OKyrYRVtUeNpkqxA2JtWAk4JcUuXaFZYZqWW+Vk4ZLNb11OdPq78?=
 =?us-ascii?Q?vDHnFcZlUSzUzFtRYu2jzqPaPHaftJtWQ1RjtEt4HqouZlvei8pB0xGCOgxC?=
 =?us-ascii?Q?82/Rso+snG4/ay9LaNoDNdJ/7qw76K6VqRJ29Kkzp/RQQ3VPy1j0V5WEA+BJ?=
 =?us-ascii?Q?tZGoxZvNeP3xRFeetNxNW/VIbUsX4P37eWIzSIBi04PmXfdWacMEfawZ61nn?=
 =?us-ascii?Q?23WT9F6LjBRGkgeWh4n8VcjQ1vuALT051MDGfmoBI24QBEkBe5EsoVo9NxLW?=
 =?us-ascii?Q?YU5oRjxGFggS4yfDM0dKTNyd0Mlo1PHwWT/sOW73PbPMmTutVfM5bpmj3U46?=
 =?us-ascii?Q?GEQcsx32od8h0A0si0JqBvqSWxV6uccpasLUqe7tm2iHnDzkTDMuBEUB0Z7f?=
 =?us-ascii?Q?KSgyYbMXR24UybjLWtJTyT1HFo0AiEPbWODTNL/CWERzlx36pM3TQexOUC/m?=
 =?us-ascii?Q?kZZcI0o2y2fBbBflw1yDZ9E8LflVvJPYALRMfahDTZpGyuGZ3T4MlbAH/vZC?=
 =?us-ascii?Q?BwQy2f7g1dfv8HXwLCIvmbiZ6hRMP33fiSs6ZQquE+FbnfGhzJSMsWT1KN54?=
 =?us-ascii?Q?UhyN/R+JBMsVjlxePQbjViDbj+O3mmFaFojj7ab+Tgpkk7T6nVWppL+g8WhL?=
 =?us-ascii?Q?157vQdcx74qzhXzKLHDNQgmyq9pst0Cx1anVzinvVPN7HEfCY7XeXm6iQg7G?=
 =?us-ascii?Q?j3r7yHYTp3cw3GogIsbRfD6PCFxsxNicHxSrfHZJbAnmHUJUc9mDQ9XI/KAV?=
 =?us-ascii?Q?IekP0PE1NsqGkBaLan8BJRJv6JCIdWaNa6yFygJEHfL7Ld8se3ucgeu1hczO?=
 =?us-ascii?Q?wLdB4+A7rNRmucydwuPgIQRb6I9NsxqBdwKvx46RfQSP975VLjEZvF+9vLzp?=
 =?us-ascii?Q?VRhx3mnNDPUu+Oa22EyiEN3LxFe08COWvJaMYCgJ689Fkzq3oUpBJhqD7wCC?=
 =?us-ascii?Q?kmyU1yjhsAgn/T38epgPiEUPs6meAC9ANOKTCGLUeeSXmddmFXHVItC/3+0c?=
 =?us-ascii?Q?Tw2We/oiZcYjn76san25LRoYz7/SalRUBDF+jG7wBoyAY3Wot367Wy5kzq9L?=
 =?us-ascii?Q?7ImEmnJ8J8ioaT4/7FUhhGsy3dn0ETHqudUvFdNY67GB5hZ+hPswpClACJ8i?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bdc6b8-442f-4d10-ddeb-08dad31cb5fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 21:49:10.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we3DJTLbPEncOVvv2wcy2/qNwQap2BtG5HD7aotqae3rmxAbzMexAwMPRu5LsOa5DCCy9WFV3Glc7Ud0cKxMhcKkcqMXQbcGkFANhERWf/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 29 Nov 2022 19:59:14 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > [ add Andrew ]
> > 
> > Shiyang Ruan wrote:
> > > Many testcases failed in dax+reflink mode with warning message in dmesg.
> > > This also effects dax+noreflink mode if we run the test after a
> > > dax+reflink test.  So, the most urgent thing is solving the warning
> > > messages.
> > > 
> > > Patch 1 fixes some mistakes and adds handling of CoW cases not
> > > previously considered (srcmap is HOLE or UNWRITTEN).
> > > Patch 2 adds the implementation of unshare for fsdax.
> > > 
> > > With these fixes, most warning messages in dax_associate_entry() are
> > > gone.  But honestly, generic/388 will randomly failed with the warning.
> > > The case shutdown the xfs when fsstress is running, and do it for many
> > > times.  I think the reason is that dax pages in use are not able to be
> > > invalidated in time when fs is shutdown.  The next time dax page to be
> > > associated, it still remains the mapping value set last time.  I'll keep
> > > on solving it.
> > > 
> > > The warning message in dax_writeback_one() can also be fixed because of
> > > the dax unshare.
> > 
> > Thank you for digging in on this, I had been pinned down on CXL tasks
> > and worried that we would need to mark FS_DAX broken for a cycle, so
> > this is timely.
> > 
> > My only concern is that these patches look to have significant collisions with
> > the fsdax page reference counting reworks pending in linux-next. Although,
> > those are still sitting in mm-unstable:
> > 
> > http://lore.kernel.org/r/20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org
> 
> As far as I know, Dan's "Fix the DAX-gup mistake" series is somewhat
> stuck.  Jan pointed out:
> 
> https://lore.kernel.org/all/20221109113849.p7pwob533ijgrytu@quack3/T/#u
> 
> or have Jason's issues since been addressed?

No, they have not. I do think the current series is a step forward, but
given the urgency remains low for the time being (CXL hotplug use case
further out, no known collisions with ongoing folio work, and no
MEMORY_DEVICE_PRIVATE users looking to build any conversions on top for
6.2) I am ok to circle back for 6.3 for that follow on work to be
integrated.

> > My preference would be to move ahead with both in which case I can help
> > rebase these fixes on top. In that scenario everything would go through
> > Andrew.
> > 
> > However, if we are getting too late in the cycle for that path I think
> > these dax-fixes take precedence, and one more cycle to let the page
> > reference count reworks sit is ok.
> 
> That sounds a decent approach.  So we go with this series ("fsdax,xfs:
> fix warning messages") and aim at 6.3-rc1 with "Fix the DAX-gup
> mistake"?
> 

Yeah, that's the path of least hassle.
