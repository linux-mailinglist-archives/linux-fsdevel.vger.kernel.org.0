Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59E92C365D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 02:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKYBwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 20:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgKYBw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:52:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF8C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 17:52:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bo9so699221ejb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 17:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrgS6CV4x3UltwJI2DnW1OzuHdog2ZsVn68ZxLeKHHU=;
        b=S4w78aWhQBYjTBwAY7d5gbt+PtP/y46iHMJppknBZWw58tkWSFAI6xaAPgM/6eBm9O
         N4Xgn+YMtJYIAiCQkH6TQhZnGm5nON8Q+WvOEzqQKP+/YTQMqy1oKULToO0pgY03LNg6
         n7HtEFeHwJ0+va8ynSQsHpx9s1PHD17ALbIMF5KnA1ikcX4wAG6LMrfW2jZEL93DAy3e
         f44ViUPd8G7cGzVwQVZ9YI6Shv6UwBJpOBoJkGle9al4+Llkc0vcwf4irsoCEgzeV6Gb
         /WtWVQk4b97Ne3qcoZB2s7tOyS8fvcV4vlEqJSwk4LusdWDygADzSnIVkAEGjpy68tvA
         kbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrgS6CV4x3UltwJI2DnW1OzuHdog2ZsVn68ZxLeKHHU=;
        b=oKrEQLTjgQSWaSS+qqZY/uO01SpxF//T/+ViPMMvusHYbGlQKv4DE+g/WYMBlUjE9R
         uPvMYZ7f3CF8AdStcrIkP2JbzqjFr+HDh0vwlhs21DmlJHh3geTfeJqT+mylcInffwPU
         ZppH/ckAnDnaXYzVqgaSMqOWXycl4HF2oq3JloVlZLv3SOY4isKtKyjb7OTDC20JY+9y
         tNDcOGseOtFEr1C85f7djG3B3QXbIERKsJP0mXCOrjakiBkN9o8VZuLfTe98hVMB6lJN
         ZyVIWz5zZJy4y7E4SD1MawzcPieJwArGEze3cUnR0ByesdCAny/xTsb1Nnb7wh5YKwIs
         IuKA==
X-Gm-Message-State: AOAM530siGUz38TL9zoCmq1kEMOQ6smMe3EwBribpo19FgXwwkGieobo
        YfCCfThhrDd91FVINaoAd49R+E0jrnYZBHzEz08I
X-Google-Smtp-Source: ABdhPJy5QqTI/AmFehlIzbR5PA4citzw5aGePHpuJGKPI7XqWUoaYAYA5Mj9jqBoqrVHRoi3kpCcjDOXx5MKAZts+mc=
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr1130856ejz.488.1606269147585;
 Tue, 24 Nov 2020 17:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
 <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
 <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
 <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com>
 <CA+EESO6qfCCZ5K1sWWrcBm6VM0w3LWkiOfAh3dhM-eVigVYYWA@mail.gmail.com>
 <CAHC9VhTtLj9QPqEqO5hHPDmMnWzUaD-2PwGw=bQ=SBxvV78Sxg@mail.gmail.com> <CA+EESO465UY7v5W4k6cqWHTDq6e6pb_NBnZZRMjawHPvfEOOLw@mail.gmail.com>
In-Reply-To: <CA+EESO465UY7v5W4k6cqWHTDq6e6pb_NBnZZRMjawHPvfEOOLw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Nov 2020 20:52:15 -0500
Message-ID: <CAHC9VhRRuc+Vxj5waVkVaJ5DN6XpTZnU8eub_Z0BFUMa5yJz0g@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
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

On Tue, Nov 24, 2020 at 3:44 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Mon, Nov 23, 2020 at 2:43 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 23, 2020 at 2:21 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > On Sun, Nov 22, 2020 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Nov 18, 2020 at 5:39 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > > I have created a cuttlefish build and have tested with the attached
> > > > > userfaultfd program:
> > > >
> > > > Thanks, that's a good place to start, a few comments:
> > > >
> > > > - While we support Android as a distribution, it isn't a platform that
> > > > we common use for development and testing.  At the moment, Fedora is
> > > > probably your best choice for that.
> > > >
> > > I tried setting up a debian/ubuntu system for testing using the
> > > instructions on the selinux-testsuite page, but the system kept
> > > freezing after 'setenforce 1'. I'll try with fedora now.
> >
> > I would expect you to have much better luck with Fedora.
>
> Yes. It worked!

Excellent :)

> > > > - Your test program should be written in vanilla C for the
> > > > selinux-testsuite.  Looking at the userfaultfdSimple.cc code that
> > > > should be a trivial conversion.
> > > >
> > > > - I think you have a good start on a test for the selinux-testsuite,
> > > > please take a look at the test suite and submit a patch against that
> > > > repo.  Ondrej (CC'd) currently maintains the test suite and he may
> > > > have some additional thoughts.
> > > >
> > > > * https://github.com/SELinuxProject/selinux-testsuite
> > >
> > > Thanks a lot for the inputs. I'll start working on this.
> >
> > Great, let us know if you hit any problems.  I think we would all like
> > to see this upstream :)
>
> I have the patch ready. I couldn't find any instructions on the
> testsuite site about patch submission. Can you please tell me how to
> proceed.

You can post it to the SELinux mailing list, much like you would do a
SELinux kernel patch.  I'll take a look and I'll make sure Ondrej
looks at it too.

Thanks!

-- 
paul moore
www.paul-moore.com
