Return-Path: <linux-fsdevel+bounces-78032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIslIx/dnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CA17EC24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4F11301BDD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F66837D128;
	Mon, 23 Feb 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrAAB+3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70F37D126
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887898; cv=pass; b=Q6fpS1jJckXCSbeRSs8QGrfGxB/AiZH7DD/XpHTU+LLNdHGkY5y8eTaKqKz8yWVOF4Rx86lA+PjOGRoZwcbMxHERp9rdY/NeHl3ddZapU6FDzrxg+jwg6fY8ooOg83ybzDkOvcMb1mgVFw7NgHB4BTMc/Msxn5O+ZG8Bu3P0PQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887898; c=relaxed/simple;
	bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+lv2esN5vGk1HfruGuzrnkiqPMHCTbjkdZ6XScqHl99AYm6GhDPs6HEu3VanQNdPL1zAtV+6AOXnIV4UliFKvOgfs7n+KV9kiXooutdSa4OamLJqio0ODyqiREJKTtE0vVh8NTKEYGI33Y+gZVJ2yA0v0DCCAZOsd01bfItGcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrAAB+3k; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794911acb04so49032247b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771887896; cv=none;
        d=google.com; s=arc-20240605;
        b=MeYD6KnANaE88pYY4t61pK/9rVozTPFOB2c6yHOLIivqQV/97q4xMpZ07MZQu1pSfb
         wAHUOTdr/ZPEoXOjMKJvSnraLH5nthyoVyf/uGl5ecv83zLyvQj2Vr4qzZEk/zvJEgUU
         WedZx5J7SqhKywJSDT6/nnX4cS797n3tMkADdf5bxd6KaVLvvxfHCoPzFgz81hNHEQwV
         59qqrgwIywPv+YL4AZqiUZpqWj+pSnR7cvewvmI6SimmofkId5wcxj3sGjBvTGaQVgNw
         rYlI8tChcHXwdO3Ruxkrv7oWlpv1+yaHQXxxmGrNVljiGlzNOoeyTPoqXeQROFOa2oRA
         WoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
        fh=Mgur7GzePWUxcjdJmP9xCL4OBQshI7sL+3Y8EPJc8VM=;
        b=d9kModosYAb7QFS0WodRxvBjGYqENYkNE8fpP3w3durXxhKw589ST2tTp00t3u8InT
         d1MsyhLZGTXJtXmBlFKAcIyTe7sQPnc00lSBg5Yf1f7s/o9fHsh6oqWy1VE6XF2e1bfL
         DOeAZXLkGGtw5iuKlc8Mv1XSUUNb25WSDSurHzTAbZBZ3GD+6Ji9bLQ/wHZyJEfI1Cfs
         aUBN2sFaKX60y/9mRPxhusCnWTpmkmjpikXntFcxsbCfdzGOLvZ1b7nSmX7wcPlTxT12
         +g27Z03st1Z645lqr7hSgFyyT21Bl3vquZ+qqp20PPWdvE37FDsiIV+l47EIQ8G81K5p
         Prgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771887896; x=1772492696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
        b=DrAAB+3krUOPSUGm37lQQJkEE9HoTlGF/HbNs4GdWUTZ4X3lXfQHENhFxfKUwTqVJL
         4qeJbAIIy9RrdZgTqqPlnRE5+VUa+kwk97S8W3i5mryiRtrHkoyr1WORYyrUv5za3fcP
         HSYlTgpFgrOrezAPiqjcfLlRqrwFOtQs82Dd/gT/gqDPupCekCkXs6vq6jiYIZ+SUf17
         4PmtxsVvStJGhcGZh/PwkwWNH1erbD2wZRLF86q/Q3A7tOaieEfIlrVloBDA2jKBbQ+4
         w0Fvmnd1XbjXStYEF4cDYW6VHqq55y1hnVpIYnQk8DXjaVET632P7JBM1bwSEbb9YNC8
         TxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887896; x=1772492696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iVARBZLENhP06ggeySaiFzVdgp8bTAAtxPPZZI/s4k=;
        b=MN8qDI8GvWEf25bFMDh99wh8HlFWN3QFL2YI6YCSxfDv2DKa3nSSbx5LTANo3HKwah
         8FXA2pIAuRxL5uebQrjT19KMNeWsK0CXXZGD30005P2nQcd03XFpbjgOHYy1MU3EV70P
         ZyApo1VBJQIcgKEA661O0wFrXFRv+g9rLX+RcPTgdWk2XNqLFaQMSyD/zH5e2XrDzVjD
         6h1vd45fe74sdyxyJtKiWAHiO6fdTk7p/WLPvlwitLP3dF2wuhMSV01X4deB3vU/3OL2
         yyu/9JjRzSnhi5zToh/ydemSwnBvxQLY/4RR0agXxMYHtvov1c19Iu6WcWuH4TL2vdsp
         ZzKg==
