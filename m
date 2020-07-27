Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2422F137
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 16:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgG0Oae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbgG0OVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE8C061794;
        Mon, 27 Jul 2020 07:21:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so15081639wrl.4;
        Mon, 27 Jul 2020 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=08HVDBYiMLNS5XaEBrGoenMFHqqclU1QBddk4akAPFw=;
        b=hI3i+gfEGNazjpvSI75AsgFBxTTz4xmK3jIwBaYMfM3Zne+iiqhonRBJGk4ZPGeOap
         OAc+UieDDbHdQ7AwSGd5BIrzzAcaAudriODK+OK+g/G0iaB7pficesjRa9vUUhyRIjU9
         DmwGtMhWUl8pYw/ZE1WxOULHa0jATpX0BNKBtT9HhcuaptGLSs3a2oNPcnKsDa0J9cRp
         gioUy4YBv+SeeyVaMrJyH6xMYxUkl/uC6ti/fG1ar5nNThP3oqKpzoooSmoPlUbYCJVd
         WZmp/O9Rk6VYfCMv20+sU2D1PCTxIHDeQENcIN+rEzMzQEX3fLX8jCr0mWfc37XskeeR
         sBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=08HVDBYiMLNS5XaEBrGoenMFHqqclU1QBddk4akAPFw=;
        b=qEvqMI2wQTaaheO3kki+OY3bfDge+1GzYYhsX47tDG26sx/BWZGCDZ6eu1y2igxUJg
         la2sYOlFE9Fl0RXcuWAbNgLcn0sDVe+pXCOxPM4WFKrXOE9625mLST8Jtqf11Dbir6k/
         AeLmFBJpsRbcUycd7cWWn0OPEA3xRZ3SE07imIVyYDyVKPZ1+suQTTQJSInO3lvyp+pG
         8o1bO6QSlNRY/Wla3jT0tDrXvUFtOMDCXebPR4g1Xw8u7r5DBGlGZyqx1u2adEGDGIk4
         TfcOA83fPJ8dDSJRNwS8u0PRau5CXYsSYb6d+Wfb6nt83rc+n3W37G1sDrrlhzHFp3T+
         x/uQ==
X-Gm-Message-State: AOAM532Xshj4YrqIwbk5YKa6MJ8ffwK75pCnfcLnjz67cJzf7nl3c7Ue
        sSsj9EY8wdQiv10v+rceHWn4sP0=
X-Google-Smtp-Source: ABdhPJzK61MEVIVpGuumk3//Y/qZrqM2db/on+NNv8Bei1v2JPIIdN+CuQuvn66Oi+9hF5Quff4Tng==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr22157101wru.201.1595859703886;
        Mon, 27 Jul 2020 07:21:43 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.162])
        by smtp.gmail.com with ESMTPSA id r11sm17493493wmh.1.2020.07.27.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:21:43 -0700 (PDT)
Date:   Mon, 27 Jul 2020 17:21:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Pascal Bouchareine <kalou@tfz.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v3] proc,fcntl: introduce F_SET_DESCRIPTION
Message-ID: <20200727142140.GA116567@localhost.localdomain>
References: <20200725045921.2723-1-kalou@tfz.net>
 <20200725052236.4062-1-kalou@tfz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200725052236.4062-1-kalou@tfz.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:22:36PM -0700, Pascal Bouchareine wrote:
> This command attaches a description to a file descriptor for
> troubleshooting purposes. The free string is displayed in the
> process fdinfo file for that fd /proc/pid/fdinfo/fd.
> 
> One intended usage is to allow processes to self-document sockets
> for netstat and friends to report

> +static long fcntl_set_description(struct file *file, char __user *desc)
> +{
> +	char *d;
> +
> +	d = strndup_user(desc, MAX_FILE_DESC_SIZE);

This should be kmem accounted because allocation is persistent.
To make things more entertaining, strndup_user() doesn't have gfp_t argument.

> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
> +
> +	spin_lock(&file->f_lock);
> +	kfree(file->f_description);
> +	file->f_description = d;
> +	spin_unlock(&file->f_lock);

Generally kfree under spinlock is not good idea.
You can replace the pointer and free without spinlock.

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -980,6 +980,9 @@ struct file {
>  	struct address_space	*f_mapping;
>  	errseq_t		f_wb_err;
>  	errseq_t		f_sb_err; /* for syncfs */
> +
> +#define MAX_FILE_DESC_SIZE 256
> +	char                    *f_description;

struct file is nicely aligned to 256 bytes on distro configs.
Will this break everything?

	$ cat /sys/kernel/slab/filp/object_size
