Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85994203A79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgFVPPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:15:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729278AbgFVPPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592838943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kqfixsov1eUqBEf3CJFifBVn1UXmhhyprdXFUKdWdgI=;
        b=MksJ0BYcTUS1o34VsnmqMV4HJqq2dzGfa8c0ng36XmKzDKWiuW1PWZF7wNMomexC0IYZCx
        8uHryL/op+LdIpAA2AuwpMQKQrhXoaShTAjYtQlwd4a2CLVpRzmOrPzZPNnwMxD/jcV/pm
        idJ5Cdptqaj0Tk3ev+iEYkQG1z9pvIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-aIZpwFwhOoOp7-U_khD76w-1; Mon, 22 Jun 2020 11:15:41 -0400
X-MC-Unique: aIZpwFwhOoOp7-U_khD76w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BB96EC1A1;
        Mon, 22 Jun 2020 15:15:40 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-26.phx2.redhat.com [10.3.112.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5A071084430;
        Mon, 22 Jun 2020 15:15:39 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.5.1 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <65c79b6d-3300-7bad-c055-e492ae1a28d4@RedHat.com>
Date:   Mon, 22 Jun 2020 11:15:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

There is a new command as added 'nfsdclnts' that
shows client info on the Linux server. 

clddb-tool was renamed to nfsdclddb

A number of memory leaks were plugged up.

Add support for SASL binds

As well as a number of bug fixes.  

The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.1/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.1

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.1/2.5.1-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.1/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

