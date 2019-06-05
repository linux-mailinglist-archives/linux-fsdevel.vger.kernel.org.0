Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD01B35E7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfFEN7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 09:59:01 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:46027 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfFEN7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:59:01 -0400
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 09:59:00 EDT
X-EEMSG-check-017: 712589965|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="712589965"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Jun 2019 13:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559742481; x=1591278481;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IbC0QjIIeqNUmaNcqRr9rxsTlp++w3u3m5omino7yeo=;
  b=KhEXLfNvUmH6xoZn+fMWBR51MNdNwOmuDgYWCFbXM9bVavwdR0IrU1x5
   NT5uOH89s4OGNmHJkNeoK7R0aLblo7SoMx9/KDj9kbMX/K6wzRvsnxET9
   Hy7fWMBu8n8fGvzB94gZNV1XtMJYUQ4XabEb3qWU99g3aCREKdJhU6sJi
   OiKo/C6DEk078hwNZlztLuJ0NDTOOJHiUfd6Rmm/9BKuikwwv/NyXcH1s
   etHY6OxoGMY478mQ983kElTx/B2CKeFJDuKrp4w1bX3QE3L7Q7r2AESPJ
   8fdODfmphKI0ht/NhBnst2jf+zySiulk9fV88xD6lgnwQAnjN08B3nUbh
   g==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="24419018"
IronPort-PHdr: =?us-ascii?q?9a23=3A1yLf9h0XC9sK0c2AsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQK/nxwZ3uMQTl6Ol3ixeRBMOHsqsC0raM+P6xEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCegbb9oMRm7ohvdusYXjIZmN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5Dxq0UKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK4Ihw7Eslp?=
 =?us-ascii?q?oTtl7PHinql0XtkKCabEAk+ums6+j/Y7XmoIGTN5Nshw3jPakjldazDOQlPg?=
 =?us-ascii?q?QUQWSW9vqw2Kf+8UHhRbVFlPw2kq3XsJDAIsQbo7a0AxRI3YY48Bu/Ezen38?=
 =?us-ascii?q?gYnXkANl5FfgmHgJLzN1HBJ/D4E++zg06wnzdz2/DGIrrhD43JLnjejLfheq?=
 =?us-ascii?q?1w601Cxwopy9BQ+ZZUBqsGIPLpVU/7rMbYAQMhMwyo3+bnD81w1pgCWW2RGq?=
 =?us-ascii?q?+ZML3dsVmS6uI0JumDfosVuDLjJPkl/PPugno5lkUcfamtx5cYdHe4HvF+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmUePqiFqCUDBNaHa2W6I8/So2CJi4AojeRoCimqCB0D?=
 =?us-ascii?q?2nEZ1RY2BMEkqMHmvwd4WYR/cMbzqfItFgkjweUrisUI4g2g+otA/71bprNO?=
 =?us-ascii?q?7U+iwetZL+29l5/erTlQs99TBuEsSd0HmHT3tokWMQWz82wKd/rFRhxViZyq?=
 =?us-ascii?q?h3nfxZGMdI5/xVUgc1L4Pcz+J+C9/sQALNZ8uGR0y8Ttq6BjExS8o7w8USbE?=
 =?us-ascii?q?ZlB9WikhfD0jKwA7APibyEGpo0/7nA33jxOcl9zmzJ1ac7g1kgXMRPKXWshr?=
 =?us-ascii?q?Rj+AjLG47Jj0KZmr6udaQd2i7N6WiCwXOAvEFDTQF/T7vFUm4bZkbNs9T56V?=
 =?us-ascii?q?3NT6W0BbQkLARB08iCJbVOatHzilVGXvjjMszEY22tg2ewGQqIxrSUYYruem?=
 =?us-ascii?q?Ud2jjdCUcdnw8J5XaGNBMzBjmuo23AFjxiD1HvbF328el4tny7SlU4zwaQb0?=
 =?us-ascii?q?1uz7C14AIaheSAS/MP2bIJoCMhqzRyHFag0NPaEsGPpw5mfKpAYtMw+0lH1W?=
 =?us-ascii?q?3HuAxnJJCgLL5thkQYcwtpu0PizRJ3Cp9PkcIytnMl0BJyKb6E0FNGbz6Y3o?=
 =?us-ascii?q?7/O73NKmnz+hCvZLXW10rA0NaZ5KgP8u40q1b9swGzEEot7XFn38NS03uG6Z?=
 =?us-ascii?q?XAFBASXo7pUkYr6xh6oKnXYi0854PSyH1tPrC4siTc1N01Gesl0Begf8tfMa?=
 =?us-ascii?q?+dEQ/yFNAVB9WqKOM0gFWpcB0EM/5I9KIuPMOpaeGG2Ki1M+Zkhj6min5H4I?=
 =?us-ascii?q?9l2EKW6yV8UvLI34oCw/yA2guHVjH8jEqus8zumoBLeysSHmyhxijgH4NReK?=
 =?us-ascii?q?JycpgRCWu0IM242M9+h5jzVH5c7lKjAEkG2MCxcxqIc1P9xRFQ1VgQoXG/gS?=
 =?us-ascii?q?u31SF0kzUyo6qHxiPO3uDieAMCOm5MQ2lil0njLZKogNAdWUj7JzQuwTKj6V?=
 =?us-ascii?q?ey47VHo6F+NXLQQA8cezXqKElhX7G2u77EZNRAvtdgijlaSOSxZxihT7f5px?=
 =?us-ascii?q?YLm3f4A2ZGxD09MSqvs5H9kg1Sh2eULXI1p33cL5Je3xDasefASOZR0zxOfy?=
 =?us-ascii?q?xxjT3aFxDoJNWy1cmFnJfE9OalXiSuUYMFInqj9p+JqCbuvT4iOha4hf3m34?=
 =?us-ascii?q?S9QAU=3D?=
