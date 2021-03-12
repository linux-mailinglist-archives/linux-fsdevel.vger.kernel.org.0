Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3923339797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 20:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhCLTnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 14:43:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234305AbhCLTnn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:43:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D18CFAF4D;
        Fri, 12 Mar 2021 19:43:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF854DA81D; Fri, 12 Mar 2021 20:41:41 +0100 (CET)
Date:   Fri, 12 Mar 2021 20:41:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert more kmaps to kmap_local_page()
Message-ID: <20210312194141.GT7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210217024826.3466046-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217024826.3466046-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:48:22PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> I am submitting these for 5.13.
> 
> Further work to remove more kmap() calls in favor of the kmap_local_page() this
> series converts those calls which required more than a common pattern which
> were covered in my previous series[1].  This is the second of what I hope to be
> 3 series to fully convert btrfs.  However, the 3rd series is going to be an RFC
> because I need to have more eyes on it before I'm sure about what to do.  For
> now this series should be good to go for 5.13.
> 
> Also this series converts the kmaps in the raid5/6 code which required a fix to
> the kmap'ings which was submitted in [2].

Branch added to for-next and will be moved to the devel queue next week.
I've added some comments about the ordering requirement, that's
something not obvious. There's a comment under 1st patch but that's
trivial to fix if needed. Thanks.
