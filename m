Return-Path: <linux-fsdevel+bounces-57578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DBB23A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785F61B6348B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25B2D0630;
	Tue, 12 Aug 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ4YARpg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DF7080E;
	Tue, 12 Aug 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031108; cv=none; b=J1+GvO+ulzWrCyNURjtYPL2UBC2tyr2gO6325MgxF0N8f0F3+l3bnGqxgbzZvSdlcMTL07Bk3SqRJQrcswdSdE8lH8e9OzYCUgZfkHGNdbQYLNVfCvQHcbj6ru151Wdp9ZVGYOi1C4H6MegUbhfCFjsvrqWsmGoL4EgM9MaPHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031108; c=relaxed/simple;
	bh=MOrpQZhreUubPx+rC1Q7y6y80hHcEBKe4ubj1Szw8ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQMfdyt6RaYDK0sGIf6c9H1qsVc6hDxrhEGPPms2a6FccYBbICZZUfK5RqGc6E4s9dVu8TzJVoeYWmYJC6S4ap8cHKH+XagPlWl5IHzuk/I9QjFo9g4IxpkOnWBq+UCsPRJPh0vkdB+WFWi/k7StWKrw2MiOadPvCKd8XpIWB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ4YARpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD9C4CEF0;
	Tue, 12 Aug 2025 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755031108;
	bh=MOrpQZhreUubPx+rC1Q7y6y80hHcEBKe4ubj1Szw8ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQ4YARpgtlJySyXSMgJf5M7MJO0kz9T7qTfye28oMqj/ZVC51SG2G7JdAW1ZY8VH8
	 0ZCTiS+9BIIB+el6pUanxHCvQH0kVSmiet4jhE3pPh37m/d2WYE0JCccUIks0OT9T9
	 NT02lKz69SEJwVKZzLc4kQp+zWsbcPvhOojmX5TKtEc4Sfr8Ry+uEfyzZU7OAcv9aN
	 mjKGjtUOw38wSWushQkhb0JpwfHTQ7199Ei8yMHSXy8gaA4Io4oxrN4aFkoMIw/9Ni
	 exJTLzr97zUn5aMvBfTAsUo4gowDlhN8ydNYI2l0Bw00DeTBsXaZ32u+JmrbSeydyE
	 ZEVBM+dTqRkCw==
Date: Tue, 12 Aug 2025 14:38:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net,
	malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <aJumQp0Vwst6eVxK@kbusch-mbp>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
 <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
 <aJukdHj1CSzo6PmX@kbusch-mbp>
 <46cndpjyrg3ygqyjpg4oaxzodte7uu7uclbubw4jtrzcsfnzgs@sornyndalbvb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cndpjyrg3ygqyjpg4oaxzodte7uu7uclbubw4jtrzcsfnzgs@sornyndalbvb>

On Tue, Aug 12, 2025 at 04:31:53PM -0400, Kent Overstreet wrote:
> If you're interested, is it time to do some spec quoting and language
> lawyering?

If you want to start or restart a thread on the block list specificaly
for that topic, then sure, happy to spec talk with you. But I don't want
to chat on this one. I just wanted to know what you were talking about
because the description seemed underhanded.

