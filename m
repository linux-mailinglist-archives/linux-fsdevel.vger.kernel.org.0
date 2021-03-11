Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804DA337660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 16:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhCKPAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 10:00:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233725AbhCKPA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615474828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7dGb8aQpMhoqKwBw4i+yc0H4oau0lAYady+6ZggTSw=;
        b=Y/GskKnj2tg0MFgo2e8Z+NOYrZaUWM7e09If3KVZL+q8M1ZCLstn2r67NczCGYr2QEXMvh
        qYIrWbhK+7mkEgdxGmUkZgkC4iwmTpf2uw8/yx+y3xrPoCy+zWV7UiSwAyoPcqnSizqz1C
        lU9x/5z1mc+oe1AEKuariH2tPGlGynE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Ryi0ezYOMvujvC9EaPIhzg-1; Thu, 11 Mar 2021 10:00:24 -0500
X-MC-Unique: Ryi0ezYOMvujvC9EaPIhzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5B79100C618;
        Thu, 11 Mar 2021 15:00:22 +0000 (UTC)
Received: from T590 (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86B0A10023BE;
        Thu, 11 Mar 2021 15:00:10 +0000 (UTC)
Date:   Thu, 11 Mar 2021 23:00:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: rename BIO_MAX_PAGES to BIO_MAX_VECS
Message-ID: <YEowdj5x93RoUqhN@T590>
References: <20210311110137.1132391-1-hch@lst.de>
 <20210311110137.1132391-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311110137.1132391-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:01:37PM +0100, Christoph Hellwig wrote:
> Ever since the addition of multipage bio_vecs BIO_MAX_PAGES has been
> horribly confusingly misnamed.  Rename it to BIO_MAX_VECS to stop
> confusing users of the bio API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