X-Forwarded-Encrypted: i=1; AJvYcCVQwziWLoybdKxt3I9EGJFFrLwUThoP1kC3w6P3lDaKH8szudi6RbAwVwG78QE22DcwmN8eR3BdgMcMlTTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PRNFeD6Mf3nDp6leo+ZV5R/pLC3dGXS9fv0Nw4lKEVAzfWhO
	Rp6pPWzaKm+Eti1Ox9p7F0f/U6GNsVQx8+IX47Sxo/hN3+DO0kNgs1ds49UKT3p16wRT+yF7ZHN
	h178z6OE9jkDr6hy7GgvmMhOl8P+mJrQ=
X-Gm-Gg: ATEYQzzUiWEFJOz1yxE82WLuJT6mBO5vGV+UaoxoDcNBoMzKORU/LzO5q/hRDJBSZqG
	V3ifvvzLjIC7826tNFVuGMtYcnH5/nuAqRXn9f8D+o5jPThv7Bl7niZWS1Oe+0l4HbSWwVmVCjo
	dsTQ8SCp6vvOaEkgBRcqgIq2UmIMUAOsf48/kayG1R+z5Yuv7SBTjzydhlLkx+ddLrSpdPG2IGY
	BHKGMaauSpTkTLjQmDpMCezpE/K7aZqXg/BTQvbz0t9ax9UQY0Kg3zvufx+VUHVNh2aHOmsfeRQ
	YJ3wL/k=
X-Received: by 2002:a05:690c:f09:b0:798:5333:ce36 with SMTP id
 00721157ae682-7985333d4f3mr19166357b3.7.1771887895866; Mon, 23 Feb 2026
 15:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-2-safinaskar@gmail.com> <20260220105913.4b62e124.ddiss@suse.de>
 <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
In-Reply-To: <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 24 Feb 2026 02:04:19 +0300
X-Gm-Features: AaiRm51ShYWisRZxqEP2jfYkn9npSVqKeCstRJL8gtXtjrs-RidKNfYk8lXIBQs
Message-ID: <CAPnZJGDDonspVK1WxDac2omkLJVX=_1Tybn4ne+sf3KyaAuofA@mail.gmail.com>
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: Rob Landley <rob@landley.net>
Cc: David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78032-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[landley.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6B8CA17EC24
X-Rspamd-Action: no action

Rob, I THINK I KNOW HOW TO SOLVE YOUR PROBLEM! (See below.)

On Mon, Feb 23, 2026 at 4:27=E2=80=AFAM Rob Landley <rob@landley.net> wrote=
:
>
> On 2/19/26 17:59, David Disseldorp wrote:
> >> This problem can be solved by using gen_init_cpio.

I said this, not David.

> It used to work, then they broke it. (See below.)

So you have a directory with rootfs, and you want to add /dev/console
to it? Do I understand your problem correctly?

This is how you can solve it.

Option 1 (recommended).

Let's assume you have your rootfs in a directory /tmp/rootfs . Then
create /tmp/cplist with:

dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1

And add this to your config:

CONFIG_INITRAMFS_SOURCE=3D"/tmp/rootfs /tmp/cplist"

This will create builtin initramfs with contents of /tmp/rootfs AND
nodes from /tmp/cplist
(i. e. /dev/console).

This will work, I just checked it.
No need to build the kernel twice.
Does this solve your problem?

Option 2.
Alternatively (assuming you already built gen_init_cpio) you can
create cpio with /dev/console using gen_init_cpio and then
concatenate it with cpio archive with your rootfs.

Unfortunately, this may require building the kernel twice, as I
explained in my previous letter in this thread. But this option
is still doable.

Option 3.
Yet another way: run

usr/gen_initramfs.sh /tmp/rootfs /tmp/cplist > some-output.cpio

(again, here /tmp/rootfs is a directory with your rootfs and
/tmp/cplist is a list of nodes.)

Unfortunately, this requires gen_init_cpio to be present, so, again,
similarly to option 2, this may require building the kernel twice.
But, again, this is doable.

In fact, gen_initramfs.sh accepts same options as CONFIG_INITRAMFS_SOURCE,
this is explained in
https://elixir.bootlin.com/linux/v6.19/source/Documentation/driver-api/earl=
y-userspace/early_userspace_support.rst#L70
.

Conclusion.
As I said, option 1 is the best in my opinion. It does not require
building the kernel twice,
and, as well as I understand, fully solves your problem.

If I miss something, please, tell me this.

I really want to help you, Rob.
I sent this patch, because I want to help you.

--=20
Askar Safin

