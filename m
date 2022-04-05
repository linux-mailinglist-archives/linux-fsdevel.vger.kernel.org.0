Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C652A4F4D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582004AbiDEXln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457605AbiDEQPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:15:42 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88F1836B
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 09:13:42 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KXt4523HhzMqCNN;
        Tue,  5 Apr 2022 18:13:41 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KXt440gnCzljsTK;
        Tue,  5 Apr 2022 18:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649175221;
        bh=HbIIPB+F63MI4bn+Xkm4MHoAj4TOesDIJhPoMCrZYT8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=qzdG0k4T0pCT9Y5O0SKeHR1gCabKPNMXBr9/oJo7CpCICY/1j/xC2dh+CGhYEieKE
         I5WUzniErLzcmVzJF5p85bToyKl7r8vfpngkouqMWfClJtdtLDQWHn6WY8FtRicLWN
         7Iz+X5pHaKySgtyIp9gsBPVns7tV6n6l4sge18jg=
Message-ID: <f93438e8-f568-a70d-2e03-4aa147932e00@digikod.net>
Date:   Tue, 5 Apr 2022 18:14:05 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <YkxYHqLqTEKFrCeg@mit.edu>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <YkxYHqLqTEKFrCeg@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 05/04/2022 16:54, Theodore Ts'o wrote:
> On Mon, Apr 04, 2022 at 10:30:13PM +0200, Mickaël Salaün wrote:
>>> If you add a new X_OK variant to access(), maybe that could fly.
>>
>> As answered in private, that was the approach I took for one of the early
>> versions but a dedicated syscall was requested by Al Viro:
>> https://lore.kernel.org/r/2ed377c4-3500-3ddc-7181-a5bc114ddf94@digikod.net
>> The main reason behind this request was that it doesn't have the exact same
>> semantic as faccessat(2). The changes for this syscall are documented here:
>> https://lore.kernel.org/all/20220104155024.48023-3-mic@digikod.net/
>> The whole history is linked in the cover letter:
>> https://lore.kernel.org/all/2ed377c4-3500-3ddc-7181-a5bc114ddf94@digikod.net/
> 
> As a suggestion, something that can be helpful for something which has
> been as heavily bike-sheded as this concept might be to write a
> "legislative history", or perhaps, a "bike shed history".
> 
> And not just with links to mailing list discussions, but a short
> summary of why, for example, we moved from the open flag O_MAYEXEC to
> the faccessat(2) approach.  I looked, but I couldn't find the
> reasoning while diving into the mail archives.  And there was some
> kind of request for some new functionality for IMA and other LSM's
> that I couldn't follow that is why the new AT_INTERETED flag, but at
> this point my time quantuum for mailing list archeology most
> definitely expired.  :-)
> 
> It might be that when all of this is laid out, we can either revisit
> prior design decisions as "that bike-shed request to support this
> corner case was unreasonable", or "oh, OK, this is why we need as
> fully general a solution as this".
> 
> Also, some of examples of potential future use cases such as "magic
> links" that were linked in the cover letter, it's not clear to me
> actually make sense in the context of a "trusted for" system call
> (although might make more sense in the context of an open flag).  So
> revisiting some of those other cases to see whether they actually
> *could* be implemented as new "TRUSTED_FOR" flags might be
> instructive.
> 
> Personally, I'm a bit skeptical about the prospct of additional use
> cases, since trusted_for(2) is essentially a mother_should_I(2)

That would be an interesting syscall name. ;)


> request where userspace is asking the kernel whether they should go
> ahead and do some particular policy thing.  And it's not clear to me
> how many of these policy questions exist where (a) the kernel is in
> the past position to answer that question, and (b) there isn't some
> additional information that the kernel doesn't have that might be
> needed to answer that question.

Script execution is definitely the main use case and the semantic is 
already known by the kernel.


> 
> For example, "Mother should I use that private key file" might require
> information about whether the SRE is currently on pager duty or not,
> at least for some policies, and the kernel isn't going to have that
> information.
> 
> Other examples of TRUSTED_FOR flags that really make sense and would
> be useful might help alleviate my skepticsm.  And the "bike shed
> history" would help with my question about why some folks didn't like
> the original O_MAYEXEC flag?

Thanks, I'll do some that.

> 
> Cheers,
> 
> 					- Ted
