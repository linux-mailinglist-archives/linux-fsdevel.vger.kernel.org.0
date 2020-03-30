Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4414197C3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgC3Msm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:48:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgC3Msm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KoG1QqhWD1DcdiyrT8mNu3Jh9PyD80FSFlC875tDkbg=; b=W5uUEn5r8yh0jhrS1xrnbRssqv
        hS/dhGgDfiWbmfXeGJurthXsutWWrF/yptFlqVcmXTuKT+htNNjybaJZ5pizOD9e8pjXMBY41ERHa
        6qPkXu3ADyBRsacmsXmvbaY3piLbDTID1YOYOHFNWeD14r5A6D1+4/pPST2+ID95eyAra++hzF9bs
        0feVCH1b3Jgube9joSG6I5pRbtjWIcFXMKIVJMEza1+rxgLh3zarnlwH3iXWpeHBqOEog63G7jSKv
        +BYQ+jCI0RJawLMevk92CR3m0YmmbLEU68TrcVe9P/voffb8CK2RYCX6hqCDyaKAwijYlOI4OT4bg
        jnbqyQJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jItqM-0002FV-8s; Mon, 30 Mar 2020 12:48:42 +0000
Date:   Mon, 30 Mar 2020 05:48:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200330124842.GY22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330123643.17120-6-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
> If an entry is at the last level, whose parent's shift is 0, it is not
> expected to be a node. We can just leverage the xa_is_node() check to
> break the loop instead of check shift additionally.

I know you didn't run the test suite after making this change.
