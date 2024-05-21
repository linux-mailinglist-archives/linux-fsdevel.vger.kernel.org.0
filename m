Return-Path: <linux-fsdevel+bounces-19902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F708CB0A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13431C21709
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A5142E8A;
	Tue, 21 May 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j739Smyr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E05130A49;
	Tue, 21 May 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302728; cv=none; b=tHAYad1jF99VT1knL/lBM6FDTTKYRKgdQiTjk9W2GxPz/hyS+7OEZQnjMicAn/JnGR9lSDoQwms5LnEfpXrXY3hnOXpS9GrveJbzgxTQutCCisyfq+HI73xl787K67lwg5Q8rmZGmyNRvVBMCegI8WyU71z7pR5QVh47AFhHym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302728; c=relaxed/simple;
	bh=ba8IClSGXDmwtOrGY8WCuVYk3WR+xkp8rtmLePbuqnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9qePBEE6za0yJJkUvudxOhQowmqLvcftzWtOrxoBjUJ+tR/EJExlTwPr9v0rUd3nOTw5S+P1FhkaUOZQYbYfYlrnab3WjYw3Qbp89LxdB9mKAHqd379bdEGPJ66UgSBhLil7xR8aMUQ92S6/nmANYL09e4FccRVqFDGPEhqowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j739Smyr; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2C1963F10D;
	Tue, 21 May 2024 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716302724;
	bh=2/f8CW90WtkYIp1uOhHP9FS9HVKaNs6eGe6DqfQe0Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=j739SmyrOi9HazlxeyULiMQAHJdRP/m97YgR/MextstArAMTaOPfX0kTkZGinsKBl
	 a2m1E363E2+dvqri4yUAUtxHEFkEbNu30VVI7D933YgBKEccLdKiZYIGizUYcEeTZ5
	 YGCGUFdULlQqzJM8uZa42CW5rRO4QxrFBnc4PbWABVUyBjsyJPxRt/D2FdMdwmc49S
	 DuzsY3p9CCjTl/uPr1pKiXlIHJI6qyaQFHgumkhy8ukP07UGV8jKqm/gvo7UY9BvcM
	 9G2cSrd2kiyJ8sF8pOFQoSaU1rSFF1k25nMYuxPjoT1ILmfY2P+VPDfAL0BuHlau+l
	 9rY0yrp3ExwXA==
Message-ID: <872c8eb0-894b-413a-8e35-130984a87bba@canonical.com>
Date: Tue, 21 May 2024 07:45:20 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Calmels
 <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 David Howells <dhowells@redhat.com>, containers@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>
 <D1CQ1FZ72NIW.2U7ZH0GU6C5W5@kernel.org>
 <D1CQ8J60S7L4.1OVRIWBERNM5Y@kernel.org>
 <D1CQC0PTK1G0.124QCO3S041Q@kernel.org>
 <1b0d222a-b556-48b0-913f-cdd5c30f8d27@canonical.com>
 <D1FDU1C3W974.2BXBDS10OB8CB@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <D1FDU1C3W974.2BXBDS10OB8CB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 07:12, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 4:57 PM EEST, John Johansen wrote:
>>> One tip: I think this is wrong forum to present namespace ideas in the
>>> first place. It would be probably better to talk about this with e.g.
>>> systemd or podman developers, and similar groups. There's zero evidence
>>> of the usefulness. Then when you go that route and come back with actual
>>> users, things click much more easily. Now this is all in the void.
>>>
>>> BR, Jarkko
>>
>> Jarkko,
>>
>> this is very much the right forum. User namespaces exist today. This
>> is a discussion around trying to reduce the exposed kernel surface
>> that is being used to attack the kernel.
> 
> Agreed, that was harsh way to put it. What I mean is that if this
> feature was included, would it be enabled by distributions?
> 
Enabled, maybe? It requires the debian distros to make sure their
packaging supports xattrs correctly. It should be good but it isn't
well exercised. It also requires the work to set these on multiple
applications. From experience we are talking 100s.

It will break out of repo applications, and require an extra step for
users to enable. Ubuntu is already breaking these but for many, of the
more popular ones they are shipping profiles so the users don't have
to take an extra step. Things like appimages remain broken and wil
require an approach similar to the Mac with unverified software
downloaded from the internet.

Nor does this fix the bwrap, unshare, ... use case. Which means the
distro is going to have to continue shipping an alternate solution
that covers those. For Ubuntu atm this is just an extra point of
friction but I expect we would still end up enabling it to tick the
checkbox at some point if it goes into the upstream kernel.

> This user base part or potential user space part is not very well
> described in the cover letter. I.e. "motivation" to put it short.
> 
yes the cover letter needs work

> I mean the technical details are really in detail in this patch set but
> it would help to digest them if there was some even rough description
> how this would be deployed.
> 
yes

> If the motivation should be obvious, then it is beyond me, and thus
> would be nice if that obvious thing was stated that everyone else gets.
> 
sure. The cover letter will get updated with this. Seeing as I have been
dealing with this a lot lately. It comes down to user namespaces allow
unprivileged code to access kernel surface area that is usually protected
behind capabilities. This has been leveraged as part of the exploit chain
in the majority of kernel exploits we are seeing.

> E.g. I like to sometimes just test quite alien patch sets for the sake
> of learning and fun (or not so fun, depends) but this patch set does not
> deliver enough information to do anything at all.
> 
under stood, I am playing devils advocate here. Its not that I don't see
value in the proposal, but that I am not sure I see enough value with
the current situation, where so much code has been written around the
assumption that unprivileged user namespaces are safe. Trying to fix
the situation without breaking everything is complicated.

> Hope this clears a bit where I stand. IMHO a good patch set should bring
> the details to the specialists on the topic but also have some wider
> audience motivational stuff in order to make clear where it fits in this
> world :-)
> 
> BR, Jarkko
> 


