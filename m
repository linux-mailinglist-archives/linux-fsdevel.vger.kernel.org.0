Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF65117612B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCBRhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 12:37:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42001 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgCBRhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:37:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so36110otd.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZAKVb1y956pqysbIHLXaqWd9Ys3FR5AQaat5ayTW2U=;
        b=tvXmHHsdwC2ZHXs+RdxnZLvNNTOIQtXQo8+c4NIG9SwSrx3X2qfM4PFM54/x5xFwJp
         cfFlhvQc0zBKaRaTBUYJdf4weoUwAZE/jWkqSkDz7QQA2gBwflEvwBaARHqOO3jfoZWe
         H3HzZ3d8YIZfEn42qsIaSNuiAQiMlVeuHwsGHfdJ91w4d3C9kQ6guQceh2DHy3g/ptV8
         GD9luNMoxl/wmt0z1ZAyx7TT3Evb8ThhnGs8bzJ/crBzhPs02h3kMtaJVJfzx4+AOqh4
         0/3m1NcszFU4y0wqzn15zw+AD7m87pgt2c5Z3r/ZdcO5TYFDuZe7cntLaqgpzosYUE3y
         +q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZAKVb1y956pqysbIHLXaqWd9Ys3FR5AQaat5ayTW2U=;
        b=cYNJkCFrJy6o/lWNYNFDbrD/4G0j5aksYHe9AmaQ4IQAiZx0HJZ0dgdJXo7DGiaGHm
         hD46JVvv1KyMocJ3bbsujpa33SMAogE7bvR1EN60fCpL+yXOyJShe+CgOgqDpfgv/iZQ
         vcrrnNixVUsnmnii0xoc7lBZTcSN8k6m6nW+iMAi5+go6EgtVwPSimU3w3CQ2f2AseoI
         0zahNoOVWJ28i0750EIUgGTeVmEyjX5+sz6b02u+rQLW1VXs9IVeuiVAhG3IZE64tyxj
         nV4FlwgGxvsYUg/Nz9otmv4ZFp8oMiZezbnkAQi1M0jwBt028zj6Aub3eJ1jcSFd2vXw
         wD0g==
X-Gm-Message-State: ANhLgQ2BcEl41ZvRQGOEL8J/y4VXCliqdrHssEDpmpxbIAVomlgk7FoN
        OL+8XFdiKGHX2ctfspi+O/ywXA0kJft+AKGrNHQpbQ==
X-Google-Smtp-Source: ADFU+vtHoXXslAIJ9PskP6M3hEdJM3ncRGi/PdHfdHEyUI3a6T8IzVZn8NhUDRURCHCZlf8D86bKwYn9TcyfdRsVwhY=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr256675oti.32.1583170673984;
 Mon, 02 Mar 2020 09:37:53 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com>
 <20200301185244.zkofjus6xtgkx4s3@wittgenstein> <CAG48ez3mnYc84iFCA25-rbJdSBi3jh9hkp569XZTbFc_9WYbZw@mail.gmail.com>
 <AM6PR03MB5170EB4427BF5C67EE98FF09E4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87a74zmfc9.fsf@x220.int.ebiederm.org> <AM6PR03MB517071DEF894C3D72D2B4AE2E4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87k142lpfz.fsf@x220.int.ebiederm.org> <AM6PR03MB51704206634C009500A8080DE4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <875zfmloir.fsf@x220.int.ebiederm.org> <CAG48ez0iXMD0mduKWHG6GZZoR+s2jXy776zwiRd+tFADCEiBEw@mail.gmail.com>
 <AM6PR03MB5170BD130F15CE1909F59B55E4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170BD130F15CE1909F59B55E4E70@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Mar 2020 18:37:27 +0100
Message-ID: <CAG48ez1jj_J3PtENWvu8piFGsik6RvuyD38ie48TYr2k1Rbf3A@mail.gmail.com>
Subject: Re: [PATCHv2] exec: Fix a deadlock in ptrace
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 2, 2020 at 6:01 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
> On 3/2/20 5:43 PM, Jann Horn wrote:
> > On Mon, Mar 2, 2020 at 5:19 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
> >>
> >>> On 3/2/20 4:57 PM, Eric W. Biederman wrote:
> >>>> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
> >>>>
> >>>>>
> >>>>> I tried this with s/EACCESS/EACCES/.
> >>>>>
> >>>>> The test case in this patch is not fixed, but strace does not freeze,
> >>>>> at least with my setup where it did freeze repeatable.
> >>>>
> >>>> Thanks, That is what I was aiming at.
> >>>>
> >>>> So we have one method we can pursue to fix this in practice.
> >>>>
> >>>>> That is
> >>>>> obviously because it bypasses the cred_guard_mutex.  But all other
> >>>>> process that access this file still freeze, and cannot be
> >>>>> interrupted except with kill -9.
> >>>>>
> >>>>> However that smells like a denial of service, that this
> >>>>> simple test case which can be executed by guest, creates a /proc/$pid/mem
> >>>>> that freezes any process, even root, when it looks at it.
> >>>>> I mean: "ln -s README /proc/$pid/mem" would be a nice bomb.
> >>>>
> >>>> Yes.  Your the test case in your patch a variant of the original
> >>>> problem.
> >>>>
> >>>>
> >>>> I have been staring at this trying to understand the fundamentals of the
> >>>> original deeper problem.
> >>>>
> >>>> The current scope of cred_guard_mutex in exec is because being ptraced
> >>>> causes suid exec to act differently.  So we need to know early if we are
> >>>> ptraced.
> >>>>
> >>>
> >>> It has a second use, that it prevents two threads entering execve,
> >>> which would probably result in disaster.
> >>
> >> Exec can fail with an error code up until de_thread.  de_thread causes
> >> exec to fail with the error code -EAGAIN for the second thread to get
> >> into de_thread.
> >>
> >> So no.  The cred_guard_mutex is not needed for that case at all.
> >>
> >>>> If that case did not exist we could reduce the scope of the
> >>>> cred_guard_mutex in exec to where your patch puts the cred_change_mutex.
> >>>>
> >>>> I am starting to think reworking how we deal with ptrace and exec is the
> >>>> way to solve this problem.
> >>
> >>
> >> I am 99% convinced that the fix is to move cred_guard_mutex down.
> >
> > "move cred_guard_mutex down" as in "take it once we've already set up
> > the new process, past the point of no return"?
> >
> >> Then right after we take cred_guard_mutex do:
> >>         if (ptraced) {
> >>                 use_original_creds();
> >>         }
> >>
> >> And call it a day.
> >>
> >> The details suck but I am 99% certain that would solve everyones
> >> problems, and not be too bad to audit either.
> >
> > Ah, hmm, that sounds like it'll work fine at least when no LSMs are involved.
> >
> > SELinux normally doesn't do the execution-degrading thing, it just
> > blocks the execution completely - see their selinux_bprm_set_creds()
> > hook. So I think they'd still need to set some state on the task that
> > says "we're currently in the middle of an execution where the target
> > task will run in context X", and then check against that in the
> > ptrace_may_access hook. Or I suppose they could just kill the task
> > near the end of execve, although that'd be kinda ugly.
> >
>
> We have current->in_execve for that, right?
> I think when the cred_guard_mutex is taken only in the critical section,
> then PTRACE_ATTACH could take the guard_mutex, and look at current->in_execve,
> and just return -EAGAIN in that case, right, everybody happy :)

It's probably going to mean that things like strace will just randomly
fail to attach to processes if they happen to be in the middle of
execve... but I guess that works?
