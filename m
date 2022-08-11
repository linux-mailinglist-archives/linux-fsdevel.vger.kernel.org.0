Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BB5906D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiHKSvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbiHKSvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:51:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DE9A96C;
        Thu, 11 Aug 2022 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660243902; x=1691779902;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=syNW617gHRClBbrg/d5eGpjRKbxAbrrb8BuXxbnhIQY=;
  b=e/omZii9vlUFTuecrB7omOiYdWaTJODDSp3azeiVFFK2+ZLL90Yt63ex
   KbKs2+l3ufUyBUHuSejHtRKWg4z8G3oWI5KEBvbABZIE2VC5uOIEdunuH
   IN8XRxL+8YzRwf5XpYlPPLo7o8i4nOx1/jKoG10oA312Qo3ledSgyNL1o
   COy0x2J2kxQ/t1hJswkL8ubZdfzY7KjFnctgMbDs2uKxLMvx3hGlnsuN8
   /KATk8WO9mQlqpkLASZyld80sLngNzXmrQ1lOWkLTzFOX9lKrD5yvALt/
   FkG4XEnw735A924EATEoltNGNrTgOQaz066VTCNQ75EW9zLcGx0RcIgE8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290189893"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290189893"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 11:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="602268003"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2022 11:51:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 11:51:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 11:51:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 11:51:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 11:51:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMMkeaPE1WLvctF/pj1WpR+GTJjjC4wPHvjbQtKBrtsOTyN9rj544GcNPf9PLJLi06BHggXqucyix5u4tgLMRWdAcildQ56cT2yyFUGkhMRCdaNZuWQ5rlCGQT0A6e56U3ZN7CSSOtq6YauUFhojDszuI0ktK09wcj/7pqu0dv5XeKzMv1WeELOmxeLqvcYt5K9gsjqDRyh6q68+8X25mFg0wC2VNtddIHfzXqwupz37CoUoIvtIQ1K7+HtNv/orQJTVS6t4oth8s43sog/O504FwTA4Pz0OST7AXs+u8/gnSSI7t6ntbjdWhsIbsFwnybH0Xi38EkVKYCWVpG3iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbgYlTD2bAfpMZ45LeSOVr8PVA9nmf/E/SkX48x9UMk=;
 b=fo/XL4IfKINczCL9pVtDMwfuILrfs2XT4N1MudqZWgDFp7VEa1fQffqgRt9kO+c/uGFs1QdgjkyHYx7j3y8s6BhJykEbhUNNvKMXQ4v5uSGBGrYuCxDnFeMXc/ChMGfTMSARNFDeAvjwiE8uYBS/6IRUKoPAr8eBkupX4JYwIbB+yC9Gyb5cHzvdy/RWHaOybqex95a7qwZ+PFNMv375zoUBlbvTRi03KZWAGF52Ki+uSo8m7m1h5qSkT2NoEJo5UDdsR5MLU0m0E0Ub6nv3iTZeTNT2NvmgqsojlMAC2qqjYzZpkV5TB2eA8Dpo1ieX8LoxU5Bbu0c36TXje9t75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 18:51:39 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::a85f:4978:86e2:8b44]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::a85f:4978:86e2:8b44%7]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 18:51:38 +0000
