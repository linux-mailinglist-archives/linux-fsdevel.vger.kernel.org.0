Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDD62888
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfGHSqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:46:24 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:16622 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfGHSqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:46:23 -0400
X-EEMSG-check-017: 727914215|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,466,1557187200"; 
   d="scan'208";a="727914215"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jul 2019 18:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562611574; x=1594147574;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=96bFs/j1tykk6zv5kGzC/jOaR4nIBLQvQjY7eMB6i98=;
  b=TZeJ/D+iOsuw2AKT+JZh1qG24a6J00O8/aa3OVdtyERt4kloYlHjt3ck
   QsW4EzBP7OX8EkyUc8+k4u6EL/bB2uIQzyoCcSnQb6IjtWlTOJ4GL+uid
   Nzy5upxY8kI09OK+cg3Pckwcx+Or5a3eFOMTtTmBngHVoq1ndFSEpWBok
   p077R0fz0wwiUBTFmCGtYyJacVwoNhQHQrnaAVaHAmGuHnePar1avo/yX
   lVSOoGak1GC5vWIWHEc7h1MMCdJ7e0FHx4FxyXLmt5eYyL/JpxOeOpOpw
   DGDMItr2QnzFnnJ3iPJqBUPEww4sPrrYxsbdXaGoX1jjbqqryZtz90A1/
   A==;
X-IronPort-AV: E=Sophos;i="5.63,466,1557187200"; 
   d="scan'208";a="25479746"
