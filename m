Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978F7377975
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 02:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEJACg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhEJACg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 20:02:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE3C061573;
        Sun,  9 May 2021 17:01:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so9237924pjv.1;
        Sun, 09 May 2021 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RCbsF0rsHchNF4Z47MfeXnkE48Z3YPKTAxzeoF4KGWI=;
        b=F6s38GpEolJEV6UGVlzsKCgWD0v7DhR4sgKU1BhtB9dZRsJfeiuzHIYDSDqVjBhGWW
         eTjRswb2/t70afCmqzQchfJgpGjsypQFx60HAnuxQjG0VGYM4egd6wAg6tHSvNqcI07X
         xtlTL6QGfRdixmDBFIFjA7mAnxbJOuHHs+N00SSK6cy0xUAT5kSDySd/bwyTQxkZM++9
         a7I2xMkt97CpFjXZDrPvZIZooVnNPfFiJ7qP6DBBeHdJLw+kRHHRHSK8O72YnQ6xwYC0
         fUdGPnvW4O/aocrYuKf3LmyAwJAtu3OCvOhCBiU+VA4h8yklvgmWOQOZbM3LnfNRA2PI
         0qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCbsF0rsHchNF4Z47MfeXnkE48Z3YPKTAxzeoF4KGWI=;
        b=RAy7B7sl2rLIPviusVgn/XiorCCllLWcXTWpjPCvaiBcBZoTZuUkj8ac3W3UTlQMW3
         y9whGHgveE/wasP/w2EYmh1c0duHPHBh9yDZz80ytrdKYxdbnny4mr88PnE8gi91ipVk
         uvngniPn192LHxDawqIxQMvHb5Q6gTBk5CAdb5YupjZ+APRMWfh293GfvO/6S+NE7PvU
         EXbjfGAoc2Qvycf1hl2kygIDMGc/xYruA8ShPzgyUdrW69F8L0dFAHucKB51YsuBcxOL
         yhW7T+Hnxl1oqdU19uOEeJguAYOy7v8q2bMmx7/XbjTgQinB8YDZp0cusrDWLJlgZf5f
         h5HA==
X-Gm-Message-State: AOAM532qR1sccScM4L9VJtbvx6Xjd2VFJZfzbM4M/wOaAG6ApqkfxXHF
        F5iVdvxoB3NU6Joxj9oiyD4=
X-Google-Smtp-Source: ABdhPJx/WcYYj3yWUknHesGy1DMzm/LquwtgJQXW4aClNXHF34qK6pR3cH2MiYV2mW6a7a8KYAKCNQ==
X-Received: by 2002:a17:90a:a384:: with SMTP id x4mr24408383pjp.201.1620604891941;
        Sun, 09 May 2021 17:01:31 -0700 (PDT)
Received: from [192.168.192.21] (47-72-82-130.dsl.dyn.ihug.co.nz. [47.72.82.130])
        by smtp.gmail.com with ESMTPSA id q24sm9334079pgb.19.2021.05.09.17.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 17:01:31 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Subject: Re: [PATCH] copy_file_range.2: Update cross-filesystem support for
 5.12
To:     Alejandro Colomar <alx.manpages@gmail.com>
References: <20210509213930.94120-1-alx.manpages@gmail.com>
 <20210509213930.94120-12-alx.manpages@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <a95d7a31-2345-8e1e-78d7-a1a8f7161565@gmail.com>
Date:   Mon, 10 May 2021 12:01:20 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210509213930.94120-12-alx.manpages@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alex,

On 5/10/21 9:39 AM, Alejandro Colomar wrote:
> Linux 5.12 fixes a regression.
> 
> Cross-filesystem (introduced in 5.3) copies were buggy.
> 
> Move the statements documenting cross-fs to BUGS.
> Kernels 5.3..5.11 should be patched soon.
> 
> State version information for some errors related to this.

Thanks. Patch applied.

Cheers,

Michael

> 
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> Related: <https://lwn.net/Articles/846403/>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Ian Lance Taylor <iant@google.com>
> Cc: Luis Lozano <llozano@chromium.org>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Olga Kornievskaia <aglo@umich.edu>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: CIFS <linux-cifs@vger.kernel.org>
> Cc: samba-technical <samba-technical@lists.samba.org>
> Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Cc: Walter Harms <wharms@bfs.de>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>  man2/copy_file_range.2 | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 467a16300..843e02241 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -169,6 +169,9 @@ Out of memory.
>  .B ENOSPC
>  There is not enough space on the target filesystem to complete the copy.
>  .TP
> +.BR EOPNOTSUPP " (since Linux 5.12)"
> +The filesystem does not support this operation.
> +.TP
>  .B EOVERFLOW
>  The requested source or destination range is too large to represent in the
>  specified data types.
> @@ -184,10 +187,17 @@ or
>  .I fd_out
>  refers to an active swap file.
>  .TP
> -.B EXDEV
> +.BR EXDEV " (before Linux 5.3)"
> +The files referred to by
> +.IR fd_in " and " fd_out
> +are not on the same filesystem.
> +.TP
> +.BR EXDEV " (since Linux 5.12)"
>  The files referred to by
>  .IR fd_in " and " fd_out
> -are not on the same mounted filesystem (pre Linux 5.3).
> +are not on the same filesystem,
> +and the source and target filesystems are not of the same type,
> +or do not support cross-filesystem copy.
>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
> @@ -200,8 +210,11 @@ Areas of the API that weren't clearly defined were clarified and the API bounds
>  are much more strictly checked than on earlier kernels.
>  Applications should target the behaviour and requirements of 5.3 kernels.
>  .PP
> -First support for cross-filesystem copies was introduced in Linux 5.3.
> -Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> +Since Linux 5.12,
> +cross-filesystem copies can be achieved
> +when both filesystems are of the same type,
> +and that filesystem implements support for it.
> +See BUGS for behavior prior to 5.12.
>  .SH CONFORMING TO
>  The
>  .BR copy_file_range ()
> @@ -226,6 +239,12 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
>  such as the use of reflinks (i.e., two or more inodes that share
>  pointers to the same copy-on-write disk blocks)
>  or server-side-copy (in the case of NFS).
> +.SH BUGS
> +In Linux kernels 5.3 to 5.11,
> +cross-filesystem copies were implemented by the kernel,
> +if the operation was not supported by individual filesystems.
> +However, on some virtual filesystems,
> +the call failed to copy, while still reporting success.
>  .SH EXAMPLES
>  .EX
>  #define _GNU_SOURCE
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
