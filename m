Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6E2FE05E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbhAUEGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbhAUECi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:02:38 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A45C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:01:58 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a109so426059otc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JBhf6T6zX2oTtgPljMvGlrceEDM0Ksq1E4i/KwvqR8s=;
        b=LYdPdG3GE3bjQa7bfgy0ObHq5c0fz+/XYbIiMVKhOkdabUMgLYbRuAfjmd9J8LO9Iq
         oXrFUpVOHla4sPcgbES98rG5hl7yMxE69Raugb0hJHTTFbBKgFlHpOFDnViBs3yy9CO4
         fo71j8AMbzLljrP0ESd7jbHP3VybrgxMebJL0JtFhm+evEjxA6hfYDoekJTo3XYBgnrV
         /N0cLTHeiJsjBGL/KI3J802CAS82BAmr9E3XBEWl8FF5bTBZ+ulDhyVrIKCL8vcCbuyF
         14HbUux8dELvo1C3huxCCXF2qsoFeGYJ9WbkHHaG7SVOjt9oNToeit3vHR7kDY6EWaO2
         0zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JBhf6T6zX2oTtgPljMvGlrceEDM0Ksq1E4i/KwvqR8s=;
        b=KGcjohY/wZlNWKhXAGVUB/4ceU1Qj6+DphPGD5DNRhglDTxFvc6p9xGlyBp8723nIQ
         +yqD448FcGYevGJEzBrMbpGRrug+5f1AGhT1cddlXnb8/7LmgrnjbhlVPhPkL26qFyUf
         /VQLVIFOg9RIpoFee/8yoqdQ2yAyI6l+sqPi7AihhpIop1I9uJNTdGGavfMCApV85ZDU
         amSoHV6hIwV5AKQTwcypQ5DZ+7johCKIuG9PyFXxalXKDNr1bqryWQhOsnOW5df8jZ9H
         IEE/lgwZ3exxwLDDH2IHnJSsdsDcJmH7JzbiEXChQSEiNdzGfsGmUdUSB8NUlXy9iHM2
         rHGA==
X-Gm-Message-State: AOAM5300zBDNN6FTvspWcugKjvFQktGWlZXdX5TNN+HieZnnlZIHMKs7
        VCzyNChE8pWJNTwpYhJlKu+0rg==
X-Google-Smtp-Source: ABdhPJwkc4737QukYHvMY7wDRCwqKMRyoKvTOx6vGp4x2nFGN0M5vdJ8eGfaGeFcBMOEBQQktk4ksw==
X-Received: by 2002:a9d:6f08:: with SMTP id n8mr8908943otq.137.1611201716976;
        Wed, 20 Jan 2021 20:01:56 -0800 (PST)
Received: from vyachessmacbook.attlocal.net ([2600:1700:42f0:6600:2906:5359:dd82:b003])
        by smtp.gmail.com with ESMTPSA id w5sm182744ote.29.2021.01.20.20.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:01:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [RFC] Filesystem error notifications proposal
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <87lfcne59g.fsf@collabora.com>
Date:   Wed, 20 Jan 2021 20:01:51 -0800
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        david@fromorbit.com, darrick.wong@oracle.com, khazhy@google.com,
        Linux FS devel list <linux-fsdevel@vger.kernel.org>,
        kernel@collabora.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4474C4D0-87E2-4437-9546-9842CC2645D2@dubeyko.com>
References: <87lfcne59g.fsf@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 20, 2021, at 12:13 PM, Gabriel Krisman Bertazi =
<krisman@collabora.com> wrote:
>=20
>=20
> My apologies for the long email.
>=20
> Please let me know your thoughts.
>=20
> 1 Summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  I'm looking for a filesystem-agnostic mechanism to report filesystem
>  errors to a monitoring tool in userspace.  I experimented first with
>  the watch_queue API but decided to move to fanotify for a few =
reasons.
>=20

I don=E2=80=99t quite follow what the point in such user-space tool =
because anybody can take a look into the syslog. Even it is possible to =
grep error messages related to particular file system. What=E2=80=99s =
the point of such tool? I can see some point to report about file system =
corruption but you are talking about any error message. Moreover, it =
could be not trivial to track corruption even on file system driver=E2=80=99=
s side.

>=20
> 2 Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  I submitted a first set of patches, based on David Howells' original
>  superblock notifications patchset, that I expanded into error
>  reporting and had an example implementation for ext4.  Upstream =
review
>  has revealed a few design problems:
>=20
>  - Including the "function:line" tuple in the notification allows the
>    uniquely identification of the error origin but it also ties the
>    decodification of the error to the source code, i.e. =
<function:line>
>    is expected to change between releases.
>=20

Error message itself could identify the location without the necessity =
to know <function:line>. Only specially generated UID can be good =
solution, I suppose.

>  - Useful debug data (inode number, block group) have formats specific
>    to the filesystems, and my design wouldn't be expansible to
>    filesystems other than ext4.
>=20

Different file system volumes associate inode ids with completely =
different objects. So, if you haven=E2=80=99t access to the same volume =
then this information could be useless. What=E2=80=99s the point to =
share these details? Sometimes, to track the issue in file system driver =
requires to know much more details related to particular volume.

Finally, what=E2=80=99s the concrete use-cases that this user-space tool =
can be used? Currently, I don=E2=80=99t see any point to use this tool. =
The syslog is much more productive way to debug and to investigate the =
issues in file system driver.

Thanks,
Viacheslav Dubeyko.

