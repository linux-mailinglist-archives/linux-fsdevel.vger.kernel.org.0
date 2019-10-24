Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E20E29A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 06:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408364AbfJXE5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 00:57:16 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41658 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJXE5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 00:57:16 -0400
Received: by mail-yw1-f68.google.com with SMTP id o195so3404768ywd.8;
        Wed, 23 Oct 2019 21:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qp4ylpFjT2NK5D3YlCPCDZfnUsSpfLeB6JcWlmTT8JE=;
        b=f+iU1lVJ+8MXE0YjXhbzT4Z+QZTKEVbpSj7I64WEMcxAgcUOKckEALuDnxjfop1KDz
         /GEuxtdqM/gAmg/8rUQcbM54P8ZvUqXo23LCox8OZKBVBlVoDn1p5gmEXxfQnAWBfBHW
         uZZaGVOWsT//cwHGlbqENLvAYitmYf5NxnxRGYapcBJVSV1rP+NlFCXZHqVZ6fsYCVwo
         HiL1fAZTVAeLbnNXS5YnMp44jrRgVnpRxhkGyVWlHqmqFFsCMZbuTBKjna3CheOTh8v8
         hD6hfXAtyLGGlQqfHMdlsFiQ1XgpXWIL5nune/Pgn/JF3P1WqL13u+LVKHRsnQpi/3uP
         Pzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qp4ylpFjT2NK5D3YlCPCDZfnUsSpfLeB6JcWlmTT8JE=;
        b=t2MGTIc8mTc7xW5/p/CK16Ve9OEKmiR3Bt1eoB5Z7AoMwDnIldppJFs4AQlRg5rSTa
         q12+rvFQWnsBdLRSERRYnp2UD56h9Ed7dygSLlsN0K+KpagF9fNJEIyKLAZLanO3WOPf
         xM/lf7xUbla/jk3vlTj9s1KC4BPrPrpH5tFKq9eB/9V+W/lhbBMXJOZIyvrB5aDeJJ6t
         C+eN3/HhTt2oLPFy4NmgSsOa9Izgi1LmAXlmxlOybOx4Ju3ogFv6LeWPgiB0NsBh1iZd
         fM7e68NeYec1KF3EY1ABYuene9koRVfxcXINUYEd59XIU70IQZHgjxsu/Ak2dZoAh9dB
         jjbg==
X-Gm-Message-State: APjAAAX2taqOZp6Wh4uI+eNoiHVcayhSQURKPdVWJQhiiAase5zce9Le
        cDp9IVjonZ/SxmlpoPcPLJDkSfLsNotmk4dR8To=
X-Google-Smtp-Source: APXvYqzpUv8fnfcjV1KksbDdhWbx31x/A6CcO3wQjALxaBgCfUkMkcsChuqQOOuA9702g94fFIVsWA6cYWlyk5yi/8s=
X-Received: by 2002:a81:6c58:: with SMTP id h85mr5010753ywc.88.1571893034732;
 Wed, 23 Oct 2019 21:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191022204453.97058-1-salyzyn@android.com> <20191022204453.97058-2-salyzyn@android.com>
 <8CE5B6E8-DCB7-4F0B-91C1-48030947F585@dilger.ca>
In-Reply-To: <8CE5B6E8-DCB7-4F0B-91C1-48030947F585@dilger.ca>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Oct 2019 07:57:03 +0300
Message-ID: <CAOQ4uxis-oQSjKrtBDi-8BQ2M3ve3w8o-YVGRwWLnq+5JLUttA@mail.gmail.com>
Subject: Re: [PATCH v14 1/5] Add flags option to get xattr method paired to __vfs_getxattr
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        kernel-team@android.com, selinux@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        ecryptfs@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[excessive CC list reduced]

On Wed, Oct 23, 2019 at 11:07 AM Andreas Dilger via samba-technical
<samba-technical@lists.samba.org> wrote:
>
>
> On Oct 22, 2019, at 2:44 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> >
> > Replace arguments for get and set xattr methods, and __vfs_getxattr
> > and __vfs_setaxtr functions with a reference to the following now
> > common argument structure:
> >
> > struct xattr_gs_args {
> >       struct dentry *dentry;
> >       struct inode *inode;
> >       const char *name;
> >       union {
> >               void *buffer;
> >               const void *value;
> >       };
> >       size_t size;
> >       int flags;
> > };
>

> > Mark,
> >
> > I do not see the first patch on fsdevel
> > and I am confused from all the suggested APIs
> > I recall Christoph's comment on v8 for not using xattr_gs_args
> > and just adding flags to existing get() method.
> > I agree to that comment.
>
> As already responded, third (?) patch version was like that,

The problem is that because of the waaay too long CC list, most revisions
of the patch and discussion were bounced from fsdevel, most emails
I did not get and cannot find in archives, so the discussion around
them is not productive.

Please resend patch to fsdevel discarding the auto added CC list
of all fs maintainers.

> gregkh@
> said it passed the limit for number of arguments, is looking a bit silly

Well, you just matched get() to set() args list, so this is not a strong
argument IMO.

> (my paraphrase), and that it should be passed as a structure. Two others
> agreed. We gained because both set and get use the same structure after
> this change (this allows a simplified read-modify-write cycle).

That sounds like a nice benefit if this was user API, but are there any
kernel users that intend to make use of that read-modify-write cycle?
I don't think so.

>
> We will need a quorum on this, 3 (structure) to 2 (flag) now (but really
> basically between Greg and Christoph?). Coding style issue: Add a flag,
> or switch to a common xattr argument  structure?
>

IIRC, Christoph was asking why the silly struct and not simply add flags
(as did I). He probably did not see Greg's comments due to the list bounce
issue. If I read your second hand description of Greg's reaction correctly,
it doesn't sound so strong opinionated as well.
Me, I can live with flags or struct - I don't care, but...

Be prepared that if you are going ahead with struct you are going to
suffer from bike shedding, which has already started and you will be
instructed (just now) to also fix all the relevant and missing Documentation.
If, on the other hand, you can get Greg and the rest to concede to adding
flags arg and match get() arg list to set() arg list, you will have a much
easier job and the patch line count, especially in fs code will be *much*
smaller - just saying.

Thanks,
Amir.
