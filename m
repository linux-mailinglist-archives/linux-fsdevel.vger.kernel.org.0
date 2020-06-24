Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085B12077C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbgFXPln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:41:43 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:36387
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404235AbgFXPlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593013300; bh=Dhys375vlyZYm8Ra4CA3t0cqtfMxqok7JpN+dbu2zhQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mCr/+nVWuFV8upxA/hRon6D8FlUc1EILZG+cbv3qkSg5rTjXgg6WkirhUGxAwv3jKXa2a2yYeokjPfcMcbYpLfvvCZX31237cYQnt8wfGQoFs2bM5K1aVmrdst/k78I32y90UWkpJYFVvMbsAGXA7OLqWG6vz8jJZJOX76Ap8/u4JUSluEboSuMbGosHKWXz+swXTac5Q6pUEkkT6nGnDXAAjyhNfSWmISANFDP6MuLB3GZpSvViymlm+bBfc1WScsCE6l77rqqLDBfyqZVyec1glqEchYSrdmS5yp5Tgl2Z5JfKNUpHI5XvYbBWsLJpibN3rqCk6o16947HJVOK6g==
X-YMail-OSG: 3.43OegVM1nvctIiVOWVEtfptGPuuw8gMmJge0iKY41Zh_yO8EMoafQ7KyORN_Z
 rOx0rU2XIgJti6OZ.qTUAT8.TKvltAYwleaVQ2aPSIhnMWDY44OB7f3fR1eupqLFXNJHHaNCtNBD
 c7qiZ6w8y0YFIpdGMvKj7sKJn6mFRD9_9rMlngvGozrZjb7xVnuKg0f._3qxio1.V0.mK7tvp71e
 kB2s.6ALQyu1XlHZDTRjX5_azmFf8VnnEKuwnkOMmfSkwQOqLdYdrHAkqDPvI1aqbrHSxaaoVCgq
 iICphgi9CyrLk34lT6lvgjz4q7dzxzJzr4igMutKbrr6EgMOR8PQDKGrdjRll0eXH9Z5L.aGwK7R
 exqHPV478mg8BusqNmVJl8QmrC_qXXux3GNTEsFFFkVQCxoKEB9b2TWmPWAfTqXo7cVt6r0Mq85U
 Ue6KJiwBw9Z6tUdSQIADUS8wlbCdfLXAjI1qMnmnnpvIcxA7qqvhHPIAQPx.oVXJ9qdrpcI3Rrnv
 ERKtRdgLdP589ML3lvCiwjpXp6gaWIgPSAiG9WhxSamj9irPMU7zTErp_vq5yQ44LIuuITB06sql
 Dmgt4HlyyRRilySv5ki0zHTVJ9mQwnUFL4rMZQW9_9baWGspqR7yQreBKF5DYvhcSzZeJObRP_EI
 MFnINsG1avcU7jgEDN6czR64jbwuRgCdZ_7zYN869yBnyKTyYGUiJK4.onxNN3jBJCzFQN6Fw2jX
 x3xWSc8LBBiAB2VK_llYlFyip4rvr0O2ihH_qCzsiUSj8trupAmjbl1ZDC00TQz8ee2V_yOFuMFX
 GwyRC5thDQ91hEW3z1HSZaCqEbPHko3kQzvQsSwqaF6wXYI6zlUyZPZpc_0apTFjIByV9KkHCeiI
 t.dRB0ZU4KPIJVjY9DXjjwUAJUlLSGlWjQtF3ZThb43z07iGR7HBH_o.mpaDNuaytUqHUHpemvFc
 VTYGV2rDphZlQU7U5k5Ue.12QXsVFYLFx7jHCRFgQMJyl2IAdU8h5f5mlfwqyxIglUQvXk50PMs9
 xmiEfQ.6rKFKYsbRSqW1tyQJFn7sEFbNeSAlGcdtP_qj.E0YNH3BWRlcMxlpS51Elc2gphIatkaH
 CXEMqt8OA6tKmQIe3j_s3gY0K8y7EAXH2DhthI4iheW2bHsbK_Pg3OrH6H2Lf7MLfmGj1MQk78V2
 DNxFuobeDADCcpSVzmGMt6mdsRzeQDIN27lab.APxzofNErXShk4mOSH.T3S9XYZDr6t.3IiCajA
 0tewg496QDESFcLnT1ZSV9jnsAvw9gGqtP9MmIQTPsX0cXo20FAqNuZU4rvJysYsNfP6tsGvffRr
 dQc6AqnHTSeLfVSFQgGpddAxVhR.6jWRTlWxOdcGlOOZxsyHpBEVEWLgZ96IfoGpXizA4ucfHGyz
 0s8r4VPfMnrbt.Tlhyorp9dFY.fUOuSM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Jun 2020 15:41:40 +0000
