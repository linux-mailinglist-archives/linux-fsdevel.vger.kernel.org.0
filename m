Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E665B352E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIIK1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiIIK1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7E9C2E3
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 03:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC2F61F6E
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 10:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE92C433D6;
        Fri,  9 Sep 2022 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662719221;
        bh=zJoOi4EV46/VaIVuseBjGzgH1MCePctdow8b5mS/Ivo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaOE9JwKyRWM5igqF/GM9eXfhiI8EGnw5sKWwJ6PLfKJo6l2JCK5FXvvQIewFhXjf
         guWR3iRx8yI/SmA6Rad+FHMdq++IwFPGP0CE6CTqxgfCA8FWGE8xvCu1XwP2CKhaiY
         kLZuBpDxv/MKC7lsYUn+FFPMPIvzo5UJBeEclCXJU2msBdMQk/hO/9Fv+yvV+8gpeh
         U7zecHf0Vns4bcJUca9zrmvFwqHWMzp/D/PqFk9YE7KeuBFwpeUr0cQZb0XNQ4fDJa
         QN6b7rsuV9tnyAjTpak7v6yGibWYR1EVJoneNIKyDBnvgpXqHtJmDrVoHOx3XyYjvf
         vJO1ra51cX88Q==
Date:   Fri, 9 Sep 2022 12:26:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
Message-ID: <20220909102656.pqlipjit2zlp4vdx@wittgenstein>
References: <20220909093019.936863-1-brauner@kernel.org>
 <87czc4rhng.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87czc4rhng.fsf@mail.parknet.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:01:07PM +0900, OGAWA Hirofumi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > A while ago we introduced a dedicated vfs{g,u}id_t type in commit
> > 1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
> > over a good part of the VFS. Ultimately we will remove all legacy
> > idmapped mount helpers that operate only on k{g,u}id_t in favor of the
> > new type safe helpers that operate on vfs{g,u}id_t.
> 
> If consistent with other parts in kernel, looks good.
> 
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Just to make sure: will you be taking this patch yourself or should I?
