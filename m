Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A01B5B2DF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiIIFH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 01:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIIFHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:07:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFA125180;
        Thu,  8 Sep 2022 22:07:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so816005wru.6;
        Thu, 08 Sep 2022 22:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8A0btdNNYUW+hceFW6H28UUkKsXmFXdS4OKZqXjLEa8=;
        b=Flubryf2i1EyS+COfyKsK9W7pRUAOhj64bJBxfQ/2SgkP66wfRk+tge5wOlTSvFLO1
         PXzo/eDWz45qE9DlsGuIIWFyoiOEG1IW1eZd/9OzvnhMTN/xPLtqeBZa8UBSul0tJ89J
         wFrR6rVAfCveL7ehLtUX3mpA86kKQq9ru7RxWUio2yzi7rPat0Op1mvxU0mldu8f2D1q
         nZcfWVMgIlxJu39xtvyr4fiXjpcdO2PlocUy2Wi5nsFDf2wo1szQPvipCtk7oShYVe5I
         wzxQ2mMI7heW7nT3BqzYIhklk1G3TEpoiYtBaWnZzCD8bqPE2SsZsmE4Nao0ZeYT3t4g
         BnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8A0btdNNYUW+hceFW6H28UUkKsXmFXdS4OKZqXjLEa8=;
        b=sGCEKa8Ch0oekqfRgiEV7+UfvqbimyXrY4NwXS2XSG0jzGurRqUTpiabSi5YkjkEe/
         spSuXFrNwnLv4YoVUDhvG2ypvP49jScLJaUt8WfJiRmqoC4UNxKG0mAOrA66v9f/+mlR
         Y/e70mVBmHScjxZquVNxw9CC9WeTI24/BE48eHrB6Op6vlLiswDlUymduv0ck09PP5g2
         XXZ8IaGRzJsbhiYAcvmz2jVSevm6OGV/a7+Ovl8llDgp6LhFzUo71w9Nzw7qAc6MVlGB
         5LEJI6yH2Y3IXpC63oMl0gwX+IRDjVIpMBLCgK5bJhlT4eYbYQ9QG5V0TX1dAy4R3E3h
         EfhA==
X-Gm-Message-State: ACgBeo35XjmwutBeUkmmHUUewrmHXCXhIRfdNu8sU4Yq/JrvfIs+EIgf
        GtDTs/tSeB2YWMz0GyiiIA==
X-Google-Smtp-Source: AA6agR4Lcmd6mQdIn1hBxBZCBlsZrhwg1ubPjxyVI2T9VgII07hSG67zLA5Q7rLqyl9iOEeGntkDUQ==
X-Received: by 2002:adf:dc8d:0:b0:228:6e44:9861 with SMTP id r13-20020adfdc8d000000b002286e449861mr7135787wrj.452.1662700042977;
        Thu, 08 Sep 2022 22:07:22 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.190])
        by smtp.gmail.com with ESMTPSA id i10-20020adfb64a000000b0021efc75914esm909189wre.79.2022.09.08.22.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:07:22 -0700 (PDT)
Date:   Fri, 9 Sep 2022 08:07:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: give /proc/cmdline size
Message-ID: <YxrKCLXE7k16j9xu@localhost.localdomain>
References: <YxoywlbM73JJN3r+@localhost.localdomain>
 <20220908134546.6054f611243da37b4f067938@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908134546.6054f611243da37b4f067938@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:45:46PM -0700, Andrew Morton wrote:
> On Thu, 8 Sep 2022 21:21:54 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Most /proc files don't have length (in fstat sense). This leads
> > to inefficiencies when reading such files with APIs commonly found in
> > modern programming languages. They open file, then fstat descriptor,
> > get st_size == 0 and either assume file is empty or start reading
> > without knowing target size.
> > 
> > cat(1) does OK because it uses large enough buffer by default.
> > But naive programs copy-pasted from SO aren't:
> 
> What is "SO"?

StackOverflow, the source of all best programs in the world!

> > 	let mut f = std::fs::File::open("/proc/cmdline").unwrap();
> > 	let mut buf: Vec<u8> = Vec::new();
> > 	f.read_to_end(&mut buf).unwrap();
> > 
> > will result in
> > 
> > 	openat(AT_FDCWD, "/proc/cmdline", O_RDONLY|O_CLOEXEC) = 3
> > 	statx(0, NULL, AT_STATX_SYNC_AS_STAT, STATX_ALL, NULL) = -1 EFAULT (Bad address)
> > 	statx(3, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_ALL, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0444, stx_size=0, ...}) = 0
> > 	lseek(3, 0, SEEK_CUR)                   = 0
> > 	read(3, "BOOT_IMAGE=(hd3,gpt2)/vmlinuz-5.", 32) = 32
> > 	read(3, "19.6-100.fc35.x86_64 root=/dev/m", 32) = 32
> > 	read(3, "apper/fedora_localhost--live-roo"..., 64) = 64
> > 	read(3, "ocalhost--live-swap rd.lvm.lv=fe"..., 128) = 116
> > 	read(3, "", 12)
> > 
> > open/stat is OK, lseek looks silly but there are 3 unnecessary reads
> > because Rust starts with 32 bytes per Vec<u8> and grows from there.
> > 
> > In case of /proc/cmdline, the length is known precisely.
> > 
> > Make variables readonly while I'm at it.
> 
> It seems arbitrary.  Why does /proc/cmdline in particular get this
> treatment?

We can calculate its length precisely and show to userspace so why not
do it. Other /proc files are trickier.
