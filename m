Return-Path: <linux-fsdevel+bounces-79119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKMtFyaHpmkZRAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 08:00:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B331E9E8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 08:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9212530465F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 07:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352538643B;
	Tue,  3 Mar 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="zVjRTRyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615BC8CE
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521246; cv=pass; b=RmmlKHUwBEpk4pvaeHVf3T/lZrkPqa21nkrPspjVIltDCz65yMJCARaprfqJQlfanBmZgPwZOYW6m/+3XCetpf9TTopgWojkU6JYk4eXFRfcnePD7kcq5OXnPP7Y8Iu8KwwUO8BPjfK4ofmq2hfGbwmMEQVhdRAM1ymE1vHMhOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521246; c=relaxed/simple;
	bh=QmOBzRbedV/DrTNT/zRl/BdOcIXhho1XmkJgkYUIQas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHb7zzoDb7ukdmBuPk6l404HQNy0THZrVrJgAYb+S7XLZqJbwnQD6Mf3Pe7YKT/b5rVpAcml0DAso4njruiAW+BYiEFRDMRQtactV/xLQ+Thp1Me2LstYYu1/JZ/U3NoHHRNiRf5FVLo0vb2nfT8UaiBBMNQEGZKeSicnZFNcaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=zVjRTRyj; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so4712313d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 23:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772521244; cv=none;
        d=google.com; s=arc-20240605;
        b=a4+Q9BnxVjU5o9+cCjfKuSQ9Ovd9UQn709vOS2r/QCbhgvNxj6jOx5umgF8qLh+wtv
         kGdWR/tpVdzty5TPzSdYMZ8Uadr8T2+qjRezUa9FhXy0hdATEj/1C/oloUJJcQ2YkHbk
         75lEq1pdZ0IDewAD9jYemstD/olZdI1AyPnzr35z+DM0MGgWWr+4mG5p90hrgzEf+TIp
         IHXErjZyzmkbeQn5mnYAs7oH6OvBTvh0zxwpKAfG1aCyhqYjMQTHGAu3NXHlzoMQqzzR
         jaWAljxN3LM/xr9MwI3XRRJq8zCzMWBEqwBDE9M8Y3YGjO1c0RfJhCF+Wc9tpNSWYYnH
         NG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdDAqhN3rl5RL2XosH5lbLdupO3Vv/WKtZ8EOPEylcE=;
        fh=qs1JTPn5Q5N2SwjLisbgBuLeYGUPrn9+PTmT5SGksYg=;
        b=a3KQZDMG/iQbbrUwpWemZnd3W1s6GlN2//JeZMxCyD6zBxlZKfmGQvpmhhEMhK0BLn
         ds1HmuzpomvKWGqHUxW5SZ73+DrVl6/Y26UGWHgiBtlmKtMfYQydNaRD4+99d06PbOpr
         hEnUU/FBUWXvVlemNO5nKKtQ1kW19NfLIQ2KSEZT4NFBzZpyMv+GLGVDobcslKMzZNn1
         zHeBpftg0/3VAf2s0VuIuZd4vU1jYkBFp2+ny2IftPW0qZIXUh5U3dX4P/aHowE03vWy
         Tle98BaRPlstaNULxL7HSxAT5TMc+LP/WfF4bi0HRfywIU1nM/8CVfnzvRdK5ZZXT2M2
         tYSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1772521244; x=1773126044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdDAqhN3rl5RL2XosH5lbLdupO3Vv/WKtZ8EOPEylcE=;
        b=zVjRTRyjj/S5OPk4VBnQyu/pqKMbRUFtQczm7DBa5jXW3hqLojWbXNz88+ve/qOU8H
         Wq3a4jLbFiZXz09rxAVzXnVVy0iCWR9+k3H4gCb4cYVxbOnP/9RUEzSpKJS1L7ZPm5D2
         YHtmceTrKBVWojws/NPDbWGuXPPnCBFnhc8iaNqXu5W62HrBN48SysYIXE8LbBco06vM
         ZDvlgIwtInR08FwRgZp4GnqEbo6rSxZ2jmqbE6DHZFEN9kk1R/Gw3GFTyFVozNGN1Z4/
         ZzgKt8/vXh4oFKjffiKOOZXQN9eiO+hlj8+p4lh08anYWjJQ63L51P9RvIl/bNLWuNBp
         G8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772521244; x=1773126044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdDAqhN3rl5RL2XosH5lbLdupO3Vv/WKtZ8EOPEylcE=;
        b=Xe5OJEMtotCF/SBMMH0upyCu5FaD6Q684vtvjjNqacPAeHWFb4mgz1HQGh0y/BcyKa
         xN+2SkD4u0HeJonuRtqcs51ybziHlPL9KnHpjKKBSJZ8EHj1krL3xQ6/BddMR+IZrQJb
         ZKS5/8umW/GDYnmQuYfDDBF/FrwQXP9eRWM5C6ibOv6SA5I+J3qw6yBUk69IM7pdNTZ7
         fAgBtTXTTm4b900SCFTJJ8TxecEubR2VLQXmInWm8M81IfrJR6SnCHyG5buy5A6O4b28
         rCNzuW64d+J6Fx9s1WZ4PjZenEpdbOklmOnwm0upAZbGbIDaMLFY00IdFe7DvBtkEdEG
         Rc3g==
