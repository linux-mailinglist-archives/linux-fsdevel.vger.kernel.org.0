Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C593E2628F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIIHhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 03:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgIIHhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:37:09 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8AC061755;
        Wed,  9 Sep 2020 00:37:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id m1so1400127ilj.10;
        Wed, 09 Sep 2020 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XplU/yDVZod7CQ9qpAr+SAIUpan2fYE9ZFD5UbHSjo=;
        b=EsydC3cWGV5Dkt1QDytC8dB6gCR2nJKlMi0uCSEDWFYuakbamQOijx3ov3GHvRhLBU
         QP3OcQkFYLotAFBcFhrM39Ahdtdx0FLUJajXYRltrmANlmfvndldYRImCYQLdHZt3IKe
         ZNN9ubYuQJsXDd6eFL3Trx3Kw8aiAqz79ffcS2QyCTU3HFnmEAKEr20lAALYpdjn7Av1
         6ZShmkABQRjuVlqRqde1buu/fQDctMUWqIz2UymaY676oNv+zo4QrMH6jiATdRLtCfVj
         AMaCxjzUR/EHGoA0FBeeMbyWxFIyE+LMukDNCAwzhd/oI5G8QgsQ30NHleaL3gzlwGtQ
         46Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XplU/yDVZod7CQ9qpAr+SAIUpan2fYE9ZFD5UbHSjo=;
        b=mI6tkjjmTrxgqfV/YsQ4L8DbZD0WTmM5eDko+FEOO8HD0trFgOkSF1SVazziH7FvAw
         XQTSzh+AKkj9v3xuZZgtLnDbWC8YRhqJdV5YcbgNz8KDjXrhiZdx17eGKNwjbH0yspQS
         AeizcUEoEVnBtngL2/RU44ELl+63JnzRrcCLn8mxJVBAbq1p/FNlluuh5ny+vwr9Oa6v
         GwRFRRQZaXnLWoO6y0WYseqMC4gTfIfAAo1Z0dh6BGLJyYO0Pky9f+km679WKZ82+V+4
         GycT1G2yi6a/qRVVxt01BwWdDZBZxG9JWOGsmySVTp2W1xEYYMNr5GIQbA6X5qKqlR9o
         ABJA==
X-Gm-Message-State: AOAM530u/LlaKsfwid7mS9W90wuixcrtWVBVEaT7b+boXGFZFB+xho9C
        7Bp7RpjufrN/+o7D3m/jTzLnKGKZnx/v7T7aSOg=
X-Google-Smtp-Source: ABdhPJz8uHZflvzrflCvmUJfx+x3RiqZkWqsTrkVrrl+8sX6vVGZdBlDIPNkr1jiZlE4u+HgUQB7+Ex+KbZmsqM5c/E=
X-Received: by 2002:a92:d482:: with SMTP id p2mr2689631ilg.9.1599637028313;
 Wed, 09 Sep 2020 00:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
 <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com> <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
 <20200908171859.GA29953@casper.infradead.org> <CAOQ4uxjX2GAJhD70=6SmwdXPH6TuOzGugtdYupDjLLywC2H5Ag@mail.gmail.com>
 <96abf6e3-2442-8871-c9f3-be981c0a1965@huawei.com>
In-Reply-To: <96abf6e3-2442-8871-c9f3-be981c0a1965@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 9 Sep 2020 10:36:57 +0300
Message-ID: <CAOQ4uxjNcjFtQuc9AeWgEO7G3CeGm3vL_wK6UhbHkxOZuRYOeQ@mail.gmail.com>
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangle6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 9, 2020 at 10:00 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>
> On 2020/9/9 11:44, Amir Goldstein wrote:
> > On Tue, Sep 8, 2020 at 8:19 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Tue, Sep 08, 2020 at 04:18:29PM +0300, Amir Goldstein wrote:
> >>> On Tue, Sep 8, 2020 at 3:53 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> >>>> For example, in fs/coredump.c, do_coredump() calls filp_open() to
> >>>> generate core files.
> >>>> In this scenario, the fsnotify_open() notification is missing.
> >>>
> >>> I am not convinced that we should generate an event.
> >>> You will have to explain in what is the real world use case that requires this
> >>> event to be generated.
> >>
> >> Take the typical usage for fsnotify of a graphical file manager.
> >> It would be nice if the file manager showed a corefile as soon as it
> >> appeared in a directory rather than waiting until some other operation
> >> in that directory caused those directory contents to be refreshed.
> >
> > fsnotify_open() is not the correct notification for file managers IMO.
> > fsnotify_create() is and it will be called in this case.
> >
> > If the reason you are interested in open events is because you want
> > to monitor the entire filesystem then welcome to the future -
> > FAN_CREATE is supported since kernel v5.1.
> >
> > Is there another real life case you have in mind where you think users
> > should be able to get an open fd for a file that the kernel has opened?
> > Because that is what FAN_OPEN will do.
> >
>
> There are also cases where file is opened in read-only mode using
> filp_open().
>
> case1: nfsd4_init_recdir() call filp_open()
> filp_open()
> nfsd4_init_recdir() fs/nfsd/nfs4recover.c#L543
>
> L70: static char user_recovery_dirname[PATH_MAX] =
> "/var/lib/nfs/v4recovery";
> L543: nn->rec_file = filp_open(user_recovery_dirname, O_RDONLY |
> O_DIRECTORY, 0);
>
>
> case2: ima_read_policy()
> filp_open()
> kernel_read_file_from_path()  fs/exec.c#L1004
> ima_read_policy()  security/integrity/ima/ima_fs.c#L286
> ima_write_policy() security/integrity/ima/ima_fs.c#L335
> ima_measure_policy_ops   security/integrity/ima/ima_fs.c#L443
> sys_write()
>
> case3: use do_file_open_root() to open file
> do_file_open_root()
> file_open_root()   fs/open.c#L1159
> kernel_read_file_from_path_initns()  fs/exec.c#L1029
> fw_get_filesystem_firmware()  drivers/base/firmware_loader/main.c#L498
>
> Do we need to add fsnotify_open() in these scenarios?

We do not *need* to add fsnotify_open() if there is no concrete use case
from real life that needs it.

Matthew gave an example of a real life use case and I explained why IMO
we don't need to add fsnotify_open() for the use case that he described.

If you want to add fsnotify_open() to any call site, please come up with
a real life use case - not a made up one, one that really exists and where
the open event is really needed.

grepping the code for callers of filp_open() is not enough.

Thanks,
Amir.
