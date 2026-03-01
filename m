Return-Path: <linux-fsdevel+bounces-78849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMInOThYpGn8eQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 16:16:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543741D05F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 16:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14152301905E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FC3328FB;
	Sun,  1 Mar 2026 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Tb4UsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A792243969
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378146; cv=pass; b=qUu7WJgV7I/Fh33n3seO/W6YPt00y2Cm8CCZvVcokJSB9xYUt9f3JGVCM1/iJuzvQyYslQ1FH3xdPi3+fvCuOqaQBYNjA/Up3AhndsqRnHfp04ysXkb5mzm4DohAZyqMMMLRjT4EiHwatpPJaUCjx1T3a2Te/QyEDAF4hedW9qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378146; c=relaxed/simple;
	bh=dK8JGyYdEozW0hh/3EWXgMcj1Vr2HLjTATqqOgadHrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtFR0Ly+JdDQ6gLLezS92gC/Cpc+0Rgr2VqShZhO9yqGp92p+yhSx7730SLg8efbvkjBgOmqt1EQg7YhoQkMQdOPEr+2fyyyUHNMu7UO1CcwNvE2caQd090LKAifPrajTEwwc94hEJlLm5EbghBOb0E33QOg3/+upOrJ6P6XJ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Tb4UsC; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5674d8be45eso1513365e0c.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 07:15:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378144; cv=none;
        d=google.com; s=arc-20240605;
        b=OA8288CJwtn66um/WDru0gflMEZJWK210S3m+v7EPA1t7oZxAQ11vwiMdh7vOTOhW6
         otTvOAfBOcSl//9zXghOWv5QX25t5rkFZ3hOFoK4ybVa9iTFRLTzwd92pJBPUIzJbMoY
         Yv2VkDVFy/sLnT5z9r9dvbfvE4ieDxn2X7KmTWvZgZvqHF/v2D26Tp7ZE2tLdSw+54ud
         GjT2P4xwiIV76M6JEZaltS2Jpru0Rk/kZqbfWHq5EIsJ3rpx9lde5yS80iTkKT0Lqe6V
         uNBvLuEhM3iZojwIEoU0RgEnh8aYVp8F+wNp1MHo1LjZmxwnGuvqlygATv5EghB8uHr5
         Rytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        fh=QFWmsbLEBGpAi3iKgW5PN5bAARVbq2G6TqNTFlR8KHg=;
        b=KnC5fvZMqLBGwVciUa1TY+ykBHdSjJhGekm2iX53CfoJoFD3sCtoBOcIIK1wjpudJP
         N/Uh/U0K3yT/9xAePBpQ9TOWSBYYvb6gFguhmgCM6klPaAzBiNxTudQkkNKORXBdz2DO
         a7t6zB1JFP+RbypVh+XtZr+q8cPQSqpptBjKEEqbDDOEBGXVGwG6kxhIutoIkrZDwEmU
         GIAATp3hy/47dM9ycwWHdpp6a5WBmmRVCnDUrCvRjXKjR6bfj+laJxkOkFwoJ72hMVN6
         uNio0CTS1sReU1QcY1Hi9yZHulTIj+Nx2USswBGa05BkepgsO6HexjCHhBvQbgkpg/Ss
         uoBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378144; x=1772982944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        b=T6Tb4UsCBoKaXSHjraGm45GXkEbObFYk+ph1wdlfQG/LFBYZt1SeUHXhWo20D16PfS
         9FUbmKVnYP0TZZuQvHGOotnJqb1Uzqa+KsQ3wCele0oIm1SmGjaZ1eztDH0mZMJ1hHRl
         OS71zKgcfzFmR/jfg/iD0Uy9Kpvdwsz4942RiVMq3jbla1ZeQogzLCY4pGylggZaiWo6
         qYIp/8A0K6/+xbCygtkhl6WnOfFWJstxDbCGGiSN1G4e5+HJmQQxW0XqTYnX02RNy2Kn
         +nEJYesrU9Vx+UgQAeh0a6WeDKqoh7lWHltB8sLKZx56O/x2SiYGZJNvY4P32M1sywjw
         7gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378144; x=1772982944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        b=v68WtAX7qQgmq+Dua2sH9SuFF69MtalWXRT0hf5CUEKqHYDOPLBKUCRgTcJUvN786b
         RqZNbL47QFvaibsK/9d7xfdU7JIexDDnI5PmTsLlXR7/8xRa339GjewV0isMi40aquqz
         ZpR9W69Oi7J1G2BQHHK15XyVCkyZBjW2sJs8RB4K7/oY+0MJJ+OIbRAwHyIWEBCO1PxP
         xPMYjtPllYHiHmsULAbNYdff/OdAIhA4i1vzAhCbpLGJywTCsXkyK2tz4/s5z9ln1tNO
         2JQpjwNdUQfh49mXnkrhQeYspbkMagazdy9OAovUK2oNigFWKetaYg/mEz6tTNH2hIiE
         enZw==
