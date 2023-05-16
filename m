Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABF7043CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEPDEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEPDEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 23:04:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FCF1FEB;
        Mon, 15 May 2023 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684206284; x=1715742284;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3ODr1T5k7L7YGp/n8hkaccXp90+fEs2czmOmlLWxPGM=;
  b=gCk9Vo72BT2o56J235Wkqg57yX8PbpXqeZhN39ET2GLdCoBXnTpo43BA
   j6ik/t0lpPO3TX6zv698V3dWrvZ9T8iYhU4+ZaU+CQh8PnwQ3PYKr6lb9
   1vEW9sUILkaDgkt1KNQdAiZhBnujqJNCspZV8sGdZll3+6L0ZxGFt17FJ
   nx1jggI/o3zWrRvCFw9/R0UQkyBZZLH5f+8Di243uukphxtE9oXyzGPSE
   Z2KLIqvvT9tXs3YtE/uq6aUOeQEe7ym3j2dSffs+mgB4OuqY6KU42MC6q
   dc6Iz7EZuYjEkXaZ0X5XWA1Ft1dwfUxB6glWc/zZMR5xCcp7uaIovt6fy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437708840"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="xz'341?scan'341,208,341";a="437708840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 20:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="770860123"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="xz'341?scan'341,208,341";a="770860123"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2023 20:04:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 20:04:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 20:04:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 20:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0KpgeendgtQt2MV/mOOiIKri6B3WZKN1BmMadfEFEQLS4eysd5FCkOuQGz+TTIzWQPgtOH9O1w7h47pAEDyaFz/xLo5JlFvNbJJvKjbWRjmgIGX+h8vxdPn1tzxRyBSGcc9eg0102s5MDpKxQdwQHtGarVvT2iZe3FrDzmSJExN5obVRc9pAEAlRFSXtKGx/yfpa/YjVgrJGbKsZaKz5X861LCV13PiEJWlaABqpbWW9MUETsxo7LNwnffyw8WOth+wjaN91sWX1ofNJdg3b+ugjeSSzjuaKzf6zyV1hLggmT0Dphkf3g5bFMnGQKDKyjI/wTq5QRIEoDw4xeMssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGL45uncYX3/zrpIHuI38d5qjw2Yn2C9YN81rlJhEys=;
 b=AOPkOGs3Z5jiaxWf09fiKklXeSuoWcQiijTL1yo4udynWmJKDDYH4dUvUVJG3yoor1svixEs4HW7wQsN482aUTllT4YLl2dSBoGjWAe+E/nwxErrcJS/CuxG7c1hOQ/UIunxQ8IDuu8DhV1rorLN6IsjCbKLPOvjn8NlmRdrgz7YgIxT7qPuNhNBsIK6gdbzkAtWstU5wjrP9EyGBVNMpQ9/indS+lp5A9SZjeGXP0qLplC+O1W80VhSLlvF7CEX4jugwFeQh8woLhixeh38egjqn0thxNZ2uUAaTxLeKsW5GoOVeVOhEYX9SwSlIHR5A0esn6oB/MTcZ9/TOghubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 03:04:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 03:04:32 +0000
Date:   Tue, 16 May 2023 11:04:20 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov" <asml.silence@gmail.com>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        <linux-kernel@vger.kernel.org>, <io-uring@vger.kernel.org>,
        "Dominique Martinet" <asmadeus@codewreck.org>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/6] kernfs: implement readdir FMODE_NOWAIT
