Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9363B3127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFXOVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 10:21:55 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:21:52 -0400
Received: from [192.168.1.155] ([77.7.27.132]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsZ3N-1l8aq20R1X-00u2tn; Thu, 24 Jun 2021 16:19:29 +0200
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
 <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net>
 <CA+a=Yy4iyMNK=8KxZ2PvB+zs8fbYNchEOyjcreWx4NEYopbtAg@mail.gmail.com>
 <6d58bd0f-668a-983a-bf7c-13110c02dae0@metux.net>
 <CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com>
 <65fc0313-b01b-9882-d716-d5a2911222b7@metux.net>
 <CA+a=Yy6B09=B-4DESX6HChVSjCF2CraQeUT5Pb0H5uX9R4F+bg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <14186baf-b7fc-7181-1c67-efccdc8036cc@metux.net>
Date:   Thu, 24 Jun 2021 16:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+a=Yy6B09=B-4DESX6HChVSjCF2CraQeUT5Pb0H5uX9R4F+bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P7pQ9oJQ2hlBAkGovSjRA5fctAdCIU1d/l+y8ztFA1x7HIQqPvZ
 85Sku0t00+aQzHclQ88RzQ69WmAHKkkEwS2xvrIYOOY6Z4diwHG82YUCqtnx6A1TBEtERlC
 PDCk4MRmWXxmoNsu3a0ewDBK6vpqvvx8Ci4ykqPct8yVHqvp47U978JiLJ9vQOH6/d1ntix
 nR0xXgvHxvlxbipDerq/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dGTNXkaMpvg=:zk8/aqjSmKOGvMUtrPtjOF
 A8BHwBfQqzXHxYU+KpX4uqUhTMySNKFppCfGYCa9d6lnmYRkGL/CSYavF7q8Cj3+I32b3STn6
 dlBWIL9Bs97A5i8XPRxg/ugE0hCPpjqb+Fn264zQff9Iz1roA44vFaNmNZ9OfG4uqeS3gUeVS
 PJijCzqzo+P6547npHpfw89S6gHhPF43FKa6SlAtzeA7D7nmJZxe9BqZuUjU7uIDWREUCj58l
 DJE8C0oDNAUtdwQq8WrV8lnEzXcxrfKyDkVjXUxS/n//asXANJ7gYIxmwguQGJ4fSIXQGriaE
 E8YtOQiAnvgzb8OUAosttqNtnrHOgnKHVbKwZ4XFf03ZqDJiNy3Pq3mD33MhoYKhgToWo107x
 hSGaDMci25PCu+FIbCA71WZwszb5k17sGSIoGeOGwVkpCsyfRMO82hF9Xcp+NY0WGxNrEo5we
 7CnSktAF3tTt+SoHIR9B5Q53klVz249NC+4rtdyDlopc26yUPm+brxhmkcvave70EejW5OJOU
 aIqaevR7/SJJsLfel1qzM4=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.06.21 08:46, Peng Tao wrote:

> Or application recovery after panic ;)

Okay, thats a different scenario. But, of course, the application needs
to have the fds already registered before it crashes. This gives two
options:

a) always store them right after opening and do it's own garbage
    collection (e.g. on each close() call). - expensive and complex
b) construct it in a way that evem on critical signals (eg. sigsegv,
    sigbus) a signal handler can still store the fds somewhere (eg. using
    statically allocated memory and extra stack) - tricky

OTOH, i'd try to construct in a way that a crash of some master process
(that can hold the fds even across restarts) is very unlikely to crash,
since it doesn't do much more than that (plus spawning workers).

By the way, if you just wanna store fd's - i'm working on a more generic
solution: an Plan9-style srvfs. It's a file system that stores aready
opened fd's and on open() gives your that fd (instead of a new one).

My previous experimental implementation did that indirectly by bridging
all operations under the hood (tedious to synchronize the whole file
state), but I'm now taking a fresh start w/ adding some "file boxing"
mechanism to the kernel (patches not ready for submission):

* a file systems's open operation can put a pointer to another struct
   file into the struct file it's operating on -- that's what I called
   a "boxed file".
* the places (actually two) that actually create new struct file's and
   call into the open chain (eg. through vfs_open() etc) then do the
   unboxing -- if there's a boxed file, they fetch it out and drop the
   just newly fd.

> Alessio already has a similar implementation in his patchset. The RPC
> patch tries to make it generic and thus usable for other use cases
> like fuse daemon upgrade and panic-recovery.b

I believe this shouldn't be some fuse specific thing. And we certainly
have to make sure that it can't be abused for dos'ing the machine.
Not sure whether that should be accounted to a namespace or cgroup.

>> I'd hate to run into situations where even killing all processes holding
>> some file open leads to a situation where it remains open inside the
>> kernel, thus blocking e.g. unmounting. I already see operators getting
>> very angy ... :o
> This is really a different design approach. The idea is to keep an FD
> active beyond the lifetime of a running process so that we can do
> panic recovery. Alessio's patchset has similar side effect in some
> corner cases and this RFC patch makes it a semantic promise. Whether
> ops like it would really depend on what they want.

The problem is: (most) fd's are bound to some processes - when they're
killed, the fd's are closed. Usually you can force a closing files
(and thus allow unmount) by checking via lsof which processes still hold
open fd to them and kill'em. If we can't do that anymore, we can run
into big trouble. There needs to be some clear lifetime control for
that.

Let's look at containers: usually the runtime/orchestration sets up a
bunch of mounts before starting the actual workload inside the 
container. On container shutdown, the processes are killed and then
everything's unmounted again (temporary storage, eg. lvm volumes or
btrfs subvols are removed afterwards).

Now, with the persistant fd's, an unprivileged user can block that
(either accidentially or on purpose). We cannot allow that to happen.

Apropos containers: this really should be, some how, bound to some
namespace (not sure whether mountfs or userns is the right place),
so containers cannot interfer with each other.

> I agree but I understand the rationale as well. A normal FUSE
> read/write uses FUSE daemon creds so the semantics are the same.
> Otherwise as you outline below, we'd have to go through all the
> read/write callbacks to make sure none of them is checking process
> creds.

I've actually looked deeper into this. There indeed are certain places
with checks for CAP_SYS_ADMIN, but these are really root-only things
where we should think very carefully whether they should work with
fds passed to processes under separate users at all. And they also
never worked with fd passing via unix socket.



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
