Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A633C6384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhGLTUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:20:15 -0400
Received: from mail.bix.bg ([193.105.196.21]:39353 "HELO mail.bix.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S233183AbhGLTUO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:20:14 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jul 2021 15:20:13 EDT
Received: (qmail 18929 invoked from network); 12 Jul 2021 19:10:43 -0000
Received: from d2.declera.com (212.116.131.122)
  by indigo.declera.com with SMTP; 12 Jul 2021 19:10:43 -0000
Message-ID: <9e3b381a04fd7f7dfbf5e2395d127ab4ef554f99.camel@declera.com>
Subject: [5.14-rc1 regression] 7fe1e79b59ba configfs: implement the
 .read_iter and .write_iter methods - affects targetcli restore
From:   Yanko Kaneti <yaneti@declera.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 12 Jul 2021 22:10:54 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 (3.41.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, 

Bisected a problem that I have with targetcli restore to:

7fe1e79b59ba configfs: implement the .read_iter and .write_iter methods

With it reads of /sys/kernel/config/target/dbroot  go on infinitely,
returning  the config value over and over again.

e.g.

$ modprobe target_core_user
$ head -n 2 /sys/kernel/config/target/dbroot 
/etc/target
/etc/target

Don't know if that's a problem with the commit or the target code, but
could perhaps be affecting other places.

- Yanko
