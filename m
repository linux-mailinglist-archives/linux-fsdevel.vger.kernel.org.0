Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C35342265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 17:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSQrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCSQrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:47:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBEDC06174A;
        Fri, 19 Mar 2021 09:47:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k4so3225582plk.5;
        Fri, 19 Mar 2021 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPeYsdmowjkppQpMJZcOjiutsnQzd/ubizhrUfn0Ztw=;
        b=IzG/AANsPWxONPbzKRFyOkTzuSU0+OV5WD3D9X/ONKXlFySw3Ijwi964gckOgittlN
         5hRqgUBjb/SG7jT5XxmE9G1ZCjHHQNWFYLjfQ3DP+l7n1Dpn9muhcsw+P/xLp4tiVaXH
         /74QBwStX0zWm+690Pz6Sm+KXs5qaggXQkFcwzMuqQ1RK61ucNBqc3NANS3pQj5fiqFB
         0ovwrH4Q4s0rArOTVkKy2XEFg2TkRwfIHgoSEFw/QNYmrmojNw9DnkmRW3NS/vdgvLdt
         oqNzEV3DKD/6n1UQQb3glcIq6HOFL/IZl4Wsq/URXIjPkUL+jusg0e3Sd558yvXf9LPT
         iJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oPeYsdmowjkppQpMJZcOjiutsnQzd/ubizhrUfn0Ztw=;
        b=fNBDuoqyiGSylkzUiv/gPo3fVwiqOFlV4ZoC8rugmBNyZOv+lY23arb4+/bG5hfb12
         uacjsd3lm6zzyFBG46xNuwjIzWl2YqJX2R0ZTRjqvcLF3FMxF9xCRfgQvlGOOGLSX4LD
         HUp1yNlTt3GUqFG6BDqTB57db2oUGwQzySF948O4TdQdC6NQPhFMhOC81NkmmBOgDqts
         8rdvx7qNsKZKwFVvUstmGgHy+skrbcF4oppm0O8hg9a/YdTnasUBylMKQF9G9yjngNhK
         Ub43O1lyTRM0F7eJxWk4H2UaXWrU0UvMNZhr5WSks+kpdMNq8sLJSdOTE6uLjDzLFGVS
         hpig==
X-Gm-Message-State: AOAM532wlPOEgLGUB0j7iBx/m0mPgIS9lxAKTWlSeADMwP7cykPRFojM
        mFGquvIJagGE0dZT571VtUY=
X-Google-Smtp-Source: ABdhPJwEAEicj0hQG5NkgB6gBP6RPY3XfcPN/AoYNlw+POoNr3rWWe/ag69hAo1mfsKUFjX8Twdolg==
X-Received: by 2002:a17:90b:804:: with SMTP id bk4mr10579106pjb.25.1616172431326;
        Fri, 19 Mar 2021 09:47:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:913d:5573:c956:f033])
        by smtp.gmail.com with ESMTPSA id h19sm5878642pgn.89.2021.03.19.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:47:10 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 19 Mar 2021 09:47:08 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, joaodias@google.com,
        surenb@google.com, willy@infradead.org, mhocko@suse.com,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [mm]  8fd8d23ab1: WARNING:at_fs/buffer.c:#__brelse
Message-ID: <YFTVjDIvnCyBmcZt@google.com>
References: <20210310161429.399432-3-minchan@kernel.org>
 <20210317023756.GA22345@xsang-OptiPlex-9020>
 <YFIucgVd7Vu9eE50@google.com>
 <20210319140528.GB30349@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319140528.GB30349@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:05:28PM +0800, Oliver Sang wrote:
> Hi Minchan,
> 
> On Wed, Mar 17, 2021 at 09:29:38AM -0700, Minchan Kim wrote:
> > On Wed, Mar 17, 2021 at 10:37:57AM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 8fd8d23ab10cc2fceeac25ea7b0e2eaf98e78d64 ("[PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration")
> > > url: https://github.com/0day-ci/linux/commits/Minchan-Kim/mm-replace-migrate_prep-with-lru_add_drain_all/20210311-001714
> > > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> > > 
> > > in testcase: blktests
> > > version: blktests-x86_64-a210761-1_20210124
> > > with following parameters:
> > > 
> > > 	test: nbd-group-01
> > > 	ucode: 0xe2
> > > 
> > > 
> > > 
> > > on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > 
> > > [   40.465061] WARNING: CPU: 2 PID: 5207 at fs/buffer.c:1177 __brelse (kbuild/src/consumer/fs/buffer.c:1177 kbuild/src/consumer/fs/buffer.c:1171) 
> > > [   40.465066] Modules linked in: nbd loop xfs libcrc32c dm_multipath dm_mod ipmi_devintf ipmi_msghandler sd_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl i915 mei_wdt intel_cstate wmi_bmof intel_gtt drm_kms_helper syscopyarea ahci intel_uncore sysfillrect sysimgblt libahci fb_sys_fops drm libata mei_me mei intel_pch_thermal wmi video intel_pmc_core acpi_pad ip_tables
> > > [   40.465086] CPU: 2 PID: 5207 Comm: mount_clear_soc Tainted: G          I       5.12.0-rc2-00062-g8fd8d23ab10c #1
> > > [   40.465088] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
> > > [   40.465089] RIP: 0010:__brelse (kbuild/src/consumer/fs/buffer.c:1177 kbuild/src/consumer/fs/buffer.c:1171) 
> > > [ 40.465091] Code: 00 00 00 00 00 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 47 60 85 c0 74 05 f0 ff 4f 60 c3 48 c7 c7 d8 99 57 82 e8 02 5d 80 00 <0f> 0b c3 0f 1f 44 00 00 55 65 ff 05 13 79 c8 7e 53 48 c7 c3 c0 89
> > 
> > Hi,
> > 
> > Unfortunately, I couldn't set the lkp test in my local mahcine
> > since installation failed(I guess my linux distribution is
> > very minor)
> > 
> > Do you mind testing this patch? (Please replace the original
> > patch with this one)
> 
> by replacing the original patch with below one, we confirmed the issue fixed. Thanks

Hi Oliver,

Let me resend formal patch with following

Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: Oliver Sang <oliver.sang@intel.com>

Thanks for the testing!
