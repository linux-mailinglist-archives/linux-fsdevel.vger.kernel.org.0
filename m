Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3BD4BEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 03:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfJLBus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 21:50:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35769 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLBur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 21:50:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so16659503qtq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2019 18:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+FrUC66hBMWPncut2Shl80U8fQ0hJ+GFsb37ZtZ2jlk=;
        b=P5dSwqRHVOVUbA546m2ofsVN6fSI2g0WmfIfGEkQNMBQuur/5Iky9CPcvjtH72FjHH
         6tgNQOLRJuj6jwfIJb2F1iDHzCIi2TJlF+hBVDknp6bKpWAtw7/IohK5zzRCOld7vM4S
         sQpYrO7OLRAfpzecYK4lL/GYg6TJUE2Es5OsjHwxi+Q8DD/aR73iQBNCoC/IKWUxuqqA
         mDI9r2FhdP4hp4MuDwizSNqOWSmkvYavH9vn6X0wd5tP/LU+AAQF8k5EU4CT9fd0yGbR
         ZcmQ05IN/2RrWSeaU7YuDU54afvwWW5rO3WlZLnRiJQmw4AZbdXUq+p91Vvvx5LdjtY6
         MD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FrUC66hBMWPncut2Shl80U8fQ0hJ+GFsb37ZtZ2jlk=;
        b=UzvqNX/hm9HdQ42PRKMJA85LLefYp4rafrjI1UK5/9tJERTvUOzqF6DAA1NnFP+UsG
         cjSdIty+wM94Hqx6PBSdNQpXYcVQCx6OfzVXOtKddkunE+wmXSykYxOMSQR3t56t6awl
         avTlrGDGsWxR9jifbRstXE+eOKav5fX8Q799vt+Z6cjJtYLwBmUqsLtK5mSQ5hc9IkLK
         jOFpjZ1ZgmW26xt/DdAxUm62i8uOvQAYiESlGmjAYr7kZcbvowi+vW/spj4Rezw3pbO1
         ujfzm6fq4PL4m6GqHAf0V7a0XE7egbTgbXNekoPi2Ss6iAWa3v0RNKP8rAOigRwH5JsB
         RrXg==
X-Gm-Message-State: APjAAAVN48C498VNYh6IPjEU6W+fCxPZvyYNtmxXU6TJCkkIhzR5OCbJ
        frUKCVik0QKtDRUFBD6u97tvHqE=
X-Google-Smtp-Source: APXvYqy8S+Q9Z32qUy0GbnDVQmljDhZsShAGJEuZJb7mwpMEm/zGr0sD2GbCQdv18ry0o1g00Dzg+g==
X-Received: by 2002:a05:6214:2ea:: with SMTP id h10mr195493qvu.113.1570845046865;
        Fri, 11 Oct 2019 18:50:46 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v94sm4746773qtd.43.2019.10.11.18.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 18:50:46 -0700 (PDT)
Date:   Fri, 11 Oct 2019 21:50:41 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH] virtio_fs: Change module name to virtiofs.ko
Message-ID: <20191012015040.rqb6buo5snmxmq74@gabell>
References: <20191011181826.GA13861@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011181826.GA13861@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek,

On Fri, Oct 11, 2019 at 02:18:26PM -0400, Vivek Goyal wrote:
> We have been calling it virtio_fs and even file name is virtio_fs.c. Module
> name is virtio_fs.ko but when registering file system user is supposed to
> specify filesystem type as "virtiofs".
> 
> Masayoshi Mizuma reported that he specified filesytem type as "virtio_fs" and
> got this warning on console.
> 
>   ------------[ cut here ]------------
>   request_module fs-virtio_fs succeeded, but still no fs?
>   WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x138
>   Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
>   CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1
> 
> So looks like kernel could find the module virtio_fs.ko but could not find
> filesystem type after that.
> 
> It probably is better to rename module name to virtiofs.ko so that above
> warning goes away in case user ends up specifying wrong fs name.

The warning is gone after applied this patch, thanks!
Please feel free to add:

    Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

- Masa

> 
> Reported-by: Masayoshi Mizuma <msys.mizuma@gmail.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/Makefile |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: rhvgoyal-linux/fs/fuse/Makefile
> ===================================================================
> --- rhvgoyal-linux.orig/fs/fuse/Makefile	2019-10-11 13:53:43.905757435 -0400
> +++ rhvgoyal-linux/fs/fuse/Makefile	2019-10-11 13:54:24.147757435 -0400
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_FUSE_FS) += fuse.o
>  obj-$(CONFIG_CUSE) += cuse.o
> -obj-$(CONFIG_VIRTIO_FS) += virtio_fs.o
> +obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
>  
>  fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
> +virtiofs-y += virtio_fs.o
