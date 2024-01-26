Return-Path: <linux-fsdevel+bounces-9029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92583D241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA851C2640E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F387494;
	Fri, 26 Jan 2024 01:51:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B746FDC
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233860; cv=none; b=b6aTVFLXS8cwKBYz5PBWBOhlVtvBgZHZ8Nfb1nlOdFGYzdf6VyZ/71t3Wg6yhm3BR9rNTFwmAbjuOWsqjsvEVUYThw/5PW1KQo8G9zCG4Wnfs3xgjrxQ4mEm7G9oLBHQfX5vVRkdNrtzGONOEk0e3aI1h4j62y1sE51XShQyDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233860; c=relaxed/simple;
	bh=2GQ4KEI7kKsLRQXQVB94MVmPqV9nNG4FmX1Pl78VJKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOXqfVNkMHeRes1tx5NXcARRfdPXaHaozipKVgTqp5YlrHIBPyLmvEpNyo7ZwVlNhsRMQ9GWy/JmzJ5rqLNj5RKUpqFTdqjHMp8qvAATHnzfRyJZab6JoBsRMecArZMDQ/+3dGbGM2x6SUSv47Ap3bu9UMZnMmeANzqs0OphNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E77C43394;
	Fri, 26 Jan 2024 01:50:57 +0000 (UTC)
Date: Thu, 25 Jan 2024 20:50:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240125205055.2752ac1c@rorschach.local.home>
In-Reply-To: <2024012522-shorten-deviator-9f45@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
	<2024012522-shorten-deviator-9f45@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 17:24:03 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jan 25, 2024 at 10:48:22AM -0500, Steven Rostedt wrote:
> > Now that I have finished the eventfs file system, I would like to present a
> > proposal to make a more generic interface that the rest of tracefs and even
> > debugfs could use that wouldn't rely on dentry as the main handle.  
> 
> You mean like kernfs does for you today?  :)
> 

I tried to use kernfs when doing a lot of this and I had issues. I
don't remember what those were, but I can revisit it.

-- Steve

