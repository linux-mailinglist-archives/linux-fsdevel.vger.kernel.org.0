Return-Path: <linux-fsdevel+bounces-68505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13DCC5D889
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF8D420DF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634E32571A;
	Fri, 14 Nov 2025 14:18:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C31D90AD;
	Fri, 14 Nov 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129925; cv=none; b=rNnpSHR4Q3/aZHh2NW+eZd87Lz59odA4ItetsR8aoJTCkpk2n8kCOSfn40xSveP1A88HiJdCW0sXEZl3xrsgRxWmjtP4fP2brUmg7kx1qyjM7OW6zTiahRZYANWE6yUE5J6/5X/JVOcSbMucQWIxLoXWFMuTY/yygMi8gSJyKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129925; c=relaxed/simple;
	bh=oxtuu8vQX95HHaPv4/1FcIB9YX6bp6nyOI9MHimg6Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9imeIXYdEl8ZRfBNS7VXjApZjru/mEvufbsTp5fglOt6uvpQx5eM+oDzHPfRpo2g86iT+RNCVnmmYfcgsT2VxA9XJ4D8IBp9+IuZw/6OfjqfDdHKgErdS2NXy6esXHtzLMNnp4cOtpEy/Yxoes8swBKUejeddmMSKCqhxEgA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AEEI2IG043073;
	Fri, 14 Nov 2025 23:18:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AEEI2oj043065
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Nov 2025 23:18:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d8cc277f-c14c-4aee-ac0b-cce2938232d8@I-love.SAKURA.ne.jp>
Date: Fri, 14 Nov 2025 23:18:02 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hfs: Update sanity check of the root record
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        George Anthony Vernon <contact@gvernon.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linux.dev"
 <linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
 <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-4-contact@gvernon.com>
 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
 <aRJvXWcwkUeal7DO@Bertha>
 <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
 <aRKB8C2f1Auy0ccA@Bertha>
 <515b148d-fe1f-4c64-afcf-1693d95e4dd0@I-love.SAKURA.ne.jp>
 <f8648814071805c63a5924e1fb812f1a26e5d32f.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <f8648814071805c63a5924e1fb812f1a26e5d32f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp

On 2025/11/12 7:56, Viacheslav Dubeyko wrote:
> The file system is mounted only if hfs_fill_super() created root node and return
> 0 [1]. However, if hfs_iget() return bad inode [2] and we will call
> is_bad_inode() here [3]:
> 
> 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
> 	hfs_find_exit(&fd);
> 	if (!root_inode || is_bad_inode(root_inode)) <-- call will be here
> 		goto bail_no_root;
> 
> then, mount will fail. So, no successful mount will happen because
> is_valid_cnid() will manage the check in hfs_read_inode().

Do you admit that mounting (and optionally fuzzing on) a bad inode (an inode
which was subjected to make_bad_inode()) is useless?

Adding is_bad_inode() check without corresponding iput() in error path causes
an inode leak bug. Also, error code will differ (my patch returns -EIO while
your approach will return -EINVAL).

Honestly speaking, I don't like use of make_bad_inode(). make_bad_inode() might
change file type. Also, I worry that make_bad_inode() causes a subtle race bug
like https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21 which has not
come to a conclusion.

Why can't we remove make_bad_inode() usage from hfs_read_inode() and return non-0 value
(so that inode_insert5() will return NULL and iget5_locked() will call destroy_inode()
and return NULL) when hfs_read_inode() encountered an invalid entry?


