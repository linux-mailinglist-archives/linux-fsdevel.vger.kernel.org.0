Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0465BCD6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiISNlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiISNlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D911C22
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 06:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E72B961411
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 13:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326B1C433D6;
        Mon, 19 Sep 2022 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663594910;
        bh=+8fH8oC1IMyC4uiy5bnQaCJr9VtggRvBItfwY3vIFyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPEKYFK5ltgnvV18tshATtWD/Uxatq+H7imzCHnk8dv4sKsS3koKuxXa2jELrxCEL
         7jGTHv2IgjZWALvat7zXWw21F8S2eOGBKASmTzl+w68dFs4VxoC6hX7O6w4w8x0yHD
         8fw6t+fPBjdTipDs2hdmTk7eTmIMNaLAFeO0I/1nuLgDMJoPOSiHpwD7o+Dl9TkMZS
         jIUbCFqAzazhXo7jUvmJ1VkyS1LUATFSpvrzZ8vEAhLvRmaSrKZBgbANzfuNY9fi9c
         e9eH1u7AUwTrgCjfQvWN0U58SHdAJ5fmcaZvlfTE/iqhU8SaAvjwxamq1HtCtRRnI+
         K7TD/+MUOtdJQ==
Date:   Mon, 19 Sep 2022 08:41:49 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xattr: always us is_posix_acl_xattr() helper
Message-ID: <YyhxnUUGUu1+GfYh@do-x1extreme>
References: <20220919094914.1174728-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919094914.1174728-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:49:14AM +0200, Christian Brauner wrote:
> The is_posix_acl_xattr() helper was added in 0c5fd887d2bb ("acl: move
> idmapped mount fixup into vfs_{g,s}etxattr()") to remove the open-coded
> checks for POSIX ACLs. We missed to update two locations. Switch them to
> use the helper.
> 
> Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
