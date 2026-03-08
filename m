Return-Path: <linux-fsdevel+bounces-79722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPl6FpitrWkW6AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 18:10:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04952315DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 18:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6E63006780
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B914362151;
	Sun,  8 Mar 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="V5oii2AP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C103921C3
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772989826; cv=pass; b=RAgT00tkNjfeveTL16U4kscrRFumPemsLe2VfJnLft7Zc95KhSjo6ud9z35OkSaYueJqIGPLAp59WYvKN/d1bgyLzxce64qOJ3ou5sxXRQCv7jrBnkmXCN5arCqxSP0k6vTZ2S1M14YiR2cc0h6tUsRmbVcWLHxEOwuv7dSec2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772989826; c=relaxed/simple;
	bh=mPpVNiloCu6uzQI1WxZPytR2t4HpF2nlFZDXYS8kVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1SmQK8j4xxUpFHEXSvp5xk1wzsGKeF/x7x95J0NA3Ke3gC9wNIJVToaYo95SyFYY+9vICsBkmyLwTNFqx5XzXzW14xmDjN1+Sg6nAmaZ+FsW1sJGZvgjURj6hynw26McmVmNZQHr/YD0+9wEYwu0GcjOuMmp7TWjnWMZZccHHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=V5oii2AP; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a140efd2d5so1512762e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 10:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772989821; cv=none;
        d=google.com; s=arc-20240605;
        b=K7SU96PwxoyXNSMCDUchdigKGyH5NpYAFfgCxNK6mEW+WKO+M6W5B4jk36973XedVH
         TwH2czMhsSAElMlpBRmWnYeg+1HW4Ud0uOAosNfUWpHuTG3ZTWgRVfpNJcp8xRJ3WU6D
         REQR3AeMn83juZEkxAaxEhXJ8I6YFR0Jd3OJzFUaPGKHq+xKclUyPIQXMG1m+Nivm9xb
         Q6XNk6PapN2nx2YzGBRkctsTf6B4jKSOL8llFFpROnCJADEgNKH7bZiWMz+FrFOTTLB9
         qH5jL3bkBVESCCdFP93eZOAokKuEosV+f/yPbvFl2J1TZUdgjJg0tyoRM7qH1lviqKeG
         y/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        fh=LqdrWMSC15PYzlrxUwZAPF//l7m+3YswUlYQzO/VMi8=;
        b=R6poAIycfirxPm+G5/yM7qymY3cic2G9xPP7fxeLV4KrDinPCpyQYOczkjK/626LIo
         V9UkMNsPWjtLUh10gk1piueQEnSj8i5XnAF6OsN43O80xlTLeXsvFdg+2NvoXjjF4CcO
         deWrddqwDFF3688VNVi2fciAFaEDXnA0picCuP42v7hnkkB2LOzfcn8lElA3F/aPa0ni
         NbEO2iHEnpYyd1QXZBu4UJIKiCcbOrhksYePoXtwgdSOmzio6K1M+83Xk1S4XDdB3xfU
         IBeaaEtxDa9aGEw2SFvEh3TBpZm+vLWz2wQBvCAfAfW0JIWHRNUT3CbEWHSzfHzVyHPe
         gZcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772989821; x=1773594621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=V5oii2AP7iK/gHbMNDsSVEdYvHWzBqwPyeiCJaSxH80cBJ0weDfC5z5Jac3vnz4xBd
         Tn2ClWoMdMt+leExQaUPFXVNn1yHQ669Vg1RrqJYPh/2X3l9jSvgtmZZiIj1bUZ2IzMa
         dB3alhLex5Auo3ljWEQXqzrJbKBAnpaXzkW8R3j7dH57EQCqLyyRRuNOPBvBnxDwabY1
         PCB7f6Teh/1ED3+YhCaqbNuWa+/ytjyR+MjlDNbb0urQBJvJj9Tgkb8oCphjnt8HYU5m
         JKo9lxiVLkjF2Ntl0hmSDMics51tH/PApK2OBsOlL42naroddrbbIARbX0CgiVbmpphc
         lFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772989821; x=1773594621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=s0OuVlSv0hyawtFRUv8cAqTv0fYHNCX1GyYbSyEhVwMQobrS62zeK75wIyFg1z89G0
         BGx69tC/ECZBSqlOaWVXRD8mTMKYjkOxKG+PpEfxJmk22GE5DeAGvE+IW5lqPrDpTI3q
         KxQgQwdHGUyw2b9nW//tranDXq2HolkLJpL9bCRs7z6p4CFPrEMBt71r2gvv0rU55w/K
         qIXTLvFtUkOVUMBvGN2E5JjODBU38uI95xp7n0NTf1KENL+MzCNnO95KCPFRm1SsXbQf
         bDDWDlJzZa7VhLCvhtNUIa6ryoKrVsa9Ak1Qx1q6PCz8VkMM+8z/evi/4YdCaJbf99iG
         oJjw==
