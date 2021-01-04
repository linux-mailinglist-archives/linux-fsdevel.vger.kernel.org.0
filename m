Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA32E91EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 09:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbhADIjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 03:39:32 -0500
Received: from verein.lst.de ([213.95.11.211]:56890 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbhADIjc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:39:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30A7568AFE; Mon,  4 Jan 2021 09:38:50 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:38:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: block_dev.c: fix kernel-doc warnings from struct
 block_device changes
Message-ID: <20210104083850.GB28271@lst.de>
References: <20201229034706.30399-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229034706.30399-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I sent two patches for that quite a while ago..
