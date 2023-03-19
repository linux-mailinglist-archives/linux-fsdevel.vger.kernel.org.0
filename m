Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92446BFF8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCSGKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 02:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSGKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 02:10:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF21123135;
        Sat, 18 Mar 2023 23:10:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7317027wmb.0;
        Sat, 18 Mar 2023 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679206230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCXZgQdVe5c6oKDsDnZCo553EMFw0K45SrmlR+yfeIU=;
        b=NxRWv5qjJAzjZ5SlbFTN6BJ9ZgRHA/HTNbhPil7P5aLbF6voyVHlpsIivhn5gzZprA
         hqeNpxQGSwV8AVDMEVe7VcIQxj3F41Ow/826tIX8xr+WQ3HNvRGsAdtg4gZLR56zPsl5
         FeJ25XnSPR9Pgiv70Vgc0rOzKFsAd9+64PxhuALfbSsys1I2uz8PHCXl5JdgZAFnPSYR
         msxfs3x0Irb0Gwz2wm4hVBY2JUyq21+HBcb9kufRs4x51hFTIA2tHwzJiXlBLD812EWg
         UIGgB1AJN1xrQQYSyVFrqz6kzcfzZcAoB9ucObSTOOpRt45+Nu6jpypAvS6BIyp3MIFU
         Izng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679206230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCXZgQdVe5c6oKDsDnZCo553EMFw0K45SrmlR+yfeIU=;
        b=prX0VEFkwsyjpRn+Z0L/34M84yeH9kBDWtidtL+FhMHKfwG2qEs1aOdaynp/34PhYk
         p1bw3Z9CoAbD+Z5zOivxiYRBd3RbWVD0bOTCRw7fF8YS1zTctNrHM15I7AlQOOVlJQ9G
         xFXawPneSn/kfCt6tIK+MWSeRndHdvSLSCvtn4Ts7dyHn9ic4mvPIYle9H34EghOojGQ
         sYQpIKq/6C9soicnJ9Zb2HpBvW0IN2zw+4lPT9H4tsegl8qwOvkVP7u0RswwgWMepBg4
         tlRvQk1ih1PfJDyRIP2MpP+FmCdhUnD4ZI3g5m6IwIWOzEgoHB9VuNi0OYoku43Xb93P
         idbQ==
X-Gm-Message-State: AO0yUKV9FwHyCg8V4eba1WZJdoBkV/itfoxGXPjlMEfKpxBU5pjO5CoU
        HZ7E98pjGWsDbSI7e3Rkp/g=
X-Google-Smtp-Source: AK7set81KcqLr/9F7KV2ou0bzzrWwqjKJLzBGcKiKCCc0V8fHOTrPF5/BaEdIi/GxxEdhSCAqsTVfA==
X-Received: by 2002:a1c:ed16:0:b0:3ed:a45d:aee9 with SMTP id l22-20020a1ced16000000b003eda45daee9mr3529255wmh.39.1679206229971;
        Sat, 18 Mar 2023 23:10:29 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003ed5909aab2sm9308183wmo.25.2023.03.18.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:10:29 -0700 (PDT)
Date:   Sun, 19 Mar 2023 06:08:19 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <b4571b7e-efb3-45ac-b442-864ed7f48edb@lucifer.local>
References: <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
 <202303190922.Wk376onx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303190922.Wk376onx-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 09:46:03AM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.3-rc2 next-20230317]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/fs-proc-kcore-Avoid-bounce-buffer-for-ktext-data/20230319-082147
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes%40gmail.com
> patch subject: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
> config: sparc64-randconfig-r015-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190922.Wk376onx-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/a28f374d35bd294a529fcba0b69c8b0e2b66fa6c
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Lorenzo-Stoakes/fs-proc-kcore-Avoid-bounce-buffer-for-ktext-data/20230319-082147
>         git checkout a28f374d35bd294a529fcba0b69c8b0e2b66fa6c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/vdso/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303190922.Wk376onx-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/wait.h:11,
>                     from include/linux/swait.h:8,
>                     from include/linux/completion.h:12,
>                     from include/linux/mm_types.h:14,
>                     from include/linux/uio.h:10,
>                     from include/linux/vmalloc.h:12,
>                     from include/asm-generic/io.h:994,
>                     from arch/sparc/include/asm/io.h:22,
>                     from arch/sparc/vdso/vclock_gettime.c:18:
> >> arch/sparc/include/asm/current.h:18:30: warning: call-clobbered register used for global register variable
>       18 | register struct task_struct *current asm("g4");
>          |                              ^~~~~~~
>    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
>      254 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
>          | ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype for '__vdso_clock_gettime_stick' [-Wmissing-prototypes]
>      282 | __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
>      307 | __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype for '__vdso_gettimeofday_stick' [-Wmissing-prototypes]
>      343 | __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +18 arch/sparc/include/asm/current.h
>
> ^1da177e4c3f41 include/asm-sparc/current.h Linus Torvalds  2005-04-16  16
> ba89f59ab825d4 include/asm-sparc/current.h David S. Miller 2007-11-16  17  #ifdef CONFIG_SPARC64
> ba89f59ab825d4 include/asm-sparc/current.h David S. Miller 2007-11-16 @18  register struct task_struct *current asm("g4");
> ba89f59ab825d4 include/asm-sparc/current.h David S. Miller 2007-11-16  19  #endif
> ^1da177e4c3f41 include/asm-sparc/current.h Linus Torvalds  2005-04-16  20
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

This doesn't seem even vaguely related to this patchset, possibly my not
specifying that I am basing on mm-unstable may be a factor here.
