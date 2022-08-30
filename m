Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043145A642C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiH3M4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiH3M4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:56:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB28122BE2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:55:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z72so9091458iof.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ni0GhJWznm9geanGgeasP6Mw3cFrj+YWSEZlccKv/b0=;
        b=Eaaa59wbIYIdduaDp+brdgCMmRGtRbhqwkxpvrOh/1kGHZXdIlOl3Di2tAeNsidldk
         /XSHO2IcQRfspeAM9iGes4ItviXk+wagk3d01sMf79FXNvgwKoyt+Jz9egPfIY1p9IdO
         ItiEHYHd3zSV1Tb9j9WAgvbL1UwR1xgnE3bWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ni0GhJWznm9geanGgeasP6Mw3cFrj+YWSEZlccKv/b0=;
        b=eBfvEZstT2vk9wVtZc+tMQUYuaMURSkGppPBd+OG63s/T3zSeyV9lsfD0lEbkAByqr
         Js6xt/HUjtquP+1cO/lOeGYrhk2JwV3f4d6Gt9D4TTfu7CpH6T/Cp1zeIfsxYQGYhP+X
         3wf0i/IjRnyzrDz2m3rdFy2IOXTggj5OpVxeYqPznOsEM0WWNIrmWhZV8a11RXYAeJ0w
         OuTn/uBDfs1xAz6B4AaXrnK66s3Qgy/tT6qx6E6tjqo5IRnxgMhdpfExwU+lBlSMA5NS
         Wux2mQx5qNyOSBe6BjGZtmKtTL1XWuZBz6TaMts1FwHYZR7IUBSEtjOlqfK2YKQIN2zR
         xjEQ==
X-Gm-Message-State: ACgBeo21HGEIEGiofe7AQL2qYAN8XEZsQt3mnuu2tUtK4htxCCtfI/6F
        35b9s9RmHLNHem2cIJK1U+1UFg==
X-Google-Smtp-Source: AA6agR7XOy1/C2kQs19g0q7KoLGcMoix4M9zRBshS6XjeeLTO7JuXD8vAUUjHBCKxqE2PJ1M5BgsLQ==
X-Received: by 2002:a05:6638:2686:b0:343:7299:2c8c with SMTP id o6-20020a056638268600b0034372992c8cmr12788574jat.198.1661864128439;
        Tue, 30 Aug 2022 05:55:28 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:56b6:7d8a:b26e:6073])
        by smtp.gmail.com with ESMTPSA id c5-20020a92d3c5000000b002eb0e5b561dsm2402134ilh.15.2022.08.30.05.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:55:28 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:55:27 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <Yw4Iv8cpwmpSEmxh@do-x1extreme>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-4-brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:42PM +0200, Christian Brauner wrote:
