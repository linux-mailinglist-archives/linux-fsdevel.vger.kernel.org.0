Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB210735C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfKVNhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:37:47 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:16315 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVNhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:37:47 -0500
X-EEMSG-check-017: 33173504|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,229,1571702400"; 
   d="scan'208";a="33173504"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 13:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574429863; x=1605965863;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5VgO2xFY1eV2tiFZ6d8QymHyU7/x6QRUuAFHrW9cvKk=;
  b=d3TghU0Nn1oKkoS6ysbnlkwkuV0uxfpQuT7H89QArbqvjD4OPeag6FTE
   ZRI6+sj31dpRP6bZdgEh7xis6Z7codCBuKo1UAHVBqukYB7EQ29s5KHlz
   pJzbA8lDoRndNQTh2nC1aXhyq5NTxjVupkPZ3Jqko/guaBNXRKLut31DA
   WMhthXfhwudgeQV3z3unEYhRY4zMlrzMRwgWrncN20KbhZOvrJzLypfb9
   34kXwNbfzCFNK6Spv5XY9hUyK39EMYCcMf6QdlI8/O/NOcO6y0bYyCOO/
   Pa46rR/92KQc33VYYIJKk/d9SwrGDA+TSketB62TM3wDuvoIv64CWNeXr
   g==;
X-IronPort-AV: E=Sophos;i="5.69,229,1571702400"; 
   d="scan'208";a="35894780"
IronPort-PHdr: =?us-ascii?q?9a23=3ARv6wRBR3pbDJXedbwKK76VZ75tpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZhaAt8tkgFKBZ4jH8fUM07OQ7/m7HzVdvd3c6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIttJ6o+yh?=
 =?us-ascii?q?bFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQWyAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg0zb0GvI?=
 =?us-ascii?q?S0fCkMyJk/xB7QdeaHc46W7RLnTuqRJi14hH1jdbmihBiy6VCtxvDzW8S7yl?=
 =?us-ascii?q?pHrjdJnsPSun0CyRDf8NWLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7X6vJCcLY50ihzlMqg0m8y/B+o4Mg?=
 =?us-ascii?q?8VX2eF5euwzqHj/E3lT7VKif06iK/Zv4zBJcsHvKK5Bg5V0oI75xa+CTepzs?=
 =?us-ascii?q?gYkGEaIF9Kdx+LlYjkN0zULPzmAvqznU6gnCpzy/DDJLLhA5HNLnbZkLfmeL?=
 =?us-ascii?q?Zw81Vcxxcozd1E+5JVCq0OIPL0WkPrstzYFQU2Pxa7w+bgFtVxzpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5vo1LOmRYI8Yoy79JOI45/7qlHM5nFgdfa6z3ZQJcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHyk12NTzpTZ3e0X6Ih6TA2E5ymDYjdSYC3mrCB3z?=
 =?us-ascii?q?m0HodQZm9YDlCAC3Dod5+LW/0UciKdPtdhkiAYVbimU4Ig2xCutAv+y7d8Le?=
 =?us-ascii?q?rb5DcYtZT929hx/eHTkgsy9TNsBcSHz26NV310nn8PRzIuwqB/oFZ9ylCY3K?=
 =?us-ascii?q?l5nfNYE91T5+1TXgc+NJ7cyfF6Ct/oVgLGZNeJR0yqQsilATspVNI+38cOY1?=
 =?us-ascii?q?phG9Wllh3D2TSlA74Rl7OQH5E06b/c32PvKMpn1nnJyrErj0M6TctXKW2mmq?=
 =?us-ascii?q?l/+hDXB47IlUWZiqmreb0S3C7W6WiM03SOs19cUANrT6XFUm4QZlHModT6+E?=
 =?us-ascii?q?zCVbmuBqojMgdbzs6CMKRKYMXzjVpaXPfjJMjeY2Wplme0BBaIwK6MbYXzd2?=
 =?us-ascii?q?UGwirSFFUEkxoS/XaaNQkyHyKho2XDAzxzEVLgfVjh8fdxqHylVE841QKKYF?=
 =?us-ascii?q?N717qz5BEVgeaQS/QJ3rIL628drGBMFUu5l/fRDMCN7155dbhYScs0/VMC0G?=
 =?us-ascii?q?XerQE7NZulefNMnFkbJj9rslvu2hM/MYBJlcwnvTt+1wZpAb6J21NGMTWD1N?=
 =?us-ascii?q?b/PaOBeTq6xwymd6ODggKW692R4Kpara1i+lg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BLAAAa49dd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBGFUgEiqEKokDhlUGgTeJZ4ofhyQJAQEBAQEBAQEBLQoBA?=
 =?us-ascii?q?YRAAoJOOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBIwQRQRALG?=
 =?us-ascii?q?AICJgICVwYNBgIBAYJfPwGCUgUgD61xdX8zhDkBgRSDM4FCBoEOKIwweIEHg?=
 =?us-ascii?q?TiCNjU+gmIEgSiDR4JeBI0diUJGdJYXgjWCN4RjjjAGG4I+jCeLMy2WU5NlI?=
 =?us-ascii?q?oFYKwgCGAghDzuCbBM9ERSHAG8BAoddhV0jAzABAQGPAoJAAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Nov 2019 13:37:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMDbcb0053299;
        Fri, 22 Nov 2019 08:37:39 -0500
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
 <20191121145245.8637-2-sds@tycho.nsa.gov>
 <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
 <CAHC9VhRURZMtEDagtSKEuuOLEJen=4PQZig3iGNomzXC1HTNSA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9d825be2-c3ae-f4ad-9f82-adce7e2059d7@tycho.nsa.gov>
