Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B43ECE31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhHPF4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 01:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhHPF4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 01:56:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127AC061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 22:55:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g138so10801208wmg.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:mime-version:content-disposition;
        bh=jqBY/ebZYRvdLqk7Wp1d8f7rPHyH1R6AhCB+qEOVxBk=;
        b=m6/l0wGvzFsXShw6tyTgmU0bniaWVrIQtihsSaY/670SGadcIgtQtT0rV7ckBYR07g
         M02HTe1WETgliRbcw49VKOiEfvvJRy/Jn1xfM4gbCZrvLCv9TbwJCdIO16gAUW9TzNZG
         CYUCmJhADuIgF9fgLgvhY/eO5ZebRvVSyGF8PVVvuHaiFg2DGUdosnF3lM/wD3XmjU+L
         4BKEBgGDMZzZ3ZGeCHBsj2hXCg9LRCbb5FHz61KUemkdwU/FtmU+xhk1NdWlaNb/HQI+
         /dSHPIutDXfrpZVhW1/sb3H1C0NeG5Unhk7vk13Sw4B+WFoHfQaZPgIO/X4w0+G1adA3
         7kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition;
        bh=jqBY/ebZYRvdLqk7Wp1d8f7rPHyH1R6AhCB+qEOVxBk=;
        b=E1BUtMCHsz5bWxjYet+Exvn2RWQmwLVwB3OVPeI5sOjJLpznT7eXqBalK4ZAHNYlAB
         Y97bHtgZwO1lvsHpr1VbKrZx04r/ENoTpiY5RyHyXUJEnoIKJ5QvejJ4FD5b6MScA97Z
         ATLc8xahIiJw7tVHxM8m+5ubv0akj1VGaSdzrQDaJplQbdjD+9nv/UCIh4qNgPf10lX/
         wClU4ukQYjjVZ4Ai+WB7dlUziuc/Wwh7ZkTQlqan3j5r4qo4+t8OszvlLwCPsqypjYpZ
         irzUgDF4ZhTEPjDBjX0OMLf1zAbIoKLgekK8eyYllw1461eG/4yECuN+75NxeWkLx+hG
         Af5Q==
X-Gm-Message-State: AOAM530QtF0GL9vJ0fiaY9RaAen5SXAGYlNEDgsEef0qqmLKciGE8H2m
        cw5+cucEfpQItIEPNr5h077saL/W6vc=
X-Google-Smtp-Source: ABdhPJwYdBKmjB9xn4sg19s2cGWKhL8NzrqytAkKD2a+wiuXWmIS0cIwHIGn6Y9jSUeOED8kS2xeTw==
X-Received: by 2002:a05:600c:3793:: with SMTP id o19mr8907068wmr.53.1629093331731;
        Sun, 15 Aug 2021 22:55:31 -0700 (PDT)
Received: from itaypc ([176.228.32.241])
        by smtp.gmail.com with ESMTPSA id o11sm9282463wrj.47.2021.08.15.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 22:55:31 -0700 (PDT)
Date:   Mon, 16 Aug 2021 07:46:33 +0300
From:   Itay Iellin <ieitayie@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linuxfoundation.org, greg@kroah.com,
        ebiederm@xmission.com, security@kernel.org,
        viro@zeniv.linux.org.uk, jannh@google.com
Message-ID: <YRntqf83j2KzHoUm@itaypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bcc: 
Subject: fs/binfmt_elf: Integer Overflow vulnerability report
Reply-To: 
I'm sharing a report of an integer overflow vulnerability I found (in 
fs/binfmt_elf.c). I sent and discussed this vulnerability report with members
of security@kernel.org. I'm raising this for public discussion, with approval
from Greg (greg@kroah.com).

On Sun, Aug 01, 2021 at 04:30:30PM +0300, Itay Iellin wrote:
> In fs/binfmt_elf.c, line 1193, e_entry value can be overflowed. This
> potentially allows to create a fake entry point field for an ELF file.
> 
> The local variable e_entry is set to elf_ex->e_entry + load_bias.
> Given an ET_DYN ELF file, without a PT_INTERP program header, with an 
> elf_ex->e_entry field in the ELF header, which equals to
> 0xffffffffffffffff(in x86_64 for example), and a load_bias which is greater 
> than 0, e_entry(the local variable) overflows. This bypasses the check of 
> BAD_ADDR macro in line 1241.
> 
> It is possible to set a large enough NO-OP(NOP) sled, before the
> actual code, modify the elf_ex->e_entry field so that elf_ex->e_entry+load_bias
> will be in the range where the NO-OP sled is mapped(because the offset
> of the PT_LOAD program header of the text segment can be controlled). 
> This is practically a guess, because load_bias is randomized, the ELF file can
> be loaded a large amount of times until elf_ex->e_entry + load_bias 
> is in the range of the NO-OP sled.
> To conclude, this bug potentially allows the creation of a "fake" entry point
> field in the ELF file header. 
> 
> Suggested git diff:
> 
> Add a BAD_ADDR test to elf_ex->e_entry to prevent from using an
> overflowed elf_entry value.
> 
> Signed-off-by: Itay Iellin <ieitayie@gmail.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 439ed81e755a..b59dcd5857db 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1238,7 +1238,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		kfree(interp_elf_phdata);
>  	} else {
>  		elf_entry = e_entry;
> -		if (BAD_ADDR(elf_entry)) {
> +		if (BAD_ADDR(elf_entry) || BAD_ADDR(elf_ex->e_entry)) {
>  			retval = -EINVAL;
>  			goto out_free_dentry;
>  		}
> -- 
> 2.32.0
> 

I am not attaching the replies to my initial report from the discussion with
members of security@kernel.org, only when or if I will be given permission
from the repliers to do so.

Itay Iellin
