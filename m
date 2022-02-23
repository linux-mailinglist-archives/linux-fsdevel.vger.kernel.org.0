Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087254C0CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbiBWGyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbiBWGyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:54:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8939A6E547
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y7dp5AQ8J5eOU8+1sJJRn/uVrpUXIuLRB80qvvWQ7qI=; b=XxB5mrnWzDbkez09kzBmNudOYd
        gyR+3h/YVBZGtMw/F/FQHlMXCPc0ofAJlyAL/EWhgvP+HqzzubaVARXb/KKyr92bZ4YEhfRpkQJBh
        ayDidURdSGVTDg3/Z6hzWN91wO1hCbJJUSj1hAf2jdNf/4++RO5ZJsskaBQWtf4aQdTS9NL7Tun25
        R+tHto3TtNVUtqgZ7gYi8nGkzoBluw1fBeXNf1WU5ez2ySKLdgxQrmDRRmhfhznRJ1EBwtJNtJ1WK
        R9MQQm4YljpLMJWYxFlZQ4kf3a9op/U69fbD5f84+4FNkoJU+LoS2gaCWGh7T9ryVPWBk+dvdc4b8
        BEbDu9ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlXM-00D36H-7J; Wed, 23 Feb 2022 06:54:08 +0000
Date:   Tue, 22 Feb 2022 22:54:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Edward Shishkin <edward.shishkin@gmail.com>
Subject: Re: [PATCH 03/22] reiserfs: Stop using AOP_FLAG_CONT_EXPAND flag
Message-ID: <YhXaEI25KUoHpWNW@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:01PM +0000, Matthew Wilcox (Oracle) wrote:
> From: Edward Shishkin <edward.shishkin@gmail.com>
> 
> We can simplify write_begin() and write_end() by handling the
> cont_expand case in reiserfs_setattr().
> 
> Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
