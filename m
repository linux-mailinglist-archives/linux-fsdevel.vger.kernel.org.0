Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252F7053CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjEPQab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEPQ3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A557A8F;
        Tue, 16 May 2023 09:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2881F63253;
        Tue, 16 May 2023 16:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974BDC433EF;
        Tue, 16 May 2023 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684254572;
        bh=BR2jGf209iwLPopt1wDme2mGVNDwrbRLw//F8qKYVQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsPI6lg5XfrMkImV+wD+hd9xtJRJK6a4WgB0i+wL5itNcruGqXo2WTJ/1GuQauama
         S2nnRKgGI/8f5nKYl4V8taBIKOx21cZsm6xO4TNjhB1hT56h90I4R2LXp8uNXTPpqS
         az/eWUXXnSZmKqV+XV2BrB/OEoup6XAtZv7nNu27IeEyBYEv8I3yW/gn8R0JgaxcH5
         th4wAxUeDpZNuQlk4L12LWbH54d27MrR8ruuLW/uvqHVSsMptt9hmO7yLA4ycsl/xl
         8OlFSV3uuVDpWdDKOxHWd6qiyBVF+Tha4VYLjh0Q0bPQDni3gTpngr064+Jx4zITOk
         QxKvqaO+woRdA==
Date:   Tue, 16 May 2023 18:29:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/9] block: factor out a bd_end_claim helper from
 blkdev_put
Message-ID: <20230516-holzweg-fachpersonal-2aa7f7ca3d03@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:26PM -0400, Christoph Hellwig wrote:
> Move all the logic to release an exclusive claim into a helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
