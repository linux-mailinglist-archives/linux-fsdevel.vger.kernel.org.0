Return-Path: <linux-fsdevel+bounces-75880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFhOGmGKe2mlFQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:27:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B1B2287
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC4C230071CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504133FE26;
	Thu, 29 Jan 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYT7ymmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD51DC997;
	Thu, 29 Jan 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704026; cv=none; b=gV2z8uCmz56iH1cVWeHyM94CEAENR6lgg420ApfD0AlzCUHGblmP0LGcJHY8+2l1NTvJe0kdLSa8um8+MVajle74yeOj5pbwOHAVZYJ1AxN5fz5a0MpcIwuoyisjq5oCn1gcLGfDQTMSi0GSeH5TW+2MezUDoa7Kh4MtqcSKNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704026; c=relaxed/simple;
	bh=rtHL1/VQYS1Lj/iAYw32emiKRb1p7qN1cmse1uPwUkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZMjSQCQFQgxed4B7YI3m08dPdWI0WxY3j/bIstFX+A4YijdR91KbZ4kLzmGXPmK5Bss3i+vgqKIRTCL9lC4Ck02aZJ0/tTDI269ePPzXnSVmAPx/TtDCiIqi/1HyZ8aHVVG6k7umoHyXYAwXB8LEyQolPfEETqlHz3FZ5DR+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYT7ymmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D04BC4CEF7;
	Thu, 29 Jan 2026 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704026;
	bh=rtHL1/VQYS1Lj/iAYw32emiKRb1p7qN1cmse1uPwUkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYT7ymmOhQd3eeeLz4UUSLRCssQLH8eh/dUtKPOdlToNcc+vACaAhCyeHG7rrljnh
	 7vv4kwarj8a6r9sFcw6gQKKLUeVPX1rtIAVedE91Yj5pUx/CqvjeFy0n15pWEMhrs2
	 ov/b2GhNcdVpVjOe94X0qQzzETAbLyZq0oAHdbi0HDZfyg4YZagQj+mNaAwlSZCiZn
	 HrTj/QSmm8numWLAJW+Lja0VTuWtZE2RT7F5WWk29KRu5TEy6zc1uqXDCzAycs2fK+
	 o1iWaVAhjf2cZrYHDINSOcch4AA0WeO0nSIrFyLzahLPcmGeV/MVzPmMHMcCTCK5uj
	 TvW/kXWjQ0svw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/2] nfsd and special kernel filesystems
Date: Thu, 29 Jan 2026 17:27:00 +0100
Message-ID: <20260129-nussbaum-stimmen-128b723cbe92@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129100212.49727-1-amir73il@gmail.com>
References: <20260129100212.49727-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=brauner@kernel.org; h=from:subject:message-id; bh=rtHL1/VQYS1Lj/iAYw32emiKRb1p7qN1cmse1uPwUkA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRWd4W6+liKxXuc+DvxU+X5hgq19bNWLt/8ciYTe1Sgw yyV9jlBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJ0mVk+PRruT3LLqnPWVuv yxWGG6yM2Nz8zuce+/35LVZHUte3bmBk+PlGdcL7d92fV3dPYDr+2qP4rwHL30s3VmRp5AfVBLU YMQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75880-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DE6B1B2287
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 11:02:10 +0100, Amir Goldstein wrote:
> Christian,
> 
> This v4 addresses Chuck and Jeff's review on v3.
> 
> The first doc patch is applicable to the doc update in vfs-7.0.misc.
> The 2nd fix patch is independent of the doc changes in vfs-7.0.misc,
> so it should be easier to backport.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/2] exportfs: clarify the documentation of open()/permission() expotrfs ops
      https://git.kernel.org/vfs/vfs/c/a39162f77f49
[2/2] nfsd: do not allow exporting of special kernel filesystems
      https://git.kernel.org/vfs/vfs/c/b3c78bc53630

