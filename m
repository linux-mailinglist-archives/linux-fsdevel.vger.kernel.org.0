Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED763CD6A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhGSN4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbhGSN4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:56:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB1C061574;
        Mon, 19 Jul 2021 07:04:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3583E1F42C2A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     amir73il@gmail.com, kbuild-all@lists.01.org, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 14/15] samples: Add fs error monitoring example
Organization: Collabora
References: <20210629191035.681913-15-krisman@collabora.com>
        <202106301048.BainWUsk-lkp@intel.com>
Date:   Mon, 19 Jul 2021 10:36:54 -0400
In-Reply-To: <202106301048.BainWUsk-lkp@intel.com> (kernel test robot's
        message of "Wed, 30 Jun 2021 10:42:56 +0800")
Message-ID: <87mtqicqux.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Gabriel,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on ext3/fsnotify]
> [also build test ERROR on ext4/dev linus/master v5.13 next-20210629]
> [cannot apply to tytso-fscrypt/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/746524d8db08a041fed90e41b15c8e8ca69cb22d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
>         git checkout 746524d8db08a041fed90e41b15c8e8ca69cb22d
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash samples/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
>        7 | #include <errno.h>
>          |          ^~~~~~~~~
>    compilation terminated.

Hi Dan,

I'm not sure what's the proper fix here.  Looks like 0day is not using
cross system libraries when building this user space code.  Should I do
something special to silent it?

-- 
Gabriel Krisman Bertazi
