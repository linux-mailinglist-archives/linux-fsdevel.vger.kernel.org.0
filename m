Return-Path: <linux-fsdevel+bounces-50845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7EAD035D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DB53B2B59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32380289378;
	Fri,  6 Jun 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="kX2stUGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31B27FD5A;
	Fri,  6 Jun 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217141; cv=none; b=okuciEbyt+5K/FBlIVIEBYYXbASJBdEqGUhsK7NbY3wuxOqo7rqfRytZb5plKVOvwzpErsoFeFxDBeh04+5rIxjqi6NtSyczCR34njOUMz21QplDc/bhgzORWQTiSthWzqd1ASc34Cm4k9Er97UckU/k2DAg668KNWLNQw9VwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217141; c=relaxed/simple;
	bh=mdgDgqmHWYRMiJBeD5MRWizVMkY2pth50iG8rwuBYOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ol+VIMfRd+hXq9/5imDAvGpzAh4wM39XuE3xhJcLHzt0slQ9qDYZMyTxsxm0nNC4edK7Pk2NPRE7z8B0X979OwnHQNZEte3NW1m7Ezr4WJqvhJkbMIhLRNd4MBVhVB4V2llDPlVJguraTOcK1B/xj035R4JdP8ogXNxgauVRiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=kX2stUGY; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Message-ID: <49730b18-605f-4194-8f93-86f832f4b8f8@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1749217127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jhQpF+R0Z64uKurrBCjq0j+He4F0llIw3IZaku5tJQ=;
	b=kX2stUGY573U2qg5ZI0N4pwIUvvKTudDnhgBPWBxxBfNPRZa04Z6CrkvK4PuxDlhqJ3LoC
	Q9GTAM36hxbyZMg72yzNobP8Sz4rBd1z+kE8wvjSZxuCkBw/uDfwb0YIORVzLfgvb+Ogqq
	q5AIMWU8zyzj/qGt9DJNU/u3whTPNEM=
Date: Fri, 6 Jun 2025 16:39:45 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Konstantin Andreev <andreev@swemel.ru>
Subject: Re: [PATCH v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: linux-security-module@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
Content-Language: en-US
Disposition-Notification-To: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2025 13:38:46.0205 (UTC) FILETIME=[53AB3ED0:01DBD6E8]

Stephen Smalley, 28/04/2025:
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
> 
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/

Sorry for being late to the party.

Your approach assumes that every fs-specific xattr lister
called like

| vfs_listxattr() {
|    if (inode->i_op->listxattr)
|        error = inode->i_op->listxattr(dentry, list, size)
|   ...

must call LSM to integrate LSM's xattr(s) into fs-specific list.
You did this for tmpfs:

| simple_xattr_list() {
|   security_inode_listsecurity()
|   // iterate real xatts list


Well, but what about other filesystems in the linux kernel?
Should all of them also modify their xattr listers?

To me, taking care of security xattrs is improper responsibility
for filesystem code.

May it be better to merge LSM xattrs
and fs-backed xattrs at the vfs level (vfs_listxattr)?

--
Konstantin Andreev

