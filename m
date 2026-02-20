Return-Path: <linux-fsdevel+bounces-77807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CawLRCbmGkTKAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:34:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E033169BDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B302B300D34D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD236604E;
	Fri, 20 Feb 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmovhQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED901365A10
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608845; cv=pass; b=tEg9RGp6Htp2dsB2glV5xjrtFih9PIoxDGv9oxJIdkhQN9eBh3iNNRcwsuHoOz0fdWLEOzPFWxMNaltwzh3fKBkjuUYV9u2CfR1ljPrLEJRI656Q87Vvo8QXY/sEfWSpAuMfc1k1fHASmkFLaIp9dCts4u9mqnD540JE+iO5SlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608845; c=relaxed/simple;
	bh=dW69iUku9IRFksYkhFKb49OwK2nuvLOXPied0JTmtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH1V0TmtfhafVvWeq14DE0MDgTVz2j4vf58XlqMw6bEurZOwUuM9WUOtjQCDnSlhsLeMeMG/KLLhSq3CkDcUHFfKWT0nMKPYjomc5YYPUchNVR8A/8+8PuRIRfHxg/2mWhpXCfzoO4gx1VI5VGR8cGU6FVpZ9ZRaZ006fVC+pZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmovhQZ; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-127148c2112so221437c88.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771608843; cv=none;
        d=google.com; s=arc-20240605;
        b=IkDrKKbo1VfFMLqWmE9jCKZOqpZUmhtpYAxeHloT8ni8N5v/eIVxFdVMWURqlNDcNl
         98jt/sWXsZGpLUSd8hiZrXOUsjTrszRGV4fvDokB4ryoXS75oxMugPGzFJpqrG0JBHTC
         XNDLxLgjHaonsHTk711BhgGk9uXq8eO/p1HxYjjbv/kdjJPtWC17E3rNDvDy/hNG0u8f
         w3DKQufppXX9UG0/YpvtMrwd6yXfJU4tRijwb1zV4rjhseJvu3XjJP7db1RwfUXrWehw
         6kSNgXytH69qhlt07OgDNm2ZKRRKXoBtrKrwwG8OMlqrbkCjrfAmoPkdNfnmDRHovfIz
         qnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        fh=OGnppa86UoermWoTgTjPtxHXr58z8nqwJcqWWn1Hfw4=;
        b=iyH79U30yJZR3T9x0W7p2Md6bZvK4ZOh2PSP2DqVZvQZVDDtmG5IMDc69glPspLTL/
         b8lm2ECpnvOBIgzZUTp4TK8KRYGOZihj0MZLG6oksrHVCB++yjIxG3K179Kms67P0qC1
         jUNzO4qDe7bBAUbohQ1LPU0RSJvQjV2bDbvjxzFwAf2G2RMvelzuToVaqSnUfH+1Zofr
         ooMGNBe71Idt1kl/DIORV+nKdBL9QbzLUt4H9oInKADUOx1S6XdGZ6Zsf+aaOtQq/ltD
         T1sw7997k43AY/hoWhKQhD59Z0fzM0Gbogc4MftgDrL72Rhp4oRY1aa8fEQ4q2zxEqkN
         v4Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608843; x=1772213643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=GUmovhQZ0/gL6Csm9lB/oZvXQzoRbh+uVmBzc8YSv+cMKg9Uubues33H/9RyfdILfj
         k+zc557ufFVnuu02HgkHoFuAOrYPjf492rTJMSJs+Y14GZdZJ6vatA+cSh9f6oo963Io
         d0+6cjq3IXdboW94NV5+1nI2XbXJvpX520Bj2HNaDdIOD88O4E6cx87O+l9159ye1JVx
         z5ECFYUXaEaFv94IyKrGZwFgzAl9mjpRAIoxg2VDDG4MXRpqli7BRe0VZzFziNXygZdF
         C5HOej3GIe0ixLu5QAUeJFlzHR9sfGixz9LuDB31Pak32LJ1sCx/7snoqduumBjN/l3T
         gKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608843; x=1772213643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=WrNnQc3IKCoV2FEyGvXA1nfpzbvvYOd0dPBFkPIwO1z8owVkZkcE5AZV48CB7B8hWk
         IeggrggS5MuoXG/0QO/a/B5AKsW9rLLGR1Ps1woCetM6ASOs9iq0CICOvqkJ5pM2Gj+9
         a+5RzGQb1aHPFi2jvzmhQMMNMobwJnuJjYBb/T6ACqP74fNfwzwxGM18tHz/Y/BxRrkn
         lDvyzinLvS8BefTEqeT2TUcSVqQxbf9teIhKtgj1plsXl1aqFR9s6tmsvaScWKHPsqtO
         w7SGuL2UcG3PfR5TGphECVmrQ8qCBcTVH+jE26/h7ROWqSLbmqimgwrRqb0A0zB9/6/n
         AuyA==
