Return-Path: <linux-fsdevel+bounces-1365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0EE7D998D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073962824D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56091EB33;
	Fri, 27 Oct 2023 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="K1r8e1Fe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FED1EB23
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 13:17:39 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA31BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:17:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7789cb322deso154876585a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698412648; x=1699017448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfz2Bqs5iMW7RXtRSpeD8StEjBYEn/6IXOAwCBucGLc=;
        b=K1r8e1FeR7Q5UC+xd6wvRiPCgY832yvvN8W/S55POL8SshumYtf/OdUC/WH75XVDZX
         +501ktg9o9NDSw7qwq3I2UiIAFv5y66HZz6f71QOQuOtX4J9M6fII4/DZNvWbc2vUGRy
         GPjeSC1JhsnOaJGDlWwW2OGiiIcUMKCZOQyPTtiCO4fTTNC0JsK9MVdK0EYHPlys8SLP
         oOg0EWP+nIe0sRO67zXa9QgjuLLbo19HHWcEQ2jzZ6VpS4RmfQ+NihUQLKCIDSEmMqHR
         zaTJXR7G3C6G0HG1Jd0gUheMVMkbS+AVWrhZwP/TiEoMhclbHnMqiqJmsWtFxLsL0nZS
         hvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412648; x=1699017448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfz2Bqs5iMW7RXtRSpeD8StEjBYEn/6IXOAwCBucGLc=;
        b=ek6cUu5mDsMl9cvPAcco7TZBGO69Zl+GfKbP7wfkWJK151aDLmhlc2SNh/EFeDVyWg
         G5RDhwwMCj0JhQdb1x+zu2SP3xuvwH6boWjANV7PV8HYzBHvpqKu1eftiMZazGJKdg2N
         ZUcMjQQAN5kJGxH7WXt20wDyMtKTg3aBeTgS7NHbmJ7Mmxo3Op2fTMV5EbKn8yK1uKsy
         w8hxevCg08VPGknXYSJos4VOH0JmeWxE1vdPp2sd2w644G8wqLy83GNS69ZkE+lpZWEN
         YF8dfL053s5MWA6te9Rz/2VnQinvXBommmub8Y7pZnkejl3Sw/GyeHw3YjGrFd4qg2tn
         0hwQ==
X-Gm-Message-State: AOJu0YyzuCxsYaXdCSggU67VXphzA7siTm64KgB3uQRrpHdmOGoNTp1/
	+nkgK34h+pNiriPMM0N3Cllkaw==
X-Google-Smtp-Source: AGHT+IH7/ohkWLF0+aCKgnhC2MdbpmoBu18H1F3h/HjHu/1SCtZzSSZKky/PkY5gCI2oXZZwMFd3oA==
X-Received: by 2002:a05:620a:d8a:b0:778:8f9c:38e8 with SMTP id q10-20020a05620a0d8a00b007788f9c38e8mr2682344qkl.37.1698412648072;
        Fri, 27 Oct 2023 06:17:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05620a468e00b0076c8fd39407sm521741qkb.113.2023.10.27.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:17:27 -0700 (PDT)
Date: Fri, 27 Oct 2023 09:17:26 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231027131726.GA2915471@perftesting>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTtOmWEx5neNKkez@infradead.org>

On Thu, Oct 26, 2023 at 10:46:01PM -0700, Christoph Hellwig wrote:
> I think you're missing the point.  A bunch of statx fields might be
> useful, but they are not solving the problem.  What you need is
> a separate vfsmount per subvolume so that userspace sees when it
> is crossing into it.  We probably can't force this onto existing
> users, so it needs a mount, or even better on-disk option but without
> that we're not getting anywhere.
> 

We have this same discussion every time, and every time you stop responding
after I point out the problems with it.

A per-subvolume vfsmount means that /proc/mounts /proc/$PID/mountinfo becomes
insanely dumb.  I've got millions of machines in this fleet with thousands of
subvolumes.  One of our workloads fires up several containers per task and runs
multiple tasks per machine, so on the order of 10-20k subvolumes.

So now I've got thousands of entries in /proc/mounts, and literally every system
related tool parses /proc/mounts every 4 nanoseconds, now I'm significantly
contributing to global warming from the massive amount of CPU usage that is
burned parsing this stupid file.

Additionally, now you're ending up with potentially sensitive information being
leaked through /proc/mounts that you didn't expect to be leaked before.  I've
got users complaining to be me because "/home/john/twilight_fanfic" showed up in
their /proc/mounts.

And then there's the expiry thing.  Now they're just directories, reclaim works
like it works for anything else.  With auto mounts they have to expire at some
point, which makes them so much more heavier weight than we want to sign up for.
Who knows what sort of scalability issues we'll run into.

There were some internal related things that went wrong with this when I tried a
decade ago, I'm sure I could fix that by changing vfsmount, so I don't see that
as a real blocker, but it's not as straightforward as just doing it.

I have to support this file system in the real world, with real world stupidity
happening that I can't control.  I wholeheartedly agree that the statx fields
are not a direct fix, it's a comprimise.  It's a way forward to let the users
who care about the distinction be able to get the information they need to make
better decisions about what to do when they run into btrfs's weirdness.  It
doesn't solve the st_dev problem today, or even for a couple of years, but it
gives us a way to eventually change the st_dev thing.  Thanks,

Josef

