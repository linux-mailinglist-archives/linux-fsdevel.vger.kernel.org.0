Return-Path: <linux-fsdevel+bounces-50852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA521AD051B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E67172CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4528937A;
	Fri,  6 Jun 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="K2tCnOwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3913D52F;
	Fri,  6 Jun 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223403; cv=none; b=Gi5s3haulA7o89LOrutaPLwppFfAiReh1OTWWSlwRL+9VkvkXKSKddYHE4mjhmbxnM8LVFdEMY7Cq7rtPm1tmMmLNSHejnUT1GgqizVadWyWBoURRqVaPTh65askGv5PsHkhdwBB936QFKqpcRgtdIgd2o++Qocxlws9d4KNQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223403; c=relaxed/simple;
	bh=YPQHOA5kSqFGUsoQ+jIhAIS36Z4dE20BlDV3jKC+PYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/ViD0qPFS6J9B2wlLLoZb4RQ1c07LOiXmu0CHmXXbXkAMzNDMAOfEMed9ToWzLcpAgKTGJyqPOaq98ZjHify4imTfLUt/hjUihF6t3mKcNueLdn7jyEET/VcheiRVreHTolb67jsib8dcAFZc7zq+yWCCjMVsG8OeDZLiBURts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=K2tCnOwG; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Message-ID: <3b461ee7-c3ee-484b-b945-ec6070355bfe@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1749223398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC5WXwIyePFbi5jc4rzYZSJpl/hestrYvtJLaOCfr/c=;
	b=K2tCnOwGIIkIFg0EJpp+pfHV2hk6mQ1J5urKlln67Jp5fOG7BkINyAZLmeBP2rChxlDZei
	7s3I6VKB79cpZhyt1jcb+fqAQ8v7Ctxk08/ZFVXH6AGy+EJZ6hOr4nFbz4eR9VxMNfp5Yn
	IlUrn/sE5ZbRKNd7wiB96flFIQnU1lE=
Date: Fri, 6 Jun 2025 18:24:16 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
Content-Language: en-US
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <49730b18-605f-4194-8f93-86f832f4b8f8@swemel.ru>
 <CAEjxPJ5KoTBB18_7+fWL+GWY4N5Vp2=Kn=9FJR2GewFRcMgzPQ@mail.gmail.com>
From: Konstantin Andreev <andreev@swemel.ru>
Disposition-Notification-To: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <CAEjxPJ5KoTBB18_7+fWL+GWY4N5Vp2=Kn=9FJR2GewFRcMgzPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Jun 2025 15:23:17.0475 (UTC) FILETIME=[EDA31B30:01DBD6F6]

Stephen Smalley, 06/06/2025 10:28 -0400:
> On Fri, Jun 6, 2025 at 9:38 AM Konstantin Andreev <andreev@swemel.ru> wrote:
>> Stephen Smalley, 28/04/2025:
>>> Update the security_inode_listsecurity() interface to allow
>>> use of the xattr_list_one() helper and update the hook
>>> implementations.
>>>
>>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
>>
>> Sorry for being late to the party.
>>
>> Your approach assumes that every fs-specific xattr lister
>> called like
>>
>> | vfs_listxattr() {
>> |    if (inode->i_op->listxattr)
>> |        error = inode->i_op->listxattr(dentry, list, size)
>> |   ...
>>
>> must call LSM to integrate LSM's xattr(s) into fs-specific list.
>> You did this for tmpfs:
>>
>> | simple_xattr_list() {
>> |   security_inode_listsecurity()
>> |   // iterate real xatts list
>>
>>
>> Well, but what about other filesystems in the linux kernel?
>> Should all of them also modify their xattr listers?
>>
>> To me, taking care of security xattrs is improper responsibility
>> for filesystem code.
>>
>> May it be better to merge LSM xattrs
>> and fs-backed xattrs at the vfs level (vfs_listxattr)?
> 
> This patch and the preceding one on which it depends were specifically
> to address a regression in the handling of listxattr() for tmpfs/shmem
> and similar filesystems.
> Originally they had no xattr handler at the filesystem level and
> vfs_listxattr() already has a fallback to ensure inclusion of the
> security.* xattr for that case.

Understood

> For filesystems like ext4 that have always (relative to first
> introduction of security.* xattrs) provided handlers, they already
> return the fs-backed xattr value and we don't need to ask the LSM for
> it.

They only return those security.* xattrs that were physically stored
in the fs permanent storage.

If LSM's xattrs are not stored they are not listed :(

> That said, you may be correct that it would be better to introduce
> some additional handling in vfs_listxattr() but I would recommend
> doing that as a follow-up.

Understood

--
Konstantin Andreev

