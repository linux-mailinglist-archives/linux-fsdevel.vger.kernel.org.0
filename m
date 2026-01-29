Return-Path: <linux-fsdevel+bounces-75856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLeJOjBje2l2EQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:40:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9BB07A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F0503009F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5992F2613;
	Thu, 29 Jan 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="LXpvMmjI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAD3A1CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693998; cv=pass; b=Zhd9DBijwV9MwH00jQlMZXn2CQkEZ0/5mTgHibVjMsxzqH0xIi0U8uN4FygptW0GrUymST+h4M7VHTJZY2GDUA+oz9rL/w0DsnHdPYl2YbLeezdAlDO8ZJ1MZZpayn1wvwIoHM0ixgLmXHjIU9hbNOQVqYbAlfq17+kfo5EgrzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693998; c=relaxed/simple;
	bh=vRKLHZgBnWXTw3cXnc1XVrnEacFxcRh8vaXsaPTd340=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IinAkEpqkbAEF6sRwprwlLFmuifmCVKly+SUKjx90IKsTb+bUSklGW6K0HgojB9RSTO8UhpFwf7f4y3R1EZ/Ax35jc4j+PfCFshFnR4JUnlMXYfgwvwfRQ7bHNF5ZHMb9a2kiieHu9/5ODi3GAAgm38fY9Y4Hotf8WnUBcdyppQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=LXpvMmjI; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-649523de905so1495964d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 05:39:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769693996; cv=none;
        d=google.com; s=arc-20240605;
        b=B2q6KUaMwD1dSwRAlVmpygsU5nkOW39BPrAFYzn+JXRjoz2NmPCt2820392fMIsWru
         ELGfOcwVoNAbG4xeONQiBzIa1SxsJWlMCS7y/FKdDn/TxmkSZy0+DlDyFhsaLwoj5mus
         SyJifOE0pxc28tWA5Vl3Siiuxfcfd+xKiI+cdlYnK79SEx6QyamkjBNEjQX0ElnfM7mG
         jT6FCf0rB5fAPbYfVfTiy+KM6rulhLZBoonmdhbXOQYuOxo3c0ud6NshFg9aYC5xHVye
         k5hOBvPGWRJ0uq2iChs5ZAJToYNES6jMv6+l9uv686NMIpwBb3GYPbx3BAppTd1LgXbz
         HAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QOUXXh54vESSTrZQI0KNya/eRaiQK+bV39JVpHPG8UI=;
        fh=cBSH6hVRk2RC5HpQ7SCqwglbL+Lu8PEdeJw63bwOcuw=;
        b=PoOkFD+NuorNGIvX622RRqktmYOvo9cxzP7UxFC/O8T3CXce49kcC2lGQkhBvfd6IE
         rDhiK1Fkqzr/5BXkfuL/aj4VGbJLfBrQypJdtf28IL37QqMMqifebypb2wcWyMww/bg2
         F3dfgxcyIm16meUQBbrlJ09dZYXMAMBS0EzDlY+F14JiN2hrnyHOhefo1ieWtaQFCLbN
         74GXdc242dvboSaZu9E8gaVlI4MKwQI9tG9xrZ6veM9ZdnyPhk7MyeCRGCGlgnv32fEa
         OcAewiABs05Sownn7NXp8zfZ039LBJolQ1yeK35q3hIJw1jYGMBmrKzodVvPtXEN4DYr
         HAkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1769693996; x=1770298796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOUXXh54vESSTrZQI0KNya/eRaiQK+bV39JVpHPG8UI=;
        b=LXpvMmjI3puXvOdwjCJ2hgi2t8XjSjtA68tb2LWJjZNMsjsDL+E6/YEI2WycsYr7kU
         gYpJGAxY3sOnamVBy8gPvKAP+2aAZPPDHJA0Uu+7Cl0viwQ6u4i0Y/O2KEMGz8Yuf5ky
         xHb9a2QxqSLN1kC7lpX770j+Uyluo3nWSra0EQoJeY3DUFJNZfGr7OldwVcNjn1oil4F
         MXI3aqnCOYvxTEmjY1UipVY1Vsj404S2tmWURX3hH8TuI52rxCyqo7a3NGkUO5vh7/3g
         5EVTYrGWnOIPUj6aBNc2larKGf0ttHdZpwSHDkofnvMGQV2IMMbgdKfF5r5ULnJSM3og
         pq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769693996; x=1770298796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOUXXh54vESSTrZQI0KNya/eRaiQK+bV39JVpHPG8UI=;
        b=WZpTIbPKb2ezuZNgpWCMuUDs1YrZTc/dsXeSJ/6om9PrM3ALLPqLgJxGTmSMWTQoAX
         hfIo5W3IEtjzCXPnlvHjrqlhrnoIvPJvsHMOVIeShkxqz8MjBcl/2BV6nEU/v1NEheaL
         IORuoi8aJ09jVLM6o/ayxfWyogmSDl0iPvDG/JVX4bM51mt1BaeGR7iN87rb7M7XtvoB
         a0MKHOi11JdpzWUplFibKixTuYZi/XEQQAFt8BvQZ9YNSxkcsMpVkWLDpWfecFUypNIi
         ACr2RtPfOGfZSocjrnQ5byoCKz7LL7kjbXIz9kgqFoOJe+94FON1ZS/Dw4yvbOp4mrjx
         /KCQ==
