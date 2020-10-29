Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25E229F73F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJ2V7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 17:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJ2V7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:59:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05FC0613D7
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 14:59:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x13so3464064pgp.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7mpKGmhk7KbAdNRg8CrtKSJUwgz+Qb8kytsY0ITcAGk=;
        b=ovnhX+qIKiPabZOH4hn59CbnR86mckuEhcSQzDfD4ogDnQOeqgaiDVK+ftwlz4GjBw
         IF1LruixH+2U6xBdFKzvJSsEFdLRlm7NDiQJeYH8lEDgRegvi09Eyiiv8FzMP+YkBG7h
         ErfC2CZ5UKzIDsJHnHHf2T8LL8QH3qahSBYYYcM+SOXYKIjkpy79Ly9naIJkDg8sGB2z
         5bXFt7H0PEyXuS99nQGXBuMc9J66121arDOCzaie84/i+VyFUCX/8Q4tK2WqqJo5rtL0
         KrmO0EobGfrkMQOJZUGWcNnsaI2FFqZ7n7t71N7ySdNYlzkPHlmVRfWSzIMDotoXHJrg
         nPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7mpKGmhk7KbAdNRg8CrtKSJUwgz+Qb8kytsY0ITcAGk=;
        b=kFpyUFyXJNyoj4dfIbIIJfyzTcsOeGLYqGVCbv4rN+2SPOc2tKS0qzNBw3TKvHRmU0
         hVWtP5IGilh8SsDAVssiDQy8VxObywjybnRBGjpVhW57mZ3m04lhvggTFbRRrMgjEvbm
         TKKBhLxpUi4YaiWHBFR4OribzwJ/wCe3HZ3ny7hYrK5se3XCYm0d2TznMHn2jUILwwJW
         oOFdtz09p66Pl/EtBq6A1bsyierPQ55+Vke0UTx/1L3FL5tvE9CSOU71318uEn9qPJp3
         egJr7umSK6K96cbhNh9Tfa5rFUH7t5yBqPeHkME2Pf7sNTI2yV+OoWka9AqkaFG5nreP
         qV/A==
X-Gm-Message-State: AOAM5339qijpcXqEVPlgMSrvplZImxVOhATgHvuCd8hPC2JjfCrBRT8Z
        3nj6PXgC3cUO72GPvCSEpF0HyA==
X-Google-Smtp-Source: ABdhPJxSWOh4ftHI47KiCrZ0illEdrC1OP4fiqquB1QRs+VL+ywYh7woPj1uc9hDTpndfsW71KZ7Hw==
X-Received: by 2002:a63:1d12:: with SMTP id d18mr5911604pgd.314.1604008755871;
        Thu, 29 Oct 2020 14:59:15 -0700 (PDT)
Received: from ?IPv6:2600:1012:b011:6d49:b5a8:d1fb:e286:b4a2? ([2600:1012:b011:6d49:b5a8:d1fb:e286:b4a2])
        by smtp.gmail.com with ESMTPSA id mp13sm814127pjb.36.2020.10.29.14.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 14:59:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Date:   Thu, 29 Oct 2020 14:58:55 -0700