X-Gm-Message-State: AOJu0Yz1BxwiIrxxFu6+C8fBdK9bExhec0hi1iGeM9gjT2KKo/MMhdh2
	TfsYsE0xGrW1zijuoHraMuf9i2zfMLgwiGcWMm+3n6b3Gei+QF7Gfo0tP7Ufnk2ADyoHAJCYt/M
	0fhEiLCMHAUy1o3xs5w758I3GUXfpgkY=
X-Gm-Gg: ATEYQzywR6xqcNBTOJwLeILHBtgOQhtnrOT+oJBC6RSD0mmerk0ElQRqTM0M1qdi4Ra
	PROStv1noFfrmuq+L07+sx1WQFgIupB9cFPjniqN3yy60vjrk7+rAZi8/HE0iu7xMRpyhls215R
	E3WcKBzDI3Ya/Vc0JVw61r0XF5BQtpN0vUahoUNSCghpiRzTed9jzYsISJUWCvYG0X1WxILpRpb
	OocFRAjf2CzDnjwP07B4TQCaLBcS3J5LA3+M2k7sBhPVpvhdjIHDy5zzgkkSczVSw2+9AS7aDTx
	Whk9PcqnHNqxPRRRFQ7UVGDSTLdgtMFZpK1RiEELtA==
X-Received: by 2002:a05:6102:510f:b0:5fd:efb0:8563 with SMTP id
 ada2fe7eead31-5ff324dc589mr3714118137.26.1772378143761; Sun, 01 Mar 2026
 07:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com> <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
In-Reply-To: <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:15:32 +0600
X-Gm-Features: AaiRm51uGb22GXl5p3FqZ7NC0pcEYjsHHjv8pL49Bl-0u37YWrXpqgAvLnlZ9vg
Message-ID: <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78849-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 543741D05F2
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 9:10=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:01 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > > > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >
> > > > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > > > This flag indicates the path should be opened if it's a regular=
 file.
> > > > > > This is useful to write secure programs that want to avoid bein=
g
> > > > > > tricked into opening device nodes with special semantics while =
thinking
> > > > > > they operate on regular files. This is a requested feature from=
 the
> > > > > > uapi-group[1].
> > > > > >
> > > > > > A corresponding error code EFTYPE has been introduced. For exam=
ple, if
> > > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the=
 flag
> > > > > > param, it will return -EFTYPE.
> > > > > >
> > > > > > When used in combination with O_CREAT, either the regular file =
is
> > > > > > created, or if the path already exists, it is opened if it's a =
regular
> > > > > > file. Otherwise, -EFTYPE is returned.
> > > > > >
> > > > >
> > > > > It would be good to mention that EFTYPE has precedent in BSD/Darw=
in.
> > > > > When an error code is already supported in another UNIX-y OS, the=
n it
> > > > > bolsters the case for adding it here.
> > > > >
> > > >
> > > > Good suggestion. Yes, I can include this information in the commit
> > > > message during the next posting.
> > > >
> > > > > Your cover letter mentions that you only tested this on btrfs. At=
 the