X-Forwarded-Encrypted: i=1; AJvYcCVPbg45DkV7xwzQkVrQVg0gi0kS54XD5HTpoPetdYRNvoesIFiWKLnhRULc6EBH5siuT0m53McLYeLmS7lm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1qvpAMqZps22LzuIjVmYNI5DpU32GUDeoeQFuVIPfg9K60Z6
	Sax7KiOvqfDjmRdhOMn4ZjAEDSULMZ5SvjhFOhE2LgMgTP5iX9U79bAkXTG/O9wHpuseS01ZlFh
	0ag25y2yJIlDjcA9COHAVwRAJTohEMMo=
X-Gm-Gg: AZuq6aLz2/o05rXLJLDcwKr0EI6KCsT2j8KoOo7AKUMkTnsq3YHdnTlOy2R0Xb8oXlU
	EHXpMFn3IgU9tTBtAun+pPvlniW5z5TgDJ8rCJ23LWyOg0i6Qj+mxaz5C/qKEjBybFTciH3xvv1
	2fSWWNrowFpoLprQS4k7oXOSrTIFDxuQ7lviO4U1Vl+ZPamV3ubA6O1HQk2OxHxbp/gW9BNu98f
	fuldv8rKnNclbRcUJ1K7PxGUEQFjnnn9CrDpoXUD66YCcIs59sOkm+juM+nHbRWWVntT1YHDFMQ
	ewmyDt/iNw3qNCj6l8H6AQ/nF+XHTqJwuW3cOYZAutDAiMmZmPPnSoq+VEaa6mUKUBZhg1zxRTC
	srELs49HtJ+Jcr2LXhFKuZjuD
X-Received: by 2002:a05:693c:2c17:b0:2ba:674a:dbe8 with SMTP id
 5a478bee46e88-2bd7bdbce7cmr74947eec.8.1771608842904; Fri, 20 Feb 2026
 09:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Feb 2026 18:33:49 +0100
X-Gm-Features: AaiRm53lo0keI-FayfnRj4AYfVuM2jzmE06bNyAO-n4MO92LWSUkvblDHz_tCFM
Message-ID: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77807-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rust-lang.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5E033169BDF
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> +    /// Create a `&Page` from a raw `struct page` pointer

Please end sentences with a period.

> +        // SAFETY: By function safety requirements, ptr is not null and =
is

Please use Markdown in comments: `ptr`.

> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.

Since we will likely try to starting introducing at least a subset of
the Safety Standard soon, we should try to use standard terms.

So I think this "valid for use as a reference" is not an established
one, no? Isn't "convertible to a shared reference" the official term?

  https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-convers=
ion

In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
stabilized for 1.95.0, so we should probably starting using those were
applicable as we bump the minimum, but we should probably use already
a similar wording as the standard library for the safety section and
the comment:

  "`ptr` must be [convertible to a reference](...)."

where the term is a link to that section. Cc'ing Benno.

I have created a (future) issue for that:

  https://github.com/Rust-for-Linux/linux/issues/1225

Cc'ing Tamir since this is close to the cast work, so it may interest
him as well.

Cheers,
Miguel

