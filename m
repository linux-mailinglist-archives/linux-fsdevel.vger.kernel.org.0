Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6A20C9F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgF1Top (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgF1Too (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 15:44:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438DC03E979;
        Sun, 28 Jun 2020 12:44:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so6513834pgg.10;
        Sun, 28 Jun 2020 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46U5LTf9rFQftrOq8rZJnWLpeHVL1rEif2GhCvIbyXU=;
        b=nwRrXvUhla2rgs08uSaWUjb8zZQG6bfs/KlbXDFJI/HOxYPn5w5mr7ql/l1Z+et3H8
         B3Lwlazj3i8zZ+dXobqL+e7pe2i1b4czgwPCsE0cM2nAq1YkC5ey6bLpdhqrdeDCv/Jw
         4UqzCTDqfymcj59XgWZlhTlzn6jwemaU2UHi2qQgx2EvS6Glvo9eN5dTsQOcXD7wdMqx
         IIwmizNe/+d3dk0KSBF78POcsqexWyIaDZqG0t/K11cj+pJBROMSLFKEhGRFWEbkggcg
         MMNxBk9TYqXqFoiWICxNqupHqdPGYemSJrebqzKphRJP0YUaSnpqRLkOdHBFaaNPmqIZ
         Idnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46U5LTf9rFQftrOq8rZJnWLpeHVL1rEif2GhCvIbyXU=;
        b=OtiWXwmVVUCjtyEwAwIJbP/ktEdwRQnvVZivb7ouYtDMYairDFxIh8les058yQ7W2d
         TVPrbCiPel9y9vto4yJjlTcSJRvN/0mhjqcGMMVj81ohZ6ZJ4/RHijjXRthLOxI6uO+Y
         eDEJE91p/qSuIhJkMeGX9hsJAJOTBcag1Cv/NmrXzPVR9O0Ny9z2d9BYiip2oTRiaNXq
         TBqfkH78Vj9x+ABe3JPrv6q8jBEFmtgg4HPgijq0zPLDzxvr/gs+CJbrIPTKva3yB3jh
         iR4r1Mt/iKyCRnBhVhrUYzXfRh1VeH/R+Q8AAJVviQgKmdcHXLEESbIdEKw7CHONzCpe
         aBtg==
X-Gm-Message-State: AOAM530fcOSVzfFb4dM6DvCEPwOaDNwxQa8YtlDq9aeG4ROGsSYuDaIc
        eeN0yzvmnY2veeUd2X4nd/c=
X-Google-Smtp-Source: ABdhPJwoQlVtn/X4YpQlMUebDpAYoaiy5IBb/4Qr2UmBHT3aj9oiPi+Ba8b8uKZx+BVBVYLMBeVqtw==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr7145153pgi.297.1593373484059;
        Sun, 28 Jun 2020 12:44:44 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:616])
        by smtp.gmail.com with ESMTPSA id n1sm17373239pjn.24.2020.06.28.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:44:43 -0700 (PDT)
Date:   Sun, 28 Jun 2020 12:44:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
Message-ID: <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
 <87366g8y1e.fsf@x220.int.ebiederm.org>
 <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 10:57:10PM +0900, Tetsuo Handa wrote:
> On 2020/06/27 21:59, Eric W. Biederman wrote:
> > Can you try replacing the __fput_sync with:
> > 	fput(file);
> >         flush_delayed_fput();
> >         task_work_run();
> 
> With below change, TOMOYO can obtain pathname like "tmpfs:/my\040test\040driver".
> 
> Please avoid WARN_ON() if printk() is sufficient (for friendliness to panic_on_warn=1 environments).
> For argv[], I guess that fork_usermode_driver() should receive argv[] as argument rather than
> trying to split info->driver_name, for somebody might want to pass meaningful argv[] (and
> TOMOYO wants to use meaningful argv[] as a hint for identifying the intent).
> 
> diff --git a/kernel/umd.c b/kernel/umd.c
> index de2f542191e5..ae6e85283f13 100644
> --- a/kernel/umd.c
> +++ b/kernel/umd.c
> @@ -7,6 +7,7 @@
>  #include <linux/mount.h>
>  #include <linux/fs_struct.h>
>  #include <linux/umd.h>
> +#include <linux/task_work.h>
>  
>  static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *name)
>  {
> @@ -25,7 +26,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
>  	if (IS_ERR(mnt))
>  		return mnt;
>  
> -	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY, 0700);
> +	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY | O_EXCL, 0700);
>  	if (IS_ERR(file)) {
>  		mntput(mnt);
>  		return ERR_CAST(file);
> @@ -41,23 +42,33 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
>  		return ERR_PTR(err);
>  	}
>  
> -	__fput_sync(file);
> +	if (current->flags & PF_KTHREAD) {
> +		__fput_sync(file);
> +	} else {
> +		fput(file);
> +		flush_delayed_fput();
> +		task_work_run();
> +	}

Thanks. This makes sense to me.

>  	return mnt;
>  }
>  
>  /**
>   * umd_load_blob - Remember a blob of bytes for fork_usermode_driver
> - * @info: information about usermode driver
> - * @data: a blob of bytes that can be executed as a file
> - * @len:  The lentgh of the blob
> + * @info: information about usermode driver (shouldn't be NULL)
> + * @data: a blob of bytes that can be executed as a file (shouldn't be NULL)
> + * @len:  The lentgh of the blob (shouldn't be 0)
>   *
>   */
>  int umd_load_blob(struct umd_info *info, const void *data, size_t len)
>  {
>  	struct vfsmount *mnt;
>  
> -	if (WARN_ON_ONCE(info->wd.dentry || info->wd.mnt))
> +	if (!info || !info->driver_name || !data || !len)
> +		return -EINVAL;
> +	if (info->wd.dentry || info->wd.mnt) {
> +		pr_info("%s already loaded.\n", info->driver_name);
>  		return -EBUSY;
> +	}

But all the defensive programming kinda goes against general kernel style.
I wouldn't do it. Especially pr_info() ?!
Though I don't feel strongly about it.

I would like to generalize elf_header_check() a bit and call it
before doing blob_to_mnt() to make sure that all blobs are elf files only.
Supporting '#!/bin/bash' or other things as blobs seems wrong to me.
