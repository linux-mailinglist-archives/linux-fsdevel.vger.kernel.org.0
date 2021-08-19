Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED23F0FEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 03:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhHSBVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 21:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhHSBVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:21:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862FC061764;
        Wed, 18 Aug 2021 18:21:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i28so8918629lfl.2;
        Wed, 18 Aug 2021 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SJuvwza4i3euGFKnNsOSq5UE2l7kBSIoFPXhirEE3R4=;
        b=fxKyYxPdHn19y1zWIJctQyf02Cp5BGh+iXmRYyxGsHjzqVwZ28VBRWJ4ovpTkA0OpW
         7fRNbiUErN6HeIrTCsFh8vUDYXQ9BBAkpzzuBP+Xys1jrVAcWqWXy4S384e/U35Qh00m
         BcXnkq+FlEm+WVrtUHfbtnwu9oBE9V2+Oj495lXZNHXn5UtCT85FzqvMvZobRbJ3Lg+k
         4/O1d9BcepeOCNoy3b0rfSHJLXU1gqed0RkIl1eygr4nghgbMn82FHAB/nGOvrWViZEh
         1EzCbkXQ3qygEk0UqGtscvSrQzF2Y1pSqSqOIdxX9j/kN/SYja/ZXXipVZdgStPyrMUC
         ElsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SJuvwza4i3euGFKnNsOSq5UE2l7kBSIoFPXhirEE3R4=;
        b=oicsjzqzpQ2Tc2GqHBHXJ0v6c949A114O7B3aKONwPa0Iu7xMp+L6hNYSgJ1wthQUm
         EtzDSoKNZVgDAut2tw0DsSQwVOWLAbNmhrre+w2fK0HgW28wl23a2s/AOWeyBD5Tw8Gw
         QkYqwnEuYuhH+7QoeAi1FgYxnE4c1nhkBpWxDBtP2nyYGmfz4VXELpBsJv7S0oZZVEDS
         eq5x5cg3UplYCzI8Hlv68S0ClHro6OcS9X8w1KXp+ryU2bzqt7PqhOzRNKzga+OLotEJ
         cIXZfKqm4/7VoVAVrPOc0sXq8WLTSFB+g7cCRtZFgSlGKcLJMwushWvsxUP8nyX0Cpgr
         XnxQ==
X-Gm-Message-State: AOAM530RA72kHUJsiUPU829qA2a0EWXXOQAB3b2SHXU4bqsktf1MRV5O
        cLb3u0xzEKrvQZf1ZSFnn6Y=
X-Google-Smtp-Source: ABdhPJxUSdb/TSThZOC0vW4s1x5WY/iq6HsaI5MpPqZA8s1xJqhodoM4fRPhgnAeb9XSAPuwLQqFGg==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr539877lfc.650.1629336071117;
        Wed, 18 Aug 2021 18:21:11 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id bt25sm131947lfb.282.2021.08.18.18.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 18:21:10 -0700 (PDT)
Date:   Thu, 19 Aug 2021 04:21:08 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 05/20] ntfs: Undeprecate iocharset= mount option
Message-ID: <20210819012108.3isqi4t6rmd5fd5x@kari-VirtualBox>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-6-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808162453.1653-6-pali@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 08, 2021 at 06:24:38PM +0200, Pali Rohár wrote:
> Other fs drivers are using iocharset= mount option for specifying charset.
> So mark iocharset= mount option as preferred and deprecate nls= mount
> option.
 
One idea is also make this change to fs/fc_parser.c and then when we
want we can drop support from all filesystem same time. This way we
can get more deprecated code off the fs drivers. Draw back is that
then every filesstem has this deprecated nls= option if it support
iocharsets option. But that should imo be ok.

