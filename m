Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7721073A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfKVNuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:50:32 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:17136 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfKVNub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:50:31 -0500
X-EEMSG-check-017: 33249397|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,229,1571702400"; 
   d="scan'208";a="33249397"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 13:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574430627; x=1605966627;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5uwSZHFrqIJnVGZwW27uC8kRArax2ShqwDqfjyR+EWQ=;
  b=WrRC4h7lze8g4Q41dUoPJaRcLc6dk/vWcAXgsaJTw3SBm5ENYiBnvov7
   /hw1QlOzTznh0tXgtswUcyOsOTaPqZsibqqGF3sx/dlAQcC4wqgA3bI6O
   8bXB1ra+cGU647yREz17oPX2fTtk7+bTMwHjTOOIsHn93Lhf8WgESpy3p
   njs/+nM2kGWvDR5fx5umZlnz283Ykp35fYt0a65PZ18Rub/Qxka5V8TB1
   iK5ECWFMErsTq+ml4mjy1F19cfTA+E8kvY1qk90weFHyleMqg2g7su+c3
   TBpjvKoB7fJPqgKAixqMny10sP64jHI+k1nZjKC/o1a1Lj9sIo5CqoHbe
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,229,1571702400"; 
   d="scan'208";a="35895533"
IronPort-PHdr: =?us-ascii?q?9a23=3A+bZrwRAfYYRUi6Q0K6gfUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP35pcuwAkXT6L1XgUPTWs2DsrQY0rGQ6v28EjFcqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAnctsYbjYRiJ6s+1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoQW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovER/I3AIjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
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
 =?us-ascii?q?t/2Lqx4BIVguacS/xAlo4D7R8otjE8OVG6xd+eX8KJug5JZKxBZZY451Bd2C?=
 =?us-ascii?q?TSsAkrbbK6KKU3vUITawR6uQvV0hxzDohR2ZwxoGgC0Bt5KaXe1khIMTyfw8?=
 =?us-ascii?q?ajafXsNmDu8UX3OObt0VbE3YPTo/1e5Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3AACp5tdd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdIEYVSASKoQqiQOGVQaBEiWJZ4ofhyQJAQEBAQEBA?=
 =?us-ascii?q?QEBLQoBAYRAAoJOOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjBAsBB?=
 =?us-ascii?q?UEQCQIYAgImAgJXBg0GAgEBgl8/AYJSJQ+TAJtzfzOEOQGESYFCBoEOKIwwe?=
 =?us-ascii?q?IEHgTgMgio1PoJiBIEog0eCXgSNHQaKAnSWF4I1gjeEY44wBhuCPownizMtl?=
 =?us-ascii?q?lOTZSKBWCsIAhgIIQ87gmwTPREUhwBvAQKHXYVdIwMwAQEBjwKCQAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Nov 2019 13:50:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMDoOXB060016;
        Fri, 22 Nov 2019 08:50:24 -0500
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
 <20191121145245.8637-2-sds@tycho.nsa.gov>
 <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
 <CAHC9VhRURZMtEDagtSKEuuOLEJen=4PQZig3iGNomzXC1HTNSA@mail.gmail.com>
 <9d825be2-c3ae-f4ad-9f82-adce7e2059d7@tycho.nsa.gov>
Message-ID: <f18bee29-7634-606b-e58b-62049a193d5b@tycho.nsa.gov>
Date:   Fri, 22 Nov 2019 08:50:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9d825be2-c3ae-f4ad-9f82-adce7e2059d7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/19 8:37 AM, Stephen Smalley wrote:
> On 11/21/19 7:30 PM, Paul Moore wrote:
>> On Thu, Nov 21, 2019 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> 
>>> wrote:
>>>> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>>>> passed down the rcu flag to the SELinux AVC, but failed to adjust the
>>>> test in slow_avc_audit() to also return -ECHILD on 
>>>> LSM_AUDIT_DATA_DENTRY.
>>>> Previously, we only returned -ECHILD if generating an audit record with
>>>> LSM_AUDIT_DATA_INODE since this was only relevant from 
>>>> inode_permission.
>>>> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
>>>> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
>>>> that dump_common_audit_data() calls d_find_alias() and collects the
>>>> dname from the result if any.
>>>> Other cases that might require similar treatment in the future are
>>>> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
>>>> a path or file is called under RCU-walk.
>>>>
>>>> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> ---
>>>>   security/selinux/avc.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>>>> index 74c43ebe34bb..f1fa1072230c 100644
>>>> --- a/security/selinux/avc.c
>>>> +++ b/security/selinux/avc.c
>>>> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state 
>>>> *state,
>>>>           * during retry. However this is logically just as if the 
>>>> operation
>>>>           * happened a little later.
>>>>           */
>>>> -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
>>>> +       if ((a->type == LSM_AUDIT_DATA_INODE ||
>>>> +            a->type == LSM_AUDIT_DATA_DENTRY) &&
>>>>              (flags & MAY_NOT_BLOCK))
>>>>                  return -ECHILD;
>>
>> With LSM_AUDIT_DATA_INODE we eventually end up calling d_find_alias()
>> in dump_common_audit_data() which could block, which is bad, that I
>> understand.  However, looking at LSM_AUDIT_DATA_DENTRY I'm less clear
>> on why that is bad?  It makes a few audit_log*() calls and one call to
>> d_backing_inode() which is non-blocking and trivial.
>>
>> What am I missing?
> 
> For those who haven't, you may wish to also read the earlier thread here 
> that led to this one:
> https://lore.kernel.org/selinux/20191119184057.14961-1-will@kernel.org/T/#t
> 
> AFAIK, neither the LSM_AUDIT_DATA_INODE nor the LSM_AUDIT_DATA_DENTRY 
> case truly block (d_find_alias does not block AFAICT, nor should 
> audit_log* as long as we use audit_log_start with GFP_ATOMIC or 
> GFP_NOWAIT). My impression from the comment in slow_avc_audit() is that 
> the issue is not really about blocking but rather about the inability to 
> safely dereference the dentry->d_name during RCU walk, which is 
> something that can occur under LSM_AUDIT_DATA_INODE or _DENTRY (or _PATH 
> or _FILE, but neither of the latter two are currently used from the two 
> hooks that are called during RCU walk, inode_permission and 
> inode_follow_link).  Originally _PATH, _DENTRY, and _INODE were all 
> under a single _FS type and the original test in slow_avc_audit() was 
> against LSM_AUDIT_DATA_FS before the split.
> 
>>
>>> Added the LSM list as I'm beginning to wonder if we should push this
>>> logic down into common_lsm_audit(), this problem around blocking
>>> shouldn't be SELinux specific.
> 
> That would require passing down the MAY_NOT_BLOCK flag or a rcu bool to 
> common_lsm_audit() just so that it could immediately return if that is 
> set and a->type is _INODE or _DENTRY (or _PATH or _FILE).  And the 
> individual security module still needs to have its own handling of 
> MAY_NOT_BLOCK/rcu for its own processing, so it won't free the security 
> module authors from thinking about it.  This is only relevant for 
> modules implementing the inode_permission and/or inode_follow_link 
> hooks, so it only currently affects SELinux and Smack, and Smack only 
> presently implements inode_permission and always returns -ECHILD if 
> MAY_NOT_BLOCK (aside from a couple trivial cases), so it will never 
> reach common_lsm_audit() in that case.

This would also require changing common_lsm_audit() to be able to return 
errors so that it can return -ECHILD and updating all callers to handle 
that.

> 
> 
>>>
>>> For the LSM folks just joining, the full patchset can be found here:
>>> * 
>>> https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t 
>>>

