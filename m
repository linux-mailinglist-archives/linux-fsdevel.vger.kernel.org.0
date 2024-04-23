Return-Path: <linux-fsdevel+bounces-17498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C118AE376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46971F2260F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91D7E0FB;
	Tue, 23 Apr 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Cvjuircy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432E768EC;
	Tue, 23 Apr 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870571; cv=none; b=ZpI+asmzh1RvfHomwCvUaNeiPA2d1zB2cMthH9dLEIWf2KMnVrrj0/9oeMHuk39oxhGh33r5MdeIasEj3hqzgfz9No4AEhFyORU6w9a0PaOfRnOf1veVQMym32rv1M2JSIgugnWj0bOTpBb1IJ08FRZ1Kw92wR48Xdsqma08+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870571; c=relaxed/simple;
	bh=PRzl2UMRNxugiCn9iqfwRQ+osGHHVPLKKkFP3xGEhf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9qjBeSVrpbY/GUypQ09fgNp/lLF8hgAPVVeSxM5VIHQ2gQlbqenJJLrdi63y+trV1MAvPOCTX1dmXhG0zhnNSaPjekoX6AXRMnisGF7qTG/xqhxmT+Rp0kXZIYhfWPcpeKkj6PRV3/k93ernE2U2yyXU57UEBXqUpLZC+ENX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Cvjuircy; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:40a8:0:640:e4a0:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id DB7B360C9B;
	Tue, 23 Apr 2024 14:02:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X2IlkaH5YSw0-nmEG2BPS;
	Tue, 23 Apr 2024 14:02:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713870154; bh=sbksa/ZjScoGnojxA1OqYqJU5tBgBrnQTdtT+gJxGMQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=CvjuircyBkl7pHn0xXK+s+sIpmqNFv1jtAtBvNLQv4IPH1/l6p4GjQZSXjOlIEz06
	 w4wKu8zsVXpiIoiwb0qXZCaHrNQo6Io0+AuBPb62GkzotejnqZOTT3fgVh9fHS+7bz
	 LWWSBPvKmf0EmOdce/NuSQMkXBPGrdeO7mPaUhl0=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9f429fb7-07a5-435a-a18e-7ffae6e9d8d2@yandex.ru>
Date: Tue, 23 Apr 2024 14:02:33 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
To: Stefan Metzmacher <metze@samba.org>, linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Linux API Mailing List <linux-api@vger.kernel.org>
References: <20240423104824.10464-1-stsp2@yandex.ru>
 <a24f8d8c-2e7e-41ff-a640-134501ba4fa2@samba.org>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <a24f8d8c-2e7e-41ff-a640-134501ba4fa2@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

23.04.2024 13:58, Stefan Metzmacher пишет:
>
> I guess this is something that should cc linux-api@vger.kernel.org ... 
Done, thanks.

