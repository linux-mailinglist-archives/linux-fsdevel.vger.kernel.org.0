Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA358F390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiHJUdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiHJUdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:33:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F26053B;
        Wed, 10 Aug 2022 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660163589; x=1691699589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ibswwapkDX3sL0U0NstJ+ZYzNa4A6XoaZ285Cu7y9vg=;
  b=D6/eFXcwyS/BpKs7o8QZldqzM9JoK0N+4vIv7eS0P6ZMKTav5evNTSPo
   ryKsRLNcj51ul+wLe/EWp/MM2GU/nOIt/SIrdfLmLPjjVkELeIIFgNL+K
   E7arya4Qk4fBysOTEmWR0SDD8d61WcAdLszGqEVrxQcmm79YQskNcBJtl
   pRgOHbf5P/u784rKPiBz/j1ZPvUI2aul1h7J+gitv1y/2qF9Om8w2gHL8
   fIkwshR+j9nT9v3PZi0um7oud80DnDoqMbxz+gmrFAPOXUTFE32xtFXoX
   M3amEB8XwZJzUgHTx2vD8NI0g+hYfzZNibf1Z9UC1piHOjDKgUoXNqfYQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="274242611"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="274242611"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781360516"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2022 13:33:06 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLsO1-0000h3-1e;
        Wed, 10 Aug 2022 20:33:05 +0000
Date:   Thu, 11 Aug 2022 04:32:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <202208110406.Lb3ONrcP-lkp@intel.com>
References: <c4ae9b882c07ea9cac64094294da5edc0756bb50.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ae9b882c07ea9cac64094294da5edc0756bb50.1659996830.git.rgb@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jack-fs/fsnotify]
[also build test WARNING on pcmoore-audit/next linus/master v5.19 next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220810-012825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220811/202208110406.Lb3ONrcP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bee8cac0b7796a753948c83b403a152f8c6acb8c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220810-012825
        git checkout bee8cac0b7796a753948c83b403a152f8c6acb8c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/auditsc.c:2907:8: warning: variable 'ib' set but not used [-Wunused-but-set-variable]
           char *ib = buf;
                 ^
   1 warning generated.


vim +/ib +2907 kernel/auditsc.c

  2902	
  2903	void __audit_fanotify(u32 response, size_t len, char *buf)
  2904	{
  2905		struct fanotify_response_info_audit_rule *friar;
  2906		size_t c = len;
> 2907		char *ib = buf;
  2908	
  2909		if (!(len && buf)) {
  2910			audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
  2911				  "resp=%u fan_type=0 fan_info=?", response);
  2912			return;
  2913		}
  2914		while (c >= sizeof(struct fanotify_response_info_header)) {
  2915			friar = (struct fanotify_response_info_audit_rule *)buf;
  2916			switch (friar->hdr.type) {
  2917			case FAN_RESPONSE_INFO_AUDIT_RULE:
  2918				if (friar->hdr.len < sizeof(*friar)) {
  2919					audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
  2920						  "resp=%u fan_type=%u fan_info=(incomplete)",
  2921						  response, friar->hdr.type);
  2922					return;
  2923				}
  2924				audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
  2925					  "resp=%u fan_type=%u fan_info=%u",
  2926					  response, friar->hdr.type, friar->audit_rule);
  2927			}
  2928			c -= friar->hdr.len;
  2929			ib += friar->hdr.len;
  2930		}
  2931	}
  2932	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
