Return-Path: <linux-fsdevel+bounces-3497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302787F54E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A1B20CEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF021378;
	Wed, 22 Nov 2023 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA842135B;
	Wed, 22 Nov 2023 23:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B994DC433CA;
	Wed, 22 Nov 2023 23:39:58 +0000 (UTC)
Date: Wed, 22 Nov 2023 18:40:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] eventfs: Some more minor fixes
Message-ID: <20231122184015.79be22ef@gandalf.local.home>
In-Reply-To: <20231122141925.GE1733890@perftesting>
References: <20231121231003.516999942@goodmis.org>
	<20231122141925.GE1733890@perftesting>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 09:19:25 -0500
Josef Bacik <josef@toxicpanda.com> wrote:

> On Tue, Nov 21, 2023 at 06:10:03PM -0500, Steven Rostedt wrote:
> > Mark Rutland reported some crashes from the latest eventfs updates.
> > This fixes most of them.
> > 
> > He still has one splat that he can trigger but I can not. Still looking
> > into that.  
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks Josef!

-- Steve


