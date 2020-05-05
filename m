Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA351C64AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgEEX6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgEEX6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:58:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C08C061A41
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 16:58:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so99999pfg.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JzaMwZpjc8kiyvkXAl8SC5OdIZko9B1uAdjf5EokFQA=;
        b=GcCRqF0rng+bDWT+XXGpRMzlhC2e6WqRpie++FCTYazS0pzx+X/KrFcQezY41N8Bqo
         L29pS/NkKaT2NqRgus6tqpdexXorGt7AUV+kFahU2b1GCiXg75mTfXKtntElnpIKDADf
         HGKWtD5DBrBDh7IcgMYYf2RgdPMDDROgrQGmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JzaMwZpjc8kiyvkXAl8SC5OdIZko9B1uAdjf5EokFQA=;
        b=BGzr+k+SFhlJ2W2Fj0ukTzmgI4NpnXWwk8dYnhlUTGJ6lKozNkX+jOLIWY0HpjwJqt
         at/MW+WlxsS7313zajlAFvM+X3b/v+0H1jS4NxgS0dBR4xg4g+sOcZrzMcJF4XYPJeb5
         C0luWOmFJlO/7sUWKidxfqC5EyGAQ95d7vCu2TL04NZ6Lwuo3cWl7faC8SAwgAoykWqe
         DD9Au9qSvkTBqsNH1hGGRurQZB/QLNICyCIoPOBTZWw43g9k9zOxxIA6Z375Ttsux6o6
         WtKGojE6Xcrac0FO61PsHAg0mgXMHqWPtzcO6foXaXjvKHl3rMn7MQqemnHiLqAnCOKb
         OCEQ==
X-Gm-Message-State: AGi0PuYRoDMp7lC4N7kQs97OzPcxQU63Ezb6iZBMbL5HCVfPCjFvs1d+
        zNvIgsHKbV/8QXMiMb9QrRksow==
X-Google-Smtp-Source: APiQypIqzHj2k/gz4IlPISOypaTNQykNBBmbQbErw1/2L6sk4p7yd0/jxv3gmS3o6U9qQVXKSF+LKg==
X-Received: by 2002:a63:e62:: with SMTP id 34mr4290017pgo.300.1588723087207;
        Tue, 05 May 2020 16:58:07 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b13sm42170pfo.67.2020.05.05.16.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 16:58:06 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] misc: bcm-vk: add Broadcom VK driver
To:     kbuild test robot <lkp@intel.com>,
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
References: <20200420162809.17529-7-scott.branden@broadcom.com>
 <202004221945.LY6x0DQD%lkp@intel.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b3e0c534-9e6a-f270-b6af-3658dca1bd42@broadcom.com>
Date:   Tue, 5 May 2020 16:58:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202004221945.LY6x0DQD%lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the kbuild and sparse issues should be resolved in PATCH v4.

On 2020-04-22 4:17 a.m., kbuild test robot wrote:
> Hi Scott,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on driver-core/driver-core-testing]
> [also build test WARNING on next-20200421]
> [cannot apply to char-misc/char-misc-testing kselftest/next linus/master v5.7-rc2]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Scott-Branden/firmware-add-partial-read-support-in-request_firmware_into_buf/20200422-114528
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 55623260bb33e2ab849af76edf2253bc04cb241f
> reproduce:
>          # apt-get install sparse
>          # sparse version: v0.6.1-191-gc51a0382-dirty
>          make ARCH=x86_64 allmodconfig
>          make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:189:15: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct bcm_vk_peer_log *p_ctl @@    got struct bcm_vk_peer_log *p_ctl @@
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:189:15: sparse:    expected struct bcm_vk_peer_log *p_ctl
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:189:15: sparse:    got void [noderef] <asn:2> *
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:685:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1> *from @@    got oderef] <asn:1> *from @@
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:685:36: sparse:    expected void const [noderef] <asn:1> *from
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:685:36: sparse:    got struct vk_image *arg
>     drivers/misc/bcm-vk/bcm_vk_dev.c:780:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1> *from @@    got oderef] <asn:1> *from @@
>     drivers/misc/bcm-vk/bcm_vk_dev.c:780:36: sparse:    expected void const [noderef] <asn:1> *from
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:780:36: sparse:    got struct vk_reset *arg
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:858:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct vk_image *arg @@    got void [nstruct vk_image *arg @@
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:858:45: sparse:    expected struct vk_image *arg
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:858:45: sparse:    got void [noderef] <asn:1> *argp
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:862:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct vk_reset *arg @@    got void [nstruct vk_reset *arg @@
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:862:40: sparse:    expected struct vk_reset *arg
>     drivers/misc/bcm-vk/bcm_vk_dev.c:862:40: sparse:    got void [noderef] <asn:1> *argp
> --
>>> drivers/misc/bcm-vk/bcm_vk_msg.c:507:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/misc/bcm-vk/bcm_vk_msg.c:707:15: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/misc/bcm-vk/bcm_vk_msg.c:715:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/misc/bcm-vk/bcm_vk_msg.c:871:31: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/misc/bcm-vk/bcm_vk_msg.c:899:47: sparse: sparse: cast removes address space '<asn:2>' of expression
>
> vim +189 drivers/misc/bcm-vk/bcm_vk_dev.c
>
>     180	
>     181	static void bcm_vk_dump_peer_log(struct bcm_vk *vk)
>     182	{
>     183		struct bcm_vk_peer_log log, *p_ctl;
>     184		char loc_buf[BCM_VK_PEER_LOG_LINE_MAX];
>     185		int cnt;
>     186		struct device *dev = &vk->pdev->dev;
>     187		uint data_offset;
>     188	
>   > 189		p_ctl = vk->bar[BAR_2] + vk->peerlog_off;
>     190		log = *p_ctl;
>     191		/* do a rmb() to make sure log is updated */
>     192		rmb();
>     193	
>     194		dev_dbg(dev, "Peer PANIC: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
>     195			log.buf_size, log.mask, log.rd_idx, log.wr_idx);
>     196	
>     197		cnt = 0;
>     198		data_offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log);
>     199		while (log.rd_idx != log.wr_idx) {
>     200			loc_buf[cnt] = vkread8(vk, BAR_2, data_offset + log.rd_idx);
>     201	
>     202			if ((loc_buf[cnt] == '\0') ||
>     203			    (cnt == (BCM_VK_PEER_LOG_LINE_MAX - 1))) {
>     204				dev_err(dev, "%s", loc_buf);
>     205				cnt = 0;
>     206			} else {
>     207				cnt++;
>     208			}
>     209			log.rd_idx = (log.rd_idx + 1) & log.mask;
>     210		}
>     211		/* update rd idx at the end */
>     212		vkwrite32(vk, log.rd_idx, BAR_2, vk->peerlog_off);
>     213	}
>     214	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

