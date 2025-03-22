Return-Path: <linux-fsdevel+bounces-44761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59728A6C88E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183D83B9A0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EC1E0E13;
	Sat, 22 Mar 2025 09:12:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58218A6D3;
	Sat, 22 Mar 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742634779; cv=none; b=rp1rqUaTeWG4jJWbHs1mo+akIyxQ8mPhaj1Peu91XMQHc7t6fs1pbeBZyUlKH/RI31PgQL5Fe2HT8deCoADssG6RiuccBdeKvbf3ZNAQlQ4iXhIToRRSOr9L6jyF//pqFf3nhr5Gt0y1fo0V3T6x5BmYZnHqRTO9JVG2tq1dYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742634779; c=relaxed/simple;
	bh=4K67r3wb1PpsvrxGDKF3+Lbz9BIPlocldztEP7J6LO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQRZONyLmW0aBHuyxj4GsAErx3HlfQ6chJgpt2n9kh0+r1+bjTBgX8XtJd4P/1XOCADsHoWZLNFdRHsj1QodpqcXO8Q7tlO21UaLGv8fyciU7PsQv88y1mRGSLm+QnZZaxM5l1dwh3wojxufqchtUKh2UApLBXdR5m1xTsPMxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024BCC4CEDD;
	Sat, 22 Mar 2025 09:12:55 +0000 (UTC)
Date: Sat, 22 Mar 2025 05:12:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 4/5] stack_tracer: move sysctl registration to
 kernel/trace/trace_stack.c
Message-ID: <20250322051251.6567bb44@batman.local.home>
In-Reply-To: <20250313-jag-mv_ctltables-v3-4-91f3bb434d27@kernel.org>
References: <20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org>
	<20250313-jag-mv_ctltables-v3-4-91f3bb434d27@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 17:22:26 +0100
Joel Granados <joel.granados@kernel.org> wrote:

> Move stack_tracer_enabled into trace_stack_sysctl_table. This is part of
> a greater effort to move ctl tables into their respective subsystems
> which will reduce the merge conflicts in kerenel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  include/linux/ftrace.h     |  2 --
>  kernel/sysctl.c            | 10 ----------
>  kernel/trace/trace_stack.c | 22 +++++++++++++++++++++-
>  3 files changed, 21 insertions(+), 13 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

