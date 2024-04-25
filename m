Return-Path: <linux-fsdevel+bounces-17735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226088B1FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C121F22B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC9323776;
	Thu, 25 Apr 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Ys1qysBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B41CFA9;
	Thu, 25 Apr 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042974; cv=none; b=oghj9Cqw+nxOdOEuXbfejyp9/2AXbvnIgD28/W9grGTz7Cn2JEPU/voSmUH0/7gVPBedegPGdgyNvY7lEzMc4X8hdsb92wkV/13Rp4c31MBzjLyUL/1gYha5fZwOG/6qPYtHtuHxDbZPDWQJAa46pxVK97n8opiR/lsw/rrnczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042974; c=relaxed/simple;
	bh=2qKI2Z1ZihKH3PK5JUq5HKpKbyzL6k/kwMrkHl1Ysfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNnu24760Grvgk4kH54Hnjc6/Jj7XwYozzm03xbPLE2/6K6AOGEsP9ZfRmETFxWOWY+tpeMBatrSc2UmEOKjAJgSAk9oJ813y5wTze1IZSbRNgXWXr8IlZvHYpWXiNhNF7JOlrTpZjKlvnadnUaVtdb/JuhkN5BCtn8HanREaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Ys1qysBY; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6e90:0:640:af43:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id D2E2F60E0A;
	Thu, 25 Apr 2024 14:02:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id e2Ko8LKdv8c0-v4eo7DhA;
	Thu, 25 Apr 2024 14:02:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714042961; bh=2qKI2Z1ZihKH3PK5JUq5HKpKbyzL6k/kwMrkHl1Ysfk=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Ys1qysBYUJJ1W0O+zWJaRNKGCx4zGCUmj6SO3MNr5tEDBXqc54vJCvaZgr3CI7P0f
	 4FFjmlXKC7Hy8HWYHKDOUJo6iAFqeCUzCOWx3dHCGSZTRvMIE1mOUOdySPBPE8g0Uk
	 sfu0nUY70YTmqPH0ORwV8lgZK0IAwELbGt2JLzlU=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <08d4dde6-d333-4992-abc6-35291a44c65f@yandex.ru>
Date: Thu, 25 Apr 2024 14:02:40 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Content-Language: en-US
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Aleksa Sarai <cyphar@cyphar.com>
References: <20240423110148.13114-1-stsp2@yandex.ru>
 <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
 <0e2e48be-86a8-418c-95b1-e8ca17469198@yandex.ru>
 <CALCETrWswr5jAzD9BkdCqLX=d8vReO8O9dVmZfL7HXdvwkft9g@mail.gmail.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CALCETrWswr5jAzD9BkdCqLX=d8vReO8O9dVmZfL7HXdvwkft9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.04.2024 03:43, Andy Lutomirski пишет:
> But you missed the FMODE_CRED part!

OK, I thought its not needed if fd
is limited to the one created by the
same process. But your explanation
is quite clear on that its needed anyway,
or otherwise the unsuspecting process
doesn't fully drop his privs.
Thank you for explaining that bit.
Which leaves just one question: is
such an opt-in enough or not?
Viro points it may not be enough,
but doesn't explain why exactly.

Maybe we need such an opt-in, and
it should be dropped on exec() and
on passing via unix fd? I don't know
what additional restrictions are needed,
as Viro didn't clarify that part, but the
opt-in is needed for sure.


