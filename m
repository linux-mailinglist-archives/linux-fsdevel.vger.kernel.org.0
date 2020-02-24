Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0C16A3D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXKZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 05:25:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbgBXKZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582539905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gy+vhmoT6JM3Yv4RVEvhda7Thq8Oh3Z0jshMS0ARWMg=;
        b=Z3WB2W3buQrh528MIAYislH4RE/kofCs1hllZJDEzKazP9jCvC3oYXTYeWfsHqup0egjOP
        Swam3ZftxYF+yH0rOq6z6Z05DJoBM7ZH3Fsz3qtK25RN2srvgNf+nlu6kHxWivsr3nQSxy
        P/MzSHxEQ0Vt24XvJd7Q+GDglDaC0kQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-NCnYek5DOSaJ6cUbfywN8g-1; Mon, 24 Feb 2020 05:25:03 -0500
X-MC-Unique: NCnYek5DOSaJ6cUbfywN8g-1
Received: by mail-qt1-f200.google.com with SMTP id x8so10155714qtq.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 02:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy+vhmoT6JM3Yv4RVEvhda7Thq8Oh3Z0jshMS0ARWMg=;
        b=Veb88QFFad0y2wK6r06+uOJgrwDr5w1r9MhmopsTRfAHFs6Wf77NM611Q9puaKCgFz
         RY8b8QmsNN9kzOa48cLTqURbDYpohaXtTsyEp0KDWoo3mDtvjxIS0OfvfW+tRcg7qgsF
         8oBHAu5a2octG+CWVlmWo5/NR851XD86Og1OnW98vLKkbTfRI3aPKckM6BiAQ++iZDc6
         UKXAGBLvZ/X66olOG6PIoclxHNTmEBXAVBfje5vGVwD2vLwd4KSCZouTUwI7B/S3p09d
         xiwfzF1VGasVxpujJ8UqRL+7ifmJ/lOKX+aLSklYayEymOog/of7lCkjZKIqIMaap6yZ
         k6NQ==
X-Gm-Message-State: APjAAAX0ugRM5uoT6fXQPmABRWFtDnrXTPO2IJ+SKcuzlTYLz8oE3tI4
        kN28BjSj6WzY/ryvsqc7XMP7Gz7k1iCfx6fXydMwP+rx+jztCQnRuo7jooEred7Wx0N6g80K5GT
        SqOBNKpzP8kr+ZNM5tLMoO4XrTCaN3Y8f9k8Lw9HKGA==
X-Received: by 2002:a37:a881:: with SMTP id r123mr14184718qke.199.1582539902870;
        Mon, 24 Feb 2020 02:25:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqztFT5Zfqx4XMsPU01nDc9vsIiEe1j5CK26LdX74+ps7d85rr9U4y9yqiVVjcliDp+alv+x51zsiwVwJlJsaVY=
X-Received: by 2002:a37:a881:: with SMTP id r123mr14184671qke.199.1582539902450;
 Mon, 24 Feb 2020 02:25:02 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com>
In-Reply-To: <1582316494.3376.45.camel@HansenPartnership.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Feb 2020 11:24:51 +0100
Message-ID: <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        christian@brauner.io, Jann Horn <jannh@google.com>,
        darrick.wong@oracle.com, Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 9:21 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2020-02-21 at 18:01 +0000, David Howells wrote:
