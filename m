Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED13603198
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 19:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJRRa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRRax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:30:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4766576576
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666114253; x=1697650253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=crZqP4AgdwRE7GzSpJTyzCbBBDqZTGyWGGv51iPhLZI=;
  b=bPtUEjoZ+qXLv1wWgIGHjcQ5TVJPUo91kL2nqr+sTO37NHjxJOb0UBMI
   eH6oRbWthd/1jNOklMCbwLZvu+6OwE6qG9K+pGUNyzypLp9DLgIju0zcw
   jPeBDpWJ0By23DIn4t/sumipyReS2guaeocADnKlldZiqFUCrQQlbZhML
   jsvmZ/yKfDjKHatKeWu4LS7IGDPrQU1lNDD4a+FhXesSGRCXcqrZhXl0h
   gTHv5yb/6UZ+PPCQfnYHkoN61am3yEIB1bBfEN6ulEDQen7caHVr8IUOj
   /csDi99LquWnBcVu/ueMrIVsXjPxooPUx7s7K7YJ15Ju2dNtxlF3ig/7K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293547127"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="293547127"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 10:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="662011267"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="662011267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 18 Oct 2022 10:30:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:30:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 10:30:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 10:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AODps3NsgJtP/27xTI3zDAZn9WIzb5n+NBOTE2eGqcW0sQatRpb9FNe1A5n+3E2zNUMbUDCTjLBn15kzDtuBx0JdZ3k1mx/MS4mpbdAxZ4OMTjGOng/C6WcJ0DEakDSk3oiNwJb9ndqlhL7h5Cw1egr1nXWbOlaRYXnE2+FR5zKVKW06wRsJXEMwDzHu2sQbzF28VOlvv99WvrX1zI6mtjrzaGKB5t68q4n+22JxPB51MqEEJEchvxwcuHK0LJ6hQZQUFiridqmnIaHp39tAeqmmMMy0PwWuSRfWHI9T1M3mKAFHsKL2PPwCzWz7OBmljAHyXOday6Mz2S0ie9e8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F59JrZatCud+dT9eb+wZahyLDzTQwQjQczwUzwYPrJA=;
 b=GRtSIXNaL4cQW6jE+BwibCCjge4I/nh0QtAwKYxijaSlvp0JLxhkufwtIAnkiYnrYmxTVIjFBvM9lg5cSARIojH9E9EKARo4YohbmGn3Y7X7DasUbMr8F5mnarXcXb45gRuE0EShykTCXBfCsqiE5qegygC5o8THtBK7woEL1H9MNUe49TGbzrNnTroKpli2IGoRMkuH8A5WKJ9B4ENKrei+8hs8RWSxsbGF5XFijHNL4LvtS1RAy8gDZHpsoTidUDGu1vMR1uNMzJjabs7l2OAchI1WjOtUlztv/CO/6JZHful2fPzl3Nylj4tuBSnx6ElnTqFlIf+Bvz854mZZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM8PR11MB5670.namprd11.prod.outlook.com
 (2603:10b6:8:37::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 17:30:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 17:30:39 +0000
Date:   Tue, 18 Oct 2022 10:30:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, <david@fromorbit.com>,
        <nvdimm@lists.linux.dev>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 07/25] fsdax: Hold dax lock over mapping insertion
