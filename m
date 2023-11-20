Return-Path: <linux-fsdevel+bounces-3210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72D37F162A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8153C1F23D6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419831D52C;
	Mon, 20 Nov 2023 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLU8an3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6F1D521
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 14:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC503C433C8;
	Mon, 20 Nov 2023 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700491689;
	bh=VlaZlLpDKTsbSQFJsQLB6VdLfoON/7etXt06BTWC2PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLU8an3R4mj1EbNoc1TmkBS85vJz41IjiP4FbcUkONErWbBchHzj1hgS+HmlPQDt6
	 30FwmwiU2QaVm54fIWAXFQe6o3XqKrDHHfx1dZ8hZsDHL63Qy5IVz2a+TqNQwOpJCD
	 saZ3EDM2Lps1fG7arDxfGd3AyXCzL9b3AuNaxm9zFgdI/F6XCkgl6OsbBjl538C4AE
	 KcDUW6FXx/rhygcN2XYqk3c4FwCgeex6P2ohWhPSKcMZhXTXcICdn8z6v8XSKDi4iW
	 wOIP3CQdupCdpqM0oHbvraznNJyEykR/UN555Jo3m4jZLD705QOOPuS3tR8R8+ldNY
	 8zwC/FA6gMFMA==
Date: Mon, 20 Nov 2023 15:48:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, Tavian Barnes <tavianator@tavianator.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v4] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231120-dazugeben-telefon-b28f4aa6be11@brauner>
References: <170043792492.4628.15646203084646716134.stgit@bazille.1015granger.net>
 <20231120-lageplan-grinsen-25b44b4fac10@brauner>
 <AF3760DC-EF1A-49DC-BE24-6EEFDAA11E90@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AF3760DC-EF1A-49DC-BE24-6EEFDAA11E90@oracle.com>

> You mean this one?

No, there had been another one about readdir specifically that was sent
to me.

