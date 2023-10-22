Return-Path: <linux-fsdevel+bounces-885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230E87D2334
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77A02814DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A28101D5;
	Sun, 22 Oct 2023 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2029AF
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 13:35:19 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93CDC;
	Sun, 22 Oct 2023 06:35:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1quYbq-00057E-Ui; Sun, 22 Oct 2023 15:35:15 +0200
Message-ID: <fd1edea6-5512-48fb-a5d1-e25ebdc56904@leemhuis.info>
Date: Sun, 22 Oct 2023 15:35:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [RESEND PATCH] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
 linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Bernd Schubert <bschubert@ddn.com>,
 Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230904133321.104584-1-git@andred.net>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230904133321.104584-1-git@andred.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697981717;d68ef9f0;
X-HE-SMSGID: 1quYbq-00057E-Ui

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.09.23 15:33, André Draszik wrote:
> From: André Draszik <andre.draszik@linaro.org>
> 
> This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
> 
> This patch breaks all existing userspace by requiring updates as
> mentioned in the commit message, which is not allowed.
> 
> Revert to restore compatibility with existing userspace
> implementations.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 3066ff93476c35679cb07a97cce37d9bb07632
#regzbot title fuse: creating new files, or reading existing files in i
Android, now returns -EFAULT
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


