Return-Path: <linux-fsdevel+bounces-19368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFFE8C40E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 14:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE73D1C21634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573114F9C8;
	Mon, 13 May 2024 12:41:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF47A3F;
	Mon, 13 May 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604096; cv=none; b=PUZ9JNYl+SDWsxvRmybicCyh+xlw82mrwlWxkfCooFK7jenIgbMPPbsDHeNx2ESqzi2FvGEHS9PfxbUakR95k+UyaUJWwkhiS3tVuTH2JBlziRB1NrqRS438SpMJH47m/OkpxSf2mhZHXQyTf9qujeAWB6zam17z2kWc3CPPVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604096; c=relaxed/simple;
	bh=iyglkIQB6KKTyXDEKBd19IqLBit9NFZJ94NAOwpbG6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJCnDWW8OYyj6Nxlbem/glX2j+2DjxgxkASD48lCPgtr51n8Xs9Av5aAGw2GdWoY6TbpCl+u+NASQc7OoU/HRJ/FasEGp5p1nfV7yv7HlLFQmGVemWkbOIKXF1ka7F+6qT/iHF92ArBzQqyoe+gBG4QTO6ep+vlNkfMEUIssAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed96772f92so34888895ad.0;
        Mon, 13 May 2024 05:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715604094; x=1716208894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZp92t/tgjMWQaWxzSO1yWcazbBOvy/GSBsy+000DoM=;
        b=o+4gqFsHXRthNNW2yWxpBI+vE6b73PSv3LEBaqoMzU7L0dm/jkqe6v1ajPbtIee5rU
         rrQcOIO1p+2OytQknvFtlDPjsN7jF4+PVnSmJ2Xo6AYvh2w5CKlmZ4JRS4l2juOvUTdD
         ZqaGFexrTK5qCECwciTj+TXG0onAcYTUevt0zfLAkx5891meOBriPEmTTBiFLmNxtzUA
         LRtAYEcUITkWCBe8Vtwx/+pGIdDSdBQQAubekxhuaQpzRPVkWMA8zq8b2Be3zpjLHSdU
         ShhLO9awz7hv7XncVbpsGCBLdK1iyG3kNdR9LqBG1GxRsRe0Q4E5O439G3xjRHMQrqwS
         l+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVgGxD/6NZXPlm4eMH+O4E3c0mpeFdmD1WkBI3W0pEzCihH+ssLEUGciw2KAyjOn1ylbI66GxQ1N7OpoRXnbNwwnc8ILAPb0iJgqRIv2Yq9FX6H9HX55oDncqpYamfyulu5V/afDDLpWovNGA==
X-Gm-Message-State: AOJu0YzWEwekx6gRHr+T/QOy8JCMDbpIYPt0PNyxXK1UDylVm6avqxhh
	NUWXVBdweM9b+4JUG8+Um4D0NSoJm1Z4nkMWWQ9G8FJnY5RjsDKP+ir73Q==
X-Google-Smtp-Source: AGHT+IE7aa4u4QpBkiILchc0FDFHWWiO9+3qmI5b1zK7BIR0L0QmBwhkx37Y1en0D0GVN27befm3ag==
X-Received: by 2002:a17:903:2301:b0:1eb:14e3:5d6e with SMTP id d9443c01a7336-1ef43d2ecbfmr116229015ad.31.1715604094367;
        Mon, 13 May 2024 05:41:34 -0700 (PDT)
Received: from gmail.com (c-71-195-205-98.hsd1.ut.comcast.net. [71.195.205.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c037520sm78361715ad.194.2024.05.13.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:41:33 -0700 (PDT)
Date: Mon, 13 May 2024 13:41:32 +0100
From: Breno Leitao <leitao@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: paulmck@kernel.org,
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fuse: annotate potential data-race in num_background
Message-ID: <ZkIKfFs-0lfflzV-@gmail.com>
References: <20240509125716.1268016-1-leitao@debian.org>
 <CAJfpeguh9upC5uqcb3uetoMm1W7difC86+-BxZZPjkXa-bNqLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguh9upC5uqcb3uetoMm1W7difC86+-BxZZPjkXa-bNqLg@mail.gmail.com>

Hello Miklos,

On Fri, May 10, 2024 at 11:21:19AM +0200, Miklos Szeredi wrote:
> On Thu, 9 May 2024 at 14:57, Breno Leitao <leitao@debian.org> wrote:
> 
> > Annotated the reader with READ_ONCE() and the writer with WRITE_ONCE()
> > to avoid such complaint from KCSAN.
> 
> I'm not sure the write side part is really needed, since the lock is
> properly protecting against concurrent readers/writers within the
> locked region.

I understand that num_background is read from an unlocked region
(fuse_readahead()).

> Does KCSAN still complain if you just add the READ_ONCE() to fuse_readahead()?

I haven't checked, but, looking at the documentation it says that both part
needs to be marked. Here is an example very similar to ours here, from
tools/memory-model/Documentation/access-marking.txt

	Lock-Protected Writes With Lockless Reads
	-----------------------------------------

	For another example, suppose a shared variable "foo" is updated only
	while holding a spinlock, but is read locklessly.  The code might look
	as follows:

		int foo;
		DEFINE_SPINLOCK(foo_lock);

		void update_foo(int newval)
		{
			spin_lock(&foo_lock);
			WRITE_ONCE(foo, newval);
			ASSERT_EXCLUSIVE_WRITER(foo);
			do_something(newval);
			spin_unlock(&foo_wlock);
		}

		int read_foo(void)
		{
			do_something_else();
			return READ_ONCE(foo);
		}

	Because foo is read locklessly, all accesses are marked.


From my understanding, we need a WRITE_ONCE() inside the lock, because
the bg_lock lock in fuse_request_end() is invisible for fuse_readahead(),
and fuse_readahead() might read num_backgroud that was writen
non-atomically/corrupted (if there is no WRITE_ONCE()).

That said, if the reader (fuse_readahead()) can handle possible
corrupted data, we can mark is with data_race() annotation. Then I
understand we don't need to mark the write with WRITE_ONCE().

Here is what access-marking.txt says about this case:

	Here are some situations where data_race() should be used instead of
	READ_ONCE() and WRITE_ONCE():

	1.      Data-racy loads from shared variables whose values are used only
		for diagnostic purposes.

	2.      Data-racy reads whose values are checked against marked reload.

	3.      Reads whose values feed into error-tolerant heuristics.

	4.      Writes setting values that feed into error-tolerant heuristics.


Anyway, I am more than happy to test with only a READ_ONLY() in the
reader side, if that the approach you prefer.

Thanks!

