Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3731E4EC775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbiC3Oyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347609AbiC3Oy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:54:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC464D27A
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TeVQVN2Wp2RCp6lvw94h9NR3JiGnJ+pOP4icHniQv0o=; b=vkyakHKpsxB7bgpr6x35KGLGNC
        kc2crQs4pBbPZmyfYaKLh33hkyuRD8Fs79O/EZ489PzB91PCJjeY8AEsYXebELOjKkL+OGnXJvBNQ
        NR2BYWTxtvZ/w7RgjB4D7vi5AsbJzj97viQjTIvOcOy6YzCjjyjmnexT90Bv3A00XpldmH45Ou2YY
        va9rfObsEufXSsZcLseX4ZCVOSK6+9VxYgPIFNAFEzIfSbfI3zIrKYLxuNLuJxBPW33OAUglygNIx
        9XUvZ1ofA71Z5pS9uqa3xvbGOxKG49XhIXJKsCSu0e2A2+xk2IFgsI2fgJPPHG9Z2xNMXS7n/KNEz
        V8X9fNLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZgb-00GJcj-0w; Wed, 30 Mar 2022 14:52:37 +0000
Date:   Wed, 30 Mar 2022 07:52:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/12] fs, net: Move read_descriptor_t to net.h
Message-ID: <YkRutOxzHfHj+Ce6@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-6-willy@infradead.org>
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

On Wed, Mar 30, 2022 at 03:49:23PM +0100, Matthew Wilcox (Oracle) wrote:
> fs.h has no more need for this typedef; networking is now the sole user
> of the read_descriptor_t.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
