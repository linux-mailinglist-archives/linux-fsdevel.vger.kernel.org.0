Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789C43A88DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFOSxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 14:53:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFOSxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:53:04 -0400
Received: from [192.168.1.155] ([95.115.9.120]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTznO-1lksBB2J4k-00R3HZ; Tue, 15 Jun 2021 20:50:55 +0200
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com>
 <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net>
 <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
 <295cfc39-a820-3167-1096-d8758074452d@metux.net>
 <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net>
Date:   Tue, 15 Jun 2021 20:50:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9YRIk9kyZASvWP6fGjB5VpsXq+AnpiJFBww/aUeWjMlxt/Mknql
 V4xhYCtaMJcnT7j37x3+FCzLv406ZXq0+aMh5HUsnvSNyAPxaFj7eYe1QWoxybaTRrIUHYK
 3WoUb8plRGU3wh02a0Sp0dhm3t1cxnGuHYZRGMalSaOdkW8YdtYxz4wia5CvC2gBugSr4OL
 U5RIplJhOZs1WvUQCy1jA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPa93BBxVQ8=:Poke6x5P4pnGpZHccSJBte
 pTQXRLRFpveqZmZJXJAOImlc2lDA3ma8/8GSIi1qdQWgMIgPaQljCeD7q5P5F0/2TpA8I+BqA
 26GU02Xgvkg/pexh1YgICYYQQx0I1Pgu0DPNCi1vO0ifi94jw3X4QMRgAvXDEK84iTAogVx+Y
 HmO6i3nOXd6QbsazPoNUO4wINLXu56rGr/Wc+oroPqKM+wUW8hrMDxsGpRj8KAnU3jswCOWge
 JUhOlmw13gUGmDER6c9H+gr4CqrXn60HhR9gcr+RIgWHeIKfW6pCARnyITSautPRgSeiRJ76r
 1o2twm3ki4+DMOX6TCze8wqgnrh+6rWVe3+pNeshzGcM8a+3isdGsGZDreu+dfSG7CsqNKXhu
 Wb0Or03qvRaes8vKvzNNTFQIb6D/DJbj52twgU5UhSwHPw5y59BNFm8pIV+aL9EtuZy7/ZsNz
 wpt5/NKqfzmjepWolJlNJ5excYcoU5gOUVwnKCkprgsC/Y7iCysRx3s/EFSIVhBjfRMkeiCC3
 kt7zSH78uKnthJDgiH5BYM=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.06.21 14:46, Peng Tao wrote:

>>
>> * it just stores fd's I don't see anything where it is actually returned
>>     to some open() operation.
> The FUSE_DEV_IOC_RESTORE_FD ioctl returns the opened fd to a different process.

So, just open() a file on a fuse fs can't restore the fd directly 
(instead of opening a new file) ? If that's the case, that would mean,
userland has to take very special actions in order to get it. Right ?

>> * the store is machine wide global - everybody uses the same number
>>     space, dont see any kind of access conrol ... how about security ?
>>
> The idea is that anyone capable of opening /dev/fuse can retrieve the FD.
> 
>> I don't believe that just storing the fd's somewhere is really helpful
>> for that purpose - the fuse server shall be able to reply the open()
>> request with an fd, which then is directly transferred to the client.
>>
> Could you describe your use case a bit? How does your client talk to
> your server? Through open syscall or through some process-to-process
> RPC calls?

I'd like to write synthetic file systems (file servers) that allows
certain unprivileged processes (in some confined environment) directly
open()ing prepared file descriptors (e.g. devices, sockets, etc) that it
isn't allowed to open directly (but the server obviously is). Those fds
could be prepared in any ways (eg. sealed, seek'ed, already connected
sockets, etc).

The client thinks it just open()'s a normal file, but actually gets some
fd prepared elsewhere.


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
