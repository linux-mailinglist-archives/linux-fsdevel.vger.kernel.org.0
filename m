Return-Path: <linux-fsdevel+bounces-4957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1C806C48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360301C20984
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980AD2DF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gpERkhv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E310C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 01:13:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c66b093b86so527187a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701854005; x=1702458805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6kf2y7bAp6mjq0zetlI4hRhT2xVJNGrhrzA1HJKDPA=;
        b=gpERkhv/+oTpI7XNlBMfqZ0ORKXtIFGmPfHLK1fZlyGVMyCYcJ39UCeIyKLRRn5wPm
         Tb21vfzg8zmt9MkCW0UM7ivkmIIFgiUdPpeB6a+A9cOtpVHieQLpx0FtUJjEqoxd6LH8
         7FLT2gRDdW9tkgxRUB/Lcw4E3C4UiS73TCk5Ozk8ElKDcS3tqQOaj9EqycI/BzlvqNgJ
         tNbvzSNc8KsYenz5jtMW52OuA5ZHvSAudHJCxeMJPzXL36PrQ3sn+4CyJIExdLTRbKiA
         pxq8qk/6GTth7kQP7qwX2wU5QS2m7CoCZZhvhwEmCFf+qDEapILyxcBMPnaKwQBUTo2G
         PERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701854005; x=1702458805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6kf2y7bAp6mjq0zetlI4hRhT2xVJNGrhrzA1HJKDPA=;
        b=pGYhT8gMyeXuDG77TgXZRBx7rOTSDX7rvTu+JE0sNAv1OBGPMLgqMXX5DDomczSpPJ
         R4AICJRVkSHmqINe7RCGKTekobHLzG+VQ4LurMwvV8kYHyTOKYFFs7qG+l4gjYJsSzj6
         nRMSKwtYOkgGKOoH6xmvu6WlK11Zk97qFCxFeJ2wkg6ZtJz0IjB0mYSD3Jp27lSA/G8Q
         Iw4GAZGYJlhpK7jmRv1p3WFVywKOwWUhfmrU+xaJkAUqI2chKzg6jSf5BpVDIMpQeO0t
         +bDDogglMNVhV2MrXO12jIqrFHCjZWxYbiyaZrw3xVFzpmETYjpNWR9UCya9cYY5/CfC
         gV+A==
X-Gm-Message-State: AOJu0YxTOnah+tXZxlZQrESmUTVXXZbJsOdxfvT2eGmZy9JgPmqO0pv2
	wBlGu8vaXZhy4eTeQe0cEviMlg==
X-Google-Smtp-Source: AGHT+IHcBVRbTw4fV4raK+5NTdQ/G9rfuq6/QM54MrQz5eNuxhHvE6/ewBaWanYphDgB22PdR9N4Fg==
X-Received: by 2002:a17:90a:c095:b0:286:7529:3598 with SMTP id o21-20020a17090ac09500b0028675293598mr3090956pjs.13.1701854004624;
        Wed, 06 Dec 2023 01:13:24 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090270c300b001cf6783fd41sm11658432plt.17.2023.12.06.01.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:13:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rAny5-004YwT-25;
	Wed, 06 Dec 2023 20:13:21 +1100
Date: Wed, 6 Dec 2023 20:13:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
	paulmck@kernel.org, tkhai@ya.ru, vbabka@suse.cz,
	roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
	tytso@mit.edu, steven.price@arm.com, cel@kernel.org,
	senozhatsky@chromium.org, yujie.liu@intel.com,
	gregkh@linuxfoundation.org, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 42/45] mm: shrinker: make global slab shrink lockless
Message-ID: <ZXA7MS+p/YjrN4Lj@dread.disaster.area>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-43-zhengqi.arch@bytedance.com>
 <CAJhGHyBdk++L+DhZoZfHUac3ci14QdTM7qqUSQ_fO2iY1iHKKA@mail.gmail.com>
 <93c36097-5266-4fc5-84a8-d770ab344361@bytedance.com>
 <CAJhGHyBJiYOQGY3t=Lpe4A-rmJML8Mn8GC35GkrQ6Us082ZTAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBJiYOQGY3t=Lpe4A-rmJML8Mn8GC35GkrQ6Us082ZTAQ@mail.gmail.com>

On Wed, Dec 06, 2023 at 04:23:24PM +0800, Lai Jiangshan wrote:
> On Wed, Dec 6, 2023 at 3:55 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > On 2023/12/6 15:47, Lai Jiangshan wrote:
> > > On Tue, Sep 12, 2023 at 9:57 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > >
> > No, this_shrinker will not be removed from the shrinker_list until the
> > last refcount is released. See below:
> >
> > > rcu_read_lock();
> > > shrinker_put(this_shrinker);
> >
> >         CPU 1                                      CPU 2
> >
> >    --> if (refcount_dec_and_test(&shrinker->refcount))
> >                 complete(&shrinker->done);
> >
> >                                 wait_for_completion(&shrinker->done);
> >                                  list_del_rcu(&shrinker->list);
> 
> since shrinker will not be removed from the shrinker_list until the
> last refcount is released.
> 
> Is it possible that shrinker_free() can be starved by continuous
> scanners getting and putting the refcount?

In theory, yes. In practice, highly improbable. i.e. I don't think
this will ever be an issue because the timing conditions for memory
reclaim to keep a permanently elevated reference count on a shrinker
for a subsystem that is being torn down are -highly- improbable.

And even if you could pull it off, who cares if shrinker_free() is
delayed? It's a teardown operation meaning the subsystem using the
shrinker will no longer be in use so the latency of the teardown
operation is largely irrelevant to whatever is still running
on the system.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

