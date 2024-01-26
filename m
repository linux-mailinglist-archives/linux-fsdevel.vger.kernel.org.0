Return-Path: <linux-fsdevel+bounces-9113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24EA83E423
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90346281F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686D24B2D;
	Fri, 26 Jan 2024 21:43:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554C25558;
	Fri, 26 Jan 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305398; cv=none; b=gH+YzlZ3dVc+xF0xALlhx8IVfspWGP2FB/na9V+8cVTJ4BZXQ58+INyQ44fveSlRH6R/tH+89PqsC3oDM9slimE60K0InrQuFZMggDyTRDGxYc9Yax7rRZayofN0GnFOkMdVdDlTmAtEntfk0bo28LD493PSB++9p/5RHXywLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305398; c=relaxed/simple;
	bh=Fz9Z4pjO+81FWe62pdCVvfqRgZSyIsDSLeZIJaQ29sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYTKH3XMA0ssf/n4Qi5UbreSAXB6ku+woNgkExvYInWbrL1MUjm2gt/plWoY3+PBr/j+mnp51XGHQrYTOSPwDDoo3oGU5Z2GPAUKIOtOn+FfgVld9udRRzoeo1TW0MaHkLi/YfQCQlLqG5L91kkDKk60eOKGsLe94SloXSfADRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E4AC43390;
	Fri, 26 Jan 2024 21:43:16 +0000 (UTC)
Date: Fri, 26 Jan 2024 16:43:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240126164315.618b8900@rorschach.local.home>
In-Reply-To: <CAHk-=witahEb8eXvRHGUGDQPj5u0uTBW+W=AwznWRf3=9GhzxQ@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=witahEb8eXvRHGUGDQPj5u0uTBW+W=AwznWRf3=9GhzxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 13:31:01 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> As it is, I feel like I have to waste my time checking all your
> patches, and I'm saying "it's not worth it".

I'm basically done with this. I never said I was a VFS guy and I
learned a lot doing this. I had really nobody to look at my code even
though most of it went to the fsdevel list. Nobody said I was doing it
wrong.

Sorry to have wasted your time

-- Steve

