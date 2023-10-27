Return-Path: <linux-fsdevel+bounces-1457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE77DA328
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9F21F21C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED16B405D9;
	Fri, 27 Oct 2023 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FwBsr3vp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4F3FE5C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:10:45 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D241B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:10:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2486266b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698444643; x=1699049443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gGWI9hiI8wgQuogxLeAYpmHgRP3GLhdkxT/rH7PRNE=;
        b=FwBsr3vp78eoyv3K0ksbwYy3169VuRqIoEyGBCYlkcBgfc4TEfDIzd4iqLub1srObf
         8DdJECk8QEHifDTHuWhazmS9CAVHuGxWm/v0CET5bWNz2J9J7LSNeDCU6zFk+/kytZvI
         xCHyg578sj09wQGKuCoQWf30syE3/hFTOlChjAKdFhiAlZHSeBPEQsFTFcD6TWjOwELX
         6FaJRXwMOywFJGECf8Dwy6510PrvDJ87BBHWk1jhhKWEtTNuPkY/Tvabo3NITXmRDKXO
         V6HCmtk2cUtWUfyWk88lgjiE7AlDRIR9KVOE4Tcw8Yg91vHlApGEdk5wrXorZusIbXyO
         QVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698444643; x=1699049443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gGWI9hiI8wgQuogxLeAYpmHgRP3GLhdkxT/rH7PRNE=;
        b=cDS2HJy5dB5T9/nf2WoAvB00knQUpa0r0g3RZgTecC4HyJXZ6TKUdDZGXAJmj6LXr3
         LvwCj+Pn8GwzNEaw5LeB5LBgrnVjNZOquUQKxkqTy+uEv6Zpyy4l7QjqLpBX1gh0jZ05
         p/z4iDLh5WyNPFf5Gtz7MIDmuYMOPzFzSkC+AG5j184p2aH6LHtLK8LgRjJbd0QZkbJe
         5r461p3BE58cqxprJM44yCWLGsCHR86inh2NiDCResKJEclJ8x0aX/ELKyVzZmvL5Rgm
         p6IxuRS6bV0gCtpjcXhzcZ4VuP60gzc50GhaPT91CKOOw0JJCpbKmL5SxMmLN16MGREx
         t2dw==
X-Gm-Message-State: AOJu0Yy7c0fU1hTkaxbvbpZw4IxXg1RGa0Lzr+m9DZwP1+nEgjrJJN3Y
	Tcf2FyVZWQpysF3QCzDFJqT+17MCZKbvmarGdWA=
X-Google-Smtp-Source: AGHT+IG1IoxGOdlvIsbi6PiESNZk4zXqAR70hoxoWNSTSt//UbCeW8udyzVcIuBpsVlTsNxAKlZ/XA==
X-Received: by 2002:a05:6a00:244b:b0:693:3851:bd98 with SMTP id d11-20020a056a00244b00b006933851bd98mr4264853pfj.2.1698444643600;
        Fri, 27 Oct 2023 15:10:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id j8-20020aa783c8000000b00690b8961bf4sm1912884pfn.146.2023.10.27.15.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:10:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qwV2N-004n9d-1L;
	Sat, 28 Oct 2023 09:10:39 +1100
Date: Sat, 28 Oct 2023 09:10:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, djwong@kernel.org, mcgrof@kernel.org,
	hch@lst.de, da.gomez@samsung.com, gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page size
Message-ID: <ZTw1X3YdOmBmM+hQ@dread.disaster.area>
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026140832.1089824-1-kernel@pankajraghav.com>

On Thu, Oct 26, 2023 at 04:08:32PM +0200, Pankaj Raghav wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size (Large block sizes)[1], this will send the
> contents of the page next to zero page(as len > PAGE_SIZE) to the
> underlying block device, causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")

I forgot to mention - this fixes tag is completely bogus. That's
just a commit that moves the code from one file to another and
there's no actual functional change at all.

Further, this isn't a change that "fixes" a bug or regression - it
is a change to support new functionality that doesnt' yet exist
upstream, and so there is no bug in the existing kernels for it to
fix....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

