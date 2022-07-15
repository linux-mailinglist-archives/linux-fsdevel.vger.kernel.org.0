Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B657646E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiGOP2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiGOP2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:28:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18D11450;
        Fri, 15 Jul 2022 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657898926; x=1689434926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2YUYVG9fYSNFXowhFYyhMZlE/GpGEE3obu6cMtX/fWQ=;
  b=YuXgrBopbtrJJUtgDTdXWlY1WAQUmYcrblqXj8hnJrK285CJTff46MyE
   tfLjowyX2z5e+Rla1rH217zJ8Ro4n4BFfZHvrFfhR8NrPB9rWgrstxD0o
   UBQU+8L8NBK6FONu6+VzgXo2z3RRfD5K04lEV3kuNsfMULjUbcywL0aAq
   dnflirgG76gLe6L2fuZJrJC+RNogJUaDlyDvHrNCXfzOFwez7ioxHoc4x
   /JNVLRQFR5F+sevnFdy2J2TU85XDbG9h+8K8hMW74XfpDzFWPlqHTBB/p
   Il7pUdTFN12c5FFmBNTZ2eu+mD4FDfhlxfLsn+fyQ0+wqPdMWLO/tCLUC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286557255"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="286557255"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 08:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="685993857"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2022 08:28:43 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCNFC-0000JO-V4;
        Fri, 15 Jul 2022 15:28:42 +0000
Date:   Fri, 15 Jul 2022 23:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ebiederm@xmission.com,
        Ian Kent <raven@themaw.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: Add keyagent request_key
Message-ID: <202207152310.dTPT29kb-lkp@intel.com>
References: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Benjamin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jmorris-security/next-testing]
[also build test WARNING on dhowells-fs/fscache-next arnd-asm-generic/master linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/Keyagents-another-call_usermodehelper-approach-for-namespaces/20220712-203658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220715/202207152310.dTPT29kb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4d4f4ae463335d3e611bdb71330ab37af115cde9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Coddington/Keyagents-another-call_usermodehelper-approach-for-namespaces/20220712-203658
        git checkout 4d4f4ae463335d3e611bdb71330ab37af115cde9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash security/keys/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/keys/keyagent.c:78:5: warning: no previous prototype for 'keyagent_request_key' [-Wmissing-prototypes]
      78 | int keyagent_request_key(struct key *authkey, void *aux)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/keyagent_request_key +78 security/keys/keyagent.c

    72	
    73	/*
    74	 * Search the calling process' keyrings for a keyagent that
    75	 * matches the requested key type.  If found, signal the keyagent
    76	 * to construct and link the key, else return -ENOKEY.
    77	 */
  > 78	int keyagent_request_key(struct key *authkey, void *aux)
    79	{
    80		struct key *ka_key, *target_key;
    81		struct request_key_auth *rka;
    82		key_ref_t ka_ref;
    83		const struct cred *cred = current_cred();
    84		int ret;
    85	
    86		/* We must be careful not to touch authkey and aux if
    87		 * returning -ENOKEY, since it will be reused.   */
    88		rka = get_request_key_auth(authkey);
    89		target_key = rka->target_key;
    90	
    91		/* Does the calling process have a keyagent in its session keyring? */
    92		ka_ref = keyring_search(
    93						make_key_ref(cred->session_keyring, 1),
    94						&key_type_keyagent,
    95						target_key->type->name, false);
    96	
    97		if (IS_ERR(ka_ref))
    98			return -ENOKEY;
    99	
   100		/* We found a keyagent, let's call out to it. */
   101		ka_key = key_ref_to_ptr(ka_ref);
   102		ret = keyagent_signal(ka_key, target_key, authkey);
   103		key_put(key_ref_to_ptr(ka_ref));
   104	
   105		return ret;
   106	}
   107	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
