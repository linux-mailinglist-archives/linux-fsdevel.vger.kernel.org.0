Return-Path: <linux-fsdevel+bounces-17316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827068AB618
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BDFB21796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A12B9B0;
	Fri, 19 Apr 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="iLipm6a4";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="kEQtThv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4493111A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559533; cv=pass; b=K97PtyI9I+eXV8ZnpCTDWc63Vt8h5KY0mEGMQwi6lzssnkP6awDxa6z5deioaxWniAPpns2PvjSws+Wxb6ZzzOpW4v2qq2uJMb/qbO/p+PQwBIn33vFbpFvb7JHqLnS/aWY3oL0pjt0MKO6fR2k6TzMTxVEcRpILJpfN3zQ60OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559533; c=relaxed/simple;
	bh=tkfbrUzLmAcZMrBY12rMpQnLtvkf2pDzStUyu6Xmnbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FNhZeRj8z3JUlj6qekKP3bDKk0huDzybtQC4dXqq19px3mxzwr9iblpRPscwThIyk5NSwV1IPBs3543RitTD6ddd15KDmfzciRs7eOA70KYjxYZAG5XhiYYNKHptTSUeT+dRzobag8JsVgaCzDveUFqcpdFhpRRnGn8QC1EV/AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=iLipm6a4; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=kEQtThv8; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713559527; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jw9rPwljTMEbccEkZNM1xnPHRqhV5CUbdMDxxGEi6Ong45E3ZUKUS2CpdoDAO+L4nm
    IiKweWe4L/1hdHTD57ImkASFJjDgzBcZCrJ/TkPyOhN7aQHbfYOcCdNvEGIW15sKLV5C
    ZUfn/6tzyZwgm0sYu5fpNnYPrc0MYRn326vGbA7uqdhBpGKTWO8YGCKILI9PulruBF8E
    G9yAw3/etsj0SReKlcEdXy32ViOHyFmIjEmSvsDPDyY0HQeU04mcWysA8oX9RxAn7hwl
    DBbZErA5zgjlyhKUJz4fJNHW1rER82S/o+vkwKm36QFvl3KVduTOzQBZPYVZ2SRj5Elb
    T7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713559527;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=4AXywwyDbNGig19Cd9ruzHwdE4EngP6nTcECFwxdOFs=;
    b=DJ7eL1Ohl1p4phwE6jAVvuOicoMGAjW6OPlVi5tqAEZOh1XuXhmIE0Tdw08iLy9+Da
    twOUqjjIQ2BEM8qA59z0KdQxRkvrgre6yEEWNuxogSu1qVOdvpjsHs9NV5/KyppuxyL0
    ovA9064NP4c2qrqouCSKhEZrsMdotixSamMYP7FRg8ojModMO0UNqoyVCbGQSiCEX6pb
    wAEUQH7p2gw1WLF8KBdDBNIUiLQF7XSe+311VVhagPkaRV4W5sP3YVrjzaWaD2IpX8mZ
    LO0n7pL1rucuBVruA96u3Xu2xNEBq1EZWGvyMqGmKWH1rGa0+HXSwxmb1MJSnfA0VxDg
    TJHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713559527;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=4AXywwyDbNGig19Cd9ruzHwdE4EngP6nTcECFwxdOFs=;
    b=iLipm6a4ULCI7RHGEcgk7XlUmQh3XkRSjkMAHYc1Qf+9VC9ioH0iN5i9HyMSQjAwn5
    bg9kOkexSQkfDi1IlfIwNW/cbHVjUFEyGO9A1i6DDFVsR7NlZ/iJ/LhZKb6MpfBPcQO/
    NcmJWNOBQbundBUDsFOXmR6zg4Ryh2L7rRdI8nUeeGGYjB+4cmamVKflQ49tNI6xuNOw
    ZLGKZXhsMmKJet//jyK7w1aKHkslrPJoj8It5F+PPaBf3CLvUhpgF27t5cQ/45O1aHP6
    CrjzzA6DZxKje7lTkEfVJJJvm825vqa55x4Fe9IvGx4eq9xWDOE4bK/qnwv0ehEKTc/s
    bp5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713559527;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=4AXywwyDbNGig19Cd9ruzHwdE4EngP6nTcECFwxdOFs=;
    b=kEQtThv8ZYpuMIvkae+2pveH5JjmpqYKWWbpx6Dec8SqkH9bK6tYGycKqscst9ScPF
    JM7aIea1t1aeqwH3RHDA==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkQW4xSV/VuPB8g/jrf+fgOZAiP5qKuiDjps0="
Received: from [IPV6:2003:de:f746:1600:cb3:28a:2d4e:f26f]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id 26f4d103JKjQytU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 19 Apr 2024 22:45:26 +0200 (CEST)
Message-ID: <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de>
Date: Fri, 19 Apr 2024 22:45:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EBADF returned from close() by FUSE
To: Antonio SJ Musumeci <trapexit@spawn.link>,
 The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link>
 <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de>
 <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link>
 <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
 <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19-04-2024 22:07, Antonio SJ Musumeci wrote:
> And I'd disagree with you because as I tried to point out that
> "documented meaning" is not set in stone. Things change over time.
> Different systems, different filesystems, etc. treat situations
> differently. Some platforms don't even have certain errno or conflate
> others. Aren't there even differences in errno across some Linux archs?

Syscalls have documentation. Errors and their semantics are part
of the documentation. If the kernel cannot actually provide
the documented semantics because it passes errors through without
sanitizing them then this should at least be documented
for each affected syscall.

Proper API documentation and stability guarantees are important
so we can write robust software against them.

Note that write(2) documents

    Other errors may occur, depending on the object connected to fd.

close(2) has no such note.

> This is just a fact of life. FUSE trying to make sense of that mess is
> just going to lead to more of a mess. IMO EIO is no better than EBADF. A
> lot of software don't handle handle EXDEV correctly let alone random
> other errnos. For years Apple's SMB server would return EIO for just
> about anything happening on the backend.

That does not mean userspace should be exposed to the entirety
of the mess. And in my opinion EIO is better than EBADF because
the former "merely" indicates that something went wrong relating
to a particular file. EBADF indicates that the file descriptor
table of the process may have been corrupted.

> If a FUSE server is sending
> back EBADF in flush then it is likely a bug or bad decision.

Agreed.

> Ask them to fix it.

Will try. But the kernel should imo also do its part fulfilling its API
contract.

> And really... what is this translation table going to look like? `errno
> --list | wc -l` returns 134. You going to have huge switch statements on
> every single one of the couple dozen FUSE functions? Some of those
> maybe with special checks against arguments for the function too since
> many errno's are used to indicate multiple, sometimes entirely
> different, errors? It'd be a mess. And as a cross platform technology
> you'd need to define it as part of the protocol effectively. And it'd be
> backwards incompatible therefore optional.

That it requires perhaps some thought to do it properly does not seem
sufficient to me to dismiss the request to provide a proper
abstraction boundary with reliable semantics that match its documentation.

Whitelisting or blacklisting errors that have guaranteed meanings in
individual syscalls and mapping those to a catchall is one possible approach.
But others are also thinkable.

That some symbolic lookup tables would be needed for this does not seem
insurmountable to me. We do something similar in the Rust standard library to
map OS-specific errors to a portable abstraction. We do have a catch-all
"Uncategorized" that's explicitly intended for currently-unrecognized codes
that may be moved to more meaningful variants later.


