Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388AF1946E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 19:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgCZS7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 14:59:22 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:35101 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZS7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:59:21 -0400
X-EEMSG-check-017: 89972741|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="89972741"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 18:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585249142; x=1616785142;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=qjWe73fUO1P3gDxEnQaP/rsr4TUjg4noRpCSQYDVYj4=;
  b=fh07z+yEZuTX8hmHlp6yG+5F18N9aMa+iYnzBexOzigTP6A6xxV/p6k5
   KxDoxRrc5ej5JhQZqT2p3VGHJd8+EBeQod4IMc1CcaMlvaBACKsNtgu/o
   /telDPGZ9nuKhQ4CDja+K92tMmkOreKBLCSZcXq/EFDHzr4Zxk6Sf0ysl
   H1AxPAXRMuXIp+CHZKDlaTcoDlj+Yya/F4MdFKo1tbmFa7lXBVDvzddnZ
   ii41mo0VlK7r53+cmwd7s7Hzqik7xAu55BN0eq5RcVTUeFDqdZXRhkFMV
   qzmU6dMWjq60YqUtVnVXuE3xXZM1Q0yuy/kqRuCMYv4WUfil89/21VlBy
   Q==;
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="34650212"
IronPort-PHdr: =?us-ascii?q?9a23=3A+vu0FxPof3AcsOPt1LYl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/v+r8bcNUDSrc9gkEXOFd2Cra4d16yP7v+rBDBIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/MusQWg4ZuJaY8xx?=
 =?us-ascii?q?TUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7fHi72hEr2jKiWel8i+ue08OTofq/qppqdN49wkg3+M6IuldKjAekgLw?=
 =?us-ascii?q?QDUGeW9f682bH+50H1XrpHguMsnqXEqJzaIN4Upq+9Aw9byIYj7BO/Ai+90N?=
 =?us-ascii?q?sFhnkKN05FeRKbgIjpPFHCOvb4DeyljFi2nzdrwO7GMqX7AprRNnjDjKvhfb?=
 =?us-ascii?q?Fl5kFB0gUzy8xQ55VQCrwaL/LzXUjxtNPcDhAnKQC73+HnCNBl3IMERW2PGr?=
 =?us-ascii?q?OZML/VsVKQ+uIvIuyMZIoIuDbnMfgq/f7vgGQ2mV8aeqmp0p8XZ26iEvt6JE?=
 =?us-ascii?q?WZZGLmgs0dHmcSogo+UOvqhUWZUTFNY3ayXqQ85iw0CY+9E4fDSZ6igKab0C?=
 =?us-ascii?q?e4AJJWfGZGBU6IEXvycIWEQfgMYjqIIsB9ijwESaShS4g52BGqtQ/6zadnL+?=
 =?us-ascii?q?XN9i0Dq53syMV15/fSlREu9T14FsGd02aQQGFpmmMHWSQ73L5woUNj0FePy6?=
 =?us-ascii?q?t4jOJCFdxV+fxJVh02NZnGz+x1E9ryQB7Ofs+VSFa6RdWrGTUxTtM3w98TbE?=
 =?us-ascii?q?dxAtuijgve0CW0Hb8aibiLCYcq8qLTwXfxPdxxy3XY26k7iVkpXM9POXehhq?=
 =?us-ascii?q?5l+AjZH5TJnFmBl6a2aaQc2zbA9GOCzWqIoUFZXxd8UabbUnAFYEvZs9D561?=
 =?us-ascii?q?jcT7+hF7snKBFNyc2cJatQbN3mk1FGSO3kONTEbGK7g32wCgqQxrOQcIrqfH?=
 =?us-ascii?q?0Q3CbDCEgBiA0T43mGOhYkBiu7oGLREiZuFVTxbEPo6+V+r2m7TkAsxQGQc0?=
 =?us-ascii?q?Jhz6a1+gIShfGEVfMT36gEuCA6pjR1Alm92dPWC8SaqwplfaVcZ8494Vhd2W?=
 =?us-ascii?q?LerQx9MYasL71hhlQGaQR4o1vu1wlrCoVHicUqtGklzBd2Ka+DyFNObS6Y3Z?=
 =?us-ascii?q?TpNr3SLWny+wqvZLDM1l7C19aW/78F6O4kpFX7oAGpCk0i/m1h09lT0HuR/Z?=
 =?us-ascii?q?rKDA0VUZL+VkY46QJ2qK3dYik4/4nUz2FjMbGosj/e3NIkHO8lyhGjf9hBK6?=
 =?us-ascii?q?OEFADyE8wHCMi0MuMngFepbhUDPOBd8K47IdmqeOeB2K6uJOxghi6pjXxb4I?=
 =?us-ascii?q?Bh1UKB7yh8SuvP35Yf2fGY3xCHWiz6jFi7t8D4h4FEaSsVHmqlxii3TLJWM4?=
 =?us-ascii?q?F7e4cGDS+FJMm+3d5/gJjgEypU/VioAFcu18iudh6fKVf62FsUnVgWpHm6gz?=
 =?us-ascii?q?Gx3hR7lDYmqqfZ1yvLh6z5eR4GPHNbbHdtgE2qIoWuid0eGk+yYExhkBqj+F?=
 =?us-ascii?q?a/3KVQub5+M3iWREBEYiz7B39tX7H2tbeYZcNLrpQyvmEfVOW6fEDfRKXxrg?=
 =?us-ascii?q?UX1wv9EGZEgjM2bTenvtP+hRM+wGacKmtj6XnUY8d9wT/B69HGA/1cxDwLQG?=
 =?us-ascii?q?9/kzaTTluiOvG38tiO0ZTOqOazUySmTJIXOTfq14Sopia95HMsBRy5guD1nc?=
 =?us-ascii?q?foVxU5lWfj3sRufT3BsRK5Z47szan8OuViOgFuAlzU5M19FYVz1IA3gdVY3X?=
 =?us-ascii?q?8Zi46V8nsLi27bPtJc1qbzKnEKQHpDwdvS+hLkw2VlJ3eExsT+THrO7NFmYo?=
 =?us-ascii?q?yBfm4O2i87p/tPAaOQ4a0MyTB5uXKkvAnRZr57hT5bxvwwvi1Jy9oVsRYgm3?=
 =?us-ascii?q?3OSosZGlNVaGm1zEWF?=
