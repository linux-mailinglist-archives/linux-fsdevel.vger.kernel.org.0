Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325F495A90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378938AbiAUHUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:20:17 -0500
Received: from verein.lst.de ([213.95.11.211]:47145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234297AbiAUHUP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:20:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F0F4268BFE; Fri, 21 Jan 2022 08:20:11 +0100 (CET)
Date:   Fri, 21 Jan 2022 08:20:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-aio@kvack.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [libaio PATCH] harness: add test for aio poll missed events
Message-ID: <20220121072011.GA26841@lst.de>
References: <20220106044943.55242-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106044943.55242-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI, this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
