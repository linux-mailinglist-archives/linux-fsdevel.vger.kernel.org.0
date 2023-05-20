Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76F70A6C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjETJik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjETJij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86CE42;
        Sat, 20 May 2023 02:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B034260B61;
        Sat, 20 May 2023 09:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22513C433D2;
        Sat, 20 May 2023 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684575517;
        bh=UITJqkbSRLqe3fEc/QtOwUE1guoZf/bbfzKL1AjylCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od+Lz2YNHLKcVu5WN/P/qKOOjTtun4t+C1+WmsiHvDKiyi/1YD4kjk8JDMk8rRSQx
         pdzF6X4a3RaH7ynOSdzubf/a1Xc6ke7xyG2nZLvFD1dHmy9N99YZ05G4Ja6y4rSt0Z
         5DMiQSN5Z/CTXeog+M63zW2PSvdYJo4WPsaFRqfdlS4ret+Hph34fjQF9Wup2qVtJe
         UPwZC2A52ZJrU06wIZCHJIEBzpdW1cD/I8UMb+qCLjd5Lk5YLyjJfIWJ+MgCXvZv5V
         3LNN8QZa7HJ+92sBouqJiE/Dh1+rRWZKw05yYnv/nV+m/PESmveuYRRJCQSBav0lRM
         XDtMHCv4eXGqg==
Date:   Sat, 20 May 2023 11:38:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v21 06/30] splice: Check for zero count in
 vfs_splice_read()
Message-ID: <20230520-zweieinhalb-erfragen-f9cce7c16e0c@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-7-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:25AM +0100, David Howells wrote:
> Make vfs_splice_read() return immediately if the length is 0.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
