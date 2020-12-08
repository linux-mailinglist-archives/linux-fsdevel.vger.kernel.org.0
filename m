Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6B2D2BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 14:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgLHNLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 08:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgLHNLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:11:47 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA9C0613D6;
        Tue,  8 Dec 2020 05:11:07 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z5so16814874iob.11;
        Tue, 08 Dec 2020 05:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+2JK7WUi1s6OvUkjUgpQQ86loaPhMWjeKRerZE2QiM=;
        b=q5DltdxEBuRdxEjSW5ui4bJdKE3KtX2fYObyDScm+OElPdw5yJEIK+uAhuvzJkINox
         LpSrWXbhAkIK68WR6hPEEVx4Ha4bS1iVzUjlHQIKuLZIV0jiBjwJkHtzpsXpKsMEv1Gs
         dTIAEnI/nN8hLNoO3TJBhe8wdw4QrR0RnEM1FZstbZnj+svgtwIr/biAa2IfKLuEP8Sl
         dp2WHP44XfkmpwWR0Opq8hc0hBpYrWSFUJAZTMEzJKLeq8HUtx1H5Dwlao++1d07yMgl
         3PqNrVHgRtRY6v+6GnV64PLjNPfjNQ+qQenhe3VHizgOKn9QFNZCbhDn9e4wgXXNra+/
         DI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+2JK7WUi1s6OvUkjUgpQQ86loaPhMWjeKRerZE2QiM=;
        b=cjbQTTAZ87mBJXgJ0bVp4xMNtdd4BKTG9KBJ902sLp9j8iKgB8VXFcn4hSg0LJnkYh
         BAp4dHnV/nKO1NsOjK8oUeMDwRh0wMKPklPRHHPhHSJfKf7XbQcaGNekcxoA4ckvOKmh
         KNNpJDRpq8bXO1r/v782ASKl3v4rvV7ainpZoaldfYI+AlSVyIV3dwKA2Q6RSM2/xCt2
         X1SwEa2kpO8lP3KI8mwexWN2/Jyf4xHlkxYqm1xJbQmwhCOqfNsHMHLh0873cE+aKr9K
         4+StK9siJPV+DEoNfPWUvRDpnUWH0gDb/DGZi1dxNOtenFpAjL+RJ26tEb0lFy1HEybB
         4Z1g==
X-Gm-Message-State: AOAM530eYmZtKivJg9hL5AvVHwqFeZ3TzCtFtwkyzRnb297r26+o67nQ
        jJIjw/8O6NfhGtmoFqM1wPLk6YgJ21pJ6Y0DxzY=
X-Google-Smtp-Source: ABdhPJygl+TeYwTKx30NJSjrFuvt69fAN+MMMPhzT5BfqHx3Lnj/QzLeUnUNOhTqK2JK1aDEIerl085xLQpJ3d4YPLU=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr23499554jal.30.1607433066622;
 Tue, 08 Dec 2020 05:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-7-mszeredi@redhat.com>
In-Reply-To: <20201207163255.564116-7-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Dec 2020 15:10:55 +0200
Message-ID: <CAOQ4uxju9wLCq5mqPLgo0anD+n7DLnmHzJ=SymFTRc0c_uVY4Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ovl: user xattr
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 6:37 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Optionally allow using "user.overlay." namespace instead of
> "trusted.overlay."

There are several occurrences of "trusted.overlay" string in code and
Documentation, which is fine. But maybe only adjust the comment for
testing xattr support:

         * Check if upper/work fs supports trusted.overlay.* xattr

>
> This is necessary for overlayfs to be able to be mounted in an unprivileged
> namepsace.
>
> Make the option explicit, since it makes the filesystem format be
> incompatible.
>
> Disable redirect_dir and metacopy options, because these would allow
> privilege escalation through direct manipulation of the
> "user.overlay.redirect" or "user.overlay.metacopy" xattrs.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -582,9 +582,10 @@ bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
>  #define OVL_XATTR_METACOPY_POSTFIX     "metacopy"
>
>  #define OVL_XATTR_TAB_ENTRY(x) \
> -       [x] = OVL_XATTR_PREFIX x ## _POSTFIX
> +       [x] = { [false] = OVL_XATTR_TRUSTED_PREFIX x ## _POSTFIX, \
> +               [true] = OVL_XATTR_USER_PREFIX x ## _POSTFIX }
>
> -const char *ovl_xattr_table[] = {
> +const char *ovl_xattr_table[][2] = {
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_OPAQUE),
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_REDIRECT),
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_ORIGIN),
> --

Can you constify this 2D array? I don't even know the syntax for that...

Thanks,
Amir.
