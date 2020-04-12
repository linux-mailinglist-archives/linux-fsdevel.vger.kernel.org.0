Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7954F1A5E68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLMCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 08:02:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:43357 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLMCF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 08:02:05 -0400
IronPort-SDR: DV8SGnOzTv5dLWq5Okw5eyA2/fNlYaEDV17mKHXXCGmgGkR/+TZF2kYxrb7uiOb8/cMXzvUoFG
 g1iBG8Hyfxpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 05:02:03 -0700
IronPort-SDR: MjYZ86/QsXaBRn4BYskzJn7SZtC2x837CRFf5pLQWAHnD+L8vEuIA597bfzpymfK3VYAu3KPEx
 rUYiWmvesTrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="399363868"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2020 05:02:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNbJI-000Dci-Q7; Sun, 12 Apr 2020 20:02:00 +0800
Date:   Sun, 12 Apr 2020 20:01:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] unicode: Expose available encodings in sysfs
Message-ID: <202004121952.JzmoxRo5%lkp@intel.com>
References: <20200411235823.2967193-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411235823.2967193-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.6 next-20200412]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/unicode-Expose-available-encodings-in-sysfs/20200412-080010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b032227c62939b5481bcd45442b36dfa263f4a7c
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-188-g79f7ac98-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/unicode/utf8-core.c:253:12: sparse: sparse: symbol 'ucd_init' was not declared. Should it be static?
>> fs/unicode/utf8-core.c:271:13: sparse: sparse: symbol 'ucd_exit' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
