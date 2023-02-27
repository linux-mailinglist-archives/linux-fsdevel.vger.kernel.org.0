Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5296A3F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 11:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjB0KCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 05:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjB0KCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:02:16 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD51E299;
        Mon, 27 Feb 2023 02:02:15 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.2.41.146])
        by gnuweeb.org (Postfix) with ESMTPSA id 147FF831E1;
        Mon, 27 Feb 2023 10:02:11 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677492135;
        bh=HzfaCigHgb6Z+xfz7yIVdSy7DWhZopcyQEu9jCZDWj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhBkp7VEtWPoK/PZd9ql0NDUOC7uzxI8gtfSNzEUA7JG1Q1mfl7OLm5XLfeOdV/q2
         OIhf/QVM6ovsRRkmjbSzI1WfGZfD8Q3PZOtOvDQnMG/sdP0Mol3/WbXl+jvN5Hf6TV
         2JwHAEEiQTTMn+tcJthImnGPAAleyRCJ/F5/xV0+FTL/L/9r2btIG2T0tRQqevLyRF
         d2H55qp3owPxxUpgp8xaiWAbYvJQnL5YDXFYOPDP7hV2ZTEF8/AmHYGFmKG4SYkMzd
         lw+2VjqgyTjMuYZjluupyl8kBFMQsa8w/mZFGi6CeZrv0sayj8DKk0S7iSgKMZu+VI
         2SyXzIFqqXOdQ==
Date:   Mon, 27 Feb 2023 17:02:08 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 2/2] Documentation: btrfs: Document the influence
 of wq_cpu_set to thread_pool option
Message-ID: <Y/x/oD+byOu092fF@biznet-home.integral.gnuweeb.org>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
 <20230226162639.20559-3-ammarfaizi2@gnuweeb.org>
 <Y/wSXlp3vTEA6eo3@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/wSXlp3vTEA6eo3@debian.me>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:15:58AM +0700, Bagas Sanjaya wrote:
> Why will the behavior be introduced in such future version (6.5)?

It's not like it has been staged for the next merge window. It's still
in an RFC state. The changes are not trivial and need further review.

I don't know if it can hit the next merge window. As such, I picked a
long distance for this proposal. If it ends up going upstream sooner, we
can change this document.

-- 
Ammar Faizi

