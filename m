Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96A1940AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCZOBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 10:01:51 -0400
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:29294 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgCZOBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:01:50 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 10:01:50 EDT
X-EEMSG-check-017: 93790637|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="93790637"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 13:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585230776; x=1616766776;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=PRC5UfyWl6IQ9UBuNWcLsZqqpUd9T1BiCJFbZ2b2SoE=;
  b=osTE6e8tDFBpk1+AZovXnOout+0P/pqcK96IUpeTktdzyvUtLanmNSGr
   uQxkbqhPkcaOmaL3v6CLZw5TGfVdPknqwx7Tk2jF2LMeQD+ehC9mP2+du
   1vmROI8EObRDdcfSfZKbSpQfD3Li/Fmcxqol7dl9ArG/1eu05MNOT4a6a
   1OGQnYPlCCPSOzDx7Dl70iFo32Ch/fquTpzMj0crWzCzZhwmD0W8PsdIK
   Tz6ZcCVf9gdPxKt1Da4c3efLz4Sv87uUoO6sKRgTdjzV47LK+X1Z+8/5n
   F2hpkPuG6mvDUa+ybb3i3Lh8R8+Kwdej7KASsL4GaiJgHXfuP2v2h/fFa
   A==;
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="41068397"
IronPort-PHdr: =?us-ascii?q?9a23=3AL8nUcxJ7TqnkjlexidmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLfv4rarrMEGX3/hxlliBBdydt6sYzbOL7eu9BCQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6txjdu8kXjIdtKqs8yg?=
 =?us-ascii?q?bCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq1jDHy/ql0X2i6+abEMk9fSz6+v7eLnmo56cN4tshgH/NKQhhNC/DPwlPg?=
 =?us-ascii?q?UBUGWX4+Sx2KD58UHnT7hGkOc6nrTBvJDfP8sbp6q5AwFP0oYk7hayFyym38?=
 =?us-ascii?q?kDnXQcMFJEeA6Ij4juO13UJvD4Fu2wj06jkDds2fDKJqfhDYnVLnjfjLfheq?=
 =?us-ascii?q?5w5FNGxwo10d9f4JZUB6oOIPL0XU/xu9jYAQEjPwOoxObnDc131pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeU5uIuJumMYZIVuCznK/c/5//jlnA5mVgafamm2ZsYdmq0EehhI0?=
 =?us-ascii?q?WceXDsmMsOEX8WvgoiS+znkEaCXiBXZ3azWaI8+z46BZm4DYfMWI+tmqaN3C?=
 =?us-ascii?q?SlEZ1MYGBJFFSMHW3vd4WeVPcGcDiSLdN5kjwYSbihTJcs1RWvtA/81rpmIf?=
 =?us-ascii?q?PY+jYGup3/ydh1/ezTlQ0y9DBtCsSd1HyCT3xwnmwWXDI2wq9/rlJnyluZ0q?=
 =?us-ascii?q?h3neZYFdpN6PNNSAs6MoTcz+NiAdDoRg3BZsuJSEqhQti+BTExT9Qxw8IBYk?=
 =?us-ascii?q?pkFdWilQ3M0DS0A7ALk7yGH4I08q3C0HjrPcp9yGjJ1LMnj1Y4RstDL2qmhr?=
 =?us-ascii?q?Rw9wLLHY7Gj12Zl7q2daQbxCPN8GaDzWyTvEBXSQJwUrvKXWoZZkTIqdT0/V?=
 =?us-ascii?q?3CT7CwBrQ9KAdBytCNKrFMatL3iVVKXvDjOM7RY2ipgWe/GQ6Ixq+QbIrtY2?=
 =?us-ascii?q?gd3zvdCE0fngAN8naJKxI+Cj2io23AFjxuE0zgY0f2/el5snO7QVc+zxuWYE?=
 =?us-ascii?q?15y7q15hkViOSCS/MSxLIEvzwsqjRqE1a73tLWFcCMpw5gfKVafNM8701L1W?=
 =?us-ascii?q?XDtwxyJJCgMqNijEYEcwtrp0Puywl3CoJYnMgytnwq0Q5yJLmA0FxbajOY2Y?=
 =?us-ascii?q?n8OrjQKmn15hCgdbTa1U3Z0NaT4q0P8ug3q03/vAG1EUov63Nn099W03aH6Z?=
 =?us-ascii?q?XKCw0SUZ31Ukkp7RR1u7baYiwl7YPOyXJsKbW0siPF298xAOslzRWgcMlEMK?=
 =?us-ascii?q?OEGw/yEtAVB9K0J+ExlFipaRUEPO9W9KEqJc+pa/yG2KuzNuZ6gD2mlXhH4J?=
 =?us-ascii?q?x60k+U9Sp8T+nI34wfw/GZxQuKTDH8g02kss/pmIBIfzYSHnCwyXusOIkESq?=
 =?us-ascii?q?R0fIsPQUypJ8SszdR5gZOlD3JR8lWkA3sJ38imfRfUZFv4i0kYyUUSpGG9gy?=
 =?us-ascii?q?Kp5zNzlD4to+yU2ymKi//vcBsBJ35jWmZvlxHvLJKygtRcW1KnK0AtlR249Q?=
 =?us-ascii?q?PhyqNGvqVjPizWRktVeyXeMW5vSO2zu6CEbsoJ74kn9W1TUeKhcRWUUbLwvR?=
 =?us-ascii?q?Ye+z3sEnEYxz0hcTyu/JLjkFgyjGObMWY2r3fDf8x07QnQ6caaRvNL2DcCAi?=
 =?us-ascii?q?5ihn2fBUa5F8em8M/SlJrZtO26EWW7WdkbbyjxyquSuS26+ytuABuij7a0gN?=
 =?us-ascii?q?KhDAt+mTfyyt1CTSzVqFP5ZY7x2uKxNucjNk9uB3fz7M11How4mYw1wNkU3n?=
 =?us-ascii?q?sXnZWa/HYdmE/8NtJU3a+4Z30IAXYpytvY+0DA31d5L2nBk4D8UW+Hw9BJYd?=
 =?us-ascii?q?C/b2JQ3TgyuZNkEqCRuYdYkDN1r1zwlgfYZfxwj39J0vc1wGILiOEO/gw2x2?=
 =?us-ascii?q?OSBa5EThoQBjDlixndt4P2l65Qfmv6NOHrhUc=3D?=
