Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4545D4337D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhJSN5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 09:57:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJSN5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:57:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A63E321A99;
        Tue, 19 Oct 2021 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634651702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCAmwd04vR+8ISMPrZZs/6BPlrRsuF68LDbyHwEPntQ=;
        b=tLZsnCbfP/PE33Cg8Lb4wiLOBxR8QveId9HdyLQwr2cih36yShITfbjTETbGmX7qoPSLnV
        KpgAA8+dbLeP0XdSU+qtQz6RQ6J5EBZxRaplNcIZug7sxD7fof1K7Oihxwjp0TkV6E8qRu
        UqkFmpgJ7dUVgd+qqNHE1kGVvaHvryE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634651702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCAmwd04vR+8ISMPrZZs/6BPlrRsuF68LDbyHwEPntQ=;
        b=eVe2N40rhMpqpW06F4v/0V4nL0bZy0/F/3sDzYIThe2zCSwt2+BtKDOwwYusSYK+iBuJ9x
        /SDiTxQlN3QaJABg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0D869A3B85;
        Tue, 19 Oct 2021 13:55:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F6DBDA7A3; Tue, 19 Oct 2021 15:54:34 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:54:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH 4/7] btrfs: use sync_blockdev
Message-ID: <20211019135434.GS30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev
References: <20211019062530.2174626-1-hch@lst.de>
 <20211019062530.2174626-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019062530.2174626-5-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:25:27AM +0200, Christoph Hellwig wrote:
> Use sync_blockdev instead of opencoding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Sterba <dsterba@suse.com>
