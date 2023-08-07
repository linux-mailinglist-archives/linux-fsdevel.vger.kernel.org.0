Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF777185A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjHGCcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 22:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHGCcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:32:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2A97;
        Sun,  6 Aug 2023 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691375566; x=1722911566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=onC7K8NB1Xczq7BMmDrmK0HAm266VBasqP/X31w6yM0=;
  b=k4BPDXl4CSsGdjAI/5aAJEqLOjUvLG5GaCjTIDVJ0iaIX89vjBkgV3lE
   fqJUh1pqFsqAqR+vHITtvFv2zIOnrTBsnM0SUWGYGKRCCtjgGpCyOYXxA
   MsOv14hZBJJWoVoaNhMiqBkZhWID5piw7ahWQ6BrScVSLv7zNlWMI0ZoM
   K6Y7py4D1I/aB7Z7DvoW6rVk7tHypzgKVr7BHpBz1ZhyQPQiv/PIsLlIw
   KelguutMHZofNHdeyC5z/C17vN6qWsef8f2BTkG+GVKea/zLhrX94fvFh
   pC0jkA8MmGZ0ZRjjSn48dcGfawZEwsszSsRYWmwB8su99D7nLhr8ki6LA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="373192109"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="373192109"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 19:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="707691437"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="707691437"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2023 19:32:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 19:32:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 6 Aug 2023 19:32:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 6 Aug 2023 19:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkuQHHhMlX/UdKqFYUY3/zXHYMy2lb+iVYSyqOEr9vrQwqYmRmBZGyXtqKsQdMVcLx0PKUIDXIeMGEy3J0GaUpuiWrSpjUAN1MUpRsRQOMmfbk8LjVR4EI1VQp3GV5k/nnsceZw3mpCnArmDsj4ALvMxP302qRyqA4FXYHRqZVWwZMVZFwiw+BcPPxsGBNHYpfsmFw0Uhprzl6Mo8NtsS4O1MzJ2E9zGkBirwGieuxHLe8pqKBM0OBZQNLzwuem+9yh5z82Xp1lrFUhgsUVAQvbwrl13vvJsmSRsQ7MeIUqo3uXGtaCst9p31bH53/Dj3AjnoyRqoPOZXMgJBEZzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TTdyNBcMpXLJYn7ywc3l0zAzBIl7+K+kbYdBf3jDa8=;
 b=EdUQsM7PTGeVraohB3q+trnFu6guaTggJITe1pkp/LLo9EO/O/TWR1GdanKVnCekalKFo3EFLJ+9lgTfVrT3Is09+lzrxh1af5OPIuXhIKoa4h55jF31+XzpecXoE9Xze6UP2rGCAIpJgEFjrFDnkOvFqSwJkNDeNvXGK0zMYBABePU54pw4HzD5LPos0PRnvj4iy06MgOj+O9Xv+JNYNhdtfx4VlARVkiMoxAO1EqHGH69GHlVenRLnL7Cl7X02G/kiwn7KgoL/TCCEFnbOLi+bdMccpXBtgVZ2UvTPpTVCarl+u+L1uw2gLS4IB1O6GUmLGiQ5/1duoGDi/vbsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:32:25 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::38b4:292a:6bad:7775]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::38b4:292a:6bad:7775%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 02:32:25 +0000
