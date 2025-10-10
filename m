Return-Path: <linux-fsdevel+bounces-63755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F045BCCF2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAD11A662F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F42EF652;
	Fri, 10 Oct 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="M0N0E6SH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DA2EDD45
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100166; cv=none; b=blIFCsEHmwNkl7BvbRivCjvd6ksmeykn7/rNRF6tdvFIlYwcIX9NkSScsjaVPvqKYn3heI+30KEgMC+7hgJvuvOGBpOu4JxOyqOzD638tbgpTzwmP3vj6qF/vpRNSHjZiU7G2WNY4N2xHzH779r5kai9AA1yKpqzjeDLWZrkW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100166; c=relaxed/simple;
	bh=au8PLeyI2+Pe4ULs+APkVrpzfMg+hC+ART9veqXOIk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUB7pPJios6kGluoUyrRcZSHmWoLfy43GHM/R/Si9hkfqZY5sCl3HqQDQoTfG8Un/PfBG1R8wthzXtDFMN5XELgpQJZgmVE+bFd99fQ3yjGsaZx0pAG5nt7ZI6LW2nTtMI4eAmy5TuVfhb3oMcjjJKbLPrjkRkDxqX2Glb/7Bqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=M0N0E6SH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1622365f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760100163; x=1760704963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ed6VgS5iZMO8gnpHzEOAATrMdAcan5FzzzLKhhlpKCc=;
        b=M0N0E6SHVT7jEPhWbMedq6miTm4XYWvWPGIQVDSCc35fp3kimxN17v7JZO8yW9mtgS
         fWyddsnJeqD7IkHnC6E9bRGLpYCaFXuDLeBUKCfNlLsyJZOkalrm+yrWWr8W3KnoSzlh
         OxdPOELQAJVmGQsVqEc3ytB6J7k5DmZMtmSlf+dgRmXujkY2E+kH6Dqzof8o+zzbuaI1
         XuZJkY4/T6qXHzxeB14dSnrUzRGVbvYt81Mgfa3dkjRIrTmEEpWmrRtIycPan6PRZKYh
         tKUXBTxKEST78QQFd+y+uFYEBMGGu8ArGi71fGkQ5RJlA5YtqbVJxeAOcHf9dy2i+z0r
         25YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100163; x=1760704963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed6VgS5iZMO8gnpHzEOAATrMdAcan5FzzzLKhhlpKCc=;
        b=URm+aZREBP20/VOn1MLhuSkLI9YOpWASbSaOxciHAlg3q1mYDO9nrm3/9FKq+Bo6hD
         O1CgGFx99hLxGgCHpIxrI6f3CA8SqRlIOc2mx4wj6wHB7ISp5mkS6hHmxwbMxcz95lUh
         56AEfn3Li82CQYIDX5dBuDCHvUIXyvbj1TS4wJiIyXNk8L/75TH6DBpys44x0DK4roQr
         q/QuqsYStJxWJqRL2yUYRwpBxkaJifaDO8GxaU7tqdAmol67otVG/ThZpT/S8IJldyGn
         Jyzl/g2okvn96YQTDp++xpcKfFfrsk2VO4TshkOCKK77IlE9wD3sAO1Ea7d1twRlSBqd
         G7mg==
X-Forwarded-Encrypted: i=1; AJvYcCV2jS/LDmIAqaY/eGVCWlq0/TsDeOhpMSh1QwJF7yq65aibT/C8mavVL9mxvmJM9RJ74mQaJtjYLJyP8vEP@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfVPnNKTEQk1Hdd7oevuuX/hc3u81DbR4B5hSUdM+sg/HOjLD
	cmg4Sug40iWEUYnmOIDOZOHk5LwRRFkJ4nm+hsntBQSpETv5ZgIJHA1H5tIDjSA/uIc3HNX08Yw
	3/QuVFCY=
X-Gm-Gg: ASbGncu96c2fMtF2KGuwLThK469fEEC7Bs8kg3r//xE0l1xXg7uJpDiGaASbJydhIdQ
	I7bDFKjoBF8SHYOW9j0mVspB0/kXy0NQ22IFIbmOrELBDJzfa60QdTvMvd4aGz5pzxLjhEd/bwr
	Fln2uvnE3goh5jAAPZ6MSu9xjw2SbLbJvD3AzYlHMxP+aqia3bYgC1BEk5A4aRG3IkcreYPjWL3
	XaTNvfxs90t5pSDLBoFWygtJWVUwp9gfbjwCoUsKO1e8Np+m+KmrQ+6ClkK4W9rqQ5inpSyx3eN
	fBLja4pFGG3K6AwtrWpUa+L4NKdTBkunJmEsqJ8Gb7SxWMmtRgpiRU4mMSZyGs9cYrf1i3k1yNY
	bc2lziBlz0G4GtY7K0/n6dL4BvLdjVX6K6VDv
X-Google-Smtp-Source: AGHT+IE9WPcyJENyMKBqBjIXMdFg1BwYt6/7Sf3fpBe2yXxsdwOSvmD7T9GXrgparUtDBtokYQjs6g==
X-Received: by 2002:a05:6000:4009:b0:425:86d1:bcc7 with SMTP id ffacd0b85a97d-42586d1c0cdmr8127958f8f.23.1760100162565;
        Fri, 10 Oct 2025 05:42:42 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3df:2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4983053sm43513775e9.8.2025.10.10.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:42:41 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:42:41 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251010124241.k4wsjwdcy5svwd36@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <20251008162655.GB502448@mit.edu>
 <20251009102259.529708-1-matt@readmodwrite.com>
 <20251009175254.d6djmzn3vk726pao@matt-Precision-5490>
 <20251010020410.GE354523@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010020410.GE354523@mit.edu>

On Thu, Oct 09, 2025 at 10:04:10PM -0400, Theodore Ts'o wrote:
> 
> OK, so that definitely confirms the theory of what's going on.  There
> have been some changes in the latest kernel that *might* address what
> you're seeing.  The challenge is that we don't have a easy reproducer
> that doesn't involve using a large file system running a production
> workload.  If you can only run this on a production server, it's
> probably not fair to ask you to try running 6.17.1 and see if it shows
> up there.
 
FWIW we will likely pick up the next LTS so I can get you an answer but
it might take a few months :)

> I do think in the long term, we need to augment thy buddy bitmap in
> fs/ext4/mballoc.c with some data structure which tracks free space in
> units of stripe blocks, so we can do block allocation in a much more
> efficient way for RAID systems.  The simplest way would be to add a
> counter of the number of aligned free stripes in the group info
> structure, plus a bit array which indicates which aligned stripes are
> free.  This is not just to improve stripe allocation, but also when
> doing sub-stripe allocation, we preferentially try allocating out of
> stripes which are already partially in use.
> 
> Out of curiosity, are you using the stride parameter because you're
> using a SSD-based RAID array, or a HDD-based RAID array?

We're using SSD-based RAID 0 with 10 disks.

$ sudo dumpe2fs -h /dev/md127| grep -E "stride|stripe"
dumpe2fs 1.47.0 (5-Feb-2023)
RAID stride:              128
RAID stripe width:        1280

