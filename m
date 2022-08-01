Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E57586F55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiHARNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiHARNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:13:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E602980B
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 10:13:49 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p81so8888734iod.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=RMpq00zmLmRyLkH3ymS8AD8nFPc9nuPS5SpA8DGRQjc=;
        b=CzbG8jn3lmpWwZNf2DkfRaHkYPFhpnngD3tqdI3rzFaOFYHZNMm6okjhZb6FbHgpBV
         MvAiCTK6W4xcrO1x5Yjhl019C5+KjcritcRqSFhQaKoMajPDUHQeWFPDkHYMGeRgY8Vu
         Vlq+9AkYHWni1BvEapZhFKQ5KeDvskzMF4zzTqigIUCnuDP933nMxj/APjQzuu+RArVP
         gqfUWjMDhjWL2VnCff9414QnqJgVQzUNvnp9EqGeJ9Iz8m8BDzpuJNlFQ+ROha+Bnafo
         tluUwY6NGaRCfpXGufNKvA0sFeRiZ78FJK3XduIgR/UnkVscDBe9pPntr4MQx346BtAD
         SBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=RMpq00zmLmRyLkH3ymS8AD8nFPc9nuPS5SpA8DGRQjc=;
        b=uUtyxl+7m9vSqwaBMtUlqc6msap+OxJ4zPvxPg+bRX9C4APMSlTQDNQI2ImmbHGKEu
         oXbzbqbyVSjMDvGXnkHa4wvNQuW5pq5ai0MvD1G5zt5dMSYpZ46ii0Uqc+TQeHx7A2GJ
         VVxHwrSztlGO7KSZuHmuOZzoKl/YbNSx8IyhL1s7/FbWGLgBffxv9vJ20dqVccTdRMjV
         2Xr+z8sQoSPD1idM9BkQSJCyodI178ZPf4K51TbpYwion15QHrUJAe/IGYnnzDLSjvL+
         lvtRzO4OfxRb/Z/q2UaFx92izlx21Om93PNwAum1MTVYfAiLyk8HhJoroxiu5GAuzQtf
         k0zg==
X-Gm-Message-State: AJIora+RDxc3HlVkW1YdApBTx/W8IBtqlbra1f2Cfsg0y7QxBsr1rFQr
        2M7NQOV0ZdGhQ39QwYAoYTBRtIgulMO7D6XrCpfMUw==
X-Google-Smtp-Source: AGRyM1us0RojN6/riPQbz3AQEf91WYt9XAWKjIH70t+mubW2Sqp7fsmB2PQ5cQkQI2b+gMYBSBcGhDrF0ZlLMZgjF94=
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id
 q3-20020a0566022f0300b006789c7c97a5mr5833295iow.32.1659374028847; Mon, 01 Aug
 2022 10:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
 <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com> <7EF50BE4-84EA-4D57-B58C-6697F1B74904@vmware.com>
In-Reply-To: <7EF50BE4-84EA-4D57-B58C-6697F1B74904@vmware.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 1 Aug 2022 10:13:12 -0700
Message-ID: <CAJHvVcghaZjgU6YhoGMehQTDU36S-UL5djG+Bym6Uax=VVoX7g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Nadav Amit <namit@vmware.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I finished up some other work and got around to writing a v5 today,
but I ran into a problem with /proc/[pid]/userfaultfd.

