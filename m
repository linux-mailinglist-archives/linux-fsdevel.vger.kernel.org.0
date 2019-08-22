Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6638992E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfHVMIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 08:08:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33734 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfHVMIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:08:51 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so11365745iog.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=520se0nJfNKPG2/Wz4PIwZz5SiY0VWFLLRH0Zcvx2oY=;
        b=FsOiGCbS7aBVKwLe8MVNcEaj2tS6nLpT41vMAhq9W69EaCdCd+goFlDxqBQDMDMXVx
         fRLTVoUv6WbaiJfEVoKr7u81RWmyUq2S5e6ut97XwlgjBj/hwOHGyaI8w8vv8DCiWpSE
         4/o6Qbnnaw8/rN1Scxzz2XE8iXhbqpugRVqB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=520se0nJfNKPG2/Wz4PIwZz5SiY0VWFLLRH0Zcvx2oY=;
        b=uNGcOzmOSKiXeGDq6zk/ZhEa0r998i2bjYAR1IkrM1hlrfWunySBQKF7pFO0W9zSOv
         aoAN/sHZjFG7vWF0nVp0xdJ39v5Yt60PIs//L2W8JH/mwFwCbsVOlpmtxrwkck2ynuJM
         2zho36HQIAjxf4AlXZ5+3TIufn+wpwyJ4dfxAp1YIEqlKXFqSM5/zQUhmg1HKs7bFuTn
         xk0qI7o0WTTqZrBtMWXuINxhdumD9o/2eHlZY4DxjoF61rjTPrR41fgq5+r01fwZjBRs
         ZjVZSCzrgqRFlxDzVG9XpCn7AYXa2QRG+3CcObkjUrjQLr3R+xSXKKNk2q0GV1YDYygF
         pFig==
X-Gm-Message-State: APjAAAXDV/RHWj/pzw3Sk8QjBE3PvCoefw3NKaDPNXB4229J0HpnEzeF
        67AmJzJhb/+uUfMYC257IqgckYED14SSbZ5dHXQ7Dw==
X-Google-Smtp-Source: APXvYqwYdxcCNf6vhP9MujNLZaK2Lw+Vul6b6vcxaDRoOQDGwDGWAGlNfsvJ+q9o9dVl9+cM3bSovsLce5QGVIpfS14=
X-Received: by 2002:a5d:9d89:: with SMTP id 9mr3814565ion.212.1566475731214;
 Thu, 22 Aug 2019 05:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190822073300.6ljb36ieah5g2p55@XZHOUW.usersys.redhat.com>
In-Reply-To: <20190822073300.6ljb36ieah5g2p55@XZHOUW.usersys.redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 22 Aug 2019 14:08:40 +0200
Message-ID: <CAJfpegsJCpabQ7-pag9KU+NmXyrtJPauQi4poO9B9rZADLLvzg@mail.gmail.com>
Subject: Re: [PATCH] fs/open.c: update {m,c}time for truncate
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 9:33 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Just like what we do for ftruncate. (Why not)
> Without this patch, cifs, sometimes NFS, fail to update timestamps
> after truncate call.

Digging through history:

4a30131e7dbb ("[PATCH] Fix some problems with truncate and mtime semantics.")
6e656be89999 ("[PATCH] ftruncate does not always update m/ctime")

These are pretty old commits (>10years); has anything changed since
then relative to the required semantics for truncate/ftruncate?

Thanks,
Miklos
