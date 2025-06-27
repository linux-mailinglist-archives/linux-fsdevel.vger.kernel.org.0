Return-Path: <linux-fsdevel+bounces-53165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829DDAEB2EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6730E7A8CA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D418296145;
	Fri, 27 Jun 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWRJpTr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA38293C5B;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016589; cv=none; b=J9EhUN88E4VZ78ELkAvwv8WSz73zGypu+xGLdc2mN05SkxTrjMQSkTI+MVzevo/2Hkys1GyTO4fZM2yRq7xogfnkZlgJSLAnmhNjoVmHDFv9mZkYpaaN9NlgNgro1tYG3+LRTk0H4Tzgl1NEyNMxmeoU4XnJ+9XavTsy83xNi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016589; c=relaxed/simple;
	bh=O0ypzQeGPRlM3z8kh5kwMJv1JvpRZXn0U0UtN6aCpRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nyl37EBIi1Gj/kkES8eoy19d4MclpBkTYYdMlTRCP9gVLAnTl8FClTWhT+kg88enTdRq4u301iwgQf6/bGHOk9CBJ1JTwjCP9NFJ4qww3vAUcOuTes9x6VyG0wbJfo2uTr0euoWNpwNfxHqZRkigXQdcV47hp936g1F2E8I6VaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWRJpTr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 769A1C4CEF0;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016589;
	bh=O0ypzQeGPRlM3z8kh5kwMJv1JvpRZXn0U0UtN6aCpRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LWRJpTr6xyB0I5AbGBLUw3U7w1hsrDqBjpPPkKGGwSwjIIkRbeQ6WpGFIfDUMd8Ad
	 de3TjQPGv89MbJrfN3PtWV7McT+zNfjES4HgC+pwJSXrHv6cN+fhYINl7hQTOALOeb
	 T6aHaapJSlOKpjRuwy3Q/TqeW/YNLXKOVrt7QX9IquU0bnndL6zL045x4QcrnEBl7m
	 OIAtOI8K1Ze261/65df/mju50V9Muq6PK51pdgsGIXOhnuUEBr8bRN7cr1yIItAw4x
	 qqEs4yWhTyKNaYn0MFXYW8S/grZyxVckdsVRCyVAGoS2lYutipGNsHJddRDGTrxxMP
	 L6ZowJ5oYcrIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E401C7EE3A;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 27 Jun 2025 11:27:26 +0200
Subject: [PATCH 2/5] sysctl: Removed unused variable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-jag-sysctl-v1-2-20dd9801420b@kernel.org>
References: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
In-Reply-To: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=685;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=O0ypzQeGPRlM3z8kh5kwMJv1JvpRZXn0U0UtN6aCpRM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGheZIl5s5St2dBl54Hk4RjroiWdqlkUFAugj
 +e0QJdUODMiRYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoXmSJAAoJELqXzVK3
 lkFPcmoL/i14QMIIr0HafzdK8WfZqc/c0dndrNGEcIjJiCNDSitIjcCIRGLqDi93jAbZnRBeXRS
 NbQdw2USHPBqU28c8caCMCSxaXKiWUsUGa8z4HUMY+44793BI8nBTx3yWzpXSBzQyRHcon/7Ceh
 lWeOqlfCLvO7+ql/DyXh2pxiNCEyNFlk98qV5cQl/+toB0vy9m/6m6mrXUjrtePJoQDqAE7bYlU
 35aqjc/a42HM+34l/2UsBYwk9RKhFu15qXBzp0mrUZjNxkcmlRrVea5URZFjcRgoZgFhskKhnxa
 nVhzi34+I+w1+qUXA5icwltS1p8/BlzPkO3tug4t/fLjyJOSsnVnxB+mGzk7VAUmpx/BY4+fJBk
 jwSx9qLcDgS32jj5YhQdGUEF57Iz3KVBIVyEQrT2cHPRekttG0PMx/G4rFG+/MwLEe+QbY6GdiE
 VGwVqaEZPP+AblDsB9O2DnMgZmh3DJb2azCIqpmbX5Hjfj1ylOa8xrH63KiqeoPfVq6is+19pu5
 G8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove unaligned_dump_stack from sysctl.h; it is no longer used or
defined.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 30bcbc59d12d2f4cec7545e7ee3f5ea5f0eefbd7..92e9146b1104123d3dc0ff004bd681861e297581 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -243,7 +243,6 @@ int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *data);
 
 extern int unaligned_enabled;
-extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
 #else /* CONFIG_SYSCTL */

-- 
2.47.2



