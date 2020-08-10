Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363D524055D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHJL3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 07:29:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHJL1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:27:37 -0400
Received: from [192.168.1.155] ([95.118.172.217]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mf0Jg-1kcmsV1RHO-00gXQe; Mon, 10 Aug 2020 13:27:21 +0200
Subject: Re: srvfs: file system for posting open file descriptors into fs
 namespace
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <55ef0e9a-fb70-7c4a-e945-4d521180221c@metux.net>
 <20200807162305.GT1236603@ZenIV.linux.org.uk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <6c2ab429-eab6-1dbe-08d4-9646f736a4c1@metux.net>
Date:   Mon, 10 Aug 2020 13:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807162305.GT1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:I8J4cWwsf8UrgmKuCBe5ULP9f//08aGVHtF3aYtFREwY62dXxA1
 +PoNrFfa5r8al362mkR0260yWa8UjW+V/dFXhqG/WBU+ZSEaes24ehkOZSDHVxl/SIq2iWa
 mQ2dcKcYsRaekivcuKtO8Bgu/Gv7PqQ+Zs7qW/9FnC1YqfBqe5uaFc6/vUA+b3IliFssio6
 HBAE8ymndpDFnWPCQVLKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FwPCCU2owKk=:QRciTeG+KCXOBZWI36zjZC
 YEBcLAsjeB7DQ5f6YcS4GjYwene+prQeCmdfuCjLf/6qA/Tcywn/1vzD3rjY6WtbGRIaWX4zQ
 BvuwGB0uqjPoxRTGpasg4DG/jI+NeKApy8rQsbfU0Plj1yn0U4aTTIuKWY2RW03AdexIp4y5v
 HT15qsGQ5t/u+jKySeqYJ9nDYZgS6k7VvrwCpeiHsePgNrpK4lL3aj8vMvh8eGLOD+5b9ddUn
 aT1wOwBPcgmG934p8QXGYd48cFCDE7Ixkr2xAutBjeWI7R8jCZ2GG+NPzIE3G5cQe1j0Rk2WL
 FnuH3qt5WoISKAaSZrTXkmtogHbr0wC+yTcaMzf4nL20mRLaPyoh0ZYIC+oKKN98IExKo0lQd
 A07O7ScTqIJygBMl+SZbGL/NRI4G0tTmyAIsW9B/WaXuhGvVfIq4f02cafKW8b4jyieNXRHsh
 r9kwXVabjtodit2B4zH0p/Mv3+wVXk9IH60uiIYP8JQc0LjSG/bbPqvKKAe9pcmfnf+lOyoOu
 SO4zVnWdOng9qMe3CjQusE7hm/sk0hpqauJESal/qo2F84oCYxLIL0goAMY7FSR3+OnQykAhl
 8ipRi/UDCVzahRKJqGWEx1NZrkbA7jp6dxo3q2gHofSBq0q8HfT/w7WV7EPQESosKMuqwFjw3
 W7PsIbpGNfuaQUvq6ypGewFuRFEzz/+rZZiay49c233RevqP9NjFdBCyGW9kttbU8fg8I3QKu
 +Ft6nqvgufbuDOpKMNEfSDuzC9yaQS7FcAM74uTjPHj134wzN5HAcQ9kqcB9DmA3qxR14nfs9
 kKIyTxT9Wuf95FiNMyNwifPt7dkt7pR/6VFQfusFATeFgu3+47No/CjZQOIFNLBxIOF6iYs
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.08.20 18:23, Al Viro wrote:

Hi,

>> This is a concept from Plan9. The main purpose is allowing applications
>> "dialing" some connection, do initial handshakes (eg. authentication)
>> and then publish the connection to other applications, that now can now
>> make use of the already dialed connection.
> 
> Yeah, but...  Linux open() always gets a new struct file instance; 

I know :(

> how
> do you work around that?  Some variant of ->atomic_open() API change?
> Details, please.

Proxy struct file. Yes, this adds lots of bloat :(

https://github.com/metux/linux-srvfs-oot/blob/master/kernel/proxy.c

I thought about some possible ugly tricks of copying over one into
another, but that could easily end up in a desaster.

Another idea would be adding a new fs-op that returns it's own struct
file - basically kinda per-fs open() syscall - which is called instead
of .open, if defined.

But for now, I tried to implement it as oot-module (and submit for
mainline later), so it could also be used on existing distro kernels.

Maybe that's not the best idea at all :o

What'd be your suggestion ?



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
