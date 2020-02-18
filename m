Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6891626F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBRNOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 08:14:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgBRNOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582031642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srX5oBCM6z4Rdiradg/lp6eUVlaigPn3ftTSiwEX5uY=;
        b=NGDlkfCv6UoCHK4iSQftO4i/Qy+ow31ImTtvIvc/xhMqwbOFO9Fo2TED3dxvNDl0Mkxp1Z
        zYwq7aFRLI78VqL1manhkJvadXBFtjBHsSs+EAlKCXcIcajE65MaDRCJWxhU52fjZ5XVQN
        D6TbtPjilqf4QDrq52snEoqZazCat6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-807tip2mNdmZ65o63FgD5A-1; Tue, 18 Feb 2020 08:14:00 -0500
X-MC-Unique: 807tip2mNdmZ65o63FgD5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAF441007276;
        Tue, 18 Feb 2020 13:13:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFF6F619DB;
        Tue, 18 Feb 2020 13:13:58 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CE42918089C8;
        Tue, 18 Feb 2020 13:13:58 +0000 (UTC)
Date:   Tue, 18 Feb 2020 08:13:58 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Message-ID: <340949318.9253893.1582031638792.JavaMail.zimbra@redhat.com>
In-Reply-To: <1d1c46b7e86bd0a18d9abbea0de0bc2be84e5e2b.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org> <1d1c46b7e86bd0a18d9abbea0de0bc2be84e5e2b.1581955849.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 20/44] docs: filesystems: convert gfs2-uevents.txt to
 ReST
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.36.116.223, 10.4.195.22]
Thread-Topic: docs: filesystems: convert gfs2-uevents.txt to ReST
Thread-Index: fh9CKZQJOdebSJOFTYg6XetmhmQ5Jw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> This document is almost in ReST format: all it needs is to have
> the titles adjusted and add a SPDX header. In other words:
> 
> - Add a SPDX header;
> - Add a document title;
> - Adjust section titles;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Both patches re: gfs2 look good.

Acked-by: Bob Peterson <rpeterso@redhat.com>

