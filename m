Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2590C1572FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 11:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgBJKqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 05:46:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29506 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726796AbgBJKqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581331594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rJyaXpulyANGo4zDbEZv1lCadcKmM1gtSWvOSX66ZQc=;
        b=CcLXSekWyXnR51+HD7wqe76ExOrCmoiSOH5NLeSHBXAUvZ6DgbL84MeTEaeC9SQksLuBGG
        I6gEwJww/LxyI8yC4W3GEU00MhYJWSI41yOfV/XsWN87WYYWfRYcqubiqQUa3NagfSXEvQ
        8iV+lQ0kgHqPm4467U9wrKFpxuF8G2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-DvjGlNtTMnyrPLq_eE67TQ-1; Mon, 10 Feb 2020 05:46:30 -0500
X-MC-Unique: DvjGlNtTMnyrPLq_eE67TQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A2713FB;
        Mon, 10 Feb 2020 10:46:29 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1126F8AC21;
        Mon, 10 Feb 2020 10:46:28 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.4.3 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <06eaa4cc-3851-295c-9cf3-ff70a07e6ede@RedHat.com>
Date:   Mon, 10 Feb 2020 05:46:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

In the release a lot of work was done to bring the internal 
rpcgen command up to speed. 

A couple new mount options nconnect and softreval were added.

A number of compilation changes were made to enable 
compiling in other Linux-like environments.

As well as the usual bug fixes.  

The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.4.3/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.4.3

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.4.3/2.4.3-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.4.3/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