> [...]
> > ============================
> > FILESYSTEM INFORMATION QUERY
> > ============================
> >
> > The fsinfo() system call allows information about the filesystem at a
> > particular path point to be queried as a set of attributes, some of
> > which may have more than one value.
> >
> > Attribute values are of four basic types:
> >
> >  (1) Version dependent-length structure (size defined by type).
> >
> >  (2) Variable-length string (up to 4096, including NUL).
> >
> >  (3) List of structures (up to INT_MAX size).
> >
> >  (4) Opaque blob (up to INT_MAX size).
> >
> > Attributes can have multiple values either as a sequence of values or
> > a sequence-of-sequences of values and all the values of a particular
> > attribute must be of the same type.
> >
> > Note that the values of an attribute *are* allowed to vary between
> > dentries within a single superblock, depending on the specific dentry
> > that you're looking at, but all the values of an attribute have to be
> > of the same type.
> >
> > I've tried to make the interface as light as possible, so
> > integer/enum attribute selector rather than string and the core does
> > all the allocation and extensibility support work rather than leaving
> > that to the filesystems. That means that for the first two attribute
> > types, the filesystem will always see a sufficiently-sized buffer
> > allocated.  Further, this removes the possibility of the filesystem
> > gaining access to the userspace buffer.
> >
> >
> > fsinfo() allows a variety of information to be retrieved about a
> > filesystem and the mount topology:
> >
> >  (1) General superblock attributes:
> >
> >      - Filesystem identifiers (UUID, volume label, device numbers,
> > ...)
> >      - The limits on a filesystem's capabilities
> >      - Information on supported statx fields and attributes and IOC
> > flags.
> >      - A variety single-bit flags indicating supported capabilities.
> >      - Timestamp resolution and range.
> >      - The amount of space/free space in a filesystem (as statfs()).
> >      - Superblock notification counter.
> >
> >  (2) Filesystem-specific superblock attributes:
> >
> >      - Superblock-level timestamps.
> >      - Cell name.
> >      - Server names and addresses.
> >      - Filesystem-specific information.
> >
> >  (3) VFS information:
> >
> >      - Mount topology information.
> >      - Mount attributes.
> >      - Mount notification counter.
> >
> >  (4) Information about what the fsinfo() syscall itself supports,
> > including
> >      the type and struct/element size of attributes.
> >
> > The system is extensible:
> >
> >  (1) New attributes can be added.  There is no requirement that a
> >      filesystem implement every attribute.  Note that the core VFS
> > keeps a
> >      table of types and sizes so it can handle future extensibility
> > rather
> >      than delegating this to the filesystems.
> >
> >  (2) Version length-dependent structure attributes can be made larger
> > and
> >      have additional information tacked on the end, provided it keeps
> > the
> >      layout of the existing fields.  If an older process asks for a
> > shorter
> >      structure, it will only be given the bits it asks for.  If a
> > newer
> >      process asks for a longer structure on an older kernel, the
> > extra
> >      space will be set to 0.  In all cases, the size of the data
> > actually
> >      available is returned.
> >
> >      In essence, the size of a structure is that structure's version:
> > a
> >      smaller size is an earlier version and a later version includes
> >      everything that the earlier version did.
> >
> >  (3) New single-bit capability flags can be added.  This is a
> > structure-typed
> >      attribute and, as such, (2) applies.  Any bits you wanted but
> > the kernel
> >      doesn't support are automatically set to 0.
> >
> > fsinfo() may be called like the following, for example:
> >
> >       struct fsinfo_params params = {
> >               .at_flags       = AT_SYMLINK_NOFOLLOW,
> >               .flags          = FSINFO_FLAGS_QUERY_PATH,
> >               .request        = FSINFO_ATTR_AFS_SERVER_ADDRESSES,
> >               .Nth            = 2,
> >       };
> >       struct fsinfo_server_address address;
> >       len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> >                    &address, sizeof(address));
> >
> > The above example would query an AFS filesystem to retrieve the
> > address
> > list for the 3rd server, and:
> >
> >       struct fsinfo_params params = {
> >               .at_flags       = AT_SYMLINK_NOFOLLOW,
> >               .flags          = FSINFO_FLAGS_QUERY_PATH,
> >               .request        = FSINFO_ATTR_AFS_CELL_NAME;
> >       };
> >       char cell_name[256];
> >       len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> >                    &cell_name, sizeof(cell_name));
> >
> > would retrieve the name of an AFS cell as a string.
> >
> > In future, I want to make fsinfo() capable of querying a context
> > created by
> > fsopen() or fspick(), e.g.:
> >
> >       fd = fsopen("ext4", 0);
> >       struct fsinfo_params params = {
> >               .flags          = FSINFO_FLAGS_QUERY_FSCONTEXT,
> >               .request        = FSINFO_ATTR_PARAMETERS;
> >       };
> >       char buffer[65536];
> >       fsinfo(fd, NULL, &params, &buffer, sizeof(buffer));
> >
> > even if that context doesn't currently have a superblock attached.  I
> > would prefer this to contain length-prefixed strings so that there's
> > no need to insert escaping, especially as any character, including
> > '\', can be used as the separator in cifs and so that binary
> > parameters can be returned (though that is a lesser issue).
>
> Could I make a suggestion about how this should be done in a way that
> doesn't actually require the fsinfo syscall at all: it could just be
> done with fsconfig.  The idea is based on something I've wanted to do
> for configfd but couldn't because otherwise it wouldn't substitute for
> fsconfig, but Christian made me think it was actually essential to the
> ability of the seccomp and other verifier tools in the critique of
> configfd and I belive the same critique applies here.
>
> Instead of making fsconfig functionally configure ... as in you pass
> the attribute name, type and parameters down into the fs specific
> handler and the handler does a string match and then verifies the
> parameters and then acts on them, make it table configured, so what
> each fstype does is register a table of attributes which can be got and
> optionally set (with each attribute having a get and optional set
> function).  We'd have multiple tables per fstype, so the generic VFS
> can register a table of attributes it understands for every fstype
> (things like name, uuid and the like) and then each fs type would
> register a table of fs specific attributes following the same pattern.
> The system would examine the fs specific table before the generic one,
> allowing overrides.  fsconfig would have the ability to both get and
> set attributes, permitting retrieval as well as setting (which is how I
> get rid of the fsinfo syscall), we'd have a global parameter, which
> would retrieve the entire table by name and type so the whole thing is
> introspectable because the upper layer knows a-priori all the
> attributes which can be set for a given fs type and what type they are
> (so we can make more of the parsing generic).  Any attribute which
> doesn't have a set routine would be read only and all attributes would
> have to have a get routine meaning everything is queryable.

And that makes me wonder: would a
"/sys/class/fs/$ST_DEV/options/$OPTION" type interface be feasible for
this?

Thanks,
Miklos

