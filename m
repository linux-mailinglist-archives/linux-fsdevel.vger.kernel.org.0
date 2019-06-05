Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187B836355
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFESZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 14:25:53 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:47509 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFESZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:25:53 -0400
X-EEMSG-check-017: 860467689|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="860467689"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Jun 2019 18:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559759143; x=1591295143;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BvQ350BgfLmmQ6MKL2JV+BtupXhBdCYhKWuagItuaTw=;
  b=m34SykPqwFHnJk8QPt3opniWYr2jTfRCIwU8ntfSbNEh6i+f3Fo78mcV
   QdrOPQVMoVQ8UkXfKzGX/pSIdGGLYntafPzbOtybitBADFDDTfkzoilb5
   a4j9olSRLbBbyvjjm24CSVHVX7lieZC/uiil0U4yAU70hZJL6nFVXzA7+
   Fce7xak6TVjq9Ni2Qh3DZukJPy/bewP47YOa0soVrUVgxgF7xnnQdjJJB
   azUoQrWmPKpVUed0RxbszygjZbhuMzhBxy4TfCxxDQpxgIqQC86Hms/Qd
   b3hiDyp60hx1xFlQSXhBdTLOJ+brQlxTBDAu+0TI+J9WK8HnkozrGiglG
   A==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="24438539"
IronPort-PHdr: =?us-ascii?q?9a23=3Ak/24EBLAuFJ60yV+WNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXL/n7rarrMEGX3/hxlliBBdydt6sdzbOK6euxByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oArPusUZhYZvK7s6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1warSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ549wr8/ip?=
 =?us-ascii?q?oTsUPZEi/whEr2l7OZel8h+uip7+TrerTmppmCOI9okgzyL6sjl8OlDek4Lw?=
 =?us-ascii?q?QCRXaX9Oui2LH54EH1WLBKgec3kqndvpDaP8MbpquhDg9Oz4kj8A2yDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBScj4fzIV3OL/f4Demnj1S2jDhr3+zGPqHmApjVKnjDjavhfb?=
 =?us-ascii?q?Fm5kFGzQo818xQ6IhMCrEAPPL8QEvxuMbeDhAnLwy+2/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUP7/Ivl+T+O0uI/KBZJQJtzb9Mfcl+vDujXsnll8HZKWmwYEYZGqkEfRhJk?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/TniFmfUT5PYHa/RKE86S8hCIKgE4jDQpqhgLub3C?=
 =?us-ascii?q?e0BpdWfHxJCkiQEXf0cIWJQ+oDaCKVIs5vjDMEUbyhS5Q62BG0qgD11rpnIf?=
 =?us-ascii?q?DI+iECqZ3j09117fXJlR4u7Tx0E9id02aVQmFqn2MIXTg20bt+oENjzFeD0L?=
 =?us-ascii?q?Z4j+ZcFdxS4fNJTwg7OYTbz+xgBND+QB/BftSRQla8XtqmGS0xTs42w9IWeU?=
 =?us-ascii?q?ZyAcuigQ7F3yexH78Vl6KEBJku/aPSxXTxIdhyy2re3qk7k1YmWtdPNXGhhq?=
 =?us-ascii?q?Nn8wjTBojJk1iWlqqze6QcxzPC+3mdzWWQuEFVSxBwUarbUnAFfEfWrsr25l?=
 =?us-ascii?q?nET7CwDbQrKAxBydSNKqFScN3mkU1GROv/ONTZe2+xn2awBRCVxrKDdYblYX?=
 =?us-ascii?q?0d3CTGBUganAAc42yGORI9Bii/uWLeCiJhFVb1b0Pr6+l+p2uxTlUowAGSc0?=
 =?us-ascii?q?1hy7219wYRhfydTfMTw70FtD46pDVwG1ayw9HWBsGepwpuYqpce8kx4FRZ2m?=
 =?us-ascii?q?LDsQxyIJigI7plhl4EfAR9p1nu2AlvCoVcjcgqq2snzAlsJqOYylNBdjWY3Z?=
 =?us-ascii?q?/rOrDMNGny8w6ga7TM1lHdztmW4KEP5+o8q1n5uwGpDEUi+W1909ZJy3uc+o?=
 =?us-ascii?q?nKDA0KXJL1U0Y38QV6pr7Dbikm+YzbyWBsMbO1sj/e29MlHe4lyhG9cNdCNK?=
 =?us-ascii?q?OLChT/E9MVB8ewMuwmgVupYQwePOBU6qE0O9mqd/yc2K6kJOxghi6pjXxb4I?=
 =?us-ascii?q?Bh1UKB7y58Su/O35YYzPCUxwiHWCnmjFenrM/3nZtJZS8dHmWh0yjoHo1Rab?=
 =?us-ascii?q?NofYYNF2iuJ9e7xtJkh57iCDZk8wuKAV8XkOu0ZR2Xbkbm3gwYgUAKvXuPkC?=
 =?us-ascii?q?6xxDVski0gquyZ0TCYh6zJfQEKKyZwT2lrkFnoLJL829sTR0W5RxMilBK460?=
 =?us-ascii?q?L33e1QreJ0KGyFEmlSeC2jFH1vSqu9sPK5ZsdL7J45+XFMXP+UfUGRSrm7pQ?=
 =?us-ascii?q?ATlSzkAT0Nl3gAazi2t8ChzFRBg2WHISM29SGIdA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BwAQCZCPhc/wHyM5BmGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?oE7MyiEFJM9AQEBAQEBBoEQJYlQkQkJAQEBAQEBAQEBNAECAQGEQAKCViM4E?=
 =?us-ascii?q?wEDAQEBBAEBAQEDAQFsKII6KQGCZwECAyMPAQU/AhALDgoCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBglMMP4F3FKcKgTGFR4MkgUaBDCiLWxd4gQeBOAyCKgcuPodOglgEi1GCI?=
 =?us-ascii?q?JsfCYIQghqRGgYbgiOGd4QCiWONDpg+IYFYKwgCGAghD4MnghsXjjwjAzCBB?=
 =?us-ascii?q?gEBjwgBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Jun 2019 18:25:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x55IPX56027164;
        Wed, 5 Jun 2019 14:25:33 -0400
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
 <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
 <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
 <9a9406ba-eda4-e3ec-2100-9f7cf1d5c130@schaufler-ca.com>
 <15CBE0B8-2797-433B-B9D7-B059FD1B9266@amacapital.net>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5dae2a59-1b91-7b35-7578-481d03c677bc@tycho.nsa.gov>
