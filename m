Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003EE12BD3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfL1KKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 05:10:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43232 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfL1KKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 05:10:51 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so26102649ioo.10;
        Sat, 28 Dec 2019 02:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQVDLXoG3OJl9MAwKiT8ijRLZ0D7oeHNde77OTeL3hI=;
        b=d1JDRRkm4o/yL3rudZbk/sKG3il48+EbO5waONXDUtS5VVAnR3GU2Uuh4CLkSFafo9
         QnAH+j5RjNsEMeRx7SwBJCSuIj7sSjezZiijj7LeEio700PZbbB3MdRp8Th4zUQbtMVE
         W36YTCKCOP724RY8S0s96zLUYWl1fIA2mDcSlp+VcjFbcV//DfCLTbfn5rkmeH5z/rtI
         9tBMO/ILJ1gFAEltsoVdt8KGo/SN9XlAcqYj8fWtmLyUOqEFTG73vbXFJbxylk8g6Wa1
         DPhn4/UrL7+VLYOwHAQJwnFaoHME/RAargFVIel/u7yC6WaXT/OuKpAT+wxANawGlSrh
         Tkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQVDLXoG3OJl9MAwKiT8ijRLZ0D7oeHNde77OTeL3hI=;
        b=e7UTRwljlczFoD3lAp+iNEZzKH5q4GdmwS6GZHHAj9+vY61COpLtlf8/HItEkOx6Ls
         du2WH1HI1XcMwNc5kWy7AvBUXTLRBNf7nW1746JZ9ZxpIiGVEE1O5jk/O232ulXlpfkY
         hZPpDIs6DzLyC6tw8kV6xSZ+nM9Tned7Vy6HlpeMmsFl6EVQZCuIoNlKpNvBvsl/OHoi
         F/aodjIZ5p26GT4P2F35OjfgI9/ZUKq90+7l3hiDp3bnSueiPQJcFitIANjnqN5fikGW
         TuOWnHUGQxIDUfAP+/juY0YfRKv4gwOF/6pLXA9QWz5sjWwcXK7Qwue8JsCKmBuaq4Ly
         LwsA==
X-Gm-Message-State: APjAAAW2fS16IzMwMlN8s2rqYBEydhfD3PTamd6MBnFKWiHZg3ICxBuf
        rrRt0uGaUmH4ajg35dCb2JAlbJnpo5/N/SjWXh/t6Yql
X-Google-Smtp-Source: APXvYqznZiIaPHTXON+mBcLVjwOIugad78cCGvRi/9LtbJdUfK8C5A/dqWe3meVMPXBjxkIEqyfYmjZ66ijUOEqFrkM=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr168001ioh.137.1577527850683;
 Sat, 28 Dec 2019 02:10:50 -0800 (PST)
MIME-Version: 1.0
References: <1535374564-8257-1-git-send-email-amir73il@gmail.com>
 <1535374564-8257-7-git-send-email-amir73il@gmail.com> <BC68C02C-E6E5-4414-A1D2-D36D335738E2@dilger.ca>
In-Reply-To: <BC68C02C-E6E5-4414-A1D2-D36D335738E2@dilger.ca>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 28 Dec 2019 12:10:38 +0200
Message-ID: <CAOQ4uxjuJ-6Tw3vw1qahjp2LrGPx=eZfZA9qk47=mWSamEiF+g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] ovl: add ovl_fadvise()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 28, 2019 at 7:49 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Aug 27, 2018, at 6:56 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Implement stacked fadvise to fix syscalls readahead(2) and fadvise64(2)
> > on an overlayfs file.
>
> I was just looking into the existence of the "new" fadvise() method in
> the VFS being able to communicate application hints directly to the
> filesystem to see if it could be used to address the word size issue in
> https://bugzilla.kernel.org/show_bug.cgi?id=205957 without adding a new
> syscall, and came across this patch and the 4/6 patch that adds the
> vfs_fadvise() function itself (copied below for clarity).
>
> It seems to me that this implementation is broken?  Only vfs_fadvise()
> is called from the fadvise64() syscall, and it will call f_op->fadvise()
> if the filesystem provides this method.  Only overlayfs provides the
> .fadvise method today.  However, it looks that ovl_fadvise() calls back
> into vfs_fadvise() again, in a seemingly endless loop?
>

You are confusing endless loop with recursion that has a stop condition.
The entire concept of stacked filesystem is recursion back into vfs.
This is essentially what most of the ovl file operations do, but they recurse
on the "real.file", which is supposed to be on a filesystem with lower
sb->s_stack_depth (FILESYSTEM_MAX_STACK_DEPTH is 2).

> It seems like generic_fadvise() should be EXPORT_SYMBOL() so that any
> filesystem that implements its own .fadvise method can do its own thing,
> and then call generic_fadvise() to handle the remaining MM-specific work.
>
> Thoughts?

Sure makes sense.
Overlayfs just doesn't need to call the generic helper.

Thanks,
Amir.