Message-ID: <202305161035.aee940eb-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="w/tzJwjKlNe4QZ5C"
Content-Disposition: inline
In-Reply-To: <20230422-uring-getdents-v2-4-2db1e37dc55e@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6919663a-5735-44d5-0324-08db55ba44ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64N9PHGxQDbj283hcnB7mQ3fIrUEVo9IGHfjaxWu8q+KU2uie5Df/n1lydhS5o+Ri0p7CdT8AqHOvMI8i+P0xg3ZucAWsLq5BHn6YrWt7gqYHDCNuddJieA7K2WNZ5xJ9j1ANJAquO8q+gvglknDX66cvvhIU1i9GS7lwNjqcWRavi3C3/xvmvh2gdNsCChU4dfF2swGOS/Wo/JCevG30BA8pStWmzzFZPiCpOzdLIXZ3y61bX4swG04/pAPruccBZ0vR3D+zQ5GGZq+oJBt2n6aIdBC+vgOdzosxbzefXalSgszVsAiGNoca1pOZifDlWSzw4baw0OCPSRKFJ3aiwlgV0BlCgLSTww29ssbH4ztaXvssfGSxbX+vFRG1Hxl66o28T/cVXSoAkmYRRR/ZunxiyLNfn/p/XEj1xN80cqiFOIBbg9QZDGgHAOW6vXR4KWTN+falnS57EzmA5tNuPuwv3Bs9Zge984HqqOaKwCr8FfvT/VI8IDhclFTK8hxg+nDfvOuml3SyL9JO7ML/BUuualu0/WISjDxFV3AKD4WaOAPW00GHcTq+aO8NbOWLaXTGtx1hnhcw1yGCzUtD9uhFCAHS5avX88dQw+SqWhhqu986IUAxf20PUWX1uiRizqpdQ9kYNH60p5fTh1MeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(44144004)(966005)(4326008)(66946007)(66556008)(66476007)(478600001)(6916009)(6486002)(86362001)(316002)(54906003)(36756003)(26005)(1076003)(186003)(107886003)(6512007)(83380400001)(6506007)(235185007)(5660300002)(8936002)(7416002)(8676002)(6666004)(2906002)(30864003)(2616005)(82960400001)(38100700002)(41300700001)(2700100001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELZhIQfR5JF5LBNfupWfqqnzHVOenNopvip1kxL8sWDrkh5ebEhmFVeO6rYW?=
 =?us-ascii?Q?8BuQxmlYy3g3aI0kH7i3Gvfn88mqnHpNr0xnJxy5s1RBUY1mcCvcXisrOVCI?=
 =?us-ascii?Q?4kHAtzDGaChNGzo0jRTJpKNMrgPfTDf3i0OlonDWOjGNet9qAuFGAiHtvCKz?=
 =?us-ascii?Q?uTK3kSjyLO5IrkmES6L1HlCROGxc6SwBc++ktNDQv89S52qZOI0DQJAWj18W?=
 =?us-ascii?Q?7Lf3m0bQTrYIiqdsVZqAU20f/18+Dm7Qzi4yLgMIZB/VKyiwc0F0go1Nh4BJ?=
 =?us-ascii?Q?0xYyQXvByTWXT2Puqjk/D77377WjPaQNQBVbNVSzetGq0FAgR4+8huOcVGgR?=
 =?us-ascii?Q?7TpAGj0JCWdlBLnjUUq59JYKYqugzihOb7FzwRUWNPNzK9VJkuUsSxvbSBte?=
 =?us-ascii?Q?qxNd/TGGYLSI5tMkx0JYL+1bGQfFXpkaXVklbPjn7aM3N0MXSKMETzE5Q7Ix?=
 =?us-ascii?Q?Dsj4lxAftUTkYBFUcO4SHShDI1Z5ygSCaJhAisbu+TCunTZQJMyknHHJqpR5?=
 =?us-ascii?Q?7n+/ctkzCxUyG+DN0XZpm75fs9yaRvwmkZnF/DrRkdkdflcliFbk5x1XbTVV?=
 =?us-ascii?Q?a56lwZXiGvzCt9uCvrwLXCxxwVXYr8bC3gOrjkGw7dkjOCgY59LAm3swL4g5?=
 =?us-ascii?Q?kSVgtuhmzcr05lQ81qbmUQUqJCTv7u1ekf8m1isKR7xrLiTQp8Co3TwSl1Gs?=
 =?us-ascii?Q?gVSpoM8tkTIgdNzw0iYOseapqpP4hXPcVaYsyRypg/pW4xo9NI71T52b/YWS?=
 =?us-ascii?Q?wL7MIaZ1IMvLjwFAS2W3YGEiSlYWwGvk+EtcWOvqWtheMTr6mkbKo6Cc9gMv?=
 =?us-ascii?Q?kstI9d6uoIgdhrFy1rNBxFkRB/wJ0fICf3Ekb7cqX5opWBz9QkC6QTjKGIHW?=
 =?us-ascii?Q?558ezxpdy86S7q2gbTax9z3oTnLjy33nFeyKExpjV/ZBfAp4N3KbAIQCzV5j?=
 =?us-ascii?Q?k75C0dvMCspIo0gkcRQPYDI0vqvdyeLqNkieh7NpRjqAGXBXS0NVEDEDuD4Z?=
 =?us-ascii?Q?0NMU5B0CI3LN7z55fiq8c0gtfdh+fbyOJ8qhEdQvbPlf46ImUtI/MOvnRlXV?=
 =?us-ascii?Q?nfKmsvZ551DykK7H7MnoB2iCVCUG9HQpVfn2psgUwxHzDPGohX/LeUUnJe9e?=
 =?us-ascii?Q?kPMlPF6C2Br9gQJ9WyFa/x/q5QLY5Mr1j56DpFzhtxF1euAFFLqACmXvk9df?=
 =?us-ascii?Q?3/ZT0Md9Kz2r2ey17n3Af0JNdEefmOcMN1uL0MZQAXqWVbm99nlsUKzPOOL9?=
 =?us-ascii?Q?rMsw2sP+5+n5aluTrSxUQ/D0DxvaMMqXzreUDD5owCoTYhh2UtQ7Uh0etk//?=
 =?us-ascii?Q?rNt+PMud7GfzWG3y53ZQF0dcbtjAXuHO1wDIfuSXIM32WSqDnUmgRW0rf6FF?=
 =?us-ascii?Q?1+k2JJhJoxuUANPNAxM2J/VNcAQ38Q9U2Wig6HZSRK1XYEuLNwRiLQpoNUV0?=
 =?us-ascii?Q?j9Pp1MS30lXf676qECAjRzCvjJqc7nZpftZlA5hrSG6pE5ynfFSreK0654KR?=
 =?us-ascii?Q?jIDJaha20iqBKT+a8nLvBAag94A8C+/eoLGTmUMhbCUl+wgmhvZwcxglCrUE?=
 =?us-ascii?Q?TkMDuEUu8mjEb578oXEffTetPmj4TX3m2VPNEKQy2I7K5CEsk+uIwer2ySjp?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6919663a-5735-44d5-0324-08db55ba44ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 03:04:32.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbiaeeyI1d66ejyDk7BpCKcflWz1GiIQesLgIuaPoCjkLPOvPuDF3Yrgakhgf76pYgfGJccQuH8wC4XGwj9bZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--w/tzJwjKlNe4QZ5C
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

commit: a551138c4b3b9fd7e74a55d6074a013bab6246db ("[PATCH v2 4/6] kernfs: implement readdir FMODE_NOWAIT")
url: https://github.com/intel-lab-lkp/linux/commits/Dominique-Martinet/fs-split-off-vfs_getdents-function-of-getdents64-syscall/20230510-185542
patch link: https://lore.kernel.org/all/20230422-uring-getdents-v2-4-2db1e37dc55e@codewreck.org/
patch subject: [PATCH v2 4/6] kernfs: implement readdir FMODE_NOWAIT

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202305161035.aee940eb-oliver.sang@intel.com


[  989.795384][   T32] INFO: task systemd:1 blocked for more than 491 seconds.
[  989.797105][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  989.798652][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.805157][   T32] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00000000
[  989.807376][   T32] Call Trace:
[  989.807873][   T32]  <TASK>
[ 989.808312][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 989.809423][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 989.810300][ T32] ? is_bpf_text_address (arch/x86/include/asm/preempt.h:85 include/linux/rcupdate.h:99 include/linux/rcupdate.h:805 kernel/bpf/core.c:721) 
[ 989.812634][ T32] ? __kernel_text_address (kernel/extable.c:79) 
[ 989.813489][ T32] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
[ 989.814106][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 989.814806][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 989.815384][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 989.816060][ T32] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073) 
[ 989.816862][ T32] ? filter_irq_stacks (kernel/stacktrace.c:114) 
[ 989.817552][ T32] ? down_write_killable (kernel/locking/rwsem.c:997) 
[ 989.818224][ T32] ? kasan_save_stack (mm/kasan/common.c:46) 
[ 989.818982][ T32] ? kasan_set_track (mm/kasan/common.c:52) 
[ 989.820158][ T32] ? do_filp_open (fs/namei.c:601 fs/namei.c:612 fs/namei.c:3817) 
[ 989.821366][ T32] ? do_sys_openat2 (fs/open.c:1356) 
[ 989.822619][ T32] ? __x64_sys_openat (fs/open.c:1383) 
[ 989.823954][ T32] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 989.825170][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 989.826651][ T32] down_read (kernel/locking/rwsem.c:1518) 
[ 989.827317][ T32] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 989.828033][ T32] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 989.828720][ T32] ? d_same_name (arch/x86/include/asm/word-at-a-time.h:84 fs/dcache.c:227 fs/dcache.c:278 fs/dcache.c:2265) 
[ 989.829326][ T32] kernfs_dop_revalidate (include/linux/instrumented.h:68 include/linux/atomic/atomic-instrumented.h:27 fs/kernfs/dir.c:36 fs/kernfs/dir.c:42 fs/kernfs/dir.c:1135) 
[ 989.830424][ T32] lookup_fast (fs/namei.c:859 fs/namei.c:856 fs/namei.c:1651) 
[ 989.831513][ T32] ? kernfs_iop_permission (fs/kernfs/inode.c:294) 
[ 989.832733][ T32] walk_component (fs/namei.c:1994) 
[ 989.833602][ T32] link_path_walk+0x533/0xa00 
[ 989.834386][ T32] ? lookup_one_len_unlocked (fs/namei.c:2243) 
[ 989.835107][ T32] ? __mutex_init (arch/x86/include/asm/atomic.h:41 include/linux/atomic/atomic-instrumented.h:42 include/linux/osq_lock.h:30 kernel/locking/mutex.c:52) 
[ 989.835787][ T32] ? __alloc_file (fs/file_table.c:154) 
[ 989.836454][ T32] path_openat (fs/namei.c:2250 (discriminator 2) fs/namei.c:3787 (discriminator 2)) 
[ 989.837123][ T32] ? vfs_tmpfile_open (fs/namei.c:3773) 
[ 989.837759][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 989.838514][ T32] do_filp_open (fs/namei.c:3818) 
[ 989.839286][ T32] ? __update_load_avg_se (kernel/sched/pelt.c:118 kernel/sched/pelt.c:226 kernel/sched/pelt.c:308) 
[ 989.840569][ T32] ? may_open_dev (fs/namei.c:3812) 
[ 989.841576][ T32] ? update_load_avg (kernel/sched/fair.c:3920 kernel/sched/fair.c:4255) 
[ 989.842373][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.843492][ T32] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 989.844732][ T32] ? alloc_fd (arch/x86/include/asm/bitops.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:29 fs/file.c:251 fs/file.c:540) 
[ 989.845759][ T32] do_sys_openat2 (fs/open.c:1356) 
[ 989.846384][ T32] ? build_open_flags (fs/open.c:1342) 
[ 989.847049][ T32] __x64_sys_openat (fs/open.c:1383) 
[ 989.847689][ T32] ? __ia32_compat_sys_open (fs/open.c:1383) 
[ 989.848385][ T32] ? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 989.848957][ T32] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:752) 
[ 989.849627][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 989.850219][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  989.850964][   T32] RIP: 0033:0x7f5c316f8be7
[  989.851562][   T32] RSP: 002b:00007ffc354a1f10 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  989.852586][   T32] RAX: ffffffffffffffda RBX: 0000562309e04d60 RCX: 00007f5c316f8be7
[  989.853582][   T32] RDX: 0000000000080000 RSI: 0000562309eb1320 RDI: 00000000ffffff9c
[  989.854556][   T32] RBP: 0000562309eb1320 R08: 0000000000000008 R09: 0000000000000001
[  989.855573][   T32] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
[  989.856562][   T32] R13: 0000562309e04d60 R14: 0000000000000001 R15: 00007ffc354a2320
[  989.857561][   T32]  </TASK>
[  989.858016][   T32] INFO: task modprobe:90 blocked for more than 491 seconds.
[  989.859063][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  989.859862][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.861044][   T32] task:modprobe        state:D stack:0     pid:90    ppid:1      flags:0x00004002
[  989.862166][   T32] Call Trace:
[  989.862649][   T32]  <TASK>
[ 989.863098][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 989.863704][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 989.864384][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 989.865125][ T32] ? idr_get_free (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 lib/radix-tree.c:113 lib/radix-tree.c:1518) 
[ 989.865743][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 989.866406][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 989.866974][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 989.867669][ T32] rwsem_down_write_slowpath (arch/x86/include/asm/current.h:41 kernel/locking/rwsem.c:1180) 
[ 989.868395][ T32] ? down_timeout (kernel/locking/rwsem.c:1108) 
[ 989.869015][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.869640][ T32] ? __kernfs_new_node (fs/kernfs/dir.c:651) 
[ 989.870566][ T32] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 989.871721][ T32] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
[ 989.872459][ T32] ? rwsem_down_write_slowpath (kernel/locking/rwsem.c:1571) 
[ 989.873626][ T32] ? kasan_save_stack (mm/kasan/common.c:47) 
[ 989.874858][ T32] ? kasan_save_stack (mm/kasan/common.c:46) 
[ 989.876064][ T32] kernfs_add_one (include/linux/kernfs.h:391 fs/kernfs/dir.c:754) 
[ 989.876931][ T32] ? pcpu_chunk_refresh_hint (mm/percpu-internal.h:114 (discriminator 3) mm/percpu.c:762 (discriminator 3)) 
[ 989.877791][ T32] kernfs_create_dir_ns (fs/kernfs/dir.c:1044) 
[ 989.878954][ T32] sysfs_create_dir_ns (fs/sysfs/dir.c:61) 
[ 989.879719][ T32] ? sysfs_create_mount_point (fs/sysfs/dir.c:41) 
[ 989.880421][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.881343][ T32] ? __kmalloc_node_track_caller (include/linux/kasan.h:196 mm/slab_common.c:966 mm/slab_common.c:986) 
[ 989.882220][ T32] kobject_add_internal (lib/kobject.c:65 lib/kobject.c:233) 
[ 989.882902][ T32] kobject_init_and_add (lib/kobject.c:368 lib/kobject.c:451) 
[ 989.883569][ T32] ? kobject_create_and_add (lib/kobject.c:444) 
[ 989.884262][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.885122][ T32] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 989.885929][ T32] ? srcu_module_notify (kernel/rcu/srcutree.c:1921 kernel/rcu/srcutree.c:1954) 
[ 989.889953][ T32] ? tracepoint_module_notify (kernel/tracepoint.c:664 kernel/tracepoint.c:709 kernel/tracepoint.c:701) 
[ 989.890685][ T32] mod_sysfs_setup (kernel/module/sysfs.c:361 kernel/module/sysfs.c:377) 
[ 989.891350][ T32] ? module_add_modinfo_attrs (kernel/module/sysfs.c:374) 
[ 989.892053][ T32] ? atomic_notifier_call_chain (kernel/notifier.c:343) 
[ 989.892766][ T32] ? klp_module_coming (kernel/livepatch/core.c:1296) 
[ 989.893417][ T32] ? load_module (kernel/module/main.c:2758 kernel/module/main.c:2945) 
[ 989.894035][ T32] load_module (kernel/module/main.c:2965) 
[ 989.894644][ T32] ? post_relocation (kernel/module/main.c:2829) 
[ 989.895343][ T32] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
[ 989.896301][ T32] ? __cond_resched (kernel/sched/core.c:8533) 
[ 989.897515][ T32] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 989.903046][ T32] __do_sys_finit_module (kernel/module/main.c:3099) 
[ 989.904404][ T32] ? __ia32_sys_init_module (kernel/module/main.c:3061) 
[ 989.905751][ T32] ? randomize_page (mm/util.c:533) 
[ 989.906912][ T32] ? ksys_mmap_pgoff (mm/mmap.c:1445) 
[ 989.907570][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 989.908151][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  989.908891][   T32] RIP: 0033:0x7feb8112a9b9
[  989.909479][   T32] RSP: 002b:00007ffd74170a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  989.910515][   T32] RAX: ffffffffffffffda RBX: 000055ac05343d30 RCX: 00007feb8112a9b9
[  989.911580][   T32] RDX: 0000000000000000 RSI: 000055ac05277260 RDI: 0000000000000003
[  989.912567][   T32] RBP: 0000000000060000 R08: 0000000000000000 R09: 000055ac053458b0
[  989.913550][   T32] R10: 0000000000000003 R11: 0000000000000246 R12: 000055ac05277260
[  989.914742][   T32] R13: 0000000000000000 R14: 000055ac05343cb0 R15: 000055ac05343d30
[  989.915789][   T32]  </TASK>
[  989.916463][   T32] INFO: task modprobe:91 blocked for more than 491 seconds.
[  989.917554][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  989.918474][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.920351][   T32] task:modprobe        state:D stack:0     pid:91    ppid:1      flags:0x00004002
[  989.922592][   T32] Call Trace:
[  989.923606][   T32]  <TASK>
[ 989.924503][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 989.925717][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 989.926964][ T32] ? osq_unlock (kernel/locking/osq_lock.c:22 kernel/locking/osq_lock.c:210) 
[ 989.927574][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 989.928128][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 989.928826][ T32] rwsem_down_write_slowpath (arch/x86/include/asm/current.h:41 kernel/locking/rwsem.c:1180) 
[ 989.929533][ T32] ? down_timeout (kernel/locking/rwsem.c:1108) 
[ 989.930115][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.930743][ T32] ? __kernfs_new_node (fs/kernfs/dir.c:651) 
[ 989.931621][ T32] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
[ 989.932705][ T32] ? rwsem_down_write_slowpath (kernel/locking/rwsem.c:1571) 
[ 989.933976][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 989.935249][ T32] ? notifier_call_chain (kernel/notifier.c:95) 
[ 989.936333][ T32] ? blocking_notifier_call_chain_robust (kernel/notifier.c:129 kernel/notifier.c:353 kernel/notifier.c:341) 
[ 989.937360][ T32] ? load_module (include/linux/notifier.h:209 kernel/module/main.c:2764 kernel/module/main.c:2945) 
[ 989.938087][ T32] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 989.938892][ T32] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 989.939627][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 989.940609][ T32] kernfs_add_one (include/linux/kernfs.h:391 fs/kernfs/dir.c:754) 
[ 989.941241][ T32] kernfs_create_dir_ns (fs/kernfs/dir.c:1044) 
[ 989.942082][ T32] sysfs_create_dir_ns (fs/sysfs/dir.c:61) 
[ 989.942885][ T32] ? sysfs_create_mount_point (fs/sysfs/dir.c:41) 
[ 989.943803][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.944568][ T32] ? __kmalloc_node_track_caller (include/linux/kasan.h:196 mm/slab_common.c:966 mm/slab_common.c:986) 
[ 989.945448][ T32] kobject_add_internal (lib/kobject.c:65 lib/kobject.c:233) 
[ 989.946551][ T32] kobject_init_and_add (lib/kobject.c:368 lib/kobject.c:451) 
[ 989.947309][ T32] ? kobject_create_and_add (lib/kobject.c:444) 
[ 989.948025][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 989.948665][ T32] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 989.949347][ T32] ? ddebug_module_notify (lib/dynamic_debug.c:1344 lib/dynamic_debug.c:1336) 
[ 989.950021][ T32] mod_sysfs_setup (kernel/module/sysfs.c:361 kernel/module/sysfs.c:377) 
[ 989.950943][ T32] ? module_add_modinfo_attrs (kernel/module/sysfs.c:374) 
[ 989.952014][ T32] ? atomic_notifier_call_chain (kernel/notifier.c:343) 
[ 989.953224][ T32] ? klp_module_coming (kernel/livepatch/core.c:1296) 
[ 989.954395][ T32] ? load_module (kernel/module/main.c:2758 kernel/module/main.c:2945) 
[ 989.955507][ T32] load_module (kernel/module/main.c:2965) 
[ 989.956552][ T32] ? post_relocation (kernel/module/main.c:2829) 
[ 989.957756][ T32] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
[ 989.958858][ T32] ? __cond_resched (kernel/sched/core.c:8533) 
[ 989.959756][ T32] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 989.961072][ T32] __do_sys_finit_module (kernel/module/main.c:3099) 
[ 989.962177][ T32] ? __ia32_sys_init_module (kernel/module/main.c:3061) 
[ 989.963144][ T32] ? randomize_page (mm/util.c:533) 
[ 989.963862][ T32] ? ksys_mmap_pgoff (mm/mmap.c:1445) 
[ 989.964664][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 989.965454][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  989.966270][   T32] RIP: 0033:0x7f1d905f79b9
[  989.967030][   T32] RSP: 002b:00007ffc9133bbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  989.968331][   T32] RAX: ffffffffffffffda RBX: 00005651b1b1ae20 RCX: 00007f1d905f79b9
[  989.969548][   T32] RDX: 0000000000000000 RSI: 00005651b1622260 RDI: 0000000000000003
[  989.970830][   T32] RBP: 0000000000060000 R08: 0000000000000000 R09: 00005651b1b1c8b0
[  989.972058][   T32] R10: 0000000000000003 R11: 0000000000000246 R12: 00005651b1622260
[  989.973341][   T32] R13: 0000000000000000 R14: 00005651b1b1af50 R15: 00005651b1b1ae20
[  989.974561][   T32]  </TASK>
[  989.975037][   T32] INFO: task systemd-journal:92 blocked for more than 491 seconds.
[  989.976285][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  989.977338][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.979000][   T32] task:systemd-journal state:D stack:0     pid:92    ppid:1      flags:0x00000000
[  989.981119][   T32] Call Trace:
[  989.982020][   T32]  <TASK>
[ 989.982888][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 989.983793][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 989.984786][ T32] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:378 arch/x86/kernel/unwind_orc.c:620) 
[ 989.985459][ T32] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 989.986085][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 989.986828][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 989.987663][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 989.988361][ T32] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073) 
[ 989.989399][ T32] ? down_write_killable (kernel/locking/rwsem.c:997) 
[ 989.990086][ T32] ? file_fdatawait_range (mm/filemap.c:3485) 
[ 989.990921][ T32] down_read (kernel/locking/rwsem.c:1518) 
[ 989.991817][ T32] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 989.993060][ T32] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 989.994335][ T32] ? d_same_name (arch/x86/include/asm/word-at-a-time.h:84 fs/dcache.c:227 fs/dcache.c:278 fs/dcache.c:2265) 
[ 989.995528][ T32] kernfs_dop_revalidate (include/linux/instrumented.h:68 include/linux/atomic/atomic-instrumented.h:27 fs/kernfs/dir.c:36 fs/kernfs/dir.c:42 fs/kernfs/dir.c:1135) 
[ 989.996846][ T32] lookup_fast (fs/namei.c:859 fs/namei.c:856 fs/namei.c:1651) 
[ 989.997996][ T32] ? kernfs_iop_permission (fs/kernfs/inode.c:294) 
[ 990.000155][ T32] walk_component (fs/namei.c:1994) 
[ 990.001367][ T32] link_path_walk+0x533/0xa00 
[ 990.002933][ T32] ? lookup_one_len_unlocked (fs/namei.c:2243) 
[ 990.004345][ T32] path_lookupat (fs/namei.c:2248 (discriminator 2) fs/namei.c:2478 (discriminator 2)) 
[ 990.005493][ T32] filename_lookup (fs/namei.c:2509) 
[ 990.006694][ T32] ? may_linkat (fs/namei.c:2502) 
[ 990.007891][ T32] ? strncpy_from_user (arch/x86/include/asm/uaccess.h:605 lib/strncpy_from_user.c:138) 
[ 990.009149][ T32] user_path_at_empty (fs/namei.c:2909) 
[ 990.010387][ T32] user_statfs (include/linux/namei.h:57 fs/statfs.c:103) 
[ 990.011522][ T32] ? __ia32_sys_ustat (fs/statfs.c:98) 
[ 990.012771][ T32] __do_sys_statfs (fs/statfs.c:196) 
[ 990.013989][ T32] ? user_statfs (fs/statfs.c:193) 
[ 990.015146][ T32] ? up_read (arch/x86/include/asm/atomic64_64.h:160 include/linux/atomic/atomic-long.h:71 include/linux/atomic/atomic-instrumented.h:1362 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1616) 
[ 990.015775][ T32] ? syscall_trace_enter+0x96/0x190 
[ 990.016557][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 990.017147][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  990.017918][   T32] RIP: 0033:0x7fd5039e98c7
[  990.018530][   T32] RSP: 002b:00007ffd5f26e0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
[  990.019615][   T32] RAX: ffffffffffffffda RBX: 00007ffd5f26e130 RCX: 00007fd5039e98c7
[  990.020612][   T32] RDX: 00007fd503aea1a4 RSI: 00007ffd5f26e130 RDI: 00007fd503ae0843
[  990.021627][   T32] RBP: 00007fd503ae0843 R08: 0000000000000000 R09: 0000000000000000
[  990.022622][   T32] R10: 00000000000002b0 R11: 0000000000000246 R12: 00007ffd5f26e2b8
[  990.023667][   T32] R13: 00007ffd5f26e2c8 R14: 00007fd503ae8610 R15: 0000000000000000
[  990.024655][   T32]  </TASK>
[  990.025154][   T32] INFO: task systemd-modules:93 blocked for more than 491 seconds.
[  990.027363][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  990.028884][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  990.030964][   T32] task:systemd-modules state:D stack:0     pid:93    ppid:1      flags:0x00000000
[  990.032126][   T32] Call Trace:
[  990.032627][   T32]  <TASK>
[ 990.033062][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 990.033683][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 990.034550][ T32] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:378 arch/x86/kernel/unwind_orc.c:620) 
[ 990.035252][ T32] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 990.035871][ T32] ? is_bpf_text_address (arch/x86/include/asm/preempt.h:85 include/linux/rcupdate.h:99 include/linux/rcupdate.h:805 kernel/bpf/core.c:721) 
[ 990.036528][ T32] ? kernel_text_address (kernel/extable.c:97 kernel/extable.c:94) 
[ 990.037170][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 990.038056][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 990.038750][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 990.039811][ T32] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073) 
[ 990.040514][ T32] ? down_write_killable (kernel/locking/rwsem.c:997) 
[ 990.041320][ T32] ? file_fdatawait_range (mm/filemap.c:3485) 
[ 990.042565][ T32] down_read (kernel/locking/rwsem.c:1518) 
[ 990.043578][ T32] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 990.044897][ T32] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 990.046130][ T32] ? d_same_name (arch/x86/include/asm/word-at-a-time.h:84 fs/dcache.c:227 fs/dcache.c:278 fs/dcache.c:2265) 
[ 990.053684][ T32] kernfs_dop_revalidate (include/linux/instrumented.h:68 include/linux/atomic/atomic-instrumented.h:27 fs/kernfs/dir.c:36 fs/kernfs/dir.c:42 fs/kernfs/dir.c:1135) 
[ 990.055053][ T32] lookup_fast (fs/namei.c:859 fs/namei.c:856 fs/namei.c:1651) 
[ 990.056152][ T32] ? kernfs_iop_permission (fs/kernfs/inode.c:294) 
[ 990.057463][ T32] walk_component (fs/namei.c:1994) 
[ 990.058592][ T32] link_path_walk+0x533/0xa00 
[ 990.060119][ T32] ? lookup_one_len_unlocked (fs/namei.c:2243) 
[ 990.061518][ T32] path_lookupat (fs/namei.c:2248 (discriminator 2) fs/namei.c:2478 (discriminator 2)) 
[ 990.062658][ T32] filename_lookup (fs/namei.c:2509) 
[ 990.063775][ T32] ? may_linkat (fs/namei.c:2502) 
[ 990.064820][ T32] ? strncpy_from_user (arch/x86/include/asm/uaccess.h:605 lib/strncpy_from_user.c:138) 
[ 990.066006][ T32] user_path_at_empty (fs/namei.c:2909) 
[ 990.067157][ T32] user_statfs (include/linux/namei.h:57 fs/statfs.c:103) 
[ 990.068186][ T32] ? __ia32_sys_ustat (fs/statfs.c:98) 
[ 990.069355][ T32] __do_sys_statfs (fs/statfs.c:196) 
[ 990.070342][ T32] ? user_statfs (fs/statfs.c:193) 
[ 990.071166][ T32] ? mm_account_fault (arch/x86/include/asm/irqflags.h:134 include/linux/memcontrol.h:1079 include/linux/memcontrol.h:1111 include/linux/memcontrol.h:1100 mm/memory.c:5123) 
[ 990.071937][ T32] ? handle_mm_fault (mm/memory.c:5262) 
[ 990.072580][ T32] ? up_read (arch/x86/include/asm/atomic64_64.h:160 include/linux/atomic/atomic-long.h:71 include/linux/atomic/atomic-instrumented.h:1362 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1616) 
[ 990.073128][ T32] ? do_user_addr_fault (include/linux/mmap_lock.h:170 arch/x86/mm/fault.c:1468) 
[ 990.073798][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 990.074387][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  990.075287][   T32] RIP: 0033:0x7f1b978518c7
[  990.075911][   T32] RSP: 002b:00007ffdb557fc48 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
[  990.077454][   T32] RAX: ffffffffffffffda RBX: 00007ffdb557fcc0 RCX: 00007f1b978518c7
[  990.078536][   T32] RDX: 00007f1b974d11a4 RSI: 00007ffdb557fcc0 RDI: 00007f1b974c7843
[  990.079636][   T32] RBP: 00007f1b974c7843 R08: 0000000000000000 R09: 9fb8220300000000
[  990.080743][   T32] R10: 00000000478bfbff R11: 0000000000000246 R12: 00007ffdb557fe48
[  990.081743][   T32] R13: 00007ffdb557fe58 R14: 00007f1b974cf610 R15: 0000000000000000
[  990.082740][   T32]  </TASK>
[  990.083412][   T32] INFO: task systemd-remount:94 blocked for more than 491 seconds.
[  990.085248][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  990.086674][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  990.089254][   T32] task:systemd-remount state:D stack:0     pid:94    ppid:1      flags:0x00000000
[  990.091522][   T32] Call Trace:
[  990.092433][   T32]  <TASK>
[ 990.093316][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 990.094513][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 990.095872][ T32] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:378 arch/x86/kernel/unwind_orc.c:620) 
[ 990.097243][ T32] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 990.098489][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 990.099700][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 990.100802][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 990.102163][ T32] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073) 
[ 990.103566][ T32] ? down_write_killable (kernel/locking/rwsem.c:997) 
[ 990.104932][ T32] ? file_fdatawait_range (mm/filemap.c:3485) 
[ 990.106279][ T32] down_read (kernel/locking/rwsem.c:1518) 
[ 990.107433][ T32] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 990.108819][ T32] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 990.110093][ T32] ? d_same_name (arch/x86/include/asm/word-at-a-time.h:84 fs/dcache.c:227 fs/dcache.c:278 fs/dcache.c:2265) 
[ 990.111095][ T32] kernfs_dop_revalidate (include/linux/instrumented.h:68 include/linux/atomic/atomic-instrumented.h:27 fs/kernfs/dir.c:36 fs/kernfs/dir.c:42 fs/kernfs/dir.c:1135) 
[ 990.111862][ T32] lookup_fast (fs/namei.c:859 fs/namei.c:856 fs/namei.c:1651) 
[ 990.112824][ T32] ? kernfs_iop_permission (fs/kernfs/inode.c:294) 
[ 990.114078][ T32] walk_component (fs/namei.c:1994) 
[ 990.114725][ T32] link_path_walk+0x533/0xa00 
[ 990.116148][ T32] ? lookup_one_len_unlocked (fs/namei.c:2243) 
[ 990.117495][ T32] path_lookupat (fs/namei.c:2248 (discriminator 2) fs/namei.c:2478 (discriminator 2)) 
[ 990.118168][ T32] filename_lookup (fs/namei.c:2509) 
[ 990.118831][ T32] ? may_linkat (fs/namei.c:2502) 
[ 990.119593][ T32] ? strncpy_from_user (arch/x86/include/asm/uaccess.h:605 lib/strncpy_from_user.c:138) 
[ 990.120820][ T32] user_path_at_empty (fs/namei.c:2909) 
[ 990.121746][ T32] user_statfs (include/linux/namei.h:57 fs/statfs.c:103) 
[ 990.122653][ T32] ? __ia32_sys_ustat (fs/statfs.c:98) 
[ 990.123499][ T32] __do_sys_statfs (fs/statfs.c:196) 
[ 990.124588][ T32] ? user_statfs (fs/statfs.c:193) 
[ 990.125742][ T32] ? mm_account_fault (arch/x86/include/asm/irqflags.h:134 include/linux/memcontrol.h:1079 include/linux/memcontrol.h:1111 include/linux/memcontrol.h:1100 mm/memory.c:5123) 
[ 990.126897][ T32] ? handle_mm_fault (mm/memory.c:5262) 
[ 990.128044][ T32] ? up_read (arch/x86/include/asm/atomic64_64.h:160 include/linux/atomic/atomic-long.h:71 include/linux/atomic/atomic-instrumented.h:1362 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1616) 
[ 990.129025][ T32] ? do_user_addr_fault (include/linux/mmap_lock.h:170 arch/x86/mm/fault.c:1468) 
[ 990.130186][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 990.131288][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  990.132597][   T32] RIP: 0033:0x7f2eda3488c7
[  990.133566][   T32] RSP: 002b:00007ffce4e63338 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
[  990.135381][   T32] RAX: ffffffffffffffda RBX: 00007ffce4e633b0 RCX: 00007f2eda3488c7
[  990.137068][   T32] RDX: 00007f2ed9fac1a4 RSI: 00007ffce4e633b0 RDI: 00007f2ed9fa2843
[  990.138642][   T32] RBP: 00007f2ed9fa2843 R08: 0000000000000000 R09: 0000000000000000
[  990.140356][   T32] R10: 00000000000002b0 R11: 0000000000000246 R12: 00007ffce4e63538
[  990.142047][   T32] R13: 00007ffce4e63548 R14: 00007f2ed9faa610 R15: 0000000000000000
[  990.143852][   T32]  </TASK>
[  990.144662][   T32] INFO: task udevadm:95 blocked for more than 491 seconds.
[  990.146198][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[  990.147520][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  990.149377][   T32] task:udevadm         state:D stack:0     pid:95    ppid:1      flags:0x00000000
[  990.151330][   T32] Call Trace:
[  990.152142][   T32]  <TASK>
[ 990.152910][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 990.153969][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 990.155177][ T32] ? kernel_text_address (kernel/extable.c:97 kernel/extable.c:94) 
[ 990.156388][ T32] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:378 arch/x86/kernel/unwind_orc.c:620) 
[ 990.157575][ T32] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 990.158682][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 990.159875][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 990.160867][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 990.162097][ T32] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073) 
[ 990.163373][ T32] ? down_write_killable (kernel/locking/rwsem.c:997) 
[ 990.164566][ T32] ? file_fdatawait_range (mm/filemap.c:3485) 
[ 990.165743][ T32] down_read (kernel/locking/rwsem.c:1518) 
[ 990.166742][ T32] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 990.168036][ T32] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 990.169190][ T32] ? d_same_name (arch/x86/include/asm/word-at-a-time.h:84 fs/dcache.c:227 fs/dcache.c:278 fs/dcache.c:2265) 
[ 990.170276][ T32] kernfs_dop_revalidate (include/linux/instrumented.h:68 include/linux/atomic/atomic-instrumented.h:27 fs/kernfs/dir.c:36 fs/kernfs/dir.c:42 fs/kernfs/dir.c:1135) 
[ 990.171430][ T32] lookup_fast (fs/namei.c:859 fs/namei.c:856 fs/namei.c:1651) 
[ 990.172459][ T32] ? kernfs_iop_permission (fs/kernfs/inode.c:294) 
[ 990.173637][ T32] walk_component (fs/namei.c:1994) 
[ 990.174710][ T32] link_path_walk+0x533/0xa00 
[ 990.176103][ T32] ? lookup_one_len_unlocked (fs/namei.c:2243) 
[ 990.177383][ T32] path_lookupat (fs/namei.c:2248 (discriminator 2) fs/namei.c:2478 (discriminator 2)) 
[ 990.178528][ T32] filename_lookup (fs/namei.c:2509) 
[ 990.179749][ T32] ? may_linkat (fs/namei.c:2502) 
[ 990.180834][ T32] ? strncpy_from_user (arch/x86/include/asm/uaccess.h:605 lib/strncpy_from_user.c:138) 
[ 990.181998][ T32] user_path_at_empty (fs/namei.c:2909) 
[ 990.183148][ T32] user_statfs (include/linux/namei.h:57 fs/statfs.c:103) 
[ 990.184197][ T32] ? __ia32_sys_ustat (fs/statfs.c:98) 
[ 990.185340][ T32] __do_sys_statfs (fs/statfs.c:196) 
[ 990.186430][ T32] ? user_statfs (fs/statfs.c:193) 
[ 990.187538][ T32] ? mm_account_fault (arch/x86/include/asm/irqflags.h:134 include/linux/memcontrol.h:1079 include/linux/memcontrol.h:1111 include/linux/memcontrol.h:1100 mm/memory.c:5123) 
[ 990.188691][ T32] ? handle_mm_fault (mm/memory.c:5262) 
[ 990.189867][ T32] ? up_read (arch/x86/include/asm/atomic64_64.h:160 include/linux/atomic/atomic-long.h:71 include/linux/atomic/atomic-instrumented.h:1362 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1616) 
[ 990.190867][ T32] ? do_user_addr_fault (include/linux/mmap_lock.h:170 arch/x86/mm/fault.c:1468) 
[ 990.192059][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 990.193125][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  990.194455][   T32] RIP: 0033:0x7f7e23ebf8c7
[  990.195521][   T32] RSP: 002b:00007ffe9f551448 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
[  990.197388][   T32] RAX: ffffffffffffffda RBX: 00007ffe9f5514c0 RCX: 00007f7e23ebf8c7
[  990.199194][   T32] RDX: 00007f7e23fe21a4 RSI: 00007ffe9f5514c0 RDI: 00007f7e23fd8843
[  990.201122][   T32] RBP: 00007f7e23fd8843 R08: 0000000000000000 R09: 9fb8220300000000
[  990.207119][   T32] R10: 00000000478bfbff R11: 0000000000000246 R12: 00007ffe9f551648
[  990.208948][   T32] R13: 00007ffe9f551670 R14: 00007f7e23fe0610 R15: 0000000000000000
[  990.210742][   T32]  </TASK>
[ 1481.315358][   T32] INFO: task systemd:1 blocked for more than 983 seconds.
[ 1481.316989][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[ 1481.318380][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1481.320287][   T32] task:systemd         state:D stack:0     pid:1     ppid:0      flags:0x00000000
[ 1481.322300][   T32] Call Trace:
[ 1481.323089][   T32]  <TASK>
[ 1481.323722][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 1481.324790][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 1481.325948][ T32] ? is_bpf_text_address (arch/x86/include/asm/preempt.h:85 include/linux/rcupdate.h:99 include/linux/rcupdate.h:805 kernel/bpf/core.c:721) 
[ 1481.327112][ T32] ? __kernel_text_address (kernel/extable.c:79) 
[ 1481.332555][ T32] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
[ 1481.333657][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 1481.334800][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 1481.335755][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 1481.337010][ T32] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073) 
[ 1481.338251][ T32] ? filter_irq_stacks (kernel/stacktrace.c:114) 
[ 1481.339367][ T32] ? down_write_killable (kernel/locking/rwsem.c:997) 
[ 1481.340483][ T32] ? kasan_save_stack (mm/kasan/common.c:46) 
[ 1481.341479][ T32] ? kasan_set_track (mm/kasan/common.c:52) 
[ 1481.342515][ T32] ? do_filp_open (fs/namei.c:601 fs/namei.c:612 fs/namei.c:3817) 
[ 1481.343547][ T32] ? do_sys_openat2 (fs/open.c:1356) 
[ 1481.344644][ T32] ? __x64_sys_openat (fs/open.c:1383) 
[ 1481.345757][ T32] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 1481.346788][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.348135][ T32] down_read (kernel/locking/rwsem.c:1518) 
[ 1481.349175][ T32] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 1481.350421][ T32] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 1481.357275][ T32] ? d_same_name (arch/x86/include/asm/word-at-a-time.h:84 fs/dcache.c:227 fs/dcache.c:278 fs/dcache.c:2265) 
[ 1481.358309][ T32] kernfs_dop_revalidate (include/linux/instrumented.h:68 include/linux/atomic/atomic-instrumented.h:27 fs/kernfs/dir.c:36 fs/kernfs/dir.c:42 fs/kernfs/dir.c:1135) 
[ 1481.359461][ T32] lookup_fast (fs/namei.c:859 fs/namei.c:856 fs/namei.c:1651) 
[ 1481.360441][ T32] ? kernfs_iop_permission (fs/kernfs/inode.c:294) 
[ 1481.361528][ T32] walk_component (fs/namei.c:1994) 
[ 1481.362501][ T32] link_path_walk+0x533/0xa00 
[ 1481.363800][ T32] ? lookup_one_len_unlocked (fs/namei.c:2243) 
[ 1481.365048][ T32] ? __mutex_init (arch/x86/include/asm/atomic.h:41 include/linux/atomic/atomic-instrumented.h:42 include/linux/osq_lock.h:30 kernel/locking/mutex.c:52) 
[ 1481.366100][ T32] ? __alloc_file (fs/file_table.c:154) 
[ 1481.367082][ T32] path_openat (fs/namei.c:2250 (discriminator 2) fs/namei.c:3787 (discriminator 2)) 
[ 1481.368064][ T32] ? vfs_tmpfile_open (fs/namei.c:3773) 
[ 1481.369074][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.370313][ T32] do_filp_open (fs/namei.c:3818) 
[ 1481.371266][ T32] ? __update_load_avg_se (kernel/sched/pelt.c:118 kernel/sched/pelt.c:226 kernel/sched/pelt.c:308) 
[ 1481.372368][ T32] ? may_open_dev (fs/namei.c:3812) 
[ 1481.373365][ T32] ? update_load_avg (kernel/sched/fair.c:3920 kernel/sched/fair.c:4255) 
[ 1481.374450][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.375378][ T32] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 1481.376371][ T32] ? alloc_fd (arch/x86/include/asm/bitops.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:29 fs/file.c:251 fs/file.c:540) 
[ 1481.377250][ T32] do_sys_openat2 (fs/open.c:1356) 
[ 1481.378142][ T32] ? build_open_flags (fs/open.c:1342) 
[ 1481.379113][ T32] __x64_sys_openat (fs/open.c:1383) 
[ 1481.380196][ T32] ? __ia32_compat_sys_open (fs/open.c:1383) 
[ 1481.381372][ T32] ? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 1481.382397][ T32] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:752) 
[ 1481.383565][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 1481.384625][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.385922][   T32] RIP: 0033:0x7f5c316f8be7
[ 1481.386955][   T32] RSP: 002b:00007ffc354a1f10 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 1481.388659][   T32] RAX: ffffffffffffffda RBX: 0000562309e04d60 RCX: 00007f5c316f8be7
[ 1481.390340][   T32] RDX: 0000000000080000 RSI: 0000562309eb1320 RDI: 00000000ffffff9c
[ 1481.396264][   T32] RBP: 0000562309eb1320 R08: 0000000000000008 R09: 0000000000000001
[ 1481.397989][   T32] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
[ 1481.399627][   T32] R13: 0000562309e04d60 R14: 0000000000000001 R15: 00007ffc354a2320
[ 1481.401415][   T32]  </TASK>
[ 1481.402318][   T32] INFO: task modprobe:90 blocked for more than 983 seconds.
[ 1481.403796][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[ 1481.405100][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1481.406876][   T32] task:modprobe        state:D stack:0     pid:90    ppid:1      flags:0x00004002
[ 1481.408746][   T32] Call Trace:
[ 1481.409491][   T32]  <TASK>
[ 1481.410226][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 1481.411131][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 1481.412410][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.413686][ T32] ? idr_get_free (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 lib/radix-tree.c:113 lib/radix-tree.c:1518) 
[ 1481.414741][ T32] ? down_write_trylock (kernel/locking/rwsem.c:414) 
[ 1481.415892][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 1481.416818][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 1481.417989][ T32] rwsem_down_write_slowpath (arch/x86/include/asm/current.h:41 kernel/locking/rwsem.c:1180) 
[ 1481.419239][ T32] ? down_timeout (kernel/locking/rwsem.c:1108) 
[ 1481.420298][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.421353][ T32] ? __kernfs_new_node (fs/kernfs/dir.c:651) 
[ 1481.422530][ T32] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 1481.423640][ T32] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
[ 1481.424626][ T32] ? rwsem_down_write_slowpath (kernel/locking/rwsem.c:1571) 
[ 1481.425959][ T32] ? kasan_save_stack (mm/kasan/common.c:47) 
[ 1481.427073][ T32] ? kasan_save_stack (mm/kasan/common.c:46) 
[ 1481.428236][ T32] kernfs_add_one (include/linux/kernfs.h:391 fs/kernfs/dir.c:754) 
[ 1481.429310][ T32] ? pcpu_chunk_refresh_hint (mm/percpu-internal.h:114 (discriminator 3) mm/percpu.c:762 (discriminator 3)) 
[ 1481.430476][ T32] kernfs_create_dir_ns (fs/kernfs/dir.c:1044) 
[ 1481.431645][ T32] sysfs_create_dir_ns (fs/sysfs/dir.c:61) 
[ 1481.432719][ T32] ? sysfs_create_mount_point (fs/sysfs/dir.c:41) 
[ 1481.433765][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.434806][ T32] ? __kmalloc_node_track_caller (include/linux/kasan.h:196 mm/slab_common.c:966 mm/slab_common.c:986) 
[ 1481.436081][ T32] kobject_add_internal (lib/kobject.c:65 lib/kobject.c:233) 
[ 1481.437226][ T32] kobject_init_and_add (lib/kobject.c:368 lib/kobject.c:451) 
[ 1481.438323][ T32] ? kobject_create_and_add (lib/kobject.c:444) 
[ 1481.439458][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.440515][ T32] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 1481.441649][ T32] ? srcu_module_notify (kernel/rcu/srcutree.c:1921 kernel/rcu/srcutree.c:1954) 
[ 1481.442760][ T32] ? tracepoint_module_notify (kernel/tracepoint.c:664 kernel/tracepoint.c:709 kernel/tracepoint.c:701) 
[ 1481.443936][ T32] mod_sysfs_setup (kernel/module/sysfs.c:361 kernel/module/sysfs.c:377) 
[ 1481.444989][ T32] ? module_add_modinfo_attrs (kernel/module/sysfs.c:374) 
[ 1481.446267][ T32] ? atomic_notifier_call_chain (kernel/notifier.c:343) 
[ 1481.447469][ T32] ? klp_module_coming (kernel/livepatch/core.c:1296) 
[ 1481.448606][ T32] ? load_module (kernel/module/main.c:2758 kernel/module/main.c:2945) 
[ 1481.449662][ T32] load_module (kernel/module/main.c:2965) 
[ 1481.450708][ T32] ? post_relocation (kernel/module/main.c:2829) 
[ 1481.451842][ T32] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
[ 1481.452990][ T32] ? __cond_resched (kernel/sched/core.c:8533) 
[ 1481.454080][ T32] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 1481.455293][ T32] __do_sys_finit_module (kernel/module/main.c:3099) 
[ 1481.456528][ T32] ? __ia32_sys_init_module (kernel/module/main.c:3061) 
[ 1481.457660][ T32] ? randomize_page (mm/util.c:533) 
[ 1481.458766][ T32] ? ksys_mmap_pgoff (mm/mmap.c:1445) 
[ 1481.459899][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 1481.460801][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.462053][   T32] RIP: 0033:0x7feb8112a9b9
[ 1481.463109][   T32] RSP: 002b:00007ffd74170a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 1481.465024][   T32] RAX: ffffffffffffffda RBX: 000055ac05343d30 RCX: 00007feb8112a9b9
[ 1481.466632][   T32] RDX: 0000000000000000 RSI: 000055ac05277260 RDI: 0000000000000003
[ 1481.468414][   T32] RBP: 0000000000060000 R08: 0000000000000000 R09: 000055ac053458b0
[ 1481.470222][   T32] R10: 0000000000000003 R11: 0000000000000246 R12: 000055ac05277260
[ 1481.471905][   T32] R13: 0000000000000000 R14: 000055ac05343cb0 R15: 000055ac05343d30
[ 1481.473600][   T32]  </TASK>
[ 1481.474351][   T32] INFO: task modprobe:91 blocked for more than 983 seconds.
[ 1481.475846][   T32]       Not tainted 6.3.0-12053-ga551138c4b3b #1
[ 1481.477177][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1481.479050][   T32] task:modprobe        state:D stack:0     pid:91    ppid:1      flags:0x00004002
[ 1481.480969][   T32] Call Trace:
[ 1481.481794][   T32]  <TASK>
[ 1481.482535][ T32] __schedule (kernel/sched/core.c:5343 kernel/sched/core.c:6669) 
[ 1481.483542][ T32] ? io_schedule_timeout (kernel/sched/core.c:6551) 
[ 1481.484706][ T32] ? osq_unlock (kernel/locking/osq_lock.c:22 kernel/locking/osq_lock.c:210) 
[ 1481.485728][ T32] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6746 (discriminator 1)) 
[ 1481.486675][ T32] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:6805) 
[ 1481.487928][ T32] rwsem_down_write_slowpath (arch/x86/include/asm/current.h:41 kernel/locking/rwsem.c:1180) 
[ 1481.489130][ T32] ? down_timeout (kernel/locking/rwsem.c:1108) 
[ 1481.490248][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.491354][ T32] ? __kernfs_new_node (fs/kernfs/dir.c:651) 
[ 1481.492438][ T32] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
[ 1481.493342][ T32] ? rwsem_down_write_slowpath (kernel/locking/rwsem.c:1571) 
[ 1481.494468][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.495663][ T32] ? notifier_call_chain (kernel/notifier.c:95) 
[ 1481.496756][ T32] ? blocking_notifier_call_chain_robust (kernel/notifier.c:129 kernel/notifier.c:353 kernel/notifier.c:341) 
[ 1481.498045][ T32] ? load_module (include/linux/notifier.h:209 kernel/module/main.c:2764 kernel/module/main.c:2945) 
[ 1481.499131][ T32] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 1481.500344][ T32] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 1481.501394][ T32] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.502720][ T32] kernfs_add_one (include/linux/kernfs.h:391 fs/kernfs/dir.c:754) 
[ 1481.503801][ T32] kernfs_create_dir_ns (fs/kernfs/dir.c:1044) 
[ 1481.504981][ T32] sysfs_create_dir_ns (fs/sysfs/dir.c:61) 
[ 1481.505997][ T32] ? sysfs_create_mount_point (fs/sysfs/dir.c:41) 
[ 1481.507197][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.509314][ T32] ? __kmalloc_node_track_caller (include/linux/kasan.h:196 mm/slab_common.c:966 mm/slab_common.c:986) 
[ 1481.510619][ T32] kobject_add_internal (lib/kobject.c:65 lib/kobject.c:233) 
[ 1481.511958][ T32] kobject_init_and_add (lib/kobject.c:368 lib/kobject.c:451) 
[ 1481.513079][ T32] ? kobject_create_and_add (lib/kobject.c:444) 
[ 1481.514276][ T32] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 1481.515339][ T32] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 1481.516463][ T32] ? ddebug_module_notify (lib/dynamic_debug.c:1344 lib/dynamic_debug.c:1336) 
[ 1481.517587][ T32] mod_sysfs_setup (kernel/module/sysfs.c:361 kernel/module/sysfs.c:377) 
[ 1481.518672][ T32] ? module_add_modinfo_attrs (kernel/module/sysfs.c:374) 
[ 1481.519892][ T32] ? atomic_notifier_call_chain (kernel/notifier.c:343) 
[ 1481.521125][ T32] ? klp_module_coming (kernel/livepatch/core.c:1296) 
[ 1481.522271][ T32] ? load_module (kernel/module/main.c:2758 kernel/module/main.c:2945) 
[ 1481.523331][ T32] load_module (kernel/module/main.c:2965) 
[ 1481.524366][ T32] ? post_relocation (kernel/module/main.c:2829) 
[ 1481.525461][ T32] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
[ 1481.526548][ T32] ? __cond_resched (kernel/sched/core.c:8533) 
[ 1481.527585][ T32] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 1481.528682][ T32] __do_sys_finit_module (kernel/module/main.c:3099) 
[ 1481.529764][ T32] ? __ia32_sys_init_module (kernel/module/main.c:3061) 
[ 1481.530866][ T32] ? randomize_page (mm/util.c:533) 
[ 1481.531860][ T32] ? ksys_mmap_pgoff (mm/mmap.c:1445) 
[ 1481.532922][ T32] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 1481.533948][ T32] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 1481.535161][   T32] RIP: 0033:0x7f1d905f79b9
[ 1481.536136][   T32] RSP: 002b:00007ffc9133bbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 1481.537935][   T32] RAX: ffffffffffffffda RBX: 00005651b1b1ae20 RCX: 00007f1d905f79b9
[ 1481.539611][   T32] RDX: 0000000000000000 RSI: 00005651b1622260 RDI: 0000000000000003
[ 1481.541313][   T32] RBP: 0000000000060000 R08: 0000000000000000 R09: 00005651b1b1c8b0
[ 1481.543097][   T32] R10: 0000000000000003 R11: 0000000000000246 R12: 00005651b1622260
[ 1481.544859][   T32] R13: 0000000000000000 R14: 00005651b1b1af50 R15: 00005651b1b1ae20
[ 1481.546692][   T32]  </TASK>
[ 1481.547492][   T32] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
BUG: kernel hang in test stage

