Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0FFC718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 14:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNNOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 08:14:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNNOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=He7TZydBqJdm6j9sMwQxIx5OY+kOVIAf9OOyvnsEo8I=; b=H8kXXk4c0DwI4SMpC88yvWlam
        G0t6uhkTWxOyi9P4Pv/0bY/6oagZlpCILgiPEI6osgCmOuD2BWKkijjFF6YrGWUZjFr23c1hDWg3N
        D6fTelb8eVI9h5qIKkP26X4UAmcJfKMi2N6RuOJF7QzaBqwN3DoVjWxM4jkqeD7XHAnW8zc7NWANi
        nFnBKj0RnSAwMyObNRjVbHvLO7jKgfDVp0J9LtN19xmYVIcr96WDk6LQxUHL8ey4yLHDe0Q4Y8jkd
        l/bwbFVmItcuydLKrrYdWcco07I2BBOR17Tlv9upt1Y4cUgcPsLrOHAfpKHIFRjXCFcwSmVPy00xl
        OO4J1sI8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVExH-0006vR-Vb; Thu, 14 Nov 2019 13:14:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF8F5301120;
        Thu, 14 Nov 2019 14:13:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93E2829E032D8; Thu, 14 Nov 2019 14:14:34 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:14:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191114131434.GQ4114@hirez.programming.kicks-ass.net>
References: <20191114113153.GB4213@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114113153.GB4213@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 07:31:53PM +0800, Ming Lei wrote:
> Hi Guys,
> 
> It is found that single AIO thread is migrated crazely by scheduler, and
> the migrate period can be < 10ms. Follows the test a):

What does crazy mean? Does it cycle through the L3 mask?
