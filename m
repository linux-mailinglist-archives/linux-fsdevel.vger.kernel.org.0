Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99FB1E9165
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgE3NH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgE3NH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 09:07:57 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD6C03E969;
        Sat, 30 May 2020 06:07:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so2253962iow.7;
        Sat, 30 May 2020 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fa2LnUBoKZEz2hoMaFjlI6+VHn6uuC5kUXlOp9IFUhc=;
        b=JDRZjD47ko2M+2hb2KkDYhY3R+6etPctuRkGN1VPbhkNrwq2Z8CIcnljdWRqu4RXyv
         dqMgfhd52++WuDSHzvTo2+WZlXlMJsogItzhGlAm6JCYG/IqU2zS3BKC94MDBTu2iwGF
         8Q+MMpYST7ULNaFbzhYyjAuzqmNXtEVgmdob8L1shKvvTDRDDZUmgHkIRpi8nqCeNKrW
         EHpv8AIStrHz35cSrvnUg8VujaPj7WgDM83uzMQVD8lEqPF502FPEseUU8QzN6P4cwAY
         6spgT96eIlMtbZ2y4WkhWdiNfBLQ5UG6nquBqeHEEhRfUQ1xogm9I0Y/rPxL438DVZOn
         HDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fa2LnUBoKZEz2hoMaFjlI6+VHn6uuC5kUXlOp9IFUhc=;
        b=JwE+tS6CDQ0Zpo4PXydnRJ1S32YLL3ohPYCyL8jZd5xrcqcAM7x5ZK101r6DY8gqQJ
         mZaItAa2DU9Ss2tbfCx/W82suUiXX12wG0qOtM1aLHYCf0l9OvlHESQhbp3XXDjW0AeA
         EsPkUXAoJbfrtuzREQfFehCyaTRApdmfo/2/FcDPBe9uql8IKGH21baHb4K8ncZ5Isam
         wBfVExiELN7tMvROAeLJz3yAsieDEGDqEpU3bbNwVA6CgRXDdo2XVu00qMGnbCQ1z3MK
         Zpw6jUlnodsZbQKzUmSLAvtsrZ9r/BcZ55gRAgTUdWlVzBeII50HA5vS76q/qOFA9faW
         6P1A==
X-Gm-Message-State: AOAM530v8Q+F5U6PhEGemvLo+oHgrNjXMrv+p+lf2CUxTGyfvGk4ICqf
        dubWD2VhYn32VasW3uuLXtBLtNr/Y02oP+DsgpM=
X-Google-Smtp-Source: ABdhPJz3St4vLcJaC0pxKPdCS9AhiyWvIPx830oYSH/5Xs7cs8fyCbjG1Cg0mq3NIcFUu4GBmZ9l1+WB/5y2NiPVgHc=
X-Received: by 2002:a02:5184:: with SMTP id s126mr10706459jaa.30.1590844076614;
 Sat, 30 May 2020 06:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200527172143.GB14550@quack2.suse.cz> <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
 <20200528125651.GA12279@nautica> <1590777699518.49838@cea.fr>
In-Reply-To: <1590777699518.49838@cea.fr>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 30 May 2020 16:07:45 +0300
Message-ID: <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com>
Subject: Re: robinhood, fanotify name info events and lustre changelog
To:     "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 9:41 PM Quentin.BOUGET@cea.fr
<Quentin.BOUGET@cea.fr> wrote:
>
> Hi,
>
> Developer of robinhood v4 here,
>
> > > > [1] https://github.com/cea-hpc/robinhood/
>
> The sources for version 4 live in a separate branch:
> https://github.com/cea-hpc/robinhood/tree/v4
>
> Any feedback is welcome =)
>
> I am guessing the most interesting bits for this discussion should be found
> here:
> https://github.com/cea-hpc/robinhood/blob/v4/include/robinhood/fsevent.h
>

That is a very well documented API and a valuable resource for me.

Notes for API choices that are aligned with current fanotify plans:
- The combination of parent fid + object fid without name is never expected

Notes for API choices that are NOT aligned with current fanotify plans:
- LINK/UNLINK events carry the linked/unlinked object fid
- XATTR events for inode (not namespace) do not carry parent fid/name

This doesn't mean that fanotify -> rbh_fsevent translation is not going to
be possible.

With fanotify FAN_CREATE event, for example, the parent fid + name
information should be used by the rbh adapter code to call
name_to_handle_at(2) and get the created object's file handle.

