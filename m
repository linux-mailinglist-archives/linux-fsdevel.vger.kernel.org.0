Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55B392FA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhE0N3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 09:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236357AbhE0N3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 09:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622122090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BO7od1PxAfFYzzcevAmxTO3TeLH1JFGJpXfFzNK4zLs=;
        b=Huuvm8iiIY2wEAoMU3HC3AhLpggXneg/LjozlseO5rb8tVo1otqIA47hkl4UwIK58WLtEK
        cnzjHLPjA1vF0MJ7mZARTLJrZy1wNuqpaUCPvCez/H2EcpirH/TyyipnSHDjaiiTZWIbht
        m9O3p3RowPhuOn4y8O6aRFB8DNNqRzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-k7I0iB0eMJKZWeqFw8pmjA-1; Thu, 27 May 2021 09:28:08 -0400
X-MC-Unique: k7I0iB0eMJKZWeqFw8pmjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96280CC624;
        Thu, 27 May 2021 13:28:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-232.ams2.redhat.com [10.36.114.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58A995D9CC;
        Thu, 27 May 2021 13:28:06 +0000 (UTC)
Subject: Re: [Virtio-fs] [PATCH 4/4] fuse: Make fuse_fill_super_submount()
 static
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
References: <20210525150230.157586-1-groug@kaod.org>
 <20210525150230.157586-5-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <db587ac1-f06b-6e6f-92fe-c94bd4849a51@redhat.com>
Date:   Thu, 27 May 2021 15:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525150230.157586-5-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25.05.21 17:02, Greg Kurz wrote:
> This function used to be called from fuse_dentry_automount(). This code
> was moved to fuse_get_tree_submount() in the same file since then. It
> is unlikely there will ever be another user. No need to be extern in
> this case.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/fuse_i.h | 9 ---------
>   fs/fuse/inode.c  | 4 ++--
>   2 files changed, 2 insertions(+), 11 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

