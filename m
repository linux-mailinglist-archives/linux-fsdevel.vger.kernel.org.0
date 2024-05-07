Return-Path: <linux-fsdevel+bounces-18884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702058BDDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37758B2182B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1914D70A;
	Tue,  7 May 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="URRyXl5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9E14D6EE;
	Tue,  7 May 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072546; cv=none; b=TWAXUz8zqNAhZHgp95M8kxHabFFCbZgjsVKDYFKleYwShkRpvyVPLkdzqgwht05FavkT57C8ReOBJsbkmY7MpUT2rpR9795iCmaoT2jbV5PYWTy32JSGXRYVEooE1puRGHeU4fcEfQ4D2ylEB9SkeI34zmlKsz7AFYyPd++NEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072546; c=relaxed/simple;
	bh=6uh8ifxHE5uS7W3QOLk171FF199PCmZvPR8VQGKwOU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgnI+o7nQfDE1WHgbLX3EoAtBu7vLtStwjew/sjFLVVFzUKHkt0KMkrmqxzZM8mCdMYT5S25hmU5ts/NVN/ZFjlc47fc49vzWiytdChCh7hE/rPrYRe50rQrrH7IPH6H0A5sFdAgMbiQ9NHJJnI7GWigpBeMwXuMWYJWU7doeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=URRyXl5p; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4a21:0:640:2a87:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id 5043C60AEF;
	Tue,  7 May 2024 12:02:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id A2UoZZEXmiE0-lvz16yjz;
	Tue, 07 May 2024 12:02:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715072532; bh=6uh8ifxHE5uS7W3QOLk171FF199PCmZvPR8VQGKwOU4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=URRyXl5p7TM+JG7sJGaDL948M/XhkeO3pZaPL1fgL8Bjms4MwfqOR33DW3NL9b/Jp
	 e2vlVjEPAZr4maOPUGUd+3ZvUIX8cJnmKCvHcJg/AjkBn1gKHfkA6pxOgfJCP3zesw
	 xiFfOVxdUlgsNzfjNv8lr3SbJkq0+lYJg1x/DmeQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <5b5cc31f-a5be-4f64-a97b-7708466ace82@yandex.ru>
Date: Tue, 7 May 2024 12:02:10 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
Content-Language: en-US
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
 <20240506.071502-teak.lily.alpine.girls-aiKJgErDohK@cyphar.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240506.071502-teak.lily.alpine.girls-aiKJgErDohK@cyphar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

07.05.2024 10:50, Aleksa Sarai пишет:
> If you are a privileged process which plans to change users,

Not privileged at all.
But I think what you say is still possible
with userns?


> A new attack I just thought of while writing this mail is that because
> there is no RESOLVE_NO_XDEV requirement, it should be possible for the
> process to get an arbitrary write primitive by creating a new
> userns+mountns and then bind-mounting / underneath the directory.
Doesn't this need a write perm to a
directory? In his case this is not a threat,
because you are not supposed to have a
write perm to that dir. OA2_CRED_INHERIT
is the only way to write.

