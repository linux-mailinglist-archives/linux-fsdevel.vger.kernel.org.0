Return-Path: <linux-fsdevel+bounces-7469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5F825512
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FB42845A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1242E3FF;
	Fri,  5 Jan 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="WeGoaF2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB402DF97
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccbc328744so19342581fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 06:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704464251; x=1705069051; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVWWEZC0nTAcEXYkvWfohoACi+DyynjzoGETkqq6WTk=;
        b=WeGoaF2yyXjLQZI12WAYVr7O2xBY+G217JVPFUTkYakWWGdyuK8FuPD0bemHTBSvAZ
         GOGw8eHzHSG8Um1Nr0Jr9MQfPVlPZl+LSBhJZRdx/tGwEcNJB9Ca7EHuW3Jx4gJwxvGf
         Cpcnhp+qSdyN8O8b97XW1YbAYtf3+nq/NO/zVjqUXX/hvWfORtrbshvct9AyQojA8qGH
         4uMSPM8DCbXbpn5norNbVnRixFh5z3c6acGSm0Tv6fKI9ASpXFGvVDrkS6/A45EOlUv9
         Jotei+FjExDPzmJM4WHlwFGt8EyFMcCQvBx3W5WRHyZR9LVvlhyw8TdGaL2qsMwqH+N6
         pSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464251; x=1705069051;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVWWEZC0nTAcEXYkvWfohoACi+DyynjzoGETkqq6WTk=;
        b=g7Q94/qwTaLe6V03Tq+pkL7wGoLWZRsWw/bYSydcOyif4zOBPClACt3HhJjdRKpSjY
         4Nf8VS2gPmZGFVE1zeuA0ThC02bnNThZDSYFQtx54yYmfj5tqLGfRpIrWYoBPFmXHG3Z
         3KtuGdZtSGHaQINWvc+iHReXNjVyOCpC3dPtYIuHXgIF8ooPtQBkz0QbyvQFRZ/h/I3x
         Tzk7k0hze5o6VmF00VFQxwm9vMv8QdKBecFLqMaBgvvr7/wPdjY7EPntkD9WPBiwWhKR
         Z8niogBOt4azy0JizMdyoPZF+CC/HE72W1E+okp1yRgEEtGw02ZF/iT3bGhHJuu3yfZg
         UrMg==
X-Gm-Message-State: AOJu0YwVLzLQlLvfhhM1+4pz4vntVoTtCh50Zj5+lEI/9DEYKVanURwy
	5y769KUVdqukXoc4T0ZlK2EfhRRHgoaFrQ==
X-Google-Smtp-Source: AGHT+IFUzqFY0DMUD4VxQFC0jdTQ+04LaFR5XJF6GZDdXO/19l3HLlkR+Dh2SihaaVqGfq3vwivRNQ==
X-Received: by 2002:a05:651c:2213:b0:2cc:8bd4:b860 with SMTP id y19-20020a05651c221300b002cc8bd4b860mr1337702ljq.85.1704464251368;
        Fri, 05 Jan 2024 06:17:31 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:3983:bdeb:5f19:e2e9])
        by smtp.gmail.com with ESMTPSA id p8-20020a2ea4c8000000b002cca51c54c0sm337155ljm.130.2024.01.05.06.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2024 06:17:30 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240105102657.fwy7uxudqdoyogd5@quack3>
Date: Fri, 5 Jan 2024 17:17:25 +0300
Cc: Matthew Wilcox <willy@infradead.org>,
 linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 linux-mm@kvack.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE208054-586E-4365-8F07-4DEBB807755C@dubeyko.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
 <20240105102657.fwy7uxudqdoyogd5@quack3>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 5, 2024, at 1:26 PM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Fri 05-01-24 13:13:11, Viacheslav Dubeyko wrote:
>>=20
>>=20
>>> On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>>>=20
>>> This is primarily a _FILESYSTEM_ track topic.  All the work has =
already
>>> been done on the MM side; the FS people need to do their part.  It =
could
>>> be a joint session, but I'm not sure there's much for the MM people
>>> to say.
>>>=20
>>> There are situations where we need to allocate memory, but cannot =
call
>>> into the filesystem to free memory.  Generally this is because we're
>>> holding a lock or we've started a transaction, and attempting to =
write
>>> out dirty folios to reclaim memory would result in a deadlock.
>>>=20
>>> The old way to solve this problem is to specify GFP_NOFS when =
allocating
>>> memory.  This conveys little information about what is being =
protected
>>> against, and so it is hard to know when it might be safe to remove.
>>> It's also a reflex -- many filesystem authors use GFP_NOFS by =
default
>>> even when they could use GFP_KERNEL because there's no risk of =
deadlock.
>>>=20
>>> The new way is to use the scoped APIs -- memalloc_nofs_save() and
>>> memalloc_nofs_restore().  These should be called when we start a
>>> transaction or take a lock that would cause a GFP_KERNEL allocation =
to
>>> deadlock.  Then just use GFP_KERNEL as normal.  The memory =
allocators
>>> can see the nofs situation is in effect and will not call back into
>>> the filesystem.
>>>=20
>>> This results in better code within your filesystem as you don't need =
to
>>> pass around gfp flags as much, and can lead to better performance =
from
>>> the memory allocators as GFP_NOFS will not be used unnecessarily.
>>>=20
>>> The memalloc_nofs APIs were introduced in May 2017, but we still =
have
>>> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which =
is
>>> really sad).  This session is for filesystem developers to talk =
about
>>> what they need to do to fix up their own filesystem, or share =
stories
>>> about how they made their filesystem better by adopting the new =
APIs.
>>>=20
>>=20
>> Many file systems are still heavily using GFP_NOFS for kmalloc and
>> kmem_cache_alloc family methods even if  memalloc_nofs_save() and
>> memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS
>> is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
>> sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), =
blkdev_issue_zeroout(),
>> blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.
>=20
> Given the nature of the scoped API, the transition has to start in the
> leaves (i.e. filesystems itself) and only once all users of say
> radix_tree_preload() are converted to the scoped API, we can remove =
the
> GFP_NOFS use from radix_tree_preload() itself. So Matthew is right =
that we
> need to start in the filesystems.

Makes sense to me. So, we need to summarize which file system uses
the GFP_NOFS for which methods. Then, I assume, it will be possible
to split the whole modification for particular phases of getting rid of
GFP_NOFS in particular case (particular method). It looks like that
we need to declare the whole modification plan and something like
a schedule for such change. Would it work in such way? :)

Thanks,
Slava.=20


