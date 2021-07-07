Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1F3BEA6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhGGPMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhGGPMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:12:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F8C061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jul 2021 08:09:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p21so4573667lfj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vct2bf/Df45LtJ8h+yLbO5LtETmr552t+vio+cdjjQs=;
        b=gnPBHqWp0mxaKMHE7t3NAtkDN2wlzks8Hm5Tc1pdtwcOxsTwnKdOihhEhhzyO1YDgp
         kfa/YcBffhH04lc2zl1SYMzw3ukhcEgC4ShKTulUKePez4yI7imzeqBOceEG3A3C+lyl
         fjKv4r0kdFpR6SZmig+g6WrmIi/xnoxXC7f5keif2k9bquAW6ykKiJiCFjXCiFj+Y8ST
         zF4ujvfeErkwBMCzvf+VTkWgVUbyL9oYWbE7T7NSsc5I6clY/bKRSAPz14yw1muAl4oj
         FUbfFQwInABaen78iN0Dg621qtaiQgfHnqhz3VdhyfJ529ihokBqaaBotHWTFwvuXouM
         etDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vct2bf/Df45LtJ8h+yLbO5LtETmr552t+vio+cdjjQs=;
        b=joK9yJv5QHIlF99Bd66pz/INQIyaX9HV3jq0aD9Pmf3GJP8sTEk4H+su99S+IqJ2wG
         T7uQKGIdghnWdRql8oA/dqlp82KFzv+4jbUBTwCe2wtmUGCwrMGS383eSlWMAI8/msBI
         PiKT/IHGdNnN7IJ2AGklGYiEcG10rCDucUuQxT42Pu6/Us6JnULsQImYiugQpbINoU0X
         BDKI25fmJh4TsMxBV5PQgfXNnMz3wqnGijx4zHj4ouJ2FLuOAFaUqEhO7++D68P3GYKP
         /x9y8J9cyfb2l2tXjg0dDO1VjmDV9CM3LrdL7D6T38mtDT8UrA6er8VtWtK+hVl0vjEV
         uHkg==
X-Gm-Message-State: AOAM532kRoFWS82RQmX5Ob4guqedqOT7rZrHn6J/yaAGkxFo9xZ9vN2i
        hdc67s5BfVJLZ389Y8NzPSc1xSU9hphpIjF1mtg=
X-Google-Smtp-Source: ABdhPJxMgpgaImgzR8lTMeAGc+NhZ9OSqYsxwTxhQ25+1TKVh7o/DjfwLXgR6/qC0fENSIWqrkMazy+Qk3q+yHfxgWA=
X-Received: by 2002:ac2:53aa:: with SMTP id j10mr515060lfh.184.1625670571382;
 Wed, 07 Jul 2021 08:09:31 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 7 Jul 2021 10:09:18 -0500
Message-ID: <CAH2r5mupFZHQFM+aYgCMQ9Whh67LfnSLg-Dsu4jasvtz1Ap0oA@mail.gmail.com>
Subject: dead code in ceph
To:     Jeff Layton <jlayton@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Noticed that with the netfs changes to Ceph (removing readpages eg)
looks like some minor things weren't removed from headers e.g.

# git grep readpages fs/ceph
cache.h:int ceph_readpages_from_fscache(struct inode *inode,
-- 
Thanks,

Steve
