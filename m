Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E046618F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjAHT6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAHT5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:57:43 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D5624F
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:57:42 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id EbnXp9wpvqMfREbnXp8wYD; Sun, 08 Jan 2023 20:57:40 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Jan 2023 20:57:40 +0100
X-ME-IP: 86.243.100.34
Message-ID: <d11ebb6e-91b1-aed5-2b16-61ebf5e75855@wanadoo.fr>
Date:   Sun, 8 Jan 2023 20:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] fs/dcache: Remove unneeded math.h and rculist.h includes
Content-Language: fr
To:     kernel test robot <lkp@intel.com>, viro@zeniv.linux.org.uk
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <028298a8b70a67a70bc7b7eb0b07d9780fc1e5f3.1673181086.git.christophe.jaillet@wanadoo.fr>
 <202301082130.LXMj5qkD-lkp@intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202301082130.LXMj5qkD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 08/01/2023 à 15:01, kernel test robot a écrit :
> Hi Christophe,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.2-rc2 next-20230106]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/fs-dcache-Remove-unneeded-math-h-and-rculist-h-includes/20230108-203341
> patch link:    https://lore.kernel.org/r/028298a8b70a67a70bc7b7eb0b07d9780fc1e5f3.1673181086.git.christophe.jaillet%40wanadoo.fr
> patch subject: [PATCH] fs/dcache: Remove unneeded math.h and rculist.h includes
> config: arc-buildonly-randconfig-r004-20230108
> compiler: arc-elf-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/91f2fb9c6cb473dcca5bec7ebe0c813252b97d7d
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Christophe-JAILLET/fs-dcache-Remove-unneeded-math-h-and-rculist-h-includes/20230108-203341
>          git checkout 91f2fb9c6cb473dcca5bec7ebe0c813252b97d7d
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/ecryptfs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from include/linux/list_bl.h:6,
>                      from include/linux/rculist_bl.h:8,
>                      from include/linux/dcache.h:7,
>                      from fs/ecryptfs/dentry.c:11:
>     include/linux/bit_spinlock.h: In function 'bit_spin_lock':
>>> include/linux/bit_spinlock.h:30:25: error: implicit declaration of function 'cpu_relax' [-Werror=implicit-function-declaration]
>        30 |                         cpu_relax();
>           |                         ^~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> 
> vim +/cpu_relax +30 include/linux/bit_spinlock.h
> 
> 626d607435617c Nicholas Piggin 2011-01-07   9
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  10  /*
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  11   *  bit-based spin_lock()
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  12   *
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  13   * Don't use this unless you really need to: spin_lock() and spin_unlock()
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  14   * are significantly faster.
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  15   */
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  16  static inline void bit_spin_lock(int bitnum, unsigned long *addr)
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  17  {
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  18  	/*
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  19  	 * Assuming the lock is uncontended, this never enters
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  20  	 * the body of the outer loop. If it is contended, then
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  21  	 * within the inner loop a non-atomic test is used to
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  22  	 * busywait with less bus contention for a good time to
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  23  	 * attempt to acquire the lock bit.
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  24  	 */
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  25  	preempt_disable();
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  26  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> b8dc93cbe91324 Nicholas Piggin 2007-10-18  27  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  28  		preempt_enable();
> 3dd2ee4824b668 Linus Torvalds  2011-04-25  29  		do {
> fb1c8f93d869b3 Ingo Molnar     2005-09-10 @30  			cpu_relax();
> 3dd2ee4824b668 Linus Torvalds  2011-04-25  31  		} while (test_bit(bitnum, addr));
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  32  		preempt_disable();
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  33  	}
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  34  #endif
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  35  	__acquire(bitlock);
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  36  }
> fb1c8f93d869b3 Ingo Molnar     2005-09-10  37
> 

I've sent a fix in [1].

I'll re-test harder the patch against <inux/dcache.h> and repost it 
if/when [1] is merged.

CJ

[1]: 
https://lore.kernel.org/all/8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr/
