Return-Path: <linux-fsdevel+bounces-58293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527EB2C072
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E61BA4A7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99315326D71;
	Tue, 19 Aug 2025 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj+ZE0t7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E132A3FB;
	Tue, 19 Aug 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602928; cv=none; b=CUsASHhSvP+pKPutjr9PNewcaYQyfRrkcrakD738bW0jYxu3YsZOzF4kKB1W8pT4JxGFA5YcRVw5dNwtetHSovZqHaM1/x55vQXfpEJAWEc/8fU5Y8GnGimfS5b40TyWYzHDkxmLI+YVr2aHK3de5PKopk0hJR17nvL0oUkfP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602928; c=relaxed/simple;
	bh=xgjcyGTKmVI/WWGy3hDbYnlHhmGujchAhnbzkdIp04g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0o43X83Ph93IcqMOfdJ8dTrJCQ5qliVgGX5AlWr0u24haSpXTYias+h6vyGirukSzP0q135PSKbg2H2G0nfRsGoSdeTiOHBnS76L71eUXqZTX/f7xJ9JXMs2OV4EY4TPz5jm19oh/kT7SlvGklZv6Yhzi+9JlaluBvytzpb9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj+ZE0t7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43B8C4CEF1;
	Tue, 19 Aug 2025 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602927;
	bh=xgjcyGTKmVI/WWGy3hDbYnlHhmGujchAhnbzkdIp04g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj+ZE0t7JBtBsMoN/gB9QQ353CIxrOFN4hq3bpmG6Tu62lIsuhpIaFOks2l8y/uvi
	 6VrwfmNBv9Wuj6BzI1hq/ML4Pamce3EPYC7K1zoYeuYDAmcF5hmZO8TPz+DMCqaP6c
	 enA4sF764InA7rslpX3r9ty1W370gPGRDhwjuXyZ4jrNQBxqiocQE/RiFL8323Aypw
	 3KoE6qs6VkkhkyhGqi/wkw3CNQ5NDWVFuwGidLqFIRpdRUKulLGGJtRfnb99k8Fnjy
	 PU3UyuQQwLeqjBKjehvL/UU53xtvkCP6mc7pQRp8ylf7oEqGRimB5bYuhJnsfHma37
	 RwzcQtYyjZVWA==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] pid: add Rust files to MAINTAINERS
Date: Tue, 19 Aug 2025 13:28:35 +0200
Message-ID: <20250819-funkhaus-braut-345acc709e07@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714124637.1905722-2-aliceryhl@google.com>
References: <20250714124637.1905722-2-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=brauner@kernel.org; h=from:subject:message-id; bh=xgjcyGTKmVI/WWGy3hDbYnlHhmGujchAhnbzkdIp04g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsiX8xb/Vsl1/LM+bt1vr05/PhlbXf17ffFS5OYV5k6 Ct3RzjiSkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDO8w/LOttVwbqdRy2+/r EW6u/XlJLvNUjX+9OvZp46myh8lOh1wY/ic0+CY+aK/SdZqfu/Tja+mMW3eU0qs2X53x8tOB3Xc Oz+QEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 14 Jul 2025 12:46:37 +0000, Alice Ryhl wrote:
> This files is maintained by Christian Brauner, thus add it to the
> relevant MAINTAINERS entry.
> 
> 

Applied to the vfs-6.18.rust branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.rust branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.rust

[2/2] pid: add Rust files to MAINTAINERS
      https://git.kernel.org/vfs/vfs/c/76196742f49e

