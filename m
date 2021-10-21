Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481F243648F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJUOo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUOo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:44:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A8C0613B9;
        Thu, 21 Oct 2021 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qQg58B7bzqfqTiRXM8gUBBXeq0uWPqSokBahSBOyAbA=; b=RsI11gaAuKSte7bColDLWPNN6V
        +0OOUOPXl9DuTcgIFFOIryNqJah0YB4zUG+R1uQWUQI4WqTCoqDDndljebaRaVUiRda45doI5Zm/q
        QVbOjgFmHtMBk8U/g3b4u/nIGZQbeVWr1ERsSFrN+kbqgPiH04X7sxo8XLHKMhNJbWqyNHg8FMn1t
        1629LouiEfMMb7kF95UQOb5s2fgPgHSpHcZFSwwnCjQ6eYMupjoilHZ/66UqLy2JDHuR95wrZ0mKK
        8bP7dQarWFLZWLiZMOQdPlhTqNtV4Bn+LZ1zrUNcKV4AU2gpsrhycJehHg591iM8cvMFhaoFsiX9u
        twx0Ac6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdZHD-007smw-UY; Thu, 21 Oct 2021 14:42:39 +0000
Date:   Thu, 21 Oct 2021 07:42:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments
 with a single argument
Message-ID: <YXF8X3RgRfZpL3Cb@infradead.org>
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org>
 <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:34:38AM -0600, Jens Axboe wrote:
> Incremental, are you happy with that comment?

Looks fine to me.
