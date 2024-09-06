Return-Path: <linux-fsdevel+bounces-28832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B496EC8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC30628AD84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55E1534EC;
	Fri,  6 Sep 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EJ6g3j2q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57A1474B5
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609062; cv=none; b=kdMgH35t8+UY/lvEuxinnAIyxPeNLVcO7EC/GqAX2VGCZEF0JTxV/gj5G0/piCDFDkYPLYuWKTVs6e/ckQWoxB6nlieJjKniaa8hRIiTADbHvg/uUP4e9+pwI7HU2wWuj3lzp9U0K6e/JREwJUec3EcqK38CQULKsM+rQSqZnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609062; c=relaxed/simple;
	bh=wD19amo2g4diYkaR+wM0BDj3uhwHMg7ctui+1OFkYtw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CXQ3UCAGsEFVHJKYe2vXfBiDVqeYTuAII4IO9esKJ+2sho0++eqYqsfq99x326QWgRfeaip05Snu5EPb/l+Sb/sxiieggsytfMXnlu/AoicXfIZfl/bGUjf2Lw/FDJhJATHHFjJCQ1q6Ivl9pgkFMNTagVwaIUe5ZDlq41X2PzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EJ6g3j2q; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=iho5zugydncillcokazyce2k2y.protonmail; t=1725609053; x=1725868253;
	bh=VVxmZMlnrbulCOpYgicmWJL7Hjrf6qlakYElzAYVcx8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EJ6g3j2ql6dS53qy+DUJpHYtxWeg/k2Q+PdJXM9Dxeh7imx/Y+2pAfa22tIl3XxiD
	 fHxvw3NckWeDq5vksr0qLvfdySYrsyFo76Z2hy8iAFDuD78ze1EF1tObNg/9Y49cXx
	 MqvKaDWS89PpSea5jlL7SOxb8w/Ob8B97xRpAo/EtQmrQrIn0o1D3iRSwJuNAJBBFa
	 2sG6EXkJOyllwnNgpGeE8koXB6GM3BJ7+/UZD1H8ieOTkwdbQ0oPGPC5VW4j5O3L/d
	 jkV4exXSGWeMCbdHvzbiFIfJs4dhoDh/JfNiQoqx8CJEq7NBSQi9kpDVpvCpyFiRh9
	 0jIuNoDWwzw7A==
Date: Fri, 06 Sep 2024 07:50:46 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>
From: Nathan Owens <ndowens08@proton.me>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
Message-ID: <01252d3a-1856-4e9e-a395-3f15c0a3afd0@proton.me>
Feedback-ID: 104529665:user:proton
X-Pm-Message-ID: 67c5618fa3ee3272c816ec8cd41028e86b003fd0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------db22c30af5b7d01c9653c4dabb75cf791da2b320a6affc106f90ce0e3bbe0e08"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------db22c30af5b7d01c9653c4dabb75cf791da2b320a6affc106f90ce0e3bbe0e08
Content-Type: multipart/mixed;
 boundary=c95c0d4fd079171dbe7160a3b7232914832ed911c964f39bff6d90f0d38f
Message-ID: <01252d3a-1856-4e9e-a395-3f15c0a3afd0@proton.me>
Date: Fri, 6 Sep 2024 02:50:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
 <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
 <wdxl2l4h2k3ady73fb4wiyzhmfoszeelmr2vs5h36xz3nl665s@n4qzgzsdekrg>
 <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
 <bczhy3gwlps24w3jwhpztzuvno7uk7vjjk5ouponvar5qzs3ye@5fckvo2xa5cz>
Content-Language: en-US
From: Nathan Owens <ndowens08@proton.me>
In-Reply-To: <bczhy3gwlps24w3jwhpztzuvno7uk7vjjk5ouponvar5qzs3ye@5fckvo2xa5cz>

--c95c0d4fd079171dbe7160a3b7232914832ed911c964f39bff6d90f0d38f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Will say both Linus and Kent has their points and reasoning, but I must 
ask, Kent please stick with the guidelines of submitting fixes, 
features, etc. I would like that Bcachefs to stay in the kernel and see 
how well Bcachefs comes along in the future and when it has your 
features and ideas. One day I would like to maybe switch from BTRFS to 
Bcachefs when it gets more features and some of the things I would like 
to be able to do, like restore from snapshot and eventually boot to 
snapshots to restore a messed up system. If it gets taken out of the 
tree, less people will know about it, nor likely take the trouble of 
compiling a kernel for Bcachefs.

