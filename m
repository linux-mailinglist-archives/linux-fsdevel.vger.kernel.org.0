Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A711940D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 15:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgCZOD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 10:03:56 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:40123 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgCZOD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:03:56 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 10:03:55 EDT
X-EEMSG-check-017: 89856681|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="89856681"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 13:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585231008; x=1616767008;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4klW1VsqpgpHGLj7aCzdzQeSrTNXwsMKRK/eE1tKzn0=;
  b=NQVSQC5kzZwKlTNahP27uiFEE2PijMn+eSdTQxXAX/reZBYnduWMzXp/
   IBW8kcEQqzd0xmQmTfuOdzEcFDRQUuZi8E2mz1HP3p4YI9xgMnHuHBYPO
   t63uD9p0F9BoSk8uFgCfVtzD81FNVH8Xp5OzMG64FN5Sg9bJREQGJbXq5
   lJ+BmrlPXOt0TIv6zcQAu6k9lM0s23dOxCrb3IbO8tYVssz6S03JrSUAg
   0/WcczEkpg2D8JjS3wHWL9+Ebrh2LNpvYE8Xf4bAoD32JR1ZqBSYPPIQ8
   JEdhffqyLn5UVCs5PJYquMFpfwn99UhWfDsG55leiM/SqmQb5G2Kla45S
   Q==;
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="34628563"
IronPort-PHdr: =?us-ascii?q?9a23=3Aou2MNRaqYuCnBWTiuirW+Pf/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsqybR7h7PlgxGXEQZ/co6odzbaP7+a5BDJLvMjJmUtBWaIPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMLjYZiK6s9xR?=
 =?us-ascii?q?vEr3pVcOlK2G1kIk6ekBn76sqs5pBo7j5eu+gm985OUKX6e7o3QLlFBzk4MG?=
 =?us-ascii?q?47+dPmuwDbQQSA+nUTXGMWkgFVAwfe9xH1Qo3xsirhueVj3iSRIND7Qqo1WT?=
 =?us-ascii?q?Sm6KdrVQPohSIaPDM37G3blsp9h79ArRm/uxJw3ZLbYICNNPp/YKzde88aRX?=
 =?us-ascii?q?FcVcpVTiBNH5+wY5cKA+cHM+lYtY39rEYQoxW4CwenGefjxiZGi3Ly2KE31f?=
 =?us-ascii?q?kqHwPb0ww6B98ArWrarNv1OqkRX+66wqbHwjffYP1Zwjr99IrFfwo9rf2QU7?=
 =?us-ascii?q?99c8zcwlQvGQPfiVWQrJToMS6J1usTq2ib7/RvVeSygGA6rgF+uDyvxsMyhY?=
 =?us-ascii?q?jJm4kYzUvE+jhiwIsuOd25SFJ0Yd6jEJdKsSGaLJF5TtktQ2FvpiY307sLso?=
 =?us-ascii?q?O4cigS0Jkr2hHSZvOdf4WI/x7vTvidLDhmiH5/Zb6ygQu5/1K6xe3mTMa01U?=
 =?us-ascii?q?5Hri9CktbRqH8AzwfT6s2bSvtl+UehxCqP2xjT6u5aJUA0krLWK4I7zb4ql5?=
 =?us-ascii?q?oTrF/DEjXqmET2kKCWdkIk9vKu6+v7ebXpuoWQN4p1igH6Kqgum8q/DvokMg?=
 =?us-ascii?q?UWQmSW9uux2Kfj8EHkWrlGkPI7nrfDvJzHPcgbo7S2Aw5R0oYt8Ra/CDKm3c?=
 =?us-ascii?q?wDnXYaN1JIYw6Hjoj1NFHOJ/D0F/G/g0+2nztxyPDGOaPhDo3XLnffiLfhYa?=
 =?us-ascii?q?p960lExQUu199f4Y5bCrYFIP/oVU/xs9vYDhA9MwOq2eroFNJ91oYGU2KVHq?=
 =?us-ascii?q?CZKL/SsUOP5u83P+mMZYoVuDPgK/g//f7hl384lEQSfamu2psXZ3S4Eep8L0?=
 =?us-ascii?q?qFZnrsh88LEX0WsQomUOzqlFqCXCZIZ3msW6I85zc7CJ+pDIrYWICtj6KO3D?=
 =?us-ascii?q?2hEp1VeG9GEFaMHmnsd4meXPcMci2SKNd7kjMYTbihV5Mh1Ra2uQ/+yrpnKP?=
 =?us-ascii?q?fU+yIBuZL4ytd6+/DTlQsz9TxoD8WRymSNT2ZpkWMVQz85wrtyoVJyylidy6?=
 =?us-ascii?q?h0mf9YGsJJ5/NPTAg6MYTQz+tgC9D9QgjBZMuGSE66QtW6BjE8VtYxw94IY0?=
 =?us-ascii?q?ZgFNSulx7D3zG3DLALibyEGpg0/7nC33j+Ocl90WzK1Ko/gFk8RMtAK2mmir?=
 =?us-ascii?q?R49wjJCI7Di1+ZmLqydaQAwC7N83+OzW6PvEFeTQ5xXrzJXXMBaUvMq9T2+E?=
 =?us-ascii?q?fCQqSwCbQoLARB09SOKqhUZd3zi1VJWvPjNM7ZY2KrlGe6HQyIya+UbIr2Z2?=
 =?us-ascii?q?Ud2z3QCEsakwAW5nuGKwc+CTm7o27EDzxhC0jvY0Xy/ul6sn+7SVU0zw6SZU?=
 =?us-ascii?q?17y7W14gIVheCbS/4LwLIEuT0hqzJvEVe8wd3WDduApxR7cKVYYNM95kpH1G?=
 =?us-ascii?q?3Duwx6JJygILpuhkMdcw5vpUPhyw13CplckcgttH4q1BB9Kb+c0F5abzOXx4?=
 =?us-ascii?q?3wOrnOJmn3+xCvbLTW1U/E3NmK/acP7ewyq0//swGxCkoi73Jn3sFT03ua5Z?=
 =?us-ascii?q?XHFwUSUZX2UkY48xh1uavWbTU654PRzXdsK7W7sife29I1A+so0hKgf9BcMK?=
 =?us-ascii?q?yaDw/yE8IaB8mzJ+wwgVekdR0EPOdV9K47O8OpaeGK17KsPOZlz3qaijFr6Y?=
 =?us-ascii?q?Z830bE3C14Q/XD3pEDzrnM0gKBXDD4pFimtc/zlMZPYjREWiKjyC3hGZRLb7?=
 =?us-ascii?q?xacoEMBmOjZcaww5E2nJPpWnhF5Ha9CF4cnsykYxyfaxr6xwIUnUAWp2G33D?=
 =?us-ascii?q?C1xCFuki0466+Y0DHKzsz8excdfG1GXm9viRHrO4fwx9QbWlW4KgYymBa76E?=
 =?us-ascii?q?LS2adWvuJ8InPVTEMOeDL5aylmU62tpv+BbtRJ5ZcArypaSqK/bEqcR7q7pA?=
 =?us-ascii?q?EVl2vgAW522j82bXept4//khg8j3iSaD5trWDeUdN9wxbBotjdQ+NBmD0cS2?=
 =?us-ascii?q?9lin2fHlGhO/Gx9MiQ0pLEtfqzEWmmU9kbdy/o5YyHsyS/6CthBhj71/S0md?=
 =?us-ascii?q?D8EQc73TXy/9ZtUirMoVD3ZYy4+b69NLdcYkRwBFL6o/F/E4V6n5p40Iocwl?=
 =?us-ascii?q?AGl56V+jwBim61PtJFj/GtJEERTCIGloaGqDPu31duezfQnNP0?=
