Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A535C1074AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKVPQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 10:16:58 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:51047 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfKVPQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:16:57 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 10:16:57 EST
X-EEMSG-check-017: 53538331|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="53538331"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 15:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574435365; x=1605971365;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Sq9v8Axahipo8jj2VI5/tmecWbF1mCpkVGho0uRGpQA=;
  b=QB4acYRPQw0aaI/hmSBy/Oj+Kp3MRLD3K4BsonJHkL3LT0Q9buxOekSQ
   o44PtEM7Hg4+kKyRYoJa8qsFz+8D5nEeSY1xOgYAMhHVHnWqQjLZmqrae
   gvZdLMhgN1B2KXXoRy6RoXevG893jSm+OP4Dye22po9btl4WtGcl43NCg
   wJ6VtqnC3UFInYwmGugkqxnWHUzTIBp01dtfE0wyTYBs1Fs0JqfQZNhEm
   Ox1otLwv9tWBq8JnGVel5pN1qNwTQYl0sYeSHmsMH9ghRXJBCURZ3YKru
   bDG6yNTmILk3cgY4Wdevc0S6kbQXSUqjTf0nuQjjScyGIqcr4bV8nQ1bv
   g==;
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="30409915"
IronPort-PHdr: =?us-ascii?q?9a23=3AbFcH6xC9+uIePMzSBrbzUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP34p82wAkXT6L1XgUPTWs2DsrQY0rGQ6v28EjNZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAnctsYbjYRgJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoQW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAJyJs53R7fbeKIc4yS7hLkTuaRLjF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhv/MqQolMy/Bv84PR?=
 =?us-ascii?q?YSUGSB5eS91KHs/U3+QLlQiP05jrLZv4zAKcQep665BxdZ0ocl6xmhEzeryM?=
 =?us-ascii?q?kUkHYIIV5feB+LkpLlN0/BLfzmF/uznkygkDJxyPDHOr3hDI/NLn/GkLr5Zr?=
 =?us-ascii?q?Zy9lVcxREvzdFf+51UCrYBLOj1Wk/qrtPUFBA5Mwuqw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7SqUWH5v8rI+SXfI8aoiv9K/w86/7rin85nkUdcrez0ZQLb3C4G+xsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxIlTOP0jF2CUDhTZ2u9Xq8n+DE7B5ypDZ3ZSoCunrOBxi?=
 =?us-ascii?q?G7EYNSZmxcDVCMC3jofZ2eW/gQcCKSPtNhkjscWLmvSo8h0RWuuRT5y7V5NO?=
 =?us-ascii?q?rU/DMXtZb52Nhy/e3Tmgk49SZoAMSFz2GNU2Z0k3sWRz83xqB/pldwy1ad3q?=
 =?us-ascii?q?h+gvxYC8Zf5/dIUgc8KJ7dwPZ2C9foWgLOZNuJVVWmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtWkkB/D3i6qDKQOmryQGZw06bzT02LsKMlj03zGzrUuj0E6QstTMm2rnq?=
 =?us-ascii?q?p/9wnVB47UnESVjqiqdb8B0yHT6meM026OsVpGUA5/T6rFR2oTZkjIotTj4E?=
 =?us-ascii?q?PNUbuuBa4gMgtbxs6IMrFKZcHxjVVaWPfjP8zTY2awm2e2GBaJyaqAbJH0dG?=
 =?us-ascii?q?oBwSXdEkkEkxwT/HqfMAg+ATquo3/aDDNwDl/vfUzs/vdkqH+hTU870RuKb0?=
 =?us-ascii?q?t/2Lqx4BIVguacS/wL1LIepCghsyl0HEq639/OF9qAoBBhfLtGbtM5/VhHzn?=
 =?us-ascii?q?nUtwh8PpymMqBjiUcScwpwv0Pz0RV4F59PkdQrrHMtygp+M6WY0ElOd2DQ4Z?=
 =?us-ascii?q?elArTKLiHX+xe1ZuaCwljD1P6O87oLrfE/rE/u+gquExxx3W9g1oxuz3aE5p?=
 =?us-ascii?q?jMRDEXWJb1X1d/owN2vJnGcyI94MXSznQqPq6q5GyRk+k1Dfcon07zN+xUN7?=
 =?us-ascii?q?mJQUqrSZwX?=
