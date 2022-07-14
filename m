Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1EB575764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbiGNWKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 18:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiGNWKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:10:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097C6B761;
        Thu, 14 Jul 2022 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657836648; x=1689372648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CK+IXwH2VwMcX91K6wXOfphw35V9iUE1EjsV3k1dtpE=;
  b=HwLSzZ2+qYR+j7uLClxFo7Twt3bzZSJ2qL0yzSVKwyWDawrd1IBOpycX
   kQzZFqGz3bTO6gmcyhF3IeZvjWtjdGETtpTJvMXl/g7zBpsLFuFITR6EA
   JGZ3lZKnnPQTlZm58ymXdmqPqMOMNyM8/EClwl1YmgzIvAfjeIvjoaDXb
   6VGO3ByTGuYtMhuYlJPjAvfW0tQlMTuGuAnA7fxw5URPiF25VGS7MzQxv
   THBHBfQyZki+Gsz2R39TNTUc7BpSw5MftFA4wL5ViYFag/EL3KDifNxnk
   GbXWZFziWa6YEh/qKU3Y9elunq05hYVKAE1kKPBy775jVhQiDf+wm0izd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371955850"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371955850"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628867169"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2022 15:10:45 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC72i-0001CD-MT;
        Thu, 14 Jul 2022 22:10:44 +0000
Date:   Fri, 15 Jul 2022 06:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        ebiederm@xmission.com, Ian Kent <raven@themaw.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: Add keyagent request_key
Message-ID: <202207150537.QnoEUasf-lkp@intel.com>
References: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Benjamin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jmorris-security/next-testing]
[also build test WARNING on dhowells-fs/fscache-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/Keyagents-another-call_usermodehelper-approach-for-namespaces/20220712-203658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
config: hexagon-randconfig-r005-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150537.QnoEUasf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d4f4ae463335d3e611bdb71330ab37af115cde9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Coddington/Keyagents-another-call_usermodehelper-approach-for-namespaces/20220712-203658
        git checkout 4d4f4ae463335d3e611bdb71330ab37af115cde9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash security/keys/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/keys/request_key.c:254:1: warning: unused label 'done' [-Wunused-label]
   done:
   ^~~~~
   1 warning generated.


vim +/done +254 security/keys/request_key.c

   217	
   218	/*
   219	 * Call out to userspace for key construction.
   220	 *
   221	 * Program failure is ignored in favour of key status.
   222	 */
   223	static int construct_key(struct key *key, const void *callout_info,
   224				 size_t callout_len, void *aux,
   225				 struct key *dest_keyring)
   226	{
   227		request_key_actor_t actor;
   228		struct key *authkey;
   229		int ret;
   230	
   231		kenter("%d,%p,%zu,%p", key->serial, callout_info, callout_len, aux);
   232	
   233		/* allocate an authorisation key */
   234		authkey = request_key_auth_new(key, "create", callout_info, callout_len,
   235					       dest_keyring);
   236		if (IS_ERR(authkey))
   237			return PTR_ERR(authkey);
   238	
   239		/* Make the call */
   240		actor = call_sbin_request_key;
   241		if (key->type->request_key)
   242			actor = key->type->request_key;
   243	#ifdef CONFIG_KEYAGENT
   244		else {
   245			ret = keyagent_request_key(authkey, aux);
   246	
   247			/* ENOKEY: no keyagents match on calling process' keyrings */
   248			if (ret != -ENOKEY)
   249				goto done;
   250		}
   251	#endif
   252		ret = actor(authkey, aux);
   253	
 > 254	done:
   255		/* check that the actor called complete_request_key() prior to
   256		 * returning an error */
   257		WARN_ON(ret < 0 &&
   258			!test_bit(KEY_FLAG_INVALIDATED, &authkey->flags));
   259	
   260		key_put(authkey);
   261		kleave(" = %d", ret);
   262		return ret;
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