X-IPAS-Result: =?us-ascii?q?A2B0AAAltHxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF8LIFBMiqEGo58gWwliXqPUoEkA1QKAQEBAQEBAQEBNAECBAEBhEQCg?=
 =?us-ascii?q?i8kNgcOAhABAQEFAQEBAQEFAwEBbIVigjspAYJ/AQUjBBFRCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JYJa1zfzOFS4NSgT6BDioBjC4aeYEHgREnDAOCXj6ES4MRg?=
 =?us-ascii?q?l4Elw9xmFWCRoJWlC0GHYJMjQKMEY8RnXYBMTeBISsIAhgIIQ+DJ1AYDY4pF?=
 =?us-ascii?q?41sVSUDMIEGAQGOHQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Mar 2020 13:56:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QDv8uu044529;
        Thu, 26 Mar 2020 09:57:08 -0400
Subject: Re: [PATCH v2 2/3] Teach SELinux about anonymous inodes
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com
References: <20200214032635.75434-1-dancol@google.com>
 <20200325230245.184786-3-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b5999b89-6921-5667-9eb2-662b14d5f730@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 09:58:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325230245.184786-3-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/25/20 7:02 PM, Daniel Colascione wrote:
> This change uses the anon_inodes and LSM infrastructure introduced in
> the previous patch to give SELinux the ability to control
> anonymous-inode files that are created using the new _secure()
> anon_inodes functions.
> 
> A SELinux policy author detects and controls these anonymous inodes by
> adding a name-based type_transition rule that assigns a new security
> type to anonymous-inode files created in some domain. The name used
> for the name-based transition is the name associated with the
> anonymous inode for file listings --- e.g., "[userfaultfd]" or
> "[perf_event]".
> 
> Example:
> 
> type uffd_t;
> type_transition sysadm_t sysadm_t : file uffd_t "[userfaultfd]";
> allow sysadm_t uffd_t:file { create };
> 
> (The next patch in this series is necessary for making userfaultfd
> support this new interface.  The example above is just
> for exposition.)
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>   security/selinux/hooks.c            | 54 +++++++++++++++++++++++++++++
>   security/selinux/include/classmap.h |  2 ++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1659b59fb5d7..b9eb45c2e4e5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2915,6 +2915,59 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> +	if (unlikely(!selinux_state.initialized))
> +		return 0;

