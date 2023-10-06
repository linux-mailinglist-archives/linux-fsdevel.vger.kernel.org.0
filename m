Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A467BC2D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 01:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjJFXII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjJFXIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:08:07 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0654A2
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 16:08:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d90da64499cso2951118276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696633684; x=1697238484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F50fu8DXl9ERFHVYVt4zY9h1hnn4ptAJ3MO5xm3ht8M=;
        b=DSWU7Th6ZPr/C9XYfy2ArD7EwQYRdfx5NerMmWa6VeiCNw24YRrs4c7/Vfca2xgG4O
         aiv44TiryMe03QX0qA4WsJTNRtLHaZmTv5GAFT+E90Slc9yUpNis1hUvIqujMk9dy+Lu
         whWgQoQmCxAp1reO223+nIWNoses+CDen4cXjYYHWeYzLJ0XgXhVLoiKgmVihZ7t0VBF
         KVUvLeTTU1rCg0CZsgE8hY/Wnvf7cl6RkUSwfcA/M9AgkF8uRT5sXVjkWFUGMQ7x9ArI
         g9ogSHC6U/qeV7Vb1LKQIgnT0KsuxnywtMV2ZAYQh0Qi2tCddZbyOa0V2URk+/YnNPYn
         rhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696633684; x=1697238484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F50fu8DXl9ERFHVYVt4zY9h1hnn4ptAJ3MO5xm3ht8M=;
        b=YbOb/6avKsj6qHmhrd47G776jkjnl4075ZOLw6FrxaPl693vhXXY3Xw99mbs75r3zh
         GvRFdvCDR6iYj1e7ZZNoe0kdK2WO3GwEeyX/d7NuWSeYw7xa1orlXCZu2tRVvAkVdiD5
         MPtZNanJhLvOUcLqxB9ZQoUQuFcaG5hmGTaCn5ZtEWCmXcB+YZZOjDKAXZdCyZbNhCOk
         kel8CrTzfKK5meTRp231MuJnTJGrUmscZPqKzrAHJ0nzUxWhbroWM5eLscnbXHukgYCA
         fiXa/Y5OWRhUmf9p7zOrj2eOEYoywBNUIHLsl4pjavDOeBl0GoJP0BXVWKsZLu02wCt9
         aJ/g==
X-Gm-Message-State: AOJu0YznmbZmhJCcrcmPe2PxbGQ6C/1LHS9kTICKsUb0dnhFJTh+plo/
        EdUqHRzJfrPisYFLCLZ2fBLaSVJii18lvnvay4hY
X-Google-Smtp-Source: AGHT+IFptmDYsPUwJNXgzo/KC+xeqdAaTYpkEhIAeXQIc7ZwVI4dQTLTBID85bUW0YeCyFWkPLg7ZtNgHG2nI/ZPkQI=
X-Received: by 2002:a25:b31a:0:b0:d4b:ab7b:17ed with SMTP id
 l26-20020a25b31a000000b00d4bab7b17edmr8590362ybj.4.1696633683762; Fri, 06 Oct
 2023 16:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <CAHC9VhTwnjhfmkT5Rzt+SBf-8hyw4PYkbuPYnm6XLoyY7VAUiw@mail.gmail.com> <CAJfpegsZqF4TnnFBsV-tzi=w_7M=To5DeAjyW=cei9YuG+qMfg@mail.gmail.com>
In-Reply-To: <CAJfpegsZqF4TnnFBsV-tzi=w_7M=To5DeAjyW=cei9YuG+qMfg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Oct 2023 19:07:52 -0400
Message-ID: <CAHC9VhS5cRA3FFWAttuy-tNP=p+Rk1O3Sq8Np29jenFQprFi4A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 6, 2023 at 4:53=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
> On Fri, 6 Oct 2023 at 04:56, Paul Moore <paul@paul-moore.com> wrote:
>
> > > Also I cannot see the point in hiding some mount ID's from the list.
> > > It seems to me that the list is just an array of numbers that in
> > > itself doesn't carry any information.
> >
> > I think it really comes down to the significance of the mount ID, and
> > I can't say I know enough of the details here to be entirely
> > comfortable taking a hard stance on this.  Can you help me understand
> > the mount ID concept a bit better?
>
> Mount ID is a descriptor that allows referring to a specific struct
> mount from userspace.
>
> The old 32 bit mount id is allocated with IDA from a global pool.
> Because it's non-referencing it doesn't allow uniquely identifying a
> mount.  That was a design mistake that I made back in 2008, thinking
> that the same sort of dense descriptor space as used for file
> descriptors would work.  Originally it was used to identify the mount
> and the parent mount in /proc/PID/mountinfo.  Later it was also added
> to the following interfaces:
>
>  - name_to_handle_at(2) returns 32 bit value
>  - /proc/PID/FD/fdinfo
>  - statx(2) returns 64 bit value
>
> It was never used on the kernel interfaces as an input argument.

Thanks for the background.

> statmount(2) and listmount(2) require the mount to be identified by
> userspace, so having a unique ID is important.  So the "[1/4] add
> unique mount ID" adds a new 64 bit ID (still global) that is allocated
> sequentially and only reused after reboot.   It is used as an input to
> these syscalls.  It is returned by statx(2) if requested by
> STATX_MNT_ID_UNIQUE and as an array of ID's by listmount(2).
>
> I can see mild security problems with the global allocation, since a
> task can observe mounts being done in other namespaces.  This doesn't
> sound too serious, and the old ID has similar issues.  But I think
> making the new ID be local to the mount namespace is also feasible.

The LSM hook API is designed to operate independently from any of the
kernel namespaces; while some LSMs may choose to be aware of
namespaces and adjust their controls accordingly, there is no
requirement that they do so.  For that reason, I'm not too bothered
either way if the mount ID is global or tied to a namespace.

> > While I'm reasonably confident that we want a security_sb_statfs()
> > control point in statmount(), it may turn out that we don't want/need
> > a call in the listmount() case.  Perhaps your original patch was
> > correct in the sense that we only want a single security_sb_statfs()
> > call for the root (implying that the child mount IDs are attributes of
> > the root/parent mount)?  Maybe it's something else entirely?
>
> Mounts are arranged in a tree (I think it obvious how) and
> listmount(2) just lists the IDs of the immediate children of a mount.
>
> I don't see ID being an attribute of a mount, it's a descriptor.

In this case I think the approach you took originally in this thread
is likely what we want, call security_sb_statfs() against the root
mount in listmount().  Just please move it after the capability
checks.

If you look at the two LSMs which implement the security_sb_statfs(),
Smack and SELinux, you see that Smack treats this as a read operation
between the current process and the specified mount and SELinux treats
this as a filesystem:getattr operations between the current process
and the specified mount.  In both cases I can see that being the right
approach for reading a list of child mounts off of a root mount.

Does that sound good?  I'm guessing that's okay since that was how you
wrote it in your original patch, but there has been a lot of
discussion since then :)

--=20
paul-moore.com
