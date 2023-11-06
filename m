Return-Path: <linux-fsdevel+bounces-2184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE387E2FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE98F1C20850
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A11D69D;
	Mon,  6 Nov 2023 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Gj4cpOIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB738E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:42:13 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EFBD51
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:42:12 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d190a8f87so32324686d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699310532; x=1699915332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh4u9lQwcTBmzRwQYOONZw1QExGbYz2ed9uS0nODmN0=;
        b=Gj4cpOIFNZRTzGJK6DSxt+fqBPLlSG99yiCcosFJftu9dGP0IADLA4be+hl9vVsGYQ
         d8dsoDUrgkL6iMciv0Kld5W5dnDMYTXcPFQItoZmrzEXD0lV/1u5k+tBsgfh4Th9TMGx
         Mhv99MCS2NOw74TW+AfZO6TW4nFtI0hpjKmeNThpxsgsO67T2lAIELlm7EvFA7qniocp
         5FaKL+fjdElOC67EStIpjzAOV8GIqAdvh2WblLQDEYIFdQjfvcxskg53QOYfItQeRRTL
         LO09dShSAQ/Ck9403sEFVNqyYR33kwBMyBqBmGa0MlqRz3r51SaeX5X5ovyq4b+5GwAJ
         iPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310532; x=1699915332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh4u9lQwcTBmzRwQYOONZw1QExGbYz2ed9uS0nODmN0=;
        b=elgiFCF4zlF29JjGYEL0ITI9hCZngNSFwJeLjrsOjCdNGaYTOMzt07jt6vlIzJzUl6
         3sUEcr6v5yGbhBI8Ta2VVq4Q91CNuHPtbuJgOqJLmJI6Fsl/5Le9Z8k8QB1s96qV3UNx
         JYt3CWamksB3II9j1v+cKXAiAX5e84gaLlqJUT3wsL/Tlg4EHozPDUZlE6LJJkQLZu3Y
         2JmjKDXN5IHhqgEeqvtK6h6cO/SRSjVURc15cPDkCWf6K9sNQPc04P/RfX0MW0HZQNkB
         EOzQ/ia4CN8LLEaiC0H0oKCVEgoP4O+dtcLhvPWCt1xid3RFK7l4jvohLQ0l7KgLuIX8
         I/eA==
X-Gm-Message-State: AOJu0Yxz1CEPtEJZ4TjkJhvXrYZI9xKV/B/yUMQYyequiYShIjyIjO90
	KOj5ZtakPBv4LZmJIvpJD9rPhA==
X-Google-Smtp-Source: AGHT+IE1BxGrUrgmYdZ4xKqxUp8ea8KUUcrhOF2gcRjFuJLv0yBe7E6hyFa7RnF2hITxbs50SL/EXw==
X-Received: by 2002:a05:6214:501c:b0:66d:20f7:8d8d with SMTP id jo28-20020a056214501c00b0066d20f78d8dmr42120778qvb.28.1699310531808;
        Mon, 06 Nov 2023 14:42:11 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e16-20020a056214111000b00670a8921170sm3838537qvs.112.2023.11.06.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:42:11 -0800 (PST)
Date: Mon, 6 Nov 2023 17:42:10 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106224210.GA3812457@perftesting>
References: <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUker5S8sZXnsvOl@infradead.org>

On Mon, Nov 06, 2023 at 09:13:19AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 06, 2023 at 02:47:16PM +0100, Christian Brauner wrote:
> > Granted, an over-generalization but non in any way different from
> > claiming that currently on one needs to know about btrfs subvolumes or
> > that the proposed vfsmount solution will make it magically so that no
> > one needs to care anymore.
> 
> I don't think any one has claimed "no one" needs to care any more.  What
> the vfsmounts buy us that is that software that doesn't know and
> should't know about btrfs subvolumes isn't silently broken.  Software
> that actually wants to do something fancy with them always need special
> casing.

Again, this is where I'm confused, because this doesn't change anything, we're
still going to report st_dev as being different, which is what you hate.

You pointed out above that user space thinks that different st_dev means
different inode space.  That is why Chris put the st_dev hack in, because rsync
got confused, and this made it not confused.

So we're actually doing exactly what user space wants, letting them know that
they've wandered into a different inode ino space when they cross into a
subvolume.

But that's the crux of the problem, new subvolume == new inode number space.
I'm not changing this.  I don't think you want us to change this.

We want to let user space who don't care to know about btrfs be able to
operate cleanly.  We have that with the st_dev hack.  Changing to vfsmounts
doesn't fix this.  Userspace doesn't know it's wandered into a new directory,
and in fact if you look at the rsync code they have a special python script you
have to use if you want to exclude bind mounts, which is all the automount thing
would accomplish.

At this point I don't care, tell me what you want me to do so you'll stop
complaining anytime we try to expose more btrfs specific information to user
space and I'll do it.  I'm tired of having this argument.  You would have had
auto mount patches in your inbox last week but it took me longer to get the new
mount api conversion done than anticipated.

But it doesn't appear to me there's agreement on the way forward.  vfsmounts
aren't going to do anything from what I can tell, but I could very well be
missing some detail.  And Christian doesn't seem to want that as a solution.
Thanks,

Josef

