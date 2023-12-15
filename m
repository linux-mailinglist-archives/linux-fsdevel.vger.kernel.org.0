Return-Path: <linux-fsdevel+bounces-6199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A919814D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBE41C23A48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A63EA6B;
	Fri, 15 Dec 2023 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxQBuYC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5693DBAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d18c224c7so635869eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702659051; x=1703263851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spsG0fp89AEtdWztNXrVBUOH8tH8IrGxk4x4Y0wkeuQ=;
        b=hxQBuYC94WSAIx1HRniTDIhuDWSXcuDs3t+BOW17SVx6KegGBctaNN9+7LGUoYK4/2
         2YvcU55xs6onElQXeoiQjBuKvjSZr5AwdFdoi/6fdKfAIXUh4LHC7DNZ4vxEnyIXeLCA
         qCZfxJhI4iDKu6vMBO0/5Ilrz1Hj1dcguotSFe746PYzVp6HJhSkBfgUjcpSDZSMG9UX
         KcI65udM0SWk5Bh38CXiG2Vp+OzGZtPS7EZWs+bH7OA7msGeZpxanyeikW3BxIX2H8Lg
         er1WNao6rWTr7y+kEL3IrFALrZhOnbKlgt5/QAzIxdhCAe0LFyhx2RtkKTQP2ROU8JKo
         JIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659051; x=1703263851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spsG0fp89AEtdWztNXrVBUOH8tH8IrGxk4x4Y0wkeuQ=;
        b=fRzoWAIqWzkkGJWfA4EdoRAXVI29YXtYQF2f3/Lx7BzNq3A71KD9XIskUn4GOFNVkl
         bDrqPUQ1rHJuk4377VHOwfMHElV4BCmvckQ4ntxg5OrokpEUM7bkOsigGHIyVT6KI9dy
         GcFu8IUSI4l3kMXRX6y5NdKHMgS34zFtUfJO2caIauhEZHRaz0U0538DcrlvYUTQkQCA
         GML7gx/1UhDeankt+a+9P12YN7qcEUxfCNRpqlu88KRaH/Yr6gSN+JIB6n0VoySz+rdN
         Nv5pLNy9LJiqGUk5UpEdYQoOmrywmAX2UH7Uv/HDfuoow2dm0u7Yho3z67A+w3X2b5Jo
         iQiw==
X-Gm-Message-State: AOJu0YwuQQ+2bnHp+O6SGdDsnT4e1VbOEwvXoPdFFuYaARSqmifmuddf
	tCqoUHJXALlgtIyFhvCP2VFKCpAinLGAAQAUV1um4qkFLrw=
X-Google-Smtp-Source: AGHT+IEnvW3rpZcyDmQ1bNHK5w27AuSQmApfbJA2rFCWqwz7E3sB8WQzY+IuQJt6aUQcF+M20/yKDef/sZNjbXDSi9g=
X-Received: by 2002:a05:6358:a087:b0:170:ef27:c0e1 with SMTP id
 u7-20020a056358a08700b00170ef27c0e1mr5658720rwn.12.1702659051230; Fri, 15 Dec
 2023 08:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208080135.4089880-1-amir73il@gmail.com> <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com> <20231215153108.GC683314@perftesting>
