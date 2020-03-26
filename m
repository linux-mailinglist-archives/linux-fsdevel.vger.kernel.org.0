Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5377919471C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCZTIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 15:08:25 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:20848 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:08:25 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 15:08:22 EDT
X-EEMSG-check-017: 70905491|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="70905491"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 19:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585249265; x=1616785265;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=vtF6BtykO350/rMpFc78UUGhjIlgmvfhIHBzW2CVU3c=;
  b=L44oCrB+bgn0NlYS3csYW0C2wPwLH3OjJsdw8u3g/DVwlJXjAbOiCtfu
   ZuPxp5JmrrbgElzBGRWsS6F2879jsRJiQtwHYuSdbUp/Qg4IAclsOcTT0
   K3m3NfeAFH2j3OGW+aLfddtNyajN4IJ4/vN+hiRPmmRuAR19SNHz5n1Vp
   8D2es0MV2RKZbafIb340cBzZd7JdP3F5CDYNwtwCnJKQfsLIUsUXg81W8
   XI4pRLPgRLl94l+/5oPG0wrlO+gnp5tCKs0jPhJc7aRT6mcFtaGLkuczM
   1AeLgHCuCk6ZdCz5Pth3Xs2U4vXg8UudT5JaSRQqeZNUISmW5An2Zs7OE
   A==;
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="34650377"
IronPort-PHdr: =?us-ascii?q?9a23=3AFf07fxbyn8jIu0nIUdFW5h3/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsu/bB7h7PlgxGXEQZ/co6odzbaP7+a5BDNLvMrJmUtBWaIPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMLjYZiKKs9xR?=
 =?us-ascii?q?vEr3RVcOlK2G1kIk6ekBn76sqs5pBo7j5eu+gm985OUKX6e7o3QLlFBzk4MG?=
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
 =?us-ascii?q?yaDw/yE8IaB8mzJ+wwgVekdR0EPOdV9K47O8OpaeGK17KsPOZlhDiml3hI4J?=
 =?us-ascii?q?hh0kKQ8CpxUuzI35MCw/GCxAuHViz8gUynss/tnIBLezASEnC4ySj+C44CLp?=
 =?us-ascii?q?F1KKoCD2ajJ4WcwdF3nJXsXHhVvAqvDlUN38uBdh2VYFjwmwZX0BJT6WCmnC?=
 =?us-ascii?q?6l1SZ9ghkmqa2Q2CGIyOPnMFIcN2pKQnRypUnjLJLyjN0AWkWsKQ8zm1/t4U?=
 =?us-ascii?q?f82rgev6l0MnPSXVYNei/6MmVverW/u6DEYMNV7p4s9yJNX6D0ZVGcV664rQ?=
 =?us-ascii?q?AW3j3uG0NAyz0hMTKnoJP0m1p9km3ZZHJyqmfJPMJ93xHS4PTCSvNLmDkLXi?=
 =?us-ascii?q?91jX/QHFf4d9q3+P2KmJrZ9OOzTWSsUttUayavhZ2BriyT92BsAAP5m/G1h8?=
 =?us-ascii?q?2hFhI1lzL4k5FyXDjMhA71f42u0qO9K+8hdU5tQBf67clSFYZ5nY89wpoX3D?=
 =?us-ascii?q?xSgpKW8GEHnmb/K9xz1qX5Y34AAzUMxpqd4g3iwldiNVqPzof0VzOa2MQySc?=
 =?us-ascii?q?O9ZzYtxi8l781MQJyR5bhAkDo99kG0tirNcPN9mXEb0vJo53kE1bJa8DExxz?=
 =?us-ascii?q?mQV+hBVXJTOjbhwlHRtIGz?=
X-IPAS-Result: =?us-ascii?q?A2DvAACg+nxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8LIFBMiqEGo58VAaBEiWJepB2A1QKAQEBAQEBAQEBNAECBAEBhEQCg?=
 =?us-ascii?q?i8kNwYOAhABAQEFAQEBAQEFAwEBbIVigjspAYJ/AQUjBBFRCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JYJa4afzOFS4NfgT6BDioBjC4aeYEHgTgMA4JePoRLgxGCX?=
 =?us-ascii?q?gSXD3GYVYJGglaULQYdm1+PEZ4FIzeBISsIAhgIIQ+DJ1AYDY4pF41sVSUDM?=
 =?us-ascii?q?IEGAQGOHQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Mar 2020 19:01:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QJ1OMB196557;
        Thu, 26 Mar 2020 15:01:24 -0400
Subject: Re: [PATCH v3 2/3] Teach SELinux about anonymous inodes
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com, jmorris@namei.org
References: <20200214032635.75434-1-dancol@google.com>
 <20200326181456.132742-1-dancol@google.com>
 <20200326181456.132742-3-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8478b39c-5ddd-6495-1f32-d973a5ee9edd@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 15:02:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326181456.132742-3-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/26/20 2:14 PM, Daniel Colascione wrote:
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
> type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> allow sysadm_t uffd_t:anon_inode { create };
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

I guess you missed the 2nd comment in my reply to v2 of this patch:
You should use isec->sclass aka SECCLASS_ANON_INODE instead of 
SECCLASS_FILE here.
