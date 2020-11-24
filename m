Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847E92C321E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbgKXUoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 15:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbgKXUon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:44:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3DC061A4F
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 12:44:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t9so198339edq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 12:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/HM/8rFP5cAjqFnUXV5a+cyTGV1vdatCTE/hESO0uw=;
        b=U7BMAGu6Hb0hKnA/oSKvqajGoBWD0yncJV3rhU6KciqAw4fR6XDauq4KVuQDRvOaer
         P2lwNuAHrhxxVpgG6cjkfq6v70V4fwxSGaqHeHmFdAA1ED1uXEi7XEkplDoAYHnh1i7t
         rI8Gkx51MM8Ud4I/HO+LRhiIcFWnJBIWoXMJ/8jwSLXWyr/g7YkOrM4p0QiKS2bkquxt
         hkiqq9TGdbvwnVZg1znTFFF8rVLohdN4M1tv35av1QDiQxkdFSj6vgcgupUE6cMhxxI+
         9segr/KIrj5dzjboN76fh2uBXToaniri7zVHFaOs1shKitGqxPvNnu1UQKQJJkZbs8up
         2upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/HM/8rFP5cAjqFnUXV5a+cyTGV1vdatCTE/hESO0uw=;
        b=tjC2IOMJ6vh7RxTRMIalTkH6EFUkvW8HIdD4blPpDHupI7UHV70TE5ZjEPit7itOOP
         Yf0R4aRF9FT5YoLlmgegeqM9HcbqINwS+I9nGzvyEVRZ/ZkCeJSQJll7eu4eBLWpjwNi
         I6Yso0sEIx4VT6irjDqTngQ0mRIsWjs7bANGn7X9oArsohPSnlQL54oDC0L/OWH6yZAg
         duw9EMSaKXU9hazPGKPVBLZ4IoqNoyIpgb0hIJH1Sz5/OpAwWYQC73p7HqpaNDRobI5b
         ALZERI/tlV60TVscPKVH2hQOwFHYf4IjaJw0VqObo/k3mMZjvbbsBJbaQsw1Poy9ZHuC
         /Taw==
X-Gm-Message-State: AOAM532QJp6MeLYHCdwj18+ycYle+NH4PhXjSHrfDqAbpl2d+F5T4/1b
        CyrrtD2jBoycd032HAUbtHE7Fq5ZxVd3jf6WI8RJhA==
X-Google-Smtp-Source: ABdhPJwZTfPGl9sCT1BVU2GvADqbE6pDiG1Xc1mtvTA/GsapyKzaYnyIr5d4QUAp0ZBQ4ukQby3tNlpzSAg6JpSsySA=
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr311916edb.245.1606250681588;
 Tue, 24 Nov 2020 12:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
 <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
 <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
 <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com>
 <CA+EESO6qfCCZ5K1sWWrcBm6VM0w3LWkiOfAh3dhM-eVigVYYWA@mail.gmail.com> <CAHC9VhTtLj9QPqEqO5hHPDmMnWzUaD-2PwGw=bQ=SBxvV78Sxg@mail.gmail.com>
In-Reply-To: <CAHC9VhTtLj9QPqEqO5hHPDmMnWzUaD-2PwGw=bQ=SBxvV78Sxg@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 24 Nov 2020 12:44:30 -0800
Message-ID: <CA+EESO465UY7v5W4k6cqWHTDq6e6pb_NBnZZRMjawHPvfEOOLw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 2:43 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Nov 23, 2020 at 2:21 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Sun, Nov 22, 2020 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Nov 18, 2020 at 5:39 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > I have created a cuttlefish build and have tested with the attached
> > > > userfaultfd program:
> > >
> > > Thanks, that's a good place to start, a few comments:
> > >
> > > - While we support Android as a distribution, it isn't a platform that
> > > we common use for development and testing.  At the moment, Fedora is
> > > probably your best choice for that.
> > >
> > I tried setting up a debian/ubuntu system for testing using the
> > instructions on the selinux-testsuite page, but the system kept
> > freezing after 'setenforce 1'. I'll try with fedora now.
>
> I would expect you to have much better luck with Fedora.

Yes. It worked!
>
> > > - Your test program should be written in vanilla C for the
> > > selinux-testsuite.  Looking at the userfaultfdSimple.cc code that
> > > should be a trivial conversion.
> > >
> > > - I think you have a good start on a test for the selinux-testsuite,
> > > please take a look at the test suite and submit a patch against that
> > > repo.  Ondrej (CC'd) currently maintains the test suite and he may
> > > have some additional thoughts.
> > >
> > > * https://github.com/SELinuxProject/selinux-testsuite
> >
> > Thanks a lot for the inputs. I'll start working on this.
>
> Great, let us know if you hit any problems.  I think we would all like
> to see this upstream :)
>
I have the patch ready. I couldn't find any instructions on the
testsuite site about patch submission. Can you please tell me how to
proceed.

> --
> paul moore
> www.paul-moore.com
