Return-Path: <linux-fsdevel+bounces-43752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D2A5D400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 02:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1945F3AE550
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB0113774D;
	Wed, 12 Mar 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSuwI+ue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F92C182
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742564; cv=none; b=D7hwGrL+YmUXohU9r4ggzPDkrGkBo+aVd1WHEyLsTugwJog3HWMmt95YyJHRfalxIkai33neyTKxDnv7HVv30XoMGMwEn6aj33Cu+wW79UkAOWfELa6BFjeWRlNErbDgi0VTpsPuEVCgxYn+4tshN7RdjgkE3yRQO7gn8dLq7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742564; c=relaxed/simple;
	bh=zmNim0dctvfuEGmbNDy9LxXIRA1vynbumloK6EoX7OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvQ8DQ2Dn8wFCJxO5qLlGluIxNrK55EZMLBhmGPYGLe8fwrkzwVuomIHXpu/ou3zjgySrLoZfMKTpVvijoVDlhF2mjTjFbslNFJa6xXvchJ6I56dTrGutRRZ0WU/yPzbaL/RMTU54ZLEyFQhkoJVSKQmQLY8koBwWARm8m7jxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSuwI+ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D771C4CEE9;
	Wed, 12 Mar 2025 01:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741742563;
	bh=zmNim0dctvfuEGmbNDy9LxXIRA1vynbumloK6EoX7OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSuwI+ueQbilvaQvmASkAI9XTb2Uy8RGLqyyoqUD4PFKsmLVVd5MQbgxUQsZgwLT+
	 NGUC4BLxxVBttJ+Ukw3iumO/DXAkiO63/sVi/s6gArWhDVseggV3ShLYP3lhwYT0Mg
	 QSZ71aO1G3HXRCSC2RViynSMigPMlWj3+6sxQVYIEkppIpeHA7yeuawPIEMQoTvXYg
	 TZ81b2JpzqHwNO079lp7eyrVaBpVBgwuVejL11APq8WQ4QVVjDVZBjOCTHGK2xQNwT
	 4ZNu4oCG1ID2QJDmWQjlGbgZKcGHSXiB93rRqCFlpficQeapbldc919L9VvaEl3T33
	 TybhysWLI5tFA==
Date: Wed, 12 Mar 2025 01:22:41 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: patchwork-bot+f2fs@kernel.org, chao@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z9Dh4UL7uTm3cQM3@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9DSym8c9h53Xmr8@casper.infradead.org>

On 03/12, Matthew Wilcox wrote:
> On Tue, Mar 11, 2025 at 07:50:38PM +0000, patchwork-bot+f2fs@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to jaegeuk/f2fs.git (dev)
> > by Jaegeuk Kim <jaegeuk@kernel.org>:
> 
> Thanks!
> 
> FWIW, I have a tree with 75 patches in it on top of this that do more
> folio conversion work.  It's not done yet; maybe another 200 patches to
> go?  I don't think it's worth posting at this point in the cycle, so
> I'll wait until -rc1 to post, by which point it'll probably be much
> larger.

Ok, thanks for the work! Will keep an eye on.

