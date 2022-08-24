Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC425A036D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 23:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiHXVxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 17:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHXVw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:52:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584E7539C;
        Wed, 24 Aug 2022 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661377978; x=1692913978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zjG0cJojjF4463dzvvCzZ7p89hLo863yxZbOLuMJyWs=;
  b=Ln1/RoprEwppDq+ndeJie8EyGI+C2jW9IYLDPRdP7f9VPHBXR2l0eHmD
   uklPI0XgGMoxE4kFcMauaOuAkwNc5F9/ghhniAEg/tYVGc3vUIQFCNcC+
   oQLxWQtlmZL5Q6QsGe5f2mjWSrStDNv1IDwSKpuWUDxoWyO72f3oT85f6
   u+rQqpbVKsLwnWXdZDfuv1do6zYPhDlyJOdFfEUs7+tqvEgn32CqbzK9M
   I7a7PuUnWJAGEWIcU3H/ypl8mbMhBGjDRlYG4HfaIWXfQ0iqIX8w4uJf0
   01NX+ZoZ3DNFNFdS3UKkdQGWr/qouxQKmOi3pqEqwi4LLz8nj4yFuuIaO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292828425"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292828425"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678208794"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2022 14:52:58 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:52:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 14:52:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 14:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3GfSENo3pXccjKVcKDl1TRE4A1c3FnIg96+7scGdFas51G8Gc924E1vjjjsyykBG3O6jS8zOV9Kyaf+w2v2zfVFNBt3K475tkcm9Gxi7DNByhYjQGomXcVFpJWNPOK4h7hjRiUt2OPfbPxLb2Xz+GE9EcSbTqTeV0+ZqPzKQoqJsd+H+FGnta9w+0vkbLOCTtK5YV5ouf3p45CN3LVdtc/26RMJKxgME3pMIDVHC786HGEs99mjMOkKoAWf8TKZ0TFB2b5BWai2SoiZt8nuwq8MNwt2aJUxGT7nYB8TJxxegjmLH8li6tnEo5pC4KQMePNimuyN3Hv4Y9WNdOXvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2WQm/Vvyctv6jdTtrdNEhvhnFz4FdDzcqrFLhmvLlg=;
 b=DDGA2Sn2SnU9+YiKuu7MI/eQn65dD+CrYM56KfMlJZTboxhTe75yE//SsgwukEzcMaHKKVX+xN/Fxd2OObHcSIv4wYAKp2rXfc7xXb8hYTPlG0GcLltQJqxyKwIOi5wHPEf+sjpDW4lIkc/uyGhlY05rxIm05zDfdLXymkwUsfExsrV4QihGLbNVHlzWJnX2SBvIWPc4nT+P3SLPhm1H78ApMr+juDIpLuHWxUqzyAfXp2kzj1qUrDZdueXqBjEOc++tjdKo4n+IwMGTcdHlosmCypvAAv1yzGdl1nHRSWaRgPpKqG//YujvWLQigd7qeRI14UD6T96wa7f+0cKW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5867.namprd11.prod.outlook.com
 (2603:10b6:a03:42a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 21:52:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 21:52:55 +0000
Date:   Wed, 24 Aug 2022 14:52:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2 05/14] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
 <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b343e05-a21a-406e-f693-08da861affeb
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5867:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPApoNv+Rz2FywhvwUBZoU7vc5SWuAfB1OPbLEXbt+ZJM6cLx/HiOEY8k2xkcFCFnQTl6wmdkQEy/hUYK4UB4tmnHvn/dEtRyP9bvO4Al7YXVoMW+h9lPTrbqqlAgCx6U0b/hCx3MD00TwEZz88xsOyPu21ohruozwEOpQ8qSEjffOz9sTBCO+WfmFHlxASr4vceX4iE4BbIbDj0upaR0caJO5PcxjBwJKIpxjMpGD7s2kz4OGQtGOfEQ67HD0G7bkW20Q0pN/AXHtxjG7LlIcNDUmFpZX1pEY3RZfLVfYuKvqh/M9WfCQsDvx5PdZhUNWpiNdCXZC9KH+lFwLgDNHDKeKdKw/9rMfiEGqB5OfJaDbwuvdDXNiNjE+K4EJDz3U4jbIYpDDN7/Rvgp7YgsRbtWoxuLGKeFbuoepSP0HokgKotK2NLz0RJLnNDXUW6vhewylZ5LqTH+Aiud60Fl1NBwbHRlHiGo3q3xJMZK6URI8NQsyQN0Y+1ZuxNfT9CrkcdiFiROiWlwD1KTypNA2jzxw6BHxHBvpXKWR+d+K/ez1JfVjksh8+nyzz+zhcEz8AYFcqViMhIYqngIi3IPwF/rlfs7MZGFdomnC8GgX900BDEpkbnUZjrlFXDV1dqS1KF/uuogOXt0MbOymyXo2HswfuecxNQSs0VwycBx1kGAan8EPsjmifYl2jhOd2v9vSNcZVbkwLw4BNs8IuZCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(39860400002)(376002)(316002)(6486002)(478600001)(8936002)(5660300002)(82960400001)(41300700001)(4326008)(66476007)(8676002)(6666004)(66556008)(7416002)(66946007)(2906002)(9686003)(26005)(6512007)(186003)(86362001)(83380400001)(6506007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?my1MbgzNsBW0d5h2ausbcBNnLyipRcL1JQcL07nEEPJuTEoNX+l2eBR/pKDv?=
 =?us-ascii?Q?jkXBYbcAIeqdHVq46ab8yLEkh5gYgB3CDXJHeyXfmfC+ZZgAoAYYIVXiYgJg?=
 =?us-ascii?Q?5Ynb7pjybhU9yPSz3ZnnmfIZaducevSvUX/3RxIWDqmcHHQFFt044FKhHH9j?=
 =?us-ascii?Q?ewVcDNvhuq+SYNxN2y/+5pkYuN3CROrbQDje5YH58WaoikEAffG3byzrMKFx?=
 =?us-ascii?Q?MwFQYInm6WDes+H68QNvWKXiSI3TRV/+j5TDubTdCc9mziSK5DMyXlhOCUq+?=
 =?us-ascii?Q?k56vBuaR8meQ9rM+QywP3fpaW6JZFLCiPT617SwE9wGdD8wLO8pajVuA9dt2?=
 =?us-ascii?Q?W/x2ijPOOpLkNtKZB3d7SGSEHeGM3QhsIU663nXuuljzbMcRA9qoq8I7v/qj?=
 =?us-ascii?Q?dJwKplgDRytBpwvyEO/t72SzCQzUuNnc8rA8YnUmHXikdjhnoQGbaC575h18?=
 =?us-ascii?Q?NNXbwQ9R1kpixfjXQXc0HkfwgVNs1/QN0HfQYOGlbQ6HalYsov4QjvMftkyr?=
 =?us-ascii?Q?tRL6dJICBTug61jqO+T8ZvkyITHzFEthKUgy/vCG5y34i7ga102RkXtZ0Q/K?=
 =?us-ascii?Q?oLiV+FA/pRcku3vreLyjfe37RJveWouyaYwNQCoy+gInCVCcStEgTqiNWy/m?=
 =?us-ascii?Q?S77PTpRver4EJo8sKw0m9RjZ37pqvuF3UegkgTgC/XO0FZ3bWveJbcqOsGqu?=
 =?us-ascii?Q?KjbTzaktTfQliRLoEm87uy6iovXazE70R1lI8fo5xqiI3gRmqo8FJH5LVIRH?=
 =?us-ascii?Q?+mdmqmLOJwl4wDQcel1MErTwChLS4yufPIX4NYgfFwXB0Baq4CkyugFT5+WZ?=
 =?us-ascii?Q?l+t98kAnG3o+KRFd+eEx/w5p2sU4/Aydnkpo/jXMNY7s72kM8EWMujjfttcv?=
 =?us-ascii?Q?38QmpD+n28MDzqJykTfyE3P+7UENunjQJMoLTzhl0uy2c/niuLT5eSd4MROM?=
 =?us-ascii?Q?bkNJJLkc6rkFFOvxajThrr3do26zLkFbs804jK1sWy8VR6LByPrOGux7oVM1?=
 =?us-ascii?Q?lcR3VqvnkMSCJeAHC2/G8q7CnMWVHcvdBSGKijtSyRqzWZzwOslUZHEVJhi0?=
 =?us-ascii?Q?CFWFfJZ86kmKKkDQUv0MsCB7K8pj8q5R3BUBZSfYKyq2r6U16E0ZCmg2FtfN?=
 =?us-ascii?Q?DEjMWWsdHp368f7Vo6d3L5kU3oPVDu+NtMEEH74tw9vCKNTMCumZDURq9Hnk?=
 =?us-ascii?Q?i3PwnaNG8HSgZSDm4DEgiwILi7vCnRa3z2VUqdvmJsiUiBENA9st9HEjdD8r?=
 =?us-ascii?Q?Fp0QsPWBP5wANyhLCSkPF0uM1lgXIM5GvW8TCWjrmjqhALv2Y1ks0EmQlDnV?=
 =?us-ascii?Q?KwPx7qIIJaphKobVWlVUoeLGndHyWqVceI0RnD3XC8RZgZg0eeDftMOTHiNC?=
 =?us-ascii?Q?V6OFIxwEke9XfTco4dRxJQ/IEJnu+WQwHOg+DAg3IlhW1ohPPPCuJoww1HKw?=
 =?us-ascii?Q?kMo4UA4xyxXVmVQbmh4SaDvgwicFUdVExgO2/YtrYGoGiV1A1zLt8FPsn6Lv?=
 =?us-ascii?Q?n5yvEEjo2fVrp2xoayPsmzqjy2WDYlQqZmj9Sx0Ee3qUDgwca4KHctXinVC0?=
 =?us-ascii?Q?cXcvixGBYGwq9B1bhnRKx79u2s2RAMXujJuLZs+ou9tkUYuiOtGY9zwD8e1x?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b343e05-a21a-406e-f693-08da861affeb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 21:52:54.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI4eWdZ4Y7+ik93Nszl9P8tDAQawO8vteuIYE6NEJ/SfX+09iYTAT/ByXABDKzmWikIz83yh6NHmmDKRA3Zr07ABzVc02NF02udS75MTmaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> This new function is a variant of mf_generic_kill_procs that accepts a
> file, offset pair instead of a struct to support multiple files sharing
> a DAX mapping.  It is intended to be called by the file systems as part
> of the memory_failure handler after the file system performed a reverse
> mapping from the storage address to the file and file offset.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/mm.h  |  2 +
>  mm/memory-failure.c | 96 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 88 insertions(+), 10 deletions(-)

Unfortunately my test suite was only running the "non-destructive" set
of 'ndctl' tests which skipped some of the complex memory-failure cases.
Upon fixing that, bisect flags this commit as the source of the following
crash regression:

 kernel BUG at mm/memory-failure.c:310!
 invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 26 PID: 1252 Comm: dax-pmd Tainted: G           OE     5.19.0-rc4+ #58
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:add_to_kill+0x304/0x400
[..]
 Call Trace:
  <TASK>
  collect_procs.part.0+0x2c8/0x470
  memory_failure+0x979/0xf30
  do_madvise.part.0.cold+0x9c/0xd3
  ? lock_is_held_type+0xe3/0x140
  ? find_held_lock+0x2b/0x80
  ? lock_release+0x145/0x2f0
  ? lock_is_held_type+0xe3/0x140
  ? syscall_enter_from_user_mode+0x20/0x70
  __x64_sys_madvise+0x56/0x70
  do_syscall_64+0x3a/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

This is from running:

  meson test -C build dax-ext4.sh

...from the ndctl repo.

I will take look, and posting it here in case I do not find it tonight
and Ruan can take a look.
