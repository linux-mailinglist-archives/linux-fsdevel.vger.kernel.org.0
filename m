Return-Path: <linux-fsdevel+bounces-16707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E06B8A197D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95D51C23E11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD415E5DB;
	Thu, 11 Apr 2024 15:35:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6715E5BA;
	Thu, 11 Apr 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849738; cv=none; b=JsZH16Wby2nE4vKC/8bmvBZvvF+M+cdwl3aPHhKOvrElXdwBhlVJ8n/neBkGn0lz8sLqARON+UR9tEjbauuSNkaXBgvVxY2WHrTCXqn4ihr4SJGCzw+sTuei3qlrUEoGMfnp66sUApuQMI2R7ohFeioEEiBCnLX98snP2DawPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849738; c=relaxed/simple;
	bh=uB0xp+Cz0RemiAN93PY9Tzv4ucfdVhTCk1XXYQuInQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EREJ55XOTasscHN4e50I10QXVQlMEfHEXYyTElKbZ2ThYGYjKpW04wXSr8BgBFWaXFdvs8WOxE7QHv2qQkX+XZ2/FHHP32JOav+qSanKWHRony5OuRssM7s/XtwnVWHBuvkPrQwc5HkcMIqyM+s9mhBeb5i9XBy3tAJ0j3ylRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A549C113CD;
	Thu, 11 Apr 2024 15:35:36 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:38:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Azeem Shaikh <azeemshaikh38@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
Message-ID: <20240411113815.086de275@gandalf.local.home>
In-Reply-To: <202404110814.B219872F76@keescook>
References: <20240411102158.1272267-1-elver@google.com>
	<202404110814.B219872F76@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 08:15:05 -0700
Kees Cook <keescook@chromium.org> wrote:

> This looks good to me. If tracing wants to take it:
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> If not, I can take it in my tree if I get a tracing Ack. :)

You can take it.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

