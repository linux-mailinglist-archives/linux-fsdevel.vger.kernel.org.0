Return-Path: <linux-fsdevel+bounces-76523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P64E6VnhWknBQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:01:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDEBF9E26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8EC3011F11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E23358C4;
	Fri,  6 Feb 2026 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b="z56W7mXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7818871F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770350482; cv=pass; b=UYAF7p8bUR5RcLqgBUvUI/bHGRTXelcO/ICmJhy+skfwAc8jNjHVlSgN43JlAiAKJh+eXsZc+UiAUIbXL8TeiO21KCCFdkaGVdYDeYlSS10Knq2C5XikN/Tmt47xLz1U4brgfIe8ZzEhpfy9zmsAexYA8OXYfutHxjGmNC60l9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770350482; c=relaxed/simple;
	bh=MJ601fAsDIsKvp0R5YEF5N0VDMJm2LTPx6s6C0mxRJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcsyrS95eUY0SAJvNq70hI1G+5YinDnt6+qG/I7gmD/TFmzHgb7+epn7fCQOP+oUnJbKvBcIIY2W1RSHnahnVlrB735KWNezNJrT313g6A1IsjAq9Rmmz+por2u26H99jePwBTXWKGNBQG1JyUlaiNn5/GaUzjKjh9KYempKIOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b=z56W7mXn; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b885e8c6727so359343666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 20:01:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770350480; cv=none;
        d=google.com; s=arc-20240605;
        b=HIcfHRRgIEJmcaVPD4lH/P5gLe05rYO/BXC7CTtmX/Xb7NB6synbbJ4vc8h5cVskbm
         q3RG3MlKJo+vbW2YGkcM1CDPoXgqw+x/uxEuN5jrqj8vU1NtsZGCA9IO+SerXJEOPvJa
         eze3GDlRrtvIr8GfwJnPrsmPvdhDweJAAHF3A5MYsShznqhwwLDJfQZ3GtOIF+jpt63N
         SrZrjiruLTSu7L+23r0Gm/JLFFcxEfLvOOWAv0TjvPVAk18HlabI2GDNg+cyKHXk/Pj5
         66rZbTcT77csAZ9kif8yJteNgGkaaHKIFwurxUGJo1IRdZM4TZkx726yBDtVrurUpi6A
         KaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJ601fAsDIsKvp0R5YEF5N0VDMJm2LTPx6s6C0mxRJ4=;
        fh=qkI6JdPRqFPYw/T/TE8rfDDSlDJpUef4dkYBAaRZpW8=;
        b=S28rpH2kObuPy+76o74LoJRfkEJ/D8aZ6zhHdxWSG0SrWqoEUq1tHUnpm7K8JIfS7D
         HDaFTUugHFNkE8MwMm6CmrINBDtlT9P2IisROPI6t0pnWXTW8RK2cC/dn8xqixw9Gqm0
         hBEZYuMLTk2/cQIefRhxd3/ce8MU2niOSqvzv4ppSVg0AoFdMhMi0baEtdQ9fNiL6vEz
         MFhX8JnJlJfuIJ79DWzwPhgQFr+rb38E1CUos20hdsw/Xy4akdtvWmA1J8q+t5VMHgNK
         7CpIVwTAS2QkfzclsP5QpE8JWNjcjHd9pwqEWfqcwZrwNCXstMMGJilmzro+O4b0nhre
         /EpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20230601.gappssmtp.com; s=20230601; t=1770350480; x=1770955280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ601fAsDIsKvp0R5YEF5N0VDMJm2LTPx6s6C0mxRJ4=;
        b=z56W7mXnPQ/EI/CX2r32x/t2G/QoQm+p3O/92iJd9039MuZtzqkTtGRO1T8HB5B+O+
         7BrqHHTo7PxpJ5WviU5Y1ci8U/qA8sjeA3n8Ao9bPl0tOZuH0yk5FarN/UH77G4FwKiz
         E0XciY69SmGau+GmnYdHQE3MS7G1Fn2CXI9YLZ0r20I0T6t4Wp3EDDLEMeJ/4POsep5H
         pEHiogm5ncEhUP2xilLLYTd7cHMavjrZmAFLAWJc62+/42l0o9ev8BM5CKvGGajsq8MU
         Z+59ExLWwQvPB8zaBR+vIqY8ZatH3k32JoDVmKIhKkNQxO+D9u/XuddsSRnrNToR0TgH
         rnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770350480; x=1770955280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJ601fAsDIsKvp0R5YEF5N0VDMJm2LTPx6s6C0mxRJ4=;
        b=s1irE/50NXtyuKMlpIOLbGkfnxRy0wyi4f3qp8Q9HeSS+UIeRdHUG5OGHtPyrer2xh
         7G0AsD4XxUqHpd9KvQJvem/v0pzdL+7S80dDk5k0WRmL2DVWZ++MIU4RtSycmqouKXl2
         HspmSceFeHRI4uqIF6svJXLCsFDFEuOibkI+n5rdP7V0QXV2/MjdQ6kdXSKUzCNxrZfN
         uBYeKuIDLzXwrjBq5nj2RCpzIUvZMohH9D3s4LkSsG1O18nY/yHzhp7NHhxLFejpg8Gj
         VM6cOLux3YmEmlx4kBGBjYhD8e2OHRW4NfA9yMRkOVzomMRvboJi7HR2QVk3qSrDCJym
         v6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXwBIsCfYisC1mCH/yCnuadsS9S3Wiuhc7hxARtHJgxHyKCqIDfHSfyljYbJWhaERrnNq4M+1J704ygfeFU@vger.kernel.org
