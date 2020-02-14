Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A763115E619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406310AbgBNQps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 11:45:48 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:29315 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbgBNQps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:45:48 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Feb 2020 11:45:47 EST
X-EEMSG-check-017: 56169778|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56169778"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 16:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581698315; x=1613234315;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=A18DncqTUADO2fhOFmzTsoqfMTabU6XL5YSHf/8ms1w=;
  b=a1zr0kKpzxGgSHWX6okpoNSsd7f4AS9AtJ9ZedcG7Km/2cnZi6LXHli+
   LzCyW9FDlPhwhbFLItBVXyuNqIEWj1LbahAY7uiQ1AMUvAFIJ9PxK59Qo
   h0W09PFZ3wiCA2OnuG/llsvNxockueHX9fqv7QA7jVdtT9VptGw8wsRMp
   xgFbEDe1lSSKWQ0tEzQjVDIk4loo8Rhlcg//8weHOtyajYQ0lxXSSwmx0
   2/nYyV2f63qBkTE9UQaSMhUTDQMXIS0I3mYcTCDcXNEI9Q+OZaXRHoWjI
   Yl5i3N9+gN6ZZ3zZgaIx7Lr7Pmqkyvj6aUN2DlKcYNAxO1J6HkKxBK51Z
   w==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="33082497"
IronPort-PHdr: =?us-ascii?q?9a23=3Aa5cC6RMIUkbScbcd//ol6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/v7pcbcNUDSrc9gkEXOFd2Cra4d16yJ6+uxASQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twfcutUZjYZmNqo61w?=
 =?us-ascii?q?fErGZPd+lKymxkIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhBOfixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTsELDHiHxmEXtkqCZal8o+vSo6uv7YrXmoYWQN4lohQHlLqsigMm/AeU8Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHkT7hHgec6n6nEvJzAO8gWqbC1DxVI3oo77hawFTam0N?=
 =?us-ascii?q?AWnXkdK1JFfQqKj5P0NFHVO/34Efe+jEiskDds3fzGOKbhDY/XInjMl7fhY6?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kcL/3pXE/+qNvYDhsiPgy7xObnD9p91ocAVm6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg55v7uiHo5mUIHfamzx5QWaGu1HvthI0?=
 =?us-ascii?q?WebnrshskOHX0WsQo5SezgkEeCXiJLZ3auQ6I84Sk2CJm4AofHR4CthqGB3S?=
 =?us-ascii?q?igE51IaWBJFEqMHW3rd4qaQfcMbjydIst7njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUctZLi0th1+uLSmQgp9TNqE8udznuNT2BonmIIXjM22ad/rlFgyleHz6?=
 =?us-ascii?q?d1mOJYFdNN6PNTSAs6NoDTz/Z8C9/sXgLNZNCJSEypQt++GzE+Usoxw8MSY0?=
 =?us-ascii?q?Z6A9iiihHD3yy3A74ajrCLCoc0/b/C0HjvOcl9z23L1Lcuj1Y4WMtDL26mib?=
 =?us-ascii?q?Bl9wjVGYHJl1+Vl6GwdaQTxCTN7nuMzXKSvEFEVw59SaHFXXEZZkvLotX1/0?=
 =?us-ascii?q?DCQKG0CbQhLARBzdWPKrVFatL3l1VKXvTjN8rEY2K3hWiwAQyExrSWbIrlY2?=
 =?us-ascii?q?8dxjnSCFAYkwAP+naLLQs+Bjmko2/FEjxuGkzgY1n2/el9tny7VEk0wB+Ob0?=
 =?us-ascii?q?F70Lq14BEVj+SGS/wPxrIEpDshqzJsEVaj3tLWEd2AqhFgfapCZ9M94UlH2X?=
 =?us-ascii?q?jdtwx8OJygMq9jikQZcwRtsEPizQh3CoZYm8gwsHwq1BZyKb6f0F5ZbzOXx4?=
 =?us-ascii?q?3wOrnMJ2nq5h+vdqrW1kjb0NaR/acP8uo3p0//swGuE0oo629n3MVN03uA+p?=
 =?us-ascii?q?XKCxIfUZT3UkY07BV6qLbaYi4y54PQy3JgK7W7sjjH29gxHusq1g6gf8tDMK?=
 =?us-ascii?q?ODDALyF8oaB8uwJ+wxm1ipYRMEM/1I9KEuJM6mePyG2KmkPOZkgj2ql3hI4I?=
 =?us-ascii?q?d40hHEyy0pZufO3psBi9qf2gKcXDb7ilrp5sz+n4tDYRkdGW2wzSWiD4lUMO?=
 =?us-ascii?q?k6YYcODHq0OcSm7tp5gJHpVjhT81vnT0gL3M6vZAq6cVPwx0tT2F4RrHjhnj?=
 =?us-ascii?q?G3i3Rwkjc0vu+E0SfT2eX+ZV8CPWJWQGRKk1jhO863gsocUUzuaBIm0FOh5E?=
 =?us-ascii?q?Dn1+1Vv6hyMWTXaVlHcjKwLGx4VKa08L2YbIoH7JIurDUSU+mmZ12eYqDyrg?=
 =?us-ascii?q?Fc0C75GWZagjcheHXiuYv8twJ1hXjbL3tpqnfdP8ZqylOX+t3GQtZD0zwHWm?=
 =?us-ascii?q?98iD/KFh67Jdbv4NbQ34/Kr+SWT2u8UthWdi7xwMWLsy7/rWtsAjWwmPe8nt?=
 =?us-ascii?q?ChGg8/lWf/0NpnTiXHrRrma6Hk0KO1Ne8hdU5tV3Hm7M8vIZ1zios9gtkr3H?=
 =?us-ascii?q?EegpiEtS4cnXzbLcRQ2aW4amEEAzEM3YiGs0DexER/IyfRlMrCXXKHz54kPo?=
 =?us-ascii?q?Trbw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CeBAAszEZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XYFgW0gEoQ+iQOGWQEBBAaBEiWJcJFKCQEBAQEBAQEBATcEAQGEQAKCJTgTA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwEBbIVDQhYBgWIpAYMCAQUjBBFRCw4KAgImAgJXBgEMC?=
 =?us-ascii?q?AEBgmM/glclri5/M4VKg0uBPoEOKgGMPXmBB4ERJwwDgl0+hEuDEIJeBI1gM?=
 =?us-ascii?q?4hQZEaXbYJEgk+TfAYcmxiOaJ0/IoFYKwgCGAghD4MoTxgNjikXjWxVIwONM?=
 =?us-ascii?q?oNWAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2020 16:38:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EGbXVq185655;
        Fri, 14 Feb 2020 11:37:34 -0500
