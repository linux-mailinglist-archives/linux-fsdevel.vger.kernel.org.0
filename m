Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E280C43BBBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 22:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhJZUoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhJZUoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:44:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF6EC061570;
        Tue, 26 Oct 2021 13:41:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x192so1335830lff.12;
        Tue, 26 Oct 2021 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i9xK3m0+QaW1ytl/BRy95Ub0ZBDl1hcy1DWr+j4fMbg=;
        b=naRBgU4BXY0RqB9ZsH6oaD+wUpURcaVHycpwSBYJdhst+iNIydG72/38udPfb8eVHh
         eczs4BYVblPZN0mz9UtHWcOfjEPLcju2JndfOhe2wQyOHjfN+sczAelDaZyFg2QTbIij
         9NgsUHmpJwqUeb8SuSPlvdtyvveJzwocNvqJE5D6uZC/1ShW7rpEaS2dhd6zCC0euTaj
         xn5kEKFMimMrmvyR2UZuqc0o6FRbVWv2cVzqXnbgvFzVMbTGfYEDkaWHX8ribejUmtQg
         P8jea0T68omrrtxbL23VRNmFkuGZ4QGxG8uzSilZ6DawZEcVxmE9Dcd4YVpt9Q0lnJTU
         mvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9xK3m0+QaW1ytl/BRy95Ub0ZBDl1hcy1DWr+j4fMbg=;
        b=2IRYQ4LjKQBQHfSL8/1EDD06YVoMTFP7AShR/DpCVs7Vfhn3Wko2WV6CabaXqQmT5e
         2pvHtNMgd+YTLthxZ3+maINyyJUU16M2tDL75MQmMd9a8KksJiwY+Bw6ANddF5He9hwv
         wDS1Nsa8FnfG5JU5FV3G6neIsTlRldnO5X6gWPp6bBXDqIj7MH3yS9hQddGGqVpeAf+s
         zrhgMk/w/61DWaomtehru7tyZzOktdbp2j1XJoN1siIfU+dOOl41g4Ak86JUlzTF/KBh
         J+vUyalBf19vV2DXAnjSMeYSPvsRWWADez0In3syx2CNK1AMHdopOK3mPrSoSrbchD5K
         cunQ==
X-Gm-Message-State: AOAM532O5eaPQBPIZ1XeG+dQ6MaZcZkgNONZk5ZdiuBgQ/V7eZ1p+WPj
        OIg3QtsBJaE/uce9nFTjJkOomyBGQ+o=
X-Google-Smtp-Source: ABdhPJzRYMJPy+zP3RzrrChtN8taT1UDuV/pxPlgKTKbxOCRk4Vd2KUCYi/6DbDzbENatMTmkpjZ1A==
X-Received: by 2002:a05:6512:31c9:: with SMTP id j9mr5231661lfe.217.1635280894522;
        Tue, 26 Oct 2021 13:41:34 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id bt20sm2036909lfb.47.2021.10.26.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:41:33 -0700 (PDT)
Date:   Tue, 26 Oct 2021 23:41:32 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs/ntfs3: Update i_ctime when xattr is added
Message-ID: <20211026204132.kyez7uu4qhv7q2wl@kari-VirtualBox>
References: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
 <d5482090-67d1-3a54-c351-b756b757a647@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5482090-67d1-3a54-c351-b756b757a647@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 07:41:50PM +0300, Konstantin Komarov wrote:
> Ctime wasn't updated after setfacl command.
> This commit fixes xfstest generic/307

When I run xfstest I get

generic/307		[20:37:41][   21.436315] run fstests generic/307 at 2021-10-26 20:37:41
[   23.362544]  vdc:
[failed, exit status 1] [20:37:45]- output mismatch (see /results/ntfs3/results-default/generic/307.out.bad)
    --- tests/generic/307.out	2021-08-03 00:08:10.000000000 +0000
    +++ /results/ntfs3/results-default/generic/307.out.bad	2021-10-26 20:37:45.172171949 +0000
    @@ -1,2 +1,4 @@
     QA output created by 307
     Silence is golden
    +setfacl: symbol lookup error: setfacl: undefined symbol: walk_tree
    +error: ctime not updated after setfacl
    ...
    (Run 'diff -u /root/xfstests/tests/generic/307.out /results/ntfs3/results-default/generic/307.out.bad'  to see the entire diff)

any ideas you get different result?

> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/xattr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 3ccdb8c2ac0b..157b70aecb4f 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -992,6 +992,9 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>  	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
>  
>  out:
> +	inode->i_ctime = current_time(inode);
> +	mark_inode_dirty(inode);
> +
>  	return err;
>  }
>  
> -- 
> 2.33.0
> 
> 
