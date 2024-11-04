Return-Path: <linux-fsdevel+bounces-33624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA49BBA66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7792B2813DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912501C232D;
	Mon,  4 Nov 2024 16:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74020326;
	Mon,  4 Nov 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738117; cv=none; b=Xncj0tbQdDHPIOe3L4FDEjz4xPxiZE76p72pOM2O/4YV2IbxK3FI5HHnQcJCUOB5e5xJM4IIb8PFReyEMaQsltuk4T2MoyiLQ8jD6b8KVfdBzn0EY7J+Iat9kBBzE6OipG/BzDhwzCkfYjraQ+XhbAic2MqQZsxaCqx4GXG0/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738117; c=relaxed/simple;
	bh=v8GPTNdK9xwTaNw72WfjxXu3vHLVXKrJ8w8nWc8DIwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9SiA5doD1qYt54qq115Cd5N0CeQP5Q9HxGgNxG/oOAeUR4bqny3Qs3pCluT3cV4EsbsPGznHr0MQoDLhPfnYJDUqfYLisYmJGkSJ5ySnzcpiIqkUp1GwPLm2o2jNXqk9iVnioELlwKUKf4LoeLmm9XdpLFlrhDwCZcpUsDhQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF91C4CECE;
	Mon,  4 Nov 2024 16:35:15 +0000 (UTC)
Date: Mon, 4 Nov 2024 11:35:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <mcgrof@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kernel: add pid_max to pid_namespace
Message-ID: <20241104113514.10625a03@gandalf.local.home>
In-Reply-To: <20241104005408.1926451-1-yun.zhou@windriver.com>
References: <20241104005408.1926451-1-yun.zhou@windriver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 08:54:08 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> It is necessary to have a different pid_max in different containers.
> For example, multiple containers are running on a host, one of which
> is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> it requires the global pid_max <= 65535. This will cause configuration
> conflicts with other containers and also limit the maximum number of
> tasks for the entire system.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

I acked the first patch. You don't mention what's different about this one
(which is something you should do below the '---' line and above the diffstat.

Like:

Changes since v1: https://lore.kernel.org/all/20241030052933.1041408-1-yun.zhou@windriver.com/

- Describe what is different.

What changed? Is it big enough for me to re-review this one so that my ack
needs to be reevaluated?

-- Steve