Subject: Re: [PATCH 2/3] Teach SELinux about anonymous inodes
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com
References: <20200211225547.235083-1-dancol@google.com>
 <20200214032635.75434-1-dancol@google.com>
 <20200214032635.75434-3-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9ca03838-8686-0007-0971-ee63bf5031da@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 11:39:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214032635.75434-3-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/20 10:26 PM, Daniel Colascione wrote:
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1659b59fb5d7..6de0892620b3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2915,6 +2915,62 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   	return 0;
>   }
>   
> +static int selinux_inode_init_security_anon(struct inode *inode,
> +					    const struct qstr *name,
> +					    const struct file_operations *fops,
> +					    const struct inode *context_inode)
> +{
> +	const struct task_security_struct *tsec = selinux_cred(current_cred());
> +	struct common_audit_data ad;
> +	struct inode_security_struct *isec;
> +	int rc;
> +
> +	if (unlikely(IS_PRIVATE(inode)))
> +		return 0;

This is not possible since the caller clears S_PRIVATE before calling 
and it would be a bug to call the hook on an inode that was intended to 
be private, so we shouldn't check it here.

> +
> +	if (unlikely(!selinux_state.initialized))
> +		return 0;

Are we doing this to defer initialization until selinux_complete_init() 
- that's normally why we bail in the !initialized case?  Not entirely 
sure what will happen in such a situation since we won't have the 
context_inode or the allocating task information at that time, so we 
certainly won't get the same result - probably they would all be labeled 
with whatever anon_inodefs is assigned via genfscon or 
SECINITSID_UNLABELED by default.  If we instead just drop this test and 
proceed, we'll inherit the context inode SID if specified or we'll call 
security_transition_sid(), which in the !initialized case will just 
return the tsid i.e. tsec->sid, so it will be labeled with the creating 
task SID (SECINITSID_KERNEL prior to initialization).  Then the 
avc_has_perm() call will pass because everything gets allowed until 
initialization. So you could drop this check and userfaultfds created 
before policy load would get the kernel SID, or you can keep it and they 
will get the unlabeled SID.  Preference?

> +
> +	isec = selinux_inode(inode);
> +
> +	/*
> +	 * We only get here once per ephemeral inode.  The inode has
> +	 * been initialized via inode_alloc_security but is otherwise
> +	 * untouched.
> +	 */
> +
> +	if (context_inode) {
> +		struct inode_security_struct *context_isec =
> +			selinux_inode(context_inode);
> +		if (IS_ERR(context_isec))
> +			return PTR_ERR(context_isec);

This isn't possible AFAICT so you don't need to test for it or handle 
it.  In fact, even the test for NULL in selinux_inode() is bogus and 
should get dropped AFAICT; we always allocate an inode security blob 
even before policy load so it would be a bug if we ever had a NULL there.

> +		isec->sid = context_isec->sid;
> +	} else {
> +		rc = security_transition_sid(
> +			&selinux_state, tsec->sid, tsec->sid,
> +			SECCLASS_FILE, name, &isec->sid);
> +		if (rc)
> +			return rc;
> +	}

Since you switched to using security_transition_sid(), you are not using 
the fops parameter anymore nor comparing with userfaultfd_fops, so you 
could drop the parameter from the hook and leave the latter static in 
the first patch.
That's assuming you are ok with having to define these type_transition 
rules for the userfaultfd case instead of having your own separate 
security class.  Wondering how many different anon inode names/classes 
there are in the kernel today and how much they change over time; for a 
small, relatively stable set, separate classes might be ok; for a large, 
dynamic set, type transitions should scale better.  We might still need 
to create a mapping table in SELinux from the names to some stable 
identifier for the policy lookup if we can't rely on the names being stable.
