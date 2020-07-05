Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5AC214B9E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 11:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGEJrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 05:47:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:60095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgGEJrL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 05:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593942424;
        bh=MCNeehA8ECXCWVknGlQbtVgERyNOAr9qWDtZzmx9HPA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V/JlajZs9gZLKtCCUmr4lNYXSlQ7FKQtchxSEdBtmTn5dOEKYImJ5n622L63HVq18
         drKF1nF3CDkh5mUjBifnuc7y1R7SVBRfYTuK/8VLzRmqXXYCOfKsQOjxyR2QW0SVht
         FnrRQcUeftsjWo6QLA0J7a0asu24X17JLQ14ZaZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1k7PRg28k4-00FT20; Sun, 05
 Jul 2020 11:47:04 +0200
Subject: Re: [PATCH 3/3] selftests: add readfile(2) selftests
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-4-gregkh@linuxfoundation.org>
 <fdaa31b7-b045-e38b-680a-01f0389e6acc@gmx.de>
 <20200705073426.GA37944@kroah.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <90c28417-3f1d-3a35-c0f9-205b8610ce78@gmx.de>
Date:   Sun, 5 Jul 2020 11:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705073426.GA37944@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H7+0tMSEmWOnLm21iLXcHFvIOoyt09SFF9sjG0hfN6hp+BzIY5j
 j9K7ckzKK1fcePecpqJptO/e77zPRnT7Pqquk2owD/bFT3AI71bEn2Oo+7eOkzQUIgenTiQ
 kydvLUQjq8q8HFsqcBYwufZf5j8d1RdwGrLqPDCzXFKWgLpgES3+kjiDX2zIsDuzySOmPx+
 U30Pb1FR1hk1sKA9oy3NA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sAnln3YuEuM=:+NOrvhrYibPhK7JBmtgC/g
 SFv0C7o/5AMXsiYRYo4bINyAecsKAYPi2VSoA/VeNv32XPkzNNaXmZ3Sx5Aedz5Gt6AM09qHf
 BBErR8Uq1gi2zGgHgrgBX/fiPZiG3wxSH53SOHzxol82LtWqQly7g1fN3LBKhQihWjYdOBF1i
 gKK2BW0MQJV05p1X2Y86qV+kQSGrG4+TFvnMPH3vHMgy3adVBXNVBKv86Sp6ZXAKniCt54Cpa
 fekFWmFFBlz9DEm9Abk0ErvvIkuBZb2ll+UttcoD0zYG/jVt/B/OlDgeo2OR8PMIpSoQil2ZG
 zA8wxHdTzZMMQLAZjqGYLjbP9G7yo4nOhctL3bKtdK287O9cHhoYAUKhclWNgDvmebbnQfyKM
 KZFoCM+N6zSiioMMzxz1br/AUoFnWCZElWajktWGYLAuuSDJ5tqRbAVu4tS38HKMmnu0VZdyh
 I1Pow3JpGBrCfnsOd90QHJcCYR+DB0LT9ZjCpG/E4jyg4CnxsDpkI1p8Ps26hdr9CJlKJZHWR
 X3ZWqK3ni0RlglkqSkmzO2R1qtPLqb/ooPQ5JgLsLILoKf82evDTrtZC5AmjvJmj+blodJG0u
 8/KYInoX5SPnqJJryG7AE3/VmCYa9Btm5gMUopy4pExuAwxPrUfgwWZw9io8tQ8NGxlWdpmqK
 KfWafS7O4O+G6d20b96hejdeO7p5rhgYBtWSursjHAdZWkemQx6jsBxxWVGAHUcusVRMxCmUZ
 Z9HWVO0ITOuW11tgRg6UwzTHzZPwCBoUV4CQR8aRN4u+DppwZroc4vy7+KYwPcA2IDZiYsafH
 DzsQ8SUlg11I3NJ0jOaswJ9EIxkus9Nl/SB6XDkN1t5h8xiWrV7YB1PnahtaH4y1l3Jw5+Qbv
 ZvFOdIOyqy5b6sJ9ixWzEB6UIvdh+YbjDZKqrp+5QTN+iBfBDlijzKBpF8EpOPMh1i3GUWAgj
 IPSuOLZfLDEVUFoknAM4EZz/L75NGpi9/iLeuf7AZkV5HR1lyy8a25K7IEJqdvXHQKnnyfrdB
 GZyXkrnmd/teTIFAlV9PpSbF1KhW/8I0xN72nOkDO6G9ZKcXXOTqw/k3NECJNSqbOxwOQTKr/
 Ch3Ki79ICNVuv3/oft4zX0KTVfH5OaA2okvQ3Wpm3xLaXH08CeD+YIVDTKR361p+wkQhcxz9x
 FFEZ37QW0MAARB4Z3BscgUTJVNNY2vQO2pdGVLL3VLgds6ebDi5MrwZlKfJE27EeyDiHcoCuX
 H57raEyyGPlxqZ6wj
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/5/20 9:34 AM, Greg Kroah-Hartman wrote:
> On Sun, Jul 05, 2020 at 03:41:48AM +0200, Heinrich Schuchardt wrote:
>> On 7/4/20 4:02 PM, Greg Kroah-Hartman wrote:
>>> Test the functionality of readfile(2) in various ways.
>>
>> Hello Greg,
>>
>> I expect readfile() to generate fanotify events FAN_OPEN_PERM, FAN_OPEN=
,
>> FAN_ACCESS_PERM, FAN_ACCESS, FAN_CLOSE_NOWRITE in this sequence.
>
> Yes, it should, I don't think I do anything unique here when it comes to
> vfs accesses that would go around those events.
>
>> Looking at patch 1/3 you took care of notifications. Would this deserve
>> testing here?
>
> Possibly, do we have other in-tree tests of syscalls that validate those
> events properly being created?

There is an inotify test in
tools/testing/selftests/cgroup/test_freezer.c

There is no fanotify test in tree test.

An fanotify test will require running with CAP_SYS_ADMIN. The kselftest
documentation does not describe that tests should be run as root. So it
may be preferable to test that the inotify events IN_OPEN, IN_ACCESS,
IN_CLOSE_NOWRITE are created for readfile().

Example coding is included in the inotify.7 and fanotify.7 manpages.

Best regards

Heinrich
