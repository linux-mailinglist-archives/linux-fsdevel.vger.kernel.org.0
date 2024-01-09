Return-Path: <linux-fsdevel+bounces-7671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C775A828FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 23:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D682833D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492353E46B;
	Tue,  9 Jan 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="v4dmi3Pe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F03DBA1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1533466a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704839013; x=1705443813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTaJ7F4UvxTDYLwb0WtqTx+At6efRtBZFNZppNwGZ4o=;
        b=v4dmi3PeHedFlxj5MN0GxY+JUYC7smfDF5oiKO9ZSBRwdXsEdaCJ+jx2r0OxPqtcGR
         cAuWOaEL135A7dfGfP0QyGa30g7Mb3djr3an/KtjgIjrCpDQbGRVYN3qwsvsdgUj0JEy
         aASsIlfknqfn4+FVfJnP5FhWhg2qsEjxjQiCNrLGEofpMzaqLi7MWUVFyiPnz+cW/uzG
         V9MKv1z4D4qaGjLqzpEWMG7OPjqg1KP7vY8qSWItJukYXiT5bH0SgL9bcIcK8WQG0tMe
         3fOHghG43tyHr6N38uBy8dwr5fbiCiEP4XpR0zbdlajkO7i7AsVFaWUYVg2hO+294ADS
         OYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839013; x=1705443813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTaJ7F4UvxTDYLwb0WtqTx+At6efRtBZFNZppNwGZ4o=;
        b=qADcPPJWRyVEp2D/JiO46w/5ge10rii8H/kMXSSq32m1SxO71+rUk3JhHwtJcIKhhZ
         yf2SNWQiAPcyVcTQVPziYNg6zUQCA96M+BznVxQrEKF2ynaNLg6t/Y23y4YsrIC6mf3v
         Odkx1+keZa6QmOg54ld/BBEFquVbi/PZaUs6G0ZBdCuwGWSrNE6oUj8ZLoQ9hbJgTShb
         3OdjWsZ2RbaBTS06d7GFGOYHteQQjKiS0A+YLP6qAinVN/Neoy0PXbvvAefwK7WNI879
         xrQ2vAxWs4aOdeWa3oarh0pOdV+EywYy7p6Am4vA4KV4w9f8QpI+xEgpj0EDM7abuvn5
         Pxew==
X-Gm-Message-State: AOJu0YwxuSbD9oZw2zCfmYpol1FT2SwLRmuCYCkcIgLOnh23CfZGQMsj
	qHH591umro0J+scK32369peC/6wzDKBo7g==
X-Google-Smtp-Source: AGHT+IHwxs6hfy7c10y/Z2WOv2jOl6yN4BZqONuQsBTiNNd0jqVThjnDnXUFG2w0+QL/HodxmXR+Zw==
X-Received: by 2002:a05:6a21:339d:b0:199:c372:d775 with SMTP id yy29-20020a056a21339d00b00199c372d775mr10071pzb.91.1704839012809;
        Tue, 09 Jan 2024 14:23:32 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id ns14-20020a17090b250e00b0028c2de909e4sm2574940pjb.50.2024.01.09.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:23:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNKVN-008FeO-0H;
	Wed, 10 Jan 2024 09:23:29 +1100
Date: Wed, 10 Jan 2024 09:23:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZ3HYUR85iIEJiGX@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <20240105105736.24jep6q6cd7vsnmz@quack3>
 <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
 <20240108173928.GB28693@twin.jikos.cz>
 <b5bc1e72-72ea-4b67-86a1-3d41deb5bc72@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bc1e72-72ea-4b67-86a1-3d41deb5bc72@wdc.com>

On Tue, Jan 09, 2024 at 07:43:54AM +0000, Johannes Thumshirn wrote:
> On 08.01.24 18:40, David Sterba wrote:
> >> 199 - btrfs
> > 
> > All the easy conversions to scoped nofs allocaionts have been done, the
> > rest requires to add saving the nofs state at the transactions tart, as
> > said in above. I have a wip series for that, updated every few releases
> > but it's intrusive and not finished for a testing run. The number of
> > patches is over 100, doing each conversion separately, the other generic
> > changes are straightforward.
> > 
> > It's possible to do it incrementally, there's one moster patch (300
> > edited lines) to add a stub parameter to transaction start,
> > https://lore.kernel.org/linux-btrfs/20211018173803.18353-1-dsterba@suse.com/ .
> > There are some counter points in the discussion if it has to be done
> > like that but IIRC it's not possible, I have examples why not.
> > 
> 
> At a first glance, storing the nofs scope in the transaction handle like 
> Filipe proposed sounds like a good idea to me.

That's exactly what XFS has done for the last couple of decades. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