Message-ID: <634ee2bc3d436_4da3294f3@dwillia2-xfh.jf.intel.com.notmuch>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579185727.2236710.8711235794537270051.stgit@dwillia2-xfh.jf.intel.com>
 <Y02tnrZXxm+NzWVK@nvidia.com>
 <634db85363e2c_4da329489@dwillia2-xfh.jf.intel.com.notmuch>
 <20221018052606.GA18887@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018052606.GA18887@lst.de>
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM8PR11MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f5a2de-8ad3-4313-1b66-08dab12e797c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuiLjoNvOjqwq7XySQtOLBD2usBNYCBsqD9tWGyCiF2am3KTP0aGWzz6BpsBcGpBjCchIr7pSjUCirC/l4mnznYQORaYWaavOPzOvGziWWnJP+tN6c263E460upgLDy6DPiwbIGAF/+1kVrJA6JEHZOFEPKZ8GC/SnyYC8Brmo88rLOUQW8dXnAJbCtS2miw1GnYLBo0xg2C8uWWZKwQWDPvJw/s0SKffCdMLZOuWkTRHM8UcUS4xhA3XrZqCOKga6i3eaM9r/YmdW0F9EAHbexxU1cUe1bXE9dCh6hCLcpZOTnmHg9nYA10VYuS/PG1FXD1bT7lA9cMwa2bmkiCkcw1wcnoJUG5a0Gb0O79PSIoD+QIakLleSI4MQyil033PmfJZbzULBkucCmxtmw7+BQ/0qDd0w+PKbSOsyyI9iZoMknsWVRDh7GbfGbddOMcxHC9EwVylLW59OLbNRv22F7o/l3whPha8IxR+ytcM/3yS2SdkioOIQx69hHqyyVkGmAjo2yQrRoJWTScVvIYq5dofyP5kFUWQjOf4PQWoRxk0QNVEL3i103lLoO5S2udHIwbVzd+UjCtEMLesgayfZJbK33AC2k5w2MuqMk4/9wOIA44MnVldFZiJBENvX16QzPdVVxzaLJMoe9pFmjj49YEKJyYUp+ofWjBWp2GRt1pAFld4QBzNzJKG+zGzvHWHV8o+Sh6uSIuwSglKKfE+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(38100700002)(478600001)(82960400001)(6486002)(5660300002)(186003)(54906003)(4326008)(6506007)(110136005)(316002)(6666004)(66946007)(66556008)(66476007)(8676002)(4744005)(2906002)(26005)(8936002)(6512007)(7416002)(9686003)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eq6FGuJYgHFOUCpbgy7SgKS68rQF9EG96uGXW2oqAXJhleXexcUQXsMchNRg?=
 =?us-ascii?Q?kVMCKqVeXRWHzYy381JKRR61KPtRaikQ6Ci7SMkb4mQf7vdD7NxutMgmn2Ec?=
 =?us-ascii?Q?w/qBlFjclUdZMYVtZr7rYaQx33vidjjHJLEo/VtVvWHl78t546tBfTDCFQ65?=
 =?us-ascii?Q?EzUIv1PiaylGobYdRHvCq6sk9VJvjbBNccxWDmkDq+sGPKmQ2wvUIq3KWpks?=
 =?us-ascii?Q?ZXjfIPvflU5nGE2OlDLpzfGTqvSRp5cCnxL6ymZrGwBLS7RJ07tK8aV/JarU?=
 =?us-ascii?Q?TmVPm7/5mW+DRhx6rxND8jZcdCWgJeD+j2UKeNM59IldjikX6in6K+UxdQF7?=
 =?us-ascii?Q?OgIP9mNVKUHJQN68wAFaogecoVfEsfhq825aql1UW6tjmGNtGTyihYwXNdqc?=
 =?us-ascii?Q?rNpWdCnSATQ/vLlxE7uBeBod6wdCTv3FXkCkAyqb2gA2FpbmjvF7pjtpq+Db?=
 =?us-ascii?Q?b/tmAvuqt/2E/OSwCt+E9R0VRzSY7A7aUcKA9N3vTFjHj5YxTeaNBqlbqEDy?=
 =?us-ascii?Q?Q5NRme7SIRyfDOsL3oNwRxnTL4xqHd4PuNwbVwvp4KBw9K8vxZXpL4G8GYAD?=
 =?us-ascii?Q?glcNxlgxAZjRy0p6SajKOeKt9FYkjp60rhUPNQ3J1oQp2wJimiRenkzVRn3w?=
 =?us-ascii?Q?lakKeiUGeHKMZ/fpREeLlHjPwAOJggbKw0c13EtOEglMQ5zcVLzNqiy6vIyo?=
 =?us-ascii?Q?bIwB546mNTFMUF+fh6zJ81w29qfAvENjB8qLvGsduTxEduLazSGDb13K6s/M?=
 =?us-ascii?Q?Hqpg8fqlaKWLpdUQ3mSavPdF6K9lNhOiKjyPIZp07QH4Jv8LDeCzIMCEhhp/?=
 =?us-ascii?Q?GijTojOPMWPlXhZOPjjThVuNK07+ew4nhcJ5GBcjNiDao6H0mlUKq5mmIKAx?=
 =?us-ascii?Q?VqqpC7uwcfzQ8T3MPBm3vJv+KzBC69Jen3Ee4CCr23fOE8szVYrP4urcsRfW?=
 =?us-ascii?Q?GTFSTrrkhByACKczPBHvZjfp9eHe7kIlDP8WqkRfNeV+9ca7zTXeKEogWP5l?=
 =?us-ascii?Q?B4hD1bB1ex4vAsGHiNRure2OsE/MlVm7iGxt28pixz7nfrZrsU5iwPD6ntWq?=
 =?us-ascii?Q?NIL1qZJ3BMc+na6LEv8P2549D2wxBkEuXX+fDy/cg5ab2O/qgq3iEvhjfs0y?=
 =?us-ascii?Q?4KSdbdstn7mB6jrW/ODUKTbpM8YBPKmOpGleqEjjXFg+i3+KVBrep6h3w2Rg?=
 =?us-ascii?Q?vc8uy+/QaGE/QQC8XjZk/SZ8mLoxCVSP68UZZyuFSLd4fswf5Ewo+vBepncJ?=
 =?us-ascii?Q?NeHY45NRFeFRfF7vQ+4FRdi/cKCUHJtcP7fgm8PLEZmZL2eDvuBWNGQzMums?=
 =?us-ascii?Q?iyRdOfPgZKLkBBDTsQkzauAIrL27+tl/IbFKx7GF6zwsmQi3gYdyiuUBY1E8?=
 =?us-ascii?Q?fU4xIQ7IRDvkMaXABx1DUN+wryBl1U2qCRZOBBCB15gRTj7BeJk0WIgiXkAu?=
 =?us-ascii?Q?WCZB8H7Gs1ZVD4Xn01Dh8IFOvPFc0A/Ysziupf3zAksudnM9aQQfhT6NlvSl?=
 =?us-ascii?Q?Bae89mghKOiO1l5er7zGWh9wfwPwLaoarMQC1sZEaz6bL4LmAcdg4341DCmO?=
 =?us-ascii?Q?S7qM7Ht7+AgO21iYCBpFa9gAOEV5odv/YW9PNOFuaV0J0us4pvPdQ19hbuTC?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f5a2de-8ad3-4313-1b66-08dab12e797c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 17:30:39.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJpvi5QOPT54kExbXPM4Owt/VzvO5sQ9VI6FVR8DmvQO81JamVKsm+FasrQP77CfIDLR8B9lwcn7kc4tEvw7WXKgmkgyZCkfQUJuKo4gNlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 01:17:23PM -0700, Dan Williams wrote:
> > Historically, no. The block-device is allowed to disappear while inodes
> > are still live.
> 
> Btw, while I agree with what you wrote below this sentence is at least
> a bit confusing.  Struct block_device/gendisk/request_queue will always
> be valid as long as a file system is mounted and inodes are live due
> to refcounting.  It's just as you correctly pointed out del_gendisk
> might have aready been called and they are dead.

Yes, when I said "allowed to disappear" I should have said "allowed to
die".
