Return-Path: <linux-fsdevel+bounces-74648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOugEr98cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:14:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B352A94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9888870BA98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA0427A0B;
	Tue, 20 Jan 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpc730Lv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE91684BE;
	Tue, 20 Jan 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917266; cv=none; b=IsfsTksvTqu4hBNE40VXNUD9FsTTmq/RHnuq29XSrw+7JfX9l1l4mpUS798g1d7EDtOk3luhGVy6TmR2cYpHoYYSFCQFieUdLcZoxtmPReKGu9miNp8WTJCKNVSb3o5LBMcygidwNTJFqCAGYImedTnTiH8duJVTVYF1vUdAb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917266; c=relaxed/simple;
	bh=vagKkIkYgMsQsMgtth/N1Y9UWzHO9KSOWCLPoiq8iMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkwQGeW6qClqE6pol652hpgpNDV/z13ua33lOTTgt1T5XciM8xrcm6t/kp4hg4yd6C+m97wVnvpQJWf4m7it7MiPseAlmYaMsBE4FImYipRXfbN/DRyloj7JVoAOvogxXIcsqQI2UGLp4yx0ld3C3Ge02Avo6VNgtM2m4ObbvFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpc730Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E55BC16AAE;
	Tue, 20 Jan 2026 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768917266;
	bh=vagKkIkYgMsQsMgtth/N1Y9UWzHO9KSOWCLPoiq8iMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hpc730LvkG2aKGO5Be6ngC6ORrBgQwHSc4RKZLoEuBHzjsLZLGXZE7VSZAXwUjghb
	 AJsdg9beAuNZfAqNNlV+UxabogqgnH9rih4sF87O02/CPm0boAZ+U2NpVoDlQY/4V4
	 4Q+6CJwFW8WKltPyyZIswfYfk3tgDq6JUXDLOqt0hpkMrx7P2pwIjTPlPg4ELQQfjY
	 Uv3wWY/Ht0/T/mFJtYswnn9+7VzkBoEpu/Rk22YTa4BzScJDNlU6zFobOI7XfRgoZP
	 jB2QAhwcFFXauehXbo0m9QHKxI/VD9RewGvrKHjqjZ2fB4csrVhUgyP/ZV7zsQ65kM
	 d0mysUW7GX/Dw==
From: Christian Brauner <brauner@kernel.org>
To: Jay Winston <jaybenjaminwinston@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/namei: fix kernel-doc markup for dentry_create
Date: Tue, 20 Jan 2026 14:54:16 +0100
Message-ID: <20260120-stunk-rational-5065ba74bddd@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118110401.2651-1-jaybenjaminwinston@gmail.com>
References: <20260118110401.2651-1-jaybenjaminwinston@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=brauner@kernel.org; h=from:subject:message-id; bh=vagKkIkYgMsQsMgtth/N1Y9UWzHO9KSOWCLPoiq8iMY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTmd/LyOLjmNgib/U3rOOSxj71qEj/jxr6Ic2Y/ioP4O hyvWj7pKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIiyKSPDjq7F+9klMh+JKNqv +xRoPY+tW3HK5u4/RW5TbRxXPZkTz8jwds5T72VxXpONFr5dL18/qfnXqRUcpZX8ZVdZrq2rU73 EBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74648-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0C8B352A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 18 Jan 2026 13:04:01 +0200, Jay Winston wrote:
> O_ is interpreted as a broken hyperlink target. Escape _ with a backslash.
> 
> The asterisk in "struct file *" is interpreted as an opening emphasis
> string that never closes. Replace double quotes with rST backticks.
> 
> Change "a ERR_PTR" to "an ERR_PTR".
> 
> [...]

Applied to the vfs-6.20.atomic_open branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.atomic_open branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.atomic_open

[1/1] fs/namei: fix kernel-doc markup for dentry_create
      https://git.kernel.org/vfs/vfs/c/6ea258d1f689

