Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FB39962A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFBXKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFBXJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:09:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B90EC06174A;
        Wed,  2 Jun 2021 16:07:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k4so4258081qkd.0;
        Wed, 02 Jun 2021 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=JE2Fmc3DG7b+ItlDWjd4iP8aI8YB3NYPt9+ZPBdFFF0=;
        b=L7pyNVcfwBVxxJ9WrQgdtAI2XFgbvKmHAqwrOebvw6FyP3MTrQdkYX1RsL4ytMnYau
         dYWNqL5L/45DNM7cVvl4zVkq2ChHksZJufXWnkH6QJwlVlULHpEgy3LdSV15EPfMBLWy
         uEktR+M9yio/dPVpScQza3lhgazWZS1brTGC/+OR9YHt/5PQAPSQuJMBV6yx8HIZzVvf
         AFHmbwkgnIU+jlvmBoYlzTQBiO9RuU1q6guIUjwMF5CgF4aMDh4WmvMownuLUMOok0mH
         AXYVTYs+jbMZARVLXqDI+3Iy2XTv2jpMmE0v5SHtnMd8qd1zpN8xaLOF1IlBM6xpD8bY
         aHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=JE2Fmc3DG7b+ItlDWjd4iP8aI8YB3NYPt9+ZPBdFFF0=;
        b=cGGr7rVLzuSOLRsHj1DFq0MRqugpCyt1WzGp+t5KfvTp3aX/Y8uZK0PBY7b51eqWl2
         9eQfNe15DzthXW0GlcWBg5dwSOFmIehiKFabH1AmDIT3yHoXhiYECMq3smJCvXwF/jY3
         oFuDGml6eCCSOffjRqOagVjF0vSEScEmBWX15h/Ivbw8kYEoyxzluT+jFqz/lADXOS6l
         keT26Tch5vDW24MDiAaIZctdG+OptYo1Od0WQRQCukKA7t18mvzijffPdpvm3q6QZ/uM
         cQ498xcEHePUjzb3F9kIFw6L0F1puH3afp4YVwjYi7SCTtbo96FBJBN2Bsw6DdRv0lz7
         PDEQ==
X-Gm-Message-State: AOAM531V7f4K5Padkh2nz9AVaf1oafH6+sQBoPuqcMspY9hnE0Ru6JpO
        GNU42xd8AN4bk9XdfzkXd+4hAJ8tXoWO
X-Google-Smtp-Source: ABdhPJzHitBRVQUjTGJd77zDS8/RmfsktOXnTvKp27tn361aFRIe3V8R6XkPZYRuH3Z5dp8Xj7+zrA==
X-Received: by 2002:a05:620a:13f5:: with SMTP id h21mr11601565qkl.415.1622675278335;
        Wed, 02 Jun 2021 16:07:58 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t9sm763146qkp.136.2021.06.02.16.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:07:57 -0700 (PDT)
Date:   Wed, 2 Jun 2021 19:07:53 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <YLgPSZ9LB/LErNw2@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bcachefs is coming along nicely :) I'd like to give a talk about where things
are at, and get comments and feedback on the roadmap.

The short of it is, things are stabilizing nicely and snapshots are right around
the corner - snapshots are largely complete and from initial
testing/benchmarking it's looking really nice, better than I anticipated, and
I'm hoping to (finally!) merge bcachefs upstream sometime after snapshots are
merged.

I've recently been working on the roadmap, it goes into some detail about work
that still needs to be done:

https://bcachefs.org/Roadmap/
