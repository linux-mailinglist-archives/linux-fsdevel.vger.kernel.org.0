Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34EC5A63E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiH3Mv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiH3Mv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:51:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7991A397
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:51:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i3so4949953ila.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EuwLrMdn5r170lxt21FOw9RSww7EjmuD2PXeNzJuUWE=;
        b=KzhPEXdmhxsmW/OeRqPlNvw7koE9tkQ5dRhH9TvHA2Nn4FweNat2IcKUEY1WbAYrXP
         Oon3acRl97A0iPCsiAfMw9YbTspWNtObI4uuEyyt95OulOgKgSVm3SwVHiTfShuBhECG
         jnzYRvy5yEF38OW2kyg2hCG2s0VarrBLqDwmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EuwLrMdn5r170lxt21FOw9RSww7EjmuD2PXeNzJuUWE=;
        b=aUyHneRIm1rTdmEW7DlNDODKw/erwHaDdX85QK9U1L8wJC6XFVW1YVDRSGc9E5HB5A
         hTzZgyxZi3Cpaw4mozR7I47mHySwqBGUwLuiuEUttL8lQpPu/nsXCi4hWaGp6O2Fk3fw
         1ouf+1/WOZIZZiBXDevjrBkpzLWVhYl739hm9yqunUNbm8DEmJZT+aCz1PhKrYVq8uM4
         viRSvbr9mM0Faiu2dfpwxPW8z0TayMhQPobWCd4/PWdkGBfblZuWOsoR8e/SojwhGPCZ
         xg7OhvQNITj9M7rN4cjVgvwcqW/D+S3m257g6/T5pxfZUl6rG1oTbo7Cb4AJVIcuFh7A
         nlrg==
X-Gm-Message-State: ACgBeo1UwiMwQNyI0kVRGp1VC1OBHELUWiGyh0ZPf2nNce17hGtI49/t
        vsqVpPR0aq2fOu6h1u0lGr4Xqg==
X-Google-Smtp-Source: AA6agR69wSD4AeZpoNYWP+g/xnioIcUCD+crM0qfDiT0j9oZ0rhfgzLVKT86G/jlNjhuUFKq3m0DSw==
X-Received: by 2002:a05:6e02:1548:b0:2ea:836d:ac6c with SMTP id j8-20020a056e02154800b002ea836dac6cmr11215138ilu.6.1661863885906;
        Tue, 30 Aug 2022 05:51:25 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:56b6:7d8a:b26e:6073])
        by smtp.gmail.com with ESMTPSA id f33-20020a05663832a100b0034294118e1bsm5546977jav.126.2022.08.30.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:51:25 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:51:25 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] acl: return EOPNOTSUPP in
 posix_acl_fix_xattr_common()
Message-ID: <Yw4HzQcp6bS0vZp8@do-x1extreme>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-3-brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:41PM +0200, Christian Brauner wrote:
> Return EOPNOTSUPP when the POSIX ACL version doesn't match and zero if
> there are no entries. This will allow us to reuse the helper in
> posix_acl_from_xattr(). This change will have no user visible effects.
> 
> Fixes: 0c5fd887d2bb ("acl: move idmapped mount fixup into vfs_{g,s}etxattr()")
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>>
