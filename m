Return-Path: <linux-fsdevel+bounces-23262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806499294E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B71F282869
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ABB13C684;
	Sat,  6 Jul 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akzRTMeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF41367;
	Sat,  6 Jul 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720286939; cv=none; b=PdKGTR51aT1UPsNEC5OzZqJ/EWerUQgbojC6hLbBxuCp2yd3mma6xNGuwx39J1RoTh3p9E0AWdaa8RJEqjEvQ3MI5uk1YU4+hzxChTeaY++1dEoWQi5rUkAx7laAg/F2S/eos4Ypbr2Nxxt0AJoytLDqBtkDAO2ejLs95h/IkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720286939; c=relaxed/simple;
	bh=WdzuamgoIootbjf07by/2xiSURnDRW+FI7ilwWPWlBg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I92k3Vp3UZj86A1g9RKkq/Ltg6DO1bcXPMI0VYTndD3pxJjLoSFI4AX5SQUwE4bf7oju9/WsDeiLXhyWupfVsUaxO/Q1gjgV2HveM5LPd5ZM8tn1ecwj3td79ipjasrEi+uxYdyGGpN3eBZ9oNYs3RhIUZFzzyytXoLEnW6Kaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akzRTMeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A63C2BD10;
	Sat,  6 Jul 2024 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720286938;
	bh=WdzuamgoIootbjf07by/2xiSURnDRW+FI7ilwWPWlBg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=akzRTMeRmXx76KyqTKZc34H0wT5VK28EgYqgyVwqIKtpldflk6XEYUdsrOoAKMX/o
	 Xiuythw1Oqog64fPmMNepciFfjWKsmaY0Ib9gzNbG7siBq0NzPpiJecLUuGxX7Csh+
	 bdZ2uI78vVhzZbQChmfxtlq14A7Rd8fEsVXELoicCqmQHZLmk4347Lhws+597EPx4p
	 kWgK4VmZW2WeTqhdfWiLY2/JLQRK37sVdfYkGv5JqF/dh56KSkLNCtWvf68ZVQOUAX
	 Gib/F+y+t7Hr8KKM4k9fH/nZSOCa3+H4GZ/9lcuhiU+/7NEK/Ckwqlqq4u3plwYrM1
	 JS+EqWjht7lwA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Jul 2024 20:28:46 +0300
Message-Id: <D2IMTK0QXAHK.UPUAI5CPLJG1@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Paul Moore" <paul@paul-moore.com>,
 "Theodore Ts'o" <tytso@mit.edu>, "Alejandro Colomar" <alx@kernel.org>,
 "Aleksa Sarai" <cyphar@cyphar.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andy Lutomirski" <luto@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Casey Schaufler" <casey@schaufler-ca.com>,
 "Christian Heimes" <christian@python.org>, "Dmitry Vyukov"
 <dvyukov@google.com>, "Eric Biggers" <ebiggers@kernel.org>, "Eric Chiang"
 <ericchiang@google.com>, "Fan Wu" <wufan@linux.microsoft.com>, "Florian
 Weimer" <fweimer@redhat.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "James Morris" <jamorris@linux.microsoft.com>, "Jan Kara" <jack@suse.cz>,
 "Jann Horn" <jannh@google.com>, "Jeff Xu" <jeffxu@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Jordan R Abrahams" <ajordanr@google.com>,
 "Lakshmi Ramasubramanian" <nramas@linux.microsoft.com>, "Luca Boccassi"
 <bluca@debian.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>, "Matt Bobrowski"
 <mattbobrowski@google.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Miklos Szeredi"
 <mszeredi@redhat.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Nicolas
 Bouchinet" <nicolas.bouchinet@ssi.gouv.fr>, "Scott Shell"
 <scottsh@microsoft.com>, "Shuah Khan" <shuah@kernel.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>, "Steve Dower" <steve.dower@python.org>,
 "Steve Grubb" <sgrubb@redhat.com>, "Thibaut Sautereau"
 <thibaut.sautereau@ssi.gouv.fr>, "Vincent Strubel"
 <vincent.strubel@ssi.gouv.fr>, "Xiaoming Ni" <nixiaoming@huawei.com>, "Yin
 Fengwei" <fengwei.yin@intel.com>, <kernel-hardening@lists.openwall.com>,
 <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net> <202407041711.B7CD16B2@keescook>
 <20240705.IeTheequ7Ooj@digikod.net> <202407051425.32AF9D2@keescook>
 <D2HYFLLXVYLS.ORASE7L62L3N@kernel.org> <20240706.SieHeiMie8fa@digikod.net>
In-Reply-To: <20240706.SieHeiMie8fa@digikod.net>

On Sat Jul 6, 2024 at 5:56 PM EEST, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sat, Jul 06, 2024 at 01:22:06AM +0300, Jarkko Sakkinen wrote:
> > On Sat Jul 6, 2024 at 12:44 AM EEST, Kees Cook wrote:
> > > > As explained in the UAPI comments, all parent processes need to be
> > > > trusted.  This meeans that their code is trusted, their seccomp fil=
ters
> > > > are trusted, and that they are patched, if needed, to check file
> > > > executability.
> > >
> > > But we have launchers that apply arbitrary seccomp policy, e.g. minij=
ail
> > > on Chrome OS, or even systemd on regular distros. In theory, this sho=
uld
> > > be handled via other ACLs.
> >=20
> > Or a regular web browser? AFAIK seccomp filtering was the tool to make
> > secure browser tabs in the first place.
>
> Yes, and that't OK.  Web browsers embedded their own seccomp filters and
> they are then as trusted as the browser code.

I'd recommend to slice of tech detail from cover letter, as long as
those details are in the commit messages.

Then, in the cover letter I'd go through maybe two familiar scenarios,
with interactions to this functionality.

A desktop web browser could be perhaps one of them...

BR, Jarkko

