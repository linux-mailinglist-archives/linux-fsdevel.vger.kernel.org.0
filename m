Return-Path: <linux-fsdevel+bounces-70987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18413CAE755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 01:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABDBD302699C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6351F3FEC;
	Tue,  9 Dec 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGpFEWA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED291DF72C;
	Tue,  9 Dec 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239268; cv=none; b=O1VAilftsYbbHxM7RwpnG33eABtTSx5hRvcCI9rL5Xi6TD4XQj24Lb2u7eXhG7/i3IEbQz1/IATsDvHI0ajyz9Kq0SI2obyagSAEakidJuEhPZCH1rqkbDoRJqKJqTTnNQSG5aNJtLZqDmIwsYABdSb4nuxRpDphpPZEE6L6aBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239268; c=relaxed/simple;
	bh=BDBWPYz+wbEugLXjqj/8cZS+h2YQAn5YDKIIuNwl6I4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bIHKqhrs38wFy/IN3oEVOK/1sMUKxWyGoDFQFlCHVLLzKo7aNuhNNOcL8BZG+hDj6STHNRbK9yWHxrPdZo/+1B+TGaCKK7Mk7aw2H0HZcnJa14TALQlYZsezcAedCcM4+Ia7tr8y5Y1LaLkwcj5a+i5pTkXfe6qF+a5xe07aQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGpFEWA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2955C4CEF1;
	Tue,  9 Dec 2025 00:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239268;
	bh=BDBWPYz+wbEugLXjqj/8cZS+h2YQAn5YDKIIuNwl6I4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mGpFEWA+l7SRI3J/w3JPeac16WtEhvlka44a7lh/JQmqwtPyCD4R0bEUZgCq04O7m
	 HmHVU7QzSvb682mkNJQIYnbkatejkPlXhTHEm7YU921xhjtAvcrimX2t+Slhlum6wW
	 qminLMFHdW5ZsXz+kcg7DYGF0U2TNNykVczfnYBJ8ZOgkDCGT7ko6MD6eTTTmlpKJ/
	 Arzi7t700t1zFAIzuK0jhuAUTTboiWPcYpywgiK+8AS0PlZLl0QxYnnpXi3RcQVr5i
	 FrnldsHyhVEXoqsFlldF2k0jBENPI6LvrrPtaArMzMwZt8Rqz7XbI9EzqCpnGsVzUT
	 acJD+Qwnh0s5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B63503808200;
	Tue,  9 Dec 2025 00:11:24 +0000 (UTC)
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251208235528.3670800-1-hpa@zytor.com>
References: <20251208235528.3670800-1-hpa@zytor.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251208235528.3670800-1-hpa@zytor.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master
X-PR-Tracked-Commit-Id: a110f942672c8995dc1cacb5a44c6730856743aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b88b2f82fab45521cb32c0b737266d90a66a748f
Message-Id: <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
Date: Tue, 09 Dec 2025 00:11:23 +0000
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H . Peter Anvin" <hpa@zytor.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@ACULAB.COM>, David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir
 i Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, Yu
 feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Dec 2025 15:55:26 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b88b2f82fab45521cb32c0b737266d90a66a748f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

