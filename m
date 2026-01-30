Return-Path: <linux-fsdevel+bounces-75958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNZQGAH3fGllPgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:22:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C5BDACB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E4293011C79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A637D128;
	Fri, 30 Jan 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku7XS6V1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE83033C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769797352; cv=none; b=rpwi4DLmnVLUr7hlRNLcB9YpdJvTtVtQe6SMaTCxeR+CTnzuiZGlwY7SlL0Pss0I6990G9UgfBxHuBwzs67/veHkAu6KD0U5X5UthCXEH3BbgQX5q3cLTMr8TFmA6m+Vm3ZPhLKWAYpUTrwBWj8RFJxv8nV1SBZXaeYcc8zRJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769797352; c=relaxed/simple;
	bh=lU6jpbnATpQTxYeo7D2FPha7yl7UYUmflHoK5DqPtZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvNkNqT2pdgCsCz4bTI08YXncYkK65zfmuolkC6d3iMXTLg0VxCvrwB2UqWSBHViNopEUbCDBRVTsb3d98VmeBPC2v6WPx/0vzBa0tE/cTWsXuXOnaYOREDO4UBkm/nx1owhV0ZMnmnejzJbEYQVyKvxt0UK+XEOOdD0HLKkiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku7XS6V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AEAC116D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769797352;
	bh=lU6jpbnATpQTxYeo7D2FPha7yl7UYUmflHoK5DqPtZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ku7XS6V1IUm9jFqzSILTpnP+tcAP1m8yAgBc3K+hxUTvYnoxLiz552piLqadwgG55
	 F4hmuEsSDhAblaNgj/5Nj6BQD8yQNxeE88a3hmHdgRqIft4bJO0l3nAmdvr8twhlWG
	 LPJGpaQv2nHKuVVXyDqlr/EfSG6csJRwpeqxop28c47tKMlC3CV4SJLjctBPqdJ2U/
	 I1HHToj02LlyTW0LL7gI29nx+liksfigH8jKyJ86QGIobSXKllyHPwv0LWS2ByImh+
	 +B8ApHwIqCKOHMVkt+++j7lvZwk6G5fcKjACxRbkMm/OaLAk5ZjXZiFDYSso85xGKr
	 RzWTM8i0f5/EQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-385d9fb297dso24636751fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 10:22:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRjKev0JjMzJkNeOG42THkeOvWYZT80X0DLyWAWW0guwheDv7eZ09t43ChQ4MXqCFAEUV60ExasCW0hMPY@vger.kernel.org
X-Gm-Message-State: AOJu0YztGuLpgi/qCzVf2vY/+xcIFklF5PUI7yJUSCxWM6UTymLAwqUO
	KIWpB1S77Nq2B12h7nElqGAvP9ux7n42bfldfOnvbjE819rJEIi2yGe2Yxilb7cAt+dJmAGZa1N
	Z2kKjFUnIIqaKW08hGyQHd3TrTk3ieIQ=
X-Received: by 2002:a2e:be90:0:b0:37a:34e2:88e7 with SMTP id
 38308e7fff4ca-3864662d0d6mr14586501fa.22.1769797351096; Fri, 30 Jan 2026
 10:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
 <20260129-erwogen-vorfeld-85a7dd7df060@brauner> <CAJ-ks9=+30hkc7+AJF4Sd7T0+odPtiK4p+XrNyDJUU2rrqOP7g@mail.gmail.com>
 <CANiq72m9sG8K6zJWCpG_yMih8KmX-V998e3C0LviWoo5p5ZA1w@mail.gmail.com>
In-Reply-To: <CANiq72m9sG8K6zJWCpG_yMih8KmX-V998e3C0LviWoo5p5ZA1w@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 30 Jan 2026 13:21:54 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9nNShpgdu_+eCNjvfD7YNTqBnV4Pz=u3C6VpMgS+Nq-Zg@mail.gmail.com>
X-Gm-Features: AZwV_QhIpdBYIn0WR4XDgBiZCHh8TeYVKOmfDznE-6oYEp16_YTCAUI8OHZQZII
Message-ID: <CAJ-ks9nNShpgdu_+eCNjvfD7YNTqBnV4Pz=u3C6VpMgS+Nq-Zg@mail.gmail.com>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75958-lists,linux-fsdevel=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C02C5BDACB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:20=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 29, 2026 at 4:14=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > Thanks Cristian. The commit doesn't seem to exist (with this hash or
> > any other, see https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.=
git/log/?h=3Dvfs-7.0.misc).
> > Is this expected?
>
> Christian may not have pushed the batch yet, given the dates in the repos=
itory.

Indeed, and that remains true now. Unfortunately this commit wont land
in linux-next until pushed, which is making me a bit worried about
discovering last-minute breakage.

