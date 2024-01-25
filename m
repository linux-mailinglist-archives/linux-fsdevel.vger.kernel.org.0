Return-Path: <linux-fsdevel+bounces-8936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9583C789
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12BF1C24D3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171286AD5;
	Thu, 25 Jan 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDTUY5dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9F7C080;
	Thu, 25 Jan 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198899; cv=none; b=Gg9F/R+aWfF7JzkbIdWuK3l/P2tu9fJvYwx6aV2GCnZw67SneByAHAydP9uMrcljNp/6LDlFP6PwBjOqwBPl2Kf2FbZxcrq41hYS63mIvE0/tx9R3+oYCkfuVBr/pNnZyTG1Pi1yqj2LjPr3Yq1+1R9+PlvuCXFxhJ0c/jpH91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198899; c=relaxed/simple;
	bh=ibwxNm2tdnHXTgdD62LX+2MMbAqPlVcGsNKmR8yQGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh4oqrTsqXEqj+AS2u/scWN+JqorIMo5Rpk+1rGo+KrW1OE+bj8bfazm/ff0rbYsq8Sygw7yKE9N7olzcyzTDlWfTfAUXjsLd6vmcmIy34Igcejsz5oOuxWSHT+qRMnaKCweNZax24zYpmS7MoGOA0DlhhN8rhx5tEo2Ht8nPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDTUY5dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42653C433C7;
	Thu, 25 Jan 2024 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706198899;
	bh=ibwxNm2tdnHXTgdD62LX+2MMbAqPlVcGsNKmR8yQGvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDTUY5drc5hjRMbTOh/O323rJLLr4aVye9f2Sn/Ngjkq30nERxnlSRPP/eTpNxU1v
	 iARp6kC7UVq1/ILFH8zoXHQWlG1iP1cLSLXr0rUH4stxoS46dZckZOf6ob1da6bzE/
	 dEyfEmlYNaIMAdiCq1iHd0r7fniTXRFCgavNB2A3nLBMwfLrfYUmvQB2ggn/VLPnrR
	 xdCCgzw5k/fQS9/YLzmh2pjoSB5+oo0txn3la/X0C+sMOrDpajDEoO8lVoyaI4xRsS
	 CDnRYlWAVfjjXOsXhhpMYUPJf2XPk6CVjz5PbM/NXs1URg5pU8HQLbwzTV/I42UMbc
	 Oj376Bril61Ng==
Date: Thu, 25 Jan 2024 17:08:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, hdanton@sina.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
Message-ID: <20240125-legten-zugleich-21a988d80b45@brauner>
References: <00000000000083513f060340d472@google.com>
 <000000000000e5e71a060fc3e747@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000e5e71a060fc3e747@google.com>

On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
> start commit:   2ccdd1b13c59 Linux 6.5-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
#syz fix: fs: Block writes to mounted block devices

