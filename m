Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3744B222452
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgGPNyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgGPNyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:54:20 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA05C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:54:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so5112730ilh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKzdsYylb43QvzCVxHnOOJtd1Q3E45AaWqtvPF20hK0=;
        b=uZM023NMelnSWVNTf9y8xJBD2fk2puB1xkn8JoFJ/pKxgmJq5A0g0j5csMUPxqLNZ7
         DThJICqb8Bc7TPMfQd8mBj9puN2cJmWkmOKONndsSi7Mqd+n+xtNvVhfaI+8RGDeLUmx
         5i31/geggDyXdbjGrGgRP7IBo4UVbKJRaZZPoM8pIj3bVxrnSS5JXZDia/eHlqEJ/hUG
         LnrOczvW5BLC3f2zbpqJzoa9wPk+HGuRIvrOUZHdllcNufyo3zM72MG+J/IoAs6hWOUP
         FV1+iuyXbBSw/FGGy5uwnTgCvKhJ0TYpp5o2BKaXKU91DW69APJ4B+mTgN/78BcD3nDn
         9oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKzdsYylb43QvzCVxHnOOJtd1Q3E45AaWqtvPF20hK0=;
        b=p20qXFsrf4+wKt2uvz5yGAVXczxSbCP+qj2zwiaY0dDnUwf4rfzOTva4OT0BxfbCRM
         YHpTU+08uCtWxj0WGlMrESZX8Nx0c5qvG41Y3+VSJVoZ/yoo5NL+9ztfs3yaMyVpOmTS
         H19E+SywresYcpSm5VfpzPYUQWdGOyEcX8qK5zbR+Ivl8bdHa8umwjCl6BtAwEkXSY/D
         UXtwHFD0Smnfl6lCQ133FyX1MfuA1hl+OktdzmbmN9fi0qNzjTDU/bs7f6MXDLuPHsaZ
         wppYMkCXR4myh/Get2bOQRHxIpDXVBRSjCjj9lyTzMZlB5pGUWRX+P/LRzHCTtoMrNIM
         duwg==
X-Gm-Message-State: AOAM531uUVDYUdHplorFiTtMpsXVStkiOvW9JTlWL5XBb6QCeUrQoxKM
        WjsyT5EkUZNy8W4w5vKj/MYKbFltUIJL6z4WPAaepdAl
X-Google-Smtp-Source: ABdhPJwBc0VE5QtQfcDL2z9bbvRQpzbNel0VBNMqDfjqiOp4e115Ea2ZliIhUBK78bbIXpuM3xALmxRk6QRtzZloed8=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4844667ilj.9.1594907659553;
 Thu, 16 Jul 2020 06:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-17-amir73il@gmail.com>
 <20200716131311.GC5022@quack2.suse.cz> <20200716132941.GD5022@quack2.suse.cz>
In-Reply-To: <20200716132941.GD5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 16:54:08 +0300
Message-ID: <CAOQ4uxjXQWRtxWbiL8Y_01dMC8ntbYi4QnzpfHQqiJ3pP=i5Vg@mail.gmail.com>
Subject: Re: [PATCH v5 16/22] fsnotify: remove check that source dentry is positive
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 4:29 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 15:13:11, Jan Kara wrote:
> > On Thu 16-07-20 11:42:24, Amir Goldstein wrote:
> > > Remove the unneeded check for positive source dentry in
> > > fsnotify_move().
> > >
> > > fsnotify_move() hook is mostly called from vfs_rename() under
> > > lock_rename() and vfs_rename() starts with may_delete() test that
> > > verifies positive source dentry.  The only other caller of
> > > fsnotify_move() - debugfs_rename() also verifies positive source.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > But in vfs_rename() if RENAME_EXCHANGE is set and target is NULL,
> > new_dentry can be negative when calling fsnotify_move() AFAICT, cannot it?
>
> FWIW, renameat2() doesn't allow RENAME_EXCHANGE with non-existent target
> and I didn't find any other place that could call vfs_rename() with
> RENAME_EXCHANGE and negative target but still vfs_rename() seems to support
> that and so fsnotify should likely handle that as well.

If some code did call vfs_rename() like that d_exchange() will barf:

void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
{
        write_seqlock(&rename_lock);

        WARN_ON(!dentry1->d_inode);
        WARN_ON(!dentry2->d_inode);

Thanks,
Amir.
