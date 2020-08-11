Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62B241E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgHKQRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 12:17:46 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:40142
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729029AbgHKQRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597162664; bh=HRZtQQztfeaIlu0ko1fCcbZ7lwBJIQ6owO2QXWY3TpA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=IPWlCwNcLYacS9jhqVwBCI39xmuZbEhVmcIL4ATgtdTJZIn2MjxFnfGlwEW2N3jfIf3eXTfsa1CexGQSmiZ8XVpWzx8YfK3Ue925slZDtSdT6ATSmHeThsm/CXPDpcuaf2a+E7LkF5QEqo0w62m+gZmpktq9Ws6F/KKgXWFEVcVmLxGZ3u+JkDrvBeh3RWe6biSbndY67smaYdLFpqrVBt/W6G7hbWQcXmIIxL0nv85fp/L6mFZw4P/MxDdtT6z9yPaTEOg+Zidr0JZoxYK24Vb6tTsirKhRqDgGJMJrU0RygYqxTISLMbctbsZzEK3x7MfuZzhJtOT5yh62rIb2EA==
X-YMail-OSG: 61iu8D4VM1lTPHyzo1VbCudKRHYFgoeEneYcnW.zg.c7ofAjqwgA4u6VEuxZWsC
 ipG5wQPPnNRN7cTHQV2RuDLMjQwCMLynmZHwudSHeobUYNfktSeYZVNoB0BTtu5R7MnYTrhhrtG.
 Oj4GJ8B4NIU1MGP2Uu._Ay.E0pKxRG9lACmQDUeiQyLFdDiZ290FOuyb4djZfe6TzWPVQGNl0.l1
 DbugqKVDguGo8MtFCdB7hgwcWeQNPRwN6hj8N87v_m332JC560pDW_Tgzp0T9l1Ol4yv9Wo0YWbP
 oRQ2dBt5OkW6ASHcKuiWiKQZS9A9eyakeVwPdrW_T05lzyKKBQch84HrQsZRupCO8cFjPW9We5Wl
 u0IHoUOG0LrUdub0QZF4d03u3W.tS8vAj9RbjSR4vCJu8dBqDy_IwGkuMfXpm7fVrPpRivYJ.CSl
 kki6siFEUKv5UKJ1M8ba5FRL5GOQQM8NKU.v4Lq3QpdE7pwGS6O_5mJ2QTeAUii1chwuRkK7pZXZ
 lVqpmLLFcLNKDvyI7cGUEfsWN0kWq5a3VKzd_gYwWfaqNy91AcxVJndnbaVdMU81AuJbGUTKbSCx
 wCJLsmOLGfo2UGtMXwGiCkaGFdx6.hlRi.12vF4tOkNzKsWWe39JzTW_3yJgXSXJKcRdb558hZmr
 KI8NoWqGSO3FsLac2rWi2KcD578c1FjgA8FRNwLTWa4Swa5R7iD0BLLaCryro2.KmPPzSj0YouAu
 OUG8ZG9fG4j0.AaJLvEySHKJ_8n_DlQK0ElY47YQoKTItRDYNgnYsi5tRHiuHxiynfBL86O4VRKN
 e7j3rJ5.He18_XaUNO3KKCIGxbZ6PccFGxNWR7ZIeRvELvNqTPBEzGhs_BVOtnhSk_iOenuZMy93
 2tUJPjtsKAo7MzdyZWRo1ZjicFi2ugZl8S91eO9E2FpEDQcvXeLRBigriaGsL8loNsTvaMt37bUW
 Qi0pB.KVwOSxP6p0EMHP0Zu.OQ4S2rl6fOW3PkQ7UsbZPuDj3gL0R3wfEekvIubU9jZ3PtI54RPv
 jWHVQxfynP_bVu.XlLp6KeGtyOT4pe0GX0UtzTGHO7UVvCsC7BmR3hwmQJeZQ9xqOEM2k7ga.w.T
 nITKvJiivAjdReWCrxbzA8P03YpCHlH_sNvg93f6WvBxrxNB32P98FGckV6zAXvrQNMuhqaBWwUy
 idJfhI8Pk7dZhrGBhT.ICul4cC6cVmeFfSJpflIXE14tZgLESibJHpUWE.lLhpGn0s0nDt1OphSO
 bF1SBwr2yy3B7h6XGdcj.XGiggMKc_U1zaBalh6LUQRgA24cXIkausF1JldoDneZ4_Bl6yhwQ5uH
 DbS5df3OEJIirSPa5Crbk07bApGPPrNHz0WkVgzm1B35re8UWBPoq89bPZudrWMbOWBrolqmMMXX
 a1o96zvKEBpjZhA1GQHJTgHikR1I62NK0kdDMrmVlWXUjlYDhckdvJWaj6AdXYyP50jhtLUr4KMJ
 KsnCgfVEpXeWDmWNvh1EWh_k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Aug 2020 16:17:44 +0000
Received: by smtp412.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c3db567eaf5f6f2d02d37813dbea7c10;
          Tue, 11 Aug 2020 16:17:41 +0000 (UTC)
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
Date:   Tue, 11 Aug 2020 09:17:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/2020 8:39 AM, Andy Lutomirski wrote:
>
>> On Aug 11, 2020, at 8:20 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> ﻿[ I missed the beginning of this discussion, so maybe this was already
>> suggested ]
>>
>>> On Tue, Aug 11, 2020 at 6:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>>> E.g.
>>>>  openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
>>> Proof of concept patch and test program below.
>> I don't think this works for the reasons Al says, but a slight
>> modification might.
>>
>> IOW, if you do something more along the lines of
>>
>>       fd = open(""foo/bar", O_PATH);
>>       metadatafd = openat(fd, "metadataname", O_ALT);
>>
>> it might be workable.
>>
>> So you couldn't do it with _one_ pathname, because that is always
>> fundamentally going to hit pathname lookup rules.
>>
>> But if you start a new path lookup with new rules, that's fine.
>>
>> This is what I think xattrs should always have done, because they are
>> broken garbage.
>>
>> In fact, if we do it right, I think we could have "getxattr()" be 100%
>> equivalent to (modulo all the error handling that this doesn't do, of
>> course):
>>
>>  ssize_t getxattr(const char *path, const char *name,
>>                        void *value, size_t size)
>>  {known
>>     int fd, attrfd;
>>
>>     fd = open(path, O_PATH);
>>     attrfd = openat(fd, name, O_ALT);
>>     close(fd);
>>     read(attrfd, value, size);
>>     close(attrfd);
>>  }
>>
>> and you'd still use getxattr() and friends as a shorthand (and for
>> POSIX compatibility), but internally in the kernel we'd have a
>> interface around that "xattrs are just file handles" model.

This doesn't work so well for setxattr(), which we want to be atomic.

> This is a lot like a less nutty version of NTFS streams, whereas the /// idea is kind of like an extra-nutty version of NTFS streams.
>
> I am personally not a fan of the in-band signaling implications of overloading /.  For example, there is plenty of code out there that thinks that (a + “/“ + b) concatenates paths. With /// overloaded, this stops being true.

Since a////////b has known meaning, and lots of applications
play loose with '/', its really dangerous to treat the string as
special. We only get away with '.' and '..' because their behavior
was defined before many of y'all were born. 


