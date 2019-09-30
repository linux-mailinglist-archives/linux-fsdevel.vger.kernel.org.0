Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABBC1C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfI3Hgb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 03:36:31 -0400
Received: from albireo.enyo.de ([37.24.231.21]:47414 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfI3Hgb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:36:31 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 03:36:30 EDT
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iEq8t-00006v-36; Mon, 30 Sep 2019 07:30:47 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iEq6d-0000Sy-Fv; Mon, 30 Sep 2019 09:28:27 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: xfs_inode not reclaimed/memory leak on 5.2.16
Date:   Mon, 30 Sep 2019 09:28:27 +0200
Message-ID: <87pnji8cpw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simply running “du -hc” on a large directory tree causes du to be
killed because of kernel paging request failure in the XFS code.

I ran slabtop, and it showed tons of xfs_inode objects.

The system was rather unhappy after that, so I wasn't able to capture
much more information.

Is this a known issue on Linux 5.2?  I don't see it with kernel
5.0.20.  Those are plain upstream kernels built for x86-64, with no
unusual config options (that I know of).
