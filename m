Return-Path: <linux-fsdevel+bounces-75947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OORIEn3GfGnaOgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:55:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86109BBCEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CA53015708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE7322C6D;
	Fri, 30 Jan 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="If36PiRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C12D97BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784951; cv=pass; b=ghGg8mSdT4GaYi6gLp91t/DNvvOt4k36khWtjR4SDmgI5WMHdkQI561amvGKWagchMi14Iqz9RdLPjRvz9q2nLX6iUDRh1ficSws1sAQBY7dzXB0MFXsIuaItBrLFYIP0IGy9nKbYdZu8r6+q9BETl1C51F9ijbRUaVZxx7+AJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784951; c=relaxed/simple;
	bh=mg7uOUMgeblP8S/OAokMwjk9S4rCDcNtYOiVtWaM4Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYHXlxFAtBmhfcWMWb2EyF5HHwO2cHDyyoGrov4Fp7ZuFVgzickrL6uz9nZ3NY0/ucdNtId9n2bY6n8Y5C8PV9JMwFD1gRDo5Q1n3Py2l+bvwzgFCXKBfQF7BTKsUmTCTzdSQIGS9FwNWPWD19pbGtK3tm7IhP5sGGzMFR2iQW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=If36PiRf; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79495b1a9f0so17570617b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 06:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769784949; cv=none;
        d=google.com; s=arc-20240605;
        b=GsiO4mLNjAsAeERc7ac3eeGcmxwdj7EwDIqTAWpGYzYWd4CMnlfRptoRcM5v3ib7bg
         lkZmWWtV0KjGRLGrCJ1X7bLkN4xyQn25miug57uS+4It7/iodoXMGUgnpd4Mf+IdJYnU
         +mi2nLe7taMUQa0Gl+CTBLbTHh3DZUOONLYpH2ozT7BofxHxPe93ADgFhjVKVs/qMsj1
         AB/vHW+yejSeAw/e8gB22EZyI9rrvXrfjFmE3ww9kis2qi6v/iv5Z0Ai0RLyDX4aROYM
         TCKpNegdz08YpsB+28eIuplp+yMKYnBEUbV0oQW1uoHeWaJvUn+0/ytFK2MNzbF4PpSj
         K5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EM2epB7nQYhPIzusbdUjf/FdU8bLhcXpUFnr3IzTDKE=;
        fh=cBSH6hVRk2RC5HpQ7SCqwglbL+Lu8PEdeJw63bwOcuw=;
        b=XSlbTSM1a/C/WrRP6vp+EoeG8uAgKIVM2nVYlSHiHmpYhqC7o0/8BPBEmFg04fm4vc
         CPaHLlm8rGKWUF/lD0QsIbZNtYaX2qVuAx81wkkoIpTxs5UFYgPDY9W1gjJhD+3mNu48
         KuzK2b1iErAEbRH9PlHbB1uSfnVvSVQEib+zH1UaepTidTdVja6q196jOFHadmlDt4xf
         sTBRi53YeuCaMRnXAsbiPY++yeaUfQABbiAN65tNFLGcCeNJ5/w6SVfg5446NKIHFpKz
         KQq3ajObkcLnj1jbVs8d3ccBq+gtTDv07CJWrQGKp2FOmvWf/NWOpIgv0GOl32KVLHhm
         ts4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1769784949; x=1770389749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM2epB7nQYhPIzusbdUjf/FdU8bLhcXpUFnr3IzTDKE=;
        b=If36PiRfM0bdPTZY0gjr8gKiNI6yGhNveHHdYOAnf6HZ6fr1JQeTYm8j5SIEuzWG2W
         0ieCpkgatT5z4BWnrOP26ApBgXoQSfvXAhjTU/w8miBu5T217+TiS6EIMD1Tk2OqrPcK
         4U5WtZQEwswdvEM1GzxB9oZp48r3hvWLnkbys1PA8MR+/VHJ2UQiNkD5xNkKW/iOEiPD
         DRQS2dRt1LrlYb/wzfNX+v+TiRj5lexpjyRijEkHpWn1MelBctJP3ixtZWG4z3uBBwiF
         1rZNxjAZOeaizw/MQzNxUTI7eFv/nsx8e11n2nCaJT+PZ8jPH/zJCMATQ25BA0N0QLJw
         mz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784949; x=1770389749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EM2epB7nQYhPIzusbdUjf/FdU8bLhcXpUFnr3IzTDKE=;
        b=CE2WFovFy//iyBGd7hZBZhaHcKU455whbrRhYXmdB8nGZbM/YYmPenMQ0zfATodgWM
         NlD55SwSBZh861c7238MFOQsfBBplG8kDO6ir3zvRVayZOtb0WbdLiKiDer/wtbepDLs
         Z3opvecZTejV8NMbP9FgdUqrYpkWfFjQGniS10nsyd617EmtyBx9Mgd7nq7/d4kHfYhI
         oCXFVx+BML/JQMF0X1/0rBwJUrtmc623OauxfU5yRwVsxsTlggB5WtVBK/nr//F14XbX
         tnm49TrRIXPerTwPC+V+iCf4nNrJv1dH6//PPzr+lg5QJhgu7xVJYR4XRi/5PKJ85Iqz
         uzyg==
