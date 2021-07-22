Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7843D23E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhGVMOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 08:14:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:9907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhGVMOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198907741"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="198907741"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 05:54:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="501808880"
Received: from denglijx-mobl.ccr.corp.intel.com (HELO [10.255.29.108]) ([10.255.29.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 05:54:37 -0700
Subject: Re: [PATCH v3 14/15] samples: Add fs error monitoring example
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel test robot <lkp@intel.com>, amir73il@gmail.com,
        kbuild-all@lists.01.org, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20210629191035.681913-15-krisman@collabora.com>
 <202106301048.BainWUsk-lkp@intel.com> <87mtqicqux.fsf@collabora.com>
 <20210720194955.GH25548@kadam>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <4313fff4-343a-2937-3a97-c5da860827b1@intel.com>
Date:   Thu, 22 Jul 2021 20:54:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720194955.GH25548@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

On 7/21/2021 3:49 AM, Dan Carpenter wrote:
> 
> On Mon, Jul 19, 2021 at 10:36:54AM -0400, Gabriel Krisman Bertazi wrote:
>> kernel test robot <lkp@intel.com> writes:
>>
>>> Hi Gabriel,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on ext3/fsnotify]
>>> [also build test ERROR on ext4/dev linus/master v5.13 next-20210629]
>>> [cannot apply to tytso-fscrypt/master]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch ]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git  fsnotify
>>> config: arm64-allyesconfig (attached as .config)
>>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://github.com/0day-ci/linux/commit/746524d8db08a041fed90e41b15c8e8ca69cb22d
>>>          git remote add linux-review https://github.com/0day-ci/linux
>>>          git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
>>>          git checkout 746524d8db08a041fed90e41b15c8e8ca69cb22d
>>>          # save the attached .config to linux build tree
>>>          mkdir build_dir
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash samples/
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
>>>         7 | #include <errno.h>
>>>           |          ^~~~~~~~~
>>>     compilation terminated.
>>
>> Hi Dan,
>>
>> I'm not sure what's the proper fix here.  Looks like 0day is not using
>> cross system libraries when building this user space code.  Should I do
>> something special to silent it?

It seems need extra libraries for arm64, we'll disable CONFIG_SAMPLES to 
avoid reporting this error.

Best Regards,
Rong Chen


> 
> I'm not the person to ask, I just look at Smatch warnings.  Rong Chen
> might know the answer.
> 
> regards,
> dan carpenter
> 
