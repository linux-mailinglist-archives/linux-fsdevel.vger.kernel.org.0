Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9C2D74C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbgLKLgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 06:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgLKLgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:36:02 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7125C0613D3;
        Fri, 11 Dec 2020 03:35:21 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq13so2064975pjb.3;
        Fri, 11 Dec 2020 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/IhdBUb0scCndiXnRQTPChTtqAPkXlFGtY0OtAx67ck=;
        b=ZKJfsRgFdbM6CxtecB00mhoKyIQaNMNtNznVof2pKSujRS5hkm8rHaZ53cpaq7mOfn
         J80cSQsVx00dJqSccv6V61+4wQ+9f8gEzgEhbBPwO41DmOfT1ui0dHKLPtNPDmsle8mZ
         SYTSEolWksiYZpZHros3sDK+w6Ymra2n5LcfhC2w3T7IKhYR83HcKTnmXGre7kMYwEAU
         CIsw1TaFevRFKPcAP3t1k1CgjClIOVazHOnW21x38vlg5Ct+l7o3scHHFLK60vy94wBM
         EvcJ8cim1URKhy96C+l+d2Oa8Z8G6zjZevcvEuV68FNt0yqCP/5yrSkZJk/br2ses6OL
         YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/IhdBUb0scCndiXnRQTPChTtqAPkXlFGtY0OtAx67ck=;
        b=O5qAcM793TTiXq9Kd+xJrGA9gO5dXBJvQOr1/tTyIfE2cMAmFVpd3OxayXDPxzjBaj
         dDJ8lRbNJOjwfS4N+/JGKPs2+ul5ud4J8Jy9Q0rGrzyJEI88aEDawhCpojagWfaw0sP9
         Uqq5OQipYLjTAWldEfOGw66UpX2JtThrwIuUZMOZwPZjd/Wu8MaCoSKM433vCSQaB3V5
         3TVX89V8ntn00SwEI9ro6j0/Y0hSNaA1uCLp803JAz/3DSV58ak85kXzTvAM4HQqthfr
         JU7AAFKcxvzmOda6g8K/bFdll2EL9NbDIdUh3dkuoaIuQeLx4sBnISGcvZ/m8opxp8ab
         qWEA==
X-Gm-Message-State: AOAM530253EZFvNGBcuKjsCft7gZMcsbOgW6Z2s3edW7nB7zKICCx4pC
        dvCmBoRrNA2WWAIZfsdi/YrYcuqjaLxfsQ==
X-Google-Smtp-Source: ABdhPJySZUD4VjYjbqOhBVhC7H5zIGyb5reb0rZmBLv0Z+plhsTOKJAUfAGTqAI4ormdSTeek15izg==
X-Received: by 2002:a17:902:d907:b029:db:cb2b:8bcc with SMTP id c7-20020a170902d907b02900dbcb2b8bccmr10911717plz.9.1607686521232;
        Fri, 11 Dec 2020 03:35:21 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id v17sm10181233pga.58.2020.12.11.03.35.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Dec 2020 03:35:20 -0800 (PST)
Date:   Fri, 11 Dec 2020 20:35:18 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] vfs: remove comment for deleted argument 'cred'
Message-ID: <20201211113518.GB6945@localhost.localdomain>
References: <20201202125232.19278-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202125232.19278-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20-12-02 21:52:32, Minwoo Im wrote:
> Removed credential argument comment with no functional changes.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  fs/open.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 9af548fb841b..85a532af0946 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -923,7 +923,6 @@ EXPORT_SYMBOL(file_path);
>   * vfs_open - open the file at the given path
>   * @path: path to open
>   * @file: newly allocated file with f_flag initialized
> - * @cred: credentials to use
>   */
>  int vfs_open(const struct path *path, struct file *file)
>  {
> -- 
> 2.17.1
> 

Hello,

Gentle ping,

Thanks!
