Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D447B393A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjI2R6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjI2R6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:58:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B41AE
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 10:58:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c7373cff01so7036655ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010290; x=1696615090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aC5cjqNqRJMxYKokdjVvuutOF44kRshAAYS87I+O62E=;
        b=JNmmSwTEcryloizv5tdu+Ls/qdTcndi6/swlVQSdJlnZynz0f1ozH0IXOUiQwwacWX
         gA53iIFBa18TppC0po0wY9Vyw80uxJ975Xn/Lk9lax8r2p66Vb4K1sS6lakTuy1c7IB/
         XF00Pp105IxxTIoCr1/G2dBs0nGD4hfD4HNTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010290; x=1696615090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC5cjqNqRJMxYKokdjVvuutOF44kRshAAYS87I+O62E=;
        b=GnI5CFlQQjAMmiFQPfDcxfMwcADQbo0N/wZ/jsk2oLPqxi3+wd9NZ/+f/iVXUa2Jkh
         tPmJceuX130gp+UTzLBDiasbs0zatnXvBgtcz9MM8QknpPMzNAYbUaKTWAP5k7F1GFV3
         5pRFTVsKA+9rqIfRpn8VNXD24XwEQMJ3i+9f09X7M4BqgAZOhFGAZcxwguE6y/Bb8Ajn
         DbDdWaiYde12XLSpwhHaZkc3i3/FIZwZl9rbTScSwrrqdEDUIoAa1hJCWdBxFOQEZ2Ly
         5MhyiCaS++SuVIj+kIiEgpB1nDAT1lAejvqF9Sf1GpbdXMrEHDGTyT5dEtr8PAB+CgUP
         8lKw==
X-Gm-Message-State: AOJu0Yym/cfkEFIoYfsJECuknTu2OdKk5KUpXY2PpYLeluSDud8ntibe
        UH0WLLIJeOMnm6v070RDbXZKnQ==
X-Google-Smtp-Source: AGHT+IHTIjg4MTnthyGSXNTf2walb3iE8iYvnRDi6RgHJI+jmXwtGUsNBG2O4G4ZKvRYL0FJ4zprVQ==
X-Received: by 2002:a17:902:e5d1:b0:1c3:e5bf:a9fe with SMTP id u17-20020a170902e5d100b001c3e5bfa9femr8315131plf.30.1696010290068;
        Fri, 29 Sep 2023 10:58:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b001c5f0fe64c2sm1628550pll.56.2023.09.29.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:58:09 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:58:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        ebiederm@xmission.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_elf_fdpic: clean up debug warnings
Message-ID: <202309291057.6D4993BA@keescook>
References: <20230927132933.3290734-1-gerg@kernel.org>
 <202309270858.680FCD9A85@keescook>
 <9e4cf2c9-a1a9-43a8-3f72-2824301bbc98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4cf2c9-a1a9-43a8-3f72-2824301bbc98@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:53:09PM +1000, Greg Ungerer wrote:
> Hi Kees,
> 
> On 28/9/23 01:59, Kees Cook wrote:
> > On Wed, Sep 27, 2023 at 11:29:33PM +1000, Greg Ungerer wrote:
> > > The binfmt_elf_fdpic loader has some debug trace that can be enabled at
> > > build time. The recent 64-bit additions cause some warnings if that
> > > debug is enabled, such as:
> > > 
> > >      fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file’:
> > >      fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘Elf64_Addr’ {aka ‘long long unsigned int’} [-Wformat=]
> > >         46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
> > >            |                                 ^~~~~~~~
> > >      ./include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
> > >        427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
> > >            |                         ^~~~
> > > 
> > > Cast values to the largest possible type (which is equivilent to unsigned
> > > long long in this case) and use appropriate format specifiers to match.
> > 
> > It seems like these should all just be "unsigned long", yes?
> 
> Some of them yes, but not all.
> For example trying to use unsigned long in the last chunk of this patch:
> 
> fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file_by_direct_mmap’:
> fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat=]

Oh, something is actually using "long long" already. :P Gotcha. Thanks!

-Kees

-- 
Kees Cook
