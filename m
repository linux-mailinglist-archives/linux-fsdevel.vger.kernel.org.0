Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19FF17FFE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCJONC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 10:13:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44459 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCJONC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:13:02 -0400
Received: by mail-io1-f68.google.com with SMTP id t26so5137308ios.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYU1wxb/ge5DirIWwK28AnywpJQY3e/U9vYLjiccLeo=;
        b=VUMeVtRyDXOmmJAxS6+A2yYelERcpsMobnU+K+HXqAre31LWH5Ybg9m1IevwykOAC8
         LuhKNNqsEpPoC+7agcvG1rpEStM2V2YpmRpy+BjS+BXwOrIaMeNotiWCXzqWdLczA50g
         BSV6AlSgpI8eO6i/dsioSkintiC6wBXLVK/So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYU1wxb/ge5DirIWwK28AnywpJQY3e/U9vYLjiccLeo=;
        b=YemjeGbFb89UmTxci0+R3tRhzA4t0X73sUdukBKcXJyR2XR6IG7fMbtsTNaNNc6NQM
         BGzC8ZQ8a/qazATsREW8d3BTm1PJR8SY+xIdaWuHqUf5kN6IjkKOy4wxI8z623QdTVfW
         636KoEy1bCG+jbw6kvSnowLucLlKVT5tmjVBKXr9fukXx7FLLbtJR1cObf8FQJwf4bng
         3L4uuglmudVQOwJZ5rMPpZRg3UR2aiVlI30ZK4KmT5tNsNjYN/smKBxINayGwNSmrDB0
         Afqvus38E5hHm51c+/ux7eggIkXuNEO1jmsd8iVOdqEfMTxIEmQXmefakyISBlTVrD86
         65lg==
X-Gm-Message-State: ANhLgQ1rKLcyjqMkc8ceONKMcHQwsi7gN7YbvrdrG5e6VI/QP7feC7F4
        v9N13axf7+obJwbp2oRujb5bf3VDWBaaADZktF0dWw==
X-Google-Smtp-Source: ADFU+vt4UJTT+vs/UI2ECs5CVHI9EXdfAc9QZZ6Sp885Ay5Ze3oaL6r9lcZCZ0eNm46t4uWRe96k4C0dQKTFbWt2E9E=
X-Received: by 2002:a5d:934d:: with SMTP id i13mr17966092ioo.154.1583849582112;
 Tue, 10 Mar 2020 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-8-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-8-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 15:12:51 +0100
Message-ID: <CAJfpeguxR2mR53BHEaSQUq2dN6mUVQHMVCoECrCX1F6x38M-0A@mail.gmail.com>
Subject: Re: [PATCH 07/20] fuse: Get rid of no_mount_options
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This option was introduced so that for virtio_fs we don't show any mounts
> options fuse_show_options(). Because we don't offer any of these options
> to be controlled by mounter.
>
> Very soon we are planning to introduce option "dax" which mounter should
> be able to specify. And no_mount_options does not work anymore. What
> we need is a per mount option specific flag so that fileystem can
> specify which options to show.
>
> Add few such flags to control the behavior in more fine grained manner
> and get rid of no_mount_options.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
