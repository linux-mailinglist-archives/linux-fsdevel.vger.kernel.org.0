Return-Path: <linux-fsdevel+bounces-6366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45241817519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9161F24F54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9A4FF94;
	Mon, 18 Dec 2023 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOMeOA7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEC4FF73;
	Mon, 18 Dec 2023 15:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5047CC433CB;
	Mon, 18 Dec 2023 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702912674;
	bh=xLnl+QFLA3msEEnMJPaZa7+UDyvcsjtqOWnz+2nCd5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOMeOA7g/ktUeBIH43fOIxAH2BaPOGFQPofE+KLsTHNYSfqb/vknUitiJimUJXMtU
	 O03ss4P2txsg/As0TORMvP0twd1IexUnA6LzwtY5X8iuQSQFYleu85gmMF+pD3vEc3
	 ZSjfskH5kIxHuu3amc+ViLhLx+355k1njZLxGCWYnUr3ndxhaXTxdHHgL1ey4X3HBC
	 9klYlh107KPRymMTX8QBNqrrihFe/kj2IgAIyRjtRRZx7uUFKI1Z58fV+iPFYcD+Es
	 TTXXnQ3CO7EJOlubR9nxaXKmxZbAda7eOfwc1V9TNDyQeu0tvtQzmvTiYOmTIIz0hX
	 zDtCiR3PAyKPA==
Date: Mon, 18 Dec 2023 16:17:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, hu1.chen@intel.com,
	miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com,
	mikko.ylinen@intel.com, lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
Message-ID: <20231218-einnehmen-hufen-822b38b4c94e@brauner>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAHk-=whzaCCucr9odvFWcWr72nraRgejD90Nwb2tP8SBE2LTQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whzaCCucr9odvFWcWr72nraRgejD90Nwb2tP8SBE2LTQw@mail.gmail.com>

> I just removed the CONFIG_DEBUG_CREDENTIALS code, because the fix for

I noticed this yesterday. Thanks for getting rid of this stuff. I never
understood who was supposed to use this for what.

