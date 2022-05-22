Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307805302EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbiEVMIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344247AbiEVMIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:08:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38633A15;
        Sun, 22 May 2022 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0l6/d9syUyRiu0Hhxfi8aVzCCh
        3Zf/THxZ09eEElli9wurtQxzUxY9OTZV4Rn2qT1NWVOjw1qR68nAoFM6TiIwPEr7ZUmMm6S2vi22y
        ehCQ5+uKuFWtRp5Lt/XK2/Xz3Jtdd7sU61Yu27dolyqvG5XEru+rXuC0ujPBjcamfNuOOJBJ046yB
        gFf/3slVeQ/w+WkxoPkV7hTGY040cHD5OjsNsfiACq8J0FHOUZMXvwYzqoIa4IbkXwk0lN5IMaDYB
        j2FNPJhcjVHFF12jmmWe25ieH65yicJNO8yZyBo2Re4HjuY8+HtZ+OR0QZBXuQtBixbKbcP/QuXpa
        6kifZmZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nskNu-001GfX-6U; Sun, 22 May 2022 12:08:34 +0000
Date:   Sun, 22 May 2022 05:08:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     linux-fsdevel@vger.kernel.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] fs/open.c: fix incorrect fmode_t cast in
 build_open_how
Message-ID: <Yoonwi1DC3bN+aCY@infradead.org>
References: <eeaba25e-7c79-3c46-c39e-a2352dbfe007@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeaba25e-7c79-3c46-c39e-a2352dbfe007@openvz.org>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