Received: by smtp421.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 99d8225b956cba644f47d6b97428fa53;
          Wed, 24 Jun 2020 15:41:39 +0000 (UTC)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
 <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
 <5254444e-465e-6dee-287b-bef58526b724@i-love.sakura.ne.jp>
 <20200624063940.ctzhf4nnh3cjyxqi@ast-mbp.dhcp.thefacebook.com>
 <321b85b4-95f0-2f9b-756a-8405adc97230@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <748ef005-7f64-ab9b-c767-c617ec995df4@schaufler-ca.com>
Date:   Wed, 24 Jun 2020 08:41:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <321b85b4-95f0-2f9b-756a-8405adc97230@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16138 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/2020 12:05 AM, Tetsuo Handa wrote:
> Forwarding to LSM-ML again. Any comments?

Hey, BPF folks - you *really* need to do better about keeping the LSM
community in the loop when you're discussing LSM issues.=20

>
> On 2020/06/24 15:39, Alexei Starovoitov wrote:
>> On Wed, Jun 24, 2020 at 01:58:33PM +0900, Tetsuo Handa wrote:
>>> On 2020/06/24 13:00, Alexei Starovoitov wrote:
>>>>> However, regarding usermode_blob, although the byte array (which co=
ntains code / data)
>>>>> might be initially loaded from the kernel space (which is protected=
), that byte array
>>>>> is no longer protected (e.g. SIGKILL, strace()) when executed becau=
se they are placed
>>>>> in the user address space. Thus, LSM modules (including pathname ba=
sed security) want
>>>>> to control how that byte array can behave.
>>>> It's privileged memory regardless. root can poke into kernel or any =
process memory.
>>> LSM is there to restrict processes running as "root".
>> hmm. do you really mean that it's possible for an LSM to restrict CAP_=
SYS_ADMIN effectively?

I think that SELinux works hard to do just that. SELinux implements it's =
own
privilege model that is tangential to the capabilities model.

More directly, it is simple to create a security module to provide finer =
privilege
granularity than capabilities. I have one lurking in a source tree, and I=
 would
be surprised if it's the only one waiting for the next round of LSM stack=
ing.

>> LSM can certainly provide extra level of foolproof-ness against accide=
ntal
>> mistakes, but it's not a security boundary.

Gasp! Them's fight'n words. How do you justify such an outrageous claim?

>>> Your "root can poke into kernel or any process memory." response is o=
ut of step with the times.
>>>
>>> Initial byte array used for usermode blob might be protected because =
of "part of .rodata or
>>> .init.rodata of kernel module", but that byte array after started in =
userspace is no longer
>>> protected.=20
>>>
>>> I don't trust such byte array as "part of kernel module", and I'm ask=
ing you how
>>> such byte array does not interfere (or be interfered by) the rest of =
the system.
>> Could you please explain the attack vector that you see in such scenar=
io?
>> How elf binaries embedded in the kernel modules different from pid 1?
>> If anything can peek into their memory the system is compromised.
>> Say, there are no user blobs in kernel modules. How pid 1 memory is di=
fferent
>> from all the JITed images? How is it different for all memory regions =
shared
>> between kernel and user processes?
>> I see an opportunity for an LSM to provide a protection against non-se=
curity
>> bugs when system is running trusted apps, but not when arbitrary code =
can
>> execute under root.
>>

