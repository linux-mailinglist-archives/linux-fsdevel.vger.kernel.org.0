Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44F8B580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 12:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfHMKZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 06:25:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46316 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfHMKZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:25:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id z51so19010304edz.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 03:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCIj+14kGtlH4KaFL03/5an+64U3xUWWWEOQqDWVXU0=;
        b=UhiViMlqcu/qFPFLafchjuRdYS2x5nZMhDos82yl3rn6TDeNHLIPtN58j2Iwz+l32N
         9ii+wVOmK+1gi4JSQDiJJcEmXURsQN1rekEi3VhEswSsK39A9Yz+/++1W3PV+z3AWOBT
         x6dQCB29rzZC41JSA160VxYOb9VkTlj1CrIn2vgYvQYVnKkIR/0KHsDQCEKksMjc8z4p
         f7zFL+Z+BL4zn9uFSEp9hrE+6d2cwk3PkfOHTjEYaoE7A6OReItxI2Jk8Tg8qN7OgwZl
         3VpkPke4Sz1DcnbKff9bQQv3tzV1/ZA2At0yjk66en774+n8KnaP3dwYh+VOUbI3VHpU
         uEHQ==
X-Gm-Message-State: APjAAAX2NH/YPMIDriUYoaJhiCwC5VwIwI7vud04MeLYMlJFXXXvMqHa
        RuVLrqXRD2ceTgQd/5ue6208JUC+
X-Google-Smtp-Source: APXvYqxEvULAbFrlTZhYTFZvqDXO25hBfDH8qcSFtN4rhD43iagSePLyRCM4wXDkEO3i/VWbmUyn7A==
X-Received: by 2002:a50:8ec9:: with SMTP id x9mr14577369edx.89.1565691911156;
        Tue, 13 Aug 2019 03:25:11 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id cb19sm17899764ejb.51.2019.08.13.03.25.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 03:25:10 -0700 (PDT)
Subject: Re: [PATCH 06/16] zuf: Multy Devices
To:     kbuild test robot <lkp@intel.com>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     kbuild-all@01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <boazh@netapp.com>
References: <20190812164244.15580-7-boazh@netapp.com>
 <201908131625.nH4peW0F%lkp@intel.com>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <a4127b90-e22c-4ed7-4d98-e4c304e4f943@electrozaur.com>
Date:   Tue, 13 Aug 2019 13:25:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201908131625.nH4peW0F%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/2019 11:11, kbuild test robot wrote:
> Hi Boaz,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [cannot apply to v5.3-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Boaz-Harrosh/zuf-ZUFS-Zero-copy-User-mode-FileSystem/20190813-074124
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:15:0,
>                     from include/asm-generic/bug.h:18,
>                     from arch/x86/include/asm/bug.h:83,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:9,
>                     from fs/zuf/t1.c:15:
>    fs/zuf/t1.c: In function 't1_fault':
>    include/linux/printk.h:304:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> fs/zuf/_pr.h:23:31: note: in expansion of macro 'pr_err'
>     #define zuf_err(s, args ...)  pr_err("[%s:%d] " s, __func__, \
>                                   ^~~~~~
>>> fs/zuf/t1.c:75:3: note: in expansion of macro 'zuf_err'
>       zuf_err("[%ld] PTE fault not expected pgoff=0x%lx addr=0x%lx\n",
>       ^~~~~~~

I do not understand how to fix this problem.
There is an explicit comment that says this is an intentional fall through.
here is the complete code:

	switch (pe_size) {
	case PE_SIZE_PTE:
		zuf_err("[%ld] PTE fault not expected pgoff=0x%lx addr=0x%lx\n",
			inode->i_ino, vmf->pgoff, addr);
		/* fall through do PMD insert anyway */
	case PE_SIZE_PMD:
		bn = linear_page_index(vma, addr & PMD_MASK);
		pfn = md_pfn(z_pmem->md, bn);
	....

Please advise on how to make your compiler happy?

Thanks
Boaz

>    fs/zuf/t1.c:78:2: note: here
>      case PE_SIZE_PMD:
>      ^~~~
> 
> vim +/pr_err +23 fs/zuf/_pr.h
> 
> f577115420e717 Boaz Harrosh 2019-08-12  19  
> f577115420e717 Boaz Harrosh 2019-08-12  20  /*
> f577115420e717 Boaz Harrosh 2019-08-12  21   * Debug code
> f577115420e717 Boaz Harrosh 2019-08-12  22   */
> f577115420e717 Boaz Harrosh 2019-08-12 @23  #define zuf_err(s, args ...)		pr_err("[%s:%d] " s, __func__, \
> f577115420e717 Boaz Harrosh 2019-08-12  24  							__LINE__, ## args)
> f577115420e717 Boaz Harrosh 2019-08-12  25  #define zuf_err_cnd(silent, s, args ...) \
> f577115420e717 Boaz Harrosh 2019-08-12  26  	do {if (!silent) \
> f577115420e717 Boaz Harrosh 2019-08-12  27  		pr_err("[%s:%d] " s, __func__, __LINE__, ## args); \
> f577115420e717 Boaz Harrosh 2019-08-12  28  	} while (0)
> f577115420e717 Boaz Harrosh 2019-08-12  29  #define zuf_warn(s, args ...)		pr_warn("[%s:%d] " s, __func__, \
> f577115420e717 Boaz Harrosh 2019-08-12  30  							__LINE__, ## args)
> f577115420e717 Boaz Harrosh 2019-08-12  31  #define zuf_warn_cnd(silent, s, args ...) \
> f577115420e717 Boaz Harrosh 2019-08-12  32  	do {if (!silent) \
> f577115420e717 Boaz Harrosh 2019-08-12  33  		pr_warn("[%s:%d] " s, __func__, __LINE__, ## args); \
> f577115420e717 Boaz Harrosh 2019-08-12  34  	} while (0)
> f577115420e717 Boaz Harrosh 2019-08-12  35  #define zuf_info(s, args ...)          pr_info("~info~ " s, ## args)
> f577115420e717 Boaz Harrosh 2019-08-12  36  
> 
> :::::: The code at line 23 was first introduced by commit
> :::::: f577115420e717e536986a2e6055c584ec2f6829 zuf: zuf-rootfs
> 
> :::::: TO: Boaz Harrosh <boaz@plexistor.com>
> :::::: CC: 0day robot <lkp@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

