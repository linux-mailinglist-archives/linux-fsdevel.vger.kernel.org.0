Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5513DC5F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhGaMbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhGaMbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 08:31:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BFC0613CF;
        Sat, 31 Jul 2021 05:30:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso1125766wmq.3;
        Sat, 31 Jul 2021 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XHZ1trvyqICL+T0kC85eYMeA/dqc6U2EPg5YaZZ+5/M=;
        b=VSnSykDdI5LvwMLCjVnry1nqkx6udFZ58XNYzfoKJEWf6XDgFaU3jkm6jsk764LEJJ
         JtpmXqw/8POxLC4MPGznD6zYH6whx2DWv3soklbPlOjcHbIzRzNm9CduQz3uZZfV8zQO
         mtm+cimeKOyKpJr/Kz0s172rD/6awysgAjqDpDWmxJOvGLbbHe2ZtcaIy3ooaHX/jlXK
         k4sUtS+iE+JpHGsPPAL2Pcu0CPjA7M3zxSJDAyC7Y2qX5cCxkm3b+yU3pUrhaC0mJ1+f
         LW3mIScaYYufPfdJpWdqptUe9CQXsx06i18N+s6Rbr5z5xrj9hTrmJgtd79KaXbfMgHR
         g1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHZ1trvyqICL+T0kC85eYMeA/dqc6U2EPg5YaZZ+5/M=;
        b=g782U2VXKVYJqhEmydQEUQu063AGLwIa22dx9QCLFkerjwW6RLMQJ7Y7IdaCNrdw2S
         FkKWPQZ74TYjGsiiUmPMKQHHxZvSqI99rPr6rMT+NS1dwI2rlltn2vCLxzTCNUL9QLlc
         jQgOj717d34WtSeU3qQ9ThEm5/zK7DzflwcgB+iehSp9KPha7yxmohkBpto+Vllc3GhO
         QgtoI5pnh6bTfcG9DdPn6n7u8LAOXKXJ7r7hIQwVtxhF/wOwiZNmodriRKkiLBjIuflK
         0ZIL2mq//hzKMbQGNhaNnsRWz2PfXjzX1OTr14hHWMZW5kr7VpW0B1QBQX3Rfe4U/LwJ
         g6Ag==
X-Gm-Message-State: AOAM530ZdsIuIc4/1P1YD2dF3gozAF8MBDO64yoWkKdE4vdkpz9vy3gz
        C6rnq5eyAGT+rKYNSpXA6Xw=
X-Google-Smtp-Source: ABdhPJx3HqcpZUwyaZcpfPqe/SFRFgEn+Sh+fHb3LXBX85Tb6iHUndw6YWHdb08WgwJmlfaTim4Jyg==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr7895728wmj.113.1627734652192;
        Sat, 31 Jul 2021 05:30:52 -0700 (PDT)
Received: from [10.8.0.10] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id w1sm4761518wmc.19.2021.07.31.05.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 05:30:51 -0700 (PDT)
Subject: Re: [PATCH v2] mount_setattr.2: New manual page documenting the
 mount_setattr() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Glibc <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <20210730094121.3252024-1-brauner@kernel.org>
 <9ba8d98e-dee9-1d8d-0777-bb5496103e24@gmail.com>
 <20210731094311.twnwu553i7hzr5md@wittgenstein>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <1ca74dab-bda4-5105-6e18-3764ee607761@gmail.com>
Date:   Sat, 31 Jul 2021 14:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731094311.twnwu553i7hzr5md@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On 7/31/21 11:43 AM, Christian Brauner wrote:
> On Fri, Jul 30, 2021 at 08:15:43PM +0200, Alejandro Colomar (man-pages) wrote:
>> Hi Christian,
>>
>>
>> On 7/30/21 11:41 AM, Christian Brauner wrote:
>>> From: Christian Brauner <christian.brauner@ubuntu.com>
>>>
>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>
>> Thanks for the patch!
>> Please see some comments below.
> 
> Thank you for the review! I've made most changes and will be sending out
> v3 shortly.
> 
> One thing I find a bit of an ask is to link to 3 separate long threads
> in this review that are discussions about groff formatting style and
> expect me to read through them to figure out how to make changes to this
> patch.

Sorry, as those (the first 2) threads discussed exactly the same issues 
here, I thought it was a good idea to link to them, but those threads 
grew even more after linking to them, so it wasn't a good idea.

Today I learnt that the same information is in a manual page, so I'll 
copy some relevant extracts from it here when necessary.

> 
> While I'm respectfully ranting, I'd like to say that in an ideal world
> we would end up writing rst in the not too distant future just as we do
> for the kernel documentation.

I proposed something like that around a year ago, when I was new to 
writing man pages.  Michael also had something like that in mind.  I 
don't know if it may ever hapen, but it has been considered a few times, 
at least.  But the transition wouldn't be easy.  And I'm not sure if RST 
can fully replace groff_man(7).

I agree that RST has a much easier learning curve in the begining.  But 
on the other hand, when you master groff_man(7), you can specify very 
complex formatting easily, which I would know how to do in RST.

> This is no comment on your work at all! But groff is a __giant__
> __giant__ pain imho.

Agree. :)

