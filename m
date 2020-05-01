Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79E51C11B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgEAL5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 07:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728570AbgEAL5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 07:57:07 -0400
X-Greylist: delayed 580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 May 2020 04:57:07 PDT
Received: from mail.python.org (mail.python.org [IPv6:2a03:b0c0:2:d0::71:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA5CC061A0C;
        Fri,  1 May 2020 04:57:07 -0700 (PDT)
Received: from seneca.home.cheimes.de (unknown [IPv6:2a04:4540:6518:8b00:aeec:f92b:b752:e7b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 49D9Tn1CB7zpF9Y;
        Fri,  1 May 2020 07:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1588333645; bh=pdFhsqmsyyF982XVgDC/+dtkNy2N/bbOczqXOrMoUoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lXIut7Jn4M4RU8tl6bpmrZKQ/kENOTJHinPDmX2e7ubiJNwM0q2RyVhrFtPudEZM5
         yst2cFm1JLYN1V8aYq6YNB0/KfHLKNMp0/GLnmO4DHs47Ro/wdNM1c3ZuLTVMG8xoc
         fuG6fIDNLRkMRaDrECtOjX8iPca9JQtw9zfA7fbg=
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
To:     Jann Horn <jannh@google.com>, Florian Weimer <fw@deneb.enyo.de>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200428175129.634352-1-mic@digikod.net>
 <CAG48ez1bKzh1YvbD_Lcg0AbMCH_cdZmrRRumU7UCJL=qPwNFpQ@mail.gmail.com>
 <87blnb48a3.fsf@mid.deneb.enyo.de>
 <CAG48ez2TphTj-VdDaSjvnr0Q8BhNmT3n86xYz4bF3wRJmAMsMw@mail.gmail.com>
From:   Christian Heimes <christian@python.org>
Autocrypt: addr=christian@python.org; prefer-encrypt=mutual; keydata=
 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
 53+DNOMi/34rdBwm0I62QkVYJYU=
Message-ID: <b78d2d0d-04cf-c0a9-bd88-20c6ec6705fd@python.org>
Date:   Fri, 1 May 2020 13:47:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAG48ez2TphTj-VdDaSjvnr0Q8BhNmT3n86xYz4bF3wRJmAMsMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/04/2020 00.01, Jann Horn wrote:
> On Tue, Apr 28, 2020 at 11:21 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>> * Jann Horn:
>>
>>> Just as a comment: You'd probably also have to use RESOLVE_MAYEXEC in
>>> the dynamic linker.
>>
>> Absolutely.  In typical configurations, the kernel does not enforce
>> that executable mappings must be backed by files which are executable.
>> It's most obvious with using an explicit loader invocation to run
>> executables on noexec mounts.  RESOLVE_MAYEXEC is much more useful
>> than trying to reimplement the kernel permission checks (or what some
>> believe they should be) in userspace.
> 
> Oh, good point.
> 
> That actually seems like something Mickaël could add to his series? If
> someone turns on that knob for "When an interpreter wants to execute
> something, enforce that we have execute access to it", they probably
> also don't want it to be possible to just map files as executable? So
> perhaps when that flag is on, the kernel should either refuse to map
> anything as executable if it wasn't opened with RESOLVE_MAYEXEC or
> (less strict) if RESOLVE_MAYEXEC wasn't used, print a warning, then
> check whether the file is executable and bail out if not?
> 
> A configuration where interpreters verify that scripts are executable,
> but other things can just mmap executable pages, seems kinda
> inconsistent...

+1

I worked with Steve Downer on Python PEP 578 [1] that added audit hooks
and PyFile_OpenCode() to CPython. A PyFile_OpenCode() implementation
with RESOLVE_MAYEXEC will hep to secure loading of Python code. But
Python also includes a wrapper of libffi. ctypes or cffi can load native
code from either shared libraries with dlopen() or execute native code
from mmap() regions. For example SnakeEater [2] is a clever attack that
abused memfd_create syscall and proc filesystem to execute code.

A consistent security policy must also ensure that mmap() PROT_EXEC
enforces the same restrictions as RESOLVE_MAYEXEC. The restriction
doesn't have be part of this patch, though.

Christian

[1] https://www.python.org/dev/peps/pep-0578/
[2] https://github.com/nullbites/SnakeEater/blob/master/SnakeEater2.py
