Return-Path: <linux-fsdevel+bounces-75422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC/TJM32dmkxZwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:08:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C8841F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A428630073E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535B1C84D0;
	Mon, 26 Jan 2026 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9kfJBC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324A1ADC97
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404101; cv=pass; b=WPdcWyBIovZ/Wx4VgodA6BRIGlEReaOhPGb8wqJnP5uZDX06nMjsS6tkAi979KTzUDZ011lRpmBYPvXCiTdyOjva200IxtOo4AzEz7MwGS1MKCO9EcXJ36ebtkGLRD3QRf4dIuCrXWcI8WxNfYXeICLdLAGX/w/1O/CPsMLZviM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404101; c=relaxed/simple;
	bh=ZBsVD6kxKzurT7H7DtCLfcoGufza6/gI7cdcVlj4q0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCMcHDxUuHya2oRNvS3gWURscMwGHN7+Zq7lHo8RNBwZotIKGSxq0LkC3zbEZblwZW90vkhQd3pUd1lQzUA9OCh1cQp1dRJUI1qydovtOIaxiskmwbrAiNGP3ZxYWq11mYbWClx6aaVIjYSI6lHMf2RYWqwlMnBf2yAhZW7pqAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9kfJBC+; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b1769fda0eso431211eec.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 21:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404098; cv=none;
        d=google.com; s=arc-20240605;
        b=W8wGtCmpVFpDpUhBYp9lEl+YvyhutnorxY/6cEZYs8SOa1UL9r3nZ+l0RcpqkgKHtj
         LQKtCvwD1oAdhD/fmSztMSRX3IrMRGWeA1kPyguQUypkxZe69QxWzQQtmcJBw8oYUUo+
         p5VQpKawfofOiZ/CTkVi2F9sLREz4c1ZuoxnVVvRET63WR4jOOLSLUJnhNQvUVZRmVf4
         C1UGHa2cyRos5fFn9hj9tqhTya2OhQqg51xjAmg32XQmaJLjU3/gpre+qJyvLqoTjn/H
         UvB4ds5DrMnVb2KVlSLiQSSHW1p1hV2uzzmAC8UJANttV6fdvnrgEeS+g4oOr4ojbqKb
         PL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        fh=ApZ2oA94+KhBTRSHFfX7HXP6MXlW75ewQfKwKgZVqas=;
        b=AfZD8bqOm63CF5pBXwlHVIpZeEfzExOlhryhy+Dyb2UTB72HfiIb8sSNQKAS2M7jPf
         SCb/USXM221sET1cfe8k1AylXmjr/1jmEwaoMKsL2I4cgLT0q3ZkiIdJN4S619zU0qVN
         UJjvs1CcFNKitOSU2WBC9zNKpfNBKR6Qxhvqeai8XVKOpt1UC0nRc0fNYtQfXxIZXXZn
         SzYHX5HLDwj7ZZ1QwGZNhDy1NQIs3hLoxyrnQZF1R0N4yR2GOrWDdO3hJSVMh8CDiPXB
         4IK/SC1669dIP8jDQqWhTEOS0y9x7O8bAetGv7yvydc+2llPskTnonErmhTEl9YwSgvu
         K3Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769404098; x=1770008898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=k9kfJBC+ldCHGEir2hpwOAhElO6egoRCIxzj0IKfTEqmro2/yY4nV/+ZWVpPnASaL2
         +mKMYxEvPEWQ3mA0MifDdWsjJxAV9WDFd60bga1tQmEuwjCMbcYXGnmdKnOy0gkl2ch2
         Mwj8Ks7ue/Tv0fi0t1I2FGHTzLLGzLT7EpWkOR1/bqd5u34W9Lgxxo6NypTHOKYsnB2Z
         KCh6L7ducVKh/8PXfUb+iHCyyPnIdAB5ON83DnVEVnBfpqvtvEurIJrSHBLvIkSub/iU
         dCIDy2cliqsDj+61/J2ss/bUZVs3zCGOy2Q26lc2sW5MOSWlOjMrzV8iWQUqiUi0YrGB
         4lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769404098; x=1770008898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=ZbO+MpCa/EpC6mkD56Gr8oLHHfWKL2ICcj3X5MVzasJ+uCed4AikBnYvgSvz+Ly460
         hyW5jCozN+LNFG6jFRLVs/Ms6WFG6OokfcVBUjku0aKa8byfN3IKasnUG+YUC/bGLKSA
         wMw+lyq1HxwCsko9gyP2uIxq/AfuKfvAMjjM7+X6kcyEB4bFDpDJBqLlbE65iLqtd9gy
         J/twmx40SYcYUmnTPKkQiQABTzrrj75xz3A0QHrVK6ETazicZ3MMVEQ6JT4P1HsDQ9My
         URLb0UzI5WIVmzWi20JaCuvHLpHJ7Yx4yxTqdl3yxuOI0O9yQyK+xZ3xG1cpSR5eyY5C
         84zg==
