Return-Path: <linux-fsdevel+bounces-76204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLLwLR4Ggmn3OAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:28:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CADA96B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8069A3154E74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC93A901B;
	Tue,  3 Feb 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZKw0Qym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AD3A9008
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128552; cv=none; b=Udi655RwY03rImUaoseKXR2QuLqRgNOi5iIIlkznGhKEyJHya8bL9n8eeA5W4jbMMW2BRnZRbJTx0ZZp3i9DPn+5lTjbLc7MwBDHxQYLrYyeRx9M4e9F/Atxhdv/BBH3pCUD//787ipoCqKGqyx5p0JstCdJ9KABGgYGmsm2MKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128552; c=relaxed/simple;
	bh=600Cb/ex2AXl+Dj4aeROeIImV3MkOrj5sa1uMbrlCc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anKqIaeCnWN4qLgQY91497QSBdW0wVbyEIxkt9LUwf/uIvr/WO/0Dni3GFdDNwiY9POxBVzrw8PmB17TPSr2yBekGLFl+r59HUORDsmcCFZtJuJo9cx6cwOeH4tImXXcB4NZuT0RyORf/3KJp/DbaY4pzjQ0MUh+MOpWN8WuIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZKw0Qym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2850CC2BC86
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128552;
	bh=600Cb/ex2AXl+Dj4aeROeIImV3MkOrj5sa1uMbrlCc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZKw0QymJdULLgrMOGZwCRHkefZPNO7ltx+PQYyIB7omIskLYv9xnHLSzgrIb/+kt
	 CmXG1RpNE5fDoHDJFBsVhnKZdjfXEkxEBu2G29JPDvDk4cNCLDEzS9Y6/NvE1TA4U8
	 0AMWrI7eJlKdypfkf0YcFy+O4lxrCmQn8dmduWJ5xtsCgwMrqmgkD8v1lVna1fzQRU
	 T/b9xuB1k2y2zZS6hlHXVjh/FmymAonwWEtG0GCHzNFWJ4JqJxQKOMfPFqP/SKaRG4
	 QOQYO21hy+in/UIBUTjk+2YXypXXUx4AZkPvjh6ZUaRs4t5QYBmHpM+0vcvzR5vjzP
	 e89+OhZ6TQZ6g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso7789945a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 06:22:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoGESujgZySmN2m386xpt6468Gxn4hyRwS6rrXXMGWSXV8EvnYqvBf55aNOBW1to9/HWI7jadkzmwEYe/1@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoTsh7zR5nfhnhGJtf5NNi31gQn8RYTxgTaX8naQKvnkUiT5t
	ZPxxF8HY9POeWwRFXfPWINKui/GT09pgE9oImZfIwNR4arWfoJqny+ur554F3Z8zQ1SVKNCpkos
	+4+esMHaYksrUVtZIp2VMI14rydXcOBI=
X-Received: by 2002:a17:907:96a8:b0:b8a:8537:e399 with SMTP id
 a640c23a62f3a-b8dff7a3018mr1142288666b.48.1770128550715; Tue, 03 Feb 2026
 06:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-12-linkinjeon@kernel.org>
 <20260203063439.GA18053@lst.de>
In-Reply-To: <20260203063439.GA18053@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 23:22:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Kpyi_2CVWZoKGTMiMLPwZ7iye-H+A50S6N=bzYyj64Q@mail.gmail.com>
X-Gm-Features: AZwV_QjvqTqmT_dra60qDf9qsRS4K7bp32VmhMhsBbOz48IZSKmmwyP298LDt5U
Message-ID: <CAKYAXd-Kpyi_2CVWZoKGTMiMLPwZ7iye-H+A50S6N=bzYyj64Q@mail.gmail.com>
Subject: Re: [PATCH v6 11/16] ntfs: update runlist handling and cluster allocator
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76204-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0E4CADA96B
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Suggested commit message:
>
> Updates runlist handling and cluster allocation to support
> contiguous allocations and filesystem trimming.
>
> Improve the runlist API to handle allocation failures and introduces
> discard support.
Okay, I will use it.
>
> > +             if (is_dealloc =3D=3D true)
> > +                     ntfs_release_dirty_clusters(vol, rl->length);
> >               up_write(&vol->lcnbmp_lock);
> > +             memalloc_nofs_restore(memalloc_flags);
> >               ntfs_debug("Done.");
> > +             return rl =3D=3D NULL ? ERR_PTR(-EIO) : rl;
>
> In general you want the memalloc_nofs_restore to be after goto
> labels in a single place, as otherwise debugging is really hard.
> In doubt a separate wrapper doing it my be even better.
Okay, I will change it as you pointed out.
Thanks for your review!
>
>

