Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1C2C18AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbgKWWnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 17:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbgKWWnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:43:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990AC061A4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 14:43:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mc24so4554364ejb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 14:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFMysbUvILtvyZ1ruMl43SlEWruGMGrEuiKh8Nwg4BY=;
        b=g1pCD8WXZAYH+/bCJyVT5mTCDV7Z/z7bOY1/rcdOo75KUvpGWVgoZ8g22QDGwY3QwC
         w1qVDaZn7AyQhP+pIfTHx2F3NhFnU5bHKGhHbJyKWql5hQRnjse5PujiVZBBhT+9vAxJ
         gdtD6tOogLcfv69pgn3LeS881NSRcP4v+bcInTa4kH77pJ8/mNnLbubYDvCNX+XNtvq5
         KygZiv82QdVVzPokO5tVlQeM0WibzUq6oafCt/TLU2nk0sqC3kQ8XEx7Jujbj98EenZj
         F8TeKoK/aQ3awHizSHLPNkhD6Fmws1yRDshQ41gxQjyotiAeTVLZO2cYYWX9O37fWmcG
         igQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFMysbUvILtvyZ1ruMl43SlEWruGMGrEuiKh8Nwg4BY=;
        b=MUCw+OAboBJJQGu40UdixxFbZEfLhilvj8YlqCOnWnf8sXDnfYDLcnplXfDUq3aISp
         j94xrffB8bMApViCvhjYwaw3/CHdwaa7smmKovA7R76uMY5qLH3tzfs5sBFdonIZipql
         mYz7hW/Prn5MCJroJWMtXokdeFA3MV1C3iMZR8DoSEUKYhZjBYViW3VNnthlc3ebYuLF
         1tmPUt+UDUln2YRu4l8LK9VxvSnQlj9YqM1PhB0wkLBSUdw4eZfz+J90IIxETkBzLIgp
         HKe2qztDRU237XhenNDEft9mXvNIOTZn7Od7Jcd9/8zQ12GwTugZL9u62ogUsN2HyK6R
         UfIA==
X-Gm-Message-State: AOAM531LqqC9yLNipUGLxN54hHnuz8Aw4v4ihBASWHUFS2X1ZLVKCMol
        B75B3mCoUR/0GGVSrXEw57AkLX5imtgK+zr1H14L
X-Google-Smtp-Source: ABdhPJyou24cx0HMQT9xpW2L2DZvDO9hsan2ip4JU49y9UllQY2ZoaOAQC2uis0G2V7t0HpAmgynMlX6E37HmfH++5g=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr1632418ejc.178.1606171385064;
 Mon, 23 Nov 2020 14:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
 <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
 <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
 <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com> <CA+EESO6qfCCZ5K1sWWrcBm6VM0w3LWkiOfAh3dhM-eVigVYYWA@mail.gmail.com>
In-Reply-To: <CA+EESO6qfCCZ5K1sWWrcBm6VM0w3LWkiOfAh3dhM-eVigVYYWA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Nov 2020 17:42:53 -0500
Message-ID: <CAHC9VhTtLj9QPqEqO5hHPDmMnWzUaD-2PwGw=bQ=SBxvV78Sxg@mail.gmail.com>
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

On Mon, Nov 23, 2020 at 2:21 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Sun, Nov 22, 2020 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Nov 18, 2020 at 5:39 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > I have created a cuttlefish build and have tested with the attached
> > > userfaultfd program:
> >
> > Thanks, that's a good place to start, a few comments:
> >
> > - While we support Android as a distribution, it isn't a platform that
> > we common use for development and testing.  At the moment, Fedora is
> > probably your best choice for that.
> >
> I tried setting up a debian/ubuntu system for testing using the
> instructions on the selinux-testsuite page, but the system kept
> freezing after 'setenforce 1'. I'll try with fedora now.

I would expect you to have much better luck with Fedora.

> > - Your test program should be written in vanilla C for the
> > selinux-testsuite.  Looking at the userfaultfdSimple.cc code that
> > should be a trivial conversion.
> >
> > - I think you have a good start on a test for the selinux-testsuite,
> > please take a look at the test suite and submit a patch against that
> > repo.  Ondrej (CC'd) currently maintains the test suite and he may
> > have some additional thoughts.
> >
> > * https://github.com/SELinuxProject/selinux-testsuite
>
> Thanks a lot for the inputs. I'll start working on this.

Great, let us know if you hit any problems.  I think we would all like
to see this upstream :)

-- 
paul moore
www.paul-moore.com
