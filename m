Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB63E7AD848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjIYMwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:52:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F392;
        Mon, 25 Sep 2023 05:52:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C75AC433C9;
        Mon, 25 Sep 2023 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646323;
        bh=pQlw7Ty8p0KdHe6fJmEwR2aVcK1GReSNX8GrdoD2DbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUF7R6+XGpbWrxvgA7C8TmCiQGQZiv+3cgzvevU7eqkemYaJ81Tu4mUMxH8aHnMDb
         v2H0GhaNGI725PXH+p2TSdrgdKp2oDRNP0nTbgTi9FzFfvWl6y3cGcIkkUzRVz5MeG
         h2Vu454+DRSClZr/rxXOwlTsCi3IeiaCsBQu8eDqf/RkYNZsZodPK+moS6IXHBq3Ra
         RGno2h5XXbkkfZQo+SlztN7xPcqvSSs2px+z4NH1vx3r4ZgirEqH+6+HFgbWmq2AFn
         vR07p3QcW39Mir562evizF+HRd9JNgMDo6OlqO/LUCIiT7SmzM7pDxM+mRsMRBFuUN
         IozRIIAxOpyFQ==
Date:   Mon, 25 Sep 2023 14:51:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
Message-ID: <20230925-westwind-zimmer-ce1952dba456@brauner>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
 <20230914-hautarzt-bangen-f9ed9a2a3152@brauner>
 <d188250d3feb3926843f76ef3ca49e9d5baa97a7.camel@kernel.org>
 <CAOQ4uxiKLKjPbOYZvJX7gE_z9bmJGc2XFsvrGiCHCd+i=zrZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiKLKjPbOYZvJX7gE_z9bmJGc2XFsvrGiCHCd+i=zrZQw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Christian, if you have any pening VFS fixes, you may send it along with them
> or we could just ask Linus to apply this one directly, so that any mgtime
> changes that may still happen for 6.7 will already have this fluke fixed.

I'll move the fix from vfs.misc into vfs.fixes now and then send it with
the pile of other fixes to Linus this week.