X-Gm-Message-State: AOJu0YwvkplVORxxor2I3aEIBLEqYf1CwpN3nIt0XvYbSw2R5vauG9/U
	0LhL1neouJ2vzC+OGJuH/+D8V33d/rGht8DtZixU5qUh6Pi1klBR48MYt7gpGZVLZvESiRjUlyv
	5hDyWjHEGJVEE7196TNTMvdmLcwxxhAdZaNZ0ImRGAY2GLYOsFMZGWd6vOz02AAA=
X-Gm-Gg: AZuq6aIy/NnY9QvJUtwWCj3p7QzGx/kJjkSa1s5unJAT+F8gvc1VHEhwtvbJUSTQXjg
	gEV+yFQWEY0eqNKlk05uZXSDN1lVMNe0n4HIYpUAq5vjyEMp6ByfFTc851Lnr3tDU8j5kNfIgjp
	o5OBhusfgDdcyH5+Qef65VtlcXsl3Q/ZthJBNT0vf8/1JrK4TlxKYw99tGflyznRiMJ0BTBfNM9
	zUeUfk5COGZFwWbTv9NscuLBnc2ldaIFjZ2Y+B7L+6S3A32eAGBUOUUjSMQgLZ1v8ZvN6OgLHig
	aQto22XolFodI5iK+USvInVhhWj54Uprmjrfk06EThqnev8xcyJ7AABW+Q==
X-Received: by 2002:a05:690c:c50d:b0:793:ac88:2a3a with SMTP id
 00721157ae682-7949e015761mr62608117b3.33.1769784948992; Fri, 30 Jan 2026
 06:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
 <20251105-rotwild-wartung-e0c391fe559a@brauner> <CACyTCKjojw0M=9NEzTpASd+OhgaPxU4hFRV2c6GEDFLZ8K2bWw@mail.gmail.com>
 <CACyTCKifDxhGBY0S9AYZBCw6S7-mf+0WYv=0VjBq_a+S0sWuiA@mail.gmail.com>
 <20260129-hummel-teilweise-43b0ba55723c@brauner> <CACyTCKiijH+HXiEksuq6RFQnMfJ2tP5pWc5fPv6hn8rRDoRHBA@mail.gmail.com>
In-Reply-To: <CACyTCKiijH+HXiEksuq6RFQnMfJ2tP5pWc5fPv6hn8rRDoRHBA@mail.gmail.com>
From: Snaipe <me@snai.pe>
Date: Fri, 30 Jan 2026 15:55:13 +0100
X-Gm-Features: AZwV_Qh8dJ12Jmx65t-wQPmi5PON9VtjVrYk1FI9sB-Mo-T2GFiQRLfMx0RxlOI
Message-ID: <CACyTCKhFnuOZBxbhzHvOacS0=4P5E091+TJUwfYvjBQPBausYw@mail.gmail.com>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[snai.pe:s=snai.pe];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[snai.pe];
	TAGGED_FROM(0.00)[bounces-75947-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[snai.pe:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@snai.pe,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,snai.pe:email,snai.pe:url,snai.pe:dkim]
X-Rspamd-Queue-Id: 86109BBCEB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 8:14=E2=80=AFPM Snaipe <me@snai.pe> wrote:
> I was a bit confused initially but I think I'm starting to see the pictur=
e.
>
> In my original attempt, process A (privileged in user ns A and mount
> ns A) would open a file descriptor, send it to process B (privileged
> in user ns B and mount ns B, but not A), which would then call
> open_tree followed by move_mount. The issue with this approach is that
> the file descriptor's path from which we get the detached copy is
> still in mount ns A, over which process B is not privileged over.
>
> If I understand you correctly, you're saying instead that process A
> should be the one doing open_tree to get a detached tree (which it can
> since it is privileged over user ns A), send it to process B, which
> then calls move_mount. Today, this operation fails with EINVAL, but
> the point would be to relax the checks in move_mount so that processes
> can mount any detached trees in mount namespaces they are privileged
> on, even if said detached tree originated from a mount namespace they
> are not privileged on.
>
> Am I interpreting your point correctly?
>

I ended up adjusting my prototype in that direction -- the good news
is that it already works as expected: if process A calls open_tree and
sends that file descriptor to process B, then process B can move_tree
the result. I'm not sure since when, but at least right now it works
on my machine which runs 6.12.63.

The not-that-good news is that I'm getting bitten with close semantics
weirdness. One thing I need is for process A to send a file descriptor
that has been flock'ed -- typically because this guards the tree being
sent against deletion by a local agent. Since open_tree returns a file
descriptor that is essentially O_PATH, it means I can't flock it, so
instead, I'm reopening the root of the tree with O_RDONLY. So far so
good:

    // on the sending end
    int fd1 =3D open_tree(...)
    int fd2 =3D openat(fd1, ".", O_RDONLY);
    flock(fd2, LOCK_EX);
    send_fd(fd2);

    // on the receiving end
    int fd =3D recv_fd();
    move_mount(fd, "", -1, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

Now, the issue is that if the sender closes fd1 after sending fd2, and
the receiver calls move_mount after fd1 has been closed, then it will
return EINVAL, while it'll work perfectly if it manages to win the
race and call move_mount before fd1 has been closed.

I haven't had time to debug this properly yet (although I'm going to
look into this) but my guess is that when fd1 is closed, the detached
tree is marked unmounted even if there are open file descriptors
pointing to content within?

--=20
Franklin "Snaipe" Mathieu
=F0=9F=9D=B0 https://snai.pe

