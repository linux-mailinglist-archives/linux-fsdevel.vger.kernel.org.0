Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977F52697B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383029AbiEMSkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354345AbiEMSkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 14:40:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB0BE0B;
        Fri, 13 May 2022 11:40:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id k2so7514074qtp.1;
        Fri, 13 May 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMOsy8saNPNJjd7MVG7MTwmCMbPAElUWPoxbkeiwsTA=;
        b=kqauGbKMccwAftLuvcnHEOqaguYYdNEACsY5o5gKaLfEP4S2zPDBDV0DsINu3Q81Kf
         W0EeVTYGMZx8HQ+VhgLHNd55RQOgZwoH8UDv8giC8jjfq0Tnixsj3F66jMwQLzYZx1OO
         8a93YeR0NivdGQDx8d/x3Ca9xMLZyTdSWcZgh6KCArZ0YRV2QuPw7qXNEkfpEPi1uML1
         JNyqKU5JrBMwbg+RiIp1GABYO3GO6qNPZ/4+vvtBUGdfTkWnSoPqM+bHlfF+sJbX8qFW
         VbKgKYcXVOxHPefaC++Fk1eHCuKObsb2mj1cURMuO20xMhzPKACxkSrw9IuIXuk9liFP
         TWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMOsy8saNPNJjd7MVG7MTwmCMbPAElUWPoxbkeiwsTA=;
        b=5Tek1YwxE/trpk8j/NkPVaIbza8is9raQ+W8bJk82i1tEWHz5ililUXgzjvVTrSeT7
         u62qaVljtqiI1bovpsxo0qCJJvrghKE/tL3+JjDpExCYxd60fNqAqHZCbOuvqlWEq02K
         I8hNoDF6cY5Bj7QUB2Lcd338+RZPDfFfB0141jtq0u8nz7qXLtnToXOj/UOm2rKGdfev
         K1Ac1k/1LcZRg/rAbOE63fEaCN5gXGo40pLJCzUDtrNmb/omj6QjSqP8ECD7EQ/eScBr
         FB2o4mqk/rCdeBSw6txdMD2YjFsPAQe83qqSZswwcDK+eVCMM+CbdFHGiIafvyOacMeO
         z27Q==
X-Gm-Message-State: AOAM530zLmCbg2mjSSMP6OeB1JgTO/dzDB3iClD+V4Wzzvp+pws1ubU2
        B+qnhMz7by9pV+Lb5FtpsAm7/THkVMgtvL6VA1jnEbL+GD0=
X-Google-Smtp-Source: ABdhPJyJh64r6r3MaCAwuk4gpXAJk+B7HIXNkUQ8TjTs6Xg8SM7rwSsPLlVeV9i7L48mam1JL1TLraD5ShJ7FgIPbjQ=
X-Received: by 2002:a05:622a:1a9c:b0:2f3:d873:4acc with SMTP id
 s28-20020a05622a1a9c00b002f3d8734accmr5913351qtc.424.1652467203126; Fri, 13
 May 2022 11:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <YnOmG2DvSpvvOEOQ@google.com> <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan> <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
 <20220506100636.k2lm22ztxpyaw373@quack3.lan> <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
 <Yn5al/rEQIcf6pjR@google.com> <CAOQ4uxiMBEz8bgNT6zhsJbVe6dKCXfd0WyZw3MdNb_WLFvk2Zg@mail.gmail.com>
 <Yn5/LgUdNbZsHc/N@google.com>
In-Reply-To: <Yn5/LgUdNbZsHc/N@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 May 2022 21:39:51 +0300
Message-ID: <CAOQ4uxhe5JggjA2guaK-_HcckmQR36jCfL=9DVZsZq3-fKKe-A@mail.gmail.com>
Subject: Re: Fanotify API - Tracking File Movement
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 6:54 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, May 13, 2022 at 05:14:57PM +0300, Amir Goldstein wrote:
> > On Fri, May 13, 2022 at 4:18 PM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > On Sat, May 07, 2022 at 07:03:13PM +0300, Amir Goldstein wrote:
> > > > Sorry Matthew, I was looking at the code to give you pointers, but there were
> > > > so many subtle details (as Jan has expected) that I could only communicate
> > > > them with a patch.
> > > > I tested that this patch does not break anything, but did not implement the
> > > > UAPI changes, so the functionality that it adds is not tested - I leave that
> > > > to you.
> > >
> > > No, that's totally fine. I had to familiarize myself with the
> > > FS/FAN_RENAME implementation as I hadn't gone over that series. So
> > > appreciate you whipping this together quickly as it would've taken a
> > > fair bit of time.
> > >
> > > Before the UAPI related modifications, we need to first figure out how
> > > we are to handle the CREATE/DELETE/MOVE cases.
> > >
> > > ...
> > >
> > > > My 0.02$ - while FAN_RENAME is a snowflake, this is not because
> > > > of our design, this is because rename(2) is a snowflake vfs operation.
> > > > The event information simply reflects the operation complexity and when
> > > > looking at non-Linux filesystem event APIs, the event information for rename
> > > > looks very similar to FAN_RENAME. In some cases (lustre IIRC) the protocol
> > > > was enhanced at some point exactly as we did with FAN_RENAME to
> > > > have all the info in one event vs. having to join two events.
> > > >
> > > > Hopefully, the attached patch simplifies the specialized implementation
> > > > a little bit.
> > > >
> > > > But... (there is always a but when it comes to UAPI),
> > > > When looking at my patch, one cannot help wondering -
> > > > what about FAN_CREATE/FAN_DELETE/FAN_MOVE?
> > > > If those can report child fid, why should they be treated differently
> > > > than FAN_RENAME w.r.t marking the child inode?
> > >
> > > This is something that crossed my mind while looking over the patch
> > > and is a very good thing to call-out indeed. I am of the opinion that
> > > we shouldn't be placing FAN_RENAME in the special egg basket and also
> > > consider how this is to operate for events
> > > FAN_CREATE/FAN_DELETE/FAN_MOVE.
> > >
> > > > For example, when watching a non-dir for FAN_CREATE, it could
> > > > be VERY helpful to get the dirfid+name of where the inode was
> > > > hard linked.
> > >
> > > Oh right, here you're referring to this specific scenario:
> > >
> > > - FAN_CREATE mark exclusively placed on /dir1/old_file
> > > - Create link(/dir1/old_file, /dir2/new_file)
> > > - Expect to receive single event including two information records
> > >   FID(/dir1/old_file) + DFID_NAME(/dir2/new_file)
> > >
> > > Is that correct?
> >
> > Correct.
> > Exactly the same event as you would get from watching dir2 with
> > FAN_CREATE|FAN_EVENT_ON_CHILD in a group with flag
> > FAN_REPORT_TARGET_FID.
>
> Right, that makes sense. For FAN_CREATE and FAN_DELETE (not entirely
> sure about FAN_MOVE right now),

FAN_MOVED_TO FAN_MOVED_FROM are not different than
FAN_CREATE FAN_DELETE they carry exact same info

> as you mentioned can we simply provide
> the DFID_NAME of the non-directory indirect objects? From a UAPI
> perspective, I think in terms of what's expected in such situation
> would be clear.
>

I think there may be some confusion.
We are not suggesting to change anything w.r.t the event info.
FAN_REPORT_TARGET_FID already defines that those dirent
events on non-dir with carry DFID_NAME and FID of non-dir child.

The only difference in behavior is that we are going to allow,
with group flag FAN_REPORT_TARGET_FID, to set the dirent
events in mask of a non-dir child to receive the exact same events
with same event info as received today for a watching parent.

Thanks,
Amir.
