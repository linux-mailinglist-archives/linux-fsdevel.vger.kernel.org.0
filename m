Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB8195829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 14:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgC0Ni7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 09:38:59 -0400
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:14025 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Ni6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:38:58 -0400
X-EEMSG-check-017: 94280116|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="94280116"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2020 13:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585316327; x=1616852327;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=mRUo/JDnum+ajYYzG8xF8TqB7b3bNv2OJJuvgrvnyfk=;
  b=YbtkUj61Dx8v4a1vcCmjTE8nemB16LrNIJQfkw3813ymHqxNvv13Ov1A
   QN+Wr8F0m4kQ5fbpidaGaoogxJDHesfAxGmdu8kxbvMCv7ll8qGX9dR5Z
   2gItOzI4ogDSRD26x8vznC+OAu/KjvDE9YDWY5BECWNWFe7u8WwBjX/ki
   O6AwjW1kZhp8T++FBv2xlLZs+DVmMeH/kDn4SDxnecLTvHb8Z1zu+/Dwx
   5vX9eqP27UpF3w6bUtkvp7xC47XpZBUuBgpS7sVHZHFR4VhydYDONQ3kE
   0g7OtJpagbpzTfYd4cPWF5PMRQ7g8niRMkN5vvYnLk8QITsuTjzCOb7h/
   g==;
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="41132410"
IronPort-PHdr: =?us-ascii?q?9a23=3AzAwoXx1GgaETqodbsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesRL/TxwZ3uMQTl6Ol3ixeRBMOHsq4C0reH+P25EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmssAncts0bjYRiJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJrUTCHjP5mEXxjKOMcEUr5vOo5Pj9brXjp5+cM5d4igD4MqswhsyyGfk0Pw?=
 =?us-ascii?q?cBUmSB+emwyafv8VP2TblUlPE6j7HVsJXAKsQaoq65DRVV0oEm6xunFDepzc?=
 =?us-ascii?q?8YkGIbLFNFZB2Hj4/pN0vIIPDjF/izmVuskDB1x/zeJL3uHo3NLmTfkLfmZb?=
 =?us-ascii?q?ty9lRTyAwvwtBY45JZEb4BIPX0Wk/+sNzXEAU1PBCzw+biEN99zJ8RWXqTAq?=
 =?us-ascii?q?+FN6PfqUOI5uMqI+mJeY8Voiz9JOIl5vP1gn85nlgdfaat3ZQJcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHyk12NTzpTZ3e0X6Ih6TA2E5ymDYjdSYC3mrCB3z?=
 =?us-ascii?q?m0HodQZm9YDlCAC3Dod5+LW/0UciKdPtdhkiAYVbimU4Ih0RCutAnny7toN+?=
 =?us-ascii?q?bU4TMXuo7+1Nhv5u3TiREz+SVxD8Sazm6NUmV0kX0TSj8o06Bwv1Z9xk2A0a?=
 =?us-ascii?q?dmmfxYE8Jc5/dTXgc9L57cwPRwC8ruVQLZYteJVFGmT82iATEwSNIx3tAPb1?=
 =?us-ascii?q?9zG9W5kx/MwTSqDKERl7GQGpw0/bzT32LrK8Z+1XnGzq8hgEciQsdVMm2mnK?=
 =?us-ascii?q?F//RDJB4HVi0WZi7qqdaME0S7J9WeDy3eOvU5BXA5zT6rFR3YfaVXSrdni+E?=
 =?us-ascii?q?PCQKGhCa49PgtC18GCMK1KZcPtjVlcQ/fjItveaXqrm2isHRaI2q+MbI3ydm?=
 =?us-ascii?q?UewiXdDVMJkx4c/XmYLwgyHCShrHzEDDxoC13vZ1ng8e5kqHO0VkU01R2Fb1?=
 =?us-ascii?q?V917qp/R4YneKcS/IJ3rIDoyogqit7HFC839LIEdaAowthfKNBYdIy+ltH0n?=
 =?us-ascii?q?jZtwNnMpy9LKBonkQefBhvv0PyyxV3DZ1NkdAwo3M3yAp/MrqY30lcdzOcxJ?=
 =?us-ascii?q?zwP7rXKm7o/B+xcaLZxlbe0NOO8KcV9Ps4s0njvB2uFkc69XVn1dpV3mCT5p?=
 =?us-ascii?q?XNCwoSXpbxXVgt+xdmoLHaZzE355nI2n10Lam0rjjC1sotBOsiyRavYcxfMK?=
 =?us-ascii?q?OLFA/zDsIaHdKhJfclm1iuaRIEM+RS+7AuM8y6cPuG3bahPPx8kzK+kWRH/I?=
 =?us-ascii?q?d931qO9yp5Te7IxYwFw/CD3gacUTfzllKhvd72mYxeYjESBGW/mmDYA9t9b6?=
 =?us-ascii?q?tzcIJDImCqKta8x9J4ita5V3de/1mnL1wB38CtdFyZaFmrmUVM1EESvGa9kD?=
 =?us-ascii?q?qQwDtznDUk6KGY2WiG2OnmdRwaKkZVS2R4y1ThO465i5YdRkfsJwwokga1oF?=
 =?us-ascii?q?33zLVBpbhuamzUTVpMcgDoIGx4FKi9rLyPZ4hI8pxs+SFWVvmsJF6BRrPjrh?=
 =?us-ascii?q?8yzSzuBS1dySo9ejXsvY/221R+iWSAPDNwoWDfdMVY2xjS/prfSORX0z5AQz?=
 =?us-ascii?q?N3zXHUGF2UIdak55OXmo3Fv+T4UHiuEtVNcDPs5ZGNsiqlo2lrBwCv2feplZ?=
 =?us-ascii?q?v6EkxyySbm0/FyXDjM6RP7ZZPmka+9NKYveE9rLFD77MV+F8d1lY50zJUX2n?=
 =?us-ascii?q?UBhpqU8WAOuWj0Ntpf1OT1a39JDTwOxMTP4RPN3kRmI3PPwJj2BVuHxc40XM?=
 =?us-ascii?q?W3emMb3GoG6slODKqFpOhfkTBdvkuzrQWXZ+N02Dga1619uzYhn+gVtV91nW?=
 =?us-ascii?q?2mCbcIEBwdZHe9mg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AJCAAhAX5e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XssgUABMiqEGo58UgEBBoEKLYl7j2aBEANUCgEBAQEBAQEBATQBAgQBAYREA?=
 =?us-ascii?q?oIxJDgTAhABAQEFAQEBAQEFAwEBbIViQhYBgWIpAYMLAQEBAQIBIxVGCwsOC?=
 =?us-ascii?q?gICJgICVwYBDAYCAQGCYz+CWAUgq1Z1gTKDTIF/g22BPoEOKgGINYN5GnmBB?=
 =?us-ascii?q?4E4D4IwLj6ENIMsgl4ElxFxmFuCRoJWil6JUgYdm2mPFJ4LIjeBISsIAhgII?=
 =?us-ascii?q?Q+DJ1AYDZwsVSUDMIEGAQGKL4NPAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Mar 2020 13:38:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02RDd40v212374;
        Fri, 27 Mar 2020 09:39:05 -0400
