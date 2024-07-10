Return-Path: <linux-fsdevel+bounces-23519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110E92D9B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F391AB21AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4E196D8E;
	Wed, 10 Jul 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lZnyBEOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B54F1E2;
	Wed, 10 Jul 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642159; cv=none; b=O3wZdeWSyNDGC5n97eiX3JjITl26YfHCu1qUhcVknvQhw9CPg3EBJ+Zcsc/3YoEFhQxYumi/TdFBhSFRGQSa9ZKzrvQrmMTAI4U0A+tcll+tw7d6Q51KpzVa/rLd2wCAyXpBZ9Hz9be0HlTG/CWgk7GfO+8lpMkOnZh9CKeNrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642159; c=relaxed/simple;
	bh=nAq2UopC+lcHEXD0KwKR6HDnTvRTNu7sg5BZmooKNd4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=b7/qleyqcT1TNjhjYbmKAZkirLuM4OFD9XqFfdn5tZG3PLaCMFxkSVuCo01glLAPeezTTCYRO9Xbjr4e8xOLPInvRRJhIPU4HA/vxxGOdo05hG3zvAmCCqYhJ0vvxEODVq/FZYt58INS7HrnU/qmqrrinrZ5ytbF1BD/aZ/6CkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lZnyBEOy; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720642149; x=1721246949; i=markus.elfring@web.de;
	bh=rho+4554GMatJ4J6FFq/74f8fKeBu1vtC6simcrat64=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lZnyBEOylSRk809Ia0nRj6Z4UOEm2+69GKJUsV28BelJpfAroe6EB9aG9iGeItoL
	 qUkqtcCjUtfet5wQyWcREXNC4c28Up0ODFfT3WpklPVudUmhM3dhL6wtudDFZgBLg
	 mqIA9EX4Mr2nw2/smMOZgkT+EI48cY+GjZAaG4TqULhMpog59YKeW433t8UKIe8Q1
	 uepFe3ffpRtnnFS1c+DOdxK36BdayviYUCOB6RyFxLpsy0eKQcp65XLr4KZR3UyUr
	 utWUyj2Unn6w+GVfVB9wuokCGSpKHIoHU6oksgWPeY8z8PgR8e5dv617OFNI6zVUv
	 gwUipE3fEr1OzBj29g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1sfaVW3Sf9-00KXWF; Wed, 10
 Jul 2024 22:09:09 +0200
Message-ID: <8fd93c4e-3324-49b6-a77c-ea9986bc3033@web.de>
Date: Wed, 10 Jul 2024 22:09:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vasiliy Kovalev <kovalev@altlinux.org>, linux-fsdevel@vger.kernel.org,
 lvc-patches@linuxtesting.org,
 syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, dutyrok@altlinux.org
References: <20240710191118.40431-2-kovalev@altlinux.org>
Subject: Re: [PATCH fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240710191118.40431-2-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l1ptvMTFbiN/O1FzRBNPX9iH0hmjL8/DegvoUVGQWj22U3u9OgC
 zVNYHpJHoaOhSeNt0HtfNDcG9ms+Rs/1q7bwVdqFnnkScQ5JvmqhTAqOOEaz1nHGHzRvSY7
 7oIvuwQLmhxy7c+wZYFppgoIbt2tCrBa9/WW4nUoigTlAV7WigaEukE/FPAgysDuTcFh5+V
 lCmWYaugy+SO+QXSgo+DA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oqzg30k6YCI=;ruKfetjCviKFaOH6HgG19JB8MFa
 5NtFyOrkk5/L2+xG9M3+FHKl6vutPANxBNDn8uP5odhUsE8u9KxamvELKGB/eQ8fecb52pgNa
 8nNN0RbjaTlxV/0z5o/SAViA/0ftjcLtDzgQKiqGApYYCCWIKnKgVC2Qj/pQZs4O/4x3UsFMm
 xsbvxvI3EJXXXItgDfgJmWygfwbELLtSVD/ZIDJsNbKIMXSRG7E7QE2+ROMQRbiJdf6UEKuz0
 8XYw+zeivXXapthi20RHI0MRdU9d3zM3n0lSRjabuB8QhMlXHimttEUqyRW5Bl1+eXhaCThPF
 Kaw2LcboryJuRlNRdw+x9Lp9TAhZC2eXg5vCd17cZxsFT7yru2h+fxqha2SXuwxoHhvxI9O2W
 GEh3qQnb7rcw19v7GpcJAqUapAR0atDR04cQJhKr7TLK04r6DCS2xebHIcEKWoKMFhz43SeqJ
 L1yM9A3TeaUrPJ+1ClPW0iqMK++5g2YaeZsDgK9Dic6izhEqU4FPQuAwdvKVJRqQqdD90Ik7p
 udpmOV5xYZ8R30ntJxj6BEkADwb/CVHS3g2Wup3e2aLwB4L5RQgElpahYnoyDLvef+w8qhoiV
 sNvZXOvGd8cO8qpLk6PLB0n6REyIrGR2Diu44RVFffxbjuzmWiMX3kRQRvqWyKYTZblRrW6oP
 Nr7PYL/CX7KvyanL8JXsWqxdYFGdBaZXbhEaucrJWqCn4Sc9c/HLTrxUMnp5jyjU/Y4nKvoMj
 Lt56XWCo88LmtC5j57/Oi3EfFMvtYzHaeq4n1+Ifk6QYfFqhm19LIgzQ4cgfnBHH2HJWf4e0a
 eIg/t8cFPwQNJT+0r833a1MQ==

> Add a check to ensure 'sb_getblk' did not return NULL before copying dat=
a.

Wording suggestion:
                        that a sb_getblk() call


How do you think about to use a summary phrase like
=E2=80=9CPrevent null pointer dereference in bfs_move_block()=E2=80=9D?


=E2=80=A6
> +++ b/fs/bfs/file.c
> @@ -35,16 +35,22 @@ static int bfs_move_block(unsigned long from, unsign=
ed long to,
>  					struct super_block *sb)
>  {
>  	struct buffer_head *bh, *new;
> +	int err;

Can a statement (like the following) become more appropriate for such
a function implementation?

	int ret =3D 0;


Regards,
Markus

