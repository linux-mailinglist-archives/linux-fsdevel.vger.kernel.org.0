Return-Path: <linux-fsdevel+bounces-22767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4291BEB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C93B1C2040B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E61586FE;
	Fri, 28 Jun 2024 12:34:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD304D8DB;
	Fri, 28 Jun 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578098; cv=none; b=aIVP6o15Op4t7jL+m5e0hlB/F42bEwEvZfVGYhceecUWWjVV93p+OCAzXc8X9nlWZJA8M/ZHMZgfRJxC6VfqaUUUDY4/bqCwrUfijG0Vei4MiocNB4T8e/4plJjr26dvr4YUAkkn6Bt6yX57lmO57W2eO1oQZoICbqqqOLw4Vhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578098; c=relaxed/simple;
	bh=t4NUwdenS3xnnLYwY/0t8WghPB6FIqkw10hI/JqhgHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulitYRk3WGcvD+/SrY+VwyLiEHNpLS7Ww7v97Bo2eQVWFhe3InvQx8JqkDswAP5IvcZa/sIMdP9SAXqHueds82bhltr8P6uYUw9N/Z0HIKTgJoi7JRYzIgEY0srEUEqUR0yI5X+OQjhMdiwENLGsMdvBnUim0UIm7s1SaHlIfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58208C116B1;
	Fri, 28 Jun 2024 12:34:57 +0000 (UTC)
Date: Fri, 28 Jun 2024 08:35:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] tracefs: Convert to new uid/gid option parsing
 helpers
Message-ID: <20240628083550.6e1597ce@gandalf.local.home>
In-Reply-To: <6c9b0b16-e61b-4dfc-852d-e2eb5bb11b82@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
	<6c9b0b16-e61b-4dfc-852d-e2eb5bb11b82@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 19:40:44 -0500
Eric Sandeen <sandeen@redhat.com> wrote:

> Convert to new uid/gid option parsing helpers
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

