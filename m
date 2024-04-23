Return-Path: <linux-fsdevel+bounces-17543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239C8AF645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653FF1C21844
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7013F45D;
	Tue, 23 Apr 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RFLwoUE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121013E3FA;
	Tue, 23 Apr 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895554; cv=none; b=X07r0eR/Ls+YcEUB4NhE8He2ky4p7dWn5VEf/gWWkYEXE+PaCm3FwLAmQ036DQQ8EC76zaLOgwcR97MIDHDcSCI8H0V/pYowsu5Z8Ywu9d0bUwDBrmpEwLNZYSZx3pFeC6O+UKpFPYb5TqyXGZmxv4qQQEZdvwKvYI9spCJvBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895554; c=relaxed/simple;
	bh=cLmdiFJGIPbJIGlD75Kc+63tuL2Yo4mblrORZE2KIGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEIYd1T9xGHGyGPMEWKx/Wr2l9ahcEalAuOysl93Vu0ftHSwcSLMHAbuCPACWC/UOuvaV1D8bc1l38caiNc4JrMdgNVH/50xcHG3lEOxf5BOhz6SeGHqcFGqe/B7Bkxbb2MZsRYA0jKyzqqg0zkz+j+lRY2Wacba9JZx3W0CPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RFLwoUE+; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a14:0:640:8120:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 6AA705EFBE;
	Tue, 23 Apr 2024 21:05:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id d5Pu8ZKo7Os0-yyoYSl4F;
	Tue, 23 Apr 2024 21:05:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713895541; bh=glKFAk+N6amMEPICwdwbwvr3K4LhVCrg+bBmsDo+ia0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=RFLwoUE+qG5ib7z005EuxVvB/+ijx1A+4g4h5j0gRFh2sl/tgRwJS0KwED3GNWvTx
	 X1t9gaPnplbBl3pp9b8+Oue3z537Nvx32xWaRg6o5GZ2LRgRX2eeV1wXvXNw5AJfL4
	 4w53QR7PCLlAjCSTIj2Tgi37z2iEfh5N3AmKs/00=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <bcc5c69a-fdb7-4835-bd1f-4093d360822c@yandex.ru>
Date: Tue, 23 Apr 2024 21:05:39 +0300
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
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240423110148.13114-1-stsp2@yandex.ru>
 <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

23.04.2024 19:44, Andy Lutomirski пишет:
>> On Apr 23, 2024, at 4:02 AM, Stas Sergeev <stsp2@yandex.ru> wrote:
>>
>> ﻿This patch-set implements the OA2_INHERIT_CRED flag for openat2() syscall.
>> It is needed to perform an open operation with the creds that were in
>> effect when the dir_fd was opened. This allows the process to pre-open
>> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
>> user, while still retaining the possibility to open/create files within
>> the pre-opened directory set.
> I like the concept, as it’s a sort of move toward a capability system. But I think that making a dirfd into this sort of capability would need to be much more explicit. Right now, any program could do this entirely by accident, and applying OA2_INHERIT_CRED to an fd fished out of /proc seems hazardous.

Could you please clarify this a bit?
I think if you open someone else's
fd via /proc, then your current creds
would be stored in a struct file, rather
than the creds of the process from
which you open. I don't think creds
can be stolen that way, as I suppose
opening via proc is similar to open
via some symlink.
Or is there some magic going on
so that the process's creds can
actually be leaked this way?

> So perhaps if an open file description for a directory could have something like FMODE_CRED, and if OA2_INHERIT_CRED also blocked .., magic links, symlinks to anywhere above the dirfd (or maybe all symlinks) and absolute path lookups, then this would be okay.

This is already there.
My fault is that I put a short description
in a cover letter and a long description
in a patch itself. I should probably swap
them, as you only read the cover letter.
My patch takes care about possible escape
scenarios by working only with restricted
lookup modes: RESOLVE_BENEATH, RESOLVE_IN_ROOT.

I made sure that symlinks leading outside
of a sandbox, are rejected.
Also note that my patch requires O_CLOEXEC
on a dir_fd to avoid the cred leakage over
exec syscall.

> Also, there are lots of ways that f_cred could be relevant: fsuid/fsgid, effective capabilities and security labels. And it gets more complex if this ever gets extended to support connecting or sending to a socket or if someone opens a device node.  Does CAP_SYS_ADMIN carry over?
Hmm, I don't know.
The v1 version of a patch only changed
fsuid/fsgid. Stefan Metzmacher suggested
to use the full creds instead, but I haven't
considered the implications of that change
just yet.
So if using the full creds is too much because
it can carry things like CAP_SYS_ADMIN, then
should I get back to v1 and only change
fsuid/fsgid?

