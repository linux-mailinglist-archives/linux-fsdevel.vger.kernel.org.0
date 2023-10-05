Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651F27BA13A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjJEOms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbjJEOk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604C16868;
        Thu,  5 Oct 2023 07:12:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F067C32779;
        Thu,  5 Oct 2023 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696502229;
        bh=gSpbj6IfxqVzUcRRXfc1iA/IHDe/dw6GWbrSd2jy4ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2cisPZYzSrMuwtKtJk2XiktKaNcgrvK9Z9jx/IQw+nVU09tGh7fPW7HXnmLflojD
         h5mDOLD7LgQM/T5xAIe3fQ8b9lE2JRnJbmukPqSSpd2PcdhW5nAfPzHoR4iIZUhDkG
         1FhaKgfiDvCAqJhL0x4oRLEY9mCsuy375BUNeLPU=
Date:   Thu, 5 Oct 2023 12:37:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 17/29] kernfs: move kernfs_xattr_handlers to .rodata
Message-ID: <2023100556-departure-hurt-4709@gregkh>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-18-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930050033.41174-18-wedsonaf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 02:00:21AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> kernfs_xattr_handlers at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
