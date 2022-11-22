Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E15633D76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 14:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiKVNWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 08:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiKVNWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:22:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB864A23
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 05:22:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s12so20581813edd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/sCjPXYcERdUFAf8BFDSKgBVLXokJh6szjM4cUjXgmA=;
        b=KSEuPgkeLDFx6FYsGqZt/UYr0uIosAOKmpFkrxaLKtsOY5+ej3pisXTi+OgNsV2tc5
         X7EPDF1cH+SRhbRmSpljMikq0X3Nd3HMrpelRdGBkHi3NxVQcSAgp3UtxrIgWhjUy9MR
         tDHzrhB0bQUiZVjOwaP+jKkQTKz8CAaDc++o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sCjPXYcERdUFAf8BFDSKgBVLXokJh6szjM4cUjXgmA=;
        b=56IwYZy6LuMAAJ2OB9/ukvRsI/xLCqo3ci3Xg9+yfPcXFgHlY3ojrBdV2cLI1r57Ws
         5H5DziEcxd3NKFg6q94+SL33Ayuqz8apECxhDwVAXb7iSPpw6Gq+vi/1I9/LAFZVwx6t
         PmQNeQxlYItakO+nBbJFsCstai9x6QKIlxvWijmWeDNvUshz+EaAPrkkPjAp7w4UHIyM
         YQ5H6/ifPVtu8sI3v/HSvaMhlHLH/bT4m3UlCgIVdPya28IzJRkaDYoPlhN1vEcCgNmh
         MAqZ8fcvDOPAwNhRmI0rAZJ4bHepEwBbJoIeau8hbhzSnTJV+ae9WShNQot2OXl96cvJ
         JPMw==
X-Gm-Message-State: ANoB5pmMJz7ydt29vax41ZsR0QiMtsqvYBYCBYoZ9W0AiSHb9i4LbNgg
        OHxQRJVaqudPOn35Va4BhkoNXkr+rSuKKkgC2YUPOnwrRKv/sQ==
X-Google-Smtp-Source: AA0mqf6XNmKoz1/v1Yn3asFCskWN6U6gPib0+ZdXymzfWvdueG40uKICckVoDbTK7xzxC1ySOTBF5nU7PeIfQOpiOus=
X-Received: by 2002:a05:6402:4507:b0:467:205b:723d with SMTP id
 ez7-20020a056402450700b00467205b723dmr899561edb.69.1669123330879; Tue, 22 Nov
 2022 05:22:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegsVAUUg5p6DbL1nA_oRF4Bui+saqbFjjYn=VYtd-N2Xew@mail.gmail.com>
 <20221122105731.parciulns5mg4jwr@wittgenstein>
In-Reply-To: <20221122105731.parciulns5mg4jwr@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Nov 2022 14:21:59 +0100
Message-ID: <CAJfpegvtgFBesiuGO93HRidWw22gQgi8VN8xNGqK86qEm3sfng@mail.gmail.com>
Subject: Re: sgid clearing rules?
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, fstests <fstests@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Nov 2022 at 11:57, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 02:14:13PM +0100, Miklos Szeredi wrote:
> > I'm looking at sgid clearing in case of file modification.  Seems like
> > the intent was:
> >
> >  - if not a regular file, then don't clear
> >  - else if task has CAP_FSETID in init_user_ns, then don't clear
>
> This one is a remnant of the past. The code was simply not updated to
> reflect the new penultimate rule you mention below. This is fixed in
> -next based on the VFS work we did (It also includes Amirs patches we
> reviewed a few weeks ago for file_remove_privs() in ovl.).
>
> >  - else if group exec is set, then clear
> >  - else if gid is in task's group list, then don't clear
> >  - else if gid and uid are mapped in current namespace and task has
> > CAP_FSETID in current namespace, then don't clear
> >  - else clear
> >
>
> The setgid stripping series in -next implements these rules.
>
> > However behavior seems to deviate from that if group exec is clear and
> > *suid* bit is not set.  The reason is that inode_has_no_xattr() will
> > set S_NOSEC and __file_remove_privs() will bail out before even
> > starting to interpret the rules.
>
> Great observation. The dentry_needs_remove_privs() now calls the new
> setattr_should_drop_sgid() helper which drops the setgid bit according
> to the rules above. And yes, we should drop the S_IXGRP check from
> is_sxid() for consistency.
> The scenario where things get wonky with the S_IXGRP check present must
> be when setattr_should_drop_sgid() retains the setgid bit.

Which is exactly what seems to happen in Test 9 and Test 11 in the
generic/68[3-7].

> In that case
> is_sxid() will mark the inode as not being security relevant even though
> the setgid bit is still set on it. This dates back to mandatory locking
> when the setgid bit was used for that. But mandatory locks are out of
> the door for a while now and this is no longer true and also wasn't
> enforced consistently for countless years even when they were still
> there. So we should make this helper consistent with the rest.
>
> I will run the patch below through xfstests with
>
> -g acl,attr,cap,idmapped,io_uring,perms,unlink
>
> which should cover all setgid tests (We've added plenty of new tests to
> the "perms" group.). Could you please review whether this make sense to you?
>
> From cbe6cec88c6cfc66e0fb61f602bb2810c3c48578 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Tue, 22 Nov 2022 11:40:32 +0100
> Subject: [PATCH] fs: use consistent setgid checks in is_sxid()
>
> Now that we made the VFS setgid checking consistent an inode can't be
> marked security irrelevant even if the setgid bit is still set. Make
> this function consistent with the other helpers.
>
> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b39c5efca180..d07cadac547e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3527,7 +3527,7 @@ int __init list_bdev_fs_names(char *buf, size_t size);
>
>  static inline bool is_sxid(umode_t mode)
>  {
> -       return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
> +       return (mode & S_ISUID) || ((mode & S_ISGID));

Yes, this is what I meant.  This can be simplified to:

       return mode & (S_ISUID | S_ISGID);

Thanks,
Miklos