Files in /proc/[pid]/* are owned by the user/group which started the
process, and they don't support being chmod'ed.

For the userfaultfd device, I think we want the following semantics:
- For UFFDs created via the device, we want to always allow handling
kernel mode faults
- For security, the device should be owned by root:root by default, so
unprivileged users don't have default access to handle kernel faults
- But, the system administrator should be able to chown/chmod it, to
grant access to handling kernel faults for this process more widely.

It could be made to work like that but I think it would involve at least:

- Special casing userfaultfd in proc_pid_make_inode
- Updating setattr/getattr for /proc/[pid] to meaningfully store and
then retrieve uid/gid different from the task's, again probably
special cased for userfautlfd since we don't want this behavior for
other files

It seems to me such a change might raise eyebrows among procfs folks.
Before I spend the time to write this up, does this seem like
something that would obviously be nack'ed?

On Wed, Jul 20, 2022 at 4:21 PM Nadav Amit <namit@vmware.com> wrote:
>
> On Jul 20, 2022, at 4:04 PM, Axel Rasmussen <axelrasmussen@google.com> wr=
ote:
>
> > =E2=9A=A0 External Email
> >
> > On Wed, Jul 20, 2022 at 3:16 PM Schaufler, Casey
> > <casey.schaufler@intel.com> wrote:
> >>> -----Original Message-----
> >>> From: Axel Rasmussen <axelrasmussen@google.com>
> >>> Sent: Tuesday, July 19, 2022 12:56 PM
> >>> To: Alexander Viro <viro@zeniv.linux.org.uk>; Andrew Morton
> >>> <akpm@linux-foundation.org>; Dave Hansen
> >>> <dave.hansen@linux.intel.com>; Dmitry V . Levin <ldv@altlinux.org>; G=
leb
> >>> Fotengauer-Malinovskiy <glebfm@altlinux.org>; Hugh Dickins
> >>> <hughd@google.com>; Jan Kara <jack@suse.cz>; Jonathan Corbet
> >>> <corbet@lwn.net>; Mel Gorman <mgorman@techsingularity.net>; Mike
> >>> Kravetz <mike.kravetz@oracle.com>; Mike Rapoport <rppt@kernel.org>;
> >>> Amit, Nadav <namit@vmware.com>; Peter Xu <peterx@redhat.com>;
> >>> Shuah Khan <shuah@kernel.org>; Suren Baghdasaryan
> >>> <surenb@google.com>; Vlastimil Babka <vbabka@suse.cz>; zhangyi
> >>> <yi.zhang@huawei.com>
> >>> Cc: Axel Rasmussen <axelrasmussen@google.com>; linux-
> >>> doc@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
> >>> kernel@vger.kernel.org; linux-mm@kvack.org; linux-
> >>> kselftest@vger.kernel.org
> >>> Subject: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine gr=
ained
> >>> access control
> >>
> >> I assume that leaving the LSM mailing list off of the CC is purely
> >> accidental. Please, please include us in the next round.
> >
> > Honestly it just hadn't occurred to me, but I'm more than happy to CC
> > it on future revisions.
> >
> >>> This series is based on torvalds/master.
> >>>
> >>> The series is split up like so:
> >>> - Patch 1 is a simple fixup which we should take in any case (even by=
 itself).
> >>> - Patches 2-6 add the feature, configurable selftest support, and doc=
s.
> >>>
> >>> Why not ...?
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> - Why not /proc/[pid]/userfaultfd? The proposed use case for this is =
for one
> >>> process to open a userfaultfd which can intercept another process' pa=
ge
> >>> faults. This seems to me like exactly what CAP_SYS_PTRACE is for, tho=
ugh,
> >>> so I
> >>> think this use case can simply use a syscall without the powers
> >>> CAP_SYS_PTRACE
> >>> grants being "too much".
> >>>
> >>> - Why not use a syscall? Access to syscalls is generally controlled b=
y
> >>> capabilities. We don't have a capability which is used for userfaultf=
d access
> >>> without also granting more / other permissions as well, and adding a =
new
> >>> capability was rejected [1].
> >>>
> >>> - It's possible a LSM could be used to control access instead. I susp=
ect
> >>> adding a brand new one just for this would be rejected,
> >>
> >> You won't know if you don't ask.
> >
> > Fair enough - I wonder if MM folks (Andrew, Peter, Nadav especially)
> > would find that approach more palatable than /proc/[pid]/userfaultfd?
> > Would it make sense from our perspective to propose a userfaultfd- or
> > MM-specific LSM for controlling access to certain features?
> >
> > I remember +Andrea saying Red Hat was also interested in some kind of
> > access control mechanism like this. Would one or the other approach be
> > more convenient for you?
>
> To reiterate my position - I think that /proc/[pid]/userfaultfd is very
> natural and can be easily extended to support cross-process access of
> userfaultfd. The necessary access controls are simple in any case. For
> cross-process access, they are similar to those that are used for other
> /proc/[pid]/X such as pagemap.
>
> I have little experience with LSM and I do not know how real deployments =
use
> them. If they are easier to deploy and people prefer them over some
> pseudo-file, I cannot argue against them.
>
>