Date:   Mon, 7 Aug 2023 10:34:50 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Brian Foster <bfoster@redhat.com>
CC:     syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tytso@mit.edu>, <heng.su@intel.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_file_write_iter
Message-ID: <ZNBYSso27S6L3sgS@xpf.sh.intel.com>
References: <0000000000007faf0005fe4f14b9@google.com>
 <000000000000a3f45805ffcbb21f@google.com>
 <ZMsE2q9VX2sQFh/g@xpf.sh.intel.com>
 <ZM0Aj6sBk/5TPdLS@bfoster>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZM0Aj6sBk/5TPdLS@bfoster>
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d1d3a1-772e-476c-5bcd-08db96ee8936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXp85wkgJyPR/pOp8t08VKwMDhNIZO7iSNwcVyPJTbEbh7sVePJTF35jIc6MHhoZsK1Rx97VU4TovKs8+WC+tMF+y6YTBQVJNG5OYumtpmV6yT21RTqSVAD3XLAHQ2AhBMG9NCUm93Pfjb6miR82LnVFQ/bRGDne1PHooRkqGVGOQZLUBjX//zTNYSl09/svp/Pw487S6gp0z0LteVA2Pn/innw6r/AOZPFEJHnWNHmOG5SnjKhQMzBgzoQQi8yBqC+GIOubutyLMSPsDaYrzrcWNeKaSh3v979QwggXSmDoNf9VphQWm3GfGJHT4LwtnH4JqzbPLZiByyt+4sDfgPZAFeRiY4HeToYKAz5H6sQtXJQeocfcKXvw6s5hhpU1tZh8tRsyL+rNBxkkEdCJFVTo6+bEm4PxK31vsJOU0Ak7evYoAaeqnl5e7JAGBpx27/dvLg8U6XlRo3eBkM7li0iJHEL6Lwc85rYWKcrXigyJIFKkiMo3SzQr48Wy9nlsqWOV4GUNsH2nOpDIrOEYQi2tHa9q0wOIuQzVOuZIRQUj3kplDu8C841gRVpCGjVWxQTKeS8NOoui8YOBGVYbIpxuArMB32oZGMWyKi1Zko5FtkZMUnuJMo2q2bZPQfmIKkBBk4Ph6KkImas1oQVyCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(1800799003)(186006)(2906002)(83380400001)(5660300002)(6666004)(38100700002)(6486002)(66476007)(66556008)(6916009)(66946007)(966005)(6512007)(82960400001)(45080400002)(4326008)(316002)(41300700001)(86362001)(44832011)(107886003)(8936002)(8676002)(26005)(6506007)(478600001)(53546011)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHOgbZbKCVCULdlvFyT1OU1QbqAgt00pfIvt1u4wpu2+aullwepEq7cBLtjr?=
 =?us-ascii?Q?X3t+waiMp7ZaTRles4KeYpxIdFk2f30V0mRSyGV7jNqLA6GinVNi49vxW7Wf?=
 =?us-ascii?Q?ikqH+O3uCDTwA4XgwoqH5oHeemuYv+OGI21AtZ/ty2rkdr3ED1Q4ECMApRBj?=
 =?us-ascii?Q?tMdvEqYW8vHJ4i56b1qMu6spg07e9c+Clw7F8xJ5yY4h1iiw5Gnd+Qm6Ab9r?=
 =?us-ascii?Q?kq1WQLyjR/YWR0rVot2LDijZll/dpZlDK/VE66qotwgZ9wUP9Q3xiG9d0bET?=
 =?us-ascii?Q?eCu20ctQVihRdAgTYcXQbSf6OlGmkF19CgbdBgPBlsh0lnf46dQ4XUTIdRNf?=
 =?us-ascii?Q?8nwEau889Qr+XFvBAOFhgKaq8pztiuoRuz1BcFVlYRHO8psRVTj3wGqi1VvF?=
 =?us-ascii?Q?Qh8/NQCxHXP7Z4fnGjLnyhkQAPDSb2vhXuWkqrfu9a411oWWWgmhJNWJ9Upg?=
 =?us-ascii?Q?BATHPQmoXmM0vu9/UrYpW6MSQ73cgUJcUUbFdoFrhrkEHhU3286hEhvAeRk/?=
 =?us-ascii?Q?OhErYZqBYUSyfmYdhQdZIP4q6mWhA8DIYhYLMQpAP2298OtVmrqgWotO9L7D?=
 =?us-ascii?Q?46Gc7qjnCNBd7cD1cI6iIxGbACgETjh+8NAYngQgsGH/ZPldPti4pFihBi89?=
 =?us-ascii?Q?DDp+kzs36DOTxM0KRCo9kVPT0Jwr15CpQEQ2MUtrmSnfXgQ4yoc6Z5ucIuuj?=
 =?us-ascii?Q?yW7Y8sRjP/N1RHKb81YfPNCWa6OOe1srjOQ+lrZwqcRO4tjfS2wbJka8Cj+R?=
 =?us-ascii?Q?SD5edbTg8A0Zu3FLfuP719IOP6O0IOtYwnso653rpC3FrplXxVF/K1dPztIe?=
 =?us-ascii?Q?6lAZ65Cu5MyE3nmRBddAKkDzikvHjBwcMziOqFcQgNbIkmCPDy8Vb+1rbajj?=
 =?us-ascii?Q?DD2O/XwB19miTfiqbOaHa8Xuu+2RrnUsUGAwhLK/6pHS4LRh27JccCbrnnas?=
 =?us-ascii?Q?GWLDhcdUQlrF9EeITtcES+8RDCkYKZyKrMTZS2uuvBgOYgZ6pqtMZ/wQAxea?=
 =?us-ascii?Q?b5Ho4Mpv61ndmQxPpNOXyPElPcEU1KzJzMfqCSYIl0mcwV0Zo0AtLl0I2XVL?=
 =?us-ascii?Q?B3BScJFe+Tm5W29WNglOJAfMKBl14d2511ZdbhBkr2GM7AOw8CW2B00Jp6EF?=
 =?us-ascii?Q?+wiHqhRg2JctcoNV8N4aKUmJaIvjNeHDwO1FvpnBe/6ZxvNQJaPyMbPfQQai?=
 =?us-ascii?Q?YmxqB5kmTN8Bj6cUM72fh4KNwbMp8vaCjXHR3lSpTQhWTBK9AvglCVvY+xQO?=
 =?us-ascii?Q?FnmIjQHt6t5R+vQbJqmJoUZQy199eWrKkExNPfzP09nBJ4Q0ruXgiaLdS4Rb?=
 =?us-ascii?Q?G3NENa/b1NHBtg0ABqPQjHD7P2Oc2dAzH8JZaKGX0Whs8oplnTUUVA0r6Ibu?=
 =?us-ascii?Q?rjmyLxWroY5dMM17lmT8jnp2KqdoPI0eGfN8vPFkEgjxPBYcJxxNq/3H8Lhx?=
 =?us-ascii?Q?sRIKCQEYmKCfU/4vi6dwWjrfi5g3Ap0oy7vD2XviFOY4qwAmzW2VnBpLaHAl?=
 =?us-ascii?Q?DsqkVBLXHNPwk6Re2k4WW305zRZaBrvHBCPMmkcn317a+vyHF+4QyRxwZ37N?=
 =?us-ascii?Q?tKExUVD8QaXQslnVNEnjD6IPYLxEAkyeO+j+JTX0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d1d3a1-772e-476c-5bcd-08db96ee8936
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:32:25.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3bRbPmOvPc9Qokc1oav8Eo3uGQm97t0xq1gsVA5y+17N5UIgt0Pp+dMjg9NqXp02IDO7Ox8P8XqISw55FvJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Brian,

