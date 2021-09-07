Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA840247B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhIGHha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhIGHh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:37:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27BC061575;
        Tue,  7 Sep 2021 00:36:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f2so15084129ljn.1;
        Tue, 07 Sep 2021 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/9Z8PKxz3pa3wY4/B71HzBJ3VJjfMzOUUHFFpqBZuVE=;
        b=QzLIFr1n9pgB0xQdNo7wButDBT2ksR18B1kFAhSzgfZ9lpAPQYgOWhSR1s50c+eC1x
         xsXMb0Bvc8BWqQoo+4oE0TW1SzQY/OShrzZx46UWBjn4gpwJt/MhN19r51cb8a2ttwru
         RYtRHRll7uWY7KWqrPT4TwV53ITeIkShW9zFKIYs8etbmZxwyKr/R7MyI0V4zDKIuwlQ
         Ob9PAN8jj2/AVoLLJDebU6zG0KoqPxP1GcUHFkfmmNrbS7bjEXxQT8jCAsk3AkKdkKTh
         jNUatsytcX+dY6g/06TxURCEU4919NLag8jVeWAfEc1dFuVCfwR6Gs+9sDRKaMjL9mwD
         IQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/9Z8PKxz3pa3wY4/B71HzBJ3VJjfMzOUUHFFpqBZuVE=;
        b=aQgdGmLlXi1Zf+/or1imXneAEtMzlDmAvOoLfP/brzx3ZBIimDdaUAdoGEL7CHXR7v
         EVRPJVSXR79oFVjSDG9BMngWk8LrDFkV0CTDopM/l3E6kH2y5yJ8mdEYw6+9HZSenDa8
         z+mEEvezBEY/EkH63249I08bGLODSyIIP+MzQ7hbeRwKreAPCZtDOp51Jfw9vg3KSY/8
         nDWPq4cTmeyEL73O71+ew5HaGeJWBtMYRf8YZDJAXv8nfo6kr/Qyt3FnlIrn85xNqi+w
         3Kp51EK38rWUnQIzTBQ6+74669UjU3eypaL/7L6HOoBSwy2nkPynHieK6A9jXQsnajP5
         VS+A==
X-Gm-Message-State: AOAM532/TXFp0m+i8ow9Fg82C9e5JmbkoDdtna0pN82/8HHpr0aOnnMN
        +88/eyiq7GhfwrSlpBmuN8AQ1X0O+uw=
X-Google-Smtp-Source: ABdhPJyD+ZNa1BiXYb9jNpsBRVv286Ko+L7ji2PyxUKf52y19cmNrGJxxiB7iODFrzn4dhtSp6jYcQ==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr13431625lji.75.1631000181228;
        Tue, 07 Sep 2021 00:36:21 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id e19sm1342265ljl.47.2021.09.07.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 00:36:20 -0700 (PDT)
Date:   Tue, 7 Sep 2021 10:36:18 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 0/9] fs/ntfs3: Use new mount api and change some opts
Message-ID: <20210907073618.bpz3fmu7jcx5mlqh@kari-VirtualBox>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 12:56:05PM +0300, Kari Argillander wrote:
> See V2 if you want:
> lore.kernel.org/ntfs3/20210819002633.689831-1-kari.argillander@gmail.com
> 
> NLS change is now blocked when remounting. Christoph also suggest that
> we block all other mount options, but I have tested a couple and they
> seem to work. I wish that we do not block any other than NLS because
> in theory they should work. Also Konstantin can comment about this.
> 
> I have not include reviewed/acked to patch "Use new api for mounting"
> because it change so much. I have also included three new patch to this
> series:
> 	- Convert mount options to pointer in sbi
> 		So that we do not need to initiliaze whole spi in 
> 		remount.
> 	- Init spi more in init_fs_context than fill_super
> 		This is just refactoring. (Series does not depend on this)
> 	- Show uid/gid always in show_options()
> 		Christian Brauner kinda ask this. (Series does not depend
> 		on this)
> 
> Series is ones again tested with kvm-xfstests. Every commit is build
> tested.

I will send v4 within couple of days. It will address issues what Pali
says in patch 8/9. Everything else should be same at least for now. Is
everything else looking ok?

> 
> v3:
> 	- Add patch "Convert mount options to pointer in sbi"
> 	- Add patch "Init spi more in init_fs_context than fill_super"
> 	- Add patch "Show uid/gid always in show_options"
> 	- Patch "Use new api for mounting" has make over
> 	- NLS loading is not anymore possible when remounting
> 	- show_options() iocharset printing is fixed
> 	- Delete comment that testing should be done with other
> 	  mount options.
> 	- Add reviewed/acked-tags to 1,2,6,8 
> 	- Rewrite this cover
> v2:
> 	- Rewrite this cover leter
> 	- Reorder noatime to first patch
> 	- NLS loading with string
> 	- Delete default_options function
> 	- Remove remount flags
> 	- Rename no_acl_rules mount option
> 	- Making code cleaner
> 	- Add comment that mount options should be tested
> 
> Kari Argillander (9):
>   fs/ntfs3: Remove unnecesarry mount option noatime
>   fs/ntfs3: Remove unnecesarry remount flag handling
>   fs/ntfs3: Convert mount options to pointer in sbi
>   fs/ntfs3: Use new api for mounting
>   fs/ntfs3: Init spi more in init_fs_context than fill_super
>   fs/ntfs3: Make mount option nohidden more universal
>   fs/ntfs3: Add iocharset= mount option as alias for nls=
>   fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules
>   fs/ntfs3: Show uid/gid always in show_options()
> 
>  Documentation/filesystems/ntfs3.rst |  10 +-
>  fs/ntfs3/attrib.c                   |   2 +-
>  fs/ntfs3/dir.c                      |   8 +-
>  fs/ntfs3/file.c                     |   4 +-
>  fs/ntfs3/inode.c                    |  12 +-
>  fs/ntfs3/ntfs_fs.h                  |  26 +-
>  fs/ntfs3/super.c                    | 486 +++++++++++++++-------------
>  fs/ntfs3/xattr.c                    |   2 +-
>  8 files changed, 284 insertions(+), 266 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
