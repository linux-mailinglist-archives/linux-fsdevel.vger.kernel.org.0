Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6DA39E08A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFGPeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 11:34:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGPeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:34:21 -0400
Received: from [192.168.1.155] ([77.9.164.246]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6bwO-1lHm3r1YlS-017zUV; Mon, 07 Jun 2021 17:32:25 +0200
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
Date:   Mon, 7 Jun 2021 17:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLeoucLiMOSPwn4U@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4sqfGogWk5tyBvrBxV1FlsUhXcevCNbuO4bvDWsCumqIqL6eVcE
 2sGaHF98a9tJfEpddDDXJBo//o2ws0wcg6mQ9I7JNCen0DP1mmR6ImbczDIjtNEYa4zppD6
 3DzRQKp8MRDkwYpEeJuIHGBNEp+EBdx2IsYVdMhJQwWSZIZKah0F5MlsQp8ul8x/bfkZlBo
 gPjo5htaaO7PNXWGSrKQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UmgsOh1XNkc=:WHkYLZDrroMI6ouJtaY2WF
 +/GnLsBdIB9WrvT0FtNvUfnx0XzzDtiZFgzFZicgdRSQZXg7umW1LcQyL8mbtxd6KJcCxXKVC
 JS7wfk3vwbLPoa9aBgyakLegc9bQq/ISfjx/1CCdfqbmzETges5LiJXUMcL1ncQ7NWeZ7pvYU
 tbaT9g9YLP2tv1EBK9Iw+NOoLQ0cMORuOdsPJfJzy68lA5NO3GDpLLAqicLPa0nPqdfYwooxA
 h5XLEmSmcL6ewT2VTR/33FPqQK40a+PINvWpNyqg0S0tGuKfBzmE7jlJCtedBHQLXFjBuMqPA
 fSMoTsyiAK8ujOqCFHYn7w13Iz4CswPtJ3uZVfRsdhtnTCteZx81wHanTSThzURXlcTnQyoQA
 4sXp/l+WNnFsBsYIRTIuAHtc5l4XIhYRNpbKkSfRHnOAH5GNicZE49La/nTcCoLltN7zAg4j2
 nXkqhKjgtYJvF5czG7SYQ4R2xL3Pti/Ue0T7gaX6fKTwBQQV70wza6a6Ut+GxSk9+e3lrdAqR
 IgLDLAw97DLtuzXeHLQ3kc=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.06.21 17:50, Alessio Balsini wrote:

>> A possible use case is fuse fd passthrough being developed
>> by Alessio Balsini [1] where underlying file system fd can be saved in
>> this file store.

oh, this could be quite what I'm currently intending do implement
(just considered 9p instead of fuse as it looks simpler to me):

I'd like the server being able to directly send an already opened fd to
the client (in response to it calling open()), quite like we can send
fd's via unix sockets.

The primary use case of that is sending already prepared fd's (eg. an
active network connection, locked-down file fd, a device that the client
can't open himself, etc).

Is that what you're working on ?


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
