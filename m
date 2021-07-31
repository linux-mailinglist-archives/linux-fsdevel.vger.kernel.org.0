Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18D53DC5AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhGaLVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhGaLVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 07:21:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C24C06175F;
        Sat, 31 Jul 2021 04:21:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso9122959wms.1;
        Sat, 31 Jul 2021 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6sPE8Fff5wbeg+astV8t8DlE621tH1W/fMSHldAuULw=;
        b=WnWgnQSp/ltZusGvOX5YacL/+UrcpCkGRj7uHpSmUiAqD068rYwaKtpkrmudmoYexF
         C5FL2sV1gTqMeMuTaS4DDbTxRBJoH2thzTMC/gzCHQ/66ZCX6ePgp5bJSh5MFYU5rv3f
         yLz7ERDfR5yoZM18AJQV3OeTm3DT0gDOP8m/pTcqV7Xpx0sgurabQaJW741eD7f2Kg+G
         n4psZDYVd2gNqVByatBdEuN15fCc5EVfS8zV+eiUn4Awa+dkjjskLHkOfgf+cFMf/TuH
         bGl5YxPcMGSA18PxZshiK2w5LCT/gTVAWcqKKkX0Lc5NOd210tIF7uIUDJuKgYWqPoH9
         hlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6sPE8Fff5wbeg+astV8t8DlE621tH1W/fMSHldAuULw=;
        b=km/7cCQeWf5qZC7qMkNTAxRtoj1MCnhMkZ4vpyt2Aczz/sR2JIaGr65VY6UiccZE2Q
         EhAXGiHzuVaBp3gQaD9v7/4u9q+wuyiD7tytMc7utjmwm/KRs8TJx2gjmRyqqoT4hdxy
         42/sYag9rfgVDSml1ZrHJdpPDPGx4HICz4tFLsvbmY8d2Hf4SIi2spzoZ2kG1hRNVw8x
         T+iWL/LSmInq6fNQEgx2H6HKqyrP8xgcKlTS+pDI3RmUeE7DcazLe/RbMz/lus2IHvhh
         NalfkZit9QOAEnPhvlCjw79gEOUOM2spOsvy0iDmKpQbTEuQ8+Gf1t8LgP8YFYW/zdNR
         kSjw==
X-Gm-Message-State: AOAM531h4bqv2tx44pyPSh84Sb1RDVX48dNHWt1oD8HuUcPboaBEnYAU
        yWmbjZIjhLn2KwwDSZkDqM8=
X-Google-Smtp-Source: ABdhPJwon4KPNoG2L8gvSycDoxhgoShvCKx7wDpIeW2pT6ik6Lj2ujrHGSz4Ver3PS3kJMrWiQ7WbA==
X-Received: by 2002:a1c:6245:: with SMTP id w66mr7849172wmb.143.1627730461525;
        Sat, 31 Jul 2021 04:21:01 -0700 (PDT)
Received: from [10.8.0.10] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id a14sm4688144wrf.97.2021.07.31.04.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 04:21:01 -0700 (PDT)
Subject: Re: [PATCH v2] mount_setattr.2: New manual page documenting the
 mount_setattr() system call
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Glibc <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210730094121.3252024-1-brauner@kernel.org>
 <9ba8d98e-dee9-1d8d-0777-bb5496103e24@gmail.com>
 <20210731014251.whqfubv3hzu3mssw@localhost.localdomain>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <00d3c648-bdb5-3005-807f-ec2d3360f16a@gmail.com>
Date:   Sat, 31 Jul 2021 13:20:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731014251.whqfubv3hzu3mssw@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Branden,

On 7/31/21 3:42 AM, G. Branden Robinson wrote:
> Hi, Alex!
> 
> At 2021-07-30T20:15:43+0200, Alejandro Colomar (man-pages) wrote:
>>> +With each extension that changes the size of
>>> +.I struct mount_attr
>>> +the kernel will expose a define of the form
>>> +.B MOUNT_ATTR_SIZE_VER<number> .
>>
>> s/.B/.BR/
> 
> I would say this is, properly considered, an instance of the notorious
> three-font problem.  "number" should be in italics, and the angle
> brackets are certainly neither literal nor variable, but are injected to
> get around the most dreaded markup problem in man(7).
> 
> But it need not be dreaded anymore.

