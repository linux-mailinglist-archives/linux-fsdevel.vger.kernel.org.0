Return-Path: <linux-fsdevel+bounces-17721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A218B1BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09BAB21B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FC6CDC8;
	Thu, 25 Apr 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hdam2PgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C556BFBC;
	Thu, 25 Apr 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029888; cv=none; b=Dv4AuYmTnRILTf1LKYTzcoqa2RFW+Wwp4326zX3Yn5hSCwy35O3WRAOWusEU0UfgL0l6FbFd8ooK6RJi7RfyHlNL5WO8AmPTh0/QHVFYyBO4NBCc2V9qYPJOkA7E21mzvSQX0Z8hcIxUYgqSx1cH1EV+1xJqBIMFITOBD/5vB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029888; c=relaxed/simple;
	bh=CjtZI7wWLGqJ5+XYn8iIRWrfe8W/XZ94e7ffMamGKvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBCco4SMGDJxzQME/jfL40q3JOk3Y/rGU/KAwfcHNIjkqiC6U2B/gzqSsOd2+cm9JcHhUB7T/91/h0tctWwKicLSqVGnngZjSqac2YPKGYZMg/QWzrDSvC053+tjnYBczW5sdTE8QnWBRcJZtRSpi7VOMVunXhn8BIFCfT29Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=hdam2PgX; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4d9c:0:640:f3a0:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 8C8A16162D;
	Thu, 25 Apr 2024 10:24:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bOG6gGioGOs0-jNjVOVWO;
	Thu, 25 Apr 2024 10:24:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714029879; bh=jLLUQDrLxe3HEYl361v9/pXQdC+WWf+JkjjMbghvWPo=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=hdam2PgXB6ee2zxNRoaWK+rJfrp3ym/nhzEXaTE61WP6EANyBIAZU/gKxSs9cgOtv
	 ncys4KZq1HSKNpVOcaW/l5rEkTzd8xFE/2GAZqNhk+TvZfJuOc5cfEHRQmaUd1iua0
	 ua/cqByIHDk5CtWx5tVOjPX3g3UxV1mS499vCs7w=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d1686d9d-b403-4985-bcaa-41d4f45a8ac0@yandex.ru>
Date: Thu, 25 Apr 2024 10:24:37 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424105248.189032-3-stsp2@yandex.ru> <20240425023127.GH2118490@ZenIV>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240425023127.GH2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.04.2024 05:31, Al Viro пишет:
> Consider the following, currently absolutely harmless situation:
> 	* process is owned by luser:students.
> 	* descriptor 69 refers to root-opened root directory (O_RDONLY)
> What's the expected result of
> 	fcntl(69, F_SEFTD, O_CLOEXEC);
> 	opening "etc/shadow" with dirfd equal to 69 and your flag given
> 	subsequent read() from the resulting descriptor?
>
> At which point will the kernel say "go fuck yourself, I'm not letting you
> read that file", provided that attacker passes that new flag of yours?
>
> As a bonus question, how about opening it for _write_, seeing that this
> is an obvious instant roothole?
>
> Again, currently the setup that has a root-opened directory in descriptor
> table of a non-root process is safe.
>
> Incidentally, suppose you have the same process run with stdin opened
> (r/o) by root.  F_SETFD it to O_CLOEXEC, then use your open with
> dirfd being 0, pathname - "" and flags - O_RDWR.

Ok, F_SETFD, how simple. :(

> AFAICS, without an explicit opt-in by the original opener it's
> a non-starter, and TBH I doubt that even with such opt-in (FMODE_CRED,
> whatever) it would be a good idea - it gives too much.
Yes, which is why I am quite sceptical
to this FMODE_CRED idea.

Please note that my O_CLOEXEC check
actually meant to check that exactly this
process have opened the dir. It just didn't
happen that way, as you pointed.
Can I replace the O_CLOEXEC check with
some explicit check that makes sure the
fd was opened by exactly that process?

