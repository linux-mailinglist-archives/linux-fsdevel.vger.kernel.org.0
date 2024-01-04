Return-Path: <linux-fsdevel+bounces-7413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41A8248CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C4E282C9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8092C19A;
	Thu,  4 Jan 2024 19:14:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33092C18C;
	Thu,  4 Jan 2024 19:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C438FC433C7;
	Thu,  4 Jan 2024 19:14:11 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:15:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240104141517.0657b9d1@gandalf.local.home>
In-Reply-To: <20240104182502.GR1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240104014837.GO1674809@ZenIV>
	<20240103212506.41432d12@gandalf.local.home>
	<20240104043945.GQ1674809@ZenIV>
	<20240104100544.593030e0@gandalf.local.home>
	<20240104182502.GR1674809@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 18:25:02 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> Unfortunately, the terms are clumsy as hell - POSIX ends up with
> "file descriptor" (for numbers) vs. "file description" (for IO
> channels), which is hard to distinguish when reading and just
> as hard to distinguish when listening.  "Opened file" (as IO
> channel) vs. "file on disc" (as collection of data that might
> be accessed via said channels) distinction on top of that also
> doesn't help, to put it mildly.  It's many decades too late to
> do anything about, unfortunately.  Pity the UNIX 101 students... ;-/

Just so I understand this correctly.

"file descriptor" - is just what maps to a specific inode.

"file description" - is how the file is accessed (position in the file and
			flags associated to how it was opened)

Did I get that correct?

-- Steve

