Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDEB52D532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiESNyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiESNxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 09:53:42 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFFE27A1;
        Thu, 19 May 2022 06:53:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a22so4762629qkl.5;
        Thu, 19 May 2022 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keYAzS3dhQvs7qI6nbKP5Mgbkua2ZacULmCdRbuaUc8=;
        b=Zy9FoaShfDwmRGcOYJ+wxpjcrZu2f2vqgHUEw75zSvAtIX0/8Tkx1V5KVZfirZj8N/
         LgZaVCDelBkIjQBbO5MWwDDAaMaefYQe8CdyUNQw8T3kuCs1PlZislLbTtwt5XEwcoKb
         IgsG2AL9JFn2oyprjb80fXiOSmE7R7STUdzKlClPdnmQ9nz93y1U6lhqibQePYnIfXCF
         SjG94wAJHj/c8tELqRz0xTk5vvEOLYrg2qAyvNlNZkbGwnUMoOg/kLeNBG+ibkaAPxPv
         kiyVMuVJZtSV40EJdTaeCBoQZSAuW1NIC5BI1JcGyXEZJ+AjTzDV5el3sQCE9dIpJrsV
         pT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keYAzS3dhQvs7qI6nbKP5Mgbkua2ZacULmCdRbuaUc8=;
        b=hF1Je0vST7GcpqKp1uzlkrM6EUIwZaTqqQ3ckAXZWb73OP5VQjhPwCiGuDPD3+bacX
         wLKFQGDRDxOkyvrex6Um0HX2oZGhIin0SFP0qkICO+ov9iFnU/Fw+RSugd/OHGhFNLrX
         //SXWL+EmUuLcrBTBo78NI3bambPHYeWtUBTCUcKIN3sw0DgbX8YcOcrfuCip89dzd+N
         N8O3UG1iwGEUFE9tLzshHe8tUp9q6p4Aey4l2V7FCmJRDEzkaXTNLW3gZXi1TK+EU+ys
         nILjZ3DqtxbHBExKtSCYGz41gOYNSGCKTkmVdQ4mO4Em4+Crlf+Nx3VJYjnOBje7AvHZ
         aqPQ==
X-Gm-Message-State: AOAM5309DPaHiSmxN4FoaC2rJX2CCHJUo10r9aAd90M1AvhoBR/6hug2
        TBfZrAY51BNV0f4VDoLhOSELhceXsS7BG+Uf07QbKMaRSKA=
X-Google-Smtp-Source: ABdhPJytoUtDATpgujBr6c0c94pGAnTZfjmWy8Z37ROo5pZsuQvcWAaHVJ98uGRlIxmGE141MkVzxANB1xRWY6LG1t0=
X-Received: by 2002:a05:620a:1aa0:b0:6a0:a34:15e0 with SMTP id
 bl32-20020a05620a1aa000b006a00a3415e0mr3096146qkb.19.1652968406507; Thu, 19
 May 2022 06:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
In-Reply-To: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 May 2022 16:53:15 +0300
Message-ID: <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
To:     He Zhe <zhe.he@windriver.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 11:22 AM He Zhe <zhe.he@windriver.com> wrote:
>
> Hi,
>
> We are experiencing the following warning from
> "WARN_ON_ONCE(ret == -EOPNOTSUPP);" in vfs_copy_file_range, from
> 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
>
> # cat /sys/class/net/can0/phys_switch_id
>
> WARNING: CPU: 7 PID: 673 at fs/read_write.c:1516 vfs_copy_file_range+0x380/0x440
> Modules linked in: llce_can llce_logger llce_mailbox llce_core sch_fq_codel
> openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> CPU: 7 PID: 673 Comm: cat Not tainted 5.15.38-yocto-standard #1
> Hardware name: Freescale S32G399A (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : vfs_copy_file_range+0x380/0x440
> lr : vfs_copy_file_range+0x16c/0x440
> sp : ffffffc00e0f3ce0
> x29: ffffffc00e0f3ce0 x28: ffffff88157b5a40 x27: 0000000000000000
> x26: ffffff8816ac3230 x25: ffffff881c060008 x24: 0000000000001000
> x23: 0000000000000000 x22: 0000000000000000 x21: ffffff881cc99540
> x20: ffffff881cc9a340 x19: ffffffffffffffa1 x18: ffffffffffffffff
> x17: 0000000000000001 x16: 0000adfbb5178cde x15: ffffffc08e0f3647
> x14: 0000000000000000 x13: 34613178302f3061 x12: 3178302b636e7973
> x11: 0000000000058395 x10: 00000000fd1c5755 x9 : ffffffc008361950
> x8 : ffffffc00a7d4d58 x7 : 0000000000000000 x6 : 0000000000000001
> x5 : ffffffc009e81000 x4 : ffffffc009e817f8 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffffff88157b5a40 x0 : ffffffffffffffa1
> Call trace:
>  vfs_copy_file_range+0x380/0x440
>  __do_sys_copy_file_range+0x178/0x3a4
>  __arm64_sys_copy_file_range+0x34/0x4c
>  invoke_syscall+0x5c/0x130
>  el0_svc_common.constprop.0+0x68/0x124
>  do_el0_svc+0x50/0xbc
>  el0_svc+0x54/0x130
>  el0t_64_sync_handler+0xa4/0x130
>  el0t_64_sync+0x1a0/0x1a4
> cat: /sys/class/net/can0/phys_switch_id: Operation not supported
>
> And we found this is triggered by the following stack. Specifically, all
> netdev_ops in CAN drivers we can find now do not have ndo_get_port_parent_id and
> ndo_get_devlink_port, which makes phys_switch_id_show return -EOPNOTSUPP all the
> way back to vfs_copy_file_range.
>
> phys_switch_id_show+0xf4/0x11c
> dev_attr_show+0x2c/0x6c
> sysfs_kf_seq_show+0xb8/0x150
> kernfs_seq_show+0x38/0x44
> seq_read_iter+0x1c4/0x4c0
> kernfs_fop_read_iter+0x44/0x50
> generic_file_splice_read+0xdc/0x190
> do_splice_to+0xa0/0xfc
> splice_direct_to_actor+0xc4/0x250
> do_splice_direct+0x94/0xe0
> vfs_copy_file_range+0x16c/0x440
> __do_sys_copy_file_range+0x178/0x3a4
> __arm64_sys_copy_file_range+0x34/0x4c
> invoke_syscall+0x5c/0x130
> el0_svc_common.constprop.0+0x68/0x124
> do_el0_svc+0x50/0xbc
> el0_svc+0x54/0x130
> el0t_64_sync_handler+0xa4/0x130
> el0t_64_sync+0x1a0/0x1a4
>
> According to the original commit log, this warning is for operational validity
> checks to generic_copy_file_range(). The reading will eventually return as
> not supported as printed above. But is this warning still necessary? If so we
> might want to remove it to have a cleaner dmesg.
>

Sigh! Those filesystems have no business doing copy_file_range()

Here is a patch that Luis has been trying to push last year
to fix a problem with copy_file_range() from tracefs:

https://lore.kernel.org/linux-fsdevel/20210702090012.28458-1-lhenriques@suse.de/

Luis gave up on it, because no maintainer stepped up to take
the patch, but I think that is the right way to go.

Maybe this bug report can raise awareness to that old patch.

Al, could you have a look?

Thanks,
Amir.
