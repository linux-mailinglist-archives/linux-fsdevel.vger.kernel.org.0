Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B60072ECA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbjFMUM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbjFMUMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:12:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D01FDB;
        Tue, 13 Jun 2023 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686687138; x=1718223138;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sveSEHLy/iewONSb1ZTRM/SLciV+z4wONMUw9zPu5QQ=;
  b=ljxX5x8koTqamY6c1VI34HGgRvFI/vMhlzImzxeJsW/qkObB9QtHocpu
   GGrrnJs1bXftje6wkBQOOkbVANKdLQ7j3GbQeBAxSDVXcg3urTqOGMhL8
   f9NfYj+sY+1e4K5S5CQmWfWs4bCpyb463W1xqejQB3RAJsfzyO40b6I9q
   PWXOA6oaGtnYEChg5Qb2h1YjMK1YO2ADIIKZoEN9MxD54TuXbkKZCd6JP
   W6XqyY8JXpYX2baHs74F1WXmqzplxIpe4Pj1LEoHzViIsZDIOTuXU0KwW
   j11KccFnQTpzryULt7eI3Ccb7LUwWNRxEYamirmesOGBxenE479FUn0z7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444813783"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="444813783"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 13:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711780429"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711780429"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 13:12:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 13:12:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 13:12:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 13:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyF+8qm1rvky2L4IWLn6qQx9KOpKyjab/Uk34EOny2LCmbyMz7V99Yq1Vuut9u2uYPgFfouGo/xN/Z/s5OTlOsGoFuPt0gTX18CDxL+vpjHAEHoKhaUxQHJRWwvc03yV0zRuiai3OYo5+huu4+lk96SFOejgSIfSxI182FU8npXz5TlZSVwRBGkOfb/qsR2nibkAUeZpy4gQ6fz+S1IKzrIY/w2kvM5WMGPHsF+V2NQIwPj/p4jm7ozOJCw3os9RQN0dmICvTWdMDHbONy7JqxX3oL1kD4/p7FGUIAbT9ycKwa1TgUOLTgFNJXSeDxKOy+HGQgLwEaIMxuoUHbJnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mdBmAu04T3XzBwfI9QatE5lQybJ2Rj9+MyHa2K4rSk=;
 b=UA7mVybW5kHsJnE9SK3XKQ8RgsoRSHdzNE+yJQFgDsmiWwTSXUv5br3AakjulyFZDu1YhMH11z2abb2h/fQ+33lvrsyx93Ul8VtvwBKFygyNqqYAO4+dVVCBv5V8VZeeNjCOWHmO/oYk8IlWAxiAp4MJNfxFiKwQ4RBqj7EKCWhdKoaS9r5FL6kiMJNAGN2YPGM9c8RT8HIJOA9MulwlJV4ULVGL69ssYrZdTHEz31LjwVS7L20oKJbFAqJHsrzs4VszvobtT8HmnAh3VxwLdRXgng3zgzqrggor1D9eJ9xsgffnkJCGcOyMFJuoTzE9KBn9q8SV0HoiRrfLrLWx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 20:12:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 20:12:06 +0000
