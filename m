Return-Path: <linux-fsdevel+bounces-7724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E772A829E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91420B2533B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF04C626;
	Wed, 10 Jan 2024 16:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9A1138F;
	Wed, 10 Jan 2024 16:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4340C433F1;
	Wed, 10 Jan 2024 16:03:08 +0000 (UTC)
Date: Wed, 10 Jan 2024 11:04:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240110110408.13b3f107@gandalf.local.home>
In-Reply-To: <20240110105251.48334598@gandalf.local.home>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
	<20240110080746.50f7767d@gandalf.local.home>
	<20240110105251.48334598@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 10:52:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll apply this patch too, as it appears to work with this code.

I meant "appears to work without this code".

-- Steve

