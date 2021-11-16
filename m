Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77F1452B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhKPHCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 02:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhKPHCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:02:37 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31BC061570;
        Mon, 15 Nov 2021 22:59:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m9so24850708iop.0;
        Mon, 15 Nov 2021 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghYIh+h47ig7bjCiUjKIag3PhJ4kq9KCEqUuH4m0J4M=;
        b=Lb1Rt+4KnfxAuQqfBXlhNddJE8naBa35bev69ZjMWsKbwfSPJMpBqB2wXK/uCsv4EQ
         f83CjcL9sV/TjV7Ijgq1chxFk8s7g5bwMNY2/4vKc442c2BvYhVI3Bce3r1p1j+WoePh
         huk0s6dZcIHn6gFCrv8NzlQlgI6VrfLUm27Eah/T26FwTP9PoHuP2Il/V9gUKEImB7Mo
         8iabqwyXWvbK88CLkX3PPj0tje9dtmDZ+9O7CoRms36ZH06Jg/y1kph/RNPxh+Tnv9/s
         i73vDNYVdiuIAUApll3FZW0fLVGXhKK6t065nuhaNHLtTflMquWXtM2LDF818K14ZIT7
         CWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghYIh+h47ig7bjCiUjKIag3PhJ4kq9KCEqUuH4m0J4M=;
        b=Ia4S4JMTW9DqhD4adI3sqmoZR9aN/5vN61v+pM0iKZGXkUIadQxsTuZhRspFIXLlvt
         PwUjFX/7xrWTtLYP9atZmmqw+/50L46ZFsJ8lMu2UB6kTc0YR0oNSydTpixsNncJZoxG
         ith2mhaqLNK2oe/39kpd0jMZend+p2DivKsOUI93OvWNOOqSRXrvtQ1SJL/tPJAUvfR5
         gv9N130kekwstLvV52gmzO4B7SaWvWke8jOATIQrhW9ec75/KZRclV6qBLoHdxjkaEe4
         0HziTxA25yjJZCIXfMceGOvLSutND1CJFQ9zpVNEzR+tC2bjawqiyz8bsDWZiP+e8PD0
         8cfg==
X-Gm-Message-State: AOAM53314CwFkthZF0rvbYOpZP5kcvMKRZzq0upde4rEb7+slYX34W1r
        ySHkfT6gH4SKLH1xvlF+W1OoNg+c1h9tX5XjdJlN80cjLRA=
X-Google-Smtp-Source: ABdhPJxQdaSvWFYGQH44iXAw6fQWHIzTMXfz/hWNy5Xq2l9qkv2Bs/GOaVwp+0HsX4hRbhEMwx8N3QO7qkf4NrG0C3c=
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr3472767iow.112.1637045980786;
 Mon, 15 Nov 2021 22:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com> <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz> <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
 <20211115102330.GC23412@quack2.suse.cz> <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
 <20211115143750.GE23412@quack2.suse.cz>
In-Reply-To: <20211115143750.GE23412@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Nov 2021 08:59:29 +0200
Message-ID: <CAOQ4uxgBncZjuTo-K+vxRovd36AuaEKUfBDQwgU86B9qwWWNVw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I like it. However,
> > If FAN_RENAME can have any combination of old,new,old+new info
> > we cannot get any with a single new into type
> > FAN_EVENT_INFO_TYPE_DFID_NAME2
> >
> > (as in this posting)
>
> We could define only DFID2 and DFID_NAME2 but I agree it would be somewhat
> weird to have DFID_NAME2 in an event and not DFID_NAME.
>
> > We can go with:
> > #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME   6
> > #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME  7
> > #define FAN_EVENT_INFO_TYPE_OLD_DFID               8
> > #define FAN_EVENT_INFO_TYPE_NEW_DFID              9
> >
> > Or we can go with:
> > /* Sub-types common to all three fid info types */
> > #define FAN_EVENT_INFO_FID_OF_OLD_DIR     1
> > #define FAN_EVENT_INFO_FID_OF_NEW_DIR    2
> >
> > struct fanotify_event_info_header {
> >        __u8 info_type;
> >        __u8 sub_type;
> >        __u16 len;
> > };
> >
> > (as in my wip branch fanotify_fid_of)
>
> When we went the way of having different types for FID and DFID, I'd
> continue with OLD_DFID_NAME, NEW_DFID_NAME, ... and keep the padding byte
> free for now (just in case there's some extension which would urgently need
> it).
>
> > We could also have FAN_RENAME require FAN_REPORT_NAME
> > that would limit the number of info types, but I cannot find a good
> > justification for this requirement.
>
> Yeah, I would not force that.
>

On second thought and after trying to write a mental man page
and realizing how ugly it gets, I feel strongly in favor of requiring
FAN_REPORT_NAME for the FAN_RENAME event.

My arguments are:
1. What is the benefit of FAN_RENAME without names?
    Is the knowledge that *something* was moved from dir A to dir B
    that important that it qualifies for the extra man page noise and
    application developer headache?
2. My declared motivation for this patch set was to close the last (?)
    functional gap between inotify and fanotify, that is, being able to
    reliably join MOVED_FROM and MOVED_TO events.
    Requiring FAN_REPORT_NAME still meets that goal.
3. In this patch set, FAN_REPORT_NAME is required (for now) for
    FAN_REPORT_TARGET_FID to reduce implementation and test
    matrix complexity (you did not object, so I wasn't planning on
    changing this requirement).
    The same argument holds for FAN_RENAME

So let's say this - we can add support for OLD_DFID, NEW_DFID types
later if we think they may serve a purpose, but at this time, I see no
reason to complicate the UAPI anymore than it already is and I would
rather implement only:

/* Info types for FAN_RENAME */
#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
/* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
/* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */

Do you agree?

Thanks,
Amir.
