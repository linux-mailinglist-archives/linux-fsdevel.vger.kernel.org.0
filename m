Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA551075C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 17:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKVQ2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 11:28:03 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:19807 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVQ2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:28:02 -0500
X-EEMSG-check-017: 33153256|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="33153256"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 16:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574440079; x=1605976079;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=V92KujVdDRAUOMqIQ2F2Sp/3kKB/bbgxyLIWLOAxY3E=;
  b=R7osB2MzEjtB4gXp0MtDq3a9Cm5Cws5Jq+BOlDgvKj1GzF2na+z/jozn
   aLVonAcp9SUd6IvkNVSLGuKAiUqJtAnqeaP/5DAjBT9jTQpteJ+3WWG0x
   JeJnwLImfpaCegcoZYpeyKwm7DQRy250zhiAu8XtlksyA+6y47qP+D8B/
   wsxovVgaUBLS2LaWDHBLmraDJZhcfYZWE8oLxA3dk8L8CRLgXvzxyzs5N
   XI2GtWBBLXmlO6O8d5Cag+FskD3N7W6XXIjWj9e2ImDUwfiU3LO9AFlFO
   lQT0skFapj5Iran27YnVx7IMpxhQN0SNFI5/uWFIjq2Cl3fRmnkgnlvZX
   A==;
X-IronPort-AV: E=Sophos;i="5.69,230,1571702400"; 
   d="scan'208";a="30415959"
IronPort-PHdr: =?us-ascii?q?9a23=3ArkS1nRTPFnnZdGXFSFnn/7PTQtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRSHt8tkgFKBZ4jH8fUM07OQ7/m7HzVdvd3R7jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIttJ6o+yR?=
 =?us-ascii?q?bEo2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEq8BIPPpWk/2r9HZDwE2Mwq1w+b5Etl90oIeWWSSAq?=
 =?us-ascii?q?6WKq/StkWI5u01L+mRZ48foCz9JOQ95/7ykX85nkcQfbK30psTaXC4GOlmIk?=
 =?us-ascii?q?qCbHryjdcOD30KshA9TOP0kl2CVyBcZ3KoU6I7/DE7B5qsDZ3fSYC1nLyBwC?=
 =?us-ascii?q?C7E4VOZm9cF1CMFWzld52eVPcRbCKeO8phkjsDVbi7VYAtzw2htAj/y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DSmxAy9ThwD8mG0GGCUXt0nmUWSD8yxqx/plZ9ylib26?=
 =?us-ascii?q?hin/NYDcBT5+9OUgoiM57T0e16C9TpVQ/aZdeJVU2mTcu8DT4sUN0728UObF?=
 =?us-ascii?q?plG9W+khDD2DKnA7sUl7yNGZw1/bvQ33bqJ8lg1XnGyrcuj109T8tROm2pmL?=
 =?us-ascii?q?R/+xLQB4HXiUWZkbildaAG0C7K7meDwjnGgEYNeQo4b6TfWjhLeErMqvzr60?=
 =?us-ascii?q?XDUfmqCLI6Ik1G08HEN6gcOfPzilATf+vuINTTZSqKnm60ARuZjueXYJHCZ3?=
 =?us-ascii?q?QW3CKbDlMN1Q8U4yDVZkAFGi69rjeGX3RVHlX1bhapqLQvpQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3AAA4DNhd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdIFtIBIqhCqJA4ZSBoE3iWeKH4ckCQEBAQEBAQEBA?=
 =?us-ascii?q?TcBAYRAAoJOOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgmwBAQEBAgEjBBFBB?=
 =?us-ascii?q?QsLGAICJgICVwYNBgIBAYJfP4JTBSCuVnV/M4VOgzWBSIEOKIwweIEHgREng?=
 =?us-ascii?q?ms+hA6DR4JeBI0SC4lCRnSWF4I1gjeTEwYbmhgtqjgigVgrCAIYCCEPgydQE?=
 =?us-ascii?q?RSGVBcVjiwjAzCPBYJAAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 16:27:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMGRahY070678;
        Fri, 22 Nov 2019 11:27:36 -0500
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, will@kernel.org,
        neilb@suse.de, linux-fsdevel@vger.kernel.org
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
 <20191121145245.8637-2-sds@tycho.nsa.gov>
 <20191122161131.GB26530@ZenIV.linux.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <18fef491-bee5-fbf6-a3b8-113150f324b4@tycho.nsa.gov>
Date:   Fri, 22 Nov 2019 11:27:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122161131.GB26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/19 11:11 AM, Al Viro wrote:
> On Thu, Nov 21, 2019 at 09:52:45AM -0500, Stephen Smalley wrote:
>> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>> passed down the rcu flag to the SELinux AVC, but failed to adjust the
>> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
>> Previously, we only returned -ECHILD if generating an audit record with
>> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
>> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
>> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
>> that dump_common_audit_data() calls d_find_alias() and collects the
>> dname from the result if any.
>> Other cases that might require similar treatment in the future are
>> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
>> a path or file is called under RCU-walk.
>>
>> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   security/selinux/avc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index 74c43ebe34bb..f1fa1072230c 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
>>   	 * during retry. However this is logically just as if the operation
>>   	 * happened a little later.
>>   	 */
>> -	if ((a->type == LSM_AUDIT_DATA_INODE) &&
>> +	if ((a->type == LSM_AUDIT_DATA_INODE ||
>> +	     a->type == LSM_AUDIT_DATA_DENTRY) &&
>>   	    (flags & MAY_NOT_BLOCK))
> 
> IDGI, to be honest.  Why do we bother with slow path if MAY_NOT_BLOCK has
> been given?  If we'd run into "there's something to report" case, we
> are not on the fastpath anymore.  IOW, why not have
>          audited = avc_audit_required(requested, avd, result, 0, &denied);
>          if (likely(!audited))
>                  return 0;
> 	if (flags & MAY_NOT_BLOCK)
> 		return -ECHILD;
>          return slow_avc_audit(state, ssid, tsid, tclass,
>                                requested, audited, denied, result,
>                                a, flags);
> in avc_audit() and be done with that?

That works for me; we would also need to do the same in 
selinux_inode_permission().  We can then stop passing flags down to 
slow_avc_audit() entirely.

> It's not just whether we *can* collect whatever audit might want; do
> we want to try and make an audit-spewing syscall marginally faster?
> And "marginally" is all you'll get there, really...
> 
> We could do
>          error = security_inode_follow_link(dentry, inode,
>                                             nd->flags & LOOKUP_RCU);
>          if (unlikely(error)) {
> 		if (error == -ECHILD && !unlazy_walk(nd))
> 			error = security_inode_follow_link(dentry, inode, 0);
> 		if (error)
> 			return ERR_PTR(error);
> 	}
> in fs/namei.c:get_link() to slightly reduce the costs; that might or
> might not be useful - I'd like to see profiling results first.  But
> trying to push the actual "spew to audit" into RCU case?  What for?
> 