Subject: Re: [PATCH v4 1/3] Add a new LSM-supporting anonymous inode interface
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com, jmorris@namei.org
References: <20200326181456.132742-1-dancol@google.com>
 <20200326200634.222009-1-dancol@google.com>
 <20200326200634.222009-2-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3ed1ea71-f640-f332-812b-652c83598784@tycho.nsa.gov>
Date:   Fri, 27 Mar 2020 09:40:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326200634.222009-2-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/26/20 4:06 PM, Daniel Colascione wrote:
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
> index 89714308c25b..024059e333dc 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,75 +55,135 @@ static struct file_system_type anon_inode_fs_type = {
> +static struct inode *anon_inode_make_secure_inode(
> +	const char *name,
> +	const struct inode *context_inode,
> +	const struct file_operations *fops)

fops argument can be removed here too, unused now by this function.

>   /**
> - * anon_inode_getfd - creates a new file instance by hooking it up to an
> - *                    anonymous inode, and a dentry that describe the "class"
> - *                    of the file
> + * anon_inode_getfile_secure - creates a new file instance by hooking
> + *                             it up to a new anonymous inode and a
> + *                             dentry that describe the "class" of the
> + *                             file.  Make it possible to use security
> + *                             modules to control access to the
> + *                             new file.
>    *
>    * @name:    [in]    name of the "class" of the new file
>    * @fops:    [in]    file operations for the new file
>    * @priv:    [in]    private data for the new file (will be file's private_data)
> - * @flags:   [in]    flags
> + * @flags:   [in]    flags for the file
> + * @anon_inode_flags: [in] flags for anon_inode*

anon_inode_flags leftover from prior version of the patch, not an 
argument in the current code.  Likewise, the "for the file" addendum to 
the @flags argument description is a leftover and not needed.

 > + * Creates a new file by hooking it on an unspecified inode. This is
 > + * useful for files that do not need to have a full-fledged inode in
 > + * order to operate correctly.  All the files created with
 > + * anon_inode_getfile_secure() will have distinct inodes, avoiding
 > + * code duplication for the file/inode/dentry setup.

The two preceding sentences directly contradict each other.

> +/**
> + * anon_inode_getfile - creates a new file instance by hooking it up
> + *                      to an anonymous inode and a dentry that
> + *                      describe the "class" of the file.

This would be identical to the original except for different word 
wrapping.  Probably a leftover from prior version of the patch where you 
were modifying the existing interface.  Recommend reverting such changes 
to minimize unnecessary noise in your diff and meke it easier to tell 
what changes are real.

> + *
> + * @name:    [in]    name of the "class" of the new file
> + * @fops:    [in]    file operations for the new file
> + * @priv:    [in]    private data for the new file (will be file's private_data)
> + * @flags:   [in]    flags for the file
>    *
> - * Creates a new file by hooking it on a single inode. This is useful for files
> + * Creates a new file by hooking it on an unspecified inode. This is useful for files

Unnecessary difference here; this interface does use a single inode.

> @@ -146,6 +207,57 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
>   	put_unused_fd(fd);
>   	return error;
>   }
> +
> +/**
> + * anon_inode_getfd_secure - creates a new file instance by hooking it
> + *                           up to a new anonymous inode and a dentry
> + *                           that describe the "class" of the file.
> + *                           Make it possible to use security modules
> + *                           to control access to the new file.
> + *
> + * @name:    [in]    name of the "class" of the new file
> + * @fops:    [in]    file operations for the new file
> + * @priv:    [in]    private data for the new file (will be file's private_data)
> + * @flags:   [in]    flags
> + *
 > + * Creates a new file by hooking it on an unspecified inode. This is
 > + * useful for files that do not need to have a full-fledged inode in
 > + * order to operate correctly.  All the files created with
 > + * anon_inode_getfile_secure() will have distinct inodes, avoiding
 > + * code duplication for the file/inode/dentry setup.

The two preceding sentences contradict each other.

