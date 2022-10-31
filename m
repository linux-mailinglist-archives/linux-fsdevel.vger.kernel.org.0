Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17486613907
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJaOdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiJaOdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:33:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FA392
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 07:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 326A7CE1154
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 14:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C89C433D7;
        Mon, 31 Oct 2022 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667226797;
        bh=e3wBUJyg5L4HVxMkpDivV90Rh+CblnYDDAkuYLKKh/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsBF94lFU95wqP15OnUPNGL11PW19Q9Zre49jX4cTp8odXBB3a5okdqJmgIzO9TPq
         ASsAxn9w+KHOcER/spx/rV981koS7LRNgkKRzRDAHrV6yM7J/HjD7EdqxIURwf1JVO
         BtPUDbHsI9LzQDtmaVSqf97agGSQ3ceCDYJGhwWBnrlVcYaLOUWMKTVZI3MEqRHHlb
         XWxjeobJlf61y4cdKcgEHuXJBaybjOorNn/RXc8zrPy8INqXZU7mqY+rJWQWXl2DJy
         VSfTSZtxqeKv1/LgDb6duSD4/JdP92vOAXu7UtaUW4VB5ORSz81jv7mxVVCjCzQJbD
         qAzEUFZs10jmQ==
Date:   Mon, 31 Oct 2022 09:33:16 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] acl: conver higher-level helpers to rely on mnt_idmap
Message-ID: <Y1/crENfwS/E/nYN@do-x1extreme>
References: <20221028111041.448001-1-brauner@kernel.org>
 <20221028111041.448001-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028111041.448001-2-brauner@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:10:42PM +0200, Christian Brauner wrote:
> Convert an initial portion to rely on struct mnt_idmap by converting the
> high level xattr helpers.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
