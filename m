Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C86D86E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjDET3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDET3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54C658C
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0F863F24
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 19:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D4C433EF;
        Wed,  5 Apr 2023 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680722968;
        bh=uagecEUmJOY2wzLwoMhVaSiva1T4t43eFV8AhHKoXm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iY7x3cULmTTjDuZrPNhDavCY86CStZWSI5azxQHkFSauk/pGjpJMqQtMbMRDr7wS0
         XGnnbBFdew6DRFaYe9KzhPRaTLiHu4XU6sMRQk94+oAI3hF0mlTaWIobG1VPA7CI3z
         kDPwOooFRW2GH34AZ4klCIDtWx+JLN6v84ANYDoptdo39jXkikh8fm+dwsYFehKzSD
         OLjU67eyAoYk+HD6IZroN2ioLuBJL839Ghz21HYhRVlWVSO9cvOVAkOlhvxNu+k6VC
         FOzjUoTTD3oDD5hViyd1VN+MwWFYmj6TePj5p2EL/+JZaTxEnODiYC6eU/ixRR3/Xu
         j/0u92utoPwNg==
Date:   Wed, 5 Apr 2023 14:29:27 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: add path_mounted()
Message-ID: <ZC3MF9Qsz8giiKdx@do-x1extreme>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
 <20230202-fs-move-mount-replace-v2-1-f53cd31d6392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v2-1-f53cd31d6392@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:13:06PM +0200, Christian Brauner wrote:
> Add a small helper to check whether a path refers to the root of the
> mount instead of open-coding this everywhere.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