Especially since it's something that you don't usually use, except when 
writing manual pages, which is not something that you do everyday 
(unless you're maintainer of the man pages, that is).

BTW, I started using groff_man(7) to write other documents of mine 
replacing LibreOffice (legal documents, for example), and it's really 
nice, once you truly understand the language.

> I genuinely like writing documentation because it
> gives me time to think about the semantics I put into code.
> But I hate writing manpages or rather dread writing them because I know
> I'm going to be losing hours or a day not on content but on formatting.
> And then rounds of reviews with subtle differences between .I and .IR
> and whatnot. As a developer and maintainer I can't usually afford losing
> that much time which means I postpone writing manpages especially
> complex ones such as this.

I understand.

In the first reviews (v1, v2), I'll focus on formatting, but if there 
remain any formatting issues that the contributor really doesn't 
understand how to fix, I can't blame a programmer for not knowing groff, 
so I'll accept it and fix it myself later, so don't worry about it too much.

I'll comment below (and maybe also in v3 you sent after this email) with 
extracts of groff_man(7) that explain the correct usage, but I don't 
intend that you send an v4 just because of that.  It's only there so 
that you read it when and if you have time, to learn how to write future 
patches.



> 
> Thanks!
> Christian

Thanks you!

Alex

> 
>>
>>
>> Regards,
>>
>> Alex
>>
>>
>>
>>> ---
>>>    man2/mount_setattr.2 | 1071 ++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 1071 insertions(+)
>>>    create mode 100644 man2/mount_setattr.2
>>>
>>> diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
>>> new file mode 100644
>>> index 000000000..1ef7630f2
>>> --- /dev/null
>>> +++ b/man2/mount_setattr.2
>>> @@ -0,0 +1,1071 @@
>>> +.\" Copyright (c) 2021 by Christian Brauner <christian.brauner@ubuntu.com>
>>> +.\"
>>> +.\" %%%LICENSE_START(VERBATIM)
>>> +.\" Permission is granted to make and distribute verbatim copies of this
>>> +.\" manual provided the copyright notice and this permission notice are
>>> +.\" preserved on all copies.
>>> +.\"
>>> +.\" Permission is granted to copy and distribute modified versions of this
>>> +.\" manual under the conditions for verbatim copying, provided that the
>>> +.\" entire resulting derived work is distributed under the terms of a
>>> +.\" permission notice identical to this one.
>>> +.\"
>>> +.\" Since the Linux kernel and libraries are constantly changing, this
>>> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
>>> +.\" responsibility for errors or omissions, or for damages resulting from
>>> +.\" the use of the information contained herein.  The author(s) may not
>>> +.\" have taken the same level of care in the production of this manual,
>>> +.\" which is licensed free of charge, as they might when working
>>> +.\" professionally.
>>> +.\"
>>> +.\" Formatted or processed versions of this manual, if unaccompanied by
>>> +.\" the source, must acknowledge the copyright and authors of this work.
>>> +.\" %%%LICENSE_END
>>> +.\"
>>> +.TH MOUNT_SETATTR 2 2021-03-22 "Linux" "Linux Programmer's Manual"
>>> +.SH NAME
>>> +mount_setattr \- change mount properties of a mount or mount tree
>>> +.SH SYNOPSIS
>>> +.nf
>>> +.BI "int mount_setattr(int " dfd ", const char *" path ", unsigned int " flags ,
>>> +.BI "                  struct mount_attr *" attr ", size_t " size );
>>> +.fi
>>> +.PP
>>> +.IR Note :
>>> +There is no glibc wrapper for this system call; see NOTES.
>>
>>
>> Please see the new syntax we're using for syscalls without a wrapper. You
>> can check for example membarrier(2):
>> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/membarrier.2>
>>
>> Also please make sure you provide a complete include list for normal usage
>> of the system call (that is, headers providing syscall(2),
>> SYS_mount_setattr, and any other constants used by the system call).
>>
>>> +.SH DESCRIPTION
>>> +The
>>> +.BR mount_setattr (2)
>>> +system call changes the mount properties of a mount or entire mount tree.
>>> +If
>>> +.I path
>>> +is a relative pathname, then it is interpreted relative to the directory
>>> +referred to by the file descriptor
>>> +.I dfd
>>> +(or the current working directory of the calling process, if
>>> +.I dfd
>>> +is the special value
>>> +.BR AT_FDCWD ).
>>> +If
>>> +.I path
>>> +is the empty string and
>>> +.BR AT_EMPTY_PATH
>>> +is specified in
>>> +.I flags
>>> +then the mount properties of the mount identified by
>>> +.I dfd
>>> +are changed.
>>> +.PP
>>> +The
>>> +.BR mount_setattr (2)
>>> +system call uses an extensible structure
>>> +.I ( "struct mount_attr" )
>>
>> s/.I/.IR/
>>
>> (check the output of .I to see the difference)
> 
> ok

To understand when to use each of .I .IR, you can read the following 
extract from groff_man(7):


    Font style macros
        The man macro package is limited in its font styling options,
        offering only bold (.B), italic (.I), and roman.  Italic text is
        usually set underscored instead on terminal devices.  The .SM and
        .SB macros set text in roman or bold, respectively, at a smaller
        point size; these differ visually from regular-sized roman or
        bold text only on typesetter devices.  It is often necessary to
        set text in different styles without intervening space.  The
        macros .BI, .BR, .IB, .IR, .RB, and .RI, where “B”, “I”, and “R”
        indicate bold, italic, and roman, respectively, set their odd-
        and even-numbered arguments in alternating styles, with no space
        separating them.
[...]
        .I [text]
               Set text in italics.  If the macro is given no arguments,
               the text of the next input line is set in italics.

               Use italics for file and path names, for environment
               variables, for enumeration or preprocessor constants in C,
               for variable (user-determined) portions of syntax
               synopses, for the first occurrence (only) of a technical
               concept being introduced, for names of works of software
               (including commands and functions, but excluding names of
               operating systems or their kernels), and anywhere a
               parameter requiring replacement by the user is
               encountered.  An exception involves variable text in a
               context that is already marked up in italics, such as file
               or path names with variable components; in such cases,
               follow the convention of mathematical typography: set the
               file or path name in italics as usual but use roman for
               the variable part (see .IR and .RI below), and italics
               again in running roman text when referring to the variable
               material.
