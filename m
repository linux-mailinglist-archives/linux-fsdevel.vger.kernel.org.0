Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADD2A45D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKCNCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:02:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbgKCNBw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:01:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFA44ADC1;
        Tue,  3 Nov 2020 13:01:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16BDCDA7D2; Tue,  3 Nov 2020 14:00:13 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:00:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v9 09/41] btrfs: disable fallocate in ZONED mode
Message-ID: <20201103130012.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <51d6321cf98f8176e6214aea5ab83325832194a7.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d6321cf98f8176e6214aea5ab83325832194a7.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:16PM +0900, Naohiro Aota wrote:
> In the future, we may be able to implement "in-memory" fallocate() in ZONED
> mode by utilizing space_info->bytes_may_use or so.

> +	/* Do not allow fallocate in ZONED mode */
> +	if (btrfs_is_zoned(btrfs_sb(inode->i_sb)))
> +		return -EOPNOTSUPP;

So here EOPNOTSUPP is ok.

> +
>  	/* Make sure we aren't being give some crap mode */
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>  		     FALLOC_FL_ZERO_RANGE))
> -- 
> 2.27.0
