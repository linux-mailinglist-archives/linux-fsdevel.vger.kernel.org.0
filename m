Return-Path: <linux-fsdevel+bounces-75605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIzvBJXIeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:15:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7571B9578C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7D6305EC0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3C35A95C;
	Tue, 27 Jan 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S86uNwKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD628357A40
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523267; cv=pass; b=Pu4oPpGJV1PmU4blyMljGZyny7HA0iv60Qpv4iq2SXDDn76CRzAJxWCYpR2omGDWp5RcBFJR0kY7Ym4hnrEPaxos5MEXM94MqhQ+4ArWxpCBn1mpONMyM0XHIGv22lBPX/YV4t+IPbeugCIurMripigNQRUy4W7NnztzxE1x4jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523267; c=relaxed/simple;
	bh=dAHdYOnTFtUUfjLxek+jTi8Dv2Ts0LkzWr8wVH9GERk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+fIlVSBWyteG9y1VmYZoHPXoVLIci/9Y93v79nlES3cBLf3+lbp3t+qvZCDoS0sLaSOOtghBAp2QXmTxWAWrvXhSpVXYz+2wKlVNl5eyqY5t77nfRyqcWSKwHZHEQgFc4N8Dw+edbDUu9h8cEh2lnoSFAn0MAJqNb8wOJ4Hmpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S86uNwKh; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3831ad8ae4eso51121131fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:14:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523264; cv=none;
        d=google.com; s=arc-20240605;
        b=L2hn0RNwU6STpIkfoUpi2hoocNo3Z4RyQVOFQrLg8Q7FX1hWElDcGRYF+okMmcBkEL
         /7InLnyffGWgYbEgEA1wgzGDlSGLi7nH6QCjBhYeVJ5MKEiibCeltFCsTLIhP4ZqP2S6
         20P2fpG6SIDTdUbpKQTWwCWY2JVwXDD2G7btQ/aFbECy99Xtd7w4qKL/jeEW1mgP9iCe
         UixoBCwbVvdvK0p9tEX/xMJggvBNVoxU8nh9yWvzhCx8MOsJt9480v1aenqVp/6VWAvM
         JRrgmJ2y3aW+kl4FHNoi0BawvQsxJZ+j3N5/KFYg96H1K39pb56RVNuaVbpRBmIpqyBH
         telw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfrvELjsn6cJgRhA7JmRV4MxQA5oz5VbCbL+bgCyxZ8=;
        fh=1aziS2Lg9wv8ns0zZumgFiZG36aod6AXDGGHB9Bl9+w=;
        b=C6CQPWJDmWYrgbHQni61818ZGn817gcFtPupW2cOrA4GGmDDuxisCoO9j/JdowkNoX
         0ka+Mg3YhxOEmlnPFeu2nWHQXadluLj7pqQ3UeGSmFebJdrRfyGjxRch1VAEQPwcgvlP
         vd856vDEnb+Kzg0sw/MfHrO4rNoP1R7asTlflzVRtyvsRt/Gd32Ncw1i3DsGCVw9lLld
         tEUxdnQcW3VOrcA/PrQ0zPWh1d7XGGFVx+xpS5Lo0s7PpKYHj0sIBtQRy30sijltutUB
         EfZ9kIO1wyG5ocBzXkiRj1LJYASZTIqoYmDXvYX9G4k3ym2Ov4PP5UPImVRZdgXtChJz
         Ea/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769523264; x=1770128064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfrvELjsn6cJgRhA7JmRV4MxQA5oz5VbCbL+bgCyxZ8=;
        b=S86uNwKhxJfbO7sajSyXsjLQPSX4o9UngOWbW2X6W4tzws1j57x8dHjC4B7Fh5jOCd
         fkTsbsnq4EToPBqt+o8lunjGBB2VDa+3c6uv6LDAb8iIHVaoen75QlJPPSAB3J7UL3hf
         wQUbfZMbJMw9d/CakC0pTISbMrhFc0PZsaSrLshe0I1RIMNjPT5wa5AQCJNyrHZsz/wA
         B25aQKQm6A5oM3vbze09wzDhqDpqK/yMxNWj9uqog1b26EZmKsq7wcAQd1MQnMMwwKMV
         wzctNAzGHdtE8BcHS5jKdoAwVU7Mf+85/v7d/+SRWS8rtILig3njhp0G+CzpYmqULdjv
         6Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523264; x=1770128064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfrvELjsn6cJgRhA7JmRV4MxQA5oz5VbCbL+bgCyxZ8=;
        b=WMj9BExgcjqcQ7l2hbizW+Y/yYIiqsSCWT7Lk4P4AskqLg+HxUg4bTz6gg62zay5JA
         YXNkPDLEoAdLs/pxMKGamJwD0yZN3TXNyrqgYTFfO3PpN4T9KCO9ovKTZ1oOQjk3EbT9
         xZI/RZQ+4C5C9pOfzysLLolA6ubuEWDxz0Dnr/CIHw2jLG+BSyCufNWRD2HhbRHrPN3B
         UjZraZ0kUggFdeJn3hAo7Q5iS3D3njY8EfCHQQo7nd9ChBp315rUNze8BZxta5gO5EEJ
         ybM8zUTfZUSbjpzQmXHUi4sTo1rgPGwcoFBndKZaBh6/+GiLFGvHD1oK44X2aYR1qmUg
         HFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUyArp7iN05QX3x6KrVYtucRyaZDIRlIPT7WtQTpmp6dpQF9OfMSSHPPbAGu2LyLZBTL7dyor1LYHsHsRs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5q1xxIEleuSxbxibaxOLpjiNIi0cczkJXVJEURDSbkGO6nAa2
	A/4zfq8wDjIxBJAVYrsNIje0k/IxB+hir4g8cQMikTtDga+akEfXO88FS9GONLw8Y8aLD0DxKiv
	0+TWtVs7xb1y+BKZuTPxGf3K7LKSZqLo=
