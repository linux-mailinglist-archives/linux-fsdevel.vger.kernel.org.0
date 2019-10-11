Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E71D419C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfJKNoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 09:44:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43110 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKNoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:44:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so8564493qtr.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2019 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RP6aN65maxNeS61oYXW4aZX24s/7aD9eOwCLwc9qZ5s=;
        b=AGIv2DkJ+VS+X5jYXLRNVnza6u+0s+sEwoYilZBapJqcjWMSnWuArLVMCmNnlGPG97
         kEGjrMgHzCgNjEhjYJKRwWhNK57BAWJuwSsOcrxp63PrVzbhKn5+TLugDjz+fZ0gEhDd
         hAm7fRMkl8k4oBbRxJCMD86OrMoLpOSmsRbb4/YgaCfx0/mewM9dMSkAtYAOvyF0gfPr
         Evn0uJ8XkqDCeiIpVOprMk+jGhtbvwS+Vdg7s5/3YLNQDCSpOH8knQ1c+Sr1381eJ/0u
         zUNbNlnKhkGhqZM2WDw1tZSGYaEID1QZenftpz4wznp29P7UoA94j3CWLD5HfA7HRH9+
         DVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RP6aN65maxNeS61oYXW4aZX24s/7aD9eOwCLwc9qZ5s=;
        b=Aog+dnJQ6PkxBY7ocll8s06gSplXKbjDZQk/JGG8JIrmzpGUmdSnEQlCq/euM3lfxi
         wES37pawkv7D/56Fa7P9vjVPuWosHN+Gap1yoVE41VyMHBF7DhbZYxS9G+zSD8TYJOaT
         M/6X8VEAIIjdSMQZKK1GtXTIFGGCXKrd6cXz8RcfhFmmLrqnAOu+AzEHnlCOa2DMzIAF
         6QrcbAshOEYaJ/hJjz7F0OmIiWZHOCbf4U1jbdJJ38ONTvLBOmuKplTyqw150f+UrAGy
         Do32fhYuhVC6yT0HUeirsmip1Fu9ys5Y9aahppaCnA9MoyCW+GNgHrLep3sTiVlqemys
         reYQ==
X-Gm-Message-State: APjAAAW8ZxA/FQgNVrUyv4xl4dtXA5HcP8QydRAm/V1dnQ4wmdI9i6SD
        ANHqTJPqZe2XdFYu96ZYI1b6nPw=
X-Google-Smtp-Source: APXvYqx3a4mpw+2UEaQMKaJ1Zx5E8M6uKBsk3gSMUKOpMFowFr79Rh6eXWVjNdGZC0AnedgPpbO+Lw==
X-Received: by 2002:ac8:7007:: with SMTP id x7mr16261008qtm.89.1570801462571;
        Fri, 11 Oct 2019 06:44:22 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v23sm4491079qto.89.2019.10.11.06.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 06:44:22 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:44:16 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtio_fs: Fix file_system_type.name to virtio_fs
Message-ID: <20191011134415.7s5efb57fyfzmzgs@gabell>
References: <20191004202921.21590-1-msys.mizuma@gmail.com>
 <20191011090208.GC2848@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011090208.GC2848@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stefan,

On Fri, Oct 11, 2019 at 10:02:08AM +0100, Stefan Hajnoczi wrote:
> On Fri, Oct 04, 2019 at 04:29:21PM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > On 5.4.0-rc1 kernel, following warning happens when virtio_fs is tried
> > to mount as "virtio_fs".
> > 
> >   ------------[ cut here ]------------
> >   request_module fs-virtio_fs succeeded, but still no fs?
> >   WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x138
> >   Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
> >   CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1
> > 
> > That's because the file_system_type.name is "virtiofs", but the
> > module name is "virtio_fs".
> > 
> > Set the file_system_type.name to "virtio_fs".
> 
> The mount command-line should be mount -t virtiofs, not mount -t
> virtio_fs.  Existing documentation on https://virtio-fs.gitlab.io/ still
> says mount -t virtio_fs but this is outdated (sorry!).  I will update
> the website and I don't think this patch needs to be merged.
> 
> We originally set the file_system_type.name to "virtio_fs" but Miklos
> explained that other Linux file systems do not contain underscores in
> their names.  The kernel module is called virtio_fs.ko and the code
> internally uses "virtio_fs" as the prefix for function names, but from a
> user point of the view the mount command-line must use "virtiofs".
> 
> Does this sound reasonable?

Yes, make sense to me, thanks!
Do you have the plan to change the module name to virtiofs.ko?
I suppose virtiofs.ko may be good enough to avoid the warning.

Thanks!
Masa
