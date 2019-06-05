Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93E13667B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFEVL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 17:11:58 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:43648 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEVL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:11:58 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 17:11:56 EDT
X-EEMSG-check-017: 22592412|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Jun 2019 21:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559768507; x=1591304507;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GlGOmoMxCLppcevLW3isDRXTsHFkzQuuvVZrdU11K28=;
  b=p49yDIRbWrYVHyVKzrJ4tv7XRwKq/8Je7c4X2YNcJlV4rehRE2Zg9bnr
   ooEhAKze52kvOhQyob/ACTgQ6GrsDDPCPwWUR7sqfKxUEkLfATxoICQL4
   NjSGJBe03CClrkbFFuEIDbOrPr0Wph0/aNlT8un0Q87mPsFH0f3iraWRe
   P7vuYzJ6WHrBgmVioNmIp4ycXNCAFYDSdUoi3tg5YTxTDlehO6cOzCHNL
   CzBLvQZ251aw5Rh3BQCvsBG61pYvLE462bLQyRe04GV3DHcpmjfK1cR1j
   fk9YKsYMOYr6+qfa3a3O+6aOulQzo5DpqfDqmyQXblvQXBxStN3HfHFi9
   g==;
X-IronPort-AV: E=Sophos;i="5.60,556,1549929600"; 
   d="scan'208";a="28614991"
IronPort-PHdr: =?us-ascii?q?9a23=3AUuSxBh/N/WTGwf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1ekUIJqq85mqBkHD//Il1AaPAdyCrasY0aGP7v6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmSexbalvIBi5swndudQajItjJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpz6TF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMYIhw74smZ?=
 =?us-ascii?q?oTtkTPBCn2l1ntjKCKbEkk/+mo6+D/brXnoJ+TKZN0hxnjPqkhlcGzG+Q1Ph?=
 =?us-ascii?q?UUU2SF9umwyqfv8VDhTLVPlPI2k63ZsJ7AJcQco660GxRV3Zs46xukEzen0M?=
 =?us-ascii?q?gXnXkALF5ffhKHlJLmN0vBIPD/E/ezm06snytzx/DaIr3hBY3ALnfZkLj/cr?=
 =?us-ascii?q?Z96E5cxRE3zdBe4ZJUF74AIPz0Wk/sstzXEwU2MxC1w+bgDtVxzIQeWXiAAq?=
 =?us-ascii?q?WBKqPdrUeI5v4zI+mLfIIVvCv9K+Qi5/P1l3A5nEUScrWz0psPaXC4Au5pI0?=
 =?us-ascii?q?GDbXrqnNgBDX8AvhAiQ+zylF2CTTlTam6uUK0m/TE0FoKnAJzYRo+xgLyOxj?=
 =?us-ascii?q?q7HpNSZm9YEFCACGvneJ+eV/gQbyKSJ9drkiYYWri5V48hyRauuRf+y7p6Mu?=
 =?us-ascii?q?rU/TYVtZH929hv4e3cixUy+SZzD8SH3GGHV3t0kX8QRz8qwKB/plRwxUqD0a?=
 =?us-ascii?q?h/jf1XC9hT5/dSUgohL57T0fF1C9DoVQLdZNuGVFGmQtC+CzErUt0x28MOY1?=
 =?us-ascii?q?p6G9i6kBDD3jCqA7gOmr2KGpM09KPc32brK8Z5ynbG0rQhjlY8TstIL22mib?=
 =?us-ascii?q?Rz9xXQB4TRiUWWi76qdbgA3C7K7GqD13CBvF9GXw52SqjFQXAfaVXTrdvj6E?=
 =?us-ascii?q?LOVbmuBqo7MgFZ086NNrNKasH1jVVBXPrjPNXeY2Ssm2a/HBqIyKiMY5f0dG?=
 =?us-ascii?q?UDwirdDFMJkx4c/XmYLwgyHCShrHzEDDxoC13vZ1ng8e5kqHO0VkU01R2Fb1?=
 =?us-ascii?q?V917qp/R4YnficS/IV3rIZtyYtsi97HE6839/NFdqAqBRufL9GbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpC6KKBinFEeeRxtv0zyzxV3FplAkc8yoXMuzQpyL7+Y0VxYezyD2Z?=
 =?us-ascii?q?DwPaHYKmrp8RCxZK7ZxEve3MyV+qgR8vQ4rUvsvAWzGkol6XVn3MFf02GA6Z?=
 =?us-ascii?q?XSEAoSTZXxX1409xdkp7DaeCg954Xb1X13KqS0rDDC1MwzBOc/yRavYc1fMK?=
 =?us-ascii?q?WaGw/2CcEaANKuKOMykVizch0EJPxS9LIzP86+c/uG2airPPtvnT6/lmRI/p?=
 =?us-ascii?q?xy0l+W9yp9Vu7J348Jw/Sf3gSaSjf8iEmuv9vpmYBLez4SBHCzySv6C45LYK?=
 =?us-ascii?q?19Y4ILBX2pI82tydV0n4TtVGJA9F6/G1MG39ekeR6Tb1z7wA1R2l0boX+5li?=
 =?us-ascii?q?uiyTx7jTUpo7GB3CzB3evibgALOm1VS2l4i1fjP4y0g8odXEiyYAgjjAGl6l?=
 =?us-ascii?q?rix6hHuKR/KHHeQV9ScCjrK2FvSbOwuaCfY85L8Z8otCJXUOOmYV+EULLyvx?=
 =?us-ascii?q?wa0yawV1dZkR8hej7imbWxyxNghW2eLF53rXzEac932BHT7cDdQvgX2SAJEn?=
 =?us-ascii?q?pWkz7SU2OgMsGp8NPcrJLKtuSzRir1TZFIWTX6xoOH8i2g7CtlBgPpzKP7oc?=
 =?us-ascii?q?HuDQVviXyz7NJtTyid6U+nM4Q=3D?=
