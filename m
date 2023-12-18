Return-Path: <linux-fsdevel+bounces-6386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B196817661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0301F272CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49237872;
	Mon, 18 Dec 2023 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1oMIENr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA063A1B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f2fc389e6so11505626d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702914844; x=1703519644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aBr9jKVEQIUupWAnMbinGlSrwHJkGh6Spd7D8mc4xM=;
        b=X1oMIENrbsMi0bdHKqOLp2N32bfNK74frtvUmB1tpm/OdFwpO96ILt+wubqihZIQEp
         +uF58DrhrAtteDMej+xnYg1hEIOg70tGqVw5KBoFrb/4MOnpZW7Pm8V5YcLA8YsbP7mM
         9HLsZ+QpSHkiDec1A9KohXMeOtQf8Lx9Z3pjfgqHe71+kVXxxnzymfi4UptyjE37FCWJ
         t3zoKw8dtqQIydqAr2FykLLevwHDL9v8/OclnCBv9PE1ai2digvaHaUbVm1805wBC9TC
         dhVdB9j2mfWy0eE8K2P7pkm2xIq2V0DznEjWj0XD8CFHjm77Y/wql+E/X8tmT/j5gXUS
         XJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914844; x=1703519644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aBr9jKVEQIUupWAnMbinGlSrwHJkGh6Spd7D8mc4xM=;
        b=K6gfENO4PwJNy+/FW1VixLYMHhJfDC7o69HawlC5ZqAEGzets9ytGoTlYLcOcWJB/W
         ICUkfFZVG5UMBMy/8TycguGUayv4Myrzh/7Gdo1idfgdcM+iMv+h6ha9I7t0eBUm/2MC
         Bj47aNEBb1+Op5Ggcm2aSfgWctAxUXpc/pE3d19rmUzLFFrxCAbZyicgc4MJWWNh6Bp9
         +A6rFeBYA41FMmSPm+EcjWKjwtMy3qlo24nWWBE+F4zTtoAHQ4Btd7xs0/iEiKYb4pHV
         QAsDw3I3x5XBDuUPGNekSB8QacR2qZ+rO7ISLTi//+O6cAyqS8rkwoxaBd4nCTE5PYX3
         XMTQ==
X-Gm-Message-State: AOJu0YynQYYWZlDId1f1BadhkDFTP9R5741CcENvJ/VmH4QyuEQ2hH/v
	dN1Zf1TjwP2g8GWe8jXONG9psUDg47CtstFP/UI=
X-Google-Smtp-Source: AGHT+IGwjJJb6smgn9B0VBu14dwxlw4pBwWKmhj8/wDdTM9X5ZUdBLb9Jjfyr+8FqA6VZMCiBdqs50dU2+lIW+5kuBA=
X-Received: by 2002:a05:6214:d82:b0:67f:345f:79cc with SMTP id
 e2-20020a0562140d8200b0067f345f79ccmr3331701qve.81.1702914843969; Mon, 18 Dec
 2023 07:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208080135.4089880-1-amir73il@gmail.com> <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting> <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3>
In-Reply-To: <20231218143504.abj3h6vxtwlwsozx@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 Dec 2023 17:53:52 +0200
Message-ID: <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:35=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 15-12-23 18:50:39, Amir Goldstein wrote:
> > On Fri, Dec 15, 2023 at 5:31=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 09:09:30PM +0200, Amir Goldstein wrote:
> > > > On Wed, Dec 13, 2023 at 7:28=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> > > > > > With FAN_DENY response, user trying to perform the filesystem o=
peration
> > > > > > gets an error with errno set to EPERM.
> > > > > >
> > > > > > It is useful for hierarchical storage management (HSM) service =
to be able
> > > > > > to deny access for reasons more diverse than EPERM, for example=
 EAGAIN,
> > > > > > if HSM could retry the operation later.
> > > > > >
> > > > > > Allow userspace to response to permission events with the respo=
nse value
> > > > > > FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom e=
rror.
> > > > > >
> > > > > > The change in fanotify_response is backward compatible, because=
 errno is
