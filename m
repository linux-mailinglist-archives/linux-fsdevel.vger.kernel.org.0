Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B01B42F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgDVLSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 07:18:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:52488 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgDVLSV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:18:21 -0400
IronPort-SDR: FgWiHvAOJHLpkGbni7gqeEFkbkE1Ui8NlDlyFMNMbz925qYByMqIvG5OgQUYheD+xn/IZLyvrR
 woo3hef3GJMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 04:18:18 -0700
IronPort-SDR: yjDUmLnrAp3nPM++rWGbhbiP+fk2ZZXzCpYbitG0voHooB4HcwejvvPP1Xn+E70WMzCRqlrpwA
 VCXcjkYUFh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="290800598"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 04:18:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jRDOP-0004yW-Jf; Wed, 22 Apr 2020 19:18:13 +0800
Date:   Wed, 22 Apr 2020 19:17:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <202004221945.LY6x0DQD%lkp@intel.com>
References: <20200420162809.17529-7-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420162809.17529-7-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Scott,

I love your patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on next-20200421]
[cannot apply to char-misc/char-misc-testing kselftest/next linus/master v5.7-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Scott-Branden/firmware-add-partial-read-support-in-request_firmware_into_buf/20200422-114528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 55623260bb33e2ab849af76edf2253bc04cb241f
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/bcm-vk/bcm_vk_dev.c:189:15: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct bcm_vk_peer_log *p_ctl @@    got struct bcm_vk_peer_log *p_ctl @@
>> drivers/misc/bcm-vk/bcm_vk_dev.c:189:15: sparse:    expected struct bcm_vk_peer_log *p_ctl
>> drivers/misc/bcm-vk/bcm_vk_dev.c:189:15: sparse:    got void [noderef] <asn:2> *
>> drivers/misc/bcm-vk/bcm_vk_dev.c:685:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1> *from @@    got oderef] <asn:1> *from @@
>> drivers/misc/bcm-vk/bcm_vk_dev.c:685:36: sparse:    expected void const [noderef] <asn:1> *from
>> drivers/misc/bcm-vk/bcm_vk_dev.c:685:36: sparse:    got struct vk_image *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:780:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1> *from @@    got oderef] <asn:1> *from @@
   drivers/misc/bcm-vk/bcm_vk_dev.c:780:36: sparse:    expected void const [noderef] <asn:1> *from
>> drivers/misc/bcm-vk/bcm_vk_dev.c:780:36: sparse:    got struct vk_reset *arg
>> drivers/misc/bcm-vk/bcm_vk_dev.c:858:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct vk_image *arg @@    got void [nstruct vk_image *arg @@
>> drivers/misc/bcm-vk/bcm_vk_dev.c:858:45: sparse:    expected struct vk_image *arg
>> drivers/misc/bcm-vk/bcm_vk_dev.c:858:45: sparse:    got void [noderef] <asn:1> *argp
>> drivers/misc/bcm-vk/bcm_vk_dev.c:862:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct vk_reset *arg @@    got void [nstruct vk_reset *arg @@
>> drivers/misc/bcm-vk/bcm_vk_dev.c:862:40: sparse:    expected struct vk_reset *arg
   drivers/misc/bcm-vk/bcm_vk_dev.c:862:40: sparse:    got void [noderef] <asn:1> *argp
--
>> drivers/misc/bcm-vk/bcm_vk_msg.c:507:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:707:15: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:715:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:871:31: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/misc/bcm-vk/bcm_vk_msg.c:899:47: sparse: sparse: cast removes address space '<asn:2>' of expression

vim +189 drivers/misc/bcm-vk/bcm_vk_dev.c

   180	
   181	static void bcm_vk_dump_peer_log(struct bcm_vk *vk)
   182	{
   183		struct bcm_vk_peer_log log, *p_ctl;
   184		char loc_buf[BCM_VK_PEER_LOG_LINE_MAX];
   185		int cnt;
   186		struct device *dev = &vk->pdev->dev;
   187		uint data_offset;
   188	
 > 189		p_ctl = vk->bar[BAR_2] + vk->peerlog_off;
   190		log = *p_ctl;
   191		/* do a rmb() to make sure log is updated */
   192		rmb();
   193	
   194		dev_dbg(dev, "Peer PANIC: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
   195			log.buf_size, log.mask, log.rd_idx, log.wr_idx);
   196	
   197		cnt = 0;
   198		data_offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log);
   199		while (log.rd_idx != log.wr_idx) {
   200			loc_buf[cnt] = vkread8(vk, BAR_2, data_offset + log.rd_idx);
   201	
   202			if ((loc_buf[cnt] == '\0') ||
   203			    (cnt == (BCM_VK_PEER_LOG_LINE_MAX - 1))) {
   204				dev_err(dev, "%s", loc_buf);
   205				cnt = 0;
   206			} else {
   207				cnt++;
   208			}
   209			log.rd_idx = (log.rd_idx + 1) & log.mask;
   210		}
   211		/* update rd idx at the end */
   212		vkwrite32(vk, log.rd_idx, BAR_2, vk->peerlog_off);
   213	}
   214	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