The reason we made this API choice is because fanotify events should
not be perceived as a sequence of changes that can be followed to
describe the current state of the filesystem.
fanotify events should be perceived as a "poll" on the namespace.
Whenever notified of a change, application should read the current state
for the filesystem. fanotify events provide "just enough" information, so
reading the current state of the filesystem is not too expensive.

> I am not sure it will matter for the rest of the conversation, but just in case:
>
>     RobinHood v4 has a notion of a "namespace" xattr (like an xattr, but for
>     a dentry rather than an inode), it is used it to store things that are only
>     really tied to the namespace (like the path of an entry). I don't think this
>     is really relevant here, you can probably ignore it.
>
>     Also, RobinHood uses file handles to uniquely identify filesystem entries,
>     and this is what is stored in a `struct rbh_id`.
>

Makes sense.
When fanotify event FAN_MODIFY reports a change of file size,
along with parent fid + name, that do not match the parent/name robinhood
knows about (i.e. because the event is received out of order with rename),
you may use that information to create rbh_fsevent_ns_xattr event to
update the path or you may wait for the FAN_MOVE_SELF event that
should arrive later.
Up to you.

> > > I couldn't find the documentation for Lustre Changelog format, because
> > > the name of the feature is not very Google friendly.
>
> Yes, this is really unfortunate. For the record, user documentation for Lustre
> lives at: http://doc.lustre.org/lustre_manual.xhtml
>
> Chapter 12.1 deals with "Lustre Changelogs" (not much more there than
> what Dominique already wrote).
>

Thanks for the link.

> > > There is one critical difference between a changelog and fanotify events.
> > > fanotify events are delivered a-synchronically and may be delivered out
> > > of order, so application must not rely on path information to update
> > > internal records without using fstatat(2) to check the actual state of the
> > > object in the filesystem.
>
> > lustre changelogs are asynchronous but the order is guaranteed so we
> > might rely on that for robinhood v4,
>
> Yes, we do. At least to a certain extent : we at least expect changelog records
> for a single filesystem entry to be emitted in the order they happened on the
> FS. I have not really given much thought to how things would work in general
> if that wasn't true, but I know this is an issue for things that deal with the
> namespace : https://jira.whamcloud.com/browse/LU-12574
>

I think we may consider in the future, since renaming directories outside
of their parent is done in the kernel under a filesystem wide lock, to
provide a new event FAN_DIR_MOVE which is not merged and not
re-odered with other FAN_DIR_MOVE events. We may even be able to
go one step further and say that FAN_DIR_MOVE is a barrier with which
no event inside the moved dir can be re-ordered, but at the moment,
there is no such guaranty for any type of event.

> > but full path is not computed from
> > information in the changelogs. Instead the design plan is to have a
> > process scrub the database for files that got updated since the last
> > path update and fix paths with fstatat, so I think it might work ; but
> > that unfortunately hasn't been implemented yet.
>
> Not exactly (I am not sure it really matters, so I'll try to be brief).
>
> The idea to keep paths in sync with what's in the filesystem is to "tag"
> entries as we update their name (ie. after a rename). Then a separate
> process comes in, queries for entries that have that "tag", and updates
> their path by concatenating their parent's path (if the parents themselves
> are not "tagged") with the entries' own, up-to-date name. After that, if
> the entry was a directory, its children are "tagged". I simplified a bit, but
> that's the idea.
>

Nice. thanks for explaining that.
I suppose you need to store the calculated path attribute for things like
index queries on the database?

> So, to be fair, full paths _are_ computed solely from information in the
> changelog records, even though it requires a bit of processing on the side.
> No additional query to the filesystem for that.
>

As I wrote, that fact that robinhood trusts the information in changelog
records doesn't mean that information needs to arrive from the kernel.
The adapter code should use information provided by fanotify events
then use open_by_handle_at(2) for directory fid to finds its current
path in the filesystem then feed that information to a robinhood change
record.

I would be happy to work with you on a POC for adapting fanotify
test code with robinhood v4, but before I invest time on that, I would
need to know there is a good chance that people are going to test and
use robinhood with Linux vfs.

May I ask, what is the reason for embarking on the project to decouple
robinhood v4 API from Lustre changelog API?
Is it because you had other fsevent producers in mind?
Do you have actual users requesting to use robinhood with non-Lustre fs?

Thanks,
Amir.
