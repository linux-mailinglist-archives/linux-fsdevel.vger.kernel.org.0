Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306B5A6433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiH3M55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiH3M5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:57:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E56122B34
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:57:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 10so9122989iou.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=bLphR6++R3S1hhrLdR5ituSvVVAn5GgM2aFbTPVCMRU=;
        b=Lnar4K0kCN4UeUWsZGUuG2M/zoecZsI4X6AL3vFQa3w1FVvT7CwiYgKYWfDqyuMXWo
         QN21isa6Ki0258HzerrLGFVuQZDkTITC/Y+D8h2L2nHqAf7RCPICF9VE47WmYyIqnIIb
         NoAEVTJ0uS0pSrEKnqn72GIOapwONdbjn3idM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bLphR6++R3S1hhrLdR5ituSvVVAn5GgM2aFbTPVCMRU=;
        b=OHYQnHtN6QBEwPOxRHWY9SGF1yfAZykzI2xXBFkl/YF4o6+U1TdnkC/EiaXu5DQBxq
         2LQoazQyxnGmFvnLjnKW5i/Z6IL/o6/t9C7S+ZF/z71k4jbujtiF+SVmFLliy12aA6i2
         WRB4de/VxzTQX+TrpPznkoYk4rlVT6MGVQv5HYBpIuVMNTSXe0gtuqTA2wS2imQgrnzc
         j52+uYzTNPipDN/6HTKUcM4VspXxXtwm9yRuYQkns6fA8AFT2nX0fs4AfR5DixyRkepv
         yLyd5h3nEX/qMgMOCKmIjcUNNbEbQs8itHc37bV0se/od3HjlzlaVLbuE/JMD6hZ8yfz
         YzEw==
X-Gm-Message-State: ACgBeo3rWHsNlWGeujYop3aUzcj6EP2JE0670Im4P5DFdOoLgKRHtIoj
        l7m2TIEn/hnGhE6h1/IAjFzHdw==
X-Google-Smtp-Source: AA6agR6B7He2V73CkCD/bCoN2eDseiilEWAQ6af1JJzTAB6hzTFIVVO5q4Se2y6Ete/s95EASKB+lA==
X-Received: by 2002:a05:6638:1381:b0:346:e4c8:a73 with SMTP id w1-20020a056638138100b00346e4c80a73mr12262089jad.168.1661864223267;
        Tue, 30 Aug 2022 05:57:03 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:56b6:7d8a:b26e:6073])
        by smtp.gmail.com with ESMTPSA id t8-20020a056602140800b006892048f548sm6203377iov.43.2022.08.30.05.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:57:03 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:57:02 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] xattr: constify value argument in vfs_setxattr()
Message-ID: <Yw4JHqgJy1JFpq1L@do-x1extreme>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-7-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-7-brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:45PM +0200, Christian Brauner wrote:
> Now that we don't perform translations directly in vfs_setxattr()
> anymore we can constify the @value argument in vfs_setxattr(). This also
> allows us to remove the hack to cast from a const in ovl_do_setxattr().
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