X-Gm-Message-State: AOJu0YwMe0KSxfLIyY+ArmPEcIc9S/X2Tb9YN2pm0qByJORKnHyhxRjG
	nknyhzgEZWxB/rQibGwFdnpm58KDddPUfjc5hJvJrV5HeZPUOQ2ENW/LiAIG4MiwwQ1sg2N21pz
	TpCKBNrJrXINznla+O5YBm+WHvPWTgQk1TSNug/hAdg==
X-Gm-Gg: AZuq6aKbF1CSXB0M7682tuphc+tnqLKlTRCLmUdZEc13IoEka3TFwo8tPnzQRuP8D0g
	k3pO8BmuFuxypYmHW29u9dpXV9wPAa/gfgM7zNYpYGJkQ16E1n/oQD+DIcw5XCvLZE1aFLrMmh5
	aySFUzKYJnu44U9/lz+/AKJiXwCbt5TTRofS1WQzD1EKYFuiBNDcfWED2v9lSjIlV6pDkeGAe8l
	1+Csfj7D8QCvrcWVWZxOBBqJGM3fvFIBNgdrqMnfIeocStQxD3t/AQr+IG/Dnu/mHWjAsJYM3JI
	b5+xqGOgpIy5GuscmowWvRF53nFSDDDEE3Iou7TRLflTxOC9amb0XSW4tYOd0z4+pdGgmYQ=
X-Received: by 2002:a17:907:60cd:b0:b87:6839:6175 with SMTP id
 a640c23a62f3a-b8eba0e0fcamr374449066b.10.1770350479895; Thu, 05 Feb 2026
 20:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201170953.19800-1-xiyou.wangcong@gmail.com> <aYBENSqGtp0XUZBw@infradead.org>
In-Reply-To: <aYBENSqGtp0XUZBw@infradead.org>
From: Cong Wang <cwang@multikernel.io>
Date: Thu, 5 Feb 2026 20:01:08 -0800
X-Gm-Features: AZwV_Qg9VY77zJfA1bdquBWf1Lvd3VC-n4ZiDOq2gALrLvN6wt6DotXnQE0RnfY
Message-ID: <CAGHCLaRmMb9ge=KZucpXRkEbRS-VHxFQM0XyU26Y5Z6bVabLsw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: add SB_I_NOEXEC flag to dmabuf pseudo-filesystem
To: Christoph Hellwig <hch@infradead.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76523-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,linaro.org,amd.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,multikernel-io.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 9EDEBF9E26
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 10:29=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sun, Feb 01, 2026 at 09:09:52AM -0800, Cong Wang wrote:
> > From: Cong Wang <cwang@multikernel.io>
> >
> > The dmabuf filesystem uses alloc_anon_inode() to create anonymous inode=
s
> > but does not set the SB_I_NOEXEC flag on its superblock. This triggers =
a
> > VFS warning in path_noexec() when userspace mmaps a dma-buf:
>
> As last time, I think it would be much preferable to set SB_I_NOEXEC and
> SB_I_NODEV by default in init_pseudo and just clear it if needed.
>
> I can't think of anything would need to clear them from a quick look.
>

I agree that setting SB_I_NOEXEC and SB_I_NODEV by default in
init_pseudo is a better approach.

I will send a v2 tomorrow.

Thanks,
Cong