As I said in another thread, you're right, but since man-pages already 
use a wrong style, I won't impose the correct style to incoming patches 
for now.

I'll fix it myself later.

> 
> There are two ways to address this; both require *roff escape sequences.
> 
> My preference is to use \c, the output line continuation escape
> sequence.  (Ingo Schwarze, OpenBSD committer and mandoc(1) maintainer,
> has the opposite preference, for \f escapes).
> 
> I recommend:
> 
> .BI MOUNT_ATTR_SIZE_VER number\c
> \&.

I also prefer your way (at least in cases like this one (maybe in the 
synopsis \f would be more appropriate)).  It is more consistent with our 
current style of placing each identifier in a line of its own, and 
normal text separately (punctuation is placed wherever it's simpler, but 
in this case I think it's simpler in a separate line).

> 
> (The non-printing input break, \& can be seen in several contexts; here,
> it prevents the period from being interpreted specially the beginning of
> the line, marking it a "control line" like the macro call immediately
> previous.)
> 
> The period will be set in the roman style.  This problem and its
> workarounds are documented in groff_man_style(7)[1].

Okay.

> 
>>> +The effect of this change will be a mount or mount tree that is read-only,
>>> +blocks the execution of setuid binaries but does allow to execute programs and
>>
>> I'm not sure about this:
>>
>> I've checked other pages that mention setuid, and I've seen different
>> things.
>> But none of them use setuid as an English word.
>> Maybe have a look at similar pages and try to use a similar syntax.
>>
>> grep -rni setuid man?
> 
> It's common in technical literature to introduce specialized terminology
> and subsequently apply it attributively.
> 
> Personally, I would style "setuid" in italics in the above example; that
> is how I would expect to see it in a printed manual.
> 
> Even more explicitly, one could write
> 
> 	execution of
> 	.IR setuid -using
> 	binaries,
> 
> While I'm here I will note that there should be a comma as noted above,
> and the seemingly ineradicable Denglish construction of following the
> verb "allow" with an infinitive should be recast.
> 
> My suggestion:
> 
> 	but allows execution of programs and access to device nodes.
> 
>>> +access to devices nodes.
>>> +In the new mount api the access time values are an enum starting from 0.
>>> +Even though they are an enum in contrast to the other mount flags such as
>>> +.BR MOUNT_ATTR_NOEXEC
>>
>> s/.BR/.B/
> 
> Alex (and others), if you have access to groff from its Git HEAD, you
> might be interested in trying my experimental CHECKSTYLE feature.  You
> use it by setting a register by that name when calling groff.  Roughly
> speaking, increasing the value turns up the linting.
> 
> groff -man -rCHECKSTYLE=n
> 
> where n is:
> 	1	Emits a warning if the argument count is wrong to TH or
> 		the six font style alternation macros.
> 	2	As 1, plus it complains of usage of deprecated macros
> 		(AT, UC, DT, PD).  And some day I'll be adding OP to
> 		that list.
> 	3	As 2, plus it complains of blank lines or lines with
> 		leading spaces.
> 
> Setting 1 has saved me from goofs prior to committing man page changes
> many times already in its short life.  Setting 2 reminds me every day
> that I need to fix up groff(7).  I don't usually provoke setting 3, but
> it has proven its worth at least once.
> 
> The above is the most documentation this feature has yet seen, and I'd
> appreciate feedback.

I'll try it.  Thanks!

> 
>>> +.IP \(bu
>>> +The mount must be a detached/anonymous mount,
>>> +i.e. it must have been created by calling
> 
> "i.e." should be followed by a comma, just like "e.g.", as they
> substitute for the English phrases "that is" and "for example",
> respectively.
> 
> And, yes, I'd semantically line break after that comma, too.  ;-)
> 
>>> +.BR open_tree (2)
>>> +with the
>>> +.I OPEN_TREE_CLONE
>>> +flag and it must not already have been visible in the filesystem.
>>> +.RE
>>> +.IP
>>
>> .IP here doesn't mean anything, if I'm not mistaken.
> 
> It certainly _should_--it should cause the insertion of vertical space.
> (It would also cause a break, but .RE already did that.)
> 
> The interaction of .IP and .RS/.RE is tricky and can probably be blamed,
> back in 2017, for irritating me to the point that I became a groff
> developer.  I've documented it as extensively as I am able in
> groff_man_style(7)[1].

Yes, indeed there are 2 consecutive blank lines, which is incorrect most 
likely.

Probably a glitch of copying and pasting without really understanding 
what each macro does (not to blame Christian, but that the groff_man(7) 
language (or dialect actually) is not something familiar to programmers, 
and most of them legitimately don't have time to learn it well).

> 
>> We don't want to format the ending period, as discussed in the linked
>> thread.  Consider using .IR as explained there.  Maybe nonbreaking spaces at
>> some points of this sequence are also necessary.
>>
>> Nonbreaking spaces are \~
>>
>> You can see a discussion about nonbreaking spaces (of yesterday) here:
>> <https://lore.kernel.org/linux-man/90d6fcc8-70e6-5c44-5703-1c2bf2ad6913@gmail.com/T/#u>
> 
> Thanks for reminding me--I need to get back to you with a suggested
> patch.  I am so bad at preparing patches for the man-pages project.  :(

If there's any difficulty that I should/may address, please tell me :)

> 
>>> +.RE
>>> +.RE
>>> +.IP
>>
>> Another unused .IP?
>>
>> What did you mean?
> 
> Here's another point to consider.  Maybe he wants to preserve the
> indentation amount "cached" by the last IP macro with such an argument.
> 
>     Horizontal and vertical spacing
>         The indent argument accepted by .RS, .IP, .TP, and the deprecated
>         .HP  is a number plus an optional scaling indicator.  If no scal‐
>         ing indicator is given, the man package assumes “n”.  An indenta‐
>         tion  specified in a call to .IP, .TP, or the deprecated .HP per‐
>         sists until (1) another of these macros is  called  with  an  ex‐
>         plicit indent argument, or (2) .SH, .SS, or .P or its synonyms is
>         called; these clear the indentation  entirely.   Relative  insets
>         created  by  .RS move the left margin and persist until .RS, .RE,
>         .SH, or .SS is called.
> 
> I realize the above text is pretty dense.  These matters were almost
> undocumented in groff 1.22.3 and for many years before that.

That's what I thought in the first place, but after further 
investigating the context, it simply seems like a problem of copy&paste.


> 
>>> +                exit_log("%m - Failed top open %s\n", optarg);
>>
>>
>> Use \e to write the escape sequence in groff.  See groff_man(7):
>>
>>         \e     Widely used in man pages to  represent  a  backslash
>>                output  glyph.  It works reliably as long as the .ec
>>                request is not used, which should  never  happen  in
>>                man pages, and it is slightly more portable than the
>>                more exact ‘\(rs’  (“reverse  solidus”)  escape  se‐
>>                quence.
>>
>> \n is interpreted by groff(1) and not translated verbatim into the
>> output.
> 
> Yes.  It interpolates a register named '"', in this case (which is a
> valid roff identifier).  That's probably not defined, so groff will
> define it automatically, assign zero to it, and then interpolated it. So
> you'd end up with %s0.
> 
> I think it bears restating that code examples in man pages, whether set
> with the .EX/.EE macros or otherwise, are not "literal" or
> "preformatted" regions[1].  .EX does two things only: it disables

s/1/2/?

> filling (which also necessarily disables automatic breaking, automatic
> hyphenation, and adjustment), and it changes the font family for
> typesetter devices (to Courier).  The escape character remains a
> backslash and it remains fully armed and operational, as Emperor
> Palpatine might say.
> 
> Regards,
> Branden
> 
> [1] https://www.man7.org/linux/man-pages/man7/groff_man_style.7.html
> [2] Long ago, in the 1970s, there was an ".li" (for "literal") request
>      in Unix troff.  It was taken out even before Version 7 Unix was
>      published.)

Not only that (.li) was taken out, but also the reference to this [2] in 
the text ;)

I guess you wanted to refer here from the second occurence of [1].


Regards,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
