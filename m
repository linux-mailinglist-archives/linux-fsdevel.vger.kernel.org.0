Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F114F3885A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 05:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhESDu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 23:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhESDuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 23:50:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC10C06175F;
        Tue, 18 May 2021 20:49:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id v18so6119965qvx.10;
        Tue, 18 May 2021 20:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtBZr8UfGMe2NRXG2EkfLojRcmF6PYYjekObnrreHsU=;
        b=axMoBxLv+eZZMTcswYPFe2DQjcb55bhqevaXwvMUByl443AFQxAf0zJW/Ptd4iEasv
         nxXM/I98/W365Sb/36K8tGE2e1DTDpsUHsY/RcrzlB/bGIlufLjOSF6Bcue/FTuHPq7K
         SSfMJgasP9pPKu12RVkxCqQH0X4IRKqp+GL6gRkSTuYko7GczAWk8Jo0NC15KJqxVLGf
         4fz3xGcgkJokdFmfc7nuqSMUKSLVTGLJgjR8jpijTA4fKGIJhT5KTKay81VavEhYePSl
         SUr7A/VQ3a+sfcz34M8N02bRVsoT3h6oSbkpr6JuK8H4Olsj6UmhaD4/4ClSOBXjjkD3
         k7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtBZr8UfGMe2NRXG2EkfLojRcmF6PYYjekObnrreHsU=;
        b=GGYzv5KxE44SG1M0JVqRuYa0j9Padjwp53J2I0htWh+PJ+i+dRXTgeCwcbZqDP9Ayt
         2L221owTDZw/vdbrTq0+oiboIfnsWtt4cJfEbYywlqNr320mXnCjWt/hqaBY1r1zWYJn
         5YwlDOCDF6B2WqSmMTqm+ELF9LzG1pm/vL1mgYKZb+WwxkYfKkZaeIURl+kIaaYsrQON
         uet0nYO+xq5H9MiYNEhh+PMkpNE0gKhzSagUmkpYK7/6gQzVPk4Xy4ODcIyR+2UKKjf2
         //3zPWdr1jvhgWKCBjp1+ofG2lF46V3+EtadcdzShSjQLIqM+bKXArSSo+IDVFvuRIZP
         BlvQ==
X-Gm-Message-State: AOAM531f0220SFYixfPr3juBa3EhRAc5WIhSqC46hep8lI2M4iUAkYf1
        Hl15OpaUvkODT3sHdcSrb1Q=
X-Google-Smtp-Source: ABdhPJyFiDNJDKDcXCyymUBk8gf4+xLUJX/gBr29YpuwXrXW6tdAjJRippor0H5ZzGmd2hDBWEpKlA==
X-Received: by 2002:a0c:c447:: with SMTP id t7mr10246194qvi.60.1621396143393;
        Tue, 18 May 2021 20:49:03 -0700 (PDT)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id g5sm9869746qtv.56.2021.05.18.20.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 20:49:02 -0700 (PDT)
From:   Neal Gompa <ngompa13@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     aaptel@suse.com, andy.lavr@gmail.com, anton@tuxera.com,
        dan.carpenter@oracle.com, dsterba@suse.cz, ebiggers@kernel.org,
        hch@lst.de, joe@perches.com, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, mark@harmstone.com,
        nborisov@suse.com, oleksandr@natalenko.name, pali@kernel.org,
        rdunlap@infradead.org, viro@zeniv.linux.org.uk,
        willy@infradead.org, Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by Paragon Software
Date:   Tue, 18 May 2021 23:47:59 -0400
Message-Id: <20210519034759.259670-1-ngompa13@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
References: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey all,

I've been playing around with this patch set locally and it seems to work
quite well. I haven't seen any replies from any bots or humans indicating
that there might be anything wrong on the list or in Patchwork (which
does not necessarily mean that there wasn't any feedback, I could equally
be quite bad at finding responses!).

Could someone please review this to see if it's finally suitable for
upstream inclusion?

Thanks in advance and best regards,
Neal

-- 
真実はいつも一つ！/ Always, there's only one truth!
