Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D329200941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgFSNAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgFSNAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:00:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B357FC06174E;
        Fri, 19 Jun 2020 06:00:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q11so9626252wrp.3;
        Fri, 19 Jun 2020 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ljPyNN/Qwakhqe+XqUeYOBqoxf7hProQtLOxnDnQs48=;
        b=Gc6uaCkqyn8M5NULiegeLR+e+X1JkduCf6rQvSXt8Nl16hZHSKp2biDEJ8StKzqR/r
         1Wcjd6LIBwveF4quZvhVEW1BvqnKkGvhoT4QbYs+t14SeTniS5Jpo561hQW3anupFQ+h
         EFw3T4P2N4ooBB930lvjBYYc3LowpM2sdscZQr0c2LD91eS9EEuWp/4whuZVEGXRXAE6
         jxzIEcdC933SSrQBX4e4nzYKv9MIi2LI5lpgVjanijHeT/MApW5lCMIkXQhgiNfqqJHU
         SwW/fGCEkhxW25+gw/NVDAGvNI3BwUOureUH9XB37sQTh7bgE+2mqxcONVvzg7O2n6kQ
         vDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljPyNN/Qwakhqe+XqUeYOBqoxf7hProQtLOxnDnQs48=;
        b=CvMx+mkD62Dq04psuMvzSbQcqlPFBs31c2evxVd2nbU1hXWSqA79UmHs9tJvufBqkx
         YnkBF5PAEoTW2ucmY4tKkc2+FwfJ/tnkiNjMsM+uId+n3wLOeKCLv5Y6CnLWcn/YTl31
         UT6MPitT6oOr+hbCQ96qM2XMSY6cMdkry+BAQq5ufJqm5DHu6ApeoIjVgRHciaCEG9BI
         1f+fuDdtLkMWb5uj8dnhjrtG0wQZUL5yzyigIS64S9Hlos3V7VT9kgoW+Owj1qCn2qxT
         zMfC8Y8fOb8V1+z2CIsScK9UThDSv9Dqx1qI8N7BB7ycQGCBrNrQPdA2u0Ya/w3z7tw5
         OGdQ==
X-Gm-Message-State: AOAM532L4FFcfaUrhsCIJlIbOfzgKNLhbFk/srsYpH0kMrd5YGy9Mokl
        gXxWDEqNneecRNLTDX2OCzE=
X-Google-Smtp-Source: ABdhPJx/JZS/Eblefk0zI3gb+uu+uT/5gLoiMz5ESaB+mWGa/RKum9IKOsU9NdFWwNFwyMESL8EE2Q==
X-Received: by 2002:a05:6000:341:: with SMTP id e1mr4003694wre.1.1592571616385;
        Fri, 19 Jun 2020 06:00:16 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id e15sm7147479wme.9.2020.06.19.06.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 06:00:15 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        christian@brauner.io
Subject: Re: [PATCH] symlink.7: document magic-links more completely
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
 <20200610055319.26374-1-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <fe72a276-a977-2589-ee83-d6ac8a21fbfa@gmail.com>
Date:   Fri, 19 Jun 2020 15:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610055319.26374-1-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aleksa,

On 6/10/20 7:53 AM, Aleksa Sarai wrote:
> Hi Michael,
> 
> Sorry for the delay and here is the patch I promised in this thread.

Thanks!

Patch applied.

Cheers,

Michael


> --8<---------------------------------------------------------------------8<--
> 
> Traditionally, magic-links have not been a well-understood topic in
> Linux. This helps clarify some of the terminology used in openat2.2.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man7/symlink.7 | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/man7/symlink.7 b/man7/symlink.7
> index 07b1db3a3764..ed99bc4236f1 100644
> --- a/man7/symlink.7
> +++ b/man7/symlink.7
> @@ -84,6 +84,21 @@ as they are implemented on Linux and other systems,
>  are outlined here.
>  It is important that site-local applications also conform to these rules,
>  so that the user interface can be as consistent as possible.
> +.SS Magic-links
> +There is a special class of symlink-like objects known as "magic-links" which
> +can be found in certain pseudo-filesystems such as
> +.BR proc (5)
> +(examples include
> +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> +Unlike normal symlinks, magic-links are not resolved through
> +pathname-expansion, but instead act as direct references to the kernel's own
> +representation of a file handle. As such, these magic-links allow users to
> +access files which cannot be referenced with normal paths (such as unlinked
> +files still referenced by a running program.)
> +.PP
> +Because they can bypass ordinary
> +.BR mount_namespaces (7)-based
> +restrictions, magic-links have been used as attack vectors in various exploits.
>  .SS Symbolic link ownership, permissions, and timestamps
>  The owner and group of an existing symbolic link can be changed
>  using
> @@ -99,16 +114,14 @@ of a symbolic link can be changed using
>  or
>  .BR lutimes (3).
>  .PP
> -On Linux, the permissions of a symbolic link are not used
> -in any operations; the permissions are always
> -0777 (read, write, and execute for all user categories),
>  .\" Linux does not currently implement an lchmod(2).
> -and can't be changed.
> -(Note that there are some "magic" symbolic links in the
> -.I /proc
> -directory tree\(emfor example, the
> -.IR /proc/[pid]/fd/*
> -files\(emthat have different permissions.)
> +On Linux, the permissions of an ordinary symbolic link are not used in any
> +operations; the permissions are always 0777 (read, write, and execute for all
> +user categories), and can't be changed.
> +.PP
> +However, magic-links do not follow this rule. They can have a non-0777 mode,
> +though this mode is not currently used in any permission checks.
> +
>  .\"
>  .\" The
>  .\" 4.4BSD
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
