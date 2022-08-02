Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A55882B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHBTlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiHBTlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:41:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E76E474D5;
        Tue,  2 Aug 2022 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659469252;
        bh=DaxnZzWlq8rdNZPIkNudbL/86e9yCrTsubkwK7be3mQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GIBhC/ac30CYs9ql8nRJkGG7KZzm+AMbtwTMyBRfaeqnu/gkLSwLwOxojKAbyjQ37
         8WU5+tu3/tlh920uL/fEmF9p+wLgX3+QwwQSB5VdKly69f+RNVJTnva8OYwGjA8+V/
         SRr7yGGoTgnd2EbuM6rkIhRBNckHEgdT42Sz4spg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.166.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1oJmZV0Dmn-001VLX; Tue, 02
 Aug 2022 21:40:52 +0200
Message-ID: <a0bf15a2-2f9c-5603-3adb-ffa705572a92@gmx.de>
Date:   Tue, 2 Aug 2022 21:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Dump command line of faulting process to syslog
Content-Language: en-US
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801152016.36498-1-deller@gmx.de>
 <YugGFEjJvIwzifq7@localhost>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <YugGFEjJvIwzifq7@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FK3A4RrVucDG0RPGQTysWhv0Er6T1qGSn62a38i7ukOkyBGyDqg
 Mx3hgk/RPivHxofiGJwZ0lF5izU8i8lHOnobDn4NVuolYJezQgc+vjLaOJJ8HZtZtkuUjjt
 40a+SJoJwdntr6wcuXz0Ny+pPxRvRxQzflIjAmKUDXTtFmczlY1V5fe4Jct/kY2BHi1K9mv
 4wZb//IVELfxXAlYwK9Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BzOzkgKJDko=:9X7pA8a8B6gL0F958q5xt8
 x0WG2yaZLzToa9wORd2Jau6bh/68jdofWljMKuyxrvq2TZxRCvCUqC6qyQcSxFzXrhVZZGuTJ
 9+rgPLvY9xb3KxEJ32kOoeSaFMaelPFiRLmmlKvM5o1SbiDHS6mR4REtg4BPNIFoA9zrH6n4q
 9ZDF3H2DBEGIh0VEOaU+QQRqVM6deL4F0PCq8ej0womJKiXVPBXrJT6g9TAivE5g57a/AnSHt
 9UrY0Qg/9XeBoXVKH/WpTYtOY0GDn5wrfjD4YWLNji2oBxsQWZmQd5ADKADYE18dAp0FDaxU1
 WzF2fXsZz3xQJfIkSU5HwQ4wQ9HEIZmT7NKdzyvoHnq/DhdxFxy8Jnwr/fnX6KJsf0iWTQz7m
 hYqYh+YDiUxrcF4oqaagF1FtXOo2LGp7bDjwm9IpU4CvFRny+8fd8wcJCwyE1CGDpYyAcQrlX
 EScqLBIQY0xMQrTrt/KWUJecF0axWtKNKYedi8hZ/FOShl7O//isWjvfp5RXrr7atF+9pda5F
 Q8mm3XGHIzi/AqGYknOjdXjx3hfqH2dGodSLv4XA8z9Ahh83AFDBxhokPZDb5aRqz1ImAJocV
 HfVYbVuGT45HojNLc6GGU9pkILKp0HvR1G2XRF3j9i3vn55pC+XUGGiyEZ78nA9qK3ppJ15EA
 OMp/bIDkihf2eXtZD37Cp9L87YFYg4MRpLrV2Iel3tcgYXA031DEabh6zUKB/7h8h7RRoFE+6
 xfMoMfdLfztt3ak0QzZczePvVhaQiqf1NC1qpC22M4+n+r8D3uHroLKOfd1R7sJaBIJilhrqO
 +7UkOEISSjuE93VZ4Rd7YbfqTxllZijSZhvACVUgS8qiVrAHX5zxEgdWekGiflNVUTnSZfdtn
 weEYRrWd6zYpiICGH0TXYKQDAQK8WVCfz9fTpM6vKX0faREftc8gKNrHlClKa5hFzsyUJefSd
 d/gCpSKQ09uA7x+NMbZ+u5E/WTd2Y7IuNi6XwGADiThSw4DW1DSjf1sT2qIrTKAJisAkma+1H
 oxJD9rtNv/M+ER2AqYkTILj9DwacojK2Zip1HD4oS4ZiGnX/T2NbJrWUc0/qo8iCN7r5HsdIE
 bd5ycVUKMS161JCq/ncEVTu2At41BN7H0BXEne5bT4xdTeikIVoGE97PQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/1/22 18:57, Josh Triplett wrote:
