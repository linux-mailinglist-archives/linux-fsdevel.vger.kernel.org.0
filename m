Return-Path: <linux-fsdevel+bounces-48336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B200CAADA61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889B67AA17C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0599212B3E;
	Wed,  7 May 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2cyRLyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50D1E3787;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607367; cv=none; b=DHAwMWxxREYBU2Trvmp2caLQA5FRx6sP9z3qTOsQNigFQj+qIhgX/QCw7G6X9p7WNGCWC0cc7NDBs5ttnERMqZPNHhJKs+Lh4b7suD0jm8yFBiBZfju0UlJNg0iMOphdkdI2mFdc9ahZJRuJwHzX+G8sdPISJNwi/nClEhDuRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607367; c=relaxed/simple;
	bh=/R+75EXS++vi//z+1SE3h0ZzDGQB+HQ9Cv8vh4zOTX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b+Hir2d6p98K9PFdCiaTQFjweY/rF8yr9iK54DYJmI8FuROnf+XQBlhWBOennUYnhnZGECAmTauTNovjVW3vYt7jff8pVoCJqzfzQ/kBJXVsEBtOtHQUHSaKLb/hJzVV0b9WrVmZ1Oq+lRTbyoMj2eApHM9sLlK7b9aJ/j7OQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2cyRLyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6271C4CEE7;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746607366;
	bh=/R+75EXS++vi//z+1SE3h0ZzDGQB+HQ9Cv8vh4zOTX8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=u2cyRLyyV2gr18q07tqaMMe0wbXQl2sIzw8eUR6fB8nd7qNiVKKryE7IGk8CLgnBO
	 rcHirtgTuIAocfocOa9i/XfztoJamWPKcrwyKu1cRfaQYpdNrvrdN4b64bPV/5QK0M
	 PbcqwtvAUXG7xdHYY+2f5CGF4dYEUipVVhDvyeWz90wiT3bFrd4ptJDUdVHRkx+bXo
	 T6XMnEYUbTfrEUTB2B4U9Sf2w5TNAfZ6tV4BNW5MWloe8JC90WmQAK+IIOE4/jVWfx
	 hKsmlZVXYC7sgexN1YZMgEvUUqc8jMUjTc+eGXkb6nyDhv2AZOJ72eXg+i2Rsce/dN
	 HD9k106hyUzKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489EC3ABC5;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Subject: [PATCH v2 0/2] Add a documentation for FUSE passthrough
Date: Wed, 07 May 2025 16:42:15 +0800
Message-Id: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOccG2gC/4WOQQ6CMBBFr0Jm7ZhShAor72FYNMOUdiElHSAaw
 t2tXMDl+8l//+8gnAILdMUOibcgIU4Z9KUA8nYaGcOQGbTStaqVQbcK42xFFp/iOnocImHdckn
 3W6VtU0GuzoldeJ/aZ5/ZB1li+pwrW/lL/wi3EhUSqcY605LR+rFO+dnC5K8UX9Afx/EF8xcvO
 LwAAAA=
X-Change-ID: 20250507-fuse-passthrough-doc-59e1c8432a63
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Bernd Schubert <bernd.schubert@fastmail.fm>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=/R+75EXS++vi//z+1SE3h0ZzDGQB+HQ9Cv8vh4zOTX8=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoGxz08UAUIZR6/4SH1If+HbA3AraI/ye151KBQ
 oserKHb6WqJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBsc9AAKCRB2HuYUOZmu
 i4foEAC9iKIDp/SNoaR4Oy+tAn6abLtNXfzF+xrs1TAxhpPfOVL7kv5IdTQqryJVDg5U7wlt3zK
 Oex4unqgJt+jjjcQHvddqoVhODYcIcvDTrAiR9DN9SrvIGzZOA9qoFcWeU64p+yRKgr7VLU/XQN
 4Vtj7gdgM3+fe6HRcSZNq/zHG31Rq+1jyTuGnOw/eXMMaJ0KtxWIzZLcPRkXMXFPs3EOFuhGTYf
 P1m/5fU5A7HksXF/0+E20jbsf90yUQjS+wY2xEiLcZoGWAFgQ2QzyGszQOA53OB0GS6aWB0eONo
 kcR2Myxx1D1H8H7D6C1/atombXmg58hdlb9MHyzaC9F6G0J9UV140RyZ+H63MGhV7hn3BPO7Bqo
 2A7LCbyHMLMIGDffKO2021AK79/0Pi6moyizRssu/fOrGIdFBtpcShyKNeCxM0r5jAGs+vn/X2z
 k8PwWjnatpFEOWx36D+A0PMnZYO6sLjQM3gPa4E/NK4beBTBjI8pZFZLnq3WxeuUW1u9vZ5E/xY
 qeYQT4a0Qq5o5rYLlAoP9caENQ1lk79kllLEyDh6lesJffH9Z9iNfxt+jV7vyo+AzL8GeqMFb+j
 n4c02FJAhSCKt0u7bGYxEkDwiP38jHiwFAU2oVG8+N6RH0wP2XWDCyv4tNwM4Bbpd4PehB/5rf8
 8oQJ3BOuKKOYk+w==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

This series adds a new file,
Documentation/filesystems/fuse-passthrough.rst, which documents why
FUSE passthrough functionality requires CAP_SYS_ADMIN capabilities.

The series also updates the MAINTAINERS file to ensure
scripts/get_maintainer.pl works correctly with FUSE documentation.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Changes in v2:
- Add the docs to Documentation/filesystems/index.rst toctree as Bagas
  Sanjaya suggested
- Remove some paragraphs as Amir Goldstein suggested
- Link to v1: https://lore.kernel.org/r/20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com

---
Chen Linxuan (2):
      MAINTAINERS: update filter of FUSE documentation
      docs: filesystems: add fuse-passthrough.rst

 Documentation/filesystems/fuse-passthrough.rst | 133 +++++++++++++++++++++++++
 Documentation/filesystems/index.rst            |   1 +
 MAINTAINERS                                    |   2 +-
 3 files changed, 135 insertions(+), 1 deletion(-)
---
base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
change-id: 20250507-fuse-passthrough-doc-59e1c8432a63

Best regards,
-- 
Chen Linxuan <chenlinxuan@uniontech.com>



