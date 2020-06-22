Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0864D2032F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFVJJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:09:18 -0400
Received: from mail-bn8nam12hn2214.outbound.protection.outlook.com ([52.100.165.214]:25409
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgFVJJQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1S1VTT86868q33LAkMz3A+P0rzKM6fvqTgI70xD/NyAkMFjuNNjqgDvPCF/NGYaMuyftsOonTeR6kw3t9Fy68lJEx4IsTNZfnRQT4uS9NeW0d8vPZFAosC3Thu4by4Q6ToO8gwR7OZcruiZT26EguposkTHt50O67ztheV7C1vd3NUcj6/J1Wd8qnfcagtYveSXrHDFQwPE3U4V7Ukuawc3xVezMQbVK3hCwJOtmOgcf/3vZJ7uWUiV/NKhk7+C3pra6AV/CTtH5c1nRAStFaeAMNQvTkpgRRiLM6n8zxIHAxAUrvV0l2YmzGhTTtTXN3jl3DR0GXGK/bM5vep3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjboPE8FDhP5OaCazEg75N3dpaR2SdubrLhT0eMTIuM=;
 b=eMdBh9zgQcZfNTBwGl5IJErIgDETHF4ptzQ9GmkW7ECrnul/6wUosqlW9mOoJZperfiJ+o0JEq5nEEp4T2DlOmetMr3RSOMBVXVoUhUe7dOqhAt04e4ZXE6OMHZ0szQK5u2w++Z9DqdEw6WnXxMjhGGdWScxENnDWT9R5l3Fxi/OlwTkRrYD9MdVopf01yAW2DNXSmz53hjJniw8FlS0yydfGDEMFD+z3grQy4dbmZsMOv2J/xCneW0/cfc470z32/Vd10NXyhg8QFqz97eM2uncwa04PxYsFK61XxTBxVhwRH5U4P2Tefj++yw6JAqmfkRAdXZIrcVm6cQgX4wF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjboPE8FDhP5OaCazEg75N3dpaR2SdubrLhT0eMTIuM=;
 b=MAUnUwCFBSRIucQ1pbSUmUgzLcuQaXxeJDLnyy9PKnoUpDCYzCvKXAGM9kJlhvOMKrEDe55AecQxyoGRdc/L9dkgbXVImfus1iClnGai+YVCISg2pK1i8vfWUjE8uVvyFdDYwhlIQfafTGYj4RkPlVcZnpg88DW68KlN9eqapqo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3311.namprd11.prod.outlook.com (2603:10b6:805:c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:09:12 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::b15b:3bd8:5bf1:1a55]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::b15b:3bd8:5bf1:1a55%6]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:09:12 +0000
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200410114720.24838-1-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <7a658764-31bd-95ac-0041-6b5064fba159@windriver.com>
Date:   Mon, 22 Jun 2020 17:09:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200410114720.24838-1-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 09:09:11 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90c2eb3-7128-4a7e-8965-08d8168bee2d
X-MS-TrafficTypeDiagnostic: SN6PR11MB3311:
X-Microsoft-Antispam-PRVS: <SN6PR11MB33115962135A318304A45E188F970@SN6PR11MB3311.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh/vrYJMP2tOIbmwgTA3HxIj2cZ2RceuW1ffD4sBsI1uhgXRelqlDnLiiemONF+YHVTaxtvKBwmcvAgo43XD7fNBrsuFTTm+5TaeYKRHk047vOkJd3s5cx/YXTthm0QPW7LsMTa6p7RHg3ZvRQsysfYbokQRKbLsrLhMo4OT5V3lhybrw76gauALbtr6WNNdn4G30dZNoTfCo1dBMaiuI/fziFFVqBFH41rfB+c/ZHYxRzk1bighs6rZkPxkuydgAo/FWRPUCdS+thRQhJJBZW5TYbSi+hrsz2dpRDhp+hXuM8NY6I5oJ7QnwvNRsQ5GYSGagoMyUk1g6U8CfpZY0spPCrXFhqVe+p+mCsnikTFe3UcJ4Enc/d/WVYOxM+SydyfSh8xFbade+XJenjrraGRB8/GSR7+PqbC+PIJpt05Uqmzydqphct+ovzneEdy20q6xb8N2q7hpCl9MONV/JlufdyZ6Mo6Ank1A8f86pmigPx7p6kKx7IHaBVFnzxaQpah8Ef9ZKZZyb1KWTkt/Qun3UtDMjau4yWiwUyGun+yLqtTm4ITs/MOj2iGu5HVlJE0Bp4OmxfzVVHyp0ZvbF1NbvgFv03ZTJj7rs6k+TKQZvGxLGUsxzf0yZn6XPxD2Nflmdt85XsfIF8zP4fjh8Uwp2NQYokMSJM2b76MmuDlrziIkxZOYUZX8PtPr562wzggVL9dIfvdQ3HAmQCp8ocGo0KKo43CVvhEVpD/qb2nj3AJ9H5ohxgnumpjDWC6E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(136003)(376002)(346002)(39850400004)(366004)(396003)(66476007)(66556008)(66946007)(83380400001)(5660300002)(31696002)(2616005)(31686004)(956004)(86362001)(6666004)(2906002)(8676002)(52116002)(16526019)(186003)(26005)(53546011)(6486002)(16576012)(316002)(478600001)(8936002)(6706004)(36756003)(78286006)(161623001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: oAqt3B/QMhhYNReEtnAe/k6mBTcoyMpA+7LDLz58rtSJveyjGp8ct1R79bbBUs+90Pvh7MgyfGNSXgmYuIxkdExTkz/BFjsvaWePumO0OOgT0ql3pZeg0on/0I+ewFV4DCDXGaeBPr/IPed3FXTi/XKo3EMl89o7SvGlAo491Tq8YPR8cJ/s4RKH+p/1q1bDxa6crvJQBLKkJNtkd0/6lB/cJLrHJODsYQp8Ynh7T/SqC2FmYPJtN410jQyVZtZOELXSXwW9MVhK6FE1EGkY7dflfwZWlMN/dj7ah6MKhqsWMkpWsM96pMRGVuGvvwToOhWgeWHcU8Ivo8OJAlTcbTsr0pZXQIPh9+YQq279Lj4sa3X29O3egjWGzqgoHT9pQGsgfp/+8xWjejVrgVwvQ5m6F+QMjh8JVa3LOKYD/rp/xOHxDx5GBU3R/b5VkWDGmIPlaXi4hikmTx4AzRoHrRAoyo4TvKIirNOstP/rODY=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90c2eb3-7128-4a7e-8965-08d8168bee2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 09:09:12.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoIGM8awQ/kYASnHUXX9CGTRz+FX0FKqB6lok4oAq/FuDPF8BUnRwnQ364WQr1w9jfVABes+ByJKL43sspX2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3311
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can this be considered for this moment?
This is actually v2 of
"[PATCH 1/2] eventfd: Make wake counter work for single fd instead of all".

Thanks,
Zhe



On 4/10/20 7:47 PM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
>
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
>
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
>
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
>
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  fs/eventfd.c            | 3 ++-
>  include/linux/eventfd.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 78e41c7c3d05..8b9bd6fb08cd 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -70,7 +70,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>  	 * it returns true, the eventfd_signal() call should be deferred to a
>  	 * safe context.
>  	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
> +	    EFD_WAKE_COUNT_MAX))
>  		return 0;
>  
>  	spin_lock_irqsave(&ctx->wqh.lock, flags);
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index dc4fd8a6644d..e7684d768e3f 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -29,6 +29,9 @@
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
>  
> +/* This is the maximum recursion depth we find so far */
> +#define EFD_WAKE_COUNT_MAX 1
> +
>  struct eventfd_ctx;
>  struct file;
>  

