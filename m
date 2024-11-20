Return-Path: <linux-fsdevel+bounces-35273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F39D355A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D6F1F22D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC10176ABA;
	Wed, 20 Nov 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u51QJyMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FC1B7F4;
	Wed, 20 Nov 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091241; cv=none; b=gWV6o877xPGGI2WwtyHcG+VClhqVz/zfC0B6Vt7czzoM+TuKSOvdgprWkcomIYr/LusclGRWcvqsCK7wg6zlvANYZCB3kb/alHN6TdeNuAkaCmggDn9SrWgV17QH+gJfgqWGaCKbpW0ZLEEsFPW0CWl/G3rMQVv0pY19Mh0Jt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091241; c=relaxed/simple;
	bh=BEvLMCFu/SwNABjZphfBubKocL8CxdAry6QR8qtTTJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+6OOtMrdh5/wXrbt7Q5FNksSh5gO0wZAX8267cjNXPRMCv+dFvJCFyShJArqVPuqyS56Hgk+ZPBFpdRr3OUoEd7aaIuQtEkN4aMpNcXpdpMUojmnwKSQ3KaQgcAqdE/X8wo4TkeRNNso0PXIB400wm7HmS2F35GjLdwt6+Nzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u51QJyMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC79C4CECD;
	Wed, 20 Nov 2024 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091240;
	bh=BEvLMCFu/SwNABjZphfBubKocL8CxdAry6QR8qtTTJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u51QJyMqql6jcLBymU5gwTy7DlpszEJNTI/EYevOz/E1JgL6uIpoHn5BkhU8BNHmS
	 dD9ysqVgZBPVizgeEbj94qUfH277oX+QvKefUa/m088VlOSe2RfyreaY8v2/cGB4nM
	 HuY10IrVRdR8gB22cJSU6wUPawIH8Hg348bUammgIAb13zRSj+Jfxxhhn4M8TLXYDC
	 lkEzrfzQGkjEGou2HdsTXOyWrPp7lmCWyy1w8euBKyJpyEvZuH6HbX7IucdPO5IIEK
	 qyZeTftLMkGQX/SAbuPeaxmhMjisdGAzdLsMXZMaKidBedTQgonXXfNocL9oHe5dv3
	 e/al+jIQAhjbQ==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
Date: Wed, 20 Nov 2024 09:27:11 +0100
Message-ID: <20241120-oblag-brotaufstrich-5bff7148d3b4@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628062329.321162-2-thorsten.blum@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=brauner@kernel.org; h=from:subject:message-id; bh=BEvLMCFu/SwNABjZphfBubKocL8CxdAry6QR8qtTTJs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzk3cpn7j9o1dH96eeXOSUZfZd3u75f89ry57na1R2 c4as+6xaEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzCIYGZ7fuNFYYMYwPWn/ n/Rpq+7eubf//ieus+f1dOqbjzBvKtFiZPh39u5bv5CXlksuS6/jOxF5+1jWXyZ3FqWIZq2nv6b LSrACAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/uio.h
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fscache: Remove duplicate included header
      https://git.kernel.org/vfs/vfs/c/b8a962275765