X-IPAS-Result: =?us-ascii?q?A2BhBwDYsnxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XssgUEyKoQajn1UBoESJYl6kHYDVAoBAQEBAQEBAQE0AQIEAQGERAKCLyQ4E?=
 =?us-ascii?q?wIQAQEBBQEBAQEBBQMBAWyFYkIWAYFiKQGCfgEBAQECASMEEUYLCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjP4JYBSCseXV/M4NMgX+DWYE+gQ4qAYg1g3kaeYEHgTgMA?=
 =?us-ascii?q?4IpBy4+h1yCXgSXD3GJD49GgkaCVopciVEGHZtfjxGeBiI3gSErCAIYCCEPg?=
 =?us-ascii?q?ydQGA2OKReNbFUlAzCBBgEBikyDUQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Mar 2020 13:52:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QDr2ef044380;
        Thu, 26 Mar 2020 09:53:06 -0400
Subject: Re: [PATCH v2 1/3] Add a new LSM-supporting anonymous inode interface
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com,
        James Morris <jmorris@namei.org>
References: <20200214032635.75434-1-dancol@google.com>
 <20200325230245.184786-2-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <70f7260d-d5b9-4035-c8a6-219c7637f601@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 09:53:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325230245.184786-2-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/25/20 7:02 PM, Daniel Colascione wrote:
> This change adds two new functions, anon_inode_getfile_secure and
> anon_inode_getfd_secure, that create anonymous-node files with
> individual non-S_PRIVATE inodes to which security modules can apply
> policy. Existing callers continue using the original singleton-inode
> kind of anonymous-inode file. We can transition anonymous inode users
> to the new kind of anonymous inode in individual patches for the sake
> of bisection and review.
> 
> The new functions accept an optional context_inode parameter that
> callers can use to provide additional contextual information to
> security modules, e.g., indicating that one anonymous struct file is a
> logical child of another, allowing a security model to propagate
> security information from one to the other.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---

> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 89714308c25b..114a04fc1db4 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,75 +55,135 @@ static struct file_system_type anon_inode_fs_type = {
>   	.kill_sb	= kill_anon_super,
>   };
>   
> -/**
> - * anon_inode_getfile - creates a new file instance by hooking it up to an
> - *                      anonymous inode, and a dentry that describe the "class"
> - *                      of the file
> - *
> - * @name:    [in]    name of the "class" of the new file
> - * @fops:    [in]    file operations for the new file
> - * @priv:    [in]    private data for the new file (will be file's private_data)
> - * @flags:   [in]    flags
> - *
> - * Creates a new file by hooking it on a single inode. This is useful for files
> - * that do not need to have a full-fledged inode in order to operate correctly.
> - * All the files created with anon_inode_getfile() will share a single inode,
> - * hence saving memory and avoiding code duplication for the file/inode/dentry
> - * setup.  Returns the newly created file* or an error pointer.
> - */
> -struct file *anon_inode_getfile(const char *name,
> -				const struct file_operations *fops,
> -				void *priv, int flags)
> +static struct inode *anon_inode_make_secure_inode(
> +	const char *name,
> +	const struct inode *context_inode,
> +	const struct file_operations *fops)
> +{
> +	struct inode *inode;
> +	const struct qstr qname = QSTR_INIT(name, strlen(name));
> +	int error;
> +
> +	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return ERR_PTR(PTR_ERR(inode));

Just return inode here?

> +	inode->i_flags &= ~S_PRIVATE;
> +	error =	security_inode_init_security_anon(
> +		inode, &qname, fops, context_inode);

Would drop fops argument to the security hook until we have an actual 
user of it; one can always add it later.


> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 37df7c9eedb1..07b0f6e03849 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1014,8 +1014,6 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
>   	}
>   }
>   
> -static const struct file_operations userfaultfd_fops;
> -
>   static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
>   				  struct userfaultfd_ctx *new,
>   				  struct uffd_msg *msg)
> @@ -1920,7 +1918,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
>   }
>   #endif
>   
> -static const struct file_operations userfaultfd_fops = {
> +const struct file_operations userfaultfd_fops = {
>   #ifdef CONFIG_PROC_FS
>   	.show_fdinfo	= userfaultfd_show_fdinfo,
>   #endif

These changes can be dropped entirely AFAICT.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..de5d37e388df 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -215,6 +215,10 @@
>    *	Returns 0 if @name and @value have been successfully set,
>    *	-EOPNOTSUPP if no security attribute is needed, or
>    *	-ENOMEM on memory allocation failure.
> + * @inode_init_security_anon:
> + *      Set up a secure anonymous inode.
> + *	Returns 0 on success. Returns -EPERM if	the security module denies
> + *	the creation of this inode.

I'd favor describing the arguments (@name, @context_inode) too.

>    * @inode_create:
>    *	Check permission to create a regular file.
>    *	@dir contains inode structure of the parent of the new file.
> @@ -1552,6 +1556,10 @@ union security_list_options {
>   					const struct qstr *qstr,
>   					const char **name, void **value,
>   					size_t *len);
> +	int (*inode_init_security_anon)(struct inode *inode,
> +					const struct qstr *name,
> +					const struct file_operations *fops,
> +					const struct inode *context_inode);
>   	int (*inode_create)(struct inode *dir, struct dentry *dentry,

Can drop the fops argument.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 64b19f050343..8ea76af0be7a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -320,6 +320,10 @@ void security_inode_free(struct inode *inode);
>   int security_inode_init_security(struct inode *inode, struct inode *dir,
>   				 const struct qstr *qstr,
>   				 initxattrs initxattrs, void *fs_data);
> +int security_inode_init_security_anon(struct inode *inode,
> +				      const struct qstr *name,
> +				      const struct file_operations *fops,
> +				      const struct inode *context_inode);

Ditto

> diff --git a/security/security.c b/security/security.c
> index 565bc9b67276..d06f3969c030 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1033,6 +1033,16 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>   }
>   EXPORT_SYMBOL(security_inode_init_security);
>   
> +int
> +security_inode_init_security_anon(struct inode *inode,
> +				  const struct qstr *name,
> +				  const struct file_operations *fops,
> +				  const struct inode *context_inode)
> +{
> +	return call_int_hook(inode_init_security_anon, 0, inode, name,
> +			     fops, context_inode);
> +}
> +

And again.


