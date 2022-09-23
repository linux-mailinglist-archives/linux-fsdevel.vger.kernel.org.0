Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC965E756B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiIWIHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIWIHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:07:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77AC12AEDC
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 01:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02A11CE20EE
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A508C433C1;
        Fri, 23 Sep 2022 08:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663920460;
        bh=FXloiN2A7oyJTyID7mC+vz4UeDV/emruo0mG/MCT6r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4BF2jTUJ9XD5Bo4QXSNFM5U+p/DYQ0c0HHMQMhX7/QkPAFyPZ2/DdyJsw/X/2ZyJ
         CYYWT/f09Z2EmM9I24Hi1a5HqEHxvxPZMRg8ZVmO27kEJ2D9UNeFSbU4xj6roj+viR
         eyPs4FFQd/xsjouQLt69CTp4PX+SJ1/2j8/qga2wKhsZHiBRo0WwHTFmLVGb1Dudzh
         Tbj96QOkCY2ETANm1c6PqIGAzxRmUbTRWKzIPvFAWEZiyTcvz4pEqaDA+kTkh6kvNs
         ETBpfPdPSuFUfbEC1FRdwK54DtyZZRDeA+vkKcWBOgdYIF98dzZPCIfb3cxWAZF2zk
         d0rZ1/RqSXmzA==
Date:   Fri, 23 Sep 2022 10:07:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 02/29] fs: rename current get acl method
Message-ID: <20220923080736.7gdvpglepnjkhnsy@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-3-brauner@kernel.org>
 <20220923064438.GB16489@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923064438.GB16489@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:44:38AM +0200, Christoph Hellwig wrote:
> >   * Filesystems that store POSIX ACLs in the unaltered uapi format should use
> >   * posix_acl_from_xattr() when reading them from the backing store and
> >   * converting them into the struct posix_acl VFS format. The helper is
> > - * specifically intended to be called from the ->get_acl() inode operation.
> > + * specifically intended to be called from the ->get_inode_acl() inode operation.
> 
> Please avoid the overly long lines in the otherwise nicely formatted
> block comments.

Will reformat.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!
