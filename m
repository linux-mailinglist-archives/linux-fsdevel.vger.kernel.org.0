Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A854EC78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 23:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379167AbiFPVXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 17:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378999AbiFPVXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:23:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BEB248E3;
        Thu, 16 Jun 2022 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655414584; x=1686950584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lxoo1CWEFbOsadOkVkKpZ+ne4Wd8d/42gZd+pwBprYQ=;
  b=JDcEnwz7w3yiA2d/0LuKWj7QBGJJuq23/Yedwa+ArhOkpq4ex2SWwo7e
   p/9rDjupW5RT2y7mrwdVhZQusg5Qa7Km2tQtPe8U9fNLSkBzx9bi88xzJ
   g7H8EgkZ/t0DyNdw7e5XmpeoFa/vw8aMFEVbaZcKnPITJf2gEs/KYYcNf
   1vh4iHHCWQDa2z/EHex0pviGgu56Nu0IQOgGDmTWC6oNvNlyNgoTZX5aV
   jr36lC59Gy326YXjy+jjveqms8GFxY7xC3JTxviH0X1GogmodTWO82PZc
   jzOuIU+zrMSNp10LbFa19YpAUjh8uym3C4zBjgmelRQ/M7MSI+gSkqSd+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280069519"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280069519"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 14:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="653337977"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2022 14:23:03 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 14:22:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 14:22:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 14:22:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGTGIKNfTSSnD47lvVrQmWghj98/Zgm+yrKWXmX0DtpI6CtvmE2JYwzDS8E1JSASpNePP59+9StCTWR+vU+9BSgU65noaYWWTRZGqQ6zd4KhFO4Py2ZPr33W4VDnwCF0LMoRYB2l5pi88dOQFsiYmwl1mgsDBsnE+v0HhuD7rYwZEYAQ99Uho1yQfhO3z2ZAFSzXxjZlNzIfSwjdcTjBeaRRvSILIcQZA8I3DzVtKAuy0YgGP/RIZgxWRkv5dOzTrn9TryKvfC/RuDPKdlLKTsBG4fgaJ1oYXlxgTVfCSGGiABUeHOUlOFZ21HLjW6/kBdvhYR9dxOOEPGQjmpRw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRSbHdbJt8rIojAfpJT80VoTGgEb0e9W7kfQhz/cEw4=;
 b=D6ZPH5AQBZVtH5joxZ5M24n8N7zxZFSOjFzH37hMJgJbOnaAOuAtgtALtU/BH+eNZAB08uPrJUpwbWXsIoK3dCzd+iZgcew15Bqt+ZWBoX7birx0wtYVpVMFSGO8bFBJoPZ4gY2dmLuKVkp20OIU+QyxBVVWSXNL5p34amE8pOyDqHoJDynKXmbF9gY2y03fXO6f+vKapugpYBwQSxVQNgdI4w1s8g67BoKadp2ovDe1uvxwNm/1c3CU4yiNaI/aJYHC/KGweqIZ/lLw3uNTmZQ3hExIO4sRdkGuYQWkVEQn/n2lE14mh42dPpdokJI3DXm0tHAq8p0sta2B8eYkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6212.namprd11.prod.outlook.com
 (2603:10b6:930:24::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 21:22:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Thu, 16 Jun 2022
 21:22:56 +0000
Date:   Thu, 16 Jun 2022 14:22:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <bp@alien8.de>, <tony.luck@intel.com>
Subject: RE: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
Message-ID: <62ab9f2eb6456_734c32944b@dwillia2-xfh.notmuch>
References: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
X-ClientProxiedBy: MWHPR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:301:1::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d1d050c-28a8-433b-412f-08da4fde614d
X-MS-TrafficTypeDiagnostic: CY5PR11MB6212:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY5PR11MB6212215DE04D27DB3AAB253FC6AC9@CY5PR11MB6212.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJrhUYxwTaAbuURQD80A7BwwcO093ZvdMBagHxzYZnXSX8X15IB+iXbkRwS8W4/F235B4lfP0A627RAcRZY7q+bOKknq8Y28sc8Sdfm66Y9zw1vm84EaN2kX+A5nOkxiuIF8tWEZFb420TkTkrlWJhaA/cksFzI1KyblBlqeeb9VHNwSqa38kbZWx3YPFQcaizRzy86G8Cm9X5cb+j8ynqm+L0RryDrNdWpy/T75mfvZapF9fv+sWfLjFVMfauuR001Do1WZU7K8Yg5cKdICCK2ISVE4yOcfYxCn1sIjAPsTKjNmrpG6lRv1eM8Ie2f/3KLD/BuZYDEtkGwc7QEHwzSUGi1CNKa6qBAhxIRlDueNk4K0k3/HHF1Ff2kbAMVkSxygVrIJmJGCPFVE79XqvAMwlxZALCqhjhGPbUC8Wlkt537o+fr15lURLgk9LREYyMcupXREYtiC+RE558gR9ws8JsXu0EZQBvlfuXZLuKR8HoDAAiArKUCrBOOOagUIuSF8nNzpCILMTcjv7ax4Er/fu/hYxp5th2Qrhn20DniQr3MFed2HYGS/dIfP7s92bJErxQpo3JoCSF24dvR82jXsmkf/KqlHLeIolrjKA7TLGNzp8SIeT6g2L4so0pz+V6CbqR3jFgE1vDG+e/9a2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(6486002)(82960400001)(107886003)(508600001)(83380400001)(186003)(26005)(5660300002)(8936002)(66946007)(2906002)(9686003)(6512007)(66476007)(4326008)(66556008)(316002)(8676002)(38100700002)(110136005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIB1+rhi997KX57LiJrZ8i4Pj1fZGza3yirLf3vSPH1KCZTHychFJutJY4Ma?=
 =?us-ascii?Q?T2/4ZSTHtdiSA1VgPMSj+INdQ2ULiCHTfo77u32pPI8Oo5yd/5f3eekeZy53?=
 =?us-ascii?Q?5ZbdDWHlzZAbj6uIpJLrK3XHQORVYV/V2rX0qPLPLZ69VPyCx2IEpR5v0SBk?=
 =?us-ascii?Q?0ndCt+6DyKL/x58XWTprEDwM14k81qsjx0xdw4RZB6DM/WbEJIDWFQeG8/W2?=
 =?us-ascii?Q?uBsru5T1E0AwIw6rhObGgUjGA+wZHbOrlVCdrw320JXbBvLjXJxBbNkNcHRC?=
 =?us-ascii?Q?VRHsM8rgrB5fnkYTvT4KKXnC+r15526AA42nk9NPUA8H5jLR4qynCDLzY8oa?=
 =?us-ascii?Q?5b4jnIZBNpePuMNtME0B8/MnkecFNBIVJnVXC2lcvIA4sgSCUdYsykcUjeWH?=
 =?us-ascii?Q?GT1uM4hw+eEMtIDFP9IIDHByhhL7Rn/pOPQ0PxVWKvE7n5UxeBS55JJ2GNY4?=
 =?us-ascii?Q?Imv8TDtfNqIJQf2ImoxiuqXM1nHlRE15jq+npwdxJktEIafJi6pF8NwVBOIZ?=
 =?us-ascii?Q?A4LhmMG9mjL13VZEtlzbyUF36SVqtJSgEu55YlkKqul1venUSqjsYWamtdrt?=
 =?us-ascii?Q?uz5exPe37z5JGpdFy6EjSpzJljN1LFcIPafM7vwKt5HnW2Y1kd819wsuGa3H?=
 =?us-ascii?Q?6IirN12Y2jz6Ib/31Yht9SgeI0vbRpRgh5S2jZTo+TJaRSmnXebQFTdqOF8W?=
 =?us-ascii?Q?ChDI7n1j9Vberx/DXF4nOpmp01kb5oB0pkDAI1/70EmHskH/3bm70rFTRT2a?=
 =?us-ascii?Q?2An7zb+bRKinLB93v8d39IYEAlDGem202m5EBtbpsboFKu0mMm/oDMHVJIMb?=
 =?us-ascii?Q?b12RaIzlI2e7mi4E/3cM0xXcSLcKXVHZbZe/YILEv95d+NcDVnyLKpNYOWc2?=
 =?us-ascii?Q?rdNbfOKVkZ7dZ7rMXBzCFcD+KVV/uy73atQqx6SKJbB20ScSLXsLt6N8pCWh?=
 =?us-ascii?Q?2duAWGsMIZ03b8kAySb+EpZ6DxDhy1vzcuUuua2vZwi8XB9vmBKMjN380zsa?=
 =?us-ascii?Q?8BaNZBNn5VLxMUUtQbk4khig8HsxBXFHBYrall7jEqxeKVY9E8UsVDCDqpzi?=
 =?us-ascii?Q?9pl5jCECV6X+eAbYUoQEbz/tq1zZ4MduOAqx5mGzM0CRGVGtM3R2vmHMoC5j?=
 =?us-ascii?Q?7YXIZuhoUuFNrg3Vwl4hf0YS2dwjFJ9Q7nlyhdvx8Xz/5T9taHtNug8CwRav?=
 =?us-ascii?Q?ZQZL6OoBHaase4JsW2BOejgJtZljpCPkIkiy4Dd4Xbug528eXGF3n1DQIylg?=
 =?us-ascii?Q?Tjr26EBGCoTMbw2gd84JqsF5c99ZKB5yQ50jy99vzawfh+EjOqJDiLge8Uar?=
 =?us-ascii?Q?vdrptK75Oh4LKsigqI6xl6xhg/5YKErw+p6PUSXo7KFV3AOFBCE/rUVbAx4D?=
 =?us-ascii?Q?aLEXjI3lrDvUFo3e0437uMw+fjSgsK1hnILIBJcZaPvPN9LVQI1T6mCEwF/P?=
 =?us-ascii?Q?rauHdI77/D79BRpHqbuXsZT/tgA59YiKWnwhjhcVTM8jSOyWSznQoIqTMmja?=
 =?us-ascii?Q?S458eF/S2JJ63sEKjeN2ecY4UQn8y85oo3lRVOeTXNT7V6cNX1WNILuZy244?=
 =?us-ascii?Q?j1Gfhxtye87312Wx6ZIDPJcckNTWGIvLr6Ntjuf3TLvCaPzTFF55SW1PD4pB?=
 =?us-ascii?Q?8Ou75dmO/06PaQNaYZxTgfZILl6JYRkwZjEjuZzVmmWWCoob8PqOp7UcLHut?=
 =?us-ascii?Q?/qgaYwl9PY791vSUJRABh2wGCLif4jO7IGAkGZfpJLMZvTu7o0eSrrnMeABM?=
 =?us-ascii?Q?XU33VIeKDaECGCLbhuMQiXXQze5U0M4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1d050c-28a8-433b-412f-08da4fde614d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:22:56.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+JQBgcWK6v96Ai+5Ce4ZfF4cAp1s6aT67L4YrmlMwUH4cgkwE/d0SmS+OFRoj0OZGClU+BkFRZA7ZdzAwv4jpke2uZ2PrpBYbu0uCv8cDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ add Tony and Boris ]

Al Viro wrote:
> [commit in question sits in vfs.git#fixes]
> 
> Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> result in a short copy.  In that case we need to trim the unused
> buffers, as well as the length of partially filled one - it's not
> enough to set ->head, ->iov_offset and ->count to reflect how
> much had we copied.  Not hard to fix, fortunately...
> 
> I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> rather than iov_iter.c - it has nothing to do with iov_iter and
> having it will allow us to avoid an ugly kludge in fs/splice.c.
> We could put it into lib/iov_iter.c for now and move it later,
> but I don't see the point going that way...

Apologies for the delay in responding (reworking my email workflow after
a loss of Gmail access for my intel.com address). This looks good to me:

Acked-by: Dan Williams <dan.j.williams@intel.com>

...and I also share the concern from Linus about the lack of testing
this gets outside of systems with the necessary hardware/firmware to do
error injection testing.

Boris and I had agreed to remove some software error injection machinery
for copy_mc_* in commit 3adb776384f2 ("x86, libnvdimm/test: Remove
COPY_MC_TEST"). Is there an appetite to see some of that return and
write a regression test for this bug?

> 
> Fixes: ca146f6f091e "lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index cb0fd633a610..4ea496924106 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -229,6 +229,15 @@ static inline bool pipe_buf_try_steal(struct pipe_inode_info *pipe,
>  	return buf->ops->try_steal(pipe, buf);
>  }
>  
> +static inline void pipe_discard_from(struct pipe_inode_info *pipe,
> +		unsigned int old_head)
> +{
> +	unsigned int mask = pipe->ring_size - 1;
> +
> +	while (pipe->head > old_head)
> +		pipe_buf_release(pipe, &pipe->bufs[--pipe->head & mask]);
> +}
> +
>  /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
>     memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
>  #define PIPE_SIZE		PAGE_SIZE
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 0b64695ab632..2bf20b48a04a 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -689,6 +689,7 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
>  	struct pipe_inode_info *pipe = i->pipe;
>  	unsigned int p_mask = pipe->ring_size - 1;
>  	unsigned int i_head;
> +	unsigned int valid = pipe->head;
>  	size_t n, off, xfer = 0;
>  
>  	if (!sanity(i))
> @@ -702,11 +703,17 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
>  		rem = copy_mc_to_kernel(p + off, addr + xfer, chunk);
>  		chunk -= rem;
>  		kunmap_local(p);
> -		i->head = i_head;
> -		i->iov_offset = off + chunk;
> -		xfer += chunk;
> -		if (rem)
> +		if (chunk) {
> +			i->head = i_head;
> +			i->iov_offset = off + chunk;
> +			xfer += chunk;
> +			valid = i_head + 1;
> +		}
> +		if (rem) {
> +			pipe->bufs[i_head & p_mask].len -= rem;
> +			pipe_discard_from(pipe, valid);
>  			break;
> +		}
>  		n -= chunk;
>  		off = 0;
>  		i_head++;


