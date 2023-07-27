Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70592764FF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjG0Jij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjG0JiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:38:17 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721666194
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:32:23 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a34a0b75eso40341966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690450342; x=1691055142;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9wG54SKOiot2xhxqhwPg9gnKBeCz5aIx7TRjv8QIGU=;
        b=PL/tvt0CbuTauU8KZes+sFfrzPx5i2oVs1vpi0kiz7a+WhwvPCbEUZSkP9515tIsZu
         MdFgTqZDIsQPXAYmvInuYeN9XcbmX54NmBeDos+fC6AHYJFwxpIN712zYGbnD+8nM64b
         f6wCPGiSiLqcJaXVHa+IBNJbw+1/1oA1T2UD4wbhqX5lou7op4euYptimhxWv/Lm3qB4
         NZnKJz58dILp4GnQAuJg4tKyYK6aZkw2hVbTw4dkC+bjivB1rfWyIJDlTnaGvSy8WuOj
         ysKuSiGbYqSU9iJEwi6MudATGm/Om331YH4Ja7euDpwlPEwJUMLfFsoI4hffzFjRFRJY
         dggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690450342; x=1691055142;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9wG54SKOiot2xhxqhwPg9gnKBeCz5aIx7TRjv8QIGU=;
        b=lUbaqOwLg2Bv/B2g+carKauJpAURJHAtBxYUkoHg2MAIt6Mh9LB9/sV8b1/D8CLVka
         f0iJtbnYZJoTy/RbHEPselWqIlNiCYoRMrfkbRWKBNIB89Mek7/dc4OJKL+s/ccKhQLS
         /TSlQbew7SN5aZ6+E7pYOC/GPsDJinrl5LiwSYr/huEH3AM4ukedPYkySi6NlOZ7jTqi
         SHB5WS+0+mwlDFiTT2GKDRhdpLPJk2q1ROKwOytHdeughXFsbdrU+km1porYIwKWcRlz
         RxFszDj0dTAflBwcpvA+wYUvcC5wcyKiMx6H7xdO8C/eZyPghxTIFZKREQcXLuoRgow5
         NlBQ==
X-Gm-Message-State: ABy/qLblLg3anTZbOQeezEGcnP6tV3L9xAhnW9DZj+lxEejOMdD+523L
        5PIf2B5MhER9I6inrKHBkj18lugodRM=
X-Google-Smtp-Source: APBJJlFJ+e9xmxyrCQ1V2JgK9iX7EyjccAOjmi7+qZk6ILEWDNE+0nq08DNB0yMFJgBaSsucaDCACszr2EA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:db47:e98d:115e:6269])
 (user=gnoack job=sendgmr) by 2002:a17:907:8315:b0:98e:3ef1:90b with SMTP id
 mq21-20020a170907831500b0098e3ef1090bmr4310ejc.1.1690450341872; Thu, 27 Jul
 2023 02:32:21 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:32:18 +0200
In-Reply-To: <e7e24682-5da7-3b09-323e-a4f784f10158@digikod.net>
Message-Id: <ZMI5ooJq6i/OJyxs@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com> <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
 <ZK6/CF0RS5KPOVff@google.com> <f3d46406-4cae-cd5d-fb35-cfcbd64c0690@digikod.net>
 <20230713.470acd0e890b@gnoack.org> <e7e24682-5da7-3b09-323e-a4f784f10158@digikod.net>
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Matt Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Micka=C3=ABl!

Overall, I believe that I thought too far ahead here and now we've
been mixing the discussions for different steps from the three-step
approach that we discussed in [1].

In order to make progress here, let me try to disentangle in this mail
which parts we need for the current step (1) and which parts are only
needed for later steps.

