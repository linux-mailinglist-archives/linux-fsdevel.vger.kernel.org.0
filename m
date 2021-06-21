Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858393AEB7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUOhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229904AbhFUOhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624286118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcdM90aFyzpmBfIEmynFS30R08h2JZ35UcTBTXT0GdE=;
        b=KWs+E+CJgMSa1MX2pK8DiQjVHlMomkDjDokL6Ghp2nNw9mWb5S0SmdGunXEb/YRxq49DmD
        5GwutLI6mXQNcogE1GGd0fR12h4AZi6Vzmq7k9l4nDTglz/RP7wBVLbt6B0jEYZK7SoHDv
        t1FbUj7k94+HJZbL/zbffLO3W4wHAM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-35pCgBqWOJi6KcRyqBnS-g-1; Mon, 21 Jun 2021 10:35:17 -0400
X-MC-Unique: 35pCgBqWOJi6KcRyqBnS-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF3CF802C80;
        Mon, 21 Jun 2021 14:35:15 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-230.rdu2.redhat.com [10.10.113.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60B875F714;
        Mon, 21 Jun 2021 14:35:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EB29D22054F; Mon, 21 Jun 2021 10:35:11 -0400 (EDT)
Date:   Mon, 21 Jun 2021 10:35:11 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: support booting of arbitrary non-blockdevice file systems v2
Message-ID: <20210621143511.GA1394463@redhat.com>
References: <20210621062657.3641879-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621062657.3641879-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 08:26:55AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support to boot off arbitrary non-blockdevice root file
> systems, based off an earlier patch from Vivek.
> 
> Chances since v1:
>  - don't try to mount every registered file system if none is specified
>  - fix various null pointer dereferences when certain kernel paramters are
>    not set
>  - general refactoring.

Thanks Christoph. This version looks good to me. I tested both with
virtiofs and 9p and it works for me.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

