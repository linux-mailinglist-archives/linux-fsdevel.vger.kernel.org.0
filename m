Return-Path: <linux-fsdevel+bounces-78457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN3cAtIVoGlifgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:43:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9301A3A4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC79D314E236
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77E3A0E97;
	Thu, 26 Feb 2026 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXfOX6e/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE5396D1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098192; cv=none; b=u2aegbFjbKTrYP7LorwJgcVF8/CMUStt5h7liJACD6Izq2eeCnsVaKk2/3suw2jyqifMs4tKV+wnZ+jPycqN3bz/3vXJCqDLC7G/ehLcH0FmhLlG3+5iAvycPNuGVWUuLj7by+Dj4Y+mVBku8hST+G2lqyfjV/SkIyVLjaFspR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098192; c=relaxed/simple;
	bh=AEnSsx/9D6b3psUj9gu5fSZuKwXQQc0gMksrbqHXhcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihbqZFATT3BtOHSmp2l1+wyxt4hlArnLBhG7Ia8M/LenlTZ8NVpC2WOTfhZbUCV2aNK5Y9QUUuRu3CjOHRIFVsq/oxfm8fTYAt1AYH5PfTc2Nb9ZQbNHFk37SFYW53QFQ+0IEaS5hnGYGlzenzhxORDYAD+BYoY3f8HhKmyKPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXfOX6e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A789C19424
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772098192;
	bh=AEnSsx/9D6b3psUj9gu5fSZuKwXQQc0gMksrbqHXhcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AXfOX6e/Xey2Z0RA+Ym8IUCSlj0jBLzRKM3DytYpkh9mTtnjh+zyUkFGMMbo5WbA9
	 xPXM85nWFx+Z4ppL+FHbCiN5ZI0AzS4N4WHnAM/zxkZgJm30RJJZSEgQ6I6DpB7dWO
	 PVCse+CdWtXP/Y7RyVFqsCYr580aC9vljUm4D0LzL4j7U0vIY4EiAlhGhdKyl60oHl
	 KsqIo64TcmGVWNt6tOCpBLgJkBFLagh9S3J83fFq81R8XRH0kd/aO44KVBASL56ltu
	 hJligztLk6HghRbLoe11HT6NfN3ebpxcIp5LBFyQKxSyTraiZezHMSJjdtYcIu7XRu
	 MJe5M6Dc80hWQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9362ddbee2so26529366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:29:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6bPGgog9VhglKUU+GWt+9dnTu6CZ7H9ngYCu/JU3VcFC/zXmv7NUZscFGsKCZAK/fdpjp/mgh1bfAPcop@vger.kernel.org
X-Gm-Message-State: AOJu0YwqC6J7A9rj0ajZyJg8NVlKQIWsMN65sksoVUd2NC8NUDhvR10Q
	uFGGysG+lxQPKH7g6tsGCxbo+U+gbf6GxwgqaY3hc8+zZKpWZKwzmQ+10liRd/A3o3Gmpngm/Q2
	88Z9vxNW99ZMLh6W0mUbYIim2gVmNO6o=
X-Received: by 2002:a17:906:fe48:b0:b90:71a2:3e76 with SMTP id
 a640c23a62f3a-b935bb83880mr97523966b.61.1772098191029; Thu, 26 Feb 2026
 01:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226040355.1974628-1-ethantidmore06@gmail.com>
In-Reply-To: <20260226040355.1974628-1-ethantidmore06@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 26 Feb 2026 18:29:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-eOjEfVvYAftLqZE5goL87k=-2vtDRavW52PyBU0pazQ@mail.gmail.com>
X-Gm-Features: AaiRm51FYvz0ryQ3i8xLZkNMHtCQlcyMueVtE28A6idU9F4od0TXvZdTv49OO6E
Message-ID: <CAKYAXd-eOjEfVvYAftLqZE5goL87k=-2vtDRavW52PyBU0pazQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ntfs: Fix two minor issues in namei.c
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78457-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A9301A3A4A
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 1:04=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:
>
> Here are two non-bug issues but should be fixed.
>
> Ethan Tidmore (2):
>   ntfs: Replace ERR_PTR(0) with NULL
>   ntfs: Remove impossible condition
Applied it to #ntfs-next.
Thanks!

