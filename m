Return-Path: <linux-fsdevel+bounces-75881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA8ZESCRe2nOGAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:56:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8464B283E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BBEE3011A6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340943469F6;
	Thu, 29 Jan 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKVvYIjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90934677A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705755; cv=pass; b=nBUv5NITtYjJvya/9SfKFDhWTg9rZpDwA9AYnstZN+FFcAw1Gark6x0nD1hDv02SUareS4q5CtFfmp4VC4h/EcK5I5vJnEa6MP4hu/VHahZ1fH1gxqvpwkicumx9DbW9srZS6EMqn5d6AfKPRGziwH1ipdysREuSeJvFB9axIsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705755; c=relaxed/simple;
	bh=DBczL+LW7LTFFjGxiSG8begktQOVzmJAElaSX3lMM0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYnIxGcFSdnqQ6ogvdsEod8O6w6q5fXYruJewvjSSRWLwWRPuC1PJwFJBLm+G3OQusPU4KBCHanIXzca2mX7GwMhcK4GqcNTXxq/n7AEJEMoOnVPBkHW0HHhCj9InBcTI8kgu6XN5pjvlZiFQc3mhkwmlw6UvoHvoxnZTRQ4/Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKVvYIjR; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5f58586fb6fso316317137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 08:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769705753; cv=none;
        d=google.com; s=arc-20240605;
        b=VVf/2HjmOaHhTFaPFVrEIRfcEWeeC8lK0Rmmdwo2QDb8i6xATfvpWHMsILUY0RH+pT
         ZkUty8dTMY0dXjv9Vx7ypTxX+S/DcgyBY1sY+tPCkSXud86TjY8qdvKqv9PIB2AGOzst
         SedVcpw9asfIewUcrKtElbAn7DuVuAsJo+pOWR8985qv+2vDsDXrmul8Dld3qYle3AIv
         mvfnPDnb6v4h972QnqUA3Akmjhm/BsSWvne/+hq+j5W9JmFemDS4QAjqv50vvutDjM4c
         zOXvH47YRyXRC7J0DmUlWXYcwhsxK84fvu65+urwkWz9tfBWb3OFSh+crGE92mQMnkIS
         6iAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBczL+LW7LTFFjGxiSG8begktQOVzmJAElaSX3lMM0o=;
        fh=jko0Xfg5q73jSqXVSzry+XG+KyuehBmJ1zXhAFj1WnY=;
        b=X4ZoqCCNTjKV1q2xp3X71GHhrr3eZg+BBLqbyM5VX+5Mzfy5OIHzmZEyGo4Yju+DfB
         g0VJ9qZ7JrfXdBsbrapfxAzcvRVqZ8bmDNJ8Ys8iP7pNeWhe5AQaknFFPmFVCHrcneLA
         6W6VsoxRl4t8Q6bLq+AfsnS++Wh1uVNIF1Hi4iw+YAjwp/+3pR6bA2l7LLUknJAfTRPq
         owNLQq/NpuBq8DJ+c9VPKl597Jh4O+OIyu/CVt4FP4Z4J2zJWMsT201mGLwLcr9MQWH2
         Fw6p3TnjTwUIZg6cqADKFO9PY2tV3N2j7ySaeDfahW6uwGXx+7RFzHjBc+exVSg5T0iD
         CzZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769705753; x=1770310553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBczL+LW7LTFFjGxiSG8begktQOVzmJAElaSX3lMM0o=;
        b=GKVvYIjR5US+UnnVZsc3NfO/TFZtVH85iT4utawp54E2J6ZMOL5Kq6j17fnaaZcfxt
         S8BMIVDDklsTEy4xRZe/Mxo2mhmbKva7dksqlJwHSNWyENZjzn3zGTAu+xZwfJpOtrQF
         4U+tvPpUktStg0hz4T4VmourP+pUOVytZi1c0ZTOjfiWOoXEQ1oHxBzGRXP1SDEgsJYN
         7T52SrWIaTZMtmtEcftA++I9XfKMVBaX5cug/RAwMhHESiidSls3gA9FgGdIELJRVqCt
         dNY9IAz+JdiOTvG3vRzByCT/XZ3Luieiro63vRldxRzxqJ8IEeq3+nhWb+W+OkVFfPxI
         ACbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705753; x=1770310553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBczL+LW7LTFFjGxiSG8begktQOVzmJAElaSX3lMM0o=;
        b=P9MrEfyXjduURn9R7qttXK5jE2BNTwUCkc2VnFTbqW6A84VLUU0to7payMGhzlkLzq
         bj5TAdYlU/YzCoeTHFJDGlR9PEopnfgqxxy9nceYG9W19y5NXL1YfkhC5E02q4P045T3
         56BTk7/wFJ2HM71D9Yw80hlLUpKbm0BFtMzGCBegOECONP8zLZRng4R7b3y++eXajvGh
         Hc6znkzRNH1hhNvaeA2ZjVthuRR+QJvazqBHS8mUbmmBKUa3gXU8q2+yYhA877y8alBu
         D1H0uDMexuue2t8VIUEy6lDdt1guHlUu9/yOt8YCdnF5NdMAsxjAj7ZG6f2ieOpiiCo8
         HsJg==
