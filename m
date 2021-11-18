Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2F4560D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhKRQqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 11:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbhKRQqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:46:44 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C1C061574;
        Thu, 18 Nov 2021 08:43:44 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e8so7109575ilu.9;
        Thu, 18 Nov 2021 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHXYrpkfWzexMQu3rjZVVnAQq/u99wN5y+Cu0SZwxoU=;
        b=OOw0SvzNbjSwHaFUynoJ35TZjNaEDyaD6GNLs3ZFGrmHyCm5gkCo6xVabRL4osIpp6
         /gN2TrbN3bF974KwXPkm8SoCUpMphUP7mBR9p64/ztfOoo22C302i5iLS3RbtBmvpFNf
         jSaU5EjYmsd5xL+NTcxKwbynTg/7OAS6keXTN2OizcAXM3S5Za7Gju2eLmWFBPhpMJmU
         KWyIFly+rGvyPAeZ5aPtb5Tcd/9KqHdZJiU0+hytYnEeboociU8ULeWZ46mSVcE+gnQA
         NwWccjlC1xeZrwwaCxexi/TxMAbnasdYQH+aZ5yi+F8M9M3bkmUfjLvEO2zppKvpw3ak
         W4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHXYrpkfWzexMQu3rjZVVnAQq/u99wN5y+Cu0SZwxoU=;
        b=i2xMfh+iE6Bz8WdzeSQVlYADwBRJ+dwT1xCys8sWo4fBH0T6RAU+8KBsn8uPQFrl2Z
         DCmekxv5DZQVaE6oMZY4nQRgCm60BqlzG4aUpHwiUnq7uA3ktAfDm1lF7XUMJN2XO6o/
         yTVF9bfQQbcM8Whp9D4dmdvKK9sBLaVUNsxy3mKuwsPHumQ+qMscwQ26BGvAsIIRJ6eL
         cTuw50HOrR30xr7auFJ8dg5QhO4Oq9rxyfBdl5ILFDDLQclczUT0B3bcfJYlPq+18MM2
         DFscRhVdVZjg4jdObdAEqvlwg5r7axBp8wcUKxjVRD2dqntaRlucrNvbGvevwNNItVFi
         ivBA==
X-Gm-Message-State: AOAM530l8cJUuFXscL4ygbUzm0TyWk97p4NFepDfYpAfxsZtVAuryBA7
        +NF6Ybqq1+4pVBu3lT3je1GKl4YEcX7RLA/H9hQ=
X-Google-Smtp-Source: ABdhPJxjKNwJrg/M6Z5DGIQ4/UeNDAyDvU5YATU7TtjHWaslW4jqFsLnGKfpKU29Va7D3vafF1SyJhikVNhSWUrPtbY=
X-Received: by 2002:a05:6e02:ea4:: with SMTP id u4mr283953ilj.319.1637253824165;
 Thu, 18 Nov 2021 08:43:44 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz> <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
 <20211115102330.GC23412@quack2.suse.cz> <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
 <20211115143750.GE23412@quack2.suse.cz> <CAOQ4uxgBncZjuTo-K+vxRovd36AuaEKUfBDQwgU86B9qwWWNVw@mail.gmail.com>
 <20211116101232.GA23464@quack2.suse.cz> <CAOQ4uxgfCmWCt=NNxj53+eKtVE-FMWBDNgFuQpGiFooZpne6zw@mail.gmail.com>
 <20211118162956.GA8267@quack2.suse.cz>
In-Reply-To: <20211118162956.GA8267@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Nov 2021 18:43:33 +0200
Message-ID: <CAOQ4uxhGt4ghy4sqoWN28akOi9B=brT6rGzE9ffOaLTHWJDJ9w@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 6:29 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-11-21 14:47:18, Amir Goldstein wrote:
> > > > So let's say this - we can add support for OLD_DFID, NEW_DFID types
> > > > later if we think they may serve a purpose, but at this time, I see no
> > > > reason to complicate the UAPI anymore than it already is and I would
> > > > rather implement only:
> > > >
> > > > /* Info types for FAN_RENAME */
> > > > #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
> > > > /* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
> > > > #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
> > > > /* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */
> > > >
> > > > Do you agree?
> > >
> > > I agree the utility of FAN_RENAME without FAN_REPORT_NAME is very limited
> > > so I'm OK with not implementing that at least for now.
> >
> > OK. The patches are staged at [1], but I ran into one more UAPI question
> > that I wanted to run by you before posting the patches.
> >
> > The question may be best described by the last commit on the tests branch [2]:
> >
> >     syscalls/fanotify16: Test FAN_RENAME with ignored mask
> >
> >     When a file is moved between two directories and only one of them is
> >     watching for FAN_RENAME events, the FAN_RENAME event will include only
> >     the information about the entry in the watched directory.
> >
> >     When one of the directories is watching FAN_RENAME, but the other is
> >     ignoring FAN_RENAME events, the FAN_RENAME event will not be reported
> >     at all.
> >
> >     This is not the same behavior as MOVED_FROM/TO events. User cannot
> >     request to ignore MOVED_FROM events according to destination directory
> >     nor MOVED_TO events according to source directory.
> >
> > I chose this behavior because I found it to be useful and consistent with
> > other behaviors involving ignored masks. Maybe "chose" is a strong word
> > here - I did not do anything to implement this specific behavior - it is just
> > how the code in fanotify_group_event_mask() works for merging masks
> > and ignored masks of different marks.
> >
> > Let me know if you approve of those ignored FAN_RENAME semantics
> > and I will post the patches for review.
>
> Yeah, I guess ignore masks with FAN_RENAME are going to be a bit
> non-intuitive either way and what you suggest makes sense. I suppose when
> SB has FAN_RENAME mark and either source or target have FAN_RENAME in the
> ignore mask, nothing will get reported as well, do it? If we are consistent
> like this, I guess fine by me.

Yes, that is correct, because the join of combined masks and combined
ignored_masks is done at the very end, if an event is in ignored mask of
any related mark, it will cause the drop of the event.

I will post patches soon.

Thanks,
Amir.
