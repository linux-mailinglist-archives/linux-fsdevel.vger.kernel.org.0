Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D590A3919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfH3OWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 10:22:31 -0400
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:61526 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfH3OWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:22:31 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 10:22:30 EDT
X-EEMSG-check-017: 4455285|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="4455285"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Aug 2019 14:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567174520; x=1598710520;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2y2fUDM7cbfNU8lcFaLDLldBnPyW28Yb9g9Vbhe8SWs=;
  b=G+QXhT1N5CLoISe6uKxs5ClefeWJePzPYQWqlSiDWTtvf8QwRYnN4MK+
   5lHAhPDyqWqkL6oxZKLt155och37Pk8+oKj8RBK/mbJLXN5QedQa2wIOW
   eyw5GHXHHJPMyaybdceKRjIhjwo768rgsCmOeFREq2AigZF92yi/TgjBR
   Ur6L28RZlAN++1vdfOMdOX3t7xOEKpYkZ/bu0hCjeixW0UZCarZFfvK81
   Vxgh3+Aen0KDSZqvCnvUrAretrb21IEAJzs3FPOO0d6J0WV36X19khfUX
   u4zLtVwvylpbctKBv3BYUAU/2M8N5B2+0m89v6LvriUmGz5IAmXwElnVs
   A==;
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="27378122"
IronPort-PHdr: =?us-ascii?q?9a23=3AmwofKB/GvICCDv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1eIRIJqq85mqBkHD//Il1AaPAdyBrasa16GJ6OjJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVmjaxe65+IRS5oAnetMQbj5ZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumarHK58u3r4wlp?=
 =?us-ascii?q?0JvUTFAiD2g1n5gLWTdkUl/uik8+XnYrP4qZ+AL4J4lw7zP6s0lsG/HOg0KB?=
 =?us-ascii?q?YCUmeF9eimybHv5Uj5T69Ljv0ynKnZqpfaJcEDq66iHgBVyZ0u6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFReeB2dlYTpNFbOIO7gAfeln1usiCtrx+zBPrD5H5rNLn/Dkbn/cr?=
 =?us-ascii?q?Z5705c0xE+zcpB6J1JCrEOOu7zVlXtu9zfCx8zKxa0zPr/CNVhyoMeXnqCAr?=
 =?us-ascii?q?GYMKPItl+F/eMuLPeKZI8UpjbxMfwl5//ojX8kll4RZ66p3YEYaHyiA/RmIF?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfT2h1KYSj5ceXazUrkn5j4nCIKpF5rDRo6pgLOfxi?=
 =?us-ascii?q?e3B4FZaXpcBl+QFnfocp2OW+0QZyKKPs9hjjsEWKCuS487yx6uuwz6y7p8I+?=
 =?us-ascii?q?rQ+y0Ys4/j1dd75+3UiBEy8yF7AN6B02GMSGF0mHkERzgs3KBwuUZ90EuM0b?=
 =?us-ascii?q?Bkg/xEEtxe//VJUgYmOp7by+x1EcvyVhjccdeIVFmmQsmmDi81Tt8qwtIPbU?=
 =?us-ascii?q?d9G9O/gRzZwyWqBLoVnaSRBJMo6qLcw2TxJ8FlxnbczqYhkUcpQs1UOG26hq?=
 =?us-ascii?q?5w6Q3TCJTHkkmDkaala7gc1jbX9Gif1WqOoF1YUAloXKrZXXAffErWrc/l5k?=
 =?us-ascii?q?PDVbCuD68qPRBbycGYN6tKbMPmjU9cSPfiP9TUe3ixlHuoBRaU2rOMa5Lne2?=
 =?us-ascii?q?YD0yTdEkgEkgYT/XmdNQUlGCehrHzRDCZ0GVLsfUzs6+9+p22/TkMuyAGKdU?=
 =?us-ascii?q?Jh3aKv+hEJnfycV+8T3rUctSclqjV0Gku93t3PB9qdvApuZ75RYc0y4FhZz2?=
 =?us-ascii?q?LVrQ99MYK6L6BkmFEedx57v0T01xV4Eo9Ai9QlrGs2zApuLqKVyFdBdzKe3Z?=
 =?us-ascii?q?DtNbzbM3Ly8w6zZK7LwFHe0cqW+6cW5PQ9rFXsoRypFk48/Hh8zdlV3GWT5o?=
 =?us-ascii?q?/QAAoRT53xSEA3+AZ+p73AZSk9/YzU32V2Maaoqj/Cx84pBOw9xxakftdfNr?=
 =?us-ascii?q?6EFQDrH80UHMihNfIlm0a3YRIAJ+1S6qE0MN28d/ec266kIvxgnDS4gmRD+o?=
 =?us-ascii?q?x91ViM9yVkQO7Sw5kF2+2Y3heAVzrkiFehs8b3mZ1LZD0LBGW/0SnkCZVPZq?=
 =?us-ascii?q?19Y4kLE32iI86pydVkgZ7iRXpY+ESkB1Mc18+jYQCSYEDl3Q1MyUQXpmSqmS?=
 =?us-ascii?q?+5zzxyjjEoobOT0zfKw+TlaBUHOXVGRHdtjVjyO4i4ldMaU1aybwgvihSl4V?=
 =?us-ascii?q?z2x69BpKRwN2PTW1tHfzDqL2F+Vau9rr6CY89J6JM1viRbSee8bk6ASr77vR?=
 =?us-ascii?q?Qa1zjuH3VRxD8lbTGmoJb5kAJgiGKbMnlzqGDVecZqxRfQt5TgQqt91yQHSG?=
 =?us-ascii?q?FYjibaAlynd42l/dKLmpPHqcikWm6hX4EVei7um8fIqiqh4kV4DBu+gba3m9?=
 =?us-ascii?q?v6AU49yyC9yto5ez/PqUPHfoTz16m8edlid01sCU60v9F2Aalig4Awg9cWwn?=
 =?us-ascii?q?FciZKLqylU2VzvOMlWjPqtJEEGQiQGlpuMu1no?=
