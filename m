Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4C30AE6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 18:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhBARvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 12:51:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:48224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhBARuu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:50:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98DBBABD6;
        Mon,  1 Feb 2021 17:50:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D68E6DA6FC; Mon,  1 Feb 2021 18:48:18 +0100 (CET)
Date:   Mon, 1 Feb 2021 18:48:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Fix potential deadlock, types and typo in
 zoned series
Message-ID: <20210201174818.GV1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
References: <20210201085204.700090-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201085204.700090-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:52:01PM +0900, Naohiro Aota wrote:
> Hello David,
> 
> The kernel test bot, Julia and Anand reported a lock incorrectness, a type
> mis-match and a typo.
> 
> Here are the fixes.
> 
> Naohiro Aota (3):
>   btrfs: fix to return bool instead of int
>   btrfs: properly unlock log_mutex in error case
>   btrfs: fix a typo in comment

Folded, thanks.
