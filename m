Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487B9122BA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfLQMeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 07:34:21 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:54417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfLQMeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:34:20 -0500
Received: from [192.168.1.155] ([95.114.21.161]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mw9oq-1hrIM82g0i-00s3SR; Tue, 17 Dec 2019 13:34:16 +0100
Subject: Re: [PATCH 0/2] New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
 <20191216093557.2vackj7qakk2jngd@orion>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <73615b86-6da7-0e65-0dbc-c158159647ef@metux.net>
Date:   Tue, 17 Dec 2019 13:33:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216093557.2vackj7qakk2jngd@orion>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kOHhF89bTYSwYfWhqLmxQ2esZHjEOBKvTZP6nzNhMnQE3Qb5rlJ
 DUsJ3ZZDXazB0ANWp/gJ8ZJIMVmFJxqFg7TrLNhyNw2UwAtjwKIsHJVuxpXk0DBAA0ugJeQ
 TNd5odFh5KriFGPQNPJo7oOCBjPeTCogB1qh7u02bFT3R54N2x/1KZpKmOr/pI0kXDbMMe4
 4UfaoZWDbangAuRUhoQVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sNg7eYdd92o=:Cgsk6pYi2BfKS0I+OWTdi2
 88ADVJKZm6uCFsM6ABJ2Kkiz+EYRUoBTjlLE3vBqczOWiVgZTFfk9wUnjgCXaXn7lFinUa0sV
 XXxvbCRbRTiL3uafC0mSF34ssaygPD481SMEUSLSkcGt7WLO5ksUzO/4ww1BTIIupFk50WJ+k
 kuBuxl2Z3Wu30Xo1jGi2MFt2BHiokefRi4fA4QqirNx8QGKh4uvqAd1lQs7Zj9qN6qXMoTMV9
 W9nEEkLjmHVpfH24Ev9xd3g3K5scv2+ixShTsT1wFlayUwXmW9lRohsXc1D89fUvROVh9du0X
 AuWc+7dno3BT7e9dlLCtLk1IQiupBZtnIVeHJNwPCfWzqud11M1no8hogxBOTKmpigba/406b
 6nLCp5FJGbBmKkMIJe+Cf8bzKVXYXn2+1kqkvN4OujZ4oqDHW1T3en6pRlcmHnYrisqEdbHKU
 dnwxuZ+jRMi82+D44OZQ7qIg3LjZ/wTijUAxwvnNAD9dF9/dgmywZyafMnmtcJ3I8Fc170cCS
 NzyERJqTiACFhAL/AWwWw+nL2tV8z/c2gsO4RZTDySRyA99JsiVR88WEkFh6U3JoTHix1NoOp
 LSxgpaITd+/XDaVV99/YDyvbLVJGvp6UTCglBxiK6xkBw896/+jRBpvmO0bIou4mk9iuZrg/b
 eYMhP52SBNdsj1CEkpLcSpTru/cdL0+gP6kmTTZANKUiivKxcqSb8IKcAhekwT6PFVmJ/boqf
 FY9REAvcZ3EfYgWayCJ7dllV6ABzKmMVyXv08bavv7lvfW7h0/jDFin4e3jiehCcsUCP2IygC
 6p3Dsz4unzbvv66r4UDQ0WNHp2ctjcApiu+bGwU2uxcIvs8ASLyHuQgdYuZI1rfSu9hySBwhu
 wAVncdejDQWC0VSFT/QA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.12.19 10:35, Carlos Maiolino wrote:

Hi,

>> Just curious: what's the exact definition of "zoned" here ?
>> Something like partitions ?
> 
> Zones inside a SMR HDD.

Oh, I wasn't aware that those things are exposed to the host at all.
Are you dealing with host-managed SMR-HDDs ?

> On a SMR HDD, each zone can only be written sequentially, due to physics
> constraints. I won't post any link with references because I think majordomo
> will spam my email if I do, but do a google search of something like 'SMR HDD
> zones' and you'll get a better idea

Reminds me on classic CDRs or tapes. Why not dealing them similarily ?


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