X-IPAS-Result: =?us-ascii?q?A2BhBwCg+nxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XssgUEyKoQajnxUBoESJYl6kHYDVAoBAQEBAQEBAQE0AQIEAQGERAKCLyQ4E?=
 =?us-ascii?q?wIQAQEBBQEBAQEBBQMBAWyFYkIWAYFiKQGCfgEBAQECASMEEUYLCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjP4JYBSCtJXV/M4NMgX+DX4E+gQ4qAYwuGnmBB4E4DAOCK?=
 =?us-ascii?q?QcuPodcgl4Elw9xmFWCRoJWilyJUQYdm1+PEZ4GIjeBISsIAhgIIQ+DJ1AYD?=
 =?us-ascii?q?Y4pF41sVSUDMIEGAQGKTINRAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Mar 2020 18:59:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QIxJ5X196479;
        Thu, 26 Mar 2020 14:59:20 -0400
Subject: Re: [PATCH v3 1/3] Add a new LSM-supporting anonymous inode interface
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com, jmorris@namei.org
References: <20200214032635.75434-1-dancol@google.com>
 <20200326181456.132742-1-dancol@google.com>
 <20200326181456.132742-2-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d2d79bba-2401-9c09-ef4d-4dae667ea730@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 15:00:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326181456.132742-2-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/26/20 2:14 PM, Daniel Colascione wrote:
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

Repeating verbatim what I said on v2 of patch 1/3.

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

Just return inode here ?

> +	inode->i_flags &= ~S_PRIVATE;
> +	error =	security_inode_init_security_anon(
> +		inode, &qname, fops, context_inode);

Would drop fops argument until we have a real user for it; we can always 
add it later.

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

These changes are unnecessary for this patch and reverted by patch 3, so 
drop them here.
