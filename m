Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7204793674
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjIFHjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 03:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjIFHjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:39:37 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D5E50;
        Wed,  6 Sep 2023 00:39:33 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44d5c49af07so1478608137.2;
        Wed, 06 Sep 2023 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693985972; x=1694590772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUk+9Rx32PDc9sNdQZWJvwjZyk5WbMi6fTHdtzwH4uY=;
        b=UbPi8VSY3jcRHZAQq42g5TjcrRDtHIoYWV1WaHFwiCgkyokDb4VjQCwVnWxdFoFG8P
         pny/RFxTnobkRhuHGSU1VRAoyPTk5L0QnNvvJM9Rsn7SFjgVBv+irCyeyV5eNGU03Cjf
         yZGlbDmkTL0Zi/YGuN7chkmUw/D0MGbCQ++M3XLkQKr8fJHuFOrHwzDktZu2GcGaChHz
         LNGYCoj8gsgRdswX8WuYbu+FNjstKgQvH7oWsxxnCd9xmImIi+sxzhAcUg2bIRA4K1M4
         K/vsqi2jHDAds9/IpsHJzvqUEi/khH7iUpjKyrexGUIPXpR6VZu7C4m1rVveUWACY/8j
         hWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985972; x=1694590772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUk+9Rx32PDc9sNdQZWJvwjZyk5WbMi6fTHdtzwH4uY=;
        b=DBsTyilqxSP5dbQZZw55rqgGpJDniq0oDiKB5FWfSiNmNsfzZVxvap09JZrVRZ+B4r
         mdkcbXWEICNjOvtjlgAReLZJ8NVfCX7X91yQ128oXeoEGVNegyU3qwl8NwjW9MohiTEf
         prFdGRMiEk0uzecJwpuRtW465v/6VPFEz2GM4o02vjotIaOxvkX2HF+1vATzgcIzgPVm
         DKPkkUiHdyFhDhvzPyBUkZuKo4PA71wLLUVSZ3uS86o/pRCqfka0vEq3jbJ8In94S+MQ
         3d2iTg4L0CoVH86yueschxMxDZ5mHePbHA3FBZidPDOfBualApIfTbfozxEwFn1vWDOp
         iGnQ==
X-Gm-Message-State: AOJu0YxkznnElKoOY5ur9dQvWWuHRpjzjsFDnniNFom13fS2LRJrMubV
        07Wn5pmMJsG2kcu9VNau4H1pWfrw1F/SDVeZhGWtHiAy9ng=
X-Google-Smtp-Source: AGHT+IEyFb4lpfNhAmlAq49+S+T1lSPVd46gyRNAIWnieI4KvDhQsgrND6zmPzI+NlzPionKRT801dlrOYWtWngTU9A=
X-Received: by 2002:a67:f4d6:0:b0:44d:4e08:ccc8 with SMTP id
 s22-20020a67f4d6000000b0044d4e08ccc8mr2020486vsn.24.1693985972399; Wed, 06
 Sep 2023 00:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230903120433.2605027-1-amir73il@gmail.com> <CVBDFOQTOWJ4.2NWF9JNF4IUFL@posteo.de>
In-Reply-To: <CVBDFOQTOWJ4.2NWF9JNF4IUFL@posteo.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 6 Sep 2023 10:39:21 +0300
Message-ID: <CAOQ4uxivZzZj=qAYrNEeBYp3y6bw=-JNmmZ-a=OHAEdM_hShow@mail.gmail.com>
Subject: Re: [PATCH] name_to_handle_at.2,fanotify_mark.2: Document the
 AT_HANDLE_FID flag
