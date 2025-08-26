Return-Path: <linux-fsdevel+bounces-59230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5001B36D91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D228E189E8DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A12264C0;
	Tue, 26 Aug 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="K1IufTP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DA23CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221487; cv=pass; b=aOiJGzIFV2VKCuhDnR6lR+Ba9qsLfNyyZ4fGYW0dYeaCiCnCe9/P3BalVxQrBjkPkqg5SXP3RBTRJ6BrYgCEOM0xyT3mbZU0OOmDUTUKRA37KkiQfHwYtM8m9iDQqZdqfrbh7hinM7y+K+jidgbxAitliZsEv0qY8QVP4B/Tgl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221487; c=relaxed/simple;
	bh=M9VfauwBLX7NxcgpVMfgAzXn/h9dr3JE5fxRdBZGBT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIb9Hny7M4gvqCMLDuVmsAlVSVnlwW5IEQA+i796wDxnMFHEdRc87wlnOUvssDnb/AvWmbOJmufhI5jRWLPuVFpsXpJGVReBsEdiJY0+pNXlI4Eo6UwJTcd0fMZ77mY6VpmrQeK/vxuabBML3RvJclHBBY1ph4siPqVEJs9FxYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=K1IufTP8; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756221473; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RIyFGg5A8QdXL5wkSDIo9TpjQSyLto8YcUuN3dQtBHmdgZTVC5GWbmOTVDeQ5qGoGixj7yhF4CfrYhR6GRzk30K1RbAig2WtTpcpA6pTQ08a+zQfxtKkskGBMQoy/6JgyWyWdw7Bdd5Fmu8rx0QKZ3k/hz9rC5pE1UGHDqTUXjI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756221473; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u8dqDZW00E/yaszJ0h1jQXjMemKg9se6aPNiZW1do3E=; 
	b=Y/UfmuZo+1cHcvcjHYqxYgYHjnENqnXYPOhpIYsYySJiMuuVxPsyDHaO6r+RahLy3ByDghWAgckeVTx4BmYMywNJ4jryB78HKrGuyOfiMxvd9da64rn4l4Ll9UAfPR2y7jNGDJ0CU+t2G5mCRPRjThG+PtPVeWapZCTjmo6uuKA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756221473;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=u8dqDZW00E/yaszJ0h1jQXjMemKg9se6aPNiZW1do3E=;
	b=K1IufTP8ScPvUIAroGoSilcIQl2Mdici+tc4zTgpoiP4NUGGSwSdvbcIsxz+mrxh
	rketpzBDV6BjbTq7mjfObW5+OjUOM1h+qdXLVWMQLHvQIbdwkL4GLJ0HHlMZWrPqzmp
	YsKy4uTnS+kt5rhLLYDT/cl8pHtsJmZCcT4uCWVM=
Received: by mx.zohomail.com with SMTPS id 175622146999451.851008478100766;
	Tue, 26 Aug 2025 08:17:49 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Date: Tue, 26 Aug 2025 18:17:45 +0300
Message-ID: <20250826151745.2766008-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825202141.GA220312@ZenIV>
References: <20250825202141.GA220312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227dce8bc9e21a7fefefe59714c0000c4f0ede94a52d428a484e1bcf49a6f3b38b67d6d30a03d2d0a:zu08011227ec7b79c9d382ba0c696ebdc90000a3b550af460c6f954249d25952b792c5561a211680c94f41e6:rf0801122c0328b955a5ede8faf00c5e3600000a4bc600c3d2a719f4df98ba4be88d168cc97ae54672d25ca3ab59099f05:ZohoMail
X-ZohoMailClient: External

Al Viro <viro@zeniv.linux.org.uk>:
> When the last reference to
> mount past the umount_tree() (i.e. already with NULL ->mnt_ns) goes away, anything
> subtree stuck to it will be detached from it and have its root unhashed and dropped.
> In other words, such tree (e.g. result of umount -l) decays from root to leaves -
> once all references to root are gone, it's cut off and all pieces are left
> to decay.  That is done with mount_writer (has to be - there are mount hash changes
> and for those mount_writer is a hard requirement) and only after the final reference
> to root has been dropped.

I'm unable to understand this.

As well as I understand your text, when you unmount some directory /a using "umount -l /a", then /a and
all its children will stay as long as there are references to /a . This contradicts to reality.

Consider this:

# mount -t tmpfs tmpfs /a
# mkdir /a/b
# mount -t tmpfs tmpfs /a/b
# mkdir /a/b/c
# cd /a
# umount -l /a

According to your text, both /a and /a/b will stay, because we have reference to /a (via our cwd).

But in reality /a/b disappears immidiately (i. e. "ls b" shows nothing, as opposed to "c").

This happens even if I test with your patches applied.

So, your explanation seems to be wrong.

-- 
Askar Safin

