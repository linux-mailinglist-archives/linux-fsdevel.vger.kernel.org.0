Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C87204B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEPL3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:29:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42573 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPL3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:29:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id j53so3363552qta.9;
        Thu, 16 May 2019 04:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzVcxVnFAhhhwS6SmNGAz5LONQcWFWbAgnrIavt93QM=;
        b=i5e05YEm2CLkMuCjTAinCSid6d3qF5ZvxR0AdVDFr2b4c5gZEkeGv0h3YOYrMgFAvh
         J/qbhh/aY+kvytRidKViKCZkpaTHhCDmS8KWKryOZwU9a603/hT69SPKr38VdNogDiIg
         AJgIcbQt/FS9NI8PZ0HLc7ZN8V6IVPlnJ4RdCl70dn2a+Rc/wq5pz2wh0Gr/K4YovwUg
         6r5hgb4mN4khhHKOXy/IJlIEj7wrxFyFcKtQZmMxWfCs5kqjuaTxutm1RtbLElSDi6vy
         Hj53jpIqJKa1bEgKy93iKpo3gELv64skKI6XhY+m+SpqmUzR9gcb7TdXs43KFpvCFTS/
         EKxQ==
X-Gm-Message-State: APjAAAU3bl4c+uylYvR0nJ9XzB6BoF6+LxAZjvybEj+7pW/1jv4a9mPh
        4he/9oL/kubEmi7GqzXEcu8fKgz/dPeoHYAt+28=
X-Google-Smtp-Source: APXvYqz2d9dZQwnnUk9pUn0cYUvFT0Pdw9MFbIzzIkr6l/rN+HuIopzXxgFtiZa5CopJqIL8faKjbCutlYXzRDoSfhw=
X-Received: by 2002:ac8:390e:: with SMTP id s14mr18333086qtb.343.1558006175664;
 Thu, 16 May 2019 04:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <155800581545.26930.2167325198332902897.stgit@warthog.procyon.org.uk>
 <155800583882.26930.17007472666085260160.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800583882.26930.17007472666085260160.stgit@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 13:29:19 +0200
Message-ID: <CAK8P3a3qtr4kvVRf0bvUOzv342px++wi7iA44zCmNRi_ipUd_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] uapi, x86: Fix the syscall numbering of the mount API syscalls
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 1:24 PM David Howells <dhowells@redhat.com> wrote:
>
> Fix the syscall numbering of the mount API syscalls so that the numbers
> match between i386 and x86_64 and that they're in the common numbering
> scheme space.
>
> Fixes: a07b20004793 ("vfs: syscall: Add open_tree(2) to reference or clone a mount")
> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> Fixes: 24dcb3d90a1f ("vfs: syscall: Add fsopen() to prepare for superblock creation")
> Fixes: ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
> Fixes: 93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
> Fixes: cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