Kboot worker: lkp-worker18
Elapsed time: 2520

kvm=(
qemu-system-x86_64
-enable-kvm
-cpu SandyBridge
-kernel $kernel
-initrd initrd-vm-meta-147.cgz
-m 16384
-smp 2
-device e1000,netdev=net0
-netdev user,id=net0,hostfwd=tcp::32032-:22
-boot order=nc
-no-reboot
-device i6300esb
-watchdog-action debug
-rtc base=localtime
-serial stdio
-display none
-monitor null
)

append=(
ip=::::vm-meta-147::dhcp
root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/vmlinuz-6.3.0-12053-ga551138c4b3b
branch=linux-review/Dominique-Martinet/fs-split-off-vfs_getdents-function-of-getdents64-syscall/20230510-185542
job=/job-script
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=a551138c4b3b9fd7e74a55d6074a013bab6246db
initcall_debug
nmi_watchdog=0
vmalloc=256M
initramfs_async=0


To reproduce:

        # build kernel
	cd linux
	cp config-6.3.0-12053-ga551138c4b3b .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--w/tzJwjKlNe4QZ5C
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="config-6.3.0-12053-ga551138c4b3b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
# CONFIG_ATH12K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_SVM is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_SUNRPC_XPRT_RDMA is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_PER_VMA_LOCK_STATS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_FAULT_INJECTION_CONFIGFS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--w/tzJwjKlNe4QZ5C
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-review/Dominique-Martinet/fs-split-off-vfs_getdents-function-of-getdents64-syscall/20230510-185542'
	export commit='a551138c4b3b9fd7e74a55d6074a013bab6246db'
	export kconfig='x86_64-rhel-8.3-func'
	export repeat_to=6
	export nr_vm=300
	export submit_id='6461b60613a273aec2a5a9aa'
	export job_file='/lkp/jobs/scheduled/vm-meta-147/boot-1-debian-11.1-x86_64-20220510.cgz-a551138c4b3b9fd7e74a55d6074a013bab6246db-20230515-44738-o6q2e1-4.yaml'
	export id='a612367428fc2fea127ca8947f5abe49eb22a378'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-05-15 12:33:11 +0800'
	export _id='6461b61f13a273aec2a5a9ab'
	export _rt='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/vmlinuz-6.3.0-12053-ga551138c4b3b
branch=linux-review/Dominique-Martinet/fs-split-off-vfs_getdents-function-of-getdents64-syscall/20230510-185542
job=/lkp/jobs/scheduled/vm-meta-147/boot-1-debian-11.1-x86_64-20220510.cgz-a551138c4b3b9fd7e74a55d6074a013bab6246db-20230515-44738-o6q2e1-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=a551138c4b3b9fd7e74a55d6074a013bab6246db
initcall_debug
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export stop_repeat_if_found='dmesg.INFO:task_blocked_for_more_than#seconds'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-147'
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/a551138c4b3b9fd7e74a55d6074a013bab6246db/vmlinuz-6.3.0-12053-ga551138c4b3b'
	export dequeue_time='2023-05-15 12:37:46 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-147/boot-1-debian-11.1-x86_64-20220510.cgz-a551138c4b3b9fd7e74a55d6074a013bab6246db-20230515-44738-o6q2e1-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--w/tzJwjKlNe4QZ5C
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--w/tzJwjKlNe4QZ5C--
