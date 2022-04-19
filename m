Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAC507002
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbiDSOVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349391AbiDSOVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:21:42 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509918E12
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 07:18:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 88CA2C00E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 16:18:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id mYN1Iko7_Kvw for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 16:18:48 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 6984EC00CB
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 16:18:48 +0200 (CEST)
Received: (qmail 20027 invoked from network); 19 Apr 2022 20:08:47 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 19 Apr 2022 20:08:47 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 40ACB460E9C; Tue, 19 Apr 2022 16:18:48 +0200 (CEST)
Date:   Tue, 19 Apr 2022 16:18:48 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <454834.1650373340@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454834.1650373340@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/19 15:02, David Howells <dhowells@redhat.com> wrote:
> I presume you are actually using a cache?

Yes, see:

On 2022/04/12 17:10, Max Kellermann <max@rabbit.intern.cm-ag> wrote:
> All web servers mount a storage via NFSv3 with fscache.

At least one web server is still in this broken state right now.  So
if you need anything from that server, tell me, and I'll get it.

I will need to downgrade to 5.16 tomorrow to get rid of the corruption
bug (I've delayed this for a week, waiting for your reply).  After
tomorrow, I can no longer help debugging this.

Max
