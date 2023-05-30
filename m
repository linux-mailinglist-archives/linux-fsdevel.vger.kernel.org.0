Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211FF716554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjE3O5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjE3O5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49984F1;
        Tue, 30 May 2023 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U8HiYp2slXvnvkKX5oxZ1aUtqPhFblbPbekApi8AX98=; b=swj2PYYnUZOwUPz3Ww7CzWaKWs
        inM6Ivn1u5wfzymid/hw+tl7pEQGO9MyNDyB1KK3ZyzeQGsNI9vXBN8LBguXfyfhKL/UHTb+5YAZy
        ysNqEgKpPc69U4S63QUKD5/QJhVWoS53qTrOeiZr5GADKTxjNLqrbJu8XL50KoArt5dqY5wkuVXF4
        VHy7tkBjtdIG73OL7Lkf7jJ3Bembisrv4yFZPa6SYqk/CZloWwQeAcD+2yFVTS5i9tk0xjG8HjAFb
        gUPyU3nkJ34p3j527ESCxSrXscwNt85h4P70hxuO4IWmoxGLZfgJoC8VJWqGcyM98onbriYYDUzTX
        4957OcuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q40mP-00EIhR-0A;
        Tue, 30 May 2023 14:56:57 +0000
Date:   Tue, 30 May 2023 07:56:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     corbet@lwn.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
Message-ID: <ZHYOucvIYTBwnzOb@infradead.org>
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526130716.2932507-1-loic.poulain@linaro.org>
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

This clashes a bit with my big rework in this area in the
"fix the name_to_dev_t mess" series. I need to resend that series
anyway, should I just include a rebased version of this patch?
