Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F35169072
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 17:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBVQpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 11:45:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:47003 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgBVQpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:45:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 08:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,472,1574150400"; 
   d="scan'208";a="349603727"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2020 08:45:14 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5Xtx-0001CW-Nc; Sun, 23 Feb 2020 00:45:13 +0800
Date:   Sun, 23 Feb 2020 00:44:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     kbuild-all@lists.01.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <202002230019.zc13SqPI%lkp@intel.com>
References: <20200220004825.23372-7-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004825.23372-7-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Scott,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on kselftest/next linus/master v5.6-rc2]
[cannot apply to driver-core/driver-core-testing next-20200221]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Scott-Branden/firmware-add-partial-read-support-in-request_firmware_into_buf/20200222-032851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 06e33595e96f212811066df192ae8bf802174296
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-173-ge0787745-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/bcm-vk/bcm_vk_dev.c:34:29: sparse: sparse: symbol 'image_tab' was not declared. Should it be static?
>> drivers/misc/bcm-vk/bcm_vk_dev.c:185:15: sparse: sparse: incorrect type in assignment (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:185:15: sparse:    expected struct bcm_vk_peer_log *p_ctl
>> drivers/misc/bcm-vk/bcm_vk_dev.c:185:15: sparse:    got void [noderef] <asn:2> *
   drivers/misc/bcm-vk/bcm_vk_dev.c:415:22: sparse: sparse: incorrect type in assignment (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:415:22: sparse:    expected void *bufp
   drivers/misc/bcm-vk/bcm_vk_dev.c:415:22: sparse:    got void [noderef] <asn:2> *
>> drivers/misc/bcm-vk/bcm_vk_dev.c:654:36: sparse: sparse: incorrect type in argument 2 (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:654:36: sparse:    expected void const [noderef] <asn:1> *from
>> drivers/misc/bcm-vk/bcm_vk_dev.c:654:36: sparse:    got struct vk_image *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:694:37: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/misc/bcm-vk/bcm_vk_dev.c:694:37: sparse:    expected void const [noderef] <asn:1> *from
>> drivers/misc/bcm-vk/bcm_vk_dev.c:694:37: sparse:    got struct vk_access *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:717:31: sparse: sparse: incorrect type in argument 1 (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:717:31: sparse:    expected void const volatile [noderef] <asn:1> *
>> drivers/misc/bcm-vk/bcm_vk_dev.c:717:31: sparse:    got unsigned int [usertype] *
   drivers/misc/bcm-vk/bcm_vk_dev.c:728:31: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/misc/bcm-vk/bcm_vk_dev.c:728:31: sparse:    expected void const volatile [noderef] <asn:1> *
   drivers/misc/bcm-vk/bcm_vk_dev.c:728:31: sparse:    got unsigned int [usertype] *
   drivers/misc/bcm-vk/bcm_vk_dev.c:793:36: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/misc/bcm-vk/bcm_vk_dev.c:793:36: sparse:    expected void const [noderef] <asn:1> *from
>> drivers/misc/bcm-vk/bcm_vk_dev.c:793:36: sparse:    got struct vk_reset *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:873:45: sparse: sparse: incorrect type in argument 2 (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:873:45: sparse:    expected struct vk_image *arg
>> drivers/misc/bcm-vk/bcm_vk_dev.c:873:45: sparse:    got void [noderef] <asn:1> *argp
   drivers/misc/bcm-vk/bcm_vk_dev.c:877:45: sparse: sparse: incorrect type in argument 2 (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:877:45: sparse:    expected struct vk_access *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:877:45: sparse:    got void [noderef] <asn:1> *argp
   drivers/misc/bcm-vk/bcm_vk_dev.c:881:40: sparse: sparse: incorrect type in argument 2 (different address spaces)
>> drivers/misc/bcm-vk/bcm_vk_dev.c:881:40: sparse:    expected struct vk_reset *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:881:40: sparse:    got void [noderef] <asn:1> *argp
--
>> drivers/misc/bcm-vk/bcm_vk_msg.c:102:6: sparse: sparse: symbol 'bcm_vk_update_qstats' was not declared. Should it be static?
>> drivers/misc/bcm-vk/bcm_vk_msg.c:455:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:656:15: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:664:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>> drivers/misc/bcm-vk/bcm_vk_msg.c:734:5: sparse: sparse: symbol 'bcm_vk_handle_last_sess' was not declared. Should it be static?
   drivers/misc/bcm-vk/bcm_vk_msg.c:823:31: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:851:47: sparse: sparse: cast removes address space '<asn:2>' of expression

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
