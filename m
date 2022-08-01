Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B388F587416
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiHAWvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 18:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiHAWve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:51:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071D27175
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 15:51:31 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r70so9491582iod.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=glcOCUJ/+awLcSG8X5QxtUVosWAHdrRlN7P8qFCy/KU=;
        b=VgjLNHr1hMbP7jz5VD9tM4tHHUdeWiE6jv/PZZxVCEl8oCfbeuNfGwRZv+sM+Wf2i5
         oNtEEDp7KV0lDn8cKVruat3XxxQpJMcYjwbPK6y/MVRRPL11HHL0qSFaA+lfpHzZBha0
         nLWIVaLCa21JIuOinIDkNS5w6493rVMBjMsIoJBEJyiHzTbqwHr8PtBHwPGlSVsZYhnF
         QZ0bwchCYRMq8Xg6oV57EE21VLo09Sr7nwNLOc9tMa0EkmmzqE6+UV6VMx2SxN+hUzky
         CnA8w+UFJxkOejBgEvFvCIaDj3nOXOQ57P4poCq6zqCOaJrsgvvPN50y3wl4tui1yenO
         Uz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=glcOCUJ/+awLcSG8X5QxtUVosWAHdrRlN7P8qFCy/KU=;
        b=gxjQryTMRWAftB+tK8eVeN5ODu1e/r2+Rz00ZbHyR/iz5qmzl/KopG0wydQUlpaSf3
         zDS0+qQbODmuxRqTQOl0VNX1/kQwN04q5n2nbpGiTi/SoaIlluGJFvujO6xOunh8MLPR
         fbV4If6ptRCKWUqAoMihwjvTCaFnLAvu/2R89rV7DLb5MaekQQZgMFu3JgXPb6G0Z9+v
         u0rvJtz65hGJppIYAngazaxfyQ7ZJ3V4v6lp9krZL5OrDFH3uX5+Ga8oEVyWqkNiQgm+
         mijYHQ4XQIP5pVYOpvfv/x7QoQe55HGELKyqrh5Ydx9DIFLkQ3Gfyn7tUjOKnWNRvkFP
         3RZA==
X-Gm-Message-State: AJIora/2jnGVxMxJ2naJXrFO3yISaySzfLtmUPiFTI4yUHrDtxp3ZFzt
        GekHcbqBwTyWZrsFafUQJ5LtaCdsE/btKVMXWg/Hpw==
X-Google-Smtp-Source: AGRyM1uNtkg5Y2IRmGnxo1RbFLJVbjJuAEzaSRiEXHBPKJ+mQGbRVw11UEmSKc0sWqWF8C25CpekbWeNsTatl+C7xk4=
X-Received: by 2002:a05:6602:15c8:b0:67c:45c7:40c9 with SMTP id
 f8-20020a05660215c800b0067c45c740c9mr6287785iow.138.1659394290961; Mon, 01
 Aug 2022 15:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
 <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com>
 <7EF50BE4-84EA-4D57-B58C-6697F1B74904@vmware.com> <CAJHvVcghaZjgU6YhoGMehQTDU36S-UL5djG+Bym6Uax=VVoX7g@mail.gmail.com>
 <DDE06635-71B4-46B9-9635-97E35E0B5482@vmware.com>
In-Reply-To: <DDE06635-71B4-46B9-9635-97E35E0B5482@vmware.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 1 Aug 2022 15:50:55 -0700
Message-ID: <CAJHvVcgR63YNyGYj1Z-XAj5WP631P0DSEK8Mx=f9E=QGJBeRug@mail.gmail.com>
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

On Mon, Aug 1, 2022 at 12:53 PM Nadav Amit <namit@vmware.com> wrote:
>
> On Aug 1, 2022, at 10:13 AM, Axel Rasmussen <axelrasmussen@google.com> wr=
ote:
>
> > =E2=9A=A0 External Email
> >
> > I finished up some other work and got around to writing a v5 today,
> > but I ran into a problem with /proc/[pid]/userfaultfd.
> >
> > Files in /proc/[pid]/* are owned by the user/group which started the
> > process, and they don't support being chmod'ed.
> >
> > For the userfaultfd device, I think we want the following semantics:
> > - For UFFDs created via the device, we want to always allow handling
> > kernel mode faults
> > - For security, the device should be owned by root:root by default, so
> > unprivileged users don't have default access to handle kernel faults
> > - But, the system administrator should be able to chown/chmod it, to
> > grant access to handling kernel faults for this process more widely.
> >
> > It could be made to work like that but I think it would involve at leas=
t:
> >
> > - Special casing userfaultfd in proc_pid_make_inode
> > - Updating setattr/getattr for /proc/[pid] to meaningfully store and
> > then retrieve uid/gid different from the task's, again probably
> > special cased for userfautlfd since we don't want this behavior for
> > other files
> >
> > It seems to me such a change might raise eyebrows among procfs folks.
> > Before I spend the time to write this up, does this seem like
> > something that would obviously be nack'ed?
>
> [ Please avoid top-posting in the future ]

I will remember this. Gmail's default behavior is annoying. :/

>
> I have no interest in making your life harder than it should be. If you
> cannot find a suitable alternative, I will not fight against it.
>
> How about this alternative: how about following KVM usage-model?
>
> IOW: You open /dev/userfaultfd, but this is not the file-descriptor that =
you
> use for most operations. Instead you first issue an ioctl - similarly to
> KVM_CREATE_VM - to get a file-descriptor for your specific process. You t=
hen
> use this new file-descriptor to perform your operations (read/ioctl/etc).
>
> This would make the fact that ioctls/reads from different processes refer=
 to
> different contexts (i.e., file-descriptors) much more natural.
>
> Does it sound better?

Ah, that I think is more or less what my series already proposes, if I
understand you correctly.

The usage is:

fd =3D open(/dev/userfaultfd) /* This FD is only useful for creating new
userfaultfds */
uffd =3D ioctl(fd, USERFAULTFD_IOC_NEW) /* Now you get a real uffd */
close(fd); /* No longer needed now that we have a real uffd */

/* Use uffd to register, COPY, CONTINUE, whatever */

One thing we could do now or in the future is extend
USERFAULTFD_IOC_NEW to take a pid as an argument, to support creating
uffds for remote processes.



And then we get the benefit of permissions for /dev nodes working very
naturally - they default to root, but can be configured by the
sysadmin via chown/chmod, or udev rules, or whatever.
