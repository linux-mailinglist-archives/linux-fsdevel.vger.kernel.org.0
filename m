Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37478AF67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjH1MBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjH1MAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:00:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D7A122;
        Mon, 28 Aug 2023 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4rQxv02ci47OREsGF9wmOxxXxDrQlTjBDwVCgc865ck=; b=sJtP+wwVhxJhFiSfRWM0nTXwST
        W5WgyjAPt8vEFf8fVy8CcHQzh1EswNUmH8Ve8S7bEI0pholjen+RKdDB1prxqbYJcGw8RJpwa6OLg
        9ypTJL1j8EJBT3jKgBRjHf3pzJ2WQv0jkbmgFF4sH7eTTk7GvGqY/V5clXROTwt3lm2qIwJdPTdFA
        Ujt5biigZozr6iVXJeyivH7Wxwd5TXjV3sRk2EkkFTqWZOKfrv3ZEvpOawepfJfOUnjlCjo4KUCpM
        AEpkVj5UCza3JPF7XXTzt84a4ZvjTSoQVwXIyJWF11IEniedZqZTII80qw35jmp/EySolCAOe/fsC
        CzR1zyhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaav6-009WcF-0j;
        Mon, 28 Aug 2023 12:00:36 +0000
Date:   Mon, 28 Aug 2023 05:00:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter()
 in read_write.c
Message-ID: <ZOyMZO2i3rKS/4tU@infradead.org>
References: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:50:56PM +0800, Kemeng Shi wrote:
> use helpers for calling f_op->{read,write}_iter() in read_write.c
> 

Why?  We really should just remove the completely pointless wrappers
instead.