[1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2=
a0c023dd761@digikod.net/


On Mon, Jul 24, 2023 at 09:03:42PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On 14/07/2023 00:38, G=C3=BCnther Noack wrote:
> > On Wed, Jul 12, 2023 at 07:48:29PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > A useful split would be at least between devices and regular
> > > files/directories, something like this:
> > > - LANDLOCK_ACCESS_FS_IOCTL_DEV: allows IOCTLs on character or block d=
evices,
> > > which should be targeted on specific paths.
> > > - LANDLOCK_ACCESS_FS_IOCTL_NODEV: allows IOCTLs on regular files,
> > > directories, unix sockets, pipes, and symlinks. These are targeting
> > > filesystems (e.g. ext4's fsverity) or common Linux file types.
> >=20
> > To make sure we are on the same page, let me paraphrase:
> >=20
> > You are suggesting that we should split the LANDLOCK_ACCESS_FS_IOCTL
> > right into a LANDLOCK_ACCESS_FS_IOCTL_DEV part (for block and
> > character devices) and a LANDLOCK_ACCESS_FS_IOCTL_NODEV part (for
> > regular files, directories, named(!) unix sockets, named(!) pipes and
> > symlinks)?  The check would presumably be done during the open(2) call
> > and then store the access right on the freshly opened struct file?
>=20
> Correct

OK, I'll add this to step (1) then.


> > (It is more clearly a philosophy of "protecting resources", rather
> > than a philosophy of limiting access to the thousands of potentially
> > buggy ioctl implementations. - But I think it might be reasonable to
> > permit unnamed pipes and socketpairs - they are useful mechanisms and
> > seem harmless as long as their implementations don't have bugs.)
>=20
> The goal of Landlock is to limit access to new resources (e.g. new FD
> obtained from an existing FD or a path).
>=20
> Unnamed pipes and socketpairs are not a way to (directly) access new kern=
el
> resources/data, hence out of scope for Landlock. Abstract unix sockets wi=
ll
> need to be restricted though, but not with a path_beneath rule (and not
> right now with this patch series).

OK, fair enough.  I can see that this is conceptually cleaner within
Landlock.

Let's go for that approach then, where Landlock only restricts newly
opened path-based files, and where we leave inherited file descriptors
and the ones created through pipe(2), socketpair(2) and timerfds as
they are for now.

It feels like TIOCSTI (and TIOCLINUX) are probably the biggest
problems when it comes to these inherited files.  With some luck,
TIOCSTI will be turned off by distributions soon (and TIOCLINUX only
works on the text console, which is luckily not in use that much).
Fingers crossed.


> > > I think it makes sense because the underlying filesystems should alre=
ady
> > > check for read/write access, which is not the case for block/char dev=
ices.
> > > Pipe and unix socket IOCTLs are quite specific but don't touch the
> > > underlying filesystem, and it should be allowed to properly use them.=
 It
> > > should be noted that the pipe and socket IOCTL implementations don't =
care
> > > about their file mode though; I guess the rationale might be that IOC=
TLs may
> > > be required to (efficiently) either read or write.
> > >=20
> >=20
> > I don't understand your remark about the read/write access.
>=20
> I meant that regular file/directory IOCTLs (e.g. fscrypt) should already
> check for read or write access according to the IOCTL command. This doesn=
't
> seem to be the case for devices because they don't modify and are unrelat=
ed
> to the underlying filesystem.
>=20
>=20
> >=20
> > Pipes have a read end and a write end, where only one of the two
> > operations should work.  Unix sockets are always bidirectional, if I
> > remember this correctly.
>=20
> Yes, but the pipe and socket IOCTL commands don't check if the related FD=
 is
> opened with read nor write.

I still don't understand your remarks about ioctl commands not
checking read and write flags.  To clarify: What you are talking about
is that the implementations of individual ioctl commands should all
check the read and write mode flags on the struct file, is that right?

I'm puzzled how you come to the conclusion that devices don't do such
checks - did you read some ioctl command implementations, or is it a
more underlying principle that I was not aware of so far?

So far, I've always been under the impression that the modes on device
files are also reflected on the associated struct file after they are
opened.  As in, you open a block device for reading to read its
contents, but you need to open it for writing to modify it.  Are these
rights not respected by the ioctl commands?


In any case - I believe the only reason why we are discussing this is
to justify the DEV/NODEV split, and that one in itself is not
controversial to me, even when I admittedly don't fully follow your
reasoning.


> > The thing that struck me about the above list of criteria is that each
> > of them seems to have gaps.  As an example, take timerfds
> > (timerfd_create(2)):
> >=20
> >   * these do not get opened through a file system path, so the *file
> >     path* can not restrict them.
>=20
> >   * they are not character or block devices and do not have a device ID=
.
> >   * they don't match any of the file types in filp->f_mode.
>=20
> Indeed, we may need a way to identify this kind of FD in the future but i=
t
> should not be an issue for now with the path_beneath rules. I guess we co=
uld
> match the anon_inode:[*] name, but I would prefer to avoid using strings.=
 A
> better way to identify this kind of FD would be to pass a similar one in =
a
> rule, in the same way as for path_beneath (as I suggested in a previous
> email).

(In retrospect, the timerfd was a bad example, because it is acquired
through something else than open(2).  I don't currently have an
immediate example at hand for an anon_inode which is reachable through
the file system (except /proc/.../fd).)

Agreed that matching the "anon_inode:*" name would be a hack.  That
does not look like it was meant as a reliable interface.

This discussion seems like it belongs to step (2) and later though, so
wouldn't block the first patch set, I think.


> > So in order to permit the TFD_IOC_SET_TICKS ioctl on them, these three
> > criteria can't be used to describe a timerfd.
>=20
> Correct, and timerfd don't give access to (FS-related) data.
>=20
> If we want to restrict this kind of FD (and if it's worth it), we can fol=
low
> the same approach as for restricting new socket creation. Restricting
> specific IOCTLs on these FDs would require a capability-based approach (c=
f.
> Capsicum): explicitly attach restrictions to a FD, not a process, and the
> mechanism is almost there thanks to the truncate access right patches. It
> would make sense for Landlock to support this kind of FD capabilities, bu=
t
> maybe not right now.

+1 let's discuss in a follow-up patch set.


> > For completeness: I forgot to list here: The other reason where a
> > check during ioctl() is needed is the case as for the timerfd, the
> > pipe(2) and socketpair(2), where a file is created through a simple
> > syscall, but without spelling out a path.  If these kinds of files are
> > in scope for ioctl protection, it can't be done during the open()
> > check alone, I suspect?
>=20
> Correct, but we don't need this kind of restriction for now.

OK


> > > As I explained before, I don't think we should care about inherited o=
r
> > > passed FDs. Other ways to get FDs (e.g. landlock_create_ruleset) shou=
ld
> > > probably not be a priority for now.
> >=20
> > I don't know what we should do about the "basic Unix tool" and
> > TIOCSTI/TIOCLINUX case, where it is possible to gain control over the
> > shell running in the tty that we get as stdout fd.
> >=20
> > I'm in that situation with the little web application I run at home,
> > but the patch that you have sent for GNU tar at some point (and which
> > we should really revive :)) has the same problem: If an attacker
> > manages to do a Remote Code Execution in that tar process, they can
> > ioctl(1, TIOCSTI, ...) their way out into the shell which invoked tar,
> > and which is not restricted with tar's Landlock policy.
> >=20
> > (I don't really see tar create a pty/tty pair either and shovel data
> > between them in a sidecar process or thread, just to protect against
> > that.)
>=20
> Indeed, and that's why sandboxing an application might raise some
> challenges. We should note that a sandboxed application might only be saf=
ely
> used in some cases (e.g. pipe stdio and close other FDs), but I agree tha=
t
> this is not satisfactory for now, and there are still gaps.

OK, I'll make sure it shows up in the documentation.


> > Remark: For the specific TIOCSTI problem, I'm seeing a glimmer of
> > light with this patch set which has appeared in the meantime:
> > https://lore.kernel.org/all/20230710002645.v565c7xq5iddruse@begin/
> > (This will still require that distributions flip that Kconfig option
> > off, but the only(?) known user of TIOCSTI, BRLTTY, would continue
> > working.)
>=20
> I hope most distros are disabling CONFIG_LEGACY_TIOCSTI, otherwise users
> should still be able to tweak the related sysctl.

+1


> > I would be more comfortable with doing the checks only at open(2) time
> > if the above patch landed in distributions so that you would need to
> > have CAP_SYS_ADMIN in order to use TIOCSTI.
> >=20
> > Do you think this is realistic?  If this does not get flipped by
> > distributions, Landlock would continue to have these TIOCSTI problems
> > on these platforms (unless its users do the pty/tty pair thing, but
> > that seems like an unrealistic demand).
>=20
> What if we use an FD to identify an inode with landlock_inode_attr rule? =
We
> could have some flag to "pin" the restriction on this specific FD/inode, =
or
> only match the device type, or the file type=E2=80=A6 We need to think a =
bit more
> about the implications though.

This would also be a later step and not be part of step (1).

The idea of using an FD as an "example" is interesting, but I'm not
fully sold on it yet.  I need to ponder it more.  Some specific
points:

* Creating such FDs might have unwanted side effects, or be
  disproportionally difficult, when they are just created for the
  purpose of defining a Landlock ruleset.

* The matching is unclear to me.  In particular, we've discussed
  before to restrict dev_t ranges (fixed major, range on minor) - I
  don't know how that would be done with this approach.


> >  I don't see how
> > specifying the file type and device ID range as plain numbers could
> > lead to a race condition.
>=20
> No race condition but side channel issues. For instance, a landlocked
> process could infer some file properties by adding and testing a Landlock
> rule even if it is not allowed to read such file properties (because of
> potential Landlock or other restrictions). Using a FD enables Landlock to
> check that the process is indeed allowed to read such properties, or we m=
ay
> decide that it is not necessary to do so.

Understood - so IIUC the scenario is that a process is not permitted
to read file attributes, but it'll be able to infer the device ID by
defining a dev_t-based Landlock rule and then observing whether ioctl
still works.

(I'll also postpone it to step (2) or later then)


> > If yes, I do agree that a list of permitted ioctls is similar to the
> > access rights flags that we already have, and it would have to get
> > passed around in a similar fashion (as "synthetic access rights"),
> > albeit using a different data structure.
> >=20
> > I'm still skeptical of the API approach where we tie previously
> > unrelated rules together, if that is what you mean here.  I find this
> > difficult to explain and reason about.  But in doubt we'll see in the
> > implementation how unwieldy it actually gets.
>=20
> Right, we don't need to implement the synthetic access rights with the
> current step though.

+1 OK

>=20
> >=20
> >=20
> > > > The upside of that approach would be that it could also be used to =
selectively
> > > > restrict specific known-evil ioctls, and letting all others continu=
e to work.
> > > > For example, sandboxing or sudo-like programs could filter out TIOC=
STI and
> > > > TIOCLINUX.
> >=20
> > By the way, selectively restricting known-bad ioctls is still not
> > possible with the approach we discussed now, I think.  Maybe TIOCSTI
> > is the only bad one... I hope.
>=20
> It would not be possible with the landlock_path_beneath_attr, but the
> landlock_inode_attr could be enough.

Will ponder it -- it has the limitation as I said above that it can't
restrict device ranges, but it could be used to apply restrictions to
specific opened inodes.

One difference I see with this approach is that the rights would not
transfer along with the opened file when the files get passed between
processes.  So the policy for that inode would apply to the enforcing
process and its new children, but it would not apply to other
processes which the file is given to.


---

Summarizing this, I believe that the parts that we need for step (1)
are the following ones:

(1) Identify and blanket-permit a small list of ioctl cmds which work
    on all file descriptors (FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC, and
    others?)

    Compare
    https://lore.kernel.org/linux-security-module/6dfc0198-9010-7c54-2699-d=
3b867249850@digikod.net/

(2) Split into LANDLOCK_ACCESS_FS_IOCTL into a ..._DEV and a ..._NODEV part=
.

(3) Point out in documentation that this IOCTL restriction scheme only
    applies to newly opened FDs and in particular point out the common
    use case where that is a TTY, and what to do in this case.

If you agree, I'd go ahead and implement that as step (1) and we can
discuss the more advanced ideas in the context of a follow-up.

Thanks,
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
