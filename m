Return-Path: <linux-fsdevel+bounces-3355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B227F3FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A625B1C20840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFBA2232E;
	Wed, 22 Nov 2023 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B3E109;
	Wed, 22 Nov 2023 00:15:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r5iO2-0004YL-Kn; Wed, 22 Nov 2023 09:15:06 +0100
Message-ID: <5884527d-a4a2-44e2-96bc-4b300c9e2fb8@leemhuis.info>
Date: Wed, 22 Nov 2023 09:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <9ba95b5e-72cb-445a-99b7-54dad4dab148@leemhuis.info>
In-Reply-To: <9ba95b5e-72cb-445a-99b7-54dad4dab148@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700640908;2433d411;
X-HE-SMSGID: 1r5iO2-0004YL-Kn

On 22.10.23 15:46, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 17.10.23 12:27, Andy Shevchenko wrote:
>> On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
>>>   Hello Linus,
>>>
>>>   could you please pull from
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
>>
>> This merge commit (?) broke boot on Intel Merrifield.
>> It has earlycon enabled and only what I got is watchdog
>> trigger without a bit of information printed out.
>>
>> I tried to give a two bisects with the same result.
> 
> #regzbot ^introduced 024128477809f8
> #regzbot title quota: boot on Intel Merrifield after merge commit
> 1500e7e0726e
> #regzbot ignore-activity

Removing this from the tracking. To quote Linus from
https://lore.kernel.org/all/CAHk-=wgEHNFHpcvnp2X6-fjBngrhPYO=oHAR905Q_qk-njV31A@mail.gmail.com/

"""
The quota thing remains unexplained, and honestly seems like a timing
issue that just happens to hit Andy. Very strange, but I suspect that
without more reports (that may or may not ever happen), we're stuck.
"""

No other reports showed up afaik.

#regzbot inconclusive: individual and strange timing issue that got stuck
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

