Return-Path: <linux-fsdevel+bounces-1252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D07D85E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0D28207F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308C134CE8;
	Thu, 26 Oct 2023 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ceSji+GR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB342DF66
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DAC433C8;
	Thu, 26 Oct 2023 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1698333796;
	bh=KJS2k1u4DDMw0/b0buiBWZM6zr1OPS6aOkhpGbQXye8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ceSji+GR/3DQAcdtE6H9wWp22qc4NvverisA9Ztwi69e9e4n25Ozw1cqokNGNXakU
	 oNXIePJO4AI0jcLXVF67vxfZK6mZ9qGWNRxE09/3GneWky6VY7v+jU07Z63KZ9qz5c
	 yVT6/ykSaiYJMKHpewmF5coyhy5FtJcG2tpiF4QY=
Date: Thu, 26 Oct 2023 08:23:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fs: Remove unneeded semicolon
Message-Id: <20231026082315.fd432f07d9db32642f78aeac@linux-foundation.org>
In-Reply-To: <20231026150334.GA13945@redhat.com>
References: <20231026005634.6581-1-yang.lee@linux.alibaba.com>
	<20231026150334.GA13945@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 17:03:35 +0200 Oleg Nesterov <oleg@redhat.com> wrote:

> On 10/26, Yang Li wrote:
> >
> > @@ -3826,7 +3826,7 @@ static struct task_struct *first_tid(struct pid *pid, int tid, loff_t f_pos,
> >  	for_each_thread(task, pos) {
> >  		if (!nr--)
> >  			goto found;
> > -	};
> > +	}
> 
> Ah, I forgot to remove this semicolon :/
> 
> This is on top of
> 
> 	document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
> 
> perhaps this cleanup can be folded into the patch above along with Yang's sob ?

The above is in mainline, so no squashing.  I added your acked-by.