X-Forwarded-Encrypted: i=1; AJvYcCVj6gmvIGEkVVH1n6mTnWxqgsU3KCza9L0yrbdz26W6BpJlwrgsYYSStZ1FBxRT0tYzODbSHAxEpXDKD8wv@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDHXu7CJrvJZ43eWapJwOCRdAA/bvuGfVbVbk3/JfBfVQddmJ
	EczadX2IbNheeX+765VYf0qBNw7HgLc8IE004CF5FWpZui1G7aLQ03uTDen/iSmXLN0KcRT+Gza
	ZX6emcZxaanALLd/6Ogveub9MHSm9bg4=
X-Gm-Gg: AZuq6aKR4m32otkDfg5iQTJv4+2wf30jC7Xto3Q+NiS4aQHDSs7DA1/TFDjoj7oYzo2
	+679nROBAe0jVnG+VRrkpwOWsqTZ9/Y4XzJ7Zpqi6CIQIVea1Fw65kudJbAH9z/0DlmIdk0CGYR
	A/pxjwSkWAHJF0xGpnI7lqKjnInCIl7ZSwD5qrvc8JwrnWlhtyGrk7mSPVPRpPw71n+269Eh0IF
	Iu2CsQYV+n+Wa3N6MloEKSwF3ABLvMuZ0TIioT1KvjcG+9xblq/F+qdX7MZUUbxYz4eA74XgG//
	/5WY5bcsxZq1eO6SdMtzrzY9DHD4x0I+Ll5DNK/Z7dwFsL1AMoLQh73wZbQVBDcjQEhs5g2E1O7
	6o4OaG2cdqecn
X-Received: by 2002:a05:7301:3d10:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b7644f41dbmr855051eec.4.1769404098278; Sun, 25 Jan 2026
 21:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 06:08:03 +0100
X-Gm-Features: AZwV_QjC45jcqbNpvCzRgWaUDtcYZvulw1uksmCYv_NCU9WJD69mYzMDZ_yhpJo
Message-ID: <CANiq72m4hBinKM4jRrkpZ5nM_wraQ8FMsYtjgKRkNDmK5sS8dw@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using LTO
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pwm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75422-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,garyguo.net,infradead.org,weathered-steel.dev,kernel.org,baylibre.com,linutronix.de,paul-moore.com,akamai.com,goodmis.org,linux-foundation.org,oracle.com,lists.infradead.org,kvack.org,konsulko.se,collabora.com,samsung.com,kloenk.dev,linuxfoundation.org,suse.cz,gentwo.org,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[58];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D7C8841F3
X-Rspamd-Action: no action

On Mon, Jan 5, 2026 at 1:42=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
>       rust: bug: add __rust_helper to helpers
>       rust: err: add __rust_helper to helpers
>       rust: maple_tree: add __rust_helper to helpers
>       rust: mm: add __rust_helper to helpers
>       rust: of: add __rust_helper to helpers
>       rust: rbtree: add __rust_helper to helpers
>       rust: slab: add __rust_helper to helpers
>       rust: uaccess: add __rust_helper to helpers
>       rust: workqueue: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

If someone did not intend for me to take it even if the Acked-by is
there (e.g. perhaps Andrew wanted to pick those nevertheless?), then
please shout.

With this, and if I didn't miss any message (plus looking at
linux-next where I see Greg picked usb), then only clk and jump_label
remain (plus any new incoming one).

Let's see if we can get them done next cycle then.

Cheers,
Miguel

