Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BB5A5A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiH3D5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 23:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH3D5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:57:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE59E2DD;
        Mon, 29 Aug 2022 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661831831; x=1693367831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o2KLwuHiZALE/Xa/7tGWnIgQagrpbzVuhDDeoe5nlEY=;
  b=jRrnG6UGZyPX6fh8YVbMPXwQy/6c9iB++vUuilIlGmxTFo66fnL78kDp
   S+/KXo3gDRC+WeRHwhir+q6KbsdXvKTeClk1coeBfyPQV59VWbKZEcT9t
   ucuF9oXAGGpoFU+Oz5t/pQLmoM9/N0Opt/xK0CYmjhcPNpKoj9Xhg+r7s
   FXveXkZJkNlImynvCP189V5WU8k7720SXZ6/LVRJJn+yPZqy7JRd8USZD
   P7e37Fiw5N21nvZULjVLOHlrK0EbUBC99s1dOdnLvdC0fCLbhb1mHbvow
   BGMYtA5xiG4rvplE2nZAb1DFOYf160RJWgtFXq5G/C/cybo6rrp3VocnD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="356788390"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="356788390"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 20:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="939849809"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2022 20:57:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 20:57:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 20:57:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 20:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUuut5N1KPZno1/0pJbFpg2QL/qYP4DIS8tlaiBekdN1pq1Nix7g9mi1Tuzaj8Lvr48LvWjbuWuwDL7UWzVjgp9GnFtG0vpBBY8oIKMAoX+a8peA7J06W7gRwSpJIUt9MtI383u24H+RKMgaPKSd7KlDyczSLRQS1ACXStFyQVbu6yHkPbQJsDscYwmIDlGM+0oC/NyaC+q2P6rYRmTGSxdRgmhQEtx+qK1HcHiiqBykmxdfRLaqnOJCzdE6ijamUPIBsQ2UW31LLXSH38VVq4iiVx5z+z4EDi8XM6s4RugbajLO0j65mkBvSBeArJPdclpusRSfhpIoxE1eTi8iOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEgihtSOQabcHWOM6VIlC2pdPQvq6PcobkftZdgxqx0=;
 b=d4QcyQbcZHAACPXIKZeRJx4d+NogBgm5w1P+3bq6KfnpdiGDEewlN14jvsoe8jOViqsix5KqLeibRSVJfYIUG88zYT7Rfh1xl1WcsUX14uiSkidInTAIZlhZ5b76ASsWXan6Kcet4v7fJoAE8aWrbaWv6PKxtWRSsMqwOjj9aaso26fbEzTf9Uq09Sru0/oQ0zu42bdDM3LPMz4b2eM2hvGgC/PKnAXrR1/S4hV1HStoRKbVB+8xrOQMXRKExRbxa1DAey3ysb5aPkmI2kY5asfvFz67+lZAHQE5KhPYXWF+GEac187s61yfFcs6PtXCG8vkmw4lkqAj3jKO79+hrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2723.namprd11.prod.outlook.com
 (2603:10b6:406:b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 03:57:08 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:57:07 +0000
Date:   Mon, 29 Aug 2022 20:57:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani" <riteshh@linux.ibm.com>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <djwong@kernel.org>
Subject: Re: [PATCH 4/4] mm/memory-failure: Fall back to vma_address() when
 ->notify_failure() fails
Message-ID: <630d8a902231b_259e5b29490@dwillia2-xfh.jf.intel.com.notmuch>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
 <166153429427.2758201.14605968329933175594.stgit@dwillia2-xfh.jf.intel.com>
 <76fb4464-73eb-256c-60e0-a0c3dc152e78@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76fb4464-73eb-256c-60e0-a0c3dc152e78@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 756ae756-562d-48d1-dcec-08da8a3bb557
X-MS-TrafficTypeDiagnostic: BN7PR11MB2723:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddV+hDUuC9Q4DZN9jkRTFuHqQHLQ2Ql7JTzwNkOOPdBKPgqluS/RaVg2Kfw1ebynHwHC321aP6oakWrh15tXtBVjVECzK7mikjwqpfU8BDDsUf5XPJVNYx7onNVms003H3CvkEQvdjFULev6UuBvyXcVoUW7iSIcjUVo2FhcHke8PaIpYkXLMCe0//YXfslrfPyrSx5sOMzT/3BuoMlcmorlYdpMTSLMo/oyAl0fqf1vXq16mUhhtPkHsXWAAVAkDdx0duxyW59R/Te0zkwvvMOvMo+pBGSwJ2JCZDCFkbMDSqCVkw54wMu5ym4mQkRwtySlwmbAfEjUNzKG6AUDJacFRpSERrjeTGOd8op1aTYzBzfpVbGC1FWxouCSWO5l3zmh+LoHjBS4O0QGmJnw18vFrB6V0GddiSvemBk1tUJDtrOXiYUX4IG/SvAz+kwxdJdJ54oTcFF3paKcDBP+cg4kQR2QllldYeS9Toj9SflU62oYbptK+E90R+LfoXqtaKMI/wfvvk/ULkcUwRp8Lz/TyVrbdahVRSgtIMUdz8ltsU1Cco+TbDafobc4mTolym3N/d5rFmhuOeJsJp8MXOBo5INbn+zQPfTxVsCT98ZB0UnnoNhmSFBHFseMnjKLEfxSM/ydok3rNWFCn/sHRzM7PX8BgBNJV3xRa1XuVmyC025kSZ02doWFOuhIw6DxryMKgfFG33lukcBQcfc1O0eGR6uBAn0FPpyQcJzf+sCXX8aewgok6M/EzeEtWeCg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(396003)(136003)(316002)(110136005)(186003)(38100700002)(86362001)(54906003)(82960400001)(83380400001)(2906002)(53546011)(41300700001)(6486002)(66946007)(66556008)(8676002)(966005)(4326008)(66476007)(478600001)(7416002)(6666004)(6506007)(5660300002)(9686003)(6512007)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MERBoRt59Pc8sqEQvNnzbfSaCWnAat0YXm5MfiH5rsqiWB2IxkiMrLsdYOk?=
 =?us-ascii?Q?2b7DuH96WjDu3nYQ2PZN6AOBKoWQ0QPZdQd4pXXalsamOgX0yYsVJMmSPQ9J?=
 =?us-ascii?Q?QUrEfuvsbr5MZDncrvs0f86ucNukOT05eE7nMKAC/BrgJL3dZp6sNhk9NS9E?=
 =?us-ascii?Q?JQ5BhJN6+eoX+88w68J2z8+GGT+R8tYNYLgLVh3dsIuEGd4tAVAPJaVOkhkS?=
 =?us-ascii?Q?76yqRDQEb/jiA8cAQ5FbawsNaI6nyYdS3n7Mo7cSldHlglRSEB6K1qoh+k6e?=
 =?us-ascii?Q?ueQiR+IMQKhL9ae7IxciW7sFBYtzm4Y3BubUz3W/ociyFHzpQU4xC8WTzP7n?=
 =?us-ascii?Q?u+V5o88LvoZtW5jaz8qS9vnO8btdVHkmC5nw4WxT1lStlUqXoY3mOLkpVyFr?=
 =?us-ascii?Q?kYaaZ7UL0A3vHeSlryPCK6QpXMrPXLXlroLdwY4pT+F3NWu+Dl6A37KI42Gg?=
 =?us-ascii?Q?VoFcf+StEcJ+u1BOha4mVcklAhqGGu8W/ujyRi5w6oSpb4yyQyu6aVSx1dkG?=
 =?us-ascii?Q?PSmj+VhP8ZkMSlLAKRx0GqBoQuX2ukQndTO1JSNAAxyox3+QUprfkr9tDKWY?=
 =?us-ascii?Q?s55eoztXVCaYlt/+ILsUc9XphxuGNFEzcTC75zBq/ZzfSJxK6XHQ7nVTOJb1?=
 =?us-ascii?Q?mppu9CHIVQrmkdwV/OJfW7xkjqubN34x1fbGzdv32FHthv2bXnsEm1+jO2VQ?=
 =?us-ascii?Q?5W7h3T+B/5/BiZoyitOPEN6xzJP0s5v4PlcE6uiGX1pOT/UnuKGIUR8/GZAa?=
 =?us-ascii?Q?cQavZJw3/dDZCiVTz/y9lvyFp21/ei1hE7jdVVpcGKt1/NnTQbPyJC6VAPRE?=
 =?us-ascii?Q?lxqcGxPu97zACaXO9AIuiNoSgIUiLGMx+GddJYnW4b1b8+aH1/uZLLI/FA4C?=
 =?us-ascii?Q?8t2wXAC7psL4RuNChEATf6GzLzjcqYIu1kCYuob7suBlv5LCl8qKFM9vu7wu?=
 =?us-ascii?Q?Q5xRSm7Rt0/XT4moV3oK5VIBt5e4LpmOLVj0ixfleZERq3/zXcWC/H0Xo8Oo?=
 =?us-ascii?Q?zcGIClMMS92KETYkgiVVmQgqcbvPb4pmYlvYdEfJ8IJlSYilWbVmaDqebWEv?=
 =?us-ascii?Q?klxrrSHyu2a/ZlEZG+RlfyuQaSIZWylsCPw7sSgIB1nJL/J2O5k9fPvMjm3k?=
 =?us-ascii?Q?ZhbQxbwAdddb6sNAosCgcXAfByA3jA1ltXMqfaI9/Hupo5b2JUgTlk7p2bOV?=
 =?us-ascii?Q?v7+ADTQw7DcSdQUr4byI72nrWIhVIOhtuhO4qWp5v8v6PARqQh4fx752knaw?=
 =?us-ascii?Q?ADcdVAcpE/SPF1TLOrOG7doY//fu4yt/a/wtDOdolLgOIhYW+r0npIT03PvY?=
 =?us-ascii?Q?NiWLbn6d2HLAs5MYKIHAXfNDccoJph0KeLAF3TKtnWtEohouI70YKG/xffeb?=
 =?us-ascii?Q?S9ApDkKukWN+4GdisCu3ojrRa/hqWrzcHYRQ/R0g/8VS1OCLxMOH8XX9pNjk?=
 =?us-ascii?Q?VN2Sxqs7WzkPam03c9Qs6J9pGpeTvhCGArLhqyLvqNx0uOGtH7HG+FWOMMYc?=
 =?us-ascii?Q?MLzGI06f477LK8+QcO8CsAFYGO9cbhofz483MukT2edj1bROR876SHYgllQT?=
 =?us-ascii?Q?xmnXoktk/aR1Hix8FC/g5Swpyo6Ij9fWrprFLJ6LEWLCUCi6qGz+bcUu1ZNr?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 756ae756-562d-48d1-dcec-08da8a3bb557
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:57:07.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpyL4pAsjiRjpzzEhxE7tNzzMSInE/NneS2Bnogo1blG6VTS3JYoL4+nwfqMgCy8VN4o6OqAq+XUHgAgUIOMJxL9bAfFZeIhNNmx3rxI5LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miaohe Lin wrote:
> On 2022/8/27 1:18, Dan Williams wrote:
> > In the case where a filesystem is polled to take over the memory failure
> > and receives -EOPNOTSUPP it indicates that page->index and page->mapping
> > are valid for reverse mapping the failure address. Introduce
> > FSDAX_INVALID_PGOFF to distinguish when add_to_kill() is being called
> > from mf_dax_kill_procs() by a filesytem vs the typical memory_failure()
> > path.
> 
> Thanks for fixing.
> I'm sorry but I can't find the bug report email. 

Report is here:

https://lore.kernel.org/all/63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch/

> Do you mean mf_dax_kill_procs() can pass an invalid pgoff to the
> add_to_kill()? 

No, the problem is that ->notify_failure() returns -EOPNOTSUPP so
memory_failure_dev_pagemap() falls back to mf_generic_kill_procs().
However, mf_generic_kill_procs() end up passing '0' for fsdax_pgoff from
collect_procs_file() to add_to_kill(). A '0' for fsdax_pgoff results in
vma_pgoff_address() returning -EFAULT which causes the VM_BUG_ON() in
dev_pagemap_mapping_shift().
