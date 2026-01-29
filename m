Return-Path: <linux-fsdevel+bounces-75853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G5uA6tUe2nRDwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:38:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B3B019D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0878E300617F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278538884A;
	Thu, 29 Jan 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebYg4IeJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5415B998;
	Thu, 29 Jan 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690279; cv=none; b=ESOODFkqm+rQWCRRy4psdT6+8JDMAefV5LPfrrA4rMEhZqWHtUIEspq84+oQ5kyLFy3yHZCA82WHZn/39q8a38dYwQ9S6V1JEQLB9he1mO5mbJMssPiZiVrNNtZgR6CLEJ2VCQBJgd+qPTvMvPJo2ulNqlPLkFO9W79TwmOg2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690279; c=relaxed/simple;
	bh=T9+P7twOypU9XArFP/M9N9rOMaHVoEosTmiOeC2xKSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1HWm4p0/mKDZffVnV+ErkB4SBTb9fzZZ0IyMrTaB0RoTLfqYjYmbXCVYAZiNwhRMV6uRo2+HfaDMomM3vr3wAV4QMJ7QP2iazPjFoptTTiMOA1eEazBCBCg8B85bcVkCzPVQerqjOCbDYK5HuVHbbluXOTAfsWvSGT0WXSsTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebYg4IeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF49C4CEF7;
	Thu, 29 Jan 2026 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769690278;
	bh=T9+P7twOypU9XArFP/M9N9rOMaHVoEosTmiOeC2xKSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebYg4IeJNlIOq71V0fDRRr2EZKdIYvMVwkfVuNqoaINHMnPULCtKX3tT/CFRjzIML
	 87BpG/NHH5aWEGc613aFiY1t+WBQ3czebxX9PtaZOWu4w/C5cC7wk05EzM8REGf4k4
	 n7GzCTBZSpv3XnmHxcXynvN6pNc6WMAdBYYcNifvge/TXZeBa5fS1coWeBoAKgETVG
	 z3Y9g9+RUUg+ltUeGCO8ewsPMvocKfeVROEZoSYrBrjtWpbw4cWnNCj6r8TpBD8wqp
	 gSiE5z3mUfpnbPghfqlZj3dQ1L+rfl99EcCJ/iVf5j6OKVO3E9FbgChGLgHXJgb1ey
	 w16i/wX8qMTDw==
From: Christian Brauner <brauner@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: dcache: fix typo in enum d_walk_ret comment
Date: Thu, 29 Jan 2026 13:37:46 +0100
Message-ID: <20260129-wunsch-pythonschlange-ff3399a72eeb@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128143150.3674284-1-chelsyratnawat2001@gmail.com>
References: <20260128143150.3674284-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=brauner@kernel.org; h=from:subject:message-id; bh=T9+P7twOypU9XArFP/M9N9rOMaHVoEosTmiOeC2xKSc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRWhyzk4+ieHLkpk2FZobFG26XLa/cL6wqtPGz1c1uAl OmBUGHZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8TmZkWDhxp+rN5Mzbd81a 9Jb+eL9a5WKIvc5hAdeViZdL9DwX2DH89wlKLYmVv6d7eM7hkKfMOoy7+IUZWd2XOTCUBezXPPm FBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75853-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A44B3B019D
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 06:31:50 -0800, Chelsy Ratnawat wrote:
> Fix minor spelling and indentation errors in the
> documentation comments.
> 
> 

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

[1/1] fs: dcache: fix typo in enum d_walk_ret comment
      https://git.kernel.org/vfs/vfs/c/fd5d8b65cfe7

