Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA677E495
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjHPPD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344039AbjHPPDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:03:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DCF2D49;
        Wed, 16 Aug 2023 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692198217; x=1723734217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AFqvtyU2z39BJI3AYxzGxYmyTqAqjIgBGsSHAKki+8E=;
  b=FG9m+QsdSxxXHyuAPEZR9vNcoiZPKM6peesKYCHdm/5WI7BKS6s2byd9
   IH4vPuqv9JEWpDKmSsJWLr+d81+fg+WihvuSx4IqPFQ0Iyr2rBqPdLqFo
   PMBEtqZwcX2K6K3a8Y+8Y/F2DOeO7Mg2VmcU6Tf+CxinI1yzxlrglr+qS
   mxQlFik4UHEBxyYBLAyxPnUmY37UwZiz5ohw+6zY8NMM2rieVFF+pCaVJ
   l6RLjycHJ8fBNBQRfQkVLuxjt+BESXi7a/f8Xgb52dn7ElgvwkDzdVvq7
   L2/GzajSAjXZOv/QcqDPd7yK4PAi0XvLosDGPAAdk0DWM3lH+pEXdubiO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372557384"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372557384"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="857849914"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="857849914"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2023 08:02:16 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWI2H-0000Ns-0y;
        Wed, 16 Aug 2023 15:02:13 +0000
Date:   Wed, 16 Aug 2023 23:01:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        joel@joelfernandes.org, christian.koenig@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/5] mm: move some shrinker-related function declarations
 to mm/internal.h