> > > > > > written in the high 8 bits of the 32bit response field and old =
kernels
> > > > > > reject respose value with high bits set.
> > > > > >
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > So a couple of comments that spring to my mind when I'm looking i=
nto this
> > > > > now (partly maybe due to my weak memory ;):
> > > > >
> > > > > 1) Do we still need the EAGAIN return? I think we have mostly dea=
lt with
> > > > > freezing deadlocks in another way, didn't we?
> > > >
> > > > I was thinking about EAGAIN on account of the HSM not being able to
> > > > download the file ATM.
> > > >
> > > > There are a bunch of error codes that are typical for network files=
ystems, e.g.
> > > > ETIMEDOUT, ENOTCONN, ECONNRESET which could be relevant to
> > > > HSM failures.
> > > >
> > > > >
> > > > > 2) If answer to 1) is yes, then there is a second question - do w=
e expect
> > > > > the errors to propagate back to the unsuspecting application doin=
g say
> > > > > read(2) syscall? Because I don't think that will fly well with a =
big
> > > > > majority of applications which basically treat *any* error from r=
ead(2) as
> > > > > fatal. This is also related to your question about standard permi=
ssion
> > > > > events. Consumers of these error numbers are going to be random
> > > > > applications and I see a potential for rather big confusion arisi=
ng there
> > > > > (like read(1) returning EINVAL or EBADF and now you wonder why th=
e hell
> > > > > until you go debug the kernel and find out the error is coming ou=
t of
> > > > > fanotify handler). And the usecase is not quite clear to me for o=
rdinary
> > > > > fanotify permission events (while I have no doubts about creativi=
ty of
> > > > > implementors of fanotify handlers ;)).
> > > > >
> > > >
> > > > That's a good question.
> > > > I prefer to delegate your question to the prospect users of the fea=
ture.
> > > >
> > > > Josef, which errors did your use case need this feature for?
> > > >
> > > > > 3) Given the potential for confusion, maybe we should stay conser=
vative and
> > > > > only allow additional EAGAIN error instead of arbitrary errno if =
we need it?
> > > > >
> > > >
> > > > I know I was planning to use this for EDQUOT error (from FAN_PRE_MO=
DIFY),
> > > > but I certainly wouldn't mind restricting the set of custom errors.
> > > > I think it makes sense. The hard part is to agree on this set of er=
rors.
> > > >
> > >
> > > I'm all for flexibility here.
> > >
> > > We're going to have 2 classes of applications interacting with HSM ba=
cked
> > > storage, normal applications and applications that know they're backe=
d by HSM.
> > > The normal applications are just going to crash if they get an error =
on read(2),
> > > it doesn't matter what errno it is.  The second class would have diff=
erent
> > > things they'd want to do in the face of different errors, and that's =
what this
> > > patchset is targeting.  We can limit it to a few errno's if that make=
s you feel
> > > better, but having more than just one would be helpful.
> >
> > Ok. In another email I got from your colleagues, they listed:
> > EIO, EAGAIN, ENOSPC as possible errors to return.
> > I added EDQUOT for our in house use case.
>
> OK, so do I get it right that you also have applications that are aware
> that they are operation on top of HSM managed filesystem and thus they ca=
n
> do meaningful things with the reported errors?
>

Some applications are HSM aware.
Some just report the errors that they get which are meaningful to users.
EIO is the standard response for HSM failure to fill content.

EDQUOT/ENOSPC is a good example of special functionality.
HSM "swaps out" file content to a slow remote tier, but the slow remote
tier may have a space/quota limit that is known to HSM.

By tracking the total of st_size under some HSM managed folder, including
the st_size of files whose content is punched out, HSM can enforce this lim=
it
not in the conventional meaning of local disk blocks usage.

This is when returning EDQUOT/ENOSPC for FAN_PRE_MODIFY makes
sense to most users/applications, except for ones that try to create
large sparse
files...


