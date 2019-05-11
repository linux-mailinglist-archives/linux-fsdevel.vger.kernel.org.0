Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6021A7CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 14:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfEKM3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 08:29:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfEKM3w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 08:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B792C3082E5F;
        Sat, 11 May 2019 12:29:52 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-27.phx2.redhat.com [10.3.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FDB75D705;
        Sat, 11 May 2019 12:29:52 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.3.4 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <5ac3b3b1-82a4-9438-9d4f-9239ce210c69@RedHat.com>
Date:   Sat, 11 May 2019 08:29:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 11 May 2019 12:29:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

nfs-utils-2.3.4 has just been released.

Some of the highlights:

* Tighten up some memory leaks
* Added back nfsdcld, the v4 client tracking daemon
* Major work on the nfs.conf configuration code. 
* Finished the junction support
* A boat load of bug fixes and tweaks. 

The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.3.4/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.3.4

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.3.4/2.3.4-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.3.4/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.
