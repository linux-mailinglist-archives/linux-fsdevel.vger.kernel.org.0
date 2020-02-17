Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65225161C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgBQUHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 15:07:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34882 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgBQUHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:07:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so12912977qtv.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 12:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WRwA/I2h7N76jJ29N/xHFETqMD8CrhcmkSDenSlSwPE=;
        b=GwIgaR7Z144hwANO37ACfKdY3X4Jfr+EmMHyMMrlZGEqnA8DLnAfUAYyTXpHjOsVpM
         LIe/nxFGGg3JkZ0SWkzZU0TCQGLEoXEk7gqL4h/ogwQaHQgiIensFgQ1MkbKyCSVxquM
         rl2JLjLH5ZfzEOx/bl2Hy6d6+Ndblf4OQrJawcSFvPidwhvWcG7IvUsvmFOe8AjJ6wgL
         rGbi2ftprZvXkLdQVaGWvhkVfHujx9e/tWa852n9W6+a0PhAVk1huB9cm92G4+ugt/ij
         swNgIeltU28qeebhIGSWklM76yWYg7uUS3ZEUDriCaZcnpv+z5neVgyH4xaJlvle2Qix
         OMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WRwA/I2h7N76jJ29N/xHFETqMD8CrhcmkSDenSlSwPE=;
        b=DF4RMjjtybV0bdrJ0wKLcTarXe1tbdDh4Z35f2lEkL9UDxlpLqx+99sMfVC2GtPcox
         7dP6ctK5gR8c/C9lfd+r2AyUum/yfIKBQYk0GzVc2afhsw6jR1Cl98vHWkP9DCNCfRlD
         Frctxe6D7Ny7Ti1fbpXev2F8dIG8Os8BrbCPcN+8U4UAOL5ArrEHRruLK6e3iYRi4hxb
         1KmrJ+tlE2n/LseDFuk1hQ1VzebpnB9dPK4QlQbeP6/FHRKyymMTIZy2wUQjYm+1qH5y
         t0hXOeiXM52c1euLwhDtWa9E+xYZMvMk+N7Fe17SAXgnDDs6ZhOiWOc2+CwxpmFrcThW
         H61g==
X-Gm-Message-State: APjAAAUtx6YqXM8FKuHj+nXM52YYhe3Q9V6LDly3iIY2swz+7HBQGw5N
        e/YcYV0141tEvaB1K2MXFHAlqg==
X-Google-Smtp-Source: APXvYqzCfnwZfo0KKey4CpVeLut5atSFfTJKjVjZ7Ss08JTsNn80ACeHv0BuWp1XUZ6gbh4Ku1WXmw==
X-Received: by 2002:ac8:6f5b:: with SMTP id n27mr13640761qtv.96.1581970057370;
        Mon, 17 Feb 2020 12:07:37 -0800 (PST)
Received: from elm ([184.169.45.4])
        by smtp.gmail.com with ESMTPSA id l10sm749766qke.93.2020.02.17.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 12:07:36 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:07:21 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH 13/44] docs: filesystems: convert ecryptfs.txt to ReST
Message-ID: <20200217200721.GA277681@elm>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <6e13841ebd00c8d988027115c75c58821bb41a0c.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e13841ebd00c8d988027115c75c58821bb41a0c.1581955849.git.mchehab+huawei@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-02-17 17:11:59, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Add a document title;
> - use :field: markup;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add table markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Tyler Hicks <code@tyhicks.com>

This serves as a reminder that eCryptfs document is in serious need of
some updates. Thanks!

Tyler

