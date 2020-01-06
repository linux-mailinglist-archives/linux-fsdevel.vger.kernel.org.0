Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39201311A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFLzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 06:55:18 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35639 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:55:18 -0500
Received: by mail-wm1-f54.google.com with SMTP id p17so14994337wmb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 03:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfsdYKG1B5YfyLA7EncgtcPx7R6mbN28iX2+mpEAViM=;
        b=fy2gxKwgmj6sxUXu8xJRjwvB9rdIPnmdwno9jwhaTHOpNy2/0ckNCkWsRg6ZpEl7Ez
         GKhMlbxqW154RPZMAMiPzt8AjLzykxLQiiJXuQYmsrwIS1iDL2vf9WYXqLh1Zn6RSz1L
         MMckYjYTLGhJtBhIFYjgZvJU25joDtLAnBLoMJnRuwwi35d/EFViL1O1GRZg7dqHB+9D
         ACFIMCZKaoIhOd0gmHgFEJwsmzobHh2PKn4o/yCctM5ZBCUD74a3kzL2/TLGE9XkHUUe
         dhdpNV5j6XXxJGyXKUnSWzj7r3h0UVtnen2W6EVPYOJjBYuecCRc4eCMo1BGGXDPVY/S
         1exQ==
X-Gm-Message-State: APjAAAWRswfX01RAT2drxLT8GT33SnUsXsHwtWGOQie0nxc76YYbBCfI
        ajgX4tdtvGdxl5O+a5P9U7ib531S
X-Google-Smtp-Source: APXvYqwxHzCj74ZfnUMnk1W6z0J80qvpWYWsFB0rX9rW1LacihajjibeIJqXzILqqPnhSJ2mOM6b+Q==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr34374696wmj.36.1578311715649;
        Mon, 06 Jan 2020 03:55:15 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id p17sm73071586wrx.20.2020.01.06.03.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 03:55:14 -0800 (PST)
Date:   Mon, 6 Jan 2020 12:55:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200106115514.GG12699@dhcp22.suse.cz>
References: <20191231125908.GD6788@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231125908.GD6788@bombadil.infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> 
> I don't want to present this topic; I merely noticed the problem.
> I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> thread here:

Thanks for bringing this up Matthew! The change in the behavior came as
a surprise to me. I can lead the session for the MM side.

> https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> 
> Summary: Congestion is broken and has been for years, and everybody's
> system is sleeping waiting for congestion that will never clear.
> 
> A good outcome for this meeting would be:
> 
>  - MM defines what information they want from the block stack.

The history of the congestion waiting is kinda hairy but I will try to
summarize expectations we used to have and we can discuss how much of
that has been real and what followed up as a cargo cult. Maybe we just
find out that we do not need functionality like that anymore. I believe
Mel would be a great contributor to the discussion.


>  - Block stack commits to giving them that information.

-- 
Michal Hocko
SUSE Labs
