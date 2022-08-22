Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4E59B761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiHVB6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 21:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiHVB6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:58:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040DFAE76
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Aug 2022 18:58:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x15so8105390pfp.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Aug 2022 18:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gXQ/2bk8gTLltrdpFsbWRVS9rtRGCVCeC4bAjRMRMXw=;
        b=rpkht8giye/g3N5RJ0ZMXkOfO6sSljPgWEITR4esrqQ/bsrZRVQm6/vJbSR6nP8pPb
         TUBjWzMh0Hl4NgmyPkxJy9rUPeKn9M3dhp0bnSRTn8gFTNPCsAQSG42sb6Ef8cLAHuWV
         +DS8blIN3YOu0X7R5nl/slfsCFMG1Cxl5381P2Yh671THLYeC3RqrjiJmSCd7+72xqS7
         XRz0FTYQC3FO8JPiFp/iEXW9ywC9S0K5QvOxu947tYY6B/2EJBWVdR3uMcVve1m8N1x0
         Uy3r+e/26OgvSWIzJXgj8KBf0zcjnNldO6XWvac9RbNj//KSM8C5sGQb9Q7cVSo7xZ22
         v+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gXQ/2bk8gTLltrdpFsbWRVS9rtRGCVCeC4bAjRMRMXw=;
        b=U0ao5hYw6ay8JGand8xgrz6KK4G470gwbceRfnBkir6DSVQyw5aExKaZBtc2cbbhJY
         Ef7KSmDP50yqQaia7TVUKSpAoxQt4vBLUu3J/45jojC3G1SHL7nT0zHUZYGRghLuTifV
         K3alZosWqdvHbB7upoY2vby6WPJweL9ZNJr6BPwCDHtLAX7mPoravgUagkZMONWplFcW
         mqS21dYNsagTa+I5hHCWbIf0najmYPyxEx8iE1oyNsU4O+VEtnHZtKeF7TqOy00JVm8b
         bHr0pXZRqEvvL5rWw1RG2Uspw2q1a5hLNXKOIfQu3uPnkLCVLxfA8kIxj3+OR4cngS6y
         hH6g==
X-Gm-Message-State: ACgBeo3fHf1aBbRxCZf9JgEj943ncGNcZuY96QwlB0ilW1Xd8eSAUBHs
        b+DdnKVaQ63iCa1AWHcIRMw/EA==
X-Google-Smtp-Source: AA6agR67BLrywojIIVs6gRpGTSLcWlBb3qXHhzeaxp0X9kLKCl6odwrUh6m2T+s/dIIFkheTv5q38w==
X-Received: by 2002:aa7:88d1:0:b0:536:1b68:d3b6 with SMTP id k17-20020aa788d1000000b005361b68d3b6mr12626213pff.81.1661133507499;
        Sun, 21 Aug 2022 18:58:27 -0700 (PDT)
Received: from [10.255.88.113] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b0016a058b7547sm189557plg.294.2022.08.21.18.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 18:58:27 -0700 (PDT)
Message-ID: <78d464bd-94db-a1bc-d864-d85f2751dca3@bytedance.com>
Date:   Mon, 22 Aug 2022 09:58:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCHSET for-6.1] kernfs, cgroup: implement kernfs_deactivate()
 and cgroup_file_show()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/20 08:05, Tejun Heo wrote:
> Hello,
> 
> Currently, deactivated kernfs nodes are used for two purposes - during
> removal to kill and drain nodes and during creation to make multiple
> kernfs_nodes creations to succeed or fail as a group.
> 
> This patchset make kernfs [de]activation generic so that it can be used
> anytime to deactivate (hide and drain) and activate (show) kernfs nodes,
> and, on top, implement cgroup_file_show() which allows toggling cgroup file
> visiblity.
> 
> This is for the following pending patchset to allow disabling PSI on
> per-cgroup basis:
> 
>  https://lore.kernel.org/all/20220808110341.15799-1-zhouchengming@bytedance.com/t/#u
> 
> which requires hiding the corresponding cgroup interface files while
> disabled.

Hello,

It's so nice of you for implementing this! I will rebase on your work to
do per-cgroup PSI disable/re-enable and test it today.

Thanks!

> 
> This patchset contains the following seven patches.
> 
>  0001-kernfs-Simply-by-replacing-kernfs_deref_open_node-wi.patch
>  0002-kernfs-Drop-unnecessary-mutex-local-variable-initial.patch
>  0003-kernfs-Refactor-kernfs_get_open_node.patch
>  0004-kernfs-Skip-kernfs_drain_open_files-more-aggressivel.patch
>  0005-kernfs-Make-kernfs_drain-skip-draining-more-aggressi.patch
>  0006-kernfs-Allow-kernfs-nodes-to-be-deactivated-and-re-a.patch
>  0007-cgroup-Implement-cgroup_file_show.patch
> 
> 0001-0003 are misc prep patches. 0004-0006 implement kernsf_deactivate().
> 0008 implements cgroup_file_show() on top. The patches are also available in
> the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-deactivate
> 
> diffstat follows. Thanks.
> 
>  fs/kernfs/dir.c             |  120 +++++++++++++++++++++++++++++++++++++++++-------------------
>  fs/kernfs/file.c            |  139 +++++++++++++++++++++++++++++++---------------------------------------
>  fs/kernfs/kernfs-internal.h |    1
>  include/linux/cgroup.h      |    1
>  include/linux/kernfs.h      |    2 +
>  kernel/cgroup/cgroup.c      |   23 +++++++++++
>  6 files changed, 172 insertions(+), 114 deletions(-)
> 
> --
> tejun
> 
> 
