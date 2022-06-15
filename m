Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A182854BEF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiFOA4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 20:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbiFOA4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:56:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEED24D610
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 17:56:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 19so11146649iou.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKyg93cuOsjgX3SRfMau9CFkIFtGcca71X1GBGA/twA=;
        b=MQ6LtxZjQfWtQHpWV47vomiQdfj6L27c0TRvC+C0M3zjA6uTx0gi+PucQ1P8g5G2lR
         9s4oKj6dTne6zg91Xlovn8GYKkSwHJeIPuUHrS1pUHw5ghOP87l97ghNFoSKJ9mSge+C
         bEQwt8e/oxql3neQNhMMlLVpRMWR+eKrArWle1YkBw/jEN5CSb4b5l9idUba5IPyPKb0
         CFV2ZKNqCNOx/k7mUFmt6iaI8e4IO9X74o7exY4nB9pCR4mfCHevtOig8n3yuIL7806C
         CdcyhTYbMciQTpJrRaO0LMoQaewg3RhKTqCq5trGPrCnzKvs17mUU2qQfL/AQFilLOPc
         mU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKyg93cuOsjgX3SRfMau9CFkIFtGcca71X1GBGA/twA=;
        b=K0nu0URvz5mGD6DX49MpBNTQHbznGFVkgEBGWTvEnpkSGex25sqzbQsYY107Amf+yr
         v3iV0CwDDpIgt33lO3hP9a349cmTgzkx3G5tMEhu5Hs7FxEiCF3v+CzDjMvKz4H56d4n
         gR0B8yUCyvEUcfUqqRHrF222jvyZ+PYoznf7tG2ZVM80c30wKAyVTuI4aDpxIyuqxKsk
         pEgZ3x3kvnXlOSoVBG6qyXqqXz8yXoPQcTsgT9R1JHI9gPAgGlPnCHXXlHcK10tSYJnl
         Z5Mq95Bj6zZ7K0IsujpAfJtTlDj3JF9e6or45UkLVrXUkgT1kMlduYHdw75VyXODGHYt
         AdfQ==
X-Gm-Message-State: AOAM531JkElgakvwtVsSzqdPCmjcusqs02XI+rKfK5RsbRsHjO6ij50A
        PK8Njcze0xRQpk99fl4eGaeVMawTmbcZrv7R48sfxg==
X-Google-Smtp-Source: ABdhPJwWsIjLEnNLsaAhJ8A6hUvciYK/wN9so24tP4f0QVi5UXzjajeATgovbKX1vhEiDkTp95uLVXPznXV5ZJFVHys=
X-Received: by 2002:a6b:bac1:0:b0:669:b1fe:58e4 with SMTP id
 k184-20020a6bbac1000000b00669b1fe58e4mr3965351iof.171.1655254591967; Tue, 14
 Jun 2022 17:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com> <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
 <Yqe6R+XSH+nFc8se@xz-m1.local> <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
 <C1C5939A-B7D2-49E7-B18B-EE7FEFE9C924@vmware.com>
In-Reply-To: <C1C5939A-B7D2-49E7-B18B-EE7FEFE9C924@vmware.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 14 Jun 2022 17:55:55 -0700
Message-ID: <CAJHvVche7ZKOpO=8PY2frtJ5nHyzo=Yt+qT1OmYg8ZOUujkPfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 5:10 PM Nadav Amit <namit@vmware.com> wrote:
>
> On Jun 13, 2022, at 3:38 PM, Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > On Mon, Jun 13, 2022 at 3:29 PM Peter Xu <peterx@redhat.com> wrote:
> >> On Mon, Jun 13, 2022 at 02:55:40PM -0700, Andrew Morton wrote:
> >>> On Wed,  1 Jun 2022 14:09:47 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> >>>
> >>>> To achieve this, add a /dev/userfaultfd misc device. This device
> >>>> provides an alternative to the userfaultfd(2) syscall for the creation
> >>>> of new userfaultfds. The idea is, any userfaultfds created this way will
> >>>> be able to handle kernel faults, without the caller having any special
> >>>> capabilities. Access to this mechanism is instead restricted using e.g.
> >>>> standard filesystem permissions.
> >>>
> >>> The use of a /dev node isn't pretty.  Why can't this be done by
> >>> tweaking sys_userfaultfd() or by adding a sys_userfaultfd2()?
> >
> > I think for any approach involving syscalls, we need to be able to
> > control access to who can call a syscall. Maybe there's another way
> > I'm not aware of, but I think today the only mechanism to do this is
> > capabilities. I proposed adding a CAP_USERFAULTFD for this purpose,
> > but that approach was rejected [1]. So, I'm not sure of another way
> > besides using a device node.
> >
> > One thing that could potentially make this cleaner is, as one LWN
> > commenter pointed out, we could have open() on /dev/userfaultfd just
> > return a new userfaultfd directly, instead of this multi-step process
> > of open /dev/userfaultfd, NEW ioctl, then you get a userfaultfd. When
> > I wrote this originally it wasn't clear to me how to get that to
> > happen - open() doesn't directly return the result of our custom open
> > function pointer, as far as I can tell - but it could be investigated.
>
> If this direction is pursued, I think that it would be better to set it as
> /proc/[pid]/userfaultfd, which would allow remote monitors (processes) to
> hook into userfaultfd of remote processes. I have a patch for that which
> extends userfaultfd syscall, but /proc/[pid]/userfaultfd may be cleaner.

Hmm, one thing I'm unsure about -

If a process is able to control another process' memory like this,
then this seems like exactly what CAP_SYS_PTRACE is intended to deal
with, right? So I'm not sure this case is directly related to the one
I'm trying to address.

This also seems distinct to me versus the existing way you'd do this,
which is open a userfaultfd and register a shared memory region, and
then fork(). Now you can control your child's memory with userfaultfd.
But, attaching to some other, previously-unrelated process with
/proc/[pid]/userfaultfd seems like a clear case for CAP_SYS_PTRACE.

>