X-IPAS-Result: =?us-ascii?q?A2BwBwAiL2ld/wHyM5BmHQEBBQEHBQGBZ4FuKoFAMiqEI?=
 =?us-ascii?q?Y8LTwEBAQEGgREliW+RJgkBAQEBAQEBAQE0AQIBAYQ/AoJgIzgTAgsBAQEEA?=
 =?us-ascii?q?QEBAQEGAwEBbIU6gjopAYJnAQUjBBFBEAsOCgICJgICVwYBDAYCAQGCXz+Bd?=
 =?us-ascii?q?xSsWH8zhUqDP4FJgQwoi3gYeIEHgREnDIJfPodPglgElUKWTYIpgieJUYhZB?=
 =?us-ascii?q?huYYi2NRZpTIYFYKwgCGAghD4Mngk4Xjj4jAzCBBgEBjWsBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Aug 2019 14:15:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7UEFGBx009557;
        Fri, 30 Aug 2019 10:15:16 -0400
Subject: Re: [PATCH 10/11] selinux: Implement the watch_key security hook [ver
 #7]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717352079.2204.16378075382991665807.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <21eb33e8-5624-0124-8690-bbea41a1b589@tycho.nsa.gov>
Date:   Fri, 30 Aug 2019 10:15:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156717352079.2204.16378075382991665807.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/19 9:58 AM, David Howells wrote:
> Implement the watch_key security hook to make sure that a key grants the
> caller View permission in order to set a watch on a key.
> 
> For the moment, the watch_devices security hook is left unimplemented as
> it's not obvious what the object should be since the queue is global and
> didn't previously exist.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>   security/selinux/hooks.c |   14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 74dd46de01b6..a63249ad98ab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6533,6 +6533,17 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>   	*_buffer = context;
>   	return rc;
>   }
> +
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +static int selinux_watch_key(struct key *key)
> +{
> +	struct key_security_struct *ksec = key->security;
> +	u32 sid = cred_sid(current_cred());

How does this differ from current_sid()?

And has current_sid() not been converted to use selinux_cred()? Looks 
like selinux_kernfs_init_security() also uses current_security() directly.

> +
> +	return avc_has_perm(&selinux_state,
> +			    sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
> +}
> +#endif
>   #endif
>   
>   #ifdef CONFIG_SECURITY_INFINIBAND
> @@ -6965,6 +6976,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(key_free, selinux_key_free),
>   	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +	LSM_HOOK_INIT(watch_key, selinux_watch_key),
> +#endif
>   #endif
>   
>   #ifdef CONFIG_AUDIT
> 

