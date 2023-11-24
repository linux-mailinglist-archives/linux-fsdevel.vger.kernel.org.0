Return-Path: <linux-fsdevel+bounces-3664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31287F702E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843681F20F78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D416428;
	Fri, 24 Nov 2023 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 01:41:40 PST
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BCD54;
	Fri, 24 Nov 2023 01:41:39 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 536DB81E3F3;
	Fri, 24 Nov 2023 10:36:06 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: d_genocide()? What about d_holodomor(), d_massmurder(),
 d_execute_warcrimes()? Re: [PATCH 15/20] d_genocide(): move the extern into
 fs/internal.h
Date: Fri, 24 Nov 2023 10:36:05 +0100
Message-ID: <10399078.nUPlyArG6x@lichtvoll.de>
In-Reply-To: <20231124074856.GA581958@ZenIV>
References:
 <20231124060553.GA575483@ZenIV> <20231124065759.GT38156@ZenIV>
 <20231124074856.GA581958@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Al Viro - 24.11.23, 08:48:57 CET:
> On Fri, Nov 24, 2023 at 06:57:59AM +0000, Al Viro wrote:
> > > > +extern void d_genocide(struct dentry *);
> > > 
> > > Seriously, who came up with THAT name? "Genocide" is not a nice
> > > term,
> > > not even if you ignore political correctness.
> > > Or what will be next? d_holodomor()? d_massmurder()?
> > > d_execute_warcrimes()?> 
> > kill_them_all(), on the account of that being what it's doing?
> 
> To elaborate a bit: what that function does (well, tries to do - it has
> serious limitations, which is why there is only one caller remaining and
> that one is used only when nothing else can access the filesystem
> anymore) is "kill given dentry, along with all its children, all their
> children, etc."

I never got why in the context of computers anything is ever being killed. 
It does not live to begin with.

You can stop something, remove it, delete it, destroy it, pause it, resume 
it, overwrite it and you can do it really quickly or (almost) instantly or 
slowly or recursively or some combination of those, but kill? You cannot 
kill what does not live. 

d_delete/destroy/remove_recursively() could be a suitable function name. 
Pick one.

Similar it is with the term children or parent. There are no children in 
computer software. Period. But here it may be more difficult to find 
alternative wording. Would still be good to find something, cause I was 
quite taken aback by the wording of the OOM killer. (Actually I was taken 
aback that an operating system could even have something that forcefully 
quits a process without saving data. It never matched my expectations of 
reliability and stability.)

So how about stopping to put meaning into computer software source code 
that simply is not there to begin with? How about starting to use terms 
that describe what is actually being done and what is actually there?

-- 
Martin



