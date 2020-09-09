Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1126313B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgIIQDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbgIIQDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:03:20 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340AC061756;
        Wed,  9 Sep 2020 09:03:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b17so2844392ilh.4;
        Wed, 09 Sep 2020 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZe2FLTTSbE/n6F/d5+lxuoP/zvLhPAND2sQnvRdXKE=;
        b=SRIw3wD8qb36rmAmhUx8CXTUO1iuSHIemzcH6+WeAaawmp0fB33Ujk193jrG62al2T
         R5uvU+3NsCNxEaKxjp+QuOX2sdI4vCSogTaRSM3k5cQ47KneChIRp7W5oSbTdfWnZWRA
         9dXGwL2GILBNoMEOSATqdL968UflSWG+zmBPUinBAyDEh3Valqq3SvKC2tq1wcrTv1tP
         bJdvywxBsW6V/A0fqEWLEmucOxg4r8VbQMTeTkBJIE0X72hzIffcPA+wjFL1ut9FuyLJ
         JqXKzhnY9G2UKaMijZ0DMYj1lz4M+Pnv5GogE8y4d6t0HLHJQH+gm26ITsqMTeJ2eoue
         sg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZe2FLTTSbE/n6F/d5+lxuoP/zvLhPAND2sQnvRdXKE=;
        b=c9wB9buLJP1HtXJkKn9gJBwjX7NL8JUB0o9kQAGMpd4QLzWMM3RqyoRaqg+KDhKYGQ
         cKfkb5OP30XfCINf0C2uAjOGpYGaAVSpfHmQilZ/TZx5oaWIesPzHTTKhCtNhnvffjR/
         73uJGxqhdFCxmKsX+SGdfF5hn7X3MG799oH1OEOKJKQfFjrXUsaGXVqsnqkWbE19TW6i
         mn9RJKEHq18rcnQN7/J9mkUQkLjRo/xmESnS4wrrtJPI8ZvWvJjJ44jdnFhNLv0MV9n1
         NLyUh5Tf+q4rUF0Nk6dNgq7lFrf4qLMHQl6NScskvLjI5DpGk3mNN3jRgjTOIj8PXKZC
         7I8Q==
X-Gm-Message-State: AOAM530YeXN9l1DqEoKYk/DnAn37n7VpgKK0G9Dm7EotIpG6vuA+eV5Z
        v473u/XSukMLVPOc/b3pVezRzGyplZUaQ01dCn0=
X-Google-Smtp-Source: ABdhPJxo1IKLB8JPIGdfnvsji8BNwsuBg4u/4N9QEkxeUOGJ7mX7I3Td0l3eSdGggQuU3P3jUgxO24p4tKPkU/vH2Ac=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr4250436ils.72.1599667399564;
 Wed, 09 Sep 2020 09:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
 <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com> <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
 <20200908171859.GA29953@casper.infradead.org> <CAOQ4uxjX2GAJhD70=6SmwdXPH6TuOzGugtdYupDjLLywC2H5Ag@mail.gmail.com>
 <96abf6e3-2442-8871-c9f3-be981c0a1965@huawei.com> <CAOQ4uxjNcjFtQuc9AeWgEO7G3CeGm3vL_wK6UhbHkxOZuRYOeQ@mail.gmail.com>
 <20200909111130.GD24207@quack2.suse.cz>
