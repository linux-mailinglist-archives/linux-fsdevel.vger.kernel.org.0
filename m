Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0625EF1A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiI2JQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiI2JQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48870127CBA;
        Thu, 29 Sep 2022 02:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F1360B3E;
        Thu, 29 Sep 2022 09:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A7C433D6;
        Thu, 29 Sep 2022 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664442986;
        bh=iUtghS/ZLy5Sj6SQilZFZjJMLgo0DHO2Vdar59zgLEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmQJ3g6t88L9ErXUlJ816B/2hmD/mjhC2aszTZLqlJ6bXAl2SNZeihFZ+qZVuRICO
         tEbY+hTNv7X4l+UaovUx3MzNpjwhah+4bKJ1wRXV6vZju5CP52M564WeCr/IcNEU4c
         pLPfJVsz99zs/Q6jJpNK3HW+salYE6p/LdKQVifRf/+DdQDGQdE1RXmhpiasKVT4Qr
         C0qIHyo9OuUoD1SR4r6ORpg5MR9wgCc/6bx9GJPEUwenY0ZmG/uV1Kmor6+d4iij+m
         y39u6/LfW7OR7R8tX8Bz3hTn/pDVb0pXqZlnLQvqw4rCyiNwYiHkgT5BZaNLLhiWeU
         u4cCZniVMwKww==
Date:   Thu, 29 Sep 2022 11:16:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 03/29] fs: rename current get acl method
Message-ID: <20220929091621.pz2wu4xzndou5jby@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-4-brauner@kernel.org>
 <20220929081253.GA3699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929081253.GA3699@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:12:53AM +0200, Christoph Hellwig wrote:
> Just wading throught the rest of the series - I think we should
> also rename the get_acl() function to get_inode_acl() to match this.

Yeah, sounds good. Folded this into the renaming patch.