Date:   Thu, 11 Aug 2022 11:51:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <ebiederm@xmission.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <sfr@canb.auug.org.au>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in kernel_execve
Message-ID: <YvVPtuel8NMmiTKk@iweiny-desk3>
References: <0000000000008c0ba505e5f22066@google.com>
 <202208110830.8F528D6737@keescook>
 <YvU+0UHrn9Ab4rR8@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvU+0UHrn9Ab4rR8@iweiny-desk3>
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a5d274-5d46-4569-d412-08da7bca85cb
X-MS-TrafficTypeDiagnostic: MN0PR11MB6279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QccI+XUTSgGRDbI5LQrTh8SCAW7vpZy1oYDVu7Wg7uQgxo6elciObSUnr6Dhg5nBUOIXe53Eo1V8hzCONB2Td/Nju7zj67uEVeBUaNeOlJOIrbyECh6zcYfhigDvv1qPRyev8vuWcfK8zlk0y/OnjtQekAgOXpYPgl144FreYMRL7Vhr0pkLmNlYqjHJEcka2t1K67zEFxpS3HzLn+Wxm7AM24syFfIE6UcT2HPdFlD8hXxK/o3KRFq3ymZa/4kqim25twT2jLZGur6ETsR7pVW4hf7fTA/nSH/edaQ1wn63+QSfe26QN3Y7I6AIAN4tD0wL/iGIu1jUWEs3b4SpA/3Tq/6oIhUTtmXF8PGJfoewJnpoNJJvZAJ+10uXzx4/voJLVDseKRF5LNqyQxZAT3ZwhTuHECU2TMtnROOsfvO9v/wLhlnmCr0WySbDzj2X+ER4m0nlx3lefZjAUu0G99WorFA+ni7ln5AdfCKI7N3/cJmB5sWZVMSbwRu+XaPGrxdGPDN1BEFTbJCfz/0Q2Q+irUFdOif4e5xzk6aILMB0MGExNiInPZ9tuj4oyWIHfcEHJYIQE1yuJhcu2tdec4gmuyfbhDIlEnP5sjpVG5nT1OaZEu16755f99hqKsp1zl/sGJrcr6KysAo+nxY72YRXInwUu0/1/+ru7FjRYOQfFsxNuh3rkLYlAPcnUXYvf/oPiSjZ2TWG/HrHA+SFh3FdqXGjpXR3x/PGGUkKcXAP23zCFG5ft3oFLdHH5cmeym/ujLRVzlwq5b9N20aQZdJFYEyk9rn1IS+y7HnIyxpebqOl9zcuflPzW8Epbmo1Xy8CIX8TlIq9F7mnSWzcGFEs2UsVbg+FPb7QHdSAmEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(38100700002)(316002)(9686003)(54906003)(6916009)(5660300002)(86362001)(82960400001)(66476007)(66556008)(4326008)(8676002)(8936002)(66946007)(44832011)(6666004)(6506007)(6512007)(26005)(41300700001)(83380400001)(186003)(45080400002)(7416002)(478600001)(33716001)(6486002)(966005)(2906002)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34lBuKE89FHDtBr1htP8gv/JE0hSo7i0E8F1DPk9RAvM0rbD/pJW3/THynMO?=
 =?us-ascii?Q?fBTrCTTsekXJeQs+wxcjBh/BAwElEZujImy6b/MZ2k6Wdxu4tEutqrM9YUcu?=
 =?us-ascii?Q?3IphhfOvxG8joqrOfikchG+/xRSUzsXwecVdfocDtOkDntPBtX0ufokJj10K?=
 =?us-ascii?Q?499WuteeLfFjvMLhmIJtFHSaQHuhxw7UnmwMzwop+P6qxsGo5tNTmBtUH/8k?=
 =?us-ascii?Q?RJ/gIk9q0OPF7quetSCc1X/tHhLjM/fejA2TLEcwLf06Lsff2XnUThqW+uTf?=
 =?us-ascii?Q?Cc9Gg37aita8FkWBFedY8pRktvA9FWpgOUYbrDkh5Yoh2x4ruc9Lwt5SslEJ?=
 =?us-ascii?Q?PL4hmEXK4z9sHqIQ3T2SdUk4fpIR+vEt+riEMcdeZZl0FnVVX2RGwq5GUEuh?=
 =?us-ascii?Q?i+AEkRyqaRemg21hl/cofT1JyJAk4a5ae9W1d8v0MvZHNOtA+Ijy/YW60J1u?=
 =?us-ascii?Q?Ansuw2xTwbKgJQJvmkumPdj6tUPUvyniJO7IXOb6bnV8cvgR5fAUiHLAUhvF?=
 =?us-ascii?Q?9C2lQdhDMgKVjAuXF2p/IG4TJUzQ6SbDwcApV4ntsO3Hx4DUQfHqEsCDZl1Y?=
 =?us-ascii?Q?fLQ7Y9XpJj2veKXdFWmxOIlwO91gwkK9oEad/p3pLsUjyLbdkzF59FTabOo6?=
 =?us-ascii?Q?qvGY+Y7WUF8M0AEbjJDqEBQ3hC7d3cQb5VSktYuLiSdOcR5gT4u8Jx0S/m6p?=
 =?us-ascii?Q?g1E7EeiaiIic9fTaWVvFPJJSK1UpM7O7KqbltyPYdIgy1otdP3HCV7FmKhgS?=
 =?us-ascii?Q?XgCrQl+0mTL4uymJ9fO1vvfzJMCnlY8+DqLpYlNS+I3Py03MCHSj2ke4o5/1?=
 =?us-ascii?Q?K6Sxw363kHixwf/Y9CVD1tIK1FvpHbt78MTl1jw41ceuhfBGdFfoc7mMfHs6?=
 =?us-ascii?Q?aBCHkwKjZg5YhOW9uAKcJ4tSxCjQgI9xv1OFXga9txB7kr+nKOldqvWLeJj1?=
 =?us-ascii?Q?CeG1IEEvmeUeoFc1vESnCVsHvVyn9yvUFajnfPpqW9XMWg8TsKY6pzNjKeZT?=
 =?us-ascii?Q?3y94QJ+Wd+L5AbwGBg06a6PueinWgszvvmcxUbfA1TtYBIKsy8Wom7czFHkw?=
 =?us-ascii?Q?Q+xamxKVPQdeuKjpFUbcIdbQ+rJxlmmN3cftaSRQVaJm3cQnaCNLrBhZVFNo?=
 =?us-ascii?Q?rwVtsBVUob6CkRXCmJ87wA3NnL3TlK5MRKe/eS4kLqmlL7ChC3wsFhbyDS5G?=
 =?us-ascii?Q?zlXOYroJNa9GtySc92GfUlB2hFSTkmA91Kf4Mbe9bNns5bW6d+khXIn0DK7F?=
 =?us-ascii?Q?HugVXzoC00SYHEUWuh8h4qLyV+UmpRE/Qqy0HHnGqA08y23xgth/JpNL8UUH?=
 =?us-ascii?Q?8AwVYU23B8wHw6z/PenZfe6smukhWZpfwpAJsRl5cbJYnTkl7fWAEejizFRD?=
 =?us-ascii?Q?9k94nPCJPNqoQKjLLa9Vg4xkq/7gGXvXOzaXn0t00AkLrW0o/hTzINqOf/+K?=
 =?us-ascii?Q?iBOikyzZP3nwEbzXHg1W5NTTcrY0Hp02rAaD5lC9YtMHcjco7ANKh3Qz7FOm?=
 =?us-ascii?Q?NY070tB7rZeq98f31Rnhw9RCkOYTD9S6vLrmAfR7LhCLckQg65tXmiKq05wk?=
 =?us-ascii?Q?4g+DbtttbL0IJN3bQBhQrHsANQdiLwiVwa5+uS4L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a5d274-5d46-4569-d412-08da7bca85cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 18:51:38.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bp7MJnHd8kziw6xdjtdzFIdxf4cVx4yadHFjCu4hJDKpg+JlT4CuFvkWy62TWFotCCnIZ+dEyXVqQeOUs+IiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:39:29AM -0700, Ira wrote:
