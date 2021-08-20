Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755423F33E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhHTSfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhHTSfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:35:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB1C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 11:35:12 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t66so11891545qkb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:to:cc:subject;
        bh=20/a0sZ2dzFKeddKBSkNEVtv2AMo9NoJrHJmvABR31k=;
        b=iraa4Yg2ZIyDuLWjWxoz7XhaITVgAYkL2+UmLSFrqzMB3Uvs29V23Zg5ZWoo3nSrSZ
         b0dXIrjTqoCGqlt1bugRacT5AbM7T5760fHd5UgMw48rJMdz4pQCKgkQqu+1q6icd7Lh
         tR4z5xVyYZXDdAyNdKWuDuKWkAVefKGJAU+UbRIwopG6QmTsWlPBx9e+xAAOzGooNbGA
         /5NPhzg0yAMk99xz4CasbFUmtvV3ciy4mALUH8pW1BZ0fEBCJlOUuEc8VXFVTaPaSSfd
         lX0gEIIFctA+XwIkf/dWjE4RhQP77SJUbdLGVanMyBnf0sf3Vbd62+dQ9ux2O4jgxyRK
         V1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject;
        bh=20/a0sZ2dzFKeddKBSkNEVtv2AMo9NoJrHJmvABR31k=;
        b=KP4fAepSL4BWyeaZh1G8WLrJYnVCi9DWveHZiq614rsiTUxKBEoUbKYRimXjbk2ndM
         bKYatfgmz+NMkR76cxY4h5DPG5A8RD0mP9XjWxw/PC4B3JcJ2X4YvffjiT1eDgq2GjDg
         8zzSuI9387YewU3I7u70Yp9qHh8ajxCqtoQI/S0Vht8iGuEzZH2lgg1+oBZEM8rw1HLd
         y+8dFty+AP/XipqHjOhtg2uUAfSuBa99+ZXNXcbYF1tptoZluUXsJqCpCgIOv3MfXDm4
         Zr9ORFr6MO2vEiwKMDFbLJXwe2NE6kdDg7ecGUejihTWePEI++z/IWZzqMLH8f9uk5bl
         sXPQ==
X-Gm-Message-State: AOAM532xODnNtrnsBgBZINDo4et7+i78VDnyPaAYAKTIzoY/5EN1U3Nx
        jWvzJVE5Eld/V6Fi8UtgGKgFDA==
X-Google-Smtp-Source: ABdhPJyu6VME/MSR6isTYWyYplihN92JlMd+BYrZuko4mFZdVnneppsOXB+uYbKpE5mJc8NKjPKd6A==
X-Received: by 2002:a37:9481:: with SMTP id w123mr10382554qkd.75.1629484511800;
        Fri, 20 Aug 2021 11:35:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p187sm3584045qkd.101.2021.08.20.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:35:11 -0700 (PDT)
Message-ID: <611ff5df.1c69fb81.43234.a478@mx.google.com>
Date:   Fri, 20 Aug 2021 14:35:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2021: Cancellation announcement
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Due to the continal assessments and growing concerns around the spiking COVID-19
infections worldwide we have made the decision to cancel the Linux Storage,
Filesystem, Memory Management, and BPF summit this year.

We are investigating dates for 2022 with the hopes that we can finally hold a
safe and productive conference.  When we have finalized those plans and are
ready to begin planning again we will send out a new call for participation.
The current board will stay in place until we can successfully host the next
conference.

We thank you for your patience and understanding while we continue to work
through this very unpredictable situation.

The linux plumbers conference is being held virtually, and there are several
micro conferences that cover the various topics that we cover at LSF.  If you
have the desire to still talk with your fellow colleagues I encourage you to
look into participating in linux plumbers and possibly submitting talks for the
appropriate micro conference.

Thank you again for your support.  Our sincere sympathies are with all those
who continue to be affected by this pandemic and wish for good health and safety
for all.

Thank you on behalf of the program committe:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)
