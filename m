Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE9390E0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 03:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEZBzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 21:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhEZBzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 21:55:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD0C061574;
        Tue, 25 May 2021 18:53:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g17so1123804qtk.9;
        Tue, 25 May 2021 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z5EbPy327867YcKmvP7oFErquE6ILB03Efh2jyvdUgE=;
        b=JDPqmBeXiw9KLPtgi037lL76EBLj82h5nn2/FWwDSF2qJUYZLugvQOKExbDkhXWQN7
         izaqGUrOt7aES4wN8wxJQ5qW6b4FrgS19d3Y3AihXMoUJlKIq1oubYg4c17Yf/CKRxWj
         eJXZzEXnXIM228UHyQwUmcI0QsPg1D4RcalK2tWRBhK7ROH4+uWiak1NXqCiiUvKkFJR
         Va7WGULdd/3mfA3dBc7IPP/4h5816xk/xcUTOzBln1wq1exA0E/kw0K+4ZWMiwr1T1jg
         jNwBVtU41rHdsmhggrEwB2366NyEUTtwwPHpuj02YcSh7wqgMg3OlBx8ligaOv2XinnP
         LxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z5EbPy327867YcKmvP7oFErquE6ILB03Efh2jyvdUgE=;
        b=LyMe1Dl2r0OOPu/+hb+M511zj30fcoFgkM3zWgsUK0it6y6j6U/HR/C2Z5Vx69iD8I
         BRqThuMqJQVjCoySyGVe1SiIqe4xxZjEBYXh3od0UdN7C7YAsdJfzYuKu81XHjjUIW+6
         eiB1f8W9pd+bjAAAbf4j+7slthdpZqbT+DdVtiM8fTvQTvLzh4N9WMAj7ncUZO9w7G+u
         kNBpH8Q6p2eTTv3KU9wHMu7L1TVXcsqXKQF6Dm7xZh37nVfu8a61wb8s6pPEL2O/7Niv
         PZvWWdT9NO/KR1utcI3H6K7m0KR1E1g79gI/p39jdIwt5NKitz1/Z83BT9m6+lqaDcHl
         989Q==
X-Gm-Message-State: AOAM5315x4dG2U7QoSEL1GNvOe5JjrkX/OvF4nYnX9PKxaypm5zdRIp/
        gwuw1uhEUDzwXZV5Jy81WCx7ZFIB9cL6
X-Google-Smtp-Source: ABdhPJyFePqFktGCt7HWdDsH+oU6KbhxsMmTgna0VHaTWjSR42/DeDyJ201BXc2JX4Kn9QT6DD4Myg==
X-Received: by 2002:ac8:7dc9:: with SMTP id c9mr35210838qte.169.1621994031617;
        Tue, 25 May 2021 18:53:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r3sm606891qtu.50.2021.05.25.18.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 18:53:51 -0700 (PDT)
Date:   Tue, 25 May 2021 21:53:46 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] generic/269: add _check_scratch_fs
Message-ID: <YK2qKlYgnfd/eX62@moria.home.lan>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
 <20210525221955.265524-8-kent.overstreet@gmail.com>
 <20210526013418.GK202095@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526013418.GK202095@locust>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 06:34:18PM -0700, Darrick J. Wong wrote:
> On Tue, May 25, 2021 at 06:19:55PM -0400, Kent Overstreet wrote:
> > This probably should be in every test that uses the scratch device.
> 
> Um, it is -- ./check runs fsck on the test and scratch devices if you
> _require_test or _require_scratch'd them (which this test does).  What
> weird output did you see?

I could've sworn I had generic/269 pass until I adedd that, but I just rechecked
and it's doing what you describe - my bad, I'll drop this one.
