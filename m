Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27036A336F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBZS3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 13:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBZS3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:29:18 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C711EC646;
        Sun, 26 Feb 2023 10:29:17 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id DBF5683191;
        Sun, 26 Feb 2023 18:29:13 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677436157;
        bh=bdrmo9b3uW06/doEdhL8zWIVVo5RJXhv1CutW1s8cnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4ii7wUAXzT0zZR3zeGgYY8XPzUeUtMcCG4/+27Zniz1a13ikjoBKxsd4Dxz7u/5b
         +1XI+Q+GPGRJGQVG+GiegDZ08qLjK0K3Zy6bdAU34WEA2Nz5536RzhUyTSk0jThbZa
         roxzmKjeVuZE18Lwcqt1+bxHlLRPh+Ps9GlmwHP9HO7FeQFeiWxrDHxDGBHFNi4dOf
         OtFpk5DxE7D+Tu8JzAz2ZOY5YWKZqkTJihmLuCs5waQPvsmtVqZSS/1MTFR0yrHs0k
         UcDJmEMgKnkiAwlRxYOjx0lTMcO7+3B13PDsXep11n1K2U0aHCn7M2KQnh4FhRClYz
         d6DWoLu6cAhwA==
Date:   Mon, 27 Feb 2023 01:29:09 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <Y/uk9cnp1jcjqI7f@biznet-home.integral.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <Y/uQdXp8ioY1WQEp@slm.duckdns.org>
 <Y/ukSBodK65MEsuL@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ukSBodK65MEsuL@biznet-home.integral.gnuweeb.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:26:24AM +0700, Ammar Faizi wrote:
> 	mount -t -o rw btrfs /dev/sda1 a;
> 	mount -t -o rw btrfs /dev/sda2 b;
> 	mount -t -o rw btrfs /dev/sda3 c;
> 	mount -t -o rw btrfs /dev/sda4 d;

Excuse the wrong mount commands, should be something like this:

	mount -t btrfs -o rw /dev/sda1 a;
	mount -t btrfs -o rw /dev/sda2 b;
	mount -t btrfs -o rw /dev/sda3 c;
	mount -t btrfs -o rw /dev/sda4 d;

-- 
Ammar Faizi

