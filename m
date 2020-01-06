Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42C31314FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 16:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgAFPkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 10:40:33 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34080 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFPkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:40:33 -0500
Received: by mail-il1-f193.google.com with SMTP id s15so42966088iln.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 07:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jPdFglUw3IkyHnar3bEzwN6KcXNrUHeJ5ocDz8k+Ns=;
        b=ANa3WKVrCfqkxeHnc0AbQErasFyAzTz5ZM+3QdPFyaLkeGA5Z30LGg4any9CpTj6mu
         31OBdAdLixmK+HsrPgDlwl2OGJOYz14OVEm4sDM6YIUgC4lFPLKPeMAme93fMQbnb5tS
         zywk/5Mg/V4PbWdii4Fyn0Twn9NobQ7fQlell+Duua2n47X4sI7g3GfYY8qXp++JQnxr
         7k4NiAD25RN6NCdqRvcGgctqsoTxazu5Qgk3s9GbjCzs6lpizLIotUdusmS+ttybuldX
         yeo7vQ02GySAkwXLXltCsN3+ZFp36Qn3eRDkAjJOgmAq0oxzTzD2Ndo1fBGaTJzRMRXF
         mqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jPdFglUw3IkyHnar3bEzwN6KcXNrUHeJ5ocDz8k+Ns=;
        b=OAnS4wYlry5yyrbY9Wh2xiC7txcR6iuR00sMYiLBtonvMXPTcPxSwBHClcpaxxYDAe
         UivKo4ZCe5SqPyfs1wCbAMwjjvtEZiF98/QL4C+T6l5NeX7TkjeLe/zxxN3FdRKFEFen
         6MnxNaXrwlW8jvOyNIyCEm7e5rJpNqI79EgV+NdgOpYZwQaMc5KoMwEadQdX/N8Bx3IA
         0a8BIGne8ccd73gu25KV5WVAiCMdZL5eo3sJoLGOBmHiYR9S706gfh/cF1dCuxK/WnEy
         GMCnef4GV4q/LJpRl4D+CvXdM0v445U18YfKQSgexA2zQzvkASIFmHex5XBNJhGqbGQF
         7mWw==
X-Gm-Message-State: APjAAAUXVGkvlIm7qahM4pIJ9OIcR1hQZ9V1Ln3QqM0QbDl9ev42J7YB
        9j4BT/CCOj5fGpBPuqVGJDH61TZeo/Dcfegm4F8=
X-Google-Smtp-Source: APXvYqzzSwwPct/ieRyukhFiLI+q+GV4o9BHUHarYCygCrstDBCeCGzHXCPuM2NVKUEPzzxHrnjoFLYRHaxL0Lio1Vs=
X-Received: by 2002:a92:1087:: with SMTP id 7mr55800540ilq.275.1578325232600;
 Mon, 06 Jan 2020 07:40:32 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
