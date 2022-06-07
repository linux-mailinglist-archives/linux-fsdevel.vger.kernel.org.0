Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5553FDE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiFGLux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbiFGLt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:49:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243C9B1BD
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 04:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54426B81ED4
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 11:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CB4C385A5;
        Tue,  7 Jun 2022 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654602593;
        bh=+fGWt/KiXuV3Ai7gEQN1LyL8tyAAyYggUr00nJxdV3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cePAZPEDD76FQ6jLEb+ovV+TuIMEr9zPq9KtBJAWlPaN4rCcrVpnaRR2gXlcZHszh
         bfl/T9Zf89YqVvm6gaOm/HbWy/vbxqlPyFxjdAjYfadIueR0c1/RFSIJqxmV6fF25j
         9P5XoHBFfc+EhcUyaDPKJz2KZKnXhfh+DnwyXk+BGyvZB+pE9InWbJQ/OLX/Mdp7ny
         9f7p++fgudVyne6wSN7q7oaDNNzAquskRFRdr6Sl2fE8ubGQ5SjkaD2i3lD7bSjfBN
         G9sV6+MEk8w8lu8zEdvWCq64H2Zod6TF2KO6aEMi6svGyYyNi75qTLGtG+9x4JD15A
         nbis4QvYEbeCw==
Date:   Tue, 7 Jun 2022 13:49:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/9] No need of likely/unlikely on calls of
 check_copy_size()
Message-ID: <20220607114948.brz2oa4i7u5cmxq3@wittgenstein>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7Pc2PFBke5FyWa@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yp7Pc2PFBke5FyWa@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:09:23AM +0000, Al Viro wrote:
> it's inline and unlikely() inside of it (including the implicit one
> in WARN_ON_ONCE()) suffice to convince the compiler that getting
> false from check_copy_size() is unlikely.
> 
> Spotted-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
