Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C53750B7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjGLO4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGLO4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:56:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA51BCB
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 07:56:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c595cadae4bso7160770276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689173771; x=1691765771;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LsbRQsJwk1Bpfwkr5d2Qp6TFELPaME+LiPFG/svl+8=;
        b=VzEtdecqUG58b0l89kRjubKr9v5B61J4stq0MJD1cjGnAjfrQGp5Zu54wW7nF+be94
         QE9AXsqfKE2SG7AQXOSD3ytEBTyhhYcQ1WIh/TnMRfF29FqkzcDxRgs8MHWorNYaJzm6
         MOoWMEZSXVAgsUhCnDZ5DY8fXu7yi4AToa31y3pUnHGJS9XqSwaQAmkchE6w/qpo0J0x
         am6RmkxZ2hWxSlM3+xhcjWBm6yPVFFYaE/GVRmZKs2R8J1WBxsvWXbjXj8r3GAJ9yeYO
         PvbvsrvjXeILJf8WGgoTN28fBqjBmyXcZlNlrm4/7QzznvdmE0iAZLNiOHOMsJh8WJ/7
         675A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173771; x=1691765771;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6LsbRQsJwk1Bpfwkr5d2Qp6TFELPaME+LiPFG/svl+8=;
        b=dVTU29xShq0mF6OnSuApes2XOgf6jjKCGq7AVF4kSMV8S59cM/AfDfPIy8g8W92jHn
         7Prvtmmw62RVYAd+5KkpCwcgatJKEvYt1A95JlmBLUVX6fxsxdYVi0lrEsHNqnL6Z2eN
         z8ia6nMBv6gSTR/UzVEEnN4AC5jKASEOz7MZd8wl7UFEbeMU/TtuSV7+rGmjZ5uln5H6
         /DqFpu/W2IivpA6OY9bd/8lQQTqAsrkqsXdPRTOJEc5Wh6+5MArGF9dAcTTzWKPESwND
         Mhc0hbZqhIunxg5GtXSXGVTY62IEsQrYzq1nxjnww0Xid8X+sGxL6+eh9DKrepdH2ORb
         FEgQ==
X-Gm-Message-State: ABy/qLbo8vWwnbQsrh7ecnvLE8cRF7uMgPE4XvDgjd19+5j4dIzZHzox
        waj3+siQnKgKEYbCIJMrhobxcCYabvk=
X-Google-Smtp-Source: APBJJlGZ7msEliB6uVouh3CiO8/3ZTJR1xL789IoWaCAP1m/Qq77yBG4HCNnmNXXOFm0lp5WVRBLWQDE9pY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:73e8:365a:7352:a14])
 (user=gnoack job=sendgmr) by 2002:a25:c05:0:b0:c70:d138:51b1 with SMTP id
 5-20020a250c05000000b00c70d13851b1mr88355ybm.12.1689173771109; Wed, 12 Jul
 2023 07:56:11 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:56:08 +0200
In-Reply-To: <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
Message-Id: <ZK6/CF0RS5KPOVff@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com> <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Wed, Jul 12, 2023 at 12:55:19PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Thinking more about this, this first step is too restrictive, which
> might lead to dangerous situations.
>=20
> My main concern is that this approach will deny innocuous or even "good"
> IOCTL. For instance, if FIOCLEX is denied, this could leak file
> descriptors and then introduce vulnerabilities.

This is a good point.

> As we discussed before, we cannot categorize all IOCTLs, but I think we
> need to add exceptions for a subset of them, and maintain this list.
> SELinux has some special handling within selinux_file_ioctl(), and we
> should use that as a starting point. The do_vfs_ioctl() function is
> another important place to look at. The main thing to keep in mind is
> that Landlock's goal is to restrict access to data (e.g. FS, network,
> IPC, bypass through other processes), not to restrict innocuous (at
> least in theory) kernel features.
>=20
> I think, at least all IOCTLs targeting file descriptors themselves should
> always be allowed, similar to fcntl(2)'s F_SETFD and F_SETFL commands:
> - FIOCLEX
> - FIONCLEX
> - FIONBIO
> - FIOASYNC
>=20
> Some others may not be a good idea:
> - FIONREAD should be OK in theory but the VFS part only target regular
> files and there is no access check according to the read right, which is
> weird.
> - FICLONE, FICLONERANGE, FIDEDUPRANGE: read/write actions.
>=20
> We should add a built-time or run-time safeguard to be sure that future
> FD IOCTLs will be added to this list. I'm not sure how to efficiently
> implement such protection though.

I need to ponder it a bit.. :)  I also don't see an obvious solution yet ho=
w to
tie these lists of ioctls together.


> I'm also wondering if we should not split the IOCTL access right into
> three: mostly read, mostly write, and misc. _IOC_READ and _IOC_WRITE are
> definitely not perfect, but tied to specific drivers (i.e. not a file
> hierarchy but a block or character device) this might help until we get
> a more fine-grained IOCTL access control. We should check if it's worth
> it according to commonly used drivers. Looking at the TTY driver, most
> IOCTLs are without read or write markers. Using this split could induce
> a false sense of security, so it should be well motivated.

