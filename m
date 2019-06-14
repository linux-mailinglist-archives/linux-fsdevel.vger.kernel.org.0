Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C343B467CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfFNSpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:45:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43403 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfFNSpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:45:05 -0400
Received: from [192.168.1.110] ([77.4.92.40]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCsgS-1hkccZ2Tui-008rOk; Fri, 14 Jun 2019 20:45:03 +0200
Subject: Re: Help with reviewing dosfstools patches
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190614102513.4uwsu2wkigg3pimq@pali>
 <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
 <9e81aa56-358a-71e1-edc1-50781062f3a4@metux.net>
Organization: metux IT consult
Message-ID: <6f21c79d-5a80-ce3f-513c-0799145202ea@metux.net>
Date:   Fri, 14 Jun 2019 20:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9e81aa56-358a-71e1-edc1-50781062f3a4@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y9lqlfdstTBt0DoPMvEfRUXRoxw4Xje2tgqv1QQgs0hUer3hnwZ
 pmR2xxNGqf4WU6XyUwGiQGU8IPF7j/ckuQk1KTUBTMxD969kW9bluh4lEps4UGjuwj48WRr
 sMXMJh2WRQOS7r3FDSYEdLYLLb84wzrLDP/1WBHy5KB1pu+1r6v7J7IydIOktUNUYDBFeLo
 Y/K7riDsb6EFhIhp+jM8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:84khekgv8Ak=:siex7XVyERaJL8tZlcUIUW
 U81Dx/pqkrYpp21xMJZvQRQncP2yNEEmjLHlNUFxRxQ/Q7lyQ2FDN+8KWW8padybQEDTibhet
 8fv7ioFxOZQr+ntNnZXQdqv1oPJpKHQmXcDnqjWMhmix8jJ/8NBWaSyedsy/gmf92TVv+wY6i
 9rvWTVQqWtLPNfuUVTVEow0CrhDiN/lF04DNERSdLwW+t4KXaFiahU9oxyxdCVFrR5Kebyyh+
 FeaigG5Ikb6HlDJG7i+BUaqMbFaSHVX8VY8mTo/eqka07caKUSnzAUi1blU6DTAJSUHJwYTDj
 Zd8S2hTPDOAF6+zY3afVqTq8SSF87QLM2KUpXxOFO6AcXZN1fjcsRUQHaEvgBqUZ74H3eef/h
 Lf6iFGdtaimRIGl3M2E1L9AyNgHau2GZGm9F3H1JvmVZboFfcfRjuTHmWxErcmmVkAcoV/Hj9
 6yUgKaZKaOdYAz9mUgldVvrM1kZma6Z5Ipc1gTo15ur38IHD1o9ltETUntT7F+dgugBe1S5bl
 L201Au8abecRf3VnW9/4OEiQZQePlq3UfuyQlho0ypv8hu5YP1wf+rpBUbreAULlhNFJSWXPW
 HuB0gB/TNv5EDDalTo6qSJ4YiqRIZe3u1uNy8PR11Yod4VqtCnHfq/g+BJDAXFk6N5c8BHCpd
 UiFbjnQmsl3Kc2p8sZqedY3hcSqJte1eMtfjbbKCsqdLlCpnpgIY+iSsJF1gISihT5xYsNJJR
 0oogBcIWAyVmkoSry/tS1msfAmzc7b1gxBVVMmCdKOxKC1iydX9xVw+4qc4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.06.19 17:45, Enrico Weigelt, metux IT consult wrote:
> On 14.06.19 16:20, Enrico Weigelt, metux IT consult wrote:
> 
> <snip>
> 
> Currently working through your branches. Smells like they really deserve
> a rebase and signed-off lines.

rebased/applied your patches and got test failures:

XFAIL: check-dot_entries
========================

Test check-dot_entries
First fsck run to check and fix error...
fsck.fat 4.1+git (2017-01-24)
/DIR
  "." is not first entry. Can't fix this yet.
/DIR
  ".." is not second entry. Can't fix this yet.
check-dot_entries.img: 4 files, 3/63931 clusters
*** Error was not detected by fsck.
XFAIL check-dot_entries.fsck (exit status: 100)

XFAIL: check-huge
=================

Test check-huge
First fsck run to check and fix error...
Failed to read sector 167772191.
fsck.fat 4.1+git (2017-01-24)
Second fsck run to check if error was fixed...
Failed to read sector 167772191.
fsck.fat 4.1+git (2017-01-24)
*** Error was not fixed by fsck.
XFAIL check-huge.fsck (exit status: 1)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
