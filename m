Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330565A642F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH3M52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiH3M5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:57:11 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A25CD4758
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:56:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id c4so9117170iof.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hnLp8LO/BC7OEqBu9Qhn6CWfmeTHeb02ESHz6bAuuCw=;
        b=DDob0+Mn4WK/68AxiRwgw1d4YuDwxVDKfQ0q81VoJVfC1TJyGQ1cL3fcXmp4FluVVG
         4fkEzwsWcJcNBaZBwLSSDODAiHMZPXEa+tXH8nKnfIchJJyBo3f62Ot9Z/OITxcBQuHu
         ED5FUlw+Dr0Apc/W6CcLjgukBXE4EVQHPm6jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hnLp8LO/BC7OEqBu9Qhn6CWfmeTHeb02ESHz6bAuuCw=;
        b=PD/CkMAC0vljTVPhqkEaky5HWpFLr7XSf4osuHpYlgmT/CEvg/5G3DTA6gA6CDuQg3
         hrk2HjE/YELc8pMm2KIsWD0rSl/MfI5qSO6X9PLGN5KK54COXUkXfh7hgpnBidx5Q1uX
         4IVI3aE8ekyzvc6PrthTVWshtnaT0uFo1cWhWyZf2mRviyZ2qdwjku1RnV+p44VzcRvE
         8ENSL/THNiUBSlUsdvVH9n2LDcOkgylpZ7FiBGhKizCp50e+31wtOVODXJOjen5vGpSK
         97DkXSH7absJqqeXKl//2K8etdmgd/b0Qx2hLHh9nN+5WhFbkRcUBRSwRgLPSYJIcwrn
         lgZA==
X-Gm-Message-State: ACgBeo1Kk1OsgK86b5t4R0Ds48Bmu2XlfdXD8KeaI40KNzWoeem/Cfjm
        E18+M+39DrXAaLlCaeLSNLzQOQ==
X-Google-Smtp-Source: AA6agR6Bx9tDDsQ6bVk98ZTP2lCFcQYm3ndwN13Koo7xMatOnxNsCWdHB8DNgb0+jnif/c/K08X+Rg==
X-Received: by 2002:a05:6602:395:b0:688:f4aa:6dd4 with SMTP id f21-20020a056602039500b00688f4aa6dd4mr10867768iov.40.1661864200782;
        Tue, 30 Aug 2022 05:56:40 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:56b6:7d8a:b26e:6073])
        by smtp.gmail.com with ESMTPSA id 129-20020a6b1587000000b0068886ea6d9asm6148812iov.54.2022.08.30.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:56:40 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:56:39 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] ovl: use vfs_set_acl_prepare()
Message-ID: <Yw4JBzKR2OD3HDQZ@do-x1extreme>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-6-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-6-brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:44PM +0200, Christian Brauner wrote:
> The posix_acl_from_xattr() helper should mainly be used in
> i_op->get_acl() handlers. It translates from the uapi struct into the
> kernel internal POSIX ACL representation and doesn't care about mount
> idmappings.
> 
> Use the vfs_set_acl_prepare() helper to generate a kernel internal POSIX
> ACL representation in struct posix_acl format taking care to map from
> the mount idmapping into the filesystem's idmapping.
> 
> The returned struct posix_acl is in the correct format to be cached by
> the VFS or passed to the filesystem's i_op->set_acl() method to write to
> the backing store.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
