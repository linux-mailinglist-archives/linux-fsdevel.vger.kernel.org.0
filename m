Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603C017FFF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCJORE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 10:17:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40725 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgCJORE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:17:04 -0400
Received: by mail-il1-f195.google.com with SMTP id g6so12125648ilc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHUlshbt0krVyNx6H5AQrYmBp/rsTRhM/TkVqLTK1cA=;
        b=DWyZY+fN2f5GWPycqc6nfqGuuLyjg3vxp56EkljIp4CFmK4rlXVcYb7WGIIrBmtWz9
         NR+EjtBnZDRvDuMV/aRpSTLTMaQIfWG4nIPbzPJwAM0W39llvBvEuEw3xVXPour1P6cG
         OnrgRxf5sAH77uw+c4f2x0E2WfazdfWrmdTjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHUlshbt0krVyNx6H5AQrYmBp/rsTRhM/TkVqLTK1cA=;
        b=Tai+p9iG+qhBqqAADhJvcvZUddL0DM3H8tbddwMBvdPsJgADEgyBOkd3Gc80Era5sq
         +K8moAx9rLcDXL38ybCAfs0uY0xq8FV0fsqOSZXHmLsWyBZSLETTkNlxDIvVB06+CQET
         R87BYQULGgXcRMv0e2n8SJebU4n73yttD2T8rK2xYl+XyuaWoxYzWgGEI/C+296IHjwC
         aeBE3jcJfH+LEv28QfRKW7iBXg1NPWSsDudFVMVFJF0DB6DByFU71lHjD45Xkxt6Yt2e
         Vsdd9O0GuLSWg8vt9A4JJyy4OnmHzYiQlYZgRn+7xCmboIJ7JjqpcGQht9zhR6te/XVz
         J2VA==
X-Gm-Message-State: ANhLgQ1PbhXB75HAL8p7sIyDUwc2EBCbex5yWGmy0Cqn/BmD6WPEnMHL
        9L62x4ux0VivA1+3La2opba9tV5EjAWTD3VHhcPPxw==
X-Google-Smtp-Source: ADFU+vtV/3QnmLNUezgyv8VStO5uYY+S+sx5ZNP2mhhnVIGPPCKJl2hcyaOkIWXF/dIC/PIi4nqGuhZAh3mfFWAL+mg=
X-Received: by 2002:a92:d745:: with SMTP id e5mr20045107ilq.285.1583849824037;
 Tue, 10 Mar 2020 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-9-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-9-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 15:16:53 +0100
Message-ID: <CAJfpegsY1LBe85-Dx49LwM9TOrHE0aQq1CAtZQdYr4pYn5tBbg@mail.gmail.com>
Subject: Re: [PATCH 08/20] fuse,virtiofs: Add a mount option to enable dax
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
> Add a mount option to allow using dax with virtio_fs.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
