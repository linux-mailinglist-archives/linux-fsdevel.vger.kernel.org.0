Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49F62DC3F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLPQWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 11:22:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:37298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgLPQWg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:22:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DABBDAC7F;
        Wed, 16 Dec 2020 16:21:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0AB8BDA6E1; Wed, 16 Dec 2020 17:20:14 +0100 (CET)
Date:   Wed, 16 Dec 2020 17:20:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 01/13] btrfs-progs: send: fix crash on unknown option
Message-ID: <20201216162014.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605723600.git.osandov@fb.com>
 <e0aff7fddf35f0f18ff21d1e2e50a5d127254392.1605723745.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0aff7fddf35f0f18ff21d1e2e50a5d127254392.1605723745.git.osandov@osandov.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:18:44AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The long options array for send is missing the zero terminator, so
> unknown options result in a crash:
> 
>   # btrfs send --foo
>   Segmentation fault (core dumped)
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

As this is an independent bugfix, I'll add it to devel now, thanks.
