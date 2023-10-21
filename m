Return-Path: <linux-fsdevel+bounces-881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053987D207A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 01:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE071C209E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1442111A;
	Sat, 21 Oct 2023 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jes7izl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C920E6
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 23:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE04C433C8;
	Sat, 21 Oct 2023 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697931382;
	bh=ePJsVbVghIPpOSlBWXWL3Zpf8CxGc78DT241F9Znn6s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Jes7izl8GIZDoZdhjcdKpFSDBNTYlqrZtRgp1KMFoTgz6Vv5Eg9lJrtxsgw+/Pd8k
	 SCgmHgcw5X+ZY5Lx5o7GwzjY39xpPA+U3sDOGJZE+Ru6soJLTDHo/r5UVmYfmfz3NY
	 ozD9uqdLam9a7jDUeLpi/XC3H8yV5WI3neuN/wWGYO3a+vVCAbxQBWKaA/8nURCTEk
	 DAsVdxCchnhMtzBMEfwZx9HhMmYqcViHBYsFgLuv3pd3+AtEB03wR2aFJzxfDf/nta
	 l5OzRTx3Tbnbysuqf6f4KlwSbKHQe9x6RVGDEgb2SPMwwVJd+CJugFtP4qfX21VsSf
	 uyB5ST6KcupdA==
Date: Sat, 21 Oct 2023 16:36:19 -0700
From: Kees Cook <kees@kernel.org>
To: andy.shevchenko@gmail.com, Jan Kara <jack@suse.cz>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Baokun Li <libaokun1@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
References: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com> <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com> <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com> <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com> <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com> <ZTLHBYv6wSUVD/DW@smile.fi.intel.com> <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com> <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
Message-ID: <BF6761C0-B813-4C98-9563-8323C208F67D@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 20, 2023 1:36:36 PM PDT, andy=2Eshevchenko@gmail=2Ecom wrote:
>That said, if you or anyone has ideas how to debug futher, I'm all ears!

I don't think this has been tried yet:

When I've had these kind of hard-to-find glitches I've used manual built-b=
inary bisection=2E Assuming you have a source tree that works when built wi=
th Clang and not with GCC:
- build the tree with Clang with, say, O=3Dbuild-clang
- build the tree with GCC, O=3Dbuild-gcc
- make a new tree for testing: cp -a build-clang build-test
- pick a suspect =2Eo file (or files) to copy from build-gcc into build-te=
st
- perform a relink: "make O=3Dbuild-test" should DTRT since the copied-in =
=2Eo files should be newer than the =2Ea and other targets
- test for failure, repeat

Once you've isolated it to (hopefully) a single =2Eo file, then comes the =
byte-by-byte analysis or something similar=2E=2E=2E

I hope that helps! These kinds of bugs are super frustrating=2E

-Kees

--=20
Kees Cook