In-Reply-To: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jan 2020 17:40:20 +0200
Message-ID: <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
Subject: Re: Questions about filesystems from SQLite author presentation
To:     Sitsofe Wheeler <sitsofe@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, drh@sqlite.org,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 6, 2020 at 9:26 AM Sitsofe Wheeler <sitsofe@gmail.com> wrote:
>
> At Linux Plumbers 2019 Dr Richard Hipp presented a talk about SQLite
> (https://youtu.be/-oP2BOsMpdo?t=5525 ). One of the slides was titled
> "Things to discuss"
> (https://sqlite.org/lpc2019/doc/trunk/slides/sqlite-intro.html/#6 )
> and had a few questions:
>
[...]
>
> However, there were even more questions in the briefing paper
> (https://sqlite.org/lpc2019/doc/trunk/briefing.md and search for '?')
> that couldn't be asked due to limited time. Does anyone know the
> answer to the extended questions and whether the the above is right
> deduction for the questions that were asked?
>

As Jan said, there is a difference between the answer to "what is the
current behavior" and "what are filesystem developers willing to commit
as behavior that will remain the same in the future", but I will try to provide
some answers to your questions.

> If a power loss occurs at about the same time that a file is being extended
> with new data, will the file be guaranteed to contain valid data after reboot,
> or might the extended area of the file contain all zeros or all ones or
> arbitrary content? In other words, is the file data always committed to disk
> ahead of the file size?

While that statement would generally be true (ever since ext3
journal=ordered...),
you have no such guaranty. Getting such a guaranty would require a new API
like O_ATOMIC.

> If a power loss occurs at about the same time as a file truncation, is it possible
> that the truncated area of the file will contain arbitrary data after reboot?
> In other words, is the file size guaranteed to be committed to disk before the
> data sections are released?

That statement is generally true for filesystem that claim to be crash
consistent.
And the filesystems that do not claim to be crash consistent provide
no guaranties
at all w.r.t power loss, so it's not worth talking about them in this context.

> If a write occurs on one or two bytes of a file at about the same time as a power
> loss, are other bytes of the file guaranteed to be unchanged after reboot?
> Or might some other bytes within the same sector have been modified as well?

I don't see how other bytes could change in this scenario, but I don't
know if the
hardware provides this guarantee. Maybe someone else knows the answer.

> When you create a new file, write to it, and fdatasync() successfully, is it also
> necessary to open and fsync() the containing directory in or to ensure that the
> file will still be there following reboot from a power loss?

There is no guarantee that file will be there after power loss without
fsync() of
containing directory. In practice, with current upstream xfs and ext4
file will be
there after reboot, because at the moment, fdatasync() of a new file implies
journal flush, which also includes the file creation.
With current upstream btrfs file may not be there after reboot.

I tried to promote a new API to provide a weaker guarantee
in LSF/MM 2019 [1][2]. The idea is an API used by an application that does not
need durability - it doesn't care if new file is there or not after
power loss, but if
the file is there, its data of the file should be valid.

I do not know if sqlite could potentially use such an API. If there is
a potential
use, I did not find it. Specifically, the proposed API DOES NOT have the
semantics of fbarrier() mentioned in the sqlite briefing doc.

[See more about fdatasync() at the bottom of my reply...]

> Has a file been unlinked or renamed since it was opened?
> (SQLite accomplishes this now by remembering the device and inode numbers
> obtained from fstat() and comparing them against the results of subsequent stat()
> calls against the original filename. Is there a more efficient way to do this?)

name_to_handle_at() is a better way to make sure that file with same name
wasn't replaced by another, because inode numbers get frequently recycled
in create/delete workloads.

> Has a particular file been created since the most recent reboot?

statx(2) exposes "birth time" (STATX_BTIME) which some filesystems
support depending on how they were formatted (e.g. ext4 inode size).
In any case, statx reports if btime info is available or not.

> Is it possible (or helpful) to tell the filesystem that the content of a particular file
> does not need to survive reboot?

Not that I know of.

> Is it possible (or helpful) to tell the filesystem that a particular file can be
> unlinked upon reboot?

Not that I know of.

> Is it possible (or helpful) to tell the filesystem about parts of the database
> file that are currently unused and that the filesystem can zero-out without
> harming the database?

As Dave already replied, FALLOC_FL_ZERO_RANGE.

[...more about fdatasync()]

One thing that I think is worth mentioning, I discussed it on LSF [3],
is the cost
of requiring applications developers to use the most strict API (i.e. fsync()),
because filesystem developers don't want to commit to new APIs -

When the same filesystem hosts two different workloads:
1. sqlite with many frequent small transaction commits
2. Creating many small files with no need for durability (e.g. untar)

Both workloads may in practice hurt each other on many filesystems.
The frequent fdatasync() calls from sqlite will sometimes cause journal
flushes, which flush more than sqlite needs, take more time to commit
and slows down the other metadata intensive workload.

Ext4 is trying to address this issue without extending the API [4].
XFS was a bit bettter than ext4 with avoiding unneeded journal flushes,
but those could still take place. Btrfs is generally better in this regard
(fdatasync() effects are quite isolated to the file).

So how can sqlite developers help to improve the situation?
If you ask me, I would suggest to provide benchmark results from
mixed workloads, like the one I described above.

If you can demonstrate the negative effects that frequent fdatasync()
calls on a single sqlite db have on the system performance as a whole,
then there is surely something that could be done to fix the problem.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/
[3] https://lwn.net/Articles/788938/
[4] https://lore.kernel.org/linux-ext4/20191001074101.256523-1-harshadshirwadkar@gmail.com/