X-IPAS-Result: =?us-ascii?q?A2BtAQDmLPhc/wHyM5BmGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?oE7ATIohBSTPQEBAQEBAQaBCAgliVCRCQkBAQEBAQEBAQE0AQIBAYRAAoJWI?=
 =?us-ascii?q?zgTAQMBAQEEAQEBAQMBAWwogjopAYJnAQIDIw8BBT8CEAsYAgImAgJXBg0GA?=
 =?us-ascii?q?gEBglMMP4F3FKcLgTGFR4MmgUaBDCiLWxd4gQeBOAyCKgcuPodOglgEi1Ezg?=
 =?us-ascii?q?W2bHwmCEIIakRoGG4IjhneEAoljpUwhgVgrCAIYCCEPgyeCGxeOPCMDMIEGA?=
 =?us-ascii?q?QGPBwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Jun 2019 21:01:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x55L1h90015404;
        Wed, 5 Jun 2019 17:01:43 -0400
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
 <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
 <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
 <9a9406ba-eda4-e3ec-2100-9f7cf1d5c130@schaufler-ca.com>
 <15CBE0B8-2797-433B-B9D7-B059FD1B9266@amacapital.net>
 <5dae2a59-1b91-7b35-7578-481d03c677bc@tycho.nsa.gov>
 <20190605192842.GA9590@kroah.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <afe35206-d4c1-1974-4b45-65c8c978d613@tycho.nsa.gov>
Date:   Wed, 5 Jun 2019 17:01:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605192842.GA9590@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/19 3:28 PM, Greg KH wrote:
> On Wed, Jun 05, 2019 at 02:25:33PM -0400, Stephen Smalley wrote:
>> On 6/5/19 1:47 PM, Andy Lutomirski wrote:
>>>
>>>> On Jun 5, 2019, at 10:01 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>
>>>>> On 6/5/2019 9:04 AM, Andy Lutomirski wrote:
>>>>>> On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>> On 6/5/2019 1:41 AM, David Howells wrote:
>>>>>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>
>>>>>>>> I will try to explain the problem once again. If process A
>>>>>>>> sends a signal (writes information) to process B the kernel
>>>>>>>> checks that either process A has the same UID as process B
>>>>>>>> or that process A has privilege to override that policy.
>>>>>>>> Process B is passive in this access control decision, while
>>>>>>>> process A is active. In the event delivery case, process A
>>>>>>>> does something (e.g. modifies a keyring) that generates an
>>>>>>>> event, which is then sent to process B's event buffer.
>>>>>>> I think this might be the core sticking point here.  It looks like two
>>>>>>> different situations:
>>>>>>>
>>>>>>> (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
>>>>>>>
>>>>>>> (2) A implicitly and unknowingly sends event to B as a side effect of some
>>>>>>>       other action (eg. B has a watch for the event A did).
>>>>>>>
>>>>>>> The LSM treats them as the same: that is B must have MAC authorisation to send
>>>>>>> a message to A.
>>>>>> YES!
>>>>>>
>>>>>> Threat is about what you can do, not what you intend to do.
>>>>>>
>>>>>> And it would be really great if you put some thought into what
>>>>>> a rational model would be for UID based controls, too.
>>>>>>
>>>>>>> But there are problems with not sending the event:
>>>>>>>
>>>>>>> (1) B's internal state is then corrupt (or, at least, unknowingly invalid).
>>>>>> Then B is a badly written program.
>>>>> Either I'm misunderstanding you or I strongly disagree.
>>>>
>>>> A program needs to be aware of the conditions under
>>>> which it gets event, *including the possibility that
>>>> it may not get an event that it's not allowed*. Do you
>>>> regularly write programs that go into corrupt states
>>>> if an open() fails? Or where read() returns less than
>>>> the amount of data you ask for?
>>>
>>> I do not regularly write programs that handle read() omitting data in the middle of a TCP stream.  I also don’t write programs that wait for processes to die and need to handle the case where a child is dead, waitid() can see it, but SIGCHLD wasn’t sent because “security”.
>>>
>>>>
>>>>>    If B has
>>>>> authority to detect a certain action, and A has authority to perform
>>>>> that action, then refusing to notify B because B is somehow missing
>>>>> some special authorization to be notified by A is nuts.
>>>>
>>>> You are hand-waving the notion of authority. You are assuming
>>>> that if A can read X and B can read X that A can write B.
>>>
>>> No, read it again please. I’m assuming that if A can *write* X and B can read X then A can send information to B.
>>
>> I guess the questions here are:
>>
>> 1) How do we handle recursive notification support, since we can't check
>> that B can read everything below a given directory easily?  Perhaps we can
>> argue that if I have watch permission to / then that implies visibility to
>> everything below it but that is rather broad.
> 
> How do you handle fanotify today which I think can do this?

Doesn't appear to have been given much thought; looks like 
fanotify_init() checks capable(CAP_SYS_ADMIN) and fanotify_mark() checks 
inode_permission(MAY_READ) on the mount/directory/file.  File 
descriptors for monitored files returned upon events at least get vetted 
through security_file_open() so that can prevent the monitoring process 
from receiving arbitrary descriptors. Would be preferable if 
fanotify_mark() did some kind of security_path_watch() or similar check, 
and distinguished mounts versus directories since monitoring of 
directories is not recursive.
