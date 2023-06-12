Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99D72B7F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjFLGLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLGLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:11:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5C93;
        Sun, 11 Jun 2023 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0nVoswaF7RP+aWNKqRqR3CEbRMr2iH+m4rhQ/GG9rtA=; b=wC9CGq8ZKflmk7B3Q6eoBXICDn
        6LmAQglzz9lJQR2Ws89Io9TmC82WiAc33wllpVaLhkqezzb+vX/cos4taEeLJJd6oHhRRMwOFe03h
        xPLwQR15DeH/pX7bsSthhABCB5eF0kgywOWespTWUuCfZsxh6ZFRZOm7vs1SJlAMFoJQVcs2cxijr
        xRN6O85rWC8sOMYuJPzPTWm+R8hKVYPqssMAUeIia2+RyJRZW6YnGz1s27JzQ2h9avxwW+7ePX/J/
        nP97C8VxyyTTlx9tnZnyrm55tcj7tTM4+0MJMdoMAXv9M9fDGHAszEyRCw+EVaOIcB0fNtf0ADbES
        wK4eyRjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8alx-002jiH-2b;
        Mon, 12 Jun 2023 06:11:25 +0000
Date:   Sun, 11 Jun 2023 23:11:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
Message-ID: <ZIa3DfH9D0BIBf8G@infradead.org>
References: <20230611132732.1502040-1-amir73il@gmail.com>
 <20230611132732.1502040-2-amir73il@gmail.com>
 <ZIaelQAs0EjPw4TR@infradead.org>
 <CAOQ4uxhNtnzpxUzfxjCJ3_7afCG1ye-pHViHjGi8asXTR_Cm3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhNtnzpxUzfxjCJ3_7afCG1ye-pHViHjGi8asXTR_Cm3w@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 09:08:37AM +0300, Amir Goldstein wrote:
> Well, I am not sure if FMODE_FAKE_PATH in v3 is a better name,
> because you did rightfully say that "fake path" is not that descriptive,
> but I will think of a better way to describe "fake path" and match the
> flag to the file container name.

I suspect the just claling it out what it is and naming it
FMODE_OVERLAYFS might be a good idea.  We'd just need to make sure not
to set it for the cachefiles use case, which is probably a good idea
anyway.
