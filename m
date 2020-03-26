Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9319458E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgCZRhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 13:37:34 -0400
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:23802 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:37:33 -0400
X-EEMSG-check-017: 93888031|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="93888031"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 17:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585244201; x=1616780201;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4btUFkjZphQF2UdhZnXwDJJ8A/TabzXpxKrmQP1Nhwc=;
  b=M9sVOfTNm3W1Xx1nQoEDacgCYJ97K4U2NzzCI6OpQUKXL+Y1AHi0IIJn
   SralracjvE/QBOe0zzf4FaCRWNuaPYgqzzaUJJ6MHijxKnnkUXcF4B/0d
   ujYUpDig1U8AZEHoCNhKlr3LUmjIKpKoC/SwOhAS/8KvNWsmnuLN4uZrZ
   YHVJT5JUM1Cd74hdGXESojkbtRfkKRXltpWwVsHmHKa9IeNG3Y5UnpCR2
   KOJCyWBOxMd6+TFiJRmqHcujqvXww1x0O6V5vNiCpCfR6NAh7f5f3VNhz
   oxt4TM8I6wqzTS6VYYlP5Eg8PDUC4zvF0nvIYxbfC1SVt8bZ+iQ11MUN5
   Q==;
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="34644859"
IronPort-PHdr: =?us-ascii?q?9a23=3ARN2Bwhfdok8C1OGOSHEDiy9nlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc28bB2N2/xhgRfzUJnB7Loc0qyK6vymADFfqs3e+Fk5M7VyFD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMnIdvKqQ8xh?=
 =?us-ascii?q?THr3ZKZu9b2X5mKVWPkhnz4cu94IRt+DlKtfI78M5AX6T6f6AmQrFdET8rLW?=
 =?us-ascii?q?M76tD1uBfaVQeA6WcSXWsQkhpTHgjK9wr6UYvrsiv7reVyxi+XNtDrQL8uWD?=
 =?us-ascii?q?Si66BrSAL0iCoCKjU0/n3bhtB2galGux+quQBxzJDIb4GULPp+f73SfdUGRW?=
 =?us-ascii?q?paQ81dUzVNDp6gY4cTCuYMO+hXr5P5p1ATsxWwAweiD/7rxjNRiHL72ag23u?=
 =?us-ascii?q?I8Gg/EwQMgBcoDvmnKotX7NKkcUu67w6fHwjrBc/xY1izw6JTKfx07vf2AQb?=
 =?us-ascii?q?x9fMjXxEIyFw3FlFKQqYn9Mj2IyuQCrXCb7+p+WuKplmUptgRxrSKrxscolI?=
 =?us-ascii?q?bIhp8ex1ff9Spk24Y4PsG4SU5nbt6kF5tcrSeaN5BsTc84TGFovzg6x6QAtJ?=
 =?us-ascii?q?WmfyYK0IwqywPQZvGIaYSF4g/vWPyPLTp3mn5pYq+zihCv+ka60OL8TNO70F?=
 =?us-ascii?q?NSoypAldnDq24C2gTI6siCVvt95kCh2SuT1wzL6uFLP0Q0la3DJp492LEwjJ?=
 =?us-ascii?q?sTsVnYHiPshEX3jLOZdkUj+uSy7eTofq7mqYOGO49xiwH+Nrwims25AesmLg?=
 =?us-ascii?q?gDR3WX9Ouz2bH5/UD1Xa9GguM5n6XHqpzWONwXpqujDA9U1oYj5Qy/DzCj0N?=
 =?us-ascii?q?kAhnkIMUlFdQmbj4npJ17OIPf4Ae25g1S3ijhn3f/GPrr/ApnVNHjMjK/hfa?=
 =?us-ascii?q?ph605b0Ac80MpQ55RIBbEGJPL+QUDxtNvfDh82Nwy73fzrB8l61oMbQWiPGL?=
 =?us-ascii?q?OWMLvOsV+U4eIiO/WMZI4QuDb4Nvgl/eTugmU5mFIGcqmp2pwXaH+8Hvt4OU?=
 =?us-ascii?q?mWfX3sgtIZG2cQogU+VPDqiEGFUTNLfHa9QaY85jA9CIK7AobOXZ6tgLOf0y?=
 =?us-ascii?q?ehBJFWZX5JCkqKEXj2c4WIQfAMaDidIsV5iDwLSaChS5M91RGprAL6z7tnLu?=
 =?us-ascii?q?zJ+iwXrJ7jz8Z66PHOlREo9Dx0E8Sc33iIT2Fzg2wIWjs2075krExjxVeMz7?=
 =?us-ascii?q?J4j+ZbFdNN/fNJVBk1NZrGw+x9EdDyVRrLfs2VR1a+XtWmHTYxQ8o1w98PZU?=
 =?us-ascii?q?Z9BtqjggnN3yqxHrAaiaKLC4Iw8q/HwXjxKNhyy2zc2KkikVYmWM1POnOihq?=
 =?us-ascii?q?Jl8AjTHYHJmV2Dl6m2baQcwDLN9GCbwGqKvUFYVhNwUKrcUXAceETWt9L56V?=
 =?us-ascii?q?3GT7K1F7QnPRVOydSYJqtJdNLpl1NGS+nnONjEZGKxgWiwDw6SxryQdIrqZ3?=
 =?us-ascii?q?kd3CLFBUgHjQAT+G2LNRYxBii/uWLSFj9uGkz1Y0Pq7+Z+rGm3TkguzwGFd0?=
 =?us-ascii?q?dhzaa6+gYJhfyATPMexqwEuCY7qzVzB1u83szZC9yBpwp/ZqlcZdI94FFa1W?=
 =?us-ascii?q?PWrQB9OYagL694il4DcAR9p1nu2AlvCoVcjcgqq2snzBJoJqKF1FNMbCuY0o?=
 =?us-ascii?q?rtOr3TM2Xy+Reva6nM2l7AytqZ5qAP6PEgoVX5oA6pDlYi82lg09RN1Xuc4J?=
 =?us-ascii?q?bKAREdUZL2VUY3+Bx6qK/AbiYh4IPU0GVmMbOovT/ax9IpGOwlxw6kf9dYM6?=
 =?us-ascii?q?OLChTyE80VB8ivNeMqgUKmYwkLPOBV8640MMemeOWc1KG3O+ZgmWHusWMSzI?=
 =?us-ascii?q?l700+IvwF7TufT1JcCxfzQigeOUTz7iH+utcf4nY0CbjYXSC731SnhAZNLfK?=
 =?us-ascii?q?RjVYkMDmiqLou8wdA6z4XgX39e6U6LGVwLwomqdACUYli72hdfkQwToHq6iW?=
 =?us-ascii?q?6jwjdpiTA1v++a2yDTx+nKahUKIChISXNkgFOqJpK7y5geXU61f00njxeo+0?=
 =?us-ascii?q?v+77ZUqb45LGTJR0pMOS/sICUqVqq2q6rHYMNV7p4smTtYXf76Yl2ATLP55R?=
 =?us-ascii?q?wA3GerHHVb7C40eivsuZjjmRF+zmWHIzI7snvDfuliyBHe+prYRPhMznwBXi?=
 =?us-ascii?q?Y+lDqTTkC1It2B5dyJk9LGteekWiSqUZgXOS/tzquPsyy04WAsChq627i3nd?=
 =?us-ascii?q?7qCgg10CPh3vFlUiLHqBu6aY7uhIqgNucyRVVlHF/x7YJBH4h6loYhzMUL1W?=
 =?us-ascii?q?MymoSe/X1Bl3z6d9pcx/StPzI2WTcXzouNs0De00p5IyfMntmoWw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DuAADi53xe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8LIFBMiqEGo5+VAaBN4l6kHYDVAoBAQEBAQEBAQE0AQIEAQGERAKCL?=
 =?us-ascii?q?yQ3Bg4CEAEBAQUBAQEBAQUDAQFshWKCOykBgn8BBSMEEVELDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgmM/glglrXp/M4VLg16BPoEOKgGMLhp5gQeBOA+CXj6ES4MRgl4El?=
 =?us-ascii?q?w9xmFWCRoJWlC0GHZtfjxGeBSM3gSErCAIYCCEPgydQGA2OKReNbFUlAzCBB?=
 =?us-ascii?q?gEBjh0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Mar 2020 17:36:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QHaiqe158602;
        Thu, 26 Mar 2020 13:36:44 -0400
Subject: Re: [PATCH v2 2/3] Teach SELinux about anonymous inodes
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com
References: <20200214032635.75434-1-dancol@google.com>
 <20200325230245.184786-3-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3e098729-dc6d-68d0-46a6-7add4fd75b11@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 13:37:36 -0400
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

These should use :anon_inode rather than :file since the class is no 
longer file.

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

You should use isec->sclass == SECCLASS_ANON_INODE instead of 
SECCLASS_FILE here.