In-Reply-To: <20231215153108.GC683314@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Dec 2023 18:50:39 +0200
Message-ID: <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:31=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Dec 13, 2023 at 09:09:30PM +0200, Amir Goldstein wrote:
> > On Wed, Dec 13, 2023 at 7:28=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> > > > With FAN_DENY response, user trying to perform the filesystem opera=
tion
> > > > gets an error with errno set to EPERM.
> > > >
> > > > It is useful for hierarchical storage management (HSM) service to b=
e able
> > > > to deny access for reasons more diverse than EPERM, for example EAG=
AIN,
> > > > if HSM could retry the operation later.
> > > >
> > > > Allow userspace to response to permission events with the response =
value
> > > > FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom error=
.
> > > >
> > > > The change in fanotify_response is backward compatible, because err=
no is
> > > > written in the high 8 bits of the 32bit response field and old kern=
els
> > > > reject respose value with high bits set.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > So a couple of comments that spring to my mind when I'm looking into =
this
> > > now (partly maybe due to my weak memory ;):
> > >
> > > 1) Do we still need the EAGAIN return? I think we have mostly dealt w=
ith
> > > freezing deadlocks in another way, didn't we?
> >
> > I was thinking about EAGAIN on account of the HSM not being able to
> > download the file ATM.
> >
> > There are a bunch of error codes that are typical for network filesyste=
ms, e.g.
> > ETIMEDOUT, ENOTCONN, ECONNRESET which could be relevant to
> > HSM failures.
> >
> > >
> > > 2) If answer to 1) is yes, then there is a second question - do we ex=
pect
> > > the errors to propagate back to the unsuspecting application doing sa=
y
> > > read(2) syscall? Because I don't think that will fly well with a big
> > > majority of applications which basically treat *any* error from read(=
2) as
> > > fatal. This is also related to your question about standard permissio=
n
> > > events. Consumers of these error numbers are going to be random
> > > applications and I see a potential for rather big confusion arising t=
here
> > > (like read(1) returning EINVAL or EBADF and now you wonder why the he=
ll
> > > until you go debug the kernel and find out the error is coming out of
> > > fanotify handler). And the usecase is not quite clear to me for ordin=
ary
> > > fanotify permission events (while I have no doubts about creativity o=
f
> > > implementors of fanotify handlers ;)).
> > >
> >
> > That's a good question.
> > I prefer to delegate your question to the prospect users of the feature=
.
> >
> > Josef, which errors did your use case need this feature for?
> >
> > > 3) Given the potential for confusion, maybe we should stay conservati=
ve and
> > > only allow additional EAGAIN error instead of arbitrary errno if we n=
eed it?
> > >
> >
> > I know I was planning to use this for EDQUOT error (from FAN_PRE_MODIFY=
),
> > but I certainly wouldn't mind restricting the set of custom errors.
> > I think it makes sense. The hard part is to agree on this set of errors=
.
> >
>
> I'm all for flexibility here.
>
> We're going to have 2 classes of applications interacting with HSM backed
> storage, normal applications and applications that know they're backed by=
 HSM.
> The normal applications are just going to crash if they get an error on r=
ead(2),
> it doesn't matter what errno it is.  The second class would have differen=
t
> things they'd want to do in the face of different errors, and that's what=
 this
> patchset is targeting.  We can limit it to a few errno's if that makes yo=
u feel
> better, but having more than just one would be helpful.
>

Ok. In another email I got from your colleagues, they listed:
EIO, EAGAIN, ENOSPC as possible errors to return.
I added EDQUOT for our in house use case.

Those are all valid errors for write(2) and some are valid for read(2).
ENOSPC/EDQUOT make a lot of sense for HSM for read(2), but could
be surprising to applications not aware of HSM.
I think it wouldn't be that bad if we let HSM decide which of those errors
to return for FAN_PRE_ACCESS as opposed to FAN_PRE_MODIFY.

But given that we do want to limit the chance of abusing this feature,
perhaps it would be best to limit the error codes to known error codes
for write(2) IO failures (i.e. not EBADF, not EFAULT) and allow returning
FAN_DENY_ERRNO only for the new FAN_PRE_{ACCESS,MODIFY}
HSM events.

IOW, FAN_{OPEN,ACCESS}_PERM - no FAN_DENY_ERRNO for you!

Does that sound good to you?

Furthermore, we can start with allowing a very limited set of errors
and extend it in the future, on case by case basis.

The way that this could be manageable is if we provide userspace
a way to test for supported return codes.

There is already a simple method that we used for testing FAN_INFO
records type support -
After fan_fd =3D fanotify_init(), userspace can write a "test" fanotify_res=
ponse
to fan_fd with fanotify_response.fd=3DFAN_NOFD.

When setting fanotify_response.fd=3DFAN_DENY, this would return ENOENT,
but with fanotify_response.fd=3DFAN_DENY_ERRNO(EIO), upstream would
return EINVAL.

This opens the possibility of allowing, say, EIO, EAGAIN in the first relea=
se
and ENOSPC, EDQUOT in the following release.

The advantage in this method is that it is very simple and already working
correctly for old kernels.

The downside is that this simple method does not allow checking for allowed
errors per specific event type, so if we decide that we do want to
allow returning
FAN_DENY_ERRNO for FAN_OPEN_PERM later on, this method could not
be used by userspace to test for this finer grained support.

In another thread, I mention the fact that FAN_OPEN_PERM still has a
potential freeze deadlock when called from open(O_TRUNC|O_CREATE),
so we can consider the fact that FAN_DENY_ERRNO is not allowed with
FAN_OPEN_PERM as a negative incentive for people to consider using
FAN_OPEN_PERM as a trigger for HSM.

Thoughts?

Thanks,
Amir.

