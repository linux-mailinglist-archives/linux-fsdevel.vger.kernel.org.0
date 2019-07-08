Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E706293B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 21:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfGHTXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 15:23:22 -0400
Received: from usfb19pa14.eemsg.mail.mil ([214.24.26.85]:59574 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbfGHTXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:23:22 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 15:23:20 EDT
X-EEMSG-check-017: 169672779|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jul 2019 19:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562613193; x=1594149193;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jMwXkOh8bQ3MYhVQUKB4xWadNR5mWRfssUJmM3hjGqk=;
  b=HTwtq3akPTxaMhAnhtThBUM3QKbMzQspdQQT1Lci92DBfYp2gSZ3KTYI
   xjPyhHApFISwecnpL39TbE+2mmpDrhm1K0q/DWWMtIsER7AXWcOIwXniE
   S4MxdwSLB4jah2PKxQjPVNVzoyPB+Voeh3aU/UlN+vfFPEIJZn8Kgd7td
   Oh43dgAK+Xf677ap/hN60Bd6a/BMaDuBiI0BxhpChbpyw22a3H1CIUibC
   ywONoYoovvCKbXG1kAH/lt3YOr8f1AE1VqpMaHyhNelYFuF/XgIytBab0
   DQXZDTjisczmlrxkEbQdnHbaUt0jN4nxOraPFtjRj0s+OjdNUUad8IsmE
   A==;
X-IronPort-AV: E=Sophos;i="5.63,466,1557187200"; 
   d="scan'208";a="25481373"
IronPort-PHdr: =?us-ascii?q?9a23=3A6V8Rxxd4zLmBugHFRVvTyIaalGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc28bBON2/xhgRfzUJnB7Loc0qyK6vqmBTRLuM3f+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLucQanYRuJrs/xx?=
 =?us-ascii?q?bIv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCReoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lo?=
 =?us-ascii?q?YTsEvfHi/2n1/6jKmKeUU/5uek8eHnYrTippOENo90jB/xMrg2l8CiDuk1PR?=
 =?us-ascii?q?ICUmiG9eimyrHu8lP1TK9XgvEul6nWqpHaJcAVpq6jBA9V154u6w2iADe9y9?=
 =?us-ascii?q?kYgXkGI05FeBKAlYTpPUrOL+riAfewhFSsji9nx+raMb35HpXNMn/Dna/8cr?=
 =?us-ascii?q?Z97E5dxhQ8zdRb55JPEbwBOuz8VVLxtNPCEh81KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI+OMvI/OLZIIOuTfyNf4l5//wjXMjnV8dfK+p3YYYaXyiGfRmOU?=
 =?us-ascii?q?qZbWDxgtcCCW0KpBYxTPT2iF2eVj5ef2q9ULgn5j4lCIOrFpzDSZytgLObwS?=
 =?us-ascii?q?e7EJlWaX5cClyVDXjnbZ+IVOsLaCKXOsVhiCALVaC9S4890hGjrAD6y6B5Ie?=
 =?us-ascii?q?rb+S0YtYnu1Nx05+3ViBEz+jJ0D8OA02GLUm57hH8IRz4x3KB5u0B9zU2D0a?=
 =?us-ascii?q?dgifxCCdNT/+9JUhs9NZPEyex6Csz9WgXFftiTU1aqWMipATAtQdIx398BfU?=
 =?us-ascii?q?J9Fs6jgxHN3iqqBaIam6aXC5wz96LWx2LxKNply3bayKkhiEErQtFVOm24mK?=
 =?us-ascii?q?F/8RPeB5LJk0qHkqalb6od0DTL9Gid0WqEpFtYXxJoUaXZQXAfYVPbosj55k?=
 =?us-ascii?q?PYTr+uEqgnMgpbxs6EMaZFccfpgk9bRPflJtveeXi9m2a3BRyQ3LODcJLqe3?=
 =?us-ascii?q?kB3CXaEEUEkB4c/HacNQg/ACehrHneASdwFVLgfUzs6/NyqHClQU8uyQGFcU?=
 =?us-ascii?q?lh26Cy+h4PivyWU+kT0a4cuCc9tzV0G06w39bXC9qGugpgc7xQYc4m4Fhczm?=
 =?us-ascii?q?/ZqQN9MYK6L6x4hV4RbR53v0Xw2BVzEIlAltIqrHwyxgpoNa2YyE9Bdy+f3Z?=
 =?us-ascii?q?3oPr3XK2/y/A2gaqLPwVHRzsqZ+roV6PQ5t1XivBilFk8l83p6ztlV12WT64?=
 =?us-ascii?q?7UDAodT53xSFw79xtkqLHAZCky+YfU2WdrMamuvT/Iw8gpC/c9yha8Y9dfN7?=
 =?us-ascii?q?uJFAvzE80cGsivJ/Umm1aybh0ZIu9S6rA7P8e9evuY166kIvxgkCiljWtZ+o?=
 =?us-ascii?q?B91FyD9y5mRu7PxZYFzOmS3hGbWDfkkFehrsf3lJhAZTETGGq/1CflCJdLaa?=
 =?us-ascii?q?1qfIYGEnmuI8KpydVknZLtWGBX9ESlB1wY3M+lYx2Sb0by3QdIz0QYvWSnmT?=
 =?us-ascii?q?ekzzxzizwpqquf3CrTw+XtbRYIIWpLRG5+glfvOoW0kd8aU1aybwQzlxuq+1?=
 =?us-ascii?q?z6x65Fq6R7NWXTRl1IfyfuJWF4TqSwrqaCY9JI6J4wtSVXUeK8YU2VS7LkoB?=
 =?us-ascii?q?sVzTnjH21AyzA/bDyqpJr5kAJgiG6HL3Z8smDZecduyhfb/tDcQuRR3jVVDB?=
 =?us-ascii?q?V/3BXeGFmwd/mu4tiQk4yL5uy+UH2sUplIWTPmwYOJqG2w4mg8RVWhnuq0ss?=
 =?us-ascii?q?/qFwkklyv60cR6EyLSo1DhYdrFzaO/ZNl7c1FoCVm00M9zHoVzg8Nkn50L8W?=
 =?us-ascii?q?QLjZWSu3wcmCH8NssNivG2V2YEWTNem42d2wPiwkA2ayvTlo8=3D?=
X-IPAS-Result: =?us-ascii?q?A2CZAACAlCNd/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WwqgW4ohByTMwaBCS2JW5EUCQEBAQEBAQEBATQBAgEBhEACgjgjNwYOAQMBA?=
 =?us-ascii?q?QEEAQEBAQQBAWyKQ4I6KQGCZgEBAQECASMVPwIQCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJTDD+BdwUPqkKBMoVHgyWBR4EMKAGLXhd4gQeBOII9Lj6HToJYBJRmlWwJg?=
 =?us-ascii?q?hmCH5FfBhuXfo0wmUsigVgrCAIYCCEPgyeCTRcUjikjAzAMegEBjWkBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jul 2019 19:13:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x68JD9A2024309;
        Mon, 8 Jul 2019 15:13:09 -0400
Subject: Re: [PATCH 3/9] security: Add a hook for the point of notification
 insertion [ver #5]
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
 <156173694190.15137.8939274212328721351.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <541e5cb3-142b-fe87-dff6-260b46d34f2d@tycho.nsa.gov>
Date:   Mon, 8 Jul 2019 15:13:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156173694190.15137.8939274212328721351.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/19 11:49 AM, David Howells wrote:
> Add a security hook that allows an LSM to rule on whether a notification
> message is allowed to be inserted into a particular watch queue.
> 
> The hook is given the following information:
> 
>   (1) The credentials of the triggerer (which may be init_cred for a system
>       notification, eg. a hardware error).
> 
>   (2) The credentials of the whoever set the watch.
> 
>   (3) The notification message.

As with the other proposed hooks, it is difficult to evaluate this hook 
without at least one implementation of the hook.  Since Casey is the 
only one requesting this hook, a Smack implementation would be the 
natural choice; I do not intend to implement this hook for SELinux. 
However, by providing this hook, you are in effect taking a position wrt 
the earlier controversy over it, i.e. that application developers must 
deal with the possibility that notifications can be dropped if a 
security module does not permit the triggerer to post the notification 
to the watcher, without any indication to either the triggerer or the 
watcher.  This is a choice you are making by providing this hook.  The 
alternative is to require that permission to set a watch imply the 
ability to receive all notifications for the watched object.  Aside from 
friendliness to application developers, the latter also yields stable, 
sane policy and better performance.

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org
> ---
> 
>   include/linux/lsm_hooks.h |   10 ++++++++++
>   include/linux/security.h  |   10 ++++++++++
>   security/security.c       |    6 ++++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f9d31f6445e4..fd4b2b14e7d0 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1426,6 +1426,12 @@
>    *	from devices (as a global set).
>    *	@watch: The watch object
>    *
> + * @post_notification:
> + *	Check to see if a watch notification can be posted to a particular
> + *	queue.
> + *	@w_cred: The credentials of the whoever set the watch.
> + *	@cred: The event-triggerer's credentials
> + *	@n: The notification being posted
>    *
>    * Security hooks for using the eBPF maps and programs functionalities through
>    * eBPF syscalls.
> @@ -1705,6 +1711,9 @@ union security_list_options {
>   #ifdef CONFIG_WATCH_QUEUE
>   	int (*watch_key)(struct watch *watch, struct key *key);
>   	int (*watch_devices)(struct watch *watch);
> +	int (*post_notification)(const struct cred *w_cred,
> +				 const struct cred *cred,
> +				 struct watch_notification *n);
>   #endif /* CONFIG_WATCH_QUEUE */
>   
>   #ifdef CONFIG_SECURITY_NETWORK
> @@ -1985,6 +1994,7 @@ struct security_hook_heads {
>   #ifdef CONFIG_WATCH_QUEUE
>   	struct hlist_head watch_key;
>   	struct hlist_head watch_devices;
> +	struct hlist_head post_notification;
>   #endif /* CONFIG_WATCH_QUEUE */
>   #ifdef CONFIG_SECURITY_NETWORK
>   	struct hlist_head unix_stream_connect;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 540863678355..5c074bf18bea 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -58,6 +58,7 @@ struct fs_context;
>   struct fs_parameter;
>   enum fs_value_type;
>   struct watch;
> +struct watch_notification;
>   
>   /* Default (no) options for the capable function */
>   #define CAP_OPT_NONE 0x0
> @@ -396,6 +397,9 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>   #ifdef CONFIG_WATCH_QUEUE
>   int security_watch_key(struct watch *watch, struct key *key);
>   int security_watch_devices(struct watch *watch);
> +int security_post_notification(const struct cred *w_cred,
> +			       const struct cred *cred,
> +			       struct watch_notification *n);
>   #endif /* CONFIG_WATCH_QUEUE */
>   #else /* CONFIG_SECURITY */
>   
> @@ -1218,6 +1222,12 @@ static inline int security_watch_devices(struct watch *watch)
>   {
>   	return 0;
>   }
> +static inline int security_post_notification(const struct cred *w_cred,
> +					     const struct cred *cred,
> +					     struct watch_notification *n)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_WATCH_QUEUE */
>   #endif	/* CONFIG_SECURITY */
>   
> diff --git a/security/security.c b/security/security.c
> index 2c9919226ad1..459e87d55ac9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1928,6 +1928,12 @@ int security_watch_devices(struct watch *watch)
>   	return call_int_hook(watch_devices, 0, watch);
>   }
>   
> +int security_post_notification(const struct cred *w_cred,
> +			       const struct cred *cred,
> +			       struct watch_notification *n)
> +{
> +	return call_int_hook(post_notification, 0, w_cred, cred, n);
> +}
>   #endif /* CONFIG_WATCH_QUEUE */
>   
>   #ifdef CONFIG_SECURITY_NETWORK
> 

