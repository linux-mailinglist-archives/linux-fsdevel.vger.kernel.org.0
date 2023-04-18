Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A816E67F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjDRPUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjDRPUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:20:37 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C995118E1;
        Tue, 18 Apr 2023 08:20:34 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id s13so7641007uaq.4;
        Tue, 18 Apr 2023 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681831233; x=1684423233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSIyxHkbZWd4wY1/3LPPdat82/dHSBlxl/GGpCWtFJg=;
        b=Nhodw3P2ijhT/AkkpvNyKmgPrwHr/hAhUSZ3QuC+q7Z5zPu2e3XIqH6kp9ziBkemVH
         95L4MePyoiTgSDvozGHlThI2YULg2Vu3DatgUXJ8dkezUeqOwhuYUW9CWClQgNUM7KJk
         2BqOctW25dXEtAmOptHCyi3GfLBAGEHmOBmU/ArHPotb1vVwF8M2uTmHvxaDqPAybdrW
         vcwQFnWfg8M3IkWdK7Vck04jz8XaauX8bfuMSCuqM0hfC3IpMcN8P82iz05gWt0rRY+S
         HvwXs8ghXvL8es3Xg1CiGNtJBB53PqCXcKZdvd/oiznyxDTVXA0v1Ok/kb/oxCdJzZkv
         saDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831233; x=1684423233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSIyxHkbZWd4wY1/3LPPdat82/dHSBlxl/GGpCWtFJg=;
        b=f4T/eGAqmeqFbZd32B6TaR1SPRJ3UdzMfuUwqPWnZ3zzAGuxnW2Wac9PAIlXAaixZZ
         MG2/GoTKcp8chQWuRHB/BBrzUksfxamGlLuhF+bo9KVRByJfpnlKo815TTsCYq7/kO9U
         XHkcQd1gYrXkj77/TZ5ELuz/9VG9LN841VWdPVc00MTvM9MGfFIC6Jo4MppkADJia2oa
         1LBr/7M7VqTbMTxs/fft56A/8qP/PBLpFfL5JlEX/PsFvQdNrC2IwuS9utZ4yR2GMbv8
         tWJm+ak2+35LNeMh0T/oBBMFS+pdmKzPDJdYO5wtAuOO1SfOyU6hH62sF3cqQEcizJ79
         CtQg==
X-Gm-Message-State: AAQBX9fpj3N3zGMsOVen/CB5ulfAxAuiurjvzYYSNPSMj1mypYRDmDmm
        C39mNhTe20S84gp/rMb051Ocfd1pJZnEJQKT3mc=
X-Google-Smtp-Source: AKy350YtKCduYu/ofuHZ00n79aJkgmfE8hsABfJkr7+6IHtQlMt8bwyL0vLJYL1e6ziBTPOhKOBpOwxlz3Vj5LgTez8=
X-Received: by 2002:a1f:a710:0:b0:40c:4d1:b550 with SMTP id
 q16-20020a1fa710000000b0040c04d1b550mr9884648vke.0.1681831233515; Tue, 18 Apr
 2023 08:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230414182903.1852019-1-amir73il@gmail.com> <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
 <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com> <20230418-absegnen-sputen-11212a0615c7@brauner>
In-Reply-To: <20230418-absegnen-sputen-11212a0615c7@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Apr 2023 18:20:22 +0300
Message-ID: <CAOQ4uxgM2x93UKcJ5D5tfoTt8s0ChTrEheTGqTcndGoyGwS=7w@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Apr 18, 2023 at 04:56:40PM +0300, Amir Goldstein wrote:
> > On Tue, Apr 18, 2023 at 4:33=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 09:29:01PM +0300, Amir Goldstein wrote:
> > > > Jan,
> > > >
> > > > Followup on my quest to close the gap with inotify functionality,
> > > > here is a proposal for FAN_UNMOUNT event.
> > > >
> > > > I have had many design questions about this:
> > >
> > > I'm going to humbly express what I feel makes sense to me when lookin=
g
> > > at this from a user perspective:
> > >
> > > > 1) Should we also report FAN_UNMOUNT for marked inodes and sb
> > > >    on sb shutdown (same as IN_UNMOUNT)?
> > >
> > > My preference would be if this would be a separate event type.
> > > FAN_SB_SHUTDOWN or something.
> >
> > If we implement an event for this at all, I would suggest FAN_IGNORED
> > or FAN_EVICTED, which has the same meaning as IN_IGNORED.
> > When you get an event that the watch went away, it could be because of:
> > 1. watch removed by user
> > 2. watch removed because inode was evicted (with FAN_MARK_EVICTABLE)
> > 3. inode deleted
> > 4. sb shutdown
> >
> > IN_IGNORED is generated in all of the above except for inode evict
> > that is not possible with inotify.
> >
> > User can figure out on his own if the inode was deleted or if fs was un=
mounted,
> > so there is not really a need for FAN_SB_SHUTDOWN IMO.
>
> Ok, sounds good.
>
> >
> > Actually, I think that FAN_IGNORED would be quite useful for the
> > FAN_MARK_EVICTABLE case, but it is a bit less trivial to implement
> > than FAN_UNMOUNT was.
> >
> > >
> > > > 2) Should we also report FAN_UNMOUNT on sb mark for any unmounts
> > > >    of that sb?
> > >
> > > I don't think so. It feels to me that if you watch an sb you don't
> > > necessarily want to watch bind mounts of that sb.
> > >
> > > > 3) Should we report also the fid of the mount root? and if we do...
> > > > 4) Should we report/consider FAN_ONDIR filter?
> > > >
> > > > All of the questions above I answered "not unless somebody requests=
"
> > > > in this first RFC.
> > >
> > > Fwiw, I agree.
> > >
> > > >
> > > > Specifically, I did get a request for an unmount event for containe=
rs
> > > > use case.
> > > >
> > > > I have also had doubts regarding the info records.
> > > > I decided that reporting fsid and mntid is minimum, but couldn't
> > > > decide if they were better of in a single MNTID record or seprate
> > > > records.
> > > >
> > > > I went with separate records, because:
> > > > a) FAN_FS_ERROR has set a precendent of separate fid record with
> > > >    fsid and empty fid, so I followed this precendent
> > > > b) MNTID record we may want to add later with FAN_REPORT_MNTID
> > > >    to all the path events, so better that it is independent
> > >
> >
> > Just thought of another reason:
> >  c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
> >      so it does not depend on filesystem having a valid f_fsid nor
> >      exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can report
> >      only MNTID record (I will amend the patch with this minor change).
>
> I see some pseudo fses generate f_fsid, e.g., tmpfs in mm/shmem.c

tmpfs is not "pseudo" in my eyes, because it implements a great deal of the
vfs interfaces, including export_ops.

and also I fixed its f_fsid recently:
59cda49ecf6c shmem: allow reporting fanotify events with file handles on tm=
pfs

> At the risk of putting my foot in my mouth, what's stopping us from
> making them all support f_fsid?

Nothing much. Jan had the same opinion [1].

We could do either:
1. use uuid_to_fsid() in vfs_statfs() if fs has set s_uuid and not set f_fs=
id
2. use s_dev as f_fsid in vfs_statfs() if fs did not set f_fsid nor s_uuid
3. randomize s_uuid for simple fs (like tmpfs)
4. any combination of the above and more

Note that we will also need to decide what to do with
name_to_handle_at() for those pseudo fs.

Quoting Jan from [1]:
"But otherwise the proposal to make name_to_handle_at() work even for
filesystems not exportable through NFS makes sense to me. But I guess we
need some buy-in from VFS maintainers for this." (hint hint).

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vtft@q=
uack3/
