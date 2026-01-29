Return-Path: <linux-fsdevel+bounces-75869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL0COoR5e2nWEwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:15:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB1B156F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3796C3013A66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF07315793;
	Thu, 29 Jan 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/GzLzEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575291BBBFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699694; cv=none; b=ozQPkaNmpO9TuZFPmOL/L6EGnMLYCWiZq6wYd4EMZaSQtkt4pSjVVyrE+xNPyA2+hfJBUfzNNf3VMmqI4YjvWErw111KMyhCadA6m9Eg5yvde3R7P0k2Afs8m5cdTwD9N9Shke0hrSBjCzOeJeNgTKfTSw7PO+hPco2H1UNLzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699694; c=relaxed/simple;
	bh=NggJJBp/i3w5RqpOL7RSwjlGSQMIjbg5xP/YpYdKkNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AswEd4aYbwCpR4iH0sQbov/lygcOYmj/Fi3OaVSrfJLOv334MaUgIwKoh2dsVbHUTDI+GUP8FBRC3UxIAp0DYT3qA/3yVepjUVgri64KnABNVhO9ecJMLgvt+uQ4IqVrxqQruNM004t8ReDZtdaTHzmr4kPuNXuC/s/kPAxbLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/GzLzEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3063DC2BCB4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769699694;
	bh=NggJJBp/i3w5RqpOL7RSwjlGSQMIjbg5xP/YpYdKkNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N/GzLzEecn0xLasCEjL8VgYKKYztAtxoTZP/WIau5R69LVL3JTkwu1o8nMURb9zZj
	 BWgGgCJGXJae9ywrD6ewBvrB+XlKQnD++ASpDTnoGeBSv+6TkHhsMBSTIdM5hrOuho
	 TDAiAXaERa7OI70FiraBqJPwraSDgvNWjhHgIjeRGZkMWrheXPiwRBgccErLSSS9ye
	 3kO9JmP3Nk5LPTNH70AglFgE1uIvx3Q6g5LlBmIj5wsSYGQFO7hRd87S8dwmcZBeGB
	 9aP2918H3wAn+ruWgZu2uszAk7tWPrzS4xDYvUNQk3w51qysCsSQ/uGFWV70mzdviT
	 nXCKMeRwXO59g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso1185904e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 07:14:54 -0800 (PST)
X-Gm-Message-State: AOJu0YwUIP1l+os/AcpY6X0aUtbFsz5zlmkbkX84EzAWKaHygXSAK9GB
	lCAtffsQEGJ4CauuR5Ss5dyelVOuWyuaQNSgQvk3c/tYUX2shncEmwgea0vP0msWEHfHs+7KETT
	W1ERmzXdv03f/WI7kpQRpfhs83MhIi3I=
X-Received: by 2002:a05:6512:3d1e:b0:59b:6c03:74a8 with SMTP id
 2adb3069b0e04-59e04017acfmr3961804e87.10.1769699692781; Thu, 29 Jan 2026
 07:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com> <20260129-erwogen-vorfeld-85a7dd7df060@brauner>
In-Reply-To: <20260129-erwogen-vorfeld-85a7dd7df060@brauner>
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 29 Jan 2026 10:14:14 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=+30hkc7+AJF4Sd7T0+odPtiK4p+XrNyDJUU2rrqOP7g@mail.gmail.com>
X-Gm-Features: AZwV_QicdVhMgyfNR6XQPSSI1RIyfLHD2csJUdSJLw1WJ3agiIs7UCgxnXK-2wo
Message-ID: <CAJ-ks9=+30hkc7+AJF4Sd7T0+odPtiK4p+XrNyDJUU2rrqOP7g@mail.gmail.com>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75869-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5BFB1B156F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 9:33=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, 22 Dec 2025 13:18:57 +0100, Tamir Duberstein wrote:
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> >
>
> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.0.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.0.misc
>
> [1/1] rust: seq_file: replace `kernel::c_str!` with C-Strings
>       https://git.kernel.org/vfs/vfs/c/40210c2b11a8

Thanks Cristian. The commit doesn't seem to exist (with this hash or
any other, see https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/=
log/?h=3Dvfs-7.0.misc).
Is this expected?

Cheers.
Tamir

