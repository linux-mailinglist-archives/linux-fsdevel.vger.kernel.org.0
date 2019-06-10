Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A393BB83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbfFJSBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 14:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388052AbfFJSBo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:01:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60601308212A;
        Mon, 10 Jun 2019 18:01:44 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-232.phx2.redhat.com [10.3.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1697C60BF1;
        Mon, 10 Jun 2019 18:01:43 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.4.1 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <feeae3ff-7985-7ad7-386e-d30d0a0a3ade@RedHat.com>
Date:   Mon, 10 Jun 2019 14:01:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 10 Jun 2019 18:01:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I decided to make another release to address some
issues that were found with mountd in prior release.

The new rootdir nfs.conf configuration is include
as well as fixing some minor compile issues. 

The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.4.1/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.4.1

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.4.1/2.4.1-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.4.1/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.