X-Forwarded-Encrypted: i=1; AJvYcCWF8dhVzAFZBC8sdspdUyUIXiETnrKDKX3Ac4aoK15mSp4DGvrBxPm19qd0ZL2JaVz94LUr95ukpon5hXld@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NY3BL7syCTu0Oz9CepfO9Qib41SamTbF5dRyodNWEuD2UvwQ
	2VXOEwXfE2c6hPko01yROzFa15vOy2Dc++Urs/aAooOC3Jk7+lx0ZiPdVqc3ZXrU4MddpSzZFOP
	U75DK3J9es7ix+3ARhYjkzJC5kOptEkWkhRLmJXbbNg==
X-Gm-Gg: ATEYQzyiR5NTc4VSiWvzakwMPrjG+3MiRSFSgIgZ7SYU7UNQNRTndB22DBO10V1fIQm
	d0TEQg44mubm7SYk7PhAJ07DpOV6nb3OocBw3iqPC+chZLNiOPqlG9B+I5v2KWaOH674iB/QAFj
	QLIv9gBllZOialPs2zsqCPgAoFh1tdEKmQuUlbe3VfOS3e2eyUK8P+NusGYsGTbdA39iguAT/il
	gsVqO9pgugaZ/9ENvDzqKGXrANBzZPPZpJQoGWHuWx8GxMiFhFcDoO3XUGyWROVzLlXYpP3hxSM
	IV7rOtBy5op0MphxkxgfFoIn4VM+WXA0JMTfv0yqY4/5vZJDVwDu
X-Received: by 2002:a53:d888:0:b0:64a:edf2:e769 with SMTP id
 956f58d0204a3-64cc2080baemr9787968d50.10.1772521243655; Mon, 02 Mar 2026
 23:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302155046.286650-1-r@hev.cc> <aaW-x-HVQpSuPRA1@casper.infradead.org>
 <CAHirt9j-appZ+Mn=8AoG=SW3Lrqi2ajdZDGp8yYWiBWkzBbQ9g@mail.gmail.com> <aaZyg0GT4_f52UEr@casper.infradead.org>
In-Reply-To: <aaZyg0GT4_f52UEr@casper.infradead.org>
From: hev <r@hev.cc>
Date: Tue, 3 Mar 2026 15:00:31 +0800
X-Gm-Features: AaiRm52m82PzF35zggyHMFL96K9Z2hLwy17XjN4QOrmMazJ6hfUaYOxSxnYbtkI
Message-ID: <CAHirt9ikm_n1KHtOSBcUpBM3nNRX90AZhr1K0PaLZuL-8ww97g@mail.gmail.com>
Subject: Re: [RFC PATCH] binfmt_elf: Align eligible read-only PT_LOAD segments
 to PMD_SIZE for THP
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B4B331E9E8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hev-cc.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[hev.cc];
	TAGGED_FROM(0.00)[bounces-79119-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hev-cc.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r@hev.cc,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hev-cc.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:32=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Mar 03, 2026 at 12:31:59PM +0800, hev wrote:
> > On Tue, Mar 3, 2026 at 12:46=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Mon, Mar 02, 2026 at 11:50:46PM +0800, WANG Rui wrote:
> > > > +config ELF_RO_LOAD_THP_ALIGNMENT
> > > > +     bool "Align read-only ELF load segments for THP (EXPERIMENTAL=
)"
> > > > +     depends on READ_ONLY_THP_FOR_FS
> > >
> > > This doesn't deserve a config option.
> >
> > This optimization is not entirely free. Increasing PT_LOAD alignment
> > can waste virtual address space, which is especially significant on
> > 32-bit systems, and it also reduces ASLR entropy by limiting the
> > number of possible load addresses.
> >
> > In addition, coarser alignment may have secondary microarchitectural
> > effects (eg. on indirect branch prediction), depending on the
> > workload. Because this change affects address space layout and
> > security-related properties, providing users with a way to opt out is
> > reasonable, rather than making it completely unconditional. This
> > behavior fits naturally under READ_ONLY_THP_FOR_FS.
>
> This isn't reasonable at all.  You're asking distro maintainers to make
> a decision they have insufficient information to make.  Almost none of
> our users compile their own kernels, and frankly those that do don't have
> enough information to make an informed decision about which way to choose=
.
>
> So if we're going to have a way to opt in/out, it needs to be something
> different.  Maybe a heuristic based on size of text segment?  Maybe an
> ELF flag?  But then, if we're going to modify the binary, why not just
> set p_align and then we don't need this patch at all?

I agree that a compile-time config is not a good fit here, and I=E2=80=99m
fine with dropping it in v2.

Relying on ELF-side changes is problematic. Increasing p_align in the
linker inflates file size due to extra padding, and more importantly
it cannot help existing binaries. The loader is therefore the only
place where this can be done without ABI changes or file size
regressions.

The logic here is deliberately strict rather than heuristic: the
segment must be read-only, at least PMD_SIZE in length, and PMD_SIZE
is capped at 32MB to avoid pathological address space waste. If these
conditions are not met, the layout is unchanged.

I don=E2=80=99t see a reliable way to make a smarter decision at load time
without workload knowledge. With READ_ONLY_THP_FOR_FS already limiting
the scope and the THP policy applied at runtime, this keeps the
behavior constrained.

Thanks,
Rui

