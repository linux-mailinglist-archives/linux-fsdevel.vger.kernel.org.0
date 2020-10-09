Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C073288B22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgJIOcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388974AbgJIOcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:32:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A5C0613D2;
        Fri,  9 Oct 2020 07:32:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r4so2628947ioh.0;
        Fri, 09 Oct 2020 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yjfO8S7B64loScyytPKcgPu2g7gJPYx9uhdcodm9LjI=;
        b=aCLVJuNL4MjVBM0l8LllSfj8gDREo92fbX/U2m4VzlyeBWW0U9vvBv+S3EaITWOT+7
         zTA8drWbzHHemrCof92NV8NM5fjR6qJKxKWC5+wBPownkRhds4foTVGx8x7EccVwWiuq
         plRN98RqHjmoMVdal/SEx0l1DtmvdW2BVcE2rJADce5q/otFHOWKEn9cW/Rrxe7Cagys
         joSBhJkPzCgQ75vUZCcCbGAQqHFtb1a2HHmnfWeozC6QUyyS2SshWnKjn+HSDP08yG9H
         gVJe0g3pI6We5ij5kGqORbou8wIurnIVoLlY5+B7QEZLpfaj1vLSBaK+CvqL6smsKGst
         TRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yjfO8S7B64loScyytPKcgPu2g7gJPYx9uhdcodm9LjI=;
        b=FMRUOzw2VY3fnYYAIhVyLjHIQq1eaeXAgg/HhsOIrwBrsOpihnh4D6S98guA0kZvL+
         4SSykrowWCcei6ODibJd3sPdvpuhE4K+DypnPVNgfoSbo07UvyJS3wYEKoZ7jqYQJKvT
         HRHuxZKR3Um5bAxpLoWXYe4z4aht2k96WSyKueGcLWs1pGG6Wma4uasjceHTnHB7RG4q
         P/oWjRVdA7ucAc9QioKc9HZG7DaGnI/3z7m24aSlHZn3JGDJhSgkwHqo2yRKUJ8TRQ2g
         Drs9EZc1xpths2m8As+KkvDP7Qv3q1LyRLUeoG1IospcrBowg5qjOKjtBLY+bDeGWRFb
         n86A==
X-Gm-Message-State: AOAM5327dvEicX0yq1XEA107JKuPNIJjlJNNEHsi+2w8/57cdD+cCtmu
        Rrt2pkeDGrCOkbG1waa0mlPf3jZfY15yF//9cqI=
X-Google-Smtp-Source: ABdhPJxO128SkgXvqwjCnu0yIALTpGyDfWaYuo9sk5kmRa3Nb1uLZ2zcfyW0/51mwatoHZBsKFvJ3e4gvvVY7LA4gFM=
X-Received: by 2002:a5e:dc0a:: with SMTP id b10mr9828942iok.156.1602253924816;
 Fri, 09 Oct 2020 07:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
 <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
In-Reply-To: <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 16:31:51 +0200
Message-ID: <CA+icZUU+UwKY8jQg9MfbojimepWahFSRU6DUt=468AfAf7uCSA@mail.gmail.com>
Subject: Re: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 4:10 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 3:49 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi Ted,
> >
> > with <ext4.git#dev> up to commit
> > ab7b179af3f98772f2433ddc4ace6b7924a4e862 ("Merge branch
> > 'hs/fast-commit-v9' into dev") I see some warnings (were reported via
> > kernel-test-bot)...
> >
> > fs/jbd2/recovery.c:241:15: warning: unused variable 'seq' [-Wunused-variable]
> > fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
> > uninitialized whenever 'if' condition is true
> > [-Wsometimes-uninitialized]
> > fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
> > uninitialized whenever '||' condition is true
> > [-Wsometimes-uninitialized]
> >
> > ...and more severe a build breakage with CONFIG_JBD2=and CONFIG_EXT4_FS=m
> >
> > ERROR: modpost: "jbd2_fc_release_bufs" [fs/ext4/ext4.ko] undefined!
> > ERROR: modpost: "jbd2_fc_init" [fs/ext4/ext4.ko] undefined!
> > ERROR: modpost: "jbd2_fc_stop_do_commit" [fs/ext4/ext4.ko] undefined!
> > ERROR: modpost: "jbd2_fc_stop" [fs/ext4/ext4.ko] undefined!
> > ERROR: modpost: "jbd2_fc_start" [fs/ext4/ext4.ko] undefined!
> >
> > Looks like missing exports.
> >
>
> This fixes it...
>
> $ git diff
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 8a51c1ad7088..e50aeefaa217 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -754,6 +754,7 @@ int jbd2_fc_start(journal_t *journal, tid_t tid)
>
>        return 0;
> }
> +EXPORT_SYMBOL(jbd2_fc_start);
>
> /*
>  * Stop a fast commit. If fallback is set, this function starts commit of
> @@ -778,11 +779,13 @@ int jbd2_fc_stop(journal_t *journal)
> {
>        return __jbd2_fc_stop(journal, 0, 0);
> }
> +EXPORT_SYMBOL(jbd2_fc_stop);
>
> int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid)
> {
>        return __jbd2_fc_stop(journal, tid, 1);
> }
> +EXPORT_SYMBOL(jbd2_fc_stop_do_commit);
>
> /* Return 1 when transaction with given tid has already committed. */
> int jbd2_transaction_committed(journal_t *journal, tid_t tid)
> @@ -954,6 +957,7 @@ int jbd2_fc_release_bufs(journal_t *journal)
>
>        return 0;
> }
> +EXPORT_SYMBOL(jbd2_fc_release_bufs);
>
> /*
>  * Conversion of logical to physical block numbers for the journal
> @@ -1389,6 +1393,7 @@ int jbd2_fc_init(journal_t *journal, int num_fc_blks)
>                return -ENOMEM;
>        return 0;
> }
> +EXPORT_SYMBOL(jbd2_fc_init);
>
> /* jbd2_journal_init_dev and jbd2_journal_init_inode:
>  *
>

[ CC: Harshad Shirwadkar <harshadshirwadkar@gmail.com> ]

Hi Harschad,

Can you look at this?

git blame shows these commits are involved:

11a6ce6a4efc2 (Harshad Shirwadkar         2020-09-18 17:54:46 -0700
728) int jbd2_fc_start(journal_t *journal, tid_t tid)
11a6ce6a4efc2 (Harshad Shirwadkar         2020-09-18 17:54:46 -0700
777) int jbd2_fc_stop(journal_t *journal)
11a6ce6a4efc2 (Harshad Shirwadkar         2020-09-18 17:54:46 -0700
782) int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid)
96df8fb629b26 (Harshad Shirwadkar         2020-09-18 17:54:47 -0700
934) int jbd2_fc_release_bufs(journal_t *journal)
d37f2bf4185b5 (Harshad Shirwadkar         2020-09-18 17:54:45 -0700
1383) int jbd2_fc_init(journal_t *journal, int num_fc_blks)

11a6ce6a4efc jbd2: add fast commit machinery
96df8fb629b2 ext4: main fast-commit commit path
d37f2bf4185b ext4 / jbd2: add fast commit initialization

Regards,
- Sedat -