X-IPAS-Result: =?us-ascii?q?A2A3AABz+ddd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdIEYVSASKoQqiQOGVQaBEiWJZ4ofhyQJAQEBAQEBA?=
 =?us-ascii?q?QEBLQoBAYRAAoJOOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBI?=
 =?us-ascii?q?wQRQRALGAICJgICVwYNBgIBAYJfPwGCUgUgD64UdX8zhDkBgRSDMoFCBoEOK?=
 =?us-ascii?q?IwweIEHgREnDIJfPoJiBIEog0eCXgSJV4NGiGFhRnSWF4I1gjeEY4lIhGgGG?=
 =?us-ascii?q?4I+jCeLMy2WU5NlIoFYKwgCGAghDzuCbBM9ERSHAG8BAoddhV0jAzABAQGPA?=
 =?us-ascii?q?oFhXwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 15:09:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMF9Jf5032346;
        Fri, 22 Nov 2019 10:09:22 -0500
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6fcbe2ee-bdb2-7365-5c3d-46424b7bfc23@tycho.nsa.gov>
Date:   Fri, 22 Nov 2019 10:09:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRiRdWfqP8sp8YKRdc4D9r9u1QYP5o2sRh7QwvgCRYYbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/19 9:49 AM, Paul Moore wrote:
> On Fri, Nov 22, 2019 at 8:37 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 11/21/19 7:30 PM, Paul Moore wrote:
>>> On Thu, Nov 21, 2019 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>>>>> passed down the rcu flag to the SELinux AVC, but failed to adjust the
>>>>> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
>>>>> Previously, we only returned -ECHILD if generating an audit record with
>>>>> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
>>>>> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
>>>>> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
>>>>> that dump_common_audit_data() calls d_find_alias() and collects the
>>>>> dname from the result if any.
>>>>> Other cases that might require similar treatment in the future are
>>>>> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
>>>>> a path or file is called under RCU-walk.
>>>>>
>>>>> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> ---
>>>>>    security/selinux/avc.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>>>>> index 74c43ebe34bb..f1fa1072230c 100644
>>>>> --- a/security/selinux/avc.c
>>>>> +++ b/security/selinux/avc.c
>>>>> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
>>>>>            * during retry. However this is logically just as if the operation
>>>>>            * happened a little later.
>>>>>            */
>>>>> -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
>>>>> +       if ((a->type == LSM_AUDIT_DATA_INODE ||
>>>>> +            a->type == LSM_AUDIT_DATA_DENTRY) &&
>>>>>               (flags & MAY_NOT_BLOCK))
>>>>>                   return -ECHILD;
>>>
>>> With LSM_AUDIT_DATA_INODE we eventually end up calling d_find_alias()
>>> in dump_common_audit_data() which could block, which is bad, that I
>>> understand.  However, looking at LSM_AUDIT_DATA_DENTRY I'm less clear
>>> on why that is bad?  It makes a few audit_log*() calls and one call to
>>> d_backing_inode() which is non-blocking and trivial.
>>>
>>> What am I missing?
>>
>> For those who haven't, you may wish to also read the earlier thread here
>> that led to this one:
>> https://lore.kernel.org/selinux/20191119184057.14961-1-will@kernel.org/T/#t
>>
>> AFAIK, neither the LSM_AUDIT_DATA_INODE nor the LSM_AUDIT_DATA_DENTRY
>> case truly block (d_find_alias does not block AFAICT, nor should
>> audit_log* as long as we use audit_log_start with GFP_ATOMIC or
>> GFP_NOWAIT).
> 
> Yes, the audit_log*() functions should be safe, if not I would
> consider that a bug; I thought d_find_alias() might block, but it's
> very likely I'm wrong in that regard.

No, it doesn't appear to block.  However, it does take d_lock and 
increment d_lockref.count, which IIUC aren't permitted during rcu-walk.

>> My impression from the comment in slow_avc_audit() is that
>> the issue is not really about blocking but rather about the inability to
>> safely dereference the dentry->d_name during RCU walk, which is
>> something that can occur under LSM_AUDIT_DATA_INODE or _DENTRY (or _PATH
>> or _FILE, but neither of the latter two are currently used from the two
>> hooks that are called during RCU walk, inode_permission and
>> inode_follow_link).  Originally _PATH, _DENTRY, and _INODE were all
>> under a single _FS type and the original test in slow_avc_audit() was
>> against LSM_AUDIT_DATA_FS before the split.
> 
> Thanks, I think that is the part I was missing.  I was focused too
> much on the VFS stuff that I didn't pay enough attention to
> slow_avc_audit().
> 
> If that is the case, the comment and code in dentry_cmp() would seem
> to indicate that it would be safe to fetch the dentry name string as
> long as we use READ_ONCE().  The length field in the qstr might be
> off, but the audit_log_untrustedstring() function doesn't use the
> qstr's length information.  I suppose if we don't mind the extra
> spinlock we could use take_dentry_name_snapshot(); that should be safe
> and we are already in the "slow" path.  I didn't check the _PATH or
> _FILE cases.
> 
> Once again, let me know if I'm missing something.

We can't take any spinlocks on the dentry during rcu-walk IIUC; that 
would defeat the purpose. In looking for a parallel with filesystem 
implementations, I noted that fs/namei.c:get_link() doesn't even pass 
the dentry to the filesystem get_link() method in the rcu-walk case, 
only doing so under ref-walk.  So they won't permit the filesystem 
implementations to ever dereference the dentry for get_link() under 
rcu-walk.  Not sure why it gets passed to security_inode_follow_link() 
then, or if it is ever safe for a security module to dereference its fields.

I was hoping to get fsdevel folks to comment since I feel like we're 
guessing about exactly what guarantees we have in this area.

> 
> As an aside, if we somehow can guarantee (e.g. via a name_snapshot)
> that qstr length information is valid, we might want to consider
> moving from audit_log_unstrustedstring() to
> audit_log_n_untrustedstring() to save us a call to strlen().
> 
>>>> Added the LSM list as I'm beginning to wonder if we should push this
>>>> logic down into common_lsm_audit(), this problem around blocking
>>>> shouldn't be SELinux specific.
>>
>> That would require passing down the MAY_NOT_BLOCK flag or a rcu bool to
>> common_lsm_audit() just so that it could immediately return if that is
>> set and a->type is _INODE or _DENTRY (or _PATH or _FILE).  And the
>> individual security module still needs to have its own handling of
>> MAY_NOT_BLOCK/rcu for its own processing, so it won't free the security
>> module authors from thinking about it.
> 
> Looking at the current SELinux code, all we do is bail out early with
> -ECHILD.  If we didn't have that check it looks like the only impact
> would be some extra assignments into a struct living on the stack and
> a call into common_lsm_audit().  That doesn't seem terrible for a slow
> path, especially if it pushes this code into a LSM common function.

Not terrible, just not sure if it ends up being a worthwhile change.  If 
the LSM maintainers would like it that way, I can do that.

> 
>>>> For the LSM folks just joining, the full patchset can be found here:
>>>> * https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t
> 

