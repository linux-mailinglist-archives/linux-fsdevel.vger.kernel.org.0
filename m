Return-Path: <linux-fsdevel+bounces-26279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DB957029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CACF282249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6FF172BA8;
	Mon, 19 Aug 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="sgyjq+th"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-gcp.globallogic.com (smtp-gcp.globallogic.com [34.141.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8B47F46;
	Mon, 19 Aug 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.141.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084740; cv=none; b=kxnFLMeKBwpJla4b8AXLpSbNPXKaz1MHiCMC8LF4nx/7bvHTmrVELJY7oQWMgmhoscxY5E2fPaW3IEqQ4xpLCg98CAoAf7p3yxHaVlqu6pOa3Lobs2TYqK4T30suM4sp2lZJB180LnVqVmKOB8cMYatgDKG0vXnHiUhj63yRvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084740; c=relaxed/simple;
	bh=4oXMonRPxccaHdiwvgUeceJcnzdEZ5/9triV5lyvzDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur3zQWPE7RfPwICmEpPT/Y7smIkT/MCpgHEXWva9lJxGf11HNPvwNZHS631O6ZaTNvmxbBSlhnCXcsKlBEUFU/jUfmXUijT5LliD7XfFEpWO4kLCatAIxXUgwOT05wS3wjFTtlGxlu1klaf8dqpGhD3LFS3/+071wCbN1tYayTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com; spf=pass smtp.mailfrom=globallogic.com; dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b=sgyjq+th; arc=none smtp.client-ip=34.141.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=globallogic.com
Received: from [172.22.130.14] (unknown [172.22.130.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gcp.globallogic.com (Postfix) with ESMTPSA id 8070B10ACE1F;
	Mon, 19 Aug 2024 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
	s=smtp-kbp; t=1724084736;
	bh=s7bm1H0BrCXSzIRXDUyyJAEje9yWAMefIXx3rGHE1EU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sgyjq+thps50dAYYWJbrmuYucGK9MOxbD1hMb6IwpOoSx1bePvWuGruCzX+WukH+H
	 F8YnPoHeSGxSytdIG58OkifhoFKantNny3QK6ufhQJ1nXvd3qx7ZoDH2CGphnI5z5A
	 aR2quZXin6JMnitJpxm5T4pgTeM9k41ulnEASG5ccFIlZPd+e1MOMeu0Qz5dKdWMcf
	 JxLrpS0K14vXDGKxeupgU6dCj5+yZSbCip+sM+8XXA2ex110x2KwxlOufPTDXTPzMW
	 Bf1HxsvXzCjP890SH+cy5fWvnsaFKI1DETqYAKNQZhQIMTDW2RVEpg8xGRJBu8ZOrl
	 1Kf1MYR2qEp5w==
Message-ID: <2b899572-6c62-46a1-9128-45172a58b79a@globallogic.com>
Date: Mon, 19 Aug 2024 19:25:35 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/exfat: add NFS export support
To: Chuck Lever <chuck.lever@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: andrii.polianytsia@globallogic.com, sj1557.seo@samsung.com,
 zach.malinowski@garmin.com, artem.dombrovskyi@globallogic.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org, linux-nfs@vger.kernel.org
References: <20240819121528.70149-1-andrii.polianytsia@globallogic.com>
 <ZsNJNJE/bIWqsXl1@tissot.1015granger.net>
 <CAKYAXd98C6t2+h7Q8UC-p3fCTYtKCwmWvd4jCn1br_crc48KLw@mail.gmail.com>
 <ZsNZQRajNoZmllBU@tissot.1015granger.net>
Content-Language: en-US, uk-UA
From: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
In-Reply-To: <ZsNZQRajNoZmllBU@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chuck and Namjae,
Thank you for your valuable feedback.

We will update the patch description to reference fs/fat/nfs.c, as the
implementation of exFAT NFS export is indeed based on similar logic
used in FAT, which also manages non-persistent file handles.

Before submitting this patch, we conducted extensive testing in four 
categories:
functionality, stress, stability, and performance. We did encounter some 
issues
related to limitations, such as Unix file permissions and timestamp 
granularity,
which are inherent due to exFAT's origins in Windows. However, our tests 
didn't
reveal issues related to file handle persistence. If you have any 
insights or scenarios
where this issue could be reproduced in real-world use, we would greatly 
appreciate
your guidance.

We will make the necessary comment updates and resubmit the patch shortly.

--
Sergii Boryshchenko

On 19.08.24 17:40, Chuck Lever wrote:
> On Mon, Aug 19, 2024 at 11:21:05PM +0900, Namjae Jeon wrote:
>>> [ ... adding linux-nfs@vger.kernel.org ]
>>>
>>> On Mon, Aug 19, 2024 at 03:15:28PM +0300, andrii.polianytsia@globallogic.com wrote:
>>>> Add NFS export support to the exFAT filesystem by implementing
>>>> the necessary export operations in fs/exfat/super.c. Enable
>>>> exFAT filesystems to be exported and accessed over NFS, enhancing
>>>> their utility in networked environments.
>>>>
>>>> Introduce the exfat_export_ops structure, which includes
>>>> functions to handle file handles and inode lookups necessary for NFS
>>>> operations.
>>> My memory is dim, but I think the reason that exporting exfat isn't
>>> supported already is because it's file handles aren't persistent.
>> Yes, and fat is the same but it supports nfs.
>> They seem to want to support it even considering the -ESTALE result by eviction.
>> This patch seems to refer to /fs/fat/nfs.c code which has the same issue.
> Fair enough. I don't see a reference to fs/fat/nfs.c, so may I
> request that this added context be included in the patch description
> before this patch is merged?
>
> Out of curiosity, is any CI testing done on fat exported via NFS? At
> the moment I don't happen to include it in NFSD's CI matrix.
>
>
>>> NFS requires that file handles remain the same across server
>>> restarts or umount/mount cycles of the exported file system.
>>>
>>>
>>>> Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
>>>> Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
>>>> ---
>>>>   fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 65 insertions(+)
>>>>
>>>> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
>>>> index 323ecebe6f0e..cb6dcafc3007 100644
>>>> --- a/fs/exfat/super.c
>>>> +++ b/fs/exfat/super.c
>>>> @@ -18,6 +18,7 @@
>>>>   #include <linux/nls.h>
>>>>   #include <linux/buffer_head.h>
>>>>   #include <linux/magic.h>
>>>> +#include <linux/exportfs.h>
>>>>
>>>>   #include "exfat_raw.h"
>>>>   #include "exfat_fs.h"
>>>> @@ -195,6 +196,69 @@ static const struct super_operations exfat_sops = {
>>>>        .show_options   = exfat_show_options,
>>>>   };
>>>>
>>>> +/**
>>>> + * exfat_export_get_inode - Get inode for export operations
>>>> + * @sb: Superblock pointer
>>>> + * @ino: Inode number
>>>> + * @generation: Generation number
>>>> + *
>>>> + * Returns pointer to inode or error pointer in case of an error.
>>>> + */
>>>> +static struct inode *exfat_export_get_inode(struct super_block *sb, u64 ino,
>>>> +     u32 generation)
>>>> +{
>>>> +     struct inode *inode = NULL;
>>>> +
>>>> +     if (ino == 0)
>>>> +             return ERR_PTR(-ESTALE);
>>>> +
>>>> +     inode = ilookup(sb, ino);
>>>> +     if (inode && generation && inode->i_generation != generation) {
>>>> +             iput(inode);
>>>> +             return ERR_PTR(-ESTALE);
>>>> +     }
>>>> +
>>>> +     return inode;
>>>> +}
>>>> +
>>>> +/**
>>>> + * exfat_fh_to_dentry - Convert file handle to dentry
>>>> + * @sb: Superblock pointer
>>>> + * @fid: File identifier
>>>> + * @fh_len: Length of the file handle
>>>> + * @fh_type: Type of the file handle
>>>> + *
>>>> + * Returns dentry corresponding to the file handle.
>>>> + */
>>>> +static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
>>>> +     struct fid *fid, int fh_len, int fh_type)
>>>> +{
>>>> +     return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
>>>> +             exfat_export_get_inode);
>>>> +}
>>>> +
>>>> +/**
>>>> + * exfat_fh_to_parent - Convert file handle to parent dentry
>>>> + * @sb: Superblock pointer
>>>> + * @fid: File identifier
>>>> + * @fh_len: Length of the file handle
>>>> + * @fh_type: Type of the file handle
>>>> + *
>>>> + * Returns parent dentry corresponding to the file handle.
>>>> + */
>>>> +static struct dentry *exfat_fh_to_parent(struct super_block *sb,
>>>> +     struct fid *fid, int fh_len, int fh_type)
>>>> +{
>>>> +     return generic_fh_to_parent(sb, fid, fh_len, fh_type,
>>>> +             exfat_export_get_inode);
>>>> +}
>>>> +
>>>> +static const struct export_operations exfat_export_ops = {
>>>> +     .encode_fh = generic_encode_ino32_fh,
>>>> +     .fh_to_dentry = exfat_fh_to_dentry,
>>>> +     .fh_to_parent = exfat_fh_to_parent,
>>>> +};
>>>> +
>>>>   enum {
>>>>        Opt_uid,
>>>>        Opt_gid,
>>>> @@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>        sb->s_flags |= SB_NODIRATIME;
>>>>        sb->s_magic = EXFAT_SUPER_MAGIC;
>>>>        sb->s_op = &exfat_sops;
>>>> +     sb->s_export_op = &exfat_export_ops;
>>>>
>>>>        sb->s_time_gran = 10 * NSEC_PER_MSEC;
>>>>        sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>> --
>>> Chuck Lever

