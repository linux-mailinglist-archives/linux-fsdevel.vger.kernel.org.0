Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC823314D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgG3LzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgG3LzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:55:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C877C061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 04:55:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so12643167ioa.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9gIZhR3sJgnE+GwQ+VNDDJBn0xqTyF/KGDLhuwY780=;
        b=OhkgSX/HddmdTRnWU6lVJcbKIDe9NPhqaRP4lley0oIB2+BkKJXwlJU5ZZ1xbUkKvI
         2wEzq41YGPefc3zqpeUch1ZS3BqbKCx+zgAXCXIMtNPoAuIzmE/cwUMN/hO6rkzqEI2C
         Bnap//TR1gVLIctdsLnDPBfRqeh21VGjF2pWeSmaufdDdAVzSnZx1UvzqhxvlKY9MroR
         IrRBKNIBdbEfdwixftd7tOVOJ3JADZF16ZaKLE/x7hKKY4Juf8BWq+qTpgRIjcoXr9SF
         51IbSVgXwATkQe4hNGSwDzLF062pqFb+KY+Z3AdkRPn4xAAbnUscV0TtlptO+xit1tFi
         vRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9gIZhR3sJgnE+GwQ+VNDDJBn0xqTyF/KGDLhuwY780=;
        b=DIWeoim+MzgXEXZp1GWNINR6t00v2MMnfTXCUwANkQOsoSNtGbxWsoieV9fsKs2ixW
         QlYtYwpuPhl3egcRkc+mFVsO2dMX44n5uVnKAbweyMhzZMCZH4oG6+DzxNMV5b9sWtU9
         EZSlD9bGAH/nZfC6ba3Pak8XHVrRkaAPx2iMIDJLVcw+5T5IIcw4+bpSDOYawpKG1zp1
         nJtOyyROM+4P3oMN8fN9Tq8Jg2YJT0J4a39kbKTx1qk3Ifh6s12dD6eBe7vrAQJKsRSe
         +l/0o/1wL7wV8ZI7pUqr8xjNG3/iCe4vxumacASKp0mnQ0T1483XHsswhcspX/BP4esj
         fORw==
X-Gm-Message-State: AOAM530QcJpJg4XYvStVkxA6wLrhLbcJTqhB8z+wfqdHZjdnysaoY3JC
        VZMLRN1j02uNIzY2dFAnpaOg3cxTYiUoRj4Pcq+tOATf
X-Google-Smtp-Source: ABdhPJxL9rwDmRP5j5p7i2ocgoYyDhk1hTIWEymDA4OLIA+9Gv8eRKizESiGKYVufsz4lunIXBQ9XF0qc/s0BWVX/8I=
X-Received: by 2002:a5e:980f:: with SMTP id s15mr23209125ioj.5.1596110122828;
 Thu, 30 Jul 2020 04:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200730111339.GA54272@mwanda>
In-Reply-To: <20200730111339.GA54272@mwanda>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 Jul 2020 14:55:11 +0300
Message-ID: <CAOQ4uxgEG9PNtdoMXw52_C4oaUQpi2DVx34_QEHeV195e3kYdg@mail.gmail.com>
Subject: Re: [bug report] fsnotify: pass dir and inode arguments to fsnotify()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 2:13 PM <dan.carpenter@oracle.com> wrote:
>
> Hello Amir Goldstein,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 40a100d3adc1: "fsnotify: pass dir and inode arguments to
> fsnotify()" from Jul 22, 2020, leads to the following Smatch
> complaint:

That's an odd report, because...

>
>     fs/notify/fsnotify.c:460 fsnotify()
>     warn: variable dereferenced before check 'inode' (see line 449)
>
> fs/notify/fsnotify.c
>    448          }
>    449          sb = inode->i_sb;
>                      ^^^^^^^^^^^
> New dreference.

First of all, two lines above we have
if (!inode) inode = dir;

This function does not assert (inode || dir), but must it??
This is even documented:

 * @inode:      optional inode associated with event -
 *              either @dir or @inode must be non-NULL.

Second,
The line above was indeed added by:
40a100d3adc1: "fsnotify: pass dir and inode arguments to fsnotify()"

However...

>
>    450
>    451          /*
>    452           * Optimization: srcu_read_lock() has a memory barrier which can
>    453           * be expensive.  It protects walking the *_fsnotify_marks lists.
>    454           * However, if we do not walk the lists, we do not have to do
>    455           * SRCU because we have no references to any objects and do not
>    456           * need SRCU to keep them "alive".
>    457           */
>    458          if (!sb->s_fsnotify_marks &&
>    459              (!mnt || !mnt->mnt_fsnotify_marks) &&
>    460              (!inode || !inode->i_fsnotify_marks) &&
>                      ^^^^^^
> Check too late.  Presumably this check can be removed?

But this line was only added later by:
9b93f33105f5 fsnotify: send event with parent/name info to
sb/mount/non-dir marks

So, yes, the check could be removed.
It is a leftover from a previous revision, but even though it is a leftover
I kind of like the code better this way.

In principle, an event on sb/mnt that is not associated with any inode
(for example
FS_UNMOUNT) could be added in the future.
And then we will have to fix documentation and the inode dereference above.

In any case, thank you for the report, but I don't see a reason to make any
changes right now.

Thanks,
Amir.