> > > > > very least, you should test NFS and SMB. It should be fairly easy=
 to
> > > > > set up mounts over loopback for those cases.
> > > > >
> > > >
> > > > I used virtme-ng (which I think reuses the host's filesystem) to ru=
n
> > > > the compiled bzImage and ran the openat2 kselftests there to verify
> > > > it's working. Is there a similar way I can test NFS/SMB by adding
> > > > kselftests? Or would I need to setup NFS/SMB inside a full VM distr=
o
> > > > with a modified kernel to test this? I would appreciate any suggest=
ion
> > > > on this.
> > > >
> > >
> > > I imagine virtme would need some configuration to set up for nfs or
> > > cifs, but maybe it's possible. I mostly use kdevops for this sort of
> > > testing.
> > >
> >
> > Got it. I will try to figure this out and do some testing for NFS/SMB. =
Thanks.
> >
> > > > > There are some places where it doesn't seem like -EFTYPE will be
> > > > > returned. It looks like it can send back -EISDIR and -ENOTDIR in =
some
> > > > > cases as well. With a new API like this, I think we ought to stri=
ve for
> > > > > consistency.
> > > > >
> > > >
> > > > Good point. There was a comment in a previous posting of this patch
> > > > series "The most useful behavior would indicate what was found (e.g=
.,
> > > > a pipe)."
> > > > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp6=
6b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > > > )
> > > > So I thought maybe it would be useful to return -EISDIR where it wa=
s
> > > > already doing that. But it is a good point about consistency that w=
e
> > > > won't be doing this for other different types so I guess it's bette=
r
> > > > to return -EFTYPE for all the cases anyway as you mention. Any
> > > > thoughts?
> > > >
> > >
> > > There is a case to be made for either. The big question is whether yo=
u
> > > can consistently return the same error codes in the same situations.
> > >
> > > For instance, you can return -EISDIR on NFS when the target is a
> > > directory, but can you do the same on btrfs or ceph? If not, then we
> > > have a situation where we have to deal with the possibility of two
> > > different error codes.
> > >
> > > In general, I think returning EFTYPE for everything is simplest and
> > > therefore best. Sure, EISDIR tells you a bit more about the target, b=
ut
> > > that info is probably not that helpful if you were expecting it to be=
 a
> > > regular file.
> > >
> >
> > Good point. I agree. I will fix this and return -EFTYPE for everything
> > in the next posting.
> >
> > > >
> > > > > Should this API return -EFTYPE for all cases where it's not S_IFR=
EG? If
> > > > > not, then what other errors are allowed? Bear in mind that you'll=
 need
> > > > > to document this in the manpages too.
> > > > >
> > > >
> > > > Are the manpages in the kernel git repository or in a separate
> > > > repository? Do I make separate patch series for that? Sorry I don't
> > > > know about this in detail.
> > > >
> > >
> > > Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
> > >
> > > ...come to think of it, you should also cc the linux-api mailing list
> > > when you send the next version:
> > >
> > >     https://www.kernel.org/doc/man-pages/linux-api-ml.html
> > >
> > > This one is fairly straightforward, but once a new API is in a releas=
ed
> > > kernel, it's hard to change things, so we'll want to make sure we get
> > > this right.
> > >
> >
> > I did not know about this. I will cc linux-api mailing list from the
> > next posting.
> >
> > > I should also ask you about testcases here. You should add some tests
> > > to fstests for O_REGULAR if you haven't already:
> > >
> > >     https://www.kernel.org/doc/man-pages/linux-api-ml.html
> > >
> >
> > I only added a kselftest for the new flag in
> > tools/testing/selftests/openat2/openat2_test.c in my second commit in
> > this patch series. Where are the fstests that I should add tests? I
> > think you added the wrong URL above, probably a typo.
> >
> >
>
> I did indeed, sorry. They're here:
>
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>

Thanks! This is a separate git repository, so I guess for both
manpages and fstests I need to submit separate patch series for
O_REGULAR. Do I need to wait first for this patch series to be merged?
How does it work?

Regards,
Dorjoy

