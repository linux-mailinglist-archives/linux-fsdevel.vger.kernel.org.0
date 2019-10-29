Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3796AE8DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 18:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbfJ2RWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 13:22:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbfJ2RWP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:22:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7A61B1D3;
        Tue, 29 Oct 2019 17:22:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8884DA734; Tue, 29 Oct 2019 18:22:21 +0100 (CET)
Date:   Tue, 29 Oct 2019 18:22:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, jack@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: use READ_ONCE/WRITE_ONCE with the i_size helpers
Message-ID: <20191029172220.GY3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, jack@suse.cz, linux-btrfs@vger.kernel.org
References: <20191011202050.8656-1-josef@toxicpanda.com>
 <20191024120843.4n2eh47okn4c635f@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024120843.4n2eh47okn4c635f@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 08:08:44AM -0400, Josef Bacik wrote:
> Al,
> 
> Will you pick this up, or do you want me to send it along?  Thanks,

So is this patch on the way to 5.4-rc or shall we apply the
btrfs-specific fix? Thanks.
