Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3397B28D16A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgJMPmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 11:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:53644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgJMPmp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:42:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA7CEB2BB;
        Tue, 13 Oct 2020 15:42:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 533EEDA7C3; Tue, 13 Oct 2020 17:41:17 +0200 (CEST)
Date:   Tue, 13 Oct 2020 17:41:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v8 10/41] btrfs: disallow inode_cache in ZONED mode
Message-ID: <20201013154117.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <4aad45e8c087490facbd24fc037b6ab374295cbe.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aad45e8c087490facbd24fc037b6ab374295cbe.1601574234.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:36:17AM +0900, Naohiro Aota wrote:
> inode_cache use pre-allocation to write its cache data. However,
> pre-allocation is completely disabled in ZONED mode.
> 
> We can technically enable inode_cache in the same way as relocation.
> However, inode_cache is rarely used and the man page discourage using it.
> So, let's just disable it for now.

Don't worry about the inode_cache mount option, it's been deprecated
as of commit b547a88ea5776a8092f7 and will be removed in 5.11.
