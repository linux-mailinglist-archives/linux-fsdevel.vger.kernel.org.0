Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97470A68B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjETJCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETJCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:02:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828510A;
        Sat, 20 May 2023 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ROreG6kiJHA2gDeVQnQ0pl8EyThSYR4NrNrObaLNkZo=; b=Libx7jSdGZ1yT/+90Pr5nn5tPz
        3p/rS2poLYavfOHw9sceEoZ4jk351v9PEiQKKkDexGqeC0iG7jPdlPISLRaA1weC4tqtAlkNNOjwV
        cftsjyXliWrqKtqzUflc0PTqANZCbz2JDrBJnQz4LFIL7htsGtwIMJMiMVAQIv6mTFqiEEqWYf2R6
        IOXzsmP2u2XQLRlo61Rd9aarKFAjHtb711mqbOGthUvI5NeXjLaj3NCX+vbF1ALHFqg+jIvBJwM6S
        OAqzeMnsRKZOmS5KTJkXQ0MJt+c0WpZpbna26j/YewRlYIA9orFYD00/eGI2AvUcuOtK4UOLKMiQa
        nyQyuprQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0ITD-0014R0-1T;
        Sat, 20 May 2023 09:01:47 +0000
Date:   Sat, 20 May 2023 02:01:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v21 18/30] ext4: Provide a splice-read stub
Message-ID: <ZGiMewK8CW7DB4sl@infradead.org>
References: <ZGhIpbrgQaPRPC3c@infradead.org>
 <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-19-dhowells@redhat.com>
 <2233565.1684567304@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2233565.1684567304@warthog.procyon.org.uk>
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

On Sat, May 20, 2023 at 08:21:44AM +0100, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > Not sure I'd call this a stub, but then again I'm not a native speaker.
> 
> "Wrapper"?

That's what I'd call it, yes.
