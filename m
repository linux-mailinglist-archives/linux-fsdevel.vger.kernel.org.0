Return-Path: <linux-fsdevel+bounces-2988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D57EE8DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EE11C209DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9997F495DC;
	Thu, 16 Nov 2023 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QvKaTL3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BD495C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 21:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD9AC433C7;
	Thu, 16 Nov 2023 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700171014;
	bh=twTNWRQdIKcOStkRGzXUGtwCSKQonpLZLAIQKx9vJcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QvKaTL3ndxsh2tVl73T17w+fISLhZTW0gIn7pe8oxtPfAcZfG+MvZhirVrmwYyJr7
	 2fEEHfjUG6qKjAICs1TWsSOFv3l5im7ASasMGpFlpSsu7TbZgogyvG+feNReCzbSBO
	 Z1uVpoTJqjG/Fp+2L/pKCJOiRojj95iCYDg6HN3A=
Date: Thu, 16 Nov 2023 13:43:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] squashfs: squashfs_read_data need to check if the
 length is 0
Message-Id: <20231116134332.285510d340637171d2fe968c@linux-foundation.org>
In-Reply-To: <20231116031352.40853-1-lizhi.xu@windriver.com>
References: <0000000000000526f2060a30a085@google.com>
	<20231116031352.40853-1-lizhi.xu@windriver.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 11:13:52 +0800 Lizhi Xu <lizhi.xu@windriver.com> wrote:

> when the length passed in is 0, the subsequent process should be exited.

Thanks, but when fixing a bug, please always describe the runtime
effects of that bug.  Amongst other things, other people need this
information to be able to decide which kernel versions need patching.

> Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com

Which is a reason why we're now adding the "Closes:" tag after
Reported-by:.

I googled the sysbot email address and so added

Closes: https://lkml.kernel.org/r/0000000000000526f2060a30a085@google.com

to the changelog.

I'll assume that a -stable kernel backport is needed.



