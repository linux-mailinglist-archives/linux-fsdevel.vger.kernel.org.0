Return-Path: <linux-fsdevel+bounces-78455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH4YH8sVoGlifgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:43:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E16CA1A3A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2171D313891D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB83A0EAE;
	Thu, 26 Feb 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxhkADY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DE39900D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098119; cv=none; b=NmzoG+h7PfDOLOV1b58+dn3zL4dISn57IXkPeNYE63TgvFcdJZTg+yewPjEX1UUSkiFazM67dIbJqrmPo4OHdpBq4u4GVotZEdD57sT8k2UWpUGq1MgW600UxDCoq6c8ixew//a4P7+DJYxneH1sl1537ZWe3n5HjEFbT016rUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098119; c=relaxed/simple;
	bh=/sXInjwUuqdcpzIFjMGgcYNyCQN62zCqDYOqqstSKC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsURTFgIB8HPNjzSOhjHMkNxrIetSOhh43xr+G88YnlaLQUSIuXP4UOriIWXjqgSS2AcBWbFF2v3BkFjf7BeLfOzbGCvVXpjYWGvSn5q/rv2/EFgpgPhgzbP6URliJUDNcdm7U1eZLtZzt1Kc6ntSDnKL+CoeIrUzRhjIJoSyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxhkADY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F60BC19424
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772098118;
	bh=/sXInjwUuqdcpzIFjMGgcYNyCQN62zCqDYOqqstSKC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UxhkADY+vDXDyaUih8uDOCrG3NwG7lwZ9D0ZKSqrrVewBnigVy6FA0fLCv7XBF02A
	 P4MGTm84UIW9lcCHmxAaIXXCU3sa3NHOIN8VEk6ZAajWDHr4wB+h4F0ypYLYB1Yyck
	 K0imErbYC/syb18IhuMjSgM8MQL0Jlib03PK0+p14z1W64GYCT02SKkDHZzhloWaXa
	 HM0hXV6RQqz05Nxomp+BLUeEpbBFF3B2zO1AJkeBCVOUagvSGZpHyIucFaOM/iFJtD
	 OvxHupnfLALlzAfdSFnafTFmzYFtYo52Xx1oTIEUwgsU6HfRUBfuiBULNgTFvRsZTd
	 /QboD9CedELPA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b934f8ec6acso75300866b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:28:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXanvv19LM0ichBNzWSiSWvEqwC5JBY+tdLYlVExrn6bfHZUrIYbANyS2NMvvqYmeu82KfUEeZMa8H0KEYu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrrtss00BQ26+nSR5RJoDSNBugmb0qCDmtDanp2Uhg1ktxmwhz
	MSpKXek9jz7XX4rMjY10QauMTwfCN5RGwIPdZVQIY878S4MzEu1Bbj9gUbp5lHXwfeBKDT+H11d
	tu1W9Gzm+1oRknr4Y86vkVmETWeIyCCU=
X-Received: by 2002:a17:906:2083:b0:b93:5f43:ccbc with SMTP id
 a640c23a62f3a-b935f43e2ecmr38885166b.53.1772098117157; Thu, 26 Feb 2026
 01:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225222453.1962678-1-ethantidmore06@gmail.com>
In-Reply-To: <20260225222453.1962678-1-ethantidmore06@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 26 Feb 2026 18:28:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9g+q35gRqZxTnTLTG8E9D8T3etgXaR0Shrci8mnMNXMQ@mail.gmail.com>
X-Gm-Features: AaiRm52Nuc6n7i3EPFL5Ny_UVSex7a8PRkdPQCnjZWGoXatKYN8O_FiSW2rdULo
Message-ID: <CAKYAXd9g+q35gRqZxTnTLTG8E9D8T3etgXaR0Shrci8mnMNXMQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Fix null pointer dereference
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-78455-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E16CA1A3A2B
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 7:25=E2=80=AFAM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:
>
> The variable ctx can be null and once confirmed to be null in its error
> path goes to label err_out. Once there it can be immediately dereferenced
> by the function ntfs_attr_put_search_ctx() which has no null pointer chec=
k.
>
> Detected by Smatch:
> fs/ntfs/ea.c:687 ntfs_new_attr_flags() error:
> we previously assumed 'ctx' could be null (see line 577)
>
> Add null pointer check before running  ntfs_attr_put_search_ctx() in
> error path.
>
> Fixes: fc053f05ca282 ("ntfs: add reparse and ea operations")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Applied it to #ntfs-next.
Thanks!

