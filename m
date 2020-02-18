Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564271626E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBRNNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 08:13:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726399AbgBRNNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582031603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DneqNBaeKl30A4lHYYXDk7nbntMeSJHFCdPwU3Dd7r0=;
        b=e7ZbVRy9uzTWgMrjTp6Inomet5CD+Jh6r1G29IEdSZJxfXF1S/ow5XbfvJjPB8Dmp0+MJX
        MeK7bsYjnRjQ5qOPjqed1ov1v2VjpUq87CTQe1bCt85uzGzSWxCJo1R6u8a12/LoXqCY4k
        91cFjtkQCeyBDPuyjFSmiRs2/XDvQhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-WjNRynsvPka-WfvdHqDJ-A-1; Tue, 18 Feb 2020 08:13:19 -0500
X-MC-Unique: WjNRynsvPka-WfvdHqDJ-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B973107ACC5;
        Tue, 18 Feb 2020 13:13:17 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9195117DC8;
        Tue, 18 Feb 2020 13:13:17 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7113535AF1;
        Tue, 18 Feb 2020 13:13:17 +0000 (UTC)
Date:   Tue, 18 Feb 2020 08:13:17 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Message-ID: <1266014959.9253821.1582031597225.JavaMail.zimbra@redhat.com>
In-Reply-To: <6d7a296de025bcfed7a229da7f8cc1678944f304.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org> <6d7a296de025bcfed7a229da7f8cc1678944f304.1581955849.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 19/44] docs: filesystems: convert gfs2.txt to ReST
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.36.116.223, 10.4.195.22]
Thread-Topic: docs: filesystems: convert gfs2.txt to ReST
Thread-Index: qxr+GACWnS4WZWTu8uqnXP6mn5UE7A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add table markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../filesystems/{gfs2.txt => gfs2.rst}        | 20 +++++++++++++------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 15 insertions(+), 6 deletions(-)
>  rename Documentation/filesystems/{gfs2.txt => gfs2.rst} (76%)

Looks good.

Acked-by: Bob Peterson <rpeterso@redhat.com>

