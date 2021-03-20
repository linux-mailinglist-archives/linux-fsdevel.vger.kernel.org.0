Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004A4342EB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 19:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCTSCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCTSCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:02:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6AC061574;
        Sat, 20 Mar 2021 11:02:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id 61so12362954wrm.12;
        Sat, 20 Mar 2021 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y34Z2sYEqx8+Z085rLmxqTJuYpOYKVEzZ/YVnvyeTMw=;
        b=kjIVkXJ36I2Qt7lurCEQEj5L5sCmC3RPd3qPDA2p54rNMEjTakL+NfUaKxYEm8yjRk
         RstI4aebJwc/nzQa1/YZ52BTb8gKWzAyFXyvwLbgOGyyKcL8NEWn4Tf6ySvt2k0o5TwR
         6dRgS0hmIXx+nF3FjSEkU0xB2EPS0ShdTghz1dALh8e+Q46yTZQ+n0/qNZctIO394LW5
         OOmAxwAriXNQLWY9XjffIqab1YHWf3FeF2dNhtXtxm6jnIguph3SJ5JLOFKP2FzYKQoe
         sonYLz4dHTdy+WYaFZJ4gZFSpHguw5/59PtF963oIUO/71eDyVsUrS86R2YeiLMhtxoS
         xS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y34Z2sYEqx8+Z085rLmxqTJuYpOYKVEzZ/YVnvyeTMw=;
        b=e1vBYmbuhS4bvAaHCzuKHdC+b5IfwkUuYAP0kMjhlzH1j9cP/dSJP1gvZt/jht8uR3
         stp2VQ9rATgk/zwQhe3Cg0fiJBqIm33WJSSo4pZ0nvRay5iY5R6SRZsHT7Qs7lY67wo0
         51+fuWqBDw3cDviGQ/GyjHYEUdEq5oYkKiJfzkLfIsJjf02I5BqJmfH4VkvTtKEa9Pqm
         Zgt9G1ZHPJtcKNaalM1T9d52v1COAnf0dTA9UH390J0LKwluWV9wmPbYnIdKnsPeSFud
         FFJzq8GAff12Ih2ofgPwyZ2lA2ZIm2/b5E6UctaATQ8RpsWRmoPtx3O2VOFGpNgOK/Sv
         rOqw==
X-Gm-Message-State: AOAM531NHGfnvERLkZ2EdUcoaHdEB8XDBBR6HFR3OzZ6xRQwgyN7rQgK
        85s8pGz95F9X7nlDFoTUDVg=
X-Google-Smtp-Source: ABdhPJylyg7eaxr+BKrcNJy497vxnfEinjCT0Ga9qJs/+pT1JylGvI54hNs6dPk7Wt9nAfEeIq+U2A==
X-Received: by 2002:a5d:640b:: with SMTP id z11mr9900833wru.327.1616263338023;
        Sat, 20 Mar 2021 11:02:18 -0700 (PDT)
Received: from example.org (ip-94-113-225-162.net.upcbroadband.cz. [94.113.225.162])
        by smtp.gmail.com with ESMTPSA id z1sm13926870wru.95.2021.03.20.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:02:17 -0700 (PDT)
Date:   Sat, 20 Mar 2021 19:02:14 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: delete redundant subset=pid check
Message-ID: <20210320180214.xxet7yjxivp4aiaq@example.org>
References: <YFYYwIBIkytqnkxP@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFYYwIBIkytqnkxP@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 06:46:08PM +0300, Alexey Dobriyan wrote:
> Two checks in lookup and readdir code should be enough to not have
> third check in open code.
> 
> Can't open what can't be looked up?

As far as I remember, I first added pidonly processing here and later then
I disabled lookup. Now this is unnecessary.

Acked-by: Alexey Gladkov <gladkov.alexey@gmail.com>

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  fs/proc/inode.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -483,7 +483,6 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
>  
>  static int proc_reg_open(struct inode *inode, struct file *file)
>  {
> -	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
>  	struct proc_dir_entry *pde = PDE(inode);
>  	int rv = 0;
>  	typeof_member(struct proc_ops, proc_open) open;
> @@ -497,9 +496,6 @@ static int proc_reg_open(struct inode *inode, struct file *file)
>  		return rv;
>  	}
>  
> -	if (fs_info->pidonly == PROC_PIDONLY_ON)
> -		return -ENOENT;
> -
>  	/*
>  	 * Ensure that
>  	 * 1) PDE's ->release hook will be called no matter what
> 

-- 
Rgrds, legion

