Return-Path: <linux-fsdevel+bounces-78454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AL0EAgUoGlAfgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:36:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0541A382F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57E0A31C4126
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB853A1A27;
	Thu, 26 Feb 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQaOPllR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC73A0B19
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098095; cv=none; b=FvIGVIkZIfapXPMHWMgNOtuSz0Du+ePjtrbqg1d9X2HppTrZpITkHGk1bQyCoMnOOphcUFRrbWPOHscp3Miq6DAImSaWLxntsrRbe7RQPKJyI8QB2jSV1J9o9+S638KQv6pZUwi8BiI4HUwvGDObBjqH13KGbOTI/WfsVo6LstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098095; c=relaxed/simple;
	bh=t3I7OJajEWZjGFLOws23fZrb3TZPetzPR/0xxzzq/1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRvc61tJdPgzXQhDiI4B4mzD9sA7vY6cUW+TXvdjPkiW+VDKLIqoj/lazJiGdn9Ghv+wfviJi4VxE+89JNQBoJKO/FRC3mBAjavJ0kJy/x7GabM4FYqCJekGyCoHg88tef5+OQmaTL+2owl/FATXWCkIWVZXoH9WOnJxFceixwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQaOPllR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F3C19422
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772098095;
	bh=t3I7OJajEWZjGFLOws23fZrb3TZPetzPR/0xxzzq/1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kQaOPllR7aeBUkxZV/Z18Cg7hQb6J9JnYDXDuMkwJHlH3IYOL+TEs/PeyK1opIaX9
	 ihT4hZ0uVAiRRuhmcz4NwCWm9p+9fBWV2KZkoxBfX5iiVzBWTLTh20YkDaDqE7IPID
	 4Y7QquGmtLs2HfzOgNd4VaecvFy/0OSpDgHxoqVIBkzOApGpS4C64wFcUuNOsYRw86
	 lINhL5hEUCssmnUXxX45BpqU/SoMzodTvtw0r5pHVXozEAT48+yqcA2nmLnM+klldz
	 47xWLDa29nEiNgagpHc3O8Lk1NB2lr9u61i+VjZiKlgI2Qw4oMGGzJAVsQYj49mxod
	 Q+PPmOXcPTw0w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9347d8dd90so97424766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:28:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvHgh94nmwm74On3VAQm3Xl6Sk+nPBTzHZ0ROkLG6+2qoaPILIlmneW8COMGHNyYmUfjm2tQIOnEpP+1qR@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmIs32gyGR5dAn6kSo2hqThtW6rZ8FnwRN6cJVn8JbPhZ+Fqm
	NOTByeeLGmv0FoZsNnu59uOka5rUeQxvJz+/J/XDeELHEiV2sMd4nTJGqXVxkPV6CjCKdqUahUI
	dQYbsN5oCGrsVXxK4KKdyfAUS2uEnmOQ=
X-Received: by 2002:a17:907:94d2:b0:b88:48ba:cdd with SMTP id
 a640c23a62f3a-b9351798ee5mr213378666b.43.1772098093709; Thu, 26 Feb 2026
 01:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226014528.3499348-1-nichen@iscas.ac.cn>
In-Reply-To: <20260226014528.3499348-1-nichen@iscas.ac.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 26 Feb 2026 18:28:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd96=RrWr9y8XEpoCpVHD-S9t5Vw_mJUbA+vV3udqsO-YQ@mail.gmail.com>
X-Gm-Features: AaiRm52__1ZTvOq64nK-hOOTQT5pBAV-tkiAzptI5uglCdazA80AHS_D33LtVKQ
Message-ID: <CAKYAXd96=RrWr9y8XEpoCpVHD-S9t5Vw_mJUbA+vV3udqsO-YQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78454-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,iscas.ac.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF0541A382F
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:47=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Applied it to #ntfs-next.
Thanks!