This comment is not bash either Linus or you Kent, but just a thought in 
hopes that more people will possibly switch to it and encourage 
production keeps happening as well.

On 8/23/24 10:10 PM, Kent Overstreet wrote:
> On Sat, Aug 24, 2024 at 10:57:55AM GMT, Linus Torvalds wrote:
>> On Sat, 24 Aug 2024 at 10:48, K
ent Overstreet <kent.overstreet@linux.dev> wrote:
>>> Sure, which is why I'm not sending you anything here that isn't a fix
>>> for a real issue.
>> Kent, bugs happen.
> I _know_.
>
> Look, filesystem development is as high stakes as it gets. Normal kernel
> development, you fuck up - you crash the machine, you lose some work,
> you reboot, people are annoyed but generally it's ok.
>
> In filesystem land, you can corrupt data and not find out about it until
> weeks later, or _worse_. I've got stories to give people literal
> nightmares. Hell, that stuff has fueled my own nightmares for years. You
> know how much grey my beard has now?
>
> Which is why I have spent many years of my life building a codebase and
> development process where I can work productively where I can not just
> catch but recover from pretty much any fuckup imaginable.
>
> Because peace of mind is priceless...
>

--c95c0d4fd079171dbe7160a3b7232914832ed911c964f39bff6d90f0d38f
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ndowens08@proton.me -
 0x227C5078.asc"; name="publickey - ndowens08@proton.me - 0x227C5078.asc"
Content-Type: application/pgp-keys; filename="publickey -
 ndowens08@proton.me - 0x227C5078.asc"; name="publickey -
 ndowens08@proton.me - 0x227C5078.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuNy40Cgp4ak1FWmZubzBoWUpLd1lCQkFIYVJ3
OEJBUWRBRlJwRGNwSFNmUUExMXR4MGpmNWtheFZJVVJydzY0YklIMllZCkdJVFRRTjdOS1c1a2Iz
ZGxibk13T0VCd2NtOTBiMjR1YldVZ1BHNWtiM2RsYm5Nd09FQndjbTkwYjI0dWJXVSsKd293RUVC
WUtBRDRGZ21YNTZOSUVDd2tIQ0FtUUhDdWw3M0lpR01FREZRZ0tCQllBQWdFQ0dRRUNtd01DSGdF
VwpJUVFpZkZCNGppWDY3WU5wYURnY0s2WHZjaUlZd1FBQVdwd0JBTG5oVzd6Snh1MDhiWjAwUE83
cFZkMk1TQTVQCnozTGMzYWpXYjkzZHkwUzhBUUNiUG4xeTJ6YXVGT1doM2lKNGk5QzRlWC9IWXFi
b0ZlV3BrVTl4SDlSK0NzNDQKQkdYNTZOSVNDaXNHQVFRQmwxVUJCUUVCQjBBcVNkNVFHVVJWR3F3
QWNjemlJRTd6SjQxMER6WnIrRkRQVzVLRQpzM2kwWEFNQkNBZkNlQVFZRmdvQUtnV0NaZm5vMGdt
UUhDdWw3M0lpR01FQ213d1dJUVFpZkZCNGppWDY3WU5wCmFEZ2NLNlh2Y2lJWXdRQUF1RU1CQU1F
ZGdqRGxVazlNRG5PYzlqaHVGSnEwcC9aenhsMFNGVVpDYW0zazlUMk4KQVA5eHJrZnpKaXhOV1dt
RUwvdDhaNGNQYldGdHhMUjB4MzFTMXlZckljMGdEZz09Cj1YNjgxCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0=
--c95c0d4fd079171dbe7160a3b7232914832ed911c964f39bff6d90f0d38f--

--------db22c30af5b7d01c9653c4dabb75cf791da2b320a6affc106f90ce0e3bbe0e08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmbatFUJEBwrpe9yIhjBFiEEInxQeI4l+u2DaWg4HCul73Ii
GMEAAJO5AQDsuQo4Nv0WUG9zL9MNOWlUwRtsc0BYxfmCNTJK9HS40wD/UjKn
bh5aQ/fw+v4TJ2E7n17BX+uUpvk/S1ZFTG2a/gA=
=lifC
-----END PGP SIGNATURE-----


--------db22c30af5b7d01c9653c4dabb75cf791da2b320a6affc106f90ce0e3bbe0e08--


