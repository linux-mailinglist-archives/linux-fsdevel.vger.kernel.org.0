Return-Path: <linux-fsdevel+bounces-75524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IwSHRzFd2nckgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:48:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61C78CBDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E753017784
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113FC28750A;
	Mon, 26 Jan 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b="WZ8vP6Hw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE8280A3B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456914; cv=pass; b=XuMx6RZE3dUhqEv/MzSi8rDp13fLU+vbOhKf0F20j9VkQfb2DUnpFqedvR9jsD27x8DWm6IEwcimJ+ABaAIj1lWb1oL07bOyTMmfDigQCMHse5KFPQ9n33zol6fe7tfRoC9WTtRHnDXpkltCluPPfHh82WDKrotpTsJQfM8vR5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456914; c=relaxed/simple;
	bh=M0vL2ZzFElYN6fOE5Yf8DQGBpKROrbD26vPQIPjtk+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX4JehIs725MhgSX7RgbtHLjJMIS4ZAziy8X32Vj2SXGbeKRpSJfPJy9MI6DdBv8Ut8zLlMoOQUgpwbm+JLIXytknMH1BPj8tquLp6X23vowPq+quL0PPSFRMeJs4xsT9PFCuugyZmOp3YKcabPFvySL8H6YzhwjWfcNfhuC3x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b=WZ8vP6Hw; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-658381b28e8so6568524a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 11:48:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769456911; cv=none;
        d=google.com; s=arc-20240605;
        b=OSYARcf02DnG0KZkk+WYYIG9ep3hrR2YHnXLHefggIR2F+AgLLoqevHM8NQX/yto94
         /thbiCPfxfm9vdKfBkIPCcjR/l+cnUWcmA/EYFGzXQZl1J7Tv4PNNE4QBsviBGaw+hcs
         m5cjr1YptwHOIhW7UUP48Jl/yyIxU29d7hth/pIpfJxh2v2yHrbz/zgmJ5RtWOBeWGgS
         hCR2JwvrwI+FWDFdaneP51EFFE7FhyaGclBCsQojBm7OJUXD2MW+WpnXb/sKnwAL6FF1
         s3Fv8EPc218idz8y00wSd0K5vVw98CGS0Ie2SakBxcFObH8e9TN0NDQzgVi2/VYDsbKh
         oP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFgoCBvKFkdr7eVG3rBCsN0lSRo0YjSiOLD4Sxa1neo=;
        fh=+HllhzJJVB4Iaubj99QmGLuu61o8Om0NuFSaFfo5p2s=;
        b=BH4Ti4DPbzds2YrBuXXDkEg1tGF+ZUrBGXtf+DHQN1KuioMAUkC4fGPQrS5vgXGjdj
         cQOpNjvNKMDZN+5se2BKzSz1wQ4MWdzmN2gOAjAJHt6llEifozMXsUx1F6oywgYzAjCs
         TXI7++LGtNr6dWlRihG1BYXEqmAt1k/469AR2ZEs3g6KHe3A1q6T8Q7VT41m4C/XN3uq
         oxUIGXKGuX1AbiWre0yljpkWejWerRSMCfMYvc9nH1qQVkn0BZnWIcnKg459ytfd6uRN
         LFtwEgEJas1R2QtdKOJ2cvhwxcd/xolIXyGOXWQAlitroVRpBbNGuBlHjkWn3QVBwll9
         0qUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20230601.gappssmtp.com; s=20230601; t=1769456911; x=1770061711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFgoCBvKFkdr7eVG3rBCsN0lSRo0YjSiOLD4Sxa1neo=;
        b=WZ8vP6HwFA78dsRip84d8XOYfokW1jAXsVTG+0Xhn8eQiEDU0cf8IZRcjpfWqZWYzb
         PS2PWAWm8ydyG8mEbnKt2y1fiw/O5VIKN+URdXzH7RPAW77e9w8PNtcf+dSGA9wUq4IE
         gcAeJ+D9uHiXC3W+28rB7ur35o6O727DW13MCBF6ZDMJWpyVjBetG+ZoD6ME9KHNqLU+
         eJiPLnsoIi8HFgqKAS2lqN795+dXfbDAVigP0/tF96t74zIlM+tqjWZwjqIGSefe57sy
         MRb1brGPJTKbnWZo8GcM4hDzY018HCWfxFQ5wYfCt8RZWJwz1SmK9JWmgiT3IqtytxhF
         XMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456911; x=1770061711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFgoCBvKFkdr7eVG3rBCsN0lSRo0YjSiOLD4Sxa1neo=;
        b=DuJG3IojVq0uhR3jGAP99NnirXIaf9lQDFGBuBh45Mxzl8k1Lh1BdHSCqqE7/8IDu9
         1rO7evDJ5rLUZOkRJkuTlPi31LS9L947+EDFmXMDsBiFHaHc3pP0qMjVyWqpTFERQB3A
         2kBBwdN6HmE3KU1B0UaAxbHAMnL6s60rVT+b5LYQU73feH0J9jmAx+wE9/VPPatu1tvg
         Z3XdBLDuUCtQiaPkre7FvotZQd8odt72LjCoQisRb8nN70mEY79vfLEpGINrItfjFavl
         PI1zjYgoaJm7A3T+8FwmVDfRAPpYD1T8dMQID+iOtdKK7JipXeGNIEqN/r5YZeZbqqBO
         DLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV45GN53h6MOGrpRNcDomfxkUJxPhijgeGmH1808LWIqy4ZPilFborH6H0+cIceGOj6NWlajJHCqHanJJ10@vger.kernel.org
