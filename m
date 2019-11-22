Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48201107633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKVRHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 12:07:07 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:28122 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:07:07 -0500
X-EEMSG-check-017: 51317621|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="51317621"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 17:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574442294; x=1605978294;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SRpjH55lTCinoXtcwoxnTdFwjmLoG/S9BFv01WVEpzU=;
  b=AZmMxORqSBsSSywuRirGqHzPbIgyJVPT4YWfLyn3yt3OmxzDGWEFAZKS
   KPZDSNRpOMMGYOoMns0Ops3mlYjfkbb9PafiTlgTnWZ+Szwypx/seH6Dr
   wuqhtCdUvrb2tIp9Zee3WxZlM9g6gOdutxSZiTMp4RPx8OQm4ak6vJdFp
   NBgvn/P+nzBYJUgBDy5Cpy1OeevazZu/TU+WAHeZBwhTAHawG1tbPC4Ku
   TvxKIW4P/dVdRJDfQJDIflGXfQ5T5Z9hJCKNCInB2h8KdFRtQ6AFqM7Wc
   xKJCk89f/p2jaohOxvcz0b+efJyBRdp9MWbvohkEZeXdZN5LdXS1ejHVm
   A==;
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="30418210"
IronPort-PHdr: =?us-ascii?q?9a23=3Ag95hFBWjpUjwKCv9zP0ID5EJgMDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZReHvKdThVPEFb/W9+hDw7KP9fy5AipZvMrK4S1KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMLjYZiJas9xR?=
 =?us-ascii?q?/Er3tVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWgGufixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gIgAdwOvnfaotv7O6gdU++60KbGwC7fb/5Vwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00xLoGuZ?=
 =?us-ascii?q?uhcygLzpQq3x3fZOKdc4iO/B3jUPydITBihHJqfr+0mhW88VC4x+HhWcS530?=
 =?us-ascii?q?xGoypYntXWqHwA2ALf5tKaRvZ740yvwyyA1xrJ5eFBOU00kK3bJIM/zbMojZ?=
 =?us-ascii?q?oTtFjDHjfxmEXrkK+abkUk9fas6+TgerjmuoWTN5V1igHjKaQigM2/AeI2Mg?=
 =?us-ascii?q?gJRGiU5/iz2Kf//Uz5XLpKjvo2nrPfsJ/GPsQUurS1AwpU0oYn8xq/DjGm38?=
 =?us-ascii?q?oEnXQfMV5Idx2Kg5LpNl3TOvz0E/iyj0q2nDt23/zGO6fuApTJLnjNirfher?=
 =?us-ascii?q?N95lZHyAUu1tBS/I5UC7EdL/LzXU/9rtrYDgQjPACuzObnD8t92psEWW2TGq?=
 =?us-ascii?q?+ZLL/SsViQ6+I3OeaMeYsVtS3lK/c/+v7uiWY1mVoafamux5sYdmq0EehhI0?=
 =?us-ascii?q?WceXDsmMsOEX8WvgoiS+znkEaCXiBXZ3azWaI8+z46BZm4DYfMWI+tmqaN3C?=
 =?us-ascii?q?SlEZ1MYGBJFFSMHW3vd4WeVPcGcDiSLdN5kjwYSbihTJcs1B+vtA/+z7pqNe?=
 =?us-ascii?q?nU9TMCtZLlytd14/fflRYo9Tx7F86dyX2CT3lonmMUQD87xL5/oU1nyleEyq?=
 =?us-ascii?q?V5guJXFdpS5/NXSAs6MZ/cz+pnC9H9QA7Bec2JSFm8TtW7AjE7VsgxzMMWY0?=
 =?us-ascii?q?ZhB9WiiQjO3yy0DL8Uk7yEH4c58rnB33jqOclx0WvJ27c5hVk8XsRPLXGmhr?=
 =?us-ascii?q?J49wXLA47JkkOZl7uldKgF0i7N73qMwnSQvE5GVA59SrvFXX8BaUvMt9j55V?=
 =?us-ascii?q?3NT6WoCbs5NgtN08mCKrFFatfxl1VJWO/jOMjCY2K2g2qwAReIxrWRbIvlYm?=
 =?us-ascii?q?kdxzvSB1QZkwAJ/HaGKQg/Cj6ko2LZETNuCFbvbF33/Olgp3O0UFU0wxuJb0?=
 =?us-ascii?q?J/zbq1/AAahfiGR/MUxLIEtz8rqy9oE1alw9LWF92AqhJ9fKVbe9M9/k1I1W?=
 =?us-ascii?q?bEuAxmJZGgK6FihlgDcwV4pk/u2RJ3CphGkcc3tnwq0AtyKaWe0F9bcDOYx5?=
 =?us-ascii?q?/wafXrLTzK9Q2rI4vR3UvTmIKO87oLwOwxtlGmuQauDEdk+HJihYp7yXyZs6?=
 =?us-ascii?q?7WARISXJS5aUM+8xx3tvmOeSUmz5/F3n1rd6+vu3nN3Mx/V7ht8QqpY9oKaP?=
 =?us-ascii?q?DMLwT1CcBPQpH0eeE=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3AABvFNhd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdIEYVSASKoQqiQOGUwaBN4lnih+HJAkBAQEBAQEBA?=
 =?us-ascii?q?QEtCgEBhEACgk44EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgm0BBSMECwEFQ?=
 =?us-ascii?q?RAJAhgCAiYCAlcGDQYCAQGCXz8BglIlD5NTm3N/M4Q5AYRQgUIGgQ4ojDB4g?=
 =?us-ascii?q?QeBESeCaz6CYgSBKINHgl4EiVeDRohhgSd0lheCNYI3hGOJSIRoBhuCPowni?=
 =?us-ascii?q?zMtllOTZSKBWCsIAhgIIQ87gmwTPREUhwBvAQKHXYVdIwMwAQEBjwKBYV8BA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 17:04:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMH4m8d089653;
        Fri, 22 Nov 2019 12:04:50 -0500
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
 <20191121145245.8637-2-sds@tycho.nsa.gov>
 <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
 <CAHC9VhRURZMtEDagtSKEuuOLEJen=4PQZig3iGNomzXC1HTNSA@mail.gmail.com>
 <9d825be2-c3ae-f4ad-9f82-adce7e2059d7@tycho.nsa.gov>
 <CAHC9VhRiRdWfqP8sp8YKRdc4D9r9u1QYP5o2sRh7QwvgCRYYbg@mail.gmail.com>
 <6fcbe2ee-bdb2-7365-5c3d-46424b7bfc23@tycho.nsa.gov>
