Return-Path: <linux-fsdevel+bounces-17754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F428B21C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70882830AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316E1494C3;
	Thu, 25 Apr 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VS2JAjlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D712BF04;
	Thu, 25 Apr 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048810; cv=none; b=bZlljtHcokslMiauyEFnTu+e9JqoQc/3SsrEaHk4h/O1jipO/5pWXvy0YXZ2iNpmW806fX7WOR90yfnqlW3lQdon/ioEA9h/qisdTYG4EW3GDU0MKpZXanugeUq/u6So9oOJSa+mFGC2kWqM1fUXWM4NQUMB0rQJk2gQ98Xhzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048810; c=relaxed/simple;
	bh=6vkPmtDiLE+/0ji3+ctV49AgPYWn3Mz5TJN/ESYCMos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxpvbdtaQtKVZiOLZ2IYBrzAZrL+4cnKCckDYxEUB+M9hNWSvsij2gFpk1oLFpyDGZL9RhxuX/2iE5QF1lvHdQ/8Xdt3nvVqYl1oKAEH1f9I6k3FWWbkcPscUkFUO9PXSyoAhkaNnRZa4jb0Jt1HN/lU3XFJOEqs/Xk8qvPyhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VS2JAjlp; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c0e:0:640:c281:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id 1866561532;
	Thu, 25 Apr 2024 15:39:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tdLplpYVsKo0-YxQbXXna;
	Thu, 25 Apr 2024 15:39:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714048797; bh=bcA6ElicbT39XJDeRPmuUikJSa8KgSxn19jArvtuNfg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=VS2JAjlpNHO4g0QFJPCVOac0ldhMWQ9eQr28iHEADsrdWY2iu28fW33yGZ6mQ3bj7
	 ggh3ZF75iIMTd0ZHoztyQmzsawi+V1fg8zWpY8o2G0md4HczmY1gLrN1RqPVQj/v82
	 fH3JVA77UI0fjmWePCpqcfODngkm/Avxe7p9tvEA=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8b136077-af77-4371-9e67-7ae339efc3c1@yandex.ru>
Date: Thu, 25 Apr 2024 15:39:54 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] implement OA2_INHERIT_CRED flag for openat2()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424-schummeln-zitieren-9821df7cbd49@brauner>
 <6b46528a-965f-410a-9e6f-9654c5e9dba2@yandex.ru>
 <20240425-ausfiel-beabsichtigen-a2ef9126ebda@brauner>
 <df51f2fd-385a-47bf-a072-a8988a801d52@yandex.ru>
 <20240425-loslassen-hexen-a1664a579ea1@brauner>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240425-loslassen-hexen-a1664a579ea1@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.04.2024 15:08, Christian Brauner пишет:
>> But I am sure you still don't understand
>> what exactly the patch does, so why not
>> to ask instead of asserting?
>> You say uid/gid can be stolen, but no,
>> it can't: the creds are reverted. Only
>> fsuid/fsgid (and caps in v2 of the patch)
>> actually affect openat2(), but nothing is
>> "leaked" after openat2() finished.
> I say "stolen" because the original opener has no say in this.

The initial idea was to keep this all
within a single-process boundary. It
wasn't coded that way though. :(


>   You're
> taking their fsuid/fsgid and groups and overriding creds for the
> duration of the lookup and open. Something the original opener never
> consented to. But let's call it "borrowed" if you're hung up on
> terminology here.

Not a terminology: you were explicitly
talking about uid/gid, blaming a v2 of
my patch. But v2 was not any more
harmful than others and uid/gid cannot
be leaked even there.
But I don't mind: if now you realize v2
is not a leak for uid/gid, then we are on
the same track.

> But ultimately it's the same complaint: the original opener has no way
> of controlling this behavior.

It wasn't clear if the opener should
control that behaviour, or maybe instead
that all should be limited within a single
process?
Andy Lutomirski's explanation made it
clear that even if the openers are the
same, the control is still needed. So now
this argument is undeniable.


>   Once ignored in my first reply, and now
> again conveniently cut off again. Let alone all the other objections.

Sorry but your complains were about
stealing uid/gid in v2, which were clearly
wrong. But this is a matter of the past.

> And fwiw, the same way you somehow feel like I haven't read your patch
> it seems you to consistently underestimate the implications of this
> change. Which is really strange because it's pretty obvious. It's
> effectively temporary setuid/setgid with some light limitations.

Temporary cred override is quite common
within the current code AFAICS when I grep
it for override_creds() call.

> Leaking directory descriptors across security boundaries becomes a lot
> more interesting with this patch applied. Something which has happened
> multiple times already and heavily figures in container escapes. And the
> RESOLVE_BENEATH/IN_ROOT restrictions only stave off symlink (and magic
> link) attacks. If a directory fd is leaked a container can take the
> fsuid/fsgid/groups from the original opener of that directory and write
> to disk with whatever it resolves to in that namespace's idmapping. It's
> basically a nice way to puzzle together arbitrary fsuid/fsgid and
> idmapping pairs in whatever namespace the opener happens to be in.

Yes, so the opt-in flag is undeniably needed.

> And to the "unsuspecting userspace" point you dismissed earlier.
> Providing a dirfd to a lesser privileged process isn't horrendously
> dangerous right now. But with this change it sure is. For stuff like
> libpathrs or systemd's fdstore this change has immediate security
> implications.

So am I getting your point correctly:
- process A uses the opt-in flag (eg O_CAPTURE_CREDS)
   and passes the fd to "unsuspecting userspace" B.
- process B is not going to use O_INHERIT_CREDS,
   but it now still can't drop his privs fully.

Is this what you mean?


