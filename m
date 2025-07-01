Return-Path: <linux-fsdevel+bounces-53450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7743EAEF206
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A705D442AF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644626CE25;
	Tue,  1 Jul 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReaEsB3E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDF260590;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360238; cv=none; b=C/YY+dJ6DVvPrIY4YItllJC2E4iOADqS0s/5WNF9Gfc3Yn30C4M+pAmD6//1lrcMSgX59XIbHJx8L9uA52zxAd4a6vavIDq+idvTuqq7OH5tlUMLSbPID+YqeGMgFGWH8wpjJX5BcrarU0eIAdhFONGmVPBXejrbcrQsS1U1Ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360238; c=relaxed/simple;
	bh=dEWKHLfVWADiu1QnYIwVkFpHz0JRRQExXjCQUaLKIu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSY2c1zH7cnplNjy4O8M6izJCiDF3tFcAMm6IxuVr1s6+PLbBR2JFU0DdwL2uW1xTeoPzkQj062or0/778A2Ev2f6y39W4jj8FejQKl8F+VoWCA7Zr/uoa5OWuitT2Jt1y53mYaxFOaDF07aZp7SozWi42LgbGQ75D0OglrXUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReaEsB3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD135C4AF09;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360237;
	bh=dEWKHLfVWADiu1QnYIwVkFpHz0JRRQExXjCQUaLKIu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ReaEsB3EaPR8rmbNzY8yX+QZaDj8KFP9YwWt92J1LaIkjgdPF2joJJ0QeLHWp9uP5
	 v+H+0DEBvxu3K2lonwCt/eYovGH0SrCgpRLdZIrnfthA3CT0KneF4Wq8FBsfKj7Y25
	 8NVZqQ/IaNXs/DDDXECVu2UYSJEk1lioARIzJfnYN3csGsd43ZcNP5LjJ3AU7yf4th
	 1JN7A9Cu4RDHqsfz1NQs7+juNduFCA2rLlJqFpgZyrkDosJyJo372su50rMvGoXUZs
	 bO/70xbzatLXMYAvtx4rN7pyobwzuivuhqDs5naqeANKdDXTGEBye3yRAkdsW1jt2v
	 amJG+//KqUXMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29A4C7EE30;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 01 Jul 2025 10:56:44 +0200
Subject: [PATCH 3/6] docs: Add awk section for ucount sysctl entries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-jag-sysctldoc-v1-3-936912553f58@kernel.org>
References: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
In-Reply-To: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
To: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=dEWKHLfVWADiu1QnYIwVkFpHz0JRRQExXjCQUaLKIu4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGhjoup1BoiQAVRdV9XfCUFoG/uF/frNFIkXC
 i+CR4U02T0/dYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoY6LqAAoJELqXzVK3
 lkFPVIAL/0vcTuIFspDtPyHHqoflZX6qS//pVY7/KpYONXZz54qbFsOYcvHsalOcGGRbEyeFThS
 KJkmT1iH2UU8KpuV8wdyHxS7BuJkSGBSCI06dqU1E7NuggI1xdSqJzpj3aj65vbrlVSF/Fw4ysg
 m+ooQgPBmxB2EjAFIL5ymNSvmEeLOtXCj8tpZf992bh3HlVjEWT0I76FstxyqDEDuKAZoeB32vC
 sre7GB8OXb8ePKNLeiICC7ntminZexu5r6dm1FWu2RRfiwx172eK9+/mKSKGfIqXJDe96/zEgC/
 Ml3+i5C5zmoqqfjW8lgE/2Ey7ipB0efkUsUJvJNg40jcITxfeIhDSs8Tj3fzqPpCSdttwqc9DPk
 E8ScOJWN71+ny43P1VI7brgjJbjWztK8I/IPYJfuqATg7tOoDH6lEP5wH/V2xM3pNIRWQMMb3NY
 Hqs/UfkRALjcAXdH/gnssypUCpgQYVLzUM89LnLP3wx67tTwqi2o1ENGRLrQaVG7hk5Cjg37hS6
 Yc=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Adjust the sysctl table detection to include the macro pattern used for
the ucount ctl_tables. This prevents falsly assigning them as
non-documented ctl_tables

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/check-sysctl-docs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 568197cb1c0a84147785f05aabbbc6ab9dd896bc..3166012b9c6ea4435dc77afaadcff3a4944b1ca8 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -130,6 +130,14 @@ curtable && /\.procname[\t ]*=[\t ]*".+"/ {
     file[curentry] = FILENAME
 }
 
+curtable && /UCOUNT_ENTRY.*/ {
+    match($0, /UCOUNT_ENTRY\("([^"]+)"\)/, names)
+    curentry = names[1]
+    if (debug) print "Adding entry " curentry " to table " curtable
+    entries[curtable][curentry]++
+    file[curentry] = FILENAME
+}
+
 /register_sysctl.*/ {
     match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *, *([^,)]+)/, tables)
     if (debug) print "Registering table " tables[3] " at " tables[2]

-- 
2.47.2