As it was pointed out by the LWN article that Jeff Xu pointed to [1], this
read/write bit in the ioctl command number is only referring to whether the
*argument pointer* to the ioctl is being read or written, but you can not u=
se
this bit to infer whether the ioctl itself performs a "reading" or "writing=
"
access to the underlying file.

As the LWN article explains, SELinux has fallen for the same trap in the pa=
st,
the post [2] has an example for an ioctl where the read/write bits for the
argument are not related to what the underlying operation does.

It might be that you could potentially use the _IOC_READ and _IOC_WRITE bit=
s to
group smaller subsets of the ioctl cmd space, such as for a single device t=
ype.
But then, the users would have to go through the list of supported ioctls o=
ne by
one anyway, to ensure that this works for that subset.  If they are going
through them one by one anyway, they might maybe just as well list them out=
 in
the filter rule...?

[1] https://lwn.net/Articles/428140
[2] https://lwn.net/Articles/428142/


I've also pondered more about the ioctl support. I have a work-in-progress =
patch
set which filters ioctls according to various criteria, but it's not fully
fleshed out yet.

In the big picture: I think that the main ways how we can build this differ=
ently
are (a) the criteria on which to decide whether an ioctl is permitted, and =
(b)
the time at which we evaluate these criteria (time of open() vs. time of
ioctl()).  We can also evaluate the criteria at different times, depending =
on
which criterium it is.

So:

(a) The criteria on which to decide that an ioctl is permitted:

    We have discussed the followowing ones so far:

    * The *ioctl cmd* (request) itself
       - needs to be taken into account, obviously.
       - ioctl cmds do not have an obvious ordering exposed to userspace,
         so asking users to specify ranges is potentially difficult
       - asking users to list all individual ioctls they do might result in
         lists that are larger than I had thought. I've straced Firefox and
         found that it did about 20-30 direct-rendering related ioctls, and=
 most
         of them were specific to my graphics card... o_O so I assume that =
there
         are more of these for other graphics cards.

    * The *file device ID* (major / minor)
       - specifying ranges is a good idea - ranges of device IDs are logica=
lly
         grouped and the order is also exposed and documented to user space=
.

    * The *file type*, read from filp->f_mode
       - includes regular files, directories, char devices, block devices,
         fifos and sockets
       - BUT this list of types in non-exhaustive:
         - there are valid struct file objects which have special types and=
 are
           not distinguishable. They might not have a file type set in f_mo=
de,
           even.  Examples include pidfds, or the Landlock ruleset FD. -- s=
o: we
           do need a way to ignore file type altogether in an ioctl rule, s=
o
           that such "special" file types can still be matched in the rule.

    * The *file path*
       - This can only really be checked against at open() time, imho.
         Doing it during the ioctl is too late, because the file might
         have been created in a different mount namespace, and then the
         current thread can't really make that file work with ioctls.
       - Not all open files *have* a file path (i.e. sockets, Landlock rule=
set)

(b) The time at which the criteria are checked:

    * During open():
       - A check at this time is necessary to match against file paths, imh=
o,
         as we already to in the ioctl patch set I've sent.

    * During ioctl():
       - A check at this time is *also* necessary, because without that, we=
 will
         not be able to restrict ioctls on TTYs and other file descriptors =
that
         are obtained from other processes.

The tentative approach I've taken in my own patch set and the WIP part so f=
ar is:

 (1) Do file path checks at open() time (modeled as a access_fs right)
 (2) Do cmds, device ID and file type checks at ioctl() time.
     This is modeled independently of the file path check. -- both checks n=
eed to
     pass independently for an ioctl invocation to be permitted.

The API of that approach is:
 * The ruleset attribute gets a new handled_misc field,
   and when setting the first bit in it, it'll deny all ioctls
   unless there is a special ioctl rule added for them
   (and the path of the file was OK for ioctl at open time).
 * A new rule type with an associated struct landlock_ioctl_attr -
   that struct lets users define:
     - the desired mask of file types (or 0 for "all")
     - the designed device ID range
     - the list of ioctl cmds to be permitted for such files

An open question is whether the ruleset attr's "handled_misc" field should
rather be a "handled_ioctl_cmds" field, a set of restricted ioctl cmds
(potentially [0, 2^32)).  I think that would be more consistent conceptuall=
y
with how it was done for file system access rights, but obviously we can't =
model
it as a bit field any more - it would have to be some other suitable
representation of a set of integers, which also lets people say "all ioctls=
".

The upside of that approach would be that it could also be used to selectiv=
ely
restrict specific known-evil ioctls, and letting all others continue to wor=
k.
For example, sandboxing or sudo-like programs could filter out TIOCSTI and
TIOCLINUX.

I'd be interested in hearing your opinion about this (also from the Chromiu=
m
side).

Thanks,
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