Message-ID: <54230ed9-536b-34aa-1b0e-5f459686b597@tycho.nsa.gov>
Date:   Fri, 22 Nov 2019 12:04:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6fcbe2ee-bdb2-7365-5c3d-46424b7bfc23@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/19 10:09 AM, Stephen Smalley wrote:
> On 11/22/19 9:49 AM, Paul Moore wrote:
>> On Fri, Nov 22, 2019 at 8:37 AM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>> On 11/21/19 7:30 PM, Paul Moore wrote:
>>>> On Thu, Nov 21, 2019 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>> On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> 
>>>>> wrote:
>>>>>> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk 
>>>>>> aware")
>>>>>> passed down the rcu flag to the SELinux AVC, but failed to adjust the
>>>>>> test in slow_avc_audit() to also return -ECHILD on 
>>>>>> LSM_AUDIT_DATA_DENTRY.
>>>>>> Previously, we only returned -ECHILD if generating an audit record 
>>>>>> with
>>>>>> LSM_AUDIT_DATA_INODE since this was only relevant from 
>>>>>> inode_permission.
>>>>>> Return -ECHILD on either LSM_AUDIT_DATA_INODE or 
>>>>>> LSM_AUDIT_DATA_DENTRY.
>>>>>> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
>>>>>> that dump_common_audit_data() calls d_find_alias() and collects the
>>>>>> dname from the result if any.
>>>>>> Other cases that might require similar treatment in the future are
>>>>>> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
>>>>>> a path or file is called under RCU-walk.
>>>>>>
>>>>>> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk 
>>>>>> aware")
>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>> ---
>>>>>>    security/selinux/avc.c | 3 ++-
>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>>>>>> index 74c43ebe34bb..f1fa1072230c 100644
>>>>>> --- a/security/selinux/avc.c
>>>>>> +++ b/security/selinux/avc.c
>>>>>> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct 
>>>>>> selinux_state *state,
>>>>>>            * during retry. However this is logically just as if 
>>>>>> the operation
>>>>>>            * happened a little later.
>>>>>>            */
>>>>>> -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
>>>>>> +       if ((a->type == LSM_AUDIT_DATA_INODE ||
>>>>>> +            a->type == LSM_AUDIT_DATA_DENTRY) &&
>>>>>>               (flags & MAY_NOT_BLOCK))
>>>>>>                   return -ECHILD;
>>>>
>>>> With LSM_AUDIT_DATA_INODE we eventually end up calling d_find_alias()
>>>> in dump_common_audit_data() which could block, which is bad, that I
>>>> understand.  However, looking at LSM_AUDIT_DATA_DENTRY I'm less clear
>>>> on why that is bad?  It makes a few audit_log*() calls and one call to
>>>> d_backing_inode() which is non-blocking and trivial.
>>>>
>>>> What am I missing?
>>>
>>> For those who haven't, you may wish to also read the earlier thread here
>>> that led to this one:
>>> https://lore.kernel.org/selinux/20191119184057.14961-1-will@kernel.org/T/#t 
>>>
>>>
>>> AFAIK, neither the LSM_AUDIT_DATA_INODE nor the LSM_AUDIT_DATA_DENTRY
>>> case truly block (d_find_alias does not block AFAICT, nor should
>>> audit_log* as long as we use audit_log_start with GFP_ATOMIC or
>>> GFP_NOWAIT).
>>
>> Yes, the audit_log*() functions should be safe, if not I would
>> consider that a bug; I thought d_find_alias() might block, but it's
>> very likely I'm wrong in that regard.
> 
> No, it doesn't appear to block.  However, it does take d_lock and 
> increment d_lockref.count, which IIUC aren't permitted during rcu-walk.
> 
>>> My impression from the comment in slow_avc_audit() is that
>>> the issue is not really about blocking but rather about the inability to
>>> safely dereference the dentry->d_name during RCU walk, which is
>>> something that can occur under LSM_AUDIT_DATA_INODE or _DENTRY (or _PATH
>>> or _FILE, but neither of the latter two are currently used from the two
>>> hooks that are called during RCU walk, inode_permission and
>>> inode_follow_link).  Originally _PATH, _DENTRY, and _INODE were all
>>> under a single _FS type and the original test in slow_avc_audit() was
>>> against LSM_AUDIT_DATA_FS before the split.
>>
>> Thanks, I think that is the part I was missing.  I was focused too
>> much on the VFS stuff that I didn't pay enough attention to
>> slow_avc_audit().
>>
>> If that is the case, the comment and code in dentry_cmp() would seem
>> to indicate that it would be safe to fetch the dentry name string as
>> long as we use READ_ONCE().  The length field in the qstr might be
>> off, but the audit_log_untrustedstring() function doesn't use the
>> qstr's length information.  I suppose if we don't mind the extra
>> spinlock we could use take_dentry_name_snapshot(); that should be safe
>> and we are already in the "slow" path.  I didn't check the _PATH or
>> _FILE cases.
>>
>> Once again, let me know if I'm missing something.
> 
> We can't take any spinlocks on the dentry during rcu-walk IIUC; that 
> would defeat the purpose. In looking for a parallel with filesystem 
> implementations, I noted that fs/namei.c:get_link() doesn't even pass 
> the dentry to the filesystem get_link() method in the rcu-walk case, 
> only doing so under ref-walk.  So they won't permit the filesystem 
> implementations to ever dereference the dentry for get_link() under 
> rcu-walk.  Not sure why it gets passed to security_inode_follow_link() 
> then, or if it is ever safe for a security module to dereference its 
> fields.
> 
> I was hoping to get fsdevel folks to comment since I feel like we're 
> guessing about exactly what guarantees we have in this area.
> 
>>
>> As an aside, if we somehow can guarantee (e.g. via a name_snapshot)
>> that qstr length information is valid, we might want to consider
>> moving from audit_log_unstrustedstring() to
>> audit_log_n_untrustedstring() to save us a call to strlen().
>>
>>>>> Added the LSM list as I'm beginning to wonder if we should push this
>>>>> logic down into common_lsm_audit(), this problem around blocking
>>>>> shouldn't be SELinux specific.
>>>
>>> That would require passing down the MAY_NOT_BLOCK flag or a rcu bool to
>>> common_lsm_audit() just so that it could immediately return if that is
>>> set and a->type is _INODE or _DENTRY (or _PATH or _FILE).  And the
>>> individual security module still needs to have its own handling of
>>> MAY_NOT_BLOCK/rcu for its own processing, so it won't free the security
>>> module authors from thinking about it.
>>
>> Looking at the current SELinux code, all we do is bail out early with
>> -ECHILD.  If we didn't have that check it looks like the only impact
>> would be some extra assignments into a struct living on the stack and
>> a call into common_lsm_audit().  That doesn't seem terrible for a slow
>> path, especially if it pushes this code into a LSM common function.
> 
> Not terrible, just not sure if it ends up being a worthwhile change.  If 
> the LSM maintainers would like it that way, I can do that.

I think this rendered moot by viro's suggestion, since we are taking the 
handling of MAY_NOT_BLOCK up even earlier in the processing and the 
flags don't need to be passed down to slow_avc_audit() anymore.  Sure, 
we could still pass them down and defer the handling to 
common_lsm_audit(), but that's just extra wasted work before we bail 
out, and we are no longer even testing the a->type field with the new 
logic so there is no longer anything related to the lsm_audit 
implementation.

> 
>>
>>>>> For the LSM folks just joining, the full patchset can be found here:
>>>>> * 
>>>>> https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t 
>>>>>
>>
> 

