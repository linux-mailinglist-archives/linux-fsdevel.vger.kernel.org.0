Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91A558995E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiHDIky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiHDIkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86522B2C;
        Thu,  4 Aug 2022 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659602441;
        bh=/KWunlLlCXBxdQLa4M371vyW0miwXwP6bA8Qrbv3P4A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=A9QI4AA554PQTTAUkdU8v/7do3Yjxln+4zCC4Rxpvac/VZjoi1SwMFfnRX7If/qdJ
         Jpk8alCLbU7/tdRDym6yN8kKrNtZCo6omqiq7lXmkE3IT+fzyDxyzEJWhcwgx6/iR7
         5DybDZtymZCrclGjxEvdwE8fSAOmYrZgR0453NUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.176.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1nWnfs0FEn-00vhHE; Thu, 04
 Aug 2022 10:40:41 +0200
Message-ID: <2f4c1abb-ca27-178a-31c3-5e422613e7e8@gmx.de>
Date:   Thu, 4 Aug 2022 10:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Dump command line of faulting process to syslog
Content-Language: en-US
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801152016.36498-1-deller@gmx.de>
 <YugGFEjJvIwzifq7@localhost> <a0bf15a2-2f9c-5603-3adb-ffa705572a92@gmx.de>
 <Yut+0Fg7F99MI48J@localhost>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Yut+0Fg7F99MI48J@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3GbtEcRdm4ZKQrToTNgAcxFNIFaXcDrbttEfipVSvnfyaK9MYfH
 yArPiikB//XE1jVgg3ox3WC5+qCbiqXXzv0c99TVW+kebVHGU4nSUQbE6KLSmc8lr3/2qar
 M3KnmtcPJ8iqTGVSOZQa71wZ9a5FSpHfWS0DyWHtVAF4MDP9zWN3Be13EacIMTgFZNzGNPh
 CNV5tVKe/1wOpM42Z57IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vGH8jOU6g9s=:OE2QiVQChxS4HNJOL92EOu
 w0wNSUjUdH2q+UkzawQ7VwyhWbPJbxVHI3wy+yNUjt4IVCbH7fbrZhfnVDlkSU5+aQNSAEmrd
 JR8SdC3lU6DCwAica2FiXosHNPXUFEawJHKRXR6XMzTUxChsUnPuPtrPlEI3G0Qgo+90AGHDZ
 MDQGrEDyQNFqTQ1sZCnYd98zJtqxDSVQ/rp7cKNci+X26hhDSKvh0hRY4MyAbMp+J6G1NEJRQ
 F9VoQ59DiIMHM2zRqh5KfB4nOfa7UCncGmP8CJID5MzowZY1B6QjaqC6LmOWIQZNXvVDDvS+N
 j8SKoVuNW2Jl9Hwc0zvMm7W57SkHrGR8tqEDpX0kjrNrefuh5C09L+DqwXyVheFmTtjbnX5Ti
 Yr1Ox/rew3eUBg0N8To4s9qqrk1f8kNvleLcZTFhxrP/nWiep6PImdvLZIt+4ngYnWOpsht99
 V0gVaT/slGn65HitVUFNbQmDc1iSECcayAv5JnshZjT0/LbiNA8yv6DCmfZ2elrOucspDzHe9
 ED4A5mN1lJ30aLI0qAig8wMC2D5wtvubn12H4ArgRrHVqKPlyv/kw3NxV6rWhhNZmhh3uHe1V
 zbm22HZz/O0COSmmnTUuJamTMMCOzLbpFvHfEAJvb6ksw9EtcF4X4cWLR/cTe0gCXvzbLWcIN
 jY9sBYPdOQvGFUayehGVCLRfIstW9f3CG8g9EnwI8nnUjmueQYnfpEutGACmBEiLvcZMEWiZL
 QNXXXYnHZ/IG3BNXg5KzPT/qdSiW0LAWnBVcg2iAyr1jxmazrHT/LKYHCy4jwxeu63GUM0zYS
 QKi6IlrgRaUEUn8cowOUwbdRZsYDxjtjzZHVbaAzBsiG9MJqoRoXAJzD3Iz5foH1dIINl+GPz
 jFElHP/Xi3r1Exev421J/Os31ssSafnueJwy9NDiCuCvHZE+VpuFA3f1wDIOBfdi1A/Lt8z4r
 Pb62o77TuLLYLHdlHqls8GcmX+ozdSJBzyRJw5Yt4SDdDZ3VsQIeyxwxdNuuB6PJxhSmWNjgU
 YzvHD91Yv3hEVvQy2o9otB29pqeMp/Bq34+LfejGuhHjV3iMg0HFQC1wC8lS+KX2jzLz483Ej
 HRHeCaYDOSWWb4Kz3dE4TP3JMgmqK2/iwdZQhOY8ea5NFwbd4Zp77V0Lg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/4/22 10:09, Josh Triplett wrote:
> On Tue, Aug 02, 2022 at 09:40:50PM +0200, Helge Deller wrote:
>> On 8/1/22 18:57, Josh Triplett wrote:
>>> On Mon, Aug 01, 2022 at 05:20:13PM +0200, Helge Deller wrote:
>>>> This patch series allows the arch-specific kernel fault handlers to d=
ump
>>>> in addition to the typical info (IP address, fault type, backtrace an=
d so on)
>>>> the command line of the faulting process.
>>>>
>>>> The motivation for this patch is that it's sometimes quite hard to fi=
nd out and
>>>> annoying to not know which program *exactly* faulted when looking at =
the syslog.
>>>>
>>>> Some examples from the syslog are:
>>>>
>>>> On parisc:
>>>>    do_page_fault() command=3D'cc1' type=3D15 address=3D0x00000000 in =
libc-2.33.so[f6abb000+184000]
>>>>    CPU: 1 PID: 13472 Comm: cc1 Tainted: G            E     5.10.133+ =
#45
>>>>    Hardware name: 9000/785/C8000
>>>>
>>>> -> We see the "cc1" compiler crashed, but it would be useful to know =
which file was compiled.
>>>>
>>>> With this patch series, the kernel now prints in addition:
>>>>    cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tm=
p/ccRkFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER =
-D NO_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/gh=
c-9.0.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Ifac=
e -quiet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O=
 -Wimplicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc=
13413_0/ghc_5.s
>>>>
>>>> -> now we know that cc1 crashed while compiling some haskell code.
>>>
>>> This does seem really useful for debugging.
>>
>> Yes.
>>
>>> However, it's also an information disclosure in various ways. The
>>> arguments of a program are often more sensitive than the name, and log=
s
>>> have a tendency to end up in various places, such as bug reports.
>>>
>>> An example of how this can be an issue:
>>> - You receive an email or other message with a sensitive link to follo=
w
>>> - You open the link, which launches `firefox https://...`
>>> - You continue browsing from that window
>>> - Firefox crashes (and recovers and restarts, so you don't think
>>>   anything of it)
>>> - Later, you report a bug on a different piece of software, and the bu=
g
>>>   reporting process includes a copy of the kernel log
>>
>> Yes, that's a possible way how such information can leak.
>>
>>> I am *not* saying that we shouldn't do this; it seems quite helpful.
>>> However, I think we need to arrange to treat this as sensitive
>>> information, similar to kptr_restrict.
>>
>> I wonder what the best solution could be.
>>
>> A somewhat trivial solution is to combine it with the dmesg_restrict sy=
sctl, e.g.:
>>
>> * When ``dmesg_restrict`` is set to 0 there are no restrictions for use=
rs to read
>> dmesg. In this case my patch would limit the information (based on exam=
ple above):
>>     cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 [note: other=
 parameters hidden due to dmesg_restrict=3D0 sysctl]
>> So it would show the full argv[0] with a hint that people would need to=
 change dmesg_restrict.
>>
>> * When ``dmesg_restrict`` is set to 1, users must have ``CAP_SYSLOG`` t=
o use dmesg(8)
>> and the patch could output all parameters:
>>      cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tm=
p/ccRkFSfY -imultilib . -imultiarch hppa-linux-gnu ....
>>
>> That would of course still leave few possible corner-cases where inform=
ation
>> could leak, but since usually programs shouldn't crash and that
>> people usually shouldn't put sensitive information into the parameter
>> list directly, it's somewhat unlikely to happen.
>>
>> Another different solution would be to add another sysctl.
>>
>> Any other ideas?
>
> I don't think we should overload the meaning of dmesg_restrict. But
> overloading kptr_restrict seems reasonable to me. (Including respecting
> kptr_restrict=3D=3D2 by not showing this at all.)

I'm fine with kptr_restrict, but I'm puzzled for which value of kptr_restr=
ict
the command line should be shown then.
By looking at the meaning of kptr_restrict, I think the command line shoul=
d be
hidden for values 0-2.
Do you suggest to add a new value "3" or am I missing something?

Helge