On 2023-08-04 at 09:43:43 -0400, Brian Foster wrote:
> On Thu, Aug 03, 2023 at 09:37:30AM +0800, Pengfei Xu wrote:
> > On 2023-07-05 at 23:33:43 -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > > 
> > > HEAD commit:    6843306689af Merge tag 'net-6.5-rc1' of git://git.kernel.o..
> > > git tree:       net
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=114522aca80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102cb190a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c49d90a80000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/f6adc10dbd71/disk-68433066.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/5c3fa1329201/vmlinux-68433066.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/84db3452bac5/bzImage-68433066.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
> > > 
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
> > > WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
> > > Modules linked in:
> > > CPU: 1 PID: 5382 Comm: syz-executor288 Not tainted 6.4.0-syzkaller-11989-g6843306689af #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> > > RIP: 0010:ext4_dio_write_iter fs/ext4/file.c:611 [inline]
> > > RIP: 0010:ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
> > > Code: 84 03 00 00 48 8b 04 24 31 ff 8b 40 20 89 c3 89 44 24 10 83 e3 08 89 de e8 5d 5a 5b ff 85 db 0f 85 d5 fc ff ff e8 30 5e 5b ff <0f> 0b e9 c9 fc ff ff e8 24 5e 5b ff 48 8b 4c 24 40 4c 89 fa 4c 89
> > > RSP: 0018:ffffc9000522fc30 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > RDX: ffff8880277a3b80 RSI: ffffffff82298140 RDI: 0000000000000005
> > > RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a832a60
> > > R13: 0000000000000000 R14: 0000000000000000 R15: fffffffffffffff5
> > > FS:  00007f154db95700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f154db74718 CR3: 000000006bcc7000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  call_write_iter include/linux/fs.h:1871 [inline]
> > >  new_sync_write fs/read_write.c:491 [inline]
> > >  vfs_write+0x981/0xda0 fs/read_write.c:584
> > >  ksys_write+0x122/0x250 fs/read_write.c:637
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f154dc094f9
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f154db952f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > > RAX: ffffffffffffffda RBX: 00007f154dc924f0 RCX: 00007f154dc094f9
> > > RDX: 0000000000248800 RSI: 0000000020000000 RDI: 0000000000000006
> > > RBP: 00007f154dc5f628 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 652e79726f6d656d
> > > R13: 656c6c616b7a7973 R14: 6465646165726874 R15: 00007f154dc924f8
> > >  </TASK>
> > > 
> > 
> > Above issue in dmesg is:
> > "WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]"
> > 
> > I found the similar behavior issue:
> > "WARNING: CPU: 0 PID: 182134 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]"
> > repro.report shows similar details.
> > 
> > Updated the bisect info for the above similar issue:
> > Bisected and the problem commit was:
> > "
> > 310ee0902b8d9d0a13a5a13e94688a5863fa29c2: ext4: allow concurrent unaligned dio overwrites
> > "
> > After reverted the commit on top of v6.5-rc3, this issue was gone.
> > 
> 
> Hi Pengfei,
> 
> Thanks for narrowing this down (and sorry for missing the earlier
> report). Unfortunately I've not been able to reproduce this locally
> using the generated reproducer. I tried both running the test program on
> a local test vm as well as booting the generated disk image directly.
> 
> That said, I have received another report of this warning that happens
> to be related to io_uring. The cause in that particular case is that
> io_uring sets IOCB_HIPRI, which iomap dio turns into
> REQ_POLLED|REQ_NOWAIT on the bio without necessarily having IOCB_NOWAIT
> set on the request. This means we can expect -EAGAIN returns from the
> storage layer without necessarily passing DIO_OVERWRITE_ONLY to iomap,
> which in turn basically means that the warning added by this commit is
> wrong.
> 
> I did submit the test patch at the link [1] referenced below to syzbot
> to see if the OVERWRITE_ONLY flag is set and the results I got this
> morning only showed the original !IOCB_NOWAIT warning. So while I still
> do not know the source of the -EAGAIN in the syzbot test (and I would
> like to), this shows that the overwrite flag is not involved and thus
> the -EAGAIN is presumably unrelated to that logic.
> 
> So in summary I think the right fix is to just remove the overwrite flag
> and warning from this ext4 codepath. It was always intended as an extra
> precaution to support the warning, and the latter is clearly wrong. I'll
> submit another test change in a separate mail just to see if syzbot
> finds anything else and plan to send a proper patch to the list. In the
> meantime, if you have any suggestions to help reproduce via the
> generated program, I'm still interested in trying to grok where that
> particular -EAGAIN comes from.. Thanks.

