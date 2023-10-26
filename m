Return-Path: <linux-fsdevel+bounces-1251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C37D8595
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCC41C20D85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B52F507;
	Thu, 26 Oct 2023 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP/h0Aqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B472E404
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F534C433C8;
	Thu, 26 Oct 2023 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698332884;
	bh=VqXDsdvKgWVcI6gCnms2OyrbuxjN6ozmecLBnQ9oQYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OP/h0AqfPQzeXetRSb/ZQX5maa+ICp3w7gdakpOjABJ3q65Np/7+DAYUUh1W3lUpT
	 lE0G5CgxWtHqbcXYiIMxrzn0ylvFTU6VcsaKDJSgRTlfSbRckDZ4FLLGbdIXWbrTZP
	 I/AGGg0wNrNMS6TL7qHesNiL7SVgclvHt8FtPMi8DFaI2ZLGrSJEfe8xyHsvhYz6Iw
	 V0UZ4GLXjB27NcvSjO85XAlpbSXKz+42kQFbhygKOT5t5SztJXqxOfES9zjyjyUKfN
	 2P8h2xQ9+cxQ4ABCfE6tIkk3ea2uH+2QibgknkMGmHdCRl/lVWTGqDOxK6bGLruSJx
	 aPGn4LIF7dI9w==
Date: Thu, 26 Oct 2023 17:08:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231026-zugreifen-impuls-15b38acf1a8c@brauner>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231025172057.kl5ajjkdo3qtr2st@quack3>
 <20231025-ersuchen-restbetrag-05047ba130b5@brauner>
 <20231026103503.ldupo3nhynjjkz45@quack3>
 <20231026-marsch-tierzucht-0221d75b18ea@brauner>
 <20231026130442.lvfsjilryuxnnrp6@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026130442.lvfsjilryuxnnrp6@quack3>

> your taste it could be also viewed as kind of layering violation so I'm not
> 100% convinced this is definitely a way to go.

Yeah, I'm not convinced either. As I said, I really like that right now
ti's a vfs thing only and we don't have specific requirements about how
devices are closed which is really nice. So let's just leave it as is?