> On Mon, Aug 01, 2022 at 05:20:13PM +0200, Helge Deller wrote:
>> This patch series allows the arch-specific kernel fault handlers to dum=
p
>> in addition to the typical info (IP address, fault type, backtrace and =
so on)
>> the command line of the faulting process.
>>
>> The motivation for this patch is that it's sometimes quite hard to find=
 out and
>> annoying to not know which program *exactly* faulted when looking at th=
e syslog.
>>
>> Some examples from the syslog are:
>>
>> On parisc:
>>    do_page_fault() command=3D'cc1' type=3D15 address=3D0x00000000 in li=
bc-2.33.so[f6abb000+184000]
>>    CPU: 1 PID: 13472 Comm: cc1 Tainted: G            E     5.10.133+ #4=
5
>>    Hardware name: 9000/785/C8000
>>
>> -> We see the "cc1" compiler crashed, but it would be useful to know wh=
ich file was compiled.
>>
>> With this patch series, the kernel now prints in addition:
>>    cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/=
ccRkFSfY -imultilib . -imultiarch hppa-linux-gnu -D USE_MINIINTERPRETER -D=
 NO_REGS -D _HPUX_SOURCE -D NOSMP -D THREADED_RTS -include /build/ghc/ghc-=
9.0.2/includes/dist-install/build/ghcversion.h -iquote compiler/GHC/Iface =
-quiet -dumpdir /tmp/ghc13413_0/ -dumpbase ghc_5.hc -dumpbase-ext .hc -O -=
Wimplicit -fno-PIC -fwrapv -fno-builtin -fno-strict-aliasing -o /tmp/ghc13=
413_0/ghc_5.s
>>
>> -> now we know that cc1 crashed while compiling some haskell code.
>
> This does seem really useful for debugging.

Yes.

> However, it's also an information disclosure in various ways. The
> arguments of a program are often more sensitive than the name, and logs
> have a tendency to end up in various places, such as bug reports.
>
> An example of how this can be an issue:
> - You receive an email or other message with a sensitive link to follow
> - You open the link, which launches `firefox https://...`
> - You continue browsing from that window
> - Firefox crashes (and recovers and restarts, so you don't think
>   anything of it)
> - Later, you report a bug on a different piece of software, and the bug
>   reporting process includes a copy of the kernel log

Yes, that's a possible way how such information can leak.

> I am *not* saying that we shouldn't do this; it seems quite helpful.
> However, I think we need to arrange to treat this as sensitive
> information, similar to kptr_restrict.

I wonder what the best solution could be.

A somewhat trivial solution is to combine it with the dmesg_restrict sysct=
l, e.g.:

* When ``dmesg_restrict`` is set to 0 there are no restrictions for users =
to read
dmesg. In this case my patch would limit the information (based on example=
 above):
    cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 [note: other pa=
rameters hidden due to dmesg_restrict=3D0 sysctl]
So it would show the full argv[0] with a hint that people would need to ch=
ange dmesg_restrict.

* When ``dmesg_restrict`` is set to 1, users must have ``CAP_SYSLOG`` to u=
se dmesg(8)
and the patch could output all parameters:
     cc1[13472] cmdline: /usr/lib/gcc/hppa-linux-gnu/12/cc1 -quiet @/tmp/c=
cRkFSfY -imultilib . -imultiarch hppa-linux-gnu ....

That would of course still leave few possible corner-cases where informati=
on
could leak, but since usually programs shouldn't crash and that
people usually shouldn't put sensitive information into the parameter
list directly, it's somewhat unlikely to happen.

Another different solution would be to add another sysctl.

Any other ideas?

Helge
