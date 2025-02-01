Return-Path: <linux-fsdevel+bounces-40539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DCA24B55
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 18:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1881C3A5C80
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1B1CAA7D;
	Sat,  1 Feb 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sxdzRIEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE681CB53D
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Feb 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738432746; cv=none; b=jDus8jfN8Y5hNrbZIysPlzraD2Mjrkp3+LB3MwPsNvKJQKkPkOv+94i83nW5yI5zrRYIvoQz3z24FXOUvtuG2a6I7qr9JOHHYtFRYbI3SqrywBPzRZrBA7ZEeptONSHXe1gCAIau8+8Gt9a7xMHRIZfNtcy4/Kri/jghj9tRFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738432746; c=relaxed/simple;
	bh=QEanhHjmGPxKCVSP1f0d92Od/Xl4SxoMICBSAMYJAr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfKY5yXEnA1QF+pfbSn7MocggdtFtiaJxQrzGUSvbCsL2VgUggP2t2kfuzGYR81oFPfMOA6fYrqsOGyvDZT4WtYpVWg8d2w137B/AvHZen18M/cG13lAl/MSRjDTqD0gHzLYrB65ajqd6BpO7RUnzDEWIni6NGoZklzMQJ4QRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sxdzRIEt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738432730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HkIr39KDpZ6NakWJJimSPaackvHlLSjkIRgMP8fQyoU=;
	b=sxdzRIEt6DCMeD8JJ3XqWV19N2c8cNvECwn7GZKXI4gGPYo0A7twQzJyBHv71CAc0gPkIX
	sHV0wpK0/wt1o0eGoCbQFrQ/Gva7gYKRwG3HAGJ2uv1Av3nPMPcROfyXODmX4oJDYG/vy9
	GN8vJxnpuxn0dMI/CfNw6QxZovYTBD0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] bcachefs docs: SubmittingPatches.rst
Date: Sat,  1 Feb 2025 12:58:34 -0500
Message-ID: <20250201175834.686165-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add an (initial?) patch submission checklist, focusing mainly on
testing.

Yes, all patches must be tested, and that starts (but does not end) with
the patch author.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 .../bcachefs/SubmittingPatches.rst            | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/filesystems/bcachefs/SubmittingPatches.rst

diff --git a/Documentation/filesystems/bcachefs/SubmittingPatches.rst b/Documentation/filesystems/bcachefs/SubmittingPatches.rst
new file mode 100644
index 000000000000..5e4615620c4a
--- /dev/null
+++ b/Documentation/filesystems/bcachefs/SubmittingPatches.rst
@@ -0,0 +1,76 @@
+Submitting patches to bcachefs:
+===============================
+
+Patches must be tested before being submitted, either with the xfstests suite
+[0], or the full bcachefs test suite in ktest [1], depending on what's being
+touched. Note that ktest wraps xfstests and will be an easier method to running
+it for most users; it includes single-command wrappers for all the mainstream
+in-kernel local filesystems.
+
+Patches will undergo more testing after being merged (including
+lockdep/kasan/preempt/etc. variants), these are not generally required to be
+run by the submitter - but do put some thought into what you're changing and
+which tests might be relevant, e.g. are you dealing with tricky memory layout
+work? kasan, are you doing locking work? then lockdep; and ktest includes
+single-command variants for the debug build types you'll most likely need.
+
+The exception to this rule is incomplete WIP/RFC patches: if you're working on
+something nontrivial, it's encouraged to send out a WIP patch to let people
+know what you're doing and make sure you're on the right track. Just make sure
+it includes a brief note as to what's done and what's incomplete, to avoid
+confusion.
+
+Rigorous checkpatch.pl adherence is not required (many of its warnings are
+considered out of date), but try not to deviate too much without reason.
+
+Focus on writing code that reads well and is organized well; code should be
+aesthetically pleasing.
+
+CI:
+===
+
+Instead of running your tests locally, when running the full test suite it's
+prefereable to let a server farm do it in parallel, and then have the results
+in a nice test dashboard (which can tell you which failures are new, and
+presents results in a git log view, avoiding the need for most bisecting).
+
+That exists [2], and community members may request an account. If you work for
+a big tech company, you'll need to help out with server costs to get access -
+but the CI is not restricted to running bcachefs tests: it runs any ktest test
+(which generally makes it easy to wrap other tests that can run in qemu).
+
+Other things to think about:
+============================
+
+- How will we debug this code? Is there sufficient introspection to diagnose
+  when something starts acting wonky on a user machine?
+
+- Does it make the codebase more or less of a mess? Can we also try to do some
+  organizing, too?
+
+- Do new tests need to be written? New assertions? How do we know and verify
+  that the code is correct, and what happens if something goes wrong?
+
+- Does it need to be performance tested? Should we add new peformance counters?
+
+- If it's a new on disk format feature - have upgrades and downgrades been
+  tested? (Automated tests exists but aren't in the CI, due to the hassle of
+  disk image management; coordinate to have them run.)
+
+Mailing list, IRC:
+==================
+
+Patches should hit the list [3], but much discussion and code review happens on
+IRC as well [4]; many people appreciate the more conversational approach and
+quicker feedback.
+
+Additionally, we have a lively user community doing excellent QA work, which
+exists primarily on IRC. Please make use of that resource; user feedback is
+important for any nontrivial feature, and documenting it in commit messages
+would be a good idea.
+
+[0]: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
+[1]: https://evilpiepirate.org/git/ktest.git/
+[2]: https://evilpiepirate.org/~testdashboard/ci/
+[3]: linux-bcachefs@vger.kernel.org
+[4]: irc.oftc.net#bcache, #bcachefs-dev
-- 
2.45.2


