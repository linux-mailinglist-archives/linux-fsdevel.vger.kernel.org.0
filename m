Return-Path: <linux-fsdevel+bounces-61248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EEB567F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A5B17D59B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884AA24E00F;
	Sun, 14 Sep 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="wbHe2jKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12B2367CE;
	Sun, 14 Sep 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850050; cv=none; b=qm/b5Byowp9LhLHgUBViH1rLT5jbuRoFG29VIzEV7D6TeDYaS4FAmn7ILywTscUb3CNY15J8wG6oEDe5ttBTGNw2MWfveCXnVibC8LA70W9nIsiPt4A3J2rrh/aN6E9+QHSukiVnPEcC49u9anzCkjJ/dRmOfUJr756/lPkzK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850050; c=relaxed/simple;
	bh=adf+i1Dj64f0rWF8ZecSFx5mI3vdOVkHIb4J9PLnWak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2J4HW22aNDiCrpnWoiLYhi5UsHfbOS1bYYBde6de5AfaWWXuetVtHr0KHSAVxxhEs0EEOuj3eMnBYsFYiZGpdttwx+gHj5Tu+JUEoZM0E7S5j7ycp8g3kAP7c4TPkpp2oU8RqDr1qFmfvNjVNXN4rtUCK0+e+K+SZBKr2Sbs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=wbHe2jKu; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cPmSP5pr7z9t7F;
	Sun, 14 Sep 2025 13:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757850037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adf+i1Dj64f0rWF8ZecSFx5mI3vdOVkHIb4J9PLnWak=;
	b=wbHe2jKuTw30yQeP3WlFesd0jkT+JRawbkFr30MwnhnKjpu3h1yXY2IryXo5is1jUU64JP
	fyw8LhXGrg8tuFnlbQTFJTWlbFTPaW8SxdJLnm0gYh9qF4rT0SKJ+hZnekTx5o3jhTb6Mj
	E0v9JcnyKVnaB5RG+6qEGB48zT6FW5OW0gL8N3So9AL2LmFWBw20VtGmN0mCSxYhp/HGk0
	kIl9wWKdNXZCdDTD3+qUcCT6OQhiS6EN8RIC+UMZ5eJq0qJNf12z91khBze8sjiwaaNNfl
	2U8cxqQtBW1caUuQGwxvcxr83vns2LELaK68k6dZPggX7pW1I5wnlHJ/VfVdIw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Sun, 14 Sep 2025 13:40:30 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: alexjlzheng@gmail.com
Cc: hch@infradead.org, brauner@kernel.org, djwong@kernel.org, 
	yi.zhang@huawei.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v4 0/4] allow partial folio write with iomap_folio_state
Message-ID: <mbs6h3gfntcyuumccrrup3ifb2dzmpsikvccu7ovrnsebuammy@if4p7zbtvees>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 4cPmSP5pr7z9t7F

On Sat, Sep 13, 2025 at 11:37:14AM +0800, alexjlzheng@gmail.com wrote:
> This patchset has been tested by xfstests' generic and xfs group, and
> there's no new failed cases compared to the lastest upstream version kernel.

Do you know if there is a specific test from generic/ or xfs/ in
xfstests that is testing this path?

As this is slightly changing the behaviour of a partial write, it would
be nice to either add a test or highlight which test is hitting this
path in the cover letter.

--
Pankaj

