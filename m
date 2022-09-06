Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1615AE509
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiIFKLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiIFKLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:11:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A549DECF;
        Tue,  6 Sep 2022 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662459080; x=1693995080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oB1TtPVVHc8wxkEfbkl6xSPnmmpiaRnJ3fakqY2gLXM=;
  b=An/Lnnx0rFicz9vaii4iHNllhXvcpS4JZMcXtY85zKNHWJ6h5WDDwIQo
   4VVUvZa44usw4yCHeoCPkSi9SJtg3RSs7gdw7Pc3ddZA0qtE95cJ0l2HI
   MCYmBMd7pMRqwQbSaY76iU5JdKo2Inl8p0lw8Kvwqd3ZSblCIAaM9nNSs
   JWSIWqiKKzTA7+2jN8sShMS29XrTYXyc/7lFgKSU3mmwSgpfhgyPvGH69
   EPTDMyAq6SXrRYdyUYItLgdLfT5weI6XKr5RIj4W6MpYvwtPYFZGFIoae
   8A0qSMWnBrSLdgF/Gh427Aj03FE8zAscs+aI+SBaOLmW0p4lUeX9Tg4b1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="283550683"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="283550683"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 03:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="565041316"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2022 03:11:17 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVVY4-0004zl-2N;
        Tue, 06 Sep 2022 10:11:16 +0000
Date:   Tue, 6 Sep 2022 18:10:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deming Wang <wangdeming@inspur.com>, vgoyal@redhat.com,
        stefanha@redhat.com, miklos@szeredi.hu
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtiofs: Drop unnecessary initialization in
 send_forget_request and virtio_fs_get_tree
Message-ID: <202209061738.Epufa2eF-lkp@intel.com>
References: <20220906053848.2503-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906053848.2503-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Deming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc4]
[also build test WARNING on linus/master next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Deming-Wang/virtiofs-Drop-unnecessary-initialization-in-send_forget_request-and-virtio_fs_get_tree/20220906-135058
base:    7e18e42e4b280c85b76967a9106a13ca61c16179
config: hexagon-randconfig-r035-20220906 (https://download.01.org/0day-ci/archive/20220906/202209061738.Epufa2eF-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a61f879fdb56490afddb6ddea4a9d57226f339f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Deming-Wang/virtiofs-Drop-unnecessary-initialization-in-send_forget_request-and-virtio_fs_get_tree/20220906-135058
        git checkout a61f879fdb56490afddb6ddea4a9d57226f339f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/fuse/virtio_fs.c:422:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!fsvq->connected) {
           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/virtio_fs.c:465:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/fuse/virtio_fs.c:422:2: note: remove the 'if' if its condition is always false
           if (!fsvq->connected) {
           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   fs/fuse/virtio_fs.c:417:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
>> fs/fuse/virtio_fs.c:1433:2: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/virtio_fs.c:1481:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/fuse/virtio_fs.c:1433:2: note: remove the 'if' if its condition is always false
           if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   fs/fuse/virtio_fs.c:1420:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   2 warnings generated.


vim +422 fs/fuse/virtio_fs.c

a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  406  
58ada94f95f71d Vivek Goyal     2019-10-30  407  /*
58ada94f95f71d Vivek Goyal     2019-10-30  408   * Returns 1 if queue is full and sender should wait a bit before sending
58ada94f95f71d Vivek Goyal     2019-10-30  409   * next request, 0 otherwise.
58ada94f95f71d Vivek Goyal     2019-10-30  410   */
58ada94f95f71d Vivek Goyal     2019-10-30  411  static int send_forget_request(struct virtio_fs_vq *fsvq,
58ada94f95f71d Vivek Goyal     2019-10-30  412  			       struct virtio_fs_forget *forget,
58ada94f95f71d Vivek Goyal     2019-10-30  413  			       bool in_flight)
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  414  {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  415  	struct scatterlist sg;
58ada94f95f71d Vivek Goyal     2019-10-30  416  	struct virtqueue *vq;
a61f879fdb5649 Deming Wang     2022-09-06  417  	int ret;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  418  	bool notify;
1efcf39eb62757 Vivek Goyal     2019-10-30  419  	struct virtio_fs_forget_req *req = &forget->req;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  420  
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  421  	spin_lock(&fsvq->lock);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12 @422  	if (!fsvq->connected) {
58ada94f95f71d Vivek Goyal     2019-10-30  423  		if (in_flight)
c17ea009610366 Vivek Goyal     2019-10-15  424  			dec_in_flight_req(fsvq);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  425  		kfree(forget);
58ada94f95f71d Vivek Goyal     2019-10-30  426  		goto out;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  427  	}
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  428  
1efcf39eb62757 Vivek Goyal     2019-10-30  429  	sg_init_one(&sg, req, sizeof(*req));
58ada94f95f71d Vivek Goyal     2019-10-30  430  	vq = fsvq->vq;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  431  	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
58ada94f95f71d Vivek Goyal     2019-10-30  432  
58ada94f95f71d Vivek Goyal     2019-10-30  433  	ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  434  	if (ret < 0) {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  435  		if (ret == -ENOMEM || ret == -ENOSPC) {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  436  			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  437  				 ret);
58ada94f95f71d Vivek Goyal     2019-10-30  438  			list_add_tail(&forget->list, &fsvq->queued_reqs);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  439  			schedule_delayed_work(&fsvq->dispatch_work,
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  440  					      msecs_to_jiffies(1));
58ada94f95f71d Vivek Goyal     2019-10-30  441  			if (!in_flight)
58ada94f95f71d Vivek Goyal     2019-10-30  442  				inc_in_flight_req(fsvq);
58ada94f95f71d Vivek Goyal     2019-10-30  443  			/* Queue is full */
58ada94f95f71d Vivek Goyal     2019-10-30  444  			ret = 1;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  445  		} else {
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  446  			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  447  				 ret);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  448  			kfree(forget);
58ada94f95f71d Vivek Goyal     2019-10-30  449  			if (in_flight)
58ada94f95f71d Vivek Goyal     2019-10-30  450  				dec_in_flight_req(fsvq);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  451  		}
58ada94f95f71d Vivek Goyal     2019-10-30  452  		goto out;
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  453  	}
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  454  
58ada94f95f71d Vivek Goyal     2019-10-30  455  	if (!in_flight)
58ada94f95f71d Vivek Goyal     2019-10-30  456  		inc_in_flight_req(fsvq);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  457  	notify = virtqueue_kick_prepare(vq);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  458  	spin_unlock(&fsvq->lock);
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  459  
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  460  	if (notify)
a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  461  		virtqueue_notify(vq);
58ada94f95f71d Vivek Goyal     2019-10-30  462  	return ret;
58ada94f95f71d Vivek Goyal     2019-10-30  463  out:
58ada94f95f71d Vivek Goyal     2019-10-30  464  	spin_unlock(&fsvq->lock);
58ada94f95f71d Vivek Goyal     2019-10-30  465  	return ret;
58ada94f95f71d Vivek Goyal     2019-10-30  466  }
58ada94f95f71d Vivek Goyal     2019-10-30  467  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