Date:   Wed, 5 Jun 2019 14:25:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <15CBE0B8-2797-433B-B9D7-B059FD1B9266@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/19 1:47 PM, Andy Lutomirski wrote:
> 
>> On Jun 5, 2019, at 10:01 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>>> On 6/5/2019 9:04 AM, Andy Lutomirski wrote:
>>>> On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 6/5/2019 1:41 AM, David Howells wrote:
>>>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>
>>>>>> I will try to explain the problem once again. If process A
>>>>>> sends a signal (writes information) to process B the kernel
>>>>>> checks that either process A has the same UID as process B
>>>>>> or that process A has privilege to override that policy.
>>>>>> Process B is passive in this access control decision, while
>>>>>> process A is active. In the event delivery case, process A
>>>>>> does something (e.g. modifies a keyring) that generates an
>>>>>> event, which is then sent to process B's event buffer.
>>>>> I think this might be the core sticking point here.  It looks like two
>>>>> different situations:
>>>>>
>>>>> (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
>>>>>
>>>>> (2) A implicitly and unknowingly sends event to B as a side effect of some
>>>>>      other action (eg. B has a watch for the event A did).
>>>>>
>>>>> The LSM treats them as the same: that is B must have MAC authorisation to send
>>>>> a message to A.
>>>> YES!
>>>>
>>>> Threat is about what you can do, not what you intend to do.
>>>>
>>>> And it would be really great if you put some thought into what
>>>> a rational model would be for UID based controls, too.
>>>>
>>>>> But there are problems with not sending the event:
>>>>>
>>>>> (1) B's internal state is then corrupt (or, at least, unknowingly invalid).
>>>> Then B is a badly written program.
>>> Either I'm misunderstanding you or I strongly disagree.
>>
>> A program needs to be aware of the conditions under
>> which it gets event, *including the possibility that
>> it may not get an event that it's not allowed*. Do you
>> regularly write programs that go into corrupt states
>> if an open() fails? Or where read() returns less than
>> the amount of data you ask for?
> 
> I do not regularly write programs that handle read() omitting data in the middle of a TCP stream.  I also don’t write programs that wait for processes to die and need to handle the case where a child is dead, waitid() can see it, but SIGCHLD wasn’t sent because “security”.
> 
>>
>>>   If B has
>>> authority to detect a certain action, and A has authority to perform
>>> that action, then refusing to notify B because B is somehow missing
>>> some special authorization to be notified by A is nuts.
>>
>> You are hand-waving the notion of authority. You are assuming
>> that if A can read X and B can read X that A can write B.
> 
> No, read it again please. I’m assuming that if A can *write* X and B can read X then A can send information to B.

I guess the questions here are:

1) How do we handle recursive notification support, since we can't check 
that B can read everything below a given directory easily?  Perhaps we 
can argue that if I have watch permission to / then that implies 
visibility to everything below it but that is rather broad.

2) Is there always a corresponding labeled object in view for each of 
these notifications to which we can check access when the watch is set?

3) Are notifications only generated for write events or can they be 
generated by processes that only have read access to the object?


