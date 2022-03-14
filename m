Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964324D8C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 20:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiCNTSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiCNTSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:18:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393339686
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 12:17:24 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso12460990otr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8H8m2y9zCzWyh+KBmKW1kBaBg9/lp5gyEtHe7vr/K4=;
        b=ke6gGCWfTigigKJGfcBTbWpRXMOiLRNUBMLpzoD9L1ugYn0e4HllR+3JuMLalpRTjZ
         iJTtuoHz/xJ6r7B5JZuEeogfn/ux79UWcllgHHnHwMTwDHYosxSC9Re1Fzg2zW1K2sto
         twi6TqUjb2JQ+5q8dZR9luAFLzgDAEVxp/KAOjIqGWGXPahbLPIK0q2XL2sz20x4RdLZ
         RqR1kYIuyRlKwUCpUDuyf+pJgpccr4gzsEogGvzY974LI6CQir91VHQ5h2nnBmiogmy4
         Z2oyn3xxKahdUwq48YEFQCTk8GTytnYv1ZF0pIu1Hi1hlDuHRepeJeVLCtCLU0OW+JKl
         4vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8H8m2y9zCzWyh+KBmKW1kBaBg9/lp5gyEtHe7vr/K4=;
        b=sm3KiUgjRdxdD6YwoVSp+B+b0YsFuJqNOc1Z20QzEEbn8OlYg2dDT47Ok1sTEffwAB
         y1YrrljwtwqPODzHT3K8JCT9wfqYlN3BEqsHZEXUsrFn+YjZryp1G+vIy9OyiBlzNUp3
         13KKxVt9qECTj7n/lh9SNk+TSC0sjkg55bvAg0tp0/fsqZL/AorA/km7ZOEUb8BvL0IA
         ftr54js0tPk6Ih6B5VvoWO/zIVvEvrfGF3lKkdoy7gL5SlH48nwjHHuXQfp78ubb27qP
         DFNf16gI8hritIVAE7ll9jFh3wwI1V4n9KUamLrfrRRa/4S+2poK2Z60HaGNxE6YnyF1
         kWKg==
X-Gm-Message-State: AOAM530cPcYTRgoQGsI4qVwxpZdf02Y+NU1R9jLBmgm2eVroMXqG9+vv
        mXi90x0iLQyX3OqOXhVg/CxCEevdzGh6OuJIXmo=
X-Google-Smtp-Source: ABdhPJxMNcHWCuAJSIRU0UTDOtX7AotxuW//ltIHcvfMhdPsmQfPMVxxUCUDfW/apflM/txQWDBphU69KT8IDxii1tU=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr11608006oti.275.1647285443800; Mon, 14
 Mar 2022 12:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com> <20220314113337.j7slrb5srxukztje@quack3.lan>
In-Reply-To: <20220314113337.j7slrb5srxukztje@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Mar 2022 21:17:11 +0200
Message-ID: <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 1:33 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-03-22 11:28:23, Amir Goldstein wrote:
> > On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 12-03-22 11:22:29, Srinivas wrote:
> > > > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT=
,
> > > > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can =
be
> > > > applied.
> > > >
> > > > However a path (file) exclusion can still be applied using
> > > >
> > > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > > > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_F=
DCWD,
> > > > "/tmp/fio/abc");  =3D=3D=3D> path exclusion that works.
> > > >
> > > > I think the directory exclusion not working is a bug as otherwise A=
V
> > > > solutions cant exclude directories when using FAN_MARK_MOUNT.
> > > >
> > > > I believe the change should be simple since we are already supporti=
ng
> > > > path exclusions. So we should be able to add the same for the direc=
tory
> > > > inode.
> > > >
> > > > 215676 =E2=80=93 fanotify Ignoring/Excluding a Directory not workin=
g with
> > > > FAN_MARK_MOUNT (kernel.org)
> > >
> > > Thanks for report! So I believe this should be fixed by commit 4f0b90=
3ded
> > > ("fsnotify: fix merge with parent's ignored mask") which is currently
> > > sitting in my tree and will go to Linus during the merge (opening in =
a
> > > week).
> >
> > Actually, in a closer look, that fix alone is not enough.
> >
> > With the current upstream kernel this should work to exclude events
> > in a directory:
> >
> > fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
> >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                        AT_FDCWD, "/tmp/fio/");
> > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> >                        FAN_MARK_IGNORED_SURV_MODIFY,
> >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                        AT_FDCWD, "/tmp/fio/");
> >
> > The first call tells fanotify that the inode mark on "/tmp/foo" is
> > interested in events on children (and not only on self).
> > The second call sets the ignored mark for open/close events.
> >
> > The fix only removed the need to include the events in the
> > first call.
> >
> > Should we also interpret FAN_EVENT_ON_CHILD correctly
> > in a call to fanotify_mark() to set an ignored mask?
> > Possibly. But that has not been done yet.
> > I can look into that if there is interest.
>
> Oh, right. I forgot about the need for FAN_EVENT_ON_CHILD in the
> mark->mask. It seems we can set FAN_EVENT_ON_CHILD in the ignored_mask as
> well but it just gets ignored currently. So we would need to propagate it
> even from ignore_mask to inode->i_fsnotify_mask. But send_to_group() woul=
d
> also need to be more careful now with ignore masks and apply them from
> parent only if the particular mark has FAN_EVENT_ON_CHILD in the ignore
> mask. Interestingly fanotify_group_event_mask() does explicitely apply
> ignore_mask from the parent regardless of FAN_EVENT_ON_CHILD flags. So
> there is some inconsistency there and it would need some tweaking...
>

I am thinking why do we need the duplicate and unaligned ignore mask logic
in send_to_group() at all?

With fanotify the only backend using the ->handle_event() multi mark
flavor, maybe we should keep it simple and let fanotify do all the specific
mark ignore logic internally?

> Overall I guess the functionality makes sense to me (in fact it is somewh=
at
> surprising it is not working like that from the beginning), API-wise it i=
s
> not outright horrible, and technically it seems doable. What do you think=
?
>

I think that having ONDIR and ON_CHILD in ignored mask is source for
confusion.
Imagine a mount mark with FAN_ONDIR and ignored mark (on dir inode)
without FAN_ONDIR.
What should the outcome be?
Don't ignore the events on dir because ignore mask does not have ONDIR?
That is not the obvious behavior that people will expect.

ON_CHILD may be a different case, but I also prefer not to deviate it from
ONDIR.

The only thing I can think of to add clarification is FAN_MARK_PARENT.

man page already says:
"The flag has no effect when marking mounts and filesystems."
It can also say:
"The flag has no effect when set in the ignored mask..."
"The flag is implied for both mask and ignored mask when marking
 directories with FAN_MARK_PARENT".

Implementation wise, this would be very simple, because we already
force set FAN_EVENT_ON_CHILD for FAN_MARK_MOUNT
and FAN_MARK_FILESYSTEM with REPORT_DIR_FID, se we can
also force set it for FAN_MARK_PARENT.

But maybe it's just me that thinks this would be more clear??

Thanks,
Amir.