> On Thu, Aug 11, 2022 at 08:33:16AM -0700, Kees Cook wrote:
> > Hi Fabio,
> > 
> > It seems likely that the kmap change[1] might be causing this crash. Is
> > there a boot-time setup race between kmap being available and early umh
> > usage?
> 
> I don't see how this is a setup problem with the config reported here.
> 
> CONFIG_64BIT=y
> 
> ...and HIGHMEM is not set.
> ...and PREEMPT_RT is not set.
> 
> So the kmap_local_page() call in that stack should be a page_address() only.
> 
> I think the issue must be some sort of race which was being prevented because
> of the preemption and/or pagefault disable built into kmap_atomic().
> 
> Is this reproducable?
> 
> The hunk below will surely fix it but I think the pagefault_disable() is
> the only thing that is required.  It would be nice to test it.

Fabio and I discussed this.  And he also mentioned that pagefault_disable() is
all that is required.

Do we have a way to test this?
Ira

> 
> Ira
> 
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index b51dd14e7388..3da588c858ca 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -640,7 +640,11 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>                 if (!page)
>                         return -E2BIG;
>                 flush_arg_page(bprm, pos & PAGE_MASK, page);
> +               preempt_disable();
> +               pagefault_disable();
>                 memcpy_to_page(page, offset_in_page(pos), arg, bytes_to_copy);
> +               pagefault_enable();
> +               preempt_enable();
>                 put_arg_page(page);
>         }
>  
> 
> > 
> > -Kees
> > 
> > [1] https://git.kernel.org/linus/c6e8e36c6ae4b11bed5643317afb66b6c3cadba8
> > 
> > On Thu, Aug 11, 2022 at 12:29:34AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> > > 
> > > BUG: unable to handle page fault for address: ffffdc0000000000
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 11826067 P4D 11826067 PUD 0 
> > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  strnlen include/linux/fortify-string.h:119 [inline]
> > >  copy_string_kernel+0x26/0x250 fs/exec.c:616
> > >  copy_strings_kernel+0xb3/0x190 fs/exec.c:655
> > >  kernel_execve+0x377/0x500 fs/exec.c:1998
> > >  call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > >  </TASK>
> > > Modules linked in:
> > > CR2: ffffdc0000000000
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > ----------------
> > > Code disassembly (best guess):
> > >    0:	74 3c                	je     0x3e
> > >    2:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
> > >    9:	fc ff df
> > >    c:	49 89 fc             	mov    %rdi,%r12
> > >    f:	48 89 f8             	mov    %rdi,%rax
> > >   12:	eb 09                	jmp    0x1d
> > >   14:	48 83 c0 01          	add    $0x1,%rax
> > >   18:	48 39 e8             	cmp    %rbp,%rax
> > >   1b:	74 1e                	je     0x3b
> > >   1d:	48 89 c2             	mov    %rax,%rdx
> > >   20:	48 89 c1             	mov    %rax,%rcx
> > >   23:	48 c1 ea 03          	shr    $0x3,%rdx
> > >   27:	83 e1 07             	and    $0x7,%ecx
> > > * 2a:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx <-- trapping instruction
> > >   2e:	38 ca                	cmp    %cl,%dl
> > >   30:	7f 04                	jg     0x36
> > >   32:	84 d2                	test   %dl,%dl
> > >   34:	75 11                	jne    0x47
> > >   36:	80 38 00             	cmpb   $0x0,(%rax)
> > >   39:	75 d9                	jne    0x14
> > >   3b:	4c 29 e0             	sub    %r12,%rax
> > >   3e:	48                   	rex.W
> > >   3f:	83                   	.byte 0x83
> > > 
> > > 
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > -- 
> > Kees Cook
