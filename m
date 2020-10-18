Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFCD29189A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Oct 2020 19:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgJRRUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRRUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:20:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E52C061755
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2020 10:20:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a7so10296158lfk.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2020 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1V7Qd+tT9snodNPvx1s+YaGG5MJsGONwzS0wBjxyVs=;
        b=KxW6Bu+SMLe5YIdtqCmf7o+2aLll58MV1mpU5St56ReH2SgDk3CB7Gt2GOJCOlNfMy
         drzmEd+YUEXg2e+CbiPEQtD8I7Yact0gq8G/p7hIw1Q6Cq6AELtqWiDsVT+QeXvKh3eU
         gxTcXeKhy+O1F2TDj3dY6F6qQz1vzx+vQwtxFvI8zFcayDQh7VFOl/k/EB5fobu/0RlL
         NFLkeFal7xcOWbd9i8TMqGRiBbZgBsG07dvxPpeAeh5xbxCnaeBTkiAw5iXtUyVfCe0P
         869nF8KVqdtyAC1dm4a4e9RgGywXsj9MlzY/jGreYCVrB+AHek5axT+JTSpFvQEa9VNK
         N75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1V7Qd+tT9snodNPvx1s+YaGG5MJsGONwzS0wBjxyVs=;
        b=lFIbwWrlg0wsayr60XV0u3hWlVByDdfbgz4bacW1IocoafFhw6dL+LAUy1sq0S7jn8
         NMc2L6B5cQ0pGjZntJHhRhNhxHUdKcsd25NoAl2gu4KYXMtK29zZA0goh08eiA+C0x2g
         3t9z/3VtjcLmEN9hOyQ69vih9qHy5thz8haUN1p8lRlyRsKHz5hMk1/ASr0+pwa0MgJf
         lDf4gme4HZhszDdHB0j5v6TdCwYdEI31Kwj+Y6ULKQpIR11x46sqSeZGsCVEVjL/DCdt
         I4eqAy0qHkU/IISOuvinEyfluk7tp6eh2aqJSwVmcqwHKGY+fNxDo2XRr1MJZ3AWAJef
         Okvw==
X-Gm-Message-State: AOAM533bpenQbCtkMRZsrClRASuPPSVLumSqkRwk3B+1Fhx/Pgh9e93l
        R18JHfD68rFIlB3KqLl8Op6/Cy4q/KynjN9Hef8=
X-Google-Smtp-Source: ABdhPJwn6LjAKA4hZzi5+DTOURPux9hkPr02EiuMeS/qgBW4k0fPurCyNEqvB01SvLFX5UqN4WuY0xeGC/g10coX35g=
X-Received: by 2002:ac2:498e:: with SMTP id f14mr4252088lfl.452.1603041629632;
 Sun, 18 Oct 2020 10:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <bug-209719-27@https.bugzilla.kernel.org/> <20201016133301.aaff2b261a0afe5e15a32138@linux-foundation.org>
 <20201018072801.GA15414@lst.de>
In-Reply-To: <20201018072801.GA15414@lst.de>
From:   My Name <haxk612@gmail.com>
Date:   Sun, 18 Oct 2020 19:20:18 +0200
Message-ID: <CAMSqM88HRMPR6Ca+Wt30SbLSgDz+XA-M3ZY9moq=cbgjwtRUjQ@mail.gmail.com>
Subject: Re: [Bug 209719] New: NULL pointer dereference
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        bugzilla-daemon@bugzilla.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This is already fixed in Al's for-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=4c207ef48269377236cd38979197c5e1631c8c16

Amazing. Thank you
