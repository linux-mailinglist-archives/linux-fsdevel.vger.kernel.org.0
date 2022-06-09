Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B512054462E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbiFIInE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbiFIIk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:40:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB97B4AA;
        Thu,  9 Jun 2022 01:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3253EB82C87;
        Thu,  9 Jun 2022 08:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C157CC34114;
        Thu,  9 Jun 2022 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654763991;
        bh=VkrIFTKTQbV3RKmsOoc2Bt3MvQh79Kf++bjgUfGWbBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsQH1IMU2w2VbMZsd0Ve2RcKBOunQgtimDy3fZ9S/0MK8V5K3cMbYw7ITjY95QhE+
         Ig/yAI9tSzbLkmKt2yOzn9az/YMPbEs4AG8uJ4fiC8yrlD98bSvGMM2q7IJkiEQUGs
         4Cyq8OWVB3u62OpptmJCCZQ0xAwTTphIr9CNiwVGn4/HBpPdMjSi+dDtwcQN9dTjI1
         g5SBS0UfjLGssbzxCoBBXD5xAj9cyCwK/3Dz6dakNh3sWsCKe0Tkeycu2qHa+LALfU
         Zau3Q7pU3FfH8Z2PNFDAe9jkQy4MtYTkAeEpRYdfpB8ze5VwqRXTgRzD1Kzwrl4wY4
         ngI9h/lLsofhQ==
Date:   Thu, 9 Jun 2022 10:39:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
Subject: Re: [fs]  e1bbcd277a: xfstests.generic.633.fail
Message-ID: <20220609083945.c2ezz7ldvqofunpm@wittgenstein>
References: <20220609081742.GA17678@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609081742.GA17678@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 04:17:42PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: e1bbcd277a53e08d619ffeec56c5c9287f2bf42f ("fs: hold writers when changing mount's idmapping")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-64f2596-1_20220518
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: generic-group-31
> 	ucode: 0xec
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> generic/633	- output mismatch (see /lkp/benchmarks/xfstests/results//generic/633.out.bad)
>     --- tests/generic/633.out	2022-05-18 12:17:48.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/633.out.bad	2022-06-07 15:37:21.117002738 +0000
>     @@ -1,2 +1,10 @@
>      QA output created by 633
>      Silence is golden
>     +idmapped-mounts.c: 8692: idmapped_mount_create_cb - Device or resource busy - failure: sys_mount_setattr
>     +idmapped-mounts.c: 8692: idmapped_mount_create_cb - Device or resource busy - failure: sys_mount_setattr
>     +idmapped-mounts.c: 8692: idmapped_mount_create_cb - Device or resource busy - failure: sys_mount_setattr
>     +idmapped-mounts.c: 8692: idmapped_mount_create_cb - Device or resource busy - failure: sys_mount_setattr
>     +idmapped-mounts.c: 8692: idmapped_mount_create_cb - Device or resource busy - failure: sys_mount_setattr
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/633.out /lkp/benchmarks/xfstests/results//generic/633.out.bad'  to see the entire diff)

Since e1bbcd277a53 ("fs: hold writers when changing mount's idmapping")
this behavior is expected and is explained in detail in the pull request
that contained this patch.

Upstream xfstests has been updated in commit
781bb995a149 ("vfs/idmapped-mounts: remove invalid test")
and would not fail.

Thanks!
Christian
