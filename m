Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0D546516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbiFJLJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345515AbiFJLJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE871451E1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 04:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A57A5CE3530
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 11:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545BAC341CC;
        Fri, 10 Jun 2022 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654859356;
        bh=Nn1G5IwsvvNSVPlBd+YB/EQOUWPXt+oScOAuxGSr678=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOwFvX5KWLM8oLpl9/Huc7V1+aFd2GvCiX3yhoBEpfWwPp4z9Q3++cqw94wAXyWrN
         CTS87V+9kKvi+E7d/RRftoUZxFO5VJ4Mj6SgwK6+ClkVUaLP34L8WScM5xjPhWcqYa
         olgf4peLHTblR87P42sqcbfcBJBOuqid3f11PxVi0jwkfAj+14LPlp/YZ3dXlL+jel
         VCkhnvxzUIdNwbmORBq5HPydf8Q0Mmr7VEXn+8zQZEoNTlqlGZQH9xhVn/66RYsI4+
         WnjrypqW8+W1RW8NFh/uhv5ZPguqUjfCbCLs5EjT+ppbmYTDM2GxEJTkfPm6KGu0RS
         RO6nf8ozpadwQ==
Date:   Fri, 10 Jun 2022 13:09:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/10] btrfs: use IOMAP_DIO_NOSYNC
Message-ID: <20220610110911.37xvyx3ijnknhzkl@wittgenstein>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
 <20220607233143.1168114-3-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-3-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:31:36PM +0000, Al Viro wrote:
> ... instead of messing with iocb flags
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Good cleanup,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
