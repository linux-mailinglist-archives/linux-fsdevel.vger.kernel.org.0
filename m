Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006C02FA299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392545AbhAROKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 09:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392694AbhAROKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:10:18 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F7C061573;
        Mon, 18 Jan 2021 06:09:38 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e7so18342413ljg.10;
        Mon, 18 Jan 2021 06:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iG/KODEdFe2K5XObeKF2Vt9sHmAGSpX5UKzCfopjxSU=;
        b=Doz5K836XN1Hu+ccBz6D+76OvCCWqvKkTjJEAyQHNkKqiW4p8y8ozBLbZTrINgHPyp
         VuNMnMugMs+ZDX4Hpa5bMn4VXIk46qKF4OrdpToe2/qcEFtMszNKdhSk1fgDh8yMex2X
         fiPsJW+kYFl2JskHlpVQzzyZKfWTQo923x35mOiTa2nlrS8HVwYTe8n+GMuSKqO2M7iO
         83HX6CI3Y/Dd8klK+A06De/2Peb1dQ+qChXMAdvjSktv/KOQ427Zv6Ru4tBfNq6GBnk2
         MvhxbZg28tKsGm5ahRBPRR0XQ8tOmBM7rx1UErFmOEbugwnaMWfTPyZZ/YJfiMA49OHP
         aOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iG/KODEdFe2K5XObeKF2Vt9sHmAGSpX5UKzCfopjxSU=;
        b=LL+ecc1ZeiqR9ytjHds7s27wZ2/7dd1EMbKmC7ynOWn1s6Xzjb81Z/E51v4prgiqO3
         02PNhWCfnUDzebzLY33VcBSD+mipjiTWrVNA3O7wscENNf3ekJOk/cIRB6qpmjc6Iu39
         ux/vxbevKJ0yctMV8V7682exeBstAQtxl+BpP3Z077IuFnLC8Z7XICq3n8tFXyXHp8pY
         ZYZk+w6jvpFpB0/r6ErwQfkcsNjcBgmpB/+iOJVIdcHyw7Ah/FkzozXRwNXmakJMRNvj
         gUN3egK8hyZfxYUPf4+vGW0F18IXMAtbwBoeU4CzP1v/IlMbM8lyrHLbAdj0Rq7sA+25
         9WRA==
X-Gm-Message-State: AOAM5331uhmZpSj3KLNz1o1XsedapExnhLh9MYINxj555TjrN83oGNFs
        uA754rc04JDxccZtpXnNFS+SHzOhHVYXpw==
X-Google-Smtp-Source: ABdhPJw1Gz9tbnGLQVkzqltWwFI0JVgvnT623otswaeYadxrv4/5z7VU+iCrgj9FnAJXYbtqgUBEng==
X-Received: by 2002:a2e:9246:: with SMTP id v6mr10308478ljg.221.1610978974812;
        Mon, 18 Jan 2021 06:09:34 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id v11sm1695394ljg.128.2021.01.18.06.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:09:34 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:09:31 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v17 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20210118140931.e2qdposfez2jsbbr@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
 <20210103195017.fim2msuzj3kup6rq@kari-VirtualBox>
 <750a0cef33f34c0989cacfb0bcd4ac5e@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750a0cef33f34c0989cacfb0bcd4ac5e@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:35:05AM +0000, Konstantin Komarov wrote:
> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Sunday, January 3, 2021 10:50 PM
> > On Thu, Dec 31, 2020 at 06:23:53PM +0300, Konstantin Komarov wrote:
> > > diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> > 
> > > +int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
> > > +		      const struct cpu_str *uni, umode_t mode, dev_t dev,
> > > +		      const char *symname, u32 size, int excl,
> > > +		      struct ntfs_fnd *fnd, struct inode **new_inode)
> > > +{
> > 
> > > +#ifdef CONFIG_NTFS3_FS_POSIX_ACL
> > 
> > In Kconfig this is NTFS3_POSIX_ACL. This repeat every file.
> > 
> 
> This is OK. You may refer to similar parts of ext4/btrfs sources as a
> reference:
> fs/ext4/Kconfig or fs/btrfs/Kconfig
> 

But in ext4 and btrfs Kconfig specify *_FS_POSIX_ACL. In ntfs3 Kconfig
specify *_POSIX_ACL. So we missing _FS_ in our Kconfig?