> ---
>  .../{ecryptfs.txt => ecryptfs.rst}            | 44 ++++++++++++-------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 28 insertions(+), 17 deletions(-)
>  rename Documentation/filesystems/{ecryptfs.txt => ecryptfs.rst} (70%)
> 
> diff --git a/Documentation/filesystems/ecryptfs.txt b/Documentation/filesystems/ecryptfs.rst
> similarity index 70%
> rename from Documentation/filesystems/ecryptfs.txt
> rename to Documentation/filesystems/ecryptfs.rst
> index 01d8a08351ac..7236172300ef 100644
> --- a/Documentation/filesystems/ecryptfs.txt
> +++ b/Documentation/filesystems/ecryptfs.rst
> @@ -1,14 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================================
>  eCryptfs: A stacked cryptographic filesystem for Linux
> +======================================================
>  
>  eCryptfs is free software. Please see the file COPYING for details.
>  For documentation, please see the files in the doc/ subdirectory.  For
>  building and installation instructions please see the INSTALL file.
>  
> -Maintainer: Phillip Hellewell
> -Lead developer: Michael A. Halcrow <mhalcrow@us.ibm.com>
> -Developers: Michael C. Thompson
> -            Kent Yoder
> -Web Site: http://ecryptfs.sf.net
> +:Maintainer: Phillip Hellewell
> +:Lead developer: Michael A. Halcrow <mhalcrow@us.ibm.com>
> +:Developers: Michael C. Thompson
> +             Kent Yoder
> +:Web Site: http://ecryptfs.sf.net
>  
>  This software is currently undergoing development. Make sure to
>  maintain a backup copy of any data you write into eCryptfs.
> @@ -19,13 +23,15 @@ SourceForge site:
>  http://sourceforge.net/projects/ecryptfs/
>  
>  Userspace requirements include:
> - - David Howells' userspace keyring headers and libraries (version
> -   1.0 or higher), obtainable from
> -   http://people.redhat.com/~dhowells/keyutils/
> - - Libgcrypt
>  
> +- David Howells' userspace keyring headers and libraries (version
> +  1.0 or higher), obtainable from
> +  http://people.redhat.com/~dhowells/keyutils/
> +- Libgcrypt
>  
> -NOTES
> +
> +Notes
> +=====
>  
>  In the beta/experimental releases of eCryptfs, when you upgrade
>  eCryptfs, you should copy the files to an unencrypted location and
> @@ -33,20 +39,21 @@ then copy the files back into the new eCryptfs mount to migrate the
>  files.
>  
>  
> -MOUNT-WIDE PASSPHRASE
> +Mount-wide Passphrase
> +=====================
>  
>  Create a new directory into which eCryptfs will write its encrypted
>  files (i.e., /root/crypt).  Then, create the mount point directory
> -(i.e., /mnt/crypt).  Now it's time to mount eCryptfs:
> +(i.e., /mnt/crypt).  Now it's time to mount eCryptfs::
>  
> -mount -t ecryptfs /root/crypt /mnt/crypt
> +    mount -t ecryptfs /root/crypt /mnt/crypt
>  
>  You should be prompted for a passphrase and a salt (the salt may be
>  blank).
>  
> -Try writing a new file:
> +Try writing a new file::
>  
> -echo "Hello, World" > /mnt/crypt/hello.txt
> +    echo "Hello, World" > /mnt/crypt/hello.txt
>  
>  The operation will complete.  Notice that there is a new file in
>  /root/crypt that is at least 12288 bytes in size (depending on your
> @@ -59,10 +66,13 @@ keyctl clear @u
>  Then umount /mnt/crypt and mount again per the instructions given
>  above.
>  
> -cat /mnt/crypt/hello.txt
> +::
>  
> +    cat /mnt/crypt/hello.txt
>  
> -NOTES
> +
> +Notes
> +=====
>  
>  eCryptfs version 0.1 should only be mounted on (1) empty directories
>  or (2) directories containing files only created by eCryptfs. If you
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index c6885c7ef781..d6d69f1c9287 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -59,6 +59,7 @@ Documentation for filesystem implementations.
>     cramfs
>     debugfs
>     dlmfs
> +   ecryptfs
>     fuse
>     overlayfs
>     virtiofs
> -- 
> 2.24.1
> 
