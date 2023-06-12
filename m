Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA172B9C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjFLIGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjFLIGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:06:01 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501830CD;
        Mon, 12 Jun 2023 01:05:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bc4e167c4b2so2051008276.3;
        Mon, 12 Jun 2023 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686557120; x=1689149120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4exatAjzA6+D9Buih0I3sDbrZV0bAmcGM6sRCZZP0s=;
        b=cT6rdEQT00fiZ35VoilxxrjDLm+iSTFVqgNKddM4pgcIoLZh+MWjLraQp0HLlYSmuM
         tK1FSb62+By2+8zffuozV5Fj0P6idUxM9eGvPdu+4UojI09Fhn9UlP1bUBZXb34L/rXR
         W74t6E0EKsXP7A/ZJKlcFMUBhDiXEO8J1yzEq1l7RS7IXAUEuuvFO4Mn/kOqtAXMSClL
         6BFE02R4AfHxPJ+qKRtNzwZA1S9Fv38uWeFNjLjpJm2DAG6RtHOo/09O/wDz41gv3qxS
         6S1rEANOfpbYkErIvgsdyuSUgHR2PkgxaQ52ifcxE8ddfzHnybB17JKEwBUvPGiPQ9qE
         fm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557120; x=1689149120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4exatAjzA6+D9Buih0I3sDbrZV0bAmcGM6sRCZZP0s=;
        b=hkL1gqJUgu2EzFbE/LMAdSE+ki14uiZUXCS7mstzQ4da5N0kxJspGe7ixVQIrn7EbU
         ntfX5sBzPblFJsf0pDDVd5ofyPpb0Hr6HUrELV3Q8pXlZXEd9KXnkq3AAHugvqKVLgKe
         wOMiUyCwVEhAPMT8C6y9gMg1kuPKv+YzkYlz74g+79PpNV6Pzxd4TMcGGL0SvozZb4Ge
         w3hw4uJEPtpHnufGbPptkxIiaFo/VmMs8CWlKsxqhB/OWYN/2KIRTUNzZNYgIcAtAIxU
         uGou4grbn6tcfBzhCf3HpFltB0+B8egEDu8bsy7wfQaFrH3fauyacvG6esPveRi609zp
         VmBg==
X-Gm-Message-State: AC+VfDwjl5xBVdO6DXy+WfW8Q52HD4xx8L/LbNQbPJzHkm1mRYVaxHTx
        oFOXS8RdZ52YKBQ3WoQCap124ykhlccr5yiMcMbTEHGCQDI=
X-Google-Smtp-Source: ACHHUZ5MqUvpUdY0rwaAId/Ti6yvLpoO7CSrnFVfnXENtwlYP8lB028tL69I1eya+xT8fE0v2bTS85eKcRtR4b1md8M=
X-Received: by 2002:a05:6358:c122:b0:129:b96d:1b0d with SMTP id
 fh34-20020a056358c12200b00129b96d1b0dmr3266805rwb.1.1686551882745; Sun, 11
 Jun 2023 23:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230611194706.1583818-1-amir73il@gmail.com> <20230611194706.1583818-2-amir73il@gmail.com>
 <ZIai+UWrU9o2UVcJ@infradead.org>
In-Reply-To: <ZIai+UWrU9o2UVcJ@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 09:37:51 +0300
Message-ID: <CAOQ4uxj0WjQHNN6qHEnXfijYSoiaZkCucvNQYTL4LH0TPLt28A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Mon, Jun 12, 2023 at 7:45=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > files, where overlayfs also puts a "fake" path in f_path - a path which
> > is not on the same fs as f_inode.
>
> But cachefs doesn't, so this needs a better explanation / documentation.
>
> > Allocate a container struct file_fake for those internal files, that
> > is used to hold the fake path along with an optional real path.
>
> The idea looks sensible, but fake a is a really weird term here.
> I know open_with_fake_path also uses it, but we really need to
> come up with a better name, and also good documentation of the
> concept here.
>
> > +/* Returns the real_path field that could be empty */
> > +struct path *__f_real_path(struct file *f)
> > +{
> > +     struct file_fake *ff =3D file_fake(f);
> > +
> > +     if (f->f_mode & FMODE_FAKE_PATH)
> > +             return &ff->real_path;
> > +     else
> > +             return &f->f_path;
> > +}
>
> two of the three callers always have FMODE_FAKE_PATH set, so please
> just drop this helper and open code it in the three callers.
>

I wanted to keep the container opaque
I can make __f_real_path not check the flag at all
and only f_real_path will check the flag

> > +
> > +/* Returns the real_path if not empty or f_path */
> > +const struct path *f_real_path(struct file *f)
> > +{
> > +     const struct path *path =3D __f_real_path(f);
> > +
> > +     return path->dentry ? path : &f->f_path;
> > +}
> > +EXPORT_SYMBOL(f_real_path);
>
> This is only needed by the few places like nfsd or btrfs send
> that directlycall fsnotify and should at very least be
> EXPORT_SYMBOL_GPL.  But I suspect with all the exta code, fsnotify_file
> really should move out of line and have an EXORT_SYMBOL_GPL instead.
>

fsnotify_file() inline is expected to avoid to call to fsnotify()
due to the optimization of zero s_fsnotify_connector
in fsnotify_parents() - this was observed as needed by some benchmarks.

> > +
> > +const struct path *f_fake_path(struct file *f)
> > +{
> > +     return &f->f_path;
> > +}
> > +EXPORT_SYMBOL(f_fake_path);
>
> .. and this helper is completely pointless.
>
> > +extern struct file *alloc_empty_file(int flags, const struct cred *cre=
d);
> > +extern struct file *alloc_empty_file_fake(int flags, const struct cred=
 *cred);
> > +extern struct path *__f_real_path(struct file *f);
>
> Please drop all the pointless externs while you're at it.

sure,

Thanks,
Amir.
