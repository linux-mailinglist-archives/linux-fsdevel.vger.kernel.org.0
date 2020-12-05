Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF22CF9C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 06:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgLEFgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 00:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgLEFgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:36:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A34C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Dec 2020 21:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qSvWs62zZREgbQ+gH3A6czOPLsjnhtZlVVJVJ+m6hPI=; b=tihiOVQ+S+qZMlAulRRZ719AJv
        N/+o0NNx96FwRY9eWe+Qh2FbqrnkFUr2VloSKXeLY+lqjNifAaQS4D/TK9h6b9W1RFW+iNcKfWugB
        7RkxlzXJhApraASKzPq42s8ZNxJLfQtXmFLqTns00Ch7ni8wiYo9cFYOPQqW41/ApeMfQC6yUtn2D
        6ue4+u7dKltanbP+D7WAPS/rHY0alydaheM4wmotOrbnsB9QL5py6afbpUd4M83I5PhQfztt2ufgC
        LTMEywGBdAp0NZQ2Fn446hia5e2+ou08YeeK+UJKc7mkS5BNLBWPrTT9+wIVbhM07/RCLEfEFR8cO
        Z/OtsA5A==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klQEd-0007Kw-FP; Sat, 05 Dec 2020 05:35:55 +0000
To:     David Howells <dhowells@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: AFS documentation
Message-ID: <f77d3d67-ea63-4cce-fa6f-2977db078b74@infradead.org>
Date:   Fri, 4 Dec 2020 21:35:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

I was browsing Documentation/filesystems/afs.rst and fs/afs/super.c
and had a few questions/comments.

1.  afs.rst says:

<<<
When inserting the driver modules the root cell must be specified along with a
list of volume location server IP addresses::

	modprobe rxrpc
	modprobe kafs rootcell=cambridge.redhat.com:172.16.18.73:172.16.18.91

The first module is the AF_RXRPC network protocol driver.  This provides the
RxRPC remote operation protocol and may also be accessed from userspace.  See:

	Documentation/networking/rxrpc.rst

The second module is the kerberos RxRPC security driver, and the third module
is the actual filesystem driver for the AFS filesystem.
>>>

so that above mentions 3 modules but only lists (modprobes) 2 of them.
Or am I missing something?


2.  fs/afs/super.c seems to be willing to parse "source=" (Opt_source).

Can you tell me the format & meaning of that mount option?
and maybe even add it to the doc. file?



thanks.
-- 
~Randy

