Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F816720246
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjFBMkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 08:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjFBMkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2823180;
        Fri,  2 Jun 2023 05:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CE764FED;
        Fri,  2 Jun 2023 12:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AACCC433D2;
        Fri,  2 Jun 2023 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709637;
        bh=wFvoHZitiOtC290G+wp4+/TYZYR62ERLRNIegvZqTQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHpXetLu3iBOp1GxAghgEgStinoRkVPS9grxrD1Z9uKpmUD4XokSL6ilTp6QNjN2J
         A8E7xHY3v+etHb3wuHN7TTtMj+2eYyTVgMZKCroMnFp4fjDAASaJA7KmRQyywna9Th
         SjN7nJVIHIXo0yw8kJpokSjZ8TZ5PJhUxVSGb2npJgw+s2QUMi76Dnl8HOAlYwJCmN
         sMSRy2i21vx7j6fZRR/Y0wYYJUQ/Rn2I4YvhRGJKzhSXPpjDwox2zH/xyDKhNOHuT9
         4sc0fuNRtOxY+0TEX/K+9kdte1IIJW9HdTRsApmy7GXHKlBsKEfralncwWg01DsSKU
         TRp6aMIAOvueg==
Date:   Fri, 2 Jun 2023 14:40:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     xiubli@redhat.com, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] fs: export mnt_idmap_get/mnt_idmap_put
Message-ID: <20230602-lernprogramm-destillation-2438cc92fee3@brauner>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 05:33:03PM +0200, Alexander Mikhalitsyn wrote:
> These helpers are required to support idmapped mounts in the Cephfs.
> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

It's fine by me to export them. The explicit contract is that _nothing
and absolutely nothing_ outside of core VFS code can directly peak into
struct mnt_idmap internals. That's the only invariant we care about.o 

Reviewed-by: Christian Brauner <brauner@kernel.org>
