Return-Path: <linux-fsdevel+bounces-53453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2EEAEF209
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AFB7AEE7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C126E6FD;
	Tue,  1 Jul 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ODeEEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A81FDD;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360238; cv=none; b=YBVGXakol41zZdpH4KRTTfuC8kyeH2VPDsb4BdWxbiBtf/FRDu+ktx47K/3DO1LwIJVQ5aLcirzjK6gBVAnt8Ms/RIornh9jQCXobFnO+Jurx4G6qEs7m4GC4IJGPOFt4AAi/p8UaqPbjz5HhFbuQInQmO5eWBywFY8gL3D1wIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360238; c=relaxed/simple;
	bh=WZgQ14D22dPLNcKEi9IjqUPAXlhupD02zXCi6Noet+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuaSUXeoaFR3m+3bWjfwYzk/WYc+/DioS1iL6MfuYc7FYoFMl+WbuzhGhltgbWeFiIwVFiFUXDQSqMlcxH9XZfXWZ730VvwIjFNWC3GR/I9MDze7hGP0LSVeLC1yDlOcDRvbYe3qXQ6n0OtLEZYLUIVxyRrWhxa52SutbJwFbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ODeEEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06881C4CEFB;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360238;
	bh=WZgQ14D22dPLNcKEi9IjqUPAXlhupD02zXCi6Noet+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J2ODeEEgPNRDu9oYlBwdaulZ8f/3Ww5Kk8nUVcACl0lyxIWOq+C/F3UiWDFWJMfEs
	 qmMj5jjkM5McIu4DeeV+9/Wdmg3f6Fe1JUKFpu10Fp0gVuCFe+ToHWKZbe8sVawX1w
	 byhS/y3cnV0ir+h0ZV1cP1cD4on9v0P6HM4oCiqMRgKHqWcf673UHhTDoz2tTVrCnw
	 76BI6mYQtpnl3aa6hrEq/84gz2YEsTPXjzGjxDszyjBuMAivuPWvsUal1uY2alEabK
	 obhrKcGhqsdLTTN0cpBcJ2Vxb7WcK6JzG8m9gigEnRkOeUqC6iJh3de3iM1k+0KEC2
	 OUWyGX7N4ilgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F045BC8303D;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 01 Jul 2025 10:56:46 +0200
Subject: [PATCH 5/6] docs: Replace spaces with tabs in check-sysctl-docs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-jag-sysctldoc-v1-5-936912553f58@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6467;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=WZgQ14D22dPLNcKEi9IjqUPAXlhupD02zXCi6Noet+Y=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGhjouvcIQVcgTjcMwYVUzjN9clCy+sHEF9p5
 hcxDDX/MlPGXokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoY6LrAAoJELqXzVK3
 lkFPCLgL/0lRvZ0dCLUwkAUFUrId8D+HSxIbi5ts9LpkVtQN+/aLjDaApT5YXFq0LvXbe7+mGXF
 chBdiVr0jGNHhpELcWG5iXprYpknA2Ef0xPSNy/FEjuAymi4UFZuxSHwzfUZmytK/dyrodTb8oM
 j84G7XarKoIMoD8owzE8lI8n6O8BZ3u4C83ry8tepNb3DPYLA5HO7Dc/wcxTdrpc+sat11Vyg3S
 egynAQEAPwKaWvl2jkiZs7yJ8abu1jBagkLlFkcHi1K0r4TDeYl2GsjM7lu7aRNKcYXo8kXdPhu
 o0JiBR/V3vn4kmxpBX/sKDEHSfymiLrg2cGF28Q82vUVQod/lFPmLv9YijvgXRQt3jrurLAvQOy
 0CFHlL1pTRaGINjgYDR74msCNjQtwWQ4OWAXAMaZNiCqcXu4w2dQfpo292e8loG23FwWq7Onte1
 Iocgogu1KdbcEKBPjlPLGqh1AsbOCxy70cbzHq+vPwncrQDhzJUas7/ADAPU6oCpH9zLfx1r6F6
 kU=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove the combination of spaces and tabs in favor of just tabs.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/check-sysctl-docs | 163 +++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 82 deletions(-)

diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 3166012b9c6ea4435dc77afaadcff3a4944b1ca8..910fd8a9a2684aa709c1572e24fc94d52b093381 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -13,10 +13,10 @@
 # Specify -vdebug=1 to see debugging information
 
 BEGIN {
-    if (!table) {
+	if (!table) {
 	print "Please specify the table to look for using the table variable" > "/dev/stderr"
 	exit 1
-    }
+	}
 
 	# Documentation title skiplist
 	skiplist[0] = "^Documentation for"
@@ -43,23 +43,23 @@ BEGIN {
 
 # Remove punctuation from the given value
 function trimpunct(value) {
-    while (value ~ /^["&]/) {
-	value = substr(value, 2)
-    }
-    while (value ~ /[]["&,}]$/) {
-	value = substr(value, 1, length(value) - 1)
-    }
-    return value
+	while (value ~ /^["&]/) {
+		value = substr(value, 2)
+	}
+	while (value ~ /[]["&,}]$/) {
+		value = substr(value, 1, length(value) - 1)
+	}
+	return value
 }
 
 # Print the information for the given entry
 function printentry(entry) {
-    seen[entry]++
-    printf "* %s from %s", entry, file[entry]
-    if (documented[entry]) {
-	printf " (documented)"
-    }
-    print ""
+	seen[entry]++
+	printf "* %s from %s", entry, file[entry]
+	if (documented[entry]) {
+		printf " (documented)"
+	}
+	print ""
 }
 
 
@@ -71,105 +71,104 @@ FNR == NR && /^=+$/ {
 		}
 	}
 
-    # The previous line is a section title, parse it
-    $0 = prevline
-    if (debug) print "Parsing " $0
-    inbrackets = 0
-    for (i = 1; i <= NF; i++) {
-	if (length($i) == 0) {
-	    continue
+	# The previous line is a section title, parse it
+	$0 = prevline
+	if (debug) print "Parsing " $0
+	inbrackets = 0
+	for (i = 1; i <= NF; i++) {
+		if (length($i) == 0) {
+			continue
+		}
+		if (!inbrackets && substr($i, 1, 1) == "(") {
+			inbrackets = 1
+		}
+		if (!inbrackets) {
+			token = trimpunct($i)
+			if (length(token) > 0 && token != "and") {
+				if (debug) print trimpunct($i)
+					documented[trimpunct($i)]++
+			}
+		}
+		if (inbrackets && substr($i, length($i), 1) == ")") {
+			inbrackets = 0
+		}
 	}
-	if (!inbrackets && substr($i, 1, 1) == "(") {
-	    inbrackets = 1
-	}
-	if (!inbrackets) {
-	    token = trimpunct($i)
-	    if (length(token) > 0 && token != "and") {
-		if (debug) print trimpunct($i)
-		documented[trimpunct($i)]++
-	    }
-	}
-	if (inbrackets && substr($i, length($i), 1) == ")") {
-	    inbrackets = 0
-	}
-    }
 }
 
 FNR == NR {
-    prevline = $0
-    next
+	prevline = $0
+	next
 }
 
 
 # Stage 2: process each file and find all sysctl tables
 BEGINFILE {
-    delete entries
-    curtable = ""
-    curentry = ""
-    delete vars
-    if (debug) print "Processing file " FILENAME
+	delete entries
+	curtable = ""
+	curentry = ""
+	delete vars
+	if (debug) print "Processing file " FILENAME
 }
 
 /^static( const)? struct ctl_table/ {
-    match($0, /static( const)? struct ctl_table ([^][]+)/, tables)
-    curtable = tables[2]
-    if (debug) print "Processing table " curtable
+	match($0, /static( const)? struct ctl_table ([^][]+)/, tables)
+	curtable = tables[2]
+	if (debug) print "Processing table " curtable
 }
 
 /^};$/ {
-    curtable = ""
-    curentry = ""
-    delete vars
+	curtable = ""
+	curentry = ""
+	delete vars
 }
 
 curtable && /\.procname[\t ]*=[\t ]*".+"/ {
-    match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
-    curentry = names[1]
-    if (debug) print "Adding entry " curentry " to table " curtable
-    entries[curtable][curentry]++
-    file[curentry] = FILENAME
+	match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
+	curentry = names[1]
+	if (debug) print "Adding entry " curentry " to table " curtable
+	entries[curtable][curentry]++
+	file[curentry] = FILENAME
 }
 
 curtable && /UCOUNT_ENTRY.*/ {
-    match($0, /UCOUNT_ENTRY\("([^"]+)"\)/, names)
-    curentry = names[1]
-    if (debug) print "Adding entry " curentry " to table " curtable
-    entries[curtable][curentry]++
-    file[curentry] = FILENAME
+	match($0, /UCOUNT_ENTRY\("([^"]+)"\)/, names)
+	curentry = names[1]
+	if (debug) print "Adding entry " curentry " to table " curtable
+	entries[curtable][curentry]++
+	file[curentry] = FILENAME
 }
 
 /register_sysctl.*/ {
-    match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *, *([^,)]+)/, tables)
-    if (debug) print "Registering table " tables[3] " at " tables[2]
-    if (tables[2] == table) {
-        for (entry in entries[tables[3]]) {
-            printentry(entry)
-        }
-    }
+	match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *, *([^,)]+)/, tables)
+	if (debug) print "Registering table " tables[3] " at " tables[2]
+	if (tables[2] == table) {
+		for (entry in entries[tables[3]]) {
+			printentry(entry)
+		}
+	}
 }
 
 /kmemdup.*/ {
-    match($0, /([^ \t]+) *= *kmemdup\(([^,]+) *,/, names)
-    if (debug) print "Found variable " names[1] " for table " names[2]
-    if (names[2] in entries) {
-        vars[names[1]] = names[2]
-    }
+	match($0, /([^ \t]+) *= *kmemdup\(([^,]+) *,/, names)
+	if (debug) print "Found variable " names[1] " for table " names[2]
+	if (names[2] in entries) {
+		vars[names[1]] = names[2]
+	}
 }
 
 /__register_sysctl_table.*/ {
-    match($0, /__register_sysctl_table\([^,]+, *"([^"]+)" *, *([^,]+)/, tables)
-    if (debug) print "Registering variable table " tables[2] " at " tables[1]
-    if (tables[1] == table && tables[2] in vars) {
-        for (entry in entries[vars[tables[2]]]) {
-            printentry(entry)
-        }
-    }
+	match($0, /__register_sysctl_table\([^,]+, *"([^"]+)" *, *([^,]+)/, tables)
+	if (debug) print "Registering variable table " tables[2] " at " tables[1]
+	if (tables[1] == table && tables[2] in vars) {
+		for (entry in entries[vars[tables[2]]]) {
+			printentry(entry)
+		}
+	}
 }
 
 END {
-    for (entry in documented) {
-	if (!seen[entry]) {
-	    print "No implementation for " entry
+	for (entry in documented) {
+		if (!seen[entry])
+			print "No implementation for " entry
 	}
-    }
 }

-- 
2.47.2



