Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B14353C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 21:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhJTT0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhJTT0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:26:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8DC06161C;
        Wed, 20 Oct 2021 12:24:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u5so567321ljo.8;
        Wed, 20 Oct 2021 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zBVYuwbzU0MrjoGITQu9tBsWZ7nbrws+z0zkrHM73ZE=;
        b=TWJxQV5pYR5GhzFo4ccC4tOo8Wfgvjfb2t4pbpy2+KtzAiCW5plYXo44STxngIpVBg
         I2pO3atCIiMB0X5qiITyxrGa8nKQ14zhgMz+2uj3xT07LbOUKUc7L8cdJshp67Jvz2mx
         E/Q9RzBO4s1JziAjRicKhfSphkeyAPRvn5yTibuokpMIRll6117L6OPPyz0L7nTkEKy1
         dMNWl1WBd6z/rMRsj6kpU22KM1oFvILYESgm0xtQMvE3Y/icJopqJJ2dxlN0NNbu9Ios
         zk6pVsUCYWftFXBIqUFI164dO6N+bA3uZQJ+d3qWROqcMeSNG3R6vk93nHrBGT/ky6IC
         s2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zBVYuwbzU0MrjoGITQu9tBsWZ7nbrws+z0zkrHM73ZE=;
        b=IvF02Peh+V93HZpapsoYQIU/S58RH/eWRqOpeCb90YdZfSfZQxU7ZOz6nIhKGsyR68
         zdS1ZG6l50e+J/Cd0Rigmz7LoiAo0M37SmD39cdd5EZbhhSxU5C9pxYuqQ6wcXXoH8H+
         0XC8VP/fRYst+B3SprxOtPOLCJtW9d6C8G6gh6SrjMHNB7oT9sp6EulpoCExPX445O0z
         NmqRqLOjERFguH/pzH5NmtamErgnoa9qEZVJHj5tkOZTkAVDqLowliF8FwH0bzuE7ch0
         HaDuzLKPufDQrPgXzrzp+3j7n1PWH89i/tapVCVDspIGbc9+bx70qVfOPog+PDuehFPR
         PcjA==
X-Gm-Message-State: AOAM533GjhRu4dbLp0lzj2VSRfPJdM6Ng9HMB/88qWTeYu2SuKti2hP7
        uEUCzVesPnGyz9tiZda5Vbo=
X-Google-Smtp-Source: ABdhPJyrm9VQo0GMaJxs62rwrDCG0Alik60ONtJwaI27umRlQFC625Te5ewPe0yeMXu+xQrVwJXh8A==
X-Received: by 2002:a2e:8e72:: with SMTP id t18mr952563ljk.189.1634757874664;
        Wed, 20 Oct 2021 12:24:34 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id bp25sm260772lfb.64.2021.10.20.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:24:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 20 Oct 2021 21:24:30 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211020192430.GA1861@pc638.lan>
References: <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
 <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan>
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 05:00:28PM +0200, Uladzislau Rezki wrote:
> >
> > On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > As I've said I am OK with either of the two. Do you or anybody have any
> > > > preference? Without any explicit event to wake up for neither of the two
> > > > is more than just an optimistic retry.
> > > >
> > > From power perspective it is better to have a delay, so i tend to say
> > > that delay is better.
> >
> > I am a terrible random number generator. Can you give me a number
> > please?
> >
> Well, we can start from one jiffy so it is one timer tick: schedule_timeout(1)
> 
A small nit, it is better to replace it by the simple msleep() call: msleep(jiffies_to_msecs(1));

--
Vlad Rezki
