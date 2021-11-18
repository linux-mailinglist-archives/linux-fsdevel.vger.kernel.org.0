Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF7455BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 13:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbhKRMu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 07:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbhKRMua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:50:30 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BDC061570;
        Thu, 18 Nov 2021 04:47:29 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id j21so726050ila.5;
        Thu, 18 Nov 2021 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOSwBO35slekigbZcDgizmAC1tZ+7ySUJIY2iAfBZu4=;
        b=YvshVZqh+D5T+Vx4mseURvI33zparPTiH9eDqnfJhlNXNa5V8nbnjFTPfWjgv+x63F
         EYKi/TmJKj3uU4VgHSZld7BKG0D58n2TrCnVqc00C5cIuCnVaoiUCvrnx5ceQNU20BCn
         FtOOf42Dc/4nhmBCMZDnc7UG6b8cC7LQaYIyVutdcmTrNx/1Y0YqM9pD29j/oNIcoPsk
         boQxRUjhNqs1A8bw8FWSw+mm4aAZ9qfw8IkQiwbTcJ9eijZpbvMFiAmEINqWRCtHqzGk
         i4dBCTzofGSnNgCxDVX5VDx4KbICk5c+IH0B2jEsd4zTD2EzRUZEU2rSRVe+znpPhevP
         se2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOSwBO35slekigbZcDgizmAC1tZ+7ySUJIY2iAfBZu4=;
        b=r9appRAP+A0xfuW7J7YikoKIVmnR6GrvVoL1tQyGUuhbtWbY3ktWeIrU8V6SLofGoG
         FEajedxnFFDszAybKYeKJ9u+pbssTULEnVgOkQH9RT6f+rzGm53yPIai+P0Pzhqx4C94
         nya9LMtj8odD/KwrSZURoSaYzgE7eyF+8pjO8kzXAHp8It9s2axUOOo/XoWTL3jXPUUr
         +bUd4TBJj23O6ptPuO0RSRlejXJZ5oOk8aCzVg8tLfc+LM6BFhahprpq7hlyPhypnDgh
         nRENZ24Q7f1ZFORi58KIGqQZWnwSN/mAGJYm9zgdkeu+cZXrY8wFPAnyL+mDtXBQ3Y5+
         5HGw==
X-Gm-Message-State: AOAM532LPkaAVyiFTjq49scgMZuPQi9r0/f7JocZkDsJ4AlNKYtwVKqo
        +yzMNNU0VN8bPozTYRtpotWwrIUDdcS8Tzb7GcZAfHvbf1Y=
X-Google-Smtp-Source: ABdhPJzVN0S5TFAgjgrwUtrnbVZABF2NSUQtuq7JC+8ckqt3swNAjcpAD5L2+Jajk9X0X8eyJBZ5rELld8yxSaYLPFk=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id n6mr16082197ili.254.1637239649335;
 Thu, 18 Nov 2021 04:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com> <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz> <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
 <20211115102330.GC23412@quack2.suse.cz> <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
 <20211115143750.GE23412@quack2.suse.cz> <CAOQ4uxgBncZjuTo-K+vxRovd36AuaEKUfBDQwgU86B9qwWWNVw@mail.gmail.com>
 <20211116101232.GA23464@quack2.suse.cz>
In-Reply-To: <20211116101232.GA23464@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Nov 2021 14:47:18 +0200
Message-ID: <CAOQ4uxgfCmWCt=NNxj53+eKtVE-FMWBDNgFuQpGiFooZpne6zw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > So let's say this - we can add support for OLD_DFID, NEW_DFID types
> > later if we think they may serve a purpose, but at this time, I see no
> > reason to complicate the UAPI anymore than it already is and I would
> > rather implement only:
> >
> > /* Info types for FAN_RENAME */
> > #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
> > /* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
> > #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
> > /* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */
> >
> > Do you agree?
>
> I agree the utility of FAN_RENAME without FAN_REPORT_NAME is very limited
> so I'm OK with not implementing that at least for now.

OK. The patches are staged at [1], but I ran into one more UAPI question
that I wanted to run by you before posting the patches.

The question may be best described by the last commit on the tests branch [2]:

    syscalls/fanotify16: Test FAN_RENAME with ignored mask

    When a file is moved between two directories and only one of them is
    watching for FAN_RENAME events, the FAN_RENAME event will include only
    the information about the entry in the watched directory.

    When one of the directories is watching FAN_RENAME, but the other is
    ignoring FAN_RENAME events, the FAN_RENAME event will not be reported
    at all.

    This is not the same behavior as MOVED_FROM/TO events. User cannot
    request to ignore MOVED_FROM events according to destination directory
    nor MOVED_TO events according to source directory.

I chose this behavior because I found it to be useful and consistent with
other behaviors involving ignored masks. Maybe "chose" is a strong word
here - I did not do anything to implement this specific behavior - it is just
how the code in fanotify_group_event_mask() works for merging masks
and ignored masks of different marks.

Let me know if you approve of those ignored FAN_RENAME semantics
and I will post the patches for review.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_rename
[2] https://github.com/amir73il/ltp/commits/fan_rename
