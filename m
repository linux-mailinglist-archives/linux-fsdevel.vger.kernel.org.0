Return-Path: <linux-fsdevel+bounces-63032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9FBA944B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB41188545A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B630649E;
	Mon, 29 Sep 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="i7RFtzf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7F26D4DE;
	Mon, 29 Sep 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150997; cv=none; b=ObPYO0P+YF/rPcc7HmFxw0AzRlvG0zZoqFEzaiO8KhbV8NLwMilEpQK1tPYaFcxGzfnNdLg7BQXINP3HpHI4wA3qHB8zvqHGS33A6Y1bXHn45WYKgM3RqNRIKXjHKUxIfx+IVxq30V8kOet+3o4OGgKWpJMgebknKGr7SUAPYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150997; c=relaxed/simple;
	bh=AkqS8F7lbEpAeM7tHdIxRfw+T1UfW2BZADYpPGk18qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIstY/gUImVly2Lvl74ViK0+jFb7cDjsRAxN5p9IcaIhDgEuRP0IxEMNRPTxHo7ymQ6Ti9xPlSNoGf01kdAHOcp7Ib/eNrI1dsyVe14g9+VHxVHcRv3aqUzat84SGcY9vdAL1bQuY8VOp/qE0IZKzkaIfLhwmpUJn79DFR0z4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=i7RFtzf+; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cb1Zb4q5qz9xxB;
	Mon, 29 Sep 2025 15:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759150983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D8tSF7Az1rTHx3Lcvasj7H6lLUnSJZjt0RmacSU+VpY=;
	b=i7RFtzf+dHw6zxp9bpYrSJfJ0KOIzArRIIE/X4otxLVdIynNYXUZ2D2n3J2NtsZA3Wa4X+
	Sb/5kFCtZU8NnFpizOZ9ZKF3SgQjVZqh05NaWhqkZmdiIFnEvIWrkPLRENbHD3bWSek4eO
	9Jcu3C0+nyN+bMUXA2HBf1b1bxIePUFY4WDxEuzJDYgqbPV8tzxS3gmn1Q+SsXgepcTk9C
	XFTsdKl+XS0dz1AzY6xjbLW6vTnZgUpVIor0IcBay7IxnDzSglPmAaDlTecQibt8KjbbM0
	XyM1l9sEp0EnSdYHiJM8E6iUiQpxgP6kZ+vtqOsCdI8IKVeQRTvqmuy8ClgL0g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2 0/2] fs: fuse: use strscpy instead of strcpy
Date: Mon, 29 Sep 2025 15:02:44 +0200
Message-ID: <20250929130246.107478-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cb1Zb4q5qz9xxB

Changes in v2:
  - Add a commit to rename 'namelen' to 'namesize', as suggested by Miklos
    Szeredi.

Miquel Sabaté Solà (2):
  fs: fuse: Use strscpy instead of strcpy
  fs: fuse: rename 'namelen' to 'namesize'

 fs/fuse/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--
2.51.0

