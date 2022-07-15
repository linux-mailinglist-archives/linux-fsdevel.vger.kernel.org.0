Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A357646A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiGOP2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiGOP2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:28:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB8DB86A;
        Fri, 15 Jul 2022 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657898925; x=1689434925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fgGIM11WL/fGrNMhdwG3+gYp9Dg+doXJUDhLlpjD/eg=;
  b=dmSdkG2SaEXsuuSqe12mOBLb2Ph9VM/7IILlXAt5X0tBJiy7ZlilujH9
   sMX96sqZuRUtXPQ75K5+BJsvDndGI2XJKaru6jwero3NUEiqtvuiLRPq3
   vK+J9tyoJ7g8ysFyess0ZgaWiHtyyaflDz9BpDhaSnlmcRv2e/1IbIB+A
   oS+6wWwy2i5MnlbXimJMUYcQGS2xU32S/F4pwLOGUtQJqrY77kUQ03ZrP
   Z2Yvkh1ET8785qsb6Ly04irDyi1rpsuRJ9rWGrrMvdicvmU4pIU/7LCSd
   YGzYWWPLy/f0sgZzKzC8kHcuJwwNveVJPb5OMCg5ERtW3urvHsKzv424x
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285842898"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="285842898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 08:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="664226118"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2022 08:28:43 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCNF7-0000JJ-Ls;
        Fri, 15 Jul 2022 15:28:37 +0000
Date:   Fri, 15 Jul 2022 23:28:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ebiederm@xmission.com,
        Ian Kent <raven@themaw.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: Add keyagent request_key
Message-ID: <202207152343.9SGLm8sP-lkp@intel.com>
References: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220715/202207152343.9SGLm8sP-lkp@intel.com/config)
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

   security/keys/request_key.c: In function 'construct_key':
>> security/keys/request_key.c:254:1: warning: label 'done' defined but not used [-Wunused-label]
     254 | done:
         | ^~~~


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
