Return-Path: <linux-fsdevel+bounces-44240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A8A66792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D0B176983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13C1B0402;
	Tue, 18 Mar 2025 03:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9C1A5BBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269326; cv=none; b=Dp8MeSzaf7MFgUK3elkdw9reOaHfTercIk81ZNJXa+kaAzFmxOQdTaSq51djofRUYetzsvgXJsFa3TOJ4xF4IKCQ9YUAQ/qXKQXVLao6vKSYsGJnp4lTJ3+M0c7+a9ZAdgTDIJ8EdowFXljT496xm2ZU2bNfW/KTtE6/l6M/sds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269326; c=relaxed/simple;
	bh=9eJd2c2jI8tonpAzZVV70wU8FI0H8wvqVyfQSv+Q5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoF7Myo1+ZXpnUvXl5TGhxo3/LPwIeS+uhPFER2e2cN8+oUPnCsHd/wLhpVfwYPdmf+7GxH1MmaIk+Z97UC83xEjliRu4LZwOtr7h8U+wYSFtDALmmPS/zO998vpiy/dY/A4EkxS5r5ORQjSMIL/Q5kIeBD5315XtuftZSbcRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnxO012168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F21AF2E011A; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Remove references to bh->b_page
Date: Mon, 17 Mar 2025 23:41:28 -0400
Message-ID: <174226639137.1025346.16102247341347415028.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213182303.2133205-1-willy@infradead.org>
References: <20250213182303.2133205-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 13 Feb 2025 18:23:01 +0000, Matthew Wilcox (Oracle) wrote:
> Buffer heads are attached to folios, not to pages.  Also
> flush_dcache_page() is now deprecated in favour of flush_dcache_folio().
> 
> 

Applied, thanks!

[1/1] ext4: Remove references to bh->b_page
      commit: a5a1102f81be238f21a1fbff00f6229078d44daf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

