Return-Path: <linux-fsdevel+bounces-17568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBB8AFC58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834A9B2387D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB92E859;
	Tue, 23 Apr 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HgKLZ9dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956602E62F;
	Tue, 23 Apr 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913164; cv=none; b=X3uomWWYYWu86B1cNCHSPm7FDJodMtebJJQzYPfz0N1aeGbVO3A6atxU/0r7LeprEmYqG0ww/JhlFUdDQAggvQmZpU1a1bIT/+k/tpZ3VumISsrDd1P5KBmjD8axFrZ5qlyAEXe+mGD2ZqIcZF5RbaHKAhH+Kqbtk0YC62GSSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913164; c=relaxed/simple;
	bh=DhW+flUhzLchgxh0ybt4z6c9Y5DfRjQUnP8fxX0ABo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW+m1IebjsUnmaoyWkC4/+NgxatO7sCmPj3e5hXdFu/rA9aX9tJpqAUlTyMkfX0fkICntehoH+udU0Mfhseu6hoLhr52qzoh/nL4okLJYR7NLYIcD5rcznUbxv7FLuKeoukWEjYT1YnACxIMBeQxWEBLNGkD21xTVKKgv4vDQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HgKLZ9dd; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5b8b:0:640:df05:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id 39B6861308;
	Wed, 24 Apr 2024 01:59:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CxTYgsOoBiE0-MoiKJb1W;
	Wed, 24 Apr 2024 01:59:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713913153; bh=dSFGkrbMp3MN5zZhL4zbEW6tvfQBxICR8WWedgCEtgA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=HgKLZ9ddzAkgMSxnE1R7ILGyuE/XJ1feN2MgTxwdHNarRlzYcmd/EmsxZzZoXa+LM
	 CpCmTu/+hRkolEr8wus/8kFsC2IxcYrftouh8N6MlePYLLGaZyk155SFk0HE7k9imF
	 ydYfNu0S8T6B+lr0PTMGsrodc+jMYM0P84uEIZSA=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8b3777bc-4cd5-4bf9-b8f2-f7ba1d596769@yandex.ru>
Date: Wed, 24 Apr 2024 01:59:12 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Content-Language: en-US
To: Stefan Metzmacher <metze@samba.org>, linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <20240422084505.3465238-2-stsp2@yandex.ru>
 <81ab6c6a-0a9e-4f2f-b455-7585283acf53@samba.org>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <81ab6c6a-0a9e-4f2f-b455-7585283acf53@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

22.04.2024 22:53, Stefan Metzmacher пишет:
> I'm wondering if it would be better to capture the whole cred structure.
>
> Similar to io_register_personality(), which uses get_current_cred().
>
> Only using uid and gid, won't reflect any group memberships or 
> capabilities... 
I ended up posting v3 where the
group memberships are added but
the rest, including capabilities, is
omitted to avoid security risks.

Does adding just a groupinfo to the
set of overridden members (which is
now: fsuid, fsgid and group_info) address
your concern?
I really think that raising caps is far
out of the scope for my approach, which
aims to be safe and simple. Someone
else can do that later, if need be.

