Return-Path: <linux-fsdevel+bounces-886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B87D233E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7484E2815A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64487101E8;
	Sun, 22 Oct 2023 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C452570
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 13:46:20 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBAFDF;
	Sun, 22 Oct 2023 06:46:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1quYmW-0006af-O9; Sun, 22 Oct 2023 15:46:16 +0200
Message-ID: <9ba95b5e-72cb-445a-99b7-54dad4dab148@leemhuis.info>
Date: Sun, 22 Oct 2023 15:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697982378;427ac114;
X-HE-SMSGID: 1quYmW-0006af-O9

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 17.10.23 12:27, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
>>   Hello Linus,
>>
>>   could you please pull from
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
>>
>> to get:
>> * fixes for possible use-after-free issues with quota when racing with
>>   chown
>> * fixes for ext2 crashing when xattr allocation races with another
>>   block allocation to the same file from page writeback code
>> * fix for block number overflow in ext2
>> * marking of reiserfs as obsolete in MAINTAINERS
>> * assorted minor cleanups
>>
>> Top of the tree is df1ae36a4a0e. The full shortlog is:
> 
> This merge commit (?) broke boot on Intel Merrifield.
> It has earlycon enabled and only what I got is watchdog
> trigger without a bit of information printed out.
> 
> I tried to give a two bisects with the same result.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot (using info from
https://lore.kernel.org/all/ZS5hhpG97QSvgYPf@smile.fi.intel.com/ here):

#regzbot ^introduced 024128477809f8
#regzbot title quota: boot on Intel Merrifield after merge commit
1500e7e0726e
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

