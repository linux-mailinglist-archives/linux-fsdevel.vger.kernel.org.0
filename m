Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA21D197C30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgC3MqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:46:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgC3MqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mL4lwQil6Lhkxg4/K6T83/LSQ5YDUAO6rYi+BeU7vYE=; b=j3rzpHekZg3flFGwOgmitK71s6
        VkUC49CHTlc/ePq15s8WoSNVs/UFuJS2PZqfC6ho830Wf4W/+VeRA+PobhK3OtVw5dx1Ip8/YGKJ0
        sqMAJ1Vdy7UrqCRznBpJQR+6peCoIwpcCIAbYpjZkyQ78f8kR5kWuTnbngprEhG9hd+mFNbl7PGrf
        ht9CqHjznNO7tvqxT5iBZtDJ10jJzwDguL+7UjWdiTZx0lHGaxeXO1YsHsX1IlpPahG07ASz2TBWf
        1S1nCvIqQJsUAxeH3PoJXJzSg4eaLH9tOJHuXQM7g4BehQT9PZ+krhLp9Vsdqg21Uuvu7LelbznV9
        NDXNVqMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jItnx-0001Te-Ff; Mon, 30 Mar 2020 12:46:13 +0000
Date:   Mon, 30 Mar 2020 05:46:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] XArray: fix comment on Zero/Retry entry
Message-ID: <20200330124613.GX22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330123643.17120-2-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:36:35PM +0000, Wei Yang wrote:
> Correct the comment according to definition.

You should work off linux-next; it's already fixed in commit
24a448b165253b6f2ab1e0bcdba9a733007681d6

