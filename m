Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA442A7E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbhJLPIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 11:08:46 -0400
Received: from verein.lst.de ([213.95.11.211]:41837 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237062AbhJLPIq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:08:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F33C67373; Tue, 12 Oct 2021 17:06:41 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:06:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20211012150641.GA20447@lst.de>
References: <20211012111226.760968-1-hch@lst.de> <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk> <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 05:57:43PM +0300, Sagi Grimberg wrote:
> Jens, is that with nvme_core.multipath=Y ?

That is the default.  But for most PCI device namespaces are private
by default so we won't use the multipath code anyway.  Only for
dual ported devices, and even for those that flag might need to be set
explicitly at namespace creation time.
