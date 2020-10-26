Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3544B299953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 23:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391882AbgJZWH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 18:07:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34760 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391702AbgJZWH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:07:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id t14so6856069pgg.1;
        Mon, 26 Oct 2020 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0VSZbhlydSBKzOaomukoTTp30g7sC2N3nt7wUIINqk=;
        b=N1JD5itU3YYw/BGCFmuNc7BXm2NtCL3p+Di0AcCMValw6fquKQx9bXQZ2RW+Wu2Ia6
         lIXA6lSXUCKY4DxcYQTMhgz1FukjQndV/+T71p6PNQZrb8CAX+Rt7Gh3yNsEAjqWXKh+
         EoRDsd4bNU2VidntDRSwEKLVDNNq1Yw+a7n+mCA9b4+P8IF5HY6CiV4UnGCozu1tmUJF
         /mE7BMZCrTZahcRRr8+rZeeP255OzF2vvDCS7S/4xXnH8N0tgcjNMw4VXJccizxbKxu0
         xVq3TEJM2ASXZNjl2S4afbceoWRNOp2UCoHpaqQc/CEQwP2VfAPEZsFwt91eqVc83Ckw
         FdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0VSZbhlydSBKzOaomukoTTp30g7sC2N3nt7wUIINqk=;
        b=diAIaZYa67o439ojiT5GKyeOQ75NENEL7Xqu19g02CeJpi91EUnBjQ812CkBl68h6k
         H6DJgj+zZ83uUyv3YRgtfA86e70stZ4oLhoenOpOTaHSvvRZu0qq1x4f1Vkv2GeF/JwL
         obGPL9lBZihEelngKlJbbM0WKdefqdAMCyXdREhLxKcuHwGrW749Yr1Zc/r/cfLGsCYM
         0YaoUlOs7wWK1sJJPUpj0nkcnY+UlNvnRgwNRQdr2D/oMBt2lL749bSX16RJcS/45nG9
         8aUFcm4kAEweO51T2mNhDN6vjvZ8WA4KjmWzhDNwqWeV1cXyDP4MNqGHBPJeWN/Yd0JJ
         APBA==
X-Gm-Message-State: AOAM531tY4JKn2P9HxqKO9z5IlhdtrQblLXFuiwFah/eF3AvSHteYcWc
        07+sIQAw5F0Qt3QNMYr32jsbuiXe4vZFmOobosE=
X-Google-Smtp-Source: ABdhPJw0koA9t4G6PoUfU5arsv2hqld465R93zKeGDlFFyUDuLlWXttKmbffNb2aQCrSQBOFxnHocU1y8f5yrJ2tz4k=
X-Received: by 2002:a63:d54e:: with SMTP id v14mr18099847pgi.203.1603750045311;
 Mon, 26 Oct 2020 15:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201026155730.542020-1-tasleson@redhat.com>
In-Reply-To: <20201026155730.542020-1-tasleson@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Oct 2020 00:07:09 +0200
Message-ID: <CAHp75Vfno9LULSfvwYA+4bEz4kW1Z7c=65HTy-O0fgLrzVA24g@mail.gmail.com>
Subject: Re: [PATCH] buffer_io_error: Use dev_err_ratelimited
To:     Tony Asleson <tasleson@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:59 PM Tony Asleson <tasleson@redhat.com> wrote:
>
> Replace printk_ratelimited with dev_err_ratelimited which
> adds dev_printk meta data. This is used by journald to
> add disk ID information to the journal entry.


> This re-worked change is from a different patch series
> and utilizes the following suggestions.
>
> - Reduce indentation level (Andy Shevchenko)
> - Remove unneeded () for conditional operator (Sergei Shtylyov)

This should go as a changelog after the cutter '---' line...

> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> ---

...somewhere here.

...

> -       if (!test_bit(BH_Quiet, &bh->b_state))
> -               printk_ratelimited(KERN_ERR
> -                       "Buffer I/O error on dev %pg, logical block %llu%s\n",
> -                       bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
> +       struct device *gendev;
> +
> +       if (test_bit(BH_Quiet, &bh->b_state))
> +               return;
> +

> +       gendev = bh->b_bdev->bd_disk ?
> +               disk_to_dev(bh->b_bdev->bd_disk) : NULL;

I'm not sure it's a good idea to print '(null)'.

Perhaps

if (bh->b_bdev->bd_disk)
  dev_err_ratelimit(disk_to_dev(bh->b_bdev->bd_disk), ...);
else
  pr_err_ratelimit(...);

?

> +       dev_err_ratelimited(gendev,
> +               "Buffer I/O error, logical block %llu%s\n",

> +               (unsigned long long)bh->b_blocknr, msg);

It's a u64 always (via sector_t), do we really need a casting?

>  }

-- 
With Best Regards,
Andy Shevchenko