Date:   Tue, 13 Jun 2023 13:12:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, <linux-aio@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs/aio: Stop allocating aio rings from HIGHMEM
Message-ID: <6488cd9030687_1ad89929456@iweiny-mobl.notmuch>
References: <20230609145937.17610-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230609145937.17610-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5527:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e54d54-86e3-4af9-20b0-08db6c4a75d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/b0QDj3MeMx3JoQ/+y4vTNbNvFCDzgvmbtSoazVPuToWfBHVwzrLY2aqyIdf2jGPoF5RpCPyfa0HmbjwvsvAc+y6Jtuxvh3x4C6JyQwAh3wEIVQHgTohoxU1bt5FiVQoFDEQgWBLNwvBK0ZJbkARCXNfbVI3AINx9SRae7gaKeZwWOhjl8kABcBHEq6zlWQaJqO2XHqNPtvtl4NAsp7mhHod2noYdYNoxy9kxSWb2KpRmLsBLN3jXOKNyLyxlRjfAewf5H3RZKGE7ktbF4l33LvgjQUv9uJjebddBtJluqbc0GHjNtDscLgflPeR+u3z67cN1w0NQtARN9DxJEgtRiVMzyoCvjsPYoFnR53LImGsFbnAMA5BJhe1oOX4Xw46wHd5N7CPw37wzMjm34tpObBpLCJP5ziZgK+QQgtnytzaj8c7GV+I5oXBEDWR1PstfCeKqtPEabHbnhfMWmlZpV4Av5enE0p7CD6YcQPPcYmmix7p0J8eKd7qmbtH3J9HbsmT30dFAfb2RIipJqnhf27jEa1WwDc6hjJ1Ywgu2n1W6Ey+27G/C6zMprdz2Bs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(110136005)(86362001)(54906003)(83380400001)(26005)(6512007)(9686003)(6506007)(478600001)(186003)(38100700002)(82960400001)(6666004)(6486002)(2906002)(316002)(44832011)(41300700001)(8676002)(66476007)(4326008)(5660300002)(66946007)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4quljjVk8PFKyav9+gYG/RBSCL5vxNuukapMjju9neDORG/fWzLKTwtCDTj+?=
 =?us-ascii?Q?3Gu7/EokpxzUKU8osnPbsSk5prt7Wnh+dVHuqTmEurfha80tKh71C+nqJLVr?=
 =?us-ascii?Q?zxklhjB4kAnBRgYe6Zg1KZDbb4dfItwyqvNXIgLJki8eOiPL0PHCiqlJch4w?=
 =?us-ascii?Q?rd3VshB0rtBD65Gv4eIhieUJelb0KvBGPCPJQt7Pwct1O0gyoT7Kk+cshxZd?=
 =?us-ascii?Q?rgUdB3FYZ7cZ+Sfhz78DCqNL3vMIX/iqdumYV6lizWyl6BKNoz0gbn5FIxqY?=
 =?us-ascii?Q?Ls3/+noX/GB2Xiaotw/XGOB2Y28/pPZbbsWfsNiRYHXQYIgOu7oZ0oONwuK9?=
 =?us-ascii?Q?F9IeGoxqmpMbvTmQrKbivZJWXyYCWbJhNKr9xbT0IGQyMOHCc/6CLckHriTo?=
 =?us-ascii?Q?8M66QSdbHk7/T5ZNn4JPI8djJsC5IbRfkjO6fAZUMbwM+OTHFKoJgKiim3pN?=
 =?us-ascii?Q?8RelSBBZWSHkUR4k++RC3ga1aIdVGfgmESll5EINbXPrtzfpyG3RjuTTYXVl?=
 =?us-ascii?Q?JltwiJpL69xzysyLmdc2+2g2lA47elry6SJgeg4bsF2gZOx0wbZm6L1kcG+R?=
 =?us-ascii?Q?KiBUy+4TibYPCLbJDtnMcQhz9oB3PaenQX0qKgUXnefdd00nZYVcYZKSHncW?=
 =?us-ascii?Q?K0IPiAGoBjDZWHKdFVRu0/Pr2FYdI2ODX6rGIG/wcYNGD9/IxizVaEUAU8fk?=
 =?us-ascii?Q?y3TwruRACGWgJA5WLeoqgjcgYb8V9Fsf8lrrngCQXxTquNI3ltoRiEdTBwNt?=
 =?us-ascii?Q?2hcZaczvOMvJM32kvlRpkBOn/XJo7QwjLekaCf6bxbO+v867UfnKatxqJWXW?=
 =?us-ascii?Q?X/IGKZ7l+kdsrDXqadu9baQcLHiWPAkzU4CPPNm00BGsZZG0wwUQP9w8Ug+E?=
 =?us-ascii?Q?ewbUDzhV+/2e7wYvXW9lijG5uYZqhh7Z/kdfY7ezbOmRjvXaQ+8vFDqLlDBr?=
 =?us-ascii?Q?VmR877Pu732Smn2t1WKaHwz7x1AmgS+hq+E71hp309/L7U/cpMm0FV1DzpDe?=
 =?us-ascii?Q?spjVRVX3qbYgAxMRZBAqRcU48PtTtOt4mdrv0UfdsnFq5zd/AI/G+3kF1ANp?=
 =?us-ascii?Q?8FK97w9MWkFQ9Eyyo1D+0cW+DcjdtyxSXia7kkflZUIJQopfqSA3wv795Q/X?=
 =?us-ascii?Q?8RDUGQ+kpusPzdPoZtB/8ElZXHs7s/VEo8ntxGr2d8XkRf2WCrqu0pPjubua?=
 =?us-ascii?Q?HyJH6V/stwkRNmvCAfO8w6MITsiwVxNAJE65VTX004xieCnUqGqa3Fi1ZTIM?=
 =?us-ascii?Q?65KB5x5PPSANyJLVUeV+aaUnIG0VP1zXn8OXEi01DFqt/iqm21r2wJOHX2bv?=
 =?us-ascii?Q?INyddVEX7W0dt+p3phlmT0zg+bZGzHgodv5mfHOqIPvzLT3YwGODEoT7AMbF?=
 =?us-ascii?Q?h4uOQ1WwI3ZgTR+9q2E2jlHxmn0bkeR8wcrULQ8uVdeJP+53A/hHY2lIRdPY?=
 =?us-ascii?Q?STOpG2BONXpuAA8Q1fnPf0POPfWu/6lWmtMAscPoauZ4A3kOvDI9e5UhaZTt?=
 =?us-ascii?Q?VK4jLbBEZLimCOybdtbesLJBGz/bxrolAxz6g6QuuDZDwNjXQ4CNG5YO+ha8?=
 =?us-ascii?Q?BE3velaYlpAWCyylxfpzdWVd66ll4lpIfuomV6CN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e54d54-86e3-4af9-20b0-08db6c4a75d5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 20:12:06.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHrkUMWhWYmHXgMnVL39pATr+X1piyuWK/hKkEVgdXbxQQZKOaYAAHTZW3oARnnCJd1Ccx07j2F8FWV0nF6Q0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5527
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

Fabio M. De Francesco wrote:
> There is no need to allocate aio rings from HIGHMEM because of very
> little memory needed here.
> 
> Therefore, use GFP_USER flag in find_or_create_page() and get rid of
> kmap*() mappings.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/aio.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index b0b17bd098bb..77e33619de40 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c

[snip]

> @@ -1250,10 +1244,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  		avail = min(avail, nr - ret);
>  		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
>  
> -		ev = kmap(page);
> +		ev = page_address(page);

NIT: This might be cleaner to remove the temp variable;

		ev = page_address(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE];

But generally LGTM.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
