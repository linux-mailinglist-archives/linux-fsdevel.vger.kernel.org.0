Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7688067
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 18:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406889AbfHIQnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 12:43:23 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46986 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHIQnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:43:23 -0400
Received: by mail-yb1-f193.google.com with SMTP id w196so7941303ybe.13;
        Fri, 09 Aug 2019 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee6sLT3QKOZ9HPHIVStB6Oq32MyzNxKnALFXSGrvSq8=;
        b=TVc46H13EkACc3tRJRH6cBRCNVjYa2zB2vR159T3lp5a1c5olUpKlZnIBVNszXgoH1
         4ZYzEqbf51kW6xTSVXjf7JFshEao6DydD6v4wZxngF1uvPtjQXNQMOVBZLBEiMxeSLau
         hDXQqmkPTnFuZEwaZXzfFWhQfdcikA9mAgaYFLwvdykxKXrjT38hchsN1ZvScRI7A41Z
         P1T6mxZFb6e/57eIJAg7SIwC4HVvhyTPbawIBCEmk9ff7DLLmJAady1ToLm9I7mmbgpq
         kxma1KWCJkIGeLivc9Dq/zhamVaRBUDGvIlg8VVOQqmgE+/2vVR8puFkGJxMpl6LT07R
         uXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee6sLT3QKOZ9HPHIVStB6Oq32MyzNxKnALFXSGrvSq8=;
        b=ilKmT8Eimd75aULfsNj9ou5YEoBNW2P23zdsKDxla61bm/zUJmxrbgc9O8R92vU24X
         EU6OY2++g8p1tu86QLb0jwB/0TgYKc/U92a5xOYGn7xcD+jwExcLsI9YF9nZpab23NLd
         sSEdO8Xh8VOaAp9KdAyh2iUup4oD2Cd0H7mghMaIaTmgBp3Yjv8w/rSm437IfHVwTM/T
         CHYsmTNTzSTkob6ygikMHldM8ZQJPudQ/KdJ0c40WQY8xYZ4ayM+EJhcJwq0KucmoSEp
         nP+X4HUOCRuTi5BCd/WkMjcOa1Hlgvk0oHlF/DTDHOLgXv3L3x3+lk7L0oHh7pU85Tn4
         uv0g==
X-Gm-Message-State: APjAAAWzBgJdvoOq7c5D+kODTSsZjZL7gOqtg8JGHBUvusb2ZOJuZuNc
        sUvZqKM7WpPl0n50YoRvBASchVe1zya4SNHe9r0=
X-Google-Smtp-Source: APXvYqyWd8Bd2MlCSQQlILPFLseAUONgO+0QnP6HjK5IX+v5Uz2uOP3Djl3F53pUiWu2hsshGUt7B65HXUjxQqXWX6U=
X-Received: by 2002:a25:d44c:: with SMTP id m73mr9201782ybf.126.1565369002163;
 Fri, 09 Aug 2019 09:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com> <e69f95ba-3da7-380a-ef14-cc866172d79a@tycho.nsa.gov>
In-Reply-To: <e69f95ba-3da7-380a-ef14-cc866172d79a@tycho.nsa.gov>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Aug 2019 19:43:09 +0300
Message-ID: <CAOQ4uxh4+SDCF7HHwSxGFx01ZyJ43VSLhLM2dDFY2AQ0HkkuvA@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [PATCH] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >>> +       switch (flags & FANOTIFY_MARK_TYPE_BITS) {
> >>> +       case FAN_MARK_MOUNT:
> >>> +               obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
> >>> +               break;
> >>> +       case FAN_MARK_FILESYSTEM:
> >>> +               obj_type = FSNOTIFY_OBJ_TYPE_SB;
> >>> +               break;
> >>> +       case FAN_MARK_INODE:
> >>> +               obj_type = FSNOTIFY_OBJ_TYPE_INODE;
> >>> +               break;
> >>> +       default:
> >>> +               ret = -EINVAL;
> >>> +               goto out;
> >>> +       }
> >
> > Sorry, I just can't stand this extra switch statement here.
> > Please initialize obj_type at the very first switch statement in
> > do_fanotify_mark() and pass it to fanotify_find_path().
> > Preferably also make it a helper that returns either
> > valid obj_type or <0 for error.
> >
> >
> I have no problem moving the initialization of obj_type up one level to
> do_fanotify_mark(). I don't think that a helper is necessary at this
> juncture as this logic seems to only exist in one place. Should this
> change, then there would be merit to having a separate function.

Ok.

> >>> +
> >>> +       ret = security_path_notify(path, mask, obj_type);
> >>>          if (ret)
> >>>                  path_put(path);
> >
> > It is probably best to mask out FANOTIFY_EVENT_FLAGS
> > when calling the hook. Although FAN_EVENT_ON_CHILD
> > and FAN_ONDIR do map to corresponding FS_ constants,
> > the security hooks from dnotify and inotify do not pass these
> > flags, so the security module cannot use them as reliable
> > information, so it will have to assume that they have been
> > requested anyway.
> >
> > Alternatively, make sure that dnotify/inotify security hooks
> > always set these two flags, by fixing up and using the
> > dnotify/inotify arg_to_mask conversion helpers before calling
> > the security hook.
> >
> I think that at this point either approach you mentioned makes just as
> much sense. If it's all the same to you, Amir, I'll just change the
> caller in fanotify to include (mask) & ~(FANOTIFY_EVENT_FLAGS)

On second look, let's go with (mask & ALL_FSNOTIFY_EVENTS)
It seems simpler and more appropriate way to convert to FS_ flags.

[...]
> >>>
> >>> -       ret = inotify_find_inode(pathname, &path, flags);
> >>> +       ret = inotify_find_inode(pathname, &path, flags, mask);
> >
> > Please use (mask & IN_ALL_EVENTS) for converting to common FS_ flags
> > or use the inotify_arg_to_mask() conversion helper, which contains more
> > details irrelevant for the security hook.
> > Otherwise mask may contain flags like IN_MASK_CREATE, which mean
> > different things on different backends and the security module cannot tell
> > the difference.
> >
> > Also note that at this point, before inotify_arg_to_mask(), the mask does
> > not yet contain FS_EVENT_ON_CHILD, which could be interesting for
> > the security hook (fanotify users can opt-in with FAN_EVENT_ON_CHILD).
> > Not a big deal though as security hook can assume the worse
> > (that events on child are requested).
> >
> I'll use (mask & IN_ALL_EVENTS).

OK.

>
> I can implement the changes in the ways I mentioned above. I don't see a
> need for anything more in the cases you brought up since none of them
> change the logic of the hook itself or would make a substantive
> difference to the operation of the hook given its current implementation.
>

Agree. If more flags are needed for LSMs they could be added later.

Thanks,
Amir.
