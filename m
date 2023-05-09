Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7A6FCFCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjEIUqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 16:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEIUqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 16:46:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813AF2110;
        Tue,  9 May 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kCdk2cX8L2MN43rb5MxNNov65UyV2OH8ru0XyISmXUI=; b=K7upsmYH2eNpceBwZDvkKsjAT+
        4vmnhZzUe6LJmKL5J95AraOcNy1gmtWq41lmziOVtI7zdlMRTcGcudRW+OikG6taddJ1oNrcCkZpf
        wIFvqKLs7A8HUbxqxo2Yjhi7LQ0urLBbkeq19KXloG+ON+kDXtBmyXpDRSg+VF/N+UfR1Z3bzQeVZ
        aofTqZ1uEH/bXHbmaScnXZ2SEsg9jhlj5xpJd2rAnmyU3Wo/tc1hjCNwT919l8VVInPw4qW8uczvd
        vGu2zKtUDzXa/1WG3N1dNzkflPSN7NggpLf9nJ+XJYMyMQTxajkMhr9TibN6mtP3p0hzjuEu2Zqr2
        i2ykeQvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwUDp-004Div-0e;
        Tue, 09 May 2023 20:46:09 +0000
Date:   Tue, 9 May 2023 13:46:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFqxEWqD19eHe353@infradead.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-8-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This is needed for bcachefs, which dynamically generates per-btree node
> unpack functions.

No, we will never add back a way for random code allocating executable
memory in kernel space.
