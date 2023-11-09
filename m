Return-Path: <linux-fsdevel+bounces-2514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D837E6B82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644F0B20E97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAA1DFF2;
	Thu,  9 Nov 2023 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSPhxUv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397A10949
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AECFC433C8;
	Thu,  9 Nov 2023 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699537822;
	bh=T8HqaVwPA44pu69xIQ/o4hzEoMTPALmJiuIf9dApJWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSPhxUv96U24CnK0cEYzhsRO7CJOi9yHE8afA+7+mgHkNmH7UtcjTEnYxSTAr1DQm
	 MVVU+BRjT9r0Ua05rJ9kw9hL07chT04ag/kpsEgEVKdBDn3wlTcQAyBSS0VpK9v86l
	 FUg3aeB7oafrsxGAquuvPooUR2konMGUgq1wYXwugtriPx/FbKTq/EpL6ocNN3aHuF
	 OWr0OiogF8Cew1QaSQ9T3BKiWNHHcC2r2bs5Aqjba+jLua5wc9Nw69MVUhnTb9SJBX
	 euj29cSIakMntINLa2JPCYKXO/3NnpspZwxZ4uYRWdAosaGNlgID08AkDvuD19dJoy
	 qEiv9gx+KK6ag==
Date: Thu, 9 Nov 2023 14:50:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/22] get rid of __dget()
Message-ID: <20231109-igelstachel-chaostheorie-44a68a15d9c5@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-6-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:40AM +0000, Al Viro wrote:
> fold into the sole remaining caller
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