X-Gm-Gg: AZuq6aJfkP/5rLtfWr4TZU6LcBiUimyyuuEJASCOk6HEVZq1+8O+qUY7wRKtWS7J+Jl
	4zMMQgwgpHSNBi3qsEwLG+39OV/iD+Wz72ypKOyOzDVerQhHgDL6qdX1yvTcZBn6KWv3wQiy5Ic
	7IDtYWKdveQcw4Q1rFtPH0/vxWKT7N7lR8v03M5v93obuNwmCFhGtS5OMCWRa67uJ15BkGsSRJK
	sLdHLBH9j4rEGvUctcLkvhn+GaAF1Klz9try5RuUt2nGUJuM2KOk3wnLTOlQkFL4SSDSBf4tGUB
	pr9/z3CBuQyluFd7ix2KdIlHkgrZtJyNgeguQbl9mdCRNRt4TJ/LwuJo+9ECNquZAWD7sF5MQ5e
	er7ZqSVCA
X-Received: by 2002:a2e:b8cf:0:b0:386:13d:40c1 with SMTP id
 38308e7fff4ca-3861c843341mr8162801fa.11.1769523263576; Tue, 27 Jan 2026
 06:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
 <CAJ-ks9kDy2_A+Zt4jO_h-=yzDjN024e1pmDy4kBrr5jsbJxvtQ@mail.gmail.com>
 <CAJ-ks9nZA84HYL_7+raFvcS1G77O7FyHk7_fsPMYuv2K1Ecp8w@mail.gmail.com> <CANiq72nFuR+W=sKMgmxx3VjxtrWGb66N3UBP6ZDG1hhhU9Bf9A@mail.gmail.com>
In-Reply-To: <CANiq72nFuR+W=sKMgmxx3VjxtrWGb66N3UBP6ZDG1hhhU9Bf9A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 27 Jan 2026 09:13:46 -0500
X-Gm-Features: AZwV_Qjp2ZD3V2IpQAwWSHlFmvmXLxbYh9A-ttXDvcr15-3ozKqBPEGAKqKuNgo
Message-ID: <CAJ-ks9m6AbgTVWEMd9qUNgyTN2OHnrxXHybYp5xK0JUUUwiFYg@mail.gmail.com>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75605-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,linuxfoundation.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7571B9578C
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 12:59=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jan 19, 2026 at 1:53=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Alexander or Christian: could you please take this through vfs or
> > would you be ok with it going through rust-next?
>
> Either seems good to me, thanks!
>
> For context, this is part of a long migration:
>
>     https://github.com/Rust-for-Linux/linux/issues/1075
>     https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Cheers,
> Miguel

Another ping here, folks! Miguel, what can we do if we do not hear
from the vfs maintainers?

