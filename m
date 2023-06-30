Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C75744527
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 01:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF3XV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjF3XVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:21:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E75242;
        Fri, 30 Jun 2023 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jvdz0LbFUd5KiEFSNFVLvK0uJCLqVYTsPuq+h53F+6E=; b=u/vsEj2FgZ9QmeEuNpjS7q+tuh
        hONGbehXcGJxZhd9FubfoY6WSSYbJ9UPF61udiyY3YDrjQYxphEMAEmqW13hZrjYlrxP9Aj0+80Mv
        lSHjcDIUUYBt37PBBzN0m+QkmonWpmQLq/GzYl2uGsUYUh8itiU4LW5ukJtsPfTYW3ijiAUHQvXGD
        /rpdUy97sLEY2g6GOCv+CDWGzno0N9uACVNRdj00rgV0xz+EZ4SF3kwchTHqSgRqom7nK2WZbhQIG
        ZmRcejFw7P/KjuG88ANRAXoXaBUnf4BHaHCr5ZC/TzjAtteUMi03cESvUlAvVzauCMdK7+4M7+MBI
        SpvKEtHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qFNPi-004kne-2X;
        Fri, 30 Jun 2023 23:20:30 +0000
Date:   Fri, 30 Jun 2023 16:20:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tom Rix <trix@redhat.com>, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: set variable sysctl_mount_point
 storage-class-specifier to static
Message-ID: <ZJ9jPpdRq3My4bKM@bombadil.infradead.org>
References: <20230611120725.183182-1-trix@redhat.com>
 <202306131330.AAC4C43AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306131330.AAC4C43AC@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:30:47PM -0700, Kees Cook wrote:
> On Sun, Jun 11, 2023 at 08:07:25AM -0400, Tom Rix wrote:
> > smatch reports
> > fs/proc/proc_sysctl.c:32:18: warning: symbol
> >   'sysctl_mount_point' was not declared. Should it be static?
> > 
> > This variable is only used in its defining file, so it should be static.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Queued up, thanks!

  Luis
