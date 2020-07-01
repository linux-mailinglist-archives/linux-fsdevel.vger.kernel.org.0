Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2852107D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgGAJQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 05:16:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgGAJQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593594995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bir7bqjcJgYEot4xBxckFswPYyAETyRptlOPMzbduK4=;
        b=QnadbUsZbLTN5/jlkP6POk5KgfIcrNMeTzo2Tz/I1qkv1d5MK4Al7uqH7AmJu2t2qvBZX1
        euZwal7ot7dJ/rlvdEhB+Fx9P7vA4PEUDEMgFTmcQUEv2zkNHLiLq9QK9MzUc6s8GygnyY
        IOkUjwzvhn6Nbd/33/melJpUKM81KTw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-9H6mYgpwO6mWvetYh-pyMA-1; Wed, 01 Jul 2020 05:16:34 -0400
X-MC-Unique: 9H6mYgpwO6mWvetYh-pyMA-1
Received: by mail-pf1-f199.google.com with SMTP id g85so4949707pfb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 02:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bir7bqjcJgYEot4xBxckFswPYyAETyRptlOPMzbduK4=;
        b=ENtV1WY18JzhIsAt4iBA/yMol8NWsXAxLTLEGTWiC3Xs2kKlugCWcPX1dNO+VDsjWg
         oKzsWL89MyJptrEJLmSCw/elyRoGlYIvfXpcbcTvx+GXKZo5wA/9jlE0oxwenlbZ3FgI
         CG+ycgNEvba5ZCBiAnbYvuK3zXdUm3wQjfeR0so9TuUMxTpt8WyDSR+YzzFbPj+2T3ed
         U1Ra6/b1wDkD+0WVMRUbltGp5LSieQjPLuOUsJO4V8nBKBHih8uHHGFFm3PKtuDaYe19
         esPySzMpajbK2zNM0hUqVXBiOuL8fukIqOxki0KYaGra5zWux/vEdhROYah25jTM19/A
         bdQw==
X-Gm-Message-State: AOAM531dv42v0w5c7adV5tmww5zoeVBQLg4rlIt+9Yd1KsNVt87sTB40
        pJiQWiPMKtz7QcIkkxVG9k3E12Je4W2S/n0573XKcdVW5Ai5CPl83oyj1k3xWtnGyWKnXPvZWal
        uOhiz69nP5J+yVQt4aP/ZTpnTXA==
X-Received: by 2002:a05:6a00:1342:: with SMTP id k2mr22670770pfu.32.1593594993512;
        Wed, 01 Jul 2020 02:16:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQMFIc/PWlagM5muWuijz1ziAMv88d0MVJCM3+aCsE+fzjpDjphfTL7QLKhA0nRjttqGaYng==
X-Received: by 2002:a05:6a00:1342:: with SMTP id k2mr22670744pfu.32.1593594993229;
        Wed, 01 Jul 2020 02:16:33 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nv9sm4869318pjb.6.2020.07.01.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 02:16:32 -0700 (PDT)
Date:   Wed, 1 Jul 2020 17:16:22 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     lampahome <pahome.chen@mirlab.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Subject: Fwd: Any tools of f2fs to inspect infos?
Message-ID: <20200701091622.GA5411@xiangao.remote.csb>
References: <CAB3eZfsO0ZN_79oaFpooJ32WNZwwyaS4GBb+W6jR=buU-VczAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3eZfsO0ZN_79oaFpooJ32WNZwwyaS4GBb+W6jR=buU-VczAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(cc linux-f2fs-devel, Jaegeuk, Chao.
 It'd be better to ask related people and cc the corresponding list.)

On Wed, Jul 01, 2020 at 03:29:41PM +0800, lampahome wrote:
> As title
> 
> Any tools of f2fs to inspect like allocated segments, hot/warm/cold
> ratio, or gc is running?
> 
> thx

