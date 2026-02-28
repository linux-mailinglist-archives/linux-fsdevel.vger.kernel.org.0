Return-Path: <linux-fsdevel+bounces-78809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t2/bC9dbomlw2QQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 04:07:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D71C012C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 04:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0835302314A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D042D0610;
	Sat, 28 Feb 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1SO5a0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE286D7D
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248018; cv=none; b=pXmhT3Z9nsoRguszxMjEhV4xhX3DHpi9OnXiKZrkXFM3ebSPUzCml7ix/wTqmhbtFsXqCmdCbSQ0P/FaJrlYB8fYkaH3uethXeSJpwuP0LDHmNk1zPdlAvwjG6l05kuhklam8BkOrQOfc+PQzoCH05f68769vvmtSk6irfcbSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248018; c=relaxed/simple;
	bh=DDaJDLr6rfbYCONV1hjqRTr3hnRKgGdTYMXk+Clst4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq7tjRv8LWKRJV1pWpR0vvMqjxMUvK4Os2z+G8OJQZrDyVM52vU3n9n9qRv9o3uCmC95F5OwzvVJ3buCpMedUJqn4ASPPpO1kHM/ds/MfuDuYXnrL71Dd06OL3BJ1/0mAwwq14agFu/EZ0GhD/+/vv+m2/H/kazNxfRvOgjm33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1SO5a0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1E3C2BC86
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772248018;
	bh=DDaJDLr6rfbYCONV1hjqRTr3hnRKgGdTYMXk+Clst4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1SO5a0+8x3wngyFabM0opxCAmDvGsUdhDhTJ99JBXqmxqRNgI9JMhNShnpxp+uHo
	 9Nj1lddFTAPdzaXlcI8Dgq6i9O4agj4bHfO8vBpZQzNCIiGsB/2ipnxh8Q8QPei+rP
	 uf/QrUKeu1WtGAD0EMDFDvGyGEIbexCZzFvHcVlo9lCdbZm1VsJDHvMGabc0vsQebj
	 VWsoD9WAusHabonA8drCbkNgRvOyb9dXpjVSTwBiCuTbA41iLYhPmaD4WOQmUbQTmx
	 v+/FqXvzTktTtoucEQzbB4wN/ot5JHUmMMMuPizRowCCRx6/ri5EtlvmyeqvFjZuh8
	 27E2Z8D3kSmBw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65fa4713bd3so4921718a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 19:06:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAJ3OS2yYPXEKta8Jd/snovfeuSbTjbk3GsuuD4kaMcPOBhQzAFPgYw3Z0UbAbr2q/+I4yAKkybDVy/bHk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+z98Dz0KmqfYB761pD6D+TkAKtW54qbPIJFbUTs4W0LWb38i/
	Y3hEK3VZLDCUHWNWhP60SVEELO1bOTG42IKsHfwBWBb7MrpezSnxSh6aO0XMZ1Jpgba58XoJEEF
	CNtMwIQmboncsKj6O7S/eLt7pcKMnU0o=
X-Received: by 2002:a17:907:60cc:b0:b93:8460:4ac with SMTP id
 a640c23a62f3a-b93846007a8mr173991766b.53.1772248017070; Fri, 27 Feb 2026
 19:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227231854.421561-1-colin.i.king@gmail.com>
In-Reply-To: <20260227231854.421561-1-colin.i.king@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 28 Feb 2026 12:06:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8yzKA4X_+J2BhSZGkWuO1VDGFPS2Cq-vaPVM4r2mbLjg@mail.gmail.com>
X-Gm-Features: AaiRm52XIwwvPr8IXCWmqUBxxs7R9NYP7ECnAOVSxQ5QHA7LESumhtOrICC7haM
Message-ID: <CAKYAXd8yzKA4X_+J2BhSZGkWuO1VDGFPS2Cq-vaPVM4r2mbLjg@mail.gmail.com>
Subject: Re: [PATCH][next] ntfs: Fix spelling mistake "initiailized" -> "initialized"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78809-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: BC4D71C012C
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 8:20=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in an ntfs_debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied it to #ntfs-next.
Thanks!

