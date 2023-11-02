Return-Path: <linux-fsdevel+bounces-1883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CFF7DFB97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C646281D1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBAD21A09;
	Thu,  2 Nov 2023 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xoN5XwRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFD21A13
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 20:32:48 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECDD19E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:32:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-778927f2dd3so73523285a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698957165; x=1699561965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34CPHx89bwh8qwgk3q1mguUkvTQjj2rMimJifw5cT9U=;
        b=xoN5XwRHizRVuDGtxHnUGiYF1iLNL7fuXG/VIXZAPfXcV4XA3EDE9kwHH5ByjKXK4P
         5nHKIIrrzkgA97BJWkoa059SQnaiSb501sBz4HnxGOZC4VCIH63rBiEtHvsuENTyny2K
         KnP3/MUTgHrcosu4MsxjTwEa0qruDbM72ewCN2U78ZOYj3PrqydVuIkZm5OQbsJ7wTc2
         d+s5+shd229oJKWSwxlUQIFwAoFGX3aRjmeBNkz4kECdMQ0Gqd95onkCnkEvLLhN8WDQ
         HI/uLf2eTRbnk5GrDES45prHq/ZrY1EtJy6uOwFIyeTyuuxebI39kQGnKdVr7sE5Kjlm
         e7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957165; x=1699561965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34CPHx89bwh8qwgk3q1mguUkvTQjj2rMimJifw5cT9U=;
        b=iKhgtiCR22qYEPgQm24RS2qGBUg8gurE0/3dIvp1VrPZpvhT0q3TmuTnUkfRx1FFdK
         VVPT1WOhO/GeO3qE+akDhVAFHKnfw5XLHaAzYLqVDC8L02jfUVY7DaOR42F5MFVKsIKr
         P1vWSb8dvozrnN3VErCBfsR/GdPBWn97frKmJlNNqcP+WLDeJXHK2Fyfxy1gdramz174
         rz3JcDiwI9QelX7r7CjiUH49ToPL0PbPG1UWzYU4eynNbLyDrqm2A0xtz2y1KXG9dz+G
         rkU/SheinH8DVhAOmoHjsoeTFz1MWNBRUjQa8Ni9ysR77T+gQd+70eoIfcdnzymqCHnm
         aefw==
X-Gm-Message-State: AOJu0Ywn+KLmaZXiT89MHrIxjwbTSElI9IOgqPKFPiQ7apowCfu7pH+O
	gg2IO3+sJJwYxTNMI1uLp3QMsA==
X-Google-Smtp-Source: AGHT+IFIQplKj+X0E7szuk90OCKyxC+AYKJdaylmw5GUDC4mFzLeB8eRJWkAA9eAYLGe6Fu3s64l2A==
X-Received: by 2002:a05:620a:bc8:b0:77a:5112:c1ef with SMTP id s8-20020a05620a0bc800b0077a5112c1efmr5966040qki.1.1698957165464;
        Thu, 02 Nov 2023 13:32:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a144a00b0076cb3690ae7sm91589qkl.68.2023.11.02.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:32:44 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:32:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102203243.GA3465621@perftesting>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
 <20231102170745.GF11264@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102170745.GF11264@suse.cz>

On Thu, Nov 02, 2023 at 06:07:45PM +0100, David Sterba wrote:
> On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> > On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > > Thanks,
> > > 
> > > Just in case you forgot about it. I did send a patch to convert btrfs to
> > > the new mount api in June:
> > > 
> > > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > > 
> > 
> > Yeah Daan told me about this after I had done the bulk of the work.  I
> > shamelessly stole the dup idea, I had been doing something uglier.
> > 
> > > Can I ask you to please please copy just two things from that series:
> > > 
> > > (1) Please get rid of the second filesystems type.
> > > (2) Please fix the silent remount behavior when mounting a subvolume.
> > >
> > 
> > Yeah I've gotten rid of the second file system type, the remount thing is odd,
> > I'm going to see if I can get away with not bringing that over.  I *think* it's
> > because the standard distro way of doing things is to do
> > 
> > mount -o ro,subvol=/my/root/vol /
> > mount -o rw,subvol=/my/home/vol /home
> > <boot some more>
> > mount -o remount,rw /
> > 
> > but I haven't messed with it yet to see if it breaks.  That's on the list to
> > investigate today.  Thanks,
> 
> It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
> subvolumes with different ro/rw options"), the functionality should
> be preserved else it's a regression.

I'll add an fstest for it then, I could have easily broken this if I didn't see
Christians giant note about it.  Thanks,

Josef

