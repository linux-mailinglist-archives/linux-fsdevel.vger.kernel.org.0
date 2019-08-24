Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962DD9BE85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfHXP2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 11:28:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfHXP2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 11:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r+fW1Mxx/WIOu0q7eOdTyS41mAFDLJVl/S3haneWLp8=; b=TJwImQZiE0XYYd1CswYHKW5n6
        jG39tv4RXZ9E9B3XED+e0S6SToGeMhKbPpp6dwYr5CxjxKxdgflwAfCVnFUwl/OeP0meDvFrlf75S
        2o4ykmjqVh19ogfzTo/37YmlZ/g1Kwjf5arpB8hQiwMQGKQGQeP3VX0RdWSaK87+husw8zGa0+fZf
        zlaWbbtggtuhd+5J4JY5k0MZHMXqGuVQlSGoqQ011ARiZHhj6NHN+5232GgXeRNNyHcbuikZkOJSs
        sr71cua8POM0V9JPilHsDUDUMSdvCPrzlzrENXlVlCHwKgo74NgIO4PIFO8KcM97OLvPRuOqrrT9C
        yWXLB2w8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i1Xxa-0002mp-NM; Sat, 24 Aug 2019 15:28:10 +0000
Date:   Sat, 24 Aug 2019 08:28:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/5] mm: Add file_offset_of_ helpers
Message-ID: <20190824152810.GA28002@bombadil.infradead.org>
References: <20190821003039.12555-3-willy@infradead.org>
 <201908241913.Slt7yyks%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908241913.Slt7yyks%lkp@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 24, 2019 at 07:48:24PM +0800, kbuild test robot wrote:
> Hi Matthew,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [cannot apply to v5.3-rc5 next-20190823]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

It depends on various patches which are in -next, although I didn't
generate them against -next.