IronPort-PHdr: =?us-ascii?q?9a23=3AxTpC6hZFQvYoCGUV/hVeLov/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsqyYx7h7PlgxGXEQZ/co6odzbaP6ea8ASdZu8bJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/eu8UKjoduN7g9xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBeyGw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwip?=
 =?us-ascii?q?oSvljDHi/xgkn2irOZdl449eSy7uTnY7HmqoedN49ylA7+LrwjltGwDOk3KA?=
 =?us-ascii?q?QDX3WX9f6i2LDs40H1WqhGguUzkqbDsZDaIcobprS+Aw9Qyosj8AuwDyy93d?=
 =?us-ascii?q?QEnXgIMFJFeBWdg4jvIFHBOur0Dfi4g1SyiDtr3ezJPqX9ApXRKXjOiKrufb?=
 =?us-ascii?q?Z6609S1gUzydRf54lPB7EbPv38R0/xu8bEDhMjLwO0xOPnAs1n1owCQWKPHr?=
 =?us-ascii?q?OZMKTKvF+W5+IvOe6MaZQUuTnjLfgl5uDugWU9mV8ce6mpwJQWZGq/HvR8LE?=
 =?us-ascii?q?WVe2fsgtQZG2cQogU+VPDqiEGFUTNLe3m9Rbk86S87CY+9FofMWoCtj6ac3C?=
 =?us-ascii?q?e1Gp1ZeHpGBkmQHnjybYmLR/AMaCeKKM97jjMETaShS5Mm1Ry2uw/60aRoLu?=
 =?us-ascii?q?XX+i0Yrp/j0Nl15+vOlRA9+zx0CNmd02eQQG5ugmMIRjg23KZlrUx60FeD3r?=
 =?us-ascii?q?Byg+ZEGtxL+/NJTgA6OIbaz+x7F9/yXQbBcc2SSFq8X9qmAC0+TtItw9AQZ0?=
 =?us-ascii?q?ZwANSvjx7C3yqsHrAZjaCEBJsx8qjExXj+O959y2ra1Kkml1QmWNFANXO4ia?=
 =?us-ascii?q?557AXTG47JnFucl6mwe6UQxijN+3mfzWCWpkFXTBZwUbnZXXAYfkbZsdT55l?=
 =?us-ascii?q?nDT7+1FbQnMxFOyciZJ6RRcN3ml0hGRPH9N9TEeW6xmmCwDw6SxryQdIrqZ3?=
 =?us-ascii?q?kd3CLFBUgHjQ8S/WyGNQk4BieuuGLTFyJuFV3xbEP26+V+q220TlUyzw6Ua0?=
 =?us-ascii?q?1tzb21+gQahfaEUfMcwqoEuDs9qzVzBFu929PWC9ydpwtuZalcfMg970xc2G?=
 =?us-ascii?q?LHuAxyIIagI7phhlEAaQR3uV3h1xFtBoVHi8gqo2sgzBBuJqKAzFNBazSY0I?=
 =?us-ascii?q?j0Or3WLGny4R+uZ7fN2l7AzNmW570P6PUkq1TjpQ2pE00i/Gh609lRzXSR/Y?=
 =?us-ascii?q?vKDAUMXpLrSEo39AZ1p6vcYiYj44PYz3psMbO7sjXawdImGPMlygq8f9dYKK?=
 =?us-ascii?q?6EEA7yE8sHB8mhMeAqlUOpYQ8aM+BM6qE0O9ird+WJ2KG1JuZshjGmgnpd4I?=
 =?us-ascii?q?B7zE2M8zBwSunS35YK2/uYxBeIVy/gjFe9tcD6gYREZTAUHmqixinoHZReZr?=
 =?us-ascii?q?VzfYsQF2euLNO4xs9ki57uRXFY7lijCE0C2MOzfhqSdVP91xVK1UsLuXynhT?=
 =?us-ascii?q?e4zztsnjEtr6qf2jHOwuv7eBUcPm5LQ3VtjVT3LIiqgNAVQlKoYxIqlBS7/0?=
 =?us-ascii?q?b6wbZUpKBlI2nUW0dIcDD8L3t+XauoqrqCf8lP5YsssSVWVuS8fF+bRqf+ox?=
 =?us-ascii?q?QEySPjGXVRxDQgejG0tZX2gQZ6hHieLHlttnrZf99/xRPF6NzbX/5R0WlOeC?=
 =?us-ascii?q?4tpTDJB1T0H9628NGQjN+XvuC5SG+lUoZ7ayTnzYqc8iC84DsuSQO+hfebiN?=
 =?us-ascii?q?DhEBZ81S79ysksUj/H6gv/Mafx0KHvCv5qZkllAhfH7sN+Hoxv2t8riIo4xW?=
 =?us-ascii?q?kRhpLT+2EO12j0L4MIiurFcHMRSGtTkJbu6w//1RgmdyjYyg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CZAABnjiNd/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WcFKoFuKIQckzIGgQktiVuRFAkBAQEBAQEBAQE0AQIBAYRAAoI4IzcGDgEDA?=
 =?us-ascii?q?QEBBAEBAQEEAQFsikOCOikBgmcBBSMVQRALDgoCAiYCAlcGAQwGAgEBglMMP?=
 =?us-ascii?q?4F3FKo6gTKFR4MlgUeBDCgBh22DcRd4gQeBOII9Lj6HToJYBJRmlWwJghmCH?=
 =?us-ascii?q?5FfBhuXfo0wmUsigVgrCAIYCCEPgyeCTReOPSMDMAx6AQGNaQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jul 2019 18:46:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x68IkB5p017610;
        Mon, 8 Jul 2019 14:46:11 -0400