> > Those are all valid errors for write(2) and some are valid for read(2).
> > ENOSPC/EDQUOT make a lot of sense for HSM for read(2), but could
> > be surprising to applications not aware of HSM.
> > I think it wouldn't be that bad if we let HSM decide which of those err=
ors
> > to return for FAN_PRE_ACCESS as opposed to FAN_PRE_MODIFY.
>
> Yeah, I don't think we need to be super-restrictive here, I'd just prefer
> to avoid the "whatever number you decide to return" kind of interface
> because I can see potential for confusion and abuse there. I think all fo=
ur
> errors above are perfectly fine for both FAN_PRE_ACCESS and FAN_PRE_MODIF=
Y
> if there are consumers that are able to use them.
>
> > But given that we do want to limit the chance of abusing this feature,
> > perhaps it would be best to limit the error codes to known error codes
> > for write(2) IO failures (i.e. not EBADF, not EFAULT) and allow returni=
ng
> > FAN_DENY_ERRNO only for the new FAN_PRE_{ACCESS,MODIFY}
> > HSM events.
> >
> > IOW, FAN_{OPEN,ACCESS}_PERM - no FAN_DENY_ERRNO for you!
> >
> > Does that sound good to you?
>
> It sounds OK to me. I'm open to allowing FAN_DENY_ERRNO for FAN_OPEN_PERM
> if there's a usecase because at least conceptually it makes a good sense
> and chances for confusion are low there. People are used to dealing with
> errors on open(2).
>

I wrote about one case I have below.

> > Furthermore, we can start with allowing a very limited set of errors
> > and extend it in the future, on case by case basis.
> >
> > The way that this could be manageable is if we provide userspace
> > a way to test for supported return codes.
> >
> > There is already a simple method that we used for testing FAN_INFO
> > records type support -
> > After fan_fd =3D fanotify_init(), userspace can write a "test" fanotify=
_response
> > to fan_fd with fanotify_response.fd=3DFAN_NOFD.
> >
> > When setting fanotify_response.fd=3DFAN_DENY, this would return ENOENT,
> > but with fanotify_response.fd=3DFAN_DENY_ERRNO(EIO), upstream would
> > return EINVAL.
> >
> > This opens the possibility of allowing, say, EIO, EAGAIN in the first r=
elease
> > and ENOSPC, EDQUOT in the following release.
>
> If we forsee that ENOSPC and EDQUOT will be needed, then we can just enab=
le
> it from start and not complicate our lives more than necessary.
>

Sure, I was just giving an example how the list could be extended case by c=
ase
in the future.

> > The advantage in this method is that it is very simple and already work=
ing
> > correctly for old kernels.
> >
> > The downside is that this simple method does not allow checking for
> > allowed errors per specific event type, so if we decide that we do want
> > to allow returning FAN_DENY_ERRNO for FAN_OPEN_PERM later on, this meth=
od
> > could not be used by userspace to test for this finer grained support.
>
> True, in that case the HSM manager would have to try responding with
> FAN_DENY_ERRNO() and if it fails, it will have to fallback to responding
> with FAN_DENY. Not too bad I'd say.
>

Yeah that works too.

> > In another thread, I mention the fact that FAN_OPEN_PERM still has a
> > potential freeze deadlock when called from open(O_TRUNC|O_CREATE),
> > so we can consider the fact that FAN_DENY_ERRNO is not allowed with
> > FAN_OPEN_PERM as a negative incentive for people to consider using
> > FAN_OPEN_PERM as a trigger for HSM.
>
> AFAIU from the past discussions, there's no good use of FAN_OPEN_PERM
> event for HSM. If that's the case, I'm for not allowing FAN_DENY_ERRNO fo=
r
> FAN_OPEN_PERM.

In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
to deny open of file during the short time that it's content is being
punched out [1].
It is quite complicated to explain, but I only used it for denying access,
not to fill content and not to write anything to filesystem.
It's worth noting that returning EBUSY in that case would be more meaningfu=
l
to users.

That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PERM,
but mainly I do not have a proof that people will not need it.

OTOH, I am a bit concerned that this will encourage developer to use
FAN_OPEN_PERM as a trigger to filling file content and then we are back to
deadlock risk zone.

Not sure which way to go.

Anyway, I think we agree that there is no reason to merge FAN_DENY_ERRNO
before FAN_PRE_* events, so we can continue this discussion later when
I post FAN_PRE_* patches - not for this cycle.

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Ma=
nagement-API#invalidating-local-cache

