Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9626597B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiHRB2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 21:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiHRB2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:28:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863F7969E
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660786116; x=1692322116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6Mm+GQLztA13mwdG8ZGsrZoUp/hEizGGwURT7gGdE7k=;
  b=ahr6T2zkCNQ7ZaY50SwheQq1Lc+LKov11PJcoBt4AJDHyhoLpiue3a6Y
   LIpwdR0hm22P5mPGYUxe7G5KVG7oDOq+A8Vgm+IaEyhF/NAQDDdFRkWN7
   /+nuPgjptyZYD1ctYOxeKl0fowkobDztvS+fYSv1zKB357MzXAd3tN8eE
   m+duQenRwRsApwd1ypv8JMsl5H3Atb994FDLj5XTLD4rILYHoKRj7/aaR
   QyBkghhMlV7lMcuXAvWWyNgzmQncs8bJJrhqN6VBV6ReN9hAuw4rWI9lR
   j5Iusq5iihOoCweP5BiFOg+cl8EBjq4UAxjTyT7vRVUgsTrPV8CHdC+RY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="290208024"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="290208024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="636612589"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 18:28:08 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:28:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 18:28:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 18:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL36kBTM1bqKiRSTmtBIR5kJlCz547q2l4DLhISgu0LfErxtZaS4yCgec8eqhuVEx0UW1QLwsi/hZL4FNVn3+FjdiTu9Y2nHY+/MidglR8EQo/cx60mHOi1Tgdw6mnUBk61cGdZ+h/D45iDdUho8VcceWYgrDp5VlBIkX683QFvHG4AIsBIsDIaVjo4pCgKhI+YNX9Zbq0200fare52dJXFVWEuSkS9GQJ/k/DXkg82Unk/Q25q7VtSLIWJmd0+FalYAQ3/jDLztrCiu9w1M9/FbnjDex2O7HZ+tScHu9DK2oYmflY7HYSfIPv1XGMjnjq8fHXNv57tPZHgorjlylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8pxefYiCEtloAmgMAjWvDP/b3SzvbYvq2YDYWRiQnE=;
 b=d/Awc0e0IYnZNAzxeuyXUXuqFgidgise+opO0c7pFnJR2cHWaudOjFlx69yvYay8QuWlWF3Gd5NuUg1kZw5fz+tM2HOyILuArzfz20N4ixpAk9gtEwpZ5Lz3auISim9GiOHSAoMpKWUH3BivbjRRHRZWwYqb6zS6XqLPw7bAAG2AzcbKzWc5PUSpLVXwCQBSnsFGPrZp1+xfGzIhHUrTnSsyVSXtlDWjmLz7/6BbNSJ4KqC1sVXCJsMLXD1hDjYTZE46zrIGo3C5eFzAGiPQksxJ3ibXPalgtTXZQez8cmhx3WxScuzUTdWjdvWuiM6sVrz2XWLmu/DEdN6RbbV29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MWHPR11MB1821.namprd11.prod.outlook.com (2603:10b6:300:10f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 18 Aug
 2022 01:28:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 01:28:05 +0000
Date:   Wed, 17 Aug 2022 18:28:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: folio_map
Message-ID: <Yv2VouJb2pNbP59m@iweiny-desk3>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
 <Yv1DzKKzkDjwVuKV@casper.infradead.org>
 <Yv1OTWPVooKJivsL@iweiny-desk3>
 <Yv1VETRRT95mV2d3@iweiny-desk3>
 <Yv1ezcVV62w0O87V@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv1ezcVV62w0O87V@casper.infradead.org>
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d3b97d-4d96-46ea-4eb9-08da80b8e694
X-MS-TrafficTypeDiagnostic: MWHPR11MB1821:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7S9/ZRdJxLhsFKWBrN0+0eRvmrH5626XIbr8Spjo4qj7HI3oKGEfmApQ4DJVfZVPWovWETG7MrYoQzTYozShXVIoTN6vhNFCwNsIZ6eDGk21n6qasZ4j/vK1lD+elxEhGJ16VkS3iBrlGqWKZdFnxwSJmIRirZc1RPVSSFT+rHqxs5g8J0xj6YFzlRaGY83pmZzuubsJZBm7+uoSvOi234ufrqr5Rg1AbxSy7pfiWxMhx1cSlRQabnnixRR3eS+HhIZ2z8PS/mEiiv9QpoaQ/Xd7IxKV6SGJrhlrOEzzLw/smCuYgFVd/tVVlSVcEJOSp7pq+TZsgUn+YlilYyLZNNyiMxPMRettceRoN1xRg1rM8uD53U9gsWKX+1+evKH6/4f5fTjc3mYo1Fl6iTp5PtsOP0qakbgibv33nuckZfmteCHyKKHXYRczB3qwQCsPFEeMLsTqAbU15gfTtjqPHCw/vnxjl53aeA7TNXC+xpQGQ0wS9ORq47BRlZF4X3xS0q+eZ0pvUWp12CFTS5zoYkcMNV61yJx/xtqGuC4B0lzC4PYBsmIU1IMOgalQH0kvQq1pRLUqUoaNi7EG/x5+8xDfmXkM1uyNhgBvMOWYFHPMtcwNWTw7ziJkAzR8xSr3X4AXl6+HIANPNxFEDfzAFm32YB8+MEpXagcFeZw38QtrpKgXLdHYOnbYSFBQoiSjzZiH8DY7T15J5gKD8Y0Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(2906002)(5660300002)(82960400001)(44832011)(83380400001)(186003)(38100700002)(6666004)(6512007)(41300700001)(9686003)(6486002)(478600001)(54906003)(6916009)(316002)(8676002)(66946007)(8936002)(66476007)(66556008)(4326008)(7116003)(33716001)(26005)(86362001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62qIZ50H/GQAonQ2TvLpRD+eVYjhk73o8GXbdLGL/Jb7bVasI0O/t3qfn9rW?=
 =?us-ascii?Q?g1Mn7+idJ+uDK+Oz+O4FpF8bXYZE+oOGmUZUDeUfEHV1HCFFBpfLs6Wgradd?=
 =?us-ascii?Q?R5xya6J7rEZng75GccWBzbFSaMQ3fyBiOgn2iA5tvgFyydWVAJwLHajomPjn?=
 =?us-ascii?Q?3e0kAXI/a79RF0RWQ1JxwoFNx4WwC8zaGeCrMjCtQ7m2DRhuVUm1sZMnR7Pm?=
 =?us-ascii?Q?/C3dS85K1iTMHhO25DqaJA+KcKKdp0X2oef9yZ+P44cjBpOthPg5l/h950fe?=
 =?us-ascii?Q?y4mhrVm5W9wRyyk/18z1pn8nI2PCU+UvbHhU3wpegyhiqX8WI9sMwynLVaIJ?=
 =?us-ascii?Q?o4zWBiN5iWadl20IaiESVcMBd/QuK4KygNZqZ2t6M4qBYvsq78gwY+wP2ilJ?=
 =?us-ascii?Q?6+U4QgRoDXiE3pjLf75b3CLcAGfdzALX3OflXpJDE2mBlFC04jzLj+DJ4w00?=
 =?us-ascii?Q?iTYfSzdMgPTnsI+7z8RKbsvm7eu1OguINJMxAppJSaNzM0bmRWR3IygR0rk1?=
 =?us-ascii?Q?lH9izafcrqrpYRTUeppwtJkgrTewLLQkZ++6Csh0BTUMmkSk96LC2OjZrC9S?=
 =?us-ascii?Q?WLoTkQlAcE89W05wErPgywRQYY7O7wYDzTEOP97Qc3bK8N7HVeta7Kf0GEwH?=
 =?us-ascii?Q?woAqzs6bvgplNq/dh/+gjXGC/m3lwEwM5UIJWFiuw3JrPzl9ZQD2j0ZhZbYB?=
 =?us-ascii?Q?qpggsj475mU2ADuViA0fGBmn3HqwBdkH0AIkWH2JgOx98u1uChjyNTg5YS+j?=
 =?us-ascii?Q?DPZtiflvUdX7Gax7QaEPFcd8f/rXlaq+fbrOz45wQ0TILVWG7QEUzKk5eDRE?=
 =?us-ascii?Q?dRT8EpGQdd/y9gnpXyIF0eCDpATX8T80mZiEoHDHcu52z2s4aqwRhMxoqOiP?=
 =?us-ascii?Q?hb8uaO1+1S3kOuXy2kdwoENJpyG105NtEKqXGssm+SblX9iVKyVPb1dqMJSC?=
 =?us-ascii?Q?aqcKNGOUXGD/0XjgHHmTsIDp1iJ+8mPFULP42RhrlD7xpN3NeWU7S+NzoFO+?=
 =?us-ascii?Q?WphdqRSC/U/5v2gimctuHGK+ysQM9D8wt9KATNjicLTe6L8nvbudhUUh+sen?=
 =?us-ascii?Q?JPjYSxeW9GP5tYn5yeINkSQQfyQbuIPW6Nng6a+gWCUNkd/twPyWAyFczKHm?=
 =?us-ascii?Q?15t1jor0Y7i7+en9Zhufcz1mT5OmB5PmU0g6M8et+petdE0Kuu1Sj1HCsAsF?=
 =?us-ascii?Q?7zGxKeLc+WSD0ZBGBbd4kcO+mzeTIZGVbbiyaA5iSc3B5lGwagZ57HqAuJog?=
 =?us-ascii?Q?GNFUoGMVzG8/YRIrIUmNVWxzmoBektCnYCq3Nqjq4SAeSIlfumf4QWEKmY/7?=
 =?us-ascii?Q?HalQz9eiD5ooPEbeKbmeMNvVtYa5SMaIbDHY2ciyGd+5CdNjGAWHsAnVCR0y?=
 =?us-ascii?Q?Apg2i7oXCTGjeqoBAx7BpZnzq8s9QpUW/L+OQqGp3p9qasC+P3p2i9Pgm1Gf?=
 =?us-ascii?Q?3JCblhSkZKZQKuTK4TQCVQCM9OPKFXorbPMwzyFSVakU2UzmxwpKoTCIx8nu?=
 =?us-ascii?Q?Tn+2rLEagUcl9CVeFZu92/xVzGDJRTga3E3d8Ho1+ef3oseEP7fjVUO+weLC?=
 =?us-ascii?Q?vtcVzmNr8qu0X/JySt1qHNMMNTEmB64slaCOQ0u2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d3b97d-4d96-46ea-4eb9-08da80b8e694
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:28:05.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z74B836s/RpssnNJg+OLOIxD2WLZ4rH4v6Jr0qAguB5WAF7C5pvdVp8zqNURoFMi8n79vi7yaq4w+lMLefro8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:34:05PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 17, 2022 at 01:52:33PM -0700, Ira Weiny wrote:
> > On Wed, Aug 17, 2022 at 01:23:41PM -0700, Ira wrote:
 
[snip]

> > > How many folios do you think will need to be mapped at a time?  And is there
> > > any practical limit on their size?  Are 64k blocks a reasonable upper bound
> > > until highmem can be deprecated completely?
> > > 
> > > I say this because I'm not sure that mapping a 64k block would always fail.
> > > These mappings are transitory.  How often will a filesystem be mapping more
> > > than 2 folios at once?
> > 
> > I did the math wrong but I think my idea can still work.
> 
> The thing is that kmap_local_page() can be called from interrupt context
> (how often is it?  no idea).  So you map two 64kB folios (at 16 entries
> each) and that consumes 32 entries for this CPU, now you take an interrupt
> and that's 33.  I don't know how deep that goes; can we have some mapped
> in userspace, some mapped in softirq and then another interrupt causes
> more to be mapped in hardirq?  I don't really want to find out, so I'd
> rather always punt to vmap() for multipage folios.
> 
> Is there a reason you want to make folio_map_local() more efficient
> on HIGHMEM systems?

It is not about efficiency.  It is about making the callers of
folio_map_local() not have to worry about the context it is used in.

If 64 entries is not enough how many?  I'm trying to see if there is any bound
we could reasonably establish?  Even kmap_local_page() _may_ run out of
entries.

Ira
