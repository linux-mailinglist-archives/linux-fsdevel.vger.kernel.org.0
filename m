Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50E523451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiEKNev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbiEKNes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 09:34:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A272163F66
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B58FB823DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 13:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF5C34110;
        Wed, 11 May 2022 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652276083;
        bh=QAwWoZaG9cgHPc4XyL1BwWy9V5tRF4Oo7fbp+tiWKyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3rqn+q84EY7TWOuAk8iSPQdPiEqXhGCir1AytV8ENjdLakaiLK1l4rzuoGDqJmJv
         /ab7OiRqkgYj9T0GQRDpqG0H8NbaRb/HXiydZf/fy8oz+VPjKn93zyBTUxwXqHVVo8
         tF3UKVGa/pwyqUXN6h60ZxydBZMRHEOIWSRz1QijE7fAobg1rXPvNMYUe+ZZJO/T5u
         ZauRvbL71d7f06BOh8NMJXwVb0GwJ6uD2oVJIdicrKNDktDiQPfN/Bcc06KmVlffxO
         H/6i9sz6CKhq8K0FFOduYFTjfcQgGzyRS3NvpGzwwF135PzJtGfEoH7e+IGWnLBh2J
         RWTRS+e0kMW8A==
Date:   Wed, 11 May 2022 15:34:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Appoint myself page cache maintainer
Message-ID: <20220511133438.asmfjxekqjvdnc5m@wittgenstein>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202849.666756-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220508202849.666756-1-willy@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:28:48PM +0100, Matthew Wilcox wrote:
> This feels like a sufficiently distinct area of responsibility to be
> worth separating out from both MM and VFS.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

+1!
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