To:     Tom Schwindl <schwindl@posteo.de>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@poochiereds.net>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 6, 2023 at 2:28=E2=80=AFAM Tom Schwindl <schwindl@posteo.de> wr=
ote:
>
> Hi,
>
> On Sun Sep 3, 2023 at 2:04 PM CEST, Amir Goldstein wrote:
> > A flag to indicate that the requested file_handle is not intended
> > to be used for open_by_handle_at(2) and may be needed to identify
> > filesystem objects reported in fanotify events.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Hi Alejandro,
> >
> > This is a followup on AT_HANDLE_FID feature from v6.5.
> >
> > Thanks,
> > Amir.
> >
> >  man2/fanotify_mark.2     | 11 +++++++++--
> >  man2/open_by_handle_at.2 | 42 +++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 48 insertions(+), 5 deletions(-)
> >
> > diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> > index 3f85deb23..8e885af69 100644
> > --- a/man2/fanotify_mark.2
> > +++ b/man2/fanotify_mark.2
> > @@ -743,10 +743,17 @@ do not specify a directory.
> >  .B EOPNOTSUPP
> >  The object indicated by
> >  .I pathname
> > -is associated with a filesystem that does not support the encoding of =
file
> > -handles.
> > +is associated with a filesystem
> > +that does not support the encoding of file handles.
> >  This error can be returned only with an fanotify group that identifies
> >  filesystem objects by file handles.
> > +Calling
> > +.BR name_to_handle_at (2)
> > +with the flag
> > +.BR AT_HANDLE_FID " (since Linux 6.5)"
> > +.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
> > +can be used as a test
> > +to check if a filesystem supports reporting events with file handles.
> >  .TP
> >  .B EPERM
> >  The operation is not permitted because the caller lacks a required cap=
ability.
> > diff --git a/man2/open_by_handle_at.2 b/man2/open_by_handle_at.2
> > index 4061faea9..4cfa21d9c 100644
> > --- a/man2/open_by_handle_at.2
> > +++ b/man2/open_by_handle_at.2
> > @@ -109,17 +109,44 @@ structure as an opaque data type: the
> >  .I handle_type
> >  and
> >  .I f_handle
> > -fields are needed only by a subsequent call to
> > +fields can be used in a subsequent call to
> >  .BR open_by_handle_at ().
> > +The caller can also use the opaque
> > +.I file_handle
> > +to compare the identity of filesystem objects
> > +that were queried at different times and possibly
> > +at different paths.
> > +The
> > +.BR fanotify (7)
> > +subsystem can report events
> > +with an information record containing a
> > +.I file_handle
> > +to identify the filesystem object.
> >  .PP
> >  The
> >  .I flags
> >  argument is a bit mask constructed by ORing together zero or more of
> > -.B AT_EMPTY_PATH
> > +.BR AT_HANDLE_FID ,
> > +.BR AT_EMPTY_PATH ,
> >  and
> >  .BR AT_SYMLINK_FOLLOW ,
> >  described below.
> >  .PP
> > +When
> > +.I flags
> > +contain the
> > +.BR AT_HANDLE_FID " (since Linux 6.5)"
> > +.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
> > +flag, the caller indicates that the returned
> > +.I file_handle
> > +is needed to identify the filesystem object,
> > +and not for opening the file later,
> > +so it should be expected that a subsequent call to
> > +.BR open_by_handle_at ()
> > +with the returned
> > +.I file_handle
> > +may fail.
> > +.PP
> >  Together, the
> >  .I pathname
> >  and
> > @@ -363,8 +390,14 @@ capability.
> >  .B ESTALE
> >  The specified
> >  .I handle
> > -is not valid.
> > +is not valid for opening a file.
> >  This error will occur if, for example, the file has been deleted.
> > +This error can also occur if the
> > +.I handle
> > +was aquired using the
>
> This should probably be s/aquired/acquired/
>
> > +.B AT_HANDLE_FID
> > +flag and the filesystem does not support
> > +.BR open_by_handle_at ().
> >  .SH VERSIONS
> >  FreeBSD has a broadly similar pair of system calls in the form of
> >  .BR getfh ()
> > @@ -386,6 +419,9 @@ file handles, for example,
> >  .IR /proc ,
> >  .IR /sys ,
> >  and various network filesystems.
> > +Some filesystem support the translation of pathnames to
>
> You should use the plural, filesystems, here.
>

Fixed in v2.

Thanks for the review!
Amir.
