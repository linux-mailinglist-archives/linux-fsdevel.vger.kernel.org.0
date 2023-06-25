Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701173D172
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjFYOZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYOZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:25:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06C9E;
        Sun, 25 Jun 2023 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687703145; x=1719239145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEXa7+daJWFICujQmk+hUpt7ny1BGIDcYKYZnvLrbks=;
  b=P8aVHsa9tup3jKFKDe/1Xg3Ws207HHfiCVXkz6kZxiRKD7xcf1CSLKWL
   0zMK+PHnSliyP0JYGjOq39YpdD6MNpTD5SPoTae2zYc6NYsE2nnXhTdbv
   /iY2CMTAXOR2Db3MdQbO5YzjbwaEdWSnjQe6IufWc7GBZPBRXX/zVXGYc
   BDcgJqXfGH12TUOdMhdznKkkau98f+Y6b9iO0JyDt8JdZwe2Qezg964+6
   4EOx95t0113NVqg3JIRnbUKiQVm8I9Zgbx3QpNAfZlBDM1VGqrIVb9l7a
   8+UioTl8NmUR9f7e0EYpIU+y65DYi6TqD9LLFVddoWnqVLa702DVWTcqE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="363621796"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="363621796"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 07:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="962498173"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="962498173"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2023 07:25:43 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDQgQ-000A4T-1B;
        Sun, 25 Jun 2023 14:25:42 +0000
Date:   Sun, 25 Jun 2023 22:25:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        brauner@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: idmappings: clarify from where
 idmappings are taken
Message-ID: <202306252253.qxHG1txo-lkp@intel.com>
References: <20230621095905.31346-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621095905.31346-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vfs-idmapping/for-next]
[also build test WARNING on linus/master v6.4-rc7 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalitsyn/docs-filesystems-idmappings-clarify-from-where-idmappings-are-taken/20230621-180345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git for-next
patch link:    https://lore.kernel.org/r/20230621095905.31346-1-aleksandr.mikhalitsyn%40canonical.com
patch subject: [PATCH] docs: filesystems: idmappings: clarify from where idmappings are taken
reproduce: (https://download.01.org/0day-ci/archive/20230625/202306252253.qxHG1txo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306252253.qxHG1txo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/idmappings.rst:378: WARNING: Unexpected indentation.

vim +378 Documentation/filesystems/idmappings.rst

   375	
   376	From the implementation point it's worth mentioning how idmappings are represented.
   377	All idmappings are taken from the corresponding user namespace.
 > 378	    - caller's idmapping (usually taken from ``current_user_ns()``)
   379	    - filesystem's idmapping (``sb->s_user_ns``)
   380	    - mount's idmapping (``mnt_idmap(vfsmnt)``)
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
