Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BD5A3CAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 10:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiH1Idj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 04:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiH1Idi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:33:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252D25592
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Aug 2022 01:33:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso11868044pjk.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Aug 2022 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=igzIvkpGT+nPYqgzOf8R+auGe6xkkz9GD36+hdfK3Lk=;
        b=t4V6YyZpM/OSUDCUR3ubrb/8Uvu7c9EuFAHJwkEUWxuLP/kjalgYewUrKfKVnAHgkO
         Q4m+2bhqbN8ZVjlgzWhf1VewQU5PzTCkd8lCH3DKAxHRZoC2Wb69NukagB1aQMoe2K/p
         HMID02DwjdNkKHKiLZ9NUM2G76EJ098LTz4CQgRLbrd7R3xXNifDM8LgljvOEL3FkBJZ
         WVFISx3rUKs/95+H3ItIXXgZrryP9yqMDKmqBcMliM6VQYzH34araE3C/qFlz7j9ddS7
         aywMXfEM8Y50KAA5P4p0a1gcgA8tFXGo3KnF5/QqIPfZ2HI49Zoy2Doncibpz9JKi3da
         3Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=igzIvkpGT+nPYqgzOf8R+auGe6xkkz9GD36+hdfK3Lk=;
        b=zuna9DnKtWwmsJgn4/DkHiGHGxaJTMYqsAEQqeKqnj/51gyP88tMYbV7V8WzUczgJT
         PpNhzaL6E1Suv5OwiwWGgdTrblUrdoqIFHLMvGPE28SoYVPJ2+aISWXG0yI0jAP0iiNo
         hceJ0TWVCwwxFWlHQ+V3ehdZ6v4/dI0tuFxdcGLr5raFaLSdeipp5bQoqsucy2BZoN4w
         /2TI4EEc6XG43YCyKYEdyA6Tn/M/DNrolx3mU/Rg6eTBg0XWwPdQT8nAWW9jpTaM8W2a
         zqHRm3ejBIQ0h8H8Rg7iGJJjEhaICchb4e6WH77890f93V7qPxAYO1QSXgqVaHB/f6ZO
         wMMg==
X-Gm-Message-State: ACgBeo1m2zufx1rXF0fT08lq7drAF7tbiHjwK2ecmqUj90oCa15L+rO0
        pY2S6HUFXfTvIBFDyDle8CfF7Q==
X-Google-Smtp-Source: AA6agR7YlDahXnkVX0waImNilO8OHqnqb1Z+dUQarxhVFoq6ok0FvXzLGd6EQapx9MGqpwmZAt1q8w==
X-Received: by 2002:a17:902:cec7:b0:172:b20d:e666 with SMTP id d7-20020a170902cec700b00172b20de666mr11047055plg.154.1661675616564;
        Sun, 28 Aug 2022 01:33:36 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e60:7d70:199a:6f05:bad8:24fd? ([2409:8a28:e60:7d70:199a:6f05:bad8:24fd])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a1d4300b001fb4a8d82a7sm4415394pju.56.2022.08.28.01.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 01:33:36 -0700 (PDT)
Message-ID: <a81e08ab-090d-0cb3-ec2d-490c5e2719ab@bytedance.com>
Date:   Sun, 28 Aug 2022 16:33:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCHSET v2 for-6.1] kernfs, cgroup: implement kernfs_show() and
 cgroup_file_show()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220828050440.734579-1-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220828050440.734579-1-tj@kernel.org>
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

On 2022/8/28 13:04, Tejun Heo wrote:
> Hello,
> 
> Greg: If this looks good to you, can you apply 0001-0008 to your tree? I'll
> likely have more cgroup updates on top, so I think it'd be better if I pull
> your tree and then handle the cgroup part in cgroup tree.
> 
> Currently, deactivated kernfs nodes are used for two purposes - during
> removal to kill and drain nodes and during creation to make multiple
> kernfs_nodes creations to succeed or fail as a group.
> 
> This patchset implements kernfs_show() which can dynamically show and hide
> kernfs_nodes using the [de]activation mechanisms, and, on top, implements
> cgroup_file_show() which allows toggling cgroup file visiblity.
> 
> This is for the following pending patchset to allow disabling PSI on
> per-cgroup basis:
> 
>  https://lore.kernel.org/all/20220808110341.15799-1-zhouchengming@bytedance.com/t/#u
> 
> which requires hiding the corresponding cgroup interface files while
> disabled.
> 
> This patchset contains the following nine patches.
> 
>  0001-kernfs-Simply-by-replacing-kernfs_deref_open_node-wi.patch
>  0002-kernfs-Drop-unnecessary-mutex-local-variable-initial.patch
>  0003-kernfs-Refactor-kernfs_get_open_node.patch
>  0004-kernfs-Skip-kernfs_drain_open_files-more-aggressivel.patch
>  0005-kernfs-Improve-kernfs_drain-and-always-call-on-remov.patch
>  0006-kernfs-Add-KERNFS_REMOVING-flags.patch
>  0007-kernfs-Factor-out-kernfs_activate_one.patch
>  0008-kernfs-Implement-kernfs_show.patch
>  0009-cgroup-Implement-cgroup_file_show.patch
> 
> 0001-0003 are misc prep patches. 0004-0008 implement kernsf_deactivate().
> 0009 implements cgroup_file_show() on top. The patches are also available in
> the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-show
> 
> The main difference from the previous version[1] is that while show/hide
> still use the same mechanism as [de]activation, their states are tracked
> separately so that e.g. an unrelated kernfs_activate() higher up in the tree
> doesn't interfere with hidden nodes in the subtree.

Hello,

For this series:
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks!

> 
> diffstat follows. Thanks.
> 
>  fs/kernfs/dir.c             |  102 +++++++++++++++++++++++++++++++----------------
>  fs/kernfs/file.c            |  151 +++++++++++++++++++++++++++++++++-------------------------------------
>  fs/kernfs/kernfs-internal.h |    1
>  include/linux/cgroup.h      |    1
>  include/linux/kernfs.h      |    3 +
>  kernel/cgroup/cgroup.c      |   20 +++++++++
>  6 files changed, 166 insertions(+), 112 deletions(-)
> 
> --
> tejun
> 
> [1] http://lkml.kernel.org/r/20220820000550.367085-1-tj@kernel.org
> 
