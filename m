Return-Path: <linux-fsdevel+bounces-1821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED17DF289
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF223B210F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123318E2F;
	Thu,  2 Nov 2023 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0h7hv6aG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48318E17
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 12:34:52 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869C19B3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 05:34:50 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so315134241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698928489; x=1699533289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2c34fKw/9t7JAP3kNbJzjzeexVOlerIjyNZal3u1tAQ=;
        b=0h7hv6aGOzpKjDRBtrkPHqrYAUBIEbi8FFM4ik1YI7ygYpi7PEW9cXHc1xqowUJ7PI
         JFraYsgDaXl5Joq6eiv0tCnqovvbCIJnvPz7EanZbaiusEHkI7psGgZZJssqkmGtk0e2
         PPNDBe87NN6tT2m7yTA8VDnWNoTt/dvCWx/NLcyjZev+Zv6OUi28AkgOrIIlYj4Ya3Hk
         n/Af51JGgL+A8r5r0aZNRsE8xKSvEzZKyAxvJodtLWWEM6hVkLj0aJTWkx+DRM6PpVJI
         bkkQ5MYMyg0WDOLM1OKNILpRkL6OUB+y65elQOCxP2qKVR/WX1zQX9JGcdV6PocG/4zV
         kT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928489; x=1699533289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c34fKw/9t7JAP3kNbJzjzeexVOlerIjyNZal3u1tAQ=;
        b=pnnpz/q3X2WTnzK9+TGg1u0gQWUKogOoDq818Y/N//71oMlkykfqg3fF9/rTaJ8tvq
         aHHbQxhB9bhL0KzkN9TEMptCqM+6651JGbuq6FhLosuZ+9bsIq9c6htekzeKTsMKlP6I
         OcQjm2yEAQ6OXxACdBmSlcKX6GIgi+mumMPyXCQG+bH+8Ft8btdAo3W+PdIZoEMs8WLW
         hlxcBgrwD9qGnodqCR/63iq6o1+5xIyPo5SENaoEKNUykjAoYnKqr4+7vv8XZESR4YwX
         JhUmJgMJ/gawLXdiVs4f+SjMaNhHG2qjNdLzRMYbckQyKTzpdJgK/i+1iLK0JZmLjWYT
         v4Fg==
X-Gm-Message-State: AOJu0Yz40mfDc+uXpCsXI3xOzutCeeY2MRnq9h6oyGGx/XvvWMyRHt0R
	6KNhiUXzNAsUukGuVm4tPbNgYAKrK55OmnXiqu6sdw==
X-Google-Smtp-Source: AGHT+IFLpof8u4AiPvmB/KBJkXrg7+KlDfo/GoxQzMtQwyJ3Ov65fn+BZKeQMD1aZ/DForcLRBD4LQ==
X-Received: by 2002:a67:e092:0:b0:45d:56e0:7178 with SMTP id f18-20020a67e092000000b0045d56e07178mr2029493vsl.2.1698928489698;
        Thu, 02 Nov 2023 05:34:49 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w4-20020a0562140b2400b0066d132b1c8bsm2312706qvj.102.2023.11.02.05.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:34:48 -0700 (PDT)
Date: Thu, 2 Nov 2023 08:34:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102123446.GA3305034@perftesting>
References: <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>

On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > We'll be converted to the new mount API tho, so I suppose that's something.
> > Thanks,
> 
> Just in case you forgot about it. I did send a patch to convert btrfs to
> the new mount api in June:
> 
> https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> 

Yeah Daan told me about this after I had done the bulk of the work.  I
shamelessly stole the dup idea, I had been doing something uglier.

> Can I ask you to please please copy just two things from that series:
> 
> (1) Please get rid of the second filesystems type.
> (2) Please fix the silent remount behavior when mounting a subvolume.
>

Yeah I've gotten rid of the second file system type, the remount thing is odd,
I'm going to see if I can get away with not bringing that over.  I *think* it's
because the standard distro way of doing things is to do

mount -o ro,subvol=/my/root/vol /
mount -o rw,subvol=/my/home/vol /home
<boot some more>
mount -o remount,rw /

but I haven't messed with it yet to see if it breaks.  That's on the list to
investigate today.  Thanks,

Josef