X-Forwarded-Encrypted: i=1; AJvYcCWnqi7kydEAIhIjdK71a4JLZLa6tQirbA68n4j5O2fRlz0TGAwA8L54E5/Zmf7z6+tyyDUTuct/550QmYeC@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/hgLRoeSd4ixpVHPK9dV91cIpOsqwq+85uZac0QQDyWKUXrc
	IuXu2rrAXrnFhEcwzqjK5PWOHRFTBiDPGbfQNtTvjb96WCFR3LK3CqOtRl0i8g9RMvUevapHbbC
	ht3ilIvSxeJTtr5T7/fFDAtRCXIzkcwX2zLkIW4kd
X-Gm-Gg: ATEYQzzDEvRmdgvclPs5kkf5h1fr3STaUB78IWrKHoVlJMhXMg4ncxsH3R9bAFWcahU
	+7MGwHSqyoAhXDPjEbLgy0GyNdouS6xFgAba9JsO5uV5vUlpX//UUKsiyjUaaelSzOy0TzYUN2I
	mFje0VmQa/lr9u/q7XtV7Vgy92dB4ECGChO8aGllgrzuGgk0Dizjs5atxPC/rq5/TTmSG1crEO6
	8iBzVrx1d1hEXSerFmDcEnWv/HFPjtJkYjSKjVdlnchZooXcv2M4udQVJt5I7DOmdwjvaPKGctK
	1nbA8qD1zFbOBPM=
X-Received: by 2002:a05:6512:10c1:b0:5a1:3539:1181 with SMTP id
 2adb3069b0e04-5a13ccc6854mr2584241e87.20.1772989820622; Sun, 08 Mar 2026
 10:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
In-Reply-To: <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 8 Mar 2026 10:10:05 -0700
X-Gm-Features: AaiRm53NE6RSEVl9G8ylA7uki0xCjhtuxwfA8HvbEL_OVbVZXAi0saXeclsKpvo
Message-ID: <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
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
X-Rspamd-Queue-Id: B04952315DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79722-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital-net.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@g=
mail.com> wrote:
> > >
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being
> > > tricked into opening device nodes with special semantics while thinki=
ng
> > > they operate on regular files. This is a requested feature from the
> > > uapi-group[1].
> > >
> >
> > I think this needs a lot more clarification as to what "regular"
> > means.  If it's literally
> >
> > > A corresponding error code EFTYPE has been introduced. For example, i=
f
> > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > like FreeBSD, macOS.
> >
> > I think this needs more clarification as to what "regular" means,
> > since S_IFREG may not be sufficient.  The UAPI group page says:
> >
> > Use-Case: this would be very useful to write secure programs that want
> > to avoid being tricked into opening device nodes with special
> > semantics while thinking they operate on regular files. This is
> > particularly relevant as many device nodes (or even FIFOs) come with
> > blocking I/O (or even blocking open()!) by default, which is not
> > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. =
Consider
> > implementation of a naive web browser which is pointed to
> > file://dev/zero, not expecting an endless amount of data to read.
> >
> > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > where that fd is a memfd?  What about files backed by non-"fast" disk
> > I/O like something on a flaky USB stick or a network mount or FUSE?
> >
> > Are we concerned about blocking open?  (open blocks as a matter of
> > course.)  Are we concerned about open having strange side effects?
> > Are we concerned about write having strange side effects?  Are we
> > concerned about cases where opening the file as root results in
> > elevated privilege beyond merely gaining the ability to write to that
> > specific path on an ordinary filesystem?
> >
>
> Above the use-case, it also says:
>
> "O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
> which opens a file only if it is of type S_IFREG."
>
> Since we allow programs to open a directory under /proc or /sys using
> O_DIRECTORY, I don't think we should do anything different here. To the
> VFS, all of the examples you gave above are S_IFREG "regular files",
> even if they are backed by something quite irregular.

That's certainly a valid and consistent way to define this, but is it usefu=
l?

--Andy

