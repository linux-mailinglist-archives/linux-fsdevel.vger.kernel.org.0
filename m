Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5C1BB70F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 08:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgD1GxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 02:53:07 -0400
Received: from verein.lst.de ([213.95.11.211]:54363 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgD1GxG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:53:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4166E68CFC; Tue, 28 Apr 2020 08:53:04 +0200 (CEST)
Date:   Tue, 28 Apr 2020 08:53:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: stop using ioctl_by_bdev for file system access to CDROMs v2
Message-ID: <20200428065304.GB18707@lst.de>
References: <20200425075706.721917-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425075706.721917-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens,

can you pick this up for the for-5.8/block tree?  We're about ready
to kill ioctl_by_bdev after this series.
