Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE6C5A6C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiH3Sd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiH3Sd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:33:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740F6C768;
        Tue, 30 Aug 2022 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WEmQN+6Nw20owgW81yaoQaqKOSVpiLyZb3sg8Y1rIiw=; b=oPO8HBOuU4ELWQw0nJ93ViKWT0
        yyEf9j8EVAGjU+Mgm+4W3xATroP2LLFq3ZKBZuyRF6optEsL1uplSH+28bKdhvJeYLA2rlqBMq/ia
        UHgOtVLzm96UdmYim94H1rxEVddp4xubb2i7gP7XLO2qhyY4KI+tBQzWTAoH0BON0glx7myauqHSX
        jTl/6HdQKyk/d+hJXlzDczGI4fVjsm2rq/8c4JM897q+so9IHHkDwm2YYRvB5aVQjLPrkrwte9Pd7
        0mL9I+sXyk7T2oxLx1T92EC7F2OkVuWAzFoFkex93tsvPDYpOht8dqkfsLQhf/aaSTUxVda7QbFMN
        0WSFEzww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oT62p-004K31-S7; Tue, 30 Aug 2022 18:33:03 +0000
Date:   Tue, 30 Aug 2022 19:33:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
        perex@perex.cz, amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 1/2] libfs: Introduce tokenize_user_input()
Message-ID: <Yw5X379ct1PK6wZO@casper.infradead.org>
References: <20220825164833.3923454-1-cezary.rojewski@intel.com>
 <20220825164833.3923454-2-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164833.3923454-2-cezary.rojewski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:48:32PM +0200, Cezary Rojewski wrote:
> Add new helper function to allow for splitting specified user string
> into a sequence of integers. Internally it makes use of get_options() so
> the returned sequence contains the integers extracted plus an additional
> element that begins the sequence and specifies the integers count.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  fs/libfs.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +

This really has nothing to do with filesystems.  Surely
string_helpers.[ch] is the appropriate place for this code?
Also get_options() should probably move its prototype from kernel.h to
string_helpers.h.