X-IPAS-Result: =?us-ascii?q?A2CPAADkxvdc/wHyM5BmGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFnKoE3BTIohBSScU4BAQEBBoE1iUIOjyKBZwkBAQEBAQEBAQE0AQIBAYRAA?=
 =?us-ascii?q?oJWIzgTAQMBAQEEAQEBAQMBAWwogjopAYJmAQEBAQIBIwQRPwIFCwsOCgICJ?=
 =?us-ascii?q?gICITYGAQkDBgIBAYJTDD+BawMJBQ+mN34zhUeCNw1dgUaBDCiLWxd4gQeBO?=
 =?us-ascii?q?II9Lj6CGoF3ARIBgymCWASIPYMDgjGGDYEnky0+CYIQghqMaE6DZAYbgiOKe?=
 =?us-ascii?q?YljjQ6Ic49LIWdxKwgCGAghD4MnghsXjjwjAzCBBgEBjEcNFwEGgiUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Jun 2019 13:48:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x55Dlut7004801;
        Wed, 5 Jun 2019 09:47:58 -0400
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <stephen.smalley@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <1207.1559680778@warthog.procyon.org.uk>
 <CALCETrXmjpSvVj_GROhgouNtbzLm5U9B4b364wycMaqApqDVNA@mail.gmail.com>
 <CAB9W1A0AgMYOwGx9c-TmAt=1O6Bjsr2P3Nhd=2+QV39dgw0CrA@mail.gmail.com>
 <CALCETrU_5djawkwW-GRyHZXHwOUjaei1Cp7NEJaVFDm_bK6G3w@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5a3353d3-3b88-6c0f-147b-6b9e2ac17773@tycho.nsa.gov>
Date:   Wed, 5 Jun 2019 09:47:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrU_5djawkwW-GRyHZXHwOUjaei1Cp7NEJaVFDm_bK6G3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/19 12:19 AM, Andy Lutomirski wrote:
> On Tue, Jun 4, 2019 at 6:18 PM Stephen Smalley
> <stephen.smalley@gmail.com> wrote:
>>
>> On Tue, Jun 4, 2019 at 4:58 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> On Tue, Jun 4, 2019 at 1:39 PM David Howells <dhowells@redhat.com> wrote:
>>>>
>>>> Andy Lutomirski <luto@kernel.org> wrote:
>>>>
>>>>>> Here's a set of patches to add a general variable-length notification queue
>>>>>> concept and to add sources of events for:
>>>>>
>>>>> I asked before and didn't see a response, so I'll ask again.  Why are you
>>>>> paying any attention at all to the creds that generate an event?
>>>>
>>>> Casey responded to you.  It's one of his requirements.
>>>>
>>>
>>> It being a "requirement" doesn't make it okay.
>>>
>>>> However, the LSMs (or at least SELinux) ignore f_cred and use current_cred()
>>>> when checking permissions.  See selinux_revalidate_file_permission() for
>>>> example - it uses current_cred() not file->f_cred to re-evaluate the perms,
>>>> and the fd might be shared between a number of processes with different creds.
>>>
>>> That's a bug.  It's arguably a rather severe bug.  If I ever get
>>> around to writing the patch I keep thinking of that will warn if we
>>> use creds from invalid contexts, it will warn.
>>
>>
>> No, not a bug.  Working as designed. Initial validation on open, but revalidation upon read/write if something has changed since open (process SID differs from opener, inode SID has changed, policy has changed). Current subject SID should be used for the revalidation. It's a MAC vs DAC difference.
>>
> 
> Can you explain how the design is valid, then?  Consider nasty cases like this:
> 
> $ sudo -u lotsofgarbage 2>/dev/whatever

(sorry for the previous html email; gmail or my inability to properly 
use it strikes again!)

Here we have four (or more) opportunities to say no:
1) Upon selinux_inode_permission(), when checking write access to 
/dev/whatever in the context of the shell process,
2) Upon selinux_file_open(), when checking and caching the open and 
write access for shell to /dev/whatever in the file security struct,
3) Upon selinux_bprm_committing_creds() -> flush_unauthorized_files(), 
when revalidating write access to /dev/whatever in the context of sudo,
4) Upon selinux_file_permission() -> 
selinux_revalidate_file_permission(), when revalidating write access to 
/dev/whatever in the context of sudo.

If any of those fail, then access is denied, so unless both the shell 
and sudo are authorized to write to /dev/whatever, it is a no-go.  NB 
Only the shell context requires open permission here; the sudo context 
only needs write.

> It is certainly the case that drivers, fs code, and other core code
> MUST NOT look at current_cred() in the context of syscalls like
> open().  Jann, I, and others have found quite a few rootable bugs of
> this sort.  What makes MAC special here?

Do you mean syscalls like write(), not open()?  I think your concern is 
that they apply some check only during write() and not open() and 
therefore are susceptible to confused deputy scenario above.  In 
contrast we are validating access at open, transfer/inherit, and use. If 
we use file->f_cred instead of current_cred() in 
selinux_revalidate_file_permission() and the current process SID differs 
from that of the opener, we'll never apply a check for the actual 
security context performing the write(), so information can flow in 
violation of the MAC policy.

> I would believe there are cases where auditing write() callers makes
> some sense, but anyone reading those logs needs to understand that the
> creds are dubious at best.
