Return-Path: <linux-fsdevel+bounces-50922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D5AD10CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 04:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A0016A4BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363EF1494A3;
	Sun,  8 Jun 2025 02:57:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF502747B;
	Sun,  8 Jun 2025 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749351475; cv=none; b=rrIyq5wpTzGg9h1R/vocIYgKU9xCG4sVNq1ySX7JIVytf6PBbtmyb5RCNpVpAZvtksF+DMdE/hCeIQYpx9CU13xxZ04ghAsRwXwXZ7kyQYseF3dSmABqBODmMYfitQfbxq6ef9PMAzsmVRtVq89WLeMz47mQgkDKhmHTUaORvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749351475; c=relaxed/simple;
	bh=VALUZrUDbsU+wOLqvuGNH4Tg/tq309i5UQ4v+Nxadg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cso4ZCmuMje6JgcCF3Ng1ncC4KV25V6jdlXCb4yl9ZbtE6XneBlEIcKesSIs9jxXQgsS/s7+kZnmgWrvss0apRJK36b92tc5F2NXECSrClRbCJO9q8uiVcunq6VC5P/z6kgFnLxoElr+Ohuva80EDXSI7unOZ09pe2IHw9mZuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <akpm@linux-foundation.org>
CC: <andrii@kernel.org>, <catalin.marinas@arm.com>, <corbet@lwn.net>,
	<david@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<npache@redhat.com>, <tz2294@columbia.edu>, <wangfushuai@baidu.com>,
	<xu.xin16@zte.com.cn>
Subject: Re: [PATCH] docs: proc: update VmFlags documentation in smaps
Date: Sun, 8 Jun 2025 10:57:14 +0800
Message-ID: <20250608025714.93302-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250607142505.e58fda734ce54167724705a3@linux-foundation.org>
References: <20250607142505.e58fda734ce54167724705a3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Thanks for the review. I'll add 'dp' info send v2 shortly.

--
Regards,
Wang

