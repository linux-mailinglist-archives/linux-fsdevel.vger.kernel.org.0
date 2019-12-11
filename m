Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDC11A35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 05:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLKERB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 23:17:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46033 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLKERB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:17:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so22415347wrj.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 20:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PQ5rQ3wik2ixjrnLCweqtH51YItg+G/tGkSEH/Bd+Yo=;
        b=GVzEL5EqPxao4ATXBC1uVCO2PZIvALYAVuqVMLM6V+m5cuD8kvlemT76jeSoYoCDHT
         dpRTFFiRSzCcgUHReyhfNcZDnp3KFmgfpa4l+/z0pFX9Ck4DLsx5Br7HOegBp41QZWYz
         3pE8gqCV8V4g14+3KFP1sK9L53UxAzrwCflAv9VtxPQWOCeM1Kl+MxFfnijJRupWtPmD
         EF9aG86Vk/Nlughme+BmHSaLZnYAxA/0BxBPLBmdXR5QI4h+rH9F+w0d3zFn94hTkAPt
         VNfJiMDfe/wMl4wDIGx+I8GV6OKwQTTcF3Oi1nGfhJXmMQS204j81yXGK/C4tmYDO2nx
         6E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PQ5rQ3wik2ixjrnLCweqtH51YItg+G/tGkSEH/Bd+Yo=;
        b=SlAOaifX6DFrBk8XSc9p2CrX0It9bZwM0kpKSmYf/S5zjoWU5mdzpqymaonMTzm+9J
         xbsbIBo7mo/OXgigjVJqrf5V16HeQ/IjxakoJOwZ1Ynxg7P83qDodLnPJSDEHCyVMOIY
         UogdEcFr4k+Zd4OReRn28JXWvQCLxrDoLt/n6gHq5AMDGMVGGoLMD5bA3V5YHoJ/oF/N
         wgpLZj1ay25ehSm2eNYf964v7gx5tuiShx8Bvol3dZe3iku+KJLpas6Dq1Cv1fjp6cEB
         2QxfxG28KJN9xrCB2MCtiXXqhTZQ9XD5NPOUrBnpPWOQjYQJz8i4NpRSFtuHvT0rUTwq
         Geyg==
X-Gm-Message-State: APjAAAWjh+rdm59Wql/fq6JnXScIInohe1dVvvbDo4UfZS6/SfE1TLAu
        EwAL3k9bMDGfqcs8zjmZVp3nzrjbPAvXZtj0epOIcmP5snk=
X-Google-Smtp-Source: APXvYqwl6qFn1LVxKBJzKSwhIs7tv8ZzsrrES/IkSkJvGkgvu8ob4nnFpE1dLC5qRAZ2qqo5uc5n8QHPUULTf4uJ6cQ=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr1105457wrp.167.1576037818100;
 Tue, 10 Dec 2019 20:16:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
In-Reply-To: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Tue, 10 Dec 2019 21:16:42 -0700
Message-ID: <CAJCQCtRSQgptZ7_Pez8FjHN6cErShOG1F7BRdYciGq7Fb=fL_w@mail.gmail.com>
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OK this is interesting. It took 7 hours to hit it the first time. And
the consistent reproducer I've now run into twice, is 'dnf install'
any little rpm, which is what I was doing the first time I hit it. I'm
not sure what about dnf or rpm is triggering this,  I've got other
things doing a bunch of small file writes including Firefox - yet
those don't trigger it.

Next, I tried a couple more times with compression disabled, and the
problem doesn't happen. So it does seem zstd related. Maybe.


Chris Murphy