Message-Id: <8E455D54-FED4-4D06-8CB7-FC6291C64259@amacapital.net>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 28, 2020, at 5:35 PM, Christian Brauner <christian.brauner@ubuntu.c=
om> wrote:
>=20
> =EF=BB=BFHey everyone,
>=20
> I vanished for a little while to focus on this work here so sorry for
> not being available by mail for a while.
>=20
> Since quite a long time we have issues with sharing mounts between
> multiple unprivileged containers with different id mappings, sharing a
> rootfs between multiple containers with different id mappings, and also
> sharing regular directories and filesystems between users with different
> uids and gids. The latter use-cases have become even more important with
> the availability and adoption of systemd-homed (cf. [1]) to implement
> portable home directories.
>=20
> The solutions we have tried and proposed so far include the introduction
> of fsid mappings, a tiny overlay based filesystem, and an approach to
> call override creds in the vfs. None of these solutions have covered all
> of the above use-cases.
>=20
> The solution proposed here has it's origins in multiple discussions
> during Linux Plumbers 2017 during and after the end of the containers
> microconference.
> To the best of my knowledge this involved Aleksa, St=C3=A9phane, Eric, Dav=
id,
> James, and myself. A variant of the solution proposed here has also been
> discussed, again to the best of my knowledge, after a Linux conference
> in St. Petersburg in Russia between Christoph, Tycho, and myself in 2017
> after Linux Plumbers.
> I've taken the time to finally implement a working version of this
> solution over the last weeks to the best of my abilities. Tycho has
> signed up for this sligthly crazy endeavour as well and he has helped
> with the conversion of the xattr codepaths.
>=20
> The core idea is to make idmappings a property of struct vfsmount
> instead of tying it to a process being inside of a user namespace which
> has been the case for all other proposed approaches.
> It means that idmappings become a property of bind-mounts, i.e. each
> bind-mount can have a separate idmapping. This has the obvious advantage
> that idmapped mounts can be created inside of the initial user
> namespace, i.e. on the host itself instead of requiring the caller to be
> located inside of a user namespace. This enables such use-cases as e.g.
> making a usb stick available in multiple locations with different
> idmappings (see the vfat port that is part of this patch series).
>=20
> The vfsmount struct gains a new struct user_namespace member. The
> idmapping of the user namespace becomes the idmapping of the mount. A
> caller that is either privileged with respect to the user namespace of
> the superblock of the underlying filesystem or a caller that is
> privileged with respect to the user namespace a mount has been idmapped
> with can create a new bind-mount and mark it with a user namespace.

So one way of thinking about this is that a user namespace that has an idmap=
ped mount can, effectively, create or chown files with *any* on-disk uid or g=
id by doing it directly (if that uid exists in-namespace, which is likely fo=
r interesting ids like 0) or by creating a new userns with that id inside.

For a file system that is private to a container, this seems moderately safe=
, although this may depend on what exactly =E2=80=9Cprivate=E2=80=9D means. W=
e probably want a mechanism such that, if you are outside the namespace, a r=
eference to a file with the namespace=E2=80=99s vfsmnt does not confer suid p=
rivilege.

Imagine the following attack: user creates a namespace with a root user and a=
rranges to get an idmapped fs, e.g. by inserting an ext4 usb stick or using w=
hatever container management tool does this.  Inside the namespace, the user=
 creates a suid-root file.

Now, outside the namespace, the user has privilege over the namespace.  (I=E2=
=80=99m assuming there is some tool that will idmap things in a namespace ow=
ned by an unprivileged user, which seems likely.). So the user makes a new b=
ind mount and if maps it to the init namespace. Game over.

So I think we need to have some control to mitigate this in a comprehensible=
 way. A big hammer would be to require nosuid. A smaller hammer might be to s=
ay that you can=E2=80=99t create a new idmapped mount unless you have privil=
ege over the userns that you want to use for the idmap and to say that a vfs=
mnt=E2=80=99s paths don=E2=80=99t do suid outside the idmap namespace.  We a=
lready do the latter for the vfsmnt=E2=80=99s mntns=E2=80=99s userns.

Hmm.  What happens if we require that an idmap userns equal the vfsmnt=E2=80=
=99s mntns=E2=80=99s userns?  Is that too limiting?

I hope that whatever solution gets used is straightforward enough to wrap on=
e=E2=80=99s head around.

> When a file/inode is accessed through an idmapped mount the i_uid and
> i_gid of the inode will be remapped according to the user namespace the
> mount has been marked with. When a new object is created based on the
> fsuid and fsgid of the caller they will similarly be remapped according
> to the user namespace of the mount they care created from.

By =E2=80=9Cmapped according to=E2=80=9D, I presume you mean that the on-dis=
k uid/gid is the gid as seen in the user namespace in question.