In-Reply-To: <20200909111130.GD24207@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 9 Sep 2020 19:03:07 +0300
Message-ID: <CAOQ4uxj91QxZHSYc46ZTNV59Qr-bEEUKS3n4FvU_UU4VUVkbBg@mail.gmail.com>
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Jan Kara <jack@suse.cz>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangle6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 9, 2020 at 2:11 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 09-09-20 10:36:57, Amir Goldstein wrote:
> > On Wed, Sep 9, 2020 at 10:00 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > >
> > > On 2020/9/9 11:44, Amir Goldstein wrote:
> > > > On Tue, Sep 8, 2020 at 8:19 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >>
> > > >> On Tue, Sep 08, 2020 at 04:18:29PM +0300, Amir Goldstein wrote:
> > > >>> On Tue, Sep 8, 2020 at 3:53 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > > >>>> For example, in fs/coredump.c, do_coredump() calls filp_open() to
> > > >>>> generate core files.
> > > >>>> In this scenario, the fsnotify_open() notification is missing.
> > > >>>
> > > >>> I am not convinced that we should generate an event.
> > > >>> You will have to explain in what is the real world use case that requires this
> > > >>> event to be generated.
> > > >>
> > > >> Take the typical usage for fsnotify of a graphical file manager.
> > > >> It would be nice if the file manager showed a corefile as soon as it
> > > >> appeared in a directory rather than waiting until some other operation
> > > >> in that directory caused those directory contents to be refreshed.
> > > >
> > > > fsnotify_open() is not the correct notification for file managers IMO.
> > > > fsnotify_create() is and it will be called in this case.
> > > >
> > > > If the reason you are interested in open events is because you want
> > > > to monitor the entire filesystem then welcome to the future -
> > > > FAN_CREATE is supported since kernel v5.1.
> > > >
> > > > Is there another real life case you have in mind where you think users
> > > > should be able to get an open fd for a file that the kernel has opened?
> > > > Because that is what FAN_OPEN will do.
> > > >
> > >
> > > There are also cases where file is opened in read-only mode using
> > > filp_open().
> > >
> > > case1: nfsd4_init_recdir() call filp_open()
> > > filp_open()
> > > nfsd4_init_recdir() fs/nfsd/nfs4recover.c#L543
> > >
> > > L70: static char user_recovery_dirname[PATH_MAX] =
> > > "/var/lib/nfs/v4recovery";
> > > L543: nn->rec_file = filp_open(user_recovery_dirname, O_RDONLY |
> > > O_DIRECTORY, 0);
> > >
> > >
> > > case2: ima_read_policy()
> > > filp_open()
> > > kernel_read_file_from_path()  fs/exec.c#L1004
> > > ima_read_policy()  security/integrity/ima/ima_fs.c#L286
> > > ima_write_policy() security/integrity/ima/ima_fs.c#L335
> > > ima_measure_policy_ops   security/integrity/ima/ima_fs.c#L443
> > > sys_write()
> > >
> > > case3: use do_file_open_root() to open file
> > > do_file_open_root()
> > > file_open_root()   fs/open.c#L1159
> > > kernel_read_file_from_path_initns()  fs/exec.c#L1029
> > > fw_get_filesystem_firmware()  drivers/base/firmware_loader/main.c#L498
> > >
> > > Do we need to add fsnotify_open() in these scenarios?
> >
> > We do not *need* to add fsnotify_open() if there is no concrete use case
> > from real life that needs it.
> >
> > Matthew gave an example of a real life use case and I explained why IMO
> > we don't need to add fsnotify_open() for the use case that he described.
> >
> > If you want to add fsnotify_open() to any call site, please come up with
> > a real life use case - not a made up one, one that really exists and where
> > the open event is really needed.
> >
> > grepping the code for callers of filp_open() is not enough.
>
> Yeah. So in kernel, things are both ways. There are filp_open() users that
> do take care to manually generate fsnotify_open() event (most notably
> io_uring, exec, or do_handle_open) and there are others as Xiaoming found
> which just don't bother.  I'm not sure filp_open() should unconditionally
> generate fsnotify_open() event as IMO some of those notifications would be
> more confusing than useful.
>
> OTOH it is true that e.g. for core dumping we will generate other fsnotify
> events such as FSNOTIFY_CLOSE (which is generated in __fput()) so missing

And to be fair, those kernel callers will probably also end up generating
FS_ACCESS/FS_MODIFY too.

> FSNOTIFY_OPEN is somewhat confusing. So having some consistency in this
> (either by generating FSNOTIFY_OPEN or by not generating FSNOTIFY_CLOSE)
> would be IMO desirable.

Well, dropping events (FS_CLOSE in particular) didn't go down well the
last time we tried it:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com/

I am just wondering who is using FS_OPEN these days and whether
they would care about this change and if not, why are we doing it?

The argument that it is confusing to see FS_ACCESS/FS_MODIFY/FS_CLOSE
and not seeing FS_OPEN is only half true - it is common to see that
pattern when the file is already open when starting to watch, so application
should not break because of that pattern.

Thanks,
Amir.
