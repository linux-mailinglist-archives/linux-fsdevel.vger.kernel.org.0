Return-Path: <linux-fsdevel+bounces-28565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6115B96C156
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161371F23D88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39DB1DCB1B;
	Wed,  4 Sep 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIM02c+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369321DC18E;
	Wed,  4 Sep 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461684; cv=none; b=ewyPBjwyYLvkgRNxy5oZ987EFGz9x5m/u+l3UfbKKXoeo0KK5UFbOguHknwy/EShgrMn4unKB8kkwx7aSE0NAH/NubA5zGjxccadxFyPy//vGQVjdcaDN1LycVQOPB2XP7v0YAYiFlrVwOo+qjoP6zdjqMtb0KNsKJl4nNJ4OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461684; c=relaxed/simple;
	bh=FPWWWeiqddbX8V80B1GjjqkJtba0qhCIKlsrh8+3VUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc3vAyl0nQZIbcmhFhxKg0WQkxm1r63SHhaDLcRuVUlTu/e9qqsY6sQOURnZ0DlV9mMptyL7xCbtV/V83LCT/68iLYNDwBWiAabUu0v3NSM8JJ++CmMqRAhTgcrxOTpqDM1+lGgArmFCjIUX3YQRaZGKZENTI0jYRvneKiWfFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIM02c+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADA4C4CEC6;
	Wed,  4 Sep 2024 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461683;
	bh=FPWWWeiqddbX8V80B1GjjqkJtba0qhCIKlsrh8+3VUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIM02c+ZBrKPgtMglUBQCyc9HE8+0OPGJTPLhpXiFito0zDhVV5lqu4WkCeMZ40+d
	 L2UWqfruC4dFAhrq3y2640w5dVWDEj1uZtkyis4RFcD0M5E4mgf+EIjYiQohnFB4Zi
	 5UVuSZsSGns/tUB17cL8Y81CKD9HplT0flbPJ07jFmovPj5snyaulmyoqesrgtl9vM
	 U7a40SoeQ8KYpHhlp5hmf3/voqse9XOdic7rbKKBovJlagt9Rg/qPOdL63diz20WbT
	 52OapMKWXJA3Fa1N/VVLcev3OX8fQPco+3wdqgJBT3CLzf2OzZFzGHiqM9IqWhznAd
	 FOrsh9fM3HKnw==
From: Christian Brauner <brauner@kernel.org>
To: Kienan Stewart <kstewart@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/pipe: Correct imprecise wording in comment
Date: Wed,  4 Sep 2024 16:54:25 +0200
Message-ID: <20240904-achtsamkeit-wahrnehmen-5bafe6cd3727@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To:  <20240904-pipe-correct_imprecise_wording-v1-1-2b07843472c2@efficios.com>
References:  <20240904-pipe-correct_imprecise_wording-v1-1-2b07843472c2@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org; h=from:subject:message-id; bh=FPWWWeiqddbX8V80B1GjjqkJtba0qhCIKlsrh8+3VUM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdKFkxyUV+3byduokXv9x4knNrTfRv1gWzzjXmzdTat GvuyZfHmTtKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmcmAhw28213dlv9oNwoOl t5VdYsjMWvmHT+Evi+L/18xTDkyW8tjJ8L98vnC/HlfljSqlZ1vFVJcz/StXWruk5OtEyyfB8pc NNzEDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 04 Sep 2024 10:13:29 -0400, Kienan Stewart wrote:
> The comment inaccurately describes what pipefs is - that is, a file
> system.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/pipe: Correct imprecise wording in comment
      https://git.kernel.org/vfs/vfs/c/a5796d69bf18

