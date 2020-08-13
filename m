Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0875243C17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMPBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:01:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30952C061757;
        Thu, 13 Aug 2020 08:01:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so2953367pfd.2;
        Thu, 13 Aug 2020 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7E03oNbQL5OmaCxbJGHTzh+uQv70s9+Kim5awpFIOQ=;
        b=dqTYbUrYs0mBd8e3EbKh+zqOEvsS/8R4soFxtxGns5xFEKS2qbbYYRqAvq5km43kE+
         hF6fNHIq2pMYlnPkoPrXaVMbJn/fLpcI8e2eoublbPhy6XrUp4xTK/A+2EOd+b4HfF1E
         FRl5AR08bNBYsPyUGaKAzu2vnDHz8qTOT0HG3qutkadMxyFZ3UtMrVasxMXiW+iMHKAj
         1ab3xKURjjrzUMt3E4otiI3sKdi5/rWteLVhR9b/08zKSGGYybGekkF0nCtBVjlHig2D
         54rku8msIu9QGfO4TT1Chy2tMuJzHErngz+NLOCctQqKSylPofQ9qPoGNz8t8buZrPws
         ELqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7E03oNbQL5OmaCxbJGHTzh+uQv70s9+Kim5awpFIOQ=;
        b=Tkg2mXS2zk4F4zG5xQJtJcw+2Te9QqeZ7AkvuhBau641ltRFGyrdIj3vYE+8i33W04
         U0urJTZrxDcsDkiaA4k+/Ae2dStKIh9UKzCTAIPTTF2CrvPWeVLXuPyloizjGl5+mdH5
         D+UwGSGvSUlYEA53XWZU0C+sBCRV7OQeDXqUfVt6Q3ASfWxbwLoSyd10QrXziPtFuOa/
         zaDRHubV4faQ5MOGNWphLxLvzEr/6I/XlLGoV7PeLMql+88BIZpV1Jx64lvUpATvtAmQ
         B91lLewLaq/9t9D2Cul0vybXpW8KPtD3YY8goti2oW4/wDKRMZlGvQv9S9gN3P5tZAwS
         6tOg==
X-Gm-Message-State: AOAM532DMuTzUfPKf1M/11lAUhMRfqjkwUGv+R7nKPQy8DuFJWvoF4gg
        ol+6hUYQv/khsKeYond0H1k=
X-Google-Smtp-Source: ABdhPJzkmNJegWshCR53AYdFRG7i7LcGbOjQXWctMKCqdTAZwQjsckpLduH02hCIf4HYxkwpyAo0pQ==
X-Received: by 2002:a63:2546:: with SMTP id l67mr4104702pgl.281.1597330868752;
        Thu, 13 Aug 2020 08:01:08 -0700 (PDT)
Received: from eug-lubuntu ([203.63.226.116])
        by smtp.gmail.com with ESMTPSA id h15sm5840666pjf.54.2020.08.13.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:01:08 -0700 (PDT)
Date:   Fri, 14 Aug 2020 01:01:00 +1000
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        dsahern@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200814010100.3e9b6423@eug-lubuntu>
In-Reply-To: <20200812075135.GA191218@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
        <20200812075135.GA191218@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Aug 2020 00:51:35 -0700
Andrei Vagin <avagin@gmail.com> wrote:

> Maybe we need resurrect the task_diag series instead of inventing
> another less-effective interface...

I would certainly welcome the resurrection of task_diag - it is clearly
more efficient than this /proc/all/ idea. It would be good to find out
if there's anything in particular that's currently blocking it.

This RFC is mainly meant to check whether such an addition would
be acceptable from an API point of view. It currently has an obvious
performance issue in that seq_file seems to only return one page at a
time so lots of read syscalls are still required. However I may not
have the time to figure out a proposed fix for this by myself.
Regardless, text-based formats can't match the efficiency of task_diag,
but binary ones are also possible.



Best Wishes,
Eugene
