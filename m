Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE24F4D67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582057AbiDEXly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457559AbiDEQKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:10:45 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3566257;
        Tue,  5 Apr 2022 09:08:41 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KXsyH363KzMqGSh;
        Tue,  5 Apr 2022 18:08:39 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KXsyG1HnxzlhFgC;
        Tue,  5 Apr 2022 18:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649174919;
        bh=i3oU7NU7ziCxqF8LgADjo6sEcbpRcshVXFm2U/900+U=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=05hjwZCfXtRlbuAPVKAqLxEozCUGiyJuKeR9DDy+LAIfvTjHN5Dda4CqaT6LR6AGj
         0Y+D5L0C62XfZfPHEbOwNOtocUwvCHWgZiSizL41MxkNWkUODtKbPJGli0dLp5ZI0X
         b0XiDi/o56PGQRzjdvJnsbHhsEcUIwMKSbhe4U14=
Message-ID: <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
Date:   Tue, 5 Apr 2022 18:09:03 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
 <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook>
 <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 05/04/2022 01:26, Linus Torvalds wrote:
> On Mon, Apr 4, 2022 at 3:25 PM Kees Cook <keescook@chromium.org> wrote:

[...]

> 
>> I think this already exists as AT_EACCESS? It was added with
>> faccessat2() itself, if I'm reading the history correctly.
> 
> Yeah, I noticed myself, I just hadn't looked (and I don't do enough
> user-space programming to be aware of if that way).

I think AT_EACCESS should be usable with the new EXECVE_OK too.


> 
>>>      (a) "what about suid bits that user space cannot react to"
>>
>> What do you mean here? Do you mean setid bits on the file itself?
> 
> Right.
> 
> Maybe we don't care.

I think we don't. I think the only corner case that could be different 
is for files that are executable, SUID and non-readable. In this case it 
wouldn't matter because userspace could not read the file, which is 
required for interpretation/execution. Anyway, S[GU]ID bits in scripts 
are just ignored by execve and we want to follow the same semantic.


> 
> Maybe we do.
> 
> Is the user-space loader going to honor them? Is it going to ignore
> them? I don't know. And it actually interacts with things like
> 'nosuid', which the kernel does know about, and user space has a hard
> time figuring out.
> 
> So if the point is "give me an interface so that I can do the same
> thing a kernel execve() loader would do", then those sgid/suid bits
> actually may be exactly the kind of thing that user space wants the
> kernel to react to - should it ignore them, or should it do something
> special when it sees that they are set?
> 
> I'm not saying that they *should* be something we care about. All I'm
> saying is that I want that *discussion* to happen.
> 
>                 Linus