[...]
        Note what is not prescribed for setting in bold or italics above:
        elements of “synopsis language” such as ellipses and brackets
        around options; proper names and adjectives; titles of anything
        other than works of literature or software; identifiers for
        standards documents or technical reports such as CSTR #54,
        RFC 1918, Unicode 13.0, or POSIX.1-2017; acronyms; and
        occurrences after the first of a technical term or piece of
        jargon.  Again, the names of operating systems and their kernels
        are, by practically universal convention, set in roman.

        Be frugal with italics for emphasis, and particularly with bold.
        Brief runs of literal text, such as references to individual
        characters or short strings, including section and subsection
        headings of man pages, are suitable objects for quotation; see
        the \(lq, \(rq, \(oq, and \(cq escapes in subsection
        “Portability” below.

        Unlike the above font style macros, the font style alternation
        macros below accept only arguments on the same line as the macro
        call.  Italic corrections are applied as appropriate.  If space
        is required within one of the arguments, first consider whether
        the same result could be achieved with as much clarity by using
        the single-style macros on separate input lines.  When it cannot,
        double-quote an argument containing embedded space characters.
        Setting all three different styles within a word presents
        challenges; it is possible with the \c and/or \f escapes, but see
        subsection “Portability” below for caveats.
[...]
        .IR italic-text roman-text ...
               Set each argument in italics and roman, alternately.

                      This is the first command of the
                      .IR prologue .

> 
>>
>>> +to allow for future extensions. Any non-flag extensions to
>>
>>
>> See the following extract from man-pages(7):
>>
>> $ man 7 man-pages | sed -n '/Use semantic newlines/,/^$/p';
>>     Use semantic newlines
>>         In the source of a manual page,  new  sentences  should  be
>>         started  on new lines, and long sentences should split into
>>         lines at clause breaks (commas, semicolons, colons, and  so
>>         on).   This  convention,  sometimes known as "semantic new‐
>>         lines", makes it easier to see the effect of patches, which
>>         often  operate at the level of individual sentences or sen‐
>>         tence clauses.
>>
>>
>> There are more cases of that in this page.
> 
> I already tried to make sure to use semantic newlines. I'll try to go
> over this once more now but I'm reluctant to send a v3 just because of
> that in case I should miss any. Especially since I've just recently seen
> manpages get an ack where that requirement wasn't fulfilled.
> An automatic formatter for this scenario would be appreciated.

Okay,  I don't know how to write such an automatic formatter (and also 
don't have the time to write such a complex thing), but maybe Branden 
knows if such a thing exists.

About semantic newlines, I noticed it mostly follows that, but the 
following regex should rarely match:

[,;:.] \+\w

Notice "... extensions. Any non-flag ..." above.

However, if it persists in v3, which I haven't seen yet, I'll probably 
fix it myself, so don't worry for now.

> 
>>
>>> +.BR mount_setattr (2)
>>> +will be implemented as new fields appended to the above structure,
>>> +with a zero value in a new field resulting in the kernel behaving
>>> +as though that extension field was not present.
>>> +Therefore, the caller
>>> +.I must
>>> +zero-fill this structure on initialization.
>>> +(See the "Extensibility" section under
>>> +.B NOTES
>>> +for more details on why this is necessary.)
>>> +.PP
>>> +The
>>> +.I size
>>> +argument should usually be specified as
>>> +.IR "sizeof(struct mount_attr)" .
>>> +However, if the caller does not intend to make use of features that got
>>> +introduced after the initial version of
>>> +.I struct mount_attr
>>> +they are free to pass the size of the initial struct together with the larger
>>> +struct.
>>> +This allows the kernel to not copy later parts of the struct that aren't used
>>> +anyway.
>>> +With each extension that changes the size of
>>> +.I struct mount_attr
>>> +the kernel will expose a define of the form
>>> +.B MOUNT_ATTR_SIZE_VER<number> .
>>
>> s/.B/.BR/
> 
> ok
> 
>>
>>> +For example the macro for the size of the initial version of
>>> +.I struct mount_attr
>>> +is
>>> +.BR MOUNT_ATTR_SIZE_VER0 .
>>> +.PP
>>> +The
>>> +.I flags
>>> +argument can be used to alter the path resolution behavior.
>>> +The supported values are:
>>> +.TP
>>> +.B AT_EMPTY_PATH
>>> +If
>>> +.I path
>>> +is the empty string change the mount properties on
>>> +.I dfd
>>> +itself.
>>> +.TP
>>> +.B AT_RECURSIVE
>>> +Change the mount properties of the entire mount tree.
>>> +.TP
>>> +.B AT_SYMLINK_NOFOLLOW
>>> +Don't follow trailing symlinks.
>>> +.TP
>>> +.B AT_NO_AUTOMOUNT
>>> +Don't trigger automounts.
>>> +.PP
>>> +The
>>> +.I attr
>>> +argument of
>>> +.BR mount_setattr (2)
>>> +is a structure of the following form:
>>> +.PP
>>> +.in +4n
>>> +.EX
>>> +struct mount_attr {
>>> +    u64 attr_set;    /* Mount properties to set. */
>>> +    u64 attr_clr;    /* Mount properties to clear. */
>>> +    u64 propagation; /* Mount propagation type. */
>>> +    u64 userns_fd;   /* User namespace file descriptor. */
>>> +};
>>> +.EE
>>> +.in
>>> +.PP
>>> +The
>>> +.I attr_set
>>> +and
>>> +.I attr_clr
>>> +members are used to specify the mount properties that are supposed to be set or
>>> +cleared for a given mount or mount tree.
>>> +Flags set in
>>> +.I attr_set
>>> +enable a property on a mount or mount tree and flags set in
>>> +.I attr_clr
>>> +remove a property from a mount or mount tree.
>>> +.PP
>>> +When changing mount properties the kernel will first clear the flags specified
>>> +in the
>>> +.I attr_clr
>>> +field and then set the flags specified in the
>>> +.I attr_set
>>> +field:
>>> +.PP
>>> +.in +4n
>>> +.EX
>>> +struct mount_attr attr = {
>>> +    .attr_clr = MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NODEV,
>>> +    .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
>>> +};
>>> +unsigned int current_mnt_flags = mnt->mnt_flags;
>>> +
>>> +/*
>>> + * Clear all flags set in .attr_clr, i.e
>>
>> s/i.e/i.e./
> 
> ok
> 
>>
>>> + * clear MOUNT_ATTR_NOEXEC and MOUNT_ATTR_NODEV.
>>> + */
>>> +current_mnt_flags &= ~attr->attr_clr;
>>> +
>>> +/*
>>> + * Now set all flags set in .attr_set, i.e.
>>> + * set MOUNT_ATTR_RDONLY and MOUNT_ATTR_NOSUID.
>>> + */
>>> +current_mnt_flags |= attr->attr_set;
>>> +
>>> +mnt->mnt_flags = current_mnt_flags;
>>> +.EE
>>> +.in
>>> +.PP
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
> I've changed it to the same wording that is used in mount:
> 
> set-user-ID and set-group-ID
> 
>>
>>> +access to devices nodes.
>>> +Multiple changes with the same set of flags requested
>>> +in
>>> +.I attr_clr
>>> +and
>>> +.I attr_set
>>> +are guaranteed to be idempotent after the changes have been applied.
>>> +.PP
>>> +The following mount attributes can be specified in the
>>> +.I attr_set
>>> +or
>>> +.I attr_clr
>>> +fields:
>>> +.TP
>>> +.B MOUNT_ATTR_RDONLY
>>> +If set in
>>> +.I attr_set
>>> +makes the mount read only and if set in
>>> +.I attr_clr
>>> +removes the read only setting if set on the mount.
>>> +.TP
>>> +.B MOUNT_ATTR_NOSUID
>>> +If set in
>>> +.I attr_set
>>> +makes the mount not honor setuid and setgid binaries, and file capabilities
>>> +when executing programs.
>>> +If set in
>>> +.I attr_clr
>>> +clears the setuid, setgid, and file capability restriction if set on this
>>> +mount.
>>> +.TP
>>> +.B MOUNT_ATTR_NODEV
>>> +If set in
>>> +.I attr_set
>>> +prevents access to devices on this mount and if set in
>>> +.I attr_clr
>>> +removes the device access restriction if set on this mount.
>>> +.TP
>>> +.B MOUNT_ATTR_NOEXEC
>>> +If set in
>>> +.I attr_set
>>> +prevents executing programs on this mount and if set in
>>> +.I attr_clr
>>> +removes the restriction to execute programs on this mount.
>>> +.TP
>>> +.B MOUNT_ATTR_NODIRATIME
>>> +If set in
>>> +.I attr_set
>>> +prevents updating access time for directories on this mount and if set in
>>> +.I attr_clr
>>> +removes access time restriction for directories.
>>> +Note that
>>> +.BR MOUNT_ATTR_NODIRATIME
>>> +can be combined with other access time settings and is implied
>>> +by the noatime setting.
>>> +All other access time settings are mutually exclusive.
>>> +.TP
>>> +.B MOUNT_ATTR__ATIME - Changing access time settings
>>
>> .BR MOUNT_ATTR_ATIME " - Changing access time settings"
>>
>> i.e., Boldface only the constant name
> 
> ok
> 
>>
>>> +In the new mount api the access time values are an enum starting from 0.
>>> +Even though they are an enum in contrast to the other mount flags such as
>>> +.BR MOUNT_ATTR_NOEXEC
>>
>> s/.BR/.B/
> 
> ok
> 
>>
>>> +they are nonetheless passed in
>>> +.I attr_set
>>> +and
>>> +.I attr_clr
>>> +for consistency with
>>> +.BR fsmount (2)
>>> +which introduced this behavior.
>>> +.IP
>>> +Note, since access times are an enum, not a bitmap,
>>> +users wanting to transition to a different access time setting cannot simply
>>> +specify the access time in
>>> +.I attr_set
>>> +but must also set
>>> +.BR MOUNT_ATTR__ATIME
>>
>> s/.BR/.B/
>>
>> Please see a clarification earlier today in a different thread regarding
>> this in linux-man@:
>> <https://lore.kernel.org/linux-man/20210712155745.831580-1-mic@digikod.net/T/#t>
> 
> I'm not sure where this thread clarifies .BR/.B usage but I also
> honestly don't have time to dig through another thread to figure out
> correct formatting.

You can read this extract of groff_man(7), which after reading the 
extract I copied above about .I and .IR, should clarify it enough:

        .B [text]
               Set text in bold.  If the macro is  given  no  argu‐
               ments,  the  text  of  the next input line is set in
               bold.

               Use bold for literal portions  of  syntax  synopses,
               for  command‐line  options  in running text, and for
               literals that are major topics of the subject  under
               discussion;  for  example,  this  page uses bold for
               macro and register names.  In  .EX/.EE  examples  of
               interactive  I/O (such as a shell session), set only
               the user‐typed input in bold.

        [...]

        .BR bold‐text roman‐text ...
               Set each argument in bold and roman, alternately.

                      Any such change becomes effective with the
                      first use of
                      .BR .NH ,
                      .I after
                      the new alias is defined.

        .IB italic‐text bold‐text ...
               Set each argument in italics and bold, alternately.

                      All macro package files must be named
                      .IB name .tmac
                      to fully use the
                      .I tmac
                      mechanism.


        .RB roman‐text bold‐text ...
               Set each argument in roman and bold, alternately.

                      Also, the statement
                      .RB \(oq "delim on" \(cq
                      is not handled specially.

Roman there mean "normal" non-italics non-bold text.

> 
>>
>>> +in the
>>> +.I attr_clr
>>> +field.
>>> +The kernel will verify that
>>> +.BR MOUNT_ATTR__ATIME
>>> +isn't partially set in
>>> +.I attr_clr
>>> +and that
>>> +.I attr_set
>>> +doesn't have any access time bits set if
>>> +.BR MOUNT_ATTR__ATIME
>>> +isn't set in
>>> +.I attr_clr.
>>> +.RS
>>> +.TP
>>> +.B MOUNT_ATTR_RELATIME
>>> +When a file is accessed via this mount, update the file's last access time
>>> +(atime) only if the current value of atime is less than or equal to the file's
>>> +last modification time (mtime) or last status change time (ctime).
>>> +.IP
>>> +To enable this access time setting on a mount or mount tree
>>> +.BR MOUNT_ATTR_RELATIME
>>> +must be set in
>>> +.I attr_set
>>> +and
>>> +.BR MOUNT_ATTR__ATIME
>>> +must be set in the
>>> +.I attr_clr
>>> +field.
>>> +.TP
>>> +.BR MOUNT_ATTR_NOATIME
>>> +Do not update access times for (all types of) files on this mount.
>>> +.IP
>>> +To enable this access time setting on a mount or mount tree
>>> +.BR MOUNT_ATTR_NOATIME
>>> +must be set in
>>> +.I attr_set
>>> +and
>>> +.BR MOUNT_ATTR__ATIME
>>> +must be set in the
>>> +.I attr_clr
>>> +field.
>>> +.TP
>>> +.BR MOUNT_ATTR_STRICTATIME
>>> +Always update the last access time (atime) when files are accessed on this
>>> +mount.
>>> +.IP
>>> +To enable this access time setting on a mount or mount tree
>>> +.BR MOUNT_ATTR_STRICTATIME
>>> +must be set in
>>> +.I attr_set
>>> +and
>>> +.BR MOUNT_ATTR__ATIME
>>> +must be set in the
>>> +.I attr_clr
>>> +field.
>>> +.RE
>>> +.TP
>>> +.BR MOUNT_ATTR_IDMAP
>>> +If set in
>>> +.I attr_set
>>> +creates an idmapped mount.
>>> +The idmapping is taken from the user namespace specified in
>>> +.I userns_fd
>>> +and attached to the mount.
>>> +It is not supported to change the idmapping of a mount after it has been
>>> +idmapped.
>>> +Therefore, it is invalid to specify
>>> +.BR MOUNT_ATTR_IDMAP
>>> +in
>>> +.I attr_clr.
>>> +More details can be found in subsequent paragraphs.
>>> +.IP
>>> +Creating an idmapped mount allows to change the ownership of all files located
>>> +under a given mount.
>>> +Other mounts that expose the same files will not be affected,
>>> +i.e. the ownership will not be changed.
>>> +Consequently, a caller accessing files through an idmapped mount will see them
>>> +owned by the uid and gid according to the idmapping attached to the mount.
>>> +.IP
>>> +The idmapping is also applied to the following
>>> +.BR xattr (7)
>>> +namespaces:
>>> +.RS
>>> +.RS
>>> +.IP \(bu 2
>>> +The
>>
>> I'm not sure "The" should be there.
>> "security" alone reads better, IMHO.
> 
> I don't think so but I also don't care enough so sure.

Ahh, I was wrong.  I misunderstood the context.

> 
>>
>>> +.I security.
>>> +namespace when interacting with filesystem capabilities through the
>>> +.I security.capability
>>> +key whenever filesystem
>>> +.BR capabilities (7)
>>> +are stored or returned in the
>>> +.I VFS_CAP_REVISION_3
>>> +format which stores a rootid alongside the capabilities.
>>> +.IP \(bu 2
>>> +The
>>> +.I system.posix_acl_access
>>> +and
>>> +.I system.posix_acl_default
>>> +keys whenever uids or gids are stored in
>>> +.BR ACL_USER
>>> +and
>>> +.BR ACL_GROUP
>>> +entries.
>>> +.RE
>>> +.RE
>>> +.IP
>>> +The following conditions must be met in order to create an idmapped mount:
>>> +.RS
>>> +.RS
>>> +.IP \(bu 2
>>> +The caller must have
>>> +.I CAP_SYS_ADMIN
>>> +in the initial user namespace.
>>> +.IP \(bu 2
>>> +The filesystem must be mounted in the initial user namespace.
>>> +.IP \(bu
>>> +The underlying filesystem must support idmapped mounts.
>>> +Currently
>>> +.BR xfs (5),
>>> +.BR ext4 (5)
>>> +and
>>> +.BR fat
>>> +filesystems support idmapped mounts with more filesystems being actively worked
>>> +on.
>>> +.IP \(bu
>>> +The mount must not already be idmapped.
>>> +This also implies that the idmapping of a mount cannot be altered.
>>> +.IP \(bu
>>> +The mount must be a detached/anonymous mount,
>>> +i.e. it must have been created by calling
>>> +.BR open_tree (2)
>>> +with the
>>> +.I OPEN_TREE_CLONE
>>> +flag and it must not already have been visible in the filesystem.
>>> +.RE
>>> +.IP
>>
>> .IP here doesn't mean anything, if I'm not mistaken.
> 
> ok
> 
>> See groff_man(7).
>> If it affects the output anyhow (which I didn't check),
>> tell me and I'll check if I need to have a deeper look at this.
>>
>>> +.RE
>>> +.IP
>>> +In the common case the user namespace passed in
>>> +.I userns_fd
>>> +together with
>>> +.BR MOUNT_ATTR_IDMAP
>>> +in
>>> +.I attr_set
>>> +to create an idmapped mount will be the user namespace of a container.
>>> +In other scenarios it will be a dedicated user namespace associated with a
>>> +given user's login session as is the case for portable home directories in
>>> +.BR systemd-homed.service (8)).
>>> +Details on how to create user namespaces and how to setup idmappings can be
>>> +gathered from
>>> +.BR user_namespaces (7).
>>> +.IP
>>> +In essence, an idmapping associated with a user namespace is a 1-to-1 mapping
>>> +between source and target ids for a given range.
>>> +Specifically, an idmapping always has the abstract form
>>> +.I [type of id] [source id] [target id] [range].
>>
>> We don't want to format the ending period, as discussed in the linked
>> thread.  Consider using .IR as explained there.  Maybe nonbreaking spaces at
>> some points of this sequence are also necessary.
> 
> I've removed this part.
> 
>>
>> Nonbreaking spaces are \~
>>
>> You can see a discussion about nonbreaking spaces (of yesterday) here:
>> <https://lore.kernel.org/linux-man/90d6fcc8-70e6-5c44-5703-1c2bf2ad6913@gmail.com/T/#u>
> 
> I'm sorry, I'm not going to read a completely unrelated thread to
> figure out correct formatting. This is now the second thread I'm
> supposed to read.
> 
>>
>>> +For example, uid 1000 1001 1 would mean that uid 1000 is mapped to uid 1001,
>>> +gid 1000 1001 2 would mean that gid 1000 will be mapped to gid 1001 and gid
>>> +1001 to gid 1002.
>>> +If we were to attach the idmapping of uid 1000 1001 1 to a mount it would cause
>>> +all files owned by uid 1000 to be owned by uid 1001.
>>> +It is possible to specify up to 340 of such idmappings providing for a great
>>> +deal of flexibility.
>>> +If any source ids are not mapped to a target id all files owned by that
>>> +unmapped source id will appear as being owned by the overflow uid or overflow
>>> +gid respectively (see
>>> +.BR user_namespaces (7)
>>> +and
>>> +.BR proc (5)).
>>> +.IP
>>> +Idmapped mounts can be useful in the following and a variety of other
>>> +scenarios:
>>> +.RS
>>> +.RS
>>> +.IP \(bu 2
>>> +Idmapped mounts make it possible to easily share files between multiple users
>>> +or multiple machines especially in complex scenarios.
>>> +For example, idmapped mounts are used to implement portable home directories in
>>> +.BR systemd-homed.service (8)
>>> +where they allow users to move their home directory to an external storage
>>> +device and use it on multiple computers where they are assigned different uids
>>> +and gids.
>>> +This effectively makes it possible to assign random uids and gids at login
>>> +time.
>>> +.IP \(bu
>>> +It is possible to share files from the host with unprivileged containers
>>> +without having to change ownership permanently through
>>> +.BR chown (2).
>>> +.IP \(bu
>>> +It is possible to idmap a container's root filesystem without having to mangle
>>> +every file.
>>> +.IP \(bu
>>> +It is possible to share files between containers with non-overlapping
>>> +idmappings.
>>> +.IP \(bu
>>> +Filesystem that lack a proper concept of ownership such as fat can use idmapped
>>> +mounts to implement discretionary access (DAC) permission checking.
>>> +.IP \(bu
>>> +Idmapped mounts allow users to efficiently change ownership on a per-mount
>>> +basis without having to (recursively)
>>> +.BR chown (2)
>>> +all files. In contrast to
>>> +.BR chown (2)
>>> +changing ownership of large sets of files is instantenous with idmapped mounts.
>>> +This is especially useful when ownership of an entire root filesystem of a
>>> +virtual machine or container is to be changed.
>>> +With idmapped mounts a single
>>> +.BR mount_setattr (2)
>>> +system call will be sufficient to change the ownership of all files.
>>> +.IP \(bu
>>> +Idmapped mounts always take the current ownership into account as
>>> +idmappings specify what a given uid or gid is supposed to be mapped to.
>>> +This contrasts with the
>>> +.BR chown (2)
>>> +system call which cannot by itself take the current ownership of the files it
>>> +changes into account.
>>> +It simply changes the ownership to the specified uid and gid.
>>> +.IP \(bu
>>> +Idmapped mounts allow to change ownership locally,
>>> +restricting it to specific mounts,
>>> +and temporarily as the ownership changes only apply as long
>>> +as the mount exists.
>>> +In contrast, changing ownership via the
>>> +.BR chown (2)
>>> +system call changes the ownership globally and permanently.
>>> +.RE
>>> +.RE
>>> +.IP
>>
>> Another unused .IP?
> 
> removed
> 
>>
>> What did you mean?

See the following extract from groff_man(7):


        .LP
        .PP
        .P     Begin  a new paragraph; these macros are synonymous.
               They break the output line at the current  position,
               followed  by  a vertical space downward by a default
               amount (which can be changed by the  deprecated  .PD
               macro).   The  font  size and style are reset to de‐
               faults; see subsection “Font  style  macros”  below.
               Finally,  the  left margin and indentation are reset
               to default values.

        [...]

        .IP [tag] [indent]
               Set an indented paragraph with an optional tag.  The
               tag and indent arguments, if present, are handled as
               with .TP, with the exception that the  tag  argument
               to .IP cannot include a macro call.

               Two convenient use cases for .IP are

                      (1) to  start  a  new paragraph with the same
                          indentation as the previous  .IP  or  .TP
                          paragraph,   if  no  indent  argument  is
                          given; and

                      (2) to set a paragraph with a short tag  that
                          is  not semantically important, such as a
                          bullet (•)—obtained with the ‘\(bu’ char‐
                          acter  escape—or list enumerator, as seen
                          in this very paragraph.



>>
>>> +.PP
>>> +The
>>> +.I propagation
>>> +field is used to specify the propagation type of the mount or mount tree.
>>> +Mount propagation options are mutually exclusive,
>>> +i.e. the propagation values behave like an enum.
>>> +The supported mount propagation settings are:
>>> +.TP
>>> +.B MS_PRIVATE
>>> +Turn all mounts into private mounts.
>>> +Mount and unmount events do not propagate into or out of this mount point.
>>> +.TP
>>> +.B MS_SHARED
>>> +Turn all mounts into shared mounts.
>>> +Mount points share events with members of a peer group.
>>> +Mount and unmount events immediately under this mount point
>>> +will propagate to the other mount points that are members of the peer group.
>>> +Propagation here means that the same mount or unmount will automatically occur
>>> +under all of the other mount points in the peer group.
>>> +Conversely, mount and unmount events that take place under peer mount points
>>> +will propagate to this mount point.
>>> +.TP
>>> +.B MS_SLAVE
>>> +Turn all mounts into dependent mounts.
>>> +Mount and unmount events propagate into this mount point from a shared peer
>>> +group.
>>> +Mount and unmount events under this mount point do not propagate to any peer.
>>> +.TP
>>> +.B MS_UNBINDABLE
>>> +This is like a private mount, and in addition this mount can't be bind mounted.
>>> +Attempts to bind mount this mount will fail.
>>> +When a recursive bind mount is performed on a directory subtree,
>>> +any bind mounts within the subtree are automatically pruned
>>> +(i.e., not replicated) when replicating that subtree to produce the target
>>> +subtree.
>>> +.PP
>>> +.SH RETURN VALUE
>>> +On success,
>>> +.BR mount_setattr (2)
>>> +returns zero.
>>> +On error, \-1 is returned and
>>> +.I errno
>>> +is set to indicate the cause of the error.
>>> +.SH ERRORS
>>> +.TP
>>> +.B EBADF
>>> +.I dfd
>>> +is not a valid file descriptor.
>>> +.TP
>>> +.B EBADF
>>> +An invalid file descriptor value was specified in
>>> +.I userns_fd.
>>> +.TP
>>> +.B EBUSY
>>> +The caller tried to change the mount to
>>> +.BR MOUNT_ATTR_RDONLY
>>> +but the mount had writers.
>>> +.TP
>>> +.B EINVAL
>>> +The path specified via the
>>> +.I dfd
>>> +and
>>> +.I path
>>> +arguments to
>>> +.BR mount_setattr (2)
>>> +isn't a mountpoint.
>>> +.TP
>>> +.B EINVAL
>>> +An unsupported value was set in
>>> +.I flags.
>>> +.TP
>>> +.B EINVAL
>>> +An unsupported value was specified in the
>>> +.I attr_set
>>> +field of
>>> +.IR mount_attr.
>>> +.TP
>>> +.B EINVAL
>>> +An unsupported value was specified in the
>>> +.I attr_clr
>>> +field of
>>> +.IR mount_attr.
>>> +.TP
>>> +.B EINVAL
>>> +An unsupported value was specified in the
>>> +.I propagation
>>> +field of
>>> +.IR mount_attr.
>>> +.TP
>>> +.B EINVAL
>>> +More than one of
>>> +.BR MS_SHARED,
>>> +.BR MS_SLAVE,
>>> +.BR MS_PRIVATE,
>>> +or
>>> +.BR MS_UNBINDABLE
>>> +was set in
>>> +.I propagation
>>> +field of
>>> +.IR mount_attr.
>>> +.TP
>>> +.B EINVAL
>>> +An access time setting was specified in the
>>> +.I attr_set
>>> +field without
>>> +.BR MOUNT_ATTR__ATIME
>>> +being set in the
>>> +.I attr_clr
>>> +field.
>>> +.TP
>>> +.B EINVAL
>>> +.BR MOUNT_ATTR_IDMAP
>>> +was specified in
>>> +.I attr_clr.
>>> +.TP
>>> +.B EINVAL
>>> +A file descriptor value was specified in
>>> +.I userns_fd
>>> +which exceeds
>>> +.BR INT_MAX.
>>> +.TP
>>> +.B EINVAL
>>> +A valid file descriptor value was specified in
>>> +.I userns_fd
>>> +but the file descriptor wasn't a namespace file descriptor or did not refer to
>>> +a user namespace.
>>> +.TP
>>> +.B EINVAL
>>> +The underlying filesystem does not support idmapped mounts.
>>> +.TP
>>> +.B EINVAL
>>> +The mount to idmap is not a detached/anonymous mount, i.e. the mount is already
>>> +visible in the filesystem.
>>> +.TP
>>> +.B EINVAL
>>> +A partial access time setting was specified in
>>> +.I attr_clr
>>> +instead of
>>> +.BR MOUNT_ATTR__ATIME
>>> +being set.
>>> +.TP
>>> +.B EINVAL
>>> +The mount is located outside the caller's mount namespace.
>>> +.TP
>>> +.B EINVAL
>>> +The underlying filesystem is mounted in a user namespace.
>>> +.TP
>>> +.B ENOENT
>>> +A pathname was empty or had a nonexistent component.
>>> +.TP
>>> +.B ENOMEM
>>> +When changing mount propagation to
>>> +.BR MS_SHARED
>>> +a new peer group id needs to be allocated for all mounts without a peer group
>>> +id set.
>>> +Allocation of this peer group id has failed.
>>> +.TP
>>> +.B ENOSPC
>>> +When changing mount propagation to
>>> +.BR MS_SHARED
>>> +a new peer group id needs to be allocated for all mounts without a peer group
>>> +id set.
>>> +Allocation of this peer group id can fail.
>>> +Note that technically further error codes are possible that are specific to the
>>> +id allocation implementation used.
>>> +.TP
>>> +.B EPERM
>>> +One of the mounts had at least one of
>>> +.BR MOUNT_ATTR_RDONLY,
>>> +.BR MOUNT_ATTR_NODEV,
>>> +.BR MOUNT_ATTR_NOSUID,
>>> +.BR MOUNT_ATTR_NOEXEC,
>>> +.BR MOUNT_ATTR_NOATIME,
>>> +or
>>> +.BR MOUNT_ATTR_NODIRATIME
>>> +set and the flag is locked.
>>> +Mount attributes become locked on a mount if:
>>> +.RS
>>> +.IP \(bu 2
>>> +a new mount or mount tree is created causing mount propagation across user
>>> +namespaces.
>>> +The kernel will lock the aforementioned flags to protect these sensitive
>>> +properties from being altered.
>>> +.IP \(bu
>>> +a new mount and user namespace pair is created.
>>> +This happens for example when specifying
>>> +.BR CLONE_NEWUSER | CLONE_NEWNS
>>> +in
>>> +.BR unshare (2),
>>> +.BR clone (2),
>>> +or
>>> +.BR clone3 (2).
>>> +The aformentioned flags become locked to protect user namespaces from altering
>>> +sensitive mount properties.
>>> +.RE
>>> +.TP
>>> +.B EPERM
>>> +A valid file descriptor value was specified in
>>> +.I userns_fd
>>> +but the file descriptor refers to the initial user namespace.
>>> +.TP
>>> +.B EPERM
>>> +An already idmapped mount was supposed to be idmapped.
>>> +.TP
>>> +.B EPERM
>>> +The caller does not have
>>> +.I CAP_SYS_ADMIN
>>> +in the initial user namespace.
>>> +.SH VERSIONS
>>> +.BR mount_setattr (2)
>>> +first appeared in Linux 5.12.
>>> +.\" commit 7d6beb71da3cc033649d641e1e608713b8220290
>>> +.\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
>>> +.\" commit 9caccd41541a6f7d6279928d9f971f6642c361af
>>> +.SH CONFORMING TO
>>> +.BR mount_setattr (2)
>>> +is Linux specific.
>>> +.SH NOTES
>>> +Currently, there is no glibc wrapper for this system call;
>>> +call it using
>>> +.BR syscall (2).
>>> +.\"
>>> +.SS Extensibility
>>> +In order to allow for future extensibility,
>>> +.BR mount_setattr (2)
>>> +along with other system calls such as
>>> +.BR openat2 (2)
>>> +and
>>> +.BR clone3 (2)
>>> +requires the user-space application to specify the size of the
>>> +.I mount_attr
>>> +structure that it is passing.
>>> +By providing this information, it is possible for
>>> +.BR mount_setattr (2)
>>> +to provide both forwards- and backwards-compatibility, with
>>> +.I size
>>> +acting as an implicit version number.
>>> +(Because new extension fields will always
>>> +be appended, the structure size will always increase.)
>>> +This extensibility design is very similar to other system calls such as
>>> +.BR perf_setattr (2),
>>> +.BR perf_event_open (2),
>>> +.BR clone3 (2)
>>> +and
>>> +.BR openat2 (2) .
>>> +.PP
>>> +Let
>>> +.I usize
>>> +be the size of the structure as specified by the user-space application,
>>> +and let
>>> +.I ksize
>>> +be the size of the structure which the kernel supports,
>>> +then there are three cases to consider:
>>> +.IP \(bu 2
>>> +If
>>> +.IR ksize
>>> +equals
>>> +.IR usize ,
>>> +then there is no version mismatch and
>>> +.I attr
>>> +can be used verbatim.
>>> +.IP \(bu
>>> +If
>>> +.IR ksize
>>> +is larger than
>>> +.IR usize ,
>>> +then there are some extension fields that the kernel supports which the
>>> +user-space application is unaware of.
>>> +Because a zero value in any added extension field signifies a no-op,
>>> +the kernel treats all of the extension fields not provided by the user-space
>>> +application as having zero values.
>>> +This provides backwards-compatibility.
>>> +.IP \(bu
>>> +If
>>> +.IR ksize
>>> +is smaller than
>>> +.IR usize ,
>>> +then there are some extension fields which the user-space application is aware
>>> +of but which the kernel does not support.
>>> +Because any extension field must have its zero values signify a no-op,
>>> +the kernel can safely ignore the unsupported extension fields if they are
>>> +all zero.
>>> +If any unsupported extension fields are non-zero, then \-1 is returned and
>>> +.I errno
>>> +is set to
>>> +.BR E2BIG .
>>> +This provides forwards-compatibility.
>>> +.PP
>>> +Because the definition of
>>> +.I struct mount_attr
>>> +may change in the future
>>> +(with new fields being added when system headers are updated),
>>> +user-space applications should zero-fill
>>> +.I struct mount_attr
>>> +to ensure that recompiling the program with new headers will not result in
>>> +spurious errors at runtime.
>>> +The simplest way is to use a designated initializer:
>>> +.PP
>>> +.in +4n
>>> +.EX
>>> +struct mount_attr attr = {
>>> +    .attr_set = MOUNT_ATTR_RDONLY,
>>> +    .attr_clr = MOUNT_ATTR_NODEV
>>> +};
>>> +.EE
>>> +.in
>>> +.PP
>>> +or explicitly using
>>> +.BR memset (3)
>>> +or similar functions:
>>> +.PP
>>> +.in +4n
>>> +.EX
>>> +struct mount_attr attr;
>>> +memset(&attr, 0, sizeof(attr));
>>> +attr.attr_set = MOUNT_ATTR_RDONLY;
>>> +attr.attr_clr = MOUNT_ATTR_NODEV;
>>> +.EE
>>> +.in
>>> +.PP
>>> +A user-space application that wishes to determine which extensions the running
>>> +kernel supports can do so by conducting a binary search on
>>> +.IR size
>>> +with a structure which has every byte nonzero
>>> +(to find the largest value which doesn't produce an error of
>>> +.BR E2BIG ).
>>> +.SH EXAMPLES
>>> +.EX
>>> +/*
>>> + * This program allows the caller to create a new detached mount and set
>>> + * various properties on it.
>>> + */
>>> +#define _GNU_SOURCE
>>> +#include <errno.h>
>>> +#include <fcntl.h>
>>> +#include <getopt.h>
>>> +#include <linux/mount.h>
>>> +#include <linux/types.h>
>>> +#include <stdbool.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <sys/syscall.h>
>>> +#include <unistd.h> > +
>>> +/* mount_setattr() */
>>> +#ifndef MOUNT_ATTR_RDONLY
>>> +#define MOUNT_ATTR_RDONLY 0x00000001
>>> +#endif
>>> +
>>> +#ifndef MOUNT_ATTR_NOSUID
>>> +#define MOUNT_ATTR_NOSUID 0x00000002
>>> +#endif
>>> +
>>> +#ifndef MOUNT_ATTR_NOEXEC
>>> +#define MOUNT_ATTR_NOEXEC 0x00000008
>>> +#endif
>>> +
>>> +#ifndef MOUNT_ATTR__ATIME
>>> +#define MOUNT_ATTR__ATIME 0x00000070
>>> +#endif
>>> +
>>> +#ifndef MOUNT_ATTR_NOATIME
>>> +#define MOUNT_ATTR_NOATIME 0x00000010
>>> +#endif
>>> +
>>> +#ifndef MOUNT_ATTR_IDMAP
>>> +#define MOUNT_ATTR_IDMAP 0x00100000
>>> +#endif
>>> +
>>> +#ifndef AT_RECURSIVE
>>> +#define AT_RECURSIVE 0x8000
>>> +#endif
>>> +
>>> +#ifndef __NR_mount_setattr
>>> +    #if defined __alpha__
>>> +        #define __NR_mount_setattr 552
>>> +    #elif defined _MIPS_SIM
>>> +        #if _MIPS_SIM == _MIPS_SIM_ABI32    /* o32 */
>>> +            #define __NR_mount_setattr (442 + 4000)
>>> +        #endif
>>> +        #if _MIPS_SIM == _MIPS_SIM_NABI32   /* n32 */
>>> +            #define __NR_mount_setattr (442 + 6000)
>>> +        #endif
>>> +        #if _MIPS_SIM == _MIPS_SIM_ABI64    /* n64 */
>>> +            #define __NR_mount_setattr (442 + 5000)
>>> +        #endif
>>> +    #elif defined __ia64__
>>> +        #define __NR_mount_setattr (442 + 1024)
>>> +    #else
>>> +        #define __NR_mount_setattr 442
>>> +    #endif
>>> +struct mount_attr {
>>> +    __u64 attr_set;
>>> +    __u64 attr_clr;
>>> +    __u64 propagation;
>>> +    __u64 userns_fd;
>>> +};
>>> +#endif
>>
>> I guess all these are to cover the case of a new kernel with an old glibc,
>> right?
>> Do we really want them here?
> 
> I've removed the syscall number handling and the struct definition and
> am only leaving the static inline syscall defines.
> 
>> The example program would be much simpler without all of that compatibility
>> layer, and it's just an example...
>>
>> Also, why use __NR_* macros instead of SYS_* ones?
>> __* identifiers are for internal implementation stuff, per the standard, so
>> the ones intended for user applications would be SYS_*, AFAIK.
>>
>>
>> Also, user-space applications shouldn't use __u64 types, AFAIK.
>> The kernel provides u64 for that matter, AFAIK.
> 
> No, userspace uses "__" types So __u64 is a uapi type and u64 is a
> kernel internal type that isn't exposed to userspace. See uapi
> definitions for bpf, clone3, mount_setattr, openat2 etc.

Ahh I was wrong.  I remembered it the other way around.

> 
> This is a definition of the struct the kernel exposes to userspace as
> uapi. If glibc wraps mount_setattr and uses uint64_t or something else
> to expose the struct then the manpage can change but until then this
> describes the uapi and so should use the proper uapi types.

Okay.

> 
> 
>> And eventhough the kernel provides u64, IMO, a user should try to use
>> standard types, except maybe for some cases if really necessary.
>> See a loong discussion here : <https://lore.kernel.org/linux-man/alpine.DEB.2.22.394.2105052219590.508961@digraph.polyomino.org.uk/T/#m8581dc5baee9023c671f0d210776be599cd375e6>
> 
> That's the bpf dicussion and you got a long list of NAKs on replacing
> kernel uapi types and I agree with the bpf folks there.

Yup, there were some mixed ACKs and NAKs, so I won't force my opinion on 
that.  Only suggest it.

> 
>>
>>
>>> +
>>> +/* open_tree() */
>>> +#ifndef OPEN_TREE_CLONE
>>> +#define OPEN_TREE_CLONE 1
>>> +#endif
>>> +
>>> +#ifndef OPEN_TREE_CLOEXEC
>>> +#define OPEN_TREE_CLOEXEC O_CLOEXEC
>>> +#endif
>>> +
>>> +#ifndef __NR_open_tree
>>> +    #if defined __alpha__
>>> +        #define __NR_open_tree 538
>>> +    #elif defined _MIPS_SIM
>>> +        #if _MIPS_SIM == _MIPS_SIM_ABI32    /* o32 */
>>> +            #define __NR_open_tree 4428
>>> +        #endif
>>> +        #if _MIPS_SIM == _MIPS_SIM_NABI32   /* n32 */
>>> +            #define __NR_open_tree 6428
>>> +        #endif
>>> +        #if _MIPS_SIM == _MIPS_SIM_ABI64    /* n64 */
>>> +            #define __NR_open_tree 5428
>>> +        #endif
>>> +    #elif defined __ia64__
>>> +        #define __NR_open_tree (428 + 1024)
>>> +    #else
>>> +        #define __NR_open_tree 428
>>> +    #endif
>>> +#endif
>>> +
>>> +/* move_mount() */
>>> +#ifndef MOVE_MOUNT_F_EMPTY_PATH
>>> +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
>>> +#endif
>>> +
>>> +#ifndef __NR_move_mount
>>> +    #if defined __alpha__
>>> +        #define __NR_move_mount 539
>>> +    #elif defined _MIPS_SIM
>>> +        #if _MIPS_SIM == _MIPS_SIM_ABI32    /* o32 */
>>> +            #define __NR_move_mount 4429
>>> +        #endif
>>> +        #if _MIPS_SIM == _MIPS_SIM_NABI32   /* n32 */
>>> +            #define __NR_move_mount 6429
>>> +        #endif
>>> +        #if _MIPS_SIM == _MIPS_SIM_ABI64    /* n64 */
>>> +            #define __NR_move_mount 5429
>>> +        #endif
>>> +    #elif defined __ia64__
>>> +        #define __NR_move_mount (428 + 1024)
>>> +    #else
>>> +        #define __NR_move_mount 429
>>> +    #endif
>>> +#endif
>>> +
>>> +static inline int mount_setattr(int dfd,
>>> +                                const char *path,
>>> +                                unsigned int flags,
>>> +                                struct mount_attr *attr,
>>> +                                size_t size)
>>> +{
>>> +    return syscall(__NR_mount_setattr, dfd, path,
>>> +                   flags, attr, size);
>>> +}
>>> +
>>> +static inline int open_tree(int dfd, const char *filename,
>>> +                            unsigned int flags)
>>> +{
>>> +    return syscall(__NR_open_tree, dfd, filename, flags);
>>> +}
>>> +
>>> +static inline int move_mount(int from_dfd,
>>> +                             const char *from_pathname,
>>> +                             int to_dfd,
>>> +                             const char *to_pathname,
>>> +                             unsigned int flags)
>>> +{
>>> +    return syscall(__NR_move_mount, from_dfd,
>>> +                   from_pathname, to_dfd, to_pathname, flags);
>>> +}
>>> +
>>> +static const struct option longopts[] = {
>>> +    {"map-mount",       required_argument,  0,  'a'},
>>> +    {"recursive",       no_argument,        0,  'b'},
>>> +    {"read-only",       no_argument,        0,  'c'},
>>> +    {"block-setid",     no_argument,        0,  'd'},
>>> +    {"block-devices",   no_argument,        0,  'e'},
>>> +    {"block-exec",      no_argument,        0,  'f'},
>>> +    {"no-access-time",  no_argument,        0,  'g'},
>>> +    { NULL,             0,                  0,   0 },
>>> +};
>>> +
>>> +#define exit_log(format, ...)                   \\
>>> +    ({                                          \\
>>> +        fprintf(stderr, format, ##__VA_ARGS__); \\
>>> +        exit(EXIT_FAILURE);                     \\
>>> +    })
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +    int fd_userns = -EBADF, index = 0;
>>> +    bool recursive = false;
>>> +    struct mount_attr *attr = &(struct mount_attr){};
>>> +    const char *source, *target;
>>> +    int fd_tree, new_argc, ret;
>>> +    char *const *new_argv;
>>> +
>>> +    while ((ret = getopt_long_only(argc, argv, "",
>>> +                                  longopts, &index)) != -1) {
>>> +        switch (ret) {
>>> +        case 'a':
>>> +            fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);
>>> +            if (fd_userns < 0)
>>> +                exit_log("%m - Failed top open %s\n", optarg);
>>
>>
>> Use \e to write the escape sequence in groff.  See groff_man(7):
> 
> ok
> 
>>
>>         \e     Widely used in man pages to  represent  a  backslash
>>                output  glyph.  It works reliably as long as the .ec
>>                request is not used, which should  never  happen  in
>>                man pages, and it is slightly more portable than the
>>                more exact ‘\(rs’  (“reverse  solidus”)  escape  se‐
>>                quence.
>>
>> \n is interpreted by groff(1) and not translated verbatim into the output.
>>
>> To test the example program you can copy it from the rendered page (tip:
>> pipe it to cat(1)) and paste it into a file and then compile that.
>>
>>
>>> +            break;
>>> +        case 'b':
>>> +            recursive = true;
>>> +            break;
>>> +        case 'c':
>>> +            attr->attr_set |= MOUNT_ATTR_RDONLY;
>>> +            break;
>>> +        case 'd':
>>> +            attr->attr_set |= MOUNT_ATTR_NOSUID;
>>> +            break;
>>> +        case 'e':
>>> +            attr->attr_set |= MOUNT_ATTR_NODEV;
>>> +            break;
>>> +        case 'f':
>>> +            attr->attr_set |= MOUNT_ATTR_NOEXEC;
>>> +            break;
>>> +        case 'g':
>>> +            attr->attr_set |= MOUNT_ATTR_NOATIME;
>>> +            attr->attr_clr |= MOUNT_ATTR__ATIME;
>>> +            break;
>>> +        default:
>>> +            exit_log("Invalid argument specified");
>>> +        }
>>> +    }
>>> +
>>> +    new_argv = &argv[optind];
>>> +    new_argc = argc - optind;
>>> +    if (new_argc < 2)
>>> +        exit_log("Missing source or target mountpoint\n");
>>> +    source = new_argv[0];
>>> +    target = new_argv[1];
>>> +
>>> +    fd_tree = open_tree(-EBADF, source,
>>> +                        OPEN_TREE_CLONE |
>>> +                        OPEN_TREE_CLOEXEC |
>>> +                        AT_EMPTY_PATH |
>>> +                        (recursive ? AT_RECURSIVE : 0));
>>> +    if (fd_tree < 0)
>>> +        exit_log("%m - Failed to open %s\n", source);
>>> +
>>> +    if (fd_userns >= 0) {
>>> +        attr->attr_set  |= MOUNT_ATTR_IDMAP;
>>> +        attr->userns_fd = fd_userns;
>>> +    }
>>> +    ret = mount_setattr(fd_tree, "",
>>> +                        AT_EMPTY_PATH |
>>> +                        (recursive ? AT_RECURSIVE : 0),
>>> +                        attr, sizeof(struct mount_attr));
>>> +    if (ret < 0)
>>> +        exit_log("%m - Failed to change mount attributes\n");
>>> +    close(fd_userns);
>>> +
>>> +    ret = move_mount(fd_tree, "", -EBADF, target,
>>> +                     MOVE_MOUNT_F_EMPTY_PATH);
>>> +    if (ret < 0)
>>> +        exit_log("%m - Failed to attach mount to %s\n", target);
>>> +    close(fd_tree);
>>> +
>>> +    exit(EXIT_SUCCESS);
>>> +}
>>> +.EE
>>> +.fi
>>> +.SH SEE ALSO
>>> +.BR capabilities (7),
>>> +.BR clone (2),
>>> +.BR clone3 (2),
>>> +.BR ext4 (5),
>>> +.BR mount (2),
>>> +.BR mount_namespaces (7),
>>> +.BR newuidmap (1),
>>> +.BR newgidmap (1),
>>> +.BR proc (5),
>>> +.BR unshare (2),
>>> +.BR user_namespaces (7),
>>> +.BR xattr (7),
>>> +.BR xfs (5)
>>>
>>> base-commit: fbe71b1b79e72be3b9afc44b5d479e7fd84b598a
>>>
>>
>>
>> -- 
>> Alejandro Colomar
>> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
>> http://www.alejandro-colomar.es/


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
