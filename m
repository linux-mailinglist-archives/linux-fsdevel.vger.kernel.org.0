Return-Path: <linux-fsdevel+bounces-77830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPSTAyzdmGnYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:16:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4D916B23B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9F513043D1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C42DCF58;
	Fri, 20 Feb 2026 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GxS1yFxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19D2D1916
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625757; cv=pass; b=EifCwVWwCTEEWd4vK7tFCYZ/qfIZGgaLIF3KMSrjWlnHKP6tj4VPLBsWDzbYXVW4AlmZvP64bPGyKyHEWv9YmIwLaD+sKaHKPN/SAqJHHry3VkwxC/CfhNRoDReNkzNTXEQGCf9xJwkPfhg7u0sThZphhaQuS7XY+AjDfmTLkQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625757; c=relaxed/simple;
	bh=j2FvKpOUAlz++LQtlLxLTnYm0ZHmX0REwKDmOP9aiII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOnC7Ixy1jlL0sEsei6ZfXV2uqfmW27/IO2gKirElbF99+AIhtqiEChK1mfWGuqqWIHlF24kD9y9sWucCVWdy9mvTKecTAzjDreBGr2VHjNRzANFDHW31M38lxc1DQ7Kvh4cmm/MMK50hKPbBVuQXORJWDKl8Q3ENDVHEY8kj9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GxS1yFxb; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1761911a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 14:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625755; cv=none;
        d=google.com; s=arc-20240605;
        b=lwhKZ8JRF9HS43bPvI125lU4orBvDNqJTTCAfoWQ5zN9qn/eQgNlOhTF7D9V+Duh66
         fEjT9mdUcfaBu1HFwtV23GY/a+sRRRz9lvlB3fADWjFxoUJ0tJ9tWFLOgHZn93UqL2JO
         n2hwEU3bcmGelfXXBeFJcwlMvkvVS2dKGWRPZ3v8WwUqS3dKWy6JUU1FAG09X1RvW2ZU
         f6RnQwgLxECtzca7iZtxTPFv0SmhtO3CP872macs3B3me/CZyMhmNocGaMJxLAsF3u7n
         DETkUGlNGExORThYSo059AfRVUXc2CsYf/D8aDerC4lWuFE9NDqOZATtVEC0umTbPqTU
         FNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        fh=Vidvmltz7NygxngAEqf2FMGBdHNknJ19E0M3vi+zrkE=;
        b=d2rfbgvWf0deH+cbeQcZ3Gkk+4FWOT3lLrHwoLFkXG05Jkdza63pI2It71PKNAZfeu
         qDKpnQWwhdnldA5QDso1fJKtC5Tosu/HSk3+7U0jfYg41AEDXeJptcWAJaPeKmU94/zf
         csAr50zZXacPKyCehPT8mTEbT81Jkcv/jeL+eSRVR9b1ePf7cTQ6NPkJLS+P2OrAxJOy
         dnMx24aaVm0XcCwlHHuN9EywFs7Cb1WH02tQMmeEYJ/G1+EZ7xp2NSIB206qUh8doF9j
         AWgM1u31WRsDhribLdzbB27e+3tmIlq5vOhV5DD9C7GD0klG3Y5hTfO/oCmP6BKuF/bg
         ywUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771625755; x=1772230555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        b=GxS1yFxbMbDV1VgMssO4X/h5IrLqOjr9uvNzwdF4mwF5cmVoE+ZEOSFkmWaKDlKd5C
         6LnUrQ4jY4ppgMmO+EyapjaqqKVdXdteUuBTZjavR2UYT1QAYke7pzDTOZ4e1s5dkG0R
         fodiCoVW6svow+f021AA5D4XDQTlV5svzccPg1zsd9Qrd9b4DY4zmSYM4ojUGUyjjAiM
         MdzVFb0+YxL0hWDOp3DFLYTHXbKGhoDcrLYA4urKNHkDoQJxE7jdKTZWkjyCD9drPzdr
         BURLdLA9MwHAZmWZb/NN18BTSLdgjIzuCc1UIXZ1UgGYQ4U174+RTzTCbOu28JQtn/gP
         KuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625755; x=1772230555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        b=siqufH2xW5W50CuAvoJUYJTDvqDW7rYRXND/fVP3hrUhHvyvIRhcVxmI/5Gq+qBoq/
         2HXXNRSIXiJzT/dUQPIQdPEYJqDJKixJmxjHg94ljt0L2iNemvv4Xr7JJMydgsK0WNGb
         xM2xpRJ3FyYx6mgwma856kjPUjlg1YPJhYeDXFMNf+YQcFdw15KCRYxzFN1gGhPflpQR
         NkxOTLcGhjkOQyrTA4WZJ8KxC01aes/tB+5GfvSx9NH1NthAxqtZTTJtiLCW7iAqmoCt
         7FseQAK9zdDLZu4UVrFB1d8zy9Z1+23x8UnaZaz/8X8xu8LkNWHgcj4k7rM8dpgWQ6T+
         Ts0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7gL3fwaUtk8x6DYu90g539QSoLSFwXp5by36CXU0pdGefqvzHIxZ3rheGTsFG2BQNk/8Kq9m4RGvKWUDS@vger.kernel.org
X-Gm-Message-State: AOJu0YzXg+lCor1FtTfeCFxZ6j1jBx14UP+Hhavd3lKBQ2MHayyO85G5
	cW/9BjWz5E56nhvjLNSjuS3wmhn5qBlZYyO/W4C3zBklT8w+T9lI7IN9KcY1Mn01T0417Gval5I
	VnGG8TNFwaJ6Un/D55Q93HOdbwaicN+YxXwZf7t1Q
X-Gm-Gg: AZuq6aIAq6w0ey0XZSD9QouDVaqfHoLIE7yS+dxe1RjFf+xcfkn+3avGg/c67HTONbb
	gupXV2ZUck4Cvnl9j18Ilz1wLprngAOLpCE57A5bM0BY3+nMc5vCw478oK6JbGIBPgH75Ns/lUW
	2wkb6tlB5rlHfh16D993+rVO4nSYY5g155JuISTnJJRqWCpkkFzJ1NFZIGhEbKnBJb28DXU05Ql
	wFM5t11PYIRLRc34IYfGIaWZitH1yqkGq4RHD+5HW/aUduUzW1PnkcWFNInMbvVSEBcp4uyPCsy
	mLi0rBI=
X-Received: by 2002:a17:90b:57c7:b0:354:7e46:4a8e with SMTP id
 98e67ed59e1d1-358aeacd536mr799506a91.7.1771625754671; Fri, 20 Feb 2026
 14:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-2-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-2-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:15:43 -0500
X-Gm-Features: AaiRm51NzP7pLbkxnmuQ3vMkAzifx0h6WMPLv9aK6B5e9dNw3jFzqT1KPgQ_5Xk
Message-ID: <CAHC9VhTxkgEnU5nP+7zs9eXOn18PXc7vBCUfY1vNd6qM+N5uAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77830-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email]
X-Rspamd-Queue-Id: 6C4D916B23B
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> Make sure calling capable()/ns_capable() actually leads to access denied
> when false is returned, because these functions emit an audit record
> when a Linux Security Module denies the capability, which makes it
> difficult to avoid allowing/silencing unnecessary permissions in
> security policies (namely with SELinux).
>
> Where the return value just used to set a flag, use the non-auditing
> ns_capable_noaudit() instead.
>
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivi=
leged users")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