> Various filesystems store POSIX ACLs on the backing store in their uapi
> format. Such filesystems need to translate from the uapi POSIX ACL
> format into the VFS format during i_op->get_acl(). The VFS provides the
> posix_acl_from_xattr() helper for this task.
> 
> But the usage of posix_acl_from_xattr() is currently ambiguous. It is
> intended to transform from a uapi POSIX ACL  to the VFS represenation.
> For example, when retrieving POSIX ACLs for permission checking during
> lookup or when calling getxattr() to retrieve system.posix_acl_{access,default}.
> 
> Calling posix_acl_from_xattr() during i_op->get_acl() will map the raw
> {g,u}id values stored as ACL_{GROUP,USER} entries in the uapi POSIX ACL
> format into k{g,u}id_t in the filesystem's idmapping and return a struct
> posix_acl ready to be returned to the VFS for caching and to perform
> permission checks on.
> 
> However, posix_acl_from_xattr() is also called during setxattr() for all
> filesystems that rely on VFS provides posix_acl_{access,default}_xattr_handler.
> The posix_acl_xattr_set() handler which is used for the ->set() method
> of posix_acl_{access,default}_xattr_handler uses posix_acl_from_xattr()
> to translate from the uapi POSIX ACL format to the VFS format so that it
> can be passed to the i_op->set_acl() handler of the filesystem or for
> direct caching in case no i_op->set_acl() handler is defined.
> 
> During setxattr() the {g,u}id values stored as ACL_{GROUP,USER} entries
> in the uapi POSIX ACL format aren't raw {g,u}id values that need to be
> mapped according to the filesystem's idmapping. Instead they are {g,u}id
> values in the caller's idmapping which have been generated during
> posix_acl_fix_xattr_from_user(). In other words, they are k{g,u}id_t
> which are passed as raw {g,u}id values abusing the uapi POSIX ACL format
> (Please note that this type safety violation has existed since the
> introduction of k{g,u}id_t. Please see [1] for more details.).
> 
> So when posix_acl_from_xattr() is called in posix_acl_xattr_set() the
> filesystem idmapping is completely irrelevant. Instead, we abuse the
> initial idmapping to recover the k{g,u}id_t base on the value stored in
> raw {g,u}id as ACL_{GROUP,USER} in the uapi POSIX ACL format.
> 
> We need to clearly distinguish betweeen these two operations as it is
> really easy to confuse for filesystems as can be seen in ntfs3.
> 
> In order to do this we factor out make_posix_acl() which takes callbacks
> allowing callers to pass dedicated methods to generate the correct
> k{g,u}id_t. This is just an internal static helper which is not exposed
> to any filesystems but it neatly encapsulates the basic logic of walking
> through a uapi POSIX ACL and returning an allocated VFS POSIX ACL with
> the correct k{g,u}id_t values.
> 
> The posix_acl_from_xattr() helper can then be implemented as a simple
> call to make_posix_acl() with callbacks that generate the correct
> k{g,u}id_t from the raw {g,u}id values in ACL_{GROUP,USER} entries in
> the uapi POSIX ACL format as read from the backing store.
> 
> For setxattr() we add a new helper vfs_set_acl_prepare() which has
> callbacks to map the POSIX ACLs from the uapi format with the k{g,u}id_t
> values stored in raw {g,u}id format in ACL_{GROUP,USER} entries into the
> correct k{g,u}id_t values in the filesystem idmapping. In contrast to
> posix_acl_from_xattr() the vfs_set_acl_prepare() helper needs to take
> the mount idmapping into account. The differences are explained in more
> detail in the kernel doc for the new functions.
> 
> In follow up patches we will remove all abuses of posix_acl_from_xattr()
> for setxattr() operations and replace it with calls to vfs_set_acl_prepare().
> 
> The new vfs_set_acl_prepare() helper allows us to deal with the
> ambiguity in how the POSI ACL uapi struct stores {g,u}id values
> depending on whether this is a getxattr() or setxattr() operation.
> 
> This also allows us to remove the posix_acl_setxattr_idmapped_mnt()
> helper reducing the abuse of the POSIX ACL uapi format to pass values
> that should be distinct types in {g,u}id values stored as
> ACL_{GROUP,USER} entries.
> 
> The removal of posix_acl_setxattr_idmapped_mnt() in turn allows us to
> re-constify the value parameter of vfs_setxattr() which in turn allows
> us to avoid the nasty cast from a const void pointer to a non-const void
> pointer on ovl_do_setxattr().
> 
> Ultimately, the plan is to get rid of the type violations completely and
> never pass the values from k{g,u}id_t as raw {g,u}id in ACL_{GROUP,USER}
> entries in uapi POSIX ACL format. But that's a longer way to go and this
> is a preparatory step.
> 
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Co-Developed-by: Seth Forshee <sforshee@digitalocean.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

I can't really give a Reviewed-by as co-author, but this does lgtm. One
nit below however.

> -/*
> - * Convert from extended attribute to in-memory representation.
> +/**
> + * make_posix_acl - convert POSIX ACLs from uapi to VFS format using the
> + *                  provided callbacks to map ACL_{GROUP,USER} entries into the
> + *                  appropriate format
> + * @mnt_userns: the mount's idmapping
> + * @fs_userns: the filesystem's idmapping
> + * @value: the uapi representation of POSIX ACLs
> + * @size: the size of @void

I think you mean "the size of @value"? This appears in a few other
comments too.
