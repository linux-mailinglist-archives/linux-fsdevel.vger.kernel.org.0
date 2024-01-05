Return-Path: <linux-fsdevel+bounces-7448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFE825191
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6336D1C22F1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93ED28E2D;
	Fri,  5 Jan 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="zxslvjPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37724B50
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccbded5aa4so16870201fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704449597; x=1705054397; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb8qWmhccm9eam1IG6/mzCzwkOR/9EGblOaiwee7lpg=;
        b=zxslvjPlfpEGbydppSZROS4yK9PFl/WyX0EkqitzSpEcuqQb8fYGxbXasU+SmJn1pu
         0rPIL9a/hYppQy3+SCQxYBeiVGlAc3JL1eedwa67OMwVfBMaVIy3o3uKsgEgGeEP8kJZ
         kDn2XrRhEN2+Eivt+R0/pv4yd14Nd+zm0VYzJ+azJfd5mihiXZd39vQIswvudDwVnOJx
         EsFuAaKGE7JOBYkQFdkSHqF2xzf/nbrccglUuZSt7MJZ6bigKmsDSgBIign0NlmGiquB
         ywd+7flGkHvnkBNzwbiGNmVhsMywddOpoSzOjIwikHTTf7CbonOyKzB3Er+rJ8DWZVWL
         G6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449597; x=1705054397;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb8qWmhccm9eam1IG6/mzCzwkOR/9EGblOaiwee7lpg=;
        b=A19M0PF1QS4ff7b2NVejxHcdOPPvuA25G7bvFSHmD+BAeTWbbhPoLFSJkau/5GLXT4
         N81O9ekQHjcGT7nkibYpUsGq94QqN4LXvKPvbwN/uUbJL+cvKKq9pbIx4iDWfi429Vee
         oUC3zXOzPzTeweA1rppJtEdhBLHNPJJhpUryizY9BExDPlxd1oMjpFipVynCr7ij/wtW
         RqjdgMRS+X1o/2sjm3g+gVQeFoBxZFWUI/E6oBfPOFOIoP6+h3GgcydJngS4WGelbJ9U
         0LX00aO4K16mSCUIntbS6kXEG7OaSJkDbaL8kvfAhCDfiNleNuXdLrazOXPGL3k+R1En
         C+Hw==
X-Gm-Message-State: AOJu0Yzdx4GO2tzza+ZFBh8g12LiMm04lbm60NmX4h6gLecqrFyhb3s3
	pmWMgelePhhFMGGY2YBEevY7SQFh6nhBWg==
X-Google-Smtp-Source: AGHT+IERFwtvcyoPP3L+QB9SFl8+7lNrV2k0KLfbM/7+3R7xK9hX+EDB4G+sBp41ebG01fKH0Phabg==
X-Received: by 2002:a2e:be93:0:b0:2cd:1d5d:322e with SMTP id a19-20020a2ebe93000000b002cd1d5d322emr1306524ljr.10.1704449597179;
        Fri, 05 Jan 2024 02:13:17 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:3983:bdeb:5f19:e2e9])
        by smtp.gmail.com with ESMTPSA id n23-20020a2e82d7000000b002ccb9f5ffcasm262090ljh.93.2024.01.05.02.13.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2024 02:13:16 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>
Date: Fri, 5 Jan 2024 13:13:11 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-mm@kvack.org,
 linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> This is primarily a _FILESYSTEM_ track topic.  All the work has =
already
> been done on the MM side; the FS people need to do their part.  It =
could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
>=20
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
>=20
> The old way to solve this problem is to specify GFP_NOFS when =
allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of =
deadlock.
>=20
> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.
>=20
> This results in better code within your filesystem as you don't need =
to
> pass around gfp flags as much, and can lead to better performance from
> the memory allocators as GFP_NOFS will not be used unnecessarily.
>=20
> The memalloc_nofs APIs were introduced in May 2017, but we still have
> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> really sad).  This session is for filesystem developers to talk about
> what they need to do to fix up their own filesystem, or share stories
> about how they made their filesystem better by adopting the new APIs.
>=20

Many file systems are still heavily using GFP_NOFS for kmalloc and
kmem_cache_alloc family methods even if  memalloc_nofs_save() and
memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS
is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), =
blkdev_issue_zeroout(),
blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.

Would it be safe to switch on =
memalloc_nofs_save()/memalloc_nofs_restore() for
all possible cases? Any potential issues or downsides?

Thanks,
Slava.


