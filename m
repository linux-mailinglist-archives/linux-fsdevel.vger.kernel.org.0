Return-Path: <linux-fsdevel+bounces-24157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23393A913
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 00:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD222840AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 22:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF1148303;
	Tue, 23 Jul 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M5PpxR53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F313B58D;
	Tue, 23 Jul 2024 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772573; cv=none; b=Hi+M4qTYjWsB7HZZ7VEh9BfyWaKGpdrgt1aR6jvgIqCABd+3Da0kWiRdi+vYPfhHe4CzHfNzxYRQThDrlc+6sh3AYy0dNo++kE+8skEk4AAqTYss4Fzydu92o/pIB/36PN9N0BbysAJDRwL3xJgNQ+vSzf44KEvxvB6a5pmYUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772573; c=relaxed/simple;
	bh=QyJFMqjHGoh0EaL1LGX7UFDims41FUQ9T4O56V/9Pvo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mw0ufhpZLIqVNPRnqjy8r/HE0gnFLyAZe9Gw3Srtjp4hJ4jbhFI5pxjwdQXzMd3QAoxt2wcsNKbSQDK4GkK5Th+ndH7bw4dw2xHUyR2HVpZAxgE/+Hk5IlYukS0sB2pDCGipC4TplzdgVlUx7p8qgUEmYTglLNhH6fu88/GBhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M5PpxR53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15794C4AF09;
	Tue, 23 Jul 2024 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721772572;
	bh=QyJFMqjHGoh0EaL1LGX7UFDims41FUQ9T4O56V/9Pvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5PpxR53RzB9beoG/0/4bfVjx+/6fqTQiDxMxEhhmTccLyI6BumXlw+mkJ7jtDJW9
	 JSbg+YRbGEhLRLiOTYgpoqf9w2iJyigw3tSegui0dnyzDxXCS2hCuWp+NxDtJhaCwJ
	 bvE41RQWe0t4NIWryvSOfyCFQro0DAiA/6EWXt+o=
Date: Tue, 23 Jul 2024 15:09:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de,
 ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
Message-Id: <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
In-Reply-To: <20240723091154.52458-1-sunjunchao2870@gmail.com>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jul 2024 05:11:54 -0400 Julian Sun <sunjunchao2870@gmail.com> wrote:

> Hi,
> 
> Recently, I saw a patch[1] on the ext4 mailing list regarding
> the correction of a macro definition error. Jan mentioned
> that "The bug in the macro is a really nasty trap...".
> Because existing compilers are unable to detect
> unused parameters in macro definitions. This inspired me
> to write a script to check for unused parameters in
> macro definitions and to run it.

Seems a useful contribution thanks.  And a nice changelog!

>  scripts/macro_checker.py | 101 +++++++++++++++++++++++++++++++++++++++

Makes me wonder who will run this, and why.  Perhaps a few people will
run ls and wonder "hey, what's that".  But many people who might have
been interested in running this simply won't know about it.

"make help | grep check" shows we have a few ad-hoc integrations but I
wonder if we would benefit from a top-level `make static-checks'
target?

