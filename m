Return-Path: <linux-fsdevel+bounces-76198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOBkDvYAgmmYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:06:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B566DA55D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97D72306F479
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26383A63E3;
	Tue,  3 Feb 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqB8mWFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F63A1E60
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127597; cv=none; b=uZ+zJLfKh6gI/Ge2FMVH+dO+9FpgFX6TYKZ8agVq8EcFvrR1L+BHzb1RMEBpt3EyYx/hQRDpYEADKwdJ0gcc73KoqJqA//Ls1AL9fwyeYZ3tyfAmW032V4w/seF+ve4v3YNb8VppxhNOsnS/5NyqkfZWjCwg+CSTMsS5Yxx7fh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127597; c=relaxed/simple;
	bh=Vlfso9YsL2As+Aclw9PU5YbD6hY/gGwU6Gf2E5KlTNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqgAWAC96ua1qFQ0S6uT7VVvpihb+YY8SOxzy4MOdw40+1Oc6VOY6KQYAohHdQt/9hW0CnlhCImPQXf4B702M3mPQrZgzpGzbJ1yt4/lAmBnz5/YEtd+9U2pYWsXC8zxKCxHYiD/R/YHJE172fxIXdG9A5jznYJgpHfLekURl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqB8mWFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47324C2BCB9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770127597;
	bh=Vlfso9YsL2As+Aclw9PU5YbD6hY/gGwU6Gf2E5KlTNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eqB8mWFFXI8dkurac8N+358EcH+txX5rfeLh2w4fNEyG6RAkgDW0MA1QCLFWaYvCP
	 CpHgAWhbmkyWEXa7wq3Fb1DE7H+JdUfaBR4RLlatv6YM8PWP7VCRIcYKq2MEIeH+Gz
	 t9qRucUDskajO+3sZWkDwT1oXNEg9mTqdf7wKYfEK4DHTBNPyanAGQ0bYcrx6GiSNl
	 HlqlAh/Y/6v5Xs8yFTNDTpzMnUH3dnA32CuIzLV5NtIRLlo7K6EW2bwySHXjJpoIkM
	 ohIy84aIpdXOfS004+6wlkDAshJWtG+KQ793gGMz9lgzDNRwiF9lI9INe/XHggq+yd
	 tWbE64nkaoFuQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8849dc12f6so816269066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 06:06:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3qT3lq2G+SS2RPSoHEWr1qSYdAQhsMg+k/dRnwJuSttiKkOLkTdw/WyDBddT6Zh2LkaFgkdlObs0/OuzG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7I7pI34kyLhY/QAefn3YbMygp2dRIxRwhCtVkbQt7a6aYfvqR
	octesRhqDHB63JmHg/voP1RUO1/e/axsHrIG0N9an3vKgqpiWzkufczODL9ig0yity5YHKnOpPf
	AHrIZ0UVlURyd39WKVjzsuvynDI/QDbg=
X-Received: by 2002:a17:907:3e06:b0:b87:206a:a241 with SMTP id
 a640c23a62f3a-b8dff515552mr935612666b.11.1770127595749; Tue, 03 Feb 2026
 06:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-11-linkinjeon@kernel.org>
 <20260203062206.GG16426@lst.de>
In-Reply-To: <20260203062206.GG16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 23:06:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8U6es9nyVc_cP0ncASO9jDeKQ68R_7udUU-Jy9ceV+Xw@mail.gmail.com>
X-Gm-Features: AZwV_QioP4t4WZp629Ui8TRp9k6Nz04cCahmKpzKJBaEsCIBQ11jwnX3TCr8lEE
Message-ID: <CAKYAXd8U6es9nyVc_cP0ncASO9jDeKQ68R_7udUU-Jy9ceV+Xw@mail.gmail.com>
Subject: Re: [PATCH v6 10/16] ntfs: update attrib operations
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76198-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9B566DA55D
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:22=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Suggested commit message:
>
> Overhaul the attribute operations to support write access, including
> full attribute list management for handling multiple MFT records, and
> compressed writes.
Okay, I will use it in the next patch-set.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!

