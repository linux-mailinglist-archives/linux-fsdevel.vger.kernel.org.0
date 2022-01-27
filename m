Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1649DE59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiA0Jp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 04:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238823AbiA0Jp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643276728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgdNOmxVZp1dDFXB5FAwhB64SXYVLfcMpBsoeczfvek=;
        b=ccKV2WIoPfnEclmmfYpjb+YO2n0GrUxccMxU/Grk8QV2nLpEp9Qk5YcQUr0a/LxvrIFrO/
        8UThghP8Ac7e3J78cI2nayucf7nf6eg4V/XYOcE3ibrNu/jTk14FJ2iF9faImlxH+g8yGa
        rM5c/karbfHj7GDH2addd4/6OWNeTFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-1dA_-dmbMEiTj6c0TdnXSA-1; Thu, 27 Jan 2022 04:45:22 -0500
X-MC-Unique: 1dA_-dmbMEiTj6c0TdnXSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0788883DD26;
        Thu, 27 Jan 2022 09:45:21 +0000 (UTC)
Received: from localhost (ovpn-13-51.pek2.redhat.com [10.72.13.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 816896C1A7;
        Thu, 27 Jan 2022 09:44:59 +0000 (UTC)
Date:   Thu, 27 Jan 2022 17:44:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Convert vmcore to use an iov_iter
Message-ID: <20220127094456.GD13508@MiWiFi-R3L-srv>
References: <20211213143927.3069508-1-willy@infradead.org>
 <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 01/01/22 at 12:36am, Al Viro wrote:
> On Mon, Dec 13, 2021 at 02:39:24PM +0000, Matthew Wilcox (Oracle) wrote:
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> A couple of notes: please, use iov_iter_count(i) instead of open-coding
> i->count.  And there's a preexisting nastiness in read_vmcore() -
> generally, a fault halfway through the read() is treated as a short read,
> rather than -EFAULT...

Willy must be busy with those tons of folio patches, since I have acked
this patchset, I will update them as per your comment and repost them
with v4.

Thanks for checking.

