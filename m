Return-Path: <linux-fsdevel+bounces-29986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C0984A35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE6B24414
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DC1AC896;
	Tue, 24 Sep 2024 17:16:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83D1AB6E4;
	Tue, 24 Sep 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198212; cv=none; b=iJk0JfiHF2CLoZSeSmt9h8/NhpxQT/2lOz3waGyv/9byGOkre6EoKWzHngHf/bZvvvS/3CmeXaJk2EW0JV9jFvzAdvtW64rhlSRGUa7fanHQh8/34aNKgGz0YX4uXmGUuqkO31mblSNJIo/DlzX23Pq4zeS0gw1mtC4VCIgESk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198212; c=relaxed/simple;
	bh=WLBiOoj7pLbXd7gJT8uVffEQAwiEKuUJN/mWVdMPiAE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=u2caq2cTqdcEifgioflpziKwOdWQrodwi+bldPzHzbR9v/IhQfd0TaMWk05RJgLZjw+IN/HM90TQM5ik+1YAp8Dvywa+lNY1p3zTv8VeWiH5UmCOzq/+D6FoP0q9XZAhg11pr53iDKu18Sguru49ue61uejm9JMpOnVN+t7nQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: clm@meta.com, stable@kernel.org, Kairui Song <kasong@tencent.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk,ct@flyingcircus.io,david@fromorbit.com,dqminh@cloudflare.com,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-xfs@vger.kernel.org,regressions@leemhuis.info,regressions@lists.linux.dev,torvalds@linux-foundation.org
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
In-Reply-To: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
Organization: Gentoo
Date: Tue, 24 Sep 2024 18:16:46 +0100
Message-ID: <87plotvuo1.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kairui, could you send them to the stable ML to be queued if Willy is
fine with it?

