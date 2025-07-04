Return-Path: <linux-fsdevel+bounces-53900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBFAF892C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CF81C45F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4B279DD5;
	Fri,  4 Jul 2025 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="tQon3CxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A40277818
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613799; cv=none; b=tTdnkb8J1dSgeyI9URS81/bnBws/gBMUipzq/nsDhqd762JA0YQTx68LneJpN2BQps2SYp8muaxKWLLQ9YSmEDssEvn+JsDTj1Fs+5JALqHomtsAgdafNbFfW+xi+x2q07CSFa9L4vVgEQia3tA9l6DGgy4R6q+zN9x+Laa2wDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613799; c=relaxed/simple;
	bh=8+9V/ga/MdCUNSwfdcCRGibrOruQGSdItrYrK412UFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgoccVNzKiq9LSPS8F6yTuZVHfiqXoQrOsBmmRq0H3opr2+6qRBlrMnlDjYEZTFdArOzLPpMgQw0JmzqWRUwUXaZ8q191ZPiQZvmbFHsXhyEn/mQs/gOBj9m1WaChDo7aowPpjAS+z6Xa+9x1A3xNiZrdcU9UXFGZwLtzZ23uY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=tQon3CxJ; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751613793;
	bh=qLtztcG8SjdhwvakcmqX1AXnOof0CO5E07gvNfRESGw=;
	h=From:Subject:Date:Message-ID;
	b=tQon3CxJ67u+0ma5THPsAqg/0IAPyofZmtLKIWo43rti0pvNXIH7jNCIgGfQhT6Pf
	 B+PaN/7NLQodoN69RdBT2SB7QIHekrETQvRuWCmcD0AeWJNI3xO6ywQ7dVo0WpHz12
	 vq6xFFeHEH+FuxdUccYSfOs03v+Nna0c2aHG3ipE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68677CA30000697F; Fri, 4 Jul 2025 15:03:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1953426816158
X-SMAIL-UIID: 6A00FAF2BDAE4B05A5E3791B1CC7DFBA-20250704-150301-1
From: Hillf Danton <hdanton@sina.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kerenl@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Date: Fri,  4 Jul 2025 15:02:46 +0800
Message-ID: <20250704070249.2347-1-hdanton@sina.com>
In-Reply-To: <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf> <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 23:34:11 -0400 Kent Overstreet wrote:
> On Thu, Jun 26, 2025 at 08:21:23PM -0700, Linus Torvalds wrote:
> > On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > per the maintainer thread discussion and precedent in xfs and btrfs
> > > for repair code in RCs, journal_rewind is again included
> > 
> > I have pulled this, but also as per that discussion, I think we'll be
> > parting ways in the 6.17 merge window.
> > 
> > You made it very clear that I can't even question any bug-fixes and I
> > should just pull anything and everything.
> 
> Linus, I'm not trying to say you can't have any say in bcachefs. Not at
> all.
> 
> I positively enjoy working with you - when you're not being a dick, but
> you can be genuinely impossible sometimes. A lot of times...
> 
Now I see why your nostrils are so up, dude, because like Linux dancing
out of the Unix box, you are not so tame. Is it wasting minutes for Elon
to think he is richer than Zucker?

BTW I have some difficulty replying offline mails.

Hillf Danton

