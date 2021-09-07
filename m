Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FA4024AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbhIGHox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhIGHox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:44:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38F9C061575;
        Tue,  7 Sep 2021 00:43:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m28so17818208lfj.6;
        Tue, 07 Sep 2021 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyNh42KG1X76ikOu0ztNW1R3WqqdGf238vySbKfs0uM=;
        b=m3tVQ/imQU+9vz+sB5ZdKyRBOXFGtpV3u0Fw0zYf8Qb+cUTchLYmE2Yl27Sdsk5BTz
         czWe7t1tlNFmXYhwbHwWuqUkG1ZrM8S96hPdxNmjgZ2y9SB0JtbiQSSC4/XkM0dOyvdo
         2BzLI7YlzODKvsrhrIACL/rksn6vzGZPgknOG/jHBtg4e9fn1mX1s9MNLVAb47xyi99R
         gHSsVQ4lTHIJ4lp0hHB1EV3jnlefO1IujnpXBvwh4as0dvkHkcU4D3psDEqhfcbBYIZC
         fzyB2589yg5S2mMTNPZeOncIjgG3UtZL5FvTRdx+FfHJyPxJUtEzilEFUQsdxI9kc1BA
         P9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iyNh42KG1X76ikOu0ztNW1R3WqqdGf238vySbKfs0uM=;
        b=STH8wEJF5NU6puVn1l5fID5FIyKWFx5VZMNTfqmCv3iSxO0ucKR56k+izfS9/dRd2Z
         GByFZT1XViw3V7p9zxwOsmKF9v0LwzEFOkslH0FaWpgBCIaDPvdVXXnaqAlphJd5eU4l
         96NHhrmo0qtO1ClQiId3IwvkbUmAtzoQt/GzzEAbm++yKk5/Ey9SLLtnT4NrUoAXLo3i
         7yzitL3vmqZ6l4XK2NpFd64J6rkbmQK+BZkQy+ClDsC8/Gm57HHi7+6UOhh0pfjRV6IJ
         lRkE0lIn+QUS3+0EMr38KVdFeoTmuhPxF83RfmJ8vIYU/w7RJInQWwJ/2VRu+8BoJJel
         bNTQ==
X-Gm-Message-State: AOAM533tP+A80UYUqD9ibQiu+1tpGyRRZrnydfbMKI24QjcxXeHs5Lsc
        MgC5xXMFgmXv2zv5rrn06ueF8Lo0404=
X-Google-Smtp-Source: ABdhPJy0t63OLJh901ZHlX+eGK1Vc+jfB9Sys3Cv5A6CrM6RFvqkZ4RY1GIdn+o65wz/wy87YylPmQ==
X-Received: by 2002:a05:6512:3d8c:: with SMTP id k12mr12244983lfv.545.1631000625004;
        Tue, 07 Sep 2021 00:43:45 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id a17sm936678lfb.91.2021.09.07.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 00:43:44 -0700 (PDT)
Date:   Tue, 7 Sep 2021 10:43:42 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] docs: fs: Refactor directory-locking.rst for better
 reading
Message-ID: <20210907074342.ycsuuafn4pjsxbei@kari-VirtualBox>
References: <20210816222639.73838-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816222639.73838-1-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 01:26:39AM +0300, Kari Argillander wrote:
> Reorganize classes so that it is easier to read. Before number 4 was
> written in one lenghty paragraph. It is as long as number 6 and it is
> basically same kind of class (rename()). Also old number 5 was list and
> it is as short as 1, 2, 3 so it can be converted non list.
> 
> This makes file now much readible.

Gently ping for this one.

> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  .../filesystems/directory-locking.rst         | 31 +++++++++----------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
> index 504ba940c36c..33921dff7af4 100644
> --- a/Documentation/filesystems/directory-locking.rst
> +++ b/Documentation/filesystems/directory-locking.rst
> @@ -11,7 +11,7 @@ When taking the i_rwsem on multiple non-directory objects, we
>  always acquire the locks in order by increasing address.  We'll call
>  that "inode pointer" order in the following.
>  
> -For our purposes all operations fall in 5 classes:
> +For our purposes all operations fall in 6 classes:
>  
>  1) read access.  Locking rules: caller locks directory we are accessing.
>  The lock is taken shared.
> @@ -22,26 +22,25 @@ exclusive.
>  3) object removal.  Locking rules: caller locks parent, finds victim,
>  locks victim and calls the method.  Locks are exclusive.
>  
> -4) rename() that is _not_ cross-directory.  Locking rules: caller locks
> -the parent and finds source and target.  In case of exchange (with
> -RENAME_EXCHANGE in flags argument) lock both.  In any case,
> -if the target already exists, lock it.  If the source is a non-directory,
> -lock it.  If we need to lock both, lock them in inode pointer order.
> -Then call the method.  All locks are exclusive.
> -NB: we might get away with locking the source (and target in exchange
> -case) shared.
> +4) link creation.  Locking rules: lock parent, check that source is not
> +a directory, lock source and call the method.  Locks are exclusive.
>  
> -5) link creation.  Locking rules:
> +5) rename() that is _not_ cross-directory.
> +Locking rules:
>  
> -	* lock parent
> -	* check that source is not a directory
> -	* lock source
> -	* call the method.
> +	* Caller locks the parent and finds source and target.
> +	* In case of exchange (with RENAME_EXCHANGE in flags argument)
> +	  lock both the source and the target.
> +	* If the target exists, lock it,  If the source is a non-directory,
> +	  lock it. If we need to lock both, do so in inode pointer order.
> +	* Call the method.
>  
>  All locks are exclusive.
> +NB: we might get away with locking the source (and target in exchange
> +case) shared.
>  
> -6) cross-directory rename.  The trickiest in the whole bunch.  Locking
> -rules:
> +6) rename() that _is_ cross-directory.  The trickiest in the whole bunch.
> +Locking rules:
>  
>  	* lock the filesystem
>  	* lock parents in "ancestors first" order.
> -- 
> 2.30.2
> 