Thanks for your patch! I'm glad it's helpful.

It could not be reproduced immediately and it takes more than 200s to
reproduce this issue, anyway here is my reproduced steps.
As following link info for example, it's not my reproduced environment and it's
alsmost the same for issue reproducing:
https://lore.kernel.org/all/0000000000007faf0005fe4f14b9@google.com/T/#mf1678f17b7b7c4b3cc73abef436aac68787397ae
  -> disk image: https://storage.googleapis.com/syzbot-assets/f6adc10dbd71/disk-68433066.raw.xz
  -> kernel image: https://storage.googleapis.com/syzbot-assets/84db3452bac5/bzImage-68433066.xz

I used below simple script to boot up vm:
"
#!/bin/bash

bzimage=$1

[[ -z "$bzimage" ]] && bzimage="./bzImage-68433066"
qemu-system-x86_64 \
        -m 2G \
        -smp 2 \
        -kernel $bzimage \
        -append "console=ttyS0 root=/dev/sda1 earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg" \
        -drive file=./disk-68433066.raw,format=raw \
        -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10023-:22 \
        -cpu host \
        -net nic,model=e1000 \
        -enable-kvm \
        -nographic \
        2>&1 | tee vmd.log
"

gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

And then access to above vm and execute the reproduced binary to reproduce.
Sometimes it takes some time to reproduce the problem.
Hope the above information helps you to reproduce the problem next time.

I saw syzbot already verified your latest patch and it's passed.
https://syzkaller.appspot.com/x/log.txt?x=17939bc1a80000

Best Regards,
Thanks!

> 
> Brian
> 
> [1] https://syzkaller.appspot.com/x/patch.diff?x=109a7c96a80000
> 
> > All information: https://github.com/xupengfe/syzkaller_logs/tree/main/230730_134501_ext4_file_write_iter
> > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.c
> > repro.prog(syscall reproduced steps): https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.prog
> > repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.report
> > Bisect log: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/bisect_info.log
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/kconfig_origin
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/6eaae198076080886b9e7d57f4ae06fa782f90ef_dmesg.log
> > 
> > Best Regards,
> > Thanks!
> > 
> > > 
> > > ---
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> 
