Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DB2409E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHJP1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgHJP1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:27:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578FC061787;
        Mon, 10 Aug 2020 08:27:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so5248325pjd.0;
        Mon, 10 Aug 2020 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cd+IPJICvi9NuWsJOzSKX+vyS3Uw46zm7ManV2vz6xU=;
        b=MhKuUzWjWYlxnc4J815mhYCdXurI9S6A0HdHbu6r++lgkAaujJCwMvsxWlvYNJM6ym
         3Jm/4rSSJ25UqqllgmaWJCwT8Qm3LnvlwrjiVuHQyJ+fQ6NMxCW1zJcn+ytAxGiAiHMe
         L2M/5e1zyFKGzXiLenesVoBWuHohr/DGXAlkBVJd1a//SmXMOQNNPY26Zbu0y9q2A9wQ
         tCWNlESutEKlp2OeR4NbZUX8PKj1m4OIbj7AAxp5Ukz7SyPQ4u6KMrfLweq5y7a09Mqp
         czpenWmhGJGFeyha2O7pkx+2/p76/LTSYMkRQEZxEA2O2pVngsSlytR4g2XH+eTm1his
         gu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cd+IPJICvi9NuWsJOzSKX+vyS3Uw46zm7ManV2vz6xU=;
        b=A0X4Fi6bMQ+uf/dsU03QDgagrsJuwk3M3fjS74P8zijMN/LJVY/1ppn/nvGdDVu2E7
         a2+uQ2VH1pH5bjonnytjR8PybjKL+QhP6HreO6RAikUa4IStNimV3ebjq+JYpBeiHPxA
         DI204lYW8TPBZi0MvznGPXZlXrCeHZkPhYcdYNAzaEYiA34R1yOM5m+FsL00OHYn/7cN
         dVsDodolF/kvd5t7IyjXbIEaIQJ6xvKuBO0Xt3YhaK9WBOKuAvZkA1A7Fscwg5gBTgE+
         AZSmH+alDsXEsrMgH6rKIsvaLGxxrOJwVpgBSrodJw+tr/do7WL/r+tIxRf6TIFn7R3t
         UQ3w==
X-Gm-Message-State: AOAM533hSQS7lKFKjItB9QbN0dSogwOIbFD7oFB7xd8iYEn6am3Qccrq
        Q8rk4oB4Ek1b+zG4I0TmV3Y=
X-Google-Smtp-Source: ABdhPJwRbwAErii7zA3EI+YRxvEgtnR3zmPGYQ6lAsvRtoYFwyV+65gitvEN5F+f7bXNbYIQN7N0Eg==
X-Received: by 2002:a17:90a:a590:: with SMTP id b16mr17299631pjq.131.1597073231782;
        Mon, 10 Aug 2020 08:27:11 -0700 (PDT)
Received: from eug-lubuntu ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id s125sm25195270pfc.63.2020.08.10.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:27:11 -0700 (PDT)
Date:   Tue, 11 Aug 2020 01:27:00 +1000
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200811012700.2c349082@eug-lubuntu>
In-Reply-To: <20200810150453.GB3962761@kroah.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
        <20200810150453.GB3962761@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 10 Aug 2020 17:04:53 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:
> How many syscalls does this save on?
> 
> Perhaps you want my proposed readfile(2) syscall:
> 	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
> to help out with things like this?  :)

The proposed readfile sounds great and would help, but if there are
1000 processes wouldn't that require 1000 readfile calls to read their
proc files?

With something like this the stats for 1000 processes could be
retrieved with an open, a few reads and a close.

> 
> > The proposed files in this proof-of-concept patch set are:
> > 
> > * /proc/all/stat
> 
> I think the problem will be defining "all" in the case of the specific
> namespace you are dealing with, right?  How will this handle all of
> those issues properly for all of these different statisics?
> 

Currently I'm trying to re-use the existing code in fs/proc that
controls which PIDs are visible, but may well be missing something..


Best Wishes,
Eugene
