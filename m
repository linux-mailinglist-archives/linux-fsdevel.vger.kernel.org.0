Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B10357570D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiGNVg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiGNVg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:36:58 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0B66B9B
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 14:36:54 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10bf634bc50so4093829fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dMsmvbkREQ7KC9eGxfbeklXcQRZHnKDY78xwrC9tKMk=;
        b=ALZYzwPvLLgaaZuNAiyDE1NXdHZ1z84Gf5xF5jMSsgEHTyXsL6oFp+ZjipwHvVvFzm
         TrKV7+yCe7S62tBtYSry/HCkP+RI1oguAi+GWQpigF5i9yBQXxwn5mEiGc0k2WRCalue
         Va5CwZcDo5AszHEPTRe9XNFn3PS2HMwL0ilTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dMsmvbkREQ7KC9eGxfbeklXcQRZHnKDY78xwrC9tKMk=;
        b=SiWUfeXBItwyfyIZ0ggnJ4iK7xfosze5vHYHDONARboDU5lpJBt7oTqcuTds+pZFe2
         05S1xwZHGeRivUTLHyjbU9id46Zs/OOf5pA72IyWwq1mmUtaLRRDZwjtO79s35ABJSrZ
         zhYDZahPW/2/IjSpsGHKmSyYncTtADzjj9YdaO+v7X2Jm+HgaBOg4WHvFrXj3U7xyJKA
         TMd3AScnEn61CAEM0/udViGF+cvWsu+OHT2DuBbQRV+SrDjDTGEuJiuMik0aCMX4l8H+
         7bZ4lRMz3nOTE/owd72doNzWk5jkwE8vY18RvrFBEpHVaJGPK767542ZjVojK/BnGIem
         QMTA==
X-Gm-Message-State: AJIora/PnRz+R+DRVe7fGSKmlgk2d2C3JYm3PUnj3M8inHx4pp4sGgkl
        p0kh77SGfoopHcnoBIQ0nffDfQ==
X-Google-Smtp-Source: AGRyM1tlwLQnIbQ6UHKexG6NWKRkWlDRbT1I/TR2dwuHH3PhVJpDf9EtHgNBha7yVB4C1rqPax6Xkg==
X-Received: by 2002:a05:6870:4389:b0:10c:5293:76bf with SMTP id r9-20020a056870438900b0010c529376bfmr5817323oah.7.1657834614051;
        Thu, 14 Jul 2022 14:36:54 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:1f77:47fa:4ce9:ddce])
        by smtp.gmail.com with ESMTPSA id t4-20020a4a96c4000000b004356bc04240sm1109830ooi.5.2022.07.14.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:36:53 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:36:53 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] acl: make posix_acl_clone() available to overlayfs
Message-ID: <YtCMdTbZPB3po8D/@do-x1extreme>
References: <20220708090134.385160-1-brauner@kernel.org>
 <20220708090134.385160-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708090134.385160-3-brauner@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:01:33AM +0200, Christian Brauner wrote:
> The ovl_get_acl() function needs to alter the POSIX ACLs retrieved from the
> lower filesystem. Instead of hand-rolling a overlayfs specific
> posix_acl_clone() variant allow export it. It's not special and it's not deeply
> internal anyway.
> 
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
