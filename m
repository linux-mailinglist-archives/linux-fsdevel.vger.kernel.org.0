Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3C264573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgIJLsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 07:48:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:36120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgIJLnp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:43:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B9ADAB91;
        Thu, 10 Sep 2020 11:30:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA230DA730; Thu, 10 Sep 2020 13:28:43 +0200 (CEST)
Date:   Thu, 10 Sep 2020 13:28:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: implement send/receive of compressed extents
 without decompressing
Message-ID: <20200910112843.GJ18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:39:50AM -0700, Omar Sandoval wrote:
> Omar Sandoval (9):
>   btrfs: send: get rid of i_size logic in send_write()
>   btrfs: send: avoid copying file data
>   btrfs: send: use btrfs_file_extent_end() in send_write_or_clone()
>   btrfs: add send_stream_version attribute to sysfs

For the record, I'll add 1-4 to misc-next.