Date:   Fri, 22 Nov 2019 08:37:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRURZMtEDagtSKEuuOLEJen=4PQZig3iGNomzXC1HTNSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/21/19 7:30 PM, Paul Moore wrote:
> On Thu, Nov 21, 2019 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>>> passed down the rcu flag to the SELinux AVC, but failed to adjust the
>>> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
>>> Previously, we only returned -ECHILD if generating an audit record with
>>> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
>>> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
>>> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
>>> that dump_common_audit_data() calls d_find_alias() and collects the
>>> dname from the result if any.
>>> Other cases that might require similar treatment in the future are
>>> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
>>> a path or file is called under RCU-walk.
>>>
>>> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>   security/selinux/avc.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>>> index 74c43ebe34bb..f1fa1072230c 100644
>>> --- a/security/selinux/avc.c
>>> +++ b/security/selinux/avc.c
>>> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
>>>           * during retry. However this is logically just as if the operation
>>>           * happened a little later.
>>>           */
>>> -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
>>> +       if ((a->type == LSM_AUDIT_DATA_INODE ||
>>> +            a->type == LSM_AUDIT_DATA_DENTRY) &&
>>>              (flags & MAY_NOT_BLOCK))
>>>                  return -ECHILD;
> 
> With LSM_AUDIT_DATA_INODE we eventually end up calling d_find_alias()
> in dump_common_audit_data() which could block, which is bad, that I
> understand.  However, looking at LSM_AUDIT_DATA_DENTRY I'm less clear
> on why that is bad?  It makes a few audit_log*() calls and one call to
> d_backing_inode() which is non-blocking and trivial.
> 
> What am I missing?

For those who haven't, you may wish to also read the earlier thread here 
that led to this one:
https://lore.kernel.org/selinux/20191119184057.14961-1-will@kernel.org/T/#t

AFAIK, neither the LSM_AUDIT_DATA_INODE nor the LSM_AUDIT_DATA_DENTRY 
case truly block (d_find_alias does not block AFAICT, nor should 
audit_log* as long as we use audit_log_start with GFP_ATOMIC or 
GFP_NOWAIT). My impression from the comment in slow_avc_audit() is that 
the issue is not really about blocking but rather about the inability to 
safely dereference the dentry->d_name during RCU walk, which is 
something that can occur under LSM_AUDIT_DATA_INODE or _DENTRY (or _PATH 
or _FILE, but neither of the latter two are currently used from the two 
hooks that are called during RCU walk, inode_permission and 
inode_follow_link).  Originally _PATH, _DENTRY, and _INODE were all 
under a single _FS type and the original test in slow_avc_audit() was 
against LSM_AUDIT_DATA_FS before the split.

> 
>> Added the LSM list as I'm beginning to wonder if we should push this
>> logic down into common_lsm_audit(), this problem around blocking
>> shouldn't be SELinux specific.

That would require passing down the MAY_NOT_BLOCK flag or a rcu bool to 
common_lsm_audit() just so that it could immediately return if that is 
set and a->type is _INODE or _DENTRY (or _PATH or _FILE).  And the 
individual security module still needs to have its own handling of 
MAY_NOT_BLOCK/rcu for its own processing, so it won't free the security 
module authors from thinking about it.  This is only relevant for 
modules implementing the inode_permission and/or inode_follow_link 
hooks, so it only currently affects SELinux and Smack, and Smack only 
presently implements inode_permission and always returns -ECHILD if 
MAY_NOT_BLOCK (aside from a couple trivial cases), so it will never 
reach common_lsm_audit() in that case.


>>
>> For the LSM folks just joining, the full patchset can be found here:
>> * https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t
