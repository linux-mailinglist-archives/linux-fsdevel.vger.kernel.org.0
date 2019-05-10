Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800201A409
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfEJUlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 16:41:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46202 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfEJUlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 16:41:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so6752211edb.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ganxwCo69+MjYlGVZok+ayq0HYAVtlcSkabz2Ai2RCk=;
        b=PX2FYdIQmLYOG9DttH4kv0cprRCB1CVkzY1eQ8hgHHfnNYlZVbH8CkFKMApWWjI0HT
         j5gDUyr+dgeMEfMtJZKOl6Avf3+OFUhwoaDxYrbETZB0PXHFBlolbkxshIsiYJkw3xz0
         ExmEM4ZdWgWVb98u3zlAzqBG13c4bV1FqysXsiqDc5fSBrP1nVEiCOuom7lIrU27F3+T
         PtJXUG+7sxBGLlZaplytARycQIqD1n7MGS0a1TxzoFrFhJ+W+rN/vxN8sj3a1jAx/DoJ
         aQAW8vAu2sRduqDDMMN5IWslifXd7edG+2owQD24IU5u1FkoJ80+KhpJxTdUd+90l+Ne
         ihmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ganxwCo69+MjYlGVZok+ayq0HYAVtlcSkabz2Ai2RCk=;
        b=adKYisCGeXw8+E8qTDfc6508Kf9omgT/gmCIbFyDtHX8DwsNEfKxFXWyb7BvWAmGCu
         H+9FA98lR66PH8rSMDF+PLsrko23unEggxFo6M8LezdqKmbhDe8OONk8KzlU0BZQ5uyS
         vrXHT6S8YTcOYrNjQZvLmTqlUojtTttASmK2SYEKMkph1Pkzo1UEPUBd8Ngywp3hvveZ
         fus6I7qDMF5sct4WFi+BZeKhribYc9QMlDVQXwpWtZm86WfpyThe9usZ2LTo9P8L6M5S
         Zv+lST16wCaZZEc4n3i9tUTXywlMQDprhZGaluZdk4UnHitVknXxuKrQ9dqUnhPJP8EE
         xJXA==
X-Gm-Message-State: APjAAAV2Lflyvda3hautE6P0KOF9zQ5ErjBPJP6bJXH3fTvedsm112Xu
        Jq9y6KsRlQ05pdilHB4/nsoyiQ==
X-Google-Smtp-Source: APXvYqwrQpOQMxFo7pL64woeiMd6ENZAMPxG/EeBd9+8Jln82x4vS7EDIT7ItJ2WpRWhrlGsKx5V/Q==
X-Received: by 2002:a50:9968:: with SMTP id l37mr13505242edb.143.1557520909008;
        Fri, 10 May 2019 13:41:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id q4sm878740ejb.65.2019.05.10.13.41.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 13:41:47 -0700 (PDT)
Date:   Fri, 10 May 2019 22:41:41 +0200
From:   Jann Horn <jannh@google.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190510204141.GB253532@google.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506191735.nmzf7kwfh7b6e2tf@yavin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 05:17:35AM +1000, Aleksa Sarai wrote:
> On 2019-05-06, Jann Horn <jannh@google.com> wrote:
> > In my opinion, CVE-2019-5736 points out two different problems:
> >
> > The big problem: The __ptrace_may_access() logic has a special-case
> > short-circuit for "introspection" that you can't opt out of; this
> > makes it possible to open things in procfs that are related to the
> > current process even if the credentials of the process wouldn't permit
> > accessing another process like it. I think the proper fix to deal with
> > this would be to add a prctl() flag for "set whether introspection is
> > allowed for this process", and if userspace has manually un-set that
> > flag, any introspection special-case logic would be skipped.
> 
> We could do PR_SET_DUMPABLE=3 for this, I guess?

Hmm... I'd make it a new prctl() command, since introspection is
somewhat orthogonal to dumpability. Also, dumpability is per-mm, and I
think the introspection flag should be per-thread.

> > An additional problem: /proc/*/exe can be used to open a file for
> > writing; I think it may have been Andy Lutomirski who pointed out some
> > time ago that it would be nice if you couldn't use /proc/*/fd/* to
> > re-open files with more privileges, which is sort of the same thing.
> 
> This is something I'm currently working on a series for, which would
> boil down to some restrictions on how re-opening of file descriptors
> works through procfs.

Ah, nice!

> However, execveat() of a procfs magiclink is a bit hard to block --
> there is no way for userspace to to represent a file being "open for
> execute" so they are all "open for execute" by default and blocking it
> outright seems a bit extreme (though I actually hope to eventually add
> the ability to mark an O_PATH as "open for X" to resolveat(2) -- hence
> why I've reserved some bits).

(For what it's worth, I'm mostly concerned about read vs write, not
really about execute, since execute really is just another form of
reading in my opinion.)

> (Thinking more about it, there is an argument that I should include the
> above patch into this series so that we can block re-opening of fds
> opened through resolveat(2) without explicit flags from the outset.)