X-Gm-Message-State: AOJu0Yz8T47tmI58v8ZSEWYZQsZ1wfxaK0zys2I4Z66GUU5r82Pl0yEt
	UgFQDTJUSvfdChgdZgYJi2mTEE/J64jL+/42aEnzM93aK4e1ZLpCIm/E8NmbNwdixyNc0DtVdTo
	7K+AuXk6G6iWb0njEBjEC4tu/3mqnHTM=
X-Gm-Gg: AZuq6aLF559pMJbyEL4gY2HcK9bQjcNLPVR2gViS0CVOtNEk5j8iwSFZgjull3svBJM
	1PS2RIhRpQpePbvzujqOM3AW/WiZeo1Nnf3qTQ58wjF1JTGPV1znsfi4PFQ+cEvcu2VSBwKd0lz
	pJfyAY/H5SZ/zS3pjCqxUkSNn57YabyXeglCIH1zPXCx/TFtzWmlthCoDCxRD9J8QIABKKYiBdd
	2ucroAduH0kGRO62ektHPV3iXrr7C76B6e+bGuxPaxypfYtv1aKDb2b3f93Ub9dfKc2LmAsfj6q
	PojhMMBMAfUaev5RQwM2Fp+Sa/wHGdZcDKaOmps2pw==
X-Received: by 2002:a05:6102:26c2:b0:5dd:84f1:b51a with SMTP id
 ada2fe7eead31-5f8e26e46c9mr25201137.43.1769705752295; Thu, 29 Jan 2026
 08:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com> <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
In-Reply-To: <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 29 Jan 2026 22:55:41 +0600
X-Gm-Features: AZwV_Qg7NnYvXxWwUR1EmaPJMu6DWGCU4Tl0z08gQf0KxrB_3LTaHZ5QEYKwhdM
Message-ID: <CAFfO_h7acCeMO5g-r1ivS_7hiTJaY_TmbyOxRtvz-2+UdmJGag@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca];
	TAGGED_FROM(0.00)[bounces-75881-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C8464B283E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jan 27, 2026 at 11:58:17PM +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being tricke=
d
> > into opening device nodes with special semantics while thinking they
> > operate on regular files.
> >
> > A corresponding error code ENOTREG has been introduced. For example, if
> > open is called on path /dev/null with O_REGULAR in the flag param, it
> > will return -ENOTREG.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -ENOTREG is returned.
> >
> > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > part of O_TMPFILE) because it doesn't make sense to open a path that
> > is both a directory and a regular file.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
>
> Yeah, we shouldn't add support for this outside of openat2(). We also
> shouldn't call this OEXT_* or O2_*. Let's just follow the pattern where
> we prefix the flag space with the name of the system call
> OPENAT2_REGULAR.
>

Thanks for the feedback. I agree that OPENAT2_REGULAR is better than
the other OEXT_*/O2_* options. Right now in the patch, the O_REGULAR
took the next slot in all the fcntl files. Should OPENAT2_REGULAR be a
bit outside of the 32bits? That way it won't take any of the regular
O_* bits and we would only need to define it in
include/uapi/asm-generic/fcntl.h file and not need it in
arch/*/fcntl.h files. What do you think?

> There's also no real need to make O_DIRECTORY exclusive with
> OPENAT2_REGULAR. Callers could legimitately want to open a directory or
> regular file but not anything else. If someone wants to operate on a
> whole filesystem tree but only wants to interact with regular files and
> directories and ignore devices, sockets, fifos etc it's very handy to
> just be able to set both in flags.
>
> Frankly, this shouldn't be a flag at all but we already have O_DIRECTORY
> in there so no need to move this into a new field.
>
> Add EFTYPE as the errno code. Some of the bsds including macos already
> have that.

Great suggestion. Will fixup in v4 submission.

Regards,
Dorjoy