Message-ID: <202308162208.cQBnGoER-lkp@intel.com>
References: <20230816083419.41088-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816083419.41088-2-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.5-rc6 next-20230816]
[cannot apply to akpm-mm/mm-everything drm-misc/drm-misc-next vfs-idmapping/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-move-some-shrinker-related-function-declarations-to-mm-internal-h/20230816-163833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20230816083419.41088-2-zhengqi.arch%40bytedance.com
patch subject: [PATCH 1/5] mm: move some shrinker-related function declarations to mm/internal.h
config: x86_64-buildonly-randconfig-r003-20230816 (https://download.01.org/0day-ci/archive/20230816/202308162208.cQBnGoER-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308162208.cQBnGoER-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308162208.cQBnGoER-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shrinker_debug.c:174:5: warning: no previous declaration for 'shrinker_debugfs_add' [-Wmissing-declarations]
    int shrinker_debugfs_add(struct shrinker *shrinker)
        ^~~~~~~~~~~~~~~~~~~~
>> mm/shrinker_debug.c:249:16: warning: no previous declaration for 'shrinker_debugfs_detach' [-Wmissing-declarations]
    struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
                   ^~~~~~~~~~~~~~~~~~~~~~~
>> mm/shrinker_debug.c:265:6: warning: no previous declaration for 'shrinker_debugfs_remove' [-Wmissing-declarations]
    void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
         ^~~~~~~~~~~~~~~~~~~~~~~


vim +/shrinker_debugfs_add +174 mm/shrinker_debug.c

bbf535fd6f06b9 Roman Gushchin     2022-05-31  173  
5035ebc644aec9 Roman Gushchin     2022-05-31 @174  int shrinker_debugfs_add(struct shrinker *shrinker)
5035ebc644aec9 Roman Gushchin     2022-05-31  175  {
5035ebc644aec9 Roman Gushchin     2022-05-31  176  	struct dentry *entry;
e33c267ab70de4 Roman Gushchin     2022-05-31  177  	char buf[128];
5035ebc644aec9 Roman Gushchin     2022-05-31  178  	int id;
5035ebc644aec9 Roman Gushchin     2022-05-31  179  
47a7c01c3efc65 Qi Zheng           2023-06-09  180  	lockdep_assert_held(&shrinker_rwsem);
5035ebc644aec9 Roman Gushchin     2022-05-31  181  
5035ebc644aec9 Roman Gushchin     2022-05-31  182  	/* debugfs isn't initialized yet, add debugfs entries later. */
5035ebc644aec9 Roman Gushchin     2022-05-31  183  	if (!shrinker_debugfs_root)
5035ebc644aec9 Roman Gushchin     2022-05-31  184  		return 0;
5035ebc644aec9 Roman Gushchin     2022-05-31  185  
5035ebc644aec9 Roman Gushchin     2022-05-31  186  	id = ida_alloc(&shrinker_debugfs_ida, GFP_KERNEL);
5035ebc644aec9 Roman Gushchin     2022-05-31  187  	if (id < 0)
5035ebc644aec9 Roman Gushchin     2022-05-31  188  		return id;
5035ebc644aec9 Roman Gushchin     2022-05-31  189  	shrinker->debugfs_id = id;
5035ebc644aec9 Roman Gushchin     2022-05-31  190  
e33c267ab70de4 Roman Gushchin     2022-05-31  191  	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
5035ebc644aec9 Roman Gushchin     2022-05-31  192  
5035ebc644aec9 Roman Gushchin     2022-05-31  193  	/* create debugfs entry */
5035ebc644aec9 Roman Gushchin     2022-05-31  194  	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
5035ebc644aec9 Roman Gushchin     2022-05-31  195  	if (IS_ERR(entry)) {
5035ebc644aec9 Roman Gushchin     2022-05-31  196  		ida_free(&shrinker_debugfs_ida, id);
5035ebc644aec9 Roman Gushchin     2022-05-31  197  		return PTR_ERR(entry);
5035ebc644aec9 Roman Gushchin     2022-05-31  198  	}
5035ebc644aec9 Roman Gushchin     2022-05-31  199  	shrinker->debugfs_entry = entry;
5035ebc644aec9 Roman Gushchin     2022-05-31  200  
2124f79de6a909 John Keeping       2023-04-18  201  	debugfs_create_file("count", 0440, entry, shrinker,
5035ebc644aec9 Roman Gushchin     2022-05-31  202  			    &shrinker_debugfs_count_fops);
2124f79de6a909 John Keeping       2023-04-18  203  	debugfs_create_file("scan", 0220, entry, shrinker,
bbf535fd6f06b9 Roman Gushchin     2022-05-31  204  			    &shrinker_debugfs_scan_fops);
5035ebc644aec9 Roman Gushchin     2022-05-31  205  	return 0;
5035ebc644aec9 Roman Gushchin     2022-05-31  206  }
5035ebc644aec9 Roman Gushchin     2022-05-31  207  
e33c267ab70de4 Roman Gushchin     2022-05-31  208  int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
e33c267ab70de4 Roman Gushchin     2022-05-31  209  {
e33c267ab70de4 Roman Gushchin     2022-05-31  210  	struct dentry *entry;
e33c267ab70de4 Roman Gushchin     2022-05-31  211  	char buf[128];
e33c267ab70de4 Roman Gushchin     2022-05-31  212  	const char *new, *old;
e33c267ab70de4 Roman Gushchin     2022-05-31  213  	va_list ap;
e33c267ab70de4 Roman Gushchin     2022-05-31  214  	int ret = 0;
e33c267ab70de4 Roman Gushchin     2022-05-31  215  
e33c267ab70de4 Roman Gushchin     2022-05-31  216  	va_start(ap, fmt);
e33c267ab70de4 Roman Gushchin     2022-05-31  217  	new = kvasprintf_const(GFP_KERNEL, fmt, ap);
e33c267ab70de4 Roman Gushchin     2022-05-31  218  	va_end(ap);
e33c267ab70de4 Roman Gushchin     2022-05-31  219  
e33c267ab70de4 Roman Gushchin     2022-05-31  220  	if (!new)
e33c267ab70de4 Roman Gushchin     2022-05-31  221  		return -ENOMEM;
e33c267ab70de4 Roman Gushchin     2022-05-31  222  
47a7c01c3efc65 Qi Zheng           2023-06-09  223  	down_write(&shrinker_rwsem);
e33c267ab70de4 Roman Gushchin     2022-05-31  224  
e33c267ab70de4 Roman Gushchin     2022-05-31  225  	old = shrinker->name;
e33c267ab70de4 Roman Gushchin     2022-05-31  226  	shrinker->name = new;
e33c267ab70de4 Roman Gushchin     2022-05-31  227  
e33c267ab70de4 Roman Gushchin     2022-05-31  228  	if (shrinker->debugfs_entry) {
e33c267ab70de4 Roman Gushchin     2022-05-31  229  		snprintf(buf, sizeof(buf), "%s-%d", shrinker->name,
e33c267ab70de4 Roman Gushchin     2022-05-31  230  			 shrinker->debugfs_id);
e33c267ab70de4 Roman Gushchin     2022-05-31  231  
e33c267ab70de4 Roman Gushchin     2022-05-31  232  		entry = debugfs_rename(shrinker_debugfs_root,
e33c267ab70de4 Roman Gushchin     2022-05-31  233  				       shrinker->debugfs_entry,
e33c267ab70de4 Roman Gushchin     2022-05-31  234  				       shrinker_debugfs_root, buf);
e33c267ab70de4 Roman Gushchin     2022-05-31  235  		if (IS_ERR(entry))
e33c267ab70de4 Roman Gushchin     2022-05-31  236  			ret = PTR_ERR(entry);
e33c267ab70de4 Roman Gushchin     2022-05-31  237  		else
e33c267ab70de4 Roman Gushchin     2022-05-31  238  			shrinker->debugfs_entry = entry;
e33c267ab70de4 Roman Gushchin     2022-05-31  239  	}
e33c267ab70de4 Roman Gushchin     2022-05-31  240  
47a7c01c3efc65 Qi Zheng           2023-06-09  241  	up_write(&shrinker_rwsem);
e33c267ab70de4 Roman Gushchin     2022-05-31  242  
e33c267ab70de4 Roman Gushchin     2022-05-31  243  	kfree_const(old);
e33c267ab70de4 Roman Gushchin     2022-05-31  244  
e33c267ab70de4 Roman Gushchin     2022-05-31  245  	return ret;
e33c267ab70de4 Roman Gushchin     2022-05-31  246  }
e33c267ab70de4 Roman Gushchin     2022-05-31  247  EXPORT_SYMBOL(shrinker_debugfs_rename);
e33c267ab70de4 Roman Gushchin     2022-05-31  248  
26e239b37ebdfd Joan Bruguera Micó 2023-05-03 @249  struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  250  				       int *debugfs_id)
5035ebc644aec9 Roman Gushchin     2022-05-31  251  {
badc28d4924bfe Qi Zheng           2023-02-02  252  	struct dentry *entry = shrinker->debugfs_entry;
badc28d4924bfe Qi Zheng           2023-02-02  253  
47a7c01c3efc65 Qi Zheng           2023-06-09  254  	lockdep_assert_held(&shrinker_rwsem);
5035ebc644aec9 Roman Gushchin     2022-05-31  255  
e33c267ab70de4 Roman Gushchin     2022-05-31  256  	kfree_const(shrinker->name);
14773bfa70e67f Tetsuo Handa       2022-07-20  257  	shrinker->name = NULL;
e33c267ab70de4 Roman Gushchin     2022-05-31  258  
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  259  	*debugfs_id = entry ? shrinker->debugfs_id : -1;
badc28d4924bfe Qi Zheng           2023-02-02  260  	shrinker->debugfs_entry = NULL;
badc28d4924bfe Qi Zheng           2023-02-02  261  
badc28d4924bfe Qi Zheng           2023-02-02  262  	return entry;
5035ebc644aec9 Roman Gushchin     2022-05-31  263  }
5035ebc644aec9 Roman Gushchin     2022-05-31  264  
26e239b37ebdfd Joan Bruguera Micó 2023-05-03 @265  void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  266  {
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  267  	debugfs_remove_recursive(debugfs_entry);
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  268  	ida_free(&shrinker_debugfs_ida, debugfs_id);
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  269  }
26e239b37ebdfd Joan Bruguera Micó 2023-05-03  270  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
