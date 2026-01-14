Return-Path: <linux-fsdevel+bounces-73788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77AD2091D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4507301AE24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2C302151;
	Wed, 14 Jan 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCFA0iS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69101D5ABA;
	Wed, 14 Jan 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412143; cv=none; b=TOwO1idad8orHh/30GZ50EvZFWxGTX9uUaqOaF8esReHth2KhJcV2U2FWwEKEnB92e5eCsLOlZapPPLcfNqYc5Sk9Jb6EWriQQewvBQgHF5euAPeaWDygUIfsJ4nngOebpOK+jscooTnQ8DKPhQtmNP57OyUGv8bWhUrUFGpNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412143; c=relaxed/simple;
	bh=StjXHvouvWQmw0RrTtQN1NyVarGBOdFO/AzhATMAE2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aM7nSCbzZy4PbnUTfV9Ay7ZFHRP0NspgQprySNHofz5/R9IgW1b/mEk8tPmWszq1jO7YBrIUZiXqXS2axfE3jKnXCaYcVQRTTsh98r4WJUoBesxUJuOnXH604cHkRGhz4AHLOvWSnNqPmRPpdUkZ1k7veMG4KYJ6bCRoiNqMgxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCFA0iS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9B1C4CEF7;
	Wed, 14 Jan 2026 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768412143;
	bh=StjXHvouvWQmw0RrTtQN1NyVarGBOdFO/AzhATMAE2w=;
	h=From:Subject:Date:To:Cc:From;
	b=kCFA0iS/5iNv+dlwY9vkID3zzyxEEFcOeHqKYj0tX5emURIwoBYBo5weR/4qKjCJ4
	 ylK7Y87loucCj9POMRk+NAcB3YPAzD1Hudh88TgHXR25GvlGGbVTkob8/EZ6uh3Bfc
	 pqSHCZcfqYYPyF5YHqrjFc4zO0YOfYysYue/UHbaNw2031igC6wogaInj9OyMRv8g8
	 cUBXKuK+21XJVBPXK2Q914ul1YTDVwclU/OrL4J/XBK8QFhOqKeapNgqYXoqLmFGlT
	 zjuamPwqpQHEhmDZuSj7UWpo1x5NvMe3PqLKPgZVsZJ2biz5X86QgkNJzBENSbEs3V
	 OqjyOxoJSrDCA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH man-pages v2 0/2] man/man2const: clean up F_GETLEASE and
 add F_SETDELEG/F_GETDELEG manpages
Date: Wed, 14 Jan 2026 12:35:23 -0500
Message-Id: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQqDMBBFryKzbopJbDBdeY/iYqhjDK1RJhJaJ
 HdvyLLLx3+8f0Ik9hTh3pzAlHz0WyigLg08FwyOhJ8Kg2qVaaVUYsV4EAulUdJE1vbaQJF3ptl
 /augBKwaxoys0lmnx8dj4Wy+SrMJ/LUkhhbZd35nbjIg0vIgDva8bOxhzzj+zTsicqAAAAA==
X-Change-ID: 20260112-master-23a1ede99836
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=StjXHvouvWQmw0RrTtQN1NyVarGBOdFO/AzhATMAE2w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZ9PqYUrazvAp4hBL07l9BcddnbZW5w5CGVsf8
 SVZDPqCY+qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWfT6gAKCRAADmhBGVaC
 FbKwEADGdAYE3MW5bm5S3dcRTsj4h28ZBe7pv7HOWNURKBJYOe/+QY0nyJgg6/zlNHVW05jDQhR
 K64BwXyH3/jukeybo+u8MR927Q6NJs17JndTZEBAVBrSOQwFT+S2O4EFHjOdP2CmEOiTIm/0hTw
 bIs7mzYOocu/QvCf/DA6HbRniBvkSxDQityHUY6gUmubaQTiniIWZI7oorWRMfEraxdVotaWgmN
 R8rKGO3aPrH/TPFLp2hwnI1yHyL1ZkLIxBPVfLvn5uZpuilB8DyY/ROaXGghSdTyIJcmlbWWitn
 x+03CeqcjzV2lsDuwC7Vj9pp+sXUmK1Mnk1SoOHybaEfh6kG45fdFgZy6Tpz0rzq3UPG8zQN4l7
 QbIYaOZ/mWMEZDgFeEPEbQei4j1yGSUvasAPmRvtVQjpAPSLxr6nWtWk869T5bVm7PmE+HL/2TV
 nBFOwBkrT32tkWlNwMQlK7F0KVAe4bJBsF3I8NG8CJRopdpJeQgEK8XizEfrPmCRDQbocLPkxSh
 bgOkCavJ/QTjCq4hiuEbm8fH4xW1YG3PeO101EcrN7e3EpaRxOnVmWbuOZ/HJ3Ffk7yJlySALyS
 2dP1LDAhLK4ZVTjuUoeew5KENDiea1p7MiG2yiNgfotif2RdxiYk6sh/6HF5gIE5Wss4mNuPg1q
 YRTim26fMjmrDJw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Hopefully this set is closer to being mergeable. Let me know if I missed
anything. Not sure if I got the semantic newline thing right, but I
think it's at least slightly more readable now.

Thanks for the review so far!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add patch to clean up F_GETLEASE manpage
- Grammatical and formatting cleanups for F_GETDELEG manpage
- Link to v1: https://lore.kernel.org/r/20260112-master-v1-1-3948465faaae@kernel.org

---
Jeff Layton (2):
      man/man2const: document the new F_SETDELEG and F_GETDELEG constants
      man/man2const: clean up the F_GETLEASE manpage

 man/man2/fcntl.2                |   5 +
 man/man2const/F_GETDELEG.2const | 246 ++++++++++++++++++++++++++++++++++++++++
 man/man2const/F_GETLEASE.2const |  22 +++-
 man/man2const/F_SETDELEG.2const |   1 +
 4 files changed, 269 insertions(+), 5 deletions(-)
---
base-commit: 753ac20a01007417aa993e70d290f51840e2f477
change-id: 20260112-master-23a1ede99836

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