This leaves secure anon inodes created before first policy load with the 
unlabeled SID rather than defaulting to the SID of the creating task 
(kernel SID in that situation).  Is that what you want?  Alternatively 
you can just remove this test and let it proceed; nothing should be 
break and the anon inodes will get the kernel SID.

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
> +		isec->sclass = context_isec->sclass;
> +		isec->sid = context_isec->sid;
> +	} else {
> +		isec->sclass = SECCLASS_ANON_INODE;
> +		rc = security_transition_sid(
> +			&selinux_state, tsec->sid, tsec->sid,
> +			SECCLASS_FILE, name, &isec->sid);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	isec->initialized = LABEL_INITIALIZED;
> +
> +	/*
> +	 * Now that we've initialized security, check whether we're
> +	 * allowed to actually create this type of anonymous inode.
> +	 */
> +
> +	ad.type = LSM_AUDIT_DATA_INODE;
> +	ad.u.inode = inode;
> +
> +	return avc_has_perm(&selinux_state,
> +			    tsec->sid,
> +			    isec->sid,
> +			    isec->sclass,
> +			    FILE__CREATE,
> +			    &ad);
> +}
> +
>   static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
>   {
>   	return may_create(dir, dentry, SECCLASS_FILE);
> @@ -6923,6 +6976,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   
>   	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
>   	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
> +	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
>   	LSM_HOOK_INIT(inode_create, selinux_inode_create),
>   	LSM_HOOK_INIT(inode_link, selinux_inode_link),
>   	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 986f3ac14282..263750b6aaac 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -248,6 +248,8 @@ struct security_class_mapping secclass_map[] = {
>   	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
>   	{ "lockdown",
>   	  { "integrity", "confidentiality", NULL } },
> +	{ "anon_inode",
> +	  { COMMON_FILE_PERMS, NULL } },
>   	{ NULL }
>     };
>   
> 