X-Gm-Message-State: AOJu0YyjeJkjurdOMiYRKfPCQ8cqk5k7djFj2MNMXY+jjjohy8Uzl/Qr
	EotRLBSkccawuFQuPZk/lZHlRYa4JBl0xaEOXZz84Sqz5be3jzTnAybCIozMDSTjrIhpG0+iUva
	FbYTUYo3uGPgIMzWYNqJRlL6PYbPux7kiFxEprEJyMw==
X-Gm-Gg: AZuq6aK67ZSdp1xjrmhG8z9P3SHWyTNM3rbe1AYpjWu6/YezOrM7RwuqZHlEpGObDvB
	n+ZrFd9X3OlPfVMiiTveqMlAP5qAp1PhG4tbZz0qiEzXuSqcnV36yzloXxRg/b4xINNIJ91ss7U
	Nn3s41D6tiN1dypWU2exd5las2X7okLXL4Kzr4aIpyZF2fjZwXyCj+v60ZUmT14IBMQy1YMEJTt
	Wzu2icihDmuVZBZcoiAZ3I5GkOtLSF7HSG7cBfc96MdGh8SnCvD4agVz4+jx4BByNHGqHpxy3ch
	omB9swgBApUPCt/jAgNLeT9ATB3WVe9MDYw/iqjjgQtgjAop5okzTd8XX1/S
X-Received: by 2002:a05:6402:380c:b0:655:a20a:a258 with SMTP id
 4fb4d7f45d1cf-6587069c213mr3379894a12.10.1769456911259; Mon, 26 Jan 2026
 11:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
 <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com> <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
 <aXe9nhAsK2lzOoxY@casper.infradead.org>
In-Reply-To: <aXe9nhAsK2lzOoxY@casper.infradead.org>
From: Cong Wang <cwang@multikernel.io>
Date: Mon, 26 Jan 2026 11:48:20 -0800
X-Gm-Features: AZwV_QiTFQvgZsMW4jmuzkfZnX6F402IWFg5QjEYp6fKcsiy_1Fuc0600LDz-zM
Message-ID: <CAGHCLaSe8g+BQ5OtRv0_Ft3o-G0gR4oVSOW0DtdsQJdwuJsDCA@mail.gmail.com>
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
To: Matthew Wilcox <willy@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75524-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[multikernel-io.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,vger.kernel.org,gmail.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,multikernel-io.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A61C78CBDA
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:16=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 09:38:23AM -0800, Cong Wang wrote:
> > If you are interested in adding multikernel support to EROFS, here is
> > the codebase you could start with:
> > https://github.com/multikernel/linux. PR is always welcome.
>
> I think the onus is rather the other way around.  Adding a new filesystem
> to Linux has a high bar to clear because it becomes a maintenance burden
> to the rest of us.  Convince us that what you're doing here *can't*
> be done better by modifying erofs.
>
> Before I saw the email from Gao Xiang, I was also going to suggest that
> using erofs would be a better idea than supporting your own filesystem.
> Writing a new filesystem is a lot of fun.  Supporting a new filesystem
> and making it production-quality is a whole lot of pain.  It's much
> better if you can leverage other people's work.  That's why DAX is a
> support layer for filesystems rather than its own filesystem.

Great question.

The core reason is multikernel assumes little to none compatibility.

Specifically for this scenario, struct inode is not compatible. This
could rule out a lot of existing filesystems, except read-only ones.

Now back to EROFS, it is still based on a block device, which
itself can't be shared among different kernels. ramdax is actually
a perfect example here, its label_area can't be shared among
different kernels.

Let's take one step back: even if we really could share a device
with multiple kernels, it still could not share the memory footprint,
with DAX + EROFS, we would still get:
1) Each kernel creates its own DAX mappings
2) And faults pages independently

There is no cross-kernel page sharing accounting.

I hope this makes sense.

Regards,
Cong

