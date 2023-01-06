Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2AC65FF11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 11:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAFKjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 05:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjAFKjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:39:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722986C2BA;
        Fri,  6 Jan 2023 02:39:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c34so1781227edf.0;
        Fri, 06 Jan 2023 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io70r00Nt8uTv7+PmyuFC/gWUcP4KkaEJZvkCpWCaqQ=;
        b=oFpy4Ra/8QxNX57dJDeFCaMr5GTpHTJ4l0xldBOSncrChQyGUwobaMBXkoffUTVxKX
         BvY4zuUsrNTODkKqrswmmaErMDYY+ETN98bgoNz12eMivqqFgY0+B4AvzbIHhdww62GT
         KKa0zLzmhCmBR86WtZpiESV+qn3lnxifkiBqVSJWauaUPXmCaRDeP5sPjvzNiTji/RHz
         wseKhi3NC/ATQT+TQUyE/HnNCmAGZlJFr0UVQHPgZvMkOzeM5cZqQ9AZ108ZRiRbTWQF
         exb61VyB3Nt6tWO2pDHzkU0Ei3HADVEnUk1sZYkeFjFgHvb9RHDlAIVnq3YWCNHTvIDm
         h2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io70r00Nt8uTv7+PmyuFC/gWUcP4KkaEJZvkCpWCaqQ=;
        b=5PH+Hy2IAGpjsBpDGIX0Rxw5d07nEPl64crPE+uBoZXxOGFUATGoFn85uQGd+hzUcb
         FaaSRYCyx219wLysKlKbA/Nx+mjEyr5gg2/tpC2wQvymGace/mEM5ylXOb/Fd8+ll0Pe
         33SaxEAqEy9gz7xCpn++V5irsPjD4X5Lm+cPyZ3gQ7J+2FUSqVVwonJAWXMPMeXE5VVC
         Lq6r027lj4UpXVt8iJtO861uk2Ow0PQ2+gVNg8BaFJWFZXZn5+NsYlHQhzEE0t0hfHy1
         zsBIHlslxdc3r3BdYvJhq28A2/h7XabBSN+uf4jDqlGOnCX6EZBlH4guuaq44ASOcY/X
         2Qqg==
X-Gm-Message-State: AFqh2kq+y9jD/uOsD6rJvY/+BA0wnRkOnJXREOfXtyFNQ4XeWEP93s/o
        Y30TrFV2jvKkLadLyj0x4Q==
X-Google-Smtp-Source: AMrXdXvfYrea77To0XKr5bkGGgtW/QLQnQZnFbJP0UwISUZTUlVdxFoq68a40TZwdMS3GHqghNyFJA==
X-Received: by 2002:a05:6402:3706:b0:472:9af1:163f with SMTP id ek6-20020a056402370600b004729af1163fmr48555537edb.37.1673001562912;
        Fri, 06 Jan 2023 02:39:22 -0800 (PST)
Received: from p183 ([46.53.252.178])
        by smtp.gmail.com with ESMTPSA id fj20-20020a0564022b9400b0048ee88aa4d0sm363551edb.56.2023.01.06.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:39:22 -0800 (PST)
Date:   Fri, 6 Jan 2023 13:39:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: BUG: core dump in selftest of proc fs
Message-ID: <Y7f6WBUXBz8tlr3b@p183>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:27:40PM +0100, Mirsad Goran Todorovac wrote:
> Dear all,
> 
> Trying to complete `make kselftest` for the first time, so maybe I'm doing something wrong?
> 
> Or we are having a regression in 6.2-rc2 release candidate ...
> 
> However, the output of selftest run is:
> 
> make[2]: Entering directory '.../linux_torvalds/tools/testing/selftests/proc'
> TAP version 13
> 1..21
> # selftests: proc: fd-001-lookup
> ok 1 selftests: proc: fd-001-lookup
> # selftests: proc: fd-002-posix-eq
> ok 2 selftests: proc: fd-002-posix-eq
> # selftests: proc: fd-003-kthread
> ok 3 selftests: proc: fd-003-kthread
> # selftests: proc: proc-loadavg-001
> ok 4 selftests: proc: proc-loadavg-001
> # selftests: proc: proc-empty-vm
> # proc-empty-vm: proc-empty-vm.c:184: test_proc_pid_maps: Assertion `rv == 0' failed.
> # /usr/bin/timeout: the monitored command dumped core
> # Aborted
> not ok 5 selftests: proc: proc-empty-vm # exit=134
> # selftests: proc: proc-pid-vm
> # proc-pid-vm: proc-pid-vm.c:365: main: Assertion `rv == len' failed.
> # /usr/bin/timeout: the monitored command dumped core
> # Aborted
> 
> Please find attached lshw output, dmesg, config and lsmod.
> 
> I am available for further diagnostics.
> 
> The platform is Ubuntu 22.10 kinetic kudu on a Lenovo Ideapad 3 15ITL6 laptop.

The "bug" is that "call rel32" instruction testing for executable
vsyscall page which should be relocated to "call 0xffffffffff600000"
is messed up. Ubuntu 22.10 ships with "vsyscall=xonly" so there should not be
any faults when executing from it. But segfault happens with normal
randomised userspace address.

I'll change it to "call *rax" which should be more robust (and works)
and free from relocations.