Subject: Re: [PATCH 2/9] security: Add hooks to rule on setting a watch [ver
 #5]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173692760.15137.9636883182556029747.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cd657aab-e11c-c0b1-2e36-dd796ca75b75@tycho.nsa.gov>
Date:   Mon, 8 Jul 2019 14:46:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156173692760.15137.9636883182556029747.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/19 11:48 AM, David Howells wrote:
> Add security hooks that will allow an LSM to rule on whether or not a watch
> may be set.  More than one hook is required as the watches watch different
> types of object.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org
> ---
> 
>   include/linux/lsm_hooks.h |   22 ++++++++++++++++++++++
>   include/linux/security.h  |   15 +++++++++++++++
>   security/security.c       |   13 +++++++++++++
>   3 files changed, 50 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 47f58cfb6a19..f9d31f6445e4 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1413,6 +1413,20 @@
>    *	@ctx is a pointer in which to place the allocated security context.
>    *	@ctxlen points to the place to put the length of @ctx.
>    *
> + * Security hooks for the general notification queue:
> + *
> + * @watch_key:
> + *	Check to see if a process is allowed to watch for event notifications
> + *	from a key or keyring.
> + *	@watch: The watch object
> + *	@key: The key to watch.
> + *
> + * @watch_devices:
> + *	Check to see if a process is allowed to watch for event notifications
> + *	from devices (as a global set).
> + *	@watch: The watch object

It is difficult to evaluate these without at least one implementation of 
each hook.  I am unclear as to how any security module would use the 
watch argument, since it has no security field/blob and does not appear 
to contain any information that would be relevant to deciding whether or 
not to permit the watch to be set.

> + *
> + *
>    * Security hooks for using the eBPF maps and programs functionalities through
>    * eBPF syscalls.
>    *
> @@ -1688,6 +1702,10 @@ union security_list_options {
>   	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
>   	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
>   	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
> +#ifdef CONFIG_WATCH_QUEUE
> +	int (*watch_key)(struct watch *watch, struct key *key);
> +	int (*watch_devices)(struct watch *watch);
> +#endif /* CONFIG_WATCH_QUEUE */
>   
>   #ifdef CONFIG_SECURITY_NETWORK
>   	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
> @@ -1964,6 +1982,10 @@ struct security_hook_heads {
>   	struct hlist_head inode_notifysecctx;
>   	struct hlist_head inode_setsecctx;
>   	struct hlist_head inode_getsecctx;
> +#ifdef CONFIG_WATCH_QUEUE
> +	struct hlist_head watch_key;
> +	struct hlist_head watch_devices;
> +#endif /* CONFIG_WATCH_QUEUE */
>   #ifdef CONFIG_SECURITY_NETWORK
>   	struct hlist_head unix_stream_connect;
>   	struct hlist_head unix_may_send;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..540863678355 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -57,6 +57,7 @@ struct mm_struct;
>   struct fs_context;
>   struct fs_parameter;
>   enum fs_value_type;
> +struct watch;
>   
>   /* Default (no) options for the capable function */
>   #define CAP_OPT_NONE 0x0
> @@ -392,6 +393,10 @@ void security_inode_invalidate_secctx(struct inode *inode);
>   int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>   int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>   int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +#ifdef CONFIG_WATCH_QUEUE
> +int security_watch_key(struct watch *watch, struct key *key);
> +int security_watch_devices(struct watch *watch);
> +#endif /* CONFIG_WATCH_QUEUE */
>   #else /* CONFIG_SECURITY */
>   
>   static inline int call_lsm_notifier(enum lsm_event event, void *data)
> @@ -1204,6 +1209,16 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>   {
>   	return -EOPNOTSUPP;
>   }
> +#ifdef CONFIG_WATCH_QUEUE
> +static inline int security_watch_key(struct watch *watch, struct key *key)
> +{
> +	return 0;
> +}
> +static inline int security_watch_devices(struct watch *watch)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_WATCH_QUEUE */
>   #endif	/* CONFIG_SECURITY */
>   
>   #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/security.c b/security/security.c
> index 613a5c00e602..2c9919226ad1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1917,6 +1917,19 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>   }
>   EXPORT_SYMBOL(security_inode_getsecctx);
>   
> +#ifdef CONFIG_WATCH_QUEUE
> +int security_watch_key(struct watch *watch, struct key *key)
> +{
> +	return call_int_hook(watch_key, 0, watch, key);
> +}
> +
> +int security_watch_devices(struct watch *watch)
> +{
> +	return call_int_hook(watch_devices, 0, watch);
> +}
> +
> +#endif /* CONFIG_WATCH_QUEUE */
> +
>   #ifdef CONFIG_SECURITY_NETWORK
>   
>   int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
> 