X-Gm-Message-State: AOJu0YwZl7YFcXK1Awx5AJun8E8CsFQwOpu1Q0cxQ8JZjLIlXlP0yMtJ
	ym2NAEwKyX4IFgDpjdMZk8J4w69g/F0cfUlHdjR6Vgfvr5aYvB0vjkky+PEkxsZxWogap2tea3i
	Q91peVZZp4j+VtaYBAVDwKhLi1SwN2oFZIuBgOpEL+A==
X-Gm-Gg: AZuq6aK4Lc4QgN9GVvEsdhouye9mzGDHEEN4iPlU/qrUnhlFydi8BLUWuPwm2GcAJIC
	Ujnaz4Nm5pLpzlbKXKJ8afYikG3YTCKqDWg658cS/omXcyfspeN8cwmDSaqO7Exq0zOckg/xTsJ
	8RJ8DVeEnEyUWnFnSzHLzmEGPiab+IQsvOvf1VfVDAj7zyNKfevKVgh+CWHfiBDIBzxp7H/y3Mv
	OQAwqQAwa0ZEyes0++kXLiFCi4NJJ9qLgPLrX7z5CVAKwejLOjdzLj+V6qZJAovhhIcg7rRBRnr
	AB7VQ4PQObQ98VYhQ5zHlXj+yeUQ0VnEyevP0hLhqkLP367YolkISdGO
X-Received: by 2002:a05:690e:1208:b0:649:9795:619f with SMTP id
 956f58d0204a3-6499efa8a9bmr2062618d50.17.1769693995787; Thu, 29 Jan 2026
 05:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
 <20251105-rotwild-wartung-e0c391fe559a@brauner> <CACyTCKjojw0M=9NEzTpASd+OhgaPxU4hFRV2c6GEDFLZ8K2bWw@mail.gmail.com>
In-Reply-To: <CACyTCKjojw0M=9NEzTpASd+OhgaPxU4hFRV2c6GEDFLZ8K2bWw@mail.gmail.com>
From: Snaipe <me@snai.pe>
Date: Thu, 29 Jan 2026 14:39:19 +0100
X-Gm-Features: AZwV_QizcxeNaF1MtMGfa6H1-Kk3LonFG64QkEg3wSNo4-OXMBzwtdauWb2-stM
Message-ID: <CACyTCKifDxhGBY0S9AYZBCw6S7-mf+0WYv=0VjBq_a+S0sWuiA@mail.gmail.com>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[snai.pe:s=snai.pe];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[snai.pe];
	TAGGED_FROM(0.00)[bounces-75856-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6AB9BB07A3
X-Rspamd-Action: no action

Hi Christian,

I have time to look at this again. I'm however unclear on the
permission model that should be applicable here.

My overarching motivation is to be able to have a process in a
user+mount namespace pass file descriptors to another process in a
different user+mount namespace, which then bind-mounts them. It seems
to me that the only real checks here are that 1) the file descriptor
points to a tree that is still mounted and 2) the caller has
CAP_SYS_ADMIN in the user namespace that owns the mount namespace in
which the caller operates, and both checks seem to be effective as of
today.

It sounds like may_copy_tree should just be changed to this:

> @@ -2946,18 +2946,21 @@ static inline bool may_copy_tree(const struct pat=
h *path)
>         if (!is_mounted(path->mnt))
>                 return false;
>
> -       return check_anonymous_mnt(mnt);
> +       return true;
>  }

But the above worries me, because I do not think I understand enough
may_copy_tree to warrant the deletion of check_anonymous_mnt, and the
reason why the check is this way in the first place.

Any advice would be appreciated.

--
Franklin "Snaipe" Mathieu
=F0=9F=9D=B0 https://snai.pe

